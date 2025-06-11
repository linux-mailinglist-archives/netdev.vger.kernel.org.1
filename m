Return-Path: <netdev+bounces-196458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FFEAD4E8D
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4373A7F60
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F381623E25A;
	Wed, 11 Jun 2025 08:37:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07723CEF9
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631026; cv=none; b=u6/4+Q+WCEe99RhKTeOI/2Snk17PwH07cqKNcMi0WmuHahKTcChsZYRkV+d+B8hKD71jcqaZMWLYJSR98IOi3DUyE+pTkpfEbj8unrxE/kfEck6qss0o8vwZxjvVH5zD+gq4jFhXvMHk+wqeIDiR/S3UeaXm9BNNWA5uMJyU7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631026; c=relaxed/simple;
	bh=RXFyn2n0qyBIR7UEWxzN/TZFEwVE6PHzZiXLpdwSdVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1EYGnA3ekH0fHO3FAVblGZFpUIviVozc5J5y1CelLo7x5DlppS7LyT0MVpJf5OzfETNcoixbnMg7yyywD2isxrlTefbIijMJiz6z4sVsdQIBJw5HDHvk9ngunnbo2KUqWLZVDbjg+dgi/hZe7Zq+SRt5TeWR0QE1pZ8XK+4ius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630985t6d722d97
X-QQ-Originating-IP: burWIKPCNSWcYVPve6VSRhlrfcbfcz5YtWE2qXq95KM=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3668617052570383599
EX-QQ-RecipientCnt: 9
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 09/12] net: wangxun: add ngbevf build
Date: Wed, 11 Jun 2025 16:35:56 +0800
Message-Id: <20250611083559.14175-10-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250611083559.14175-1-mengyuanlou@net-swift.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N754UttbGfoJ7awHGxhzWPsrguCAxTO6ZugcUp8NpS0g9yPLBmI8APWX
	Rc4DsXlyQ9Q/GNFnKs41xOZDoMq+43p7k5grtGygQgOsR9A3v5UoFZ9AepENy/KgsFdGxJ9
	qrgdMGs7EcqEVx81AIB6k5wS65yU1G0J8yVS4Soe16zlDYc2IEwl55+zODzZoaXL6O6kTFX
	tYSA6bo3cUXSa2oJxLD7LbUTJKHOv9mCgYpizFM4ygT9AdIT8X/5i8t/nOwM8igENGyhwzY
	mzRGO/uV9JO9KaTeQ9SWe8eHSqbD/oQzbxsnbD84E6rTP48t9nfKbBLJowdoKaIKVW/P0tT
	XY8sB2uANy66wRIm+F0o8tqor2DBwmPGV87fBWP+uCftcLbSGcHZIImawtBwyULa4pA3Yuq
	mBDwxA8n8ktvG1NHC5tJlwPw2kRafpnZFP5GizeYjUteLMtfqmCsIT7m+UNXKPNXC6n7djz
	iG5knnh+q0rdfJcFX8jE8cAxI3gy+68puP2ltq5KywE3sEtlmrxviN7W31gqWo+vv7tb67p
	L1KVyHHokEUbDoeOuO2OV3QjnxawA4m/XCDG+R4WVeyMy4klwQihgccZUfzX8yXzdtzd8P6
	ocwl/8MGDTV2FHCXGxxwBk/NCa4u6idFVmujSPUoXYdpDmVk98natdB40NA3nLjdxQU0zpP
	/ZCd2AmkLnE67XbP8EupZYBsiFfVhb36VYDF1RapmmhwW4wptz/ziU9ObU44WLBmQwycIzl
	Sp/b5Nv+tfM9CQ+7cDcE5KYeMAGOEM77icXlVob+KDB7TV3wCH13mdpAUXQIwg1mC4++cWq
	agoXEb2OKXKZgIP3WiQ3oBXez9CEiiplqdt8Aarf+bc1O6t7hfM/aK3+kxh+5rnOjvGlN2C
	ipe2vnqZran0wm4zvGLlo+PDFyRm6DTN+Z3mmdjYBRGl1cRqT/IIVmC2e+KbBTmhJ/xUBWu
	/pP5AfPjapZEv+aWPErANSycvTTYcY6mYL6dWLJtpULqaUoGoqW24zp9SdkWugr6fAZxvPA
	bQD45JsmGFo3qkq/XSubepsDzvyrpssA/NXQgWDmdBXeOqTavOK8zCrQld0qALmDy6VYMGL
	u4Q7i59GgZJqG3P9yhEWGD8q8Q4TsoazK6oRHXekhIq6cN8jWbI0ds=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Add doc build infrastructure for ngbevf driver.
