Return-Path: <netdev+bounces-100062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289798D7BE5
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3851C21708
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7633537708;
	Mon,  3 Jun 2024 06:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRD+LFSM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D522E83F
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717397572; cv=none; b=OXrj8+jhMvNg0kRN8zCx6KtjPRROjjEjKwTzrHBx6SqkocmcGtgHeaiKkFr1hilULihVscPe8yV9RPjF9LA5gYDxqL+dlYROt+8qiioCzQVk9cf0SXiBBztrNfcyfBOpAcTBiYe5kDTa9oYSds6AemLf6Roq7c7hRvuy/Jjr+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717397572; c=relaxed/simple;
	bh=4rnp4+PSK1OOPkjBI85swViXKj5E9W5pa2ukbgAhsqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QciqAY4/8oDSxJok69KYTGVegpPnAhvBGz5yWm3KPC7bTCQemjZR492CNk5zgD6JK+Qp48OteKep4IP6i0EvXQhfQJFXXdpaJob8k32gAlujFEnYvk7rEZpswmBZnA7MjQhr8+i4dDGVq93H9XZkkw6oGzwMohPQzQzg5Ede4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRD+LFSM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c036a14583so510810a91.1
        for <netdev@vger.kernel.org>; Sun, 02 Jun 2024 23:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717397570; x=1718002370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjl3Y+TI9JD8z4u/gtCsuoldwONF//aNtx4gMWmDzt0=;
        b=SRD+LFSMYaNRpqoJk7TbXgkzmkgSBQsSIp/vx4teboiKu9GezuncqX3nPgOXfZ6caI
         zN6jA9oD6KUGY35cGYQtuNj0ssH1vAsAkrlVGCRcRTcTJP1nX4PgeM0opLeQAiflQTu2
         5NpxAZXs0O6Lst7GdiYkYvCHJWA430FZ+PhSpV/nP0MB2Csr8GNzlHAt/QiVWs4HB4Qs
         vhwZyHMcIAjJFBIRvumxnN7unnZ/pJGsZDTjIhJVjIKPAjJQ8xLovuEIYgRgqN+FY99g
         pvjWrY/CrDr1KDrRF/oTiqdqZ8AZ4v2kzBuu3yk3KdJn3ib1MY4GQ9cKAvVJHtDz2ffd
         bKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717397570; x=1718002370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjl3Y+TI9JD8z4u/gtCsuoldwONF//aNtx4gMWmDzt0=;
        b=LTdYd2dZtoSoJ2zMN0aKVFIDIPjkFnamZPA/IPoJPVvlLIZsvuGgDpJtAKk5CU09sO
         vvDkSwOekKjTxvfJMIJkvPicbulS9MWH+OLc5geoKWJU7NNuW1Zy0sP8FMSlqrY7AQpC
         hjvkKo8QHDkvL04e2oi195ZoCdnqkuQG3q9/bz6FKwis2SAIj+xcW622H5y7r2eH2jO8
         h2ZDJfGIzT34pElydcE2L2oW6kxjxZm5bz7lII5Cj3PqfdNRWo0JxWdS1i2Xbogq9rZ3
         ZoFkYacBWsWWX7pXzZr1sPHGaJKFjYRKPqJx5Zk5RelgH+alZOI/YOiyWVMLWVov5bcW
         1cnA==
X-Gm-Message-State: AOJu0YwZkahQEjiIhCoPXGmTY1a8LHuAKObWU9W8/IS45CmNDGKSPUWV
	N3VbFsl67Mu4Hhq89BOV+grEVyYLtWoPv/64KpoVLZluQ50Zg2PGoB+Aq6yw
X-Google-Smtp-Source: AGHT+IGiK2DWut8MxQsoKVzSMm5lxfbr5T1IbRLWRi8Sl3BQkAlIpE2RP5l08ZGo8Aq+LBw9fY/AuA==
X-Received: by 2002:a17:90b:3013:b0:2bd:e950:dfa5 with SMTP id 98e67ed59e1d1-2c1dc5caceemr7007718a91.2.1717397569933;
        Sun, 02 Jun 2024 23:52:49 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1c27e293csm5448263a91.28.2024.06.02.23.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 23:52:49 -0700 (PDT)
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
Subject: [PATCH net-next v8 1/6] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Mon,  3 Jun 2024 15:49:50 +0900
Message-Id: <20240603064955.58327-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603064955.58327-1-fujita.tomonori@gmail.com>
References: <20240603064955.58327-1-fujita.tomonori@gmail.com>
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


