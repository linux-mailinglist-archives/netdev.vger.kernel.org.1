Return-Path: <netdev+bounces-119322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F2895525E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6FDB22112
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B181C7B66;
	Fri, 16 Aug 2024 21:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xf4Hw7AE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913D1C68A0
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843758; cv=none; b=YedlsW+MsQc7N/zW7f1qSTkgSmwa6LmGNpC6M6qMCn0MHx+JF4Y7VkCsN2/d0KhUXD9ViOgoXrMITtjJq/zpaeByxx1rKin5j9DGRvbKsoWz0Yaki1zivL1l2TcyDJ/lEQ78ua6ESrXzqLVVKNE6JjAlklmJgshH8ry6tjpqabA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843758; c=relaxed/simple;
	bh=ye3Q+8yIGczFY9PKKUyOx5b+6M+C7UqJA4gbSHS44Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eqcbt7CYMsus7tmpmNJyfkm5rMMm0UhIMKarDET4xIdXiJt0I/iPnoSZu3gPDrNxeQwlZFmlEfRnX/vV1Wc2VUZq12gRy7KFGf6YXinHqB4jhSa9+6J9sLgFndQ8RyDJen2jQjCksz2cviqBYy4+2ZoalMtQod8K8SyONaYrNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xf4Hw7AE; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1e0ff6871so160620985a.2
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723843756; x=1724448556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9pCI+VyqhnD5xznIBfY84/Za6K9cJpKNKj6kGlQKX8=;
        b=Xf4Hw7AEcn2L3cMoN4j4ntF2R0TOyFWJB1o3EMPiRvosSPhgxIXMXDwA9hMeZcQ8uo
         pL+s8wT8SynWxHDBvDIU9qp+AAljSuexy/AUaqE84r9y8ZgYsVjLR/oKJ2Bq7JeyEiRP
         Bzncf8vrag4oJC1XVMz5RutgLpaK18cJNpbSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843756; x=1724448556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9pCI+VyqhnD5xznIBfY84/Za6K9cJpKNKj6kGlQKX8=;
        b=WypIQI1ME9MPM74va8KxTeKZw19cHwPN+rj0c7UKniLP/EDZlPETP44ILUhe5lVYY1
         qXamFmkQv8gSd/uIyMd4dCUMRCGySeatKateCtCDBw/Yvxembk2g2RO0CYh/oyLdDOTc
         gyGE4ty56rNsbf5kOO8UnF8SGjgIpU3VKeEHf6foszNjio0mnEGllqABc1UcsfjkQnv3
         2CPLNhPr7EzX2/WMCUxAEjn/b+JcBQwv5uH3iVsIUBnRxG4wg9YXc+l2XV3pEk7qP4DQ
         yc3GgqhgmrnhFg1pjHWy3TfyXsmHmSjFn4HEc5IT4+9BtdQdw0fbBZf6fXvEeZnVQxB1
         CMaw==
X-Gm-Message-State: AOJu0YxstqBmSeHtqLsFm612tS1w5M5h8doFacEuSw6QExHYxwgfOan6
	BYOJAyWZZZxjFm+lWcbJ9yUW569cP6A78viKpdrpxKp/KxKRCMNOqVMZ6bn7mQ==
X-Google-Smtp-Source: AGHT+IGXRfG5onPKMuogKDaa11oY+NeFqErAmPME/RizIDzdH9QtxoFKhJ0OHXL61Y/F/HL3+8N1eQ==
X-Received: by 2002:a05:622a:2596:b0:447:d4ce:dd26 with SMTP id d75a77b69052e-454b68f2734mr11291371cf.56.1723843755451;
        Fri, 16 Aug 2024 14:29:15 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm20752221cf.9.2024.08.16.14.29.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:29:15 -0700 (PDT)
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
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH net-next v2 5/9] bnxt_en: Remove BNXT_FLAG_USING_MSIX flag
Date: Fri, 16 Aug 2024 14:28:28 -0700
Message-ID: <20240816212832.185379-6-michael.chan@broadcom.com>
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
index 54d82e54456c..8d3970ccdc21 100644
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
@@ -10655,20 +10626,6 @@ static void bnxt_setup_msix(struct bnxt *bp)
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
@@ -10681,10 +10638,7 @@ static int bnxt_setup_int_mode(struct bnxt *bp)
 			return rc ?: -ENODEV;
 	}
 
-	if (bp->flags & BNXT_FLAG_USING_MSIX)
-		bnxt_setup_msix(bp);
-	else
-		bnxt_setup_inta(bp);
+	bnxt_setup_msix(bp);
 
 	rc = bnxt_set_real_num_queues(bp);
 	return rc;
@@ -10825,7 +10779,6 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 		rc = -ENOMEM;
 		goto msix_setup_exit;
 	}
-	bp->flags |= BNXT_FLAG_USING_MSIX;
 	kfree(msix_ent);
 	return 0;
 
@@ -10840,12 +10793,10 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 
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
@@ -10943,9 +10894,6 @@ static int bnxt_request_irq(struct bnxt *bp)
 #ifdef CONFIG_RFS_ACCEL
 	rmap = bp->dev->rx_cpu_rmap;
 #endif
-	if (!(bp->flags & BNXT_FLAG_USING_MSIX))
-		flags = IRQF_SHARED;
-
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
@@ -11010,29 +10958,22 @@ static void bnxt_del_napi(struct bnxt *bp)
 
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
 
@@ -12151,12 +12092,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
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
index e2e2986a976b..043d2a849674 100644
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


