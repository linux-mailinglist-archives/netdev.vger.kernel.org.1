Return-Path: <netdev+bounces-79053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C0877A19
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 04:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4812C1F20F2E
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 03:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4E0138C;
	Mon, 11 Mar 2024 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cvmlBWRY"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2981841;
	Mon, 11 Mar 2024 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710127687; cv=none; b=eyB+DBDxQXdeHU1t7gqXibLGpdpEqvKyzdLdoBT7OG5t3n1WVpmJu5IWHmgOMvY4jOFdn5k4dslavnPnUDfjFMy2MkGBy4t0PmxOvFkHykXkxVxpze8VG+eVs+alb5YYfK5D0e2k3TXFm7ldICyCfLLLRg6gKYUQjVcrOmXO+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710127687; c=relaxed/simple;
	bh=2We7NM8NuSa8VZnXUAwK8s6k5JVLT3KsflOZXseGnOE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SB2swpCA8pLZfgS3hrbbwvZMCx+hmSnVxCX3bqDZ3yAKAWVOAGGr/PIaMjNtmTJ0dFWw4KZ3oqfSVwJXVYewoJtQ0jaBBfEfFuIvAk1Jqm7cnEQ6P2YroKRJ/F0x3fKAjIKnqhBvLQXUrj/5Sel07dsHro7v9q316cRxIDW8Lag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cvmlBWRY; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ANrUYP006812;
	Sun, 10 Mar 2024 20:27:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=z1onnWzGgqG4k0az0YKqYt
	8yhLnJJchpJGqqmcW1Jdc=; b=cvmlBWRYZLjyjk/q/EGkDeLy05wpdoHHT5xYm3
	mWabO/VJTnIpYR7v0JOM5raER70z8YHWd3J1CQbxB60SZlp8kK9fUCpU6DI9dcnd
	0cPJ7x1mRCQcvGbkiTxUyO6HV3SFzuA66TMcDM5HR7rNInjEQaT5vDk9dUYJIg+k
	Aj9Qm6QLN/12VtP5N1AKIrz7yT+cNvZMieUQZK+7ZuMaTSvS5blSUgXZBGVZL2iI
	QblWCA74bOOvwCaHxMCYTirVCs4TTzNmAeZy3kTXSOEPYZQexaMB/KMC3cNUZ+R5
	YTiv5uoqUuT75qRQ0FyAlx6FthSwaKmx2v5mfUtHBogs4eXg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wrr5kkcjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 20:27:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 10 Mar 2024 20:27:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Sun, 10 Mar 2024 20:27:22 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id BDF2C3F7058;
	Sun, 10 Mar 2024 20:27:18 -0700 (PDT)
Date: Mon, 11 Mar 2024 08:57:17 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <edumazet@google.com>, <mhiramat@kernel.org>,
        <mathieu.desnoyers@efficios.com>, <rostedt@goodmis.org>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
        Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 2/2] trace: tcp: fully support
 trace_tcp_send_reset
Message-ID: <20240311032717.GB1241282@maili.marvell.com>
References: <20240311024104.67522-1-kerneljasonxing@gmail.com>
 <20240311024104.67522-3-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311024104.67522-3-kerneljasonxing@gmail.com>
X-Proofpoint-GUID: rKluH81ysV7D3PRKPYloV9RDzu7XR3Ow
X-Proofpoint-ORIG-GUID: rKluH81ysV7D3PRKPYloV9RDzu7XR3Ow
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_16,2024-03-06_01,2023-05-22_02