Implement the basic PCI driver loading and unloading interface.
Initialize the id_table which support 1G virtual
functions for Wangxun.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../ethernet/wangxun/ngbevf.rst               |  16 ++
 drivers/net/ethernet/wangxun/Kconfig          |  15 ++
 drivers/net/ethernet/wangxun/Makefile         |   1 +
 drivers/net/ethernet/wangxun/ngbevf/Makefile  |   9 ++
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c | 149 ++++++++++++++++++
 .../net/ethernet/wangxun/ngbevf/ngbevf_type.h |  24 +++
 7 files changed, 215 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/Makefile
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
 create mode 100644 drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index e93453410772..40ac552641a3 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -60,6 +60,7 @@ Contents:
    wangxun/txgbe
    wangxun/txgbevf
    wangxun/ngbe
+   wangxun/ngbevf
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst b/Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst
new file mode 100644
index 000000000000..a39e3d5a1038
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+==================================================================
+Linux Base Virtual Function Driver for Wangxun(R) Gigabit Ethernet
+==================================================================
+
+WangXun Gigabit Virtual Function Linux driver.
+Copyright(c) 2015 - 2025 Beijing WangXun Technology Co., Ltd.
+
+Support
+=======
+For general information, go to the website at:
+https://www.net-swift.com
+
+If you got any problem, contact Wangxun support team via nic-support@net-swift.com
+and Cc: netdev.
diff --git a/drivers/net/ethernet/wangxun/Kconfig b/drivers/net/ethernet/wangxun/Kconfig
index a6ec73e4f300..c548f4e80565 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -82,4 +82,19 @@ config TXGBEVF
 	  To compile this driver as a module, choose M here. MSI-X interrupt
 	  support is required for this driver to work correctly.
 
+config NGBEVF
+	tristate "Wangxun(R) GbE Virtual Function Ethernet support"
+	depends on PCI_MSI
+	select LIBWX
+	help
+	  This driver supports virtual functions for WX1860, WX1860AL.
+
+	  This driver was formerly named ngbevf.
+
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/device_drivers/ethernet/wangxun/ngbevf.rst>.
+
+	  To compile this driver as a module, choose M here. MSI-X interrupt
+	  support is required for this driver to work correctly.
+
 endif # NET_VENDOR_WANGXUN
diff --git a/drivers/net/ethernet/wangxun/Makefile b/drivers/net/ethernet/wangxun/Makefile
index 71371d47a6ee..0a71a710b717 100644
--- a/drivers/net/ethernet/wangxun/Makefile
+++ b/drivers/net/ethernet/wangxun/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_LIBWX) += libwx/
 obj-$(CONFIG_TXGBE) += txgbe/
 obj-$(CONFIG_TXGBEVF) += txgbevf/
 obj-$(CONFIG_NGBE) += ngbe/
