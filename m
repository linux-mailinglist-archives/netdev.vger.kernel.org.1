Return-Path: <netdev+bounces-53130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0408016AC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F06D1C20C46
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1B59E32;
	Fri,  1 Dec 2023 22:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M0x8rYpP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964AAAD
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:40:07 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-67a3f1374bdso15093616d6.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470406; x=1702075206; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNSDybDxes7MnX6TFDQ7QxvtL3sFEmrHYiXyOLUt4Y4=;
        b=M0x8rYpPRHFokTLZH5WJTJFcApPYxd66gD0+u45Kll2ZEYXhaqj4I47veeD2TLf8sA
         oiTRU7glZw20EMUR+pEG/TY4VwZMIRsOU1gVGXHjJOpmtIeEyJ2EE+/DCYgOfw44Eayu
         +iJKf3y7C+lHUaEJUiV4GNDFySaarpp8cNYYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470406; x=1702075206;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNSDybDxes7MnX6TFDQ7QxvtL3sFEmrHYiXyOLUt4Y4=;
        b=nZxXuEBvfbL4YSDo5+9exQUifS9FGaTKv3xWaekRfZvGAl19l+yZja62X7ib6IANyj
         qbXj28xb6baBcndKk8F7/jiNMLB/IGcvovHQuypKcHWkA4jXJlgOHvOBSYrrcbAGyCZN
         t4QEfWUOjc8MGoEfGTntsSmu2mE5y/wFFSRykx3rYKLYG0D6e5iv8752DthS5cN38Eor
         Fk+ZCn7OiyhGeZy78I0cSlztOyDa3xniEkCFSr05PmfP+TimjAb+vQa4rxwYsDe+SAg3
         CUE05L58wsj2D+ijUWB/4OF98RguWGYcBpsP8CWahlcwl9r26sbRQuCPA2H0ySw18psn
         8GgA==
X-Gm-Message-State: AOJu0YyyDnYoB/OiZhhTS89V9eUKd2T+r8I1yjeiO6ou8n4aN/k56MPo
	SVPSnPMcSqJYWi2kGQ2g0scd9g==
X-Google-Smtp-Source: AGHT+IHatHbb1ad2bRVZDYYGUx8eyONIY9fYH+o49muxdW49e6D87he8rR2yTs4vpbsM3Q2r+ZwzVw==
X-Received: by 2002:a0c:ed4a:0:b0:67a:93b7:c880 with SMTP id v10-20020a0ced4a000000b0067a93b7c880mr426359qvq.11.1701470406363;
        Fri, 01 Dec 2023 14:40:06 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.40.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:40:06 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 13/15] bnxt_en: Support force speed using the new HWRM fields
Date: Fri,  1 Dec 2023 14:39:22 -0800
Message-Id: <20231201223924.26955-14-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231201223924.26955-1-michael.chan@broadcom.com>
References: <20231201223924.26955-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000332182060b7a7390"

--000000000000332182060b7a7390
Content-Transfer-Encoding: 8bit

Modify bnxt_force_link_speed() to support the new speeds stored in
link_info->support_speeds2, including the new 400G speed.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 52 ++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 7bc0bddbb126..0a7dd48f1da8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2128,6 +2128,7 @@ bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 lanes)
 	struct bnxt *bp = netdev_priv(dev);
 	struct bnxt_link_info *link_info = &bp->link_info;
 	u16 support_pam4_spds = link_info->support_pam4_speeds;
+	u16 support_spds2 = link_info->support_speeds2;
 	u16 support_spds = link_info->support_speeds;
 	u8 sig_mode = BNXT_SIG_MODE_NRZ;
 	u32 lanes_needed = 1;
@@ -2139,7 +2140,8 @@ bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 lanes)
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_100MB;
 		break;
 	case SPEED_1000:
-		if (support_spds & BNXT_LINK_SPEED_MSK_1GB)
+		if ((support_spds & BNXT_LINK_SPEED_MSK_1GB) ||
+		    (support_spds2 & BNXT_LINK_SPEEDS2_MSK_1GB))
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_1GB;
 		break;
 	case SPEED_2500:
@@ -2147,7 +2149,8 @@ bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 lanes)
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_2_5GB;
 		break;
 	case SPEED_10000:
-		if (support_spds & BNXT_LINK_SPEED_MSK_10GB)
+		if ((support_spds & BNXT_LINK_SPEED_MSK_10GB) ||
+		    (support_spds2 & BNXT_LINK_SPEEDS2_MSK_10GB))
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_10GB;
 		break;
 	case SPEED_20000:
@@ -2157,26 +2160,34 @@ bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 lanes)
 		}
 		break;
 	case SPEED_25000:
-		if (support_spds & BNXT_LINK_SPEED_MSK_25GB)
+		if ((support_spds & BNXT_LINK_SPEED_MSK_25GB) ||
+		    (support_spds2 & BNXT_LINK_SPEEDS2_MSK_25GB))
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_25GB;
 		break;
 	case SPEED_40000:
