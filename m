Return-Path: <netdev+bounces-161277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5580A2074A
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 10:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05D71881E44
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDB1DFD95;
	Tue, 28 Jan 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W+T/B/UR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A01DEFDD;
	Tue, 28 Jan 2025 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056306; cv=none; b=qsXz42jzii6k99Yxl9iyrRN9viBiPU/wLKLirc6FaqkvTPLbN1OpSqDW9fWC0rH9+qeFdLbvJMcWHYpQXA8nvl1dwyBm0itWxceapBl9JVpWvFOYTuE9euvSdnGT9eA0g4BN6n66HKq4HEUizxqCXocnNfqwzML60pacF4zE4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056306; c=relaxed/simple;
	bh=2MCFZ9wpB8587gKey2myseV/3R+kG6yxRK4OLLNsB2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPv2U66fPkmGpnx7VsT9lv0E3sLXqe7mf2u5Lk/o3NjbpST8eduRZUeBv5yryEB5F/2L4VbrycjrA+CDHBKgJgx85+lXs614H3gzAoLIxMYGnM5xfP4l6EpYQWXJEjwu11ErbcvQbglMQRDeBARQAy6bFPrYL2PJFrxsbxmN4w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=W+T/B/UR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F/mLp4/rZVhTMvAhm2DU4sz8gpzZbWxkS6yKSksgN2M=; b=W+T/B/URc1KDzvOZrUcVZW2HJA
	nHcUtkb/Em+pWMD3OZ+HmagE/9l/qYxwyYMyHhLab6L+kZ42+MOc0fTiJwLEDnrwxhq2foAS49kYz
	A0x+lZ/0Zpi0gJpSBIIjDIAYMghg06ckSiPRggKda0Ia6/AN2uUvXbZRrQT4hS7UGqK2sxEnUuDIh
	GGjnQj8EQIURj7xPO9cQJp2GsQkZsDIhjWW2LrMys3UCaV5Uf1QQUnsyfwmTpd7ZeVcfe68fl9rlz
	R6XRLSR370wmwbdLuVL1TVdRgbG2tCSkJ2u3x2Tdfcbs/ygidEUxBfwHZwEr0ZFOjzPK5u2vqwCAL
	fZyckJWA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36220)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tchpx-0006mg-2X;
	Tue, 28 Jan 2025 09:24:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tchpt-0002Wd-2T;
	Tue, 28 Jan 2025 09:24:45 +0000
Date: Tue, 28 Jan 2025 09:24:45 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128033226.70866-2-Tristram.Ha@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 27, 2025 at 07:32:25PM -0800, Tristram.Ha@microchip.com wrote:
> For 1000BaseX mode setting neg_mode to false works, but that does not
> work for SGMII mode.  Setting 0x18 value in register 0x1f8001 allows
> 1000BaseX mode to work with auto-negotiation enabled.

I'm not sure (a) exactly what the above paragraph is trying to tell me,
and (b) why setting the AN control register to 0x18, which should only
affect SGMII, has an effect on 1000BASE-X.

Note that a config word formatted for SGMII can result in a link with
1000BASE-X to come up, but it is not correct. So, I highly recommend you
check the config word sent by the XPCS to the other end of the link.
Bit 0 of that will tell you whether it is SGMII-formatted or 802.3z
formatted.

> However SGMII mode in KSZ9477 has a bug in which the current speed
> needs to be set in MII_BMCR to pass traffic.  The current driver code
> does not do anything when link is up with auto-negotiation enabled, so
> that code needs to be changed for KSZ9477.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
>  drivers/net/pcs/pcs-xpcs.c   | 52 ++++++++++++++++++++++++++++++++++--
>  drivers/net/pcs/pcs-xpcs.h   |  2 ++
>  include/linux/pcs/pcs-xpcs.h |  6 +++++
>  3 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 1faa37f0e7b9..ddf6cd4b37a7 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -768,6 +768,14 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
>  		val |= DW_VR_MII_AN_INTR_EN;
>  	}
>  
> +	if (xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ &&
> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> +		mask |= DW_VR_MII_SGMII_LINK_STS | DW_VR_MII_TX_CONFIG_MASK;
> +		val |= FIELD_PREP(DW_VR_MII_TX_CONFIG_MASK,
> +				  DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII);
> +		val |= DW_VR_MII_SGMII_LINK_STS;
> +	}
> +
>  	ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_CTRL, mask, val);
>  	if (ret < 0)
>  		return ret;
> @@ -982,6 +990,15 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
>  	if (ret < 0)
>  		return ret;
>  
> +	/* DW_VR_MII_AN_STS_C37_ANCMPLT_INTR just means link change in SGMII
> +	 * mode, so needs to be cleared.  It can appear just by itself, which
> +	 * does not mean the link is up.
> +	 */
> +	if (xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ &&
> +	    (ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR)) {
> +		ret &= ~DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
> +		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
> +	}

