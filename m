Return-Path: <netdev+bounces-196462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7CAD4E93
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631963A8785
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8A423D2BD;
	Wed, 11 Jun 2025 08:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D116923ABAF
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631048; cv=none; b=txZrq4P0opT7+59EcDiMmaUBZu+WtH4ffsPWgly8kQX3Y5/dAtzrJy2bzlP3kFoGXfPDRwL3rYzxK4r/chbIiinVsPN2Bu+XvNMlZr8UEcce35kdcwEKCj6eWmLtaRZf1ScsEsNhBoTJRqzm4dum+mxWCZvFlCMp/ixeEVqVH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631048; c=relaxed/simple;
	bh=AwMpviDhMZvBfVu/EW95htHCw45qLXh8FQQQ5bu2SQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ILtTIP66CIW2X+PBmtok5xtNrpoomPR4wiEFmwJzUKlqSeVhn4sIGSJQOLTb0D27umM/c01t0KN8xoZwbXdBpA1V69CgC+97/pDsvHgZk8xndEX1rGlcvNJ/ylZ80rylnfPZgWNiHb+H6/j5PBmEr4w+qAcp04JHAgLW6zwHDrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630974ta5a37027
X-QQ-Originating-IP: Q3AgSnxdS9hzeEA1x0WyaWTVswSECiBwk3S9Fx8C+VI=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3862933459380285957
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
Subject: [PATCH net-next 04/12] net: wangxun: add txgbevf build
Date: Wed, 11 Jun 2025 16:35:51 +0800
Message-Id: <20250611083559.14175-5-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: M0CLMknQ4bm36AzS2ZSCh2E/BL+Y9pmw5foVvJx7Wt83AKVqXvDxkloa
	x6o+zY7UUgWNay77MizzXY8Zq3As1p675HPq+B9HB5mvuM94GKI+HoO6ofiBBsszBQ+f09/
	6EhXb2polncWXpnqSSsn62iTlML/HD3dJ3soEe88Xw88tWLfWT79cAZWQ3glKt4LqRD+3F/
	fVwHHDxTKRyyEtcP46VGKZrIndCkRuawcaDgiBv37FrGS0oPlxbnYxtDPYx5N9O8JcYoPqe
	JIJtz4vv1kixX9hrnP1aoCFtcmXDu/noo2rkc7udca6WFLzqPNnaQfT3d4u3MYcZvh4/GA/
	4R0O/6o4mBQQPeQvybMQJCqWVig0X0Q9pb3iRXXYsjmFxV5yQ3FLgTIEI6qytq1PHEovQAo
	2WH4lsnoR33rrNjlfdOR9d4xEnyPiU1tzt9lOgcLM1ypEBsUZ9blqwwkT+8VvfseUqDkYWV
	yl6oDZmyzUeHg+zRh4DBda0OmXtyimVNNykuNrO74yQFIkvuEYyB7RWVKgmG1WhuWNHrYOm
	5gsIGaVHLGh+htVFrXJDGlYBCkr5a9sby12Ul5CpJvVQK/hCbcOcNEvSK7+cvHX87D+avye
	fkl+09KFc4KS4H2GtzIy88ybBu4qpzpLKEspjKxyvMXyxftPMYSEUS+LOlJiGehYM4tyfaA
	XCzb6QqvbzMUrNiDFRCg2vg0N/x0KS5REYCr/ZJA5gaGRG2Eb5/KHp4nltv3mn003QR6Lxf
	JVCz0aeG95qUiq3S8jx3YFgwUc6qmQ7miUQPy7XKiVjKuuQAPQEAUSpFKJ/j+EG/f4Lgaog
	2aAwKx8Myj+9x+g+wKUB6a5L4YoTA+IV5pUK8xQmW2SejLoAXf4iXERmhDZMJoQkqN+SJOf
	RWL0lotRIJrpqciueMakMa/5DiSURjBKam0gMW1eFtOnFvmp1sePCHj7yi6zMpGcr7gYKaz
	gTeSHmY4HEH14FAhH4N3ZAhLBiTxXvsbUu268VsHkMDXjZ0ALpMX92u7TnIp4Nqbx1JXAUe
	Oi6Q+dXZz+uqyBF1VjcWgkgHt8IKUeqfRQdKX8o1hxicDhTXZb0hhA6khkp62G3bMBFCHDD
	k9T7Uv3gC6CIXXYxplUb1OKqm6wOupWXQq2alV7x/JB
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Add doc build infrastructure for txgbevf driver.
Implement the basic PCI driver loading and unloading interface.
Initialize the id_table which support 10/25/40G virtual
functions for Wangxun.
Ioremap the space of bar0 and bar4 which will be used.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../device_drivers/ethernet/index.rst         |   1 +
 .../ethernet/wangxun/txgbevf.rst              |  16 ++
 drivers/net/ethernet/wangxun/Kconfig          |  18 ++
 drivers/net/ethernet/wangxun/Makefile         |   1 +
 .../net/ethernet/wangxun/libwx/wx_vf_common.c |  38 +++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |   4 +
 drivers/net/ethernet/wangxun/txgbevf/Makefile |   9 +
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   | 154 ++++++++++++++++++
 .../ethernet/wangxun/txgbevf/txgbevf_type.h   |  20 +++
 9 files changed, 261 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/Makefile
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
 create mode 100644 drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 139b4c75a191..e93453410772 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -58,6 +58,7 @@ Contents:
    ti/tlan
    ti/icssg_prueth
    wangxun/txgbe
