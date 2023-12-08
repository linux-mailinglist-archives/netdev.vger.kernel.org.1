Return-Path: <netdev+bounces-55113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8352D80970C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 01:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76A31C20CA3
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 00:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8933D372;
	Fri,  8 Dec 2023 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MF1XSYFb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B48819A6
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 16:17:28 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-59063f8455eso737920eaf.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 16:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701994647; x=1702599447; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SdEmXiUuGSvk53hT7HIMfcR2WNZz4YIJetYDUMOmDbs=;
        b=MF1XSYFbFt+ZkgH962RdZzqox07ZLOPIuVcWK2B8VQj/BpCzsc+ZGVUXT1WrHN7MS7
         1412dG1FETZWSLyunW+Z4ZrApXw/XThsYqz9DeT6Mgc6n3KdLeQGdf8gtedB813rJCul
         kl1Kp6FzfVvFJf90YKi6KpyNTuQFskkLETT/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994647; x=1702599447;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdEmXiUuGSvk53hT7HIMfcR2WNZz4YIJetYDUMOmDbs=;
        b=X15XWMDk6cAmdN8PDordGkBt2ThORwHihUDe5MUdE+W1mlMNPFWzh6FGGBUp6AxYEW
         +VWi68y5A8yt65YfwFPWf0mtLiNhmyFEUUyRrUkZTkhp1qVs/gAWEwwYwKOoReRmGpKD
         jYFxDR5SNDZ75z2lNEcjJrPdhGbSqFsq5aLsJ9Z8PrFVeBuIzDOuPFFGfUFTRuKuf44E
         inV1ASxyOcKrSrS3w27kJ4aPl3zhCkhgYZV4RLCN/853YIa2Anes2MHmcG13vALjo6oF
         4HChgNHVC/gAx9KpavWPHFLR+1SjVRlDQnHYW9hSB1vU9JYh7MccgCYyL8Gn2TvZOgst
         NoaA==
X-Gm-Message-State: AOJu0Yx2bPKz1dGnV+YxdTRCaGMK9ZVOE92Anyxj01O3/gLfAPRYwnsu
	asdHDE2Uv9Er5b/zjnSt/xSFoA==
X-Google-Smtp-Source: AGHT+IFo6lCv6S3pDnlc9JNgBsXUZ9BSaVmZFNvKmlH1xdp5oPy+XpAqJOfQMuaIGkaZQG555ID5fQ==
X-Received: by 2002:a05:6358:882c:b0:170:17eb:203e with SMTP id hv44-20020a056358882c00b0017017eb203emr3848445rwb.39.1701994647050;
        Thu, 07 Dec 2023 16:17:27 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id o4-20020a056a0015c400b006cdd369e3d0sm356493pfu.201.2023.12.07.16.17.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2023 16:17:25 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net v3 3/4] bnxt_en: Fix wrong return value check in bnxt_close_nic()
Date: Thu,  7 Dec 2023 16:16:57 -0800
Message-Id: <20231208001658.14230-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231208001658.14230-1-michael.chan@broadcom.com>
References: <20231208001658.14230-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006245e0060bf4826f"

--0000000000006245e0060bf4826f
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

The wait_event_interruptible_timeout() function returns 0
if the timeout elapsed, -ERESTARTSYS if it was interrupted
by a signal, and the remaining jiffies otherwise if the
condition evaluated to true before the timeout elapsed.

Driver should have checked for zero return value instead of
a positive value.

MChan: Print a warning for -ERESTARTSYS.  The close operation
will proceed anyway when wait_event_interruptible_timeout()
returns for any reason.  Since we do the close no matter what,
we should not return this error code to the caller.  Change
bnxt_close_nic() to a void function and remove all error
handling from some of the callers.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3: Log a warning for -ERESTARTSYS and do not return error code
    to caller.
v2: Add missing SoB tag.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 13 +++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c | 11 ++---------
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 ++++---------------
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  5 ++---
 5 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b4a5311bdeb5..aa1f5b776b5a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10732,10 +10732,8 @@ static void __bnxt_close_nic(struct bnxt *bp, bool irq_re_init,
 	bnxt_free_mem(bp, irq_re_init);
 }
 
