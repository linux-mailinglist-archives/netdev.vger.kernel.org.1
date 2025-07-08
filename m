Return-Path: <netdev+bounces-204962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B75AFCB6E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BC53B4B27
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A517B2DEA6C;
	Tue,  8 Jul 2025 13:08:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF2326B08F;
	Tue,  8 Jul 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980083; cv=none; b=PrW7EBcW+XIZsWKepvF6tzFgE+t92UqQG+Ptz5s50oqSSbz4N8snNCYephFjuqoY/wROjhNAB6J3qJkWiiKNm+hJzlPU+Jy6896FbazirDPJNhzq4iJmETA0MonyHdzeB9nZnRrx+tDD+Te2HpjXrgO2Lcw3K+/UQAUmH2xEzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980083; c=relaxed/simple;
	bh=yl2+0mucE7moFihttzGyG7Dy/bz+IUq2S63dKYNWBIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKGFsC8qxwP6IJ5TctDMcIQM9CC+/6VscHSUyIGIfJRLMIq7tdSgd97WSHu35EnN0TTmQgFzW3Jq5CKUXEjCYgoT6IBcCJ3ECwpclb75JR1DdrlfOuAbNMtRnxy71E6P9fHg7CZyEKXK7zQ/uZLNXLs/skM9iQ2mUubb6zIqNkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bc1dg71Vmz2qFF0;
	Tue,  8 Jul 2025 21:08:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 649381402CB;
	Tue,  8 Jul 2025 21:07:58 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 21:07:57 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 04/11] net: hns3: use seq_file for files in common/ of hns3 layer
Date: Tue, 8 Jul 2025 21:00:22 +0800
Message-ID: <20250708130029.1310872-5-shaojijie@huawei.com>
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
dev_info/coalesce_info/page_pool_info

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 259 ++++++------------
 1 file changed, 88 insertions(+), 171 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index bb1adf9daec7..a08f8402eea0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -127,7 +127,7 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_DEV_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "tx_bd_queue",
@@ -351,14 +351,14 @@ static struct hns3_dbg_cmd_info hns3_dbg_cmd[] = {
 		.cmd = HNAE3_DBG_CMD_PAGE_POOL_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t1,
 	},
 	{
 		.name = "coalesce_info",
 		.cmd = HNAE3_DBG_CMD_COAL_INFO,
 		.dentry = HNS3_DBG_DENTRY_COMMON,
 		.buf_len = HNS3_DBG_READ_LEN_1MB,
-		.init = hns3_dbg_common_file_init,
+		.init = hns3_dbg_common_init_t1,
 	},
 };
 
@@ -423,21 +423,6 @@ static struct hns3_dbg_cap_info hns3_dbg_cap[] = {
 	}
 };
 
-static const struct hns3_dbg_item coal_info_items[] = {
-	{ "VEC_ID", 2 },
-	{ "ALGO_STATE", 2 },
-	{ "PROFILE_ID", 2 },
-	{ "CQE_MODE", 2 },
-	{ "TUNE_STATE", 2 },
-	{ "STEPS_LEFT", 2 },
-	{ "STEPS_RIGHT", 2 },
-	{ "TIRED", 2 },
-	{ "SW_GL", 2 },
-	{ "SW_QL", 2 },
-	{ "HW_GL", 2 },
-	{ "HW_QL", 2 },
-};
-
 static const char * const dim_cqe_mode_str[] = { "EQE", "CQE" };
 static const char * const dim_state_str[] = { "START", "IN_PROG", "APPLY" };
 static const char * const