+   wangxun/txgbevf
    wangxun/ngbe
 
 .. only::  subproject and html
diff --git a/Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst b/Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst
new file mode 100644
index 000000000000..b2f759b7b518
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+===========================================================================
+Linux Base Virtual Function Driver for Wangxun(R) 10/25/40 Gigabit Ethernet
+===========================================================================
+
+WangXun 10/25/40 Gigabit Virtual Function Linux driver.
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
index e5fc942c28cc..a6ec73e4f300 100644
--- a/drivers/net/ethernet/wangxun/Kconfig
+++ b/drivers/net/ethernet/wangxun/Kconfig
@@ -64,4 +64,22 @@ config TXGBE
 	  To compile this driver as a module, choose M here. The module
 	  will be called txgbe.
 
+config TXGBEVF
+	tristate "Wangxun(R) 10/25/40G Virtual Function Ethernet support"
+	depends on PCI
+	depends on PCI_MSI
+	select LIBWX
+	select PHYLINK
+	help
+	  This driver supports virtual functions for SP1000A, WX1820AL,
+	  WX5XXX, WX5XXXAL.
+
+	  This driver was formerly named txgbevf.
+
+	  More specific information on configuring the driver is in
+	  <file:Documentation/networking/device_drivers/ethernet/wangxun/txgbevf.rst>.
+
+	  To compile this driver as a module, choose M here. MSI-X interrupt
+	  support is required for this driver to work correctly.
+
 endif # NET_VENDOR_WANGXUN
diff --git a/drivers/net/ethernet/wangxun/Makefile b/drivers/net/ethernet/wangxun/Makefile
index ca19311dbe38..71371d47a6ee 100644
--- a/drivers/net/ethernet/wangxun/Makefile
+++ b/drivers/net/ethernet/wangxun/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_LIBWX) += libwx/
 obj-$(CONFIG_TXGBE) += txgbe/
+obj-$(CONFIG_TXGBEVF) += txgbevf/
 obj-$(CONFIG_NGBE) += ngbe/
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 861adf97e801..6619a7abd1d8 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -11,6 +11,44 @@
 #include "wx_vf_lib.h"
 #include "wx_vf_common.h"
 
