Return-Path: <netdev+bounces-134292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 032FE998B6C
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC6CB344F6
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EECC1EABA6;
	Thu, 10 Oct 2024 14:28:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67B1CCEEA;
	Thu, 10 Oct 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570515; cv=none; b=HzoR4H22hZDBoDi8cMUAPlpbxSky60TyLIA7GuBlVXS6CtA2ob+Q3iNYzp8uPc9YIypDQ2Ofl3X/kIr8vefCs4mwhBj7RfCTT1HAbuS1FdBE102KcEirvVxsssCORDF3mp/BvbFEUWTTJQ7JJTBGvoknR+OORkquy9fDOhoPtSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570515; c=relaxed/simple;
	bh=6oPLpF5B7z8dCmOmLkmOyiKhj2c+K8LvLwAuHQKr9tA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGo/ILxrCPyooI/Uh0emb+jYl0xfoGqPRFKCTHK8WNIrvqurFE2vgv8W9eQqO4z0ni8aKdUaXmIUiYEJGNK0HXTVLdi/U0K62LqjWIoj7rvUpCwK3qzJ5ztSBuiXpCtmFxWw44VSzeRBNpTcLYY+CNFlBIdMblwGlWfWsPye81Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPX7p2yMyz1HJpM;
	Thu, 10 Oct 2024 22:24:22 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 60BC01400DC;
	Thu, 10 Oct 2024 22:28:29 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 22:28:28 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>, <christophe.jaillet@wanadoo.fr>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V12 net-next 07/10] net: hibmcge: Implement rx_poll function to receive packets
Date: Thu, 10 Oct 2024 22:21:36 +0800
Message-ID: <20241010142139.3805375-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241010142139.3805375-1-shaojijie@huawei.com>
References: <20241010142139.3805375-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Implement rx_poll function to read the rx descriptor after
receiving the rx interrupt. Adjust the skb based on the
descriptor to complete the reception of the packet.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v11 -> v12:
  - Fix some warnings detected by checkpatch, suggested by Jakub and Simon Horman.
     ./scripts/checkpatch.pl --strict --codespell --max-line-length=80
  v11: https://lore.kernel.org/all/20241008022358.863393-1-shaojijie@huawei.com/
v10 -> v11:
  - Not call napi_complete_done() if packet_done >= budget in napi.poll(),
    suggested by Jakub.
  - Not refill the buffers if budget is 0 in RX napi.poll(), suggested by Jakub.
  - Use napi_gro_receive() instead of netif_receive_skb(), suggested by Jakub.
  v10: https://lore.kernel.org/all/20240912025127.3912972-1-shaojijie@huawei.com/
v8 -> v9:
  - Remove hbg_nic_is_open() judgment from hbg_napi_rx_poll()
  v8: https://lore.kernel.org/all/20240909023141.3234567-1-shaojijie@huawei.com/
v6 -> v7:
  - Use dev_sw_netstats_rx_add() instead of dev->stats, suggested by Paolo.
  v6: https://lore.kernel.org/all/20240830121604.2250904-8-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |   5 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  10 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  |   8 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  13 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 143 +++++++++++++++++-
 6 files changed, 177 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index cceb674bd1c8..96daf058d387 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -15,6 +15,10 @@
 #define HBG_VECTOR_NUM			4
 #define HBG_PCU_CACHE_LINE_SIZE		32
 #define HBG_TX_TIMEOUT_BUF_LEN		1024
