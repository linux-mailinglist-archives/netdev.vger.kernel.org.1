Return-Path: <netdev+bounces-122891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02284963012
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405B2B23267
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348EC1AB51A;
	Wed, 28 Aug 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R+XKIULO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDC1AAE3B
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869989; cv=none; b=tJNvxcuiCBz5H9gF+T5DGKYcwzUtE3bszlC2uucD+d1dIQGD1fMjj3qkQPGX1trA5jmFg7zGo9GWfsRySZ+SY0ftY3tdzg2zO2nukIkSnjE8dszhpOz2rVJygltIGIUwMjFBgLxy7SUjjFAMYUS+LnViWyCZkEweN6fx4IXUBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869989; c=relaxed/simple;
	bh=9HHibu9dmHUzfYWGObAYufSKDig2J9G5O1A+PVFH6Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLqSBlcDErii8lrRu52fQDoTo+4HBGyGOuN0BJqHMVIrbOpm6MoWmAfD/YCiJSluFrS0G39Gge6zVTCM2SYBSRQDII/+EYPS+ANca4KauXq35kcAm/Wm6xBcIKkmYrWr1ZfikXQpeh+OXi1TIy0o5fvdpO5fnneTVs4CjSxwtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R+XKIULO; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44fe9cf83c7so39130341cf.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724869986; x=1725474786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOR12VouuMtqBOBdTtiTEX8qrbvpXj6gt5a2tTIdmDo=;
        b=R+XKIULOBIo9VhZLat7El26p9fqUzpSOq528hH+4+stsygLj7wlraavAV8uWzLz4nL
         UiO44TMTHC0EtYkbP4b+4w4zztl/mYr5gBTrnvyV+xrGB/qhMRLA6C1rDDW12eJjIWvd
         6LTNlVKghit2WV6egeOhTJXrXyh6K7LeGCBM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869986; x=1725474786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOR12VouuMtqBOBdTtiTEX8qrbvpXj6gt5a2tTIdmDo=;
        b=pod0BdH6DshXRUYk1Ry1Lr+Q/sIPSusWENE15Mz3wGwLiM8TGBstGeenb/Wzc5WDFW
         OA9K6+iVEEaALa0OM/pxnAc3YF8Jo3uUuWcnFpJvlyGtTKS+AopDA/hSaar89u/kbaw3
         +ecsySFRPsjR87rDmquAnFf25HTwgtR8W/Fto138ERscBYAI3rZYxfhSGVYN2ecbEUsJ
         GLAj0XWDlFh49GqR55s9CGvbCVwctgUbEpeklvWi/OblRX2L6UFMcADbqe3qJZodgGl2
         j299qmSwtekYcaiGXysIEJEA+d3YcagapPeAYhttTjAgsPO9ROKjupMQHRCqRsXpZTVX
         QzXQ==
X-Gm-Message-State: AOJu0YypcYXSEnC7rZjWHwf3jqghwuYfYb3te4c0e/Y0mCMBG/qUMw3z
	C5ezP7x37vgItTuX7soHUB+XAZtIeWTDGnddFnKuIugkJBlwePDYcB58UpOxPA==
X-Google-Smtp-Source: AGHT+IE2HNqGuq1MJept/oUAEhjOqVouWArlo6SyfYSQWzqolxe8ASGNYVLSXUh0JNMv1hZVe9Cx7Q==
X-Received: by 2002:a05:6214:4281:b0:6bb:9aeb:c04b with SMTP id 6a1803df08f44-6c33e69bc44mr4311606d6.47.1724869986041;
        Wed, 28 Aug 2024 11:33:06 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c36esm68126866d6.43.2024.08.28.11.33.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:33:05 -0700 (PDT)
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
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH net-next v4 5/9] bnxt_en: Remove BNXT_FLAG_USING_MSIX flag
Date: Wed, 28 Aug 2024 11:32:31 -0700
Message-ID: <20240828183235.128948-6-michael.chan@broadcom.com>
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

