Return-Path: <netdev+bounces-139318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC319B17BE
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 14:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718AA1F23169
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 12:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA4D1D5CC5;
	Sat, 26 Oct 2024 12:04:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A210E5;
	Sat, 26 Oct 2024 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729944260; cv=none; b=Ss+yYgc9ZMSgONsqjGBCLXw9wrMNRF9BSIOOC+0pBoDod5EOOyrasEwO2RY0KmW5aQpyU/zfxtOTrhGwI8eDUACLHmI2jpYRevROAx716VR4FVinxnjoijVBxcLDMLb0IIHVhtbO1UhS2WxISHZLsRVW/V82SWs7C1dxKd2u2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729944260; c=relaxed/simple;
	bh=FNt+mvaMHiwkWxL13rQqjqBN6EXZJCSBoJOigQI5U18=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvBthta5h1QC8/NYQ/x5CUYrFLvAlU7eUzVfmuxBIuArb8aobSqVQd/BJWlY/UNw9Q43M+r7yBeRFtBFWUQvynYPTKI6bQ1qd1yL6zrY2BeF+fGvmElg47xYEOlC02l/wHTlyFOnPo0x7CGxslB4Gyy6GsaWrE/kF+AnPA7bTxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XbJF11Zhjz1SCm9;
	Sat, 26 Oct 2024 20:02:45 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id D2067180041;
	Sat, 26 Oct 2024 20:04:12 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 26 Oct 2024 20:04:11 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V2 net-next 1/8] net: hibmcge: Add dump statistics supported in this module
Date: Sat, 26 Oct 2024 19:57:33 +0800
Message-ID: <20241026115740.633503-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241026115740.633503-1-shaojijie@huawei.com>
References: <20241026115740.633503-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)

The driver supports many hw statistics. This patch supports
dump statistics through ethtool_ops and ndo.get_stats64().

The type of hw statistics register is u32, and the type
of driver statistics is u64. To prevent the statistics
register from overflowing, the driver dump the statistics
every 5 minutes in a scheduled task.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 100 ++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 179 ++++++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h  |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  58 +++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  97 ++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 171 ++++++++++++++++-
 6 files changed, 602 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 96daf058d387..411afc9b916b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -116,6 +116,104 @@ struct hbg_mac {
 	u32 link_status;
 };
 
