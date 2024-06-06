Return-Path: <netdev+bounces-101215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5681B8FDC68
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 04:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F2C286525
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6695114AB8;
	Thu,  6 Jun 2024 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PU0XbLoR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1F440C;
	Thu,  6 Jun 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717639201; cv=none; b=i5Hq+MUPA18ncA7Hsj8imtYR03Bxl7XmYSXYQ6LUMrdl5tPO0c+SrJPCSmCqO9brtAnNVOrCaNN6T4i/pbVYF0zIXR2XzOAAwj6eKJPoKkU2x8imYVgxqHf2CZkKK/4KN+wm4Un4sE5ZXw83walpSi8LQ/ii/lU2TtMds6jnxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717639201; c=relaxed/simple;
	bh=UUaR2Lwz2qnXHZMhM8gEdFJFzvFKdLYjI37xtcCj1qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtRRj3crtgcqqJMT3dF4mkIDNDNUXoU+EtZMUjbEUa0yQ3K22H6y98WN5suj6VE9H6BgcyPxbdbCqM1zuwQzRH2MYQQooH9hxLetUjIi2TivvqpJXae63//xt4r3xNaG+qzVPge0xlochIJ/Jg0aP7OuFhZmg0EKiifyioNJhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PU0XbLoR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YQ0LTYNoImIQLOiX4Ut70Gj7/HKQ9yGsF/aiJ4r9GjA=; b=PU0XbLoRMasZlTwkSvHIPeds/T
	S5KJF4e5JFqfPY0Boe6NxjIIE2uk9ZwJtUiIbCsOoVwId2B6VybC6iIKjnqV6BBkFipASBlib9+/v
	NDHPllThHPw1fQN2tYbw+Jiw/dcXSBYmsh5nUTvarFPFUoUkNYaX9SaRyoIIsxnSgczs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sF2Pp-00Gxwy-I5; Thu, 06 Jun 2024 03:59:45 +0200
Date: Thu, 6 Jun 2024 03:59:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v3 3/4] net: macb: Add ARP support to WOL
Message-ID: <901ec7a8-7460-492e-8f50-6d339a987020@lunn.ch>
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
 <20240605102457.4050539-4-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605102457.4050539-4-vineeth.karumanchi@amd.com>

> @@ -3278,13 +3280,11 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  {
>  	struct macb *bp = netdev_priv(netdev);
>  
> -	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) {
> -		phylink_ethtool_get_wol(bp->phylink, wol);
> -		wol->supported |= WAKE_MAGIC;
> -
> -		if (bp->wol & MACB_WOL_ENABLED)
> -			wol->wolopts |= WAKE_MAGIC;
> -	}
> +	phylink_ethtool_get_wol(bp->phylink, wol);

So you ask the PHY what it supports, and what it currently has
enabled.

> +	wol->supported |= (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ? WAKE_MAGIC : 0;
> +	wol->supported |= (bp->wol & MACB_WOL_HAS_ARP_PACKET) ? WAKE_ARP : 0;

You mask in what the MAC supports.

> +	/* Pass wolopts to ethtool */
> +	wol->wolopts = bp->wolopts;

And then you overwrite what the PHY is currently doing with
bp->wolopts.

Now, if we look at what macb_set_wol does:

> @@ -3300,11 +3300,10 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  	if (!ret || ret != -EOPNOTSUPP)
>  		return ret;
>

We are a little bit short of context here. This is checking the return
value of:

	ret = phylink_ethtool_set_wol(bp->phylink, wol);

So if there is no error, or an error which is not EOPNOTSUPP, it
returns here. So if the PHY supports WAKE_MAGIC and/or WAKE_ARP, there
is nothing for the MAC to do. Importantly, the code below which sets
bp->wolopts is not reached.

So your get_wol looks wrong.

> -	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
> -	    (wol->wolopts & ~WAKE_MAGIC))
> -		return -EOPNOTSUPP;
> +	bp->wolopts = (wol->wolopts & WAKE_MAGIC) ? WAKE_MAGIC : 0;
> +	bp->wolopts |= (wol->wolopts & WAKE_ARP) ? WAKE_ARP : 0;
>  
> -	if (wol->wolopts & WAKE_MAGIC)
> +	if (bp->wolopts)
>  		bp->wol |= MACB_WOL_ENABLED;
>  	else
>  		bp->wol &= ~MACB_WOL_ENABLED;
> @@ -5085,10 +5084,8 @@ static int macb_probe(struct platform_device *pdev)
>  	else
>  		bp->max_tx_length = GEM_MAX_TX_LEN;
>  

> @@ -5257,6 +5255,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  		return 0;
>  
>  	if (bp->wol & MACB_WOL_ENABLED) {
> +		/* Check for IP address in WOL ARP mode */
> +		ifa = rcu_dereference(__in_dev_get_rcu(bp->dev)->ifa_list);
> +		if ((bp->wolopts & WAKE_ARP) && !ifa) {
> +			netdev_err(netdev, "IP address not assigned\n");
> +			return -EOPNOTSUPP;
> +		}

I don't know suspend too well. Is returning an error enough abort the
suspend?

	Andrew

