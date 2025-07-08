Return-Path: <netdev+bounces-204970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B149AFCB82
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4541C2003F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3CF2E1C4E;
	Tue,  8 Jul 2025 13:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93BD2DECB5;
	Tue,  8 Jul 2025 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980092; cv=none; b=HSIfnpiU7hYApNn9/c4EmmZ0ZfRmV/Hl8aGF2I8BAyIIIstl9qMCjKWCNFkNwF5LXbWc1c7d7Bflb8h9M6DkUgJApsTSQEDdn/QG2hkWg8IArltVU+uF8Ri5BDSIcv41pZxldxJbUilbiEyVY6dcBoz8kC+nh6iUkvc9xcv/OD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980092; c=relaxed/simple;
	bh=SYn6/xvL1irec70hS1gy44irh9YtMxDzpKxJbwdyTYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ni4TXaCWy7xBMxTZnCoWdWYAQBcH50Kws/Wl93DuBuol6w+QbVlm1XL101tVa2Z1YmL4f4WF2fSsSRU+gh3R6BZfCXiOEfkDqPYc2SlGI6c7A5l2x221j0vr8aSSPEHpIj+ZT9Mhtkq66zkscSDDbmzjH+FHYGW5Vk/aD6ZIN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bc1Yb3xClz1d1sZ;
	Tue,  8 Jul 2025 21:05:23 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 154821800B1;
	Tue,  8 Jul 2025 21:08:01 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 21:08:00 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 09/11] net: hns3: use seq_file for files in common/ of hclge layer
Date: Tue, 8 Jul 2025 21:00:27 +0800
Message-ID: <20250708130029.1310872-10-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250708130029.1310872-1-shaojijie@huawei.com>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Yonglong Liu <liuyonglong@huawei.com>

This patch use seq_file for the following nodes:
mng_tbl/loopback/interrupt_info/reset_info/imp_info/ncl_config/
mac_tnl_status/service_task_info/vlan_config/ptp_info

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  22 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 426 ++++++++----------
 2 files changed, 200 insertions(+), 248 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index e471d6fcdd1b..7e9208e69c74 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -163,49 +163,49 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_MNG_TBL,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "loopback",
 		.cmd = HNAE3_DBG_CMD_LOOPBACK,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "interrupt_info",
 		.cmd = HNAE3_DBG_CMD_INTERRUPT_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "reset_info",
 		.cmd = HNAE3_DBG_CMD_RESET_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "imp_info",
 		.cmd = HNAE3_DBG_CMD_IMP_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ncl_config",
 		.cmd = HNAE3_DBG_CMD_NCL_CONFIG,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN_128KB,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mac_tnl_status",
 		.cmd = HNAE3_DBG_CMD_MAC_TNL_STATUS,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "bios_common",
@@ -317,21 +317,21 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_SERV_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "vlan_config",
 		.cmd = HNAE3_DBG_CMD_VLAN_CONFIG,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ptp_info",
 		.cmd = HNAE3_DBG_CMD_PTP_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "fd_counter",