-int bnxt_close_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
+void bnxt_close_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 {
-	int rc = 0;
-
 	if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
 		/* If we get here, it means firmware reset is in progress
 		 * while we are trying to close.  We can safely proceed with
@@ -10750,15 +10748,18 @@ int bnxt_close_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 
 #ifdef CONFIG_BNXT_SRIOV
 	if (bp->sriov_cfg) {
+		int rc;
+
 		rc = wait_event_interruptible_timeout(bp->sriov_cfg_wait,
 						      !bp->sriov_cfg,
 						      BNXT_SRIOV_CFG_WAIT_TMO);
-		if (rc)
-			netdev_warn(bp->dev, "timeout waiting for SRIOV config operation to complete!\n");
+		if (!rc)
+			netdev_warn(bp->dev, "timeout waiting for SRIOV config operation to complete, proceeding to close!\n");
+		else if (rc < 0)
+			netdev_warn(bp->dev, "SRIOV config operation interrupted, proceeding to close!\n");
 	}
 #endif
 	__bnxt_close_nic(bp, irq_re_init, link_re_init);
-	return rc;
 }
 
 static int bnxt_close(struct net_device *dev)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e702dbc3e6b1..0488b0466015 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2375,7 +2375,7 @@ int bnxt_open_nic(struct bnxt *, bool, bool);
 int bnxt_half_open_nic(struct bnxt *bp);
 void bnxt_half_close_nic(struct bnxt *bp);
 void bnxt_reenable_sriov(struct bnxt *bp);
-int bnxt_close_nic(struct bnxt *, bool, bool);
+void bnxt_close_nic(struct bnxt *, bool, bool);
 void bnxt_get_ring_err_stats(struct bnxt *bp,
 			     struct bnxt_total_ring_err_stats *stats);
 int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index f302dac56599..89809f1b129c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -449,15 +449,8 @@ static int bnxt_dl_reload_down(struct devlink *dl, bool netns_change,
 			return -ENODEV;
 		}
 		bnxt_ulp_stop(bp);
-		if (netif_running(bp->dev)) {
-			rc = bnxt_close_nic(bp, true, true);
-			if (rc) {
-				NL_SET_ERR_MSG_MOD(extack, "Failed to close");
-				dev_close(bp->dev);
-				rtnl_unlock();
-				break;
-			}
-		}
+		if (netif_running(bp->dev))
+			bnxt_close_nic(bp, true, true);
 		bnxt_vf_reps_free(bp);
 		rc = bnxt_hwrm_func_drv_unrgtr(bp);
 		if (rc) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f3f384773ac0..5f67a7f94e7d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -165,9 +165,8 @@ static int bnxt_set_coalesce(struct net_device *dev,
 reset_coalesce:
 	if (test_bit(BNXT_STATE_OPEN, &bp->state)) {
 		if (update_stats) {
-			rc = bnxt_close_nic(bp, true, false);
-			if (!rc)
-				rc = bnxt_open_nic(bp, true, false);
+			bnxt_close_nic(bp, true, false);
+			rc = bnxt_open_nic(bp, true, false);
 		} else {
 			rc = bnxt_hwrm_set_coal(bp);
 		}
@@ -972,12 +971,7 @@ static int bnxt_set_channels(struct net_device *dev,
 			 * before PF unload
 			 */
 		}
-		rc = bnxt_close_nic(bp, true, false);
-		if (rc) {
-			netdev_err(bp->dev, "Set channel failure rc :%x\n",
-				   rc);
-			return rc;
-		}
+		bnxt_close_nic(bp, true, false);
 	}
 
 	if (sh) {
@@ -4042,12 +4036,7 @@ static void bnxt_self_test(struct net_device *dev, struct ethtool_test *etest,
 		bnxt_run_fw_tests(bp, test_mask, &test_results);
 	} else {
 		bnxt_ulp_stop(bp);
-		rc = bnxt_close_nic(bp, true, false);
-		if (rc) {
-			etest->flags |= ETH_TEST_FL_FAILED;
-			bnxt_ulp_start(bp, rc);
-			return;
-		}
+		bnxt_close_nic(bp, true, false);
 		bnxt_run_fw_tests(bp, test_mask, &test_results);
 
 		buf[BNXT_MACLPBK_TEST_IDX] = 1;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index f3886710e778..6e3da3362bd6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -521,9 +521,8 @@ static int bnxt_hwrm_ptp_cfg(struct bnxt *bp)
 
 	if (netif_running(bp->dev)) {
 		if (ptp->rx_filter == HWTSTAMP_FILTER_ALL) {
-			rc = bnxt_close_nic(bp, false, false);
-			if (!rc)
-				rc = bnxt_open_nic(bp, false, false);
+			bnxt_close_nic(bp, false, false);
+			rc = bnxt_open_nic(bp, false, false);
 		} else {
 			bnxt_ptp_cfg_tstamp_filters(bp);
 		}
-- 
2.30.1


--0000000000006245e0060bf4826f
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKFgr/y0aGcmV4L2a7yrqS67S0rm1bJ6
W5t395VA92lvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
ODAwMTcyN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQC1g9W4KPD9HTdaSDdfpziYfwLbdwt4WKqdzU9hjPaemMRUSTtt
/sLm/TEMCXz9dVSydJ37p8gdnkDDlANS8TcGPqwDI0gu0++5xrTyxTq+nSSjOHhIeMVCcVIKmsUL
zfGTZMBW7wg8pLW/SbhI2unSoS0xx7PNWYFTl/vv7RzKy1CPZUaDmKj1SaJo0A+BLOZdqCXKCrtP
cBHKy6jmlUHsV12wmeVzUkLSlHNBT1ozZF27L1uaf9ecGx1c7OanLBCZqtY0MAFepcXVjVRhnrO3
xIAV8q1dp3CRYuMwn98FjjvPiB3xlDa/d5PVOjukZsK744hKAcuiRRILeNtIbSnj
--0000000000006245e0060bf4826f--

