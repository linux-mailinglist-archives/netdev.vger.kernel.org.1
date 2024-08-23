Return-Path: <netdev+bounces-121492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8AB95D64B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCC21F2283A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BC4193064;
	Fri, 23 Aug 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PcEePCe9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E4192B68
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443073; cv=none; b=Nk1YgXn7T+HTXmKibKNbXVvGft/DAGK16Mu504l4oB18lZNUj1TLk7NKHUb1+g5+N1sHD+O3M4eijnq0qwd8AFD8JLIYpwUgh3vMDPgL0Fyz6AFwZ+8f5Qs7UcOBUhs6pTxWoYyHjDYWkcv/51QqMmwBcw2WzVBtW6R/kf9iShg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443073; c=relaxed/simple;
	bh=+Quhs+GcmcvCNJ67S9TdSosAPU6p9yKFBTy6cg3ykgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6YNW7EXzaGW0IwKD9B0vxRfWNZX/YpAR8gjMTvP0NX6ReI4fohJ9lGzplHX4T/M4rWSLJWz4wst/reF3G6NOhk5vGUV7BOF8cXvIc+9+Biq//dACDbAa3YBect7umNnZQrT7HNo9jbvvgQ7H9Gxe41j8F6qx6ZwOlw1TxQ5xk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PcEePCe9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso1769320a12.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724443071; x=1725047871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICqtqN+lT+gy/ZNlwHRQ7RE0sHXMmNuHqivUFb84cy8=;
        b=PcEePCe9ypWR8q1knovYEastgcvCOOea/mhM4/M8zp9xLgWO8GVN1rwJ6u51jCEcZs
         7U9SEPSsMSjPg3xnLNuN17vkP9Buwpzr1iy+NNzML41E4t/7uKkZIVPpzHKQGt8jPa6d
         Si6F2PZ0DtOPAAGFVHP6oi4Mjl0oYg6bJOYi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443071; x=1725047871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICqtqN+lT+gy/ZNlwHRQ7RE0sHXMmNuHqivUFb84cy8=;
        b=Jl7X0ZHniAH2QVnQCge6vowE3g9eDRJ+8Y5a/JeMyWXGYWnC2TYU5oXNlQGUG2pvXO
         JhzS3Hq2lDDw4N7FYamxJiTxY36u+IXr6YN/57wM9lukE4LEGeWXZOLy9WTbU3IVzkbH
         iEzr1V7HCnKALHN0qxGiBhwU5QP9yyXXwp7uO2JqeJMl76HkaMZW/3UhBEVZMR60RC4h
         Io3nI4t/H65F6QOpoTD6WCdncEE06z59lUqj+6A4XiRcK/EYu8f0IA/i4I4xXEPyu75P
         qy8HhOwm3FlcrmGFp38FtoH5ZNV/sP3BKHF46Y2HzosiLE5OZMkKQxuW0+e/0ME2Huhe
         bgyg==
X-Gm-Message-State: AOJu0Ywlk8Xmw+XIuA/2C6nFsBs9yL3P0DNNMLHHtJIwCiMKS+cQu4tG
	jnAB0+suDx2IWaar4emaWfwm58Gr4y+kK/8Hlld+SoMjEcx2BLX/ltwInhHcuQ==
X-Google-Smtp-Source: AGHT+IEXaHNGlflwrKsX1VJzqem6DvxTx1w1uq4l99I7cppivF3E7zcEOV2wx3YO2kyzw+OIbde2tw==
X-Received: by 2002:a05:6a20:c78f:b0:1c0:ede4:9a73 with SMTP id adf61e73a8af0-1cc8b4290ebmr4433231637.7.1724443071231;
        Fri, 23 Aug 2024 12:57:51 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434253dbesm3417424b3a.76.2024.08.23.12.57.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 12:57:50 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org,
	helgaas@kernel.org,
	przemyslaw.kitszel@intel.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v3 4/9] bnxt_en: Deprecate support for legacy INTX mode
