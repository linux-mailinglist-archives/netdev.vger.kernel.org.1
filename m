Return-Path: <netdev+bounces-195347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90A1ACFACE
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 03:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638EC178790
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944FA3B1A4;
	Fri,  6 Jun 2025 01:40:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424E2BD1B
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.205.220.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749174027; cv=none; b=YM84YWHftpUe3ZJDhEYBFweISBJ65pobbfwrOEJOdu1tFqSrv3tzJwUEgPJBKIIainX+JNI34EyEzXwh31D7xn2Jh869ged05OUwQknOcQSCQoaORBnJIw3rwIi3+kauX5JsnMiCDBL4+pYFfKpFf/ITs4J1iHFCdvEOc3gSiWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749174027; c=relaxed/simple;
	bh=RKj/pHgqPCeEO3Mc6rJdWlwiIk1w28Z+BFlAsGMtFm0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=N7kNZGHxVmVwsPnH5gj8lSUhQsauNjcUDB8pZWTGXdtXI5WzDD/hzkc1Aos4aBUZG/389tm0uS0jhjtTPdzQX9qxdYn+Ob8+mZHdz/KwrqIvV+XIlxHyo5sjw7jmNZP1nqKCmSLl268+JBXg9D1C62XPmpQqYquuwOaWlC3AsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net; spf=none smtp.mailfrom=lists.ewheeler.net; arc=none smtp.client-ip=173.205.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.ewheeler.net
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id 2C94B45;
	Thu,  5 Jun 2025 18:33:28 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Qn93SjBlnRqq; Thu,  5 Jun 2025 18:33:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 9F02541;
	Thu,  5 Jun 2025 18:33:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 9F02541
Date: Thu, 5 Jun 2025 18:32:46 -0700 (PDT)
From: Eric Wheeler <netdev@lists.ewheeler.net>
To: Neal Cardwell <ncardwell@google.com>
cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
    Geumhwan Yu <geumhwan.yu@samsung.com>, Jakub Kicinski <kuba@kernel.org>, 
    Neal Cardwell <ncardwell@google.com>, Sasha Levin <sashal@kernel.org>, 
    Yuchung Cheng <ycheng@google.com>, stable@kernel.org
Subject: [BISECT] regression: tcp: fix to allow timestamp undo if no retransmits
 were sent
Message-ID: <64ea9333-e7f9-0df-b0f2-8d566143acab@ewheeler.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello Neal,

After upgrading to Linux v6.6.85 on an older Supermicro SYS-2026T-6RFT+
with an Intel 82599ES 10GbE NIC (ixgbe) linked to a Netgear GS728TXS at
10GbE via one SFP+ DAC (no bonding), we found TCP performance with
existing devices on 1Gbit ports was <60Mbit; however, TCP with devices
across the switch on 10Gbit ports runs at full 10GbE.

Interestingly, the problem only presents itself when transmitting 
from Linux; receive traffic (to Linux) performs just fine:
	~60Mbit: Linux v6.6.85 =TX=> 10GbE -> switch -> 1GbE  -> device
	 ~1Gbit: device        =TX=>  1GbE -> switch -> 10GbE -> Linux v6.6.85

Through bisection, we found this first-bad commit:

	tcp: fix to allow timestamp undo if no retransmits were sent
		upstream: 	e37ab7373696e650d3b6262a5b882aadad69bb9e
		stable 6.6.y:	e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f

To validate the regression, we performed the procedures below using the 
latest versions of Linux. As you can see by comparing the performance 
measurements, it is 10-16x faster after reverting. This appears to affect 
everything after ~6.6.12-rc1 when the patch was introduced, as well as any 
stable releases that cherry-picked it. I have pasted the small commit that 
was reverted below for your reference.

Do you understand why it would behave this way, and what the correct fix 
(or possible workaround) would be? 

Currently we are able to reproduce this reliably, please let me know if 
you would like us to gather any additional information.

-Eric

# Testing v6.6.92

