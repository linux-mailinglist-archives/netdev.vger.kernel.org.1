Return-Path: <netdev+bounces-225302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0E9B920A3
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89314162EBD
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF352EC08C;
	Mon, 22 Sep 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b7Er1Bh3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D62EBB87
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555836; cv=none; b=ObGDlpq2BXeCtwPCKNhryeY0QFKmKURkEeCIwTR3fpH2w1nAUQmlRmHvuiL9HD6MF08xR0rCngk7XnYhN0dvCXXBJIpqfgQgB2+fna7f/DXraOJLfTmJvec0XgzU24PThAhpv3JXLwZHNdHpOUWImE0n6oH3txL1L7kgIdblEa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555836; c=relaxed/simple;
	bh=J4LifS0XFxE9XnnUkpq/M7Ahh2VjCfmc40Jk58R0ZCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmNbQonMB75YUjbNAvhS+BxfXLz5omSF+fwZ/BoHHC246fbNgWd2DwG5NtEShH3nkmqUW2ebdby9cs8hrmZmMgeJ8XcfbZ8Ku5Wm6EBx3Gb1UrDVjiWkbBjMBV370KfQt2oKz9O2WEMTC5QstnhWLp56h+wIYZP4jURrE3DKzvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b7Er1Bh3; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-279e2554b6fso7605115ad.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555835; x=1759160635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiAUve12B6y0VXa7aGKojambByjOg98b5E/1OlA7Abs=;
        b=AqycYCgmkBugi3DdJ5MeSXkxLXVv8zj9xGVtNoYQNE5DBH9l9VuJMKA52iLC0TirNK
         8pR3pNfBHQDV95wpswkfCyqYbcMk0KK7M0/QEWAjrM6lHKBDKPqecxd4CkejRODVPPBL
         JDTzx7T5Yfw2de3T+FOTK1d77WDYd9u6F+96jpXDgIT2S6G7WI2bRoXLgp1ng8q8TRRH
         PQ+midKh/wwpzNbM/KnvnjfIAkAyVBxuJDBzbxFoUJIYAtq16M5eKQEVTPBZ4OA2+iLF
         PWVraHTKKT81Cnkhk3BEpQcdI0jaPsQELRjuV/C1FHuHH4egvVnhc9e+ozZHMeYXkhaD
         smdg==
X-Forwarded-Encrypted: i=1; AJvYcCU9FgcQKcD/Alm7ly30xjuZXiqmTA3c5DzIDZwEYjd/vWtiKP8jcpykeEQ/Y9U+VhYfzEeg3Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye7t0UpGq/qNdoJ5naPyQRJS+rhbhCjlaBNtp29xXtNUHIT/Rz
	SR5xGI6rHzSD2KPXPB8MEAmx4ZHg6GVz3W5ZUcu1tsr9mPJdjTJiHvn9eMn1f2opSFyTwGIqyi8
	WcXC+gESRbJZlcOZRTBQjqt75Aq+kSp31lVbhNdZ1/mcsUW+RkQ2LweZqwvfAowDm5vULNaoYNL
	AStJkTIjJuNmraK+n3/6jr1WRof8i1IAPHijV31D1wuFXriifJuNchlSTHjm0hOJ8Mz5XjCLpRU
	fopYgjPQ8Zz
X-Gm-Gg: ASbGncshCvh8oB5zl2UjBELIzWdEM7M3UH1Gbo/CrsVwqeKP8oGEOCSq8JnPya2ewD5
	+Gc9/iyEY01+FrrlKIhTNHfHZGlNAaQlNN6ekT4+x5CtQBheZbm8V3p/quEHkYWNVjb1l7cvfT6
	MxW520nZJJVsLjgcv2tzLfPDX49aUnusWNatYMA/q0Kfirt7kTuoIddY/j0Wk8ybrUrx4qAdg1c
	aBRN6eYFURBMu8Jagau2i39yPRqosplhb+4sNWdS/IgX4I6W/ExkDe7ziDGtaX9R7/BO0KVgnBS
	vOxZ+hJmyuieMpu79aZ/WCB/TH1YV/AJFGiLntsEweAFsbhuxjcR9sgLBQNsHd8s8ei0yeRKlJz
	dn22AeuZ0pQhDcVGVQLwX2bFXB/34smWYJxcDFIYFyVt3Y+/uooTVqJ3dDFhdlL6GuSX6VODN7Q
	==
