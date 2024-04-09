Return-Path: <netdev+bounces-85983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B43789D30B
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFA4EB217E1
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6497D417;
	Tue,  9 Apr 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qbb7z23t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E37D096
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647830; cv=none; b=dlDhBOM3THV+tYXXoOagMl6ARqWEY1/v++I3vqqJnBgqH5Z3smyaHPjH8E2+GsVsdQk8R3bUdCPHHWVpHYuhGttAIdyeWqaOtvKWf/a1CWGIMrh8aulzLrdLw6k8yNJfRXE7xh0vBVQqIDnGZWgIBlqNRLMdXuaGQ5Nkg/40/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647830; c=relaxed/simple;
	bh=q2Cs0YfNPRBwgUjeXgYZPRIY4hFMTnOMGrXWS87chwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAvnj/B8O2IwUb//5uihb9HeNZIHK+hRwY3lsTkhk78EL4It2roaNAKJuLTYMF9l5GZoVvrg+pwlxn+KpW62HsZOvWy33LKIw9czmCPedewb7JCz66mEcL51KIF2Yu3MEUreWeu0/QnEhqToe2k4Xbg817LAk8CqdZhD2ELJTw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qbb7z23t; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51fc011e8fso26118366b.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 00:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712647826; x=1713252626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKp9iyhdpbkHShnqT1Bpb+638mmslPyOXZxA0lb4kzI=;
        b=Qbb7z23tpFrfuUTHaiGKIqCSLKt5TTYKMZPpT0DLHlXNiXu/k/3/PVUScB/Ls3n3ny
         kSXYoQ6Ao2yIJkRp3mLpNNtb9HVlNumWmucdVa2Ft7TT0Kjc+qz7p4Z0OomnO5nmSDwe
         N2i5uqYIra2NVCrbGV8ebw5BQj98g+xjXTerdsNOX9BiYRtpCe6F/Il9Rw4hR1cGUJfS
         9ZDh4cW7ZJ2t11OKOKzZaGyNtXmJ+KtdvLb5KzDdT/+EQE9aY/zUMEnmStqjMjOIWK85
         8j/BtJOfExnZJarYV0wYfwp3j8NYpVeJKYsVUGdLuETb9Cd7xvH3NIH7Iq+Yee8k4loB
         dchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712647826; x=1713252626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKp9iyhdpbkHShnqT1Bpb+638mmslPyOXZxA0lb4kzI=;
        b=gvadxQ2TLo5oM5K6+DPTf4ryKre4HHUbIDZ6VWSmSt/70vfksS32F5jmP9qr32EhOA
         6wzOhyoMhr8WDwGoEZnqaxIcMSyZBJAiArCKvtS9/Wkpc+2DY8HNAekA8ZtaeSspWb68
         RxxrYA7+N/RaaGGsoMItb6J4dHFQgwifxr1D6xuuNHn4CkXZUBJO6rvWOvuuKBvysLy9
         U6/EoP80FNLB53394/aHCXWcAL1r3L68fNKmnAM8GgN7I15YYN1qCaEhWJR4gSXV6oo4
         hfWxmGoepXVHobbAOb9Z26SC5UHVFcujcEIlwTa2Y4QZjD1C7EU10Yktaz2q+bdT+TWj
         3B1A==
X-Gm-Message-State: AOJu0Ywe6XyiJAVocCR7YbT2Hu+3b5mRUyGj48cKZxlyKT9VInPvZvvo
	hrNSCqOUDtH1qwZLahtPLHwqvJQkg1pjyQD4MuE7v8Q9WYbQTgTw
X-Google-Smtp-Source: AGHT+IHX6pw57OxB55P+xu1QmbI3txukm6hitwT8eEukEF0fQjDiDfT3e7XO/ajKyxW2Td1HzDoacQ==
X-Received: by 2002:a17:907:2d09:b0:a51:d463:32c0 with SMTP id gs9-20020a1709072d0900b00a51d46332c0mr4934529ejc.57.1712647826515;
        Tue, 09 Apr 2024 00:30:26 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a473362062fsm5315694ejt.220.2024.04.09.00.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:30:25 -0700 (PDT)
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
	Eric Woudstra <ericwouds@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v4 net-next 3/6] net: phy: realtek: Add driver instances for rtl8221b via Clause 45
Date: Tue,  9 Apr 2024 09:30:13 +0200
Message-ID: <20240409073016.367771-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240409073016.367771-1-ericwouds@gmail.com>
References: <20240409073016.367771-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marek Behún <kabel@kernel.org>

Collected from several commits in [PATCH net-next]
"Realtek RTL822x PHY rework to c45 and SerDes interface switching"

The instances are used by Clause 45 only accessible PHY's on several sfp
modules, which are using RollBall protocol.

