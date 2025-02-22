Return-Path: <netdev+bounces-168736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA54A40662
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 09:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD7B19C02F3
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB20200BB4;
	Sat, 22 Feb 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQJUNSYl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAF2AF04
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213325; cv=none; b=hCkP//awSvpLhCrUpOiqjlsvP7xE7CLgSzm4mLvHHU5QWpna/tjYVL9nBaKev5UVCiC/LiK3CEvD8H4el4/PU5tuvzdcI2+Wa9thL1iLlVWY9nnn9i0HyzH/0OPtJkgVG5mFrVZsDTV/1iCI3WLsAk4Bkar+H6QpK72oWQY+mZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213325; c=relaxed/simple;
	bh=jHqO2HODQDU5zhCqpMyTPgrwTCbvTwjPEVq7o/j1vWU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bWjw4RCTRlpGMdRwtukUT6XZ9qXwk3MUUgBS/pDNHo8QMLwq3PPoTBFJC03KTBu4cUXMeZ55dpYU2bZMu8WAdu1wxuMGWeZrnaEysM/fjXu/xsdpmEqsSyjuImlSXieUHS1hi0GtfuTjWNDAkCKeT0Jt98T4+8g45pBAd8BduT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQJUNSYl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso3607520a12.2
        for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 00:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740213322; x=1740818122; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCeyw/OYck2yzJ+MuKnHBBNuftzEJudk6Yt0d5xSdp8=;
        b=MQJUNSYl0dlmbj6opGx/ju5+smiBkMQ81OKRmzCoNYoW7ONju8kujY+TBwTS0nkOLy
         h0hQfKoXNBLLv3GpYzB/vdFyFMm2thm7fuSnMrgaaoM3ONLgcutnr7sFNsDf6whMMUQ3
         c4vKGTRrx0VEiB+xbwBAMMa/wTbFvYgWLRP5ury5VC64eMCL6GdvN1ls6kbACiMFHGwt
         yro1259ZBrf85PVX5TB7PzI4l/UcMXTJnLLy62SPciTi/k04HiDg9p52ItNhfDUaQbHs
         Uzide3agmt4kgC8ZtnimVydgUijsstqSM/0tokIoOAIj9AXm27eYOLehp8yiJOcr9GPC
         VNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740213322; x=1740818122;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCeyw/OYck2yzJ+MuKnHBBNuftzEJudk6Yt0d5xSdp8=;
        b=fk7Gi6XQY7gi5MTj/c5gmGXeKtPL9ROWIc1IxSmhjHbKfE289kl6ZrQkkOUzVwwmgS
         CUjns7JQgCazhBlM/VirlYNFDWZtA4D04xMKCplzwBbqlheqzS41EYR9jeSwKzwscQxN
         EQ1jk4rGlBdWgx/Ueq7bs2gmxfiaXf7SsHCa3A6t6px/AXjQ7cyDSPmAKk/nsl8PuzYb
         QGCz4TtAMij2gDBU77FrQEXnyCV5NypTREVfLQkL2IWeaw98ABX1/HP+lAlmGgEPk2DN
         Kz62g4YLUbAiq+ZeuqU4pF0l6uj/g/2/QPU1dMjs1lZ2OIrXeBCfvTnPCkMnCNcULU/g
         YNmA==
X-Gm-Message-State: AOJu0YxG8agxAcErjK+K2CayfFx3DgnMb/XOM/5M7KmaMSRX0qhsWQ6D
	+XbAwtFFqJOhsWTcVjmmaUgSX950Yl6by9Euz63msqiAtU4x3USUNp0qOw==
X-Gm-Gg: ASbGncsPuESnqjzNFOYfRr0lA/l9bzDAom/DP1BAcEy3KMIRjcc9rAZ04X2pGQwo4WE
	iRWsUXRUBvv6MMAW4J/1BDWXw0Qge0kKl/VXCMn8miroZIHBU1ANo5o9kQdklrGNU3uol4btPTd
	cCRQ56m61rIYGm6Apzhm2BN5Hv5YWBuIoM9YBollmiAUmXNG8iz6jYs6CfyfdU0PNJcADNTlm+0
	WoRQnmW364yUEpWVkIdL3hmGTPM07k/HnLhoyYF2M0Sgw9zoDcKfrQ+RKRRhZO1N/lkPdhfHRcD
	i4xu8FTFDXj6yFIxluIrBhSMoFvBImVEj7fYmwHZCfoueTX4lso+NI9Wk4o7foo6GF5XObFlOVw
	uMqAQgv27ZLUzgYZvG9z6TDPBvbOOZ2AiS6Jz2McM65jz3x10Qm6XL4UCUoY10Zb+M9as+xTkhL
	pKCY+9kbuzMDgi7eu7ow==
X-Google-Smtp-Source: AGHT+IF33Uepd4diltq7kVeHRccRKHjNp6SLJJeORuNGU9Um1VzlVktZo1/kmwluNn/SNl3FpVZ2TA==
X-Received: by 2002:a05:6402:3815:b0:5de:b438:1fdb with SMTP id 4fb4d7f45d1cf-5e0b7266b9amr13234391a12.30.1740213321899;
        Sat, 22 Feb 2025 00:35:21 -0800 (PST)
