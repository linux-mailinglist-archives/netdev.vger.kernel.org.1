Return-Path: <netdev+bounces-180115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA94BA7FA41
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E11189AF63
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FEB264FAC;
	Tue,  8 Apr 2025 09:44:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-16.us.a.mail.aliyun.com (out198-16.us.a.mail.aliyun.com [47.90.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A092C264F87;
	Tue,  8 Apr 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105499; cv=none; b=h6tHUoImeMBS4msdM+nFuUezcmvz8HOCNIphqx5PN7UlpuB24s1P/4UHnS3K5IwfqY1UCl51oNYcc1UjhZoW1NHrQ+OyanTZ7P3iuVmH2vcx52sG4ulAmz8QcUvX4jBckkC5bGn9+r/dOoGWNMTLKGWlmfH6UGBoXpdelHWtt7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105499; c=relaxed/simple;
	bh=Ak4/P0eqCFkY6AKW/B7Rq5AIPcx/X7Hwl9N/mhG4u4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kH0VE34jvxPBiLm+P50j3ZraAPQ1eNXByAwW6xmdst0Q6xdj1jFMjL4oeIrSxsidKwovF5SYy4D4Xrbzwla+28NlP3BkezCyQddxDkaFqaJJf1dfmU4rRWe6WcSjAQLI/RjzR4wMi6CXNqjf95tkkxLmXzIXk7nrG03Is4UVfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7Kv_1744104532 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:28:53 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank <Frank.Sae@motor-comm.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com,
	linux-kernel@vger.kernel.org,
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>,
	lee@trager.us,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	geert+renesas@glider.be,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v4 03/14] yt6801: Implement pci_driver shutdown
Date: Tue,  8 Apr 2025 17:28:24 +0800
Message-Id: <20250408092835.3952-4-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
References: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the pci_driver shutdown function to shutdown this driver.
Implement the fxgmac_net_powerdown function to stop tx, disable tx,
 disable rx, config powerdown, free rx date and free tx date.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   |  50 +++
 .../ethernet/motorcomm/yt6801/yt6801_desc.h   |  19 ++
 .../ethernet/motorcomm/yt6801/yt6801_main.c   | 310 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   | 281 ++++++++++++++++
 4 files changed, 660 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
new file mode 100644
index 000000000..a83ebb478
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include "yt6801_type.h"
+#include "yt6801_desc.h"
+
+void fxgmac_desc_data_unmap(struct fxgmac_pdata *priv,
+			    struct fxgmac_desc_data *desc_data)
+{
+	if (desc_data->skb_dma) {
+		if (desc_data->mapped_as_page) {
+			dma_unmap_page(priv->dev, desc_data->skb_dma,
+				       desc_data->skb_dma_len, DMA_TO_DEVICE);
+		} else {
+			dma_unmap_single(priv->dev, desc_data->skb_dma,
+					 desc_data->skb_dma_len, DMA_TO_DEVICE);
+		}
+		desc_data->skb_dma = 0;
+		desc_data->skb_dma_len = 0;
+	}
+
+	if (desc_data->skb) {
+		dev_kfree_skb_any(desc_data->skb);
+		desc_data->skb = NULL;
+	}
+
+	if (desc_data->rx.hdr.pa.pages)
+		put_page(desc_data->rx.hdr.pa.pages);
+
+	if (desc_data->rx.hdr.pa_unmap.pages) {
+		dma_unmap_page(priv->dev, desc_data->rx.hdr.pa_unmap.pages_dma,
+			       desc_data->rx.hdr.pa_unmap.pages_len,
+			       DMA_FROM_DEVICE);
+		put_page(desc_data->rx.hdr.pa_unmap.pages);
+	}
+
+	if (desc_data->rx.buf.pa.pages)
+		put_page(desc_data->rx.buf.pa.pages);
+
+	if (desc_data->rx.buf.pa_unmap.pages) {
+		dma_unmap_page(priv->dev, desc_data->rx.buf.pa_unmap.pages_dma,
+			       desc_data->rx.buf.pa_unmap.pages_len,
+			       DMA_FROM_DEVICE);
+		put_page(desc_data->rx.buf.pa_unmap.pages);
+	}
+	memset(&desc_data->tx, 0, sizeof(desc_data->tx));
+	memset(&desc_data->rx, 0, sizeof(desc_data->rx));
+
+	desc_data->mapped_as_page = 0;
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
new file mode 100644
index 000000000..a4c7a8af2
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef YT6801_DESC_H
+#define YT6801_DESC_H
+
+#define FXGMAC_TX_DESC_CNT		256
+#define FXGMAC_TX_DESC_MIN_FREE		(FXGMAC_TX_DESC_CNT >> 3)
+#define FXGMAC_TX_DESC_MAX_PROC		(FXGMAC_TX_DESC_CNT >> 1)
+#define FXGMAC_RX_DESC_CNT		1024
+#define FXGMAC_RX_DESC_MAX_DIRTY	(FXGMAC_RX_DESC_CNT >> 3)
+
+#define FXGMAC_GET_DESC_DATA(ring, idx)	((ring)->desc_data_head + (idx))
+#define FXGMAC_GET_ENTRY(x, size)	(((x) + 1) & ((size) - 1))
+
+void fxgmac_desc_data_unmap(struct fxgmac_pdata *priv,
+			    struct fxgmac_desc_data *desc_data);
+
+#endif /* YT6801_DESC_H */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
index 39f03b4a4..8baabeb53 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
@@ -19,6 +19,7 @@
 
 #include <linux/module.h>
 #include "yt6801_type.h"
+#include "yt6801_desc.h"
 
 #define PHY_WR_CONFIG(reg_offset)	(0x8000205 + ((reg_offset) * 0x10000))
 static int fxgmac_phy_write_reg(struct fxgmac_pdata *priv, u32 reg_id, u32 data)
@@ -106,6 +107,219 @@ static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
 	return 0;
 }
 
+static void fxgmac_disable_mgm_irq(struct fxgmac_pdata *priv)
+{
+	fxgmac_io_wr_bits(priv, MGMT_INT_CTRL0, MGMT_INT_CTRL0_INT_MASK,
+			  MGMT_INT_CTRL0_INT_MASK_MASK);
+}
+
+static void napi_disable_del(struct fxgmac_pdata *priv, struct napi_struct *n,
+			     u32 flag)
+{
+	napi_disable(n);
+	netif_napi_del(n);
+	priv->int_flag &= ~flag;
+}
+
+static void fxgmac_napi_disable(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	u32 rx_napi[] = {INT_FLAG_RX0_NAPI, INT_FLAG_RX1_NAPI,
+			INT_FLAG_RX2_NAPI, INT_FLAG_RX3_NAPI};
+
+	if (!priv->per_channel_irq) {
+		if (!FIELD_GET(INT_FLAG_LEGACY_NAPI, priv->int_flag))
+			return;
+
+		napi_disable_del(priv, &priv->napi,
+				 INT_FLAG_LEGACY_NAPI);
+		return;
+	}
+
+	if (FIELD_GET(INT_FLAG_TX_NAPI, priv->int_flag))
+		napi_disable_del(priv, &channel->napi_tx, INT_FLAG_TX_NAPI);
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		if (priv->int_flag & rx_napi[i])
+			napi_disable_del(priv, &channel->napi_rx, rx_napi[i]);
+}
+
+static void fxgmac_free_irqs(struct fxgmac_pdata *priv)
+{
+	u32 rx_irq[] = {INT_FLAG_RX0_IRQ, INT_FLAG_RX1_IRQ,
+			INT_FLAG_RX2_IRQ, INT_FLAG_RX3_IRQ};
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	if (!FIELD_GET(INT_FLAG_MSIX, priv->int_flag) &&
+	    FIELD_GET(INT_FLAG_LEGACY_IRQ, priv->int_flag)) {
+		devm_free_irq(priv->dev, priv->dev_irq, priv);
+		priv->int_flag &= ~INT_FLAG_LEGACY_IRQ;
+	}
+
+	if (!priv->per_channel_irq)
+		return;
+
+	if (FIELD_GET(INT_FLAG_TX_IRQ, priv->int_flag)) {
+		priv->int_flag &= ~INT_FLAG_TX_IRQ;
+		devm_free_irq(priv->dev, channel->dma_irq_tx, channel);
+	}
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		if (priv->int_flag & rx_irq[i]) {
+			priv->int_flag &= ~rx_irq[i];
+			devm_free_irq(priv->dev, channel->dma_irq_rx, channel);
+		}
+}
+
+static void fxgmac_free_tx_data(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	struct fxgmac_ring *ring;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		ring = channel->tx_ring;
+		if (!ring)
+			break;
+
+		for (u32 j = 0; j < ring->dma_desc_count; j++)
+			fxgmac_desc_data_unmap(priv,
+					       FXGMAC_GET_DESC_DATA(ring, j));
+	}
+}
+
+static void fxgmac_free_rx_data(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	struct fxgmac_ring *ring;
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++) {
+		ring = channel->rx_ring;
+		if (!ring)
+			break;
+
+		for (u32 j = 0; j < ring->dma_desc_count; j++)
+			fxgmac_desc_data_unmap(priv,
+					       FXGMAC_GET_DESC_DATA(ring, j));
+	}
+}
+
+static void fxgmac_prepare_tx_stop(struct fxgmac_pdata *priv,
+				   struct fxgmac_channel *channel)
+{
+	unsigned long tx_timeout;
+	unsigned int tx_status;
+
+	/* The Tx engine cannot be stopped if it is actively processing
+	 * descriptors. Wait for the Tx engine to enter the stopped or
+	 * suspended state.
+	 */
+	tx_timeout = jiffies + (FXGMAC_DMA_STOP_TIMEOUT * HZ);
+
+	while (time_before(jiffies, tx_timeout)) {
+		tx_status = fxgmac_io_rd(priv, DMA_DSR0);
+		tx_status = FIELD_GET(DMA_DSR0_TPS, tx_status);
+		if (tx_status == DMA_TPS_STOPPED ||
+		    tx_status == DMA_TPS_SUSPENDED)
+			break;
+
+		fsleep(500);
+	}
+
+	if (!time_before(jiffies, tx_timeout))
+		dev_err(priv->dev, "timed out waiting for Tx DMA channel  stop\n");
+}
+
+static void fxgmac_disable_tx(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	/* Prepare for Tx DMA channel stop */
+	fxgmac_prepare_tx_stop(priv, channel);
+
+	fxgmac_io_wr_bits(priv, MAC_CR, MAC_CR_TE, 0); /* Disable MAC Tx */
+
+	/* Disable Tx queue */
+	fxgmac_mtl_wr_bits(priv, 0, MTL_Q_TQOMR, MTL_Q_TQOMR_TXQEN,
+			   MTL_Q_DISABLED);
+
+	/* Disable Tx DMA channel */
+	fxgmac_dma_wr_bits(channel, DMA_CH_TCR, DMA_CH_TCR_ST, 0);
+}
+
+static void fxgmac_prepare_rx_stop(struct fxgmac_pdata *priv,
+				   unsigned int queue)
+{
+	unsigned int rx_status, rx_q, rx_q_sts;
+	unsigned long rx_timeout;
+
+	/* The Rx engine cannot be stopped if it is actively processing
+	 * packets. Wait for the Rx queue to empty the Rx fifo.
+	 */
+	rx_timeout = jiffies + (FXGMAC_DMA_STOP_TIMEOUT * HZ);
+
+	while (time_before(jiffies, rx_timeout)) {
+		rx_status = fxgmac_mtl_io_rd(priv, queue, MTL_Q_RQDR);
+		rx_q = FIELD_GET(MTL_Q_RQDR_PRXQ, rx_status);
+		rx_q_sts = FIELD_GET(MTL_Q_RQDR_RXQSTS, rx_status);
+		if (rx_q == 0 && rx_q_sts == 0)
+			break;
+
+		fsleep(500);
+	}
+
+	if (!time_before(jiffies, rx_timeout))
+		dev_err(priv->dev, "timed out waiting for Rx queue %u to empty\n",
+			queue);
+}
+
+static void fxgmac_disable_rx(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	u32 i;
+
+	/* Disable MAC Rx */
+	fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_CST, 0);
+	fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_ACS, 0);
+	fxgmac_io_wr_bits(priv, MAC_CR,  MAC_CR_RE, 0);
+
+	/* Prepare for Rx DMA channel stop */
+	for (i = 0; i < priv->rx_q_count; i++)
+		fxgmac_prepare_rx_stop(priv, i);
+
+	fxgmac_io_wr(priv, MAC_RQC0R, 0); /* Disable each Rx queue */
+
+	/* Disable each Rx DMA channel */
+	for (i = 0; i < priv->channel_count; i++, channel++)
+		fxgmac_dma_wr_bits(channel, DMA_CH_RCR, DMA_CH_RCR_SR, 0);
+}
+
+/**
+ * fxgmac_set_oob_wol - disable or enable oob wol crtl function
+ * @priv: driver private struct
+ * @en: 1 or 0
+ *
+ * Description:  After enable OOB_WOL from efuse, mac will loopcheck phy status,
+ *   and lead to panic sometimes. So we should disable it from powerup,
+ *   enable it from power down.
+ */
+static void fxgmac_set_oob_wol(struct fxgmac_pdata *priv, unsigned int en)
+{
+	/* en = 1 is disable */
+	fxgmac_io_wr_bits(priv, OOB_WOL_CTRL, OOB_WOL_CTRL_DIS, !en);
+}
+
+static void fxgmac_config_powerup(struct fxgmac_pdata *priv)
+{
+	fxgmac_set_oob_wol(priv, 0);
+	/* GAMC power up */
+	fxgmac_io_wr_bits(priv, MAC_PMT_STA, MAC_PMT_STA_PWRDWN, 0);
+}
+
+static void fxgmac_pre_powerdown(struct fxgmac_pdata *priv)
+{
+	fxgmac_set_oob_wol(priv, 1);
+	fsleep(2000);
+}
 static void fxgmac_phy_release(struct fxgmac_pdata *priv)
 {
 	fxgmac_io_wr_bits(priv, EPHY_CTRL, EPHY_CTRL_RESET, 1);
@@ -117,6 +331,82 @@ static void fxgmac_phy_reset(struct fxgmac_pdata *priv)
 	fsleep(1500);
 }
 
