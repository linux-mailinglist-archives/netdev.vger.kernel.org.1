Return-Path: <netdev+bounces-240941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29042C7C529
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 04:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 327CA351A67
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880519E98D;
	Sat, 22 Nov 2025 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BQIrW9r1"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B4542AA9;
	Sat, 22 Nov 2025 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763783262; cv=none; b=oxfC2cXRsdcF3EVEkl28++nKPs+nMZwQ5qyGbwY/rRahHNgcuhnrwrVdQyQHJnjOa0ERiQYAuqB1Qt4jB4hVyt78RNUqUsC++O5Ap89BLT3CWoJVJ9oTiIyXvsKAmgw2YOk0ClnzpTr107hhXER6kSX3aFrT1NQaDN+IF7MK5Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763783262; c=relaxed/simple;
	bh=4YauUqqOOPCmZ4tlSquuIiVXg7KozkQnAaK1CuBXwf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHwHxjRQoQD6nN3eNSsIAYGw8W98QDM1mxzuc2MNFLd69BTjoQrmGcp8mzq12aUwlo7Vu0ZgVbwzXZIH/Tcf5O7YOLwfiLOBshZLDwuvVCb6Q8eWVvc311JubXru9UAGlAHgt6dr0D+ac/qsG9ZjhAhtvFsmQtLx3CMfakd/Pkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BQIrW9r1; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zWY3g5xFWpq3JjR08Srb0jBJwjCfAQJ7FrnWFA1W8TQ=;
	b=BQIrW9r11iRz7iOfJfC4RKjecCiFiFW5dGidld+RpDzRDYL83WEcsOyN/xZiUAmiPtm0uETnb
	gZza/nJjiDP6QxwF/wQhvXQOkDG61RAVGePCgk+iT1087ZrV2ymynHGGNM6GVU+cnxfzTIyHzej
	ULrC8auQL1+uqzwYWMMbT1E=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dCyfn4rc5z1K96B;
	Sat, 22 Nov 2025 11:45:53 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 719481A016C;
	Sat, 22 Nov 2025 11:47:37 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 22 Nov 2025 11:47:36 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net-next 3/3] net: hibmcge: add support for pagepool on rx
Date: Sat, 22 Nov 2025 11:46:57 +0800
Message-ID: <20251122034657.3373143-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251122034657.3373143-1-shaojijie@huawei.com>
References: <20251122034657.3373143-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

add support for pagepool on rx, and remove the legacy path

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v1 -> v2:
  - remove the legacy path after using pagepool, suggested by Jakub.
  v1: https://lore.kernel.org/all/20251117174957.631e7b40@kernel.org/
---
 drivers/net/ethernet/hisilicon/Kconfig        |   1 +
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |   8 +
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 166 ++++++++++++++----
 3 files changed, 142 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 38875c196cb6..18eca7d12c20 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -151,6 +151,7 @@ config HIBMCGE
 	select FIXED_PHY
 	select MOTORCOMM_PHY
 	select REALTEK_PHY
+	select PAGE_POOL
 	help
 	  If you wish to compile a kernel for a BMC with HIBMC-xx_gmac
 	  then you should answer Y to this. This makes this driver suitable for use
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 2097e4c2b3d7..8e134da3e217 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -7,6 +7,7 @@
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <net/page_pool/helpers.h>
 #include "hbg_reg.h"
 
 #define HBG_STATUS_DISABLE		0x0
@@ -55,6 +56,12 @@ struct hbg_buffer {
 	dma_addr_t skb_dma;
 	u32 skb_len;
 
+	struct page *page;
+	void *page_addr;
+	dma_addr_t page_dma;
+	u32 page_size;
+	u32 page_offset;
+
 	enum hbg_dir dir;
 	struct hbg_ring *ring;
 	struct hbg_priv *priv;
@@ -78,6 +85,7 @@ struct hbg_ring {
 	struct hbg_priv *priv;
 	struct napi_struct napi;
 	char *tout_log_buf; /* tx timeout log buffer */
+	struct page_pool *page_pool; /* only for rx */
 };
 
 enum hbg_hw_event_type {
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index ea691d564161..a4ea92c31c2f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -31,6 +31,11 @@
 	typeof(ring) _ring = (ring); \
 	_ring->p = hbg_queue_next_prt(_ring->p, _ring); })
 
+#define hbg_get_page_order(ring) ({ \
+	typeof(ring) _ring = (ring); \
+	get_order(hbg_spec_max_frame_len(_ring->priv, _ring->dir)); })
+#define hbg_get_page_size(ring) (PAGE_SIZE << hbg_get_page_order((ring)))
+
 #define HBG_TX_STOP_THRS	2
 #define HBG_TX_START_THRS	(2 * HBG_TX_STOP_THRS)
 
