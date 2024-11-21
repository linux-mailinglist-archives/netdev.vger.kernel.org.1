Return-Path: <netdev+bounces-146566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C09D4596
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 02:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD631F22336
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 01:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C6A1474D3;
	Thu, 21 Nov 2024 01:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641DB5FEE6;
	Thu, 21 Nov 2024 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732154005; cv=none; b=BEUyN0RUtwGug7LCTLB7Rv3VauDiPRxNcznvz/2jN0IGPVjqF5Iof36Ba/djfrCoEtB3rdQUcY/wDZdUK49wY2fzFWu0ct7YL5eXjVkNoR+zp45l6BVB+QJIaL+ABJ1gtNdzU3dQa7vdmTaqUPrzFP5p1jGONf/1PdpQ/COnKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732154005; c=relaxed/simple;
	bh=BQJu5XWAr6DCiC2zlg9+quQA/DuqFl3VvXEZSV8QuKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I7tRZcWAxPhdHdvVQfu1TMbHysw+0bISWkHtPsZBF1CfF7FHqKiKd/x6vMsuQ+2Cv47wKLoZSGS4zLLgngqrxq1SjcOy5GKt/Wn4AG0mDzpEqfdWmBEXL9M7fMTeP8/FJ5hX6meA9E1CPQrwEoJcyK+TGVLaYdSsTDBKPTn7F5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppXl_1732100201 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:42 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 06/21] motorcomm:yt6801: Implement the poll functions
Date: Thu, 21 Nov 2024 09:53:12 +0800
Message-Id: <20241120105625.22508-7-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the fxgmac_request_irqs to request legacy or msix irqs, msix irqs
include a PHY_OTHER irq.
Implement the fxgmac_create_skb to  create skb for rx.
Implement the fxgmac_misc_isr and fxgmac_misc_poll function to clear misc
interrupts(MSI_ID_PHY_OTHER) status.
Implement the fxgmac_isr function to handle legacy irq.
Implement the fxgmac_dma_isr function to handle tx and rx irq.
Implement the fxgmac_all_poll for legacy irq.
Implement the fxgmac_one_poll_rx and fxgmac_one_poll_tx for msix irq.
Implement the fxgmac_tx_poll and fxgmac_rx_poll to handle tx and rx.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   | 183 +++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 650 ++++++++++++++++++
 2 files changed, 833 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
index 2edf53d9b..4010e9412 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
@@ -320,3 +320,186 @@ int fxgmac_channels_rings_alloc(struct fxgmac_pdata *pdata)
 	fxgmac_channels_rings_free(pdata);
 	return ret;
 }
