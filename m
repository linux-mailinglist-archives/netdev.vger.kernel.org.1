Return-Path: <netdev+bounces-213500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA18B255DF
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068EA1C8252E
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6032F39DD;
	Wed, 13 Aug 2025 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bocF5eoC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EA430AACF
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121400; cv=none; b=MFse8EmJ4GSziS/Gt4gn+17ukd72LXcbUEbJ2SbUj7Wrqa3LbL0KjcjBAG80X2kTWFNTRd6bsuyuJXzivX33a5QCDgB8q80vTSLKuAvAyBpzvsUiwz8hIWV4tPRUuQ2nyb/YwWHiE91PYW99NbYnt9EP5AgDrAz4DMyfzhTX9v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121400; c=relaxed/simple;
	bh=htl+OeOoQ4fkbq/sTdaiCC6S2LOilTUedt4Oka/LDB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+Xk5ArZ1LNuzMXtLRoQ6V1XwHfUTBb+pi9ot2z3ru9WwEHdDSvI5MIooS7pxeyOUeIHHc2rJxC2Vxc7TYmqQ717qgCAC8MCjbwN7X9lEg2fXXJEr43C/LzNAviGAJ9ypf6Ndcp4Bbj1Au62Sp1Smz8iZXl1hABbV8pY6EUe8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bocF5eoC; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce5277b8eso250060e87.2
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 14:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755121395; x=1755726195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkjd0iez/5FPr5JfZkUEbejVS2tse0443ncHCL4cjl0=;
        b=bocF5eoC2SE99H4+AlUBTwntSBx8NqwIXAiQR+Fsr6KnCpVI05rDOmPTtQbNwSQ8+R
         FoqfYQ55URACan3NrySEC2znE8Y/huFY76Jnxhz83cgR70M52t0d1dFjSZkBvniBveWV
         q/QkZnvLGExEF+To/eptGZCImeoaGU5b7kYluTZj6GsCGc8KB68CpU9kDXkj3337Gmgt
         PGy50zUsNXtiuqD/lzbECXf0cOmaHz5W2CV3CrO+r3N7svZG6K1GVKHOvOBIZ0ihxvhj
         L+YBREo3ZikZ/sQjsWnoA7W4tUi6TORr2xgsPbbyyzPhEVUPKfsmiu83vAx8211bXoEw
         bDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121395; x=1755726195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkjd0iez/5FPr5JfZkUEbejVS2tse0443ncHCL4cjl0=;
        b=qg5fsi+i0uHf4ZuhQypm7FoXIse/ds2Dp/7JkUPBrFkg46qUSdjacCAx/9LHES7GWz
         rfZbo7l10xw4KbKlp6FarODXK75+L/ZJss/PyaEE0V8fTjtSiC01ZBnga85nTJ9tvp1a
         4bKQ/6zCm2srS16mIDp/oNf7NClcZSvyFRoWY9QFcT2vcBIy5meZ18j+zbkRuGGrLKcI
         70NJXNvXdHoOAN76jq6LelMilNGVlSNlUKaK+EYdn1EPREVEDsI5Po5xKo/pva0opGyf
         s9t788OI4b0UhhMZTVEFFC91VMSDY2B1ctkHSbejX9+6vQZb0dAWU6woVtwKKZWk/86b
         VyyQ==
X-Gm-Message-State: AOJu0YyOCUC+wv6mZlB2d5xXjZoGgYKmiq9N52zTd5JXEvy5KOJy8KXw
	8q+p7X85IlNiqAEGqLP3evd27IGVlapb0lGxjq/i3d5oemCI/0V3HWn/mkzlU+cN+wk=
X-Gm-Gg: ASbGncuFsJHnT6iSIsN7Yc9xdKNR4Rr5woLZAXVyDeigfV0hRILSOHHddHIzGu9p9v5
	/w2B+MUYmMsVJ5uOHNQtXXTqlrIw6smWQNlt6Bsgzo36uPOTpuURedS3VjXGD7ezaEhFYC8NZqS
	0d3bpb7o9IdTZnnc13hcu8oNVOH4IFhSqjx1Rl3bXCczt6iNzRY8ZxZKk96fxwPhP3rCsgbg+ZE
	R9CgParx5TaX9m8jlOLforIC2ddk/Gy7Q080S+u7JFQJlNMyXf+0BOyueHrGRkV8exZrvL3A23A
	T3ORKCuncfN0b82yxuixYREUer8hYG6+8T2ngjDvzE5njrk/S+hAvIgqDAGTEhvKu8elk9AhH8z
	aT2VdGq2+8DpYv+EO78NWX95saTv1bKtE
