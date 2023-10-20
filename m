Return-Path: <netdev+bounces-43132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC0C7D180F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC05B1C210CC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE3D3158D;
	Fri, 20 Oct 2023 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fj8K1ZQV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7B2B74B
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:28:23 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF85D7C
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5892832f8daso1867228a12.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697837297; x=1698442097; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=naLP3uk0QzlFzWMjrDGbMLoqGb9RAO2Pak7io1tig3U=;
        b=fj8K1ZQVdu+OXrbGc9ngHuB5HAmrYPp5tFCBjf72V4ATM//sWNqwjFqK+YsgeatapV
         5ORHgsApw8wZdgLWvBUypf3JeFOH2ISj2LYgUENFi1p3A2Ej8WJHqYKtVyZYJyVuyDL1
         CbefMQtqYW+cX3pJOrpEWP7WaP0Il1RTydGH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697837297; x=1698442097;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naLP3uk0QzlFzWMjrDGbMLoqGb9RAO2Pak7io1tig3U=;
        b=QzQnGfT4VgYzxYhNrWoVTOc6ReDl9SPwqLi0yYuFtmctyT+TqE6Yg5D63i3T6jKacj
         xNxgEr02KyCC4TgltF5jXg2WbHogCh2uM1E1JHc2amCVu+vw66wfD6ryu2zQsGC9FGxR
         t9iQko4T895bIXD9wtObheqIV5W5JmRLgQ+UJl7YDnKZjZOgDug2GQNltf7n2xf4OAMR
         fEc41nyLXFo/2UAk5T+KreWv0l2njBSHfXjfHvMC4SEHGYiL+exsuCBwGQG/3E0oVkEd
         uACsThlF0PrTMINjqpVhgHRk3xef2HPCVPVA09XoyEOpWkxRV+We6H2nLiQdyYvo5kvx
         aFXA==
X-Gm-Message-State: AOJu0YwTnsAPc4ZXfzW6g5UFgje39TADeoR9sMTu8frj3bD6YVo437sd
	hbYeYdVi+/YR5i38dO9YhqwmYA==
X-Google-Smtp-Source: AGHT+IEwQ45koJeSedVD6R+iHaedGP/4ckSN+dT8ffINHWkVIyNzB5uo8WPiQQ7bPn1dXQDjP3wU8g==
X-Received: by 2002:a17:90b:3546:b0:27d:5568:e867 with SMTP id lt6-20020a17090b354600b0027d5568e867mr4424772pjb.9.1697837296920;
        Fri, 20 Oct 2023 14:28:16 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a7e8d00b0026d4100e0e8sm1843348pjl.10.2023.10.20.14.28.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2023 14:28:16 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next 6/8] bnxt_en: Refactor NRZ/PAM4 link speed related logic
Date: Fri, 20 Oct 2023 14:27:55 -0700
Message-Id: <20231020212757.173551-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231020212757.173551-1-michael.chan@broadcom.com>
References: <20231020212757.173551-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000003dbc506082c8de4"

--00000000000003dbc506082c8de4
Content-Transfer-Encoding: 8bit

Refactor some NRZ/PAM4 link speed related logic into helper functions.
The NRZ and PAM4 link parameters are stored in separate structure fields.
The driver logic has to check whether it is in NRZ or PAM4 mode and
then use the appropriate field.

Refactor this logic into helper functions for better readability.

Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 98 ++++++++++++++++-------
 1 file changed, 67 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 65092150d451..5d7a29f99401 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2129,6 +2129,48 @@ static u16 bnxt_agg_ring_id_to_grp_idx(struct bnxt *bp, u16 ring_id)
 	return INVALID_HW_RING_ID;
 }
 
