Return-Path: <netdev+bounces-115354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F2D945F2B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 16:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B87B216A1
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E746453368;
	Fri,  2 Aug 2024 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXcwHAF+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD064EEC3;
	Fri,  2 Aug 2024 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608138; cv=none; b=FiqKQfotFtNDlFGJfVKp/AUa9xsDgt935q2m2DsSse2i9jsYQlM1kXN+dx6w/w3d6Uhptnhtf8i/59X8qUqwDfN2Dd2KwVURDizv42/Nmq9Xln+jggRuzp8lyz60xwWPenRf//BI40wEu5MS8lmH0KkOM93N/Nu6Cxa0H/PHKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608138; c=relaxed/simple;
	bh=m7Y6Di23g7SkOV8aRpP2zGN3zxD8WgaWmWu7uNswhkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSVChDqasbn4XQkd4TB6PyOVlQzNIkwgTGPpBLy3zG4ZfiZQiMoTyvVMwkK6vnyDK+Cv54sf2ocLXsB/7PO9j/Xue7tAto+50YA1oYcLBVhTTvvxU5ukOQR1brAoGaaSQPmVY1xanLg///xlphrCti0NKjs9BKZTo/4QGAJ7VmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXcwHAF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CCDC32782;
	Fri,  2 Aug 2024 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608138;
	bh=m7Y6Di23g7SkOV8aRpP2zGN3zxD8WgaWmWu7uNswhkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iXcwHAF+9G8fepXOlBI2utRqIE5H+Asuk0HjM5Yi7KkAyLQ7KRip0tuD0oxuLH2/H
	 VgFlHs7uJReqKusGxDkzMDqSTOg1kfQna22WogPwRoRBOw6nTs/Zh1GeDVv8HsyC2v
	 w05Ba4iZjreC4DTfyOyE/SHRJdkjr4MuxQuzSyVlkEZHo4VinZyXPVTcwZOAagdc1K
	 L2+jqejvXzUWzOnXYrPb9QOsWJI0ePJ1CtC/KsXdnC+rH7N7Q40EqpET225MEj2wJn
	 uuTk3AIQm5lunR8PQFwJJM4dwHww8Sn+7GLFMTVxwCxrC+hf2RBPgF88t0wdC2X9OS
	 qaQgXOv5DDE3g==
Date: Fri, 2 Aug 2024 15:15:34 +0100
From: Simon Horman <horms@kernel.org>
To: Moon Yeounsu <yyyynoom@gmail.com>
Cc: cooldavid@cooldavid.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: use ip_hdrlen() instead of bit shift
Message-ID: <20240802141534.GA2504122@kernel.org>
References: <20240802054421.5428-1-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802054421.5428-1-yyyynoom@gmail.com>

On Fri, Aug 02, 2024 at 02:44:21PM +0900, Moon Yeounsu wrote:
> `ip_hdr(skb)->ihl << 2` are the same as `ip_hdrlen(skb)`
> Therefore, we should use a well-defined function not a bit shift
> to find the header length.
> 
> It also compress two lines at a single line.
> 
> Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>

Firstly, I think this clean-up is both correct and safe.  Safe because
ip_hdrlen() only relies on ip_hdr(), which is already used in the same code
path. And correct because ip_hdrlen multiplies ihl by 4, which is clearly
equivalent to a left shift of 2 bits.

However, I do wonder about the value of clean-ups for what appears to be a
very old driver, which hasn't received a new feature for quite sometime

And further, I wonder if we should update this driver from "Maintained" to
"Odd Fixes" as the maintainer, "Guo-Fu Tseng" <cooldavid@cooldavid.org>,
doesn't seem to have been seen by lore since early 2020.

https://lore.kernel.org/netdev/20200219034801.M31679@cooldavid.org/

> ---
>  drivers/net/ethernet/jme.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
> index b06e24562973..83b185c995df 100644
> --- a/drivers/net/ethernet/jme.c
> +++ b/drivers/net/ethernet/jme.c
> @@ -946,15 +946,13 @@ jme_udpsum(struct sk_buff *skb)
>  	if (skb->protocol != htons(ETH_P_IP))
>  		return csum;
>  	skb_set_network_header(skb, ETH_HLEN);
> +
>  	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
> -	    (skb->len < (ETH_HLEN +
> -			(ip_hdr(skb)->ihl << 2) +
> -			sizeof(struct udphdr)))) {
> +	    (skb->len < (ETH_HLEN + (ip_hdrlen(skb)) + sizeof(struct udphdr)))) {

The parentheses around the call to ip_hdrlen are unnecessary.
And this line is now too long: networking codes till prefers
code to be 80 columns wide or less.

>  		skb_reset_network_header(skb);
>  		return csum;
>  	}
> -	skb_set_transport_header(skb,
> -			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
> +	skb_set_transport_header(skb, ETH_HLEN + (ip_hdrlen(skb)));

Unnecessary parentheses here too.

>  	csum = udp_hdr(skb)->check;
>  	skb_reset_transport_header(skb);
>  	skb_reset_network_header(skb);

-- 
pw-bot: cr