+static void fxgmac_disable_msix_irqs(struct fxgmac_pdata *priv)
+{
+	for (u32 intid = 0; intid < MSIX_TBL_MAX_NUM; intid++)
+		fxgmac_disable_msix_one_irq(priv, intid);
+}
+
+static void fxgmac_stop(struct fxgmac_pdata *priv)
+{
+	struct net_device *ndev = priv->ndev;
+	struct netdev_queue *txq;
+
+	if (priv->dev_state != FXGMAC_DEV_START)
+		return;
+
+	priv->dev_state = FXGMAC_DEV_STOP;
+
+	if (priv->per_channel_irq)
+		fxgmac_disable_msix_irqs(priv);
+	else
+		fxgmac_disable_mgm_irq(priv);
+
+	netif_carrier_off(ndev);
+	netif_tx_stop_all_queues(ndev);
+	fxgmac_disable_tx(priv);
+	fxgmac_disable_rx(priv);
+	fxgmac_free_irqs(priv);
+	fxgmac_napi_disable(priv);
+	phy_stop(priv->phydev);
+
+	txq = netdev_get_tx_queue(ndev, priv->channel_head->queue_index);
+	netdev_tx_reset_queue(txq);
+}
+
+static void fxgmac_config_powerdown(struct fxgmac_pdata *priv)
+{
+	fxgmac_io_wr_bits(priv, MAC_CR, MAC_CR_RE, 1); /* Enable MAC Rx */
+	fxgmac_io_wr_bits(priv, MAC_CR, MAC_CR_TE, 1); /* Enable MAC TX */
+
+	/* Set GAMC power down */
+	fxgmac_io_wr_bits(priv, MAC_PMT_STA, MAC_PMT_STA_PWRDWN, 1);
+}
+
+static int fxgmac_net_powerdown(struct fxgmac_pdata *priv)
+{
+	struct net_device *ndev = priv->ndev;
+
+	/* Signal that we are down to the interrupt handler */
+	if (__test_and_set_bit(FXGMAC_POWER_STATE_DOWN, &priv->power_state))
+		return 0; /* do nothing if already down */
+
+	__clear_bit(FXGMAC_POWER_STATE_UP, &priv->power_state);
+	netif_tx_stop_all_queues(ndev); /* Shut off incoming Tx traffic */
+
+	/* Call carrier off first to avoid false dev_watchdog timeouts */
+	netif_carrier_off(ndev);
+	netif_tx_disable(ndev);
+	fxgmac_disable_rx(priv);
+
+	/* Synchronize_rcu() needed for pending XDP buffers to drain */
+	synchronize_rcu();
+
+	fxgmac_stop(priv);
+	fxgmac_pre_powerdown(priv);
+
+	if (!test_bit(FXGMAC_POWER_STATE_DOWN, &priv->power_state))
+		dev_err(priv->dev, "fxgmac powerstate is %lu when config powe down.\n",
+			priv->power_state);
+
+	/* Set mac to lowpower mode */
+	fxgmac_config_powerdown(priv);
+	fxgmac_free_tx_data(priv);
+	fxgmac_free_rx_data(priv);
+
+	return 0;
+}
+
 static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *priv)
 {
 	struct pci_dev *pdev = to_pci_dev(priv->dev);
@@ -256,6 +546,25 @@ static void fxgmac_remove(struct pci_dev *pcidev)
 	}
 }
 