X-Google-Smtp-Source: AGHT+IEvhlAlDOR8c1HOFpyHbAZGYFxSW2pedbTxrMtlJS+vCG/4IRjwjFU5ZfPReXvHjQ9Mbio/dVHpd1Of
X-Received: by 2002:a17:903:b48:b0:240:48f4:40f7 with SMTP id d9443c01a7336-269ba51646fmr164930785ad.39.1758555834640;
        Mon, 22 Sep 2025 08:43:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-274ade77f17sm2859485ad.48.2025.09.22.08.43.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:43:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-84b9c23b8aeso192331085a.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758555833; x=1759160633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiAUve12B6y0VXa7aGKojambByjOg98b5E/1OlA7Abs=;
        b=b7Er1Bh3ai3gVsMW+Cno2hhgZ03t0RnwtVRTUvlFs3C1I6PLTBgX5xJTOqIoOhSy/O
         tbMd/d01Or8BaBgkof33DXlQyTlL5AxsY1yp056nqEqPV9WvYSlCyOLc3DuBp2L8aUjN
         LJb5vu2KuWRnNxxKAl4TZ5G+Eem1VB/28exv0=
X-Forwarded-Encrypted: i=1; AJvYcCUk/3QDV5hbmdKJ/rjfdY84cPz3awbQ8s/xQWJxcylaSvgXAAdshJlzK+teSOx93pkWGFwbySQ=@vger.kernel.org
X-Received: by 2002:a05:620a:3943:b0:84f:f50c:ec00 with SMTP id af79cd13be357-84ff50cec3cmr96893485a.60.1758555832853;
        Mon, 22 Sep 2025 08:43:52 -0700 (PDT)
X-Received: by 2002:a05:620a:3943:b0:84f:f50c:ec00 with SMTP id af79cd13be357-84ff50cec3cmr96890485a.60.1758555832278;
        Mon, 22 Sep 2025 08:43:52 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84ada77bb17sm179496785a.30.2025.09.22.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:43:51 -0700 (PDT)
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
Subject: [PATCH v2 7/8] RDMA/bng_re: Add basic debugfs infrastructure
Date: Mon, 22 Sep 2025 15:43:02 +0000
Message-Id: <20250922154303.246809-8-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922154303.246809-1-siva.kallam@broadcom.com>
References: <20250922154303.246809-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add basic debugfs infrastructure for Broadcom next generation
controller.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/Makefile      |  3 +-
 drivers/infiniband/hw/bng_re/bng_debugfs.c | 39 ++++++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_debugfs.h | 12 +++++++
 drivers/infiniband/hw/bng_re/bng_dev.c     | 12 +++++++
 drivers/infiniband/hw/bng_re/bng_re.h      |  1 +
 5 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.h

diff --git a/drivers/infiniband/hw/bng_re/Makefile b/drivers/infiniband/hw/bng_re/Makefile
index 556b763b43f9..c6aaaf853c77 100644
--- a/drivers/infiniband/hw/bng_re/Makefile
+++ b/drivers/infiniband/hw/bng_re/Makefile
@@ -4,4 +4,5 @@ ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge -I $(srctree)/driv
 obj-$(CONFIG_INFINIBAND_BNG_RE) += bng_re.o
 
 bng_re-y := bng_dev.o bng_fw.o \
