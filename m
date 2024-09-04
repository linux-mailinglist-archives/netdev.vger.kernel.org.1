Return-Path: <netdev+bounces-124793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B196AF38
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 05:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786D1B22763
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 03:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC7B4317B;
	Wed,  4 Sep 2024 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="q+n8Hb2L"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93545026;
	Wed,  4 Sep 2024 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725420233; cv=none; b=pDxxG2dS/f/i0Y69a8KhdUjCs7FXgqnJDAyuscAR2C5c11jxKblqlOcMcX4NN8SIQue0wAEyUndy+fCGE+hbAQMylB3OO1ffQzwveZDx/GZGXpiDrbmc2dbqewVRSxHsK+3HiZX4BZaWAS1uYHhkR0dnSuCEREfYkGFmG/rDszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725420233; c=relaxed/simple;
	bh=C+H9j8j6KQP2EbKisNjB+UxEGbIgUJQFZo1TB4LWvWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/5ynP5AUjx6KwWMhq1GuiPDUN68TdB1mzKb+7tDK8og4bv+lju010itt1UGQIL3Z/r3tdSSp+aCrzGowv2KvJuUjjLa7M/B4H/dz3V954i8jGgPva7MfsLaupotC+ufdoFPfYhCj9MOA1lrUQirHE/IM6Lfs/dV+tzs6H1OFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=q+n8Hb2L; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4843NNU602040895, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1725420203; bh=C+H9j8j6KQP2EbKisNjB+UxEGbIgUJQFZo1TB4LWvWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=q+n8Hb2LE/jaISaJITEvGO3s6JSR4HLhE9Sew3TR75O2RiiSSU2P0BTAXBsSMbrWq
	 /1lfsfV4D6pkXBS0mVqPCJGrnfBeXEYfaRdFv4J8gsifJlCOgH1EO125Ev2JiTUqbh
	 Gc46kHLV0oyLbmrjOJVqZGe264zWdLqRPOPI9Qxd2cTmfalIBV5JLta4cKnjMuyJJt
	 prUmhJlo3Iv5I1T3yAwGoebNzDnTjurNA9vNRJJLYAvXx1wMCZqhYbTkgnjKF8fK/r
	 Sj6eBcGChaLcBpeeK/VZcDkM+Vj3gt16ewv3xJkYOsf9Yju5JKpCXbCwbQ18lpmDFd
	 lKEUeKCZPl/rQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4843NNU602040895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 11:23:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Sep 2024 11:23:23 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 4 Sep
 2024 11:23:23 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v30 06/13] rtase: Implement .ndo_start_xmit function
Date: Wed, 4 Sep 2024 11:21:07 +0800
Message-ID: <20240904032114.247117-7-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904032114.247117-1-justinlai0215@realtek.com>
References: <20240904032114.247117-1-justinlai0215@realtek.com>
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

Implement .ndo_start_xmit function to fill the information of the packet
to be transmitted into the tx descriptor, and then the hardware will
transmit the packet using the information in the tx descriptor.
In addition, we also implemented the tx_handler function to enable the
tx descriptor to be reused.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 283 ++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index ce40aa84588f..bef5a944df59 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -253,6 +253,68 @@ static void rtase_mark_to_asic(union rtase_rx_desc *desc, u32 rx_buf_sz)
 		   cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz));
 }
 
+static u32 rtase_tx_avail(struct rtase_ring *ring)
+{
+	return READ_ONCE(ring->dirty_idx) + RTASE_NUM_DESC -
+	       READ_ONCE(ring->cur_idx);
+}
+
+static int tx_handler(struct rtase_ring *ring, int budget)
+{
+	const struct rtase_private *tp = ring->ivec->tp;
+	struct net_device *dev = tp->dev;
+	u32 dirty_tx, tx_left;
+	u32 bytes_compl = 0;
+	u32 pkts_compl = 0;
+	int workdone = 0;
+
+	dirty_tx = ring->dirty_idx;
+	tx_left = READ_ONCE(ring->cur_idx) - dirty_tx;
+
+	while (tx_left > 0) {
+		u32 entry = dirty_tx % RTASE_NUM_DESC;
+		struct rtase_tx_desc *desc = ring->desc +
+				       sizeof(struct rtase_tx_desc) * entry;
+		u32 status;
+
+		status = le32_to_cpu(desc->opts1);
+
+		if (status & RTASE_DESC_OWN)
+			break;
+
+		rtase_unmap_tx_skb(tp->pdev, ring->mis.len[entry], desc);
+		ring->mis.len[entry] = 0;
+		if (ring->skbuff[entry]) {
+			pkts_compl++;
+			bytes_compl += ring->skbuff[entry]->len;
+			napi_consume_skb(ring->skbuff[entry], budget);
+			ring->skbuff[entry] = NULL;
+		}
+
+		dirty_tx++;
+		tx_left--;
+		workdone++;
+
+		if (workdone == RTASE_TX_BUDGET_DEFAULT)
+			break;
+	}
+
+	if (ring->dirty_idx != dirty_tx) {
+		dev_sw_netstats_tx_add(dev, pkts_compl, bytes_compl);
+		WRITE_ONCE(ring->dirty_idx, dirty_tx);
+
+		netif_subqueue_completed_wake(dev, ring->index, pkts_compl,
+					      bytes_compl,
+					      rtase_tx_avail(ring),
+					      RTASE_TX_START_THRS);
+
+		if (ring->cur_idx != dirty_tx)
+			rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
+	}
+
+	return 0;
+}
+
 static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
 {
 	struct rtase_ring *ring = &tp->tx_ring[idx];
@@ -991,6 +1053,226 @@ static int rtase_close(struct net_device *dev)
 	return 0;
 }
 
