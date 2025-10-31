Return-Path: <netdev+bounces-234631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076DC24CCA
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C021A66712
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE62346E7C;
	Fri, 31 Oct 2025 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tZk+K69y"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD415345CD4;
	Fri, 31 Oct 2025 11:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910357; cv=none; b=ol80SR00+in9OVNnla/NIPtTwzB3k+imhgxXH5iIi/oWqyKOGRAyc2TNFCHqulGtKfrvkHopYEBQ7igTN2xtX87Ka0L+Nt6NBslWXe6osCQd5ePLiOahWVdQJEm1Bcr6rD7wauZeWW2R5eDxYzLwE/006TlDm3OKd/HqUFFYMGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910357; c=relaxed/simple;
	bh=S5IFUps93qpDO2XZbKKT67i/iIJg4oYrcX2D840XN2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4r1VGGqOcLeoGncW6RhoMdh8b7n8JoTvYqsVWbZ3EYtsiKRMdtBiFu3sxzEqWJUWjO7c2Bc/7/ekcpFz13xgmtyLtQorkuwrnTdR/u+Q8rfZPCk8qeWCL5oBy1sAKN0MxZtFWSMVNtb9wj+jFJoSHUwFO/U+/uqbr+CNLdKz9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tZk+K69y; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 78C06A1851;
	Fri, 31 Oct 2025 12:32:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=g7IU8MOev+9Q8khQL+wq
	jLCoSKrjT/n0LAN06kkjTgo=; b=tZk+K69yLPNrs5aRNx0kZwMgsRzxDL+Claq3
	3jJN0689bA5We4dG/Yf5FgDpmm2rJMwxViV5b7VxZ7EKIZjQ0vSlXbNtoUIH3YSI
	9OD6N65PERlOssldn5pMrmY+SVAUv2+u5CSIXqBa37CTQno7HuEK2RiFwJeYi79W
	Qe9yRORSV6GdjzPvkzWZ/NRTkxfcTX4EWclxzSlJgrLfBwr2cpZFzCsmsMT5rZrd
	8SGovlNlnfBOhyg4OjYkV/vkxPlIxcxX79CT7AUGdfoWEBJ8rqoEfsAv58rXz8M+
	2c18ZnMdr2FMsDFv1jpulQYT9BAbfALbJZ4gkYmPwMKrIn6ryADuX9ggq6Plhqpz
	ZTjwBgg+3pMyumrL+K3BrA3yzs2jetfZReKOyFukDWSrFEKcvZfPpBJBE2KqKKIx
	J1+d4YFjharncBqOWrxoLN+diGwxcaiXHetHxZ/bj6nb7qprX2HFExg8NUKh13kj
	ygrX3S398cxNzwwvZsyDYjwJuzMoWkge6byW7eMfQYO1OIPx4aczeSCSWprgurxs
	LjiDYHgUq/i9Tn9u7s14dUvUpMF0leSfAB7yKVKr5B3KVKjnPZMwuQULq/Dgw43F
	ZFKkW+DtB4u7J/b3IPE9Za7KWMyNVb3HZJynvhrqBu4KjgOpferHntdXlR37cATB
	cel099o=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next 2/3] net: mdio: common handling of phy device reset properties
Date: Fri, 31 Oct 2025 12:32:27 +0100
Message-ID: <cf21efc26fee6c56faab9f4b80790d21b8271da9.1761909948.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1761909948.git.buday.csaba@prolan.hu>
References: <cover.1761909948.git.buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1761910350;VERSION=8001;MC=3731004014;ID=195343;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F677D60

Unify the handling of the per device reset properties for
`mdio_device`.

Merge mdio_device_register_gpiod() and mdio_device_register_reset()
into mdio_device_register_reset(), that handles both
reset-controllers and reset-gpios.
Move reading of the reset firmware properties (reset-assert-us,
reset-deassert-us) from fwnode_mdio.c to mdio_device_register_reset(),
so all reset related initialization code is kept in one place.

Introduce mdio_device_unregister_reset() to release the associated
resources.

These changes make tracking the reset properties easier.
Added kernel-doc for mdio_device_register/unregister_reset().

