Return-Path: <netdev+bounces-151359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB899EE581
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D87160F22
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7930212B39;
	Thu, 12 Dec 2024 11:51:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C09212B2E;
	Thu, 12 Dec 2024 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004301; cv=none; b=aozt5FBc4LBQLqr28QxWvOJuVap6j+M9TDYKRrn4hbo3rEx5UM+2h2t4baD31rJ3/f0DnS0JgcHVF1t9t6y72ifL6R7W1R6M7avEcw4wSiP7gNCUptxUF6q+AFHK4/lIjRukShtX390DkNiS2dmuGYvZbUccjsTWCg+b7X7rFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004301; c=relaxed/simple;
	bh=olEHe2kIFU5LmsQ/s8jaXd5eH9qgDPy/f5rnkTATUBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQS6RERAuKvge6AK5l4BNjr7BtjmWGnfYp7LptudlQfAYyQ6z6r9MIw411yLZil1DEb9a2c38Hd40tAFnpStXI6eQGL8L7+9PNtZwqNFKUhE2qR4CXBjY8qr2goPudDui51rhjGJ+O0s7lGHSGmb8xaVH1XkgiKKUwp3LzVdrv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y89hZ1syKz6K9gt;
	Thu, 12 Dec 2024 19:48:14 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 22ADB140A77;
	Thu, 12 Dec 2024 19:51:33 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Dec
 2024 12:51:23 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>, gongfan <gongfan1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Cai Huoqing
	<cai.huoqing@linux.dev>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Meny Yossefi
	<meny.yossefi@huawei.com>
Subject: [RFC net-next v02 3/3] net: hinic3: sw and hw initialization code
Date: Thu, 12 Dec 2024 14:04:17 +0200
Message-ID: <d36f3df22d93066c590ec1fb3ec25274d7c0b4f1.1733990727.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733990727.git.gur.stavi@huawei.com>
References: <cover.1733990727.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

From: gongfan <gongfan1@huawei.com>

This is [3/3] part of hinic3 Ethernet driver initial submission.
With this patch hinic3 becomes a functional Ethernet driver.

The driver parts contained in this patch:
Memory allocation and initialization of the driver structures.
Management interfaces initialization.
HW capabilities probing, initialization and setup using management
interfaces.
Net device open/stop implementation and data queues initialization.
Register VID:DID in PCI id_table.

Submitted-by: Gur Stavi <gur.stavi@huawei.com>
Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: gongfan <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    | 194 ++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |   4 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 344 +++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  16 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 120 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c | 551 ++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 259 ++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  16 +
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   4 +-
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |   1 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 101 ++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 449 ++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 141 +++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  31 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   5 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    | 870 +++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |  24 +
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |  10 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 356 ++++++-
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 215 ++++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  13 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  93 ++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  12 +
 26 files changed, 3838 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
index 423501b87cbd..db82948804c8 100644
--- a/drivers/net/ethernet/huawei/hinic3/Makefile
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -11,6 +11,7 @@ hinic3-objs := hinic3_hwdev.o \
 	       hinic3_eqs.o \
 	       hinic3_queue_common.o \
 	       hinic3_mbox.o \
+	       hinic3_mgmt.o \
 	       hinic3_hw_comm.o \
 	       hinic3_wq.o \
 	       hinic3_cmdq.o \
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
index 08121b3112cc..a042e003af54 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -8,9 +8,198 @@
 #include "hinic3_mbox.h"
 #include "hinic3_hwif.h"
 
+#define HINIC3_CFG_MAX_QP  256
+#define VECTOR_THRESHOLD   2
+
 #define IS_NIC_TYPE(hwdev) \
 	(((u32)(hwdev)->cfg_mgmt->svc_cap.chip_svc_type) & BIT(SERVICE_T_NIC))
 
+static void parse_pub_res_cap(struct hinic3_hwdev *hwdev,
+			      struct service_cap *cap,
+			      const struct cfg_cmd_dev_cap *dev_cap,
+			      enum func_type type)
+{
+	cap->port_id = dev_cap->port_id;
+	cap->chip_svc_type = dev_cap->svc_cap_en;
+}
+
+static void parse_l2nic_res_cap(struct hinic3_hwdev *hwdev,
+				struct service_cap *cap,
+				const struct cfg_cmd_dev_cap *dev_cap,
+				enum func_type type)
+{
+	struct nic_service_cap *nic_cap = &cap->nic_cap;
+
+	nic_cap->max_sqs = min(dev_cap->nic_max_sq_id + 1, HINIC3_CFG_MAX_QP);
+}
+
+static void parse_dev_cap(struct hinic3_hwdev *hwdev,
+			  const struct cfg_cmd_dev_cap *dev_cap, enum func_type type)
+{
+	struct service_cap *cap = &hwdev->cfg_mgmt->svc_cap;
+
+	/* Public resource */
+	parse_pub_res_cap(hwdev, cap, dev_cap, type);
+
+	/* L2 NIC resource */
+	if (IS_NIC_TYPE(hwdev))
+		parse_l2nic_res_cap(hwdev, cap, dev_cap, type);
+}
+
+static int get_cap_from_fw(struct hinic3_hwdev *hwdev, enum func_type type)
+{
+	struct cfg_cmd_dev_cap dev_cap;
+	u32 out_len = sizeof(dev_cap);
+	int err;
+
+	memset(&dev_cap, 0, sizeof(dev_cap));
+	dev_cap.func_id = hinic3_global_func_id(hwdev);
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, HINIC3_MOD_CFGM,
+				       CFG_CMD_GET_DEV_CAP,
+				       &dev_cap, sizeof(dev_cap),
+				       &dev_cap, &out_len, 0);
+	if (err || dev_cap.head.status || !out_len) {
+		dev_err(hwdev->dev,
+			"Failed to get capability from FW, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, dev_cap.head.status, out_len);
+		return -EIO;
+	}
+
+	parse_dev_cap(hwdev, &dev_cap, type);
+
+	return 0;
+}
+
+static int hinic3_init_irq_info(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	u16 intr_num = hwif->attr.num_irqs;
+	struct cfg_irq_info *irq_info;
+	u16 intr_needed;
+
+	if (!intr_num) {
+		dev_err(hwdev->dev, "Irq num cfg in fw is zero, msix_flex_en %d\n",
+			hwif->attr.msix_flex_en);
+		return -EFAULT;
+	}
+
+	intr_needed = hwif->attr.msix_flex_en ? (hwif->attr.num_aeqs +
+		      hwif->attr.num_ceqs + hwif->attr.num_sq) : intr_num;
+	if (intr_needed > intr_num) {
+		dev_warn(hwdev->dev, "Irq num cfg %d is less than the needed irq num %d msix_flex_en %d\n",
+			 intr_num, intr_needed, hwdev->hwif->attr.msix_flex_en);
+		intr_needed = intr_num;
+	}
+
+	irq_info = &cfg_mgmt->irq_info;
+	irq_info->alloc_info = kcalloc(intr_num, sizeof(*irq_info->alloc_info),
+				       GFP_KERNEL);
+	if (!irq_info->alloc_info)
+		return -ENOMEM;
+
+	irq_info->num_irq_hw = intr_needed;
+	mutex_init(&irq_info->irq_mutex);
+
+	return 0;
+}
+
+static int hinic3_init_irq_alloc_info(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+	struct cfg_irq_alloc_info *irq_alloc_info;
+	u16 nreq = cfg_mgmt->irq_info.num_irq_hw;
+	struct pci_dev *pdev = hwdev->pdev;
+	struct msix_entry *entry;
+	int actual_irq;
+	u16 i;
+
+	irq_alloc_info = cfg_mgmt->irq_info.alloc_info;
+
+	if (!nreq) {
+		dev_err(hwdev->dev, "Number of interrupts must not be zero\n");
+		return -EINVAL;
+	}
+	entry = kcalloc(nreq, sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	for (i = 0; i < nreq; i++)
+		entry[i].entry = i;
+
+	actual_irq = pci_enable_msix_range(pdev, entry, VECTOR_THRESHOLD, nreq);
+	if (actual_irq < 0) {
+		dev_err(hwdev->dev, "Alloc msix entries with threshold 2 failed. actual_irq: %d\n",
+			actual_irq);
+		kfree(entry);
+		return -ENOMEM;
+	}
+
+	nreq = (u16)actual_irq;
+	cfg_mgmt->irq_info.num_irq = nreq;
+
+	for (i = 0; i < nreq; ++i) {
+		irq_alloc_info[i].info.msix_entry_idx = entry[i].entry;
+		irq_alloc_info[i].info.irq_id = entry[i].vector;
+		irq_alloc_info[i].allocated = false;
+	}
+
+	kfree(entry);
+	return 0;
+}
+
+int hinic3_init_cfg_mgmt(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_mgmt_info *cfg_mgmt;
+	int err;
+
+	if (!hwdev->hwif->attr.num_ceqs) {
+		dev_err(hwdev->dev, "Ceq num cfg in fw is zero\n");
+		return -EINVAL;
+	}
+
+	cfg_mgmt = kzalloc(sizeof(*cfg_mgmt), GFP_KERNEL);
+	if (!cfg_mgmt)
+		return -ENOMEM;
+
+	hwdev->cfg_mgmt = cfg_mgmt;
+
+	err = hinic3_init_irq_info(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cfg_irq_info, err: %d\n",
+			err);
+		goto err_undo_cfg_mgmt_alloc;
+	}
+
+	err = hinic3_init_irq_alloc_info(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init irq_alloc_info, err: %d\n",
+			err);
+		goto err_undo_irq_info_alloc;
+	}
+
+	return 0;
+
+err_undo_irq_info_alloc:
+	kfree(cfg_mgmt->irq_info.alloc_info);
+	cfg_mgmt->irq_info.alloc_info = NULL;
+
+err_undo_cfg_mgmt_alloc:
+	kfree(cfg_mgmt);
+	return err;
+}
+
+void hinic3_free_cfg_mgmt(struct hinic3_hwdev *hwdev)
+{
+	struct cfg_mgmt_info *cfg_mgmt = hwdev->cfg_mgmt;
+
+	pci_disable_msix(hwdev->pdev);
+	kfree(cfg_mgmt->irq_info.alloc_info);
+	cfg_mgmt->irq_info.alloc_info = NULL;
+	kfree(cfg_mgmt);
+}
+
 int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
 		      struct irq_info *alloc_arr, u16 *act_num)
 {
@@ -53,6 +242,11 @@ void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id)
 	mutex_unlock(&irq_info->irq_mutex);
 }
 
+int init_capability(struct hinic3_hwdev *hwdev)
+{
+	return get_cap_from_fw(hwdev, TYPE_VF);
+}
+
 bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
 {
 	if (!IS_NIC_TYPE(hwdev))
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
index cef311b8f642..c9616a56b8f4 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
@@ -47,10 +47,14 @@ struct cfg_mgmt_info {
 	struct service_cap  svc_cap;
 };
 
+int hinic3_init_cfg_mgmt(struct hinic3_hwdev *hwdev);
+void hinic3_free_cfg_mgmt(struct hinic3_hwdev *hwdev);
+
 int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
 		      struct irq_info *alloc_arr, u16 *act_num);
 void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id);
 
+int init_capability(struct hinic3_hwdev *hwdev);
 bool hinic3_support_nic(struct hinic3_hwdev *hwdev);
 u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev);
 u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev);
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
index 3147afc8391d..8abb06ec1a17 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -6,6 +6,7 @@
 #include "hinic3_hw_comm.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_mbox.h"
+#include "hinic3_cmdq.h"
 #include "hinic3_hwif.h"
 
 static int comm_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd, const void *buf_in,
@@ -66,3 +67,346 @@ int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
 
 	return 0;
 }