+struct hbg_stats {
+	u64 rx_desc_drop;
+	u64 rx_desc_l2_err_cnt;
+	u64 rx_desc_pkt_len_err_cnt;
+	u64 rx_desc_l3_err_cnt;
+	u64 rx_desc_l3_wrong_head_cnt;
+	u64 rx_desc_l3_csum_err_cnt;
+	u64 rx_desc_l3_len_err_cnt;
+	u64 rx_desc_l3_zero_ttl_cnt;
+	u64 rx_desc_l3_other_cnt;
+	u64 rx_desc_l4_err_cnt;
+	u64 rx_desc_l4_wrong_head_cnt;
+	u64 rx_desc_l4_len_err_cnt;
+	u64 rx_desc_l4_csum_err_cnt;
+	u64 rx_desc_l4_zero_port_num_cnt;
+	u64 rx_desc_l4_other_cnt;
+	u64 rx_desc_frag_cnt;
+	u64 rx_desc_ip_ver_err_cnt;
+	u64 rx_desc_ipv4_pkt_cnt;
+	u64 rx_desc_ipv6_pkt_cnt;
+	u64 rx_desc_no_ip_pkt_cnt;
+	u64 rx_desc_ip_pkt_cnt;
+	u64 rx_desc_tcp_pkt_cnt;
+	u64 rx_desc_udp_pkt_cnt;
+	u64 rx_desc_vlan_pkt_cnt;
+	u64 rx_desc_icmp_pkt_cnt;
+	u64 rx_desc_arp_pkt_cnt;
+	u64 rx_desc_rarp_pkt_cnt;
+	u64 rx_desc_multicast_pkt_cnt;
+	u64 rx_desc_broadcast_pkt_cnt;
+	u64 rx_desc_ipsec_pkt_cnt;
+	u64 rx_desc_ip_opt_pkt_cnt;
+	u64 rx_desc_key_not_match_cnt;
+
+	u64 rx_octets_total_ok_cnt;
+	u64 rx_uc_pkts_cnt;
+	u64 rx_mc_pkts_cnt;
+	u64 rx_bc_pkts_cnt;
+	u64 rx_vlan_pkt_cnt;
+	u64 rx_octets_bad_cnt;
+	u64 rx_octets_total_filt_cnt;
+	u64 rx_filt_pkt_cnt;
+	u64 rx_trans_pkg_cnt;
+	u64 rx_framesize_64;
+	u64 rx_framesize_65_127;
+	u64 rx_framesize_128_255;
+	u64 rx_framesize_256_511;
+	u64 rx_framesize_512_1023;
+	u64 rx_framesize_1024_1518;
+	u64 rx_framesize_bt_1518;
+	u64 rx_fcs_error_cnt;
+	u64 rx_data_error_cnt;
+	u64 rx_align_error_cnt;
+	u64 rx_frame_long_err_cnt;
+	u64 rx_jabber_err_cnt;
+	u64 rx_pause_macctl_frame_cnt;
+	u64 rx_unknown_macctl_frame_cnt;
+	u64 rx_frame_very_long_err_cnt;
+	u64 rx_frame_runt_err_cnt;
+	u64 rx_frame_short_err_cnt;
+	u64 rx_over_flow_cnt;
+	u64 rx_addr_overflow_cnt;
+	u64 rx_bufrq_err_cnt;
+	u64 rx_we_err_cnt;
+	u64 rx_overrun_cnt;
+	u64 rx_lengthfield_err_cnt;
+	u64 rx_fail_comma_cnt;
+
+	u64 rx_dma_err_cnt;
+	u64 rx_fifo_fill_full_cnt;
+
+	u64 tx_octets_total_ok_cnt;
+	u64 tx_uc_pkts_cnt;
+	u64 tx_mc_pkts_cnt;
+	u64 tx_bc_pkts_cnt;
+	u64 tx_vlan_pkt_cnt;
+	u64 tx_octets_bad_cnt;
+	u64 tx_trans_pkg_cnt;
+	u64 tx_pause_frame_cnt;
+	u64 tx_framesize_64;
+	u64 tx_framesize_65_127;
+	u64 tx_framesize_128_255;
+	u64 tx_framesize_256_511;
+	u64 tx_framesize_512_1023;
+	u64 tx_framesize_1024_1518;
+	u64 tx_framesize_bt_1518;
+	u64 tx_underrun_err_cnt;
+	u64 tx_add_cs_fail_cnt;
+	u64 tx_we_err_cnt;
+	u64 tx_bufrl_err_cnt;
+	u64 tx_crc_err_cnt;
+	u64 tx_drop_cnt;
+	u64 tx_excessive_length_drop_cnt;
+
+	u64 tx_timeout_cnt;
+	u64 tx_dma_err_cnt;
+};
+
 struct hbg_priv {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -126,6 +224,8 @@ struct hbg_priv {
 	struct hbg_vector vectors;
 	struct hbg_ring tx_ring;
 	struct hbg_ring rx_ring;
+	struct hbg_stats stats;
+	struct delayed_work service_task;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index c3370114aef3..774b49a4186c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -3,12 +3,191 @@
 
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include "hbg_common.h"
 #include "hbg_ethtool.h"
+#include "hbg_hw.h"
+
+#define HBG_STATS_FIELD_OFF(f) (offsetof(struct hbg_stats, f))
+#define HBG_STATS_READ(p, offset) (*(u64 *)((u8 *)(p) + (offset)))
+#define HBG_STATS_UPDATE(p, offset, val) (HBG_STATS_READ(p, offset) += (val))
+
+struct hbg_ethtool_stats {
+	char name[ETH_GSTRING_LEN];
+	unsigned long offset;
+	u32 reg; /* set to 0 if stats is not updated via dump reg */
+};
+
+#define HBG_STATS_I(stats) { #stats, HBG_STATS_FIELD_OFF(stats), 0}
+#define HBG_STATS_REG_I(stats, reg) { #stats, HBG_STATS_FIELD_OFF(stats), reg}
+
+static const struct hbg_ethtool_stats hbg_ethtool_stats_map[] = {
+	HBG_STATS_I(rx_desc_l2_err_cnt),
+	HBG_STATS_I(rx_desc_pkt_len_err_cnt),
+	HBG_STATS_I(rx_desc_l3_err_cnt),
+	HBG_STATS_I(rx_desc_l3_wrong_head_cnt),
+	HBG_STATS_I(rx_desc_l3_csum_err_cnt),
+	HBG_STATS_I(rx_desc_l3_len_err_cnt),
+	HBG_STATS_I(rx_desc_l3_zero_ttl_cnt),
+	HBG_STATS_I(rx_desc_l3_other_cnt),
+	HBG_STATS_I(rx_desc_l4_err_cnt),
+	HBG_STATS_I(rx_desc_l4_wrong_head_cnt),
+	HBG_STATS_I(rx_desc_l4_len_err_cnt),
+	HBG_STATS_I(rx_desc_l4_csum_err_cnt),
+	HBG_STATS_I(rx_desc_l4_zero_port_num_cnt),
+	HBG_STATS_I(rx_desc_l4_other_cnt),
+	HBG_STATS_I(rx_desc_frag_cnt),
+	HBG_STATS_I(rx_desc_ip_ver_err_cnt),
+	HBG_STATS_I(rx_desc_ipv4_pkt_cnt),
+	HBG_STATS_I(rx_desc_ipv6_pkt_cnt),
+	HBG_STATS_I(rx_desc_no_ip_pkt_cnt),
+	HBG_STATS_I(rx_desc_ip_pkt_cnt),
+	HBG_STATS_I(rx_desc_tcp_pkt_cnt),
+	HBG_STATS_I(rx_desc_udp_pkt_cnt),
+	HBG_STATS_I(rx_desc_vlan_pkt_cnt),
+	HBG_STATS_I(rx_desc_icmp_pkt_cnt),
+	HBG_STATS_I(rx_desc_arp_pkt_cnt),
+	HBG_STATS_I(rx_desc_rarp_pkt_cnt),
+	HBG_STATS_I(rx_desc_multicast_pkt_cnt),
+	HBG_STATS_I(rx_desc_broadcast_pkt_cnt),
+	HBG_STATS_I(rx_desc_ipsec_pkt_cnt),
+	HBG_STATS_I(rx_desc_ip_opt_pkt_cnt),
+	HBG_STATS_I(rx_desc_key_not_match_cnt),
+
+	HBG_STATS_REG_I(rx_octets_total_ok_cnt,
+			HBG_REG_RX_OCTETS_TOTAL_OK_ADDR),
+	HBG_STATS_REG_I(rx_octets_bad_cnt, HBG_REG_RX_OCTETS_BAD_ADDR),
+	HBG_STATS_REG_I(rx_octets_total_filt_cnt,
+			HBG_REG_RX_OCTETS_TOTAL_FILT_ADDR),
+	HBG_STATS_REG_I(rx_uc_pkts_cnt, HBG_REG_RX_UC_PKTS_ADDR),
+	HBG_STATS_REG_I(rx_mc_pkts_cnt, HBG_REG_RX_MC_PKTS_ADDR),
+	HBG_STATS_REG_I(rx_bc_pkts_cnt, HBG_REG_RX_BC_PKTS_ADDR),
+	HBG_STATS_REG_I(rx_vlan_pkt_cnt, HBG_REG_RX_TAGGED_ADDR),
+	HBG_STATS_REG_I(rx_filt_pkt_cnt, HBG_REG_RX_FILT_PKT_CNT_ADDR),
+	HBG_STATS_REG_I(rx_trans_pkg_cnt, HBG_REG_RX_TRANS_PKG_CNT_ADDR),
+	HBG_STATS_REG_I(rx_framesize_64, HBG_REG_RX_PKTS_64OCTETS_ADDR),
+	HBG_STATS_REG_I(rx_framesize_65_127,
+			HBG_REG_RX_PKTS_65TO127OCTETS_ADDR),
+	HBG_STATS_REG_I(rx_framesize_128_255,
+			HBG_REG_RX_PKTS_128TO255OCTETS_ADDR),
+	HBG_STATS_REG_I(rx_framesize_256_511,
+			HBG_REG_RX_PKTS_256TO511OCTETS_ADDR),
+	HBG_STATS_REG_I(rx_framesize_512_1023,
+			HBG_REG_RX_PKTS_512TO1023OCTETS_ADDR),
+	HBG_STATS_REG_I(rx_framesize_1024_1518,
+			HBG_REG_RX_PKTS_1024TO1518OCTETS_ADDR),
+	HBG_STATS_REG_I(rx_framesize_bt_1518,
+			HBG_REG_RX_PKTS_1519TOMAXOCTETS_ADDR),
+	HBG_STATS_REG_I(rx_fcs_error_cnt, HBG_REG_RX_FCS_ERRORS_ADDR),
+	HBG_STATS_REG_I(rx_data_error_cnt, HBG_REG_RX_DATA_ERR_ADDR),
+	HBG_STATS_REG_I(rx_align_error_cnt, HBG_REG_RX_ALIGN_ERRORS_ADDR),
+	HBG_STATS_REG_I(rx_frame_long_err_cnt, HBG_REG_RX_LONG_ERRORS_ADDR),
+	HBG_STATS_REG_I(rx_jabber_err_cnt, HBG_REG_RX_JABBER_ERRORS_ADDR),
+	HBG_STATS_REG_I(rx_pause_macctl_frame_cnt,
+			HBG_REG_RX_PAUSE_MACCTL_FRAMCOUNTER_ADDR),
+	HBG_STATS_REG_I(rx_unknown_macctl_frame_cnt,
+			HBG_REG_RX_UNKNOWN_MACCTL_FRAMCOUNTER_ADDR),
+	HBG_STATS_REG_I(rx_frame_very_long_err_cnt,
+			HBG_REG_RX_VERY_LONG_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_frame_runt_err_cnt, HBG_REG_RX_RUNT_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_frame_short_err_cnt, HBG_REG_RX_SHORT_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_over_flow_cnt, HBG_REG_RX_OVER_FLOW_CNT_ADDR),
+	HBG_STATS_REG_I(rx_addr_overflow_cnt, HBG_REG_RX_ADDR_OVERFLOW_ADDR),
+	HBG_STATS_REG_I(rx_bufrq_err_cnt, HBG_REG_RX_BUFRQ_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_we_err_cnt, HBG_REG_RX_WE_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_overrun_cnt, HBG_REG_RX_OVERRUN_CNT_ADDR),
+	HBG_STATS_REG_I(rx_lengthfield_err_cnt,
+			HBG_REG_RX_LENGTHFIELD_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_fail_comma_cnt, HBG_REG_RX_FAIL_COMMA_CNT_ADDR),
+	HBG_STATS_I(rx_dma_err_cnt),
+	HBG_STATS_I(rx_fifo_fill_full_cnt),
+
+	HBG_STATS_REG_I(tx_octets_total_ok_cnt,
+			HBG_REG_OCTETS_TRANSMITTED_OK_ADDR),
+	HBG_STATS_REG_I(tx_uc_pkts_cnt, HBG_REG_TX_UC_PKTS_ADDR),
+	HBG_STATS_REG_I(tx_mc_pkts_cnt, HBG_REG_TX_MC_PKTS_ADDR),
+	HBG_STATS_REG_I(tx_bc_pkts_cnt, HBG_REG_TX_BC_PKTS_ADDR),
+	HBG_STATS_REG_I(tx_vlan_pkt_cnt, HBG_REG_TX_TAGGED_ADDR),
+	HBG_STATS_REG_I(tx_octets_bad_cnt, HBG_REG_OCTETS_TRANSMITTED_BAD_ADDR),
+	HBG_STATS_REG_I(tx_trans_pkg_cnt, HBG_REG_TX_TRANS_PKG_CNT_ADDR),
+	HBG_STATS_REG_I(tx_pause_frame_cnt, HBG_REG_TX_PAUSE_FRAMES_ADDR),
+	HBG_STATS_REG_I(tx_framesize_64, HBG_REG_TX_PKTS_64OCTETS_ADDR),
+	HBG_STATS_REG_I(tx_framesize_65_127,
+			HBG_REG_TX_PKTS_65TO127OCTETS_ADDR),
+	HBG_STATS_REG_I(tx_framesize_128_255,
+			HBG_REG_TX_PKTS_128TO255OCTETS_ADDR),
+	HBG_STATS_REG_I(tx_framesize_256_511,
+			HBG_REG_TX_PKTS_256TO511OCTETS_ADDR),
+	HBG_STATS_REG_I(tx_framesize_512_1023,
+			HBG_REG_TX_PKTS_512TO1023OCTETS_ADDR),
+	HBG_STATS_REG_I(tx_framesize_1024_1518,
+			HBG_REG_TX_PKTS_1024TO1518OCTETS_ADDR),
+	HBG_STATS_REG_I(tx_framesize_bt_1518,
+			HBG_REG_TX_PKTS_1519TOMAXOCTETS_ADDR),
+	HBG_STATS_REG_I(tx_underrun_err_cnt, HBG_REG_TX_UNDERRUN_ADDR),
+	HBG_STATS_REG_I(tx_add_cs_fail_cnt, HBG_REG_TX_CS_FAIL_CNT_ADDR),
+	HBG_STATS_REG_I(tx_bufrl_err_cnt, HBG_REG_TX_BUFRL_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(tx_crc_err_cnt, HBG_REG_TX_CRC_ERROR_ADDR),
+	HBG_STATS_REG_I(tx_drop_cnt, HBG_REG_TX_DROP_CNT_ADDR),
+	HBG_STATS_REG_I(tx_excessive_length_drop_cnt,
+			HBG_REG_TX_EXCESSIVE_LENGTH_DROP_ADDR),
+	HBG_STATS_I(tx_dma_err_cnt),
+	HBG_STATS_I(tx_timeout_cnt),
+};
+
+static int hbg_ethtool_get_sset_count(struct net_device *netdev, int stringset)
+{
+	if (stringset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	return ARRAY_SIZE(hbg_ethtool_stats_map);
+}
+
+static void hbg_ethtool_get_strings(struct net_device *netdev,
+				    u32 stringset, u8 *data)
+{
+	u32 i;
+
+	if (stringset != ETH_SS_STATS)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(hbg_ethtool_stats_map); i++)
+		ethtool_puts(&data, hbg_ethtool_stats_map[i].name);
+}
+
+void hbg_update_stats(struct hbg_priv *priv)
+{
+	const struct hbg_ethtool_stats *stats_info;
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(hbg_ethtool_stats_map); i++) {
+		stats_info = &hbg_ethtool_stats_map[i];
+		if (!stats_info->reg)
+			continue;
+
+		HBG_STATS_UPDATE(&priv->stats, stats_info->offset,
+				 hbg_reg_read(priv, stats_info->reg));
+	}
+}
+
+static void hbg_ethtool_get_stats(struct net_device *netdev,
+				  struct ethtool_stats *stats, u64 *data)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	u32 i;
+
+	hbg_update_stats(priv);
+	for (i = 0; i < ARRAY_SIZE(hbg_ethtool_stats_map); i++)
+		*data++ = HBG_STATS_READ(&priv->stats,
+					 hbg_ethtool_stats_map[i].offset);
+}
 
 static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+	.get_sset_count		= hbg_ethtool_get_sset_count,
+	.get_strings		= hbg_ethtool_get_strings,
+	.get_ethtool_stats	= hbg_ethtool_get_stats,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
index 628707ec2686..995ec369ff30 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
@@ -7,5 +7,6 @@
 #include <linux/netdevice.h>
 
 void hbg_ethtool_set_ops(struct net_device *netdev);
+void hbg_update_stats(struct hbg_priv *priv);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 75505fb5cc4a..0918d9be6e01 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -122,6 +122,10 @@ static void hbg_net_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	char *buf = ring->tout_log_buf;
 	u32 pos = 0;
 
+	priv->stats.tx_timeout_cnt++;
+
+	pos += scnprintf(buf + pos, HBG_TX_TIMEOUT_BUF_LEN - pos,
+			 "tx_timeout cnt: %llu\n", priv->stats.tx_timeout_cnt);
 	pos += scnprintf(buf + pos, HBG_TX_TIMEOUT_BUF_LEN - pos,
 			 "ring used num: %u, fifo used num: %u\n",
 			 hbg_get_queue_used_num(ring),
@@ -134,6 +138,25 @@ static void hbg_net_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	netdev_info(netdev, "%s", buf);
 }
 
+static void hbg_net_get_stats(struct net_device *netdev,
+			      struct rtnl_link_stats64 *stats)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct hbg_stats *h_stats = &priv->stats;
+
+	hbg_update_stats(priv);
+	dev_get_tstats64(netdev, stats);
+	stats->tx_dropped += h_stats->tx_drop_cnt;
+	stats->tx_dropped += h_stats->tx_excessive_length_drop_cnt;
+
+	stats->tx_errors += h_stats->tx_add_cs_fail_cnt;
+	stats->tx_errors += h_stats->tx_bufrl_err_cnt;
+	stats->tx_errors += h_stats->tx_underrun_err_cnt;
+	stats->tx_errors += h_stats->tx_we_err_cnt;
+	stats->tx_errors += h_stats->tx_crc_err_cnt;
+	stats->tx_errors += h_stats->tx_timeout_cnt;
+}
+
 static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_open		= hbg_net_open,
 	.ndo_stop		= hbg_net_stop,
