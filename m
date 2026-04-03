Return-Path: <netdev+bounces-275193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ2NL44a0Gl33QYAu9opvQ
	(envelope-from <netdev+bounces-275193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:52:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F6B397E98
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 21:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 116E5303AE1A
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1EB3D6694;
	Fri,  3 Apr 2026 19:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FChFEwGi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA953D75DB;
	Fri,  3 Apr 2026 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245802; cv=none; b=tX2Xg2gOiGtDHpj39LhQQoi9fyyAlR1seZzPqr86Wzd/NVm5tD3elfUMFyDrhIqAMFT1RdT1H6eH6uxysemFKlayXl6YN1/BpRvlh/706xaSweNHawQOacw0WiXM4D1cGbXq4LCX403yefWXJHO7w5EbVtIYFyCX+7VTIZajxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245802; c=relaxed/simple;
	bh=3VP3/iRmgYEbcnf4CIEJcg3vvJ3v0OPjbqYKCuVGZCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUYmm80ZlOb44GNCQnVNhvKqeqFMYax+OOrfMRLGE6Loc8Cl8fDMyBsnpmf6s+t7ra4Si9N/qTWGIPkLzEVLkMLCFuWX6B/yu4VOtax7XWhA27RKI5e7weUkI1DeNlTtNv3wmnKWaewNkCTAM2dG+1vVyJCZJQQo38BzuBliHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FChFEwGi; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775245797; x=1806781797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3VP3/iRmgYEbcnf4CIEJcg3vvJ3v0OPjbqYKCuVGZCs=;
  b=FChFEwGi5Knx5CnU738yDQzZR8YEhZtjQ8tDe3ZA2Wb9sWQIEIpCfU5y
   Tp2gU5ZvVZau0eXrxMM/6MLLQUBj/msZ1Z8s0k7V7da2KSbI/mZvr6edU
   HhASu9HsbanCYsEoX8ZldiXpF4ruxzjcDelcmHy+xMfV5sUgAijA8Vzqk
   zsvQHo7kNDtRjRpX6xcSIeXEJS8nlZ7h3OxkOJd88sW9N3PwdvGO+/X5y
   MWHR3zzJUtSFOghPFcWq44CirxVTOO9nOlaFj8hinwtujwsgvp2zmWepd
   3KW4hJF0s4gVGZpvH4jLglM41Wx6gzPRygRJSRkB7zvcDh1uT2K5Oiiyp
   w==;
X-CSE-ConnectionGUID: 6wPcLscWRNaDg8o8iKNXYQ==
X-CSE-MsgGUID: lnjBcarTQvyRkcTVBRuV5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76428834"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76428834"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 12:49:47 -0700
X-CSE-ConnectionGUID: yQQ67JmdRbiEyl/9PizWYA==
X-CSE-MsgGUID: Ls1E2BOETUiCh8MCg94NZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="265266144"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2026 12:49:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	anthony.l.nguyen@intel.com,
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
	Bharath R <Bharath.r@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v2 11/14] ixd: add basic driver framework for Intel(R) Control Plane Function
Date: Fri,  3 Apr 2026 12:49:33 -0700
Message-ID: <20260403194938.3577011-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
References: <20260403194938.3577011-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275193-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,intel.com:email,intel.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,osuosl.org:email]
X-Rspamd-Queue-Id: 96F6B397E98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Larysa Zaremba <larysa.zaremba@intel.com>

Add module register and probe functionality. Add the required support to
register IXD PCI driver, as well as probe and remove call backs. Enable the
PCI device and request the kernel to reserve the memory resources that will
be used by the driver. Finally map the BAR0 address space.

For now, use devm_alloc() to allocate adapter, as it requires the least
amount of code. In a later commit, it will be replaced with a devlink
alternative.

Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Bharath R <Bharath.r@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/intel/ixd.rst     |  39 ++++++
 drivers/net/ethernet/intel/Kconfig            |   2 +
 drivers/net/ethernet/intel/Makefile           |   1 +
 drivers/net/ethernet/intel/ixd/Kconfig        |  13 ++
 drivers/net/ethernet/intel/ixd/Makefile       |   8 ++
 drivers/net/ethernet/intel/ixd/ixd.h          |  28 +++++
 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  28 +++++
 drivers/net/ethernet/intel/ixd/ixd_main.c     | 112 ++++++++++++++++++
 9 files changed, 232 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/ixd.rst
 create mode 100644 drivers/net/ethernet/intel/ixd/Kconfig
 create mode 100644 drivers/net/ethernet/intel/ixd/Makefile
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 5f3f06111911..5b6846f387f8 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -38,6 +38,7 @@ Contents:
    intel/igbvf
    intel/ixgbe
    intel/ixgbevf