+int wxvf_suspend(struct device *dev_d)
+{
+	struct pci_dev *pdev = to_pci_dev(dev_d);
+	struct wx *wx = pci_get_drvdata(pdev);
+
+	netif_device_detach(wx->netdev);
+	pci_disable_device(pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL(wxvf_suspend);
+
+void wxvf_shutdown(struct pci_dev *pdev)
+{
+	wxvf_suspend(&pdev->dev);
+}
+EXPORT_SYMBOL(wxvf_shutdown);
+
+int wxvf_resume(struct device *dev_d)
+{
+	struct pci_dev *pdev = to_pci_dev(dev_d);
+	struct wx *wx = pci_get_drvdata(pdev);
+
+	pci_set_master(pdev);
+	netif_device_attach(wx->netdev);
+
+	return 0;
+}
+EXPORT_SYMBOL(wxvf_resume);
+
+void wxvf_remove(struct pci_dev *pdev)
+{
+	pci_release_selected_regions(pdev,
+				     pci_select_bars(pdev, IORESOURCE_MEM));
+	pci_disable_device(pdev);
+}
+EXPORT_SYMBOL(wxvf_remove);
+
 static irqreturn_t wx_msix_misc_vf(int __always_unused irq, void *data)
 {
 	struct wx *wx = data;
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
index 9bee9de86cb2..f3b31f33407b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -4,6 +4,10 @@
 #ifndef _WX_VF_COMMON_H_
 #define _WX_VF_COMMON_H_
 
+int wxvf_suspend(struct device *dev_d);
+void wxvf_shutdown(struct pci_dev *pdev);
+int wxvf_resume(struct device *dev_d);
+void wxvf_remove(struct pci_dev *pdev);
 int wx_request_msix_irqs_vf(struct wx *wx);
 void wx_negotiate_api_vf(struct wx *wx);
 void wx_reset_vf(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/txgbevf/Makefile b/drivers/net/ethernet/wangxun/txgbevf/Makefile
new file mode 100644
index 000000000000..4c7e6de04424
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbevf/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd.
+#
+# Makefile for the Wangxun(R) 10/25/40GbE virtual functions driver
+#
+
+obj-$(CONFIG_TXGBE) += txgbevf.o
+
+txgbevf-objs := txgbevf_main.o
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
new file mode 100644
index 000000000000..9e8ddec36913
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -0,0 +1,154 @@
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
+#include "txgbevf_type.h"
+
+/* txgbevf_pci_tbl - PCI Device ID Table
+ *
+ * Wildcard entries (PCI_ANY_ID) should come last
+ * Last entry must be all 0s
+ *
+ * { Vendor ID, Device ID, SubVendor ID, SubDevice ID,
+ *   Class, Class Mask, private data (not used) }
+ */
+static const struct pci_device_id txgbevf_pci_tbl[] = {
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_SP1000), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_WX1820), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML500F), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML510F), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML5024), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML5124), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML503F), 0},
+	{ PCI_VDEVICE(WANGXUN, TXGBEVF_DEV_ID_AML513F), 0},
+	/* required last entry */
+	{ .device = 0 }
+};
+
+/**
+ * txgbevf_probe - Device Initialization Routine
+ * @pdev: PCI device information struct
+ * @ent: entry in txgbevf_pci_tbl
+ *
+ * Return: return 0 on success, negative on failure
+ *
+ * txgbevf_probe initializes an adapter identified by a pci_dev structure.
+ * The OS initialization, configuring of the adapter private structure,
+ * and a hardware reset occur.
+ **/
+static int txgbevf_probe(struct pci_dev *pdev,
+			 const struct pci_device_id __always_unused *ent)
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
+					 TXGBEVF_MAX_TX_QUEUES,
+					 TXGBEVF_MAX_RX_QUEUES);
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
+	wx->b4_addr = devm_ioremap(&pdev->dev,
+				   pci_resource_start(pdev, 4),
+				   pci_resource_len(pdev, 4));
+	if (!wx->b4_addr) {
+		err = -EIO;
+		goto err_pci_release_regions;
+	}
+
+	netdev->features |= NETIF_F_HIGHDMA;
+
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
+ * txgbevf_remove - Device Removal Routine
+ * @pdev: PCI device information struct
+ *
+ * txgbevf_remove is called by the PCI subsystem to alert the driver
+ * that it should release a PCI device.  The could be caused by a
+ * Hot-Plug event, or because the driver is going to be removed from
+ * memory.
+ **/
+static void txgbevf_remove(struct pci_dev *pdev)
+{
+	wxvf_remove(pdev);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(txgbevf_pm_ops, wxvf_suspend, wxvf_resume);
+
+static struct pci_driver txgbevf_driver = {
+	.name     = KBUILD_MODNAME,
+	.id_table = txgbevf_pci_tbl,
+	.probe    = txgbevf_probe,
+	.remove   = txgbevf_remove,
+	.shutdown = wxvf_shutdown,
+	/* Power Management Hooks */
+	.driver.pm	= pm_sleep_ptr(&txgbevf_pm_ops)
+};
+
+module_pci_driver(txgbevf_driver);
+
+MODULE_DEVICE_TABLE(pci, txgbevf_pci_tbl);
+MODULE_AUTHOR("Beijing WangXun Technology Co., Ltd, <software@trustnetic.com>");
+MODULE_DESCRIPTION("WangXun(R) 10/25/40 Gigabit Virtual Function Network Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
new file mode 100644
index 000000000000..2ba9d0cb63d5
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_type.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _TXGBEVF_TYPE_H_
+#define _TXGBEVF_TYPE_H_
+
+/* Device IDs */
+#define TXGBEVF_DEV_ID_SP1000                  0x1000
+#define TXGBEVF_DEV_ID_WX1820                  0x2000
+#define TXGBEVF_DEV_ID_AML500F                 0x500F
+#define TXGBEVF_DEV_ID_AML510F                 0x510F
+#define TXGBEVF_DEV_ID_AML5024                 0x5024
+#define TXGBEVF_DEV_ID_AML5124                 0x5124
+#define TXGBEVF_DEV_ID_AML503F                 0x503f
+#define TXGBEVF_DEV_ID_AML513F                 0x513f
+
+#define TXGBEVF_MAX_RX_QUEUES                  4
+#define TXGBEVF_MAX_TX_QUEUES                  4
+
+#endif /* _TXGBEVF_TYPE_H_ */
-- 
2.30.1



