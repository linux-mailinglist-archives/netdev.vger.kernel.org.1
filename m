Return-Path: <netdev+bounces-118067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DDD950714
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32F61F236F6
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59919DF92;
	Tue, 13 Aug 2024 14:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087F19D086;
	Tue, 13 Aug 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557765; cv=none; b=teRLaL+E8l/HyLtIagXXhrmuxBIixzSeZjjP2Z0UnmUJVBx5lGgkoZ/EgWOCjT0stK26XzhAK6oyTkean3nmyIYLic6SsfTsIc11JCnDJco2T/MgihwJLynmV4Ht5Vbh6zu4ta0t4lneRbRE2ypmjq89gjUxGKXaSna9QkmN1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557765; c=relaxed/simple;
	bh=wW7f0HLb0D4DI9iVhaBYxLqLnPX0Yay8Xm2agjrHXEo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWu0AMzcOzLwok2U0ioPtNdlq/PiNFkoCg+Gnwcn/+BVqlytj6C8gIpR12vrvAkE3bRTl3Qw+jivQz4Jkl3TWCLYCRTJ29WXQsnNqcTyvPCYpEcvzCClvnAwyfFfk9Zdx02CHuvCHckVAqP7bZ8QVhJVat5k6OWy46ioL2vQoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WjtL05h3Vz1HGF8;
	Tue, 13 Aug 2024 21:59:36 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 32CC4140134;
	Tue, 13 Aug 2024 22:02:40 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 22:02:39 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <andrew@lunn.ch>,
	<jdamato@fastly.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH V2 net-next 07/11] net: hibmcge: Implement rx_poll function to receive packets
Date: Tue, 13 Aug 2024 21:56:36 +0800
Message-ID: <20240813135640.1694993-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240813135640.1694993-1-shaojijie@huawei.com>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Implement rx_poll function to read the rx descriptor after
receiving the rx interrupt. Adjust the skb based on the
descriptor to complete the reception of the packet.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |   5 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  10 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  |   8 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   2 +
 .../hisilicon/hibmcge/hbg_reg_union.h         |  65 ++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 156 +++++++++++++++++-
 8 files changed, 247 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index f63a5be936ed..84d386e31749 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -16,6 +16,10 @@
 #define HBG_VECTOR_NUM			4
 #define HBG_PCU_CACHE_LINE_SIZE		32
 #define HBG_TX_TIMEOUT_BUF_LEN		1024
+#define HBG_RX_DESCR			0x01
+
+#define HBG_PACKET_HEAD_SIZE	((HBG_RX_SKIP1 + HBG_RX_SKIP2 + HBG_RX_DESCR) * \
+				 HBG_PCU_CACHE_LINE_SIZE)
 
 enum hbg_tx_state {
 	HBG_TX_STATE_COMPLETE = 0, /* clear state, must fix to 0 */
@@ -132,6 +136,7 @@ struct hbg_priv {
 	struct hbg_mac mac;
 	struct hbg_vector vectors;
 	struct hbg_ring tx_ring;
+	struct hbg_ring rx_ring;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 9a8f18cece1a..d6e1600988e4 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -67,6 +67,7 @@ int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 		return -EADDRNOTAVAIL;
 
 	dev_specs->max_frame_len = HBG_PCU_CACHE_LINE_SIZE + dev_specs->max_mtu;
+	dev_specs->rx_buf_size = HBG_PACKET_HEAD_SIZE + dev_specs->max_frame_len;
 	return 0;
 }
 
@@ -116,6 +117,10 @@ u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir)
 		return hbg_reg_read_field(priv, HBG_REG_CF_CFF_DATA_NUM_ADDR,
 					  HBG_REG_CF_CFF_DATA_NUM_ADDR_TX_M);
 
+	if (hbg_dir_has_rx(dir))
+		return hbg_reg_read_field(priv, HBG_REG_CF_CFF_DATA_NUM_ADDR,
+					  HBG_REG_CF_CFF_DATA_NUM_ADDR_RX_M);
+
 	return 0;
 }
 
@@ -127,6 +132,11 @@ void hbg_hw_set_tx_desc(struct hbg_priv *priv, struct hbg_tx_desc *tx_desc)
 	hbg_reg_write(priv, HBG_REG_TX_CFF_ADDR_3_ADDR, tx_desc->clear_addr);
 }
 
