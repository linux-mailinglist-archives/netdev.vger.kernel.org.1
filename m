Return-Path: <netdev+bounces-206547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53891B036E8
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 08:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109FA17A6A4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 06:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23665231A51;
	Mon, 14 Jul 2025 06:18:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E0228CB5;
	Mon, 14 Jul 2025 06:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473889; cv=none; b=XZLg34mUyi7LOLUCicrC3XnviWmWcCjNgVXOqiIAafqX6yHR4XjiUlhzrwMK16OEDUYw/mcppP2KMtPV9RRAWaNZ63IDu55dVThBsbWjTPuP5nYc9XPlveT8/+WsoMMyeojmHzHmyV2Op+IKIjXOYPVfG8pwd/V6mYUPiEGMOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473889; c=relaxed/simple;
	bh=A+uTG2IylH0egwSFG0meytDPc02VJnBvLXBwDHcrmz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdzGBToAO5yrXSkxXjKAmF5q5sOIckA//KVZHKLazM8aTxmQWb7wKkoDTuoc3sp8rNn48Sq5qWlDFrqW3xwQZ1oOcXxBvafRtBR4LKztnktaKN9Mt0TRINVXs7+YhaePjGR8TocSr1B7z132j6d27axpmx8pDuxMWI6hbuAoOqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bgX7y1NBHzHrTN;
	Mon, 14 Jul 2025 14:13:50 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 7129F1402FA;
	Mon, 14 Jul 2025 14:17:56 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 14:17:55 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net-next 03/10] net: hns3: use seq_file for files in queue/ in debugfs
Date: Mon, 14 Jul 2025 14:10:30 +0800
Message-ID: <20250714061037.2616413-4-shaojijie@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

This patch use seq_file for the following nodes:
rx_queue_info/queue_map

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 149 ++++++------------
 1 file changed, 44 insertions(+), 105 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 52877ffec928..bb1adf9daec7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -288,14 +288,14 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_QUEUE_MAP,
 		.dentry = HNS3_DBG_DENTRY_QUEUE,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "rx_queue_info",
 		.cmd = HNAE3_DBG_CMD_RX_QUEUE_INFO,
 		.dentry = HNS3_DBG_DENTRY_QUEUE,
 		.buf_len = HNS3_DBG_READ_LEN_1MB,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "tx_queue_info",
@@ -572,76 +572,46 @@ static int hns3_dbg_coal_info(struct hnae3_handle *h, char *buf, int len)
 	return 0;
 }
 
-static const struct hns3_dbg_item rx_queue_info_items[] = {
-	{ "QUEUE_ID", 2 },
-	{ "BD_NUM", 2 },
-	{ "BD_LEN", 2 },
-	{ "TAIL", 2 },
-	{ "HEAD", 2 },
-	{ "FBDNUM", 2 },
-	{ "PKTNUM", 5 },
-	{ "COPYBREAK", 2 },
-	{ "RING_EN", 2 },
-	{ "RX_RING_EN", 2 },
-	{ "BASE_ADDR", 10 },
-};
-
 static void hns3_dump_rx_queue_info(struct hns3_enet_ring *ring,
-				    struct hnae3_ae_dev *ae_dev, char **result,
-				    u32 index)
+				    struct seq_file *s, u32 index)
 {
+	struct hnae3_ae_dev *ae_dev = hnae3_seq_file_to_ae_dev(s);
+	void __iomem *base = ring->tqp->io_base;
 	u32 base_add_l, base_add_h;
-	u32 j = 0;
-
-	sprintf(result[j++], "%u", index);
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_RX_RING_BD_NUM_REG));
 
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_RX_RING_BD_LEN_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_RX_RING_TAIL_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_RX_RING_HEAD_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_RX_RING_FBDNUM_REG));
-
-	sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
-		HNS3_RING_RX_RING_PKTNUM_RECORD_REG));
-	sprintf(result[j++], "%u", ring->rx_copybreak);
-
-	sprintf(result[j++], "%s",
-		str_on_off(readl_relaxed(ring->tqp->io_base +
-					 HNS3_RING_EN_REG)));
+	seq_printf(s, "%-10u", index);
+	seq_printf(s, "%-8u",
+		   readl_relaxed(base + HNS3_RING_RX_RING_BD_NUM_REG));
+	seq_printf(s, "%-8u",
+		   readl_relaxed(base + HNS3_RING_RX_RING_BD_LEN_REG));
+	seq_printf(s, "%-6u",
+		   readl_relaxed(base + HNS3_RING_RX_RING_TAIL_REG));
+	seq_printf(s, "%-6u",
+		   readl_relaxed(base + HNS3_RING_RX_RING_HEAD_REG));
+	seq_printf(s, "%-8u",
+		   readl_relaxed(base + HNS3_RING_RX_RING_FBDNUM_REG));
+	seq_printf(s, "%-11u", readl_relaxed(base +
+		   HNS3_RING_RX_RING_PKTNUM_RECORD_REG));
+	seq_printf(s, "%-11u", ring->rx_copybreak);
+	seq_printf(s, "%-9s",
+		   str_on_off(readl_relaxed(base + HNS3_RING_EN_REG)));
 
 	if (hnae3_ae_dev_tqp_txrx_indep_supported(ae_dev))
