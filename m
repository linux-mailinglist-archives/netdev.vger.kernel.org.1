Return-Path: <netdev+bounces-152900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8149F63F1
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A9188BBFC
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DE919ABC2;
	Wed, 18 Dec 2024 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="VG8+2bYg"
X-Original-To: netdev@vger.kernel.org
Received: from lf-1-33.ptr.blmpb.com (lf-1-33.ptr.blmpb.com [103.149.242.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC21946B8
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519242; cv=none; b=FDb+xBR96AwZqsSUfx2S5QftKrEiEbzJTs4JC2KnWxuEH0jgWKxmMkgY0jYRpC1Tkswv1Xma+0F5IJYTs/uKdKJ6ucUqx3Hf3FrI05GnLL7oSm0fDmvGFJ7cgzbQffna9tSedcGsd94F5PEE3/znoZdgD7JWUnAFScv3boVzvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519242; c=relaxed/simple;
	bh=WnX8mgq2T06QCqPE2GXs4KwN6pSTsHJfbpRpz1E7Tz8=;
	h=In-Reply-To:To:Cc:Subject:Message-Id:Content-Type:From:Date:
	 Mime-Version:References; b=DVBTJ+DJUjl1/OdqqRDJJpSEH+Ylq5umCJybTrphlq/xcEfMmr8mjKQYwxXV9PvsU1mH7NOJ/gqRnFH0m1ShonNInqTlQ2WL6kYn1HUCb0SOM8wUtYFDQJIa8I/YItvEEyrUyEI2RoJDX4uIqMBSv/0zUEqe1IuGhrgLM3KP9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=VG8+2bYg; arc=none smtp.client-ip=103.149.242.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734519027; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=vynbOgFOWyJkYcvlUkPIfSCJqXEWF+/jpX1X8B9jVas=;
 b=VG8+2bYggQJ7ReDfhA+qbfnaNQiPw8rPInS5DH/IfYtq9JdHHRAOXurU8vKq4OqtLLRkjQ
 zthjvmPcwaWU4DLSqphdokp8efEGdICcJ8vgzRR3P3dHg418BP5BRjGKcqaGL9pGQtTZx8
 ZWaQDJc3H18RFybXbFQ+DgaxSsMJW77keFXtqieTqUaLhIetsj1Kk0bfdXMowhUIUKowxX
 Qm5qy3105rzgYepa4coJ0jnpMuUNq78HobmTz5XmPEKnihieT4EuyNO4nVATha0uqQmzTX
 4FvcvFJYZqCR2vknfy68Qonhd3zZV8vvuSe7z9bHWozCuak2kDx48M5kFZFNSQ==
In-Reply-To: <20241218105023.2237645-1-tianx@yunsilicon.com>
To: <netdev@vger.kernel.org>
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Subject: [PATCH v1 01/16] net-next/yunsilicon: Add xsc driver basic framework
Message-Id: <20241218105023.2237645-2-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 18:50:24 +0800
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
From: "Xin Tian" <tianx@yunsilicon.com>
Date: Wed, 18 Dec 2024 18:50:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Xin Tian <tianx@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+26762a8f1+49fc25+vger.kernel.org+tianx@yunsilicon.com>
References: <20241218105023.2237645-1-tianx@yunsilicon.com>

Add yunsilicon xsc driver basic framework, including xsc_pci driver
and xsc_eth driver

 
Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
Co-developed-by: Lei Yan <Jacky@yunsilicon.com>
Signed-off-by: Xin Tian <tianx@yunsilicon.com>
---
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/yunsilicon/Kconfig       |  26 ++
 drivers/net/ethernet/yunsilicon/Makefile      |   8 +
 .../ethernet/yunsilicon/xsc/common/xsc_core.h | 132 +++++++++
 .../net/ethernet/yunsilicon/xsc/net/Kconfig   |  16 ++
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |   9 +
 .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |  16 ++
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   9 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    | 272 ++++++++++++++++++
 10 files changed, 490 insertions(+)
 create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c

diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 0baac25db..aa6016597 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -82,6 +82,7 @@ source "drivers/net/ethernet/i825xx/Kconfig"
 source "drivers/net/ethernet/ibm/Kconfig"
 source "drivers/net/ethernet/intel/Kconfig"
 source "drivers/net/ethernet/xscale/Kconfig"
+source "drivers/net/ethernet/yunsilicon/Kconfig"
 
 config JME
 	tristate "JMicron(R) PCI-Express Gigabit Ethernet support"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index c03203439..c16c34d4b 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_NET_VENDOR_INTEL) += intel/
 obj-$(CONFIG_NET_VENDOR_I825XX) += i825xx/
 obj-$(CONFIG_NET_VENDOR_MICROSOFT) += microsoft/
 obj-$(CONFIG_NET_VENDOR_XSCALE) += xscale/
+obj-$(CONFIG_NET_VENDOR_YUNSILICON) += yunsilicon/
 obj-$(CONFIG_JME) += jme.o
 obj-$(CONFIG_KORINA) += korina.o
 obj-$(CONFIG_LANTIQ_ETOP) += lantiq_etop.o
diff --git a/drivers/net/ethernet/yunsilicon/Kconfig b/drivers/net/ethernet/yunsilicon/Kconfig
new file mode 100644
index 000000000..c766390b4
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+# Yunsilicon driver configuration
+#
+
+config NET_VENDOR_YUNSILICON
+	bool "Yunsilicon devices"
+	default y
+	depends on PCI || NET
+	depends on ARM64 || X86_64
+	help
+	  If you have a network (Ethernet) device belonging to this class,
+	  say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Yunsilicon cards. If you say Y, you will be asked
+	  for your specific card in the following questions.
+
+if NET_VENDOR_YUNSILICON
+
+source "drivers/net/ethernet/yunsilicon/xsc/net/Kconfig"
+source "drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig"
+
+endif # NET_VENDOR_YUNSILICON
diff --git a/drivers/net/ethernet/yunsilicon/Makefile b/drivers/net/ethernet/yunsilicon/Makefile
new file mode 100644
index 000000000..6fc8259a7
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+# Makefile for the Yunsilicon device drivers.
+#
+
+# obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc/net/
+obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc/pci/
\ No newline at end of file
diff --git a/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
new file mode 100644
index 000000000..5ed12760e
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#ifndef XSC_CORE_H
+#define XSC_CORE_H
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+extern unsigned int xsc_log_level;
+
+#define XSC_PCI_VENDOR_ID		0x1f67
+
+#define XSC_MC_PF_DEV_ID		0x1011
+#define XSC_MC_VF_DEV_ID		0x1012
+#define XSC_MC_PF_DEV_ID_DIAMOND	0x1021
+
+#define XSC_MF_HOST_PF_DEV_ID		0x1051
+#define XSC_MF_HOST_VF_DEV_ID		0x1052
+#define XSC_MF_SOC_PF_DEV_ID		0x1053
+
+#define XSC_MS_PF_DEV_ID		0x1111
+#define XSC_MS_VF_DEV_ID		0x1112
+
+#define XSC_MV_HOST_PF_DEV_ID		0x1151
+#define XSC_MV_HOST_VF_DEV_ID		0x1152
+#define XSC_MV_SOC_PF_DEV_ID		0x1153
+
+enum {
+	XSC_LOG_LEVEL_DBG	= 0,
+	XSC_LOG_LEVEL_INFO	= 1,
+	XSC_LOG_LEVEL_WARN	= 2,
+	XSC_LOG_LEVEL_ERR	= 3,
+};
+
+#define xsc_dev_log(condition, level, dev, fmt, ...)			\
+do {									\
+	if (condition)							\
+		dev_printk(level, dev, dev_fmt(fmt), ##__VA_ARGS__);	\
+} while (0)
+
+#define xsc_core_dbg(__dev, format, ...)				\
+	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_DBG, KERN_DEBUG,	\
+		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
+		__func__, __LINE__, current->pid, ##__VA_ARGS__)
+
+#define xsc_core_dbg_once(__dev, format, ...)				\
+	dev_dbg_once(&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,	\
+		     __func__, __LINE__, current->pid,			\
+		     ##__VA_ARGS__)
+
+#define xsc_core_dbg_mask(__dev, mask, format, ...)			\
+do {									\
+	if ((mask) & xsc_debug_mask)					\
+		xsc_core_dbg(__dev, format, ##__VA_ARGS__);		\
+} while (0)
+
+#define xsc_core_err(__dev, format, ...)				\
+	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_ERR, KERN_ERR,	\
+		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
+		__func__, __LINE__, current->pid, ##__VA_ARGS__)
+
+#define xsc_core_err_rl(__dev, format, ...)				\
+	dev_err_ratelimited(&(__dev)->pdev->dev,			\
+			   "%s:%d:(pid %d): " format,			\
+			   __func__, __LINE__, current->pid,		\
+			   ##__VA_ARGS__)
+
+#define xsc_core_warn(__dev, format, ...)				\
+	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_WARN, KERN_WARNING,	\
+		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
+		__func__, __LINE__, current->pid, ##__VA_ARGS__)
+
+#define xsc_core_info(__dev, format, ...)				\
+	xsc_dev_log(xsc_log_level <= XSC_LOG_LEVEL_INFO, KERN_INFO,	\
+		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
+		__func__, __LINE__, current->pid, ##__VA_ARGS__)
+
+#define xsc_pr_debug(format, ...)					\
+do {									\
+	if (xsc_log_level <= XSC_LOG_LEVEL_DBG)				\
+		pr_debug(format, ##__VA_ARGS__);		\
+} while (0)
+
+#define assert(__dev, expr)						\
+do {									\
+	if (!(expr)) {							\
+		dev_err(&(__dev)->pdev->dev,				\
+		"Assertion failed! %s, %s, %s, line %d\n",		\
+		#expr, __FILE__, __func__, __LINE__);			\
+	}								\
+} while (0)
+
+enum {
+	XSC_MAX_NAME_LEN = 32,
+};
+
+struct xsc_dev_resource {
+	struct mutex alloc_mutex;	/* protect buffer alocation according to numa node */
+};
+
+enum xsc_pci_state {
+	XSC_PCI_STATE_DISABLED,
+	XSC_PCI_STATE_ENABLED,
+};
+
+struct xsc_priv {
+	char			name[XSC_MAX_NAME_LEN];
+	struct list_head	dev_list;
+	struct list_head	ctx_list;
+	spinlock_t		ctx_lock;	/* protect ctx_list */
+	int			numa_node;
+};
+
+struct xsc_core_device {
+	struct pci_dev		*pdev;
+	struct device		*device;
+	struct xsc_priv		priv;
+	struct xsc_dev_resource	*dev_res;
+
+	void __iomem		*bar;
+	int			bar_num;
+
+	struct mutex		pci_state_mutex;	/* protect pci_state */
+	enum xsc_pci_state	pci_state;
+	struct mutex		intf_state_mutex;	/* protect intf_state */
+	unsigned long		intf_state;
+};
+
+#endif
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
new file mode 100644
index 000000000..0d9a4ff8a
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+# Yunsilicon driver configuration
+#
+
+config YUNSILICON_XSC_ETH
+	tristate "Yunsilicon XSC ethernet driver"
+	default n
+	depends on YUNSILICON_XSC_PCI
+	help
+	  This driver provides ethernet support for
+	  Yunsilicon XSC devices.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called xsc_eth.
diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/Makefile b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
new file mode 100644
index 000000000..2811433af
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/net/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+
+ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
+
+obj-$(CONFIG_YUNSILICON_XSC_ETH) += xsc_eth.o
+
+xsc_eth-y := main.o
\ No newline at end of file
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
new file mode 100644
index 000000000..2b6d79905
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+# Yunsilicon PCI configuration
+#
+
+config YUNSILICON_XSC_PCI
+	tristate "Yunsilicon XSC PCI driver"
+	default n
+	select PAGE_POOL
+	help
+	  This driver is common for Yunsilicon XSC
+	  ethernet and RDMA drivers.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called xsc_pci.
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
new file mode 100644
index 000000000..709270df8
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+# All rights reserved.
+
+ccflags-y += -I$(srctree)/drivers/net/ethernet/yunsilicon/xsc
+
+obj-$(CONFIG_YUNSILICON_XSC_PCI) += xsc_pci.o
+
+xsc_pci-y := main.o
diff --git a/drivers/net/ethernet/yunsilicon/xsc/pci/main.c b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
new file mode 100644
index 000000000..cbe0bfbd1
--- /dev/null
+++ b/drivers/net/ethernet/yunsilicon/xsc/pci/main.c
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2021-2025, Shanghai Yunsilicon Technology Co., Ltd.
+ * All rights reserved.
+ */
+
+#include "common/xsc_core.h"
+
+unsigned int xsc_log_level = XSC_LOG_LEVEL_WARN;
+module_param_named(log_level, xsc_log_level, uint, 0644);
+MODULE_PARM_DESC(log_level,
+		 "lowest log level to print: 0=debug, 1=info, 2=warning, 3=error. Default=1");
+EXPORT_SYMBOL(xsc_log_level);
+
+#define XSC_PCI_DRV_DESC	"Yunsilicon Xsc PCI driver"
+
+static const struct pci_device_id xsc_pci_id_table[] = {
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MC_PF_DEV_ID_DIAMOND) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_HOST_PF_DEV_ID) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MF_SOC_PF_DEV_ID) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MS_PF_DEV_ID) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_HOST_PF_DEV_ID) },
+	{ PCI_DEVICE(XSC_PCI_VENDOR_ID, XSC_MV_SOC_PF_DEV_ID) },
+	{ 0 }
+};
+
+static int set_dma_caps(struct pci_dev *pdev)
+{
+	int err;
+
+	err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (err)
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	else
+		err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+
+	if (!err)
+		dma_set_max_seg_size(&pdev->dev, SZ_2G);
+
+	return err;
+}
+
+static int xsc_pci_enable_device(struct xsc_core_device *xdev)
+{
+	struct pci_dev *pdev = xdev->pdev;
+	int err = 0;
+
+	mutex_lock(&xdev->pci_state_mutex);
+	if (xdev->pci_state == XSC_PCI_STATE_DISABLED) {
+		err = pci_enable_device(pdev);
+		if (!err)
+			xdev->pci_state = XSC_PCI_STATE_ENABLED;
+	}
+	mutex_unlock(&xdev->pci_state_mutex);
+
+	return err;
+}
+
+static void xsc_pci_disable_device(struct xsc_core_device *xdev)
+{
+	struct pci_dev *pdev = xdev->pdev;
+
+	mutex_lock(&xdev->pci_state_mutex);
+	if (xdev->pci_state == XSC_PCI_STATE_ENABLED) {
+		pci_disable_device(pdev);
+		xdev->pci_state = XSC_PCI_STATE_DISABLED;
+	}
+	mutex_unlock(&xdev->pci_state_mutex);
+}
+
+static int xsc_pci_init(struct xsc_core_device *xdev, const struct pci_device_id *id)
+{
+	struct pci_dev *pdev = xdev->pdev;
+	void __iomem *bar_base;
+	int bar_num = 0;
+	int err;
+
+	mutex_init(&xdev->pci_state_mutex);
+	xdev->priv.numa_node = dev_to_node(&pdev->dev);
+
+	err = xsc_pci_enable_device(xdev);
+	if (err) {
+		xsc_core_err(xdev, "failed to enable PCI device: err=%d\n", err);
+		goto err_ret;
+	}
+
+	err = pci_request_region(pdev, bar_num, KBUILD_MODNAME);
+	if (err) {
+		xsc_core_err(xdev, "failed to request %s pci_region=%d: err=%d\n",
+			     KBUILD_MODNAME, bar_num, err);
+		goto err_disable;
+	}
+
+	pci_set_master(pdev);
+
+	err = set_dma_caps(pdev);
+	if (err) {
+		xsc_core_err(xdev, "failed to set DMA capabilities mask: err=%d\n", err);
+		goto err_clr_master;
+	}
+
+	bar_base = pci_ioremap_bar(pdev, bar_num);
+	if (!bar_base) {
+		xsc_core_err(xdev, "failed to ioremap %s bar%d\n", KBUILD_MODNAME, bar_num);
+		goto err_clr_master;
+	}
+
+	err = pci_save_state(pdev);
+	if (err) {
+		xsc_core_err(xdev, "pci_save_state failed: err=%d\n", err);
+		goto err_io_unmap;
+	}
+
+	xdev->bar_num = bar_num;
+	xdev->bar = bar_base;
+
+	return 0;
+
+err_io_unmap:
+	pci_iounmap(pdev, bar_base);
+err_clr_master:
+	pci_clear_master(pdev);
+	pci_release_region(pdev, bar_num);
+err_disable:
+	xsc_pci_disable_device(xdev);
+err_ret:
+	return err;
+}
+
+static void xsc_pci_fini(struct xsc_core_device *xdev)
+{
+	struct pci_dev *pdev = xdev->pdev;
+
+	if (xdev->bar)
+		pci_iounmap(pdev, xdev->bar);
+	pci_clear_master(pdev);
+	pci_release_region(pdev, xdev->bar_num);
+	xsc_pci_disable_device(xdev);
+}
+
+static int xsc_priv_init(struct xsc_core_device *xdev)
+{
+	struct xsc_priv *priv = &xdev->priv;
+
+	strscpy(priv->name, dev_name(&xdev->pdev->dev), XSC_MAX_NAME_LEN);
+
+	INIT_LIST_HEAD(&priv->ctx_list);
+	spin_lock_init(&priv->ctx_lock);
+	mutex_init(&xdev->intf_state_mutex);
+
+	return 0;
+}
+
+static int xsc_dev_res_init(struct xsc_core_device *xdev)
+{
+	struct xsc_dev_resource *dev_res;
+
+	dev_res = kvzalloc(sizeof(*dev_res), GFP_KERNEL);
+	if (!dev_res)
+		return -ENOMEM;
+
+	xdev->dev_res = dev_res;
+	mutex_init(&dev_res->alloc_mutex);
+
+	return 0;
+}
+
+static void xsc_dev_res_cleanup(struct xsc_core_device *xdev)
+{
+	kfree(xdev->dev_res);
+}
+
+static int xsc_core_dev_init(struct xsc_core_device *xdev)
+{
+	int err;
+
+	xsc_priv_init(xdev);
+
+	err = xsc_dev_res_init(xdev);
+	if (err) {
+		xsc_core_err(xdev, "xsc dev res init failed %d\n", err);
+		goto out;
+	}
+
+	return 0;
+out:
+	return err;
+}
+
+static void xsc_core_dev_cleanup(struct xsc_core_device *xdev)
+{
+	xsc_dev_res_cleanup(xdev);
+}
+
+static int xsc_pci_probe(struct pci_dev *pci_dev,
+			 const struct pci_device_id *id)
+{
+	struct xsc_core_device *xdev;
+	int err;
+
+	xdev = kzalloc(sizeof(*xdev), GFP_KERNEL);
+	if (!xdev)
+		return -ENOMEM;
+
+	xdev->pdev = pci_dev;
+	xdev->device = &pci_dev->dev;
+
+	pci_set_drvdata(pci_dev, xdev);
+	err = xsc_pci_init(xdev, id);
+	if (err) {
+		xsc_core_err(xdev, "xsc_pci_init failed %d\n", err);
+		goto err_unset_pci_drvdata;
+	}
+
+	err = xsc_core_dev_init(xdev);
+	if (err) {
+		xsc_core_err(xdev, "xsc_core_dev_init failed %d\n", err);
+		goto err_pci_fini;
+	}
+
+	return 0;
+err_pci_fini:
+	xsc_pci_fini(xdev);
+err_unset_pci_drvdata:
+	pci_set_drvdata(pci_dev, NULL);
+	kfree(xdev);
+
+	return err;
+}
+
+static void xsc_pci_remove(struct pci_dev *pci_dev)
+{
+	struct xsc_core_device *xdev = pci_get_drvdata(pci_dev);
+
+	xsc_core_dev_cleanup(xdev);
+	xsc_pci_fini(xdev);
+	pci_set_drvdata(pci_dev, NULL);
+	kfree(xdev);
+}
+
+static struct pci_driver xsc_pci_driver = {
+	.name		= "xsc-pci",
+	.id_table	= xsc_pci_id_table,
+	.probe		= xsc_pci_probe,
+	.remove		= xsc_pci_remove,
+};
+
+static int __init xsc_init(void)
+{
+	int err;
+
+	err = pci_register_driver(&xsc_pci_driver);
+	if (err) {
+		pr_err("failed to register pci driver\n");
+		goto out;
+	}
+	return 0;
+
+out:
+	return err;
+}
+
+static void __exit xsc_fini(void)
+{
+	pci_unregister_driver(&xsc_pci_driver);
+}
+
+module_init(xsc_init);
+module_exit(xsc_fini);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION(XSC_PCI_DRV_DESC);
-- 
2.43.0