+
+static int hinic3_comm_features_nego(struct hinic3_hwdev *hwdev, u8 opcode, u64 *s_feature,
+				     u16 size)
+{
+	struct comm_cmd_feature_nego feature_nego;
+	u32 out_size = sizeof(feature_nego);
+	int err;
+
+	memset(&feature_nego, 0, sizeof(feature_nego));
+	feature_nego.func_id = hinic3_global_func_id(hwdev);
+	feature_nego.opcode = opcode;
+	if (opcode == MGMT_MSG_CMD_OP_SET)
+		memcpy(feature_nego.s_feature, s_feature, (size * sizeof(u64)));
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_FEATURE_NEGO,
+				    &feature_nego, sizeof(feature_nego),
+				    &feature_nego, &out_size);
+	if (err || !out_size || feature_nego.head.status) {
+		dev_err(hwdev->dev, "Failed to negotiate feature, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, feature_nego.head.status, out_size);
+		return -EINVAL;
+	}
+
+	if (opcode == MGMT_MSG_CMD_OP_GET)
+		memcpy(s_feature, feature_nego.s_feature, (size * sizeof(u64)));
+
+	return 0;
+}
+
+int hinic3_get_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature, u16 size)
+{
+	return hinic3_comm_features_nego(hwdev, MGMT_MSG_CMD_OP_GET, s_feature,
+					 size);
+}
+
+int hinic3_set_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature, u16 size)
+{
+	return hinic3_comm_features_nego(hwdev, MGMT_MSG_CMD_OP_SET, s_feature,
+					 size);
+}
+
+int hinic3_get_global_attr(struct hinic3_hwdev *hwdev, struct comm_global_attr *attr)
+{
+	struct comm_cmd_get_glb_attr get_attr;
+	u32 out_size = sizeof(get_attr);
+	int err;
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_GET_GLOBAL_ATTR,
+				    &get_attr, sizeof(get_attr), &get_attr,
+				    &out_size);
+	if (err || !out_size || get_attr.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to get global attribute, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, get_attr.head.status, out_size);
+		return -EIO;
+	}
+
+	memcpy(attr, &get_attr.attr, sizeof(*attr));
+
+	return 0;
+}
+
+int hinic3_set_func_svc_used_state(struct hinic3_hwdev *hwdev, u16 svc_type, u8 state)
+{
+	struct comm_cmd_func_svc_used_state used_state;
+	u32 out_size = sizeof(used_state);
+	int err;
+
+	memset(&used_state, 0, sizeof(used_state));
+	used_state.func_id = hinic3_global_func_id(hwdev);
+	used_state.svc_type = svc_type;
+	used_state.used_state = state;
+
+	err = comm_msg_to_mgmt_sync(hwdev,
+				    COMM_MGMT_CMD_SET_FUNC_SVC_USED_STATE,
+				    &used_state, sizeof(used_state),
+				    &used_state, &out_size);
+	if (err || !out_size || used_state.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set func service used state, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, used_state.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int hinic3_set_dma_attr_tbl(struct hinic3_hwdev *hwdev, u8 entry_idx, u8 st, u8 at, u8 ph,
+			    u8 no_snooping, u8 tph_en)
+{
+	struct comm_cmd_dma_attr_config dma_attr;
+	u32 out_size = sizeof(dma_attr);
+	int err;
+
+	memset(&dma_attr, 0, sizeof(dma_attr));
+	dma_attr.func_id = hinic3_global_func_id(hwdev);
+	dma_attr.entry_idx = entry_idx;
+	dma_attr.st = st;
+	dma_attr.at = at;
+	dma_attr.ph = ph;
+	dma_attr.no_snooping = no_snooping;
+	dma_attr.tph_en = tph_en;
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_SET_DMA_ATTR, &dma_attr, sizeof(dma_attr),
+				    &dma_attr, &out_size);
+	if (err || !out_size || dma_attr.head.status) {
+		dev_err(hwdev->dev, "Failed to set dma attr, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, dma_attr.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, u16 func_idx, u32 page_size)
+{
+	struct comm_cmd_wq_page_size page_size_info;
+	u32 out_size = sizeof(page_size_info);
+	int err;
+
+	memset(&page_size_info, 0, sizeof(page_size_info));
+	page_size_info.func_id = func_idx;
+	page_size_info.page_size = ilog2(page_size / HINIC3_MIN_PAGE_SIZE);
+	page_size_info.opcode = MGMT_MSG_CMD_OP_SET;
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_CFG_PAGESIZE,
+				    &page_size_info, sizeof(page_size_info),
+				    &page_size_info, &out_size);
+	if (err || !out_size || page_size_info.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set wq page size, err: %d, status: 0x%x, out_size: 0x%0x\n",
+			err, page_size_info.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth)
+{
+	struct comm_cmd_root_ctxt root_ctxt;
+	u32 out_size = sizeof(root_ctxt);
+	int err;
+
+	memset(&root_ctxt, 0, sizeof(root_ctxt));
+	root_ctxt.func_id = hinic3_global_func_id(hwdev);
+
+	root_ctxt.set_cmdq_depth = 1;
+	root_ctxt.cmdq_depth = ilog2(cmdq_depth);
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_SET_VAT, &root_ctxt,
+				    sizeof(root_ctxt), &root_ctxt, &out_size);
+	if (err || !out_size || root_ctxt.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set cmdq depth, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, root_ctxt.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+#define HINIC3_WAIT_CMDQ_IDLE_TIMEOUT    5000
+
+static enum hinic3_wait_return check_cmdq_stop_handler(void *priv_data)
+{
+	struct hinic3_hwdev *hwdev = priv_data;
+	enum hinic3_cmdq_type cmdq_type;
+	struct hinic3_cmdqs *cmdqs;
+
+	cmdqs = hwdev->cmdqs;
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		if (!hinic3_cmdq_idle(&cmdqs->cmdq[cmdq_type]))
+			return WAIT_PROCESS_WAITING;
+	}
+
+	return WAIT_PROCESS_CPL;
+}
+
+static int wait_cmdq_stop(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	enum hinic3_cmdq_type cmdq_type;
+	int err;
+
+	if (!(cmdqs->status & HINIC3_CMDQ_ENABLE))
+		return 0;
+
+	cmdqs->status &= ~HINIC3_CMDQ_ENABLE;
+	err = hinic3_wait_for_timeout(hwdev, check_cmdq_stop_handler,
+				      HINIC3_WAIT_CMDQ_IDLE_TIMEOUT,
+				      USEC_PER_MSEC);
+	if (!err)
+		return 0;
+
+	for (cmdq_type = 0; cmdq_type < cmdqs->cmdq_num; cmdq_type++) {
+		if (!hinic3_cmdq_idle(&cmdqs->cmdq[cmdq_type]))
+			dev_err(hwdev->dev, "Cmdq %d is busy\n", cmdq_type);
+	}
+	cmdqs->status |= HINIC3_CMDQ_ENABLE;
+	return err;
+}
+
+int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev)
+{
+	struct comm_cmd_clear_doorbell clear_db;
+	struct comm_cmd_clear_resource clr_res;
+	struct hinic3_hwif *hwif = hwdev->hwif;
+	u32 out_size = sizeof(clear_db);
+	int ret = 0;
+	int err;
+
+	err = wait_cmdq_stop(hwdev);
+	if (err) {
+		dev_warn(hwdev->dev, "CMDQ is still working, CMDQ timeout value is unreasonable\n");
+		ret = err;
+	}
+
+	hinic3_disable_doorbell(hwif);
+
+	memset(&clear_db, 0, sizeof(clear_db));
+	clear_db.func_id = hwif->attr.func_global_idx;
+	err = comm_msg_to_mgmt_sync(hwdev,  COMM_MGMT_CMD_FLUSH_DOORBELL,
+				    &clear_db, sizeof(clear_db),
+				    &clear_db, &out_size);
+	if (err || !out_size || clear_db.head.status) {
+		dev_warn(hwdev->dev, "Failed to flush doorbell, err: %d, status: 0x%x, out_size: 0x%x\n",
+			 err, clear_db.head.status, out_size);
+		if (err)
+			ret = err;
+		else
+			ret = -EFAULT;
+	}
+
+	/* wait for chip to stop I/O */
+	msleep(100);
+
+	memset(&clr_res, 0, sizeof(clr_res));
+	clr_res.func_id = hwif->attr.func_global_idx;
+	err = hinic3_send_mbox_to_mgmt_no_ack(hwdev, HINIC3_MOD_COMM,
+					      COMM_MGMT_CMD_START_FLUSH,
+					      &clr_res, sizeof(clr_res));
+	if (err) {
+		dev_warn(hwdev->dev, "Failed to notice flush message, err: %d\n",
+			 err);
+		ret = err;
+	}
+
+	hinic3_enable_doorbell(hwif);
+
+	err = hinic3_reinit_cmdq_ctxts(hwdev);
+	if (err) {
+		dev_warn(hwdev->dev, "Failed to reinit cmdq\n");
+		ret = err;
+	}
+
+	return ret;
+}
+
+static int get_hw_rx_buf_size_idx(int rx_buf_sz, u16 *buf_sz_idx)
+{
+	/* Supported RX buffer sizes in bytes. Configured by array index. */
+	static const int supported_sizes[16] = {
+		[0] = 32,     [1] = 64,     [2] = 96,     [3] = 128,
+		[4] = 192,    [5] = 256,    [6] = 384,    [7] = 512,
+		[8] = 768,    [9] = 1024,   [10] = 1536,  [11] = 2048,
+		[12] = 3072,  [13] = 4096,  [14] = 8192,  [15] = 16384,
+	};
+	u16 idx;
+
+	/* Scan from biggest to smallest. Choose supported size that is equal or
+	 * smaller. For smaller value HW will under-utilize posted buffers. For
+	 * bigger value HW may overrun posted buffers.
+	 */
+	idx = ARRAY_SIZE(supported_sizes);
+	while (idx > 0) {
+		idx--;
+		if (supported_sizes[idx] <= rx_buf_sz) {
+			*buf_sz_idx = idx;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+int hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, u32 rq_depth, u32 sq_depth, int rx_buf_sz)
+{
+	struct comm_cmd_root_ctxt root_ctxt;
+	u32 out_size = sizeof(root_ctxt);
+	u16 buf_sz_idx;
+	int err;
+
+	err = get_hw_rx_buf_size_idx(rx_buf_sz, &buf_sz_idx);
+	if (err)
+		return err;
+
+	memset(&root_ctxt, 0, sizeof(root_ctxt));
+	root_ctxt.func_id = hinic3_global_func_id(hwdev);
+
+	root_ctxt.set_cmdq_depth = 0;
+	root_ctxt.cmdq_depth = 0;
+
+	root_ctxt.lro_en = 1;
+
+	root_ctxt.rq_depth  = ilog2(rq_depth);
+	root_ctxt.rx_buf_sz = buf_sz_idx;
+	root_ctxt.sq_depth  = ilog2(sq_depth);
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_SET_VAT,
+				    &root_ctxt, sizeof(root_ctxt),
+				    &root_ctxt, &out_size);
+	if (err || !out_size || root_ctxt.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set root context, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, root_ctxt.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev)
+{
+	struct comm_cmd_root_ctxt root_ctxt;
+	u32 out_size = sizeof(root_ctxt);
+	int err;
+
+	memset(&root_ctxt, 0, sizeof(root_ctxt));
+	root_ctxt.func_id = hinic3_global_func_id(hwdev);
+
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_SET_VAT,
+				    &root_ctxt, sizeof(root_ctxt),
+				    &root_ctxt, &out_size);
+	if (err || !out_size || root_ctxt.head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set root context, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, root_ctxt.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
index 2d747270515e..2a7ef8181939 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -8,6 +8,8 @@
 
 struct hinic3_hwdev;
 
+#define HINIC3_WQ_PAGE_SIZE_ORDER       8
+
 struct interrupt_info {
 	u32 lli_set;
 	u32 interrupt_coalesc_set;
@@ -23,4 +25,18 @@ int hinic3_set_interrupt_cfg_direct(struct hinic3_hwdev *hwdev,
 				    const struct interrupt_info *info);
 int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
 
+int hinic3_get_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature, u16 size);
+int hinic3_set_comm_features(struct hinic3_hwdev *hwdev, u64 *s_feature, u16 size);
+int hinic3_get_global_attr(struct hinic3_hwdev *hwdev, struct comm_global_attr *attr);
+int hinic3_set_func_svc_used_state(struct hinic3_hwdev *hwdev, u16 svc_type, u8 state);
+int hinic3_set_dma_attr_tbl(struct hinic3_hwdev *hwdev, u8 entry_idx, u8 st, u8 at, u8 ph,
+			    u8 no_snooping, u8 tph_en);
+
+int hinic3_set_wq_page_size(struct hinic3_hwdev *hwdev, u16 func_idx, u32 page_size);
+int hinic3_set_cmdq_depth(struct hinic3_hwdev *hwdev, u16 cmdq_depth);
+int hinic3_func_rx_tx_flush(struct hinic3_hwdev *hwdev);
+int hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, u32 rq_depth, u32 sq_depth,
+			 int rx_buf_sz);
+int hinic3_clean_root_ctxt(struct hinic3_hwdev *hwdev);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
index 229256780a0b..39418831a8b9 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -17,6 +17,48 @@ struct mgmt_msg_head {
 	u8 rsvd0[6];
 };
 
+enum cfg_cmd {
+	CFG_CMD_GET_DEV_CAP = 0,
+};
+
+/* Device capabilities, defined by hw */
+struct cfg_cmd_dev_cap {
+	struct mgmt_msg_head head;
+
+	u16                  func_id;
+	u16                  rsvd1;
+
+	/* Public resources */
+	u8                   host_id;
+	u8                   ep_id;
+	u8                   er_id;
+	u8                   port_id;
+
+	u16                  host_total_func;
+	u8                   host_pf_num;
+	u8                   pf_id_start;
+	u16                  host_vf_num;
+	u16                  vf_id_start;
+	u8                   host_oq_id_mask_val;
+	u8                   timer_en;
+	u8                   host_valid_bitmap;
+	u8                   rsvd_host;
+
+	u16                  svc_cap_en;
+	u16                  max_vf;
+	u8                   flexq_en;
+	u8                   valid_cos_bitmap;
+	u8                   port_cos_valid_bitmap;
+	u8                   rsvd2[45];
+
+	/* l2nic */
+	u16                  nic_max_sq_id;
+	u16                  nic_max_rq_id;
+	u16                  nic_default_num_queues;
+
+	u8                   rsvd3[250];
+};
+
 enum hinic3_service_type {
 	SERVICE_T_NIC = 0,
 	SERVICE_T_MAX = 1,
@@ -82,6 +124,10 @@ enum func_reset_type_bits {
 	RESET_TYPE_NIC          = BIT(13),
 };
 
+#define HINIC3_COMM_RESET \
+	(RESET_TYPE_COMM | RESET_TYPE_COMM_CMD_CH | RESET_TYPE_FLUSH | \
+	 RESET_TYPE_MQM | RESET_TYPE_SMF | RESET_TYPE_PF_BW_CFG)
+
 struct comm_cmd_func_reset {
 	struct mgmt_msg_head head;
 	u16                  func_id;
@@ -103,6 +149,46 @@ enum hinic3_cmdq_type {
 	HINIC3_MAX_CMDQ_TYPES = 4
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
+enum hinic3_svc_type {
+	SVC_T_COMM = 0,
+	SVC_T_NIC  = 1,
+};
+
+struct comm_cmd_func_svc_used_state {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  svc_type;
+	u8                   used_state;
+	u8                   rsvd[35];
+};
+
+struct comm_cmd_dma_attr_config {
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
 struct comm_cmd_ceq_ctrl_reg {
 	struct mgmt_msg_head head;
 	u16                  func_id;
@@ -112,6 +198,28 @@ struct comm_cmd_ceq_ctrl_reg {
 	u32                  rsvd1;
 };
 
+struct comm_cmd_wq_page_size {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u8                   opcode;
+	/* real_size=4KB*2^page_size, range(0~20) must be checked by driver */
+	u8                   page_size;
+	u32                  rsvd1;
+};
+
+struct comm_cmd_root_ctxt {
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
 struct cmdq_ctxt_info {
 	u64 curr_wqe_page_pfn;
 	u64 wq_block_pfn;
@@ -125,4 +233,16 @@ struct comm_cmd_cmdq_ctxt {
 	struct cmdq_ctxt_info ctxt;
 };
 
+struct comm_cmd_clear_doorbell {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  rsvd1[3];
+};
+
+struct comm_cmd_clear_resource {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  rsvd1[3];
+};
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
index 014fe4eeed5c..9f5bfb350d6d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -3,22 +3,567 @@
 
 #include "hinic3_hwdev.h"
 #include "hinic3_mbox.h"
+#include "hinic3_cmdq.h"
 #include "hinic3_mgmt.h"
+#include "hinic3_eqs.h"
 #include "hinic3_hw_comm.h"
 #include "hinic3_hwif.h"
+#include "hinic3_csr.h"
+
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
+#define HINIC3_PCIE_ST_DISABLE  0
+#define HINIC3_PCIE_AT_DISABLE  0
+#define HINIC3_PCIE_PH_DISABLE  0
+
+#define PCIE_MSIX_ATTR_ENTRY    0
+
+#define HINIC3_DEAULT_EQ_MSIX_PENDING_LIMIT      0
+#define HINIC3_DEAULT_EQ_MSIX_COALESC_TIMER_CFG  0xFF
+#define HINIC3_DEAULT_EQ_MSIX_RESEND_TIMER_CFG   7
+
+#define HINIC3_HWDEV_WQ_NAME    "hinic3_hardware"
+#define HINIC3_WQ_MAX_REQ       10
+
+enum hinic3_hwdev_init_state {
+	HINIC3_HWDEV_MBOX_INITED = 2,
+	HINIC3_HWDEV_CMDQ_INITED = 3,
+};
+
+static int hinic3_comm_aeqs_init(struct hinic3_hwdev *hwdev)
+{
+	struct irq_info aeq_irqs[HINIC3_MAX_AEQS];
+	u16 num_aeqs, resp_num_irq, i;
+	int err;
+
+	num_aeqs = hwdev->hwif->attr.num_aeqs;
+	if (num_aeqs > HINIC3_MAX_AEQS) {
+		dev_warn(hwdev->dev, "Adjust aeq num to %d\n",
+			 HINIC3_MAX_AEQS);
+		num_aeqs = HINIC3_MAX_AEQS;
+	}
+	err = hinic3_alloc_irqs(hwdev, num_aeqs, aeq_irqs, &resp_num_irq);
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
+	err = hinic3_aeqs_init(hwdev, num_aeqs, aeq_irqs);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init aeqs\n");
+		goto err_aeqs_init;
+	}
+
+	return 0;
+
+err_aeqs_init:
+	for (i = 0; i < num_aeqs; i++)
+		hinic3_free_irq(hwdev, aeq_irqs[i].irq_id);
+
+	return err;
+}
+
+static int hinic3_comm_ceqs_init(struct hinic3_hwdev *hwdev)
+{
+	struct irq_info ceq_irqs[HINIC3_MAX_CEQS];
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
+	err = hinic3_alloc_irqs(hwdev, num_ceqs, ceq_irqs, &resp_num_irq);
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
+	err = hinic3_ceqs_init(hwdev, num_ceqs, ceq_irqs);
+	if (err) {
+		dev_err(hwdev->dev,
+			"Failed to init ceqs, err:%d\n", err);
+		goto err_ceqs_init;
+	}
+
+	return 0;
+
+err_ceqs_init:
+	for (i = 0; i < num_ceqs; i++)
+		hinic3_free_irq(hwdev, ceq_irqs[i].irq_id);
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
+	struct interrupt_info info = {};
+	struct hinic3_eq *eq;
+	u16 q_id;
+	int err;
+
+	info.interrupt_coalesc_set = 1;
+	info.pending_limt = HINIC3_DEAULT_EQ_MSIX_PENDING_LIMIT;
+	info.coalesc_timer_cfg = HINIC3_DEAULT_EQ_MSIX_COALESC_TIMER_CFG;
+	info.resend_timer_cfg = HINIC3_DEAULT_EQ_MSIX_RESEND_TIMER_CFG;
+
+	for (q_id = 0; q_id < aeqs->num_aeqs; q_id++) {
+		eq = &aeqs->aeq[q_id];
+		info.msix_index = eq->eq_irq.msix_entry_idx;
+		err = hinic3_set_interrupt_cfg_direct(hwdev, &info);
+		if (err) {
+			dev_err(hwdev->dev, "Set msix attr for aeq %d failed\n",
+				q_id);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static int init_ceqs_msix_attr(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_ceqs *ceqs = hwdev->ceqs;
+	struct interrupt_info info = {};
+	struct hinic3_eq *eq;
+	u16 q_id;
+	int err;
+
+	info.interrupt_coalesc_set = 1;
+	info.pending_limt = HINIC3_DEAULT_EQ_MSIX_PENDING_LIMIT;
+	info.coalesc_timer_cfg = HINIC3_DEAULT_EQ_MSIX_COALESC_TIMER_CFG;
+	info.resend_timer_cfg = HINIC3_DEAULT_EQ_MSIX_RESEND_TIMER_CFG;
+
+	for (q_id = 0; q_id < ceqs->num_ceqs; q_id++) {
+		eq = &ceqs->ceq[q_id];
+		info.msix_index = eq->eq_irq.msix_entry_idx;
+		err = hinic3_set_interrupt_cfg_direct(hwdev, &info);
+		if (err) {
+			dev_err(hwdev->dev, "Set msix attr for ceq %u failed\n",
+				q_id);
+			return -EFAULT;
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
+		goto err_comm_mbox_init;
+	}
+
+	err = init_aeqs_msix_attr(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init aeqs msix attr\n");
+		goto err_aeqs_msix_attr_init;
+	}
+
+	return 0;
+
+err_aeqs_msix_attr_init:
+	hinic3_comm_mbox_free(hwdev);
+
+err_comm_mbox_init:
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
+	val |= HINIC3_DMA_ATTR_INDIR_IDX_SET(PCIE_MSIX_ATTR_ENTRY, IDX);
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
+	return hinic3_set_dma_attr_tbl(hwdev, PCIE_MSIX_ATTR_ENTRY, HINIC3_PCIE_ST_DISABLE,
+				       HINIC3_PCIE_AT_DISABLE, HINIC3_PCIE_PH_DISABLE,
+				       HINIC3_PCIE_SNOOP, HINIC3_PCIE_TPH_DISABLE);
+}
+
+static int init_basic_attributes(struct hinic3_hwdev *hwdev)
+{
+	struct comm_global_attr glb_attr;
+	int err;
+
+	err = hinic3_func_reset(hwdev, hinic3_global_func_id(hwdev),
+				HINIC3_COMM_RESET);
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
+	err = hinic3_set_func_svc_used_state(hwdev, SVC_T_COMM, 1);
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
+	err = hinic3_set_cmdq_depth(hwdev, HINIC3_CMDQ_DEPTH);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set cmdq depth\n");
+		goto err_set_cmdq_depth;
+	}
+
+	set_bit(HINIC3_HWDEV_CMDQ_INITED, &hwdev->func_state);
+
+	return 0;
+
+err_set_cmdq_depth:
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
+		goto err_undo_ceqs_init;
+	}
+
+	hwdev->wq_page_size = HINIC3_MIN_PAGE_SIZE << HINIC3_WQ_PAGE_SIZE_ORDER;
+	err = hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+				      hwdev->wq_page_size);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set wq page size\n");
+		goto err_undo_ceqs_init;
+	}
+
+	err = hinic3_comm_cmdqs_init(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cmd queues\n");
+		goto err_undo_set_wq_page;
+	}
+
+	return 0;
+
+err_undo_set_wq_page:
+	hinic3_set_wq_page_size(hwdev, hinic3_global_func_id(hwdev),
+				HINIC3_MIN_PAGE_SIZE);
+err_undo_ceqs_init:
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
+		goto err_undo_basic_mgmt_ch;
+
+	err = init_cmdqs_channel(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init cmdq channel\n");
+		goto err_undo_basic_attr;
+	}
+
+	return 0;
+
+err_undo_basic_attr:
+	hinic3_set_func_svc_used_state(hwdev, SVC_T_COMM, 0);
+
+err_undo_basic_mgmt_ch:
+	free_base_mgmt_channel(hwdev);
+
+	return err;
+}
+
+static void hinic3_uninit_comm_ch(struct hinic3_hwdev *hwdev)
+{
+	hinic3_free_cmdqs_channel(hwdev);
+	hinic3_set_func_svc_used_state(hwdev, SVC_T_COMM, 0);
+	free_base_mgmt_channel(hwdev);
+}
+
+static DEFINE_IDA(hinic3_adev_ida);
+
+static int hinic3_adev_idx_alloc(void)
+{
+	return ida_alloc(&hinic3_adev_ida, GFP_KERNEL);
+}
+
+static void hinic3_adev_idx_free(int id)
+{
+	ida_free(&hinic3_adev_ida, id);
+}
+
+static int init_hwdev(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+	struct hinic3_hwdev *hwdev;
+
+	hwdev = kzalloc(sizeof(*hwdev), GFP_KERNEL);
+	if (!hwdev)
+		return -ENOMEM;
+
+	pci_adapter->hwdev = hwdev;
+	hwdev->adapter = pci_adapter;
+	hwdev->pdev = pci_adapter->pdev;
+	hwdev->dev = &pci_adapter->pdev->dev;
+	hwdev->func_state = 0;
+	memset(hwdev->features, 0, sizeof(hwdev->features));
+	hwdev->dev_id = hinic3_adev_idx_alloc();
+	spin_lock_init(&hwdev->channel_lock);
+	return 0;
+}
 
 int hinic3_init_hwdev(struct pci_dev *pdev)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+	struct hinic3_hwdev *hwdev;
+	int err;
+
+	err = init_hwdev(pdev);
+	if (err)
+		return err;
+
+	hwdev = pci_adapter->hwdev;
+	err = hinic3_init_hwif(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init hwif\n");
+		goto err_init_hwif;
+	}
+
+	hwdev->workq = alloc_workqueue(HINIC3_HWDEV_WQ_NAME, WQ_MEM_RECLAIM, HINIC3_WQ_MAX_REQ);
+	if (!hwdev->workq) {
+		dev_err(hwdev->dev, "Failed to alloc hardware workq\n");
+		goto err_alloc_workq;
+	}
+
+	err = hinic3_init_cfg_mgmt(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init config mgmt\n");
+		goto err_init_cfg_mgmt;
+	}
+
+	err = hinic3_init_comm_ch(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init communication channel\n");
+		goto err_init_comm_ch;
+	}
+
+	err = init_capability(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init capability\n");
+		goto err_undo_init_comm_ch;
+	}
+
+	err = hinic3_set_comm_features(hwdev, hwdev->features, COMM_MAX_FEATURE_QWORD);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set comm features\n");
+		goto err_undo_init_comm_ch;
+	}
+
+	return 0;
+
+err_undo_init_comm_ch:
+	hinic3_uninit_comm_ch(hwdev);
+
+err_init_comm_ch:
+	hinic3_free_cfg_mgmt(hwdev);
+
+err_init_cfg_mgmt:
+	destroy_workqueue(hwdev->workq);
+
+err_alloc_workq:
+	hinic3_free_hwif(hwdev);
+
+err_init_hwif:
+	pci_adapter->hwdev = NULL;
+	hinic3_adev_idx_free(hwdev->dev_id);
+	kfree(hwdev);
+
 	return -EFAULT;
 }
 
 void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
 {
-	/* Completed by later submission due to LoC limit. */
+	u64 drv_features[COMM_MAX_FEATURE_QWORD];
+
+	memset(drv_features, 0, sizeof(drv_features));
+	hinic3_set_comm_features(hwdev, drv_features, COMM_MAX_FEATURE_QWORD);
+	hinic3_func_rx_tx_flush(hwdev);
+	hinic3_uninit_comm_ch(hwdev);
+	hinic3_free_cfg_mgmt(hwdev);
+	destroy_workqueue(hwdev->workq);
+	hinic3_free_hwif(hwdev);
+	hinic3_adev_idx_free(hwdev->dev_id);
+	kfree(hwdev);
 }
 
 void hinic3_set_api_stop(struct hinic3_hwdev *hwdev)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_mbox *mbox;
+
+	spin_lock_bh(&hwdev->channel_lock);
+	if (test_bit(HINIC3_HWDEV_MBOX_INITED, &hwdev->func_state)) {
+		mbox = hwdev->mbox;
+		spin_lock(&mbox->mbox_lock);
+		if (mbox->event_flag == EVENT_START)
+			mbox->event_flag = EVENT_TIMEOUT;
+		spin_unlock(&mbox->mbox_lock);
+	}
+
+	if (test_bit(HINIC3_HWDEV_CMDQ_INITED, &hwdev->func_state))
+		hinic3_cmdq_flush_sync_cmd(hwdev);
+
+	spin_unlock_bh(&hwdev->channel_lock);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
index 1cbaf543cb52..52c65af1a0aa 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -10,6 +10,9 @@
 #include "hinic3_hwif.h"
 #include "hinic3_csr.h"
 
+#define HWIF_READY_TIMEOUT          10000
+#define DB_AND_OUTBOUND_EN_TIMEOUT  60000
+
 /* config BAR45 4MB, DB & DWQE both 2MB */
 #define HINIC3_DB_DWQE_SIZE  0x00400000
 
@@ -18,6 +21,41 @@
 #define HINIC3_DWQE_OFFSET   0x00000800ULL
 #define HINIC3_DB_MAX_AREAS  (HINIC3_DB_DWQE_SIZE / HINIC3_DB_PAGE_SIZE)
 
+#define MAX_MSIX_ENTRY       2048
+
+#define HINIC3_AF0_FUNC_GLOBAL_IDX_MASK  GENMASK(11, 0)
+#define HINIC3_AF0_P2P_IDX_MASK          GENMASK(16, 12)
+#define HINIC3_AF0_PCI_INTF_IDX_MASK     GENMASK(19, 17)
+#define HINIC3_AF0_FUNC_TYPE_MASK        BIT(28)
+#define HINIC3_AF0_GET(val, member) \
+	FIELD_GET(HINIC3_AF0_##member##_MASK, val)
+
+#define HINIC3_AF1_AEQS_PER_FUNC_MASK     GENMASK(9, 8)
+#define HINIC3_AF1_MGMT_INIT_STATUS_MASK  BIT(30)
+#define HINIC3_AF1_GET(val, member) \
+	FIELD_GET(HINIC3_AF1_##member##_MASK, val)
+
+#define HINIC3_AF2_CEQS_PER_FUNC_MASK      GENMASK(8, 0)
+#define HINIC3_AF2_IRQS_PER_FUNC_MASK      GENMASK(26, 16)
+#define HINIC3_AF2_GET(val, member) \
+	FIELD_GET(HINIC3_AF2_##member##_MASK, val)
+
+#define HINIC3_AF4_DOORBELL_CTRL_MASK  BIT(0)
+#define HINIC3_AF4_GET(val, member) \
+	FIELD_GET(HINIC3_AF4_##member##_MASK, val)
+#define HINIC3_AF4_SET(val, member) \
+	FIELD_PREP(HINIC3_AF4_##member##_MASK, val)
+
+#define HINIC3_AF5_OUTBOUND_CTRL_MASK  BIT(0)
+#define HINIC3_AF5_GET(val, member) \
+	FIELD_GET(HINIC3_AF5_##member##_MASK, val)
+
+#define HINIC3_AF6_PF_STATUS_MASK     GENMASK(15, 0)
+#define HINIC3_AF6_FUNC_MAX_SQ_MASK   GENMASK(31, 23)
+#define HINIC3_AF6_MSIX_FLEX_EN_MASK  BIT(22)
+#define HINIC3_AF6_GET(val, member) \
+	FIELD_GET(HINIC3_AF6_##member##_MASK, val)
+
 #define HINIC3_GET_REG_ADDR(reg)  ((reg) & (HINIC3_REGS_FLAG_MASK))
 
 static void __iomem *hinic3_reg_addr(struct hinic3_hwif *hwif, u32 reg)
@@ -42,6 +80,137 @@ void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val)
 	writel((__force u32)raw_val, addr);
 }
 
+static enum hinic3_wait_return check_hwif_ready_handler(void *priv_data)
+{
+	struct hinic3_hwdev *hwdev = priv_data;
+	u32 attr1;
+
+	attr1 = hinic3_hwif_read_reg(hwdev->hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+	return HINIC3_AF1_GET(attr1, MGMT_INIT_STATUS) ?
+		WAIT_PROCESS_CPL : WAIT_PROCESS_WAITING;
+}
+
+static int wait_hwif_ready(struct hinic3_hwdev *hwdev)
+{
+	return hinic3_wait_for_timeout(hwdev, check_hwif_ready_handler,
+				       HWIF_READY_TIMEOUT, USEC_PER_MSEC);
+}
+
+/* Init attr struct from HW attr values. */
+static void init_hwif_attr(struct hinic3_func_attr *attr, u32 attr0, u32 attr1,
+			   u32 attr2, u32 attr3, u32 attr6)
+{
+	attr->func_global_idx = HINIC3_AF0_GET(attr0, FUNC_GLOBAL_IDX);
+	attr->port_to_port_idx = HINIC3_AF0_GET(attr0, P2P_IDX);
+	attr->pci_intf_idx = HINIC3_AF0_GET(attr0, PCI_INTF_IDX);
+	attr->func_type = HINIC3_AF0_GET(attr0, FUNC_TYPE);
+
+	attr->num_aeqs = BIT(HINIC3_AF1_GET(attr1, AEQS_PER_FUNC));
+	attr->num_ceqs = (u8)HINIC3_AF2_GET(attr2, CEQS_PER_FUNC);
+	attr->num_irqs = HINIC3_AF2_GET(attr2, IRQS_PER_FUNC);
+	if (attr->num_irqs > MAX_MSIX_ENTRY)
+		attr->num_irqs = MAX_MSIX_ENTRY;
+
+	attr->num_sq = HINIC3_AF6_GET(attr6, FUNC_MAX_SQ);
+	attr->msix_flex_en = HINIC3_AF6_GET(attr6, MSIX_FLEX_EN);
+}
+
+/* Get device attributes from HW. */
+static int get_hwif_attr(struct hinic3_hwdev *hwdev)
+{
+	u32 attr0, attr1, attr2, attr3, attr6;
+	struct hinic3_hwif *hwif;
+
+	hwif = hwdev->hwif;
+	attr0  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR0_ADDR);
+	attr1  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+	attr2  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR2_ADDR);
+	attr3  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR3_ADDR);
+	attr6  = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR6_ADDR);
+	init_hwif_attr(&hwif->attr, attr0, attr1, attr2, attr3, attr6);
+	return 0;
+}
+
+static enum hinic3_doorbell_ctrl hinic3_get_doorbell_ctrl_status(struct hinic3_hwif *hwif)
+{
+	u32 attr4 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR4_ADDR);
+
+	return HINIC3_AF4_GET(attr4, DOORBELL_CTRL);
+}
+
+static enum hinic3_outbound_ctrl hinic3_get_outbound_ctrl_status(struct hinic3_hwif *hwif)
+{
+	u32 attr5 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR5_ADDR);
+
+	return HINIC3_AF5_GET(attr5, OUTBOUND_CTRL);
+}
+
+void hinic3_enable_doorbell(struct hinic3_hwif *hwif)
+{
+	u32 addr, attr4;
+
+	addr = HINIC3_CSR_FUNC_ATTR4_ADDR;
+	attr4 = hinic3_hwif_read_reg(hwif, addr);
+
+	attr4 &= ~HINIC3_AF4_DOORBELL_CTRL_MASK;
+	attr4 |= HINIC3_AF4_SET(ENABLE_DOORBELL, DOORBELL_CTRL);
+
+	hinic3_hwif_write_reg(hwif, addr, attr4);
+}
+
+void hinic3_disable_doorbell(struct hinic3_hwif *hwif)
+{
+	u32 addr, attr4;
+
+	addr = HINIC3_CSR_FUNC_ATTR4_ADDR;
+	attr4 = hinic3_hwif_read_reg(hwif, addr);
+
+	attr4 &= ~HINIC3_AF4_DOORBELL_CTRL_MASK;
+	attr4 |= HINIC3_AF4_SET(DISABLE_DOORBELL, DOORBELL_CTRL);
+
+	hinic3_hwif_write_reg(hwif, addr, attr4);
+}
+
+static int init_hwif(struct hinic3_hwdev *hwdev, void __iomem *cfg_reg_base)
+{
+	struct hinic3_hwif *hwif;
+
+	hwif = kzalloc(sizeof(*hwif), GFP_KERNEL);
+	if (!hwif)
+		return -ENOMEM;
+
+	hwdev->hwif = hwif;
+	hwif->cfg_regs_base = (u8 __iomem *)cfg_reg_base + HINIC3_VF_CFG_REG_OFFSET;
+	return 0;
+}
+
+static int db_area_idx_init(struct hinic3_hwif *hwif, u64 db_base_phy,
+			    u8 __iomem *db_base, u64 db_dwqe_len)
+{
+	struct hinic3_db_area *db_area = &hwif->db_area;
+	u32 db_max_areas;
+
+	hwif->db_base_phy = db_base_phy;
+	hwif->db_base = db_base;
+	hwif->db_dwqe_len = db_dwqe_len;
+
+	db_max_areas = (db_dwqe_len > HINIC3_DB_DWQE_SIZE) ?
+		      HINIC3_DB_MAX_AREAS :
+		      (u32)(db_dwqe_len / HINIC3_DB_PAGE_SIZE);
+	db_area->db_bitmap_array = bitmap_zalloc(db_max_areas, GFP_KERNEL);
+	if (!db_area->db_bitmap_array)
+		return -ENOMEM;
+
+	db_area->db_max_areas = db_max_areas;
+	spin_lock_init(&db_area->idx_lock);
+	return 0;
+}
+
+static void db_area_idx_free(struct hinic3_db_area *db_area)
+{
+	kfree(db_area->db_bitmap_array);
+}
+
 static int get_db_idx(struct hinic3_hwif *hwif, u32 *idx)
 {
 	struct hinic3_db_area *db_area = &hwif->db_area;
@@ -129,6 +298,15 @@ void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 	hinic3_hwif_write_reg(hwif, addr, mask_bits);
 }
 
+static void disable_all_msix(struct hinic3_hwdev *hwdev)
+{
+	u16 num_irqs = hwdev->hwif->attr.num_irqs;
+	u16 i;
+
+	for (i = 0; i < num_irqs; i++)
+		hinic3_set_msix_state(hwdev, i, HINIC3_MSIX_DISABLE);
+}
+
 void hinic3_misx_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
 				       u8 clear_resend_en)
 {
@@ -165,6 +343,87 @@ void hinic3_set_msix_auto_mask_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 	hinic3_hwif_write_reg(hwif, addr, mask_bits);
 }
 
+static enum hinic3_wait_return check_db_outbound_enable_handler(void *priv_data)
+{
+	enum hinic3_outbound_ctrl outbound_ctrl;
+	struct hinic3_hwif *hwif = priv_data;
+	enum hinic3_doorbell_ctrl db_ctrl;
+
+	db_ctrl = hinic3_get_doorbell_ctrl_status(hwif);
+	outbound_ctrl = hinic3_get_outbound_ctrl_status(hwif);
+	if (outbound_ctrl == ENABLE_OUTBOUND && db_ctrl == ENABLE_DOORBELL)
+		return WAIT_PROCESS_CPL;
+
+	return WAIT_PROCESS_WAITING;
+}
+
+static int wait_until_doorbell_and_outbound_enabled(struct hinic3_hwif *hwif)
+{
+	return hinic3_wait_for_timeout(hwif, check_db_outbound_enable_handler,
+				       DB_AND_OUTBOUND_EN_TIMEOUT,
+				       USEC_PER_MSEC);
+}
+
+int hinic3_init_hwif(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
+	struct hinic3_hwif *hwif;
+	u32 attr1, attr4, attr5;
+	int err;
+
+	err = init_hwif(hwdev, pci_adapter->cfg_reg_base);
+	if (err)
+		return err;
+
+	hwif = hwdev->hwif;
+
+	err = db_area_idx_init(hwif, pci_adapter->db_base_phy,
+			       pci_adapter->db_base,
+			       pci_adapter->db_dwqe_len);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init db area.\n");
+		goto err_init_db_area;
+	}
+
+	err = wait_hwif_ready(hwdev);
+	if (err) {
+		attr1 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR1_ADDR);
+		dev_err(hwdev->dev, "Chip status is not ready, attr1:0x%x\n", attr1);
+		goto err_hwif_ready;
+	}
+
+	err = get_hwif_attr(hwdev);
+	if (err) {
+		dev_err(hwdev->dev, "Get hwif attr failed\n");
+		goto err_hwif_ready;
+	}
+
+	err = wait_until_doorbell_and_outbound_enabled(hwif);
+	if (err) {
+		attr4 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR4_ADDR);
+		attr5 = hinic3_hwif_read_reg(hwif, HINIC3_CSR_FUNC_ATTR5_ADDR);
+		dev_err(hwdev->dev, "Hw doorbell/outbound is disabled, attr4 0x%x attr5 0x%x\n",
+			attr4, attr5);
+		goto err_hwif_ready;
+	}
+
+	disable_all_msix(hwdev);
+	return 0;
+
+err_hwif_ready:
+	db_area_idx_free(&hwif->db_area);
+err_init_db_area:
+	kfree(hwif);
+
+	return err;
+}
+
+void hinic3_free_hwif(struct hinic3_hwdev *hwdev)
+{
+	db_area_idx_free(&hwdev->hwif->db_area);
+	kfree(hwdev->hwif);
+}
+
 u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
 {
 	return hwdev->hwif->attr.func_global_idx;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
index ebfaf2c49c3a..5e3d2f135884 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -45,6 +45,16 @@ struct hinic3_hwif {
 	struct hinic3_func_attr attr;
 };
 
+enum hinic3_outbound_ctrl {
+	ENABLE_OUTBOUND  = 0x0,
+	DISABLE_OUTBOUND = 0x1,
+};
+
+enum hinic3_doorbell_ctrl {
+	ENABLE_DOORBELL  = 0,
+	DISABLE_DOORBELL = 1,
+};
+
 enum hinic3_msix_state {
 	HINIC3_MSIX_ENABLE,
 	HINIC3_MSIX_DISABLE,
@@ -58,11 +68,17 @@ enum hinic3_msix_auto_mask {
 u32 hinic3_hwif_read_reg(struct hinic3_hwif *hwif, u32 reg);
 void hinic3_hwif_write_reg(struct hinic3_hwif *hwif, u32 reg, u32 val);
 
+void hinic3_disable_doorbell(struct hinic3_hwif *hwif);
+void hinic3_enable_doorbell(struct hinic3_hwif *hwif);
+
 int hinic3_alloc_db_addr(struct hinic3_hwdev *hwdev, void __iomem **db_base,
 			 void __iomem **dwqe_base);
 void hinic3_free_db_addr(struct hinic3_hwdev *hwdev, const void __iomem *db_base,
 			 void __iomem *dwqe_base);
 
+int hinic3_init_hwif(struct hinic3_hwdev *hwdev);
+void hinic3_free_hwif(struct hinic3_hwdev *hwdev);
+
 void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,
 			   enum hinic3_msix_state flag);
 void hinic3_misx_intr_clear_resend_bit(struct hinic3_hwdev *hwdev, u16 msix_idx,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
index 526b4a9aecf4..a8371c94ec6a 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -6,6 +6,7 @@
 #include "hinic3_lld.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hw_cfg.h"
+#include "hinic3_pci_id_tbl.h"
 #include "hinic3_mgmt.h"
 
 #define HINIC3_VF_PCI_CFG_REG_BAR  0
@@ -307,6 +308,7 @@ static void hinic3_func_deinit(struct pci_dev *pdev)
 {
 	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
 
+	hinic3_flush_mgmt_workq(pci_adapter->hwdev);
 	hinic3_detach_aux_devices(pci_adapter->hwdev);
 	hinic3_free_hwdev(pci_adapter->hwdev);
 }
@@ -378,7 +380,7 @@ static void hinic3_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id hinic3_pci_table[] = {
-	/* Completed by later submission due to LoC limit. */
+	{PCI_VDEVICE(HUAWEI, PCI_DEV_ID_HINIC3_VF), 0},
 	{0, 0}
 
 };
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
new file mode 100644
index 000000000000..9271dac53761
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include "hinic3_mgmt.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_eqs.h"
+#include "hinic3_mbox.h"
+
+void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev)
+{
+	if (hwdev->aeqs)
+		flush_workqueue(hwdev->aeqs->workq);
+}
+
+void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header, u8 size)
+{
+	if ((HINIC3_MSG_HEADER_GET(*(u64 *)header, SOURCE) ==
+	     HINIC3_MSG_FROM_MBOX)) {
+		hinic3_mbox_func_aeqe_handler(hwdev, header, size);
+	}
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
index 9e044a8a81b5..327f3ca55b89 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
@@ -9,5 +9,6 @@
 struct hinic3_hwdev;
 
 void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev);
+void hinic3_mgmt_msg_aeqe_handler(struct hinic3_hwdev *hwdev, u8 *header, u8 size);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index 1ab9e09a3d2b..dd4ce334e687 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -83,12 +83,105 @@ struct hinic3_port_mac_update {
 	u8                          new_mac[ETH_ALEN];
 };
 
+struct hinic3_cmd_cons_idx_attr {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_idx;
+	u8                          dma_attr_off;
+	u8                          pending_limit;
+	u8                          coalescing_time;
+	u8                          intr_en;
+	u16                         intr_idx;
+	u32                         l2nic_sqn;
+	u32                         rsvd;
+	u64                         ci_addr;
+};
+
+struct hinic3_cmd_clear_qp_resource {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_id;
+	u16                         rsvd1;
+};
+
 struct hinic3_force_pkt_drop {
 	struct hinic3_mgmt_msg_head msg_head;
 	u8                          port;
 	u8                          rsvd1[3];
 };
 
+struct hinic3_vport_state {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_id;
+	u16                         rsvd1;
+	/* 0--disable, 1--enable */
+	u8                          state;
+	u8                          rsvd2[3];
+};
+
+/* IEEE 802.1Qaz std */
+#define NIC_DCB_COS_MAX      0x8
+
+struct hinic3_cmd_set_dcb_state {
+	struct hinic3_mgmt_msg_head head;
+	u16                         func_id;
+	/* 0 - get dcb state, 1 - set dcb state */
+	u8                          op_code;
+	/* 0 - disable, 1 - enable dcb */
+	u8                          state;
+	/* 0 - disable, 1 - enable dcb */
+	u8                          port_state;
+	u8                          rsvd[7];
+};
+
+#define HINIC3_RSS_TYPE_VALID_MASK         BIT(23)
+#define HINIC3_RSS_TYPE_TCP_IPV6_EXT_MASK  BIT(24)
+#define HINIC3_RSS_TYPE_IPV6_EXT_MASK      BIT(25)
+#define HINIC3_RSS_TYPE_TCP_IPV6_MASK      BIT(26)
+#define HINIC3_RSS_TYPE_IPV6_MASK          BIT(27)
+#define HINIC3_RSS_TYPE_TCP_IPV4_MASK      BIT(28)
+#define HINIC3_RSS_TYPE_IPV4_MASK          BIT(29)
+#define HINIC3_RSS_TYPE_UDP_IPV6_MASK      BIT(30)
+#define HINIC3_RSS_TYPE_UDP_IPV4_MASK      BIT(31)
+#define HINIC3_RSS_TYPE_SET(val, member)  \
+	FIELD_PREP(HINIC3_RSS_TYPE_##member##_MASK, val)
+#define HINIC3_RSS_TYPE_GET(val, member)  \
+	FIELD_GET(HINIC3_RSS_TYPE_##member##_MASK, val)
+
+#define NIC_RSS_INDIR_SIZE  256
+#define NIC_RSS_KEY_SIZE    40
+
+struct hinic3_rss_context_table {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_id;
+	u16                         rsvd1;
+	u32                         context;
+};
+
+struct hinic3_cmd_rss_engine_type {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_id;
+	u8                          opcode;
+	u8                          hash_engine;
+	u8                          rsvd1[4];
+};
+
+struct hinic3_cmd_rss_hash_key {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_id;
+	u8                          opcode;
+	u8                          rsvd1;
+	u8                          key[NIC_RSS_KEY_SIZE];
+};
+
+struct hinic3_cmd_rss_config {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_id;
+	u8                          rss_en;
+	u8                          rq_priority_number;
+	u8                          prio_tc[NIC_DCB_COS_MAX];
+	u16                         num_qps;
+	u16                         rsvd1;
+};
+
 /* Commands between NIC to fw */
 enum hinic3_nic_cmd {
 	/* FUNC CFG */
@@ -106,6 +199,14 @@ enum hinic3_nic_cmd {
 	HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC = 65,
 	HINIC3_NIC_CMD_QOS_DCB_STATE             = 110,
 	HINIC3_NIC_CMD_FORCE_PKT_DROP            = 113,
+	HINIC3_NIC_CMD_MAX                       = 256,
+};
+
+/* NIC CMDQ MODE */
+enum hinic3_ucode_cmd {
+	HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX    = 0,
+	HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT = 1,
+	HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE = 4,
 };
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index d02dd714ce2e..5932b1486624 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -12,16 +12,457 @@
 #include "hinic3_rss.h"
 #include "hinic3_hwif.h"
 
+/* try to modify the number of irq to the target number,
+ * and return the actual number of irq.
+ */
+static u16 hinic3_qp_irq_change(struct net_device *netdev,
+				u16 dst_num_qp_irq)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 resp_irq_num, irq_num_gap, i;
+	struct irq_info *qps_irq_info;
+	u16 idx;
+	int err;
+
+	qps_irq_info = nic_dev->qps_irq_info;
+	if (dst_num_qp_irq > nic_dev->num_qp_irq) {
+		irq_num_gap = dst_num_qp_irq - nic_dev->num_qp_irq;
+		err = hinic3_alloc_irqs(nic_dev->hwdev, irq_num_gap,
+					&qps_irq_info[nic_dev->num_qp_irq],
+					&resp_irq_num);
+		if (err) {
+			netdev_err(netdev, "Failed to alloc irqs\n");
+			return nic_dev->num_qp_irq;
+		}
+
+		nic_dev->num_qp_irq += resp_irq_num;
+	} else if (dst_num_qp_irq < nic_dev->num_qp_irq) {
+		irq_num_gap = nic_dev->num_qp_irq - dst_num_qp_irq;
+		for (i = 0; i < irq_num_gap; i++) {
+			idx = (nic_dev->num_qp_irq - i) - 1;
+			hinic3_free_irq(nic_dev->hwdev,
+					qps_irq_info[idx].irq_id);
+			qps_irq_info[idx].irq_id = 0;
+			qps_irq_info[idx].msix_entry_idx = 0;
+		}
+		nic_dev->num_qp_irq = dst_num_qp_irq;
+	}
+
+	return nic_dev->num_qp_irq;
+}
+
+static void hinic3_config_num_qps(struct net_device *netdev,
+				  struct hinic3_dyna_txrxq_params *q_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 alloc_num_irq, cur_num_irq;
+	u16 dst_num_irq;
+
+	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
+		q_params->num_qps = 1;
+
+	if (nic_dev->num_qp_irq >= q_params->num_qps)
+		goto out;
+
+	cur_num_irq = nic_dev->num_qp_irq;
+
+	alloc_num_irq = hinic3_qp_irq_change(netdev, q_params->num_qps);
+	if (alloc_num_irq < q_params->num_qps) {
+		q_params->num_qps = alloc_num_irq;
+		netdev_warn(netdev, "Can not get enough irqs, adjust num_qps to %u\n",
+			    q_params->num_qps);
+
+		/* The current irq may be in use, we must keep it */
+		dst_num_irq = max_t(u16, cur_num_irq, q_params->num_qps);
+		hinic3_qp_irq_change(netdev, dst_num_irq);
+	}
+
+out:
+	netdev_dbg(netdev, "Finally num_qps: %u\n", q_params->num_qps);
+}
+
+static int hinic3_setup_num_qps(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u32 irq_size;
+
+	nic_dev->num_qp_irq = 0;
+
+	irq_size = sizeof(*nic_dev->qps_irq_info) * nic_dev->max_qps;
+	if (!irq_size) {
+		netdev_err(netdev, "Cannot allocate zero size entries\n");
+		return -EINVAL;
+	}
+	nic_dev->qps_irq_info = kzalloc(irq_size, GFP_KERNEL);
+	if (!nic_dev->qps_irq_info)
+		return -ENOMEM;
+
+	hinic3_config_num_qps(netdev, &nic_dev->q_params);
+
+	return 0;
+}
+
+static void hinic3_destroy_num_qps(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i;
+
+	for (i = 0; i < nic_dev->num_qp_irq; i++)
+		hinic3_free_irq(nic_dev->hwdev,
+				nic_dev->qps_irq_info[i].irq_id);
+
+	kfree(nic_dev->qps_irq_info);
+}
+
+static int hinic3_alloc_txrxq_resources(struct net_device *netdev,
+					struct hinic3_dyna_txrxq_params *q_params)
+{
+	u32 size;
+	int err;
+
+	size = sizeof(*q_params->txqs_res) * q_params->num_qps;
+	q_params->txqs_res = kzalloc(size, GFP_KERNEL);
+	if (!q_params->txqs_res)
+		return -ENOMEM;
+
+	size = sizeof(*q_params->rxqs_res) * q_params->num_qps;
+	q_params->rxqs_res = kzalloc(size, GFP_KERNEL);
+	if (!q_params->rxqs_res) {
+		err = -ENOMEM;
+		goto err_alloc_rxqs_res_arr;
+	}
+
+	size = sizeof(*q_params->irq_cfg) * q_params->num_qps;
+	q_params->irq_cfg = kzalloc(size, GFP_KERNEL);
+	if (!q_params->irq_cfg) {
+		err = -ENOMEM;
+		goto err_alloc_irq_cfg;
+	}
+
+	err = hinic3_alloc_txqs_res(netdev, q_params->num_qps,
+				    q_params->sq_depth, q_params->txqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc txqs resource\n");
+		goto err_alloc_txqs_res;
+	}
+
+	err = hinic3_alloc_rxqs_res(netdev, q_params->num_qps,
+				    q_params->rq_depth, q_params->rxqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc rxqs resource\n");
+		goto err_alloc_rxqs_res;
+	}
+
+	return 0;
+
+err_alloc_rxqs_res:
+	hinic3_free_txqs_res(netdev, q_params->num_qps, q_params->sq_depth,
+			     q_params->txqs_res);
+
+err_alloc_txqs_res:
+	kfree(q_params->irq_cfg);
+	q_params->irq_cfg = NULL;
+
+err_alloc_irq_cfg:
+	kfree(q_params->rxqs_res);
+	q_params->rxqs_res = NULL;
+
+err_alloc_rxqs_res_arr:
+	kfree(q_params->txqs_res);
+	q_params->txqs_res = NULL;
+
+	return err;
+}
+
+static void hinic3_free_txrxq_resources(struct net_device *netdev,
+					struct hinic3_dyna_txrxq_params *q_params)
+{
+	hinic3_free_rxqs_res(netdev, q_params->num_qps, q_params->rq_depth,
+			     q_params->rxqs_res);
+	hinic3_free_txqs_res(netdev, q_params->num_qps, q_params->sq_depth,
+			     q_params->txqs_res);
+
+	kfree(q_params->irq_cfg);
+	q_params->irq_cfg = NULL;
+
+	kfree(q_params->rxqs_res);
+	q_params->rxqs_res = NULL;
+
+	kfree(q_params->txqs_res);
+	q_params->txqs_res = NULL;
+}
+
+static int hinic3_configure_txrxqs(struct net_device *netdev,
+				   struct hinic3_dyna_txrxq_params *q_params)
+{
+	int err;
+
+	err = hinic3_configure_txqs(netdev, q_params->num_qps,
+				    q_params->sq_depth, q_params->txqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to configure txqs\n");
+		return err;
+	}
+
+	err = hinic3_configure_rxqs(netdev, q_params->num_qps,
+				    q_params->rq_depth, q_params->rxqs_res);
+	if (err) {
+		netdev_err(netdev, "Failed to configure rxqs\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static int hinic3_configure(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_set_port_mtu(netdev, (u16)netdev->mtu);
+	if (err) {
+		netdev_err(netdev, "Failed to set mtu\n");
+		return err;
+	}
+
+	/* Ensure DCB is disabled */
+	hinic3_sync_dcb_state(nic_dev->hwdev, 1, 0);
+
+	if (test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		err = hinic3_rss_init(netdev);
+		if (err) {
+			netdev_err(netdev, "Failed to init rss\n");
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static void hinic3_remove_configure(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
+		hinic3_rss_deinit(netdev);
+}
+
+static int hinic3_alloc_channel_resources(struct net_device *netdev,
+					  struct hinic3_dyna_qp_params *qp_params,
+					  struct hinic3_dyna_txrxq_params *trxq_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	qp_params->num_qps = trxq_params->num_qps;
+	qp_params->sq_depth = trxq_params->sq_depth;
+	qp_params->rq_depth = trxq_params->rq_depth;
+
+	err = hinic3_alloc_qps(nic_dev, qp_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc qps\n");
+		return err;
+	}
+
+	err = hinic3_alloc_txrxq_resources(netdev, trxq_params);
+	if (err) {
+		netdev_err(netdev, "Failed to alloc txrxq resources\n");
+		hinic3_free_qps(nic_dev, qp_params);
+		return err;
+	}
+
+	return 0;
+}
+
+static void hinic3_free_channel_resources(struct net_device *netdev,
+					  struct hinic3_dyna_qp_params *qp_params,
+					  struct hinic3_dyna_txrxq_params *trxq_params)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_free_txrxq_resources(netdev, trxq_params);
+	hinic3_free_qps(nic_dev, qp_params);
+}
+
+static int hinic3_open_channel(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_init_qp_ctxts(nic_dev);
+	if (err) {
+		netdev_err(netdev, "Failed to init qps\n");
+		return err;
+	}
+
+	err = hinic3_configure_txrxqs(netdev, &nic_dev->q_params);
+	if (err) {
+		netdev_err(netdev, "Failed to configure txrxqs\n");
+		goto err_cfg_txrxqs;
+	}
+
+	err = hinic3_qps_irq_init(netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to init txrxq irq\n");
+		goto err_cfg_txrxqs;
+	}
+
+	err = hinic3_configure(netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to init txrxq irq\n");
+		goto err_configure;
+	}
+
+	return 0;
+
+err_configure:
+	hinic3_qps_irq_deinit(netdev);
+
+err_cfg_txrxqs:
+	hinic3_free_qp_ctxts(nic_dev);
+
+	return err;
+}
+
+static void hinic3_close_channel(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_remove_configure(netdev);
+	hinic3_qps_irq_deinit(netdev);
+	hinic3_free_qp_ctxts(nic_dev);
+}
+
+static int hinic3_vport_up(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	bool link_status_up;
+	u16 glb_func_id;
+	int err;
+
+	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
+	err = hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, true);
+	if (err) {
+		netdev_err(netdev, "Failed to enable vport\n");
+		goto err_vport_enable;
+	}
+
+	netif_set_real_num_tx_queues(netdev, nic_dev->q_params.num_qps);
+	netif_set_real_num_rx_queues(netdev, nic_dev->q_params.num_qps);
+	netif_tx_wake_all_queues(netdev);
+
+	err = hinic3_get_link_status(nic_dev->hwdev, &link_status_up);
+	if (!err && link_status_up)
+		netif_carrier_on(netdev);
+
+	return 0;
+
+err_vport_enable:
+	hinic3_flush_qps_res(nic_dev->hwdev);
+	/* wait to guarantee that no packets will be sent to host */
+	msleep(100);
+
+	return err;
+}
+
+static void hinic3_vport_down(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 glb_func_id;
+
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+
+	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
+	hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
+
+	hinic3_flush_txqs(netdev);
+	/* wait to guarantee that no packets will be sent to host */
+	msleep(100);
+	hinic3_flush_qps_res(nic_dev->hwdev);
+}
+
 static int hinic3_open(struct net_device *netdev)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_qp_params qp_params;
+	int err;
+
+	if (test_bit(HINIC3_INTF_UP, &nic_dev->flags)) {
+		netdev_dbg(netdev, "Netdev already open, do nothing\n");
+		return 0;
+	}
+
+	err = hinic3_init_nicio_res(nic_dev);
+	if (err) {
+		netdev_err(netdev, "Failed to init nicio resources\n");
+		return err;
+	}
+
+	err = hinic3_setup_num_qps(netdev);
+	if (err) {
+		netdev_err(netdev, "Failed to setup num_qps\n");
+		goto err_setup_qps;
+	}
+
+	err = hinic3_alloc_channel_resources(netdev, &qp_params,
+					     &nic_dev->q_params);
+	if (err)
+		goto err_alloc_channel_res;
+
+	hinic3_init_qps(nic_dev, &qp_params);
+
+	err = hinic3_open_channel(netdev);
+	if (err)
+		goto err_open_channel;
+
+	err = hinic3_vport_up(netdev);
+	if (err)
+		goto err_vport_up;
+
+	set_bit(HINIC3_INTF_UP, &nic_dev->flags);
+
+	return 0;
+
+err_vport_up:
+	hinic3_close_channel(netdev);
+
+err_open_channel:
+	hinic3_deinit_qps(nic_dev, &qp_params);
+	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
+
+err_alloc_channel_res:
+	hinic3_destroy_num_qps(netdev);
+
+err_setup_qps:
+	hinic3_deinit_nicio_res(nic_dev);
+
+	return err;
 }
 
 static int hinic3_close(struct net_device *netdev)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_qp_params qp_params;
+
+	if (!test_and_clear_bit(HINIC3_INTF_UP, &nic_dev->flags)) {
+		netdev_dbg(netdev, "Netdev already close, do nothing\n");
+		return 0;
+	}
+
+	if (test_and_clear_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags))
+		goto out;
+
+	hinic3_vport_down(netdev);
+	hinic3_close_channel(netdev);
+	hinic3_deinit_qps(nic_dev, &qp_params);
+	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
+
+out:
+	hinic3_deinit_nicio_res(nic_dev);
+	hinic3_destroy_num_qps(netdev);
+
+	return 0;
 }
 
 static int hinic3_change_mtu(struct net_device *netdev, int new_mtu)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
index 22db923101e2..732e1a2420a5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -45,6 +45,12 @@ static int nic_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode, u64 *s_featur
 	return 0;
 }
 
+int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev)
+{
+	return nic_feature_nego(nic_dev->hwdev, HINIC3_CMD_OP_GET,
+				&nic_dev->nic_io->feature_cap, 1);
+}
+
 int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev)
 {
 	return nic_feature_nego(nic_dev->hwdev, HINIC3_CMD_OP_SET,
@@ -89,6 +95,19 @@ static int hinic3_set_function_table(struct hinic3_hwdev *hwdev, u32 cfg_bitmap,
 	return 0;
 }
 
+int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_func_tbl_cfg func_tbl_cfg;
+	u32 cfg_bitmap;
+
+	func_tbl_cfg.mtu = 0x3FFF; /* default, max mtu */
+	func_tbl_cfg.rx_wqe_buf_size = nic_io->rx_buff_len;
+
+	cfg_bitmap = BIT(FUNC_CFG_INIT) | BIT(FUNC_CFG_MTU) | BIT(FUNC_CFG_RX_BUF_SIZE);
+	return hinic3_set_function_table(nic_dev->hwdev, cfg_bitmap, &func_tbl_cfg);
+}
+
 int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -231,6 +250,60 @@ int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac, u8 *new_mac
 	return 0;
 }
 
+int hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr *attr)
+{
+	struct hinic3_cmd_cons_idx_attr cons_idx_attr;
+	u32 out_size = sizeof(cons_idx_attr);
+	int err;
+
+	memset(&cons_idx_attr, 0, sizeof(cons_idx_attr));
+	cons_idx_attr.func_idx = hinic3_global_func_id(hwdev);
+	cons_idx_attr.dma_attr_off  = attr->dma_attr_off;
+	cons_idx_attr.pending_limit = attr->pending_limit;
+	cons_idx_attr.coalescing_time  = attr->coalescing_time;
+
+	if (attr->intr_en) {
+		cons_idx_attr.intr_en = attr->intr_en;
+		cons_idx_attr.intr_idx = attr->intr_idx;
+	}
+
+	cons_idx_attr.l2nic_sqn = attr->l2nic_sqn;
+	cons_idx_attr.ci_addr = attr->ci_dma_base;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SQ_CI_ATTR_SET,
+				     &cons_idx_attr, sizeof(cons_idx_attr),
+				     &cons_idx_attr, &out_size);
+	if (err || !out_size || cons_idx_attr.msg_head.status) {
+		dev_err(hwdev->dev,
+			"Failed to set ci attribute table, err: %d, status: 0x%x, out_size: 0x%x\n",
+			err, cons_idx_attr.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_cmd_clear_qp_resource sq_res;
+	u32 out_size = sizeof(sq_res);
+	int err;
+
+	memset(&sq_res, 0, sizeof(sq_res));
+	sq_res.func_id = hinic3_global_func_id(hwdev);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_CLEAR_QP_RESOURCE,
+				     &sq_res, sizeof(sq_res), &sq_res,
+				     &out_size);
+	if (err || !out_size || sq_res.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to clear sq resources, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, sq_res.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
 {
 	struct hinic3_force_pkt_drop pkt_drop;
@@ -252,3 +325,71 @@ int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
 
 	return pkt_drop.msg_head.status;
 }
+
+int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state)
+{
+	struct hinic3_cmd_set_dcb_state dcb_state;
+	u32 out_size = sizeof(dcb_state);
+	int err;
+
+	memset(&dcb_state, 0, sizeof(dcb_state));
+	dcb_state.op_code = op_code;
+	dcb_state.state = state;
+	dcb_state.func_id = hinic3_global_func_id(hwdev);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_QOS_DCB_STATE,
+				     &dcb_state, sizeof(dcb_state), &dcb_state, &out_size);
+	if (err || dcb_state.head.status || !out_size) {
+		dev_err(hwdev->dev,
+			"Failed to set dcb state, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, dcb_state.head.status, out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up)
+{
+	struct mag_cmd_get_link_status get_link;
+	u32 out_size = sizeof(get_link);
+	int err;
+
+	memset(&get_link, 0, sizeof(get_link));
+	get_link.port_id = hinic3_physical_port_id(hwdev);
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, HINIC3_MOD_HILINK,
+				       MAG_CMD_GET_LINK_STATUS, &get_link,
+				       sizeof(get_link), &get_link, &out_size, 0);
+	if (err || !out_size || get_link.head.status) {
+		dev_err(hwdev->dev, "Failed to get link state, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, get_link.head.status, out_size);
+		return -EIO;
+	}
+
+	*link_status_up = !!get_link.status;
+
+	return 0;
+}
+
+int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id, bool enable)
+{
+	struct hinic3_vport_state en_state;
+	u32 out_size = sizeof(en_state);
+	int err;
+
+	memset(&en_state, 0, sizeof(en_state));
+	en_state.func_id = func_id;
+	en_state.state = enable ? 1 : 0;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_VPORT_ENABLE,
+				     &en_state, sizeof(en_state),
+				     &en_state, &out_size);
+	if (err || !out_size || en_state.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set vport state, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, en_state.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
index 00456994e55c..3df4bf3c6584 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -24,15 +24,40 @@ enum hinic3_nic_event_type {
 	EVENT_NIC_LINK_UP = 1,
 };
 
+struct hinic3_sq_attr {
+	u8  dma_attr_off;
+	u8  pending_limit;
+	u8  coalescing_time;
+	u8  intr_en;
+	u16 intr_idx;
+	u32 l2nic_sqn;
+	u64 ci_dma_base;
+};
+
+enum mag_cmd {
+	MAG_CMD_GET_LINK_STATUS        = 7,
+};
+
+/* firmware also use this cmd report link event to driver */
+struct mag_cmd_get_link_status {
+	struct mgmt_msg_head head;
+	u8                   port_id;
+	/* 0:link down  1:link up */
+	u8                   status;
+	u8                   rsvd0[2];
+};
+
 int l2nic_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd,
 			   const void *buf_in, u32 in_size,
 			   void *buf_out, u32 *out_size);
 
+int hinic3_get_nic_feature_from_hw(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev);
 bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
 			 enum nic_feature_cap feature_bits);
 void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap);
 
+int hinic3_init_function_table(struct hinic3_nic_dev *nic_dev);
 int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu);
 
 int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id);
@@ -40,6 +65,12 @@ int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id,
 int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac, u8 *new_mac, u16 vlan_id,
 		      u16 func_id);
 
+int hinic3_set_ci_table(struct hinic3_hwdev *hwdev, struct hinic3_sq_attr *attr);
+int hinic3_flush_qps_res(struct hinic3_hwdev *hwdev);
 int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev);
 
