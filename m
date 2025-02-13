Return-Path: <netdev+bounces-165801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85563A3368E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1921188C067
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943EE207A06;
	Thu, 13 Feb 2025 04:03:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5705206F33;
	Thu, 13 Feb 2025 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419406; cv=none; b=XVgEXIz2vUY93kJ1ngcZY7UV9ixZNTw3cmsyw50kwb9j2vkJoTTNbQYojP9EgX+ErP9lSAt9PxaeeJw/OxBTquVhAMBBCicyAY6V5KJca4mctRo75phOna+pSdasoi1fJJYX2QorKKyHfAISlL4o7QUHyfwndq0EYqHRMr1f6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419406; c=relaxed/simple;
	bh=OgT3h1ohbAePLhwT5q49zf5Z9UGq8edxSHHtO0sAG30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7WnBVLT5y/IAfLEk4HKd+w/4SdcV+iB+VU65tmB51T2T0MJGpHtRP/eaHCmAiPI95GUC4WnsG8Ob2mhANwToblzUiZtOQlumP3w+aIe5QeTBknruU5DwRQrUkw1SC/IFj2g3KRs4XmjqN5oywri+LdJQAWNt6T8kj5BIdwsNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YthHr1zqqz1W5YR;
	Thu, 13 Feb 2025 11:58:48 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 313371402E2;
	Thu, 13 Feb 2025 12:03:16 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 12:03:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 6/7] net: hibmcge: Add BMC diagnose feature in this module
Date: Thu, 13 Feb 2025 11:55:28 +0800
Message-ID: <20250213035529.2402283-7-shaojijie@huawei.com>
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

The MAC hardware is on the BMC side, and the driver is on the host side.
When the driver is abnormal, the BMC cannot directly detect the
exception cause.
Therefore, this patch implements the BMC diagnosis feature.

When users query driver diagnosis information on the BMC, the driver
detects the query request in the scheduled task and reports
driver statistics and link status to the BMC through the bar space.
The BMC collects logs to analyze exception causes.

Currently, the scheduled task is executed every 5 minutes.
To quickly respond to user query requests,
this patch changes the scheduled task to once every second.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hibmcge/Makefile   |   2 +-
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |   1 +
 .../ethernet/hisilicon/hibmcge/hbg_diagnose.c | 348 ++++++++++++++++++
 .../ethernet/hisilicon/hibmcge/hbg_diagnose.h |  11 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  11 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   7 +
 6 files changed, 377 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/Makefile b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
index 7ea15f9ef849..1a9da564b306 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/Makefile
+++ b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
@@ -6,4 +6,4 @@
 obj-$(CONFIG_HIBMCGE) += hibmcge.o
 
 hibmcge-objs = hbg_main.o hbg_hw.o hbg_mdio.o hbg_irq.o hbg_txrx.o hbg_ethtool.o \
