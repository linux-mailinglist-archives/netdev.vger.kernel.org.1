Return-Path: <netdev+bounces-113817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FEC94001C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45880B20F6C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC86D190070;
	Mon, 29 Jul 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHnpxRER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942818FDD1;
	Mon, 29 Jul 2024 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287202; cv=none; b=cmTVWlkrIhLYP9qgt+2gOUwK1Pguwx68WSfUpy5SFZKfHtHwU/2eUKTXighNT5pBdXpMJKs8PkIOZGVs3zL6UCxQfgVqR1ll7v+2kBvM40PDDdvznJq2HuvyBHw2iy/VBE/k/JxHP8ik26KCPtasVSKiVePkNXmN+O4R5l3MOEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287202; c=relaxed/simple;
	bh=/nll/xQ57QpCe/KFcvY9S3fpHUjf5E1IdqrSu7nCt3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RxFQvVx2eGpJyvW6WRFgPFroD1HkHPJSjn9fEVjYdTDOksQ2ofzP3HX0L3JLsZ/Heo2q8ZSOC5k4Xe5N5ukGed6f4Bw2gLaj7cj1fkYSrhuoWnXzZI4M1rsnSEa2JfjpJTNveOEiiDtET3KKXzu+lEq3MS45y+VQcdcd3hCrYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHnpxRER; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so5969295e87.2;
        Mon, 29 Jul 2024 14:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287198; x=1722891998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aood59TYIo0CSyaSVOXxvTHUPNO93s3Ct8cxPWT2YP0=;
        b=SHnpxRERRJ3D5ooLIPWudwLvwSoMq7V43m/CA0m+EYHbO7MQRw4bF2/QJBc3bW6qd4
         3Mz1GWvjgSHFi9u+cr6K/yiJfwWXW77RMtZ6C1xcJEf7ZfSQLV0gjWa1Ckf6baghxtdl
         q/2I34T5SgV1TJuQTbba4a7jdVheTfk28bmNXLhWLjkF5SKABGbYypqMb5+v9OlNlRsx
         MFP8nqhWexWlFMY4s43f5dVL0huZzySIqn4EcofD3VJ7QsvUozwkvh5eiQXyQiBFSiQc
         SXP9XVUKbof1Yr0qv19b3txOfQfESSZ9TarnHS9XcpUvvEF3dCo3o1LHWRy3E9O/nUhj
         fccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287198; x=1722891998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aood59TYIo0CSyaSVOXxvTHUPNO93s3Ct8cxPWT2YP0=;
        b=fI61RQC1Og+kNSZ88iJeIsYm6NH51oAFez/Hc/hsCokAlsWP4dJCWeHtvIPgAGK4Zu
         J+bnQOlxWPzIwnxRkzafkJoXkrJ3tzuExOUMIINGOQ07zTVqMvIyDxV1n7HWALNahqOb
         +Tajp4vcNpcbMUdCrtIOmuYGEJYvbGGCsGZcr6jbbEPsEN2SEpKNTkvCbMGWDLDv+rCD
         fgGTCwTTW81dtBjb3sNoB3s0lcu/IDNNY++ouelHR4k0VXFV5N/uZs09PIjUZoLO7gtU
         0PkptHf56O5dkcAvQdmz9ryWE/w8JteguSLl6D9ok/k22cpVa5g5GkHOZaQFfAgAahow
         bbBw==
X-Forwarded-Encrypted: i=1; AJvYcCUhreDcy5CrMBR1SetDGCy4jnzJW+TXx04woGMs/fp2xyz9U4F8tttrhoiROappwx20EeMD4SAuZacmkkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwweIIzNqWiLpMNMvx/D6BOVEFhXzZVfvCJWsB25xDBFlHtTQko
	okWogQc6hykpNbNuKef+/PgC+f01yWzSl1a9K9uUD4gU4pVnj2xYm/Qgwt/R
X-Google-Smtp-Source: AGHT+IF51byaAuVxiOkHYwjvPEN83vlnJXCSOK4Ixxb1xF9g1jgloJnfwk6kja8u9w/eD1+FBTBX7A==
X-Received: by 2002:ac2:5692:0:b0:530:aa53:60f6 with SMTP id 2adb3069b0e04-530aa53625cmr58394e87.15.1722287198558;
        Mon, 29 Jul 2024 14:06:38 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2becesm1624210e87.258.2024.07.29.14.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:06:38 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 9/9] net: phy: vitesse: implement downshift in vsc73xx phys
Date: Mon, 29 Jul 2024 23:06:15 +0200
Message-Id: <20240729210615.279952-10-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729210615.279952-1-paweldembicki@gmail.com>
References: <20240729210615.279952-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit implements downshift feature in vsc73xx family phys.

By default downshift was enabled with maximum tries.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/phy/vitesse.c | 100 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index 19b7bf189be5..9228c6652627 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -10,8 +10,10 @@
 #include <linux/mii.h>
 #include <linux/ethtool.h>
 #include <linux/phy.h>
