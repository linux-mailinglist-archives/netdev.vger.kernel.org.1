Return-Path: <netdev+bounces-110486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 136CC92C94B
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 05:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55A79B22A57
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537AA381B0;
	Wed, 10 Jul 2024 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Qga7JrtN"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1EC2D6;
	Wed, 10 Jul 2024 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582646; cv=none; b=Sa0oDIc7LQRzYlv268gcwkjIsfVgyaYJj3njPywxvtvoT3c/hzhTtmYxK3Rzl9AFKEY+MxgBaM81rNrzeK1Q0c5BoM31SL6r/YjD5B5tV07dmm97Sf22qLG8njT0v/hvr7CR/ozChaNEsY4QQiTh7PbpMBEfy0MReoFAFNpYJmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582646; c=relaxed/simple;
	bh=nDylsU0d/rxpBTicT3wUpG7DE2mM43L3IpZMSWfGV0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ityhnNOSxA++zVq7ad7VfNNBHXaae9vtxfZqcFclraAJcoFm6nq0rISPiL/uQoWJT1RDOqgI7fZEIw878/OXi5MsxsK/3b2T+P1mD+jWispeFY4G1g4fDYXvKFHDChaH8A89SuZihJSSXIAj7Y19WbqtaYakzx/vc8hkYhsDFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Qga7JrtN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46A3axvF71588723, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720582619; bh=nDylsU0d/rxpBTicT3wUpG7DE2mM43L3IpZMSWfGV0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Qga7JrtNp+9I5zjnk0IZeaBkz1j15NQ5x3iPA4ENLdPh0W9PVaJTOFI1LnnjkvF7X
	 h+s/oNs1dR900npO1xcZx93dNakxQ+wpsRTPnOoETEwZQ+eQE4GhOL7YK7CARgZznh
	 rZkx/licMAtMrvyHRQ+GRIGEKZBOrWWI2crdDJ6mKHRgU5mV7qEhEI9kape9WFfmH9
	 n0Aki6Ric1witrYwIunYwd6VoZ5GjX2L8X+gSiobsjjp18b4A7xQ75+8e4YRbk3fT8
	 b20zoIDEVT+gr0bsw1phclZJYd3syvOyieRJcF6Bo0Ry7ZTzEnHcdjRIr6zWvqox5S
	 oip/LDHTk9cPw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46A3axvF71588723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 11:36:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 11:37:00 +0800
Received: from RTDOMAIN (172.21.210.68) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Jul
 2024 11:36:59 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v23 07/13] rtase: Implement a function to receive packets
Date: Wed, 10 Jul 2024 11:32:28 +0800
Message-ID: <20240710033234.26868-8-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710033234.26868-1-justinlai0215@realtek.com>
References: <20240710033234.26868-1-justinlai0215@realtek.com>
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
 .../net/ethernet/realtek/rtase/rtase_main.c   | 145 ++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 86211b629def..7fe0e95acf70 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -450,6 +450,151 @@ static void rtase_rx_ring_clear(struct rtase_ring *ring)
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
+		/* the driver does not support incoming fragmented
+		 * frames. they are seen as a symptom of over-mtu
+		 * sized frames
+		 */
+		if (unlikely(rtase_fragmented_frame(status))) {
+			tp->stats.rx_dropped++;
+			tp->stats.rx_length_errors++;
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


