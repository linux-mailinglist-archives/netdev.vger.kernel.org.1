Return-Path: <netdev+bounces-74545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26462861CD9
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02852876DC
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C282E146E63;
	Fri, 23 Feb 2024 19:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c3TZFw69"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E095614535D
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717707; cv=none; b=Z+1yw26HuHZqQq5KhlR7B5YG7EOWH7PZ6Bw1M0jsMkN2ZWbvj22w2Nk4dFvIwni6+sZcPU2bsUJG+tQxGio+hu7et1KmSifYqhuWvQyprpFfrx8NTEKl84315vk8yIglPqU+uz6qk8tpCqMl0k2JRAVqGBcuxmuDYl6vDZeXDu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717707; c=relaxed/simple;
	bh=jKH7Gd8ABRV3ws9GX8vsEixhrB/uPWW3NyMle5cs2k4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7L81doSkFj+u3BGDFt7crkoeJFX/P5StPKZT/DTrZTzEljiWDdHY2+vCo0FHNYQaa0o8RKLTU147qnq7mOSM3+qAmJzXhN7gXElsS9O+1LNrB7fumpHv0L7YjmZbXugNDLZ9g4e+RRpHZc7HXDZZJ4F+qCJRnDvdMvSbLFF5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=c3TZFw69; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708717697; x=1740253697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wu+O9oh6qYesem5wX1j+sXK3ICeuFwgTt9v8q2HggKg=;
  b=c3TZFw69G0m9niobRB49Yf6OZ/nto1ilYmSnTDVsi936E0J39YR5IkZ5
   8pfzZov2ztHxEWwbHLEEGncgkq50AUUnMxnriFVAwTok+241c01itxwzJ
   XoGGNuWkvkvP6Js+mRx2a8X3v76aXQVoD2o9qQmMsf4D7t6Oe+mJbguUK
   M=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="707084459"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:48:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:29936]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.41:2525] with esmtp (Farcaster)
 id d5177a41-3dc8-4bca-b6f8-03cd26f81bcb; Fri, 23 Feb 2024 19:48:08 +0000 (UTC)
X-Farcaster-Flow-ID: d5177a41-3dc8-4bca-b6f8-03cd26f81bcb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:48:08 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:48:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 10/10] tcp: make dropreason in tcp_child_process() work
Date: Fri, 23 Feb 2024 11:47:56 -0800
Message-ID: <20240223194756.7942-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223102851.83749-11-kerneljasonxing@gmail.com>
References: <20240223102851.83749-11-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 18:28:51 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> It's time to let it work right now. We've already prepared for this:)
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> --
> v9
> Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
> Link: https://lore.kernel.org/netdev/CANn89iKE2vYz_6sYd=u3HbqdgiU0BWhdMY9-ivs0Rcht+X+Rfg@mail.gmail.com/
> 1. add reviewed-by tag (David)
> 2. add reviewed-by tag (Eric)
> 
> v8
> Link: https://lore.kernel.org/netdev/CANn89i+huvL_Zidru_sNHbjwgM7==-q49+mgJq7vZPRgH6DgKg@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/CANn89iKmaZZSnk5+CCtSH43jeUgRWNQPV4cjc0vpWNT7nHnQQg@mail.gmail.com/
> 1. squash v7 patch [11/11] into the current patch.
> 2. refine the rcv codes. (Eric)
> 
> v7
> Link: https://lore.kernel.org/all/20240219043815.98410-1-kuniyu@amazon.com/
> 1. adjust the related part of code only since patch [04/11] is changed.
> ---
>  net/ipv4/tcp_ipv4.c | 12 +++++++-----
>  net/ipv6/tcp_ipv6.c | 16 ++++++++++------
>  2 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index c79e25549972..a22ee5838751 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1907,7 +1907,6 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
>  		return 0;
>  	}
>  
> -	reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	if (tcp_checksum_complete(skb))
>  		goto csum_err;
>  
> @@ -1917,7 +1916,8 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
>  		if (!nsk)
>  			return 0;
>  		if (nsk != sk) {
> -			if (tcp_child_process(sk, nsk, skb)) {
> +			reason = tcp_child_process(sk, nsk, skb);
> +			if (reason) {
>  				rsk = nsk;
>  				goto reset;
>  			}
> @@ -2276,10 +2276,12 @@ int tcp_v4_rcv(struct sk_buff *skb)
>  		if (nsk == sk) {
>  			reqsk_put(req);
>  			tcp_v4_restore_cb(skb);
> -		} else if (tcp_child_process(sk, nsk, skb)) {
> -			tcp_v4_send_reset(nsk, skb);
> -			goto discard_and_relse;
>  		} else {
> +			drop_reason = tcp_child_process(sk, nsk, skb);
> +			if (drop_reason) {
> +				tcp_v4_send_reset(nsk, skb);
> +				goto discard_and_relse;
> +			}
>  			sock_put(sk);
>  			return 0;
>  		}
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 4f8464e04b7f..f677f0fa5196 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1623,7 +1623,6 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>  	if (np->rxopt.all)
>  		opt_skb = skb_clone_and_charge_r(skb, sk);
>  
> -	reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
>  		struct dst_entry *dst;
>  
> @@ -1654,8 +1653,11 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
>  		struct sock *nsk = tcp_v6_cookie_check(sk, skb);
>  
>  		if (nsk != sk) {
> -			if (nsk && tcp_child_process(sk, nsk, skb))
> -				goto reset;
> +			if (nsk) {
> +				reason = tcp_child_process(sk, nsk, skb);
> +				if (reason)
> +					goto reset;
> +			}
>  			if (opt_skb)
>  				__kfree_skb(opt_skb);
>  			return 0;
> @@ -1854,10 +1856,12 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
>  		if (nsk == sk) {
>  			reqsk_put(req);
>  			tcp_v6_restore_cb(skb);
> -		} else if (tcp_child_process(sk, nsk, skb)) {
> -			tcp_v6_send_reset(nsk, skb);
> -			goto discard_and_relse;
>  		} else {
> +			drop_reason = tcp_child_process(sk, nsk, skb);
> +			if (drop_reason) {
> +				tcp_v6_send_reset(nsk, skb);
> +				goto discard_and_relse;
> +			}
>  			sock_put(sk);
>  			return 0;
>  		}
> -- 
> 2.37.3