Received: from ?IPV6:2a02:3100:a1a4:5e00:55c8:38f0:e9a8:fb41? (dynamic-2a02-3100-a1a4-5e00-55c8-38f0-e9a8-fb41.310.pool.telefonica.de. [2a02:3100:a1a4:5e00:55c8:38f0:e9a8:fb41])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287cebsm14875463a12.74.2025.02.22.00.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 00:35:20 -0800 (PST)
Message-ID: <082eacd2-a888-4716-8797-b3491ce02820@gmail.com>
Date: Sat, 22 Feb 2025 09:36:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] net: phy: add phylib-internal.h
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch is a starting point for moving phylib-internal
declarations to a private header file.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- fix spdx comment style
---
 drivers/net/phy/phy-c45.c          |  1 +
 drivers/net/phy/phy-core.c         |  3 ++-
 drivers/net/phy/phy.c              |  2 ++
 drivers/net/phy/phy_device.c       |  2 ++
 drivers/net/phy/phy_led_triggers.c |  2 ++
 drivers/net/phy/phylib-internal.h  | 25 +++++++++++++++++++++++++
 include/linux/phy.h                | 13 -------------
 7 files changed, 34 insertions(+), 14 deletions(-)
 create mode 100644 drivers/net/phy/phylib-internal.h

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 37c9a344b..0bcbdce38 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -9,6 +9,7 @@
 #include <linux/phy.h>
 
 #include "mdio-open-alliance.h"
+#include "phylib-internal.h"
 
 /**
  * genphy_c45_baset1_able - checks if the PMA has BASE-T1 extended abilities
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 2fd1d153a..b1c1670de 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -6,6 +6,8 @@
 #include <linux/phy.h>
 #include <linux/of.h>
 
+#include "phylib-internal.h"
+
 /**
  * phy_speed_to_str - Return a string representing the PHY link speed
  *
@@ -544,7 +546,6 @@ void phy_check_downshift(struct phy_device *phydev)
 
 	phydev->downshifted_rate = 1;
 }
-EXPORT_SYMBOL_GPL(phy_check_downshift);
 
 static int phy_resolve_min_speed(struct phy_device *phydev, bool fdx_only)
 {
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index b454e31d4..fd8d8dd29 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -36,6 +36,8 @@
 #include <net/genetlink.h>
 #include <net/sock.h>
 
+#include "phylib-internal.h"
+
 #define PHY_STATE_TIME	HZ
 
 #define PHY_STATE_STR(_state)			\
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 103a4d102..7d21379fa 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -41,6 +41,8 @@
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
 
+#include "phylib-internal.h"
+
 MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index f550576eb..bd3c9554f 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -5,6 +5,8 @@
 #include <linux/phy_led_triggers.h>
 #include <linux/netdevice.h>
 
+#include "phylib-internal.h"
+
 static struct phy_led_trigger *phy_speed_to_led_trigger(struct phy_device *phy,
 							unsigned int speed)
 {
diff --git a/drivers/net/phy/phylib-internal.h b/drivers/net/phy/phylib-internal.h
new file mode 100644
index 000000000..dc9592c6b
--- /dev/null
+++ b/drivers/net/phy/phylib-internal.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * phylib-internal header
+ */
+
+#ifndef __PHYLIB_INTERNAL_H
+#define __PHYLIB_INTERNAL_H
+
+struct phy_device;
+
+/*
+ * phy_supported_speeds - return all speeds currently supported by a PHY device
+ */
+unsigned int phy_supported_speeds(struct phy_device *phy,
+				  unsigned int *speeds,
+				  unsigned int size);
+void of_set_phy_supported(struct phy_device *phydev);
+void of_set_phy_eee_broken(struct phy_device *phydev);
+void of_set_phy_timing_role(struct phy_device *phydev);
+int phy_speed_down_core(struct phy_device *phydev);
+void phy_check_downshift(struct phy_device *phydev);
+
+int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
+
+#endif /* __PHYLIB_INTERNAL_H */
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c0f524579..3076b4caa 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -184,13 +184,6 @@ static inline void phy_interface_set_rgmii(unsigned long *intf)
 	__set_bit(PHY_INTERFACE_MODE_RGMII_TXID, intf);
 }
 
-/*
- * phy_supported_speeds - return all speeds currently supported by a PHY device
- */
-unsigned int phy_supported_speeds(struct phy_device *phy,
-				      unsigned int *speeds,
-				      unsigned int size);
-
 /**
  * phy_modes - map phy_interface_t enum to device tree binding of phy-mode
  * @interface: enum phy_interface_t value
@@ -1324,10 +1317,6 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask,
 		   bool exact);
 size_t phy_speeds(unsigned int *speeds, size_t size,
 		  unsigned long *mask);
-void of_set_phy_supported(struct phy_device *phydev);
-void of_set_phy_eee_broken(struct phy_device *phydev);
-void of_set_phy_timing_role(struct phy_device *phydev);
-int phy_speed_down_core(struct phy_device *phydev);
 
 /**
  * phy_is_started - Convenience function to check whether PHY is started
@@ -1353,7 +1342,6 @@ static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode
 
 void phy_resolve_aneg_pause(struct phy_device *phydev);
 void phy_resolve_aneg_linkmode(struct phy_device *phydev);
-void phy_check_downshift(struct phy_device *phydev);
 
 /**
  * phy_read - Convenience function for reading a given PHY register
@@ -2028,7 +2016,6 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data);
 int genphy_c45_an_config_eee_aneg(struct phy_device *phydev);
-int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
 
 /* Generic C45 PHY driver */
 extern struct phy_driver genphy_c45_driver;
-- 
2.48.1


