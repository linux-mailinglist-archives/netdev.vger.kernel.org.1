Return-Path: <netdev+bounces-158621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9A9A12BF6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BFD6188A576
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 19:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1AB1D63C9;
	Wed, 15 Jan 2025 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQR1ihUE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB211D618E
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736970434; cv=none; b=kihJciLEfB5WOjRgiZ+2vyCkgpE4ABgpvAQm6rrW1Iatj0UpZKd4sh7p4+NSrz/aq7hqFzjihn2Qo2Q6bMa9KibM0uwVAGWz6cgf8UEyTz+nQiwBLWK3eTNt5oNU9Haf5i/5EE/LPBZMppNypgyF/aIt16kkac/LkL9NGUzqDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736970434; c=relaxed/simple;
	bh=JcoBOLlZDFxc6w3ZGGX5fV9BvtX38EbLZkkoUF0zD+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mFVllL2uQtA5wP7eLAjYLyK8MJHikewNkcp/KaUYL0r7T99PHiPvh1icxvp/0dKSwNTM7r63xbauBlicNWwqmLFzOrN6GTpSoBvKEspchJ7zzo0Mw8e/pOCz0TFAbjGZU8VHGXC2W1wZwhuS17g4Q8NiHwpiR2qu7vEp4LL3NUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AQR1ihUE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434f398a171so72535e9.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736970431; x=1737575231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+HwjLRPW3qYzmyzCBBtyVwl3HhaHmrEDtXBLyx7UHGQ=;
        b=AQR1ihUE504XpdQqMYZGBgU2H7V7nBkUPh4IWwVVqBGZXY4lkWk2rMprqGaiD+L7m4
         KS7qI3jLRhaEGvnoMgYxnYBlRsTXpK7lhboqhN/H2d6Ka3EXp53XQotCzKkuPBPQIEUw
         MHFRqfi9imTX4zJ5rzGpUp23HJnNReudiwjeSYNaJRUgq6djQZZhKyq51g8ErFHBpeFs
         C2Ni6XWh04BN2hhtdVs3nroByFj5l7Qo6IKWbLA4RwTO0b+AdaaG5N79A1D5vwxrvZFd
         16Uv2/cFtyTITA4+HBpzw8N+y6kf4IGbxYOdYO4hejbwRwQuCd8YQlOfnNe5qZOGGtzJ
         NDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736970431; x=1737575231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HwjLRPW3qYzmyzCBBtyVwl3HhaHmrEDtXBLyx7UHGQ=;
        b=b2UH6pmEvPyq48XGXusiquzI/0HMhdr6qrPfNyaHWV/v7gu51jkhCS9X3qZXNrL5iO
         pmpOl6veC+2lfVSdY2ikwvTBwOX8criCGL7jTSvk2HFAPSmHB1D5SQgQRD4WPey+Nho1
         LrqTftyWsmVGkGM+yiW4rpCVMMyZvfHIcYXnafqXyXETr2g/1IuESZNo8semst0DjRe2
         lyoyf8XWqvDdNulRcCVEq0kfxnijclyHZZMuKZdwNLB6zsICUUacCqLInAGCI7CTxRbK
         4W7SudVA7Yp+ndhtUTRdGgJVift/csJR9pYx/ntc03pPNvkhJUeRWqz/rlJecGD8WO9c
         AIGA==
X-Forwarded-Encrypted: i=1; AJvYcCUBCoMBn/w23/AY9COkoZKku2YVxdudsTZZBNJ0hpJxl9rg4Yi0ldsVK9Vp0Hs2v3LzDQftBDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQWGPDnHHT+Q1LrLpBLy8SRjVLBWfof+g92VL7IkaOPZ+HkrT
	aTxws8JvbRZPZA1OC4UHmnrOrIA8+vXIkCtlncS5DSk/zR1kpCom4mXGFR1mkdY=
X-Gm-Gg: ASbGncv0Z/getuR4qjeX14KV7sQDpzLw6g9zCHkR2DLkRXsx/eFZsqCbwWaPaxrGObk
	jdvgqk3KJ9hUvRe6vBPWQ55a5vJwe9xH2KKmOq5qh1MSvO5kYj4Tg+KKeektr4mV7g1Cd+0XpN5
	wlGiqa3s3gq/XAoYWe+mUXgNqGOwRIlKZ2s5vl1/aDta81eizu5d5C82RGya8GomzZfppe4eBjc
	60Mjg7IkfT+4EGLkNa9Q2Z/ilUZT5IJJhEHnTTPKq/S/T3QEAc0+dok4H6NwPj4js1HwME=
X-Google-Smtp-Source: AGHT+IEwtfl9NZmzY+E0t5e6s2+QtV/BALzaojDV7VZf39tnjLx60qhVEo0NKESZxMiWM0MB4U1PZw==
X-Received: by 2002:a05:600c:4e52:b0:434:a339:ec67 with SMTP id 5b1f17b1804b1-436eba35780mr99818725e9.3.1736970431127;
        Wed, 15 Jan 2025 11:47:11 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38bd0dsm18327001f8f.45.2025.01.15.11.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 11:47:10 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dsa: Use str_enable_disable-like helpers
