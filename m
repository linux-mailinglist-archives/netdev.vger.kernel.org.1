Return-Path: <netdev+bounces-176130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0DEA68E42
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 14:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0713BE71A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536A2374EA;
	Wed, 19 Mar 2025 13:52:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836642FC23;
	Wed, 19 Mar 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392335; cv=none; b=LONua3vVB/D6At6zL9ir3L0pt9Rlp0Y/nBS+vUriZSOfYAsQ1XZ1HygjpZQ7oxU6aN95cORKT2GNWx25S+lkhW7LOyOsBgM0uHi+IxtzlsHeeJZ4cJTYHd0vVZjlsgHy0MmkbiFy7w6W9R+ByPBWZ0ZEeffuzicdyjXCOrwgaRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392335; c=relaxed/simple;
	bh=fblOU5XQsvkux3RLhPLmC/pFbQsmjwoFmqRLPXIxi64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CbNtrQbEYKHo37oSQK09HUWvssgYzrEoMbeZ3+K1mIDJqUuH6NSnJui0n5TpW2S8gvfb2mL9Y2b1CgzjgiFBghD5wB0xRJk7veqmieLkPjFIg5WQgjLIhjwT8/sxSY3iTetuTGvhuFM4eoKP+oHC1hAcijdTHgq0N7T17QX64BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B360113E;
	Wed, 19 Mar 2025 06:52:21 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C3AE93F673;
	Wed, 19 Mar 2025 06:52:11 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Subject: [RESEND PATCH] net: phy: fixed_phy: transition to the faux device interface
Date: Wed, 19 Mar 2025 13:52:09 +0000
Message-Id: <20250319135209.2734594-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The net fixed phy driver does not require the creation of a platform
device. Originally, this approach was chosen for simplicity when the
driver was first implemented.

With the introduction of the lightweight faux device interface, we now
have a more appropriate alternative. Migrate the device to utilize the
faux bus, given that the platform device it previously created was not
a real one anyway. This will get rid of the fake platform device.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/net/phy/fixed_phy.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Hi,

This is just a resend of [1][2] independent of the series as there are
no dependency.

Regards,
Sudeep

[1] https://lore.kernel.org/all/20250317-plat2faux_dev-v1-7-5fe67c085ad5@arm.com/
[2] https://lore.kernel.org/all/20250318-plat2faux_dev-v2-8-e6cc73f78478@arm.com/


diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index aef739c20ac4..ee7831a9849b 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -10,7 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
+#include <linux/device/faux.h>
 #include <linux/list.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
@@ -40,7 +40,7 @@ struct fixed_phy {
 	struct gpio_desc *link_gpiod;
 };
 
-static struct platform_device *pdev;
+static struct faux_device *fdev;
 static struct fixed_mdio_bus platform_fmb = {
 	.phys = LIST_HEAD_INIT(platform_fmb.phys),
 };
@@ -337,9 +337,9 @@ static int __init fixed_mdio_bus_init(void)
 	struct fixed_mdio_bus *fmb = &platform_fmb;
 	int ret;
 
-	pdev = platform_device_register_simple("Fixed MDIO bus", 0, NULL, 0);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	fdev = faux_device_create("Fixed MDIO bus", NULL, NULL);
+	if (!fdev)
+		return -ENODEV;
 
 	fmb->mii_bus = mdiobus_alloc();
 	if (fmb->mii_bus == NULL) {
@@ -350,7 +350,7 @@ static int __init fixed_mdio_bus_init(void)
 	snprintf(fmb->mii_bus->id, MII_BUS_ID_SIZE, "fixed-0");
 	fmb->mii_bus->name = "Fixed MDIO Bus";
 	fmb->mii_bus->priv = fmb;
-	fmb->mii_bus->parent = &pdev->dev;
+	fmb->mii_bus->parent = &fdev->dev;
 	fmb->mii_bus->read = &fixed_mdio_read;
 	fmb->mii_bus->write = &fixed_mdio_write;
 	fmb->mii_bus->phy_mask = ~0;
@@ -364,7 +364,7 @@ static int __init fixed_mdio_bus_init(void)
 err_mdiobus_alloc:
 	mdiobus_free(fmb->mii_bus);
 err_mdiobus_reg:
-	platform_device_unregister(pdev);
+	faux_device_destroy(fdev);
 	return ret;
 }
 module_init(fixed_mdio_bus_init);
@@ -376,7 +376,7 @@ static void __exit fixed_mdio_bus_exit(void)
 
 	mdiobus_unregister(fmb->mii_bus);
 	mdiobus_free(fmb->mii_bus);
-	platform_device_unregister(pdev);
+	faux_device_destroy(fdev);
 
 	list_for_each_entry_safe(fp, tmp, &fmb->phys, node) {
 		list_del(&fp->node);
-- 
2.34.1