+obj-$(CONFIG_NGBEVF) += ngbevf/
diff --git a/drivers/net/ethernet/wangxun/ngbevf/Makefile b/drivers/net/ethernet/wangxun/ngbevf/Makefile
new file mode 100644
index 000000000000..11a4f15e2ce3
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/ngbevf/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd.
+#
+# Makefile for the Wangxun(R) 1GbE virtual functions driver
+#
+
+obj-$(CONFIG_NGBE) += ngbevf.o
+
+ngbevf-objs := ngbevf_main.o
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
new file mode 100644
index 000000000000..77025e7deeeb
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/string.h>
+#include <linux/etherdevice.h>
+
+#include "../libwx/wx_type.h"
+#include "../libwx/wx_vf_common.h"
+#include "ngbevf_type.h"
+
+/* ngbevf_pci_tbl - PCI Device ID Table
+ *
+ * Wildcard entries (PCI_ANY_ID) should come last
+ * Last entry must be all 0s
+ *
+ * { Vendor ID, Device ID, SubVendor ID, SubDevice ID,
+ *   Class, Class Mask, private data (not used) }
+ */
+static const struct pci_device_id ngbevf_pci_tbl[] = {
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL_W), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A2), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A2S), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A4), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A4S), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL2), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL2S), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL4), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL4S), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860NCSI), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860A1), 0},
+	{ PCI_VDEVICE(WANGXUN, NGBEVF_DEV_ID_EM_WX1860AL1), 0},
+	/* required last entry */
+	{ .device = 0 }
+};
+
+/**
+ * ngbevf_probe - Device Initialization Routine
+ * @pdev: PCI device information struct
+ * @ent: entry in ngbevf_pci_tbl
+ *
+ * Return: return 0 on success, negative on failure
+ *
+ * ngbevf_probe initializes an adapter identified by a pci_dev structure.
+ * The OS initialization, configuring of the adapter private structure,
+ * and a hardware reset occur.
+ **/
+static int ngbevf_probe(struct pci_dev *pdev,
+			const struct pci_device_id __always_unused *ent)
+{
+	struct net_device *netdev;
+	struct wx *wx = NULL;
+	int err;
+
+	err = pci_enable_device_mem(pdev);
+	if (err)
+		return err;
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_err(&pdev->dev,
+			"No usable DMA configuration, aborting\n");
+		goto err_pci_disable_dev;
+	}
+
+	err = pci_request_selected_regions(pdev,
+					   pci_select_bars(pdev, IORESOURCE_MEM),
+					   dev_driver_string(&pdev->dev));
+	if (err) {
+		dev_err(&pdev->dev,
+			"pci_request_selected_regions failed 0x%x\n", err);
+		goto err_pci_disable_dev;
+	}
+
+	pci_set_master(pdev);
+
+	netdev = devm_alloc_etherdev_mqs(&pdev->dev,
+					 sizeof(struct wx),
+					 NGBEVF_MAX_TX_QUEUES,
+					 NGBEVF_MAX_RX_QUEUES);
+	if (!netdev) {
+		err = -ENOMEM;
+		goto err_pci_release_regions;
+	}
+
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+
+	wx = netdev_priv(netdev);
+	wx->netdev = netdev;
+	wx->pdev = pdev;
+
+	wx->msg_enable = netif_msg_init(-1, NETIF_MSG_DRV |
+					NETIF_MSG_PROBE | NETIF_MSG_LINK);
+	wx->hw_addr = devm_ioremap(&pdev->dev,
+				   pci_resource_start(pdev, 0),
+				   pci_resource_len(pdev, 0));
+	if (!wx->hw_addr) {
+		err = -EIO;
+		goto err_pci_release_regions;
+	}
+
+	netdev->features |= NETIF_F_HIGHDMA;
+	pci_set_drvdata(pdev, wx);
+
+	return 0;
+
+err_pci_release_regions:
+	pci_release_selected_regions(pdev,
+				     pci_select_bars(pdev, IORESOURCE_MEM));
+err_pci_disable_dev:
+	pci_disable_device(pdev);
+	return err;
+}
+
+/**
+ * ngbevf_remove - Device Removal Routine
+ * @pdev: PCI device information struct
+ *
+ * ngbevf_remove is called by the PCI subsystem to alert the driver
+ * that it should release a PCI device.  The could be caused by a
+ * Hot-Plug event, or because the driver is going to be removed from
+ * memory.
+ **/
+static void ngbevf_remove(struct pci_dev *pdev)
+{
+	wxvf_remove(pdev);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ngbevf_pm_ops, wxvf_suspend, wxvf_resume);
+
+static struct pci_driver ngbevf_driver = {
+	.name     = KBUILD_MODNAME,
+	.id_table = ngbevf_pci_tbl,
+	.probe    = ngbevf_probe,
+	.remove   = ngbevf_remove,
+	.shutdown = wxvf_shutdown,
+	/* Power Management Hooks */
+	.driver.pm	= pm_sleep_ptr(&ngbevf_pm_ops)
+};
+
+module_pci_driver(ngbevf_driver);
+
+MODULE_DEVICE_TABLE(pci, ngbevf_pci_tbl);
+MODULE_AUTHOR("Beijing WangXun Technology Co., Ltd, <software@trustnetic.com>");
+MODULE_DESCRIPTION("WangXun(R) Gigabit PCI Express Network Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
new file mode 100644
index 000000000000..c71a244ec6b9
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_type.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _NGBEVF_TYPE_H_
+#define _NGBEVF_TYPE_H_
+
+/* Device IDs */
+#define NGBEVF_DEV_ID_EM_WX1860AL_W             0x0110
+#define NGBEVF_DEV_ID_EM_WX1860A2               0x0111
+#define NGBEVF_DEV_ID_EM_WX1860A2S              0x0112
+#define NGBEVF_DEV_ID_EM_WX1860A4               0x0113
+#define NGBEVF_DEV_ID_EM_WX1860A4S              0x0114
+#define NGBEVF_DEV_ID_EM_WX1860AL2              0x0115
+#define NGBEVF_DEV_ID_EM_WX1860AL2S             0x0116
+#define NGBEVF_DEV_ID_EM_WX1860AL4              0x0117
+#define NGBEVF_DEV_ID_EM_WX1860AL4S             0x0118
+#define NGBEVF_DEV_ID_EM_WX1860NCSI             0x0119
+#define NGBEVF_DEV_ID_EM_WX1860A1               0x011a
+#define NGBEVF_DEV_ID_EM_WX1860AL1              0x011b
+
+#define NGBEVF_MAX_RX_QUEUES                  1
+#define NGBEVF_MAX_TX_QUEUES                  1
+
+#endif /* _NGBEVF_TYPE_H_ */
-- 
2.30.1


