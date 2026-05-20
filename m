Return-Path: <netdev+bounces-289748-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIEfK/MqDWo2uAUAu9opvQ
	(envelope-from <netdev+bounces-289748-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:30:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2F25873FB
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 05:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CB473082F63
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2193624C9;
	Wed, 20 May 2026 03:30:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-14.us.a.mail.aliyun.com (out198-14.us.a.mail.aliyun.com [47.90.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193F3603E8;
	Wed, 20 May 2026 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247821; cv=none; b=pENK0jvw39OdJJKH0AF2sPosdHhWpwejXzoT0hJV/wqCA1zrsQf0wN9GLBSszHVRDQ4jxgkyDx+psbGvPcK8TAvbu1oxMiUGCnYyMtKi6Z6DeDqpWZMCy9ZnR0cOAef4jkKOZminimH7Gv16JWCV/0nIi5Liuq0Gh8/XDMats+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247821; c=relaxed/simple;
	bh=L3ErfeRGD4SCFMXIfLoCSr9pqh6QPeW3W7hYeKreiek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=coxbPpHMKjhOeijHLPI4ikeufNy/eV44egWl3UFGWhsY58QhYbc6zg4Lu/dojgEWN6Ez6lgzHlmW/c8yI5FE6Gtl3ODDt2gzYyqQM4hJ6xdIEVHpjwTLkztWcd4v8AKwHrr1e3bpdSnGARQIk3MYNILqM9Dardmi9J3qRVqikRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9171291|0.2071213;CH=green;DM=|AD|false|;DS=CONTINUE|ham_alarm|0.0174842-0.00331017-0.979206;FP=12040230913814613738|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.hbYx45u_1779247802;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hbYx45u_1779247802 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 May 2026 11:30:03 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v15 net-next 07/11] net/nebula-matrix: add intr resource implementation
Date: Wed, 20 May 2026 11:29:39 +0800
Message-ID: <20260520032950.4874-8-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520032950.4874-1-illusion.wang@nebula-matrix.com>
References: <20260520032950.4874-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289748-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url]
X-Rspamd-Queue-Id: 2A2F25873FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch adds the nbl_interrupt module for management of driver-private
MSI-X indices, plus hw_ops callbacks to program the function MSI-X mapping
registers, configure MSI-X info, and enable mailbox interrupts.

Key interfaces:
- configure_msix_map:   Allocates driver-private global MSI-X indices
                          (interrupt_net_bitmap / interrupt_others_bitmap)
                          and programs the hardware MSI-X mapping registers
                          (NBL_PCOMPLETER_FUNCTION_MSIX_MAP).
                          The actual PCI MSI-X vector allocation is done
                          by nbl_dev_alloc_msix_intr().
- destroy_msix_map:     Releases MSI-X indices and tears down the mapping.
- set_mailbox_irq:       Enables/disables a specific mailbox interrupt.
- configure_msix_info:   Programs PADPT_HOST_MSIX_INFO and
                          PCOMPLETER_HOST_MSIX_FID_TABLE.

The patch does not use kernel MSI-X allocation primitives
(pci_alloc_irq_vectors, pci_msix_alloc_irq_at, irq_domain). It manages
a driver-private global index space and programs vendor-specific
MSI-X mapping registers.

Note: Mutual exclusion for configure_msix_map, destroy_msix_map, and
enable_mailbox_irq is handled by the dispatch layer; these functions
assume the caller already holds the necessary lock.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  76 +++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   8 +
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 267 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  21 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  30 ++
 .../nbl/nbl_include/nbl_include.h             |   2 +
 8 files changed, 406 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index b03c20f9988e..a56e722a5ac7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -9,6 +9,7 @@ nbl-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_hw/nbl_resource.o \
+				nbl_hw/nbl_interrupt.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_dev.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 99f425568040..599e408075e7 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -64,6 +64,78 @@ static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,
 	spin_unlock(&hw_mgt->reg_lock);
 }
 
