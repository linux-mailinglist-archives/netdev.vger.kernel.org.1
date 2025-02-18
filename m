Return-Path: <netdev+bounces-167158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B616A39071
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAB11890947
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA83F1494D9;
	Tue, 18 Feb 2025 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlv0vK/0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E677145B0B;
	Tue, 18 Feb 2025 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842632; cv=none; b=FCOczlSp+j6faON1wckDD44mKiitdv+qt4tUwV2WBYC3Sdd50uCss9u7P8SmfDLcDrBKBtWZ56sg0zNezLebQvxx/t7YRP9isc2/GLsG00mcEIduiHFQSYuMZTLO1h6O+f0aBztZsH5MXHiJXQmSjWSSh/Bj10E9xR+lq36lJqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842632; c=relaxed/simple;
	bh=qtmfUDGv75w5CVqcuw6bNGD/cByFFoR3YiX/L5Hn6i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FESwCG762pcg2FE/qf6Afwkv7fybCquzLkJysWuYsJTg7zdvFA1oBqqWopCEVrb6f3GdSuIGCcUef1StiMiCBgZIeQJtZq+8Hh307HBm4QzaXjS9DbDedvCmtVO3seskm+60tHMkmkV5yWZUFVEZAC5gewUdkhQVoins6NBh/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlv0vK/0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f2339dcfdso73933085ad.1;
        Mon, 17 Feb 2025 17:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739842630; x=1740447430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mci4RkoOk3fkrGQ1DfYbs8TH7LLH/ggg9lHEgHHbo9U=;
        b=mlv0vK/0elZ4NLXc9SBAN9HzCG4Pz1cobDZkW/kF9YuFiE7DjWR7O2/ZPsbKVThpTo
         +f7gDJiun9hglmcC9ZC/qtZJ4U5aiRJNuDfC4nUYGMSUhkYweeryXGGy5ihioL5qfLJC
         +hZ3XBvD1CdAGZigKD+gAeVE9BbHfCnDD0Gnbyvz4kdQ4/rCPQLCIY55ZTbe91yJ7m7/
         LRvIK1PVFAq+ES1wr+SuN8XhSgVmKGin9W5b6WyeLfbenBrUv5zx4kWuR4kmmByRtsb1
         HijhCxK2phv78RXxxUMZT0NMEoo6GUokbZqvN6dD9P0lDgj7z4+8kDHtkCFBFxyYuXA5
         tZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842630; x=1740447430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mci4RkoOk3fkrGQ1DfYbs8TH7LLH/ggg9lHEgHHbo9U=;
        b=CZD5zQaX9LTNy9tqDwsMQyIyXkq5BIDN7o5RgwUkYXtxRI1AvEUkh/5eVq0oNtRqJD
         Wuq/9lkalqGBEmPWjSGhfA/YckZ8jDMC5p0a4FoLuTKs01gNVUhFdU+KMRfpPBc+szKS
         32b1DHg5vQK9fKXy4AKqDpC8U579Sz+vfoeuUNMKLVc5WTCVcEEg0uZzvexZs7enFAoq
         DH0IqJbMJbGK6F3ZLwO0jx6/oBikgj9aXZlRxPr5/Gh40NkiZMPTdDvN1QoNIY/tmHgc
         +/9562unWsCEvKaht969b00+6Pc5YaV0q1VLrVQ9vj1x5t8iXJTCPvT3+cqrOJ2FjLuI
         bxAg==
X-Forwarded-Encrypted: i=1; AJvYcCU8IMREeo9gDn7hYVBYZG0N16bWjR8GnVcoZRmo872AfbHWO1B2Y0G9k0gco7LmRzbIDRrPh5oGR6PFf4Z7@vger.kernel.org, AJvYcCUnyjZ6uUctzPGF61r8cA0kOBq0udOUTKw34380ya+ny/oz8eQX6sG3Vlodx/0z/SBe5mz9Bl5N/+u8@vger.kernel.org, AJvYcCWsHf8XqxQl5SlP110f68Ha1qO7iYksAxT4oT81aUdhrRigEV4zgFYRIn8cnwAEshv9VtZ80dF1@vger.kernel.org
X-Gm-Message-State: AOJu0YxmHJb4f7mGEBMkUGk/5ZHA0Z+lpkZV3C2L6fIh+tCQEMQvsRop
	cp3cy9rvApM1VRSgoNKkPClFNwRVpML1XwoQvnRgpWRGsVhODqRV
X-Gm-Gg: ASbGncvLwL3o+n1sGAdEjitnBSnqHIAoQ+mQpxRmjDYcPIk0m2u40N3XERLT7At61EV
	ligUJPL3v/406JabSEM4maF/xawGkxp0HEHd9zykr8+kNHclwmTr82xbHHl0O2FrJmj3dHvtqav
	e9oZLOharelOUAx4MgiM5PnQ89WQfbK3ys0KB2+araRbQY34sQhijr+JeQ6K0IggH+ysTrKxPHG
	TuPD9dxYQBw+eeN/Y2+2UYYk70puPKtvl2KkdUzbbGLapDZ8kCckc9qzEe3nn/6yGcxwnBoBv63
	BrEK2+F0XCkz1mPGi2MFbj2Rmwf+ogIepQ==
