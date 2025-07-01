Return-Path: <netdev+bounces-202824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32F3AEF2D0
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 11:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916591719C6
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E195E26CE09;
	Tue,  1 Jul 2025 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SM2FqGem"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE026C39B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361112; cv=none; b=A2syYVuFedBDBYG2TCKAkN2TydYFgauU6Dixjgzn+8no95FrqHv1Q/J8jJnK6vV8aHkstEyZNrO9hheh8F5XZiTZMuZ2lmLP4SA2aocCLDxLxnszc6uucV7Co1JCLotdUd9JQDV+GSdlIPlMoJdZpVNJvzsG07CNcqWkHiU7xpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361112; c=relaxed/simple;
	bh=1i0ryR5cBWV6GtdEGU8s3EojruIksTv9gJs15V/sUpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozaCOfhMyV7sQ+pber3XepL5yE8DKfRJq99ufbahi0VnUyDIJIt9HD+hOSBZcwC+3o8Lx7rLYSUuKAsN9gi/BmrGlSvgen4lgz7MkEejYtWMkd4WeZhEGXWit16TZZPwp0qcZ+nGNzSUoGug5Z6vWXz9luM3LYAS4G4widyw5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SM2FqGem; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748e63d4b05so1955687b3a.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1751361110; x=1751965910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7ZtbDhifmulp6X+CGsmi42q8oGid7NOjLwBd1zaIRg=;
        b=SM2FqGemMkfIVO+UDTjx2N0aDWsd896H0/mWq5qKSCsB6F6btDV7CDIY+Mof/sBdF1
         YdVhqX+x+Q6kfOj5tPvqdXL4xvdkDKE5wtBIvOgMJ3+f0zDbdhpKe5EE2fUofGiC2Ljd
         lUX2kqq6TEOqMbKrEBIEh5pADAZjDMPy8m7j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361110; x=1751965910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7ZtbDhifmulp6X+CGsmi42q8oGid7NOjLwBd1zaIRg=;
        b=jMhyXzVnpq3HgYaoyuMBNYfw7PWlrnRJP/MPqzDmb3uxbRRt5mu8GVMEBgar3Z+02C
         8SaF16LIyKcwJQD/P2jsb5SlRyCGHsrUNaeBFgZfdWcBI9iHN3BhzGIo+B2rrrlWXhwa
         54wxmoGvG3ZECUlJq7R7lIebQrcnxiMyZx9Uqji49GRqDdTWqIh/Cj8rxNToR0qCICDm
         4gehAfm1XwU93gFvS71uiQUbK3+kTRawEqhASroPuHBPbTRvbYh10veJNEUTqCbDrFcO
         Yk59t/QGmfObjkwHwqDhsp9T0YEw5ZtjS/mJjzfPGfMilsimbsNiB+yTDO7zxKQK0FRk
         Yvug==
X-Gm-Message-State: AOJu0YxkrEGjjIJt9fgneffM3HJd0HStl8IbJkcwkNg9cRyzTP3Ps+jt
	DBRapHlWTG+fd/BhYgmnfPMxYD9ZX3iXc2MNj7nQOAyaP/0puP3t/D3cJdI6r+8n4g==
X-Gm-Gg: ASbGnctVLUHTvZab8e74lxa6lUVSmADO72smy8s81maIoEbZJ39Q5px34DUiPWx2Ux9
	2l6Jdln/gHGFko5XBq/3iiRKeEy4HhEI30FXIUStqjYLyzw+cnS1hWW4gxJlw2CBFNLfCkO39qw
	KiJV18DMgbdTW+o6Lv4TpBtFC8QTERZixvroVhjWyxMBbA/of3OWmHVLtlMjMWim8nPloADUJb6
	I49JoU3glHX+netUrjGlRmTUoL5MUs94Q3jcf6zv0eezQt1/y1bV8V1IcbkFzb7geQ7WPxyRXOJ
	vsfXnLOPCZHf4Sr6GcKgo3zm5gEKjgaEdS1x7fTxpIonq88yOoxqh/tLSLF1jxdWYTFUc8vQs49
	7N/HXLzz0va/QXemODtuW2heegcfI
X-Google-Smtp-Source: AGHT+IFgJDHAkl2TOYiic4+miA72HcRH5YO5MM7i/Qv0249LYR+6NMvnvGl+aUIzCISEeLulTfE1PQ==
X-Received: by 2002:a05:6a20:3d8d:b0:220:1ca5:957c with SMTP id adf61e73a8af0-220a16c4113mr31231334637.31.1751361110519;
        Tue, 01 Jul 2025 02:11:50 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e30201c1sm8893603a12.22.2025.07.01.02.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:11:50 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next, v3 01/10] bng_en: Add PCI interface
Date: Tue,  1 Jul 2025 14:34:59 +0000
Message-ID: <20250701143511.280702-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250701143511.280702-1-vikas.gupta@broadcom.com>
References: <20250701143511.280702-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic pci interface to the driver which supports
the BCM5770X NIC family.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 MAINTAINERS                                   |   6 +
 drivers/net/ethernet/broadcom/Kconfig         |   8 +
 drivers/net/ethernet/broadcom/Makefile        |   1 +
 drivers/net/ethernet/broadcom/bnge/Makefile   |   5 +
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  16 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    | 141 ++++++++++++++++++
 6 files changed, 177 insertions(+)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/Makefile
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bb9df569a3ff..4a9b9d14e0df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4853,6 +4853,12 @@ F:	drivers/firmware/broadcom/tee_bnxt_fw.c
 F:	drivers/net/ethernet/broadcom/bnxt/
 F:	include/linux/firmware/broadcom/tee_bnxt_fw.h
 