@@ -482,12 +467,11 @@ static void hns3_dbg_fill_content(char *content, u16 len,
 }
 
 static void hns3_get_coal_info(struct hns3_enet_tqp_vector *tqp_vector,
-			       char **result, int i, bool is_tx)
+			       struct seq_file *s, int i, bool is_tx)
 {
 	unsigned int gl_offset, ql_offset;
 	struct hns3_enet_coalesce *coal;
 	unsigned int reg_val;
-	unsigned int j = 0;
 	struct dim *dim;
 	bool ql_enable;
 
@@ -505,69 +489,52 @@ static void hns3_get_coal_info(struct hns3_enet_tqp_vector *tqp_vector,
 		ql_enable = tqp_vector->rx_group.coal.ql_enable;
 	}
 
-	sprintf(result[j++], "%d", i);
-	sprintf(result[j++], "%s", dim->state < ARRAY_SIZE(dim_state_str) ?
-		dim_state_str[dim->state] : "unknown");
-	sprintf(result[j++], "%u", dim->profile_ix);
-	sprintf(result[j++], "%s", dim->mode < ARRAY_SIZE(dim_cqe_mode_str) ?
-		dim_cqe_mode_str[dim->mode] : "unknown");
-	sprintf(result[j++], "%s",
-		dim->tune_state < ARRAY_SIZE(dim_tune_stat_str) ?
-		dim_tune_stat_str[dim->tune_state] : "unknown");
-	sprintf(result[j++], "%u", dim->steps_left);
-	sprintf(result[j++], "%u", dim->steps_right);
-	sprintf(result[j++], "%u", dim->tired);
-	sprintf(result[j++], "%u", coal->int_gl);
-	sprintf(result[j++], "%u", coal->int_ql);
+	seq_printf(s, "%-8d", i);
+	seq_printf(s, "%-12s", dim->state < ARRAY_SIZE(dim_state_str) ?
+		   dim_state_str[dim->state] : "unknown");
+	seq_printf(s, "%-12u", dim->profile_ix);
+	seq_printf(s, "%-10s", dim->mode < ARRAY_SIZE(dim_cqe_mode_str) ?
+		   dim_cqe_mode_str[dim->mode] : "unknown");
+	seq_printf(s, "%-12s", dim->tune_state < ARRAY_SIZE(dim_tune_stat_str) ?
+		   dim_tune_stat_str[dim->tune_state] : "unknown");
+	seq_printf(s, "%-12u%-13u%-7u%-7u%-7u", dim->steps_left,
+		   dim->steps_right, dim->tired, coal->int_gl, coal->int_ql);
 	reg_val = readl(tqp_vector->mask_addr + gl_offset) &
 		  HNS3_VECTOR_GL_MASK;
-	sprintf(result[j++], "%u", reg_val);
+	seq_printf(s, "%-7u", reg_val);
 	if (ql_enable) {
 		reg_val = readl(tqp_vector->mask_addr + ql_offset) &
 			  HNS3_VECTOR_QL_MASK;
-		sprintf(result[j++], "%u", reg_val);
+		seq_printf(s, "%u\n", reg_val);
 	} else {
-		sprintf(result[j++], "NA");
+		seq_puts(s, "NA\n");
 	}
 }
 
-static void hns3_dump_coal_info(struct hnae3_handle *h, char *buf, int len,
-				int *pos, bool is_tx)
+static void hns3_dump_coal_info(struct seq_file *s, bool is_tx)
 {
-	char data_str[ARRAY_SIZE(coal_info_items)][HNS3_DBG_DATA_STR_LEN];
-	char *result[ARRAY_SIZE(coal_info_items)];
+	struct hnae3_handle *h = hnae3_seq_file_to_handle(s);
 	struct hns3_enet_tqp_vector *tqp_vector;
 	struct hns3_nic_priv *priv = h->priv;
-	char content[HNS3_DBG_INFO_LEN];
 	unsigned int i;
 
-	for (i = 0; i < ARRAY_SIZE(coal_info_items); i++)
-		result[i] = &data_str[i][0];
+	seq_printf(s, "%s interrupt coalesce info:\n", is_tx ? "tx" : "rx");
 
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "%s interrupt coalesce info:\n",
-			  is_tx ? "tx" : "rx");
-	hns3_dbg_fill_content(content, sizeof(content), coal_info_items,
-			      NULL, ARRAY_SIZE(coal_info_items));
-	*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
+	seq_puts(s, "VEC_ID  ALGO_STATE  PROFILE_ID  CQE_MODE  TUNE_STATE  ");
+	seq_puts(s, "STEPS_LEFT  STEPS_RIGHT  TIRED  SW_GL  SW_QL  ");
+	seq_puts(s, "HW_GL  HW_QL\n");
 
 	for (i = 0; i < priv->vector_num; i++) {
 		tqp_vector = &priv->tqp_vector[i];
-		hns3_get_coal_info(tqp_vector, result, i, is_tx);
-		hns3_dbg_fill_content(content, sizeof(content), coal_info_items,
-				      (const char **)result,
-				      ARRAY_SIZE(coal_info_items));
-		*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
+		hns3_get_coal_info(tqp_vector, s, i, is_tx);
 	}
 }
 
