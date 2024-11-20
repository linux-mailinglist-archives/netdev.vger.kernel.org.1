Return-Path: <netdev+bounces-146479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 363019D392A
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 12:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF8BFB2C134
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED4B1A42D8;
	Wed, 20 Nov 2024 11:02:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-19.us.a.mail.aliyun.com (out198-19.us.a.mail.aliyun.com [47.90.198.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C421A3BC3;
	Wed, 20 Nov 2024 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100539; cv=none; b=JUerqMKpByP6Wl2kTldce85DcreWCAX6D6hM6fqiCUysi4zeA+95TNmzIOKos6czDfjr6h78xPlDWlJQ0aMbojBUy177hYS2p7xetgnDpV+69EqdOyHQfHs16N/uOpQ2OcR8z11fFyh1xdjtkookVBAD+WbeiB2ICLOsnC7RA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100539; c=relaxed/simple;
	bh=LrjQk+wAmfmrNp1l/7ZNByErxg6B2w8Q19HTgAo1tc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=btz8jxmJq2nu9yFJWsDuFiRYuQBecwDMegpZOOyQw9mHoC/E/V/j/VxOBWHMdhwQjfDwhonCUHHEezbILOKHJObbjCt48b4Kd2JVpeX6ggMjYKtY6ksr6lNS1aEyWzH2amtbmAII6EupWdnRFCyUIc2jJm+RuWBLbFsRCcAaauk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppcq_1732100205 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:46 +0800
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
Subject: [PATCH net-next v2 14/21] motorcomm:yt6801: Implement the WOL function of ethtool_ops
Date: Wed, 20 Nov 2024 18:56:18 +0800
Message-Id: <20241120105625.22508-15-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the .get_wol and .set_wol callback function.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../motorcomm/yt6801/yt6801_ethtool.c         | 169 +++++
 .../net/ethernet/motorcomm/yt6801/yt6801_hw.c | 576 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 118 ++++
 3 files changed, 863 insertions(+)

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c
index 7989ccbc3..af643a16a 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c
@@ -565,6 +565,173 @@ static int fxgmac_set_ringparam(struct net_device *netdev,
 	return ret;
 }
 
+static void fxgmac_get_wol(struct net_device *netdev,
+			   struct ethtool_wolinfo *wol)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	wol->supported = WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_MAGIC |
+			 WAKE_ARP | WAKE_PHY;
+
+	wol->wolopts = 0;
+	if (!(pdata->hw_feat.rwk) || !device_can_wakeup(pdata->dev)) {
+		yt_err(pdata, "%s, pci does not support wakeup.\n", __func__);
+		return;
+	}
+
+	wol->wolopts = pdata->wol;
+}
+
+#pragma pack(1)
+/* it's better to make this struct's size to 128byte. */
+struct pattern_packet {
+	u8 ether_daddr[ETH_ALEN];
+	u8 ether_saddr[ETH_ALEN];
+	u16 ether_type;
+
+	__be16 ar_hrd;		/* format of hardware address  */
+	__be16 ar_pro;		/* format of protocol          */
+	u8 ar_hln;		/* length of hardware address  */
+	u8 ar_pln;		/* length of protocol address  */
+	__be16 ar_op;		/* ARP opcode (command)        */
+	u8 ar_sha[ETH_ALEN];	/* sender hardware address     */
+	u8 ar_sip[4];		/* sender IP address           */
+	u8 ar_tha[ETH_ALEN];	/* target hardware address     */
+	u8 ar_tip[4];		/* target IP address           */
+
+	u8 reverse[86];
+};
+
+#pragma pack()
+
+static int fxgmac_set_pattern_data(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	u8 type_offset, tip_offset, op_offset;
+	struct wol_bitmap_pattern pattern[4];
+	struct pattern_packet packet;
+	u32 ip_addr, i = 0;
+
+	memset(pattern, 0, sizeof(struct wol_bitmap_pattern) * 4);
+
+	/* Config ucast */
+	if (pdata->wol & WAKE_UCAST) {
+		pattern[i].mask_info[0] = 0x3F;
+		pattern[i].mask_size = sizeof(pattern[0].mask_info);
+		memcpy(pattern[i].pattern_info, pdata->mac_addr, ETH_ALEN);
+		pattern[i].pattern_offset = 0;
+		i++;
+	}
+
+	/* Config bcast */
+	if (pdata->wol & WAKE_BCAST) {
+		pattern[i].mask_info[0] = 0x3F;
+		pattern[i].mask_size = sizeof(pattern[0].mask_info);
+		memset(pattern[i].pattern_info, 0xFF, ETH_ALEN);
+		pattern[i].pattern_offset = 0;
+		i++;
+	}
+
+	/* Config mcast */
+	if (pdata->wol & WAKE_MCAST) {
+		pattern[i].mask_info[0] = 0x7;
+		pattern[i].mask_size = sizeof(pattern[0].mask_info);
+		pattern[i].pattern_info[0] = 0x1;
+		pattern[i].pattern_info[1] = 0x0;
+		pattern[i].pattern_info[2] = 0x5E;
+		pattern[i].pattern_offset = 0;
+		i++;
+	}
+
+	/* Config arp */
+	if (pdata->wol & WAKE_ARP) {
+		memset(pattern[i].mask_info, 0, sizeof(pattern[0].mask_info));
+		type_offset = offsetof(struct pattern_packet, ar_pro);
+		pattern[i].mask_info[type_offset / 8] |= 1 << type_offset % 8;
+		type_offset++;
+		pattern[i].mask_info[type_offset / 8] |= 1 << type_offset % 8;
+		op_offset = offsetof(struct pattern_packet, ar_op);
+		pattern[i].mask_info[op_offset / 8] |= 1 << op_offset % 8;
+		op_offset++;
+		pattern[i].mask_info[op_offset / 8] |= 1 << op_offset % 8;
+		tip_offset = offsetof(struct pattern_packet, ar_tip);
+		pattern[i].mask_info[tip_offset / 8] |= 1 << tip_offset % 8;
+		tip_offset++;
+		pattern[i].mask_info[tip_offset / 8] |= 1 << type_offset % 8;
+		tip_offset++;
+		pattern[i].mask_info[tip_offset / 8] |= 1 << type_offset % 8;
+		tip_offset++;
+		pattern[i].mask_info[tip_offset / 8] |= 1 << type_offset % 8;
+
+		packet.ar_pro = 0x0 << 8 | 0x08;
+		/* ARP type is 0x0800, notice that ar_pro and ar_op is
+		 * big endian
+		 */
+		packet.ar_op = 0x1 << 8;
+		/* 1 is arp request,2 is arp replay, 3 is rarp request,
+		 * 4 is rarp replay
+		 */
+		ip_addr = fxgmac_get_netdev_ip4addr(pdata);
+		packet.ar_tip[0] = ip_addr & 0xFF;
+		packet.ar_tip[1] = (ip_addr >> 8) & 0xFF;
+		packet.ar_tip[2] = (ip_addr >> 16) & 0xFF;
+		packet.ar_tip[3] = (ip_addr >> 24) & 0xFF;
+		memcpy(pattern[i].pattern_info, &packet, MAX_PATTERN_SIZE);
+		pattern[i].mask_size = sizeof(pattern[0].mask_info);
+		pattern[i].pattern_offset = 0;
+		i++;
+	}
+
+	return hw_ops->set_wake_pattern(pdata, pattern, i);
+}
+
+static int fxgmac_set_wol(struct net_device *netdev,
+			  struct ethtool_wolinfo *wol)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	int ret;
+
+	if (wol->wolopts & (WAKE_MAGICSECURE | WAKE_FILTER)) {
+		yt_err(pdata, "%s, not supported wol options, 0x%x\n", __func__,
+		       wol->wolopts);
+		return -EOPNOTSUPP;
+	}
+
+	if (!(pdata->hw_feat.rwk)) {
+		yt_err(pdata, "%s, hw wol feature is n/a\n", __func__);
+		return wol->wolopts ? -EOPNOTSUPP : 0;
+	}
+
+	pdata->wol = 0;
+	if (wol->wolopts & WAKE_UCAST)
+		pdata->wol |= WAKE_UCAST;
+
+	if (wol->wolopts & WAKE_MCAST)
+		pdata->wol |= WAKE_MCAST;
+
+	if (wol->wolopts & WAKE_BCAST)
+		pdata->wol |= WAKE_BCAST;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		pdata->wol |= WAKE_MAGIC;
+
+	if (wol->wolopts & WAKE_PHY)
+		pdata->wol |= WAKE_PHY;
+
+	if (wol->wolopts & WAKE_ARP)
+		pdata->wol |= WAKE_ARP;
+
+	ret = fxgmac_set_pattern_data(pdata);
+	if (ret < 0)
+		return ret;
+
+	ret = fxgmac_config_wol(pdata, (!!(pdata->wol)));
+	yt_dbg(pdata, "%s, opt=0x%x, wol=0x%x\n", __func__, wol->wolopts,
+	       pdata->wol);
+
+	return ret;
+}
+
 static int fxgmac_get_regs_len(struct net_device __always_unused *netdev)
 {
 	return FXGMAC_PHY_REG_CNT * sizeof(u32);
@@ -725,6 +892,8 @@ static const struct ethtool_ops fxgmac_ethtool_ops = {
 	.get_rxfh_key_size		= fxgmac_get_rxfh_key_size,
 	.get_rxfh			= fxgmac_get_rxfh,
 	.set_rxfh			= fxgmac_set_rxfh,
+	.get_wol			= fxgmac_get_wol,
+	.set_wol			= fxgmac_set_wol,
 	.nway_reset			= phy_ethtool_nway_reset,
 	.get_link_ksettings		= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings		= phy_ethtool_set_link_ksettings,
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
index a70fa4ede..bd3036625 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
@@ -1399,6 +1399,187 @@ static void fxgmac_config_rss(struct fxgmac_pdata *pdata)
 		fxgmac_disable_rss(pdata);
 }
 
+static void fxgmac_update_aoe_ipv4addr(struct fxgmac_pdata *pdata, u8 *ip_addr)
+{
+	u32 val, ipval = 0;
+
+	if (ip_addr) {
+		ipval = (ip_addr[0] << 24) | (ip_addr[1] << 16) |
+			(ip_addr[2] << 8) | (ip_addr[3] << 0);
+		yt_dbg(pdata,
+		       "%s, covert IP dotted-addr %s to binary 0x%08x ok.\n",
+		       __func__, ip_addr, cpu_to_be32(ipval));
+	} else {
+		/* Get ipv4 addr from net device */
+		ipval = fxgmac_get_netdev_ip4addr(pdata);
+		yt_dbg(pdata, "%s, Get net device binary IP ok, 0x%08x\n",
+		       __func__, cpu_to_be32(ipval));
+
+		ipval = cpu_to_be32(ipval);
+	}
+
+	val = rd32_mac(pdata, MAC_ARP_PROTO_ADDR);
+	if (val != (ipval)) {
+		wr32_mac(pdata, ipval, MAC_ARP_PROTO_ADDR);
+		yt_dbg(pdata,
+		       "%s, update arp ipaddr reg from 0x%08x to 0x%08x\n",
+		       __func__, val, ipval);
+	}
+}
+
+static void fxgmac_enable_arp_offload(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_ARPEN_POS, MAC_CR_ARPEN_LEN, 1);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_disable_arp_offload(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_ARPEN_POS, MAC_CR_ARPEN_LEN, 0);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+/**
+ * fxgmac_set_ns_offload - config register for NS offload function
+ * @pdata: board private structure
+ * @index: 0~1, index to NS look up table. one entry of the lut is like
+ *   this |remote|solicited|target0|target1|
+ * @remote_addr: ipv6 addr where yt6801 gets the NS solicitation pkt(request).
+ *   in common, it is 0 to match any remote machine.
+ * @solicited_addr: the solicited node multicast group address which
+ *   yt6801 computes and joins.
+ * @target_addr1: it is the target address in NS solicitation pkt.
+ * @target_addr2:second target address, any address (with ast 6B same with
+ *  target address)
+ * @mac_addr: it is the target address in NS solicitation pkt.
+ */
+static void
+fxgmac_set_ns_offload(struct fxgmac_pdata *pdata, unsigned int index,
+		      unsigned char *remote_addr, unsigned char *solicited_addr,
+		      unsigned char *target_addr1, unsigned char *target_addr2,
+		      unsigned char *mac_addr)
+{
+	u32 base = (NS_LUT_MAC_ADDR_CTL - NS_LUT_ROMOTE0 + 4) * index;
+	u32 address[4], mac_hi, mac_lo;
+	u8 remote_not_zero = 0;
+	u32 val;
+
+	val = rd32_mem(pdata, NS_TPID_PRO);
+	fxgmac_set_bits(&val, NS_TPID_PRO_STPID_POS, NS_TPID_PRO_STPID_LEN,
+			0X8100);
+	fxgmac_set_bits(&val, NS_TPID_PRO_CTPID_POS, NS_TPID_PRO_CTPID_LEN,
+			0X9100);
+	wr32_mem(pdata, val, NS_TPID_PRO);
+
+	val = rd32_mem(pdata, base + NS_LUT_MAC_ADDR_CTL);
+	fxgmac_set_bits(&val, NS_LUT_DST_CMP_TYPE_POS, NS_LUT_DST_CMP_TYPE_LEN,
+			1);
+	fxgmac_set_bits(&val, NS_LUT_DST_IGNORED_POS, NS_LUT_DST_IGNORED_LEN,
+			1);
+	fxgmac_set_bits(&val, NS_LUT_REMOTE_AWARED_POS,
+			NS_LUT_REMOTE_AWARED_LEN, 1);
+	fxgmac_set_bits(&val, NS_LUT_TARGET_ISANY_POS, NS_LUT_TARGET_ISANY_LEN,
+			0);
+	wr32_mem(pdata, val, base + NS_LUT_MAC_ADDR_CTL);
+
+	for (u32 i = 0; i < 16 / 4; i++) {
+		address[i] = (remote_addr[i * 4 + 0] << 24) |
+			     (remote_addr[i * 4 + 1] << 16) |
+			     (remote_addr[i * 4 + 2] << 8) |
+			     (remote_addr[i * 4 + 3] << 0);
+		wr32_mem(pdata, address[i], base + NS_LUT_ROMOTE0 + 4 * i);
+		if (address[i])
+			remote_not_zero = 1;
+
+		address[i] = (target_addr1[i * 4 + 0] << 24) |
+			     (target_addr1[i * 4 + 1] << 16) |
+			     (target_addr1[i * 4 + 2] << 8) |
+			     (target_addr1[i * 4 + 3] << 0);
+		wr32_mem(pdata, address[i], base + NS_LUT_TARGET0 + 4 * i);
+		address[i] = (solicited_addr[i * 4 + 0] << 24) |
+			     (solicited_addr[i * 4 + 1] << 16) |
+			     (solicited_addr[i * 4 + 2] << 8) |
+			     (solicited_addr[i * 4 + 3] << 0);
+		wr32_mem(pdata, address[i], base + NS_LUT_SOLICITED0 + 4 * i);
+		address[i] = (target_addr2[i * 4 + 0] << 24) |
+			     (target_addr2[i * 4 + 1] << 16) |
+			     (target_addr2[i * 4 + 2] << 8) |
+			     (target_addr2[i * 4 + 3] << 0);
+		wr32_mem(pdata, address[i],
+			 0X10 * index + NS_LUT_TARGET4 + 4 * i);
+	}
+	mac_hi = (mac_addr[0] << 24) | (mac_addr[1] << 16) |
+		      (mac_addr[2] << 8) | (mac_addr[3] << 0);
+	mac_lo = (mac_addr[4] << 8) | (mac_addr[5] << 0);
+	wr32_mem(pdata, mac_hi, base + NS_LUT_MAC_ADDR);
+
+	val = rd32_mem(pdata, base + NS_LUT_MAC_ADDR_CTL);
+	fxgmac_set_bits(&val, NS_LUT_MAC_ADDR_LOW_POS, NS_LUT_MAC_ADDR_LOW_LEN,
+			mac_lo);
+	if (remote_not_zero == 0)
+		fxgmac_set_bits(&val, NS_LUT_REMOTE_AWARED_POS,
+				NS_LUT_REMOTE_AWARED_LEN, 0);
+	else
+		fxgmac_set_bits(&val, NS_LUT_REMOTE_AWARED_POS,
+				NS_LUT_REMOTE_AWARED_LEN, 1);
+	wr32_mem(pdata, val, base + NS_LUT_MAC_ADDR_CTL);
+}
+
+static void fxgmac_update_ns_offload_ipv6addr(struct fxgmac_pdata *pdata,
+					      unsigned int param)
+{
+	struct net_device *netdev = pdata->netdev;
+	unsigned char addr_buf[5][16];
+	static u8 ns_offload_tab_idx;
+	unsigned char *solicited_addr;
+	unsigned char *target_addr1;
+	unsigned char *remote_addr;
+	unsigned char *mac_addr;
+
+	remote_addr = (unsigned char *)&addr_buf[0][0];
+	solicited_addr = (unsigned char *)&addr_buf[1][0];
+	target_addr1 = (unsigned char *)&addr_buf[2][0];
+	mac_addr = (unsigned char *)&addr_buf[4][0];
+
+	param &= (FXGMAC_NS_IFA_LOCAL_LINK | FXGMAC_NS_IFA_GLOBAL_UNICAST);
+	/* Get ipv6 addr from net device */
+	if (fxgmac_get_netdev_ip6addr(pdata, target_addr1, solicited_addr,
+				      param) == NULL) {
+		yt_err(pdata,
+		       "%s, get ipv6 addr with err and ignore NS offload.\n",
+		       __func__);
+		return;
+	}
+
+	yt_dbg(pdata, "%s, IPv6 local-link=%pI6, solicited =%pI6\n", __func__,
+	       target_addr1, solicited_addr);
+
+	memcpy(mac_addr, netdev->dev_addr, netdev->addr_len);
+	yt_dbg(pdata, "ns_tab idx=%d, %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       ns_offload_tab_idx, mac_addr[0], mac_addr[1], mac_addr[2],
+	       mac_addr[3], mac_addr[4], mac_addr[5]);
+
+	memset(remote_addr, 0, 16);
+	fxgmac_set_ns_offload(pdata, ns_offload_tab_idx++, remote_addr,
+			      solicited_addr, target_addr1, target_addr1,
+			      mac_addr);
+
+#define NS_OFFLOAD_TAB_MAX_IDX	2
+	if (ns_offload_tab_idx >= NS_OFFLOAD_TAB_MAX_IDX)
+		ns_offload_tab_idx = 0;
+}
+
+static void fxgmac_enable_ns_offload(struct fxgmac_pdata *pdata)
+{
+	wr32_mem(pdata, 0X00000011, NS_OF_GLB_CTL);
+}
+
 static int fxgmac_check_wake_pattern_fifo_pointer(struct fxgmac_pdata *pdata)
 {
 	u32 val;
@@ -1419,6 +1600,390 @@ static int fxgmac_check_wake_pattern_fifo_pointer(struct fxgmac_pdata *pdata)
 	return 0;
 }
 
+static int fxgmac_set_wake_pattern_mask(struct fxgmac_pdata *pdata,
+					u32 filter_index, u8 register_index,
+					u32 data)
+{
+	const u16 address_offset[16][3] = {
+		{0x1020, 0x1024, 0x1028},
+		{0x102c, 0x1030, 0x1034},
+		{0x1038, 0x103c, 0x1040},
+		{0x1044, 0x1050, 0x1054},
+		{0x1058, 0x105c, 0x1060},
+		{0x1064, 0x1068, 0x106c},
+		{0x1070, 0x1074, 0x1078},
+		{0x107c, 0x1080, 0x1084},
+		{0x1088, 0x108c, 0x1090},
+		{0x1134, 0x113c, 0x1140},
+		{0x1208, 0x1200, 0x1204},
+		{0x1218, 0x1210, 0x1214},
+		{0x1228, 0x1220, 0x1224},
+		{0x1238, 0x1230, 0x1234},
+		{0x1248, 0x1240, 0x1244},
+		{0x1258, 0x1250, 0x1254},
+	};
+	if (filter_index > 15 || register_index > 2) {
+		yt_err(pdata,
+		       "%s, xx is over range, filter:%d, register:0x%x\n",
+		       __func__, filter_index, register_index);
+		return -EINVAL;
+	}
+	wr32_mem(pdata, data, address_offset[filter_index][register_index]);
+	return 0;
+}
+
+union type16 {
+	u16 raw;
+	struct {
+		u16 bit_0 : 1;
+		u16 bit_1 : 1;
+		u16 bit_2 : 1;
+		u16 bit_3 : 1;
+		u16 bit_4 : 1;
+		u16 bit_5 : 1;
+		u16 bit_6 : 1;
+		u16 bit_7 : 1;
+		u16 bit_8 : 1;
+		u16 bit_9 : 1;
+		u16 bit_10 : 1;
+		u16 bit_11 : 1;
+		u16 bit_12 : 1;
+		u16 bit_13 : 1;
+		u16 bit_14 : 1;
+		u16 bit_15 : 1;
+	} bits;
+};
+
+union type8 {
+	u16 raw;
+	struct {
+		u16 bit_0 : 1;
+		u16 bit_1 : 1;
+		u16 bit_2 : 1;
+		u16 bit_3 : 1;
+		u16 bit_4 : 1;
+		u16 bit_5 : 1;
+		u16 bit_6 : 1;
+		u16 bit_7 : 1;
+	} bits;
+};
+
+static u16 wol_crc16(u8 *frame, u16 uslen)
+{
+	union type16 crc, crc_comb;
+	union type8 next_crc, rrpe_data;
+
+	next_crc.raw = 0;
+	crc.raw = 0xffff;
+	for (u32 i = 0; i < uslen; i++) {
+		rrpe_data.raw = frame[i];
+		next_crc.bits.bit_0 = crc.bits.bit_15 ^ rrpe_data.bits.bit_0;
+		next_crc.bits.bit_1 = crc.bits.bit_14 ^ next_crc.bits.bit_0 ^
+				      rrpe_data.bits.bit_1;
+		next_crc.bits.bit_2 = crc.bits.bit_13 ^ next_crc.bits.bit_1 ^
+				      rrpe_data.bits.bit_2;
+		next_crc.bits.bit_3 = crc.bits.bit_12 ^ next_crc.bits.bit_2 ^
+				      rrpe_data.bits.bit_3;
+		next_crc.bits.bit_4 = crc.bits.bit_11 ^ next_crc.bits.bit_3 ^
+				      rrpe_data.bits.bit_4;
+		next_crc.bits.bit_5 = crc.bits.bit_10 ^ next_crc.bits.bit_4 ^
+				      rrpe_data.bits.bit_5;
+		next_crc.bits.bit_6 = crc.bits.bit_9 ^ next_crc.bits.bit_5 ^
+				      rrpe_data.bits.bit_6;
+		next_crc.bits.bit_7 = crc.bits.bit_8 ^ next_crc.bits.bit_6 ^
+				      rrpe_data.bits.bit_7;
+
+		crc_comb.bits.bit_15 = crc.bits.bit_7 ^ next_crc.bits.bit_7;
+		crc_comb.bits.bit_14 = crc.bits.bit_6;
+		crc_comb.bits.bit_13 = crc.bits.bit_5;
+		crc_comb.bits.bit_12 = crc.bits.bit_4;
+		crc_comb.bits.bit_11 = crc.bits.bit_3;
+		crc_comb.bits.bit_10 = crc.bits.bit_2;
+		crc_comb.bits.bit_9 = crc.bits.bit_1 ^ next_crc.bits.bit_0;
+		crc_comb.bits.bit_8 = crc.bits.bit_0 ^ next_crc.bits.bit_1;
+		crc_comb.bits.bit_7 = next_crc.bits.bit_0 ^ next_crc.bits.bit_2;
+		crc_comb.bits.bit_6 = next_crc.bits.bit_1 ^ next_crc.bits.bit_3;
+		crc_comb.bits.bit_5 = next_crc.bits.bit_2 ^ next_crc.bits.bit_4;
+		crc_comb.bits.bit_4 = next_crc.bits.bit_3 ^ next_crc.bits.bit_5;
+		crc_comb.bits.bit_3 = next_crc.bits.bit_4 ^ next_crc.bits.bit_6;
+		crc_comb.bits.bit_2 = next_crc.bits.bit_5 ^ next_crc.bits.bit_7;
+		crc_comb.bits.bit_1 = next_crc.bits.bit_6;
+		crc_comb.bits.bit_0 = next_crc.bits.bit_7;
+		crc.raw = crc_comb.raw;
+	}
+	return crc.raw;
+}
+
+static void __write_filter(struct fxgmac_pdata *pdata, u8 i, u8 n)
+{
+	u8 *mask = &pdata->pattern[i * 4 + n].mask_info[0];
+	u32 val;
+
+	val = (mask[3] & 0x7f << 24) | (mask[2] << 16) | (mask[1] << 8) |
+	      (mask[0] << 0);
+
+	wr32_mac(pdata, val, MAC_RWK_PAC);
+}
+
+static u32 __set_filter_addr_type(struct fxgmac_pdata *pdata, u8 i, u8 n,
+				  u32 total_cnt, u32 pattern_cnt)
+{
+	struct wol_bitmap_pattern *pattern = &pdata->pattern[i * 4 + n];
+	u32 val;
+
+	/* Set filter enable bit. */
+	val = ((i * 4 + n) < total_cnt) ? (0x1 << 8 * n) : 0x0;
+
+	/* Set filter address type, 0- unicast, 1 - multicast. */
+	val |= (i * 4 + n >= total_cnt)		 ? 0x0 :
+	       (i * 4 + n >= pattern_cnt)	 ? (0x1 << (3 + 8 * n)) :
+	       pattern->pattern_offset		 ? 0x0 :
+	       !(pattern->mask_info[0] & 0x01)	 ? 0x0 :
+	       (pattern->pattern_info[0] & 0x01) ? (0x1 << (3 + 8 * n)) :
+							 0x0;
+	return val;
+}
+
+static u32 __wake_pattern_mask_val(struct wol_bitmap_pattern *pattern, u8 n)
+{
+	u8 *mask = &pattern->mask_info[n * 4];
+	u32 val;
+
+	val = ((mask[7] & 0x7f) << (24 + 1)) | (mask[6] << (16 + 1)) |
+	      (mask[5] << (8 + 1)) | (mask[4] << (0 + 1)) |
+	      ((mask[3] & 0x80) >> 7);
+
+	return val;
+}
+
+static int fxgmac_set_wake_pattern(struct fxgmac_pdata *pdata,
+				   struct wol_bitmap_pattern *wol_pattern,
+				   u32 pattern_cnt)
+{
+	u32 total_cnt = 0, inherited_cnt = 0, val;
+	struct wol_bitmap_pattern *pattern;
+	u16 map_index, mask_index;
+	u8 mask[MAX_PATTERN_SIZE];
+	u32 i, j, z;
+
+	if (pattern_cnt > MAX_PATTERN_COUNT) {
+		yt_err(pdata, "%s, %d patterns exceed %d, not supported!\n",
+		       __func__, pattern_cnt, MAX_PATTERN_COUNT);
+		return -EINVAL;
+	}
+
+	/* Reset the FIFO head pointer. */
+	if (fxgmac_check_wake_pattern_fifo_pointer(pdata)) {
+		yt_err(pdata, "%s, remote pattern array pointer is not be 0\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < pattern_cnt; i++) {
+		pattern = &pdata->pattern[i];
+		memcpy(pattern, wol_pattern + i, sizeof(wol_pattern[0]));
+
+		if (pattern_cnt + inherited_cnt >= MAX_PATTERN_COUNT)
+			continue;
+
+		if (wol_pattern[i].pattern_offset ||
+		    !(wol_pattern[i].mask_info[0] & 0x01)) {
+			pattern = &pdata->pattern[pattern_cnt + inherited_cnt];
+			memcpy(pattern, wol_pattern + i,
+			       sizeof(wol_pattern[0]));
+			inherited_cnt++;
+		}
+	}
+	total_cnt = pattern_cnt + inherited_cnt;
+
+	/* Calculate the crc-16 of the mask pattern */
+	for (i = 0; i < total_cnt; i++) {
+		/* Please program pattern[i] to NIC for pattern match wakeup.
+		 * pattern_size, pattern_info, mask_info
+		 */
+		mask_index = 0;
+		map_index = 0;
+		pattern = &pdata->pattern[i];
+		for (j = 0; j < pattern->mask_size; j++) {
+			for (z = 0;
+			     z < ((j == (MAX_PATTERN_SIZE / 8 - 1)) ? 7 : 8);
+			     z++) {
+				if (pattern->mask_info[j] & (0x01 << z)) {
+					mask[map_index] =
+						pattern->pattern_info
+							[pattern->pattern_offset +
+							 mask_index];
+					map_index++;
+				}
+				mask_index++;
+			}
+		}
+		/* Calculate  the crc-16 of the mask pattern */
+		pattern->pattern_crc = wol_crc16(mask, map_index);
+		memset(mask, 0, sizeof(mask));
+	}
+
+	/* Write patterns by FIFO block. */
+	for (i = 0; i < (total_cnt + 3) / 4; i++) {
+		/* 1. Write the first 4Bytes of Filter. */
+		__write_filter(pdata, i, 0);
+		__write_filter(pdata, i, 1);
+		__write_filter(pdata, i, 2);
+		__write_filter(pdata, i, 3);
+
+		/* 2. Write the Filter Command. */
+		val = 0;
+		val |= __set_filter_addr_type(pdata, i, 0, total_cnt,
+					      pattern_cnt);
+		val |= __set_filter_addr_type(pdata, i, 1, total_cnt,
+					      pattern_cnt);
+		val |= __set_filter_addr_type(pdata, i, 2, total_cnt,
+					      pattern_cnt);
+		val |= __set_filter_addr_type(pdata, i, 3, total_cnt,
+					      pattern_cnt);
+		wr32_mac(pdata, val, MAC_RWK_PAC);
+
+		/* 3. Write the mask offset. */
+		val = (pdata->pattern[i * 4 + 3].pattern_offset << 24) |
+		      (pdata->pattern[i * 4 + 2].pattern_offset << 16) |
+		      (pdata->pattern[i * 4 + 1].pattern_offset << 8) |
+		      (pdata->pattern[i * 4 + 0].pattern_offset << 0);
+		wr32_mac(pdata, val, MAC_RWK_PAC);
+
+		/* 4. Write the masked data CRC. */
+		val = (pdata->pattern[i * 4 + 1].pattern_crc << 16) |
+		      (pdata->pattern[i * 4 + 0].pattern_crc << 0);
+		wr32_mac(pdata, val, MAC_RWK_PAC);
+		val = (pdata->pattern[i * 4 + 3].pattern_crc << 16) |
+		      (pdata->pattern[i * 4 + 2].pattern_crc << 0);
+		wr32_mac(pdata, val, MAC_RWK_PAC);
+	}
+
+	for (i = 0; i < total_cnt; i++) {
+		/* Global  manager  regitster  mask bit 31~62 */
+		pattern = &pdata->pattern[i];
+		val = __wake_pattern_mask_val(pattern, 0);
+		fxgmac_set_wake_pattern_mask(pdata, i, 0, val);
+
+		/* Global  manager  regitster  mask bit 63~94 */
+		val = __wake_pattern_mask_val(pattern, 1);
+		fxgmac_set_wake_pattern_mask(pdata, i, 1, val);
+
+		/* Global  manager regitster  mask bit 95~126 */
+		val = __wake_pattern_mask_val(pattern, 2);
+		fxgmac_set_wake_pattern_mask(pdata, i, 2, val);
+	}
+
+	return 0;
+}
+
+static void fxgmac_enable_wake_pattern(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_RWKFILTERST_POS,
+			MAC_PMT_STA_RWKFILTERST_LEN, 1);
+	fxgmac_set_bits(&val, MAC_PMT_STA_RWKPKTEN_POS,
+			MAC_PMT_STA_RWKPKTEN_LEN, 1);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_PKT_EN_POS, WOL_PKT_EN_LEN, 1);
+	wr32_mem(pdata, val, WOL_CTRL);
+}
+
+static void fxgmac_disable_wake_pattern(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_RWKFILTERST_POS,
+			MAC_PMT_STA_RWKFILTERST_LEN, 1);
+	fxgmac_set_bits(&val, MAC_PMT_STA_RWKPKTEN_POS,
+			MAC_PMT_STA_RWKPKTEN_LEN, 0);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_PKT_EN_POS, WOL_PKT_EN_LEN, 0);
+	wr32_mem(pdata, val, WOL_CTRL);
+}
+
+static void fxgmac_enable_wake_magic_pattern(struct fxgmac_pdata *pdata)
+{
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	u16 pm_ctrl;
+	u32 val;
+	int pos;
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_MGKPKTEN_POS,
+			MAC_PMT_STA_MGKPKTEN_LEN, 1);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_PKT_EN_POS, WOL_PKT_EN_LEN, 1);
+	wr32_mem(pdata, val, WOL_CTRL);
+
+	pos = pci_find_capability(pdev, PCI_CAP_ID_PM);
+	if (!pos) {
+		yt_err(pdata, "Unable to find Power Management Capabilities\n");
+		return;
+	}
+
+	pci_read_config_word(pdev, pos + PCI_PM_CTRL, &pm_ctrl);
+	pm_ctrl |= PCI_PM_CTRL_PME_ENABLE;
+	pci_write_config_word(pdev, pos + PCI_PM_CTRL, pm_ctrl);
+}
+
+static void fxgmac_disable_wake_magic_pattern(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_PKT_EN_POS, WOL_PKT_EN_LEN, 0);
+	wr32_mem(pdata, val, WOL_CTRL);
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_MGKPKTEN_POS,
+			MAC_PMT_STA_MGKPKTEN_LEN, 0);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+}
+
+static void fxgmac_enable_wake_packet_indication(struct fxgmac_pdata *pdata,
+						 int en)
+{
+	u32 val_wpi_crtl0;
+
+	rd32_mem(pdata, MGMT_WOL_CTRL); /* Read-clear WoL event. */
+
+	/* Prepare to write packet data by write wpi_mode to 1 */
+	val_wpi_crtl0 = rd32_mem(pdata, MGMT_WPI_CTRL0);
+	fxgmac_set_bits(&val_wpi_crtl0, MGMT_WPI_CTRL0_WPI_MODE_POS,
+			MGMT_WPI_CTRL0_WPI_MODE_LEN,
+			(en ? MGMT_WPI_CTRL0_WPI_MODE_WR :
+				    MGMT_WPI_CTRL0_WPI_MODE_NORMAL));
+	wr32_mem(pdata, val_wpi_crtl0, MGMT_WPI_CTRL0);
+}
+
+static void fxgmac_enable_wake_link_change(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_LINKCHG_EN_POS, WOL_LINKCHG_EN_LEN, 1);
+	wr32_mem(pdata, val, WOL_CTRL);
+}
+
+static void fxgmac_disable_wake_link_change(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_LINKCHG_EN_POS, WOL_LINKCHG_EN_LEN, 0);
+	wr32_mem(pdata, val, WOL_CTRL);
+}
+
 static void fxgmac_enable_dma_interrupts(struct fxgmac_pdata *pdata)
 {
 	struct fxgmac_channel *channel = pdata->channel_head;
@@ -2686,4 +3251,15 @@ void fxgmac_hw_ops_init(struct fxgmac_hw_ops *hw_ops)
 	hw_ops->set_rss_options = fxgmac_write_rss_options;
 	hw_ops->set_rss_hash_key = fxgmac_set_rss_hash_key;
 	hw_ops->write_rss_lookup_table = fxgmac_write_rss_lookup_table;
+
+	/* Wake */
+	hw_ops->disable_arp_offload = fxgmac_disable_arp_offload;
+	hw_ops->enable_wake_magic_pattern = fxgmac_enable_wake_magic_pattern;
+	hw_ops->disable_wake_magic_pattern = fxgmac_disable_wake_magic_pattern;
+	hw_ops->enable_wake_link_change = fxgmac_enable_wake_link_change;
+	hw_ops->disable_wake_link_change = fxgmac_disable_wake_link_change;
+	hw_ops->set_wake_pattern = fxgmac_set_wake_pattern;
+	hw_ops->enable_wake_pattern = fxgmac_enable_wake_pattern;
+	hw_ops->disable_wake_pattern = fxgmac_disable_wake_pattern;
+
 }
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
index c5c13601e..6a3d1073c 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -14,6 +14,89 @@
 const struct net_device_ops *fxgmac_get_netdev_ops(void);
 static void fxgmac_napi_enable(struct fxgmac_pdata *pdata);
 
