Return-Path: <netdev+bounces-170628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6C4A49666
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE4716C70B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC925D1ED;
	Fri, 28 Feb 2025 10:01:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-148.mail.aliyun.com (out28-148.mail.aliyun.com [115.124.28.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A5A25CC89;
	Fri, 28 Feb 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736881; cv=none; b=sqFQLB6a4LbuB7h3DXDkKWyVomoAqqmN+1mcZ76fr3+lD9Ud67Ua0c0AkYxc9eIypBdhGL8couKMJ3JhZNk0Z8g5spGRnVm0KSHomF3RTq5Qt5whxOwW9B8JV6GFtqSFOjmABoyoVPQFBv9PnI4buCLdaM5gdleikOuU2ST6Lyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736881; c=relaxed/simple;
	bh=JmZvXSoE2b1I1y2BThOc2gOxaHDUsYTR2/2DKKnP+Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HyxzBKV+AvmgQ5flnDkqZrHCDM+dTlTTzj/bQrbtrrqL1ZfxYoFUoJBmiX2zYkBffxPVSA49XhM2YD2JJYob5f+L+kQ2mQ1BFv6A/RktePCJT2cApKNhlyKExFvgrMhYezLasXbezyOwn7wE9MB1Eu3pfwpyhC+/hHQwFNYnXUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1Iw_1740736838 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:38 +0800
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
Subject: [PATCH net-next v3 09/14] motorcomm:yt6801: Implement the poll functions
Date: Fri, 28 Feb 2025 18:01:15 +0800
Message-Id: <20250228100020.3944-10-Frank.Sae@motor-comm.com>
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

Implement the fxgmac_request_irqs to request legacy or msix irqs, msix
  irqs.
Implement the fxgmac_create_skb to  create skb for rx.
Implement the fxgmac_isr function to handle legacy irq.
Implement the fxgmac_dma_isr function to handle tx and rx irq.
Implement the fxgmac_all_poll for legacy irq.
Implement the fxgmac_one_poll_rx and fxgmac_one_poll_tx for msix irq.
Implement the fxgmac_tx_poll and fxgmac_rx_poll to handle tx and rx.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   | 298 +++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 397 ++++++++++++++++++
 2 files changed, 695 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
index 74a0bec45..a4d116f33 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
@@ -271,3 +271,301 @@ int fxgmac_channels_rings_alloc(struct fxgmac_pdata *priv)
 	fxgmac_channels_rings_free(priv);
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
+static int fxgmac_alloc_pages(struct fxgmac_pdata *priv,
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
+	pages_dma = dma_map_page(priv->dev, pages, 0, PAGE_SIZE << order,
+				 DMA_FROM_DEVICE);
+	if (dma_mapping_error(priv->dev, pages_dma)) {
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
+int fxgmac_rx_buffe_map(struct fxgmac_pdata *priv, struct fxgmac_ring *ring,
+			struct fxgmac_desc_data *desc_data)
+{
+	int ret;
+
+	if (!ring->rx_hdr_pa.pages) {
+		ret = fxgmac_alloc_pages(priv, &ring->rx_hdr_pa, GFP_ATOMIC, 0);
+		if (ret)
+			return ret;
+	}
+	/* Set up the header page info */
+	fxgmac_set_buffer_data(&desc_data->rx.hdr, &ring->rx_hdr_pa,
+			       priv->rx_buf_size);
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
+	FXGMAC_SET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3, INTE, 1);
+	FXGMAC_SET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3, BUF2V, 0);
+	FXGMAC_SET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3, BUF1V, 1);
+
+	/* Since the Rx DMA engine is likely running, make sure everything
+	 * is written to the descriptor(s) before setting the OWN bit
+	 * for the descriptor
+	 */
+	dma_wmb();
+
+	FXGMAC_SET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3, OWN, 1);
+
+	/* Make sure ownership is written to the descriptor */
+	dma_wmb();
+}
+
+int fxgmac_tx_skb_map(struct fxgmac_channel *channel, struct sk_buff *skb)
+{
+	struct fxgmac_pdata *priv = channel->priv;
+	struct fxgmac_ring *ring = channel->tx_ring;
+	unsigned int start_index, cur_index;
+	struct fxgmac_desc_data *desc_data;
+	unsigned int offset, datalen, len;
+	struct fxgmac_pkt_info *pkt_info;
+	unsigned int tso, vlan;
+	dma_addr_t skb_dma;
+	skb_frag_t *frag;
+
+	offset = 0;
+	start_index = ring->cur;
+	cur_index = ring->cur;
+	pkt_info = &ring->pkt_info;
+	pkt_info->desc_count = 0;
+	pkt_info->length = 0;
+
+	tso = FXGMAC_GET_BITS(pkt_info->attr, ATTR_TX, TSO_ENABLE);
+	vlan = FXGMAC_GET_BITS(pkt_info->attr, ATTR_TX, VLAN_CTAG);
+
+	/* Save space for a context descriptor if needed */
+	if ((tso && pkt_info->mss != ring->tx.cur_mss) ||
+	    (vlan && pkt_info->vlan_ctag != ring->tx.cur_vlan_ctag))
+		cur_index = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+
+	if (tso) {
+		/* Map the TSO header */
+		skb_dma = dma_map_single(priv->dev, skb->data,
+					 pkt_info->header_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(priv->dev, skb_dma)) {
+			yt_err(priv, "dma_map_single err\n");
+			goto err_out;
+		}
+		desc_data->skb_dma = skb_dma;
+		desc_data->skb_dma_len = pkt_info->header_len;
+
+		offset = pkt_info->header_len;
+		pkt_info->length += pkt_info->header_len;
+
+		cur_index = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+		desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+	}
+
+	/* Map the (remainder of the) packet */
+	for (datalen = skb_headlen(skb) - offset; datalen;) {
+		len = min_t(unsigned int, datalen, FXGMAC_TX_MAX_BUF_SIZE);
+		skb_dma = dma_map_single(priv->dev, skb->data + offset, len,
+					 DMA_TO_DEVICE);
+		if (dma_mapping_error(priv->dev, skb_dma)) {
+			yt_err(priv, "dma_map_single err\n");
+			goto err_out;
+		}
+		desc_data->skb_dma = skb_dma;
+		desc_data->skb_dma_len = len;
+
+		datalen -= len;
+		offset += len;
+		pkt_info->length += len;
+
+		cur_index = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+		desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+	}
+
+	for (u32 i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		frag = &skb_shinfo(skb)->frags[i];
+		offset = 0;
+
+		for (datalen = skb_frag_size(frag); datalen;) {
+			len = min_t(unsigned int, datalen,
+				    FXGMAC_TX_MAX_BUF_SIZE);
+			skb_dma = skb_frag_dma_map(priv->dev, frag, offset, len,
+						   DMA_TO_DEVICE);
+			if (dma_mapping_error(priv->dev, skb_dma)) {
+				yt_err(priv, "skb_frag_dma_map err\n");
+				goto err_out;
+			}
+			desc_data->skb_dma = skb_dma;
+			desc_data->skb_dma_len = len;
+			desc_data->mapped_as_page = 1;
+
+			datalen -= len;
+			offset += len;
+			pkt_info->length += len;
+
+			cur_index = FXGMAC_GET_ENTRY(cur_index,
+						     ring->dma_desc_count);
+			desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+		}
+	}
+
+	/* Save the skb address in the last entry. We always have some data
+	 * that has been mapped so desc_data is always advanced past the last
+	 * piece of mapped data - use the entry pointed to by cur_index - 1.
+	 */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, (cur_index - 1) &
+					 (ring->dma_desc_count - 1));
+	desc_data->skb = skb;
+
+	/* Save the number of descriptor entries used */
+	if (start_index <= cur_index)
+		pkt_info->desc_count = cur_index - start_index;
+	else
+		pkt_info->desc_count =
+			ring->dma_desc_count - start_index + cur_index;
+
+	return pkt_info->desc_count;
+
+err_out:
+	while (start_index < cur_index) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+		start_index =
+			FXGMAC_GET_ENTRY(start_index, ring->dma_desc_count);
+		fxgmac_desc_data_unmap(priv, desc_data);
+	}
+
+	return 0;
+}
+
+void fxgmac_dump_rx_desc(struct fxgmac_pdata *priv, struct fxgmac_ring *ring,
+			 unsigned int idx)
+{
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, idx);
+	dma_desc = desc_data->dma_desc;
+	yt_dbg(priv,
+	       "RX: dma_desc=%p, dma_desc_addr=%pad, RX_NORMAL_DESC[%d RX BY DEVICE] = %08x:%08x:%08x:%08x\n\n",
+	       dma_desc, &desc_data->dma_desc_addr, idx,
+	       le32_to_cpu(dma_desc->desc0), le32_to_cpu(dma_desc->desc1),
+	       le32_to_cpu(dma_desc->desc2), le32_to_cpu(dma_desc->desc3));
+}
+
+void fxgmac_dump_tx_desc(struct fxgmac_pdata *priv, struct fxgmac_ring *ring,
+			 unsigned int idx, unsigned int count,
+			 unsigned int flag)
+{
+	struct fxgmac_desc_data *desc_data;
+
+	while (count--) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, idx);
+		yt_dbg(priv,
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
+	return !FXGMAC_GET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, OWN);
+}
+
+int fxgmac_is_last_desc(struct fxgmac_dma_desc *dma_desc)
+{
+	/* Rx and Tx share LD bit, so check TDES3.LD bit */
+	return FXGMAC_GET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, LD);
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index 14c59cece..ddfdde001 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -102,17 +102,69 @@ static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
 	return 0;
 }
 
