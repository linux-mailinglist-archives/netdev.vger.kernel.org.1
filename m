Return-Path: <netdev+bounces-306702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id noygJwVqUWpEEQMAu9opvQ
	(envelope-from <netdev+bounces-306702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:54:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E710973F320
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:54:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MgFDrPVi;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306702-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306702-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031EC3019809
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ADC3D1CC3;
	Fri, 10 Jul 2026 21:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFBB3B4EB3;
	Fri, 10 Jul 2026 21:53:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720405; cv=none; b=TIp5ax4/YTTwL9zaGpn96uSQi+KvrbUEby9YJHftJJ/qCFlKqDwlczorhdgLqniAiSsEYN0JGch6j0rAcRD7sgUwz5L+MYxdUFCM7R5LWCw1arVuEh048H1bUdqZSClFayOalgTw8xI0QCZNypwoDXOzbiKXgJY19PM9feVIT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720405; c=relaxed/simple;
	bh=AnZblPC1aGP+v87vlmy8bLBoaVQmShmwhhyiOjowMdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkCmlvvBEw2GXT4RLepW6y/qsi5mOHNe/Mpp1jczHm+xt2uHV2pwm3tAXAwQpicthXb6Vh9zeWKMcHFLauhZ/V8+dYIGBZtJtxJsUY93SIs6cmHaA+b9uwJPVsQRQxQRwit+ZzCldR4GarBLhNxptf9whIk7qzwNlrgPLEeFFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MgFDrPVi; arc=none smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783720404; x=1815256404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AnZblPC1aGP+v87vlmy8bLBoaVQmShmwhhyiOjowMdA=;
  b=MgFDrPVimX7IeiVkjM8EYA6xllbbRUrEmjFCGb03j+j1gXIeckR6Zgcd
   Mxx+XEDqKEmpAsEnyAsi8rKqoFVuyTd/2pJeyxe/RKFp1yxJxwHlGmSCH
   AIS9rSkFACh1s3xVY/iB6Mr4hQIxQPKVjeER/R+QjtGlz61qxzZ7yPbLP
   uKERRUIBKZg90T+pAuFhp5VDETfZXdS0As2TLaGODTxvBejZKUAS/+7JP
   98bY3+NViFTu51YiV1rXoHZouYw/C5M2DrlZxsP99GF1vwi72jod7sI+G
   ZJSxHwNPRv+jdxxH8Z6u+vLeojjlqZv8wc5me28E9QS6eDu83l/sIfVH1
   Q==;
X-CSE-ConnectionGUID: zYEZTYLxTyW9ncYn5PzrVw==
X-CSE-MsgGUID: k2hyRiL5RoqiAAQY8glCmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107220713"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107220713"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 14:53:21 -0700
X-CSE-ConnectionGUID: ji8nfptgQvufBnbqag0C6w==
X-CSE-MsgGUID: kgLhvI67RWOF5zrWZdFemQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254494616"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2026 14:53:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Phani R Burra <phani.r.burra@intel.com>,
	anthony.l.nguyen@intel.com,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	Bharath R <bharath.r@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net-next v4 02/15] libie: add PCI device initialization helpers to libie
Date: Fri, 10 Jul 2026 14:52:59 -0700
Message-ID: <20260710215313.1475803-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306702-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:phani.r.burra@intel.com,m:anthony.l.nguyen@intel.com,m:larysa.zaremba@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:anjali.singhai@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:bharath.r@intel.com,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E710973F320

From: Phani R Burra <phani.r.burra@intel.com>

idpf and ixd drivers serve different PCI functions on the same device,
therefore their PCI configuration flow is very similar.

Add support functions for idpf and ixd to configure PCI functionality and
access MMIO space. Add a mapping list which can be traversed by a driver,
e.g. to pass certain I/O mappings to the auxbus devices. Such list is also
traversed by the libie_pci_get_mmio_addr() helper, which allows for easier
memory access.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
Co-developed-by: Victor Raj <victor.raj@intel.com>
Signed-off-by: Victor Raj <victor.raj@intel.com>
Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libie/Kconfig  |   6 +
 drivers/net/ethernet/intel/libie/Makefile |   4 +
 drivers/net/ethernet/intel/libie/pci.c    | 209 ++++++++++++++++++++++
 include/linux/net/intel/libie/pci.h       |  56 ++++++
 4 files changed, 275 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/libie/pci.c
 create mode 100644 include/linux/net/intel/libie/pci.h

diff --git a/drivers/net/ethernet/intel/libie/Kconfig b/drivers/net/ethernet/intel/libie/Kconfig
index 70831c7e336e..500a95c944a8 100644
--- a/drivers/net/ethernet/intel/libie/Kconfig
+++ b/drivers/net/ethernet/intel/libie/Kconfig
@@ -23,3 +23,9 @@ config LIBIE_FWLOG
 	  for it. Firmware logging is using admin queue interface to communicate
 	  with the device. Debugfs is a user interface used to config logging
 	  and dump all collected logs.
