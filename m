Return-Path: <netdev+bounces-217764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D079FB39C8A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A772467652
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720E30F7EF;
	Thu, 28 Aug 2025 12:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A2631280D;
	Thu, 28 Aug 2025 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383041; cv=none; b=nBmsLYWLFMJz8cFdb4TXrAGRjKXOxzbKlBMlHdhdeRMTrWVu7QuV19zomkZPQXdxCnoJOyLofnBh3XDMXjgoJyrxBU7TxNzW1cKydjaPzw5x7TnW0P5LIBPMFoN3xgaXq3LC2THsPpRTaXstoki3Q8Ymd9dPBDtxRWNSz7Bd4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383041; c=relaxed/simple;
	bh=nlVp2QA52QIw7dq9+zNtK+tlyeuWR5SI05V6xA8HV1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujBLh/IxTE7mQukpbtSdH76LS7U/6wwMEtGYhP20D/bVSjs0y8pG1FGYEwF+t8tIL0GdTkmxtqdwE0Nd7X7UEVgSCiFU87aYLRCfZKImTZ/NZ6VHVChnkWbPY7DfFyLT5H7eblAs/6NuKOp1MPph/kaPaJYvnnybaNb/zoJBZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cCKy575Mtz27jHC;
	Thu, 28 Aug 2025 20:11:41 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 229F01A0188;
	Thu, 28 Aug 2025 20:10:35 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 20:10:33 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
	<mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v02 03/14] hinic3: HW common function initialization
Date: Thu, 28 Aug 2025 20:10:09 +0800
Message-ID: <c4a9a72f52c019ab6eebdcf8334c1705974d1749.1756378721.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1756378721.git.zhuyikai1@h-partners.com>
References: <cover.1756378721.git.zhuyikai1@h-partners.com>
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

Add initialization for data structures and functions(cmdq ceq mbox ceq)
that interact with hardware.

Co-developed-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 174 +++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  17 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  67 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c | 461 +++++++++++++++++-
 4 files changed, 718 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index 7adcdd569c7b..b016806c7f67 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -3,6 +3,7 @@
 
 #include <linux/delay.h>
 
+#include "hinic3_cmdq.h"
 #include "hinic3_hw_comm.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
@@ -61,3 +62,176 @@ int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
 
 	return 0;
 }
