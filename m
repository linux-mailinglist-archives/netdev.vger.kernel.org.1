Return-Path: <netdev+bounces-99721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48658D60AB
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C19531C23CBD
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE9157492;
	Fri, 31 May 2024 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L7TkgavT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07B4157470
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154812; cv=none; b=Z5ZjikyVXbpJIg4xjQ6S6RIQajq2yuCN2z7jngctLE7W8mRzkkInM9lA0Mm2UKecSI2k7ChgCUplgLCJST7Zr7Ft7S2AMtU5dAknAt9FqvD41DFwBCY/hxGEtChaRugTsKZe+StpVqrcYTc53jzyxr37FFYTnxNdooGf5REbcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154812; c=relaxed/simple;
	bh=cKN5lf6pA+apt/jEK8jbRQ79SOOxpYB3vUcvj7l6qN4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mXmqLl6+ht5IlcL58jfv6qLJWh1DMKTpdFA7KZtwsomwg7UOv5xY0/7syB4IKd/unG6/GYcAjanpESnJJTYpf7qpuwF5hHB0BAL74brHwihOgYDFFXm03NSOqSTtNGObWq05TKevU2e1xUYhPyrumtsROCVKoBJDX/n5cXK7ZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L7TkgavT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qpacFX5VDJA8hqeTYWlxmcQDH7WR5LnO+Gr7wC03k4w=; b=L7TkgavT1I7Vf1zeF5TFVRCPEj
	0UPVZGv3ZgRnjkTWVNNzu2n5AQh1Df3/3thGflGhS2FAq/7zroKoA6mivRDAILqrgIdkZex/CJFcU
	BKPeGVCH5kDg8cofP/zjhBEXFZehElg+s8bjcbV+lps6t5AIFtJjSlbZiG8X16V6cb960ZcVsQtVD
	RPH6tbt9WW9P+cYxz0tYA2Ca7CTYO9GEy+PBbFZ2Emkx/uE6BjyKlTgImQ53aiYyqqJvdRJ/Bukku
	p+w1NEaxttykYdhObzu5gsprW6EWa0P0cITE8Xq0hnvVtITNclt+87XfH60XjCaXvDGDm+Xwe3VuE
	7bsd8KoQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44060 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sD0P4-0008SI-09;
	Fri, 31 May 2024 12:26:34 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sD0P5-00EzC6-Me; Fri, 31 May 2024 12:26:35 +0100
In-Reply-To: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC net-next v2 5/8] net: stmmac: dwmac4: convert sgmii/rgmii
 "pcs" to phylink
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sD0P5-00EzC6-Me@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 31 May 2024 12:26:35 +0100

Convert dwmac4 sgmii/rgmii "pcs" implementation to use a phylink_pcs
so we can eventually get rid of the exceptional paths that conflict
with phylink.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 102 ++++++++++++------
 1 file changed, 72 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index dbd9f93b2460..cb99cb69c52b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/phylink.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac4.h"
@@ -758,42 +759,76 @@ static void dwmac4_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
 	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
 }
 
-static void dwmac4_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
+static int dwmac4_mii_pcs_validate(struct phylink_pcs *pcs,
+				   unsigned long *supported,
+				   const struct phylink_link_state *state)
 {
-	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
+	/* Only support in-band */
+	if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, state->advertising))
+		return -EINVAL;
+
+	return 0;
 }
 
-/* RGMII or SMII interface */
-static void dwmac4_phystatus(void __iomem *ioaddr, struct stmmac_extra_stats *x)
+static int dwmac4_mii_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+				 phy_interface_t interface,
+				 const unsigned long *advertising,
+				 bool permit_pause_to_mac)
 {
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+
+	return dwmac_pcs_config(hw, neg_mode, interface, advertising,
+				GMAC_PCS_BASE);
+}
+
+static void dwmac4_mii_pcs_get_state(struct phylink_pcs *pcs,
+				     struct phylink_link_state *state)
+{
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+	unsigned int clk_spd;
 	u32 status;
 
-	status = readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
-	x->irq_rgmii_n++;
+	status = readl(hw->pcsr + GMAC_PHYIF_CONTROL_STATUS);
+
+	state->link = !!(status & GMAC_PHYIF_CTRLSTATUS_LNKSTS);
+	if (!state->link)
+		return;
 
-	/* Check the link status */
-	if (status & GMAC_PHYIF_CTRLSTATUS_LNKSTS) {
-		int speed_value;
+	clk_spd = FIELD_GET(GMAC_PHYIF_CTRLSTATUS_SPEED, status);
+	if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_125)
+		state->speed = SPEED_1000;
+	else if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_25)
+		state->speed = SPEED_100;
+	else if (clk_spd == GMAC_PHYIF_CTRLSTATUS_SPEED_2_5)
+		state->speed = SPEED_10;
+
+	/* FIXME: Is this even correct?
+	 * GMAC_PHYIF_CTRLSTATUS_TC = BIT(0)
+	 * GMAC_PHYIF_CTRLSTATUS_LNKMOD = BIT(16)
+	 * GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK = 1
+	 *
+	 * The result is, we test bit 0 for the duplex setting.
+	 */
+	state->duplex = status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK ?
+			DUPLEX_FULL : DUPLEX_HALF;
 
