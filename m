Return-Path: <netdev+bounces-85463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D00D89ACD3
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 22:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653781C215F7
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0F54E1DA;
	Sat,  6 Apr 2024 20:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M4d/j/XQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B164F5F9
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434459; cv=none; b=Td84mTR9fo35YgAlyKDXQ/sHfJQj7zaJAQ5Lq0DG4PB0a8RfQ/Sl3Ht8wS8ldpfR7CLwvgflJKl1y3bP8LhqOPqrZAM5zRa2YYidoNLQ3to3vMAd7yXU9hdaXFCDolJ0cz2qd1iqgrN/JlbFb4HvO7gUIPxDkv86F8T5CpmRHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434459; c=relaxed/simple;
	bh=zdSFNxjfLA1vj0wL9Qk7dYbfsefbjxh136VgsdiSg3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eK3qYuJeXMYR5eaVS98xVX7vrYQfye4T8yVuVAp3xseg/t5qfgCSMFgd13ua0cJgoneCEG8pMhImOsxJ8wuQiZu2Jc/MbKR+2sd8LoVKGzJ7EmqoWw+Q5W+nBsF0WHEt5TMotMh/vsCjelpYzdrG87vrBvyToliLFpD56N8q2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M4d/j/XQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Oqh2XRP/MH/MweeMUWi+g8QbT8VLHwXzrU+lz6qGOH4=; b=M4
	d/j/XQRFuOrPW2mUrqmkcG0AqiOZNrgBDnBJG/TJyYPGrint4iRehKt7OKwYfoinuqPYCyVsMIyqi
	mUN70aBO70MYWaVXzh//gkYL38A9ln9PVshkqZElHKbmM+M/aajEqDtgrVQpw837UVN/nyJZAK96O
	gZbbFYz1jG2V6vI=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCQZ-00COA7-Ma; Sat, 06 Apr 2024 22:14:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 06 Apr 2024 15:13:34 -0500
Subject: [PATCH net-next v4 7/8] dsa: mv88e6xxx: Create port/netdev LEDs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-7-eb97665e7f96@lunn.ch>
References: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
In-Reply-To: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6865; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=zdSFNxjfLA1vj0wL9Qk7dYbfsefbjxh136VgsdiSg3s=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEa0A1GTEDn8nTNCdd6O2tOppxe4UwhAGEE1bJ
 2M8x0Mn4siJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGtAAAKCRDmvw3LpmlM
 hBDgEACjznnHWJx48FGisZW4GAVzSSl19fLaObfL/uG3e9J9/ggBuz30/J8ZOXFqx9NC/xK4eJu
 iQyhM+auHk7yJvpXIeds4YHNseFHLiveUGc6dx5qMuJbHKVieU/50//rrP7yM7A9YLBUEl4zHWT
 5oSBRXSiiQfSDN0ZJNFPn+Lsyyuli9YY7RMUgoum4ZIDSUBgyin75wkhC+coGnT0vKfxc8mURE9
 sRPAiL1VoixJt/eOdhY7eRy0YbI4pXu2BM3+myBH9GEjQstvITFfMTUzI9sNNe+7lo/JU/5DWKz
 kTQ3CDb8Otb2V+VxOFnC3w2Dh8wPiK4LubQywJ1tTYv0tZriipQuWUikqdOZAmnWgDxuzq3ejKi
 V42A9m7kFQBwvOplW2zcsIjQNZdaty2PrDTpB8l9MmQM3eGNTaZX4xzt6pRmElPxQgRVdwlyDtx
 T43Z0qgyHSKFnetGFYX0rlV/UZXuYU15VsP6O2g9c87cquxVV4utNm6JCPZ+6xxhSwHHRLIaxKx
 nLCXy9uH+xBwT1m9ZxQ5S02cTaxM+X4+0Q7dwo/zDVeOJZv3EjOhI0L9IQuk9L1ePqK9rmtlPZx
 mpw7n41GEChCW7D6qLB0m7qsnvA/f9qvLsgB8wHpj5zgXFIqRp2RbRJXxkPg4OK8u3b30BZ7nRg
 hiacV2svsSnlYtg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Make use of the helpers to add LEDs to the user ports when the port is
setup. Also remove the LEDs when the port is destroyed to avoid any
race conditions with users of /sys/class/leds and LED triggers after
the driver has been removed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/Kconfig |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c  | 119 +++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h  |  13 +++++
 3 files changed, 132 insertions(+), 1 deletion(-)

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
index 3d7e4aa9293a..4e4031f11088 100644
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
+	struct dsa_port *dp = dsa_port_from_netdev(ndev);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
+	int port = dp->index;
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
+	struct dsa_port *dp = dsa_port_from_netdev(ndev);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
+	int port = dp->index;
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
+	struct dsa_port *dp = dsa_port_from_netdev(ndev);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
+	int port = dp->index;
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
+	struct dsa_port *dp = dsa_port_from_netdev(ndev);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
+	int port = dp->index;
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
+	struct dsa_port *dp = dsa_port_from_netdev(ndev);
+	struct mv88e6xxx_chip *chip = dp->ds->priv;
+	int port = dp->index;
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
@@ -4006,7 +4106,9 @@ static int mv88e6xxx_setup(struct dsa_switch *ds)
 
 static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
 {
+	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct mv88e6xxx_chip *chip = ds->priv;
+	struct mv88e6xxx_port *p;
 	int err;
 
 	if (chip->info->ops->pcs_ops &&
@@ -4016,13 +4118,28 @@ static int mv88e6xxx_port_setup(struct dsa_switch *ds, int port)
 			return err;
 	}
 
-	return mv88e6xxx_setup_devlink_regions_port(ds, port);
+	err  = mv88e6xxx_setup_devlink_regions_port(ds, port);
+	if (err)
+		return err;
+
+	if (dp->dn && dsa_is_user_port(ds, port)) {
+		p = &chip->ports[port];
+		INIT_LIST_HEAD(&p->leds);
+		err = netdev_leds_setup(dp->user, dp->dn, &p->leds,
+					&mv88e6xxx_netdev_leds_ops, 2);
+		if (err)
+			mv88e6xxx_teardown_devlink_regions_port(ds, port);
+	}
+	return err;
 }
 
 static void mv88e6xxx_port_teardown(struct dsa_switch *ds, int port)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
 
+	if (dsa_is_user_port(ds, port))
+		netdev_leds_teardown(&chip->ports[port].leds);
+
 	mv88e6xxx_teardown_devlink_regions_port(ds, port);
 
 	if (chip->info->ops->pcs_ops &&
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 64f8bde68ccf..d15bb5810831 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -291,6 +291,9 @@ struct mv88e6xxx_port {
 
 	/* MacAuth Bypass control flag */
 	bool mab;
+
+	/* LEDs associated to the port */
+	struct list_head leds;
 };
 
 enum mv88e6xxx_region_id {
@@ -432,6 +435,7 @@ struct mv88e6xxx_chip {
 
 	/* Bridge MST to SID mappings */
 	struct list_head msts;
+
 };
 
 struct mv88e6xxx_bus_ops {
@@ -668,6 +672,15 @@ struct mv88e6xxx_ops {
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


