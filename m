Return-Path: <netdev+bounces-219286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFBCB40E73
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 22:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53783B8E65
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E842E7BD8;
	Tue,  2 Sep 2025 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l30VwIAS"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2860E35957
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844231; cv=none; b=I/6alex95wA4ln7yUaanILEq/tjdsHWk7mCi9k4Xn70jsTPUBtaD3fkD07u+YikepwYHP5ZZ2UE9DKMnzkbtBAUgdcIZx+XXko15Ft+wI8mcnLbimpLl3onowZyWqAy+g3JPiSzXMKzl/ayOR/vmaZTbY4HgQfSWsnKLmXEzII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844231; c=relaxed/simple;
	bh=+hbpy2Iiqvr1/l+i18sWmNyFeecx71SVVhMh4y2GFPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cSYpzxrdeyv3dK+BVTpJzq1k+i1iPSFQruq40cAcpiDxhh0pQSRIwxoi9e6OAVxC8wbWxGJtfSHUtLfMJ3DHWJh1bcoz1zwHh+4Q+AcQIACwugglpL1GQr+4kWCPNcGkXMugDuHoHquKMIHuzuPTr/wQ1iMEFzL0mIU9VqfV8Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l30VwIAS; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4334e29b-1cd0-48ba-9afa-54d01b1b7143@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756844217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8BX0PvoIYm3qSVd3fOXvAXCOsSt/r0E/au78lFxCpY=;
	b=l30VwIAS6nXs2JQmyxqdbm95ZHPrXBlsrpA+RHj1rJcDlQRxIrx6SyG0HECSoaYhVX2LOo
	cnNnCZg27zUjJpWIlUNEvW4QIv3tlsW2eeoGMTxJFjTAgvmVa1xtFjyvaoJgRzuFxxTKLg
	JLt/nfsVQqb+hjWQYj/mHG7AZUrydJg=
Date: Tue, 2 Sep 2025 13:16:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next/net 4/5] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250829010026.347440-1-kuniyu@google.com>
 <20250829010026.347440-5-kuniyu@google.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250829010026.347440-5-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> +static inline bool sk_should_enter_memory_pressure(struct sock *sk)
> +{
> +	return !mem_cgroup_sk_enabled(sk) || !mem_cgroup_sk_isolated(sk);
> +}
> +
>   static inline long
>   proto_memory_allocated(const struct proto *prot)
>   {

> @@ -3154,8 +3158,11 @@ bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
>   	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
>   		return true;
>   
> -	sk_enter_memory_pressure(sk);
> +	if (sk_should_enter_memory_pressure(sk))
> +		sk_enter_memory_pressure(sk);
> +
>   	sk_stream_moderate_sndbuf(sk);
> +
>   	return false;
>   }

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 71a956fbfc55..dcbd49e2f8af 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -908,7 +908,8 @@ struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
>   		}
>   		__kfree_skb(skb);
>   	} else {
> -		sk->sk_prot->enter_memory_pressure(sk);
> +		if (sk_should_enter_memory_pressure(sk))
> +			tcp_enter_memory_pressure(sk);

This change from sk_prot->enter_memory_pressure to tcp_enter_memory_pressure 
looks fine. A qq / nit, have you thought about checking 
sk_should_enter_memory_pressure inside the tcp_enter_memory_pressure(sk) / 
sk_enter_memory_pressure(sk) ?

Other changes of patch 4 lgtm.

Shakeel, you have ack-ed patch 1. Will you take a look at patch 3 and patch 4 also?

>   		sk_stream_moderate_sndbuf(sk);
>   	}

> @@ -1016,7 +1017,7 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
>   	mptcp_for_each_subflow(msk, subflow) {
>   		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>   
> -		if (first)
> +		if (first && sk_should_enter_memory_pressure(ssk))
>   			tcp_enter_memory_pressure(ssk);
>   		sk_stream_moderate_sndbuf(ssk);
>   
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index f672a62a9a52..6696ef837116 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -35,6 +35,7 @@
>   #include <linux/netdevice.h>
>   #include <net/dst.h>
>   #include <net/inet_connection_sock.h>
> +#include <net/proto_memory.h>
>   #include <net/tcp.h>
>   #include <net/tls.h>
>   #include <linux/skbuff_ref.h>
> @@ -371,7 +372,8 @@ static int tls_do_allocation(struct sock *sk,
>   	if (!offload_ctx->open_record) {
>   		if (unlikely(!skb_page_frag_refill(prepend_size, pfrag,
>   						   sk->sk_allocation))) {
> -			READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
> +			if (sk_should_enter_memory_pressure(sk))
> +				READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
>   			sk_stream_moderate_sndbuf(sk);
>   			return -ENOMEM;
>   		}


