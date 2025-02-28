Return-Path: <netdev+bounces-170641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21FCA496A7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E571C174D0B
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCC225C71D;
	Fri, 28 Feb 2025 10:06:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725425BACA;
	Fri, 28 Feb 2025 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740737207; cv=none; b=ED+BqVgUMC4sg4mHUsWAB5DU4SSWEmJtiVrC9WhDFa1oUEFX2P3Rzg8ClAkEVoyt2oWZYhBfS80PFnPX8TpmFeqM3RJB9nPW1K/Pjjr3AZY15TvtiVuNC01tWekMc4ejIObweSpAQPQLEV1X0toSehQu5vqJgYMiY9H5GngUlbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740737207; c=relaxed/simple;
	bh=/Egb4jGASEIxFJ/497+mh5eGk73BWY/qxCviR/YM420=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvwXXlFU+Zm1OfqD7kjJI7ZHaMDALbFs1VeSSCCT+mfBN0vbMkTxAaw3LDyeror+Qx1NSMcjmSOzIo77Vd1ADxinedzAet2m1jccWMrw5uiTg7chK4JxxcYGW5yCU30y7pgHjnqfCqubZ98G5YJO8VOBRA48v6sb9qAbj0Gmkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn1Jl_1740736839 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:39 +0800
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
Subject: [PATCH net-next v3 10/14] motorcomm:yt6801: Implement .ndo_start_xmit function
Date: Fri, 28 Feb 2025 18:01:23 +0800
Message-Id: <20250228100020.3944-11-Frank.Sae@motor-comm.com>
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

Implement .ndo_start_xmit function to prepare preliminary packet info for
 TX, prepare tso and vlan, then map tx skb, at last it call dev_xmit
 function to send data.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 368 ++++++++++++++++++
 1 file changed, 368 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index ddfdde001..74af6bcd4 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -102,6 +102,23 @@ static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
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
+	FXGMAC_DMA_IO_WR(channel, DMA_CH_TDTR_LO,
+			 lower_32_bits(desc_data->dma_desc_addr));
+
+	ring->tx.xmit_more = 0;
+}
+
 static unsigned int fxgmac_desc_tx_avail(struct fxgmac_ring *ring)
 {
 	if (ring->dirty > ring->cur)
@@ -109,6 +126,30 @@ static unsigned int fxgmac_desc_tx_avail(struct fxgmac_ring *ring)
 	else
 		return ring->dma_desc_count - ring->cur + ring->dirty;
 }
