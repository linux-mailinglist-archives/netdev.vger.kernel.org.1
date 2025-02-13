Return-Path: <netdev+bounces-165966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A429A33CFA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282061889629
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768CA212D8D;
	Thu, 13 Feb 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X/XnKPTb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE992054E4;
	Thu, 13 Feb 2025 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443886; cv=none; b=UHSCkJogeNweSZk9KsLCK8QTqDsdfZiIzh4Qgr6ZqXhOcLQgfNPQrVo15z9sT388XoJIoJLxj1vd8x0EcQeBu5qxap+KC8Q3BmyaFC1j6WA/SyZ8COkQHpyqScNVkX5S65T5IknKb88BcxT8wbKBeyz1eETptVIFgztmslVhF2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443886; c=relaxed/simple;
	bh=IF3pV7l7zOjvvG/0UDfuSxAlR8BVTLZ4GNjgKKSCkmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAe3ifnqdYgIZS1BKZPgN1EKQj8mq2AbzqBokUoyTvPQMdunBg9nWK5CZ11MhaXQWU7cBtqE0jDyNHLpShXnlzCTYw9WZjxfP11hNxCiximpY4+sh7C4pa0nVTueslx2uyOZPbnyEk1LybEmz0HukgIJVtvWzj7WQsBMLHGhbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X/XnKPTb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t+Sa1rIopsE4vpBI1kqaD2rohwmI2qAey/4fz9993mc=; b=X/XnKPTb2dokpBdeEwNhew0L1F
	B+I44FJ50CE/Xs7CxZGHDwJ3TH4O8+W6KA/hZvX1JiGnZrJ98HujZJ5ChNpcp5D8mGcow579YLpVz
	YG+kAlsPjl6AJmGrAu3vcY5995Z1q7UPL3liVu8qGcYnFAADjtNKz9jqMpC5tmJa1uMwvDV1w8nDT
	CH5VY8Wl05Nr88D/uNFQlJexL6u9uGZZsCMac8HELUEAAPkKifa8NhD3s2d4iVfZI4GlJQyWVI7W1
	bMONE0q26ZCGVLQC9RHn3HwC7rZsrzvWGClclXPZfh9NfEwlZ+xAlqLotpNyctkV3/K26wKepODna
	NV43mtww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51268)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tiWoK-0000pL-2u;
	Thu, 13 Feb 2025 10:51:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tiWoH-00024b-0u;
	Thu, 13 Feb 2025 10:51:09 +0000
Date: Thu, 13 Feb 2025 10:51:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Rosen Penev <rosenp@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, s-vadapalli@ti.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: phy: mscc: Add auto-negotiation feature to VSC8514
Message-ID: <Z63OnZTBMeAbzxrB@shell.armlinux.org.uk>
References: <20250213102150.2400429-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213102150.2400429-1-c-vankar@ti.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 13, 2025 at 03:51:50PM +0530, Chintan Vankar wrote:
> Add function vsc85xx_config_inband_aneg() in mscc_main.c to enable
> auto-negotiation. The function enables auto-negotiation by configuring
> the MAC SerDes PCS Control register of VSC8514.
> 
> Invoke the vsc85xx_config_inband_aneg() function from the
> vsc8514_config_init() function present in mscc_main.c to start the
> auto-negotiation process. This is required to get Ethernet working with
> the Quad port Ethernet Add-On card connected to J7 common processor board.

A few points:

1. please read the netdev FAQ:
   https://www.kernel.org/doc/html/v5.6/networking/netdev-FAQ.html
   specifically the first question. Please also note the delay
   requirement for resending patches.

2. Is this a fix? Does something not work at the moment?

3. Will always forcing the inband signalling to be enabled result in
   another existing user that doesn't provide the inband signalling
   now failing? Do you know for sure that this won't disrupt any other
   users of this PHY?

4. Maybe consider using phylink in the ethernet driver and populating
   the .inband_caps() and .config_inband() methods which will allow
   the inband signalling properties to be negotiated between the MAC's
   PCS and the PHY.

Other points inline below:

> +static int vsc85xx_config_inband_aneg(struct phy_device *phydev, bool enabled)
> +{
> +	u16 reg_val = 0;
> +	int rc;
> +
> +	if (enabled)
> +		reg_val = MSCC_PHY_SERDES_ANEG;
> +
> +	rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_3,
> +			      MSCC_PHY_SERDES_PCS_CTRL, MSCC_PHY_SERDES_ANEG,
> +			      reg_val);
> +
> +	return rc;

Why not simply:

	return phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_3,
				MSCC_PHY_SERDES_PCS_CTRL,
				MSCC_PHY_SERDES_ANEG,
				reg_val);

?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

