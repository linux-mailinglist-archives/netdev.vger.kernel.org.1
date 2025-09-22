Return-Path: <netdev+bounces-225308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6182BB920F7
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7EC167DED
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E9F2E7182;
	Mon, 22 Sep 2025 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N7wJfHeh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1327F724
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556302; cv=none; b=JVm1F18GhHF/oqVqOwEvq8w2vTdsy+GnqncXsyQeGe5scKC0dn41z+WSUNjVP/CaZVx8Q7luU7Zfbv8Oqk8mupotcQy0AOd3EmLs8D6++wOjdjET5kRXYyebYtQ2NgJwl9qg2zoN1jS0yGrSmP7xCWFeWUY+j1D87l0KCI3HEqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556302; c=relaxed/simple;
	bh=Br9Bks/9nSFnyRluZAi40V3sh16fAmnmRYCaG/zY86A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pl+EoQ3R0mvNx/CLCQ3sqnOgQ9Ly1lwhap6vopGd9+j0zh57E2I/ThFbD8xzO7KQjEZLnH3McA++qBaSRSgTUaU9TvUutb8ovz4JLVlHSt3sSi4GY++HYVspeFRkc3vmGV5h50ezGEEn6jUIecbwhZub+zHY6PDuIAkFYvwTT/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N7wJfHeh; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-74526ca79c2so2301772a34.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758556300; x=1759161100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8ugwrW3JHxQdE71RS1L0SPO3O6DHbv2Tldl1Sm3ELQ=;
        b=wDqHeFo4LLDShGB63ioyd7oDx/eXuXZqaOtrDQ9tkxdTf77UVO28ATCjV5chpACWrv
         ZrC4cgohpi2XoDxzwKxnG/RyusO4Ay4fk/YGbUUO4J9DpnJq9hY+kS5Q3onrn7DvPjBq
         /izV6Y+q0vy1XxmKv7H8NaN2ldwEYiY4PpIZASHVDLKst+rb0pqDGVVKWV4h860AD2mG
         p6Jt2quAVQd3boYPGCSWLXEsrGr1BmoaR3FlEVrv10H5oTEZxSl8rxKkM0QVo5aNHzQg
         CAztSzB4E0KudQD6lO8NIqf7UFxlMxSoF3GenI9vMaU0Jj3Ao7DgpbOUdjtOJL8SH5TP
         Z65Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKnaW3urndZVbIBqIlVIy9svJ3/+b836uzS52Wf2pSEoF0X8Ro1+FuQvM2UvPuiPHLlOUhLWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpHEuJ5lEvQeCFrS9KdW0HvEj8c4tqyc0oBSqxCjmaUfDfvvI
	Ieqgqf16eQhorGc5nHZFouZ0DgY8YP6/E5xCKrLdvhpcUVomD9ofAS3k7YzBE6e1b3ROi2dmOBX
	5ozXtCWEIOTxaxpQRBVtB/HClKWyXy8v0asfN3Ux80ESAP7HJSsp3j2uw6jBDNEmvBcRFxLNLWy
	ZZdTZuOJMcLPucuGahJOihL4qtD/ZWgEp3ivq/Iik0XbQaYY3xQtLhHc7woIpnoi3xFHbybRcAp
	vWCboZNkQjs
X-Gm-Gg: ASbGnctjONywoXpW6/2QIKKG0cZHsK8a1TSi+mb3rKv30kuCAaLZvfevmoAbFHIwRxy
	bJM7nN0yyo5kbIsdb7yK207WTMxpJbgWeWWMuoZnXlihr/fapc1/wlBsB/8R76iLOgFO1cj6Z0l
	9Bz/orMETd17Vdw6+6yn0uXGJSm9m203zYnYVMldkKGiv9r2pU7+H7H6sEuqqa8hHzcMOGyiTgP
	05/G5OPHxS8mscHtZCeEVKo7Art+vRdr8DtOD6So3eQGTGHGImNfC4utECD4wb6hKKPRO6mOpG8
	QjFHv5Mkm32vooE5jufTWgNFE6N2OwNPz/p7OIvpOQETH3nbPH5Mx/dl6MnFX9HyRA3mDKd7NxJ
	bji9ps07faWoVe7pBfmzS/d3oolefhZjrb0aW9zKkB8SxSKF8bzAOdJu9LTG95+KfDsbVrECU0f
	IC
