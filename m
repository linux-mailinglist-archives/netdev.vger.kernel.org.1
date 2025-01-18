Return-Path: <netdev+bounces-159576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7794BA15E84
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 19:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D0C1886D88
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 18:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A094819FA8D;
	Sat, 18 Jan 2025 18:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxFpjFlL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4C136327;
	Sat, 18 Jan 2025 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737225837; cv=none; b=T3uImyQLYyYXF0g0fxyPyOObs+IpiFshVIpyD9J7aJx2ld7ztUnXuXWbcwhjbXclZcU8NCqczOcztiZFbRhLSWXcM1U0V7W85n5nQTCEYUDEJ3bcLt5dIrYlO3u5Ud1eiquJyn1f1jjf0tRkNbPWXrIjZXBrEKI7GgRLqGo/1k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737225837; c=relaxed/simple;
	bh=+iwkhhOGPdC3xgxlF3sg+rBOERpnf1MptoGPdowM+3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a7WTsCHW4bU/h8zQ0NWPHkF66F2eB0RRVH1EG+g5s6EGxI3FwwRvJHaxPQzPw5v8aaCbnSR6vn/mwo3VqhZqHCrlE115EgdwEy3S9Z5uCK7R8R5CQUF22JcQgBEExPSeA0a7YvnYp+FNNSoYYEFEm0XcC2q521kXVg9srykphnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxFpjFlL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43635796b48so19821405e9.0;
        Sat, 18 Jan 2025 10:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737225834; x=1737830634; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5zH//ydjqM5hORnfNum81jWDQE64C/M8GdF5egp+Y8s=;
        b=mxFpjFlL5uOWkxJMAdlD1YrtDHhvJU4cMFXwedf2rpo99clLfc/n353Xvi+24VravO
         HWbcbCLoKdO+GlNIVT/d7qawPD+2Uay+cwYKA4ewKTjkez4xVSlGJoIhDRBQL/kz/sR3
         giVw7c/jJ+fsL6j/H4w7WvDBwIO+i5qSBMwloDFK4mGbXj3R3Upjam9yIBN3XPPxqYnj
         RrEXn2DZQd521NedQCYpItKOBtLO0Uekle1egsDD3NvHet1pgTJRJ1wL2C48uQj/URk+
         iaKF+3ZuYIKH1IRMDG/HaQPWpq7leTdVPCgMzGY6goKOnXgcsms5PBid/bvUW1Sy3AHu
         Nuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737225834; x=1737830634;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5zH//ydjqM5hORnfNum81jWDQE64C/M8GdF5egp+Y8s=;
        b=JwI3CPSJ5sa7vRH5XEv59z0oT4b4rdaenbSua9VWichsZD4PgQ+oNMzekS7u4C9QQP
         mQ0sIbkyQ81XbGDjMPQLR3cOj22WgMkUX4TlV5B1M/zf85Evxdu8toLG4xayWUHcIHpD
         JgfRcj1AHwk0x8YxXVKaAVVL/iANB6euhHl3VbnfIeFDElrKQWJUVixubfjR7qTOEp2c
         wGOv23dcVfjcMOzB6ou/L14Mk1SxqOHzHHFFDseomRVriFwFAgCzxOwaA1PJRBvp6nMF
         H3yCWdCf4ssUSVPx9XXc7pH8BKzSZ08DlIDnTe9UD8LGRlpHBT63YAtO6tcJiNLM/WX1
         mhSw==
X-Forwarded-Encrypted: i=1; AJvYcCXDg7QHSunLb/JYyS1thrxp/JMAXG1z8eLlg6VihDTeYxz+TBISafLpySxjpNwOe5/xC6HkRpfS76E5KVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzebf7UET9IW5M3NQdKhJsr9o2v1hLvoX6h4+mcxHBYH4AOSNa
	khEc1bWN5tpeoCwXstM2GcfjXVOgQW0/Q1wQGMVfnH5upn4Ci2tH
X-Gm-Gg: ASbGncuAILKvzAgR5IvhBC86zSyNFESJ4EwC4M5zu+kCwasthkDIUlDpCm2SvOND1d9
	vB5DGKbqGgAMzLp5BgbzrwQAYLJ5FM2wlOv8tmGjkVMrEasljAQ1SCG5XB7uijugqbiwV0Ju1Zm
	KPxbswqG1h0UdXVJxZV7sc2/ObgkYUD8/ln+mI+ll4rLnXLqsccrzHKdYC+jf3GMydFkk1TvELh
	nXHncGWCM4L+baUR6p3O6M3Dz4RmTsnSAk+F1drFMyMH9/4AL/6kd/ACzD1IyThXJAlyzps8Q==
