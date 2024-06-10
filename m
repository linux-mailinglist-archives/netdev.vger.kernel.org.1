Return-Path: <netdev+bounces-102262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C1B9021D9
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305EEB21FE5
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6C80607;
	Mon, 10 Jun 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BwVfcNT6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C986F7E576;
	Mon, 10 Jun 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023584; cv=none; b=G7Mge9CPS1Fxb5WLkG3Gq8TilZN8Yof4hoBLGSX26DR5JLI1/iitfejYDcQqnMzl7jPmqSzA2E6c2pUm4YRl9HRKt4neEIRyTGDVNAJ6ypNLOGhSqxzCimVdiEdvo0QPlqIPL2kO8UnYvxkvojG3nw0lJHFuISAVv6rq4PYJfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023584; c=relaxed/simple;
	bh=1KSrYV9LSAMiVSDqg4YllA/qK2mV4TYwx0hJ+/HkKLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2TEGWkrQL1o62qNslenOWIj6Lrp8F8RIXV6gQXOSDFV84Tymv/MO3C9jnkY7ymobOWvyZPdWH5onfhLzu/LocEzWCJHfJMWYOBH3n56r8Y6iIWZMYws5a7uYvI59+mdISMdptrBer7ZgoYtEvjGvmZ1BkrZNxLgXMX6S5I6Tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BwVfcNT6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bN/MqI/H7ST5s3XZJ2g/NEy+WWWfgWgz/Insw+RA3PA=; b=BwVfcNT6d9uK+bJOp8evPMyN3M
	Aoi5RqklnpHf7t6Xbf+RFXQdS4BMeQ5EHqxTtbQJA+hDCjY27zmkG9wythBzIaj+6rffWvt8/7Xcw
	j0tp9VGMcW4LIQDvCAz7xuGoFlDfbfoj5mJdJgVxV0fmnf4wsgW7i53lKO/CaE20z1jI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sGePX-00HISO-TM; Mon, 10 Jun 2024 14:46:07 +0200
Date: Mon, 10 Jun 2024 14:46:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux@armlinux.org.uk, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v4 3/4] net: macb: Add ARP support to WOL
Message-ID: <b46427d8-2b8c-4b26-b53a-6dcc3d0ea27f@lunn.ch>
References: <20240610053936.622237-1-vineeth.karumanchi@amd.com>
 <20240610053936.622237-4-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610053936.622237-4-vineeth.karumanchi@amd.com>

> @@ -3294,22 +3292,15 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
>  
>  	/* Pass the order to phylink layer */
>  	ret = phylink_ethtool_set_wol(bp->phylink, wol);
> -	/* Don't manage WoL on MAC if handled by the PHY
> -	 * or if there's a failure in talking to the PHY
> -	 */
> -	if (!ret || ret != -EOPNOTSUPP)
> +	/* Don't manage WoL on MAC if there's a failure in talking to the PHY */
> +	if (!!ret && ret != -EOPNOTSUPP)
>  		return ret;

The comment is wrong. You could be happily talking to the PHY, it just
does not support what you asked it to do.

> @@ -5257,6 +5247,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
>  		return 0;
>  
>  	if (bp->wol & MACB_WOL_ENABLED) {
> +		/* Check for IP address in WOL ARP mode */
> +		ifa = rcu_dereference(__in_dev_get_rcu(bp->dev)->ifa_list);
> +		if ((bp->wolopts & WAKE_ARP) && !ifa) {
> +			netdev_err(netdev, "IP address not assigned\n");

"IP address not assigned" on its own does not give a user whos suspend
fails a very good idea why.  "IP address not assigned as required by
WoL walk ARP" would be better.


    Andrew

---
pw-bot: cr