-static int hns3_dbg_coal_info(struct hnae3_handle *h, char *buf, int len)
+static int hns3_dbg_coal_info(struct seq_file *s, void *data)
 {
-	int pos = 0;
-
-	hns3_dump_coal_info(h, buf, len, &pos, true);
-	pos += scnprintf(buf + pos, len - pos, "\n");
-	hns3_dump_coal_info(h, buf, len, &pos, false);
+	hns3_dump_coal_info(s, true);
+	seq_puts(s, "\n");
+	hns3_dump_coal_info(s, false);
 
 	return 0;
 }
@@ -881,126 +848,86 @@ static int hns3_dbg_tx_bd_info(struct hns3_dbg_data *d, char *buf, int len)
 	return 0;
 }
 
-static void
-hns3_dbg_dev_caps(struct hnae3_handle *h, char *buf, int len, int *pos)
+static void hns3_dbg_dev_caps(struct hnae3_handle *h, struct seq_file *s)
 {
 	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(h);
 	unsigned long *caps = ae_dev->caps;
 	u32 i, state;
 
-	*pos += scnprintf(buf + *pos, len - *pos, "dev capability:\n");
+	seq_puts(s, "dev capability:\n");
 
 	for (i = 0; i < ARRAY_SIZE(hns3_dbg_cap); i++) {
 		state = test_bit(hns3_dbg_cap[i].cap_bit, caps);
-		*pos += scnprintf(buf + *pos, len - *pos, "%s: %s\n",
-				  hns3_dbg_cap[i].name, str_yes_no(state));
+		seq_printf(s, "%s: %s\n", hns3_dbg_cap[i].name,
+			   str_yes_no(state));
 	}
 
-	*pos += scnprintf(buf + *pos, len - *pos, "\n");
+	seq_puts(s, "\n");
 }
 