Signed-off-by: Marek Behún <kabel@kernel.org>
[ Added matching functions to differentiate C45 instances ]
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/realtek.c | 135 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 131 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 08d338271bd0..f4a6f073a1f7 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -64,6 +64,13 @@
 #define RTL822X_VND1_SERDES_CTRL3_MODE_SGMII			0x02
 #define RTL822X_VND1_SERDES_CTRL3_MODE_2500BASEX		0x16
 
+/* RTL822X_VND2_XXXXX registers are only accessible when phydev->is_c45
+ * is set, they cannot be accessed by C45-over-C22.
+ */
+#define RTL822X_VND2_GBCR				0xa412
+
+#define RTL822X_VND2_GANLPAR				0xa414
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -74,6 +81,9 @@
 
 #define RTL_GENERIC_PHYID			0x001cc800
 #define RTL_8211FVD_PHYID			0x001cc878
+#define RTL_8221B_VB_CG				0x001cc849
+#define RTL_8221B_VN_CG				0x001cc84a
+#define RTL_8251B				0x001cc862
 
 MODULE_DESCRIPTION("Realtek PHY driver");
 MODULE_AUTHOR("Johnson Leung");
@@ -839,6 +849,67 @@ static int rtl822xb_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl822x_c45_config_aneg(struct phy_device *phydev)
+{
+	bool changed = false;
+	int ret, val;
+
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return genphy_c45_pma_setup_forced(phydev);
+
+	ret = genphy_c45_an_config_aneg(phydev);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	val = linkmode_adv_to_mii_ctrl1000_t(phydev->advertising);
+
+	/* Vendor register as C45 has no standardized support for 1000BaseT */
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2, RTL822X_VND2_GBCR,
+				     ADVERTISE_1000FULL, val);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	return genphy_c45_check_and_restart_aneg(phydev, changed);
+}
+
+static int rtl822x_c45_read_status(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret = genphy_c45_read_status(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Vendor register as C45 has no standardized support for 1000BaseT */
+	if (phydev->autoneg == AUTONEG_ENABLE) {
+		val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
+				   RTL822X_VND2_GANLPAR);
+		if (val < 0)
+			return val;
+
+		mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
+	}
+
+	return 0;
+}
+
+static int rtl822xb_c45_read_status(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = rtl822x_c45_read_status(phydev);
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
@@ -862,6 +933,35 @@ static int rtl8226_match_phy_device(struct phy_device *phydev)
 	       rtlgen_supports_2_5gbps(phydev);
 }
 
+static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
+			       bool is_c45)
+{
+	if (phydev->is_c45)
+		return is_c45 && (id == phydev->c45_ids.device_ids[1]);
+	else
+		return !is_c45 && (id == phydev->phy_id);
+}
+
+static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev)
+{
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
+}
+
+static int rtl8221b_vb_cg_c45_match_phy_device(struct phy_device *phydev)
+{
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true);
+}
+
+static int rtl8221b_vn_cg_c22_match_phy_device(struct phy_device *phydev)
+{
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, false);
+}
+
+static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev)
+{
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, true);
+}
+
 static int rtlgen_resume(struct phy_device *phydev)
 {
 	int ret = genphy_resume(phydev);
@@ -872,6 +972,15 @@ static int rtlgen_resume(struct phy_device *phydev)
 	return ret;
 }
 
+static int rtlgen_c45_resume(struct phy_device *phydev)
+{
+	int ret = genphy_c45_pma_resume(phydev);
+
+	msleep(20);
+
+	return ret;
+}
+
 static int rtl9000a_config_init(struct phy_device *phydev)
 {
 	phydev->autoneg = AUTONEG_DISABLE;
@@ -1143,8 +1252,8 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc849),
-		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
+		.match_phy_device = rtl8221b_vb_cg_c22_match_phy_device,
+		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C22)",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
@@ -1155,8 +1264,17 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc84a),
-		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
+		.match_phy_device = rtl8221b_vb_cg_c45_match_phy_device,
+		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
+		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
+		.config_aneg    = rtl822x_c45_config_aneg,
+		.read_status    = rtl822xb_c45_read_status,
+		.suspend        = genphy_c45_pma_suspend,
+		.resume         = rtlgen_c45_resume,
+	}, {
+		.match_phy_device = rtl8221b_vn_cg_c22_match_phy_device,
+		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
@@ -1166,6 +1284,15 @@ static struct phy_driver realtek_drvs[] = {
 		.resume         = rtlgen_resume,
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
+	}, {
+		.match_phy_device = rtl8221b_vn_cg_c45_match_phy_device,
+		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
+		.config_init    = rtl822xb_config_init,
+		.get_rate_matching = rtl822xb_get_rate_matching,
+		.config_aneg    = rtl822x_c45_config_aneg,
+		.read_status    = rtl822xb_c45_read_status,
+		.suspend        = genphy_c45_pma_suspend,
+		.resume         = rtlgen_c45_resume,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc862),
 		.name           = "RTL8251B 5Gbps PHY",
-- 
2.42.1


