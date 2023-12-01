Return-Path: <netdev+bounces-53128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6367D8016A9
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A181C20C77
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7758E59B6B;
	Fri,  1 Dec 2023 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B+hUVeaS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEC7AD
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:40:04 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a44ee7ab3so16461176d6.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470403; x=1702075203; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDfI0qETOyOwee4a05idwPbHSr3fDqaCzwRXHLLk0WU=;
        b=B+hUVeaSMGMF7a2tRN/AMzTb4ZcqeEcjgQYf8wVtuB8U7E1h3+u3/nhkeN7AzTELXK
         rEwFhg6IELZ7Rb6BTRz6Yk19s/HNV0NXNaO4CUawHJVrMV+7Y746bnSDnL8rMoflKan9
         TiwWq6kNcHXeE3yG9PPqbgqaWfwCygveJlQ0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470403; x=1702075203;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mDfI0qETOyOwee4a05idwPbHSr3fDqaCzwRXHLLk0WU=;
        b=Z98JSXNfz6YhBYjtpiuRhV+GCCMiCXpsEhS8iRKzFTLNlr04XktWVkad5F+WpcHqmn
         LDI/ZwwkLsEQNg3JCEfYIdvk/iKh8Yoh6DxYzrVqHE9ZWAa/VFnDrttoGf/dVqr1QjYm
         na/D9ZE34TNTks7BT4oVL7szKoLq4PFjdZ2PICbNfLJ2vR7Q1yfK8gIDIAYvNV/j8DIl
         Ty/mT5O10VNva1Hce5+Y1g2+WoOt26MhiMbYYMKMAdhm34J/KfaLofH2uj8RW4+3xmpM
         Mk4Cd1JiH84eWHDDo10U/0JRIqYAByrBjcaJaZLEjDchX7ED/LHTT4lRk4tn7WHbc7JO
         WgEQ==
X-Gm-Message-State: AOJu0YzF8iylz2lD6SV7X/nGro+wUI+fizg5AM3hQ25eqmbXRTaBkfV4
	SkStKUMs0ik+3tXDFpPqab07cg==
X-Google-Smtp-Source: AGHT+IErXjB2JXLKtyeDv/0mDdZdk1rjLTVDrl5RjbVjVdlSazHwcHO6mbGhH5DnYgcXPYkbjxemCA==
X-Received: by 2002:a05:6214:564d:b0:67a:a721:f304 with SMTP id mh13-20020a056214564d00b0067aa721f304mr295479qvb.68.1701470403120;
        Fri, 01 Dec 2023 14:40:03 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.40.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:40:02 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next 11/15] bnxt_en: Refactor ethtool speeds logic
Date: Fri,  1 Dec 2023 14:39:20 -0800
Message-Id: <20231201223924.26955-12-michael.chan@broadcom.com>
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
	boundary="00000000000000e0d8060b7a7390"

--00000000000000e0d8060b7a7390
Content-Transfer-Encoding: 8bit

Add helper functions to refactor the logic that converts firmware
speed masks to ethtool speeds.  Pass the phy_flags to
bnxt_get_ethtool_speeds() and the call chain.  The refactoring and the
phy_flags will be needed when adding support for the new speeds in the
next patches.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 87 +++++++++++++------
 1 file changed, 61 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index ad0b93682771..a9b6141337d4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1801,7 +1801,7 @@ static const u16 bnxt_pam4_speed_masks[] = {
 };
 
 static enum bnxt_link_speed_indices
