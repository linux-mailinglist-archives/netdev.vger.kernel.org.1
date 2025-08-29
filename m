Return-Path: <netdev+bounces-218257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D54B3BB51
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F0F17CCA3
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678C0317701;
	Fri, 29 Aug 2025 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="a+TuDSaB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D703176F1
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470679; cv=none; b=ZIQ6k5TPpUT8hEp+AgaiQ4YD0YQ2hFxYKeyzo1NBq2f+kjhUa8fgkJDocIJQSFsudgE7VosEnMy4ORb2rHlp3y+R22/JL0PuS5m60ChRYhVPDrPHxj+9l2oW460lfJqV90P77sQNiWkYbrI49uLZnTmCSz2+A1ftSkpYSpmZL/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470679; c=relaxed/simple;
	bh=AxYEawSE2N3A/SjebJ3NpgKipTP1qKQH53ibGarn2wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZn/ysQHQ/6SLJKjjCLB0wYL4q0x1mROFI2xw2Pnz/LRPPJsnN1LQdsKvxM6JE/uy1qKan2sc1406geGyo++trN6ZxesB3yzXqjFLpeR7xUaAz/C/tT+DKxA87sj5fPqou/ELyFD5n+GiQbL1LXV94CfIKQq7Tb66pcb6kuHHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=a+TuDSaB; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-246648f833aso13237335ad.3
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470675; x=1757075475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8I7tlPINdJc8O0KJpNidrGsrL80VvPMNRcUF1iAFB0A=;
        b=rAjp/H7ySP802RpqsjCnCb6H5Cbr/AIjledjdueCfldTexovmkzFHebwO05du9Zz4T
         iG1OqSxZBGR1slwGbyHw06kcbI6Ut2I0pz8aGkwTYZ++ZrX++3/z0Znm6kLxrN0BZSF6
         eT/DVIkzf4GOV/+Pt/SAmVaXblr1ENmIR+NAEFpxQiuAqKrth4NC4ZT+BhmN9ML7LISH
         2oof0Z3Bpp3l8jmQgSb8u3EUo2umlwuhh+6Jg9i6GHtnj4EU3nsTKBKm7WgCZ0PQX3l5
         7C1Py34OldXNqQ5yLB83RwrdxqKJaFneEeAvsVhZQkmy50NVWYB282ONjr1BW6nSzws6
         tqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ9VVgFtcb2pX5SrmG7i9Olndt5bMqgK+gvp+fRRnUwfny0yIhQmq8TQ8Z0B1oWOUusZzjV6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjfyS0BkIq5nlWO9eJA9J/ZbZeupwoqeiwb2qFEiLovtJr+vq
	Vrr2oTIGL9sx/qPdOk92a6jirmzaJF2ofsAZszjgyDXYPPEblRwmsJ0868yfkpIwgpkSXzTb6sg
	fz5lXLs9k//aw1WlFYJLbd6js1uucbRLlPR0kr3g2JdlajU5loC7ez4LuFnGAyJjpI9a4HmdJve
	0zQle8K5/jhG9gptd7fndcEy3H+t87FmtVN8kfNnIr4i8NYVmkPoZ9aboPWWj6gPnNHfDvkBo93
	t6ZimEim8HN
X-Gm-Gg: ASbGncslTNuRB54SujSbumYYObYdVbhvZdmg2gKNgIbnK0perEjFt1ayqXVi9BqCGjs
	GjR/eqIi9o9QmlDbFsx8dYUTlDsF7sOXXjHIZ26sM0QG9pEaOYMDiJnQ1xoRVARXmzYikyVHGFl
	vUwK8hn65sbyiqNPCtRTwcj3ZhzxKmM2TyezMxmdtNIT6AVFl69kY74pkQ5Ah8lKJlR53/0lpcU
	TKOkEb9AWWm0w4BwuBeWktMeEyQ1tmvzLsPTKIp5/xKY5rHOvFU5DASdp6SSuHytPjedNAqWq+o
	8TVuWbCI45zKw0INqnCaEWFrth/IK4EnicFvCBWQORHKpXGO3i83WzYzXvm6IU0VPZ705W7VlJX
	IPnt9nOyA7F5lmEjuxi/frPAzfFk0yWWqHEDUs/n5MlVC2OyRKb4L6LMjH2v+RSZz1vzye2qrTx
	AL
X-Google-Smtp-Source: AGHT+IEQGnjDw0KaRCAUfU+i53Bcajg2w6Xb0HHhADUbAhVQs0dFni8EG5kw6mjnVTL5EOlyqR2IWfVf7Bsg
X-Received: by 2002:a17:902:ce01:b0:248:7b23:5129 with SMTP id d9443c01a7336-2487b2362e2mr172958025ad.16.1756470674463;
        Fri, 29 Aug 2025 05:31:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-327ba59133asm283927a91.8.2025.08.29.05.31.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:31:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870317642so424813485a.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756470673; x=1757075473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8I7tlPINdJc8O0KJpNidrGsrL80VvPMNRcUF1iAFB0A=;
        b=a+TuDSaBr+MNJjWLLmunKWWD40GaeLHCPFRlsbHWKZWyEJiV0qLtfQPQJVfedigWa7
         +lSB2LagAi3phIuAORJhCykUVPxD4LZI1uKo56/qiFLa6GK6FeXa2U5w9U3Cbs7B6Cnq
         4zxCznZDLKHmkLmYZazVoCB3YgkyO3Xf1eElc=