@@ -142,8 +165,35 @@ static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_set_mac_address	= hbg_net_set_mac_address,
 	.ndo_change_mtu		= hbg_net_change_mtu,
 	.ndo_tx_timeout		= hbg_net_tx_timeout,
+	.ndo_get_stats64	= hbg_net_get_stats,
 };
 
+static void hbg_service_task(struct work_struct *work)
+{
+	struct hbg_priv *priv = container_of(work, struct hbg_priv,
+					     service_task.work);
+
+	/* The type of statistics register is u32,
+	 * and the type of driver statistics is u64.
+	 * To prevent the statistics register from overflowing,
+	 * the driver dumps the statistics every 5 minutes.
+	 */
+	hbg_update_stats(priv);
+	schedule_delayed_work(&priv->service_task,
+			      msecs_to_jiffies(5 * 60 * MSEC_PER_SEC));
+}
+
+static void hbg_delaywork_init(struct hbg_priv *priv)
+{
+	INIT_DELAYED_WORK(&priv->service_task, hbg_service_task);
+	schedule_delayed_work(&priv->service_task, 0);
+}
+
+static void hbg_delaywork_uninit(void *data)
+{
+	cancel_delayed_work_sync(data);
+}
+
 static int hbg_init(struct hbg_priv *priv)
 {
 	int ret;
@@ -160,7 +210,13 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
-	return hbg_mdio_init(priv);
+	ret = hbg_mdio_init(priv);
+	if (ret)
+		return ret;
+
+	hbg_delaywork_init(priv);
+	return devm_add_action_or_reset(&priv->pdev->dev, hbg_delaywork_uninit,
+					&priv->service_task);
 }
 
 static int hbg_pci_init(struct pci_dev *pdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 57d81c6d7633..7d1d5bb028be 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -47,12 +47,57 @@
 #define HBG_REG_TRANSMIT_CTRL_PAD_EN_B		BIT(7)
 #define HBG_REG_TRANSMIT_CTRL_CRC_ADD_B		BIT(6)
 #define HBG_REG_TRANSMIT_CTRL_AN_EN_B		BIT(5)
+#define HBG_REG_RX_OCTETS_TOTAL_OK_ADDR		(HBG_REG_SGMII_BASE + 0x0080)
+#define HBG_REG_RX_OCTETS_BAD_ADDR		(HBG_REG_SGMII_BASE + 0x0084)
+#define HBG_REG_RX_UC_PKTS_ADDR			(HBG_REG_SGMII_BASE + 0x0088)
+#define HBG_REG_RX_MC_PKTS_ADDR			(HBG_REG_SGMII_BASE + 0x008C)
+#define HBG_REG_RX_BC_PKTS_ADDR			(HBG_REG_SGMII_BASE + 0x0090)
+#define HBG_REG_RX_PKTS_64OCTETS_ADDR		(HBG_REG_SGMII_BASE + 0x0094)
+#define HBG_REG_RX_PKTS_65TO127OCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x0098)
+#define HBG_REG_RX_PKTS_128TO255OCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x009C)
+#define HBG_REG_RX_PKTS_256TO511OCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x00A0)
+#define HBG_REG_RX_PKTS_512TO1023OCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x00A4)
+#define HBG_REG_RX_PKTS_1024TO1518OCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x00A8)
+#define HBG_REG_RX_PKTS_1519TOMAXOCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x00AC)
+#define HBG_REG_RX_FCS_ERRORS_ADDR		(HBG_REG_SGMII_BASE + 0x00B0)
+#define HBG_REG_RX_TAGGED_ADDR			(HBG_REG_SGMII_BASE + 0x00B4)
+#define HBG_REG_RX_DATA_ERR_ADDR		(HBG_REG_SGMII_BASE + 0x00B8)
+#define HBG_REG_RX_ALIGN_ERRORS_ADDR		(HBG_REG_SGMII_BASE + 0x00BC)
+#define HBG_REG_RX_LONG_ERRORS_ADDR		(HBG_REG_SGMII_BASE + 0x00C0)
+#define HBG_REG_RX_JABBER_ERRORS_ADDR		(HBG_REG_SGMII_BASE + 0x00C4)
+#define HBG_REG_RX_PAUSE_MACCTL_FRAMCOUNTER_ADDR   (HBG_REG_SGMII_BASE + 0x00C8)
+#define HBG_REG_RX_UNKNOWN_MACCTL_FRAMCOUNTER_ADDR (HBG_REG_SGMII_BASE + 0x00CC)
+#define HBG_REG_RX_VERY_LONG_ERR_CNT_ADDR	(HBG_REG_SGMII_BASE + 0x00D0)
+#define HBG_REG_RX_RUNT_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x00D4)
+#define HBG_REG_RX_SHORT_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x00D8)
+#define HBG_REG_RX_FILT_PKT_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x00E8)
+#define HBG_REG_RX_OCTETS_TOTAL_FILT_ADDR	(HBG_REG_SGMII_BASE + 0x00EC)
+#define HBG_REG_OCTETS_TRANSMITTED_OK_ADDR	(HBG_REG_SGMII_BASE + 0x0100)
+#define HBG_REG_OCTETS_TRANSMITTED_BAD_ADDR	(HBG_REG_SGMII_BASE + 0x0104)
+#define HBG_REG_TX_UC_PKTS_ADDR			(HBG_REG_SGMII_BASE + 0x0108)
+#define HBG_REG_TX_MC_PKTS_ADDR			(HBG_REG_SGMII_BASE + 0x010C)
+#define HBG_REG_TX_BC_PKTS_ADDR			(HBG_REG_SGMII_BASE + 0x0110)
+#define HBG_REG_TX_PKTS_64OCTETS_ADDR		(HBG_REG_SGMII_BASE + 0x0114)
+#define HBG_REG_TX_PKTS_65TO127OCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x0118)
+#define HBG_REG_TX_PKTS_128TO255OCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x011C)
+#define HBG_REG_TX_PKTS_256TO511OCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x0120)
+#define HBG_REG_TX_PKTS_512TO1023OCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x0124)
+#define HBG_REG_TX_PKTS_1024TO1518OCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x0128)
+#define HBG_REG_TX_PKTS_1519TOMAXOCTETS_ADDR	(HBG_REG_SGMII_BASE + 0x012C)
+#define HBG_REG_TX_EXCESSIVE_LENGTH_DROP_ADDR	(HBG_REG_SGMII_BASE + 0x014C)
+#define HBG_REG_TX_UNDERRUN_ADDR		(HBG_REG_SGMII_BASE + 0x0150)
+#define HBG_REG_TX_TAGGED_ADDR			(HBG_REG_SGMII_BASE + 0x0154)
+#define HBG_REG_TX_CRC_ERROR_ADDR		(HBG_REG_SGMII_BASE + 0x0158)
+#define HBG_REG_TX_PAUSE_FRAMES_ADDR		(HBG_REG_SGMII_BASE + 0x015C)
 #define HBG_REG_CF_CRC_STRIP_ADDR		(HBG_REG_SGMII_BASE + 0x01B0)
 #define HBG_REG_CF_CRC_STRIP_B			BIT(0)
 #define HBG_REG_MODE_CHANGE_EN_ADDR		(HBG_REG_SGMII_BASE + 0x01B4)
 #define HBG_REG_MODE_CHANGE_EN_B		BIT(0)
 #define HBG_REG_RECV_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x01E0)
 #define HBG_REG_RECV_CTRL_STRIP_PAD_EN_B	BIT(3)
+#define HBG_REG_RX_OVERRUN_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x01EC)
+#define HBG_REG_RX_LENGTHFIELD_ERR_CNT_ADDR	(HBG_REG_SGMII_BASE + 0x01F4)
+#define HBG_REG_RX_FAIL_COMMA_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x01F8)
 #define HBG_REG_STATION_ADDR_LOW_2_ADDR		(HBG_REG_SGMII_BASE + 0x0210)
 #define HBG_REG_STATION_ADDR_HIGH_2_ADDR	(HBG_REG_SGMII_BASE + 0x0214)
 
@@ -80,9 +125,15 @@
 #define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
 #define HBG_REG_MAX_FRAME_LEN_ADDR		(HBG_REG_SGMII_BASE + 0x0444)
 #define HBG_REG_MAX_FRAME_LEN_M			GENMASK(15, 0)
+#define HBG_REG_TX_DROP_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0448)
+#define HBG_REG_RX_OVER_FLOW_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x044C)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR		(HBG_REG_SGMII_BASE + 0x045C)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR_TX_M	GENMASK(8, 0)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR_RX_M	GENMASK(24, 16)
+#define HBG_REG_TX_CS_FAIL_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0460)
+#define HBG_REG_RX_TRANS_PKG_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0464)
+#define HBG_REG_TX_TRANS_PKG_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0468)
+#define HBG_REG_RX_ADDR_OVERFLOW_ADDR		(HBG_REG_SGMII_BASE + 0x046C)
 #define HBG_REG_TX_CFF_ADDR_0_ADDR		(HBG_REG_SGMII_BASE + 0x0488)
 #define HBG_REG_TX_CFF_ADDR_1_ADDR		(HBG_REG_SGMII_BASE + 0x048C)
 #define HBG_REG_TX_CFF_ADDR_2_ADDR		(HBG_REG_SGMII_BASE + 0x0490)
@@ -101,6 +152,9 @@
 #define HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE2_M	GENMASK(3, 0)
 #define HBG_REG_RX_PKT_MODE_ADDR		(HBG_REG_SGMII_BASE + 0x04F4)
 #define HBG_REG_RX_PKT_MODE_PARSE_MODE_M	GENMASK(22, 21)
+#define HBG_REG_RX_BUFRQ_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x058C)
+#define HBG_REG_TX_BUFRL_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0590)
+#define HBG_REG_RX_WE_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0594)
 #define HBG_REG_CF_IND_TXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x0694)
 #define HBG_REG_IND_INTR_MASK_B			BIT(0)
 #define HBG_REG_CF_IND_TXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0698)
@@ -139,5 +193,48 @@ struct hbg_rx_desc {
 };
 
 #define HBG_RX_DESC_W2_PKT_LEN_M	GENMASK(31, 16)
+#define HBG_RX_DESC_W2_PORT_NUM_M	GENMASK(15, 12)
+#define HBG_RX_DESC_W4_IP_TCP_UDP_M	GENMASK(31, 30)
+#define HBG_RX_DESC_W4_IPSEC_B		BIT(29)
+#define HBG_RX_DESC_W4_IP_VERSION_B	BIT(28)
+#define HBG_RX_DESC_W4_L4_ERR_CODE_M	GENMASK(26, 23)
+#define HBG_RX_DESC_W4_FRAG_B		BIT(22)
+#define HBG_RX_DESC_W4_OPT_B		BIT(21)
+#define HBG_RX_DESC_W4_IP_VERSION_ERR_B	BIT(20)
+#define HBG_RX_DESC_W4_BRD_CST_B	BIT(19)
+#define HBG_RX_DESC_W4_MUL_CST_B	BIT(18)
+#define HBG_RX_DESC_W4_ARP_B		BIT(17)
+#define HBG_RX_DESC_W4_RARP_B		BIT(16)
+#define HBG_RX_DESC_W4_ICMP_B		BIT(15)
+#define HBG_RX_DESC_W4_VLAN_FLAG_B	BIT(14)
+#define HBG_RX_DESC_W4_DROP_B		BIT(13)
+#define HBG_RX_DESC_W4_L3_ERR_CODE_M	GENMASK(12, 9)
+#define HBG_RX_DESC_W4_L2_ERR_B		BIT(8)
+#define HBG_RX_DESC_W4_IDX_MATCH_B	BIT(7)
+
+enum hbg_l3_err_code {
+	HBG_L3_OK,
+	HBG_L3_WRONG_HEAD,
+	HBG_L3_CSUM_ERR,
+	HBG_L3_LEN_ERR,
+	HBG_L3_ZERO_TTL,
+	HBG_L3_RSVD,
+};
+
+enum hbg_l4_err_code {
+	HBG_L4_OK,
+	HBG_L4_WRONG_HEAD,
+	HBG_L4_LEN_ERR,
+	HBG_L4_CSUM_ERR,
+	HBG_L4_ZERO_PORT_NUM,
+	HBG_L4_RSVD,
+};
+
+enum hbg_pkt_type_code {
+	HBG_NO_IP_PKT = 0,
+	HBG_IP_PKT,
+	HBG_TCP_PKT,
+	HBG_UDP_PKT,
+};
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index f4f256a0dfea..d100b2357ec2 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -38,8 +38,14 @@ static int hbg_dma_map(struct hbg_buffer *buffer)
 	buffer->skb_dma = dma_map_single(&priv->pdev->dev,
 					 buffer->skb->data, buffer->skb_len,
 					 buffer_to_dma_dir(buffer));
-	if (unlikely(dma_mapping_error(&priv->pdev->dev, buffer->skb_dma)))
+	if (unlikely(dma_mapping_error(&priv->pdev->dev, buffer->skb_dma))) {
+		if (buffer->dir == HBG_DIR_RX)
+			priv->stats.rx_dma_err_cnt++;
+		else
+			priv->stats.tx_dma_err_cnt++;
+
 		return -ENOMEM;
+	}
 
 	return 0;
 }
