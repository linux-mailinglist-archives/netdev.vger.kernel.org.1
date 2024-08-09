Return-Path: <netdev+bounces-117313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B4F94D8AD
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 00:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9EB1C21677
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 22:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8F316A925;
	Fri,  9 Aug 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="etMGsa43"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B91168490
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 22:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723241965; cv=none; b=oHrbWHcXJ9osuzIlyg6NmsKTw23TRdJ1JB1bH+KLLSoW7XaUfhg5Pz2PlCbWaLOvJXd70BZwOntweg+tZEqyH2bjK80SfWT5RpscDutZpjamirQzVXw8wNJ5qIAHBlZO/XW3kD7rrI6M8V+19KfEoeEyUeRJa1R3X/C9JZb7JrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723241965; c=relaxed/simple;
	bh=gmPOdnkynbPb8o+8M20qrSXK3D+4L2DJo03KE1wt0lU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QMVbI+HwEHmdJYU/x0CWqRPbrh6bP4i6kYnt7YptCE0r3PPqK89dwI2m83rCDXJgwf0d6Wh7slD+mbyNkR450wXmYexXswx2tIXSbtRKZXlSya7RnLTNZjhrEMjtv1IWCIN1+ygPvXBx8dF84J1AmmV8nVR4hWb3DkJf7baphCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=etMGsa43; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a94aa5080so309896766b.3
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723241961; x=1723846761; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfYQBpVjHCnCukxlOzKlxaWAalREHgGrteOpSdoYkpA=;
        b=etMGsa43hMUuV5D2noWRHR5lQ6umLuBl4LNS0Sr1gM/jgk7/THWwK+SZZotkn9XXT+
         qq4eLix7rAs7d1yfw30/DV8aZqPHeucct9c2LUA5QCI9H7aitrzR9hRzk0eJjQgYUUeN
         rGr2lGzpe5cywVd/AEMzgQeTn+QFHCxzD6uV5jhwxq6TluM3IjXqiaTkGygadSoboS+B
         5zZCrXtmrOmJEloxA/ROOb0RhnLUIg7picHae/4lSA983P2YzFmsDUAhAANse61MCbaL
         KpFIlVaeXg61uX+h4yaWTritCCgCZEempOXkB6Ygb7UIM45QHI8AxlVPCqtBJCTg1zhs
         mQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723241961; x=1723846761;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfYQBpVjHCnCukxlOzKlxaWAalREHgGrteOpSdoYkpA=;
        b=W5I8fpOsyuvY1oPX+n0u236uMpLwZVCAImJD+b+YXoM/wVhOnihymRSWDYCjEu3bxW
         PmRY5EPJd0J6dZk+KTVb34mZGTAR7gjcFD+x2TzMLB8jeyiqHQ2ZV9FhSnPDvUsRbW05
         4O5JWB9hvjMZZbFVB9A3p5gkH+0+VzotrfZnilgrj8/Q6zGKv9oyQ1NyX1FU7GlJ2D5D
         3PMTgnd6VyW6Mg0ANEj+Qr8wIZ53O2VNdARWV4tgcjiGCf4regEccZyCoGjULXZUCTQZ
         gNo5q71AVY6pTuh1OfoTSfb9ovnpqGcu/m4mcUf9eOdbM3w+YHrmEjBr3FwwB4OAXMMW
         1EpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3mePTEVK/zwM6oNo2S/nPpNTmOFXceIHYVoG9lNOrlz1haPjocjx1JYbrtdI0t+7jV3xkza+LJobQ4nHo7DIYYT2gqFre
X-Gm-Message-State: AOJu0YxNLgMLB1i1vvk+Ktzfi87uHv1oZnIMB0z7iN/0cZl9a7AGfPEL
	hreUc7n5YAYEVLcp9xql4E2fKspWlfd4jlnqfxxLeKfzLBi2a54DIqpUM0gNJABVdQOnGORb2io
	V
X-Google-Smtp-Source: AGHT+IF6yYQK0bBVFro4vjPX/9H68i4+bYh8oAlEzo+mq1L495QxAEOoPSwXBvG3nA0KWRnBH0FVUA==
X-Received: by 2002:a17:907:d5a0:b0:a72:4320:19f3 with SMTP id a640c23a62f3a-a80aa6094dfmr211726066b.39.1723241960471;
        Fri, 09 Aug 2024 15:19:20 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb0e4af1sm15209766b.86.2024.08.09.15.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 15:19:19 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 10 Aug 2024 00:19:12 +0200
Subject: [PATCH RFC v2] net: dsa: mv88e6xxx: Support LED control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240810-mv88e6xxx-leds-v2-1-7417d5336686@linaro.org>
X-B4-Tracking: v=1; b=H4sIAN+VtmYC/3WNQQrDIBRErxL+upaqkJquCoUeoNuSRYzf5EOqR
 YtYgnevuO/yzTBvdogYCCNcuh0CJorkXQVx6GBeJ7cgI1MZxElIzoVkr6QU9jlntqGJTCs9aMl
 7awcFdfQOaCk34RMe9xuMNVwpfnz4tpPEW/XPlzjjTM7yXK1GSKuvG7kp+KMPC4yllB83Ysdqs
 gAAAA==
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