X-Google-Smtp-Source: AGHT+IEzItwsw/1rv74WA7pbg4zgWFTc2IWhJNS9cY886XZU3+2aN21qfbE6VV31+gN3sZdvSblGhyJiw20l
X-Received: by 2002:a05:6830:4188:b0:747:4744:a4d6 with SMTP id 46e09a7af769-76f7bba940emr6879088a34.17.1758556299477;
        Mon, 22 Sep 2025 08:51:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-76918322f77sm464910a34.2.2025.09.22.08.51.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:51:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f6eeb20eso161604711cf.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758556298; x=1759161098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8ugwrW3JHxQdE71RS1L0SPO3O6DHbv2Tldl1Sm3ELQ=;
        b=N7wJfHehYf8aLEJ9/ALkuCZtX3tVDUsdtQpyDoReNh9byWsBzegTaQ8Rw6FE59U/TX
         KmcJwkZTMYiOyDdHOwE8WRtLjR/ysVzv6hhKtqSucx7MLrm6r+P3zE8tx6Ig7FjpU+pX
         Fh+fVBi5Gx7lfjT1nrzY3aoEVNdeUvIAojYwo=
X-Forwarded-Encrypted: i=1; AJvYcCVj5OCm0MPxQWAAUxBnfEkdGfsXknRX2UeZzeUMRudKOE0OUITaOA9kYejuRQ0Z8iiaRw2vLf4=@vger.kernel.org
X-Received: by 2002:a05:620a:318a:b0:84c:1d25:890d with SMTP id af79cd13be357-84c1d258b69mr256316485a.57.1758555818198;
        Mon, 22 Sep 2025 08:43:38 -0700 (PDT)
X-Received: by 2002:a05:620a:318a:b0:84c:1d25:890d with SMTP id af79cd13be357-84c1d258b69mr256313185a.57.1758555817663;
        Mon, 22 Sep 2025 08:43:37 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84ada77bb17sm179496785a.30.2025.09.22.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:43:37 -0700 (PDT)
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
Subject: [PATCH v2 4/8] RDMA/bng_re: Allocate required memory resources for Firmware channel
Date: Mon, 22 Sep 2025 15:42:59 +0000
Message-Id: <20250922154303.246809-5-siva.kallam@broadcom.com>
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

Allocate required memory resources for Firmware channel.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/Makefile  |   6 +-
 drivers/infiniband/hw/bng_re/bng_dev.c |  32 +++-
 drivers/infiniband/hw/bng_re/bng_fw.c  |  70 +++++++
 drivers/infiniband/hw/bng_re/bng_fw.h  |  69 +++++++
 drivers/infiniband/hw/bng_re/bng_re.h  |   2 +
 drivers/infiniband/hw/bng_re/bng_res.c | 250 +++++++++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_res.h |  76 ++++++++
 7 files changed, 495 insertions(+), 10 deletions(-)
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.c

diff --git a/drivers/infiniband/hw/bng_re/Makefile b/drivers/infiniband/hw/bng_re/Makefile
index f854dae25b1c..1b957defbabc 100644
--- a/drivers/infiniband/hw/bng_re/Makefile
+++ b/drivers/infiniband/hw/bng_re/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-
-ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge
+ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge -I $(srctree)/drivers/infiniband/hw/bnxt_re
 
 obj-$(CONFIG_INFINIBAND_BNG_RE) += bng_re.o
 
-bng_re-y := bng_dev.o
+bng_re-y := bng_dev.o bng_fw.o \
+	    bng_res.o
diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index cad065df2032..1506f32fb550 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -8,6 +8,7 @@
 #include <rdma/ib_verbs.h>
 
 #include "bng_res.h"
+#include "bng_fw.h"
 #include "bng_re.h"
 #include "bnge.h"
 #include "bnge_hwrm.h"
@@ -60,6 +61,9 @@ static void bng_re_destroy_chip_ctx(struct bng_re_dev *rdev)
 
 	chip_ctx = rdev->chip_ctx;
 	rdev->chip_ctx = NULL;
+	rdev->rcfw.res = NULL;
+	rdev->bng_res.cctx = NULL;
+	rdev->bng_res.pdev = NULL;
 	kfree(chip_ctx);
 }
 
@@ -69,7 +73,8 @@ static int bng_re_setup_chip_ctx(struct bng_re_dev *rdev)
 	struct bnge_auxr_dev *aux_dev;
 
 	aux_dev = rdev->aux_dev;