-	    bng_res.o bng_sp.o
+	    bng_res.o bng_sp.o \
+	    bng_debugfs.o
diff --git a/drivers/infiniband/hw/bng_re/bng_debugfs.c b/drivers/infiniband/hw/bng_re/bng_debugfs.c
new file mode 100644
index 000000000000..9ec5a8785250
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_debugfs.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+#include <linux/debugfs.h>
+#include <linux/pci.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "bng_res.h"
+#include "bng_fw.h"
+#include "bnge.h"
+#include "bnge_auxr.h"
+#include "bng_re.h"
+#include "bng_debugfs.h"
+
+static struct dentry *bng_re_debugfs_root;
+
+void bng_re_debugfs_add_pdev(struct bng_re_dev *rdev)
+{
+	struct pci_dev *pdev = rdev->aux_dev->pdev;
+
+	rdev->dbg_root =
+		debugfs_create_dir(dev_name(&pdev->dev), bng_re_debugfs_root);
+}
+
+void bng_re_debugfs_rem_pdev(struct bng_re_dev *rdev)
+{
+	debugfs_remove_recursive(rdev->dbg_root);
+	rdev->dbg_root = NULL;
+}
+
+void bng_re_register_debugfs(void)
+{
+	bng_re_debugfs_root = debugfs_create_dir("bng_re", NULL);
+}
+
+void bng_re_unregister_debugfs(void)
+{
+	debugfs_remove(bng_re_debugfs_root);
+}
diff --git a/drivers/infiniband/hw/bng_re/bng_debugfs.h b/drivers/infiniband/hw/bng_re/bng_debugfs.h
new file mode 100644
index 000000000000..baef71df4242
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_debugfs.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2025 Broadcom.
+
+#ifndef __BNG_RE_DEBUGFS__
+#define __BNG_RE_DEBUGFS__
+
+void bng_re_debugfs_add_pdev(struct bng_re_dev *rdev);
+void bng_re_debugfs_rem_pdev(struct bng_re_dev *rdev);
+
+void bng_re_register_debugfs(void);
+void bng_re_unregister_debugfs(void);
+#endif
diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index cdebe408f50f..9dbd8837457d 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -14,6 +14,7 @@
 #include "bnge_auxr.h"
 #include "bng_re.h"
 #include "bnge_hwrm.h"
+#include "bng_debugfs.h"
 
 static char version[] =
 		BNG_RE_DESC "\n";
@@ -219,6 +220,7 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 
 static void bng_re_dev_uninit(struct bng_re_dev *rdev)
 {
+	bng_re_debugfs_rem_pdev(rdev);
 	bng_re_disable_rcfw_channel(&rdev->rcfw);
 	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id,
 			     RING_ALLOC_REQ_RING_TYPE_NQ);
@@ -318,6 +320,9 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	rc = bng_re_get_dev_attr(&rdev->rcfw);
 	if (rc)
 		goto disable_rcfw;
+
+	bng_re_debugfs_add_pdev(rdev);
+
 	return 0;
 disable_rcfw:
 	bng_re_disable_rcfw_channel(&rdev->rcfw);
@@ -424,17 +429,24 @@ static int __init bng_re_mod_init(void)
 
 	pr_info("%s: %s", BNG_ROCE_DRV_MODULE_NAME, version);
 
+	bng_re_register_debugfs();
+
 	rc = auxiliary_driver_register(&bng_re_driver);
 	if (rc) {
 		pr_err("%s: Failed to register auxiliary driver\n",
 		       BNG_ROCE_DRV_MODULE_NAME);
+		goto unreg_debugfs;
 	}
+	return 0;
+unreg_debugfs:
+	bng_re_unregister_debugfs();
 	return rc;
 }
 
 static void __exit bng_re_mod_exit(void)
 {
 	auxiliary_driver_unregister(&bng_re_driver);
+	bng_re_unregister_debugfs();
 }
 
 module_init(bng_re_mod_init);
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
index 7598dd91043b..76837f17f12d 100644
--- a/drivers/infiniband/hw/bng_re/bng_re.h
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -76,6 +76,7 @@ struct bng_re_dev {
 	struct bng_re_nq_record		*nqr;
 	/* Device Resources */
 	struct bng_re_dev_attr		*dev_attr;
+	struct dentry			*dbg_root;
 };
 
 #endif
-- 
2.34.1


