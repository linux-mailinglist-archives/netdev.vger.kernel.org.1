Return-Path: <netdev+bounces-43131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C33B7D180E
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A65EB21592
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839FC2FE06;
	Fri, 20 Oct 2023 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eQpyb627"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB12747B
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:28:20 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7959BD76
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27d329a704bso968892a91.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697837295; x=1698442095; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0iDsdde1UpxLJuddoHTlaXetG59akoEUYg8dcbi1CJE=;
        b=eQpyb627xlAu7E6gWopaxMwxWoPGWMi0/8WNTVBe5n58rsYCgy8bw6MShrLohP6Ki4
         AMLsWXUJSR/v61nFTR5qvN1c56pwGWN9l56dJ03kXM9rqgR9wGNdj0n/0Ju5sbiUXHDw
         Tnej2O/IvhcNHxcbUuPVgMKyTMtAxpk7x3rVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697837295; x=1698442095;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0iDsdde1UpxLJuddoHTlaXetG59akoEUYg8dcbi1CJE=;
        b=FrCOEZQzqJZJMQVth2UGTmbLHjKcnS0daI56X/IYL7RpcI2aePXjI/C4JKhIgoMeMm
         WCYVaYFjIebgnDFhilhXMOcUZ/ol7BO32gJ31p2O05lyklZ+9OSUOyhtlQNpWNNo1Htp
         fcWy+q6Oq8y/GZ+I1OEMQnM2y8bQ/T9GLnAZ2lxgK4RME02zvXNpBhUmI9roQ9IvS5ww
         6tSh0DWH4SToirhiW/qpHmfXrm7jkISVJbqt2zbGJ4Ptra3uoI87rH9E4uwIzqORFuCa
         aZI8lXewTuViTX9P7sgfO7oIuB2zvFnx8a9rRHNzUH3SnfBHZCrvRuKkZnBzT1fk2ld3
         w5aQ==
X-Gm-Message-State: AOJu0Yzi5Xlhr0i29CcIpyoG0yRwsnC38vyf5aFhbukOpygwEffFcXCI
	6YOG9znEmaszqZBijbS2KXgh+A==
X-Google-Smtp-Source: AGHT+IHOw0XdzSLntTJaYdycuB63yxn48hUMo6IxfzHQE1hAssUYZ/G7ZNTB+kqTgLvbm7G7oKr9Mw==
X-Received: by 2002:a17:90a:8a12:b0:27d:1af5:3b17 with SMTP id w18-20020a17090a8a1200b0027d1af53b17mr2893733pjn.26.1697837294383;
        Fri, 20 Oct 2023 14:28:14 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a7e8d00b0026d4100e0e8sm1843348pjl.10.2023.10.20.14.28.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2023 14:28:13 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [PATCH net-next 4/8] bnxt_en: support lane configuration via ethtool
Date: Fri, 20 Oct 2023 14:27:53 -0700
Message-Id: <20231020212757.173551-5-michael.chan@broadcom.com>
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
	boundary="000000000000de999806082c8c8c"

--000000000000de999806082c8c8c
Content-Transfer-Encoding: 8bit

From: Edwin Peer <edwin.peer@broadcom.com>

Recent kernels support changing the number of link lanes via ethtool.
This is useful for determining the appropriate signal mode to use when
a given link speed can be achieved using different lane configurations.

Accept the ethtool lanes parameter when configuring forced speed.  If
there is no lanes parameter, select a default.

Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 32 +++++++++++++++----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index c925e21eadec..19b0bff9c590 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2019,13 +2019,15 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	return 0;
 }
 
-static int bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed)
+static int
+bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 lanes)
 {
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_link_info *link_info = &bp->link_info;
 	u16 support_pam4_spds = link_info->support_pam4_speeds;
 	u16 support_spds = link_info->support_speeds;
 	u8 sig_mode = BNXT_SIG_MODE_NRZ;
+	u32 lanes_needed = 1;
 	u16 fw_speed = 0;
 
 	switch (ethtool_speed) {
@@ -2046,37 +2048,46 @@ static int bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed)
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_10GB;
 		break;
 	case SPEED_20000:
-		if (support_spds & BNXT_LINK_SPEED_MSK_20GB)
+		if (support_spds & BNXT_LINK_SPEED_MSK_20GB) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_20GB;
+			lanes_needed = 2;
+		}
 		break;
 	case SPEED_25000:
 		if (support_spds & BNXT_LINK_SPEED_MSK_25GB)
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_25GB;
 		break;
 	case SPEED_40000:
