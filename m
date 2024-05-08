Return-Path: <netdev+bounces-94557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F378BFD77
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1FAB25465
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB565823F;
	Wed,  8 May 2024 12:43:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5F56455;
	Wed,  8 May 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715172235; cv=none; b=tA+FqRtr89TnO41bmVAeCxQrLq+7unbI4Sn1F82RnujnYsR78nygJlSl7QQ8uftINGjooneWxZvJCw1sSyMrr0kivIpTtSPbRsbLWQPQ9D3wsz0OsJp0KRYH6/OJlAHmNcmp9YKKvDNhNSStbrV4ZofZp8yiPyHXYkCQZiZAKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715172235; c=relaxed/simple;
	bh=PhV2Emi/wGXycD+0LHkChmZx0uNY1pxA/6vcGae8lIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNfQCIDUxwrPOlMphQmOf7SsDptKsfppPy+SKLUlbQPvg81Z2u7m2dXahv8V/58pJ2O/ZLyihr/p2KSf4Yp1fI8upsVyzu1/rsSX65Fg/kSfYFHfC3GIn8hA9uz13aN39w+ydobqqCZJtzjSQFKJ19dW7Qa6KAoDEFH+M6aVnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 448ChZzlD467590, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 448ChZzlD467590
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 May 2024 20:43:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 20:43:35 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 8 May
 2024 20:43:35 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v18 07/13] rtase: Implement a function to receive packets
Date: Wed, 8 May 2024 20:39:39 +0800
Message-ID: <20240508123945.201524-8-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508123945.201524-1-justinlai0215@realtek.com>
References: <20240508123945.201524-1-justinlai0215@realtek.com>
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

Implement rx_handler to read the information of the rx descriptor,
thereby checking the packet accordingly and storing the packet
in the socket buffer to complete the reception of the packet.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 146 ++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index a30dcdbdc3cc..4aac9cc134d3 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -452,6 +452,152 @@ static void rtase_rx_ring_clear(struct rtase_ring *ring)
 	}
 }
 
+static int rtase_fragmented_frame(u32 status)
+{
+	return (status & (RTASE_RX_FIRST_FRAG | RTASE_RX_LAST_FRAG)) !=
+		(RTASE_RX_FIRST_FRAG | RTASE_RX_LAST_FRAG);
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
+		    ((opts2 & RTASE_RX_UDPT) && !(opts2 & RTASE_RX_UDPF))) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			skb->ip_summed = CHECKSUM_NONE;
+		}
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
+	const struct rtase_private *tp = ring->ivec->tp;
+	union rtase_rx_desc *desc_base = ring->desc;
+	u32 pkt_size, cur_rx, delta, entry, status;
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
+		/* make sure discriptor has been updated */
+		rmb();
+		status = le32_to_cpu(desc->desc_status.opts1);
+
+		if (status & RTASE_DESC_OWN)
+			break;
+
+		if (unlikely(status & RTASE_RX_RES)) {
+			if (net_ratelimit())
+				netdev_warn(dev, "Rx ERROR. status = %08x\n",
+					    status);
+
+			dev->stats.rx_errors++;
+
+			if (status & (RTASE_RX_RWT | RTASE_RX_RUNT))
+				dev->stats.rx_length_errors++;
+
+			if (status & RTASE_RX_CRC)
+				dev->stats.rx_crc_errors++;
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
+		/* the driver does not support incoming fragmented
+		 * frames. they are seen as a symptom of over-mtu
+		 * sized frames
+		 */
+		if (unlikely(rtase_fragmented_frame(status))) {
+			dev->stats.rx_dropped++;
+			dev->stats.rx_length_errors++;
+			rtase_mark_to_asic(desc, tp->rx_buf_sz);
+			continue;
+		}
+
+		skb = ring->skbuff[entry];
+		dma_sync_single_for_cpu(&tp->pdev->dev,
+					ring->mis.data_phy_addr[entry],
+					tp->rx_buf_sz, DMA_FROM_DEVICE);
+
+		ring->skbuff[entry] = NULL;
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
+			dev->stats.multicast++;
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
+		prefetch(desc);
+	} while (workdone != budget);
+
+	ring->cur_idx = cur_rx;
+	delta = rtase_rx_ring_fill(ring, ring->dirty_idx, ring->cur_idx, 1);
+
+	if (!delta && workdone)
+		netdev_info(dev, "no Rx buffer allocated\n");
+
+	ring->dirty_idx += delta;
+
+	if ((ring->dirty_idx + RTASE_NUM_DESC) == ring->cur_idx)
+		netdev_emerg(dev, "Rx buffers exhausted\n");
+
+	return workdone;
+}
+
 static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
 {
 	struct rtase_ring *ring = &tp->rx_ring[idx];
-- 
2.34.1


