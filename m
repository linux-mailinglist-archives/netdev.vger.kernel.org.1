Return-Path: <netdev+bounces-197108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E35A4AD780E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64603189032E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520929B8CE;
	Thu, 12 Jun 2025 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="CdNoi5TP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489CB29B78B
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749745045; cv=none; b=Ft+/XEnsVtTPF7pTJtGB0b2k8jwiXbvXMXBQIhOYujVFAnVK2VPkyHb64lvozsdkAqUOxDDQXBdQ44sQPBAUdtWWyCjIbK8S9Y05C3KYgFNgm+LFriTGlJiGh4O0MqK0FN4s+sigOq+J1Xsg4qsm0vCkX4AQysXdGYm2/1eXY4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749745045; c=relaxed/simple;
	bh=dPuf9FUWeM+BLK1seyi9NcOAI+FsAeZ4PO++j3ziw9w=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=r+ax96nZOa5hRXOBJFn2qcVHmgMSiD5oSL7Q4f5W71B7YXAlh91EllHwFXpvYsseSVzJcg253Wo+ooprFkZoKD7pYihJlTBmj4KnUo/cCydThZvs1azCwZheEWtwgdUda66/9RzBqb2bJTaGxjc2Z9Ygy4fUQWjO7Yo02DCBjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=CdNoi5TP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Xa9ldOdTR15G6fLzz6FMCCQoVl/XbCjTH6vEU5SJCOk=; b=CdNoi5TPJJrLH10Sw2eRffsdzb
	9VEhwCn95AoKUxX8/rrEow1A1c93zES5VglqCfbaN7Cdh9ItU+kizCgF6hicI7KBnCnspvwP4Zfdl
	flWKI87Z3Qfs6Ls/AF8y5d8xj4k8Ux52/8mcMwXWocL2Jfrg9TPGKLknE/Yk5YytZjrSnrqhQdoAG
	dy5PRrylmyfPZIH1teBk3/ihn8qVRuwFczIch/8+6Mt5GCkCP2dXONgK1XyD05yPiF2mR+ot4eCUN
	Zfye27SbI4ldpj2XLSpouy8/bmYvkrnfJTdYmqR6E+SYXLj56MnOtvj9Y0OoGqauVHQrzcRgn2nQX
	AiB8IW6w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50116 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPkc7-00087v-3D;
	Thu, 12 Jun 2025 17:17:16 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPkbT-004EyG-OQ; Thu, 12 Jun 2025 17:16:35 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: stmmac: remove pcs_get_adv_lp() support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPkbT-004EyG-OQ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 17:16:35 +0100

It appears that the GMAC_ANE_ADV and GMAC_ANE_LPA registers are only
available for TBI and RTBI PHY interfaces. In commit 482b3c3ba757
("net: stmmac: Drop TBI/RTBI PCS flags") support for these was dropped,
and thus it no longer makes sense to access these registers.

Remove the *_get_adv_lp() functions, and the now redundant struct
rgmii_adv and STMMAC_PCS_* definitions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  | 11 -----
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  6 ---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  8 ----
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  4 --
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 47 +------------------
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  | 32 +------------
 6 files changed, 4 insertions(+), 104 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index ea5da5793362..cbffccb3b9af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -396,17 +396,6 @@ enum request_irq_err {
 
 #define CORE_IRQ_MTL_RX_OVERFLOW	BIT(8)
 
-/* Physical Coding Sublayer */
-struct rgmii_adv {
-	unsigned int pause;
-	unsigned int duplex;
-	unsigned int lp_pause;
-	unsigned int lp_duplex;
-};
-
-#define STMMAC_PCS_PAUSE	1
-#define STMMAC_PCS_ASYM_PAUSE	2
-
 /* DMA HW capabilities */
 struct dma_features {
 	unsigned int mbps_10_100;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 56b76aaa58f0..38875c832bb8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -399,11 +399,6 @@ static void dwmac1000_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
 	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
 }
 
-static void dwmac1000_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
-{
-	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
-}
-
 static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 			    struct stmmac_extra_stats *x,
 			    u32 rx_queues, u32 tx_queues)
@@ -508,7 +503,6 @@ const struct stmmac_ops dwmac1000_ops = {
 	.set_eee_pls = dwmac1000_set_eee_pls,
 	.debug = dwmac1000_debug,
 	.pcs_ctrl_ane = dwmac1000_ctrl_ane,
-	.pcs_get_adv_lp = dwmac1000_get_adv_lp,
 	.set_mac_loopback = dwmac1000_set_mac_loopback,
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 9c2549d4100f..bc06b24fc611 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -589,11 +589,6 @@ static void dwmac4_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
 	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
 }
 
