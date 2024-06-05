Return-Path: <netdev+bounces-101179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EA48FDA74
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFD11F25E1C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592D15FD16;
	Wed,  5 Jun 2024 23:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wzs4zCSb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B040167299
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717630049; cv=none; b=gbFb4TpcHjqXb4Z7ZT4SaHvGYWUwrOgrJfqpKboKYkXidaFcPNpeFAI6jFVQj/C1HOJ1DkS1iH/vWyi7+KcKc1EGKcvvEKpiXqrxX9VVghPvCNSVwYYdhpGzBiDA1N25HFn0AyW2uwRURzeb7h34RZIOsyWoFSfqKV5FA3jW64M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717630049; c=relaxed/simple;
	bh=4rnp4+PSK1OOPkjBI85swViXKj5E9W5pa2ukbgAhsqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A9xlSLeCX8lTdQDh0yOM+tBgp1eossKS1EfZPMDFN4VDM9jfhDE4NDgkhWcTtWnHvLLdRukzofQ1K0WhyulmctjCxwamY+SwLb1nVl4MYtRG/ii7qz/lbfexHKSJ8sLSf8fMWdo2NgjP4VIo9IZ/Ir5B3gF5+i4g/zan/7NaTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wzs4zCSb; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3734052ffd9so130745ab.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 16:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717630046; x=1718234846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjl3Y+TI9JD8z4u/gtCsuoldwONF//aNtx4gMWmDzt0=;
        b=Wzs4zCSb4NGpT71YgJ9+FBHc4M3f2XHyGpB9rr1vObPWIL4qaniJnWyjT4Qb/Xi/Kj
         iMq9i2InqkXUQUe/B6HfYRnwYn1ECy1hN9O4vG0xvP8poPkKu8nmvz4b75/dfaCe0URC
         C8bCRHyux6rJNIs+pPEt4gFVkv38VvTd3Qr1XJrl8nuwAjf52q8Uyl38sOk+5i9+SCQU
         EaiUltsK5UCqJbYOiM2tIPmrsYU4WdzuHmpPC0V+qyNYRTTivqjqFR0Yh03sTLkwac0e
         d/uYTVVDp6oPZbVdGAsUw2LMKQGiIUWfma86MCKNy2uZjZj9yPVo/y/u4nmisRX1IdI2
         RCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717630046; x=1718234846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjl3Y+TI9JD8z4u/gtCsuoldwONF//aNtx4gMWmDzt0=;
        b=u9Jsie8T+QMleZLNHFHNX755ac7QPTdL+wGtntSV6sspgPqB1Jox+XwABhqv1xj77B
         jucuIjf+ConkKChlBLc2CkLg/av0S0QQLH/iTipkJ0b9yIADBwNSsmD0llCHIcx3lwf5
         RCsHw85iWnjZaXyxsV9KrTN+BGc3H9p6dmf56EYwY4gdqLJgDv1YCwQLS/ONpVZxY+Nj
         nOGBxtMVhdkG43TGg5eVzoUTYyveP28z762GCAnV2b7wu5EmFMLlWR5AviqjY9gaoTwW
         1MCYeDTDtkwTBcGpF9Xg+ZtkI/jlYMfUolvC9ltLkcfQBnLff99SPAMqAxq5M9pq75rt
         ogdA==
X-Gm-Message-State: AOJu0YzEx2V8EEeYiBkyO4AKRigaHGEajKXZgcxp3di/HaoA94MBSImI
	tPLJvL3zaMmiGQBWUqcF566JN396YC7PSVrmGmHTbpljPZ15x9jJwPtIvV+X
X-Google-Smtp-Source: AGHT+IFqRuv85xBjUaeP8bWV5sEC1x5AD0KqRMhE+zPXvTulyoy9tF/dNJIgge8uNSou+6+O7YSFRw==
X-Received: by 2002:a92:cda2:0:b0:374:aedb:1607 with SMTP id e9e14a558f8ab-374b1e108e4mr40059585ab.0.1717630046400;
        Wed, 05 Jun 2024 16:27:26 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de28f37482sm67725a12.94.2024.06.05.16.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 16:27:26 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	hfdevel@gmx.net,
	naveenm@marvell.com,
	jdamato@fastly.com
Subject: [PATCH net-next v9 1/6] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Thu,  6 Jun 2024 08:26:03 +0900
Message-Id: <20240605232608.65471-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605232608.65471-1-fujita.tomonori@gmail.com>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c   | 55 ++++++++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h   | 11 ++++++
 5 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7538152be2f1..ec7970203ee6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22141,7 +22141,13 @@ TEHUTI ETHERNET DRIVER
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
index 000000000000..6ec436120d18
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#include <linux/pci.h>
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
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(&pdev->dev, "failed to set DMA mask.\n");
+		goto err_disable_device;
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
index 000000000000..a5c5b558f56c
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#ifndef _TN40_H_
+#define _TN40_H_
+
+#define TN40_DRV_NAME "tn40xx"
+
+#define PCI_VENDOR_ID_EDIMAX 0x1432
+
+#endif /* _TN40XX_H */
-- 
2.34.1