@@ -345,7 +345,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_UMV_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "page_pool_info",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index a8b87b8ec292..00cf6cc89eda 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -1950,19 +1950,17 @@ static int hclge_dbg_dump_qos_buf_cfg(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int hclge_dbg_dump_mng_table(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_mng_table(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_mac_ethertype_idx_rd_cmd *req0;
 	struct hclge_desc desc;
 	u32 msg_egress_port;
-	int pos = 0;
 	int ret, i;
 
-	pos += scnprintf(buf + pos, len - pos,
-			 "entry  mac_addr          mask  ether  ");
-	pos += scnprintf(buf + pos, len - pos,
-			 "mask  vlan  mask  i_map  i_dir  e_type  ");
-	pos += scnprintf(buf + pos, len - pos, "pf_id  vf_id  q_id  drop\n");
+	seq_puts(s, "entry  mac_addr          mask  ether  ");
+	seq_puts(s, "mask  vlan  mask  i_map  i_dir  e_type  ");
+	seq_puts(s, "pf_id  vf_id  q_id  drop\n");
 
 	for (i = 0; i < HCLGE_DBG_MNG_TBL_MAX; i++) {
 		hclge_cmd_setup_basic_desc(&desc, HCLGE_MAC_ETHERTYPE_IDX_RD,
@@ -1980,30 +1978,27 @@ static int hclge_dbg_dump_mng_table(struct hclge_dev *hdev, char *buf, int len)
 		if (!req0->resp_code)
 			continue;
 
-		pos += scnprintf(buf + pos, len - pos, "%02u     %pM ",
-				 le16_to_cpu(req0->index), req0->mac_addr);
+		seq_printf(s, "%02u     %pM ",
+			   le16_to_cpu(req0->index), req0->mac_addr);
 
-		pos += scnprintf(buf + pos, len - pos,
-				 "%x     %04x   %x     %04x  ",
-				 !!(req0->flags & HCLGE_DBG_MNG_MAC_MASK_B),
-				 le16_to_cpu(req0->ethter_type),
-				 !!(req0->flags & HCLGE_DBG_MNG_ETHER_MASK_B),
-				 le16_to_cpu(req0->vlan_tag) &
-				 HCLGE_DBG_MNG_VLAN_TAG);
+		seq_printf(s, "%x     %04x   %x     %04x  ",
+			   !!(req0->flags & HCLGE_DBG_MNG_MAC_MASK_B),
+			   le16_to_cpu(req0->ethter_type),
+			   !!(req0->flags & HCLGE_DBG_MNG_ETHER_MASK_B),
+			   le16_to_cpu(req0->vlan_tag) &
+			   HCLGE_DBG_MNG_VLAN_TAG);
 
-		pos += scnprintf(buf + pos, len - pos,
-				 "%x     %02x     %02x     ",
-				 !!(req0->flags & HCLGE_DBG_MNG_VLAN_MASK_B),
-				 req0->i_port_bitmap, req0->i_port_direction);
+		seq_printf(s, "%x     %02x     %02x     ",
+			   !!(req0->flags & HCLGE_DBG_MNG_VLAN_MASK_B),
+			   req0->i_port_bitmap, req0->i_port_direction);
 
 		msg_egress_port = le16_to_cpu(req0->egress_port);
-		pos += scnprintf(buf + pos, len - pos,
-				 "%x       %x      %02x     %04x  %x\n",
-				 !!(msg_egress_port & HCLGE_DBG_MNG_E_TYPE_B),
-				 msg_egress_port & HCLGE_DBG_MNG_PF_ID,
-				 (msg_egress_port >> 3) & HCLGE_DBG_MNG_VF_ID,
-				 le16_to_cpu(req0->egress_queue),
-				 !!(msg_egress_port & HCLGE_DBG_MNG_DROP_B));
+		seq_printf(s, "%x       %x      %02x     %04x  %x\n",
+			   !!(msg_egress_port & HCLGE_DBG_MNG_E_TYPE_B),
+			   msg_egress_port & HCLGE_DBG_MNG_PF_ID,
+			   (msg_egress_port >> 3) & HCLGE_DBG_MNG_VF_ID,
+			   le16_to_cpu(req0->egress_queue),
+			   !!(msg_egress_port & HCLGE_DBG_MNG_DROP_B));
 	}
 
 	return 0;
@@ -2213,74 +2208,95 @@ int hclge_dbg_dump_rst_info(struct hclge_dev *hdev, char *buf, int len)
 	return 0;
 }
 
-static int hclge_dbg_dump_serv_info(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_seq_dump_rst_info(struct seq_file *s, void *data)
+{
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
+	u32 i, offset;
+
+	seq_printf(s, "PF reset count: %u\n", hdev->rst_stats.pf_rst_cnt);
+	seq_printf(s, "FLR reset count: %u\n", hdev->rst_stats.flr_rst_cnt);
+	seq_printf(s, "GLOBAL reset count: %u\n",
+		   hdev->rst_stats.global_rst_cnt);
+	seq_printf(s, "IMP reset count: %u\n", hdev->rst_stats.imp_rst_cnt);
+	seq_printf(s, "reset done count: %u\n", hdev->rst_stats.reset_done_cnt);
+	seq_printf(s, "HW reset done count: %u\n",
+		   hdev->rst_stats.hw_reset_done_cnt);
+	seq_printf(s, "reset count: %u\n", hdev->rst_stats.reset_cnt);
+	seq_printf(s, "reset fail count: %u\n", hdev->rst_stats.reset_fail_cnt);
+
+	for (i = 0; i < ARRAY_SIZE(hclge_dbg_rst_info); i++) {
+		offset = hclge_dbg_rst_info[i].offset;
+		seq_printf(s, "%s: 0x%x\n",
+			   hclge_dbg_rst_info[i].message,
+			   hclge_read_dev(&hdev->hw, offset));
+	}
+
+	seq_printf(s, "hdev state: 0x%lx\n", hdev->state);
+
+	return 0;
+}
+
+static int hclge_dbg_dump_serv_info(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	unsigned long rem_nsec;
-	int pos = 0;
 	u64 lc;
 
 	lc = local_clock();
 	rem_nsec = do_div(lc, HCLGE_BILLION_NANO_SECONDS);
 
-	pos += scnprintf(buf + pos, len - pos, "local_clock: [%5lu.%06lu]\n",
-			 (unsigned long)lc, rem_nsec / 1000);
-	pos += scnprintf(buf + pos, len - pos, "delta: %u(ms)\n",
-			 jiffies_to_msecs(jiffies - hdev->last_serv_processed));
-	pos += scnprintf(buf + pos, len - pos,
-			 "last_service_task_processed: %lu(jiffies)\n",
-			 hdev->last_serv_processed);
-	pos += scnprintf(buf + pos, len - pos, "last_service_task_cnt: %lu\n",
-			 hdev->serv_processed_cnt);
+	seq_printf(s, "local_clock: [%5lu.%06lu]\n",
+		   (unsigned long)lc, rem_nsec / 1000);
+	seq_printf(s, "delta: %u(ms)\n",
+		   jiffies_to_msecs(jiffies - hdev->last_serv_processed));
+	seq_printf(s, "last_service_task_processed: %lu(jiffies)\n",
+		   hdev->last_serv_processed);
+	seq_printf(s, "last_service_task_cnt: %lu\n", hdev->serv_processed_cnt);
 
 	return 0;
 }
 
-static int hclge_dbg_dump_interrupt(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_interrupt(struct seq_file *s, void *data)
 {
-	int pos = 0;
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 
-	pos += scnprintf(buf + pos, len - pos, "num_nic_msi: %u\n",
-			 hdev->num_nic_msi);
-	pos += scnprintf(buf + pos, len - pos, "num_roce_msi: %u\n",
-			 hdev->num_roce_msi);
-	pos += scnprintf(buf + pos, len - pos, "num_msi_used: %u\n",
-			 hdev->num_msi_used);
-	pos += scnprintf(buf + pos, len - pos, "num_msi_left: %u\n",
-			 hdev->num_msi_left);
+	seq_printf(s, "num_nic_msi: %u\n", hdev->num_nic_msi);
+	seq_printf(s, "num_roce_msi: %u\n", hdev->num_roce_msi);
+	seq_printf(s, "num_msi_used: %u\n", hdev->num_msi_used);
+	seq_printf(s, "num_msi_left: %u\n", hdev->num_msi_left);
 
 	return 0;
 }
 
-static void hclge_dbg_imp_info_data_print(struct hclge_desc *desc_src,
-					  char *buf, int len, u32 bd_num)
+static void hclge_dbg_imp_info_data_print(struct seq_file *s,
+					  struct hclge_desc *desc_src,
+					  u32 bd_num)
 {
 #define HCLGE_DBG_IMP_INFO_PRINT_OFFSET 0x2
 
 	struct hclge_desc *desc_index = desc_src;
 	u32 offset = 0;
-	int pos = 0;
 	u32 i, j;
 
-	pos += scnprintf(buf + pos, len - pos, "offset | data\n");
+	seq_puts(s, "offset | data\n");
 
 	for (i = 0; i < bd_num; i++) {
 		j = 0;
 		while (j < HCLGE_DESC_DATA_LEN - 1) {
-			pos += scnprintf(buf + pos, len - pos, "0x%04x | ",
-					 offset);
-			pos += scnprintf(buf + pos, len - pos, "0x%08x  ",
-					 le32_to_cpu(desc_index->data[j++]));
-			pos += scnprintf(buf + pos, len - pos, "0x%08x\n",
-					 le32_to_cpu(desc_index->data[j++]));
+			seq_printf(s, "0x%04x | ", offset);
+			seq_printf(s, "0x%08x  ",
+				   le32_to_cpu(desc_index->data[j++]));
+			seq_printf(s, "0x%08x\n",
+				   le32_to_cpu(desc_index->data[j++]));
 			offset += sizeof(u32) * HCLGE_DBG_IMP_INFO_PRINT_OFFSET;
 		}
 		desc_index++;
 	}
 }
 
-static int
-hclge_dbg_get_imp_stats_info(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_get_imp_stats_info(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_get_imp_bd_cmd *req;
 	struct hclge_desc *desc_src;
 	struct hclge_desc desc;
@@ -2317,7 +2333,7 @@ hclge_dbg_get_imp_stats_info(struct hclge_dev *hdev, char *buf, int len)
 		return ret;
 	}
 
-	hclge_dbg_imp_info_data_print(desc_src, buf, len, bd_num);
+	hclge_dbg_imp_info_data_print(s, desc_src, bd_num);
 
 	kfree(desc_src);
 
@@ -2328,7 +2344,7 @@ hclge_dbg_get_imp_stats_info(struct hclge_dev *hdev, char *buf, int len)
 #define HCLGE_MAX_NCL_CONFIG_LENGTH	16384
 
 static void hclge_ncl_config_data_print(struct hclge_desc *desc, int *index,
-					char *buf, int len, int *pos)
+					struct seq_file *s)
 {
 #define HCLGE_CMD_DATA_NUM		6
 
@@ -2340,9 +2356,8 @@ static void hclge_ncl_config_data_print(struct hclge_desc *desc, int *index,
 			if (i == 0 && j == 0)
 				continue;
 
-			*pos += scnprintf(buf + *pos, len - *pos,
-					  "0x%04x | 0x%08x\n", offset,
-					  le32_to_cpu(desc[i].data[j]));
+			seq_printf(s, "0x%04x | 0x%08x\n", offset,
+				   le32_to_cpu(desc[i].data[j]));
 
 			offset += sizeof(u32);
 			*index -= sizeof(u32);
@@ -2353,19 +2368,18 @@ static void hclge_ncl_config_data_print(struct hclge_desc *desc, int *index,
 	}
 }
 
-static int
-hclge_dbg_dump_ncl_config(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_ncl_config(struct seq_file *s, void *data)
 {
 #define HCLGE_NCL_CONFIG_LENGTH_IN_EACH_CMD	(20 + 24 * 4)
 
 	struct hclge_desc desc[HCLGE_CMD_NCL_CONFIG_BD_NUM];
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	int bd_num = HCLGE_CMD_NCL_CONFIG_BD_NUM;
 	int index = HCLGE_MAX_NCL_CONFIG_LENGTH;
-	int pos = 0;
 	u32 data0;
 	int ret;
 
-	pos += scnprintf(buf + pos, len - pos, "offset | data\n");
+	seq_puts(s, "offset | data\n");
 
 	while (index > 0) {
 		data0 = HCLGE_MAX_NCL_CONFIG_LENGTH - index;
@@ -2378,27 +2392,26 @@ hclge_dbg_dump_ncl_config(struct hclge_dev *hdev, char *buf, int len)
 		if (ret)
 			return ret;
 
-		hclge_ncl_config_data_print(desc, &index, buf, len, &pos);
+		hclge_ncl_config_data_print(desc, &index, s);
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_loopback(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_loopback(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct phy_device *phydev = hdev->hw.mac.phydev;
 	struct hclge_config_mac_mode_cmd *req_app;
 	struct hclge_common_lb_cmd *req_common;
 	struct hclge_desc desc;
 	u8 loopback_en;
-	int pos = 0;
 	int ret;
 
 	req_app = (struct hclge_config_mac_mode_cmd *)desc.data;
 	req_common = (struct hclge_common_lb_cmd *)desc.data;
 
-	pos += scnprintf(buf + pos, len - pos, "mac id: %u\n",
-			 hdev->hw.mac.mac_id);
+	seq_printf(s, "mac id: %u\n", hdev->hw.mac.mac_id);
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CONFIG_MAC_MODE, true);
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -2410,8 +2423,7 @@ static int hclge_dbg_dump_loopback(struct hclge_dev *hdev, char *buf, int len)
 
 	loopback_en = hnae3_get_bit(le32_to_cpu(req_app->txrx_pad_fcs_loop_en),
 				    HCLGE_MAC_APP_LP_B);
-	pos += scnprintf(buf + pos, len - pos, "app loopback: %s\n",
-			 str_on_off(loopback_en));
+	seq_printf(s, "app loopback: %s\n", str_on_off(loopback_en));
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_COMMON_LOOPBACK, true);
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
@@ -2422,24 +2434,22 @@ static int hclge_dbg_dump_loopback(struct hclge_dev *hdev, char *buf, int len)
 		return ret;
 	}
 
-	loopback_en = req_common->enable & HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B;
-	pos += scnprintf(buf + pos, len - pos, "serdes serial loopback: %s\n",
-			 str_on_off(loopback_en));
+	loopback_en = req_common->enable &
+		      HCLGE_CMD_SERDES_SERIAL_INNER_LOOP_B;
+	seq_printf(s, "serdes serial loopback: %s\n", str_on_off(loopback_en));
 
 	loopback_en = req_common->enable &
-			HCLGE_CMD_SERDES_PARALLEL_INNER_LOOP_B ? 1 : 0;
-	pos += scnprintf(buf + pos, len - pos, "serdes parallel loopback: %s\n",
-			 str_on_off(loopback_en));
+		      HCLGE_CMD_SERDES_PARALLEL_INNER_LOOP_B ? 1 : 0;
+	seq_printf(s, "serdes parallel loopback: %s\n",
+		   str_on_off(loopback_en));
 
 	if (phydev) {
 		loopback_en = phydev->loopback_enabled;
-		pos += scnprintf(buf + pos, len - pos, "phy loopback: %s\n",
-				 str_on_off(loopback_en));
+		seq_printf(s, "phy loopback: %s\n", str_on_off(loopback_en));
 	} else if (hnae3_dev_phy_imp_supported(hdev)) {
 		loopback_en = req_common->enable &
 			      HCLGE_CMD_GE_PHY_INNER_LOOP_B;
-		pos += scnprintf(buf + pos, len - pos, "phy loopback: %s\n",
-				 str_on_off(loopback_en));
+		seq_printf(s, "phy loopback: %s\n", str_on_off(loopback_en));
 	}
 
 	return 0;
@@ -2448,23 +2458,20 @@ static int hclge_dbg_dump_loopback(struct hclge_dev *hdev, char *buf, int len)
 /* hclge_dbg_dump_mac_tnl_status: print message about mac tnl interrupt
  * @hdev: pointer to struct hclge_dev
  */
-static int
-hclge_dbg_dump_mac_tnl_status(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_mac_tnl_status(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_mac_tnl_stats stats;
 	unsigned long rem_nsec;
-	int pos = 0;
 
-	pos += scnprintf(buf + pos, len - pos,
-			 "Recently generated mac tnl interruption:\n");
+	seq_puts(s, "Recently generated mac tnl interruption:\n");
 
 	while (kfifo_get(&hdev->mac_tnl_log, &stats)) {
 		rem_nsec = do_div(stats.time, HCLGE_BILLION_NANO_SECONDS);
 
-		pos += scnprintf(buf + pos, len - pos,
-				 "[%07lu.%03lu] status = 0x%x\n",
-				 (unsigned long)stats.time, rem_nsec / 1000,
-				 stats.status);
+		seq_printf(s, "[%07lu.%03lu] status = 0x%x\n",
+			   (unsigned long)stats.time, rem_nsec / 1000,
+			   stats.status);
 	}
 
 	return 0;
@@ -2498,35 +2505,28 @@ static void hclge_dbg_dump_mac_list(struct seq_file *s, bool is_unicast)
 	}
 }
 
-static int hclge_dbg_dump_umv_info(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_umv_info(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	u8 func_num = pci_num_vf(hdev->pdev) + 1;
 	struct hclge_vport *vport;
-	int pos = 0;
 	u8 i;
 
-	pos += scnprintf(buf, len, "num_alloc_vport   : %u\n",
-			  hdev->num_alloc_vport);
-	pos += scnprintf(buf + pos, len - pos, "max_umv_size     : %u\n",
-			 hdev->max_umv_size);
-	pos += scnprintf(buf + pos, len - pos, "wanted_umv_size  : %u\n",
-			 hdev->wanted_umv_size);
-	pos += scnprintf(buf + pos, len - pos, "priv_umv_size    : %u\n",
-			 hdev->priv_umv_size);
+	seq_printf(s, "num_alloc_vport   : %u\n", hdev->num_alloc_vport);
+	seq_printf(s, "max_umv_size     : %u\n", hdev->max_umv_size);
+	seq_printf(s, "wanted_umv_size  : %u\n", hdev->wanted_umv_size);
+	seq_printf(s, "priv_umv_size    : %u\n", hdev->priv_umv_size);
 
 	mutex_lock(&hdev->vport_lock);
-	pos += scnprintf(buf + pos, len - pos, "share_umv_size   : %u\n",
-			 hdev->share_umv_size);
+	seq_printf(s, "share_umv_size   : %u\n", hdev->share_umv_size);
 	for (i = 0; i < func_num; i++) {
 		vport = &hdev->vport[i];
-		pos += scnprintf(buf + pos, len - pos,
-				 "vport(%u) used_umv_num : %u\n",
-				 i, vport->used_umv_num);
+		seq_printf(s, "vport(%u) used_umv_num : %u\n",
+			   i, vport->used_umv_num);
 	}
 	mutex_unlock(&hdev->vport_lock);
 
-	pos += scnprintf(buf + pos, len - pos, "used_mc_mac_num  : %u\n",
-			 hdev->used_mc_mac_num);
+	seq_printf(s, "used_mc_mac_num  : %u\n", hdev->used_mc_mac_num);
 
 	return 0;
 }
@@ -2668,38 +2668,12 @@ static int hclge_get_port_vlan_filter_bypass_state(struct hclge_dev *hdev,
 	return 0;
 }
 
-static const struct hclge_dbg_item vlan_filter_items[] = {
-	{ "FUNC_ID", 2 },
-	{ "I_VF_VLAN_FILTER", 2 },
-	{ "E_VF_VLAN_FILTER", 2 },
-	{ "PORT_VLAN_FILTER_BYPASS", 0 }
-};
-
-static const struct hclge_dbg_item vlan_offload_items[] = {
-	{ "FUNC_ID", 2 },
-	{ "PVID", 4 },
-	{ "ACCEPT_TAG1", 2 },
-	{ "ACCEPT_TAG2", 2 },
-	{ "ACCEPT_UNTAG1", 2 },
-	{ "ACCEPT_UNTAG2", 2 },
-	{ "INSERT_TAG1", 2 },
-	{ "INSERT_TAG2", 2 },
-	{ "SHIFT_TAG", 2 },
-	{ "STRIP_TAG1", 2 },
-	{ "STRIP_TAG2", 2 },
-	{ "DROP_TAG1", 2 },
-	{ "DROP_TAG2", 2 },
-	{ "PRI_ONLY_TAG1", 2 },
-	{ "PRI_ONLY_TAG2", 0 }
-};
-
-static int hclge_dbg_dump_vlan_filter_config(struct hclge_dev *hdev, char *buf,
-					     int len, int *pos)
+static int hclge_dbg_dump_vlan_filter_config(struct hclge_dev *hdev,
+					     struct seq_file *s)
 {
-	char content[HCLGE_DBG_VLAN_FLTR_INFO_LEN], str_id[HCLGE_DBG_ID_LEN];
-	const char *result[ARRAY_SIZE(vlan_filter_items)];
-	u8 i, j, vlan_fe, bypass, ingress, egress;
 	u8 func_num = pci_num_vf(hdev->pdev) + 1; /* pf and enabled vf num */
+	u8 i, vlan_fe, bypass, ingress, egress;
+	char str_id[HCLGE_DBG_ID_LEN];
 	int ret;
 
 	ret = hclge_get_vlan_filter_state(hdev, HCLGE_FILTER_TYPE_PORT, 0,
@@ -2709,14 +2683,11 @@ static int hclge_dbg_dump_vlan_filter_config(struct hclge_dev *hdev, char *buf,
 	ingress = vlan_fe & HCLGE_FILTER_FE_NIC_INGRESS_B;
 	egress = vlan_fe & HCLGE_FILTER_FE_NIC_EGRESS_B ? 1 : 0;
 
-	*pos += scnprintf(buf, len, "I_PORT_VLAN_FILTER: %s\n",
-			  str_on_off(ingress));
-	*pos += scnprintf(buf + *pos, len - *pos, "E_PORT_VLAN_FILTER: %s\n",
-			  str_on_off(egress));
+	seq_printf(s, "I_PORT_VLAN_FILTER: %s\n", str_on_off(ingress));
+	seq_printf(s, "E_PORT_VLAN_FILTER: %s\n", str_on_off(egress));
 
-	hclge_dbg_fill_content(content, sizeof(content), vlan_filter_items,
-			       NULL, ARRAY_SIZE(vlan_filter_items));
-	*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
+	seq_puts(s, "FUNC_ID  I_VF_VLAN_FILTER  E_VF_VLAN_FILTER  ");
+	seq_puts(s, "PORT_VLAN_FILTER_BYPASS\n");
 
 	for (i = 0; i < func_num; i++) {
 		ret = hclge_get_vlan_filter_state(hdev, HCLGE_FILTER_TYPE_VF, i,
@@ -2729,37 +2700,32 @@ static int hclge_dbg_dump_vlan_filter_config(struct hclge_dev *hdev, char *buf,
 		ret = hclge_get_port_vlan_filter_bypass_state(hdev, i, &bypass);
 		if (ret)
 			return ret;
-		j = 0;
-		result[j++] = hclge_dbg_get_func_id_str(str_id, i);
-		result[j++] = str_on_off(ingress);
-		result[j++] = str_on_off(egress);
-		result[j++] = test_bit(HNAE3_DEV_SUPPORT_PORT_VLAN_BYPASS_B,
-				       hdev->ae_dev->caps) ?
-			      str_on_off(bypass) : "NA";
-		hclge_dbg_fill_content(content, sizeof(content),
-				       vlan_filter_items, result,
-				       ARRAY_SIZE(vlan_filter_items));
-		*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
-	}
-	*pos += scnprintf(buf + *pos, len - *pos, "\n");
+
+		seq_printf(s, "%-9s%-18s%-18s%s\n",
+			   hclge_dbg_get_func_id_str(str_id, i),
+			   str_on_off(ingress), str_on_off(egress),
+			   test_bit(HNAE3_DEV_SUPPORT_PORT_VLAN_BYPASS_B,
+				    hdev->ae_dev->caps) ?
+						str_on_off(bypass) : "NA");
+	}
+	seq_puts(s, "\n");
 
 	return 0;
 }
 
-static int hclge_dbg_dump_vlan_offload_config(struct hclge_dev *hdev, char *buf,
-					      int len, int *pos)
+static int hclge_dbg_dump_vlan_offload_config(struct hclge_dev *hdev,
+					      struct seq_file *s)
 {
-	char str_id[HCLGE_DBG_ID_LEN], str_pvid[HCLGE_DBG_ID_LEN];
-	const char *result[ARRAY_SIZE(vlan_offload_items)];
-	char content[HCLGE_DBG_VLAN_OFFLOAD_INFO_LEN];
 	u8 func_num = pci_num_vf(hdev->pdev) + 1; /* pf and enabled vf num */
 	struct hclge_dbg_vlan_cfg vlan_cfg;
+	char str_id[HCLGE_DBG_ID_LEN];
 	int ret;
-	u8 i, j;
+	u8 i;
 
-	hclge_dbg_fill_content(content, sizeof(content), vlan_offload_items,
-			       NULL, ARRAY_SIZE(vlan_offload_items));
-	*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
+	seq_puts(s, "FUNC_ID  PVID  ACCEPT_TAG1  ACCEPT_TAG2 ACCEPT_UNTAG1  ");
+	seq_puts(s, "ACCEPT_UNTAG2  INSERT_TAG1  INSERT_TAG2  SHIFT_TAG  ");
+	seq_puts(s, "STRIP_TAG1  STRIP_TAG2  DROP_TAG1  DROP_TAG2  ");
+	seq_puts(s, "PRI_ONLY_TAG1  PRI_ONLY_TAG2\n");
 
 	for (i = 0; i < func_num; i++) {
 		ret = hclge_get_vlan_tx_offload_cfg(hdev, i, &vlan_cfg);
@@ -2770,92 +2736,78 @@ static int hclge_dbg_dump_vlan_offload_config(struct hclge_dev *hdev, char *buf,
 		if (ret)
 			return ret;
 
-		sprintf(str_pvid, "%u", vlan_cfg.pvid);
-		j = 0;
-		result[j++] = hclge_dbg_get_func_id_str(str_id, i);
-		result[j++] = str_pvid;
-		result[j++] = str_on_off(vlan_cfg.accept_tag1);
-		result[j++] = str_on_off(vlan_cfg.accept_tag2);
-		result[j++] = str_on_off(vlan_cfg.accept_untag1);
-		result[j++] = str_on_off(vlan_cfg.accept_untag2);
-		result[j++] = str_on_off(vlan_cfg.insert_tag1);
-		result[j++] = str_on_off(vlan_cfg.insert_tag2);
-		result[j++] = str_on_off(vlan_cfg.shift_tag);
-		result[j++] = str_on_off(vlan_cfg.strip_tag1);
-		result[j++] = str_on_off(vlan_cfg.strip_tag2);
-		result[j++] = str_on_off(vlan_cfg.drop_tag1);
-		result[j++] = str_on_off(vlan_cfg.drop_tag2);
-		result[j++] = str_on_off(vlan_cfg.pri_only1);
-		result[j++] = str_on_off(vlan_cfg.pri_only2);
-
-		hclge_dbg_fill_content(content, sizeof(content),
-				       vlan_offload_items, result,
-				       ARRAY_SIZE(vlan_offload_items));
-		*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
+		seq_printf(s, "%-9s", hclge_dbg_get_func_id_str(str_id, i));
+		seq_printf(s, "%-6u", vlan_cfg.pvid);
+		seq_printf(s, "%-13s", str_on_off(vlan_cfg.accept_tag1));
+		seq_printf(s, "%-12s", str_on_off(vlan_cfg.accept_tag2));
+		seq_printf(s, "%-15s", str_on_off(vlan_cfg.accept_untag1));
+		seq_printf(s, "%-15s", str_on_off(vlan_cfg.accept_untag2));
+		seq_printf(s, "%-13s", str_on_off(vlan_cfg.insert_tag1));
+		seq_printf(s, "%-13s", str_on_off(vlan_cfg.insert_tag2));
+		seq_printf(s, "%-11s", str_on_off(vlan_cfg.shift_tag));
+		seq_printf(s, "%-12s", str_on_off(vlan_cfg.strip_tag1));
+		seq_printf(s, "%-12s", str_on_off(vlan_cfg.strip_tag2));
+		seq_printf(s, "%-11s", str_on_off(vlan_cfg.drop_tag1));
+		seq_printf(s, "%-11s", str_on_off(vlan_cfg.drop_tag2));
+		seq_printf(s, "%-15s", str_on_off(vlan_cfg.pri_only1));
+		seq_printf(s, "%s\n", str_on_off(vlan_cfg.pri_only2));
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_vlan_config(struct hclge_dev *hdev, char *buf,
-				      int len)
+static int hclge_dbg_dump_vlan_config(struct seq_file *s, void *data)
 {
-	int pos = 0;
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	int ret;
 
-	ret = hclge_dbg_dump_vlan_filter_config(hdev, buf, len, &pos);
+	ret = hclge_dbg_dump_vlan_filter_config(hdev, s);
 	if (ret)
 		return ret;
 
-	return hclge_dbg_dump_vlan_offload_config(hdev, buf, len, &pos);
+	return hclge_dbg_dump_vlan_offload_config(hdev, s);
 }
 
-static int hclge_dbg_dump_ptp_info(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_ptp_info(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_ptp *ptp = hdev->ptp;
 	u32 sw_cfg = ptp->ptp_cfg;
 	unsigned int tx_start;
 	unsigned int last_rx;
-	int pos = 0;
 	u32 hw_cfg;
 	int ret;
 
-	pos += scnprintf(buf + pos, len - pos, "phc %s's debug info:\n",
-			 ptp->info.name);
-	pos += scnprintf(buf + pos, len - pos, "ptp enable: %s\n",
-			 str_yes_no(test_bit(HCLGE_PTP_FLAG_EN, &ptp->flags)));
-	pos += scnprintf(buf + pos, len - pos, "ptp tx enable: %s\n",
-			 str_yes_no(test_bit(HCLGE_PTP_FLAG_TX_EN,
-					     &ptp->flags)));
-	pos += scnprintf(buf + pos, len - pos, "ptp rx enable: %s\n",
-			 str_yes_no(test_bit(HCLGE_PTP_FLAG_RX_EN,
-					     &ptp->flags)));
+	seq_printf(s, "phc %s's debug info:\n", ptp->info.name);
+	seq_printf(s, "ptp enable: %s\n",
+		   str_yes_no(test_bit(HCLGE_PTP_FLAG_EN, &ptp->flags)));
+	seq_printf(s, "ptp tx enable: %s\n",
+		   str_yes_no(test_bit(HCLGE_PTP_FLAG_TX_EN, &ptp->flags)));
+	seq_printf(s, "ptp rx enable: %s\n",
+		   str_yes_no(test_bit(HCLGE_PTP_FLAG_RX_EN, &ptp->flags)));
 
 	last_rx = jiffies_to_msecs(ptp->last_rx);
-	pos += scnprintf(buf + pos, len - pos, "last rx time: %lu.%lu\n",
-			 last_rx / MSEC_PER_SEC, last_rx % MSEC_PER_SEC);
-	pos += scnprintf(buf + pos, len - pos, "rx count: %lu\n", ptp->rx_cnt);
+	seq_printf(s, "last rx time: %lu.%lu\n",
+		   last_rx / MSEC_PER_SEC, last_rx % MSEC_PER_SEC);
+	seq_printf(s, "rx count: %lu\n", ptp->rx_cnt);
 
 	tx_start = jiffies_to_msecs(ptp->tx_start);
-	pos += scnprintf(buf + pos, len - pos, "last tx start time: %lu.%lu\n",
-			 tx_start / MSEC_PER_SEC, tx_start % MSEC_PER_SEC);
-	pos += scnprintf(buf + pos, len - pos, "tx count: %lu\n", ptp->tx_cnt);
-	pos += scnprintf(buf + pos, len - pos, "tx skipped count: %lu\n",
-			 ptp->tx_skipped);
-	pos += scnprintf(buf + pos, len - pos, "tx timeout count: %lu\n",
-			 ptp->tx_timeout);
-	pos += scnprintf(buf + pos, len - pos, "last tx seqid: %u\n",
-			 ptp->last_tx_seqid);
+	seq_printf(s, "last tx start time: %lu.%lu\n",
+		   tx_start / MSEC_PER_SEC, tx_start % MSEC_PER_SEC);
+	seq_printf(s, "tx count: %lu\n", ptp->tx_cnt);
+	seq_printf(s, "tx skipped count: %lu\n", ptp->tx_skipped);
+	seq_printf(s, "tx timeout count: %lu\n", ptp->tx_timeout);
+	seq_printf(s, "last tx seqid: %u\n", ptp->last_tx_seqid);
+
 
 	ret = hclge_ptp_cfg_qry(hdev, &hw_cfg);
 	if (ret)
 		return ret;
 
-	pos += scnprintf(buf + pos, len - pos, "sw_cfg: %#x, hw_cfg: %#x\n",
-			 sw_cfg, hw_cfg);
+	seq_printf(s, "sw_cfg: %#x, hw_cfg: %#x\n", sw_cfg, hw_cfg);
 
-	pos += scnprintf(buf + pos, len - pos, "tx type: %d, rx filter: %d\n",
-			 ptp->ts_cfg.tx_type, ptp->ts_cfg.rx_filter);
+	seq_printf(s, "tx type: %d, rx filter: %d\n",
+		   ptp->ts_cfg.tx_type, ptp->ts_cfg.rx_filter);
 
 	return 0;
 }
@@ -2929,31 +2881,31 @@ static const struct hclge_dbg_func hclge_dbg_cmd_func[] = {
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_MNG_TBL,
-		.dbg_dump = hclge_dbg_dump_mng_table,
+		.dbg_read_func = hclge_dbg_dump_mng_table,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_LOOPBACK,
-		.dbg_dump = hclge_dbg_dump_loopback,
+		.dbg_read_func = hclge_dbg_dump_loopback,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_PTP_INFO,
-		.dbg_dump = hclge_dbg_dump_ptp_info,
+		.dbg_read_func = hclge_dbg_dump_ptp_info,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_INTERRUPT_INFO,
-		.dbg_dump = hclge_dbg_dump_interrupt,
+		.dbg_read_func = hclge_dbg_dump_interrupt,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_RESET_INFO,
-		.dbg_dump = hclge_dbg_dump_rst_info,
+		.dbg_read_func = hclge_dbg_seq_dump_rst_info,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_IMP_INFO,
-		.dbg_dump = hclge_dbg_get_imp_stats_info,
+		.dbg_read_func = hclge_dbg_get_imp_stats_info,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_NCL_CONFIG,
-		.dbg_dump = hclge_dbg_dump_ncl_config,
+		.dbg_read_func = hclge_dbg_dump_ncl_config,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_BIOS_COMMON,
@@ -3005,15 +2957,15 @@ static const struct hclge_dbg_func hclge_dbg_cmd_func[] = {
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_MAC_TNL_STATUS,
-		.dbg_dump = hclge_dbg_dump_mac_tnl_status,
+		.dbg_read_func = hclge_dbg_dump_mac_tnl_status,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_SERV_INFO,
-		.dbg_dump = hclge_dbg_dump_serv_info,
+		.dbg_read_func = hclge_dbg_dump_serv_info,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_VLAN_CONFIG,
-		.dbg_dump = hclge_dbg_dump_vlan_config,
+		.dbg_read_func = hclge_dbg_dump_vlan_config,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_FD_COUNTER,
@@ -3021,7 +2973,7 @@ static const struct hclge_dbg_func hclge_dbg_cmd_func[] = {
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_UMV_INFO,
-		.dbg_dump = hclge_dbg_dump_umv_info,
+		.dbg_read_func = hclge_dbg_dump_umv_info,
 	},
 };
 
-- 
2.33.0