+static u16 bnxt_get_force_speed(struct bnxt_link_info *link_info)
+{
+	if (link_info->req_signal_mode == BNXT_SIG_MODE_PAM4)
+		return link_info->force_pam4_link_speed;
+	return link_info->force_link_speed;
+}
+
+static void bnxt_set_force_speed(struct bnxt_link_info *link_info)
+{
+	link_info->req_link_speed = link_info->force_link_speed;
+	link_info->req_signal_mode = BNXT_SIG_MODE_NRZ;
+	if (link_info->force_pam4_link_speed) {
+		link_info->req_link_speed = link_info->force_pam4_link_speed;
+		link_info->req_signal_mode = BNXT_SIG_MODE_PAM4;
+	}
+}
+
+static void bnxt_set_auto_speed(struct bnxt_link_info *link_info)
+{
+	link_info->advertising = link_info->auto_link_speeds;
+	link_info->advertising_pam4 = link_info->auto_pam4_link_speeds;
+}
+
+static bool bnxt_force_speed_updated(struct bnxt_link_info *link_info)
+{
+	if (link_info->req_signal_mode == BNXT_SIG_MODE_NRZ &&
+	    link_info->req_link_speed != link_info->force_link_speed)
+		return true;
+	if (link_info->req_signal_mode == BNXT_SIG_MODE_PAM4 &&
+	    link_info->req_link_speed != link_info->force_pam4_link_speed)
+		return true;
+	return false;
+}
+
+static bool bnxt_auto_speed_updated(struct bnxt_link_info *link_info)
+{
+	if (link_info->advertising != link_info->auto_link_speeds ||
+	    link_info->advertising_pam4 != link_info->auto_pam4_link_speeds)
+		return true;
+	return false;
+}
+
 #define BNXT_EVENT_THERMAL_CURRENT_TEMP(data2)				\
 	((data2) &							\
 	  ASYNC_EVENT_CMPL_ERROR_REPORT_THERMAL_EVENT_DATA2_CURRENT_TEMP_MASK)
@@ -2255,7 +2297,7 @@ static int bnxt_async_event_process(struct bnxt *bp,
 		/* print unsupported speed warning in forced speed mode only */
 		if (!(link_info->autoneg & BNXT_AUTONEG_SPEED) &&
 		    (data1 & 0x20000)) {
-			u16 fw_speed = link_info->force_link_speed;
+			u16 fw_speed = bnxt_get_force_speed(link_info);
 			u32 speed = bnxt_fw_to_ethtool_speed(fw_speed);
 
 			if (speed != SPEED_UNKNOWN)
@@ -9689,13 +9731,31 @@ static bool bnxt_support_dropped(u16 advertising, u16 supported)
 	return ((supported | diff) != supported);
 }
 
+static bool bnxt_support_speed_dropped(struct bnxt_link_info *link_info)
+{
+	/* Check if any advertised speeds are no longer supported. The caller
+	 * holds the link_lock mutex, so we can modify link_info settings.
+	 */
+	if (bnxt_support_dropped(link_info->advertising,
+				 link_info->support_auto_speeds)) {
+		link_info->advertising = link_info->support_auto_speeds;
+		return true;
+	}
+	if (bnxt_support_dropped(link_info->advertising_pam4,
+				 link_info->support_pam4_auto_speeds)) {
+		link_info->advertising_pam4 = link_info->support_pam4_auto_speeds;
+		return true;
+	}
+	return false;
+}
+
 int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
 {
 	struct bnxt_link_info *link_info = &bp->link_info;
 	struct hwrm_port_phy_qcfg_output *resp;
 	struct hwrm_port_phy_qcfg_input *req;
 	u8 link_state = link_info->link_state;
-	bool support_changed = false;
+	bool support_changed;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_PORT_PHY_QCFG);
@@ -9809,19 +9869,7 @@ int bnxt_update_link(struct bnxt *bp, bool chng_link_state)
 	if (!BNXT_PHY_CFG_ABLE(bp))
 		return 0;
 
-	/* Check if any advertised speeds are no longer supported. The caller
-	 * holds the link_lock mutex, so we can modify link_info settings.
-	 */
-	if (bnxt_support_dropped(link_info->advertising,
-				 link_info->support_auto_speeds)) {
-		link_info->advertising = link_info->support_auto_speeds;
-		support_changed = true;
-	}
-	if (bnxt_support_dropped(link_info->advertising_pam4,
-				 link_info->support_pam4_auto_speeds)) {
-		link_info->advertising_pam4 = link_info->support_pam4_auto_speeds;
-		support_changed = true;
-	}
+	support_changed = bnxt_support_speed_dropped(link_info);
 	if (support_changed && (link_info->autoneg & BNXT_AUTONEG_SPEED))
 		bnxt_hwrm_set_link_setting(bp, true, false);
 	return 0;
@@ -10362,19 +10410,14 @@ static int bnxt_update_phy_setting(struct bnxt *bp)
 	if (!(link_info->autoneg & BNXT_AUTONEG_SPEED)) {
 		if (BNXT_AUTO_MODE(link_info->auto_mode))
 			update_link = true;
-		if (link_info->req_signal_mode == BNXT_SIG_MODE_NRZ &&
-		    link_info->req_link_speed != link_info->force_link_speed)
-			update_link = true;
-		else if (link_info->req_signal_mode == BNXT_SIG_MODE_PAM4 &&
-			 link_info->req_link_speed != link_info->force_pam4_link_speed)
+		if (bnxt_force_speed_updated(link_info))
 			update_link = true;
 		if (link_info->req_duplex != link_info->duplex_setting)
 			update_link = true;
 	} else {
 		if (link_info->auto_mode == BNXT_LINK_AUTO_NONE)
 			update_link = true;
-		if (link_info->advertising != link_info->auto_link_speeds ||
-		    link_info->advertising_pam4 != link_info->auto_pam4_link_speeds)
+		if (bnxt_auto_speed_updated(link_info))
 			update_link = true;
 	}
 
@@ -11992,16 +12035,9 @@ static void bnxt_init_ethtool_link_settings(struct bnxt *bp)
 		} else {
 			link_info->autoneg |= BNXT_AUTONEG_FLOW_CTRL;
 		}
