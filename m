Return-Path: <netdev+bounces-91138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49FA8B184B
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 03:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602C92857E3
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 01:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEFF9F5;
	Thu, 25 Apr 2024 01:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+Z4RfiH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544054C7E
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007126; cv=none; b=tt5onru8VWAVMpXaqiFAhrioYRCLYb4eBlI8LMZP7FSWDw4olZMfmeKk27LdEsw5RJMQBj9EQVoBFDGi4Q1mlzIV47hQQmh62EwE+7nzjCpJUucVXuzQj8VP99bZYoG6KstUss5Y2slUdiWRhaIMkUf7qPDammXPBo1Ipwlp4qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007126; c=relaxed/simple;
	bh=1+YfES0rUJMtmebgsBt2gjJDpG4zb9+auOkUqPK65aY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ucljOIa9e5rDC2yCUcafz0+sHEKlpWg0Y2RtMDf4C1yQ0k9AYvMDClAvyeZYRGHQtpv/xBhH33AeQcGuw0ndAxAymNkCw1IZ7vGx6DK33OY/n8czhejm3zvN7lIlvvTBX7ZpENuIK2rn0atKdnQd7ShbsoVCO5WakmqjuENK3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+Z4RfiH; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ea0a6856d7so47292a34.1
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714007124; x=1714611924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ktERlXiL+O7F2ZilFf6Zkq2fIRwEdeAOSRMxI3TGZ8=;
        b=c+Z4RfiHP1rWF0AqrXV/udcvwymLGnnP3wwvlrrUYlQznp2pjzwct13PBmMuyaU7k0
         MIa5m5cm1eNdXuHUoIm7aXlf/ohk3zz4do4xUoWVOZXrVCwEDeXtlG7NZdlJSWUN60u8
         ZO4m11C9aK93mBM3b3DZmQK3TI4Rj4a14lsZGTT09SzFOE9ZWcNXgmc5mqZTe6itYOEW
         JkP3w9IOBeRtJlAEIYs4lycVN9KjJHQ2ZUKkFBHDsYYPr518k/T1QO7U2DsWPjoDcUDF
         /L3Y9HmNb2STi9mjpeJJ/RrCdmbpy614PnIN4SmeCGxtC45P7iWcb4qclc/+WwQzXKFY
         P7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714007124; x=1714611924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ktERlXiL+O7F2ZilFf6Zkq2fIRwEdeAOSRMxI3TGZ8=;
        b=Q43C5HFTwg79aTdjduT5nAY+VUiSsYfwTE5noF1qOx5opllhISRpBOO2QWcgDcWfN2
         rivP5S9Dw/tGxpwWqwWas5nj8NQRNxLKEfweNR6+96plpD7pMJV1r+S+rCN9ioP754Au
         CNC7uiyX/k6s8Vg+WdDbKZ0hlM526sE4BF4nygHHjR5VuvmpEEHgkpI4FoQUB/fZKxct
         BGTw0oh1jlLXwB32Guu74MkDPQYBSqsQLr1oY1XPEK47D6lnrUsyTosJI4h9fRqKDI9A
         5cFzns33gnFafSvpHiBeB1IN4Ddz3g+ZRkGIGriXJvemsoWyzfVQp8YCAtYXfid4flJ0
         BGkQ==
X-Gm-Message-State: AOJu0YzUXvoZypEIwPM5fwARGLTNQAsih4KQcnkpAamNOu4nohofYnkv
	9x8S7ivSrUQ3z0CMZt4uey5yqJzoewdqRtjlYD/RdhCpgzH3HMZ2fNYZOQ==
X-Google-Smtp-Source: AGHT+IFbrTCyNaeqlDDPZPwJf22S/gBnpgXedkZTkdHxRu9ARzKwic6kUzM9tvFTPuamSPcgsGRjFA==
X-Received: by 2002:a05:6808:22a7:b0:3c8:4227:4fb0 with SMTP id bo39-20020a05680822a700b003c842274fb0mr3535128oib.2.1714007124099;
        Wed, 24 Apr 2024 18:05:24 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id s27-20020a63525b000000b006008ee7e805sm5644940pgl.30.2024.04.24.18.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 18:05:23 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	horms@kernel.org
Subject: [PATCH net-next v2 1/6] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Thu, 25 Apr 2024 10:03:49 +0900
Message-Id: <20240425010354.32605-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425010354.32605-1-fujita.tomonori@gmail.com>
References: <20240425010354.32605-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.h   | 15 ++++++++
 5 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/tehuti/tn40.c
 create mode 100644 drivers/net/ethernet/tehuti/tn40.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c0bfad334623..c3045c31f207 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21823,7 +21823,13 @@ TEHUTI ETHERNET DRIVER
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
index 000000000000..c26f391059e1
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -0,0 +1,57 @@
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
+MODULE_VERSION(TN40_DRV_VERSION);
diff --git a/drivers/net/ethernet/tehuti/tn40.h b/drivers/net/ethernet/tehuti/tn40.h
new file mode 100644
index 000000000000..83db71ba3b02
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.h
@@ -0,0 +1,15 @@
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
+#define TN40_DRV_VERSION "0.3.6.17.2"
+
+#define PCI_VENDOR_ID_EDIMAX 0x1432
+
+#endif /* _TN40XX_H */
-- 
2.34.1


