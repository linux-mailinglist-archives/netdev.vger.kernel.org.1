Return-Path: <netdev+bounces-144779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AF19C873C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3347DB21EDF
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A3F1F76B6;
	Thu, 14 Nov 2024 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CA0uCSYs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677E314EC47;
	Thu, 14 Nov 2024 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578778; cv=none; b=aWCNnLXdyXv+7WVZpbD6uoF/U51c8Fw0MFd84OzbU46JCUnzzk/Bivsxv0ikJOs3kt1HvoU+DtQk/WYVNlReLrJXWVE+fNr3MxnIu7ZA64r3zV9IqvGPLxhCd/SP/yQ0VgQwkP91NFvErALJIHiXavLsvad+qIS6ww4btvu7v3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578778; c=relaxed/simple;
	bh=Pnc0qNHkdPR0PA5sax719eiAyaQU67fymQB+8rJyElo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RICmgQNeZ4rvDhjJlD3l8K7bJStMVHYTNf0we531sB68lIwwhs5b2cWyeM/LHH8TLDkC3s6UyExN+4ylc2AICb3By5t6RxVxEdZaI++tPixiI+r1TTyWh4oKxLQCNRsl1Xk2LX1U+9WokhlkFzVDZZ26B+Zcs2ydPIEV52igAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CA0uCSYs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gIPrSHgQCALCepHl6R+DTYzMov4UgSjk+ZA9/KyL5Qc=; b=CA0uCSYsodv0SQpUQLPg+KwV1j
	EOlFv+wYDpcRDgp2xP9fYXhBS0UkslmAeNFxvc/UPX/QDM9nTvMHb+Rb6cUcq/zTfCKsxIGlFmrwM
	TyoKtRmwlH4+WcAcpfp+TwMMEyi0UTdTrCScZJ7tnbJ1Df18lW2N/W4W/S3JgmLXtJlNWq7uXid7o
	aOQsjDZCkpZNfzjalZOEcIqNmHnBv3jRuVfiCkBdf6nz8dnJb1nv/+OzBsWBGtX8Sl0mRWh2ozlpd
	GBjeExq32+6wAshDmMRV/EWWV1+oJyy3Pn30P4STwNRs68DsewdJaRfxtzYgjEOaiziLFeokGZHMe
	8LukeCIg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58434)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBWje-0007mr-2u;
	Thu, 14 Nov 2024 10:05:59 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBWjY-000113-2H;
	Thu, 14 Nov 2024 10:05:52 +0000
Date: Thu, 14 Nov 2024 10:05:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v1 1/2] net: phy: set eee_cfg based on PHY
 configuration
Message-ID: <ZzXLgEjElnJD1445@shell.armlinux.org.uk>
References: <20241114081653.3939346-1-yong.liang.choong@linux.intel.com>
 <20241114081653.3939346-2-yong.liang.choong@linux.intel.com>
 <ZzXBpEHs0y2_elqK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzXBpEHs0y2_elqK@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 14, 2024 at 09:23:48AM +0000, Russell King (Oracle) wrote:
> On Thu, Nov 14, 2024 at 04:16:52PM +0800, Choong Yong Liang wrote:
> > Not all PHYs have EEE enabled by default. For example, Marvell PHYs are
> > designed to have EEE hardware disabled during the initial state, and it
> > needs to be configured to turn it on again.
> > 
> > This patch reads the PHY configuration and sets it as the initial value for
> > eee_cfg.tx_lpi_enabled and eee_cfg.eee_enabled instead of having them set to
> > true by default.
> 
> eee_cfg.tx_lpi_enabled is something phylib tracks, and it merely means
> that LPI needs to be enabled at the MAC if EEE was negotiated:
> 
>  * @tx_lpi_enabled: Whether the interface should assert its tx lpi, given
>  *      that eee was negotiated.
> 
> eee_cfg.eee_enabled means that EEE mode was enabled - which is user
> configuration:
> 
>  * @eee_enabled: EEE configured mode (enabled/disabled).
> 
> phy_probe() reads the initial PHY state and sets things up
> appropriately.
> 
> However, there is a point where the EEE configuration (advertisement,
> and therefore eee_enabled state) is written to the PHY, and that should
> be config_aneg(). Looking at the Marvell driver, it's calling
> genphy_config_aneg() which eventually calls
> genphy_c45_an_config_eee_aneg() which does this (via
> __genphy_config_aneg()).
> 
> Please investigate why the hardware state is going out of sync with the
> software state.

I think I've found the issue.

We have phydev->eee_enabled and phydev->eee_cfg.eee_enabled, which looks
like a bug to me. We write to phydev->eee_cfg.eee_enabled in
phy_support_eee(), leaving phydev->eee_enabled untouched.

However, most other places are using phydev->eee_enabled.

This is (a) confusing and (b) wrong, and having the two members leads
to this confusion, and makes the code more difficult to follow (unless
one has already clocked that there are these two different things both
called eee_enabled).

This is my untested prototype patch to fix this - it may cause breakage
elsewhere:

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index c1b3576c307f..2d64d3f293e5 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -943,7 +943,7 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_eee_abilities);
  */
 int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
 {
-	if (!phydev->eee_enabled) {
+	if (!phydev->eee_cfg.eee_enabled) {
 		__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
 
 		return genphy_c45_write_eee_adv(phydev, adv);
@@ -1576,8 +1576,6 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 		}
 	}
 
-	phydev->eee_enabled = data->eee_enabled;
-
 	ret = genphy_c45_an_config_eee_aneg(phydev);
 	if (ret > 0) {
 		ret = phy_restart_aneg(phydev);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bc24c9f2786b..b26bb33cd1d4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3589,12 +3589,12 @@ static int phy_probe(struct device *dev)
 	/* There is no "enabled" flag. If PHY is advertising, assume it is
 	 * kind of enabled.
 	 */
-	phydev->eee_enabled = !linkmode_empty(phydev->advertising_eee);
+	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
 
 	/* Some PHYs may advertise, by default, not support EEE modes. So,
 	 * we need to clean them.
 	 */
-	if (phydev->eee_enabled)
+	if (phydev->eee_cfg.eee_enabled)
 		linkmode_and(phydev->advertising_eee, phydev->supported_eee,
 			     phydev->advertising_eee);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 1e4127c495c0..33905e9672a7 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -601,7 +601,6 @@ struct macsec_ops;
  * @adv_old: Saved advertised while power saving for WoL
  * @supported_eee: supported PHY EEE linkmodes
  * @advertising_eee: Currently advertised EEE linkmodes
- * @eee_enabled: Flag indicating whether the EEE feature is enabled
  * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
@@ -721,7 +720,6 @@ struct phy_device {
 	/* used for eee validation and configuration*/
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_eee);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising_eee);
-	bool eee_enabled;
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
 	DECLARE_PHY_INTERFACE_MASK(host_interfaces);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