X-Google-Smtp-Source: AGHT+IFpCNULbrdQ4bL3NjbtO3DGZ3M3Y1Q/XJBpaT4PSk5F3GgVyIpUTlvE+T0J7ncxvAitFj9ewQ==
X-Received: by 2002:a05:6512:138c:b0:553:2cc1:2bb2 with SMTP id 2adb3069b0e04-55ce4ffd208mr267152e87.6.1755121395364;
        Wed, 13 Aug 2025 14:43:15 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b95a105d4sm4732918e87.160.2025.08.13.14.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:43:14 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Aug 2025 23:43:06 +0200
Subject: [PATCH net-next 4/4] net: dsa: ks8995: Add basic switch set-up
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-ks8995-to-dsa-v1-4-75c359ede3a5@linaro.org>
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
In-Reply-To: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

We start to extend the KS8995 driver by simply registering it
as a DSA device and implementing a few switch callbacks for
STP set-up and such to begin with.

No special tags or other advanced stuff: we use DSA_TAG_NONE
and rely on the default set-up in the switch with the special
DSA tags turned off. This makes the switch wire up properly
to all its PHY's and simple bridge traffic works properly.

After this the bridge DT bindings are respected, ports and their
PHYs get connected to the switch and react appropriately through
the phylib when cables are plugged in etc.

Tested like this in a hacky OpenWrt image:

Bring up conduit interface manually:
ixp4xx_eth c8009000.ethernet eth0: eth0: link up,
  speed 100 Mb/s, full duplex

spi-ks8995 spi0.0: enable port 0
spi-ks8995 spi0.0: set KS8995_REG_PC2 for port 0 to 06
spi-ks8995 spi0.0 lan1: configuring for phy/mii link mode
spi-ks8995 spi0.0 lan1: Link is Up - 100Mbps/Full - flow control rx/tx

PING 169.254.1.1 (169.254.1.1): 56 data bytes
64 bytes from 169.254.1.1: seq=0 ttl=64 time=1.629 ms
64 bytes from 169.254.1.1: seq=1 ttl=64 time=0.951 ms

I also tested SSH from the device to the host and it works fine.

It also works fine to ping the device from the host and to SSH
into the device from the host.

This brings the ks8995 driver to a reasonable state where it can
be used from the current device tree bindings and the existing
device trees in the kernel.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/Kconfig  |   1 +
 drivers/net/dsa/ks8995.c | 398 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 396 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 49326a9a0cffcb55da2068d8463c614cf6465243..202a35d8d06188a3e9bdfbbe135b70ae492f9a7b 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -102,6 +102,7 @@ config NET_DSA_RZN1_A5PSW
 config NET_DSA_KS8995
 	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
 	depends on SPI
+	select NET_DSA_TAG_NONE
 	help
 	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
 	  switches, managed over SPI.
diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index 36f6b2d87712eb95194961efe2df2d784d3aa31f..5c4c83e004773b65b6471bf118ab55c4fbf6abd7 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -3,6 +3,7 @@
  * SPI driver for Micrel/Kendin KS8995M and KSZ8864RMN ethernet switches
  *
  * Copyright (C) 2008 Gabor Juhos <juhosg at openwrt.org>
+ * Copyright (C) 2025 Linus Walleij <linus.walleij@linaro.org>
  *
  * This file was based on: drivers/spi/at25.c
  *     Copyright (C) 2006 David Brownell
@@ -10,6 +11,9 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bits.h>
+#include <linux/if_bridge.h>
+#include <linux/if_vlan.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -17,8 +21,8 @@
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
-
 #include <linux/spi/spi.h>
+#include <net/dsa.h>
 
 #define DRV_VERSION		"0.1.1"
 #define DRV_DESC		"Micrel KS8995 Ethernet switch SPI driver"
@@ -29,18 +33,59 @@
 #define KS8995_REG_ID1		0x01    /* Chip ID1 */
 
 #define KS8995_REG_GC0		0x02    /* Global Control 0 */
+
+#define KS8995_GC0_P5_PHY	BIT(3)	/* Port 5 PHY enabled */
+
 #define KS8995_REG_GC1		0x03    /* Global Control 1 */
 #define KS8995_REG_GC2		0x04    /* Global Control 2 */
