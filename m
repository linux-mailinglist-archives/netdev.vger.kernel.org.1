Return-Path: <netdev+bounces-113812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3764F940012
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9275FB21045
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E7018F2C6;
	Mon, 29 Jul 2024 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsMqLKlI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B118EFC2;
	Mon, 29 Jul 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287194; cv=none; b=mEeWYQNUMp0+z1lCpcV5x3uYoAlcxmiYluK+76JlX1vd16G/n9usch3lviznHv3EfNsSQeSTGPIv1UHhpz6UkjYXjmhccdcudKtXaF7bIn/eS1I8A6zKwOgD3V4p4YRwoh+rbeK4hF2pIh9RcPM/pIY+MoboBZdAu9XJSwQJOcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287194; c=relaxed/simple;
	bh=QuPKaf941lHkWf9prBu9zUyAhNquWVs+vlrb39sN+AY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jm89zvhtJbWVlMBdtNlDW0y+CfmUzGquqUUKm8S4ZQZ02nd9RKeNrFGwD/00xER6NOU/G/oeW68R56VzFJwh7PwfoX0+U4hy9p+jcRka3PRlaQo468PxGEE9Z/s+54fytbVWzcrkKMm+STouuZb9jxz3ZJfNpVI7ngp62HKbtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsMqLKlI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef25511ba9so31800941fa.0;
        Mon, 29 Jul 2024 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722287190; x=1722891990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxl8FNTDoLnQTbWd6UAaRZ2yNtfTa4I0FfsdYDSD1cY=;
        b=nsMqLKlIoxyKjsdVNuo9UsLdPsneZF+qbJTG3fXs9Hhu5wD6w+WsNCqEhKx8Ai75kR
         nbl8VXdOl8/7XXnaNlMS7Bn+cCCqK/i2nAFXpfZLMMjVTIoPjYBO/5PARCFD9GiJjFwn
         C3h2D4n/FRvFh5Wkr5LmKZrb0zv7/xo9hpuB1HLFBsC4lrEnM6MJjXYMDwozh6E/rwaB
         ypB1qrPRyspxj+I+AKw3nHKJYx9xGIa21ALYROr8sBiKuECVkcsJ28k9LQe3pmLe7lC/
         VbQ261JHGRJru+RSagvnnjvDY6HozZtR/jvQoZiuHIOyAtd4HtWmAwKONtXN8KFK8hUd
         0UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722287190; x=1722891990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxl8FNTDoLnQTbWd6UAaRZ2yNtfTa4I0FfsdYDSD1cY=;
        b=jEMVaRpuyks3LMoD2iBiOR0dyxyTVLSehZqrjPrpYD8rWkFpPUWFP06B4WqP10zQwO
         lFu1USRnb2RRfZzxtE+nJWI6S0fxHTTT+RFZfR66Yxlq2O4d5v/cUWZzIM3iZIFYB8Rl
         ubW2xx8yGRspcUp9eN1HIFlKvIbxxWr/P9F6bRJ/LAsvZjAlGEezJlJQAyVHoROo6ETz
         mgdAsgbj286kuvkyKcen3iMac599EkhqgphYH71avoLAPZBvNcZ/25JAFSWKiN6HFmeU
         ku68V2i5mVZidzj0whapDuz4UJ+z09pju6waWq9/pb4iz0V1SRDMcaPT4HQXM0vBtGgl
         EHvA==
X-Forwarded-Encrypted: i=1; AJvYcCW/feMrUCtP8VAW8kSZByJiTAUsKG4hVV3JCrYg+jQY4eTORR0YsJquqMkt4F9P3+/pkbbpAxsr27wOy2/O97sJ9EMb1GZtkHgL0xHd
X-Gm-Message-State: AOJu0YzwkymHubYcSgIqG2GF/v3/y5mBxmQfRa67WZQPYaLBBkwSk3aL
	hej+vpW6WWRLQNB0uyifxd+J5TbBL9Z1qwlCVSrZaG9ZvdZ8wtLek8bnAXIz