X-Forwarded-Encrypted: i=1; AJvYcCXdYuBset6MSB+kOrd73W3leEapGXsY4QdBDNQtdMszqAbBeRyZPe7NAP45AIK/WQFHrrCycbo=@vger.kernel.org
X-Received: by 2002:a05:620a:a485:b0:7e7:40f1:8d35 with SMTP id af79cd13be357-7ea10fd12e7mr2957561085a.30.1756470673034;
        Fri, 29 Aug 2025 05:31:13 -0700 (PDT)
X-Received: by 2002:a05:620a:a485:b0:7e7:40f1:8d35 with SMTP id af79cd13be357-7ea10fd12e7mr2957556185a.30.1756470672358;
        Fri, 29 Aug 2025 05:31:12 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm162384585a.66.2025.08.29.05.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:31:11 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Usman Ansari <usman.ansari@broadcom.com>
Subject: [PATCH 2/8] RDMA/bng_re: Add Auxiliary interface
Date: Fri, 29 Aug 2025 12:30:36 +0000
Message-Id: <20250829123042.44459-3-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829123042.44459-1-siva.kallam@broadcom.com>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=all
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add basic Auxiliary interface to the driver which supports
the BCM5770X NIC family.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 MAINTAINERS                            |   7 ++
 drivers/infiniband/Kconfig             |   1 +
 drivers/infiniband/hw/Makefile         |   1 +
 drivers/infiniband/hw/bng_re/Kconfig   |  10 ++
 drivers/infiniband/hw/bng_re/Makefile  |   7 ++
 drivers/infiniband/hw/bng_re/bng_dev.c | 142 +++++++++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_re.h  |  27 +++++
 7 files changed, 195 insertions(+)
 create mode 100644 drivers/infiniband/hw/bng_re/Kconfig
 create mode 100644 drivers/infiniband/hw/bng_re/Makefile
 create mode 100644 drivers/infiniband/hw/bng_re/bng_dev.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_re.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..0f0168872e37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5122,6 +5122,13 @@ W:	http://www.broadcom.com
 F:	drivers/infiniband/hw/bnxt_re/
 F:	include/uapi/rdma/bnxt_re-abi.h
 
+BROADCOM 800 GIGABIT ROCE DRIVER
+M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
+L:	linux-rdma@vger.kernel.org
+S:	Supported
+W:	http://www.broadcom.com
+F:	drivers/infiniband/hw/bng_re/
+
 BROADCOM NVRAM DRIVER
 M:	Rafał Miłecki <zajec5@gmail.com>
 L:	linux-mips@vger.kernel.org
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 3a394cd772f6..9a847a5c453b 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -80,6 +80,7 @@ config INFINIBAND_VIRT_DMA
 if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
 if !UML
 source "drivers/infiniband/hw/bnxt_re/Kconfig"
+source "drivers/infiniband/hw/bng_re/Kconfig"
 source "drivers/infiniband/hw/cxgb4/Kconfig"
 source "drivers/infiniband/hw/efa/Kconfig"
 source "drivers/infiniband/hw/erdma/Kconfig"
diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index df61b2299ec0..7f2056e6a16b 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -13,4 +13,5 @@ obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
 obj-$(CONFIG_INFINIBAND_HNS_HIP08)	+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
+obj-$(CONFIG_INFINIBAND_BNG_RE)		+= bng_re/
 obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
