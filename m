Return-Path: <netdev+bounces-119320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E955595525C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3E01C21F16
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0CC1C6897;
	Fri, 16 Aug 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T4rbMkTt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CD1C6890
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843756; cv=none; b=FPawE4+EvYT8EnmCU22hjFIaqiwYDtkGWRTndERn8tGPMIbccbGvMiox4dFjHXaVnCJn4iPoSdEthcM5YR2Aw5WZ03RK1YJT1zLKYMdj4PMHH1to6umqgFH3RH7KrlB3DjRbubBbrCHIxAEqc+Y00GR/CNEZo2YCBeCMrbMUvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843756; c=relaxed/simple;
	bh=ohL978brj/DCtaYUBlWZQq16OJiewoBDDZZhHwjho8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsssfsFI16BWtMfs/BfHV23f9hVAwd0/jd1i23bx43ot8Cj93MrezamdnOWz4XeJX1RIP+++AhtWdh5U8XHp20GJJONvSuiv1/24gxDwPePBB7Afw2IQ5qactaBe2vkRfZUM1GpkcsDodVmIhbvfbODaFvbTTO11hj7ui/iuF0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T4rbMkTt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44ff6dd158cso14397331cf.3
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723843753; x=1724448553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3IQACyrz1sqR74RBooMlydhPg+qkxHpMk7ZN7MUVrw=;
        b=T4rbMkTteaBmQUWHWbhXRZJziX7g3ELxGeV2bVQqi+99bu0viflUO9AePzpXHDCQZJ
         fZ/cAVNKLNIsWrW44iJPZcPrtE0ShxP1yV90caW504ZZksDyTNfSFe4XBSHmCCN4zvMA
         5F6cqBmE5GhYtgrz2u8NPjVcc2GSRFs77b534=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843753; x=1724448553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3IQACyrz1sqR74RBooMlydhPg+qkxHpMk7ZN7MUVrw=;
        b=tVemIcxewwesuBqFegqRiwf+lBjz18J9tTPNqvNbgQsxQtBwqjxJHh9FhzmeYB69qU
         QD7lvPvxegzdTHFElhX1BFyeJkgiyQsuhM2OCiwulYUB3QwGoA9gYK4ZRxemyRbocVWZ
         0mGItU+b9nqrbFiVlk49r9mYv1ZjuBqXOVG+rxtRofCXkzomXCzvnokN9KdZDIZJ7Age
         OILTDNPS2Xz9oQWRQiHF+hOpY+Rm21uhOfbdd9IiKrU0ZPOwjO068KuS6BzBhMY+PxLZ
         Cz4UZOCOflwJWi5/N1oniklzF1DaN/shQ79SCgrzpDieKXB0u+9N0qOWrFmKrZGiKW/D
         ll9A==
X-Gm-Message-State: AOJu0Yy5E+jf7ft/a4WviBKtzqn3gYdJG9wTSVl40mE/LqoUvb9tC2No
	f1jFHEQVXsg3cm+7Oe42atgt3RJAItvA4WipatMi65/3CxtuBloVvTXqTJKMwg==
X-Google-Smtp-Source: AGHT+IF9HSIx13GInV19bzuxEaMQZSTrS0N1/evid9ltxtngDiJEl0Vqubhu6OzLCXwhHmcCGe5Aeg==
X-Received: by 2002:a05:622a:2485:b0:447:eb33:410d with SMTP id d75a77b69052e-45374233d66mr60015981cf.18.1723843753535;
        Fri, 16 Aug 2024 14:29:13 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm20752221cf.9.2024.08.16.14.29.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:29:13 -0700 (PDT)
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
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 4/9] bnxt_en: Deprecate support for legacy INTX mode
Date: Fri, 16 Aug 2024 14:28:27 -0700
Message-ID: <20240816212832.185379-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240816212832.185379-1-michael.chan@broadcom.com>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
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
index 149ec5bda477..54d82e54456c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10772,7 +10772,7 @@ static int bnxt_get_num_msix(struct bnxt *bp)
 	return bnxt_nq_rings_in_use(bp);
 }
 
-static int bnxt_init_msix(struct bnxt *bp)
+static int bnxt_init_int_mode(struct bnxt *bp)
 {
 	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp;
 	struct msix_entry *msix_ent;
@@ -10830,7 +10830,7 @@ static int bnxt_init_msix(struct bnxt *bp)
 	return 0;
 
 msix_setup_exit:
-	netdev_err(bp->dev, "bnxt_init_msix err: %x\n", rc);
+	netdev_err(bp->dev, "bnxt_init_int_mode err: %x\n", rc);
 	kfree(bp->irq_tbl);
 	bp->irq_tbl = NULL;
 	pci_disable_msix(bp->pdev);
@@ -10838,35 +10838,6 @@ static int bnxt_init_msix(struct bnxt *bp)
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
@@ -12912,7 +12883,7 @@ bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx)
 	    !BNXT_SUPPORTS_NTUPLE_VNIC(bp))
 		return bnxt_rfs_supported(bp);
 
-	if (!(bp->flags & BNXT_FLAG_MSIX_CAP) || !bnxt_can_reserve_rings(bp) || !bp->rx_nr_rings)
+	if (!bnxt_can_reserve_rings(bp) || !bp->rx_nr_rings)
 		return false;
 
 	hwr.grp = bp->rx_nr_rings;
@@ -15774,6 +15745,11 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -15800,9 +15776,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (BNXT_PF(bp))
 		SET_NETDEV_DEVLINK_PORT(dev, &bp->dl_port);
 
-	if (pdev->msix_cap)
-		bp->flags |= BNXT_FLAG_MSIX_CAP;
-
 	rc = bnxt_init_board(pdev, dev);
 	if (rc < 0)
 		goto init_err_free;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index aa2eb78a8763..e2e2986a976b 100644
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


