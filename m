Return-Path: <netdev+bounces-92027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BA18B5046
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 06:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789911C210AF
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 04:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA785C8E2;
	Mon, 29 Apr 2024 04:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3j3KZpR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A762563
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 04:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365580; cv=none; b=Y8OgH8uh8RP/KzRDAV4FapsPLuZ0/eMRaaKwBPKW0zpYkJK+dOmlDpCaSJEoYBDygoagDpU5GMu++t4ADrFeIVJd9SVngtBsT1FYmWB9MOZepPYIRCxzLPaj5Hpf5TzcpDddkJTfT2jOph92zATmb6jvBlHpDCTzo7mX+sYmMiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365580; c=relaxed/simple;
	bh=DGuzid59Wi4I570ZwZzoIfPgk26W6+fxqsCxVj4AGfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PvHn3VTolGd8QgW5S3q6S2gfxxdC7nKnTjPZElBXKuQe6eyq/xyk0TAvwqgwOKsmYW2RUVmwO11en+fQwBx4Chk4FE3rYTejkwxkRe20nfqkGJWYAMm5zPAyVeso/goEbrZwynkreMrND1OABEYsq1mZj2C8YueAqmMOqlRd6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3j3KZpR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2aa0f3625aeso994306a91.1
        for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 21:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714365578; x=1714970378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+ttOdQm48b3aCF/BkRvurlfClT6ifW6Af0J3nJYC5Y=;
        b=a3j3KZpRKWhPyXu+6hc9zYE4s9Ch0n90TpZGGbKja/rmSvMS+Y3iVVYKbydM64rqF0
         4NRzNJ7uIRe1YZuq+txa6EAyMWSM61hIOEt2VBLxCPUwISxatVqzQ1Wo5wzywNA2XdRj
         ixDhM7DgmkC+8+wTZP4/wZfQYtnb8bmG8tx/+iedq21/Me4BG7zeg2JtgJu+EdKy8tUs
         pyOnO1oKmzp10tfQYCybGNkIfFUcmCoao8nYhMOYOnOYFd3eP0AoxOWsZPrvyWzBqFff
         edilsPoSCK6EGTf3ItXN0m6nseusV2yY1yJM5Xn01FigQbDfxde2ttCnjZbhav2mcGtM
         tL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714365578; x=1714970378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+ttOdQm48b3aCF/BkRvurlfClT6ifW6Af0J3nJYC5Y=;
        b=Tk0c6mC3q1s6MTmZyhVznck+WoJ2YqDApg5BppzvZjvFjWC7+MvfK4K3AV1dWwJ3Tp
         PnS5JdjEaowcNeybkVZicV9lzBMgLFdfoXLxN/jaCBFQbyAbM/GAL0wTk2sY8Ws6NYMu
         rFdekAZkGCQb0YoEH9+wqtt3Eo/U3TmPYUtVZ2C9l9mwM4+nvOyhSROFxtA4C8rN0cOW
         VmtMAQMZbRQ9m/CQtvemcBYEZqjhRsaEJG+kNmuJcjvHF4KEzUIaze6h30fHr07VRFAV
         8lEKPNupH4TAhZSOKIAUCrTqMgUcoPaiiXh47bYDhTmbKLCO+LyOWBkq2HTTv2LQOaO5
         7oCg==
X-Gm-Message-State: AOJu0Yz1EsNxakebtOHG3tETHa20wjetR6OPVfcEpCSx35SF7YDFfEy0
	iBhTzLJOXO9udtS6dlhyblMplxEa3zW3rXp1gfaQxw2mDOLAy1041orpfg==
X-Google-Smtp-Source: AGHT+IEj6eq0K65NXUP18B8Gz6FnBfKrS9XJrR5FO+awBnDSrRBGlIuAn8cCm90pRuBXI44qrxjszw==
X-Received: by 2002:a17:902:e747:b0:1e4:397b:492c with SMTP id p7-20020a170902e74700b001e4397b492cmr11275877plf.4.1714365578407;
        Sun, 28 Apr 2024 21:39:38 -0700 (PDT)