+
+#define KS8995_GC2_HUGE		BIT(2)	/* Huge packet support */
+#define KS8995_GC2_LEGAL	BIT(1)	/* Legal size override */
+
 #define KS8995_REG_GC3		0x05    /* Global Control 3 */
 #define KS8995_REG_GC4		0x06    /* Global Control 4 */
+
+#define KS8995_GC4_10BT		BIT(4)	/* Force switch to 10Mbit */
+#define KS8995_GC4_MII_FLOW	BIT(5)	/* MII full-duplex flow control enable */
+#define KS8995_GC4_MII_HD	BIT(6)	/* MII half-duplex mode enable */
+
 #define KS8995_REG_GC5		0x07    /* Global Control 5 */
 #define KS8995_REG_GC6		0x08    /* Global Control 6 */
 #define KS8995_REG_GC7		0x09    /* Global Control 7 */
 #define KS8995_REG_GC8		0x0a    /* Global Control 8 */
 #define KS8995_REG_GC9		0x0b    /* Global Control 9 */
 
-#define KS8995_REG_PC(p, r)	((0x10 * p) + r)	 /* Port Control */
-#define KS8995_REG_PS(p, r)	((0x10 * p) + r + 0xe)  /* Port Status */
+#define KS8995_GC9_SPECIAL	BIT(0)	/* Special tagging mode (DSA) */
+
+/* In DSA the ports 1-4 are numbered 0-3 and the CPU port is port 4 */
+#define KS8995_REG_PC(p, r)	(0x10 + (0x10 * (p)) + (r)) /* Port Control */
+#define KS8995_REG_PS(p, r)	(0x1e + (0x10 * (p)) + (r)) /* Port Status */
+
+#define KS8995_REG_PC0		0x00    /* Port Control 0 */
+#define KS8995_REG_PC1		0x01    /* Port Control 1 */
+#define KS8995_REG_PC2		0x02    /* Port Control 2 */
+#define KS8995_REG_PC3		0x03    /* Port Control 3 */
+#define KS8995_REG_PC4		0x04    /* Port Control 4 */
+#define KS8995_REG_PC5		0x05    /* Port Control 5 */
+#define KS8995_REG_PC6		0x06    /* Port Control 6 */
+#define KS8995_REG_PC7		0x07    /* Port Control 7 */
+#define KS8995_REG_PC8		0x08    /* Port Control 8 */
+#define KS8995_REG_PC9		0x09    /* Port Control 9 */
+#define KS8995_REG_PC10		0x0a    /* Port Control 10 */
+#define KS8995_REG_PC11		0x0b    /* Port Control 11 */
+#define KS8995_REG_PC12		0x0c    /* Port Control 12 */
+#define KS8995_REG_PC13		0x0d    /* Port Control 13 */
+
+#define KS8995_PC0_TAG_INS	BIT(2)	/* Enable tag insertion on port */
+#define KS8995_PC0_TAG_REM	BIT(1)	/* Enable tag removal on port */
+#define KS8995_PC0_PRIO_EN	BIT(0)	/* Enable priority handling */
+
+#define KS8995_PC2_TXEN		BIT(2)	/* Enable TX on port */
+#define KS8995_PC2_RXEN		BIT(1)	/* Enable RX on port */
+#define KS8995_PC2_LEARN_DIS	BIT(0)	/* Disable learning on port */
+
+#define KS8995_PC13_TXDIS	BIT(6)	/* Disable transmitter */
+#define KS8995_PC13_PWDN	BIT(3)	/* Power down */
 
 #define KS8995_REG_TPC0		0x60    /* TOS Priority Control 0 */
 #define KS8995_REG_TPC1		0x61    /* TOS Priority Control 1 */
@@ -91,6 +136,8 @@
 #define KS8995_CMD_WRITE	0x02U
 #define KS8995_CMD_READ		0x03U
 
