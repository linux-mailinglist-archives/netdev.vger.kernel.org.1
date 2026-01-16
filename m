Return-Path: <netdev+bounces-250366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8654D29727
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 01:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FA9030084F5
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 00:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E713093DB;
	Fri, 16 Jan 2026 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mVjHQHzm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D6518024
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 00:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524581; cv=none; b=QHbSoKIal+ZYbskXvo8bn4R3oFTxfLkr/vRclgVTDjstX+yhxgcMpZKSYCfO037ByOTS3mvB50s4Wlm6qudWCXt3RyyPDYrhqWGvpnBipM04dhialwfCZ30Jwl2wb0vae3GzVQhQfC0fDybETlxBKdz3fhWK3qg/bCLWNK7qjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524581; c=relaxed/simple;
	bh=REZSzb8Fhmc+nIkNMwOCW0S+HKga39UjmPkgZg3qf1o=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=K5+wKggXJx4/zm2neYxWszQfojli/lBRmVASBEwrnTtDPXJIut2NMkYS0ELhUqVE5RHhYridraKb4ybJoyBuRosSToW8P+9jbHq8KXFKQQLdGQjbBRso6wfvHfD7DEBtkUZpHZl5qbnwCguqgmingif4NSjAbyhBPWCtFQ/HCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mVjHQHzm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=coMklXB781im7lw/0AY6BqxU9Hmev4f7cn7mlclUrZg=; b=mVjHQHzmdB/eGWZ22lq/xsH55A
	yR7RzWFsg0h+YaqdYnqkFALMHvq4Zo7YAWPACHaJqwonndEksWbbcypN1xqPgXGc4O1OIuTl0LH/R
	e7XWu+FKFY3tYIvElLhZboKJDsuIdG3NAXgoZOa2Cn4CCvMB+mCQPOpzoOBw02DA5BXOj05J71tcO
	lpQh3MYbI0x0ATYJ7yo/LJVUjQEnu833t8K4Mr0CFlW0EtroNVGZVJLjaJxQs1ExXZes0KK6R+9QT
	FasV2f/IiKka77sw7KKp1RYFAkuCLLX02VHyW1VXJpOC5tuOH0TjjSgA7+9dIF8cmQq6hLekDefZA
	+EcM8/tg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56166 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vgY1l-000000001mQ-05Sq;
	Fri, 16 Jan 2026 00:49:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vgY1k-00000003vOC-0Z1H;
	Fri, 16 Jan 2026 00:49:24 +0000
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
Subject: [PATCH net-next] net: stmmac: fix dwmac4 transmit performance
 regression
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vgY1k-00000003vOC-0Z1H@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 16 Jan 2026 00:49:24 +0000

dwmac4's transmit performance dropped by a factor of four due to an
incorrect assumption about which definitions are for what. This
highlights the need for sane register macros.

Commit 8409495bf6c9 ("net: stmmac: cores: remove many xxx_SHIFT
definitions") changed the way the txpbl value is merged into the
register:

        value = readl(ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, chan));
-       value = value | (txpbl << DMA_BUS_MODE_PBL_SHIFT);
+       value = value | FIELD_PREP(DMA_BUS_MODE_PBL, txpbl);

With the following in the header file:

 #define DMA_BUS_MODE_PBL               BIT(16)
-#define DMA_BUS_MODE_PBL_SHIFT         16

The assumption here was that DMA_BUS_MODE_PBL was the mask for
DMA_BUS_MODE_PBL_SHIFT, but this turns out not to be the case.

The field is actually six bits wide, buts 21:16, and is called
TXPBL.

What's even more confusing is, there turns out to be a PBLX8
single bit in the DMA_CHAN_CONTROL register (0x1100 for channel 0),
and DMA_BUS_MODE_PBL seems to be used for that. However, this bit
et.al. was listed under a comment "/* DMA SYS Bus Mode bitmap */"
which is for register 0x1004.

