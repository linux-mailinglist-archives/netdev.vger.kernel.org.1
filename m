Return-Path: <netdev+bounces-238635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B87C5C427
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE7042271D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F2307481;
	Fri, 14 Nov 2025 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yzyDi5Tb"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B636D309EE1;
	Fri, 14 Nov 2025 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112207; cv=none; b=kT/MNwtzX1kRui9TCOBK5t/x7221MPF3VnkzJcGLtF2I1RkA8WMYrAPwR83ALrLISP4IIAWJC9Ksc2jKC2J4qNboREDNePoBmSpxEOPqUcyAkWDHbOJGLu8jRT7EnukUUZCx8yjbGpI6n7z9y4C8n+CfV+aO3XOzqJ94t9fUtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112207; c=relaxed/simple;
	bh=y6Bhnw8A+7hb0zMxFQ+p18ifH21QdDsCMZT5Q0VGIGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJhwTkGjdkoraBCPQIYmNqAGhQnzcHBHpEQHTWq3rZ46QDqIscscDhzWKA903yWVLWyrBxK55eJHla1Yi35kVzifqKHaI5vYBogmuCfXHsHJVzdkkXC9jGWdsmNnfGwzYS0XSmODHfzLMBw7DST4lRboq6kt4horfRB7N0gMVB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yzyDi5Tb; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YH4NmnPyTR38Qhd0hfRC5HRVvESSJJhOyXz473L3zW8=;
	b=yzyDi5TbEd7XrP7ZWCVXpsGqEnZqVYu/XSA1IAG9P/n31I4RJldZtZGPRUkDhs8Q29fk5J6Ui
	CmcdNcdoF486JsnDO0k/Xgd0h3u4inCcmfxc1iA5zOjChW3z3EMs30Diwo2owlCLHKuT7Yx1Qt8
	xUgvEoe++uprffpKCgmGXD4=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4d7BTt0YMMz1K9Bc;
	Fri, 14 Nov 2025 17:21:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 272021400CF;
	Fri, 14 Nov 2025 17:23:17 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Nov 2025 17:23:16 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 3/3] net: hibmcge: support pagepool for rx
Date: Fri, 14 Nov 2025 17:22:22 +0800
Message-ID: <20251114092222.2071583-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251114092222.2071583-1-shaojijie@huawei.com>
References: <20251114092222.2071583-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Support pagepool for rx, retaining the original
packet receiving process.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/Kconfig        |   1 +
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  23 ++-
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |   2 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   7 +
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 170 ++++++++++++++++--
 5 files changed, 185 insertions(+), 18 deletions(-)

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
index 2097e4c2b3d7..39cc18686f7e 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -7,6 +7,7 @@
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <net/page_pool/helpers.h>
 #include "hbg_reg.h"
 
 #define HBG_STATUS_DISABLE		0x0
