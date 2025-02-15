Return-Path: <netdev+bounces-166665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31AEA36E79
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 14:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A91B16E6AF
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9911AB531;
	Sat, 15 Feb 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7GV2Gvg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9119E78F35
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739626124; cv=none; b=khHT7zO7WyTKcgpX6umA0590l51FyLkxnG9Bsi7wR2IEf7P5QiJr4xHyMdtTAlSXPdxP24+6ISjquSqhsUstX6uRhnCRE5Um1b3pj68g9g4NysLhkMUou8e5D0KUb5Rff6LJg+WRVhHSz5lXt0/hCzHs6Za2oOK1/zOGajf94mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739626124; c=relaxed/simple;
	bh=JBhVWmJ5uW83X8oaEnEEl5FZHWBrcDWRfm0wjb2kiBk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=AFnFuAGbqwSZNy6x3jfF5Wc/gBqjVQLj5TAW/QKe45j7UF+lZceZwdqVOnztE1/79aqFJ1dje1f3XHoD5PUZhiQJOdheCKfc2BJF8Yq8V+Ck0tEOlTgLewiBtlqIIKavhELoQD1iuzTpsofC64l/xZJqxNSSLhWJ+IWQGpz2b/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7GV2Gvg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4395f81db4dso17681155e9.1
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 05:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739626120; x=1740230920; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nl3xdzP4Xa8lo85o7sel2bCSOa9kdPd2hhZoEelKP8g=;
        b=N7GV2GvgA0qqCRvd6872dAHnPeN27kNYm3mPDy2/gUqQRRWSYezEZZ7iUhXtm26ekP
         QmGhAVOonjjD7U/VbAFnYMWRryr3/KGUN5fYEtwNSsDX7ga1CpdcpMfU0BQTe5NrAHvZ
         E0QgkhsU2HkNGMCJS2EEAMGUftcvYRifJGvS4ZvJrD4pIa8M4CVOGZ8Yb2zEQohu8fJf
         hlAvD4AmcOgQvs1ALqEpkN0kUYDM7xZolXn3c95nUwCSFFWtVD5vAFOPpV9dsKA9e160
         NG75ur7brguG6jQWCSFsah2Rh2DWzBrdFi3o80+rru6W5nQDAPaopKEdCsT1EWcutGA+
         MywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739626120; x=1740230920;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nl3xdzP4Xa8lo85o7sel2bCSOa9kdPd2hhZoEelKP8g=;
        b=KiSW4PHHUSV+L/8/OSWTOVT4stJZZ0RxRV7ERnFQn5DoQ4PhSJpBdKtXlT3HH5F5yP
         pHQ32ErZjKD3jjdNXpqc12OPCXQ5SXP5v/9DTv1aTr+t3hBJMstOAj2+B0t2FX1kThrA
         N5U5DUBMjUc6W28TjmhyvrJ2Rf+HZc4PuDyasvJNGZjJa64wr0bqczJd0YQboTZO/fuT
         qrHBBQwdoDRB6tWLzss+jb1G+03tpiT4Xj4Nw7+k2x5PrUf+Xfv/bz5Tqt4gZaAtAQoU
         BpEZps94SyFq5Od7wOize6ca3kqwpX+ESeAC9GtmazTA/mA/bqDRyteFCWBxU/9vFonv
         4TJg==
X-Gm-Message-State: AOJu0YzPxHyLWm2eBIw+0gfRNt8Y6o1fGb8UXi7rcnjafS65NcPAp6bu
	0P8uZ6zYnYTVGc7kV3jZlm23ENJeKFFla6VMrv1c1mXZf+weed+voU1ha2Py
X-Gm-Gg: ASbGncsMB99MStO9BDINZZmVJNqBsTOJLOomHoIqo8Az/1BhH5DxkAdjp0IcUp5aGUT
	Ba6UCuSCo6GsUQETIxgsct+jT2z3E12W/859W3/Ll2fdpb8di4lrL/bqqA0g6L1vM/B3SiENFan
	qUZ1eQ+EUuR1SGKQN5KzBAesJf11aR5jZA/Xd1q1FJtViN5fazLdsW05oT70OnasnC5c/8gjXQs
	NYpuR71nXAsXHvyww9EaDupAJoQLXHWsF909VKeMNk4CSzJG+qihrWsJjfZEuTAWBfraHqKbYFf
	Np6/oJENWTAh7weRGosQlSe2vD1VEk+D1K+VyJPc8kABjpT+r9aQhOEaaOUa9umTX6TpJ/oe/ih
	XVzrVKQFtBG1m1A9opH0OTO4hKn1T5g5t+gYjpPb5yd95UY2M9GabZc/xq94Q8p+vsjpnCTP87k
	oSzG6u0Us=
X-Google-Smtp-Source: AGHT+IE1OM+4WXyBMeUkNfTMljQwDqE9CTJ4HK8padu/OBCNIdasCqaSVzS9iLFlgpyBbmWiJfbCYA==
X-Received: by 2002:a05:600c:154a:b0:439:3159:c33d with SMTP id 5b1f17b1804b1-4396ec871bbmr36923965e9.13.1739626119520;
        Sat, 15 Feb 2025 05:28:39 -0800 (PST)
