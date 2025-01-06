Return-Path: <netdev+bounces-155496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CA2A0284D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F557A2026
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DD51DE894;
	Mon,  6 Jan 2025 14:44:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E48B1DDC1F;
	Mon,  6 Jan 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174656; cv=none; b=ME3BPuMpzG7C39Si3jNCGNlTFjKckk+qz9TdG+miT7IcHXRr8+A+w9B+5Ihj4IbDoiDwaD3YvZKE6ikNwgAD3P3mlBb7rDwbMT7Sw/cRNEIiu2iRMgCymg/ZMs0uaNkz/5K6Ufwp7NhzlH/61ZeIodGRbY16+miT0bsi7GsGChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174656; c=relaxed/simple;
	bh=Oh1JCmkW1ly8RM+KOuGlSC7mCiNICG39hvYkyTwd0+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nr0x7Ryv/jyPLSrFSPh1mEDLVF+qvT9Gad+iJ40CAz/XRIJ9ti22jWPg4Y+PLfgvOyACqqS8fOqqRunDWFvozRMu/MDGpgAvLBeH1jq+NfBswLaffaw5HKMOuI3dY2p4WoUwvMU9PSHOeptkN9bXfbqttKcB5EB98v9g0hR5cRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YRcKr1DWSzxX5g;
	Mon,  6 Jan 2025 22:40:32 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D8E96140383;
	Mon,  6 Jan 2025 22:44:11 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jan 2025 22:44:11 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net 3/7] net: hns3: Resolved the issue that the debugfs query result is inconsistent.
Date: Mon, 6 Jan 2025 22:36:38 +0800
Message-ID: <20250106143642.539698-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250106143642.539698-1-shaojijie@huawei.com>
References: <20250106143642.539698-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Hao Lan <lanhao@huawei.com>

This patch modifies the implementation of debugfs:

When the user process stops unexpectedly, not all data of the file system
is read. In this case, the save_buf pointer is not released. When the
user process is called next time, save_buf is used to copy the cached
data to the user space. As a result, the queried data is stale.

To solve this problem, this patch implements .open() and .release() handler
for debugfs file_operations. moving allocation buffer and execution
of the cmd to the .open() handler and freeing in to the .release() handler.
Allocate separate buffer for each reader and associate the buffer
with the file pointer.
When different user read processes no longer share the buffer,
the stale data problem is fixed.

