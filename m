Return-Path: <netdev+bounces-225297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8084AB9205E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8DD3B350A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B7F2EB852;
	Mon, 22 Sep 2025 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aDtEux6C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474862EB844
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555815; cv=none; b=FAJ8u8U06R4Foy1PRe/Iw/Q135yKxEafMv6sJfaHjO7jXqn9LAD/lQaqeijbcut1u7lAtXD30ENJPGpiSD3iIkDSGyRRLe/5ot1FzPq4U9In8yFIIy8C0en6PI8LkUzQMRjqd5whOp04/94RRijbNvylKknmYsAY9qAuBFdlvYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555815; c=relaxed/simple;
	bh=nvS/W6KyxMZxG8V8N050+H9gunEqjBk64MEWWL8UZZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtiYU3yCC7HDSDSZFgnhprgJiMPsSgZHlYF/yCTqBx1lJf3b5Cz7gZd5qxgtbgPdLKdRR6w9K/D00xXeJNkrwFdbyZuBULAM1s3MC8NJPy3iVUBGC8m+K7FyPXYPk83nZpHCRx595l2z2e3vCT7c6SlFUPH1GKHZZAjOwBSNBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aDtEux6C; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-826fe3b3e2bso488524285a.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555812; x=1759160612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEVkZUHr9+nmdKm/NA9YeMe1Jm0/YNgYQLjrx3Tp1/w=;
        b=nERv0LZjFju/h8ggqaW7CDBH/wxWRTRKkUPMBddrDPX5rMNlhw/GJ9IwIzaSqQyMxC
         UYbKIH7vJ9q8CBZRCK8eRYciTX5b46kYvDgeKpufsHLCh3/Q5T45JlsxmlL+15t48TpN
         BySUAUsNcK2/gcTfaUV3bdTnB293kxAP1LVk3PUGEa9enTTbGUdhzdx5roeecmtxF1N3
         H8gt2J1jSui3hrUQcYQzw3zEdBQtI5wF2K1vUE+S9PsfjckgbYRsb2Eeada6BH4faMw7
         DMu/QVmf2hG+555FnwDHbfTCw+JrCXXoxlnsNE9Ngj3NHzjUp0J4fbDSRUteUu3z2Sa3
         EWhg==
X-Forwarded-Encrypted: i=1; AJvYcCUeONeN+CRojtsbsp/QFABWQYozNwJIJR2uv5OuhE/SyP6D0SaXzJ4WoNoSW3SVutxreFN5u1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tzLcK/8B7cgF2NXjJwOpn3/a5eIOaF4gBHIf+zY9cXViEMee
	0B1gvKP/7VWPTp//DUB2rLzjC2QVQCOCVrTjLUhkrQfvQfVt3F0y0upma8tYE1dFOqueqMJe4qu
	1qABlX4t2MyazKFb/MuQpUf6OrlUKwJ5i0owWwVvPe4cd/czvEGPxuCm4OjVoeMB5fim8Lx5aEm
	5133OcOuUwAHte+wGghlMG3ohIIKT2pGx7fIW6P+lSWIs28Mb1OvVHsV+HnwikTZ9hDWy9h5frf
	9TeaZd+5VGP
X-Gm-Gg: ASbGnctb3PN7UvVzE9mTMk81yVh78SJqHUK4tKtA32eps/AhTi5sBJs5eAJ0/X5VcVe
	Yy2sAg8c5fBAwVJ3AmMhYe9AfX/znZUIfmiU0w3c3YT4gSwhK1XGDZn0ZV5Ux+5Rf+S6jK7fRTP
	LuLX9WylhtswPg4ZN0CMMAMCqqGV3ExxHZldbEVh1ecLKR4CC9MhpqAzoc/sBIS/sRx8pMzJ6hY
	byG8QIW9u234TtZIi0J20mUEL8vt60vPdfjoTgdb9xogaSg9jVma1wm7tw5GWF7onW5trzsq4kD
	Y2BYmF5AJTpxMjNt2EnOnDo8lAONy7QdlHCrLO/zLiqN8eFL+qloHFCbl0b2a27N2onCWLxQW9v
	lTUNBUOkC78W4ZaEhyssM4nbAyrfMsdfmvCDDE/ouHv7fklOVT21hKhwFTW1p0N+Aqs924I1p+w
	==
X-Google-Smtp-Source: AGHT+IFoRFzeHQtpQKLcsFkM9PG+TjSTFg4xJRenk4QjhEwpdnsNTcvfDdVoGbNS2f3ICvhiYGHWtVDnnEXb
X-Received: by 2002:a05:620a:2914:b0:842:5d9e:d4a0 with SMTP id af79cd13be357-8425d9ed5e3mr1004903785a.6.1758555811845;
        Mon, 22 Sep 2025 08:43:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4bda5ed2fa5sm2671831cf.12.2025.09.22.08.43.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:43:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-78f28554393so65854406d6.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758555811; x=1759160611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEVkZUHr9+nmdKm/NA9YeMe1Jm0/YNgYQLjrx3Tp1/w=;
        b=aDtEux6CagwkWis9HY+X1nqJLIKUVLNDLlYY4mSSVrxJQvkHUgkFWCk5qM8VlZw/d4
         56Vrgc80dexT1hh1YSgWUHqmRUlcgFqOfrJuiriWQX358KH11SAk2QZlEq5lQAwRGx8j
         kQ+9cCLNk35PdggIdqkpbrF2nsAfx87kmYGJs=
X-Forwarded-Encrypted: i=1; AJvYcCVpyXLqi5qQgDD5XFv7RORGnvWpD3pNDdzXWoMLSZxnI2bn0hn7FIRaolVOqsIsPCBuAWcAmuo=@vger.kernel.org
X-Received: by 2002:a05:620a:9489:b0:7f9:ec3f:b047 with SMTP id af79cd13be357-83ba29b676bmr1017032585a.2.1758555810597;
        Mon, 22 Sep 2025 08:43:30 -0700 (PDT)
X-Received: by 2002:a05:620a:9489:b0:7f9:ec3f:b047 with SMTP id af79cd13be357-83ba29b676bmr1017029685a.2.1758555810013;
        Mon, 22 Sep 2025 08:43:30 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84ada77bb17sm179496785a.30.2025.09.22.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:43:29 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH v2 2/8] RDMA/bng_re: Add Auxiliary interface
Date: Mon, 22 Sep 2025 15:42:57 +0000
Message-Id: <20250922154303.246809-3-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922154303.246809-1-siva.kallam@broadcom.com>
References: <20250922154303.246809-1-siva.kallam@broadcom.com>
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
index 088558cc8b18..b29b1f58b0b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5131,6 +5131,13 @@ W:	http://www.broadcom.com
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
index f0323f1d6f01..794b9778816b 100644
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
index b706dc0d0263..c42b22ac3303 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -13,5 +13,6 @@ obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
 obj-$(CONFIG_INFINIBAND_HNS_HIP08)	+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
+obj-$(CONFIG_INFINIBAND_BNG_RE)		+= bng_re/
 obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
 obj-$(CONFIG_INFINIBAND_IONIC)		+= ionic/
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
index 000000000000..08aba72a26f7
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
+	if (!rdev) {
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


