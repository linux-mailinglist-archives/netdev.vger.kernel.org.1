Return-Path: <netdev+bounces-49448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9CA7F2190
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D944B219EA
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF93B787;
	Mon, 20 Nov 2023 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K/8VRauR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEFCC7
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:39 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-42033328ad0so29939321cf.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 15:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700523878; x=1701128678; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=atj0wcg9XYQePoheikbPi9EKAIZzEF9jPNFTWltqhrY=;
        b=K/8VRauRGnvpKAovrzK5PWyQJLz7GorhsdgPnc3kjTvuFojMF7b5mMmFkDmZRnNR2U
         kwu+dkHfgEv9P6NZkclDdV9gruHwwj1t4o5yffDBT4K+IevJ2uQmiFk18kl0/zgAIqA/
         wfmYh5doVR0YR23PzcscXuRgl/ggEEJDBkxOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523878; x=1701128678;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=atj0wcg9XYQePoheikbPi9EKAIZzEF9jPNFTWltqhrY=;
        b=ZOph2JqOt8kao0BYBA7eUhECQmebVjBolRVbi6lrrsLT694YHYrYXju6n4Yw4xSBxf
         GVebX1bwYbPdMMMhuNLPjy1+252Jqwf4QQYM+BKLosYtTyz9N0L78//idwAeNOzdfzR2
         1RYsjZZOcpA96RX8J3vDCFZ+aa4iyW7N4ndPwoXqnTCPnsTeQhlci5RVQ2GIhZ2/128W
         5bw08+DuARnyN2wTJgcIFvkL0jukjjCvlqt0KZJzBowtgfulj9aXpRFtAvry6Ex8ltwb
         haaPsiVzK3g96MrB/5SdOqje1go7mBf4HiPBUylxxm/udJj/wTzD3mK5i0ASSiHWbeCH
         u1rg==
X-Gm-Message-State: AOJu0YxnuIyuHJXHhWvGa7zHbI07gSwkMjO5tl5PHN9NfGUZAp9IkM9l
	iGoHaX35leS3X6Yfu7/JGZT7TA==
X-Google-Smtp-Source: AGHT+IHlT+BNCYyJ3G1giaXbfyf3KH+fE7GUOntzEBLAU3l021t0YOBEVDN72auwvP3ySc1Yjynd7A==
X-Received: by 2002:a05:622a:50b:b0:418:15ab:85b8 with SMTP id l11-20020a05622a050b00b0041815ab85b8mr10844638qtx.13.1700523878329;
        Mon, 20 Nov 2023 15:44:38 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i9-20020ac871c9000000b0041803dfb240sm3053384qtp.45.2023.11.20.15.44.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Nov 2023 15:44:38 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 02/13] bnxt_en: Free bp->ctx inside bnxt_free_ctx_mem()
Date: Mon, 20 Nov 2023 15:43:54 -0800
Message-Id: <20231120234405.194542-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231120234405.194542-1-michael.chan@broadcom.com>
References: <20231120234405.194542-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b89eb7060a9e117f"

--000000000000b89eb7060a9e117f
Content-Transfer-Encoding: 8bit

We always free bp->ctx right after calling bnxt_free_ctx_mem(), so just
free it at the end of that function to make things simpler.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 14 ++------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c |  2 --
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6b19d5b8d95a..8ff21768e592 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7552,6 +7552,8 @@ void bnxt_free_ctx_mem(struct bnxt *bp)
 	bnxt_free_ctx_pg_tbls(bp, &ctx->srq_mem);
 	bnxt_free_ctx_pg_tbls(bp, &ctx->qp_mem);
 	ctx->flags &= ~BNXT_CTX_FLAG_INITED;
+	kfree(ctx);
+	bp->ctx = NULL;
 }
 
 static int bnxt_alloc_ctx_mem(struct bnxt *bp)
@@ -10321,8 +10323,6 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 			if (!test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
 				bnxt_ulp_stop(bp);
 			bnxt_free_ctx_mem(bp);
-			kfree(bp->ctx);
-			bp->ctx = NULL;
 			bnxt_dcb_free(bp);
 			rc = bnxt_fw_init_one(bp);
 			if (rc) {
@@ -11948,8 +11948,6 @@ static void bnxt_fw_reset_close(struct bnxt *bp)
 	if (pci_is_enabled(bp->pdev))
 		pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp);
-	kfree(bp->ctx);
-	bp->ctx = NULL;
 }
 
 static bool is_bnxt_fw_ok(struct bnxt *bp)
@@ -13368,8 +13366,6 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp);
-	kfree(bp->ctx);
-	bp->ctx = NULL;
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
 	bnxt_free_port_stats(bp);
@@ -13969,8 +13965,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp);
-	kfree(bp->ctx);
-	bp->ctx = NULL;
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
 
@@ -14023,8 +14017,6 @@ static int bnxt_suspend(struct device *device)
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp);
-	kfree(bp->ctx);
-	bp->ctx = NULL;
 	rtnl_unlock();
 	return rc;
 }
@@ -14121,8 +14113,6 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
 	bnxt_free_ctx_mem(bp);
-	kfree(bp->ctx);
-	bp->ctx = NULL;
 	rtnl_unlock();
 
 	/* Request a slot slot reset. */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index f302dac56599..10b842539b08 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -469,8 +469,6 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 		}
 		bnxt_cancel_reservations(bp, false);
 		bnxt_free_ctx_mem(bp);
-		kfree(bp->ctx);
-		bp->ctx = NULL;
 		break;
 	}
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE: {
-- 
2.30.1


--000000000000b89eb7060a9e117f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN8gs2rRKEoe9HaxnkHxIiPxnyfngNw3
uB9ssy4Evi5WMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTEy
MDIzNDQzOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCvDnvHIvs9VOK/cRcjuR+0RUmes5GcjcJ+Is4l1kpnZNVPxJfZ
bPBSdJxs37GkFYnd4L7nOqAckP4pYJqsOMpe7BVkUVQE4eAQHhcgv7RgnZCh0AxY8xb6T17CnezT
kMZeLeKXJRRQaku1lY+QjxeFZCt0GYiuAdpRAqqkCqyoAj8OZcYWLHS50/Z7Y8sxmILSwG5Med9k
HoA+vStnV11ComurxHGMMYCPaiH3/wtf21NNzHZXWEiQstMvpRo/TT94hhoESEPsbE7PGVt6sD3B
EX62vaGfqku71dYLPHk32QNz+RRPrODTxjVTR0ZV1IIDhsuPc0QAqcu/0HsemzAb
--000000000000b89eb7060a9e117f--

