Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA6B741390
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjF1OR5 (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 10:17:57 -0400
Received: from vps0.lunn.ch ([156.67.10.101]:40100 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231494AbjF1ORv (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 10:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=k3suBQGB6dhKNJE7WpWQ+BzXLEWRoMzvBu3IwZiS1/I=; b=MfeRR2yZ+Mbu0ybDYiZIqlvFLe
        7SMy89sz3/oNFPU/ksfQdopXqAkaQBi8wrG7iHgSDy1FkuAzrIaf8/CozhE3xZNPLlsb4SKpgnr2/
        HA8liQci03v2jmq45zzRdSIfs/odwhgpYRfbJqa2Ux7pG1YrHfc1ROs/fNb8TIJriWn4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEVzP-0007hs-MG; Wed, 28 Jun 2023 16:17:47 +0200
Date:   Wed, 28 Jun 2023 16:17:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Revanth Kumar Uppala <ruppala@nvidia.com>
Cc:     linux@armlinux.org.uk, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-tegra@vger.kernel.org,
        Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH 4/4] net: phy: aqr113c: Enable Wake-on-LAN (WOL)
Message-ID: <c1aedb1e-e750-40ce-a19a-dfb21e2a971f@lunn.ch>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-4-ruppala@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124326.55732-4-ruppala@nvidia.com>
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

> +static int aqr113c_wol_enable(struct phy_device *phydev)
> +{
> +	struct aqr107_priv *priv = phydev->priv;
> +	u16 val;
> +	int ret;
> +
> +	/* Disables all advertised speeds except for the WoL
> +	 * speed (100BASE-TX FD or 1000BASE-T)
> +	 * This is set as per the APP note from Marvel
> +	 */
> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> +			       MDIO_AN_LD_LOOP_TIMING_ABILITY);
> +	if (ret < 0)
> +		return ret;

Please take a look at phylink_speed_down() and
phylink_speed_up(). Assuming the PHY is not reporting it can do 10Full
and 10Half, it should end up in 100BaseFull. Assuming the link partner
can do 100BaseFull....

Russell points out you are making a lot of assumptions about the
system side link. Ideally, you want to leave that to the PHY. Once the
auto-neg at the lower speed has completed, it might change the system
side link, e.g. to SGMII and the normal machinery should pass that
onto the MAC, so it can follow. I would not force anything.

> @@ -619,6 +784,31 @@ static int aqr107_config_init(struct phy_device *phydev)
>  	if (ret < 0)
>  		return ret;
>  
> +	/* Configure Magic packet frame pattern (MAC address) */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_C22EXT, MDIO_C22EXT_MAGIC_PKT_PATTERN_0_2_15,
> +			    phydev->attached_dev->dev_addr[0] |
> +			    (phydev->attached_dev->dev_addr[1] << 8));

I think most PHY drivers do this as part of enabling WOL. Doing it in
aqr107_config_init() is early, is the MAC address stable yet? The user
could change it. It could still be changed after wol is enabled, but
at least the user has a clear point in time when WoL configuration
happens.

> +static void aqr113c_get_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> +{
> +	int val;
> +
> +	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_RSVD_VEND_STATUS3);
> +	if (val < 0)
> +		return;
> +
> +	wol->supported = WAKE_MAGIC;
> +	if (val & 0x1)
> +		wol->wolopts = WAKE_MAGIC;

WoL seems to be tried to interrupts. So maybe you should actually
check an interrupt is available? This is not going to work if the PHY
is being polled. It does however get a bit messy, some boards might
connect the 'interrupt' pin to PMIC. So there is not a true interrupt,
but the PMIC can turn the power back on.

    Andrew
