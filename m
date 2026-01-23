Return-Path: <netdev+bounces-252578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APPMNYbNcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:23:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D406F055
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33EFA3044A6D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2384037649B;
	Fri, 23 Jan 2026 01:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-24.us.a.mail.aliyun.com (out198-24.us.a.mail.aliyun.com [47.90.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601CD2F49EB;
	Fri, 23 Jan 2026 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131158; cv=none; b=ILqvHfchPtYC7iiQJ4q3DNqfWBAvikqrhGxJVBOYVNcRgfmXeNKDQqYo+iX/VOuPnkBYgmlsMPWM4qrLFT/7wOrLSrhfSvSJBXEWq7nCeKLaNTanDrHDmWqXhe9lD8NVkU5soiZtQdEH2Q7v75XHofaF8ykI7okQP12RdVDaAqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131158; c=relaxed/simple;
	bh=r7+5Q8U7BFDbeW/TVOF8zMwuoyql0mwkXETJuhq7Y20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnnXOiNFNNv1n6EYaitK45fmlvt7CcCZ/lL0SC7VErqysCCp3Tk8o4pkGtLEy4UVIWefH9D9o6VQeTf5Pz8OgXaqj5vscABTnGaqY23XVm/nLpd8PPSx3gyLYU4Mk48xQ8+u0Z7aJP8Yz1xeah236HlLy7DesQ4tp47X/RiSOnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYW.A_1769131124 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:45 +0800
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
	hawk@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 net-next 06/15] net/nebula-matrix: add intr resource implementation
Date: Fri, 23 Jan 2026 09:17:43 +0800
Message-ID: <20260123011804.31263-7-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252578-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53D406F055
X-Rspamd-Action: no action

Dynamically allocate and manage MSI-X interrupt vectors, including
network interrupts and other types of interrupts.
Interrupt Mapping Table Management: Maintain the MSI-X mapping table
(msix_map_table) to establish interrupt associations between hardware
and software.
Interrupt Enabling/Disabling:
Support enabling or disabling specific interrupts through hardware
operations.
Interrupt Information Query: Provide interfaces to obtain the
hardware register addresses and data of interrupts.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   4 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  95 +++++-
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  19 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 314 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  13 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   | 271 +++++++++++++++
 .../nbl/nbl_include/nbl_def_resource.h        |   9 +
 .../nbl/nbl_include/nbl_include.h             | 139 +++++++-
 9 files changed, 856 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 8bf3ca9c6862..d27f0bd7f81b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -10,6 +10,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_hw/nbl_resource.o \
+				nbl_hw/nbl_interrupt.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_service.o \
 				nbl_core/nbl_dev.o \
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
index 9db7c9b4a739..6d4b890a4d84 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -34,6 +34,10 @@
 #define NBL_ADAP_TO_SERV_OPS_TBL(adapter) ((adapter)->intf.service_ops_tbl)
 #define NBL_ADAP_TO_DEV_OPS_TBL(adapter) ((adapter)->intf.dev_ops_tbl)
 #define NBL_ADAP_TO_CHAN_OPS_TBL(adapter) ((adapter)->intf.channel_ops_tbl)
+
+#define NBL_ADAPTER_TO_RES_PT_OPS(adapter) \
+	(&(NBL_ADAP_TO_SERV_OPS_TBL(adapter)->pt_ops))
+
 #define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
 
 #define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 63d01f790af8..baad9e6ad4c9 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -19,6 +19,94 @@ static u32 nbl_hw_get_quirks(void *priv)
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
@@ -203,6 +291,9 @@ static u32 nbl_hw_get_fw_eth_map(void *priv)
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.configure_msix_map = nbl_hw_configure_msix_map,
+	.configure_msix_info = nbl_hw_configure_msix_info,
+
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
 	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
@@ -215,7 +306,9 @@ static struct nbl_hw_ops hw_ops = {
 	.get_pf_bar_addr = nbl_hw_get_pf_bar_addr,
 
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
-
+	.enable_mailbox_irq = nbl_hw_enable_mailbox_irq,
+	.enable_msix_irq = nbl_hw_enable_msix_irq,
+	.get_msix_irq_enable_info = nbl_hw_get_msix_irq_enable_info,
 	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
 	.get_board_info = nbl_hw_get_board_info,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 308d675478b6..16e5941aaf76 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -173,6 +173,7 @@ static struct nbl_resource_ops res_ops = {
 static struct nbl_res_product_ops product_ops = {
 };
 
+static bool is_ops_inited;
 static int
 nbl_res_setup_res_mgt(struct nbl_common_info *common,
 		      struct nbl_resource_mgt_leonis **res_mgt_leonis)
@@ -220,15 +221,28 @@ static int nbl_res_setup_ops(struct device *dev,
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
@@ -416,6 +430,7 @@ static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
 {
 	struct nbl_resource_mgt *res_mgt = &res_mgt_leonis->res_mgt;
 
+	nbl_intr_mgt_stop(res_mgt);
 	nbl_res_ctrl_dev_remove_vsi_info(res_mgt);
 	nbl_res_ctrl_dev_remove_eth_info(res_mgt);
 	nbl_res_ctrl_dev_sriov_info_remove(res_mgt);
@@ -454,6 +469,10 @@ static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
 		ret = nbl_res_ring_num_info_init(res_mgt);
 		if (ret)
 			goto start_fail;
+
+		ret = nbl_intr_mgt_start(res_mgt);
+		if (ret)
+			goto start_fail;
 	}
 	return 0;
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
new file mode 100644
index 000000000000..97cabddcc02d
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
@@ -0,0 +1,314 @@
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
+/* NBL_INTR_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_INTR_OPS_TBL						\
+do {									\
+	NBL_INTR_SET_OPS(configure_msix_map,				\
+			 nbl_res_intr_configure_msix_map);		\
+	NBL_INTR_SET_OPS(destroy_msix_map,				\
+			 nbl_res_intr_destroy_msix_map);		\
+	NBL_INTR_SET_OPS(enable_mailbox_irq,				\
+			 nbl_res_intr_enable_mailbox_irq);		\
+	NBL_INTR_SET_OPS(get_msix_irq_enable_info,			\
+			 nbl_res_get_msix_irq_enable_info);		\
+	NBL_INTR_SET_OPS(get_global_vector,				\
+			 nbl_res_intr_get_global_vector);		\
+	NBL_INTR_SET_OPS(get_msix_entry_id,				\
+			 nbl_res_intr_get_msix_entry_id);		\
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
index f6fd151141d5..b8653e0039d7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -10,12 +10,20 @@
 #include "nbl_core.h"
 #include "nbl_hw.h"
 
+struct nbl_resource_mgt;
+
 #define NBL_RES_MGT_TO_COMMON(res_mgt)		((res_mgt)->common)
 #define NBL_RES_MGT_TO_COMMON_OPS(res_mgt)	(&((res_mgt)->common_ops))
 #define NBL_RES_MGT_TO_DEV(res_mgt) \
 	NBL_COMMON_TO_DEV(NBL_RES_MGT_TO_COMMON(res_mgt))
 #define NBL_RES_MGT_TO_DMA_DEV(res_mgt)		\
 	NBL_COMMON_TO_DMA_DEV(NBL_RES_MGT_TO_COMMON(res_mgt))
+#define NBL_RES_MGT_TO_INTR_MGT(res_mgt)	((res_mgt)->intr_mgt)
+#define NBL_RES_MGT_TO_QUEUE_MGT(res_mgt)	((res_mgt)->queue_mgt)
+#define NBL_RES_MGT_TO_TXRX_MGT(res_mgt)	((res_mgt)->txrx_mgt)
+#define NBL_RES_MGT_TO_VSI_MGT(res_mgt)		((res_mgt)->vsi_mgt)
+#define NBL_RES_MGT_TO_INTR_MGT(res_mgt)	((res_mgt)->intr_mgt)
+#define NBL_RES_MGT_TO_PROD_OPS(res_mgt)	((res_mgt)->product_ops)
 #define NBL_RES_MGT_TO_RES_INFO(res_mgt)	((res_mgt)->resource_info)
 #define NBL_RES_MGT_TO_SRIOV_INFO(res_mgt) \
 	(NBL_RES_MGT_TO_RES_INFO(res_mgt)->sriov_info)
@@ -35,13 +43,261 @@
 	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->ops)
 #define NBL_RES_MGT_TO_CHAN_PRIV(res_mgt) \
 	(NBL_RES_MGT_TO_CHAN_OPS_TBL(res_mgt)->priv)
+#define NBL_RES_MGT_TO_TX_RING(res_mgt, index)	\
+	(NBL_RES_MGT_TO_TXRX_MGT(res_mgt)->tx_rings[(index)])
+#define NBL_RES_MGT_TO_RX_RING(res_mgt, index)	\
+	(NBL_RES_MGT_TO_TXRX_MGT(res_mgt)->rx_rings[(index)])
+#define NBL_RES_MGT_TO_VECTOR(res_mgt, index)	\
+	(NBL_RES_MGT_TO_TXRX_MGT(res_mgt)->vectors[(index)])
+
+#define NBL_RES_BASE_QID(res_mgt) NBL_RES_MGT_TO_RES_INFO(res_mgt)->base_qid
+#define NBL_RES_NOFITY_QID(res_mgt, local_qid) \
+	(NBL_RES_BASE_QID(res_mgt) * 2 + (local_qid))
 
 #define NBL_MAX_NET_ID				NBL_MAX_FUNC
 #define NBL_MAX_JUMBO_FRAME_SIZE		(9600)
 #define NBL_PKT_HDR_PAD		(ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2))
+
+/* --------- QUEUE ---------- */
+#define NBL_MAX_TXRX_QUEUE			(2048)
 #define NBL_DEFAULT_DESC_NUM			(1024)
 #define NBL_MAX_TXRX_QUEUE_PER_FUNC		(256)
+
 #define NBL_DEFAULT_PF_HW_QUEUE_NUM		(16)
+#define NBL_VSI_PF_LEGACY_QUEUE_NUM_MAX	(NBL_MAX_TXRX_QUEUE_PER_FUNC)
+
+#define NBL_SPECIFIC_VSI_NET_ID_OFFSET		(4)
+#define NBL_MAX_CACHE_SIZE			(256)
+#define NBL_MAX_BATCH_DESC			(64)
+
+enum nbl_qid_map_table_type {
+	NBL_MASTER_QID_MAP_TABLE,
+	NBL_SLAVE_QID_MAP_TABLE,
+	NBL_QID_MAP_TABLE_MAX
+};
+
+struct nbl_queue_vsi_info {
+	u32 curr_qps;
+	u16 curr_qps_static; /* This will not be reset when netdev down */
+	u16 vsi_index;
+	u16 vsi_id;
+	u16 rss_ret_base;
+	u16 rss_entry_size;
+	u16 net_id;
+	u16 queue_offset;
+	u16 queue_num;
+	bool rss_vld;
+	bool vld;
+};
+
+struct nbl_queue_info {
+	struct nbl_queue_vsi_info vsi_info[NBL_VSI_MAX];
+	u64 notify_addr;
+	u32 qid_map_index;
+	u16 num_txrx_queues;
+	u16 rss_ret_base;
+	u16 *txrx_queues;
+	u16 *queues_context;
+	u32 *uvn_stat_pkt_drop;
+	u16 rss_entry_size;
+	u16 split;
+	u32 curr_qps;
+	u16 queue_size;
+};
+
+struct nbl_queue_mgt {
+	DECLARE_BITMAP(txrx_queue_bitmap, NBL_MAX_TXRX_QUEUE);
+	DECLARE_BITMAP(rss_ret_bitmap, NBL_EPRO_RSS_RET_TBL_DEPTH);
+	struct nbl_qid_map_table qid_map_table[NBL_QID_MAP_TABLE_ENTRIES];
+	struct nbl_queue_info queue_info[NBL_MAX_FUNC];
+	u16 net_id_ref_vsinum[NBL_MAX_NET_ID];
+	u32 total_qid_map_entries;
+	int qid_map_select;
+	bool qid_map_ready;
+	u32 qid_map_tail[NBL_QID_MAP_TABLE_MAX];
+};
+
+/* --------- INTERRUPT ---------- */
+#define NBL_MAX_OTHER_INTERRUPT			1024
+#define NBL_MAX_NET_INTERRUPT			4096
+
+struct nbl_msix_map {
+	u16 valid:1;
+	u16 global_msix_index:13;
+	u16 rsv:2;
+};
+
+struct nbl_msix_map_table {
+	struct nbl_msix_map *base_addr;
+	dma_addr_t dma;
+	size_t size;
+};
+
+struct nbl_func_interrupt_resource_mng {
+	u16 num_interrupts;
+	u16 num_net_interrupts;
+	u16 msix_base;
+	u16 msix_max;
+	u16 *interrupts;
+	struct nbl_msix_map_table msix_map_table;
+};
+
+struct nbl_interrupt_mgt {
+	DECLARE_BITMAP(interrupt_net_bitmap, NBL_MAX_NET_INTERRUPT);
+	DECLARE_BITMAP(interrupt_others_bitmap, NBL_MAX_OTHER_INTERRUPT);
+	struct nbl_func_interrupt_resource_mng func_intr_res[NBL_MAX_FUNC];
+};
+
+/* --------- TXRX ---------- */
+struct nbl_txrx_vsi_info {
+	u16 ring_offset;
+	u16 ring_num;
+};
+
+struct nbl_ring_desc {
+	/* buffer address */
+	__le64 addr;
+	/* buffer length */
+	__le32 len;
+	/* buffer ID */
+	__le16 id;
+	/* the flags depending on descriptor type */
+	__le16 flags;
+};
+
+struct nbl_tx_buffer {
+	struct nbl_ring_desc *next_to_watch;
+	union {
+		struct sk_buff *skb;
+	};
+	dma_addr_t dma;
+	u32 len;
+
+	unsigned int bytecount;
+	unsigned short gso_segs;
+	bool page;
+	u32 tx_flags;
+};
+
+struct nbl_dma_info {
+	dma_addr_t addr;
+	struct page *page;
+	u32 size;
+};
+
+struct nbl_page_cache {
+	u32 head;
+	u32 tail;
+	struct nbl_dma_info page_cache[NBL_MAX_CACHE_SIZE];
+};
+
+struct nbl_rx_buffer {
+	struct nbl_dma_info *di;
+	u16 offset;
+	u16 rx_pad;
+	u16 size;
+	bool last_in_page;
+	bool first_in_page;
+};
+
+struct nbl_res_vector {
+	struct nbl_napi_struct nbl_napi;
+	struct nbl_res_tx_ring *tx_ring;
+	struct nbl_res_rx_ring *rx_ring;
+	u8 __iomem *irq_enable_base;
+	u32 irq_data;
+	bool started;
+	bool net_msix_mask_en;
+};
+
+struct nbl_res_tx_ring {
+	/*data path*/
+	struct nbl_ring_desc *desc;
+	struct nbl_tx_buffer *tx_bufs;
+	struct device *dma_dev;
+	struct net_device *netdev;
+	u8 __iomem *notify_addr;
+	struct nbl_queue_stats stats;
+	struct u64_stats_sync syncp;
+	struct nbl_tx_queue_stats tx_stats;
+	enum nbl_product_type product_type;
+	u16 queue_index;
+	u16 desc_num;
+	u16 notify_qid;
+	u16 avail_used_flags;
+	/* device ring wrap counter */
+	bool used_wrap_counter;
+	u16 next_to_use;
+	u16 next_to_clean;
+	u16 tail_ptr;
+	u16 mode;
+	u16 vlan_tci;
+	u16 vlan_proto;
+	u8 eth_id;
+	u8 extheader_tx_len;
+
+	/* control path */
+	// dma for desc[]
+	dma_addr_t dma;
+	// size for desc[]
+	unsigned int size;
+	bool valid;
+
+	struct nbl_txrx_vsi_info *vsi_info;
+} ____cacheline_internodealigned_in_smp;
+
+struct nbl_res_rx_ring {
+	/* data path */
+	struct nbl_ring_desc *desc;
+	struct nbl_rx_buffer *rx_bufs;
+	struct nbl_dma_info *di;
+	struct device *dma_dev;
+	struct net_device *netdev;
+	struct page_pool *page_pool;
+	struct nbl_queue_stats stats;
+	struct nbl_rx_queue_stats rx_stats;
+	struct u64_stats_sync syncp;
+	struct nbl_page_cache page_cache;
+
+	enum nbl_product_type product_type;
+	u32 buf_len;
+	u16 avail_used_flags;
+	bool used_wrap_counter;
+	u8 nid;
+	u16 next_to_use;
+	u16 next_to_clean;
+	u16 tail_ptr;
+	u16 mode;
+	u16 desc_num;
+	u16 queue_index;
+	u16 vlan_tci;
+	u16 vlan_proto;
+	bool linear_skb;
+
+	/* control path */
+	struct nbl_common_info *common;
+	void *txrx_mgt;
+	// dma for desc[]
+	dma_addr_t dma;
+	// size for desc[]
+	unsigned int size;
+	bool valid;
+	u16 notify_qid;
+
+	u16 frags_num_per_page;
+} ____cacheline_internodealigned_in_smp;
+
+struct nbl_txrx_mgt {
+	struct nbl_res_vector **vectors;
+	struct nbl_res_tx_ring **tx_rings;
+	struct nbl_res_rx_ring **rx_rings;
+	struct nbl_txrx_vsi_info vsi_info[NBL_VSI_MAX];
+	u16 tx_ring_num;
+	u16 rx_ring_num;
+};
+
+struct nbl_vsi_mgt {
+};
 
 /* --------- INFO ---------- */
 struct nbl_sriov_info {
@@ -112,6 +368,18 @@ struct nbl_resource_common_ops {
 };
 
 struct nbl_res_product_ops {
+	/* for queue */
+	void (*queue_mgt_init)(struct nbl_queue_mgt *queue_mgt);
+	int (*setup_qid_map_table)(struct nbl_resource_mgt *res_mgt,
+				   u16 func_id, u64 notify_addr);
+	void (*remove_qid_map_table)(struct nbl_resource_mgt *res_mgt,
+				     u16 func_id);
+	int (*init_qid_map_table)(struct nbl_resource_mgt *res_mgt,
+				  struct nbl_queue_mgt *queue_mgt,
+				  struct nbl_hw_ops *hw_ops);
+
+	/* for intr */
+	void (*nbl_intr_mgt_init)(struct nbl_resource_mgt *res_mgt);
 };
 
 struct nbl_resource_mgt {
@@ -151,6 +419,9 @@ int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
 u64 nbl_res_get_func_bar_base_addr(struct nbl_resource_mgt *res_mgt,
 				   u16 func_id);
 u8 nbl_res_vsi_id_to_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id);
+int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt);
+void nbl_intr_mgt_stop(struct nbl_resource_mgt *res_mgt);
+int nbl_intr_setup_ops(struct nbl_resource_ops *resource_ops);
 void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
 					    enum nbl_vsi_serv_type *dst_type);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
index ef8ccb5707f5..9bc90fe824bd 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -16,10 +16,19 @@ struct nbl_resource_pt_ops {
 };
 
 struct nbl_resource_ops {
+	int (*configure_msix_map)(void *priv, u16 func_id, u16 num_net_msix,
+				  u16 num_others_msix, bool net_msix_mask_en);
+	int (*destroy_msix_map)(void *priv, u16 func_id);
+	int (*enable_mailbox_irq)(void *priv, u16 func_id, u16 vector_id,
+				  bool enable_msix);
+	u16 (*get_global_vector)(void *priv, u16 vsi_id, u16 local_vec_id);
+	u16 (*get_msix_entry_id)(void *priv, u16 vsi_id, u16 local_vec_id);
 	int (*register_net)(void *priv, u16 func_id,
 			    struct nbl_register_net_param *register_param,
 			    struct nbl_register_net_result *register_result);
 	int (*unregister_net)(void *priv, u16 func_id);
+	u8 __iomem *(*get_msix_irq_enable_info)(void *priv, u16 global_vec_id,
+						u32 *irq_data);
 	u16 (*get_vsi_id)(void *priv, u16 func_id, u16 type);
 	void (*get_eth_id)(void *priv, u16 vsi_id, u8 *eth_mode, u8 *eth_id,
 			   u8 *logic_eth_id);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 53fbcf43149b..651100e59f0a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -12,13 +12,26 @@
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl_core"
 
+#define NBL_PAIR_ID_GET_TX(id)				((id) * 2 + 1)
+#define NBL_PAIR_ID_GET_RX(id)				((id) * 2)
+
 #define NBL_MAX_PF					8
+
+#define NBL_RATE_MBPS_100G				100000
+#define NBL_RATE_MBPS_25G				25000
+#define NBL_RATE_MBPS_10G				10000
+
 #define NBL_NEXT_ID(id, max)				\
 	({						\
 		typeof(id) _id = (id);			\
 		((_id) == (max) ? 0 : (_id) + 1);	\
 	})
+
 #define NBL_MAX_FUNC					(520)
+
+/* Used for macros to pass checkpatch */
+#define NBL_NAME(x)					x
+
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
 	NBL_PRODUCT_MAX,
@@ -60,13 +73,111 @@ struct nbl_txrx_queue_param {
 	u16 rxcsum;
 };
 
-struct nbl_vnet_queue_info_param {
-	u32 function_id;
-	u32 device_id;
-	u32 bus_id;
-	u32 msix_idx;
-	u32 msix_idx_valid;
-	u32 valid;
+struct nbl_qid_map_table {
+	u32 local_qid;
+	u32 notify_addr_l;
+	u32 notify_addr_h;
+	u32 global_qid;
+	u32 ctrlq_flag;
+};
+
+struct nbl_qid_map_param {
+	struct nbl_qid_map_table *qid_map;
+	u16 start;
+	u16 len;
+};
+
+struct nbl_queue_cfg_param {
+	/* queue args*/
+	u64 desc;
+	u64 avail;
+	u64 used;
+	u16 size;
+	u16 extend_header;
+	u16 split;
+	u16 last_avail_idx;
+	u16 global_queue_id;
+
+	/*interrupt args*/
+	u16 global_vector;
+	u16 intr_en;
+	u16 intr_mask;
+
+	/* dvn args */
+	u16 tx;
+
+	/* uvn args*/
+	u16 rxcsum;
+	u16 half_offload_en;
+};
+
+struct nbl_queue_stats {
+	u64 packets;
+	u64 bytes;
+	u64 descs;
+};
+
+struct nbl_tx_queue_stats {
+	u64 tso_packets;
+	u64 tso_bytes;
+	u64 tx_csum_packets;
+	u64 tx_busy;
+	u64 tx_dma_busy;
+	u64 tx_multicast_packets;
+	u64 tx_unicast_packets;
+	u64 tx_skb_free;
+	u64 tx_desc_addr_err_cnt;
+	u64 tx_desc_len_err_cnt;
+};
+
+struct nbl_rx_queue_stats {
+	u64 rx_csum_packets;
+	u64 rx_csum_errors;
+	u64 rx_multicast_packets;
+	u64 rx_unicast_packets;
+	u64 rx_desc_addr_err_cnt;
+	u64 rx_alloc_buf_err_cnt;
+	u64 rx_cache_reuse;
+	u64 rx_cache_full;
+	u64 rx_cache_empty;
+	u64 rx_cache_busy;
+	u64 rx_cache_waive;
+};
+
+struct nbl_stats {
+	/* for toe stats */
+	u64 tso_packets;
+	u64 tso_bytes;
+	u64 tx_csum_packets;
+	u64 rx_csum_packets;
+	u64 rx_csum_errors;
+	u64 tx_busy;
+	u64 tx_dma_busy;
+	u64 tx_multicast_packets;
+	u64 tx_unicast_packets;
+	u64 rx_multicast_packets;
+	u64 rx_unicast_packets;
+	u64 tx_skb_free;
+	u64 tx_desc_addr_err_cnt;
+	u64 tx_desc_len_err_cnt;
+	u64 rx_desc_addr_err_cnt;
+	u64 rx_alloc_buf_err_cnt;
+	u64 rx_cache_reuse;
+	u64 rx_cache_full;
+	u64 rx_cache_empty;
+	u64 rx_cache_busy;
+	u64 rx_cache_waive;
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 rx_packets;
+	u64 rx_bytes;
+};
+
+enum nbl_fw_port_speed {
+	NBL_FW_PORT_SPEED_10G,
+	NBL_FW_PORT_SPEED_25G,
+	NBL_FW_PORT_SPEED_50G,
+	NBL_FW_PORT_SPEED_100G,
 };
 
 enum {
@@ -102,9 +213,21 @@ enum {
 };
 
 #define NBL_FEATURE(name)			(1 << (NBL_##name##_BIT))
-#define NBL_FEATURE_TEST_BIT(val, loc)		(((val) >> (loc)) & 0x1)
+
 enum nbl_performance_mode {
 	NBL_QUIRKS_NO_TOE,
 	NBL_QUIRKS_UVN_PREFETCH_ALIGN,
 };
+
+struct nbl_ring_param {
+	u16 tx_ring_num;
+	u16 rx_ring_num;
+	u16 queue_size;
+};
+
+struct nbl_napi_struct {
+	struct napi_struct napi;
+	atomic_t is_irq;
+};
+
 #endif
-- 
2.47.3


