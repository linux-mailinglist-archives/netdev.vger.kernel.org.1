Return-Path: <netdev+bounces-248286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DACADD067BD
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 23:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09B8530213EA
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 22:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8B3382EE;
	Thu,  8 Jan 2026 22:56:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6BB328B47
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 22:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913001; cv=none; b=cTog/spLzqZ+CVV1uFwo5z2EHA8Dr2R2Z68/2jc2m3WuTWkomtihv5IRxGyLh+AzmTEZT4DCAjenRxKaKC+x8gWMPLgPsbDNrzsenx5iyI0s2prcp+rhVVBR34x1q0giywGhiZGUONhOs+stjfIqSfKYCkYlp9jGc2lIGlpZTew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913001; c=relaxed/simple;
	bh=nGMlZKbaT2wJPsdQEzeuGC0jIw1FU2Of7eJDNgpQcK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MN1k7E+GfGlFA3eVtIb3nn3hidNrzkpxeF5GuWzKnMWx1vginpVGrlBQxruKR8Y+jjcxifL6IxUU0xMNWEChB9G33rw2sSRJv+k/71x9ks7Z+stO5nP3BYDzTqPnaj1Maspv5g41g6Q80zZo+c1yHnvA41BAt9AK+7YfPkoVzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vdyvV-000000004w2-3jaR;
	Thu, 08 Jan 2026 22:56:21 +0000
Date: Thu, 8 Jan 2026 22:56:14 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Fabio Baltieri <fabio.baltieri@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
Message-ID: <aWA2DswjBcFWi8eA@makrotopia.org>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
 <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>

On Thu, Jan 08, 2026 at 09:27:06PM +0100, Heiner Kallweit wrote:
> RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
> DAC). The list of supported modes was provided by Realtek. According to the
> r8127 vendor driver also 1G modules are supported, but this needs some more
> complexity in the driver, and only 10G mode has been tested so far.
> Therefore mainline support will be limited to 10G for now.
> The SFP port signals are hidden in the chip IP and driven by firmware.
> Therefore mainline SFP support can't be used here.
> This PHY driver is used by the RTL8127ATF support in r8169.
> RTL8127ATF reports the same PHY ID as the TP version. Therefore use a dummy
> PHY ID.  This PHY driver is used by the RTL8127ATF support in r8169.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  MAINTAINERS                            |  1 +
>  drivers/net/phy/realtek/realtek_main.c | 54 ++++++++++++++++++++++++++
>  include/linux/realtek_phy.h            |  7 ++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 include/linux/realtek_phy.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 765ad2daa21..6ede656b009 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9416,6 +9416,7 @@ F:	include/linux/phy_link_topology.h
>  F:	include/linux/phylib_stubs.h
>  F:	include/linux/platform_data/mdio-bcm-unimac.h
>  F:	include/linux/platform_data/mdio-gpio.h
> +F:	include/linux/realtek_phy.h
>  F:	include/trace/events/mdio.h
>  F:	include/uapi/linux/mdio.h
>  F:	include/uapi/linux/mii.h
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index eb5b540ada0..b57ef0ce15a 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -16,6 +16,7 @@
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
> +#include <linux/realtek_phy.h>
>  #include <linux/string_choices.h>
>  
>  #include "../phylib.h"
> @@ -2100,6 +2101,45 @@ static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
>  	return IRQ_HANDLED;
>  }
>  
> +static int rtlgen_sfp_get_features(struct phy_device *phydev)
> +{
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> +			 phydev->supported);
> +
> +	/* set default mode */
> +	phydev->speed = SPEED_10000;
> +	phydev->duplex = DUPLEX_FULL;
> +
> +	phydev->port = PORT_FIBRE;
> +
> +	return 0;
> +}
> +
> +static int rtlgen_sfp_read_status(struct phy_device *phydev)
> +{
> +	int val, err;
> +
> +	err = genphy_update_link(phydev);
> +	if (err)
> +		return err;
> +
> +	if (!phydev->link)
> +		return 0;
> +
> +	val = rtlgen_read_vend2(phydev, RTL_VND2_PHYSR);

This should be the same as
phy_read(phydev, MII_RESV2); /* on page 0 */
Please try.


> +	if (val < 0)
> +		return val;
> +
> +	rtlgen_decode_physr(phydev, val);
> +
> +	return 0;
> +}
> +
> +static int rtlgen_sfp_config_aneg(struct phy_device *phydev)
> +{
> +	return 0;
> +}
> +
>  static struct phy_driver realtek_drvs[] = {
>  	{
>  		PHY_ID_MATCH_EXACT(0x00008201),
> @@ -2361,6 +2401,20 @@ static struct phy_driver realtek_drvs[] = {
>  		.write_page	= rtl821x_write_page,
>  		.read_mmd	= rtl822x_read_mmd,
>  		.write_mmd	= rtl822x_write_mmd,
> +	}, {
> +		PHY_ID_MATCH_EXACT(PHY_ID_RTL_DUMMY_SFP),
> +		.name		= "Realtek SFP PHY Mode",
> +		.flags		= PHY_IS_INTERNAL,
> +		.probe		= rtl822x_probe,
> +		.get_features	= rtlgen_sfp_get_features,
> +		.config_aneg	= rtlgen_sfp_config_aneg,
> +		.read_status	= rtlgen_sfp_read_status,
> +		.suspend	= genphy_suspend,
> +		.resume		= rtlgen_resume,
> +		.read_page	= rtl821x_read_page,
> +		.write_page	= rtl821x_write_page,
> +		.read_mmd	= rtl822x_read_mmd,
> +		.write_mmd	= rtl822x_write_mmd,
>  	}, {
>  		PHY_ID_MATCH_EXACT(0x001ccad0),
>  		.name		= "RTL8224 2.5Gbps PHY",
> diff --git a/include/linux/realtek_phy.h b/include/linux/realtek_phy.h
> new file mode 100644
> index 00000000000..d683bc1b065
> --- /dev/null
> +++ b/include/linux/realtek_phy.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _REALTEK_PHY_H
> +#define _REALTEK_PHY_H
> +
> +#define	PHY_ID_RTL_DUMMY_SFP	0x001ccbff
> +
> +#endif /* _REALTEK_PHY_H */
> -- 
> 2.52.0
> 
> 

