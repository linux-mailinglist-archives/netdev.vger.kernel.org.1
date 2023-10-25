Return-Path: <netdev+bounces-44226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1357D7262
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 19:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9621C20E29
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFCD30F86;
	Wed, 25 Oct 2023 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UqrUW0n4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367330F97
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 17:34:46 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2F18C
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 10:34:43 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7788f513872so2772785a.1
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 10:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1698255282; x=1698860082; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7lLc74iucfkSagTngo0w/CgNB4zg7uJtat26T1MBATc=;
        b=UqrUW0n4XTBWq5Yx5prN9SD8Z10GTN5s1rdSyZcwxQPV416fFxhoWpC/wxyaY015QK
         /78Up3W05yYeL09XtUw/Dpkm+yUiQRhmsn2rIz15jC4VDP2e11KBIsfOWNBxcz2c485K
         D85iWDfeUe4Zxi5UpSP+PgTj9zvnVgdIRQH9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255282; x=1698860082;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7lLc74iucfkSagTngo0w/CgNB4zg7uJtat26T1MBATc=;
        b=Ok+g355L0FzAbDOeBc2tovF4Mu0b2ML/oMiXW26US7PsJXv+N9C85zagTSa7eOSF72
         M7grEAdB55gI55Lm2YiChkna3BqFHD5Yo1lNwMsGHHv69V0SC5FifAh8KrGJzkAk3Yag
         S9SLj8LR3eaYM64vywVQAn26mM9alJAcek6jqkA9l7i0UEomDKyaBHDhkJTXncyvBLR1
         BFiOjPU7gfS1aTSyLjqLM7+GpHmUQyjFq6i+o+VQu6VXoC3EGQdP6rZl8uMGxnERPzer
         aEMMneWQYgbahlRQBsNSI/54YxBgFaHWhOWecfVzWqJelDg1zHv8gCFyww+fRPCV9a3w
         OssQ==
X-Gm-Message-State: AOJu0Yxc0V6+CLkvjFL0lOrKYXJGpd52sk70meuEC1F6agl4s35rydFf
	pRlFgTMB2YxjAyb1RIaeOEHTeaUh3RuSPfoXreMEMXg5KLxP0XwCyWQC6R3vefmA+6rmU4HXmrd
	v/IokuIwRcx5GcMp/a5KbCf18lXwu8STTGWnwPzCqUG4ph6QJPhlr15KZYHvrQ9t2qtjpFabvEq
	2fs8AmGcYWW1H1
X-Google-Smtp-Source: AGHT+IER/THKzyidQcAgA/umHbCwsV/um2ZoKrQMP+KKtFbJj+HpP1SXBEAn7Gsby6nW7J7QiBr+/A==
X-Received: by 2002:a05:620a:410c:b0:767:f1de:293c with SMTP id j12-20020a05620a410c00b00767f1de293cmr16749409qko.59.1698255282064;
        Wed, 25 Oct 2023 10:34:42 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id bp37-20020a05620a45a500b00767dcf6f4adsm4332384qkb.51.2023.10.25.10.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 10:34:41 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Simon Horman <horms@kernel.org>,
	Justin Chen <justin.chen@broadcom.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Joe Damato <jdamato@fastly.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 3/5] net: phy: Add pluming for ethtool_{get,set}_rxnfc
Date: Wed, 25 Oct 2023 10:32:58 -0700
Message-Id: <20231025173300.1776832-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
References: <20231025173300.1776832-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000db917a06088ddee7"

--000000000000db917a06088ddee7
Content-Transfer-Encoding: 8bit

Ethernet MAC drivers supporting Wake-on-LAN using programmable filters
(WAKE_FILTER) typically configure such programmable filters using the
ethtool::set_rxnfc API and with a sepcial RX_CLS_FLOW_WAKE to indicate
the filter is also wake-up capable.

In order to offer the same functionality for capable Ethernet PHY
drivers, wire-up the ethtool::{get,set}_rxnfc APIs within the PHY
library.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/phy.c | 19 +++++++++++++++++++
 include/linux/phy.h   |  8 ++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index a5fa077650e8..e2f2cc38ff31 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1740,3 +1740,22 @@ int phy_ethtool_nway_reset(struct net_device *ndev)
 	return ret;
 }
 EXPORT_SYMBOL(phy_ethtool_nway_reset);
+
+int phy_ethtool_get_rxnfc(struct phy_device *phydev,
+			  struct ethtool_rxnfc *nfc, u32 *rule_locs)
+{
+	if (phydev->drv && phydev->drv->get_rxnfc)
+		return phydev->drv->get_rxnfc(phydev, nfc, rule_locs);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(phy_ethtool_get_rxnfc);
+
+int phy_ethtool_set_rxnfc(struct phy_device *phydev, struct ethtool_rxnfc *nfc)
+{
+	if (phydev->drv && phydev->drv->set_rxnfc)
+		return phydev->drv->set_rxnfc(phydev, nfc);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(phy_ethtool_set_rxnfc);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3cc52826f18e..03e7c6352aef 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1077,6 +1077,10 @@ struct phy_driver {
 	int (*get_sqi)(struct phy_device *dev);
 	/** @get_sqi_max: Get the maximum signal quality indication */
 	int (*get_sqi_max)(struct phy_device *dev);
+	/* Used for WAKE_FILTER programming only */
+	int (*get_rxnfc)(struct phy_device *dev,
+			 struct ethtool_rxnfc *nfc, u32 *rule_locs);
+	int (*set_rxnfc)(struct phy_device *dev, struct ethtool_rxnfc *nfc);
 
 	/* PLCA RS interface */
 	/** @get_plca_cfg: Return the current PLCA configuration */
@@ -1989,6 +1993,10 @@ int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
 			     struct netlink_ext_ack *extack);
 int phy_ethtool_get_plca_status(struct phy_device *phydev,
 				struct phy_plca_status *plca_st);
+int phy_ethtool_get_rxnfc(struct phy_device *phydev,
+			  struct ethtool_rxnfc *nfc, u32 *rule_locs);
+int phy_ethtool_set_rxnfc(struct phy_device *phydev,
+			  struct ethtool_rxnfc *nfc);
 
 int __phy_hwtstamp_get(struct phy_device *phydev,
 		       struct kernel_hwtstamp_config *config);
-- 
2.34.1


--000000000000db917a06088ddee7
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFq4DqNGgCW1Pvxe
JvBdn2YMihqXn7e+rZsCmFuFH05kMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMTAyNTE3MzQ0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA5EPZ3onfpCikCw+NtXXrljBcGQmtHJFiM
xtM5c6WmlMuM940BVQsM7rnDgxET0+GZ1QuPciKHJue/lXFWMdPzhuvrtSjVrriQFNBxLdrShRmT
Kq2zKuUGysSz8gqRmLDCZaeHKFdY0q2Of3kf7+yCn6nrTXdNVHpwTNdcMhKqYgu01EF9xed8ff5j
qZ6eQ/4kPXNYki//XHqtAI9RGKuknMeHRt10V3WzI1sZJUd1WDvd86kmKDK4CHWMlHwz/Af5L12e
TFFxPhPFtsgfGTDw/8q7AQJYxFZz3ZfFm4A0Y3QgDkjsH8Cgg7Bfvh+SxNbGbDEO7fcWdKcbHC+c
q2mv
--000000000000db917a06088ddee7--

