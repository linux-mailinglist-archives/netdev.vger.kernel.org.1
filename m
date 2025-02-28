Return-Path: <netdev+bounces-170640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC667A496A3
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A657A5968
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B649260A33;
	Fri, 28 Feb 2025 10:06:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-8.us.a.mail.aliyun.com (out198-8.us.a.mail.aliyun.com [47.90.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223AC26036B;
	Fri, 28 Feb 2025 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737167; cv=none; b=FvEfl4DTd01AzOnd/L8MTfnhhYlL91tZ4X/49hDid/GgZ8kvG9GwYbxHh1zyTVOPQ/3LcQNJMLFlwVIqrV9QVlRAZGVc3m/wwT3AyE+s5b9OWT3TmIJGCXdE+Fp/hQQ67E2HJxsJXMyUUiEb7EjCk+VchQ0gKVpr/ZeKxYijwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737167; c=relaxed/simple;
	bh=rKKoapeU3Mgrdvx1znvZkM743aU29GNyMexs8eijBVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHzSOu+iURmO8D5/jW5syi91b12MW4q1Bl5KLDnUNF/bKOoL0WEdsNVa6uRaKHbOyhR2gGLirkx8t+h26n5zcV0yw7TRLbAjSlEKP2uGpaub4WWtTxYv/Bvom0F0nVItOp8cWwgIr7GbWSQv4t12u3X02UeYqoK5Cz69S2owlE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1B-_1740736833 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:33 +0800
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
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v3 03/14] motorcomm:yt6801: Implement pci_driver shutdown
Date: Fri, 28 Feb 2025 18:00:09 +0800
Message-Id: <20250228100020.3944-4-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
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
 .../ethernet/motorcomm/yt6801/yt6801_desc.h   |  35 ++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 301 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_pci.c    |  24 ++
 4 files changed, 410 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
new file mode 100644
index 000000000..3ff5eff11
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include "yt6801.h"
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
index 000000000..b238f20be
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
@@ -0,0 +1,35 @@
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
+void fxgmac_desc_tx_reset(struct fxgmac_desc_data *desc_data);
+void fxgmac_desc_rx_reset(struct fxgmac_desc_data *desc_data);
+void fxgmac_desc_data_unmap(struct fxgmac_pdata *priv,
+			    struct fxgmac_desc_data *desc_data);
+
+int fxgmac_channels_rings_alloc(struct fxgmac_pdata *priv);
+void fxgmac_channels_rings_free(struct fxgmac_pdata *priv);
+int fxgmac_tx_skb_map(struct fxgmac_channel *channel, struct sk_buff *skb);
+int fxgmac_rx_buffe_map(struct fxgmac_pdata *priv, struct fxgmac_ring *ring,
+			struct fxgmac_desc_data *desc_data);
+void fxgmac_dump_tx_desc(struct fxgmac_pdata *priv, struct fxgmac_ring *ring,
+			 unsigned int idx, unsigned int count,
+			 unsigned int flag);
+void fxgmac_dump_rx_desc(struct fxgmac_pdata *priv, struct fxgmac_ring *ring,
+			 unsigned int idx);
+
+int fxgmac_is_tx_complete(struct fxgmac_dma_desc *dma_desc);
+int fxgmac_is_last_desc(struct fxgmac_dma_desc *dma_desc);
+
+#endif /* YT6801_DESC_H */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index c54550cd4..7d557f6b0 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -9,6 +9,7 @@
 #include <linux/tcp.h>
 
 #include "yt6801.h"
+#include "yt6801_desc.h"
 
 #define PHY_WR_CONFIG(reg_offset)	(0x8000205 + ((reg_offset) * 0x10000))
 static int fxgmac_phy_write_reg(struct fxgmac_pdata *priv, u32 reg_id, u32 data)
@@ -98,6 +99,229 @@ static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
 	return 0;
 }
 
