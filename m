Return-Path: <netdev+bounces-83523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5AB892C89
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 19:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1545A1F22AEF
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A2E32182;
	Sat, 30 Mar 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Y2ZwjODe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF801E49E
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823559; cv=none; b=Pifqu4hswMA5XYzsj958zp3WJXI3QNQKbLR27edQkRMkswQgtkrUxgiAKMxxWzNdyP+dO2/HqOoTAoYe85J1uvozV651U7aw6OmganBx24jo2qp4vaeQ9PS2LATynf2t0qS6tciLM9KPIlJeutpqOKd41oxCYvCCylX65Pm0H0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823559; c=relaxed/simple;
	bh=IVC7OOvMzW5yXMpAAZzym0vqZZeWLthDjaIG3pm2C3E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnylfAnzqzmsTl+21V0Fu5F+pnXA4yHDQSAEX9Ho1Kyi1luFrxJIJ3gAS2zADuLooWVEEQ+kOU1LVOnYOKFhzpsHWNcxVqHVgscG4nrxsj3DVDEMnBFSIWGIVIHmxll62Lxce196Gn1faPdL9BhS16VBrKjd3EMV3rKxwMlGfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y2ZwjODe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=4JLtN5ibtvhZWx8l7BV8dFoJzk9YF2vVywijAQ/9lkM=; b=Y2
	ZwjODeKizcIAdqv+Kpjonj1YnZDAH92Xkdkr6wuqR2UJT/IMHCHFFYFWd4y0YNoPEZRwU0cSTevsx
	NbyVoKDYRoIFdVmkmHQWdN7qKsdIVTYGXtPAxzV2ZlIqQKGEfOzCVKSe/ft9Dx/WxNG/OdS+CYkOL
	cvdsH9E1E0s7vZQ=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqdVH-00Bjfq-I2; Sat, 30 Mar 2024 19:32:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 30 Mar 2024 13:31:59 -0500
Subject: [PATCH net-next v2 2/7] net: Add helpers for netdev LEDs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-2-fc5beb9febc5@lunn.ch>
References: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
In-Reply-To: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9080; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=IVC7OOvMzW5yXMpAAZzym0vqZZeWLthDjaIG3pm2C3E=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCFq1duwVouKTvF77c9nr+3n5jQZ9kAJpw6syA
 f825FIfcy+JAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZghatQAKCRDmvw3LpmlM
 hJy9EACPAPYi8H6LElsrW+bRNKRKq2+XxWWrFhJE0TRWxSQR+e0bmZd4TtLpSVWleW8IKPji+dE
 ALK6xr2g2WxEC63Cd9x8E7YMofvVQICNFD04VQNIFsSMoBkMLNyLQ9VF86CZYIXV9f2VDsOG22Q
 3CCHA9bDlbj3NDLjRsmYOlAgrxnpvpNtX4tcQgrohvnmhMhLljXilHGeVGob6f2Vr887ZX+46rz
 EDrcreWx4d8Hz7tPUIva3DS+ooToQmr5AfsGm5R57qE8VzjHCRHfJ50b+FliHEjWEQSEA62fKDI
 wFjddi8tJhM7x9KMQYyVeMebiuwogG24ApficunqoabRt5iGFaU7yS69TBpMAOYhxJFLHZ5XSUL
 vm+AAqdmN60kSFvjr8LMh7qlVkkyUWE8t91BGVElHfFHtLi72wnZGV4nrjTKZYtsULglVlnLlOB
 REvATktAZ/xguasNsQLoXa3RI5oaz76oxs4A6MNRjUGyFX5Uk4NHU4ADyovTD44ATD+MuEXCpRJ
 RO2aLIFtmeP+yxaCKjZ5gZou9n61rLqaJUrQykIgIQUycl4TOVG9Inzf4S6z0mVfCmTAc8ceYv4
 9sYjO9sEpPe3b6wVFM3jgpfwCYeSTE9gvp9jYD28QVlHhczQAztovX3iNY6ftN/sO/81+GpXXaR
 X3Ju+z+/1l+qbAQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Add a set of helpers for parsing the standard device tree properties
for LEDs as part of an ethernet device, and registering them with the
LED subsystem. This code can be used by any sort of netdev driver,
including plain MAC, DSA switches or pure switchdev switch driver.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/net/netdev_leds.h |  45 +++++++++++
 net/Kconfig               |  11 +++
 net/core/Makefile         |   1 +
 net/core/netdev-leds.c    | 201 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 258 insertions(+)