+#define KS8995_CPU_PORT		4
+#define KS8995_NUM_PORTS	5 /* 5 ports including the CPU port */
 #define KS8995_RESET_DELAY	10 /* usec */
 
 enum ks8995_chip_variant {
@@ -138,11 +185,14 @@ static const struct ks8995_chip_params ks8995_chip[] = {
 
 struct ks8995_switch {
 	struct spi_device	*spi;
+	struct device		*dev;
+	struct dsa_switch	*ds;
 	struct mutex		lock;
 	struct gpio_desc	*reset_gpio;
 	struct bin_attribute	regs_attr;
 	const struct ks8995_chip_params	*chip;
 	int			revision_id;
+	unsigned int max_mtu[KS8995_NUM_PORTS];
 };
 
 static const struct spi_device_id ks8995_id[] = {
@@ -371,6 +421,327 @@ static int ks8995_get_revision(struct ks8995_switch *ks)
 	return err;
 }
 
+static int ks8995_check_config(struct ks8995_switch *ks)
+{
+	int ret;
+	u8 val;
+
+	ret = ks8995_read_reg(ks, KS8995_REG_GC0, &val);
+	if (ret) {
+		dev_err(ks->dev, "failed to read KS8995_REG_GC0\n");
+		return ret;
+	}
+
+	dev_dbg(ks->dev, "port 5 PHY %senabled\n",
+		(val & KS8995_GC0_P5_PHY) ? "" : "not ");
+
+	val |= KS8995_GC0_P5_PHY;
+	ret = ks8995_write_reg(ks, KS8995_REG_GC0, val);
+	if (ret)
+		dev_err(ks->dev, "failed to set KS8995_REG_GC0\n");
+
+	dev_dbg(ks->dev, "set KS8995_REG_GC0 to 0x%02x\n", val);
+
+	return 0;
+}
+
+static void
+ks8995_mac_config(struct phylink_config *config, unsigned int mode,
+		  const struct phylink_link_state *state)
+{
+}
+
+static void
+ks8995_mac_link_up(struct phylink_config *config, struct phy_device *phydev,
+		   unsigned int mode, phy_interface_t interface,
+		   int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ks8995_switch *ks = dp->ds->priv;
+	int port = dp->index;
+	int ret;
+	u8 val;
+
+	/* Allow forcing the mode on the fixed CPU port, no autonegotiation.
+	 * We assume autonegotiation works on the PHY-facing ports.
+	 */
+	if (port != KS8995_CPU_PORT)
+		return;
+
+	dev_dbg(ks->dev, "MAC link up on CPU port (%d)\n", port);
+
+	ret = ks8995_read_reg(ks, KS8995_REG_GC4, &val);
+	if (ret) {
+		dev_err(ks->dev, "failed to read KS8995_REG_GC4\n");
+		return;
+	}
+
+	/* Conjure port config */
+	switch (speed) {
+	case SPEED_10:
+		dev_dbg(ks->dev, "set switch MII to 100Mbit mode\n");
+		val |= KS8995_GC4_10BT;
+		break;
+	case SPEED_100:
+	default:
+		dev_dbg(ks->dev, "set switch MII to 100Mbit mode\n");
+		val &= ~KS8995_GC4_10BT;
+		break;
+	}
+
+	if (duplex == DUPLEX_HALF) {
+		dev_dbg(ks->dev, "set switch MII to half duplex\n");
+		val |= KS8995_GC4_MII_HD;
+	} else {
+		dev_dbg(ks->dev, "set switch MII to full duplex\n");
+		val &= ~KS8995_GC4_MII_HD;
+	}
+
+	dev_dbg(ks->dev, "set KS8995_REG_GC4 to %02x\n", val);
+
+	/* Enable the CPU port */
+	ret = ks8995_write_reg(ks, KS8995_REG_GC4, val);
+	if (ret)
+		dev_err(ks->dev, "failed to set KS8995_REG_GC4\n");
+}
+
+static void
+ks8995_mac_link_down(struct phylink_config *config, unsigned int mode,
+		     phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ks8995_switch *ks = dp->ds->priv;
+	int port = dp->index;
+
+	if (port != KS8995_CPU_PORT)
+		return;
+
+	dev_dbg(ks->dev, "MAC link down on CPU port (%d)\n", port);
+
+	/* Disable the CPU port */
+}
+
+static const struct phylink_mac_ops ks8995_phylink_mac_ops = {
+	.mac_config = ks8995_mac_config,
+	.mac_link_up = ks8995_mac_link_up,
+	.mac_link_down = ks8995_mac_link_down,
+};
+
+static enum
+dsa_tag_protocol ks8995_get_tag_protocol(struct dsa_switch *ds,
+					 int port,
+					 enum dsa_tag_protocol mp)
+{
+	/* This switch actually uses the 6 byte KS8995 protocol */
+	return DSA_TAG_PROTO_NONE;
+}
+
+static int ks8995_setup(struct dsa_switch *ds)
+{
+	return 0;
+}
+
+static int ks8995_port_enable(struct dsa_switch *ds, int port,
+			      struct phy_device *phy)
+{
+	struct ks8995_switch *ks = ds->priv;
+
+	dev_dbg(ks->dev, "enable port %d\n", port);
+
+	return 0;
+}
+
+static void ks8995_port_disable(struct dsa_switch *ds, int port)
+{
+	struct ks8995_switch *ks = ds->priv;
+
+	dev_dbg(ks->dev, "disable port %d\n", port);
+}
+
+static int ks8995_port_pre_bridge_flags(struct dsa_switch *ds, int port,
+					struct switchdev_brport_flags flags,
+					struct netlink_ext_ack *extack)
+{
+	/* We support enabling/disabling learning */
+	if (flags.mask & ~(BR_LEARNING))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ks8995_port_bridge_flags(struct dsa_switch *ds, int port,
+				    struct switchdev_brport_flags flags,
+				    struct netlink_ext_ack *extack)
+{
+	struct ks8995_switch *ks = ds->priv;
+	int ret;
+	u8 val;
+
+	if (flags.mask & BR_LEARNING) {
+		ret = ks8995_read_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC2), &val);
+		if (ret) {
+			dev_err(ks->dev, "failed to read KS8995_REG_PC2 on port %d\n", port);
+			return ret;
+		}
+
+		if (flags.val & BR_LEARNING)
+			val &= ~KS8995_PC2_LEARN_DIS;
+		else
+			val |= KS8995_PC2_LEARN_DIS;
+
+		ret = ks8995_write_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC2), val);
+		if (ret) {
+			dev_err(ks->dev, "failed to write KS8995_REG_PC2 on port %d\n", port);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void ks8995_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
+{
+	struct ks8995_switch *ks = ds->priv;
+	int ret;
+	u8 val;
+
+	ret = ks8995_read_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC2), &val);
+	if (ret) {
+		dev_err(ks->dev, "failed to read KS8995_REG_PC2 on port %d\n", port);
+		return;
+	}
+
+	/* Set the bits for the different STP states in accordance with
+	 * the datasheet, pages 36-37 "Spanning tree support".
+	 */
+	switch (state) {
+	case BR_STATE_DISABLED:
+	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
+		val &= ~KS8995_PC2_TXEN;
+		val &= ~KS8995_PC2_RXEN;
+		val |= KS8995_PC2_LEARN_DIS;
+		break;
+	case BR_STATE_LEARNING:
+		val &= ~KS8995_PC2_TXEN;
+		val &= ~KS8995_PC2_RXEN;
+		val &= ~KS8995_PC2_LEARN_DIS;
+		break;
+	case BR_STATE_FORWARDING:
+		val |= KS8995_PC2_TXEN;
+		val |= KS8995_PC2_RXEN;
+		val &= ~KS8995_PC2_LEARN_DIS;
+		break;
+	default:
+		dev_err(ks->dev, "unknown bridge state requested\n");
+		return;
+	}
+
+	ret = ks8995_write_reg(ks, KS8995_REG_PC(port, KS8995_REG_PC2), val);
+	if (ret) {
+		dev_err(ks->dev, "failed to write KS8995_REG_PC2 on port %d\n", port);
+		return;
+	}
+
+	dev_dbg(ks->dev, "set KS8995_REG_PC2 for port %d to %02x\n", port, val);
+}
+
+static void ks8995_phylink_get_caps(struct dsa_switch *dsa, int port,
+				    struct phylink_config *config)
+{
+	unsigned long *interfaces = config->supported_interfaces;
+
+	if (port == KS8995_CPU_PORT)
+		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
+
+	if (port <= 3) {
+		/* Internal PHYs */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL, interfaces);
+		/* phylib default */
+		__set_bit(PHY_INTERFACE_MODE_MII, interfaces);
+	}
+
+	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100;
+}
+
+/* Huge packet support up to 1916 byte packages "inclusive"
+ * which means that tags are included. If the bit is not set
+ * it is 1536 bytes "inclusive". We present the length without
+ * tags or ethernet headers. The setting affects all ports.
+ */
+static int ks8995_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
+{
+	struct ks8995_switch *ks = ds->priv;
+	unsigned int max_mtu;
+	int ret;
+	u8 val;
+	int i;
+
+	ks->max_mtu[port] = new_mtu;
+
+	/* Roof out the MTU for the entire switch to the greatest
+	 * common denominator: the biggest set for any one port will
+	 * be the biggest MTU for the switch.
+	 */
+	max_mtu = ETH_DATA_LEN;
+	for (i = 0; i < KS8995_NUM_PORTS; i++) {
+		if (ks->max_mtu[i] > max_mtu)
+			max_mtu = ks->max_mtu[i];
+	}
+
+	/* Translate to layer 2 size.
+	 * Add ethernet and (possible) VLAN headers, and checksum to the size.
+	 * For ETH_DATA_LEN (1500 bytes) this will add up to 1522 bytes.
+	 */
+	max_mtu += VLAN_ETH_HLEN;
+	max_mtu += ETH_FCS_LEN;
+
+	ret = ks8995_read_reg(ks, KS8995_REG_GC2, &val);
+	if (ret) {
+		dev_err(ks->dev, "failed to read KS8995_REG_GC2\n");
+		return ret;
+	}
+
+	if (max_mtu <= 1522) {
+		val &= ~KS8995_GC2_HUGE;
+		val &= ~KS8995_GC2_LEGAL;
+	} else if (max_mtu > 1522 && max_mtu <= 1536) {
+		/* This accepts packets up to 1536 bytes */
+		val &= ~KS8995_GC2_HUGE;
+		val |= KS8995_GC2_LEGAL;
+	} else {
+		/* This accepts packets up to 1916 bytes */
+		val |= KS8995_GC2_HUGE;
+		val |= KS8995_GC2_LEGAL;
+	}
+
+	dev_dbg(ks->dev, "new max MTU %d bytes (inclusive)\n", max_mtu);
+
+	ret = ks8995_write_reg(ks, KS8995_REG_GC2, val);
+	if (ret)
+		dev_err(ks->dev, "failed to set KS8995_REG_GC2\n");
+
+	return ret;
+}
+
+static int ks8995_get_max_mtu(struct dsa_switch *ds, int port)
+{
+	return 1916 - ETH_HLEN - ETH_FCS_LEN;
+}
+
+static const struct dsa_switch_ops ks8995_ds_ops = {
+	.get_tag_protocol = ks8995_get_tag_protocol,
+	.setup = ks8995_setup,
+	.port_pre_bridge_flags = ks8995_port_pre_bridge_flags,
+	.port_bridge_flags = ks8995_port_bridge_flags,
+	.port_enable = ks8995_port_enable,
+	.port_disable = ks8995_port_disable,
+	.port_stp_state_set = ks8995_port_stp_state_set,
+	.port_change_mtu = ks8995_change_mtu,
+	.port_max_mtu = ks8995_get_max_mtu,
+	.phylink_get_caps = ks8995_phylink_get_caps,
+};
+
 /* ------------------------------------------------------------------------ */
 static int ks8995_probe(struct spi_device *spi)
 {
@@ -389,6 +760,7 @@ static int ks8995_probe(struct spi_device *spi)
 
 	mutex_init(&ks->lock);
 	ks->spi = spi;
+	ks->dev = &spi->dev;
 	ks->chip = &ks8995_chip[variant];
 
 	ks->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
@@ -435,6 +807,25 @@ static int ks8995_probe(struct spi_device *spi)
 	dev_info(&spi->dev, "%s device found, Chip ID:%x, Revision:%x\n",
 		 ks->chip->name, ks->chip->chip_id, ks->revision_id);
 
+	err = ks8995_check_config(ks);
+	if (err)
+		return err;
+
+	ks->ds = devm_kzalloc(&spi->dev, sizeof(*ks->ds), GFP_KERNEL);
+	if (!ks->ds)
+		return -ENOMEM;
+
+	ks->ds->dev = &spi->dev;
+	ks->ds->num_ports = KS8995_NUM_PORTS;
+	ks->ds->ops = &ks8995_ds_ops;
+	ks->ds->phylink_mac_ops = &ks8995_phylink_mac_ops;
+	ks->ds->priv = ks;
+
+	err = dsa_register_switch(ks->ds);
+	if (err)
+		return dev_err_probe(&spi->dev, err,
+				     "unable to register DSA switch\n");
+
 	return 0;
 }
 
@@ -442,6 +833,7 @@ static void ks8995_remove(struct spi_device *spi)
 {
 	struct ks8995_switch *ks = spi_get_drvdata(spi);
 
+	dsa_unregister_switch(ks->ds);
 	/* assert reset */
 	gpiod_set_value_cansleep(ks->reset_gpio, 1);
 }

-- 
2.50.1


