Return-Path: <netdev+bounces-206549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDFEB036EC
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3632C17AA21
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3144523370F;
	Mon, 14 Jul 2025 06:18:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C1922E406;
	Mon, 14 Jul 2025 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473890; cv=none; b=dvF9mLg5Sr08Onvh5RdKi1UWivuYOq8zmpFhVBI+cXuuVyLmn2bnuinycE+a+o1bc8u1jVek0CdudjOWgZwNS3DS/lMq2eVwZynWkQqdbmR7HxiMbIUHnIarp/IG4Uzp41sgvRCEg1BUjfBWvr3KhrBjGXzb0kHsu9qB8kRXgFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473890; c=relaxed/simple;
	bh=tjTv/7DT6K/7YsrKzDHh+lMvsXJvIuDn47tbCkx32Is=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PYl9jNjPo4kQSrOPXnBJ0hi4mtO6DP6dba+5xf+ISxBq5s3UGgJzCkw0a46Bm7obc3NGwpJ+zIhIZ2JejQr9lowSOM2K+eItJYjhwZsM8EEpVzboLYD2mg/mK/gzVnXbcpjrddslmA8a22mbmjhSfvxzuy8fTVXn8n2jI8xwSDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bgXFs3XQQz2YPs1;
	Mon, 14 Jul 2025 14:18:57 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D92C7140113;
	Mon, 14 Jul 2025 14:17:58 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 14:17:58 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net-next 07/10] net: hns3: use seq_file for files in reg/ in debugfs