-static void dwmac4_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
-{
-	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
-}
-
 /* RGMII or SMII interface */
 static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
 {
@@ -958,7 +953,6 @@ const struct stmmac_ops dwmac4_ops = {
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
-	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
@@ -993,7 +987,6 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
-	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.flex_pps_config = dwmac5_flex_pps_config,
@@ -1030,7 +1023,6 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
-	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.safety_feat_config = dwmac5_safety_feat_config,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index ae4efffb785f..e1ac9a245bfe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -300,7 +300,6 @@ struct stmmac_dma_ops {
 
 struct mac_device_info;
 struct net_device;
-struct rgmii_adv;
 struct stmmac_tc_entry;
 struct stmmac_pps_cfg;
 struct stmmac_rss;
@@ -377,7 +376,6 @@ struct stmmac_ops {
 	/* PCS calls */
 	void (*pcs_ctrl_ane)(void __iomem *ioaddr, bool ane, bool srgmi_ral,
 			     bool loopback);
-	void (*pcs_get_adv_lp)(void __iomem *ioaddr, struct rgmii_adv *adv);
 	/* Safety Features */
 	int (*safety_feat_config)(void __iomem *ioaddr, unsigned int asp,
 				  struct stmmac_safety_feature_cfg *safety_cfg);
@@ -467,8 +465,6 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, debug, __priv, __args)
 #define stmmac_pcs_ctrl_ane(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, pcs_ctrl_ane, __args)
-#define stmmac_pcs_get_adv_lp(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, pcs_get_adv_lp, __args)
 #define stmmac_safety_feat_config(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, safety_feat_config, __args)
 #define stmmac_safety_feat_irq_status(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index f702f7b7bf9f..72f1724af037 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -325,7 +325,6 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
 	if (!(priv->plat->flags & STMMAC_FLAG_HAS_INTEGRATED_PCS) &&
 	    (priv->hw->pcs & STMMAC_PCS_RGMII ||
 	     priv->hw->pcs & STMMAC_PCS_SGMII)) {
-		struct rgmii_adv adv;
 		u32 supported, advertising, lp_advertising;
 
 		if (!priv->xstats.pcs_link) {
@@ -337,10 +336,6 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
 
 		cmd->base.speed = priv->xstats.pcs_speed;
 
-		/* Get and convert ADV/LP_ADV from the HW AN registers */
-		if (stmmac_pcs_get_adv_lp(priv, priv->ioaddr, &adv))
-			return -EOPNOTSUPP;	/* should never happen indeed */
-
 		/* Encoding of PSE bits is defined in 802.3z, 37.2.1.4 */
 
 		ethtool_convert_link_mode_to_legacy_u32(
@@ -350,44 +345,12 @@ static int stmmac_ethtool_get_link_ksettings(struct net_device *dev,
 		ethtool_convert_link_mode_to_legacy_u32(
 			&lp_advertising, cmd->link_modes.lp_advertising);
 
-		if (adv.pause & STMMAC_PCS_PAUSE)
-			advertising |= ADVERTISED_Pause;
-		if (adv.pause & STMMAC_PCS_ASYM_PAUSE)
-			advertising |= ADVERTISED_Asym_Pause;
-		if (adv.lp_pause & STMMAC_PCS_PAUSE)
-			lp_advertising |= ADVERTISED_Pause;
-		if (adv.lp_pause & STMMAC_PCS_ASYM_PAUSE)
-			lp_advertising |= ADVERTISED_Asym_Pause;
-
 		/* Reg49[3] always set because ANE is always supported */
 		cmd->base.autoneg = ADVERTISED_Autoneg;
 		supported |= SUPPORTED_Autoneg;
 		advertising |= ADVERTISED_Autoneg;
 		lp_advertising |= ADVERTISED_Autoneg;
 
-		if (adv.duplex) {
-			supported |= (SUPPORTED_1000baseT_Full |
-				      SUPPORTED_100baseT_Full |
-				      SUPPORTED_10baseT_Full);
-			advertising |= (ADVERTISED_1000baseT_Full |
-					ADVERTISED_100baseT_Full |
-					ADVERTISED_10baseT_Full);
-		} else {
-			supported |= (SUPPORTED_1000baseT_Half |
-				      SUPPORTED_100baseT_Half |
-				      SUPPORTED_10baseT_Half);
-			advertising |= (ADVERTISED_1000baseT_Half |
-					ADVERTISED_100baseT_Half |
-					ADVERTISED_10baseT_Half);
-		}
-		if (adv.lp_duplex)
-			lp_advertising |= (ADVERTISED_1000baseT_Full |
-					   ADVERTISED_100baseT_Full |
-					   ADVERTISED_10baseT_Full);
-		else
-			lp_advertising |= (ADVERTISED_1000baseT_Half |
-					   ADVERTISED_100baseT_Half |
-					   ADVERTISED_10baseT_Half);
 		cmd->base.port = PORT_OTHER;
 
 		ethtool_convert_legacy_u32_to_link_mode(
@@ -515,12 +478,9 @@ stmmac_get_pauseparam(struct net_device *netdev,
 		      struct ethtool_pauseparam *pause)
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
-	struct rgmii_adv adv_lp;
 
-	if (priv->hw->pcs && !stmmac_pcs_get_adv_lp(priv, priv->ioaddr, &adv_lp)) {
+	if (priv->hw->pcs) {
 		pause->autoneg = 1;
-		if (!adv_lp.pause)
-			return;
 	} else {
 		phylink_ethtool_get_pauseparam(priv->phylink, pause);
 	}
@@ -531,12 +491,9 @@ stmmac_set_pauseparam(struct net_device *netdev,
 		      struct ethtool_pauseparam *pause)
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
-	struct rgmii_adv adv_lp;
 
-	if (priv->hw->pcs && !stmmac_pcs_get_adv_lp(priv, priv->ioaddr, &adv_lp)) {
+	if (priv->hw->pcs) {
 		pause->autoneg = 1;
-		if (!adv_lp.pause)
-			return -EOPNOTSUPP;
 		return 0;
 	} else {
 		return phylink_ethtool_set_pauseparam(priv->phylink, pause);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 1bdf87b237c4..4a684c97dfae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -16,6 +16,8 @@
 /* PCS registers (AN/TBI/SGMII/RGMII) offsets */
 #define GMAC_AN_CTRL(x)		(x)		/* AN control */
 #define GMAC_AN_STATUS(x)	(x + 0x4)	/* AN status */
+
+/* ADV, LPA and EXP are only available for the TBI and RTBI interfaces */
 #define GMAC_ANE_ADV(x)		(x + 0x8)	/* ANE Advertisement */
 #define GMAC_ANE_LPA(x)		(x + 0xc)	/* ANE link partener ability */
 #define GMAC_ANE_EXP(x)		(x + 0x10)	/* ANE expansion */
@@ -107,34 +109,4 @@ static inline void dwmac_ctrl_ane(void __iomem *ioaddr, u32 reg, bool ane,
 
 	writel(value, ioaddr + GMAC_AN_CTRL(reg));
 }
-
-/**
- * dwmac_get_adv_lp - Get ADV and LP cap
- * @ioaddr: IO registers pointer
- * @reg: Base address of the AN Control Register.
- * @adv_lp: structure to store the adv,lp status
- * Description: this is to expose the ANE advertisement and Link partner ability
- * status to ethtool support.
- */
-static inline void dwmac_get_adv_lp(void __iomem *ioaddr, u32 reg,
-				    struct rgmii_adv *adv_lp)
-{
-	u32 value = readl(ioaddr + GMAC_ANE_ADV(reg));
-
-	if (value & GMAC_ANE_FD)
-		adv_lp->duplex = DUPLEX_FULL;
-	if (value & GMAC_ANE_HD)
-		adv_lp->duplex |= DUPLEX_HALF;
-
-	adv_lp->pause = (value & GMAC_ANE_PSE) >> GMAC_ANE_PSE_SHIFT;
-
-	value = readl(ioaddr + GMAC_ANE_LPA(reg));
-
-	if (value & GMAC_ANE_FD)
-		adv_lp->lp_duplex = DUPLEX_FULL;
-	if (value & GMAC_ANE_HD)
-		adv_lp->lp_duplex = DUPLEX_HALF;
-
-	adv_lp->lp_pause = (value & GMAC_ANE_PSE) >> GMAC_ANE_PSE_SHIFT;
-}
 #endif /* __STMMAC_PCS_H__ */
-- 
2.30.2