+int hinic3_sync_dcb_state(struct hinic3_hwdev *hwdev, u8 op_code, u8 state);
+int hinic3_get_link_status(struct hinic3_hwdev *hwdev, bool *link_status_up);
+int hinic3_set_vport_enable(struct hinic3_hwdev *hwdev, u16 func_id, bool enable);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 86857cc920b6..c4e6c3537215 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -36,6 +36,11 @@ struct nic_rss_type {
 	u8 udp_ipv4;
 };
 
+struct nic_rss_indirect_tbl_set {
+	u32 rsvd[4];
+	u16 entry[NIC_RSS_INDIR_SIZE];
+};
+
 struct hinic3_irq {
 	struct net_device  *netdev;
 	u16                msix_entry_idx;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
index fe79bf8013b9..e1d9dbdc01c6 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
@@ -5,17 +5,881 @@
 #include "hinic3_hwdev.h"
 #include "hinic3_nic_cfg.h"
 #include "hinic3_nic_dev.h"
+#include "hinic3_cmdq.h"
 #include "hinic3_hw_comm.h"
 #include "hinic3_hw_intf.h"
 #include "hinic3_hwif.h"
 
+#define HINIC3_DEAULT_TX_CI_PENDING_LIMIT    1
+#define HINIC3_DEAULT_TX_CI_COALESCING_TIME  1
+#define HINIC3_DEAULT_DROP_THD_ON            (0xFFFF)
+#define HINIC3_DEAULT_DROP_THD_OFF           0
+
+#define HINIC3_CI_Q_ADDR_SIZE                (64)
+
+#define CI_TABLE_SIZE(num_qps)  \
+	(ALIGN((num_qps) * HINIC3_CI_Q_ADDR_SIZE, HINIC3_MIN_PAGE_SIZE))
+
+#define HINIC3_CI_VADDR(base_addr, q_id)  \
+	((u8 *)(base_addr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)
+
+#define HINIC3_CI_PADDR(base_paddr, q_id)  \
+	((base_paddr) + (q_id) * HINIC3_CI_Q_ADDR_SIZE)
+
+#define SQ_WQ_PREFETCH_MAX        1
+#define SQ_WQ_PREFETCH_MIN        1
+#define SQ_WQ_PREFETCH_THRESHOLD  16
+
+#define RQ_WQ_PREFETCH_MAX        4
+#define RQ_WQ_PREFETCH_MIN        1
+#define RQ_WQ_PREFETCH_THRESHOLD  256
+
+/* (2048 - 8) / 64 */
+#define HINIC3_Q_CTXT_MAX         31
+
+enum hinic3_qp_ctxt_type {
+	HINIC3_QP_CTXT_TYPE_SQ = 0,
+	HINIC3_QP_CTXT_TYPE_RQ = 1,
+};
+
+struct hinic3_qp_ctxt_hdr {
+	u16 num_queues;
+	u16 queue_type;
+	u16 start_qid;
+	u16 rsvd;
+};
+
+struct hinic3_sq_ctxt {
+	u32 ci_pi;
+	u32 drop_mode_sp;
+	u32 wq_pfn_hi_owner;
+	u32 wq_pfn_lo;
+
+	u32 rsvd0;
+	u32 pkt_drop_thd;
+	u32 global_sq_id;
+	u32 vlan_ceq_attr;
+
+	u32 pref_cache;
+	u32 pref_ci_owner;
+	u32 pref_wq_pfn_hi_ci;
+	u32 pref_wq_pfn_lo;
+
+	u32 rsvd8;
+	u32 rsvd9;
+	u32 wq_block_pfn_hi;
+	u32 wq_block_pfn_lo;
+};
+
+struct hinic3_rq_ctxt {
+	u32 ci_pi;
+	u32 ceq_attr;
+	u32 wq_pfn_hi_type_owner;
+	u32 wq_pfn_lo;
+
+	u32 rsvd[3];
+	u32 cqe_sge_len;
+
+	u32 pref_cache;
+	u32 pref_ci_owner;
+	u32 pref_wq_pfn_hi_ci;
+	u32 pref_wq_pfn_lo;
+
+	u32 pi_paddr_hi;
+	u32 pi_paddr_lo;
+	u32 wq_block_pfn_hi;
+	u32 wq_block_pfn_lo;
+};
+
+struct hinic3_sq_ctxt_block {
+	struct hinic3_qp_ctxt_hdr cmdq_hdr;
+	struct hinic3_sq_ctxt     sq_ctxt[HINIC3_Q_CTXT_MAX];
+};
+
+struct hinic3_rq_ctxt_block {
+	struct hinic3_qp_ctxt_hdr cmdq_hdr;
+	struct hinic3_rq_ctxt     rq_ctxt[HINIC3_Q_CTXT_MAX];
+};
+
+struct hinic3_clean_queue_ctxt {
+	struct hinic3_qp_ctxt_hdr cmdq_hdr;
+	u32                       rsvd;
+};
+
+#define SQ_CTXT_SIZE(num_sqs)  \
+	((u16)(sizeof(struct hinic3_qp_ctxt_hdr) +  \
+	 (num_sqs) * sizeof(struct hinic3_sq_ctxt)))
+
+#define RQ_CTXT_SIZE(num_rqs)  \
+	((u16)(sizeof(struct hinic3_qp_ctxt_hdr) +  \
+	 (num_rqs) * sizeof(struct hinic3_rq_ctxt)))
+
+#define CI_IDX_HIGH_SHIFT    12
+#define CI_HIGN_IDX(val)     ((val) >> CI_IDX_HIGH_SHIFT)
+
+#define SQ_CTXT_PI_IDX_MASK                GENMASK(15, 0)
+#define SQ_CTXT_CI_IDX_MASK                GENMASK(31, 16)
+#define SQ_CTXT_CI_PI_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_##member##_MASK, val)
+
+#define SQ_CTXT_MODE_SP_FLAG_MASK          BIT(0)
+#define SQ_CTXT_MODE_PKT_DROP_MASK         BIT(1)
+#define SQ_CTXT_MODE_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_MODE_##member##_MASK, val)
+
+#define SQ_CTXT_WQ_PAGE_HI_PFN_MASK        GENMASK(19, 0)
+#define SQ_CTXT_WQ_PAGE_OWNER_MASK         BIT(23)
+#define SQ_CTXT_WQ_PAGE_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_WQ_PAGE_##member##_MASK, val)
+
+#define SQ_CTXT_PKT_DROP_THD_ON_MASK       GENMASK(15, 0)
+#define SQ_CTXT_PKT_DROP_THD_OFF_MASK      GENMASK(31, 16)
+#define SQ_CTXT_PKT_DROP_THD_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_PKT_DROP_##member##_MASK, val)
+
+#define SQ_CTXT_GLOBAL_SQ_ID_MASK          GENMASK(12, 0)
+#define SQ_CTXT_GLOBAL_QUEUE_ID_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_##member##_MASK, val)
+
+#define SQ_CTXT_VLAN_INSERT_MODE_MASK      GENMASK(20, 19)
+#define SQ_CTXT_VLAN_CEQ_EN_MASK           BIT(23)
+#define SQ_CTXT_VLAN_CEQ_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_VLAN_##member##_MASK, val)
+
+#define SQ_CTXT_PREF_CACHE_THRESHOLD_MASK  GENMASK(13, 0)
+#define SQ_CTXT_PREF_CACHE_MAX_MASK        GENMASK(24, 14)
+#define SQ_CTXT_PREF_CACHE_MIN_MASK        GENMASK(31, 25)
+
+#define SQ_CTXT_PREF_CI_HI_MASK            GENMASK(3, 0)
+#define SQ_CTXT_PREF_OWNER_MASK            BIT(4)
+
+#define SQ_CTXT_PREF_WQ_PFN_HI_MASK        GENMASK(19, 0)
+#define SQ_CTXT_PREF_CI_LOW_MASK           GENMASK(31, 20)
+#define SQ_CTXT_PREF_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_PREF_##member##_MASK, val)
+
+#define SQ_CTXT_WQ_BLOCK_PFN_HI_MASK       GENMASK(22, 0)
+#define SQ_CTXT_WQ_BLOCK_SET(val, member)  \
+	FIELD_PREP(SQ_CTXT_WQ_BLOCK_##member##_MASK, val)
+
+#define RQ_CTXT_PI_IDX_MASK                GENMASK(15, 0)
+#define RQ_CTXT_CI_IDX_MASK                GENMASK(31, 16)
+#define RQ_CTXT_CI_PI_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_##member##_MASK, val)
+
+#define RQ_CTXT_CEQ_ATTR_INTR_MASK         GENMASK(30, 21)
+#define RQ_CTXT_CEQ_ATTR_EN_MASK           BIT(31)
+#define RQ_CTXT_CEQ_ATTR_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_CEQ_ATTR_##member##_MASK, val)
+
+#define RQ_CTXT_WQ_PAGE_HI_PFN_MASK        GENMASK(19, 0)
+#define RQ_CTXT_WQ_PAGE_WQE_TYPE_MASK      GENMASK(29, 28)
+#define RQ_CTXT_WQ_PAGE_OWNER_MASK         BIT(31)
+#define RQ_CTXT_WQ_PAGE_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_WQ_PAGE_##member##_MASK, val)
+
+#define RQ_CTXT_CQE_LEN_MASK               GENMASK(29, 28)
+#define RQ_CTXT_CQE_LEN_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_##member##_MASK, val)
+
+#define RQ_CTXT_PREF_CACHE_THRESHOLD_MASK  GENMASK(13, 0)
+#define RQ_CTXT_PREF_CACHE_MAX_MASK        GENMASK(24, 14)
+#define RQ_CTXT_PREF_CACHE_MIN_MASK        GENMASK(31, 25)
+
+#define RQ_CTXT_PREF_CI_HI_MASK            GENMASK(3, 0)
+#define RQ_CTXT_PREF_OWNER_MASK            BIT(4)
+
+#define RQ_CTXT_PREF_WQ_PFN_HI_MASK        GENMASK(19, 0)
+#define RQ_CTXT_PREF_CI_LOW_MASK           GENMASK(31, 20)
+#define RQ_CTXT_PREF_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_PREF_##member##_MASK, val)
+
+#define RQ_CTXT_WQ_BLOCK_PFN_HI_MASK       GENMASK(22, 0)
+#define RQ_CTXT_WQ_BLOCK_SET(val, member)  \
+	FIELD_PREP(RQ_CTXT_WQ_BLOCK_##member##_MASK, val)
+
+#define WQ_PAGE_PFN_SHIFT       12
+#define WQ_BLOCK_PFN_SHIFT      9
+#define WQ_PAGE_PFN(page_addr)  ((page_addr) >> WQ_PAGE_PFN_SHIFT)
+#define WQ_BLOCK_PFN(page_addr) ((page_addr) >> WQ_BLOCK_PFN_SHIFT)
+
+static int init_nic_io(struct hinic3_nic_io **nic_io)
+{
+	*nic_io = kzalloc(sizeof(**nic_io), GFP_KERNEL);
+	if (!(*nic_io))
+		return -ENOMEM;
+
+	return 0;
+}
+
 int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_nic_io *nic_io;
+	int err;
+
+	err = init_nic_io(&nic_io);
+	if (err)
+		return err;
+
+	nic_dev->nic_io = nic_io;
+
+	err = hinic3_set_func_svc_used_state(hwdev, SVC_T_NIC, 1);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set function svc used state\n");
+		goto err_set_used_state;
+	}
+
+	err = hinic3_init_function_table(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init function table\n");
+		goto err_out;
+	}
+
+	nic_io->rx_buff_len = nic_dev->rx_buff_len;
+
+	err = hinic3_get_nic_feature_from_hw(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to get nic features\n");
+		goto err_out;
+	}
+
+	nic_io->feature_cap &= NIC_F_ALL_MASK;
+	nic_io->feature_cap &= NIC_DRV_DEFAULT_FEATURE;
+	dev_dbg(hwdev->dev, "nic features: 0x%llx\n\n", nic_io->feature_cap);
+
+	return 0;
+
+err_out:
+	hinic3_set_func_svc_used_state(hwdev, SVC_T_NIC, 0);
+
+err_set_used_state:
+	nic_dev->nic_io = NULL;
+	kfree(nic_io);
+
+	return err;
 }
 
 void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+
+	hinic3_set_func_svc_used_state(nic_dev->hwdev, SVC_T_NIC, 0);
+	nic_dev->nic_io = NULL;
+	kfree(nic_io);
+}
+
+int hinic3_init_nicio_res(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	void __iomem *db_base;
+	int err;
+
+	nic_io->max_qps = hinic3_func_max_qnum(hwdev);
+
+	err = hinic3_alloc_db_addr(hwdev, &db_base, NULL);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to allocate doorbell for sqs\n");
+		return -ENOMEM;
+	}
+	nic_io->sqs_db_addr = db_base;
+
+	err = hinic3_alloc_db_addr(hwdev, &db_base, NULL);
+	if (err) {
+		hinic3_free_db_addr(hwdev, nic_io->sqs_db_addr, NULL);
+		dev_err(hwdev->dev, "Failed to allocate doorbell for rqs\n");
+		return -ENOMEM;
+	}
+	nic_io->rqs_db_addr = db_base;
+
+	nic_io->ci_vaddr_base = dma_alloc_coherent(hwdev->dev,
+						   CI_TABLE_SIZE(nic_io->max_qps),
+						   &nic_io->ci_dma_base, GFP_KERNEL);
+	if (!nic_io->ci_vaddr_base) {
+		hinic3_free_db_addr(hwdev, nic_io->sqs_db_addr, NULL);
+		hinic3_free_db_addr(hwdev, nic_io->rqs_db_addr, NULL);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void hinic3_deinit_nicio_res(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+
+	dma_free_coherent(hwdev->dev,
+			  CI_TABLE_SIZE(nic_io->max_qps),
+			  nic_io->ci_vaddr_base, nic_io->ci_dma_base);
+
+	hinic3_free_db_addr(hwdev, nic_io->sqs_db_addr, NULL);
+	hinic3_free_db_addr(hwdev, nic_io->rqs_db_addr, NULL);
+}
+
+static int hinic3_create_sq(struct hinic3_hwdev *hwdev, struct hinic3_io_queue *sq,
+			    u16 q_id, u32 sq_depth, u16 sq_msix_idx)
+{
+	int err;
+
+	/* sq used & hardware request init 1 */
+	sq->owner = 1;
+
+	sq->q_id = q_id;
+	sq->msix_entry_idx = sq_msix_idx;
+
+	err = hinic3_wq_create(hwdev, &sq->wq, sq_depth,
+			       (u16)BIT(HINIC3_SQ_WQEBB_SHIFT));
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create tx queue %u wq\n",
+			q_id);
+		return err;
+	}
+
+	return 0;
+}
+
+static int hinic3_create_rq(struct hinic3_hwdev *hwdev, struct hinic3_io_queue *rq,
+			    u16 q_id, u32 rq_depth, u16 rq_msix_idx)
+{
+	int err;
+
+	rq->q_id = q_id;
+	rq->msix_entry_idx = rq_msix_idx;
+
+	err = hinic3_wq_create(hwdev, &rq->wq, rq_depth,
+			       (u16)BIT(HINIC3_RQ_WQEBB_SHIFT + HINIC3_NORMAL_RQ_WQE));
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create rx queue %u wq\n",
+			q_id);
+		return err;
+	}
+
+	return 0;
+}
+
+static int create_qp(struct hinic3_hwdev *hwdev, struct hinic3_io_queue *sq,
+		     struct hinic3_io_queue *rq, u16 q_id, u32 sq_depth,
+		     u32 rq_depth, u16 qp_msix_idx)
+{
+	int err;
+
+	err = hinic3_create_sq(hwdev, sq, q_id, sq_depth, qp_msix_idx);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create sq, qid: %u\n",
+			q_id);
+		return err;
+	}
+
+	err = hinic3_create_rq(hwdev, rq, q_id, rq_depth, qp_msix_idx);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to create rq, qid: %u\n",
+			q_id);
+		goto err_create_rq;
+	}
+
+	return 0;
+
+err_create_rq:
+	hinic3_wq_destroy(hwdev, &sq->wq);
+
+	return err;
+}
+
+static void destroy_qp(struct hinic3_hwdev *hwdev, struct hinic3_io_queue *sq,
+		       struct hinic3_io_queue *rq)
+{
+	hinic3_wq_destroy(hwdev, &sq->wq);
+	hinic3_wq_destroy(hwdev, &rq->wq);
+}
+
+int hinic3_alloc_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params)
+{
+	struct irq_info *qps_msix_arry = nic_dev->qps_irq_info;
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_io_queue *sqs;
+	struct hinic3_io_queue *rqs;
+	u16 q_id, i;
+	int err;
+
+	if (qp_params->num_qps > nic_io->max_qps || !qp_params->num_qps)
+		return -EINVAL;
+
+	sqs = kcalloc(qp_params->num_qps, sizeof(*sqs), GFP_KERNEL);
+	if (!sqs) {
+		err = -ENOMEM;
+		goto err_alloc_sqs;
+	}
+
+	rqs = kcalloc(qp_params->num_qps, sizeof(*rqs), GFP_KERNEL);
+	if (!rqs) {
+		err = -ENOMEM;
+		goto err_alloc_rqs;
+	}
+
+	for (q_id = 0; q_id < qp_params->num_qps; q_id++) {
+		err = create_qp(hwdev, &sqs[q_id], &rqs[q_id], q_id, qp_params->sq_depth,
+				qp_params->rq_depth, qps_msix_arry[q_id].msix_entry_idx);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to allocate qp %u, err: %d\n", q_id, err);
+			goto err_create_qp;
+		}
+	}
+
+	qp_params->sqs = sqs;
+	qp_params->rqs = rqs;
+
+	return 0;
+
+err_create_qp:
+	for (i = 0; i < q_id; i++)
+		destroy_qp(hwdev, &sqs[i], &rqs[i]);
+
+	kfree(rqs);
+
+err_alloc_rqs:
+	kfree(sqs);
+
+err_alloc_sqs:
+
+	return err;
+}
+
+void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params)
+{
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	u16 q_id;
+
+	for (q_id = 0; q_id < qp_params->num_qps; q_id++)
+		destroy_qp(hwdev, &qp_params->sqs[q_id], &qp_params->rqs[q_id]);
+
+	kfree(qp_params->sqs);
+	kfree(qp_params->rqs);
+}
+
+void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_io_queue *sqs = qp_params->sqs;
+	struct hinic3_io_queue *rqs = qp_params->rqs;
+	u16 q_id;
+
+	nic_io->num_qps = qp_params->num_qps;
+	nic_io->sq = qp_params->sqs;
+	nic_io->rq = qp_params->rqs;
+	for (q_id = 0; q_id < nic_io->num_qps; q_id++) {
+		sqs[q_id].cons_idx_addr =
+			(u16 *)HINIC3_CI_VADDR(nic_io->ci_vaddr_base, q_id);
+		/* clear ci value */
+		WRITE_ONCE(*sqs[q_id].cons_idx_addr, 0);
+
+		sqs[q_id].db_addr = nic_io->sqs_db_addr;
+		rqs[q_id].db_addr = nic_io->rqs_db_addr;
+	}
+}
+
+void hinic3_deinit_qps(struct hinic3_nic_dev *nic_dev,
+		       struct hinic3_dyna_qp_params *qp_params)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+
+	qp_params->sqs = nic_io->sq;
+	qp_params->rqs = nic_io->rq;
+	qp_params->num_qps = nic_io->num_qps;
+}
+
+static void hinic3_qp_prepare_cmdq_header(struct hinic3_qp_ctxt_hdr *qp_ctxt_hdr,
+					  enum hinic3_qp_ctxt_type ctxt_type,
+					  u16 num_queues, u16 q_id)
+{
+	qp_ctxt_hdr->queue_type = ctxt_type;
+	qp_ctxt_hdr->num_queues = num_queues;
+	qp_ctxt_hdr->start_qid = q_id;
+	qp_ctxt_hdr->rsvd = 0;
+
+	cmdq_buf_swab32(qp_ctxt_hdr, sizeof(*qp_ctxt_hdr));
+}
+
+static void hinic3_sq_prepare_ctxt(struct hinic3_io_queue *sq, u16 sq_id,
+				   struct hinic3_sq_ctxt *sq_ctxt)
+{
+	u64 wq_page_addr, wq_page_pfn, wq_block_pfn;
+	u32 wq_block_pfn_hi, wq_block_pfn_lo;
+	u32 wq_page_pfn_hi, wq_page_pfn_lo;
+	u16 pi_start, ci_start;
+
+	ci_start = hinic3_get_sq_local_ci(sq);
+	pi_start = hinic3_get_sq_local_pi(sq);
+
+	wq_page_addr = hinic3_wq_get_first_wqe_page_addr(&sq->wq);
+
+	wq_page_pfn = WQ_PAGE_PFN(wq_page_addr);
+	wq_page_pfn_hi = upper_32_bits(wq_page_pfn);
+	wq_page_pfn_lo = lower_32_bits(wq_page_pfn);
+
+	wq_block_pfn = WQ_BLOCK_PFN(sq->wq.wq_block_paddr);
+	wq_block_pfn_hi = upper_32_bits(wq_block_pfn);
+	wq_block_pfn_lo = lower_32_bits(wq_block_pfn);
+
+	sq_ctxt->ci_pi =
+		SQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |
+		SQ_CTXT_CI_PI_SET(pi_start, PI_IDX);
+
+	sq_ctxt->drop_mode_sp =
+		SQ_CTXT_MODE_SET(0, SP_FLAG) |
+		SQ_CTXT_MODE_SET(0, PKT_DROP);
+
+	sq_ctxt->wq_pfn_hi_owner =
+		SQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |
+		SQ_CTXT_WQ_PAGE_SET(1, OWNER);
+
+	sq_ctxt->wq_pfn_lo = wq_page_pfn_lo;
+
+	sq_ctxt->pkt_drop_thd =
+		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_ON, THD_ON) |
+		SQ_CTXT_PKT_DROP_THD_SET(HINIC3_DEAULT_DROP_THD_OFF, THD_OFF);
+
+	sq_ctxt->global_sq_id =
+		SQ_CTXT_GLOBAL_QUEUE_ID_SET(sq_id, GLOBAL_SQ_ID);
+
+	/* enable insert c-vlan by default */
+	sq_ctxt->vlan_ceq_attr =
+		SQ_CTXT_VLAN_CEQ_SET(0, CEQ_EN) |
+		SQ_CTXT_VLAN_CEQ_SET(1, INSERT_MODE);
+
+	sq_ctxt->rsvd0 = 0;
+
+	sq_ctxt->pref_cache =
+		SQ_CTXT_PREF_SET(SQ_WQ_PREFETCH_MIN, CACHE_MIN) |
+		SQ_CTXT_PREF_SET(SQ_WQ_PREFETCH_MAX, CACHE_MAX) |
+		SQ_CTXT_PREF_SET(SQ_WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+
+	sq_ctxt->pref_ci_owner =
+		SQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |
+		SQ_CTXT_PREF_SET(1, OWNER);
+
+	sq_ctxt->pref_wq_pfn_hi_ci =
+		SQ_CTXT_PREF_SET(ci_start, CI_LOW) |
+		SQ_CTXT_PREF_SET(wq_page_pfn_hi, WQ_PFN_HI);
+
+	sq_ctxt->pref_wq_pfn_lo = wq_page_pfn_lo;
+
+	sq_ctxt->wq_block_pfn_hi =
+		SQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI);
+
+	sq_ctxt->wq_block_pfn_lo = wq_block_pfn_lo;
+
+	cmdq_buf_swab32(sq_ctxt, sizeof(*sq_ctxt));
+}
+
+static void hinic3_rq_prepare_ctxt_get_wq_info(struct hinic3_io_queue *rq,
+					       u32 *wq_page_pfn_hi, u32 *wq_page_pfn_lo,
+					       u32 *wq_block_pfn_hi, u32 *wq_block_pfn_lo)
+{
+	u64 wq_page_addr, wq_page_pfn, wq_block_pfn;
+
+	wq_page_addr = hinic3_wq_get_first_wqe_page_addr(&rq->wq);
+
+	wq_page_pfn = WQ_PAGE_PFN(wq_page_addr);
+	*wq_page_pfn_hi = upper_32_bits(wq_page_pfn);
+	*wq_page_pfn_lo = lower_32_bits(wq_page_pfn);
+
+	wq_block_pfn = WQ_BLOCK_PFN(rq->wq.wq_block_paddr);
+	*wq_block_pfn_hi = upper_32_bits(wq_block_pfn);
+	*wq_block_pfn_lo = lower_32_bits(wq_block_pfn);
+}
+
+static void hinic3_rq_prepare_ctxt(struct hinic3_io_queue *rq, struct hinic3_rq_ctxt *rq_ctxt)
+{
+	u32 wq_block_pfn_hi, wq_block_pfn_lo;
+	u32 wq_page_pfn_hi, wq_page_pfn_lo;
+	u16 pi_start, ci_start;
+
+	ci_start = (u16)((u32)(rq->wq.cons_idx & rq->wq.idx_mask) << HINIC3_NORMAL_RQ_WQE);
+	pi_start = (u16)((u32)(rq->wq.prod_idx & rq->wq.idx_mask) << HINIC3_NORMAL_RQ_WQE);
+
+	hinic3_rq_prepare_ctxt_get_wq_info(rq, &wq_page_pfn_hi, &wq_page_pfn_lo,
+					   &wq_block_pfn_hi, &wq_block_pfn_lo);
+
+	rq_ctxt->ci_pi =
+		RQ_CTXT_CI_PI_SET(ci_start, CI_IDX) |
+		RQ_CTXT_CI_PI_SET(pi_start, PI_IDX);
+
+	rq_ctxt->ceq_attr =
+		RQ_CTXT_CEQ_ATTR_SET(0, EN) |
+		RQ_CTXT_CEQ_ATTR_SET(rq->msix_entry_idx, INTR);
+
+	rq_ctxt->wq_pfn_hi_type_owner =
+		RQ_CTXT_WQ_PAGE_SET(wq_page_pfn_hi, HI_PFN) |
+		RQ_CTXT_WQ_PAGE_SET(1, OWNER);
+
+	/* use 16Byte WQE */
+	rq_ctxt->wq_pfn_hi_type_owner |=
+		RQ_CTXT_WQ_PAGE_SET(2, WQE_TYPE);
+	rq_ctxt->cqe_sge_len = RQ_CTXT_CQE_LEN_SET(1, CQE_LEN);
+
+	rq_ctxt->wq_pfn_lo = wq_page_pfn_lo;
+
+	rq_ctxt->pref_cache =
+		RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_MIN, CACHE_MIN) |
+		RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_MAX, CACHE_MAX) |
+		RQ_CTXT_PREF_SET(RQ_WQ_PREFETCH_THRESHOLD, CACHE_THRESHOLD);
+
+	rq_ctxt->pref_ci_owner =
+		RQ_CTXT_PREF_SET(CI_HIGN_IDX(ci_start), CI_HI) |
+		RQ_CTXT_PREF_SET(1, OWNER);
+
+	rq_ctxt->pref_wq_pfn_hi_ci =
+		RQ_CTXT_PREF_SET(wq_page_pfn_hi, WQ_PFN_HI) |
+		RQ_CTXT_PREF_SET(ci_start, CI_LOW);
+
+	rq_ctxt->pref_wq_pfn_lo = wq_page_pfn_lo;
+
+	rq_ctxt->wq_block_pfn_hi =
+		RQ_CTXT_WQ_BLOCK_SET(wq_block_pfn_hi, PFN_HI);
+
+	rq_ctxt->wq_block_pfn_lo = wq_block_pfn_lo;
+
+	cmdq_buf_swab32(rq_ctxt, sizeof(*rq_ctxt));
+}
+
+static int init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_sq_ctxt_block *sq_ctxt_block;
+	u16 q_id, curr_id, max_ctxts, i;
+	struct hinic3_sq_ctxt *sq_ctxt;
+	struct hinic3_cmd_buf *cmd_buf;
+	struct hinic3_io_queue *sq;
+	u64 out_param;
+	int err = 0;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	q_id = 0;
+	while (q_id < nic_io->num_qps) {
+		sq_ctxt_block = cmd_buf->buf;
+		sq_ctxt = sq_ctxt_block->sq_ctxt;
+
+		max_ctxts = (nic_io->num_qps - q_id) > HINIC3_Q_CTXT_MAX ?
+			     HINIC3_Q_CTXT_MAX : (nic_io->num_qps - q_id);
+
+		hinic3_qp_prepare_cmdq_header(&sq_ctxt_block->cmdq_hdr,
+					      HINIC3_QP_CTXT_TYPE_SQ, max_ctxts,
+					      q_id);
+
+		for (i = 0; i < max_ctxts; i++) {
+			curr_id = q_id + i;
+			sq = &nic_io->sq[curr_id];
+			hinic3_sq_prepare_ctxt(sq, curr_id, &sq_ctxt[i]);
+		}
+
+		cmd_buf->size = SQ_CTXT_SIZE(max_ctxts);
+		err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,
+					      cmd_buf, &out_param);
+		if (err || out_param != 0) {
+			dev_err(hwdev->dev, "Failed to set SQ ctxts, err: %d, out_param: 0x%llx\n",
+				err, out_param);
+			err = -EFAULT;
+			break;
+		}
+
+		q_id += max_ctxts;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+
+	return err;
+}
+
+static int init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_rq_ctxt_block *rq_ctxt_block;
+	u16 q_id, curr_id, max_ctxts, i;
+	struct hinic3_rq_ctxt *rq_ctxt;
+	struct hinic3_cmd_buf *cmd_buf;
+	struct hinic3_io_queue *rq;
+	u64 out_param;
+	int err = 0;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	q_id = 0;
+	while (q_id < nic_io->num_qps) {
+		rq_ctxt_block = cmd_buf->buf;
+		rq_ctxt = rq_ctxt_block->rq_ctxt;
+
+		max_ctxts = (nic_io->num_qps - q_id) > HINIC3_Q_CTXT_MAX ?
+				HINIC3_Q_CTXT_MAX : (nic_io->num_qps - q_id);
+
+		hinic3_qp_prepare_cmdq_header(&rq_ctxt_block->cmdq_hdr,
+					      HINIC3_QP_CTXT_TYPE_RQ, max_ctxts,
+					      q_id);
+
+		for (i = 0; i < max_ctxts; i++) {
+			curr_id = q_id + i;
+			rq = &nic_io->rq[curr_id];
+			hinic3_rq_prepare_ctxt(rq, &rq_ctxt[i]);
+		}
+
+		cmd_buf->size = RQ_CTXT_SIZE(max_ctxts);
+
+		err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+					      HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX,
+					      cmd_buf, &out_param);
+		if (err || out_param != 0) {
+			dev_err(hwdev->dev, "Failed to set RQ ctxts, err: %d, out_param: 0x%llx\n",
+				err, out_param);
+			err = -EFAULT;
+			break;
+		}
+
+		q_id += max_ctxts;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+
+	return err;
+}
+
+static int init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	int err;
+
+	err = init_sq_ctxts(nic_dev);
+	if (err)
+		return err;
+
+	err = init_rq_ctxts(nic_dev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
+				    enum hinic3_qp_ctxt_type ctxt_type)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_clean_queue_ctxt *ctxt_block;
+	struct hinic3_cmd_buf *cmd_buf;
+	u64 out_param;
+	int err;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	ctxt_block = cmd_buf->buf;
+	ctxt_block->cmdq_hdr.num_queues = nic_io->max_qps;
+	ctxt_block->cmdq_hdr.queue_type = ctxt_type;
+	ctxt_block->cmdq_hdr.start_qid = 0;
+	ctxt_block->cmdq_hdr.rsvd = 0;
+	ctxt_block->rsvd = 0;
+
+	cmdq_buf_swab32(ctxt_block, sizeof(*ctxt_block));
+
+	cmd_buf->size = sizeof(*ctxt_block);
+
+	err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT,
+				      cmd_buf, &out_param);
+	if ((err) || (out_param)) {
+		dev_err(hwdev->dev, "Failed to clean queue offload ctxts, err: %d,out_param: 0x%llx\n",
+			err, out_param);
+
+		err = -EFAULT;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+
+	return err;
+}
+
+static int clean_qp_offload_ctxt(struct hinic3_nic_dev *nic_dev)
+{
+	/* clean LRO/TSO context space */
+	return (clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_SQ) ||
+		clean_queue_offload_ctxt(nic_dev, HINIC3_QP_CTXT_TYPE_RQ));
+}
+
+/* init qps ctxt and set sq ci attr and arm all sq */
+int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct hinic3_sq_attr sq_attr;
+	u32 rq_depth;
+	u16 q_id;
+	int err;
+
+	err = init_qp_ctxts(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init QP ctxts\n");
+		return err;
+	}
+
+	/* clean LRO/TSO context space */
+	err = clean_qp_offload_ctxt(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to clean qp offload ctxts\n");
+		return err;
+	}
+
+	rq_depth = nic_io->rq[0].wq.q_depth << HINIC3_NORMAL_RQ_WQE;
+
+	err = hinic3_set_root_ctxt(hwdev, rq_depth, nic_io->sq[0].wq.q_depth,
+				   nic_io->rx_buff_len);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set root context\n");
+		return err;
+	}
+
+	for (q_id = 0; q_id < nic_io->num_qps; q_id++) {
+		sq_attr.ci_dma_base =
+			HINIC3_CI_PADDR(nic_io->ci_dma_base, q_id) >> 0x2;
+		sq_attr.pending_limit = HINIC3_DEAULT_TX_CI_PENDING_LIMIT;
+		sq_attr.coalescing_time = HINIC3_DEAULT_TX_CI_COALESCING_TIME;
+		sq_attr.intr_en = 1;
+		sq_attr.intr_idx = nic_io->sq[q_id].msix_entry_idx;
+		sq_attr.l2nic_sqn = q_id;
+		sq_attr.dma_attr_off = 0;
+		err = hinic3_set_ci_table(hwdev, &sq_attr);
+		if (err) {
+			dev_err(hwdev->dev, "Failed to set ci table\n");
+			goto err_set_cons_idx_table;
+		}
+	}
+
+	return 0;
+
+err_set_cons_idx_table:
+	hinic3_clean_root_ctxt(hwdev);
+
+	return err;
+}
+
+void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev)
+{
+	hinic3_clean_root_ctxt(nic_dev->hwdev);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
index c10e48726386..1c9e145de3ad 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -91,6 +91,15 @@ static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,
 	writeq(*((u64 *)&db), DB_ADDR(queue, pi));
 }
 
