Return-Path: <netdev+bounces-245789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75740CD7FE6
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48F5E3013E88
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB8A25B2F4;
	Tue, 23 Dec 2025 03:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-113.mail.aliyun.com (out28-113.mail.aliyun.com [115.124.28.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DE92367B8;
	Tue, 23 Dec 2025 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461891; cv=none; b=OkoMjiLoUjXvmbJuSBoY9IHxUCtqf6eSJLXKR/r1avf4/Sn2285rNpFFm+JObYNL6xKJP8vND96YAO+LfzZLd1Q+/pJkwnQYKGwy1QiIIQl+KJHpnf37Nr8lZ3CyluMGQkq2XLYqEtdVyfPO4Rm/i4DMIeETzBWYeWR5BmV00HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461891; c=relaxed/simple;
	bh=MqE0v1LFRf+46na4n8NNeishxCjoK1Qdcus0QTqeziw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHNW5T7v5tWBeY8gStY7JBG4Cn3nZ/fC7iIlnEyFi0ttEVP1jveCOz/Tv107yWtmiqSEI2QC4q5c118a0DXryWLpH8v5xFsmJhLe+vSQD8BTVVH4NE9I4Sm20Hp3Ni9noqvrKgEZbIdcV9QaBkJqYwtode3asiUImXetzWyL/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.fqrxWPZ_1766461879 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 11:51:21 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 net-next 01/15] net/nebula-matrix: add minimum nbl build framework
Date: Tue, 23 Dec 2025 11:50:24 +0800
Message-ID: <20251223035113.31122-2-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1.Add nbl min build infrastructure for nbl driver.
2.Implemented the framework of pci device initialization.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
Change-Id: I6cbc439505e82e993dd87ad91d9242d6f05840bb
---
 .../ethernet/nebula-matrix/m18100.rst         |  52 ++++++
 MAINTAINERS                                   |  10 ++
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |  39 +++++
 drivers/net/ethernet/nebula-matrix/Makefile   |   6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |  23 +++
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |  30 ++++
 .../nbl/nbl_include/nbl_include.h             |  72 ++++++++
 .../nbl/nbl_include/nbl_product_base.h        |  21 +++
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c | 155 ++++++++++++++++++
 11 files changed, 410 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
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
index e36689cd7cc7..6c50296cab83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27628,6 +27628,16 @@ F:	Documentation/networking/device_drivers/ethernet/wangxun/*
 F:	drivers/net/ethernet/wangxun/
 F:	drivers/net/pcs/pcs-xpcs-wx.c
 
+NEBULA-MATRIX ETHERNET DRIVER (nebula-matrix)
+M:	Illusion.Wang <illusion.wang@nebula-matrix.com>
+M:	Dimon.Zhao <dimon.zhao@nebula-matrix.com>
+M:	Alvin.Wang <alvin.wang@nebula-matrix.com>
+M:	Sam Chen <sam.chen@nebula-matrix.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/device_drivers/ethernet/nebula-matrix/*
+F:	drivers/net/ethernet/nebula-matrix/
+
 WATCHDOG DEVICE DRIVERS
 M:	Wim Van Sebroeck <wim@linux-watchdog.org>
 M:	Guenter Roeck <linux@roeck-us.net>
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 4a1b368ca7e6..3995f75f1016 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -204,5 +204,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
 source "drivers/net/ethernet/wiznet/Kconfig"
 source "drivers/net/ethernet/xilinx/Kconfig"
 source "drivers/net/ethernet/xircom/Kconfig"
+source "drivers/net/ethernet/nebula-matrix/Kconfig"
 
 endif # ETHERNET
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 2e18df8ca8ec..632dac9c4b75 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -108,4 +108,5 @@ obj-$(CONFIG_NET_VENDOR_XILINX) += xilinx/
 obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
 obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
 obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
+obj-$(CONFIG_NET_VENDOR_NEBULA_MATRIX) += nebula-matrix/
 obj-$(CONFIG_OA_TC6) += oa_tc6.o
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
index 000000000000..7717efab0b01
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Nebula Matrix Limited.
+# Author:
+
+obj-$(CONFIG_NBL_CORE) := nbl_core.o
+
+nbl_core-objs +=      nbl_main.o
+
+# Do not modify include path, unless you are adding a new file which needs some headers in its
+# direct upper directory (see the exception part in below).
+#
+# The structure requires that codes can only access the header files in nbl_include, or the .h that
+# has the same name as the .c file. The only exception is that the product-specific files can access
+# the same headers as the common part, e.g. nbl_hw_leonis.c can access nbl_hw.h.
+# Make sure to put all the things you need to expose to others in nbl_def_xxx.h, and make everything
+# in your own .h private.
+#
+# Try not to break these rules, sincerely.
+ccflags-y += -I$(srctree)/$(src)
+ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/
+ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw
+ccflags-y += -I$(srctree)/drivers/net/ethernet/nebula-matrix/nbl/
+
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
new file mode 100644
index 000000000000..898f5752d0b3
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_CORE_H_
+#define _NBL_CORE_H_
+#include "nbl_product_base.h"
+#define NBL_CAP_SET_BIT(loc)			(1 << (loc))
+#define NBL_CAP_TEST_BIT(val, loc)		(((val) >> (loc)) & 0x1)
+
+#define NBL_CAP_IS_CTRL(val)			NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_CTRL_BIT)
+#define NBL_CAP_IS_NET(val)			NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_NET_BIT)
+#define NBL_CAP_IS_VF(val)			NBL_CAP_TEST_BIT(val, NBL_CAP_IS_VF_BIT)
+#define NBL_CAP_IS_NIC(val)			NBL_CAP_TEST_BIT(val, NBL_CAP_IS_NIC_BIT)
+#define NBL_CAP_IS_USER(val)			NBL_CAP_TEST_BIT(val, NBL_CAP_HAS_USER_BIT)
+#define NBL_CAP_IS_OCP(val)			NBL_CAP_TEST_BIT(val, NBL_CAP_IS_OCP_BIT)
+#define NBL_CAP_IS_LEONIS(val)			NBL_CAP_TEST_BIT(val, NBL_CAP_IS_LEONIS_BIT)
+
+enum {
+	NBL_CAP_HAS_CTRL_BIT = 0,
+	NBL_CAP_HAS_NET_BIT,
+	NBL_CAP_IS_VF_BIT,
+	NBL_CAP_IS_NIC_BIT,
+	NBL_CAP_IS_LEONIS_BIT,
+	NBL_CAP_HAS_USER_BIT,
+	NBL_CAP_IS_OCP_BIT,
+};
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
new file mode 100644
index 000000000000..0bceb682b824
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_INCLUDE_H_
+#define _NBL_INCLUDE_H_
+
+#include <linux/mod_devicetable.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/etherdevice.h>
+#include <linux/if_ether.h>
+#include <linux/if_vlan.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/sctp.h>
+#include <linux/firmware.h>
+#include <linux/list.h>
+#include <net/ip_tunnels.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/cdev.h>
+#include <linux/kfifo.h>
+#include <linux/termios_internal.h>
+#include <linux/termios.h>
+#include <net/inet6_hashtables.h>
+#include <linux/compiler.h>
+#include <linux/netdevice.h>
+#include <net/ipv6.h>
+#include <linux/if_bridge.h>
+#include <linux/rtnetlink.h>
+#include <linux/pci.h>
+/*  ------  Basic definitions  -------  */
+#define NBL_DRIVER_NAME					"nbl_core"
+#define NBL_DRIVER_VERSION				"25.11-1.16"
+
+#define NBL_FLOW_INDEX_BYTE_LEN				8
+
+#define NBL_RATE_MBPS_100G				(100000)
+#define NBL_RATE_MBPS_25G				(25000)
+#define NBL_RATE_MBPS_10G				(10000)
+
+#define NBL_NEXT_ID(id, max)	({ typeof(id) _id = (id); ((_id) == (max) ? 0 : (_id) + 1); })
+#define NBL_IPV6_U32LEN					4
+
+#define NBL_MAX_FUNC					(520)
+#define NBL_MAX_MTU					15
+
+enum nbl_product_type {
+	NBL_LEONIS_TYPE,
+	NBL_PRODUCT_MAX,
+};
+
+struct nbl_func_caps {
+	u32 has_ctrl:1;
+	u32 has_net:1;
+	u32 is_vf:1;
+	u32 is_nic:1;
+	u32 has_user:1;
+	u32 is_ocp:1;
+	u32 rsv:26;
+};
+
+struct nbl_init_param {
+	struct nbl_func_caps caps;
+	enum nbl_product_type product_type;
+	bool pci_using_dac;
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
new file mode 100644
index 000000000000..ff3d2a9bc1e5
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEF_PRODUCT_BASE_H_
+#define _NBL_DEF_PRODUCT_BASE_H_
+
+#include "nbl_include.h"
+
+struct nbl_product_base_ops {
+	int (*hw_init)(void *p, struct nbl_init_param *param);
+	void (*hw_remove)(void *p);
+	int (*res_init)(void *p, struct nbl_init_param *param);
+	void (*res_remove)(void *p);
+	int (*chan_init)(void *p, struct nbl_init_param *param);
+	void (*chan_remove)(void *p);
+};
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
new file mode 100644
index 000000000000..1565fa20aae8
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include <linux/aer.h>
+#include "nbl_core.h"
+
+static int nbl_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *id)
+{
+	struct device *dev = &pdev->dev;
+
+	dev_info(dev, "nbl probe finished\n");
+	return 0;
+}
+
+static void nbl_remove(struct pci_dev *pdev)
+{
+	dev_info(&pdev->dev, "nbl remove OK!\n");
+}
+
+static void nbl_shutdown(struct pci_dev *pdev)
+{
+}
+
+#define NBL_VENDOR_ID			(0x1F0F)
+
+/**
+ *  Leonis DeviceID
+ * 0x3403-0x340d for snic v3r1 product
+ **/
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
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_OCP), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_OCP), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_BASE_T_OCP), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110_LX_BASE_T_OCP), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_OCP), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_OCP), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_OCP_BIT)},
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_BASE_T_OCP), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_LX_BASE_T_OCP), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) | NBL_CAP_SET_BIT(NBL_CAP_HAS_USER_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_OCP_BIT) },
+	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18000_VF), .driver_data =
+	  NBL_CAP_SET_BIT(NBL_CAP_HAS_NET_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_VF_BIT) |
+	  NBL_CAP_SET_BIT(NBL_CAP_IS_NIC_BIT) | NBL_CAP_SET_BIT(NBL_CAP_IS_LEONIS_BIT) },
+	/* required as sentinel */
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, nbl_id_table);
+
+static int __maybe_unused nbl_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused nbl_resume(struct device *dev)
+{
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(nbl_pm_ops, nbl_suspend, nbl_resume);
+static struct pci_driver nbl_driver = {
+	.name = NBL_DRIVER_NAME,
+	.id_table = nbl_id_table,
+	.probe = nbl_probe,
+	.remove = nbl_remove,
+	.shutdown = nbl_shutdown,
+	.driver.pm = &nbl_pm_ops,
+};
+
+static int __init nbl_module_init(void)
+{
+	int status;
+
+	status = pci_register_driver(&nbl_driver);
+
+	return status;
+}
+
+static void __exit nbl_module_exit(void)
+{
+	pci_unregister_driver(&nbl_driver);
+
+	pr_info("nbl module unloaded\n");
+}
+
+module_init(nbl_module_init);
+module_exit(nbl_module_exit);
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION(NBL_DRIVER_VERSION);
-- 
2.43.0


