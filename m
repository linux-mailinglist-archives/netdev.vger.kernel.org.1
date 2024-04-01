Return-Path: <netdev+bounces-83757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D14893B88
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 15:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3AC828232C
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB0D3F9E7;
	Mon,  1 Apr 2024 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lbLQng5Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB233F9C8
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 13:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978586; cv=none; b=qhqsYlKye7sOrR1T99fkgsKqZjV4PEy7bo9DnlbPqiuHGOBQR5HckByMooFthaoAKw7etT57fv/bvKvl1q9ODYHO0nPgodK6eWBjLaBwMZ6Wl+GwI6Pk61bIwZW6XbD1matRNdAUtgJQ2YZUb0KIOZLy4KHfWiAUKoSYGFynegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978586; c=relaxed/simple;
	bh=eyWWTxPoudNlAZdERrOv9Bwe45r32AgBYq27NFhVTt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aM4ftW7SkWOWFtzb/jTjhrCOwPqeJA9TW7uEp/5Lq8nLaifOO9qGtYjwL5loSumDs8m9lTAAo+ZjVW37B3KBjzKZkHeN5j//+uE6iXSAnyjAsd6X7Tf9vQYu6DFz2ZqiF0JGRXvnw7AhPmI0OZ/harVAPDKKS5krpNjTx/lCcuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lbLQng5Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=88VDQyfelWFzdQfAlUflPNZGjeED3LV01VuBtwMW+6Y=; b=lb
	LQng5QwlyWowf/DMjWM2MQAIAIgYY9WfTvMejDDdnlg9uaTJv5fdyAASGs32Wepxdxq08k5QgdnJo
	Q3hxS9rTH9luDkdaMz4rRXgTjcGF+7FXKFp63fz1UmDZpM0J+25FgVFAHHyRG9JJwUC0XbbdtPyR1
	P+F8KihBwTPl+e8=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrHpl-00BrFx-CB; Mon, 01 Apr 2024 15:36:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 01 Apr 2024 08:35:51 -0500
Subject: [PATCH net-next v3 6/7] dsa: mv88e6xxx: Create port/netdev LEDs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-6-221b3fa55f78@lunn.ch>
References: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
In-Reply-To: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6701; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=eyWWTxPoudNlAZdERrOv9Bwe45r32AgBYq27NFhVTt4=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCrhCzFukQX+FFU3w4DTGz1lP4VItn8JWPGO4V
 EJDb2zRammJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZgq4QgAKCRDmvw3LpmlM
 hLYkEACMd5aJmwkRTVBaPkh2MqInna8l2zlG0NJjlWh5mOKg4YkHWiXphM1g+i9HrDk1L31+Zmt
 mX04vm6C9HjFauTTiLY8naOIJkKXlhPhx6hGSdbAeb5+bouZiVHZLhTEc6nIC+6+8tJTUFx1+qD
 0Kv/18Fi9mbrIH54WBGsRRLbvrUBYd1C4bTLaDdXCtNdNfVrKmmzuoaZaSk3jwCdRpztHVLANsH
 /5nUAQZnozNJwrIOhRf32+cezeP7uV/aj3ig4gffeDqQuhfM/cR3wSaUODWLLwwL4hHPu3vX2vT
 CtDeoONCmfhR8Ylq7fr/J0X0ZXYdauFReH1RWgOYmmujGaLEcBXGA2vLVny23aDuqIA0EEemlVE
 QIqrW0xzln083v0aqsCv04Uh+8crhFNl0NE/UZI8G9zSJ/l8bHRuA4wwGPqV2taHmPOHyl1big2
 GNoGxylLd1cmLuXAWh3qqu8BJbjzdTwwugfQsVDRjSLZIpRxwc4gQNeYCP3IM5aIbq7ZK9JxCKy
 OWAhBP1+R5EL1MtzQWvABvezlONB8vkY20JEX2WbsQT/Uwybdmy8WxyMDNrrjxwGm8lzH9p0EKT
 bczCHEvCV0nfvHWoNo+dk1w+yOoRZREPwoGJB+KIOxeQdtjWika9h7qLiGFkCg5IMMc004rcoQ5
 wnHt1w7E5N7i6LQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the helpers to add LEDs to the user ports when the port is
setup.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/Kconfig |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c  | 117 +++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h  |  12 ++++
 3 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/Kconfig b/drivers/net/dsa/mv88e6xxx/Kconfig
index e3181d5471df..ded5c6b9132b 100644
--- a/drivers/net/dsa/mv88e6xxx/Kconfig
+++ b/drivers/net/dsa/mv88e6xxx/Kconfig
@@ -5,6 +5,7 @@ config NET_DSA_MV88E6XXX
 	select IRQ_DOMAIN
 	select NET_DSA_TAG_EDSA
 	select NET_DSA_TAG_DSA
+	select NETDEV_LEDS
 	help
 	  This driver adds support for most of the Marvell 88E6xxx models of
 	  Ethernet switch chips, except 88E6060.
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3d7e4aa9293a..b8e39dcad2da 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -31,6 +31,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/phylink.h>
 #include <net/dsa.h>
+#include <net/netdev_leds.h>
 
 #include "chip.h"
 #include "devlink.h"
@@ -3129,6 +3130,105 @@ static int mv88e6xxx_switch_reset(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_software_reset(chip);
 }
 
