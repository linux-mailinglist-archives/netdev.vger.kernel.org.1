Return-Path: <netdev+bounces-105991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCCF9142B9
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 08:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6093C1C22666
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 06:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C08C22097;
	Mon, 24 Jun 2024 06:30:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479CB18EB8;
	Mon, 24 Jun 2024 06:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210618; cv=none; b=iKhYXj/bkoxe5U/YodyMZ7vECPDXx2Sk7Hd/zRALnTnkqBr5AjPqWYu71nMEfTFSUiZDbzefC7YBYyexNxOvhtBhSghFc4EU4zzxhILIS0aDauHHPk4LIfB9oiR4PDYV2TXwy+SkXwQe3JM58G0SM27xrSj3lXaLKGPxrbmgBiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210618; c=relaxed/simple;
	bh=YbO5vK3rg7ZCtm4TNN/ooa4u/NJJ9HiFg++5bHriWdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjqDIectw9q35YGvN88eNLWe+WqhuLr1vgstdsKq+Dj5snYp40vDkaRlgurkvblVjg7/LQXbvMnQ2IHF6lZNG9j5OnGnniz+C3vNJ6gvXDZelYq6q2EsBiCOunA79ZdNqrYrTwse+mZWWOgPhKNPJWi0kIZbhwOJ1fvK5SjMMg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45O6TrOmA2836058, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45O6TrOmA2836058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 14:29:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 14:29:54 +0800
Received: from RTDOMAIN (172.21.210.106) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 24 Jun
 2024 14:29:53 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v21 02/13] rtase: Implement the .ndo_open function
Date: Mon, 24 Jun 2024 14:28:10 +0800
Message-ID: <20240624062821.6840-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624062821.6840-1-justinlai0215@realtek.com>
References: <20240624062821.6840-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Implement the .ndo_open function to set default hardware settings
and initialize the descriptor ring and interrupts. Among them,
when requesting interrupt, because the first group of interrupts
needs to process more events, the overall structure and interrupt
handler will be different from other groups of interrupts, so it
needs to be handled separately. The first set of interrupt handlers
need to handle the interrupt status of RXQ0 and TXQ0, TXQ4~7,
while other groups of interrupt handlers will handle the interrupt
status of RXQ1&TXQ1 or RXQ2&TXQ2 or RXQ3&TXQ3 according to the
interrupt vector.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 418 ++++++++++++++++++
 1 file changed, 418 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 2aa472d4212a..ed296d93331f 100755
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -131,6 +131,290 @@ static u32 rtase_r32(const struct rtase_private *tp, u16 reg)
 	return readl(tp->mmio_addr + reg);
 }
 
