Return-Path: <netdev+bounces-146581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC8A9D4778
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 07:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83B8B225E8
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 06:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBC3482EF;
	Thu, 21 Nov 2024 06:18:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-8.us.a.mail.aliyun.com (out198-8.us.a.mail.aliyun.com [47.90.198.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F2230986;
	Thu, 21 Nov 2024 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732169907; cv=none; b=lIBS3xujg6GW41guAc7VNftmG8kwjl7VY+2yiZ93c9V8Pz+EpRGXt5LNgVCD68oqjtHPuQ6yXBwFSE5YiP48MlNU6Cqfpl8XGox0/Dl1d6ykq2awJAPaKtEms9VxeSXlPPd8XFDF9X6Xls3JrYRYJOt5H/6lH5nqEwkHLu+OpLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732169907; c=relaxed/simple;
	bh=CXCg3h4nW21IyFct/IBlnrAs8YRvDNnbS6yWqqJ/5AE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+sxXjParyrrrarSliWiJB2eiqosDQRkSAXV6G80QRFt/gckEwo7f0m1/JukevZIyBP7YzJv2cykfwxO45M7OpR+hl6fm1pM5B4cfB/bHBCSecK7bvozkWcg3e3hsxwVujtz3BXrWoQidiTVMJ/xs5yKSIMCrlDxga4kvoOpFHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppae_1732100203 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:44 +0800
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
Subject: [PATCH net-next v2 10/21] motorcomm:yt6801: Implement .ndo_start_xmit function
Date: Thu, 21 Nov 2024 14:18:02 +0800
Message-Id: <20241120105625.22508-11-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement .ndo_start_xmit function to prepare preliminary packet info for TX，
Prepare tso and vlan， then map tx skb, at last it call dev_xmit function to
send data.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   | 133 ++++++
 .../net/ethernet/motorcomm/yt6801/yt6801_hw.c | 404 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 269 ++++++++++++
 3 files changed, 806 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
index 4010e9412..e5e95ee5c 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
@@ -455,6 +455,139 @@ void fxgmac_desc_rx_reset(struct fxgmac_desc_data *desc_data)
 	dma_wmb();
 }
 
+int fxgmac_tx_skb_map(struct fxgmac_channel *channel, struct sk_buff *skb)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
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
+	tso = FXGMAC_GET_BITS(pkt_info->attributes, TX_PKT_ATTR_TSO_ENABLE_POS,
+			      TX_PKT_ATTR_TSO_ENABLE_LEN);
+	vlan = FXGMAC_GET_BITS(pkt_info->attributes, TX_PKT_ATTR_VLAN_CTAG_POS,
+			       TX_PKT_ATTR_VLAN_CTAG_LEN);
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
+		skb_dma = dma_map_single(pdata->dev, skb->data,
+					 pkt_info->header_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(pdata->dev, skb_dma)) {
+			yt_err(pdata, "dma_map_single err\n");
+			goto err_out;
+		}
+		desc_data->skb_dma = skb_dma;
+		desc_data->skb_dma_len = pkt_info->header_len;
+		yt_dbg(pdata, "skb header: index=%u, dma=%pad, len=%u\n",
+		       cur_index, &skb_dma, pkt_info->header_len);
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
+		skb_dma = dma_map_single(pdata->dev, skb->data + offset, len,
+					 DMA_TO_DEVICE);
+		if (dma_mapping_error(pdata->dev, skb_dma)) {
+			yt_err(pdata, "dma_map_single err\n");
+			goto err_out;
+		}
+		desc_data->skb_dma = skb_dma;
+		desc_data->skb_dma_len = len;
+		yt_dbg(pdata, "skb data: index=%u, dma=%pad, len=%u\n",
+		       cur_index, &skb_dma, len);
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
+		yt_dbg(pdata, "mapping frag %u\n", i);
+
+		frag = &skb_shinfo(skb)->frags[i];
+		offset = 0;
+
+		for (datalen = skb_frag_size(frag); datalen;) {
+			len = min_t(unsigned int, datalen,
+				    FXGMAC_TX_MAX_BUF_SIZE);
+			skb_dma = skb_frag_dma_map(pdata->dev, frag, offset,
+						   len, DMA_TO_DEVICE);
+			if (dma_mapping_error(pdata->dev, skb_dma)) {
+				yt_err(pdata, "skb_frag_dma_map err\n");
+				goto err_out;
+			}
+			desc_data->skb_dma = skb_dma;
+			desc_data->skb_dma_len = len;
+			desc_data->mapped_as_page = 1;
+
+			yt_dbg(pdata, "skb frag: index=%u, dma=%pad, len=%u\n",
+			       cur_index, &skb_dma, len);
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
+		fxgmac_desc_data_unmap(pdata, desc_data);
+	}
+
+	return 0;
+}
+
 void fxgmac_dump_rx_desc(struct fxgmac_pdata *pdata, struct fxgmac_ring *ring,
 			 unsigned int idx)
 {
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
index 1af26b0b4..791dd69b7 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
@@ -2156,6 +2156,408 @@ static void fxgmac_clear_misc_int_status(struct fxgmac_pdata *pdata)
 		wr32_mac(pdata, val, DMA_ECC_INT_SR);
 }
 
