Return-Path: <netdev+bounces-92673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0308B83BC
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 02:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2161F23122
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 00:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503F84C83;
	Wed,  1 May 2024 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S/gSUmWW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B59F4C97
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714523507; cv=none; b=btEja2F6G7UR5+Vhw6KlYG0vadY76JivQgxUS5fgHwLxUXp/bg2zbUNk7uyof4xObgspM+DdiAYKOKFP8g4tBWItwHIrdWNZlnXg+2MdRz6DS2v2Yvc6zGbRMzdHzw2Y0SyCM3KFT+1Mvjq+j2+BelSNoSn/rMvzWjOe9EfdayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714523507; c=relaxed/simple;
	bh=JxAzk8KWG8zeHpSDKHDEp4s3uYVE1c7g6bC1RRBHNus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGPz5xS4BD3HpcbS3EbGSGrXpUWM+ByaM60GCHFdURh/kCdV76UpqczqL9Qqqrih1kRJ/Ymb3nzKpsNpaP72C8pgDXk2tfWDa/2h+UdDSsb5NUqHLYpjFW0+2xB8jqfzq3WXImInf4Tt3DOLz5G+RuJqBYTu4rUF1Yhisp4iAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S/gSUmWW; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61b68644ab4so61509297b3.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 17:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714523504; x=1715128304; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHSb8FkF23eWmFvu5gHoSQDY/BD3mX4bf7+L4wZr8jw=;
        b=S/gSUmWWp7Qu1c7O5RnpkhOTlG+0W8wjuWK75PRP9EIYaOs2kVGooLAbsU2D7A6GWs
         02ed3wpSWnSPUTydJPPDZqM3q0T2GP0iE2knR88SERsS1kkkzPFTe0xxWD+9dMQxhYlp
         rsiqQhOnunLQj8vI5U5T1zPq1ATUdpfjAk92Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714523504; x=1715128304;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHSb8FkF23eWmFvu5gHoSQDY/BD3mX4bf7+L4wZr8jw=;
        b=CusZ7pZmcvm9ttyWKsNhXz0cXioqEwU+i+XQLKA+X1aQ4BoL6k1kW0NKBxyCIrSk/4
         YzEJlHEPl1qxUYWDMNcHgeFOZfcekEymGMjyvg8kFSVy6Acm3Z/DUrj2FkZAWaDV2zRV
         Z0DFU6S2wDjq3o9tPu65jb4NxbeTFKu6SPm7vzWFjVw3Z89DeoKzmFwnbpfHv4zA4oIL
         eeBAuazfp1qOZLS2LSHTSXrjMjqDY5qVpJCelYASeS8LhZiy/HgCE2Fkb9WMXc7WGx5K
         TK2iQAZ15gok1NqKmTyowZHqfE+X0RS0x8YUsiYLyv2fdRC3N7DNv2uIJTTc2OTZyDQz
         dEjA==
X-Gm-Message-State: AOJu0YxFw7WlcsoKggCyuLznN+AClusX+83OxTeKNdquIndk7bFJdI5U
	CyBbN9dH41PIFFTlPvfDDz5z7X/Xzsc6xfLPjX80HyYvr9dpEi0sGKCkpAzqTPZxTPZymi2w/ho
	=
X-Google-Smtp-Source: AGHT+IER+z2fs5aQbGc+ieEXgZSqNS5U09BdyWigMbvyt/Jlau17pHTF34p3TcrljpPWa5j4A2kV8Q==
X-Received: by 2002:a05:690c:39b:b0:61a:e856:85f1 with SMTP id bh27-20020a05690c039b00b0061ae85685f1mr1170827ywb.13.1714523504118;
        Tue, 30 Apr 2024 17:31:44 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id f15-20020ac8470f000000b0043a7cb47069sm4337935qtp.9.2024.04.30.17.31.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 17:31:43 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 4/6] bnxt_en: Add a mutex to synchronize ULP operations
Date: Tue, 30 Apr 2024 17:30:54 -0700
Message-Id: <20240501003056.100607-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240501003056.100607-1-michael.chan@broadcom.com>
References: <20240501003056.100607-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000745b890617599c34"

--000000000000745b890617599c34
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

The current scheme relies heavily on the RTNL lock for all ULP
operations between the L2 and the RoCE driver.  Add a new en_dev_lock
mutex so that the asynchronous ULP_STOP and ULP_START operations
can be serialized with bnxt_register_dev() and bnxt_unregister_dev()
calls without relying on the RTNL lock.  The next patch will remove
the RTNL lock from the ULP_STOP and ULP_START calls.

Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 20 ++++++++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index d8927838f1cf..ba3fa1c2e5d9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -113,6 +113,7 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 	int rc = 0;
 
 	rtnl_lock();
