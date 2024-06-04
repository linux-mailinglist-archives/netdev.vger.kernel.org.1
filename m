Return-Path: <netdev+bounces-100527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D9A8FB017
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650061F235DE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 10:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9048C1465A9;
	Tue,  4 Jun 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZGgVXAhm"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B30145331;
	Tue,  4 Jun 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497616; cv=none; b=N1WPikcIcBC4yLRJOmdhIdeu09voBTSYZ7IsZYdeBn10QwJ4TjYoJ6ZtOlFEIMjC7eg2un1lVzg58vwgtMwvsFM44ENlo6TwMvz8jvPZuEw2bfNPqCuZHpXGDDEr5qBCIao0Rxhc2dpvE8jW7NqXzA4D/cZ8rff1dUfBMpsSGKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497616; c=relaxed/simple;
	bh=zHUPZZHW+ZEur32yOu9bNVrl2FFhAMVvCk/Q3HSZ+HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QfNM+ImrFaKGIT5/Iy1+xxEAKgekZ7go1wWQH44RsZ3hnTSYhqYCB2BdR9QEKj6ViZ2rAzJYloUh3unZcc3ZmZygh0NDxG6OU7vkEyU2K74Cvb+OD7BcJLBWvWzXz0iri5G/ezPQpPEG9wM3dSoHbwm5iVqAjwHZvhLGU0k9P6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZGgVXAhm; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3DAD11BF211;
	Tue,  4 Jun 2024 10:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717497612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/akqxQ8ZFvPLOMVKUlPKOLHsqv0rRfnwElZnZGMC46k=;
	b=ZGgVXAhm0vCMK6z5gM9luwipcnmXX+yYv/4zhgvYb00MTd29cbmOwQjXCXSSuNdmZel15I
	96Hgei4QTJoBcGCDAB4ME5dqAnuMbuGIhlP2pWGRSuruD3GPKFlOnkj7gFUaH3mfrFqzYz
	09/ykD30fgxHzXvypkhMHn6Yo3hjTSrp/REje8+qeQqnTXzE9BM7JFAZULWTa7Aww8nuA6
	DpY46Cfzydr6FOniJvw9wKm3VYk3CYgpSWHm3rCU68KfTFlGXFggJNQCMnQKPLD4oD54Cj
	3MU4UjT9Cp8XXurY9ct00MdzHD/svQwPKYg41Ax/NSQ36OlBHiyHGBg1KwYISg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 04 Jun 2024 12:39:43 +0200
Subject: [PATCH net-next v14 08/14] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-feature_ptp_netnext-v14-8-77b6f6efea40@bootlin.com>
References: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
In-Reply-To: <20240604-feature_ptp_netnext-v14-0-77b6f6efea40@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Radu Pirea <radu-nicolae.pirea@oss.nxp.com>, 
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, 
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: kory.maincent@bootlin.com

Prepare for future hardware timestamp selection by adding source and
corresponding pointers to ptp_clock structure.
Additionally, introduce helpers for registering specific phydev or netdev
PTP clocks, retrieving PTP clock information such as hwtstamp source or
phydev/netdev pointers, and obtaining the ptp_clock structure from the
phc index.
These helpers are added to a new ptp_clock_consumer.c file, built as
builtin. This is necessary because these helpers will be called by
ethtool or net timestamping, which are builtin code.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v8:
- New patch.

Change in v10:
- Add get and put function to avoid unregistering a ptp clock object used.
- Fix kdoc issues.

Change in v11:
- Remove useless extern.

Change in v12:
- Add missing return description in the kdoc.

Change in v13:
- Remove a semicolon which bring errors while not building PTP driver.
- Remove few useless EXPORT_SYMBOL().
- Separate PTP consumer symbole which are builtin from PTP provider.

