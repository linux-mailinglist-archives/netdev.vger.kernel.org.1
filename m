Return-Path: <netdev+bounces-165796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6D0A33684
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92073A4C7F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B75205E35;
	Thu, 13 Feb 2025 04:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E908489;
	Thu, 13 Feb 2025 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419400; cv=none; b=VFJcKnU+pkItacV0Udd8muS8Y0yGHZqSpe8505iH/h726tESx/gJ9/KISGXaPTBjC0kqz6ovHN8SGZaetSc62PRVwmFRnCKTTYqMCJ2nIPiXu83DpuNF5OOZscwYyuLSZTBMMUydvS0szBFbVIldukba6/kqdZIVZces8btQ0mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419400; c=relaxed/simple;
	bh=8H7gwMgv/i+jmAmw61x/jTrpj1wGAno7SYvUMKMbhgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOwqZE7OhhsdT7Vw8Jww/U9hFXhxis/j0N8t338VMfR1Jy0f/j0YwQjMEZN1N5jHzD/YdYZDCwcORvlnbRcFlFP/rxGxvXyUVLCOfmlKAArcngcfxuF27xwxosiEnB5sY+r/YQ/DWtAuG0CdjreB9fXNgF3fnf+GUS+KI91XBLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YthM62rYKzpbQw;
	Thu, 13 Feb 2025 12:01:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A0671800B6;
	Thu, 13 Feb 2025 12:03:13 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 12:03:09 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 1/7] net: hibmcge: Add dump statistics supported in this module
Date: Thu, 13 Feb 2025 11:55:23 +0800
Message-ID: <20250213035529.2402283-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250213035529.2402283-1-shaojijie@huawei.com>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The driver supports many hw statistics. This patch supports
dump statistics through ethtool_ops and ndo.get_stats64().

The type of hw statistics register is u32,
To prevent the statistics register from overflowing,
the driver dump the statistics every 5 minutes
in a scheduled task.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   | 111 +++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 297 ++++++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.h  |   5 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  70 +++++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  96 ++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 164 +++++++++-
 6 files changed, 741 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index b4300d8ea4ad..920514a8e29a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -142,6 +142,115 @@ struct hbg_user_def {
 	struct ethtool_pauseparam pause_param;
 };
 