+static void fxgmac_disable_mgm_irq(struct fxgmac_pdata *priv)
+{
+	FXGMAC_IO_WR_BITS(priv, MGMT_INT_CTRL0, INT_MASK,
+			  MGMT_INT_CTRL0_INT_MASK_MASK);
+}
+
+static void napi_disable_del(struct fxgmac_pdata *priv, struct napi_struct *n,
+			     u32 flag_pos)
+{
+	napi_disable(n);
+	netif_napi_del(n);
+	SET_BITS(priv->int_flag, flag_pos, 1, 0); /* set flag_pos bit to 0 */
+}
+
+static void fxgmac_napi_disable(struct fxgmac_pdata *priv)
+{
+	u32 rx = FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, RX_NAPI);
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	if (!priv->per_channel_irq) {
+		if (!FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, LEGACY_NAPI))
+			return;
+
+		napi_disable_del(priv, &priv->napi,
+				 INT_FLAG_LEGACY_NAPI_POS);
+		return;
+	}
+
+	if (FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, TX_NAPI))
+		napi_disable_del(priv, &channel->napi_tx,
+				 INT_FLAG_TX_NAPI_POS);
+
+	for (u32 i = 0; i < priv->channel_count; i++, channel++)
+		if (GET_BITS(rx, i, INT_FLAG_PER_RX_NAPI_LEN))
+			napi_disable_del(priv, &channel->napi_rx,
+					 INT_FLAG_RX_NAPI_POS + i);
+}
+
+static void fxgmac_free_irqs(struct fxgmac_pdata *priv)
+{
+	u32 i, rx = FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, RX_IRQ);
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	if (!FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, MSIX) &&
+	    FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, LEGACY_IRQ)) {
+		devm_free_irq(priv->dev, priv->dev_irq, priv);
+		FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, LEGACY_IRQ, 0);
+	}
+
+	if (!priv->per_channel_irq)
+		return;
+
+	if (FXGMAC_GET_BITS(priv->int_flag, INT_FLAG, TX_IRQ)) {
+		FXGMAC_SET_BITS(priv->int_flag, INT_FLAG, TX_IRQ, 0);
+		devm_free_irq(priv->dev, channel->dma_irq_tx, channel);
+	}
+
+	for (i = 0; i < priv->channel_count; i++, channel++) {
+		if (GET_BITS(rx, i, INT_FLAG_PER_RX_IRQ_LEN)) {
+			SET_BITS(priv->int_flag, INT_FLAG_RX_IRQ_POS + i,
+				 INT_FLAG_PER_RX_IRQ_LEN, 0);
+			devm_free_irq(priv->dev, channel->dma_irq_rx, channel);
+		}
+	}
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
+	unsigned int tx_q_idx, tx_status;
+	unsigned int tx_dsr, tx_pos;
+	unsigned long tx_timeout;
+
+	/* Calculate the status register to read and the position within */
+	if (channel->queue_index < DMA_DSRX_FIRST_QUEUE) {
+		tx_dsr = DMA_DSR0;
+		tx_pos = (channel->queue_index * DMA_DSR_Q_LEN) +
+			 DMA_DSR0_TPS_START;
+	} else {
+		tx_q_idx = channel->queue_index - DMA_DSRX_FIRST_QUEUE;
+
+		tx_dsr = DMA_DSR1 + ((tx_q_idx / DMA_DSRX_QPR) * DMA_DSRX_INC);
+		tx_pos = ((tx_q_idx % DMA_DSRX_QPR) * DMA_DSR_Q_LEN) +
+			 DMA_DSRX_TPS_START;
+	}
+
+	/* The Tx engine cannot be stopped if it is actively processing
+	 * descriptors. Wait for the Tx engine to enter the stopped or
+	 * suspended state.
+	 */
+	tx_timeout = jiffies + (FXGMAC_DMA_STOP_TIMEOUT * HZ);
+
+	while (time_before(jiffies, tx_timeout)) {
+		tx_status = FXGMAC_MAC_IO_RD(priv, tx_dsr);
+		tx_status = GET_BITS(tx_status, tx_pos, DMA_DSR_TPS_LEN);
+		if (tx_status == DMA_TPS_STOPPED ||
+		    tx_status == DMA_TPS_SUSPENDED)
+			break;
+
+		fsleep(500);
+	}
+
+	if (!time_before(jiffies, tx_timeout))
+		yt_err(priv,
+		       "timed out waiting for Tx DMA channel %u to stop\n",
+		       channel->queue_index);
+}
+
+static void fxgmac_disable_tx(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+
+	/* Prepare for Tx DMA channel stop */
+	fxgmac_prepare_tx_stop(priv, channel);
+
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, TE, 0);/* Disable MAC Tx */
+
+	/* Disable Tx queue */
+	FXGMAC_MTL_IO_WR_BITS(priv, 0, MTL_Q_TQOMR, TXQEN, MTL_Q_DISABLED);
+
+	/* Disable Tx DMA channel */
+	FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_TCR, ST, 0);
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
+		rx_status = FXGMAC_MTL_IO_RD(priv, queue, MTL_Q_RQDR);
+		rx_q = FXGMAC_GET_BITS(rx_status, MTL_Q_RQDR, PRXQ);
+		rx_q_sts = FXGMAC_GET_BITS(rx_status, MTL_Q_RQDR, RXQSTS);
+		if (rx_q == 0 && rx_q_sts == 0)
+			break;
+
+		fsleep(500);
+	}
+
+	if (!time_before(jiffies, rx_timeout))
+		yt_err(priv, "timed out waiting for Rx queue %u to empty\n",
+		       queue);
+}
+
+static void fxgmac_disable_rx(struct fxgmac_pdata *priv)
+{
+	struct fxgmac_channel *channel = priv->channel_head;
+	u32 i;
+
+	/* Disable MAC Rx */
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, CST, 0);
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, ACS, 0);
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, RE, 0);
+
+	/* Prepare for Rx DMA channel stop */
+	for (i = 0; i < priv->rx_q_count; i++)
+		fxgmac_prepare_rx_stop(priv, i);
+
+	FXGMAC_MAC_IO_WR(priv, MAC_RQC0R, 0); /* Disable each Rx queue */
+
+	/* Disable each Rx DMA channel */
+	for (i = 0; i < priv->channel_count; i++, channel++)
+		FXGMAC_DMA_IO_WR_BITS(channel, DMA_CH_RCR, SR, 0);
+}
+
+/**
+ * fxgmac_set_oob_wol - disable or enable oob wol crtl function
+ * @priv: driver private struct
+ * @enable: 1 or 0
+ *
+ * Description:  After enable OOB_WOL from efuse, mac will loopcheck phy status,
+ *   and lead to panic sometimes. So we should disable it from powerup,
+ *   enable it from power down.
+ */
+static void fxgmac_set_oob_wol(struct fxgmac_pdata *priv, unsigned int en)
+{
+	FXGMAC_IO_WR_BITS(priv, OOB_WOL_CTRL, DIS, !en);/* en = 1 is disable */
+}
+
+static void fxgmac_pre_powerdown(struct fxgmac_pdata *priv)
+{
+	fxgmac_set_oob_wol(priv, 1);
+	fsleep(2000);
+}
+
 static void fxgmac_phy_release(struct fxgmac_pdata *priv)
 {
 	FXGMAC_IO_WR_BITS(priv, EPHY_CTRL, RESET, 1);
@@ -110,6 +334,83 @@ void fxgmac_phy_reset(struct fxgmac_pdata *priv)
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
+	struct net_device *netdev = priv->netdev;
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
+	netif_carrier_off(netdev);
+	netif_tx_stop_all_queues(netdev);
+	fxgmac_disable_tx(priv);
+	fxgmac_disable_rx(priv);
+	fxgmac_free_irqs(priv);
+	fxgmac_napi_disable(priv);
+	phy_stop(priv->phydev);
+
+	txq = netdev_get_tx_queue(netdev, priv->channel_head->queue_index);
+	netdev_tx_reset_queue(txq);
+}
+
+static void fxgmac_config_powerdown(struct fxgmac_pdata *priv)
+{
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, RE, 1); /* Enable MAC Rx */
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_CR, TE, 1); /* Enable MAC TX */
+
+	/* Set GAMC power down */
+	FXGMAC_MAC_IO_WR_BITS(priv, MAC_PMT_STA, PWRDWN, 1);
+}
+
+int fxgmac_net_powerdown(struct fxgmac_pdata *priv)
+{
+	struct net_device *netdev = priv->netdev;
+
+	/* Signal that we are down to the interrupt handler */
+	if (__test_and_set_bit(FXGMAC_POWER_STATE_DOWN, &priv->powerstate))
+		return 0; /* do nothing if already down */
+
+	__clear_bit(FXGMAC_POWER_STATE_UP, &priv->powerstate);
+	netif_tx_stop_all_queues(netdev); /* Shut off incoming Tx traffic */
+
+	/* Call carrier off first to avoid false dev_watchdog timeouts */
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+	fxgmac_disable_rx(priv);
+
+	/* Synchronize_rcu() needed for pending XDP buffers to drain */
+	synchronize_rcu();
+
+	fxgmac_stop(priv);
+	fxgmac_pre_powerdown(priv);
+
+	if (!test_bit(FXGMAC_POWER_STATE_DOWN, &priv->powerstate))
+		yt_err(priv,
+		       "fxgmac powerstate is %lu when config powe down.\n",
+		       priv->powerstate);
+
+	/* Set mac to lowpower mode */
+	fxgmac_config_powerdown(priv);
+	fxgmac_free_tx_data(priv);
+	fxgmac_free_rx_data(priv);
+
+	return 0;
+}
+
 #ifdef CONFIG_PCI_MSI
 static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *priv)
 {
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
index 1b80ae15a..fba01e393 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
@@ -80,6 +80,29 @@ static void fxgmac_remove(struct pci_dev *pcidev)
 	dev_dbg(dev, "%s has been removed\n", netdev->name);
 }
 