Date: Fri, 23 Aug 2024 12:56:52 -0700
Message-ID: <20240823195657.31588-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240823195657.31588-1-michael.chan@broadcom.com>
References: <20240823195657.31588-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware has deprecated support for legacy INTX in 2022 (since v2.27)
and INTX hasn't been tested for many years before that.  INTX was
only used as a fallback mechansim in case MSIX wasn't available.  MSIX
is always supported by all firmware.  If MSIX capability in PCI config
space is not found during probe, abort.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Fix memory leak, update changelog
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 43 +++++------------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  1 -
 2 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b236a76c0188..b5a5c4911143 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10770,7 +10770,7 @@ static int bnxt_get_num_msix(struct bnxt *bp)
 	return bnxt_nq_rings_in_use(bp);
 }
 
-static int bnxt_init_msix(struct bnxt *bp)
+static int bnxt_init_int_mode(struct bnxt *bp)
 {
 	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp;
 	struct msix_entry *msix_ent;
@@ -10828,7 +10828,7 @@ static int bnxt_init_msix(struct bnxt *bp)
 	return 0;
 
 msix_setup_exit:
-	netdev_err(bp->dev, "bnxt_init_msix err: %x\n", rc);
+	netdev_err(bp->dev, "bnxt_init_int_mode err: %x\n", rc);
 	kfree(bp->irq_tbl);
 	bp->irq_tbl = NULL;
 	pci_disable_msix(bp->pdev);
@@ -10836,35 +10836,6 @@ static int bnxt_init_msix(struct bnxt *bp)
 	return rc;
 }
 
-static int bnxt_init_inta(struct bnxt *bp)
-{
-	bp->irq_tbl = kzalloc(sizeof(struct bnxt_irq), GFP_KERNEL);
-	if (!bp->irq_tbl)
-		return -ENOMEM;
-
-	bp->total_irqs = 1;
-	bp->rx_nr_rings = 1;
-	bp->tx_nr_rings = 1;
-	bp->cp_nr_rings = 1;
-	bp->flags |= BNXT_FLAG_SHARED_RINGS;
-	bp->irq_tbl[0].vector = bp->pdev->irq;
-	return 0;
-}
-
-static int bnxt_init_int_mode(struct bnxt *bp)
-{
-	int rc = -ENODEV;
-
-	if (bp->flags & BNXT_FLAG_MSIX_CAP)
-		rc = bnxt_init_msix(bp);
-
-	if (!(bp->flags & BNXT_FLAG_USING_MSIX) && BNXT_PF(bp)) {
-		/* fallback to INTA */
-		rc = bnxt_init_inta(bp);
-	}
-	return rc;
-}
-
 static void bnxt_clear_int_mode(struct bnxt *bp)
 {
 	if (bp->flags & BNXT_FLAG_USING_MSIX)
@@ -12910,7 +12881,7 @@ bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx)
 	    !BNXT_SUPPORTS_NTUPLE_VNIC(bp))
 		return bnxt_rfs_supported(bp);
 
-	if (!(bp->flags & BNXT_FLAG_MSIX_CAP) || !bnxt_can_reserve_rings(bp) || !bp->rx_nr_rings)
+	if (!bnxt_can_reserve_rings(bp) || !bp->rx_nr_rings)
 		return false;
 
 	hwr.grp = bp->rx_nr_rings;
@@ -15772,6 +15743,11 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (pci_is_bridge(pdev))
 		return -ENODEV;
 
+	if (!pdev->msix_cap) {
+		dev_err(&pdev->dev, "MSIX capability not found, aborting\n");
+		return -ENODEV;
+	}
+
 	/* Clear any pending DMA transactions from crash kernel
 	 * while loading driver in capture kernel.
 	 */
@@ -15798,9 +15774,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (BNXT_PF(bp))
 		SET_NETDEV_DEVLINK_PORT(dev, &bp->dl_port);
 
-	if (pdev->msix_cap)
-		bp->flags |= BNXT_FLAG_MSIX_CAP;
-
 	rc = bnxt_init_board(pdev, dev);
 	if (rc < 0)
 		goto init_err_free;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index da6fad403f52..9192cf26c871 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2200,7 +2200,6 @@ struct bnxt {
 	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
 					 BNXT_FLAG_LRO)
 	#define BNXT_FLAG_USING_MSIX	0x40
-	#define BNXT_FLAG_MSIX_CAP	0x80
 	#define BNXT_FLAG_RFS		0x100
 	#define BNXT_FLAG_SHARED_RINGS	0x200
 	#define BNXT_FLAG_PORT_STATS	0x400
-- 
2.30.1