-static void
-hns3_dbg_dev_specs(struct hnae3_handle *h, char *buf, int len, int *pos)
+static void hns3_dbg_dev_specs(struct hnae3_handle *h, struct seq_file *s)
 {
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
 	struct hnae3_dev_specs *dev_specs = &ae_dev->dev_specs;
 	struct hnae3_knic_private_info *kinfo = &h->kinfo;
 	struct net_device *dev = kinfo->netdev;
 
-	*pos += scnprintf(buf + *pos, len - *pos, "dev_spec:\n");
-	*pos += scnprintf(buf + *pos, len - *pos, "MAC entry num: %u\n",
-			  dev_specs->mac_entry_num);
-	*pos += scnprintf(buf + *pos, len - *pos, "MNG entry num: %u\n",
-			  dev_specs->mng_entry_num);
-	*pos += scnprintf(buf + *pos, len - *pos, "MAX non tso bd num: %u\n",
-			  dev_specs->max_non_tso_bd_num);
-	*pos += scnprintf(buf + *pos, len - *pos, "RSS ind tbl size: %u\n",
-			  dev_specs->rss_ind_tbl_size);
-	*pos += scnprintf(buf + *pos, len - *pos, "RSS key size: %u\n",
-			  dev_specs->rss_key_size);
-	*pos += scnprintf(buf + *pos, len - *pos, "RSS size: %u\n",
-			  kinfo->rss_size);
-	*pos += scnprintf(buf + *pos, len - *pos, "Allocated RSS size: %u\n",
-			  kinfo->req_rss_size);
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "Task queue pairs numbers: %u\n",
-			  kinfo->num_tqps);
-	*pos += scnprintf(buf + *pos, len - *pos, "RX buffer length: %u\n",
-			  kinfo->rx_buf_len);
-	*pos += scnprintf(buf + *pos, len - *pos, "Desc num per TX queue: %u\n",
-			  kinfo->num_tx_desc);
-	*pos += scnprintf(buf + *pos, len - *pos, "Desc num per RX queue: %u\n",
-			  kinfo->num_rx_desc);
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "Total number of enabled TCs: %u\n",
-			  kinfo->tc_info.num_tc);
-	*pos += scnprintf(buf + *pos, len - *pos, "MAX INT QL: %u\n",
-			  dev_specs->int_ql_max);
-	*pos += scnprintf(buf + *pos, len - *pos, "MAX INT GL: %u\n",
-			  dev_specs->max_int_gl);
-	*pos += scnprintf(buf + *pos, len - *pos, "MAX TM RATE: %u\n",
-			  dev_specs->max_tm_rate);
-	*pos += scnprintf(buf + *pos, len - *pos, "MAX QSET number: %u\n",
-			  dev_specs->max_qset_num);
-	*pos += scnprintf(buf + *pos, len - *pos, "umv size: %u\n",
-			  dev_specs->umv_size);
-	*pos += scnprintf(buf + *pos, len - *pos, "mc mac size: %u\n",
-			  dev_specs->mc_mac_size);
-	*pos += scnprintf(buf + *pos, len - *pos, "MAC statistics number: %u\n",
-			  dev_specs->mac_stats_num);
-	*pos += scnprintf(buf + *pos, len - *pos,
-			  "TX timeout threshold: %d seconds\n",
-			  dev->watchdog_timeo / HZ);
-	*pos += scnprintf(buf + *pos, len - *pos, "Hilink Version: %u\n",
-			  dev_specs->hilink_version);
+	seq_puts(s, "dev_spec:\n");
+	seq_printf(s, "MAC entry num: %u\n", dev_specs->mac_entry_num);
+	seq_printf(s, "MNG entry num: %u\n", dev_specs->mng_entry_num);
+	seq_printf(s, "MAX non tso bd num: %u\n",
+		   dev_specs->max_non_tso_bd_num);
+	seq_printf(s, "RSS ind tbl size: %u\n", dev_specs->rss_ind_tbl_size);
+	seq_printf(s, "RSS key size: %u\n", dev_specs->rss_key_size);
+	seq_printf(s, "RSS size: %u\n", kinfo->rss_size);
+	seq_printf(s, "Allocated RSS size: %u\n", kinfo->req_rss_size);
+	seq_printf(s, "Task queue pairs numbers: %u\n", kinfo->num_tqps);
+	seq_printf(s, "RX buffer length: %u\n", kinfo->rx_buf_len);
+	seq_printf(s, "Desc num per TX queue: %u\n", kinfo->num_tx_desc);
+	seq_printf(s, "Desc num per RX queue: %u\n", kinfo->num_rx_desc);
+	seq_printf(s, "Total number of enabled TCs: %u\n",
+		   kinfo->tc_info.num_tc);
+	seq_printf(s, "MAX INT QL: %u\n", dev_specs->int_ql_max);
+	seq_printf(s, "MAX INT GL: %u\n", dev_specs->max_int_gl);
+	seq_printf(s, "MAX TM RATE: %u\n", dev_specs->max_tm_rate);
+	seq_printf(s, "MAX QSET number: %u\n", dev_specs->max_qset_num);
+	seq_printf(s, "umv size: %u\n", dev_specs->umv_size);
+	seq_printf(s, "mc mac size: %u\n", dev_specs->mc_mac_size);
+	seq_printf(s, "MAC statistics number: %u\n", dev_specs->mac_stats_num);
+	seq_printf(s, "TX timeout threshold: %d seconds\n",
+		   dev->watchdog_timeo / HZ);
+	seq_printf(s, "mac tunnel number: %u\n", dev_specs->tnl_num);
+	seq_printf(s, "Hilink Version: %u\n", dev_specs->hilink_version);
 }
 
-static int hns3_dbg_dev_info(struct hnae3_handle *h, char *buf, int len)
+static int hns3_dbg_dev_info(struct seq_file *s, void *data)
 {
-	int pos = 0;
-
-	hns3_dbg_dev_caps(h, buf, len, &pos);
+	struct hnae3_handle *h = hnae3_seq_file_to_handle(s);
 
-	hns3_dbg_dev_specs(h, buf, len, &pos);
+	hns3_dbg_dev_caps(h, s);
+	hns3_dbg_dev_specs(h, s);
 
 	return 0;
 }
 
-static const struct hns3_dbg_item page_pool_info_items[] = {
-	{ "QUEUE_ID", 2 },
-	{ "ALLOCATE_CNT", 2 },
-	{ "FREE_CNT", 6 },
-	{ "POOL_SIZE(PAGE_NUM)", 2 },
-	{ "ORDER", 2 },
-	{ "NUMA_ID", 2 },
-	{ "MAX_LEN", 2 },
-};
-
 static void hns3_dump_page_pool_info(struct hns3_enet_ring *ring,
-				     char **result, u32 index)
+				     struct seq_file *s, u32 index)
 {
-	u32 j = 0;
-
-	sprintf(result[j++], "%u", index);
-	sprintf(result[j++], "%u",
-		READ_ONCE(ring->page_pool->pages_state_hold_cnt));
-	sprintf(result[j++], "%d",
-		atomic_read(&ring->page_pool->pages_state_release_cnt));
-	sprintf(result[j++], "%u", ring->page_pool->p.pool_size);
-	sprintf(result[j++], "%u", ring->page_pool->p.order);
-	sprintf(result[j++], "%d", ring->page_pool->p.nid);
-	sprintf(result[j++], "%uK", ring->page_pool->p.max_len / 1024);
+	seq_printf(s, "%-10u%-14u%-14d%-21u%-7u%-9d%uK\n",
+		   index,
+		   READ_ONCE(ring->page_pool->pages_state_hold_cnt),
+		   atomic_read(&ring->page_pool->pages_state_release_cnt),
+		   ring->page_pool->p.pool_size,
+		   ring->page_pool->p.order,
+		   ring->page_pool->p.nid,
+		   ring->page_pool->p.max_len / 1024);
 }
 
