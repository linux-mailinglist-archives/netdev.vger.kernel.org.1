Return-Path: <netdev+bounces-105994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DD09142C5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 08:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 136681C2299B
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 06:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D6C25763;
	Mon, 24 Jun 2024 06:32:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A6210E9;
	Mon, 24 Jun 2024 06:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210725; cv=none; b=Hr0O8R8LAN0PZhN+oCAAe79rIB+F/a+9XLq9AwWdHJv7xgBczqm5c+AlBqet5HbFU1RUSo58s80fhk+E+xccvf1NWqgWdApGFswfhCsgNZE6qKhsifvYuF/kdpxNBa1DHecJ5o9WXG/HKqB497DdKwPHqXO4zNrkXm3ZfJWlGdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210725; c=relaxed/simple;
	bh=b3oUSCkkzfcq7sLYtjHZoEyJTKqH/qBryVhztqOKm88=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWdE9laNl/Wg6djJPuTi+9Rl2i8S41a1DhOz4GgizfVlwV3mi8/Xy2rKuokAJmJChgrplsQWg3NIfDFYoEC3IVtR+o0iujH5/EO34n8ESc1CmhC/v+vfetcDKiljSSITbWchpFqGztUVBkrbbHB4Lu/WK19bZH0jUtkqbFr7X2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45O6Vf7F22838298, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45O6Vf7F22838298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 14:31:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 14:31:41 +0800
Received: from RTDOMAIN (172.21.210.106) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 24 Jun
 2024 14:31:41 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v21 05/13] rtase: Implement hardware configuration function
Date: Mon, 24 Jun 2024 14:28:13 +0800
Message-ID: <20240624062821.6840-6-justinlai0215@realtek.com>
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
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Implement rtase_hw_config to set default hardware settings, including
setting interrupt mitigation, tx/rx DMA burst, interframe gap time,
rx packet filter, near fifo threshold and fill descriptor ring and
tally counter address, and enable flow control. When filling the
rx descriptor ring, the first group of queues needs to be processed
separately because the positions of the first group of queues are not
regular with other subsequent groups. The other queues are all newly
added features, but we want to retain the original design. So they were
not put together.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 238 ++++++++++++++++++
 1 file changed, 238 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index e65f53f01bce..8adc63a8375c 100755
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -465,6 +465,23 @@ static int rtase_init_ring(const struct net_device *dev)
 	return -ENOMEM;
 }
 
+static void rtase_interrupt_mitigation(const struct rtase_private *tp)
+{
+	u32 i;
+
+	for (i = 0; i < tp->func_tx_queue_num; i++)
+		rtase_w16(tp, RTASE_INT_MITI_TX + i * 2, tp->tx_int_mit);
+
+	for (i = 0; i < tp->func_rx_queue_num; i++)
+		rtase_w16(tp, RTASE_INT_MITI_RX + i * 2, tp->rx_int_mit);
+}
+
+static void rtase_tally_counter_addr_fill(const struct rtase_private *tp)
+{
+	rtase_w32(tp, RTASE_DTCCR4, upper_32_bits(tp->tally_paddr));
+	rtase_w32(tp, RTASE_DTCCR0, lower_32_bits(tp->tally_paddr));
+}
+
 static void rtase_tally_counter_clear(const struct rtase_private *tp)
 {
 	u32 cmd = lower_32_bits(tp->tally_paddr);
@@ -473,6 +490,119 @@ static void rtase_tally_counter_clear(const struct rtase_private *tp)
 	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_RESET);
 }
 