-
+	rdev->bng_res.pdev = aux_dev->pdev;
+	rdev->rcfw.res = &rdev->bng_res;
 	chip_ctx = kzalloc(sizeof(*chip_ctx), GFP_KERNEL);
 	if (!chip_ctx)
 		return -ENOMEM;
@@ -77,6 +82,7 @@ static int bng_re_setup_chip_ctx(struct bng_re_dev *rdev)
 	chip_ctx->hw_stats_size = aux_dev->hw_ring_stats_size;
 
 	rdev->chip_ctx = chip_ctx;
+	rdev->bng_res.cctx = rdev->chip_ctx;
 
 	return 0;
 }
@@ -135,6 +141,14 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 		cctx->hwrm_cmd_max_timeout = BNG_ROCE_FW_MAX_TIMEOUT;
 }
 
+static void bng_re_dev_uninit(struct bng_re_dev *rdev)
+{
+	bng_re_free_rcfw_channel(&rdev->rcfw);
+	bng_re_destroy_chip_ctx(rdev);
+	if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
+		bnge_unregister_dev(rdev->aux_dev);
+}
+
 static int bng_re_dev_init(struct bng_re_dev *rdev)
 {
 	int rc;
@@ -170,14 +184,18 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 
 	bng_re_query_hwrm_version(rdev);
 
+	rc = bng_re_alloc_fw_channel(&rdev->bng_res, &rdev->rcfw);
+	if (rc) {
+		ibdev_err(&rdev->ibdev,
+			  "Failed to allocate RCFW Channel: %#x\n", rc);
+		goto fail;
+	}
+
 	return 0;
-}
 
