Return-Path: <netdev+bounces-154662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C19FF53A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 00:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B933A24B8
	for <lists+netdev@lfdr.de>; Wed,  1 Jan 2025 23:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793676035;
	Wed,  1 Jan 2025 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="uCKQHVGp"
X-Original-To: netdev@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6314293
	for <netdev@vger.kernel.org>; Wed,  1 Jan 2025 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735775548; cv=pass; b=VLbAERoi/elMa8IgUKtSBjxv90bUkeCbe9TYZrUDFKDL2G7zFh7J3XkmtD4UHA9ysVg/fDlw15fs0TZDIUlkUEii2akKXtijUE8azv0otXvJgq1TtaWKGTaXSuPoVlnf42QpYtd0pkuPc3vHU2eYXVd9OoIWMB6tOM28C3f1IIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735775548; c=relaxed/simple;
	bh=HOa7M+aGk9ybc3gw6PRe5zv+3QHmXMYmTGSkuDuEMVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YkzWm+5hSBr9dD+Aq1meAx32gYl2WAuXu9olI98qR829nfcRknJtOA9OVPwyVMJQiDqhtVuMW6MU6tXtLwl6WgmEk90AGYALCRP90ALQHAz5lWMt8t5pskb3RtmjFxBcIaDKmSPwa3VSQG7eNDo99MobC2tNT0sDKvgEY/mrq3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=uCKQHVGp; arc=pass smtp.client-ip=185.56.87.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=instance-europe-west4-rhcm.prod.antispam.mailspamprotection.com; s=arckey; t=1735775545;
	 b=JCjpm2nTBCDbYDtNElh2XccLrf0687SluRIuBjzNY7hgb1MhjnnslWqNka4kZhyFzKwXXzDbZY
	  +RGGeOvr4xy/0mEb2RCUgn4WWequmcHWtnDbRDnfy0lMRK24mYsGD65DKbRWCsvSUjvvVJvtkL
	  bidaZe3h5MS54W8nBzH9Y208YiXKP+hnxoPIrQ6pb+E3VRc+oRawAeZDh8foP4oRP5mluhBM6v
	  iDIp7BnBA29U0iZfCylzDUF57eITFBlYSYJLlDtRdmnOQsdZwWGX1QqxbA6nk7bApDbZhLUJSB
	  IFbGavIgfB6DadCqDp2BGRY+KvwhOjVKNh6qsajqCU8nag==;
ARC-Authentication-Results: i=1; instance-europe-west4-rhcm.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=instance-europe-west4-rhcm.prod.antispam.mailspamprotection.com; s=arckey; t=1735775545;
	bh=HOa7M+aGk9ybc3gw6PRe5zv+3QHmXMYmTGSkuDuEMVw=;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	  DKIM-Signature;
	b=DbJa57wl5TxrZu1iajOxQfZpLKXASWSf/zE5cP/sPVTWNWz5rAOcl4kWlEYD3YfK2cKXvcb+cE
	  GTnIIxy/Op/dMtNH2wXikqf+J0RSIsSeQAoR+EagAkZ6qkDU6PJ7pSyNySJNhCyzNGjKTg+2k0
	  f5+wPX6c9wD9crb1UzE3wWjHz40gPbu7NRKUYvEOfJcwFDpb9kZt9GSKnbOimHaiMRl7CaM9BY
	  zsL9JlQlJVzxWXEvI/CFjov7eCdpkvcvBZbuic/dj+tVQ5QOQdt1AZCul6Ue0+keBQgwPoAHe4
	  bFrzE+xJ655BhkxVuboPunsb/npNvyXMLw2eLyIbnDjfNQ==;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-rhcm.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tT8Vb-00000006txd-0Zc8
	for netdev@vger.kernel.org;
	Wed, 01 Jan 2025 23:52:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=rIb5Urn0gI7eY70qYEjfXzdZzPYgAZXJY7p3B8ONt1Q=; b=uCKQHVGpuK46NmxuvwGXfAULFD
	5f3yP4d/VZlVbXPbPyz9IQiBoRxnEbbNoQm/PApRVRn1/xhUgoSsUXK9kEswZRQEsewrnLhSeB9fr
	OKhLShYImgqtEprAXRemSeAGa53Xc+9rlCENumcVN+KRVBIJYL6G5D8Zlq5zZhC/ROaM=;
Received: from [87.11.41.26] (port=63942 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <francesco@valla.it>)
	id 1tT8VV-00000000HXP-3L3e;
	Wed, 01 Jan 2025 23:52:09 +0000
