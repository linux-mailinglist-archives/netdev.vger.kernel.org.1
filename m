Return-Path: <netdev+bounces-218263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1436B3BB60
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0899517AB8D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A727F31A06F;
	Fri, 29 Aug 2025 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eroPlF02"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23338317700
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470710; cv=none; b=sgkAx6T8F9DO57RWcFoQVV5VsKQhZ9sj7BCF1NS8ZlbwwrUWlhcbh1lp48LqThGn85SPd3KVaQLZpdMUTMfi+rfrsmIGVPWHPdPE5pErGEa8GKvkJTFBpCEyXgvHtY6d3ajRCCrb+KSbypE882V1VR2ZrdXgOpgNu5GRsQrIZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470710; c=relaxed/simple;
	bh=RIFRi3MNJGSSdjQM1Ui6VxpUsWC/b8GxminKx27eVwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JUAS87r0SVvMGdf/8ZKAh65N+KK1EZsG8+PlLvuVG0oZGKC99pOPGz2Ufqb3VS5Q6GwnLXrd9Pw1OZKLL62vkSscRkDScbwXQ3M42M1qjqSG7g39WEWrqX1iJLhUCfL3lib2wNcTOdDxOFHzlPMCPZGSdl2IHS/QAwTex2qqOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eroPlF02; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-771fa8e4190so1454275b3a.1
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470707; x=1757075507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ocs1O7M+XeHOMJsN32xtyWTZCKjfIDggqthostXpTY0=;
        b=dvVRdnp5eJBIhAuDUbyRh508/4Tt8OjvLO3a9JhB1rCzMiR8Vt9KEGwzER1a2GLu9Z
         KrO9Mg21jTg0NV9vupluwJSUj394LbGf684nycFTl2uXbyLviO4cviPhBQ1y+nUHMBw+
         tGDote36w1Ou6q3bKOlmmIINavExirEwrqBjS7y4nvbT2hkr+GzcZ1dvfBi4MrimvpPr
         wZanh0IkFCvKof5ZMDDjuI2mDFuebKv5dJ/DaePnRn8LQ5NHd1yY19SmwSX69IkJYOnZ
         CaxhqRyp8XHMcfHWh6eK6b+1rygGgkpMCvMgiosUMAyNFZX9MYW3EkmxVHzgoO1jEFrs
         YANw==
X-Forwarded-Encrypted: i=1; AJvYcCW7lqV8caVGQv2VuoeKaKLGZrw1jRoHhtpa41YYAMEP9Bkctrj3fTfTmKanIwscIhgsTMPhAo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeR6EgQmTHm3LluXsxF947FGPn0iDyhSUi/DGMka2YHRsvfqO8
	H7V1ayrv7eqs7Vu4t5GCEAy8nCx7XXtw6jDNyseU+62KNPhSx5kU7yA+JxEI9nAc8chO0elt/+3
	RITLKxs6fkBTzmtk8TshHSG2qxssoBsNrWkeKkXK/eW6nIAEBS13b3YDjMg0GDoGB2NVL9jTaeY
	nBatlABR7Gwt1DWFpMANOloFoRuWL0bHNLfEXaQDeuDH2OyDOEmHE9OHVoob/HRRTbrkK2wFlWU
	O34KHlqY6Eb
X-Gm-Gg: ASbGncvmzB7stuSE+yGOr8lZYe96tVHWVM83uJyF89ImenClFVgusdAO16UODNtQ6EJ
	A+AH9WlufgMZ9K5dk8Ns7kxskBRjY849u2y89c9xgrQCROrLEmVJJudvMyfJqx2h9XDqdQ3sX4h
	sIN4y9FTJx1n1/OFiEl9qWldYNv7vuKYmp19k7viWVZT65AyXCQDzlC3HpW5dEWhrtjkq5VPuYL
	2fWzrVCk9i4K8YNfhRmmzn5IMySyIGGjgXhCC4IMT/QNGI0uerZaRc0P4m1OrrWGrmRYneTG3se
	QKHvUXZipoMLoLHKsfwgxgTS0CVCd0uGzpYERv1UMAhuTvUTBxVm8pQGMUAL4AQ84XpTwji9UqE
	TxWFUJfUKhjkKHJGL72243gaNxN46HAPbuT6c5C0L6DwoqyeYbD2ZvQTioV1dKu6Q3AJGZjwMGQ
	==
X-Google-Smtp-Source: AGHT+IGBwyupqB2b+hNheHEdfjJEkkDBbA0UH+6Y7PMQObv855jTwal/8MFZpvOv8ezfEOof2WA8fhY+w1wG
X-Received: by 2002:a05:6a20:9389:b0:243:99c8:c0da with SMTP id adf61e73a8af0-24399c8c69fmr14480458637.11.1756470707379;
        Fri, 29 Aug 2025 05:31:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b4cd26ae354sm153136a12.14.2025.08.29.05.31.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:31:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b10993f679so45768541cf.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756470706; x=1757075506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocs1O7M+XeHOMJsN32xtyWTZCKjfIDggqthostXpTY0=;
        b=eroPlF02U/MdI2GZnv5mTnA1ENp6pVRWbXOViPrbDAHLIYIcWX/wnpShakdlx4nrSB
         q8wpqQJNuw4c4wtUkqI67WAMypn/Fen28Gb4JTANEuXzC+/umqDXs2RlFUG3DSTLlVlT
         kGrIzZrz71cqCMxCoFUNd8o1Q33AlpNYhDesc=
X-Forwarded-Encrypted: i=1; AJvYcCUEBoLBE+fL3nzZbNFHZLzlOrM41vEyiLQnGt8EbObwt1BbhgX2MbXV+094tyCAW83On4DAuuU=@vger.kernel.org
X-Received: by 2002:a05:622a:211:b0:4b2:a07c:d728 with SMTP id d75a77b69052e-4b2aaa2b1d3mr340921451cf.27.1756470706067;
        Fri, 29 Aug 2025 05:31:46 -0700 (PDT)
X-Received: by 2002:a05:622a:211:b0:4b2:a07c:d728 with SMTP id d75a77b69052e-4b2aaa2b1d3mr340920941cf.27.1756470705437;
        Fri, 29 Aug 2025 05:31:45 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm162384585a.66.2025.08.29.05.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:31:45 -0700 (PDT)
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
Subject: [PATCH 7/8] RDMA/bng_re: Add basic debugfs infrastructure
Date: Fri, 29 Aug 2025 12:30:41 +0000
Message-Id: <20250829123042.44459-8-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829123042.44459-1-siva.kallam@broadcom.com>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
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
index 9faa64af3047..773121682bbe 100644
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


