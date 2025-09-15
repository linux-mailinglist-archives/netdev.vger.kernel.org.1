Return-Path: <netdev+bounces-223157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9A6B58137
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05FA7A901B
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8E1D6194;
	Mon, 15 Sep 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bzc8sPsM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C963B2DC786
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757951380; cv=none; b=ivuLUdl0WqZDBsv+HL3c5x0XW+hPURIbhn9ay4Kn8AH6QQ800NlSdZ1O8HpS+GRHCVfURRqfAKfDs2fYEDp8CvEP+etf3tFXCC7U6u9+V2m95nVpt3gN/zTOo+Q+m/8ZgcK1/QTBUnT3dmm54ZQwVaJxa4WT6Km5DfCS9FdNbTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757951380; c=relaxed/simple;
	bh=3YtH3OhNY0ygt6zSepvW8K42hG0gydWRfHCbOpADDHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C02QjnqOnjgsajv6zy6TV1ofFWbHFTzfqyiI8kDDphbaSTgKxuT993dLYS0VkBj0rDqF9Ie+rQC+kQMIvwgcj6AfqCHnM1ioQJuGOFGYejVAltyai9R6if1IvK53GowS7Bkx5IaJ7LNZUaXhIEhG6+IpZ2MX7pmKP0h0Z8kAX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bzc8sPsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1379AC4CEF1;
	Mon, 15 Sep 2025 15:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951380;
	bh=3YtH3OhNY0ygt6zSepvW8K42hG0gydWRfHCbOpADDHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bzc8sPsMc4W2giKXg8ebPHMFYITA+TzoKqd33TLDoR6SsiJX2wHjMzQ5ZygZTScpH
	 jH2T66HwVo7893kwZCm3kD/2/OvichxDoh49q/3rZ062BZ+yMBLukXp/WGVayHa5iO
	 4rSWywaFTHEwwvwPUu9pPdkmKeKWeOBTbbX3BQjvIzyiYjjsxv3rc1XU7BirNPCVPa
	 79IB9ZWfR2MNHjYM8uDeGhvVDr+QEPy4ZB3mYz10c7px1n9vhN4WasYlJWRV36h9W+
	 SJlm360ZgGKWvQGpAYTtg0xs69vDWIACNy0i6FZpPsAXeRXOxJuTcFDnnb2XK8DoBX
	 WA/OnPUy6FETQ==
Message-ID: <4aa939a8-256e-4045-bb4a-01a380a1c519@kernel.org>
Date: Mon, 15 Sep 2025 09:49:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: ipv4: simplify drop reason handling in
 ip_rcv_finish_core
Content-Language: en-US
To: Antoine Tenart <atenart@kernel.org>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: netdev@vger.kernel.org
References: <20250915091958.15382-1-atenart@kernel.org>
 <20250915091958.15382-3-atenart@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250915091958.15382-3-atenart@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 3:19 AM, Antoine Tenart wrote:
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 8878e865ddf6..93b8286e526a 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -335,7 +335,6 @@ static int ip_rcv_finish_core(struct net *net,
>  			goto drop_error;
>  	}
>  
> -	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;

since you are touching this function for drop reason cleanups,
drop_reason should be changed from `int` to `enum skb_drop_reason`

>  	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
>  	    !skb_dst(skb) &&
>  	    !skb->sk &&
> @@ -354,7 +353,6 @@ static int ip_rcv_finish_core(struct net *net,
>  				drop_reason = udp_v4_early_demux(skb);
>  				if (unlikely(drop_reason))

This should be `drop_reason != SKB_NOT_DROPPED_YET`

>  					goto drop_error;
> -				drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  
>  				/* must reload iph, skb->head might have changed */
>  				iph = ip_hdr(skb);
> @@ -372,7 +370,6 @@ static int ip_rcv_finish_core(struct net *net,
>  						   ip4h_dscp(iph), dev);
>  		if (unlikely(drop_reason))

similarly here.

>  			goto drop_error;
> -		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  	} else {
>  		struct in_device *in_dev = __in_dev_get_rcu(dev);
>  
> @@ -391,8 +388,10 @@ static int ip_rcv_finish_core(struct net *net,
>  	}
>  #endif
>  
> -	if (iph->ihl > 5 && ip_rcv_options(skb, dev))
> +	if (iph->ihl > 5 && ip_rcv_options(skb, dev)) {
> +		drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
>  		goto drop;
> +	}
>  
>  	rt = skb_rtable(skb);
>  	if (rt->rt_type == RTN_MULTICAST) {


