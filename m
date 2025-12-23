Return-Path: <netdev+bounces-245798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67596CD8009
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 94A4E30019CC
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048422DA76C;
	Tue, 23 Dec 2025 03:52:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-34.us.a.mail.aliyun.com (out198-34.us.a.mail.aliyun.com [47.90.198.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65832DC320;
	Tue, 23 Dec 2025 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461940; cv=none; b=gmEQhBFIfzfEUjHuTyj7yWh4+u1skUdX+vur1pyeO158MU7aPTHrkLQTxDKrV519QBbs1Boim9RQnuPWc++XKFoDYhAAbECZyMvuhdqZjkaZHcRc/OfGbz5T3xtMsm8XHeXKoDlfIZ6pAH2LUWf7NusF1as4tijyV4gQr+hcrGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461940; c=relaxed/simple;
	bh=/h9xZewUh9Sgt89JzqP5VN+Gwprk57ffoapGT7EjpXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+3mcHDxACdPj/7XJ2YJsL8P486SQkp72fL1ak/qN3u+qndOxOPef3ddqZucrSwHDZcdJa6/KGNQvmSlkMweuBC18Rjbtn3aYOPeiIfgX+uav+qW81dX5oTH+T8TnotJxOfTvNMb6h2xgVhawvZaT6FmMM+LRPowOEVUmUjQ1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.fqrxX0W_1766461910 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 11:51:52 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 net-next 12/15] net/nebula-matrix: add Dev layer definitions and implementation
Date: Tue, 23 Dec 2025 11:50:35 +0800
Message-ID: <20251223035113.31122-13-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

some import steps in dev init:
1.init common dev:setup mailbox channel queue,alloc mbx task,alloc
reset task,register mailbox chan task, register common irq and etc.
2.init ctrl dev: register ctrl irq, init chip, start_mgt_flow,set chan qinfo,
setup adminq channel queue, register adminq chan task , alloc some task and etc.
3.init net dev: build, register and set up vsi, register net irq and etc.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
Change-Id: I95a9bae6a02fb6fdce0475d2a6fa75793ac2c98e
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    2 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   16 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      | 1527 ++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |  303 ++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  | 1556 +++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_service.h  |   20 +
 .../nebula-matrix/nbl/nbl_core/nbl_sysfs.c    |   79 +
 .../nebula-matrix/nbl/nbl_core/nbl_sysfs.h    |   21 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |    6 +-
 .../nbl_hw_leonis/nbl_resource_leonis.c       |    4 +-
 .../nbl/nbl_include/nbl_def_common.h          |    9 +
 .../nbl/nbl_include/nbl_def_dev.h             |   27 +
 .../nbl/nbl_include/nbl_def_service.h         |   81 +
 .../nbl/nbl_include/nbl_include.h             |   43 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |   55 +
 15 files changed, 3746 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index bb324feb5cc3..ef4e5d4da034 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -19,6 +19,8 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_adminq.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_service.o \
+				nbl_core/nbl_sysfs.o \
+				nbl_core/nbl_dev.o \
 				nbl_main.o
 
 # Do not modify include path, unless you are adding a new file which needs some headers in its
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 12d9fef345b6..96e00bcc5ff4 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -13,6 +13,7 @@
 #include "nbl_def_resource.h"
 #include "nbl_def_dispatch.h"
 #include "nbl_def_service.h"
+#include "nbl_def_dev.h"
 #include "nbl_def_common.h"
 
 #define NBL_ADAPTER_TO_PDEV(adapter)		((adapter)->pdev)
@@ -24,11 +25,13 @@
 #define NBL_ADAPTER_TO_RES_MGT(adapter)		((adapter)->core.res_mgt)
 #define NBL_ADAPTER_TO_DISP_MGT(adapter)	((adapter)->core.disp_mgt)
 #define NBL_ADAPTER_TO_SERV_MGT(adapter)	((adapter)->core.serv_mgt)
+#define NBL_ADAPTER_TO_DEV_MGT(adapter)		((adapter)->core.dev_mgt)
 #define NBL_ADAPTER_TO_CHAN_MGT(adapter)	((adapter)->core.chan_mgt)
 #define NBL_ADAPTER_TO_HW_OPS_TBL(adapter)	((adapter)->intf.hw_ops_tbl)
 #define NBL_ADAPTER_TO_RES_OPS_TBL(adapter)	((adapter)->intf.resource_ops_tbl)
 #define NBL_ADAPTER_TO_DISP_OPS_TBL(adapter)	((adapter)->intf.dispatch_ops_tbl)
 #define NBL_ADAPTER_TO_SERV_OPS_TBL(adapter)	((adapter)->intf.service_ops_tbl)
+#define NBL_ADAPTER_TO_DEV_OPS_TBL(adapter)	((adapter)->intf.dev_ops_tbl)
 #define NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter)	((adapter)->intf.channel_ops_tbl)
 
 #define NBL_ADAPTER_TO_RES_PT_OPS(adapter)	(&(NBL_ADAPTER_TO_SERV_OPS_TBL(adapter)->pt_ops))
@@ -88,6 +91,7 @@ struct nbl_interface {
 	struct nbl_resource_ops_tbl *resource_ops_tbl;
 	struct nbl_dispatch_ops_tbl *dispatch_ops_tbl;
 	struct nbl_service_ops_tbl *service_ops_tbl;
+	struct nbl_dev_ops_tbl *dev_ops_tbl;
 	struct nbl_channel_ops_tbl *channel_ops_tbl;
 };
 
@@ -122,6 +126,18 @@ struct nbl_netdev_priv {
 	s64 last_st_time;
 };
 
+#define NBL_ST_MAX_DEVICE_NUM			96
+struct nbl_software_tool_table {
+	DECLARE_BITMAP(devid, NBL_ST_MAX_DEVICE_NUM);
+	int major;
+	dev_t devno;
+	struct class *cls;
+};
+
 struct nbl_adapter *nbl_core_init(struct pci_dev *pdev, struct nbl_init_param *param);
 void nbl_core_remove(struct nbl_adapter *adapter);
+
+int nbl_st_init(struct nbl_software_tool_table *st_table);
+void nbl_st_remove(struct nbl_software_tool_table *st_table);
+struct nbl_software_tool_table *nbl_get_st_table(void);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
new file mode 100644
index 000000000000..853dd5469f60
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -0,0 +1,1527 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include <linux/time.h>
+#include <linux/rtc.h>
+#include "nbl_dev.h"
+
+static int debug = -1;
+module_param(debug, int, 0);
+MODULE_PARM_DESC(debug, "netif debug level (0=none,...,16=all), adapter debug_mask (<-1)");
+
+static int net_msix_mask_en = 1;
+module_param(net_msix_mask_en, int, 0);
+MODULE_PARM_DESC(net_msix_mask_en, "net msix interrupt mask enable");
+
+int performance_mode = 3;
+module_param(performance_mode, int, 0);
+MODULE_PARM_DESC(performance_mode, "performance_mode");
+
+int restore_eth = 1;
+module_param(restore_eth, int, 0);
+MODULE_PARM_DESC(restore_eth, "restore_eth");
+static struct nbl_dev_board_id_table board_id_table;
+
+struct nbl_dev_ops dev_ops;
+
+static void nbl_dev_handle_fatal_err(struct nbl_dev_mgt *dev_mgt);
+static int nbl_dev_setup_st_dev(struct nbl_adapter *adapter, struct nbl_init_param *param);
+static void nbl_dev_remove_st_dev(struct nbl_adapter *adapter);
+
+/* ----------  Basic functions  ---------- */
+static int nbl_dev_alloc_board_id(struct nbl_dev_board_id_table *index_table, u32 board_key)
+{
+	int i = 0;
+
+	for (i = 0; i < NBL_DEV_BOARD_ID_MAX; i++) {
+		if (index_table->entry[i].board_key == board_key) {
+			index_table->entry[i].refcount++;
+			return i;
+		}
+	}
+
+	for (i = 0; i < NBL_DEV_BOARD_ID_MAX; i++) {
+		if (!index_table->entry[i].valid) {
+			index_table->entry[i].board_key = board_key;
+			index_table->entry[i].refcount++;
+			index_table->entry[i].valid = true;
+			return i;
+		}
+	}
+
+	return -ENOSPC;
+}
+
+static void nbl_dev_free_board_id(struct nbl_dev_board_id_table *index_table, u32 board_key)
+{
+	int i = 0;
+
+	for (i = 0; i < NBL_DEV_BOARD_ID_MAX; i++) {
+		if (index_table->entry[i].board_key == board_key && index_table->entry[i].valid) {
+			index_table->entry[i].refcount--;
+			break;
+		}
+	}
+
+	if (i != NBL_DEV_BOARD_ID_MAX && !index_table->entry[i].refcount)
+		memset(&index_table->entry[i], 0, sizeof(index_table->entry[i]));
+}
+
+/* ----------  Interrupt config  ---------- */
+static void nbl_dev_handle_abnormal_event(struct work_struct *work)
+{
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       clean_abnormal_irq_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->process_abnormal_event(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+}
+
+static void nbl_dev_register_common_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_irq_num irq_num = {0};
+
+	serv_ops->get_common_irq_num(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &irq_num);
+	msix_info->serv_info[NBL_MSIX_MAILBOX_TYPE].num = irq_num.mbx_irq_num;
+}
+
+static void nbl_dev_register_net_irq(struct nbl_dev_mgt *dev_mgt, u16 queue_num)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+
+	msix_info->serv_info[NBL_MSIX_NET_TYPE].num = queue_num;
+	msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en = net_msix_mask_en;
+}
+
+static void nbl_dev_register_ctrl_irq(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_common *dev_common = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+	struct nbl_msix_info *msix_info = NBL_DEV_COMMON_TO_MSIX_INFO(dev_common);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_ctrl_irq_num irq_num = {0};
+
+	serv_ops->get_ctrl_irq_num(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &irq_num);
+
+	msix_info->serv_info[NBL_MSIX_ABNORMAL_TYPE].num = irq_num.abnormal_irq_num;
+	msix_info->serv_info[NBL_MSIX_ADMINDQ_TYPE].num = irq_num.adminq_irq_num;
+}
+
+/* ----------  Channel config  ---------- */
+static int nbl_dev_setup_chan_qinfo(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	int ret = 0;
+
+	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		return 0;
+
+	ret = chan_ops->cfg_chan_qinfo_map_table(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+						 chan_type);
+	if (ret)
+		dev_err(dev, "setup chan:%d, qinfo map table failed\n", chan_type);
+
+	return ret;
+}
+
+static int nbl_dev_setup_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	int ret = 0;
+
+	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		ret = chan_ops->setup_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
+
+	return ret;
+}
+
+static int nbl_dev_remove_chan_queue(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	int ret = 0;
+
+	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		ret = chan_ops->teardown_queue(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
+
+	return ret;
+}
+
+static void nbl_dev_remove_chan_keepalive(struct nbl_dev_mgt *dev_mgt, u8 chan_type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		chan_ops->remove_keepalive(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type);
+}
+
+static void nbl_dev_register_chan_task(struct nbl_dev_mgt *dev_mgt,
+				       u8 chan_type, struct work_struct *task)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	if (chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type))
+		chan_ops->register_chan_task(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), chan_type, task);
+}
+
+/* ----------  Tasks config  ---------- */
+static void nbl_dev_clean_mailbox_task(struct work_struct *work)
+{
+	struct nbl_dev_common *common_dev = container_of(work, struct nbl_dev_common,
+							 clean_mbx_task);
+	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_TYPE_MAILBOX);
+}
+
+static void nbl_dev_prepare_reset_task(struct work_struct *work)
+{
+	int ret;
+	struct nbl_reset_task_info *task_info = container_of(work, struct nbl_reset_task_info,
+							     task);
+	struct nbl_dev_common *common_dev = container_of(task_info, struct nbl_dev_common,
+							 reset_task);
+	struct nbl_dev_mgt *dev_mgt = common_dev->dev_mgt;
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_chan_send_info chan_send;
+
+	serv_ops->netdev_stop(dev_mgt->net_dev->netdev);
+	netif_device_detach(dev_mgt->net_dev->netdev); /* to avoid ethtool operation */
+	nbl_dev_remove_chan_keepalive(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common), NBL_CHAN_MSG_ACK_RESET_EVENT, NULL,
+		      0, NULL, 0, 0);
+	/* notify ctrl dev, finish reset event process */
+	ret = chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+	chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
+				  NBL_CHAN_TYPE_MAILBOX, true);
+
+	/* sleep to avoid send_msg is running */
+	usleep_range(10, 20);
+
+	/* ctrl dev must shutdown phy reg read/write after ctrl dev has notify emp shutdown dev */
+	if (!NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt))
+		serv_ops->set_hw_status(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_HW_FATAL_ERR);
+}
+
+static void nbl_dev_clean_adminq_task(struct work_struct *work)
+{
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       clean_adminq_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	chan_ops->clean_queue_subtask(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_TYPE_ADMINQ);
+}
+
+static void nbl_dev_fw_heartbeat_task(struct work_struct *work)
+{
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       fw_hb_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+
+	if (task_info->fw_resetting)
+		return;
+
+	if (!serv_ops->check_fw_heartbeat(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt))) {
+		dev_notice(NBL_COMMON_TO_DEV(common), "FW reset detected");
+		task_info->fw_resetting = true;
+		chan_ops->set_queue_state(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_ABNORMAL,
+					NBL_CHAN_TYPE_ADMINQ, true);
+		nbl_common_queue_delayed_work(&task_info->fw_reset_task, MSEC_PER_SEC, true);
+	}
+}
+
+static void nbl_dev_fw_reset_task(struct work_struct *work)
+{
+}
+
+static void nbl_dev_adapt_desc_gother_task(struct work_struct *work)
+{
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       adapt_desc_gother_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->adapt_desc_gother(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+}
+
+static void nbl_dev_recovery_abnormal_task(struct work_struct *work)
+{
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       recovery_abnormal_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->recovery_abnormal(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+}
+
+static void nbl_dev_ctrl_reset_task(struct work_struct *work)
+{
+	struct nbl_task_info *task_info = container_of(work, struct nbl_task_info,
+						       reset_task);
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+
+	nbl_dev_handle_fatal_err(dev_mgt);
+}
+
+static void nbl_dev_ctrl_task_schedule(struct nbl_task_info *task_info)
+{
+	struct nbl_dev_mgt *dev_mgt = task_info->dev_mgt;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_FW_HB_CAP))
+		nbl_common_queue_work(&task_info->fw_hb_task, true);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_ADAPT_DESC_GOTHER))
+		nbl_common_queue_work(&task_info->adapt_desc_gother_task, true);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_RECOVERY_ABNORMAL_STATUS))
+		nbl_common_queue_work(&task_info->recovery_abnormal_task, true);
+}
+
+static void nbl_dev_ctrl_task_timer(struct timer_list *t)
+{
+	struct nbl_task_info *task_info = container_of(t, struct nbl_task_info, serv_timer);
+
+	mod_timer(&task_info->serv_timer, round_jiffies(task_info->serv_timer_period + jiffies));
+	nbl_dev_ctrl_task_schedule(task_info);
+}
+
+static void nbl_dev_chan_notify_flr_resp(void *priv, u16 src_id, u16 msg_id,
+					 void *data, u32 data_len)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	u16 vfid;
+
+	vfid = *(u16 *)data;
+	serv_ops->process_flr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), vfid);
+}
+
+static void nbl_dev_ctrl_register_flr_chan_msg(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   NBL_PROCESS_FLR_CAP))
+		return;
+
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_ADMINQ_FLR_NOTIFY,
+			       nbl_dev_chan_notify_flr_resp, dev_mgt);
+}
+
+static struct nbl_dev_temp_alarm_info temp_alarm_info[NBL_TEMP_STATUS_MAX] = {
+	{LOGLEVEL_WARNING, "High temperature on sensors0 resumed.\n"},
+	{LOGLEVEL_WARNING, "High temperature on sensors0 observed, security(WARNING).\n"},
+	{LOGLEVEL_CRIT, "High temperature on sensors0 observed, security(CRITICAL).\n"},
+	{LOGLEVEL_EMERG, "High temperature on sensors0 observed, security(EMERGENCY).\n"},
+};
+
+static void nbl_dev_handle_temp_ext(struct nbl_dev_mgt *dev_mgt, u8 *data, u16 data_len)
+{
+	u16 temp = (u16)*data;
+	u64 uptime = 0;
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	enum nbl_dev_temp_status old_temp_status = ctrl_dev->temp_status;
+	enum nbl_dev_temp_status new_temp_status = NBL_TEMP_STATUS_NORMAL;
+
+	/* no resume if temp exceed NBL_TEMP_EMERG_THRESHOLD, even if the temp resume nomal.
+	 * Because the hw has shutdown.
+	 */
+	if (old_temp_status == NBL_TEMP_STATUS_EMERG)
+		return;
+
+	/* if temp in (85-105) and not in normal_status, no resume to avoid alarm oscillate */
+	if (temp > NBL_TEMP_NOMAL_THRESHOLD &&
+	    temp < NBL_TEMP_WARNING_THRESHOLD &&
+	    old_temp_status > NBL_TEMP_STATUS_NORMAL)
+		return;
+
+	if (temp >= NBL_TEMP_WARNING_THRESHOLD &&
+	    temp < NBL_TEMP_CRIT_THRESHOLD)
+		new_temp_status = NBL_TEMP_STATUS_WARNING;
+	else if (temp >= NBL_TEMP_CRIT_THRESHOLD &&
+		 temp < NBL_TEMP_EMERG_THRESHOLD)
+		new_temp_status = NBL_TEMP_STATUS_CRIT;
+	else if (temp >= NBL_TEMP_EMERG_THRESHOLD)
+		new_temp_status = NBL_TEMP_STATUS_EMERG;
+
+	if (new_temp_status == old_temp_status)
+		return;
+
+	ctrl_dev->temp_status = new_temp_status;
+
+	/* temp fall only alarm when the alarm need to resume */
+	if (new_temp_status < old_temp_status && new_temp_status != NBL_TEMP_STATUS_NORMAL)
+		return;
+
+	if (data_len > sizeof(u16))
+		uptime = *(u64 *)(data + sizeof(u16));
+	nbl_log(common, temp_alarm_info[new_temp_status].logvel,
+		"[%llu] %s", uptime, temp_alarm_info[new_temp_status].alarm_info);
+
+	if (new_temp_status == NBL_TEMP_STATUS_EMERG) {
+		ctrl_dev->task_info.reset_event = NBL_HW_FATAL_ERR_EVENT;
+		nbl_common_queue_work(&ctrl_dev->task_info.reset_task, false);
+	}
+}
+
+static const char *nbl_log_level_name(int level)
+{
+	switch (level) {
+	case NBL_EMP_ALERT_LOG_FATAL:
+		return "FATAL";
+	case NBL_EMP_ALERT_LOG_ERROR:
+		return "ERROR";
+	case NBL_EMP_ALERT_LOG_WARNING:
+		return "WARNING";
+	case NBL_EMP_ALERT_LOG_INFO:
+		return "INFO";
+	default:
+		return "UNKNOWN";
+	}
+}
+
+static void nbl_dev_handle_emp_log_ext(struct nbl_dev_mgt *dev_mgt, u8 *data, u16 data_len)
+{
+	struct nbl_emp_alert_log_event *log_event = (struct nbl_emp_alert_log_event *)data;
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+
+	nbl_log(common, LOGLEVEL_INFO, "[FW][%llu] <%s> %.*s", log_event->uptime,
+		nbl_log_level_name(log_event->level), data_len - sizeof(u64) - sizeof(u8),
+		log_event->data);
+}
+
+static void nbl_dev_chan_notify_evt_alert_resp(void *priv, u16 src_id, u16 msg_id,
+					       void *data, u32 data_len)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	struct nbl_chan_param_emp_alert_event *alert_param =
+						(struct nbl_chan_param_emp_alert_event *)data;
+
+	switch (alert_param->type) {
+	case NBL_EMP_EVENT_TEMP_ALERT:
+		nbl_dev_handle_temp_ext(dev_mgt, alert_param->data, alert_param->len);
+		return;
+	case NBL_EMP_EVENT_LOG_ALERT:
+		nbl_dev_handle_emp_log_ext(dev_mgt, alert_param->data, alert_param->len);
+		return;
+	default:
+		return;
+	}
+}
+
+static void nbl_dev_ctrl_register_emp_ext_alert_chan_msg(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_ADMINQ_EXT_ALERT,
+			       nbl_dev_chan_notify_evt_alert_resp, dev_mgt);
+}
+
+static int nbl_dev_setup_ctrl_dev_task(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	task_info->dev_mgt = dev_mgt;
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_FW_HB_CAP)) {
+		nbl_common_alloc_task(&task_info->fw_hb_task, nbl_dev_fw_heartbeat_task);
+		task_info->timer_setup = true;
+	}
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_FW_RESET_CAP)) {
+		nbl_common_alloc_delayed_task(&task_info->fw_reset_task, nbl_dev_fw_reset_task);
+		task_info->timer_setup = true;
+	}
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_ADMINDQ_CAP)) {
+		nbl_common_alloc_task(&task_info->clean_adminq_task, nbl_dev_clean_adminq_task);
+		task_info->timer_setup = true;
+	}
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_ADAPT_DESC_GOTHER)) {
+		nbl_common_alloc_task(&task_info->adapt_desc_gother_task,
+				      nbl_dev_adapt_desc_gother_task);
+		task_info->timer_setup = true;
+	}
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_RECOVERY_ABNORMAL_STATUS)) {
+		nbl_common_alloc_task(&task_info->recovery_abnormal_task,
+				      nbl_dev_recovery_abnormal_task);
+		task_info->timer_setup = true;
+	}
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_RESET_CTRL_CAP))
+		nbl_common_alloc_task(&task_info->reset_task, &nbl_dev_ctrl_reset_task);
+
+	nbl_common_alloc_task(&task_info->clean_abnormal_irq_task,
+			      nbl_dev_handle_abnormal_event);
+
+	if (task_info->timer_setup) {
+		timer_setup(&task_info->serv_timer, nbl_dev_ctrl_task_timer, 0);
+		task_info->serv_timer_period = HZ;
+	}
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_ADMINQ, &task_info->clean_adminq_task);
+
+	return 0;
+}
+
+static void nbl_dev_remove_ctrl_dev_task(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_ctrl *ctrl_dev = NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_task_info *task_info = NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev);
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_ADMINQ, NULL);
+
+	nbl_common_release_task(&task_info->clean_abnormal_irq_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_FW_RESET_CAP))
+		nbl_common_release_delayed_task(&task_info->fw_reset_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_FW_HB_CAP))
+		nbl_common_release_task(&task_info->fw_hb_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_ADMINDQ_CAP))
+		nbl_common_release_task(&task_info->clean_adminq_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_ADAPT_DESC_GOTHER))
+		nbl_common_release_task(&task_info->adapt_desc_gother_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_RECOVERY_ABNORMAL_STATUS))
+		nbl_common_release_task(&task_info->recovery_abnormal_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_RESET_CTRL_CAP))
+		nbl_common_release_task(&task_info->reset_task);
+}
+
+static int nbl_dev_update_template_config(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->update_template_config(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+}
+
+/* ----------  Dev init process  ---------- */
+static int nbl_dev_setup_common_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_common *common_dev;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	int board_id;
+
+	common_dev = devm_kzalloc(NBL_ADAPTER_TO_DEV(adapter),
+				  sizeof(struct nbl_dev_common), GFP_KERNEL);
+	if (!common_dev)
+		return -ENOMEM;
+	common_dev->dev_mgt = dev_mgt;
+
+	if (nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX))
+		goto setup_chan_fail;
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_MAILBOX_CAP))
+		nbl_common_alloc_task(&common_dev->clean_mbx_task, nbl_dev_clean_mailbox_task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_RESET_CAP))
+		nbl_common_alloc_task(&common_dev->reset_task.task, &nbl_dev_prepare_reset_task);
+
+	if (param->caps.is_nic) {
+		board_id = serv_ops->get_board_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+		if (board_id < 0)
+			goto get_board_id_fail;
+		NBL_COMMON_TO_BOARD_ID(common) = board_id;
+	}
+
+	NBL_COMMON_TO_VSI_ID(common) = serv_ops->get_vsi_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), 0,
+							    NBL_VSI_DATA);
+
+	serv_ops->get_eth_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_COMMON_TO_VSI_ID(common),
+			     &NBL_COMMON_TO_ETH_MODE(common), &NBL_COMMON_TO_ETH_ID(common),
+			     &NBL_COMMON_TO_LOGIC_ETH_ID(common));
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, &common_dev->clean_mbx_task);
+
+	NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt) = common_dev;
+
+	nbl_dev_register_common_irq(dev_mgt);
+
+	return 0;
+
+get_board_id_fail:
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_RESET_CAP))
+		nbl_common_release_task(&common_dev->reset_task.task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_MAILBOX_CAP))
+		nbl_common_release_task(&common_dev->clean_mbx_task);
+setup_chan_fail:
+	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), common_dev);
+	return -EFAULT;
+}
+
+static void nbl_dev_remove_common_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_common *common_dev = NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt);
+
+	if (!common_dev)
+		return;
+
+	nbl_dev_register_chan_task(dev_mgt, NBL_CHAN_TYPE_MAILBOX, NULL);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_RESET_CAP))
+		nbl_common_release_task(&common_dev->reset_task.task);
+
+	if (serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  NBL_TASK_CLEAN_MAILBOX_CAP))
+		nbl_common_release_task(&common_dev->clean_mbx_task);
+
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_MAILBOX);
+
+	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), common_dev);
+	NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt) = NULL;
+}
+
+static int nbl_dev_setup_ctrl_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_ctrl *ctrl_dev;
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	int i, ret = 0;
+	u32 board_key;
+	char part_number[50] = "";
+	char serial_number[128] = "";
+	int board_id;
+
+	board_key = pci_domain_nr(dev_mgt->common->pdev->bus) << 16 |
+			dev_mgt->common->pdev->bus->number;
+	if (param->caps.is_nic) {
+		board_id =
+			nbl_dev_alloc_board_id(&board_id_table, board_key);
+		if (board_id < 0)
+			return -ENOSPC;
+		NBL_COMMON_TO_BOARD_ID(common) =  board_id;
+	}
+
+	dev_info(dev, "board_key 0x%x alloc board id 0x%x\n",
+		 board_key, NBL_COMMON_TO_BOARD_ID(common));
+
+	ctrl_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_ctrl), GFP_KERNEL);
+	if (!ctrl_dev)
+		goto alloc_fail;
+	NBL_DEV_CTRL_TO_TASK_INFO(ctrl_dev)->adapter = adapter;
+	NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt) = ctrl_dev;
+
+	nbl_dev_register_ctrl_irq(dev_mgt);
+
+	ctrl_dev->ctrl_dev_wq1 = create_singlethread_workqueue("nbl_ctrldev_wq1");
+	if (!ctrl_dev->ctrl_dev_wq1) {
+		dev_err(dev, "Failed to create workqueue nbl_ctrldev_wq1\n");
+		goto alloc_wq_fail;
+	}
+
+	ret = serv_ops->init_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	if (ret) {
+		dev_err(dev, "ctrl dev chip_init failed\n");
+		goto chip_init_fail;
+	}
+
+	ret = serv_ops->start_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	if (ret) {
+		dev_err(dev, "ctrl dev start_mgt_flow failed\n");
+		goto mgt_flow_fail;
+	}
+
+	for (i = 0; i < NBL_CHAN_TYPE_MAX; i++) {
+		ret = nbl_dev_setup_chan_qinfo(dev_mgt, i);
+		if (ret) {
+			dev_err(dev, "ctrl dev setup chan qinfo failed\n");
+				goto setup_chan_q_fail;
+		}
+	}
+
+	nbl_dev_ctrl_register_flr_chan_msg(dev_mgt);
+	nbl_dev_ctrl_register_emp_ext_alert_chan_msg(dev_mgt);
+
+	ret = nbl_dev_setup_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+	if (ret) {
+		dev_err(dev, "ctrl dev setup chan queue failed\n");
+			goto setup_chan_q_fail;
+	}
+
+	ret = nbl_dev_setup_ctrl_dev_task(dev_mgt);
+	if (ret) {
+		dev_err(dev, "ctrl dev task failed\n");
+		goto setup_ctrl_dev_task_fail;
+	}
+
+	serv_ops->get_part_number(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), part_number);
+	serv_ops->get_serial_number(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), serial_number);
+	dev_info(dev, "part number: %s, serial number: %s\n", part_number, serial_number);
+
+	nbl_dev_update_template_config(dev_mgt);
+
+	return 0;
+
+setup_ctrl_dev_task_fail:
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+setup_chan_q_fail:
+	serv_ops->stop_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+mgt_flow_fail:
+	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+chip_init_fail:
+	destroy_workqueue(ctrl_dev->ctrl_dev_wq1);
+alloc_wq_fail:
+	devm_kfree(dev, ctrl_dev);
+	NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt) = NULL;
+alloc_fail:
+	nbl_dev_free_board_id(&board_id_table, board_key);
+	return ret;
+}
+
+static void nbl_dev_remove_ctrl_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_ctrl **ctrl_dev = &NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	u32 board_key;
+
+	if (!*ctrl_dev)
+		return;
+
+	board_key = pci_domain_nr(dev_mgt->common->pdev->bus) << 16 |
+			dev_mgt->common->pdev->bus->number;
+	nbl_dev_remove_chan_queue(dev_mgt, NBL_CHAN_TYPE_ADMINQ);
+	nbl_dev_remove_ctrl_dev_task(dev_mgt);
+
+	serv_ops->stop_mgt_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	serv_ops->destroy_chip(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+
+	destroy_workqueue((*ctrl_dev)->ctrl_dev_wq1);
+	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), *ctrl_dev);
+	*ctrl_dev = NULL;
+
+	/* If it is not nic, this free function will do nothing, so no need check */
+	nbl_dev_free_board_id(&board_id_table, board_key);
+}
+
+static int nbl_dev_netdev_open(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->netdev_open(netdev);
+}
+
+static int nbl_dev_netdev_stop(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->netdev_stop(netdev);
+}
+
+static netdev_tx_t nbl_dev_start_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_resource_pt_ops *pt_ops = NBL_DEV_MGT_TO_RES_PT_OPS(dev_mgt);
+
+	return pt_ops->start_xmit(skb, netdev);
+}
+
+static void nbl_dev_netdev_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->get_stats64(netdev, stats);
+}
+
+static int nbl_dev_netdev_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->rx_add_vid(netdev, proto, vid);
+}
+
+static int nbl_dev_netdev_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	return serv_ops->rx_kill_vid(netdev, proto, vid);
+}
+
+static const struct net_device_ops netdev_ops_leonis_pf = {
+	.ndo_open = nbl_dev_netdev_open,
+	.ndo_stop = nbl_dev_netdev_stop,
+	.ndo_start_xmit = nbl_dev_start_xmit,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
+	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
+
+};
+
+static const struct net_device_ops netdev_ops_leonis_vf = {
+	.ndo_open = nbl_dev_netdev_open,
+	.ndo_stop = nbl_dev_netdev_stop,
+	.ndo_start_xmit = nbl_dev_start_xmit,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_get_stats64 = nbl_dev_netdev_get_stats64,
+	.ndo_vlan_rx_add_vid = nbl_dev_netdev_rx_add_vid,
+	.ndo_vlan_rx_kill_vid = nbl_dev_netdev_rx_kill_vid,
+
+};
+
+static int nbl_dev_setup_netops_leonis(void *priv, struct net_device *netdev,
+				       struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	bool is_vf = param->caps.is_vf;
+
+	if (is_vf) {
+		netdev->netdev_ops = &netdev_ops_leonis_vf;
+	} else {
+		netdev->netdev_ops = &netdev_ops_leonis_pf;
+		serv_ops->set_netdev_ops(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					 &netdev_ops_leonis_pf, true);
+	}
+	return 0;
+}
+
+static int nbl_dev_register_net(struct nbl_dev_mgt *dev_mgt,
+				struct nbl_register_net_result *register_result)
+{
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct pci_dev *pdev = NBL_COMMON_TO_PDEV(NBL_DEV_MGT_TO_COMMON(dev_mgt));
+#ifdef CONFIG_PCI_IOV
+	struct resource *res;
+#endif
+	u16 pf_bdf;
+	u64 pf_bar_start;
+	u64 vf_bar_start, vf_bar_size;
+	u16 total_vfs = 0, offset, stride;
+	int pos;
+	u32 val;
+	struct nbl_register_net_param register_param = {0};
+	int ret = 0;
+
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0, &val);
+	pf_bar_start = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
+	pci_read_config_dword(pdev, PCI_BASE_ADDRESS_0 + 4, &val);
+	pf_bar_start |= ((u64)val << 32);
+
+	register_param.pf_bar_start = pf_bar_start;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (pos) {
+		pf_bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
+
+		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_OFFSET, &offset);
+		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_STRIDE, &stride);
+		pci_read_config_word(pdev, pos + PCI_SRIOV_TOTAL_VF, &total_vfs);
+
+		pci_read_config_dword(pdev, pos + PCI_SRIOV_BAR, &val);
+		vf_bar_start = (u64)(val & PCI_BASE_ADDRESS_MEM_MASK);
+		pci_read_config_dword(pdev, pos + PCI_SRIOV_BAR + 4, &val);
+		vf_bar_start |= ((u64)val << 32);
+
+#ifdef CONFIG_PCI_IOV
+		res = &pdev->resource[PCI_IOV_RESOURCES];
+		vf_bar_size = resource_size(res);
+#else
+		vf_bar_size = 0;
+#endif
+		if (total_vfs) {
+			register_param.pf_bdf = pf_bdf;
+			register_param.vf_bar_start = vf_bar_start;
+			register_param.vf_bar_size = vf_bar_size;
+			register_param.total_vfs = total_vfs;
+			register_param.offset = offset;
+			register_param.stride = stride;
+		}
+	}
+
+	net_dev->total_vfs = total_vfs;
+
+	ret = serv_ops->register_net(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				     &register_param, register_result);
+
+	if (!register_result->tx_queue_num || !register_result->rx_queue_num)
+		return -EIO;
+
+	return ret;
+}
+
+static void nbl_dev_unregister_net(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct device *dev = NBL_DEV_MGT_TO_DEV(dev_mgt);
+	int ret;
+
+	ret = serv_ops->unregister_net(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt));
+	if (ret)
+		dev_err(dev, "unregister net failed\n");
+}
+
+static u16 nbl_dev_vsi_alloc_queue(struct nbl_dev_net *net_dev, u16 queue_num)
+{
+	struct nbl_dev_vsi_controller *vsi_ctrl = &net_dev->vsi_ctrl;
+	u16 queue_offset = 0;
+
+	if (vsi_ctrl->queue_free_offset + queue_num > net_dev->total_queue_num)
+		return -ENOSPC;
+
+	queue_offset = vsi_ctrl->queue_free_offset;
+	vsi_ctrl->queue_free_offset += queue_num;
+
+	return queue_offset;
+}
+
+static int nbl_dev_vsi_common_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				    struct nbl_dev_vsi *vsi)
+{
+	int ret = 0;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_vsi_param vsi_param = {0};
+
+	vsi->queue_offset = nbl_dev_vsi_alloc_queue(NBL_DEV_MGT_TO_NET_DEV(dev_mgt),
+						    vsi->queue_num);
+	vsi_param.index = vsi->index;
+	vsi_param.vsi_id = vsi->vsi_id;
+	vsi_param.queue_offset = vsi->queue_offset;
+	vsi_param.queue_num = vsi->queue_num;
+
+	/* Tell serv & res layer the mapping from vsi to queue_id */
+	ret = serv_ops->register_vsi_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &vsi_param);
+	return ret;
+}
+
+static void nbl_dev_vsi_common_remove(struct nbl_dev_mgt *dev_mgt, struct nbl_dev_vsi *vsi)
+{
+}
+
+static int nbl_dev_vsi_data_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				     void *vsi_data)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	int ret = 0;
+
+	ret = nbl_dev_register_net(dev_mgt, &vsi->register_result);
+	if (ret)
+		return ret;
+
+	vsi->queue_num = vsi->register_result.tx_queue_num;
+	vsi->queue_size = vsi->register_result.queue_size;
+
+	nbl_debug(common, NBL_DEBUG_VSI, "Data vsi register, queue_num %d, queue_size %d",
+		  vsi->queue_num, vsi->queue_size);
+
+	return 0;
+}
+
+static int nbl_dev_vsi_data_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				  void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
+}
+
+static void nbl_dev_vsi_data_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_vsi_common_remove(dev_mgt, vsi);
+}
+
+static int nbl_dev_vsi_ctrl_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				     void *vsi_data)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->get_rep_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				     &vsi->queue_num, &vsi->queue_size);
+
+	nbl_debug(common, NBL_DEBUG_VSI, "Ctrl vsi register, queue_num %d, queue_size %d",
+		  vsi->queue_num, vsi->queue_size);
+	return 0;
+}
+
+static int nbl_dev_vsi_ctrl_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				  void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
+}
+
+static void nbl_dev_vsi_ctrl_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_vsi_common_remove(dev_mgt, vsi);
+}
+
+static int nbl_dev_vsi_user_register(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				     void *vsi_data)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	serv_ops->get_user_queue_info(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				      &vsi->queue_num, &vsi->queue_size,
+				      NBL_COMMON_TO_VSI_ID(common));
+
+	nbl_debug(common, NBL_DEBUG_VSI, "User vsi register, queue_num %d, queue_size %d",
+		  vsi->queue_num, vsi->queue_size);
+	return 0;
+}
+
+static int nbl_dev_vsi_user_setup(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+				  void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	return nbl_dev_vsi_common_setup(dev_mgt, param, vsi);
+}
+
+static void nbl_dev_vsi_user_remove(struct nbl_dev_mgt *dev_mgt, void *vsi_data)
+{
+	struct nbl_dev_vsi *vsi = (struct nbl_dev_vsi *)vsi_data;
+
+	nbl_dev_vsi_common_remove(dev_mgt, vsi);
+}
+
+static struct nbl_dev_vsi_tbl vsi_tbl[NBL_VSI_MAX] = {
+	[NBL_VSI_DATA] = {
+		.vsi_ops = {
+			.register_vsi = nbl_dev_vsi_data_register,
+			.setup = nbl_dev_vsi_data_setup,
+			.remove = nbl_dev_vsi_data_remove,
+		},
+		.vf_support = true,
+		.only_nic_support = false,
+		.in_kernel = true,
+		.use_independ_irq = true,
+		.static_queue = true,
+	},
+	[NBL_VSI_CTRL] = {
+		.vsi_ops = {
+			.register_vsi = nbl_dev_vsi_ctrl_register,
+			.setup = nbl_dev_vsi_ctrl_setup,
+			.remove = nbl_dev_vsi_ctrl_remove,
+		},
+		.vf_support = false,
+		.only_nic_support = true,
+		.in_kernel = true,
+		.use_independ_irq = true,
+		.static_queue = true,
+	},
+	[NBL_VSI_USER] = {
+		.vsi_ops = {
+			.register_vsi = nbl_dev_vsi_user_register,
+			.setup = nbl_dev_vsi_user_setup,
+			.remove = nbl_dev_vsi_user_remove,
+		},
+		.vf_support = false,
+		.only_nic_support = true,
+		.in_kernel = false,
+		.use_independ_irq = false,
+		.static_queue = false,
+	},
+};
+
+static int nbl_dev_vsi_build(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param)
+{
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_vsi *vsi = NULL;
+	int i;
+
+	net_dev->vsi_ctrl.queue_num = 0;
+	net_dev->vsi_ctrl.queue_free_offset = 0;
+
+	/* Build all vsi, and alloc vsi_id for each of them */
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		if ((param->caps.is_vf && !vsi_tbl[i].vf_support) ||
+		    (!param->caps.is_nic && vsi_tbl[i].only_nic_support))
+			continue;
+
+		vsi = devm_kzalloc(NBL_DEV_MGT_TO_DEV(dev_mgt), sizeof(*vsi), GFP_KERNEL);
+		if (!vsi)
+			goto malloc_vsi_fail;
+
+		vsi->ops = &vsi_tbl[i].vsi_ops;
+		vsi->vsi_id = serv_ops->get_vsi_id(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), 0, i);
+		vsi->index = i;
+		vsi->in_kernel = vsi_tbl[i].in_kernel;
+		vsi->use_independ_irq = vsi_tbl[i].use_independ_irq;
+		vsi->static_queue = vsi_tbl[i].static_queue;
+		net_dev->vsi_ctrl.vsi_list[i] = vsi;
+	}
+
+	return 0;
+
+malloc_vsi_fail:
+	while (--i + 1) {
+		devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), net_dev->vsi_ctrl.vsi_list[i]);
+		net_dev->vsi_ctrl.vsi_list[i] = NULL;
+	}
+
+	return -ENOMEM;
+}
+
+static void nbl_dev_vsi_destroy(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	int i;
+
+	for (i = 0; i < NBL_VSI_MAX; i++)
+		if (net_dev->vsi_ctrl.vsi_list[i]) {
+			devm_kfree(NBL_DEV_MGT_TO_DEV(dev_mgt), net_dev->vsi_ctrl.vsi_list[i]);
+			net_dev->vsi_ctrl.vsi_list[i] = NULL;
+		}
+}
+
+struct nbl_dev_vsi *nbl_dev_vsi_select(struct nbl_dev_mgt *dev_mgt, u8 vsi_index)
+{
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_dev_vsi *vsi = NULL;
+	int i = 0;
+
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		vsi = net_dev->vsi_ctrl.vsi_list[i];
+		if (vsi && vsi->index == vsi_index)
+			return vsi;
+	}
+
+	return NULL;
+}
+
+static int nbl_dev_chan_get_st_name_req(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_common_info *common = NBL_DEV_MGT_TO_COMMON(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+
+	NBL_CHAN_SEND(chan_send, NBL_COMMON_TO_MGT_PF(common),
+		      NBL_CHAN_MSG_GET_ST_NAME, NULL, 0,
+		      st_dev->real_st_name, sizeof(st_dev->real_st_name), 1);
+	return chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+}
+
+static void nbl_dev_chan_get_st_name_resp(void *priv, u16 src_id, u16 msg_id,
+					  void *data, u32 data_len)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)priv;
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct device *dev = NBL_COMMON_TO_DEV(dev_mgt->common);
+	struct nbl_chan_ack_info chan_ack;
+	int ret;
+
+	NBL_CHAN_ACK(chan_ack, src_id, NBL_CHAN_MSG_GET_ST_NAME, msg_id,
+		     0, st_dev->st_name, sizeof(st_dev->st_name));
+	ret = chan_ops->send_ack(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_ack);
+	if (ret)
+		dev_err(dev, "channel send ack failed with ret: %d, msg_type: %d\n",
+			ret, NBL_CHAN_MSG_GET_ST_NAME);
+}
+
+static void nbl_dev_register_get_st_name_chan_msg(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+
+	if (!chan_ops->check_queue_exist(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+					 NBL_CHAN_TYPE_MAILBOX))
+		return;
+
+	chan_ops->register_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt),
+			       NBL_CHAN_MSG_GET_ST_NAME,
+			       nbl_dev_chan_get_st_name_resp, dev_mgt);
+	st_dev->resp_msg_registered = true;
+}
+
+static void nbl_dev_unregister_get_st_name_chan_msg(struct nbl_dev_mgt *dev_mgt)
+{
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+
+	if (!st_dev->resp_msg_registered)
+		return;
+
+	chan_ops->unregister_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), NBL_CHAN_MSG_GET_ST_NAME);
+}
+
+static struct nbl_dev_net_ops netdev_ops[NBL_PRODUCT_MAX] = {
+	{
+		.setup_netdev_ops	= nbl_dev_setup_netops_leonis,
+	},
+};
+
+static void nbl_det_setup_net_dev_ops(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param)
+{
+	NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt) = &netdev_ops[param->product_type];
+}
+
+static int nbl_dev_setup_net_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_dev_vsi *vsi;
+	int i, ret = 0;
+	u16 total_queue_num = 0, kernel_queue_num = 0, user_queue_num = 0;
+	u16 dynamic_queue_max = 0, irq_queue_num = 0;
+
+	*net_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_net), GFP_KERNEL);
+	if (!*net_dev)
+		return -ENOMEM;
+
+	ret = nbl_dev_vsi_build(dev_mgt, param);
+	if (ret)
+		goto vsi_build_fail;
+
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
+
+		if (!vsi)
+			continue;
+
+		ret = vsi->ops->register_vsi(dev_mgt, param, vsi);
+		if (ret) {
+			dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "Vsi %d register failed", vsi->index);
+			goto vsi_register_fail;
+		}
+
+		if (vsi->static_queue) {
+			total_queue_num += vsi->queue_num;
+		} else {
+			if (dynamic_queue_max < vsi->queue_num)
+				dynamic_queue_max = vsi->queue_num;
+		}
+
+		if (vsi->use_independ_irq)
+			irq_queue_num += vsi->queue_num;
+
+		if (vsi->in_kernel)
+			kernel_queue_num += vsi->queue_num;
+		else
+			user_queue_num += vsi->queue_num;
+	}
+
+	/* all vsi's dynamic only support enable use one at the same time. */
+	total_queue_num += dynamic_queue_max;
+
+	/* the total queue set must before vsi stepup */
+	(*net_dev)->total_queue_num = total_queue_num;
+	(*net_dev)->kernel_queue_num = kernel_queue_num;
+	(*net_dev)->user_queue_num = user_queue_num;
+
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
+
+		if (!vsi)
+			continue;
+
+		if (!vsi->in_kernel)
+			continue;
+
+		ret = vsi->ops->setup(dev_mgt, param, vsi);
+		if (ret) {
+			dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "Vsi %d setup failed", vsi->index);
+			goto vsi_setup_fail;
+		}
+	}
+
+	nbl_dev_register_net_irq(dev_mgt, irq_queue_num);
+
+	nbl_det_setup_net_dev_ops(dev_mgt, param);
+
+	return 0;
+
+vsi_setup_fail:
+vsi_register_fail:
+	nbl_dev_vsi_destroy(dev_mgt);
+vsi_build_fail:
+	devm_kfree(dev, *net_dev);
+	return ret;
+}
+
+static void nbl_dev_remove_net_dev(struct nbl_adapter *adapter)
+{
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net **net_dev = &NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_dev_vsi *vsi;
+	int i = 0;
+
+	if (!*net_dev)
+		return;
+
+	for (i = 0; i < NBL_VSI_MAX; i++) {
+		vsi = (*net_dev)->vsi_ctrl.vsi_list[i];
+
+		if (!vsi)
+			continue;
+
+		vsi->ops->remove(dev_mgt, vsi);
+	}
+	nbl_dev_vsi_destroy(dev_mgt);
+
+	nbl_dev_unregister_net(dev_mgt);
+
+	devm_kfree(dev, *net_dev);
+	*net_dev = NULL;
+}
+
+static int nbl_dev_setup_st_dev(struct nbl_adapter *adapter, struct nbl_init_param *param)
+{
+	int ret;
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_st_dev *st_dev;
+
+	/* unify restool's chardev for leonis/draco/rnic400. all pf create chardev */
+	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_RESTOOL_CAP))
+		return 0;
+
+	st_dev = devm_kzalloc(dev, sizeof(struct nbl_dev_st_dev), GFP_KERNEL);
+	if (!st_dev)
+		return -ENOMEM;
+
+	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = st_dev;
+	ret = serv_ops->setup_st(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					 nbl_get_st_table(), st_dev->st_name);
+	if (ret) {
+		dev_err(dev, "create resource char dev failed\n");
+		goto alloc_chardev_failed;
+	}
+
+	if (param->caps.has_ctrl) {
+		nbl_dev_register_get_st_name_chan_msg(dev_mgt);
+	} else {
+		ret = nbl_dev_chan_get_st_name_req(dev_mgt);
+		if (!ret)
+			serv_ops->register_real_st_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+							st_dev->real_st_name);
+		else
+			dev_err(dev, "get real resource char dev failed\n");
+	}
+
+	return 0;
+alloc_chardev_failed:
+	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), st_dev);
+	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = NULL;
+	return -1;
+}
+
+static void nbl_dev_remove_st_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+
+	if (!serv_ops->get_product_fix_cap(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), NBL_RESTOOL_CAP))
+		return;
+
+	nbl_dev_unregister_get_st_name_chan_msg(dev_mgt);
+	serv_ops->remove_st(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), nbl_get_st_table());
+
+	devm_kfree(NBL_ADAPTER_TO_DEV(adapter), st_dev);
+	NBL_DEV_MGT_TO_ST_DEV(dev_mgt) = NULL;
+}
+
+static int nbl_dev_setup_dev_mgt(struct nbl_common_info *common, struct nbl_dev_mgt **dev_mgt)
+{
+	*dev_mgt = devm_kzalloc(NBL_COMMON_TO_DEV(common), sizeof(struct nbl_dev_mgt), GFP_KERNEL);
+	if (!*dev_mgt)
+		return -ENOMEM;
+
+	NBL_DEV_MGT_TO_COMMON(*dev_mgt) = common;
+	return 0;
+}
+
+static void nbl_dev_remove_dev_mgt(struct nbl_common_info *common, struct nbl_dev_mgt **dev_mgt)
+{
+	devm_kfree(NBL_COMMON_TO_DEV(common), *dev_mgt);
+	*dev_mgt = NULL;
+}
+
+static void nbl_dev_remove_ops(struct device *dev, struct nbl_dev_ops_tbl **dev_ops_tbl)
+{
+	devm_kfree(dev, *dev_ops_tbl);
+	*dev_ops_tbl = NULL;
+}
+
+static int nbl_dev_setup_ops(struct device *dev, struct nbl_dev_ops_tbl **dev_ops_tbl,
+			     struct nbl_adapter *adapter)
+{
+	*dev_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_dev_ops_tbl), GFP_KERNEL);
+	if (!*dev_ops_tbl)
+		return -ENOMEM;
+
+	NBL_DEV_OPS_TBL_TO_OPS(*dev_ops_tbl) = &dev_ops;
+	NBL_DEV_OPS_TBL_TO_PRIV(*dev_ops_tbl) = adapter;
+
+	return 0;
+}
+
+int nbl_dev_init(void *p, struct nbl_init_param *param)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_dev_mgt **dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_ops_tbl **dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
+	struct nbl_service_ops_tbl *serv_ops_tbl = NBL_ADAPTER_TO_SERV_OPS_TBL(adapter);
+	struct nbl_channel_ops_tbl *chan_ops_tbl = NBL_ADAPTER_TO_CHAN_OPS_TBL(adapter);
+	int ret = 0;
+
+	ret = nbl_dev_setup_dev_mgt(common, dev_mgt);
+	if (ret)
+		goto setup_mgt_fail;
+
+	NBL_DEV_MGT_TO_SERV_OPS_TBL(*dev_mgt) = serv_ops_tbl;
+	NBL_DEV_MGT_TO_CHAN_OPS_TBL(*dev_mgt) = chan_ops_tbl;
+
+	ret = nbl_dev_setup_common_dev(adapter, param);
+	if (ret)
+		goto setup_common_dev_fail;
+
+	if (param->caps.has_ctrl) {
+		ret = nbl_dev_setup_ctrl_dev(adapter, param);
+		if (ret)
+			goto setup_ctrl_dev_fail;
+	}
+
+	ret = nbl_dev_setup_net_dev(adapter, param);
+	if (ret)
+		goto setup_net_dev_fail;
+
+	ret = nbl_dev_setup_st_dev(adapter, param);
+	if (ret)
+		goto setup_st_dev_fail;
+
+	ret = nbl_dev_setup_ops(dev, dev_ops_tbl, adapter);
+	if (ret)
+		goto setup_ops_fail;
+
+	return 0;
+
+setup_ops_fail:
+	nbl_dev_remove_st_dev(adapter);
+setup_st_dev_fail:
+	nbl_dev_remove_net_dev(adapter);
+setup_net_dev_fail:
+	nbl_dev_remove_ctrl_dev(adapter);
+setup_ctrl_dev_fail:
+	nbl_dev_remove_common_dev(adapter);
+setup_common_dev_fail:
+	nbl_dev_remove_dev_mgt(common, dev_mgt);
+setup_mgt_fail:
+	return ret;
+}
+
+void nbl_dev_remove(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct device *dev = NBL_ADAPTER_TO_DEV(adapter);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_dev_mgt **dev_mgt = (struct nbl_dev_mgt **)&NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_ops_tbl **dev_ops_tbl = &NBL_ADAPTER_TO_DEV_OPS_TBL(adapter);
+
+	nbl_dev_remove_ops(dev, dev_ops_tbl);
+
+	nbl_dev_remove_st_dev(adapter);
+	nbl_dev_remove_net_dev(adapter);
+	nbl_dev_remove_ctrl_dev(adapter);
+	nbl_dev_remove_common_dev(adapter);
+
+	nbl_dev_remove_dev_mgt(common, dev_mgt);
+}
+
+static void nbl_dev_handle_fatal_err(struct nbl_dev_mgt *dev_mgt)
+{
+}
+
+/* ----------  Dev start process  ---------- */
+void nbl_dev_register_dev_name(void *p)
+{
+	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+
+	/* get pf_name then register it to AF */
+	serv_ops->register_dev_name(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+				    common->vsi_id, net_dev->netdev->name);
+}
+
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
new file mode 100644
index 000000000000..41b1955f6bae
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
@@ -0,0 +1,303 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEV_H_
+#define _NBL_DEV_H_
+
+#include "nbl_core.h"
+#include "nbl_sysfs.h"
+
+#define NBL_DEV_MGT_TO_COMMON(dev_mgt)		((dev_mgt)->common)
+#define NBL_DEV_MGT_TO_DEV(dev_mgt)		NBL_COMMON_TO_DEV(NBL_DEV_MGT_TO_COMMON(dev_mgt))
+#define NBL_DEV_MGT_TO_COMMON_DEV(dev_mgt)	((dev_mgt)->common_dev)
+#define NBL_DEV_MGT_TO_CTRL_DEV(dev_mgt)	((dev_mgt)->ctrl_dev)
+#define NBL_DEV_MGT_TO_NET_DEV(dev_mgt)		((dev_mgt)->net_dev)
+#define NBL_DEV_MGT_TO_USER_DEV(dev_mgt)	((dev_mgt)->user_dev)
+#define NBL_DEV_MGT_TO_ST_DEV(dev_mgt)		((dev_mgt)->st_dev)
+#define NBL_DEV_COMMON_TO_MSIX_INFO(dev_common)	(&(dev_common)->msix_info)
+#define NBL_DEV_CTRL_TO_TASK_INFO(dev_ctrl)	(&(dev_ctrl)->task_info)
+#define NBL_DEV_MGT_TO_EMP_CONSOLE(dev_mgt)	((dev_mgt)->emp_console)
+#define NBL_DEV_MGT_TO_NETDEV_OPS(dev_mgt)	((dev_mgt)->net_dev->ops)
+
+#define NBL_DEV_MGT_TO_SERV_OPS_TBL(dev_mgt)	((dev_mgt)->serv_ops_tbl)
+#define NBL_DEV_MGT_TO_SERV_OPS(dev_mgt)	(NBL_DEV_MGT_TO_SERV_OPS_TBL(dev_mgt)->ops)
+#define NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt)	(NBL_DEV_MGT_TO_SERV_OPS_TBL(dev_mgt)->priv)
+#define NBL_DEV_MGT_TO_RES_PT_OPS(dev_mgt)	(&(NBL_DEV_MGT_TO_SERV_OPS_TBL(dev_mgt)->pt_ops))
+#define NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)	((dev_mgt)->chan_ops_tbl)
+#define NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt)	(NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)->ops)
+#define NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt)	(NBL_DEV_MGT_TO_CHAN_OPS_TBL(dev_mgt)->priv)
+
+#define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV | NETIF_MSG_PROBE | NETIF_MSG_LINK | \
+			    NETIF_MSG_IFDOWN | NETIF_MSG_IFUP)
+
+#define NBL_STRING_NAME_LEN			(32)
+#define NBL_DEFAULT_MTU				(1500)
+
+#define NBL_MAX_CARDS				16
+
+#define NBL_KEEPALIVE_TIME_CYCLE		(10 * HZ)
+
+#define NBL_DEV_BATCH_RESET_FUNC_NUM		(32)
+#define NBL_DEV_BATCH_RESET_USEC		(1000000)
+
+#define NBL_TIME_LEN				(32)
+#define NBL_SAVED_TRACES_NUM			(16)
+
+#define NBL_DEV_FW_RESET_WAIT_TIME		(3500)
+
+enum nbl_reset_status {
+	NBL_RESET_INIT,
+	NBL_RESET_SEND,
+	NBL_RESET_DONE,
+	NBL_RESET_STATUS_MAX
+};
+
+struct nbl_task_info {
+	struct nbl_adapter *adapter;
+	struct nbl_dev_mgt *dev_mgt;
+	struct work_struct fw_hb_task;
+	struct delayed_work fw_reset_task;
+	struct work_struct clean_adminq_task;
+	struct work_struct adapt_desc_gother_task;
+	struct work_struct clean_abnormal_irq_task;
+	struct work_struct recovery_abnormal_task;
+	struct work_struct report_temp_task;
+	struct work_struct report_reboot_task;
+	struct work_struct reset_task;
+	enum nbl_reset_event reset_event;
+	enum nbl_reset_status reset_status[NBL_MAX_FUNC];
+	struct timer_list serv_timer;
+	unsigned long serv_timer_period;
+
+	bool fw_resetting;
+	bool timer_setup;
+};
+
+struct nbl_reset_task_info {
+	struct work_struct task;
+	enum nbl_reset_event event;
+};
+
+enum nbl_msix_serv_type {
+	/* virtio_dev has a config vector_id, and the vector_id need is 0 */
+	NBL_MSIX_VIRTIO_TYPE = 0,
+	NBL_MSIX_NET_TYPE,
+	NBL_MSIX_MAILBOX_TYPE,
+	NBL_MSIX_ABNORMAL_TYPE,
+	NBL_MSIX_ADMINDQ_TYPE,
+	NBL_MSIX_RDMA_TYPE,
+	NBL_MSIX_TYPE_MAX
+
+};
+
+struct nbl_msix_serv_info {
+	char irq_name[NBL_STRING_NAME_LEN];
+	u16 num;
+	u16 base_vector_id;
+	/* true: hw report msix, hw need to mask actively */
+	bool hw_self_mask_en;
+};
+
+struct nbl_msix_info {
+	struct nbl_msix_serv_info serv_info[NBL_MSIX_TYPE_MAX];
+	struct msix_entry *msix_entries;
+};
+
+struct nbl_dev_common {
+	struct nbl_dev_mgt *dev_mgt;
+	struct device *hwmon_dev;
+	struct nbl_msix_info msix_info;
+	char mailbox_name[NBL_STRING_NAME_LEN];
+	// for ctrl-dev/net-dev mailbox recv msg
+	struct work_struct clean_mbx_task;
+
+	struct nbl_reset_task_info reset_task;
+};
+
+enum nbl_dev_temp_status {
+	NBL_TEMP_STATUS_NORMAL = 0,
+	NBL_TEMP_STATUS_WARNING,
+	NBL_TEMP_STATUS_CRIT,
+	NBL_TEMP_STATUS_EMERG,
+	NBL_TEMP_STATUS_MAX
+};
+
+enum nbl_emp_log_level {
+	NBL_EMP_ALERT_LOG_FATAL = 0,
+	NBL_EMP_ALERT_LOG_ERROR = 1,
+	NBL_EMP_ALERT_LOG_WARNING = 2,
+	NBL_EMP_ALERT_LOG_INFO = 3,
+};
+
+struct nbl_fw_reporter_ctx {
+	u64 timestamp;
+	u32 temp_num;
+	char reboot_report_time[NBL_TIME_LEN];
+};
+
+struct nbl_fw_temp_trace_data {
+	u64 timestamp;
+	u32 temp_num;
+};
+
+struct nbl_fw_reboot_trace_data {
+	char local_time[NBL_TIME_LEN];
+};
+
+struct nbl_health_reporters {
+	struct {
+		struct nbl_fw_temp_trace_data trace_data[NBL_SAVED_TRACES_NUM];
+		u8 saved_traces_index;
+		struct mutex lock; /* protect reading data of temp_trace_data*/
+	} temp_st_arr;
+
+	struct {
+		struct nbl_fw_reboot_trace_data trace_data[NBL_SAVED_TRACES_NUM];
+		u8 saved_traces_index;
+		struct mutex lock; /* protect reading data of reboot_trace_data*/
+	} reboot_st_arr;
+
+	struct nbl_fw_reporter_ctx reporter_ctx;
+};
+
+struct nbl_dev_ctrl {
+	struct nbl_task_info task_info;
+	enum nbl_dev_temp_status temp_status;
+	struct nbl_health_reporters health_reporters;
+	struct workqueue_struct *ctrl_dev_wq1;
+};
+
+enum nbl_dev_emp_alert_event {
+	NBL_EMP_EVENT_TEMP_ALERT = 1,
+	NBL_EMP_EVENT_LOG_ALERT = 2,
+	NBL_EMP_EVENT_MAX
+};
+
+enum nbl_dev_temp_threshold {
+	NBL_TEMP_NOMAL_THRESHOLD = 85,
+	NBL_TEMP_WARNING_THRESHOLD = 105,
+	NBL_TEMP_CRIT_THRESHOLD = 115,
+	NBL_TEMP_EMERG_THRESHOLD = 120,
+};
+
+struct nbl_dev_temp_alarm_info {
+	int logvel;
+#define NBL_TEMP_ALARM_STR_LEN		128
+	char alarm_info[NBL_TEMP_ALARM_STR_LEN];
+};
+
+struct nbl_dev_vsi_controller {
+	u16 queue_num;
+	u16 queue_free_offset;
+	void *vsi_list[NBL_VSI_MAX];
+};
+
+struct nbl_dev_net_ops {
+	int (*setup_netdev_ops)(void *priv, struct net_device *netdev,
+				struct nbl_init_param *param);
+};
+
+struct nbl_dev_attr_info {
+	struct nbl_netdev_name_attr dev_name_attr;
+};
+
+struct nbl_dev_net {
+	struct net_device *netdev;
+	struct nbl_dev_attr_info dev_attr;
+	struct nbl_dev_net_ops *ops;
+	u8 eth_id;
+	struct nbl_dev_vsi_controller vsi_ctrl;
+	u16 total_queue_num;
+	u16 kernel_queue_num;
+	u16 user_queue_num;
+	u16 total_vfs;
+	struct nbl_st_name st_name;
+
+};
+
+/* Unify leonis/draco/rnic resource tool. All pf has st char dev. For leonis, only pf0 has adminq,
+ * so other pf's resoure tool use pf0's char dev actually.
+ */
+struct nbl_dev_st_dev {
+	bool resp_msg_registered;
+	u8 resv[3];
+	char st_name[NBL_RESTOOL_NAME_LEN];
+	char real_st_name[NBL_RESTOOL_NAME_LEN];
+};
+
+struct nbl_dev_mgt {
+	struct nbl_common_info *common;
+	struct nbl_service_ops_tbl *serv_ops_tbl;
+	struct nbl_channel_ops_tbl *chan_ops_tbl;
+	struct nbl_dev_common *common_dev;
+	struct nbl_dev_ctrl *ctrl_dev;
+	struct nbl_dev_net *net_dev;
+	struct nbl_dev_st_dev *st_dev;
+};
+
+struct nbl_dev_vsi_feature {
+	u16 has_lldp:1;
+	u16 has_lacp:1;
+	u16 rsv:14;
+};
+
+struct nbl_dev_vsi_ops {
+	int (*register_vsi)(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+			    void *vsi_data);
+	int (*setup)(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+		     void *vsi_data);
+	void (*remove)(struct nbl_dev_mgt *dev_mgt, void *vsi_data);
+	int (*start)(void *dev_priv, struct net_device *netdev, void *vsi_data);
+	void (*stop)(void *dev_priv, void *vsi_data);
+	int (*netdev_build)(struct nbl_dev_mgt *dev_mgt, struct nbl_init_param *param,
+			    struct net_device *netdev, void *vsi_data);
+	void (*netdev_destroy)(struct nbl_dev_mgt *dev_mgt, void *vsi_data);
+};
+
+struct nbl_dev_vsi {
+	struct nbl_dev_vsi_ops *ops;
+	struct net_device *netdev;
+	struct net_device *napi_netdev;
+	struct nbl_register_net_result register_result;
+	struct nbl_dev_vsi_feature feature;
+	u16 vsi_id;
+	u16 queue_offset;
+	u16 queue_num;
+	u16 queue_size;
+	u16 in_kernel;
+	u8 index;
+	bool enable;
+	bool use_independ_irq;
+	bool static_queue;
+};
+
+struct nbl_dev_vsi_tbl {
+	struct nbl_dev_vsi_ops vsi_ops;
+	bool vf_support;
+	bool only_nic_support;
+	u16 in_kernel;
+	bool use_independ_irq;
+	bool static_queue;
+};
+
+#define NBL_DEV_BOARD_ID_MAX			NBL_DRIVER_DEV_MAX
+struct nbl_dev_board_id_entry {
+	u32 board_key; /* domain << 16 | bus_id */
+	u8 refcount;
+	bool valid;
+};
+
+struct nbl_dev_board_id_table {
+	struct nbl_dev_board_id_entry entry[NBL_DEV_BOARD_ID_MAX];
+};
+
+struct nbl_dev_vsi *nbl_dev_vsi_select(struct nbl_dev_mgt *dev_mgt, u8 vsi_index);
+void nbl_net_add_name_attr(struct nbl_netdev_name_attr *dev_name_attr, char *rep_name);
+void nbl_net_remove_dev_attr(struct nbl_dev_net *net_dev);
+int nbl_netdev_add_st_sysfs(struct net_device *netdev, struct nbl_dev_net *net_dev);
+void nbl_netdev_remove_st_sysfs(struct nbl_dev_net *net_dev);
+#endif
+
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
index bedb6283a891..2ed67c9fe73b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -7,6 +7,924 @@
 #include "nbl_service.h"
 #include <crypto/hash.h>
 