Now that we only support MSIX, the BNXT_FLAG_USING_MSIX is always true.
Remove it and any if conditions checking for it.  Remove the INTX
handler and associated logic.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 99 ++++---------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 -
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  5 -
 3 files changed, 17 insertions(+), 88 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b5a5c4911143..67f09e22a25c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2854,34 +2854,6 @@ static inline int bnxt_has_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 	return TX_CMP_VALID(txcmp, raw_cons);
 }
 
-static irqreturn_t bnxt_inta(int irq, void *dev_instance)
-{
-	struct bnxt_napi *bnapi = dev_instance;
-	struct bnxt *bp = bnapi->bp;
-	struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
-	u32 cons = RING_CMP(cpr->cp_raw_cons);
-	u32 int_status;
-
-	prefetch(&cpr->cp_desc_ring[CP_RING(cons)][CP_IDX(cons)]);
-
-	if (!bnxt_has_work(bp, cpr)) {
-		int_status = readl(bp->bar0 + BNXT_CAG_REG_LEGACY_INT_STATUS);
-		/* return if erroneous interrupt */
-		if (!(int_status & (0x10000 << cpr->cp_ring_struct.fw_ring_id)))
-			return IRQ_NONE;
-	}
-
-	/* disable ring IRQ */
-	BNXT_CP_DB_IRQ_DIS(cpr->cp_db.doorbell);
-
-	/* Return here if interrupt is shared and is disabled. */
-	if (unlikely(atomic_read(&bp->intr_sem) != 0))
-		return IRQ_HANDLED;
-
-	napi_schedule(&bnapi->napi);
-	return IRQ_HANDLED;
-}
-
 static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			    int budget)
 {
@@ -6876,15 +6848,14 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 			req->cq_handle = cpu_to_le64(ring->handle);
 			req->enables |= cpu_to_le32(
 				RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID);
-		} else if (bp->flags & BNXT_FLAG_USING_MSIX) {
+		} else {
 			req->int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 		}
 		break;
 	case HWRM_RING_ALLOC_NQ:
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_NQ;
 		req->length = cpu_to_le32(bp->cp_ring_mask + 1);
-		if (bp->flags & BNXT_FLAG_USING_MSIX)
-			req->int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
+		req->int_mode = RING_ALLOC_REQ_INT_MODE_MSIX;
 		break;
 	default:
 		netdev_err(bp->dev, "hwrm alloc invalid ring type %d\n",
@@ -10653,20 +10624,6 @@ static void bnxt_setup_msix(struct bnxt *bp)
 	}
 }
 
-static void bnxt_setup_inta(struct bnxt *bp)
-{
-	const int len = sizeof(bp->irq_tbl[0].name);
-
-	if (bp->num_tc) {
-		netdev_reset_tc(bp->dev);
-		bp->num_tc = 0;
-	}
-
-	snprintf(bp->irq_tbl[0].name, len, "%s-%s-%d", bp->dev->name, "TxRx",
-		 0);
-	bp->irq_tbl[0].handler = bnxt_inta;
-}
-
 static int bnxt_init_int_mode(struct bnxt *bp);
 
 static int bnxt_setup_int_mode(struct bnxt *bp)
@@ -10679,10 +10636,7 @@ static int bnxt_setup_int_mode(struct bnxt *bp)
 			return rc ?: -ENODEV;
 	}
 
-	if (bp->flags & BNXT_FLAG_USING_MSIX)
-		bnxt_setup_msix(bp);
-	else
-		bnxt_setup_inta(bp);
+	bnxt_setup_msix(bp);
 
 	rc = bnxt_set_real_num_queues(bp);
 	return rc;
@@ -10823,7 +10777,6 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 		rc = -ENOMEM;
 		goto msix_setup_exit;
 	}
-	bp->flags |= BNXT_FLAG_USING_MSIX;
 	kfree(msix_ent);
 	return 0;
 