+static void rtase_desc_addr_fill(const struct rtase_private *tp)
+{
+	const struct rtase_ring *ring;
+	u16 i, cmd, val;
+	int err;
+
+	for (i = 0; i < tp->func_tx_queue_num; i++) {
+		ring = &tp->tx_ring[i];
+
+		rtase_w32(tp, RTASE_TX_DESC_ADDR0,
+			  lower_32_bits(ring->phy_addr));
+		rtase_w32(tp, RTASE_TX_DESC_ADDR4,
+			  upper_32_bits(ring->phy_addr));
+
+		cmd = i | RTASE_TX_DESC_CMD_WE | RTASE_TX_DESC_CMD_CS;
+		rtase_w16(tp, RTASE_TX_DESC_COMMAND, cmd);
+
+		err = read_poll_timeout(rtase_r16, val,
+					!(val & RTASE_TX_DESC_CMD_CS), 10,
+					1000, false, tp,
+					RTASE_TX_DESC_COMMAND);
+
+		if (err == -ETIMEDOUT)
+			netdev_err(tp->dev,
+				   "error occurred in fill tx descriptor\n");
+	}
+
+	for (i = 0; i < tp->func_rx_queue_num; i++) {
+		ring = &tp->rx_ring[i];
+
+		if (i == 0) {
+			rtase_w32(tp, RTASE_Q0_RX_DESC_ADDR0,
+				  lower_32_bits(ring->phy_addr));
+			rtase_w32(tp, RTASE_Q0_RX_DESC_ADDR4,
+				  upper_32_bits(ring->phy_addr));
+		} else {
+			rtase_w32(tp, (RTASE_Q1_RX_DESC_ADDR0 + ((i - 1) * 8)),
+				  lower_32_bits(ring->phy_addr));
+			rtase_w32(tp, (RTASE_Q1_RX_DESC_ADDR4 + ((i - 1) * 8)),
+				  upper_32_bits(ring->phy_addr));
+		}
+	}
+}
+
+static void rtase_hw_set_features(const struct net_device *dev,
+				  netdev_features_t features)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rx_config, val;
+
+	rx_config = rtase_r16(tp, RTASE_RX_CONFIG_0);
+	if (features & NETIF_F_RXALL)
+		rx_config |= (RTASE_ACCEPT_ERR | RTASE_ACCEPT_RUNT);
+	else
+		rx_config &= ~(RTASE_ACCEPT_ERR | RTASE_ACCEPT_RUNT);
+
+	rtase_w16(tp, RTASE_RX_CONFIG_0, rx_config);
+
+	val = rtase_r16(tp, RTASE_CPLUS_CMD);
+	if (features & NETIF_F_RXCSUM)
+		rtase_w16(tp, RTASE_CPLUS_CMD, val | RTASE_RX_CHKSUM);
+	else
+		rtase_w16(tp, RTASE_CPLUS_CMD, val & ~RTASE_RX_CHKSUM);
+
+	rx_config = rtase_r16(tp, RTASE_RX_CONFIG_1);
+	if (dev->features & NETIF_F_HW_VLAN_CTAG_RX)
+		rx_config |= (RTASE_INNER_VLAN_DETAG_EN |
+			      RTASE_OUTER_VLAN_DETAG_EN);
+	else
+		rx_config &= ~(RTASE_INNER_VLAN_DETAG_EN |
+			       RTASE_OUTER_VLAN_DETAG_EN);
+
+	rtase_w16(tp, RTASE_RX_CONFIG_1, rx_config);
+}
+
+static void rtase_hw_set_rx_packet_filter(struct net_device *dev)
+{
+	u32 mc_filter[2] = { 0xFFFFFFFF, 0xFFFFFFFF };
+	struct rtase_private *tp = netdev_priv(dev);
+	u16 rx_mode;
+
+	rx_mode = rtase_r16(tp, RTASE_RX_CONFIG_0) & ~RTASE_ACCEPT_MASK;
+	rx_mode |= RTASE_ACCEPT_BROADCAST | RTASE_ACCEPT_MYPHYS;
+
+	if (dev->flags & IFF_PROMISC) {
+		rx_mode |= RTASE_ACCEPT_MULTICAST | RTASE_ACCEPT_ALLPHYS;
+	} else if (dev->flags & IFF_ALLMULTI) {
+		rx_mode |= RTASE_ACCEPT_MULTICAST;
+	} else {
+		struct netdev_hw_addr *hw_addr;
+
+		mc_filter[0] = 0;
+		mc_filter[1] = 0;
+
+		netdev_for_each_mc_addr(hw_addr, dev) {
+			u32 bit_nr = eth_hw_addr_crc(hw_addr);
+			u32 idx = u32_get_bits(bit_nr, BIT(31));
+			u32 bit = u32_get_bits(bit_nr,
+					       RTASE_MULTICAST_FILTER_MASK);
+
+			mc_filter[idx] |= BIT(bit);
+			rx_mode |= RTASE_ACCEPT_MULTICAST;
+		}
+	}
+
+	if (dev->features & NETIF_F_RXALL)
+		rx_mode |= RTASE_ACCEPT_ERR | RTASE_ACCEPT_RUNT;
+
+	rtase_w32(tp, RTASE_MAR0, swab32(mc_filter[1]));
+	rtase_w32(tp, RTASE_MAR1, swab32(mc_filter[0]));
+	rtase_w16(tp, RTASE_RX_CONFIG_0, rx_mode);
+}
+
 static void rtase_irq_dis_and_clear(const struct rtase_private *tp)
 {
 	const struct rtase_int_vector *ivec = &tp->int_vector[0];
@@ -547,6 +677,114 @@ static void rtase_hw_reset(const struct net_device *dev)
 	rtase_nic_reset(dev);
 }
 
