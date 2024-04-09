Return-Path: <netdev+bounces-86296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 312A289E53D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA5B1F22FFA
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241CF158D6A;
	Tue,  9 Apr 2024 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xp7Tzyud"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CAC158D91
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699701; cv=none; b=G0UfFBa6z7z7shQZyRYjOYWc0mvjq5bYQE9kAbcMupmB+v5cLhPnd9B7qpEr450QpR3MfIcwE+9NuLK0G1nUN2/KrGfi817dPpYN14KHivHft4oHflhz8EUu9VccSaAykVGl5OHHG87y8xR1zDT72gYQyLW1DDBq5NzYNR2mL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699701; c=relaxed/simple;
	bh=61FDAwX7jHa+ItCQpLYECF+0sOjMhzZQ4+CpV0UlWUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szI2bcxCh062H3ve23XEAgleU+RmsNvZ0f7no9wcOrlEXlJHnggxPYFKx1VlRwNFMIVqay0626r9O/YqPrwqdqhN1xEg9he2dUFAIBov5H/Ln/BcQbkwvnukiwmIjWigDC7478z3VDmDFTFEEq49cO47r27HRqoal8ARLeD9bdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xp7Tzyud; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so39251245ad.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712699699; x=1713304499; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXySbWC15L67iUXb5gskHolh+euWlf3i1sGN9m+BaNM=;
        b=Xp7TzyudE3KWblI5eOTV1nReeoFXiZeNEvecpxO6ybU3KYuGMWMx597z7RqkIQe8lO
         ixE4NnReV/rzBs2Nv+qFMXZ2JRryHKlGAa6zo5o3VrDgtWtAJqFxYVyGWoY9t5AyEAwJ
         uXQ0I8Vs04BBmagoUCO/fK39mkYHcGIKA82pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712699699; x=1713304499;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXySbWC15L67iUXb5gskHolh+euWlf3i1sGN9m+BaNM=;
        b=t00VaQBu+Vk/xO2gZUnqwuzOgTEaQzxCg18KmRP2DlciQLz9azdBWJLG4PAhi2hzw3
         gk7FCbSyQoCIWlPdVqJ6yra/3MHtWRWkU+d8ekZtt4JTp+37HdFiH6Q9piQOQ/SVPde8
         DlRM8XCecsL3CI+zQZmkvtPWw/3wMUrDEhP+nlbcRe4Y6lFQO1xDTVua32tPQneZnRuJ
         g/3uXBc4eCWlANtdwddxdZ2gYAd+6U+u8r0q+ORKzAF9ZPXdjPSkbWHEMcqtg5oMdWTV
         HF8wDOq1goLSHL1oMtusWxUzwgxxasR3HMRdGykTUnSWf6CRzcSxrlBg/oMI3yABLG7P
         aEYg==
X-Gm-Message-State: AOJu0Yz8aHc77m0wHCjx4FuBlZ8XEMMqmyT60kTITKJH0B8nSTLjobxC
	JwP03LiYmYbY1pbFS+K4wWRxOFB7t5GIPzvVKDQ6bSbMOzlQFa7200AhDv18Uw==
X-Google-Smtp-Source: AGHT+IH2EzpY8KNoEYG69im1t6UdJEhx2lyjZbM0xIYFOyYQS3uoy/H/4cDDWqHwZTSNdFfCZ7QuDA==
X-Received: by 2002:a17:902:c105:b0:1e2:74af:e166 with SMTP id 5-20020a170902c10500b001e274afe166mr881541pli.63.1712699697805;
        Tue, 09 Apr 2024 14:54:57 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001e3e081dea1sm6983687plb.0.2024.04.09.14.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2024 14:54:56 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next 4/7] bnxt_en: Refactor bnxt_rdma_aux_device_init/uninit functions
Date: Tue,  9 Apr 2024 14:54:28 -0700
Message-Id: <20240409215431.41424-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240409215431.41424-1-michael.chan@broadcom.com>
References: <20240409215431.41424-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002c1fdf0615b0f930"

--0000000000002c1fdf0615b0f930
Content-Transfer-Encoding: 8bit

From: Vikas Gupta <vikas.gupta@broadcom.com>

In its current form, bnxt_rdma_aux_device_init() not only initializes
the necessary data structures of the newly created aux device but also
adds the aux device into the aux bus subsytem. Refactor the logic into
separate functions, first function to initialize the aux device along
with the required resources and second, to actually add the device to
the aux bus subsytem.
This separation helps to create bnxt_en_dev much earlier and save its
resources separately.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 10 ++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 33 ++++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 ++
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8213a37cba3e..8c24e83ba050 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14786,10 +14786,13 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	if (BNXT_PF(bp))
 		bnxt_sriov_disable(bp);
 
-	bnxt_rdma_aux_device_uninit(bp);
+	bnxt_rdma_aux_device_del(bp);
 
 	bnxt_ptp_clear(bp);
 	unregister_netdev(dev);