+
+static netdev_tx_t fxgmac_maybe_stop_tx_queue(struct fxgmac_channel *channel,
+					      struct fxgmac_ring *ring,
+					      unsigned int count)
+{
+	struct fxgmac_pdata *priv = channel->priv;
+
+	if (count > fxgmac_desc_tx_avail(ring)) {
+		yt_err(priv, "Tx queue stopped, not enough descriptors available\n");
+		netif_stop_subqueue(priv->netdev, channel->queue_index);
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
 	FXGMAC_IO_WR(priv, MSIX_TBL_MASK + int_id * 16, 0);
@@ -1956,8 +1997,335 @@ static void fxgmac_dbg_pkt(struct fxgmac_pdata *priv, struct sk_buff *skb,
 	yt_dbg(priv, "\n************** SKB dump ****************\n");
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
+	csum = FXGMAC_GET_BITS(pkt_info->attr, ATTR_TX, CSUM_ENABLE);
+	tso = FXGMAC_GET_BITS(pkt_info->attr, ATTR_TX, TSO_ENABLE);
+	vlan = FXGMAC_GET_BITS(pkt_info->attr, ATTR_TX, VLAN_CTAG);
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
+		FXGMAC_SET_BITS_LE(dma_desc->desc2, TX_CONTEXT_DESC2, MSS,
+				   pkt_info->mss);
+
+		/* Mark it as a CONTEXT descriptor */
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_CONTEXT_DESC3, CTXT, 1);
+
+		/* Indicate this descriptor contains the MSS */
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_CONTEXT_DESC3, TCMSSV,
+				   1);
+
+		ring->tx.cur_mss = pkt_info->mss;
+	}
+
+	if (vlan_context) {
+		/* Mark it as a CONTEXT descriptor */
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_CONTEXT_DESC3, CTXT, 1);
+
+		/* Set the VLAN tag */
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_CONTEXT_DESC3, VT,
+				   pkt_info->vlan_ctag);
+
+		/* Indicate this descriptor contains the VLAN tag */
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_CONTEXT_DESC3, VLTV, 1);
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
+	FXGMAC_SET_BITS_LE(dma_desc->desc2, TX_NORMAL_DESC2, HL_B1L,
+			   desc_data->skb_dma_len);
+
+	/* VLAN tag insertion check */
+	if (vlan)
+		FXGMAC_SET_BITS_LE(dma_desc->desc2, TX_NORMAL_DESC2, VTIR,
+				   TX_NORMAL_DESC2_VLAN_INSERT);
+
+	/* Timestamp enablement check */
+	if (FXGMAC_GET_BITS(pkt_info->attr, ATTR_TX, PTP))
+		FXGMAC_SET_BITS_LE(dma_desc->desc2, TX_NORMAL_DESC2, TTSE, 1);
+
+	/* Mark it as First Descriptor */
+	FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, FD, 1);
+
+	/* Mark it as a NORMAL descriptor */
+	FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, CTXT, 0);
+
+	/* Set OWN bit if not the first descriptor */
+	if (cur_index != start_index)
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, OWN, 1);
+
+	if (tso) {
+		/* Enable TSO */
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, TSE, 1);
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, TCPPL,
+				   pkt_info->tcp_payload_len);
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, TCPHDRLEN,
+				   pkt_info->tcp_header_len / 4);
+	} else {
+		/* Enable CRC and Pad Insertion */
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, CPC, 0);
+
+		/* Enable HW CSUM */
+		if (csum)
+			FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3,
+					   CIC, 0x3);
+
+		/* Set the total length to be transmitted */
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, FL,
+				   pkt_info->length);
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
+		FXGMAC_SET_BITS_LE(dma_desc->desc2, TX_NORMAL_DESC2, HL_B1L,
+				   desc_data->skb_dma_len);
+
+		/* Set OWN bit */
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, OWN, 1);
+
+		/* Mark it as NORMAL descriptor */
+		FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, CTXT, 0);
+
+		/* Enable HW CSUM */
+		if (csum)
+			FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3,
+					   CIC, 0x3);
+	}
+
+	/* Set LAST bit for the last descriptor */
+	FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, LD, 1);
+
+	FXGMAC_SET_BITS_LE(dma_desc->desc2, TX_NORMAL_DESC2, IC, 1);
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
+	FXGMAC_SET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3, OWN, 1);
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
+	if (!FXGMAC_GET_BITS(pkt_info->attr, ATTR_TX, TSO_ENABLE))
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
+		FXGMAC_SET_BITS(pkt_info->attr, ATTR_TX, TSO_ENABLE, 1);
+		FXGMAC_SET_BITS(pkt_info->attr, ATTR_TX, CSUM_ENABLE, 1);
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		FXGMAC_SET_BITS(pkt_info->attr, ATTR_TX, CSUM_ENABLE, 1);
+	}
+
+	if (skb_vlan_tag_present(skb)) {
+		/* VLAN requires an extra descriptor if tag is different */
+		if (skb_vlan_tag_get(skb) != ring->tx.cur_vlan_ctag)
+			/* We can share with the TSO context descriptor */
+			if (!context_desc)
+				pkt_info->desc_count++;
+
+		FXGMAC_SET_BITS(pkt_info->attr, ATTR_TX, VLAN_CTAG, 1);
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
+static netdev_tx_t fxgmac_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct fxgmac_pdata *priv = netdev_priv(netdev);
+	struct fxgmac_pkt_info *tx_pkt_info;
+	struct fxgmac_channel *channel;
+	struct netdev_queue *txq;
+	struct fxgmac_ring *ring;
+	int ret;
+
+	channel = priv->channel_head + skb->queue_mapping;
+	txq = netdev_get_tx_queue(netdev, channel->queue_index);
+	ring = channel->tx_ring;
+	tx_pkt_info = &ring->pkt_info;
+
+	if (skb->len == 0) {
+		yt_err(priv, "empty skb received from stack\n");
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
+		yt_err(priv, "error processing TSO packet\n");
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+	fxgmac_prep_vlan(skb, tx_pkt_info);
+
+	if (!fxgmac_tx_skb_map(channel, skb)) {
+		dev_kfree_skb_any(skb);
+		yt_err(priv, "xmit, map tx skb err\n");
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