+#define HBG_RX_DESCR			0x01
+
+#define HBG_PACKET_HEAD_SIZE	((HBG_RX_SKIP1 + HBG_RX_SKIP2 + \
+				  HBG_RX_DESCR) * HBG_PCU_CACHE_LINE_SIZE)
 
 enum hbg_dir {
 	HBG_DIR_TX = 1 << 0,
@@ -121,6 +125,7 @@ struct hbg_priv {
 	struct hbg_mac mac;
 	struct hbg_vector vectors;
 	struct hbg_ring tx_ring;
+	struct hbg_ring rx_ring;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 05c71887b25a..05295c2ad439 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -74,6 +74,7 @@ static int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 		return -EADDRNOTAVAIL;
 
 	specs->max_frame_len = HBG_PCU_CACHE_LINE_SIZE + specs->max_mtu;
+	specs->rx_buf_size = HBG_PACKET_HEAD_SIZE + specs->max_frame_len;
 	return 0;
 }
 
@@ -178,6 +179,10 @@ u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir)
 		return hbg_reg_read_field(priv, HBG_REG_CF_CFF_DATA_NUM_ADDR,
 					  HBG_REG_CF_CFF_DATA_NUM_ADDR_TX_M);
 
+	if (dir & HBG_DIR_RX)
+		return hbg_reg_read_field(priv, HBG_REG_CF_CFF_DATA_NUM_ADDR,
+					  HBG_REG_CF_CFF_DATA_NUM_ADDR_RX_M);
+
 	return 0;
 }
 
@@ -189,6 +194,11 @@ void hbg_hw_set_tx_desc(struct hbg_priv *priv, struct hbg_tx_desc *tx_desc)
 	hbg_reg_write(priv, HBG_REG_TX_CFF_ADDR_3_ADDR, tx_desc->word3);
 }
 
+void hbg_hw_fill_buffer(struct hbg_priv *priv, u32 buffer_dma_addr)
+{
+	hbg_reg_write(priv, HBG_REG_RX_CFF_ADDR_ADDR, buffer_dma_addr);
+}
+
 void hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex)
 {
 	hbg_reg_write_field(priv, HBG_REG_PORT_MODE_ADDR,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 508e41cce41e..14fb39241c93 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -54,5 +54,6 @@ void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable);
 void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr);
 u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir);
 void hbg_hw_set_tx_desc(struct hbg_priv *priv, struct hbg_tx_desc *tx_desc);
+void hbg_hw_fill_buffer(struct hbg_priv *priv, u32 buffer_dma_addr);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index fed5502e51c8..25dd25f096fe 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -19,13 +19,19 @@ static void hbg_irq_handle_tx(struct hbg_priv *priv,
 	napi_schedule(&priv->tx_ring.napi);
 }
 
