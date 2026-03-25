Return-Path: <netdev+bounces-271380-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD0UDC1ew2m1qQQAu9opvQ
	(envelope-from <netdev+bounces-271380-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:01:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 956E531F5D6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA77C301C56A
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B1A2DCF72;
	Wed, 25 Mar 2026 04:01:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9F12DAFDE;
	Wed, 25 Mar 2026 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411267; cv=none; b=DmEIukg8r/zMZZPtIVXXBdZfI8W+tQTazc0IazpHBkstE2AJKyOxddsmwLZoR4dFRqdNNL7hDbzFGORDgKu4M6817o2h3GMS1SmN5oBBVuJ7uKAvNmtuk1q66w56gHD1vJfUPdoTSxyROQqJcNJrTNscaszwl5m2Vju+uvx+YLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411267; c=relaxed/simple;
	bh=yp79XqBiRqxJhGNuD7HAaJpS2xaggnKWmYqOqxF2vWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STQDnqUE36YY4j7KIDadVAufEGJPfwaiBZznHtfWgjAWqoBkVIg4DrfUhjil56gBXBTMwWpyOhK/qUgE76h630xARpijnBoCe60jA6NmnM5/86QzmOeSehD6vtje7+VfEeFVPlKs3UP08eQVMswtZPGE2S8lk85L2NnjWzD6xlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06714728|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0196957-0.00295728-0.977347;FP=16596899845898772146|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.gzTMEVp_1774411253;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gzTMEVp_1774411253 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 25 Mar 2026 12:00:54 +0800
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
Subject: [PATCH v9 net-next 01/11] net/nebula-matrix: add minimum nbl build framework
Date: Wed, 25 Mar 2026 12:00:33 +0800
Message-ID: <20260325040048.2313-2-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325040048.2313-1-illusion.wang@nebula-matrix.com>
References: <20260325040048.2313-1-illusion.wang@nebula-matrix.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271380-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,illusion.wang:url]
X-Rspamd-Queue-Id: 956E531F5D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1.Add nbl min build infrastructure for nbl driver.

2.Implemented the framework of pci device initialization.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../ethernet/nebula-matrix/nbl.rst            |  27 +++++
 MAINTAINERS                                   |  10 ++
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |  34 ++++++
 drivers/net/ethernet/nebula-matrix/Makefile   |   6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   6 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  17 +++
 .../nbl/nbl_include/nbl_include.h             |  21 ++++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 113 ++++++++++++++++++
 11 files changed, 237 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 5f3f06111911..14868fabc1c6 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -48,6 +48,7 @@ Contents:
    meta/fbnic
    microsoft/netvsc
    mucse/rnpgbe
+   nebula-matrix/nbl
    netronome/nfp
    pensando/ionic
    pensando/ionic_rdma
diff --git a/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
new file mode 100644
index 000000000000..6bac46ed8265
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================
+Linux Base Driver for Nebula-matrix M18000-NIC family
+======================================================
+
+Overview:
+=========
+M18000-NIC is a series of network interface card for the Data Center Area.
+
+The driver supports link-speed 100GbE/25GE/10GE.
+
+M18000-NIC devices support MSI-X interrupt vector for each Tx/Rx queue and
+interrupt moderation.
+
+M18000-NIC devices support also various offload features such as checksum offload,
+Receive-Side Scaling(RSS).
+
+Support
+=======
+
+For more information about M18000-NIC, please visit the following URL:
+https://www.nebula-matrix.com/
+
+If an issue is identified with the released source code on the supported kernel
+with a supported adapter, email the specific information related to the issue to
+open@nebula-matrix.com.
diff --git a/MAINTAINERS b/MAINTAINERS
index a09bf30a057d..e262af15bbcd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18204,6 +18204,16 @@ F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
 F:	Documentation/hwmon/nct7363.rst
 F:	drivers/hwmon/nct7363.c
 
+NEBULA-MATRIX ETHERNET DRIVER (nebula-matrix)
+M:	Illusion Wang <illusion.wang@nebula-matrix.com>
+M:	Dimon Zhao <dimon.zhao@nebula-matrix.com>
+M:	Alvin Wang <alvin.wang@nebula-matrix.com>
+M:	Sam Chen <sam.chen@nebula-matrix.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/device_drivers/ethernet/nebula-matrix/
+F:	drivers/net/ethernet/nebula-matrix/
+
 NETCONSOLE
 M:	Breno Leitao <leitao@debian.org>
 S:	Maintained
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index aa7103e7f47f..3aa005adb90e 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -131,6 +131,7 @@ config FEALNX
 
 source "drivers/net/ethernet/ni/Kconfig"
 source "drivers/net/ethernet/natsemi/Kconfig"
+source "drivers/net/ethernet/nebula-matrix/Kconfig"
 source "drivers/net/ethernet/netronome/Kconfig"
 source "drivers/net/ethernet/8390/Kconfig"
 source "drivers/net/ethernet/nvidia/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 6615a67a63d5..024a8e91abed 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_NET_VENDOR_MUCSE) += mucse/
 obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
 obj-$(CONFIG_FEALNX) += fealnx.o
 obj-$(CONFIG_NET_VENDOR_NATSEMI) += natsemi/
+obj-$(CONFIG_NET_VENDOR_NEBULA_MATRIX) += nebula-matrix/
 obj-$(CONFIG_NET_VENDOR_NETRONOME) += netronome/
 obj-$(CONFIG_NET_VENDOR_NI) += ni/
 obj-$(CONFIG_NET_VENDOR_NVIDIA) += nvidia/