This adds control over the hardware LEDs in the Marvell
MV88E6xxx DSA switch and enables it for MV88E6352.

This fixes an imminent problem on the Inteno XG6846 which
has a WAN LED that simply do not work with hardware
defaults: driver amendment is necessary.

The patch is modeled after Christian Marangis LED support
code for the QCA8k DSA switch, I got help with the register
definitions from Tim Harvey.

After this patch it is possible to activate hardware link
indication like this (or with a similar script):

  cd /sys/class/leds/Marvell\ 88E6352:05:00:green:wan/
  echo netdev > trigger
  echo 1 > link

This makes the green link indicator come up on any link
speed. It is also possible to be more elaborate, like this:

  cd /sys/class/leds/Marvell\ 88E6352:05:00:green:wan/
  echo netdev > trigger
  echo 1 > link_1000
  cd /sys/class/leds/Marvell\ 88E6352:05:01:amber:wan/
  echo netdev > trigger
  echo 1 > link_100

Making the green LED come on for a gigabit link and the
amber LED come on for a 100 mbit link.

After the previous series rewriting the MV88E6xxx DT
bindings to use YAML a "leds" subnode is already valid
for each port, in my scratch device tree it looks like
this:

   leds {
     #address-cells = <1>;
     #size-cells = <0>;

     led@0 {
       reg = <0>;
       color = <LED_COLOR_ID_GREEN>;
       function = LED_FUNCTION_LAN;
       default-state = "off";
       linux,default-trigger = "netdev";
     };
     led@1 {
       reg = <1>;
       color = <LED_COLOR_ID_AMBER>;
       function = LED_FUNCTION_LAN;
       default-state = "off";
     };
   };

This DT config is not yet configuring everything: the netdev
default trigger is assigned by the hw acceleration callbacks are
not called, and there is no way to set the netdev sub-trigger
type from the device tree, such as if you want a gigabit link
indicator. This has to be done from userspace at this point.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
The attempt to make LED support more generic didn't work out
as expected, so proposing to merge the very particular for now.
---
Changes in v2:
- Rebased onto v6.11-rc1
- Make sure to make the LED code mostly optional to compile
  in by a Kconfig option.
- Link to v1: https://lore.kernel.org/r/20231123-mv88e6xxx-leds-v1-1-3c379b3d23fb@linaro.org
---
 drivers/net/dsa/mv88e6xxx/Kconfig  |  10 +
 drivers/net/dsa/mv88e6xxx/Makefile |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c   |  36 +-
 drivers/net/dsa/mv88e6xxx/chip.h   |  12 +
 drivers/net/dsa/mv88e6xxx/leds.c   | 741 +++++++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.c   |   1 +
 drivers/net/dsa/mv88e6xxx/port.h   | 133 +++++++
 7 files changed, 932 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/Kconfig b/drivers/net/dsa/mv88e6xxx/Kconfig
index e3181d5471df..64ae3882d17c 100644
--- a/drivers/net/dsa/mv88e6xxx/Kconfig
+++ b/drivers/net/dsa/mv88e6xxx/Kconfig
@@ -17,3 +17,13 @@ config NET_DSA_MV88E6XXX_PTP
 	help
 	  Say Y to enable PTP hardware timestamping on Marvell 88E6xxx switch
 	  chips that support it.
+
+config NET_DSA_MV88E6XXX_LEDS
+	bool "LED support for Marvell 88E6xxx"
+	default y
+	depends on NET_DSA_MV88E6XXX
+	depends on LEDS_CLASS=y || LEDS_CLASS=NET_DSA_MV88E6XXX
+	depends on LEDS_TRIGGERS
+	help
+	  This enabled support for controlling the LEDs attached to the
+	  Marvell 88E6xxx switch chips.
diff --git a/drivers/net/dsa/mv88e6xxx/Makefile b/drivers/net/dsa/mv88e6xxx/Makefile
index a9a9651187db..dd961081d631 100644
--- a/drivers/net/dsa/mv88e6xxx/Makefile
+++ b/drivers/net/dsa/mv88e6xxx/Makefile
@@ -9,6 +9,7 @@ mv88e6xxx-objs += global2.o
 mv88e6xxx-objs += global2_avb.o
 mv88e6xxx-objs += global2_scratch.o
 mv88e6xxx-$(CONFIG_NET_DSA_MV88E6XXX_PTP) += hwtstamp.o
+mv88e6xxx-$(CONFIG_NET_DSA_MV88E6XXX_LEDS) += leds.o
 mv88e6xxx-objs += pcs-6185.o
 mv88e6xxx-objs += pcs-6352.o
 mv88e6xxx-objs += pcs-639x.o
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5b4e2ce5470d..d2180e6fceaf 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -27,6 +27,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_mdio.h>
 #include <linux/platform_data/mv88e6xxx.h>
+#include <linux/property.h>
 #include <linux/netdevice.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phylink.h>
