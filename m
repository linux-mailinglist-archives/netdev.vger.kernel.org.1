Return-Path: <netdev+bounces-43134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA0A7D1811
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D21C210CA
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBB132185;
	Fri, 20 Oct 2023 21:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VPc2nKpZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30092FE0E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:28:23 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32B3D6D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5ab2cb900fcso889293a12.0
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697837298; x=1698442098; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BMM08PPpP8N9Xwt7rJplYIgdnHpvZjXmQjWULq++WWM=;
        b=VPc2nKpZla/TnttO2lrZeGt2XO1tgyY/Et7aqZri2+Eg1XYpoY+DGkJGy/pBjFXcGI
         7A2EtynTgQhrldbBNCEsVBnQoOrMd8jL8CkVho6KHJx4gvG2+No1PH2RMz3cT1HZJ0Ee
         k2bFtOIzD80y7OOsu2LLuorRQukaLfdGOMTOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697837298; x=1698442098;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BMM08PPpP8N9Xwt7rJplYIgdnHpvZjXmQjWULq++WWM=;
        b=Ns/CUhf0eWiidIwNix6Fh5V4htZG/1OnbIeAz7tm9qr1VPvt2ZVJuYLl7jjG6+VJrh
         dH3c8p02djPC13f/o3+BkxOmkbWIlKTjgLGczp6WmU2H2+tVmsGCY+5baFyVFV/6ZXwg
         ahVQRMqznKreJ0OuDMPBYZ/7rLvrT3vFqJc41jJ/8/b1zlRIFLW+No0p3pK4Ts6zXS6N
         ijH3DM6WPXEH5FJSoUQ3S9JD/4D72jAjjh8xmMMijkM8zTtK9lE3+4EzNego/k16XpxP
         SQMr8zAMS1l1j9wA++VrmFivZTCRhfK/fkW1p012oZ1ySwviia9iHZvJrHA4AS39IPtX
         Cjkw==
X-Gm-Message-State: AOJu0YyOgEmPp5dPIbkGD0rqf6d0TDMJhIP9HtpX4Kw8w8VSvF5jtNKy
	dXic7gV7/p7jiRAws75m9g9uyw==
X-Google-Smtp-Source: AGHT+IFz46Qha3XB6Sh74avHl0uKnL4xZ5pQGlyGWLzmK6zSf/v68/a1V0moddCjJosEfrM3qnsH6A==
X-Received: by 2002:a17:90b:2ec7:b0:27d:2ad2:4d9c with SMTP id ss7-20020a17090b2ec700b0027d2ad24d9cmr2802322pjb.35.1697837298003;
        Fri, 20 Oct 2023 14:28:18 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a7e8d00b0026d4100e0e8sm1843348pjl.10.2023.10.20.14.28.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2023 14:28:17 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [PATCH net-next 7/8] bnxt_en: convert to linkmode_set_bit() API
Date: Fri, 20 Oct 2023 14:27:56 -0700
Message-Id: <20231020212757.173551-8-michael.chan@broadcom.com>
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
	boundary="0000000000000fd6d806082c8dcf"

--0000000000000fd6d806082c8dcf
Content-Transfer-Encoding: 8bit

From: Edwin Peer <edwin.peer@broadcom.com>

Barring the BNXT_FW_TO_ETHTOOL speed macros, which will be removed
in the next patch, update code to use the newer API.

No functional change.

Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 48 +++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 98a767becd0d..c72dfa0708e5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1816,31 +1816,31 @@ static void bnxt_get_ethtool_modes(struct bnxt_link_info *link_info,
 	struct bnxt *bp = container_of(link_info, struct bnxt, link_info);
 
 	if (!(bp->phy_flags & BNXT_PHY_FL_NO_PAUSE)) {
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     Pause);
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     Asym_Pause);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 lk_ksettings->link_modes.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 lk_ksettings->link_modes.supported);
 	}
 
 	if (link_info->support_auto_speeds || link_info->support_pam4_auto_speeds)
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     Autoneg);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 lk_ksettings->link_modes.supported);
 
 	if (~link_info->autoneg & BNXT_AUTONEG_FLOW_CTRL)
 		return;
 
 	if (link_info->auto_pause_setting & BNXT_LINK_PAUSE_RX)
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, advertising,
-						     Pause);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 lk_ksettings->link_modes.advertising);
 	if (hweight8(link_info->auto_pause_setting & BNXT_LINK_PAUSE_BOTH) == 1)
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, advertising,
-						     Asym_Pause);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 lk_ksettings->link_modes.advertising);
 	if (link_info->lp_pause & BNXT_LINK_PAUSE_RX)
-		ethtool_link_ksettings_add_link_mode(lk_ksettings,
-						     lp_advertising, Pause);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 lk_ksettings->link_modes.lp_advertising);
 	if (hweight8(link_info->lp_pause & BNXT_LINK_PAUSE_BOTH) == 1)
-		ethtool_link_ksettings_add_link_mode(lk_ksettings,
-						     lp_advertising, Asym_Pause);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 lk_ksettings->link_modes.lp_advertising);
 }
 
 static void bnxt_fw_to_ethtool_advertised_fec(struct bnxt_link_info *link_info,
@@ -1988,8 +1988,8 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	if (link_info->autoneg) {
 		bnxt_fw_to_ethtool_advertised_spds(link_info, lk_ksettings);
 		bnxt_fw_to_ethtool_advertised_fec(link_info, lk_ksettings);
-		ethtool_link_ksettings_add_link_mode(lk_ksettings,
-						     advertising, Autoneg);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 lk_ksettings->link_modes.advertising);
 		base->autoneg = AUTONEG_ENABLE;
 		if (link_info->phy_link_status == BNXT_LINK_LINK)
 			bnxt_fw_to_ethtool_lp_adv(link_info, lk_ksettings);
@@ -2000,15 +2000,15 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 	base->port = PORT_NONE;
 	if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP) {
 		base->port = PORT_TP;
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     TP);
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, advertising,
-						     TP);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
+				 lk_ksettings->link_modes.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
+				 lk_ksettings->link_modes.advertising);
 	} else {
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, supported,
-						     FIBRE);
-		ethtool_link_ksettings_add_link_mode(lk_ksettings, advertising,
-						     FIBRE);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+				 lk_ksettings->link_modes.supported);
+		linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT,
+				 lk_ksettings->link_modes.advertising);
 
 		if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC)
 			base->port = PORT_DA;
-- 
2.30.1


--0000000000000fd6d806082c8dcf
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICZs3V357c9ukmi6qDUr2utdL6yo9WK5
mervYufZYUByMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
MDIxMjgxOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAmPk2gtyFiCHaL3xozz3/F5GuiKfhJOuxL72QZgaXkbRtWIrIs
6DppouNuXG5l2MrCaL63V4iqhRauvb4dyja5q85dYiyFbyyDacGhSYIMyAcgiGwmlbCPAV7Sl2tg
BkiA9rEDVutAGFwN/sLogdE1Q89p+e1AD4nvXXRGv+P+03Kk5pUkGGP48dUZjuoOa1VUFTWfLQIr
PD1+PY1Hl/99hyFyNGuy2Dgyyc2Gt4qesXOaQVa8TtuWoS8ZX6rhpF01sHfFLUovJr6g1+UKsndF
LFB6QUiAtAFXzxnw7eOLB82cU9jddLUTBuiQlrzOB5B5tHv4ML+N4q05tEYDSwI/
--0000000000000fd6d806082c8dcf--