+   intel/ixd
    intel/i40e
    intel/iavf
    intel/ice
diff --git a/Documentation/networking/device_drivers/ethernet/intel/ixd.rst b/Documentation/networking/device_drivers/ethernet/intel/ixd.rst
new file mode 100644
index 000000000000..1387626e5d20
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/intel/ixd.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+==========================================================================
+iXD Linux* Base Driver for the Intel(R) Control Plane Function
+==========================================================================
+
+Intel iXD Linux driver.
+Copyright(C) 2025 Intel Corporation.
+
+.. contents::
+
+For questions related to hardware requirements, refer to the documentation
+supplied with your Intel adapter. All hardware requirements listed apply to use
+with Linux.
+
+
+Identifying Your Adapter
+========================
+For information on how to identify your adapter, and for the latest Intel
+network drivers, refer to the Intel Support website:
+http://www.intel.com/support
+
+
+Support
+=======
+For general information, go to the Intel support website at:
+http://www.intel.com/support/
+
+If an issue is identified with the released source code on a supported kernel
+with a supported adapter, email the specific information related to the issue
+to intel-wired-lan@lists.osuosl.org.
+
+
+Trademarks
+==========
+Intel is a trademark or registered trademark of Intel Corporation or its
+subsidiaries in the United States and/or other countries.
+
+* Other names and brands may be claimed as the property of others.
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 288fa8ce53af..780f113986ea 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -398,4 +398,6 @@ config IGC_LEDS
 
 source "drivers/net/ethernet/intel/idpf/Kconfig"
 
+source "drivers/net/ethernet/intel/ixd/Kconfig"
+
 endif # NET_VENDOR_INTEL
diff --git a/drivers/net/ethernet/intel/Makefile b/drivers/net/ethernet/intel/Makefile
index 9a37dc76aef0..08b29f3b6801 100644
--- a/drivers/net/ethernet/intel/Makefile
+++ b/drivers/net/ethernet/intel/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_IAVF) += iavf/
 obj-$(CONFIG_FM10K) += fm10k/
 obj-$(CONFIG_ICE) += ice/
 obj-$(CONFIG_IDPF) += idpf/
