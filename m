Return-Path: <netdev+bounces-196375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D3DAD46C3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0721613E0
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C94B29B233;
	Tue, 10 Jun 2025 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wArqi2lZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F68329AAEC
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598327; cv=none; b=oPYHiVE2ZqwDIw3tOrTABVrx/9byOyYKIDX/RctM9bTNyXTkQXH10xiJaLMrgDkhj6TusYGinVQvcq3P7v62RjlJk704nD93qDhdS5dGWmF820oiczhv+EQYskhigngtk0/7ZksXdgwxgvQlEpoINqNv0FNTKB6oDQhRuXenrzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598327; c=relaxed/simple;
	bh=a9mHbrJOiLHj5NsYMvttJmJI0NUURDRVikwiQPz8Cus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZHceAHGKHewrs/rbu19o7YuMUwg2FNgu3pfR6fdCmgfE/sw8HlBIjxXcZ1SGtHYvYYYjaWYD4qJM3DrhOgu29QeGjB9IbM8nXqHTokO44VeGbMIh63aHqyWTS86HPrx28qSXt8+VSl6j7EP/TxKzYP3P7zMAiPhTAmN/+Ve3jOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wArqi2lZ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749598323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8RdlCinf2+TlX4dL62XH9+5xu9xSdaTA7tP0qW17CU=;
	b=wArqi2lZqUqF+oXUylRPZ+1QettdjP++OmHMV2lTAYMlHeUFcuYaEaKumXQ0J5XN+75Wcw
	11c5pgEE1/0AjNiv5JECh9C0zixmNyZNBffDE63H5PcEK2OB2jWf+aHxYrnRS8WbhpSv2Q
	glvmFyPc3rWoehjBwh+0lmQnhSAnoSU=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [net-next PATCH v6 08/10] net: macb: Move most of mac_config to mac_prepare
Date: Tue, 10 Jun 2025 19:31:32 -0400
Message-Id: <20250610233134.3588011-9-sean.anderson@linux.dev>
In-Reply-To: <20250610233134.3588011-1-sean.anderson@linux.dev>
References: <20250610233134.3588011-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

mac_prepare is called every time the interface is changed, so we can do
all of our configuration there, instead of in mac_config. This will be
useful for the next patch where we will set the PCS bit based on whether
we are using our internal PCS. No functional change intended.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v6:
- Fix use of spin_lock instead of spin_unlock

Changes in v2:
- Fix docs for macb_pcs_config_an
- Include change to macb_pcs_get_state which was previously in the next
  patch

 drivers/net/ethernet/cadence/macb_main.c | 209 ++++++++++++++---------
 1 file changed, 132 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d1f1ae5ea161..78433d8f3746 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -549,19 +549,91 @@ static void macb_set_tx_clk(struct macb *bp, int speed)
 		netdev_err(bp->dev, "adjusting tx_clk failed.\n");
 }
 