+struct hinic3_dyna_qp_params {
+	u16                    num_qps;
+	u32                    sq_depth;
+	u32                    rq_depth;
+
+	struct hinic3_io_queue *sqs;
+	struct hinic3_io_queue *rqs;
+};
+
 struct hinic3_nic_io {
 	struct hinic3_io_queue *sq;
 	struct hinic3_io_queue *rq;
@@ -115,4 +124,19 @@ struct hinic3_nic_io {
 int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev);
 void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev);
 
+int hinic3_init_nicio_res(struct hinic3_nic_dev *nic_dev);
+void hinic3_deinit_nicio_res(struct hinic3_nic_dev *nic_dev);
+
+int hinic3_alloc_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params);
+void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params);
+void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
+		     struct hinic3_dyna_qp_params *qp_params);
+void hinic3_deinit_qps(struct hinic3_nic_dev *nic_dev,
+		       struct hinic3_dyna_qp_params *qp_params);
+
+int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
+void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev);
+
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h b/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
new file mode 100644
index 000000000000..4336e002988a
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_PCI_ID_TBL_H
+#define HINIC3_PCI_ID_TBL_H
+
+#define PCI_VENDOR_ID_HUAWEI    0x19e5
+#define PCI_DEV_ID_HINIC3_VF    0x375F
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
index 7873a18fac65..2ef547a5fc4c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
@@ -5,8 +5,334 @@
 #include "hinic3_hwdev.h"
 #include "hinic3_nic_dev.h"
 #include "hinic3_nic_cfg.h"
