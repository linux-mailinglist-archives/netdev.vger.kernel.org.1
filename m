Return-Path: <netdev+bounces-180145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A20C6A7FBA0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DC7116A15D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584732690F9;
	Tue,  8 Apr 2025 10:15:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132612206A2;
	Tue,  8 Apr 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107315; cv=none; b=fSKtJAgJWRLADu/r2McmK624HAMkAaDDzMyp98Ghfyy5knVxlk3spai8/127qsganiRDQsC5opZFbuuaVy+huoeJNfM9SxtuBp95aQhmltqNjbcr5k5IBiFbFhRWm+0p+Ad+CYf0MiG2pwLCqGlpYtUKXVzecgwhY6iCOOCJkrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107315; c=relaxed/simple;
	bh=JOc5cF/LE5O0N/L4ofDr9oKgMYF6k98K+qRFZh0jV88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6mYhzpZ+trn770DHmmsTdk0nQ5UOtycVlfdf0VcO+fTVazeRDSphok2TOHPvYxSxvCjJBns0WfbaK3dtmz/fXgCgflMiAnqV25GZFp4kDw5zFAxcv11gOhW6PSQp7Jno3f1DgHvSo8EE2t3ofqxNkcXKa+aQpXFkVyqtX+UulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww7TQ_1744104538 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:28:59 +0800
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
Subject: [PATCH net-next v4 10/14] yt6801: Implement .ndo_start_xmit function
Date: Tue, 08 Apr 2025 18:14:57 +0800
Message-Id: <20250408092835.3952-11-Frank.Sae@motor-comm.com>
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

Implement .ndo_start_xmit function to prepare preliminary packet info for
 TX, prepare tso and vlan, then map tx skb, at last it call dev_xmit
 function to send data.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_main.c   | 366 ++++++++++++++++++
 1 file changed, 366 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
index 50c3a1364..e1c4153cf 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
@@ -110,6 +110,23 @@ static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
 	return 0;
 }
 
+static void fxgmac_tx_start_xmit(struct fxgmac_channel *channel,
+				 struct fxgmac_ring *ring)
+{
+	struct fxgmac_desc_data *desc_data;
+
+	wmb();  /* Make sure everything is written before the register write */
+
+	/* Issue a poll command to Tx DMA by writing address
+	 * of next immediate free descriptor
+	 */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, ring->cur);
+	fxgmac_dma_io_wr(channel, DMA_CH_TDTR_LO,
+			 lower_32_bits(desc_data->dma_desc_addr));
+
+	ring->tx.xmit_more = 0;
+}
+
 static unsigned int fxgmac_desc_tx_avail(struct fxgmac_ring *ring)
 {
 	if (ring->dirty > ring->cur)
@@ -118,6 +135,29 @@ static unsigned int fxgmac_desc_tx_avail(struct fxgmac_ring *ring)
 		return ring->dma_desc_count - ring->cur + ring->dirty;
 }
 
+static netdev_tx_t fxgmac_maybe_stop_tx_queue(struct fxgmac_channel *channel,
+					      struct fxgmac_ring *ring,
+					      unsigned int count)
+{
+	struct fxgmac_pdata *priv = channel->priv;
+
+	if (count > fxgmac_desc_tx_avail(ring)) {
+		netdev_err(priv->ndev, "Tx queue stopped, not enough descriptors available\n");
+		netif_stop_subqueue(priv->ndev, channel->queue_index);
+		ring->tx.queue_stopped = 1;
+
+		/* If we haven't notified the hardware because of xmit_more
+		 * support, tell it now
+		 */
+		if (ring->tx.xmit_more)
+			fxgmac_tx_start_xmit(channel, ring);
+
+		return NETDEV_TX_BUSY;
+	}
+
+	return NETDEV_TX_OK;
+}
+
 static void fxgmac_enable_msix_one_irq(struct fxgmac_pdata *priv, u32 int_id)
 {
 	fxgmac_io_wr(priv, MSIX_TBL_MASK + int_id * 16, 0);
@@ -303,6 +343,7 @@ static int fxgmac_request_irqs(struct fxgmac_pdata *priv)
 	fxgmac_free_irqs(priv);
 	return ret;
 }
