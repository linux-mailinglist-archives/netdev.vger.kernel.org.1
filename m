Return-Path: <netdev+bounces-180362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3971A81102
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 17:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463AE8855A7
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98C22DF8A;
	Tue,  8 Apr 2025 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE9Rvldq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9C22D4F9;
	Tue,  8 Apr 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744127641; cv=none; b=njOHMvdSGuJHPs72IHtolFDqYH6SCcKlDADfaSbgFypZ88WltdIKqWZiG8ZK/PPLL52mc3W/AMHIeglR0qVWOFdtZhi3/9qXlIQ1shJAxRfCAXFCJHrEDXadqBfEz2oCfP/wRBbkg6Vh6BeLrwwoPBOvlPxJIZuNCaJtkiFLnKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744127641; c=relaxed/simple;
	bh=rhRNPrwgHxuwuX8EJqxWCDuGP/PlPNaPILeYY0/ajdI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnL/FOUskC5wfkkagaB2peOzWJoQrGt0VqJpuTUpRTJBNI6RjXMDZAc2nA6Mo+O/9MaObrW44rmOuwrx/G+obNjx5l6O+kcQk4k425cLbNAXU6MqX1opztdKvHajilmNRR6r54WKwX+rN/Hv0pWKbI++LSyVbg4a8PrPi5LT2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE9Rvldq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso37599775e9.0;
        Tue, 08 Apr 2025 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744127638; x=1744732438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ekOcUtRr3A4IOGCZAyUQefTbVJ5awYg2QZ9PR3IRAM0=;
        b=UE9RvldqqADgkzWxyVqgkWsyB3YsRgDZidvauxFbM5H6OrSSjOl5xAGfwBHkMLzqzq
         QpHJk2Uy87GMzyuHlm2kUl/Bdki8aH+k2zvS+GbpyE3OT8WBE68B0XCc7T6zFnmKf3cr
         UFztvr67ZbgOIwemUpTqVs3rfvf/VRVreraOMw+IFTn54dspBODlKnEH9aftvATiJl7D
         W88/y0ik7dukp/uiTuAP7eAt1uf2tqbX2IjtwnZ8W+ze1RDHjZiG9GZSyOeV6agKi4hS
         uERjcVrZ93HQfORfWcG4kSq4i4kadG5LfbZgLeF+g5tPnPP/gOfwaB6LsW9OsAb0/3Rc
         Kpsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744127638; x=1744732438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ekOcUtRr3A4IOGCZAyUQefTbVJ5awYg2QZ9PR3IRAM0=;
        b=w8Clhm7/O5a/Ep7Z9HonZAMcJ2VXvt29iWLj4SqepDbksRARYXNxvWddPb9b0sCl4H
         00F6B1ODdf0Ivh3jfGtIFmb9U6WGaZrd5cQgAEPJ3+zm7I/uEs83jRY6q77hja4p9EHa
         FHY/qxmgx89JSaM+ZcV0s404Msm4Z4rVQI3K64tvGWnK6hZvIX0ZAGUrljqa265D+gyI
         0P+5bNa/TjU6+NJuoCkSiYN4KWX9vgMMuZxYNEysa5FY/IOXNN/gDsCXuy0Lvu9w+nwe
         YVnyT5/jWUeaHLkawwSVNqHB0jY9Y4sX7MMtnIm058ryNDnJzvKqes4eFigP9y3rCPw0
         /6rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/moxn44tLG0iKrTz/qpZF2U6OOIZkQq4YCHCEC3SPAQeVpfv3rH+0XiYBBkN23ICVGNDTpjS0O+n0cw=@vger.kernel.org, AJvYcCWe1qkIzj2MZPaSx0Kkeu8L3gRTh+/wYl0HvHC/xfyEIsLKR44nWf8HDoUrtBgX748nRfqvcyvm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1n9dMMDQVdnnbz8gr6Rh/ABavLuKudekPWvoYZWmu2VZZlv/
	rdKg4W/LabTEr2dJtvwnFF8+GyRLyrUAFd4jWCIvALUqfu9eQG86
X-Gm-Gg: ASbGncu3A1PH7wcuR4WEIa1RR9xPKlv+47I5Hvl7cs0N2FnvR0Zddkno58NYLBsOSI4
	RdFIb5YRG22+aMm7xxS5v7cxUvJlD/AbX/0Ri/Gv361cwxpomLxx1SbuUeqWwztpFfZW/dLLE50
	/DMAb6SEvmp6ZrbuCzka+CUG+emowbWaejiBcG0uvsWed54Kecuuq+92vVEE6d/w0rKm4lRkG45
	u2nDnQf3ZstsJ3lXugAmbS9Fb2rZh/TZ3llsMBGHTJQ4iCVlTtd/LL78Fxc91dv5ir/rzAjzw4f
	Cf2i0VM5Bct+5cYhZp0gMq201noMhCgveNTBuWBTsuTAl9eg38A7YdGLnM3ZO5u01Nhp0IO6qPy
	XU4q//ClfUACI7g==