+#include <linux/bitfield.h>
 
 /* Vitesse Extended Page Magic Register(s) */
+#define MII_VSC73XX_EXT_PAGE_1E		0x01
 #define MII_VSC82X4_EXT_PAGE_16E	0x10
 #define MII_VSC82X4_EXT_PAGE_17E	0x11
 #define MII_VSC82X4_EXT_PAGE_18E	0x12
@@ -60,6 +62,15 @@
 /* Vitesse Extended Page Access Register */
 #define MII_VSC82X4_EXT_PAGE_ACCESS	0x1f
 
+/* Vitesse VSC73XX Extended Control Register */
+#define MII_VSC73XX_PHY_CTRL_EXT3		0x14
+
+#define MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN	BIT(4)
+#define MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT	GENMASK(3, 2)
+#define MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_STA	BIT(1)
+#define MII_VSC73XX_DOWNSHIFT_MAX		5
+#define MII_VSC73XX_DOWNSHIFT_INVAL		1
+
 /* VSC73XX PHY_BYPASS_CTRL register*/
 #define MII_VSC73XX_PHY_BYPASS_CTRL		MII_DCOUNTER
 #define MII_PBC_FORCED_SPEED_AUTO_MDIX_DIS	BIT(7)
@@ -133,6 +144,84 @@ static int vsc73xx_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, VSC73XX_EXT_PAGE_ACCESS, page);
 }
 
+static int vsc73xx_get_downshift(struct phy_device *phydev, u8 *data)
+{
+	int page, val, cnt, enable;
+
+	page = phy_select_page(phydev, MII_VSC73XX_EXT_PAGE_1E);
+	if (page < 0)
+		return page;
+
+	val = __phy_read(phydev, MII_VSC73XX_PHY_CTRL_EXT3);
+	if (val < 0)
+		goto restore_page;
+
+	enable = FIELD_GET(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN, val);
+	cnt = FIELD_GET(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT, val) + 2;
+
+	*data = enable ? cnt : DOWNSHIFT_DEV_DISABLE;
+
+restore_page:
+	phy_restore_page(phydev, page, val);
+	return 0;
+}
+
+static int vsc73xx_set_downshift(struct phy_device *phydev, u8 cnt)
+{
+	int page, ret, val;
+
+	if (cnt > MII_VSC73XX_DOWNSHIFT_MAX)
+		return -E2BIG;
+	else if (cnt == MII_VSC73XX_DOWNSHIFT_INVAL)
+		return -EINVAL;
+
+	page = phy_select_page(phydev, MII_VSC73XX_EXT_PAGE_1E);
+	if (page < 0)
+		return page;
+
+	if (!cnt) {
+		ret = __phy_clear_bits(phydev, MII_VSC73XX_PHY_CTRL_EXT3,
+				       MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN);
+	} else {
+		val = MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN |
+		      FIELD_PREP(MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT,
+				 cnt - 2);
+
+		ret = __phy_modify(phydev, MII_VSC73XX_PHY_CTRL_EXT3,
+				   MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_EN |
+				   MII_VSC73XX_PHY_CTRL_EXT3_DOWNSHIFT_CNT,
+				   val);
+	}
+
+	ret = phy_restore_page(phydev, page, ret);
+	if (ret < 0)
+		return ret;
+
+	return genphy_soft_reset(phydev);
+}
+
+static int vsc73xx_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return vsc73xx_get_downshift(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int vsc73xx_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return vsc73xx_set_downshift(phydev, *(const u8 *)data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void vsc73xx_config_init(struct phy_device *phydev)
 {
 	/* Receiver init */
@@ -142,6 +231,9 @@ static void vsc73xx_config_init(struct phy_device *phydev)
 
 	/* Config LEDs 0x61 */
 	phy_modify(phydev, MII_TPISTATUS, 0xff00, 0x0061);
+
+	/* Enable downshift by default */
+	vsc73xx_set_downshift(phydev, MII_VSC73XX_DOWNSHIFT_MAX);
 }
 
 static int vsc738x_config_init(struct phy_device *phydev)
@@ -460,6 +552,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC7388,
 	.name           = "Vitesse VSC7388",
@@ -469,6 +563,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC7395,
 	.name           = "Vitesse VSC7395",
@@ -478,6 +574,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC7398,
 	.name           = "Vitesse VSC7398",
@@ -487,6 +585,8 @@ static struct phy_driver vsc82xx_driver[] = {
 	.config_aneg    = vsc73xx_config_aneg,
 	.read_page      = vsc73xx_read_page,
 	.write_page     = vsc73xx_write_page,
+	.get_tunable    = vsc73xx_get_tunable,
+	.set_tunable    = vsc73xx_set_tunable,
 }, {
 	.phy_id         = PHY_ID_VSC8662,
 	.name           = "Vitesse VSC8662",
-- 
2.34.1


