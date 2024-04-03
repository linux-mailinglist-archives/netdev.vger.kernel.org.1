Return-Path: <netdev+bounces-84598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E444E897993
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C301C216F6
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D2C155730;
	Wed,  3 Apr 2024 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWRBh6x9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3456B70
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174918; cv=none; b=GqC4KIBvKObwcBLYygjXVQL24PMl3jV5WO+1GNsJF+HVM+jAciEDpUgKjRYIUI309nefL/Frc0QYwibaB5yN9nBAMoJhzJ1GPMNYd0oW6opriRxpmLIUQjGgGgoCEDVrF8fx6CLgIlAhc2GkC2+W3UjdAZ4mscDDAAUOdtd1rGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174918; c=relaxed/simple;
	bh=vs9rY9utHA3S6f2lTLj+Vd9VjkDK1FD7dTigB+veahA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jjMIVta9uEW+tsfdQSIUsF/pcsU6VHuu2211x9XVoWqzfVhJvXzRSQJtAd90iddXM6GBLHScJ4WzmDZsQWCBlyqCixgKDqQ0VK2r2tgd/dtwhXv3NmQZNHlxwLxrx9xm0VQNWwoNR0bJ74XsUpMp0M2SOKxq2xsS4cyI4vId574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWRBh6x9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e28be94d32so1770045ad.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174916; x=1712779716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CHzxQHK9Lqcog8W42sHoq7id1vDuaRjkicBhWkJ+UbY=;
        b=MWRBh6x9ZtakQDWvmHB7SL0Vm4bushKmLHu1LMojw6Dxt+12EqVIqU/V3IK1YCDVjw
         P0QmUSt3tnK82W4gv/b1z5DXQWOFKZPS+NRihNaaSfDpSWzF+JTOmvyl6xyHAAoa6izR
         0q3m4MHxajCMjc91U0nc/R0ALv5wPKTj3SF+xZnWQAlNHQVt3CwCENcR+8eihgV6vQgY
         /3KOu3eUA8RLs2xJ2ygyFeHVDJkyoQGOD/LO4Aqz0pJhNRmmWSK6gwWCr0jUlaGAKxPf
         hbyfnnufnIniKJA3W73xanAVYtgUmeYThMkxHaRwgxVPxjvfgxIe4+EH7g3lSfLrdRvV
         GLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174916; x=1712779716;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHzxQHK9Lqcog8W42sHoq7id1vDuaRjkicBhWkJ+UbY=;
        b=h3IH59jJVACUgg6xeMEUyIsP0wcBPqnVPu8MERpp+XUkr4Q+HG6aT1eLiQA2NX9IuI
         PALfUzKEA9rwsLfrjMMdqoss19BWbR/zXBWxG6zTBCSFFq7OhmRCKOQtXbDRLt8CamPi
         kPVbOgUjC/dcvFfNLCjfEeAjElQHtneLjUxPJiX3OOPQu7YljLAlflKtz8vMJHcz9TLt
         oI3p1VHlUu2Cpp6YXQ06nW2Br0xFI2xpkIo5hn+F7FxJ2BieEpVv2DShpo31w2qelQyR
         b2SjMafZmIrEo8QwLUHQy0Gy/JrRG5G9YSu/gUMLHH8SFxEL9pO9ZQBATZL2t6Eb0vna
         JuLQ==
X-Gm-Message-State: AOJu0Yx6wf5Ujw2/IMzjTYnJxSQTbmozx+KhWMkbu/anbBct7cvgs2Ol
	GyRGYYn7nBGPA8/ZeeZNsStSzhzqHZEM/00uoHjWsKFCKurhwesg
X-Google-Smtp-Source: AGHT+IG9FevuM4B+cUZCFlYpok8DJksTB+l+tjEmMUsYzpf99KtVi2k/N5kdBDoEbLX95zu+UXIptw==
X-Received: by 2002:a17:902:db10:b0:1e0:a8b8:aba3 with SMTP id m16-20020a170902db1000b001e0a8b8aba3mr404309plx.35.1712174915458;
        Wed, 03 Apr 2024 13:08:35 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902e5c100b001e20574bacesm13765591plf.83.2024.04.03.13.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 13:08:34 -0700 (PDT)
Subject: [net-next PATCH 02/15] eth: fbnic: add scaffolding for Meta's NIC
 driver
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com
Date: Wed, 03 Apr 2024 13:08:33 -0700
Message-ID: 
 <171217491384.1598374.15535514527169847181.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
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
 drivers/net/ethernet/meta/Kconfig               |   29 +++
 drivers/net/ethernet/meta/Makefile              |    6 +
 drivers/net/ethernet/meta/fbnic/Makefile        |   10 +
 drivers/net/ethernet/meta/fbnic/fbnic.h         |   19 ++
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     |    9 +
 drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h |    5 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c     |  196 +++++++++++++++++++++++
 10 files changed, 283 insertions(+)
 create mode 100644 drivers/net/ethernet/meta/Kconfig
 create mode 100644 drivers/net/ethernet/meta/Makefile
 create mode 100644 drivers/net/ethernet/meta/fbnic/Makefile
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_csr.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_drvinfo.h
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6a233e1a3cf2..77efffbd23f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14307,6 +14307,13 @@ T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
 F:	drivers/staging/media/meson/vdec/
 
+META ETHERNET DRIVERS
+M:	Alexander Duyck <alexanderduyck@fb.com>
+M:	Jakub Kicinski <kuba@kernel.org>
+R:	kernel-team@meta.com
+S:	Maintained
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
index 000000000000..8949ab15a02e
--- /dev/null
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -0,0 +1,29 @@
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
index 000000000000..1cb71cb1de14
--- /dev/null
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -0,0 +1,196 @@
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
+	/* required last entry */
+	{0, }
+};
+MODULE_DEVICE_TABLE(pci, fbnic_pci_tbl);
+
+/**
+ *  fbnic_probe - Device Initialization Routine
+ *  @pdev: PCI device information struct
+ *  @ent: entry in fbnic_pci_tbl
+ *
+ *  Returns 0 on success, negative on failure
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
+	/* disconnect device if failure is not recoverable via reset */
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
+	pr_info(DRV_SUMMARY " (%s)", fbnic_driver.name);
+
+	err = pci_register_driver(&fbnic_driver);
+
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



