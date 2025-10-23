Return-Path: <netdev+bounces-232055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A01AEC0057A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC7F3350B02
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17747305978;
	Thu, 23 Oct 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zENATkq4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3A230AAC2
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212799; cv=none; b=cKMuf+SIdZlpj+cMKrUz5/rZJII/0T9jLmRAbddCVaKQurF9FLDxdDn3SzAm0YvKWsNytwsfc5bYrXAApyUhFZkOfJSsId0gIgCE7iJhv+GJIl7QNj6I7+/eGz43Q2LqMAapXFlfRVqtp8PtdRbbC1z7hVTqp5L2XQo+5ak6sHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212799; c=relaxed/simple;
	bh=x7LcanOO5jUguzsWnaHVqCWZyFdBRCdPYyuW7ZwxcCs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Vs8WgFArotZ9jyz0fyrY+1mkkQegxgGxSSM/wbNRkfdgGImxo2ItwQIfdjruTx2fwEkAiUheaoUTQSJxSprnufR9HzCl+9kzLkgUqeUNG2sYf0toqmjBfUqs/WGeRC261SBckFaCBJHVAEk8+l2ZhVBVMSggv+Durr5N07ra1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zENATkq4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lZxI4ElVQRDHDwUjNlzEzvtgHXaIDyFC91nvXTxngLA=; b=zENATkq4Lcm2pf3+N7P2MW0EL8
	u8Tiyx32llIGBSopm7LSyxe6V20ZVXf5Nsrm7are6QqBII3VMhPrqG/FaWOZTSqBM+xyS3/2hDRj5
	BRkXhq40cbDtG/t+FcoW/V8z5LfEUho6ubQOIL6ACKd9FK5sV/qM4aOhaIpL/XZVbyci8DTLU28BV
	1BPAZ2TGzKF3gSjbeVWTcUxDU+4KNyyuK8J5B4+cQMeKMHWB3AIg9GkHnqRNS7toyAI4TT0VTfIgt
	REYio8ixamC2hpEQx81FY6h3BAHCLZSXoXE+W9VuH4VGPRf6B8vaz7o5FxZQ/VZFkt2yX5pflIEq8
	63YMfYTw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60232 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrtq-0000000068s-3iZF;
	Thu, 23 Oct 2025 10:46:26 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrtp-0000000BMYs-3bhI;
	Thu, 23 Oct 2025 10:46:25 +0100
In-Reply-To: <aPn5YVeUcWo4CW3c@shell.armlinux.org.uk>
References: <aPn5YVeUcWo4CW3c@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/2] net: stmmac: add support for controlling PCS
 interrupts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrtp-0000000BMYs-3bhI@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:46:25 +0100

Add support to the PCS instance for controlling the PCS interrupts
depending on whether the PCS is used.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac1000.h   |  7 +++---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  | 11 ++++------
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  2 --
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 10 +++------
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 22 ++++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  |  4 +++-
 6 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 8f3002d9de78..697bba641e05 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -38,11 +38,10 @@
 #define	GMAC_INT_DISABLE_PCSAN		BIT(2)
 #define	GMAC_INT_DISABLE_PMT		BIT(3)
 #define	GMAC_INT_DISABLE_TIMESTAMP	BIT(9)
-#define	GMAC_INT_DISABLE_PCS	(GMAC_INT_DISABLE_PCSLINK | \
-				 GMAC_INT_DISABLE_PCSAN)
 #define	GMAC_INT_DEFAULT_MASK	(GMAC_INT_DISABLE_RGMII | \
-				 GMAC_INT_DISABLE_TIMESTAMP | \
-				 GMAC_INT_DISABLE_PCS)
+				 GMAC_INT_DISABLE_PCSLINK | \
+				 GMAC_INT_DISABLE_PCSAN | \
+				 GMAC_INT_DISABLE_TIMESTAMP)
 
 /* PMT Control and Status */
 #define GMAC_PMT		0x0000002c
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index 2ca94bfd3f71..a2ae136d2c0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -27,7 +27,9 @@ static int dwmac1000_pcs_init(struct stmmac_priv *priv)
 	if (!priv->dma_cap.pcs)
 		return 0;
 
