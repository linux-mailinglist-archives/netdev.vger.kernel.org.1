Return-Path: <netdev+bounces-85945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9199689CF93
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 02:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3202850CA
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 00:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC27B1C0DE5;
	Tue,  9 Apr 2024 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xE3vSCSt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA0A937
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712624073; cv=none; b=JAqulfm4wYwfg2xbg89eEIH2o1GMLXiJ9PmhEsb6HAf2Wk6UrgCmS/uohS84h0DH1D8IwNKvD5D7k5KSAhXSGTs2Mj+DKasCteHVGWJxtiN9do0dTl3WJNK0GZWOXm/RzpeNEpyp+PjZypPoTSjfSBaR4+Zoi0sLnT3lPVGr8lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712624073; c=relaxed/simple;
	bh=wbGGrajCrBljNe48PBImIu4pgrPPJ0tG2cusdv6396w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rMEq9S0BMox8hGLKQKYQdGDWWFxur5U44zagizi8BX/oCQhsyco/AtcaBaDDeTfL1h8vppRNbZJlTdhYp1Me6H8TUiEVsYojbJAl+7LZt8rvEZRcNKrTz57+H23t00hzBEtXmUKOUiuKCMfwxeZNh/qMPW/OFj/NHzbND2T/gJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xE3vSCSt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:From:Sender:Reply-To:Subject:Date:Message-ID:
	To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1hyl/LotxSwOYTA0Vd+BlcEen0pWXzMyX6BZU7h3d8s=; b=xE3vSCStOPRW35vXT1io1JRIWa
	9Vq+nrePRalbnH/slAc78DGD2h0xWwqAFhTooLwMGIjh7PAqjencnHnHhq1MHjBNAQu5cAeBuwiT/
	Bt/Wun0HHNT3jHhDxiVahSBM0V0DotHoCzPFRRtymc+bOFAhxg4oBBkVvZYKiUH8ARhc=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtzkn-00CWm1-67; Tue, 09 Apr 2024 02:54:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 08 Apr 2024 19:54:04 -0500
Subject: [PATCH net-next] net: genet: Fixup EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-stmmac-eee-v1-1-3d65d671c06b@lunn.ch>
X-B4-Tracking: v=1; b=H4sIAKuRFGYC/x3MQQqAIBBG4avErBswC6muEi3EfmsWWahEEN09a
 fkt3nsoIQoSjdVDEZckOUJBU1fkNhtWsCzFpJXuVKd6TnnfrWMAvLSuhxqMN1ZTCc4IL/c/myg
 gc8CdaX7fD+W0Nc9mAAAA
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5836; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=wbGGrajCrBljNe48PBImIu4pgrPPJ0tG2cusdv6396w=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmFJG+XWDide6Z77R7JtTa8bfXVOL3OQspWJq6M
 seUJiUzhICJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhSRvgAKCRDmvw3LpmlM
 hP/vEACC1mDVsvB8u5EWHw3zlAP+WeVwz4mKX2Y4sTmPGlA+PM8ylC7Br2TKa1Wo6nrHl+u2sCQ
 VdVNJIRX2B7aDT9BrSS0uekocLsRqCXiQupXbOicPLxLnCx9QGKNXqXQ8gP4K5yU0oxphmll4iI
 yoKKCRu38WPOglSf6oQIL694iL2CMDbS18H0DfKpOUTBdGNQhIMMP7y5TVYdagTYbgDma867Idi
 5Ok/W2PhoWTcq12E1gs9IP/031zoqwpNnKOdlbbO2/6Z88W4CwMsTfmxu77Yjd1PWIMkP85cw0e
 nyuhgu35BudO6a7oZeGaBK0WhANd0MCg0rxmW+5ZbLxL6BV99d8Yuljdnwxy94WADCRb84nI75c
 TU+8T2Cchr7bMUz/GnkEQdAxxJJ5AQn4xqXRm1honXAjtAYBpntqjBuPvbyI956U+qA1vCRXqnM
 27YN60ZZHJHdEEVtxumVDJrEFyRo2SPguFgp1c16wjL/RgkcyXnDgBuqJx572e3C0IKQuAgjJVk
 yYAI04/JnFTs91tMPmBJ5VDy1E8xH6WVgPLXmOs2Ya5OJFsUgImzPkHWcb1XV+/zGq2PzFNMIn6
 5eLZ9/lc8sV69Qw31qtEl+leXTMCOY9TdMK8FSNTnWaViXVpWuYQwFoiA0jagrMvVGA7itZpbl2
 ankFTpe0D00JuOg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

The enabling/disabling of EEE in the MAC should happen as a result of
auto negotiation. So move the enable/disable into bcmgenet_mii_setup()
which gets called by phylib when there is a change in link status.

bcmgenet_set_eee() now just writes the LPI timer value to the
hardware.  Everything else is passed to phylib, so it can correctly
setup the PHY.

