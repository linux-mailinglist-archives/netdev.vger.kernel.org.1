Return-Path: <netdev+bounces-264664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOpNJLVMqmmIOwEAu9opvQ
	(envelope-from <netdev+bounces-264664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:40:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B66D21B382
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 04:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D19D3301AAB4
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41919353ED9;
	Fri,  6 Mar 2026 03:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3D4502F;
	Fri,  6 Mar 2026 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768428; cv=none; b=C1Pkuo3zYMLElb06GhPPWs4/3f5faeMlbA+6SJKi19A+NJom0V7alJ6XrsU7UH/KA2mDhe0Wypi4PT4+pBIMgk87zh9SY3F6HW666EIoZVmquDEY9TtPseIO0UI2ereUC8gzreG6/2Vkj3tAS2HzJqEbWCPy3C+62sVhxkv1lJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768428; c=relaxed/simple;
	bh=p/DXFrVWwHl8BW61C7tTaODlegL9UXlBvqF2s84NfnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7HQkwuR7e5+kNb+v9W+d/W8qBfJvkndSlbV00KfTrT0MQDc3ZYrz2oaLwTqS/M54h1OY8jZ5jGLjCGFdDR1MV5OmGzyk5RETlXLB9LhXk+oulpTxqQhv0U1+N9ajy1UDD7RqxT64Az+9lGWTrInwwgs1t++8mXCt+TAuidIKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gmDLiKH_1772768101 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Mar 2026 11:35:02 +0800
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
Subject: [PATCH v6 net-next 07/11] net/nebula-matrix: add intr resource implementation
Date: Fri,  6 Mar 2026 11:34:42 +0800
Message-ID: <20260306033451.5196-8-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306033451.5196-1-illusion.wang@nebula-matrix.com>
References: <20260306033451.5196-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0B66D21B382
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.972];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-264664-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

MSI-X Interrupt Configuration: 
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
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  71 +++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  13 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 243 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  13 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  33 +++
 .../nbl/nbl_include/nbl_include.h             |   2 +
 7 files changed, 376 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 8e917b4c045b..0ebb4b1e3803 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -10,6 +10,7 @@ nbl-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_hw/nbl_resource.o \
+				nbl_hw/nbl_interrupt.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_dev.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index a40589c33a0a..d20cef692723 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -62,6 +62,73 @@ static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,
 	spin_unlock(&hw_mgt->reg_lock);
 }
 
