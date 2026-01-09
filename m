Return-Path: <netdev+bounces-248423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D70D0864F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 11:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 288793015160
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 10:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF59C3375D5;
	Fri,  9 Jan 2026 10:02:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-28.us.a.mail.aliyun.com (out198-28.us.a.mail.aliyun.com [47.90.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654CB3370F0;
	Fri,  9 Jan 2026 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767952968; cv=none; b=i5d/h0d40QsWlGyfo7LpcB1ypUj7TUxxJrWOz2dUgRL0nswICL8AdCyKm6BvyonF0myxu7arkp5kWmzqhMjJRD661dzG7av4ESrcrffF3iQkrdDpvGOY/AovrkzS8Z9WMVGLfaaSvHf8yi/cEZ/EhnMYkx9/SokAi9gO5hj9QcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767952968; c=relaxed/simple;
	bh=L2Wg4dl5Qk8Y3+prB5aGHCyMr5knKQJYIWZWYosB7J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBYzWxVT+F1bUOawaU9Kud65+O2qDh03XCLPmnF7YDV8pjD7F7ss/iAtV8iyznbCew8SbS6jNhLViqJynyc8PnE9dCvtthf+AflU9OxerEzDtGHQjFD+e/p1VLkJnE2C0BLNi3Vr57eVAHk/pNpcVnSP4/g4FSEpBH3sO7XxONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.g2QQAVc_1767952945 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 09 Jan 2026 18:02:26 +0800
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
Subject: [PATCH v2 net-next 01/15] net/nebula-matrix: add minimum nbl build framework
Date: Fri,  9 Jan 2026 18:01:19 +0800
Message-ID: <20260109100146.63569-2-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
References: <20260109100146.63569-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1.Add nbl min build infrastructure for nbl driver.
2.Implemented the framework of pci device initialization.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../ethernet/nebula-matrix/m18100.rst         |  52 ++++++++
 MAINTAINERS                                   |  10 ++
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |  39 ++++++
 drivers/net/ethernet/nebula-matrix/Makefile   |   6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |  11 ++
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  29 +++++
 .../nbl/nbl_include/nbl_include.h             |  24 ++++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 117 ++++++++++++++++++
 10 files changed, 290 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

diff --git a/Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst b/Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst
new file mode 100644
index 000000000000..e1b63a2bafe0
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================================================
+Linux Base Driver for Nebula-matrix M18100-NIC family
+============================================================
+
+Overview:
+=========
+M18100-NIC is a series of network interface card for the Data Center Area.
+
+The driver supports link-speed 100GbE/25GE/10GE.
+
+M18100-NIC devices support SR-IOV. This driver is used for both of Physical
+Function(PF) and Virtual Function(VF).
+
+M18100-NIC devices support MSI-X interrupt vector for each Tx/Rx queue and
+interrupt moderation.
+
+M18100-NIC devices support also various offload features such as checksum offload,
+Receive-Side Scaling(RSS).
+
+
+Supported PCI vendor ID/device IDs:
+===================================
+
+1f0f:3403 - M18110 Family PF
+1f0f:3404 - M18110 Lx Family PF
+1f0f:3405 - M18110 Family BASE-T PF
+1f0f:3406 - M18110 Lx Family BASE-T PF
+1f0f:3407 - M18110 Family OCP PF
+1f0f:3408 - M18110 Lx Family OCP PF
+1f0f:3409 - M18110 Family BASE-T OCP PF
+1f0f:340a - M18110 Lx Family BASE-T OCP PF
+1f0f:340b - M18100 Family PF
+1f0f:340c - M18100 Lx Family PF
+1f0f:340d - M18100 Family BASE-T PF
+1f0f:340e - M18100 Lx Family BASE-T PF
+1f0f:340f - M18100 Family OCP PF
+1f0f:3410 - M18100 Lx Family OCP PF
+1f0f:3411 - M18100 Family BASE-T OCP PF
+1f0f:3412 - M18100 Lx Family BASE-T OCP PF
+1f0f:3413 - M18100 Family Virtual Function
+
+Support
+=======
+
+For more information about M18100-NIC, please visit the following URL:
+https://www.nebula-matrix.com/
+
+If an issue is identified with the released source code on the supported kernel
+with a supported adapter, email the specific information related to the issue to
+open@nebula-matrix.com.
diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..6cf58be32a17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18003,6 +18003,16 @@ F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
 F:	Documentation/hwmon/nct7363.rst
 F:	drivers/hwmon/nct7363.c
 
+NEBULA-MATRIX ETHERNET DRIVER (nebula-matrix)
+M:	llusion.Wang <illusion.wang@nebula-matrix.com>
+M:	Dimon.Zhao <dimon.zhao@nebula-matrix.com>
+M:	Alvin.Wang <alvin.wang@nebula-matrix.com>
+M:	Sam Chen <sam.chen@nebula-matrix.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/device_drivers/ethernet/nebula-matrix/*
+F:	drivers/net/ethernet/nebula-matrix/
+
 NETCONSOLE
 M:	Breno Leitao <leitao@debian.org>
 S:	Maintained
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 4a1b368ca7e6..4753e203ba85 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -143,6 +143,7 @@ config FEALNX
 
 source "drivers/net/ethernet/ni/Kconfig"
 source "drivers/net/ethernet/natsemi/Kconfig"
+source "drivers/net/ethernet/nebula-matrix/Kconfig"
 source "drivers/net/ethernet/neterion/Kconfig"
 source "drivers/net/ethernet/netronome/Kconfig"
 source "drivers/net/ethernet/8390/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 2e18df8ca8ec..fec3cbf75f10 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_NET_VENDOR_MUCSE) += mucse/
 obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
 obj-$(CONFIG_FEALNX) += fealnx.o
 obj-$(CONFIG_NET_VENDOR_NATSEMI) += natsemi/
+obj-$(CONFIG_NET_VENDOR_NEBULA_MATRIX) += nebula-matrix/
 obj-$(CONFIG_NET_VENDOR_NETERION) += neterion/
 obj-$(CONFIG_NET_VENDOR_NETRONOME) += netronome/
 obj-$(CONFIG_NET_VENDOR_NI) += ni/
diff --git a/drivers/net/ethernet/nebula-matrix/Kconfig b/drivers/net/ethernet/nebula-matrix/Kconfig
new file mode 100644
index 000000000000..ff786917f2bf
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/Kconfig
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Nebula-matrix network device configuration
+#
+
+config NET_VENDOR_NEBULA_MATRIX
+    bool "Nebula-matrix devices"
+    default y
+    help
+      If you have a network (Ethernet) card belonging to this class, say Y.
+
+      Note that the answer to this question doesn't directly affect the
+      kernel: saying N will just cause the configurator to skip all
+      the questions about Nebula-matrix cards. If you say Y, you will be
+      asked for your specific card in the following questions.
+
+if NET_VENDOR_NEBULA_MATRIX
+
+config NBL_CORE
+    tristate "Nebula-matrix Ethernet Controller m18110 Family support"
+    depends on PCI && VFIO
+    depends on ARM64 || X86_64
+    default m
+    select PLDMFW
+    select PAGE_POOL
+    help
+      This driver supports Nebula-matrix Ethernet Controller m18110 Family of
+      devices.  For more information about this product, go to the product
+      description with smart NIC:
+
+      <http://www.nebula-matrix.com>
+
+      More specific information on configuring the driver is in
+      <file:Documentation/networking/device_drivers/ethernet/nebula-matrix/m18110.rst>.
+
+      To compile this driver as a module, choose M here. The module
+      will be called nbl_core.
+
+endif # NET_VENDOR_NEBULA_MATRIX
diff --git a/drivers/net/ethernet/nebula-matrix/Makefile b/drivers/net/ethernet/nebula-matrix/Makefile
new file mode 100644
index 000000000000..dc6bf7dcd6bf
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Nebula-matrix network device drivers.
+#
+
+obj-$(CONFIG_NBL_CORE) += nbl/
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
new file mode 100644
index 000000000000..df16a3436a5c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Nebula Matrix Limited.
+# Author:
+
+obj-$(CONFIG_NBL_CORE) := nbl_core.o
+
+nbl_core-objs +=      nbl_main.o
+
+# Provide include files
+ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/
+ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
new file mode 100644
index 000000000000..e91de717bfe8
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_CORE_H_
+#define _NBL_CORE_H_
+
+#include <linux/pci.h>
+#include "nbl_include.h"
+#define NBL_CAP_TEST_BIT(val, loc) (((val) >> (loc)) & 0x1)
+
+#define NBL_CAP_IS_CTRL(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
+#define NBL_CAP_IS_NET(val) NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_NET_BIT)
+#define NBL_CAP_IS_VF(val) NBL_CAP_TEST_BIT(val, NBL_CAP_IS_VF_BIT)
+#define NBL_CAP_IS_NIC(val) NBL_CAP_TEST_BIT(val, NBL_CAP_IS_NIC_BIT)
+#define NBL_CAP_IS_OCP(val) NBL_CAP_TEST_BIT(val, NBL_CAP_IS_OCP_BIT)
+#define NBL_CAP_IS_LEONIS(val) NBL_CAP_TEST_BIT(val, NBL_CAP_IS_LEONIS_BIT)
+
+enum {
+	NBL_CAP_HAS_CTRL_BIT = 0,
+	NBL_CAP_HAS_NET_BIT,
+	NBL_CAP_IS_VF_BIT,
+	NBL_CAP_IS_NIC_BIT,
+	NBL_CAP_IS_LEONIS_BIT,
+	NBL_CAP_IS_OCP_BIT,
+};
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
new file mode 100644
index 000000000000..963e13927a79
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_INCLUDE_H_
+#define _NBL_INCLUDE_H_
+
+#include <linux/types.h>
+
+/*  ------  Basic definitions  -------  */
+#define NBL_DRIVER_NAME					"nbl_core"
+
+struct nbl_func_caps {
+	u32 has_ctrl:1;
+	u32 has_net:1;
+	u32 is_vf:1;
+	u32 is_nic:1;
+	u32 is_ocp:1;
+	u32 rsv:27;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
new file mode 100644
index 000000000000..ddb45144ff1c
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include <linux/aer.h>
+#include "nbl_core.h"
+
+static int nbl_probe(struct pci_dev *pdev,
+		     const struct pci_device_id __always_unused *id)
+{
+	struct device *dev = &pdev->dev;
+
+	dev_dbg(dev, "nbl probe ok!\n");
+	return 0;
+}
+
+static void nbl_remove(struct pci_dev *pdev)
+{
+	dev_dbg(&pdev->dev, "nbl remove OK!\n");
+}
+
+#define NBL_VENDOR_ID			(0x1F0F)
+
+/*
+ *  Leonis DeviceID
+ * 0x3403-0x340d for snic v3r1 product
+ */
+#define NBL_DEVICE_ID_M18110			(0x3403)
+#define NBL_DEVICE_ID_M18110_LX			(0x3404)
+#define NBL_DEVICE_ID_M18110_BASE_T		(0x3405)
+#define NBL_DEVICE_ID_M18110_LX_BASE_T		(0x3406)
+#define NBL_DEVICE_ID_M18110_OCP		(0x3407)
+#define NBL_DEVICE_ID_M18110_LX_OCP		(0x3408)
+#define NBL_DEVICE_ID_M18110_BASE_T_OCP		(0x3409)
+#define NBL_DEVICE_ID_M18110_LX_BASE_T_OCP	(0x340a)
+#define NBL_DEVICE_ID_M18000			(0x340b)
+#define NBL_DEVICE_ID_M18000_LX			(0x340c)
+#define NBL_DEVICE_ID_M18000_BASE_T		(0x340d)
+#define NBL_DEVICE_ID_M18000_LX_BASE_T		(0x340e)
+#define NBL_DEVICE_ID_M18000_OCP		(0x340f)
+#define NBL_DEVICE_ID_M18000_LX_OCP		(0x3410)
+#define NBL_DEVICE_ID_M18000_BASE_T_OCP		(0x3411)
+#define NBL_DEVICE_ID_M18000_LX_BASE_T_OCP	(0x3412)
+#define NBL_DEVICE_ID_M18000_VF			(0x3413)
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
+			 BIT(NBL_CAP_IS_LEONIS_BIT) | BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) | BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) | BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) | BIT(NBL_CAP_IS_OCP_BIT) },
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
+			 BIT(NBL_CAP_IS_LEONIS_BIT) | BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) | BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) | BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T_OCP),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_NIC_BIT) |
+			 BIT(NBL_CAP_IS_LEONIS_BIT) | BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_VF),
+	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) | BIT(NBL_CAP_IS_VF_BIT) |
+			 BIT(NBL_CAP_IS_NIC_BIT) | BIT(NBL_CAP_IS_LEONIS_BIT) },
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