diff --git a/drivers/net/ethernet/nebula-matrix/Kconfig b/drivers/net/ethernet/nebula-matrix/Kconfig
new file mode 100644
index 000000000000..28a05dc7a0b4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/Kconfig
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Nebula-matrix network device configuration
+#
+
+config NET_VENDOR_NEBULA_MATRIX
+	bool "Nebula-matrix devices"
+	default y
+	help
+	  If you have a network (Ethernet) card belonging to this class, say Y.
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Nebula-matrix cards. If you say Y, you will be asked
+	  for your specific card in the following questions.
+
+if NET_VENDOR_NEBULA_MATRIX
+
+config NBL
+	tristate "Nebula-matrix Ethernet Controller m18100/m18000 support"
+	depends on 64BIT && PCI
+	help
+	  This driver supports Nebula-matrix Ethernet Controller m18100/m18000
+	  Family of devices.  For more information about this product, go to
+	  the product description with smart NIC:
+
+	  <http://www.nebula-matrix.com>
+
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst>.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called nbl.
+
+endif # NET_VENDOR_NEBULA_MATRIX
diff --git a/drivers/net/ethernet/nebula-matrix/Makefile b/drivers/net/ethernet/nebula-matrix/Makefile
new file mode 100644
index 000000000000..42cdf2db8f0c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Nebula-matrix network device drivers.
+#
+
+obj-$(CONFIG_NBL) += nbl/
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
new file mode 100644
index 000000000000..b90fba239401
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Nebula Matrix Limited.
+
+obj-$(CONFIG_NBL) := nbl.o
+
+nbl-objs +=      nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
new file mode 100644
index 000000000000..beb6af7eb08e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_CORE_H_
+#define _NBL_CORE_H_
+
+#include <linux/bits.h>
+enum {
+	NBL_CAP_HAS_CTRL_BIT = BIT(0),
+	NBL_CAP_HAS_NET_BIT = BIT(1),
+	NBL_CAP_IS_NIC_BIT = BIT(2),
+	NBL_CAP_IS_LEONIS_BIT = BIT(3),
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
new file mode 100644
index 000000000000..1046e6517b15
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_INCLUDE_H_
+#define _NBL_INCLUDE_H_
+
+#include <linux/types.h>
+
+/*  ------  Basic definitions  -------  */
+#define NBL_DRIVER_NAME					"nbl"
+
+struct nbl_func_caps {
+	u32 has_ctrl:1;
+	u32 has_net:1;
+	u32 is_nic:1;
+	u32 rsv:29;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
new file mode 100644
index 000000000000..15a6aecf5560
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+#include "nbl_include/nbl_include.h"
+#include "nbl_core.h"
+
+static int nbl_probe(struct pci_dev *pdev,
+		     const struct pci_device_id *id)
+{
+	return 0;
+}
+
+static void nbl_remove(struct pci_dev *pdev)
+{
+}
+
+/*
+ * PCI Device IDs for Leonis/NBL Network Controllers
+ *
+ * Vendor ID: 0x1F0F
+ * SNIC v3r1 product Device IDs range: 0x3403-0x3412
+ */
+#define NBL_VENDOR_ID				0x1F0F
+
+#define NBL_DEVICE_ID_M18110			0x3403
+#define NBL_DEVICE_ID_M18110_LX			0x3404
+#define NBL_DEVICE_ID_M18110_BASE_T		0x3405
+#define NBL_DEVICE_ID_M18110_LX_BASE_T		0x3406
+#define NBL_DEVICE_ID_M18110_OCP		0x3407
+#define NBL_DEVICE_ID_M18110_LX_OCP		0x3408
+#define NBL_DEVICE_ID_M18110_BASE_T_OCP		0x3409
+#define NBL_DEVICE_ID_M18110_LX_BASE_T_OCP	0x340a
+#define NBL_DEVICE_ID_M18000			0x340b
+#define NBL_DEVICE_ID_M18000_LX			0x340c
+#define NBL_DEVICE_ID_M18000_BASE_T		0x340d
+#define NBL_DEVICE_ID_M18000_LX_BASE_T		0x340e
+#define NBL_DEVICE_ID_M18000_OCP		0x340f
+#define NBL_DEVICE_ID_M18000_LX_OCP		0x3410
+#define NBL_DEVICE_ID_M18000_BASE_T_OCP		0x3411
+#define NBL_DEVICE_ID_M18000_LX_BASE_T_OCP	0x3412
+
+static const struct pci_device_id nbl_id_table[] = {
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_OCP),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_OCP),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T_OCP),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T_OCP),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_OCP),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_OCP),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T_OCP),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T_OCP),
+	  .driver_data = NBL_CAP_HAS_NET_BIT | NBL_CAP_IS_NIC_BIT |
+			 NBL_CAP_IS_LEONIS_BIT },
+	/* required as sentinel */
+	{
+		0,
+	}
+};
+MODULE_DEVICE_TABLE(pci, nbl_id_table);
+
+static struct pci_driver nbl_driver = {
+	.name = NBL_DRIVER_NAME,
+	.id_table = nbl_id_table,
+	.probe = nbl_probe,
+	.remove = nbl_remove,
+};
+
+module_pci_driver(nbl_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Nebula Matrix Network Driver");
-- 
2.47.3


