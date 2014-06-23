package Devel::StatProfiler::Reader;
# ABSTRACT: read profiler output

use strict;
use warnings;

require Devel::StatProfiler; # load XS but don't start profiling

package Devel::StatProfiler::StackFrame;

sub file { $_[0]->{file} }
sub line { $_[0]->{line} }

sub package { $_[0]->{package} }
sub sub_name { $_[0]->{sub_name} }
sub fq_sub_name { $_[0]->{fq_sub_name} }
sub uq_sub_name { ($_[0]->{file} || '(unknown)') . ':' . $_[0]->{fq_sub_name} }
sub first_line { $_[0]->{first_line} }
sub kind { $_[0]->{line} == -2 ? 2 :
           $_[0]->{line} == -1 ? 1 : # -1 means "XSUB"
                                 0 }

package Devel::StatProfiler::MainStackFrame;

sub file { $_[0]->{file} }
sub line { $_[0]->{line} }

sub package { '' }
sub sub_name { '' }
sub fq_sub_name { '' }
sub uq_sub_name { $_[0]->{file} . ':main' }
sub kind { 0 }

package Devel::StatProfiler::EvalStackFrame;

our @ISA = qw(Devel::StatProfiler::MainStackFrame);

sub uq_sub_name { $_[0]->{file} . ':eval' }

package Devel::StatProfiler::StackTrace;

sub weight { $_[0]->{weight} }
sub frames { $_[0]->{frames} }
sub op_name { $_[0]->{op_name} }

1;
