Return-Path: <netdev+bounces-215899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE7CB30D23
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402331CE45C0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3028B407;
	Fri, 22 Aug 2025 04:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GyigsuoA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78942773F6
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835376; cv=none; b=fLN4agA6bJhC/1E/+PKBZLOtm7zBAtuXkkPDplBWncTr4XiAixYYbSUEsYu0WB7m4OV7716ydhpSewG2uflkvqQE8j4eemBnBMS0ZRQCIvoA6MNAu9NokOJh8hsCg0izf4xUe7PXARsxgSgSoYPu0p7Jo7odw993X9ZbUSBWRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835376; c=relaxed/simple;
	bh=39+oe9SB85UaY1/dYjexAgsa7wUOhhfw9MgFsKM0+n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmbl91f2VDok1ghydmCkaRfIGgRxkwbDdd1t7qm7B5d9bT5n/2H8YR4iaoWKtkhRM0NBkIUnhC/JadT1f6njpQPG9uIzjtSmwvfOc8vU5uDze1Qzf6XwTOnHFBAS7fX2oHqSUhyzQ9LHPmQYCDo99/uaw+J0leOWOUtM5u1cMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GyigsuoA; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-88432e6700dso25867139f.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835374; x=1756440174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttRgLIRqTP30+LhxgwiGR9e2bpOp/NOF9qofYEvXhuQ=;
        b=g+z1VjNdnw5kkRTST/64/QoP2RT3UCx/DT+Z/7wB3+4tTXoHhNofGM7LNbQTgKlG9b
         97QfgV9u5hTpz03DRWhjhoHB3ygfZYGWB59YCCEFMz0zoswsHQuzAtpAYm2TplmWHXuA
         wKSj/Llq5PUCGAo92WmHTucIWkbbrHABCis6vh1kubRsM9HYiY66otGe+5WlcCI4u+08
         jFAwxsSwIyBHG1cBLkP5ZsErrcE8vzlIHorTt0SD+0kh9U9ycETJY2UsitWNVZEZOL6N
         LUAHGSDoB4jIzTlzWpE5Yxdz9elYigTCLvrGztro8m1cpmySjPcASiixvA25ijAPkiSU
         CeMw==
X-Forwarded-Encrypted: i=1; AJvYcCVMYlv0m5PALqjkkkXAs5Rp4zFMfxplmq6CLBv0t2LeAWfyNqeKiHlOB+vRNv/K611xNFpC+7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHrkEZf20pgdSOBCgxW+/zHmmMfLSIZP6Ea4nNNb6hhyPqfXtE
	lDVn0J13/FOahIYE8kg21MX/+WDvKeP7u9kBElZ82owvk5fff9wIKz4PRqeq0w7GU8gg2v2yZWs
	t2Ayf16alqyuGZkXm+Qbft0//zR4eCI8gknBFZyn07UfPGjAZi8POXxlHXw230Z4dt7/f86UBEE
	VQ+8hRxXgTW4qPBWrDimXA1IxMfg1quMfcLHMAY3Sm5cFpAT2KDjjjQRTS78xyjJWUsbM5ktUBT
	E5DwdZxie34k/mC7lxgESej
X-Gm-Gg: ASbGncusO3AhK8ZTY2Xl2V6gmfVqlmTYqChs9Kq7HP6e5WP3M4SBkkW+OlDhx1hFxpD
	IpOs1cvmBI31nnmDAOUc1itVqy82/ZWuZKsYSThfkAnHRktCpWy+qUsvXCw5wn88MDPDGdSPaty
	QfNnk5rTsQgYnrB1eIRVjklssnUnbpUaVbTzIEAowAawxX8b4ULY3RqcWIF6jU6VKyPjceWzNmB
	kzAMPWUflSVc6B2BX1w8y7hQ2jea9wXZAX0K4qe5tBMDuq1V5aYP6drbWKcSpJoGKCrD9kH15aq
	iev1OJ6aBabRMykrjQMIq/P6w61CAWeS24hBugyyu1/0k1pKKAFiLSY8rENEAhaI/UJ50laCMTF
	jYiP+C8D9Br/FJUsWuQ+m/QM87tNNdW5mxbWLQde1RR/xNIVHszrSuzgJw7qko8rzK610JU954v
	qKd522zHWyFDYA
X-Google-Smtp-Source: AGHT+IHrP9vCC7bx05bGrsZB1JDamGUaUzmDz3PmBETb/6Giu7VWcxou5IrR2ewSKZ3yDGUfRWIiPUuwIx7B
X-Received: by 2002:a05:6602:15d2:b0:87c:5a38:45e9 with SMTP id ca18e2360f4ac-886bd1016ebmr265652639f.3.1755835373747;
        Thu, 21 Aug 2025 21:02:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-886b626aae0sm16922439f.11.2025.08.21.21.02.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:02:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e8afd68so1608514b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835372; x=1756440172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttRgLIRqTP30+LhxgwiGR9e2bpOp/NOF9qofYEvXhuQ=;
        b=GyigsuoAgQuLuTQ3c1tRlmlLy/wRgKoSsnBDlP3lMisrd3NKAAn87X18ygX5T9bVqJ
         UozXLxhqjQ/7/txQ9mRbF7XUFnkcWnPXxMOYlm47Cn/r5I/guzImpKu4WrKsiMeJEkiu
         C7H00i8XdwdpIsyKP6iYjjgcSZGKGPHknr2EE=