+
+static void fxgmac_set_buffer_data(struct fxgmac_buffer_data *bd,
+				   struct fxgmac_page_alloc *pa,
+				   unsigned int len)
+{
+	get_page(pa->pages);
+	bd->pa = *pa;
+
+	bd->dma_base = pa->pages_dma;
+	bd->dma_off = pa->pages_offset;
+	bd->dma_len = len;
+
+	pa->pages_offset += len;
+	if ((pa->pages_offset + len) > pa->pages_len) {
+		/* This data descriptor is responsible for unmapping page(s) */
+		bd->pa_unmap = *pa;
+
+		/* Get a new allocation next time */
+		pa->pages = NULL;
+		pa->pages_len = 0;
+		pa->pages_offset = 0;
+		pa->pages_dma = 0;
+	}
+}
+
+static int fxgmac_alloc_pages(struct fxgmac_pdata *pdata,
+			      struct fxgmac_page_alloc *pa, gfp_t gfp,
+			      int order)
+{
+	struct page *pages = NULL;
+	dma_addr_t pages_dma;
+
+	/* Try to obtain pages, decreasing order if necessary */
+	gfp |= __GFP_COMP | __GFP_NOWARN;
+	while (order >= 0) {
+		pages = alloc_pages(gfp, order);
+		if (pages)
+			break;
+
+		order--;
+	}
+
+	if (!pages)
+		return -ENOMEM;
+
+	/* Map the pages */
+	pages_dma = dma_map_page(pdata->dev, pages, 0, PAGE_SIZE << order,
+				 DMA_FROM_DEVICE);
+	if (dma_mapping_error(pdata->dev, pages_dma)) {
+		put_page(pages);
+		return -ENOMEM;
+	}
+
+	pa->pages = pages;
+	pa->pages_len = PAGE_SIZE << order;
+	pa->pages_offset = 0;
+	pa->pages_dma = pages_dma;
+
+	return 0;
+}
+
+#define FXGMAC_SKB_ALLOC_SIZE 512
+
+int fxgmac_rx_buffe_map(struct fxgmac_pdata *pdata, struct fxgmac_ring *ring,
+			struct fxgmac_desc_data *desc_data)
+{
+	int ret;
+
+	if (!ring->rx_hdr_pa.pages) {
+		ret = fxgmac_alloc_pages(pdata, &ring->rx_hdr_pa, GFP_ATOMIC,
+					 0);
+		if (ret)
+			return ret;
+	}
+	/* Set up the header page info */
+	fxgmac_set_buffer_data(&desc_data->rx.hdr, &ring->rx_hdr_pa,
+			       pdata->rx_buf_size);
+
+	return 0;
+}
+
+void fxgmac_desc_tx_reset(struct fxgmac_desc_data *desc_data)
+{
+	struct fxgmac_dma_desc *dma_desc = desc_data->dma_desc;
+
+	/* Reset the Tx descriptor
+	 * Set buffer 1 (lo) address to zero
+	 * Set buffer 1 (hi) address to zero
+	 * Reset all other control bits (IC, TTSE, B2L & B1L)
+	 * Reset all other control bits (OWN, CTXT, FD, LD, CPC, CIC, etc)
+	 */
+	dma_desc->desc0 = 0;
+	dma_desc->desc1 = 0;
+	dma_desc->desc2 = 0;
+	dma_desc->desc3 = 0;
+
+	/* Make sure ownership is written to the descriptor */
+	dma_wmb();
+}
+
+void fxgmac_desc_rx_reset(struct fxgmac_desc_data *desc_data)
+{
+	struct fxgmac_dma_desc *dma_desc = desc_data->dma_desc;
+	dma_addr_t hdr_dma;
+
+	/* Reset the Rx descriptor
+	 * Set buffer 1 (lo) address to header dma address (lo)
+	 * Set buffer 1 (hi) address to header dma address (hi)
+	 * set control bits OWN and INTE
+	 */
+	hdr_dma = desc_data->rx.hdr.dma_base + desc_data->rx.hdr.dma_off;
+	dma_desc->desc0 = cpu_to_le32(lower_32_bits(hdr_dma));
+	dma_desc->desc1 = cpu_to_le32(upper_32_bits(hdr_dma));
+	dma_desc->desc2 = 0;
+	dma_desc->desc3 = 0;
+	fxgmac_set_bits_le(&dma_desc->desc3, RX_NORMAL_DESC3_INTE_POS,
+			   RX_NORMAL_DESC3_INTE_LEN, 1);
+	fxgmac_set_bits_le(&dma_desc->desc3, RX_NORMAL_DESC3_BUF2V_POS,
+			   RX_NORMAL_DESC3_BUF2V_LEN, 0);
+	fxgmac_set_bits_le(&dma_desc->desc3, RX_NORMAL_DESC3_BUF1V_POS,
+			   RX_NORMAL_DESC3_BUF1V_LEN, 1);
+
+	/* Since the Rx DMA engine is likely running, make sure everything
+	 * is written to the descriptor(s) before setting the OWN bit
+	 * for the descriptor
+	 */
+	dma_wmb();
+
+	fxgmac_set_bits_le(&dma_desc->desc3, RX_NORMAL_DESC3_OWN_POS,
+			   RX_NORMAL_DESC3_OWN_LEN, 1);
+
+	/* Make sure ownership is written to the descriptor */
+	dma_wmb();
+}
+
+void fxgmac_dump_rx_desc(struct fxgmac_pdata *pdata, struct fxgmac_ring *ring,
+			 unsigned int idx)
+{
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, idx);
+	dma_desc = desc_data->dma_desc;
+	yt_dbg(pdata,
+	       "RX: dma_desc=%p, dma_desc_addr=%pad, RX_NORMAL_DESC[%d RX BY DEVICE] = %08x:%08x:%08x:%08x\n\n",
+	       dma_desc, &desc_data->dma_desc_addr, idx,
+	       le32_to_cpu(dma_desc->desc0), le32_to_cpu(dma_desc->desc1),
+	       le32_to_cpu(dma_desc->desc2), le32_to_cpu(dma_desc->desc3));
+}
+
+void fxgmac_dump_tx_desc(struct fxgmac_pdata *pdata, struct fxgmac_ring *ring,
+			 unsigned int idx, unsigned int count,
+			 unsigned int flag)
+{
+	struct fxgmac_desc_data *desc_data;
+
+	while (count--) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, idx);
+		yt_dbg(pdata,
+		       "TX: dma_desc=%p, dma_desc_addr=%pad, TX_NORMAL_DESC[%d %s] = %08x:%08x:%08x:%08x\n",
+		       desc_data->dma_desc, &desc_data->dma_desc_addr, idx,
+		       (flag == 1) ? "QUEUED FOR TX" : "TX BY DEVICE",
+		       le32_to_cpu(desc_data->dma_desc->desc0),
+		       le32_to_cpu(desc_data->dma_desc->desc1),
+		       le32_to_cpu(desc_data->dma_desc->desc2),
+		       le32_to_cpu(desc_data->dma_desc->desc3));
+
+		idx++;
+	}
+}
+
+int fxgmac_is_tx_complete(struct fxgmac_dma_desc *dma_desc)
+{
+	return !FXGMAC_GET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3_OWN_POS,
+				   TX_NORMAL_DESC3_OWN_LEN);
+}
+
+int fxgmac_is_last_desc(struct fxgmac_dma_desc *dma_desc)
+{
+	/* Rx and Tx share LD bit, so check TDES3.LD bit */
+	return FXGMAC_GET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3_LD_POS,
+				  TX_NORMAL_DESC3_LD_LEN);
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index eedf4dcb0..2033267d9 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -13,6 +13,30 @@
 
 static void fxgmac_napi_enable(struct fxgmac_pdata *pdata);
 