+static void nbl_hw_set_mailbox_irq(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				   bool enable_msix, u16 global_vec_id)
+{
+	union nbl_mailbox_qinfo_map_table_u mb_qinfo_map = { 0 };
+
+	nbl_hw_rd_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
+		       &mb_qinfo_map.data, sizeof(mb_qinfo_map));
+
+	if (enable_msix) {
+		mb_qinfo_map.info.msix_idx = global_vec_id;
+		mb_qinfo_map.info.msix_idx_valid = 1;
+	} else {
+		mb_qinfo_map.info.msix_idx = 0;
+		mb_qinfo_map.info.msix_idx_valid = 0;
+	}
+
+	nbl_hw_wr_regs(hw_mgt, NBL_MAILBOX_QINFO_MAP_REG_ARR(func_id),
+		       &mb_qinfo_map.data, sizeof(mb_qinfo_map));
+}
+
+static void nbl_hw_configure_msix_map(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				      bool valid, dma_addr_t dma_addr, u8 bus,
+				      u8 devid, u8 function)
+{
+	union nbl_function_msix_map_u function_msix_map;
+
+	memset(&function_msix_map, 0, sizeof(function_msix_map));
+	if (valid) {
+		function_msix_map.info.msix_map_base_addr = dma_addr;
+		/* use ctrl dev's bdf, because the dma memory was
+		 * allocated by it
+		 */
+		function_msix_map.info.function = function & 0x7;
+		function_msix_map.info.devid = devid & 0x1F;
+		function_msix_map.info.bus = bus;
+		function_msix_map.info.valid = 1;
+	}
+
+	nbl_hw_wr_regs(hw_mgt,
+		       NBL_PCOMPLETER_FUNCTION_MSIX_MAP_REG_ARR(func_id),
+		       function_msix_map.data, sizeof(function_msix_map));
+}
+
+static void nbl_hw_configure_msix_info(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				       bool valid, u16 interrupt_id, u8 bus,
+				       u8 devid, u8 function, bool msix_mask_en)
+{
+	union nbl_pcompleter_host_msix_fid_table_u host_msix_fid;
+	union nbl_host_msix_info_u msix_info;
+
+	memset(&host_msix_fid, 0, sizeof(host_msix_fid));
+	memset(&msix_info, 0, sizeof(msix_info));
+	if (valid) {
+		host_msix_fid.info.vld = 1;
+		host_msix_fid.info.fid = func_id;
+
+		msix_info.info.intrl_pnum = 0;
+		msix_info.info.intrl_rate = 0;
+		msix_info.info.function = function & 0x7;
+		msix_info.info.devid = devid & 0x1F;
+		msix_info.info.bus = bus;
+		msix_info.info.valid = 1;
+		if (msix_mask_en)
+			msix_info.info.msix_mask_en = 1;
+	}
+
+	nbl_hw_wr_regs(hw_mgt, NBL_PADPT_HOST_MSIX_INFO_REG_ARR(interrupt_id),
+		       msix_info.data, sizeof(msix_info));
+	nbl_hw_wr_regs(hw_mgt, NBL_PCOMPLETER_HOST_MSIX_FID_TABLE(interrupt_id),
+		       &host_msix_fid.data, sizeof(host_msix_fid));
+}
+
 static void nbl_hw_update_mailbox_queue_tail_ptr(struct nbl_hw_mgt *hw_mgt,
 						 u16 tail_ptr, u8 txrx)
 {
@@ -202,6 +274,9 @@ static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.configure_msix_map = nbl_hw_configure_msix_map,
+	.configure_msix_info = nbl_hw_configure_msix_info,
+
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
 	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
@@ -211,6 +286,7 @@ static struct nbl_hw_ops hw_ops = {
 	.get_real_bus = nbl_hw_get_real_bus,
 
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+	.set_mailbox_irq = nbl_hw_set_mailbox_irq,
 
 	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 36366cd47753..fa3e120dc506 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -10,6 +10,9 @@
 static struct nbl_resource_ops res_ops = {
 	.get_vsi_id = nbl_res_func_id_to_vsi_id,
 	.get_eth_id = nbl_res_get_eth_id,
+	.configure_msix_map = nbl_res_intr_configure_msix_map,
+	.destroy_msix_map = nbl_res_intr_destroy_msix_map,
+	.set_mailbox_irq = nbl_res_intr_set_mailbox_irq,
 };
 
 static struct nbl_resource_mgt *
@@ -227,7 +230,12 @@ static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
 		ret = nbl_res_ctrl_dev_vsi_info_init(res_mgt);
 		if (ret)
 			return ret;
+
+		ret = nbl_intr_mgt_start(res_mgt);
+		if (ret)
+			return ret;
 	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
index 4e61a5c141e5..1da2abcaf00f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -7,4 +7,5 @@
 #define _NBL_RESOURCE_LEONIS_H_
 
 #include "../nbl_resource.h"
+#include "../nbl_interrupt.h"
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
new file mode 100644
index 000000000000..c9d030e55fa1
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include "nbl_interrupt.h"
+
+int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
+				  u16 func_id)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct device *dev = res_mgt->common->dev;
+	struct nbl_msix_map_table *msix_map_table;
+	u16 *interrupts;
+	u16 intr_num, i;
+
+	if (func_id >= NBL_MAX_FUNC) {
+		dev_err(dev, "Invalid func_id %u\n", func_id);
+		return -EINVAL;
+	}
+
+	intr_num = intr_mgt->func_intr_res[func_id].num_interrupts;
+	interrupts = intr_mgt->func_intr_res[func_id].interrupts;
+	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
+
+	if (!interrupts || !msix_map_table->base_addr) {
+		dev_err(dev, "No interrupts to clr for func_id %u\n", func_id);
+		return -EINVAL;
+	}
+
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
+	/* Ensure completion of DMA memory write operation */
+	dma_wmb();
+	/* use ctrl dev bdf */
+	hw_ops->configure_msix_map(res_mgt->hw_ops_tbl->priv, func_id, false, 0,
+				   0, 0, 0);
+	kfree(interrupts);
+	intr_mgt->func_intr_res[func_id].interrupts = NULL;
+	intr_mgt->func_intr_res[func_id].num_interrupts = 0;
+
+	dma_free_coherent(dev, msix_map_table->size, msix_map_table->base_addr,
+			  msix_map_table->dma);
+	msix_map_table->size = 0;
+	msix_map_table->base_addr = NULL;
+	msix_map_table->dma = 0;
+
+	return 0;
+}
+
+int nbl_res_intr_configure_msix_map(struct nbl_resource_mgt *res_mgt,
+				    u16 func_id, u16 num_net_msix,
+				    u16 num_others_msix,
+				    bool net_msix_mask_en)
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
+	if (func_id >= NBL_MAX_FUNC) {
+		dev_err(dev, "Invalid func_id %u\n", func_id);
+		return -EINVAL;
+	}
+	if (num_net_msix == 0 && num_others_msix == 0) {
+		dev_err(dev, "MSI-X count cannot be zero\n");
+		return -EINVAL;
+	}
+	if (num_net_msix > NBL_MSIX_MAP_TABLE_MAX_ENTRIES ||
+	    num_others_msix > NBL_MSIX_MAP_TABLE_MAX_ENTRIES) {
+		dev_err(dev, "Invalid MSI-X count: net=%u, others=%u\n",
+			num_net_msix, num_others_msix);
+		return -EINVAL;
+	}
+
+	if (check_add_overflow(num_net_msix, num_others_msix, &requested) ||
+	    requested > NBL_MSIX_MAP_TABLE_MAX_ENTRIES) {
+		dev_err(dev, "MSI-X total %u exceeds max %u\n",
+			requested, NBL_MSIX_MAP_TABLE_MAX_ENTRIES);
+		return -EINVAL;
+	}
+
+	ret = nbl_res_func_id_to_bdf(res_mgt, func_id, &bus, &devid, &function);
+	if (ret)
+		return ret;
+
+	/* Clean up old resources (if they exist) */
+	if (intr_mgt->func_intr_res[func_id].interrupts) {
+		ret = nbl_res_intr_destroy_msix_map(res_mgt, func_id);
+		if (ret) {
+			dev_err(dev, "Failed to destroy old MSIX map: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
+	WARN_ON(msix_map_table->base_addr);
+	msix_map_table->size =
+		sizeof(struct nbl_msix_map) * NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
+	/* HW indexes the MSI-X map table with a fixed stride of 1024 entries,
+	 * so we must allocate the full table even if fewer vectors are used.
+	 */
+	msix_map_table->base_addr = dma_alloc_coherent(dev,
+						       msix_map_table->size,
+						       &msix_map_table->dma,
+						       GFP_KERNEL);
+	if (!msix_map_table->base_addr) {
+		dev_err(dev, "Allocate DMA memory for function msix map table failed\n");
+		msix_map_table->size = 0;
+		return -ENOMEM;
+	}
+
+	interrupts = kcalloc(requested, sizeof(interrupts[0]), GFP_KERNEL);
+	if (!interrupts) {
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
+			dev_err(dev, "There is no available interrupt left\n");
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
+			dev_err(dev, "There is no available interrupt left\n");
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
+	/* Ensure completion of DMA memory write operation */
+	dma_wmb();
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
+int nbl_res_intr_set_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+				 u16 func_id, u16 vector_id,
+				 bool enable_msix)
+{
+	struct nbl_interrupt_mgt *intr_mgt = res_mgt->intr_mgt;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_common_info *common = res_mgt->common;
+	struct device *dev = common->dev;
+	u16 global_vec_id;
+
+	if (func_id >= NBL_MAX_FUNC ||
+	    !intr_mgt->func_intr_res[func_id].interrupts ||
+	    vector_id >= intr_mgt->func_intr_res[func_id].num_interrupts) {
+		dev_err(dev, "Invalid func_id %u or vector_id %u\n",
+			func_id, vector_id);
+		return -EINVAL;
+	}
+
+	global_vec_id = intr_mgt->func_intr_res[func_id].interrupts[vector_id];
+	hw_ops->set_mailbox_irq(res_mgt->hw_ops_tbl->priv, func_id,
+				   enable_msix, global_vec_id);
+
+	return 0;
+}
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
new file mode 100644
index 000000000000..5aa46a4fce4c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_INTERRUPT_H_
+#define _NBL_INTERRUPT_H_
+
+#include "nbl_resource.h"
+
+#define NBL_MSIX_MAP_TABLE_MAX_ENTRIES	1024
+int nbl_res_intr_destroy_msix_map(struct nbl_resource_mgt *res_mgt,
+				  u16 func_id);
+int nbl_res_intr_configure_msix_map(struct nbl_resource_mgt *res_mgt,
+				    u16 func_id, u16 num_net_msix,
+				    u16 num_others_msix,
+				    bool net_msix_mask_en);
+int nbl_res_intr_set_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+				 u16 func_id, u16 vector_id,
+				 bool enable_msix);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index 15dc7f78afc0..b1f5724e727a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -18,6 +18,35 @@
 
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
@@ -75,6 +104,7 @@ int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
 			   u8 *bus, u8 *dev, u8 *function);
 int nbl_res_get_eth_id(struct nbl_resource_mgt *res_mgt, u16 vsi_id,
 		       u8 *eth_num, u8 *eth_id, u8 *logic_eth_id);
+int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt);
 void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
 					    enum nbl_vsi_serv_type *dst_type);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 6a0bf5e8ca32..e4f11e6ded94 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -19,6 +19,8 @@
 
 #define NBL_MAX_FUNC					520
 #define NBL_MAX_ETHERNET				4
+/* Used for macros to pass checkpatch */
+#define NBL_NAME(x)					x
 
 enum nbl_product_type {
 	NBL_LEONIS_TYPE,
-- 
2.47.3


