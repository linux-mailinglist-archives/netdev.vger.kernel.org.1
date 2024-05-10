Return-Path: <netdev+bounces-95176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984838C1A2C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 02:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 942A51C215DD
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D205173;
	Fri, 10 May 2024 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PgQVjNi9"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829E7F
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299423; cv=none; b=jyyett0lMBnrPAYz2tQVIxwMZo6ma+zUC+wHY0ysukJG2rM3Fj7/baFWSC4OaRKjhHv2lE2htlXB6WpyeHKGRqlava7CQTtlj5xBH7NH8/ZboyOubOJxwFzEcLiqHKXcYO5sUhajnzAoOfAmQmWSVraKbj60U/DY+uRXx9+331Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299423; c=relaxed/simple;
	bh=OnZCHGSKPaNuGmEUTmPZsqOerRbhIwNlERnZQm6fMXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSj63+i80Gmy00xRHZQGSQVrlr4vs4aIxtMmv61f+rLm3hLQdtiye51T5HNYZz+ZCrgcQ3XprAVZsd1KLAmndvKSQwKemmOuBGLXOlgHCfpTNQwseX8njCicyLhd8RtJqWDi1Xiy6XOGKPL575bT8mn2RUJNAOVQwyXxCPp+K0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PgQVjNi9; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 844E1C0000F6;
	Thu,  9 May 2024 17:03:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 844E1C0000F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1715299414;
	bh=OnZCHGSKPaNuGmEUTmPZsqOerRbhIwNlERnZQm6fMXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgQVjNi93am/7OsxT9MtYWx/gS/aCQgXbbejRteFkmuXeKbnYJQO6+yTsObbFxZSu
	 RRt5N8C2Nlr0S9fML/Uew+f6Qh2ddsOfjVmtYr0rPLp+s98T2QK48s2MG58AhQnA00
	 pqxAS1N/R5+CmCzSouJUJFKVuB42Nmn4buipyru8=
Received: from lvnvdd6494.lvn.broadcom.net (lvnvdd6494.lvn.broadcom.net [10.36.237.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 9BC6A18041CAC6;
	Thu,  9 May 2024 17:03:32 -0700 (PDT)
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
To: netdev@vger.kernel.org
Cc: jitendra.vegiraju@broadcom.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH, net-next, 1/2] net: stmmac: Export dma_ops for reuse in glue drivers.
Date: Thu,  9 May 2024 17:03:30 -0700
Message-Id: <20240510000331.154486-2-jitendra.vegiraju@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240510000331.154486-1-jitendra.vegiraju@broadcom.com>
References: <20240510000331.154486-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding a new glue driver that relies on common
functionality provide by dwxgmac2 core functions.
The new device is mostly similar to dwxgmac2 implementation but,
with minor conflicting differences in certain operations.

By exporting the dwxgmac2 dma operations, new glue drivers
can reuse common functions.

Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  62 ++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 149 +++++++++++-------
 2 files changed, 150 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 6a2c7d22df1e..d4aa8e290ca1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -495,4 +495,66 @@
 #define XGMAC_RDES3_TSD			BIT(6)
 #define XGMAC_RDES3_TSA			BIT(4)
 
+int dwxgmac2_dma_reset(void __iomem *ioaddr);
+void dwxgmac2_dma_init(void __iomem *ioaddr,
+		       struct stmmac_dma_cfg *dma_cfg, int atds);
+void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
+			    void __iomem *ioaddr,
+			    struct stmmac_dma_cfg *dma_cfg, u32 chan);
+void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t phy, u32 chan);
+void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t phy, u32 chan);
+void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi);
+void dwxgmac2_dma_dump_regs(struct stmmac_priv *priv,
+			    void __iomem *ioaddr, u32 *reg_space);
+void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  int mode, u32 channel, int fifosz, u8 qmode);
+void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  int mode, u32 channel, int fifosz, u8 qmode);
+void dwxgmac2_enable_dma_irq(struct stmmac_priv *priv,
+			     void __iomem *ioaddr, u32 chan,
+			     bool rx, bool tx);
+void dwxgmac2_disable_dma_irq(struct stmmac_priv *priv,
+			      void __iomem *ioaddr, u32 chan,
+			      bool rx, bool tx);
+void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
+			   void __iomem *ioaddr, u32 chan);
+void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  u32 chan);
+void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
+			   void __iomem *ioaddr, u32 chan);
+void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  u32 chan);
+int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
+			   void __iomem *ioaddr,
+			   struct stmmac_extra_stats *x, u32 chan,
+			   u32 dir);
+int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
+			    struct dma_features *dma_cap);
+void dwxgmac2_rx_watchdog(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  u32 riwt, u32 queue);
+void dwxgmac2_set_rx_ring_len(struct stmmac_priv *priv,
+			      void __iomem *ioaddr, u32 len, u32 chan);
+void dwxgmac2_set_tx_ring_len(struct stmmac_priv *priv,
+			      void __iomem *ioaddr, u32 len, u32 chan);
+void dwxgmac2_set_rx_tail_ptr(struct stmmac_priv *priv,
+			      void __iomem *ioaddr, u32 ptr, u32 chan);
+void dwxgmac2_set_tx_tail_ptr(struct stmmac_priv *priv,
+			      void __iomem *ioaddr, u32 ptr, u32 chan);
+void dwxgmac2_enable_tso(struct stmmac_priv *priv, void __iomem *ioaddr,
+			 bool en, u32 chan);
+void dwxgmac2_qmode(struct stmmac_priv *priv, void __iomem *ioaddr,
+		    u32 channel, u8 qmode);
+void dwxgmac2_set_bfsize(struct stmmac_priv *priv, void __iomem *ioaddr,
+			 int bfsize, u32 chan);
+void dwxgmac2_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
+			 bool en, u32 chan);
+int dwxgmac2_enable_tbs(struct stmmac_priv *priv, void __iomem *ioaddr,
+			bool en, u32 chan);
+
 #endif /* __STMMAC_DWXGMAC2_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index dd2ab6185c40..f437b63f57b9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -8,7 +8,7 @@
 #include "stmmac.h"
 #include "dwxgmac2.h"
 