+static unsigned int fxgmac_desc_tx_avail(struct fxgmac_ring *ring)
+{
+	unsigned int avail;
+
+	if (ring->dirty > ring->cur)
+		avail = ring->dirty - ring->cur;
+	else
+		avail = ring->dma_desc_count - ring->cur + ring->dirty;
+
+	return avail;
+}
+
+static unsigned int fxgmac_desc_rx_dirty(struct fxgmac_ring *ring)
+{
+	unsigned int dirty;
+
+	if (ring->dirty <= ring->cur)
+		dirty = ring->cur - ring->dirty;
+	else
+		dirty = ring->dma_desc_count - ring->dirty + ring->cur;
+
+	return dirty;
+}
+
 static int fxgmac_calc_rx_buf_size(struct fxgmac_pdata *pdata, unsigned int mtu)
 {
 	u32 rx_buf_size, max_mtu;
@@ -53,6 +77,119 @@ static void fxgmac_enable_rx_tx_ints(struct fxgmac_pdata *pdata)
 	}
 }
 
+static int fxgmac_misc_poll(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_pdata *pdata =
+		container_of(napi, struct fxgmac_pdata, napi_misc);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	if (napi_complete_done(napi, 0))
+		hw_ops->enable_msix_one_irq(pdata, MSI_ID_PHY_OTHER);
+
+	return 0;
+}
+
+static irqreturn_t fxgmac_misc_isr(int irq, void *data)
+{
+	struct fxgmac_pdata *pdata = data;
+	struct fxgmac_hw_ops *hw_ops;
+	u32 val;
+
+	val = rd32_mem(pdata, MGMT_INT_CTRL0);
+	if (!(val & MGMT_INT_CTRL0_INT_STATUS_MISC))
+		return IRQ_HANDLED;
+
+	hw_ops = &pdata->hw_ops;
+	hw_ops->disable_msix_one_irq(pdata, MSI_ID_PHY_OTHER);
+	hw_ops->clear_misc_int_status(pdata);
+
+	napi_schedule_irqoff(&pdata->napi_misc);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fxgmac_isr(int irq, void *data)
+{
+	struct fxgmac_pdata *pdata = data;
+	u32 val, mgm_intctrl_val, isr;
+	struct fxgmac_hw_ops *hw_ops;
+
+	val = rd32_mem(pdata, MGMT_INT_CTRL0);
+	if (!(val &
+	      (MGMT_INT_CTRL0_INT_STATUS_RX | MGMT_INT_CTRL0_INT_STATUS_TX |
+	       MGMT_INT_CTRL0_INT_STATUS_MISC)))
+		return IRQ_HANDLED;
+
+	hw_ops = &pdata->hw_ops;
+	hw_ops->disable_mgm_irq(pdata);
+	mgm_intctrl_val = val;
+	pdata->stats.mgmt_int_isr++;
+
+	/* Handle dma channel isr */
+	for (u32 i = 0; i < pdata->channel_count; i++) {
+		isr = rd32_mac(pdata, FXGMAC_DMA_REG(pdata->channel_head + i, DMA_CH_SR));
+
+		if (isr & BIT(DMA_CH_SR_TPS_POS))
+			pdata->stats.tx_process_stopped++;
+
+		if (isr & BIT(DMA_CH_SR_RPS_POS))
+			pdata->stats.rx_process_stopped++;
+
+		if (isr & BIT(DMA_CH_SR_TBU_POS))
+			pdata->stats.tx_buffer_unavailable++;
+
+		if (isr & BIT(DMA_CH_SR_RBU_POS))
+			pdata->stats.rx_buffer_unavailable++;
+
+		/* Restart the device on a Fatal Bus Error */
+		if (isr & BIT(DMA_CH_SR_FBE_POS)) {
+			pdata->stats.fatal_bus_error++;
+			schedule_work(&pdata->restart_work);
+		}
+
+		/* Clear all interrupt signals */
+		wr32_mac(pdata, isr, FXGMAC_DMA_REG(pdata->channel_head + i, DMA_CH_SR));
+	}
+
+	if (mgm_intctrl_val & MGMT_INT_CTRL0_INT_STATUS_MISC)
+		hw_ops->clear_misc_int_status(pdata);
+
+	if (napi_schedule_prep(&pdata->napi)) {
+		pdata->stats.napi_poll_isr++;
+		__napi_schedule_irqoff(&pdata->napi); /* Turn on polling */
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fxgmac_dma_isr(int irq, void *data)
+{
+	struct fxgmac_channel *channel = data;
+	struct fxgmac_hw_ops *hw_ops;
+	struct fxgmac_pdata *pdata;
+	u32 message_id, val = 0;
+
+	pdata = channel->pdata;
+	hw_ops = &pdata->hw_ops;
+
+	if (irq == channel->dma_irq_tx) {
+		message_id = MSI_ID_TXQ0;
+		hw_ops->disable_msix_one_irq(pdata, message_id);
+		fxgmac_set_bits(&val, DMA_CH_SR_TI_POS, DMA_CH_SR_TI_LEN, 1);
+		wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+		napi_schedule_irqoff(&channel->napi_tx);
+		return IRQ_HANDLED;
+	}
+
+	message_id = channel->queue_index;
+	hw_ops->disable_msix_one_irq(pdata, message_id);
+	val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+	fxgmac_set_bits(&val, DMA_CH_SR_RI_POS, DMA_CH_SR_RI_LEN, 1);
+	wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+	napi_schedule_irqoff(&channel->napi_rx);
+	return IRQ_HANDLED;
+}
+
 #define FXGMAC_NAPI_ENABLE			0x1
 #define FXGMAC_NAPI_DISABLE			0x0
 static void fxgmac_napi_disable(struct fxgmac_pdata *pdata)
@@ -112,6 +249,148 @@ static void fxgmac_napi_disable(struct fxgmac_pdata *pdata)
 	}
 }
 
+#define FXGMAC_IRQ_ENABLE			0x1
+#define FXGMAC_IRQ_DISABLE			0x0
+static int fxgmac_request_irqs(struct fxgmac_pdata *pdata)
+{
+	struct net_device *netdev = pdata->netdev;
+	u32 *flags = &pdata->int_flags;
+	struct fxgmac_channel *channel;
+	u32 misc, tx, rx, need_free;
+	u32 i, msix, msi;
+	int ret;
+
+	msi = FIELD_GET(FXGMAC_FLAG_MSI_ENABLED, *flags);
+	msix = FIELD_GET(FXGMAC_FLAG_MSIX_ENABLED, *flags);
+	need_free = FIELD_GET(BIT(FXGMAC_FLAG_LEGACY_IRQ_POS), *flags);
+
+	if (!msix && !need_free) {
+		ret = devm_request_irq(pdata->dev, pdata->dev_irq, fxgmac_isr,
+				       msi ? 0 : IRQF_SHARED, netdev->name,
+				       pdata);
+		if (ret) {
+			yt_err(pdata, "error requesting irq %d, ret = %d\n",
+			       pdata->dev_irq, ret);
+			return ret;
+		}
+
+		fxgmac_set_bits(flags, FXGMAC_FLAG_LEGACY_IRQ_POS,
+				FXGMAC_FLAG_LEGACY_IRQ_LEN, FXGMAC_IRQ_ENABLE);
+	}
+
+	if (!pdata->per_channel_irq)
+		return 0;
+
+	channel = pdata->channel_head;
+
+	tx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_TX_IRQ_POS,
+			     FXGMAC_FLAG_TX_IRQ_LEN);
+	rx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_RX_IRQ_POS,
+			     FXGMAC_FLAG_RX_IRQ_LEN);
+	misc = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_MISC_IRQ_POS,
+			       FXGMAC_FLAG_MISC_IRQ_LEN);
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		snprintf(channel->dma_irq_rx_name,
+			 sizeof(channel->dma_irq_rx_name) - 1, "%s-ch%d-Rx-%u",
+			 netdev_name(netdev), i, channel->queue_index);
+
+		if (FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i) && !tx) {
+			snprintf(channel->dma_irq_tx_name,
+				 sizeof(channel->dma_irq_tx_name) - 1,
+				 "%s-ch%d-Tx-%u", netdev_name(netdev), i,
+				 channel->queue_index);
+			ret = devm_request_irq(pdata->dev, channel->dma_irq_tx,
+					       fxgmac_dma_isr, 0,
+					       channel->dma_irq_tx_name,
+					       channel);
+			if (ret) {
+				yt_err(pdata,
+				       "%s, err with MSIx irq, request for ch %d tx, ret=%d\n",
+				       __func__, i, ret);
+				goto err_irq;
+			}
+
+			fxgmac_set_bits(flags, FXGMAC_FLAG_TX_IRQ_POS,
+					FXGMAC_FLAG_TX_IRQ_LEN,
+					FXGMAC_IRQ_ENABLE);
+
+			if (netif_msg_drv(pdata)) {
+				yt_dbg(pdata,
+				       "%s, MSIx irq_tx request ok, ch=%d, irq=%d,%s\n",
+				       __func__, i, channel->dma_irq_tx,
+				       channel->dma_irq_tx_name);
+			}
+		}
+
+		if (!FXGMAC_GET_BITS(rx, i, FXGMAC_FLAG_PER_RX_IRQ_LEN)) {
+			ret = devm_request_irq(pdata->dev, channel->dma_irq_rx,
+					       fxgmac_dma_isr, 0,
+					       channel->dma_irq_rx_name,
+					       channel);
+			if (ret) {
+				yt_err(pdata, "error requesting irq %d\n",
+				       channel->dma_irq_rx);
+				goto err_irq;
+			}
+			fxgmac_set_bits(flags, FXGMAC_FLAG_RX_IRQ_POS + i,
+					FXGMAC_FLAG_PER_RX_IRQ_LEN,
+					FXGMAC_IRQ_ENABLE);
+		}
+	}
+
+	if (!misc) {
+		snprintf(pdata->misc_irq_name, sizeof(pdata->misc_irq_name) - 1,
+			 "%s-misc", netdev_name(netdev));
+		ret = devm_request_irq(pdata->dev, pdata->misc_irq,
+				       fxgmac_misc_isr, 0, pdata->misc_irq_name,
+				       pdata);
+		if (ret) {
+			yt_err(pdata,
+			       "error requesting misc irq %d, ret = %d\n",
+			       pdata->misc_irq, ret);
+			goto err_irq;
+		}
+		fxgmac_set_bits(flags, FXGMAC_FLAG_MISC_IRQ_POS,
+				FXGMAC_FLAG_MISC_IRQ_LEN, FXGMAC_IRQ_ENABLE);
+	}
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s, MSIx irq request ok, total=%d,%d~%d\n",
+		       __func__, i, (pdata->channel_head)[0].dma_irq_rx,
+		       (pdata->channel_head)[i - 1].dma_irq_rx);
+
+	return 0;
+
+err_irq:
+	yt_err(pdata, "%s, err with MSIx irq request at %d,ret=%d\n", __func__,
+	       i, ret);
+
+	for (i--, channel--; i < pdata->channel_count; i--, channel--) {
+		if (FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i) && tx) {
+			fxgmac_set_bits(flags, FXGMAC_FLAG_TX_IRQ_POS,
+					FXGMAC_FLAG_TX_IRQ_LEN,
+					FXGMAC_IRQ_DISABLE);
+			devm_free_irq(pdata->dev, channel->dma_irq_tx, channel);
+		}
+
+		if (FXGMAC_GET_BITS(rx, i, FXGMAC_FLAG_PER_RX_IRQ_LEN)) {
+			fxgmac_set_bits(flags, FXGMAC_FLAG_RX_IRQ_POS + i,
+					FXGMAC_FLAG_PER_RX_IRQ_LEN,
+					FXGMAC_IRQ_DISABLE);
+
+			devm_free_irq(pdata->dev, channel->dma_irq_rx, channel);
+		}
+	}
+
+	if (misc) {
+		fxgmac_set_bits(flags, FXGMAC_FLAG_MISC_IRQ_POS,
+				FXGMAC_FLAG_MISC_IRQ_LEN, FXGMAC_IRQ_DISABLE);
+		devm_free_irq(pdata->dev, pdata->misc_irq, pdata);
+	}
+
+	return ret;
+}
+
 static void fxgmac_free_irqs(struct fxgmac_pdata *pdata)
 {
 	u32 i, need_free, misc, tx, rx, msix;
@@ -709,6 +988,29 @@ int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res)
 	return ret;
 }
 
