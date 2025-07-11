Return-Path: <netdev+bounces-206068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89121B013D2
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 08:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527C41894F5D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 06:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CDE1DE2BC;
	Fri, 11 Jul 2025 06:41:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35D1DE3AB;
	Fri, 11 Jul 2025 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752216097; cv=none; b=CuB6uWv++ElXy60k6XEUsLn2fzHLtju9YFK18GCxfuzawA+zaf/i2Zq7/LXOS3Wh7wZhCZcuwLhF5yg56k2FVIbZgXdfmKH2J04asrsYqMQa4m8J4ljr8qEGyloOSS7NYJCVtnGm+GPTeafumTdoOpGHIOQglRzUbu+9Xlgx8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752216097; c=relaxed/simple;
	bh=Hz8mzMBpunaIr0oivnNTV8QHFjCPR+dZt9nCA1EOkl8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TY/HpV97o+qtTdLt+QSGM8dczCD+j9p4RkUAiAntjXqkNMx+BYLR5OVLHfbMUtPhnlqe0k+0TgE8yfncnzTXGbHkO2yk8Rxz5oTUTWwufspWOHFFCMKdfMFhiya3B4xoyNnOML1XtAtI3XOb6m7FDhVToAdDhXTc0LBruvsrd0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bdhRd58rCzdbpJ;
	Fri, 11 Jul 2025 14:21:01 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 99383140137;
	Fri, 11 Jul 2025 14:25:06 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Jul 2025 14:25:05 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net-next 05/11] net: hns3: use seq_file for files in tm/ in debugfs
Date: Fri, 11 Jul 2025 14:17:19 +0800
Message-ID: <20250711061725.225585-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250711061725.225585-1-shaojijie@huawei.com>
References: <20250711061725.225585-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

Use seq_file for files in debugfs. This is the first
modification for reading in hclge_debugfs.c.

This patch use seq_file for the following nodes:
tm_nodes/tm_priority/tm_qset/tm_map/tm_pg/tm_port/tc_sch_info/
qos_pause_cfg/qos_pri_map/qos_dscp_map/qos_buf_cfg

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
ChangeLog:
v1 -> v2:
  - Remove unnecessary cast, suggested by Andrew Lunn
  v1: https://lore.kernel.org/all/20250708130029.1310872-1-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   5 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  45 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 516 +++++++-----------
 .../hisilicon/hns3/hns3pf/hclge_debugfs.h     |   1 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   1 +
 .../hisilicon/hns3/hns3pf/hclge_main.h        |   2 +
 6 files changed, 236 insertions(+), 334 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index db9639c3c402..5cc20558fe21 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -601,6 +601,8 @@ typedef int (*read_func)(struct seq_file *s, void *data);
  *   Get wake on lan info
  * set_wol
  *   Config wake on lan
+ * dbg_get_read_func
+ *   Return the read func for debugfs seq file
  */
 struct hnae3_ae_ops {
 	int (*init_ae_dev)(struct hnae3_ae_dev *ae_dev);
@@ -803,6 +805,9 @@ struct hnae3_ae_ops {
 			struct ethtool_wolinfo *wol);
 	int (*set_wol)(struct hnae3_handle *handle,
 		       struct ethtool_wolinfo *wol);
+	int (*dbg_get_read_func)(struct hnae3_handle *handle,
+				 enum hnae3_dbg_cmd cmd,
+				 read_func *func);
 };
 
 struct hnae3_dcb_ops {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index a08f8402eea0..e687e47393e4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -43,6 +43,7 @@ static struct hns3_dbg_dentry_info hns3_dbg_dentry[] = {
 static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd);
 static int hns3_dbg_common_file_init(struct hnae3_handle *handle, u32 cmd);
 static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32 cmd);
+static int hns3_dbg_common_init_t2(struct hnae3_handle *handle, u32 cmd);
 
 static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 	{
@@ -50,77 +51,77 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_TM_NODES,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_priority",
 		.cmd = HNAE3_DBG_CMD_TM_PRI,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_qset",
 		.cmd = HNAE3_DBG_CMD_TM_QSET,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN_1MB,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_map",
 		.cmd = HNAE3_DBG_CMD_TM_MAP,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN_1MB,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_pg",
 		.cmd = HNAE3_DBG_CMD_TM_PG,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tm_port",
 		.cmd = HNAE3_DBG_CMD_TM_PORT,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tc_sch_info",
 		.cmd = HNAE3_DBG_CMD_TC_SCH_INFO,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_pause_cfg",
 		.cmd = HNAE3_DBG_CMD_QOS_PAUSE_CFG,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_pri_map",
 		.cmd = HNAE3_DBG_CMD_QOS_PRI_MAP,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_dscp_map",
 		.cmd = HNAE3_DBG_CMD_QOS_DSCP_MAP,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "qos_buf_cfg",
 		.cmd = HNAE3_DBG_CMD_QOS_BUF_CFG,
 		.dentry = HNS3_DBG_DENTRY_TM,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "dev_info",
@@ -1144,6 +1145,28 @@ static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32 cmd)
 	return 0;
 }
 
