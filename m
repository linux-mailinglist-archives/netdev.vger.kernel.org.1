Return-Path: <netdev+bounces-123058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF85963906
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925A6286B34
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73174CB36;
	Thu, 29 Aug 2024 03:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="orcYCH1a"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3742481B1;
	Thu, 29 Aug 2024 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903555; cv=none; b=eEux3eogvMU18IeNrsv1n5Osq6Dmi1hhJltdFqTNu7hkWrhiSb/pLdbDHnvObeMbJJulkF17Bkt5Lm1e62E8A2OaTTLpWZfLDdU8AhykTcm1/i6R+MHi5McbdnqgVdsYlQVVNwQmeVdAxjGoZLhnm6UbijiPu3i0+51KzX955+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903555; c=relaxed/simple;
	bh=/QBMicjyrvy8xdZRjhSISwviNYLYOtrR3UWA5AQ813U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dpwW8HrwQDhLCaToYvvoEg4/yeS2pu7V4hnj16N5rs3h1BU9qAP1kg/wiTN6gbDAQaUWhjaZ03STqh+ZF/uo08GZnavuce2P8On8Lay1onzrtvROa6dgSnufXJOXW5o9AJHktsDcy4IgNEGP4ACA9rSuo46Bq1pdaclm8ZpvCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=orcYCH1a; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47T3q7HO13107488, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724903527; bh=/QBMicjyrvy8xdZRjhSISwviNYLYOtrR3UWA5AQ813U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=orcYCH1aILxFdPBkn4dX7iWDcjjmKHNplQ2/LU+9MhM52IbOy5gUyQ7ImQnMIrmZi
	 Qa0JYyZt/wVQ8LTM2R1/SRkI5yHRVP8268WKd1M/3x7+AExMDMfhBkJIJWbMvbIyUR
	 AYFRZS/yCRn2OLe3R2iO00zkxmbjAtNOg2te31PG1aOUvVEdeiT4WtfsK0LRYuaHOO
	 JJrhpDH+wDmTHE4voyLkUIf5KSJmlcUvQdjaYku/PaqThV29kDj4huwvIdNdQvKL6i
	 CmRS0YAtdZQ4OuLVp26OIf+LjEnTegTXa6Nza84NeNIl3ganPBnxrKYK/w64FgxPzQ
	 IKKws+QKfR+fA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47T3q7HO13107488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 11:52:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 11:52:07 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Aug
 2024 11:52:06 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v29 07/13] rtase: Implement a function to receive packets
Date: Thu, 29 Aug 2024 11:48:26 +0800
Message-ID: <20240829034832.139345-8-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829034832.139345-1-justinlai0215@realtek.com>
References: <20240829034832.139345-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Implement rx_handler to read the information of the rx descriptor,
thereby checking the packet accordingly and storing the packet
in the socket buffer to complete the reception of the packet.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index bef5a944df59..bf2c24adef90 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -436,6 +436,151 @@ static void rtase_rx_ring_clear(struct page_pool *page_pool,
 	}
 }
 