+unsigned int fxgmac_get_netdev_ip4addr(struct fxgmac_pdata *pdata)
+{
+	unsigned int ipval = 0xc0a801ca; /* 192.168.1.202 */
+	struct net_device *netdev = pdata->netdev;
+	struct in_ifaddr *ifa;
+
+	rcu_read_lock();
+
+	/* We only get the first IPv4 addr. */
+	ifa = rcu_dereference(netdev->ip_ptr->ifa_list);
+	if (ifa) {
+		ipval = (unsigned int)ifa->ifa_address;
+		yt_dbg(pdata, "%s, netdev %s IPv4 address %pI4, mask: %pI4\n",
+		       __func__, ifa->ifa_label, &ifa->ifa_address,
+		       &ifa->ifa_mask);
+	}
+
+	rcu_read_unlock();
+
+	return ipval;
+}
+
+unsigned char *fxgmac_get_netdev_ip6addr(struct fxgmac_pdata *pdata,
+					 unsigned char *ipval,
+					 unsigned char *ip6addr_solicited,
+					 unsigned int ifa_flag)
+{
+	struct net_device *netdev = pdata->netdev;
+	unsigned char solicited_ipval[16] = { 0 };
+	unsigned char local_ipval[16] = { 0 };
+	struct in6_addr *addr_ip6_solicited;
+	struct in6_addr *addr_ip6;
+	struct inet6_ifaddr *ifp;
+	int err = -EADDRNOTAVAIL;
+	struct inet6_dev *i6dev;
+
+	if (!(ifa_flag &
+	      (FXGMAC_NS_IFA_GLOBAL_UNICAST | FXGMAC_NS_IFA_LOCAL_LINK))) {
+		yt_err(pdata, "%s, ifa_flag :%d is err.\n", __func__, ifa_flag);
+		return NULL;
+	}
+
+	addr_ip6 = (struct in6_addr *)local_ipval;
+	addr_ip6_solicited = (struct in6_addr *)solicited_ipval;
+
+	if (ipval)
+		addr_ip6 = (struct in6_addr *)ipval;
+
+	if (ip6addr_solicited)
+		addr_ip6_solicited = (struct in6_addr *)ip6addr_solicited;
+
+	in6_pton("fe80::4808:8ffb:d93e:d753", -1, (u8 *)addr_ip6, -1, NULL);
+
+	rcu_read_lock();
+	i6dev = __in6_dev_get(netdev);
+	if (!i6dev)
+		goto err;
+
+	read_lock_bh(&i6dev->lock);
+	list_for_each_entry(ifp, &i6dev->addr_list, if_list) {
+		if (((ifa_flag & FXGMAC_NS_IFA_GLOBAL_UNICAST) &&
+		     ifp->scope != IFA_LINK) ||
+		    ((ifa_flag & FXGMAC_NS_IFA_LOCAL_LINK) &&
+		     ifp->scope == IFA_LINK)) {
+			memcpy(addr_ip6, &ifp->addr, 16);
+			addrconf_addr_solict_mult(addr_ip6, addr_ip6_solicited);
+			err = 0;
+			break;
+		}
+	}
+	read_unlock_bh(&i6dev->lock);
+
+	if (err)
+		goto err;
+
+	rcu_read_unlock();
+	return ipval;
+err:
+	rcu_read_unlock();
+	yt_err(pdata, "%s, get ipv6 addr err, use default.\n", __func__);
+	return NULL;
+}
+
 static unsigned int fxgmac_desc_tx_avail(struct fxgmac_ring *ring)
 {
 	unsigned int avail;
@@ -903,6 +986,41 @@ static void fxgmac_restart_work(struct work_struct *work)
 	rtnl_unlock();
 }
 
