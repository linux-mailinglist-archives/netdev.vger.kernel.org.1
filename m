Return-Path: <netdev+bounces-204964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD34AFCB74
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7EBB560E3F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB642DF3C6;
	Tue,  8 Jul 2025 13:08:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB22DCF74;
	Tue,  8 Jul 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980085; cv=none; b=NKCiLFO+D2uvUdLz4DzFayek0fNrEfAVk3a4+TFww9HgQHINviKSZpDMRcOQlDtR+pOOyXY0lPgUYtkpjilIaYbBxcLcaKwAoHiBSc0LiPQ1p5pWxlB4JYRf+mI6PPHo5KbQRQok+qA1C325zrTMBXyX1+JNNP5Nh/qIhaMaIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980085; c=relaxed/simple;
	bh=UnnpKBNm5rW40ncS/tagoIywMrmLiDgN2Y1t6vQ7/QU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ld3EJvBAabkk9XJtE+TfT5Iu4T/tryHFZ8EEMMbBHkJjiyfUIHndhFy+KmfTsTb/bHQRIq5y+gOJECWf5mbcG6ibWCfwOmR1D+WOf/PNJujPdGm2ol3O+KO0vH7PRn5QL8txX2DkdOMzHyBm3H8JMi4K4MK8x63bkARjZhVu7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bc1ZQ2PRjz2SSv7;
	Tue,  8 Jul 2025 21:06:06 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 81B0F180044;
	Tue,  8 Jul 2025 21:08:00 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 21:07:59 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 08/11] net: hns3: use seq_file for files in fd/ in debugfs
Date: Tue, 8 Jul 2025 21:00:26 +0800
Message-ID: <20250708130029.1310872-9-shaojijie@huawei.com>
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

This patch use seq_file for the following nodes:
fd_tcam/fd_counter

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  4 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 55 ++++++-------------
 2 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index c1a626ea845c..e471d6fcdd1b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -310,7 +310,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_FD_TCAM,
 		.dentry = HNS3_DBG_DENTRY_FD,
 		.buf_len = HNS3_DBG_READ_LEN_1MB,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "service_task_info",
@@ -338,7 +338,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_FD_COUNTER,
 		.dentry = HNS3_DBG_DENTRY_FD,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "umv_info",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index be663823a3db..a8b87b8ec292 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -2009,17 +2009,14 @@ static int hclge_dbg_dump_mng_table(struct hclge_dev *hdev, char *buf, int len)
 	return 0;
 }
 
-#define HCLGE_DBG_TCAM_BUF_SIZE 256
-
 static int hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, bool sel_x,
-				  char *tcam_buf,
+				  struct seq_file *s,
 				  struct hclge_dbg_tcam_msg tcam_msg)
 {
 	struct hclge_fd_tcam_config_1_cmd *req1;
 	struct hclge_fd_tcam_config_2_cmd *req2;
 	struct hclge_fd_tcam_config_3_cmd *req3;
 	struct hclge_desc desc[3];
-	int pos = 0;
 	int ret, i;
 	__le32 *req;
 
@@ -2041,27 +2038,23 @@ static int hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, bool sel_x,
 	if (ret)
 		return ret;
 
-	pos += scnprintf(tcam_buf + pos, HCLGE_DBG_TCAM_BUF_SIZE - pos,
-			 "read result tcam key %s(%u):\n", sel_x ? "x" : "y",
-			 tcam_msg.loc);
+	seq_printf(s, "read result tcam key %s(%u):\n",
+		   sel_x ? "x" : "y", tcam_msg.loc);
 
 	/* tcam_data0 ~ tcam_data1 */
 	req = (__le32 *)req1->tcam_data;
 	for (i = 0; i < 2; i++)
-		pos += scnprintf(tcam_buf + pos, HCLGE_DBG_TCAM_BUF_SIZE - pos,
-				 "%08x\n", le32_to_cpu(*req++));
+		seq_printf(s, "%08x\n", le32_to_cpu(*req++));
 
 	/* tcam_data2 ~ tcam_data7 */
 	req = (__le32 *)req2->tcam_data;
 	for (i = 0; i < 6; i++)
-		pos += scnprintf(tcam_buf + pos, HCLGE_DBG_TCAM_BUF_SIZE - pos,
-				 "%08x\n", le32_to_cpu(*req++));
+		seq_printf(s, "%08x\n", le32_to_cpu(*req++));
 
 	/* tcam_data8 ~ tcam_data12 */
 	req = (__le32 *)req3->tcam_data;
 	for (i = 0; i < 5; i++)
-		pos += scnprintf(tcam_buf + pos, HCLGE_DBG_TCAM_BUF_SIZE - pos,
-				 "%08x\n", le32_to_cpu(*req++));
+		seq_printf(s, "%08x\n", le32_to_cpu(*req++));
 
 	return ret;
 }
@@ -2085,14 +2078,13 @@ static int hclge_dbg_get_rules_location(struct hclge_dev *hdev, u16 *rule_locs)
 	return cnt;
 }
 