@@ -195,14 +201,169 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
 	return packet_done;
 }
 
+static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
+				    struct hbg_rx_desc *desc)
+{
+	if (likely(!FIELD_GET(HBG_RX_DESC_W4_L3_ERR_CODE_M, desc->word4) &&
+		   !FIELD_GET(HBG_RX_DESC_W4_L4_ERR_CODE_M, desc->word4)))
+		return true;
+
+	switch (FIELD_GET(HBG_RX_DESC_W4_L3_ERR_CODE_M, desc->word4)) {
+	case HBG_L3_OK:
+		break;
+	case HBG_L3_WRONG_HEAD:
+		priv->stats.rx_desc_l3_wrong_head_cnt++;
+		return false;
+	case HBG_L3_CSUM_ERR:
+		priv->stats.rx_desc_l3_csum_err_cnt++;
+		return false;
+	case HBG_L3_LEN_ERR:
+		priv->stats.rx_desc_l3_len_err_cnt++;
+		return false;
+	case HBG_L3_ZERO_TTL:
+		priv->stats.rx_desc_l3_zero_ttl_cnt++;
+		return false;
+	default:
+		priv->stats.rx_desc_l3_other_cnt++;
+		return false;
+	}
+
+	switch (FIELD_GET(HBG_RX_DESC_W4_L4_ERR_CODE_M, desc->word4)) {
+	case HBG_L4_OK:
+		break;
+	case HBG_L4_WRONG_HEAD:
+		priv->stats.rx_desc_l4_wrong_head_cnt++;
+		return false;
+	case HBG_L4_LEN_ERR:
+		priv->stats.rx_desc_l4_len_err_cnt++;
+		return false;
+	case HBG_L4_CSUM_ERR:
+		priv->stats.rx_desc_l4_csum_err_cnt++;
+		return false;
+	case HBG_L4_ZERO_PORT_NUM:
+		priv->stats.rx_desc_l4_zero_port_num_cnt++;
+		return false;
+	default:
+		priv->stats.rx_desc_l4_other_cnt++;
+		return false;
+	}
+
+	return true;
+}
+
+static void hbg_update_rx_ip_protocol_stats(struct hbg_priv *priv,
+					    struct hbg_rx_desc *desc)
+{
+	if (unlikely(!FIELD_GET(HBG_RX_DESC_W4_IP_TCP_UDP_M, desc->word4))) {
+		priv->stats.rx_desc_no_ip_pkt_cnt++;
+		return;
+	}
+
+	if (unlikely(FIELD_GET(HBG_RX_DESC_W4_IP_VERSION_ERR_B, desc->word4))) {
+		priv->stats.rx_desc_ip_ver_err_cnt++;
+		return;
+	}
+
+	/* 0:ipv4, 1:ipv6 */
+	if (FIELD_GET(HBG_RX_DESC_W4_IP_VERSION_B, desc->word4))
+		priv->stats.rx_desc_ipv6_pkt_cnt++;
+	else
+		priv->stats.rx_desc_ipv4_pkt_cnt++;
+
+	switch (FIELD_GET(HBG_RX_DESC_W4_IP_TCP_UDP_M, desc->word4)) {
+	case HBG_IP_PKT:
+		priv->stats.rx_desc_ip_pkt_cnt++;
+		if (FIELD_GET(HBG_RX_DESC_W4_OPT_B, desc->word4))
+			priv->stats.rx_desc_ip_opt_pkt_cnt++;
+		if (FIELD_GET(HBG_RX_DESC_W4_FRAG_B, desc->word4))
+			priv->stats.rx_desc_frag_cnt++;
+
+		if (FIELD_GET(HBG_RX_DESC_W4_ICMP_B, desc->word4))
+			priv->stats.rx_desc_icmp_pkt_cnt++;
+		else if (FIELD_GET(HBG_RX_DESC_W4_IPSEC_B, desc->word4))
+			priv->stats.rx_desc_ipsec_pkt_cnt++;
+		break;
+	case HBG_TCP_PKT:
+		priv->stats.rx_desc_tcp_pkt_cnt++;
+		break;
+	case HBG_UDP_PKT:
+		priv->stats.rx_desc_udp_pkt_cnt++;
+		break;
+	default:
+		priv->stats.rx_desc_no_ip_pkt_cnt++;
+		break;
+	}
+}
+
+static void hbg_update_rx_protocol_stats(struct hbg_priv *priv,
+					 struct hbg_rx_desc *desc)
+{
+	if (unlikely(!FIELD_GET(HBG_RX_DESC_W4_IDX_MATCH_B, desc->word4))) {
+		priv->stats.rx_desc_key_not_match_cnt++;
+		return;
+	}
+
+	if (FIELD_GET(HBG_RX_DESC_W4_BRD_CST_B, desc->word4))
+		priv->stats.rx_desc_broadcast_pkt_cnt++;
+	else if (FIELD_GET(HBG_RX_DESC_W4_MUL_CST_B, desc->word4))
+		priv->stats.rx_desc_multicast_pkt_cnt++;
+
+	if (FIELD_GET(HBG_RX_DESC_W4_VLAN_FLAG_B, desc->word4))
+		priv->stats.rx_desc_vlan_pkt_cnt++;
+
+	if (FIELD_GET(HBG_RX_DESC_W4_ARP_B, desc->word4)) {
+		priv->stats.rx_desc_arp_pkt_cnt++;
+		return;
+	} else if (FIELD_GET(HBG_RX_DESC_W4_RARP_B, desc->word4)) {
+		priv->stats.rx_desc_rarp_pkt_cnt++;
+		return;
+	}
+
+	hbg_update_rx_ip_protocol_stats(priv, desc);
+}
+
+static bool hbg_rx_pkt_check(struct hbg_priv *priv, struct hbg_rx_desc *desc)
+{
+	if (unlikely(FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, desc->word2) >
+		     priv->dev_specs.max_frame_len)) {
+		priv->netdev->stats.rx_length_errors++;
+		priv->stats.rx_desc_pkt_len_err_cnt++;
+		return false;
+	}
+
+	if (unlikely(FIELD_GET(HBG_RX_DESC_W2_PORT_NUM_M, desc->word2) !=
+		     priv->dev_specs.mac_id ||
+		     FIELD_GET(HBG_RX_DESC_W4_DROP_B, desc->word4))) {
+		priv->netdev->stats.rx_dropped++;
+		priv->stats.rx_desc_drop++;
+		return false;
+	}
+
+	if (unlikely(FIELD_GET(HBG_RX_DESC_W4_L2_ERR_B, desc->word4))) {
+		priv->netdev->stats.rx_errors++;
+		priv->stats.rx_desc_l2_err_cnt++;
+		return false;
+	}
+
+	if (unlikely(!hbg_rx_check_l3l4_error(priv, desc))) {
+		priv->netdev->stats.rx_errors++;
+		return false;
+	}
+
+	hbg_update_rx_protocol_stats(priv, desc);
+	return true;
+}
+
 static int hbg_rx_fill_one_buffer(struct hbg_priv *priv)
 {
 	struct hbg_ring *ring = &priv->rx_ring;
 	struct hbg_buffer *buffer;
 	int ret;
 
-	if (hbg_queue_is_full(ring->ntc, ring->ntu, ring))
+	if (hbg_queue_is_full(ring->ntc, ring->ntu, ring)) {
+		priv->stats.rx_fifo_fill_full_cnt++;
 		return 0;
+	}
 
 	buffer = &ring->queue[ring->ntu];
 	ret = hbg_buffer_alloc_skb(buffer);
@@ -257,8 +418,12 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
 		pkt_len = FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2);
 
-		hbg_dma_unmap(buffer);
+		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc))) {
+			hbg_buffer_free(buffer);
+			goto next_buffer;
+		}
 
+		hbg_dma_unmap(buffer);
 		skb_reserve(buffer->skb, HBG_PACKET_HEAD_SIZE + NET_IP_ALIGN);
 		skb_put(buffer->skb, pkt_len);
 		buffer->skb->protocol = eth_type_trans(buffer->skb,
-- 
2.33.0