Change in v14:
- Add back missing EXPORT_SYMBOL().
---
 drivers/ptp/Makefile             |   5 ++
 drivers/ptp/ptp_clock.c          |  33 ++++++++++-
 drivers/ptp/ptp_clock_consumer.c | 100 +++++++++++++++++++++++++++++++
 drivers/ptp/ptp_private.h        |   7 +++
 include/linux/ptp_clock_kernel.h | 125 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 269 insertions(+), 1 deletion(-)

diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 68bf02078053..9d7226b995cf 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -3,6 +3,11 @@
 # Makefile for PTP 1588 clock support.
 #
 
+ifdef CONFIG_PTP_1588_CLOCK
+# The ptp_clock consumer is built-in whenever PTP_1588_CLOCK is built-in
+# or module
+obj-y					:= ptp_clock_consumer.o
+endif
 ptp-y					:= ptp_clock.o ptp_chardev.o ptp_sysfs.o ptp_vclock.o
 ptp_kvm-$(CONFIG_X86)			:= ptp_kvm_x86.o ptp_kvm_common.o
 ptp_kvm-$(CONFIG_HAVE_ARM_SMCCC)	:= ptp_kvm_arm.o ptp_kvm_common.o
diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c56cd0f63909..593b5c906314 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -34,7 +34,6 @@ const struct class ptp_class = {
 
 static dev_t ptp_devt;
 
-static DEFINE_XARRAY_ALLOC(ptp_clocks_map);
 
 /* time stamp event queue operations */
 
@@ -512,6 +511,38 @@ void ptp_cancel_worker_sync(struct ptp_clock *ptp)
 }
 EXPORT_SYMBOL(ptp_cancel_worker_sync);
 
+struct ptp_clock *netdev_ptp_clock_register(struct ptp_clock_info *info,
+					    struct net_device *dev)
+{
+	struct ptp_clock *ptp;
+
+	ptp = ptp_clock_register(info, &dev->dev);
+	if (IS_ERR(ptp))
+		return ptp;
+
+	ptp->phc_source = HWTSTAMP_SOURCE_NETDEV;
+	ptp->netdev = dev;
+
+	return ptp;
+}
+EXPORT_SYMBOL(netdev_ptp_clock_register);
+
+struct ptp_clock *phydev_ptp_clock_register(struct ptp_clock_info *info,
+					    struct phy_device *phydev)
+{
+	struct ptp_clock *ptp;
+
+	ptp = ptp_clock_register(info, &phydev->mdio.dev);
+	if (IS_ERR(ptp))
+		return ptp;
+
+	ptp->phc_source = HWTSTAMP_SOURCE_PHYLIB;
+	ptp->phydev = phydev;
+
+	return ptp;
+}
+EXPORT_SYMBOL(phydev_ptp_clock_register);
+
 /* module operations */
 
 static void __exit ptp_exit(void)
