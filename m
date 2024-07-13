Return-Path: <netdev+bounces-111320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D1193081A
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 01:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A582823F7
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AFB16EB77;
	Sat, 13 Jul 2024 23:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WpsaTkZz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923F16D9AC
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720914251; cv=none; b=fI6hxD/jVJ2t8JFlhY8fnprkzMySrt1IjkEh+Tibku6zXVsktIf84Dhkc8PixzsMqspsb+CvglFTBSv0UE1JiS4xvSv0er114b5pgVByb+PJcjVsknb9mGAxYnAQeEQHFPLZADVEOImVh+aYb6TjpQMxSlTgYhtpvekw3g9QVbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720914251; c=relaxed/simple;
	bh=2LFycrL+1ZqNbnVUEvLGCwtlYDYUlmIFUA0YHzIQcp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBLfGwtfTiup/ym/CQlx6L7H73UcmPU3L9Cc0aBQf4KstLTZF2rTgBa2jAUaOuPvxJwWr97Jc/DuS6LfKfSfkiY7hkMB2nkZjxBBCVuwdjj5tMABk7lkAPYpyZ4jUaWp+qZZzlQYiWOhtqYcB4sdbe5mBWOOYZdteOqo/96AWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WpsaTkZz; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-447f7c7c5fcso19025881cf.0
        for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 16:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720914248; x=1721519048; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2tYYoWBCJNopWccKay4PdX1EibY8ZSHIfBXU7LbAaTM=;
        b=WpsaTkZz181NYF/ZKzNDGkybkSLFVz7FNGdVfoCPTmb9cGr6SsWKQ4rBEmFsj6DoOh
         iWT+FYpmUOg7BZbRLso0qRghys+7nQYSv/D4mpNFsVp/ogVdzebhFbYj0K4JIou18MC3
         fRuN/moYse1K2krNRIHyCiUBZwntfDBy8EvTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720914248; x=1721519048;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tYYoWBCJNopWccKay4PdX1EibY8ZSHIfBXU7LbAaTM=;
        b=t6+Ey+lWIDnk5dU5aDRryPRMrk2feF15O9Lw9xgvIUlYLLepouhZtft/RFaI7Hyak9
         jcNQN1N/GEg40DMV4m5WerVxQt7d5TiNNxFd2kSPcHknv/+OwfzRpv00W/w1Io7ECmtU
         bsZDbczs4sM6Py47/RKVPneHHPnMt8/x45ZO19m5Fl9vDZx7CMcYG8LcGlKiqRuSGqbP
         V389F9eKOWlisR9kC8U2UnMpzvYLgziwth2phZTw+6nzI33hKDGXol/GwcPOOkhjzpWu
         alxkdDcAM1Gjo9Io7uaq9UKMY+6GFYdNsdC2CFOyM3EgIZfO1e0n++ms2Nc0DZxn1SoM
         Ic2A==
X-Gm-Message-State: AOJu0YxSZNSbcKn1TWJqhp9Qnbx7G2RRUliv1dc/ubx24VR97sZYECHm
	fXuAcl15wpLHrFuIwheza5L0Ysu+oKFRQTvwwEBTzrfIzvrEWhAYEyuSx3rBOg==
X-Google-Smtp-Source: AGHT+IED9JzC2sXkwXvICAfcj2M2MYx79ekUOZTnEjbjdsJO/jQOlSYW4QQoePphgtaojn1hn7EfZg==
X-Received: by 2002:a05:622a:43:b0:447:e3da:8041 with SMTP id d75a77b69052e-447fa8adcd4mr200257401cf.4.1720914248081;
        Sat, 13 Jul 2024 16:44:08 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbe6f7sm78124585a.37.2024.07.13.16.44.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2024 16:44:07 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: [PATCH net-next 5/9] bnxt_en: Remove BNXT_FLAG_USING_MSIX flag
Date: Sat, 13 Jul 2024 16:43:35 -0700
Message-ID: <20240713234339.70293-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240713234339.70293-1-michael.chan@broadcom.com>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000780668061d299234"

--000000000000780668061d299234
Content-Transfer-Encoding: 8bit

Now that we only support MSIX, the BNXT_FLAG_USING_MSIX is always true.
Remove it and any if conditions checking for it.  Remove the INTX
handler and associated logic.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 99 ++++---------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 -
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  5 -
 3 files changed, 17 insertions(+), 88 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7599fc3f8e27..39407b7c8958 100644
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
@@ -6872,15 +6844,14 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
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
@@ -10628,20 +10599,6 @@ static void bnxt_setup_msix(struct bnxt *bp)
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
@@ -10654,10 +10611,7 @@ static int bnxt_setup_int_mode(struct bnxt *bp)
 			return rc ?: -ENODEV;
 	}
 
-	if (bp->flags & BNXT_FLAG_USING_MSIX)
-		bnxt_setup_msix(bp);
-	else
-		bnxt_setup_inta(bp);
+	bnxt_setup_msix(bp);
 
 	rc = bnxt_set_real_num_queues(bp);
 	return rc;
@@ -10798,7 +10752,6 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 		rc = -ENOMEM;
 		goto msix_setup_exit;
 	}
-	bp->flags |= BNXT_FLAG_USING_MSIX;
 	kfree(msix_ent);
 	return 0;
 
@@ -10813,12 +10766,10 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 
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
@@ -10916,9 +10867,6 @@ static int bnxt_request_irq(struct bnxt *bp)
 #ifdef CONFIG_RFS_ACCEL
 	rmap = bp->dev->rx_cpu_rmap;
 #endif
-	if (!(bp->flags & BNXT_FLAG_USING_MSIX))
-		flags = IRQF_SHARED;
-
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
@@ -10983,29 +10931,22 @@ static void bnxt_del_napi(struct bnxt *bp)
 
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
 
@@ -12124,12 +12065,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
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
index 06030244d740..10e642abacf1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2198,7 +2198,6 @@ struct bnxt {
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


--000000000000780668061d299234
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOVcs3wuos0sUSxiXv7+cUoMpt37AO0y
Qq2hfzhS7ODTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcx
MzIzNDQwOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCxELrzf8gZUev/MMvcrCM03+D6BopBfAB6HiisbBjeXjFjTLXD
I+4QCZS68ZrfTqr6UXQ/7DddU+QrTEJUarcUl5BHyIdFQs1J8dEiN+6v0WMZoSxaYZjSMPfET6/g
ged9mh2dIEeFCvmDJZn+3PjnUa+NzC9trCrJ6BFtq3lcVV8xvhQdvf8Fmsvc90lQh1p6VD3McO5P
TnJpjA26dnR66O1ObwNpFsg8ra6UG7PEAoDtQ7M0jZmAj6EKwoz3w3md61e1iTItwG9RshzTa90B
kQ+ymMD11P3L85nVGGqRpVty5MtqPgiPGPYWCnAo48KmCon6xK8v1FShCKrv1lHR
--000000000000780668061d299234--