X-Google-Smtp-Source: AGHT+IHKzsoeJNNGfKaNcAxvBf/KZhRqe+GPxGl72u1n77wBG4ZaGiylfFnB29RsSKYjcFw0tEqdQg==
X-Received: by 2002:a17:902:ce06:b0:21f:40de:ae4e with SMTP id d9443c01a7336-2210458f528mr202468655ad.9.1739842630431;
        Mon, 17 Feb 2025 17:37:10 -0800 (PST)
Received: from localhost.localdomain ([64.114.251.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d4d8sm76910165ad.170.2025.02.17.17.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:37:10 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 1/5] net: phy: bcm63xx: add support for BCM63268 GPHY
Date: Mon, 17 Feb 2025 17:36:40 -0800
Message-ID: <20250218013653.229234-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218013653.229234-1-kylehendrydev@gmail.com>
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for the internal gigabit PHY on the
BCM63268 SoC. The PHY has a low power mode that has can be
enabled/disabled through the GPHY control register. The
register is passed in through the device tree, and the
relevant bits are set in the suspend and resume functions.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/phy/bcm63xx.c | 96 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/net/phy/bcm63xx.c b/drivers/net/phy/bcm63xx.c
index b46a736a3130..613c3da315ac 100644
--- a/drivers/net/phy/bcm63xx.c
+++ b/drivers/net/phy/bcm63xx.c
@@ -3,8 +3,11 @@
  *	Driver for Broadcom 63xx SOCs integrated PHYs
  */
 #include "bcm-phy-lib.h"
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/phy.h>
+#include <linux/regmap.h>
+
 
 #define MII_BCM63XX_IR		0x1a	/* interrupt register */
 #define MII_BCM63XX_IR_EN	0x4000	/* global interrupt enable */
@@ -13,10 +16,19 @@
 #define MII_BCM63XX_IR_LINK	0x0200	/* link changed */
 #define MII_BCM63XX_IR_GMASK	0x0100	/* global interrupt mask */
 
+#define PHY_ID_BCM63268_GPHY	0x03625f50
+
+#define GPHY_CTRL_IDDQ_BIAS	BIT(0)
+#define GPHY_CTRL_LOW_PWR	BIT(3)
+
 MODULE_DESCRIPTION("Broadcom 63xx internal PHY driver");
 MODULE_AUTHOR("Maxime Bizon <mbizon@freebox.fr>");
 MODULE_LICENSE("GPL");
 
+struct bcm_gphy_priv {
+		struct regmap *gphy_ctrl;
+};
+
 static int bcm63xx_config_intr(struct phy_device *phydev)
 {
 	int reg, err;
@@ -69,6 +81,80 @@ static int bcm63xx_config_init(struct phy_device *phydev)
 	return phy_write(phydev, MII_BCM63XX_IR, reg);
 }
 
+int bcm63268_gphy_set(struct phy_device *phydev, bool enable)
+{
+	struct bcm_gphy_priv *priv = phydev->priv;
+	u32 pwr_bits;
+	int ret;
+
+	pwr_bits = GPHY_CTRL_IDDQ_BIAS | GPHY_CTRL_LOW_PWR;
+
+	if (enable)
+		ret = regmap_update_bits(priv->gphy_ctrl, 0, pwr_bits, 0);
+	else
+		ret = regmap_update_bits(priv->gphy_ctrl, 0, pwr_bits, pwr_bits);
+
+	return ret;
+}
+
+int bcm63268_gphy_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = bcm63268_gphy_set(phydev, true);
+	if (ret)
+		return ret;
+
+	ret = genphy_resume(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int bcm63268_gphy_suspend(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	ret = bcm63268_gphy_set(phydev, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int bcm63268_gphy_probe(struct phy_device *phydev)
+{
+	struct device_node *np = dev_of_node(&phydev->mdio.bus->dev);
+	struct mdio_device *mdio = &phydev->mdio;
+	struct device *dev = &mdio->dev;
+	struct bcm_gphy_priv *priv;
+	struct regmap *regmap;
+	int err;
+
+	err = devm_phy_package_join(dev, phydev, 0, 0);
+	if (err)
+		return err;
+
+	priv = devm_kzalloc(dev, sizeof(struct bcm_gphy_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	regmap = syscon_regmap_lookup_by_phandle(np, "brcm,gphy-ctrl");
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	priv->gphy_ctrl = regmap;
+
+	return 0;
+}
+
 static struct phy_driver bcm63xx_driver[] = {
 {
 	.phy_id		= 0x00406000,
@@ -89,6 +175,15 @@ static struct phy_driver bcm63xx_driver[] = {
 	.config_init	= bcm63xx_config_init,
 	.config_intr	= bcm63xx_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
+}, {
+	.phy_id         = PHY_ID_BCM63268_GPHY,
+	.phy_id_mask    = 0xfffffff0,
+	.name           = "Broadcom BCM63268 GPHY",
+	/* PHY_BASIC_FEATURES */
+	.flags          = PHY_IS_INTERNAL,
+	.probe          = bcm63268_gphy_probe,
+	.resume			= bcm63268_gphy_resume,
+	.suspend		= bcm63268_gphy_suspend,
 } };
 
 module_phy_driver(bcm63xx_driver);
@@ -96,6 +191,7 @@ module_phy_driver(bcm63xx_driver);
 static const struct mdio_device_id __maybe_unused bcm63xx_tbl[] = {
 	{ 0x00406000, 0xfffffc00 },
 	{ 0x002bdc00, 0xfffffc00 },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_BCM63268_GPHY) },
 	{ }
 };
 
-- 
2.43.0