+
+	bnxt_rdma_aux_device_uninit(bp);
+
 	bnxt_free_l2_filters(bp, true);
 	bnxt_free_ntp_fltrs(bp, true);
 	if (BNXT_SUPPORTS_MULTI_RSS_CTX(bp))
@@ -15408,13 +15411,15 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
 		bnxt_init_multi_rss_ctx(bp);
 
+	bnxt_rdma_aux_device_init(bp);
+
 	rc = register_netdev(dev);
 	if (rc)
 		goto init_err_cleanup;
 
 	bnxt_dl_fw_reporters_create(bp);
 
-	bnxt_rdma_aux_device_init(bp);
+	bnxt_rdma_aux_device_add(bp);
 
 	bnxt_print_device_info(bp);
 
@@ -15422,6 +15427,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	return 0;
 init_err_cleanup:
+	bnxt_rdma_aux_device_uninit(bp);
 	bnxt_dl_unregister(bp);
 init_err_dl:
 	bnxt_shutdown_tc(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index cae88747b110..ae2b367b1226 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -291,7 +291,6 @@ void bnxt_rdma_aux_device_uninit(struct bnxt *bp)
 
 	aux_priv = bp->aux_priv;
 	adev = &aux_priv->aux_dev;
-	auxiliary_device_delete(adev);
 	auxiliary_device_uninit(adev);
 }
 
@@ -309,6 +308,14 @@ static void bnxt_aux_dev_release(struct device *dev)
 	bp->aux_priv = NULL;
 }
 
+void bnxt_rdma_aux_device_del(struct bnxt *bp)
+{
+	if (!bp->edev)
+		return;
+
+	auxiliary_device_delete(&bp->aux_priv->aux_dev);
+}
+
 static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 {
 	edev->net = bp->dev;
@@ -332,6 +339,23 @@ static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 	edev->ulp_tbl->msix_requested = bnxt_get_ulp_msix_num(bp);
 }
 
+void bnxt_rdma_aux_device_add(struct bnxt *bp)
+{
+	struct auxiliary_device *aux_dev;
+	int rc;
+
+	if (!bp->edev)
+		return;
+
+	aux_dev = &bp->aux_priv->aux_dev;
+	rc = auxiliary_device_add(aux_dev);
+	if (rc) {
+		netdev_warn(bp->dev, "Failed to add auxiliary device for ROCE\n");
+		auxiliary_device_uninit(aux_dev);
+		bp->flags &= ~BNXT_FLAG_ROCE_CAP;
+	}
+}
+
 void bnxt_rdma_aux_device_init(struct bnxt *bp)
 {
 	struct auxiliary_device *aux_dev;
@@ -386,13 +410,6 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
 	bp->edev = edev;
 	bnxt_set_edev_info(edev, bp);
 
-	rc = auxiliary_device_add(aux_dev);
-	if (rc) {
-		netdev_warn(bp->dev,
-			    "Failed to add auxiliary device for ROCE\n");
-		goto aux_dev_uninit;
-	}
-
 	return;
 
 aux_dev_uninit:
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index f8df4095399f..ae7266ddf167 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -103,6 +103,8 @@ void bnxt_ulp_irq_stop(struct bnxt *bp);
 void bnxt_ulp_irq_restart(struct bnxt *bp, int err);
 void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl);
 void bnxt_rdma_aux_device_uninit(struct bnxt *bp);
+void bnxt_rdma_aux_device_del(struct bnxt *bp);
+void bnxt_rdma_aux_device_add(struct bnxt *bp);
 void bnxt_rdma_aux_device_init(struct bnxt *bp);
 int bnxt_register_dev(struct bnxt_en_dev *edev, struct bnxt_ulp_ops *ulp_ops,
 		      void *handle);
-- 
2.30.1


--0000000000002c1fdf0615b0f930
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBz0TFRh3f+Li1LIIiGVTguYYseSVzpM
S+LpO7j6pXCkMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQw
OTIxNTQ1OVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQALpN4c7quGvJu4P2RLe9GHkhU0f5ZPojDu0fisxb8a24ZS5tmY
t9VlCOmqCGYQfZFgMxM65zYnhn7ZEjT1huBce5jKbbmX8dXRMpta2yRWNiB9/7PRVonAzHGrSqe8
xh4NkpXpJFSBQa1K1xgxuQA+oii7+gt/yR3K1AO/vxlS+54auLpUkJ0bUAEnZZkJtQWD1ofLfko+
ZskO3ilId3G4ipwa6gJSgaoJadfXocrnCoc7+8v9stj76jHK49fzBYrtK06hWI12J1sBubaJcxzy
BsURaZHzN4FypHtAgwhShs7CG7wFp1GW1+uzrR57lMDrKHLnO/iPUjZ9WGd793dM
--0000000000002c1fdf0615b0f930--