+static void rtase_free_desc(struct rtase_private *tp)
+{
+	struct pci_dev *pdev = tp->pdev;
+	u32 i;
+
+	for (i = 0; i < tp->func_tx_queue_num; i++) {
+		if (!tp->tx_ring[i].desc)
+			continue;
+
+		dma_free_coherent(&pdev->dev, RTASE_TX_RING_DESC_SIZE,
+				  tp->tx_ring[i].desc,
+				  tp->tx_ring[i].phy_addr);
+		tp->tx_ring[i].desc = NULL;
+	}
+
+	for (i = 0; i < tp->func_rx_queue_num; i++) {
+		if (!tp->rx_ring[i].desc)
+			continue;
+
+		dma_free_coherent(&pdev->dev, RTASE_RX_RING_DESC_SIZE,
+				  tp->rx_ring[i].desc,
+				  tp->rx_ring[i].phy_addr);
+		tp->rx_ring[i].desc = NULL;
+	}
+}
+
+static int rtase_alloc_desc(struct rtase_private *tp)
+{
+	struct pci_dev *pdev = tp->pdev;
+	u32 i;
+
+	/* rx and tx descriptors needs 256 bytes alignment.
+	 * dma_alloc_coherent provides more.
+	 */
+	for (i = 0; i < tp->func_tx_queue_num; i++) {
+		tp->tx_ring[i].desc =
+				dma_alloc_coherent(&pdev->dev,
+						   RTASE_TX_RING_DESC_SIZE,
+						   &tp->tx_ring[i].phy_addr,
+						   GFP_KERNEL);
+		if (!tp->tx_ring[i].desc)
+			goto err_out;
+	}
+
+	for (i = 0; i < tp->func_rx_queue_num; i++) {
+		tp->rx_ring[i].desc =
+				dma_alloc_coherent(&pdev->dev,
+						   RTASE_RX_RING_DESC_SIZE,
+						   &tp->rx_ring[i].phy_addr,
+						   GFP_KERNEL);
+		if (!tp->rx_ring[i].desc)
+			goto err_out;
+	}
+
+	return 0;
+
+err_out:
+	rtase_free_desc(tp);
+	return -ENOMEM;
+}
+
+static void rtase_mark_to_asic(union rtase_rx_desc *desc, u32 rx_buf_sz)
+{
+	u32 eor = le32_to_cpu(desc->desc_cmd.opts1) & RTASE_RING_END;
+
+	desc->desc_status.opts2 = 0;
+	/* force memory writes to complete before releasing descriptor */
+	dma_wmb();
+	WRITE_ONCE(desc->desc_cmd.opts1,
+		   cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz));
+}
+
+static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
+{
+	struct rtase_ring *ring = &tp->tx_ring[idx];
+	struct rtase_tx_desc *desc;
+	u32 i;
+
+	memset(ring->desc, 0x0, RTASE_TX_RING_DESC_SIZE);
+	memset(ring->skbuff, 0x0, sizeof(ring->skbuff));
+	ring->cur_idx = 0;
+	ring->dirty_idx = 0;
+	ring->index = idx;
+
+	for (i = 0; i < RTASE_NUM_DESC; i++) {
+		ring->mis.len[i] = 0;
+		if ((RTASE_NUM_DESC - 1) == i) {
+			desc = ring->desc + sizeof(struct rtase_tx_desc) * i;
+			desc->opts1 = cpu_to_le32(RTASE_RING_END);
+		}
+	}
+
+	ring->ring_handler = tx_handler;
+	if (idx < 4) {
+		ring->ivec = &tp->int_vector[idx];
+		list_add_tail(&ring->ring_entry,
+			      &tp->int_vector[idx].ring_list);
+	} else {
+		ring->ivec = &tp->int_vector[0];
+		list_add_tail(&ring->ring_entry, &tp->int_vector[0].ring_list);
+	}
+}
+
+static void rtase_map_to_asic(union rtase_rx_desc *desc, dma_addr_t mapping,
+			      u32 rx_buf_sz)
+{
+	desc->desc_cmd.addr = cpu_to_le64(mapping);
+
+	rtase_mark_to_asic(desc, rx_buf_sz);
+}
+
+static void rtase_make_unusable_by_asic(union rtase_rx_desc *desc)
+{
+	desc->desc_cmd.addr = cpu_to_le64(RTK_MAGIC_NUMBER);
+	desc->desc_cmd.opts1 &= ~cpu_to_le32(RTASE_DESC_OWN | RSVD_MASK);
+}
+
+static int rtase_alloc_rx_skb(const struct rtase_ring *ring,
+			      struct sk_buff **p_sk_buff,
+			      union rtase_rx_desc *desc,
+			      dma_addr_t *rx_phy_addr, u8 in_intr)
+{
+	struct rtase_int_vector *ivec = ring->ivec;
+	const struct rtase_private *tp = ivec->tp;
+	struct sk_buff *skb = NULL;
+	dma_addr_t mapping;
+	struct page *page;
+	void *buf_addr;
+
+	page = page_pool_dev_alloc_pages(tp->page_pool);
+	if (!page) {
+		netdev_err(tp->dev, "failed to alloc page\n");
+		goto err_out;
+	}
+
+	buf_addr = page_address(page);
+	mapping = page_pool_get_dma_addr(page);
+
+	skb = build_skb(buf_addr, PAGE_SIZE);
+	if (!skb) {
+		page_pool_put_full_page(tp->page_pool, page, true);
+		netdev_err(tp->dev, "failed to build skb\n");
+		goto err_out;
+	}
+
+	*p_sk_buff = skb;
+	*rx_phy_addr = mapping;
+	rtase_map_to_asic(desc, mapping, tp->rx_buf_sz);
+
+	return 0;
+
+err_out:
+	rtase_make_unusable_by_asic(desc);
+
+	return -ENOMEM;
+}
+
+static u32 rtase_rx_ring_fill(struct rtase_ring *ring, u32 ring_start,
+			      u32 ring_end, u8 in_intr)
+{
+	union rtase_rx_desc *desc_base = ring->desc;
+	u32 cur;
+
+	for (cur = ring_start; ring_end - cur > 0; cur++) {
+		u32 i = cur % RTASE_NUM_DESC;
+		union rtase_rx_desc *desc = desc_base + i;
+		int ret;
+
+		if (ring->skbuff[i])
+			continue;
+
+		ret = rtase_alloc_rx_skb(ring, &ring->skbuff[i], desc,
+					 &ring->mis.data_phy_addr[i],
+					 in_intr);
+		if (ret)
+			break;
+	}
+
+	return cur - ring_start;
+}
+
+static void rtase_mark_as_last_descriptor(union rtase_rx_desc *desc)
+{
+	desc->desc_cmd.opts1 |= cpu_to_le32(RTASE_RING_END);
+}
+
+static void rtase_rx_ring_clear(struct rtase_ring *ring)
+{
+	union rtase_rx_desc *desc;
+	u32 i;
+
+	for (i = 0; i < RTASE_NUM_DESC; i++) {
+		desc = ring->desc + sizeof(union rtase_rx_desc) * i;
+
+		if (!ring->skbuff[i])
+			continue;
+
+		skb_mark_for_recycle(ring->skbuff[i]);
+
+		dev_kfree_skb(ring->skbuff[i]);
+
+		ring->skbuff[i] = NULL;
+
+		rtase_make_unusable_by_asic(desc);
+	}
+}
+
+static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
+{
+	struct rtase_ring *ring = &tp->rx_ring[idx];
+	u16 i;
+
+	memset(ring->desc, 0x0, RTASE_RX_RING_DESC_SIZE);
+	memset(ring->skbuff, 0x0, sizeof(ring->skbuff));
+	ring->cur_idx = 0;
+	ring->dirty_idx = 0;
+	ring->index = idx;
+
+	for (i = 0; i < RTASE_NUM_DESC; i++)
+		ring->mis.data_phy_addr[i] = 0;
+
+	ring->ring_handler = rx_handler;
+	ring->ivec = &tp->int_vector[idx];
+	list_add_tail(&ring->ring_entry, &tp->int_vector[idx].ring_list);
+}
+
+static void rtase_rx_clear(struct rtase_private *tp)
+{
+	u32 i;
+
+	for (i = 0; i < tp->func_rx_queue_num; i++)
+		rtase_rx_ring_clear(&tp->rx_ring[i]);
+
+	page_pool_destroy(tp->page_pool);
+	tp->page_pool = NULL;
+}
+
+static int rtase_init_ring(const struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	struct page_pool_params pp_params = { 0 };
+	struct page_pool *page_pool;
+	u32 num;
+	u16 i;
+
+	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp_params.order = 0;
+	pp_params.pool_size = RTASE_NUM_DESC * tp->func_rx_queue_num;
+	pp_params.nid = dev_to_node(&tp->pdev->dev);
+	pp_params.dev = &tp->pdev->dev;
+	pp_params.dma_dir = DMA_FROM_DEVICE;
+	pp_params.max_len = PAGE_SIZE;
+	pp_params.offset = 0;
+
+	page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(page_pool)) {
+		netdev_err(tp->dev, "failed to create page pool\n");
+		return -ENOMEM;
+	}
+
+	tp->page_pool = page_pool;
+
+	for (i = 0; i < tp->func_tx_queue_num; i++)
+		rtase_tx_desc_init(tp, i);
+
+	for (i = 0; i < tp->func_rx_queue_num; i++) {
+		rtase_rx_desc_init(tp, i);
+		num = rtase_rx_ring_fill(&tp->rx_ring[i], 0,
+					 RTASE_NUM_DESC, 0);
+		if (num != RTASE_NUM_DESC)
+			goto err_out;
+
+		rtase_mark_as_last_descriptor(tp->rx_ring[i].desc +
+					      sizeof(union rtase_rx_desc) *
+					      (RTASE_NUM_DESC - 1));
+	}
+
+	return 0;
+
+err_out:
+	rtase_rx_clear(tp);
+	return -ENOMEM;
+}
+
 static void rtase_tally_counter_clear(const struct rtase_private *tp)
 {
 	u32 cmd = lower_32_bits(tp->tally_paddr);
@@ -139,6 +423,130 @@ static void rtase_tally_counter_clear(const struct rtase_private *tp)
 	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_RESET);
 }
 