+static int rtase_fragmented_frame(u32 status)
+{
+	return (status & (RTASE_RX_FIRST_FRAG | RTASE_RX_LAST_FRAG)) !=
+	       (RTASE_RX_FIRST_FRAG | RTASE_RX_LAST_FRAG);
+}
+
+static void rtase_rx_csum(const struct rtase_private *tp, struct sk_buff *skb,
+			  const union rtase_rx_desc *desc)
+{
+	u32 opts2 = le32_to_cpu(desc->desc_status.opts2);
+
+	/* rx csum offload */
+	if (((opts2 & RTASE_RX_V4F) && !(opts2 & RTASE_RX_IPF)) ||
+	    (opts2 & RTASE_RX_V6F)) {
+		if (((opts2 & RTASE_RX_TCPT) && !(opts2 & RTASE_RX_TCPF)) ||
+		    ((opts2 & RTASE_RX_UDPT) && !(opts2 & RTASE_RX_UDPF)))
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		else
+			skb->ip_summed = CHECKSUM_NONE;
+	} else {
+		skb->ip_summed = CHECKSUM_NONE;
+	}
+}
+
+static void rtase_rx_vlan_skb(union rtase_rx_desc *desc, struct sk_buff *skb)
+{
+	u32 opts2 = le32_to_cpu(desc->desc_status.opts2);
+
+	if (!(opts2 & RTASE_RX_VLAN_TAG))
+		return;
+
+	__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+			       swab16(opts2 & RTASE_VLAN_TAG_MASK));
+}
+
+static void rtase_rx_skb(const struct rtase_ring *ring, struct sk_buff *skb)
+{
+	struct rtase_int_vector *ivec = ring->ivec;
+
+	napi_gro_receive(&ivec->napi, skb);
+}
+
+static int rx_handler(struct rtase_ring *ring, int budget)
+{
+	union rtase_rx_desc *desc_base = ring->desc;
+	u32 pkt_size, cur_rx, delta, entry, status;
+	struct rtase_private *tp = ring->ivec->tp;
+	struct net_device *dev = tp->dev;
+	union rtase_rx_desc *desc;
+	struct sk_buff *skb;
+	int workdone = 0;
+
+	cur_rx = ring->cur_idx;
+	entry = cur_rx % RTASE_NUM_DESC;
+	desc = &desc_base[entry];
+
+	do {
+		status = le32_to_cpu(desc->desc_status.opts1);
+
+		if (status & RTASE_DESC_OWN)
+			break;
+
+		/* This barrier is needed to keep us from reading
+		 * any other fields out of the rx descriptor until
+		 * we know the status of RTASE_DESC_OWN
+		 */
+		dma_rmb();
+
+		if (unlikely(status & RTASE_RX_RES)) {
+			if (net_ratelimit())
+				netdev_warn(dev, "Rx ERROR. status = %08x\n",
+					    status);
+
+			tp->stats.rx_errors++;
+
+			if (status & (RTASE_RX_RWT | RTASE_RX_RUNT))
+				tp->stats.rx_length_errors++;
+
+			if (status & RTASE_RX_CRC)
+				tp->stats.rx_crc_errors++;
+
+			if (dev->features & NETIF_F_RXALL)
+				goto process_pkt;
+
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			goto skip_process_pkt;
+		}
+
+process_pkt:
+		pkt_size = status & RTASE_RX_PKT_SIZE_MASK;
+		if (likely(!(dev->features & NETIF_F_RXFCS)))
+			pkt_size -= ETH_FCS_LEN;
+
+		/* The driver does not support incoming fragmented frames.
+		 * They are seen as a symptom of over-mtu sized frames.
+		 */
+		if (unlikely(rtase_fragmented_frame(status))) {
+			tp->stats.rx_dropped++;
+			tp->stats.rx_length_errors++;
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			goto skip_process_pkt;
+		}
+
+		dma_sync_single_for_cpu(&tp->pdev->dev,
+					ring->mis.data_phy_addr[entry],
+					tp->rx_buf_sz, DMA_FROM_DEVICE);
+
+		skb = build_skb(ring->data_buf[entry], PAGE_SIZE);
+		if (!skb) {
+			tp->stats.rx_dropped++;
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			goto skip_process_pkt;
+		}
+		ring->data_buf[entry] = NULL;
+
+		if (dev->features & NETIF_F_RXCSUM)
+			rtase_rx_csum(tp, skb, desc);
+
+		skb->dev = dev;
+		skb_put(skb, pkt_size);
+		skb_mark_for_recycle(skb);
+		skb->protocol = eth_type_trans(skb, dev);
+
+		if (skb->pkt_type == PACKET_MULTICAST)
+			tp->stats.multicast++;
+
+		rtase_rx_vlan_skb(desc, skb);
+		rtase_rx_skb(ring, skb);
+
+		dev_sw_netstats_rx_add(dev, pkt_size);
+
+skip_process_pkt:
+		workdone++;
+		cur_rx++;
+		entry = cur_rx % RTASE_NUM_DESC;
+		desc = ring->desc + sizeof(union rtase_rx_desc) * entry;
+	} while (workdone != budget);
+
+	ring->cur_idx = cur_rx;
+	delta = rtase_rx_ring_fill(ring, ring->dirty_idx, ring->cur_idx);
+	ring->dirty_idx += delta;
+
+	return workdone;
+}
+
 static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
 {
 	struct rtase_ring *ring = &tp->rx_ring[idx];
-- 
2.34.1