+static void hbg_irq_handle_rx(struct hbg_priv *priv,
+			      struct hbg_irq_info *irq_info)
+{
+	napi_schedule(&priv->rx_ring.napi);
+}
+
 #define HBG_TXRX_IRQ_I(name, handle) \
 	{#name, HBG_INT_MSK_##name##_B, false, false, 0, handle}
 #define HBG_ERR_IRQ_I(name, need_print) \
 	{#name, HBG_INT_MSK_##name##_B, true, need_print, 0, hbg_irq_handle_err}
 
 static struct hbg_irq_info hbg_irqs[] = {
-	HBG_TXRX_IRQ_I(RX, NULL),
+	HBG_TXRX_IRQ_I(RX, hbg_irq_handle_rx),
 	HBG_TXRX_IRQ_I(TX, hbg_irq_handle_tx),
 	HBG_ERR_IRQ_I(MAC_MII_FIFO_ERR, true),
 	HBG_ERR_IRQ_I(MAC_PCS_RX_FIFO_ERR, true),
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 0b7926a2a4fa..57d81c6d7633 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -82,10 +82,12 @@
 #define HBG_REG_MAX_FRAME_LEN_M			GENMASK(15, 0)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR		(HBG_REG_SGMII_BASE + 0x045C)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR_TX_M	GENMASK(8, 0)
+#define HBG_REG_CF_CFF_DATA_NUM_ADDR_RX_M	GENMASK(24, 16)
 #define HBG_REG_TX_CFF_ADDR_0_ADDR		(HBG_REG_SGMII_BASE + 0x0488)
 #define HBG_REG_TX_CFF_ADDR_1_ADDR		(HBG_REG_SGMII_BASE + 0x048C)
 #define HBG_REG_TX_CFF_ADDR_2_ADDR		(HBG_REG_SGMII_BASE + 0x0490)
 #define HBG_REG_TX_CFF_ADDR_3_ADDR		(HBG_REG_SGMII_BASE + 0x0494)
+#define HBG_REG_RX_CFF_ADDR_ADDR		(HBG_REG_SGMII_BASE + 0x04A0)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
@@ -127,4 +129,15 @@ struct hbg_tx_desc {
 #define HBG_TX_DESC_W0_l4_CS_B		BIT(0)
 #define HBG_TX_DESC_W1_SEND_LEN_M	GENMASK(19, 4)
 
+struct hbg_rx_desc {
+	u32 word0;
+	u32 word1; /* tag */
+	u32 word2;
+	u32 word3;
+	u32 word4;
+	u32 word5;
+};
+
+#define HBG_RX_DESC_W2_PKT_LEN_M	GENMASK(31, 16)
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index 6f828d7e77b3..f4f256a0dfea 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -21,7 +21,12 @@
 	_r->len - hbg_queue_used_num((head), (tail), _r) - 1; })
 #define hbg_queue_is_empty(head, tail, ring) \
 	(hbg_queue_used_num((head), (tail), (ring)) == 0)
+#define hbg_queue_is_full(head, tail, ring) \
+	(hbg_queue_left_num((head), (tail), (ring)) == 0)
 #define hbg_queue_next_prt(p, ring) (((p) + 1) % (ring)->len)
+#define hbg_queue_move_next(p, ring) ({ \
+	typeof(ring) _ring = (ring); \
+	_ring->p = hbg_queue_next_prt(_ring->p, _ring); })
 
 #define HBG_TX_STOP_THRS	2
 #define HBG_TX_START_THRS	(2 * HBG_TX_STOP_THRS)
@@ -124,6 +129,20 @@ static void hbg_buffer_free_skb(struct hbg_buffer *buffer)
 	buffer->skb = NULL;
 }
 
+static int hbg_buffer_alloc_skb(struct hbg_buffer *buffer)
+{
+	u32 len = hbg_spec_max_frame_len(buffer->priv, buffer->dir);
+	struct hbg_priv *priv = buffer->priv;
+
+	buffer->skb = netdev_alloc_skb(priv->netdev, len);
+	if (unlikely(!buffer->skb))
+		return -ENOMEM;
+
+	buffer->skb_len = len;
+	memset(buffer->skb->data, 0, HBG_PACKET_HEAD_SIZE);
+	return 0;
+}
+
 static void hbg_buffer_free(struct hbg_buffer *buffer)
 {
 	hbg_dma_unmap(buffer);
@@ -176,6 +195,92 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
 	return packet_done;
 }
 