+static unsigned int fxgmac_desc_tx_avail(struct fxgmac_ring *ring)
+{
+	if (ring->dirty > ring->cur)
+		return ring->dirty - ring->cur;
+	else
+		return ring->dma_desc_count - ring->cur + ring->dirty;
+}
 static void fxgmac_enable_msix_one_irq(struct fxgmac_pdata *priv, u32 int_id)
 {
 	FXGMAC_IO_WR(priv, MSIX_TBL_MASK + int_id * 16, 0);
 }
 
+static void fxgmac_disable_msix_one_irq(struct fxgmac_pdata *priv, u32 intid)
+{
+	FXGMAC_IO_WR(priv, MSIX_TBL_MASK + intid * 16, 1);
+}
+
 static void fxgmac_disable_mgm_irq(struct fxgmac_pdata *priv)
 {
 	FXGMAC_IO_WR_BITS(priv, MGMT_INT_CTRL0, INT_MASK,
 			  MGMT_INT_CTRL0_INT_MASK_MASK);
 }
 
+static irqreturn_t fxgmac_isr(int irq, void *data)
+{
+	struct fxgmac_pdata *priv = data;
+	u32 val;
+
+	val = FXGMAC_IO_RD(priv, MGMT_INT_CTRL0);
+	if (!(val & MGMT_INT_CTRL0_INT_STATUS_RXTXMISC))
+		return IRQ_NONE;
+
+	/* Restart the device on a Fatal Bus Error */
+	for (u32 i = 0; i < priv->channel_count; i++) {
+		val = FXGMAC_DMA_IO_RD(priv->channel_head + i, DMA_CH_SR);
+		if (FXGMAC_GET_BITS(val, DMA_CH_SR, FBE))
+			schedule_work(&priv->restart_work);
+	}
+
+	fxgmac_disable_mgm_irq(priv);
+	napi_schedule_irqoff(&priv->napi); /* Turn on polling */
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fxgmac_dma_isr(int irq, void *data)
+{
+	struct fxgmac_channel *channel = data;
+
+	if (irq == channel->dma_irq_tx) {
+		fxgmac_disable_msix_one_irq(channel->priv, MSI_ID_TXQ0);
+		/* Clear Tx signal */
+		FXGMAC_DMA_IO_WR(channel, DMA_CH_SR, BIT(DMA_CH_SR_TI_POS));
+		napi_schedule_irqoff(&channel->napi_tx);
+		return IRQ_HANDLED;
+	}
+
+	fxgmac_disable_msix_one_irq(channel->priv, channel->queue_index);
+	/* Clear Rx signal */
+	FXGMAC_DMA_IO_WR(channel, DMA_CH_SR, BIT(DMA_CH_SR_RI_POS));
+	napi_schedule_irqoff(&channel->napi_rx);
+	return IRQ_HANDLED;
+}
+
 static void napi_disable_del(struct fxgmac_pdata *priv, struct napi_struct *n,
 			     u32 flag_pos)
 {
@@ -1880,6 +1932,30 @@ int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res)
 	return ret;
 }
 
