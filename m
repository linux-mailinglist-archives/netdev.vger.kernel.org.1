Return-Path: <netdev+bounces-195505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3EEAD09FE
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 00:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B763A4FE1
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 22:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DDE21767B;
	Fri,  6 Jun 2025 22:34:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2581E2853
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.205.220.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749249297; cv=none; b=liN4jOqm54Cg3Ycmi23ZvEJ7leUdDktZFJfz6X3cSJTdN2CDOMex07H2qMS3IV1lgHpXTZdc1UjNrFPhn7UwxvhPQaBXysp57cVj4WzbHX3ZHM7XhkW0XwfEnTGwSgloJuqOr1wxTzMxOVU6eOo3cNygzsh5RUp2EoIonjFY+DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749249297; c=relaxed/simple;
	bh=Oq3XeXxVDeW7uBRWcbbkfugTGYNtNExrgFAfxx25tGc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZbGYaUpPpxHzURRFBVy2EK+8VYcSI8LWu8I+J9DCHNSGSXJJWqqTtbBNnefogi/1I5GVuH55ZY9vT3pQQgDgIIWWAwwLpF/E8O5z+wBbqNx57x7ei0qh9Ylwk3o/jVtsnGRQpRd4CwpUQt4gEKMw3cTZ+2hWPwdpfUVgaTkNCk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net; spf=none smtp.mailfrom=lists.ewheeler.net; arc=none smtp.client-ip=173.205.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.ewheeler.net
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 2CAAF89;
	Fri,  6 Jun 2025 15:34:55 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xqRyo2X8pWNS; Fri,  6 Jun 2025 15:34:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id BF88141;
	Fri,  6 Jun 2025 15:34:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net BF88141
Date: Fri, 6 Jun 2025 15:34:53 -0700 (PDT)
From: Eric Wheeler <netdev@lists.ewheeler.net>
To: Neal Cardwell <ncardwell@google.com>
cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
    Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
    Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
    stable@kernel.org
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
In-Reply-To: <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com>
Message-ID: <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net>
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net> <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1767548671-1749249293=:21862"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1767548671-1749249293=:21862
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 6 Jun 2025, Neal Cardwell wrote:
> On Thu, Jun 5, 2025 at 9:33 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> >
> > Hello Neal,
> >
> > After upgrading to Linux v6.6.85 on an older Supermicro SYS-2026T-6RFT+
> > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS728TXS at
> > 10GbE via one SFP+ DAC (no bonding), we found TCP performance with
> > existing devices on 1Gbit ports was <60Mbit; however, TCP with devices
> > across the switch on 10Gbit ports runs at full 10GbE.
> >
> > Interestingly, the problem only presents itself when transmitting
> > from Linux; receive traffic (to Linux) performs just fine:
> >         ~60Mbit: Linux v6.6.85 =TX=> 10GbE -> switch -> 1GbE  -> device
> >          ~1Gbit: device        =TX=>  1GbE -> switch -> 10GbE -> Linux v6.6.85
> >
> > Through bisection, we found this first-bad commit:
> >
> >         tcp: fix to allow timestamp undo if no retransmits were sent
> >                 upstream:       e37ab7373696e650d3b6262a5b882aadad69bb9e
> >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f
> >
> 
> Thank you for your detailed report and your offer to run some more tests!
> 
> I don't have any good theories yet. It is striking that the apparent
> retransmit rate is more than 100x higher in your "Before Revert" case
> than in your "After Revert" case. It seems like something very odd is
> going on. :-)

good point, I wonder what that might imply...

> If you could re-run tests while gathering more information, and share
> that information, that would be very useful.
> 
> What would be very useful would be the following information, for both
> (a) Before Revert, and (b) After Revert kernels:
> 
> # as root, before the test starts, start instrumentation
> # and leave it running in the background; something like:
> (while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tmp/ss.txt &
> nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done)  >
> /tmp/nstat.txt &
> tcpdump -w /tmp/tcpdump.${eth}.pcap -n -s 116 -c 1000000  &
> 
> # then run the test
> 
> # then kill the instrumentation loops running in the background:
> kill %1 %2 %3

Sure, here they are:

	https://www.linuxglobal.com/out/for-neal/

These are the commands that we ran.  You will probably notice that it is
running under a bridge, but the behavior is the same whether or not it
is enslaved to a bridge. (The way that these systems are configured it is
quite difficult to mess with the bridge so I would like to keep it as it
is for testing if possible.)