Date: Mon, 14 Jul 2025 14:10:34 +0800
Message-ID: <20250714061037.2616413-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250714061037.2616413-1-shaojijie@huawei.com>
References: <20250714061037.2616413-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch use seq_file for the following nodes:
bios_common/ssu/igu_egu/rpu/ncsi/rtc/ppp/rcb/tqp/mac/dcb

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  22 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 271 +++++++++---------
 2 files changed, 150 insertions(+), 143 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index b6b3eb2f5652..c1a626ea845c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -212,77 +212,77 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_REG_BIOS_COMMON,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ssu",
 		.cmd = HNAE3_DBG_CMD_REG_SSU,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "igu_egu",
 		.cmd = HNAE3_DBG_CMD_REG_IGU_EGU,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "rpu",
 		.cmd = HNAE3_DBG_CMD_REG_RPU,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ncsi",
 		.cmd = HNAE3_DBG_CMD_REG_NCSI,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "rtc",
 		.cmd = HNAE3_DBG_CMD_REG_RTC,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "ppp",
 		.cmd = HNAE3_DBG_CMD_REG_PPP,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "rcb",
 		.cmd = HNAE3_DBG_CMD_REG_RCB,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "tqp",
 		.cmd = HNAE3_DBG_CMD_REG_TQP,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN_128KB,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mac",
 		.cmd = HNAE3_DBG_CMD_REG_MAC,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "dcb",
 		.cmd = HNAE3_DBG_CMD_REG_DCB,
 		.dentry = HNS3_DBG_DENTRY_REG,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "queue_map",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index 1fecfeeff93d..6a2e3c71bdb1 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -829,7 +829,7 @@ int hclge_dbg_cmd_send(struct hclge_dev *hdev, struct hclge_desc *desc_src,
 static int
 hclge_dbg_dump_reg_tqp(struct hclge_dev *hdev,
 		       const struct hclge_dbg_reg_type_info *reg_info,
-		       char *buf, int len, int *pos)
+		       struct seq_file *s)
 {
 	const struct hclge_dbg_dfx_message *dfx_message = reg_info->dfx_msg;
 	const struct hclge_dbg_reg_common_msg *reg_msg = &reg_info->reg_msg;
@@ -849,13 +849,12 @@ hclge_dbg_dump_reg_tqp(struct hclge_dev *hdev,
 	min_num = min_t(int, bd_num * HCLGE_DESC_DATA_LEN, reg_msg->msg_num);
 
 	for (i = 0, cnt = 0; i < min_num; i++, dfx_message++)
-		*pos += scnprintf(buf + *pos, len - *pos, "item%u = %s\n",
-				  cnt++, dfx_message->message);
+		seq_printf(s, "item%u = %s\n", cnt++, dfx_message->message);
 
 	for (i = 0; i < cnt; i++)
-		*pos += scnprintf(buf + *pos, len - *pos, "item%u\t", i);
+		seq_printf(s, "item%u\t", i);
 
-	*pos += scnprintf(buf + *pos, len - *pos, "\n");
+	seq_puts(s, "\n");
 
 	for (index = 0; index < hdev->vport[0].alloc_tqps; index++) {
 		dfx_message = reg_info->dfx_msg;
@@ -870,10 +869,9 @@ hclge_dbg_dump_reg_tqp(struct hclge_dev *hdev,
 			if (i > 0 && !entry)
 				desc++;
 
-			*pos += scnprintf(buf + *pos, len - *pos, "%#x\t",
-					  le32_to_cpu(desc->data[entry]));
+			seq_printf(s, "%#x\t", le32_to_cpu(desc->data[entry]));
 		}
-		*pos += scnprintf(buf + *pos, len - *pos, "\n");
+		seq_puts(s, "\n");
 	}
 
 	kfree(desc_src);
@@ -883,7 +881,7 @@ hclge_dbg_dump_reg_tqp(struct hclge_dev *hdev,
 static int
 hclge_dbg_dump_reg_common(struct hclge_dev *hdev,
 			  const struct hclge_dbg_reg_type_info *reg_info,
-			  char *buf, int len, int *pos)
+			  struct seq_file *s)
 {
 	const struct hclge_dbg_reg_common_msg *reg_msg = &reg_info->reg_msg;
 	const struct hclge_dbg_dfx_message *dfx_message = reg_info->dfx_msg;
@@ -917,9 +915,8 @@ hclge_dbg_dump_reg_common(struct hclge_dev *hdev,
 		if (!dfx_message->flag)
 			continue;
 
-		*pos += scnprintf(buf + *pos, len - *pos, "%s: %#x\n",
-				  dfx_message->message,
-				  le32_to_cpu(desc->data[entry]));
+		seq_printf(s, "%s: %#x\n", dfx_message->message,
+			   le32_to_cpu(desc->data[entry]));
 	}
 
 	kfree(desc_src);
@@ -943,8 +940,8 @@ static const struct hclge_dbg_status_dfx_info hclge_dbg_mac_en_status[] = {
 	{HCLGE_MAC_TX_OVERSIZE_TRUNCATE_B, "mac_tx_oversize_truncate_en"}
 };
 
-static int  hclge_dbg_dump_mac_enable_status(struct hclge_dev *hdev, char *buf,
-					     int len, int *pos)
+static int hclge_dbg_dump_mac_enable_status(struct hclge_dev *hdev,
+					    struct seq_file *s)
 {
 	struct hclge_config_mac_mode_cmd *req;
 	struct hclge_desc desc;
@@ -965,16 +962,15 @@ static int  hclge_dbg_dump_mac_enable_status(struct hclge_dev *hdev, char *buf,
 
 	for (i = 0; i < ARRAY_SIZE(hclge_dbg_mac_en_status); i++) {
 		offset = hclge_dbg_mac_en_status[i].offset;
-		*pos += scnprintf(buf + *pos, len - *pos, "%s: %#x\n",
-				  hclge_dbg_mac_en_status[i].message,
-				  hnae3_get_bit(loop_en, offset));
+		seq_printf(s, "%s: %#x\n", hclge_dbg_mac_en_status[i].message,
+			   hnae3_get_bit(loop_en, offset));
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_mac_frame_size(struct hclge_dev *hdev, char *buf,
-					 int len, int *pos)
+static int hclge_dbg_dump_mac_frame_size(struct hclge_dev *hdev,
+					 struct seq_file *s)
 {
 	struct hclge_config_max_frm_size_cmd *req;
 	struct hclge_desc desc;
@@ -991,16 +987,14 @@ static int hclge_dbg_dump_mac_frame_size(struct hclge_dev *hdev, char *buf,
 
 	req = (struct hclge_config_max_frm_size_cmd *)desc.data;
 
-	*pos += scnprintf(buf + *pos, len - *pos, "max_frame_size: %u\n",
-			  le16_to_cpu(req->max_frm_size));
-	*pos += scnprintf(buf + *pos, len - *pos, "min_frame_size: %u\n",
-			  req->min_frm_size);
+	seq_printf(s, "max_frame_size: %u\n", le16_to_cpu(req->max_frm_size));
+	seq_printf(s, "min_frame_size: %u\n", req->min_frm_size);
 
 	return 0;
 }
 
-static int hclge_dbg_dump_mac_speed_duplex(struct hclge_dev *hdev, char *buf,
-					   int len, int *pos)
+static int hclge_dbg_dump_mac_speed_duplex(struct hclge_dev *hdev,
+					   struct seq_file *s)
 {
 #define HCLGE_MAC_SPEED_SHIFT	0
 #define HCLGE_MAC_SPEED_MASK	GENMASK(5, 0)
@@ -1021,33 +1015,31 @@ static int hclge_dbg_dump_mac_speed_duplex(struct hclge_dev *hdev, char *buf,
 
 	req = (struct hclge_config_mac_speed_dup_cmd *)desc.data;
 
-	*pos += scnprintf(buf + *pos, len - *pos, "speed: %#lx\n",
-			  hnae3_get_field(req->speed_dup, HCLGE_MAC_SPEED_MASK,
-					  HCLGE_MAC_SPEED_SHIFT));
-	*pos += scnprintf(buf + *pos, len - *pos, "duplex: %#x\n",
-			  hnae3_get_bit(req->speed_dup,
-					HCLGE_MAC_DUPLEX_SHIFT));
+	seq_printf(s, "speed: %#lx\n",
+		   hnae3_get_field(req->speed_dup, HCLGE_MAC_SPEED_MASK,
+				   HCLGE_MAC_SPEED_SHIFT));
+	seq_printf(s, "duplex: %#x\n",
+		   hnae3_get_bit(req->speed_dup, HCLGE_MAC_DUPLEX_SHIFT));
 	return 0;
 }
 
-static int hclge_dbg_dump_mac(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_mac(struct seq_file *s, void *data)
 {
-	int pos = 0;
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	int ret;
 
-	ret = hclge_dbg_dump_mac_enable_status(hdev, buf, len, &pos);
+	ret = hclge_dbg_dump_mac_enable_status(hdev, s);
 	if (ret)
 		return ret;
 
-	ret = hclge_dbg_dump_mac_frame_size(hdev, buf, len, &pos);
+	ret = hclge_dbg_dump_mac_frame_size(hdev, s);
 	if (ret)
 		return ret;
 
-	return hclge_dbg_dump_mac_speed_duplex(hdev, buf, len, &pos);
+	return hclge_dbg_dump_mac_speed_duplex(hdev, s);
 }
 
-static int hclge_dbg_dump_dcb_qset(struct hclge_dev *hdev, char *buf, int len,
-				   int *pos)
+static int hclge_dbg_dump_dcb_qset(struct hclge_dev *hdev, struct seq_file *s)
 {
 	struct hclge_dbg_bitmap_cmd req;
 	struct hclge_desc desc;
@@ -1058,8 +1050,8 @@ static int hclge_dbg_dump_dcb_qset(struct hclge_dev *hdev, char *buf, int len,
 	if (ret)
 		return ret;
 
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "qset_id  roce_qset_mask  nic_qset_mask  qset_shaping_pass  qset_bp_status\n");
+	seq_puts(s, "qset_id  roce_qset_mask  nic_qset_mask  ");
+	seq_puts(s, "qset_shaping_pass  qset_bp_status\n");
 	for (qset_id = 0; qset_id < qset_num; qset_id++) {
 		ret = hclge_dbg_cmd_send(hdev, &desc, qset_id, 1,
 					 HCLGE_OPC_QSET_DFX_STS);
@@ -1068,17 +1060,14 @@ static int hclge_dbg_dump_dcb_qset(struct hclge_dev *hdev, char *buf, int len,
 
 		req.bitmap = (u8)le32_to_cpu(desc.data[1]);
 
-		*pos += scnprintf(buf + *pos, len - *pos,
-				  "%04u           %#x            %#x             %#x               %#x\n",
-				  qset_id, req.bit0, req.bit1, req.bit2,
-				  req.bit3);
+		seq_printf(s, "%04u     %#-16x%#-15x%#-19x%#-x\n",
+			   qset_id, req.bit0, req.bit1, req.bit2, req.bit3);
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_dcb_pri(struct hclge_dev *hdev, char *buf, int len,
-				  int *pos)
+static int hclge_dbg_dump_dcb_pri(struct hclge_dev *hdev, struct seq_file *s)
 {
 	struct hclge_dbg_bitmap_cmd req;
 	struct hclge_desc desc;
@@ -1089,8 +1078,7 @@ static int hclge_dbg_dump_dcb_pri(struct hclge_dev *hdev, char *buf, int len,
 	if (ret)
 		return ret;
 
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "pri_id  pri_mask  pri_cshaping_pass  pri_pshaping_pass\n");
+	seq_puts(s, "pri_id  pri_mask  pri_cshaping_pass  pri_pshaping_pass\n");
 	for (pri_id = 0; pri_id < pri_num; pri_id++) {
 		ret = hclge_dbg_cmd_send(hdev, &desc, pri_id, 1,
 					 HCLGE_OPC_PRI_DFX_STS);
@@ -1099,24 +1087,21 @@ static int hclge_dbg_dump_dcb_pri(struct hclge_dev *hdev, char *buf, int len,
 
 		req.bitmap = (u8)le32_to_cpu(desc.data[1]);
 
-		*pos += scnprintf(buf + *pos, len - *pos,
-				  "%03u       %#x           %#x                %#x\n",
-				  pri_id, req.bit0, req.bit1, req.bit2);
+		seq_printf(s, "%03u     %#-10x%#-19x%#-x\n",
+			   pri_id, req.bit0, req.bit1, req.bit2);
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_dcb_pg(struct hclge_dev *hdev, char *buf, int len,
-				 int *pos)
+static int hclge_dbg_dump_dcb_pg(struct hclge_dev *hdev, struct seq_file *s)
 {
 	struct hclge_dbg_bitmap_cmd req;
 	struct hclge_desc desc;
 	u8 pg_id;
 	int ret;
 
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "pg_id  pg_mask  pg_cshaping_pass  pg_pshaping_pass\n");
+	seq_puts(s, "pg_id  pg_mask  pg_cshaping_pass  pg_pshaping_pass\n");
 	for (pg_id = 0; pg_id < hdev->tm_info.num_pg; pg_id++) {
 		ret = hclge_dbg_cmd_send(hdev, &desc, pg_id, 1,
 					 HCLGE_OPC_PG_DFX_STS);
@@ -1125,47 +1110,41 @@ static int hclge_dbg_dump_dcb_pg(struct hclge_dev *hdev, char *buf, int len,
 
 		req.bitmap = (u8)le32_to_cpu(desc.data[1]);
 
-		*pos += scnprintf(buf + *pos, len - *pos,
-				  "%03u      %#x           %#x               %#x\n",
-				  pg_id, req.bit0, req.bit1, req.bit2);
+		seq_printf(s, "%03u    %#-9x%#-18x%#-x\n",
+			   pg_id, req.bit0, req.bit1, req.bit2);
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_dcb_queue(struct hclge_dev *hdev, char *buf, int len,
-				    int *pos)
+static int hclge_dbg_dump_dcb_queue(struct hclge_dev *hdev, struct seq_file *s)
 {
 	struct hclge_desc desc;
 	u16 nq_id;
 	int ret;
 
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "nq_id  sch_nic_queue_cnt  sch_roce_queue_cnt\n");
+	seq_puts(s, "nq_id  sch_nic_queue_cnt  sch_roce_queue_cnt\n");
 	for (nq_id = 0; nq_id < hdev->num_tqps; nq_id++) {
 		ret = hclge_dbg_cmd_send(hdev, &desc, nq_id, 1,
 					 HCLGE_OPC_SCH_NQ_CNT);
 		if (ret)
 			return ret;
 
-		*pos += scnprintf(buf + *pos, len - *pos, "%04u           %#x",
-				  nq_id, le32_to_cpu(desc.data[1]));
+		seq_printf(s, "%04u   %#-19x",
+			   nq_id, le32_to_cpu(desc.data[1]));
 
 		ret = hclge_dbg_cmd_send(hdev, &desc, nq_id, 1,
 					 HCLGE_OPC_SCH_RQ_CNT);
 		if (ret)
 			return ret;
 
-		*pos += scnprintf(buf + *pos, len - *pos,
-				  "               %#x\n",
-				  le32_to_cpu(desc.data[1]));
+		seq_printf(s, "%#-x\n", le32_to_cpu(desc.data[1]));
 	}
 
 	return 0;
 }
 
-static int hclge_dbg_dump_dcb_port(struct hclge_dev *hdev, char *buf, int len,
-				   int *pos)
+static int hclge_dbg_dump_dcb_port(struct hclge_dev *hdev, struct seq_file *s)
 {
 	struct hclge_dbg_bitmap_cmd req;
 	struct hclge_desc desc;
@@ -1179,16 +1158,13 @@ static int hclge_dbg_dump_dcb_port(struct hclge_dev *hdev, char *buf, int len,
 
 	req.bitmap = (u8)le32_to_cpu(desc.data[1]);
 
-	*pos += scnprintf(buf + *pos, len - *pos, "port_mask: %#x\n",
-			 req.bit0);
-	*pos += scnprintf(buf + *pos, len - *pos, "port_shaping_pass: %#x\n",
-			 req.bit1);
+	seq_printf(s, "port_mask: %#x\n", req.bit0);
+	seq_printf(s, "port_shaping_pass: %#x\n", req.bit1);
 
 	return 0;
 }
 
-static int hclge_dbg_dump_dcb_tm(struct hclge_dev *hdev, char *buf, int len,
-				 int *pos)
+static int hclge_dbg_dump_dcb_tm(struct hclge_dev *hdev, struct seq_file *s)
 {
 	struct hclge_desc desc[2];
 	u8 port_id = 0;
@@ -1199,32 +1175,23 @@ static int hclge_dbg_dump_dcb_tm(struct hclge_dev *hdev, char *buf, int len,
 	if (ret)
 		return ret;
 
-	*pos += scnprintf(buf + *pos, len - *pos, "SCH_NIC_NUM: %#x\n",
-			  le32_to_cpu(desc[0].data[1]));
-	*pos += scnprintf(buf + *pos, len - *pos, "SCH_ROCE_NUM: %#x\n",
-			  le32_to_cpu(desc[0].data[2]));
+	seq_printf(s, "SCH_NIC_NUM: %#x\n", le32_to_cpu(desc[0].data[1]));
+	seq_printf(s, "SCH_ROCE_NUM: %#x\n", le32_to_cpu(desc[0].data[2]));
 
 	ret = hclge_dbg_cmd_send(hdev, desc, port_id, 2,
 				 HCLGE_OPC_TM_INTERNAL_STS);
 	if (ret)
 		return ret;
 
-	*pos += scnprintf(buf + *pos, len - *pos, "pri_bp: %#x\n",
-			  le32_to_cpu(desc[0].data[1]));
-	*pos += scnprintf(buf + *pos, len - *pos, "fifo_dfx_info: %#x\n",
-			  le32_to_cpu(desc[0].data[2]));
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "sch_roce_fifo_afull_gap: %#x\n",
-			  le32_to_cpu(desc[0].data[3]));
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "tx_private_waterline: %#x\n",
-			  le32_to_cpu(desc[0].data[4]));
-	*pos += scnprintf(buf + *pos, len - *pos, "tm_bypass_en: %#x\n",
-			  le32_to_cpu(desc[0].data[5]));
-	*pos += scnprintf(buf + *pos, len - *pos, "SSU_TM_BYPASS_EN: %#x\n",
-			  le32_to_cpu(desc[1].data[0]));
-	*pos += scnprintf(buf + *pos, len - *pos, "SSU_RESERVE_CFG: %#x\n",
-			  le32_to_cpu(desc[1].data[1]));
+	seq_printf(s, "pri_bp: %#x\n", le32_to_cpu(desc[0].data[1]));
+	seq_printf(s, "fifo_dfx_info: %#x\n", le32_to_cpu(desc[0].data[2]));
+	seq_printf(s, "sch_roce_fifo_afull_gap: %#x\n",
+		   le32_to_cpu(desc[0].data[3]));
+	seq_printf(s, "tx_private_waterline: %#x\n",
+		   le32_to_cpu(desc[0].data[4]));
+	seq_printf(s, "tm_bypass_en: %#x\n", le32_to_cpu(desc[0].data[5]));
+	seq_printf(s, "SSU_TM_BYPASS_EN: %#x\n", le32_to_cpu(desc[1].data[0]));
+	seq_printf(s, "SSU_RESERVE_CFG: %#x\n", le32_to_cpu(desc[1].data[1]));
 
 	if (hdev->hw.mac.media_type == HNAE3_MEDIA_TYPE_COPPER)
 		return 0;
@@ -1234,65 +1201,60 @@ static int hclge_dbg_dump_dcb_tm(struct hclge_dev *hdev, char *buf, int len,
 	if (ret)
 		return ret;
 
-	*pos += scnprintf(buf + *pos, len - *pos, "TC_MAP_SEL: %#x\n",
-			  le32_to_cpu(desc[0].data[1]));
-	*pos += scnprintf(buf + *pos, len - *pos, "IGU_PFC_PRI_EN: %#x\n",
-			  le32_to_cpu(desc[0].data[2]));
-	*pos += scnprintf(buf + *pos, len - *pos, "MAC_PFC_PRI_EN: %#x\n",
-			  le32_to_cpu(desc[0].data[3]));
-	*pos += scnprintf(buf + *pos, len - *pos, "IGU_PRI_MAP_TC_CFG: %#x\n",
-			  le32_to_cpu(desc[0].data[4]));
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "IGU_TX_PRI_MAP_TC_CFG: %#x\n",
-			  le32_to_cpu(desc[0].data[5]));
+	seq_printf(s, "TC_MAP_SEL: %#x\n", le32_to_cpu(desc[0].data[1]));
+	seq_printf(s, "IGU_PFC_PRI_EN: %#x\n", le32_to_cpu(desc[0].data[2]));
+	seq_printf(s, "MAC_PFC_PRI_EN: %#x\n", le32_to_cpu(desc[0].data[3]));
+	seq_printf(s, "IGU_PRI_MAP_TC_CFG: %#x\n",
+		   le32_to_cpu(desc[0].data[4]));
+	seq_printf(s, "IGU_TX_PRI_MAP_TC_CFG: %#x\n",
+		   le32_to_cpu(desc[0].data[5]));
 
 	return 0;
 }
 
-static int hclge_dbg_dump_dcb(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_dcb(struct seq_file *s, void *data)
 {
-	int pos = 0;
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	int ret;
 
-	ret = hclge_dbg_dump_dcb_qset(hdev, buf, len, &pos);
+	ret = hclge_dbg_dump_dcb_qset(hdev, s);
 	if (ret)
 		return ret;
 
-	ret = hclge_dbg_dump_dcb_pri(hdev, buf, len, &pos);
+	ret = hclge_dbg_dump_dcb_pri(hdev, s);
 	if (ret)
 		return ret;
 
-	ret = hclge_dbg_dump_dcb_pg(hdev, buf, len, &pos);
+	ret = hclge_dbg_dump_dcb_pg(hdev, s);
 	if (ret)
 		return ret;
 
-	ret = hclge_dbg_dump_dcb_queue(hdev, buf, len, &pos);
+	ret = hclge_dbg_dump_dcb_queue(hdev, s);
 	if (ret)
 		return ret;
 
-	ret = hclge_dbg_dump_dcb_port(hdev, buf, len, &pos);
+	ret = hclge_dbg_dump_dcb_port(hdev, s);
 	if (ret)
 		return ret;
 
-	return hclge_dbg_dump_dcb_tm(hdev, buf, len, &pos);
+	return hclge_dbg_dump_dcb_tm(hdev, s);
 }
 
-static int hclge_dbg_dump_reg_cmd(struct hclge_dev *hdev,
-				  enum hnae3_dbg_cmd cmd, char *buf, int len)
+static int hclge_dbg_dump_reg_cmd(enum hnae3_dbg_cmd cmd, struct seq_file *s)
 {
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	const struct hclge_dbg_reg_type_info *reg_info;
-	int pos = 0, ret = 0;
+	int ret = 0;
 	u32 i;
 
 	for (i = 0; i < ARRAY_SIZE(hclge_dbg_reg_info); i++) {
 		reg_info = &hclge_dbg_reg_info[i];
 		if (cmd == reg_info->cmd) {
 			if (cmd == HNAE3_DBG_CMD_REG_TQP)
-				return hclge_dbg_dump_reg_tqp(hdev, reg_info,
-							      buf, len, &pos);
+				return hclge_dbg_dump_reg_tqp(hdev,
+							      reg_info, s);
 
-			ret = hclge_dbg_dump_reg_common(hdev, reg_info, buf,
-							len, &pos);
+			ret = hclge_dbg_dump_reg_common(hdev, reg_info, s);
 			if (ret)
 				break;
 		}
@@ -1301,6 +1263,51 @@ static int hclge_dbg_dump_reg_cmd(struct hclge_dev *hdev,
 	return ret;
 }
 
+static int hclge_dbg_dump_bios_reg_cmd(struct seq_file *s, void *data)
+{
+	return hclge_dbg_dump_reg_cmd(HNAE3_DBG_CMD_REG_BIOS_COMMON, s);
+}
+
+static int hclge_dbg_dump_ssu_reg_cmd(struct seq_file *s, void *data)
+{
+	return hclge_dbg_dump_reg_cmd(HNAE3_DBG_CMD_REG_SSU, s);
+}
+
+static int hclge_dbg_dump_igu_egu_reg_cmd(struct seq_file *s, void *data)
+{
+	return hclge_dbg_dump_reg_cmd(HNAE3_DBG_CMD_REG_IGU_EGU, s);
+}
+
+static int hclge_dbg_dump_rpu_reg_cmd(struct seq_file *s, void *data)
+{
+	return hclge_dbg_dump_reg_cmd(HNAE3_DBG_CMD_REG_RPU, s);
+}
+
+static int hclge_dbg_dump_ncsi_reg_cmd(struct seq_file *s, void *data)
+{
+	return hclge_dbg_dump_reg_cmd(HNAE3_DBG_CMD_REG_NCSI, s);
+}
+
+static int hclge_dbg_dump_rtc_reg_cmd(struct seq_file *s, void *data)
+{
+	return hclge_dbg_dump_reg_cmd(HNAE3_DBG_CMD_REG_RTC, s);
+}
+
+static int hclge_dbg_dump_ppp_reg_cmd(struct seq_file *s, void *data)
+{
+	return hclge_dbg_dump_reg_cmd(HNAE3_DBG_CMD_REG_PPP, s);
+}
+
+static int hclge_dbg_dump_rcb_reg_cmd(struct seq_file *s, void *data)
+{
+	return hclge_dbg_dump_reg_cmd(HNAE3_DBG_CMD_REG_RCB, s);
+}
+
+static int hclge_dbg_dump_tqp_reg_cmd(struct seq_file *s, void *data)
+{
+	return hclge_dbg_dump_reg_cmd(HNAE3_DBG_CMD_REG_TQP, s);
+}
+
 static int hclge_dbg_dump_tc(struct seq_file *s, void *data)
 {
 	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
@@ -2969,47 +2976,47 @@ static const struct hclge_dbg_func hclge_dbg_cmd_func[] = {
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_BIOS_COMMON,
-		.dbg_dump_reg = hclge_dbg_dump_reg_cmd,
+		.dbg_read_func = hclge_dbg_dump_bios_reg_cmd,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_SSU,
-		.dbg_dump_reg = hclge_dbg_dump_reg_cmd,
+		.dbg_read_func = hclge_dbg_dump_ssu_reg_cmd,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_IGU_EGU,
-		.dbg_dump_reg = hclge_dbg_dump_reg_cmd,
+		.dbg_read_func = hclge_dbg_dump_igu_egu_reg_cmd,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_RPU,
-		.dbg_dump_reg = hclge_dbg_dump_reg_cmd,
+		.dbg_read_func = hclge_dbg_dump_rpu_reg_cmd,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_NCSI,
-		.dbg_dump_reg = hclge_dbg_dump_reg_cmd,
+		.dbg_read_func = hclge_dbg_dump_ncsi_reg_cmd,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_RTC,
-		.dbg_dump_reg = hclge_dbg_dump_reg_cmd,
+		.dbg_read_func = hclge_dbg_dump_rtc_reg_cmd,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_PPP,
-		.dbg_dump_reg = hclge_dbg_dump_reg_cmd,
+		.dbg_read_func = hclge_dbg_dump_ppp_reg_cmd,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_RCB,
-		.dbg_dump_reg = hclge_dbg_dump_reg_cmd,
+		.dbg_read_func = hclge_dbg_dump_rcb_reg_cmd,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_TQP,
-		.dbg_dump_reg = hclge_dbg_dump_reg_cmd,
+		.dbg_read_func = hclge_dbg_dump_tqp_reg_cmd,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_MAC,
-		.dbg_dump = hclge_dbg_dump_mac,
+		.dbg_read_func = hclge_dbg_dump_mac,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_REG_DCB,
-		.dbg_dump = hclge_dbg_dump_dcb,
+		.dbg_read_func = hclge_dbg_dump_dcb,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_FD_TCAM,
-- 
2.33.0