+static void __fxgmac_shutdown(struct pci_dev *pcidev)
+{
+	struct fxgmac_pdata *priv = dev_get_drvdata(&pcidev->dev);
+	struct net_device *ndev = priv->ndev;
+
+	fxgmac_net_powerdown(priv);
+	netif_device_detach(ndev);
+}
+
+static void fxgmac_shutdown(struct pci_dev *pcidev)
+{
+	rtnl_lock();
+	 __fxgmac_shutdown(pcidev);
+	if (system_state == SYSTEM_POWER_OFF) {
+		pci_wake_from_d3(pcidev, false);
+		pci_set_power_state(pcidev, PCI_D3hot);
+	}
+	rtnl_unlock();
+}
 #define MOTORCOMM_PCI_ID			0x1f0a
 #define YT6801_PCI_DEVICE_ID			0x6801
 
@@ -271,6 +580,7 @@ static struct pci_driver fxgmac_pci_driver = {
 	.id_table	= fxgmac_pci_tbl,
 	.probe		= fxgmac_probe,
 	.remove		= fxgmac_remove,
+	.shutdown	= fxgmac_shutdown,
 };
 
 module_pci_driver(fxgmac_pci_driver);
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
index b43952981..124860602 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
@@ -34,6 +34,61 @@
 #define EPHY_CTRL_STA_DUPLEX			BIT(2)
 #define EPHY_CTRL_STA_SPEED			GENMASK(4, 3)
 