@@ -65,6 +70,43 @@ static void hbg_dma_unmap(struct hbg_buffer *buffer)
 	buffer->skb_dma = 0;
 }
 
+static void hbg_buffer_free_page(struct hbg_buffer *buffer)
+{
+	struct hbg_ring *ring = buffer->ring;
+
+	if (unlikely(!buffer->page))
+		return;
+
+	page_pool_put_full_page(ring->page_pool, buffer->page, false);
+
+	buffer->page = NULL;
+	buffer->page_dma = 0;
+	buffer->page_addr = NULL;
+	buffer->page_size = 0;
+	buffer->page_offset = 0;
+}
+
+static int hbg_buffer_alloc_page(struct hbg_buffer *buffer)
+{
+	struct hbg_ring *ring = buffer->ring;
+	u32 len = hbg_get_page_size(ring);
+	u32 offset;
+
+	if (unlikely(!ring->page_pool))
+		return 0;
+
+	buffer->page = page_pool_dev_alloc_frag(ring->page_pool, &offset, len);
+	if (unlikely(!buffer->page))
+		return -ENOMEM;
+
+	buffer->page_dma = page_pool_get_dma_addr(buffer->page) + offset;
+	buffer->page_addr = page_address(buffer->page) + offset;
+	buffer->page_size = len;
+	buffer->page_offset = offset;
+
+	return 0;
+}
+
 static void hbg_init_tx_desc(struct hbg_buffer *buffer,
 			     struct hbg_tx_desc *tx_desc)
 {
@@ -138,24 +180,14 @@ static void hbg_buffer_free_skb(struct hbg_buffer *buffer)
 	buffer->skb = NULL;
 }
 
-static int hbg_buffer_alloc_skb(struct hbg_buffer *buffer)
-{
-	u32 len = hbg_spec_max_frame_len(buffer->priv, buffer->dir);
-	struct hbg_priv *priv = buffer->priv;
-
-	buffer->skb = netdev_alloc_skb(priv->netdev, len);
-	if (unlikely(!buffer->skb))
-		return -ENOMEM;
-
-	buffer->skb_len = len;
-	memset(buffer->skb->data, 0, HBG_PACKET_HEAD_SIZE);
-	return 0;
-}
-
 static void hbg_buffer_free(struct hbg_buffer *buffer)
 {
-	hbg_dma_unmap(buffer);
-	hbg_buffer_free_skb(buffer);
+	if (buffer->skb) {
+		hbg_dma_unmap(buffer);
+		return hbg_buffer_free_skb(buffer);
+	}
+
+	hbg_buffer_free_page(buffer);
 }
 
 static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
@@ -382,17 +414,15 @@ static int hbg_rx_fill_one_buffer(struct hbg_priv *priv)
 		return 0;
 
 	buffer = &ring->queue[ring->ntu];
-	ret = hbg_buffer_alloc_skb(buffer);
+	ret = hbg_buffer_alloc_page(buffer);
 	if (unlikely(ret))
 		return ret;
 
-	ret = hbg_dma_map(buffer);
-	if (unlikely(ret)) {
-		hbg_buffer_free_skb(buffer);
-		return ret;
-	}
+	memset(buffer->page_addr, 0, HBG_PACKET_HEAD_SIZE);
+	dma_sync_single_for_device(&priv->pdev->dev, buffer->page_dma,
+				   HBG_PACKET_HEAD_SIZE, DMA_TO_DEVICE);
 
-	hbg_hw_fill_buffer(priv, buffer->skb_dma);
+	hbg_hw_fill_buffer(priv, buffer->page_dma);
 	hbg_queue_move_next(ntu, ring);
 	return 0;
 }
@@ -425,13 +455,29 @@ static bool hbg_sync_data_from_hw(struct hbg_priv *priv,
 	/* make sure HW write desc complete */
 	dma_rmb();
 
-	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->skb_dma,
-				buffer->skb_len, DMA_FROM_DEVICE);
+	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->page_dma,
+				buffer->page_size, DMA_FROM_DEVICE);
 
-	rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
+	rx_desc = (struct hbg_rx_desc *)buffer->page_addr;
 	return FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2) != 0;
 }
 
