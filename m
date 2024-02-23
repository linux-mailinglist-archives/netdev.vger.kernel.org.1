Return-Path: <netdev+bounces-74540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B93861C88
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264732875E0
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1491A1448E0;
	Fri, 23 Feb 2024 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AeWoQK+f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB02179A8
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 19:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708716546; cv=none; b=Flv2ArRNJRAXOyaO43lNoHYBCnnfzkRZT+MLQFGckHiMXFBVLgy2S0Cp04ULOYd1wKbah4TvYfdxmtyWVyb3LNOpFXa9WjzJtsyURVrn5/IICHI+NFBiC04+6pEk3TYZc3GvGaJCwv3gnld4k1owvD6sTRYfBrMYF0BY7hVT4LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708716546; c=relaxed/simple;
	bh=VIok3FOHrgKvrXR2nVmyJPoQQG9xhKJUtLHtKOZ91M4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NP5ZDALiMGUyB3wY2R9F4aFvOWnWJdsS6UityaR7vRe8yY2K8gnjgbblRB8j8LhWIyIatUfTkP0H3QrV9A0T/Az5UxabLdnqdFZtP1diTUmgopO3lUA7v/jVCAinRXQKrLczpdbW0x2gKyhNSHjbM8bZjSNPW9HSTwdvNb1XM60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AeWoQK+f; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708716544; x=1740252544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3KOY2QzrF9mMQPw1/sDUNLdFQkf6urcxta5OmSRhBT0=;
  b=AeWoQK+fUaXvvnXUOqjpkR3uAVC23tIn2A1moeuYBep1x9OxOSLsgPXy
   QrAasOJSjxma0NxQRyMlTWnxXGTxzIbLqsv8eNENo3VAqHNPvpeM5/FhW
   pB7nW6GjEKT03nmkOxbvf0EMlC73d0/EWJOpZMmLLyATgEc/pdIeliUO8
   A=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="68343279"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 19:29:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:41027]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.241:2525] with esmtp (Farcaster)
 id c1142762-8be2-444b-b386-32a697dbd5ee; Fri, 23 Feb 2024 19:29:03 +0000 (UTC)
X-Farcaster-Flow-ID: c1142762-8be2-444b-b386-32a697dbd5ee
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:29:03 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 19:29:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v9 05/10] tcp: use drop reasons in cookie check for ipv6
Date: Fri, 23 Feb 2024 11:28:51 -0800
Message-ID: <20240223192851.6413-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223102851.83749-6-kerneljasonxing@gmail.com>
References: <20240223102851.83749-6-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 23 Feb 2024 18:28:46 +0800
> From: Jason Xing <kernelxing@tencent.com>
> 
> Like what I did to ipv4 mode, refine this part: adding more drop
> reasons for better tracing.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> --
> v9
> Link: https://lore.kernel.org/netdev/c5640fc4-16dc-4058-97c6-bd84bae4fda1@kernel.org/
> 1. add reviewed-by tag (David)
> 
> v8
> Link: https://lore.kernel.org/netdev/CANn89i+b+bYqX0aVv9KtSm=nLmEQznamZmqaOzfqtJm_ux9JBw@mail.gmail.com/
> 1. add reviewed-by tag (Eric)
> 
> v6:
> Link: https://lore.kernel.org/netdev/20240215210922.19969-1-kuniyu@amazon.com/
> 1. Not use NOMEM because of MPTCP (Kuniyuki). I chose to use NO_SOCKET as
> an indicator which can be used as three kinds of cases to tell people that we're
> unable to get a valid one. It's a relatively general reason like what we did
> to TCP_FLAGS.
> 
> v5:
> Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
> 1. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
> 2. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
> 3. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)
> ---
>  net/ipv6/syncookies.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
> index ea0d9954a29f..8bad0a44a0a6 100644
> --- a/net/ipv6/syncookies.c
> +++ b/net/ipv6/syncookies.c
> @@ -190,16 +190,20 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
>  		if (IS_ERR(req))
>  			goto out;
>  	}
> -	if (!req)
> +	if (!req) {
> +		SKB_DR_SET(reason, NO_SOCKET);
>  		goto out_drop;
> +	}
>  
>  	ireq = inet_rsk(req);
>  
>  	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
>  	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
>  
> -	if (security_inet_conn_request(sk, skb, req))
> +	if (security_inet_conn_request(sk, skb, req)) {
> +		SKB_DR_SET(reason, SECURITY_HOOK);
>  		goto out_free;
> +	}
>  
>  	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
>  	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
> @@ -236,8 +240,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
>  		security_req_classify_flow(req, flowi6_to_flowi_common(&fl6));
>  
>  		dst = ip6_dst_lookup_flow(net, sk, &fl6, final_p);
> -		if (IS_ERR(dst))
> +		if (IS_ERR(dst)) {
> +			SKB_DR_SET(reason, IP_OUTNOROUTES);
>  			goto out_free;
> +		}
>  	}
>  
>  	req->rsk_window_clamp = tp->window_clamp ? :dst_metric(dst, RTAX_WINDOW);
> @@ -257,8 +263,10 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
>  	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
>  
>  	ret = tcp_get_cookie_sock(sk, skb, req, dst);
> -	if (!ret)
> +	if (!ret) {
> +		SKB_DR_SET(reason, NO_SOCKET);
>  		goto out_drop;
> +	}
>  out:
>  	return ret;
>  out_free:
> -- 
> 2.37.3