No functional changes intended.

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/mdio/fwnode_mdio.c |  5 -----
 drivers/net/phy/mdio_bus.c     |  7 +------
 drivers/net/phy/mdio_device.c  | 35 ++++++++++++++++++++++++++--------
 include/linux/mdio.h           |  2 +-
 4 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 9b41d4697..ba7091518 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -92,11 +92,6 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 	if (fwnode_property_read_bool(child, "broken-turn-around"))
 		mdio->phy_ignore_ta_mask |= 1 << addr;
 
-	fwnode_property_read_u32(child, "reset-assert-us",
-				 &phy->mdio.reset_assert_delay);
-	fwnode_property_read_u32(child, "reset-deassert-us",
-				 &phy->mdio.reset_deassert_delay);
-
 	/* Associate the fwnode with the device structure so it
 	 * can be looked up later
 	 */
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index f23298232..748c6a9aa 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -41,10 +41,6 @@ int mdiobus_register_device(struct mdio_device *mdiodev)
 		return -EBUSY;
 
 	if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
-		err = mdio_device_register_gpiod(mdiodev);
-		if (err)
-			return err;
-
 		err = mdio_device_register_reset(mdiodev);
 		if (err)
 			return err;
@@ -64,8 +60,7 @@ int mdiobus_unregister_device(struct mdio_device *mdiodev)
 	if (mdiodev->bus->mdio_map[mdiodev->addr] != mdiodev)
 		return -EINVAL;
 
-	gpiod_put(mdiodev->reset_gpio);
-	reset_control_put(mdiodev->reset_ctrl);
+	mdio_device_unregister_reset(mdiodev);
 
 	mdiodev->bus->mdio_map[mdiodev->addr] = NULL;
 
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 5a78d8624..ec0263264 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -118,8 +118,17 @@ void mdio_device_remove(struct mdio_device *mdiodev)
 }
 EXPORT_SYMBOL(mdio_device_remove);
 
-int mdio_device_register_gpiod(struct mdio_device *mdiodev)
+/**
+ * mdio_device_register_reset - Read and initialize the reset properties of
+ *				an mdio device
+ * @mdiodev: mdio_device structure
+ *
+ * Return: Zero if successful, negative error code on failure
+ */
+int mdio_device_register_reset(struct mdio_device *mdiodev)
 {
+	struct reset_control *reset;
+
 	/* Deassert the optional reset signal */
 	mdiodev->reset_gpio = gpiod_get_optional(&mdiodev->dev,
 						 "reset", GPIOD_OUT_LOW);
@@ -129,22 +138,32 @@ int mdio_device_register_gpiod(struct mdio_device *mdiodev)
 	if (mdiodev->reset_gpio)
 		gpiod_set_consumer_name(mdiodev->reset_gpio, "PHY reset");
 
-	return 0;
-}
-
-int mdio_device_register_reset(struct mdio_device *mdiodev)
-{
-	struct reset_control *reset;
-
 	reset = reset_control_get_optional_exclusive(&mdiodev->dev, "phy");
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
 	mdiodev->reset_ctrl = reset;
 
+	/* Read optional firmware properties */
+	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-assert-us",
+				 &mdiodev->reset_assert_delay);
+	fwnode_property_read_u32(dev_fwnode(&mdiodev->dev), "reset-deassert-us",
+				 &mdiodev->reset_deassert_delay);
+
 	return 0;
 }
 
+/**
+ * mdio_device_unregister_reset - uninitialize the reset properties of
+ *				  an mdio device
+ * @mdiodev: mdio_device structure
+ */
+void mdio_device_unregister_reset(struct mdio_device *mdiodev)
+{
+	gpiod_put(mdiodev->reset_gpio);
+	reset_control_put(mdiodev->reset_ctrl);
+}
+
 void mdio_device_reset(struct mdio_device *mdiodev, int value)
 {
 	unsigned int d;
diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 1322d2623..e76f5a6c2 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -92,8 +92,8 @@ void mdio_device_free(struct mdio_device *mdiodev);
 struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr);
 int mdio_device_register(struct mdio_device *mdiodev);
 void mdio_device_remove(struct mdio_device *mdiodev);
-int mdio_device_register_gpiod(struct mdio_device *mdiodev);
 int mdio_device_register_reset(struct mdio_device *mdiodev);
+void mdio_device_unregister_reset(struct mdio_device *mdiodev);
 void mdio_device_reset(struct mdio_device *mdiodev, int value);
 int mdio_driver_register(struct mdio_driver *drv);
 void mdio_driver_unregister(struct mdio_driver *drv);
-- 
2.39.5