Fix this up by adding an appropriately named field definition under
the DMA_CHAN_TX_CONTROL() register address definition.

Move the RPBL mask definition under DMA_CHAN_RX_CONTROL(), correctly
renaming it as well.

Also move the PBL bit definition under DMA_CHAN_CONTROL(), correctly
renaming it.

This removes confusion over the PBL fields.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c | 8 ++++----
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 7036beccfc85..aaa83e9ff4f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -52,7 +52,7 @@ static void dwmac4_dma_init_rx_chan(struct stmmac_priv *priv,
 	u32 rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
 
 	value = readl(ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, chan));
-	value = value | FIELD_PREP(DMA_BUS_MODE_RPBL_MASK, rxpbl);
+	value = value | FIELD_PREP(DMA_CHAN_RX_CTRL_RXPBL_MASK, rxpbl);
 	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, chan));
 
 	if (IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) && likely(dma_cfg->eame))
@@ -73,7 +73,7 @@ static void dwmac4_dma_init_tx_chan(struct stmmac_priv *priv,
 	u32 txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
 
 	value = readl(ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, chan));
-	value = value | FIELD_PREP(DMA_BUS_MODE_PBL, txpbl);
+	value = value | FIELD_PREP(DMA_CHAN_TX_CTRL_TXPBL_MASK, txpbl);
 
 	/* Enable OSP to get best performance */
 	value |= DMA_CONTROL_OSP;
@@ -98,7 +98,7 @@ static void dwmac4_dma_init_channel(struct stmmac_priv *priv,
 	/* common channel control register config */
 	value = readl(ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
 	if (dma_cfg->pblx8)
-		value = value | DMA_BUS_MODE_PBL;
+		value = value | DMA_CHAN_CTRL_PBLX8;
 	writel(value, ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
 
 	/* Mask interrupts by writing to CSR7 */
@@ -116,7 +116,7 @@ static void dwmac410_dma_init_channel(struct stmmac_priv *priv,
 	/* common channel control register config */
 	value = readl(ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
 	if (dma_cfg->pblx8)
-		value = value | DMA_BUS_MODE_PBL;
+		value = value | DMA_CHAN_CTRL_PBLX8;
 
 	writel(value, ioaddr + DMA_CHAN_CONTROL(dwmac4_addrs, chan));
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 5f1e2916f099..9d9077a4ac9f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -24,8 +24,6 @@
 
 #define DMA_SYS_BUS_MODE		0x00001004
 
-#define DMA_BUS_MODE_PBL		BIT(16)
-#define DMA_BUS_MODE_RPBL_MASK		GENMASK(21, 16)
 #define DMA_BUS_MODE_MB			BIT(14)
 #define DMA_BUS_MODE_FB			BIT(0)
 
@@ -68,19 +66,22 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 
 #define DMA_CHAN_CONTROL(addrs, x)	dma_chanx_base_addr(addrs, x)
 
+#define DMA_CHAN_CTRL_PBLX8		BIT(16)
 #define DMA_CONTROL_SPH			BIT(24)
 
 #define DMA_CHAN_TX_CONTROL(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x4)
 
 #define DMA_CONTROL_EDSE		BIT(28)
+#define DMA_CHAN_TX_CTRL_TXPBL_MASK	GENMASK(21, 16)
 #define DMA_CONTROL_TSE			BIT(12)
 #define DMA_CONTROL_OSP			BIT(4)
 #define DMA_CONTROL_ST			BIT(0)
 
 #define DMA_CHAN_RX_CONTROL(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x8)
 
-#define DMA_CONTROL_SR			BIT(0)
+#define DMA_CHAN_RX_CTRL_RXPBL_MASK	GENMASK(21, 16)
 #define DMA_RBSZ_MASK			GENMASK(14, 1)
+#define DMA_CONTROL_SR			BIT(0)
 
 #define DMA_CHAN_TX_BASE_ADDR_HI(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x10)
 #define DMA_CHAN_TX_BASE_ADDR(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x14)
-- 
2.47.3