+static void rtase_set_rx_queue(const struct rtase_private *tp)
+{
+	u16 reg_data;
+
+	reg_data = rtase_r16(tp, RTASE_FCR);
+	switch (tp->func_rx_queue_num) {
+	case 1:
+		u16p_replace_bits(&reg_data, 0x1, RTASE_FCR_RXQ_MASK);
+		break;
+	case 2:
+		u16p_replace_bits(&reg_data, 0x2, RTASE_FCR_RXQ_MASK);
+		break;
+	case 4:
+		u16p_replace_bits(&reg_data, 0x3, RTASE_FCR_RXQ_MASK);
+		break;
+	}
+	rtase_w16(tp, RTASE_FCR, reg_data);
+}
+
+static void rtase_set_tx_queue(const struct rtase_private *tp)
+{
+	u16 reg_data;
+
+	reg_data = rtase_r16(tp, RTASE_TX_CONFIG_1);
+	switch (tp->tx_queue_ctrl) {
+	case 1:
+		u16p_replace_bits(&reg_data, 0x0, RTASE_TC_MODE_MASK);
+		break;
+	case 2:
+		u16p_replace_bits(&reg_data, 0x1, RTASE_TC_MODE_MASK);
+		break;
+	case 3:
+	case 4:
+		u16p_replace_bits(&reg_data, 0x2, RTASE_TC_MODE_MASK);
+		break;
+	default:
+		u16p_replace_bits(&reg_data, 0x3, RTASE_TC_MODE_MASK);
+		break;
+	}
+	rtase_w16(tp, RTASE_TX_CONFIG_1, reg_data);
+}
+
+static void rtase_hw_config(struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u32 reg_data32;
+	u16 reg_data16;
+
+	rtase_hw_reset(dev);
+
+	/* set rx dma burst */
+	reg_data16 = rtase_r16(tp, RTASE_RX_CONFIG_0);
+	reg_data16 &= ~(RTASE_RX_SINGLE_TAG | RTASE_RX_SINGLE_FETCH);
+	u16p_replace_bits(&reg_data16, RTASE_RX_DMA_BURST_256,
+			  RTASE_RX_MX_DMA_MASK);
+	rtase_w16(tp, RTASE_RX_CONFIG_0, reg_data16);
+
+	/* new rx descritpor */
+	reg_data16 = rtase_r16(tp, RTASE_RX_CONFIG_1);
+	reg_data16 |= RTASE_RX_NEW_DESC_FORMAT_EN | RTASE_PCIE_NEW_FLOW;
+	u16p_replace_bits(&reg_data16, 0xF, RTASE_RX_MAX_FETCH_DESC_MASK);
+	rtase_w16(tp, RTASE_RX_CONFIG_1, reg_data16);
+
+	rtase_set_rx_queue(tp);
+
+	rtase_interrupt_mitigation(tp);
+
+	/* set tx dma burst size and interframe gap time */
+	reg_data32 = rtase_r32(tp, RTASE_TX_CONFIG_0);
+	u32p_replace_bits(&reg_data32, RTASE_TX_DMA_BURST_UNLIMITED,
+			  RTASE_TX_DMA_MASK);
+	u32p_replace_bits(&reg_data32, RTASE_INTERFRAMEGAP,
+			  RTASE_TX_INTER_FRAME_GAP_MASK);
+	rtase_w32(tp, RTASE_TX_CONFIG_0, reg_data32);
+
+	/* new tx descriptor */
+	reg_data16 = rtase_r16(tp, RTASE_TFUN_CTRL);
+	rtase_w16(tp, RTASE_TFUN_CTRL, reg_data16 |
+		  RTASE_TX_NEW_DESC_FORMAT_EN);
+
+	/* tx fetch desc number */
+	rtase_w8(tp, RTASE_TDFNR, 0x10);
+
+	/* tag num select */
+	reg_data16 = rtase_r16(tp, RTASE_MTPS);
+	u16p_replace_bits(&reg_data16, 0x4, RTASE_TAG_NUM_SEL_MASK);
+	rtase_w16(tp, RTASE_MTPS, reg_data16);
+
+	rtase_set_tx_queue(tp);
+
+	rtase_w16(tp, RTASE_TOKSEL, 0x5555);
+
+	rtase_tally_counter_addr_fill(tp);
+	rtase_desc_addr_fill(tp);
+	rtase_hw_set_features(dev, dev->features);
+
+	/* enable flow control */
+	reg_data16 = rtase_r16(tp, RTASE_CPLUS_CMD);
+	reg_data16 |= (RTASE_FORCE_TXFLOW_EN | RTASE_FORCE_RXFLOW_EN);
+	rtase_w16(tp, RTASE_CPLUS_CMD, reg_data16);
+	/* set near fifo threshold - rx missed issue. */
+	rtase_w16(tp, RTASE_RFIFONFULL, 0x190);
+
+	rtase_w16(tp, RTASE_RMS, tp->rx_buf_sz);
+
+	rtase_hw_set_rx_packet_filter(dev);
+}
+
 static void rtase_nic_enable(const struct net_device *dev)
 {
 	const struct rtase_private *tp = netdev_priv(dev);
-- 
2.34.1