-static void bng_re_dev_uninit(struct bng_re_dev *rdev)
-{
-	bng_re_destroy_chip_ctx(rdev);
-	if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
-		bnge_unregister_dev(rdev->aux_dev);
+fail:
+	bng_re_dev_uninit(rdev);
+	return rc;
 }
 
 static int bng_re_add_device(struct auxiliary_device *adev)
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
new file mode 100644
index 000000000000..bf7bbcf9b56e
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_fw.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+#include <linux/pci.h>
+
+#include "bng_res.h"
+#include "bng_fw.h"
+
+void bng_re_free_rcfw_channel(struct bng_re_rcfw *rcfw)
+{
+	kfree(rcfw->crsqe_tbl);
+	bng_re_free_hwq(rcfw->res, &rcfw->cmdq.hwq);
+	bng_re_free_hwq(rcfw->res, &rcfw->creq.hwq);
+	rcfw->pdev = NULL;
+}
+
+int bng_re_alloc_fw_channel(struct bng_re_res *res,
+			    struct bng_re_rcfw *rcfw)
+{
+	struct bng_re_hwq_attr hwq_attr = {};
+	struct bng_re_sg_info sginfo = {};
+	struct bng_re_cmdq_ctx *cmdq;
+	struct bng_re_creq_ctx *creq;
+
+	rcfw->pdev = res->pdev;
+	cmdq = &rcfw->cmdq;
+	creq = &rcfw->creq;
+	rcfw->res = res;
+
+	sginfo.pgsize = PAGE_SIZE;
+	sginfo.pgshft = PAGE_SHIFT;
+
+	hwq_attr.sginfo = &sginfo;
+	hwq_attr.res = rcfw->res;
+	hwq_attr.depth = BNG_FW_CREQE_MAX_CNT;
+	hwq_attr.stride = BNG_FW_CREQE_UNITS;
+	hwq_attr.type = BNG_HWQ_TYPE_QUEUE;
+
+	if (bng_re_alloc_init_hwq(&creq->hwq, &hwq_attr)) {
+		dev_err(&rcfw->pdev->dev,
+			"HW channel CREQ allocation failed\n");
+		goto fail;
+	}
+
+	rcfw->cmdq_depth = BNG_FW_CMDQE_MAX_CNT;
+
+	sginfo.pgsize = bng_fw_cmdqe_page_size(rcfw->cmdq_depth);
+	hwq_attr.depth = rcfw->cmdq_depth & 0x7FFFFFFF;
+	hwq_attr.stride = BNG_FW_CMDQE_UNITS;
+	hwq_attr.type = BNG_HWQ_TYPE_CTX;
+	if (bng_re_alloc_init_hwq(&cmdq->hwq, &hwq_attr)) {
+		dev_err(&rcfw->pdev->dev,
+			"HW channel CMDQ allocation failed\n");
+		goto fail;
+	}
+
+	rcfw->crsqe_tbl = kcalloc(cmdq->hwq.max_elements,
+				  sizeof(*rcfw->crsqe_tbl), GFP_KERNEL);
+	if (!rcfw->crsqe_tbl)
+		goto fail;
+
+	spin_lock_init(&rcfw->tbl_lock);
+
+	rcfw->max_timeout = res->cctx->hwrm_cmd_max_timeout;
+
+	return 0;
+
+fail:
+	bng_re_free_rcfw_channel(rcfw);
+	return -ENOMEM;
+}
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.h b/drivers/infiniband/hw/bng_re/bng_fw.h
new file mode 100644
index 000000000000..351f73baa9df
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_fw.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2025 Broadcom.
+
+#ifndef __BNG_FW_H__
+#define __BNG_FW_H__
+
+/* CREQ */
+#define BNG_FW_CREQE_MAX_CNT	(64 * 1024)
+#define BNG_FW_CREQE_UNITS	16
+
+/* CMDQ */
+struct bng_fw_cmdqe {
+	u8	data[16];
+};
+
+#define BNG_FW_CMDQE_MAX_CNT		8192
+#define BNG_FW_CMDQE_UNITS		sizeof(struct bng_fw_cmdqe)
+#define BNG_FW_CMDQE_BYTES(depth)	((depth) * BNG_FW_CMDQE_UNITS)
+
+static inline u32 bng_fw_cmdqe_npages(u32 depth)
+{
+	u32 npages;
+
+	npages = BNG_FW_CMDQE_BYTES(depth) / PAGE_SIZE;
+	if (BNG_FW_CMDQE_BYTES(depth) % PAGE_SIZE)
+		npages++;
+	return npages;
+}
+
+static inline u32 bng_fw_cmdqe_page_size(u32 depth)
+{
+	return (bng_fw_cmdqe_npages(depth) * PAGE_SIZE);
+}
+
+/* HWQ */
+struct bng_re_cmdq_ctx {
+	struct bng_re_hwq		hwq;
+};
+
+struct bng_re_creq_ctx {
+	struct bng_re_hwq		hwq;
+};
+
+struct bng_re_crsqe {
+	struct creq_qp_event	*resp;
+	u32			req_size;
+	/* Free slots at the time of submission */
+	u32			free_slots;
+	u8			opcode;
+};
+
+/* RoCE FW Communication Channels */
+struct bng_re_rcfw {
+	struct pci_dev		*pdev;
+	struct bng_re_res	*res;
+	struct bng_re_cmdq_ctx	cmdq;
+	struct bng_re_creq_ctx	creq;
+	struct bng_re_crsqe	*crsqe_tbl;
+	/* To synchronize the qp-handle hash table */
+	spinlock_t		tbl_lock;
+	u32			cmdq_depth;
+	/* cached from chip cctx for quick reference in slow path */
+	u16			max_timeout;
+};
+
+void bng_re_free_rcfw_channel(struct bng_re_rcfw *rcfw);
+int bng_re_alloc_fw_channel(struct bng_re_res *res,
+			    struct bng_re_rcfw *rcfw);
+#endif
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
index db692ad8db0e..18f80e2a1a46 100644
--- a/drivers/infiniband/hw/bng_re/bng_re.h
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -27,6 +27,8 @@ struct bng_re_dev {
 	struct bnge_auxr_dev		*aux_dev;
 	struct bng_re_chip_ctx		*chip_ctx;
 	int				fn_id;
+	struct bng_re_res		bng_res;
+	struct bng_re_rcfw		rcfw;
 };
 
 #endif
