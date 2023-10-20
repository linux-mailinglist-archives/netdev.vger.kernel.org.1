Return-Path: <netdev+bounces-43133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D147D1810
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CC61C21031
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247002B749;
	Fri, 20 Oct 2023 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nb8Eu2HC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA12FE09
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:28:23 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F11D68
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5a9bf4fbd3fso934713a12.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697837296; x=1698442096; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TjTk5x/BMqIltJXEN+AOADHZlZUg3zOJJYeLJ4J4OpY=;
        b=Nb8Eu2HChxrA6wOeJ7I94Oes8CxFOGOnvvt8xfkYA+gx6cfez10QDY74oxT4v3KTdN
         748z3PfV9I5W7//4Zv58ZRsUpJcgXJaldSegPSHXTv3kn3BlQpxMDV7zCUJ2IykgG4+m
         5WuSZt9F3XuzWHiETX/oz/fRMM2s6IHWY/lkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697837296; x=1698442096;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjTk5x/BMqIltJXEN+AOADHZlZUg3zOJJYeLJ4J4OpY=;
        b=aMCjH8KkkXPE22F+RQJHjiEaEUYAlatfbYUTDxF57qIbknlLo7fbtEYPQSKdsOkntp
         3HcxsUbagmgJQusuf1qlCpkUd9p79BH+8KwMq0V3GZE5Qk4vUHmL8ItDK6xsGUJ8Uv+f
         lgsR7omzMbYy8+J5nAH2EMm7CFJxdRwuk3VhT9zRbZarvsRG2DREl9TrKYdoVaENFvbe
         icwEq1/Dj/VBlVrvijJ9bMyHiwPWgVEQrZZ8n7tzKt9wx1xk+zqgsDATxPZuK1lPRb+3
         iSHRKbMyYRvGagijw2o8rSU7C4z9sIjDrPTWfyZbzTw/0x5Aoq9wOASm0SUAp2t94hVQ
         akTg==
X-Gm-Message-State: AOJu0YxEe+kVm/23c53y1ZM3PlCW0IdccgMus1JexRui5rXCYHCG8IgX
	q/3yaDy9ZzTBcUuDki/jOCnwyA==
X-Google-Smtp-Source: AGHT+IHEk8F2bAy2kWj8gYpd7i6aoc0i/OUmIKASpDsi/LJan3q1UUaC/PmnCieP8Tm2DKPnOEN6Mg==
X-Received: by 2002:a17:90b:35c4:b0:27c:f48e:e245 with SMTP id nb4-20020a17090b35c400b0027cf48ee245mr3094844pjb.24.1697837295463;
        Fri, 20 Oct 2023 14:28:15 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a7e8d00b0026d4100e0e8sm1843348pjl.10.2023.10.20.14.28.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2023 14:28:15 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [PATCH net-next 5/8] bnxt_en: refactor speed independent ethtool modes
Date: Fri, 20 Oct 2023 14:27:54 -0700
Message-Id: <20231020212757.173551-6-michael.chan@broadcom.com>
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
	boundary="000000000000ec953806082c8ccd"

--000000000000ec953806082c8ccd
Content-Transfer-Encoding: 8bit

From: Edwin Peer <edwin.peer@broadcom.com>

A future patch in this series will change the algorithm used to
determine ethtool speed and media modes. Extract the handling of
the unrelated pause, autoneg modes into an independent function.
Also separate FEC handling out of bnxt_fw_to_ethtool_*_spds().

No functional change.

Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 78 ++++++++++---------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 19b0bff9c590..98a767becd0d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1730,7 +1730,7 @@ bnxt_get_link_mode(struct bnxt_link_info *link_info)
 	return link_mode;
 }
 
-#define BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, fw_pause, lk_ksettings, name)\
+#define BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, lk_ksettings, name)		\
 {									\
 	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_100MB)			\
 		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
@@ -1753,16 +1753,6 @@ bnxt_get_link_mode(struct bnxt_link_info *link_info)
 	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_100GB)			\
 		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
 						     100000baseCR4_Full);\
-	if ((fw_pause) & BNXT_LINK_PAUSE_RX) {				\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     Pause);		\
-		if (!((fw_pause) & BNXT_LINK_PAUSE_TX))			\
-			ethtool_link_ksettings_add_link_mode(		\
-					lk_ksettings, name, Asym_Pause);\
-	} else if ((fw_pause) & BNXT_LINK_PAUSE_TX) {			\
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, name,\
-						     Asym_Pause);	\
-	}								\
 }
 
 #define BNXT_ETHTOOL_TO_FW_SPDS(fw_speeds, lk_ksettings, name)		\
@@ -1820,6 +1810,39 @@ bnxt_get_link_mode(struct bnxt_link_info *link_info)
 		(fw_speeds) |= BNXT_LINK_PAM4_SPEED_MSK_200GB;		\
 }
 