+
+static int hinic3_comm_features_nego(struct hinic3_hwdev *hwdev, u8 opcode,
+				     u64 *s_feature, u16 size)
+{
+	struct comm_cmd_feature_nego feature_nego = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	feature_nego.func_id = hinic3_global_func_id(hwdev);
+	feature_nego.opcode = opcode;
+	if (opcode == MGMT_MSG_CMD_OP_SET)
+		memcpy(feature_nego.s_feature, s_feature, (size * sizeof(u64)));
+
+	mgmt_msg_params_init_default(&msg_params, &feature_nego,
+				     sizeof(feature_nego));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_FEATURE_NEGO, &msg_params);
+	if (err || feature_nego.head.status) {
+		dev_err(hwdev->dev, "Failed to negotiate feature, err: %d, status: 0x%x\n",
+			err, feature_nego.head.status);
+		return -EINVAL;
+	}
+
+	if (opcode == MGMT_MSG_CMD_OP_GET)
+		memcpy(s_feature, feature_nego.s_feature, (size * sizeof(u64)));
+
+	return 0;
+}
+
+int hinic3_get_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature,
+			     u16 size)
+{
+	return hinic3_comm_features_nego(hwdev, MGMT_MSG_CMD_OP_GET, s_feature,
+					 size);
+}
+
+int hinic3_set_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature,
+			     u16 size)
+{
+	return hinic3_comm_features_nego(hwdev, MGMT_MSG_CMD_OP_SET, s_feature,
+					 size);
+}
+
+int hinic3_get_global_attr(struct hinic3_hwdev *hwdev,
+			   struct comm_global_attr *attr)
+{
+	struct comm_cmd_get_glb_attr get_attr = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	mgmt_msg_params_init_default(&msg_params, &get_attr, sizeof(get_attr));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_GET_GLOBAL_ATTR, &msg_params);
+	if (err || get_attr.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get global attribute, err: %d, status: 0x%x\n",
+			err, get_attr.head.status);
+		return -EIO;
+	}
+
+	memcpy(attr, &get_attr.attr, sizeof(*attr));
+
+	return 0;
+}
+
+int hinic3_set_func_svc_used_state(struct hinic3_hwdev *hwdev, u16 svc_type,
+				   u8 state)
+{
+	struct comm_cmd_set_func_svc_used_state used_state = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	used_state.func_id = hinic3_global_func_id(hwdev);
+	used_state.svc_type = svc_type;
+	used_state.used_state = state;
+
+	mgmt_msg_params_init_default(&msg_params, &used_state,
+				     sizeof(used_state));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SET_FUNC_SVC_USED_STATE,
+				       &msg_params);
+	if (err || used_state.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set func service used state, err: %d, status: 0x%x\n",
+			err, used_state.head.status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int hinic3_set_dma_attr_tbl(struct hinic3_hwdev *hwdev, u8 entry_idx, u8 st,
+			    u8 at, u8 ph, u8 no_snooping, u8 tph_en)
+{
+	struct comm_cmd_set_dma_attr dma_attr = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	dma_attr.func_id = hinic3_global_func_id(hwdev);
+	dma_attr.entry_idx = entry_idx;
+	dma_attr.st = st;
+	dma_attr.at = at;
+	dma_attr.ph = ph;
+	dma_attr.no_snooping = no_snooping;
+	dma_attr.tph_en = tph_en;
+
+	mgmt_msg_params_init_default(&msg_params, &dma_attr, sizeof(dma_attr));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SET_DMA_ATTR, &msg_params);
+	if (err || dma_attr.head.status) {
+		dev_err(hwdev->dev, "Failed to set dma attr, err: %d, status: 0x%x\n",
+			err, dma_attr.head.status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, u16 func_idx,
+			    u32 page_size)
+{
+	struct comm_cmd_cfg_wq_page_size page_size_info = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	page_size_info.func_id = func_idx;
+	page_size_info.page_size = ilog2(page_size / HINIC3_MIN_PAGE_SIZE);
+	page_size_info.opcode = MGMT_MSG_CMD_OP_SET;
+
+	mgmt_msg_params_init_default(&msg_params, &page_size_info,
+				     sizeof(page_size_info));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_CFG_PAGESIZE, &msg_params);
+	if (err || page_size_info.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set wq page size, err: %d, status: 0x%x\n",
+			err, page_size_info.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth)
+{
+	struct comm_cmd_set_root_ctxt root_ctxt = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	root_ctxt.func_id = hinic3_global_func_id(hwdev);
+
+	root_ctxt.set_cmdq_depth = 1;
+	root_ctxt.cmdq_depth = ilog2(cmdq_depth);
+
+	mgmt_msg_params_init_default(&msg_params, &root_ctxt,
+				     sizeof(root_ctxt));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,
+				       COMM_CMD_SET_VAT, &msg_params);
+	if (err || root_ctxt.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set cmdq depth, err: %d, status: 0x%x\n",
+			err, root_ctxt.head.status);
+		return -EFAULT;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
index 2270987b126f..478db3c13281 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -8,6 +8,8 @@
 
 struct hinic3_hwdev;
 
+#define HINIC3_WQ_PAGE_SIZE_ORDER  8
+
 struct hinic3_interrupt_info {
 	u32 lli_set;
 	u32 interrupt_coalesc_set;
@@ -23,4 +25,19 @@ int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
 				    const struct hinic3_interrupt_info *info);
 int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
 
+int hinic3_get_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature,
+			     u16 size);
+int hinic3_set_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature,
+			     u16 size);
+int hinic3_get_global_attr(struct hinic3_hwdev *hwdev,
+			   struct comm_global_attr *attr);
+int hinic3_set_func_svc_used_state(struct hinic3_hwdev *hwdev, u16 svc_type,
+				   u8 state);
+int hinic3_set_dma_attr_tbl(struct hinic3_hwdev *hwdev, u8 entry_idx, u8 st,
+			    u8 at, u8 ph, u8 no_snooping, u8 tph_en);
+
+int hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, u16 func_idx,
+			    u32 page_size);
+int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index 379ba4cb042c..b5695dda8fe5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -98,6 +98,11 @@ enum comm_func_reset_bits {
 	COMM_FUNC_RESET_BIT_NIC          = BIT(13),
 };
 