+
+config LIBIE_PCI
+	tristate
+	help
+	  Helper functions for management of PCI resources belonging
+	  to networking devices.
diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
index db57fc6780ea..a28509cb9086 100644
--- a/drivers/net/ethernet/intel/libie/Makefile
+++ b/drivers/net/ethernet/intel/libie/Makefile
@@ -12,3 +12,7 @@ libie_adminq-y			:= adminq.o
 obj-$(CONFIG_LIBIE_FWLOG) 	+= libie_fwlog.o
 
 libie_fwlog-y			:= fwlog.o
+
+obj-$(CONFIG_LIBIE_PCI)		+= libie_pci.o
+
+libie_pci-y			:= pci.o
diff --git a/drivers/net/ethernet/intel/libie/pci.c b/drivers/net/ethernet/intel/libie/pci.c
new file mode 100644
index 000000000000..a0d3535d6529
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/pci.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include <linux/net/intel/libie/pci.h>
+
+/**
+ * libie_find_mmio_region - find MMIO region containing a range
+ * @mmio_list: list that contains MMIO region info
+ * @offset: range start offset
+ * @size: range size
+ * @bar_idx: BAR index containing the range to search
+ *
+ * Return: pointer to a MMIO region overlapping with the range in any way or
+ *	   NULL if no such region is mapped.
+ */
+static struct libie_pci_mmio_region *
+libie_find_mmio_region(const struct list_head *mmio_list,
+		       resource_size_t offset, resource_size_t size,
+		       int bar_idx)
+{
+	resource_size_t end_offset = offset + size;
+	struct libie_pci_mmio_region *mr;
+
+	list_for_each_entry(mr, mmio_list, list) {
+		resource_size_t mr_end = mr->offset + mr->size;
+		resource_size_t mr_start = mr->offset;
+
+		if (mr->bar_idx != bar_idx)
+			continue;
+		if (offset < mr_end && end_offset > mr_start)
+			return mr;
+	}
+
+	return NULL;
+}
+
+/**
+ * __libie_pci_get_mmio_addr - get the MMIO virtual address
+ * @mmio_info: contains list of MMIO regions
+ * @offset: register offset to find
+ * @num_args: number of additional arguments present
+ *
+ * This function finds the virtual address of a register offset by iterating
+ * through the non-linear MMIO regions that are mapped by the driver.
+ *
+ * Return: valid MMIO virtual address or NULL.
+ */
+void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
+					resource_size_t offset,
+					int num_args, ...)
+{
+	struct libie_pci_mmio_region *mr;
+	int bar_idx = 0;
+	va_list args;
+
+	if (num_args) {
+		va_start(args, num_args);
+		bar_idx = va_arg(args, int);
+		va_end(args);
+	}
+
+	list_for_each_entry(mr, &mmio_info->mmio_list, list)
+		if (bar_idx == mr->bar_idx && offset >= mr->offset &&
+		    offset < mr->offset + mr->size) {
+			offset -= mr->offset;
+
+			return mr->addr + offset;
+		}
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(__libie_pci_get_mmio_addr, "LIBIE_PCI");
+
+/**
+ * __libie_pci_map_mmio_region - map PCI device MMIO region
+ * @mmio_info: struct to store the mapped MMIO region
+ * @offset: MMIO region start offset
+ * @size: MMIO region size
+ * @num_args: number of additional arguments present
+ *
+ * Return: true on success, false on memory map failure.
+ */
+bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
+				 resource_size_t offset,
+				 resource_size_t size, int num_args, ...)
+{
+	struct pci_dev *pdev = mmio_info->pdev;
+	struct libie_pci_mmio_region *mr;
+	resource_size_t end_offset;
+	void __iomem *va;
+	int bar_idx = 0;
+	va_list args;
+
+	if (num_args) {
+		va_start(args, num_args);
+		bar_idx = va_arg(args, int);
+		va_end(args);
+	}
+
+	/* pci_iomap_range() would silently map less in such case */
+	if (!size || check_add_overflow(offset, size, &end_offset) ||
+	    end_offset > pci_resource_len(pdev, bar_idx))
+		return false;
+
+	mr = libie_find_mmio_region(&mmio_info->mmio_list, offset, size,
+				    bar_idx);
+	if (mr) {
+		pci_warn(pdev,
+			 "Mapping of BAR%u (offset=%llu, size=%llu) intersecting region (offset=%llu, size=%llu) already exists\n",
+			 bar_idx, (unsigned long long)mr->offset,
+			 (unsigned long long)mr->size,
+			 (unsigned long long)offset, (unsigned long long)size);
+		return mr->offset <= offset &&
+		       mr->offset + mr->size >= end_offset;
+	}
+
+	va = pci_iomap_range(mmio_info->pdev, bar_idx, offset, size);
+	if (!va) {
+		pci_err(pdev, "Failed to map BAR%u region\n", bar_idx);
+		return false;
+	}
+
+	mr = kvzalloc_obj(*mr);
+	if (!mr) {
+		pci_iounmap(pdev, va);
+		return false;
+	}
+
+	mr->addr = va;
+	mr->offset = offset;
+	mr->size = size;
+	mr->bar_idx = bar_idx;
+
+	list_add_tail(&mr->list, &mmio_info->mmio_list);
+
+	return true;
+}
+EXPORT_SYMBOL_NS_GPL(__libie_pci_map_mmio_region, "LIBIE_PCI");
+
+/**
+ * libie_pci_unmap_fltr_regs - unmap selected PCI device MMIO regions
+ * @mmio_info: contains list of MMIO regions to unmap
+ * @fltr: returns true, if region is to be unmapped
+ */
+void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
+			       bool (*fltr)(struct libie_mmio_info *mmio_info,
+					    struct libie_pci_mmio_region *reg))
+{
+	struct libie_pci_mmio_region *mr, *tmp;
+
+	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
+		if (!fltr(mmio_info, mr))
+			continue;
+		pci_iounmap(mmio_info->pdev, mr->addr);
+		list_del(&mr->list);
+		kvfree(mr);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_fltr_regs, "LIBIE_PCI");
+
+/**
+ * libie_pci_unmap_all_mmio_regions - unmap all PCI device MMIO regions
+ * @mmio_info: contains list of MMIO regions to unmap
+ */
+void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info)
+{
+	struct libie_pci_mmio_region *mr, *tmp;
+
+	list_for_each_entry_safe(mr, tmp, &mmio_info->mmio_list, list) {
+		pci_iounmap(mmio_info->pdev, mr->addr);
+		list_del(&mr->list);
+		kvfree(mr);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(libie_pci_unmap_all_mmio_regions, "LIBIE_PCI");
+
+/**
+ * libie_pci_init_dev - enable and reserve PCI regions of the device
+ * @pdev: PCI device information
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+int libie_pci_init_dev(struct pci_dev *pdev)
+{
+	int err;
+
+	err = pcim_enable_device(pdev);
+	if (err)
+		return err;
+
+	for (int bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM) {
+			err = pcim_request_region(pdev, bar, pci_name(pdev));
+			if (err)
+				return err;
+		}
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (err)
+		return err;
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(libie_pci_init_dev, "LIBIE_PCI");
+
+MODULE_DESCRIPTION("Common Ethernet PCI library");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/net/intel/libie/pci.h b/include/linux/net/intel/libie/pci.h
new file mode 100644
index 000000000000..effd072c55c8
--- /dev/null
+++ b/include/linux/net/intel/libie/pci.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef __LIBIE_PCI_H
+#define __LIBIE_PCI_H
+
+#include <linux/pci.h>
+
+/**
+ * struct libie_pci_mmio_region - structure for MMIO region info
+ * @list: used to add a MMIO region to the list of MMIO regions in
+ *	  libie_mmio_info
+ * @addr: virtual address of MMIO region start
+ * @offset: start offset of the MMIO region
+ * @size: size of the MMIO region
+ * @bar_idx: BAR index to which the MMIO region belongs to
+ */
+struct libie_pci_mmio_region {
+	struct list_head	list;
+	void __iomem		*addr;
+	resource_size_t		offset;
+	resource_size_t		size;
+	u16			bar_idx;
+};
+
+/**
+ * struct libie_mmio_info - contains list of MMIO regions
+ * @pdev: PCI device pointer
+ * @mmio_list: list of MMIO regions
+ */
+struct libie_mmio_info {
+	struct pci_dev		*pdev;
+	struct list_head	mmio_list;
+};
+
+#define libie_pci_map_mmio_region(mmio_info, offset, size, ...)	\
+	__libie_pci_map_mmio_region(mmio_info, offset, size,		\
+				     COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
+
+#define libie_pci_get_mmio_addr(mmio_info, offset, ...)		\
+	__libie_pci_get_mmio_addr(mmio_info, offset,			\
+				   COUNT_ARGS(__VA_ARGS__), ##__VA_ARGS__)
+
+bool __libie_pci_map_mmio_region(struct libie_mmio_info *mmio_info,
+				 resource_size_t offset, resource_size_t size,
+				 int num_args, ...);
+void __iomem *__libie_pci_get_mmio_addr(struct libie_mmio_info *mmio_info,
+					resource_size_t offset,
+					int num_args, ...);
+void libie_pci_unmap_all_mmio_regions(struct libie_mmio_info *mmio_info);
+void libie_pci_unmap_fltr_regs(struct libie_mmio_info *mmio_info,
+			       bool (*fltr)(struct libie_mmio_info *mmio_info,
+					    struct libie_pci_mmio_region *reg));
+int libie_pci_init_dev(struct pci_dev *pdev);
+
+#endif /* __LIBIE_PCI_H */
-- 
2.47.1