X-Forwarded-Encrypted: i=1; AJvYcCX21dNXcBnt1OtuiFu2+J96rQxBTMC70YTsUyvURP/l3DRTebWgdI3slcg12M461A5qHZr3OeM=@vger.kernel.org
X-Received: by 2002:a05:6a00:9295:b0:76e:9f28:ad56 with SMTP id d2e1a72fcca58-7702fa664camr2400138b3a.14.1755835372180;
        Thu, 21 Aug 2025 21:02:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:9295:b0:76e:9f28:ad56 with SMTP id d2e1a72fcca58-7702fa664camr2400106b3a.14.1755835371753;
        Thu, 21 Aug 2025 21:02:51 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:51 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 03/10] RDMA/bnxt_re: Refactor hw context memory allocation
Date: Fri, 22 Aug 2025 09:37:54 +0530
Message-ID: <20250822040801.776196-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch is in preparation for other patches in this series.
There is no functional changes intended.

1. Rename bnxt_qplib_alloc_ctx() to bnxt_qplib_alloc_hwctx().
2. Rename bnxt_qplib_free_ctx() to bnxt_qplib_free_hwctx().
3. Reduce the number of arguments of bnxt_qplib_alloc_hwctx()
   by moving a check outside of it.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c      | 18 ++++++++++--------
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 17 ++++++-----------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  9 ++++-----
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 3ae5f0d08f3a..9f752cb0c135 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2011,7 +2011,7 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 			ibdev_warn(&rdev->ibdev,
 				   "Failed to deinitialize RCFW: %#x", rc);
 		bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
-		bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
+		bnxt_qplib_free_hwctx(&rdev->qplib_res, &rdev->qplib_ctx);
 		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
@@ -2139,12 +2139,14 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	bnxt_qplib_query_version(&rdev->rcfw);
 	bnxt_re_set_resource_limits(rdev);
 
-	rc = bnxt_qplib_alloc_ctx(&rdev->qplib_res, &rdev->qplib_ctx, 0,
-				  bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx));
-	if (rc) {
-		ibdev_err(&rdev->ibdev,
-			  "Failed to allocate QPLIB context: %#x\n", rc);
-		goto disable_rcfw;
+	if (!rdev->is_virtfn &&
+	    !bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
+		rc = bnxt_qplib_alloc_hwctx(&rdev->qplib_res, &rdev->qplib_ctx);
+		if (rc) {
+			ibdev_err(&rdev->ibdev,
+				  "Failed to allocate hw context: %#x\n", rc);
+			goto disable_rcfw;
+		}
 	}
 	rc = bnxt_re_net_stats_ctx_alloc(rdev,
 					 rdev->qplib_ctx.stats.dma_map,
@@ -2206,7 +2208,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 free_sctx:
 	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
 free_ctx:
-	bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
+	bnxt_qplib_free_hwctx(&rdev->qplib_res, &rdev->qplib_ctx);
 disable_rcfw:
 	bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 free_ring:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 6cd05207ffed..db2ee7246861 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -350,8 +350,8 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 }
 
 /* Context Tables */
-void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
-			 struct bnxt_qplib_ctx *ctx)
+void bnxt_qplib_free_hwctx(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_ctx *ctx)
 {
 	int i;
 
@@ -464,7 +464,7 @@ static int bnxt_qplib_setup_tqm_rings(struct bnxt_qplib_res *res,
 }
 
 /*
- * Routine: bnxt_qplib_alloc_ctx
+ * Routine: bnxt_qplib_alloc_hwctx
  * Description:
  *     Context tables are memories which are used by the chip fw.
  *     The 6 tables defined are:
@@ -484,17 +484,13 @@ static int bnxt_qplib_setup_tqm_rings(struct bnxt_qplib_res *res,
  * Returns:
  *     0 if success, else -ERRORS
  */
-int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
-			 struct bnxt_qplib_ctx *ctx,
-			 bool virt_fn, bool is_p5)
+int bnxt_qplib_alloc_hwctx(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_ctx *ctx)
 {
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_sg_info sginfo = {};
 	int rc;
 
-	if (virt_fn || is_p5)
-		goto stats_alloc;
-
 	/* QPC Tables */
 	sginfo.pgsize = PAGE_SIZE;
 	sginfo.pgshft = PAGE_SHIFT;
@@ -540,7 +536,6 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 	rc = bnxt_qplib_alloc_init_hwq(&ctx->tim_tbl, &hwq_attr);
 	if (rc)
 		goto fail;
-stats_alloc:
 	/* Stats */
 	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, res->cctx, &ctx->stats);
 	if (rc)
@@ -549,7 +544,7 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 	return 0;
 
 fail:
-	bnxt_qplib_free_ctx(res, ctx);
+	bnxt_qplib_free_hwctx(res, ctx);
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 12e2fa23794a..9d866cfdebab 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -433,11 +433,10 @@ void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_init_res(struct bnxt_qplib_res *res);
 void bnxt_qplib_free_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct net_device *netdev);
-void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
-			 struct bnxt_qplib_ctx *ctx);
-int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
-			 struct bnxt_qplib_ctx *ctx,
-			 bool virt_fn, bool is_p5);
+void bnxt_qplib_free_hwctx(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_ctx *ctx);
+int bnxt_qplib_alloc_hwctx(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_ctx *ctx);
 int bnxt_qplib_map_db_bar(struct bnxt_qplib_res *res);
 void bnxt_qplib_unmap_db_bar(struct bnxt_qplib_res *res);
 
-- 
2.43.5


