Return-Path: <netdev+bounces-99719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA808D60A6
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C36DB1C23CEF
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B68015746D;
	Fri, 31 May 2024 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l6AvPnST"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C055894
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154800; cv=none; b=ijMlIutsMFQjJE3pj+aNaX3dx3p71rpIzq2Xu8taGpImHuDB+yP9HY9r5ri6sWjEXojAoRJmS3bBrJIa7o2ud72VSZ4gFTa4K58mw6fSaWkJhudOxLsD/Zv725qfXHz8koa0YLNZ+eIAijM6jROJ+h5vALnetuX1BGA/84iHKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154800; c=relaxed/simple;
	bh=uN4nEp/qSdBLmc4QgZK340QgOlX918yIdAyDiy/rAhc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=O3z6Vki7H9W9e0qJSEa/qpWj2pUXAIwNggKHagvCOzoW6ttBJglM0diro4lCSTf+w+vm+1j+hVY0FNBm0h26yNJTglIyS+UkeNz62K00xGay7ZrdS+hOeikOyleKfGfcmdBaLSMilUc94CJKtSf9bLW7ksKM/TC3OdgzXnVKaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l6AvPnST; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w+hJV1Y6OwOM4T6mSnn7qj2UsDUhsehMQ+K2hdlXRfg=; b=l6AvPnSTSdekvL8SdZWe4tLxMW
	d5kbnJNAwhAAZBiHDU0B2DJMaqX1mRBXpOQqc6V4kPMojnbRPAMRNucwbxMJZjwjQoStjvD1x2M0o
	zaDBIKrre1FRiWH/r5qCMcHq/64B5fQ/WkimHPp1I9nj1fiEkxtPV0fT8PxUy/G5ohwnSW8Q1DfKl
	szHv/Yf8M/FjKdrY9LgvbpnJwSruFwIjl/YrxV/oXJauR7DOdkoIZMdfKEmSO0L7INO5Apf8Vdj2Y
	yeFr+4p3vUfb8k1svXuijBWKdo2V11n44fq1cd5L6QeSxKBs+lxtjUtP2oVbVVrfQg1XMRVo+DFKB
	1C8V5gfw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59326 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sD0Os-0008Ri-2Y;
	Fri, 31 May 2024 12:26:22 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sD0Ov-00EzBu-BC; Fri, 31 May 2024 12:26:25 +0100
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
Subject: [PATCH RFC net-next v2 3/8] net: stmmac: dwmac1000: convert
 sgmii/rgmii "pcs" to phylink
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sD0Ov-00EzBu-BC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 31 May 2024 12:26:25 +0100

Convert dwmac1000 sgmii/rgmii "pcs" implementation to use a phylink_pcs
so we can eventually get rid of the exceptional paths that conflict
with phylink.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 113 ++++++++++++------
 1 file changed, 75 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index d413d76a8936..4a0572d5f865 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/ethtool.h>
 #include <linux/io.h>
+#include <linux/phylink.h>
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 #include "dwmac1000.h"
@@ -261,39 +262,6 @@ static void dwmac1000_pmt(struct mac_device_info *hw, unsigned long mode)
 	writel(pmt, ioaddr + GMAC_PMT);
 }
 