+void hbg_hw_fill_buffer(struct hbg_priv *priv, u32 buffer_dma_addr)
+{
+	hbg_reg_write(priv, HBG_REG_RX_CFF_ADDR_ADDR, buffer_dma_addr);
+}
+
 void hbg_hw_get_err_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status)
 {
 	status->bits = hbg_reg_read(priv, HBG_REG_CF_INTRPT_STAT_ADDR);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 012845dd95bb..d056d31c58ae 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -43,5 +43,6 @@ void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu);
 int hbg_hw_init(struct hbg_priv *pri);
 u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir);
 void hbg_hw_set_tx_desc(struct hbg_priv *priv, struct hbg_tx_desc *tx_desc);
+void hbg_hw_fill_buffer(struct hbg_priv *priv, u32 buffer_dma_addr);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index 134c59a7986c..3e1c80315ea6 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -19,9 +19,15 @@ static void hbg_irq_handle_tx(struct hbg_priv *priv,
 	napi_schedule(&priv->tx_ring.napi);
 }
 
+static void hbg_irq_handle_rx(struct hbg_priv *priv,
+			      struct hbg_irq_info *irq_info)
+{
+	napi_schedule(&priv->rx_ring.napi);
+}
+
 static struct hbg_irq_info hbg_irqs[] = {
 	{ "TX", HBG_IRQ_TX, false, false, 0, hbg_irq_handle_tx },
-	{ "RX", HBG_IRQ_RX, false, false, 0, NULL },
+	{ "RX", HBG_IRQ_RX, false, false, 0, hbg_irq_handle_rx },
 	{ "RX_BUF_AVL", HBG_IRQ_BUF_AVL, true, false, 0, hbg_irq_handle_err },
 	{ "MAC_MII_FIFO_ERR", HBG_IRQ_MAC_MII_FIFO_ERR,
 	  true, true, 0, hbg_irq_handle_err },
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index e08e3a477cea..0024af404762 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -36,6 +36,7 @@ static int hbg_net_open(struct net_device *dev)
 		return 0;
 
 	netif_carrier_off(dev);
+	napi_enable(&priv->rx_ring.napi);
 	napi_enable(&priv->tx_ring.napi);
 	hbg_all_irq_enable(priv, true);
 	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
@@ -59,6 +60,7 @@ static int hbg_net_stop(struct net_device *dev)
 	hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
 	hbg_all_irq_enable(priv, false);
 	napi_disable(&priv->tx_ring.napi);
+	napi_disable(&priv->rx_ring.napi);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 0feb3cd24937..99432c9d052d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -54,10 +54,12 @@
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
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
index 6a2a585451d7..d6d511f836b4 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg_union.h
@@ -198,4 +198,69 @@ struct hbg_tx_desc {
 	u32 clear_addr; /* word3 */
 };
 
+struct hbg_rx_desc {
+	union {
+		struct {
+			u32 rsv : 3;
+			u32 tt : 2;
+			u32 group : 4;
+			u32 qos : 3;
+			u32 gen_id : 8;
+			u32 rsv1 : 12;
+		};
+		u32 word0;
+	};
+	u32 tag; /* word1 */
+	union {
+		struct {
+			u32 all_skip_len : 9;
+			u32 rsv2 : 3;
+			u32 port_num : 4;
+			u32 len : 16;
+		};
+		u32 word2;
+	};
+	union {
+		struct {
+			u16 vlan;
+			u8 ip_offset;
+			u8 buf_num;
+		};
+		u32 word3;
+	};
+	union {
+		struct {
+			u32 rsv3 : 5;
+			u32 pm : 2;
+			u32 index_match : 1;
+			u32 l2_error : 1;
+			u32 l3_error_code : 4;
+			u32 drop : 1;
+			u32 vlan_flag : 1;
+			u32 icmp : 1;
+			u32 rarp : 1;
+			u32 arp : 1;
+			u32 mul_cst : 1;
+			u32 brd_cst : 1;
+			u32 ip_version_err : 1;
+			u32 opt : 1;
+			u32 frag : 1;
+			u32 l4_error_code : 4;
+			u32 rsv4 : 1;
+			u32 ip_version : 1;
+			u32 ipsec : 1;
+			u32 ip_tcp_udp : 2;
+		};
+		u32 word4;
+	};
+	union {
+		struct {
+			u16 size;
+			u8 rsv5;
+			u8 back;
+		};
+		u32 word5;
+	};
+};
+
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index bd16f5df3b5f..7c2aee4f95c9 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -14,6 +14,9 @@
 #define hbg_queue_is_full(head, tail, ring) ((head) == ((tail) + 1) % (ring)->len)
 #define hbg_queue_is_empty(head, tail) ((head) == (tail))
 #define hbg_queue_next_prt(p, ring) (((p) + 1) % (ring)->len)
+#define hbg_queue_move_next(p, ring) ({ \
+	typeof(ring) _ring = (ring); \
+	_ring->p = hbg_queue_next_prt(_ring->p, _ring); })
 
 static int hbg_dma_map(struct hbg_buffer *buffer)
 {
@@ -117,6 +120,20 @@ static void hbg_buffer_free_skb(struct hbg_buffer *buffer)
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
@@ -163,6 +180,107 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
 	return packet_done;
 }
 
