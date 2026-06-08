Return-Path: <netdev+bounces-296617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kxnaL7bbJmrIlwIAu9opvQ
	(envelope-from <netdev+bounces-296617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:11:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C66E5657DFA
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:11:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=LFpNRQVt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296617-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296617-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F790301E6E0
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3253EB7E8;
	Mon,  8 Jun 2026 14:42:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E73E9C36;
	Mon,  8 Jun 2026 14:41:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929720; cv=none; b=TcqGC/gmB9bFoPugW4PXDWPYIbOa0eZPKICr9KZ/d7Vnf9auw39AFarlsaNS3tRbIzVSiOiQmUdZXFoXgpsJSPt8U+F5TnTE4E2WZ2CxHgG3UbRJut6CEe+mEMS0pUJq4VxEahnq7QEu/ggklR2qiP8yZaaj0RKvsaC1t4y3+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929720; c=relaxed/simple;
	bh=9NPyxJRWF4FeQOPERfHiH0yfWlnmZMLy1qnS9IdQIxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1sJVJ3u6Ey5vgddVlZbwHAB076g+58Ypl5DyzF6gvv/+7im10boX3KRMhXJhHc/Dizl8uyeG7xNHJz0s3wrWDGVPtDwJfaQh3yl8XzrAW9/C+GOW3hsgRUTUU5+YFneOCMAXiLflP67Kh1xjSSIdX3VmrNYmveXphnWbRZQK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFpNRQVt; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780929719; x=1812465719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9NPyxJRWF4FeQOPERfHiH0yfWlnmZMLy1qnS9IdQIxs=;
  b=LFpNRQVtGhnmZrLaDcSfbzOJnSCkbDqdxSxQpqnEuaDle7ViMuXbqmtn
   cowpL+5YaPDzrSuBosqxjI5tEp1yWvfs+2iPfoP3LKs7zLdVqpwSjquoo
   VXCtLQVj/KNCU/GUSG8aXnQKTZElddRYyNIx5/R6YVIpLZuKe62/CXTRd
   EMgJ4Eq6P35791ecefenDO6gliIQUjctXby6JxYikCxWdISU/Q7DR0Gdh
   pFjPNoGJT3bVEzM6kdcN3IgiADiDjuOHRKES6JQOeqGc95T1IjsgXRpnY
   8LBauMBNIwQ7E6z328QleCssUXzQ7qT4z94GocraPEuP0h55ub4HYApCe
   Q==;
X-CSE-ConnectionGUID: GabM9mXHQ4W/boenhG9A7w==
X-CSE-MsgGUID: WK41FPM3THy36dOR8KzOtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81642043"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81642043"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 07:41:58 -0700
X-CSE-ConnectionGUID: 42hGm/eCTlyHiVjk05C6xg==
X-CSE-MsgGUID: FhJcJE8sTO6XpXwz5g7NhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="249489759"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 08 Jun 2026 07:41:53 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AAD9928795;
	Mon,  8 Jun 2026 15:41:50 +0100 (IST)
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
	Bharath R <Bharath.r@intel.com>
Subject: [PATCH iwl-next v8 12/15] ixd: add basic driver framework for Intel(R) Control Plane Function
Date: Mon,  8 Jun 2026 16:41:17 +0200
Message-ID: <20260608144127.2751230-13-larysa.zaremba@intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296617-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:larysa.zaremba@intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Bharath.r@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C66E5657DFA

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
Tested-by: Bharath R <Bharath.r@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
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
index 786a23c84b90..afaa1de55b50 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -37,6 +37,7 @@ Contents:
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
index 000000000000..1b918c5d31cd
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_H_
+#define _IXD_H_
+
+#include <linux/net/intel/libie/pci.h>
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
2.47.0


