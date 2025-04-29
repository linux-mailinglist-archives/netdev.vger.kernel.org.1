Return-Path: <netdev+bounces-186657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C8AA0257
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 08:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFF646550A
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 06:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEC41AA782;
	Tue, 29 Apr 2025 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTSwe+XW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACE3FD1
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745906607; cv=none; b=fcbcOkuOVuzU3BMoiBwq43ZtHAAcAul4lx5z0NKfRihb3g2DXbohcXU0P4yfizxNE5sm7UPf0bAdFAfh2u1PV1aiLZIsMVhvW8EKT15G/sT3tvXvAYFF98B/qgg+td1GD/yMVZmCc/1w3uJIX/AwbYQBH/qsZJjxh20uUTpMuhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745906607; c=relaxed/simple;
	bh=Ums7kubkPJ/92/btu7l4bxXOc1bBDX4fCkWU7neVAuc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=U9z6eb2e4lNqajbGXbCrfCU5MiVvyHlzaKPTka1C35K6ANnSHqkCqNHUqLujxRKSMvG6hddAG28EG/iwkcmx4Io+qSNeI6/BxcqQmwCJ0Vn2dHiqzC91BsIQxOfVFh4PGWHF0bAyPY3ppObeISmJbwvMAy+090DV4mlWErcHWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTSwe+XW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso34747305e9.0
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745906603; x=1746511403; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7w7tQE/nDR2lHbLINhZQKOou+A5YMbCiZgmuCYz1j0=;
        b=DTSwe+XW0Uvl91Hk0dumf1Ij3E5xVuXIS8ruh4xK8r2rWlHfh5xO52TeTaVx4+0YSu
         Tdmd+n+k/4GYy7x7YoRyFG0LR7EzK32p+UjiwmvNyG55RfXoK2N09cnNkWIK+YUTJD2a
         GIjEideytdJgA4SV4ol2/5E9N/nQ/UchdVKV95gIUidOFGD4YWig5tc5rlyTim1UW3C6
         8d9udEAMjGPurfWKIeMtTr7P7QifChzIZjy+wtKre8mfSFr9HRDWOhdrPmR81iYKHgHf
         8PGZGj4ShtXe9+Dp8XwoPeOw+7OXoMd3TWXAB6gv6PgLxffElN8S0Lff8FPcMtLqFE9E
         MIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745906603; x=1746511403;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7w7tQE/nDR2lHbLINhZQKOou+A5YMbCiZgmuCYz1j0=;
        b=k3IlqTXeDao04JedMMG8McVhAB+kTbOcze5uKTBXmwY3j8B7wjt7HcLSNHJvDrJK6J
         2PDl2xRGTwmulNZV7yBj21rSKsoetGqJN+zaZrijSaTZxGggW8NdTx1HgD8dL6hpc8V2
         MqPTl0I2490E8mhiPnhLxXuw4prHws7DaROjt9wSC2kT7E+gTUlI7e9opfTkRD62Ejxg
         Z5mKdvLYPF586NREGFA5DsHnK3SSmAUEXc6TNgHXsuPkhn6QLfGCpOnYJflFBnOfkLku
         c4C+CdkkTy26YP+dhqdSW51JmlQV1V+ICPTYAa9PKoSIoBuQ3fVIOfnP0VAKDuUxz/vr
         hqWg==
X-Gm-Message-State: AOJu0YxC0JJZ0jbATUz/i7vXCZjA1wBzsHu/mHfxseFRqGhwzQSc/uPO
	NzZyyVKjXpsokr4gLsWVIaLtbByXy6FYFrgRdwj7PHOgVpRP9utkqqxeIg==
X-Gm-Gg: ASbGncvjRHW5ELt8V/bvqg3mkB+kwGCSMykgbdFhlbd8YsyvjtWwKToTH3FIliO/zfE
	IGaKBHMl0mGKyiLdbl5iYfn1Z82Yk1b/bvT5S6sAJukEOSzaPdQBSCLGuebdbfAVDY9NjHlk22p
	KiPMY32+xfenDuNAhoqFvxp3Cq1o/wl6txroqIwPF2IzRf3HXEO8IoBfYZCTELB/R3HWo6ruwSY
	JZhH3RGKPw4N09L5+lUXACkXT+WzNp2he/uKB61dYbPFCS2UPvXC92qWAEiw6GEeCwzSF9QVbYg
	/ejNDinJM3Fc2D7MtzAQr1pV5OoqKjfH3AgC/PAxM0QNOGdQepjD0sg87NBHBWXuZjmSvS77r7q
	Z1DO6BcKv1xI5k7pUXDKVQOS1p01MbdSWvfxzcK7D9DJ0Wz0rdisTnb7lEOPshGLieSNGjvaI6/
	gICw==