-static int dwxgmac2_dma_reset(void __iomem *ioaddr)
+int dwxgmac2_dma_reset(void __iomem *ioaddr)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_MODE);
 
@@ -18,9 +18,10 @@ static int dwxgmac2_dma_reset(void __iomem *ioaddr)
 	return readl_poll_timeout(ioaddr + XGMAC_DMA_MODE, value,
 				  !(value & XGMAC_SWR), 0, 100000);
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_reset);
 
-static void dwxgmac2_dma_init(void __iomem *ioaddr,
-			      struct stmmac_dma_cfg *dma_cfg, int atds)
+void dwxgmac2_dma_init(void __iomem *ioaddr,
+		       struct stmmac_dma_cfg *dma_cfg, int atds)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
 
@@ -32,10 +33,11 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_init);
 
-static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
-				   void __iomem *ioaddr,
-				   struct stmmac_dma_cfg *dma_cfg, u32 chan)
+void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
+			    void __iomem *ioaddr,
+			    struct stmmac_dma_cfg *dma_cfg, u32 chan)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_CH_CONTROL(chan));
 
@@ -45,11 +47,12 @@ static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
 	writel(value, ioaddr + XGMAC_DMA_CH_CONTROL(chan));
 	writel(XGMAC_DMA_INT_DEFAULT_EN, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_init_chan);
 
-static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
-				      void __iomem *ioaddr,
-				      struct stmmac_dma_cfg *dma_cfg,
-				      dma_addr_t phy, u32 chan)
+void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t phy, u32 chan)
 {
 	u32 rxpbl = dma_cfg->rxpbl ?: dma_cfg->pbl;
 	u32 value;
@@ -62,11 +65,12 @@ static void dwxgmac2_dma_init_rx_chan(struct stmmac_priv *priv,
 	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
 	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_init_rx_chan);
 
-static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
-				      void __iomem *ioaddr,
-				      struct stmmac_dma_cfg *dma_cfg,
-				      dma_addr_t phy, u32 chan)
+void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
+			       void __iomem *ioaddr,
+			       struct stmmac_dma_cfg *dma_cfg,
+			       dma_addr_t phy, u32 chan)
 {
 	u32 txpbl = dma_cfg->txpbl ?: dma_cfg->pbl;
 	u32 value;
@@ -80,8 +84,9 @@ static void dwxgmac2_dma_init_tx_chan(struct stmmac_priv *priv,
 	writel(upper_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
 	writel(lower_32_bits(phy), ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_init_tx_chan);
 
-static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
+void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
 	int i;
@@ -133,18 +138,20 @@ static void dwxgmac2_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 	writel(XGMAC_TDPS, ioaddr + XGMAC_TX_EDMA_CTRL);
 	writel(XGMAC_RDPS, ioaddr + XGMAC_RX_EDMA_CTRL);
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_axi);
 
-static void dwxgmac2_dma_dump_regs(struct stmmac_priv *priv,
-				   void __iomem *ioaddr, u32 *reg_space)
+void dwxgmac2_dma_dump_regs(struct stmmac_priv *priv,
+			    void __iomem *ioaddr, u32 *reg_space)
 {
 	int i;
 
 	for (i = (XGMAC_DMA_MODE / 4); i < XGMAC_REGSIZE; i++)
 		reg_space[i] = readl(ioaddr + i * 4);
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_dump_regs);
 
-static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
-				 int mode, u32 channel, int fifosz, u8 qmode)
+void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  int mode, u32 channel, int fifosz, u8 qmode)
 {
 	u32 value = readl(ioaddr + XGMAC_MTL_RXQ_OPMODE(channel));
 	unsigned int rqs = fifosz / 256 - 1;
@@ -208,9 +215,10 @@ static void dwxgmac2_dma_rx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value = readl(ioaddr + XGMAC_MTL_QINTEN(channel));
 	writel(value | XGMAC_RXOIE, ioaddr + XGMAC_MTL_QINTEN(channel));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_rx_mode);
 