bcmgenet_get_eee() relies on phylib doing most of the work, the MAC
driver just adds the LPI timer value from hardware.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 26 ++++++--------------------
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  6 +-----
 drivers/net/ethernet/broadcom/genet/bcmmii.c   |  7 +------
 3 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b1f84b37032a..c090b519255a 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1272,13 +1272,14 @@ static void bcmgenet_get_ethtool_stats(struct net_device *dev,
 	}
 }
 
-void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
-			     bool tx_lpi_enabled)
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	u32 off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
+	u32 off;
 	u32 reg;
 
+	off = priv->hw_params->tbuf_offset + TBUF_ENERGY_CTRL;
+
 	if (enable && !priv->clk_eee_enabled) {
 		clk_prepare_enable(priv->clk_eee);
 		priv->clk_eee_enabled = true;
@@ -1293,7 +1294,7 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
 
 	/* Enable EEE and switch to a 27Mhz clock automatically */
 	reg = bcmgenet_readl(priv->base + off);
-	if (tx_lpi_enabled)
+	if (enable)
 		reg |= TBUF_EEE_EN | TBUF_PM_EN;
 	else
 		reg &= ~(TBUF_EEE_EN | TBUF_PM_EN);
@@ -1311,15 +1312,11 @@ void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
 		clk_disable_unprepare(priv->clk_eee);
 		priv->clk_eee_enabled = false;
 	}
-
-	priv->eee.eee_enabled = enable;
-	priv->eee.tx_lpi_enabled = tx_lpi_enabled;
 }
 
 static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	struct ethtool_keee *p = &priv->eee;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1327,7 +1324,6 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!dev->phydev)
 		return -ENODEV;
 
-	e->tx_lpi_enabled = p->tx_lpi_enabled;
 	e->tx_lpi_timer = bcmgenet_umac_readl(priv, UMAC_EEE_LPI_TIMER);
 
 	return phy_ethtool_get_eee(dev->phydev, e);
@@ -1336,8 +1332,6 @@ static int bcmgenet_get_eee(struct net_device *dev, struct ethtool_keee *e)
 static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
-	struct ethtool_keee *p = &priv->eee;
-	bool active;
 
 	if (GENET_IS_V1(priv))
 		return -EOPNOTSUPP;
@@ -1345,15 +1339,7 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!dev->phydev)
 		return -ENODEV;
 
-	p->eee_enabled = e->eee_enabled;
-
-	if (!p->eee_enabled) {
-		bcmgenet_eee_enable_set(dev, false, false);
-	} else {
-		active = phy_init_eee(dev->phydev, false) >= 0;
-		bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
-		bcmgenet_eee_enable_set(dev, active, e->tx_lpi_enabled);
-	}
+	bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
 
 	return phy_ethtool_set_eee(dev->phydev, e);
 }
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 7523b60b3c1c..bb82ecb2e220 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -644,8 +644,6 @@ struct bcmgenet_priv {
 	bool wol_active;
 
 	struct bcmgenet_mib_counters mib;
-
-	struct ethtool_keee eee;
 };
 
 #define GENET_IO_MACRO(name, offset)					\
@@ -703,7 +701,5 @@ int bcmgenet_wol_power_down_cfg(struct bcmgenet_priv *priv,
 void bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 			       enum bcmgenet_power_mode mode);
 
-void bcmgenet_eee_enable_set(struct net_device *dev, bool enable,
-			     bool tx_lpi_enabled);
-
+void bcmgenet_eee_enable_set(struct net_device *dev, bool enable);
 #endif /* __BCMGENET_H__ */
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 9ada89355747..25eeea4c1965 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -30,7 +30,6 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct phy_device *phydev = dev->phydev;
 	u32 reg, cmd_bits = 0;
-	bool active;
 
 	/* speed */
 	if (phydev->speed == SPEED_1000)
@@ -88,11 +87,6 @@ static void bcmgenet_mac_config(struct net_device *dev)
 		reg |= CMD_TX_EN | CMD_RX_EN;
 	}
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
-
-	active = phy_init_eee(phydev, 0) >= 0;
-	bcmgenet_eee_enable_set(dev,
-				priv->eee.eee_enabled && active,
-				priv->eee.tx_lpi_enabled);
 }
 
 /* setup netdev link state when PHY link status change and
@@ -106,6 +100,7 @@ void bcmgenet_mii_setup(struct net_device *dev)
 
 	if (phydev->link) {
 		bcmgenet_mac_config(dev);
+		bcmgenet_eee_enable_set(dev, phydev->enable_tx_lpi);
 	} else {
 		reg = bcmgenet_ext_readl(priv, EXT_RGMII_OOB_CTRL);
 		reg &= ~RGMII_LINK;

---
base-commit: 39f59c72ad3a1eaab9a60f0671bc94d2bc826d21
change-id: 20240408-stmmac-eee-d3c8e096f6a2

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


