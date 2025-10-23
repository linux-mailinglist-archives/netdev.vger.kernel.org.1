Return-Path: <netdev+bounces-232115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73077C01487
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 075884EEDBD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A90314D1E;
	Thu, 23 Oct 2025 13:14:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EAC314B76;
	Thu, 23 Oct 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225239; cv=none; b=qQyWnL++Ze0egPAZuahB9fDoBQckr7o/Q4ACaqbAu+1L8/5L1KVryh/n6jl28mxpIYNvyKwbZ9CGL/0ysvT0Je1dey6ZUyiqefRVDa4cwihWvTHeo0V8bpneubrAK1m/6xlRAOBQ17XzdcntDcuk0NvVhx+K35F/tJs9Dk151kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225239; c=relaxed/simple;
	bh=3T5OHLUonyzHW+Uz3Gr6kqhNfGV1CiA2tJBJkclldYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJp3YXvcPGu+FtWHI5eE8WMGbZ35vVYLHidtHOz1ng1ARiRYenffOy5sR9Fl4cbiO1m37/HDCIcuQO/Y6tkLEqSFSlWoi8kQtwJ+PP7t/6kiaXs8/pXR+T1ZXNRtPJzEvy+gJnc29Sb+MT8KS6+wdlKnSCfuJbjxwPV6vaZqEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4csmZR5C9Kz2Cgrq;
	Thu, 23 Oct 2025 21:09:03 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 852AC1401E9;
	Thu, 23 Oct 2025 21:13:55 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 23 Oct 2025 21:13:54 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 2/2] net: hns3: fix null pointer in debugfs issue
Date: Thu, 23 Oct 2025 21:13:38 +0800
Message-ID: <20251023131338.2642520-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251023131338.2642520-1-shaojijie@huawei.com>
References: <20251023131338.2642520-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Currently, when debugfs and reset are executed concurrently,
some resources are released during the reset process,
which may cause debugfs to read null pointers or other anomalies.

Therefore, in this patch, interception protection has been added
to debugfs operations that are sensitive to reset.

Fixes: eced3d1c41db ("net: hns3: use seq_file for files in queue/ in debugfs")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 67 ++++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |  6 ++
 2 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 4cce4f4ba6b0..aa0f8a6cd9d6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -383,6 +383,15 @@ static const char * const dim_state_str[] = { "START", "IN_PROG", "APPLY" };
 static const char * const
 dim_tune_stat_str[] = { "ON_TOP", "TIRED", "RIGHT", "LEFT" };
 
+static bool hns3_dbg_is_device_busy(struct hns3_nic_priv *priv)
+{
+	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
+	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+		return true;
+
+	return false;
+}
+
 static void hns3_get_coal_info(struct hns3_enet_tqp_vector *tqp_vector,
 			       struct seq_file *s, int i, bool is_tx)
 {
@@ -428,13 +437,16 @@ static void hns3_get_coal_info(struct hns3_enet_tqp_vector *tqp_vector,
 	}
 }
 