+static void bnxt_get_ethtool_modes(struct bnxt_link_info *link_info,
+				   struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+
+	if (!(bp->phy_flags & BNXT_PHY_FL_NO_PAUSE)) {
+		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
+						     Pause);
+		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
+						     Asym_Pause);
+	}
+
+	if (link_info->support_auto_speeds || link_info->support_pam4_auto_speeds)
+		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
+						     Autoneg);
+
+	if (~link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL)
+		return;
+
+	if (link_info->auto_pause_setting & BNXT_LINK_PAUSE_RX)
+		ethtool_link_ksettings_add_link_mode(lk_ksettings, advertising,
+						     Pause);
+	if (hweight8(link_info->auto_pause_setting & BNXT_LINK_PAUSE_BOTH) == 1)
+		ethtool_link_ksettings_add_link_mode(lk_ksettings, advertising,
+						     Asym_Pause);
+	if (link_info->lp_pause & BNXT_LINK_PAUSE_RX)
+		ethtool_link_ksettings_add_link_mode(lk_ksettings,
+						     lp_advertising, Pause);
+	if (hweight8(link_info->lp_pause & BNXT_LINK_PAUSE_BOTH) == 1)
+		ethtool_link_ksettings_add_link_mode(lk_ksettings,
+						     lp_advertising, Asym_Pause);
+}
+
 static void bnxt_fw_to_ethtool_advertised_fec(struct bnxt_link_info *link_info,
 				struct ethtool_link_ksettings *lk_ksettings)
 {
@@ -1845,28 +1868,18 @@ static void bnxt_fw_to_ethtool_advertised_spds(struct bnxt_link_info *link_info,
 				struct ethtool_link_ksettings *lk_ksettings)
 {
 	u16 fw_speeds = link_info->advertising;
-	u8 fw_pause = 0;
 
-	if (link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL)
-		fw_pause = link_info->auto_pause_setting;
-
-	BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, fw_pause, lk_ksettings, advertising);
+	BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, lk_ksettings, advertising);
 	fw_speeds = link_info->advertising_pam4;
 	BNXT_FW_TO_ETHTOOL_PAM4_SPDS(fw_speeds, lk_ksettings, advertising);
-	bnxt_fw_to_ethtool_advertised_fec(link_info, lk_ksettings);
 }
 
 static void bnxt_fw_to_ethtool_lp_adv(struct bnxt_link_info *link_info,
 				struct ethtool_link_ksettings *lk_ksettings)
 {
 	u16 fw_speeds = link_info->lp_auto_link_speeds;
-	u8 fw_pause = 0;
-
-	if (link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL)
-		fw_pause = link_info->lp_pause;
 
-	BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, fw_pause, lk_ksettings,
-				lp_advertising);
+	BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, lk_ksettings, lp_advertising);
 	fw_speeds = link_info->lp_auto_pam4_link_speeds;
 	BNXT_FW_TO_ETHTOOL_PAM4_SPDS(fw_speeds, lk_ksettings, lp_advertising);
 }
@@ -1895,25 +1908,11 @@ static void bnxt_fw_to_ethtool_support_fec(struct bnxt_link_info *link_info,
 static void bnxt_fw_to_ethtool_support_spds(struct bnxt_link_info *link_info,
 				struct ethtool_link_ksettings *lk_ksettings)
 {
-	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
 	u16 fw_speeds = link_info->support_speeds;
 
-	BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, 0, lk_ksettings, supported);
+	BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, lk_ksettings, supported);
 	fw_speeds = link_info->support_pam4_speeds;
 	BNXT_FW_TO_ETHTOOL_PAM4_SPDS(fw_speeds, lk_ksettings, supported);
-
-	if (!(bp->phy_flags & BNXT_PHY_FL_NO_PAUSE)) {
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     Pause);
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     Asym_Pause);
-	}
-
-	if (link_info->support_auto_speeds ||
-	    link_info->support_pam4_auto_speeds)
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     Autoneg);
-	bnxt_fw_to_ethtool_support_fec(link_info, lk_ksettings);
 }
 
 u32 bnxt_fw_to_ethtool_speed(u16 fw_link_speed)
@@ -1977,7 +1976,9 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	link_info = &bp->link_info;
 
 	mutex_lock(&bp->link_lock);
+	bnxt_get_ethtool_modes(link_info, lk_ksettings);
 	bnxt_fw_to_ethtool_support_spds(link_info, lk_ksettings);
+	bnxt_fw_to_ethtool_support_fec(link_info, lk_ksettings);
 	link_mode = bnxt_get_link_mode(link_info);
 	if (link_mode != BNXT_LINK_MODE_UNKNOWN)
 		ethtool_params_from_link_mode(lk_ksettings, link_mode);
@@ -1986,6 +1987,7 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 
 	if (link_info->autoneg) {
 		bnxt_fw_to_ethtool_advertised_spds(link_info, lk_ksettings);
+		bnxt_fw_to_ethtool_advertised_fec(link_info, lk_ksettings);
 		ethtool_link_ksettings_add_link_mode(lk_ksettings,
 						     advertising, Autoneg);
 		base->autoneg = AUTONEG_ENABLE;
-- 
2.30.1


--000000000000ec953806082c8ccd
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIE7x2lk6EVx1Ingh5l8k+raBjoyJCIfZ
yjeSeyDRhUZLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
MDIxMjgxNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCYhzcpgOnW8mO3ATJFL6YA9Qe/hn+snZO0CTtQzVh69od32vsE
yjl5wYVWlkaQRWJ5FsJ+gjCs/3aoPJ7mnHynke/NInPneRz41driWwQWv8AXgX8lCcBqiKQ3TvO5
pjRcp2lJNvZIWDuKQXXRwIxQUflMgTTdg+D/NRGJtAp/XPvMyZvAB1qv1S4pSnZ+VENSYbHL/fJm
uc5einvSgnwOJTPah66RAukI2alX1zvhePiQtAI1fhGGq+9ZojSSoowqq+zK3hWLNX6BXVLOViu+
IdYQEc8BFrQmjed9gX9sVMePTRIX5aNlw6PrOfH/6iwKRq5fcYoTPu4QytamcQMq
--000000000000ec953806082c8ccd--

