Return-Path: <netdev+bounces-121493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2ED95D64C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB731F22837
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6F192B86;
	Fri, 23 Aug 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="binYaUHr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E07192B6D
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443075; cv=none; b=VHt/BCAWordx7aXqAoCA1wr7lpt1y5C5IEM+Z/W6nkLAK3ulWfBU5ugWKoulMM0Lnnyimj1tVpEDH65x6yXmeorIJLjP5RhKjxi3UD417UVscPWT5JlPR+D8MjrcvaDaulpdJQDL4n4hWARnQb2siQwIuYN7WUM/U5JK7wbKtt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443075; c=relaxed/simple;
	bh=9HHibu9dmHUzfYWGObAYufSKDig2J9G5O1A+PVFH6Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJMLv68qZISnYHSt8DDKoSfdhjJC7tG9MqD7vyJTNXWcqDLlhT+UFpEInK1LwitIf69dtqk9hVpHp6VkgsnitZk7F2gxQHG5evkgu3VXEvPFFySitgjX1FzXjDYR3kZMr4IaVpgo1DdxNuNMD+L3ZTG+bIQmZEYlfHB1hgVBKHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=binYaUHr; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7142014d8dfso2025301b3a.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724443073; x=1725047873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOR12VouuMtqBOBdTtiTEX8qrbvpXj6gt5a2tTIdmDo=;
        b=binYaUHrTqi9tMeM2axLKWP0gGcE2295AEBhO+iGuG1lV6ADQBLtS1AlWV5Thq6X/g
         TGM1MzFgq0wI3wFdcT2y4eLRMTIsfEgfHSUsvZSbob/4NTTCSzmYVo5HuAWeUjpI2/wI
         0+GFTL77HQ9RKPW4n1C6wslUjgwEDSsZntMaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443073; x=1725047873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOR12VouuMtqBOBdTtiTEX8qrbvpXj6gt5a2tTIdmDo=;
        b=DRBA5dykfpcCyOLmSSY9+aUiUsCIuD6I3VWDCJn76REqfFHUGkePHq56KgYZa4Lh9f
         q3AzzmT6/7JSGPIcbimez3XJ0tlTA+CjMWoCoidlFcpTnDMsTx6z7CpqP3r9PdJJjPER
         /lus44uuIpvLLV+h/004eFeBasreATk8WZjaSbzenYq8ok+qFutN3QZOo+FrQJ7us+D+
         NW5bRQP9mL871gTkWLo1EFTZU5izHwJbAoQ4DcmX2GbduND/j7ZqKfM3rzcjxD53TE7s
         35EV8WyoYDis1vvLwcQN1PIHFfpKDbsoZaz2HmE8Kx5bMkHJdnwaILPUh3YrhpTW4p+K
         Wocg==
X-Gm-Message-State: AOJu0Yy1/V2Z+IKyDwUiUV2NPczWt8jOnPZrebjbtWp7R2ZN9T49kCdk
	pKmBkg5qqPpXsgD5shNuaOj97AVgaGe2fdkAP1DnxBP+wxBylRUWgwFLqwtQRg==
X-Google-Smtp-Source: AGHT+IE0/A1r4mf8npni4QJ7Fc/ofu7HThntrlJ3UV0gACy3ftWBCATej0sgInZ7HkNv1UxpFQszCg==
X-Received: by 2002:a05:6a00:2789:b0:704:2b6e:f10b with SMTP id d2e1a72fcca58-71445d5b19fmr3749494b3a.15.1724443072701;
        Fri, 23 Aug 2024 12:57:52 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434253dbesm3417424b3a.76.2024.08.23.12.57.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 12:57:52 -0700 (PDT)
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
Subject: [PATCH net-next v3 5/9] bnxt_en: Remove BNXT_FLAG_USING_MSIX flag
Date: Fri, 23 Aug 2024 12:56:53 -0700
Message-ID: <20240823195657.31588-6-michael.chan@broadcom.com>
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