+#include "hinic3_cmdq.h"
 #include "hinic3_hwif.h"
 
+static void hinic3_fillout_indir_tbl(struct net_device *netdev, u32 *indir)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u32 i, num_qps;
+
+	num_qps = nic_dev->q_params.num_qps;
+	for (i = 0; i < NIC_RSS_INDIR_SIZE; i++)
+		indir[i] = i % num_qps;
+}
+
+static int hinic3_rss_cfg(struct hinic3_hwdev *hwdev, u8 rss_en, u16 num_qps)
+{
+	struct hinic3_cmd_rss_config rss_cfg;
+	u32 out_size = sizeof(rss_cfg);
+	int err;
+
+	memset(&rss_cfg, 0, sizeof(struct hinic3_cmd_rss_config));
+	rss_cfg.func_id = hinic3_global_func_id(hwdev);
+	rss_cfg.rss_en = rss_en;
+	rss_cfg.rq_priority_number = 0;
+	rss_cfg.num_qps = num_qps;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_RSS_CFG,
+				     &rss_cfg, sizeof(rss_cfg),
+				     &rss_cfg, &out_size);
+	if (err || !out_size || rss_cfg.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set rss cfg, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, rss_cfg.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void hinic3_init_rss_parameters(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	nic_dev->rss_hash_type = HINIC3_RSS_HASH_ENGINE_TYPE_XOR;
+	nic_dev->rss_type.tcp_ipv6_ext = 1;
+	nic_dev->rss_type.ipv6_ext = 1;
+	nic_dev->rss_type.tcp_ipv6 = 1;
+	nic_dev->rss_type.ipv6 = 1;
+	nic_dev->rss_type.tcp_ipv4 = 1;
+	nic_dev->rss_type.ipv4 = 1;
+	nic_dev->rss_type.udp_ipv6 = 1;
+	nic_dev->rss_type.udp_ipv4 = 1;
+}
+
+static void hinic3_set_default_rss_indir(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	set_bit(HINIC3_RSS_DEFAULT_INDIR, &nic_dev->flags);
+}
+
+static void hinic3_maybe_reconfig_rss_indir(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int i;
+
+	for (i = 0; i < NIC_RSS_INDIR_SIZE; i++) {
+		if (nic_dev->rss_indir[i] >= nic_dev->q_params.num_qps) {
+			hinic3_set_default_rss_indir(netdev);
+			break;
+		}
+	}
+}
+
+/* Get number of CPUs on same NUMA node of device. */
+static unsigned int dev_num_cpus(struct device *dev)
+{
+	unsigned int i, num_cpus, num_node_cpus;
+	int dev_node;
+
+	dev_node = dev_to_node(dev);
+	num_cpus = num_online_cpus();
+	num_node_cpus = 0;
+
+	for (i = 0; i < num_cpus; i++) {
+		if (cpu_to_node(i) == dev_node)
+			num_node_cpus++;
+	}
+
+	return num_node_cpus ? : num_cpus;
+}
+
+static void decide_num_qps(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	unsigned int dev_cpus;
+
+	dev_cpus = dev_num_cpus(&nic_dev->pdev->dev);
+	nic_dev->q_params.num_qps = min(dev_cpus, nic_dev->max_qps);
+}
+
+static int alloc_rss_resource(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	static const u8 default_rss_key[NIC_RSS_KEY_SIZE] = {
+		0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
+		0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
+		0xd0, 0xca, 0x2b, 0xcb, 0xae, 0x7b, 0x30, 0xb4,
+		0x77, 0xcb, 0x2d, 0xa3, 0x80, 0x30, 0xf2, 0x0c,
+		0x6a, 0x42, 0xb7, 0x3b, 0xbe, 0xac, 0x01, 0xfa};
+
+	nic_dev->rss_hkey = kzalloc(NIC_RSS_KEY_SIZE, GFP_KERNEL);
+	if (!nic_dev->rss_hkey)
+		return -ENOMEM;
+
+	memcpy(nic_dev->rss_hkey, default_rss_key, NIC_RSS_KEY_SIZE);
+	nic_dev->rss_indir = kzalloc(sizeof(u32) * NIC_RSS_INDIR_SIZE, GFP_KERNEL);
+	if (!nic_dev->rss_indir) {
+		kfree(nic_dev->rss_hkey);
+		nic_dev->rss_hkey = NULL;
+		return -ENOMEM;
+	}
+
+	set_bit(HINIC3_RSS_DEFAULT_INDIR, &nic_dev->flags);
+
+	return 0;
+}
+
+static int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev,
+				    const u32 *indir_table)
+{
+	struct nic_rss_indirect_tbl_set *indir_tbl;
+	struct hinic3_cmd_buf *cmd_buf;
+	u64 out_param;
+	int err;
+	u32 i;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	cmd_buf->size = sizeof(struct nic_rss_indirect_tbl_set);
+	indir_tbl = cmd_buf->buf;
+	memset(indir_tbl, 0, sizeof(*indir_tbl));
+
+	for (i = 0; i < NIC_RSS_INDIR_SIZE; i++)
+		indir_tbl->entry[i] = indir_table[i];
+
+	cmdq_buf_swab32(indir_tbl, sizeof(*indir_tbl));
+
+	err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE,
+				      cmd_buf, &out_param);
+	if (err || out_param != 0) {
+		dev_err(hwdev->dev, "Failed to set rss indir table\n");
+		err = -EFAULT;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+	return err;
+}
+
+static int hinic3_set_rss_type(struct hinic3_hwdev *hwdev,
+			       struct nic_rss_type rss_type)
+{
+	struct hinic3_rss_context_table ctx_tbl;
+	u32 out_size = sizeof(ctx_tbl);
+	u32 ctx;
+	int err;
+
+	memset(&ctx_tbl, 0, sizeof(ctx_tbl));
+	ctx_tbl.func_id = hinic3_global_func_id(hwdev);
+	ctx = HINIC3_RSS_TYPE_SET(1, VALID) |
+	      HINIC3_RSS_TYPE_SET(rss_type.ipv4, IPV4) |
+	      HINIC3_RSS_TYPE_SET(rss_type.ipv6, IPV6) |
+	      HINIC3_RSS_TYPE_SET(rss_type.ipv6_ext, IPV6_EXT) |
+	      HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv4, TCP_IPV4) |
+	      HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6, TCP_IPV6) |
+	      HINIC3_RSS_TYPE_SET(rss_type.tcp_ipv6_ext, TCP_IPV6_EXT) |
+	      HINIC3_RSS_TYPE_SET(rss_type.udp_ipv4, UDP_IPV4) |
+	      HINIC3_RSS_TYPE_SET(rss_type.udp_ipv6, UDP_IPV6);
+	ctx_tbl.context = ctx;
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC,
+				     &ctx_tbl, sizeof(ctx_tbl),
+				     &ctx_tbl, &out_size);
+
+	if (ctx_tbl.msg_head.status == MGMT_CMD_UNSUPPORTED) {
+		return MGMT_CMD_UNSUPPORTED;
+	} else if (err || !out_size || ctx_tbl.msg_head.status) {
+		dev_err(hwdev->dev, "mgmt Failed to set rss context offload, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, ctx_tbl.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_rss_cfg_hash_type(struct hinic3_hwdev *hwdev, u8 opcode,
+				    enum hinic3_rss_hash_type *type)
+{
+	struct hinic3_cmd_rss_engine_type hash_type_cmd;
+	u32 out_size = sizeof(hash_type_cmd);
+	int err;
+
+	memset(&hash_type_cmd, 0, sizeof(struct hinic3_cmd_rss_engine_type));
+
+	hash_type_cmd.func_id = hinic3_global_func_id(hwdev);
+	hash_type_cmd.opcode = opcode;
+
+	if (opcode == HINIC3_CMD_OP_SET)
+		hash_type_cmd.hash_engine = *type;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev,
+				     HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE,
+				     &hash_type_cmd, sizeof(hash_type_cmd),
+				     &hash_type_cmd, &out_size);
+	if (err || !out_size || hash_type_cmd.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to %s hash engine, err: %d, status: 0x%x, out size: 0x%x\n",
+			opcode == HINIC3_CMD_OP_SET ? "set" : "get",
+			err, hash_type_cmd.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET)
+		*type = hash_type_cmd.hash_engine;
+
+	return 0;
+}
+
+static int hinic3_rss_set_hash_type(struct hinic3_hwdev *hwdev,
+				    enum hinic3_rss_hash_type type)
+{
+	return hinic3_rss_cfg_hash_type(hwdev, HINIC3_CMD_OP_SET, &type);
+}
+
+static int hinic3_config_rss_hw_resource(struct net_device *netdev,
+					 u32 *indir_tbl)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir_tbl);
+	if (err)
+		return err;
+
+	err = hinic3_set_rss_type(nic_dev->hwdev, nic_dev->rss_type);
+	if (err)
+		return err;
+
+	return hinic3_rss_set_hash_type(nic_dev->hwdev, nic_dev->rss_hash_type);
+}
+
+static int hinic3_rss_cfg_hash_key(struct hinic3_hwdev *hwdev, u8 opcode,
+				   u8 *key)
+{
+	struct hinic3_cmd_rss_hash_key hash_key;
+	u32 out_size = sizeof(hash_key);
+	int err;
+
+	memset(&hash_key, 0, sizeof(struct hinic3_cmd_rss_hash_key));
+	hash_key.func_id = hinic3_global_func_id(hwdev);
+	hash_key.opcode = opcode;
+
+	if (opcode == HINIC3_CMD_OP_SET)
+		memcpy(hash_key.key, key, NIC_RSS_KEY_SIZE);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev,
+				     HINIC3_NIC_CMD_CFG_RSS_HASH_KEY,
+				     &hash_key, sizeof(hash_key),
+				     &hash_key, &out_size);
+	if (err || !out_size || hash_key.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to %s hash key, err: %d, status: 0x%x, out size: 0x%x\n",
+			opcode == HINIC3_CMD_OP_SET ? "set" : "get",
+			err, hash_key.msg_head.status, out_size);
+		return -EINVAL;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET)
+		memcpy(key, hash_key.key, NIC_RSS_KEY_SIZE);
+
+	return 0;
+}
+
+static int hinic3_rss_set_hash_key(struct hinic3_hwdev *hwdev, const u8 *key)
+{
+	u8 hash_key[NIC_RSS_KEY_SIZE];
+
+	memcpy(hash_key, key, NIC_RSS_KEY_SIZE);
+	return hinic3_rss_cfg_hash_key(hwdev, HINIC3_CMD_OP_SET, hash_key);
+}
+
+static int hinic3_set_hw_rss_parameters(struct net_device *netdev, u8 rss_en)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_rss_set_hash_key(nic_dev->hwdev, nic_dev->rss_hkey);
+	if (err)
+		return err;
+
+	hinic3_maybe_reconfig_rss_indir(netdev);
+
+	if (test_bit(HINIC3_RSS_DEFAULT_INDIR, &nic_dev->flags))
+		hinic3_fillout_indir_tbl(netdev, nic_dev->rss_indir);
+
+	err = hinic3_config_rss_hw_resource(netdev, nic_dev->rss_indir);
+	if (err)
+		return err;
+
+	err = hinic3_rss_cfg(nic_dev->hwdev, rss_en, nic_dev->q_params.num_qps);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int hinic3_rss_init(struct net_device *netdev)
+{
+	return hinic3_set_hw_rss_parameters(netdev, 1);
+}
+
+void hinic3_rss_deinit(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_rss_cfg(nic_dev->hwdev, 0, 0);
+}
+
 void hinic3_clear_rss_config(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
@@ -20,5 +346,33 @@ void hinic3_clear_rss_config(struct net_device *netdev)
 
 void hinic3_try_to_enable_rss(struct net_device *netdev)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	nic_dev->max_qps = hinic3_func_max_qnum(hwdev);
+	if (nic_dev->max_qps <= 1 || !hinic3_test_support(nic_dev, NIC_F_RSS))
+		goto set_q_params;
+
+	err = alloc_rss_resource(netdev);
+	if (err) {
+		nic_dev->max_qps = 1;
+		goto set_q_params;
+	}
+
+	set_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
+	decide_num_qps(netdev);
+	hinic3_init_rss_parameters(netdev);
+	err = hinic3_set_hw_rss_parameters(netdev, 0);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set hardware rss parameters\n");
+		hinic3_clear_rss_config(netdev);
+		nic_dev->max_qps = 1;
+		goto set_q_params;
+	}
+	return;
+
+set_q_params:
+	clear_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
+	nic_dev->q_params.num_qps = nic_dev->max_qps;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
index 4da23014d680..ddc6a91aae39 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
@@ -6,6 +6,8 @@
 
 #include <linux/netdevice.h>
 