+static void nbl_serv_set_link_state(struct nbl_service_mgt *serv_mgt, struct net_device *netdev);
+
+static void nbl_serv_set_queue_param(struct nbl_serv_ring *ring, u16 desc_num,
+				     struct nbl_txrx_queue_param *param, u16 vsi_id,
+				     u16 global_vector_id)
+{
+	param->vsi_id = vsi_id;
+	param->dma = ring->dma;
+	param->desc_num = desc_num;
+	param->local_queue_id = ring->local_queue_id / 2;
+	param->global_vector_id = global_vector_id;
+	param->intr_en = 1;
+	param->intr_mask = 1;
+	param->extend_header = 1;
+	param->rxcsum = 1;
+	param->split = 0;
+}
+
+/**
+ * In virtio mode, the emulator triggers the configuration of
+ * txrx_registers only based on tx_ring, so the rx_info needs
+ * to be delivered first before the tx_info can be delivered.
+ */
+static int
+nbl_serv_setup_queues(struct nbl_service_mgt *serv_mgt, struct nbl_serv_ring_vsi_info *vsi_info)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_txrx_queue_param param = {0};
+	struct nbl_serv_ring *ring;
+	struct nbl_serv_vector *vector;
+	u16 start = vsi_info->ring_offset, end = vsi_info->ring_offset + vsi_info->ring_num;
+	int i, ret = 0;
+
+	for (i = start; i < end; i++) {
+		vector = &ring_mgt->vectors[i];
+		ring = &ring_mgt->rx_rings[i];
+		nbl_serv_set_queue_param(ring, ring_mgt->rx_desc_num, &param,
+					 vsi_info->vsi_id, vector->global_vector_id);
+
+		ret = disp_ops->setup_queue(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), &param, false);
+		if (ret)
+			return ret;
+	}
+
+	for (i = start; i < end; i++) {
+		vector = &ring_mgt->vectors[i];
+		ring = &ring_mgt->tx_rings[i];
+		nbl_serv_set_queue_param(ring, ring_mgt->tx_desc_num, &param,
+					 vsi_info->vsi_id, vector->global_vector_id);
+
+		ret = disp_ops->setup_queue(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), &param, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void
+nbl_serv_flush_rx_queues(struct nbl_service_mgt *serv_mgt, u16 ring_offset, u16 ring_num)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	int i;
+
+	for (i = ring_offset; i < ring_offset + ring_num; i++)
+		disp_ops->kick_rx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+}
+
+static int nbl_serv_setup_rings(struct nbl_service_mgt *serv_mgt, struct net_device *netdev,
+				struct nbl_serv_ring_vsi_info *vsi_info, bool use_napi)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	u16 start = vsi_info->ring_offset, end = vsi_info->ring_offset + vsi_info->ring_num;
+	int i, ret = 0;
+
+	for (i = start; i < end; i++) {
+		ring_mgt->tx_rings[i].dma =
+			disp_ops->start_tx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+		if (!ring_mgt->tx_rings[i].dma) {
+			netdev_err(netdev, "Fail to start tx ring %d", i);
+			ret = -EFAULT;
+			break;
+		}
+	}
+	if (i != end) {
+		while (--i + 1 > start)
+			disp_ops->stop_tx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+		goto tx_err;
+	}
+
+	for (i = start; i < end; i++) {
+		ring_mgt->rx_rings[i].dma =
+			disp_ops->start_rx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i, use_napi);
+		if (!ring_mgt->rx_rings[i].dma) {
+			netdev_err(netdev, "Fail to start rx ring %d", i);
+			ret = -EFAULT;
+			break;
+		}
+	}
+	if (i != end) {
+		while (--i + 1 > start)
+			disp_ops->stop_rx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+		goto rx_err;
+	}
+
+	return 0;
+
+rx_err:
+	for (i = start; i < end; i++)
+		disp_ops->stop_tx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+tx_err:
+	return ret;
+}
+
+static void nbl_serv_stop_rings(struct nbl_service_mgt *serv_mgt,
+				struct nbl_serv_ring_vsi_info *vsi_info)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 start = vsi_info->ring_offset, end = vsi_info->ring_offset + vsi_info->ring_num;
+	int i;
+
+	for (i = start; i < end; i++)
+		disp_ops->stop_tx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+
+	for (i = start; i < end; i++)
+		disp_ops->stop_rx_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), i);
+}
+
+static void nbl_serv_check_flow_table_spec(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	int ret;
+
+	if (!flow_mgt->force_promisc)
+		return;
+
+	ret = disp_ops->check_flow_table_spec(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					      flow_mgt->vlan_list_cnt,
+					      flow_mgt->unicast_mac_cnt + 1,
+					      flow_mgt->multi_mac_cnt);
+
+	if (!ret) {
+		flow_mgt->force_promisc = 0;
+		flow_mgt->pending_async_work = 1;
+	}
+}
+
+static struct nbl_serv_vlan_node *nbl_serv_alloc_vlan_node(void)
+{
+	struct nbl_serv_vlan_node *vlan_node = NULL;
+
+	vlan_node = kzalloc(sizeof(*vlan_node), GFP_ATOMIC);
+	if (!vlan_node)
+		return NULL;
+
+	INIT_LIST_HEAD(&vlan_node->node);
+	vlan_node->ref_cnt = 1;
+	vlan_node->primary_mac_effective = 0;
+	vlan_node->sub_mac_effective = 0;
+
+	return vlan_node;
+}
+
+static void nbl_serv_free_vlan_node(struct nbl_serv_vlan_node *vlan_node)
+{
+	kfree(vlan_node);
+}
+
+static int nbl_serv_update_vlan_node_effective(struct nbl_service_mgt *serv_mgt,
+					       struct nbl_serv_vlan_node *vlan_node,
+					       bool effective,
+					       u16 vsi)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct net_device *dev = net_resource_mgt->netdev;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_serv_submac_node *submac_node;
+	bool force_promisc = 0;
+	int ret = 0, i = 0;
+
+	if (vlan_node->primary_mac_effective == effective &&
+	    vlan_node->sub_mac_effective == effective)
+		return 0;
+
+	if (effective && !vlan_node->primary_mac_effective) {
+		ret = disp_ops->add_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    flow_mgt->mac, vlan_node->vid, vsi);
+		if (ret)
+			goto check_ret;
+	} else if (!effective && vlan_node->primary_mac_effective) {
+		disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				      flow_mgt->mac, vlan_node->vid, vsi);
+	}
+
+	vlan_node->primary_mac_effective = effective;
+
+	for (i = 0; i < NBL_SUBMAC_MAX; i++)
+		list_for_each_entry(submac_node, &flow_mgt->submac_list[i], node) {
+			if (!submac_node->effective)
+				continue;
+
+			if (effective && !vlan_node->sub_mac_effective) {
+				ret = disp_ops->add_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+							    submac_node->mac, vlan_node->vid, vsi);
+				if (ret)
+					goto del_macvlan_node;
+			} else if (!effective && vlan_node->sub_mac_effective) {
+				disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						      submac_node->mac, vlan_node->vid, vsi);
+			}
+		}
+
+	vlan_node->sub_mac_effective = effective;
+
+	return 0;
+
+del_macvlan_node:
+	for (i = 0; i < NBL_SUBMAC_MAX; i++)
+		list_for_each_entry(submac_node, &flow_mgt->submac_list[i], node) {
+			if (submac_node->effective)
+				disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						      submac_node->mac, vlan_node->vid, vsi);
+		}
+check_ret:
+	if (ret) {
+		force_promisc = 1;
+		if (flow_mgt->force_promisc ^ force_promisc) {
+			flow_mgt->force_promisc = force_promisc;
+			flow_mgt->pending_async_work = 1;
+			netdev_info(dev, "Reached VLAN filter limit, forcing promisc/allmuti moden");
+		}
+	}
+
+	if (vlan_node->primary_mac_effective == effective)
+		return 0;
+
+	if (!NBL_COMMON_TO_VF_CAP(NBL_SERV_MGT_TO_COMMON(serv_mgt)))
+		return 0;
+
+	return ret;
+}
+
+static void nbl_serv_set_sfp_state(void *priv, struct net_device *netdev, u8 eth_id,
+				   bool open, bool is_force)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	int ret = 0;
+
+	if (test_bit(NBL_FLAG_LINK_DOWN_ON_CLOSE, &serv_mgt->flags) || is_force) {
+		if (open) {
+			ret = disp_ops->set_sfp_state(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						      eth_id, NBL_SFP_MODULE_ON);
+			if (ret)
+				netdev_info(netdev, "Fail to open sfp\n");
+			else
+				netdev_info(netdev, "open sfp\n");
+		} else {
+			ret = disp_ops->set_sfp_state(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						      eth_id, NBL_SFP_MODULE_OFF);
+			if (ret)
+				netdev_info(netdev, "Fail to close sfp\n");
+			else
+				netdev_info(netdev, "close sfp\n");
+		}
+	}
+}
+
+static void nbl_serv_set_netdev_carrier_state(void *priv, struct net_device *netdev, u8 link_state)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = serv_mgt->net_resource_mgt;
+
+	if (test_bit(NBL_DOWN, adapter->state))
+		return;
+
+	switch (net_resource_mgt->link_forced) {
+	case IFLA_VF_LINK_STATE_AUTO:
+		if (link_state) {
+			if (!netif_carrier_ok(netdev)) {
+				netif_carrier_on(netdev);
+				netdev_info(netdev, "Set nic link up\n");
+			}
+		} else {
+			if (netif_carrier_ok(netdev)) {
+				netif_carrier_off(netdev);
+				netdev_info(netdev, "Set nic link down\n");
+			}
+		}
+		return;
+	case IFLA_VF_LINK_STATE_ENABLE:
+		netif_carrier_on(netdev);
+		return;
+	case IFLA_VF_LINK_STATE_DISABLE:
+		netif_carrier_off(netdev);
+		return;
+	default:
+		netif_carrier_on(netdev);
+		return;
+	}
+}
+
+static void nbl_serv_set_link_state(struct nbl_service_mgt *serv_mgt, struct net_device *netdev)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = serv_mgt->net_resource_mgt;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	u16 vsi_id = NBL_COMMON_TO_VSI_ID(common);
+	u8 eth_id = NBL_COMMON_TO_ETH_ID(common);
+	struct nbl_eth_link_info eth_link_info = {0};
+	int ret = 0;
+
+	net_resource_mgt->link_forced =
+		disp_ops->get_link_forced(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+
+	if (net_resource_mgt->link_forced == IFLA_VF_LINK_STATE_AUTO) {
+		ret = disp_ops->get_link_state(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					       eth_id, &eth_link_info);
+		if (ret) {
+			netdev_err(netdev, "Fail to get_link_state err %d\n", ret);
+			eth_link_info.link_status = 1;
+		}
+	}
+
+	nbl_serv_set_netdev_carrier_state(serv_mgt, netdev, eth_link_info.link_status);
+}
+
+int nbl_serv_vsi_open(void *priv, struct net_device *netdev, u16 vsi_index,
+		      u16 real_qps, bool use_napi)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info = &ring_mgt->vsi_info[vsi_index];
+	int ret = 0;
+
+	if (vsi_info->started)
+		return 0;
+
+	ret = nbl_serv_setup_rings(serv_mgt, netdev, vsi_info, use_napi);
+	if (ret) {
+		netdev_err(netdev, "Fail to setup rings\n");
+		goto setup_rings_fail;
+	}
+
+	ret = nbl_serv_setup_queues(serv_mgt, vsi_info);
+	if (ret) {
+		netdev_err(netdev, "Fail to setup queues\n");
+		goto setup_queue_fail;
+	}
+	nbl_serv_flush_rx_queues(serv_mgt, vsi_info->ring_offset, vsi_info->ring_num);
+
+	if (vsi_index == NBL_VSI_DATA)
+		disp_ops->cfg_txrx_vlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					net_resource_mgt->vlan_tci, net_resource_mgt->vlan_proto,
+					vsi_index);
+
+	ret = disp_ops->cfg_dsch(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				 vsi_info->vsi_id, true);
+	if (ret) {
+		netdev_err(netdev, "Fail to setup dsch\n");
+		goto setup_dsch_fail;
+	}
+
+	vsi_info->active_ring_num = real_qps;
+	ret = disp_ops->setup_cqs(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				  vsi_info->vsi_id, real_qps, false);
+	if (ret)
+		goto setup_cqs_fail;
+
+	vsi_info->started = true;
+	return 0;
+
+setup_cqs_fail:
+	disp_ops->cfg_dsch(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+			   NBL_COMMON_TO_VSI_ID(common), false);
+setup_dsch_fail:
+	disp_ops->remove_all_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				    NBL_COMMON_TO_VSI_ID(common));
+setup_queue_fail:
+	nbl_serv_stop_rings(serv_mgt, vsi_info);
+setup_rings_fail:
+	return ret;
+}
+
+int nbl_serv_vsi_stop(void *priv, u16 vsi_index)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_ring_vsi_info *vsi_info = &ring_mgt->vsi_info[vsi_index];
+
+	if (!vsi_info->started)
+		return 0;
+
+	vsi_info->started = false;
+	/* modify defalt action and rss configuration */
+	disp_ops->remove_cqs(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_info->vsi_id);
+
+	/* clear dsch config */
+	disp_ops->cfg_dsch(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_info->vsi_id, false);
+
+	/* disable and rest tx/rx logic queue */
+	disp_ops->remove_all_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_info->vsi_id);
+
+	/* free tx and rx bufs */
+	nbl_serv_stop_rings(serv_mgt, vsi_info);
+
+	return 0;
+}
+
+static int nbl_serv_abnormal_event_to_queue(int event_type)
+{
+	switch (event_type) {
+	case NBL_ABNORMAL_EVENT_DVN:
+		return NBL_TX;
+	case NBL_ABNORMAL_EVENT_UVN:
+		return NBL_RX;
+	default:
+		return event_type;
+	}
+}
+
+static int nbl_serv_chan_stop_abnormal_sw_queue_req(struct nbl_service_mgt *serv_mgt,
+						    u16 local_queue_id, u16 func_id, int type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_param_stop_abnormal_sw_queue param = {0};
+	struct nbl_chan_send_info chan_send = {0};
+	int ret = 0;
+
+	param.local_queue_id = local_queue_id;
+	param.type = type;
+
+	NBL_CHAN_SEND(chan_send, func_id, NBL_CHAN_MSG_STOP_ABNORMAL_SW_QUEUE,
+		      &param, sizeof(param), NULL, 0, 1);
+	ret = chan_ops->send_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_send);
+
+	return ret;
+}
+
+static dma_addr_t nbl_serv_chan_restore_netdev_queue_req(struct nbl_service_mgt *serv_mgt,
+							 u16 local_queue_id, u16 func_id, int type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_param_restore_queue param = {0};
+	struct nbl_chan_send_info chan_send = {0};
+	dma_addr_t dma = 0;
+	int ret = 0;
+
+	param.local_queue_id = local_queue_id;
+	param.type = type;
+
+	NBL_CHAN_SEND(chan_send, func_id, NBL_CHAN_MSG_RESTORE_NETDEV_QUEUE,
+		      &param, sizeof(param), &dma, sizeof(dma), 1);
+	ret = chan_ops->send_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_send);
+	if (ret)
+		return 0;
+
+	return dma;
+}
+
+static int nbl_serv_chan_restart_netdev_queue_req(struct nbl_service_mgt *serv_mgt,
+						  u16 local_queue_id, u16 func_id, int type)
+{
+	struct nbl_channel_ops *chan_ops = NBL_SERV_MGT_TO_CHAN_OPS(serv_mgt);
+	struct nbl_chan_param_restart_queue param = {0};
+	struct nbl_chan_send_info chan_send = {0};
+
+	param.local_queue_id = local_queue_id;
+	param.type = type;
+
+	NBL_CHAN_SEND(chan_send, func_id, NBL_CHAN_MSG_RESTART_NETDEV_QUEUE,
+		      &param, sizeof(param), NULL, 0, 1);
+	return chan_ops->send_msg(NBL_SERV_MGT_TO_CHAN_PRIV(serv_mgt), &chan_send);
+}
+
+static int
+nbl_serv_start_abnormal_hw_queue(struct nbl_service_mgt *serv_mgt, u16 vsi_id, u16 local_queue_id,
+				 dma_addr_t dma, int type)
+{
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_txrx_queue_param param = {0};
+	struct nbl_serv_vector *vector;
+	struct nbl_serv_ring *ring;
+	int ret = 0;
+
+	switch (type) {
+	case NBL_TX:
+		vector = &ring_mgt->vectors[local_queue_id];
+		ring = &ring_mgt->tx_rings[local_queue_id];
+		ring->dma = dma;
+		nbl_serv_set_queue_param(ring, ring_mgt->tx_desc_num, &param,
+					 vsi_id, vector->global_vector_id);
+		ret = disp_ops->setup_queue(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), &param, true);
+		return ret;
+	case NBL_RX:
+		vector = &ring_mgt->vectors[local_queue_id];
+		ring = &ring_mgt->rx_rings[local_queue_id];
+		ring->dma = dma;
+
+		nbl_serv_set_queue_param(ring, ring_mgt->rx_desc_num, &param,
+					 vsi_id, vector->global_vector_id);
+		ret = disp_ops->setup_queue(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), &param, false);
+		return 0;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static void nbl_serv_restore_queue(struct nbl_service_mgt *serv_mgt, u16 vsi_id,
+				   u16 local_queue_id, u16 type, bool dif_err)
+{
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u16 func_id = disp_ops->get_function_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	u16 global_queue_id;
+	dma_addr_t dma = 0;
+	int ret = 0;
+
+	while (!rtnl_trylock())
+		msleep(20);
+
+	ret = nbl_serv_chan_stop_abnormal_sw_queue_req(serv_mgt, local_queue_id, func_id, type);
+	if (ret)
+		goto unlock;
+
+	ret = disp_ops->stop_abnormal_hw_queue(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
+					       local_queue_id, type);
+	if (ret)
+		goto unlock;
+
+	dma = nbl_serv_chan_restore_netdev_queue_req(serv_mgt, local_queue_id, func_id, type);
+	if (!dma)
+		goto unlock;
+
+	ret = nbl_serv_start_abnormal_hw_queue(serv_mgt, vsi_id, local_queue_id, dma, type);
+	if (ret)
+		goto unlock;
+
+	ret = nbl_serv_chan_restart_netdev_queue_req(serv_mgt, local_queue_id, func_id, type);
+	if (ret)
+		goto unlock;
+
+	if (dif_err && type == NBL_TX) {
+		global_queue_id =
+			disp_ops->get_vsi_global_queue_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+							  vsi_id, local_queue_id);
+		nbl_info(common, NBL_DEBUG_COMMON,
+			 "dvn int_status:0, queue_id:%d\n", global_queue_id);
+	}
+
+unlock:
+	rtnl_unlock();
+}
+
+int nbl_serv_netdev_open(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_serv_ring_vsi_info *vsi_info;
+	int num_cpus, real_qps, ret = 0;
+	bool netdev_open = true;
+
+	if (!test_bit(NBL_DOWN, adapter->state))
+		return -EBUSY;
+
+	netdev_info(netdev, "Nbl open\n");
+
+	netif_carrier_off(netdev);
+	nbl_serv_set_sfp_state(serv_mgt, netdev, NBL_COMMON_TO_ETH_ID(common), true, false);
+	vsi_info = &ring_mgt->vsi_info[NBL_VSI_DATA];
+
+	if (vsi_info->active_ring_num) {
+		real_qps = vsi_info->active_ring_num;
+	} else {
+		num_cpus = num_online_cpus();
+		real_qps = num_cpus > vsi_info->ring_num ? vsi_info->ring_num : num_cpus;
+	}
+
+	ret = nbl_serv_vsi_open(serv_mgt, netdev, NBL_VSI_DATA, real_qps, 1);
+	if (ret)
+		goto vsi_open_fail;
+
+	ret = netif_set_real_num_tx_queues(netdev, real_qps);
+	if (ret)
+		goto setup_real_qps_fail;
+	ret = netif_set_real_num_rx_queues(netdev, real_qps);
+	if (ret)
+		goto setup_real_qps_fail;
+
+	netif_tx_start_all_queues(netdev);
+	clear_bit(NBL_DOWN, adapter->state);
+	set_bit(NBL_RUNNING, adapter->state);
+	nbl_serv_set_link_state(serv_mgt, netdev);
+
+	netdev_info(netdev, "Nbl open ok!\n");
+
+	return 0;
+
+setup_real_qps_fail:
+	nbl_serv_vsi_stop(serv_mgt, NBL_VSI_DATA);
+vsi_open_fail:
+	netdev_open = false;
+	return ret;
+}
+
+int nbl_serv_netdev_stop(struct net_device *netdev)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+
+	if (!test_bit(NBL_RUNNING, adapter->state))
+		return -EBUSY;
+
+	netdev_info(netdev, "Nbl stop\n");
+	set_bit(NBL_DOWN, adapter->state);
+	clear_bit(NBL_RUNNING, adapter->state);
+
+	nbl_serv_set_sfp_state(serv_mgt, netdev, NBL_COMMON_TO_ETH_ID(common), false, false);
+
+	netif_tx_stop_all_queues(netdev);
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+	synchronize_net();
+	nbl_serv_vsi_stop(serv_mgt, NBL_VSI_DATA);
+	netdev_info(netdev, "Nbl stop ok!\n");
+
+	return 0;
+}
+
+static int nbl_serv_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(dev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_netdev_priv *priv = netdev_priv(dev);
+	struct nbl_serv_vlan_node *vlan_node;
+	bool effective = true;
+	int ret = 0;
+
+	if (vid == NBL_DEFAULT_VLAN_ID)
+		return 0;
+
+	if (flow_mgt->vid != 0)
+		effective = false;
+
+	if (!flow_mgt->unicast_flow_enable)
+		effective = false;
+
+	if (!flow_mgt->trusted_en && flow_mgt->vlan_list_cnt >= NBL_NO_TRUST_MAX_VLAN)
+		return -ENOSPC;
+
+	nbl_debug(common, NBL_DEBUG_COMMON, "add mac-vlan dev for proto 0x%04x, vid %u.",
+		  be16_to_cpu(proto), vid);
+
+	list_for_each_entry(vlan_node, &flow_mgt->vlan_list, node) {
+		nbl_debug(common, NBL_DEBUG_COMMON, "add mac-vlan dev vid %u.", vlan_node->vid);
+		if (vlan_node->vid == vid) {
+			vlan_node->ref_cnt++;
+			return 0;
+		}
+	}
+
+	vlan_node = nbl_serv_alloc_vlan_node();
+	if (!vlan_node)
+		return -ENOMEM;
+
+	vlan_node->vid = vid;
+	ret = nbl_serv_update_vlan_node_effective(serv_mgt, vlan_node, effective, priv->data_vsi);
+	if (ret)
+		goto add_macvlan_failed;
+	list_add(&vlan_node->node, &flow_mgt->vlan_list);
+	flow_mgt->vlan_list_cnt++;
+
+	nbl_serv_check_flow_table_spec(serv_mgt);
+
+	return 0;
+
+add_macvlan_failed:
+	nbl_serv_free_vlan_node(vlan_node);
+	return ret;
+}
+
+static int nbl_serv_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(dev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_netdev_priv *priv = netdev_priv(dev);
+	struct nbl_serv_vlan_node *vlan_node;
+
+	if (vid == NBL_DEFAULT_VLAN_ID)
+		return 0;
+
+	nbl_debug(common, NBL_DEBUG_COMMON, "del mac-vlan dev for proto 0x%04x, vid %u.",
+		  be16_to_cpu(proto), vid);
+
+	list_for_each_entry(vlan_node, &flow_mgt->vlan_list, node) {
+		nbl_debug(common, NBL_DEBUG_COMMON, "del mac-vlan dev vid %u.", vlan_node->vid);
+		if (vlan_node->vid == vid) {
+			vlan_node->ref_cnt--;
+			if (!vlan_node->ref_cnt) {
+				nbl_serv_update_vlan_node_effective(serv_mgt, vlan_node,
+								    0, priv->data_vsi);
+				list_del(&vlan_node->node);
+				flow_mgt->vlan_list_cnt--;
+				nbl_serv_free_vlan_node(vlan_node);
+			}
+			break;
+		}
+	}
+
+	nbl_serv_check_flow_table_spec(serv_mgt);
+
+	return 0;
+}
+
+static void nbl_serv_get_stats64(struct net_device *netdev, struct rtnl_link_stats64 *stats)
+{
+	struct nbl_adapter *adapter = NBL_NETDEV_TO_ADAPTER(netdev);
+	struct nbl_service_mgt *serv_mgt = NBL_ADAPTER_TO_SERV_MGT(adapter);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_stats net_stats = { 0 };
+
+	if (!stats) {
+		netdev_err(netdev, "get_link_stats64 stats is null\n");
+		return;
+	}
+
+	disp_ops->get_net_stats(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), &net_stats);
+
+	stats->rx_packets = net_stats.rx_packets;
+	stats->tx_packets = net_stats.tx_packets;
+	stats->rx_bytes = net_stats.rx_bytes;
+	stats->tx_bytes = net_stats.tx_bytes;
+	stats->multicast = net_stats.rx_multicast_packets;
+
+	stats->rx_errors = 0;
+	stats->tx_errors = 0;
+	stats->rx_length_errors = netdev->stats.rx_length_errors;
+	stats->rx_crc_errors = netdev->stats.rx_crc_errors;
+	stats->rx_frame_errors = netdev->stats.rx_frame_errors;
+	stats->rx_dropped = 0;
+	stats->tx_dropped = 0;
+}
+
+static int nbl_serv_register_net(void *priv, struct nbl_register_net_param *register_param,
+				 struct nbl_register_net_result *register_result)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->register_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				     register_param, register_result);
+}
+
+static int nbl_serv_unregister_net(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	return disp_ops->unregister_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static int nbl_serv_start_mgt_flow(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->setup_multi_group(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static void nbl_serv_stop_mgt_flow(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->remove_multi_group(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static u32 nbl_serv_get_tx_headroom(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_tx_headroom(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+/**
+ * This ops get fix product capability from resource layer, this capability fix by product_type, no
+ * need get from ctrl device
+ */
+static bool nbl_serv_get_product_fix_cap(void *priv, enum nbl_fix_cap_type cap_type)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_product_fix_cap(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						       cap_type);
+}
+
+static int nbl_serv_init_chip(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	struct nbl_common_info *common;
+	struct device *dev;
+	int ret = 0;
+
+	common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	dev = NBL_COMMON_TO_DEV(common);
+
+	ret = disp_ops->init_chip_module(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret) {
+		dev_err(dev, "init_chip_module failed\n");
+		goto module_init_fail;
+	}
+
+	ret = disp_ops->queue_init(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret) {
+		dev_err(dev, "queue_init failed\n");
+		goto queue_init_fail;
+	}
+
+	ret = disp_ops->vsi_init(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret) {
+		dev_err(dev, "vsi_init failed\n");
+		goto vsi_init_fail;
+	}
+
+	return 0;
+
+vsi_init_fail:
+queue_init_fail:
+module_init_fail:
+	return ret;
+}
+
+static int nbl_serv_destroy_chip(void *p)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)p;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	if (!disp_ops->get_product_fix_cap(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					   NBL_NEED_DESTROY_CHIP))
+		return 0;
+
+	disp_ops->deinit_chip_module(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	return 0;
+}
+
+static u16 nbl_serv_get_vsi_id(void *priv, u16 func_id, u16 type)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_vsi_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), func_id, type);
+}
+
+static void nbl_serv_get_eth_id(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_eth_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
+				    eth_mode, eth_id, logic_eth_id);
+}
+
+static void nbl_serv_get_rep_queue_info(void *priv, u16 *queue_num, u16 *queue_size)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->get_rep_queue_info(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				     queue_num, queue_size);
+}
+
+static void nbl_serv_get_user_queue_info(void *priv, u16 *queue_num, u16 *queue_size, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->get_user_queue_info(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				      queue_num, queue_size, vsi_id);
+}
+
+static void
+nbl_serv_set_netdev_ops(void *priv, const struct net_device_ops *net_device_ops, bool is_pf)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct device *dev = NBL_SERV_MGT_TO_DEV(serv_mgt);
+
+	dev_info(dev, "set netdev ops:%p is_pf:%d\n", net_device_ops, is_pf);
+	if (is_pf)
+		net_resource_mgt->netdev_ops.pf_netdev_ops = (void *)net_device_ops;
+}
+
 static void nbl_serv_setup_flow_mgt(struct nbl_serv_flow_mgt *flow_mgt)
 {
 	int i = 0;
@@ -16,7 +934,645 @@ static void nbl_serv_setup_flow_mgt(struct nbl_serv_flow_mgt *flow_mgt)
 		INIT_LIST_HEAD(&flow_mgt->submac_list[i]);
 }
 