-static void macb_usx_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
-				 phy_interface_t interface, int speed,
-				 int duplex)
-{
-	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
-	u32 config;
-
-	config = gem_readl(bp, USX_CONTROL);
-	config = GEM_BFINS(SERDES_RATE, MACB_SERDES_RATE_10G, config);
-	config = GEM_BFINS(USX_CTRL_SPEED, HS_SPEED_10000M, config);
-	config &= ~(GEM_BIT(TX_SCR_BYPASS) | GEM_BIT(RX_SCR_BYPASS));
-	config |= GEM_BIT(TX_EN);
-	gem_writel(bp, USX_CONTROL, config);
+static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+			       struct phylink_link_state *state)
+{
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+
+	phylink_mii_c22_pcs_decode_state(state, neg_mode, gem_readl(bp, PCSSTS),
+					 gem_readl(bp, PCSANLPBASE));
+}
+
+/**
+ * macb_pcs_config_an() - Configure autonegotiation settings for PCSs
+ * @bp: The macb to operate on
+ * @neg_mode: The autonegotiation mode
+ * @interface: The interface to use
+ * @advertising: The advertisement mask
+ *
+ * This provides common configuration for PCS autonegotiation.
+ *
+ * Context: Call with @bp->lock held.
+ * Return: 1 if any registers were changed; 0 otherwise
+ */
+static int macb_pcs_config_an(struct macb *bp, unsigned int neg_mode,
+			      phy_interface_t interface,
+			      const unsigned long *advertising)
+{
+	bool changed = false;
+	int old, new;
+
+	old = gem_readl(bp, PCSANADV);
+	new = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
+	if (new != -EINVAL && old != new) {
+		changed = true;
+		gem_writel(bp, PCSANADV, new);
+	}
+
+	old = new = gem_readl(bp, PCSCNTRL);
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		new |= BMCR_ANENABLE;
+	else
+		new &= ~BMCR_ANENABLE;
+	if (old != new) {
+		changed = true;
+		gem_writel(bp, PCSCNTRL, new);
+	}
+	return changed;
+}
+
+static int macb_pcs_config(struct phylink_pcs *pcs, unsigned int mode,
+			   phy_interface_t interface,
+			   const unsigned long *advertising,
+			   bool permit_pause_to_mac)
+{
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+	bool changed = false;
+	unsigned long flags;
+	u32 old, new;
+
+	spin_lock_irqsave(&bp->lock, flags);
+	old = new = gem_readl(bp, NCFGR);
+	new |= GEM_BIT(SGMIIEN);
+	if (old != new) {
+		changed = true;
+		gem_writel(bp, NCFGR, new);
+	}
+
+	if (macb_pcs_config_an(bp, mode, interface, advertising))
+		changed = true;
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+	return changed;
+}
+
+static void macb_pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
+	u32 bmcr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	bmcr = gem_readl(bp, PCSCNTRL);
+	bmcr |= BMCR_ANENABLE;
+	gem_writel(bp, PCSCNTRL, bmcr);
+
+	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
 static void macb_usx_pcs_get_state(struct phylink_pcs *pcs,
@@ -589,45 +661,60 @@ static int macb_usx_pcs_config(struct phylink_pcs *pcs,
 			       bool permit_pause_to_mac)
 {
 	struct macb *bp = container_of(pcs, struct macb, phylink_usx_pcs);
+	unsigned long flags;
+	bool changed;
+	u16 old, new;
 
-	gem_writel(bp, USX_CONTROL, gem_readl(bp, USX_CONTROL) |
-		   GEM_BIT(SIGNAL_OK));
+	spin_lock_irqsave(&bp->lock, flags);
+	if (macb_pcs_config_an(bp, neg_mode, interface, advertising))
+		changed = true;
 
-	return 0;
-}
+	old = new = gem_readl(bp, USX_CONTROL);
+	new |= GEM_BIT(SIGNAL_OK);
+	if (old != new) {
+		changed = true;
+		gem_writel(bp, USX_CONTROL, new);
+	}
 
-static void macb_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
-			       struct phylink_link_state *state)
-{
-	state->link = 0;
-}
+	old = new = gem_readl(bp, USX_CONTROL);
+	new = GEM_BFINS(SERDES_RATE, MACB_SERDES_RATE_10G, new);
+	new = GEM_BFINS(USX_CTRL_SPEED, HS_SPEED_10000M, new);
+	new &= ~(GEM_BIT(TX_SCR_BYPASS) | GEM_BIT(RX_SCR_BYPASS));
+	new |= GEM_BIT(TX_EN);
+	if (old != new) {
+		changed = true;
+		gem_writel(bp, USX_CONTROL, new);
+	}
 
-static void macb_pcs_an_restart(struct phylink_pcs *pcs)
-{
-	/* Not supported */
-}
-
-static int macb_pcs_config(struct phylink_pcs *pcs,
-			   unsigned int neg_mode,
-			   phy_interface_t interface,
-			   const unsigned long *advertising,
-			   bool permit_pause_to_mac)
-{
-	return 0;
+	spin_unlock_irqrestore(&bp->lock, flags);
+	return changed;
 }
 
 static const struct phylink_pcs_ops macb_phylink_usx_pcs_ops = {
 	.pcs_get_state = macb_usx_pcs_get_state,
 	.pcs_config = macb_usx_pcs_config,
-	.pcs_link_up = macb_usx_pcs_link_up,
 };
 
 static const struct phylink_pcs_ops macb_phylink_pcs_ops = {
 	.pcs_get_state = macb_pcs_get_state,
-	.pcs_an_restart = macb_pcs_an_restart,
 	.pcs_config = macb_pcs_config,
+	.pcs_an_restart = macb_pcs_an_restart,
 };
 