+struct hbg_stats {
+	u64 rx_desc_drop;
+	u64 rx_desc_l2_err_cnt;
+	u64 rx_desc_pkt_len_err_cnt;
+	u64 rx_desc_l3l4_err_cnt;
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
+	u64 rx_uc_pkt_cnt;
+	u64 rx_mc_pkt_cnt;
+	u64 rx_bc_pkt_cnt;
+	u64 rx_vlan_pkt_cnt;
+	u64 rx_octets_bad_cnt;
+	u64 rx_octets_total_filt_cnt;
+	u64 rx_filt_pkt_cnt;
+	u64 rx_trans_pkt_cnt;
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
+	u64 rx_pause_macctl_frame_cnt;
+	u64 rx_unknown_macctl_frame_cnt;
+	/* crc ok, > max_frm_size, < 2max_frm_size */
+	u64 rx_frame_long_err_cnt;
+	/* crc fail, > max_frm_size, < 2max_frm_size */
+	u64 rx_jabber_err_cnt;
+	/* > 2max_frm_size */
+	u64 rx_frame_very_long_err_cnt;
+	/* < 64byte, >= short_runts_thr */
+	u64 rx_frame_runt_err_cnt;
+	/* < short_runts_thr */
+	u64 rx_frame_short_err_cnt;
+	/* PCU: dropped when the RX FIFO is full.*/
+	u64 rx_overflow_cnt;
+	/* GMAC: the count of overflows of the RX FIFO */
+	u64 rx_overrun_cnt;
+	/* PCU: the count of buffer alloc errors in RX */
+	u64 rx_bufrq_err_cnt;
+	/* PCU: the count of write descriptor errors in RX */
+	u64 rx_we_err_cnt;
+	/* GMAC: the count of pkts that contain PAD but length is not 64 */
+	u64 rx_lengthfield_err_cnt;
+	u64 rx_fail_comma_cnt;
+
+	u64 rx_dma_err_cnt;
+
+	u64 tx_octets_total_ok_cnt;
+	u64 tx_uc_pkt_cnt;
+	u64 tx_mc_pkt_cnt;
+	u64 tx_bc_pkt_cnt;
+	u64 tx_vlan_pkt_cnt;
+	u64 tx_octets_bad_cnt;
+	u64 tx_trans_pkt_cnt;
+	u64 tx_pause_frame_cnt;
+	u64 tx_framesize_64;
+	u64 tx_framesize_65_127;
+	u64 tx_framesize_128_255;
+	u64 tx_framesize_256_511;
+	u64 tx_framesize_512_1023;
+	u64 tx_framesize_1024_1518;
+	u64 tx_framesize_bt_1518;
+	/* GMAC: the count of times that frames fail to be transmitted
+	 *       due to internal errors.
+	 */
+	u64 tx_underrun_err_cnt;
+	u64 tx_add_cs_fail_cnt;
+	/* PCU: the count of buffer free errors in TX */
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
@@ -155,6 +264,8 @@ struct hbg_priv {
 	struct hbg_mac_filter filter;
 	enum hbg_reset_type reset_type;
 	struct hbg_user_def user_def;
+	struct hbg_stats stats;
+	struct delayed_work service_task;
 };
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index 00364a438ec2..f5be8d0ef611 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -9,6 +9,135 @@
 #include "hbg_ethtool.h"
 #include "hbg_hw.h"
 
+struct hbg_ethtool_stats {
+	char name[ETH_GSTRING_LEN];
+	unsigned long offset;
+	u32 reg; /* set to 0 if stats is not updated via dump reg */
+};
+
+#define HBG_STATS_I(stats) { #stats, HBG_STATS_FIELD_OFF(stats), 0}
+#define HBG_STATS_REG_I(stats, reg) { #stats, HBG_STATS_FIELD_OFF(stats), reg}
+
+static const struct hbg_ethtool_stats hbg_ethtool_stats_info[] = {
+	HBG_STATS_I(rx_desc_l2_err_cnt),
+	HBG_STATS_I(rx_desc_pkt_len_err_cnt),
+	HBG_STATS_I(rx_desc_l3_wrong_head_cnt),
+	HBG_STATS_I(rx_desc_l3_csum_err_cnt),
+	HBG_STATS_I(rx_desc_l3_len_err_cnt),
+	HBG_STATS_I(rx_desc_l3_zero_ttl_cnt),
+	HBG_STATS_I(rx_desc_l3_other_cnt),
+	HBG_STATS_I(rx_desc_l4_wrong_head_cnt),
+	HBG_STATS_I(rx_desc_l4_len_err_cnt),
+	HBG_STATS_I(rx_desc_l4_csum_err_cnt),
+	HBG_STATS_I(rx_desc_l4_zero_port_num_cnt),
+	HBG_STATS_I(rx_desc_l4_other_cnt),
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
+	HBG_STATS_REG_I(rx_octets_bad_cnt, HBG_REG_RX_OCTETS_BAD_ADDR),
+	HBG_STATS_REG_I(rx_octets_total_filt_cnt,
+			HBG_REG_RX_OCTETS_TOTAL_FILT_ADDR),
+	HBG_STATS_REG_I(rx_uc_pkt_cnt, HBG_REG_RX_UC_PKTS_ADDR),
+	HBG_STATS_REG_I(rx_vlan_pkt_cnt, HBG_REG_RX_TAGGED_ADDR),
+	HBG_STATS_REG_I(rx_filt_pkt_cnt, HBG_REG_RX_FILT_PKT_CNT_ADDR),
+	HBG_STATS_REG_I(rx_data_error_cnt, HBG_REG_RX_DATA_ERR_ADDR),
+	HBG_STATS_REG_I(rx_frame_long_err_cnt, HBG_REG_RX_LONG_ERRORS_ADDR),
+	HBG_STATS_REG_I(rx_jabber_err_cnt, HBG_REG_RX_JABBER_ERRORS_ADDR),
+	HBG_STATS_REG_I(rx_frame_very_long_err_cnt,
+			HBG_REG_RX_VERY_LONG_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_frame_runt_err_cnt, HBG_REG_RX_RUNT_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_frame_short_err_cnt, HBG_REG_RX_SHORT_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_overflow_cnt, HBG_REG_RX_OVER_FLOW_CNT_ADDR),
+	HBG_STATS_REG_I(rx_bufrq_err_cnt, HBG_REG_RX_BUFRQ_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_we_err_cnt, HBG_REG_RX_WE_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_overrun_cnt, HBG_REG_RX_OVERRUN_CNT_ADDR),
+	HBG_STATS_REG_I(rx_lengthfield_err_cnt,
+			HBG_REG_RX_LENGTHFIELD_ERR_CNT_ADDR),
+	HBG_STATS_REG_I(rx_fail_comma_cnt, HBG_REG_RX_FAIL_COMMA_CNT_ADDR),
+	HBG_STATS_I(rx_dma_err_cnt),
+
+	HBG_STATS_REG_I(tx_uc_pkt_cnt, HBG_REG_TX_UC_PKTS_ADDR),
+	HBG_STATS_REG_I(tx_vlan_pkt_cnt, HBG_REG_TX_TAGGED_ADDR),
+	HBG_STATS_REG_I(tx_octets_bad_cnt, HBG_REG_OCTETS_TRANSMITTED_BAD_ADDR),
+
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
+static const struct hbg_ethtool_stats hbg_ethtool_rmon_stats_info[] = {
+	HBG_STATS_I(rx_desc_frag_cnt),
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
+};
+
+static const struct hbg_ethtool_stats hbg_ethtool_mac_stats_info[] = {
+	HBG_STATS_REG_I(rx_mc_pkt_cnt, HBG_REG_RX_MC_PKTS_ADDR),
+	HBG_STATS_REG_I(rx_bc_pkt_cnt, HBG_REG_RX_BC_PKTS_ADDR),
+	HBG_STATS_REG_I(rx_align_error_cnt, HBG_REG_RX_ALIGN_ERRORS_ADDR),
+	HBG_STATS_REG_I(rx_octets_total_ok_cnt,
+			HBG_REG_RX_OCTETS_TOTAL_OK_ADDR),
+	HBG_STATS_REG_I(rx_trans_pkt_cnt, HBG_REG_RX_TRANS_PKG_CNT_ADDR),
+	HBG_STATS_REG_I(rx_fcs_error_cnt, HBG_REG_RX_FCS_ERRORS_ADDR),
+	HBG_STATS_REG_I(tx_mc_pkt_cnt, HBG_REG_TX_MC_PKTS_ADDR),
+	HBG_STATS_REG_I(tx_bc_pkt_cnt, HBG_REG_TX_BC_PKTS_ADDR),
+	HBG_STATS_REG_I(tx_octets_total_ok_cnt,
+			HBG_REG_OCTETS_TRANSMITTED_OK_ADDR),
+	HBG_STATS_REG_I(tx_trans_pkt_cnt, HBG_REG_TX_TRANS_PKG_CNT_ADDR),
+};
+
+static const struct hbg_ethtool_stats hbg_ethtool_ctrl_stats_info[] = {
+	HBG_STATS_REG_I(rx_pause_macctl_frame_cnt,
+			HBG_REG_RX_PAUSE_MACCTL_FRAMCOUNTER_ADDR),
+	HBG_STATS_REG_I(tx_pause_frame_cnt, HBG_REG_TX_PAUSE_FRAMES_ADDR),
+	HBG_STATS_REG_I(rx_unknown_macctl_frame_cnt,
+			HBG_REG_RX_UNKNOWN_MACCTL_FRAMCOUNTER_ADDR),
+};
+
 enum hbg_reg_dump_type {
 	HBG_DUMP_REG_TYPE_SPEC = 0,
 	HBG_DUMP_REG_TYPE_MDIO,
@@ -180,6 +309,167 @@ static int hbg_ethtool_reset(struct net_device *netdev, u32 *flags)
 	return hbg_reset(priv);
 }
 
+static void hbg_update_stats_by_info(struct hbg_priv *priv,
+				     const struct hbg_ethtool_stats *info,
+				     u32 info_len)
+{
+	const struct hbg_ethtool_stats *stats;
+	u32 i;
+
+	for (i = 0; i < info_len; i++) {
+		stats = &info[i];
+		if (!stats->reg)
+			continue;
+
+		HBG_STATS_U(&priv->stats, stats->offset,
+			    hbg_reg_read(priv, stats->reg));
+	}
+}
+
+void hbg_update_stats(struct hbg_priv *priv)
+{
+	hbg_update_stats_by_info(priv, hbg_ethtool_stats_info,
+				 ARRAY_SIZE(hbg_ethtool_stats_info));
+	hbg_update_stats_by_info(priv, hbg_ethtool_rmon_stats_info,
+				 ARRAY_SIZE(hbg_ethtool_rmon_stats_info));
+	hbg_update_stats_by_info(priv, hbg_ethtool_mac_stats_info,
+				 ARRAY_SIZE(hbg_ethtool_mac_stats_info));
+	hbg_update_stats_by_info(priv, hbg_ethtool_ctrl_stats_info,
+				 ARRAY_SIZE(hbg_ethtool_ctrl_stats_info));
+}
+
+static int hbg_ethtool_get_sset_count(struct net_device *netdev, int stringset)
+{
+	if (stringset != ETH_SS_STATS)
+		return -EOPNOTSUPP;
+
+	return ARRAY_SIZE(hbg_ethtool_stats_info);
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
+	for (i = 0; i < ARRAY_SIZE(hbg_ethtool_stats_info); i++)
+		ethtool_puts(&data, hbg_ethtool_stats_info[i].name);
+}
+
+static void hbg_ethtool_get_stats(struct net_device *netdev,
+				  struct ethtool_stats *stats, u64 *data)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	u32 i;
+
+	hbg_update_stats(priv);
+	for (i = 0; i < ARRAY_SIZE(hbg_ethtool_stats_info); i++)
+		*data++ = HBG_STATS_R(&priv->stats,
+				      hbg_ethtool_stats_info[i].offset);
+}
+
+static void hbg_ethtool_get_pause_stats(struct net_device *netdev,
+					struct ethtool_pause_stats *epstats)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct hbg_stats *stats = &priv->stats;
+
+	hbg_update_stats(priv);
+	epstats->rx_pause_frames = stats->rx_pause_macctl_frame_cnt;
+	epstats->tx_pause_frames = stats->tx_pause_frame_cnt;
+}
+
+static void hbg_ethtool_get_eth_mac_stats(struct net_device *netdev,
+					  struct ethtool_eth_mac_stats *emstats)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct hbg_stats *stats = &priv->stats;
+
+	hbg_update_stats(priv);
+	emstats->FramesTransmittedOK = stats->tx_trans_pkt_cnt;
+	emstats->FramesReceivedOK = stats->rx_trans_pkt_cnt;
+	emstats->FrameCheckSequenceErrors = stats->rx_fcs_error_cnt;
+	emstats->AlignmentErrors = stats->rx_align_error_cnt;
+	emstats->OctetsTransmittedOK = stats->tx_octets_total_ok_cnt;
+	emstats->OctetsReceivedOK = stats->rx_octets_total_ok_cnt;
+
+	emstats->MulticastFramesXmittedOK = stats->tx_mc_pkt_cnt;
+	emstats->BroadcastFramesXmittedOK = stats->tx_bc_pkt_cnt;
+	emstats->MulticastFramesReceivedOK = stats->rx_mc_pkt_cnt;
+	emstats->BroadcastFramesReceivedOK = stats->rx_bc_pkt_cnt;
+	emstats->InRangeLengthErrors = stats->rx_fcs_error_cnt +
+				       stats->rx_jabber_err_cnt +
+				       stats->rx_unknown_macctl_frame_cnt +
+				       stats->rx_bufrq_err_cnt +
+				       stats->rx_we_err_cnt;
+	emstats->OutOfRangeLengthField = stats->rx_frame_short_err_cnt +
+					 stats->rx_frame_runt_err_cnt +
+					 stats->rx_lengthfield_err_cnt +
+					 stats->rx_frame_long_err_cnt +
+					 stats->rx_frame_very_long_err_cnt;
+	emstats->FrameTooLongErrors = stats->rx_frame_long_err_cnt +
+				      stats->rx_frame_very_long_err_cnt;
+}
+
+static void
+hbg_ethtool_get_eth_ctrl_stats(struct net_device *netdev,
+			       struct ethtool_eth_ctrl_stats *ecstats)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct hbg_stats *s = &priv->stats;
+
+	hbg_update_stats(priv);
+	ecstats->MACControlFramesTransmitted = s->tx_pause_frame_cnt;
+	ecstats->MACControlFramesReceived = s->rx_pause_macctl_frame_cnt;
+	ecstats->UnsupportedOpcodesReceived = s->rx_unknown_macctl_frame_cnt;
+}
+
+static const struct ethtool_rmon_hist_range hbg_rmon_ranges[] = {
+	{    0,    64 },
+	{   65,   127 },
+	{  128,   255 },
+	{  256,   511 },
+	{  512,  1023 },
+	{ 1024,  1518 },
+	{ 1519,  4095 },
+};
+
+static void
+hbg_ethtool_get_rmon_stats(struct net_device *netdev,
+			   struct ethtool_rmon_stats *rmon_stats,
+			   const struct ethtool_rmon_hist_range **ranges)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct hbg_stats *stats = &priv->stats;
+
+	hbg_update_stats(priv);
+	rmon_stats->undersize_pkts = stats->rx_frame_short_err_cnt +
+				     stats->rx_frame_runt_err_cnt +
+				     stats->rx_lengthfield_err_cnt;
+	rmon_stats->oversize_pkts = stats->rx_frame_long_err_cnt +
+				    stats->rx_frame_very_long_err_cnt;
+	rmon_stats->fragments = stats->rx_desc_frag_cnt;
+	rmon_stats->hist[0] = stats->rx_framesize_64;
+	rmon_stats->hist[1] = stats->rx_framesize_65_127;
+	rmon_stats->hist[2] = stats->rx_framesize_128_255;
+	rmon_stats->hist[3] = stats->rx_framesize_256_511;
+	rmon_stats->hist[4] = stats->rx_framesize_512_1023;
+	rmon_stats->hist[5] = stats->rx_framesize_1024_1518;
+	rmon_stats->hist[6] = stats->rx_framesize_bt_1518;
+
+	rmon_stats->hist_tx[0] = stats->tx_framesize_64;
+	rmon_stats->hist_tx[1] = stats->tx_framesize_65_127;
+	rmon_stats->hist_tx[2] = stats->tx_framesize_128_255;
+	rmon_stats->hist_tx[3] = stats->tx_framesize_256_511;
+	rmon_stats->hist_tx[4] = stats->tx_framesize_512_1023;
+	rmon_stats->hist_tx[5] = stats->tx_framesize_1024_1518;
+	rmon_stats->hist_tx[6] = stats->tx_framesize_bt_1518;
+
+	*ranges = hbg_rmon_ranges;
+}
+
 static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
