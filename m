Return-Path: <netdev+bounces-118486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BB8951BFF
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F7B1C2103D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5618D1B1405;
	Wed, 14 Aug 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKppiM8T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5861AE86B;
	Wed, 14 Aug 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642616; cv=none; b=pOoWavOyBOk8tQGhCfqte0vyH8yPkPDQX6wU2L6I76orjTgOf/lL07MGvMyrDbjDwjsSfDoEQxcC7GF8h0xczcA7snelloCHg1kErmFdEDGO47Ncfcep7+l1mpef3JHoW/BSAGlUqMMGzx1dSwTK1D3v22IEnBQMfmgfIftaIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642616; c=relaxed/simple;
	bh=AfZwoXYyHlaI4AyS0IHIY7OBojZ3hrhEHOAmUSWTFSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7VXvVcqVL+ogABelbsI5I6UlOJqFdIsixAEKeByBQEEHHFCOMOX2/otGekXiI1Jb6tnc6UpdFqnvOz7uXI5WIkGq9C6puJdayaJu0LnCM79HQN6BnB60LPbOfhwgSktVfgiMlGBLfjQ1t1kXFCn3y5X2GahFvFm8YHz8lCvtTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKppiM8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EF0C32786;
	Wed, 14 Aug 2024 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723642616;
	bh=AfZwoXYyHlaI4AyS0IHIY7OBojZ3hrhEHOAmUSWTFSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKppiM8TI7lg9JcPCqT3Sn2s7Dbo55T0W+E2BmfhSpBkLZPy8I8QGQnz/vSKybnXK
	 E9lR4jrEmyE2rA+inP9wlEDEa0HG5ToUIFQ26LAzmitN9b9ZdFMMJgA22e1nn8skwx
	 1AH+5YWgdWXAALyM4BX1Nin1y1z/GOm6GaBAXiL3t2hDhzOB86YOhN++iFjviAU7tk
	 5wxCnVXr2UAA/xr8/UCZU8J+R3RNH4nsK3R5AHvwPMsjwYzmD94nUK033aeUcwN8y1
	 gDZUksJo3wa1LJ4IDhtx1Pubx97ppcalgz8tjGGf+vwhwif+p4852NDC149g7lqYkA
	 HEvFRtp8VV80w==
Date: Wed, 14 Aug 2024 14:36:51 +0100
From: Simon Horman <horms@kernel.org>
To: Nils Fuhler <nils@nilsfuhler.de>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ip6: ndisc: fix incorrect forwarding of proxied ns
 packets
Message-ID: <20240814133651.GA322002@kernel.org>
References: <20240814123105.8474-2-nils@nilsfuhler.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814123105.8474-2-nils@nilsfuhler.de>

On Wed, Aug 14, 2024 at 02:31:06PM +0200, Nils Fuhler wrote:
> When enabling proxy_ndp per interface instead of globally, neighbor
> solicitation packets sent to proxied global unicast addresses are
> forwarded instead of generating a neighbor advertisement. When
> proxy_ndp is enabled globally, these packets generate na responses as
> expected.
> 
> This patch fixes this behaviour. When an ns packet is sent to a
> proxied unicast address, it generates an na response regardless
> whether proxy_ndp is enabled per interface or globally.
> 
> Signed-off-by: Nils Fuhler <nils@nilsfuhler.de>
> ---
>  net/ipv6/ip6_output.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index ab504d31f0cd..13eaacc5a747 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -551,8 +551,8 @@ int ip6_forward(struct sk_buff *skb)
>  		return -ETIMEDOUT;
>  	}
>  
> -	/* XXX: idev->cnf.proxy_ndp? */
> -	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> +	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> +	     READ_ONCE(idev->cnf.proxy_ndp)) &&

Hi Nils,

Earlier in this function it is assumed that idev may be NULL,
I think you need to take that into account here too.

Flagged by Smatch.

If you do post an update, please be sure to wait 24h before doing so.
https://docs.kernel.org/process/maintainer-netdev.html

>  	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev, 0)) {
>  		int proxied = ip6_forward_proxy_check(skb);
>  		if (proxied > 0) {
> -- 
> 2.39.2
> 
> 

