Return-Path: <netdev+bounces-85460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B96F89ACD0
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 22:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B722C2825C5
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B017D4F1E2;
	Sat,  6 Apr 2024 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JmiLBtFz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CBC4EB55
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434451; cv=none; b=sQdqD6KefBjoMG1tRW7FFhCvgfIduZCXMotcOsKwfqiijef7OHT8o6j9g19mRViXNpThSrXIANDJ/EGhWVcAhL+o8AblcvJhxo6C9NIifgwSYM3xQRk9mYkLiq9S4VcwIdXSwPSx+dhiRp9DFz0mnCFIjW/9lC/iPPVDyw9Lq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434451; c=relaxed/simple;
	bh=5c/LeEUlIOtE+8gy1/iUzzqk5iYILTlD+nwjHKT76NQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qOgwr8VRip90Qmj4Dv7iN6UhmvpLm1D5GhIAKQ3aEIblj67ZaulEfS9U3IKBeU8Ru2fUVcZWJuU7vKWD3CqnQlHwezDg9t2EsoJbJVdxJRsGwCjNWLiRJPoHGcwYJfrLttbByAqvnWn9xXFmKIBRAomOa4tqsD7OjHSzU5tfIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JmiLBtFz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=uWtW/XSwpo6clFLMk/FD9MvkIl41Cc/iKiNTFPUgXss=; b=Jm
	iLBtFzK06Jdwv6/oP1I7X8pS6QXkPABOV8FUB7DqT/d+pXtD5CQs1kWDiSNWwP8VYk4rkYv8rE5WC
	s5CpOyqlWv82tCi7jzOS0fjEonNikDrRW5ih9nDYVdj8SkGNe3A2R2oRcOCC90HAyzWJPI3hZJEaC
	ex1DhdscyHtp86U=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCQR-00COA7-Mz; Sat, 06 Apr 2024 22:14:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 06 Apr 2024 15:13:31 -0500
Subject: [PATCH net-next v4 4/8] net: Add helpers for netdev LEDs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-4-eb97665e7f96@lunn.ch>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9120; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=5c/LeEUlIOtE+8gy1/iUzzqk5iYILTlD+nwjHKT76NQ=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEaz/uKh+V3LO7v4F+8eqm92GE9i0a8jJVrCia
 1aDL3QhpHKJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGs/wAKCRDmvw3LpmlM
 hKw8EACno28OT1ZiOqNB04JGNShM48rtF/p2e/vH0uKBYCs3GD0ZFOqDrWt9nvjIugR946b7g2/
 /sphgunymLsGD1dbxbZfILAU4ntA9yVvNc67Z1JrWrkJzYrYfSQ9nryEVJ81ZAHAILIxYaj8D2x
 4qO4nAyJXwfYJtepRhCZaS/S0GxpN/NjXfWA0X1iB+fJsoyKXByGR1ljQOsIq1VMazFTy77NKxl
 YzGwTuyK5vyj0YuyVQxJbrmGdCoJ7pagtyR0Mi2gi7CIylk0L1ynbq5hRkpA2r2EHPIJeGXasGM
 t/nf0g7oNm9q72Ih9vXwnjmCuTHnCUazsgLKjJAt4MknsRU05BxdysERAoEQ8dQ9Qj6usG23kwY
 wOM2/pU/CirFXm211ctI/GNz7Iq/H8E7cfI1M+Ky2CG0qiyXPB0Z+Y5blMVgKOrYA2qLFEn2OUB
 gLwJExmd5339e6CK42zYIxDGmouszBdVqSqObKAwExforZ94DxrG2gZ/K80FMyQ9cZR6QmhKxml
 Sbgtz0X+uc7T8PUGuCqDuaPFHpchMM/u4c6SS7U417Vb/1oP70pIx+I5BPHeyYBYTWdESC3itgZ
 wrcVL63tjMKnhzLsL3zzHNLs/LAYCoz2vgaZL0jivrHsCCC3DrI4sK4M7ZT2HDDyW0paaxmGG2H
 WWtZc6aY1jeLipg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

