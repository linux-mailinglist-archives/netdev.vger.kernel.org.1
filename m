Return-Path: <netdev+bounces-149369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 514489E54CC
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7405816ABC7
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9921771F;
	Thu,  5 Dec 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OtigY0H6"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08099217643;
	Thu,  5 Dec 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400047; cv=none; b=W56pAMvBxFjpowX5wLn7mQ1kqQpXmYI0oED6Bj4DnDrY58u/fjhYRBrqeLU4pCUwdMb369FjkcN0cW/KUTOkvpk26IjJ+9knbkrZlm0uMNxXAICI54QNMTq8Gh+JtEWQSmlr9PTUJ53JZHagwXBY8exk4Y+hiLdobBPSYMqf4gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400047; c=relaxed/simple;
	bh=rttFMm5kMnZrxU5EMle2zdqqkrFEu0NuBMm1C9Q5uUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4lsUV6B1DmKE8bL5sBL33ZMmPmMvCq3OTYATq+VrdKBUyiqiNZPBIBwTsKGo/XtN4c6xAlehqAhN5CJEwybaXYhIR4t+4/NegSNv0puXVkbH4+TDcmJCyRnfkW66apZEsFLKbEE2t3wHxRCZlfcW5t7FP7/Sv4xUpvirZTQSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OtigY0H6; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HsNXSjPnsOI9vNbgqxtYP3UXdwyVqEVl44CHRXepZI0=; b=OtigY0H605WikV5hVOm6qPluCM
	wfVRPVYMiOr+KLLMIebOswK+ldRcWBUj/wV00qxozp9mHYWk1qqhv/CVeIsOyXUs4gKx4Roj3I0Cp
	6ClQy7zHZzMSiXhEpdmYL78qb/Tsgl2YNHGdnnrTVL1exABi2Ntjj4bSl/4L5Gq+N7rjjD6fZrR4s
	2qUBli8SYsHpJS4iF2Oncw47F5Mnofzo+U3VacyxfEg+PxklQsCJbAp3oPSe2x7r3+dOr3BR0lqNn
	UNBvco+mxQPaPzRfzUg+r2tv1zVOW/C4RA6GMNck697clyb6SG+wmMtEqJ3R9FfSsDR9jQ7vsJIna
	Su4p85Bg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36680)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tJAWy-0004ih-07;
	Thu, 05 Dec 2024 12:00:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tJAWv-0006Wa-1D;
	Thu, 05 Dec 2024 12:00:25 +0000
Date: Thu, 5 Dec 2024 12:00:25 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/7] net: ethtool: add support for structured
 PHY statistics
Message-ID: <Z1GV2cY_LFH7mcAn@shell.armlinux.org.uk>
References: <20241203075622.2452169-1-o.rempel@pengutronix.de>
 <20241203075622.2452169-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203075622.2452169-3-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 03, 2024 at 08:56:16AM +0100, Oleksij Rempel wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Introduce a new way to report PHY statistics in a structured and
> standardized format using the netlink API. This new method does not
> replace the old driver-specific stats, which can still be accessed with
> `ethtool -S <eth name>`. The structured stats are available with
> `ethtool -S <eth name> --all-groups`.
> 
> This new method makes it easier to diagnose problems by organizing stats
> in a consistent and documented way.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
...
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 523195c724b5..20a0d43ab5d4 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1097,7 +1097,8 @@ struct phy_driver {
>  	 * must only set statistics which are actually collected by the device.
>  	 */
>  	void (*get_phy_stats)(struct phy_device *dev,
> -			      struct ethtool_eth_phy_stats *eth_stats);
> +			      struct ethtool_eth_phy_stats *eth_stats,
> +			      struct ethtool_phy_stats *stats);

So we introduce a new function pointer in patch 1, and then change its
prototype in patch 2... wouldn't it be better to introduce the new
structure in patch 1, and then the function pointer in the next patch?

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

