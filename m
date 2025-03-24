Return-Path: <netdev+bounces-177081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E625EA6DC8D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A86F3B2789
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE3C25F7A3;
	Mon, 24 Mar 2025 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jZjE5V4M"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11219C569;
	Mon, 24 Mar 2025 14:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825055; cv=none; b=SeF8vY7DDWLk1bTXCMF+Hf8CNPUJSpdW0pY+30tHwjoozAUL2v8gvy7eBrjLOTWevuA8OEoDXEnH7PV6WDvbf/ltLpJuveDHChaeWX0TW2yT1ZD2uTgCOhpFYf3iovBYhlfq/ncCRMeUuSNc6EoKTiFjJKU3SWy/NXDJW+y9YEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825055; c=relaxed/simple;
	bh=QZRyHaer4aVTsJACugml0QiF0ENOWqtGXsMcJVhuviY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaqDmx9/lucJv2OK/GfemCVgouVx73UIzi8y17rmRqAYkfZpPeC+3UtpyUA90Iaa1j4vhUbGsAm7BUG2BZmB27rPF4b3wEidyZfwrwoNjnAtglpKTLt6XYzwb9FBB1qz6Evl0ZGnHyY+E7f2BByBfrUJzs6uQH0RH3lqgI4NniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jZjE5V4M; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+reJuCbLkyPvkpR8TOLTyAMnNK1tq2tJBBQi3tYUQ9o=; b=jZjE5V4MBYSqGrnZjRfhUasREq
	M3aD0DMus0d84LKGN8je7NwmG+egyqT73PWJO1brt6wf3HqiXreND05BwZ5wCm0rR9yTdr63P8TY1
	eaEdYT2/5Nu0+f1Ilil4guY6OoX+Y/+rF/QFg2Atbbf65cRVbAgpJn59wt1IGy++Ojg4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1twiP9-006wSY-Ji; Mon, 24 Mar 2025 15:03:51 +0100
Date: Mon, 24 Mar 2025 15:03:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
Message-ID: <f0c685b0-b543-4038-a9bd-9db7fc00c808@lunn.ch>
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323225439.32400-1-ansuelsmth@gmail.com>

> Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> AS21210PB1 that all register with the PHY ID 0x7500 0x7500
> before the firmware is loaded.

Does the value change after the firmware is loaded? Is the same
firmware used for all variants?

> +++ b/drivers/net/phy/Kconfig
> @@ -121,6 +121,18 @@ config AMCC_QT2025_PHY
>  
>  source "drivers/net/phy/aquantia/Kconfig"
>  
> +config AS21XXX_PHY
> +	tristate "Aeonsemi AS21xxx PHYs"

The sorting is based on the tristate value, so that when you look at
'make menuconfig' the menu is in alphabetical order. So this goes
before aquantia.

> +/* 5 LED at step of 0x20
> + * FE: Fast-Ethernet (100)
> + * GE: Gigabit-Ethernet (1000)
> + * NG: New-Generation (2500/5000/10000)
> + * (Lovely ChatGPT managed to translate meaning of NG)

It might be a reference to NBase-T Gigabit.

Please add a comment somewhere about how locking works for IPCs. As
far as i see, the current locking scheme is that IPCs are only called
from probe, so no locking is actually required. But:

> +#define IPC_CMD_NG_TESTMODE		0x1b /* Set NG test mode and tone */
> +#define IPC_CMD_TEMP_MON		0x15 /* Temperature monitoring function */
> +#define IPC_CMD_SET_LED			0x23 /* Set led */

suggests IPCs might in the future be needed outside of probe, and then
a different locking scheme might be needed, particularly for
temperature monitoring.

> +static int as21xxx_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* AS21xxx supports 100M/1G/2.5G/5G/10G speed. */
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
> +			   phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +			   phydev->supported);
> +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> +			   phydev->supported);

Does this mean the registers genphy_read_abilities() reads are broken
and report link modes it does not actually support?

> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +			 phydev->supported);

and it is also not reporting modes it does actually support? Is
genphy_read_abilities() actually doing anything useful? Some more
comments would be good here.

> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +			 phydev->supported);

Does this mean genphy_c45_pma_read_abilities() also returns the wrong
values?

> +static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
> +{
> +	int status;
> +
> +	*bmcr = phy_read_mmd(phydev, MDIO_MMD_AN,
> +			     MDIO_AN_C22 + MII_BMCR);
> +	if (*bmcr < 0)
> +		return *bmcr;
> +
> +	/* Autoneg is being started, therefore disregard current
> +	 * link status and report link as down.
> +	 */
> +	if (*bmcr & BMCR_ANRESTART) {
> +		phydev->link = 0;
> +		return 0;
> +	}
> +
> +	status = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);

No MDIO_AN_C22 + here? Maybe add a comment about which C22 registers
are mapped into C45 space.

	Andrew