## Before Revert
- git checkout v6.6.92
- build, boot, test with `iperf -c <ip>`
	[  5] local 192.168.1.52 port 42886 connected to 192.168.1.203 port 5201
	[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
	[  5]   0.00-1.00   sec  41.5 MBytes   348 Mbits/sec  153    322 KBytes       
	[  5]   1.00-2.00   sec  3.68 MBytes  30.8 Mbits/sec  491    368 KBytes       
	[  5]   2.00-3.00   sec  3.00 MBytes  25.2 Mbits/sec  1477    425 KBytes       
	[  5]   3.00-4.00   sec  3.25 MBytes  27.2 Mbits/sec  1348   2.85 KBytes       
	[  5]   4.00-5.00   sec  3.43 MBytes  28.8 Mbits/sec  1875    498 KBytes       
	[  5]   5.00-6.00   sec  3.49 MBytes  29.3 Mbits/sec  1957    471 KBytes       
	[  5]   6.00-7.00   sec  2.48 MBytes  20.8 Mbits/sec  1463    538 KBytes       
	[  5]   7.00-8.00   sec  1.25 MBytes  10.5 Mbits/sec  1072    603 KBytes       
	[  5]   8.00-9.00   sec  3.71 MBytes  31.2 Mbits/sec  1362    593 KBytes       
	[  5]   9.00-10.00  sec  2.50 MBytes  21.0 Mbits/sec  1676    624 KBytes       
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bitrate         Retr
	[  5]   0.00-10.00  sec  68.3 MBytes  57.3 Mbits/sec  12874             sender <<<
	[  5]   0.00-10.04  sec  64.9 MBytes  54.3 Mbits/sec                  receiver <<<

## After Revert
- git checkout v6.6.92
- git revert e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f
- build, boot, test with `iperf -c <ip>`
	[  5] local 192.168.1.52 port 44136 connected to 192.168.1.203 port 5201
	[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
	[  5]   0.00-1.00   sec  90.5 MBytes   759 Mbits/sec  117    261 KBytes       
	[  5]   1.00-2.00   sec   113 MBytes   949 Mbits/sec    5    264 KBytes       
	[  5]   2.00-3.00   sec   113 MBytes   952 Mbits/sec    3    274 KBytes       
	[  5]   3.00-4.00   sec   113 MBytes   947 Mbits/sec    5    267 KBytes       
	[  5]   4.00-5.00   sec   113 MBytes   949 Mbits/sec    3    248 KBytes       
	[  5]   5.00-6.00   sec   113 MBytes   951 Mbits/sec    8    247 KBytes       
	[  5]   6.00-7.00   sec   113 MBytes   947 Mbits/sec    5    252 KBytes       
	[  5]   7.00-8.00   sec   113 MBytes   950 Mbits/sec    6    247 KBytes       
	[  5]   8.00-9.00   sec   113 MBytes   951 Mbits/sec    8    254 KBytes       
	[  5]   9.00-10.00  sec   113 MBytes   948 Mbits/sec    3    247 KBytes       
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bitrate         Retr
	[  5]   0.00-10.00  sec  1.08 GBytes   930 Mbits/sec  163               sender <<<
	[  5]   0.00-10.04  sec  1.08 GBytes   925 Mbits/sec                  receiver <<<



# Testing v6.15.1

## Before Revert
- git checkout v6.15.1
- build, boot, test with `iperf -c <ip>`
	[  5] local 192.168.1.52 port 52154 connected to 192.168.1.203 port 5201
	[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
	[  5]   0.00-1.00   sec  77.8 MBytes   652 Mbits/sec   73    298 KBytes       
	[  5]   1.00-2.00   sec  3.61 MBytes  30.3 Mbits/sec  530    388 KBytes       
	[  5]   2.00-3.00   sec  2.88 MBytes  24.2 Mbits/sec  1126    389 KBytes       
	[  5]   3.00-4.00   sec  3.06 MBytes  25.7 Mbits/sec  1750    456 KBytes       
	[  5]   4.00-5.00   sec  3.25 MBytes  27.2 Mbits/sec  1822    488 KBytes       
	[  5]   5.00-6.00   sec  3.43 MBytes  28.8 Mbits/sec  1506    530 KBytes       
	[  5]   6.00-7.00   sec  3.68 MBytes  30.8 Mbits/sec  1926    543 KBytes       
	[  5]   7.00-8.00   sec  2.48 MBytes  20.8 Mbits/sec  1675    609 KBytes       
	[  5]   8.00-9.00   sec  2.49 MBytes  20.9 Mbits/sec  941    332 KBytes       
	[  5]   9.00-10.00  sec  11.1 MBytes  93.4 Mbits/sec  747    358 KBytes       
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bitrate         Retr
	[  5]   0.00-10.00  sec   114 MBytes  95.5 Mbits/sec  12096             sender <<<
	[  5]   0.00-10.04  sec   110 MBytes  92.1 Mbits/sec                  receiver <<<

## After Revert
- git checkout v6.15.1
- git revert e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f
- build, boot, test with `iperf -c <ip>`
	[  5] local 192.168.1.52 port 52266 connected to 192.168.1.203 port 5201
	[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
	[  5]   0.00-1.00   sec  91.3 MBytes   766 Mbits/sec   81    275 KBytes       
	[  5]   1.00-2.00   sec   113 MBytes   947 Mbits/sec    6    281 KBytes       
	[  5]   2.00-3.00   sec   113 MBytes   952 Mbits/sec    8    272 KBytes       
	[  5]   3.00-4.00   sec   113 MBytes   950 Mbits/sec    3    274 KBytes       
	[  5]   4.00-5.00   sec   113 MBytes   950 Mbits/sec    6    264 KBytes       
	[  5]   5.00-6.00   sec   113 MBytes   944 Mbits/sec    6    272 KBytes       
	[  5]   6.00-7.00   sec   114 MBytes   952 Mbits/sec    9    272 KBytes       
	[  5]   7.00-8.00   sec  89.0 MBytes   746 Mbits/sec   62    315 KBytes       
	[  5]   8.00-9.00   sec   113 MBytes   947 Mbits/sec    6    304 KBytes       
	[  5]   9.00-10.00  sec   113 MBytes   948 Mbits/sec    6    302 KBytes       
	- - - - - - - - - - - - - - - - - - - - - - - - -
	[ ID] Interval           Transfer     Bitrate         Retr
	[  5]   0.00-10.00  sec  1.06 GBytes   910 Mbits/sec  193               sender <<<
	[  5]   0.00-10.04  sec  1.06 GBytes   905 Mbits/sec                  receiver <<<



# git show e37ab7373696e650d3b6262a5b882aadad69bb9e|cat

commit e37ab7373696e650d3b6262a5b882aadad69bb9e
Author: Neal Cardwell <ncardwell@google.com>
Date:   Tue Oct 1 20:05:15 2024 +0000

    tcp: fix to allow timestamp undo if no retransmits were sent
    
    Fix the TCP loss recovery undo logic in tcp_packet_delayed() so that
    it can trigger undo even if TSQ prevents a fast recovery episode from
    reaching tcp_retransmit_skb().
    
    Geumhwan Yu <geumhwan.yu@samsung.com> recently reported that after
    this commit from 2019:
    
    commit bc9f38c8328e ("tcp: avoid unconditional congestion window undo
    on SYN retransmit")
    
    ...and before this fix we could have buggy scenarios like the
    following:
    
    + Due to reordering, a TCP connection receives some SACKs and enters a
      spurious fast recovery.
    
    + TSQ prevents all invocations of tcp_retransmit_skb(), because many
      skbs are queued in lower layers of the sending machine's network
      stack; thus tp->retrans_stamp remains 0.
    
    + The connection receives a TCP timestamp ECR value echoing a
      timestamp before the fast recovery, indicating that the fast
      recovery was spurious.
    
    + The connection fails to undo the spurious fast recovery because
      tp->retrans_stamp is 0, and thus tcp_packet_delayed() returns false,
      due to the new logic in the 2019 commit: commit bc9f38c8328e ("tcp:
      avoid unconditional congestion window undo on SYN retransmit")
    
    This fix tweaks the logic to be more similar to the
    tcp_packet_delayed() logic before bc9f38c8328e, except that we take
    care not to be fooled by the FLAG_SYN_ACKED code path zeroing out
    tp->retrans_stamp (the bug noted and fixed by Yuchung in
    bc9f38c8328e).
    
    Note that this returns the high-level behavior of tcp_packet_delayed()
    to again match the comment for the function, which says: "Nothing was
    retransmitted or returned timestamp is less than timestamp of the
    first retransmission." Note that this comment is in the original
    2005-04-16 Linux git commit, so this is evidently long-standing
    behavior.
    
    Fixes: bc9f38c8328e ("tcp: avoid unconditional congestion window undo on SYN retransmit")
    Reported-by: Geumhwan Yu <geumhwan.yu@samsung.com>
    Diagnosed-by: Geumhwan Yu <geumhwan.yu@samsung.com>
    Signed-off-by: Neal Cardwell <ncardwell@google.com>
    Signed-off-by: Yuchung Cheng <ycheng@google.com>
    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Link: https://patch.msgid.link/20241001200517.2756803-2-ncardwell.sw@gmail.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cc05ec1faac8..233b77890795 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2473,8 +2473,22 @@ static bool tcp_skb_spurious_retrans(const struct tcp_sock *tp,
  */
 static inline bool tcp_packet_delayed(const struct tcp_sock *tp)
 {
-	return tp->retrans_stamp &&
-	       tcp_tsopt_ecr_before(tp, tp->retrans_stamp);
+	const struct sock *sk = (const struct sock *)tp;
+
+	if (tp->retrans_stamp &&
+	    tcp_tsopt_ecr_before(tp, tp->retrans_stamp))
+		return true;  /* got echoed TS before first retransmission */
+
+	/* Check if nothing was retransmitted (retrans_stamp==0), which may
+	 * happen in fast recovery due to TSQ. But we ignore zero retrans_stamp
+	 * in TCP_SYN_SENT, since when we set FLAG_SYN_ACKED we also clear
+	 * retrans_stamp even if we had retransmitted the SYN.
+	 */
+	if (!tp->retrans_stamp &&	   /* no record of a retransmit/SYN? */
+	    sk->sk_state != TCP_SYN_SENT)  /* not the FLAG_SYN_ACKED case? */
+		return true;  /* nothing was retransmitted */
+
+	return false;
 }
 
 /* Undo procedures. */


--
Eric Wheeler
www.linuxglobal.com