diff --git a/drivers/infiniband/hw/bng_re/bng_res.c b/drivers/infiniband/hw/bng_re/bng_res.c
new file mode 100644
index 000000000000..2119d1f39b65
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_res.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include <rdma/ib_umem.h>
+
+#include "bng_res.h"
+#include "roce_hsi.h"
+
+static void bng_free_pbl(struct bng_re_res  *res, struct bng_re_pbl *pbl)
+{
+	struct pci_dev *pdev = res->pdev;
+	int i;
+
+	for (i = 0; i < pbl->pg_count; i++) {
+		if (pbl->pg_arr[i])
+			dma_free_coherent(&pdev->dev, pbl->pg_size,
+					  (void *)((unsigned long)
+					     pbl->pg_arr[i] &
+						PAGE_MASK),
+					  pbl->pg_map_arr[i]);
+		else
+			dev_warn(&pdev->dev,
+					"PBL free pg_arr[%d] empty?!\n", i);
+		pbl->pg_arr[i] = NULL;
+	}
+
+	vfree(pbl->pg_arr);
+	pbl->pg_arr = NULL;
+	vfree(pbl->pg_map_arr);
+	pbl->pg_map_arr = NULL;
+	pbl->pg_count = 0;
+	pbl->pg_size = 0;
+}
+
+static int bng_alloc_pbl(struct bng_re_res  *res,
+			 struct bng_re_pbl *pbl,
+			 struct bng_re_sg_info *sginfo)
+{
+	struct pci_dev *pdev = res->pdev;
+	u32 pages;
+	int i;
+
+	if (sginfo->nopte)
+		return 0;
+	pages = sginfo->npages;
+
+	/* page ptr arrays */
+	pbl->pg_arr = vmalloc_array(pages, sizeof(void *));
+	if (!pbl->pg_arr)
+		return -ENOMEM;
+
+	pbl->pg_map_arr = vmalloc_array(pages, sizeof(dma_addr_t));
+	if (!pbl->pg_map_arr) {
+		vfree(pbl->pg_arr);
+		pbl->pg_arr = NULL;
+		return -ENOMEM;
+	}
+	pbl->pg_count = 0;
+	pbl->pg_size = sginfo->pgsize;
+
+	for (i = 0; i < pages; i++) {
+		pbl->pg_arr[i] = dma_alloc_coherent(&pdev->dev,
+				pbl->pg_size,
+				&pbl->pg_map_arr[i],
+				GFP_KERNEL);
+		if (!pbl->pg_arr[i])
+			goto fail;
+		pbl->pg_count++;
+	}
+
+	return 0;
+fail:
+	bng_free_pbl(res, pbl);
+	return -ENOMEM;
+}
+
+void bng_re_free_hwq(struct bng_re_res *res,
+		     struct bng_re_hwq *hwq)
+{
+	int i;
+
+	if (!hwq->max_elements)
+		return;
+	if (hwq->level >= BNG_PBL_LVL_MAX)
+		return;
+
+	for (i = 0; i < hwq->level + 1; i++)
+		bng_free_pbl(res, &hwq->pbl[i]);
+
+	hwq->level = BNG_PBL_LVL_MAX;
+	hwq->max_elements = 0;
+	hwq->element_size = 0;
+	hwq->prod = 0;
+	hwq->cons = 0;
+}
+
+/* All HWQs are power of 2 in size */
+int bng_re_alloc_init_hwq(struct bng_re_hwq *hwq,
+			  struct bng_re_hwq_attr *hwq_attr)
+{
+	u32 npages, pg_size;
+	struct bng_re_sg_info sginfo = {};
+	u32 depth, stride, npbl, npde;
+	dma_addr_t *src_phys_ptr, **dst_virt_ptr;
+	struct bng_re_res *res;
+	struct pci_dev *pdev;
+	int i, rc, lvl;
+
+	res = hwq_attr->res;
+	pdev = res->pdev;
+	pg_size = hwq_attr->sginfo->pgsize;
+	hwq->level = BNG_PBL_LVL_MAX;
+
+	depth = roundup_pow_of_two(hwq_attr->depth);
+	stride = roundup_pow_of_two(hwq_attr->stride);
+
+	npages = (depth * stride) / pg_size;
+	if ((depth * stride) % pg_size)
+		npages++;
+	if (!npages)
+		return -EINVAL;
+	hwq_attr->sginfo->npages = npages;
+
+	if (npages == MAX_PBL_LVL_0_PGS && !hwq_attr->sginfo->nopte) {
+		/* This request is Level 0, map PTE */
+		rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_0], hwq_attr->sginfo);
+		if (rc)
+			goto fail;
+		hwq->level = BNG_PBL_LVL_0;
+		goto done;
+	}
+
+	if (npages >= MAX_PBL_LVL_0_PGS) {
+		if (npages > MAX_PBL_LVL_1_PGS) {
+			u32 flag = PTU_PTE_VALID;
+			/* 2 levels of indirection */
+			npbl = npages >> MAX_PBL_LVL_1_PGS_SHIFT;
+			if (npages % BIT(MAX_PBL_LVL_1_PGS_SHIFT))
+				npbl++;
+			npde = npbl >> MAX_PDL_LVL_SHIFT;
+			if (npbl % BIT(MAX_PDL_LVL_SHIFT))
+				npde++;
+			/* Alloc PDE pages */
+			sginfo.pgsize = npde * pg_size;
+			sginfo.npages = 1;
+			rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_0], &sginfo);
+			if (rc)
+				goto fail;
+
+			/* Alloc PBL pages */
+			sginfo.npages = npbl;
+			sginfo.pgsize = PAGE_SIZE;
+			rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_1], &sginfo);
+			if (rc)
+				goto fail;
+			/* Fill PDL with PBL page pointers */
+			dst_virt_ptr =
+				(dma_addr_t **)hwq->pbl[BNG_PBL_LVL_0].pg_arr;
+			src_phys_ptr = hwq->pbl[BNG_PBL_LVL_1].pg_map_arr;
+			for (i = 0; i < hwq->pbl[BNG_PBL_LVL_1].pg_count; i++)
+				dst_virt_ptr[0][i] = src_phys_ptr[i] | flag;
+
+			/* Alloc or init PTEs */
+			rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_2],
+					 hwq_attr->sginfo);
+			if (rc)
+				goto fail;
+			hwq->level = BNG_PBL_LVL_2;
+			if (hwq_attr->sginfo->nopte)
+				goto done;
+			/* Fill PBLs with PTE pointers */
+			dst_virt_ptr =
+				(dma_addr_t **)hwq->pbl[BNG_PBL_LVL_1].pg_arr;
+			src_phys_ptr = hwq->pbl[BNG_PBL_LVL_2].pg_map_arr;
+			for (i = 0; i < hwq->pbl[BNG_PBL_LVL_2].pg_count; i++) {
+				dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
+					src_phys_ptr[i] | PTU_PTE_VALID;
+			}
+			if (hwq_attr->type == BNG_HWQ_TYPE_QUEUE) {
+				/* Find the last pg of the size */
+				i = hwq->pbl[BNG_PBL_LVL_2].pg_count;
+				dst_virt_ptr[PTR_PG(i - 1)][PTR_IDX(i - 1)] |=
+								  PTU_PTE_LAST;
+				if (i > 1)
+					dst_virt_ptr[PTR_PG(i - 2)]
+						    [PTR_IDX(i - 2)] |=
+						    PTU_PTE_NEXT_TO_LAST;
+			}
+		} else { /* pages < 512 npbl = 1, npde = 0 */
+			u32 flag = PTU_PTE_VALID;
+
+			/* 1 level of indirection */
+			npbl = npages >> MAX_PBL_LVL_1_PGS_SHIFT;
+			if (npages % BIT(MAX_PBL_LVL_1_PGS_SHIFT))
+				npbl++;
+			sginfo.npages = npbl;
+			sginfo.pgsize = PAGE_SIZE;
+			/* Alloc PBL page */
+			rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_0], &sginfo);
+			if (rc)
+				goto fail;
+			/* Alloc or init  PTEs */
+			rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_1],
+					 hwq_attr->sginfo);
+			if (rc)
+				goto fail;
+			hwq->level = BNG_PBL_LVL_1;
+			if (hwq_attr->sginfo->nopte)
+				goto done;
+			/* Fill PBL with PTE pointers */
+			dst_virt_ptr =
+				(dma_addr_t **)hwq->pbl[BNG_PBL_LVL_0].pg_arr;
+			src_phys_ptr = hwq->pbl[BNG_PBL_LVL_1].pg_map_arr;
+			for (i = 0; i < hwq->pbl[BNG_PBL_LVL_1].pg_count; i++)
+				dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
+					src_phys_ptr[i] | flag;
+			if (hwq_attr->type == BNG_HWQ_TYPE_QUEUE) {
+				/* Find the last pg of the size */
+				i = hwq->pbl[BNG_PBL_LVL_1].pg_count;
+				dst_virt_ptr[PTR_PG(i - 1)][PTR_IDX(i - 1)] |=
+								  PTU_PTE_LAST;
+				if (i > 1)
+					dst_virt_ptr[PTR_PG(i - 2)]
+						    [PTR_IDX(i - 2)] |=
+						    PTU_PTE_NEXT_TO_LAST;
+			}
+		}
+	}
+done:
+	hwq->prod = 0;
+	hwq->cons = 0;
+	hwq->pdev = pdev;
+	hwq->depth = hwq_attr->depth;
+	hwq->max_elements = hwq->depth;
+	hwq->element_size = stride;
+	/* For direct access to the elements */
+	lvl = hwq->level;
+	if (hwq_attr->sginfo->nopte && hwq->level)
+		lvl = hwq->level - 1;
+	hwq->pbl_ptr = hwq->pbl[lvl].pg_arr;
+	hwq->pbl_dma_ptr = hwq->pbl[lvl].pg_map_arr;
+	spin_lock_init(&hwq->lock);
+
+	return 0;
+fail:
+	bng_re_free_hwq(res, hwq);
+	return -ENOMEM;
+}
diff --git a/drivers/infiniband/hw/bng_re/bng_res.h b/drivers/infiniband/hw/bng_re/bng_res.h
index d64833498e2a..e6123abadfad 100644
--- a/drivers/infiniband/hw/bng_re/bng_res.h
+++ b/drivers/infiniband/hw/bng_re/bng_res.h
@@ -6,6 +6,18 @@
 
 #define BNG_ROCE_FW_MAX_TIMEOUT	60
 
