Return-Path: <netdev+bounces-92845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097E38B9200
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 01:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236BDB21393
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFBE13D892;
	Wed,  1 May 2024 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ks9UHnh7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE4168B10
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604864; cv=none; b=j2rvrDotn36sWfi7AGvPqJvbJYfjWnUtW9oIULx353EmdAxF0EUeocoWwqBlrwRhdPenrgXV2DVbbwGqI/QoYLS4mDnXO9S1tztc6tcDf57T3beQp+16UhYN3DGga1fPkpEamRENrkeVH80nOYIPtF1CvLoOg5WnnKu0x3Hq7fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604864; c=relaxed/simple;
	bh=Df7+1ZTvDT/sCjV8SkyFLdOVSF1/POwFi98bn3jOUXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBfiGHHABbbmAxM/5bDr2kXbpL3bRQb/00k55gA3vnrXtjZDFSafPg+/UBw2BY7QBg5WmYdz2O4Rf71k8wM3C9nS81b0uBorDLpeV3xwVDP5gnYoqD6hACkT+jaoj4JMSRb+FkhB3WVSOn4TwYhTzCsJr8oG1bP9ogRaVyYC7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ks9UHnh7; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b15e3fb4a8so779557a91.3
        for <netdev@vger.kernel.org>; Wed, 01 May 2024 16:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714604862; x=1715209662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yu9UcN1s0Fq0kOlBPpKB7vOD0qmrgnM/pfLnS0UJgNI=;
        b=Ks9UHnh78P/DI5yMvuj8VohW/YQejLUjxjkV3tvz0Gond/tpRZ0f9tmmRfiaO4pTNA
         LgOTdzkq/3tb/4spEWnu35LqxvRAd8cpuYBlp41UxaL1TOibMLzJwbaHomkmA0Eo0EQO
         0enmYq+PSecvA1gECeVs28rO3+8BSLR+ruH9qX7c7y2N8U9TUaC+JShy0qblh+MJtdvI
         c+XUbBQZ326p7aMAQkdc7esy6QPR+/DZxPY6YaeTuqaeBbtJQq4dYDT9qmwCAvaftiOq
         v9GR4PCFDK7pdLADz2Y4scqRtjFWzcqHBM71ZPCdS+l0NM/bA1OeMD0fct6EdBiKVAfI
         Gsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714604862; x=1715209662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yu9UcN1s0Fq0kOlBPpKB7vOD0qmrgnM/pfLnS0UJgNI=;
        b=awHsNw88WgS4Tc3yLTprca0iSaxrZuOvWGvIh+0JsbIRiKKyhxd6yRltXMWTjtyyVp
         74W/f+LgN0ArrC9LDJMclraBjuGRIiQYO+iPS1S3DXWXC/hLBzNcnTKO0lnR6WspzudF
         FTNCrnZASBVwTFMSO9W92SID9NKx0q/BfkTxEC+3pYVGvWtsIpEfP6s3/oul9vksE6Zw
         wizi7bBED8a1+VTSy2RikfjDUMuMsdm24xcqIxz9BPcNT3YHUHOkJV108RwU6YOGrjxu
         Za4q1MK/B0Yp/vz+YQhM7XLLRCjVpapeoElWm1fGLDLfHshhAprUAsjnd0wknEruSnBG
         P0Ug==
X-Gm-Message-State: AOJu0Yw8Jp9rA3Fr1EXwrD9Gg4z8AmGwJ9hOPVp21tZ7z+aYQfPMuxOn
	aqPgM69ElVlC4dSYl27+wd9B+MQsHIbJH5tmNRvaHZ73HgpBMpsFCEdjzZ2f
X-Google-Smtp-Source: AGHT+IFkVg0xaprD2r4A1lsHwdOKE0u47L5UsHX9zdTpIIzU4cG2iSE3nT/WqNBS4h8Hd/lP0gbXWA==
X-Received: by 2002:a05:6a21:81a4:b0:1ae:38d5:fd3b with SMTP id pd36-20020a056a2181a400b001ae38d5fd3bmr4570799pzb.5.1714604861842;
        Wed, 01 May 2024 16:07:41 -0700 (PDT)
Received: from rpi.. (p4300206-ipxg22801hodogaya.kanagawa.ocn.ne.jp. [153.172.224.206])
        by smtp.gmail.com with ESMTPSA id fv4-20020a056a00618400b006e64ddfa71asm23819380pfb.170.2024.05.01.16.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:07:41 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	kuba@kernel.org,
	jiri@resnulli.us,
	horms@kernel.org
Subject: [PATCH net-next v4 1/6] net: tn40xx: add pci driver for Tehuti Networks TN40xx chips
Date: Thu,  2 May 2024 08:05:47 +0900
Message-Id: <20240501230552.53185-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501230552.53185-1-fujita.tomonori@gmail.com>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
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
 drivers/net/ethernet/tehuti/tn40.c   | 58 ++++++++++++++++++++++++++++
 drivers/net/ethernet/tehuti/tn40.h   | 11 ++++++
 5 files changed, 91 insertions(+), 1 deletion(-)
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
index 000000000000..a7c4fad249c9
--- /dev/null
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -0,0 +1,58 @@
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


