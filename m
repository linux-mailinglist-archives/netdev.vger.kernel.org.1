Return-Path: <netdev+bounces-104331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC5290C30A
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 07:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E191F22911
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3811E529;
	Tue, 18 Jun 2024 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWU3UsHh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2E1CD2C
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 05:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718687882; cv=none; b=hBoJnxyl4XC2GxEDGotWUXlyyjiLNA83Eha8YVn9I2gq9JmlhlJJgU0Xh3I+VepYdpM+Pm7SRzjC0xzFRRCSKJ7YqEFUY3q+knWlNWUDscO+F+F3mz/E8vOhRtArHUdzTwXtq2nnfhFz2te1VShMqcWL6IxLzSQ1UN/IiuEl++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718687882; c=relaxed/simple;
	bh=dUAGr/4G2kBgFRyUV7OKaBMGhyl9X2KxjKLl3YN3h9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Oc1ChTE/yhvJQTIweEoACPfOh4RedcL2r9gdco5c0xFdXaISaeHSp4ZxGWw9mAjmZrfI7rOkvrJqudQdboin6WYMn77sWYyoT0ew1U6EW28z2fH8RNe2dqoDynAeYyRsXBbnLWFrCv/K2yVnkFOV5Gxo398moteblzScrAojrXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWU3UsHh; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c4e2cd931aso720399a91.0
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 22:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718687880; x=1719292680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhAntXelsU30sbD0gP818bSlHDx9YPGlJ0n72DF2HQw=;
        b=YWU3UsHhb8bUeIQOvP+DszzZDup8ZIT8pKmEsbVyqs83DYmwHf/yoGhH6tb+vaDBZZ
         mOWyYMrUN2Y0rlSiLo0R5RRDgG+L9mgBrgM0Btt+/HOoBMcn5WQ+ElLClAFAtP9uB7CM
         dZFoYOeNxEezZDHh2dBuWAoN/CbuXVcTVk0S6H5GFMychS3zvfNZ8ZhlNKnhUd5zVd2u
         z6ADU5NZapqqAwS1uzqTZhHCriHsyhD4oYdHGs1dkobzwK5Jbdi/zqpN+ZuI7p9H4gm+
         NY70k16gBJ0da5IQHWnyeo8e8d8FhvtGmQyAGU4ltgTu4vui9zlHA/AS33iIZ+Sn+B+i
         D+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718687880; x=1719292680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhAntXelsU30sbD0gP818bSlHDx9YPGlJ0n72DF2HQw=;
        b=JyVHrQmoMk5BzfxZLDvhB7VA2pGgYMFEhkwKjUE16joiKdcfuPHixI2yBnpYW12VJ1
         X7AkA6IAniHt4tZKq0UTNzhbCdtRrvEo/UCaowcpyMjUqf2MDUiGJHSE2LpMk9q2Bv38
         1f/oaoLXl1TBgs7JUd2Q32fo14C/yeMSUvTC8qB0CKtxehNzc/5WOzSSgDwXC+oWULgy
         ZY3jq8+1izgY2H97zRmO5TA9kSJ0igaCHY23xLc2cmas7965ViO8dojdgFafMd74ELk4
         afzLpQT6uoCzXghRMSkNMOoIVpulBJmMx+/Y5Upi1gU8X8W1fxxuApXGCH0oS9HK5MTg
         boMQ==
X-Gm-Message-State: AOJu0YzfH/Jtkq7sYyY6XYXqGywC2Nd/2CvLYKMPYhCdXOOPtluldNl1
	NUDenlzxOXdL2rE4NMCQaBSHZQHykspDvD2BMfXjGfpR/nspm9x4iE3yQDIt
X-Google-Smtp-Source: AGHT+IF5vrPvPOUYKC9GrE5CU38M1T370ejAPI/RA03raApVM8iUNyiWJaPXur1g80Za736f5O3AhA==
X-Received: by 2002:a05:6a20:1584:b0:1af:cefe:dba3 with SMTP id adf61e73a8af0-1bae7b3d2c7mr14133065637.0.1718687880205;
        Mon, 17 Jun 2024 22:18:00 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6debasm88165575ad.65.2024.06.17.22.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 22:17:59 -0700 (PDT)
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
Subject: [PATCH net-next v11 2/7] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Tue, 18 Jun 2024 14:16:03 +0900
Message-Id: <20240618051608.95208-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618051608.95208-1-fujita.tomonori@gmail.com>
References: <20240618051608.95208-1-fujita.tomonori@gmail.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS                          |  8 ++++-
 drivers/net/ethernet/tehuti/Kconfig  | 12 +++++++
 drivers/net/ethernet/tehuti/Makefile |  3 ++
 drivers/net/ethernet/tehuti/tn40.c   | 54 ++++++++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h   |  9 +++++
 5 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e66b7d4324ae..4bb88ef9bee8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22139,7 +22139,13 @@ TEHUTI ETHERNET DRIVER
 M:	Andy Gospodarek <andy@greyhouse.net>
 L:	netdev@vger.kernel.org
 S:	Supported
-F:	drivers/net/ethernet/tehuti/*
+F:	drivers/net/ethernet/tehuti/tehuti.*
+
+TEHUTI TN40XX ETHERNET DRIVER
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
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
index 000000000000..248b17366680
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -0,0 +1,54 @@
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
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Tehuti Network TN40xx Driver");
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
new file mode 100644
index 000000000000..b45a2eef2850
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) Tehuti Networks Ltd. */
+
+#ifndef _TN40_H_
+#define _TN40_H_
+
+#define TN40_DRV_NAME "tn40xx"
+
+#endif /* _TN40XX_H */
-- 
2.34.1