X-Google-Smtp-Source: AGHT+IGu5nLJEyBMCthQjCrqJ9WROLMkMM1Kk/GppDS/TtXPjlmZAkOAYIc732QTdzd0liojH6aPiw==
X-Received: by 2002:a05:600c:2e11:b0:434:ff08:202e with SMTP id 5b1f17b1804b1-438926daa5emr57402885e9.8.1737225833821;
        Sat, 18 Jan 2025 10:43:53 -0800 (PST)
Received: from [127.0.1.1] ([2a00:79c0:679:b700:bace:4cb2:853f:bbed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904131f5sm75145995e9.11.2025.01.18.10.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 10:43:53 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
Date: Sat, 18 Jan 2025 19:43:43 +0100
Subject: [PATCH v2] net: phy: marvell-88q2xxx: Fix temperature measurement
 with reset-gpios
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250118-marvell-88q2xxx-fix-hwmon-v2-1-402e62ba2dcb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAF72i2cC/42NQQ6CMBBFr0Jm7Zi2EaiuvIdhUWGgk1Cqrak1h
 LtbOYHL93/++ytECkwRLtUKgRJH9ksBdaigt2aZCHkoDEqoWkjZoDMh0Tyj1k+Vc8aRM9q38ws
 OTSuEMXRWqoWyfwQq5e6+dYUtx5cPn/0qyV/6jzVJlEhU9+NgTnfS7XVyhudj7x1027Z9AU5ZH
 vnCAAAA
X-Change-ID: 20250116-marvell-88q2xxx-fix-hwmon-d6700aae9227
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Stefan Eichenberger <eichest@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2

When using temperature measurement on Marvell 88Q2XXX devices and the
reset-gpios property is set in DT, the device does a hardware reset when
interface is brought down and up again. That means that the content of
the register MDIO_MMD_PCS_MV_TEMP_SENSOR2 is reset to default and that
leads to permanent deactivation of the temperature measurement, because
activation is done in mv88q2xxx_probe. To fix this move activation of
temperature measurement to mv88q222x_config_init.

Fixes: a557a92e6881 ("net: phy: marvell-88q2xxx: add support for temperature sensor")
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
Changes in v2:
- Added missing fixes tag
- Link to v1: https://lore.kernel.org/r/20250116-marvell-88q2xxx-fix-hwmon-v1-1-ee5cfda4be87@gmail.com
---
 drivers/net/phy/marvell-88q2xxx.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 4494b3e39ce2b672efe49d53d7021b765def6aa6..a3996471a1c9a5d4060d5d19ce44aa70e902a83f 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -95,6 +95,10 @@
 
 #define MDIO_MMD_PCS_MV_TDR_OFF_CUTOFF			65246
 
+struct mv88q2xxx_priv {
+	bool enable_temp;
+};
+
 struct mmd_val {
 	int devad;
 	u32 regnum;
@@ -710,17 +714,12 @@ static const struct hwmon_chip_info mv88q2xxx_hwmon_chip_info = {
 
 static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 {
+	struct mv88q2xxx_priv *priv = phydev->priv;
 	struct device *dev = &phydev->mdio.dev;
 	struct device *hwmon;
 	char *hwmon_name;
-	int ret;
-
-	/* Enable temperature sense */
-	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TEMP_SENSOR2,
-			     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
-	if (ret < 0)
-		return ret;
 
+	priv->enable_temp = true;
 	hwmon_name = devm_hwmon_sanitize_name(dev, dev_name(dev));
 	if (IS_ERR(hwmon_name))
 		return PTR_ERR(hwmon_name);
@@ -743,6 +742,14 @@ static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
 
 static int mv88q2xxx_probe(struct phy_device *phydev)
 {
+	struct mv88q2xxx_priv *priv;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
 	return mv88q2xxx_hwmon_probe(phydev);
 }
 
@@ -810,6 +817,18 @@ static int mv88q222x_revb1_revb2_config_init(struct phy_device *phydev)
 
 static int mv88q222x_config_init(struct phy_device *phydev)
 {
+	struct mv88q2xxx_priv *priv = phydev->priv;
+	int ret;
+
+	/* Enable temperature sense */
+	if (priv->enable_temp) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
+				     MDIO_MMD_PCS_MV_TEMP_SENSOR2,
+				     MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK, 0);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (phydev->c45_ids.device_ids[MDIO_MMD_PMAPMD] == PHY_ID_88Q2220_REVB0)
 		return mv88q222x_revb0_config_init(phydev);
 	else

---
base-commit: b44e27b4df1a1cd3fd84cf26c82156ed0301575f
change-id: 20250116-marvell-88q2xxx-fix-hwmon-d6700aae9227

Best regards,
-- 
Dimitri Fedrau <dima.fedrau@gmail.com>