From: Francesco Valla <francesco@valla.it>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH] net: phy: don't issue a module request if a driver is available
Date: Thu,  2 Jan 2025 00:51:22 +0100
Message-ID: <20250101235122.704012-1-francesco@valla.it>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 05fc14a954b6595731b1c8add44a2847
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
Authentication-Results: instance-europe-west4-rhcm.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Whenever a new PHY device is created, request_module() is called
unconditionally, without checking if a driver for the new PHY is already
available (either built-in or from a previous probe). This conflicts
with async probing of the underlying MDIO bus and always throws a
warning (because if a driver is loaded it _might_ cause a deadlock, if
in turn it calls async_synchronize_full()).

Add a list of registered drivers and check if one is already available
before resorting to call request_module(); in this way, if the PHY
driver is already there, the MDIO bus can perform the async probe.

Signed-off-by: Francesco Valla <francesco@valla.it>
---
 drivers/net/phy/phy_device.c | 61 +++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b26bb33cd1d4..a9e8b834851c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -44,6 +44,14 @@ MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
 MODULE_LICENSE("GPL");
 
+struct phy_drv_node {
+	const struct phy_driver *drv;
+	struct list_head list;
+};
+
+static LIST_HEAD(phy_drv_list);
+static DECLARE_RWSEM(phy_drv_list_sem);
+
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_basic_features);
 
@@ -658,6 +666,23 @@ static int phy_request_driver_module(struct phy_device *dev, u32 phy_id)
 	return 0;
 }
 
+static bool phy_driver_exists(u32 phy_id)
+{
+	bool found = false;
+	struct phy_drv_node *node;
+
+	down_read(&phy_drv_list_sem);
+	list_for_each_entry(node, &phy_drv_list, list) {
+		if (phy_id_compare(phy_id, node->drv->phy_id, node->drv->phy_id_mask)) {
+			found = true;
+			break;
+		}
+	}
+	up_read(&phy_drv_list_sem);
+
+	return found;
+}
+
 struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 				     bool is_c45,
 				     struct phy_c45_device_ids *c45_ids)
@@ -709,11 +734,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 	mutex_init(&dev->lock);
 	INIT_DELAYED_WORK(&dev->state_queue, phy_state_machine);
 
-	/* Request the appropriate module unconditionally; don't
-	 * bother trying to do so only if it isn't already loaded,
-	 * because that gets complicated. A hotplug event would have
-	 * done an unconditional modprobe anyway.
-	 * We don't do normal hotplug because it won't work for MDIO
+	/* We don't do normal hotplug because it won't work for MDIO
 	 * -- because it relies on the device staying around for long
 	 * enough for the driver to get loaded. With MDIO, the NIC
 	 * driver will get bored and give up as soon as it finds that
@@ -724,7 +745,8 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 		int i;
 
 		for (i = 1; i < num_ids; i++) {
-			if (c45_ids->device_ids[i] == 0xffffffff)
+			if (c45_ids->device_ids[i] == 0xffffffff ||
+			    phy_driver_exists(c45_ids->device_ids[i]))
 				continue;
 
 			ret = phy_request_driver_module(dev,
@@ -732,7 +754,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 			if (ret)
 				break;
 		}
-	} else {
+	} else if (!phy_driver_exists(phy_id)) {
 		ret = phy_request_driver_module(dev, phy_id);
 	}
 
@@ -3674,6 +3696,7 @@ static int phy_remove(struct device *dev)
  */
 int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 {
+	struct phy_drv_node *node;
 	int retval;
 
 	/* Either the features are hard coded, or dynamically
@@ -3695,6 +3718,10 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 		 new_driver->name))
 		return -EINVAL;
 
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
 	new_driver->mdiodrv.flags |= MDIO_DEVICE_IS_PHY;
 	new_driver->mdiodrv.driver.name = new_driver->name;
 	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
@@ -3707,10 +3734,15 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	if (retval) {
 		pr_err("%s: Error %d in registering driver\n",
 		       new_driver->name, retval);
-
+		kfree(node);
 		return retval;
 	}
 
+	down_write(&phy_drv_list_sem);
+	node->drv = new_driver;
+	list_add(&node->list, &phy_drv_list);
+	up_write(&phy_drv_list_sem);
+
 	pr_debug("%s: Registered new driver\n", new_driver->name);
 
 	return 0;
@@ -3736,6 +3768,19 @@ EXPORT_SYMBOL(phy_drivers_register);
 
 void phy_driver_unregister(struct phy_driver *drv)
 {
+	struct phy_drv_node *node;
+
+	down_write(&phy_drv_list_sem);
+	list_for_each_entry(node, &phy_drv_list, list) {
+		if (phy_id_compare(drv->phy_id,
+				   node->drv->phy_id, node->drv->phy_id_mask)) {
+			list_del(&node->list);
+			kfree(node);
+			break;
+		}
+	}
+	up_write(&phy_drv_list_sem);
+
 	driver_unregister(&drv->mdiodrv.driver);
 }
 EXPORT_SYMBOL(phy_driver_unregister);
-- 
2.47.1