+static void fxgmac_dbg_pkt(struct fxgmac_pdata *priv, struct sk_buff *skb,
+			   bool tx_rx)
+{
+	struct ethhdr *eth = (struct ethhdr *)skb->data;
+	unsigned char buffer[128];
+
+	yt_dbg(priv, "\n************** SKB dump ****************\n");
+	yt_dbg(priv, "%s, packet of %d bytes\n", (tx_rx ? "TX" : "RX"),
+	       skb->len);
+	yt_dbg(priv, "Dst MAC addr: %pM\n", eth->h_dest);
+	yt_dbg(priv, "Src MAC addr: %pM\n", eth->h_source);
+	yt_dbg(priv, "Protocol: %#06x\n", ntohs(eth->h_proto));
+
+	for (u32 i = 0; i < skb->len; i += 32) {
+		unsigned int len = min(skb->len - i, 32U);
+
+		hex_dump_to_buffer(&skb->data[i], len, 32, 1, buffer,
+				   sizeof(buffer), false);
+		yt_dbg(priv, "  %#06x: %s\n", i, buffer);
+	}
+
+	yt_dbg(priv, "\n************** SKB dump ****************\n");
+}
+
 static const struct net_device_ops fxgmac_netdev_ops = {
 	.ndo_open		= fxgmac_open,
 };
