Return-Path: <netdev+bounces-204967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC29AFCB79
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308B54277C5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FAE2E041F;
	Tue,  8 Jul 2025 13:08:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73942DECBF;
	Tue,  8 Jul 2025 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980087; cv=none; b=hHVzmwEAVCBgv7tYgt0CWlylg3zC3m19vSPv4ulWAWAFpF++8cwjopl9DAmhGJbOIe0E9mzlfnzj0V8VVh6cRsdr1xgZmDn3H+tzKnGyJSgkLyymVhRYKurQoDICBs9iPeScMON100iOHHoK9R3y+cgHko+lMPkeRy0P5lDuGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980087; c=relaxed/simple;
	bh=Xac90ZZQCDDnOLbzQYwWGrDJ/LuRYG5SDaUM5tOufZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MS8IkfUy2xl1bDkxUy8ywo82jB5CfcVqKgctCjl6q56PUgdD0KNViLwFuv68bto890f21OHkUkI02WjkXLOIVYiEVtJETSKXpH6WgrYAd9dHpgsHUceEOXAfjKmyFSb4gJxQgf0LH/Y8mVHzLu/qI/WP25gaT8oXCk6orzXjlSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bc1Yb5xn7z13MlQ;
	Tue,  8 Jul 2025 21:05:23 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 84EE7140156;
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
Subject: [PATCH net-next 10/11] net: hns3: use seq_file for files in tx_bd_info/ and rx_bd_info/ in debugfs
Date: Tue, 8 Jul 2025 21:00:28 +0800
Message-ID: <20250708130029.1310872-11-shaojijie@huawei.com>
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

This patch use seq_file for the following nodes:
tx_bd_queue_*/rx_bd_queue_*

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 194 +++++++-----------
 1 file changed, 74 insertions(+), 120 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 7e9208e69c74..e038e408de53 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -693,157 +693,100 @@ static int hns3_dbg_queue_map(struct seq_file *s, void *data)
 	return 0;
 }
 
-static const struct hns3_dbg_item rx_bd_info_items[] = {
-	{ "BD_IDX", 3 },
-	{ "L234_INFO", 2 },
-	{ "PKT_LEN", 3 },
-	{ "SIZE", 4 },
-	{ "RSS_HASH", 4 },
-	{ "FD_ID", 2 },
-	{ "VLAN_TAG", 2 },
-	{ "O_DM_VLAN_ID_FB", 2 },
-	{ "OT_VLAN_TAG", 2 },
-	{ "BD_BASE_INFO", 2 },
-	{ "PTYPE", 2 },
-	{ "HW_CSUM", 2 },
-};
-
 static void hns3_dump_rx_bd_info(struct hns3_nic_priv *priv,
-				 struct hns3_desc *desc, char **result, int idx)
+				 struct hns3_desc *desc, struct seq_file *s,
+				 int idx)
 {
-	unsigned int j = 0;
-
-	sprintf(result[j++], "%d", idx);
-	sprintf(result[j++], "%#x", le32_to_cpu(desc->rx.l234_info));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.pkt_len));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.size));
-	sprintf(result[j++], "%#x", le32_to_cpu(desc->rx.rss_hash));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.fd_id));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.vlan_tag));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.o_dm_vlan_id_fb));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->rx.ot_vlan_tag));
-	sprintf(result[j++], "%#x", le32_to_cpu(desc->rx.bd_base_info));
+	seq_printf(s, "%-9d%#-11x%-10u%-8u%#-12x%-7u%-10u%-17u%-13u%#-14x",
+		   idx, le32_to_cpu(desc->rx.l234_info),
+		   le16_to_cpu(desc->rx.pkt_len), le16_to_cpu(desc->rx.size),
+		   le32_to_cpu(desc->rx.rss_hash), le16_to_cpu(desc->rx.fd_id),
+		   le16_to_cpu(desc->rx.vlan_tag),
+		   le16_to_cpu(desc->rx.o_dm_vlan_id_fb),
+		   le16_to_cpu(desc->rx.ot_vlan_tag),
+		   le32_to_cpu(desc->rx.bd_base_info));
+
 	if (test_bit(HNS3_NIC_STATE_RXD_ADV_LAYOUT_ENABLE, &priv->state)) {
 		u32 ol_info = le32_to_cpu(desc->rx.ol_info);
 
-		sprintf(result[j++], "%5lu", hnae3_get_field(ol_info,
-							     HNS3_RXD_PTYPE_M,
-							     HNS3_RXD_PTYPE_S));
-		sprintf(result[j++], "%7u", le16_to_cpu(desc->csum));
+		seq_printf(s, "%-7lu%-9u\n",
+			   hnae3_get_field(ol_info, HNS3_RXD_PTYPE_M,
+					   HNS3_RXD_PTYPE_S),
+			   le16_to_cpu(desc->csum));
 	} else {
-		sprintf(result[j++], "NA");
-		sprintf(result[j++], "NA");
+		seq_puts(s, "NA     NA\n");
 	}
 }
 
