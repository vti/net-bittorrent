package t::10000_by_class::Net::BitTorrent::Torrent::Generator;
{
    use strict;
    use warnings;
    use 5.010.000;
    use Test::Most;
    use lib '../', '../../../../../', '../../../../../lib', 'lib';
    use Net::BitTorrent::Torrent::Generator;
    use parent 'Test::Class';
    $|++;

    # Basic utility functions/methods
    sub info_hash {'87411D31D8EEE096DE8E3F2E975FF789748DEFC5'}
    sub files     {'./t/90000_data/96000_data/96020_miniswarm_seed/'}

    sub new_args {
        my $s = shift;
        -e $s->files ? last : chdir '..' for 0 .. 15;
        (files => $s->files);
    }

    sub startup : Test( startup => 1 ) {
        my $s = shift;
        $s->{'torrent'} = new_ok 'Net::BitTorrent::Torrent::Generator',
            [$s->new_args];
        explain 'New metadata looks like...', $s->{'torrent'};
    }

    sub _000_info_hash : Test( 1 ) {
        my $s = shift;
        is $s->{'torrent'}->info_hash->to_Hex, $s->info_hash,
            'generated info_hash';
        explain 'Metadata now looks like...', $s->{'torrent'};
    }

    sub _001_comment : Test( 4 ) {
        my $s = shift;
        is $s->{'torrent'}->comment, undef, 'default comment is undef';
        ok !$s->{'torrent'}->_has_comment, '_has_comment is false';
        ok $s->{'torrent'}->_set_comment('See credit.txt for attributions.'),
            '_set_comment( ... )';
        is $s->{'torrent'}->comment, 'See credit.txt for attributions.',
            'comment is correct';
    }

    #
    #$ENV{'TEST_VERBOSE'}++;
    __PACKAGE__->runtests() if !caller;
}
1;

=pod

=head1 Author

Sanko Robinson <sanko@cpan.org> - http://sankorobinson.com/

CPAN ID: SANKO

=head1 License and Legal

Copyright (C) 2008-2010 by Sanko Robinson <sanko@cpan.org>

This program is free software; you can redistribute it and/or modify it under
the terms of
L<The Artistic License 2.0|http://www.perlfoundation.org/artistic_license_2_0>.
See the F<LICENSE> file included with this distribution or
L<notes on the Artistic License 2.0|http://www.perlfoundation.org/artistic_2_0_notes>
for clarification.

When separated from the distribution, all original POD documentation is
covered by the
L<Creative Commons Attribution-Share Alike 3.0 License|http://creativecommons.org/licenses/by-sa/3.0/us/legalcode>.
See the
L<clarification of the CCA-SA3.0|http://creativecommons.org/licenses/by-sa/3.0/us/>.

Neither this module nor the L<Author|/Author> is affiliated with BitTorrent,
Inc.

=for rcs $Id$

=cut