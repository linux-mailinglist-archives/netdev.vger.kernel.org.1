Return-Path: <netdev+bounces-296608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TvCeNKbYJmrclgIAu9opvQ
	(envelope-from <netdev+bounces-296608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:58:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A4D657B5D
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:58:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dIo7gKsF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296608-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296608-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B49BA306C59D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E1B3E0C70;
	Mon,  8 Jun 2026 14:41:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5BE3DEFF1;
	Mon,  8 Jun 2026 14:41:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929702; cv=none; b=GF6arczy7PPyUBjjm5B5tWgq1vQy4h/nXOEKW1ZymtWVw+HXrna5n14KT/1jp4EH1S5Dy4p6q6ZnnIx6CBU7joR4mDpxpq5BPNqU1tpeg3V2VbA+0aWXUlDrCmKDlSv0/gVqrtTsBdocsldh2wZtZQqO1LDiNnu6WGIUlQBk6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929702; c=relaxed/simple;
	bh=95ja2jdDtJljIktlebtm6gj4rPEiD4QIvRoJp31H2Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EP1bD25ROsUOVsE/nmyZiiuaydyk6RXQqmjjxVnwn9ZGJW/wte+HEWkr+dU6iO6h9vSTnuICxdKSUEZDOjMpBW9is6C1KsItUiPXpXB/JAG081y6vO35jggALID3b46Y4qoayWFJ+b8FedO5hOYeGS9A5BQr+LkFgRC0KtJxs44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIo7gKsF; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780929700; x=1812465700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=95ja2jdDtJljIktlebtm6gj4rPEiD4QIvRoJp31H2Os=;
  b=dIo7gKsFuXZARY0fsHOA1BqUpwnHQ0n+xUQnLoHl1yvquzL4B9gLXyT1
   0j6gd9EfncVxrxFBJa247h7J7XH0WRtHnwIU1JBWSXBsdZ6NlvguxsFPC
   c48uJxygIyC1C2om/pJcdW4FlHeQKzXfe27SdwHwziLvgu5OB6Gu92ugx
   JYvNCW7TlVMhVC47AcY0ftlsp9uW/ti1GbvkYv6TJEY5iwGLqKXPGzhe5
   MRw+76xmSdGcoDHhs6c/g5uI0lbDoVenOLXreZWiMgJaby8f6HZ3vyWg0
   ChFysD2YvKpXvbgpVFXL8Jx3TRoMZrqODoDlx7cQkSc2w9uac4KTG5ESp
   w==;
X-CSE-ConnectionGUID: HxFyh1KOTxS1TMsnoJuiaA==
X-CSE-MsgGUID: 5z/cQP5fSmqw84d1dL/coQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81641963"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81641963"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 07:41:40 -0700
X-CSE-ConnectionGUID: FHslap1mSeWDHEjv1eZf7A==
X-CSE-MsgGUID: KYrGcPiRRsWdQGfB+pMalA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="249489712"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 08 Jun 2026 07:41:34 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8E4B128794;
	Mon,  8 Jun 2026 15:41:31 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	jayaprakash.shanmugam@intel.com,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Phani R Burra <phani.r.burra@intel.com>,
	Bharath R <bharath.r@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH iwl-next v8 02/15] libie: add PCI device initialization helpers to libie
Date: Mon,  8 Jun 2026 16:41:07 +0200
Message-ID: <20260608144127.2751230-3-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260608144127.2751230-1-larysa.zaremba@intel.com>
References: <20260608144127.2751230-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296608-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:larysa.zaremba@intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:phani.r.burra@intel.com,m:bharath.r@intel.com,m:Samuel.salin@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75A4D657B5D

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
---
 drivers/net/ethernet/intel/libie/Kconfig  |   6 +
 drivers/net/ethernet/intel/libie/Makefile |   4 +
 drivers/net/ethernet/intel/libie/pci.c    | 207 ++++++++++++++++++++++
 include/linux/net/intel/libie/pci.h       |  56 ++++++
 4 files changed, 273 insertions(+)
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
index 000000000000..9dd5859d2834
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/pci.c
@@ -0,0 +1,207 @@
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
+	if (size_add(offset, size) > pci_resource_len(pdev, bar_idx))
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
+		       mr->offset + mr->size >= offset + size;
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
+		iounmap(va);
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
+		iounmap(mr->addr);
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
+		iounmap(mr->addr);
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
2.47.0


