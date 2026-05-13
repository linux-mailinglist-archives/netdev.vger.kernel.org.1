Return-Path: <netdev+bounces-287359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AkKOIvRA2oF/AEAu9opvQ
	(envelope-from <netdev+bounces-287359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6742752BCBD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 673DC3097796
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D323624AB;
	Wed, 13 May 2026 01:17:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F235DA7F;
	Wed, 13 May 2026 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635037; cv=none; b=W6QGSd2XEQ2cJogXfN7ieZxClOCOysbKloj8N3MGJa7AfdoWCehi7AOhvPZPc+lrh2IZtujnl6mKClVf1M4Hz6BcTxONzGQnx0aTYbRbSD6CR68XrhGSVDkCV90dZ59Xc6mu3DEN+e13okazL6uBiXT+xh+92nU3KWG4Nw52P4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635037; c=relaxed/simple;
	bh=Sto4Ns98LkrLqEpCgk+6GbzqLOACfg7jFs/H8FObWg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvjPSqQoagN3CArZFeQ8tIqKH+C1kdOYOpm838ZFdBuTapSo2xvwDrkpcTtfOEJUeZAAZKwsLyitNpGqNnPwpDvM5ullkojEe29FkOMAYcC6jQR5nqj/1UMfBx0ez/ptWJFueRwNnnlyIZUDiDvOFl5goW+TLU90Se5UFj9O3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.9171291|0.60382;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_social|0.0275373-0.00150986-0.970953;FP=13193117096609337002|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.hVp4DNv_1778635021;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hVp4DNv_1778635021 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 13 May 2026 09:17:02 +0800
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
Subject: [PATCH v14 net-next 07/11] net/nebula-matrix: add intr resource implementation
Date: Wed, 13 May 2026 09:16:40 +0800
Message-ID: <20260513011649.4404-8-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513011649.4404-1-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6742752BCBD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287359-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.975];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:email,nebula-matrix.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,illusion.wang:url]
X-Rspamd-Action: no action

Implement dynamic allocation and management of MSI-X interrupt vectors,
including network interrupts and other interrupt types. Maintain the
MSI-X mapping table (msix_map_table) to establish interrupt associations
between hardware and software. Support enabling/disabling specific
interrupts through hardware operations.

Introduce the following interfaces:
  - configure_msix_map: dynamically allocate MSI-X vectors and build the
    mapping table for network and other interrupts.
  - destroy_msix_map: release MSI-X resources and tear down the mapping
    table.
  - enable_mailbox_irq: enable a specific mailbox interrupt via hardware
    operation.

Note: Mutual exclusion for configure_msix_map, destroy_msix_map, and
enable_mailbox_irq is handled by the dispatch layer; these functions
assume the caller already holds the necessary lock.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  75 ++++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   8 +
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   2 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  | 252 ++++++++++++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |  21 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  30 +++
 .../nbl/nbl_include/nbl_def_hw.h              |   1 +
 .../nbl/nbl_include/nbl_include.h             |   2 +
 9 files changed, 392 insertions(+)
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
index 55d6ed70a9e6..612d6c9812b0 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -64,6 +64,76 @@ static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,
 	spin_unlock(&hw_mgt->reg_lock);
 }
 
+static void nbl_hw_enable_mailbox_irq(struct nbl_hw_mgt *hw_mgt, u16 func_id,
+				      bool enable_msix, u16 global_vec_id)
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
+		/* use af's bdf, because dma memmory is alloc by af */
+		function_msix_map.info.function = function;
+		function_msix_map.info.devid = devid;
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
+		msix_info.info.function = function;
+		msix_info.info.devid = devid;
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
@@ -200,6 +270,10 @@ static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.configure_msix_map = nbl_hw_configure_msix_map,
+	.configure_msix_info = nbl_hw_configure_msix_info,
+	.flush_write = nbl_flush_writes,
+
 	.update_mailbox_queue_tail_ptr = nbl_hw_update_mailbox_queue_tail_ptr,
 	.config_mailbox_rxq = nbl_hw_config_mailbox_rxq,
 	.config_mailbox_txq = nbl_hw_config_mailbox_txq,