Received: from ?IPV6:2a02:3100:b3f6:5100:59d9:7e3c:e758:189b? (dynamic-2a02-3100-b3f6-5100-59d9-7e3c-e758-189b.310.pool.telefonica.de. [2a02:3100:b3f6:5100:59d9:7e3c:e758:189b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8397sm101217015e9.36.2025.02.15.05.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 05:28:38 -0800 (PST)
Message-ID: <c90bdf76-f8b8-4d06-9656-7a52d5658ee6@gmail.com>
Date: Sat, 15 Feb 2025 14:29:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: realtek: add defines for shadowed c45
 standard registers
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Realtek shadows standard c45 registers in VEND2 device register space.
Add defines for these VEND2 registers, based on the names of the
standard c45 registers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 33 +++++++++++++++++---------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 34be1d752..e137e9942 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -96,6 +96,16 @@
 #define RTL_VND2_PHYSR_MASTER			BIT(11)
 #define RTL_VND2_PHYSR_SPEED_MASK		(RTL_VND2_PHYSR_SPEEDL | RTL_VND2_PHYSR_SPEEDH)
 
+#define	RTL_MDIO_PCS_EEE_ABLE			0xa5c4
+#define	RTL_MDIO_AN_EEE_ADV			0xa5d0
+#define	RTL_MDIO_AN_EEE_LPABLE			0xa5d2
+#define	RTL_MDIO_AN_10GBT_CTRL			0xa5d4
+#define	RTL_MDIO_AN_10GBT_STAT			0xa5d6
+#define	RTL_MDIO_PMA_SPEED			0xa616
+#define	RTL_MDIO_AN_EEE_LPABLE2			0xa6d0
+#define	RTL_MDIO_AN_EEE_ADV2			0xa6d4
+#define	RTL_MDIO_PCS_EEE_ABLE2			0xa6ec
+
 #define RTL_GENERIC_PHYID			0x001cc800
 #define RTL_8211FVD_PHYID			0x001cc878
 #define RTL_8221B				0x001cc840
@@ -753,11 +763,11 @@ static int rtlgen_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
 	if (devnum == MDIO_MMD_VEND2)
 		ret = rtlgen_read_vend2(phydev, regnum);
 	else if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE)
-		ret = rtlgen_read_vend2(phydev, 0xa5c4);
+		ret = rtlgen_read_vend2(phydev, RTL_MDIO_PCS_EEE_ABLE);
 	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV)
-		ret = rtlgen_read_vend2(phydev, 0xa5d0);
+		ret = rtlgen_read_vend2(phydev, RTL_MDIO_AN_EEE_ADV);
 	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_LPABLE)
-		ret = rtlgen_read_vend2(phydev, 0xa5d2);
+		ret = rtlgen_read_vend2(phydev, RTL_MDIO_AN_EEE_LPABLE);
 	else
 		ret = -EOPNOTSUPP;
 
@@ -772,7 +782,7 @@ static int rtlgen_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	if (devnum == MDIO_MMD_VEND2)
 		ret = rtlgen_write_vend2(phydev, regnum, val);
 	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV)
-		ret = rtlgen_write_vend2(phydev, regnum, 0xa5d0);
+		ret = rtlgen_write_vend2(phydev, regnum, RTL_MDIO_AN_EEE_ADV);
 	else
 		ret = -EOPNOTSUPP;
 
@@ -787,11 +797,11 @@ static int rtl822x_read_mmd(struct phy_device *phydev, int devnum, u16 regnum)
 		return ret;
 
 	if (devnum == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE2)
-		ret = rtlgen_read_vend2(phydev, 0xa6ec);
+		ret = rtlgen_read_vend2(phydev, RTL_MDIO_PCS_EEE_ABLE2);
 	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV2)
-		ret = rtlgen_read_vend2(phydev, 0xa6d4);
+		ret = rtlgen_read_vend2(phydev, RTL_MDIO_AN_EEE_ADV2);
 	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_LPABLE2)
-		ret = rtlgen_read_vend2(phydev, 0xa6d0);
+		ret = rtlgen_read_vend2(phydev, RTL_MDIO_AN_EEE_LPABLE2);
 
 	return ret;
 }
@@ -805,7 +815,7 @@ static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 		return ret;
 
 	if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV2)
-		ret = rtlgen_write_vend2(phydev, 0xa6d4, val);
+		ret = rtlgen_write_vend2(phydev, RTL_MDIO_AN_EEE_ADV2, val);
 
 	return ret;
 }
@@ -901,7 +911,7 @@ static int rtl822x_get_features(struct phy_device *phydev)
 {
 	int val;
 
-	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xa616);
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL_MDIO_PMA_SPEED);
 	if (val < 0)
 		return val;
 
@@ -922,7 +932,8 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 	if (phydev->autoneg == AUTONEG_ENABLE) {
 		u16 adv = linkmode_adv_to_mii_10gbt_adv_t(phydev->advertising);
 
-		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2, 0xa5d4,
+		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
+					     RTL_MDIO_AN_10GBT_CTRL,
 					     MDIO_AN_10GBT_CTRL_ADV2_5G |
 					     MDIO_AN_10GBT_CTRL_ADV5G, adv);
 		if (ret < 0)
@@ -968,7 +979,7 @@ static int rtl822x_read_status(struct phy_device *phydev)
 	    !phydev->autoneg_complete)
 		return 0;
 
-	lpadv = phy_read_mmd(phydev, MDIO_MMD_VEND2, 0xa5d6);
+	lpadv = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL_MDIO_AN_10GBT_STAT);
 	if (lpadv < 0)
 		return lpadv;
 
-- 
2.48.1