Add a set of helpers for parsing the standard device tree properties
for LEDs as part of an ethernet device, and registering them with the
LED subsystem. This code can be used by any sort of netdev driver,
including plain MAC, DSA switches or pure switchdev switch driver.

The MAC driver should call netdev_leds_teardown() before destroying
the netdev to ensure the ops cannot be called after unbinding the
device.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 include/net/netdev_leds.h |  50 ++++++++++++
 net/Kconfig               |  11 +++
 net/core/Makefile         |   1 +
 net/core/netdev-leds.c    | 199 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 261 insertions(+)

diff --git a/include/net/netdev_leds.h b/include/net/netdev_leds.h
new file mode 100644
index 000000000000..30053891561c
--- /dev/null
+++ b/include/net/netdev_leds.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Helpers used for creating and managing LEDs on a netdev MAC
+ * driver.
+ */
+
+#ifndef _NET_NETDEV_LEDS_H
+#define _NET_NETDEV_LEDS_H
+
+#include <linux/leds.h>
+#include <linux/types.h>
+
+struct net_device;
+struct list_head;
+
+struct netdev_leds_ops {
+	int (*brightness_set)(struct net_device *ndev, u8 led,
+			      enum led_brightness brightness);
+	int (*blink_set)(struct net_device *ndev, u8 led,
+			 unsigned long *delay_on, unsigned long *delay_off);
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
+void netdev_leds_teardown(struct list_head *list);
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
+static inline void netdev_leds_teardown(struct list_head *list)
+{
+}
+#endif /* CONFIG_NETDEV_LEDS */
+
+#endif /* _NET_PORT_LEDS_H */
diff --git a/net/Kconfig b/net/Kconfig
index 3e57ccf0da27..5301b95744cd 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -516,4 +516,15 @@ config NET_TEST
 
 	  If unsure, say N.
 
+config NETDEV_LEDS
+	bool "NETDEV helper code for MAC LEDs"
+	select LEDS_CLASS
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_NETDEV
+	help
+	  NICs and switches often contain LED controllers. When the LEDs
+	  are part of the MAC, the MAC driver, aka netdev driver, should
+	  make the LEDs available. NETDEV_LEDS offers a small library
+	  of code to help MAC drivers do this.
+
 endif   # if NET
diff --git a/net/core/Makefile b/net/core/Makefile
index 21d6fbc7e884..d04ce07541b5 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -42,3 +42,4 @@ obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
 obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
+obj-$(CONFIG_NETDEV_LEDS) += netdev-leds.o
diff --git a/net/core/netdev-leds.c b/net/core/netdev-leds.c
new file mode 100644
index 000000000000..bea981ff42ea
--- /dev/null
+++ b/net/core/netdev-leds.c
@@ -0,0 +1,199 @@
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
+	netdev_led = kzalloc(sizeof(*netdev_led), GFP_KERNEL);
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
+	err = led_classdev_register_ext(dev, cdev, &init_data);
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
+ * list, which should be unique to the netdev. The ops structure
+ * contains the callbacks needed to control the LEDs.
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
+			of_node_put(leds);
+			of_node_put(led);
+			return err;
+		}
+	}
+	of_node_put(leds);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(netdev_leds_setup);
+
+/**
+ * netdev_leds_teardown - Remove LEDs for a netdev
+ *
+ * @list: list to add LEDs to teardown
+ *
+ * Unregister all LEDs from the given list of LEDS, freeing up any
+ * allocated memory.
+ */
+void netdev_leds_teardown(struct list_head *list)
+{
+	struct netdev_led *netdev_led;
+	struct led_classdev *cdev;
+
+	list_for_each_entry(netdev_led, list, led_list) {
+		cdev = &netdev_led->led_cdev;
+		led_classdev_unregister(cdev);
+		kfree(netdev_led);
+	}
+}
+EXPORT_SYMBOL_GPL(netdev_leds_teardown);

-- 
2.43.0