X-Google-Smtp-Source: AGHT+IEcvb61vad+7cTWO+SjMN3izWfOVzCUXI71ezIzb4gGUHEDx9bOWlC53mcqXmTAlTQO2RLqzw==
X-Received: by 2002:a05:600c:3484:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-43ed0db4006mr180860035e9.31.1744127637770;
        Tue, 08 Apr 2025 08:53:57 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c30226ee4sm15716615f8f.93.2025.04.08.08.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:53:57 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.or
Subject: [net-next PATCH 2/2] net: phy: mediatek: add Airoha PHY ID to SoC driver
Date: Tue,  8 Apr 2025 17:53:14 +0200
Message-ID: <20250408155321.613868-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408155321.613868-1-ansuelsmth@gmail.com>
References: <20250408155321.613868-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha AN7581 SoC ship with a Switch based on the MT753x Switch embedded
in other SoC like the MT7581 and the MT7988. Similar to these they
require configuring some pin to enable LED PHYs.

Add support for the PHY ID for the Airoha embedded Switch and define a
simple probe function to toggle these pins. Also fill the LED functions
and add dedicated function to define LED polarity.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/mediatek/Kconfig      |  4 +-
 drivers/net/phy/mediatek/mtk-ge-soc.c | 62 +++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index c80b4c5b7b66..0fb496757e04 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -15,8 +15,8 @@ config MEDIATEK_GE_PHY
 
 config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
-	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
-	depends on NVMEM_MTK_EFUSE || COMPILE_TEST
+	depends on (ARM64 && (ARCH_MEDIATEK || ARCH_AIROHA)) || COMPILE_TEST
+	depends on (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || ARCH_AIROHA || COMPILE_TEST
 	select MTK_NET_PHYLIB
 	help
 	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index 175cf5239bba..fd0e447ffce7 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -11,8 +11,11 @@
 #include "../phylib.h"
 #include "mtk.h"
 
+#define MTK_PHY_MAX_LEDS			2
+
 #define MTK_GPHY_ID_MT7981			0x03a29461
 #define MTK_GPHY_ID_MT7988			0x03a29481
+#define MTK_GPHY_ID_AN7581			0x03a294c1
 
 #define MTK_EXT_PAGE_ACCESS			0x1f
 #define MTK_PHY_PAGE_STANDARD			0x0000
@@ -1406,6 +1409,53 @@ static int mt7981_phy_probe(struct phy_device *phydev)
 	return mt798x_phy_calibration(phydev);
 }
 
+static int an7581_phy_probe(struct phy_device *phydev)
+{
+	struct mtk_socphy_priv *priv;
+	struct pinctrl *pinctrl;
+
+	/* Toggle pinctrl to enable PHY LED */
+	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "gbe-led");
+	if (IS_ERR(pinctrl))
+		dev_err(&phydev->mdio.bus->dev,
+			"Failed to setup PHY LED pinctrl\n");
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
+static int an7581_phy_led_polarity_set(struct phy_device *phydev, int index,
+				       unsigned long modes)
+{
+	u32 mode;
+	u16 val;
+
+	if (index >= MTK_PHY_MAX_LEDS)
+		return -EINVAL;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			val = MTK_PHY_LED_ON_POLARITY;
+			break;
+		case PHY_LED_ACTIVE_HIGH:
+			val = 0;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
+			      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
+			      MTK_PHY_LED_ON_POLARITY, val);
+}
+
 static struct phy_driver mtk_socphy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981),
@@ -1441,6 +1491,17 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.led_hw_control_set = mt798x_phy_led_hw_control_set,
 		.led_hw_control_get = mt798x_phy_led_hw_control_get,
 	},
+	{
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7581),
+		.name		= "Airoha AN7581 PHY",
+		.probe		= an7581_phy_probe,
+		.led_blink_set	= mt798x_phy_led_blink_set,
+		.led_brightness_set = mt798x_phy_led_brightness_set,
+		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
+		.led_hw_control_set = mt798x_phy_led_hw_control_set,
+		.led_hw_control_get = mt798x_phy_led_hw_control_get,
+		.led_polarity_set = an7581_phy_led_polarity_set,
+	},
 };
 
 module_phy_driver(mtk_socphy_driver);
@@ -1448,6 +1509,7 @@ module_phy_driver(mtk_socphy_driver);
 static const struct mdio_device_id __maybe_unused mtk_socphy_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981) },
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7988) },
+	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7581) },
 	{ }
 };
 
-- 
2.48.1