+static void fxgmac_dev_xmit(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->tx_ring;
+	unsigned int tso_context, vlan_context;
+	unsigned int csum, tso, vlan, attr;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct fxgmac_pkt_info *pkt_info;
+	int start_index = ring->cur;
+	int cur_index = ring->cur;
+	int i;
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata, "%s, desc cur=%d\n", __func__, cur_index);
+
+	pkt_info = &ring->pkt_info;
+	attr = pkt_info->attributes;
+	csum = FXGMAC_GET_BITS(attr, TX_PKT_ATTR_CSUM_ENABLE_POS,
+			       TX_PKT_ATTR_CSUM_ENABLE_LEN);
+	tso = FXGMAC_GET_BITS(attr, TX_PKT_ATTR_TSO_ENABLE_POS,
+			      TX_PKT_ATTR_TSO_ENABLE_LEN);
+	vlan = FXGMAC_GET_BITS(attr, TX_PKT_ATTR_VLAN_CTAG_POS,
+			       TX_PKT_ATTR_VLAN_CTAG_LEN);
+
+	if (tso && pkt_info->mss != ring->tx.cur_mss)
+		tso_context = 1;
+	else
+		tso_context = 0;
+
+	if ((tso_context) && (netif_msg_tx_done(pdata))) {
+		yt_dbg(pdata, "%s, tso_%s tso=0x%x,pkt_mss=%d,cur_mss=%d\n",
+		       __func__, (pkt_info->mss) ? "start" : "stop", tso,
+		       pkt_info->mss, ring->tx.cur_mss);
+	}
+
+	if (vlan && pkt_info->vlan_ctag != ring->tx.cur_vlan_ctag)
+		vlan_context = 1;
+	else
+		vlan_context = 0;
+
+	if (vlan && (netif_msg_tx_done(pdata)))
+		yt_dbg(pdata,
+		       "%s, pkt vlan=%d, ring vlan=%d, vlan_context=%d\n",
+		       __func__, pkt_info->vlan_ctag, ring->tx.cur_vlan_ctag,
+		       vlan_context);
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+	dma_desc = desc_data->dma_desc;
+
+	/* Create a context descriptor if this is a TSO pkt_info */
+	if (tso_context) {
+		if (netif_msg_tx_done(pdata))
+			yt_dbg(pdata, "tso context descriptor,mss=%u\n",
+			       pkt_info->mss);
+
+		/* Set the MSS size */
+		fxgmac_set_bits_le(&dma_desc->desc2, TX_CONTEXT_DESC2_MSS_POS,
+				   TX_CONTEXT_DESC2_MSS_LEN, pkt_info->mss);
+
+		/* Mark it as a CONTEXT descriptor */
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_CONTEXT_DESC3_CTXT_POS,
+				   TX_CONTEXT_DESC3_CTXT_LEN, 1);
+
+		/* Indicate this descriptor contains the MSS */
+		fxgmac_set_bits_le(&dma_desc->desc3,
+				   TX_CONTEXT_DESC3_TCMSSV_POS,
+				   TX_CONTEXT_DESC3_TCMSSV_LEN, 1);
+
+		ring->tx.cur_mss = pkt_info->mss;
+	}
+
+	if (vlan_context) {
+		yt_dbg(pdata, "VLAN context descriptor, ctag=%u\n",
+		       pkt_info->vlan_ctag);
+
+		/* Mark it as a CONTEXT descriptor */
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_CONTEXT_DESC3_CTXT_POS,
+				   TX_CONTEXT_DESC3_CTXT_LEN, 1);
+
+		/* Set the VLAN tag */
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_CONTEXT_DESC3_VT_POS,
+				   TX_CONTEXT_DESC3_VT_LEN,
+				   pkt_info->vlan_ctag);
+
+		/* Indicate this descriptor contains the VLAN tag */
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_CONTEXT_DESC3_VLTV_POS,
+				   TX_CONTEXT_DESC3_VLTV_LEN, 1);
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
+	fxgmac_set_bits_le(&dma_desc->desc2, TX_NORMAL_DESC2_HL_B1L_POS,
+			   TX_NORMAL_DESC2_HL_B1L_LEN, desc_data->skb_dma_len);
+
+	/* VLAN tag insertion check */
+	if (vlan) {
+		fxgmac_set_bits_le(&dma_desc->desc2, TX_NORMAL_DESC2_VTIR_POS,
+				   TX_NORMAL_DESC2_VTIR_LEN,
+				   TX_NORMAL_DESC2_VLAN_INSERT);
+		pdata->stats.tx_vlan_packets++;
+	}
+
+	/* Timestamp enablement check */
+	if (FXGMAC_GET_BITS(attr, TX_PKT_ATTR_PTP_POS, TX_PKT_ATTR_PTP_LEN))
+		fxgmac_set_bits_le(&dma_desc->desc2, TX_NORMAL_DESC2_TTSE_POS,
+				   TX_NORMAL_DESC2_TTSE_LEN, 1);
+
+	/* Mark it as First Descriptor */
+	fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_FD_POS,
+			   TX_NORMAL_DESC3_FD_LEN, 1);
+
+	/* Mark it as a NORMAL descriptor */
+	fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_CTXT_POS,
+			   TX_NORMAL_DESC3_CTXT_LEN, 0);
+
+	/* Set OWN bit if not the first descriptor */
+	if (cur_index != start_index)
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_OWN_POS,
+				   TX_NORMAL_DESC3_OWN_LEN, 1);
+
+	if (tso) {
+		/* Enable TSO */
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_TSE_POS,
+				   TX_NORMAL_DESC3_TSE_LEN, 1);
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_TCPPL_POS,
+				   TX_NORMAL_DESC3_TCPPL_LEN,
+				   pkt_info->tcp_payload_len);
+		fxgmac_set_bits_le(&dma_desc->desc3,
+				   TX_NORMAL_DESC3_TCPHDRLEN_POS,
+				   TX_NORMAL_DESC3_TCPHDRLEN_LEN,
+				   pkt_info->tcp_header_len / 4);
+
+		pdata->stats.tx_tso_packets++;
+	} else {
+		/* Enable CRC and Pad Insertion */
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_CPC_POS,
+				   TX_NORMAL_DESC3_CPC_LEN, 0);
+
+		/* Enable HW CSUM */
+		if (csum)
+			fxgmac_set_bits_le(&dma_desc->desc3,
+					   TX_NORMAL_DESC3_CIC_POS,
+					   TX_NORMAL_DESC3_CIC_LEN, 0x3);
+
+		/* Set the total length to be transmitted */
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_FL_POS,
+				   TX_NORMAL_DESC3_FL_LEN, pkt_info->length);
+	}
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata,
+		       "%s, before more descs, desc cur=%d, start=%d, desc=%#x,%#x,%#x,%#x\n",
+		       __func__, cur_index, start_index, dma_desc->desc0,
+		       dma_desc->desc1, dma_desc->desc2, dma_desc->desc3);
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
+		fxgmac_set_bits_le(&dma_desc->desc2, TX_NORMAL_DESC2_HL_B1L_POS,
+				   TX_NORMAL_DESC2_HL_B1L_LEN,
+				   desc_data->skb_dma_len);
+
+		/* Set OWN bit */
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_OWN_POS,
+				   TX_NORMAL_DESC3_OWN_LEN, 1);
+
+		/* Mark it as NORMAL descriptor */
+		fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_CTXT_POS,
+				   TX_NORMAL_DESC3_CTXT_LEN, 0);
+
+		/* Enable HW CSUM */
+		if (csum)
+			fxgmac_set_bits_le(&dma_desc->desc3,
+					   TX_NORMAL_DESC3_CIC_POS,
+					   TX_NORMAL_DESC3_CIC_LEN, 0x3);
+	}
+
+	/* Set LAST bit for the last descriptor */
+	fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_LD_POS,
+			   TX_NORMAL_DESC3_LD_LEN, 1);
+
+	fxgmac_set_bits_le(&dma_desc->desc2, TX_NORMAL_DESC2_IC_POS,
+			   TX_NORMAL_DESC2_IC_LEN, 1);
+
+	/* Save the Tx info to report back during cleanup */
+	desc_data->tx.packets = pkt_info->tx_packets;
+	desc_data->tx.bytes = pkt_info->tx_bytes;
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata,
+		       "%s, last descs, desc cur=%d, desc=%#x,%#x,%#x,%#x\n",
+		       __func__, cur_index, dma_desc->desc0, dma_desc->desc1,
+		       dma_desc->desc2, dma_desc->desc3);
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
+	fxgmac_set_bits_le(&dma_desc->desc3, TX_NORMAL_DESC3_OWN_POS,
+			   TX_NORMAL_DESC3_OWN_LEN, 1);
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata,
+		       "%s, first descs, start=%d, desc=%#x,%#x,%#x,%#x\n",
+		       __func__, start_index, dma_desc->desc0, dma_desc->desc1,
+		       dma_desc->desc2, dma_desc->desc3);
+
+	if (netif_msg_tx_queued(pdata))
+		fxgmac_dump_tx_desc(pdata, ring, start_index,
+				    pkt_info->desc_count, 1);
+
+	/* Make sure ownership is written to the descriptor */
+	smp_wmb();
+
+	ring->cur = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+	fxgmac_tx_start_xmit(channel, ring);
+
+	if (netif_msg_tx_done(pdata)) {
+		yt_dbg(pdata, "%s, %s: descriptors %u to %u written\n",
+		       __func__, channel->name,
+		       start_index & (ring->dma_desc_count - 1),
+		       (ring->cur - 1) & (ring->dma_desc_count - 1));
+	}
+}
+
+static void fxgmac_get_rx_tstamp(struct fxgmac_pkt_info *pkt_info,
+				 struct fxgmac_dma_desc *dma_desc)
+{
+	u64 nsec;
+
+	nsec = le32_to_cpu(dma_desc->desc1);
+	nsec <<= 32;
+	nsec |= le32_to_cpu(dma_desc->desc0);
+	if (nsec != 0xffffffffffffffffULL) {
+		pkt_info->rx_tstamp = nsec;
+		fxgmac_set_bits(&pkt_info->attributes,
+				RX_PKT_ATTR_RX_TSTAMP_POS,
+				RX_PKT_ATTR_RX_TSTAMP_LEN, 1);
+	}
+}
+
+static int fxgmac_dev_read(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	struct net_device *netdev = pdata->netdev;
+	static unsigned int cnt_incomplete;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct fxgmac_pkt_info *pkt_info;
+	u32 ipce, iphe, rxparser;
+	unsigned int err, etlt;
+	unsigned int *attr;
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, ring->cur);
+	dma_desc = desc_data->dma_desc;
+	pkt_info = &ring->pkt_info;
+	attr = &pkt_info->attributes;
+
+	/* Check for data availability */
+	if (FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_OWN_POS,
+			       RX_NORMAL_DESC3_OWN_LEN))
+		return 1;
+
+	/* Make sure descriptor fields are read after reading the OWN bit */
+	dma_rmb();
+
+	if (netif_msg_rx_status(pdata))
+		fxgmac_dump_rx_desc(pdata, ring, ring->cur);
+
+	if (FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_CTXT_POS,
+			       RX_NORMAL_DESC3_CTXT_LEN)) {
+		/* Timestamp Context Descriptor */
+		fxgmac_get_rx_tstamp(pkt_info, dma_desc);
+
+		fxgmac_set_bits(attr, RX_PKT_ATTR_CONTEXT_POS,
+				RX_PKT_ATTR_CONTEXT_LEN, 1);
+		fxgmac_set_bits(attr, RX_PKT_ATTR_CONTEXT_NEXT_POS,
+				RX_PKT_ATTR_CONTEXT_NEXT_LEN, 0);
+		if (netif_msg_rx_status(pdata))
+			yt_dbg(pdata, "%s, context desc ch=%s\n", __func__,
+			       channel->name);
+		return 0;
+	}
+
+	/* Normal Descriptor, be sure Context Descriptor bit is off */
+	fxgmac_set_bits(attr, RX_PKT_ATTR_CONTEXT_POS, RX_PKT_ATTR_CONTEXT_LEN,
+			0);
+
+	/* Indicate if a Context Descriptor is next */
+	/* Get the header length */
+	if (FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_FD_POS,
+			       RX_NORMAL_DESC3_FD_LEN)) {
+		desc_data->rx.hdr_len =
+			FXGMAC_GET_BITS_LE(dma_desc->desc2,
+					   RX_NORMAL_DESC2_HL_POS,
+					   RX_NORMAL_DESC2_HL_LEN);
+		if (desc_data->rx.hdr_len)
+			pdata->stats.rx_split_header_packets++;
+	}
+
+	/* Get the pkt_info length */
+	desc_data->rx.len = FXGMAC_GET_BITS_LE(dma_desc->desc3,
+					       RX_NORMAL_DESC3_PL_POS,
+					       RX_NORMAL_DESC3_PL_LEN);
+
+	if (!FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_LD_POS,
+				RX_NORMAL_DESC3_LD_LEN)) {
+		/* Not all the data has been transferred for this pkt_info */
+		fxgmac_set_bits(attr, RX_PKT_ATTR_INCOMPLETE_POS,
+				RX_PKT_ATTR_INCOMPLETE_LEN, 1);
+		cnt_incomplete++;
+		if (cnt_incomplete < 2 && netif_msg_rx_status(pdata))
+			yt_dbg(pdata,
+			       "%s, not last desc,pkt incomplete yet,%u\n",
+			       __func__, cnt_incomplete);
+
+		return 0;
+	}
+	if ((cnt_incomplete) && netif_msg_rx_status(pdata))
+		yt_dbg(pdata, "%s, rx back to normal and incomplete cnt=%u\n",
+		       __func__, cnt_incomplete);
+	cnt_incomplete = 0;
+
+	/* This is the last of the data for this pkt_info */
+	fxgmac_set_bits(attr, RX_PKT_ATTR_INCOMPLETE_POS,
+			RX_PKT_ATTR_INCOMPLETE_LEN, 0);
+
+	/* Set checksum done indicator as appropriate */
+	if (netdev->features & NETIF_F_RXCSUM) {
+		ipce = FXGMAC_GET_BITS_LE(dma_desc->desc1,
+					  RX_NORMAL_DESC1_WB_IPCE_POS,
+					  RX_NORMAL_DESC1_WB_IPCE_LEN);
+		iphe = FXGMAC_GET_BITS_LE(dma_desc->desc1,
+					  RX_NORMAL_DESC1_WB_IPHE_POS,
+					  RX_NORMAL_DESC1_WB_IPHE_LEN);
+		if (!ipce && !iphe)
+			fxgmac_set_bits(attr, RX_PKT_ATTR_CSUM_DONE_POS,
+					RX_PKT_ATTR_CSUM_DONE_LEN, 1);
+		else
+			return 0;
+	}
+
+	/* Check for errors (only valid in last descriptor) */
+	err = FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_ES_POS,
+				 RX_NORMAL_DESC3_ES_LEN);
+
+	/* b111: Incomplete parsing due to ECC error */
+	rxparser = FXGMAC_GET_BITS_LE(dma_desc->desc2,
+				      RX_NORMAL_DESC2_WB_RAPARSER_POS,
+				      RX_NORMAL_DESC2_WB_RAPARSER_LEN);
+	if (err || rxparser == 0x7) {
+		fxgmac_set_bits(&pkt_info->errors, RX_PACKET_ERRORS_FRAME_POS,
+				RX_PACKET_ERRORS_FRAME_LEN, 1);
+		return 0;
+	}
+
+	etlt = FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_ETLT_POS,
+				  RX_NORMAL_DESC3_ETLT_LEN);
+
+	if (etlt == 0x4 && (netdev->features & NETIF_F_HW_VLAN_CTAG_RX)) {
+		fxgmac_set_bits(attr, RX_PKT_ATTR_VLAN_CTAG_POS,
+				RX_PKT_ATTR_VLAN_CTAG_LEN, 1);
+		pkt_info->vlan_ctag =
+			FXGMAC_GET_BITS_LE(dma_desc->desc0,
+					   RX_NORMAL_DESC0_OVT_POS,
+					   RX_NORMAL_DESC0_OVT_LEN);
+		yt_dbg(pdata, "vlan-ctag=%#06x\n", pkt_info->vlan_ctag);
+	}
+
+	return 0;
+}
+
 void fxgmac_hw_ops_init(struct fxgmac_hw_ops *hw_ops)
 {
 	hw_ops->pcie_init = fxgmac_pcie_init;
@@ -2168,6 +2570,8 @@ void fxgmac_hw_ops_init(struct fxgmac_hw_ops *hw_ops)
 	hw_ops->disable_tx = fxgmac_disable_tx;
 	hw_ops->enable_rx = fxgmac_enable_rx;
 	hw_ops->disable_rx = fxgmac_disable_rx;
+	hw_ops->dev_read = fxgmac_dev_read;
+	hw_ops->dev_xmit = fxgmac_dev_xmit;
 
 	hw_ops->enable_channel_irq = fxgmac_enable_channel_irq;
 	hw_ops->disable_channel_irq = fxgmac_disable_channel_irq;
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index c3baa06b0..fa1587e69 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -38,6 +38,206 @@ static unsigned int fxgmac_desc_rx_dirty(struct fxgmac_ring *ring)
 	return dirty;
 }
 