Received: from rpi.. (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001ebd799bd1csm796129pls.13.2024.04.28.21.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 21:39:38 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	jiri@resnulli.us,
	horms@kernel.org
Subject: [PATCH net-next v3 1/6] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Mon, 29 Apr 2024 13:38:22 +0900
Message-Id: <20240429043827.44407-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429043827.44407-1-fujita.tomonori@gmail.com>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This just adds the scaffolding for an ethernet driver for Tehuti
Networks TN40xx chips.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 MAINTAINERS                          |  8 +++-
 drivers/net/ethernet/tehuti/Kconfig  | 12 ++++++
 drivers/net/ethernet/tehuti/Makefile |  3 ++
 drivers/net/ethernet/tehuti/tn40.c   | 56 ++++++++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h   | 14 +++++++
 5 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ab89edc6974d..3b8f1b8cc2f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21841,7 +21841,13 @@ TEHUTI ETHERNET DRIVER
 M:	Andy Gospodarek <andy@greyhouse.net>
 L:	netdev@vger.kernel.org
 S:	Supported
-F:	drivers/net/ethernet/tehuti/*
+F:	drivers/net/ethernet/tehuti/tehuti.*
+
+TEHUTI TN40XX ETHERNET DRIVER
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ethernet/tehuti/tn40*
 
 TELECOM CLOCK DRIVER FOR MCPL0010
 M:	Mark Gross <markgross@kernel.org>
diff --git a/drivers/net/ethernet/tehuti/Kconfig b/drivers/net/ethernet/tehuti/Kconfig
index 8735633765a1..849e3b4a71c1 100644
--- a/drivers/net/ethernet/tehuti/Kconfig
+++ b/drivers/net/ethernet/tehuti/Kconfig
@@ -23,4 +23,16 @@ config TEHUTI
 	help
 	  Tehuti Networks 10G Ethernet NIC
 
+config TEHUTI_TN40
+	tristate "Tehuti Networks TN40xx 10G Ethernet adapters"
+	depends on PCI
+	help
+	  This driver supports 10G Ethernet adapters using Tehuti Networks
+	  TN40xx chips. Currently, adapters with Applied Micro Circuits
+	  Corporation QT2025 are supported; Tehuti Networks TN9310,
+	  DLink DXE-810S, ASUS XG-C100F, and Edimax EN-9320.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called tn40xx.
+
 endif # NET_VENDOR_TEHUTI
diff --git a/drivers/net/ethernet/tehuti/Makefile b/drivers/net/ethernet/tehuti/Makefile
index 13a0ddd62088..1c468d99e476 100644
--- a/drivers/net/ethernet/tehuti/Makefile
+++ b/drivers/net/ethernet/tehuti/Makefile
@@ -4,3 +4,6 @@
 #
 
 obj-$(CONFIG_TEHUTI) += tehuti.o
+
+tn40xx-y := tn40.o
+obj-$(CONFIG_TEHUTI_TN40) += tn40xx.o
diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
new file mode 100644
index 000000000000..fe2c392abe31
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include "tn40.h"
+
+static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	int ret;
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_err(&pdev->dev, "failed to set DMA mask.\n");
+			goto err_disable_device;
+		}
+	}
+	return 0;
+err_disable_device:
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static void tn40_remove(struct pci_dev *pdev)
+{
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id tn40_id_table[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
+			 PCI_VENDOR_ID_TEHUTI, 0x3015) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
+			 PCI_VENDOR_ID_DLINK, 0x4d00) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
+			 PCI_VENDOR_ID_ASUSTEK, 0x8709) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
+			 PCI_VENDOR_ID_EDIMAX, 0x8103) },
+	{ }
+};
+
+static struct pci_driver tn40_driver = {
+	.name = TN40_DRV_NAME,
+	.id_table = tn40_id_table,
+	.probe = tn40_probe,
+	.remove = tn40_remove,
+};
+
+module_pci_driver(tn40_driver);
+
+MODULE_DEVICE_TABLE(pci, tn40_id_table);
+MODULE_AUTHOR("Tehuti networks");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Tehuti Network TN40xx Driver");
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
new file mode 100644
index 000000000000..098267dfbc07
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#ifndef _TN40_H_
+#define _TN40_H_
+
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#define TN40_DRV_NAME "tn40xx"
+
+#define PCI_VENDOR_ID_EDIMAX 0x1432
+
+#endif /* _TN40XX_H */
-- 
2.34.1