# Before Revert

	WHEN=before-revert
	(while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tmp/$WHEN-ss.txt &
	nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done)  > /tmp/$WHEN-nstat.txt &
	tcpdump -i br0 -w /tmp/$WHEN-tcpdump.${eth}.pcap -n -s 116 -c 1000000 host 192.168.1.203 &
	iperf3 -c 192.168.1.203
	kill %1 %2 %3

	[1] 1769507
	[2] 1769511
	[3] 1769512
	Connecting to host 192.168.1.203, port 5201
	dropped privs to tcpdump
	tcpdump: listening on br0, link-type EN10MB (Ethernet), snapshot length 116 bytes
	[  5] local 192.168.1.51 port 44674 connected to 192.168.1.203 port 5201
	[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
	[  5]   0.00-1.00   sec   110 MBytes   920 Mbits/sec   28    278 KBytes       
	[  5]   1.00-2.00   sec  3.19 MBytes  26.7 Mbits/sec  260    336 KBytes       
	[  5]   2.00-3.00   sec  3.06 MBytes  25.7 Mbits/sec  862    431 KBytes       
	[  5]   3.00-4.00   sec  3.12 MBytes  26.2 Mbits/sec  1730    462 KBytes       
	[  5]   4.00-5.00   sec  3.25 MBytes  27.2 Mbits/sec  1490    443 KBytes       
	[  5]   5.00-6.00   sec  3.31 MBytes  27.8 Mbits/sec  1898    543 KBytes       
	[  5]   6.00-7.00   sec  2.45 MBytes  20.5 Mbits/sec  1640    111 KBytes       
	[  5]   7.00-8.00   sec  3.70 MBytes  31.0 Mbits/sec  1868    530 KBytes       
	[  5]   8.00-9.00   sec  3.71 MBytes  31.1 Mbits/sec  2137    539 KBytes       
	[  5]   9.00-10.00  sec  3.75 MBytes  31.5 Mbits/sec  1012    365 KBytes       
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bitrate         Retr
	[  5]   0.00-10.00  sec   139 MBytes   117 Mbits/sec  12925             sender
	[  5]   0.00-10.04  sec   137 MBytes   114 Mbits/sec                  receiver

	iperf Done.
	35180 packets captured
	35607 packets received by filter
	0 packets dropped by kernel
	[root@hv ~]# renice -20 $$
	1760056 (process ID) old priority 0, new priority -20
	[1]   Terminated              ( while true; do
	    date +%s.%N; ss -tenmoi; sleep 0.050;
	done ) > /tmp/$WHEN-ss.txt
	[2]-  Terminated              ( while true; do
	    date +%s.%N; nstat; sleep 0.050;
	done ) > /tmp/$WHEN-nstat.txt
	[3]+  Done                    tcpdump -i br0 -w /tmp/$WHEN-tcpdump.${eth}.pcap -n -s 116 -c 1000000 host 192.168.1.203
	[root@hv ~]# tar cvzf $WHEN.tar.gz /tmp/$WHEN*


# After Revert

	eth=br0
	WHEN=after-revert
	(while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tmp/$WHEN-ss.txt &
	nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done)  > /tmp/$WHEN-nstat.txt &
	tcpdump -i br0 -w /tmp/$WHEN-tcpdump.${eth}.pcap -n -s 116 -c 1000000 host 192.168.1.203 &
	iperf3 -c 192.168.1.203
	kill %1 %2 %3

	[1] 1471593
	[2] 1471597
	[3] 1471598
	Connecting to host 192.168.1.203, port 5201
	dropped privs to tcpdump
	tcpdump: listening on br0, link-type EN10MB (Ethernet), snapshot length 116 bytes
	[  5] local 192.168.1.52 port 41240 connected to 192.168.1.203 port 5201
	[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
	[  5]   0.00-1.00   sec   113 MBytes   948 Mbits/sec   12    282 KBytes       
	[  5]   1.00-2.00   sec  90.5 MBytes   759 Mbits/sec   73    288 KBytes       
	[  5]   2.00-3.00   sec   114 MBytes   952 Mbits/sec    4    287 KBytes       
	[  5]   3.00-4.00   sec  89.9 MBytes   754 Mbits/sec   56    298 KBytes       
	[  5]   4.00-5.00   sec   113 MBytes   945 Mbits/sec   26    247 KBytes       
	[  5]   5.00-6.00   sec   113 MBytes   946 Mbits/sec    4    261 KBytes       
	[  5]   6.00-7.00   sec   113 MBytes   947 Mbits/sec    8    267 KBytes       
	[  5]   7.00-8.00   sec  89.4 MBytes   750 Mbits/sec   74    318 KBytes       
	[  5]   8.00-9.00   sec  89.7 MBytes   752 Mbits/sec   83    269 KBytes       
	[  5]   9.00-10.00  sec  90.2 MBytes   757 Mbits/sec  110    315 KBytes       
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bitrate         Retr
	[  5]   0.00-10.00  sec  1014 MBytes   851 Mbits/sec  450             sender
	[  5]   0.00-10.04  sec  1013 MBytes   846 Mbits/sec                  receiver

	iperf Done.
	131027 packets captured
	131841 packets received by filter
	0 packets dropped by kernel
	[root@hv ~]# tar cvzf after-revert /tmp/before*
	tar: Removing leading `/' from member names
	tar: /tmp/before*: Cannot stat: No such file or directory
	tar: Exiting with failure status due to previous errors
	[1]   Terminated              ( while true; do
	    date +%s.%N; ss -tenmoi; sleep 0.050;
	done ) > /tmp/$WHEN-ss.txt
	[2]-  Terminated              ( while true; do
	    date +%s.%N; nstat; sleep 0.050;
	done ) > /tmp/$WHEN-nstat.txt
	[3]+  Done                    tcpdump -i br0 -w /tmp/$WHEN-tcpdump.${eth}.pcap -n -s 116 -c 1000000 host 192.168.1.203
	[root@hv ~]# tar cvzf $WHEN.tar.gz /tmp/$WHEN*


-Eric

> Then if you could copy the iperf output and these output files to a
> web server, or Dropbox, or Google Drive, etc, and share the URL, I
> would be very grateful.
> 
> For this next phase, there's no need to test both 6.6 and 6.15.
> Testing either one is fine. We just need, say, 6.15 before the revert,
> and 6.15 after the revert.
> 
> Thanks!
> neal
> 
--8323328-1767548671-1749249293=:21862--