diff --git a/drivers/ptp/ptp_clock_consumer.c b/drivers/ptp/ptp_clock_consumer.c
new file mode 100644
index 000000000000..58b0c8948fc8
--- /dev/null
+++ b/drivers/ptp/ptp_clock_consumer.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * PTP 1588 clock support
+ *
+ * Copyright (C) 2010 OMICRON electronics GmbH
+ */
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/posix-clock.h>
+#include <linux/pps_kernel.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+#include <linux/debugfs.h>
+#include <linux/xarray.h>
+#include <uapi/linux/sched/types.h>
+
+#include "ptp_private.h"
+
+DEFINE_XARRAY_ALLOC(ptp_clocks_map);
+EXPORT_SYMBOL(ptp_clocks_map);
+
+bool ptp_clock_from_phylib(struct ptp_clock *ptp)
+{
+	return ptp->phc_source == HWTSTAMP_SOURCE_PHYLIB;
+}
+
+bool ptp_clock_from_netdev(struct ptp_clock *ptp)
+{
+	return ptp->phc_source == HWTSTAMP_SOURCE_NETDEV;
+}
+
+struct net_device *ptp_clock_netdev(struct ptp_clock *ptp)
+{
+	if (ptp->phc_source != HWTSTAMP_SOURCE_NETDEV)
+		return NULL;
+
+	return ptp->netdev;
+}
+
+struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp)
+{
+	if (ptp->phc_source != HWTSTAMP_SOURCE_PHYLIB)
+		return NULL;
+
+	return ptp->phydev;
+}
+EXPORT_SYMBOL(ptp_clock_phydev);
+
+int ptp_clock_get(struct device *dev, struct ptp_clock *ptp)
+{
+	struct device_link *link;
+
+	if (!ptp)
+		return 0;
+
+	if (!try_module_get(ptp->info->owner))
+		return -EPROBE_DEFER;
+
+	get_device(&ptp->dev);
+
+	link = device_link_add(dev, &ptp->dev, DL_FLAG_STATELESS);
+	if (!link)
+		dev_warn(dev, "failed to create device link to %s\n",
+			 dev_name(&ptp->dev));
+
+	return 0;
+}
+
+struct ptp_clock *ptp_clock_get_by_index(struct device *dev, int index)
+{
+	struct ptp_clock *ptp;
+	int ret;
+
+	if (index < 0)
+		return NULL;
+
+	ptp = xa_load(&ptp_clocks_map, (unsigned long)index);
+	if (IS_ERR_OR_NULL(ptp))
+		return ptp;
+
+	ret = ptp_clock_get(dev, ptp);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return ptp;
+}
+
+void ptp_clock_put(struct device *dev, struct ptp_clock *ptp)
+{
+	if (!ptp)
+		return;
+
+	device_link_remove(dev, &ptp->dev);
+	put_device(&ptp->dev);
+	module_put(ptp->info->owner);
+}
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index 18934e28469e..6a306e6e34c2 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -24,6 +24,8 @@
 #define PTP_DEFAULT_MAX_VCLOCKS 20
 #define PTP_MAX_CHANNELS 2048
 
