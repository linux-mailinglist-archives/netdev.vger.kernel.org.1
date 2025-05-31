Return-Path: <netdev+bounces-194513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD73EAC9C58
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 20:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35ABD17A2F1
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525B71A3141;
	Sat, 31 May 2025 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgQWXQob"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E52907;
	Sat, 31 May 2025 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748716795; cv=none; b=Qyu4cveu7ODc4ySmkJUav9xNX3ox+hYumGzMeFOXuZs+JnZAc3GWv3VDhFC9zOieO0CnEu/xlbvaVYO6jyzK5A/22dLAogkpPG3i69Hr23eUO5HU9FiOI1I68mUAj5WgFHC2wrfUO0QN4krRKQr1zS2VbECfZgvwKEFdNjVfhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748716795; c=relaxed/simple;
	bh=siLeM9++8r0ODoi+wjzDjRUa7L7fDm4F+gHfOU57OtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YueYJxCmrqg5PbRUWTi7iHuQhzhIwc2Gt+YJqUngOdEDzZ2D/hRcZOM3w7QxdTBVPiFKf5dD6+n3Jy2d7ZIVMIXYy+uY9vQzPc5wKvFALhxQ3zQw/4RCBl3BAuomsGl0VJffpvJuP+5ylxXAn4TpvTa8064MCIrh1x/Yr4BcZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgQWXQob; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74019695377so1901072b3a.3;
        Sat, 31 May 2025 11:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748716793; x=1749321593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pg0UJGmkB9eAqwQAGGERmKFyJgP97enh4p/9sTbGNAo=;
        b=MgQWXQobMD/oGNnaGK3EoBi10A0ssnPtVpGc/SRl68PE0m13MPoA0iOXnD9DfCvAq0
         36TO0XMcjrT6Md76Hb5dkoNfUlzC9pcc5zNQ2Fp2r1wSfvuRLO+/qQdyheje6QbINI3y
         la256rTLjTaQcdZvRhnEXhdPNrBb5BEqEZpcjHAeOuhE0Wo/Us6q6SdFbdH8wIEsYxUT
         nxPwIuxuIFQ6Fy7etoK9Qo3du1qBCjkzQwQ+LhEm0nJiuHdzsdkfeRAfNwr89kfSSVyc
         NCYNg4s4HCMhaO3kdtWgsQnAgEi1332RWJwyb9eGNE23TkAqEZK3b49GT3cs8IMs77T/
         TLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748716793; x=1749321593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg0UJGmkB9eAqwQAGGERmKFyJgP97enh4p/9sTbGNAo=;
        b=F8qJrQ54nYNK9zltLAHs8Z1mxxNJBGCkrUJ1I4nXiX95Ztp5ZdM93jWoJsmudRTXcv
         lfdprejscARR34aQewQhfgpFBqIbNM/Xnkxr/3wLqbllbv8P2l9fOTtDMEyiEHZPAocH
         LVnIM6wvCRKfXC1bgDUcebgkBE7WPR0FjkYSxe9XlhtXL2i/wi9VUmXygG1qO2BCs9yS
         F0DjCf4aSPfht8iTjpWRCElto9GwhdJ7fD5BftqoxUUmA8O5DVH8TbbCgf/c7xaQCCmk
         ZRXUwtyA121zxQBFVprJ/6SadS6y08Dpw+p2mgIZeDSpAVZhXFSLBDiP4I9nWq27IlQs
         16IA==
X-Forwarded-Encrypted: i=1; AJvYcCU6aEw6nf9FdTPnfazBLT/d9ht7cUbqC2ixQvmGPji0VbZmhIR2cczoqsvkhhAR65HSe2OECJYHzofC9dVo@vger.kernel.org, AJvYcCUVP5+SAumiAXp2Tfis2YGXnVn1oGxQBE0b1zbc6WN4orLyaNBNeyZKGKrj+R1xDINFXJFsaAMt@vger.kernel.org, AJvYcCVAv5jHxy00SoPNZnhpKD0Ya7+oARZMbDZTnJ47K98gtkn0l81b0e6c7qOrSCaMoDloKpSYmh4KqYv2@vger.kernel.org
X-Gm-Message-State: AOJu0YxgWD6+jOgkvFsruag1KGLqcoqDZhH8XMVw18NT/5Lwd+akYQLf
	Ix/8X6W2l33jco+hYqOnO/AXX9yravQ5beWaFw16KwU3feEZnq7MvAK8
X-Gm-Gg: ASbGnctIpxF1ZAtb6Ge3GIK2C1xkD7AlJimLz5VFy7VhdY/dZQVK9ueChFohG+CJXQo
	hsvMoF3M19ruP4wbqXIQdAt0fG6XpP9yA2K/MsD22n4/UPHoGzPJbYNwuTNcjnJy4qxPO+/Ijh1
	OlAqMlNK0lGFqIymLsDv/BZ9ol8t6KNSdzw1BLretr7tN84lOgMj5nDkzu+dAMXUITFmBw4xhKT
	71eyuazfiX9CGhOof6xDqWqSpzj0HSbfGxvv4xbFhqsfgLhJKjcnBYa5rD8NaEHEeSpOT8wXxf9
	bZLbAAUjaaUZr0ySa4XM2A8QzI/3hrzuuZ9Idnaz8CeVN7Rf1eG7RHnaOaKwcUMeqp34