X-Google-Smtp-Source: AGHT+IFFnxIKiVkCBtjvRBXBqJ+HQAJ+R5fG0pkmUdMchZUdhRzTJr4tqE6d/YHLbDBgq4hKMlA1uw==
X-Received: by 2002:a05:6512:1308:b0:52f:cc9e:449d with SMTP id 2adb3069b0e04-5309b6d3473mr2583452e87.3.1722287190278;
        Mon, 29 Jul 2024 14:06:30 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2becesm1624210e87.258.2024.07.29.14.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 14:06:29 -0700 (PDT)
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
	Linus Walleij <linus.walleij@linaro.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/9] net: dsa: vsc73xx: use defined values in phy operations
Date: Mon, 29 Jul 2024 23:06:10 +0200
Message-Id: <20240729210615.279952-5-paweldembicki@gmail.com>
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

This commit changes magic numbers in phy operations.
Some shifted registers was replaced with bitfield macros.

No functional changes done.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 45 ++++++++++++++++++++------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index e5466396669d..5eb37dee2261 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
 #include <linux/etherdevice.h>
@@ -40,6 +41,10 @@
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
+/* MII Block subblock */
+#define VSC73XX_BLOCK_MII_INTERNAL	0x0 /* Internal MDIO subblock */
+#define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
+
 #define CPU_PORT	6 /* CPU port */
 
 /* MAC Block registers */
@@ -221,9 +226,22 @@
 #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE	3
 
 /* MII block 3 registers */
-#define VSC73XX_MII_STAT	0x0
-#define VSC73XX_MII_CMD		0x1
-#define VSC73XX_MII_DATA	0x2
+#define VSC73XX_MII_STAT		0x0
+#define VSC73XX_MII_CMD			0x1
+#define VSC73XX_MII_DATA		0x2
+
+#define VSC73XX_MII_STAT_BUSY		BIT(3)
+#define VSC73XX_MII_STAT_READ		BIT(2)
+#define VSC73XX_MII_STAT_WRITE		BIT(1)
+
+#define VSC73XX_MII_CMD_SCAN		BIT(27)
+#define VSC73XX_MII_CMD_OPERATION	BIT(26)
+#define VSC73XX_MII_CMD_PHY_ADDR	GENMASK(25, 21)
+#define VSC73XX_MII_CMD_PHY_REG		GENMASK(20, 16)
+#define VSC73XX_MII_CMD_WRITE_DATA	GENMASK(15, 0)
+
+#define VSC73XX_MII_DATA_FAILURE	BIT(16)
+#define VSC73XX_MII_DATA_READ_DATA	GENMASK(15, 0)
 
 /* Arbiter block 5 registers */
 #define VSC73XX_ARBEMPTY		0x0c
@@ -535,20 +553,24 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 	int ret;
 
 	/* Setting bit 26 means "read" */
-	cmd = BIT(26) | (phy << 21) | (regnum << 16);
-	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
+	cmd = VSC73XX_MII_CMD_OPERATION |
+	      FIELD_PREP(VSC73XX_MII_CMD_PHY_ADDR, phy) |
+	      FIELD_PREP(VSC73XX_MII_CMD_PHY_REG, regnum);
+	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+			    VSC73XX_MII_CMD, cmd);
 	if (ret)
 		return ret;
 	msleep(2);
-	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, 0, 2, &val);
+	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+			   VSC73XX_MII_DATA, &val);
 	if (ret)
 		return ret;
-	if (val & BIT(16)) {
+	if (val & VSC73XX_MII_DATA_FAILURE) {
 		dev_err(vsc->dev, "reading reg %02x from phy%d failed\n",
 			regnum, phy);
 		return -EIO;
 	}
-	val &= 0xFFFFU;
+	val &= VSC73XX_MII_DATA_READ_DATA;
 
 	dev_dbg(vsc->dev, "read reg %02x from phy%d = %04x\n",
 		regnum, phy, val);
@@ -574,8 +596,11 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 		return 0;
 	}
 
-	cmd = (phy << 21) | (regnum << 16) | val;
-	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
+	cmd = FIELD_PREP(VSC73XX_MII_CMD_PHY_ADDR, phy) |
+	      FIELD_PREP(VSC73XX_MII_CMD_PHY_REG, regnum) |
+	      FIELD_PREP(VSC73XX_MII_CMD_WRITE_DATA, val);
+	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+			    VSC73XX_MII_CMD, cmd);
 	if (ret)
 		return ret;
 
-- 
2.34.1