-static void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
-				 int mode, u32 channel, int fifosz, u8 qmode)
+void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  int mode, u32 channel, int fifosz, u8 qmode)
 {
 	u32 value = readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(channel));
 	unsigned int tqs = fifosz / 256 - 1;
@@ -251,10 +259,11 @@ static void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 
 	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(channel));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_tx_mode);
 
-static void dwxgmac2_enable_dma_irq(struct stmmac_priv *priv,
-				    void __iomem *ioaddr, u32 chan,
-				    bool rx, bool tx)
+void dwxgmac2_enable_dma_irq(struct stmmac_priv *priv,
+			     void __iomem *ioaddr, u32 chan,
+			     bool rx, bool tx)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 
@@ -265,10 +274,11 @@ static void dwxgmac2_enable_dma_irq(struct stmmac_priv *priv,
 
 	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_enable_dma_irq);
 
-static void dwxgmac2_disable_dma_irq(struct stmmac_priv *priv,
-				     void __iomem *ioaddr, u32 chan,
-				     bool rx, bool tx)
+void dwxgmac2_disable_dma_irq(struct stmmac_priv *priv,
+			      void __iomem *ioaddr, u32 chan,
+			      bool rx, bool tx)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 
@@ -279,9 +289,10 @@ static void dwxgmac2_disable_dma_irq(struct stmmac_priv *priv,
 
 	writel(value, ioaddr + XGMAC_DMA_CH_INT_EN(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_disable_dma_irq);
 
-static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
-				  void __iomem *ioaddr, u32 chan)
+void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
+			   void __iomem *ioaddr, u32 chan)
 {
 	u32 value;
 
@@ -293,9 +304,10 @@ static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
 	value |= XGMAC_CONFIG_TE;
 	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_start_tx);
 
-static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
-				 u32 chan)
+void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  u32 chan)
 {
 	u32 value;
 
@@ -307,9 +319,10 @@ static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value &= ~XGMAC_CONFIG_TE;
 	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_stop_tx);
 
-static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
-				  void __iomem *ioaddr, u32 chan)
+void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
+			   void __iomem *ioaddr, u32 chan)
 {
 	u32 value;
 
@@ -321,9 +334,10 @@ static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
 	value |= XGMAC_CONFIG_RE;
 	writel(value, ioaddr + XGMAC_RX_CONFIG);
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_start_rx);
 
-static void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
-				 u32 chan)
+void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  u32 chan)
 {
 	u32 value;
 
@@ -331,11 +345,12 @@ static void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value &= ~XGMAC_RXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_stop_rx);
 
-static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
-				  void __iomem *ioaddr,
-				  struct stmmac_extra_stats *x, u32 chan,
-				  u32 dir)
+int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
+			   void __iomem *ioaddr,
+			   struct stmmac_extra_stats *x, u32 chan,
+			   u32 dir)
 {
 	struct stmmac_pcpu_stats *stats = this_cpu_ptr(priv->xstats.pcpu_stats);
 	u32 intr_status = readl(ioaddr + XGMAC_DMA_CH_STATUS(chan));
@@ -384,9 +399,10 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_dma_interrupt);
 
-static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
-				   struct dma_features *dma_cap)
+int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
+			    struct dma_features *dma_cap)
 {
 	u32 hw_cap;
 
@@ -499,39 +515,45 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_get_hw_feature);
 
-static void dwxgmac2_rx_watchdog(struct stmmac_priv *priv, void __iomem *ioaddr,
-				 u32 riwt, u32 queue)
+void dwxgmac2_rx_watchdog(struct stmmac_priv *priv, void __iomem *ioaddr,
+			  u32 riwt, u32 queue)
 {
 	writel(riwt & XGMAC_RWT, ioaddr + XGMAC_DMA_CH_Rx_WATCHDOG(queue));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_rx_watchdog);
 