+int hinic3_rss_init(struct net_device *netdev);
+void hinic3_rss_deinit(struct net_device *netdev);
 void hinic3_try_to_enable_rss(struct net_device *netdev);
 void hinic3_clear_rss_config(struct net_device *netdev);
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
index 35b77fb91608..d69b0bf638f6 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -25,13 +25,44 @@
 
 int hinic3_alloc_rxqs(struct net_device *netdev)
 {
-	/* Completed by later submission due to LoC limit. */
-	return -EFAULT;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	struct pci_dev *pdev = nic_dev->pdev;
+	u16 num_rxqs = nic_dev->max_qps;
+	struct hinic3_rxq *rxq;
+	u64 rxq_size;
+	u16 q_id;
+
+	rxq_size = num_rxqs * sizeof(*nic_dev->rxqs);
+	if (!rxq_size) {
+		dev_err(hwdev->dev, "Cannot allocate zero size rxqs\n");
+		return -EINVAL;
+	}
+
+	nic_dev->rxqs = kzalloc(rxq_size, GFP_KERNEL);
+	if (!nic_dev->rxqs)
+		return -ENOMEM;
+
+	for (q_id = 0; q_id < num_rxqs; q_id++) {
+		rxq = &nic_dev->rxqs[q_id];
+		rxq->netdev = netdev;
+		rxq->dev = &pdev->dev;
+		rxq->q_id = q_id;
+		rxq->buf_len = nic_dev->rx_buff_len;
+		rxq->rx_buff_shift = ilog2(nic_dev->rx_buff_len);
+		rxq->dma_rx_buff_size = nic_dev->dma_rx_buff_size;
+		rxq->q_depth = nic_dev->q_params.rq_depth;
+		rxq->q_mask = nic_dev->q_params.rq_depth - 1;
+	}
+
+	return 0;
 }
 
 void hinic3_free_rxqs(struct net_device *netdev)
 {
-	/* Completed by later submission due to LoC limit. */
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->rxqs);
 }
 
 static int rx_alloc_mapped_page(struct net_device *netdev, struct hinic3_rx_info *rx_info)
