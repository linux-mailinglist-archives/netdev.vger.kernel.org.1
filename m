Return-Path: <netdev+bounces-222808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAFEB56308
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 23:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502EC56461A
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 21:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0264B27586B;
	Sat, 13 Sep 2025 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMaBPGfo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D52750E6
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757797675; cv=none; b=PmjmHjE0moDXXsu1AR5y3vjoYZ0TaCpEWc9Ooh3lijrrWkrJ2NWL7bTP7dTftMZJzqVu95wq17SbuH0YatrxCXwgCE6ZJquttNYAafLdKxV4M/woBYyd+bJSeHWsXMDq2mb5PdEwLKHyku0Qa03JRECMUdUxKEqDfLg9P/nRquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757797675; c=relaxed/simple;
	bh=6Me6MfAGl8eKVIycjUBD349ktvNC/VSMYi0Xi42UanY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lwa1K3Ogbw2Ipsio7uwbDULLkmjTbmo7xvpyH9XxNYXVKmF0ZGFT1Wftt/OII7a8ssvQHuavesZrol/pwPV39KoAOxl566LOhmLJd4qEoTzMZRUrAGdvyXaQSXiNbyfp2ci3P62g0LEL22FlIJ+hRM+PuVa2ulvMmVmFqD800hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMaBPGfo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e7643b0ab4so2007311f8f.2
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757797672; x=1758402472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TLcnJ47WCPT6J8/iMBRaW89OsooSw9hH1iKxSw92AyA=;
        b=UMaBPGfoEroRLGNsw9QLPwipp+nAx7zXoTcIVxAldt4h37Z5+igd75mkRUoZRpGKiW
         7YoJiHNWuoRxW1cyY//WXoDmZuVV4Akm3yjHflKHxyZ8RiWqhSORUGAwKFgBaoenZkme
         y7mwrikFXmgVAFP/UAIObmYM9wj0ukhJtoKDM6xXMgpWdgPV9stTmk6ObL2ekYA2dQ1w
         z8++A1sdkZZcdRjyN7yyFNKurrA2A3Ruoed5Ee8KUk4sfZcdmfa4o14Tz71T1xBv9UJ4
         f7vg94ZIXRKXaZyfy54On1NW0jIKxLcaQ4oVD0B5ky0BL0ewj9mVnKi3O8KUciGB6rrx
         7MUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757797672; x=1758402472;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLcnJ47WCPT6J8/iMBRaW89OsooSw9hH1iKxSw92AyA=;
        b=VsMPrENR/rb7xXOBZ1e17qtPqOvUzSqdL+700uSCW3NbcYkTRHf2ThoWU5hZoB75+7
         MnELgGY7TH35cfexTPUSJUrYXSUEnfu5LwZplMZfwJastPv1dFZG78m+8jnhgHv0YZnk
         2qL8l80w6tTH0maTDqDySfHCFlOZGtb4HqlqwvBcNuzpK6LX7XDEn5KExO3zh6ciK/jx
         gIp6+QnO+5hvGRaropTkL5qAV+yAY+TxpZRe9b7fhiIl60zISoFlJmo2TzTUdsiZczT9
         8OLxZ+sgWvHsC/L7uOpylumYH4bI20ec0dOmq0gwhhL3nyHttWq7Ix8t/eTMsvDYU0cY
         ng1A==
X-Gm-Message-State: AOJu0YwiUVWGyrSczsRHD2oFfg6XNbDGfwWdO+ZSOjTbECabohx0jlKC
	oborleIN/68a+hFhBm4s9//UqASyl1vR3XKv0PFE828YR0l8yM6E0CcH
