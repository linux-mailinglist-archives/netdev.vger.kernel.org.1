Return-Path: <netdev+bounces-244747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7F4CBDECB
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 904B4301765B
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF6F2D47FE;
	Mon, 15 Dec 2025 13:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="PjNGwJCd"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869F10957;
	Mon, 15 Dec 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803601; cv=none; b=sgolEaH1oda0jJu1fuCONhx002UT7b7EU1REq1Eg8DQr4O/UBoNQ09xyMx2MsKDEITLnj4m0dSmWnsPOIfen6CCD+6SS2OlHeEdyG3NZfPHLzrrSnrhTcU/CicDSgAkrqxSGUaKqdjL2S4eU5zKkFdPK2I7X/GPoU+pMokXtJOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803601; c=relaxed/simple;
	bh=Si6RvWyw94wYHTyp4BE0LyHi1xMMrfcs0bHNwGU8Nbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFsIFSy8XjFt7jxwIgiL2ePPu6ybtrcqZ4q6QJeH13bP27vwtP0KSfwfGrFqm4NdnS5vH3isTVQ9bn7X/8q817H/cBK/XgJWG3abYy+U7flEzSTErNLVxjPxQV6ArCH4TmxDJvel2+lMZezbhM8q4pfYpBgWn15c/JHv/6HhDZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=PjNGwJCd; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gvv806IIngKsCS+RthrpGnKcpWnhs1K6eyI0UEm1pBY=;
	b=PjNGwJCddisb0aHJPTWim/JL5CyLy6PiGZ+ue1fTqbdWEfpDlTpd+QF90qnpFZlmO3YXWDYKh
	s0NtLTVc6vAJCBMSYAFsAI+D2jxb8IvPgnrrMXfUjLxOfYvNmbwpe/fd03X62vCOKR2UHBu6uG0
	0OnEnZROUb3HXZLAoTI6Wpg=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dVKp26H3tzcb1N;
	Mon, 15 Dec 2025 20:56:58 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id E17BD140203;
	Mon, 15 Dec 2025 20:59:48 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 20:59:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH RFC net-next 1/6] net: phy: change of_phy_leds() to fwnode_phy_leds()
Date: Mon, 15 Dec 2025 20:57:00 +0800
Message-ID: <20251215125705.1567527-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251215125705.1567527-1-shaojijie@huawei.com>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Change of_phy_leds() to fwnode_phy_leds(), to support
of node, acpi node, and software node together.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/phy/phy_device.c | 37 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 81984d4ebb7c..c5ce057f88ff 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3208,8 +3208,8 @@ static void phy_leds_unregister(struct phy_device *phydev)
 	}
 }
 
-static int of_phy_led(struct phy_device *phydev,
-		      struct device_node *led)
+static int fwnode_phy_led(struct phy_device *phydev,
+			  struct fwnode_handle *led)
 {
 	struct device *dev = &phydev->mdio.dev;
 	struct led_init_data init_data = {};
@@ -3226,17 +3226,17 @@ static int of_phy_led(struct phy_device *phydev,
 	cdev = &phyled->led_cdev;
 	phyled->phydev = phydev;
 
-	err = of_property_read_u32(led, "reg", &index);
+	err = fwnode_property_read_u32(led, "reg", &index);
 	if (err)
 		return err;
 	if (index > U8_MAX)
 		return -EINVAL;
 
-	if (of_property_read_bool(led, "active-high"))
+	if (fwnode_property_read_bool(led, "active-high"))
 		set_bit(PHY_LED_ACTIVE_HIGH, &modes);
-	if (of_property_read_bool(led, "active-low"))
+	if (fwnode_property_read_bool(led, "active-low"))
 		set_bit(PHY_LED_ACTIVE_LOW, &modes);
-	if (of_property_read_bool(led, "inactive-high-impedance"))
+	if (fwnode_property_read_bool(led, "inactive-high-impedance"))
 		set_bit(PHY_LED_INACTIVE_HIGH_IMPEDANCE, &modes);
 
 	if (WARN_ON(modes & BIT(PHY_LED_ACTIVE_LOW) &&
@@ -3273,7 +3273,7 @@ static int of_phy_led(struct phy_device *phydev,
 #endif
 	cdev->max_brightness = 1;
 	init_data.devicename = dev_name(&phydev->mdio.dev);
-	init_data.fwnode = of_fwnode_handle(led);
+	init_data.fwnode = led;
 	init_data.devname_mandatory = true;
 
 	err = led_classdev_register_ext(dev, cdev, &init_data);
@@ -3285,19 +3285,16 @@ static int of_phy_led(struct phy_device *phydev,
 	return 0;
 }
 
-static int of_phy_leds(struct phy_device *phydev)
+static int fwnode_phy_leds(struct phy_device *phydev)
 {
-	struct device_node *node = phydev->mdio.dev.of_node;
-	struct device_node *leds;
+	struct fwnode_handle *fwnode = dev_fwnode(&phydev->mdio.dev);
+	struct fwnode_handle *leds, *led;
 	int err;
 
-	if (!IS_ENABLED(CONFIG_OF_MDIO))
-		return 0;
-
-	if (!node)
+	if (!fwnode)
 		return 0;
 
-	leds = of_get_child_by_name(node, "leds");
+	leds = fwnode_get_named_child_node(fwnode, "leds");
 	if (!leds)
 		return 0;
 
@@ -3311,17 +3308,17 @@ static int of_phy_leds(struct phy_device *phydev)
 		goto exit;
 	}
 
-	for_each_available_child_of_node_scoped(leds, led) {
-		err = of_phy_led(phydev, led);
+	fwnode_for_each_available_child_node(leds, led) {
+		err = fwnode_phy_led(phydev, led);
 		if (err) {
-			of_node_put(leds);
+			fwnode_handle_put(leds);
 			phy_leds_unregister(phydev);
 			return err;
 		}
 	}
 
 exit:
-	of_node_put(leds);
+	fwnode_handle_put(leds);
 	return 0;
 }
 
@@ -3516,7 +3513,7 @@ static int phy_probe(struct device *dev)
 	 * LEDs for them.
 	 */
 	if (IS_ENABLED(CONFIG_PHYLIB_LEDS) && !phy_driver_is_genphy(phydev))
-		err = of_phy_leds(phydev);
+		err = fwnode_phy_leds(phydev);
 
 out:
 	/* Re-assert the reset signal on error */
-- 
2.33.0