+static u8 __iomem *nbl_serv_get_hw_addr(void *priv, size_t *size)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_hw_addr(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), size);
+}
+
+static u16 nbl_serv_get_function_id(void *priv, u16 vsi_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_function_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id);
+}
+
+static void nbl_serv_get_real_bdf(void *priv, u16 vsi_id, u8 *bus, u8 *dev, u8 *function)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_real_bdf(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id,
+				      bus, dev, function);
+}
+
+static bool nbl_serv_check_fw_heartbeat(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->check_fw_heartbeat(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static bool nbl_serv_check_fw_reset(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->check_fw_reset(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static void nbl_serv_get_common_irq_num(void *priv, struct nbl_common_irq_num *irq_num)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	irq_num->mbx_irq_num = disp_ops->get_mbx_irq_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static void nbl_serv_get_ctrl_irq_num(void *priv, struct nbl_ctrl_irq_num *irq_num)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	irq_num->adminq_irq_num = disp_ops->get_adminq_irq_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	irq_num->abnormal_irq_num =
+		disp_ops->get_abnormal_irq_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static int nbl_serv_get_port_attributes(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ret = disp_ops->get_port_attributes(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static int nbl_serv_update_template_config(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	int ret = 0;
+
+	ret = disp_ops->update_ring_num(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int nbl_serv_get_part_number(void *priv, char *part_number)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_part_number(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), part_number);
+}
+
+static int nbl_serv_get_serial_number(void *priv, char *serial_number)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_serial_number(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), serial_number);
+}
+
+static int nbl_serv_enable_port(void *priv, bool enable)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+	int ret = 0;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	ret = disp_ops->enable_port(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), enable);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
+static void nbl_serv_init_port(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops;
+
+	disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->init_port(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static int nbl_serv_set_eth_mac_addr(void *priv, u8 *mac, u8 eth_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+
+	if (NBL_COMMON_TO_VF_CAP(common))
+		return 0;
+	else
+		return disp_ops->set_eth_mac_addr(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+						  mac, eth_id);
+}
+
+static void nbl_serv_adapt_desc_gother(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	if (test_bit(NBL_FLAG_HIGH_THROUGHPUT, &serv_mgt->flags))
+		disp_ops->set_desc_high_throughput(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+	else
+		disp_ops->adapt_desc_gother(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static void nbl_serv_process_flr(void *priv, u16 vfid)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->flr_clear_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+	disp_ops->flr_clear_flows(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+	disp_ops->flr_clear_interrupt(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+	disp_ops->flr_clear_net(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+}
+
+static u16 nbl_serv_covert_vfid_to_vsi_id(void *priv, u16 vfid)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->covert_vfid_to_vsi_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vfid);
+}
+
+static void nbl_serv_recovery_abnormal(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->unmask_all_interrupts(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static void nbl_serv_keep_alive(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->keep_alive(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static int nbl_serv_register_vsi_info(void *priv, struct nbl_vsi_param *vsi_param)
+{
+	u16 vsi_index = vsi_param->index;
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_ring_mgt *ring_mgt = NBL_SERV_MGT_TO_RING_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	u32 num_cpus;
+
+	ring_mgt->vsi_info[vsi_index].vsi_index = vsi_index;
+	ring_mgt->vsi_info[vsi_index].vsi_id = vsi_param->vsi_id;
+	ring_mgt->vsi_info[vsi_index].ring_offset = vsi_param->queue_offset;
+	ring_mgt->vsi_info[vsi_index].ring_num = vsi_param->queue_num;
+
+	/* init active ring number before first open, guarantee fd direct config check success. */
+	num_cpus = num_online_cpus();
+	ring_mgt->vsi_info[vsi_index].active_ring_num = (u16)num_cpus > vsi_param->queue_num ?
+							vsi_param->queue_num : (u16)num_cpus;
+
+	/**
+	 * Clear cfgs, in case this function exited abnormaly last time.
+	 * only for data vsi, vf in vm only support data vsi.
+	 * DPDK user vsi can not leak resource.
+	 */
+	if (vsi_index == NBL_VSI_DATA)
+		disp_ops->clear_queues(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_param->vsi_id);
+	disp_ops->register_vsi_ring(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_index,
+				    vsi_param->queue_offset, vsi_param->queue_num);
+
+	return disp_ops->register_vsi2q(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_index,
+					vsi_param->vsi_id, vsi_param->queue_offset,
+					vsi_param->queue_num);
+}
+
+static int nbl_serv_st_open(struct inode *inode, struct file *filep)
+{
+	struct nbl_serv_st_mgt *p = container_of(inode->i_cdev, struct nbl_serv_st_mgt, cdev);
+
+	filep->private_data = p;
+
+	return 0;
+}
+
+static ssize_t nbl_serv_st_write(struct file *file, const char __user *ubuf,
+				 size_t size, loff_t *ppos)
+{
+	return 0;
+}
+
+static ssize_t nbl_serv_st_read(struct file *file, char __user *ubuf, size_t size, loff_t *ppos)
+{
+	return 0;
+}
+
+static int nbl_serv_st_release(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int nbl_serv_process_passthrough(struct nbl_service_mgt *serv_mgt,
+					unsigned int cmd, unsigned long arg)
+{
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_passthrough_fw_cmd_param *param = NULL, *result = NULL;
+	int ret = 0;
+
+	if (st_mgt->real_st_name_valid)
+		return -EOPNOTSUPP;
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		goto alloc_param_fail;
+
+	result = kzalloc(sizeof(*result), GFP_KERNEL);
+	if (!result)
+		goto alloc_result_fail;
+
+	ret = copy_from_user(param, (void *)arg, _IOC_SIZE(cmd));
+	if (ret) {
+		nbl_err(common, NBL_DEBUG_ST, "Bad access %d.\n", ret);
+		return ret;
+	}
+
+	nbl_debug(common, NBL_DEBUG_ST, "Passthough opcode: %d\n", param->opcode);
+
+	ret = disp_ops->passthrough_fw_cmd(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), param, result);
+	if (ret)
+		goto passthrough_fail;
+
+	ret = copy_to_user((void *)arg, result, _IOC_SIZE(cmd));
+
+passthrough_fail:
+	kfree(result);
+alloc_result_fail:
+	kfree(param);
+alloc_param_fail:
+	return ret;
+}
+
+static int nbl_serv_process_st_info(struct nbl_service_mgt *serv_mgt,
+				    unsigned int cmd, unsigned long arg)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+	struct nbl_st_info_param *param = NULL;
+	int ret = 0;
+
+	nbl_debug(common, NBL_DEBUG_ST, "Get st info\n");
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
+
+	strscpy(param->driver_name, NBL_DRIVER_NAME, sizeof(param->driver_name));
+	if (net_resource_mgt->netdev)
+		strscpy(param->netdev_name[0], net_resource_mgt->netdev->name,
+			sizeof(param->netdev_name[0]));
+
+	strscpy(param->driver_ver, NBL_DRIVER_VERSION, sizeof(param->driver_ver));
+
+	param->bus = common->bus;
+	param->devid = common->devid;
+	param->function = common->function;
+	param->domain = pci_domain_nr(NBL_COMMON_TO_PDEV(common)->bus);
+
+	param->version = IOCTL_ST_INFO_VERSION;
+
+	param->real_chrdev_flag = st_mgt->real_st_name_valid;
+	if (st_mgt->real_st_name_valid)
+		memcpy(param->real_chrdev_name, st_mgt->real_st_name,
+		       sizeof(param->real_chrdev_name));
+
+	ret = copy_to_user((void *)arg, param, _IOC_SIZE(cmd));
+
+	kfree(param);
+	return ret;
+}
+
+static long nbl_serv_st_unlock_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct nbl_serv_st_mgt *st_mgt = file->private_data;
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)st_mgt->serv_mgt;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	int ret = 0;
+
+	if (_IOC_TYPE(cmd) != IOCTL_TYPE) {
+		nbl_err(common, NBL_DEBUG_ST, "cmd %u, bad magic 0x%x/0x%x.\n",
+			cmd, _IOC_TYPE(cmd), IOCTL_TYPE);
+		return -ENOTTY;
+	}
+
+	if (_IOC_DIR(cmd) & _IOC_READ)
+		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+	else if (_IOC_DIR(cmd) & _IOC_WRITE)
+		ret = !access_ok((void __user *)arg, _IOC_SIZE(cmd));
+	if (ret) {
+		nbl_err(common, NBL_DEBUG_ST, "Bad access.\n");
+		return ret;
+	}
+
+	switch (cmd) {
+	case IOCTL_PASSTHROUGH:
+		ret = nbl_serv_process_passthrough(serv_mgt, cmd, arg);
+		break;
+	case IOCTL_ST_INFO:
+		ret = nbl_serv_process_st_info(serv_mgt, cmd, arg);
+		break;
+	default:
+		nbl_err(common, NBL_DEBUG_ST, "Unknown cmd %d.\n", cmd);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+
+static const struct file_operations st_ops = {
+	.owner = THIS_MODULE,
+	.open = nbl_serv_st_open,
+	.write = nbl_serv_st_write,
+	.read = nbl_serv_st_read,
+	.unlocked_ioctl = nbl_serv_st_unlock_ioctl,
+	.release = nbl_serv_st_release,
+};
+
+static int nbl_serv_alloc_subdev_id(struct nbl_software_tool_table *st_table)
+{
+	int subdev_id;
+
+	subdev_id = find_first_zero_bit(st_table->devid, NBL_ST_MAX_DEVICE_NUM);
+	if (subdev_id == NBL_ST_MAX_DEVICE_NUM)
+		return -ENOSPC;
+	set_bit(subdev_id, st_table->devid);
+
+	return subdev_id;
+}
+
+static void nbl_serv_free_subdev_id(struct nbl_software_tool_table *st_table, int id)
+{
+	clear_bit(id, st_table->devid);
+}
+
+static void nbl_serv_register_real_st_name(void *priv, char *st_name)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+
+	st_mgt->real_st_name_valid = true;
+	memcpy(st_mgt->real_st_name, st_name, NBL_RESTOOL_NAME_LEN);
+}
+
+static int nbl_serv_setup_st(void *priv, void *st_table_param, char *st_name)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_software_tool_table *st_table = (struct nbl_software_tool_table *)st_table_param;
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+	struct device *char_device;
+	char name[NBL_RESTOOL_NAME_LEN] = {0};
+	dev_t devid;
+	int id, subdev_id, ret = 0;
+
+	id = NBL_COMMON_TO_BOARD_ID(common);
+
+	subdev_id = nbl_serv_alloc_subdev_id(st_table);
+	if (subdev_id < 0)
+		goto alloc_subdev_id_fail;
+
+	devid = MKDEV(st_table->major, subdev_id);
+
+	if (!NBL_COMMON_TO_PCI_FUNC_ID(common))
+		snprintf(name, sizeof(name), "nblst%04x_conf%d",
+			 NBL_COMMON_TO_PDEV(common)->device, id);
+	else
+		snprintf(name, sizeof(name), "nblst%04x_conf%d.%d",
+			 NBL_COMMON_TO_PDEV(common)->device, id, NBL_COMMON_TO_PCI_FUNC_ID(common));
+
+	st_mgt = devm_kzalloc(NBL_COMMON_TO_DEV(common), sizeof(*st_mgt), GFP_KERNEL);
+	if (!st_mgt)
+		goto malloc_fail;
+
+	st_mgt->serv_mgt = serv_mgt;
+
+	st_mgt->major = MAJOR(devid);
+	st_mgt->minor = MINOR(devid);
+	st_mgt->devno = devid;
+	st_mgt->subdev_id = subdev_id;
+
+	cdev_init(&st_mgt->cdev, &st_ops);
+	ret = cdev_add(&st_mgt->cdev, devid, 1);
+	if (ret)
+		goto cdev_add_fail;
+
+	char_device = device_create(st_table->cls, NULL, st_mgt->devno, NULL, name);
+	if (IS_ERR(char_device)) {
+		ret = -EBUSY;
+		goto device_create_fail;
+	}
+
+	memcpy(st_name, name, NBL_RESTOOL_NAME_LEN);
+	memcpy(st_mgt->st_name, name, NBL_RESTOOL_NAME_LEN);
+	NBL_SERV_MGT_TO_ST_MGT(serv_mgt) = st_mgt;
+	return 0;
+
+device_create_fail:
+	cdev_del(&st_mgt->cdev);
+cdev_add_fail:
+	devm_kfree(NBL_COMMON_TO_DEV(common), st_mgt);
+malloc_fail:
+	nbl_serv_free_subdev_id(st_table, subdev_id);
+alloc_subdev_id_fail:
+	return ret;
+}
+
+static void nbl_serv_remove_st(void *priv, void *st_table_param)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_software_tool_table *st_table = (struct nbl_software_tool_table *)st_table_param;
+	struct nbl_serv_st_mgt *st_mgt = NBL_SERV_MGT_TO_ST_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+
+	if (!st_mgt)
+		return;
+
+	device_destroy(st_table->cls, st_mgt->devno);
+	cdev_del(&st_mgt->cdev);
+
+	nbl_serv_free_subdev_id(st_table, st_mgt->subdev_id);
+
+	NBL_SERV_MGT_TO_ST_MGT(serv_mgt) = NULL;
+	devm_kfree(NBL_COMMON_TO_DEV(common), st_mgt);
+}
+
+static int nbl_serv_get_board_id(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	return disp_ops->get_board_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt));
+}
+
+static int nbl_serv_process_abnormal_event(void *priv)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_abnormal_event_info abnomal_info;
+	struct nbl_abnormal_details *detail;
+	u16 local_queue_id;
+	int type, i, ret = 0;
+
+	memset(&abnomal_info, 0, sizeof(abnomal_info));
+
+	ret = disp_ops->process_abnormal_event(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), &abnomal_info);
+	if (!ret)
+		return ret;
+
+	for (i = 0; i < NBL_ABNORMAL_EVENT_MAX; i++) {
+		detail = &abnomal_info.details[i];
+
+		if (!detail->abnormal)
+			continue;
+
+		type = nbl_serv_abnormal_event_to_queue(i);
+		local_queue_id = disp_ops->get_local_queue_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+							      detail->vsi_id, detail->qid);
+		if (local_queue_id == U16_MAX)
+			return 0;
+
+		nbl_serv_restore_queue(serv_mgt, detail->vsi_id, local_queue_id, type, true);
+	}
+
+	return 0;
+}
+
+static void nbl_serv_register_dev_name(void *priv, u16 vsi_id, char *name)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->register_dev_name(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), vsi_id, name);
+}
+
+static void nbl_serv_set_hw_status(void *priv, enum nbl_hw_status hw_status)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->set_hw_status(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), hw_status);
+}
+
+static void nbl_serv_get_active_func_bitmaps(void *priv, unsigned long *bitmap, int max_func)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->get_active_func_bitmaps(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), bitmap, max_func);
+}
+
+static void nbl_serv_get_board_info(void *priv, struct nbl_board_port_info *board_info)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	disp_ops->get_board_info(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), board_info);
+}
+
+u16 nbl_serv_get_vf_function_id(void *priv, int vf_id)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+	struct nbl_serv_net_resource_mgt *net_resource_mgt =
+					NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct nbl_common_info *common = NBL_SERV_MGT_TO_COMMON(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	if (vf_id >= net_resource_mgt->total_vfs || !net_resource_mgt->vf_info)
+		return U16_MAX;
+
+	return disp_ops->get_vf_function_id(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+					    NBL_COMMON_TO_VSI_ID(common), vf_id);
+}
+
 static struct nbl_service_ops serv_ops = {
+	.init_chip = nbl_serv_init_chip,
+	.destroy_chip = nbl_serv_destroy_chip,
+
+	.get_common_irq_num = nbl_serv_get_common_irq_num,
+	.get_ctrl_irq_num = nbl_serv_get_ctrl_irq_num,
+	.get_port_attributes = nbl_serv_get_port_attributes,
+	.update_template_config = nbl_serv_update_template_config,
+	.get_part_number = nbl_serv_get_part_number,
+	.get_serial_number = nbl_serv_get_serial_number,
+	.enable_port = nbl_serv_enable_port,
+	.init_port = nbl_serv_init_port,
+	.set_sfp_state = nbl_serv_set_sfp_state,
+
+	.register_net = nbl_serv_register_net,
+	.unregister_net = nbl_serv_unregister_net,
+
+	.register_vsi_info = nbl_serv_register_vsi_info,
+
+	.start_mgt_flow = nbl_serv_start_mgt_flow,
+	.stop_mgt_flow = nbl_serv_stop_mgt_flow,
+	.get_tx_headroom = nbl_serv_get_tx_headroom,
+	.get_product_fix_cap	= nbl_serv_get_product_fix_cap,
+
+	.vsi_open = nbl_serv_vsi_open,
+	.vsi_stop = nbl_serv_vsi_stop,
+	/* For netdev ops */
+	.netdev_open = nbl_serv_netdev_open,
+	.netdev_stop = nbl_serv_netdev_stop,
+	.rx_add_vid = nbl_serv_rx_add_vid,
+	.rx_kill_vid = nbl_serv_rx_kill_vid,
+	.get_stats64 = nbl_serv_get_stats64,
+	.get_rep_queue_info = nbl_serv_get_rep_queue_info,
+	.get_user_queue_info = nbl_serv_get_user_queue_info,
+
+	.set_netdev_ops = nbl_serv_set_netdev_ops,
+
+	.get_vsi_id = nbl_serv_get_vsi_id,
+	.get_eth_id = nbl_serv_get_eth_id,
+
+	.get_board_info = nbl_serv_get_board_info,
+
+	.get_hw_addr = nbl_serv_get_hw_addr,
+
+	.get_function_id = nbl_serv_get_function_id,
+	.get_real_bdf = nbl_serv_get_real_bdf,
+	.set_eth_mac_addr = nbl_serv_set_eth_mac_addr,
+	.process_abnormal_event = nbl_serv_process_abnormal_event,
+	.adapt_desc_gother = nbl_serv_adapt_desc_gother,
+	.process_flr = nbl_serv_process_flr,
+	.get_board_id = nbl_serv_get_board_id,
+	.covert_vfid_to_vsi_id = nbl_serv_covert_vfid_to_vsi_id,
+	.recovery_abnormal = nbl_serv_recovery_abnormal,
+	.keep_alive = nbl_serv_keep_alive,
+
+	.check_fw_heartbeat = nbl_serv_check_fw_heartbeat,
+	.check_fw_reset = nbl_serv_check_fw_reset,
+	.setup_st = nbl_serv_setup_st,
+	.remove_st = nbl_serv_remove_st,
+	.register_real_st_name = nbl_serv_register_real_st_name,
+
+	.register_dev_name = nbl_serv_register_dev_name,
+
+	.set_hw_status = nbl_serv_set_hw_status,
+	.get_active_func_bitmaps = nbl_serv_get_active_func_bitmaps,
+	.get_vf_function_id = nbl_serv_get_vf_function_id,
 };
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
index f230b11cf4bc..5d3652b5f31f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.h
@@ -254,6 +254,25 @@ struct nbl_serv_net_resource_mgt {
 	u32 dump_perf_len;
 };
 
