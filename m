Return-Path: <netdev+bounces-248424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A036D08689
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CE5A305BCCF
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5F43382E1;
	Fri,  9 Jan 2026 10:02:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1C923D7CE;
	Fri,  9 Jan 2026 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952970; cv=none; b=rpdkvddC4vMkcmHmrNHFwH0QAphtOcsPre6pq2nRWIuLP3Yh1H/Ri3VqrMC7BKG2Kq8kL3iYrJoVKGcCfOBI2rYnQLW9Gp0Z5OiD3D6rhMY2fgn6ridXPdKmOWN0qPy6KEUt20T4zPyg0h6D00P2LA+I0If/knGBGAvMUO8Pyx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952970; c=relaxed/simple;
	bh=EacljC2AzM+e43d5pvf306MnL4X2V2uw9GjUe0h5dCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7ED9r+qaasc+hawLVuSowdlD1OHRy23QFxlwSLP5h50hBO6I74UxqKB5RUmLWHGP5L91hX6pdy1udEXI5zeJgr9nmgVC+6VZe4Pl4Lg1+fqZ6ikN8UqGGp8S7KxDaVrJfQi0Y6IlzZ4fFmwHgx396GV+FxQRZByS9IrMU974c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQAkw_1767952955 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:36 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 net-next 07/15] net/nebula-matrix: add intr resource definitions and implementation
Date: Fri,  9 Jan 2026 18:01:25 +0800
Message-ID: <20260109100146.63569-8-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

intr interfaces offer comprehensive interrupt lifecycle management
functions (including configuration, enabling, disabling, and
destruction), status query capabilities,as well as performance tuning
features (such as suppression levels). Additionally, they provide
differentiated handling for PF and VF, making them suitable for
high-performance networking devices (e.g., in SR-IOV scenarios).

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 204 ++++++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  18 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 448 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  13 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |   4 +
 .../nbl/nbl_include/nbl_def_hw.h              |  17 +
 .../nbl/nbl_include/nbl_include.h             |   6 +
 8 files changed, 711 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 977544cd1b95..9c20af47313e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -10,6 +10,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_hw/nbl_resource.o \
+				nbl_hw/nbl_interrupt.o \
 				nbl_hw/nbl_adminq.o \
 				nbl_main.o
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 57cae6baaafd..cc792497d01f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -19,6 +19,164 @@ static u32 nbl_hw_get_quirks(void *priv)
 	return quirks;
 }
 