@@ -190,6 +480,13 @@ static const struct ethtool_ops hbg_ethtool_ops = {
 	.set_pauseparam         = hbg_ethtool_set_pauseparam,
 	.reset			= hbg_ethtool_reset,
 	.nway_reset		= phy_ethtool_nway_reset,
+	.get_sset_count		= hbg_ethtool_get_sset_count,
+	.get_strings		= hbg_ethtool_get_strings,
+	.get_ethtool_stats	= hbg_ethtool_get_stats,
+	.get_pause_stats	= hbg_ethtool_get_pause_stats,
+	.get_eth_mac_stats	= hbg_ethtool_get_eth_mac_stats,
+	.get_eth_ctrl_stats	= hbg_ethtool_get_eth_ctrl_stats,
+	.get_rmon_stats		= hbg_ethtool_get_rmon_stats,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
index 628707ec2686..e173155b146a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.h
@@ -6,6 +6,11 @@
 
 #include <linux/netdevice.h>
 
+#define HBG_STATS_FIELD_OFF(f) (offsetof(struct hbg_stats, f))
+#define HBG_STATS_R(p, offset) (*(u64 *)((u8 *)(p) + (offset)))
+#define HBG_STATS_U(p, offset, val) (HBG_STATS_R(p, offset) += (val))
+
 void hbg_ethtool_set_ops(struct net_device *netdev);
+void hbg_update_stats(struct hbg_priv *priv);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index bb0f25ac9760..4667e51ccc2d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -214,6 +214,10 @@ static void hbg_net_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 	char *buf = ring->tout_log_buf;
 	u32 pos = 0;
 
+	priv->stats.tx_timeout_cnt++;
+
+	pos += scnprintf(buf + pos, HBG_TX_TIMEOUT_BUF_LEN - pos,
+			 "tx_timeout cnt: %llu\n", priv->stats.tx_timeout_cnt);
 	pos += scnprintf(buf + pos, HBG_TX_TIMEOUT_BUF_LEN - pos,
 			 "ring used num: %u, fifo used num: %u\n",
 			 hbg_get_queue_used_num(ring),
@@ -226,6 +230,39 @@ static void hbg_net_tx_timeout(struct net_device *netdev, unsigned int txqueue)
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
+
+	/* fifo empty */
+	stats->tx_fifo_errors += h_stats->tx_drop_cnt;
+
+	stats->tx_dropped += h_stats->tx_excessive_length_drop_cnt +
+			     h_stats->tx_drop_cnt;
+	stats->tx_errors += h_stats->tx_add_cs_fail_cnt +
+			    h_stats->tx_bufrl_err_cnt +
+			    h_stats->tx_underrun_err_cnt +
+			    h_stats->tx_crc_err_cnt;
+	stats->rx_errors += h_stats->rx_data_error_cnt;
+	stats->multicast += h_stats->rx_mc_pkt_cnt;
+	stats->rx_dropped += h_stats->rx_desc_drop;
+	stats->rx_length_errors += h_stats->rx_frame_very_long_err_cnt +
+				   h_stats->rx_frame_long_err_cnt +
+				   h_stats->rx_frame_runt_err_cnt +
+				   h_stats->rx_frame_short_err_cnt +
+				   h_stats->rx_lengthfield_err_cnt;
+	stats->rx_frame_errors += h_stats->rx_desc_l2_err_cnt +
+				  h_stats->rx_desc_l3l4_err_cnt;
+	stats->rx_fifo_errors += h_stats->rx_overflow_cnt +
+				 h_stats->rx_overrun_cnt;
+	stats->rx_crc_errors += h_stats->rx_fcs_error_cnt;
+}
+
 static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_open		= hbg_net_open,
 	.ndo_stop		= hbg_net_stop,
@@ -235,8 +272,37 @@ static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_change_mtu		= hbg_net_change_mtu,
 	.ndo_tx_timeout		= hbg_net_tx_timeout,
 	.ndo_set_rx_mode	= hbg_net_set_rx_mode,
+	.ndo_get_stats64	= hbg_net_get_stats,
 };
 
