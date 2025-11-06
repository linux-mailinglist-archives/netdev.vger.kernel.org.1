Return-Path: <netdev+bounces-236274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F45C3A838
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FE924FE183
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783BB30E0EB;
	Thu,  6 Nov 2025 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OaozC1C7"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35592737FC;
	Thu,  6 Nov 2025 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427792; cv=none; b=X+k7d/Au9kU92KEXnk1G18GmoC8IMi2s4mZo/AiyQAha6w7Qft5Ft9xc+YBYAnoIvIPxM1lyIpiYn5qxWTHe9CwbPiRbJiH5jHQMh/NhzJPmLchJqWnG+Jn29r0o5Xu4dTbFmN1zhw7MdpWHa70AXVIJS9HeIM7pW86E4NPx9fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427792; c=relaxed/simple;
	bh=Yo11R5PA0h7sBvF4QbL/h8NjO/hnP5mUB/L+k2OXaTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVuJmbSo2ec1HR92+fUo6dBwuxHiQMFpBOq0ZMjx1sR8K/37AmDC5W8upDa9kRv9Q609i9k6M43aB0+Y8qJsvTUmA2ChM6zo1btQtGU9bHNU+u3EP+80ZTWOka2DM/i0bYI3ioLHx2JQhU88NyXyiLrjTbBNygk1Ry9yOud7iuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OaozC1C7; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ooEXsThnFqxlR+hJcUyugmXBk7XYfSeccxyu9rqq460=;
	b=OaozC1C7YsX2Q72AE0H0mvoNTYJRBJqCSHclkF4rUBYXzl9ldPUBhAOxPE8Lh6KASvr8m/oMy
	fGt67UBopyPLtOI4BdT9Eouhffk7L9tUK9QiFtMYfrMOHNvFcdfOl1IgGfK109Z/kaWvRC63epf
	hWlC2XI3GB8zFdtYMn3JkRU=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4d2KNT4mPfz1T4jT;
	Thu,  6 Nov 2025 19:15:05 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id AA6E4140276;
	Thu,  6 Nov 2025 19:16:20 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 19:16:19 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <Markus.Elfring@web.de>, <pavan.chebbi@broadcom.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
	<luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>
Subject: [PATCH net-next v05 1/5] hinic3: Add PF framework
Date: Thu, 6 Nov 2025 19:15:51 +0800
Message-ID: <ef0ccf58f3c32c16a21ac83e8159a529bc87c2d8.1762414088.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1762414088.git.zhuyikai1@h-partners.com>
References: <cover.1762414088.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Add support for PF framework based on the VF code.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |  6 ++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 61 +++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  4 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 22 +++++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c | 44 ++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  2 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 90 ++++++++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  | 23 +++++
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   | 53 ++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 30 +++++--
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  | 42 +++++++--
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  1 +
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 61 ++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  3 +
 14 files changed, 419 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
index e7417e8efa99..f7083a6e7df9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_csr.h
@@ -5,6 +5,7 @@
 #define _HINIC3_CSR_H_
 
 #define HINIC3_CFG_REGS_FLAG                  0x40000000
+#define HINIC3_MGMT_REGS_FLAG                 0xC0000000
 #define HINIC3_REGS_FLAG_MASK                 0x3FFFFFFF
 
 #define HINIC3_VF_CFG_REG_OFFSET              0x2000
@@ -24,6 +25,11 @@
 #define HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF  (HINIC3_CFG_REGS_FLAG + 0x0108)
 #define HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF  (HINIC3_CFG_REGS_FLAG + 0x010C)
 
+#define HINIC3_HOST_CSR_BASE_ADDR             (HINIC3_MGMT_REGS_FLAG + 0x6000)
+#define HINIC3_PPF_ELECTION_OFFSET            0x0
+#define HINIC3_CSR_PPF_ELECTION_ADDR  \
+	(HINIC3_HOST_CSR_BASE_ADDR + HINIC3_PPF_ELECTION_OFFSET)
+
 #define HINIC3_CSR_DMA_ATTR_TBL_ADDR          (HINIC3_CFG_REGS_FLAG + 0x380)
 #define HINIC3_CSR_DMA_ATTR_INDIR_IDX_ADDR    (HINIC3_CFG_REGS_FLAG + 0x390)
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index 89638813df40..09dae2ef610c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -314,6 +314,8 @@ int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev)
 			ret = -EFAULT;
 	}
 
+	hinic3_set_pf_status(hwif, HINIC3_PF_STATUS_FLR_START_FLAG);
+
 	clr_res.func_id = hwif->attr.func_global_idx;
 	msg_params.buf_in = &clr_res;
 	msg_params.in_size = sizeof(clr_res);
@@ -337,6 +339,65 @@ int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev)
 	return ret;
 }
 
