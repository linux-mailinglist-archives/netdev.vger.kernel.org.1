Return-Path: <netdev+bounces-106523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA270916A91
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E65B226F2
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEE9149E05;
	Tue, 25 Jun 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjuahR4G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0D3BB23
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326148; cv=none; b=BjagzG/0/T8Nq2JMBcqD7/KTBQDgXREtMRkuLUN7Wl0rcNgcYnTBed1XemQBiwCiYP41eHsA92QwTC7PI4JDAS/Pux717Z9l2ZNSZ8X3SZm9pXYVUmSp9QaVDE5UsXB4HiH3VPUnGemvsItaqcPr0u3j7h2BhOM/GGkMjQYUIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326148; c=relaxed/simple;
	bh=puOxuhaIsWu+YIgs869hMHvMKrC+bn7EU3NIZhkDbqc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qd7sYEsq5dqZajZKakamx3xCspG26DjIj3FrBD0AO6sInaW42xRzrJ2yPknMS29zMmec8gwCQn6i6zQhSZUBJItPEW2/4L3+XiO3jbFcdAHHuVfhfGAjNfprm7o+3p3JKsE1daBZPNp4HRRkz/xcVdvjw22NOt7zg6xkrjjQ6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjuahR4G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6da06ba24so40821895ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719326146; x=1719930946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3AUCMIkioWrvGvNTagr5M6xjQv0mzKqG1/c0nD8psSQ=;
        b=VjuahR4GDL4tchI/fNezfEgI8+FBx+0/OXgiZpWcuWIJbSITNiPMnQH8EdEKfeEyi7
         zQKboJCCJ2N6E7BCvK+n3RMn9e5iLYnLd/F74urRt21dTlI7GOdEBEFX9U/5oDY7PAY1
         uQ4Vp22yDz8AxvzCoehFxUWRVbKzfmKxUwwLLcq5QWKvjs7ePdySp6WkzjiT3afJs+8U
         B2lKeIGsxaTCtMCY8HGCF/sUnvLP1NEo8ZRhLK7wVy/ayl0u3ML7L5lCg7kKy/Nfqddy
         dAyY4mKVhdlNEy+onCQyTCMwP2+yooIUuT4WOtWJzHqrnbewh2IbbmteTaKODJh/B5wC
         VVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719326146; x=1719930946;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3AUCMIkioWrvGvNTagr5M6xjQv0mzKqG1/c0nD8psSQ=;
        b=wWiKO8h5aw3MD5mBwdCC+Bfvc4zirVmDfzr8cXwzYQflORcsBiBRU9K+ZlmGW4EZjL
         YHMMs0B2GHelFU+Dl/ZFXcaGTBslfJwooslkIyYzMRRsWWzWZNk9cKxDZBuXDSdwFCGP
         uishVi2BEZt8dMnP2mF0a0/+3d7AoUXBsemgHszfECIjzHWmWbNe688dCasKkkNLcfsD
         UimOiGUSv1SpQYpP5eHVgwweceUbkwA6SUUb6P2ApE9apHiitFixNdG3Pg7S4NW98c9z
         kMeLekzvpferc5LfdRM0Fc9sfVKqWReAA6PvBeJQTxNzKorbD0uFaYvMnMbc4ZgXjO88
         5dYQ==
X-Gm-Message-State: AOJu0Yxj5nYrTmUxy1CqaPVsQF1lybas843W2t2WV4rqx9Vljs/1Q0g9
	U1iWxs/y0VOvnF3wbH+GUWj+nvwJo8VtQkrKJT7C8YF3njDBkulo
X-Google-Smtp-Source: AGHT+IFZ9IjqL82HQmRFd+51vEW/rv8UnEkhe9Q8BlY4Bg4xtxnyPOht9GyY+fXOv13txM52MQC1Tg==
X-Received: by 2002:a17:903:2452:b0:1fa:7f7e:2e0b with SMTP id d9443c01a7336-1fa7f7e33a6mr7245245ad.67.1719326145455;
        Tue, 25 Jun 2024 07:35:45 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c591bsm82060565ad.165.2024.06.25.07.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:35:45 -0700 (PDT)
Subject: [net-next PATCH v2 02/15] eth: fbnic: Add scaffolding for Meta's NIC
 driver
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Tue, 25 Jun 2024 07:35:44 -0700
Message-ID: 
 <171932614407.3072535.16320831117421799545.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Create a bare-bones PCI driver for Meta's NIC.