@@ -1889,6 +1965,327 @@ const struct net_device_ops *fxgmac_get_netdev_ops(void)
 	return &fxgmac_netdev_ops;
 }
 
+static void fxgmac_rx_refresh(struct fxgmac_channel *channel)
+{
+	struct fxgmac_ring *ring = channel->rx_ring;
+	struct fxgmac_pdata *priv = channel->priv;
+	struct fxgmac_desc_data *desc_data;
+
+	while (ring->dirty != ring->cur) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, ring->dirty);
+
+		/* Reset desc_data values */
+		fxgmac_desc_data_unmap(priv, desc_data);
+
+		if (fxgmac_rx_buffe_map(priv, ring, desc_data))
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
+	desc_data = FXGMAC_GET_DESC_DATA(ring, (ring->dirty - 1) &
+					 (ring->dma_desc_count - 1));
+	FXGMAC_DMA_IO_WR(channel, DMA_CH_RDTR_LO,
+			 lower_32_bits(desc_data->dma_desc_addr));
+}
+
+static struct sk_buff *fxgmac_create_skb(struct fxgmac_pdata *priv,
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
+	dma_sync_single_range_for_cpu(priv->dev, desc_data->rx.hdr.dma_base,
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
+	struct fxgmac_pdata *priv = channel->priv;
+	unsigned int cur, tx_packets = 0, tx_bytes = 0;
+	struct fxgmac_ring *ring = channel->tx_ring;
+	struct net_device *netdev = priv->netdev;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct netdev_queue *txq;
+	int processed = 0;
+
+	/* Nothing to do if there isn't a Tx ring for this channel */
+	if (!ring)
+		return 0;
+
+	if (ring->cur != ring->dirty && (netif_msg_tx_done(priv)))
+		yt_dbg(priv, "%s, ring_cur=%d,ring_dirty=%d,qIdx=%d\n",
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
+		if (netif_msg_tx_done(priv))
+			fxgmac_dump_tx_desc(priv, ring, ring->dirty, 1, 0);
+
+		if (fxgmac_is_last_desc(dma_desc)) {
+			tx_packets += desc_data->tx.packets;
+			tx_bytes += desc_data->tx.bytes;
+		}
+
+		/* Free the SKB and reset the descriptor for re-use */
+		fxgmac_desc_data_unmap(priv, desc_data);
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
+	return processed;
+}
+
+static int fxgmac_one_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_channel *channel =
+		container_of(napi, struct fxgmac_channel, napi_tx);
+	struct fxgmac_pdata *priv = channel->priv;
+	int ret;
+
+	ret = fxgmac_tx_poll(channel);
+	if (napi_complete_done(napi, 0))
+		fxgmac_enable_msix_one_irq(priv, MSI_ID_TXQ0);
+
+	return ret;
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
+static int fxgmac_rx_poll(struct fxgmac_channel *channel, int budget)
+{
+	struct fxgmac_pdata *priv = channel->priv;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	struct net_device *netdev = priv->netdev;
+	u32 context_next, context, incomplete;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_pkt_info *pkt_info;
+	struct napi_struct *napi;
+	u32 len, max_len;
+	int packet_count = 0;
+
+	struct sk_buff *skb;
+
+	/* Nothing to do if there isn't a Rx ring for this channel */
+	if (!ring)
+		return 0;
+
+	napi = (priv->per_channel_irq) ? &channel->napi_rx : &priv->napi;
+	pkt_info = &ring->pkt_info;
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
+		if (fxgmac_dev_read(channel))
+			break;
+
+		ring->cur = FXGMAC_GET_ENTRY(ring->cur, ring->dma_desc_count);
+		incomplete = FXGMAC_GET_BITS(pkt_info->attr, ATTR_RX, INCOMPLETE);
+		context_next = FXGMAC_GET_BITS(pkt_info->attr, ATTR_RX, CONTEXT_NEXT);
+		context = FXGMAC_GET_BITS(pkt_info->attr, ATTR_RX, CONTEXT);
+
+		if (incomplete || context_next)
+			goto read_again;
+
+		if (pkt_info->errors) {
+			dev_kfree_skb(skb);
+			priv->netdev->stats.rx_dropped++;
+			yt_err(priv, "error in received packet\n");
+			goto next_packet;
+		}
+
+		if (!context) {
+			len = desc_data->rx.len;
+			if (len == 0) {
+				if (net_ratelimit())
+					yt_err(priv,
+					       "A packet of length 0 was received\n");
+				priv->netdev->stats.rx_length_errors++;
+				priv->netdev->stats.rx_dropped++;
+				goto next_packet;
+			}
+
+			if (len && !skb) {
+				skb = fxgmac_create_skb(priv, napi, desc_data,
+							len);
+				if (unlikely(!skb)) {
+					if (net_ratelimit())
+						yt_err(priv,
+						       "create skb err\n");
+					priv->netdev->stats.rx_dropped++;
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
+					yt_err(priv,
+					       "len %d larger than max size %d\n",
+					       len, max_len);
+				priv->netdev->stats.rx_length_errors++;
+				priv->netdev->stats.rx_dropped++;
+				dev_kfree_skb(skb);
+				goto next_packet;
+			}
+		}
+
+		if (!skb) {
+			priv->netdev->stats.rx_dropped++;
+			goto next_packet;
+		}
+
+		if (netif_msg_pktdata(priv))
+			fxgmac_dbg_pkt(priv, skb, false);
+
+		skb_checksum_none_assert(skb);
+		if (netdev->features & NETIF_F_RXCSUM)
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		if (FXGMAC_GET_BITS(pkt_info->attr, ATTR_RX, VLAN_CTAG))
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       pkt_info->vlan_ctag);
+
+		if (FXGMAC_GET_BITS(pkt_info->attr, ATTR_RX, RSS_HASH))
+			skb_set_hash(skb, pkt_info->rss_hash,
+				     pkt_info->rss_hash_type);
+
+		skb->dev = netdev;
+		skb->protocol = eth_type_trans(skb, netdev);
+		skb_record_rx_queue(skb, channel->queue_index);
+		napi_gro_receive(napi, skb);
+
+next_packet:
+		packet_count++;
+		priv->netdev->stats.rx_packets++;
+		priv->netdev->stats.rx_bytes += len;
+	}
+
+	return packet_count;
+}
+
+static int fxgmac_one_poll_rx(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_channel *channel =
+		container_of(napi, struct fxgmac_channel, napi_rx);
+	int processed = fxgmac_rx_poll(channel, budget);
+
+	if (processed < budget && (napi_complete_done(napi, processed)))
+		fxgmac_enable_msix_one_irq(channel->priv, channel->queue_index);
+
+	return processed;
+}
+
+static int fxgmac_all_poll(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_channel *channel;
+	struct fxgmac_pdata *priv;
+	int processed = 0;
+
+	priv = container_of(napi, struct fxgmac_pdata, napi);
+	do {
+		channel = priv->channel_head;
+		/* Only support 1 tx channel, poll ch 0. */
+		fxgmac_tx_poll(priv->channel_head + 0);
+		for (u32 i = 0; i < priv->channel_count; i++, channel++)
+			processed += fxgmac_rx_poll(channel, budget);
+	} while (false);
+
+	/* If we processed everything, we are done */
+	if (processed < budget) {
+		/* Turn off polling */
+		if (napi_complete_done(napi, processed))
+			fxgmac_enable_mgm_irq(priv);
+	}
+
+	if ((processed) && (netif_msg_rx_status(priv)))
+		yt_dbg(priv, "%s, received : %d\n", __func__, processed);
+
+	return processed;
+}
+
 static void napi_add_enable(struct fxgmac_pdata *priv, struct napi_struct *napi,
 			    int (*poll)(struct napi_struct *, int),
 			    u32 flag_pos)
-- 
2.34.1