+static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
+					       phy_interface_t interface)
+{
+	struct net_device *ndev = to_net_dev(config->dev);
+	struct macb *bp = netdev_priv(ndev);
+
+	if (interface == PHY_INTERFACE_MODE_10GBASER)
+		return &bp->phylink_usx_pcs;
+	else if (interface == PHY_INTERFACE_MODE_SGMII)
+		return &bp->phylink_sgmii_pcs;
+	else
+		return NULL;
+}
+
 static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 			    const struct phylink_link_state *state)
 {
@@ -646,18 +733,14 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 		if (state->interface == PHY_INTERFACE_MODE_RMII)
 			ctrl |= MACB_BIT(RM9200_RMII);
 	} else if (macb_is_gem(bp)) {
-		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
-		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
-
-		if (state->interface == PHY_INTERFACE_MODE_SGMII) {
-			ctrl |= GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL);
-		} else if (state->interface == PHY_INTERFACE_MODE_10GBASER) {
+		if (macb_mac_select_pcs(config, state->interface))
 			ctrl |= GEM_BIT(PCSSEL);
-			ncr |= GEM_BIT(ENABLE_HS_MAC);
-		} else if (bp->caps & MACB_CAPS_MIIONRGMII &&
-			   bp->phy_interface == PHY_INTERFACE_MODE_MII) {
+		else
+			ctrl &= ~GEM_BIT(PCSSEL);
+
+		if (bp->caps & MACB_CAPS_MIIONRGMII &&
+		    bp->phy_interface == PHY_INTERFACE_MODE_MII)
 			ncr |= MACB_BIT(MIIONRGMII);
-		}
 	}
 
 	/* Apply the new configuration, if any */
@@ -667,22 +750,6 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 	if (old_ncr ^ ncr)
 		macb_or_gem_writel(bp, NCR, ncr);
 
-	/* Disable AN for SGMII fixed link configuration, enable otherwise.
-	 * Must be written after PCSSEL is set in NCFGR,
-	 * otherwise writes will not take effect.
-	 */
-	if (macb_is_gem(bp) && state->interface == PHY_INTERFACE_MODE_SGMII) {
-		u32 pcsctrl, old_pcsctrl;
-
-		old_pcsctrl = gem_readl(bp, PCSCNTRL);
-		if (mode == MLO_AN_FIXED)
-			pcsctrl = old_pcsctrl & ~GEM_BIT(PCSAUTONEG);
-		else
-			pcsctrl = old_pcsctrl | GEM_BIT(PCSAUTONEG);
-		if (old_pcsctrl != pcsctrl)
-			gem_writel(bp, PCSCNTRL, pcsctrl);
-	}
-
 	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
@@ -735,10 +802,12 @@ static void macb_mac_link_up(struct phylink_config *config,
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 		ctrl &= ~MACB_BIT(PAE);
 		if (macb_is_gem(bp)) {
-			ctrl &= ~GEM_BIT(GBE);
+			ctrl &= ~(GEM_BIT(GBE) | GEM_BIT(ENABLE_HS_MAC));
 
 			if (speed == SPEED_1000)
 				ctrl |= GEM_BIT(GBE);
+			else if (speed == SPEED_10000)
+				ctrl |= GEM_BIT(ENABLE_HS_MAC);
 		}
 
 		if (rx_pause)
@@ -776,20 +845,6 @@ static void macb_mac_link_up(struct phylink_config *config,
 	netif_tx_wake_all_queues(ndev);
 }
 
-static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
-					       phy_interface_t interface)
-{
-	struct net_device *ndev = to_net_dev(config->dev);
-	struct macb *bp = netdev_priv(ndev);
-
-	if (interface == PHY_INTERFACE_MODE_10GBASER)
-		return &bp->phylink_usx_pcs;
-	else if (interface == PHY_INTERFACE_MODE_SGMII)
-		return &bp->phylink_sgmii_pcs;
-	else
-		return NULL;
-}
-
 static const struct phylink_mac_ops macb_phylink_ops = {
 	.mac_select_pcs = macb_mac_select_pcs,
 	.mac_config = macb_mac_config,
-- 
2.35.1.1320.gc452695387.dirty