@@ -3371,14 +3372,44 @@ static int mv88e6xxx_setup_upstream_port(struct mv88e6xxx_chip *chip, int port)
 static int mv88e6xxx_setup_port(struct mv88e6xxx_chip *chip, int port)
 {
 	struct device_node *phy_handle = NULL;
+	struct fwnode_handle *ports_fwnode;
+	struct fwnode_handle *port_fwnode;
 	struct dsa_switch *ds = chip->ds;
+	struct mv88e6xxx_port *p;
 	struct dsa_port *dp;
 	int tx_amp;
 	int err;
 	u16 reg;
+	u32 val;
+
+	p = &chip->ports[port];
+	p->chip = chip;
+	p->port = port;
+
+	/* Look up corresponding fwnode if any */
+	ports_fwnode = device_get_named_child_node(chip->dev, "ethernet-ports");
+	if (!ports_fwnode)
+		ports_fwnode = device_get_named_child_node(chip->dev, "ports");
+	if (ports_fwnode) {
+		fwnode_for_each_child_node(ports_fwnode, port_fwnode) {
+			if (fwnode_property_read_u32(port_fwnode, "reg", &val))
+				continue;
+			if (val == port) {
+				p->fwnode = port_fwnode;
+				p->fiber = fwnode_property_present(port_fwnode, "sfp");
+				break;
+			}
+		}
+	} else {
+		dev_info(chip->dev,
+			 "no ethernet ports node defined for the device\n");
+	}
 
-	chip->ports[port].chip = chip;
-	chip->ports[port].port = port;
+	if (chip->info->ops->port_setup_leds) {
+		err = chip->info->ops->port_setup_leds(chip, port);
+		if (err && err != -EOPNOTSUPP)
+			return err;
+	}
 
 	err = mv88e6xxx_port_setup_mac(chip, port, LINK_UNFORCED,
 				       SPEED_UNFORCED, DUPLEX_UNFORCED,
@@ -5396,6 +5427,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
 	.port_get_cmode = mv88e6352_port_get_cmode,
+	.port_setup_leds = mv88e6xxx_port_setup_leds,
 	.port_setup_message_port = mv88e6xxx_setup_message_port,
 	.stats_snapshot = mv88e6320_g1_stats_snapshot,
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index c34caf9815c5..01a693448ef2 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -13,7 +13,9 @@
 #include <linux/irq.h>
 #include <linux/gpio/consumer.h>
 #include <linux/kthread.h>
+#include <linux/leds.h>
 #include <linux/phy.h>
+#include <linux/property.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/timecounter.h>
 #include <net/dsa.h>
@@ -275,6 +277,7 @@ struct mv88e6xxx_vlan {
 struct mv88e6xxx_port {
 	struct mv88e6xxx_chip *chip;
 	int port;
+	struct fwnode_handle *fwnode;
 	struct mv88e6xxx_vlan bridge_pvid;
 	u64 serdes_stats[2];
 	u64 atu_member_violation;
@@ -289,6 +292,12 @@ struct mv88e6xxx_port {
 	struct devlink_region *region;
 	void *pcs_private;
 
+	/* LED related information */
+	bool fiber;
+	struct led_classdev led0;
+	struct led_classdev led1;
+	u16 ledreg;
+
 	/* MacAuth Bypass control flag */
 	bool mab;
 };
@@ -572,6 +581,9 @@ struct mv88e6xxx_ops {
 			      phy_interface_t mode);
 	int (*port_get_cmode)(struct mv88e6xxx_chip *chip, int port, u8 *cmode);
 
+	/* LED control */
+	int (*port_setup_leds)(struct mv88e6xxx_chip *chip, int port);
+
 	/* Some devices have a per port register indicating what is
 	 * the upstream port this port should forward to.
 	 */
diff --git a/drivers/net/dsa/mv88e6xxx/leds.c b/drivers/net/dsa/mv88e6xxx/leds.c
new file mode 100644
index 000000000000..1f9c597ecaba
--- /dev/null
+++ b/drivers/net/dsa/mv88e6xxx/leds.c
@@ -0,0 +1,741 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/bitfield.h>
+#include <linux/leds.h>
+#include <linux/property.h>
+
+#include "chip.h"
+#include "global2.h"
+#include "port.h"
+
+/* Offset 0x16: LED control */
+
+static int mv88e6xxx_led_brightness_set(struct mv88e6xxx_port *p, int led,
+					int brightness)
+{
+	u16 reg;
+
+	reg = p->ledreg;
+
+	if (led == 1)
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK;
+	else
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK;
+
+	if (brightness) {
+		/* Selector 0x0f == Force LED ON */
+		if (led == 1)
+			reg |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELF;
+		else
+			reg |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELF;
+	} else {
+		/* Selector 0x0e == Force LED OFF */
+		if (led == 1)
+			reg |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELE;
+		else
+			reg |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELE;
+	}
+
+	p->ledreg = reg;
+
+	reg |= MV88E6XXX_PORT_LED_CONTROL_UPDATE;
+	reg |= MV88E6XXX_PORT_LED_CONTROL_POINTER_LED01_CTRL;
+
+	return mv88e6xxx_port_write(p->chip, p->port, MV88E6XXX_PORT_LED_CONTROL, reg);
+}
+
+static int mv88e6xxx_led0_brightness_set_blocking(struct led_classdev *ldev,
+						  enum led_brightness brightness)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_brightness_set(p, 0, brightness);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+static int mv88e6xxx_led1_brightness_set_blocking(struct led_classdev *ldev,
+						  enum led_brightness brightness)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_brightness_set(p, 1, brightness);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+struct mv88e6xxx_led_hwconfig {
+	int led;
+	u8 portmask;
+	unsigned long rules;
+	bool fiber;
+	bool blink_activity;
+	u16 selector;
+};
+
+/* The following is a lookup table to check what rules we can support on a
+ * certain LED given restrictions such as that some rules only work with fiber
+ * (SFP) connections and some blink on activity by default.
+ */
+#define MV88E6XXX_PORTS_0_3 (BIT(0)|BIT(1)|BIT(2)|BIT(3))
+#define MV88E6XXX_PORTS_4_5 (BIT(4)|BIT(5))
+#define MV88E6XXX_PORT_4 BIT(4)
+#define MV88E6XXX_PORT_5 BIT(5)
+
+/* Entries are listed in selector order */
+static const struct mv88e6xxx_led_hwconfig mv88e6xxx_led_hwconfigs[] = {
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORT_4,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL0,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORT_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL0,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL1,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10)|BIT(TRIGGER_NETDEV_LINK_100),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL1,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_4_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100),
+		.blink_activity = true,
+		.fiber = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL1,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_4_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.fiber = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL1,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL2,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10)|BIT(TRIGGER_NETDEV_LINK_100),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL2,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_4_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.fiber = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL2,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_4_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100),
+		.blink_activity = true,
+		.fiber = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL2,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL3,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_1000),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL3,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_4_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.fiber = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL3,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORT_4,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL4,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORT_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL5,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL6,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL6,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORT_4,
+		.rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL6,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORT_5,
+		.rules = BIT(TRIGGER_NETDEV_FULL_DUPLEX),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL6,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL7,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL7,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL8,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL8,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORT_5,
+		.rules = BIT(TRIGGER_NETDEV_LINK),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL8,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SEL9,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SEL9,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_10),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SELA,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SELA,
+	},
+	{
+		.led = 0,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED0_SELB,
+	},
+	{
+		.led = 1,
+		.portmask = MV88E6XXX_PORTS_0_3,
+		.rules = BIT(TRIGGER_NETDEV_LINK_100)|BIT(TRIGGER_NETDEV_LINK_1000),
+		.blink_activity = true,
+		.selector = MV88E6XXX_PORT_LED_CONTROL_LED1_SELB,
+	},
+};
+
+/* mv88e6xxx_led_match_selector() - look up the appropriate LED mode selector
+ * @p: port state container
+ * @led: LED number, 0 or 1
+ * @blink_activity: blink the LED (usually blink on indicated activity)
+ * @fiber: the link is connected to fiber such as SFP
+ * @rules: LED status flags from the LED classdev core
+ * @selector: fill in the selector in this parameter with an OR operation
+ */
+static int mv88e6xxx_led_match_selector(struct mv88e6xxx_port *p, int led, bool blink_activity,
+					bool fiber, unsigned long rules, u16 *selector)
+{
+	const struct mv88e6xxx_led_hwconfig *conf;
+	int i;
+
+	/* No rules means we turn the LED off */
+	if (!rules) {
+		if (led == 1)
+			*selector |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELE;
+		else
+			*selector |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELE;
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mv88e6xxx_led_hwconfigs); i++) {
+		conf = &mv88e6xxx_led_hwconfigs[i];
+
+		if (conf->led != led)
+			continue;
+
+		if (!(conf->portmask & BIT(p->port)))
+			continue;
+
+		if (conf->blink_activity != blink_activity)
+			continue;
+
+		if (conf->fiber != fiber)
+			continue;
+
+		if (conf->rules == rules) {
+			*selector |= conf->selector;
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/* mv88e6xxx_led_get_selector() - get the appropriate LED mode selector
+ * @p: port state container
+ * @led: LED number, 0 or 1
+ * @fiber: the link is connected to fiber such as SFP
+ * @rules: LED status flags from the LED classdev core
+ * @selector: fill in the selector in this parameter with an OR operation
+ */
+static int mv88e6xxx_led_get_selector(struct mv88e6xxx_port *p, int led,
+				      bool fiber, unsigned long rules, u16 *selector)
+{
+	int err;
+
+	/* What happens here is that we first try to locate a trigger with solid
+	 * indicator (such as LED is on for a 1000 link) else we try a second
+	 * sweep to find something suitable with a trigger that will blink on
+	 * activity.
+	 */
+	err = mv88e6xxx_led_match_selector(p, led, false, fiber, rules, selector);
+	if (err)
+		return mv88e6xxx_led_match_selector(p, led, true, fiber, rules, selector);
+
+	return 0;
+}
+
+/* Sets up the hardware blinking period */
+static int mv88e6xxx_led_set_blinking_period(struct mv88e6xxx_port *p, int led,
+					     unsigned long *delay_on, unsigned long *delay_off)
+{
+	unsigned long period;
+	u16 reg;
+
+	period = *delay_on + *delay_off;
+
+	reg = 0;
+
+	switch (period) {
+	case 21:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_21MS;
+		break;
+	case 42:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_42MS;
+		break;
+	case 84:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_84MS;
+		break;
+	case 168:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_168MS;
+		break;
+	case 336:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_336MS;
+		break;
+	case 672:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_672MS;
+		break;
+	default:
+		/* Fall back to software blinking */
+		return -EINVAL;
+	}
+
+	/* This is essentially PWM duty cycle: how long time of the period
+	 * will the LED be on. Zero isn't great in most cases.
+	 */
+	switch (*delay_on) {
+	case 0:
+		/* This is usually pretty useless and will make the LED look OFF */
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_NONE;
+		break;
+	case 21:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_21MS;
+		break;
+	case 42:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_42MS;
+		break;
+	case 84:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_84MS;
+		break;
+	case 168:
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_168MS;
+		break;
+	default:
+		/* Just use something non-zero */
+		reg |= MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_21MS;
+		*delay_on = 21;
+		break;
+	}
+
+	reg |= MV88E6XXX_PORT_LED_CONTROL_UPDATE;
+	/* Set up blink rate */
+	reg |= MV88E6XXX_PORT_LED_CONTROL_POINTER_STRETCH_BLINK;
+
+	return mv88e6xxx_port_write(p->chip, p->port, MV88E6XXX_PORT_LED_CONTROL, reg);
+}
+
+static int mv88e6xxx_led_blink_set(struct mv88e6xxx_port *p, int led,
+				   unsigned long *delay_on, unsigned long *delay_off)
+{
+	u16 reg;
+	int err;
+
+	/* Choose a sensible default 336 ms (~3 Hz) */
+	if ((*delay_on == 0) && (*delay_off == 0)) {
+		*delay_on = 168;
+		*delay_off = 168;
+	}
+
+	/* No off delay is just on */
+	if (*delay_off == 0)
+		return mv88e6xxx_led_brightness_set(p, led, 1);
+
+	err = mv88e6xxx_led_set_blinking_period(p, led, delay_on, delay_off);
+	if (err)
+		return err;
+
+	reg = p->ledreg;
+
+	if (led == 1)
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK;
+	else
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK;
+
+	/* This will select the forced blinking status */
+	if (led == 1)
+		reg |= MV88E6XXX_PORT_LED_CONTROL_LED1_SELD;
+	else
+		reg |= MV88E6XXX_PORT_LED_CONTROL_LED0_SELD;
+
+	p->ledreg = reg;
+
+	reg |= MV88E6XXX_PORT_LED_CONTROL_UPDATE;
+	reg |= MV88E6XXX_PORT_LED_CONTROL_POINTER_LED01_CTRL;
+
+	return mv88e6xxx_port_write(p->chip, p->port, MV88E6XXX_PORT_LED_CONTROL, reg);
+}
+
+static int mv88e6xxx_led0_blink_set(struct led_classdev *ldev,
+				    unsigned long *delay_on,
+				    unsigned long *delay_off)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_blink_set(p, 0, delay_on, delay_off);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+static int mv88e6xxx_led1_blink_set(struct led_classdev *ldev,
+				    unsigned long *delay_on,
+				    unsigned long *delay_off)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_blink_set(p, 1, delay_on, delay_off);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+static int
+mv88e6xxx_led0_hw_control_is_supported(struct led_classdev *ldev, unsigned long rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+	u16 selector = 0;
+
+	return mv88e6xxx_led_get_selector(p, 0, p->fiber, rules, &selector);
+}
+
+static int
+mv88e6xxx_led1_hw_control_is_supported(struct led_classdev *ldev, unsigned long rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+	u16 selector = 0;
+
+	return mv88e6xxx_led_get_selector(p, 1, p->fiber, rules, &selector);
+}
+
+static int mv88e6xxx_led_hw_control_set(struct mv88e6xxx_port *p,
+					int led, unsigned long rules)
+{
+	u16 reg;
+	int err;
+
+	reg = p->ledreg;
+
+	if (led == 1)
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK;
+	else
+		reg &= ~MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK;
+
+	err = mv88e6xxx_led_get_selector(p, led, p->fiber, rules, &reg);
+	if (err)
+		return err;
+
+	p->ledreg = reg;
+
+	reg |= MV88E6XXX_PORT_LED_CONTROL_UPDATE;
+	reg |= MV88E6XXX_PORT_LED_CONTROL_POINTER_LED01_CTRL;
+
+	if (led == 0)
+		dev_dbg(p->chip->dev, "LED 0 hw control on port %d trigger selector 0x%02x\n",
+			p->port,
+			(unsigned int)(p->ledreg & MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK));
+	else
+		dev_dbg(p->chip->dev, "LED 1 hw control on port %d trigger selector 0x%02x\n",
+			p->port,
+			(unsigned int)(p->ledreg & MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK) >> 4);
+
+	err = mv88e6xxx_port_write(p->chip, p->port, MV88E6XXX_PORT_LED_CONTROL, reg);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int
+mv88e6xxx_led_hw_control_get(struct mv88e6xxx_port *p, int led, unsigned long *rules)
+{
+	/* The hardware register cannot be read: no initial state determined */
+	return -EINVAL;
+}
+
+static int
+mv88e6xxx_led0_hw_control_set(struct led_classdev *ldev, unsigned long rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_hw_control_set(p, 0, rules);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+static int
+mv88e6xxx_led1_hw_control_set(struct led_classdev *ldev, unsigned long rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+	int err;
+
+	mv88e6xxx_reg_lock(p->chip);
+	err = mv88e6xxx_led_hw_control_set(p, 1, rules);
+	mv88e6xxx_reg_unlock(p->chip);
+
+	return err;
+}
+
+static int
+mv88e6xxx_led0_hw_control_get(struct led_classdev *ldev, unsigned long *rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+
+	return mv88e6xxx_led_hw_control_get(p, 0, rules);
+}
+
+static int
+mv88e6xxx_led1_hw_control_get(struct led_classdev *ldev, unsigned long *rules)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+
+	return mv88e6xxx_led_hw_control_get(p, 1, rules);
+}
+
+static struct device *mv88e6xxx_led_hw_control_get_device(struct mv88e6xxx_port *p)
+{
+	struct dsa_port *dp;
+
+	dp = dsa_to_port(p->chip->ds, p->port);
+	if (!dp)
+		return NULL;
+	if (dp->user)
+		return &dp->user->dev;
+	return NULL;
+}
+
+static struct device *
+mv88e6xxx_led0_hw_control_get_device(struct led_classdev *ldev)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led0);
+
+	return mv88e6xxx_led_hw_control_get_device(p);
+}
+
+static struct device *
+mv88e6xxx_led1_hw_control_get_device(struct led_classdev *ldev)
+{
+	struct mv88e6xxx_port *p = container_of(ldev, struct mv88e6xxx_port, led1);
+
+	return mv88e6xxx_led_hw_control_get_device(p);
+}
+
+int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port)
+{
+	struct fwnode_handle *led = NULL, *leds = NULL;
+	struct led_init_data init_data = { };
+	unsigned long delay_off = 168;
+	unsigned long delay_on = 168;
+	enum led_default_state state;
+	struct mv88e6xxx_port *p;
+	struct led_classdev *l;
+	struct device *dev;
+	u32 led_num;
+	int ret;
+
+	/* LEDs are on ports 1,2,3,4, 5 and 6 (index 0..5), no more */
+	if (port > 5)
+		return -EOPNOTSUPP;
+
+	p = &chip->ports[port];
+	if (!p->fwnode)
+		return 0;
+	p->ledreg = 0;
+
+	dev = chip->dev;
+
+	leds = fwnode_get_named_child_node(p->fwnode, "leds");
+	if (!leds) {
+		dev_info(dev, "No Leds node specified in device tree for port %d!\n",
+			 port);
+		return 0;
+	}
+
+	fwnode_for_each_child_node(leds, led) {
+		/* Reg represent the led number of the port, max 2
+		 * LEDs can be connected to each port, in some designs
+		 * only one LED is connected.
+		 */
+		if (fwnode_property_read_u32(led, "reg", &led_num))
+			continue;
+		if (led_num > 1) {
+			dev_err(dev, "invalid LED specified port %d\n", port);
+			continue;
+		}
+
+		if (led_num == 0)
+			l = &p->led0;
+		else
+			l = &p->led1;
+
+		state = led_init_default_state_get(led);
+		switch (state) {
+		case LEDS_DEFSTATE_ON:
+			l->brightness = 1;
+			mv88e6xxx_led_brightness_set(p, led_num, 1);
+			break;
+		case LEDS_DEFSTATE_KEEP:
+			break;
+		default:
+			l->brightness = 0;
+			mv88e6xxx_led_brightness_set(p, led_num, 0);
+		}
+
+		/* Default blinking period for LEDs */
+		mv88e6xxx_led_set_blinking_period(p, led_num, &delay_on, &delay_off);
+
+		l->max_brightness = 1;
+		if (led_num == 0) {
+			l->brightness_set_blocking = mv88e6xxx_led0_brightness_set_blocking;
+			l->blink_set = mv88e6xxx_led0_blink_set;
+			l->hw_control_is_supported = mv88e6xxx_led0_hw_control_is_supported;
+			l->hw_control_set = mv88e6xxx_led0_hw_control_set;
+			l->hw_control_get = mv88e6xxx_led0_hw_control_get;
+			l->hw_control_get_device = mv88e6xxx_led0_hw_control_get_device;
+		} else {
+			l->brightness_set_blocking = mv88e6xxx_led1_brightness_set_blocking;
+			l->blink_set = mv88e6xxx_led1_blink_set;
+			l->hw_control_is_supported = mv88e6xxx_led1_hw_control_is_supported;
+			l->hw_control_set = mv88e6xxx_led1_hw_control_set;
+			l->hw_control_get = mv88e6xxx_led1_hw_control_get;
+			l->hw_control_get_device = mv88e6xxx_led1_hw_control_get_device;
+		}
+		l->hw_control_trigger = "netdev";
+
+		init_data.default_label = ":port";
+		init_data.fwnode = led;
+		init_data.devname_mandatory = true;
+		init_data.devicename = kasprintf(GFP_KERNEL, "%s:0%d:0%d", chip->info->name,
+						 port, led_num);
+		if (!init_data.devicename)
+			return -ENOMEM;
+
+		ret = devm_led_classdev_register_ext(dev, l, &init_data);
+		if (ret)
+			dev_err(dev, "Failed to init LED %d for port %d", led_num, port);
+
+		kfree(init_data.devicename);
+	}
+
+	return 0;
+}
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1..d72bba1969f7 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -12,6 +12,7 @@
 #include <linux/if_bridge.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