+static int hns3_dbg_common_init_t2(struct hnae3_handle *handle, u32 cmd)
+{
+	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
+	struct device *dev = &handle->pdev->dev;
+	struct dentry *entry_dir;
+	read_func func;
+	int ret;
+
+	if (!ops->dbg_get_read_func)
+		return 0;
+
+	ret = ops->dbg_get_read_func(handle, hns3_dbg_cmd[cmd].cmd, &func);
+	if (ret)
+		return ret;
+
+	entry_dir = hns3_dbg_dentry[hns3_dbg_cmd[cmd].dentry].dentry;
+	debugfs_create_devm_seqfile(dev, hns3_dbg_cmd[cmd].name, entry_dir,
+				    func);
+
+	return 0;
+}
+
 int hns3_dbg_init(struct hnae3_handle *handle)
 {
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index f130020a1227..61a5ae95f313 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -12,6 +12,9 @@
 #include "hclge_tm.h"
 #include "hnae3.h"
 
+#define hclge_seq_file_to_hdev(s)	\
+		(((struct hnae3_ae_dev *)hnae3_seq_file_to_ae_dev(s))->priv)
+
 static const char * const hclge_mac_state_str[] = {
 	"TO_ADD", "TO_DEL", "ACTIVE"
 };
@@ -1298,12 +1301,12 @@ static int hclge_dbg_dump_reg_cmd(struct hclge_dev *hdev,
 	return ret;
 }
 
-static int hclge_dbg_dump_tc(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_tc(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_ets_tc_weight_cmd *ets_weight;
+	const char *sch_mode_str;
 	struct hclge_desc desc;
-	char *sch_mode_str;
-	int pos = 0;
 	int ret;
 	u8 i;
 
@@ -1323,72 +1326,37 @@ static int hclge_dbg_dump_tc(struct hclge_dev *hdev, char *buf, int len)
 
 	ets_weight = (struct hclge_ets_tc_weight_cmd *)desc.data;
 
-	pos += scnprintf(buf + pos, len - pos, "enabled tc number: %u\n",
-			 hdev->tm_info.num_tc);
-	pos += scnprintf(buf + pos, len - pos, "weight_offset: %u\n",
-			 ets_weight->weight_offset);
+	seq_printf(s, "enabled tc number: %u\n", hdev->tm_info.num_tc);
+	seq_printf(s, "weight_offset: %u\n", ets_weight->weight_offset);
 
-	pos += scnprintf(buf + pos, len - pos, "TC    MODE  WEIGHT\n");
+	seq_puts(s, "TC    MODE  WEIGHT\n");
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		sch_mode_str = ets_weight->tc_weight[i] ? "dwrr" : "sp";
-		pos += scnprintf(buf + pos, len - pos, "%u     %4s    %3u\n",
-				 i, sch_mode_str, ets_weight->tc_weight[i]);
+		seq_printf(s, "%u     %4s    %3u\n", i, sch_mode_str,
+			   ets_weight->tc_weight[i]);
 	}
 
 	return 0;
 }
 
-static const struct hclge_dbg_item tm_pg_items[] = {
-	{ "ID", 2 },
-	{ "PRI_MAP", 2 },
-	{ "MODE", 2 },
-	{ "DWRR", 2 },
-	{ "C_IR_B", 2 },
-	{ "C_IR_U", 2 },
-	{ "C_IR_S", 2 },
-	{ "C_BS_B", 2 },
-	{ "C_BS_S", 2 },
-	{ "C_FLAG", 2 },
-	{ "C_RATE(Mbps)", 2 },
-	{ "P_IR_B", 2 },
-	{ "P_IR_U", 2 },
-	{ "P_IR_S", 2 },
-	{ "P_BS_B", 2 },
-	{ "P_BS_S", 2 },
-	{ "P_FLAG", 2 },
-	{ "P_RATE(Mbps)", 0 }
-};
-
-static void hclge_dbg_fill_shaper_content(struct hclge_tm_shaper_para *para,
-					  char **result, u8 *index)
+static void hclge_dbg_fill_shaper_content(struct seq_file *s,
+					  struct hclge_tm_shaper_para *para)
 {
-	sprintf(result[(*index)++], "%3u", para->ir_b);
-	sprintf(result[(*index)++], "%3u", para->ir_u);
-	sprintf(result[(*index)++], "%3u", para->ir_s);
-	sprintf(result[(*index)++], "%3u", para->bs_b);
-	sprintf(result[(*index)++], "%3u", para->bs_s);
-	sprintf(result[(*index)++], "%3u", para->flag);
-	sprintf(result[(*index)++], "%6u", para->rate);
+	seq_printf(s, "%-8u%-8u%-8u%-8u%-8u%-8u%-14u", para->ir_b, para->ir_u,
+		   para->ir_s, para->bs_b, para->bs_s, para->flag, para->rate);
 }
 
-static int __hclge_dbg_dump_tm_pg(struct hclge_dev *hdev, char *data_str,
-				  char *buf, int len)
+static int hclge_dbg_dump_tm_pg(struct seq_file *s, void *data)
 {
 	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
-	char *result[ARRAY_SIZE(tm_pg_items)], *sch_mode_str;
-	u8 pg_id, sch_mode, weight, pri_bit_map, i, j;
-	char content[HCLGE_DBG_TM_INFO_LEN];
-	int pos = 0;
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
+	u8 pg_id, sch_mode, weight, pri_bit_map;
+	const char *sch_mode_str;
 	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(tm_pg_items); i++) {
-		result[i] = data_str;
-		data_str += HCLGE_DBG_DATA_STR_LEN;
-	}
-
-	hclge_dbg_fill_content(content, sizeof(content), tm_pg_items,
-			       NULL, ARRAY_SIZE(tm_pg_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
+	seq_puts(s, "ID  PRI_MAP  MODE  DWRR  C_IR_B  C_IR_U  C_IR_S  C_BS_B  ");
+	seq_puts(s, "C_BS_S  C_FLAG  C_RATE(Mbps)  P_IR_B  P_IR_U  P_IR_S  ");
+	seq_puts(s, "P_BS_B  P_BS_S  P_FLAG  P_RATE(Mbps)\n");
 
 	for (pg_id = 0; pg_id < hdev->tm_info.num_pg; pg_id++) {
 		ret = hclge_tm_get_pg_to_pri_map(hdev, pg_id, &pri_bit_map);
@@ -1418,68 +1386,41 @@ static int __hclge_dbg_dump_tm_pg(struct hclge_dev *hdev, char *data_str,
 		sch_mode_str = sch_mode & HCLGE_TM_TX_SCHD_DWRR_MSK ? "dwrr" :
 				       "sp";
 
-		j = 0;
-		sprintf(result[j++], "%02u", pg_id);
-		sprintf(result[j++], "0x%02x", pri_bit_map);
-		sprintf(result[j++], "%4s", sch_mode_str);
-		sprintf(result[j++], "%3u", weight);
-		hclge_dbg_fill_shaper_content(&c_shaper_para, result, &j);
-		hclge_dbg_fill_shaper_content(&p_shaper_para, result, &j);
-
-		hclge_dbg_fill_content(content, sizeof(content), tm_pg_items,
-				       (const char **)result,
-				       ARRAY_SIZE(tm_pg_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		seq_printf(s, "%02u  0x%-7x%-6s%-6u", pg_id, pri_bit_map,
+			   sch_mode_str, weight);
+		hclge_dbg_fill_shaper_content(s, &c_shaper_para);
+		hclge_dbg_fill_shaper_content(s, &p_shaper_para);
+		seq_puts(s, "\n");
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_tm_pg(struct hclge_dev *hdev, char *buf, int len)
-{
-	char *data_str;
-	int ret;
-
-	data_str = kcalloc(ARRAY_SIZE(tm_pg_items),
-			   HCLGE_DBG_DATA_STR_LEN, GFP_KERNEL);
-	if (!data_str)
-		return -ENOMEM;
-
-	ret = __hclge_dbg_dump_tm_pg(hdev, data_str, buf, len);
-
-	kfree(data_str);
-
-	return ret;
-}
-
-static int hclge_dbg_dump_tm_port(struct hclge_dev *hdev,  char *buf, int len)
+static int hclge_dbg_dump_tm_port(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_tm_shaper_para shaper_para;
-	int pos = 0;
 	int ret;
 
 	ret = hclge_tm_get_port_shaper(hdev, &shaper_para);
 	if (ret)
 		return ret;
 
-	pos += scnprintf(buf + pos, len - pos,
-			 "IR_B  IR_U  IR_S  BS_B  BS_S  FLAG  RATE(Mbps)\n");
-	pos += scnprintf(buf + pos, len - pos,
-			 "%3u   %3u   %3u   %3u   %3u     %1u   %6u\n",
-			 shaper_para.ir_b, shaper_para.ir_u, shaper_para.ir_s,
-			 shaper_para.bs_b, shaper_para.bs_s, shaper_para.flag,
-			 shaper_para.rate);
+	seq_puts(s, "IR_B  IR_U  IR_S  BS_B  BS_S  FLAG  RATE(Mbps)\n");
+	seq_printf(s, "%3u   %3u   %3u   %3u   %3u     %1u   %6u\n",
+		   shaper_para.ir_b, shaper_para.ir_u, shaper_para.ir_s,
+		   shaper_para.bs_b, shaper_para.bs_s, shaper_para.flag,
+		   shaper_para.rate);
 
 	return 0;
 }
 
 static int hclge_dbg_dump_tm_bp_qset_map(struct hclge_dev *hdev, u8 tc_id,
-					 char *buf, int len)
+					 struct seq_file *s)
 {
 	u32 qset_mapping[HCLGE_BP_EXT_GRP_NUM];
 	struct hclge_bp_to_qs_map_cmd *map;
 	struct hclge_desc desc;
-	int pos = 0;
 	u8 group_id;
 	u8 grp_num;
 	u16 i = 0;
@@ -1505,27 +1446,27 @@ static int hclge_dbg_dump_tm_bp_qset_map(struct hclge_dev *hdev, u8 tc_id,
 		qset_mapping[group_id] = le32_to_cpu(map->qs_bit_map);
 	}
 
-	pos += scnprintf(buf + pos, len - pos, "INDEX | TM BP QSET MAPPING:\n");
+	seq_puts(s, "INDEX | TM BP QSET MAPPING:\n");
 	for (group_id = 0; group_id < grp_num / 8; group_id++) {
-		pos += scnprintf(buf + pos, len - pos,
-			 "%04d  | %08x:%08x:%08x:%08x:%08x:%08x:%08x:%08x\n",
-			 group_id * 256, qset_mapping[i + 7],
-			 qset_mapping[i + 6], qset_mapping[i + 5],
-			 qset_mapping[i + 4], qset_mapping[i + 3],
-			 qset_mapping[i + 2], qset_mapping[i + 1],
-			 qset_mapping[i]);
+		seq_printf(s,
+			   "%04d  | %08x:%08x:%08x:%08x:%08x:%08x:%08x:%08x\n",
+			   group_id * 256, qset_mapping[i + 7],
+			   qset_mapping[i + 6], qset_mapping[i + 5],
+			   qset_mapping[i + 4], qset_mapping[i + 3],
+			   qset_mapping[i + 2], qset_mapping[i + 1],
+			   qset_mapping[i]);
 		i += 8;
 	}
 
-	return pos;
+	return 0;
 }
 
-static int hclge_dbg_dump_tm_map(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_tm_map(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	u16 queue_id;
 	u16 qset_id;
 	u8 link_vld;
-	int pos = 0;
 	u8 pri_id;
 	u8 tc_id;
 	int ret;
@@ -1544,32 +1485,28 @@ static int hclge_dbg_dump_tm_map(struct hclge_dev *hdev, char *buf, int len)
 		if (ret)
 			return ret;
 
-		pos += scnprintf(buf + pos, len - pos,
-				 "QUEUE_ID   QSET_ID   PRI_ID   TC_ID\n");
-		pos += scnprintf(buf + pos, len - pos,
-				 "%04u        %4u       %3u      %2u\n",
-				 queue_id, qset_id, pri_id, tc_id);
+		seq_puts(s, "QUEUE_ID   QSET_ID   PRI_ID   TC_ID\n");
+		seq_printf(s, "%04u        %4u       %3u      %2u\n",
+			   queue_id, qset_id, pri_id, tc_id);
 
 		if (!hnae3_dev_dcb_supported(hdev))
 			continue;
 
-		ret = hclge_dbg_dump_tm_bp_qset_map(hdev, tc_id, buf + pos,
-						    len - pos);
+		ret = hclge_dbg_dump_tm_bp_qset_map(hdev, tc_id, s);
 		if (ret < 0)
 			return ret;
-		pos += ret;
 
-		pos += scnprintf(buf + pos, len - pos, "\n");
+		seq_puts(s, "\n");
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_tm_nodes(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_tm_nodes(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_tm_nodes_cmd *nodes;
 	struct hclge_desc desc;
-	int pos = 0;
 	int ret;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_TM_NODES, true);
@@ -1582,65 +1519,36 @@ static int hclge_dbg_dump_tm_nodes(struct hclge_dev *hdev, char *buf, int len)
 
 	nodes = (struct hclge_tm_nodes_cmd *)desc.data;
 
-	pos += scnprintf(buf + pos, len - pos, "       BASE_ID  MAX_NUM\n");
-	pos += scnprintf(buf + pos, len - pos, "PG      %4u      %4u\n",
-			 nodes->pg_base_id, nodes->pg_num);
-	pos += scnprintf(buf + pos, len - pos, "PRI     %4u      %4u\n",
-			 nodes->pri_base_id, nodes->pri_num);
-	pos += scnprintf(buf + pos, len - pos, "QSET    %4u      %4u\n",
-			 le16_to_cpu(nodes->qset_base_id),
-			 le16_to_cpu(nodes->qset_num));
-	pos += scnprintf(buf + pos, len - pos, "QUEUE   %4u      %4u\n",
-			 le16_to_cpu(nodes->queue_base_id),
-			 le16_to_cpu(nodes->queue_num));
+	seq_puts(s, "       BASE_ID  MAX_NUM\n");
+	seq_printf(s, "PG      %4u      %4u\n", nodes->pg_base_id,
+		   nodes->pg_num);
+	seq_printf(s, "PRI     %4u      %4u\n", nodes->pri_base_id,
+		   nodes->pri_num);
+	seq_printf(s, "QSET    %4u      %4u\n",
+		   le16_to_cpu(nodes->qset_base_id),
+		   le16_to_cpu(nodes->qset_num));
+	seq_printf(s, "QUEUE   %4u      %4u\n",
+		   le16_to_cpu(nodes->queue_base_id),
+		   le16_to_cpu(nodes->queue_num));
 
 	return 0;
 }
 
-static const struct hclge_dbg_item tm_pri_items[] = {
-	{ "ID", 4 },
-	{ "MODE", 2 },
-	{ "DWRR", 2 },
-	{ "C_IR_B", 2 },
-	{ "C_IR_U", 2 },
-	{ "C_IR_S", 2 },
-	{ "C_BS_B", 2 },
-	{ "C_BS_S", 2 },
-	{ "C_FLAG", 2 },
-	{ "C_RATE(Mbps)", 2 },
-	{ "P_IR_B", 2 },
-	{ "P_IR_U", 2 },
-	{ "P_IR_S", 2 },
-	{ "P_BS_B", 2 },
-	{ "P_BS_S", 2 },
-	{ "P_FLAG", 2 },
-	{ "P_RATE(Mbps)", 0 }
-};
-
-static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_tm_pri(struct seq_file *s, void *data)
 {
 	struct hclge_tm_shaper_para c_shaper_para, p_shaper_para;
-	char *result[ARRAY_SIZE(tm_pri_items)], *sch_mode_str;
-	char content[HCLGE_DBG_TM_INFO_LEN];
-	u8 pri_num, sch_mode, weight, i, j;
-	char *data_str;
-	int pos, ret;
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
+	u8 pri_num, sch_mode, weight, i;
+	const char *sch_mode_str;
+	int ret;
 
 	ret = hclge_tm_get_pri_num(hdev, &pri_num);
 	if (ret)
 		return ret;
 
-	data_str = kcalloc(ARRAY_SIZE(tm_pri_items), HCLGE_DBG_DATA_STR_LEN,
-			   GFP_KERNEL);
-	if (!data_str)
-		return -ENOMEM;
-
-	for (i = 0; i < ARRAY_SIZE(tm_pri_items); i++)
-		result[i] = &data_str[i * HCLGE_DBG_DATA_STR_LEN];
-
-	hclge_dbg_fill_content(content, sizeof(content), tm_pri_items,
-			       NULL, ARRAY_SIZE(tm_pri_items));
-	pos = scnprintf(buf, len, "%s", content);
+	seq_puts(s, "ID  MODE  DWRR  C_IR_B  C_IR_U  C_IR_S  C_BS_B  ");
+	seq_puts(s, "C_BS_S  C_FLAG  C_RATE(Mbps)  P_IR_B  P_IR_U  P_IR_S  ");
+	seq_puts(s, "P_BS_B  P_BS_S  P_FLAG  P_RATE(Mbps)\n");
 
 	for (i = 0; i < pri_num; i++) {
 		ret = hclge_tm_get_pri_sch_mode(hdev, i, &sch_mode);
@@ -1666,59 +1574,31 @@ static int hclge_dbg_dump_tm_pri(struct hclge_dev *hdev, char *buf, int len)
 		sch_mode_str = sch_mode & HCLGE_TM_TX_SCHD_DWRR_MSK ? "dwrr" :
 			       "sp";
 
-		j = 0;
-		sprintf(result[j++], "%04u", i);
-		sprintf(result[j++], "%4s", sch_mode_str);
-		sprintf(result[j++], "%3u", weight);
-		hclge_dbg_fill_shaper_content(&c_shaper_para, result, &j);
-		hclge_dbg_fill_shaper_content(&p_shaper_para, result, &j);
-		hclge_dbg_fill_content(content, sizeof(content), tm_pri_items,
-				       (const char **)result,
-				       ARRAY_SIZE(tm_pri_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		seq_printf(s, "%04u  %-6s%-6u", i, sch_mode_str, weight);
+		hclge_dbg_fill_shaper_content(s, &c_shaper_para);
+		hclge_dbg_fill_shaper_content(s, &p_shaper_para);
+		seq_puts(s, "\n");
 	}
 
 out:
-	kfree(data_str);
 	return ret;
 }
 
-static const struct hclge_dbg_item tm_qset_items[] = {
-	{ "ID", 4 },
-	{ "MAP_PRI", 2 },
-	{ "LINK_VLD", 2 },
-	{ "MODE", 2 },
-	{ "DWRR", 2 },
-	{ "IR_B", 2 },
-	{ "IR_U", 2 },
-	{ "IR_S", 2 },
-	{ "BS_B", 2 },
-	{ "BS_S", 2 },
-	{ "FLAG", 2 },
-	{ "RATE(Mbps)", 0 }
-};
-
-static int hclge_dbg_dump_tm_qset(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_tm_qset(struct seq_file *s, void *data)
 {
-	char data_str[ARRAY_SIZE(tm_qset_items)][HCLGE_DBG_DATA_STR_LEN];
-	char *result[ARRAY_SIZE(tm_qset_items)], *sch_mode_str;
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	u8 priority, link_vld, sch_mode, weight;
 	struct hclge_tm_shaper_para shaper_para;
-	char content[HCLGE_DBG_TM_INFO_LEN];
+	const char *sch_mode_str;
 	u16 qset_num, i;
-	int ret, pos;
-	u8 j;
+	int ret;
 
 	ret = hclge_tm_get_qset_num(hdev, &qset_num);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < ARRAY_SIZE(tm_qset_items); i++)
-		result[i] = &data_str[i][0];
-
-	hclge_dbg_fill_content(content, sizeof(content), tm_qset_items,
-			       NULL, ARRAY_SIZE(tm_qset_items));
-	pos = scnprintf(buf, len, "%s", content);
+	seq_puts(s, "ID    MAP_PRI  LINK_VLD  MODE  DWRR  IR_B  IR_U  IR_S  ");
+	seq_puts(s, "BS_B  BS_S  FLAG  RATE(Mbps)\n");
 
 	for (i = 0; i < qset_num; i++) {
 		ret = hclge_tm_get_qset_map_pri(hdev, i, &priority, &link_vld);
@@ -1740,29 +1620,22 @@ static int hclge_dbg_dump_tm_qset(struct hclge_dev *hdev, char *buf, int len)
 		sch_mode_str = sch_mode & HCLGE_TM_TX_SCHD_DWRR_MSK ? "dwrr" :
 			       "sp";
 
-		j = 0;
-		sprintf(result[j++], "%04u", i);
-		sprintf(result[j++], "%4u", priority);
-		sprintf(result[j++], "%4u", link_vld);
-		sprintf(result[j++], "%4s", sch_mode_str);
-		sprintf(result[j++], "%3u", weight);
-		hclge_dbg_fill_shaper_content(&shaper_para, result, &j);
-
-		hclge_dbg_fill_content(content, sizeof(content), tm_qset_items,
-				       (const char **)result,
-				       ARRAY_SIZE(tm_qset_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		seq_printf(s, "%04u  %-9u%-10u%-6s%-6u", i, priority, link_vld,
+			   sch_mode_str, weight);
+		seq_printf(s, "%-6u%-6u%-6u%-6u%-6u%-6u%-14u\n",
+			   shaper_para.ir_b, shaper_para.ir_u, shaper_para.ir_s,
+			   shaper_para.bs_b, shaper_para.bs_s, shaper_para.flag,
+			   shaper_para.rate);
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_qos_pause_cfg(struct hclge_dev *hdev, char *buf,
-					int len)
+static int hclge_dbg_dump_qos_pause_cfg(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_cfg_pause_param_cmd *pause_param;
 	struct hclge_desc desc;
-	int pos = 0;
 	int ret;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_CFG_MAC_PARA, true);
@@ -1775,23 +1648,21 @@ static int hclge_dbg_dump_qos_pause_cfg(struct hclge_dev *hdev, char *buf,
 
 	pause_param = (struct hclge_cfg_pause_param_cmd *)desc.data;
 
-	pos += scnprintf(buf + pos, len - pos, "pause_trans_gap: 0x%x\n",
-			 pause_param->pause_trans_gap);
-	pos += scnprintf(buf + pos, len - pos, "pause_trans_time: 0x%x\n",
-			 le16_to_cpu(pause_param->pause_trans_time));
+	seq_printf(s, "pause_trans_gap: 0x%x\n", pause_param->pause_trans_gap);
+	seq_printf(s, "pause_trans_time: 0x%x\n",
+		   le16_to_cpu(pause_param->pause_trans_time));
 	return 0;
 }
 
 #define HCLGE_DBG_TC_MASK		0x0F
 
-static int hclge_dbg_dump_qos_pri_map(struct hclge_dev *hdev, char *buf,
-				      int len)
+static int hclge_dbg_dump_qos_pri_map(struct seq_file *s, void *data)
 {
 #define HCLGE_DBG_TC_BIT_WIDTH		4
 
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_qos_pri_map_cmd *pri_map;
 	struct hclge_desc desc;
-	int pos = 0;
 	u8 *pri_tc;
 	u8 tc, i;
 	int ret;
@@ -1806,33 +1677,33 @@ static int hclge_dbg_dump_qos_pri_map(struct hclge_dev *hdev, char *buf,
 
 	pri_map = (struct hclge_qos_pri_map_cmd *)desc.data;
 
-	pos += scnprintf(buf + pos, len - pos, "vlan_to_pri: 0x%x\n",
-			 pri_map->vlan_pri);
-	pos += scnprintf(buf + pos, len - pos, "PRI  TC\n");
+	seq_printf(s, "vlan_to_pri: 0x%x\n", pri_map->vlan_pri);
+	seq_puts(s, "PRI  TC\n");
 
 	pri_tc = (u8 *)pri_map;
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		tc = pri_tc[i >> 1] >> ((i & 1) * HCLGE_DBG_TC_BIT_WIDTH);
 		tc &= HCLGE_DBG_TC_MASK;
-		pos += scnprintf(buf + pos, len - pos, "%u     %u\n", i, tc);
+		seq_printf(s, "%u     %u\n", i, tc);
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_qos_dscp_map(struct hclge_dev *hdev, char *buf,
-				       int len)
+static int hclge_dbg_dump_qos_dscp_map(struct seq_file *s, void *data)
 {
-	struct hnae3_knic_private_info *kinfo = &hdev->vport[0].nic.kinfo;
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_desc desc[HCLGE_DSCP_MAP_TC_BD_NUM];
+	struct hnae3_knic_private_info *kinfo;
 	u8 *req0 = (u8 *)desc[0].data;
 	u8 *req1 = (u8 *)desc[1].data;
 	u8 dscp_tc[HNAE3_MAX_DSCP];
-	int pos, ret;
+	int ret;
 	u8 i, j;
 
-	pos = scnprintf(buf, len, "tc map mode: %s\n",
-			tc_map_mode_str[kinfo->tc_map_mode]);
+	kinfo = &hdev->vport[0].nic.kinfo;
+
+	seq_printf(s, "tc map mode: %s\n", tc_map_mode_str[kinfo->tc_map_mode]);
 
 	if (kinfo->tc_map_mode != HNAE3_TC_MAP_MODE_DSCP)
 		return 0;
@@ -1847,7 +1718,7 @@ static int hclge_dbg_dump_qos_dscp_map(struct hclge_dev *hdev, char *buf,
 		return ret;
 	}
 
-	pos += scnprintf(buf + pos, len - pos, "\nDSCP  PRIO  TC\n");
+	seq_puts(s, "\nDSCP  PRIO  TC\n");
 
 	/* The low 32 dscp setting use bd0, high 32 dscp setting use bd1 */
 	for (i = 0; i < HNAE3_MAX_DSCP / HCLGE_DSCP_MAP_TC_BD_NUM; i++) {
@@ -1865,18 +1736,17 @@ static int hclge_dbg_dump_qos_dscp_map(struct hclge_dev *hdev, char *buf,
 		if (kinfo->dscp_prio[i] == HNAE3_PRIO_ID_INVALID)
 			continue;
 
-		pos += scnprintf(buf + pos, len - pos, " %2u    %u    %u\n",
-				 i, kinfo->dscp_prio[i], dscp_tc[i]);
+		seq_printf(s, " %2u    %u    %u\n", i, kinfo->dscp_prio[i],
+			   dscp_tc[i]);
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_tx_buf_cfg(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_tx_buf_cfg(struct hclge_dev *hdev, struct seq_file *s)
 {
 	struct hclge_tx_buff_alloc_cmd *tx_buf_cmd;
 	struct hclge_desc desc;
-	int pos = 0;
 	int i, ret;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_TX_BUFF_ALLOC, true);
@@ -1889,19 +1759,17 @@ static int hclge_dbg_dump_tx_buf_cfg(struct hclge_dev *hdev, char *buf, int len)
 
 	tx_buf_cmd = (struct hclge_tx_buff_alloc_cmd *)desc.data;
 	for (i = 0; i < HCLGE_MAX_TC_NUM; i++)
-		pos += scnprintf(buf + pos, len - pos,
-				 "tx_packet_buf_tc_%d: 0x%x\n", i,
-				 le16_to_cpu(tx_buf_cmd->tx_pkt_buff[i]));
+		seq_printf(s, "tx_packet_buf_tc_%d: 0x%x\n", i,
+			   le16_to_cpu(tx_buf_cmd->tx_pkt_buff[i]));
 
-	return pos;
+	return 0;
 }
 
-static int hclge_dbg_dump_rx_priv_buf_cfg(struct hclge_dev *hdev, char *buf,
-					  int len)
+static int hclge_dbg_dump_rx_priv_buf_cfg(struct hclge_dev *hdev,
+					  struct seq_file *s)
 {
 	struct hclge_rx_priv_buff_cmd *rx_buf_cmd;
 	struct hclge_desc desc;
-	int pos = 0;
 	int i, ret;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_RX_PRIV_BUFF_ALLOC, true);
@@ -1912,26 +1780,24 @@ static int hclge_dbg_dump_rx_priv_buf_cfg(struct hclge_dev *hdev, char *buf,
 		return ret;
 	}
 
-	pos += scnprintf(buf + pos, len - pos, "\n");
+	seq_puts(s, "\n");
 
 	rx_buf_cmd = (struct hclge_rx_priv_buff_cmd *)desc.data;
 	for (i = 0; i < HCLGE_MAX_TC_NUM; i++)
-		pos += scnprintf(buf + pos, len - pos,
-				 "rx_packet_buf_tc_%d: 0x%x\n", i,
-				 le16_to_cpu(rx_buf_cmd->buf_num[i]));
+		seq_printf(s, "rx_packet_buf_tc_%d: 0x%x\n", i,
+			   le16_to_cpu(rx_buf_cmd->buf_num[i]));
 
-	pos += scnprintf(buf + pos, len - pos, "rx_share_buf: 0x%x\n",
-			 le16_to_cpu(rx_buf_cmd->shared_buf));
+	seq_printf(s, "rx_share_buf: 0x%x\n",
+		   le16_to_cpu(rx_buf_cmd->shared_buf));
 
-	return pos;
+	return 0;
 }
 
-static int hclge_dbg_dump_rx_common_wl_cfg(struct hclge_dev *hdev, char *buf,
-					   int len)
+static int hclge_dbg_dump_rx_common_wl_cfg(struct hclge_dev *hdev,
+					   struct seq_file *s)
 {
 	struct hclge_rx_com_wl *rx_com_wl;
 	struct hclge_desc desc;
-	int pos = 0;
 	int ret;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_RX_COM_WL_ALLOC, true);
@@ -1943,21 +1809,19 @@ static int hclge_dbg_dump_rx_common_wl_cfg(struct hclge_dev *hdev, char *buf,
 	}
 
 	rx_com_wl = (struct hclge_rx_com_wl *)desc.data;
-	pos += scnprintf(buf + pos, len - pos, "\n");
-	pos += scnprintf(buf + pos, len - pos,
-			 "rx_com_wl: high: 0x%x, low: 0x%x\n",
-			 le16_to_cpu(rx_com_wl->com_wl.high),
-			 le16_to_cpu(rx_com_wl->com_wl.low));
+	seq_puts(s, "\n");
+	seq_printf(s, "rx_com_wl: high: 0x%x, low: 0x%x\n",
+		   le16_to_cpu(rx_com_wl->com_wl.high),
+		   le16_to_cpu(rx_com_wl->com_wl.low));
 
-	return pos;
+	return 0;
 }
 
-static int hclge_dbg_dump_rx_global_pkt_cnt(struct hclge_dev *hdev, char *buf,
-					    int len)
+static int hclge_dbg_dump_rx_global_pkt_cnt(struct hclge_dev *hdev,
+					    struct seq_file *s)
 {
 	struct hclge_rx_com_wl *rx_packet_cnt;
 	struct hclge_desc desc;
-	int pos = 0;
 	int ret;
 
 	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_RX_GBL_PKT_CNT, true);
@@ -1969,20 +1833,18 @@ static int hclge_dbg_dump_rx_global_pkt_cnt(struct hclge_dev *hdev, char *buf,
 	}
 
 	rx_packet_cnt = (struct hclge_rx_com_wl *)desc.data;
-	pos += scnprintf(buf + pos, len - pos,
-			 "rx_global_packet_cnt: high: 0x%x, low: 0x%x\n",
-			 le16_to_cpu(rx_packet_cnt->com_wl.high),
-			 le16_to_cpu(rx_packet_cnt->com_wl.low));
+	seq_printf(s, "rx_global_packet_cnt: high: 0x%x, low: 0x%x\n",
+		   le16_to_cpu(rx_packet_cnt->com_wl.high),
+		   le16_to_cpu(rx_packet_cnt->com_wl.low));
 
-	return pos;
+	return 0;
 }
 
-static int hclge_dbg_dump_rx_priv_wl_buf_cfg(struct hclge_dev *hdev, char *buf,
-					     int len)
+static int hclge_dbg_dump_rx_priv_wl_buf_cfg(struct hclge_dev *hdev,
+					     struct seq_file *s)
 {
 	struct hclge_rx_priv_wl_buf *rx_priv_wl;
 	struct hclge_desc desc[2];
-	int pos = 0;
 	int i, ret;
 
 	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_OPC_RX_PRIV_WL_ALLOC, true);
@@ -1997,28 +1859,25 @@ static int hclge_dbg_dump_rx_priv_wl_buf_cfg(struct hclge_dev *hdev, char *buf,
 
 	rx_priv_wl = (struct hclge_rx_priv_wl_buf *)desc[0].data;
 	for (i = 0; i < HCLGE_TC_NUM_ONE_DESC; i++)
-		pos += scnprintf(buf + pos, len - pos,
-			 "rx_priv_wl_tc_%d: high: 0x%x, low: 0x%x\n", i,
-			 le16_to_cpu(rx_priv_wl->tc_wl[i].high),
-			 le16_to_cpu(rx_priv_wl->tc_wl[i].low));
+		seq_printf(s, "rx_priv_wl_tc_%d: high: 0x%x, low: 0x%x\n", i,
+			   le16_to_cpu(rx_priv_wl->tc_wl[i].high),
+			   le16_to_cpu(rx_priv_wl->tc_wl[i].low));
 
 	rx_priv_wl = (struct hclge_rx_priv_wl_buf *)desc[1].data;
 	for (i = 0; i < HCLGE_TC_NUM_ONE_DESC; i++)
-		pos += scnprintf(buf + pos, len - pos,
-			 "rx_priv_wl_tc_%d: high: 0x%x, low: 0x%x\n",
-			 i + HCLGE_TC_NUM_ONE_DESC,
-			 le16_to_cpu(rx_priv_wl->tc_wl[i].high),
-			 le16_to_cpu(rx_priv_wl->tc_wl[i].low));
+		seq_printf(s, "rx_priv_wl_tc_%d: high: 0x%x, low: 0x%x\n",
+			   i + HCLGE_TC_NUM_ONE_DESC,
+			   le16_to_cpu(rx_priv_wl->tc_wl[i].high),
+			   le16_to_cpu(rx_priv_wl->tc_wl[i].low));
 
-	return pos;
+	return 0;
 }
 
 static int hclge_dbg_dump_rx_common_threshold_cfg(struct hclge_dev *hdev,
-						  char *buf, int len)
+						  struct seq_file *s)
 {
 	struct hclge_rx_com_thrd *rx_com_thrd;
 	struct hclge_desc desc[2];
-	int pos = 0;
 	int i, ret;
 
 	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_OPC_RX_COM_THRD_ALLOC, true);
@@ -2031,62 +1890,53 @@ static int hclge_dbg_dump_rx_common_threshold_cfg(struct hclge_dev *hdev,
 		return ret;
 	}
 
-	pos += scnprintf(buf + pos, len - pos, "\n");
+	seq_puts(s, "\n");
 	rx_com_thrd = (struct hclge_rx_com_thrd *)desc[0].data;
 	for (i = 0; i < HCLGE_TC_NUM_ONE_DESC; i++)
-		pos += scnprintf(buf + pos, len - pos,
-			 "rx_com_thrd_tc_%d: high: 0x%x, low: 0x%x\n", i,
-			 le16_to_cpu(rx_com_thrd->com_thrd[i].high),
-			 le16_to_cpu(rx_com_thrd->com_thrd[i].low));
+		seq_printf(s, "rx_com_thrd_tc_%d: high: 0x%x, low: 0x%x\n", i,
+			   le16_to_cpu(rx_com_thrd->com_thrd[i].high),
+			   le16_to_cpu(rx_com_thrd->com_thrd[i].low));
 
 	rx_com_thrd = (struct hclge_rx_com_thrd *)desc[1].data;
 	for (i = 0; i < HCLGE_TC_NUM_ONE_DESC; i++)
-		pos += scnprintf(buf + pos, len - pos,
-			 "rx_com_thrd_tc_%d: high: 0x%x, low: 0x%x\n",
-			 i + HCLGE_TC_NUM_ONE_DESC,
-			 le16_to_cpu(rx_com_thrd->com_thrd[i].high),
-			 le16_to_cpu(rx_com_thrd->com_thrd[i].low));
+		seq_printf(s, "rx_com_thrd_tc_%d: high: 0x%x, low: 0x%x\n",
+			   i + HCLGE_TC_NUM_ONE_DESC,
+			   le16_to_cpu(rx_com_thrd->com_thrd[i].high),
+			   le16_to_cpu(rx_com_thrd->com_thrd[i].low));
 
-	return pos;
+	return 0;
 }
 
-static int hclge_dbg_dump_qos_buf_cfg(struct hclge_dev *hdev, char *buf,
-				      int len)
+static int hclge_dbg_dump_qos_buf_cfg(struct seq_file *s, void *data)
 {
-	int pos = 0;
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	int ret;
 
-	ret = hclge_dbg_dump_tx_buf_cfg(hdev, buf + pos, len - pos);
+	ret = hclge_dbg_dump_tx_buf_cfg(hdev, s);
 	if (ret < 0)
 		return ret;
-	pos += ret;
 
-	ret = hclge_dbg_dump_rx_priv_buf_cfg(hdev, buf + pos, len - pos);
+	ret = hclge_dbg_dump_rx_priv_buf_cfg(hdev, s);
 	if (ret < 0)
 		return ret;
-	pos += ret;
 
-	ret = hclge_dbg_dump_rx_common_wl_cfg(hdev, buf + pos, len - pos);
+	ret = hclge_dbg_dump_rx_common_wl_cfg(hdev, s);
 	if (ret < 0)
 		return ret;
-	pos += ret;
 
-	ret = hclge_dbg_dump_rx_global_pkt_cnt(hdev, buf + pos, len - pos);
+	ret = hclge_dbg_dump_rx_global_pkt_cnt(hdev, s);
 	if (ret < 0)
 		return ret;
-	pos += ret;
 
-	pos += scnprintf(buf + pos, len - pos, "\n");
+	seq_puts(s, "\n");
 	if (!hnae3_dev_dcb_supported(hdev))
 		return 0;
 
-	ret = hclge_dbg_dump_rx_priv_wl_buf_cfg(hdev, buf + pos, len - pos);
+	ret = hclge_dbg_dump_rx_priv_wl_buf_cfg(hdev, s);
 	if (ret < 0)
 		return ret;
-	pos += ret;
 
-	ret = hclge_dbg_dump_rx_common_threshold_cfg(hdev, buf + pos,
-						     len - pos);
+	ret = hclge_dbg_dump_rx_common_threshold_cfg(hdev, s);
 	if (ret < 0)
 		return ret;
 
@@ -3060,47 +2910,47 @@ static int hclge_dbg_dump_mac_mc(struct hclge_dev *hdev, char *buf, int len)
 static const struct hclge_dbg_func hclge_dbg_cmd_func[] = {
 	{
 		.cmd = HNAE3_DBG_CMD_TM_NODES,
-		.dbg_dump = hclge_dbg_dump_tm_nodes,
+		.dbg_read_func = hclge_dbg_dump_tm_nodes,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_TM_PRI,
-		.dbg_dump = hclge_dbg_dump_tm_pri,
+		.dbg_read_func = hclge_dbg_dump_tm_pri,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_TM_QSET,
-		.dbg_dump = hclge_dbg_dump_tm_qset,
+		.dbg_read_func = hclge_dbg_dump_tm_qset,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_TM_MAP,
-		.dbg_dump = hclge_dbg_dump_tm_map,
+		.dbg_read_func = hclge_dbg_dump_tm_map,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_TM_PG,
-		.dbg_dump = hclge_dbg_dump_tm_pg,
+		.dbg_read_func = hclge_dbg_dump_tm_pg,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_TM_PORT,
-		.dbg_dump = hclge_dbg_dump_tm_port,
+		.dbg_read_func = hclge_dbg_dump_tm_port,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_TC_SCH_INFO,
-		.dbg_dump = hclge_dbg_dump_tc,
+		.dbg_read_func = hclge_dbg_dump_tc,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_QOS_PAUSE_CFG,
-		.dbg_dump = hclge_dbg_dump_qos_pause_cfg,
+		.dbg_read_func = hclge_dbg_dump_qos_pause_cfg,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_QOS_PRI_MAP,
-		.dbg_dump = hclge_dbg_dump_qos_pri_map,
+		.dbg_read_func = hclge_dbg_dump_qos_pri_map,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_QOS_DSCP_MAP,
-		.dbg_dump = hclge_dbg_dump_qos_dscp_map,
+		.dbg_read_func = hclge_dbg_dump_qos_dscp_map,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_QOS_BUF_CFG,
-		.dbg_dump = hclge_dbg_dump_qos_buf_cfg,
+		.dbg_read_func = hclge_dbg_dump_qos_buf_cfg,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_MAC_UC,
@@ -3230,3 +3080,23 @@ int hclge_dbg_read_cmd(struct hnae3_handle *handle, enum hnae3_dbg_cmd cmd,
 	dev_err(&hdev->pdev->dev, "invalid command(%d)\n", cmd);
 	return -EINVAL;
 }
+
+int hclge_dbg_get_read_func(struct hnae3_handle *handle, enum hnae3_dbg_cmd cmd,
+			    read_func *func)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	const struct hclge_dbg_func *cmd_func;
+	struct hclge_dev *hdev = vport->back;
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(hclge_dbg_cmd_func); i++) {
+		if (cmd == hclge_dbg_cmd_func[i].cmd) {
+			cmd_func = &hclge_dbg_cmd_func[i];
+			*func = cmd_func->dbg_read_func;
+			return 0;
+		}
+	}
+
+	dev_err(&hdev->pdev->dev, "invalid command(%d)\n", cmd);
+	return -EINVAL;
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
index 2b998cbed826..317f79efd54c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.h
@@ -92,6 +92,7 @@ struct hclge_dbg_func {
 	int (*dbg_dump)(struct hclge_dev *hdev, char *buf, int len);
 	int (*dbg_dump_reg)(struct hclge_dev *hdev, enum hnae3_dbg_cmd cmd,
 			    char *buf, int len);
+	read_func dbg_read_func;
 };
 
 struct hclge_dbg_status_dfx_info {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 35c984a256ab..9c9e87c22b80 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -12865,6 +12865,7 @@ static const struct hnae3_ae_ops hclge_ops = {
 	.enable_fd = hclge_enable_fd,
 	.add_arfs_entry = hclge_add_fd_entry_by_arfs,
 	.dbg_read_cmd = hclge_dbg_read_cmd,
+	.dbg_get_read_func = hclge_dbg_get_read_func,
 	.handle_hw_ras_error = hclge_handle_hw_ras_error,
 	.get_hw_reset_stat = hclge_get_hw_reset_stat,
 	.ae_dev_resetting = hclge_ae_dev_resetting,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index b9fc719880bb..57c09e8fd583 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -1144,6 +1144,8 @@ void hclge_vport_stop(struct hclge_vport *vport);
 int hclge_set_vport_mtu(struct hclge_vport *vport, int new_mtu);
 int hclge_dbg_read_cmd(struct hnae3_handle *handle, enum hnae3_dbg_cmd cmd,
 		       char *buf, int len);
+int hclge_dbg_get_read_func(struct hnae3_handle *handle, enum hnae3_dbg_cmd cmd,
+			    read_func *func);
 u16 hclge_covert_handle_qid_global(struct hnae3_handle *handle, u16 queue_id);
 int hclge_notify_client(struct hclge_dev *hdev,
 			enum hnae3_reset_notify_type type);
-- 
2.33.0