+int hinic3_set_bdf_ctxt(struct hinic3_hwdev *hwdev,
+			struct comm_cmd_bdf_info *bdf_info)
+{
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	mgmt_msg_params_init_default(&msg_params, bdf_info, sizeof(*bdf_info));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SEND_BDF_INFO, &msg_params);
+	if (err || bdf_info->head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set bdf info to fw, err: %d, status: 0x%x\n",
+			err, bdf_info->head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int hinic3_sync_time(struct hinic3_hwdev *hwdev, u64 time)
+{
+	struct comm_cmd_sync_time time_info = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	time_info.mstime = time;
+
+	mgmt_msg_params_init_default(&msg_params, &time_info,
+				     sizeof(time_info));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SYNC_TIME, &msg_params);
+	if (err || time_info.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to sync time to mgmt, err: %d, status: 0x%x\n",
+			err, time_info.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+void hinic3_sync_time_to_fw(struct hinic3_hwdev *hwdev)
+{
+	struct timespec64 ts = {};
+	u64 time;
+	int err;
+
+	ktime_get_real_ts64(&ts);
+	time = (u64)(ts.tv_sec * MSEC_PER_SEC + ts.tv_nsec / NSEC_PER_MSEC);
+
+	err = hinic3_sync_time(hwdev, time);
+	if (err)
+		dev_err(hwdev->dev,
+			"Synchronize UTC time to firmware failed, errno:%d.\n",
+			err);
+}
+
 static int get_hw_rx_buf_size_idx(int rx_buf_sz, u16 *buf_sz_idx)
 {
 	/* Supported RX buffer sizes in bytes. Configured by array index. */
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
index 304f5691f0c2..c9c6b4fbcb12 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -40,6 +40,10 @@ int hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, u16 func_idx,
 			    u32 page_size);
 int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth);
 int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev);
