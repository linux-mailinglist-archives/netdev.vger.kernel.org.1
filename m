Return-Path: <netdev+bounces-215292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCEEB2DF28
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 16:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB08A1C83F8D
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BC9223DEF;
	Wed, 20 Aug 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuqX7rRu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F91B223708;
	Wed, 20 Aug 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699601; cv=none; b=EV/eyvdN+yp/EnSPCTKWlz/C4czGcEYzBJYMavhZQFTMqZuM9mNaaHm5PZa6j3tZup9hEb3rZjYpEO6XtISLq5yu+3ZkqGWoidNuKYUcYNpm3Nd4zPScD136FfzkB07PnA+tAPl1yF17V2isy5ljqOMPtQJRSXs2Yfs2FVDu8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699601; c=relaxed/simple;
	bh=AwEHyZ/5mtrDYnfz3vqrnsJHfNOCpuaO1HkIIP/yN40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOM1ITOi5x8XsXqX71+QQA8LGUaGjqT6DDFEpw2pUeVNLxKB9QZX8qtPNKc932deL4Ggwe8YQDa9kFWeLcVsgO0SRBHG5CZAP2DdKPDjVWIJKc+XC3WMyECVHxzqySPIamBOxEp5KlaDrw53ixN2MF2c6JaGpFMFGQcWyUjZLqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuqX7rRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CD1C4CEE7;
	Wed, 20 Aug 2025 14:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699601;
	bh=AwEHyZ/5mtrDYnfz3vqrnsJHfNOCpuaO1HkIIP/yN40=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FuqX7rRu64K7skjJB1My7FMWRpzsQAdzaTX/0Ry4Y+gKWqale/mf4cTOf7WC+wtGO
	 NeGKM01+0x6KHf46eRKYoRD3GiiIjaMN1ltboZ7++eIIvmNk065D8JKRgqXA3TVZDm
	 gBCD3mSb8CEw2Q0WukWFL2zuABMxWp4+9eUPd6TOP5iIm5RWeB1QKOTZCjTINSi84v
	 oh2tqfLH+2XAk1saS35zs6ZlgRNFjM5D/0mJHINgzUTxBiDS9E4sl04bi8mA9OuMXi
	 uPdp0jtQt3abvY2HwKkRkMu5DcBMdYjBEttRk25Ld5R0iu0jEklyszot2KmJjMxERp
	 iD2jqMwLN+axA==
Message-ID: <89f5efc6-e380-4523-a512-38fef942890a@kernel.org>
Date: Wed, 20 Aug 2025 08:19:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: ipv4: allow directed broadcast
 routes to use dst hint
Content-Language: en-US
To: Oscar Maes <oscmaes92@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org
References: <20250819174642.5148-1-oscmaes92@gmail.com>
 <20250819174642.5148-2-oscmaes92@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250819174642.5148-2-oscmaes92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/25 11:46 AM, Oscar Maes wrote:
> Currently, ip_extract_route_hint uses RTN_BROADCAST to decide
> whether to use the route dst hint mechanism.
> 
> This check is too strict, as it prevents directed broadcast
> routes from using the hint, resulting in poor performance
> during bursts of directed broadcast traffic.
> 
> Fix this in ip_extract_route_hint and modify ip_route_use_hint
> to preserve the intended behaviour.
> 
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> ---
>  net/ipv4/ip_input.c | 11 +++++++----
>  net/ipv4/route.c    |  2 +-
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index fc323994b1fa..a09aca2c8567 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c
> @@ -587,9 +587,13 @@ static void ip_sublist_rcv_finish(struct list_head *head)
>  }
>  
>  static struct sk_buff *ip_extract_route_hint(const struct net *net,
> -					     struct sk_buff *skb, int rt_type)
> +					     struct sk_buff *skb)
>  {
> -	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
> +	const struct iphdr *iph = ip_hdr(skb);
> +
> +	if (fib4_has_custom_rules(net) ||
> +	    ipv4_is_lbcast(iph->daddr) ||
> +	    ipv4_is_zeronet(iph->daddr) ||
>  	    IPCB(skb)->flags & IPSKB_MULTIPATH)
>  		return NULL;
>  

seems ok to me.

Reviewed-by: David Ahern <dsahern@kernel.org>