X-Google-Smtp-Source: AGHT+IGqT61pmvlly4xJbBp73IFfhmQHWldMxuTNRdPuTEQjSlaaKncbCixHoDl+jjID/rSdz3PSZw==
X-Received: by 2002:a05:600c:a41a:b0:43d:683:8caa with SMTP id 5b1f17b1804b1-441ac9a8851mr10317195e9.15.1745906602024;
        Mon, 28 Apr 2025 23:03:22 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f36:c100:15a9:157c:731:106b? (p200300ea8f36c10015a9157c0731106b.dip0.t-ipconnect.de. [2003:ea:8f36:c100:15a9:157c:731:106b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-440a0692a22sm163626635e9.2.2025.04.28.23.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 23:03:21 -0700 (PDT)
Message-ID: <c74772a9-dab6-44bf-a657-389df89d85c2@gmail.com>
Date: Tue, 29 Apr 2025 08:04:46 +0200
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
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] net: phy: factor out provider part from
 mdio_bus.c
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After 52358dd63e34 ("net: phy: remove function stubs") there's a
problem if CONFIG_MDIO_BUS is set, but CONFIG_PHYLIB is not.
mdiobus_scan() uses phylib functions like get_phy_device().
Bringing back the stub wouldn't make much sense, because it would
allow to compile mdiobus_scan(), but the function would be unusable.
The stub returned NULL, and we have the following in mdiobus_scan():

phydev = get_phy_device(bus, addr, c45);
        if (IS_ERR(phydev))
                return phydev;

So calling mdiobus_scan() w/o CONFIG_PHYLIB would cause a crash later in
mdiobus_scan(). In general the PHYLIB functionality isn't optional here.
Consequently, MDIO bus providers depend on PHYLIB.
Therefore factor it out and build it together with the libphy core
modules. In addition make all MDIO bus providers under /drivers/net/mdio
depend on PHYLIB. Same applies to enetc MDIO bus provider. Note that
PHYLIB selects MDIO_DEVRES, therefore we can omit this here.

Fixes: 52358dd63e34 ("net: phy: remove function stubs")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504270639.mT0lh2o1-lkp@intel.com/
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebased
---
 drivers/net/ethernet/freescale/enetc/Kconfig |   3 +-
 drivers/net/mdio/Kconfig                     |  16 +-
 drivers/net/phy/Makefile                     |   2 +-
 drivers/net/phy/mdio_bus.c                   | 462 +-----------------
 drivers/net/phy/mdio_bus_provider.c          | 484 +++++++++++++++++++
 include/linux/phy.h                          |   1 +
 6 files changed, 494 insertions(+), 474 deletions(-)
 create mode 100644 drivers/net/phy/mdio_bus_provider.c

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 5367e8af1..7250d3bbf 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -73,8 +73,7 @@ config FSL_ENETC_IERB
 
 config FSL_ENETC_MDIO
 	tristate "ENETC MDIO driver"
-	depends on PCI && MDIO_BUS
-	select MDIO_DEVRES
+	depends on PCI && PHYLIB
 	help
 	  This driver supports NXP ENETC Central MDIO controller as a PCIe
 	  physical function (PF) device.
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index f680ed676..107236cd6 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -19,30 +19,25 @@ config MDIO_BUS
 	  reflects whether the mdio_bus/mdio_device code is built as a
 	  loadable module or built-in.
 
+if PHYLIB
+
 config FWNODE_MDIO
-	def_tristate PHYLIB
-	depends on (ACPI || OF) || COMPILE_TEST
+	def_tristate (ACPI || OF) || COMPILE_TEST
 	select FIXED_PHY
 	help
 	  FWNODE MDIO bus (Ethernet PHY) accessors
 
 config OF_MDIO
-	def_tristate PHYLIB
-	depends on OF
-	depends on PHYLIB
+	def_tristate OF
 	select FIXED_PHY
 	help
 	  OpenFirmware MDIO bus (Ethernet PHY) accessors
 
 config ACPI_MDIO
-	def_tristate PHYLIB
-	depends on ACPI
-	depends on PHYLIB
+	def_tristate ACPI
 	help
 	  ACPI MDIO bus (Ethernet PHY) accessors
 
-if MDIO_BUS
-
 config MDIO_DEVRES
 	tristate
 
@@ -57,7 +52,6 @@ config MDIO_SUN4I
 config MDIO_XGENE
 	tristate "APM X-Gene SoC MDIO bus controller"
 	depends on ARCH_XGENE || COMPILE_TEST
-	depends on PHYLIB
 	help
 	  This module provides a driver for the MDIO busses found in the
 	  APM X-Gene SoC's.
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 23ce205ae..631859d44 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -3,7 +3,7 @@
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
 				   linkmode.o phy_link_topology.o \
-				   phy_package.o phy_caps.o
+				   phy_package.o phy_caps.o mdio_bus_provider.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_MDIO_DEVICE
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index ede596c1a..f5ccbe33a 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -8,17 +8,14 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/gpio/consumer.h>
 #include <linux/init.h>
-#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/micrel_phy.h>
 #include <linux/mii.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -27,7 +24,6 @@
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/reset.h>
-#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
@@ -37,8 +33,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/mdio.h>
 
-#include "mdio-boardinfo.h"
-
 static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
 {
 	/* Deassert the optional reset signal */
@@ -136,45 +130,6 @@ bool mdiobus_is_registered_device(struct mii_bus *bus, int addr)
 }
 EXPORT_SYMBOL(mdiobus_is_registered_device);
 
-/**
- * mdiobus_alloc_size - allocate a mii_bus structure
- * @size: extra amount of memory to allocate for private storage.
- * If non-zero, then bus->priv is points to that memory.
- *
- * Description: called by a bus driver to allocate an mii_bus
- * structure to fill in.
- */
-struct mii_bus *mdiobus_alloc_size(size_t size)
-{
-	struct mii_bus *bus;
-	size_t aligned_size = ALIGN(sizeof(*bus), NETDEV_ALIGN);
-	size_t alloc_size;
-	int i;
-
-	/* If we alloc extra space, it should be aligned */
-	if (size)
-		alloc_size = aligned_size + size;
-	else
-		alloc_size = sizeof(*bus);
-
-	bus = kzalloc(alloc_size, GFP_KERNEL);
-	if (!bus)
-		return NULL;
-
-	bus->state = MDIOBUS_ALLOCATED;
-	if (size)
-		bus->priv = (void *)bus + aligned_size;
-
-	/* Initialise the interrupts to polling and 64-bit seqcounts */
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		bus->irq[i] = PHY_POLL;
-		u64_stats_init(&bus->stats[i].syncp);
-	}
-
-	return bus;
-}
-EXPORT_SYMBOL(mdiobus_alloc_size);
-
 /**
  * mdiobus_release - mii_bus device release callback
  * @d: the target struct device that contains the mii_bus
@@ -403,11 +358,12 @@ static const struct attribute_group *mdio_bus_groups[] = {
 	NULL,
 };
 
-static struct class mdio_bus_class = {
+const struct class mdio_bus_class = {
 	.name		= "mdio_bus",
 	.dev_release	= mdiobus_release,
 	.dev_groups	= mdio_bus_groups,
 };
+EXPORT_SYMBOL_GPL(mdio_bus_class);
 
 /**
  * mdio_find_bus - Given the name of a mdiobus, find the mii_bus.
@@ -451,422 +407,8 @@ struct mii_bus *of_mdio_find_bus(struct device_node *mdio_bus_np)
 	return d ? to_mii_bus(d) : NULL;
 }
 EXPORT_SYMBOL(of_mdio_find_bus);
-
-/* Walk the list of subnodes of a mdio bus and look for a node that
- * matches the mdio device's address with its 'reg' property. If
- * found, set the of_node pointer for the mdio device. This allows
- * auto-probed phy devices to be supplied with information passed in
- * via DT.
- * If a PHY package is found, PHY is searched also there.
- */
-static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
-			       struct device_node *np)
-{
-	struct device_node *child;
-
-	for_each_available_child_of_node(np, child) {
-		int addr;
-
-		if (of_node_name_eq(child, "ethernet-phy-package")) {
-			/* Validate PHY package reg presence */
-			if (!of_property_present(child, "reg")) {
-				of_node_put(child);
-				return -EINVAL;
-			}
-
-			if (!of_mdiobus_find_phy(dev, mdiodev, child)) {
-				/* The refcount for the PHY package will be
-				 * incremented later when PHY join the Package.
-				 */
-				of_node_put(child);
-				return 0;
-			}
-
-			continue;
-		}
-
-		addr = of_mdio_parse_addr(dev, child);
-		if (addr < 0)
-			continue;
-
-		if (addr == mdiodev->addr) {
-			device_set_node(dev, of_fwnode_handle(child));
-			/* The refcount on "child" is passed to the mdio
-			 * device. Do _not_ use of_node_put(child) here.
-			 */
-			return 0;
-		}
-	}
-
-	return -ENODEV;
-}
-
-static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
-				    struct mdio_device *mdiodev)
-{
-	struct device *dev = &mdiodev->dev;
-
-	if (dev->of_node || !bus->dev.of_node)
-		return;
-
-	of_mdiobus_find_phy(dev, mdiodev, bus->dev.of_node);
-}
-#else /* !IS_ENABLED(CONFIG_OF_MDIO) */
-static inline void of_mdiobus_link_mdiodev(struct mii_bus *mdio,
-					   struct mdio_device *mdiodev)
-{
-}
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
-	mdiodev->bus_match = mdio_device_bus_match;
-	mdiodev->dev.platform_data = (void *)bi->platform_data;
-
-	ret = mdio_device_register(mdiodev);
-	if (ret)
-		mdio_device_free(mdiodev);
-
-	return ret;
-}
-
-static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
-{
-	struct phy_device *phydev = ERR_PTR(-ENODEV);
-	struct fwnode_handle *fwnode;
-	char node_name[16];
-	int err;
-
-	phydev = get_phy_device(bus, addr, c45);
-	if (IS_ERR(phydev))
-		return phydev;
-
-	/* For DT, see if the auto-probed phy has a corresponding child
-	 * in the bus node, and set the of_node pointer in this case.
-	 */
-	of_mdiobus_link_mdiodev(bus, &phydev->mdio);
-
-	/* Search for a swnode for the phy in the swnode hierarchy of the bus.
-	 * If there is no swnode for the phy provided, just ignore it.
-	 */
-	if (dev_fwnode(&bus->dev) && !dev_fwnode(&phydev->mdio.dev)) {
-		snprintf(node_name, sizeof(node_name), "ethernet-phy@%d",
-			 addr);
-		fwnode = fwnode_get_named_child_node(dev_fwnode(&bus->dev),
-						     node_name);
-		if (fwnode)
-			device_set_node(&phydev->mdio.dev, fwnode);
-	}
-
-	err = phy_device_register(phydev);
-	if (err) {
-		phy_device_free(phydev);
-		return ERR_PTR(-ENODEV);
-	}
-
-	return phydev;
-}
-
-/**
- * mdiobus_scan_c22 - scan one address on a bus for C22 MDIO devices.
- * @bus: mii_bus to scan
- * @addr: address on bus to scan
- *
- * This function scans one address on the MDIO bus, looking for
- * devices which can be identified using a vendor/product ID in
- * registers 2 and 3. Not all MDIO devices have such registers, but
- * PHY devices typically do. Hence this function assumes anything
- * found is a PHY, or can be treated as a PHY. Other MDIO devices,
- * such as switches, will probably not be found during the scan.
- */
-struct phy_device *mdiobus_scan_c22(struct mii_bus *bus, int addr)
-{
-	return mdiobus_scan(bus, addr, false);
-}
-EXPORT_SYMBOL(mdiobus_scan_c22);
-
-/**
- * mdiobus_scan_c45 - scan one address on a bus for C45 MDIO devices.
- * @bus: mii_bus to scan
- * @addr: address on bus to scan
- *
- * This function scans one address on the MDIO bus, looking for
- * devices which can be identified using a vendor/product ID in
- * registers 2 and 3. Not all MDIO devices have such registers, but
- * PHY devices typically do. Hence this function assumes anything
- * found is a PHY, or can be treated as a PHY. Other MDIO devices,
- * such as switches, will probably not be found during the scan.
- */
-static struct phy_device *mdiobus_scan_c45(struct mii_bus *bus, int addr)
-{
-	return mdiobus_scan(bus, addr, true);
-}
-
-static int mdiobus_scan_bus_c22(struct mii_bus *bus)
-{
-	int i;
-
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		if ((bus->phy_mask & BIT(i)) == 0) {
-			struct phy_device *phydev;
-
-			phydev = mdiobus_scan_c22(bus, i);
-			if (IS_ERR(phydev) && (PTR_ERR(phydev) != -ENODEV))
-				return PTR_ERR(phydev);
-		}
-	}
-	return 0;
-}
-
-static int mdiobus_scan_bus_c45(struct mii_bus *bus)
-{
-	int i;
-
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		if ((bus->phy_mask & BIT(i)) == 0) {
-			struct phy_device *phydev;
-
-			/* Don't scan C45 if we already have a C22 device */
-			if (bus->mdio_map[i])
-				continue;
-
-			phydev = mdiobus_scan_c45(bus, i);
-			if (IS_ERR(phydev) && (PTR_ERR(phydev) != -ENODEV))
-				return PTR_ERR(phydev);
-		}
-	}
-	return 0;
-}
-
-/* There are some C22 PHYs which do bad things when where is a C45
- * transaction on the bus, like accepting a read themselves, and
- * stomping over the true devices reply, to performing a write to
- * themselves which was intended for another device. Now that C22
- * devices have been found, see if any of them are bad for C45, and if we
- * should skip the C45 scan.
- */
-static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
-{
-	int i;
-
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		struct phy_device *phydev;
-		u32 oui;
-
-		phydev = mdiobus_get_phy(bus, i);
-		if (!phydev)
-			continue;
-		oui = phydev->phy_id >> 10;
-
-		if (oui == MICREL_OUI)
-			return true;
-	}
-	return false;
-}
-
-/**
- * __mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
- * @bus: target mii_bus
- * @owner: module containing bus accessor functions
- *
- * Description: Called by a bus driver to bring up all the PHYs
- *   on a given bus, and attach them to the bus. Drivers should use
- *   mdiobus_register() rather than __mdiobus_register() unless they
- *   need to pass a specific owner module. MDIO devices which are not
- *   PHYs will not be brought up by this function. They are expected
- *   to be explicitly listed in DT and instantiated by of_mdiobus_register().
- *
- * Returns 0 on success or < 0 on error.
- */
-int __mdiobus_register(struct mii_bus *bus, struct module *owner)
-{
-	struct mdio_device *mdiodev;
-	struct gpio_desc *gpiod;
-	bool prevent_c45_scan;
-	int i, err;
-
-	if (!bus || !bus->name)
-		return -EINVAL;
-
-	/* An access method always needs both read and write operations */
-	if (!!bus->read != !!bus->write || !!bus->read_c45 != !!bus->write_c45)
-		return -EINVAL;
-
-	/* At least one method is mandatory */
-	if (!bus->read && !bus->read_c45)
-		return -EINVAL;
-
-	if (bus->parent && bus->parent->of_node)
-		bus->parent->of_node->fwnode.flags |=
-					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
-
-	WARN(bus->state != MDIOBUS_ALLOCATED &&
-	     bus->state != MDIOBUS_UNREGISTERED,
-	     "%s: not in ALLOCATED or UNREGISTERED state\n", bus->id);
-
-	bus->owner = owner;
-	bus->dev.parent = bus->parent;
-	bus->dev.class = &mdio_bus_class;
-	bus->dev.groups = NULL;
-	dev_set_name(&bus->dev, "%s", bus->id);
-
-	/* If the bus state is allocated, we're registering a fresh bus
-	 * that may have a fwnode associated with it. Grab a reference
-	 * to the fwnode. This will be dropped when the bus is released.
-	 * If the bus was set to unregistered, it means that the bus was
-	 * previously registered, and we've already grabbed a reference.
-	 */
-	if (bus->state == MDIOBUS_ALLOCATED)
-		fwnode_handle_get(dev_fwnode(&bus->dev));
-
-	/* We need to set state to MDIOBUS_UNREGISTERED to correctly release
-	 * the device in mdiobus_free()
-	 *
-	 * State will be updated later in this function in case of success
-	 */
-	bus->state = MDIOBUS_UNREGISTERED;
-
-	err = device_register(&bus->dev);
-	if (err) {
-		pr_err("mii_bus %s failed to register\n", bus->id);
-		return -EINVAL;
-	}
-
-	mutex_init(&bus->mdio_lock);
-	mutex_init(&bus->shared_lock);
-
-	/* assert bus level PHY GPIO reset */
-	gpiod = devm_gpiod_get_optional(&bus->dev, "reset", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpiod)) {
-		err = dev_err_probe(&bus->dev, PTR_ERR(gpiod),
-				    "mii_bus %s couldn't get reset GPIO\n",
-				    bus->id);
-		device_del(&bus->dev);
-		return err;
-	} else	if (gpiod) {
-		bus->reset_gpiod = gpiod;
-		fsleep(bus->reset_delay_us);
-		gpiod_set_value_cansleep(gpiod, 0);
-		if (bus->reset_post_delay_us > 0)
-			fsleep(bus->reset_post_delay_us);
-	}
-
-	if (bus->reset) {
-		err = bus->reset(bus);
-		if (err)
-			goto error_reset_gpiod;
-	}
-
-	if (bus->read) {
-		err = mdiobus_scan_bus_c22(bus);
-		if (err)
-			goto error;
-	}
-
-	prevent_c45_scan = mdiobus_prevent_c45_scan(bus);
-
-	if (!prevent_c45_scan && bus->read_c45) {
-		err = mdiobus_scan_bus_c45(bus);
-		if (err)
-			goto error;
-	}
-
-	mdiobus_setup_mdiodev_from_board_info(bus, mdiobus_create_device);
-
-	bus->state = MDIOBUS_REGISTERED;
-	dev_dbg(&bus->dev, "probed\n");
-	return 0;
-
-error:
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		mdiodev = bus->mdio_map[i];
-		if (!mdiodev)
-			continue;
-
-		mdiodev->device_remove(mdiodev);
-		mdiodev->device_free(mdiodev);
-	}
-error_reset_gpiod:
-	/* Put PHYs in RESET to save power */
-	if (bus->reset_gpiod)
-		gpiod_set_value_cansleep(bus->reset_gpiod, 1);
-
-	device_del(&bus->dev);
-	return err;
-}
-EXPORT_SYMBOL(__mdiobus_register);
-
-void mdiobus_unregister(struct mii_bus *bus)
-{
-	struct mdio_device *mdiodev;
-	int i;
-
-	if (WARN_ON_ONCE(bus->state != MDIOBUS_REGISTERED))
-		return;
-	bus->state = MDIOBUS_UNREGISTERED;
-
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		mdiodev = bus->mdio_map[i];
-		if (!mdiodev)
-			continue;
-
-		if (mdiodev->reset_gpio)
-			gpiod_put(mdiodev->reset_gpio);
-
-		mdiodev->device_remove(mdiodev);
-		mdiodev->device_free(mdiodev);
-	}
-
-	/* Put PHYs in RESET to save power */
-	if (bus->reset_gpiod)
-		gpiod_set_value_cansleep(bus->reset_gpiod, 1);
-
-	device_del(&bus->dev);
-}
-EXPORT_SYMBOL(mdiobus_unregister);
-
-/**
- * mdiobus_free - free a struct mii_bus
- * @bus: mii_bus to free
- *
- * This function releases the reference to the underlying device
- * object in the mii_bus.  If this is the last reference, the mii_bus
- * will be freed.
- */
-void mdiobus_free(struct mii_bus *bus)
-{
-	/* For compatibility with error handling in drivers. */
-	if (bus->state == MDIOBUS_ALLOCATED) {
-		kfree(bus);
-		return;
-	}
-
-	WARN(bus->state != MDIOBUS_UNREGISTERED,
-	     "%s: not in UNREGISTERED state\n", bus->id);
-	bus->state = MDIOBUS_RELEASED;
-
-	put_device(&bus->dev);
-}
-EXPORT_SYMBOL(mdiobus_free);
-
 static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
 {
 	preempt_disable();
diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
new file mode 100644
index 000000000..65850e362
--- /dev/null
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* MDIO Bus provider interface
+ *
+ * Author: Andy Fleming
+ *
+ * Copyright (c) 2004 Freescale Semiconductor, Inc.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/gpio/consumer.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/micrel_phy.h>
+#include <linux/mii.h>
+#include <linux/mm.h>
+#include <linux/netdevice.h>
+#include <linux/of_device.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/unistd.h>
+
+#include "mdio-boardinfo.h"
+
+/**
+ * mdiobus_alloc_size - allocate a mii_bus structure
+ * @size: extra amount of memory to allocate for private storage.
+ * If non-zero, then bus->priv is points to that memory.
+ *
+ * Description: called by a bus driver to allocate an mii_bus
+ * structure to fill in.
+ */
+struct mii_bus *mdiobus_alloc_size(size_t size)
+{
+	struct mii_bus *bus;
+	size_t aligned_size = ALIGN(sizeof(*bus), NETDEV_ALIGN);
+	size_t alloc_size;
+	int i;
+
+	/* If we alloc extra space, it should be aligned */
+	if (size)
+		alloc_size = aligned_size + size;
+	else
+		alloc_size = sizeof(*bus);
+
+	bus = kzalloc(alloc_size, GFP_KERNEL);
+	if (!bus)
+		return NULL;
+
+	bus->state = MDIOBUS_ALLOCATED;
+	if (size)
+		bus->priv = (void *)bus + aligned_size;
+
+	/* Initialise the interrupts to polling and 64-bit seqcounts */
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		bus->irq[i] = PHY_POLL;
+		u64_stats_init(&bus->stats[i].syncp);
+	}
+
+	return bus;
+}
+EXPORT_SYMBOL(mdiobus_alloc_size);
+
+#if IS_ENABLED(CONFIG_OF_MDIO)
+/* Walk the list of subnodes of a mdio bus and look for a node that
+ * matches the mdio device's address with its 'reg' property. If
+ * found, set the of_node pointer for the mdio device. This allows
+ * auto-probed phy devices to be supplied with information passed in
+ * via DT.
+ * If a PHY package is found, PHY is searched also there.
+ */
+static int of_mdiobus_find_phy(struct device *dev, struct mdio_device *mdiodev,
+			       struct device_node *np)
+{
+	struct device_node *child;
+
+	for_each_available_child_of_node(np, child) {
+		int addr;
+
+		if (of_node_name_eq(child, "ethernet-phy-package")) {
+			/* Validate PHY package reg presence */
+			if (!of_property_present(child, "reg")) {
+				of_node_put(child);
+				return -EINVAL;
+			}
+
+			if (!of_mdiobus_find_phy(dev, mdiodev, child)) {
+				/* The refcount for the PHY package will be
+				 * incremented later when PHY join the Package.
+				 */
+				of_node_put(child);
+				return 0;
+			}
+
+			continue;
+		}
+
+		addr = of_mdio_parse_addr(dev, child);
+		if (addr < 0)
+			continue;
+
+		if (addr == mdiodev->addr) {
+			device_set_node(dev, of_fwnode_handle(child));
+			/* The refcount on "child" is passed to the mdio
+			 * device. Do _not_ use of_node_put(child) here.
+			 */
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
+static void of_mdiobus_link_mdiodev(struct mii_bus *bus,
+				    struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+
+	if (dev->of_node || !bus->dev.of_node)
+		return;
+
+	of_mdiobus_find_phy(dev, mdiodev, bus->dev.of_node);
+}
+#endif
+
+/**
+ * mdiobus_create_device - create a full MDIO device given
+ * a mdio_board_info structure
+ * @bus: MDIO bus to create the devices on
+ * @bi: mdio_board_info structure describing the devices
+ *
+ * Returns 0 on success or < 0 on error.
+ */
+static int mdiobus_create_device(struct mii_bus *bus,
+				 struct mdio_board_info *bi)
+{
+	struct mdio_device *mdiodev;
+	int ret = 0;
+
+	mdiodev = mdio_device_create(bus, bi->mdio_addr);
+	if (IS_ERR(mdiodev))
+		return -ENODEV;
+
+	strscpy(mdiodev->modalias, bi->modalias,
+		sizeof(mdiodev->modalias));
+	mdiodev->bus_match = mdio_device_bus_match;
+	mdiodev->dev.platform_data = (void *)bi->platform_data;
+
+	ret = mdio_device_register(mdiodev);
+	if (ret)
+		mdio_device_free(mdiodev);
+
+	return ret;
+}
+
+static struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr, bool c45)
+{
+	struct phy_device *phydev = ERR_PTR(-ENODEV);
+	struct fwnode_handle *fwnode;
+	char node_name[16];
+	int err;
+
+	phydev = get_phy_device(bus, addr, c45);
+	if (IS_ERR(phydev))
+		return phydev;
+
+#if IS_ENABLED(CONFIG_OF_MDIO)
+	/* For DT, see if the auto-probed phy has a corresponding child
+	 * in the bus node, and set the of_node pointer in this case.
+	 */
+	of_mdiobus_link_mdiodev(bus, &phydev->mdio);
+#endif
+
+	/* Search for a swnode for the phy in the swnode hierarchy of the bus.
+	 * If there is no swnode for the phy provided, just ignore it.
+	 */
+	if (dev_fwnode(&bus->dev) && !dev_fwnode(&phydev->mdio.dev)) {
+		snprintf(node_name, sizeof(node_name), "ethernet-phy@%d",
+			 addr);
+		fwnode = fwnode_get_named_child_node(dev_fwnode(&bus->dev),
+						     node_name);
+		if (fwnode)
+			device_set_node(&phydev->mdio.dev, fwnode);
+	}
+
+	err = phy_device_register(phydev);
+	if (err) {
+		phy_device_free(phydev);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return phydev;
+}
+
+/**
+ * mdiobus_scan_c22 - scan one address on a bus for C22 MDIO devices.
+ * @bus: mii_bus to scan
+ * @addr: address on bus to scan
+ *
+ * This function scans one address on the MDIO bus, looking for
+ * devices which can be identified using a vendor/product ID in
+ * registers 2 and 3. Not all MDIO devices have such registers, but
+ * PHY devices typically do. Hence this function assumes anything
+ * found is a PHY, or can be treated as a PHY. Other MDIO devices,
+ * such as switches, will probably not be found during the scan.
+ */
+struct phy_device *mdiobus_scan_c22(struct mii_bus *bus, int addr)
+{
+	return mdiobus_scan(bus, addr, false);
+}
+EXPORT_SYMBOL(mdiobus_scan_c22);
+
+/**
+ * mdiobus_scan_c45 - scan one address on a bus for C45 MDIO devices.
+ * @bus: mii_bus to scan
+ * @addr: address on bus to scan
+ *
+ * This function scans one address on the MDIO bus, looking for
+ * devices which can be identified using a vendor/product ID in
+ * registers 2 and 3. Not all MDIO devices have such registers, but
+ * PHY devices typically do. Hence this function assumes anything
+ * found is a PHY, or can be treated as a PHY. Other MDIO devices,
+ * such as switches, will probably not be found during the scan.
+ */
+static struct phy_device *mdiobus_scan_c45(struct mii_bus *bus, int addr)
+{
+	return mdiobus_scan(bus, addr, true);
+}
+
+static int mdiobus_scan_bus_c22(struct mii_bus *bus)
+{
+	int i;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		if ((bus->phy_mask & BIT(i)) == 0) {
+			struct phy_device *phydev;
+
+			phydev = mdiobus_scan_c22(bus, i);
+			if (IS_ERR(phydev) && (PTR_ERR(phydev) != -ENODEV))
+				return PTR_ERR(phydev);
+		}
+	}
+	return 0;
+}
+
+static int mdiobus_scan_bus_c45(struct mii_bus *bus)
+{
+	int i;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		if ((bus->phy_mask & BIT(i)) == 0) {
+			struct phy_device *phydev;
+
+			/* Don't scan C45 if we already have a C22 device */
+			if (bus->mdio_map[i])
+				continue;
+
+			phydev = mdiobus_scan_c45(bus, i);
+			if (IS_ERR(phydev) && (PTR_ERR(phydev) != -ENODEV))
+				return PTR_ERR(phydev);
+		}
+	}
+	return 0;
+}
+
+/* There are some C22 PHYs which do bad things when where is a C45
+ * transaction on the bus, like accepting a read themselves, and
+ * stomping over the true devices reply, to performing a write to
+ * themselves which was intended for another device. Now that C22
+ * devices have been found, see if any of them are bad for C45, and if we
+ * should skip the C45 scan.
+ */
+static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
+{
+	int i;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		struct phy_device *phydev;
+		u32 oui;
+
+		phydev = mdiobus_get_phy(bus, i);
+		if (!phydev)
+			continue;
+		oui = phydev->phy_id >> 10;
+
+		if (oui == MICREL_OUI)
+			return true;
+	}
+	return false;
+}
+
+/**
+ * __mdiobus_register - bring up all the PHYs on a given bus and attach them to bus
+ * @bus: target mii_bus
+ * @owner: module containing bus accessor functions
+ *
+ * Description: Called by a bus driver to bring up all the PHYs
+ *   on a given bus, and attach them to the bus. Drivers should use
+ *   mdiobus_register() rather than __mdiobus_register() unless they
+ *   need to pass a specific owner module. MDIO devices which are not
+ *   PHYs will not be brought up by this function. They are expected
+ *   to be explicitly listed in DT and instantiated by of_mdiobus_register().
+ *
+ * Returns 0 on success or < 0 on error.
+ */
+int __mdiobus_register(struct mii_bus *bus, struct module *owner)
+{
+	struct mdio_device *mdiodev;
+	struct gpio_desc *gpiod;
+	bool prevent_c45_scan;
+	int i, err;
+
+	if (!bus || !bus->name)
+		return -EINVAL;
+
+	/* An access method always needs both read and write operations */
+	if (!!bus->read != !!bus->write || !!bus->read_c45 != !!bus->write_c45)
+		return -EINVAL;
+
+	/* At least one method is mandatory */
+	if (!bus->read && !bus->read_c45)
+		return -EINVAL;
+
+	if (bus->parent && bus->parent->of_node)
+		bus->parent->of_node->fwnode.flags |=
+					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
+
+	WARN(bus->state != MDIOBUS_ALLOCATED &&
+	     bus->state != MDIOBUS_UNREGISTERED,
+	     "%s: not in ALLOCATED or UNREGISTERED state\n", bus->id);
+
+	bus->owner = owner;
+	bus->dev.parent = bus->parent;
+	bus->dev.class = &mdio_bus_class;
+	bus->dev.groups = NULL;
+	dev_set_name(&bus->dev, "%s", bus->id);
+
+	/* If the bus state is allocated, we're registering a fresh bus
+	 * that may have a fwnode associated with it. Grab a reference
+	 * to the fwnode. This will be dropped when the bus is released.
+	 * If the bus was set to unregistered, it means that the bus was
+	 * previously registered, and we've already grabbed a reference.
+	 */
+	if (bus->state == MDIOBUS_ALLOCATED)
+		fwnode_handle_get(dev_fwnode(&bus->dev));
+
+	/* We need to set state to MDIOBUS_UNREGISTERED to correctly release
+	 * the device in mdiobus_free()
+	 *
+	 * State will be updated later in this function in case of success
+	 */
+	bus->state = MDIOBUS_UNREGISTERED;
+
+	err = device_register(&bus->dev);
+	if (err) {
+		pr_err("mii_bus %s failed to register\n", bus->id);
+		return -EINVAL;
+	}
+
+	mutex_init(&bus->mdio_lock);
+	mutex_init(&bus->shared_lock);
+
+	/* assert bus level PHY GPIO reset */
+	gpiod = devm_gpiod_get_optional(&bus->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod)) {
+		err = dev_err_probe(&bus->dev, PTR_ERR(gpiod),
+				    "mii_bus %s couldn't get reset GPIO\n",
+				    bus->id);
+		device_del(&bus->dev);
+		return err;
+	} else	if (gpiod) {
+		bus->reset_gpiod = gpiod;
+		fsleep(bus->reset_delay_us);
+		gpiod_set_value_cansleep(gpiod, 0);
+		if (bus->reset_post_delay_us > 0)
+			fsleep(bus->reset_post_delay_us);
+	}
+
+	if (bus->reset) {
+		err = bus->reset(bus);
+		if (err)
+			goto error_reset_gpiod;
+	}
+
+	if (bus->read) {
+		err = mdiobus_scan_bus_c22(bus);
+		if (err)
+			goto error;
+	}
+
+	prevent_c45_scan = mdiobus_prevent_c45_scan(bus);
+
+	if (!prevent_c45_scan && bus->read_c45) {
+		err = mdiobus_scan_bus_c45(bus);
+		if (err)
+			goto error;
+	}
+
+	mdiobus_setup_mdiodev_from_board_info(bus, mdiobus_create_device);
+
+	bus->state = MDIOBUS_REGISTERED;
+	dev_dbg(&bus->dev, "probed\n");
+	return 0;
+
+error:
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		mdiodev = bus->mdio_map[i];
+		if (!mdiodev)
+			continue;
+
+		mdiodev->device_remove(mdiodev);
+		mdiodev->device_free(mdiodev);
+	}
+error_reset_gpiod:
+	/* Put PHYs in RESET to save power */
+	if (bus->reset_gpiod)
+		gpiod_set_value_cansleep(bus->reset_gpiod, 1);
+
+	device_del(&bus->dev);
+	return err;
+}
+EXPORT_SYMBOL(__mdiobus_register);
+
+void mdiobus_unregister(struct mii_bus *bus)
+{
+	struct mdio_device *mdiodev;
+	int i;
+
+	if (WARN_ON_ONCE(bus->state != MDIOBUS_REGISTERED))
+		return;
+	bus->state = MDIOBUS_UNREGISTERED;
+
+	for (i = 0; i < PHY_MAX_ADDR; i++) {
+		mdiodev = bus->mdio_map[i];
+		if (!mdiodev)
+			continue;
+
+		if (mdiodev->reset_gpio)
+			gpiod_put(mdiodev->reset_gpio);
+
+		mdiodev->device_remove(mdiodev);
+		mdiodev->device_free(mdiodev);
+	}
+
+	/* Put PHYs in RESET to save power */
+	if (bus->reset_gpiod)
+		gpiod_set_value_cansleep(bus->reset_gpiod, 1);
+
+	device_del(&bus->dev);
+}
+EXPORT_SYMBOL(mdiobus_unregister);
+
+/**
+ * mdiobus_free - free a struct mii_bus
+ * @bus: mii_bus to free
+ *
+ * This function releases the reference to the underlying device
+ * object in the mii_bus.  If this is the last reference, the mii_bus
+ * will be freed.
+ */
+void mdiobus_free(struct mii_bus *bus)
+{
+	/* For compatibility with error handling in drivers. */
+	if (bus->state == MDIOBUS_ALLOCATED) {
+		kfree(bus);
+		return;
+	}
+
+	WARN(bus->state != MDIOBUS_UNREGISTERED,
+	     "%s: not in UNREGISTERED state\n", bus->id);
+	bus->state = MDIOBUS_RELEASED;
+
+	put_device(&bus->dev);
+}
+EXPORT_SYMBOL(mdiobus_free);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3beaf225e..d62d29202 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2062,6 +2062,7 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 		       struct netlink_ext_ack *extack);
 
 extern const struct bus_type mdio_bus_type;
+extern const struct class mdio_bus_class;
 
 struct mdio_board_info {
 	const char	*bus_id;
-- 
2.49.0