+static void __fxgmac_shutdown(struct pci_dev *pcidev)
+{
+	struct fxgmac_pdata *priv = dev_get_drvdata(&pcidev->dev);
+	struct net_device *netdev = priv->netdev;
+
+	rtnl_lock();
+	fxgmac_net_powerdown(priv);
+	netif_device_detach(netdev);
+	rtnl_unlock();
+}
+
+static void fxgmac_shutdown(struct pci_dev *pcidev)
+{
+	struct fxgmac_pdata *priv = dev_get_drvdata(&pcidev->dev);
+
+	mutex_lock(&priv->mutex);
+	 __fxgmac_shutdown(pcidev);
+	if (system_state == SYSTEM_POWER_OFF) {
+		pci_wake_from_d3(pcidev, false);
+		pci_set_power_state(pcidev, PCI_D3hot);
+	}
+	mutex_unlock(&priv->mutex);
+}
 #define MOTORCOMM_PCI_ID			0x1f0a
 #define YT6801_PCI_DEVICE_ID			0x6801
 
@@ -95,6 +118,7 @@ static struct pci_driver fxgmac_pci_driver = {
 	.id_table	= fxgmac_pci_tbl,
 	.probe		= fxgmac_probe,
 	.remove		= fxgmac_remove,
+	.shutdown	= fxgmac_shutdown,
 };
 
 module_pci_driver(fxgmac_pci_driver);
-- 
2.34.1