-		x->pcs_link = 1;
+	dwmac_pcs_get_state(hw, state, GMAC_PCS_BASE);
+}
 
-		speed_value = ((status & GMAC_PHYIF_CTRLSTATUS_SPEED) >>
-			       GMAC_PHYIF_CTRLSTATUS_SPEED_SHIFT);
-		if (speed_value == GMAC_PHYIF_CTRLSTATUS_SPEED_125)
-			x->pcs_speed = SPEED_1000;
-		else if (speed_value == GMAC_PHYIF_CTRLSTATUS_SPEED_25)
-			x->pcs_speed = SPEED_100;
-		else
-			x->pcs_speed = SPEED_10;
+static const struct phylink_pcs_ops dwmac4_mii_pcs_ops = {
+	.pcs_validate = dwmac4_mii_pcs_validate,
+	.pcs_config = dwmac4_mii_pcs_config,
+	.pcs_get_state = dwmac4_mii_pcs_get_state,
+};
 
-		x->pcs_duplex = (status & GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK);
+static struct phylink_pcs *
+dwmac4_phylink_select_pcs(struct stmmac_priv *priv, phy_interface_t interface)
+{
+	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
+	    priv->hw->pcs & STMMAC_PCS_SGMII)
+		return &priv->hw->mac_pcs;
 
-		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
-			x->pcs_duplex ? "Full" : "Half");
-	} else {
-		x->pcs_link = 0;
-		pr_info("Link is Down\n");
-	}
+	return NULL;
 }
 
 static int dwmac4_irq_mtl_status(struct stmmac_priv *priv,
@@ -867,8 +902,12 @@ static int dwmac4_irq_status(struct mac_device_info *hw,
 	}
 
 	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
-	if (intr_status & PCS_RGSMIIIS_IRQ)
-		dwmac4_phystatus(ioaddr, x);
+	if (intr_status & PCS_RGSMIIIS_IRQ) {
+		/* TODO Dummy-read to clear the IRQ status */
+		readl(ioaddr + GMAC_PHYIF_CONTROL_STATUS);
+		phylink_pcs_change(&hw->mac_pcs, false);
+		x->irq_rgmii_n++;
+	}
 
 	return ret;
 }
@@ -1186,6 +1225,7 @@ static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
 const struct stmmac_ops dwmac4_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
+	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1210,7 +1250,6 @@ const struct stmmac_ops dwmac4_ops = {
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
-	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
@@ -1230,6 +1269,7 @@ const struct stmmac_ops dwmac4_ops = {
 const struct stmmac_ops dwmac410_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
+	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1254,7 +1294,6 @@ const struct stmmac_ops dwmac410_ops = {
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
-	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.flex_pps_config = dwmac5_flex_pps_config,
@@ -1278,6 +1317,7 @@ const struct stmmac_ops dwmac410_ops = {
 const struct stmmac_ops dwmac510_ops = {
 	.core_init = dwmac4_core_init,
 	.update_caps = dwmac4_update_caps,
+	.phylink_select_pcs = dwmac4_phylink_select_pcs,
 	.set_mac = stmmac_dwmac4_set_mac,
 	.rx_ipc = dwmac4_rx_ipc_enable,
 	.rx_queue_enable = dwmac4_rx_queue_enable,
@@ -1302,7 +1342,6 @@ const struct stmmac_ops dwmac510_ops = {
 	.set_eee_timer = dwmac4_set_eee_timer,
 	.set_eee_pls = dwmac4_set_eee_pls,
 	.pcs_ctrl_ane = dwmac4_ctrl_ane,
-	.pcs_get_adv_lp = dwmac4_get_adv_lp,
 	.debug = dwmac4_debug,
 	.set_filter = dwmac4_set_filter,
 	.safety_feat_config = dwmac5_safety_feat_config,
@@ -1391,5 +1430,8 @@ int dwmac4_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_mask = GENMASK(11, 8);
 	mac->num_vlan = dwmac4_get_num_vlan(priv->ioaddr);
 
+	mac->mac_pcs.ops = &dwmac4_mii_pcs_ops;
+	mac->mac_pcs.neg_mode = true;
+
 	return 0;
 }
-- 
2.30.2