+#define OOB_WOL_CTRL				0x1010
+#define OOB_WOL_CTRL_DIS			BIT(0)
+
+/* MAC management registers */
+#define MGMT_INT_CTRL0				0x1100
+#define MGMT_INT_CTRL0_INT_STATUS		GENMASK(15, 0)
+#define  MGMT_INT_CTRL0_INT_STATUS_RX		0x000f
+#define  MGMT_INT_CTRL0_INT_STATUS_TX		0x0010
+#define  MGMT_INT_CTRL0_INT_STATUS_MISC		0x0020
+#define  MGMT_INT_CTRL0_INT_STATUS_RXTX		0x0030
+#define MGMT_INT_CTRL0_INT_MASK			GENMASK(31, 16)
+#define  MGMT_INT_CTRL0_INT_MASK_RXCH		0x000f
+#define  MGMT_INT_CTRL0_INT_MASK_TXCH		0x0010
+#define  MGMT_INT_CTRL0_INT_MASK_MISC		0x0020
+#define  MGMT_INT_CTRL0_INT_MASK_EX_PMT		0xf7ff
+#define  MGMT_INT_CTRL0_INT_MASK_DISABLE	0xf000
+#define  MGMT_INT_CTRL0_INT_MASK_MASK		0xffff
+
+/* msi table */
+#define MSI_ID_RXQ0				0
+#define MSI_ID_RXQ1				1
+#define MSI_ID_RXQ2				2
+#define MSI_ID_RXQ3				3
+#define MSI_ID_TXQ0				4
+#define MSIX_TBL_MAX_NUM			5
+
+/****************  GMAC register. *********************/
+#define MAC_CR				0x2000
+#define MAC_CR_RE			BIT(0)
+#define MAC_CR_TE			BIT(1)
+#define MAC_CR_LM			BIT(12)
+#define MAC_CR_DM			BIT(13)
+#define MAC_CR_FES			BIT(14)
+#define MAC_CR_PS			BIT(15)
+#define MAC_CR_JE			BIT(16)
+#define MAC_CR_ACS			BIT(20)
+#define MAC_CR_CST			BIT(21)
+#define MAC_CR_IPC			BIT(27)
+#define MAC_CR_ARPEN			BIT(31)
+
+#define MAC_RQC0R			0x20a0
+#define MAC_RQC1R			0x20a4
+#define MAC_RQC2R			0x20a8
+#define MAC_RQC2_INC			4
+#define MAC_RQC2_Q_PER_REG		4
+
+#define MAC_PMT_STA			0x20c0
+#define MAC_PMT_STA_PWRDWN		BIT(0)
+#define MAC_PMT_STA_MGKPKTEN		BIT(1)
+#define MAC_PMT_STA_RWKPKTEN		BIT(2)
+#define MAC_PMT_STA_MGKPRCVD		BIT(5)
+#define MAC_PMT_STA_RWKPRCVD		BIT(6)
+#define MAC_PMT_STA_GLBLUCAST		BIT(9)
+#define MAC_PMT_STA_RWKPTR		GENMASK(27, 24)
+#define MAC_PMT_STA_RWKFILTERST		BIT(31)
 #define MAC_MDIO_ADDR			0x2200
 #define MAC_MDIO_ADDR_BUSY		BIT(0)
 #define MAC_MDIO_ADDR_GOC		GENMASK(3, 2)