+#define COMM_FUNC_RESET_FLAG \
+	(COMM_FUNC_RESET_BIT_COMM | COMM_FUNC_RESET_BIT_COMM_CMD_CH | \
+	 COMM_FUNC_RESET_BIT_FLUSH | COMM_FUNC_RESET_BIT_MQM | \
+	 COMM_FUNC_RESET_BIT_SMF | COMM_FUNC_RESET_BIT_PF_BW_CFG)
+
 struct comm_cmd_func_reset {
 	struct mgmt_msg_head head;
 	u16                  func_id;
@@ -114,6 +119,46 @@ struct comm_cmd_feature_nego {
 	u64                  s_feature[COMM_MAX_FEATURE_QWORD];
 };
 
+struct comm_global_attr {
+	u8  max_host_num;
+	u8  max_pf_num;
+	u16 vf_id_start;
+	/* for api cmd to mgmt cpu */
+	u8  mgmt_host_node_id;
+	u8  cmdq_num;
+	u8  rsvd1[34];
+};
+
+struct comm_cmd_get_glb_attr {
+	struct mgmt_msg_head    head;
+	struct comm_global_attr attr;
+};
+
+enum comm_func_svc_type {
+	COMM_FUNC_SVC_T_COMM = 0,
+	COMM_FUNC_SVC_T_NIC  = 1,
+};
+
+struct comm_cmd_set_func_svc_used_state {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  svc_type;
+	u8                   used_state;
+	u8                   rsvd[35];
+};
+
+struct comm_cmd_set_dma_attr {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u8                   entry_idx;
+	u8                   st;
+	u8                   at;
+	u8                   ph;
+	u8                   no_snooping;
+	u8                   tph_en;
+	u32                  resv1;
+};
+
 struct comm_cmd_set_ceq_ctrl_reg {
 	struct mgmt_msg_head head;
 	u16                  func_id;
@@ -123,6 +168,28 @@ struct comm_cmd_set_ceq_ctrl_reg {
 	u32                  rsvd1;
 };
 
+struct comm_cmd_cfg_wq_page_size {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u8                   opcode;
+	/* real_size=4KB*2^page_size, range(0~20) must be checked by driver */
+	u8                   page_size;
+	u32                  rsvd1;
+};
+
+struct comm_cmd_set_root_ctxt {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u8                   set_cmdq_depth;
+	u8                   cmdq_depth;
+	u16                  rx_buf_sz;
+	u8                   lro_en;
+	u8                   rsvd1;
+	u16                  sq_depth;
+	u16                  rq_depth;
+	u64                  rsvd2;
+};
+
 struct comm_cmdq_ctxt_info {
 	__le64 curr_wqe_page_pfn;
 	__le64 wq_block_pfn;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 670819f0e92c..cd4425b265bf 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 
+#include "hinic3_cmdq.h"
+#include "hinic3_csr.h"
 #include "hinic3_eqs.h"
 #include "hinic3_hw_comm.h"
 #include "hinic3_hwdev.h"
@@ -8,6 +10,30 @@
 #include "hinic3_mbox.h"
 #include "hinic3_mgmt.h"
 
+#define HINIC3_PCIE_SNOOP        0
+#define HINIC3_PCIE_TPH_DISABLE  0
+
+#define HINIC3_DMA_ATTR_INDIR_IDX_MASK          GENMASK(9, 0)
+#define HINIC3_DMA_ATTR_INDIR_IDX_SET(val, member)  \
+	FIELD_PREP(HINIC3_DMA_ATTR_INDIR_##member##_MASK, val)
+
+#define HINIC3_DMA_ATTR_ENTRY_ST_MASK           GENMASK(7, 0)
+#define HINIC3_DMA_ATTR_ENTRY_AT_MASK           GENMASK(9, 8)
+#define HINIC3_DMA_ATTR_ENTRY_PH_MASK           GENMASK(11, 10)
+#define HINIC3_DMA_ATTR_ENTRY_NO_SNOOPING_MASK  BIT(12)
+#define HINIC3_DMA_ATTR_ENTRY_TPH_EN_MASK       BIT(13)
+#define HINIC3_DMA_ATTR_ENTRY_SET(val, member)  \
+	FIELD_PREP(HINIC3_DMA_ATTR_ENTRY_##member##_MASK, val)
+
+#define HINIC3_PCIE_ST_DISABLE       0
+#define HINIC3_PCIE_AT_DISABLE       0
+#define HINIC3_PCIE_PH_DISABLE       0
+#define HINIC3_PCIE_MSIX_ATTR_ENTRY  0
+
+#define HINIC3_DEFAULT_EQ_MSIX_PENDING_LIMIT      0
+#define HINIC3_DEFAULT_EQ_MSIX_COALESC_TIMER_CFG  0xFF
+#define HINIC3_DEFAULT_EQ_MSIX_RESEND_TIMER_CFG   7
+
 #define HINIC3_HWDEV_WQ_NAME    "hinic3_hardware"
 #define HINIC3_WQ_MAX_REQ       10
 
@@ -16,6 +42,402 @@ enum hinic3_hwdev_init_state {
 	HINIC3_HWDEV_CMDQ_INITED = 3,
 };
 
+static int hinic3_comm_aeqs_init(struct hinic3_hwdev *hwdev)
+{
+	struct msix_entry aeq_msix_entries[HINIC3_MAX_AEQS];
+	u16 num_aeqs, resp_num_irq, i;
+	int err;
+
+	num_aeqs = hwdev->hwif->attr.num_aeqs;
+	if (num_aeqs > HINIC3_MAX_AEQS) {
+		dev_warn(hwdev->dev, "Adjust aeq num to %d\n",
+			 HINIC3_MAX_AEQS);
+		num_aeqs = HINIC3_MAX_AEQS;
+	}
+	err = hinic3_alloc_irqs(hwdev, num_aeqs, aeq_msix_entries,
+				&resp_num_irq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc aeq irqs, num_aeqs: %u\n",
+			num_aeqs);
+		return err;
+	}
+
+	if (resp_num_irq < num_aeqs) {
+		dev_warn(hwdev->dev, "Adjust aeq num to %u\n",
+			 resp_num_irq);
+		num_aeqs = resp_num_irq;
+	}
+
+	err = hinic3_aeqs_init(hwdev, num_aeqs, aeq_msix_entries);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init aeqs\n");
+		goto err_free_irqs;
+	}
+
+	return 0;
+
+err_free_irqs:
+	for (i = 0; i < num_aeqs; i++)
+		hinic3_free_irq(hwdev, aeq_msix_entries[i].vector);
+
+	return err;
+}
+
+static int hinic3_comm_ceqs_init(struct hinic3_hwdev *hwdev)
+{
+	struct msix_entry ceq_msix_entries[HINIC3_MAX_CEQS];
+	u16 num_ceqs, resp_num_irq, i;
+	int err;
+
+	num_ceqs = hwdev->hwif->attr.num_ceqs;
+	if (num_ceqs > HINIC3_MAX_CEQS) {
+		dev_warn(hwdev->dev, "Adjust ceq num to %d\n",
+			 HINIC3_MAX_CEQS);
+		num_ceqs = HINIC3_MAX_CEQS;
+	}
+
+	err = hinic3_alloc_irqs(hwdev, num_ceqs, ceq_msix_entries,
+				&resp_num_irq);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc ceq irqs, num_ceqs: %u\n",
+			num_ceqs);
+		return err;
+	}
+
+	if (resp_num_irq < num_ceqs) {
+		dev_warn(hwdev->dev, "Adjust ceq num to %u\n",
+			 resp_num_irq);
+		num_ceqs = resp_num_irq;
+	}
+
+	err = hinic3_ceqs_init(hwdev, num_ceqs, ceq_msix_entries);
+	if (err) {
+		dev_err(hwdev->dev,
+			"Failed to init ceqs, err:%d\n", err);
+		goto err_free_irqs;
+	}
+
+	return 0;
+
+err_free_irqs:
+	for (i = 0; i < num_ceqs; i++)
+		hinic3_free_irq(hwdev, ceq_msix_entries[i].vector);
+
+	return err;
+}
+
+static int hinic3_comm_mbox_init(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_init_mbox(hwdev);
+	if (err)
+		return err;
+
+	hinic3_aeq_register_cb(hwdev, HINIC3_MBX_FROM_FUNC,
+			       hinic3_mbox_func_aeqe_handler);
+	hinic3_aeq_register_cb(hwdev, HINIC3_MSG_FROM_FW,
+			       hinic3_mgmt_msg_aeqe_handler);
+
+	set_bit(HINIC3_HWDEV_MBOX_INITED, &hwdev->func_state);
+
+	return 0;
+}
+
+static void hinic3_comm_mbox_free(struct hinic3_hwdev *hwdev)
+{
+	spin_lock_bh(&hwdev->channel_lock);
+	clear_bit(HINIC3_HWDEV_MBOX_INITED, &hwdev->func_state);
+	spin_unlock_bh(&hwdev->channel_lock);
+	hinic3_aeq_unregister_cb(hwdev, HINIC3_MBX_FROM_FUNC);
+	hinic3_aeq_unregister_cb(hwdev, HINIC3_MSG_FROM_FW);
+	hinic3_free_mbox(hwdev);
+}
+
+static int init_aeqs_msix_attr(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_aeqs *aeqs = hwdev->aeqs;
+	struct hinic3_interrupt_info info = {};
+	struct hinic3_eq *eq;
+	u16 q_id;
+	int err;
+
+	info.interrupt_coalesc_set = 1;
+	info.pending_limit = HINIC3_DEFAULT_EQ_MSIX_PENDING_LIMIT;
+	info.coalesc_timer_cfg = HINIC3_DEFAULT_EQ_MSIX_COALESC_TIMER_CFG;
+	info.resend_timer_cfg = HINIC3_DEFAULT_EQ_MSIX_RESEND_TIMER_CFG;
+
+	for (q_id = 0; q_id < aeqs->num_aeqs; q_id++) {
+		eq = &aeqs->aeq[q_id];
+		info.msix_index = eq->msix_entry_idx;
+		err = hinic3_set_interrupt_cfg_direct(hwdev, &info);
+		if (err) {
+			dev_err(hwdev->dev, "Set msix attr for aeq %d failed\n",
+				q_id);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int init_ceqs_msix_attr(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_ceqs *ceqs = hwdev->ceqs;
+	struct hinic3_interrupt_info info = {};
+	struct hinic3_eq *eq;
+	u16 q_id;
+	int err;
+
+	info.interrupt_coalesc_set = 1;
+	info.pending_limit = HINIC3_DEFAULT_EQ_MSIX_PENDING_LIMIT;
+	info.coalesc_timer_cfg = HINIC3_DEFAULT_EQ_MSIX_COALESC_TIMER_CFG;
+	info.resend_timer_cfg = HINIC3_DEFAULT_EQ_MSIX_RESEND_TIMER_CFG;
+
+	for (q_id = 0; q_id < ceqs->num_ceqs; q_id++) {
+		eq = &ceqs->ceq[q_id];
+		info.msix_index = eq->msix_entry_idx;
+		err = hinic3_set_interrupt_cfg_direct(hwdev, &info);
+		if (err) {
+			dev_err(hwdev->dev, "Set msix attr for ceq %u failed\n",
+				q_id);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int init_basic_mgmt_channel(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_comm_aeqs_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init async event queues\n");
+		return err;
+	}
+
+	err = hinic3_comm_mbox_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init mailbox\n");
+		goto err_free_comm_aeqs;
+	}
+
+	err = init_aeqs_msix_attr(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init aeqs msix attr\n");
+		goto err_free_comm_mbox;
+	}
+
+	return 0;
+
+err_free_comm_mbox:
+	hinic3_comm_mbox_free(hwdev);
+
+err_free_comm_aeqs:
+	hinic3_aeqs_free(hwdev);
+
+	return err;
+}
+
+static void free_base_mgmt_channel(struct hinic3_hwdev *hwdev)
+{
+	hinic3_comm_mbox_free(hwdev);
+	hinic3_aeqs_free(hwdev);
+}
+
+static int dma_attr_table_init(struct hinic3_hwdev *hwdev)
+{
+	u32 addr, val, dst_attr;
+
+	/* Indirect access, set entry_idx first */
+	addr = HINIC3_CSR_DMA_ATTR_INDIR_IDX_ADDR;
+	val = hinic3_hwif_read_reg(hwdev->hwif, addr);
+	val &= ~HINIC3_DMA_ATTR_ENTRY_AT_MASK;
+	val |= HINIC3_DMA_ATTR_INDIR_IDX_SET(HINIC3_PCIE_MSIX_ATTR_ENTRY, IDX);
+	hinic3_hwif_write_reg(hwdev->hwif, addr, val);
+
+	addr = HINIC3_CSR_DMA_ATTR_TBL_ADDR;
+	val = hinic3_hwif_read_reg(hwdev->hwif, addr);
+
+	dst_attr = HINIC3_DMA_ATTR_ENTRY_SET(HINIC3_PCIE_ST_DISABLE, ST) |
+		   HINIC3_DMA_ATTR_ENTRY_SET(HINIC3_PCIE_AT_DISABLE, AT) |
+		   HINIC3_DMA_ATTR_ENTRY_SET(HINIC3_PCIE_PH_DISABLE, PH) |
+		   HINIC3_DMA_ATTR_ENTRY_SET(HINIC3_PCIE_SNOOP, NO_SNOOPING) |
+		   HINIC3_DMA_ATTR_ENTRY_SET(HINIC3_PCIE_TPH_DISABLE, TPH_EN);
+	if (val == dst_attr)
+		return 0;
+
+	return hinic3_set_dma_attr_tbl(hwdev,
+				       HINIC3_PCIE_MSIX_ATTR_ENTRY,
+				       HINIC3_PCIE_ST_DISABLE,
+				       HINIC3_PCIE_AT_DISABLE,
+				       HINIC3_PCIE_PH_DISABLE,
+				       HINIC3_PCIE_SNOOP,
+				       HINIC3_PCIE_TPH_DISABLE);
+}
+
+static int init_basic_attributes(struct hinic3_hwdev *hwdev)
+{
+	struct comm_global_attr glb_attr;
+	int err;
+
+	err = hinic3_func_reset(hwdev, hinic3_global_func_id(hwdev),
+				COMM_FUNC_RESET_FLAG);
+	if (err)
+		return err;
+
+	err = hinic3_get_comm_features(hwdev, hwdev->features,
+				       COMM_MAX_FEATURE_QWORD);
+	if (err)
+		return err;
+
+	dev_dbg(hwdev->dev, "Comm hw features: 0x%llx\n", hwdev->features[0]);
+
+	err = hinic3_get_global_attr(hwdev, &glb_attr);
+	if (err)
+		return err;
+
+	err = hinic3_set_func_svc_used_state(hwdev, COMM_FUNC_SVC_T_COMM, 1);
+	if (err)
+		return err;
+
+	err = dma_attr_table_init(hwdev);
+	if (err)
+		return err;
+
+	hwdev->max_cmdq = min(glb_attr.cmdq_num, HINIC3_MAX_CMDQ_TYPES);
+	dev_dbg(hwdev->dev,
+		"global attribute: max_host: 0x%x, max_pf: 0x%x, vf_id_start: 0x%x, mgmt node id: 0x%x, cmdq_num: 0x%x\n",
+		glb_attr.max_host_num, glb_attr.max_pf_num,
+		glb_attr.vf_id_start, glb_attr.mgmt_host_node_id,
+		glb_attr.cmdq_num);
+
+	return 0;
+}
+
+static int hinic3_comm_cmdqs_init(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_cmdqs_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cmd queues\n");
+		return err;
+	}
+
+	hinic3_ceq_register_cb(hwdev, HINIC3_CMDQ, hinic3_cmdq_ceq_handler);
+
+	err = hinic3_set_cmdq_depth(hwdev, CMDQ_DEPTH);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set cmdq depth\n");
+		goto err_free_cmdqs;
+	}
+
+	set_bit(HINIC3_HWDEV_CMDQ_INITED, &hwdev->func_state);
+
+	return 0;
+
+err_free_cmdqs:
+	hinic3_cmdqs_free(hwdev);
+
+	return err;
+}
+
+static void hinic3_comm_cmdqs_free(struct hinic3_hwdev *hwdev)
+{
+	spin_lock_bh(&hwdev->channel_lock);
+	clear_bit(HINIC3_HWDEV_CMDQ_INITED, &hwdev->func_state);
+	spin_unlock_bh(&hwdev->channel_lock);
+
+	hinic3_ceq_unregister_cb(hwdev, HINIC3_CMDQ);
+	hinic3_cmdqs_free(hwdev);
+}
+
+static int init_cmdqs_channel(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = hinic3_comm_ceqs_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init completion event queues\n");
+		return err;
+	}
+
+	err = init_ceqs_msix_attr(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init ceqs msix attr\n");
+		goto err_free_ceqs;
+	}
+
+	hwdev->wq_page_size = HINIC3_MIN_PAGE_SIZE << HINIC3_WQ_PAGE_SIZE_ORDER;
+	err = hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+				      hwdev->wq_page_size);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set wq page size\n");
+		goto err_free_ceqs;
+	}
+
+	err = hinic3_comm_cmdqs_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cmd queues\n");
+		goto err_reset_wq_page_size;
+	}
+
+	return 0;
+
+err_reset_wq_page_size:
+	hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+				HINIC3_MIN_PAGE_SIZE);
+err_free_ceqs:
+	hinic3_ceqs_free(hwdev);
+
+	return err;
+}
+
+static void hinic3_free_cmdqs_channel(struct hinic3_hwdev *hwdev)
+{
+	hinic3_comm_cmdqs_free(hwdev);
+	hinic3_ceqs_free(hwdev);
+}
+
+static int hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
+{
+	int err;
+
+	err = init_basic_mgmt_channel(hwdev);
+	if (err)
+		return err;
+
+	err = init_basic_attributes(hwdev);
+	if (err)
+		goto err_free_basic_mgmt_ch;
+
+	err = init_cmdqs_channel(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cmdq channel\n");
+		goto err_clear_func_svc_used_state;
+	}
+
+	return 0;
+
+err_clear_func_svc_used_state:
+	hinic3_set_func_svc_used_state(hwdev, COMM_FUNC_SVC_T_COMM, 0);
+
+err_free_basic_mgmt_ch:
+	free_base_mgmt_channel(hwdev);
+
+	return err;
+}
+
+static void hinic3_uninit_comm_ch(struct hinic3_hwdev *hwdev)
+{
+	hinic3_free_cmdqs_channel(hwdev);
+	hinic3_set_func_svc_used_state(hwdev, COMM_FUNC_SVC_T_COMM, 0);
+	free_base_mgmt_channel(hwdev);
+}
+
 int hinic3_init_hwdev(struct pci_dev *pdev)
 {
 	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
@@ -53,8 +475,27 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 		goto err_destroy_workqueue;
 	}
 