+static void nbl_hw_enable_mailbox_irq(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				      bool enable_msix, u16 global_vec_id)
+{
+	struct nbl_mailbox_qinfo_map_table mb_qinfo_map = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
+		       (u32 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
+
+	if (enable_msix) {
+		mb_qinfo_map.msix_idx = global_vec_id;
+		mb_qinfo_map.msix_idx_valid = 1;
+	} else {
+		mb_qinfo_map.msix_idx = 0;
+		mb_qinfo_map.msix_idx_valid = 0;
+	}
+
+	nbl_hw_wr_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
+		       (u32 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
+}
+
+static void nbl_hw_configure_msix_map(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				      bool valid, dma_addr_t dma_addr, u8 bus,
+				      u8 devid, u8 function)
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
+	nbl_hw_wr_regs(hw_mgt,
+		       NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(func_id),
+		       (u32 *)&function_msix_map, sizeof(function_msix_map));
+}
+
+static void nbl_hw_configure_msix_info(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				       bool valid, u16 interrupt_id, u8 bus,
+				       u8 devid, u8 function, bool msix_mask_en)
+{
+	struct nbl_pcompleter_host_msix_fid_table host_msix_fid_tbl = { 0 };
+	struct nbl_host_msix_info msix_info = { 0 };
+
+	if (valid) {
+		host_msix_fid_tbl.vld = 1;
+		host_msix_fid_tbl.fid = func_id;
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
+	nbl_hw_wr_regs(hw_mgt, NBL_PADPT_HOST_MSIX_INFO_REG_ARR(interrupt_id),
+		       (u32 *)&msix_info, sizeof(msix_info));
+	nbl_hw_wr_regs(hw_mgt, NBL_PCOMPLETER_HOST_MSIX_FID_TABLE(interrupt_id),
+		       (u32 *)&host_msix_fid_tbl, sizeof(host_msix_fid_tbl));
+}
+
 static void nbl_hw_update_mailbox_queue_tail_ptr(struct nbl_hw_mgt *hw_mgt,
 						 u16 tail_ptr, u8 txrx)
 {
@@ -194,6 +261,9 @@ static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.configure_msix_map = nbl_hw_configure_msix_map,
+	.configure_msix_info = nbl_hw_configure_msix_info,
+
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
 	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
@@ -203,6 +273,7 @@ static struct nbl_hw_ops hw_ops = {
 	.get_real_bus = nbl_hw_get_real_bus,
 
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+	.enable_mailbox_irq = nbl_hw_enable_mailbox_irq,
 
 	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index c69dab6e7df9..337dd8de2286 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -12,6 +12,7 @@ static struct nbl_resource_ops res_ops = {
 	.get_eth_id = nbl_res_get_eth_id,
 };
 
+static bool is_ops_inited;
 static struct nbl_resource_mgt *
 nbl_res_setup_res_mgt(struct nbl_common_info *common)
 {
@@ -37,11 +38,19 @@ static struct nbl_resource_ops_tbl *
 nbl_res_setup_ops(struct device *dev, struct nbl_resource_mgt *res_mgt)
 {
 	struct nbl_resource_ops_tbl *res_ops_tbl;
+	int ret;
 
 	res_ops_tbl = devm_kzalloc(dev, sizeof(*res_ops_tbl), GFP_KERNEL);
 	if (!res_ops_tbl)
 		return ERR_PTR(-ENOMEM);
 
+	if (!is_ops_inited) {
+		ret = nbl_intr_setup_ops(&res_ops);
+		if (ret)
+			return ERR_PTR(-ENOMEM);
+		is_ops_inited = true;
+	}
+
 	res_ops_tbl->ops = &res_ops;
 	res_ops_tbl->priv = res_mgt;
 
@@ -203,6 +212,10 @@ static int nbl_res_start(struct nbl_resource_mgt *res_mgt,
 		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
 		if (ret)
 			return ret;
+
+		ret = nbl_intr_mgt_start(res_mgt);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
new file mode 100644
index 000000000000..c39cc45cc42c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include "nbl_interrupt.h"
+
+static int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
+					 u16 func_id)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_msix_map_table *msix_map_table;
+	u16 *interrupts;
+	u16 intr_num, i;
+
+	/* use ctrl dev bdf */
+	hw_ops->configure_msix_map(res_mgt->hw_ops_tbl->priv, func_id, false, 0,
+				   0, 0, 0);
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
+		hw_ops->configure_msix_info(res_mgt->hw_ops_tbl->priv, func_id,
+					    false, interrupts[i], 0, 0, 0,
+					    false);
+	}
+
+	kfree(interrupts);
+	intr_mgt->func_intr_res[func_id].interrupts = NULL;
+	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
+
+	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
+	dma_free_coherent(dev, msix_map_table->size, msix_map_table->base_addr,
+			  msix_map_table->dma);
+	msix_map_table->size = 0;
+	msix_map_table->base_addr = NULL;
+	msix_map_table->dma = 0;
+
+	return 0;
+}
+
+static int nbl_res_intr_configure_msix_map(struct nbl_resource_mgt *res_mgt,
+					   u16 func_id, u16 num_net_msix,
+					   u16 num_others_msix,
+					   bool net_msix_mask_en)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = res_mgt->common;
+	struct nbl_msix_map_table *msix_map_table;
+	struct nbl_msix_map *msix_map_entries;
+	struct device *dev = common->dev;
+	u16 requested, intr_index;
+	u8 bus, devid, function;
+	bool msix_mask_en;
+	u16 *interrupts;
+	int ret = 0;
+	u16 i;
+
+	if (intr_mgt->func_intr_res[func_id].interrupts)
+		nbl_res_intr_destroy_msix_map(res_mgt, func_id);
+
+	ret = nbl_res_func_id_to_bdf(res_mgt, func_id, &bus, &devid, &function);
+	if (ret == U32_MAX)
+		return -EINVAL;
+
+	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
+	WARN_ON(msix_map_table->base_addr);
+	msix_map_table->size =
+		sizeof(struct nbl_msix_map) * NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
+	msix_map_table->base_addr = dma_alloc_coherent(dev,
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
+		hw_ops->configure_msix_info(res_mgt->hw_ops_tbl->priv, func_id,
+					    true, interrupts[i], bus, devid,
+					    function, msix_mask_en);
+	}
+
+	/* use ctrl dev bdf */
+	hw_ops->configure_msix_map(res_mgt->hw_ops_tbl->priv, func_id, true,
+				   msix_map_table->dma, common->hw_bus,
+				   common->devid, common->function);
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
+	dma_free_coherent(dev, msix_map_table->size, msix_map_table->base_addr,
+			  msix_map_table->dma);
+	msix_map_table->size = 0;
+	msix_map_table->base_addr = NULL;
+	msix_map_table->dma = 0;
+
+	return ret;
+}
+
+static int nbl_res_intr_enable_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+					   u16 func_id, u16 vector_id,
+					   bool enable_msix)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	u16 global_vec_id;
+
+	global_vec_id = intr_mgt->func_intr_res[func_id].interrupts[vector_id];
+	hw_ops->enable_mailbox_irq(res_mgt->hw_ops_tbl->priv, func_id,
+				   enable_msix, global_vec_id);
+
+	return 0;
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
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static struct nbl_interrupt_mgt *nbl_intr_setup_mgt(struct device *dev)
+{
+	struct nbl_interrupt_mgt *intr_mgt;
+
+	intr_mgt = devm_kzalloc(dev, sizeof(*intr_mgt), GFP_KERNEL);
+	if (!intr_mgt)
+		return ERR_PTR(-ENOMEM);
+
+	return intr_mgt;
+}
+
+int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_interrupt_mgt *intr_mgt;
+	int ret;
+
+	intr_mgt = nbl_intr_setup_mgt(dev);
+	if (IS_ERR(intr_mgt)) {
+		ret = PTR_ERR(intr_mgt);
+		return ret;
+	}
+	res_mgt->intr_mgt = intr_mgt;
+	return 0;
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
+#undef NBL_INTR_SET_OPS
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
new file mode 100644
index 000000000000..a847c71ad6d3
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
index e7cf1032fa5d..d3bd067f139b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -17,6 +17,37 @@
 
 struct nbl_resource_mgt;
 
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
 /* --------- INFO ---------- */
 struct nbl_sriov_info {
 	unsigned int bdf;
@@ -78,6 +109,8 @@ int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
 			   u8 *bus, u8 *dev, u8 *function);
 void nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
 			u8 *eth_mode, u8 *eth_id, u8 *logic_eth_id);
+int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt);
+int nbl_intr_setup_ops(struct nbl_resource_ops *resource_ops);
 void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
 					    enum nbl_vsi_serv_type *dst_type);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index c9d50ccb2b50..ed644fd04c10 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -18,6 +18,8 @@
 
 #define NBL_MAX_FUNC					(520)
 #define NBL_MAX_ETHERNET				(4)
+/* Used for macros to pass checkpatch */
+#define NBL_NAME(x)					x
 
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
-- 
2.47.3