-		if (support_spds & BNXT_LINK_SPEED_MSK_40GB)
+		if (support_spds & BNXT_LINK_SPEED_MSK_40GB) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_40GB;
+			lanes_needed = 4;
+		}
 		break;
 	case SPEED_50000:
-		if (support_spds & BNXT_LINK_SPEED_MSK_50GB) {
+		if ((support_spds & BNXT_LINK_SPEED_MSK_50GB) && lanes != 1) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_50GB;
+			lanes_needed = 2;
 		} else if (support_pam4_spds & BNXT_LINK_PAM4_SPEED_MSK_50GB) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_50GB;
 			sig_mode = BNXT_SIG_MODE_PAM4;
 		}
 		break;
 	case SPEED_100000:
-		if (support_spds & BNXT_LINK_SPEED_MSK_100GB) {
+		if ((support_spds & BNXT_LINK_SPEED_MSK_100GB) &&
+		    lanes != 2 && lanes != 1) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_100GB;
+			lanes_needed = 4;
 		} else if (support_pam4_spds & BNXT_LINK_PAM4_SPEED_MSK_100GB) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_100GB;
 			sig_mode = BNXT_SIG_MODE_PAM4;
+			lanes_needed = 2;
 		}
 		break;
 	case SPEED_200000:
 		if (support_pam4_spds & BNXT_LINK_PAM4_SPEED_MSK_200GB) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_200GB;
 			sig_mode = BNXT_SIG_MODE_PAM4;
+			lanes_needed = 4;
 		}
 		break;
 	}
@@ -2086,6 +2097,11 @@ static int bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed)
 		return -EINVAL;
 	}
 
+	if (lanes && lanes != lanes_needed) {
+		netdev_err(dev, "unsupported number of lanes for speed\n");
+		return -EINVAL;
+	}
+
 	if (link_info->req_link_speed == fw_speed &&
 	    link_info->req_signal_mode == sig_mode &&
 	    link_info->autoneg == 0)
@@ -2130,7 +2146,7 @@ static int bnxt_set_link_ksettings(struct net_device *dev,
 	struct bnxt_link_info *link_info = &bp->link_info;
 	const struct ethtool_link_settings *base = &lk_ksettings->base;
 	bool set_pause = false;
-	u32 speed;
+	u32 speed, lanes = 0;
 	int rc = 0;
 
 	if (!BNXT_PHY_CFG_ABLE(bp))
@@ -2171,7 +2187,8 @@ static int bnxt_set_link_ksettings(struct net_device *dev,
 			goto set_setting_exit;
 		}
 		speed = base->speed;
-		rc = bnxt_force_link_speed(dev, speed);
+		lanes = lk_ksettings->lanes;
+		rc = bnxt_force_link_speed(dev, speed, lanes);
 		if (rc) {
 			if (rc == -EALREADY)
 				rc = 0;
@@ -4377,6 +4394,7 @@ void bnxt_ethtool_free(struct bnxt *bp)
 }
 
 const struct ethtool_ops bnxt_ethtool_ops = {
+	.cap_link_lanes_supported	= 1,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
 				     ETHTOOL_COALESCE_USECS_IRQ |
-- 
2.30.1


--000000000000de999806082c8c8c
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIAm5NSzECIc+Xzo9fBQMkIaqkAUQPmxb
gi9W2vbY7RyBMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
MDIxMjgxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBMV5aeDaK8pMizNMYjY/24EnGdatS2ivbA7yfMEBW/tjzVJnlK
Ul+9/4H+GxgIMav4N0KTIRDgf8PWh/EqBNOiAxs7CZDIi/EztXu9zbkjc6bsNkH3gqV6b3REdBhp
amgMlOIgf8EY4xOAc82pMK0hMJZLd0M3hfrlVNk4iVQYAHNp23ECxmu9qt4qP5lBNRwHIfkvTbwT
Oq+iXCvnXc8sgb0C9VEAZzhhA00xm9Mg6Z9U9Ucasg8nprFN1J9SzJhQusrBwpkKfLat8iiXOld4
P5HPMeBm+MFMbPMr7b+QOMIxiCLywt6LfDtGxkoR8YNZ/gEZJ8my+F4raTwWUnyS
--000000000000de999806082c8c8c--