X-Gm-Gg: ASbGncubohbfX+Y0Txp8ZjFtNZV3i7+oLf5WIMevESf8TxvsmKDym3Qr13FbQ6vTjgH
	KLzo/38us93fjSWvVPrFLBSGZrXyDBgT6eCpCItwovz/1rX8VHyiIFs8wrhF8vaAtoxm3EB9GdP
	niqkm1XcvD6CXbjD9inP3neFp81q+nHZOqa2MpfQN6WloUzSvk0EnrteEebow7XIac+Jy8D5qeB
	C6aDfoEdnfpPwtpBP++z7G/87JMeupsWvxnk7g4uihTrXTbfmRaJVmX1bnZb2tYpkh5Uf45AfFu
	T8odPjg1LH78ofljMqrhFvo/7RA/YSlv49YasWxnMAGMR1XqlXWnoIFgHRXDodcoOSoekyUzQFu
	JVYJddvCaMPscCQWp6f/Pb3EmlINAW137L76YtXo/K+eog+n2r/R9eceltiBRiHwWSBsgd4PqAx
	EkcF7NLtnEHWjcZDJshE3OfpyToSkna4FfKBz6+rlk9ON6NIiweBCvtXFgyRTAL0x+Qxa/CNIlu
	YSAUEt33ac=
