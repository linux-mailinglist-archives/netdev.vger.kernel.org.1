Return-Path: <netdev+bounces-265655-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJGgE/v+rmkxLQIAu9opvQ
	(envelope-from <netdev+bounces-265655-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5A823D66D
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF0EB3055571
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3C92BEC5E;
	Mon,  9 Mar 2026 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7lMKMVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427428751B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075819; cv=none; b=BFzSlaFxqhs5XRI65Clwqqw7+oFtQbysMviPidSOw9g5S3pA6C3i5vYG3EJRPQzejUCVmpPHZ2pFQSPOt6IPQLX7DR3odpF7O0Kc7iNPxQVFMm2BDzGVJhIDD1vaVDXrYNKcL8eznnCjmS7gzLjJCuW/LnAh8WKpCpPbplewv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075819; c=relaxed/simple;
	bh=sQ7K5soRoUOhgRyuxlgiBIUIIJZnkhiW4dnZ/KDHenM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aNo+T7x9Se/NWUV4YLYmaVDLudvp+WX2TJ5DhMRMoRmseWGOR6yMWHNKRGJRAYTiKZBc5pwmYf2WEh6LK7/FgqAKWdLWRBXcNCzzmVavnfw5MdxrOU1CzLWIkNn+U4Qz2LB0VFz1/0xqwob5+xG+58oG/KnnAM+8Vctu58Wn8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7lMKMVw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48539cbb7b1so9906125e9.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773075813; x=1773680613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJ/4zcixQ1wTiiNvslj4zPcsegflsK4bmRP3vKhsaT8=;
        b=a7lMKMVwCWPcA5wWg2RDBtZzVOeI/vH6L/2jnJjgPgvGt+L72Sp7nSgCT4Y0kpjhda
         fuSSlrvax6rnmazlgPSMz6CKb0EC2GIqiXZ8EaZZuTjRf0Gh2+rZHg5vgmTDPsTiF4BL
         RDpSB/uGV5V747ztDxY9e07OLzLYOufOMdhN0XT3c8TO0ePDsV0CuyjsotRuqGVQ6hMj
         TQ1aEvmATlnKz6PzGtVBEXakNcfeVZFoJEOZ2mHYXCxtFyvBVTqEan4HxXfUOX60eZQl
         S6VXkkDmbZ5msIgOaRDCPXBdumO84N/3XtwVULyRoVzNi8STtMxc5RwltO5CH111QJap
         P1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075813; x=1773680613;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ/4zcixQ1wTiiNvslj4zPcsegflsK4bmRP3vKhsaT8=;
        b=SN9GDjHIbu2FwZN8srC6AKnY2Vu0aK0LEZZr64kmZ/S1SiZvh/aeNNSpjT6zWTBbv2
         YMC1bHNNAmNafQD/SMb0ltkBLgJjBDK6UUEcLxXsJ4Wl+af4DUTIqnoinAP0g6s2Eqre
         WJnv2W8yD/yNslx467+eM7BZuhbdAFMaOTi1TeleLJFMMWaTS8tDNSIgCsrui5dNvk6k
         XmsTdO49TpfmCdbVi6s/sxQKgqU695Ox3XpkcEIG8jPlCJvLt1IBtc4wVljV4ykQrbzD
         KzabNZLi94tlcubZg9K75pS4ps3FGyzDPzah0UJev4A6OIzh/1ZTY8y2vn77hRsiETyc
         MgSA==
X-Gm-Message-State: AOJu0YxvTjSqHvR7fQU90fs+Y9M0Jayqzl3oKi1Thol9aOiFAXYedikN
	gk3QTN9mPbqnakzO9I59OHobDYq/efMJuy+lXF8XlxYZfRgnuZBQeGjz
X-Gm-Gg: ATEYQzx7GKkplDc0vaiH+MggD8P9/BPhcjFHGvoIKAXiMggxY1+ut1tTSGaHJPEjFmm
	zBrjrnmGG1amSCaHuLmeEcBV26WtANQLiHAhTKXDE3pxTXNIJXbJKLjOGQKZwHiPtJZHNi6UmvQ
	JBIm3umecjMQWFo/pKTxV0aM+KZsy00EHueBPTWP12tB8h2NyxjqbzJ27I2poc61A2wnAJ5IbbH
	Ms0b3++RKsKmGb9qhuCWwthT6ghnD1FZMFAG0sKEO+FLjeJ9n5b4gpp+yCyEoN3DYdamA2nVOiC
	LW5+TCsqZohK2TyiT02aPISeu9hi8qeGRrCejetPDma33SILKue4q9HChjqFUdYxY4H+m+18uFa
	ERZuQTsWO+iQRMy6u888GeyvFFM88+ywTFJ2r3uC90Nf4gEGiWDfzhkn/bKqRtLnDClwr1xwJU8
	MmP6Mq/n3AHfMxNUAWATmrd+i6sE9LEWJ/o515z8OZE/9CKdtdE+GUqA9x7qgFiQjH1QWCjsuW6
	ObElkKflz81dyofB9vpv4XGx5pwhWdv+dNbc2R5koe0HLoi18Rs40yfy39UvTU=
X-Received: by 2002:a05:600c:8708:b0:485:3c8f:e4d3 with SMTP id 5b1f17b1804b1-4853c8fe6a0mr44130765e9.13.1773075812378;
        Mon, 09 Mar 2026 10:03:32 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f46:ce00:5f9:7f3c:5f9a:2a3d? (p200300ea8f46ce0005f97f3c5f9a2a3d.dip0.t-ipconnect.de. [2003:ea:8f46:ce00:5f9:7f3c:5f9a:2a3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48533d6151esm52252415e9.10.2026.03.09.10.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:03:31 -0700 (PDT)
Message-ID: <c6dbf9b3-3ca0-434b-ad3a-71fe602ab809@gmail.com>
Date: Mon, 9 Mar 2026 18:03:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 2/5] net: phy: make mdio_device.c part of libphy
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-clk@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <9d5724bc-e525-4f8f-b3f8-b16dd5a1164e@gmail.com>
Content-Language: en-US
In-Reply-To: <9d5724bc-e525-4f8f-b3f8-b16dd5a1164e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0D5A823D66D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-265655-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This patch
- makes mdio_device.c part of libphy
- makes mdio_device_(un)register_reset() static
- moves mdiobus_(un)register_device() from mdio_bus.c to mdio_device.c,
  stops exporting both functions and makes them private to phylib

This further decouples the MDIO consumer functionality from libphy.

Note: This makes MDIO driver registration part of phylib, therefore
      adjust Kconfig dependencies where needed.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- add needed Kconfig dependency changes
---
 drivers/clk/qcom/Kconfig          |  2 +-
 drivers/net/phy/Makefile          |  6 ++---
 drivers/net/phy/mdio-private.h    | 11 ---------
 drivers/net/phy/mdio_bus.c        | 36 ----------------------------
 drivers/net/phy/mdio_device.c     | 39 ++++++++++++++++++++++++++++---
 drivers/net/phy/phylib-internal.h |  4 ++++
 drivers/phy/broadcom/Kconfig      |  4 ++--
 include/linux/mdio.h              |  2 --
 8 files changed, 46 insertions(+), 58 deletions(-)
 delete mode 100644 drivers/net/phy/mdio-private.h

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index a8a86ea6bb7..a277c434d64 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -392,7 +392,7 @@ config IPQ_NSSCC_9574
 
 config IPQ_NSSCC_QCA8K
 	tristate "QCA8K(QCA8386 or QCA8084) NSS Clock Controller"
-	depends on MDIO_BUS
+	depends on PHYLIB
 	help
 	  Support for NSS(Network SubSystem) clock controller on
 	  qca8386/qca8084 chip.
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
diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index 1d89a2fd9b7..46371a8940d 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -52,7 +52,7 @@ config PHY_BCM_NS_USB3
 	tristate "Broadcom Northstar USB 3.0 PHY Driver"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
 	depends on HAS_IOMEM && OF
-	depends on MDIO_BUS
+	depends on PHYLIB
 	select GENERIC_PHY
 	help
 	  Enable this to support Broadcom USB 3.0 PHY connected to the USB
@@ -60,7 +60,7 @@ config PHY_BCM_NS_USB3
 
 config PHY_NS2_PCIE
 	tristate "Broadcom Northstar2 PCIe PHY driver"
-	depends on (OF && MDIO_BUS_MUX_BCM_IPROC) || (COMPILE_TEST && MDIO_BUS)
+	depends on (OF && MDIO_BUS_MUX_BCM_IPROC) || (COMPILE_TEST && PHYLIB)
 	select GENERIC_PHY
 	default ARCH_BCM_IPROC
 	help
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