Fixes: 5e69ea7ee2a6 ("net: hns3: refactor the debugfs process")
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Guangwei Zhang <zhangwangwei6@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
ChangeLog:
v1 -> v2:
  - Fix a data inconsistency issue caused by simultaneous access of multiple readers,
    suggested by Jakub.
  v1: https://lore.kernel.org/all/20241107133023.3813095-1-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  3 -
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 96 ++++++-------------
 2 files changed, 31 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 710a8f9f2248..12ba380eb701 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -916,9 +916,6 @@ struct hnae3_handle {
 
 	u8 netdev_flags;
 	struct dentry *hnae3_dbgfs;
-	/* protects concurrent contention between debugfs commands */
-	struct mutex dbgfs_lock;
-	char **dbgfs_buf;
 
 	/* Network interface message level enabled bits */
 	u32 msg_enable;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 807eb3bbb11c..9bbece25552b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -1260,69 +1260,55 @@ static int hns3_dbg_read_cmd(struct hns3_dbg_data *dbg_data,
 static ssize_t hns3_dbg_read(struct file *filp, char __user *buffer,
 			     size_t count, loff_t *ppos)
 {
-	struct hns3_dbg_data *dbg_data = filp->private_data;
+	char *buf = filp->private_data;
+
+	return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
+}
+
+static int hns3_dbg_open(struct inode *inode, struct file *filp)
+{
+	struct hns3_dbg_data *dbg_data = inode->i_private;
 	struct hnae3_handle *handle = dbg_data->handle;
 	struct hns3_nic_priv *priv = handle->priv;
-	ssize_t size = 0;
-	char **save_buf;
-	char *read_buf;
 	u32 index;
+	char *buf;
 	int ret;
 
+	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
+	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state))
+		return -EBUSY;
+
 	ret = hns3_dbg_get_cmd_index(dbg_data, &index);
 	if (ret)
 		return ret;
 
-	mutex_lock(&handle->dbgfs_lock);
-	save_buf = &handle->dbgfs_buf[index];
-
-	if (!test_bit(HNS3_NIC_STATE_INITED, &priv->state) ||
-	    test_bit(HNS3_NIC_STATE_RESETTING, &priv->state)) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	if (*save_buf) {
-		read_buf = *save_buf;
-	} else {
-		read_buf = kvzalloc(hns3_dbg_cmd[index].buf_len, GFP_KERNEL);
-		if (!read_buf) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		/* save the buffer addr until the last read operation */
-		*save_buf = read_buf;
-
-		/* get data ready for the first time to read */
-		ret = hns3_dbg_read_cmd(dbg_data, hns3_dbg_cmd[index].cmd,
-					read_buf, hns3_dbg_cmd[index].buf_len);
-		if (ret)
-			goto out;
-	}
+	buf = kvzalloc(hns3_dbg_cmd[index].buf_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
 
-	size = simple_read_from_buffer(buffer, count, ppos, read_buf,
-				       strlen(read_buf));
-	if (size > 0) {
-		mutex_unlock(&handle->dbgfs_lock);
-		return size;
+	ret = hns3_dbg_read_cmd(dbg_data, hns3_dbg_cmd[index].cmd,
+				buf, hns3_dbg_cmd[index].buf_len);
+	if (ret) {
+		kvfree(buf);
+		return ret;
 	}
 
-out:
-	/* free the buffer for the last read operation */
-	if (*save_buf) {
-		kvfree(*save_buf);
-		*save_buf = NULL;
-	}
+	filp->private_data = buf;
+	return 0;
+}
 
-	mutex_unlock(&handle->dbgfs_lock);
-	return ret;
+static int hns3_dbg_release(struct inode *inode, struct file *filp)
+{
+	kvfree(filp->private_data);
+	filp->private_data = NULL;
+	return 0;
 }
 
 static const struct file_operations hns3_dbg_fops = {
 	.owner = THIS_MODULE,
-	.open  = simple_open,
+	.open  = hns3_dbg_open,
 	.read  = hns3_dbg_read,
+	.release = hns3_dbg_release,
 };
 
 static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd)
@@ -1379,13 +1365,6 @@ int hns3_dbg_init(struct hnae3_handle *handle)
 	int ret;
 	u32 i;
 
-	handle->dbgfs_buf = devm_kcalloc(&handle->pdev->dev,
-					 ARRAY_SIZE(hns3_dbg_cmd),
-					 sizeof(*handle->dbgfs_buf),
-					 GFP_KERNEL);
-	if (!handle->dbgfs_buf)
-		return -ENOMEM;
-
 	hns3_dbg_dentry[HNS3_DBG_DENTRY_COMMON].dentry =
 				debugfs_create_dir(name, hns3_dbgfs_root);
 	handle->hnae3_dbgfs = hns3_dbg_dentry[HNS3_DBG_DENTRY_COMMON].dentry;
@@ -1395,8 +1374,6 @@ int hns3_dbg_init(struct hnae3_handle *handle)
 			debugfs_create_dir(hns3_dbg_dentry[i].name,
 					   handle->hnae3_dbgfs);
 
-	mutex_init(&handle->dbgfs_lock);
-
 	for (i = 0; i < ARRAY_SIZE(hns3_dbg_cmd); i++) {
 		if ((hns3_dbg_cmd[i].cmd == HNAE3_DBG_CMD_TM_NODES &&
 		     ae_dev->dev_version <= HNAE3_DEVICE_VERSION_V2) ||
@@ -1425,24 +1402,13 @@ int hns3_dbg_init(struct hnae3_handle *handle)
 out:
 	debugfs_remove_recursive(handle->hnae3_dbgfs);
 	handle->hnae3_dbgfs = NULL;
-	mutex_destroy(&handle->dbgfs_lock);
 	return ret;
 }
 
 void hns3_dbg_uninit(struct hnae3_handle *handle)
 {
-	u32 i;
-
 	debugfs_remove_recursive(handle->hnae3_dbgfs);
 	handle->hnae3_dbgfs = NULL;
-
-	for (i = 0; i < ARRAY_SIZE(hns3_dbg_cmd); i++)
-		if (handle->dbgfs_buf[i]) {
-			kvfree(handle->dbgfs_buf[i]);
-			handle->dbgfs_buf[i] = NULL;
-		}
-
-	mutex_destroy(&handle->dbgfs_lock);
 }
 
 void hns3_dbg_register_debugfs(const char *debugfs_dir_name)
-- 
2.33.0