-/* RGMII or SMII interface */
-static void dwmac1000_rgsmii(void __iomem *ioaddr, struct stmmac_extra_stats *x)
-{
-	u32 status;
-
-	status = readl(ioaddr + GMAC_RGSMIIIS);
-	x->irq_rgmii_n++;
-
-	/* Check the link status */
-	if (status & GMAC_RGSMIIIS_LNKSTS) {
-		int speed_value;
-
-		x->pcs_link = 1;
-
-		speed_value = ((status & GMAC_RGSMIIIS_SPEED) >>
-			       GMAC_RGSMIIIS_SPEED_SHIFT);
-		if (speed_value == GMAC_RGSMIIIS_SPEED_125)
-			x->pcs_speed = SPEED_1000;
-		else if (speed_value == GMAC_RGSMIIIS_SPEED_25)
-			x->pcs_speed = SPEED_100;
-		else
-			x->pcs_speed = SPEED_10;
-
-		x->pcs_duplex = (status & GMAC_RGSMIIIS_LNKMOD_MASK);
-
-		pr_info("Link is Up - %d/%s\n", (int)x->pcs_speed,
-			x->pcs_duplex ? "Full" : "Half");
-	} else {
-		x->pcs_link = 0;
-		pr_info("Link is Down\n");
-	}
-}
-
 static int dwmac1000_irq_status(struct mac_device_info *hw,
 				struct stmmac_extra_stats *x)
 {
@@ -335,8 +303,12 @@ static int dwmac1000_irq_status(struct mac_device_info *hw,
 
 	dwmac_pcs_isr(ioaddr, GMAC_PCS_BASE, intr_status, x);
 
-	if (intr_status & PCS_RGSMIIIS_IRQ)
-		dwmac1000_rgsmii(ioaddr, x);
+	if (intr_status & PCS_RGSMIIIS_IRQ) {
+		/* TODO Dummy-read to clear the IRQ status */
+		readl(ioaddr + GMAC_RGSMIIIS);
+		phylink_pcs_change(&hw->mac_pcs, false);
+		x->irq_rgmii_n++;
+	}
 
 	return ret;
 }
@@ -404,9 +376,71 @@ static void dwmac1000_ctrl_ane(void __iomem *ioaddr, bool ane, bool srgmi_ral,
 	dwmac_ctrl_ane(ioaddr, GMAC_PCS_BASE, ane, srgmi_ral, loopback);
 }
 
-static void dwmac1000_get_adv_lp(void __iomem *ioaddr, struct rgmii_adv *adv)
+static int dwmac1000_mii_pcs_validate(struct phylink_pcs *pcs,
+				      unsigned long *supported,
+				      const struct phylink_link_state *state)
+{
+	/* Only support in-band */
+	if (!test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, state->advertising))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dwmac1000_mii_pcs_config(struct phylink_pcs *pcs,
+				    unsigned int neg_mode,
+				    phy_interface_t interface,
+				    const unsigned long *advertising,
+				    bool permit_pause_to_mac)
 {
-	dwmac_get_adv_lp(ioaddr, GMAC_PCS_BASE, adv);
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+
+	return dwmac_pcs_config(hw, neg_mode, interface, advertising,
+				GMAC_PCS_BASE);
+}
+
+static void dwmac1000_mii_pcs_get_state(struct phylink_pcs *pcs,
+					struct phylink_link_state *state)
+{
+	struct mac_device_info *hw = phylink_pcs_to_mac_dev_info(pcs);
+	unsigned int spd_clk;
+	u32 status;
+
+	status = readl(hw->pcsr + GMAC_RGSMIIIS);
+
+	state->link = status & GMAC_RGSMIIIS_LNKSTS;
+	if (!state->link)
+		return;
+
+	spd_clk = FIELD_GET(GMAC_RGSMIIIS_SPEED, status);
+	if (spd_clk == GMAC_RGSMIIIS_SPEED_125)
+		state->speed = SPEED_1000;
+	else if (spd_clk == GMAC_RGSMIIIS_SPEED_25)
+		state->speed = SPEED_100;
+	else if (spd_clk == GMAC_RGSMIIIS_SPEED_2_5)
+		state->speed = SPEED_10;
+
+	state->duplex = status & GMAC_RGSMIIIS_LNKMOD_MASK ?
+			DUPLEX_FULL : DUPLEX_HALF;
+
+	dwmac_pcs_get_state(hw, state, GMAC_PCS_BASE);
+}
+
+static const struct phylink_pcs_ops dwmac1000_mii_pcs_ops = {
+	.pcs_validate = dwmac1000_mii_pcs_validate,
+	.pcs_config = dwmac1000_mii_pcs_config,
+	.pcs_get_state = dwmac1000_mii_pcs_get_state,
+};
+
+static struct phylink_pcs *
+dwmac1000_phylink_select_pcs(struct stmmac_priv *priv,
+			     phy_interface_t interface)
+{
+	if (priv->hw->pcs & STMMAC_PCS_RGMII ||
+	    priv->hw->pcs & STMMAC_PCS_SGMII)
+		return &priv->hw->mac_pcs;
+
+	return NULL;
 }
 
 static void dwmac1000_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -499,6 +533,7 @@ static void dwmac1000_set_mac_loopback(void __iomem *ioaddr, bool enable)
 
 const struct stmmac_ops dwmac1000_ops = {
 	.core_init = dwmac1000_core_init,
+	.phylink_select_pcs = dwmac1000_phylink_select_pcs,
 	.set_mac = stmmac_set_mac,
 	.rx_ipc = dwmac1000_rx_ipc_enable,
 	.dump_regs = dwmac1000_dump_regs,
@@ -514,7 +549,6 @@ const struct stmmac_ops dwmac1000_ops = {
 	.set_eee_pls = dwmac1000_set_eee_pls,
 	.debug = dwmac1000_debug,
 	.pcs_ctrl_ane = dwmac1000_ctrl_ane,
-	.pcs_get_adv_lp = dwmac1000_get_adv_lp,
 	.set_mac_loopback = dwmac1000_set_mac_loopback,
 };
 
@@ -549,5 +583,8 @@ int dwmac1000_setup(struct stmmac_priv *priv)
 	mac->mii.clk_csr_shift = 2;
 	mac->mii.clk_csr_mask = GENMASK(5, 2);
 
+	mac->mac_pcs.ops = &dwmac1000_mii_pcs_ops;
+	mac->mac_pcs.neg_mode = true;
+
 	return 0;
 }
-- 
2.30.2