-static int hns3_dbg_rx_bd_info(struct hns3_dbg_data *d, char *buf, int len)
+static int hns3_dbg_rx_bd_info(struct seq_file *s, void *private)
 {
-	char data_str[ARRAY_SIZE(rx_bd_info_items)][HNS3_DBG_DATA_STR_LEN];
-	struct hns3_nic_priv *priv = d->handle->priv;
-	char *result[ARRAY_SIZE(rx_bd_info_items)];
-	char content[HNS3_DBG_INFO_LEN];
+	struct hns3_dbg_data *data = s->private;
+	struct hnae3_handle *h = data->handle;
+	struct hns3_nic_priv *priv = h->priv;
 	struct hns3_enet_ring *ring;
 	struct hns3_desc *desc;
 	unsigned int i;
-	int pos = 0;
 
-	if (d->qid >= d->handle->kinfo.num_tqps) {
-		dev_err(&d->handle->pdev->dev,
-			"queue%u is not in use\n", d->qid);
+	if (data->qid >= h->kinfo.num_tqps) {
+		dev_err(&h->pdev->dev, "queue%u is not in use\n", data->qid);
 		return -EINVAL;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(rx_bd_info_items); i++)
-		result[i] = &data_str[i][0];
+	seq_printf(s, "Queue %u rx bd info:\n", data->qid);
+	seq_puts(s, "BD_IDX   L234_INFO  PKT_LEN   SIZE    ");
+	seq_puts(s, "RSS_HASH    FD_ID  VLAN_TAG  O_DM_VLAN_ID_FB  ");
+	seq_puts(s, "OT_VLAN_TAG  BD_BASE_INFO  PTYPE  HW_CSUM\n");
 
-	pos += scnprintf(buf + pos, len - pos,
-			  "Queue %u rx bd info:\n", d->qid);
-	hns3_dbg_fill_content(content, sizeof(content), rx_bd_info_items,
-			      NULL, ARRAY_SIZE(rx_bd_info_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
-
-	ring = &priv->ring[d->qid + d->handle->kinfo.num_tqps];
+	ring = &priv->ring[data->qid + data->handle->kinfo.num_tqps];
 	for (i = 0; i < ring->desc_num; i++) {
 		desc = &ring->desc[i];
 
-		hns3_dump_rx_bd_info(priv, desc, result, i);
-		hns3_dbg_fill_content(content, sizeof(content),
-				      rx_bd_info_items, (const char **)result,
-				      ARRAY_SIZE(rx_bd_info_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		hns3_dump_rx_bd_info(priv, desc, s, i);
 	}
 
 	return 0;
 }
 
-static const struct hns3_dbg_item tx_bd_info_items[] = {
-	{ "BD_IDX", 2 },
-	{ "ADDRESS", 13 },
-	{ "VLAN_TAG", 2 },
-	{ "SIZE", 2 },
-	{ "T_CS_VLAN_TSO", 2 },
-	{ "OT_VLAN_TAG", 3 },
-	{ "TV", 5 },
-	{ "OLT_VLAN_LEN", 2 },
-	{ "PAYLEN_OL4CS", 2 },
-	{ "BD_FE_SC_VLD", 2 },
-	{ "MSS_HW_CSUM", 0 },
-};
-
-static void hns3_dump_tx_bd_info(struct hns3_desc *desc, char **result, int idx)
+static void hns3_dump_tx_bd_info(struct hns3_desc *desc, struct seq_file *s,
+				 int idx)
 {
-	unsigned int j = 0;
-
-	sprintf(result[j++], "%d", idx);
-	sprintf(result[j++], "%#llx", le64_to_cpu(desc->addr));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->tx.vlan_tag));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->tx.send_size));
-	sprintf(result[j++], "%#x",
-		le32_to_cpu(desc->tx.type_cs_vlan_tso_len));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->tx.outer_vlan_tag));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->tx.tv));
-	sprintf(result[j++], "%u",
-		le32_to_cpu(desc->tx.ol_type_vlan_len_msec));
-	sprintf(result[j++], "%#x", le32_to_cpu(desc->tx.paylen_ol4cs));
-	sprintf(result[j++], "%#x", le16_to_cpu(desc->tx.bdtp_fe_sc_vld_ra_ri));
-	sprintf(result[j++], "%u", le16_to_cpu(desc->tx.mss_hw_csum));
+	seq_printf(s, "%-8d%#-20llx%-10u%-6u%#-15x%-14u%-7u%-16u%#-14x%#-14x%-11u\n",
+		   idx, le64_to_cpu(desc->addr),
+		   le16_to_cpu(desc->tx.vlan_tag),
+		   le16_to_cpu(desc->tx.send_size),
+		   le32_to_cpu(desc->tx.type_cs_vlan_tso_len),
+		   le16_to_cpu(desc->tx.outer_vlan_tag),
+		   le16_to_cpu(desc->tx.tv),
+		   le32_to_cpu(desc->tx.ol_type_vlan_len_msec),
+		   le32_to_cpu(desc->tx.paylen_ol4cs),
+		   le16_to_cpu(desc->tx.bdtp_fe_sc_vld_ra_ri),
+		   le16_to_cpu(desc->tx.mss_hw_csum));
 }
 