-		if (support_spds & BNXT_LINK_SPEED_MSK_40GB) {
+		if ((support_spds & BNXT_LINK_SPEED_MSK_40GB) ||
+		    (support_spds2 & BNXT_LINK_SPEEDS2_MSK_40GB)) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_40GB;
 			lanes_needed = 4;
 		}
 		break;
 	case SPEED_50000:
-		if ((support_spds & BNXT_LINK_SPEED_MSK_50GB) && lanes != 1) {
+		if (((support_spds & BNXT_LINK_SPEED_MSK_50GB) ||
+		     (support_spds2 & BNXT_LINK_SPEEDS2_MSK_50GB)) &&
+		    lanes != 1) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_50GB;
 			lanes_needed = 2;
 		} else if (support_pam4_spds & BNXT_LINK_PAM4_SPEED_MSK_50GB) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_50GB;
 			sig_mode = BNXT_SIG_MODE_PAM4;
+		} else if (support_spds2 & BNXT_LINK_SPEEDS2_MSK_50GB_PAM4) {
+			fw_speed = BNXT_LINK_SPEED_50GB_PAM4;
+			sig_mode = BNXT_SIG_MODE_PAM4;
 		}
 		break;
 	case SPEED_100000:
-		if ((support_spds & BNXT_LINK_SPEED_MSK_100GB) &&
+		if (((support_spds & BNXT_LINK_SPEED_MSK_100GB) ||
+		     (support_spds2 & BNXT_LINK_SPEEDS2_MSK_100GB)) &&
 		    lanes != 2 && lanes != 1) {
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_LINK_SPEED_100GB;
 			lanes_needed = 4;
@@ -2184,6 +2195,14 @@ bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 lanes)
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_100GB;
 			sig_mode = BNXT_SIG_MODE_PAM4;
 			lanes_needed = 2;
+		} else if ((support_spds2 & BNXT_LINK_SPEEDS2_MSK_100GB_PAM4) &&
+			   lanes != 1) {
+			fw_speed = BNXT_LINK_SPEED_100GB_PAM4;
+			sig_mode = BNXT_SIG_MODE_PAM4;
+			lanes_needed = 2;
+		} else if (support_spds2 & BNXT_LINK_SPEEDS2_MSK_100GB_PAM4_112) {
+			fw_speed = BNXT_LINK_SPEED_100GB_PAM4_112;
+			sig_mode = BNXT_SIG_MODE_PAM4_112;
 		}
 		break;
 	case SPEED_200000:
@@ -2191,6 +2210,27 @@ bnxt_force_link_speed(struct net_device *dev, u32 ethtool_speed, u32 lanes)
 			fw_speed = PORT_PHY_CFG_REQ_FORCE_PAM4_LINK_SPEED_200GB;
 			sig_mode = BNXT_SIG_MODE_PAM4;
 			lanes_needed = 4;
+		} else if ((support_spds2 & BNXT_LINK_SPEEDS2_MSK_200GB_PAM4) &&
+			   lanes != 2) {
+			fw_speed = BNXT_LINK_SPEED_200GB_PAM4;
+			sig_mode = BNXT_SIG_MODE_PAM4;
+			lanes_needed = 4;
+		} else if (support_spds2 & BNXT_LINK_SPEEDS2_MSK_200GB_PAM4_112) {
+			fw_speed = BNXT_LINK_SPEED_200GB_PAM4_112;
+			sig_mode = BNXT_SIG_MODE_PAM4_112;
+			lanes_needed = 2;
+		}
+		break;
+	case SPEED_400000:
+		if ((support_spds2 & BNXT_LINK_SPEEDS2_MSK_400GB_PAM4) &&
+		    lanes != 4) {
+			fw_speed = BNXT_LINK_SPEED_400GB_PAM4;
+			sig_mode = BNXT_SIG_MODE_PAM4;
+			lanes_needed = 8;
+		} else if (support_spds2 & BNXT_LINK_SPEEDS2_MSK_400GB_PAM4_112) {
+			fw_speed = BNXT_LINK_SPEED_400GB_PAM4_112;
+			sig_mode = BNXT_SIG_MODE_PAM4_112;
+			lanes_needed = 4;
 		}
 		break;
 	}
-- 
2.30.1


--000000000000332182060b7a7390
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN1ne92tpJNCCcF6aZOHLsVPeL8kWNi1
fmeLjaaxY+YPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyNDAwNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCfhsBLXtgrHQ/iC/JvlGF6dvLAIHUtkPbV8bvDFnmgSG9ghyHp
V4MeYNbBc3kDKa6kqibRwjGby56iWSZ7pZX+5QAfGWT2WRj9nc7HKzzzJmyHia+d3NNgLoiBsJH+
OOVuCjqwnxN8XMLYrI8fYpQTOJ7VL1TKgfDIhI7fu12OvZqTJNRa6u/w3Jw8iE/EPGrXaL5cLiBP
F9RcXX4nGCYpX23Dn3sZteMwH4dgmSXu21OSyJn7yeynWdqvmKt73Q69KKVii1ngWeVOdgT+IXBK
YIE6aGxcnMaO2hL+zZh9g8RO8pKS1LSqlOOLQq1Ws3bQGU6OK+g8gnjsRpmJsq/y
--000000000000332182060b7a7390--