+void fxgmac_dbg_pkt(struct fxgmac_pdata *pdata, struct sk_buff *skb, bool tx_rx)
+{
+	struct ethhdr *eth = (struct ethhdr *)skb->data;
+	unsigned char buffer[128];
+
+	yt_dbg(pdata, "\n************** SKB dump ****************\n");
+	yt_dbg(pdata, "%s, packet of %d bytes\n", (tx_rx ? "TX" : "RX"),
+	       skb->len);
+	yt_dbg(pdata, "Dst MAC addr: %pM\n", eth->h_dest);
+	yt_dbg(pdata, "Src MAC addr: %pM\n", eth->h_source);
+	yt_dbg(pdata, "Protocol: %#06x\n", ntohs(eth->h_proto));
+
+	for (u32 i = 0; i < skb->len; i += 32) {
+		unsigned int len = min(skb->len - i, 32U);
+
+		hex_dump_to_buffer(&skb->data[i], len, 32, 1, buffer,
+				   sizeof(buffer), false);
+		yt_dbg(pdata, "  %#06x: %s\n", i, buffer);
+	}
+
+	yt_dbg(pdata, "\n************** SKB dump ****************\n");
+}
+
 static const struct net_device_ops fxgmac_netdev_ops = {
 	.ndo_open		= fxgmac_open,
 };