+obj-$(CONFIG_IXD) += ixd/
diff --git a/drivers/net/ethernet/intel/ixd/Kconfig b/drivers/net/ethernet/intel/ixd/Kconfig
new file mode 100644
index 000000000000..f5594efe292c
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2025 Intel Corporation
+
+config IXD
+	tristate "Intel(R) Control Plane Function Support"
+	depends on PCI_MSI
+	select LIBETH
+	select LIBIE_PCI
+	help
+	  This driver supports Intel(R) Control Plane PCI Function
+	  of Intel E2100 and later IPUs and FNICs.
+	  It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
+	  exposed by the same card.
diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
new file mode 100644
index 000000000000..3849bc240600
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2025 Intel Corporation
+
+# Intel(R) Control Plane Function Linux Driver
+
+obj-$(CONFIG_IXD) += ixd.o
+
+ixd-y := ixd_main.o
diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
new file mode 100644
index 000000000000..d813c27941a5
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_H_
+#define _IXD_H_
+
+#include <linux/intel/libie/pci.h>
+
+/**
+ * struct ixd_adapter - Data structure representing a CPF
+ * @hw: Device access data
+ */
+struct ixd_adapter {
+	struct libie_mmio_info hw;
+};
+
+/**
+ * ixd_to_dev - Get the corresponding device struct from an adapter
+ * @adapter: PCI device driver-specific private data
+ *
+ * Return: struct device corresponding to the given adapter
+ */
+static inline struct device *ixd_to_dev(struct ixd_adapter *adapter)
+{
+	return &adapter->hw.pdev->dev;
+}
+
+#endif /* _IXD_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
new file mode 100644
index 000000000000..fbb88929d0de
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_LAN_REGS_H_
+#define _IXD_LAN_REGS_H_
+
+/* Control Plane Function PCI ID */
+#define IXD_DEV_ID_CPF			0x1efe
+
+/* Control Queue (Mailbox) */
+#define PF_FW_MBX_REG_LEN		4096
+#define PF_FW_MBX			0x08400000
+
+/* Reset registers */
+#define PFGEN_RTRIG_REG_LEN		2048
+#define PFGEN_RTRIG			0x08407000	/* Device resets */
+
+/**
+ * struct ixd_bar_region - BAR region description
+ * @offset: BAR region offset
+ * @size: BAR region size
+ */
+struct ixd_bar_region {
+	resource_size_t offset;
+	resource_size_t size;
+};
+
+#endif /* _IXD_LAN_REGS_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
new file mode 100644
index 000000000000..75ee53152e61
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include "ixd.h"
+#include "ixd_lan_regs.h"
+
+MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
+MODULE_IMPORT_NS("LIBIE_PCI");
+MODULE_LICENSE("GPL");
+
+/**
+ * ixd_remove - remove a CPF PCI device
+ * @pdev: PCI device being removed
+ */
+static void ixd_remove(struct pci_dev *pdev)
+{
+	struct ixd_adapter *adapter = pci_get_drvdata(pdev);
+
+	libie_pci_unmap_all_mmio_regions(&adapter->hw);
+}
+
+/**
+ * ixd_shutdown - shut down a CPF PCI device
+ * @pdev: PCI device being shut down
+ */
+static void ixd_shutdown(struct pci_dev *pdev)
+{
+	ixd_remove(pdev);
+
+	if (system_state == SYSTEM_POWER_OFF)
+		pci_set_power_state(pdev, PCI_D3hot);
+}
+
+/**
+ * ixd_iomap_regions - iomap PCI BARs
+ * @adapter: adapter to map memory regions for
+ *
+ * Returns: %0 on success, negative on failure
+ */
+static int ixd_iomap_regions(struct ixd_adapter *adapter)
+{
+	const struct ixd_bar_region regions[] = {
+		{
+			.offset = PFGEN_RTRIG,
+			.size = PFGEN_RTRIG_REG_LEN,
+		},
+		{
+			.offset = PF_FW_MBX,
+			.size = PF_FW_MBX_REG_LEN,
+		},
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(regions); i++) {
+		struct libie_mmio_info *mmio_info = &adapter->hw;
+		bool map_ok;
+
+		map_ok = libie_pci_map_mmio_region(mmio_info,
+						   regions[i].offset,
+						   regions[i].size);
+		if (!map_ok) {
+			dev_err(ixd_to_dev(adapter),
+				"Failed to map PCI device MMIO region\n");
+
+			libie_pci_unmap_all_mmio_regions(mmio_info);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * ixd_probe - probe a CPF PCI device
+ * @pdev: corresponding PCI device
+ * @ent: entry in ixd_pci_tbl
+ *
+ * Returns: %0 on success, negative errno code on failure
+ */
+static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	struct ixd_adapter *adapter;
+	int err;
+
+	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
+	if (!adapter)
+		return -ENOMEM;
+	adapter->hw.pdev = pdev;
+	INIT_LIST_HEAD(&adapter->hw.mmio_list);
+
+	err = libie_pci_init_dev(pdev);
+	if (err)
+		return err;
+
+	pci_set_drvdata(pdev, adapter);
+
+	return ixd_iomap_regions(adapter);
+}
+
+static const struct pci_device_id ixd_pci_tbl[] = {
+	{ PCI_VDEVICE(INTEL, IXD_DEV_ID_CPF) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, ixd_pci_tbl);
+
+static struct pci_driver ixd_driver = {
+	.name			= KBUILD_MODNAME,
+	.id_table		= ixd_pci_tbl,
+	.probe			= ixd_probe,
+	.remove			= ixd_remove,
+	.shutdown		= ixd_shutdown,
+};
+module_pci_driver(ixd_driver);
-- 
2.47.1