@@ -42,6 +97,153 @@
 #define MAC_MDIO_DATA_GD		GENMASK(15, 0)
 #define MAC_MDIO_DATA_RA		GENMASK(31, 16)
 
+/* MTL queue registers */
+#define MTL_Q_BASE			0x2d00
+#define MTL_Q_INC			0x40
+
+#define MTL_Q_TQOMR			0x00
+#define MTL_Q_TQOMR_FTQ			BIT(0)
+#define MTL_Q_TQOMR_TSF			BIT(1)
+#define MTL_Q_TQOMR_TXQEN		GENMASK(3, 2)
+#define MTL_Q_DISABLED			0x00
+#define MTL_Q_EN_IF_AV			0x01
+#define MTL_Q_ENABLED			0x02
+
+#define MTL_Q_RQDR			0x38
+#define MTL_Q_RQDR_RXQSTS		GENMASK(5, 4)
+#define MTL_Q_RQDR_PRXQ			GENMASK(29, 16)
+#define DMA_DSRX_INC				4
+#define DMA_DSR0				0x300c
+#define DMA_DSR0_TPS				GENMASK(15, 12)
+#define  DMA_TPS_STOPPED			0x00
+#define  DMA_TPS_SUSPENDED			0x06
+
+/* DMA channel registers */
+#define DMA_CH_BASE			0x3100
+#define DMA_CH_INC			0x80
+
+#define DMA_CH_TCR			0x04
+#define DMA_CH_TCR_ST			BIT(0)
+#define DMA_CH_TCR_OSP			BIT(4)
+#define DMA_CH_TCR_TSE			BIT(12)
+#define DMA_CH_TCR_PBL			GENMASK(21, 16)
+#define  DMA_CH_PBL_1			1
+#define  DMA_CH_PBL_2			2
+#define  DMA_CH_PBL_4			4
+#define  DMA_CH_PBL_8			8
+#define  DMA_CH_PBL_16			16
+#define  DMA_CH_PBL_32			32
+#define  DMA_CH_PBL_64			64
+#define  DMA_CH_PBL_128			128
+#define  DMA_CH_PBL_256			256
+
+#define DMA_CH_RCR			0x08
+#define DMA_CH_RCR_SR			BIT(0)
+#define DMA_CH_RCR_RBSZ			GENMASK(14, 1)
+#define DMA_CH_RCR_PBL			GENMASK(21, 16)
+
+/* Page allocation related values */
+struct fxgmac_page_alloc {
+	struct page *pages;
+	unsigned int pages_len;
+	unsigned int pages_offset;
+	dma_addr_t pages_dma;
+};
+
+/* Ring entry buffer data */
+struct fxgmac_buffer_data {
+	struct fxgmac_page_alloc pa;
+	struct fxgmac_page_alloc pa_unmap;
+
+	dma_addr_t dma_base;
+	unsigned long dma_off;
+	unsigned int dma_len;
+};
+
+struct fxgmac_tx_desc_data {
+	unsigned int packets;		/* BQL packet count */
+	unsigned int bytes;		/* BQL byte count */
+};
+
+struct fxgmac_rx_desc_data {
+	struct fxgmac_buffer_data hdr;	/* Header locations */
+	struct fxgmac_buffer_data buf;	/* Payload locations */
+	unsigned short hdr_len;		/* Length of received header */
+	unsigned short len;		/* Length of received packet */
+};
+
+struct fxgmac_desc_data {
+	struct fxgmac_dma_desc *dma_desc;  /* Virtual address of descriptor */
+	dma_addr_t dma_desc_addr;          /* DMA address of descriptor */
+	struct sk_buff *skb;               /* Virtual address of SKB */
+	dma_addr_t skb_dma;                /* DMA address of SKB data */
+	unsigned int skb_dma_len;          /* Length of SKB DMA area */
+
+	/* Tx/Rx -related data */
+	struct fxgmac_tx_desc_data tx;
+	struct fxgmac_rx_desc_data rx;
+
+	unsigned int mapped_as_page;
+};
+
+struct fxgmac_ring {
+	struct fxgmac_pkt_info pkt_info;  /* packet related information */
+
+	/* Virtual/DMA addresses of DMA descriptor list */
+	struct fxgmac_dma_desc *dma_desc_head;
+	dma_addr_t dma_desc_head_addr;
+	unsigned int dma_desc_count;
+
+	/* Array of descriptor data corresponding the DMA descriptor
+	 * (always use the FXGMAC_GET_DESC_DATA macro to access this data)
+	 */
+	struct fxgmac_desc_data *desc_data_head;
+
+	/* Page allocation for RX buffers */
+	struct fxgmac_page_alloc rx_hdr_pa;
+	struct fxgmac_page_alloc rx_buf_pa;
+
+	/* Ring index values
+	 * cur  - Tx: index of descriptor to be used for current transfer
+	 *        Rx: index of descriptor to check for packet availability
+	 * dirty - Tx: index of descriptor to check for transfer complete
+	 *         Rx: index of descriptor to check for buffer reallocation
+	 */
+	unsigned int cur;
+	unsigned int dirty;
+
+	struct {
+		unsigned int xmit_more;
+		unsigned int queue_stopped;
+		unsigned short cur_mss;
+		unsigned short cur_vlan_ctag;
+	} tx;
+} ____cacheline_aligned;
+
+struct fxgmac_channel {
+	char name[16];
+
+	/* Address of private data area for device */
+	struct fxgmac_pdata *priv;
+
+	/* Queue index and base address of queue's DMA registers */
+	unsigned int queue_index;
+
+	/* Per channel interrupt irq number */
+	u32 dma_irq_rx;
+	char dma_irq_rx_name[IFNAMSIZ + 32];
+	u32 dma_irq_tx;
+	char dma_irq_tx_name[IFNAMSIZ + 32];
+
+	/* ndev related settings */
+	struct napi_struct napi_tx;
+	struct napi_struct napi_rx;
+
+	void __iomem *dma_regs;
+	struct fxgmac_ring *tx_ring;
+	struct fxgmac_ring *rx_ring;
+} ____cacheline_aligned;
+
 struct fxgmac_resources {
 	void __iomem *addr;
 	int irq;
@@ -64,6 +266,16 @@ struct fxgmac_pdata {
 
 	void __iomem *hw_addr;			/* Registers base */
 
+	/* Rings for Tx/Rx on a DMA channel */
+	struct fxgmac_channel *channel_head;
+	unsigned int channel_count;
+	unsigned int rx_ring_count;
+	unsigned int rx_desc_count;
+	unsigned int rx_q_count;
+#define FXGMAC_TX_1_RING	1
+#define FXGMAC_TX_1_Q		1
+	unsigned int tx_desc_count;
+
 	/* Device interrupt */
 	int dev_irq;
 	unsigned int per_channel_irq;
@@ -89,6 +301,9 @@ struct fxgmac_pdata {
 
 	u32 msg_enable;
 	enum fxgmac_dev_state dev_state;
+#define FXGMAC_POWER_STATE_DOWN			0
+#define FXGMAC_POWER_STATE_UP			1
+	unsigned long power_state;
 };
 
 static inline u32 fxgmac_io_rd(struct fxgmac_pdata *priv, u32 reg)
@@ -119,4 +334,70 @@ fxgmac_io_wr_bits(struct fxgmac_pdata *priv, u32 reg, u32 mask, u32 set)
 	fxgmac_io_wr(priv, reg, cfg);
 }
 
+static inline u32 fxgmac_mtl_io_rd(struct fxgmac_pdata *priv, u8 n, u32 reg)
+{
+	return fxgmac_io_rd(priv, reg + n * MTL_Q_INC);
+}
+
+static inline u32
+fxgmac_mtl_rd_bits(struct fxgmac_pdata *priv, u8 n, u32 reg, u32 mask)
+{
+	return fxgmac_io_rd_bits(priv,  reg + n * MTL_Q_INC, mask);
+}
+
+static inline void
+fxgmac_mtl_io_wr(struct fxgmac_pdata *priv, u8 n, u32 reg, u32 set)
+{
+	return fxgmac_io_wr(priv,  reg + n * MTL_Q_INC, set);
+}
+
+static inline void
+fxgmac_mtl_wr_bits(struct fxgmac_pdata *priv, u8 n, u32 reg, u32 mask, u32 set)
+{
+	return fxgmac_io_wr_bits(priv,  reg + n * MTL_Q_INC, mask, set);
+}
+
+static inline u32 fxgmac_dma_io_rd(struct fxgmac_channel *channel, u32 reg)
+{
+	return ioread32(channel->dma_regs + reg);
+}
+
+static inline u32
+fxgmac_dma_rd_bits(struct fxgmac_channel *channel, u32 reg, u32 mask)
+{
+	u32 cfg = fxgmac_dma_io_rd(channel, reg);
+
+	return FIELD_GET(mask, cfg);
+}
+
+static inline void
+fxgmac_dma_io_wr(struct fxgmac_channel *channel, u32 reg, u32 set)
+{
+	iowrite32(set, channel->dma_regs + reg);
+}
+
+static inline void
+fxgmac_dma_wr_bits(struct fxgmac_channel *channel, u32 reg, u32 mask, u32 set)
+{
+	u32 cfg = fxgmac_dma_io_rd(channel, reg);
+
+	cfg &= ~mask;
+	cfg |= FIELD_PREP(mask, set);
+	fxgmac_dma_io_wr(channel, reg, cfg);
+}
+
+static inline u32 fxgmac_desc_rd_bits(__le32 desc, u32 mask)
+{
+	return FIELD_GET(mask, le32_to_cpu(desc));
+}
+
+static inline void fxgmac_desc_wr_bits(__le32 *desc, u32 mask, u32 set)
+{
+	u32 cfg = le32_to_cpu(*desc);
+
+	cfg &= ~mask;
+	cfg |= FIELD_PREP(mask, set);
+	*desc = cpu_to_le32(cfg);
+}
+
 #endif /* YT6801_TYPE_H */
-- 
2.34.1


