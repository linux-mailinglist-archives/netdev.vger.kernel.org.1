Return-Path: <netdev+bounces-113511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9557493ED61
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489F0282AAF
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 06:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B61B84A2B;
	Mon, 29 Jul 2024 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kqfJkDim"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46B82877;
	Mon, 29 Jul 2024 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234336; cv=none; b=q3kzdD4v5D68fEszL4y0ReyMkG+IFtWxQ2p3nep2Jhvfad1f6LDgjKs5Wkt/yn9eZ6EP/xY9J0DI30uz31k0YTjNpBtozjRssyKSvObKYmQSQPIzqv1Akg3Sfe4iXue7YftZIR3ZeUO87LdpliID17tTZBj/XSdLJuwJZKnCcmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234336; c=relaxed/simple;
	bh=dOojlkON4XUTm2E1oOPBzIvBdWSXyHrC7rUX4X0G2y4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVHrf6Qq+uhGLc5s9dda5uchZ2QCXN0D1ZgpQa5bpDcF309G7BjZ+PFfhlYaln0odMxnVNKl3L6dSAWXqGvBYE1qmhgN8CKTxRYeaYpqAMm/vbSk29saoLxVwq/YHAMR/ckgrGF4d8lCQtB/sHqFBxpKnFzsRQ8ez8xYho2LUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kqfJkDim; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46T6PCHs83600273, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722234312; bh=dOojlkON4XUTm2E1oOPBzIvBdWSXyHrC7rUX4X0G2y4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kqfJkDimAza8zwyhB/JTPBKENNsLD5M/Opcs6jVMpVl+rLql3i7Ru1nX7nQZJsERl
	 aOa9lfFD64tIPiBZk+JY+IuChMhY6JVjfRHPcWXK4MnrY+I5B6cq/PZNZrWVQspKF0
	 HEwr8y97+93Lpb24VoYkgMkFaBkyh5SobSPrjs2588Mq2XcP0XE/TCKcrmJ0ffcgv7
	 umB5Egv5a+LLlKIBQ7EVcJcY+6B5A6Jk5Hupk0xOsBf4ss2selhUmnLLbkuShmWoiF
	 hqXPXCOw2wyLL9gj6BU8QIc9cXi7YEnpT4CQtc3VUJ2DsSaWuGgLmTRYxxUXz9RpMu
	 YHOxXiRFh6eiA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46T6PCHs83600273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 14:25:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 14:25:12 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Jul
 2024 14:25:11 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v25 08/13] rtase: Implement net_device_ops
Date: Mon, 29 Jul 2024 14:21:16 +0800
Message-ID: <20240729062121.335080-9-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729062121.335080-1-justinlai0215@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
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

1. Implement .ndo_set_rx_mode so that the device can change address
list filtering.
2. Implement .ndo_set_mac_address so that mac address can be changed.
3. Implement .ndo_change_mtu so that mtu can be changed.
4. Implement .ndo_tx_timeout to perform related processing when the
transmitter does not make any progress.
5. Implement .ndo_get_stats64 to provide statistics that are called
when the user wants to get network device usage.
6. Implement .ndo_vlan_rx_add_vid to register VLAN ID when the device
supports VLAN filtering.
7. Implement .ndo_vlan_rx_kill_vid to unregister VLAN ID when the device
supports VLAN filtering.
8. Implement the .ndo_setup_tc to enable setting any "tc" scheduler,
classifier or action on dev.
9. Implement .ndo_fix_features enables adjusting requested feature flags
based on device-specific constraints.
10. Implement .ndo_set_features enables updating device configuration to
new features.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 8fd69d96219f..80673fa1e9a3 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1433,6 +1433,11 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_BUSY;
 }
 
+static void rtase_set_rx_mode(struct net_device *dev)
+{
+	rtase_hw_set_rx_packet_filter(dev);
+}
+
 static void rtase_enable_eem_write(const struct rtase_private *tp)
 {
 	u8 val;
@@ -1465,10 +1470,240 @@ static void rtase_rar_set(const struct rtase_private *tp, const u8 *addr)
 	rtase_w16(tp, RTASE_LBK_CTRL, RTASE_LBK_ATLD | RTASE_LBK_CLR);
 }
 