+#define PTR_CNT_PER_PG		(PAGE_SIZE / sizeof(void *))
+#define PTR_MAX_IDX_PER_PG	(PTR_CNT_PER_PG - 1)
+#define PTR_PG(x)		(((x) & ~PTR_MAX_IDX_PER_PG) / PTR_CNT_PER_PG)
+#define PTR_IDX(x)		((x) & PTR_MAX_IDX_PER_PG)
+
+#define MAX_PBL_LVL_0_PGS		1
+#define MAX_PBL_LVL_1_PGS		512
+#define MAX_PBL_LVL_1_PGS_SHIFT		9
+#define MAX_PBL_LVL_1_PGS_FOR_LVL_2	256
+#define MAX_PBL_LVL_2_PGS		(256 * 512)
+#define MAX_PDL_LVL_SHIFT               9
+
 struct bng_re_chip_ctx {
 	u16	chip_num;
 	u16	hw_stats_size;
@@ -13,4 +25,68 @@ struct bng_re_chip_ctx {
 	u16	hwrm_cmd_max_timeout;
 };
 
+struct bng_re_pbl {
+	u32		pg_count;
+	u32		pg_size;
+	void		**pg_arr;
+	dma_addr_t	*pg_map_arr;
+};
+
+enum bng_re_pbl_lvl {
+	BNG_PBL_LVL_0,
+	BNG_PBL_LVL_1,
+	BNG_PBL_LVL_2,
+	BNG_PBL_LVL_MAX
+};
+
+enum bng_re_hwq_type {
+	BNG_HWQ_TYPE_CTX,
+	BNG_HWQ_TYPE_QUEUE
+};
+
+struct bng_re_sg_info {
+	u32	npages;
+	u32	pgshft;
+	u32	pgsize;
+	bool	nopte;
+};
+
+struct bng_re_hwq_attr {
+	struct bng_re_res		*res;
+	struct bng_re_sg_info		*sginfo;
+	enum bng_re_hwq_type		type;
+	u32				depth;
+	u32				stride;
+	u32				aux_stride;
+	u32				aux_depth;
+};
+
+struct bng_re_hwq {
+	struct pci_dev			*pdev;
+	/* lock to protect hwq */
+	spinlock_t			lock;
+	struct bng_re_pbl		pbl[BNG_PBL_LVL_MAX + 1];
+	/* Valid values: 0, 1, 2 */
+	enum bng_re_pbl_lvl		level;
+	/* PBL entries */
+	void				**pbl_ptr;
+	/* PBL  dma_addr */
+	dma_addr_t			*pbl_dma_ptr;
+	u32				max_elements;
+	u32				depth;
+	u16				element_size;
+	u32				prod;
+	u32				cons;
+};
+
+struct bng_re_res {
+	struct pci_dev			*pdev;
+	struct bng_re_chip_ctx		*cctx;
+};
+
+void bng_re_free_hwq(struct bng_re_res *res,
+		     struct bng_re_hwq *hwq);
+
+int bng_re_alloc_init_hwq(struct bng_re_hwq *hwq,
+			  struct bng_re_hwq_attr *hwq_attr);
 #endif
-- 
2.34.1


