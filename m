Return-Path: <netdev+bounces-181185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4212A84039
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B63A007F1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA527C841;
	Thu, 10 Apr 2025 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/19l36g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849FB27C14A;
	Thu, 10 Apr 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279483; cv=none; b=ReuokBHBClcjOX1OGj8DW0lcpJc71BrOtukbtMowkU8LBeOVPcUu0M6Dj3bGtL+Vv6WmCk4wq4PoOMw2DcuuMKtleenr6ZMorjrsLW1bvbrAc1M9GBBoSs/siHbCx5kRQHZ9q2zS1xN6b8dLgo+eQfCNg12tdFh4CKXM+ZbXioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279483; c=relaxed/simple;
	bh=d2l0bgeOa75neO0E5WT9wRpN8pWI6q1OkesNZ42wDTU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCuGBqCv1Hm62tymxSE5DOvnBh4ttvvRIa8/Wlssb5zgOiPNFoaFRYban7wyVvLqznhTjVDQgAZKGJ1gGxw0x1kA8+HQZFrOJC9nKAIVkzFy4CPmWy193GUYBtQHNm54Cgb4AqQ+KCJUFG3q6JPAo0NQ6VtQ4o17x5MKOdaEOBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/19l36g; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf257158fso4925305e9.2;
        Thu, 10 Apr 2025 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744279480; x=1744884280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdUAxzWtLeB6HjxCg5m7G0qo3TL8BAYNXQpF7s4o0Vo=;
        b=N/19l36g6reOy+VscO+vvmD0zLbcof8CfTw/w7I0tNL7SQ2PSNv1/acy02cF4hmWwS
         QZytdeApKEbJ9QyaD0vfAWJqtVHZ/1CnPjn6baHKMiu2AiXZJX03inQneFfYfr7Pbkd4
         GLPsatmKp8hDuQDhk9J9u5CJ90vY8FTwfaDPHe78u5hl+rpB0AYFc+boutLmglYgpjK4
         1LFU3P0VawWGOLe2meP3BcV4w5g25IUj9uTszEwVM+iwsxfEwWm28LM60AX98WU794FI
         dpTItKYAAYhooCR+8WkftyVT/ninAwmmGI1KshNbZBEMI1VcAvZbAuoIZbYiljQQwoE9
         Poiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744279480; x=1744884280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdUAxzWtLeB6HjxCg5m7G0qo3TL8BAYNXQpF7s4o0Vo=;
        b=lmDTf4PcN6fLGDQ2kJEkMV609U4ow4y5eYPcRTm7rbqqGFavKtQ/5CoIK8YPeAhutX
         PDAjKJWV29leDomRv2ers29ty1D+O0E+XczscblVI02wYUNzwJvq0gFQvN3ekSHqM9s3
         GO+FCjQQLQi4kWYq9wHHr65opAhrLCg85h3snsh+PMBeSmtjSgCsgS8Uf/phppUF3j92
         BaFcwodU0JsVxSzlmkp4P/Ydj+243hiKiprPG6rknEJkdR7pRrmDVmdJQSiK7xN5E5bP
         zQjkPwKB3JUxQv2VHso10Opp6Usm98LU1GGgZcPUEOaT4tAQA96YWJnZW7KVtBjq4L9p
         p5LA==
X-Forwarded-Encrypted: i=1; AJvYcCUj4Zdv9DWDjMBBNyYJf/fitoUV5JywGR9m4HqYYS22xhDsR2VPFLKgYQ8ajrTdAfTOlwc8+ymt@vger.kernel.org, AJvYcCXEemManOYn1ohOnP28y4cyVJnwI9L3xSdbONDtl4aggfmg95EWouvATVwnfaqLvuT/ST7ZVS16yWBZSwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAOTDOlxLEtmkit3VLxi/DN5idsxrqFwF66vtMkEW/YUtVoWuH
	Y17iM5CWzSvYXkx/pakqVwLFXmfCqsggHPZG79T9bTROyZIQTOkr
X-Gm-Gg: ASbGncuYIJ1CGrbwlubecnpPafTcmF2hJ2PPkYlShk9xDf1IHAUGtXU/z5sTEwcmv5V
	qu+s4YVebuvqLmED2+48wYh/Obgt13I9Hy8Wo9eE5u6+SEJz/Jzu2Zdt6cOsE7tjyNJyLosUMHs
	9HmFOkpu55qNoMAonw6PhqaGNQgaPGSDt2KbNSkto5xXuRRIYVw4C0WrLvVpidklyZZrRTZRKVR
	Ualb8G/o/2BzCFxJZCyzPFumrMvWHZQ0OlHEtsj2h1lRwYcyH4NteUxCupW9NRVCasekd2Qt8Ls
	harCTuzlzPYknR1T4d6zQS76LyXzHJCDo37vv8UbTNw0LC50wmYUrYblKtIqybfGtTrCHyBt1K2
	W5hQMHVjb4g==
X-Google-Smtp-Source: AGHT+IGYoTyBBqFICuMkH3mR4Fg8hmdezzL5DfQ1KcqV7+Ty4VNQeL8aQBID3P+joTDw2WBxubY1eQ==
X-Received: by 2002:a05:600c:4f4e:b0:43c:fae1:5151 with SMTP id 5b1f17b1804b1-43f2d9599efmr19305005e9.25.1744279479484;
        Thu, 10 Apr 2025 03:04:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f2066d109sm50193065e9.20.2025.04.10.03.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:04:39 -0700 (PDT)
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
	linux-mediatek@lists.infradead.org
Subject: [net-next PATCH v2 2/2] net: phy: mediatek: add Airoha PHY ID to SoC driver
Date: Thu, 10 Apr 2025 12:04:04 +0200
Message-ID: <20250410100410.348-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250410100410.348-1-ansuelsmth@gmail.com>
References: <20250410100410.348-1-ansuelsmth@gmail.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add Reviewed-by tag
- Address suggested dependency from Russell

 drivers/net/phy/mediatek/Kconfig      |  4 +-
 drivers/net/phy/mediatek/mtk-ge-soc.c | 62 +++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index 6a4c2b328c41..4308002bb82c 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -15,7 +15,9 @@ config MEDIATEK_GE_PHY
 
 config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
-	depends on (ARM64 && ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || COMPILE_TEST
+	depends on ARM64 || COMPILE_TEST
+	depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
+		   COMPILE_TEST
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


