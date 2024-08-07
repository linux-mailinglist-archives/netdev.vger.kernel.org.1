Return-Path: <netdev+bounces-116412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6097794A592
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47DE51C21412
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFEC1DD3BB;
	Wed,  7 Aug 2024 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S38Xy+mI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F81DF680
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026717; cv=none; b=GXg8QhjFxGqeChcQFMrsL6AtdNkSvFYCnepttzYgwEVyBayU1xrYNyhSxo5N07gCUM7WZmonetsm+OK/nHQXWq66+lGsnezUCeT9eJE4E8XrMTWsXFxRf9RBW04+f1IVA0yjROBUBwfeZNh8YaUOoOukVv5xC6iuC2do/JgnmEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026717; c=relaxed/simple;
	bh=PTFXzBTz6H3w190e9ueYAvJUlT9ygZiuy4UBARVVDKY=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=Nt+y6/jEzKdwohecq7oK0pH7ak51jp7otO1s8VSfGzSlG+eZM10DusMvW7ijr+8cPseoYX5CSZTNW45gI0M1D4En5UUqCfzR01dT+vipP2Vese1afTc10eoy1tducx9w6CpZQ4iFkwEyNy0uuf8YE0eH5jz0zMw2SzkE+RDpPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S38Xy+mI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vB7rVwzM9nmAPT2PAwffAy7e1fMdTHH6U5BfB0//5lc=; b=S38Xy+mIxHxJtaKOBT55TcFaVQ
	UzqMwZ8qhzWjUseC8QAIS2Te7FxNwPsvyiG2WS3EHFws9ZLwFOUM9KpuWyLLuh8xfh5oiQ6vvIOh7
	O9+nHAdZtQSBc9n0Lin7S0+VokMItkMaRerrbvsqyuBQdF7hFWdltR8dAXG5bhZyCOnxsQI7W7RLj
	+fGYYNfQxal8xtzc3NjLdApYrIG/Ub8B1e5eAULJMhrhRlmQnUbjG5PXEVYVpnRjgtlg8y0Qw4vVR
	hJA/rWnh+Zs3RtdYwaXLx359ikc2mKXd1hkbMZLqnl7q0/jyNMBfPLYitdJX6khUkWs8hPX/iRg9F
	L6RNA3tw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41234 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sbdxD-0006sX-0m;
	Wed, 07 Aug 2024 11:31:39 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sbdxI-0024Eo-HE; Wed, 07 Aug 2024 11:31:44 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: phylib: do not disable autoneg for fixed speeds
 >= 1G
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sbdxI-0024Eo-HE@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 07 Aug 2024 11:31:44 +0100

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
index 29a4225cb712..76312591dcb8 100644
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
2.30.2