+static void rtase_nic_enable(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rcr = rtase_r16(tp, RTASE_RX_CONFIG_1);
+	u8 val;
+
+	rtase_w16(tp, RTASE_RX_CONFIG_1, rcr & ~RTASE_PCIE_RELOAD_EN);
+	rtase_w16(tp, RTASE_RX_CONFIG_1, rcr | RTASE_PCIE_RELOAD_EN);
+
+	val = rtase_r8(tp, RTASE_CHIP_CMD);
+	rtase_w8(tp, RTASE_CHIP_CMD, val | RTASE_TE | RTASE_RE);
+
+	val = rtase_r8(tp, RTASE_MISC);
+	rtase_w8(tp, RTASE_MISC, val & ~RTASE_RX_DV_GATE_EN);
+}
+
+static void rtase_enable_hw_interrupt(const struct rtase_private *tp)
+{
+	const struct rtase_int_vector *ivec = &tp->int_vector[0];
+	u32 i;
+
+	rtase_w32(tp, ivec->imr_addr, ivec->imr);
+
+	for (i = 1; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		rtase_w16(tp, ivec->imr_addr, ivec->imr);
+	}
+}
+
+static void rtase_hw_start(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	rtase_nic_enable(dev);
+	rtase_enable_hw_interrupt(tp);
+}
+
+static int rtase_open(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	const struct pci_dev *pdev = tp->pdev;
+	struct rtase_int_vector *ivec;
+	u16 i = 0, j;
+	int ret;
+
+	ivec = &tp->int_vector[0];
+	tp->rx_buf_sz = RTASE_RX_BUF_SIZE;
+
+	ret = rtase_alloc_desc(tp);
+	if (ret)
+		return ret;
+
+	ret = rtase_init_ring(dev);
+	if (ret)
+		goto err_free_all_allocated_mem;
+
+	rtase_hw_config(dev);
+
+	if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
+		ret = request_irq(ivec->irq, rtase_interrupt, 0,
+				  dev->name, ivec);
+		if (ret)
+			goto err_free_all_allocated_irq;
+
+		/* request other interrupts to handle multiqueue */
+		for (i = 1; i < tp->int_nums; i++) {
+			ivec = &tp->int_vector[i];
+			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
+				 tp->dev->name, i);
+			ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
+					  ivec->name, ivec);
+			if (ret)
+				goto err_free_all_allocated_irq;
+		}
+	} else {
+		ret = request_irq(pdev->irq, rtase_interrupt, 0, dev->name,
+				  ivec);
+		if (ret)
+			goto err_free_all_allocated_mem;
+	}
+
+	rtase_hw_start(dev);
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		napi_enable(&ivec->napi);
+	}
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+
+	return 0;
+
+err_free_all_allocated_irq:
+	for (j = 0; j < i; j++)
+		free_irq(tp->int_vector[j].irq, &tp->int_vector[j]);
+
+err_free_all_allocated_mem:
+	rtase_free_desc(tp);
+
+	return ret;
+}
+
+static int rtase_close(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	const struct pci_dev *pdev = tp->pdev;
+	u32 i;
+
+	rtase_down(dev);
+
+	if (tp->sw_flag & RTASE_SWF_MSIX_ENABLED) {
+		for (i = 0; i < tp->int_nums; i++)
+			free_irq(tp->int_vector[i].irq, &tp->int_vector[i]);
+
+	} else {
+		free_irq(pdev->irq, &tp->int_vector[0]);
+	}
+
+	rtase_free_desc(tp);
+
+	return 0;
+}
+
 static void rtase_enable_eem_write(const struct rtase_private *tp)
 {
 	u8 val;
@@ -171,6 +579,11 @@ static void rtase_rar_set(const struct rtase_private *tp, const u8 *addr)
 	rtase_w16(tp, RTASE_LBK_CTRL, RTASE_LBK_ATLD | RTASE_LBK_CLR);
 }
 
+static const struct net_device_ops rtase_netdev_ops = {
+	.ndo_open = rtase_open,
+	.ndo_stop = rtase_close,
+};
+
 static void rtase_get_mac_address(struct net_device *dev)
 {
 	struct rtase_private *tp = netdev_priv(dev);
@@ -191,6 +604,11 @@ static void rtase_get_mac_address(struct net_device *dev)
 	rtase_rar_set(tp, dev->dev_addr);
 }
 
+static void rtase_init_netdev_ops(struct net_device *dev)
+{
+	dev->netdev_ops = &rtase_netdev_ops;
+}
+
 static void rtase_reset_interrupt(struct pci_dev *pdev,
 				  const struct rtase_private *tp)
 {
-- 
2.34.1


