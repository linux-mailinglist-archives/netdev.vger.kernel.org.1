Return-Path: <netdev+bounces-147414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BF09D9778
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3120B162861
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8781BF7E8;
	Tue, 26 Nov 2024 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ho+hNTOD"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB357194A66;
	Tue, 26 Nov 2024 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625514; cv=none; b=UxLxr3ZHZ2dAGJAUZAtTn8MvQ8hKvsPbAC+jjUW04H8anRN8LeiVibJrNU6kjAC6F3YPAyhfFrQbQsnnR9+Y9Aj1i/MKKgf8xHpSRPTckX4vR7L1AsrQQdK9sDnlfl7URWI3w9NmW9MFjbs6csXsx5I0U4+5i+9QG+cWwOZ+3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625514; c=relaxed/simple;
	bh=8LGlOIUGhQV0u96KZLm1OBFo+UPE9uRQUj6RRD1HUIg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCZJmzI9in5iPiv2ga2b2p+WrCpUFd0yIYt02Ju9+7KgE4QQ1P09ERmoqL5qQqjPwMGyI3ic1ltJxptuuqB7DMClRKgrNrWu8r4IHBEfZk4wkNaj8sIfTAosCgYMObT2uGKPlg7oX96BEaZMwx3Sbwyd2ct1M/FQVK07ZjAw2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ho+hNTOD; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6C412206E9;
	Tue, 26 Nov 2024 13:51:43 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lYgrauiUCBbs; Tue, 26 Nov 2024 13:51:42 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id CF749201AE;
	Tue, 26 Nov 2024 13:51:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com CF749201AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1732625502;
	bh=Z5mXv8QGvkVhiIVXeNoGTPBJEBa77o+JeFI9zmSaylI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ho+hNTODkgxwtwi0boZnCwU3BbIwM91nzdEaQyxMrAX/dSgBMKDkwSUCelfKcdvHj
	 00zq4GQYOkxsTm28Sza3XAAmN5E80r9a3CbL1jDtUfo/f22JWNbLRHVbjVNrlOLE1l
	 nZjffMsVhWmb9r0xUyiyTxNBRQHUNwaVziHQRHsuh9ugi2bT0ReqbL8EJJmgG3E669
	 sH0Z3V/WPQg0lkcUfDCvDerl52SDJJom3GuvwzRvDY7lVW+meJuySdLiTixnvuAdZp
	 lh2pfAT7/6i2OmrlV2z9ZWRU/RWip35bejeNZRWx4DfjZj3yOjOse7S+JWvECts7+3
	 85P1azXhgCeFw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 13:51:42 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 13:51:42 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 41F183184178; Tue, 26 Nov 2024 13:51:42 +0100 (CET)
Date: Tue, 26 Nov 2024 13:51:42 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Ilia Lin <ilia.lin@kernel.org>
CC: <leonro@nvidia.com>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Message-ID: <Z0XEXqe38O5lcsq5@gauss3.secunet.de>
References: <20241124093531.3783434-1-ilia.lin@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241124093531.3783434-1-ilia.lin@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sun, Nov 24, 2024 at 11:35:31AM +0200, Ilia Lin wrote:
> In packet offload mode the raw packets will be sent to the NiC,
> and will not return to the Network Stack. In event of crossing
> the MTU size after the encapsulation, the NiC HW may not be
> able to fragment the final packet.
> Adding mandatory pre-encapsulation fragmentation for both
> IPv4 and IPv6, if tunnel mode with packet offload is configured
> on the state.
> 
> Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
> ---
>  net/ipv4/xfrm4_output.c | 31 +++++++++++++++++++++++++++++--
>  net/ipv6/xfrm6_output.c |  8 ++++++--
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
> index 3cff51ba72bb0..a4271e0dd51bb 100644
> --- a/net/ipv4/xfrm4_output.c
> +++ b/net/ipv4/xfrm4_output.c
> @@ -14,17 +14,44 @@
>  #include <net/xfrm.h>
>  #include <net/icmp.h>
>  
> +static int __xfrm4_output_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
> +{
> +	return xfrm_output(sk, skb);
> +}
> +
>  static int __xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  {
> -#ifdef CONFIG_NETFILTER
> -	struct xfrm_state *x = skb_dst(skb)->xfrm;
> +	struct dst_entry *dst = skb_dst(skb);
> +	struct xfrm_state *x = dst->xfrm;
> +	unsigned int mtu;
> +	bool toobig;
>  
> +#ifdef CONFIG_NETFILTER
>  	if (!x) {
>  		IPCB(skb)->flags |= IPSKB_REROUTED;
>  		return dst_output(net, sk, skb);
>  	}
>  #endif
>  
> +	if (x->props.mode != XFRM_MODE_TUNNEL || x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
> +		goto skip_frag;
> +
> +	mtu = xfrm_state_mtu(x, dst_mtu(skb_dst(skb)));
> +
> +	toobig = skb->len > mtu && !skb_is_gso(skb);
> +
> +	if (!skb->ignore_df && toobig && skb->sk) {
> +		xfrm_local_error(skb, mtu);
> +		kfree_skb(skb);
> +		return -EMSGSIZE;
> +	}
> +
> +	if (toobig) {
> +		IPCB(skb)->frag_max_size = mtu;
> +		return ip_do_fragment(net, sk, skb, __xfrm4_output_finish);
> +	}

This would fragment the packet even if the DF bit is set.

Please no further packet offload stuff in generic code.