@@ -52,8 +53,24 @@ struct hbg_buffer {
 	dma_addr_t state_dma;
 
 	struct sk_buff *skb;
-	dma_addr_t skb_dma;
-	u32 skb_len;
+	struct page *page;
+	u32 page_offset;
+
+	union {
+		void *skb_data_addr;
+		void *page_addr;
+		void *pkt_addr;
+	};
+	union {
+		dma_addr_t skb_dma;
+		dma_addr_t page_dma;
+		dma_addr_t pkt_dma;
+	};
+	union {
+		u32 skb_len;
+		u32 page_size;
+		u32 pkt_len;
+	};
 
 	enum hbg_dir dir;
 	struct hbg_ring *ring;
@@ -78,6 +95,7 @@ struct hbg_ring {
 	struct hbg_priv *priv;
 	struct napi_struct napi;
 	char *tout_log_buf; /* tx timeout log buffer */
+	struct page_pool *page_pool;
 };
 
 enum hbg_hw_event_type {
@@ -101,6 +119,7 @@ struct hbg_dev_specs {
 
 	u32 max_frame_len;
 	u32 rx_buf_size;
+	bool page_pool_enabled;
 };
 
 struct hbg_irq_info {
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 01ad82d2f5cc..d963913def81 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -122,6 +122,8 @@ static int hbg_dbg_nic_state(struct seq_file *s, void *unused)
 	np_link_fail = !hbg_reg_read_field(priv, HBG_REG_AN_NEG_STATE_ADDR,
 					   HBG_REG_AN_NEG_STATE_NP_LINK_OK_B);
 	seq_printf(s, "np_link fail state: %s\n", str_true_false(np_link_fail));
+	seq_printf(s, "page_pool enabled: %s\n",
+		   str_true_false(priv->dev_specs.page_pool_enabled));
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 068da2fd1fea..9d8b80db9f8b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -19,6 +19,10 @@
 #define HBG_SUPPORT_FEATURES (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
 			     NETIF_F_RXCSUM)
 
+static bool page_pool_enabled = true;
+module_param(page_pool_enabled, bool, 0400);
+MODULE_PARM_DESC(page_pool_enabled, "set page_pool enabled, default is true");
+
 static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
 {
 	const struct hbg_irq_info *info;
@@ -367,6 +371,9 @@ static int hbg_init(struct hbg_priv *priv)
 {
 	int ret;
 
+	if (IS_ENABLED(CONFIG_PAGE_POOL))
+		priv->dev_specs.page_pool_enabled = page_pool_enabled;
+
 	ret = hbg_hw_event_notify(priv, HBG_HW_EVENT_INIT);
 	if (ret)
 		return ret;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index ea691d564161..b71f277419fa 100644
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
 
@@ -136,6 +141,7 @@ static void hbg_buffer_free_skb(struct hbg_buffer *buffer)
 
 	dev_kfree_skb_any(buffer->skb);
 	buffer->skb = NULL;
+	buffer->skb_data_addr = NULL;
 }
 
 static int hbg_buffer_alloc_skb(struct hbg_buffer *buffer)
@@ -148,7 +154,44 @@ static int hbg_buffer_alloc_skb(struct hbg_buffer *buffer)
 		return -ENOMEM;
 
 	buffer->skb_len = len;
-	memset(buffer->skb->data, 0, HBG_PACKET_HEAD_SIZE);
+	buffer->skb_data_addr = buffer->skb->data;
+	return 0;
+}
+
+static void hbg_buffer_free_page(struct hbg_buffer *buffer)
+{
+	struct hbg_ring *ring = buffer->ring;
+
+	if (unlikely(!ring->page_pool || !buffer->page))
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
 	return 0;
 }
 
@@ -371,6 +414,36 @@ static bool hbg_rx_pkt_check(struct hbg_priv *priv, struct hbg_rx_desc *desc,
 	return true;
 }
 
+static int hbg_alloc_mapping_buffer(struct hbg_buffer *buffer)
+{
+	struct hbg_ring *ring = buffer->ring;
+	int ret;
+
+	if (ring->page_pool)
+		return hbg_buffer_alloc_page(buffer);
+
+	ret = hbg_buffer_alloc_skb(buffer);
+	if (unlikely(ret))
+		return ret;
+
+	ret = hbg_dma_map(buffer);
+	if (unlikely(ret))
+		hbg_buffer_free_skb(buffer);
+
+	return ret;
+}
+
+static void hbg_free_mapping_buffer(struct hbg_buffer *buffer)
+{
+	struct hbg_ring *ring = buffer->ring;
+
+	if (ring->page_pool)
+		return hbg_buffer_free_page(buffer);
+
+	hbg_dma_unmap(buffer);
+	hbg_buffer_free_skb(buffer);
+}
+
 static int hbg_rx_fill_one_buffer(struct hbg_priv *priv)
 {
 	struct hbg_ring *ring = &priv->rx_ring;
@@ -382,17 +455,15 @@ static int hbg_rx_fill_one_buffer(struct hbg_priv *priv)
 		return 0;
 
 	buffer = &ring->queue[ring->ntu];
-	ret = hbg_buffer_alloc_skb(buffer);
+	ret = hbg_alloc_mapping_buffer(buffer);
 	if (unlikely(ret))
 		return ret;
 
-	ret = hbg_dma_map(buffer);
-	if (unlikely(ret)) {
-		hbg_buffer_free_skb(buffer);
-		return ret;
-	}
+	memset(buffer->pkt_addr, 0, HBG_PACKET_HEAD_SIZE);
+	dma_sync_single_for_device(&priv->pdev->dev, buffer->pkt_dma,
+				   HBG_PACKET_HEAD_SIZE, DMA_TO_DEVICE);
 
-	hbg_hw_fill_buffer(priv, buffer->skb_dma);
+	hbg_hw_fill_buffer(priv, buffer->pkt_dma);
 	hbg_queue_move_next(ntu, ring);
 	return 0;
 }
@@ -425,13 +496,29 @@ static bool hbg_sync_data_from_hw(struct hbg_priv *priv,
 	/* make sure HW write desc complete */
 	dma_rmb();
 
-	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->skb_dma,
-				buffer->skb_len, DMA_FROM_DEVICE);
+	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->pkt_dma,
+				buffer->pkt_len, DMA_FROM_DEVICE);
 
-	rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
+	rx_desc = (struct hbg_rx_desc *)buffer->pkt_addr;
 	return FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2) != 0;
 }
 