+extern struct xarray ptp_clocks_map;
+
 struct timestamp_event_queue {
 	struct ptp_extts_event buf[PTP_MAX_TIMESTAMPS];
 	int head;
@@ -41,6 +43,11 @@ struct ptp_clock {
 	struct ptp_clock_info *info;
 	dev_t devid;
 	int index; /* index into clocks.map */
+	enum hwtstamp_source phc_source;
+	union { /* Pointer of the phc_source device */
+		struct net_device *netdev;
+		struct phy_device *phydev;
+	};
 	struct pps_device *pps_source;
 	long dialed_frequency; /* remembers the frequency adjustment */
 	struct list_head tsevqs; /* timestamp fifo list */
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index 6e4b8206c7d0..860c1e293a62 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -9,7 +9,9 @@
 #define _PTP_CLOCK_KERNEL_H_
 
 #include <linux/device.h>
+#include <linux/netdevice.h>
 #include <linux/pps_kernel.h>
+#include <linux/phy.h>
 #include <linux/ptp_clock.h>
 #include <linux/timecounter.h>
 #include <linux/skbuff.h>
@@ -340,6 +342,106 @@ extern void ptp_clock_event(struct ptp_clock *ptp,
 
 extern int ptp_clock_index(struct ptp_clock *ptp);
 
+/**
+ * netdev_ptp_clock_register() - Register a PTP hardware clock driver for
+ *				 a net device
+ *
+ * @info: Structure describing the new clock.
+ * @dev:  Pointer of the net device.
+ *
+ * Return: Pointer of the PTP clock, error pointer otherwise.
+ */
+
+struct ptp_clock *
+netdev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct net_device *dev);
+
+/**
+ * phydev_ptp_clock_register() - Register a PTP hardware clock driver for
+ *				 a phy device
+ *
+ * @info:   Structure describing the new clock.
+ * @phydev:  Pointer of the phy device.
+ *
+ * Return: Pointer of the PTP clock, error pointer otherwise.
+ */
+
+struct ptp_clock *
+phydev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct phy_device *phydev);
+
+/**
+ * ptp_clock_from_phylib() - Does the PTP clock comes from phylib
+ *
+ * @ptp:  The clock obtained from net/phy_ptp_clock_register().
+ *
+ * Return: True if the PTP clock comes from phylib, false otherwise.
+ */
+
+bool ptp_clock_from_phylib(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_from_netdev() - Does the PTP clock comes from netdev
+ *
+ * @ptp:  The clock obtained from net/phy_ptp_clock_register().
+ *
+ * Return: True if the PTP clock comes from netdev, false otherwise.
+ */
+
+bool ptp_clock_from_netdev(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_netdev() - Obtain the net_device reference of PTP clock
+ *
+ * @ptp:  The clock obtained from netdev_ptp_clock_register().
+ *
+ * Return: Pointer of the net device, NULL otherwise.
+ */
+
+struct net_device *ptp_clock_netdev(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_phydev() - Obtain the phy_device reference of a PTP clock
+ *
+ * @ptp:  The clock obtained from phydev_ptp_clock_register().
+ *
+ * Return: Pointer of the phy device, NULL otherwise.
+ */
+
+struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_get() - Increment refcount of the PTP clock
+ *
+ * @dev:  The device which get the PTP clock.
+ * @ptp:  Pointer of a PTP clock.
+ *
+ * Return: 0 in case of success, error otherwise.
+ */
+
+int ptp_clock_get(struct device *dev, struct ptp_clock *ptp);
+
+/**
+ * ptp_clock_get_by_index() - Obtain the PTP clock reference from a given
+ *			      PHC index
+ *
+ * @dev:  The device which get the PTP clock.
+ * @index:  The device index of a PTP clock.
+ *
+ * Return: Pointer of the PTP clock, error pointer otherwise.
+ */
+
+struct ptp_clock *ptp_clock_get_by_index(struct device *dev, int index);
+
+/**
+ * ptp_clock_put() - decrement refcount of the PTP clock
+ *
+ * @dev:  The device which get the PTP clock.
+ * @ptp:  Pointer of a PTP clock.
+ */
+
+void ptp_clock_put(struct device *dev, struct ptp_clock *ptp);
+
 /**
  * ptp_find_pin() - obtain the pin index of a given auxiliary function
  *
@@ -405,6 +507,29 @@ static inline void ptp_clock_event(struct ptp_clock *ptp,
 { }
 static inline int ptp_clock_index(struct ptp_clock *ptp)
 { return -1; }
+static inline struct ptp_clock *
+netdev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct net_device *dev)
+{ return NULL; }
+static inline struct ptp_clock *
+phydev_ptp_clock_register(struct ptp_clock_info *info,
+			  struct phy_device *phydev)
+{ return NULL; }
+static inline bool ptp_clock_from_phylib(struct ptp_clock *ptp)
+{ return false; }
+static inline bool ptp_clock_from_netdev(struct ptp_clock *ptp)
+{ return false; }
+static inline struct net_device *ptp_clock_netdev(struct ptp_clock *ptp)
+{ return NULL; }
+static inline struct phy_device *ptp_clock_phydev(struct ptp_clock *ptp)
+{ return NULL; }
+static inline int ptp_clock_get(struct device *dev, struct ptp_clock *ptp)
+{ return -ENODEV; }
+static inline void ptp_clock_put(struct device *dev, struct ptp_clock *ptp)
+{ }
+static inline struct ptp_clock *ptp_clock_get_by_index(struct device *dev,
+						       int index)
+{ return NULL; }
 static inline int ptp_find_pin(struct ptp_clock *ptp,
 			       enum ptp_pin_function func, unsigned int chan)
 { return -1; }

-- 
2.34.1


