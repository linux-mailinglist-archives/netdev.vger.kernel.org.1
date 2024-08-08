Return-Path: <netdev+bounces-116811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C2394BC6E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E372827C7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6146189F52;
	Thu,  8 Aug 2024 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pS7VmCYL"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C255149C54
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117289; cv=none; b=YE7e4+llvdUPIQxNJn3ifvVSnliA151QjE/8EwMCp4D8hicRGB+vYuWn2lIjJmh///2L7D3Ym4VwTB9Rpr3oHMneAh+5D2x6OuZg0nW822RImek1/ijnQL5vjoKJVmkymcBH6VqR3EgFvSgWri7ZUG7GcTCvg+Wx/OAEdOzyW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117289; c=relaxed/simple;
	bh=Hm3rDO+jiuybNu6qKGWVuDZmy4bP+r0dvJ+mMp2igmc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=YVUTNt4yjJVD2JkIVq6+DRwsmM4a796nC+WpOWlicPxsIQ8dO+tGXTgc63eL1kxZII35RnVtDUqlYt+Lln7IZqjMn/02S/DkPOoiD5p1F50PHTw3dOjn0S4f9XuuBuoV0sCxy9HAGtGYsuDz9jhBrjIy7PcZCaHLMcHqL1gGNRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pS7VmCYL; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wdaIxImMNBQCcG5BUnlc1/0zQjVxKYNsUW9gLHl3MvE=; b=pS7VmCYL9o0sPLXes2u0ZZEiHy
	GRgF8rA/ldGZnUVFq42FZPVeHRuC2KSIPtRMzz7Z9ZHDA9mhoDBRGhAifoIRn3sOO0mEjI7NnMBTL
	i9e02tfWzWz6+8gM7wU7HS6LMSpTUjr9Lke+VALNS4O+JLxgZnCurAhF6MLmDqKcyOW/FdhtxIuXh
	MAUF40v7pbBVosfG/Kfgba7tLQ6WQst1iyKZOPThvwjYFRLdlIos34/yUakIdwT5Fmd1/ZA1N7Fkz
	t9pwI21m4AK2+1UPZgtRsBI7taPOEOsNAigCl9nLaXhfUlhmHLm3CHjtVsMS6MI1Lzlr44VZxLEet
	RJvqL7ag==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41426 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sc1W8-0001C8-3D;
	Thu, 08 Aug 2024 12:41:17 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sc1WE-002Fuk-6Z; Thu, 08 Aug 2024 12:41:22 +0100
In-Reply-To: <ZrSutHAqb6uLfmHh@shell.armlinux.org.uk>
References: <ZrSutHAqb6uLfmHh@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 2/2] net: phylib: do not disable autoneg for fixed
 speeds >= 1G
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sc1WE-002Fuk-6Z@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 08 Aug 2024 12:41:22 +0100

We have an increasing number of drivers that are forcing
auto-negotiation to be enabled for speeds of 1G or faster.

It would appear that auto-negotiation is mandatory for speeds above
100M. In 802.3, Annex 40C's state diagrams seems to imply that
mr_autoneg_enable (BMCR AN ENABLE) doesn't affect whether or not the
AN state machines work for 1000base-T, and some PHY datasheets (e.g.
Marvell Alaska) state that disabling mr_autoneg_enable leaves AN
enabled but forced to 1G full duplex.

Other PHY datasheets imply that BMCR AN ENABLE should not be cleared
for >= 1G.

Thus, this should be handled in phylib rather than in each driver.

Rather than erroring out, arrange to implement the Marvell Alaska
solution but in software for all PHYs: generate an appropriate
single-speed advertisement for the requested speed, and keep AN
enabled to the PHY driver. However, to avoid userspace API breakage,
continue to report to userspace that we have AN disabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy_device.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 29a4225cb712..69fe207ac2eb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2103,22 +2103,20 @@ EXPORT_SYMBOL(phy_reset_after_clk_enable);
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
@@ -2141,7 +2139,7 @@ static int genphy_config_advert(struct phy_device *phydev)
 	if (!(bmsr & BMSR_ESTATEN))
 		return changed;
 
-	adv = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+	adv = linkmode_adv_to_mii_ctrl1000_t(advert);
 
 	err = phy_modify_changed(phydev, MII_CTRL1000,
 				 ADVERTISE_1000FULL | ADVERTISE_1000HALF,
@@ -2365,6 +2363,9 @@ EXPORT_SYMBOL(genphy_check_and_restart_aneg);
  */
 int __genphy_config_aneg(struct phy_device *phydev, bool changed)
 {
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(fixed_advert);
+	const struct phy_setting *set;
+	unsigned long *advert;
 	int err;
 
 	err = genphy_c45_an_config_eee_aneg(phydev);
@@ -2379,10 +2380,25 @@ int __genphy_config_aneg(struct phy_device *phydev, bool changed)
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
+			linkmode_set_bit(set->bit, fixed_advert);
+
+		advert = fixed_advert;
+	}
 
-	err = genphy_config_advert(phydev);
+	err = genphy_config_advert(phydev, advert);
 	if (err < 0) /* error */
 		return err;
 	else if (err)
-- 
2.30.2