+static int hbg_rx_fill_one_buffer(struct hbg_priv *priv)
+{
+	struct hbg_ring *ring = &priv->rx_ring;
+	struct hbg_buffer *buffer;
+	int ret;
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
+static int hbg_rx_fill_buffers(struct hbg_priv *priv)
+{
+	struct hbg_ring *ring = &priv->rx_ring;
+	int ret;
+
+	while (!(hbg_fifo_is_full(priv, ring->dir) ||
+		 hbg_queue_is_full(ring->ntc, ring->ntu, ring))) {
+		ret = hbg_rx_fill_one_buffer(priv);
+		if (ret)
+			return ret;
+	}
+
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
+	return rx_desc->len != 0;
+}
+
+static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
+{
+	struct hbg_ring *ring = container_of(napi, struct hbg_ring, napi);
+	struct hbg_priv *priv = ring->priv;
+	struct hbg_rx_desc *rx_desc;
+	struct hbg_buffer *buffer;
+	u32 packet_done = 0;
+
+	if (unlikely(!hbg_nic_is_open(priv))) {
+		napi_complete(napi);
+		return 0;
+	}
+
+	while (packet_done < budget) {
+		if (unlikely(hbg_queue_is_empty(ring->ntc, ring->ntu)))
+			break;
+
+		buffer = &ring->queue[ring->ntc];
+		if (unlikely(!buffer->skb))
+			goto next_buffer;
+
+		if (unlikely(!hbg_sync_data_from_hw(priv, buffer)))
+			break;
+
+		hbg_dma_unmap(buffer);
+
+		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
+		skb_reserve(buffer->skb, HBG_PACKET_HEAD_SIZE + NET_IP_ALIGN);
+		skb_put(buffer->skb, rx_desc->len);
+		buffer->skb->protocol = eth_type_trans(buffer->skb, priv->netdev);
+
+		priv->netdev->stats.rx_bytes += rx_desc->len;
+		priv->netdev->stats.rx_packets++;
+		netif_receive_skb(buffer->skb);
+		buffer->skb = NULL;
+		hbg_rx_fill_one_buffer(priv);
+
+next_buffer:
+		hbg_queue_move_next(ntc, ring);
+		packet_done++;
+	}
+
+	hbg_rx_fill_buffers(priv);
+	if (likely(napi_complete_done(napi, packet_done)))
+		hbg_irq_enable(priv, HBG_IRQ_RX, true);
+
+	return packet_done;
+}
+
 static void hbg_ring_uninit(struct hbg_ring *ring)
 {
 	struct hbg_buffer *buffer;
@@ -240,15 +358,50 @@ static int hbg_tx_ring_init(struct hbg_priv *priv)
 	return 0;
 }
 
+static int hbg_rx_ring_init(struct hbg_priv *priv)
+{
+	struct hbg_ring *rx_ring = &priv->rx_ring;
+	int ret;
+
+	ret = hbg_ring_init(priv, rx_ring, HBG_DIR_RX);
+	if (ret)
+		return ret;
+
+	netif_napi_add(priv->netdev, &priv->rx_ring.napi, hbg_napi_rx_poll);
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
+		goto err_uninit_tx;
+	}
+
+	ret = hbg_rx_fill_buffers(priv);
+	if (ret) {
+		dev_err(&priv->pdev->dev,
+			"failed to fill rx buffers, ret = %d\n", ret);
+		goto err_uninit_rx;
+	}
 
+	return 0;
+
+err_uninit_rx:
+	hbg_ring_uninit(&priv->rx_ring);
+err_uninit_tx:
+	hbg_ring_uninit(&priv->tx_ring);
 	return ret;
 }
 
@@ -257,4 +410,5 @@ void hbg_txrx_uninit(void *data)
 	struct hbg_priv *priv = data;
 
 	hbg_ring_uninit(&priv->tx_ring);
+	hbg_ring_uninit(&priv->rx_ring);
 }
-- 
2.33.0