On 2024-03-11 at 08:11:04, Jason Xing (kerneljasonxing@gmail.com) wrote:
> From: Jason Xing <kernelxing@tencent.com>
>
> Prior to this patch, what we can see by enabling trace_tcp_send is
> only happening under two circumstances:
> 1) active rst mode
> 2) non-active rst mode and based on the full socket
>
> That means the inconsistency occurs if we use tcpdump and trace
> simultaneously to see how rst happens.
>
> It's necessary that we should take into other cases into considerations,
> say:
> 1) time-wait socket
> 2) no socket
> ...
>
> By parsing the incoming skb and reversing its 4-turple can
> we know the exact 'flow' which might not exist.
>
> Samples after applied this patch:
> 1. tcp_send_reset: skbaddr=XXX skaddr=XXX src=ip:port dest=ip:port
> state=TCP_ESTABLISHED
> 2. tcp_send_reset: skbaddr=000...000 skaddr=XXX src=ip:port dest=ip:port
> state=UNKNOWN
> Note:
> 1) UNKNOWN means we cannot extract the right information from skb.
> 2) skbaddr/skaddr could be 0
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/trace/events/tcp.h | 39 ++++++++++++++++++++++++++++++++++++--
>  net/ipv4/tcp_ipv4.c        |  4 ++--
>  net/ipv6/tcp_ipv6.c        |  3 ++-
>  3 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
> index 2495a1d579be..6c09d7941583 100644
> --- a/include/trace/events/tcp.h
> +++ b/include/trace/events/tcp.h
> @@ -107,11 +107,46 @@ DEFINE_EVENT(tcp_event_sk_skb, tcp_retransmit_skb,
>   * skb of trace_tcp_send_reset is the skb that caused RST. In case of
>   * active reset, skb should be NULL
>   */
> -DEFINE_EVENT(tcp_event_sk_skb, tcp_send_reset,
> +TRACE_EVENT(tcp_send_reset,
>
>  	TP_PROTO(const struct sock *sk, const struct sk_buff *skb),
>
> -	TP_ARGS(sk, skb)
> +	TP_ARGS(sk, skb),
> +
> +	TP_STRUCT__entry(
> +		__field(const void *, skbaddr)
> +		__field(const void *, skaddr)
> +		__field(int, state)
> +		__array(__u8, saddr, sizeof(struct sockaddr_in6))
> +		__array(__u8, daddr, sizeof(struct sockaddr_in6))
> +	),
> +
> +	TP_fast_assign(
> +		__entry->skbaddr = skb;
> +		__entry->skaddr = sk;
> +		/* Zero means unknown state. */
> +		__entry->state = sk ? sk->sk_state : 0;
> +
> +		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
> +		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
> +
> +		if (sk && sk_fullsock(sk)) {
> +			const struct inet_sock *inet = inet_sk(sk);
> +
> +			TP_STORE_ADDR_PORTS(__entry, inet, sk);
> +		} else {
> +			/*
> +			 * We should reverse the 4-turple of skb, so later
> +			 * it can print the right flow direction of rst.
> +			 */
> +			TP_STORE_ADDR_PORTS_SKB(skb, entry->daddr, entry->saddr);
> +		}
> +	),
> +
> +	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s",
Could you consider using %px ? is it permitted ? it will be easy to track skb.

> +		  __entry->skbaddr, __entry->skaddr,
> +		  __entry->saddr, __entry->daddr,
> +		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN")
>  );
>
>  /*
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a22ee5838751..d5c4a969c066 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -868,10 +868,10 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb)
>  	 */
>  	if (sk) {
>  		arg.bound_dev_if = sk->sk_bound_dev_if;
> -		if (sk_fullsock(sk))
> -			trace_tcp_send_reset(sk, skb);
>  	}
>
> +	trace_tcp_send_reset(sk, skb);
> +
>  	BUILD_BUG_ON(offsetof(struct sock, sk_bound_dev_if) !=
>  		     offsetof(struct inet_timewait_sock, tw_bound_dev_if));
>
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index 3f4cba49e9ee..8e9c59b6c00c 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -1113,7 +1113,6 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
>  	if (sk) {
>  		oif = sk->sk_bound_dev_if;
>  		if (sk_fullsock(sk)) {
> -			trace_tcp_send_reset(sk, skb);
>  			if (inet6_test_bit(REPFLOW, sk))
>  				label = ip6_flowlabel(ipv6h);
>  			priority = READ_ONCE(sk->sk_priority);
> @@ -1129,6 +1128,8 @@ static void tcp_v6_send_reset(const struct sock *sk, struct sk_buff *skb)
>  			label = ip6_flowlabel(ipv6h);
>  	}
>
> +	trace_tcp_send_reset(sk, skb);
> +
>  	tcp_v6_send_response(sk, skb, seq, ack_seq, 0, 0, 0, oif, 1,
>  			     ipv6_get_dsfield(ipv6h), label, priority, txhash,
>  			     &key);
> --
> 2.37.3
>

