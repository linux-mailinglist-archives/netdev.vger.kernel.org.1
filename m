Return-Path: <netdev+bounces-87856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAAA8A4CCB
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5911C21F67
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80C55D47B;
	Mon, 15 Apr 2024 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zzd5Loli"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F3C5D758
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177851; cv=none; b=lbf+os681mNMx/ro6Gt9vF6wkydjSMuu9NARqdHQnpInwHCWt9IO7/NUMFWK9oFpPLfsGekiaL6kuzTCNaRWtBNV0bVhpJcv6LPQjz1c3c/+zZmWzJut8bihdKEyjEHhdno0egxL9dYsF/XORHVS9RT4VddCo0BVKYR10TwcsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177851; c=relaxed/simple;
	bh=5nSG0WVzOB0MqjPT5vOeRw9qyJczlOBKrXKKl+5oZD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DggiHeff8Q/phpXkDw0LRW6/TwFu2SrCJj1k7uUyj/5dYupYfJSdPrDV10Vme4BIQ/L3RCFckX3HtV4Kc1sMTNZITuHWdzp6aJ/IG7jB2wfgHYBxlmOLbShadxOxIssM06aOyqA86E5EStaL9dejN8iVh5Xhi19y0N04QbpdKpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zzd5Loli; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e2be2361efso5004865ad.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713177848; x=1713782648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDYJoW8giA4GYN9chXFH+YEPipetyIlmzpVnNV0zVZA=;
        b=Zzd5LoliANTau4fpz5JfDopmztHzq87eqmsG5SUHEPOV0plTXkVEBgFgIwA5b0wY9z
         DfV1y3utviQbh670qe1/Mf/jrjiMQ1cebRZfUler4BT+FmycH/7lcHX1xtpNjBP7Hony
         GKFitj7uygo+DImi/Ib7mOfEluJg1ADIh5xUWJ1Bp1fuUy4/+JpN6CVzq33Um+ivyUrE
         gszOoiYB6vCv812JgWb2XtmRcUHju9NfeW8d/tNl6mT+BHJVSrWg/QJIyevnhkjbKqkR
         EFLhU0OVs+agty1/jq2qYgSjSP02KI3uiTAH2eyhYLew5Ap3tvttzRWlqXNB7Z2OWlcN
         7qwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713177848; x=1713782648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDYJoW8giA4GYN9chXFH+YEPipetyIlmzpVnNV0zVZA=;
        b=WnKheW2etPAtx3ZNhSW7juX+xxaNA29IOVtFKQgB1wcF/y8s1KjdSk7uwqTp8HUKKk
         7FzjubYwp4syOfkXPeneDQJ/M5VyHZ7YiJGTfTwqAT3jB1EJ2DxkRyVUqnJVAxPRVl/y
         WN/Y95F4HJWyanZhHtJdh/5aKyaseIDLFbkIArPwoZ4uiFbCZ32kWXEsCc6s5twPFrcx
         hfzZL5SIgybe2nSfYo1wcvIaT8j/c2mMlGLBIa5ypLZdlw8sEWy8Rn7W0tXll39TuzNm
         6UAnfMD4ts+KuHKYXxIU9zcDiFPAxD18VHYDytiDXF3cChL+CCaTslrnTGAEFdxYsoEU
         kd2g==
X-Gm-Message-State: AOJu0YxRLtsvmPUnY0PTCGQNy8JhssU5PUc6NUAJLAyHCH7QHq+tdAfU
	CLxpqkB/3eAMk5eXk538riF183tD8MMYjKSQp0tcbIxia8C/b0qx0TYbYA==
X-Google-Smtp-Source: AGHT+IG8/EvrTgWSbHvIZtu5iFSPJW4+rrG4iVoopnyVcdvGbLcHJWeVah+2RKAIExjNZB7EEWVCFg==
X-Received: by 2002:a17:902:e5d0:b0:1dd:b883:3398 with SMTP id u16-20020a170902e5d000b001ddb8833398mr11337846plf.4.1713177848192;
        Mon, 15 Apr 2024 03:44:08 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id f4-20020a17090274c400b001e256cb48f7sm7581991plt.197.2024.04.15.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:44:07 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch
Subject: [PATCH net-next v1 1/5] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Mon, 15 Apr 2024 19:43:48 +0900
Message-Id: <20240415104352.4685-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415104352.4685-1-fujita.tomonori@gmail.com>
References: <20240415104352.4685-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c   | 57 ++++++++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h   | 17 +++++++++
 5 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ba3fe6ac09c..3bd757e803d3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21818,7 +21818,13 @@ TEHUTI ETHERNET DRIVER
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
index 000000000000..368a73300f8a
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include "tn40.h"
+
+static int bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
+static void bdx_remove(struct pci_dev *pdev)
+{
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id bdx_id_table[] = {
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
+static struct pci_driver bdx_driver = {
+	.name = BDX_DRV_NAME,
+	.id_table = bdx_id_table,
+	.probe = bdx_probe,
+	.remove = bdx_remove,
+};
+
+module_pci_driver(bdx_driver);
+
+MODULE_DEVICE_TABLE(pci, bdx_id_table);
+MODULE_AUTHOR("Tehuti networks");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Tehuti Network TN30xx Driver");
+MODULE_VERSION(BDX_DRV_VERSION);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
new file mode 100644
index 000000000000..8507c8f7bc6a
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#ifndef _TN40_H_
+#define _TN40_H_
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/version.h>
+
+#define BDX_DRV_NAME "tn40xx"
+#define BDX_DRV_VERSION "0.3.6.17.2"
+
+#define PCI_VENDOR_ID_EDIMAX 0x1432
+
+#endif /* _TN40XX_H */
-- 
2.34.1