-static void dwxgmac2_set_rx_ring_len(struct stmmac_priv *priv,
-				     void __iomem *ioaddr, u32 len, u32 chan)
+void dwxgmac2_set_rx_ring_len(struct stmmac_priv *priv,
+			      void __iomem *ioaddr, u32 len, u32 chan)
 {
 	writel(len, ioaddr + XGMAC_DMA_CH_RxDESC_RING_LEN(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_set_rx_ring_len);
 
-static void dwxgmac2_set_tx_ring_len(struct stmmac_priv *priv,
-				     void __iomem *ioaddr, u32 len, u32 chan)
+void dwxgmac2_set_tx_ring_len(struct stmmac_priv *priv,
+			      void __iomem *ioaddr, u32 len, u32 chan)
 {
 	writel(len, ioaddr + XGMAC_DMA_CH_TxDESC_RING_LEN(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_set_tx_ring_len);
 
-static void dwxgmac2_set_rx_tail_ptr(struct stmmac_priv *priv,
-				     void __iomem *ioaddr, u32 ptr, u32 chan)
+void dwxgmac2_set_rx_tail_ptr(struct stmmac_priv *priv,
+			      void __iomem *ioaddr, u32 ptr, u32 chan)
 {
 	writel(ptr, ioaddr + XGMAC_DMA_CH_RxDESC_TAIL_LPTR(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_set_rx_tail_ptr);
 
-static void dwxgmac2_set_tx_tail_ptr(struct stmmac_priv *priv,
-				     void __iomem *ioaddr, u32 ptr, u32 chan)
+void dwxgmac2_set_tx_tail_ptr(struct stmmac_priv *priv,
+			      void __iomem *ioaddr, u32 ptr, u32 chan)
 {
 	writel(ptr, ioaddr + XGMAC_DMA_CH_TxDESC_TAIL_LPTR(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_set_tx_tail_ptr);
 
-static void dwxgmac2_enable_tso(struct stmmac_priv *priv, void __iomem *ioaddr,
-				bool en, u32 chan)
+void dwxgmac2_enable_tso(struct stmmac_priv *priv, void __iomem *ioaddr,
+			 bool en, u32 chan)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 
@@ -542,9 +564,10 @@ static void dwxgmac2_enable_tso(struct stmmac_priv *priv, void __iomem *ioaddr,
 
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_enable_tso);
 
-static void dwxgmac2_qmode(struct stmmac_priv *priv, void __iomem *ioaddr,
-			   u32 channel, u8 qmode)
+void dwxgmac2_qmode(struct stmmac_priv *priv, void __iomem *ioaddr,
+		    u32 channel, u8 qmode)
 {
 	u32 value = readl(ioaddr + XGMAC_MTL_TXQ_OPMODE(channel));
 	u32 flow = readl(ioaddr + XGMAC_RX_FLOW_CTRL);
@@ -560,9 +583,10 @@ static void dwxgmac2_qmode(struct stmmac_priv *priv, void __iomem *ioaddr,
 
 	writel(value, ioaddr +  XGMAC_MTL_TXQ_OPMODE(channel));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_qmode);
 
-static void dwxgmac2_set_bfsize(struct stmmac_priv *priv, void __iomem *ioaddr,
-				int bfsize, u32 chan)
+void dwxgmac2_set_bfsize(struct stmmac_priv *priv, void __iomem *ioaddr,
+			 int bfsize, u32 chan)
 {
 	u32 value;
 
@@ -571,9 +595,10 @@ static void dwxgmac2_set_bfsize(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value |= bfsize << XGMAC_RBSZ_SHIFT;
 	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_set_bfsize);
 
-static void dwxgmac2_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
-				bool en, u32 chan)
+void dwxgmac2_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
+			 bool en, u32 chan)
 {
 	u32 value = readl(ioaddr + XGMAC_RX_CONFIG);
 
@@ -588,9 +613,10 @@ static void dwxgmac2_enable_sph(struct stmmac_priv *priv, void __iomem *ioaddr,
 		value &= ~XGMAC_SPH;
 	writel(value, ioaddr + XGMAC_DMA_CH_CONTROL(chan));
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_enable_sph);
 
-static int dwxgmac2_enable_tbs(struct stmmac_priv *priv, void __iomem *ioaddr,
-			       bool en, u32 chan)
+int dwxgmac2_enable_tbs(struct stmmac_priv *priv, void __iomem *ioaddr,
+			bool en, u32 chan)
 {
 	u32 value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 
@@ -611,6 +637,7 @@ static int dwxgmac2_enable_tbs(struct stmmac_priv *priv, void __iomem *ioaddr,
 	writel(XGMAC_DEF_FTOS, ioaddr + XGMAC_DMA_TBS_CTRL3);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dwxgmac2_enable_tbs);
 
 const struct stmmac_dma_ops dwxgmac210_dma_ops = {
 	.reset = dwxgmac2_dma_reset,
-- 
2.25.1