+static void nbl_hw_enable_mailbox_irq(void *priv, u16 func_id, bool enable_msix,
+				      u16 global_vec_id)
+{
+	struct nbl_mailbox_qinfo_map_table mb_qinfo_map = { 0 };
+
+	nbl_hw_rd_regs(priv, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
+		       (u8 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
+
+	if (enable_msix) {
+		mb_qinfo_map.msix_idx = global_vec_id;
+		mb_qinfo_map.msix_idx_valid = 1;
+	} else {
+		mb_qinfo_map.msix_idx = 0;
+		mb_qinfo_map.msix_idx_valid = 0;
+	}
+
+	nbl_hw_wr_regs(priv, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
+		       (u8 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
+}
+
+static void nbl_abnormal_intr_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_fem_int_mask fem_mask = { 0 };
+	struct nbl_epro_int_mask epro_mask = { 0 };
+	u32 top_ctrl_mask = 0xFFFFFFFF;
+
+	/* Mask and clear fem cfg_err */
+	nbl_hw_rd_regs(hw_mgt, NBL_FEM_INT_MASK, (u8 *)&fem_mask,
+		       sizeof(fem_mask));
+	fem_mask.cfg_err = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_INT_MASK, (u8 *)&fem_mask,
+		       sizeof(fem_mask));
+
+	memset(&fem_mask, 0, sizeof(fem_mask));
+	fem_mask.cfg_err = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_FEM_INT_STATUS, (u8 *)&fem_mask,
+		       sizeof(fem_mask));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_FEM_INT_MASK, (u8 *)&fem_mask,
+		       sizeof(fem_mask));
+
+	/* Mask and clear epro cfg_err */
+	nbl_hw_rd_regs(hw_mgt, NBL_EPRO_INT_MASK, (u8 *)&epro_mask,
+		       sizeof(epro_mask));
+	epro_mask.cfg_err = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_INT_MASK, (u8 *)&epro_mask,
+		       sizeof(epro_mask));
+
+	memset(&epro_mask, 0, sizeof(epro_mask));
+	epro_mask.cfg_err = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_EPRO_INT_STATUS, (u8 *)&epro_mask,
+		       sizeof(epro_mask));
+
+	/* Mask and clear all top_tcrl abnormal intrs.
+	 */
+	nbl_hw_wr_regs(hw_mgt, NBL_TOP_CTRL_INT_MASK, (u8 *)&top_ctrl_mask,
+		       sizeof(top_ctrl_mask));
+
+	nbl_hw_wr_regs(hw_mgt, NBL_TOP_CTRL_INT_STATUS, (u8 *)&top_ctrl_mask,
+		       sizeof(top_ctrl_mask));
+}
+
+static void nbl_hw_enable_abnormal_irq(void *priv, bool enable_msix,
+				       u16 global_vec_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_abnormal_msix_vector abnormal_msix_vetcor = { 0 };
+	u32 abnormal_timeout = 0x927C0; /* 600000, 1ms */
+	u32 quirks;
+
+	if (enable_msix) {
+		abnormal_msix_vetcor.idx = global_vec_id;
+		abnormal_msix_vetcor.vld = 1;
+	}
+
+	quirks = nbl_hw_get_quirks(hw_mgt);
+
+	if (!(quirks & BIT(NBL_QUIRKS_NO_TOE)))
+		abnormal_timeout = 0x3938700; /* 1s */
+
+	nbl_hw_wr_regs(hw_mgt, NBL_PADPT_ABNORMAL_TIMEOUT,
+		       (u8 *)&abnormal_timeout, sizeof(abnormal_timeout));
+
+	nbl_hw_wr_regs(hw_mgt, NBL_PADPT_ABNORMAL_MSIX_VEC,
+		       (u8 *)&abnormal_msix_vetcor,
+		       sizeof(abnormal_msix_vetcor));
+
+	nbl_abnormal_intr_init(hw_mgt);
+}
+
+static void nbl_hw_enable_msix_irq(void *priv, u16 global_vec_id)
+{
+	struct nbl_msix_notify msix_notify = { 0 };
+
+	msix_notify.glb_msix_idx = global_vec_id;
+
+	nbl_hw_wr_regs(priv, NBL_PCOMPLETER_MSIX_NOTIRY_OFFSET,
+		       (u8 *)&msix_notify, sizeof(msix_notify));
+}
+
+static u8 __iomem *
+nbl_hw_get_msix_irq_enable_info(void *priv, u16 global_vec_id, u32 *irq_data)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_msix_notify msix_notify = { 0 };
+
+	msix_notify.glb_msix_idx = global_vec_id;
+	memcpy(irq_data, &msix_notify, sizeof(msix_notify));
+
+	return (hw_mgt->hw_addr + NBL_PCOMPLETER_MSIX_NOTIRY_OFFSET);
+}
+
+static void nbl_hw_configure_msix_map(void *priv, u16 func_id, bool valid,
+				      dma_addr_t dma_addr, u8 bus, u8 devid,
+				      u8 function)
+{
+	struct nbl_function_msix_map function_msix_map = { 0 };
+
+	if (valid) {
+		function_msix_map.msix_map_base_addr = dma_addr;
+		/* use af's bdf, because dma memmory is alloc by af */
+		function_msix_map.function = function;
+		function_msix_map.devid = devid;
+		function_msix_map.bus = bus;
+		function_msix_map.valid = 1;
+	}
+
+	nbl_hw_wr_regs(priv, NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(func_id),
+		       (u8 *)&function_msix_map, sizeof(function_msix_map));
+}
+
+static void nbl_hw_configure_msix_info(void *priv, u16 func_id, bool valid,
+				       u16 interrupt_id, u8 bus, u8 devid,
+				       u8 function, bool msix_mask_en)
+{
+	struct nbl_pcompleter_host_msix_fid_table host_msix_fid_table = { 0 };
+	struct nbl_host_msix_info msix_info = { 0 };
+
+	if (valid) {
+		host_msix_fid_table.vld = 1;
+		host_msix_fid_table.fid = func_id;
+
+		msix_info.intrl_pnum = 0;
+		msix_info.intrl_rate = 0;
+		msix_info.function = function;
+		msix_info.devid = devid;
+		msix_info.bus = bus;
+		msix_info.valid = 1;
+		if (msix_mask_en)
+			msix_info.msix_mask_en = 1;
+	}
+
+	nbl_hw_wr_regs(priv, NBL_PADPT_HOST_MSIX_INFO_REG_ARR(interrupt_id),
+		       (u8 *)&msix_info, sizeof(msix_info));
+	nbl_hw_wr_regs(priv, NBL_PCOMPLETER_HOST_MSIX_FID_TABLE(interrupt_id),
+		       (u8 *)&host_msix_fid_table, sizeof(host_msix_fid_table));
+}
+
 static void nbl_hw_update_mailbox_queue_tail_ptr(void *priv, u16 tail_ptr,
 						 u8 txrx)
 {
@@ -203,6 +361,20 @@ static void nbl_hw_cfg_mailbox_qinfo(void *priv, u16 func_id, u16 bus,
 		       (u8 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
 }
 
+static void nbl_hw_set_coalesce(void *priv, u16 interrupt_id, u16 pnum,
+				u16 rate)
+{
+	struct nbl_host_msix_info msix_info = { 0 };
+
+	nbl_hw_rd_regs(priv, NBL_PADPT_HOST_MSIX_INFO_REG_ARR(interrupt_id),
+		       (u8 *)&msix_info, sizeof(msix_info));
+
+	msix_info.intrl_pnum = pnum;
+	msix_info.intrl_rate = rate;
+	nbl_hw_wr_regs(priv, NBL_PADPT_HOST_MSIX_INFO_REG_ARR(interrupt_id),
+		       (u8 *)&msix_info, sizeof(msix_info));
+}
+
 static void nbl_hw_config_adminq_rxq(void *priv, dma_addr_t dma_addr,
 				     int size_bwid)
 {
@@ -277,6 +449,30 @@ static void nbl_hw_cfg_adminq_qinfo(void *priv, u16 bus, u16 devid,
 			      sizeof(adminq_qinfo_map));
 }
 
+static void nbl_hw_enable_adminq_irq(void *priv, bool enable_msix,
+				     u16 global_vec_id)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_common_info *common = NBL_HW_MGT_TO_COMMON(hw_mgt);
+	struct nbl_adminq_qinfo_map_table adminq_qinfo_map = { 0 };
+
+	adminq_qinfo_map.bus = common->hw_bus;
+	adminq_qinfo_map.devid = common->devid;
+	adminq_qinfo_map.function = NBL_COMMON_TO_PCI_FUNC_ID(common);
+
+	if (enable_msix) {
+		adminq_qinfo_map.msix_idx = global_vec_id;
+		adminq_qinfo_map.msix_idx_valid = 1;
+	} else {
+		adminq_qinfo_map.msix_idx = 0;
+		adminq_qinfo_map.msix_idx_valid = 0;
+	}
+
+	nbl_hw_write_mbx_regs(priv, NBL_ADMINQ_MSIX_MAP_TABLE_ADDR,
+			      (u8 *)&adminq_qinfo_map,
+			      sizeof(adminq_qinfo_map));
+}
+
 static void nbl_hw_update_adminq_queue_tail_ptr(void *priv, u16 tail_ptr,
 						u8 txrx)
 {
@@ -551,6 +747,9 @@ static enum nbl_hw_status nbl_hw_get_hw_status(void *priv)
 };
 
 static struct nbl_hw_ops hw_ops = {
+	.configure_msix_map = nbl_hw_configure_msix_map,
+	.configure_msix_info = nbl_hw_configure_msix_info,
+	.set_coalesce = nbl_hw_set_coalesce,
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
 	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
@@ -564,12 +763,17 @@ static struct nbl_hw_ops hw_ops = {
 	.get_pf_bar_addr = nbl_hw_get_pf_bar_addr,
 	.get_vf_bar_addr = nbl_hw_get_vf_bar_addr,
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+	.enable_mailbox_irq = nbl_hw_enable_mailbox_irq,
+	.enable_abnormal_irq = nbl_hw_enable_abnormal_irq,
+	.enable_msix_irq = nbl_hw_enable_msix_irq,
+	.get_msix_irq_enable_info = nbl_hw_get_msix_irq_enable_info,
 
 	.config_adminq_rxq = nbl_hw_config_adminq_rxq,
 	.config_adminq_txq = nbl_hw_config_adminq_txq,
 	.stop_adminq_rxq = nbl_hw_stop_adminq_rxq,
 	.stop_adminq_txq = nbl_hw_stop_adminq_txq,
 	.cfg_adminq_qinfo = nbl_hw_cfg_adminq_qinfo,
+	.enable_adminq_irq = nbl_hw_enable_adminq_irq,
 	.update_adminq_queue_tail_ptr = nbl_hw_update_adminq_queue_tail_ptr,
 	.check_adminq_dma_err = nbl_hw_check_adminq_dma_err,
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index ea5c83b1ab76..b4c6de135a26 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -490,6 +490,7 @@ static struct nbl_resource_ops res_ops = {
 static struct nbl_res_product_ops product_ops = {
 };
 
+static bool is_ops_inited;
 static int
 nbl_res_setup_res_mgt(struct nbl_common_info *common,
 		      struct nbl_resource_mgt_leonis **res_mgt_leonis)
@@ -537,15 +538,28 @@ static int nbl_res_setup_ops(struct device *dev,
 			     struct nbl_resource_ops_tbl **res_ops_tbl,
 			     struct nbl_resource_mgt_leonis *res_mgt_leonis)
 {
+	int ret = 0;
+
 	*res_ops_tbl = devm_kzalloc(dev, sizeof(struct nbl_resource_ops_tbl),
 				    GFP_KERNEL);
 	if (!*res_ops_tbl)
 		return -ENOMEM;
 
+	if (!is_ops_inited) {
+		ret = nbl_intr_setup_ops(&res_ops);
+		if (ret)
+			goto setup_fail;
+		is_ops_inited = true;
+	}
+
 	(*res_ops_tbl)->ops = &res_ops;
 	(*res_ops_tbl)->priv = res_mgt_leonis;
 
 	return 0;
+
+setup_fail:
+	nbl_res_remove_ops(dev, res_ops_tbl);
+	return -EAGAIN;
 }
 
 static int nbl_res_ctrl_dev_setup_eth_info(struct nbl_resource_mgt *res_mgt)
@@ -851,6 +865,7 @@ static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
 {
 	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
 
+	nbl_intr_mgt_stop(res_mgt);
 	nbl_res_ctrl_dev_ustore_stats_remove(res_mgt);
 	nbl_res_ctrl_dev_remove_vsi_info(res_mgt);
 	nbl_res_ctrl_dev_remove_eth_info(res_mgt);
@@ -903,6 +918,9 @@ static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
 		if (ret)
 			goto start_fail;
 
+		ret = nbl_intr_mgt_start(res_mgt);
+		if (ret)
+			goto start_fail;
 		nbl_res_set_fix_capability(res_mgt, NBL_TASK_FW_HB_CAP);
 		nbl_res_set_fix_capability(res_mgt, NBL_TASK_FW_RESET_CAP);
 		nbl_res_set_fix_capability(res_mgt, NBL_TASK_CLEAN_ADMINDQ_CAP);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
new file mode 100644
index 000000000000..176478bcb414
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_interrupt.h"
+
+static int nbl_res_intr_destroy_msix_map(void *priv, u16 func_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct device *dma_dev;
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_interrupt_mgt *intr_mgt;
+	struct nbl_msix_map_table *msix_map_table;
+	u16 *interrupts;
+	u16 intr_num;
+	u16 i;
+
+	if (!res_mgt)
+		return -EINVAL;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	intr_mgt = NBL_RES_MGT_TO_INTR_MGT(res_mgt);
+	dma_dev = NBL_RES_MGT_TO_DMA_DEV(res_mgt);
+
+	/* use ctrl dev bdf */
+	hw_ops->configure_msix_map(NBL_RES_MGT_TO_HW_PRIV(res_mgt), func_id,
+				   false, 0, 0, 0, 0);
+
+	intr_num = intr_mgt->func_intr_res[func_id].num_interrupts;
+	interrupts = intr_mgt->func_intr_res[func_id].interrupts;
+
+	WARN_ON(!interrupts);
+	for (i = 0; i < intr_num; i++) {
+		if (interrupts[i] >= NBL_MAX_OTHER_INTERRUPT)
+			clear_bit(interrupts[i] - NBL_MAX_OTHER_INTERRUPT,
+				  intr_mgt->interrupt_net_bitmap);
+		else
+			clear_bit(interrupts[i],
+				  intr_mgt->interrupt_others_bitmap);
+
+		hw_ops->configure_msix_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					    func_id, false, interrupts[i], 0, 0,
+					    0, false);
+	}
+
+	kfree(interrupts);
+	intr_mgt->func_intr_res[func_id].interrupts = NULL;
+	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
+
+	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
+	dma_free_coherent(dma_dev, msix_map_table->size,
+			  msix_map_table->base_addr, msix_map_table->dma);
+	msix_map_table->size = 0;
+	msix_map_table->base_addr = NULL;
+	msix_map_table->dma = 0;
+
+	return 0;
+}
+
+static int nbl_res_intr_configure_msix_map(void *priv, u16 func_id,
+					   u16 num_net_msix,
+					   u16 num_others_msix,
+					   bool net_msix_mask_en)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct device *dma_dev;
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_interrupt_mgt *intr_mgt;
+	struct nbl_common_info *common;
+	struct nbl_msix_map_table *msix_map_table;
+	struct nbl_msix_map *msix_map_entries;
+	u16 *interrupts;
+	u16 requested;
+	u16 intr_index;
+	u16 i;
+	u8 bus, devid, function;
+	bool msix_mask_en;
+	int ret = 0;
+
+	if (!res_mgt)
+		return -EINVAL;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	intr_mgt = NBL_RES_MGT_TO_INTR_MGT(res_mgt);
+	dma_dev = NBL_RES_MGT_TO_DMA_DEV(res_mgt);
+	common = NBL_RES_MGT_TO_COMMON(res_mgt);
+
+	if (intr_mgt->func_intr_res[func_id].interrupts)
+		nbl_res_intr_destroy_msix_map(priv, func_id);
+
+	nbl_res_func_id_to_bdf(res_mgt, func_id, &bus, &devid, &function);
+
+	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
+	WARN_ON(msix_map_table->base_addr);
+	msix_map_table->size =
+		sizeof(struct nbl_msix_map) * NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
+	msix_map_table->base_addr = dma_alloc_coherent(dma_dev,
+						       msix_map_table->size,
+						       &msix_map_table->dma,
+						       GFP_ATOMIC | __GFP_ZERO);
+	if (!msix_map_table->base_addr) {
+		pr_err("Allocate DMA memory for function msix map table failed\n");
+		msix_map_table->size = 0;
+		return -ENOMEM;
+	}
+
+	requested = num_net_msix + num_others_msix;
+	interrupts = kcalloc(requested, sizeof(interrupts[0]), GFP_ATOMIC);
+	if (!interrupts) {
+		pr_err("Allocate function interrupts array failed\n");
+		ret = -ENOMEM;
+		goto alloc_interrupts_err;
+	}
+
+	intr_mgt->func_intr_res[func_id].interrupts = interrupts;
+	intr_mgt->func_intr_res[func_id].num_interrupts = requested;
+	intr_mgt->func_intr_res[func_id].num_net_interrupts = num_net_msix;
+
+	for (i = 0; i < num_net_msix; i++) {
+		intr_index = find_first_zero_bit(intr_mgt->interrupt_net_bitmap,
+						 NBL_MAX_NET_INTERRUPT);
+		if (intr_index == NBL_MAX_NET_INTERRUPT) {
+			pr_err("There is no available interrupt left\n");
+			ret = -EAGAIN;
+			goto get_interrupt_err;
+		}
+		interrupts[i] = intr_index + NBL_MAX_OTHER_INTERRUPT;
+		set_bit(intr_index, intr_mgt->interrupt_net_bitmap);
+	}
+
+	for (i = num_net_msix; i < requested; i++) {
+		intr_index =
+			find_first_zero_bit(intr_mgt->interrupt_others_bitmap,
+					    NBL_MAX_OTHER_INTERRUPT);
+		if (intr_index == NBL_MAX_OTHER_INTERRUPT) {
+			pr_err("There is no available interrupt left\n");
+			ret = -EAGAIN;
+			goto get_interrupt_err;
+		}
+		interrupts[i] = intr_index;
+		set_bit(intr_index, intr_mgt->interrupt_others_bitmap);
+	}
+
+	msix_map_entries = msix_map_table->base_addr;
+	for (i = 0; i < requested; i++) {
+		msix_map_entries[i].global_msix_index = interrupts[i];
+		msix_map_entries[i].valid = 1;
+
+		if (i < num_net_msix && net_msix_mask_en)
+			msix_mask_en = 1;
+		else
+			msix_mask_en = 0;
+		hw_ops->configure_msix_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					    func_id, true, interrupts[i], bus,
+					    devid, function, msix_mask_en);
+		if (i < num_net_msix)
+			hw_ops->set_coalesce(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+					     interrupts[i], 0, 0);
+	}
+
+	/* use ctrl dev bdf */
+	hw_ops->configure_msix_map(NBL_RES_MGT_TO_HW_PRIV(res_mgt), func_id,
+				   true, msix_map_table->dma, common->hw_bus,
+				   common->devid,
+				   NBL_COMMON_TO_PCI_FUNC_ID(common));
+
+	return 0;
+
+get_interrupt_err:
+	while (i--) {
+		intr_index = interrupts[i];
+		if (intr_index >= NBL_MAX_OTHER_INTERRUPT)
+			clear_bit(intr_index - NBL_MAX_OTHER_INTERRUPT,
+				  intr_mgt->interrupt_net_bitmap);
+		else
+			clear_bit(intr_index,
+				  intr_mgt->interrupt_others_bitmap);
+	}
+	kfree(interrupts);
+	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
+	intr_mgt->func_intr_res[func_id].interrupts = NULL;
+
+alloc_interrupts_err:
+	dma_free_coherent(dma_dev, msix_map_table->size,
+			  msix_map_table->base_addr, msix_map_table->dma);
+	msix_map_table->size = 0;
+	msix_map_table->base_addr = NULL;
+	msix_map_table->dma = 0;
+
+	return ret;
+}
+
+static int nbl_res_init_vf_msix_map(void *priv, u16 func_id, bool enable)
+{
+#define NBL_VF_NET_MSIX_NUM (4)
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	u16 net_msix_num = NBL_VF_NET_MSIX_NUM;
+	u16 tx_queue_num = 0;
+	u16 rx_queue_num = 0;
+
+	if (enable) {
+		if (res_mgt->common_ops.get_queue_num) {
+			res_mgt->common_ops.get_queue_num(priv, func_id,
+							  &tx_queue_num,
+							  &rx_queue_num);
+			net_msix_num = tx_queue_num + rx_queue_num;
+		}
+
+		return nbl_res_intr_configure_msix_map(priv, func_id,
+						       net_msix_num, 1, true);
+	}
+
+	nbl_res_intr_destroy_msix_map(priv, func_id);
+
+	return 0;
+}
+
+static int nbl_res_intr_destroy_msix_map_export(void *priv, u16 func_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	int ret = 0;
+
+	ret = nbl_res_intr_destroy_msix_map(priv, func_id);
+
+	if (func_id >= NBL_RES_MGT_TO_PF_NUM(res_mgt))
+		ret |= nbl_res_init_vf_msix_map(priv, func_id, true);
+
+	return ret;
+}
+
+static int nbl_res_intr_enable_mailbox_irq(void *priv, u16 func_id,
+					   u16 vector_id, bool enable_msix)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_interrupt_mgt *intr_mgt;
+	u16 global_vec_id;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	intr_mgt = NBL_RES_MGT_TO_INTR_MGT(res_mgt);
+
+	global_vec_id = intr_mgt->func_intr_res[func_id].interrupts[vector_id];
+	hw_ops->enable_mailbox_irq(NBL_RES_MGT_TO_HW_PRIV(res_mgt), func_id,
+				   enable_msix, global_vec_id);
+
+	return 0;
+}
+
+static int nbl_res_intr_enable_abnormal_irq(void *priv, u16 vector_id,
+					    bool enable_msix)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_interrupt_mgt *intr_mgt;
+	u16 global_vec_id;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	intr_mgt = NBL_RES_MGT_TO_INTR_MGT(res_mgt);
+
+	global_vec_id = intr_mgt->func_intr_res[0].interrupts[vector_id];
+	hw_ops->enable_abnormal_irq(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+				    enable_msix, global_vec_id);
+	return 0;
+}
+
+static u8 __iomem *nbl_res_get_msix_irq_enable_info(void *priv,
+						    u16 global_vec_id,
+						    u32 *irq_data)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	return hw_ops->get_msix_irq_enable_info(NBL_RES_MGT_TO_HW_PRIV(res_mgt),
+						global_vec_id, irq_data);
+}
+
+static u16 nbl_res_intr_get_global_vector(void *priv, u16 vsi_id,
+					  u16 local_vec_id)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_interrupt_mgt *intr_mgt = NBL_RES_MGT_TO_INTR_MGT(res_mgt);
+	u16 func_id = nbl_res_vsi_id_to_func_id(res_mgt, vsi_id);
+
+	return intr_mgt->func_intr_res[func_id].interrupts[local_vec_id];
+}
+
+static u16 nbl_res_intr_get_msix_entry_id(void *priv, u16 vsi_id,
+					  u16 local_vec_id)
+{
+	return local_vec_id;
+}
+
+static int nbl_res_intr_enable_adminq_irq(void *priv, u16 vector_id,
+					  bool enable_msix)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops;
+	struct nbl_interrupt_mgt *intr_mgt;
+	u16 global_vec_id;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	intr_mgt = NBL_RES_MGT_TO_INTR_MGT(res_mgt);
+
+	global_vec_id = intr_mgt->func_intr_res[0].interrupts[vector_id];
+	hw_ops->enable_adminq_irq(NBL_RES_MGT_TO_HW_PRIV(res_mgt), enable_msix,
+				     global_vec_id);
+	return 0;
+}
+
+static int nbl_res_intr_get_mbx_irq_num(void *priv)
+{
+	return 1;
+}
+
+static int nbl_res_intr_get_adminq_irq_num(void *priv)
+{
+	return 1;
+}
+
+static int nbl_res_intr_get_abnormal_irq_num(void *priv)
+{
+	return 1;
+}
+
+static void nbl_res_flr_clear_interrupt(void *priv, u16 vf_id)
+{
+}
+
+static void nbl_res_intr_unmask(struct nbl_resource_mgt *res_mgt,
+				u16 interrupts_id)
+{
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	hw_ops->enable_msix_irq(NBL_RES_MGT_TO_HW_PRIV(res_mgt), interrupts_id);
+}
+
+static void nbl_res_unmask_all_interrupts(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_interrupt_mgt *intr_mgt = NBL_RES_MGT_TO_INTR_MGT(res_mgt);
+	int i, j;
+
+	for (i = 0; i < NBL_MAX_PF; i++) {
+		if (intr_mgt->func_intr_res[i].interrupts) {
+			for (j = 0;
+			     j < intr_mgt->func_intr_res[i].num_interrupts; j++)
+				nbl_res_intr_unmask(res_mgt,
+						    intr_mgt->func_intr_res[i]
+							    .interrupts[j]);
+		}
+	}
+}
+
+/* NBL_INTR_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_INTR_OPS_TBL						\
+do {									\
+	NBL_INTR_SET_OPS(init_vf_msix_map, nbl_res_init_vf_msix_map);	\
+	NBL_INTR_SET_OPS(configure_msix_map,				\
+			 nbl_res_intr_configure_msix_map);		\
+	NBL_INTR_SET_OPS(destroy_msix_map,				\
+			 nbl_res_intr_destroy_msix_map_export);		\
+	NBL_INTR_SET_OPS(enable_mailbox_irq,				\
+			 nbl_res_intr_enable_mailbox_irq);		\
+	NBL_INTR_SET_OPS(enable_abnormal_irq,				\
+			 nbl_res_intr_enable_abnormal_irq);		\
+	NBL_INTR_SET_OPS(enable_adminq_irq,				\
+			 nbl_res_intr_enable_adminq_irq);		\
+	NBL_INTR_SET_OPS(get_msix_irq_enable_info,			\
+			 nbl_res_get_msix_irq_enable_info);		\
+	NBL_INTR_SET_OPS(get_global_vector,				\
+			 nbl_res_intr_get_global_vector);		\
+	NBL_INTR_SET_OPS(get_msix_entry_id,				\
+			 nbl_res_intr_get_msix_entry_id);		\
+	NBL_INTR_SET_OPS(get_mbx_irq_num,				\
+			 nbl_res_intr_get_mbx_irq_num);			\
+	NBL_INTR_SET_OPS(get_adminq_irq_num,				\
+			 nbl_res_intr_get_adminq_irq_num);		\
+	NBL_INTR_SET_OPS(get_abnormal_irq_num,				\
+			 nbl_res_intr_get_abnormal_irq_num);		\
+	NBL_INTR_SET_OPS(flr_clear_interrupt,				\
+			 nbl_res_flr_clear_interrupt);			\
+	NBL_INTR_SET_OPS(unmask_all_interrupts,				\
+			 nbl_res_unmask_all_interrupts);		\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_intr_setup_mgt(struct device *dev,
+			      struct nbl_interrupt_mgt **intr_mgt)
+{
+	*intr_mgt =
+		devm_kzalloc(dev, sizeof(struct nbl_interrupt_mgt), GFP_KERNEL);
+	if (!*intr_mgt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void nbl_intr_remove_mgt(struct device *dev,
+				struct nbl_interrupt_mgt **intr_mgt)
+{
+	devm_kfree(dev, *intr_mgt);
+	*intr_mgt = NULL;
+}
+
+int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_interrupt_mgt **intr_mgt;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	intr_mgt = &NBL_RES_MGT_TO_INTR_MGT(res_mgt);
+
+	return nbl_intr_setup_mgt(dev, intr_mgt);
+}
+
+void nbl_intr_mgt_stop(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_interrupt_mgt **intr_mgt;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	intr_mgt = &NBL_RES_MGT_TO_INTR_MGT(res_mgt);
+
+	if (!(*intr_mgt))
+		return;
+
+	nbl_intr_remove_mgt(dev, intr_mgt);
+}
+
+int nbl_intr_setup_ops(struct nbl_resource_ops *res_ops)
+{
+#define NBL_INTR_SET_OPS(name, func)		\
+	do {					\
+		res_ops->NBL_NAME(name) = func; \
+		;				\
+	} while (0)
+	NBL_INTR_OPS_TBL;
+#undef  NBL_INTR_SET_OPS
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
new file mode 100644
index 000000000000..5448bcf36416
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_INTERRUPT_H_
+#define _NBL_INTERRUPT_H_
+
+#include "nbl_resource.h"
+
+#define NBL_MSIX_MAP_TABLE_MAX_ENTRIES	(1024)
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index e90d25e6bc20..5cbe0ebc4f89 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -845,6 +845,10 @@ u8 nbl_res_vsi_id_to_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
 int nbl_adminq_mgt_start(struct nbl_resource_mgt *res_mgt);
 void nbl_adminq_mgt_stop(struct nbl_resource_mgt *res_mgt);
 int nbl_adminq_setup_ops(struct nbl_resource_ops *resource_ops);
+
+int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt);
+void nbl_intr_mgt_stop(struct nbl_resource_mgt *res_mgt);
+int nbl_intr_setup_ops(struct nbl_resource_ops *resource_ops);
 bool nbl_res_get_fix_capability(void *priv, enum nbl_fix_cap_type cap_type);
 void nbl_res_set_fix_capability(struct nbl_resource_mgt *res_mgt,
 				enum nbl_fix_cap_type cap_type);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 243869883801..ee4194ab7252 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -10,6 +10,14 @@
 #include "nbl_include.h"
 
 struct nbl_hw_ops {
+	void (*configure_msix_map)(void *priv, u16 func_id, bool valid,
+				   dma_addr_t dma_addr, u8 bus, u8 devid,
+				   u8 function);
+	void (*configure_msix_info)(void *priv, u16 func_id, bool valid,
+				    u16 interrupt_id, u8 bus, u8 devid,
+				    u8 function, bool net_msix_mask_en);
+	void (*set_coalesce)(void *priv, u16 interrupt_id, u16 pnum, u16 rate);
+
 	void (*update_mailbox_queue_tail_ptr)(void *priv, u16 tail_ptr,
 					      u8 txrx);
 	void (*config_mailbox_rxq)(void *priv, dma_addr_t dma_addr,
@@ -27,6 +35,13 @@ struct nbl_hw_ops {
 	u64 (*get_vf_bar_addr)(void *priv, u16 func_id);
 	void (*cfg_mailbox_qinfo)(void *priv, u16 func_id, u16 bus, u16 devid,
 				  u16 function);
+	void (*enable_mailbox_irq)(void *priv, u16 func_id, bool enable_msix,
+				   u16 global_vec_id);
+	void (*enable_abnormal_irq)(void *priv, bool enable_msix,
+				    u16 global_vec_id);
+	void (*enable_msix_irq)(void *priv, u16 global_vec_id);
+	u8 __iomem *(*get_msix_irq_enable_info)(void *priv, u16 global_vec_id,
+						u32 *irq_data);
 	void (*config_adminq_rxq)(void *priv, dma_addr_t dma_addr,
 				  int size_bwid);
 	void (*config_adminq_txq)(void *priv, dma_addr_t dma_addr,
@@ -34,6 +49,8 @@ struct nbl_hw_ops {
 	void (*stop_adminq_rxq)(void *priv);
 	void (*stop_adminq_txq)(void *priv);
 	void (*cfg_adminq_qinfo)(void *priv, u16 bus, u16 devid, u16 function);
+	void (*enable_adminq_irq)(void *priv, bool enable_msix,
+				  u16 global_vec_id);
 	void (*update_adminq_queue_tail_ptr)(void *priv, u16 tail_ptr, u8 txrx);
 	bool (*check_adminq_dma_err)(void *priv, bool tx);
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 8759ba3d478c..134704229116 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -17,6 +17,10 @@
 
 #define NBL_MAX_PF					8
 
+#define NBL_RATE_MBPS_100G				100000
+#define NBL_RATE_MBPS_25G				25000
+#define NBL_RATE_MBPS_10G				10000
+
 #define NBL_NEXT_ID(id, max)				\
 	({						\
 		typeof(id) _id = (id);			\
@@ -25,6 +29,8 @@
 
 #define NBL_MAX_FUNC					(520)
 #define NBL_MAX_MTU_NUM					15
+/* Used for macros to pass checkpatch */
+#define NBL_NAME(x)					x
 
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
-- 
2.47.3