+#include <linux/property.h>
 
 #include "chip.h"
 #include "global2.h"
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index ddadeb9bfdae..852b1e4a218b 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -309,6 +309,130 @@
 /* Offset 0x13: OutFiltered Counter */
 #define MV88E6XXX_PORT_OUT_FILTERED	0x13
 
+/* Offset 0x16: LED Control */
+#define MV88E6XXX_PORT_LED_CONTROL				0x16
+#define MV88E6XXX_PORT_LED_CONTROL_UPDATE			BIT(15)
+#define MV88E6XXX_PORT_LED_CONTROL_POINTER_MASK			GENMASK(14, 12)
+#define MV88E6XXX_PORT_LED_CONTROL_POINTER_LED01_CTRL		(0x00 << 12) /* Control for LED 0 and 1 */
+#define MV88E6XXX_PORT_LED_CONTROL_POINTER_STRETCH_BLINK	(0x06 << 12) /* Stetch and Blink Rate */
+#define MV88E6XXX_PORT_LED_CONTROL_POINTER_CNTL_SPECIAL		(0x07 << 12) /* Control for the Port's Special LED */
+#define MV88E6XXX_PORT_LED_CONTROL_DATA_MASK			GENMASK(10, 0)
+/* Selection masks valid for either port 1,2,3,4 or 5 */
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL_MASK		GENMASK(3, 0)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL_MASK		GENMASK(7, 4)
+/* Selection control for LED 0 and 1, ports 5 and 6 only has LED 0
+ * Bits  Function
+ * 0..3  LED 0 control selector on ports 1-5
+ * 4..7  LED 1 control selector on ports 1-4 on port 5 this controls LED 0 of port 6
+ *
+ * Sel Port LED Function
+ * 0   1-4  0   Link/Act/Speed by Blink Rate (off=no link, on=link, blink=activity, blink speed=link speed)
+ *     1-4  1   Port 2's Special LED
+ *     5-6  0   Port 5 Link/Act (off=no link, on=link, blink=activity)
+ *     5-6  1   Port 6 Link/Act (off=no link, on=link 1000, blink=activity)
+ * 1   1-4  0   100/1000 Link/Act (off=no link, on=100 or 1000 link, blink=activity)
+ *     1-4  1   10/100 Link Act (off=no link, on=10 or 100 link, blink=activity)
+ *     5-6  0   Fiber 100 Link/Act (off=no link, on=link 100, blink=activity)
+ *     5-6  1   Fiber 1000 Link/Act (off=no link, on=link 1000, blink=activity)
+ * 2   1-4  0   1000 Link/Act (off=no link, on=link 1000, blink=activity)
+ *     1-4  1   10/100 Link/Act (off=no link, on=10 or 100 link, blink=activity)
+ *     5-6  0   Fiber 1000 Link/Act (off=no link, on=link 1000, blink=activity)
+ *     5-6  1   Fiber 100 Link/Act (off=no link, on=link 100, blink=activity)
+ * 3   1-4  0   Link/Act (off=no link, on=link, blink=activity)
+ *     1-4  1   1000 Link (off=no link, on=1000 link)
+ *     5-6  0   Port 0's Special LED
+ *     5-6  1   Fiber Link (off=no link, on=link)
+ * 4   1-4  0   Port 0's Special LED
+ *     1-4  1   Port 1's Special LED
+ *     5-6  0   Port 1's Special LED
+ *     5-6  1   Port 5 Link/Act (off=no link, on=link, blink=activity)
+ * 5   1-4  0   Reserved
+ *     1-4  1   Reserved
+ *     5-6  0   Port 2's Special LED
+ *     5-6  1   Port 6 Link (off=no link, on=link)
+ * 6   1-4  0   Duplex/Collision (off=half-duplex,on=full-duplex,blink=collision)
+ *     1-4  1   10/1000 Link/Act (off=no link, on=10 or 1000 link, blink=activity)
+ *     5-6  0   Port 5 Duplex/Collision (off=half-duplex, on=full-duplex, blink=col)
+ *     5-6  1   Port 6 Duplex/Collision (off=half-duplex, on=full-duplex, blink=col)
+ * 7   1-4  0   10/1000 Link/Act (off=no link, on=10 or 1000 link, blink=activity)
+ *     1-4  1   10/1000 Link (off=no link, on=10 or 1000 link)
+ *     5-6  0   Port 5 Link/Act/Speed by Blink rate (off=no link, on=link, blink=activity, blink speed=link speed)
+ *     5-6  1   Port 6 Link/Act/Speed by Blink rate (off=no link, on=link, blink=activity,  blink speed=link speed)
+ * 8   1-4  0   Link (off=no link, on=link)
+ *     1-4  1   Activity (off=no link, blink on=activity)
+ *     5-6  0   Port 6 Link/Act (off=no link, on=link, blink=activity)
+ *     5-6  1   Port 0's Special LED
+ * 9   1-4  0   10 Link (off=no link, on=10 link)
+ *     1-4  1   100 Link (off=no link, on=100 link)
+ *     5-6  0   Reserved
+ *     5-6  1   Port 1's Special LED
+ * a   1-4  0   10 Link/Act (off=no link, on=10 link, blink=activity)
+ *     1-4  1   100 Link/Act (off=no link, on=100 link, blink=activity)
+ *     5-6  0   Reserved
+ *     5-6  1   Port 2's Special LED
+ * b   1-4  0   100/1000 Link (off=no link, on=100 or 1000 link)
+ *     1-4  1   10/100 Link (off=no link, on=100 link, blink=activity)
+ *     5-6  0   Reserved
+ *     5-6  1   Reserved
+ * c     *  *   PTP Act (blink on=PTP activity)
+ * d     *  *   Force Blink
+ * e     *  *   Force Off
+ * f     *  *   Force On
+ */
+/* Select LED0 output */
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL0			0x0
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL1			0x1
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL2			0x2
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL3			0x3
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL4			0x4
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL5			0x5
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL6			0x6
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL7			0x7
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL8			0x8
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SEL9			0x9
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELA			0xa
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELB			0xb
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELC			0xc
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELD			0xd
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELE			0xe
+#define MV88E6XXX_PORT_LED_CONTROL_LED0_SELF			0xf
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL0			(0x0 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL1			(0x1 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL2			(0x2 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL3			(0x3 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL4			(0x4 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL5			(0x5 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL6			(0x6 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL7			(0x7 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL8			(0x8 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SEL9			(0x9 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELA			(0xa << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELB			(0xb << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELC			(0xc << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELD			(0xd << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELE			(0xe << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_LED1_SELF			(0xf << 4)
+/* Stretch and Blink Rate Control (Index 0x06 of LED Control) */
+/* Pulse Stretch Selection for all LED's on this port */
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_NONE	(0 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_21MS	(1 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_42MS	(2 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_84MS	(3 << 4)
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_PULSE_STRETCH_168MS	(4 << 4)
+/* Blink Rate Selection for all LEDs on this port */
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_21MS		0
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_42MS		1
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_84MS		2
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_168MS	3
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_336MS	4
+#define MV88E6XXX_PORT_LED_CONTROL_0x06_BLINK_RATE_672MS	5
+ /* Control for Special LED (Index 0x7 of LED Control on Port0) */
+#define MV88E6XXX_PORT_LED_CONTROL_0x07_P0_LAN_LINKACT_SHIFT	0 /* bits 6:0 LAN Link Activity LED */
+/* Control for Special LED (Index 0x7 of LED Control on Port 1) */
+#define MV88E6XXX_PORT_LED_CONTROL_0x07_P1_WAN_LINKACT_SHIFT	0 /* bits 6:0 WAN Link Activity LED */
+/* Control for Special LED (Index 0x7 of LED Control on Port 2) */
+#define MV88E6XXX_PORT_LED_CONTROL_0x07_P2_PTP_ACT		0 /* bits 6:0 PTP Activity */
+
 /* Offset 0x18: IEEE Priority Mapping Table */
 #define MV88E6390_PORT_IEEE_PRIO_MAP_TABLE			0x18
 #define MV88E6390_PORT_IEEE_PRIO_MAP_TABLE_UPDATE		0x8000
@@ -457,6 +581,15 @@ int mv88e6393x_port_set_cmode(struct mv88e6xxx_chip *chip, int port,
 			      phy_interface_t mode);
 int mv88e6185_port_get_cmode(struct mv88e6xxx_chip *chip, int port, u8 *cmode);
 int mv88e6352_port_get_cmode(struct mv88e6xxx_chip *chip, int port, u8 *cmode);
+#ifdef CONFIG_NET_DSA_MV88E6XXX_LEDS
+int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip, int port);
+#else
+static inline int mv88e6xxx_port_setup_leds(struct mv88e6xxx_chip *chip,
+					    int port)
+{
+	return 0;
+}
+#endif
 int mv88e6xxx_port_drop_untagged(struct mv88e6xxx_chip *chip, int port,
 				 bool drop_untagged);
 int mv88e6xxx_port_set_map_da(struct mv88e6xxx_chip *chip, int port, bool map);

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20231123-mv88e6xxx-leds-b8b9b316ff98

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