+static int hbg_build_skb(struct hbg_priv *priv,
+			 struct hbg_buffer *buffer, u32 pkt_len)
+{
+	net_prefetch(buffer->page_addr);
+
+	buffer->skb = napi_build_skb(buffer->page_addr, buffer->page_size);
+	if (unlikely(!buffer->skb))
+		return -ENOMEM;
+	skb_mark_for_recycle(buffer->skb);
+
+	/* page will be freed together with the skb */
+	buffer->page = NULL;
+
+	return 0;
+}
+
 static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 {
 	struct hbg_ring *ring = container_of(napi, struct hbg_ring, napi);
@@ -447,29 +493,33 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 			break;
 
 		buffer = &ring->queue[ring->ntc];
-		if (unlikely(!buffer->skb))
+		if (unlikely(!buffer->page))
 			goto next_buffer;
 
 		if (unlikely(!hbg_sync_data_from_hw(priv, buffer)))
 			break;
-		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
+		rx_desc = (struct hbg_rx_desc *)buffer->page_addr;
 		pkt_len = FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2);
 		trace_hbg_rx_desc(priv, ring->ntc, rx_desc);
 
+		if (unlikely(hbg_build_skb(priv, buffer, pkt_len))) {
+			hbg_buffer_free_page(buffer);
+			goto next_buffer;
+		}
+
 		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc, buffer->skb))) {
-			hbg_buffer_free(buffer);
+			hbg_buffer_free_skb(buffer);
 			goto next_buffer;
 		}
 
-		hbg_dma_unmap(buffer);
 		skb_reserve(buffer->skb, HBG_PACKET_HEAD_SIZE + NET_IP_ALIGN);
 		skb_put(buffer->skb, pkt_len);
 		buffer->skb->protocol = eth_type_trans(buffer->skb,
 						       priv->netdev);
-
 		dev_sw_netstats_rx_add(priv->netdev, pkt_len);
 		napi_gro_receive(napi, buffer->skb);
 		buffer->skb = NULL;
+		buffer->page = NULL;
 
 next_buffer:
 		hbg_rx_fill_one_buffer(priv);
@@ -484,6 +534,42 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 	return packet_done;
 }
 
+static void hbg_ring_page_pool_destory(struct hbg_ring *ring)
+{
+	if (!ring->page_pool)
+		return;
+
+	page_pool_destroy(ring->page_pool);
+	ring->page_pool = NULL;
+}
+
+static int hbg_ring_page_pool_init(struct hbg_priv *priv, struct hbg_ring *ring)
+{
+	u32 buf_size = hbg_spec_max_frame_len(priv, ring->dir);
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order = hbg_get_page_order(ring),
+		.pool_size = ring->len * buf_size / hbg_get_page_size(ring),
+		.nid = dev_to_node(&priv->pdev->dev),
+		.dev = &priv->pdev->dev,
+		.napi = &ring->napi,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = 0,
+		.max_len = hbg_get_page_size(ring),
+	};
+	int ret = 0;
+
+	ring->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(ring->page_pool)) {
+		ret = PTR_ERR(ring->page_pool);
+		dev_err(&priv->pdev->dev,
+			"failed to create page pool, ret = %d\n", ret);
+		ring->page_pool = NULL;
+	}
+
+	return ret;
+}
+
 static void hbg_ring_uninit(struct hbg_ring *ring)
 {
 	struct hbg_buffer *buffer;
@@ -502,6 +588,7 @@ static void hbg_ring_uninit(struct hbg_ring *ring)
 		buffer->priv = NULL;
 	}
 
+	hbg_ring_page_pool_destory(ring);
 	dma_free_coherent(&ring->priv->pdev->dev,
 			  ring->len * sizeof(*ring->queue),
 			  ring->queue, ring->queue_dma);
@@ -517,6 +604,7 @@ static int hbg_ring_init(struct hbg_priv *priv, struct hbg_ring *ring,
 {
 	struct hbg_buffer *buffer;
 	u32 i, len;
+	int ret;
 
 	len = hbg_get_spec_fifo_max_num(priv, dir) + 1;
 	/* To improve receiving performance under high-stress scenarios,
@@ -550,11 +638,23 @@ static int hbg_ring_init(struct hbg_priv *priv, struct hbg_ring *ring,
 	ring->ntu = 0;
 	ring->len = len;
 
-	if (dir == HBG_DIR_TX)
+	if (dir == HBG_DIR_TX) {
 		netif_napi_add_tx(priv->netdev, &ring->napi, napi_poll);
-	else
+	} else {
 		netif_napi_add(priv->netdev, &ring->napi, napi_poll);
 
+		ret = hbg_ring_page_pool_init(priv, ring);
+		if (ret) {
+			netif_napi_del(&ring->napi);
+			dma_free_coherent(&ring->priv->pdev->dev,
+					  ring->len * sizeof(*ring->queue),
+					  ring->queue, ring->queue_dma);
+			ring->queue = NULL;
+			ring->len = 0;
+			return ret;
+		}
+	}
+
 	napi_enable(&ring->napi);
 	return 0;
 }
-- 
2.33.0