@@ -209,6 +283,7 @@ static struct nbl_hw_ops hw_ops = {
 	.get_real_bus = nbl_hw_get_real_bus,
 
 	.cfg_mailbox_qinfo = nbl_hw_cfg_mailbox_qinfo,
+	.enable_mailbox_irq = nbl_hw_enable_mailbox_irq,
 
 	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 7c366a1d5e48..e0cfad759826 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -10,6 +10,9 @@
 static struct nbl_resource_ops res_ops = {
 	.get_vsi_id = nbl_res_func_id_to_vsi_id,
 	.get_eth_id = nbl_res_get_eth_id,
+	.configure_msix_map = nbl_res_intr_configure_msix_map,
+	.destroy_msix_map = nbl_res_intr_destroy_msix_map,
+	.enable_mailbox_irq = nbl_res_intr_enable_mailbox_irq,
 };
 
 static struct nbl_resource_mgt *
@@ -205,7 +208,12 @@ static int nbl_res_start(struct nbl_resource_mgt *res_mgt)
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
index 4e61a5c141e5..5c41983890bd 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -7,4 +7,6 @@
 #define _NBL_RESOURCE_LEONIS_H_
 
 #include "../nbl_resource.h"
+#include "../nbl_interrupt.h"
+#include "../nbl_vsi.h"
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
new file mode 100644
index 000000000000..f1f3a2ac7559
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
@@ -0,0 +1,252 @@
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
+	/* use ctrl dev bdf */
+	hw_ops->configure_msix_map(res_mgt->hw_ops_tbl->priv, func_id, false, 0,
+				   0, 0, 0);
+
+	intr_num = intr_mgt->func_intr_res[func_id].num_interrupts;
+	interrupts = intr_mgt->func_intr_res[func_id].interrupts;
+
+	if (!interrupts) {
+		dev_err(dev, "No interrupts to clr for func_id %u\n", func_id);
+		return -EINVAL;
+	}
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
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
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
+
+	if (num_net_msix > NBL_MSIX_MAP_TABLE_MAX_ENTRIES ||
+	    num_others_msix > NBL_MSIX_MAP_TABLE_MAX_ENTRIES ||
+	    num_net_msix + num_others_msix < num_net_msix) {
+		dev_err(dev, "Invalid MSI-X count: net=%u, others=%u\n",
+			num_net_msix, num_others_msix);
+		return -EINVAL;
+	}
+
+	requested = num_net_msix + num_others_msix;
+	if (requested > NBL_MSIX_MAP_TABLE_MAX_ENTRIES)
+		return -EINVAL;
+
+	/* Clean up old resources (if they exist) */
+	if (intr_mgt->func_intr_res[func_id].interrupts)
+		nbl_res_intr_destroy_msix_map(res_mgt, func_id);
+
+	ret = nbl_res_func_id_to_bdf(res_mgt, func_id, &bus, &devid, &function);
+	if (ret)
+		return ret;
+
+	msix_map_table = &intr_mgt->func_intr_res[func_id].msix_map_table;
+	WARN_ON(msix_map_table->base_addr);
+	msix_map_table->size =
+		sizeof(struct nbl_msix_map) * NBL_MSIX_MAP_TABLE_MAX_ENTRIES;
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
+	hw_ops->flush_write(res_mgt->hw_ops_tbl->priv);
+	dma_free_coherent(dev, msix_map_table->size, msix_map_table->base_addr,
+			  msix_map_table->dma);
+	msix_map_table->size = 0;
+	msix_map_table->base_addr = NULL;
+	msix_map_table->dma = 0;
+
+	return ret;
+}
+
+int nbl_res_intr_enable_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+				    u16 func_id, u16 vector_id,
+				    bool enable_msix)
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
+	hw_ops->enable_mailbox_irq(res_mgt->hw_ops_tbl->priv, func_id,
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
index 000000000000..05ab41e8cf85
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
+int nbl_res_intr_enable_mailbox_irq(struct nbl_resource_mgt *res_mgt,
+				    u16 func_id, u16 vector_id,
+				    bool enable_msix);
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
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 4c0d4909ce8b..bfb7006d9379 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -18,6 +18,7 @@ struct nbl_hw_ops {
 				    bool valid, u16 interrupt_id, u8 bus,
 				    u8 devid, u8 function,
 				    bool net_msix_mask_en);
+	void (*flush_write)(struct nbl_hw_mgt *hw_mgt);
 	void (*update_mailbox_queue_tail_ptr)(struct nbl_hw_mgt *hw_mgt,
 					      u16 tail_ptr, u8 txrx);
 	void (*config_mailbox_rxq)(struct nbl_hw_mgt *hw_mgt,
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