@@ -716,6 +1018,354 @@ static const struct net_device_ops fxgmac_netdev_ops = {
 const struct net_device_ops *fxgmac_get_netdev_ops(void)
 {
 	return &fxgmac_netdev_ops;
+}
+
+static void fxgmac_rx_refresh(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	struct fxgmac_desc_data *desc_data;
+
+	while (ring->dirty != ring->cur) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, ring->dirty);
+
+		/* Reset desc_data values */
+		fxgmac_desc_data_unmap(pdata, desc_data);
+
+		if (fxgmac_rx_buffe_map(pdata, ring, desc_data))
+			break;
+
+		fxgmac_desc_rx_reset(desc_data);
+		ring->dirty =
+			FXGMAC_GET_ENTRY(ring->dirty, ring->dma_desc_count);
+	}
+
+	/* Make sure everything is written before the register write */
+	wmb();
+
+	/* Update the Rx Tail Pointer Register with address of
+	 * the last cleaned entry
+	 */
+	desc_data =
+		FXGMAC_GET_DESC_DATA(ring,
+				     (ring->dirty - 1) &
+				     (ring->dma_desc_count - 1));
+	wr32_mac(pdata, lower_32_bits(desc_data->dma_desc_addr),
+		 FXGMAC_DMA_REG(channel, DMA_CH_RDTR_LO));
+}
+
+static struct sk_buff *fxgmac_create_skb(struct fxgmac_pdata *pdata,
+					 struct napi_struct *napi,
+					 struct fxgmac_desc_data *desc_data,
+					 unsigned int len)
+{
+	unsigned int copy_len;
+	struct sk_buff *skb;
+	u8 *packet;
+
+	skb = napi_alloc_skb(napi, desc_data->rx.hdr.dma_len);
+	if (!skb)
+		return NULL;
+
+	/* Start with the header buffer which may contain just the header
+	 * or the header plus data
+	 */
+	dma_sync_single_range_for_cpu(pdata->dev, desc_data->rx.hdr.dma_base,
+				      desc_data->rx.hdr.dma_off,
+				      desc_data->rx.hdr.dma_len,
+				      DMA_FROM_DEVICE);
+
+	packet = page_address(desc_data->rx.hdr.pa.pages) +
+		 desc_data->rx.hdr.pa.pages_offset;
+	copy_len = min(desc_data->rx.hdr.dma_len, len);
+	skb_copy_to_linear_data(skb, packet, copy_len);
+	skb_put(skb, copy_len);
+
+	return skb;
+}
+
+static int fxgmac_tx_poll(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	unsigned int cur, tx_packets = 0, tx_bytes = 0;
+	struct fxgmac_ring *ring = channel->tx_ring;
+	struct net_device *netdev = pdata->netdev;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct netdev_queue *txq;
+	int processed = 0;
+
+	/* Nothing to do if there isn't a Tx ring for this channel */
+	if (!ring) {
+		if (netif_msg_tx_done(pdata) &&
+		    channel->queue_index < FXGMAC_TX_1_Q)
+			yt_dbg(pdata, "%s, null point to ring %d\n", __func__,
+			       channel->queue_index);
+		return 0;
+	}
+	if (ring->cur != ring->dirty && (netif_msg_tx_done(pdata)))
+		yt_dbg(pdata, "%s, ring_cur=%d,ring_dirty=%d,qIdx=%d\n",
+		       __func__, ring->cur, ring->dirty, channel->queue_index);
+
+	cur = ring->cur;
+
+	/* Be sure we get ring->cur before accessing descriptor data */
+	smp_rmb();
+
+	txq = netdev_get_tx_queue(netdev, channel->queue_index);
+	while (ring->dirty != cur) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, ring->dirty);
+		dma_desc = desc_data->dma_desc;
+
+		if (!fxgmac_is_tx_complete(dma_desc))
+			break;
+
+		/* Make sure descriptor fields are read after reading
+		 * the OWN bit
+		 */
+		dma_rmb();
+
+		if (netif_msg_tx_done(pdata))
+			fxgmac_dump_tx_desc(pdata, ring, ring->dirty, 1, 0);
+
+		if (fxgmac_is_last_desc(dma_desc)) {
+			tx_packets += desc_data->tx.packets;
+			tx_bytes += desc_data->tx.bytes;
+		}
+
+		/* Free the SKB and reset the descriptor for re-use */
+		fxgmac_desc_data_unmap(pdata, desc_data);
+		fxgmac_desc_tx_reset(desc_data);
+
+		processed++;
+		ring->dirty =
+			FXGMAC_GET_ENTRY(ring->dirty, ring->dma_desc_count);
+	}
+
+	if (!processed)
+		return 0;
+
+	netdev_tx_completed_queue(txq, tx_packets, tx_bytes);
+
+	/* Make sure ownership is written to the descriptor */
+	smp_wmb();
+	if (ring->tx.queue_stopped == 1 &&
+	    (fxgmac_desc_tx_avail(ring) > FXGMAC_TX_DESC_MIN_FREE)) {
+		ring->tx.queue_stopped = 0;
+		netif_tx_wake_queue(txq);
+	}
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata, "%s, processed=%d\n", __func__, processed);
+
+	return processed;
+}
+
+static int fxgmac_one_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_channel *channel =
+		container_of(napi, struct fxgmac_channel, napi_tx);
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_hw_ops *hw_ops;
+	int ret;
+
+	hw_ops = &pdata->hw_ops;
+	ret = fxgmac_tx_poll(channel);
+	if (napi_complete_done(napi, 0))
+		hw_ops->enable_msix_one_irq(pdata, MSI_ID_TXQ0);
+
+	return ret;
+}
+
+static int fxgmac_rx_poll(struct fxgmac_channel *channel, int budget)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	struct net_device *netdev = pdata->netdev;
+	u32 context_next, context, incomplete;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_pkt_info *pkt_info;
+	struct fxgmac_hw_ops *hw_ops;
+	struct napi_struct *napi;
+	u32 len, attr, max_len;
+	int packet_count = 0;
+
+	struct sk_buff *skb;
+
+	/* Nothing to do if there isn't a Rx ring for this channel */
+	if (!ring)
+		return 0;
+
+	incomplete = 0;
+	context_next = 0;
+	napi = (pdata->per_channel_irq) ? &channel->napi_rx : &pdata->napi;
+	pkt_info = &ring->pkt_info;
+
+	hw_ops = &pdata->hw_ops;
+
+	while (packet_count < budget) {
+		memset(pkt_info, 0, sizeof(*pkt_info));
+		skb = NULL;
+		len = 0;
+
+read_again:
+		desc_data = FXGMAC_GET_DESC_DATA(ring, ring->cur);
+
+		if (fxgmac_desc_rx_dirty(ring) > FXGMAC_RX_DESC_MAX_DIRTY)
+			fxgmac_rx_refresh(channel);
+
+		if (hw_ops->dev_read(channel))
+			break;
+
+		ring->cur = FXGMAC_GET_ENTRY(ring->cur, ring->dma_desc_count);
+		attr = pkt_info->attributes;
+		incomplete = FXGMAC_GET_BITS(attr, RX_PKT_ATTR_INCOMPLETE_POS,
+					     RX_PKT_ATTR_INCOMPLETE_LEN);
+		context_next = FXGMAC_GET_BITS(attr,
+					       RX_PKT_ATTR_CONTEXT_NEXT_POS,
+					       RX_PKT_ATTR_CONTEXT_NEXT_LEN);
+		context = FXGMAC_GET_BITS(attr, RX_PKT_ATTR_CONTEXT_POS,
+					  RX_PKT_ATTR_CONTEXT_LEN);
+
+		if (incomplete || context_next)
+			goto read_again;
+
+		if (pkt_info->errors) {
+			yt_err(pdata, "error in received packet\n");
+			dev_kfree_skb(skb);
+			pdata->netdev->stats.rx_dropped++;
+			goto next_packet;
+		}
+
+		if (!context) {
+			len = desc_data->rx.len;
+			if (len == 0) {
+				if (net_ratelimit())
+					yt_err(pdata,
+					       "A packet of length 0 was received\n");
+				pdata->netdev->stats.rx_length_errors++;
+				pdata->netdev->stats.rx_dropped++;
+				goto next_packet;
+			}
+
+			if (len && !skb) {
+				skb = fxgmac_create_skb(pdata, napi, desc_data,
+							len);
+				if (unlikely(!skb)) {
+					if (net_ratelimit())
+						yt_err(pdata,
+						       "create skb err\n");
+					pdata->netdev->stats.rx_dropped++;
+					goto next_packet;
+				}
+			}
+			max_len = netdev->mtu + ETH_HLEN;
+			if (!(netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+			    skb->protocol == htons(ETH_P_8021Q))
+				max_len += VLAN_HLEN;
+
+			if (len > max_len) {
+				if (net_ratelimit())
+					yt_err(pdata,
+					       "len %d larger than max size %d\n",
+					       len, max_len);
+				pdata->netdev->stats.rx_length_errors++;
+				pdata->netdev->stats.rx_dropped++;
+				dev_kfree_skb(skb);
+				goto next_packet;
+			}
+		}
+
+		if (!skb) {
+			pdata->netdev->stats.rx_dropped++;
+			goto next_packet;
+		}
+
+		if (netif_msg_pktdata(pdata))
+			fxgmac_dbg_pkt(pdata, skb, false);
+
+		skb_checksum_none_assert(skb);
+		if (netdev->features & NETIF_F_RXCSUM)
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		if (FXGMAC_GET_BITS(attr, RX_PKT_ATTR_VLAN_CTAG_POS,
+				    RX_PKT_ATTR_VLAN_CTAG_LEN)) {
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       pkt_info->vlan_ctag);
+			pdata->stats.rx_vlan_packets++;
+		}
+
+		if (FXGMAC_GET_BITS(attr, RX_PKT_ATTR_RSS_HASH_POS,
+				    RX_PKT_ATTR_RSS_HASH_LEN))
+			skb_set_hash(skb, pkt_info->rss_hash,
+				     pkt_info->rss_hash_type);
+
+		skb->dev = netdev;
+		skb->protocol = eth_type_trans(skb, netdev);
+		skb_record_rx_queue(skb, channel->queue_index);
+
+		napi_gro_receive(napi, skb);
+
+next_packet:
+		packet_count++;
+		pdata->netdev->stats.rx_packets++;
+		pdata->netdev->stats.rx_bytes += len;
+	}
+
+	return packet_count;
+}
+
+static int fxgmac_one_poll_rx(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_channel *channel =
+		container_of(napi, struct fxgmac_channel, napi_rx);
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_hw_ops *hw_ops;
+	int processed = 0;
+
+	hw_ops = &pdata->hw_ops;
+	processed = fxgmac_rx_poll(channel, budget);
+	if (processed < budget) {
+		if (napi_complete_done(napi, processed)) {
+			hw_ops->enable_msix_one_irq(pdata,
+						    channel->queue_index);
+		}
+	}
+
+	return processed;
+}
+
+static int fxgmac_all_poll(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_pdata *pdata =
+		container_of(napi, struct fxgmac_pdata, napi);
+	struct fxgmac_channel *channel;
+	int processed;
+
+	if (netif_msg_rx_status(pdata))
+		yt_dbg(pdata, "%s, budget=%d\n", __func__, budget);
+
+	processed = 0;
+	do {
+		channel = pdata->channel_head;
+		/* Only support 1 tx channel, poll ch 0. */
+		fxgmac_tx_poll(pdata->channel_head + 0);
+		for (u32 i = 0; i < pdata->channel_count; i++, channel++)
+			processed += fxgmac_rx_poll(channel, budget);
+	} while (false);
+
+	/* If we processed everything, we are done */
+	if (processed < budget) {
+		/* Turn off polling */
+		if (napi_complete_done(napi, processed))
+			pdata->hw_ops.enable_mgm_irq(pdata);
+	}
+
+	if ((processed) && (netif_msg_rx_status(pdata)))
+		yt_dbg(pdata, "%s, received : %d\n", __func__, processed);
+
+	return processed;
+}
 
 static void fxgmac_napi_enable(struct fxgmac_pdata *pdata)
 {
-- 
2.34.1