Subsequent changes will flesh it out.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 MAINTAINERS                                     |    7 +
 drivers/net/ethernet/Kconfig                    |    1 
 drivers/net/ethernet/Makefile                   |    1 
 drivers/net/ethernet/meta/Kconfig               |   30 +++
 drivers/net/ethernet/meta/Makefile              |    6 +
 drivers/net/ethernet/meta/fbnic/Makefile        |   10 +
 drivers/net/ethernet/meta/fbnic/fbnic.h         |   19 ++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     |    9 +
 drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c     |  198 +++++++++++++++++++++++
 10 files changed, 286 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/Kconfig
 create mode 100644 drivers/net/ethernet/meta/Makefile
 create mode 100644 drivers/net/ethernet/meta/fbnic/Makefile
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_csr.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e3cb040fc16..42e9e55d161a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14570,6 +14570,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
 F:	drivers/staging/media/meson/vdec/
 
+META ETHERNET DRIVERS
+M:	Alexander Duyck <alexanderduyck@fb.com>
+M:	Jakub Kicinski <kuba@kernel.org>
+R:	kernel-team@meta.com
+S:	Supported
+F:	drivers/net/ethernet/meta/
+
 METHODE UDPU SUPPORT
 M:	Robert Marko <robert.marko@sartura.hr>
 S:	Maintained
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 6a19b5393ed1..0baac25db4f8 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -122,6 +122,7 @@ source "drivers/net/ethernet/litex/Kconfig"
 source "drivers/net/ethernet/marvell/Kconfig"
 source "drivers/net/ethernet/mediatek/Kconfig"
 source "drivers/net/ethernet/mellanox/Kconfig"
+source "drivers/net/ethernet/meta/Kconfig"
 source "drivers/net/ethernet/micrel/Kconfig"
 source "drivers/net/ethernet/microchip/Kconfig"
 source "drivers/net/ethernet/mscc/Kconfig"
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 0d872d4efcd1..c03203439c0e 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_NET_VENDOR_LITEX) += litex/
 obj-$(CONFIG_NET_VENDOR_MARVELL) += marvell/
 obj-$(CONFIG_NET_VENDOR_MEDIATEK) += mediatek/
 obj-$(CONFIG_NET_VENDOR_MELLANOX) += mellanox/
+obj-$(CONFIG_NET_VENDOR_META) += meta/
 obj-$(CONFIG_NET_VENDOR_MICREL) += micrel/
 obj-$(CONFIG_NET_VENDOR_MICROCHIP) += microchip/
 obj-$(CONFIG_NET_VENDOR_MICROSEMI) += mscc/
diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
new file mode 100644
index 000000000000..fbbc38e7e507
--- /dev/null
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Meta Platforms network device configuration
+#
+
+config NET_VENDOR_META
+	bool "Meta Platforms devices"
+	default y
+	help
+	  If you have a network (Ethernet) card designed by Meta, say Y.
+	  That's Meta as in the parent company of Facebook.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Meta cards. If you say Y, you will be asked for
+	  your specific card in the following questions.
+
+if NET_VENDOR_META
+
+config FBNIC
+	tristate "Meta Platforms Host Network Interface"
+	depends on X86_64 || COMPILE_TEST
+	depends on PCI_MSI
+	help
+	  This driver supports Meta Platforms Host Network Interface.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called fbnic.  MSI-X interrupt support is required.
+
+endif # NET_VENDOR_META
diff --git a/drivers/net/ethernet/meta/Makefile b/drivers/net/ethernet/meta/Makefile
new file mode 100644
index 000000000000..88804f3de963
--- /dev/null
+++ b/drivers/net/ethernet/meta/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Meta Platforms network device drivers.
+#
+
+obj-$(CONFIG_FBNIC) += fbnic/
diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
new file mode 100644
index 000000000000..ce277fec875f
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+
+#
+# Makefile for the Meta(R) Host Network Interface
+#
+
+obj-$(CONFIG_FBNIC) += fbnic.o
+
+fbnic-y := fbnic_pci.o
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
new file mode 100644
index 000000000000..25702dab8d66
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _FBNIC_H_
+#define _FBNIC_H_
+
+#include "fbnic_csr.h"
+
+extern char fbnic_driver_name[];
+
+enum fbnic_boards {
+	fbnic_board_asic
+};
+
+struct fbnic_info {
+	unsigned int bar_mask;
+};
+
+#endif /* _FBNIC_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
new file mode 100644
index 000000000000..72e89c07bf54
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _FBNIC_CSR_H_
+#define _FBNIC_CSR_H_
+
+#define PCI_DEVICE_ID_META_FBNIC_ASIC		0x0013
+
+#endif /* _FBNIC_CSR_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h b/drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h
new file mode 100644
index 000000000000..809ba6729442
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#define DRV_NAME "fbnic"
+#define DRV_SUMMARY "Meta(R) Host Network Interface Driver"
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
new file mode 100644
index 000000000000..e860ec3750c3
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "fbnic.h"
+#include "fbnic_drvinfo.h"
+
+char fbnic_driver_name[] = DRV_NAME;
+
+MODULE_DESCRIPTION(DRV_SUMMARY);
+MODULE_LICENSE("GPL");
+
+static const struct fbnic_info fbnic_asic_info = {
+	.bar_mask = BIT(0) | BIT(4)
+};
+
+static const struct fbnic_info *fbnic_info_tbl[] = {
+	[fbnic_board_asic] = &fbnic_asic_info,
+};
+
+static const struct pci_device_id fbnic_pci_tbl[] = {
+	{ PCI_DEVICE_DATA(META, FBNIC_ASIC, fbnic_board_asic) },
+	/* Required last entry */
+	{0, }
+};
+MODULE_DEVICE_TABLE(pci, fbnic_pci_tbl);
+
+/**
+ *  fbnic_probe - Device Initialization Routine
+ *  @pdev: PCI device information struct
+ *  @ent: entry in fbnic_pci_tbl
+ *
+ *  Return: 0 on success, negative on failure
+ *
+ *  Initializes a PCI device identified by a pci_dev structure.
+ *  The OS initialization, configuring of the adapter private structure,
+ *  and a hardware reset occur.
+ **/
+static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	const struct fbnic_info *info = fbnic_info_tbl[ent->driver_data];
+	int err;
+
+	if (pdev->error_state != pci_channel_io_normal) {
+		dev_err(&pdev->dev,
+			"PCI device still in an error state. Unable to load...\n");
+		return -EIO;
+	}
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "PCI enable device failed: %d\n", err);
+		return err;
+	}
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(46));
+	if (err)
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (err) {
+		dev_err(&pdev->dev, "DMA configuration failed: %d\n", err);
+		return err;
+	}
+
+	err = pcim_iomap_regions(pdev, info->bar_mask, fbnic_driver_name);
+	if (err) {
+		dev_err(&pdev->dev,
+			"pci_request_selected_regions failed: %d\n", err);
+		return err;
+	}
+
+	pci_set_master(pdev);
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+/**
+ * fbnic_remove - Device Removal Routine
+ * @pdev: PCI device information struct
+ *
+ * Called by the PCI subsystem to alert the driver that it should release
+ * a PCI device.  The could be caused by a Hot-Plug event, or because the
+ * driver is going to be removed from memory.
+ **/
+static void fbnic_remove(struct pci_dev *pdev)
+{
+}
+
+static int fbnic_pm_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int __fbnic_pm_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int __maybe_unused fbnic_pm_resume(struct device *dev)
+{
+	int err;
+
+	err = __fbnic_pm_resume(dev);
+
+	return err;
+}
+
+static const struct dev_pm_ops fbnic_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(fbnic_pm_suspend, fbnic_pm_resume)
+};
+
+static void fbnic_shutdown(struct pci_dev *pdev)
+{
+	fbnic_pm_suspend(&pdev->dev);
+}
+
+static pci_ers_result_t fbnic_err_error_detected(struct pci_dev *pdev,
+						 pci_channel_state_t state)
+{
+	/* Disconnect device if failure is not recoverable via reset */
+	if (state == pci_channel_io_perm_failure)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	fbnic_pm_suspend(&pdev->dev);
+
+	/* Request a slot reset */
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t fbnic_err_slot_reset(struct pci_dev *pdev)
+{
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_save_state(pdev);
+
+	if (pci_enable_device_mem(pdev)) {
+		dev_err(&pdev->dev,
+			"Cannot re-enable PCI device after reset.\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void fbnic_err_resume(struct pci_dev *pdev)
+{
+}
+
+static const struct pci_error_handlers fbnic_err_handler = {
+	.error_detected	= fbnic_err_error_detected,
+	.slot_reset	= fbnic_err_slot_reset,
+	.resume		= fbnic_err_resume,
+};
+
+static struct pci_driver fbnic_driver = {
+	.name		= fbnic_driver_name,
+	.id_table	= fbnic_pci_tbl,
+	.probe		= fbnic_probe,
+	.remove		= fbnic_remove,
+	.driver.pm	= &fbnic_pm_ops,
+	.shutdown	= fbnic_shutdown,
+	.err_handler	= &fbnic_err_handler,
+};
+
+/**
+ * fbnic_init_module - Driver Registration Routine
+ *
+ * The first routine called when the driver is loaded.  All it does is
+ * register with the PCI subsystem.
+ **/
+static int __init fbnic_init_module(void)
+{
+	int err;
+
+	err = pci_register_driver(&fbnic_driver);
+	if (err)
+		goto out;
+
+	pr_info(DRV_SUMMARY " (%s)", fbnic_driver.name);
+out:
+	return err;
+}
+module_init(fbnic_init_module);
+
+/**
+ * fbnic_exit_module - Driver Exit Cleanup Routine
+ *
+ * Called just before the driver is removed from memory.
+ **/
+static void __exit fbnic_exit_module(void)
+{
+	pci_unregister_driver(&fbnic_driver);
+}
+module_exit(fbnic_exit_module);