diff --git a/include/net/netdev_leds.h b/include/net/netdev_leds.h
new file mode 100644
index 000000000000..239f492f29f5
--- /dev/null
+++ b/include/net/netdev_leds.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Helpers used for creating and managing LEDs on a netdev MAC
+ * driver.
+ */
+
+#ifndef _NET_NETDEV_LEDS_H
+#define _NET_NETDEV_LEDS_H
+
+struct netdev_leds_ops {
+	int (*brightness_set)(struct net_device *ndev, u8 led,
+			      enum led_brightness brightness);
+	int (*blink_set)(struct net_device *ndev, u8 led,
+			 unsigned long *delay_on,  unsigned long *delay_off);
+	int (*hw_control_is_supported)(struct net_device *ndev, u8 led,
+				       unsigned long flags);
+	int (*hw_control_set)(struct net_device *ndev, u8 led,
+			      unsigned long flags);
+	int (*hw_control_get)(struct net_device *ndev, u8 led,
+			      unsigned long *flags);
+};
+
+#ifdef CONFIG_NETDEV_LEDS
+int netdev_leds_setup(struct net_device *ndev, struct device_node *np,
+		      struct list_head *list, struct netdev_leds_ops *ops,
+		      int max_leds);
+
+void netdev_leds_teardown(struct list_head *list, struct net_device *ndev);
+
+#else
+static inline int netdev_leds_setup(struct net_device *ndev,
+				    struct device_node *np,
+				    struct list_head *list,
+				    struct netdev_leds_ops *ops)
+{
+	return 0;
+}
+
+static inline void netdev_leds_teardown(struct list_head *list,
+					struct net_device *ndev)
+{
+}
+#endif /* CONFIG_NETDEV_LEDS */
+
+#endif /* _NET_PORT_LEDS_H */
diff --git a/net/Kconfig b/net/Kconfig
index 3e57ccf0da27..96b1543b5c6f 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -516,4 +516,15 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config NETDEV_LEDS
+	bool "NETDEV helper code for MAC LEDs"
+	depends on LEDS_CLASS
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_NETDEV
+	help
+	  NICs and Switches often contain LED controllers. When the LEDs
+	  are part of the MAC, the MAC driver, aka netdev driver, should
+	  make the LEDs available. NETDEV_LEDS offers a small library
+	  of code to help MAC drivers do this.
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index 6e6548011fae..9d887af68837 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
 obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += gso_test.o
