Return-Path: <netdev+bounces-190836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01514AB9093
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1F4C7AED25
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC027990E;
	Thu, 15 May 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEUqmuzj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEB31F153C
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339857; cv=none; b=kTz08HOm3EiDeEWxwl9+68cvBMYMHkNiufP1G5vEUVstp+dSG/TqeCP17WVqqu0mdmt3f/ZajXbyy6PuOwSchpRHUk+3H9CVk7L1062LEx2TQL0Ree0+k862HMB1pZdpOdJSnL++2QYKfH/yWcczX58WIC0XcUIPEY3QaMfvUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339857; c=relaxed/simple;
	bh=t/sYCR18yPaNYfpdPLlwzz+zMYfOk/JFwVHg1s5rvqQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bU13qTmiOuiAJVJXLKynyorXxiS9YJ5USZYBZlFpcoXo5+V1YyI2U22FF3W1vo2Befv4zSA23bo3thNuNBtALYNtDW8FIiMbCCXpX1UFoPVdeAtUWxtPjO44FPv1bLjqd4XjKEmrdBotc/yHR8gCxjgMTtq4Wk1rAVG1MPT7gRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEUqmuzj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso12841765e9.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 13:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747339854; x=1747944654; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsruiZr/xklW5KgYkNz6XWFInEvGanjIKH6LKlaCcaM=;
        b=KEUqmuzjFKzMyTM82wxbolI1A0dB6Fgm3jLW1qtOXTlizWdSH5+zb8pC7Ed0O+jGQG
         scQF+Xy+STPySh6bXzeJ4r22h0X62Zhkpdl7mwRpOBSpBWw9bpjpf6JUVTrjwo4jIqpP
         lB2TZaggL+ePfChaVmKIrI8KrWv+08NdmRadvwZM/2BSIir/auk3b0utUFJ046joVRwS
         IeI6gjK0Bhyf8jmxirBi6h8dxG2hkn67pNiCmqw+Uy/qyW4HfLaVhnUaDdHCj4G5f5nU
         EoAb4sQ3AjTd81A3E3jI+0hymRtRMmwXkiNXUqC8R+XmH9GCwVnsebOCXyfLTYC5St4x
         fWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747339854; x=1747944654;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsruiZr/xklW5KgYkNz6XWFInEvGanjIKH6LKlaCcaM=;
        b=XiMC9Rp/jwylqDBpvQGFKnFlIS+P4p/DXWu0/PAPfyNz6i6ivGQeVw3IPXumvzA/3f
         Zr7TH5czOGNGmXqMC1CxZ96vU3og8W8Y+04JRpTatuXJ5+8e+kjwrLZJRmpB4PLFbLlc
         X8T13+d2gPSQghz52+J9GfAR33g6A/7jNOy1gSj+mVP/FSM8LPUwdWbsKtwMXCgV2rR4
         2Z7d3uacXUjGkUw1bxgih61TySlyt8gVeC6+/ZajFfswwLIFEGViX2MkX7lm2L2CfHKd
         4JsH3LyB1Fh0luIsQX/qs9/H7Iq2CKm6srXLC6kjKepwovzsJh2OkURcm/8le/nfNxdP
         KwQQ==
X-Gm-Message-State: AOJu0Yz1eqRHpC/DOxqERmE3kEPN/iiYFLi0e0Dq60ac13aQnv/aQQRI
	6BXAZpsWI4Mh7GBdMhELkFDyn5Pqn/kkIa5t4Qs3xHvroGF+Skjf+W3TJ3mbBA==
X-Gm-Gg: ASbGnctL13vybGVYjCytR3K71Qzow/cfBrpChYYRgStEacjvEckNN3FcokUXGSLsz6V
	o+Ess88sU0k0b2h8aE18XYvtCottj22yETFcz2xjplZo/u8pXqqv9yfZLqgOFPWQZtoBdGh0r1z
	+H7ZteYo0GASCXbZBQ33LYz0n5COaVzB2i7o71SPZ9BME2VGiZ11tIJPYgRlv8ovgmPffUItkTU
	rxlBFGqSNeaJv/7KSbC5lpet5JJwxYSc2d3f3ufDl4t69xthBPQu9HxZHIP5E4kDT6NvdnzVDT2
	GcfKTae0L7BgIpxJDksKbN5bSfQrO1sYJCE9/qdtCQkW+TeQzYbIJwhvDLc8W7lXUmAamAJTpe9
	jOeSqDD3Yw8Qb4s9CteHMo6UUlpUPXCel03ouGsA0/CaUMecu2GMofda8BnTp7blzUUYOFqUvK2
	Ux7svbWg3C7g==