+int fxgmac_config_wol(struct fxgmac_pdata *pdata, bool en)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	if (!pdata->hw_feat.rwk) {
+		yt_err(pdata, "error configuring WOL - not supported.\n");
+		return -EOPNOTSUPP;
+	}
+
+	hw_ops->disable_wake_magic_pattern(pdata);
+	hw_ops->disable_wake_pattern(pdata);
+	hw_ops->disable_wake_link_change(pdata);
+
+	if (en) {
+		/* Config mac address for rx of magic or ucast */
+		hw_ops->set_mac_address(pdata, (u8 *)(pdata->netdev->dev_addr));
+
+		/* Enable Magic packet */
+		if (pdata->wol & WAKE_MAGIC)
+			hw_ops->enable_wake_magic_pattern(pdata);
+
+		/* Enable global unicast packet */
+		if (pdata->wol &
+		    (WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_ARP))
+			hw_ops->enable_wake_pattern(pdata);
+
+		/* Enable ephy link change */
+		if (pdata->wol & WAKE_PHY)
+			hw_ops->enable_wake_link_change(pdata);
+	}
+	device_set_wakeup_enable((pdata->dev), en);
+
+	return 0;
+}
+
 int fxgmac_net_powerdown(struct fxgmac_pdata *pdata, bool wake_en)
 {
 	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
-- 
2.34.1


