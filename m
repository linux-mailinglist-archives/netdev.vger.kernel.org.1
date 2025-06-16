Return-Path: <netdev+bounces-198218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE930ADBAA8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 22:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63735174A76
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 20:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8926A288C13;
	Mon, 16 Jun 2025 20:14:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9102BEFF0
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.205.220.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750104870; cv=none; b=OAJeUM0p9Yhlhb+cdKnBLmB5v99rLwuU90HuWtdK6YZBVf8PegGgVVXvVYyabhQI29RdVPjDLon1xOuhRwczOQos8HdEh0GTdKSzP7LSvgEXOAcrFda41lwx2hwBII0VkbVHC+geFhZUo2y+1aHvftrrO79bKFmIE8Zl8y/PYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750104870; c=relaxed/simple;
	bh=V9e+eLsV51hESvlS9FPGF9+JtzTpMCVKCdPxLku5XQ0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CWaJDnrXOXy+AGbAAncx0cLpy7J+jovW/NW43RLWMCkkSFSmDWHkm+6TfO7ImW1wz/Nwudikd4FNWRDn2uMnA6/DHTfXrY4ij4fHrBhyvr8RzUcN3kPEyu9pvL0HiaW2xpCexpaHHrzy7KHjb+9+bxN1D0CEKWdgOXAzP5jzEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net; spf=none smtp.mailfrom=lists.ewheeler.net; arc=none smtp.client-ip=173.205.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.ewheeler.net
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id E73308A;
	Mon, 16 Jun 2025 13:14:21 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HmQgDA-inrHY; Mon, 16 Jun 2025 13:14:20 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 5100045;
	Mon, 16 Jun 2025 13:14:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 5100045
Date: Mon, 16 Jun 2025 13:13:59 -0700 (PDT)
From: Eric Wheeler <netdev@lists.ewheeler.net>
To: Neal Cardwell <ncardwell@google.com>
cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
    Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
    Sasha Levin <sashal@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
    stable@kernel.org
Subject: Re: [BISECT] regression: tcp: fix to allow timestamp undo if no
 retransmits were sent