+#define IOCTL_TYPE 'n'
+#define IOCTL_PASSTHROUGH	_IOWR(IOCTL_TYPE, 0x01, struct nbl_passthrough_fw_cmd_param)
+#define IOCTL_ST_INFO		_IOR(IOCTL_TYPE, 0x02, struct nbl_st_info_param)
+
+#define IOCTL_ST_INFO_VERSION	0x10		/* 1.0 */
+
+struct nbl_serv_st_mgt {
+	void *serv_mgt;
+	struct cdev cdev;
+	int major;
+	int minor;
+	dev_t devno;
+	int subdev_id;
+	char st_name[NBL_RESTOOL_NAME_LEN];
+	char real_st_name[NBL_RESTOOL_NAME_LEN];
+	bool real_st_name_valid;
+	u8 resv[3];
+};
+
 struct nbl_service_mgt {
 	struct nbl_common_info *common;
 	struct nbl_dispatch_ops_tbl *disp_ops_tbl;
@@ -261,6 +280,7 @@ struct nbl_service_mgt {
 	struct nbl_serv_ring_mgt ring_mgt;
 	struct nbl_serv_flow_mgt flow_mgt;
 	struct nbl_serv_net_resource_mgt *net_resource_mgt;
+	struct nbl_serv_st_mgt *st_mgt;
 	unsigned long old_flags;
 	unsigned long flags;
 };
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.c
new file mode 100644
index 000000000000..f354b3bfe96b
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_dev.h"
+
+#define NBL_SET_RO_ATTR(dev_name_attr, attr_name, attr_show) do {			\
+	typeof(dev_name_attr) _name_attr = (dev_name_attr);				\
+	(_name_attr)->attr.name = __stringify(attr_name);				\
+	(_name_attr)->attr.mode = SYSFS_PREALLOC | VERIFY_OCTAL_PERMISSIONS(0444);	\
+	(_name_attr)->show = attr_show;							\
+	(_name_attr)->store = NULL;							\
+} while (0)
+
+static ssize_t net_rep_show(struct device *dev,
+			    struct nbl_netdev_name_attr *attr, char *buf)
+{
+	return scnprintf(buf, IFNAMSIZ, "%s\n", attr->net_dev_name);
+}
+
+static ssize_t nbl_st_name_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
+{
+	struct nbl_sysfs_st_info *st_info = container_of(attr, struct nbl_sysfs_st_info, kobj_attr);
+	struct nbl_dev_net *net_dev = st_info->net_dev;
+	struct nbl_netdev_priv *net_priv = netdev_priv(net_dev->netdev);
+	struct nbl_adapter *adapter = net_priv->adapter;
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_st_dev *st_dev = NBL_DEV_MGT_TO_ST_DEV(dev_mgt);
+
+	return snprintf(buf, PAGE_SIZE, "nblst/%s\n", st_dev->st_name);
+}
+
+void nbl_netdev_remove_st_sysfs(struct nbl_dev_net *net_dev)
+{
+	if (!net_dev->st_name.st_name_kobj)
+		return;
+
+	sysfs_remove_file(net_dev->st_name.st_name_kobj,
+			  &net_dev->st_name.st_info.kobj_attr.attr);
+
+	kobject_put(net_dev->st_name.st_name_kobj);
+}
+
+int nbl_netdev_add_st_sysfs(struct net_device *netdev, struct nbl_dev_net *net_dev)
+{
+	int ret;
+
+	net_dev->st_name.st_name_kobj = kobject_create_and_add("resource_tool", &netdev->dev.kobj);
+	if (!net_dev->st_name.st_name_kobj)
+		return -ENOMEM;
+
+	net_dev->st_name.st_info.net_dev = net_dev;
+	sysfs_attr_init(&net_dev->st_name.st_info.kobj_attr.attr);
+	net_dev->st_name.st_info.kobj_attr.attr.name = "st_name";
+	net_dev->st_name.st_info.kobj_attr.attr.mode = 0444;
+	net_dev->st_name.st_info.kobj_attr.show = nbl_st_name_show;
+
+	ret = sysfs_create_file(net_dev->st_name.st_name_kobj,
+				&net_dev->st_name.st_info.kobj_attr.attr);
+
+	if (ret)
+		netdev_err(netdev, "Failed to create st_name sysfs file\n");
+
+	return 0;
+}
+
+void nbl_net_add_name_attr(struct nbl_netdev_name_attr *attr, char *rep_name)
+{
+	sysfs_attr_init(&attr->attr);
+	NBL_SET_RO_ATTR(attr, dev_name, net_rep_show);
+	strscpy(attr->net_dev_name, rep_name, IFNAMSIZ);
+}
+
+void nbl_net_remove_dev_attr(struct nbl_dev_net *net_dev)
+{
+	sysfs_remove_file(&net_dev->netdev->dev.kobj, &net_dev->dev_attr.dev_name_attr.attr);
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.h
new file mode 100644
index 000000000000..6e5651af617b
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_sysfs.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_SYSFS_H_
+#define _NBL_SYSFS_H_
+
+struct nbl_sysfs_st_info {
+	struct nbl_dev_net *net_dev;
+	struct kobj_attribute kobj_attr;
+};
+
+struct nbl_st_name {
+	struct kobject *st_name_kobj;
+	struct nbl_sysfs_st_info st_info;
+};
+
+#endif
+
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index cc09abd15408..74ceb7de71f2 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -728,7 +728,8 @@ static int nbl_uvn_init(struct nbl_hw_mgt *hw_mgt)
 
 	quirks = nbl_hw_get_quirks(hw_mgt);
 
-	if (!(quirks & BIT(NBL_QUIRKS_UVN_PREFETCH_ALIGN)))
+	if (performance_mode & BIT(NBL_QUIRKS_UVN_PREFETCH_ALIGN) ||
+	    !(quirks & BIT(NBL_QUIRKS_UVN_PREFETCH_ALIGN)))
 		prefetch_init.sel = 1;
 
 	nbl_hw_write_regs(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT,
@@ -2063,7 +2064,8 @@ static void nbl_hw_enable_abnormal_irq(void *priv, bool enable_msix,
 
 	quirks = nbl_hw_get_quirks(hw_mgt);
 
-	if (!(quirks & BIT(NBL_QUIRKS_NO_TOE)))
+	if (performance_mode & BIT(NBL_QUIRKS_NO_TOE) ||
+	    !(quirks & BIT(NBL_QUIRKS_NO_TOE)))
 		abnormal_timeout = 0x3938700; /* 1s */
 
 	nbl_hw_write_regs(hw_mgt, NBL_PADPT_ABNORMAL_TIMEOUT,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 87c77e55415f..154598493f1f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -246,7 +246,8 @@ static int nbl_res_register_net(void *priv, u16 func_id,
 	ether_addr_copy(register_result->mac, mac);
 
 	quirks = nbl_res_get_quirks(res_mgt);
-	if (!(quirks & BIT(NBL_QUIRKS_NO_TOE))) {
+	if (performance_mode & BIT(NBL_QUIRKS_NO_TOE) ||
+	    !(quirks & BIT(NBL_QUIRKS_NO_TOE))) {
 		csumo_features = NBL_FEATURE(NETIF_F_RXCSUM) |
 				NBL_FEATURE(NETIF_F_IP_CSUM) |
 				NBL_FEATURE(NETIF_F_IPV6_CSUM);
@@ -978,6 +979,7 @@ static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
 
 		nbl_res_set_fix_capability(res_mgt, NBL_HIGH_THROUGHPUT_CAP);
 		nbl_res_set_fix_capability(res_mgt, NBL_DVN_DESC_REQ_SYSFS_CAP);
+		nbl_res_set_fix_capability(res_mgt, NBL_NEED_DESTROY_CHIP);
 	}
 
 	if (caps.has_net) {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index 58aa1b0eafdb..cf6570b9a246 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -256,6 +256,15 @@ struct nbl_common_info {
 	bool wol_ena;
 };
 
+struct nbl_netdev_name_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct device *dev,
+			struct nbl_netdev_name_attr *attr, char *buf);
+	ssize_t (*store)(struct device *dev,
+			 struct nbl_netdev_name_attr *attr, const char *buf, size_t len);
+	char net_dev_name[IFNAMSIZ];
+};
+
 struct nbl_index_tbl_key {
 	struct device *dev;
 	u32 start_index;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
new file mode 100644
index 000000000000..74f231dd997b
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_DEV_H_
+#define _NBL_DEF_DEV_H_
+
+#include "nbl_include.h"
+
+#define NBL_DEV_OPS_TBL_TO_OPS(dev_ops_tbl)	((dev_ops_tbl)->ops)
+#define NBL_DEV_OPS_TBL_TO_PRIV(dev_ops_tbl)	((dev_ops_tbl)->priv)
+
+struct nbl_dev_ops {
+};
+
+struct nbl_dev_ops_tbl {
+	struct nbl_dev_ops *ops;
+	void *priv;
+};
+
+int nbl_dev_init(void *p, struct nbl_init_param *param);
+void nbl_dev_remove(void *p);
+void nbl_dev_register_dev_name(void *p);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
index d5dd7b6726cc..39788878a42e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
@@ -13,6 +13,87 @@
 #define NBL_SERV_OPS_TBL_TO_PRIV(serv_ops_tbl) ((serv_ops_tbl)->priv)
 
 struct nbl_service_ops {
+	int (*init_chip)(void *p);
+	int (*destroy_chip)(void *p);
+	void (*get_common_irq_num)(void *priv, struct nbl_common_irq_num *irq_num);
+	void (*get_ctrl_irq_num)(void *priv, struct nbl_ctrl_irq_num *irq_num);
+	int (*get_port_attributes)(void *p);
+	int (*update_template_config)(void *priv);
+	int (*get_part_number)(void *priv, char *part_number);
+	int (*get_serial_number)(void *priv, char *serial_number);
+	int (*enable_port)(void *p, bool enable);
+	void (*init_port)(void *priv);
+	int (*vsi_open)(void *priv, struct net_device *netdev, u16 vsi_index,
+			u16 real_qps, bool use_napi);
+	int (*vsi_stop)(void *priv, u16 vsi_index);
+	int (*netdev_open)(struct net_device *netdev);
+	int (*netdev_stop)(struct net_device *netdev);
+	void (*get_stats64)(struct net_device *netdev, struct rtnl_link_stats64 *stats);
+	void (*set_rx_mode)(struct net_device *dev);
+	void (*change_rx_flags)(struct net_device *dev, int flag);
+	int (*rx_add_vid)(struct net_device *dev, __be16 proto, u16 vid);
+	int (*rx_kill_vid)(struct net_device *dev, __be16 proto, u16 vid);
+	int (*set_features)(struct net_device *dev, netdev_features_t features);
+	netdev_features_t (*features_check)(struct sk_buff *skb, struct net_device *dev,
+					    netdev_features_t features);
+	int (*get_phys_port_name)(struct net_device *dev, char *name, size_t len);
+	int (*set_vf_spoofchk)(struct net_device *netdev, int vf_id, bool ena);
+	int (*set_vf_link_state)(struct net_device *dev, int vf_id, int link_state);
+	int (*set_vf_mac)(struct net_device *netdev, int vf_id, u8 *mac);
+	int (*set_vf_rate)(struct net_device *netdev, int vf_id, int min_rate, int max_rate);
+	int (*set_vf_vlan)(struct net_device *dev, int vf_id, u16 vlan, u8 pri, __be16 proto);
+	int (*get_vf_config)(struct net_device *dev, int vf_id, struct ifla_vf_info *ivi);
+	int (*get_vf_stats)(struct net_device *dev, int vf_id, struct ifla_vf_stats *vf_stats);
+	void (*tx_timeout)(struct net_device *netdev, u32 txqueue);
+
+	int (*bridge_setlink)(struct net_device *netdev, struct nlmsghdr *nlh,
+			      u16 flags, struct netlink_ext_ack *extack);
+	int (*bridge_getlink)(struct sk_buff *skb, u32 pid, u32 seq,
+			      struct net_device *dev, u32 filter_mask, int nlflags);
+	u16 (*select_queue)(struct net_device *netdev, struct sk_buff *skb,
+			    struct net_device *sb_dev);
+	int (*set_vf_trust)(struct net_device *netdev, int vf_id, bool trusted);
+	int (*register_net)(void *priv, struct nbl_register_net_param *register_param,
+			    struct nbl_register_net_result *register_result);
+	int (*unregister_net)(void *priv);
+	int (*register_vsi_info)(void *priv, struct nbl_vsi_param *vsi_param);
+	int (*start_mgt_flow)(void *priv);
+	void (*stop_mgt_flow)(void *priv);
+	u32 (*get_tx_headroom)(void *priv);
+	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
+	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id);
+	void (*set_sfp_state)(void *priv, struct net_device *netdev, u8 eth_id,
+			      bool open, bool is_force);
+	int (*get_board_id)(void *priv);
+	void (*get_board_info)(void *priv, struct nbl_board_port_info *board_info);
+
+	void (*get_rep_queue_info)(void *priv, u16 *queue_num, u16 *queue_size);
+	void (*get_user_queue_info)(void *priv, u16 *queue_num, u16 *queue_size, u16 vsi_id);
+	void (*set_netdev_ops)(void *priv, const struct net_device_ops *net_device_ops, bool is_pf);
+
+	u8 __iomem * (*get_hw_addr)(void *priv, size_t *size);
+	u16 (*get_function_id)(void *priv, u16 vsi_id);
+	void (*get_real_bdf)(void *priv, u16 vsi_id, u8 *bus, u8 *dev, u8 *function);
+	int (*set_eth_mac_addr)(void *priv, u8 *mac, u8 eth_id);
+	int (*process_abnormal_event)(void *priv);
+	void (*adapt_desc_gother)(void *priv);
+	void (*process_flr)(void *priv, u16 vfid);
+	u16 (*covert_vfid_to_vsi_id)(void *priv, u16 vfid);
+	void (*recovery_abnormal)(void *priv);
+	void (*keep_alive)(void *priv);
+
+	bool (*check_fw_heartbeat)(void *priv);
+	bool (*check_fw_reset)(void *priv);
+
+	bool (*get_product_fix_cap)(void *priv, enum nbl_fix_cap_type cap_type);
+	int (*setup_st)(void *priv, void *st_table_param, char *st_name);
+	void (*remove_st)(void *priv, void *st_table_param);
+	void (*register_real_st_name)(void *priv, char *st_name);
+	void (*register_dev_name)(void *priv, u16 vsi_id, char *name);
+	void (*set_hw_status)(void *priv, enum nbl_hw_status hw_status);
+	void (*get_active_func_bitmaps)(void *priv, unsigned long *bitmap, int max_func);
+
+	u16 (*get_vf_function_id)(void *priv, int vf_id);
 };
 
 struct nbl_service_ops_tbl {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 9341ed6d59fa..f331cf1471a7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -54,6 +54,9 @@
 
 #define NBL_MAX_FUNC					(520)
 #define NBL_MAX_MTU					15
+
+#define SET_DEV_MIN_MTU(netdev, mtu) ((netdev)->min_mtu = (mtu))
+#define SET_DEV_MAX_MTU(netdev, mtu) ((netdev)->max_mtu = (mtu))
 /* Used for macros to pass checkpatch */
 #define NBL_NAME(x)					x
 
@@ -109,6 +112,11 @@ enum nbl_hw_status {
 	NBL_HW_STATUS_MAX,
 };
 
+enum nbl_reset_event {
+	NBL_HW_FATAL_ERR_EVENT, /* Most hw module is not work nomal exclude pcie/emp */
+	NBL_HW_MAX_EVENT
+};
+
 struct nbl_func_caps {
 	u32 has_ctrl:1;
 	u32 has_net:1;
@@ -435,6 +443,25 @@ struct nbl_fw_cmd_vf_num_param {
 	u16 vf_max_num[NBL_VF_NUM_CMD_LEN];
 };
 
+#define NBL_RESTOOL_NAME_LEN	32
+#define NBL_ST_INFO_NAME_LEN				(64)
+#define NBL_ST_INFO_NETDEV_MAX				(8)
+#define NBL_ST_INFO_RESERVED_LEN			(344)
+struct nbl_st_info_param {
+	u8 version;
+	u8 bus;
+	u8 devid;
+	u8 function;
+	u16 domain;
+	u16 rsv0;
+	char driver_name[NBL_ST_INFO_NAME_LEN];
+	char driver_ver[NBL_ST_INFO_NAME_LEN];
+	char netdev_name[NBL_ST_INFO_NETDEV_MAX][NBL_ST_INFO_NAME_LEN];
+	char real_chrdev_flag;
+	char real_chrdev_name[31];
+	u8 rsv[NBL_ST_INFO_RESERVED_LEN];
+} __packed;
+
 #define NBL_OPS_CALL(func, para)								\
 	({ typeof(func) _func = (func);								\
 	 (!_func) ? 0 : _func para; })
@@ -521,6 +548,20 @@ static const netdev_features_t nbl_netdev_features[] = {
 };
 
 #define NBL_FEATURE(name)			(1 << (NBL_##name##_BIT))
+#define NBL_FEATURE_TEST_BIT(val, loc)		(((val) >> (loc)) & 0x1)
+
+static inline netdev_features_t nbl_features_to_netdev_features(u64 features)
+{
+	netdev_features_t netdev_features = 0;
+	int i = 0;
+
+	for (i = 0; i < NBL_FEATURES_COUNT; i++) {
+		if (NBL_FEATURE_TEST_BIT(features, i))
+			netdev_features += nbl_netdev_features[i];
+	}
+
+	return netdev_features;
+};
 
 enum nbl_abnormal_event_module {
 	NBL_ABNORMAL_EVENT_DVN = 0,
@@ -544,6 +585,8 @@ enum nbl_performance_mode {
 	NBL_QUIRKS_UVN_PREFETCH_ALIGN,
 };
 
+extern int performance_mode;
+
 struct nbl_vsi_param {
 	u16 vsi_id;
 	u16 queue_offset;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index a67f6ce75a93..a15b2068e1e1 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -7,6 +7,7 @@
 #include <linux/aer.h>
 #include "nbl_core.h"
 
+static struct nbl_software_tool_table nbl_st_table;
 static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
 	{
 		.hw_init	= nbl_hw_init_leonis,
@@ -18,6 +19,11 @@ static struct nbl_product_base_ops nbl_product_base_ops[NBL_PRODUCT_MAX] = {
 	},
 };
 
+static char *nblst_cdevnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "nblst/%s", dev_name(dev));
+}
+
 static void nbl_core_setup_product_ops(struct nbl_adapter *adapter, struct nbl_init_param *param,
 				       struct nbl_product_base_ops **product_base_ops)
 {
@@ -78,7 +84,14 @@ struct nbl_adapter *nbl_core_init(struct pci_dev *pdev, struct nbl_init_param *p
 	ret = nbl_serv_init(adapter, param);
 	if (ret)
 		goto serv_init_fail;
+
+	ret = nbl_dev_init(adapter, param);
+	if (ret)
+		goto dev_init_fail;
 	return adapter;
+
+dev_init_fail:
+	nbl_serv_remove(adapter);
 serv_init_fail:
 	nbl_disp_remove(adapter);
 disp_init_fail:
@@ -103,6 +116,7 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 
 	dev = NBL_ADAPTER_TO_DEV(adapter);
 	product_base_ops = NBL_ADAPTER_TO_RPDUCT_BASE_OPS(adapter);
+	nbl_dev_remove(adapter);
 	nbl_serv_remove(adapter);
 	nbl_disp_remove(adapter);
 	product_base_ops->res_remove(adapter);
@@ -111,6 +125,42 @@ void nbl_core_remove(struct nbl_adapter *adapter)
 	devm_kfree(dev, adapter);
 }
 
+int nbl_st_init(struct nbl_software_tool_table *st_table)
+{
+	dev_t devid;
+	int ret = 0;
+
+	ret = alloc_chrdev_region(&devid, 0, NBL_ST_MAX_DEVICE_NUM, "nblst");
+	if (ret < 0)
+		return ret;
+
+	st_table->major = MAJOR(devid);
+	st_table->devno = devid;
+
+	st_table->cls = class_create("nblst_cls");
+
+	st_table->cls->devnode = nblst_cdevnode;
+	if (IS_ERR(st_table->cls)) {
+		unregister_chrdev(st_table->major, "nblst");
+		unregister_chrdev_region(st_table->devno, NBL_ST_MAX_DEVICE_NUM);
+		ret = -EBUSY;
+	}
+
+	return ret;
+}
+
+void nbl_st_remove(struct nbl_software_tool_table *st_table)
+{
+	class_destroy(st_table->cls);
+	unregister_chrdev(st_table->major, "nblst");
+	unregister_chrdev_region(st_table->devno, NBL_ST_MAX_DEVICE_NUM);
+}
+
+struct nbl_software_tool_table *nbl_get_st_table(void)
+{
+	return &nbl_st_table;
+}
+
 static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
 			       struct nbl_init_param *param)
 {
@@ -317,6 +367,8 @@ static int __init nbl_module_init(void)
 		pr_err("Failed to create wq, err = %d\n", status);
 		goto wq_create_failed;
 	}
+	nbl_st_init(nbl_get_st_table());
+
 	status = pci_register_driver(&nbl_driver);
 	if (status) {
 		pr_err("Failed to register PCI driver, err = %d\n", status);
@@ -335,7 +387,10 @@ static void __exit nbl_module_exit(void)
 {
 	pci_unregister_driver(&nbl_driver);
 
+	nbl_st_remove(nbl_get_st_table());
+
 	nbl_common_destroy_wq();
+
 	pr_info("nbl module unloaded\n");
 }
 
-- 
2.43.0