-		hbg_debugfs.o hbg_err.o
+		hbg_debugfs.o hbg_err.o hbg_diagnose.o
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index e942a1e6f859..a8982a4a8988 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -278,6 +278,7 @@ struct hbg_priv {
 	enum hbg_reset_type reset_type;
 	struct hbg_user_def user_def;
 	struct hbg_stats stats;
+	unsigned long last_update_stats_time;
 	struct delayed_work service_task;
 
 	self_test_pkt_recv self_test_pkt_recv_fn;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
new file mode 100644
index 000000000000..d61c03f34ff0
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2025 Hisilicon Limited.
+
+#include <linux/iopoll.h>
+#include <linux/phy.h>
+#include "hbg_common.h"
+#include "hbg_ethtool.h"
+#include "hbg_hw.h"
+#include "hbg_diagnose.h"
+
+#define HBG_MSG_DATA_MAX_NUM	64
+
+struct hbg_diagnose_message {
+	u32 opcode;
+	u32 status;
+	u32 data_num;
+	struct hbg_priv *priv;
+
+	u32 data[HBG_MSG_DATA_MAX_NUM];
+};
+
+#define HBG_HW_PUSH_WAIT_TIMEOUT_US	(2 * 1000 * 1000)
+#define HBG_HW_PUSH_WAIT_INTERVAL_US	(1 * 1000)
+
+enum hbg_push_cmd {
+	HBG_PUSH_CMD_IRQ = 0,
+	HBG_PUSH_CMD_STATS,
+	HBG_PUSH_CMD_LINK,
+};
+
+struct hbg_push_stats_info {
+	/* id is used to match the name of the current stats item.
+	 * and is used for pretty print on BMC
+	 */
+	u32 id;
+	u64 offset;
+};
+
+struct hbg_push_irq_info {
+	/* id is used to match the name of the current irq.
+	 * and is used for pretty print on BMC
+	 */
+	u32 id;
+	u32 mask;
+};
+
+#define HBG_PUSH_IRQ_I(name, id) {id, HBG_INT_MSK_##name##_B}
+static const struct hbg_push_irq_info hbg_push_irq_list[] = {
+	HBG_PUSH_IRQ_I(RX, 0),
+	HBG_PUSH_IRQ_I(TX, 1),
+	HBG_PUSH_IRQ_I(TX_PKT_CPL, 2),
+	HBG_PUSH_IRQ_I(MAC_MII_FIFO_ERR, 3),
+	HBG_PUSH_IRQ_I(MAC_PCS_RX_FIFO_ERR, 4),
+	HBG_PUSH_IRQ_I(MAC_PCS_TX_FIFO_ERR, 5),
+	HBG_PUSH_IRQ_I(MAC_APP_RX_FIFO_ERR, 6),
+	HBG_PUSH_IRQ_I(MAC_APP_TX_FIFO_ERR, 7),
+	HBG_PUSH_IRQ_I(SRAM_PARITY_ERR, 8),
+	HBG_PUSH_IRQ_I(TX_AHB_ERR, 9),
+	HBG_PUSH_IRQ_I(RX_BUF_AVL, 10),
+	HBG_PUSH_IRQ_I(REL_BUF_ERR, 11),
+	HBG_PUSH_IRQ_I(TXCFG_AVL, 12),
+	HBG_PUSH_IRQ_I(TX_DROP, 13),
+	HBG_PUSH_IRQ_I(RX_DROP, 14),
+	HBG_PUSH_IRQ_I(RX_AHB_ERR, 15),
+	HBG_PUSH_IRQ_I(MAC_FIFO_ERR, 16),
+	HBG_PUSH_IRQ_I(RBREQ_ERR, 17),
+	HBG_PUSH_IRQ_I(WE_ERR, 18),
+};
+
+#define HBG_PUSH_STATS_I(name, id) {id, HBG_STATS_FIELD_OFF(name)}
+static const struct hbg_push_stats_info hbg_push_stats_list[] = {
+	HBG_PUSH_STATS_I(rx_desc_drop, 0),
+	HBG_PUSH_STATS_I(rx_desc_l2_err_cnt, 1),
+	HBG_PUSH_STATS_I(rx_desc_pkt_len_err_cnt, 2),
+	HBG_PUSH_STATS_I(rx_desc_l3_wrong_head_cnt, 3),
+	HBG_PUSH_STATS_I(rx_desc_l3_csum_err_cnt, 4),
+	HBG_PUSH_STATS_I(rx_desc_l3_len_err_cnt, 5),
+	HBG_PUSH_STATS_I(rx_desc_l3_zero_ttl_cnt, 6),
+	HBG_PUSH_STATS_I(rx_desc_l3_other_cnt, 7),
+	HBG_PUSH_STATS_I(rx_desc_l4_err_cnt, 8),
+	HBG_PUSH_STATS_I(rx_desc_l4_wrong_head_cnt, 9),
+	HBG_PUSH_STATS_I(rx_desc_l4_len_err_cnt, 10),
+	HBG_PUSH_STATS_I(rx_desc_l4_csum_err_cnt, 11),
+	HBG_PUSH_STATS_I(rx_desc_l4_zero_port_num_cnt, 12),
+	HBG_PUSH_STATS_I(rx_desc_l4_other_cnt, 13),
+	HBG_PUSH_STATS_I(rx_desc_frag_cnt, 14),
+	HBG_PUSH_STATS_I(rx_desc_ip_ver_err_cnt, 15),
+	HBG_PUSH_STATS_I(rx_desc_ipv4_pkt_cnt, 16),
+	HBG_PUSH_STATS_I(rx_desc_ipv6_pkt_cnt, 17),
+	HBG_PUSH_STATS_I(rx_desc_no_ip_pkt_cnt, 18),
+	HBG_PUSH_STATS_I(rx_desc_ip_pkt_cnt, 19),
+	HBG_PUSH_STATS_I(rx_desc_tcp_pkt_cnt, 20),
+	HBG_PUSH_STATS_I(rx_desc_udp_pkt_cnt, 21),
+	HBG_PUSH_STATS_I(rx_desc_vlan_pkt_cnt, 22),
+	HBG_PUSH_STATS_I(rx_desc_icmp_pkt_cnt, 23),
+	HBG_PUSH_STATS_I(rx_desc_arp_pkt_cnt, 24),
+	HBG_PUSH_STATS_I(rx_desc_rarp_pkt_cnt, 25),
+	HBG_PUSH_STATS_I(rx_desc_multicast_pkt_cnt, 26),
+	HBG_PUSH_STATS_I(rx_desc_broadcast_pkt_cnt, 27),
+	HBG_PUSH_STATS_I(rx_desc_ipsec_pkt_cnt, 28),
+	HBG_PUSH_STATS_I(rx_desc_ip_opt_pkt_cnt, 29),
+	HBG_PUSH_STATS_I(rx_desc_key_not_match_cnt, 30),
+	HBG_PUSH_STATS_I(rx_octets_total_ok_cnt, 31),
+	HBG_PUSH_STATS_I(rx_uc_pkt_cnt, 32),
+	HBG_PUSH_STATS_I(rx_mc_pkt_cnt, 33),
+	HBG_PUSH_STATS_I(rx_bc_pkt_cnt, 34),
+	HBG_PUSH_STATS_I(rx_vlan_pkt_cnt, 35),
+	HBG_PUSH_STATS_I(rx_octets_bad_cnt, 36),
+	HBG_PUSH_STATS_I(rx_octets_total_filt_cnt, 37),
+	HBG_PUSH_STATS_I(rx_filt_pkt_cnt, 38),
+	HBG_PUSH_STATS_I(rx_trans_pkt_cnt, 39),
+	HBG_PUSH_STATS_I(rx_framesize_64, 40),
+	HBG_PUSH_STATS_I(rx_framesize_65_127, 41),
+	HBG_PUSH_STATS_I(rx_framesize_128_255, 42),
+	HBG_PUSH_STATS_I(rx_framesize_256_511, 43),
+	HBG_PUSH_STATS_I(rx_framesize_512_1023, 44),
+	HBG_PUSH_STATS_I(rx_framesize_1024_1518, 45),
+	HBG_PUSH_STATS_I(rx_framesize_bt_1518, 46),
+	HBG_PUSH_STATS_I(rx_fcs_error_cnt, 47),
+	HBG_PUSH_STATS_I(rx_data_error_cnt, 48),
+	HBG_PUSH_STATS_I(rx_align_error_cnt, 49),
+	HBG_PUSH_STATS_I(rx_frame_long_err_cnt, 50),
+	HBG_PUSH_STATS_I(rx_jabber_err_cnt, 51),
+	HBG_PUSH_STATS_I(rx_pause_macctl_frame_cnt, 52),
+	HBG_PUSH_STATS_I(rx_unknown_macctl_frame_cnt, 53),
+	HBG_PUSH_STATS_I(rx_frame_very_long_err_cnt, 54),
+	HBG_PUSH_STATS_I(rx_frame_runt_err_cnt, 55),
+	HBG_PUSH_STATS_I(rx_frame_short_err_cnt, 56),
+	HBG_PUSH_STATS_I(rx_overflow_cnt, 57),
+	HBG_PUSH_STATS_I(rx_bufrq_err_cnt, 58),
+	HBG_PUSH_STATS_I(rx_we_err_cnt, 59),
+	HBG_PUSH_STATS_I(rx_overrun_cnt, 60),
+	HBG_PUSH_STATS_I(rx_lengthfield_err_cnt, 61),
+	HBG_PUSH_STATS_I(rx_fail_comma_cnt, 62),
+	HBG_PUSH_STATS_I(rx_dma_err_cnt, 63),
+	HBG_PUSH_STATS_I(rx_fifo_less_empty_thrsld_cnt, 64),
+	HBG_PUSH_STATS_I(tx_octets_total_ok_cnt, 65),
+	HBG_PUSH_STATS_I(tx_uc_pkt_cnt, 66),
+	HBG_PUSH_STATS_I(tx_mc_pkt_cnt, 67),
+	HBG_PUSH_STATS_I(tx_bc_pkt_cnt, 68),
+	HBG_PUSH_STATS_I(tx_vlan_pkt_cnt, 69),
+	HBG_PUSH_STATS_I(tx_octets_bad_cnt, 70),
+	HBG_PUSH_STATS_I(tx_trans_pkt_cnt, 71),
+	HBG_PUSH_STATS_I(tx_pause_frame_cnt, 72),
+	HBG_PUSH_STATS_I(tx_framesize_64, 73),
+	HBG_PUSH_STATS_I(tx_framesize_65_127, 74),
+	HBG_PUSH_STATS_I(tx_framesize_128_255, 75),
+	HBG_PUSH_STATS_I(tx_framesize_256_511, 76),
+	HBG_PUSH_STATS_I(tx_framesize_512_1023, 77),
+	HBG_PUSH_STATS_I(tx_framesize_1024_1518, 78),
+	HBG_PUSH_STATS_I(tx_framesize_bt_1518, 79),
+	HBG_PUSH_STATS_I(tx_underrun_err_cnt, 80),
+	HBG_PUSH_STATS_I(tx_add_cs_fail_cnt, 81),
+	HBG_PUSH_STATS_I(tx_bufrl_err_cnt, 82),
+	HBG_PUSH_STATS_I(tx_crc_err_cnt, 83),
+	HBG_PUSH_STATS_I(tx_drop_cnt, 84),
+	HBG_PUSH_STATS_I(tx_excessive_length_drop_cnt, 85),
+	HBG_PUSH_STATS_I(tx_dma_err_cnt, 86),
+};
+
+static int hbg_push_msg_send(struct hbg_priv *priv,
+			     struct hbg_diagnose_message *msg)
+{
+	u32 header = 0;
+	u32 i;
+
+	if (msg->data_num == 0)
+		return 0;
+
+	for (i = 0; i < msg->data_num && i < HBG_MSG_DATA_MAX_NUM; i++)
+		hbg_reg_write(priv,
+			      HBG_REG_MSG_DATA_BASE_ADDR + i * sizeof(u32),
+			      msg->data[i]);
+
+	hbg_field_modify(header, HBG_REG_MSG_HEADER_OPCODE_M, msg->opcode);
+	hbg_field_modify(header, HBG_REG_MSG_HEADER_DATA_NUM_M,  msg->data_num);
+	hbg_field_modify(header, HBG_REG_MSG_HEADER_RESP_CODE_M, ETIMEDOUT);
+
+	/* start status */
+	hbg_field_modify(header, HBG_REG_MSG_HEADER_STATUS_M, 1);
+
+	/* write header msg to start push */
+	hbg_reg_write(priv, HBG_REG_MSG_HEADER_ADDR, header);
+
+	/* wait done */
+	readl_poll_timeout(priv->io_base + HBG_REG_MSG_HEADER_ADDR, header,
+			   !FIELD_GET(HBG_REG_MSG_HEADER_STATUS_M, header),
+			   HBG_HW_PUSH_WAIT_INTERVAL_US,
+			   HBG_HW_PUSH_WAIT_TIMEOUT_US);
+
+	msg->status = FIELD_GET(HBG_REG_MSG_HEADER_STATUS_M, header);
+	return -(int)FIELD_GET(HBG_REG_MSG_HEADER_RESP_CODE_M, header);
+}
+
+static int hbg_push_data(struct hbg_priv *priv,
+			 u32 opcode, u32 *data, u32 data_num)
+{
+	struct hbg_diagnose_message msg = {0};
+	u32 data_left_num;
+	u32 i, j;
+	int ret;
+
+	msg.priv = priv;
+	msg.opcode = opcode;
+	for (i = 0; i < data_num / HBG_MSG_DATA_MAX_NUM + 1; i++) {
+		if (i * HBG_MSG_DATA_MAX_NUM >= data_num)
+			break;
+
+		data_left_num = data_num - i * HBG_MSG_DATA_MAX_NUM;
+		for (j = 0; j < data_left_num && j < HBG_MSG_DATA_MAX_NUM; j++)
+			msg.data[j] = data[i * HBG_MSG_DATA_MAX_NUM + j];
+
+		msg.data_num = j;
+		ret = hbg_push_msg_send(priv, &msg);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int hbg_push_data_u64(struct hbg_priv *priv, u32 opcode,
+			     u64 *data, u32 data_num)
+{
+	/* The length of u64 is twice that of u32,
+	 * the data_num must be multiplied by 2.
+	 */
+	return hbg_push_data(priv, opcode, (u32 *)data, data_num * 2);
+}
+
+static u64 hbg_get_irq_stats(struct hbg_vector *vectors, u32 mask)
+{
+	u32 i = 0;
+
+	for (i = 0; i < vectors->info_array_len; i++)
+		if (vectors->info_array[i].mask == mask)
+			return vectors->info_array[i].count;
+
+	return 0;
+}
+
+static int hbg_push_irq_cnt(struct hbg_priv *priv)
+{
+	/* An id needs to be added for each data.
+	 * Therefore, the data_num must be multiplied by 2.
+	 */
+	u32 data_num = ARRAY_SIZE(hbg_push_irq_list) * 2;
+	struct hbg_vector *vectors = &priv->vectors;
+	const struct hbg_push_irq_info *info;
+	u32 i, j = 0;
+	u64 *data;
+	int ret;
+
+	data = kcalloc(data_num, sizeof(u64), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* An id needs to be added for each data.
+	 * So i + 2 for each loop.
+	 */
+	for (i = 0; i < data_num; i += 2) {
+		info = &hbg_push_irq_list[j++];
+		data[i] = info->id;
+		data[i + 1] = hbg_get_irq_stats(vectors, info->mask);
+	}
+
+	ret = hbg_push_data_u64(priv, HBG_PUSH_CMD_IRQ, data, data_num);
+	kfree(data);
+	return ret;
+}
+
+static int hbg_push_link_status(struct hbg_priv *priv)
+{
+	u32 link_status[2];
+
+	/* phy link status */
+	link_status[0] = priv->mac.phydev->link;
+	/* mac link status */
+	link_status[1] = hbg_reg_read_field(priv, HBG_REG_AN_NEG_STATE_ADDR,
+					    HBG_REG_AN_NEG_STATE_NP_LINK_OK_B);
+
+	return hbg_push_data(priv, HBG_PUSH_CMD_LINK,
+			     link_status, ARRAY_SIZE(link_status));
+}
+
+static int hbg_push_stats(struct hbg_priv *priv)
+{
+	/* An id needs to be added for each data.
+	 * Therefore, the data_num must be multiplied by 2.
+	 */
+	u64 data_num = ARRAY_SIZE(hbg_push_stats_list) * 2;
+	struct hbg_stats *stats = &priv->stats;
+	const struct hbg_push_stats_info *info;
+	u32 i, j = 0;
+	u64 *data;
+	int ret;
+
+	data = kcalloc(data_num, sizeof(u64), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* An id needs to be added for each data.
+	 * So i + 2 for each loop.
+	 */
+	for (i = 0; i < data_num; i += 2) {
+		info = &hbg_push_stats_list[j++];
+		data[i] = info->id;
+		data[i + 1] = HBG_STATS_R(stats, info->offset);
+	}
+
+	ret = hbg_push_data_u64(priv, HBG_PUSH_CMD_STATS, data, data_num);
+	kfree(data);
+	return ret;
+}
+
+void hbg_diagnose_message_push(struct hbg_priv *priv)
+{
+	int ret;
+
+	if (test_bit(HBG_NIC_STATE_RESETTING, &priv->state))
+		return;
+
+	/* only 1 is the right value */
+	if (hbg_reg_read(priv, HBG_REG_PUSH_REQ_ADDR) != 1)
+		return;
+
+	ret = hbg_push_irq_cnt(priv);
+	if (ret) {
+		dev_err(&priv->pdev->dev,
+			"failed to push irq cnt, ret = %d\n", ret);
+		goto push_done;
+	}
+
+	ret = hbg_push_link_status(priv);
+	if (ret) {
+		dev_err(&priv->pdev->dev,
+			"failed to push link status, ret = %d\n", ret);
+		goto push_done;
+	}
+
+	ret = hbg_push_stats(priv);
+	if (ret)
+		dev_err(&priv->pdev->dev,
+			"failed to push stats, ret = %d\n", ret);
+
+push_done:
+	hbg_reg_write(priv, HBG_REG_PUSH_REQ_ADDR, 0);
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.h
new file mode 100644
index 000000000000..ba04c6d8c03d
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2025 Hisilicon Limited. */
+
+#ifndef __HBG_DIAGNOSE_H
+#define __HBG_DIAGNOSE_H
+
+#include "hbg_common.h"
+
+void hbg_diagnose_message_push(struct hbg_priv *priv);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index a7bbb19017b9..78999d41f41d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -6,6 +6,7 @@
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_common.h"
+#include "hbg_diagnose.h"
 #include "hbg_err.h"
 #include "hbg_ethtool.h"
 #include "hbg_hw.h"
@@ -293,13 +294,19 @@ static void hbg_service_task(struct work_struct *work)
 	if (test_and_clear_bit(HBG_NIC_STATE_NEED_RESET, &priv->state))
 		hbg_err_reset(priv);
 
+	hbg_diagnose_message_push(priv);
+
 	/* The type of statistics register is u32,
 	 * To prevent the statistics register from overflowing,
 	 * the driver dumps the statistics every 5 minutes.
 	 */
-	hbg_update_stats(priv);
+	if (time_after(jiffies, priv->last_update_stats_time + 5 * 60 * HZ)) {
+		hbg_update_stats(priv);
+		priv->last_update_stats_time = jiffies;
+	}
+
 	schedule_delayed_work(&priv->service_task,
-			      msecs_to_jiffies(5 * 60 * MSEC_PER_SEC));
+			      msecs_to_jiffies(MSEC_PER_SEC));
 }
 
 void hbg_err_reset_task_schedule(struct hbg_priv *priv)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 9f9346b7f1be..5feee123ecbe 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -18,6 +18,13 @@
 #define HBG_REG_TX_FIFO_NUM_ADDR		0x0030
 #define HBG_REG_RX_FIFO_NUM_ADDR		0x0034
 #define HBG_REG_VLAN_LAYERS_ADDR		0x0038
+#define HBG_REG_PUSH_REQ_ADDR			0x00F0
+#define HBG_REG_MSG_HEADER_ADDR			0x00F4
+#define HBG_REG_MSG_HEADER_OPCODE_M		GENMASK(7, 0)
+#define HBG_REG_MSG_HEADER_STATUS_M		GENMASK(11, 8)
+#define HBG_REG_MSG_HEADER_DATA_NUM_M		GENMASK(19, 12)
+#define HBG_REG_MSG_HEADER_RESP_CODE_M		GENMASK(27, 20)
+#define HBG_REG_MSG_DATA_BASE_ADDR		0x0100
 
 /* MDIO */
 #define HBG_REG_MDIO_BASE			0x8000
-- 
2.33.0