+obj-$(CONFIG_NETDEV_LEDS) += netdev-leds.o
diff --git a/net/core/netdev-leds.c b/net/core/netdev-leds.c
new file mode 100644
index 000000000000..802dd819a991
--- /dev/null
+++ b/net/core/netdev-leds.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <net/netdev_leds.h>
+
+struct netdev_led {
+	struct list_head led_list;
+	struct led_classdev led_cdev;
+	struct netdev_leds_ops *ops;
+	struct net_device *ndev;
+	u8 index;
+};
+
+#define to_netdev_led(d) container_of(d, struct netdev_led, led_cdev)
+
+static int netdev_brightness_set(struct led_classdev *led_cdev,
+				 enum led_brightness value)
+{
+	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
+
+	return netdev_led->ops->brightness_set(netdev_led->ndev,
+					       netdev_led->index,
+					       value);
+}
+
+static int netdev_blink_set(struct led_classdev *led_cdev,
+			    unsigned long *delay_on, unsigned long *delay_off)
+{
+	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
+
+	return netdev_led->ops->blink_set(netdev_led->ndev,
+					  netdev_led->index,
+					  delay_on, delay_off);
+}
+
+static __maybe_unused int
+netdev_hw_control_is_supported(struct led_classdev *led_cdev,
+			       unsigned long flags)
+{
+	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
+
+	return netdev_led->ops->hw_control_is_supported(netdev_led->ndev,
+							netdev_led->index,
+							flags);
+}
+
+static __maybe_unused int netdev_hw_control_set(struct led_classdev *led_cdev,
+						unsigned long flags)
+{
+	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
+
+	return netdev_led->ops->hw_control_set(netdev_led->ndev,
+					       netdev_led->index,
+					       flags);
+}
+
+static __maybe_unused int netdev_hw_control_get(struct led_classdev *led_cdev,
+						unsigned long *flags)
+{
+	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
+
+	return netdev_led->ops->hw_control_get(netdev_led->ndev,
+					       netdev_led->index,
+					       flags);
+}
+
+static struct device *
+netdev_hw_control_get_device(struct led_classdev *led_cdev)
+{
+	struct netdev_led *netdev_led = to_netdev_led(led_cdev);
+
+	return &netdev_led->ndev->dev;
+}
+
+static int netdev_led_setup(struct net_device *ndev, struct device_node *led,
+			    struct list_head *list, struct netdev_leds_ops *ops,
+			    int max_leds)
+{
+	struct led_init_data init_data = {};
+	struct device *dev = &ndev->dev;
+	struct netdev_led *netdev_led;
+	struct led_classdev *cdev;
+	u32 index;
+	int err;
+
+	netdev_led = devm_kzalloc(dev, sizeof(*netdev_led), GFP_KERNEL);
+	if (!netdev_led)
+		return -ENOMEM;
+
+	netdev_led->ndev = ndev;
+	netdev_led->ops = ops;
+	cdev = &netdev_led->led_cdev;
+
+	err = of_property_read_u32(led, "reg", &index);
+	if (err)
+		return err;
+
+	if (index >= max_leds)
+		return -EINVAL;
+
+	netdev_led->index = index;
+
+	if (ops->brightness_set)
+		cdev->brightness_set_blocking = netdev_brightness_set;
+	if (ops->blink_set)
+		cdev->blink_set = netdev_blink_set;
+#ifdef CONFIG_LEDS_TRIGGERS
+	if (ops->hw_control_is_supported)
+		cdev->hw_control_is_supported = netdev_hw_control_is_supported;
+	if (ops->hw_control_set)
+		cdev->hw_control_set = netdev_hw_control_set;
+	if (ops->hw_control_get)
+		cdev->hw_control_get = netdev_hw_control_get;
+	cdev->hw_control_trigger = "netdev";
+#endif
+	cdev->hw_control_get_device = netdev_hw_control_get_device;
+	cdev->max_brightness = 1;
+	init_data.fwnode = of_fwnode_handle(led);
+	init_data.devname_mandatory = true;
+
+	init_data.devicename = dev_name(dev);
+	err = devm_led_classdev_register_ext(dev, cdev, &init_data);
+	if (err)
+		return err;
+
+	INIT_LIST_HEAD(&netdev_led->led_list);
+	list_add(&netdev_led->led_list, list);
+
+	return 0;
+}
+
+/**
+ * netdev_leds_setup - Parse DT node and create LEDs for netdev
+ *
+ * @ndev: struct netdev for the MAC
+ * @np: ethernet-node in device tree
+ * @list: list to add LEDs to
+ * @ops: structure of ops to manipulate the LED.
+ * @max_leds: maximum number of LEDs support by netdev.
+ *
+ * Parse the device tree node, as described in
+ * ethernet-controller.yaml, and find any LEDs. For each LED found,
+ * ensure the reg value is less than max_leds, create an LED and
+ * register it with the LED subsystem. The LED will be added to the
+ * list, which can be shared by all netdevs of the device. The ops
+ * structure contains the callbacks needed to control the LEDs.
+ *
+ * Return 0 in success, otherwise an negative error code.
+ */
+int netdev_leds_setup(struct net_device *ndev, struct device_node *np,
+		      struct list_head *list, struct netdev_leds_ops *ops,
+		      int max_leds)
+{
+	struct device_node *leds, *led;
+	int err;
+
+	leds = of_get_child_by_name(np, "leds");
+	if (!leds)
+		return 0;
+
+	for_each_available_child_of_node(leds, led) {
+		err = netdev_led_setup(ndev, led, list, ops, max_leds);
+		if (err) {
+			of_node_put(led);
+			return err;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(netdev_leds_setup);
+
+/**
+ * netdev_leds_teardown - Remove LEDs for a netdev
+ *
+ * @list: list to add LEDs to teardown
+ * @ndev: The netdev for which LEDs should be removed
+ *
+ * Unregister all LEDs for a given netdev, freeing up any allocated
+ * memory.
+ */
+void netdev_leds_teardown(struct list_head *list, struct net_device *ndev)
+{
+	struct netdev_led *netdev_led;
+	struct led_classdev *cdev;
+	struct device *dev;
+
+	list_for_each_entry(netdev_led, list, led_list) {
+		if (netdev_led->ndev != ndev)
+			continue;
+		dev = &netdev_led->ndev->dev;
+		cdev = &netdev_led->led_cdev;
+		devm_led_classdev_unregister(dev, cdev);
+	}
+}
+EXPORT_SYMBOL_GPL(netdev_leds_teardown);

-- 
2.43.0


