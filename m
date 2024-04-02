Return-Path: <netdev+bounces-83890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5422E894AFE
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 07:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5CB51F23776
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 05:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7332C1863F;
	Tue,  2 Apr 2024 05:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pbo1Z0ds"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B8118050
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037541; cv=none; b=VVZxwfrripa2KP4t6w0iViq9KIoh+gjh3bhxFln0k1PIKVhnEXXAvVeoUGjj2UwBFeq/KNRTyBr3Tcy48pfiPzed+0cyXOhXaCFrMnsuKUo0oTl+sT69bFjLz7vlp5YlyqhNGjKDr/Ba3vfevRzbrGbDWmvmkVujWnMuFzsHp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037541; c=relaxed/simple;
	bh=Ampd6HQHcXxr9ZEFyFME+2325RtBlr/wpqtz3fXPUDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEiaf3ncCaEjX8b9RVTBfg9z8aDefsfYWBigSPrzxxyiaBsrPL8rTsQkXktNuIYGDKIhzBDnVwSc1V7CTU3WPVRT7jFNEkiEBuOnUw174K65/AcQ3ASneiGtHHQ24Q2Hfk6rryndF96HbAm0f6aEqhBSf48r20zKwRo/xmk03nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pbo1Z0ds; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56d5d4d2e2bso2613928a12.3
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 22:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712037538; x=1712642338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9V31exu69XJdwQKx28bPGGlT6S7Qasz8QRl4Vw0vQQ=;
        b=Pbo1Z0dsWsWNwGIGnJbqhrXpbYy0ZNDQOxk17CMe+rMmhq2GW8XiPuQMqj5smzedxT
         EzcUhfjRaSGpVi0uuVXczsuFc+8gcQ6IWv+zqV24PFBBcUL6gwAK6tEmikrGBPybixsZ
         TH6w+Xa+VtY4/jQhbWmKhXXT07+D/4oOyv7H/fuG2yDqrl3c1DlZpPDw4w7rlVIfbjgJ
         Mm9mOiOmMMllQi0NJRhHUVEtEIXiTB5Qb8TnlrMI9IYE8Ww09y/5EPygLH0Myy/OTl4o
         KnRKPjPIcpvfAFlcwaTbh4YB+mXKOBGv+dLN6I0GEEKKBJjpOrAOEOuxiRbV/bUFE+SF
         RGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712037538; x=1712642338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9V31exu69XJdwQKx28bPGGlT6S7Qasz8QRl4Vw0vQQ=;
        b=BO5+gT6SPOITNK0GkTXhmYY0k7bPH1GV4r1tDfT4XFHNLqflTaRTocpoiVc6nf6JJY
         jx6iFc2V+o/5vZqs7s4wJFkwXFt7gxVNnrMsKK2z+GUDNYMA4suTmphmn7FJFVkwDTWN
         X/HWG8gYEpXL4OZmQHYCeNBt5DSGhabYLIwS58OKBYyZBZQDEpIplDG709wMGCIa7qfx
         DEwXXFeNlg/3S83wxxOCJU0aX307rdgiRy4PPyrDRFildqmLcvm3+xnUcFhCYXjSWbbK
         y/eUbPWDifj26cAaFawPP+IK+dcwVgbtlotmdyL7UeN3aHvAUv+PsszoeCDFZhS9qCWG
         ZdMA==
X-Gm-Message-State: AOJu0Yz6c/qyxMmZVZ1B91iHRve7vE501F6peqEzN2diFoMwzl6qLPC3
	lbzHRYYxgog9lVwzgAFkTAAbBS7mHTa/OuN0hZBTt1bHVeIB8FHK
X-Google-Smtp-Source: AGHT+IGSJbMuI3uG5O0FyVMCDQaucJ3ZC0NDFnhrGUr4E9b1b1qTCQ3NYPhdUW9019kX8ws9bTZJ3g==
X-Received: by 2002:a17:907:11cd:b0:a4e:2d1e:6914 with SMTP id va13-20020a17090711cd00b00a4e2d1e6914mr6946123ejb.11.1712037537512;
        Mon, 01 Apr 2024 22:58:57 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id cd1-20020a170906b34100b00a4a396ba54asm6136636ejb.93.2024.04.01.22.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 22:58:57 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	Alexander Couzens <lynxis@fe80.eu>,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v3 net-next 1/6] net: phy: realtek: configure SerDes mode for rtl822xb PHYs
Date: Tue,  2 Apr 2024 07:58:43 +0200
Message-ID: <20240402055848.177580-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240402055848.177580-1-ericwouds@gmail.com>
References: <20240402055848.177580-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexander Couzens <lynxis@fe80.eu>

The rtl8221b and rtl8226b series support switching SerDes mode between
2500base-x and sgmii based on the negotiated copper speed.

Configure this switching mode according to SerDes modes supported by
host.

