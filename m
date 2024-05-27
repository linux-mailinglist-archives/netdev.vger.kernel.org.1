Return-Path: <netdev+bounces-98329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C22E18D0EB0
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76042282E58
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 20:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBAA161320;
	Mon, 27 May 2024 20:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aV0rN5tq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B255338D
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716842396; cv=none; b=cxe/zj86WHDhGlGLW+ES6aM6EImrf1n+5izD+DBX4pSW+CeE5o3Oyig10D50RvBZv578w881NCAEGECuvCzDd7EHH2ac7tOw4Y9qWEX3NViJbFGYIM9vWRs4IrPXyqjVkbbGJ/k6k1JpFadCwBjWfpPJLrhdm7GkAvllaxOkhog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716842396; c=relaxed/simple;
	bh=hkrb8EtUe+8MwV15uhT+Dlmk+MxjLy1kUYvKEVt7WAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AjdjUzpIW1M81TX8g/vmAYRbu9IKzUuQizg582NuNlhsq9Ncr6pxWVQvD2zCeG9vGw+rHnk66K77KNxhxGg0JpYZAaypdeRlYzE7yme93AU9Vet5nAE8mLbMoFTvkce3qdPrrD+uvMqDJyRp3go0WC0CsnQb7ArRbFq4FrBSQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aV0rN5tq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2bf5ba9a2c5so19507a91.0
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 13:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716842394; x=1717447194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1bcZtywl4gv9RxhVaIh8Vqw04D0WxYuVcQPOWfj5pc=;
        b=aV0rN5tqMgTyZP1BLT9xR5ntYtKvEp51QMw/7kkflRG3nRn3DMz58HO5njGBgPl/NW
         Fp0RrSNA4SycjoHzlXAh+SiwQbfJhhYLqUlda9G/YvRprWCDLNRXkoCaRrThb1l1KzFY
         ew255pcuQ+fYnxqqmzfLeXZWpB4t/uHqYr4EaXjzmisBYkxD/uSqM360yvdzdLwbZpd8
         hyGlq3b9YLWc1scEGE09HdpPmC5UMJyPBysKYUH/1RsU5/tJrWg0RT1eSa5bxva7SrHv
         fAvB2fnm0F35lxyrW1upwvpOYVpmrxFseJNUdxdK3324FsBFNp/GiNLYVXnNeHQTw6Cc
         bYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716842394; x=1717447194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1bcZtywl4gv9RxhVaIh8Vqw04D0WxYuVcQPOWfj5pc=;
        b=ZI+2i9VKd8EB2RtLLJCZ7nQRH15guyk1M24ZPG4EfjnUhA9uC1ZkeT7m4WxJB94xwb
         +2jehDEG8v1RdM48LyUTPH0EY3JfD7WPcWeQs8X94BJt+jniLiXZOdcY15wOeUPRDMp7
         V2opkQPtWilut0T99UilMMpOcmzBwKwljH3S673ixB0vim4u0ZyETiTgo9xKfPq42uGJ
         b61rwUb9EwEpVHjzyMBfAHGG2kpijQ8pMBYUsK2JETvdiPHrWlT46Me0c38g8FzNzaSe
         L7asL5jJm4ammn3tHJA7qfKd5vqghMM45jq4Nkvf5aG2X7wfhZ4CRbsd3F/bENFQumHU
         Jefg==
X-Gm-Message-State: AOJu0YzfKrxAEB9YxsPUuQmISicmgaZEwZdc79i3U6CJ7XWOnXowsXDW
	pvCm5CyR86fp3BWT+MI0tu4Dk6mxzWzwkuXT4lHNflpnswumsz8riNc7tArZ
X-Google-Smtp-Source: AGHT+IGx9pwd7GhRv7Ssf7aa0tYAO5OJSlzgnCvnqs1HyyiRPzr/c+ATxW9HzSY+C/kuYweIbV/3wQ==
X-Received: by 2002:a05:6a20:1056:b0:1a7:91b0:9ba3 with SMTP id adf61e73a8af0-1b212e526d2mr10436308637.4.1716842393723;
        Mon, 27 May 2024 13:39:53 -0700 (PDT)
Received: from rpi.. (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f4960ca3f6sm26502925ad.164.2024.05.27.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 13:39:52 -0700 (PDT)
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
Subject: [PATCH net-next v7 1/6] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Tue, 28 May 2024 05:39:23 +0900
Message-Id: <20240527203928.38206-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527203928.38206-1-fujita.tomonori@gmail.com>
References: <20240527203928.38206-1-fujita.tomonori@gmail.com>
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
index 27367ad339ea..a25e620f385e 100644
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


