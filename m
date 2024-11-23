Return-Path: <netdev+bounces-146899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6B29D697D
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 15:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1CE1615A8
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC21CFA9;
	Sat, 23 Nov 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oWV/bS4y"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D95B195
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732373423; cv=none; b=Evd5Au9+8XPZWM54AimawdWAQh4YoONHHLCw79nqbi8FLpjPzI31mb/cpiMlE+14jfd2IIiJsRGolb++tEq1yJqBwPzp0iXbrJNmiGjbMPhmikeUg/KWAKFhZEqR7VDiFJEDEWBSnX+WTbO0Z8ihuifrfgVA0MrbFd6KoVmgE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732373423; c=relaxed/simple;
	bh=Ok0DKi1lkXLGzG940gcAXtGWOQ8LJhAR2nhD7x7cYhI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=a6Pz+skUb0zC+hyQUeZB+jOIYqlPurc4ikc2nzpg6mxEGdIgoIff1veMxtMUH99lq9DhSYaMZVjWVyEB5xPv4pc0KNPQs0u7FiqP57FWtJjb+iVA4KUDa/dCUuZO17EhLprvG0/EsBgznTWI2HqBeJ8nwr3jPLV+yPdlu2ZQTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oWV/bS4y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i8zo9/PJXZzyB1YqBCkhbvnXDwMzXivW1R2LSmEE0JM=; b=oWV/bS4ysAv1T2i1uZusM4p+K6
	NTCJoi9JgEh+4qx6Oyrls5NRlSo3KpGg91RD6yJ/96kswiaWWDjUyMsLak0jx+emi6PlchQtbMzD9
	ZOGXsfyqGaVUSrV7FidobHrpO1H6rTX5IieakQKYpLzRoGdsGtVA+GYRU1BlXWzhNR23JT4tM2POc
	eU0rxmVL8DUXmwsXzUnbicpGDT+YAeFXhaLkgRkfxkGj5/y8jHi5Vp5EiIX5A/ecFXwUCG8A0Aqwi
	VoFhd1ZPFFZWIpNmUHbizOMe7WqpQJgWPOUXLMf2LiwFbE9mXSr58qzzHKf/1bk3ILuec+mUxvGf7
	rqLKQLsA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57886 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tErSe-00028Z-2i;
	Sat, 23 Nov 2024 14:50:13 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tErSe-005RhB-2R; Sat, 23 Nov 2024 14:50:12 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org
Subject: [PATCH net v3] net: phy: fix phy_ethtool_set_eee() incorrectly
 enabling LPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tErSe-005RhB-2R@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 23 Nov 2024 14:50:12 +0000

When phy_ethtool_set_eee_noneg() detects a change in the LPI
parameters, it attempts to update phylib state and trigger the link
to cycle so the MAC sees the updated parameters.

However, in doing so, it sets phydev->enable_tx_lpi depending on
whether the EEE configuration allows the MAC to generate LPI without
taking into account the result of negotiation.

This can be demonstrated with a 1000base-T FD interface by:

 # ethtool --set-eee eno0 advertise 8   # cause EEE to be not negotiated
 # ethtool --set-eee eno0 tx-lpi off
 # ethtool --set-eee eno0 tx-lpi on

This results in being true, despite EEE not having been negotiated and:
 # ethtool --show-eee eno0
	EEE status: enabled - inactive
	Tx LPI: 250 (us)
	Supported EEE link modes:  100baseT/Full
	                           1000baseT/Full
	Advertised EEE link modes:  100baseT/Full
	                                         1000baseT/Full

Fix this by keeping track of whether EEE was negotiated via a new
eee_active member in struct phy_device, and include this state in
the decision whether phydev->enable_tx_lpi should be set.

Fixes: 3e43b903da04 ("net: phy: Immediately call adjust_link if only tx_lpi_enabled changes")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v3:
- fixed kernel-doc
- added fixes tag
- rebased on Heiner's patch: https://patchwork.kernel.org/project/netdevbpf/patch/a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com/
As such, not added Andrew's r-b.

 drivers/net/phy/phy-c45.c |  2 +-
 drivers/net/phy/phy.c     | 30 ++++++++++++++++++------------
 include/linux/phy.h       |  2 ++
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 96d0b3a5a9d3..944ae98ad110 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1530,7 +1530,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 		return ret;
 
 	data->eee_enabled = is_enabled;
-	data->eee_active = ret;
+	data->eee_active = phydev->eee_active;
 	linkmode_copy(data->supported, phydev->supported_eee);
 
 	return 0;
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index a660a80f34b7..0d20b534122b 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -990,14 +990,14 @@ static int phy_check_link_status(struct phy_device *phydev)
 		phydev->state = PHY_RUNNING;
 		err = genphy_c45_eee_is_active(phydev,
 					       NULL, NULL, NULL);
-		if (err <= 0)
-			phydev->enable_tx_lpi = false;
-		else
-			phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled;
+		phydev->eee_active = err > 0;
+		phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
+					phydev->eee_active;
 
 		phy_link_up(phydev);
 	} else if (!phydev->link && phydev->state != PHY_NOLINK) {
 		phydev->state = PHY_NOLINK;
+		phydev->eee_active = false;
 		phydev->enable_tx_lpi = false;
 		phy_link_down(phydev);
 	}
@@ -1685,15 +1685,21 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
 static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
 				      const struct eee_config *old_cfg)
 {
-	if (phydev->eee_cfg.tx_lpi_enabled != old_cfg->tx_lpi_enabled ||
+	bool enable_tx_lpi;
+
+	if (!phydev->link)
+		return;
+
+	enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled && phydev->eee_active;
+
+	if (phydev->enable_tx_lpi != enable_tx_lpi ||
 	    phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {
-		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
-		if (phydev->link) {
-			phydev->link = false;
-			phy_link_down(phydev);
-			phydev->link = true;
-			phy_link_up(phydev);
-		}
+		phydev->enable_tx_lpi = false;
+		phydev->link = false;
+		phy_link_down(phydev);
+		phydev->enable_tx_lpi = enable_tx_lpi;
+		phydev->link = true;
+		phy_link_up(phydev);
 	}
 }
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 77c6d6451638..563c46205685 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -602,6 +602,7 @@ struct macsec_ops;
  * @supported_eee: supported PHY EEE linkmodes
  * @advertising_eee: Currently advertised EEE linkmodes
  * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
+ * @eee_active: phylib private state, indicating that EEE has been negotiated
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
  * @host_interfaces: PHY interface modes supported by host
@@ -723,6 +724,7 @@ struct phy_device {
 	/* Energy efficient ethernet modes which should be prohibited */
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_broken_modes);
 	bool enable_tx_lpi;
+	bool eee_active;
 	struct eee_config eee_cfg;
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
-- 
2.30.2


