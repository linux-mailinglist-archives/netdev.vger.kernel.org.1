Return-Path: <netdev+bounces-170465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4FA48D46
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D582F16DE3F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834AB175BF;
	Fri, 28 Feb 2025 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrdGkAyE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5D8F5A;
	Fri, 28 Feb 2025 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702467; cv=none; b=IdFVt4qU3cA6BSZChClruVvOz3u7zr2q8jTxj+JxgudxA7sa5IlVzMZywedmMebYwWtkuQ1etd+31VltfWhGPzHsKnaJStdrVvBsMly5mJsB54pydapTfQOuvenpgfLz1Z/2pKGtJNzjJSJ6+GNDezjxZn0tNtQIHHUfeHq2S2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702467; c=relaxed/simple;
	bh=MmZwy6RFz1ZG2vtqBPaqDy3bEl59QTyEdMgwmtK0KAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epUEEVuUIln3ejGdQpOi/892I7sXbeXxe9Gi2BwCLVSp3u5/60pcJQHoNyInMEZXed2NtJgx+zBpL2ssHhf7CyYjQyqjx8bSqFux/1Z2Apr08XxZe0L3jD6+L8ka/zdaSCsgwIrbgKs2pvGh2v/wXJVZCPR0dJS33sxZJcZkfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrdGkAyE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2feb1d7a68fso1883312a91.1;
        Thu, 27 Feb 2025 16:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740702465; x=1741307265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcj8+jvL+9xfvoiMDuFhN+LdLWbXzXy0Rx7vgwdad/s=;
        b=HrdGkAyEfdMHfgcM3KkegVygxiHX6kSqTtZzRhTcJqDATE9iAIFrnJxLNmxKetBCAw
         oof2Tfkogko/edQw5ZxkFirBgIEul2rfc7A9eYreFH3fhk+3lb1HnHr99nUSdX7ztf2W
         VkN4xm0EMTWlzNR9tzHDbz9tcY/LPA0Z9eHQfoDyOB+MUuHpGUxBSFMtXqdXiaNmUjHi
         77YFKKejVxrDoVWtRKZKERwK01qcl9aejT/uSU486mCMNwmHal4OvShH42LHgvqqVkWZ
         ShJedd3IciJ8qVlQWMGh6KDyEvxfjhMFVH2pihwFp2Jg7WFrvvv1tWSus8jn6iGhJw04
         cnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702465; x=1741307265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcj8+jvL+9xfvoiMDuFhN+LdLWbXzXy0Rx7vgwdad/s=;
        b=UEhVwfnHa7uZtNJjq+TSy7SiQ3sByfYClI5QvAlxwG6DJk6tJbnLBW1/mEVCO7aZ2Y
         4yebOyO31OHSIcZE6uzoWwYeSAlFd62KVwUyxaY8DFAlxEUv8Q7z10aLMIkvZ9CGfiuu
         lwVMMw1SnMhkAPL+DLJ00qQ+zL5S1F6Tj09GQvNShxQp7jQ2jZxUrQgC7+mW1GS+WKxu
         4G8pFjBbMSyWINdILZSCysA6w/oYRNdHNB4s7opsuiRQqFUgwzo35m+lFD0qYKCYRN2j
         iv5pgUajnY0YeAA52xG4aQ9KFWN+lMdK6ghsCzleMQ81mvO/9hikqn3CFQbBk4fPqqj9
         /nQA==
X-Forwarded-Encrypted: i=1; AJvYcCUiUn0IUoVtE1d+ckmpPvFOOvpfdZj1/zJy1gpv4c4xJTzKnLHEmfCH3DFDA2KWp2yAsGoCDjwF@vger.kernel.org, AJvYcCUw4Z5kxDs0lY3vPyHPzBVa6HiaM/98NF2srIfc9xSGu05a821Q9x8AYMxg7gbaP0BvbAppJyRaXs5/@vger.kernel.org, AJvYcCXjvfWua/Ed+W+znJ1Wy3WTMBUXve21/MAMhOaeIncPwMHsbD4ZikZcfsgBCEYcb+k9Ib7WAjEiv7jzIBda@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe95U4xiDpJxo5O9eZ7Txu6+WZKh1rFD85w8mm4U3wHGG/dK5u
	pA/8NPiPZ8lmRRKGkldjJwBQI9/5vNahICpi1tlaob0YkzPW8mkt