@@ -63,6 +94,29 @@ static int rx_alloc_mapped_page(struct net_device *netdev, struct hinic3_rx_info
 	return 0;
 }
 
+/* Associate fixed completion element to every wqe in the rq. Every rq wqe will
+ * always post completion to the same place.
+ */
+static void rq_associate_cqes(struct hinic3_rxq *rxq)
+{
+	struct hinic3_queue_pages *qpages;
+	struct hinic3_rq_wqe *rq_wqe;
+	dma_addr_t cqe_dma;
+	int cqe_len;
+	u32 i;
+
+	/* unit of cqe length is 16B */
+	cqe_len = sizeof(struct hinic3_rq_cqe) >> HINIC3_CQE_SIZE_SHIFT;
+	qpages = &rxq->rq->wq.qpages;
+
+	for (i = 0; i < rxq->q_depth; i++) {
+		rq_wqe = get_q_element(qpages, i, NULL);
+		cqe_dma = rxq->cqe_start_paddr + i * sizeof(struct hinic3_rq_cqe);
+		rq_wqe->cqe_hi_addr = upper_32_bits(cqe_dma);
+		rq_wqe->cqe_lo_addr = lower_32_bits(cqe_dma);
+	}
+}
+
 static void rq_wqe_buff_set(struct hinic3_io_queue *rq, uint32_t wqe_idx,
 			    dma_addr_t dma_addr, u16 len)
 {
@@ -106,6 +160,48 @@ static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
 	return i;
 }
 
