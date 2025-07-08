Return-Path: <netdev+bounces-204961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08596AFCB6D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F234D1BC6927
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5E12DE6E5;
	Tue,  8 Jul 2025 13:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648211F4CB2;
	Tue,  8 Jul 2025 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980083; cv=none; b=T25XIhugifz3XROEFGR6//g7kISYE7uv52u095FR7mT5mJ9/pQei3RQj0cAbjX7jKtEjVgRmPXO/J7n0dOHBJT09V6t4dxST4dfDrj5Wj9NruOp47ahsM/3Qw4ypthkhIJciIPWxrWrk/v194uEbdhUrp0fkVEeZkh2FjKh8ISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980083; c=relaxed/simple;
	bh=QzC7eFhDu610iYeJhqTM2+yej379+e7jAnyWst+WBrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3ygZ8vNEXcM+RPtyespidEkjhtPyCbZZB70bkQjpjZusncmN307Gx8JG3Ba+t7RzktnFqPDqxqVJwLd3jJIAjktGX5T6HWWw8HZt+C+coM+HThxJ43H8nUAIhFGBvYVV5vPrICn5OURQi8YqnFU5y6XD/QQAX65MY4NECxzuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bc1WS00xfzWfyr;
	Tue,  8 Jul 2025 21:03:31 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F5FB180237;
	Tue,  8 Jul 2025 21:07:57 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 21:07:56 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 02/11] net: hns3: clean up the build warning in debugfs by use seq file
Date: Tue, 8 Jul 2025 21:00:20 +0800
Message-ID: <20250708130029.1310872-3-shaojijie@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

Arnd reported that there are two build warning for on-stasck
buffer oversize. As Arnd's suggestion, using seq file way
to avoid the stack buffer or kmalloc buffer allocating.

Reported-by: Arnd Bergmann <arnd@kernel.org>
Closes: https://lore.kernel.org/all/20250610092113.2639248-1-arnd@kernel.org/
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   8 ++
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 128 ++++++++----------
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |   2 +
 3 files changed, 63 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 8dc7d6fae224..474cc6c8d748 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -339,6 +339,11 @@ enum hnae3_dbg_cmd {
 	HNAE3_DBG_CMD_UNKNOWN,
 };
 