+BROADCOM BNG_EN 800 GIGABIT ETHERNET DRIVER
+M:	Vikas Gupta <vikas.gupta@broadcom.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/ethernet/broadcom/bnge/
+
 BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS
 M:	Arend van Spriel <arend.vanspriel@broadcom.com>
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 81a74e07464f..e2c1ac91708e 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -253,6 +253,14 @@ config BNXT_HWMON
 	  Say Y if you want to expose the thermal sensor data on NetXtreme-C/E
 	  devices, via the hwmon sysfs interface.
 
+config BNGE
+	tristate "Broadcom Ethernet device support"
+	depends on PCI
+	help
+	  This driver supports Broadcom 50/100/200/400/800 gigabit Ethernet cards.
+	  The module will be called bng_en. To compile this driver as a module,
+	  choose M here.
+
 config BCMASP
 	tristate "Broadcom ASP 2.0 Ethernet support"
 	depends on ARCH_BRCMSTB || COMPILE_TEST
diff --git a/drivers/net/ethernet/broadcom/Makefile b/drivers/net/ethernet/broadcom/Makefile
index bac5cb6ad0cd..10cc1c92ecfc 100644
--- a/drivers/net/ethernet/broadcom/Makefile
+++ b/drivers/net/ethernet/broadcom/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_BGMAC_PLATFORM) += bgmac-platform.o
 obj-$(CONFIG_SYSTEMPORT) += bcmsysport.o
 obj-$(CONFIG_BNXT) += bnxt/
 obj-$(CONFIG_BCMASP) += asp2/
+obj-$(CONFIG_BNGE) += bnge/
diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
new file mode 100644
index 000000000000..0c3d632805d1
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_BNGE) += bng_en.o
+
+bng_en-y := bnge_core.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
new file mode 100644
index 000000000000..b49c51b44473
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_H_
+#define _BNGE_H_
+
+#define DRV_NAME	"bng_en"
+#define DRV_SUMMARY	"Broadcom 800G Ethernet Linux Driver"
+
+extern char bnge_driver_name[];
+
+enum board_idx {
+	BCM57708,
+};
+
+#endif /* _BNGE_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
new file mode 100644
index 000000000000..514602555cd1
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/init.h>
+#include <linux/crash_dump.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "bnge.h"
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION(DRV_SUMMARY);
+
+char bnge_driver_name[] = DRV_NAME;
+
+static const struct {
+	char *name;
+} board_info[] = {
+	[BCM57708] = { "Broadcom BCM57708 50Gb/100Gb/200Gb/400Gb/800Gb Ethernet" },
+};
+
+static const struct pci_device_id bnge_pci_tbl[] = {
+	{ PCI_VDEVICE(BROADCOM, 0x1780), .driver_data = BCM57708 },
+	/* Required last entry */
+	{0, }
+};
+MODULE_DEVICE_TABLE(pci, bnge_pci_tbl);
+
+static void bnge_print_device_info(struct pci_dev *pdev, enum board_idx idx)
+{
+	struct device *dev = &pdev->dev;
+
+	dev_info(dev, "%s found at mem %lx\n", board_info[idx].name,
+		 (long)pci_resource_start(pdev, 0));
+
+	pcie_print_link_status(pdev);
+}
+
+static void bnge_pci_disable(struct pci_dev *pdev)
+{
+	pci_release_regions(pdev);
+	if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
+}
+
+static int bnge_pci_enable(struct pci_dev *pdev)
+{
+	int rc;
+
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "Cannot enable PCI device, aborting\n");
+		return rc;
+	}
+
+	if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM)) {
+		dev_err(&pdev->dev,
+			"Cannot find PCI device base address, aborting\n");
+		rc = -ENODEV;
+		goto err_pci_disable;
+	}
+
+	rc = pci_request_regions(pdev, bnge_driver_name);
+	if (rc) {
+		dev_err(&pdev->dev, "Cannot obtain PCI resources, aborting\n");
+		goto err_pci_disable;
+	}
+
+	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+
+	pci_set_master(pdev);
+
+	return 0;
+
+err_pci_disable:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	int rc;
+
+	if (pci_is_bridge(pdev))
+		return -ENODEV;
+
+	if (!pdev->msix_cap) {
+		dev_err(&pdev->dev, "MSIX capability missing, aborting\n");
+		return -ENODEV;
+	}
+
+	if (is_kdump_kernel()) {
+		pci_clear_master(pdev);
+		pcie_flr(pdev);
+	}
+
+	rc = bnge_pci_enable(pdev);
+	if (rc)
+		return rc;
+
+	bnge_print_device_info(pdev, ent->driver_data);
+
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+static void bnge_remove_one(struct pci_dev *pdev)
+{
+	bnge_pci_disable(pdev);
+}
+
+static void bnge_shutdown(struct pci_dev *pdev)
+{
+	pci_disable_device(pdev);
+
+	if (system_state == SYSTEM_POWER_OFF) {
+		pci_wake_from_d3(pdev, 0);
+		pci_set_power_state(pdev, PCI_D3hot);
+	}
+}
+
+static struct pci_driver bnge_driver = {
+	.name		= bnge_driver_name,
+	.id_table	= bnge_pci_tbl,
+	.probe		= bnge_probe_one,
+	.remove		= bnge_remove_one,
+	.shutdown	= bnge_shutdown,
+};
+
+static int __init bnge_init_module(void)
+{
+	return pci_register_driver(&bnge_driver);
+}
+module_init(bnge_init_module);
+
+static void __exit bnge_exit_module(void)
+{
+	pci_unregister_driver(&bnge_driver);
+}
+module_exit(bnge_exit_module);
-- 
2.47.1


