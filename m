Return-Path: <netdev+bounces-75207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DBC868A35
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9881C21DF4
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19255E70;
	Tue, 27 Feb 2024 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdZUkPJ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075054BCB
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020335; cv=none; b=Tmlc+MNh2c7cX0Ny2IqXstV6d5h31vRoHPysDta6qiMHToQq4p+YpCKleZHlV5fxVP6e6KbvyK5nzPUrNs34QTpBoz1BhSY30eXOZ7dil3i8ATq3prCvBLmwv50pgBqYTMp6+Ew/9Yx4+p3JyxatPPQNPMAJEFA99wDiVgR40tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020335; c=relaxed/simple;
	bh=D9d2gLGV+H9Dx1o5hWwuRB09liSlDPYfHq5pJrxtpAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fqeofVW+hyPFqBwmQsuYhu2BxO0/CmETVI/cW93wmaJehebKtSgg72Xi5i2wFF5sc+puxItSXr688CSzXGouMeKdwaunBNZpgt38hF7rnHkKW5UIh/o+J0x7C9QPThPTw8m1jQBqFfSZ6SAUpKQAdlTQx5XWmzKdr3+l5TP2hqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdZUkPJ5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso472257166b.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709020332; x=1709625132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm73J2e9NjYnil3Gq+K1miusdQf03+KpV2uG6yda8Rg=;
        b=bdZUkPJ5FEzLLD3yC/n8M6/oy1hC3Hrg0fGRdD+FZbKrJ0L+fTfRsUa+zsqlrBAmKg
         i6+zENcOLH6GFuKI51W84UjB5jtZgVnJjCtI/PUz/evuv4NKCsFw60RLU/Bo1afB3wsd
         sw2YYOzEWaR4AwVIkO4+oJekccXTkLpcqXtmRtn3iWUHszP0REZXmf4qWTvMKXPPHraG
         Qwtpa84TyP4RR/H/GuyKte5fngSC0jK3jkct/v4YaF1WYoekEIzXOozDJEoLRn4srnyU
         xfO9+fIpDiFS5LYtKiHlfXCNkz0yuhLOv0PUCW+abM5aRbyVaBjmHpawqUvaPpvt4pEq
         Dh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020332; x=1709625132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xm73J2e9NjYnil3Gq+K1miusdQf03+KpV2uG6yda8Rg=;
        b=U9L39blT7KXByfASMtyAUA1PyUney/M6gqdtQ2xO5m1FwxdUsfU5P/+UE8s6YTqDji
         ip0dglvoL/Tdka1WUbRgGXxGw+m4l3hGAH05PGC8q79TOLmtzVQ2NvTOl2K7eK26yIB9
         KZS4jNSQzwNF8AcOonUZQQvmU0uoG8wuEsb9yigKkWeq91AhCcfy/KF99ISeiaR4fj0A
         IqL7eExjHimE5kvXEKm//aW+ObRmnyEINLTvtRXnhalv+GCJexx+oqbIq30FRbGIRGbi
         lLySYlJHCOKwbpS0nFeG3gAzMOZruEqq4uhP61JMvfhobPVd1Es65Y0hUQYIjKJJzquK
         7HyQ==
X-Gm-Message-State: AOJu0YwAMR7d4wmJUNfIjPR1BK3MBYsHGk0sWy9FJTJ37T3bvn76WL2W
	DqEX5TnwHcOTbBmHdKZJxZoeB7rzHIpBPvmzsLjmle6Gl9yoLIpq
X-Google-Smtp-Source: AGHT+IGySedehGx7O7YS1LEWj1oupS64QZkkUgSPZbTM+r4vJ6XI7128IAn1YljMgObnz7VDIBFjSA==
X-Received: by 2002:a17:906:135b:b0:a40:2998:567c with SMTP id x27-20020a170906135b00b00a402998567cmr5697310ejb.41.1709020332064;
        Mon, 26 Feb 2024 23:52:12 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a3f0dbdf106sm496460ejc.105.2024.02.26.23.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:52:11 -0800 (PST)
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
Subject: [PATCH RFC net-next 1/6] net: phy: realtek: configure SerDes mode for rtl822x/8251b PHYs
Date: Tue, 27 Feb 2024 08:51:46 +0100
Message-ID: <20240227075151.793496-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240227075151.793496-1-ericwouds@gmail.com>
References: <20240227075151.793496-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexander Couzens <lynxis@fe80.eu>

The rtl822x series and rtl8251b support switching SerDes mode between
2500base-x and sgmii based on the negotiated copper speed.

Configure this switching mode according to SerDes modes supported by
host.

Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
[ refactored, dropped HiSGMII mode and changed commit message ]
Signed-off-by: Marek Behún <kabel@kernel.org>
[ changed rtl822x_update_interface() to use vendor register ]
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 96 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 1fa70427b2a2..67cffe9b7d5d 100644
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
 
@@ -659,6 +669,60 @@ static int rtl822x_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	return ret;
 }
 
+static int rtl822x_config_init(struct phy_device *phydev)
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
+	if (!has_2500 && !has_sgmii)
+		return 0;
+
+	/* fill in possible interfaces */
+	__assign_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces,
+		     has_2500);
+	__assign_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces,
+		     has_sgmii);
+
+	/* determine SerDes option mode */
+	if (has_2500 && !has_sgmii)
+		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX;
+	else
+		mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII;
+
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
+	/* the following 3 writes into SerDes control are needed for 2500base-x
+	 * mode to work properly
+	 */
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
@@ -695,6 +759,25 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 	return __genphy_config_aneg(phydev, ret);
 }
 
+static void rtl822x_update_interface(struct phy_device *phydev)
+{
+	int val;
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
@@ -709,11 +792,13 @@ static int rtl822x_read_status(struct phy_device *phydev)
 						  lpadv);
 	}
 
-	ret = genphy_read_status(phydev);
+	ret = rtlgen_read_status(phydev);
 	if (ret < 0)
 		return ret;
 
-	return rtlgen_get_speed(phydev);
+	rtl822x_update_interface(phydev);
+
+	return 0;
 }
 
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
@@ -976,6 +1061,7 @@ static struct phy_driver realtek_drvs[] = {
 		.match_phy_device = rtl8226_match_phy_device,
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -988,6 +1074,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -1000,6 +1087,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8226-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1010,6 +1098,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1019,6 +1108,7 @@ static struct phy_driver realtek_drvs[] = {
 		PHY_ID_MATCH_EXACT(0x001cc849),
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
+		.config_init    = rtl822x_config_init,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
@@ -1030,6 +1120,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1040,6 +1131,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8251B 5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl822x_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
-- 
2.42.1