X-Gm-Gg: ASbGncvQS9X0lsf9wQrO2c42fnMG5jOYtNq8j7B/DUMiHq0b9t1UOKlv/g03yABx/fu
	cGw748TguvAFuDqIoEdWiDfj6RMnQL8RMR5Orr6bL8oLmrN9X7S++ZbbA4zyQMo1RqJy0/macjq
	rs5D3DAaJB1KOqUTVQzdIxbYgxJKoP1qN5fnitRiFf1EiDAi2yCPjLCPwD4F6iKI15vUX2bNCn5
	TydD0SZlVOIXNEZiiDj7wEnopHvjvL6WOKdO53EfholNlJ+Kn6ihGg2yKE1TTI7aLLxO9tMLxT6
	Jgn3USpmiqPT7wN89wQIcZVzLXqzGwnTfbTCojItP7vg5A==
X-Google-Smtp-Source: AGHT+IHtennpjocmEAAkOX/8ipxexx+y8EDTMt+4et88s4DsR0LW34UTutKuGJC1nProHrgYH+od0Q==
X-Received: by 2002:a17:90b:1845:b0:2ee:d193:f3d5 with SMTP id 98e67ed59e1d1-2febab2ecbfmr2330544a91.7.1740702465014;
        Thu, 27 Feb 2025 16:27:45 -0800 (PST)
Received: from localhost.localdomain ([205.250.172.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe82840e62sm4511094a91.34.2025.02.27.16.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:27:44 -0800 (PST)
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
Subject: [PATCH v3 1/3] net: phy: bcm63xx: add support for BCM63268 GPHY
Date: Thu, 27 Feb 2025 16:27:15 -0800
Message-ID: <20250228002722.5619-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228002722.5619-1-kylehendrydev@gmail.com>
References: <20250228002722.5619-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the internal gigabit PHY on the BCM63268 SoC.
Some of the PHY functionality is configured out of band through
memory mapped registers. The GPHY control register contains bits
which need to be written to enable/disable low power mode. The
register is part of the SoC's GPIO controller, so accessing it
is done through a phandle to that syscon.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/phy/bcm63xx.c | 101 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/net/phy/bcm63xx.c b/drivers/net/phy/bcm63xx.c
index b46a736a3130..9467bbf573e5 100644
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
@@ -69,6 +82,84 @@ static int bcm63xx_config_init(struct phy_device *phydev)
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
+	ret = genphy_resume(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
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
+	ret = bcm63268_gphy_set(phydev, false);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int bcm63268_gphy_probe(struct phy_device *phydev)
+{
+	struct mdio_device *mdio = &phydev->mdio;
+	struct device *dev = &mdio->dev;
+	struct reset_control *reset;
+	struct bcm_gphy_priv *priv;
+	struct regmap *regmap;
+	int ret;
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
+	ret = reset_control_reset(reset);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static struct phy_driver bcm63xx_driver[] = {
 {
 	.phy_id		= 0x00406000,
@@ -89,6 +180,15 @@ static struct phy_driver bcm63xx_driver[] = {
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
@@ -96,6 +196,7 @@ module_phy_driver(bcm63xx_driver);
 static const struct mdio_device_id __maybe_unused bcm63xx_tbl[] = {
 	{ 0x00406000, 0xfffffc00 },
 	{ 0x002bdc00, 0xfffffc00 },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_BCM63268_GPHY) },
 	{ }
 };
 
-- 
2.43.0