diff --git a/drivers/infiniband/hw/bng_re/Kconfig b/drivers/infiniband/hw/bng_re/Kconfig
new file mode 100644
index 000000000000..85845f72c64d
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INFINIBAND_BNG_RE
+	tristate "Broadcom Next generation RoCE HCA support"
+	depends on 64BIT
+	depends on INET && DCB && BNGE
+	help
+	  This driver supports Broadcom Next generation
+	  50/100/200/400/800 gigabit RoCE HCAs. The module
+	  will be called bng_re. To compile this driver
+	  as a module, choose M here.
diff --git a/drivers/infiniband/hw/bng_re/Makefile b/drivers/infiniband/hw/bng_re/Makefile
new file mode 100644
index 000000000000..f854dae25b1c
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge
+
+obj-$(CONFIG_INFINIBAND_BNG_RE) += bng_re.o
+
+bng_re-y := bng_dev.o
diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
new file mode 100644
index 000000000000..208844e98bd6
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/auxiliary_bus.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "bng_re.h"
+#include "bnge.h"
+#include "bnge_auxr.h"
+
+static char version[] =
+		BNG_RE_DESC "\n";
+
+MODULE_AUTHOR("Siva Reddy Kallam <siva.kallam@broadcom.com>");
+MODULE_DESCRIPTION(BNG_RE_DESC);
+MODULE_LICENSE("Dual BSD/GPL");
+
+static struct bng_re_dev *bng_re_dev_add(struct auxiliary_device *adev,
+					 struct bnge_auxr_dev *aux_dev)
+{
+	struct bng_re_dev *rdev;
+
+	/* Allocate bng_re_dev instance */
+	rdev = ib_alloc_device(bng_re_dev, ibdev);
+	if (!rdev) {
+		ibdev_err(NULL, "%s: bng_re_dev allocation failure!",
+			  BNG_ROCE_DRV_MODULE_NAME);
+		return NULL;
+	}
+
+	/* Assign auxiliary device specific data */
+	rdev->netdev = aux_dev->net;
+	rdev->aux_dev = aux_dev;
+	rdev->adev = adev;
+	rdev->fn_id = rdev->aux_dev->pdev->devfn;
+
+	return rdev;
+}
+
+static int bng_re_add_device(struct auxiliary_device *adev)
+{
+	struct bnge_auxr_priv *auxr_priv =
+		container_of(adev, struct bnge_auxr_priv, aux_dev);
+	struct bng_re_en_dev_info *dev_info;
+	struct bng_re_dev *rdev;
+	int rc;
+
+	dev_info = auxiliary_get_drvdata(adev);
+
+	rdev = bng_re_dev_add(adev, auxr_priv->auxr_dev);
+	if (!rdev || !rdev_to_dev(rdev)) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	dev_info->rdev = rdev;
+
+	return 0;
+exit:
+	return rc;
+}
+
+
+static void bng_re_remove_device(struct bng_re_dev *rdev,
+				 struct auxiliary_device *aux_dev)
+{
+	ib_dealloc_device(&rdev->ibdev);
+}
+
+
+static int bng_re_probe(struct auxiliary_device *adev,
+			const struct auxiliary_device_id *id)
+{
+	struct bnge_auxr_priv *aux_priv =
+		container_of(adev, struct bnge_auxr_priv, aux_dev);
+	struct bng_re_en_dev_info *en_info;
+	int rc;
+
+	en_info = kzalloc(sizeof(*en_info), GFP_KERNEL);
+	if (!en_info)
+		return -ENOMEM;
+
+	en_info->auxr_dev = aux_priv->auxr_dev;
+
+	auxiliary_set_drvdata(adev, en_info);
+
+	rc = bng_re_add_device(adev);
+	if (rc)
+		kfree(en_info);
+	return rc;
+}
+
+static void bng_re_remove(struct auxiliary_device *adev)
+{
+	struct bng_re_en_dev_info *dev_info = auxiliary_get_drvdata(adev);
+	struct bng_re_dev *rdev;
+
+	rdev = dev_info->rdev;
+
+	if (rdev)
+		bng_re_remove_device(rdev, adev);
+	kfree(dev_info);
+}
+
+static const struct auxiliary_device_id bng_re_id_table[] = {
+	{ .name = BNG_RE_ADEV_NAME ".rdma", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, bng_re_id_table);
+
+static struct auxiliary_driver bng_re_driver = {
+	.name = "rdma",
+	.probe = bng_re_probe,
+	.remove = bng_re_remove,
+	.id_table = bng_re_id_table,
+};
+
+static int __init bng_re_mod_init(void)
+{
+	int rc;
+
+	pr_info("%s: %s", BNG_ROCE_DRV_MODULE_NAME, version);
+
+	rc = auxiliary_driver_register(&bng_re_driver);
+	if (rc) {
+		pr_err("%s: Failed to register auxiliary driver\n",
+		       BNG_ROCE_DRV_MODULE_NAME);
+	}
+	return rc;
+}
+
+static void __exit bng_re_mod_exit(void)
+{
+	auxiliary_driver_unregister(&bng_re_driver);
+}
+
+module_init(bng_re_mod_init);
+module_exit(bng_re_mod_exit);
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
new file mode 100644
index 000000000000..bd3aacdc05c4
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2025 Broadcom.
+
+#ifndef __BNG_RE_H__
+#define __BNG_RE_H__
+
+#define BNG_ROCE_DRV_MODULE_NAME	"bng_re"
+#define BNG_RE_ADEV_NAME		"bng_en"
+
+#define BNG_RE_DESC	"Broadcom 800G RoCE Driver"
+
+#define	rdev_to_dev(rdev)	((rdev) ? (&(rdev)->ibdev.dev) : NULL)
+
+struct bng_re_en_dev_info {
+	struct bng_re_dev *rdev;
+	struct bnge_auxr_dev *auxr_dev;
+};
+
+struct bng_re_dev {
+	struct ib_device		ibdev;
+	struct net_device		*netdev;
+	struct auxiliary_device         *adev;
+	struct bnge_auxr_dev		*aux_dev;
+	int				fn_id;
+};
+
+#endif
-- 
2.34.1