@@ -10838,12 +10791,10 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 
 static void bnxt_clear_int_mode(struct bnxt *bp)
 {
-	if (bp->flags & BNXT_FLAG_USING_MSIX)
-		pci_disable_msix(bp->pdev);
+	pci_disable_msix(bp->pdev);
 
 	kfree(bp->irq_tbl);
 	bp->irq_tbl = NULL;
-	bp->flags &= ~BNXT_FLAG_USING_MSIX;
 }
 
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
@@ -10941,9 +10892,6 @@ static int bnxt_request_irq(struct bnxt *bp)
 #ifdef CONFIG_RFS_ACCEL
 	rmap = bp->dev->rx_cpu_rmap;
 #endif
-	if (!(bp->flags & BNXT_FLAG_USING_MSIX))
-		flags = IRQF_SHARED;
-
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
@@ -11008,29 +10956,22 @@ static void bnxt_del_napi(struct bnxt *bp)
 
 static void bnxt_init_napi(struct bnxt *bp)
 {
-	int i;
+	int (*poll_fn)(struct napi_struct *, int) = bnxt_poll;
 	unsigned int cp_nr_rings = bp->cp_nr_rings;
 	struct bnxt_napi *bnapi;
+	int i;
 
-	if (bp->flags & BNXT_FLAG_USING_MSIX) {
-		int (*poll_fn)(struct napi_struct *, int) = bnxt_poll;
-
-		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-			poll_fn = bnxt_poll_p5;
-		else if (BNXT_CHIP_TYPE_NITRO_A0(bp))
-			cp_nr_rings--;
-		for (i = 0; i < cp_nr_rings; i++) {
-			bnapi = bp->bnapi[i];
-			netif_napi_add(bp->dev, &bnapi->napi, poll_fn);
-		}
-		if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
-			bnapi = bp->bnapi[cp_nr_rings];
-			netif_napi_add(bp->dev, &bnapi->napi,
-				       bnxt_poll_nitroa0);
-		}
-	} else {
-		bnapi = bp->bnapi[0];
-		netif_napi_add(bp->dev, &bnapi->napi, bnxt_poll);
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
+		poll_fn = bnxt_poll_p5;
+	else if (BNXT_CHIP_TYPE_NITRO_A0(bp))
+		cp_nr_rings--;
+	for (i = 0; i < cp_nr_rings; i++) {
+		bnapi = bp->bnapi[i];
+		netif_napi_add(bp->dev, &bnapi->napi, poll_fn);
+	}
+	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
+		bnapi = bp->bnapi[cp_nr_rings];
+		netif_napi_add(bp->dev, &bnapi->napi, bnxt_poll_nitroa0);
 	}
 }
 
@@ -12149,12 +12090,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	rc = bnxt_reserve_rings(bp, irq_re_init);
 	if (rc)
 		return rc;
-	if ((bp->flags & BNXT_FLAG_RFS) &&
-	    !(bp->flags & BNXT_FLAG_USING_MSIX)) {
-		/* disable RFS if falling back to INTA */
-		bp->dev->hw_features &= ~NETIF_F_NTUPLE;
-		bp->flags &= ~BNXT_FLAG_RFS;
-	}
 
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 9192cf26c871..b1903a1617f1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2199,7 +2199,6 @@ struct bnxt {
 	#define BNXT_FLAG_STRIP_VLAN	0x20
 	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
 					 BNXT_FLAG_LRO)
-	#define BNXT_FLAG_USING_MSIX	0x40
 	#define BNXT_FLAG_RFS		0x100
 	#define BNXT_FLAG_SHARED_RINGS	0x200
 	#define BNXT_FLAG_PORT_STATS	0x400
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 58bd84b59f0e..7bb8a5d74430 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -902,11 +902,6 @@ int bnxt_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct bnxt *bp = netdev_priv(dev);
 
-	if (!(bp->flags & BNXT_FLAG_USING_MSIX)) {
-		netdev_warn(dev, "Not allow SRIOV if the irq mode is not MSIX\n");
-		return 0;
-	}
-
 	rtnl_lock();
 	if (!netif_running(dev)) {
 		netdev_warn(dev, "Reject SRIOV config request since if is down!\n");
-- 
2.30.1