+static int hbg_build_skb(struct hbg_buffer *buffer)
+{
+	if (!buffer->ring->page_pool) {
+		hbg_dma_unmap(buffer);
+		return 0;
+	}
+
+	net_prefetch(buffer->page_addr);
+	buffer->skb = napi_build_skb(buffer->page_addr, buffer->page_size);
+	if (unlikely(!buffer->skb))
+		return -ENOMEM;
+
+	skb_mark_for_recycle(buffer->skb);
+	return 0;
+}
+
 static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 {
 	struct hbg_ring *ring = container_of(napi, struct hbg_ring, napi);
@@ -447,21 +534,25 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 			break;
 
 		buffer = &ring->queue[ring->ntc];
-		if (unlikely(!buffer->skb))
+		if (unlikely(!buffer->pkt_addr))
 			goto next_buffer;
 
 		if (unlikely(!hbg_sync_data_from_hw(priv, buffer)))
 			break;
-		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
+		rx_desc = (struct hbg_rx_desc *)buffer->pkt_addr;
 		pkt_len = FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2);
 		trace_hbg_rx_desc(priv, ring->ntc, rx_desc);
 
+		if (unlikely(hbg_build_skb(buffer))) {
+			hbg_free_mapping_buffer(buffer);
+			goto next_buffer;
+		}
+
 		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc, buffer->skb))) {
-			hbg_buffer_free(buffer);
+			hbg_free_mapping_buffer(buffer);
 			goto next_buffer;
 		}
 
-		hbg_dma_unmap(buffer);
 		skb_reserve(buffer->skb, HBG_PACKET_HEAD_SIZE + NET_IP_ALIGN);
 		skb_put(buffer->skb, pkt_len);
 		buffer->skb->protocol = eth_type_trans(buffer->skb,
@@ -470,6 +561,8 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 		dev_sw_netstats_rx_add(priv->netdev, pkt_len);
 		napi_gro_receive(napi, buffer->skb);
 		buffer->skb = NULL;
+		buffer->page = NULL;
+		buffer->pkt_addr = NULL;
 
 next_buffer:
 		hbg_rx_fill_one_buffer(priv);
@@ -484,6 +577,15 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
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
 static void hbg_ring_uninit(struct hbg_ring *ring)
 {
 	struct hbg_buffer *buffer;
@@ -497,11 +599,12 @@ static void hbg_ring_uninit(struct hbg_ring *ring)
 
 	for (i = 0; i < ring->len; i++) {
 		buffer = &ring->queue[i];
-		hbg_buffer_free(buffer);
+		hbg_free_mapping_buffer(buffer);
 		buffer->ring = NULL;
 		buffer->priv = NULL;
 	}
 
+	hbg_ring_page_pool_destory(ring);
 	dma_free_coherent(&ring->priv->pdev->dev,
 			  ring->len * sizeof(*ring->queue),
 			  ring->queue, ring->queue_dma);
@@ -511,6 +614,33 @@ static void hbg_ring_uninit(struct hbg_ring *ring)
 	ring->priv = NULL;
 }
 
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
 static int hbg_ring_init(struct hbg_priv *priv, struct hbg_ring *ring,
 			 int (*napi_poll)(struct napi_struct *, int),
 			 enum hbg_dir dir)
@@ -582,6 +712,14 @@ static int hbg_rx_ring_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
+	if (priv->dev_specs.page_pool_enabled) {
+		ret = hbg_ring_page_pool_init(priv, &priv->rx_ring);
+		if (ret) {
+			hbg_ring_uninit(&priv->rx_ring);
+			return ret;
+		}
+	}
+
 	ret = hbg_rx_fill_buffers(priv);
 	if (ret)
 		hbg_ring_uninit(&priv->rx_ring);
-- 
2.33.0