+
 static void fxgmac_free_tx_data(struct fxgmac_pdata *priv)
 {
 	struct fxgmac_channel *channel = priv->channel_head;
@@ -1954,8 +1995,333 @@ static void fxgmac_dbg_pkt(struct fxgmac_pdata *priv, struct sk_buff *skb,
 	dev_dbg(priv->dev, "\n************** SKB dump ****************\n");
 }
 
+static void fxgmac_dev_xmit(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *priv = channel->priv;
+	struct fxgmac_ring *ring = channel->tx_ring;
+	unsigned int tso_context, vlan_context;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct fxgmac_pkt_info *pkt_info;
+	unsigned int csum, tso, vlan;
+	int i, start_index = ring->cur;
+	int cur_index = ring->cur;
+
+	pkt_info = &ring->pkt_info;
+	csum =  FIELD_GET(ATTR_TX_CSUM_ENABLE, pkt_info->attr);
+	tso = FIELD_GET(ATTR_TX_TSO_ENABLE, pkt_info->attr);
+	vlan = FIELD_GET(ATTR_TX_VLAN_CTAG, pkt_info->attr);
+
+	if (tso && pkt_info->mss != ring->tx.cur_mss)
+		tso_context = 1;
+	else
+		tso_context = 0;
+
+	if (vlan && pkt_info->vlan_ctag != ring->tx.cur_vlan_ctag)
+		vlan_context = 1;
+	else
+		vlan_context = 0;
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+	dma_desc = desc_data->dma_desc;
+
+	/* Create a context descriptor if this is a TSO pkt_info */
+	if (tso_context) {
+		/* Set the MSS size */
+		fxgmac_desc_wr_bits(&dma_desc->desc2, TX_CONTEXT_DESC2_MSS,
+				    pkt_info->mss);
+
+		/* Mark it as a CONTEXT descriptor */
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_CONTEXT_DESC3_CTXT, 1);
+
+		/* Indicate this descriptor contains the MSS */
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_CONTEXT_DESC3_TCMSSV,
+				    1);
+
+		ring->tx.cur_mss = pkt_info->mss;
+	}
+
+	if (vlan_context) {
+		/* Mark it as a CONTEXT descriptor */
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_CONTEXT_DESC3_CTXT, 1);
+
+		/* Set the VLAN tag */
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_CONTEXT_DESC3_VT,
+				    pkt_info->vlan_ctag);
+
+		/* Indicate this descriptor contains the VLAN tag */
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_CONTEXT_DESC3_VLTV, 1);
+
+		ring->tx.cur_vlan_ctag = pkt_info->vlan_ctag;
+	}
+	if (tso_context || vlan_context) {
+		cur_index = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+		desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+		dma_desc = desc_data->dma_desc;
+	}
+
+	/* Update buffer address (for TSO this is the header) */
+	dma_desc->desc0 = cpu_to_le32(lower_32_bits(desc_data->skb_dma));
+	dma_desc->desc1 = cpu_to_le32(upper_32_bits(desc_data->skb_dma));
+
+	/* Update the buffer length */
+	fxgmac_desc_wr_bits(&dma_desc->desc2, TX_DESC2_HL_B1L,
+			    desc_data->skb_dma_len);
+
+	/* VLAN tag insertion check */
+	if (vlan)
+		fxgmac_desc_wr_bits(&dma_desc->desc2, TX_DESC2_VTIR, 2);
+
+	/* Timestamp enablement check */
+	if (FIELD_GET(ATTR_TX_PTP, pkt_info->attr))
+		fxgmac_desc_wr_bits(&dma_desc->desc2, TX_DESC2_TTSE, 1);
+
+	/* Mark it as First Descriptor */
+	fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_FD, 1);
+
+	/* Mark it as a NORMAL descriptor */
+	fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_CTXT, 0);
+
+	/* Set OWN bit if not the first descriptor */
+	if (cur_index != start_index)
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_OWN, 1);
+
+	if (tso) {
+		/* Enable TSO */
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_TSE, 1);
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_TCPPL,
+				    pkt_info->tcp_payload_len);
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_TCPHDRLEN,
+				    pkt_info->tcp_header_len / 4);
+	} else {
+		/* Enable CRC and Pad Insertion */
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_CPC, 0);
+
+		/* Enable HW CSUM */
+		if (csum)
+			fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_CIC,
+					    0x3);
+
+		/* Set the total length to be transmitted */
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_FL,
+				    pkt_info->length);
+	}
+
+	if (start_index <= cur_index)
+		i = cur_index - start_index + 1;
+	else
+		i = ring->dma_desc_count - start_index + cur_index;
+
+	for (; i < pkt_info->desc_count; i++) {
+		cur_index = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+		desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+		dma_desc = desc_data->dma_desc;
+
+		/* Update buffer address */
+		dma_desc->desc0 =
+			cpu_to_le32(lower_32_bits(desc_data->skb_dma));
+		dma_desc->desc1 =
+			cpu_to_le32(upper_32_bits(desc_data->skb_dma));
+
+		/* Update the buffer length */
+		fxgmac_desc_wr_bits(&dma_desc->desc2, TX_DESC2_HL_B1L,
+				    desc_data->skb_dma_len);
+
+		/* Set OWN bit */
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_OWN, 1);
+
+		/* Mark it as NORMAL descriptor */
+		fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_CTXT, 0);
+
+		/* Enable HW CSUM */
+		if (csum)
+			fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_CIC,
+					    0x3);
+	}
+
+	/* Set LAST bit for the last descriptor */
+	fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_LD, 1);
+
+	fxgmac_desc_wr_bits(&dma_desc->desc2, TX_DESC2_IC, 1);
+
+	/* Save the Tx info to report back during cleanup */
+	desc_data->tx.packets = pkt_info->tx_packets;
+	desc_data->tx.bytes = pkt_info->tx_bytes;
+
+	/* In case the Tx DMA engine is running, make sure everything
+	 * is written to the descriptor(s) before setting the OWN bit
+	 * for the first descriptor
+	 */
+	dma_wmb();
+
+	/* Set OWN bit for the first descriptor */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+	dma_desc = desc_data->dma_desc;
+	fxgmac_desc_wr_bits(&dma_desc->desc3, TX_DESC3_OWN, 1);
+
+	if (netif_msg_tx_queued(priv))
+		fxgmac_dump_tx_desc(priv, ring, start_index,
+				    pkt_info->desc_count, 1);
+
+	smp_wmb();  /* Make sure ownership is written to the descriptor */
+
+	ring->cur = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+	fxgmac_tx_start_xmit(channel, ring);
+}
+
+static void fxgmac_prep_vlan(struct sk_buff *skb,
+			     struct fxgmac_pkt_info *pkt_info)
+{
+	if (skb_vlan_tag_present(skb))
+		pkt_info->vlan_ctag = skb_vlan_tag_get(skb);
+}
+
+static int fxgmac_prep_tso(struct fxgmac_pdata *priv, struct sk_buff *skb,
+			   struct fxgmac_pkt_info *pkt_info)
+{
+	int ret;
+
+	if (!FIELD_GET(ATTR_TX_TSO_ENABLE, pkt_info->attr))
+		return 0;
+
+	ret = skb_cow_head(skb, 0);
+	if (ret)
+		return ret;
+
+	pkt_info->header_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
+	pkt_info->tcp_header_len = tcp_hdrlen(skb);
+	pkt_info->tcp_payload_len = skb->len - pkt_info->header_len;
+	pkt_info->mss = skb_shinfo(skb)->gso_size;
+
+	/* Update the number of packets that will ultimately be transmitted
+	 * along with the extra bytes for each extra packet
+	 */
+	pkt_info->tx_packets = skb_shinfo(skb)->gso_segs;
+	pkt_info->tx_bytes += (pkt_info->tx_packets - 1) * pkt_info->header_len;
+
+	return 0;
+}
+
+static int fxgmac_is_tso(struct sk_buff *skb)
+{
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
+	if (!skb_is_gso(skb))
+		return 0;
+
+	return 1;
+}
+
+static void fxgmac_prep_tx_pkt(struct fxgmac_pdata *priv,
+			       struct fxgmac_ring *ring, struct sk_buff *skb,
+			       struct fxgmac_pkt_info *pkt_info)
+{
+	u32 len, context_desc = 0;
+
+	pkt_info->skb = skb;
+	pkt_info->desc_count = 0;
+	pkt_info->tx_packets = 1;
+	pkt_info->tx_bytes = skb->len;
+
+	if (fxgmac_is_tso(skb)) {
+		/* TSO requires an extra descriptor if mss is different */
+		if (skb_shinfo(skb)->gso_size != ring->tx.cur_mss) {
+			context_desc = 1;
+			pkt_info->desc_count++;
+		}
+
+		/* TSO requires an extra descriptor for TSO header */
+		pkt_info->desc_count++;
+		pkt_info->attr |= (ATTR_TX_TSO_ENABLE | ATTR_TX_CSUM_ENABLE);
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		pkt_info->attr |= ATTR_TX_CSUM_ENABLE;
+	}
+
+	if (skb_vlan_tag_present(skb)) {
+		/* VLAN requires an extra descriptor if tag is different */
+		if (skb_vlan_tag_get(skb) != ring->tx.cur_vlan_ctag)
+			/* We can share with the TSO context descriptor */
+			if (!context_desc)
+				pkt_info->desc_count++;
+
+		pkt_info->attr |= ATTR_TX_VLAN_CTAG;
+	}
+
+	for (len = skb_headlen(skb); len;) {
+		pkt_info->desc_count++;
+		len -= min_t(unsigned int, len, FXGMAC_TX_MAX_BUF_SIZE);
+	}
+
+	for (u32 i = 0; i < skb_shinfo(skb)->nr_frags; i++)
+		for (len = skb_frag_size(&skb_shinfo(skb)->frags[i]); len;) {
+			pkt_info->desc_count++;
+			len -= min_t(unsigned int, len, FXGMAC_TX_MAX_BUF_SIZE);
+		}
+}
+
+static netdev_tx_t fxgmac_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct fxgmac_pdata *priv = netdev_priv(ndev);
+	struct fxgmac_pkt_info *tx_pkt_info;
+	struct fxgmac_channel *channel;
+	struct netdev_queue *txq;
+	struct fxgmac_ring *ring;
+	int ret;
+
+	channel = priv->channel_head + skb->queue_mapping;
+	txq = netdev_get_tx_queue(ndev, channel->queue_index);
+	ring = channel->tx_ring;
+	tx_pkt_info = &ring->pkt_info;
+
+	if (skb->len == 0) {
+		netdev_err(priv->ndev, "empty skb received from stack\n");
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* Prepare preliminary packet info for TX */
+	memset(tx_pkt_info, 0, sizeof(*tx_pkt_info));
+	fxgmac_prep_tx_pkt(priv, ring, skb, tx_pkt_info);
+
+	/* Check that there are enough descriptors available */
+	ret = fxgmac_maybe_stop_tx_queue(channel, ring,
+					 tx_pkt_info->desc_count);
+	if (ret == NETDEV_TX_BUSY)
+		return ret;
+
+	ret = fxgmac_prep_tso(priv, skb, tx_pkt_info);
+	if (ret < 0) {
+		netdev_err(priv->ndev, "processing TSO packet failed\n");
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+	fxgmac_prep_vlan(skb, tx_pkt_info);
+
+	if (!fxgmac_tx_skb_map(channel, skb)) {
+		dev_kfree_skb_any(skb);
+		netdev_err(priv->ndev, "xmit, map tx skb failed\n");
+		return NETDEV_TX_OK;
+	}
+
+	/* Report on the actual number of bytes (to be) sent */
+	netdev_tx_sent_queue(txq, tx_pkt_info->tx_bytes);
+
+	/* Configure required descriptor fields for transmission */
+	fxgmac_dev_xmit(channel);
+
+	if (netif_msg_pktdata(priv))
+		fxgmac_dbg_pkt(priv, skb, true);
+
+	/* Stop the queue in advance if there may not be enough descriptors */
+	fxgmac_maybe_stop_tx_queue(channel, ring, FXGMAC_TX_MAX_DESC_NR);
+
+	return NETDEV_TX_OK;
+}
+
 static const struct net_device_ops fxgmac_netdev_ops = {
 	.ndo_open		= fxgmac_open,
+	.ndo_start_xmit		= fxgmac_xmit,
 };
 
 const struct net_device_ops *fxgmac_get_netdev_ops(void)
-- 
2.34.1


