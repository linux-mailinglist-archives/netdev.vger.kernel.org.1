Return-Path: <netdev+bounces-198952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF82ADE6CE
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75BAE189BC39
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502542868A4;
	Wed, 18 Jun 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RO3jfgZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACC285047
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238671; cv=none; b=VYgdGU+CuFRfylbcN1/Fu8eAuaS4ahkc2RADHXIPZl5/Y5s+IFNZ5YNorT5VvwIO3r66P6cbRynXJwYc2YRtZf3lBn9ERGOjSuw9LzNziP73sJfdSwCS/8/wOBqvVtGvqiNSRgZR36hKSOEXSmRCIvfzw2joO/cA+VdR+D2sYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238671; c=relaxed/simple;
	bh=/sdU1qMNoJ0bvwjvGOsGO9FBW5XHk0rY7exk3jbRQJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYbchHqP0IRLAWJayH/gzne+6vE2Priq0Pd2UiZQZJcfhKkko3qW3fD0yWmhVAaDtwWsHxv+MuhzJimGeLH8zZAb4/lJOW+j39eF1e471iaB1PKbQGzCSF3rfM/1dtRx++NaH002JnYlCPT6pN0kcOcYs0jL2m8XyfZKqG9W69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RO3jfgZJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73c17c770a7so7380422b3a.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750238668; x=1750843468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR7EzpOcm/lrExaQc9aOQ7ExvWUFWTwhRPcakxeEpQI=;
        b=RO3jfgZJr76BG0rYEG5Y07trnfmjedj0PI4nopsbu0S8jNhnZ7BNRoIeTlflNFWJeJ
         0FC13JWvosbY2QTepRPd65f9aSeNSgUPdaSQCzHTI5GJQGeJijBWb3apEt2ur0p+RqfL
         iWd6pgyB6i8MVCbRyL2tCJCKVHq3x80/lZb3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750238668; x=1750843468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OR7EzpOcm/lrExaQc9aOQ7ExvWUFWTwhRPcakxeEpQI=;
        b=hFwcqaBgxFn74zmcO1BIs5nbIuBlK2XTSjknR5sCdD6ZzcrIzRJSSbt1MQ4UpZ1AAd
         4NTSuDlNzeGbhZ7zb2D+lEQyTjK+O/rq6H/vtH54kgwyAuQq613t1oHTx3gigqays/HW
         dfmxsiAvw7s808ymZ608f0d+6MiuVLrdTFg5V8kzegGPk+Ku0Wuet3K3x15fU9pG5w3g
         JiiOLmhR+BaekkRZa0dEjdkeW+/bfa/YfuTyLqTuSh/Ey6KPcBClT3JOhPZbJOOb6Vfi
         ONwh++DipwB9SQcmxLk85YqMCcoObR/MaGKkAfnzBGHDlBldbDelOBnoW0VeyNeC9KAB
         QFOA==
X-Gm-Message-State: AOJu0Yyqlx1CImjL9+a2FfoazmhR1qPX/Jc4s4yhAMgdQcq4Z5GlwD7k
	nYNFdMwSkI9V729myEmwM/ZF+jEv3kePCh7berG86IgZFrQU1q6qKiqhWajaj8Vqpg==
X-Gm-Gg: ASbGnct6GQE14m6X4KLzUgEpY0KSnjHCPcLOQL8kgTuPH0vbPiduc+n53EBkvTb7zHO
	jcMhNqP7tok3/FLGffwTl+Xd3qTdHv6oi7/byt13hE3H89nh7fVe2SdCf+GygYnrPIzLRLmRJmO
	YtLERvUGXhn1gKlsmVFk6892UTjYzkcT1j8O8hYEkwrE+P+ObXccwX59M/BxkcHJefOGq9uLaqh
	LDkyakjwCP5tF2zK/uWqySJgcY5cShXusNQSWTKUmmXBa1qBrfzg/P2zavcTtrgBqrvdjNnNq8B
	hLhK597YoC1pNtsc56sxuzMo+aboGUz/Yt52BLZDyvcNM4eJ9xjefcSU1jsJPYDcpMnJJjidh31
	5fC8/BR+U62VW7l/yOgix9gN2g3Qb5LG0b2Eo2pk=
X-Google-Smtp-Source: AGHT+IEp2uv85HMsESn8B73kJ6UnYjmTVcFq6xZRkuE3FQps1msK6SKzjFp4kBGKVza/Fo7XvWlUvQ==
X-Received: by 2002:a05:6a20:6f8e:b0:21e:f2b5:30de with SMTP id adf61e73a8af0-21fbd55aec5mr26724420637.12.1750238667947;
        Wed, 18 Jun 2025 02:24:27 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecd08sm10408993b3a.27.2025.06.18.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:24:27 -0700 (PDT)
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
Subject: [net-next, 01/10] bng_en: Add PCI interface
Date: Wed, 18 Jun 2025 14:47:31 +0000
Message-ID: <20250618144743.843815-2-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618144743.843815-1-vikas.gupta@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
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
 .../net/ethernet/broadcom/bnge/bnge_core.c    | 149 ++++++++++++++++++
 6 files changed, 185 insertions(+)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/Makefile
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 507c5ff6f620..af349b77a92e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4854,6 +4854,12 @@ F:	drivers/firmware/broadcom/tee_bnxt_fw.c
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
index 000000000000..3778210da98d
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -0,0 +1,149 @@
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
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64)) != 0 &&
+	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
+		dev_err(&pdev->dev, "System does not support DMA, aborting\n");
+		rc = -EIO;
+		goto err_pci_release;
+	}
+
+	pci_set_master(pdev);
+
+	return 0;
+
+err_pci_release:
+	pci_release_regions(pdev);
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