-static int
-hns3_dbg_page_pool_info(struct hnae3_handle *h, char *buf, int len)
+static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
 {
-	char data_str[ARRAY_SIZE(page_pool_info_items)][HNS3_DBG_DATA_STR_LEN];
-	char *result[ARRAY_SIZE(page_pool_info_items)];
+	struct hnae3_handle *h = hnae3_seq_file_to_handle(s);
 	struct hns3_nic_priv *priv = h->priv;
-	char content[HNS3_DBG_INFO_LEN];
 	struct hns3_enet_ring *ring;
-	int pos = 0;
 	u32 i;
 
 	if (!priv->ring) {
@@ -1013,23 +940,16 @@ hns3_dbg_page_pool_info(struct hnae3_handle *h, char *buf, int len)
 		return -EFAULT;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(page_pool_info_items); i++)
-		result[i] = &data_str[i][0];
+	seq_puts(s, "QUEUE_ID  ALLOCATE_CNT  FREE_CNT      ");
+	seq_puts(s, "POOL_SIZE(PAGE_NUM)  ORDER  NUMA_ID  MAX_LEN\n");
 
-	hns3_dbg_fill_content(content, sizeof(content), page_pool_info_items,
-			      NULL, ARRAY_SIZE(page_pool_info_items));
-	pos += scnprintf(buf + pos, len - pos, "%s", content);
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
 		if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
 		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
 			return -EPERM;
+
 		ring = &priv->ring[(u32)(i + h->kinfo.num_tqps)];
-		hns3_dump_page_pool_info(ring, result, i);
-		hns3_dbg_fill_content(content, sizeof(content),
-				      page_pool_info_items,
-				      (const char **)result,
-				      ARRAY_SIZE(page_pool_info_items));
-		pos += scnprintf(buf + pos, len - pos, "%s", content);
+		hns3_dump_page_pool_info(ring, s, i);
 	}
 
 	return 0;
@@ -1052,10 +972,6 @@ static int hns3_dbg_get_cmd_index(struct hns3_dbg_data *dbg_data, u32 *index)
 }
 
 static const struct hns3_dbg_func hns3_dbg_cmd_func[] = {
-	{
-		.cmd = HNAE3_DBG_CMD_DEV_INFO,
-		.dbg_dump = hns3_dbg_dev_info,
-	},
 	{
 		.cmd = HNAE3_DBG_CMD_TX_BD,
 		.dbg_dump_bd = hns3_dbg_tx_bd_info,
@@ -1064,14 +980,6 @@ static const struct hns3_dbg_func hns3_dbg_cmd_func[] = {
 		.cmd = HNAE3_DBG_CMD_RX_BD,
 		.dbg_dump_bd = hns3_dbg_rx_bd_info,
 	},
-	{
-		.cmd = HNAE3_DBG_CMD_PAGE_POOL_INFO,
-		.dbg_dump = hns3_dbg_page_pool_info,
-	},
-	{
-		.cmd = HNAE3_DBG_CMD_COAL_INFO,
-		.dbg_dump = hns3_dbg_coal_info,
-	},
 };
 
 static int hns3_dbg_read_cmd(struct hns3_dbg_data *dbg_data,
@@ -1216,6 +1124,15 @@ static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32 cmd)
 	case HNAE3_DBG_CMD_QUEUE_MAP:
 		func = hns3_dbg_queue_map;
 		break;
+	case HNAE3_DBG_CMD_PAGE_POOL_INFO:
+		func = hns3_dbg_page_pool_info;
+		break;
+	case HNAE3_DBG_CMD_COAL_INFO:
+		func = hns3_dbg_coal_info;
+		break;
+	case HNAE3_DBG_CMD_DEV_INFO:
+		func = hns3_dbg_dev_info;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.33.0