+void fxgmac_tx_start_xmit(struct fxgmac_channel *channel,
+			  struct fxgmac_ring *ring)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_desc_data *desc_data;
+
+	/* Make sure everything is written before the register write */
+	wmb();
+
+	/* Issue a poll command to Tx DMA by writing address
+	 * of next immediate free descriptor
+	 */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, ring->cur);
+	wr32_mac(pdata, lower_32_bits(desc_data->dma_desc_addr),
+		 FXGMAC_DMA_REG(channel, DMA_CH_TDTR_LO));
+
+	if (netif_msg_tx_done(pdata)) {
+		yt_dbg(pdata,
+		       "tx_start_xmit: dump before wr reg, dma base=0x%016llx,reg=0x%08x,",
+		       desc_data->dma_desc_addr,
+		       rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_TDTR_LO)));
+
+		yt_dbg(pdata, "tx timer usecs=%u,tx_timer_active=%u\n",
+		       pdata->tx_usecs, channel->tx_timer_active);
+	}
+
+	ring->tx.xmit_more = 0;
+}
+
+static netdev_tx_t fxgmac_maybe_stop_tx_queue(struct fxgmac_channel *channel,
+					      struct fxgmac_ring *ring,
+					      unsigned int count)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+
+	if (count > fxgmac_desc_tx_avail(ring)) {
+		/* Avoid wrongly optimistic queue wake-up: tx poll thread must
+		 * not miss a ring update when it notices a stopped queue.
+		 */
+		smp_wmb();
+		netif_stop_subqueue(pdata->netdev, channel->queue_index);
+		ring->tx.queue_stopped = 1;
+
+		/* Sync with tx poll:
+		 * - publish queue status and cur ring index (write barrier)
+		 * - refresh dirty ring index (read barrier).
+		 * May the current thread have a pessimistic view of the ring
+		 * status and forget to wake up queue, a racing tx poll thread
+		 * can't.
+		 */
+		smp_mb();
+		if (count <= fxgmac_desc_tx_avail(ring)) {
+			ring->tx.queue_stopped = 0;
+			netif_start_subqueue(pdata->netdev,
+					     channel->queue_index);
+			fxgmac_tx_start_xmit(channel, ring);
+		} else {
+			/* If we haven't notified the hardware because of
+			 * xmit_more support, tell it now
+			 */
+			if (ring->tx.xmit_more)
+				fxgmac_tx_start_xmit(channel, ring);
+			if (netif_msg_tx_done(pdata))
+				yt_dbg(pdata, "about stop tx q, ret BUSY\n");
+			return NETDEV_TX_BUSY;
+		}
+	}
+
+	return NETDEV_TX_OK;
+}
+
+static void fxgmac_prep_vlan(struct sk_buff *skb,
+			     struct fxgmac_pkt_info *pkt_info)
+{
+	if (skb_vlan_tag_present(skb))
+		pkt_info->vlan_ctag = skb_vlan_tag_get(skb);
+}
+
+static int fxgmac_prep_tso(struct fxgmac_pdata *pdata, struct sk_buff *skb,
+			   struct fxgmac_pkt_info *pkt_info)
+{
+	int ret;
+
+	if (!FXGMAC_GET_BITS(pkt_info->attributes, TX_PKT_ATTR_TSO_ENABLE_POS,
+			     TX_PKT_ATTR_TSO_ENABLE_LEN))
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
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata,
+		       "header_len=%u, tcp_header_len=%u, tcp_payload_len=%u, mss=%u\n",
+		       pkt_info->header_len, pkt_info->tcp_header_len,
+		       pkt_info->tcp_payload_len, pkt_info->mss);
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
+static void fxgmac_prep_tx_pkt(struct fxgmac_pdata *pdata,
+			       struct fxgmac_ring *ring, struct sk_buff *skb,
+			       struct fxgmac_pkt_info *pkt_info)
+{
+	u32 *attr = &pkt_info->attributes;
+	u32 len, context_desc = 0;
+
+	pkt_info->skb = skb;
+	pkt_info->desc_count = 0;
+	pkt_info->tx_packets = 1;
+	pkt_info->tx_bytes = skb->len;
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata, "%s, pkt desc cnt=%d,skb len=%d, skbheadlen=%d\n",
+		       __func__, pkt_info->desc_count, skb->len,
+		       skb_headlen(skb));
+
+	if (fxgmac_is_tso(skb)) {
+		/* TSO requires an extra descriptor if mss is different */
+		if (skb_shinfo(skb)->gso_size != ring->tx.cur_mss) {
+			context_desc = 1;
+			pkt_info->desc_count++;
+		}
+		if (netif_msg_tx_done(pdata))
+			yt_dbg(pdata,
+			       "fxgmac_is_tso=%d, ip_summed=%d,skb gso=%d\n",
+			       ((skb->ip_summed == CHECKSUM_PARTIAL) &&
+				(skb_is_gso(skb))) ? 1 : 0,
+			       skb->ip_summed, skb_is_gso(skb) ? 1 : 0);
+
+		/* TSO requires an extra descriptor for TSO header */
+		pkt_info->desc_count++;
+		fxgmac_set_bits(attr, TX_PKT_ATTR_TSO_ENABLE_POS,
+				TX_PKT_ATTR_TSO_ENABLE_LEN, 1);
+		fxgmac_set_bits(attr, TX_PKT_ATTR_CSUM_ENABLE_POS,
+				TX_PKT_ATTR_CSUM_ENABLE_LEN, 1);
+		if (netif_msg_tx_done(pdata))
+			yt_dbg(pdata, "%s,tso, pkt desc cnt=%d\n", __func__,
+			       pkt_info->desc_count);
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL)
+		fxgmac_set_bits(attr, TX_PKT_ATTR_CSUM_ENABLE_POS,
+				TX_PKT_ATTR_CSUM_ENABLE_LEN, 1);
+
+	if (skb_vlan_tag_present(skb)) {
+		/* VLAN requires an extra descriptor if tag is different */
+		if (skb_vlan_tag_get(skb) != ring->tx.cur_vlan_ctag)
+			/* We can share with the TSO context descriptor */
+			if (!context_desc) {
+				context_desc = 1;
+				pkt_info->desc_count++;
+			}
+
+		fxgmac_set_bits(attr, TX_PKT_ATTR_VLAN_CTAG_POS,
+				TX_PKT_ATTR_VLAN_CTAG_LEN, 1);
+		if (netif_msg_tx_done(pdata))
+			yt_dbg(pdata, "%s,VLAN, pkt desc cnt=%d,vlan=0x%04x\n",
+			       __func__, pkt_info->desc_count,
+			       skb_vlan_tag_get(skb));
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
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata,
+		       "%s,pkt desc cnt%d,skb len%d, skbheadlen=%d,frags=%d\n",
+		       __func__, pkt_info->desc_count, skb->len,
+		       skb_headlen(skb), skb_shinfo(skb)->nr_frags);
+}
+
 static int fxgmac_calc_rx_buf_size(struct fxgmac_pdata *pdata, unsigned int mtu)
 {
 	u32 rx_buf_size, max_mtu;
@@ -1713,8 +1913,77 @@ void fxgmac_dbg_pkt(struct fxgmac_pdata *pdata, struct sk_buff *skb, bool tx_rx)
 	yt_dbg(pdata, "\n************** SKB dump ****************\n");
 }
 
