Return-Path: <netdev+bounces-36401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8418E7AF8E7
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 337951C2083E
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 03:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C5E134B3;
	Wed, 27 Sep 2023 03:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFE2134A5
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 03:58:08 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4821E1E953
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:07 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59f6e6b206fso75970847b3.3
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 20:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1695787086; x=1696391886; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZGP3jLAK49z6VBhkQP5/gfVQ4vZzO/FNHztPkUzS10=;
        b=CI7lyrEm644dFm5i2uRWvIUt+MeAlRIFU1KONvntvJywhhDfqNsxNjv9c8cDG4BgAU
         IrTP2jw9e8R1+7FPpHo/IcycKV8GMTDSFqg7ri3vTB0wNA2QImmyzq9+AvLk6abkkQUr
         NjwxbtrHLmgGMhcRt0UaR3epUmRywhulv1sB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695787086; x=1696391886;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZGP3jLAK49z6VBhkQP5/gfVQ4vZzO/FNHztPkUzS10=;
        b=sEs3ejm0l280ETo769wzPWxvsn0ZBxCi4W7RE6yYMGmFut6Vc4SKhP3e2v8Ne3P1Y/
         9zFy21HVJ1q/kWOxyPSAqEDf7RAWrD1eoWXjMUi8yl6T8BFC9u5+SFDFj2SZ4uW2G29Q
         EqDG44g0C6nkwzXTlR7o5sjPFOD5Zf3iPxjuU0roeqks9Gt8P/TCx4Ibxdxjlu36Bcg3
         xHAPrUrrC2h7H8V7CpjseO5UZfe8MWqTOh+ZCd/EgJiq9dK97zs0pUtIVRHWJaHvojPP
         7i++A+XuQzie9o74bUNsg2iek2w8WCm2ajN2ytA9eohSChJSD9LvkLKBUpGUXox989mW
         qqSw==
X-Gm-Message-State: AOJu0Yxaas7uIq92W0uKSKdqPAu+PbtBFlfRRdI/C2M5YVD7WdmOScCu
	Op5Z1pxSzrcE6GCZjcu7GLCizA==
X-Google-Smtp-Source: AGHT+IH3DEix9zBQVCrnzLq61HEHACX1dkh1+9MgYhl98juP9g4WG7OvGu7XImXfYrdvdZ9b+axmxQ==
X-Received: by 2002:a0d:d914:0:b0:56f:fffc:56ff with SMTP id b20-20020a0dd914000000b0056ffffc56ffmr1160919ywe.42.1695787086248;
        Tue, 26 Sep 2023 20:58:06 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id k67-20020a633d46000000b00577bc070c6bsm9736097pga.68.2023.09.26.20.58.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 20:58:05 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 2/9] bnxt_en: Enhance hwmon temperature reporting
Date: Tue, 26 Sep 2023 20:57:27 -0700
Message-Id: <20230927035734.42816-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230927035734.42816-1-michael.chan@broadcom.com>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000eb500506064f322e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000eb500506064f322e
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Driver currently does hwmon device register and unregister
in open and close() respectively. As a result, user will not
be able to query hwmon temperature when interface is in
ifdown state.

Enhance it by moving the hwmon register/unregister to the
probe/remove functions.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7551aa8068f8..785084147994 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10280,7 +10280,7 @@ static struct attribute *bnxt_attrs[] = {
 };
 ATTRIBUTE_GROUPS(bnxt);
 
-static void bnxt_hwmon_close(struct bnxt *bp)
+static void bnxt_hwmon_uninit(struct bnxt *bp)
 {
 	if (bp->hwmon_dev) {
 		hwmon_device_unregister(bp->hwmon_dev);
@@ -10288,7 +10288,7 @@ static void bnxt_hwmon_close(struct bnxt *bp)
 	}
 }
 
-static void bnxt_hwmon_open(struct bnxt *bp)
+static void bnxt_hwmon_init(struct bnxt *bp)
 {
 	struct hwrm_temp_monitor_query_input *req;
 	struct pci_dev *pdev = bp->pdev;
@@ -10298,7 +10298,7 @@ static void bnxt_hwmon_open(struct bnxt *bp)
 	if (!rc)
 		rc = hwrm_req_send_silent(bp, req);
 	if (rc == -EACCES || rc == -EOPNOTSUPP) {
-		bnxt_hwmon_close(bp);
+		bnxt_hwmon_uninit(bp);
 		return;
 	}
 
@@ -10314,11 +10314,11 @@ static void bnxt_hwmon_open(struct bnxt *bp)
 	}
 }
 #else
-static void bnxt_hwmon_close(struct bnxt *bp)
+static void bnxt_hwmon_uninit(struct bnxt *bp)
 {
 }
 
-static void bnxt_hwmon_open(struct bnxt *bp)
+static void bnxt_hwmon_init(struct bnxt *bp)
 {
 }
 #endif
@@ -10651,7 +10651,6 @@ static int bnxt_open(struct net_device *dev)
 				bnxt_reenable_sriov(bp);
 			}
 		}
-		bnxt_hwmon_open(bp);
 	}
 
 	return rc;
@@ -10736,7 +10735,6 @@ static int bnxt_close(struct net_device *dev)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
-	bnxt_hwmon_close(bp);
 	bnxt_close_nic(bp, true, true);
 	bnxt_hwrm_shutdown_link(bp);
 	bnxt_hwrm_if_change(bp, false);
@@ -12300,6 +12298,7 @@ static int bnxt_fw_init_one_p2(struct bnxt *bp)
 	if (bp->fw_cap & BNXT_FW_CAP_PTP)
 		__bnxt_hwrm_ptp_qcfg(bp);
 	bnxt_dcb_init(bp);
+	bnxt_hwmon_init(bp);
 	return 0;
 }
 
@@ -13205,6 +13204,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bnxt_clear_int_mode(bp);
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	bnxt_free_hwrm_resources(bp);
+	bnxt_hwmon_uninit(bp);
 	bnxt_ethtool_free(bp);
 	bnxt_dcb_free(bp);
 	kfree(bp->ptp_cfg);
@@ -13801,6 +13801,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 init_err_pci_clean:
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	bnxt_free_hwrm_resources(bp);
+	bnxt_hwmon_uninit(bp);
 	bnxt_ethtool_free(bp);
 	bnxt_ptp_clear(bp);
 	kfree(bp->ptp_cfg);
-- 
2.30.1


--000000000000eb500506064f322e
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBUhKWFEYiwFPdb0G3lAeEaKPghpGo/N
GpqlW4LjhSx/MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDky
NzAzNTgwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAl6POZU+fRwb6fTYm4u7s+mqETdLLlOadgBlth7oBnYTTnIQ39
a8fDighekGGd6WOwGprsEaOkjqMwfirtqtzr5q/98VgOjW/vl59CV4SeAw3YTPnVuHzjt06o0e4G
EcHOah5UP45RpUOerG539Ar05bQTyhwzB8SxWjW/8pndwRNisV8qYPc5TiHKYb8n6wwkiL/Z/WfY
1TM2tFqHKju6E6JwBo6xXWZ1swk1MA2K4bGojjpzNp2XTzIGm+qeXSdjuYhybb767EbBgtvy1S0W
6HGVfBcWMKQyctGbZQ51HIno7sj2xKwoSTN6xXKFshrY9GTpm9fa0ufBFw05zg89
--000000000000eb500506064f322e--

