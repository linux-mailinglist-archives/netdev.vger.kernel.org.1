Return-Path: <netdev+bounces-117590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6195594E6E6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12701F23473
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B0A1537D0;
	Mon, 12 Aug 2024 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wwnuG9Rk"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D068152199;
	Mon, 12 Aug 2024 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444821; cv=none; b=F/zrVsL9uREGq3/Bv8pYdqR3Fj1IdExxIkwLFPB3dZS4RQXJOz0kxPd/dT57OvQYBDTKb0pihhFogxlRjdRREiPQ2NXM7QDtsyEdXhV0sE5fMTj1+afmsrkpEHU8tSyMloOJoIb1hkIHgmg4QsrdPn8Pu9KNPFqZnbbopM7fsAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444821; c=relaxed/simple;
	bh=+6VvshhWzazK5tNuMzDKpyBsNpOQOfWAzV7Yvb9+/H4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtncWn+yj8Ma63NlBmjwxKNWb/6eVzhDccmQGyVOd293J4QLu8FHgXFxjfrzyqbl0lkMc+yxqTVRihGuxr5sWemxw7r/kWyOlHYrPlX7PhFkdsW9QUIwRkQsgXOt7xm2mZK131AeRrVD4vva3TJnX8myJ3PCtQafxAK0SGtIxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wwnuG9Rk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47C6duKB33756969, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723444796; bh=+6VvshhWzazK5tNuMzDKpyBsNpOQOfWAzV7Yvb9+/H4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wwnuG9RkBm2eJv6jFOKLjOcsAPmnXWv1pIoPxPUZ8WkAZkgp4taXxDi8bFsozYxfm
	 xsu6FZh2ad56VdY2r2I3vKKw0DgUXuCgwGrctEzvIry/VEjFjdoRxWi8kn+bY0Q6VI
	 SW1i/vbiwzoDfPPe3LdNSOB+vL8rA06AptlK5beLASdbGWCxLY/V9jbd2BfuBPVKDD
	 ZX6tEYZ3KcC+YEChtQ9XV32au9739suUB+yawq2Vaf/OsMIt9w92eithPHVy2WX3IT
	 TwERKEXbN8ey8IF4frxyBwqWFZZxiUuUwKitFUWD1ab47HqN/iaagENLNBBJh2pgdy
	 yh5l8K+8mavRA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47C6duKB33756969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 14:39:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 14:39:56 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 12 Aug
 2024 14:39:56 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v27 08/13] rtase: Implement net_device_ops
Date: Mon, 12 Aug 2024 14:35:34 +0800
Message-ID: <20240812063539.575865-9-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812063539.575865-1-justinlai0215@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
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
index 561fcaeb2b2b..b8569924248f 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1424,6 +1424,11 @@ static netdev_tx_t rtase_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static void rtase_set_rx_mode(struct net_device *dev)
+{
+	rtase_hw_set_rx_packet_filter(dev);
+}
+
 static void rtase_enable_eem_write(const struct rtase_private *tp)
 {
 	u8 val;
@@ -1456,10 +1461,240 @@ static void rtase_rar_set(const struct rtase_private *tp, const u8 *addr)
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


