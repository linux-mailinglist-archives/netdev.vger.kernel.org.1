Return-Path: <netdev+bounces-122890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B608C963011
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB5371C20890
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2570D1A76A7;
	Wed, 28 Aug 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YIv2yMsb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6754F1A7AE8
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869987; cv=none; b=rETV6VmODI56Tmm2DmIriTtzgMxEx0aPk/PJBx8SVxC2RgV1FU46dE/4ljuJBNM+Wiqhva7C8OZvlsiyuTypLqFCC8UtL6XDpw3N0oP3c+3d9FHv64gKN1tAarT0Ki24I6P1HyWPH3OUwgHx9Q1K28DCrVA0ecSjfCoAjz2sWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869987; c=relaxed/simple;
	bh=ARcNCprM0v5GsAod68xC+wV75kue9/QBz3JkEmebWzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVOIjHLtuuK1Wtg7H0/gvl3bDvF7nXzTdD1xhEO5y6Oz87AnOUbAacoLGUPvQRnp2dftt07vj5tbxOfBNeP/t4uMTOwJU/XtZEBdx0s3yCpde7UsqbtEv+5eThqa6djn0mGzCjOBvXfpBvLyaGc5eHPisTeRal8eMJc8loLy/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YIv2yMsb; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf7a2035d9so9113466d6.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724869984; x=1725474784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWyUzv61NDShL72tz88j7Usn+4QNeZHKrg/0gsrYQCg=;
        b=YIv2yMsbblOaMuZHvhrSEslr6BPZAuLeqAo8MwhYYT2bp+oX77DTdqQXiH0fZVpBST
         yRw8Uj+lSHNXx91G+iyB2aEJlnFZt66WNW+CtfvAav75r07BexpFM//SDwPcX9An1tcb
         ge6Rk1RyRE/n5EmR51JNhma+9V/uoqYkMlrJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869984; x=1725474784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWyUzv61NDShL72tz88j7Usn+4QNeZHKrg/0gsrYQCg=;
        b=maYWbD5SHzYp0yNWg4yxbVWe6GxugYF0XEhILkCw4A1WIMpUcHIbzB7Z05RHUw9Eqf
         PBQs14IZLo2PPfhmznRTr0xCyImrk1EC9l7pXK/0TcE/bHGhEjzavhvovf2uJGqYoKse
         fOA2m2UoIZjBWrWssxcpF3bB8D0sL1vz1gilUpF0SuWj902JNgsr6OFrPw/kA3+3aCr0
         FyoZb+Vqk3fWDlaDZcnvXFpSKpu0C0dnjY/WXieFKIxTrIGubuZTeRK301nDlievUEFH
         udmA/5f6juRrSNJTGozw+KZVBIYXa/x1s1JQNsekPT8iRRm3RT6evZGAgWsWxMWhEmur
         mzvA==
X-Gm-Message-State: AOJu0Yw3xVJG7v9EWeSLzIuy4Vy1Xf7/o6G5L0wrrUOPaVcX9Z/cLaGQ
	eCozUkZhKL/SVZlRnq8hpuUej+CzAWGPrXBaFCMZhouoAjGGc9lpn0c7KyVamg==
X-Google-Smtp-Source: AGHT+IFr0RSQI/8q7rv0ciOy7zRth6JLfeUmu/d9lCGqgHcY2bEyR5qQqY3KCQhfquzDHDdvebaP4w==
X-Received: by 2002:ad4:5e8f:0:b0:6b2:a68e:6cf5 with SMTP id 6a1803df08f44-6c33f325aa7mr1214536d6.5.1724869984172;
        Wed, 28 Aug 2024 11:33:04 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c36esm68126866d6.43.2024.08.28.11.33.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:33:03 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/9] bnxt_en: Deprecate support for legacy INTX mode
Date: Wed, 28 Aug 2024 11:32:30 -0700
Message-ID: <20240828183235.128948-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240828183235.128948-1-michael.chan@broadcom.com>
References: <20240828183235.128948-1-michael.chan@broadcom.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


