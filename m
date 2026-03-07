Return-Path: <netdev+bounces-265190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJwKH1eZrGlarAEAu9opvQ
	(envelope-from <netdev+bounces-265190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:32:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D346222DB7D
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 845B9301C585
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C858291C33;
	Sat,  7 Mar 2026 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkG8++P9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8871C30AD00
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772919125; cv=none; b=Tx5fUIfrc/rUEjJnKOJPBZhSKEfnw8P0clU11FnvEUIQ2OkzyS7JKpzo+k1BGvXnDGVzbpvPVl3MGLXaO5p9IsZx7f513hS8wtfMBd2M+kjppdZwD5lNdCIOQFph481c1tw4RBK+e/BYZD1/5ythfKcX5Ycq7tcxKWndMIWpvzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772919125; c=relaxed/simple;
	bh=DLRqN/q3qIVsnLk7u7XdWcNSLPuqBIheDVAL8d+lPlA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=autD7TyNeYG6zT7bRSnjTYLnWF3TkvzbNllDMi40sM1+Pe8CV9acs85Qt1TO8ymfYQqaUVqndARy3hiFVcpqLfW6sn0MCi6ojNNzujpIeDBaqsvX6DHwbDVHKSp/Ry/06YGVsoX1VeHpKXu4OJlkyYoZujSgZDVEWXL/P9CMd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkG8++P9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-483487335c2so86741965e9.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772919122; x=1773523922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s76Dtklp9Y35SW5G+35vzg3Hwp8B5rcLHeq8coetQsM=;
        b=NkG8++P9xIPznJvkG4j5ISnBCrID+E0GjSWPfqf7O7T9a0EJsxP68GBilHMQjJaI0k
         KNu1owNlaORA44VaoiNPLOHx111/lVDudlcaJ78GR9g3wM+6koFtgK+UnMHSUOaYgcRN
         Qtnd9+pQRsNzgb/GzDPIEu7aXWF/2/+76tIMqbZaaHPpStTCNu3lkVyJCMQGR3YmpjhS
         F1dpj2Whqr8aGHsVt2AUFVZ7WqC2QvfWYAIc7KyWge4Of3gDQuvCf3Q5X/XslLh8/l4H
         WLorSE0h9FQmDGhqBy+ruaIofk88d6J2F4Y6OqdIv+xuxI3yePK4pksTPXAJYj6mjhlu
         MH8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772919122; x=1773523922;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s76Dtklp9Y35SW5G+35vzg3Hwp8B5rcLHeq8coetQsM=;
        b=jdpHoIebC3s9V2V165r1sVpqmG/ME+6CUqpO3BmGxKVptyLNRZrVkBH5b0TPsMB+I6
         khSy+ilitj4bVJfWBXAcTnEEQJ181r1+slsRgJHJJCxIhhQ+Glzmjt3SIMPXkhF5WmQ+
         tB+Xrkrz0nQk36uYA3PmTxcvalRCxuW353QpdGmMgkUqfQFFQynmcwn1vKAZIdkn+VBf
         Vfc0BMxjvcp8rsBTv64aRF8z0mSfMF8s2oEjQxWt2rmrxmMHDdvi3i6swNuU2m3bTh8d
         tUDE3gCCGYwEGeJlaD5jE9gjjBXp9oRd5RneSwzOYpSifAltFVY2e9jHInle1iP9RcaG
         fpeg==
X-Gm-Message-State: AOJu0YyMhET2O9Q4kt1qSS7WIunRATGSrwNTsDzKMUfThjn8M8mT6xi0
	4Il0seVWvBZeyMcn8QCNPGC3Us6JcaMCX0K0Hd7S7hgYol3WeoA8HId8
X-Gm-Gg: ATEYQzwZeNaCPU9CnGZmHZ4FQu9UNpmw3vq51Kgj/AYKy9ToYFOk9M0tv8kl/+lfQiH
	YHQS4QX/6gfuqO/FDtNhtdKTqgQIFqOBwiya0Wed7HhlO1uICZla2uNcNLkl2kFt3/hSla44Rrj
	YzmraSvqvpCzbaPiQxgH0hgFgQneOCLXve4M8ogFmzLI8CDwoyNuBJqrd4pI6PcHAi6DGOMtZoQ
	18TBq9OVvAHtFIGT8kPbg1etRYH9skmnp0b9eUYbGMqmw6tQRtcHRGvTx+Pn7Zg5GawEBjWESgr
	hywEcAmb0S3L1Pjsv2JAh4DBPCG31p3VNIdxW+iWCIpHiAMlW+tWD4DoE0MJ/hITOoudqi8q65N
	FdD96g69pMGBdkhsnO6oZ4WO+BOF9IB2G+3cQxYqJhyrDSU+7sXWN6TjAZXt2tFXujaoNAkFaM7
	OuRXIHXOfFJQEDHPNEpu2VGmYqzgqeXWHY2Lykc9oMTYS/cWYY81nskqdn8nDB/ryhEOY5kzkgU
	YD72CCIsdYyg/cGkf+UfwRhRXGF7SaM3pk8bldgySq8U4y+FnkUrJFlIVD+x0ePig==
X-Received: by 2002:a05:600c:a12:b0:482:df17:bbbc with SMTP id 5b1f17b1804b1-48526969710mr101723415e9.20.1772919121946;
        Sat, 07 Mar 2026 13:32:01 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0f:7f00:f48b:e818:2b17:74e3? (p200300ea8f0f7f00f48be8182b1774e3.dip0.t-ipconnect.de. [2003:ea:8f0f:7f00:f48b:e818:2b17:74e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48535863e40sm14453755e9.14.2026.03.07.13.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 13:32:01 -0800 (PST)
Message-ID: <8600cf79-7604-43c1-8cc0-306e58e31153@gmail.com>
Date: Sat, 7 Mar 2026 22:32:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/5] net: phy: make mdio_device.c part of libphy
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
References: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Content-Language: en-US
In-Reply-To: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D346222DB7D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265190-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.844];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This patch
- makes mdio_device.c part of libphy
- makes mdio_device_(un)register_reset() static
- moves mdiobus_(un)register_device() from mdio_bus.c to mdio_device.c,
  stops exporting both functions and makes them private to phylib

This further decouples the MDIO consumer functionality from libphy.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/Makefile          |  6 ++---
 drivers/net/phy/mdio-private.h    | 11 ---------
 drivers/net/phy/mdio_bus.c        | 36 ----------------------------
 drivers/net/phy/mdio_device.c     | 39 ++++++++++++++++++++++++++++---
 drivers/net/phy/phylib-internal.h |  4 ++++
 include/linux/mdio.h              |  2 --
 6 files changed, 43 insertions(+), 55 deletions(-)
 delete mode 100644 drivers/net/phy/mdio-private.h

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 3a34917adea..8d262b4e2be 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -3,8 +3,8 @@
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
 				   linkmode.o phy_link_topology.o \
-				   phy_caps.o mdio_bus_provider.o phy_port.o
-mdio-bus-y			+= mdio_bus.o mdio_device.o
+				   phy_caps.o mdio_bus_provider.o phy_port.o \
+				   mdio_device.o
 
 ifdef CONFIG_PHYLIB
 # built-in whenever PHYLIB is built-in or module
@@ -15,7 +15,7 @@ libphy-$(CONFIG_SWPHY)		+= swphy.o
 libphy-$(CONFIG_LED_TRIGGER_PHY)	+= phy_led_triggers.o
 libphy-$(CONFIG_OPEN_ALLIANCE_HELPERS) += open_alliance_helpers.o
 
-obj-$(CONFIG_MDIO_BUS)		+= mdio-bus.o
+obj-$(CONFIG_MDIO_BUS)		+= mdio_bus.o
 obj-$(CONFIG_PHYLINK)		+= phylink.o
 obj-$(CONFIG_PHYLIB)		+= libphy.o
 obj-$(CONFIG_PHYLIB)		+= mdio_devres.o
diff --git a/drivers/net/phy/mdio-private.h b/drivers/net/phy/mdio-private.h
deleted file mode 100644
index 8bc6d9088af..00000000000
--- a/drivers/net/phy/mdio-private.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef __MDIO_PRIVATE_H
-#define __MDIO_PRIVATE_H
-
-/* MDIO internal helpers
- */
-
-int mdio_device_register_reset(struct mdio_device *mdiodev);
-void mdio_device_unregister_reset(struct mdio_device *mdiodev);
-
-#endif /* __MDIO_PRIVATE_H */
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 48c0447e6a8..a30c679feec 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -29,46 +29,10 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/unistd.h>
-#include "mdio-private.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/mdio.h>
 
-int mdiobus_register_device(struct mdio_device *mdiodev)
-{
-	int err;
-
-	if (mdiodev->bus->mdio_map[mdiodev->addr])
-		return -EBUSY;
-
-	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
-		err = mdio_device_register_reset(mdiodev);
-		if (err)
-			return err;
-
-		/* Assert the reset signal */
-		mdio_device_reset(mdiodev, 1);
-	}
-
-	mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;
-
-	return 0;
-}
-EXPORT_SYMBOL(mdiobus_register_device);
-
-int mdiobus_unregister_device(struct mdio_device *mdiodev)
-{
-	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
-		return -EINVAL;
-
-	mdio_device_unregister_reset(mdiodev);
-
-	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
-
-	return 0;
-}
-EXPORT_SYMBOL(mdiobus_unregister_device);
-
 static struct mdio_device *mdiobus_find_device(struct mii_bus *bus, int addr)
 {
 	bool addr_valid = addr >= 0 && addr < ARRAY_SIZE(bus->mdio_map);
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index da4fb7484c7..56080d3d2d2 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -22,7 +22,7 @@
 #include <linux/string.h>
 #include <linux/unistd.h>
 #include <linux/property.h>
-#include "mdio-private.h"
+#include "phylib-internal.h"
 
 /**
  * mdio_device_register_reset - Read and initialize the reset properties of
@@ -31,7 +31,7 @@
  *
  * Return: Zero if successful, negative error code on failure
  */
-int mdio_device_register_reset(struct mdio_device *mdiodev)
+static int mdio_device_register_reset(struct mdio_device *mdiodev)
 {
 	struct reset_control *reset;
 
@@ -67,7 +67,7 @@ int mdio_device_register_reset(struct mdio_device *mdiodev)
  *				  an mdio device
  * @mdiodev: mdio_device structure
  */
-void mdio_device_unregister_reset(struct mdio_device *mdiodev)
+static void mdio_device_unregister_reset(struct mdio_device *mdiodev)
 {
 	gpiod_put(mdiodev->reset_gpio);
 	mdiodev->reset_gpio = NULL;
@@ -189,6 +189,39 @@ void mdio_device_remove(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL(mdio_device_remove);
 
+int mdiobus_register_device(struct mdio_device *mdiodev)
+{
+	int err;
+
+	if (mdiodev->bus->mdio_map[mdiodev->addr])
+		return -EBUSY;
+
+	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
+		err = mdio_device_register_reset(mdiodev);
+		if (err)
+			return err;
+
+		/* Assert the reset signal */
+		mdio_device_reset(mdiodev, 1);
+	}
+
+	mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;
+
+	return 0;
+}
+
+int mdiobus_unregister_device(struct mdio_device *mdiodev)
+{
+	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
+		return -EINVAL;
+
+	mdio_device_unregister_reset(mdiodev);
+
+	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
+
+	return 0;
+}
+
 /**
  * mdio_probe - probe an MDIO device
  * @dev: device to probe
diff --git a/drivers/net/phy/phylib-internal.h b/drivers/net/phy/phylib-internal.h
index dc9592c6bb8..bfb1aa82386 100644
--- a/drivers/net/phy/phylib-internal.h
+++ b/drivers/net/phy/phylib-internal.h
@@ -6,6 +6,7 @@
 #ifndef __PHYLIB_INTERNAL_H
 #define __PHYLIB_INTERNAL_H
 
+struct mdio_device;
 struct phy_device;
 
 /*
@@ -20,6 +21,9 @@ void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 void phy_check_downshift(struct phy_device *phydev);
 
+int mdiobus_register_device(struct mdio_device *mdiodev);
+int mdiobus_unregister_device(struct mdio_device *mdiodev);
+
 int genphy_c45_read_eee_adv(struct phy_device *phydev, unsigned long *adv);
 
 #endif /* __PHYLIB_INTERNAL_H */
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 5d1203b9af2..f4f9d960944 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -688,8 +688,6 @@ static inline int mdiodev_c45_write(struct mdio_device *mdiodev, u32 devad,
 				 val);
 }
 
-int mdiobus_register_device(struct mdio_device *mdiodev);
-int mdiobus_unregister_device(struct mdio_device *mdiodev);
 bool mdiobus_is_registered_device(struct mii_bus *bus, int addr);
 struct phy_device *mdiobus_get_phy(struct mii_bus *bus, int addr);
 
-- 
2.53.0