-static int hns3_dbg_tx_bd_info(struct hns3_dbg_data *d, char *buf, int len)
+static int hns3_dbg_tx_bd_info(struct seq_file *s, void *private)
 {
-	char data_str[ARRAY_SIZE(tx_bd_info_items)][HNS3_DBG_DATA_STR_LEN];
-	struct hns3_nic_priv *priv = d->handle->priv;
-	char *result[ARRAY_SIZE(tx_bd_info_items)];
-	char content[HNS3_DBG_INFO_LEN];
+	struct hns3_dbg_data *data = s->private;
+	struct hnae3_handle *h = data->handle;
+	struct hns3_nic_priv *priv = h->priv;
 	struct hns3_enet_ring *ring;
 	struct hns3_desc *desc;
 	unsigned int i;
-	int pos = 0;
 
-	if (d->qid >= d->handle->kinfo.num_tqps) {
-		dev_err(&d->handle->pdev->dev,
-			"queue%u is not in use\n", d->qid);
+	if (data->qid >= h->kinfo.num_tqps) {
+		dev_err(&h->pdev->dev, "queue%u is not in use\n", data->qid);
 		return -EINVAL;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(tx_bd_info_items); i++)
-		result[i] = &data_str[i][0];
-
-	pos += scnprintf(buf + pos, len - pos,
-			  "Queue %u tx bd info:\n", d->qid);
-	hns3_dbg_fill_content(content, sizeof(content), tx_bd_info_items,
-			      NULL, ARRAY_SIZE(tx_bd_info_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
+	seq_printf(s, "Queue %u tx bd info:\n", data->qid);
+	seq_puts(s, "BD_IDX  ADDRESS             VLAN_TAG  SIZE  ");
+	seq_puts(s, "T_CS_VLAN_TSO  OT_VLAN_TAG   TV     OLT_VLAN_LEN  ");
+	seq_puts(s, "PAYLEN_OL4CS  BD_FE_SC_VLD   MSS_HW_CSUM\n");
 
-	ring = &priv->ring[d->qid];
+	ring = &priv->ring[data->qid];
 	for (i = 0; i < ring->desc_num; i++) {
 		desc = &ring->desc[i];
 
-		hns3_dump_tx_bd_info(desc, result, i);
-		hns3_dbg_fill_content(content, sizeof(content),
-				      tx_bd_info_items, (const char **)result,
-				      ARRAY_SIZE(tx_bd_info_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		hns3_dump_tx_bd_info(desc, s, i);
 	}
 
 	return 0;
@@ -973,14 +916,6 @@ static int hns3_dbg_get_cmd_index(struct hns3_dbg_data *dbg_data, u32 *index)
 }
 
 static const struct hns3_dbg_func hns3_dbg_cmd_func[] = {
-	{
-		.cmd = HNAE3_DBG_CMD_TX_BD,
-		.dbg_dump_bd = hns3_dbg_tx_bd_info,
-	},
-	{
-		.cmd = HNAE3_DBG_CMD_RX_BD,
-		.dbg_dump_bd = hns3_dbg_rx_bd_info,
-	},
 };
 
 static int hns3_dbg_read_cmd(struct hns3_dbg_data *dbg_data,
@@ -1062,10 +997,29 @@ static const struct file_operations hns3_dbg_fops = {
 	.release = hns3_dbg_release,
 };
 
+static int hns3_dbg_bd_info_show(struct seq_file *s, void *private)
+{
+	struct hns3_dbg_data *data = s->private;
+	struct hnae3_handle *h = data->handle;
+	struct hns3_nic_priv *priv = h->priv;
+
+	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
+	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+		return -EBUSY;
+
+	if (data->cmd == HNAE3_DBG_CMD_TX_BD)
+		return hns3_dbg_tx_bd_info(s, private);
+	else if (data->cmd == HNAE3_DBG_CMD_RX_BD)
+		return hns3_dbg_rx_bd_info(s, private);
+
+	return -EOPNOTSUPP;
+}
+DEFINE_SHOW_ATTRIBUTE(hns3_dbg_bd_info);
+
 static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd)
 {
-	struct dentry *entry_dir;
 	struct hns3_dbg_data *data;
+	struct dentry *entry_dir;
 	u16 max_queue_num;
 	unsigned int i;
 
@@ -1084,7 +1038,7 @@ static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd)
 		data[i].qid = i;
 		sprintf(name, "%s%u", hns3_dbg_cmd[cmd].name, i);
 		debugfs_create_file(name, 0400, entry_dir, &data[i],
-				    &hns3_dbg_fops);
+				    &hns3_dbg_bd_info_fops);
 	}
 
 	return 0;
-- 
2.33.0