-	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE);
+	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE,
+					  GMAC_INT_DISABLE_PCSLINK |
+					  GMAC_INT_DISABLE_PCSAN);
 }
 
 static void dwmac1000_core_init(struct mac_device_info *hw,
@@ -48,12 +50,7 @@ static void dwmac1000_core_init(struct mac_device_info *hw,
 	writel(value | GMAC_CORE_INIT, ioaddr + GMAC_CONTROL);
 
 	/* Mask GMAC interrupts */
-	value = GMAC_INT_DEFAULT_MASK;
-
-	if (hw->pcs)
-		value &= ~GMAC_INT_DISABLE_PCS;
-
-	writel(value, ioaddr + GMAC_INT_MASK);
+	writel(GMAC_INT_DEFAULT_MASK, ioaddr + GMAC_INT_MASK);
 
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Tag detection without filtering */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 6dd84b6544cc..3cb733781e1e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -106,8 +106,6 @@
 #define GMAC_INT_LPI_EN			BIT(5)
 #define GMAC_INT_TSIE			BIT(12)
 
-#define	GMAC_PCS_IRQ_DEFAULT	(GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE)
-
 #define	GMAC_INT_DEFAULT_ENABLE	(GMAC_INT_PMT_EN | GMAC_INT_LPI_EN | \
 				 GMAC_INT_TSIE)
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 6269407d70cd..a4282fd7c3c7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -27,7 +27,8 @@ static int dwmac4_pcs_init(struct stmmac_priv *priv)
 	if (!priv->dma_cap.pcs)
 		return 0;
 
-	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE);
+	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE,
+					  GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE);
 }
 
 static void dwmac4_core_init(struct mac_device_info *hw,
@@ -46,12 +47,7 @@ static void dwmac4_core_init(struct mac_device_info *hw,
 	writel((clk_rate / 1000000) - 1, ioaddr + GMAC4_MAC_ONEUS_TIC_COUNTER);
 
 	/* Enable GMAC interrupts */
-	value = GMAC_INT_DEFAULT_ENABLE;
-
-	if (hw->pcs)
-		value |= GMAC_PCS_IRQ_DEFAULT;
-
-	writel(value, ioaddr + GMAC_INT_EN);
+	writel(GMAC_INT_DEFAULT_ENABLE, ioaddr + GMAC_INT_EN);
 
 	if (GMAC_INT_DEFAULT_ENABLE & GMAC_INT_TSIE)
 		init_waitqueue_head(&priv->tstamp_busy_wait);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index 50ea51d7a1cc..e2f531c11986 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -2,6 +2,22 @@
 #include "stmmac.h"
 #include "stmmac_pcs.h"
 
+static int dwmac_integrated_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
+
+	stmmac_mac_irq_modify(spcs->priv, 0, spcs->int_mask);
+
+	return 0;
+}
+
+static void dwmac_integrated_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct stmmac_pcs *spcs = phylink_pcs_to_stmmac_pcs(pcs);
+
+	stmmac_mac_irq_modify(spcs->priv, spcs->int_mask, 0);
+}
+
 static void dwmac_integrated_pcs_get_state(struct phylink_pcs *pcs,
 					   unsigned int neg_mode,
 					   struct phylink_link_state *state)
@@ -23,11 +39,14 @@ static int dwmac_integrated_pcs_config(struct phylink_pcs *pcs,
 }
 
 static const struct phylink_pcs_ops dwmac_integrated_pcs_ops = {
+	.pcs_enable = dwmac_integrated_pcs_enable,
+	.pcs_disable = dwmac_integrated_pcs_disable,
 	.pcs_get_state = dwmac_integrated_pcs_get_state,
 	.pcs_config = dwmac_integrated_pcs_config,
 };
 
-int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset)
+int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
+			       u32 int_mask)
 {
 	struct stmmac_pcs *spcs;
 
@@ -37,6 +56,7 @@ int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset)
 
 	spcs->priv = priv;
 	spcs->base = priv->ioaddr + offset;
+	spcs->int_mask = int_mask;
 	spcs->pcs.ops = &dwmac_integrated_pcs_ops;
 
 	__set_bit(PHY_INTERFACE_MODE_SGMII, spcs->pcs.supported_interfaces);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index 64397ac8ecab..cda93894168e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -52,6 +52,7 @@ struct stmmac_priv;
 struct stmmac_pcs {
 	struct stmmac_priv *priv;
 	void __iomem *base;
+	u32 int_mask;
 	struct phylink_pcs pcs;
 };
 
@@ -61,7 +62,8 @@ phylink_pcs_to_stmmac_pcs(struct phylink_pcs *pcs)
 	return container_of(pcs, struct stmmac_pcs, pcs);
 }
 
-int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset);
+int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
+			       u32 int_mask);
 
 /**
  * dwmac_pcs_isr - TBI, RTBI, or SGMII PHY ISR
-- 
2.47.3