-		sprintf(result[j++], "%s",
-			str_on_off(readl_relaxed(ring->tqp->io_base +
-						 HNS3_RING_RX_EN_REG)));
+		seq_printf(s, "%-12s", str_on_off(readl_relaxed(base +
+						  HNS3_RING_RX_EN_REG)));
 	else
-		sprintf(result[j++], "%s", "NA");
+		seq_printf(s, "%-12s", "NA");
 
-	base_add_h = readl_relaxed(ring->tqp->io_base +
-					HNS3_RING_RX_RING_BASEADDR_H_REG);
-	base_add_l = readl_relaxed(ring->tqp->io_base +
-					HNS3_RING_RX_RING_BASEADDR_L_REG);
-	sprintf(result[j++], "0x%08x%08x", base_add_h, base_add_l);
+	base_add_h = readl_relaxed(base + HNS3_RING_RX_RING_BASEADDR_H_REG);
+	base_add_l = readl_relaxed(base + HNS3_RING_RX_RING_BASEADDR_L_REG);
+	seq_printf(s, "0x%08x%08x\n", base_add_h, base_add_l);
 }
 
-static int hns3_dbg_rx_queue_info(struct hnae3_handle *h,
-				  char *buf, int len)
+static int hns3_dbg_rx_queue_info(struct seq_file *s, void *data)
 {
-	char data_str[ARRAY_SIZE(rx_queue_info_items)][HNS3_DBG_DATA_STR_LEN];
-	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
-	char *result[ARRAY_SIZE(rx_queue_info_items)];
+	struct hnae3_handle *h = hnae3_seq_file_to_handle(s);
 	struct hns3_nic_priv *priv = h->priv;
-	char content[HNS3_DBG_INFO_LEN];
 	struct hns3_enet_ring *ring;
-	int pos = 0;
 	u32 i;
 
 	if (!priv->ring) {
@@ -649,12 +619,9 @@ static int hns3_dbg_rx_queue_info(struct hnae3_handle *h,
 		return -EFAULT;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(rx_queue_info_items); i++)
-		result[i] = &data_str[i][0];
+	seq_puts(s, "QUEUE_ID  BD_NUM  BD_LEN  TAIL  HEAD  FBDNUM  ");
+	seq_puts(s, "PKTNUM     COPYBREAK  RING_EN  RX_RING_EN  BASE_ADDR\n");
 
-	hns3_dbg_fill_content(content, sizeof(content), rx_queue_info_items,
-			      NULL, ARRAY_SIZE(rx_queue_info_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
 		/* Each cycle needs to determine whether the instance is reset,
 		 * to prevent reference to invalid memory. And need to ensure
@@ -665,12 +632,7 @@ static int hns3_dbg_rx_queue_info(struct hnae3_handle *h,
 			return -EPERM;
 
 		ring = &priv->ring[(u32)(i + h->kinfo.num_tqps)];
-		hns3_dump_rx_queue_info(ring, ae_dev, result, i);
-		hns3_dbg_fill_content(content, sizeof(content),
-				      rx_queue_info_items,
-				      (const char **)result,
-				      ARRAY_SIZE(rx_queue_info_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		hns3_dump_rx_queue_info(ring, s, i);
 	}
 
 	return 0;
@@ -741,44 +703,23 @@ static int hns3_dbg_tx_queue_info(struct seq_file *s, void *data)
 	return 0;
 }
 
-static const struct hns3_dbg_item queue_map_items[] = {
-	{ "local_queue_id", 2 },
-	{ "global_queue_id", 2 },
-	{ "vector_id", 2 },
-};
-
-static int hns3_dbg_queue_map(struct hnae3_handle *h, char *buf, int len)
+static int hns3_dbg_queue_map(struct seq_file *s, void *data)
 {
-	char data_str[ARRAY_SIZE(queue_map_items)][HNS3_DBG_DATA_STR_LEN];
-	char *result[ARRAY_SIZE(queue_map_items)];
+	struct hnae3_handle *h = hnae3_seq_file_to_handle(s);
 	struct hns3_nic_priv *priv = h->priv;
-	char content[HNS3_DBG_INFO_LEN];
-	int pos = 0;
-	int j;
 	u32 i;
 
 	if (!h->ae_algo->ops->get_global_queue_id)
 		return -EOPNOTSUPP;
 
-	for (i = 0; i < ARRAY_SIZE(queue_map_items); i++)
-		result[i] = &data_str[i][0];
+	seq_puts(s, "local_queue_id  global_queue_id  vector_id\n");
 
-	hns3_dbg_fill_content(content, sizeof(content), queue_map_items,
-			      NULL, ARRAY_SIZE(queue_map_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
 		if (!priv->ring || !priv->ring[i].tqp_vector)
 			continue;
-		j = 0;
-		sprintf(result[j++], "%u", i);
-		sprintf(result[j++], "%u",
-			h->ae_algo->ops->get_global_queue_id(h, i));
-		sprintf(result[j++], "%d",
-			priv->ring[i].tqp_vector->vector_irq);
-		hns3_dbg_fill_content(content, sizeof(content), queue_map_items,
-				      (const char **)result,
-				      ARRAY_SIZE(queue_map_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		seq_printf(s, "%-16u%-17u%d\n", i,
+			   h->ae_algo->ops->get_global_queue_id(h, i),
+			   priv->ring[i].tqp_vector->vector_irq);
 	}
 
 	return 0;
@@ -1111,10 +1052,6 @@ static int hns3_dbg_get_cmd_index(struct hns3_dbg_data *dbg_data, u32 *index)
 }
 
 static const struct hns3_dbg_func hns3_dbg_cmd_func[] = {
-	{
-		.cmd = HNAE3_DBG_CMD_QUEUE_MAP,
-		.dbg_dump = hns3_dbg_queue_map,
-	},
 	{
 		.cmd = HNAE3_DBG_CMD_DEV_INFO,
 		.dbg_dump = hns3_dbg_dev_info,
@@ -1127,10 +1064,6 @@ static const struct hns3_dbg_func hns3_dbg_cmd_func[] = {
 		.cmd = HNAE3_DBG_CMD_RX_BD,
 		.dbg_dump_bd = hns3_dbg_rx_bd_info,
 	},
-	{
-		.cmd = HNAE3_DBG_CMD_RX_QUEUE_INFO,
-		.dbg_dump = hns3_dbg_rx_queue_info,
-	},
 	{
 		.cmd = HNAE3_DBG_CMD_PAGE_POOL_INFO,
 		.dbg_dump = hns3_dbg_page_pool_info,
@@ -1277,6 +1210,12 @@ static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32 cmd)
 	case HNAE3_DBG_CMD_TX_QUEUE_INFO:
 		func = hns3_dbg_tx_queue_info;
 		break;
+	case HNAE3_DBG_CMD_RX_QUEUE_INFO:
+		func = hns3_dbg_rx_queue_info;
+		break;
+	case HNAE3_DBG_CMD_QUEUE_MAP:
+		func = hns3_dbg_queue_map;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.33.0