+static int hbg_rx_fill_one_buffer(struct hbg_priv *priv)
+{
+	struct hbg_ring *ring = &priv->rx_ring;
+	struct hbg_buffer *buffer;
+	int ret;
+
+	if (hbg_queue_is_full(ring->ntc, ring->ntu, ring))
+		return 0;
+
+	buffer = &ring->queue[ring->ntu];
+	ret = hbg_buffer_alloc_skb(buffer);
+	if (unlikely(ret))
+		return ret;
+
+	ret = hbg_dma_map(buffer);
+	if (unlikely(ret)) {
+		hbg_buffer_free_skb(buffer);
+		return ret;
+	}
+
+	hbg_hw_fill_buffer(priv, buffer->skb_dma);
+	hbg_queue_move_next(ntu, ring);
+	return 0;
+}
+
+static bool hbg_sync_data_from_hw(struct hbg_priv *priv,
+				  struct hbg_buffer *buffer)
+{
+	struct hbg_rx_desc *rx_desc;
+
+	/* make sure HW write desc complete */
+	dma_rmb();
+
+	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->skb_dma,
+				buffer->skb_len, DMA_FROM_DEVICE);
+
+	rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
+	return FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2) != 0;
+}
+
+static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
+{
+	struct hbg_ring *ring = container_of(napi, struct hbg_ring, napi);
+	struct hbg_priv *priv = ring->priv;
+	struct hbg_rx_desc *rx_desc;
+	struct hbg_buffer *buffer;
+	u32 packet_done = 0;
+	u32 pkt_len;
+
+	while (packet_done < budget) {
+		if (unlikely(hbg_queue_is_empty(ring->ntc, ring->ntu, ring)))
+			break;
+
+		buffer = &ring->queue[ring->ntc];
+		if (unlikely(!buffer->skb))
+			goto next_buffer;
+
+		if (unlikely(!hbg_sync_data_from_hw(priv, buffer)))
+			break;
+		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
+		pkt_len = FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2);
+
+		hbg_dma_unmap(buffer);
+
+		skb_reserve(buffer->skb, HBG_PACKET_HEAD_SIZE + NET_IP_ALIGN);
+		skb_put(buffer->skb, pkt_len);
+		buffer->skb->protocol = eth_type_trans(buffer->skb,
+						       priv->netdev);
+
+		dev_sw_netstats_rx_add(priv->netdev, pkt_len);
+		napi_gro_receive(napi, buffer->skb);
+		buffer->skb = NULL;
+
+next_buffer:
+		hbg_rx_fill_one_buffer(priv);
+		hbg_queue_move_next(ntc, ring);
+		packet_done++;
+	}
+
+	if (likely(packet_done < budget &&
+		   napi_complete_done(napi, packet_done)))
+		hbg_hw_irq_enable(priv, HBG_INT_MSK_RX_B, true);
+
+	return packet_done;
+}
+
 static void hbg_ring_uninit(struct hbg_ring *ring)
 {
 	struct hbg_buffer *buffer;
@@ -232,7 +337,11 @@ static int hbg_ring_init(struct hbg_priv *priv, struct hbg_ring *ring,
 	ring->ntu = 0;
 	ring->len = len;
 
-	netif_napi_add_tx(priv->netdev, &ring->napi, napi_poll);
+	if (dir == HBG_DIR_TX)
+		netif_napi_add_tx(priv->netdev, &ring->napi, napi_poll);
+	else
+		netif_napi_add(priv->netdev, &ring->napi, napi_poll);
+
 	napi_enable(&ring->napi);
 	return 0;
 }
@@ -252,14 +361,43 @@ static int hbg_tx_ring_init(struct hbg_priv *priv)
 	return hbg_ring_init(priv, tx_ring, hbg_napi_tx_recycle, HBG_DIR_TX);
 }
 
+static int hbg_rx_ring_init(struct hbg_priv *priv)
+{
+	int ret;
+	u32 i;
+
+	ret = hbg_ring_init(priv, &priv->rx_ring, hbg_napi_rx_poll, HBG_DIR_RX);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < priv->rx_ring.len - 1; i++) {
+		ret = hbg_rx_fill_one_buffer(priv);
+		if (ret) {
+			hbg_ring_uninit(&priv->rx_ring);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int hbg_txrx_init(struct hbg_priv *priv)
 {
 	int ret;
 
 	ret = hbg_tx_ring_init(priv);
-	if (ret)
+	if (ret) {
 		dev_err(&priv->pdev->dev,
 			"failed to init tx ring, ret = %d\n", ret);
+		return ret;
+	}
+
+	ret = hbg_rx_ring_init(priv);
+	if (ret) {
+		dev_err(&priv->pdev->dev,
+			"failed to init rx ring, ret = %d\n", ret);
+		hbg_ring_uninit(&priv->tx_ring);
+	}
 
 	return ret;
 }
@@ -267,4 +405,5 @@ int hbg_txrx_init(struct hbg_priv *priv)
 void hbg_txrx_uninit(struct hbg_priv *priv)
 {
 	hbg_ring_uninit(&priv->tx_ring);
+	hbg_ring_uninit(&priv->rx_ring);
 }
-- 
2.33.0