X-Google-Smtp-Source: AGHT+IGmHjrHz6p6eGio7dm2FVS4u6g10DOnqW8vHl3Zl8M3+vEeb5Gx21mjHTU52WNVTJGx1mlfIQ==
X-Received: by 2002:a05:6a20:3949:b0:21a:d1fe:9e82 with SMTP id adf61e73a8af0-21bad0fb3bdmr4254938637.30.1748716792779;
        Sat, 31 May 2025 11:39:52 -0700 (PDT)
Received: from localhost.localdomain ([64.114.250.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed34fdsm4888915b3a.75.2025.05.31.11.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 11:39:52 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND net-next v4 1/3] net: phy: bcm63xx: add support for BCM63268 GPHY
Date: Sat, 31 May 2025 11:39:12 -0700
Message-ID: <20250531183919.561004-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250531183919.561004-1-kylehendrydev@gmail.com>
References: <20250531183919.561004-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the internal gigabit PHY on the BCM63268 SoC.
Low power mode is set in the GPHY control register which is
accessed through the GPIO controller syscon.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/phy/bcm63xx.c | 88 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/net/phy/bcm63xx.c b/drivers/net/phy/bcm63xx.c
index b46a736a3130..b45f2c9acc06 100644
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
+#include <linux/reset.h>
 
 #define MII_BCM63XX_IR		0x1a	/* interrupt register */
 #define MII_BCM63XX_IR_EN	0x4000	/* global interrupt enable */
@@ -13,10 +16,20 @@
 #define MII_BCM63XX_IR_LINK	0x0200	/* link changed */
 #define MII_BCM63XX_IR_GMASK	0x0100	/* global interrupt mask */
 
+#define PHY_ID_BCM63268_GPHY	0x03625f50
+
+#define GPHY_CTRL_OFFSET	0x54
+#define GPHY_CTRL_IDDQ_BIAS	BIT(0)
+#define GPHY_CTRL_LOW_PWR	BIT(3)
+
 MODULE_DESCRIPTION("Broadcom 63xx internal PHY driver");
 MODULE_AUTHOR("Maxime Bizon <mbizon@freebox.fr>");
 MODULE_LICENSE("GPL");
 
+struct bcm_gphy_priv {
+	struct regmap *gpio_ctrl;
+};
+
 static int bcm63xx_config_intr(struct phy_device *phydev)
 {
 	int reg, err;
@@ -69,6 +82,71 @@ static int bcm63xx_config_init(struct phy_device *phydev)
 	return phy_write(phydev, MII_BCM63XX_IR, reg);
 }
 
+static int bcm63268_gphy_set(struct phy_device *phydev, bool enable)
+{
+	struct bcm_gphy_priv *priv = phydev->priv;
+	u32 pwr_bits;
+	int ret;
+
+	pwr_bits = GPHY_CTRL_IDDQ_BIAS | GPHY_CTRL_LOW_PWR;
+
+	if (enable)
+		ret = regmap_update_bits(priv->gpio_ctrl, GPHY_CTRL_OFFSET, pwr_bits, 0);
+	else
+		ret = regmap_update_bits(priv->gpio_ctrl, GPHY_CTRL_OFFSET, pwr_bits, pwr_bits);
+
+	return ret;
+}
+
+static int bcm63268_gphy_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = bcm63268_gphy_set(phydev, true);
+	if (ret)
+		return ret;
+
+	return genphy_resume(phydev);
+}
+
+static int bcm63268_gphy_suspend(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	return bcm63268_gphy_set(phydev, false);
+}
+
+static int bcm63268_gphy_probe(struct phy_device *phydev)
+{
+	struct mdio_device *mdio = &phydev->mdio;
+	struct device *dev = &mdio->dev;
+	struct reset_control *reset;
+	struct bcm_gphy_priv *priv;
+	struct regmap *regmap;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	regmap = syscon_regmap_lookup_by_phandle(dev->of_node, "brcm,gpio-ctrl");
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	priv->gpio_ctrl = regmap;
+
+	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
+	return reset_control_reset(reset);
+}
+
 static struct phy_driver bcm63xx_driver[] = {
 {
 	.phy_id		= 0x00406000,
@@ -89,6 +167,15 @@ static struct phy_driver bcm63xx_driver[] = {
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
@@ -96,6 +183,7 @@ module_phy_driver(bcm63xx_driver);
 static const struct mdio_device_id __maybe_unused bcm63xx_tbl[] = {
 	{ 0x00406000, 0xfffffc00 },
 	{ 0x002bdc00, 0xfffffc00 },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_BCM63268_GPHY) },
 	{ }
 };
 
-- 
2.43.0


