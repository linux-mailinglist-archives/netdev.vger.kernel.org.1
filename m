Return-Path: <netdev+bounces-172307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADBCA54225
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 06:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A41E1718B1
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 05:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761919D88F;
	Thu,  6 Mar 2025 05:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoldvsNK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149DE19E97A;
	Thu,  6 Mar 2025 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239112; cv=none; b=TlAtEWVnvOkM39V03dRIq9jDs4XLAkKdrJm2YZ3eJ3ctpPHgfa2JCbWfSEb+SlfnFB8UbURODn89Is4AFrckZoEzkm5UIWap15jBkgMZ6jtMfiNGKSQobhhOrtZhrgXHGWusklhrFL+iQ48ylvXPCDxyLTWk9MEsNlVXIbYnS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239112; c=relaxed/simple;
	bh=siLeM9++8r0ODoi+wjzDjRUa7L7fDm4F+gHfOU57OtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sse4KzDE8HcoY00n4YBqsPjyEV36ne30qxpXOzGstrCmpzaGxDQ2ru+m5wK/nGNj2O/Jv2OrJ4zJhXe/g6C4C87lZ20dYIRVKtCT+wwxn9xMa62Wmxg1+b14YPJMavfsDz3Egtjs7HrVvolXPVJbvGBjufl128kVm4Js8krOeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoldvsNK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223a7065ff8so4917995ad.0;
        Wed, 05 Mar 2025 21:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741239110; x=1741843910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pg0UJGmkB9eAqwQAGGERmKFyJgP97enh4p/9sTbGNAo=;
        b=aoldvsNK6lWR0WhoNVYvMrLgvTLHxlpdfzPkX/wCxCPN/ZH+ec5sZmUP1Sz88OhFT2
         MsHv/C/GSxnkKLAh5dTsd+XNngVg+FHwNhweglrQ537mrDd+K+/xo6axnrBW/Os5jRON
         uUJc1JeUuWoQggXd60++oqX0pb5DLK7jbkNU3GVPDbI9mScoHA1AujtyEAPAMMoeX4Cx
         vgpXlrSHbni6yV5X907Rr3kgrSguzMVpOuNxXSB5We/MUdTxpMfuQXTt4+0MXI1ZJECY
         wEnszCAGXAI48jIicsxFiwYYcEyKlRwyzYMeZVjoxLlpREFUHgCtP7Jh3CbgJzrtQYPU
         pJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741239110; x=1741843910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pg0UJGmkB9eAqwQAGGERmKFyJgP97enh4p/9sTbGNAo=;
        b=X9WnJzA6J9dQ+ljnvpX3fTMj57wismboA6wXnroTeu6CLUcwbCo8iRFSRnwl92Hx2p
         ugfuYdd0bDi+2KTHbcNvlY/V6sk46zJM5IbXYm8sB9nwZBAJkIOTIejzEp6C0WMaky7K
         NUk6cE23HYpVx6WeHMTnm7UXCn+1Ny9vAR+PPz8WRxQZF6RhdsCZbUw03d8uoi19+Zau
         pG8kDWr9B14tLZ51bvXwS21px1lSK47QECDSAha/1ZkywWYWQsimdm7EIV82dr0EdK29
         6H/xcRagP/O8foCuLi/uXzgxuFIffrIlOvOc3JKgV8j4rz/cbXZ7vgzHuPAUxA75rj5R
         rD7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPg3wFfvANr6zF0fP+Ls5I0Ki40f5vHZHls1LuvkVxVIslcnwjros6VZDeTh+ydcRHShSwwY3+@vger.kernel.org, AJvYcCVrZAhJUZiGxlVBaIjMD5Jb0aMzi+d3naSoreeEkt7Zqs7fCpnyM0zyx8oOhRriLWe34dhm1BNxliuU@vger.kernel.org, AJvYcCWh8pE7FEQcWTVF8LWAZdaUokj4Q6Dkq6ssiVsX5VQBMbsnYqb7xGHq1SBjtKLvpVexn0MEpFqwPd6wxE4P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8uvfJqOD/TvsUyuKhpHRUgoMsVdpeKSM0hsCmIDhwVxT8OwBM
	fWFJQkrpM89ZX1W/SEFzX/yaNisY+jb2zLoPjg0tQBrueBPBeJ/R
X-Gm-Gg: ASbGncui1TLljfgiEvUYsHzFk7/kqpjE/bIm3+HysuemYccDLK72rW1abMMLJvhPGZl
	0SEFtGtMmSxg0I3AHsFLQqY2hKlAutzRulgB4UXMnv/91YhFEeWC1SRaTE7GLY4/vtP142dv+Ln
	fqaFLalvyw71svzgSK+2hKG3CncU3zSZyoPDKlvhZD35MJyzZ2BItAOnW8DZSj5d1OvNBaIagrY
	KwSr16YdBcGN7NkauHvQPKotx2hRfN8HyuSucDgRknmtArhbYk/pNTJO0fABBHvevXkAs5wAM6D
	Dqt1Cu/25/+YC7/j46jytm1xfA9yp/Ub/rTYALnHecZbvds/W1Rx9cWxvCfOflx0
X-Google-Smtp-Source: AGHT+IFQloQNcTSdlZI11jZW2seAs3G5v5VinzyUM8r8SVYpLXLW/OvoWO+R9d3cK0xsOHl2MKwpdQ==
X-Received: by 2002:a17:902:ea03:b0:223:f928:4553 with SMTP id d9443c01a7336-223f928486bmr76652325ad.44.1741239110230;
        Wed, 05 Mar 2025 21:31:50 -0800 (PST)
Received: from localhost.localdomain ([205.250.198.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8ae4sm3470045ad.243.2025.03.05.21.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 21:31:50 -0800 (PST)
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
Subject: [PATCH net-next v4 1/3] net: phy: bcm63xx: add support for BCM63268 GPHY
Date: Wed,  5 Mar 2025 21:30:58 -0800
Message-ID: <20250306053105.41677-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306053105.41677-1-kylehendrydev@gmail.com>
References: <20250306053105.41677-1-kylehendrydev@gmail.com>
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