*_get_state() is not an interrupt acknowledgement function. It isn't
_necessarily_ called when an interrupt has happened, and it will be
called "sometime after" the interrupt has been handled as it's called
from an entirely separate workqueue.

Would it be better to just ignore the block following:

	} else if (ret == DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {

instead? I'm not sure that block of code/if statement was correct,
and was added in "net: pcs: xpcs: adapt Wangxun NICs for SGMII mode".

>  	if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
>  		int speed_value;
>  
> @@ -1037,6 +1054,18 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
>  {
>  	int lpa, bmsr;
>  
> +	/* DW_VR_MII_AN_STS_C37_ANCMPLT_INTR just means link change, so needs
> +	 * to be cleared.  If polling is not used then it is cleared by
> +	 * following code.
> +	 */
> +	if (xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ && xpcs->pcs.poll) {
> +		int val;
> +
> +		val = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS);
> +		if (val & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR)
> +			xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS,
> +				   0);
> +	}

Same concerns.

>  	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>  			      state->advertising)) {
>  		/* Reset link state */
> @@ -1138,9 +1167,14 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
>  					 phy_interface_t interface,
>  					 int speed, int duplex)
>  {
> +	u16 val = 0;
>  	int ret;
>  
> -	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> +	/* Microchip KSZ SGMII implementation has a bug that needs MII_BMCR
> +	 * register to be updated with current speed to pass traffic.
> +	 */
> +	if (xpcs->quirk != DW_XPCS_QUIRK_MICROCHIP_KSZ &&

	if (!(xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ &&
	      interface != PHY_INTERFACE_MODE_SGMII) &&

> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
>  		return;
>  
>  	if (interface == PHY_INTERFACE_MODE_1000BASEX) {
> @@ -1155,10 +1189,18 @@ static void xpcs_link_up_sgmii_1000basex(struct dw_xpcs *xpcs,
>  			dev_err(&xpcs->mdiodev->dev,
>  				"%s: half duplex not supported\n",
>  				__func__);
> +
> +		/* No need to update MII_BMCR register if not in SGMII mode. */
> +		if (xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ &&
> +		    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> +			return;

then you don't need this.

>  	}
>  
> +	if (xpcs->quirk == DW_XPCS_QUIRK_MICROCHIP_KSZ &&
> +	    neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> +		val = BMCR_ANENABLE;
>  	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
> -			 mii_bmcr_encode_fixed(speed, duplex));
> +			 val | mii_bmcr_encode_fixed(speed, duplex));

I think in this case, I'd prefer this to just modify the speed and
duplex bits rather than writing the whole register.

>  	if (ret)
>  		dev_err(&xpcs->mdiodev->dev, "%s: xpcs_write returned %pe\n",
>  			__func__, ERR_PTR(ret));
> @@ -1563,5 +1605,11 @@ void xpcs_destroy_pcs(struct phylink_pcs *pcs)
>  }
>  EXPORT_SYMBOL_GPL(xpcs_destroy_pcs);
>  
> +void xpcs_set_quirk(struct dw_xpcs *xpcs, int quirk)
> +{
> +	xpcs->quirk = quirk;
> +}
> +EXPORT_SYMBOL_GPL(xpcs_set_quirk);

According to the KSZ9477 data, the physid is 0x7996ced0 (which is the
DW value according to the xpcs header file). We also read the PMA ID
(xpcs->info.pma). Can this be used to identify the KSZ9477 without
introducing quirks?

I would prefer to avoid going down the route of introducing a quirk
mask - that seems to be a recipe to breed lots of flags that make
long term maintenance more difficult.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