X-Google-Smtp-Source: AGHT+IHZPFUCMJIcrA3gL0Ace9hMz7dmzxAIzpB2FeFp8jT2BIPmvZ3zF1QwNpObvP9XERDu+qdk5Q==
X-Received: by 2002:a05:6000:2885:b0:3e3:c5a8:a1be with SMTP id ffacd0b85a97d-3e76552eb61mr6548385f8f.0.1757797672000;
        Sat, 13 Sep 2025 14:07:52 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f24:8500:34bf:776f:e57e:cca6? (p200300ea8f24850034bf776fe57ecca6.dip0.t-ipconnect.de. [2003:ea:8f24:8500:34bf:776f:e57e:cca6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e8a68c443fsm3340438f8f.45.2025.09.13.14.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 14:07:50 -0700 (PDT)
Message-ID: <01542a2e-05f5-4f13-acef-72632b33b5be@gmail.com>
Date: Sat, 13 Sep 2025 23:08:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] net: phy: remove mdio_board_info support from
 phylib
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4ccf7476-0744-4f6b-aafc-7ba84d15a432@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <4ccf7476-0744-4f6b-aafc-7ba84d15a432@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After having removed mdio_board_info usage from dsa_loop, there's no
user left. So let's drop support for it from phylib.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/Makefile            |  2 +-
 drivers/net/phy/mdio-boardinfo.c    | 79 -----------------------------
 drivers/net/phy/mdio-boardinfo.h    | 18 -------
 drivers/net/phy/mdio_bus_provider.c | 33 ------------
 include/linux/phy.h                 | 10 ----
 5 files changed, 1 insertion(+), 141 deletions(-)
 delete mode 100644 drivers/net/phy/mdio-boardinfo.c
 delete mode 100644 drivers/net/phy/mdio-boardinfo.h

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 402a33d55..76e0db40f 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -8,7 +8,7 @@ mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_PHYLIB
 # built-in whenever PHYLIB is built-in or module
-obj-y				+= stubs.o mdio-boardinfo.o
+obj-y				+= stubs.o
 endif
 
 libphy-$(CONFIG_SWPHY)		+= swphy.o
diff --git a/drivers/net/phy/mdio-boardinfo.c b/drivers/net/phy/mdio-boardinfo.c
deleted file mode 100644
index d3184e8f1..000000000
--- a/drivers/net/phy/mdio-boardinfo.c
+++ /dev/null
@@ -1,79 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * mdio-boardinfo - Collect pre-declarations for MDIO devices
- */
-
-#include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/mutex.h>
-#include <linux/phy.h>
-#include <linux/slab.h>
-
-#include "mdio-boardinfo.h"
-
-static LIST_HEAD(mdio_board_list);
-static DEFINE_MUTEX(mdio_board_lock);
-
-struct mdio_board_entry {
-	struct list_head	list;
-	struct mdio_board_info	board_info;
-};
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
-	struct mdio_board_entry *be, *tmp;
-
-	mutex_lock(&mdio_board_lock);
-	list_for_each_entry_safe(be, tmp, &mdio_board_list, list) {
-		struct mdio_board_info *bi = &be->board_info;
-
-		if (strcmp(bus->id, bi->bus_id))
-			continue;
-
-		mutex_unlock(&mdio_board_lock);
-		cb(bus, bi);
-		mutex_lock(&mdio_board_lock);
-	}
-	mutex_unlock(&mdio_board_lock);
-}
-EXPORT_SYMBOL(mdiobus_setup_mdiodev_from_board_info);
-
-/**
- * mdiobus_register_board_info - register MDIO devices for a given board
- * @info: array of devices descriptors
- * @n: number of descriptors provided
- * Context: can sleep
- *
- * The board info passed can be marked with __initdata but be pointers
- * such as platform_data etc. are copied as-is
- */
-int mdiobus_register_board_info(const struct mdio_board_info *info,
-				unsigned int n)
-{
-	struct mdio_board_entry *be;
-
-	be = kcalloc(n, sizeof(*be), GFP_KERNEL);
-	if (!be)
-		return -ENOMEM;
-
-	for (int i = 0; i < n; i++, be++) {
-		be->board_info = info[i];
-		mutex_lock(&mdio_board_lock);
-		list_add_tail(&be->list, &mdio_board_list);
-		mutex_unlock(&mdio_board_lock);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(mdiobus_register_board_info);
diff --git a/drivers/net/phy/mdio-boardinfo.h b/drivers/net/phy/mdio-boardinfo.h
deleted file mode 100644
index 0878b7787..000000000
--- a/drivers/net/phy/mdio-boardinfo.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * mdio-boardinfo.h - board info interface internal to the mdio_bus
- * component
- */
-
-#ifndef __MDIO_BOARD_INFO_H
-#define __MDIO_BOARD_INFO_H
-
-struct mii_bus;
-struct mdio_board_info;
-
-void mdiobus_setup_mdiodev_from_board_info(struct mii_bus *bus,
-					   int (*cb)
-					   (struct mii_bus *bus,
-					    struct mdio_board_info *bi));
-
-#endif /* __MDIO_BOARD_INFO_H */
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index f43973e73..a2391d4b7 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -29,8 +29,6 @@
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
 
-#include "mdio-boardinfo.h"
-
 /**
  * mdiobus_alloc_size - allocate a mii_bus structure
  * @size: extra amount of memory to allocate for private storage.
@@ -132,35 +130,6 @@ static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
 }
 #endif
 
-/**
- * mdiobus_create_device - create a full MDIO device given
- * a mdio_board_info structure
- * @bus: MDIO bus to create the devices on
- * @bi: mdio_board_info structure describing the devices
- *
- * Returns 0 on success or < 0 on error.
- */
-static int mdiobus_create_device(struct mii_bus *bus,
-				 struct mdio_board_info *bi)
-{
-	struct mdio_device *mdiodev;
-	int ret = 0;
-
-	mdiodev = mdio_device_create(bus, bi->mdio_addr);
-	if (IS_ERR(mdiodev))
-		return -ENODEV;
-
-	strscpy(mdiodev->modalias, bi->modalias,
-		sizeof(mdiodev->modalias));
-	mdiodev->dev.platform_data = (void *)bi->platform_data;
-
-	ret = mdio_device_register(mdiodev);
-	if (ret)
-		mdio_device_free(mdiodev);
-
-	return ret;
-}
-
 static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
 {
 	struct phy_device *phydev = ERR_PTR(-ENODEV);
@@ -404,8 +373,6 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 			goto error;
 	}
 
-	mdiobus_setup_mdiodev_from_board_info(bus, mdiobus_create_device);
-
 	bus->state = MDIOBUS_REGISTERED;
 	dev_dbg(&bus->dev, "probed\n");
 	return 0;
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 04553419a..249aee317 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2116,16 +2116,6 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 extern const struct bus_type mdio_bus_type;
 extern const struct class mdio_bus_class;
 
-struct mdio_board_info {
-	const char	*bus_id;
-	char		modalias[MDIO_NAME_SIZE];
-	int		mdio_addr;
-	const void	*platform_data;
-};
-
-int mdiobus_register_board_info(const struct mdio_board_info *info,
-				unsigned int n);
-
 /**
  * phy_module_driver() - Helper macro for registering PHY drivers
  * @__phy_drivers: array of PHY drivers to register
-- 
2.51.0



