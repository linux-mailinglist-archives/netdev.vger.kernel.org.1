Return-Path: <netdev+bounces-105964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D9913F4B
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 01:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02DF1B215C3
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B52185E5F;
	Sun, 23 Jun 2024 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxjdEGwq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DFD186296
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719187009; cv=none; b=ohwpuBmV0OPeDTx9qoHRR3kX6wwlNlE+A6lZwrJHs46QQmUF1M+kyyXZcpewtSYu1/wpnF8PXENuBObMh4ryCZIjMn2pIwVyGz6uMPn7oWZwEzAnUt9fXM5ZZyY/GQqdJGqaoQ2tXF0/dyxyF9mgbt7v1kXnyygm8AGAJ+4ETWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719187009; c=relaxed/simple;
	bh=1mXXdPT6pqAsxMpol14VhiUCNMfjAn2Hh4f31ppNiho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X2qU1lngUGoxcxj2ihMciFfWubaDALZsZRpe2Ofw8oyzi5is8mdCgNCN2rl2SGXHvaXy9pD80lgalqNaVTTDiLt6moUo5R7iBqHyJBRaMk2u60kmvy4QQ+BYPLkQ6/Jx0t7ThWR5496SOm54otRcdbm1NMNeYe6/h1sH0PX8zwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxjdEGwq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c2cb6750fcso690034a91.1
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 16:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719187007; x=1719791807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hacp8zus201MviAqdvswP8+zamILuRUVlfN2GYtUVBM=;
        b=lxjdEGwqT+dSRqzA0bqf2mX0lMYU3oipx9RgseiCYXYuVD0ouBLQRU/x8mBRInM4Eq
         eioJZShKu/vfOveQnFpQ3qL2qw4xkd5Mlle7HzK6zz7xMPLqzLrWnxMR2elt9yg6YGF5
         kpoKxSPZScwJyv7dWwX7U3KyFeFiZZBlEofb+6TD8tK5OcXfcgXJTuQqX5azSls6qt26
         jSVq3kZDEXzz3UR/iEXb1QVokPSxzPO/GDRIoon1PLIQimAX3TQDBtENN07/vInnK4fi
         1CfWq3tU5I6h2i4hIxmTY9pWrPhEeyrGbX9m9HpGqMkQVJfd/HzVrcV1nuHQNgt51vI2
         Imvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719187007; x=1719791807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hacp8zus201MviAqdvswP8+zamILuRUVlfN2GYtUVBM=;
        b=A4ykd46W4KI60AOGk3EbH0Ld0FM5V3yfXyqDfwo+VibllklswlQd/jB6J8W+TC7JmQ
         eC3T3dl86+Rbo9JJpaKlH/JPH3QvQmkXAy1aa/iwduPy1WK6KKcffTf8PMEI/scUcTw+
         NUri/cw+z9l4oCojsXpR+mAezi4hpaDa1c2k9BMp3SOdqBjns7pBooEl6yOi56yH6FCx
         rHXnKPhq3n/cdRxcfnpn74E3sWI3Dv/yDLOqP7NXhj+peCgcwJmEXbWiJG8OqH7CEJaI
         yBL4L2Te/H4neQ9z3W4hSaTjB4mBRQBLy4P4c67yUpa19tGuKvIqDi4uW1eQOlsTxUYs
         ZFQQ==
X-Gm-Message-State: AOJu0YxDDIq5BagB6+JedaHp9HNsRWzS2HGxD7Joev4ykF5TrsFobdAG
	ydOQQK8T+4KnfcoMfO6k8aQfSH96kQkyCR5ZCJyWTl1Ndq48UktCWTfvLC9z
X-Google-Smtp-Source: AGHT+IGdFYZLYHWKMmZKboA7KgAU5BWk0w0Eb7i31pL6UqU/8hnC9LnGQGmxYivlyFRqVyffkWGHOA==
X-Received: by 2002:a17:903:187:b0:1f6:ee76:1b35 with SMTP id d9443c01a7336-1fa0d8217f7mr54239685ad.5.1719187006958;
        Sun, 23 Jun 2024 16:56:46 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb1d448dsm50501985ad.0.2024.06.23.16.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 16:56:46 -0700 (PDT)
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
Subject: [PATCH net-next v12 2/7] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Mon, 24 Jun 2024 08:55:02 +0900
Message-Id: <20240623235507.108147-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623235507.108147-1-fujita.tomonori@gmail.com>
References: <20240623235507.108147-1-fujita.tomonori@gmail.com>
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
index 0e3cb040fc16..bc97ff8ce6f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22148,7 +22148,13 @@ TEHUTI ETHERNET DRIVER
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