+	mutex_lock(&edev->en_dev_lock);
 	if (!bp->irq_tbl) {
 		rc = -ENODEV;
 		goto exit;
@@ -136,6 +137,7 @@ int bnxt_register_dev(struct bnxt_en_dev *edev,
 	bnxt_fill_msix_vecs(bp, bp->edev->msix_entries);
 	edev->flags |= BNXT_EN_FLAG_MSIX_REQUESTED;
 exit:
+	mutex_unlock(&edev->en_dev_lock);
 	rtnl_unlock();
 	return rc;
 }
@@ -150,6 +152,7 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 
 	ulp = edev->ulp_tbl;
 	rtnl_lock();
+	mutex_lock(&edev->en_dev_lock);
 	if (ulp->msix_requested)
 		edev->flags &= ~BNXT_EN_FLAG_MSIX_REQUESTED;
 	edev->ulp_tbl->msix_requested = 0;
@@ -165,6 +168,7 @@ void bnxt_unregister_dev(struct bnxt_en_dev *edev)
 		msleep(100);
 		i++;
 	}
+	mutex_unlock(&edev->en_dev_lock);
 	rtnl_unlock();
 	return;
 }
@@ -223,6 +227,12 @@ void bnxt_ulp_stop(struct bnxt *bp)
 	if (!edev)
 		return;
 
+	mutex_lock(&edev->en_dev_lock);
+	if (!bnxt_ulp_registered(edev)) {
+		mutex_unlock(&edev->en_dev_lock);
+		return;
+	}
+
 	edev->flags |= BNXT_EN_FLAG_ULP_STOPPED;
 	if (aux_priv) {
 		struct auxiliary_device *adev;
@@ -237,6 +247,7 @@ void bnxt_ulp_stop(struct bnxt *bp)
 			adrv->suspend(adev, pm);
 		}
 	}
+	mutex_unlock(&edev->en_dev_lock);
 }
 
 void bnxt_ulp_start(struct bnxt *bp, int err)
@@ -252,6 +263,12 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 	if (err)
 		return;
 
+	mutex_lock(&edev->en_dev_lock);
+	if (!bnxt_ulp_registered(edev)) {
+		mutex_unlock(&edev->en_dev_lock);
+		return;
+	}
+
 	if (edev->ulp_tbl->msix_requested)
 		bnxt_fill_msix_vecs(bp, edev->msix_entries);
 
@@ -267,7 +284,7 @@ void bnxt_ulp_start(struct bnxt *bp, int err)
 			adrv->resume(adev);
 		}
 	}
-
+	mutex_unlock(&edev->en_dev_lock);
 }
 
 void bnxt_ulp_irq_stop(struct bnxt *bp)
@@ -383,6 +400,7 @@ static void bnxt_set_edev_info(struct bnxt_en_dev *edev, struct bnxt *bp)
 	edev->l2_db_size = bp->db_size;
 	edev->l2_db_size_nc = bp->db_size;
 	edev->l2_db_offset = bp->db_offset;
+	mutex_init(&edev->en_dev_lock);
 
 	if (bp->flags & BNXT_FLAG_ROCEV1_CAP)
 		edev->flags |= BNXT_EN_FLAG_ROCEV1_CAP;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index b86baf901a5d..4eafe6ec0abf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -88,6 +88,9 @@ struct bnxt_en_dev {
 
 	u16				ulp_num_msix_vec;
 	u16				ulp_num_ctxs;
+
+					/* serialize ulp operations */
+	struct mutex			en_dev_lock;
 };
 
 static inline bool bnxt_ulp_registered(struct bnxt_en_dev *edev)
-- 
2.30.1


--000000000000745b890617599c34
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIC2VPtRnp8ip0KQs4uhvzX3lQHUBJnQd
lRYF4xCTlKwQMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUw
MTAwMzE0NFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAmXBCQ5VL5txGIbvEFl1IH16/UqcDiN9NwsD8F5E24Ps4Hd3C1
X4gxiw19dFz8UQIUsq9sQdc7rC5GKSq0BznFQgdc0WjFN0Q33PG/FQ2/vYi7QoAfzRs+yKpWCl4s
mHTskdhPVNOzH9kuk6f/vq0cNNjxA3X3yrreavJ4+R7s+C2P5QVHVY8BcwexKKgyOiGoc7WQffDe
5vqKoVSbhTWsbemhJSiK/m/Fem2ECaumVkAMyyzvSMZ1+1Mg2KkTmfks+G5NCtiVB6vyCblBeNlM
ohekz+sD6YrUo7cMJ3gNEFkvoxRoYCHovHy7SNBXa3j2sV73m+O2e9Md6ArOIM+k
--000000000000745b890617599c34--