+static u32 hinic3_rx_alloc_buffers(struct net_device *netdev, u32 rq_depth,
+				   struct hinic3_rx_info *rx_info_arr)
+{
+	u32 free_wqebbs = rq_depth - 1;
+	u32 idx;
+	int err;
+
+	for (idx = 0; idx < free_wqebbs; idx++) {
+		err = rx_alloc_mapped_page(netdev, &rx_info_arr[idx]);
+		if (err)
+			break;
+	}
+
+	return idx;
+}
+
+static void hinic3_rx_free_buffers(struct net_device *netdev, u32 q_depth,
+				   struct hinic3_rx_info *rx_info_arr)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_rx_info *rx_info;
+	u32 i;
+
+	/* Free all the Rx ring sk_buffs */
+	for (i = 0; i < q_depth; i++) {
+		rx_info = &rx_info_arr[i];
+
+		if (rx_info->buf_dma_addr) {
+			dma_unmap_page(&nic_dev->pdev->dev,
+				       rx_info->buf_dma_addr,
+				       nic_dev->dma_rx_buff_size,
+				       DMA_FROM_DEVICE);
+			rx_info->buf_dma_addr = 0;
+		}
+
+		if (rx_info->page) {
+			__free_pages(rx_info->page, nic_dev->page_order);
+			rx_info->page = NULL;
+		}
+	}
+}
+
 static void hinic3_reuse_rx_page(struct hinic3_rxq *rxq,
 				 struct hinic3_rx_info *old_rx_info)
 {
@@ -358,6 +454,119 @@ static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
 	return 0;
 }
 
+int hinic3_alloc_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res)
+{
+	u64 cqe_mem_size = sizeof(struct hinic3_rq_cqe) * rq_depth;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_rxq_res *rqres;
+	u32 pkt_idx;
+	int idx, i;
+	u64 size;
+
+	for (idx = 0; idx < num_rq; idx++) {
+		rqres = &rxqs_res[idx];
+		size = sizeof(*rqres->rx_info) * rq_depth;
+		rqres->rx_info = kzalloc(size, GFP_KERNEL);
+		if (!rqres->rx_info)
+			goto err_out;
+
+		rqres->cqe_start_vaddr = dma_alloc_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+							    &rqres->cqe_start_paddr,
+							    GFP_KERNEL);
+		if (!rqres->cqe_start_vaddr) {
+			kfree(rqres->rx_info);
+			goto err_out;
+		}
+
+		pkt_idx = hinic3_rx_alloc_buffers(netdev, rq_depth, rqres->rx_info);
+		if (!pkt_idx) {
+			dma_free_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+					  rqres->cqe_start_vaddr,
+					  rqres->cqe_start_paddr);
+			kfree(rqres->rx_info);
+			netdev_err(netdev, "Failed to alloc rxq%d rx buffers\n", idx);
+			goto err_out;
+		}
+		rqres->next_to_alloc = (u16)pkt_idx;
+	}
+	return 0;
+
+err_out:
+	for (i = 0; i < idx; i++) {
+		rqres = &rxqs_res[i];
+
+		hinic3_rx_free_buffers(netdev, rq_depth, rqres->rx_info);
+		dma_free_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+				  rqres->cqe_start_vaddr,
+				  rqres->cqe_start_paddr);
+		kfree(rqres->rx_info);
+	}
+
+	return -ENOMEM;
+}
+
+void hinic3_free_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res)
+{
+	u64 cqe_mem_size = sizeof(struct hinic3_rq_cqe) * rq_depth;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_rxq_res *rqres;
+	int idx;
+
+	for (idx = 0; idx < num_rq; idx++) {
+		rqres = &rxqs_res[idx];
+
+		hinic3_rx_free_buffers(netdev, rq_depth, rqres->rx_info);
+		dma_free_coherent(&nic_dev->pdev->dev, cqe_mem_size,
+				  rqres->cqe_start_vaddr,
+				  rqres->cqe_start_paddr);
+		kfree(rqres->rx_info);
+	}
+}
+
+int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_rxq_res *rqres;
+	struct irq_info *msix_entry;
+	struct hinic3_rxq *rxq;
+	u16 q_id;
+	u32 pkts;
+
+	for (q_id = 0; q_id < num_rq; q_id++) {
+		rxq = &nic_dev->rxqs[q_id];
+		rqres = &rxqs_res[q_id];
+		msix_entry = &nic_dev->qps_irq_info[q_id];
+
+		rxq->irq_id = msix_entry->irq_id;
+		rxq->msix_entry_idx = msix_entry->msix_entry_idx;
+		rxq->next_to_update = 0;
+		rxq->next_to_alloc = rqres->next_to_alloc;
+		rxq->q_depth = rq_depth;
+		rxq->delta = rxq->q_depth;
+		rxq->q_mask = rxq->q_depth - 1;
+		rxq->cons_idx = 0;
+
+		rxq->cqe_arr = rqres->cqe_start_vaddr;
+		rxq->cqe_start_paddr = rqres->cqe_start_paddr;
+		rxq->rx_info = rqres->rx_info;
+
+		rxq->rq = &nic_dev->nic_io->rq[rxq->q_id];
+
+		rq_associate_cqes(rxq);
+
+		pkts = hinic3_rx_fill_buffers(rxq);
+		if (!pkts) {
+			netdev_err(netdev, "Failed to fill Rx buffer\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 #define LRO_PKT_HDR_LEN_IPV4    66
 #define LRO_PKT_HDR_LEN_IPV6    86
 #define LRO_PKT_HDR_LEN(cqe) \
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index 6a567647795e..b1c2d4dc791c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -83,9 +83,22 @@ struct hinic3_rxq {
 	dma_addr_t             cqe_start_paddr;
 } ____cacheline_aligned;
 
+struct hinic3_dyna_rxq_res {
+	u16                   next_to_alloc;
+	struct hinic3_rx_info *rx_info;
+	dma_addr_t            cqe_start_paddr;
+	void                  *cqe_start_vaddr;
+};
+
 int hinic3_alloc_rxqs(struct net_device *netdev);
 void hinic3_free_rxqs(struct net_device *netdev);
 
+int hinic3_alloc_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
+void hinic3_free_rxqs_res(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
+int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
+			  u32 rq_depth, struct hinic3_dyna_rxq_res *rxqs_res);
 int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget);
 
 #endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index 1496f282603c..648651ab636b 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -146,6 +146,19 @@ static void tx_free_skb(struct net_device *netdev,
 	tx_info->skb = NULL;
 }
 
+static void free_all_tx_skbs(struct net_device *netdev, u32 sq_depth,
+			     struct hinic3_tx_info *tx_info_arr)
+{
+	struct hinic3_tx_info *tx_info;
+	u32 idx;
+
+	for (idx = 0; idx < sq_depth; idx++) {
+		tx_info = &tx_info_arr[idx];
+		if (tx_info->skb)
+			tx_free_skb(netdev, tx_info);
+	}
+}
+
 union hinic3_ip {
 	struct iphdr   *v4;
 	struct ipv6hdr *v6;
@@ -671,6 +684,86 @@ int hinic3_flush_txqs(struct net_device *netdev)
 #define HINIC3_BDS_PER_SQ_WQEBB \
 	(HINIC3_SQ_WQEBB_SIZE / sizeof(struct hinic3_sq_bufdesc))
 
+int hinic3_alloc_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res)
+{
+	struct hinic3_dyna_txq_res *tqres;
+	int idx, i;
+	u64 size;
+
+	for (idx = 0; idx < num_sq; idx++) {
+		tqres = &txqs_res[idx];
+
+		size = sizeof(*tqres->tx_info) * sq_depth;
+		tqres->tx_info = kzalloc(size, GFP_KERNEL);
+		if (!tqres->tx_info)
+			goto err_out;
+
+		size = sizeof(*tqres->bds) *
+			(sq_depth * HINIC3_BDS_PER_SQ_WQEBB +
+			 HINIC3_MAX_SQ_SGE);
+		tqres->bds = kzalloc(size, GFP_KERNEL);
+		if (!tqres->bds) {
+			kfree(tqres->tx_info);
+			goto err_out;
+		}
+	}
+
+	return 0;
+
+err_out:
+	for (i = 0; i < idx; i++) {
+		tqres = &txqs_res[i];
+
+		kfree(tqres->bds);
+		kfree(tqres->tx_info);
+	}
+
+	return -ENOMEM;
+}
+
+void hinic3_free_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res)
+{
+	struct hinic3_dyna_txq_res *tqres;
+	int idx;
+
+	for (idx = 0; idx < num_sq; idx++) {
+		tqres = &txqs_res[idx];
+
+		free_all_tx_skbs(netdev, sq_depth, tqres->tx_info);
+		kfree(tqres->bds);
+		kfree(tqres->tx_info);
+	}
+}
+
+int hinic3_configure_txqs(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dyna_txq_res *tqres;
+	struct hinic3_txq *txq;
+	u16 q_id;
+	u32 idx;
+
+	for (q_id = 0; q_id < num_sq; q_id++) {
+		txq = &nic_dev->txqs[q_id];
+		tqres = &txqs_res[q_id];
+
+		txq->q_depth = sq_depth;
+		txq->q_mask = sq_depth - 1;
+
+		txq->tx_info = tqres->tx_info;
+		for (idx = 0; idx < sq_depth; idx++)
+			txq->tx_info[idx].dma_info =
+				&tqres->bds[idx * HINIC3_BDS_PER_SQ_WQEBB];
+
+		txq->sq = &nic_dev->nic_io->sq[q_id];
+	}
+
+	return 0;
+}
+
 int hinic3_tx_poll(struct hinic3_txq *txq, int budget)
 {
 	struct net_device *netdev = txq->netdev;
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
index 7b4cb4608353..3185d0c21872 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -119,9 +119,21 @@ struct hinic3_txq {
 	struct hinic3_io_queue  *sq;
 } ____cacheline_aligned;
 
+struct hinic3_dyna_txq_res {
+	struct hinic3_tx_info  *tx_info;
+	struct hinic3_dma_info *bds;
+};
+
 int hinic3_alloc_txqs(struct net_device *netdev);
 void hinic3_free_txqs(struct net_device *netdev);
 
+int hinic3_alloc_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
+void hinic3_free_txqs_res(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
+int hinic3_configure_txqs(struct net_device *netdev, u16 num_sq,
+			  u32 sq_depth, struct hinic3_dyna_txq_res *txqs_res);
+
 netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
 int hinic3_tx_poll(struct hinic3_txq *txq, int budget);
 int hinic3_flush_txqs(struct net_device *netdev);
-- 
2.45.2


