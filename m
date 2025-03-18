Return-Path: <netdev+bounces-175833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB3A67A4E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C98188F220
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF8E211A0A;
	Tue, 18 Mar 2025 17:02:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10672135BD;
	Tue, 18 Mar 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317366; cv=none; b=Edsdbq+GSdivpGhsdI3R1DZEioUvsuZ7CW/0xffivxn8hd6Zbmn/JTd3VA8bqrwp1ulRNbCt1boGdhYcjOxJck9s5/GgIIfScnB7K+UlwyDyJLuAjVImY3yqjYHWFwY4JZhhp8c8VRPT26kEEwe7tQWFguKnW13dEpqVBG/dg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317366; c=relaxed/simple;
	bh=QzJgahSVlSnPEW0+dKHJjQ4euPpwRVaYcROk61G2c0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSH5ucDi/F0HoVnxN/7hD3XmjyhnnLDB61447mwdMEp5R01/jCZrV0q9F4I7GJ0Q0/r50QtzPyIpb+mVMHRv6PI5ZOJN21KBvobi33zBV30IN7K5YAO8iFief6tzcH8PGkyVK0KIyD+r5eIfXfK8TNNxXbQ1UpjbwA4vduVbKqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C5481A25;
	Tue, 18 Mar 2025 10:02:49 -0700 (PDT)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC3E73F673;
	Tue, 18 Mar 2025 10:02:39 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 18 Mar 2025 17:01:46 +0000
Subject: [PATCH v2 8/8] net: phy: fixed_phy: transition to the faux device
 interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-plat2faux_dev-v2-8-e6cc73f78478@arm.com>
References: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
In-Reply-To: <20250318-plat2faux_dev-v2-0-e6cc73f78478@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=QzJgahSVlSnPEW0+dKHJjQ4euPpwRVaYcROk61G2c0s=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBn2acjJfK9XrY9C04/OxvAgk3YKFLyoo4IjykEo
 SaJHEUhG3mJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ9mnIwAKCRAAQbq8MX7i
 mChxEACny/i1d7qnxSgF7wA3rTQEEdMhguxpuh/vKoSA4zQbcBvt/+CiNJsRrnPZNYhgEoHxCEe
 sYpu+xa6jPNXCoGJ5c1LLWicKXaYKW7DP/1/Y36woY8/ZbJk4v1kWprNZGf01LOO9Y4IDCk6Wjd
 zPh6gW4bGg687TVyc2NiR0OMgpSYu2z/Nj95LoYoC/AuwBoj2UUG8NVYXKprZ3SfiDxPudsLv5n
 zLvG9MTWQ/EmUsSoZr/2N6FSaZEouaLLXWGfm1kypYl/g0+usc8MDvKQZulQ2PeBc8TfvUR9Si2
 A64A2z9s+z5uDKgFdVk7EhhmCHrjsKssBg62tIrxyPb9ypKBenQbKIqJevRz67Rmiwxd9X/hU9M
 F4omkoHo/Y/E5hV3mE2V6HcsdDMygqgg9NANiDn4K6OtOPgV/RYjQP2NvjHwYXNP4g/oKUrnlRt
 MSNKkWKyDm4vPmpQ5F9Xi7NLf3aIlG10oZGBH1zCBHKTtj+4HJiBdfxSb9UEUWPKR78tF0bhrDv
 3IEqEuxpDuwcVSN57/q8wWMfYKunax/wQKIVwqXstHom8FiI3zoYxulSENx2EvNsbiG5OQy4NiS
 5jve8hGCAhRebcC0w8EZY1PtssYBV2NMdCmdAEAdfjgNpc3/bsoL0HuBe2r0WL0tVQNxCQ0Nz1c
 5Yxs4sHHoLaS8Uw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

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