+#define hnae3_seq_file_to_ae_dev(s)	\
+		((struct hnae3_ae_dev *)dev_get_drvdata((s)->private))
+#define hnae3_seq_file_to_handle(s)	\
+		((struct hnae3_handle *)(hnae3_seq_file_to_ae_dev(s)->handle))
+
 enum hnae3_tc_map_mode {
 	HNAE3_TC_MAP_MODE_PRIO,
 	HNAE3_TC_MAP_MODE_DSCP,
@@ -434,8 +439,11 @@ struct hnae3_ae_dev {
 	u32 dev_version;
 	DECLARE_BITMAP(caps, HNAE3_DEV_CAPS_MAX_NUM);
 	void *priv;
+	struct hnae3_handle *handle;
 };
 
+typedef int (*read_func)(struct seq_file *s, void *data);
+
 /* This struct defines the operation on the handle.
  *
  * init_ae_dev(): (mandatory)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index aec719ce3ccd..52877ffec928 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -3,6 +3,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/seq_file.h>
 #include <linux/string_choices.h>
 
 #include "hnae3.h"
@@ -41,6 +42,7 @@ static struct hns3_dbg_dentry_info hns3_dbg_dentry[] = {
 
 static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd);
 static int hns3_dbg_common_file_init(struct hnae3_handle *handle, u32 cmd);
+static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32 cmd);
 
 static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 	{
@@ -300,7 +302,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_TX_QUEUE_INFO,
 		.dentry = HNS3_DBG_DENTRY_QUEUE,
 		.buf_len = HNS3_DBG_READ_LEN_1MB,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "fd_tcam",
@@ -674,77 +676,45 @@ static int hns3_dbg_rx_queue_info(struct hnae3_handle *h,
 	return 0;
 }
 
-static const struct hns3_dbg_item tx_queue_info_items[] = {
-	{ "QUEUE_ID", 2 },
-	{ "BD_NUM", 2 },
-	{ "TC", 2 },
-	{ "TAIL", 2 },
-	{ "HEAD", 2 },
-	{ "FBDNUM", 2 },
-	{ "OFFSET", 2 },
-	{ "PKTNUM", 5 },
-	{ "RING_EN", 2 },
-	{ "TX_RING_EN", 2 },
-	{ "BASE_ADDR", 10 },
-};
-
 static void hns3_dump_tx_queue_info(struct hns3_enet_ring *ring,
-				    struct hnae3_ae_dev *ae_dev, char **result,
-				    u32 index)
+				    struct seq_file *s, u32 index)
 {
+	struct hnae3_ae_dev *ae_dev = hnae3_seq_file_to_ae_dev(s);
+	void __iomem *base = ring->tqp->io_base;
 	u32 base_add_l, base_add_h;
-	u32 j = 0;
 
-	sprintf(result[j++], "%u", index);
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_BD_NUM_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_TC_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_TAIL_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_HEAD_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_FBDNUM_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_OFFSET_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_TX_RING_PKTNUM_RECORD_REG));
-
-	sprintf(result[j++], "%s",
-		str_on_off(readl_relaxed(ring->tqp->io_base +
-					 HNS3_RING_EN_REG)));
+	seq_printf(s, "%-10u", index);
+	seq_printf(s, "%-8u",
+		   readl_relaxed(base + HNS3_RING_TX_RING_BD_NUM_REG));
+	seq_printf(s, "%-4u", readl_relaxed(base + HNS3_RING_TX_RING_TC_REG));
+	seq_printf(s, "%-6u", readl_relaxed(base + HNS3_RING_TX_RING_TAIL_REG));
+	seq_printf(s, "%-6u", readl_relaxed(base + HNS3_RING_TX_RING_HEAD_REG));
+	seq_printf(s, "%-8u",
+		   readl_relaxed(base + HNS3_RING_TX_RING_FBDNUM_REG));
+	seq_printf(s, "%-8u",
+		   readl_relaxed(base + HNS3_RING_TX_RING_OFFSET_REG));
+	seq_printf(s, "%-11u",
+		   readl_relaxed(base + HNS3_RING_TX_RING_PKTNUM_RECORD_REG));
+	seq_printf(s, "%-9s",
+		   str_on_off(readl_relaxed(base + HNS3_RING_EN_REG)));
 
 	if (hnae3_ae_dev_tqp_txrx_indep_supported(ae_dev))
-		sprintf(result[j++], "%s",
-			str_on_off(readl_relaxed(ring->tqp->io_base +
-						 HNS3_RING_TX_EN_REG)));
+		seq_printf(s, "%-12s",
+			   str_on_off(readl_relaxed(base +
+						    HNS3_RING_TX_EN_REG)));
 	else
-		sprintf(result[j++], "%s", "NA");
+		seq_printf(s, "%-12s", "NA");
 
-	base_add_h = readl_relaxed(ring->tqp->io_base +
-					HNS3_RING_TX_RING_BASEADDR_H_REG);
-	base_add_l = readl_relaxed(ring->tqp->io_base +
-					HNS3_RING_TX_RING_BASEADDR_L_REG);
-	sprintf(result[j++], "0x%08x%08x", base_add_h, base_add_l);
+	base_add_h = readl_relaxed(base + HNS3_RING_TX_RING_BASEADDR_H_REG);
+	base_add_l = readl_relaxed(base + HNS3_RING_TX_RING_BASEADDR_L_REG);
+	seq_printf(s, "0x%08x%08x\n", base_add_h, base_add_l);
 }
 
-static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
-				  char *buf, int len)
+static int hns3_dbg_tx_queue_info(struct seq_file *s, void *data)
 {
-	char data_str[ARRAY_SIZE(tx_queue_info_items)][HNS3_DBG_DATA_STR_LEN];
-	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
-	char *result[ARRAY_SIZE(tx_queue_info_items)];
+	struct hnae3_handle *h = hnae3_seq_file_to_handle(s);
 	struct hns3_nic_priv *priv = h->priv;
-	char content[HNS3_DBG_INFO_LEN];
 	struct hns3_enet_ring *ring;
-	int pos = 0;
 	u32 i;
 
 	if (!priv->ring) {
@@ -752,12 +722,8 @@ static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
 		return -EFAULT;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(tx_queue_info_items); i++)
-		result[i] = &data_str[i][0];
-
-	hns3_dbg_fill_content(content, sizeof(content), tx_queue_info_items,
-			      NULL, ARRAY_SIZE(tx_queue_info_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
+	seq_puts(s, "QUEUE_ID  BD_NUM  TC  TAIL  HEAD  FBDNUM  OFFSET  ");
+	seq_puts(s, "PKTNUM     RING_EN  TX_RING_EN  BASE_ADDR\n");
 
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
 		/* Each cycle needs to determine whether the instance is reset,
@@ -769,12 +735,7 @@ static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
 			return -EPERM;
 
 		ring = &priv->ring[i];
-		hns3_dump_tx_queue_info(ring, ae_dev, result, i);
-		hns3_dbg_fill_content(content, sizeof(content),
-				      tx_queue_info_items,
-				      (const char **)result,
-				      ARRAY_SIZE(tx_queue_info_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		hns3_dump_tx_queue_info(ring, s, i);
 	}
 
 	return 0;
@@ -1170,10 +1131,6 @@ static const struct hns3_dbg_func hns3_dbg_cmd_func[] = {
 		.cmd = HNAE3_DBG_CMD_RX_QUEUE_INFO,
 		.dbg_dump = hns3_dbg_rx_queue_info,
 	},
-	{
-		.cmd = HNAE3_DBG_CMD_TX_QUEUE_INFO,
-		.dbg_dump = hns3_dbg_tx_queue_info,
-	},
 	{
 		.cmd = HNAE3_DBG_CMD_PAGE_POOL_INFO,
 		.dbg_dump = hns3_dbg_page_pool_info,
@@ -1310,6 +1267,27 @@ hns3_dbg_common_file_init(struct hnae3_handle *handle, u32 cmd)
 	return 0;
 }
 
+static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32 cmd)
+{
+	struct device *dev = &handle->pdev->dev;
+	struct dentry *entry_dir;
+	read_func func = NULL;
+
+	switch (hns3_dbg_cmd[cmd].cmd) {
+	case HNAE3_DBG_CMD_TX_QUEUE_INFO:
+		func = hns3_dbg_tx_queue_info;
+		break;
+	default:
+		return -EINVAL;
+	}
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
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 49fcee7a6d0f..52f42fe1d56f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5299,6 +5299,8 @@ static int hns3_client_init(struct hnae3_handle *handle)
 	struct net_device *netdev;
 	int ret;
 
+	ae_dev->handle = handle;
+
 	handle->ae_algo->ops->get_tqps_and_rss_info(handle, &alloc_tqps,
 						    &max_rss_size);
 	netdev = alloc_etherdev_mq(sizeof(struct hns3_nic_priv), alloc_tqps);
-- 
2.33.0


