Return-Path: <netdev+bounces-175249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47237A64929
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 11:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3883B172E1F
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCC723816F;
	Mon, 17 Mar 2025 10:14:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0E3237A3B;
	Mon, 17 Mar 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206443; cv=none; b=EbO/Kf0ig35iwTDKde1rcQZ8E0rIA/aO4lEbX7VLiHS6dCkS99K+simNf8tncpq5JzOSnvqMDKwWb58ixKrpSdRjCcKKniEkUEa24g9cmVj2+Z3ou1ugX4x4v4OrUYcVU7kTGpcFLtkMaM0xo+qEyQOuh+QmZoPeLFowK17GXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206443; c=relaxed/simple;
	bh=HHdZErm8BjMqpB8v6zRi2otchdcjI/bZfyLzXogt27A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gH2vyKzB70kRJMc26fdELk87qVOd6ZLh8aOIkKEFdDk8WAsHhP4cXWqHsGtRQp0j2J3TQDPlT5+kI596aGfhqHwaSqFPhFvIhfGkia1qHGSFuV9USpgxv5b5InBniFs0wFo14B18q0/rDmCoPzMahvP4Rk/zVMVyVI/3ofj9Xak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C1A313D5;
	Mon, 17 Mar 2025 03:14:10 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 151073F673;
	Mon, 17 Mar 2025 03:13:59 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Mar 2025 10:13:19 +0000
Subject: [PATCH 7/9] net: phy: fixed_phy: transition to the faux device
 interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-plat2faux_dev-v1-7-5fe67c085ad5@arm.com>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
In-Reply-To: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2841; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=HHdZErm8BjMqpB8v6zRi2otchdcjI/bZfyLzXogt27A=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn1/XbYQ+ahwD2Rp/tJLJcXVQOmij9MazsBlzLX
 3EfFytNcp+JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9f12wAKCRAAQbq8MX7i
 mMkaEACN4Q898YXIMORP4uejPLi+PJpMCR63s8LYHzmcB8LM9LW17y7nWG/BZ9nXw0DaJ4Nnk0z
 FXxKz+Ago6xlZNMw9/VCg7lbfcb1z7cynB3kazM8lMuFbJCBkOM5rAMjQ90W3bnqj1hYSsnQREw
 NtqYnIi0BHrreuPiNks955noZYRz+mp2RkPNABqEwFIapBMNA++PjB6AGvKJrjywdo34To6YPSM
 RGcApKgBFBPG7IEQzxiHO50Bg45cDkemgACDe5XLul1/R1Gl67caO3SsAW7cwm//iMxzztAIUGo
 ++dIuoBBNAMkYPPNr/+xjlW5dybynxQHL1CBxK9NMKIpf6hvopSj72HGI3yz9L6hEKUSUzg0mt5
 A0oph4NyCesqnUtjHfxbk3KHf7yDHhQTiysUAntdllTKUcEmJxfjmu0CRiS1VgzQLeWPwpekTyH
 +c7xgk7q5PO2Gr7Kmb2mnKyHzK9YrpE+8wGrPsJOaUc2a/JYcEt73swswnL3A95eD7ZdE3lOwNI
 0eMvNgQiLJpGP03YgFo3efTHcR8iIOBOU1E/we9S3HiLRBy/aSouGefa0h/zuQQq0xrOexCduSq
 WfIEy+nu3qVeccB4e1isFSHmqqRbuPHPjrs/xCmlWU9srk4bE3Mo+t1Bnv1xJR2pRW9hYiPrmR6
 Zx1x+J7STU3Wk7w==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

The net fixed phy driver does not require the creation of a platform
device. Originally, this approach was chosen for simplicity when the
driver was first implemented.

With the introduction of the lightweight faux device interface, we now
have a more appropriate alternative. Migrate the driver to utilize the
faux bus, given that the platform device it previously created was not
a real one anyway. This will simplify the code, reducing its footprint
while maintaining functionality.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/net/phy/fixed_phy.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index aef739c20ac4d5a271465a677a85ef7c18cfce70..ee7831a9849b3728ca9c541da35d17e089985da2 100644
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


