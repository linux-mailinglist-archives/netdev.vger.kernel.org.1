Return-Path: <netdev+bounces-80843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A78813FB
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 16:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307E61F24990
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A009540866;
	Wed, 20 Mar 2024 15:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.knielsen-hq.org (mail.knielsen-hq.org [93.95.228.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE1482DB
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.95.228.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946805; cv=none; b=LpkYQyzQrCTHo+9qa56kgh6ZRUmPla+Z333olmY2zA3BAaqho7sXysbGD+h2c+GI0zKuw0R77jeC3kuaoJZNS9L1Oekvj8o2ZjMwW/rymUBRbnO1ipzfrbsDD54Lm+UNQ9mEe0D7z206UNqycPzvA7elQU37rs4lq8YZnByZNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946805; c=relaxed/simple;
	bh=PHVnMfQJeQLbsPSXmPH7hNPoiUoP9y7ZMZbGRwt9ECc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bXUxg/6CrdNEm5RMOyylepJLDrJ3FX/O3sWawsihtjaT8EFHeC/T0/Z1Bbl+Wa6m8Rf036XR71rXSdix3wNHb5guHIxwBZgzetqUITDmsCptrSSCiiokCkHedFcIE0CFt/hQsJWTgKT3pQmWDgg7ILPc+G+z59oahlPOw9CkLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knielsen-hq.org; spf=pass smtp.mailfrom=knielsen-hq.org; arc=none smtp.client-ip=93.95.228.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=knielsen-hq.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knielsen-hq.org
Received: from urd-vpn.knielsen-hq.org ([10.75.110.6] helo=urd)
	by mail.knielsen-hq.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <knielsen@knielsen-hq.org>)
	id 1rmxQ7-001X8V-Gr
	for netdev@vger.kernel.org; Wed, 20 Mar 2024 15:59:59 +0100
From: Kristian Nielsen <knielsen@knielsen-hq.org>
To: netdev@vger.kernel.org
Subject: Bug/race between TCP client connect() and kill -9 of server process
Date: Wed, 20 Mar 2024 15:59:58 +0100
Message-ID: <87sf0ldk41.fsf@urd.knielsen-hq.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

I'm seeing a problem where a client process does a TCP connect(2) at the
same time that a SIGKILL is sent to the process doing listen(2).
Occasionally, seemingly depending on some exact timing/race, the connect()
will succeed, but the client is never notified that the server closed the
connection (no FIN/RST packet), and a poll()/select() in the client waits
indefinitely.

The behaviour is as if the code that handles process kill first walks the
list of existing connections (inclusive listen(2) backlog) and sends FIN to
the client. Then it shuts down the listening socket, after which SYN will be
replied with RST. But leaving a small time window in-between where new
connections are still acknowledged with SYN/ACK, but no longer shut down by
FIN nor RST.

This is all on 127.0.0.1 loopback, so no network/packet loss issues involved.

$ uname -a
Linux urd 5.10.0-8-amd64 #1 SMP Debian 5.10.46-5 (2021-09-23) x86_64 GNU/Linux

Also reproduced on several other kernel versions and on RiscV.

Attached is a perl script that reproduces the problem, also available here:

  https://knielsen-hq.org/test_listen_backlog_on_server_kill.pl

The script repeatedly forks a server process, establishes some connections,
does kill -9 of the server, tries to re-connect at the same time, and tests
whether the reconnect is handled correctly (either refused, or notified of
close). For me, usually the problem occurs within a few 100 iterations.

Here is an example output where it triggers the error and corresponding
tcpdump output:

-----------------------------------------------------------------------
AHA! select() on extra connection timed out on iteration 67!
Extra connection fd=19 port=59404

14:49:55.066435 lo    In  IP localhost.59404 > localhost.2345: Flags [S], seq 4284834695, win 65495, options [mss 65495,sackOK,TS val 152268719 ecr 0,nop,wscale 7], length 0
14:49:55.066465 lo    In  IP localhost.2345 > localhost.59404: Flags [S.], seq 3024130858, ack 4284834696, win 65483, options [mss 65495,sackOK,TS val 152268719 ecr 152268719,nop,wscale 7], length 0
14:49:55.066491 lo    In  IP localhost.59404 > localhost.2345: Flags [.], ack 1, win 512, options [nop,nop,TS val 152268719 ecr 152268719], length 0
14:50:05.077150 lo    In  IP localhost.59404 > localhost.2345: Flags [F.], seq 1, ack 1, win 512, options [nop,nop,TS val 152278730 ecr 152268719], length 0
14:50:05.077183 lo    In  IP localhost.2345 > localhost.59404: Flags [R], seq 3024130859, win 0, length 0
-----------------------------------------------------------------------

We see the connection being established with SYN/ACK, but no FIN is sent
when the server process exits. And only 10 seconds later, when the script
times out the poll()/select() does the client send FIN, which is replied
with RST as there is no listening socket on port 2345.

Occasionally another behaviour is seen, the client's initial SYN packet is
not replied, causing client retransmission (which is then replied with RST):

-----------------------------------------------------------------------
Oops, connect() took 1.008663 seconds! (connect=No)

14:57:19.389914 lo    In  IP localhost.43856 > localhost.2345: Flags [S], seq 2851822367, win 65495, options [mss 65495,sackOK,TS val 152713043 ecr 0,nop,wscale 7], length 0
14:57:20.398363 lo    In  IP localhost.43856 > localhost.2345: Flags [S], seq 2851822367, win 65495, options [mss 65495,sackOK,TS val 152714051 ecr 0,nop,wscale 7], length 0
14:57:20.398415 lo    In  IP localhost.2345 > localhost.43856: Flags [R.], seq 0, ack 2851822368, win 0, length 0
-----------------------------------------------------------------------

A practical consequence of this bug is that if a server dies, a client may
seemingly re-establish its connection successfully and think that it is
again connected to the (restarted) server and wait for data. But in reality
the client's connection is dead, and the client can wait indefinitely for
data on the socket or EOF/close notification.

This problem originates from the testsuite / continuous integration of
MariaDB, a relational database. The testsuite is testing the correctness of
various scenarios of the server process crashing. These tests very
occasionally fail due to a timeout on the re-established server connection,
which is due to this bug. Original MariaDB bug for reference:

  https://jira.mariadb.org/browse/MDEV-30232

Any ideas? Is this a known issue?

 - Kristian.


--=-=-=
Content-Type: text/x-perl
Content-Disposition: inline; filename=test_listen_backlog_on_server_kill.pl
Content-Description: Script to reproduce the problem

#! /usr/bin/perl

use strict;
use warnings;

use Socket;
use Time::HiRes qw(gettimeofday tv_interval);

my $verbose = undef;
# The number of connections seems to affect the chance of hitting
# the race. So might need tuning on different machines.
my $num_connected = 20;
my $port = 2345;
my $proto = getprotobyname("tcp");
my $remote = "127.0.0.1";
my $iaddr   = inet_aton($remote)       || die "no host: $remote";
my $paddr   = sockaddr_in($port, $iaddr);

print <<END;
This script tries to demonstrate a race/bug between TCP connect() in a client
process and SIGKILL on the server process. When the timing is just right, the
connect() can succeed while the killed process is closing existing connections,
but the resulting extra connection does not get any notification that it has
been closed on the server, so poll()/select() on the client hangs indefinitely.

Occasionally we also observe that the extra connect() completes only after
(almost) exactly 1 second, after which it returns failure to connect.

END
for (my $i = 1; ; ++$i) {
  print "Iteration: $i\n"
      if (($i % 100) == 0);
  test(1 + int(rand($num_connected)), $i);
  select(undef, undef, undef, 0.01);
}


sub test {
  my ($N, $iter) = @_;

  # Spawn a server process.
  my $pid = open(my $child, '-|');
  die unless defined($pid);
  if (!$pid) {
    server($N);
    exit(0);  # NOTREACHED
  }

  # Wait for the server process to setup the listening socket.
  sysread($child, my $dummy, 1);

  my $socks = [];
  my $rin = my $win = my $ein = '';
  for my $i (1..$N) {
    socket($socks->[$i], PF_INET, SOCK_STREAM, $proto)
        or die "socket: $!";
    connect($socks->[$i], $paddr)
        or die "connect: $!";
    vec($rin, fileno($socks->[$i]), 1) = 1;
    sysread($socks->[$i], my $dummy2, 1);
    #print "Connected! sock=", fileno($socks->[$i]), "\n";
  }
  $ein = $rin;
  print "select() vector: ", unpack('H*', $rin), "\n"
      if $verbose;

  socket(my $extra_sock, PF_INET, SOCK_STREAM, $proto) or die "extra_sock: $!";

  # Wait for the server to die, which causes connection sockets to close and notify us.
  my $t0 = [gettimeofday];
  my $res = select(my $rout = $rin, my $wout = $win, my $eout = $ein, undef);
  # Try to get in an extra connection while the server process is still getting
  # killed. This is the connection that can show the race/bug, where the
  # connection gets established, but there is never any notification that
  # the connection was closed at the other end.
  my $t1 = [gettimeofday];
  my $res2 = connect($extra_sock, $paddr);
  my $t2 = [gettimeofday];
  print "select() returns: $res out=", unpack('H*', $rout), " err=", unpack('H*', $eout), "\n"
      if $verbose;
  my $elapsed1 = tv_interval($t0, $t1);
  my $elapsed2 = tv_interval($t1, $t2);
  print "Oops, select() took $elapsed1 seconds! (found=$res)\n"
      if $elapsed1 > 0.5;
  # Curiously, the extra connection sometimes takes almost exactly 1 second
  # to fail.
  print "Oops, connect() took $elapsed2 seconds! (connect=", ($res2 ? 'Yes' : 'No'), ")\n"
      if $elapsed2 > 0.5;
  if ($res2) {
    print "Oh! Got an extra connection: fd=", fileno($extra_sock), "\n";
    my $rin2 = my $win2 = my $ein2 = '';
    vec($rin2, fileno($extra_sock), 1) = 1;
    $ein2 = $rin2;
    my $res3 = select(my $rout2 = $rin2, my $wout2 = $win2, my $eout2 = $ein2, 10);
    print "extra select() returns: $res3 out=",
            unpack('H*', $rout2), " err=", unpack('H*', $eout2), "\n"
        if $verbose;
    if (!$res3) {
      print STDERR "AHA! select() on extra connection timed out on iteration $iter!\n";
      my ($extra_port, $extra_host) = sockaddr_in(getsockname($extra_sock));
      print STDERR "Extra connection fd=", fileno($extra_sock),
          " port=", $extra_port, "\n";
      exit(1);
    }
  } else {
    print "Bummer, no extra connection this time...\n"
        if $verbose;
  }

  close $child;
  close $socks->[$_] for (1..$N);
  close $extra_sock;
}

# Server.
sub server {
  my ($N) = @_;
  socket(my $server, PF_INET, SOCK_STREAM, $proto) || die "socket: $!";
  setsockopt($server, SOL_SOCKET, SO_REUSEADDR, pack("l", 1))
                                                || die "setsockopt: $!";
  bind($server, sockaddr_in($port, INADDR_ANY)) || die "bind: $!";
  listen($server, SOMAXCONN)                    || die "listen: $!";

  # Signal parent that socket is ready!
  syswrite(STDOUT, '.', 1);

  # First accept a bunch of connections.
  my $clis = [];
  for my $i (1..$N) {
    my $res = accept($clis->[$i], $server);
    die unless $res;
    syswrite($clis->[$i], '!', 1) or die;
  }
  # Then SIGKILL ourselves, see if we can trigger a client managing to get a
  # connection in during the close-of-sockets.
  select(undef, undef, undef, 0.02);
  print STDERR "SIGKILL self\n"
      if $verbose;
  kill 9, $$;
  sleep(10) while (1);
}

--=-=-=--

