Return-Path: <netdev+bounces-287362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG9zMlzRA2oF/AEAu9opvQ
	(envelope-from <netdev+bounces-287362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:18:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBE952BC90
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E17CA300530F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6FE3672B8;
	Wed, 13 May 2026 01:17:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-25.us.a.mail.aliyun.com (out198-25.us.a.mail.aliyun.com [47.90.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D63360EF1;
	Wed, 13 May 2026 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635040; cv=none; b=H0bIeJrmPV6sy/83a9iJM+sOl7xX75uYUbyyjpLVOC5fWHUQednl0slog17UHG1a+wZSerKQXCXqP+j7PGpytOJKUT1udOU59SA0sAWqJUxlDOAZKKchp7HK2V4TJiUt5YzV1qqqJD/NvjUgvPZqaGrBAUNqDk38pZ+sC7JZ1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635040; c=relaxed/simple;
	bh=uEJ2U/guPUevZyvdqsy+ryJLXZUF7UZ5pe+5kDN7mOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cypnNfdYYQIV8nS2V33gQQ54W7mZnZdLPtGiOdZuMK7rz/omelP9dRaYiWzSsthRqc+Z7/4eUt0F3W/aljYJrXOlBFTzM2OAt4RZvUvVVX1gknTumTKCqFQ5EEuvBfi0WuBuPZVAQkaTQmBTOt0g9REqtoOJcxoGWaGntN/qDQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06713078|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0221906-0.00311292-0.974696;FP=16597484786084748978|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.hVp4DFy_1778635013;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hVp4DFy_1778635013 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 13 May 2026 09:16:54 +0800
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
Subject: [PATCH v14 net-next 01/11] net/nebula-matrix: add minimum nbl build framework
Date: Wed, 13 May 2026 09:16:34 +0800
Message-ID: <20260513011649.4404-2-illusion.wang@nebula-matrix.com>
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
X-Rspamd-Queue-Id: CEBE952BC90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287362-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.969];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:email,nebula-matrix.com:mid,nebula-matrix.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,illusion.wang:url]
X-Rspamd-Action: no action

1.Add nbl min build infrastructure for nbl driver.

2.Add PCI driver skeleton with empty stubs for nbl driver.

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
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  16 +++
 .../nbl/nbl_include/nbl_include.h             |  21 ++++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 113 ++++++++++++++++++
 11 files changed, 236 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index fd3be5d20397..00b87a6ebe6d 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -46,6 +46,7 @@ Contents:
    meta/fbnic
    microsoft/netvsc
    mucse/rnpgbe
+   nebula-matrix/nbl
    netronome/nfp
    pensando/ionic
    pensando/ionic_rdma
diff --git a/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
new file mode 100644
index 000000000000..10feb5f37c04
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================
+Linux Base Driver for Nebula-matrix M18000-NIC family
+=====================================================
+
+Overview:
+=========
+M18000-NIC is a series of network interface cards for the Data Center Area.
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
index 5bbbbde6b907..4928a3f79941 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18371,6 +18371,16 @@ F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
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
index b8f70e2a1763..14b038f75e65 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -129,6 +129,7 @@ config FEALNX
 
 source "drivers/net/ethernet/ni/Kconfig"
 source "drivers/net/ethernet/natsemi/Kconfig"
+source "drivers/net/ethernet/nebula-matrix/Kconfig"
 source "drivers/net/ethernet/netronome/Kconfig"
 source "drivers/net/ethernet/8390/Kconfig"
 source "drivers/net/ethernet/nvidia/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 57344fec6ce0..69b5ee281270 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -66,6 +66,7 @@ obj-$(CONFIG_NET_VENDOR_MUCSE) += mucse/
 obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
 obj-$(CONFIG_FEALNX) += fealnx.o
 obj-$(CONFIG_NET_VENDOR_NATSEMI) += natsemi/
+obj-$(CONFIG_NET_VENDOR_NEBULA_MATRIX) += nebula-matrix/
 obj-$(CONFIG_NET_VENDOR_NETRONOME) += netronome/
 obj-$(CONFIG_NET_VENDOR_NI) += ni/
 obj-$(CONFIG_NET_VENDOR_NVIDIA) += nvidia/
diff --git a/drivers/net/ethernet/nebula-matrix/Kconfig b/drivers/net/ethernet/nebula-matrix/Kconfig
new file mode 100644
index 000000000000..6517c843fbde
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
+	tristate "Nebula-matrix Ethernet Controller m18110/m18000 support"
+	depends on PCI && (64BIT || COMPILE_TEST) && CPU_LITTLE_ENDIAN
+	help
+	  This driver supports Nebula-matrix Ethernet Controller m18110/m18000
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
index 000000000000..c525114297b4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_CORE_H_
+#define _NBL_CORE_H_
+
+enum {
+	NBL_CAP_HAS_CTRL_BIT,
+	NBL_CAP_HAS_NET_BIT,
+	NBL_CAP_IS_NIC_BIT,
+	NBL_CAP_IS_LEONIS_BIT,
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
index 000000000000..10c3536b327b
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
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) },
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