-		link_info->advertising = link_info->auto_link_speeds;
-		link_info->advertising_pam4 = link_info->auto_pam4_link_speeds;
+		bnxt_set_auto_speed(link_info);
 	} else {
-		link_info->req_link_speed = link_info->force_link_speed;
-		link_info->req_signal_mode = BNXT_SIG_MODE_NRZ;
-		if (link_info->force_pam4_link_speed) {
-			link_info->req_link_speed =
-				link_info->force_pam4_link_speed;
-			link_info->req_signal_mode = BNXT_SIG_MODE_PAM4;
-		}
+		bnxt_set_force_speed(link_info);
 		link_info->req_duplex = link_info->duplex_setting;
 	}
 	if (link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL)
-- 
2.30.1


--00000000000003dbc506082c8de4
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIPIbI0k9rr9/74O6UotzoC1yCWe6DpuY
S31aPR2/vyjdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
MDIxMjgxN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBS+6foV5lgprUReeVPkWkXiRMN+oLlFo5vt/kw9HvwTBjU4G8i
ySX/So+Ku2S8D+jBzlmhWu+LUgDL2DNlcXp5GxBvH9r92+GcnUiMVx5cIsd336Ed2yof43WbPQO7
8USIGig1bxJnZ+dw3TJbje7FX3ewRebxhulYhFOHHOp/UDo1AH20IKhCVWHANs1oVRlwnTbcCyO0
2GEs8c96sTgDO6sI7v2eP7PH3F590G/7Z/4oI95+yRggPnln+SS7wd5h2BJL2lNSXJNd0grYGFYV
DlIpP2qm5alR1tkVAxMHYSaMfaDIgxQAfV6zA1NueTxtU7034IrpwMEiA4cXXDkO
--00000000000003dbc506082c8de4--