Date: Wed, 15 Jan 2025 20:47:03 +0100
Message-ID: <20250115194703.117074-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ternary (condition ? "enable" : "disable") syntax with helpers
from string_choices.h because:
1. Simple function call with one argument is easier to read.  Ternary
   operator has three arguments and with wrapping might lead to quite
   long code.
2. Is slightly shorter thus also easier to read.
3. It brings uniformity in the text - same string.
4. Allows deduping by the linker, which results in a smaller binary
   file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

I have more of similar patches in progress, but before I start spamming
you with this let me know if you find such code more readable, specially
for more complex conditions in ternary operators.


 drivers/net/dsa/mv88e6xxx/pcs-639x.c | 3 ++-
 drivers/net/dsa/mv88e6xxx/port.c     | 3 ++-
 drivers/net/dsa/realtek/rtl8366rb.c  | 7 ++++---
 3 files changed, 8 insertions(+), 5 deletions(-)


diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
index d758a6c1b226..dcec8ec16394 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/mii.h>
+#include <linux/string_choices.h>
 
 #include "chip.h"
 #include "global2.h"
@@ -748,7 +749,7 @@ static int mv88e6393x_sgmii_apply_2500basex_an(struct mv88e639x_pcs *mpcs,
 	if (err)
 		dev_err(mpcs->mdio.dev.parent,
 			"failed to %s 2500basex fix: %pe\n",
-			enable ? "enable" : "disable", ERR_PTR(err));
+			str_enable_disable(enable), ERR_PTR(err));
 
 	return err;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index dc777ddce1f3..66b1b7277281 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -13,6 +13,7 @@
 #include <linux/phy.h>
 #include <linux/phylink.h>
 #include <linux/property.h>
+#include <linux/string_choices.h>
 
 #include "chip.h"
 #include "global2.h"
@@ -176,7 +177,7 @@ int mv88e6xxx_port_set_link(struct mv88e6xxx_chip *chip, int port, int link)
 
 	dev_dbg(chip->dev, "p%d: %s link %s\n", port,
 		reg & MV88E6XXX_PORT_MAC_CTL_FORCE_LINK ? "Force" : "Unforce",
-		reg & MV88E6XXX_PORT_MAC_CTL_LINK_UP ? "up" : "down");
+		str_up_down(reg & MV88E6XXX_PORT_MAC_CTL_LINK_UP));
 
 	return 0;
 }
diff --git a/drivers/net/dsa/realtek/rtl8366rb.c b/drivers/net/dsa/realtek/rtl8366rb.c
index 23374178a176..4c4a95d4380c 100644
--- a/drivers/net/dsa/realtek/rtl8366rb.c
+++ b/drivers/net/dsa/realtek/rtl8366rb.c
@@ -21,6 +21,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of_irq.h>
 #include <linux/regmap.h>
+#include <linux/string_choices.h>
 
 #include "realtek.h"
 #include "realtek-smi.h"
@@ -1522,7 +1523,7 @@ static int rtl8366rb_vlan_filtering(struct dsa_switch *ds, int port,
 	rb = priv->chip_data;
 
 	dev_dbg(priv->dev, "port %d: %s VLAN filtering\n", port,
-		vlan_filtering ? "enable" : "disable");
+		str_enable_disable(vlan_filtering));
 
 	/* If the port is not in the member set, the frame will be dropped */
 	ret = regmap_update_bits(priv->map, RTL8366RB_VLAN_INGRESS_CTRL2_REG,
@@ -1884,7 +1885,7 @@ static bool rtl8366rb_is_vlan_valid(struct realtek_priv *priv, unsigned int vlan
 
 static int rtl8366rb_enable_vlan(struct realtek_priv *priv, bool enable)
 {
-	dev_dbg(priv->dev, "%s VLAN\n", enable ? "enable" : "disable");
+	dev_dbg(priv->dev, "%s VLAN\n", str_enable_disable(enable));
 	return regmap_update_bits(priv->map,
 				  RTL8366RB_SGCR, RTL8366RB_SGCR_EN_VLAN,
 				  enable ? RTL8366RB_SGCR_EN_VLAN : 0);
@@ -1892,7 +1893,7 @@ static int rtl8366rb_enable_vlan(struct realtek_priv *priv, bool enable)
 
 static int rtl8366rb_enable_vlan4k(struct realtek_priv *priv, bool enable)
 {
-	dev_dbg(priv->dev, "%s VLAN 4k\n", enable ? "enable" : "disable");
+	dev_dbg(priv->dev, "%s VLAN 4k\n", str_enable_disable(enable));
 	return regmap_update_bits(priv->map, RTL8366RB_SGCR,
 				  RTL8366RB_SGCR_EN_VLAN_4KTB,
 				  enable ? RTL8366RB_SGCR_EN_VLAN_4KTB : 0);
-- 
2.43.0