-bnxt_encoding_speed_idx(u8 sig_mode, u16 speed_msk)
+bnxt_encoding_speed_idx(u8 sig_mode, u16 phy_flags, u16 speed_msk)
 {
 	const u16 *speeds;
 	int idx, len;
@@ -1831,14 +1831,14 @@ bnxt_encoding_speed_idx(u8 sig_mode, u16 speed_msk)
 
 static void
 __bnxt_get_ethtool_speeds(unsigned long fw_mask, enum bnxt_media_type media,
-			  u8 sig_mode, unsigned long *et_mask)
+			  u8 sig_mode, u16 phy_flags, unsigned long *et_mask)
 {
 	enum ethtool_link_mode_bit_indices link_mode;
 	enum bnxt_link_speed_indices speed;
 	u8 bit;
 
 	for_each_set_bit(bit, &fw_mask, BNXT_FW_SPEED_MSK_BITS) {
-		speed = bnxt_encoding_speed_idx(sig_mode, 1 << bit);
+		speed = bnxt_encoding_speed_idx(sig_mode, phy_flags, 1 << bit);
 		if (!speed)
 			continue;
 
@@ -1852,16 +1852,66 @@ __bnxt_get_ethtool_speeds(unsigned long fw_mask, enum bnxt_media_type media,
 
 static void
 bnxt_get_ethtool_speeds(unsigned long fw_mask, enum bnxt_media_type media,
-			u8 sig_mode, unsigned long *et_mask)
+			u8 sig_mode, u16 phy_flags, unsigned long *et_mask)
 {
 	if (media) {
-		__bnxt_get_ethtool_speeds(fw_mask, media, sig_mode, et_mask);
+		__bnxt_get_ethtool_speeds(fw_mask, media, sig_mode, phy_flags,
+					  et_mask);
 		return;
 	}
 
 	/* list speeds for all media if unknown */
 	for (media = 1; media < __BNXT_MEDIA_END; media++)
-		__bnxt_get_ethtool_speeds(fw_mask, media, sig_mode, et_mask);
+		__bnxt_get_ethtool_speeds(fw_mask, media, sig_mode, phy_flags,
+					  et_mask);
+}
+
+static void
+bnxt_get_all_ethtool_support_speeds(struct bnxt_link_info *link_info,
+				    enum bnxt_media_type media,
+				    struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+	u16 phy_flags = bp->phy_flags;
+
+	bnxt_get_ethtool_speeds(link_info->support_speeds, media,
+				BNXT_SIG_MODE_NRZ, phy_flags,
+				lk_ksettings->link_modes.supported);
+	bnxt_get_ethtool_speeds(link_info->support_pam4_speeds, media,
+				BNXT_SIG_MODE_PAM4, phy_flags,
+				lk_ksettings->link_modes.supported);
+}
+
+static void
+bnxt_get_all_ethtool_adv_speeds(struct bnxt_link_info *link_info,
+				enum bnxt_media_type media,
+				struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+	u16 phy_flags = bp->phy_flags;
+
+	bnxt_get_ethtool_speeds(link_info->advertising, media,
+				BNXT_SIG_MODE_NRZ, phy_flags,
+				lk_ksettings->link_modes.advertising);
+	bnxt_get_ethtool_speeds(link_info->advertising_pam4, media,
+				BNXT_SIG_MODE_PAM4, phy_flags,
+				lk_ksettings->link_modes.advertising);
+}
+
+static void
+bnxt_get_all_ethtool_lp_speeds(struct bnxt_link_info *link_info,
+			       enum bnxt_media_type media,
+			       struct ethtool_link_ksettings *lk_ksettings)
+{
+	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
+	u16 phy_flags = bp->phy_flags;
+
+	bnxt_get_ethtool_speeds(link_info->lp_auto_link_speeds, media,
+				BNXT_SIG_MODE_NRZ, phy_flags,
+				lk_ksettings->link_modes.lp_advertising);
+	bnxt_get_ethtool_speeds(link_info->lp_auto_pam4_link_speeds, media,
+				BNXT_SIG_MODE_PAM4, phy_flags,
+				lk_ksettings->link_modes.lp_advertising);
 }
 
 static void bnxt_update_speed(u32 *delta, bool installed_media, u16 *speeds,
@@ -2017,12 +2067,7 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	mutex_lock(&bp->link_lock);
 	bnxt_get_ethtool_modes(link_info, lk_ksettings);
 	media = bnxt_get_media(link_info);
-	bnxt_get_ethtool_speeds(link_info->support_speeds,
-				media, BNXT_SIG_MODE_NRZ,
-				lk_ksettings->link_modes.supported);
-	bnxt_get_ethtool_speeds(link_info->support_pam4_speeds,
-				media, BNXT_SIG_MODE_PAM4,
-				lk_ksettings->link_modes.supported);
+	bnxt_get_all_ethtool_support_speeds(link_info, media, lk_ksettings);
 	bnxt_fw_to_ethtool_support_fec(link_info, lk_ksettings);
 	link_mode = bnxt_get_link_mode(link_info);
 	if (link_mode != BNXT_LINK_MODE_UNKNOWN)
@@ -2035,20 +2080,10 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 				 lk_ksettings->link_modes.advertising);
 		base->autoneg = AUTONEG_ENABLE;
-		bnxt_get_ethtool_speeds(link_info->advertising,
-					media, BNXT_SIG_MODE_NRZ,
-					lk_ksettings->link_modes.advertising);
-		bnxt_get_ethtool_speeds(link_info->advertising_pam4,
-					media, BNXT_SIG_MODE_PAM4,
-					lk_ksettings->link_modes.advertising);
-		if (link_info->phy_link_status == BNXT_LINK_LINK) {
-			bnxt_get_ethtool_speeds(link_info->lp_auto_link_speeds,
-						media, BNXT_SIG_MODE_NRZ,
-						lk_ksettings->link_modes.lp_advertising);
-			bnxt_get_ethtool_speeds(link_info->lp_auto_pam4_link_speeds,
-						media, BNXT_SIG_MODE_PAM4,
-						lk_ksettings->link_modes.lp_advertising);
-		}
+		bnxt_get_all_ethtool_adv_speeds(link_info, media, lk_ksettings);
+		if (link_info->phy_link_status == BNXT_LINK_LINK)
+			bnxt_get_all_ethtool_lp_speeds(link_info, media,
+						       lk_ksettings);
 	} else {
 		base->autoneg = AUTONEG_DISABLE;
 	}
-- 
2.30.1


--00000000000000e0d8060b7a7390
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEINHq9V7ZPSffpW3o+JJ2+eNMYVYWTXRz
1zMCq4/vePukMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyNDAwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCx8Pi8EWmR3FrEIWw+xTJwBEUrP+fsQruLQd/h9BWqAdNfiwA8
+mQHNemKCVclGKqUqxutenutpzqS/lUukyL5b4QpZ5GKOKV2+G4I+fDuh3yvm9c65OV20Z5HZ2lD
0Hs9Wy63YWY3R0Bxmgk24xVfMbXpLXwOvvddn78u1LUu7dtFX30gU8R+TdYooKD8hBdz6Q+3s8I0
z5lHqKQu/ePVwojKhhIQAsiZUrA5L9Hauq+3WduBwdG8DyQr0DzDefj4N1eRGJnX76xX07D75Npx
VbrSP4pVlRWHA6S5n6leUr+mKOZSOfWfL+r8IwTmB+sWotBwikqRoSfcQB6BxeVm
--00000000000000e0d8060b7a7390--