+static u32 rtase_tx_vlan_tag(const struct rtase_private *tp,
+			     const struct sk_buff *skb)
+{
+	return (skb_vlan_tag_present(skb)) ?
+		(RTASE_TX_VLAN_TAG | swab16(skb_vlan_tag_get(skb))) : 0x00;
+}
+
+static u32 rtase_tx_csum(struct sk_buff *skb, const struct net_device *dev)
+{
+	u32 csum_cmd = 0;
+	u8 ip_protocol;
+
+	switch (vlan_get_protocol(skb)) {
+	case htons(ETH_P_IP):
+		csum_cmd = RTASE_TX_IPCS_C;
+		ip_protocol = ip_hdr(skb)->protocol;
+		break;
+
+	case htons(ETH_P_IPV6):
+		csum_cmd = RTASE_TX_IPV6F_C;
+		ip_protocol = ipv6_hdr(skb)->nexthdr;
+		break;
+
+	default:
+		ip_protocol = IPPROTO_RAW;
+		break;
+	}
+
+	if (ip_protocol == IPPROTO_TCP)
+		csum_cmd |= RTASE_TX_TCPCS_C;
+	else if (ip_protocol == IPPROTO_UDP)
+		csum_cmd |= RTASE_TX_UDPCS_C;
+
+	csum_cmd |= u32_encode_bits(skb_transport_offset(skb),
+				    RTASE_TCPHO_MASK);
+
+	return csum_cmd;
+}
+
+static int rtase_xmit_frags(struct rtase_ring *ring, struct sk_buff *skb,
+			    u32 opts1, u32 opts2)
+{
+	const struct skb_shared_info *info = skb_shinfo(skb);
+	const struct rtase_private *tp = ring->ivec->tp;
+	const u8 nr_frags = info->nr_frags;
+	struct rtase_tx_desc *txd = NULL;
+	u32 cur_frag, entry;
+
+	entry = ring->cur_idx;
+	for (cur_frag = 0; cur_frag < nr_frags; cur_frag++) {
+		const skb_frag_t *frag = &info->frags[cur_frag];
+		dma_addr_t mapping;
+		u32 status, len;
+		void *addr;
+
+		entry = (entry + 1) % RTASE_NUM_DESC;
+
+		txd = ring->desc + sizeof(struct rtase_tx_desc) * entry;
+		len = skb_frag_size(frag);
+		addr = skb_frag_address(frag);
+		mapping = dma_map_single(&tp->pdev->dev, addr, len,
+					 DMA_TO_DEVICE);
+
+		if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
+			if (unlikely(net_ratelimit()))
+				netdev_err(tp->dev,
+					   "Failed to map TX fragments DMA!\n");
+
+			goto err_out;
+		}
+
+		if (((entry + 1) % RTASE_NUM_DESC) == 0)
+			status = (opts1 | len | RTASE_RING_END);
+		else
+			status = opts1 | len;
+
+		if (cur_frag == (nr_frags - 1)) {
+			ring->skbuff[entry] = skb;
+			status |= RTASE_TX_LAST_FRAG;
+		}
+
+		ring->mis.len[entry] = len;
+		txd->addr = cpu_to_le64(mapping);
+		txd->opts2 = cpu_to_le32(opts2);
+
+		/* make sure the operating fields have been updated */
+		dma_wmb();
+		txd->opts1 = cpu_to_le32(status);
+	}
+
+	return cur_frag;
+
+err_out:
+	rtase_tx_clear_range(ring, ring->cur_idx + 1, cur_frag);
+	return -EIO;
+}
+
+static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
+				    struct net_device *dev)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	struct rtase_private *tp = netdev_priv(dev);
+	u32 q_idx, entry, len, opts1, opts2;
+	struct netdev_queue *tx_queue;
+	bool stop_queue, door_bell;
+	u32 mss = shinfo->gso_size;
+	struct rtase_tx_desc *txd;
+	struct rtase_ring *ring;
+	dma_addr_t mapping;
+	int frags;
+
+	/* multiqueues */
+	q_idx = skb_get_queue_mapping(skb);
+	ring = &tp->tx_ring[q_idx];
+	tx_queue = netdev_get_tx_queue(dev, q_idx);
+
+	if (unlikely(!rtase_tx_avail(ring))) {
+		if (net_ratelimit())
+			netdev_err(dev,
+				   "BUG! Tx Ring full when queue awake!\n");
+
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
+	}
+
+	entry = ring->cur_idx % RTASE_NUM_DESC;
+	txd = ring->desc + sizeof(struct rtase_tx_desc) * entry;
+
+	opts1 = RTASE_DESC_OWN;
+	opts2 = rtase_tx_vlan_tag(tp, skb);
+
+	/* tcp segmentation offload (or tcp large send) */
+	if (mss) {
+		if (shinfo->gso_type & SKB_GSO_TCPV4) {
+			opts1 |= RTASE_GIANT_SEND_V4;
+		} else if (shinfo->gso_type & SKB_GSO_TCPV6) {
+			if (skb_cow_head(skb, 0))
+				goto err_dma_0;
+
+			tcp_v6_gso_csum_prep(skb);
+			opts1 |= RTASE_GIANT_SEND_V6;
+		} else {
+			WARN_ON_ONCE(1);
+		}
+
+		opts1 |= u32_encode_bits(skb_transport_offset(skb),
+					 RTASE_TCPHO_MASK);
+		opts2 |= u32_encode_bits(mss, RTASE_MSS_MASK);
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		opts2 |= rtase_tx_csum(skb, dev);
+	}
+
+	frags = rtase_xmit_frags(ring, skb, opts1, opts2);
+	if (unlikely(frags < 0))
+		goto err_dma_0;
+
+	if (frags) {
+		len = skb_headlen(skb);
+		opts1 |= RTASE_TX_FIRST_FRAG;
+	} else {
+		len = skb->len;
+		ring->skbuff[entry] = skb;
+		opts1 |= RTASE_TX_FIRST_FRAG | RTASE_TX_LAST_FRAG;
+	}
+
+	if (((entry + 1) % RTASE_NUM_DESC) == 0)
+		opts1 |= (len | RTASE_RING_END);
+	else
+		opts1 |= len;
+
+	mapping = dma_map_single(&tp->pdev->dev, skb->data, len,
+				 DMA_TO_DEVICE);
+
+	if (unlikely(dma_mapping_error(&tp->pdev->dev, mapping))) {
+		if (unlikely(net_ratelimit()))
+			netdev_err(dev, "Failed to map TX DMA!\n");
+
+		goto err_dma_1;
+	}
+
+	ring->mis.len[entry] = len;
+	txd->addr = cpu_to_le64(mapping);
+	txd->opts2 = cpu_to_le32(opts2);
+	txd->opts1 = cpu_to_le32(opts1 & ~RTASE_DESC_OWN);
+
+	/* make sure the operating fields have been updated */
+	dma_wmb();
+
+	door_bell = __netdev_tx_sent_queue(tx_queue, skb->len,
+					   netdev_xmit_more());
+
+	txd->opts1 = cpu_to_le32(opts1);
+
+	skb_tx_timestamp(skb);
+
+	/* tx needs to see descriptor changes before updated cur_idx */
+	smp_wmb();
+
+	WRITE_ONCE(ring->cur_idx, ring->cur_idx + frags + 1);
+
+	stop_queue = !netif_subqueue_maybe_stop(dev, ring->index,
+						rtase_tx_avail(ring),
+						RTASE_TX_STOP_THRS,
+						RTASE_TX_START_THRS);
+
+	if (door_bell || stop_queue)
+		rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
+
+	return NETDEV_TX_OK;
+
+err_dma_1:
+	ring->skbuff[entry] = NULL;
+	rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
+
+err_dma_0:
+	tp->stats.tx_dropped++;
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
 static void rtase_enable_eem_write(const struct rtase_private *tp)
 {
 	u8 val;
@@ -1026,6 +1308,7 @@ static void rtase_rar_set(const struct rtase_private *tp, const u8 *addr)
 static const struct net_device_ops rtase_netdev_ops = {
 	.ndo_open = rtase_open,
 	.ndo_stop = rtase_close,
+	.ndo_start_xmit = rtase_start_xmit,
 };
 
 static void rtase_get_mac_address(struct net_device *dev)
-- 
2.34.1