+int hinic3_set_bdf_ctxt(struct hinic3_hwdev *hwdev,
+			struct comm_cmd_bdf_info *bdf_info);
+void hinic3_sync_time_to_fw(struct hinic3_hwdev *hwdev);
+
 int hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, u32 rq_depth, u32 sq_depth,
 			 int rx_buf_sz);
 int hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index 623cf2d14cbc..a0422ec0500f 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -110,6 +110,10 @@ enum comm_cmd {
 	COMM_CMD_CFG_MSIX_CTRL_REG       = 23,
 	COMM_CMD_SET_CEQ_CTRL_REG        = 24,
 	COMM_CMD_SET_DMA_ATTR            = 25,
+
+	/* Commands for obtaining information */
+	COMM_CMD_SYNC_TIME               = 62,
+	COMM_CMD_SEND_BDF_INFO           = 64,
 };
 
 struct comm_cmd_cfg_msix_ctrl_reg {
@@ -251,6 +255,24 @@ struct comm_cmd_clear_resource {
 	u16                  rsvd1[3];
 };
 
+struct comm_cmd_sync_time {
+	struct mgmt_msg_head head;
+
+	u64                  mstime;
+	u64                  rsvd1;
+};
+
+struct comm_cmd_bdf_info {
+	struct mgmt_msg_head head;
+
+	u16                  function_idx;
+	u8                   rsvd1[2];
+	u8                   bus;
+	u8                   device;
+	u8                   function;
+	u8                   rsvd2[5];
+};
+
 /* Services supported by HW. HW uses these values when delivering events.
  * HW supports multiple services that are not yet supported by driver
  * (e.g. RoCE).
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 95a213133be9..2b1f1036620e 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -13,6 +13,8 @@
 #define HINIC3_PCIE_SNOOP        0
 #define HINIC3_PCIE_TPH_DISABLE  0
 
+#define HINIC3_SYNFW_TIME_PERIOD  (60 * 60 * 1000)
+
 #define HINIC3_DMA_ATTR_INDIR_IDX_MASK          GENMASK(9, 0)
 #define HINIC3_DMA_ATTR_INDIR_IDX_SET(val, member)  \
 	FIELD_PREP(HINIC3_DMA_ATTR_INDIR_##member##_MASK, val)
@@ -38,6 +40,7 @@
 #define HINIC3_WQ_MAX_REQ       10
 
 enum hinic3_hwdev_init_state {
+	HINIC3_HWDEV_MGMT_INITED = 1,
 	HINIC3_HWDEV_MBOX_INITED = 2,
 	HINIC3_HWDEV_CMDQ_INITED = 3,
 };
@@ -419,6 +422,8 @@ static int hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
 		goto err_clear_func_svc_used_state;
 	}
 
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_ACTIVE_FLAG);
+
 	return 0;
 
 err_clear_func_svc_used_state:
@@ -431,11 +436,43 @@ static int hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
 
 static void hinic3_uninit_comm_ch(struct hinic3_hwdev *hwdev)
 {
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_INIT);
 	hinic3_free_cmdqs_channel(hwdev);
 	hinic3_set_func_svc_used_state(hwdev, COMM_FUNC_SVC_T_COMM, 0);
 	free_base_mgmt_channel(hwdev);
 }
 
+static void hinic3_auto_sync_time_work(struct work_struct *work)
+{
+	struct delayed_work *delay = to_delayed_work(work);
+	struct hinic3_hwdev *hwdev;
+
+	hwdev = container_of(delay, struct hinic3_hwdev, sync_time_task);
+
+	hinic3_sync_time_to_fw(hwdev);
+
+	queue_delayed_work(hwdev->workq, &hwdev->sync_time_task,
+			   msecs_to_jiffies(HINIC3_SYNFW_TIME_PERIOD));
+}
+
+static void hinic3_init_ppf_work(struct hinic3_hwdev *hwdev)
+{
+	if (hinic3_ppf_idx(hwdev) != hinic3_global_func_id(hwdev))
+		return;
+
+	INIT_DELAYED_WORK(&hwdev->sync_time_task, hinic3_auto_sync_time_work);
+	queue_delayed_work(hwdev->workq, &hwdev->sync_time_task,
+			   msecs_to_jiffies(HINIC3_SYNFW_TIME_PERIOD));
+}
+
+static void hinic3_free_ppf_work(struct hinic3_hwdev *hwdev)
+{
+	if (hinic3_ppf_idx(hwdev) != hinic3_global_func_id(hwdev))
+		return;
+
+	disable_delayed_work_sync(&hwdev->sync_time_task);
+}
+
 static DEFINE_IDA(hinic3_adev_ida);
 
 static int hinic3_adev_idx_alloc(void)
@@ -498,15 +535,19 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 		goto err_uninit_comm_ch;
 	}
 
+	hinic3_init_ppf_work(hwdev);
+
 	err = hinic3_set_comm_features(hwdev, hwdev->features,
 				       COMM_MAX_FEATURE_QWORD);
 	if (err) {
 		dev_err(hwdev->dev, "Failed to set comm features\n");
-		goto err_uninit_comm_ch;
+		goto err_free_ppf_work;
 	}
 
 	return 0;
 
+err_free_ppf_work:
+	hinic3_free_ppf_work(hwdev);
 err_uninit_comm_ch:
 	hinic3_uninit_comm_ch(hwdev);
 err_free_cfg_mgmt:
@@ -528,6 +569,7 @@ void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 	u64 drv_features[COMM_MAX_FEATURE_QWORD] = {};
 
 	hinic3_set_comm_features(hwdev, drv_features, COMM_MAX_FEATURE_QWORD);
+	hinic3_free_ppf_work(hwdev);
 	hinic3_func_rx_tx_flush(hwdev);
 	hinic3_uninit_comm_ch(hwdev);
 	hinic3_free_cfg_mgmt(hwdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
index 62e2745e9316..78cface6ddd7 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
@@ -28,6 +28,7 @@ struct hinic3_pcidev {
 
 	void __iomem         *cfg_reg_base;
 	void __iomem         *intr_reg_base;
+	void __iomem         *mgmt_reg_base;
 	void __iomem         *db_base;
 	u64                  db_dwqe_len;
 	u64                  db_base_phy;
@@ -48,6 +49,7 @@ struct hinic3_hwdev {
 	struct hinic3_ceqs          *ceqs;
 	struct hinic3_mbox          *mbox;
 	struct hinic3_cmdqs         *cmdqs;
+	struct delayed_work         sync_time_task;
 	struct workqueue_struct     *workq;
 	/* protect channel init and uninit */
 	spinlock_t                  channel_lock;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index f76f140fb6f7..801f48e241f8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -31,6 +31,7 @@
 #define HINIC3_AF0_GET(val, member) \
 	FIELD_GET(HINIC3_AF0_##member##_MASK, val)
 
+#define HINIC3_AF1_PPF_IDX_MASK           GENMASK(5, 0)
 #define HINIC3_AF1_AEQS_PER_FUNC_MASK     GENMASK(9, 8)
 #define HINIC3_AF1_MGMT_INIT_STATUS_MASK  BIT(30)
 #define HINIC3_AF1_GET(val, member) \
@@ -41,6 +42,10 @@
 #define HINIC3_AF2_GET(val, member) \
 	FIELD_GET(HINIC3_AF2_##member##_MASK, val)
 
+#define HINIC3_AF3_GLOBAL_VF_ID_OF_PF_MASK  GENMASK(27, 16)
+#define HINIC3_AF3_GET(val, member) \
+	FIELD_GET(HINIC3_AF3_##member##_MASK, val)
+
 #define HINIC3_AF4_DOORBELL_CTRL_MASK  BIT(0)
 #define HINIC3_AF4_GET(val, member) \
 	FIELD_GET(HINIC3_AF4_##member##_MASK, val)
@@ -54,9 +59,17 @@
 #define HINIC3_AF6_PF_STATUS_MASK     GENMASK(15, 0)
 #define HINIC3_AF6_FUNC_MAX_SQ_MASK   GENMASK(31, 23)
 #define HINIC3_AF6_MSIX_FLEX_EN_MASK  BIT(22)
+#define HINIC3_AF6_SET(val, member) \
+	FIELD_PREP(HINIC3_AF6_##member##_MASK, val)
 #define HINIC3_AF6_GET(val, member) \
 	FIELD_GET(HINIC3_AF6_##member##_MASK, val)
 
+#define HINIC3_PPF_ELECTION_IDX_MASK  GENMASK(5, 0)
+#define HINIC3_PPF_ELECTION_SET(val, member) \
+	FIELD_PREP(HINIC3_PPF_ELECTION_##member##_MASK, val)
+#define HINIC3_PPF_ELECTION_GET(val, member) \
+	FIELD_GET(HINIC3_PPF_ELECTION_##member##_MASK, val)
+
 #define HINIC3_GET_REG_ADDR(reg)  ((reg) & (HINIC3_REGS_FLAG_MASK))
 
 static void __iomem *hinic3_reg_addr(struct hinic3_hwif *hwif, u32 reg)
@@ -105,12 +118,15 @@ static void set_hwif_attr(struct hinic3_func_attr *attr, u32 attr0, u32 attr1,
 	attr->pci_intf_idx = HINIC3_AF0_GET(attr0, PCI_INTF_IDX);
 	attr->func_type = HINIC3_AF0_GET(attr0, FUNC_TYPE);
 
+	attr->ppf_idx = HINIC3_AF1_GET(attr1, PPF_IDX);
 	attr->num_aeqs = BIT(HINIC3_AF1_GET(attr1, AEQS_PER_FUNC));
 	attr->num_ceqs = HINIC3_AF2_GET(attr2, CEQS_PER_FUNC);
 	attr->num_irqs = HINIC3_AF2_GET(attr2, IRQS_PER_FUNC);
 	if (attr->num_irqs > HINIC3_MAX_MSIX_ENTRY)
 		attr->num_irqs = HINIC3_MAX_MSIX_ENTRY;
 
+	attr->global_vf_id_of_pf = HINIC3_AF3_GET(attr3, GLOBAL_VF_ID_OF_PF);
+
 	attr->num_sq = HINIC3_AF6_GET(attr6, FUNC_MAX_SQ);
 	attr->msix_flex_en = HINIC3_AF6_GET(attr6, MSIX_FLEX_EN);
 }
@@ -187,6 +203,28 @@ void hinic3_toggle_doorbell(struct hinic3_hwif *hwif,
 	hinic3_hwif_write_reg(hwif, addr, attr4);
 }
 
+static void hinic3_set_ppf(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	struct hinic3_func_attr *attr;
+	u32 addr, val;
+
+	if (HINIC3_IS_VF(hwdev))
+		return;
+
+	/* Read Modify Write */
+	attr = &hwif->attr;
+	addr = HINIC3_CSR_PPF_ELECTION_ADDR;
+	val = hinic3_hwif_read_reg(hwif, addr);
+	val &= ~HINIC3_PPF_ELECTION_IDX_MASK;
+	val |= HINIC3_PPF_ELECTION_SET(attr->func_global_idx, IDX);
+	hinic3_hwif_write_reg(hwif, addr, val);
+
+	/* Check PPF index */
+	val = hinic3_hwif_read_reg(hwif, addr);
+	attr->ppf_idx = HINIC3_PPF_ELECTION_GET(val, IDX);
+}
+
 static int db_area_idx_init(struct hinic3_hwif *hwif, u64 db_base_phy,
 			    u8 __iomem *db_base, u64 db_dwqe_len)
 {
@@ -366,6 +404,27 @@ static int wait_until_doorbell_and_outbound_enabled(struct hinic3_hwif *hwif)
 				       USEC_PER_MSEC);
 }
 
+void hinic3_set_pf_status(struct hinic3_hwif *hwif,
+			  enum hinic3_pf_status status)
+{
+	u32 attr6 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);
+
+	attr6 &= ~HINIC3_AF6_PF_STATUS_MASK;
+	attr6 |= HINIC3_AF6_SET(status, PF_STATUS);
+
+	if (hwif->attr.func_type == HINIC3_FUNC_TYPE_VF)
+		return;
+
+	hinic3_hwif_write_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR, attr6);
+}
+
+enum hinic3_pf_status hinic3_get_pf_status(struct hinic3_hwif *hwif)
+{
+	u32 attr6 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);
+
+	return HINIC3_AF6_GET(attr6, PF_STATUS);
+}
+
 int hinic3_init_hwif(struct hinic3_hwdev *hwdev)
 {
 	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
@@ -378,9 +437,15 @@ int hinic3_init_hwif(struct hinic3_hwdev *hwdev)
 		return -ENOMEM;
 
 	hwdev->hwif = hwif;
-	hwif->cfg_regs_base = (u8 __iomem *)pci_adapter->cfg_reg_base +
+	/* if function is VF, mgmt_regs_base will be NULL */
+	hwif->cfg_regs_base = pci_adapter->mgmt_reg_base ?
+			      pci_adapter->cfg_reg_base :
+			      (u8 __iomem *)pci_adapter->cfg_reg_base +
 			      HINIC3_VF_CFG_REG_OFFSET;
 
+	hwif->intr_regs_base = pci_adapter->intr_reg_base;
+	hwif->mgmt_regs_base = pci_adapter->mgmt_reg_base;
+
 	err = db_area_idx_init(hwif, pci_adapter->db_base_phy,
 			       pci_adapter->db_base,
 			       pci_adapter->db_dwqe_len);
@@ -412,7 +477,15 @@ int hinic3_init_hwif(struct hinic3_hwdev *hwdev)
 		goto err_free_db_area_idx;
 	}
 
+	hinic3_set_ppf(hwdev);
+
 	disable_all_msix(hwdev);
+	/* disable mgmt cpu from reporting any event */
+	hinic3_set_pf_status(hwdev->hwif, HINIC3_PF_STATUS_INIT);
+
+	dev_dbg(hwdev->dev, "global_func_idx: %u, func_type: %d, host_id: %u, ppf: %u\n",
+		hwif->attr.func_global_idx, hwif->attr.func_type,
+		hwif->attr.pci_intf_idx, hwif->attr.ppf_idx);
 
 	return 0;
 
@@ -434,3 +507,18 @@ u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
 {
 	return hwdev->hwif->attr.func_global_idx;
 }
+
+u8 hinic3_pf_id_of_vf(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->hwif->attr.port_to_port_idx;
+}
+
+u16 hinic3_glb_pf_vf_offset(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->hwif->attr.global_vf_id_of_pf;
+}
+
+u8 hinic3_ppf_idx(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->hwif->attr.ppf_idx;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
index c02904e861cc..445bf7fa79b4 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -10,6 +10,7 @@
 struct hinic3_hwdev;
 
 enum hinic3_func_type {
+	HINIC3_FUNC_TYPE_PF = 0,
 	HINIC3_FUNC_TYPE_VF = 1,
 };
 
@@ -38,6 +39,8 @@ static_assert(sizeof(struct hinic3_func_attr) == 20);
 
 struct hinic3_hwif {
 	u8 __iomem              *cfg_regs_base;
+	u8 __iomem              *intr_regs_base;
+	u8 __iomem              *mgmt_regs_base;
 	u64                     db_base_phy;
 	u64                     db_dwqe_len;
 	u8 __iomem              *db_base;
@@ -50,6 +53,13 @@ enum hinic3_outbound_ctrl {
 	DISABLE_OUTBOUND = 0x1,
 };
 
+enum hinic3_pf_status {
+	HINIC3_PF_STATUS_INIT            = 0x0,
+	HINIC3_PF_STATUS_ACTIVE_FLAG     = 0x11,
+	HINIC3_PF_STATUS_FLR_START_FLAG  = 0x12,
+	HINIC3_PF_STATUS_FLR_FINISH_FLAG = 0x13,
+};
+
 enum hinic3_doorbell_ctrl {
 	ENABLE_DOORBELL  = 0,
 	DISABLE_DOORBELL = 1,
@@ -65,6 +75,12 @@ enum hinic3_msix_auto_mask {
 	HINIC3_SET_MSIX_AUTO_MASK,
 };
 
+#define HINIC3_FUNC_TYPE(hwdev)  ((hwdev)->hwif->attr.func_type)
+#define HINIC3_IS_PF(hwdev)  \
+	(HINIC3_FUNC_TYPE(hwdev) == HINIC3_FUNC_TYPE_PF)
+#define HINIC3_IS_VF(hwdev)  \
+	(HINIC3_FUNC_TYPE(hwdev) == HINIC3_FUNC_TYPE_VF)
+
 u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);
 void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);
 
@@ -75,6 +91,10 @@ int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
 			 void __iomem **dwqe_base);
 void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const u8 __iomem *db_base);
 
+void hinic3_set_pf_status(struct hinic3_hwif *hwif,
+			  enum hinic3_pf_status status);
+enum hinic3_pf_status hinic3_get_pf_status(struct hinic3_hwif *hwif);
+
 int hinic3_init_hwif(struct hinic3_hwdev *hwdev);
 void hinic3_free_hwif(struct hinic3_hwdev *hwdev);
 
@@ -86,5 +106,8 @@ void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 				     enum hinic3_msix_auto_mask flag);
 
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);
+u8 hinic3_pf_id_of_vf(struct hinic3_hwdev *hwdev);
+u16 hinic3_glb_pf_vf_offset(struct hinic3_hwdev *hwdev);
+u8 hinic3_ppf_idx(struct hinic3_hwdev *hwdev);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 3db8241a3b0c..2b77fea1e0b3 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -5,15 +5,22 @@
 #include <linux/iopoll.h>
 
 #include "hinic3_hw_cfg.h"
+#include "hinic3_hw_comm.h"
 #include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
 #include "hinic3_lld.h"
 #include "hinic3_mgmt.h"
 #include "hinic3_pci_id_tbl.h"
 
 #define HINIC3_VF_PCI_CFG_REG_BAR  0
+#define HINIC3_PF_PCI_CFG_REG_BAR  1
 #define HINIC3_PCI_INTR_REG_BAR    2
+/* Only PF has mgmt bar */
+#define HINIC3_PCI_MGMT_REG_BAR    3
 #define HINIC3_PCI_DB_BAR          4
 
+#define HINIC3_IS_VF_DEV(pdev)     ((pdev)->device == PCI_DEV_ID_HINIC3_VF)
+
 #define HINIC3_EVENT_POLL_SLEEP_US   1000
 #define HINIC3_EVENT_POLL_TIMEOUT_US 10000000
 
@@ -181,8 +188,12 @@ void hinic3_adev_event_unregister(struct auxiliary_device *adev)
 static int hinic3_mapping_bar(struct pci_dev *pdev,
 			      struct hinic3_pcidev *pci_adapter)
 {
-	pci_adapter->cfg_reg_base = pci_ioremap_bar(pdev,
-						    HINIC3_VF_PCI_CFG_REG_BAR);
+	int cfg_bar;
+
+	cfg_bar = HINIC3_IS_VF_DEV(pdev) ?
+			HINIC3_VF_PCI_CFG_REG_BAR : HINIC3_PF_PCI_CFG_REG_BAR;
+
+	pci_adapter->cfg_reg_base = pci_ioremap_bar(pdev, cfg_bar);
 	if (!pci_adapter->cfg_reg_base) {
 		dev_err(&pdev->dev, "Failed to map configuration regs\n");
 		return -ENOMEM;
@@ -195,16 +206,28 @@ static int hinic3_mapping_bar(struct pci_dev *pdev,
 		goto err_unmap_cfg_reg_base;
 	}
 
+	if (!HINIC3_IS_VF_DEV(pdev)) {
+		pci_adapter->mgmt_reg_base =
+			pci_ioremap_bar(pdev, HINIC3_PCI_MGMT_REG_BAR);
+		if (!pci_adapter->mgmt_reg_base) {
+			dev_err(&pdev->dev, "Failed to map mgmt regs\n");
+			goto err_unmap_intr_reg_base;
+		}
+	}
+
 	pci_adapter->db_base_phy = pci_resource_start(pdev, HINIC3_PCI_DB_BAR);
 	pci_adapter->db_dwqe_len = pci_resource_len(pdev, HINIC3_PCI_DB_BAR);
 	pci_adapter->db_base = pci_ioremap_bar(pdev, HINIC3_PCI_DB_BAR);
 	if (!pci_adapter->db_base) {
 		dev_err(&pdev->dev, "Failed to map doorbell regs\n");
-		goto err_unmap_intr_reg_base;
+		goto err_unmap_mgmt_reg_base;
 	}
 
 	return 0;
 
+err_unmap_mgmt_reg_base:
+	if (!HINIC3_IS_VF_DEV(pdev))
+		iounmap(pci_adapter->mgmt_reg_base);
 err_unmap_intr_reg_base:
 	iounmap(pci_adapter->intr_reg_base);
 
@@ -217,6 +240,8 @@ static int hinic3_mapping_bar(struct pci_dev *pdev,
 static void hinic3_unmapping_bar(struct hinic3_pcidev *pci_adapter)
 {
 	iounmap(pci_adapter->db_base);
+	if (!HINIC3_IS_VF_DEV(pci_adapter->pdev))
+		iounmap(pci_adapter->mgmt_reg_base);
 	iounmap(pci_adapter->intr_reg_base);
 	iounmap(pci_adapter->cfg_reg_base);
 }
@@ -295,6 +320,9 @@ static int hinic3_func_init(struct pci_dev *pdev,
 		return err;
 	}
 
+	if (HINIC3_IS_PF(pci_adapter->hwdev))
+		hinic3_sync_time_to_fw(pci_adapter->hwdev);
+
 	err = hinic3_attach_aux_devices(pci_adapter->hwdev);
 	if (err)
 		goto err_free_hwdev;
@@ -311,6 +339,8 @@ static void hinic3_func_uninit(struct pci_dev *pdev)
 {
 	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
 
+	/* disable mgmt reporting before flushing mgmt work-queue. */
+	hinic3_set_pf_status(pci_adapter->hwdev->hwif, HINIC3_PF_STATUS_INIT);
 	hinic3_flush_mgmt_workq(pci_adapter->hwdev);
 	hinic3_detach_aux_devices(pci_adapter->hwdev);
 	hinic3_free_hwdev(pci_adapter->hwdev);
@@ -319,6 +349,7 @@ static void hinic3_func_uninit(struct pci_dev *pdev)
 static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
 {
 	struct pci_dev *pdev = pci_adapter->pdev;
+	struct comm_cmd_bdf_info bdf_info = {};
 	int err;
 
 	err = hinic3_mapping_bar(pdev, pci_adapter);
@@ -331,8 +362,24 @@ static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
 	if (err)
 		goto err_unmap_bar;
 
+	if (HINIC3_IS_PF(pci_adapter->hwdev)) {
+		bdf_info.function_idx =
+			hinic3_global_func_id(pci_adapter->hwdev);
+		bdf_info.bus = pdev->bus->number;
+		bdf_info.device = PCI_SLOT(pdev->devfn);
+		bdf_info.function =  PCI_FUNC(pdev->devfn);
+
+		err = hinic3_set_bdf_ctxt(pci_adapter->hwdev, &bdf_info);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to set BDF info to fw\n");
+			goto err_uninit_func;
+		}
+	}
+
 	return 0;
 
+err_uninit_func:
+	hinic3_func_uninit(pdev);
 err_unmap_bar:
 	hinic3_unmapping_bar(pci_adapter);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index 6d87d4d895ba..a7c9c5bca53a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -130,6 +130,7 @@ static int hinic3_sw_init(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	u8 mac_addr[ETH_ALEN];
 	int err;
 
 	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
@@ -137,16 +138,29 @@ static int hinic3_sw_init(struct net_device *netdev)
 
 	hinic3_try_to_enable_rss(netdev);
 
-	/* VF driver always uses random MAC address. During VM migration to a
-	 * new device, the new device should learn the VMs old MAC rather than
-	 * provide its own MAC. The product design assumes that every VF is
-	 * suspectable to migration so the device avoids offering MAC address
-	 * to VFs.
-	 */
-	eth_hw_addr_random(netdev);
+	if (HINIC3_IS_VF(hwdev)) {
+		/* VF driver always uses random MAC address. During VM migration
+		 * to a new device, the new device should learn the VMs old MAC
+		 * rather than provide its own MAC. The product design assumes
+		 * that every VF is suspectable to migration so the device
+		 * avoids offering MAC address to VFs.
+		 */
+		eth_hw_addr_random(netdev);
+	} else {
+		err = hinic3_get_default_mac(hwdev, mac_addr);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to get MAC address\n");
+			goto err_clear_rss_config;
+		}
+		eth_hw_addr_set(netdev, mac_addr);
+	}
+
 	err = hinic3_set_mac(hwdev, netdev->dev_addr, 0,
 			     hinic3_global_func_id(hwdev));
-	if (err) {
+	/* Failure to set MAC is not a fatal error for VF since its MAC may have
+	 * already been set by PF
+	 */
+	if (err && err != -EADDRINUSE) {
 		dev_err(hwdev->dev, "Failed to set default MAC\n");
 		goto err_clear_rss_config;
 	}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
index cf67e26acece..b4e151e88a13 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -82,10 +82,27 @@ static struct hinic3_msg_desc *get_mbox_msg_desc(struct hinic3_mbox *mbox,
 						 enum mbox_msg_direction_type dir,
 						 u16 src_func_id)
 {
+	struct hinic3_hwdev *hwdev = mbox->hwdev;
 	struct hinic3_msg_channel *msg_ch;
-
-	msg_ch = (src_func_id == MBOX_MGMT_FUNC_ID) ?
-		&mbox->mgmt_msg : mbox->func_msg;
+	u16 id;
+
+	if (src_func_id == MBOX_MGMT_FUNC_ID) {
+		msg_ch = &mbox->mgmt_msg;
+	} else if (HINIC3_IS_VF(hwdev)) {
+		/* message from pf */
+		msg_ch = mbox->func_msg;
+		if (src_func_id != hinic3_pf_id_of_vf(hwdev) || !msg_ch)
+			return NULL;
+	} else if (src_func_id > hinic3_glb_pf_vf_offset(hwdev)) {
+		/* message from vf */
+		id = (src_func_id - 1) - hinic3_glb_pf_vf_offset(hwdev);
+		if (id >= 1)
+			return NULL;
+
+		msg_ch = &mbox->func_msg[id];
+	} else {
+		return NULL;
+	}
 
 	return (dir == MBOX_MSG_SEND) ?
 		&msg_ch->recv_msg : &msg_ch->resp_msg;
@@ -409,6 +426,13 @@ int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
 	if (err)
 		goto err_destroy_workqueue;
 
+	if (HINIC3_IS_VF(hwdev)) {
+		/* VF to PF mbox message channel */
+		err = hinic3_init_func_mbox_msg_channel(hwdev);
+		if (err)
+			goto err_uninit_mgmt_msg_ch;
+	}
+
 	err = hinic3_init_func_mbox_msg_channel(hwdev);
 	if (err)
 		goto err_uninit_mgmt_msg_ch;
@@ -424,8 +448,8 @@ int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
 	return 0;
 
 err_uninit_func_mbox_msg_ch:
-	hinic3_uninit_func_mbox_msg_channel(hwdev);
-
+	if (HINIC3_IS_VF(hwdev))
+		hinic3_uninit_func_mbox_msg_channel(hwdev);
 err_uninit_mgmt_msg_ch:
 	uninit_mgmt_msg_channel(mbox);
 
@@ -576,7 +600,13 @@ static void write_mbox_msg_attr(struct hinic3_mbox *mbox,
 {
 	struct hinic3_hwif *hwif = mbox->hwdev->hwif;
 	u32 mbox_int, mbox_ctrl, tx_size;
+	u16 func = dst_func;
 
+	/* VF can send non-management messages only to PF. We set DST_FUNC field
+	 * to 0 since HW will ignore it anyway.
+	 */
+	if (HINIC3_IS_VF(mbox->hwdev) && dst_func != MBOX_MGMT_FUNC_ID)
+		func = 0;
 	tx_size = ALIGN(seg_len + MBOX_HEADER_SZ, MBOX_SEG_LEN_ALIGN) >> 2;
 
 	mbox_int = MBOX_INT_SET(dst_aeqn, DST_AEQN) |
@@ -587,7 +617,7 @@ static void write_mbox_msg_attr(struct hinic3_mbox *mbox,
 
 	mbox_ctrl = MBOX_CTRL_SET(1, TX_STATUS) |
 		    MBOX_CTRL_SET(0, TRIGGER_AEQE) |
-		    MBOX_CTRL_SET(dst_func, DST_FUNC);
+		    MBOX_CTRL_SET(func, DST_FUNC);
 
 	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_INT_OFF, mbox_int);
 	hinic3_hwif_write_reg(hwif, HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index 6cc0345c39e4..f9a3222b1b46 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -163,6 +163,7 @@ enum l2nic_cmd {
 	L2NIC_CMD_SET_SQ_CI_ATTR      = 8,
 	L2NIC_CMD_CLEAR_QP_RESOURCE   = 11,
 	L2NIC_CMD_FEATURE_NEGO        = 15,
+	L2NIC_CMD_GET_MAC             = 20,
 	L2NIC_CMD_SET_MAC             = 21,
 	L2NIC_CMD_DEL_MAC             = 22,
 	L2NIC_CMD_UPDATE_MAC          = 23,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 979f47ca77f9..e784f1b04a41 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -117,17 +117,52 @@ int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
 					 &func_tbl_cfg);
 }
 
+static bool hinic3_check_vf_set_by_pf(struct hinic3_hwdev *hwdev,
+				      u8 status)
+{
+	return HINIC3_IS_VF(hwdev) && status == HINIC3_PF_SET_VF_ALREADY;
+}
+
 static int hinic3_check_mac_info(struct hinic3_hwdev *hwdev, u8 status,
 				 u16 vlan_id)
 {
 	if ((status && status != MGMT_STATUS_EXIST) ||
 	    ((vlan_id & BIT(15)) && status == MGMT_STATUS_EXIST)) {
+		if (hinic3_check_vf_set_by_pf(hwdev, status))
+			return 0;
+
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
+int hinic3_get_default_mac(struct hinic3_hwdev *hwdev, u8 *mac_addr)
+{
+	struct l2nic_cmd_set_mac mac_info = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	mac_info.func_id = hinic3_global_func_id(hwdev);
+
+	mgmt_msg_params_init_default(&msg_params, &mac_info, sizeof(mac_info));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_GET_MAC,
+				       &msg_params);
+
+	if (err || mac_info.msg_head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get mac, err: %d, status: 0x%x\n",
+			err, mac_info.msg_head.status);
+		return -EFAULT;
+	}
+
+	ether_addr_copy(mac_addr, mac_info.mac);
+
+	return 0;
+}
+
 int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id,
 		   u16 func_id)
 {
@@ -157,9 +192,9 @@ int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id,
 		return -EIO;
 	}
 
-	if (mac_info.msg_head.status == MGMT_STATUS_PF_SET_VF_ALREADY) {
+	if (hinic3_check_vf_set_by_pf(hwdev, mac_info.msg_head.status)) {
 		dev_warn(hwdev->dev, "PF has already set VF mac, Ignore set operation\n");
-		return 0;
+		return -EADDRINUSE;
 	}
 
 	if (mac_info.msg_head.status == MGMT_STATUS_EXIST) {
@@ -191,11 +226,18 @@ int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id,
 
 	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
 				       L2NIC_CMD_DEL_MAC, &msg_params);
-	if (err) {
+	if (err ||
+	    (mac_info.msg_head.status &&
+	     !hinic3_check_vf_set_by_pf(hwdev, mac_info.msg_head.status))) {
 		dev_err(hwdev->dev,
 			"Failed to delete MAC, err: %d, status: 0x%x\n",
 			err, mac_info.msg_head.status);
-		return err;
+		return -EFAULT;
+	}
+
+	if (hinic3_check_vf_set_by_pf(hwdev, mac_info.msg_head.status)) {
+		dev_warn(hwdev->dev, "PF has already set VF mac, Ignore delete operation.\n");
+		return -EADDRINUSE;
 	}
 
 	return 0;
@@ -231,6 +273,17 @@ int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac,
 		return -EIO;
 	}
 
+	if (hinic3_check_vf_set_by_pf(hwdev, mac_info.msg_head.status)) {
+		dev_warn(hwdev->dev, "PF has already set VF MAC. Ignore update operation\n");
+		return -EADDRINUSE;
+	}
+
+	if (mac_info.msg_head.status == HINIC3_MGMT_STATUS_EXIST) {
+		dev_warn(hwdev->dev,
+			 "MAC is repeated. Ignore update operation\n");
+		return 0;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index b83b567fa542..08bf14679bf8 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -16,6 +16,8 @@ struct hinic3_nic_dev;
 #define HINIC3_MAX_JUMBO_FRAME_SIZE  9600
 
 #define HINIC3_VLAN_ID_MASK          0x7FFF
+#define HINIC3_PF_SET_VF_ALREADY     0x4
+#define HINIC3_MGMT_STATUS_EXIST     0x6
 
 enum hinic3_nic_event_type {
 	HINIC3_NIC_EVENT_LINK_DOWN = 0,
@@ -41,6 +43,7 @@ void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap);
 int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu);
 
+int hinic3_get_default_mac(struct hinic3_hwdev *hwdev, u8 *mac_addr);
 int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id,
 		   u16 func_id);
 int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id,
-- 
2.43.0