-static int hclge_dbg_dump_fd_tcam(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_fd_tcam(struct seq_file *s, void *data)
 {
-	u32 rule_num = hdev->fd_cfg.rule_num[HCLGE_FD_STAGE_1];
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_dbg_tcam_msg tcam_msg;
 	int i, ret, rule_cnt;
 	u16 *rule_locs;
-	char *tcam_buf;
-	int pos = 0;
+	u32 rule_num;
 
 	if (!hnae3_ae_dev_fd_supported(hdev->ae_dev)) {
 		dev_err(&hdev->pdev->dev,
@@ -2100,6 +2092,7 @@ static int hclge_dbg_dump_fd_tcam(struct hclge_dev *hdev, char *buf, int len)
 		return -EOPNOTSUPP;
 	}
 
+	rule_num = hdev->fd_cfg.rule_num[HCLGE_FD_STAGE_1];
 	if (!hdev->hclge_fd_rule_num || !rule_num)
 		return 0;
 
@@ -2107,12 +2100,6 @@ static int hclge_dbg_dump_fd_tcam(struct hclge_dev *hdev, char *buf, int len)
 	if (!rule_locs)
 		return -ENOMEM;
 
-	tcam_buf = kzalloc(HCLGE_DBG_TCAM_BUF_SIZE, GFP_KERNEL);
-	if (!tcam_buf) {
-		kfree(rule_locs);
-		return -ENOMEM;
-	}
-
 	rule_cnt = hclge_dbg_get_rules_location(hdev, rule_locs);
 	if (rule_cnt < 0) {
 		ret = rule_cnt;
@@ -2126,38 +2113,34 @@ static int hclge_dbg_dump_fd_tcam(struct hclge_dev *hdev, char *buf, int len)
 		tcam_msg.stage = HCLGE_FD_STAGE_1;
 		tcam_msg.loc = rule_locs[i];
 
-		ret = hclge_dbg_fd_tcam_read(hdev, true, tcam_buf, tcam_msg);
+		ret = hclge_dbg_fd_tcam_read(hdev, true, s, tcam_msg);
 		if (ret) {
 			dev_err(&hdev->pdev->dev,
 				"failed to get fd tcam key x, ret = %d\n", ret);
 			goto out;
 		}
 
-		pos += scnprintf(buf + pos, len - pos, "%s", tcam_buf);
-
-		ret = hclge_dbg_fd_tcam_read(hdev, false, tcam_buf, tcam_msg);
+		ret = hclge_dbg_fd_tcam_read(hdev, false, s, tcam_msg);
 		if (ret) {
 			dev_err(&hdev->pdev->dev,
 				"failed to get fd tcam key y, ret = %d\n", ret);
 			goto out;
 		}
 
-		pos += scnprintf(buf + pos, len - pos, "%s", tcam_buf);
 	}
 
 out:
-	kfree(tcam_buf);
 	kfree(rule_locs);
 	return ret;
 }
 
-static int hclge_dbg_dump_fd_counter(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_fd_counter(struct seq_file *s, void *data)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	u8 func_num = pci_num_vf(hdev->pdev) + 1; /* pf and enabled vf num */
 	struct hclge_fd_ad_cnt_read_cmd *req;
 	char str_id[HCLGE_DBG_ID_LEN];
 	struct hclge_desc desc;
-	int pos = 0;
 	int ret;
 	u64 cnt;
 	u8 i;
@@ -2165,8 +2148,7 @@ static int hclge_dbg_dump_fd_counter(struct hclge_dev *hdev, char *buf, int len)
 	if (!hnae3_ae_dev_fd_supported(hdev->ae_dev))
 		return -EOPNOTSUPP;
 
-	pos += scnprintf(buf + pos, len - pos,
-			 "func_id\thit_times\n");
+	seq_puts(s, "func_id\thit_times\n");
 
 	for (i = 0; i < func_num; i++) {
 		hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_FD_CNT_OP, true);
@@ -2180,8 +2162,7 @@ static int hclge_dbg_dump_fd_counter(struct hclge_dev *hdev, char *buf, int len)
 		}
 		cnt = le64_to_cpu(req->cnt);
 		hclge_dbg_get_func_id_str(str_id, i);
-		pos += scnprintf(buf + pos, len - pos,
-				 "%s\t%llu\n", str_id, cnt);
+		seq_printf(s, "%s\t%llu\n", str_id, cnt);
 	}
 
 	return 0;
@@ -3020,7 +3001,7 @@ static const struct hclge_dbg_func hclge_dbg_cmd_func[] = {
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_FD_TCAM,
-		.dbg_dump = hclge_dbg_dump_fd_tcam,
+		.dbg_read_func = hclge_dbg_dump_fd_tcam,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_MAC_TNL_STATUS,
@@ -3036,7 +3017,7 @@ static const struct hclge_dbg_func hclge_dbg_cmd_func[] = {
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_FD_COUNTER,
-		.dbg_dump = hclge_dbg_dump_fd_counter,
+		.dbg_read_func = hclge_dbg_dump_fd_counter,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_UMV_INFO,
-- 
2.33.0