There is an additional datasheet for RTL8226B/RTL8221B called
"SERDES MODE SETTING FLOW APPLICATION NOTE" where a sequence is
described to setup interface and rate adapter mode.

However, there is no documentation about the meaning of registers
and bits, it's literally just magic numbers and pseudo-code.

Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
[ refactored, dropped HiSGMII mode and changed commit message ]
Signed-off-by: Marek Behún <kabel@kernel.org>
[ changed rtl822x_update_interface() to use vendor register ]
[ always fill in possible interfaces ]
[ only apply to rtl8221b and rtl8226b phy's ]
[ set phydev->rate_matching in .config_init() ]
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 114 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 1fa70427b2a2..70cd1834a832 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -54,6 +54,16 @@
 						 RTL8201F_ISR_LINK)
 #define RTL8201F_IER				0x13
 
+#define RTL822X_VND1_SERDES_OPTION			0x697a
+#define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
+#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII		0
+#define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX		2
+
+#define RTL822X_VND1_SERDES_CTRL3			0x7580
+#define RTL822X_VND1_SERDES_CTRL3_MODE_MASK		GENMASK(5, 0)
+#define RTL822X_VND1_SERDES_CTRL3_MODE_SGMII			0x02
+#define RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX		0x16
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -659,6 +669,63 @@ static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	return ret;
 }
 
+static int rtl822xb_config_init(struct phy_device *phydev)
+{
+	bool has_2500, has_sgmii;
+	u16 mode;
+	int ret;
+
+	has_2500 = test_bit(PHY_INTERFACE_MODE_2500BASEX,
+			    phydev->host_interfaces) ||
+		   phydev->interface == PHY_INTERFACE_MODE_2500BASEX;
+
+	has_sgmii = test_bit(PHY_INTERFACE_MODE_SGMII,
+			     phydev->host_interfaces) ||
+		    phydev->interface == PHY_INTERFACE_MODE_SGMII;
+
+	/* fill in possible interfaces */
+	__assign_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces,
+		     has_2500);
+	__assign_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces,
+		     has_sgmii);
+
+	if (!has_2500 && !has_sgmii)
+		return 0;
+
+	/* determine SerDes option mode */
+	if (has_2500 && !has_sgmii) {
+		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX;
+		phydev->rate_matching = RATE_MATCH_PAUSE;
+	} else {
+		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII;
+		phydev->rate_matching = RATE_MATCH_NONE;
+	}
+
+	/* the following sequence with magic numbers sets up the SerDes
+	 * option mode
+	 */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x75f3, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND1,
+				     RTL822X_VND1_SERDES_OPTION,
+				     RTL822X_VND1_SERDES_OPTION_MODE_MASK,
+				     mode);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6a04, 0x0503);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f10, 0xd455);
+	if (ret < 0)
+		return ret;
+
+	return phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x6f11, 0x8020);
+}
+
 static int rtl822x_get_features(struct phy_device *phydev)
 {
 	int val;
@@ -695,6 +762,28 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 	return __genphy_config_aneg(phydev, ret);
 }
 
+static void rtl822xb_update_interface(struct phy_device *phydev)
+{
+	int val;
+
+	if (!phydev->link)
+		return;
+
+	/* Change interface according to serdes mode */
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, RTL822X_VND1_SERDES_CTRL3);
+	if (val < 0)
+		return;
+
+	switch (val & RTL822X_VND1_SERDES_CTRL3_MODE_MASK) {
+	case RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX:
+		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+		break;
+	case RTL822X_VND1_SERDES_CTRL3_MODE_SGMII:
+		phydev->interface = PHY_INTERFACE_MODE_SGMII;
+		break;
+	}
+}
+
 static int rtl822x_read_status(struct phy_device *phydev)
 {
 	int ret;
@@ -716,6 +805,19 @@ static int rtl822x_read_status(struct phy_device *phydev)
 	return rtlgen_get_speed(phydev);
 }
 
+static int rtl822xb_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = rtl822x_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	rtl822xb_update_interface(phydev);
+
+	return 0;
+}
+
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
@@ -988,7 +1090,8 @@ static struct phy_driver realtek_drvs[] = {
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
-		.read_status	= rtl822x_read_status,
+		.config_init    = rtl822xb_config_init,
+		.read_status	= rtl822xb_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
@@ -1010,7 +1113,8 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
-		.read_status    = rtl822x_read_status,
+		.config_init    = rtl822xb_config_init,
+		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
@@ -1020,7 +1124,8 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
-		.read_status    = rtl822x_read_status,
+		.config_init    = rtl822xb_config_init,
+		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
@@ -1030,7 +1135,8 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
-		.read_status    = rtl822x_read_status,
+		.config_init    = rtl822xb_config_init,
+		.read_status    = rtl822xb_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
-- 
2.42.1