X-Google-Smtp-Source: AGHT+IFtrwI2XzJJb6Nxq+JaNYbuIhB9PKVq4GXnbS+auZxpX/k1JbKfNWZxPBRuDfwmJUupAuW57Q==
X-Received: by 2002:a5d:5848:0:b0:3a3:2aa4:6f6b with SMTP id ffacd0b85a97d-3a35c822afbmr1262325f8f.1.1747339854166;
        Thu, 15 May 2025 13:10:54 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:2300:ec36:b14d:f12:70b? (p200300ea8f4a2300ec36b14d0f12070b.dip0.t-ipconnect.de. [2003:ea:8f4a:2300:ec36:b14d:f12:70b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d224sm509779f8f.12.2025.05.15.13.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 13:10:53 -0700 (PDT)
Message-ID: <de5f64cb-1d9f-414e-b506-c924dd9f951d@gmail.com>
Date: Thu, 15 May 2025 22:11:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: move mdiobus_setup_mdiodev_from_board_info
 to mdio_bus_provider.c
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Move mdiobus_setup_mdiodev_from_board_info() to mdio_bus_provider.c.
Benefits are:
- The function doesn't have to be exported any longer and can be made
  static.
- We can call mdiobus_create_device() directly instead of passing it
  as a callback.

Only drawback is that now list and mutex have to be exported.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio-boardinfo.c    | 41 +++--------------------------
 drivers/net/phy/mdio-boardinfo.h    |  9 +++----
 drivers/net/phy/mdio_bus_provider.c | 26 +++++++++++++++++-
 3 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/drivers/net/phy/mdio-boardinfo.c b/drivers/net/phy/mdio-boardinfo.c
index 2de679a68..a52eaefe2 100644
--- a/drivers/net/phy/mdio-boardinfo.c
+++ b/drivers/net/phy/mdio-boardinfo.c
@@ -11,43 +11,10 @@

 #include "mdio-boardinfo.h"
 
-static LIST_HEAD(mdio_board_list);
-static DEFINE_MUTEX(mdio_board_lock);
-
-/**
- * mdiobus_setup_mdiodev_from_board_info - create and setup MDIO devices
- * from pre-collected board specific MDIO information
- * @bus: Bus the board_info belongs to
- * @cb: Callback to create device on bus
- * Context: can sleep
- */
-void mdiobus_setup_mdiodev_from_board_info(struct mii_bus *bus,
-					   int (*cb)
-					   (struct mii_bus *bus,
-					    struct mdio_board_info *bi))
-{
-	struct mdio_board_entry *be;
-	struct mdio_board_entry *tmp;
-	struct mdio_board_info *bi;
-	int ret;
-
-	mutex_lock(&mdio_board_lock);
-	list_for_each_entry_safe(be, tmp, &mdio_board_list, list) {
-		bi = &be->board_info;
-
-		if (strcmp(bus->id, bi->bus_id))
-			continue;
-
-		mutex_unlock(&mdio_board_lock);
-		ret = cb(bus, bi);
-		mutex_lock(&mdio_board_lock);
-		if (ret)
-			continue;
-
-	}
-	mutex_unlock(&mdio_board_lock);
-}
-EXPORT_SYMBOL(mdiobus_setup_mdiodev_from_board_info);
+LIST_HEAD(mdio_board_list);
+EXPORT_SYMBOL_GPL(mdio_board_list);
+DEFINE_MUTEX(mdio_board_lock);
+EXPORT_SYMBOL_GPL(mdio_board_lock);
 
 /**
  * mdiobus_register_board_info - register MDIO devices for a given board
diff --git a/drivers/net/phy/mdio-boardinfo.h b/drivers/net/phy/mdio-boardinfo.h
index 773bb5139..7488e3de2 100644
--- a/drivers/net/phy/mdio-boardinfo.h
+++ b/drivers/net/phy/mdio-boardinfo.h
@@ -7,17 +7,16 @@
 #ifndef __MDIO_BOARD_INFO_H
 #define __MDIO_BOARD_INFO_H
 
-#include <linux/phy.h>
+#include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/phy.h>
 
 struct mdio_board_entry {
 	struct list_head	list;
 	struct mdio_board_info	board_info;
 };
 
-void mdiobus_setup_mdiodev_from_board_info(struct mii_bus *bus,
-					   int (*cb)
-					   (struct mii_bus *bus,
-					    struct mdio_board_info *bi));
+extern struct list_head mdio_board_list;
+extern struct mutex mdio_board_lock;
 
 #endif /* __MDIO_BOARD_INFO_H */
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index 48dc4bf85..dd3219969 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -161,6 +161,30 @@ static int mdiobus_create_device(struct mii_bus *bus,
 	return ret;
 }
 
+/**
+ * mdiobus_setup_mdiodev_from_board_info - create and setup MDIO devices
+ * from pre-collected board specific MDIO information
+ * @bus: Bus the board_info belongs to
+ * Context: can sleep
+ */
+static void mdiobus_setup_mdiodev_from_board_info(struct mii_bus *bus)
+{
+	struct mdio_board_entry *be, *tmp;
+
+	mutex_lock(&mdio_board_lock);
+	list_for_each_entry_safe(be, tmp, &mdio_board_list, list) {
+		struct mdio_board_info *bi = &be->board_info;
+
+		if (strcmp(bus->id, bi->bus_id))
+			continue;
+
+		mutex_unlock(&mdio_board_lock);
+		mdiobus_create_device(bus, bi);
+		mutex_lock(&mdio_board_lock);
+	}
+	mutex_unlock(&mdio_board_lock);
+}
+
 static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
 {
 	struct phy_device *phydev = ERR_PTR(-ENODEV);
@@ -404,7 +428,7 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error;
 	}
 
-	mdiobus_setup_mdiodev_from_board_info(bus, mdiobus_create_device);
+	mdiobus_setup_mdiodev_from_board_info(bus);
 
 	bus->state = MDIOBUS_REGISTERED;
 	dev_dbg(&bus->dev, "probed\n");
-- 
2.49.0