-static void hns3_dump_coal_info(struct seq_file *s, bool is_tx)
+static int hns3_dump_coal_info(struct seq_file *s, bool is_tx)
 {
 	struct hnae3_handle *h = hnae3_seq_file_to_handle(s);
 	struct hns3_enet_tqp_vector *tqp_vector;
 	struct hns3_nic_priv *priv = h->priv;
 	unsigned int i;
 
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
+
 	seq_printf(s, "%s interrupt coalesce info:\n", is_tx ? "tx" : "rx");
 
 	seq_puts(s, "VEC_ID  ALGO_STATE  PROFILE_ID  CQE_MODE  TUNE_STATE  ");
@@ -442,18 +454,26 @@ static void hns3_dump_coal_info(struct seq_file *s, bool is_tx)
 	seq_puts(s, "HW_GL  HW_QL\n");
 
 	for (i = 0; i < priv->vector_num; i++) {
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
+
 		tqp_vector = &priv->tqp_vector[i];
 		hns3_get_coal_info(tqp_vector, s, i, is_tx);
 	}
+
+	return 0;
 }
 
 static int hns3_dbg_coal_info(struct seq_file *s, void *data)
 {
-	hns3_dump_coal_info(s, true);
-	seq_puts(s, "\n");
-	hns3_dump_coal_info(s, false);
+	int ret;
 
-	return 0;
+	ret = hns3_dump_coal_info(s, true);
+	if (ret)
+		return ret;
+
+	seq_puts(s, "\n");
+	return hns3_dump_coal_info(s, false);
 }
 
 static void hns3_dump_rx_queue_info(struct hns3_enet_ring *ring,
@@ -498,6 +518,9 @@ static int hns3_dbg_rx_queue_info(struct seq_file *s, void *data)
 	struct hns3_enet_ring *ring;
 	u32 i;
 
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
+
 	if (!priv->ring) {
 		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
 		return -EFAULT;
@@ -511,8 +534,7 @@ static int hns3_dbg_rx_queue_info(struct seq_file *s, void *data)
 		 * to prevent reference to invalid memory. And need to ensure
 		 * that the following code is executed within 100ms.
 		 */
-		if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+		if (hns3_dbg_is_device_busy(priv))
 			return -EPERM;
 
 		ring = &priv->ring[(u32)(i + h->kinfo.num_tqps)];
@@ -563,6 +585,9 @@ static int hns3_dbg_tx_queue_info(struct seq_file *s, void *data)
 	struct hns3_enet_ring *ring;
 	u32 i;
 
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
+
 	if (!priv->ring) {
 		dev_err(&h->pdev->dev, "priv->ring is NULL\n");
 		return -EFAULT;
@@ -576,8 +601,7 @@ static int hns3_dbg_tx_queue_info(struct seq_file *s, void *data)
 		 * to prevent reference to invalid memory. And need to ensure
 		 * that the following code is executed within 100ms.
 		 */
-		if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+		if (hns3_dbg_is_device_busy(priv))
 			return -EPERM;
 
 		ring = &priv->ring[i];
@@ -596,6 +620,9 @@ static int hns3_dbg_queue_map(struct seq_file *s, void *data)
 	if (!h->ae_algo->ops->get_global_queue_id)
 		return -EOPNOTSUPP;
 
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
+
 	seq_puts(s, "local_queue_id  global_queue_id  vector_id\n");
 
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
@@ -643,6 +670,9 @@ static int hns3_dbg_rx_bd_info(struct seq_file *s, void *private)
 	struct hns3_desc *desc;
 	unsigned int i;
 
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
+
 	if (data->qid >= h->kinfo.num_tqps) {
 		dev_err(&h->pdev->dev, "queue%u is not in use\n", data->qid);
 		return -EINVAL;
@@ -655,8 +685,10 @@ static int hns3_dbg_rx_bd_info(struct seq_file *s, void *private)
 
 	ring = &priv->ring[data->qid + data->handle->kinfo.num_tqps];
 	for (i = 0; i < ring->desc_num; i++) {
-		desc = &ring->desc[i];
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
 
+		desc = &ring->desc[i];
 		hns3_dump_rx_bd_info(priv, desc, s, i);
 	}
 
@@ -688,6 +720,9 @@ static int hns3_dbg_tx_bd_info(struct seq_file *s, void *private)
 	struct hns3_desc *desc;
 	unsigned int i;
 
+	if (hns3_dbg_is_device_busy(priv))
+		return -EBUSY;
+
 	if (data->qid >= h->kinfo.num_tqps) {
 		dev_err(&h->pdev->dev, "queue%u is not in use\n", data->qid);
 		return -EINVAL;
@@ -700,8 +735,10 @@ static int hns3_dbg_tx_bd_info(struct seq_file *s, void *private)
 
 	ring = &priv->ring[data->qid];
 	for (i = 0; i < ring->desc_num; i++) {
-		desc = &ring->desc[i];
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
 
+		desc = &ring->desc[i];
 		hns3_dump_tx_bd_info(desc, s, i);
 	}
 
@@ -804,9 +841,8 @@ static int hns3_dbg_page_pool_info(struct seq_file *s, void *data)
 	seq_puts(s, "POOL_SIZE(PAGE_NUM)  ORDER  NUMA_ID  MAX_LEN\n");
 
 	for (i = 0; i < h->kinfo.num_tqps; i++) {
-		if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-		    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
-			return -EPERM;
+		if (hns3_dbg_is_device_busy(priv))
+			return -EBUSY;
 
 		ring = &priv->ring[(u32)(i + h->kinfo.num_tqps)];
 		hns3_dump_page_pool_info(ring, s, i);
@@ -821,8 +857,7 @@ static int hns3_dbg_bd_info_show(struct seq_file *s, void *private)
 	struct hnae3_handle *h = data->handle;
 	struct hns3_nic_priv *priv = h->priv;
 
-	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+	if (hns3_dbg_is_device_busy(priv))
 		return -EBUSY;
 
 	if (data->cmd == HNAE3_DBG_CMD_TX_BD)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index b76d25074e99..b658077b9d50 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -2470,6 +2470,9 @@ static int hclge_dbg_dump_umv_info(struct seq_file *s, void *data)
 	struct hclge_vport *vport;
 	u8 i;
 
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		return -EBUSY;
+
 	seq_printf(s, "num_alloc_vport   : %u\n", hdev->num_alloc_vport);
 	seq_printf(s, "max_umv_size     : %u\n", hdev->max_umv_size);
 	seq_printf(s, "wanted_umv_size  : %u\n", hdev->wanted_umv_size);
@@ -2680,6 +2683,9 @@ static int hclge_dbg_dump_vlan_offload_config(struct hclge_dev *hdev,
 	int ret;
 	u8 i;
 
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
+		return -EBUSY;
+
 	seq_puts(s, "FUNC_ID  PVID  ACCEPT_TAG1  ACCEPT_TAG2 ACCEPT_UNTAG1  ");
 	seq_puts(s, "ACCEPT_UNTAG2  INSERT_TAG1  INSERT_TAG2  SHIFT_TAG  ");
 	seq_puts(s, "STRIP_TAG1  STRIP_TAG2  DROP_TAG1  DROP_TAG2  ");
-- 
2.33.0


