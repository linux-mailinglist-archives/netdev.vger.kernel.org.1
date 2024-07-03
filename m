Return-Path: <netdev+bounces-109039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741E492699D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AB61C21EBA
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671C1850B9;
	Wed,  3 Jul 2024 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YBdk8dK2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0924E4964E
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038801; cv=none; b=fCYDjRuCBTypsGimDVUCpsad4XN3kf3hOqG8kCEfCjKy4YaoN9sG0jYTLfwhC3wb8Y890pDXv3lT3IFdjAknnS4KaSwEQDHZ2Xtt4HnKerElL6VmWsIlIRUJV2w5P71vWEscaw1fXEHaxIpgvKU24BzGWyQlXkJSUpEf3XaYynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038801; c=relaxed/simple;
	bh=LyITkQQhJ1RzIHc0MfA3b1Op3/GzxrkaQAHT3WTxBtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4eQCQhJkQoSDRx5Y1oUzi5o4kBgt7cBXUCJvVo+lQCNkWw7+t7U0dl2xI9zcIbni7Ea075AQYGfU+g3PI7OYANQ+PWaQV/fi5Q2blcTWn1T/ZwS3N8LYDLO1FFt0Ore+voUF2bLZgbBoRuyDyN2K+kt62pQAdjmTn/mcmznzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YBdk8dK2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xAI/1QABtax3Gh0SAl+F4c+m56HNVv/9XGTdoJZ+9Lg=; b=YBdk8dK2N40BgEFsuA6NAFuf+g
	89nMMD5aiRoiFIqGC1Cvos0nhVYMUYoQYCbGDHqKtbZN2HVvVCcucN8rQt2u3kmL9Rk9cROpOUPBk
	gSoiR1n+BLOcRtVFYs0WDw5Jn/0X1GwYQswui45fvLsn61tbcngRJFMIUSeKwm7/zxhExXd9xa+et
	1DrS+idA/VFrMw+dnJcCgOE8HBeQ3j6bniyN7kuORyPo6Mo/7wnUCKowMI1ePDiYTp4W08kKOKPFG
	ozsWE8UpOpQ33aHGv+tvSGEvOF5c0Xy7kOz7VwgKFbJMJvTdsDJNdDYBm6a5UryGPh36bUpWr92dz
	VKX7+Qmw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39264)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sP6ex-00067z-2i;
	Wed, 03 Jul 2024 21:32:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sP6ey-0003HC-IV; Wed, 03 Jul 2024 21:33:00 +0100
Date: Wed, 3 Jul 2024 21:33:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Serge Semin <fancer.lancer@gmail.com>, si.yanteng@linux.dev,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>, hkallweit1@gmail.com,
	peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, Jose.Abreu@synopsys.com,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set
 network speed to 1000.
Message-ID: <ZoW1fNqV3PxEobFx@shell.armlinux.org.uk>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
 <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
 <ZlgpLm3L6EdFO60f@shell.armlinux.org.uk>
 <6ba14d835ff12f479eeced585b9336c1e6219d54@linux.dev>
 <gndedhwq6q6ou56nxnld6irkv4curb7mql4sy2i4wx5qnqksoh@6kpyuozs656l>
 <ZoQX1bqtJI2Zd9qH@shell.armlinux.org.uk>
 <hdqpsuq7n4aalav7jtzttfksw5ct36alowsc65e72armjt2h67@shph7z32rbc6>
 <ZoWex6T0QbRBmDFE@shell.armlinux.org.uk>
 <eb4bed28-c04e-4098-b947-e9fc626ba478@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb4bed28-c04e-4098-b947-e9fc626ba478@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 03, 2024 at 09:09:53PM +0200, Andrew Lunn wrote:
> > Rather than erroring out, I think it may be better to just adopt
> > the Marvell solution to this problem to give consistent behaviour
> > across all PHYs.
> 
> Yes, expand phy_config_aneg() to look for this condition and enable
> autoneg. But should we disable it when the condition is reverted? The
> user swaps to 100Mbps forced?

I think we should "lie" to userspace rather than report how the
hardware was actually programmed - again, because that's what would
happen with Marvell Alaska.

> What about other speeds? Is this limited to 1G? Since we have devices
> without auto-neg for 2500BaseX i assume it is not an issue there.

1000base-X can have AN disabled - that's not an issue. Yes, there's
the ongoing issues with 2500base-X. 10Gbase-T wording is similar to
1000base-T, so we probably need to do similar there. Likely also the
case for 2500base-T and 5000base-T as well.

So I'm thinking of something like this (untested):

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 6c6ec9475709..197c4d5ab55b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2094,22 +2094,20 @@ EXPORT_SYMBOL(phy_reset_after_clk_enable);
 /**
  * genphy_config_advert - sanitize and advertise auto-negotiation parameters
  * @phydev: target phy_device struct
+ * @advert: auto-negotiation parameters to advertise
  *
  * Description: Writes MII_ADVERTISE with the appropriate values,
  *   after sanitizing the values to make sure we only advertise
  *   what is supported.  Returns < 0 on error, 0 if the PHY's advertisement
  *   hasn't changed, and > 0 if it has changed.
  */
-static int genphy_config_advert(struct phy_device *phydev)
+static int genphy_config_advert(struct phy_device *phydev,
+				const unsigned long *advert)
 {
 	int err, bmsr, changed = 0;
 	u32 adv;
 
-	/* Only allow advertising what this PHY supports */
-	linkmode_and(phydev->advertising, phydev->advertising,
-		     phydev->supported);
-
-	adv = linkmode_adv_to_mii_adv_t(phydev->advertising);
+	adv = linkmode_adv_to_mii_adv_t(advert);
 
 	/* Setup standard advertisement */
 	err = phy_modify_changed(phydev, MII_ADVERTISE,
@@ -2132,7 +2130,7 @@ static int genphy_config_advert(struct phy_device *phydev)
 	if (!(bmsr & BMSR_ESTATEN))
 		return changed;
 
-	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+	adv = linkmode_adv_to_mii_ctrl1000_t(advert);
 
 	err = phy_modify_changed(phydev, MII_CTRL1000,
 				 ADVERTISE_1000FULL | ADVERTISE_1000HALF,
@@ -2356,6 +2354,9 @@ EXPORT_SYMBOL(genphy_check_and_restart_aneg);
  */
 int __genphy_config_aneg(struct phy_device *phydev, bool changed)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(fixed_advert);
+	const struct phy_setting *set;
+	unsigned long *advert;
 	int err;
 
 	err = genphy_c45_an_config_eee_aneg(phydev);
@@ -2370,10 +2371,25 @@ int __genphy_config_aneg(struct phy_device *phydev, bool changed)
 	else if (err)
 		changed = true;
 
-	if (AUTONEG_ENABLE != phydev->autoneg)
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		/* Only allow advertising what this PHY supports */
+		linkmode_and(phydev->advertising, phydev->advertising,
+			     phydev->supported);
+		advert = phydev->advertising;
+	} else if (phydev->speed < SPEED_1000) {
 		return genphy_setup_forced(phydev);
+	} else {
+		linkmode_zero(fixed_advert);
+
+		set = phy_lookup_setting(phydev->speed, phydev->duplex,
+					 phydev->supported, true);
+		if (set)
+			linkmode_set(set->bit, fixed_advert);
+
+		advert = fixed_advert;
+	}
 
-	err = genphy_config_advert(phydev);
+	err = genphy_config_advert(phydev, advert);
 	if (err < 0) /* error */
 		return err;
 	else if (err)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

