Return-Path: <netdev+bounces-204963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F6AFCB6F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F071AA4F54
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3022F2DEA8D;
	Tue,  8 Jul 2025 13:08:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC7283FE5;
	Tue,  8 Jul 2025 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980084; cv=none; b=bSelA22IVgyrEOuTg2bc1++AtRjEO68Du98xCiTiZURvxuH9N+rLawYtpobnfhcYHxHntW3c2w29YBVxEvqYnIMBdD7XcBdpFadyJvc1OpDmTlkBjnoHIEBDdrNLt3AtwmGjbf5HAIkAC0HqJ+/5vRnjxKqK/dzZAcM5zKvVizw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980084; c=relaxed/simple;
	bh=+QIK93mCGjd8myr45mJmnACdf9QWPu0zAa6IPrcCp0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9RKnV8q3+QHMO14vnhgfIPWPYlkXg7kb2YvxVqBy2+fNpP1fXkiUOfj8FqSmaTIgpl9wr8Wu+VWQBsPFqR1V84tXcs9hnFQ8WL8YKljqPiExVpSdRkHcLrS6GnGT+DlAqAfvV1Y13skWWpS5gppFMZ/j1C/GaVfOBAHXiyd8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bc1WV0ZTJzWfxX;
	Tue,  8 Jul 2025 21:03:34 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 72046140156;
	Tue,  8 Jul 2025 21:07:59 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 21:07:58 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 06/11] net: hns3: use seq_file for files in mac_list/ in debugfs
Date: Tue, 8 Jul 2025 21:00:24 +0800
Message-ID: <20250708130029.1310872-7-shaojijie@huawei.com>
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
uc/mc

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  4 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 57 ++++++-------------
 2 files changed, 20 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index e687e47393e4..b6b3eb2f5652 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -149,14 +149,14 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_MAC_UC,
 		.dentry = HNS3_DBG_DENTRY_MAC,
 		.buf_len = HNS3_DBG_READ_LEN_128KB,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mc",
 		.cmd = HNAE3_DBG_CMD_MAC_MC,
 		.dentry = HNS3_DBG_DENTRY_MAC,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t2,
 	},
 	{
 		.name = "mng_tbl",
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index e5a5680c2088..29c842d3f184 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -2482,50 +2482,29 @@ hclge_dbg_dump_mac_tnl_status(struct hclge_dev *hdev, char *buf, int len)
 	return 0;
 }
 
-
-static const struct hclge_dbg_item mac_list_items[] = {
-	{ "FUNC_ID", 2 },
-	{ "MAC_ADDR", 12 },
-	{ "STATE", 2 },
-};
-
-static void hclge_dbg_dump_mac_list(struct hclge_dev *hdev, char *buf, int len,
-				    bool is_unicast)
+static void hclge_dbg_dump_mac_list(struct seq_file *s, bool is_unicast)
 {
-	char data_str[ARRAY_SIZE(mac_list_items)][HCLGE_DBG_DATA_STR_LEN];
-	char content[HCLGE_DBG_INFO_LEN], str_id[HCLGE_DBG_ID_LEN];
-	char *result[ARRAY_SIZE(mac_list_items)];
+	struct hclge_dev *hdev = hclge_seq_file_to_hdev(s);
 	struct hclge_mac_node *mac_node, *tmp;
 	struct hclge_vport *vport;
 	struct list_head *list;
-	u32 func_id, i;
-	int pos = 0;
+	u32 func_id;
 
-	for (i = 0; i < ARRAY_SIZE(mac_list_items); i++)
-		result[i] = &data_str[i][0];
-
-	pos += scnprintf(buf + pos, len - pos, "%s MAC_LIST:\n",
-			 is_unicast ? "UC" : "MC");
-	hclge_dbg_fill_content(content, sizeof(content), mac_list_items,
-			       NULL, ARRAY_SIZE(mac_list_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
+	seq_printf(s, "%s MAC_LIST:\n", is_unicast ? "UC" : "MC");
+	seq_puts(s, "FUNC_ID  MAC_ADDR            STATE\n");
 
 	for (func_id = 0; func_id < hdev->num_alloc_vport; func_id++) {
 		vport = &hdev->vport[func_id];
 		list = is_unicast ? &vport->uc_mac_list : &vport->mc_mac_list;
 		spin_lock_bh(&vport->mac_list_lock);
 		list_for_each_entry_safe(mac_node, tmp, list, node) {
-			i = 0;
-			result[i++] = hclge_dbg_get_func_id_str(str_id,
-								func_id);
-			sprintf(result[i++], "%pM", mac_node->mac_addr);
-			sprintf(result[i++], "%5s",
-				hclge_mac_state_str[mac_node->state]);
-			hclge_dbg_fill_content(content, sizeof(content),
-					       mac_list_items,
-					       (const char **)result,
-					       ARRAY_SIZE(mac_list_items));
-			pos += scnprintf(buf + pos, len - pos, "%s", content);
+			if (func_id)
+				seq_printf(s, "vf%-7u", func_id - 1U);
+			else
+				seq_puts(s, "pf       ");
+			seq_printf(s, "%pM   ", mac_node->mac_addr);
+			seq_printf(s, "%5s\n",
+				   hclge_mac_state_str[mac_node->state]);
 		}
 		spin_unlock_bh(&vport->mac_list_lock);
 	}
@@ -2893,16 +2872,16 @@ static int hclge_dbg_dump_ptp_info(struct hclge_dev *hdev, char *buf, int len)
 	return 0;
 }
 
-static int hclge_dbg_dump_mac_uc(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_mac_uc(struct seq_file *s, void *data)
 {
-	hclge_dbg_dump_mac_list(hdev, buf, len, true);
+	hclge_dbg_dump_mac_list(s, true);
 
 	return 0;
 }
 
-static int hclge_dbg_dump_mac_mc(struct hclge_dev *hdev, char *buf, int len)
+static int hclge_dbg_dump_mac_mc(struct seq_file *s, void *data)
 {
-	hclge_dbg_dump_mac_list(hdev, buf, len, false);
+	hclge_dbg_dump_mac_list(s, false);
 
 	return 0;
 }
@@ -2954,11 +2933,11 @@ static const struct hclge_dbg_func hclge_dbg_cmd_func[] = {
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_MAC_UC,
-		.dbg_dump = hclge_dbg_dump_mac_uc,
+		.dbg_read_func = hclge_dbg_dump_mac_uc,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_MAC_MC,
-		.dbg_dump = hclge_dbg_dump_mac_mc,
+		.dbg_read_func = hclge_dbg_dump_mac_mc,
 	},
 	{
 		.cmd = HNAE3_DBG_CMD_MNG_TBL,
-- 
2.33.0


