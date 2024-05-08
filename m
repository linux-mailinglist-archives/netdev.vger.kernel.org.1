Return-Path: <netdev+bounces-94528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912298BFC7E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 13:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B484F1C23421
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459C1839E3;
	Wed,  8 May 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRQJ7HYp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278382D64
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168610; cv=none; b=cC/DiKurLNblsaAWeWt5qVfBERzoTkt/V5iRdbTgpCvmBMpCc5jelY6NoRFdbgKo3LUtlxTE9TccV2CSAtuM159X0hUK4/5XHynQNbLb/+TnZsM0wDtkLEPW7FVjQN+MZtUWfEbATa4pNVE8zdNENfH4O/0zxhOkgp0fi/kCJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168610; c=relaxed/simple;
	bh=4ULD8hFjDaSItSUuEg/9Ox6BoEib/yULpqMjRYxifWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrRYhoEGTzr6Do6qye4kgf0zlh7xMHBg93raJJEGdgj0Pw7QvGB0VnpNCSTMTGOFVferLOB7GhCKqaeJ4AJcCoktTk9GEOTjXU8LBpusOdSpC0mZKUfwb+KnSkWCc1xYGXpru8gtK0NbeZXXKcEQiU8kvG1Vbs0FkkduUXPEBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRQJ7HYp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b620b0662dso184960a91.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715168608; x=1715773408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJDxLQ8fv8Qeejppo9c+q2ZeEo1yb/1Z8I5fz2Gw1is=;
        b=hRQJ7HYpQMcnuLfDvLhTfkX5gPo5EkfQMsCE8hI943xdbImRm23geXfmytc803+BoX
         DzpKedC26N2SFoCoUj0BwE+edJCwmMOVhuiRXyIEQoTAf6GE3U16rS21cltlferGK7VQ
         qaH+SFW1MqL5+t5oJPxhY0Yyp+g2JpPULmQgagzC4MEAjUPmA61vQsqRUKjb7zpzil49
         5IQ/6PHKyKixbxTsnoJt/tILX4AQwo4dA9jYlOADBGJDfWL5Dt8o3cgvT4HvIHIitdK1
         bPnxLeSVor0bRflMA39MBnGOVeG9Y/u15Gm6Mv5UlbAAq+cVG+9YVeSXyKW6zyIzTUNC
         6m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168608; x=1715773408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJDxLQ8fv8Qeejppo9c+q2ZeEo1yb/1Z8I5fz2Gw1is=;
        b=aeQgWIfL1I0YCcZFavYV03B4L0oY8qE8emkQgAYJRvj9CU3SepeTrCtJo6/PbI+H7K
         qr2d3ePlrDqBNNLwfb9S/xxgXYnpYJzZ1CYga1jE41m2+4y/lzWL8tgabZCJ1AMcb2xg
         UjVPdrpkvOj6W+CaRIdlY9g7qifKuGbIeAiY0m1v9g0Uh96/cZS1cVLME5XMcAHGZYOD
         pv+oHfjS8LnjCJmOtI5sHqtXoB7G2hGit8hh/+RKwhAXi+T7f91pqNK/ZbdFiwfs0rdt
         qEhFLT1JRtcAnyhBDBoqFu87gVNex6k1okpr58zlWysuoR2hcJ8wCiRRBWca0KCi4nXJ
         8mLw==
X-Gm-Message-State: AOJu0YzDVK5ooViLklAMdbB4MPqWK5fiscbpwqCD40+lDoNONfpXOm4y
	WlEkijGm7sWEwxmNNYenoXdKY18QwAFA7Kn/HQ8zLKpNPUip3ZASpxHwek1y
X-Google-Smtp-Source: AGHT+IFT+Pu38eqcAkB84duLuG7djJjrHOI3JKDeZAyfYRvxZETVlBhdbD8yGuTQDWni4MFvhM6+ZA==
X-Received: by 2002:a17:902:d4d2:b0:1e7:b7da:842 with SMTP id d9443c01a7336-1eeb01a3ce1mr25623025ad.2.1715168607720;
        Wed, 08 May 2024 04:43:27 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001e83a70d774sm11620938plg.187.2024.05.08.04.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:43:27 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org,
	kuba@kernel.org,
	jiri@resnulli.us,
	pabeni@redhat.com
Subject: [PATCH net-next v5 1/6] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Wed,  8 May 2024 20:39:42 +0900
Message-Id: <20240508113947.68530-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508113947.68530-1-fujita.tomonori@gmail.com>
References: <20240508113947.68530-1-fujita.tomonori@gmail.com>
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
index 294e472d7de8..07abdb0de37e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21840,7 +21840,13 @@ TEHUTI ETHERNET DRIVER
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


