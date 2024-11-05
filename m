Return-Path: <netdev+bounces-141831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3649BC74B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 08:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FD01C22054
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 07:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550E11FCF41;
	Tue,  5 Nov 2024 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CNzFl80+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE0282F1
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730792972; cv=none; b=Rjsgr8evtAoAOYVa+LHVhTA8Qnu0xsC0s0Zujwtk10zGsH7x3v69vkmhfX23JuHkfsXLQOagAYWmBI2ZptfzFgTZ0Ce+1Lrtdtdo/baFXcbA8ZcgJnHo8np8O5XrIJgQU/vIqh4S2DO3dKsvKQ405ngimJk/ZwmE1SP9hYOd1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730792972; c=relaxed/simple;
	bh=qfqLpZeTQPswxkg9GLMZaMpmIincBUUUDXLdljDLi2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ER4Pe/JfA2BmlWrS20dAzfQ8ls+vfNHcRryRir3gIRpUVpXusmRImt2/ivKXfvhIfidWN+1Efl+8AKWxlcCBAydqcANCdzVZEuABZUE1rtuFTbuzO1FPUw1vTHjv1F8klu3VU0snUbkut7NoF4T6jgSnWySWfHa3/xBX1nR0zrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CNzFl80+; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730792970; x=1762328970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=buxtl97omJkJ9wNG5yilJBu27HtxpCMQCFIYaxJnDJw=;
  b=CNzFl80+qP9aBPw3JTGC7oMH0vJt6ARXI3ZpC1HHYSz5JYpX6kaQZySO
   zznV+UU6k6dal7BpSPv4Z88NLhRXhfpxPqJ8fZWOCHmvIYFaMqIa1Vs86
   2Px9KREN4qQLqYUl234tXoD2GvIjULKPHaI+4QBojH4l+Vy+sh8QBNZAr
   U=;
X-IronPort-AV: E=Sophos;i="6.11,259,1725321600"; 
   d="scan'208";a="39031355"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 07:49:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:47817]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.170:2525] with esmtp (Farcaster)
 id 8c07c67d-a201-4b65-b151-3dac93b35ace; Tue, 5 Nov 2024 07:49:25 +0000 (UTC)
X-Farcaster-Flow-ID: 8c07c67d-a201-4b65-b151-3dac93b35ace
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 07:49:21 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 07:49:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kernelxing@tencent.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] tcp: avoid RST in 3-way shakehands due to failure in tcp_timewait_state_process
Date: Mon, 4 Nov 2024 23:49:16 -0800
Message-ID: <20241105074916.75107-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105025511.42652-1-kerneljasonxing@gmail.com>
References: <20241105025511.42652-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue,  5 Nov 2024 10:55:11 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> We found there are rare chances that some RST packets appear during
> the shakehands because the timewait socket cannot accept the SYN and

s/shakehands/handshake/

same in the subject.

> doesn't return TCP_TW_SYN in tcp_timewait_state_process().
> 
> Here is how things happen in production:
> Time        Client(A)        Server(B)
> 0s          SYN-->
> ...
> 132s                         <-- FIN
> ...
> 169s        FIN-->
> 169s                         <-- ACK
> 169s        SYN-->
> 169s                         <-- ACK
> 169s        RST-->
> As above picture shows, the two flows have a start time difference
> of 169 seconds. B starts to send FIN so it will finally enter into
> TIMEWAIT state. Nearly at the same time A launches a new connection
> that soon is reset by itself due to receiving a ACK.
> 
> There are two key checks in tcp_timewait_state_process() when timewait
> socket in B receives the SYN packet:
> 1) after(TCP_SKB_CB(skb)->seq, rcv_nxt)
> 2) (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0)
> 
> Regarding the first rule, it fails as expected because in the first
> connection the seq of SYN sent from A is 1892994276, then 169s have
> passed, the second SYN has 239034613 (caused by overflow of s32).
> 
> Then how about the second rule?
> It fails again!
> Let's take a look at how the tsval comes out:
> __tcp_transmit_skb()
>     -> tcp_syn_options()
>         -> opts->tsval = tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) + tp->tsoffset;
> The timestamp depends on two things, one is skb->skb_mstamp_ns, the
> other is tp->tsoffset. The latter value is fixed, so we don't need
> to care about it. If both operations (sending FIN and then starting
> sending SYN) from A happen in 1ms, then the tsval would be the same.
> It can be clearly seen in the tcpdump log. Notice that the tsval is
> with millisecond precision.
> 
> Based on the above analysis, I decided to make a small change to
> the check in tcp_timewait_state_process() so that the second flow
> would not fail.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp_minisocks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index bb1fe1ba867a..2b29d1bf5ca0 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -234,7 +234,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
>  	if (th->syn && !th->rst && !th->ack && !paws_reject &&
>  	    (after(TCP_SKB_CB(skb)->seq, rcv_nxt) ||
>  	     (tmp_opt.saw_tstamp &&
> -	      (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) < 0))) {

I think this follows RFC 6191 and such a change requires a formal
discussion at IETF.

https://datatracker.ietf.org/doc/html/rfc6191#section-2

---8<---
      *  If TCP Timestamps would be enabled for the new incarnation of
         the connection, and the timestamp contained in the incoming SYN
         segment is greater than the last timestamp seen on the previous
         incarnation of the connection (for that direction of the data
         transfer), honor the connection request (creating a connection
         in the SYN-RECEIVED state).

      *  If TCP Timestamps would be enabled for the new incarnation of
         the connection, the timestamp contained in the incoming SYN
         segment is equal to the last timestamp seen on the previous
         incarnation of the connection (for that direction of the data
         transfer), and the Sequence Number of the incoming SYN segment
         is greater than the last sequence number seen on the previous
         incarnation of the connection (for that direction of the data
         transfer), honor the connection request (creating a connection
         in the SYN-RECEIVED state).
---8<---

> +	      (s32)(READ_ONCE(tcptw->tw_ts_recent) - tmp_opt.rcv_tsval) <= 0))) {
>  		u32 isn = tcptw->tw_snd_nxt + 65535 + 2;
>  		if (isn == 0)
>  			isn++;
> -- 
> 2.37.3