In-Reply-To: <9ef3bfe-01f-29da-6d5-1baf2fad7254@ewheeler.net>
Message-ID: <a8579544-a9de-63ae-61ed-283c872289a@ewheeler.net>
References: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net> <CADVnQykCiDvzqgGU5NO9744V2P+umCdDQjduDWV0-xeLE0ey0Q@mail.gmail.com> <d7421eff-7e61-16ec-e1ca-e969b267f44d@ewheeler.net> <CADVnQy=SLM6vyWr5-UGg6TFU+b0g4s=A0h2ujRpphTyuxDYXKA@mail.gmail.com>
 <CADVnQy=kB-B-9rAOgSjBAh+KHx4pkz-VoTnBZ0ye+Fp4hjicPA@mail.gmail.com> <CADVnQyna9cMvJf9Mp5jLR1vryAY1rEbAjZC_ef=Q8HRM4tNFzQ@mail.gmail.com> <CADVnQyk0bsGJrcA13xEaDmVo_6S94FuK68T0_iiTLyAKoVVPyA@mail.gmail.com> <CADVnQyktk+XpvLuc6jZa5CpqoGyjzzzYJ5iJk3=Eh5JAGyNyVQ@mail.gmail.com>
 <9ef3bfe-01f-29da-6d5-1baf2fad7254@ewheeler.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1713979476-1750104860=:30465"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1713979476-1750104860=:30465
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sun, 15 Jun 2025, Eric Wheeler wrote:
> On Tue, 10 Jun 2025, Neal Cardwell wrote:
> > On Mon, Jun 9, 2025 at 1:45 PM Neal Cardwell <ncardwell@google.com> wrote:
> > >
> > > On Sat, Jun 7, 2025 at 7:26 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > >
> > > > On Sat, Jun 7, 2025 at 6:54 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > >
> > > > > On Sat, Jun 7, 2025 at 3:13 PM Neal Cardwell <ncardwell@google.com> wrote:
> > > > > >
> > > > > > On Fri, Jun 6, 2025 at 6:34 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> > > > > > >
> > > > > > > On Fri, 6 Jun 2025, Neal Cardwell wrote:
> > > > > > > > On Thu, Jun 5, 2025 at 9:33 PM Eric Wheeler <netdev@lists.ewheeler.net> wrote:
> > > > > > > > >
> > > > > > > > > Hello Neal,
> > > > > > > > >
> > > > > > > > > After upgrading to Linux v6.6.85 on an older Supermicro SYS-2026T-6RFT+
> > > > > > > > > with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS728TXS at
> > > > > > > > > 10GbE via one SFP+ DAC (no bonding), we found TCP performance with
> > > > > > > > > existing devices on 1Gbit ports was <60Mbit; however, TCP with devices
> > > > > > > > > across the switch on 10Gbit ports runs at full 10GbE.
> > > > > > > > >
> > > > > > > > > Interestingly, the problem only presents itself when transmitting
> > > > > > > > > from Linux; receive traffic (to Linux) performs just fine:
> > > > > > > > >         ~60Mbit: Linux v6.6.85 =TX=> 10GbE -> switch -> 1GbE  -> device
> > > > > > > > >          ~1Gbit: device        =TX=>  1GbE -> switch -> 10GbE -> Linux v6.6.85
> > > > > > > > >
> > > > > > > > > Through bisection, we found this first-bad commit:
> > > > > > > > >
> > > > > > > > >         tcp: fix to allow timestamp undo if no retransmits were sent
> > > > > > > > >                 upstream:       e37ab7373696e650d3b6262a5b882aadad69bb9e
> > > > > > > > >                 stable 6.6.y:   e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f
> > 
> 
> > The attached patch should apply (with "git am") for any recent kernel
> > that has the "tcp: fix to allow timestamp undo if no retransmits were
> > sent" patch it is fixing. So you should be able to test it on top of
> > the 6.6 stable or 6.15 stable kernels you used earlier. Whichever is
> > easier.

Definitely better, but performance is ~15% slower vs reverting, and the
retransmit counts are still higher than the other.  In the two sections
below you can see the difference between after the fix and after the
revert.  

Here is the output:

## After fixing with your patch:
	https://www.linuxglobal.com/out/for-neal/after-fix.tar.gz

	WHEN=after-fix
	(while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tmp/$WHEN-ss.txt &
	nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done)  > /tmp/$WHEN-nstat.txt &
	tcpdump -i br0 -w /tmp/$WHEN-tcpdump.${eth}.pcap -n -s 116 -c 1000000 host 192.168.1.203 &
	iperf3 -c 192.168.1.203
	kill %1 %2 %3

	[1] 2300
	nstat: history is aged out, resetting
	[2] 2304
	[3] 2305
	Connecting to host 192.168.1.203, port 5201
	[  5] local 192.168.1.52 port 47730 connected to 192.168.1.203 port 5201
	dropped privs to tcpdump
	tcpdump: listening on br0, link-type EN10MB (Ethernet), snapshot length 116 bytes
	[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
	[  5]   0.00-1.00   sec   115 MBytes   963 Mbits/sec   21    334 KBytes       
	[  5]   1.00-2.00   sec   113 MBytes   949 Mbits/sec    3    325 KBytes       
	[  5]   2.00-3.00   sec  41.8 MBytes   350 Mbits/sec  216   5.70 KBytes       
	[  5]   3.00-4.00   sec   113 MBytes   952 Mbits/sec   77    234 KBytes       
	[  5]   4.00-5.00   sec   110 MBytes   927 Mbits/sec    5    281 KBytes       
	[  5]   5.00-6.00   sec  69.5 MBytes   583 Mbits/sec  129    336 KBytes       
	[  5]   6.00-7.00   sec  66.8 MBytes   561 Mbits/sec  234    302 KBytes       
	[  5]   7.00-8.00   sec   113 MBytes   949 Mbits/sec    8    312 KBytes       
	[  5]   8.00-9.00   sec  89.9 MBytes   754 Mbits/sec   72    247 KBytes       
	[  5]   9.00-10.00  sec   113 MBytes   949 Mbits/sec    6    235 KBytes       
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bitrate         Retr
	[  5]   0.00-10.00  sec   946 MBytes   794 Mbits/sec  771               sender <<<
	[  5]   0.00-10.04  sec   944 MBytes   789 Mbits/sec                  receiver <<<

	iperf Done.
	145337 packets captured
	146674 packets received by filter
	0 packets dropped by kernel
	[1]   Terminated              ( while true; do
	    date +%s.%N; ss -tenmoi; sleep 0.050;
	done ) > /tmp/$WHEN-ss.txt
	[root@hv2 ~]# 
	[2]-  Terminated              ( while true; do
	    date +%s.%N; nstat; sleep 0.050;
	done ) > /tmp/$WHEN-nstat.txt
	[3]+  Done                    tcpdump -i br0 -w /tmp/$WHEN-tcpdump.${eth}.pcap -n -s 116 -c 1000000 host 192.168.1.203

## After Revert
	WHEN=after-revert-6.6.93
	(while true; do date +%s.%N; ss -tenmoi; sleep 0.050; done) > /tmp/$WHEN-ss.txt &
	nstat -n; (while true; do date +%s.%N; nstat; sleep 0.050; done)  > /tmp/$WHEN-nstat.txt &
	tcpdump -i br0 -w /tmp/$WHEN-tcpdump.${eth}.pcap -n -s 116 -c 1000000 host 192.168.1.203 &
	iperf3 -c 192.168.1.203
	kill %1 %2 %3
	[1] 2088
	nstat: history is aged out, resetting
	[2] 2092
	[3] 2093
	Connecting to host 192.168.1.203, port 5201
	dropped privs to tcpdump
	tcpdump: listening on br0, link-type EN10MB (Ethernet), snapshot length 116 bytes
	[  5] local 192.168.1.52 port 47256 connected to 192.168.1.203 port 5201
	[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
	[  5]   0.00-1.00   sec   115 MBytes   962 Mbits/sec   13    324 KBytes       
	[  5]   1.00-2.00   sec   114 MBytes   953 Mbits/sec    3    325 KBytes       
	[  5]   2.00-3.00   sec   113 MBytes   947 Mbits/sec    4    321 KBytes       
	[  5]   3.00-4.00   sec   113 MBytes   950 Mbits/sec    3    321 KBytes       
	[  5]   4.00-5.00   sec   113 MBytes   946 Mbits/sec    5    322 KBytes       
	[  5]   5.00-6.00   sec   113 MBytes   950 Mbits/sec    8    321 KBytes       
	[  5]   6.00-7.00   sec   113 MBytes   948 Mbits/sec    5    312 KBytes       
	[  5]   7.00-8.00   sec   113 MBytes   952 Mbits/sec    3    301 KBytes       
	[  5]   8.00-9.00   sec   113 MBytes   945 Mbits/sec    7    301 KBytes       
	[  5]   9.00-10.00  sec   114 MBytes   953 Mbits/sec    4    302 KBytes       
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bitrate         Retr
	[  5]   0.00-10.00  sec  1.11 GBytes   950 Mbits/sec   55             sender
	[  5]   0.00-10.04  sec  1.10 GBytes   945 Mbits/sec                  receiver

	iperf Done.
	[root@hv2 ~]# 189249 packets captured
	189450 packets received by filter
	0 packets dropped by kernel


--
Eric Wheeler
--8323328-1713979476-1750104860=:30465--