+static int mv88e6xxx_led_brightness_set(struct net_device *ndev,
+					u8 led, enum led_brightness value)
+{
+	struct dsa_switch *ds = dsa_user_to_ds(ndev);
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int port = dsa_user_to_index(ndev);
+	int err;
+
+	if (chip->info->ops->led_brightness_set) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->led_brightness_set(chip, port, led,
+							  value);
+		mv88e6xxx_reg_unlock(chip);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int mv88e6xxx_led_blink_set(struct net_device *ndev, u8 led,
+				   unsigned long *delay_on,
+				   unsigned long *delay_off)
+{
+	struct dsa_switch *ds = dsa_user_to_ds(ndev);
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int port = dsa_user_to_index(ndev);
+	int err;
+
+	if (chip->info->ops->led_blink_set) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->led_blink_set(chip, port, led,
+						     delay_on, delay_off);
+		mv88e6xxx_reg_unlock(chip);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int mv88e6xxx_led_hw_control_is_supported(struct net_device *ndev,
+						 u8 led, unsigned long flags)
+{
+	struct dsa_switch *ds = dsa_user_to_ds(ndev);
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int port = dsa_user_to_index(ndev);
+	int err;
+
+	if (chip->info->ops->led_hw_control_is_supported) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->led_hw_control_is_supported(chip, port,
+								   led, flags);
+		mv88e6xxx_reg_unlock(chip);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int mv88e6xxx_led_hw_control_set(struct net_device *ndev, u8 led,
+					unsigned long flags)
+{
+	struct dsa_switch *ds = dsa_user_to_ds(ndev);
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int port = dsa_user_to_index(ndev);
+	int err;
+
+	if (chip->info->ops->led_hw_control_set) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->led_hw_control_set(chip, port,
+							  led, flags);
+		mv88e6xxx_reg_unlock(chip);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
+static int mv88e6xxx_led_hw_control_get(struct net_device *ndev,
+					u8 led, unsigned long *flags)
+{
+	struct dsa_switch *ds = dsa_user_to_ds(ndev);
+	struct mv88e6xxx_chip *chip = ds->priv;
+	int port = dsa_user_to_index(ndev);
+	int err;
+
+	if (chip->info->ops->led_hw_control_get) {
+		mv88e6xxx_reg_lock(chip);
+		err = chip->info->ops->led_hw_control_get(chip, port,
+							  led, flags);
+		mv88e6xxx_reg_unlock(chip);
+		return err;
+	}
+	return -EOPNOTSUPP;
+}
+
+static struct netdev_leds_ops mv88e6xxx_netdev_leds_ops = {
+	.brightness_set = mv88e6xxx_led_brightness_set,
+	.blink_set = mv88e6xxx_led_blink_set,
+	.hw_control_is_supported = mv88e6xxx_led_hw_control_is_supported,
+	.hw_control_set = mv88e6xxx_led_hw_control_set,
+	.hw_control_get = mv88e6xxx_led_hw_control_get,
+};
+
 static int mv88e6xxx_set_port_mode(struct mv88e6xxx_chip *chip, int port,
 				   enum mv88e6xxx_frame_mode frame,
 				   enum mv88e6xxx_egress_mode egress, u16 etype)
@@ -4006,6 +4106,7 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 
 static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct mv88e6xxx_chip *chip = ds->priv;
 	int err;
 
@@ -4016,13 +4117,26 @@ static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
 			return err;
 	}
 
-	return mv88e6xxx_setup_devlink_regions_port(ds, port);
+	err  = mv88e6xxx_setup_devlink_regions_port(ds, port);
+	if (err)
+		return err;
+
+	if (dp->dn) {
+		err = netdev_leds_setup(dp->user, dp->dn, &chip->leds,
+					&mv88e6xxx_netdev_leds_ops, 2);
+		if (err)
+			mv88e6xxx_teardown_devlink_regions_port(ds, port);
+	}
+	return err;
 }
 
 static void mv88e6xxx_port_teardown(struct dsa_switch *ds, int port)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct mv88e6xxx_chip *chip = ds->priv;
 
+	netdev_leds_teardown(&chip->leds, dp->user);
+
 	mv88e6xxx_teardown_devlink_regions_port(ds, port);
 
 	if (chip->info->ops->pcs_ops &&
@@ -6397,6 +6511,7 @@ static struct mv88e6xxx_chip *mv88e6xxx_alloc_chip(struct device *dev)
 	INIT_LIST_HEAD(&chip->mdios);
 	idr_init(&chip->policies);
 	INIT_LIST_HEAD(&chip->msts);
+	INIT_LIST_HEAD(&chip->leds);
 
 	return chip;
 }
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 64f8bde68ccf..b70e74203b31 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -432,6 +432,9 @@ struct mv88e6xxx_chip {
 
 	/* Bridge MST to SID mappings */
 	struct list_head msts;
+
+	/* LEDs associated to the ports */
+	struct list_head leds;
 };
 
 struct mv88e6xxx_bus_ops {
@@ -668,6 +671,15 @@ struct mv88e6xxx_ops {
 	int (*led_blink_set)(struct mv88e6xxx_chip *chip, int port, u8 led,
 			     unsigned long *delay_on,
 			     unsigned long *delay_off);
+	int (*led_hw_control_is_supported)(struct mv88e6xxx_chip *chip,
+					   int port, u8 led,
+					   unsigned long flags);
+	int (*led_hw_control_set)(struct mv88e6xxx_chip *chip,
+				  int port, u8 led,
+				  unsigned long flags);
+	int (*led_hw_control_get)(struct mv88e6xxx_chip *chip,
+				  int port, u8 led,
+				  unsigned long *flags);
 };
 
 struct mv88e6xxx_irq_ops {

-- 
2.43.0


