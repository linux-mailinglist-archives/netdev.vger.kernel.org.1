Return-Path: <netdev+bounces-239201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA371C65702
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 55EF52BFAF
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3765333437;
	Mon, 17 Nov 2025 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cSIwGULI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A6F331A52
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399578; cv=none; b=eTFd4QPTxI4TNLlZsqr6h1PiZybohySVJnye4xWYFD83ufgMZforFXOAQSIdQbyt30dxylHR/HuqJlY7F9ppypDBgTyg2KbK4CSEoyJ/v7hDmejSq1ugQP4/MO0+2K4tiToChuZxH6zynJZLZA2vI9TBk5UuLy7UtAu/HjfNMNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399578; c=relaxed/simple;
	bh=nDHz3eC1FzpL6uA+juCEMKu81/1+1H/sZuhqNVV3xhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGDbxBRPVxRzpPEmzlDF85DMQC/48QvIK2T+ATwRryZ5BJuIHkRk6sNpFzj/WMoLjdpO24xdk+5aIbAkIqMw6uYdWxMm26lUuV2DX0yLy4K4GRz1qD/R5GJ/8NgqsaqArKcSUO3I14Ck6RoihiDs8WUaeTAUM+W7tbKOFj4wEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cSIwGULI; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-5d758dba570so1858406137.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399572; x=1764004372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkWTvp5BJ0Zz51pZ2oS2FhCEN4QHYE9K3JJ+RWZxqd0=;
        b=qKQKkBkDt6hP72fXZRqRiNnPJEdqdut/ZTUvL3SnciUAW/2kUMZ2agRZaakG3ZN1DF
         FBcYwVAHWitnMO31hZHFt5VXordme51uSBL9kB7bciFsiqsy8y0P3ByHhF4erl4+n86G
         qftGXrk+ZaR9/kaoyBU9VTVXhUJydaJeqAu8c0Vo9fAJZI7D9fNQxisqxNAsxdJPYXV8
         EaLhxFLTLvJDzjQY/vuLXG4bm1MsLc3XEmallqaYHlDBiIeTfbjXNNZNYAYz56J5aWH5
         1zMhP8N1ESdFIW6rik6a9zDzlXHmG0mTiYhX/+FIOmV+ZUxk1d7VObHpdVywIOQ6dnx3
         u8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCV5hvKrXGN2bPkBGqCYwZq15xm+lPv3e4Ye3PlfUZLyX2qXNdW6XKv5M93krFVndWbYwhFXNbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvjl2gvALevXlxbSSc5Tl/RzsKSIDqNi9eeep+rtgtPAwqvZWa
	8arqOFcwCO2gAD4YzmAHKmVGLWBlMgrLMHy2Gv0rSriDgVx3QLbzuW7S/s/Yuw+2Ha206oOqHRM
	bHbaKTI4sFtx/XdPdRaadVI2fpmbo1+M2iS6hYLuuT5kDHuFOulIJrIKfOYszh8ANlJ1YT47GJ5
	6rgbvXW8aG/Gc6w8Ky6GXj2f2ntQ9w5RDubT1pymlJuM8jICqfIjgldAWHGTgAolDnhXb7WMpMb
	7xLf6wxWciu
X-Gm-Gg: ASbGncvKGNMsUxu/AdTiqhODari1obt+a3WXFEBuclpXgWEu90djF83B/+z5h6ATcjN
	mnPEuc/uy1oizzfAEawBroePZ7OrYPXfGMYQkvkSDtpJDhSGFclFea5uQq8yGuJ7wKodKU6IVZ+
	5kpy6A/MXsnBPeuKejRjP3TzfyRlL+khfRHSh5HdIjU02Mu7rcCjqtZuAlOd8VfOOkTtRUBFKia
	alTWqW/KmRHEnfTmKbWdbT4NU1oy8vqtH5vLK1aN9EjG7FRkC7qECkEbzKLPixLXRTHeLiEqKW+
	CSc1RWmKObBf1fpdb3GPu3v71wFlWQ6MD/c9oHSPACb3y+T8Aq8H+J+6HYc45sB8uwT0fMDvq0d
	89+RE9GxnJnjcY01Ya6F/3b/Aja+cL2TdLJ5UoOzc8WR32rZI0VJfrkquAOW5hk/q0cQUj8mZ1j
	uACqaVDVaxe6F6w7NiH2c28p354TyATODA
X-Google-Smtp-Source: AGHT+IFTxMppL1NjTGQvFzpr5wdqDOUBRmvwq3QyQwHFhI+wIgQ7knXK5V1Lbw2VLuAT6hIRd8CAzG5hJhWA
X-Received: by 2002:a05:6102:cd0:b0:5dd:b2a0:ac69 with SMTP id ada2fe7eead31-5dfc54e7ecamr3553860137.5.1763399570990;
        Mon, 17 Nov 2025 09:12:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5dfb708456dsm1530513137.2.2025.11.17.09.12.50
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:12:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8823c1345c0so63484736d6.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763399570; x=1764004370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkWTvp5BJ0Zz51pZ2oS2FhCEN4QHYE9K3JJ+RWZxqd0=;
        b=cSIwGULIVyyp1mVfU4OJTF1v2G4YJ46KTTvBAErN2tzBQt4OwAoGWqEI9aR0Pd0nZ5
         DTFuQgVclueFwgiTWsxKDZ8rAvvbqE9CIFsy19anhRoZYyz0oMO3kmegRxPZy1/x1Ntp
         MnJYGtw4jGWqEkzX0N13yjsNQSYUMuSN+RoyY=
X-Forwarded-Encrypted: i=1; AJvYcCXRBmvK+XvszFB6XHE9bAMOJe5uIosqAE7RrUMe150yArUM7WVWA+4Xmomn2udrXiiiicHUcZI=@vger.kernel.org
X-Received: by 2002:a05:6214:d02:b0:87c:1ec5:841e with SMTP id 6a1803df08f44-882925a3fd2mr200879556d6.8.1763399570331;
        Mon, 17 Nov 2025 09:12:50 -0800 (PST)
X-Received: by 2002:a05:6214:d02:b0:87c:1ec5:841e with SMTP id 6a1803df08f44-882925a3fd2mr200878856d6.8.1763399569822;
        Mon, 17 Nov 2025 09:12:49 -0800 (PST)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314557sm96082236d6.20.2025.11.17.09.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:12:49 -0800 (PST)
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
Subject: [PATCH v3 7/8] RDMA/bng_re: Add basic debugfs infrastructure
Date: Mon, 17 Nov 2025 17:11:25 +0000
Message-ID: <20251117171136.128193-8-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117171136.128193-1-siva.kallam@broadcom.com>
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
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
2.43.0