+static netdev_tx_t fxgmac_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_pkt_info *tx_pkt_info;
+	struct fxgmac_channel *channel;
+	struct fxgmac_hw_ops *hw_ops;
+	struct netdev_queue *txq;
+	struct fxgmac_ring *ring;
+	int ret;
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata, "%s, skb->len=%d,q=%d\n", __func__, skb->len,
+		       skb->queue_mapping);
+
+	channel = pdata->channel_head + skb->queue_mapping;
+	txq = netdev_get_tx_queue(netdev, channel->queue_index);
+	ring = channel->tx_ring;
+	tx_pkt_info = &ring->pkt_info;
+
+	hw_ops = &pdata->hw_ops;
+
+	if (skb->len == 0) {
+		yt_err(pdata, "empty skb received from stack\n");
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* Prepare preliminary packet info for TX */
+	memset(tx_pkt_info, 0, sizeof(*tx_pkt_info));
+	fxgmac_prep_tx_pkt(pdata, ring, skb, tx_pkt_info);
+
+	/* Check that there are enough descriptors available */
+	ret = fxgmac_maybe_stop_tx_queue(channel, ring,
+					 tx_pkt_info->desc_count);
+	if (ret == NETDEV_TX_BUSY)
+		return ret;
+
+	ret = fxgmac_prep_tso(pdata, skb, tx_pkt_info);
+	if (ret < 0) {
+		yt_err(pdata, "error processing TSO packet\n");
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+	fxgmac_prep_vlan(skb, tx_pkt_info);
+
+	if (!fxgmac_tx_skb_map(channel, skb)) {
+		dev_kfree_skb_any(skb);
+		yt_err(pdata, "xmit, map tx skb err\n");
+		return NETDEV_TX_OK;
+	}
+
+	/* Report on the actual number of bytes (to be) sent */
+	netdev_tx_sent_queue(txq, tx_pkt_info->tx_bytes);
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata, "xmit,before hw_xmit, byte len=%d\n",
+		       tx_pkt_info->tx_bytes);
+
+	/* Configure required descriptor fields for transmission */
+	hw_ops->dev_xmit(channel);
+
+	if (netif_msg_pktdata(pdata))
+		fxgmac_dbg_pkt(pdata, skb, true);
+
+	/* Stop the queue in advance if there may not be enough descriptors */
+	fxgmac_maybe_stop_tx_queue(channel, ring, FXGMAC_TX_MAX_DESC_NR);
+
+	return NETDEV_TX_OK;
+}
 static const struct net_device_ops fxgmac_netdev_ops = {
 	.ndo_open		= fxgmac_open,
+	.ndo_start_xmit		= fxgmac_xmit,
 };
 
 const struct net_device_ops *fxgmac_get_netdev_ops(void)
-- 
2.34.1