+	err = hinic3_init_comm_ch(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init communication channel\n");
+		goto err_free_cfg_mgmt;
+	}
+
+	err = hinic3_set_comm_features(hwdev, hwdev->features,
+				       COMM_MAX_FEATURE_QWORD);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set comm features\n");
+		goto err_uninit_comm_ch;
+	}
+
 	return 0;
 
+err_uninit_comm_ch:
+	hinic3_uninit_comm_ch(hwdev);
+
+err_free_cfg_mgmt:
+	hinic3_free_cfg_mgmt(hwdev);
+
 err_destroy_workqueue:
 	destroy_workqueue(hwdev->workq);
 
@@ -70,6 +511,10 @@ int hinic3_init_hwdev(struct pci_dev *pdev)
 
 void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 {
+	u64 drv_features[COMM_MAX_FEATURE_QWORD] = {};
+
+	hinic3_set_comm_features(hwdev, drv_features, COMM_MAX_FEATURE_QWORD);
+	hinic3_uninit_comm_ch(hwdev);
 	hinic3_free_cfg_mgmt(hwdev);
 	destroy_workqueue(hwdev->workq);
 	hinic3_free_hwif(hwdev);
@@ -78,5 +523,19 @@ void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 
 void hinic3_set_api_stop(struct hinic3_hwdev *hwdev)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_mbox *mbox;
+
+	spin_lock_bh(&hwdev->channel_lock);
+	if (test_bit(HINIC3_HWDEV_MBOX_INITED, &hwdev->func_state)) {
+		mbox = hwdev->mbox;
+		spin_lock(&mbox->mbox_lock);
+		if (mbox->event_flag == MBOX_EVENT_START)
+			mbox->event_flag = MBOX_EVENT_TIMEOUT;
+		spin_unlock(&mbox->mbox_lock);
+	}
+
+	if (test_bit(HINIC3_HWDEV_CMDQ_INITED, &hwdev->func_state))
+		hinic3_cmdq_flush_sync_cmd(hwdev);
+
+	spin_unlock_bh(&hwdev->channel_lock);
 }
-- 
2.43.0


