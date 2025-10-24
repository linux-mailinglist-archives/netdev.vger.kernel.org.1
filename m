Return-Path: <netdev+bounces-232511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C57C061CC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EEA34E6646
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB999314D11;
	Fri, 24 Oct 2025 11:50:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFFD314A83
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306627; cv=none; b=gsI+8Riv+z1nScHnxGHWlSpCz/I46pjdezae1ldtQDYoz/trN9SZGRS0dNzsz+8tWMbYBv7mTya6xaXJGDch8lSVd7CPZvwt1hX/ArRBDMZDjxU3lbdhKcSSPHLoHDw0VVqkjOuPtKIKz+L4SP/wCnu6PMprM9Zf1MsO9RnF8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306627; c=relaxed/simple;
	bh=ucnVhXbduOX+ot4YU+vd9rENq1k3IpNDh0LUYYkWUUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlQrj/Th7omEZu3paE1SR6Bbl4Wysf/4M/yUf9ReaXvPCzOgPAIQeJ7nleTQdOvFIcVZZk42IsfvjlAknGEyEAsIaoh0K331AD+rKeri8YbtURIgT2JWCuJwQB1XFm4mZo7s90bPUTvl7FmPpy2oB5YaL/8GJGOTUM/KPbgPdAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1vCGJ4-0002FG-RS; Fri, 24 Oct 2025 13:50:06 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 24 Oct 2025 13:49:54 +0200
Subject: [PATCH v5 02/10] net: stmmac: Use interrupt mode INTM=1 for per
 channel irq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-v6-12-topic-socfpga-agilex5-v5-2-4c4a51159eeb@pengutronix.de>
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
Cc: kernel@pengutronix.de, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Teoh Ji Sheng <ji.sheng.teoh@intel.com>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Teoh Ji Sheng <ji.sheng.teoh@intel.com>

commit 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1
for multi-MSI") is introduced for platform that uses MSI.

Similar approach is taken to enable per channel interrupt
that uses shared peripheral interrupt (SPI), so only per channel
TX and RX intr (TI/RI) are handled by TX/RX ISR without calling
common interrupt ISR.

TX/RX NORMAL interrupts check is now decoupled, since NIS bit
is not asserted for any TI/RI events when INTM=1.

Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h       |  3 +++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c   | 10 +++++++++-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c    | 20 ++++++++++++++++++++
 include/linux/stmmac.h                               |  2 ++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 0d408ee17f337..64b533207e4a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -326,6 +326,9 @@
 /* DMA Registers */
 #define XGMAC_DMA_MODE			0x00003000
 #define XGMAC_SWR			BIT(0)
+#define DMA_MODE_INTM_MASK		GENMASK(13, 12)
+#define DMA_MODE_INTM_SHIFT		12
+#define DMA_MODE_INTM_MODE1		0x1
 #define XGMAC_DMA_SYSBUS_MODE		0x00003004
 #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
 #define XGMAC_WR_OSR_LMT_SHIFT		24
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 4d6bb995d8d84..1e9ee1f10f0ef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
 		value |= XGMAC_EAME;
 
 	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
+
+	if (dma_cfg->multi_irq_en) {
+		value = readl(ioaddr + XGMAC_DMA_MODE);
+		value &= ~DMA_MODE_INTM_MASK;
+		value |= (DMA_MODE_INTM_MODE1 << DMA_MODE_INTM_SHIFT);
+		writel(value, ioaddr + XGMAC_DMA_MODE);
+	}
 }
 
 static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
@@ -359,13 +366,14 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
 		}
 	}
 
-	/* TX/RX NORMAL interrupts */
+	/* RX NORMAL interrupts */
 	if (likely(intr_status & XGMAC_RI)) {
 		u64_stats_update_begin(&stats->syncp);
 		u64_stats_inc(&stats->rx_normal_irq_n[chan]);
 		u64_stats_update_end(&stats->syncp);
 		ret |= handle_rx;
 	}
+	/* TX NORMAL interrupts */
 	if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
 		u64_stats_update_begin(&stats->syncp);
 		u64_stats_inc(&stats->tx_normal_irq_n[chan]);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 27bcaae07a7f2..cfa82b8e04b94 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -607,6 +607,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	dma_cfg->fixed_burst = of_property_read_bool(np, "snps,fixed-burst");
 	dma_cfg->mixed_burst = of_property_read_bool(np, "snps,mixed-burst");
 
+	dma_cfg->multi_irq_en = of_property_read_bool(np, "snps,multi-irq-en");
+
 	plat->force_thresh_dma_mode = of_property_read_bool(np, "snps,force_thresh_dma_mode");
 	if (plat->force_thresh_dma_mode && plat->force_sf_dma_mode) {
 		plat->force_sf_dma_mode = 0;
@@ -737,6 +739,8 @@ EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res)
 {
+	char irq_name[11];
+	int i;
 	memset(stmmac_res, 0, sizeof(*stmmac_res));
 
 	/* Get IRQ information early to have an ability to ask for deferred
@@ -746,6 +750,22 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 	if (stmmac_res->irq < 0)
 		return stmmac_res->irq;
 
+	/* For RX Channel */
+	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
+		sprintf(irq_name, "%s%d", "macirq_rx", i);
+		stmmac_res->rx_irq[i] = platform_get_irq_byname(pdev, irq_name);
+		if (stmmac_res->rx_irq[i] < 0)
+			break;
+	}
+
+	/* For TX Channel */
+	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+		sprintf(irq_name, "%s%d", "macirq_tx", i);
+		stmmac_res->tx_irq[i] = platform_get_irq_byname(pdev, irq_name);
+			if (stmmac_res->tx_irq[i] < 0)
+				break;
+	}
+
 	/* On some platforms e.g. SPEAr the wake up irq differs from the mac irq
 	 * The external wake up irq can be passed through the platform code
 	 * named as "eth_wake_irq"
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index fa1318bac06c4..a8b15b4e3c370 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -102,6 +102,7 @@ struct stmmac_dma_cfg {
 	bool aal;
 	bool eame;
 	bool multi_msi_en;
+	bool multi_irq_en;
 	bool dche;
 	bool atds;
 };
@@ -290,6 +291,7 @@ struct plat_stmmacenet_data {
 	u8 vlan_fail_q;
 	struct pci_dev *pdev;
 	int int_snapshot_num;
+	bool multi_irq_en;
 	int msi_mac_vec;
 	int msi_wol_vec;
 	int msi_lpi_vec;

-- 
2.51.0