+static int rtase_set_mac_address(struct net_device *dev, void *p)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	int ret;
+
+	ret = eth_mac_addr(dev, p);
+	if (ret)
+		return ret;
+
+	rtase_rar_set(tp, dev->dev_addr);
+
+	return 0;
+}
+
+static int rtase_change_mtu(struct net_device *dev, int new_mtu)
+{
+	dev->mtu = new_mtu;
+
+	netdev_update_features(dev);
+
+	return 0;
+}
+
+static void rtase_wait_for_quiescence(const struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec;
+	u32 i;
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		synchronize_irq(ivec->irq);
+		/* wait for any pending NAPI task to complete */
+		napi_disable(&ivec->napi);
+	}
+
+	rtase_irq_dis_and_clear(tp);
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		napi_enable(&ivec->napi);
+	}
+}
+
+static void rtase_sw_reset(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	int ret;
+
+	netif_stop_queue(dev);
+	netif_carrier_off(dev);
+	rtase_hw_reset(dev);
+
+	/* let's wait a bit while any (async) irq lands on */
+	rtase_wait_for_quiescence(dev);
+	rtase_tx_clear(tp);
+	rtase_rx_clear(tp);
+
+	ret = rtase_init_ring(dev);
+	if (ret) {
+		netdev_err(dev, "unable to init ring\n");
+		rtase_free_desc(tp);
+		return;
+	}
+
+	rtase_hw_config(dev);
+	/* always link, so start to transmit & receive */
+	rtase_hw_start(dev);
+
+	netif_carrier_on(dev);
+	netif_wake_queue(dev);
+}
+
+static void rtase_dump_tally_counter(const struct rtase_private *tp)
+{
+	dma_addr_t paddr = tp->tally_paddr;
+	u32 cmd = lower_32_bits(paddr);
+	u32 val;
+	int err;
+
+	rtase_w32(tp, RTASE_DTCCR4, upper_32_bits(paddr));
+	rtase_w32(tp, RTASE_DTCCR0, cmd);
+	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_DUMP);
+
+	err = read_poll_timeout(rtase_r32, val, !(val & RTASE_COUNTER_DUMP),
+				10, 250, false, tp, RTASE_DTCCR0);
+
+	if (err == -ETIMEDOUT)
+		netdev_err(tp->dev, "error occurred in dump tally counter\n");
+}
+
+static void rtase_dump_state(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	int max_reg_size = RTASE_PCI_REGS_SIZE;
+	const struct rtase_counters *counters;
+	const struct rtase_ring *ring;
+	u32 dword_rd;
+	int n = 0;
+
+	ring = &tp->tx_ring[0];
+	netdev_err(dev, "Tx descriptor info:\n");
+	netdev_err(dev, "Tx curIdx = 0x%x\n", ring->cur_idx);
+	netdev_err(dev, "Tx dirtyIdx = 0x%x\n", ring->dirty_idx);
+	netdev_err(dev, "Tx phyAddr = %pad\n", &ring->phy_addr);
+
+	ring = &tp->rx_ring[0];
+	netdev_err(dev, "Rx descriptor info:\n");
+	netdev_err(dev, "Rx curIdx = 0x%x\n", ring->cur_idx);
+	netdev_err(dev, "Rx dirtyIdx = 0x%x\n", ring->dirty_idx);
+	netdev_err(dev, "Rx phyAddr = %pad\n", &ring->phy_addr);
+
+	netdev_err(dev, "Device Registers:\n");
+	netdev_err(dev, "Chip Command = 0x%02x\n",
+		   rtase_r8(tp, RTASE_CHIP_CMD));
+	netdev_err(dev, "IMR = %08x\n", rtase_r32(tp, RTASE_IMR0));
+	netdev_err(dev, "ISR = %08x\n", rtase_r32(tp, RTASE_ISR0));
+	netdev_err(dev, "Boot Ctrl Reg(0xE004) = %04x\n",
+		   rtase_r16(tp, RTASE_BOOT_CTL));
+	netdev_err(dev, "EPHY ISR(0xE014) = %04x\n",
+		   rtase_r16(tp, RTASE_EPHY_ISR));
+	netdev_err(dev, "EPHY IMR(0xE016) = %04x\n",
+		   rtase_r16(tp, RTASE_EPHY_IMR));
+	netdev_err(dev, "CLKSW SET REG(0xE018) = %04x\n",
+		   rtase_r16(tp, RTASE_CLKSW_SET));
+
+	netdev_err(dev, "Dump PCI Registers:\n");
+
+	while (n < max_reg_size) {
+		if ((n % RTASE_DWORD_MOD) == 0)
+			netdev_err(tp->dev, "0x%03x:\n", n);
+
+		pci_read_config_dword(tp->pdev, n, &dword_rd);
+		netdev_err(tp->dev, "%08x\n", dword_rd);
+		n += 4;
+	}
+
+	netdev_err(dev, "Dump tally counter:\n");
+	counters = tp->tally_vaddr;
+	rtase_dump_tally_counter(tp);
+
+	netdev_err(dev, "tx_packets %lld\n",
+		   le64_to_cpu(counters->tx_packets));
+	netdev_err(dev, "rx_packets %lld\n",
+		   le64_to_cpu(counters->rx_packets));
+	netdev_err(dev, "tx_errors %lld\n",
+		   le64_to_cpu(counters->tx_errors));
+	netdev_err(dev, "rx_errors %d\n",
+		   le32_to_cpu(counters->rx_errors));
+	netdev_err(dev, "rx_missed %d\n",
+		   le16_to_cpu(counters->rx_missed));
+	netdev_err(dev, "align_errors %d\n",
+		   le16_to_cpu(counters->align_errors));
+	netdev_err(dev, "tx_one_collision %d\n",
+		   le32_to_cpu(counters->tx_one_collision));
+	netdev_err(dev, "tx_multi_collision %d\n",
+		   le32_to_cpu(counters->tx_multi_collision));
+	netdev_err(dev, "rx_unicast %lld\n",
+		   le64_to_cpu(counters->rx_unicast));
+	netdev_err(dev, "rx_broadcast %lld\n",
+		   le64_to_cpu(counters->rx_broadcast));
+	netdev_err(dev, "rx_multicast %d\n",
+		   le32_to_cpu(counters->rx_multicast));
+	netdev_err(dev, "tx_aborted %d\n",
+		   le16_to_cpu(counters->tx_aborted));
+	netdev_err(dev, "tx_underun %d\n",
+		   le16_to_cpu(counters->tx_underun));
+}
+
+static void rtase_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	rtase_dump_state(dev);
+	rtase_sw_reset(dev);
+}
+
+static void rtase_get_stats64(struct net_device *dev,
+			      struct rtnl_link_stats64 *stats)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	const struct rtase_counters *counters;
+
+	counters = tp->tally_vaddr;
+
+	dev_fetch_sw_netstats(stats, dev->tstats);
+
+	/* fetch additional counter values missing in stats collected by driver
+	 * from tally counter
+	 */
+	rtase_dump_tally_counter(tp);
+	stats->rx_errors = tp->stats.rx_errors;
+	stats->tx_errors = le64_to_cpu(counters->tx_errors);
+	stats->rx_dropped = tp->stats.rx_dropped;
+	stats->tx_dropped = tp->stats.tx_dropped;
+	stats->multicast = tp->stats.multicast;
+	stats->rx_length_errors = tp->stats.rx_length_errors;
+}
+
+static netdev_features_t rtase_fix_features(struct net_device *dev,
+					    netdev_features_t features)
+{
+	netdev_features_t features_fix = features;
+
+	/* not support TSO for jumbo frames */
+	if (dev->mtu > ETH_DATA_LEN)
+		features_fix &= ~NETIF_F_ALL_TSO;
+
+	return features_fix;
+}
+
+static int rtase_set_features(struct net_device *dev,
+			      netdev_features_t features)
+{
+	netdev_features_t features_set = features;
+
+	features_set &= NETIF_F_RXALL | NETIF_F_RXCSUM |
+			NETIF_F_HW_VLAN_CTAG_RX;
+
+	if (features_set ^ dev->features)
+		rtase_hw_set_features(dev, features_set);
+
+	return 0;
+}
+
 static const struct net_device_ops rtase_netdev_ops = {
 	.ndo_open = rtase_open,
 	.ndo_stop = rtase_close,
 	.ndo_start_xmit = rtase_start_xmit,
+	.ndo_set_rx_mode = rtase_set_rx_mode,
+	.ndo_set_mac_address = rtase_set_mac_address,
+	.ndo_change_mtu = rtase_change_mtu,
+	.ndo_tx_timeout = rtase_tx_timeout,
+	.ndo_get_stats64 = rtase_get_stats64,
+	.ndo_fix_features = rtase_fix_features,
+	.ndo_set_features = rtase_set_features,
 };
 
 static void rtase_get_mac_address(struct net_device *dev)
-- 
2.34.1