+static void hbg_service_task(struct work_struct *work)
+{
+	struct hbg_priv *priv = container_of(work, struct hbg_priv,
+					     service_task.work);
+
+	/* The type of statistics register is u32,
+	 * To prevent the statistics register from overflowing,
+	 * the driver dumps the statistics every 5 minutes.
+	 */
+	hbg_update_stats(priv);
+	schedule_delayed_work(&priv->service_task,
+			      msecs_to_jiffies(5 * 60 * MSEC_PER_SEC));
+}
+
+static void hbg_cancel_delayed_work_sync(void *data)
+{
+	cancel_delayed_work_sync(data);
+}
+
+static int hbg_delaywork_init(struct hbg_priv *priv)
+{
+	INIT_DELAYED_WORK(&priv->service_task, hbg_service_task);
+	schedule_delayed_work(&priv->service_task, 0);
+	return devm_add_action_or_reset(&priv->pdev->dev,
+					hbg_cancel_delayed_work_sync,
+					&priv->service_task);
+}
+
 static int hbg_mac_filter_init(struct hbg_priv *priv)
 {
 	struct hbg_dev_specs *dev_specs = &priv->dev_specs;
@@ -291,6 +357,10 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
+	ret = hbg_delaywork_init(priv);
+	if (ret)
+		return ret;
+
 	hbg_debugfs_init(priv);
 	hbg_init_user_def(priv);
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index f12efc12f3c5..106d0e0408ba 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -60,6 +60,48 @@
 #define HBG_REG_TRANSMIT_CTRL_AN_EN_B		BIT(5)
 #define HBG_REG_REC_FILT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0064)
 #define HBG_REG_REC_FILT_CTRL_UC_MATCH_EN_B	BIT(0)
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
 #define HBG_REG_LINE_LOOP_BACK_ADDR		(HBG_REG_SGMII_BASE + 0x01A8)
 #define HBG_REG_CF_CRC_STRIP_ADDR		(HBG_REG_SGMII_BASE + 0x01B0)
 #define HBG_REG_CF_CRC_STRIP_B			BIT(0)
@@ -69,6 +111,9 @@
 #define HBG_REG_RECV_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x01E0)
 #define HBG_REG_RECV_CTRL_STRIP_PAD_EN_B	BIT(3)
 #define HBG_REG_VLAN_CODE_ADDR			(HBG_REG_SGMII_BASE + 0x01E8)
+#define HBG_REG_RX_OVERRUN_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x01EC)
+#define HBG_REG_RX_LENGTHFIELD_ERR_CNT_ADDR	(HBG_REG_SGMII_BASE + 0x01F4)
+#define HBG_REG_RX_FAIL_COMMA_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x01F8)
 #define HBG_REG_STATION_ADDR_LOW_0_ADDR		(HBG_REG_SGMII_BASE + 0x0200)
 #define HBG_REG_STATION_ADDR_HIGH_0_ADDR	(HBG_REG_SGMII_BASE + 0x0204)
 #define HBG_REG_STATION_ADDR_LOW_1_ADDR		(HBG_REG_SGMII_BASE + 0x0208)
@@ -111,12 +156,17 @@
 #define HBG_REG_RX_BUS_ERR_ADDR_ADDR		(HBG_REG_SGMII_BASE + 0x0440)
 #define HBG_REG_MAX_FRAME_LEN_ADDR		(HBG_REG_SGMII_BASE + 0x0444)
 #define HBG_REG_MAX_FRAME_LEN_M			GENMASK(15, 0)
+#define HBG_REG_TX_DROP_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0448)
+#define HBG_REG_RX_OVER_FLOW_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x044C)
 #define HBG_REG_DEBUG_ST_MCH_ADDR		(HBG_REG_SGMII_BASE + 0x0450)
 #define HBG_REG_FIFO_CURR_STATUS_ADDR		(HBG_REG_SGMII_BASE + 0x0454)
 #define HBG_REG_FIFO_HIST_STATUS_ADDR		(HBG_REG_SGMII_BASE + 0x0458)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR		(HBG_REG_SGMII_BASE + 0x045C)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR_TX_M	GENMASK(8, 0)
 #define HBG_REG_CF_CFF_DATA_NUM_ADDR_RX_M	GENMASK(24, 16)
+#define HBG_REG_TX_CS_FAIL_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0460)
+#define HBG_REG_RX_TRANS_PKG_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0464)
+#define HBG_REG_TX_TRANS_PKG_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0468)
 #define HBG_REG_CF_TX_PAUSE_ADDR		(HBG_REG_SGMII_BASE + 0x0470)
 #define HBG_REG_TX_CFF_ADDR_0_ADDR		(HBG_REG_SGMII_BASE + 0x0488)
 #define HBG_REG_TX_CFF_ADDR_1_ADDR		(HBG_REG_SGMII_BASE + 0x048C)
@@ -136,6 +186,9 @@
 #define HBG_REG_RX_CTRL_RXBUF_1ST_SKIP_SIZE2_M	GENMASK(3, 0)
 #define HBG_REG_RX_PKT_MODE_ADDR		(HBG_REG_SGMII_BASE + 0x04F4)
 #define HBG_REG_RX_PKT_MODE_PARSE_MODE_M	GENMASK(22, 21)
+#define HBG_REG_RX_BUFRQ_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x058C)
+#define HBG_REG_TX_BUFRL_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0590)
+#define HBG_REG_RX_WE_ERR_CNT_ADDR		(HBG_REG_SGMII_BASE + 0x0594)
 #define HBG_REG_DBG_ST0_ADDR			(HBG_REG_SGMII_BASE + 0x05E4)
 #define HBG_REG_DBG_ST1_ADDR			(HBG_REG_SGMII_BASE + 0x05E8)
 #define HBG_REG_DBG_ST2_ADDR			(HBG_REG_SGMII_BASE + 0x05EC)
@@ -178,5 +231,48 @@ struct hbg_rx_desc {
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
+	HBG_L3_OK = 0,
+	HBG_L3_WRONG_HEAD,
+	HBG_L3_CSUM_ERR,
+	HBG_L3_LEN_ERR,
+	HBG_L3_ZERO_TTL,
+	HBG_L3_RSVD,
+};
+
+enum hbg_l4_err_code {
+	HBG_L4_OK = 0,
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
index f4f256a0dfea..35dd3512d00e 100644
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
@@ -195,6 +201,156 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
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
+		priv->stats.rx_desc_pkt_len_err_cnt++;
+		return false;
+	}
+
+	if (unlikely(FIELD_GET(HBG_RX_DESC_W2_PORT_NUM_M, desc->word2) !=
+		     priv->dev_specs.mac_id ||
+		     FIELD_GET(HBG_RX_DESC_W4_DROP_B, desc->word4))) {
+		priv->stats.rx_desc_drop++;
+		return false;
+	}
+
+	if (unlikely(FIELD_GET(HBG_RX_DESC_W4_L2_ERR_B, desc->word4))) {
+		priv->stats.rx_desc_l2_err_cnt++;
+		return false;
+	}
+
+	if (unlikely(!hbg_rx_check_l3l4_error(priv, desc))) {
+		priv->stats.rx_desc_l3l4_err_cnt++;
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
@@ -257,8 +413,12 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
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


