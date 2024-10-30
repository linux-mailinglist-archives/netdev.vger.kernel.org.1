Return-Path: <netdev+bounces-140391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C5F9B64E9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BB9E1F23340
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0CF1F4FD3;
	Wed, 30 Oct 2024 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e9+89s+c"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E811EF948;
	Wed, 30 Oct 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730296518; cv=none; b=M8XBy3zLxMohmt4owHag2VUTuP8Ds5+rupEGReu1IYMM1UOMbMBCjiBm4IjybNlsGgb1+6jfZJRXAVNOZWsFxONHuKub2IPHuupce1ZsIghZbtfMlyYNXNM2s7fFivw8wQw2Lidc4XWfIJ/Uc4v9NvTzkIIBNEkDsuG8kwu6NYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730296518; c=relaxed/simple;
	bh=+gUUvlaA57OsDeRZq9krqWQP2oYDSQKZWKViDsTiE6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSytaVdqd+EVN3HrtaDNNhfx91oViXIWQ9t71J/CZuOaIvPiTiU+bR++hfZhkcCHfxaMRVYs5/2A6ARpwv6IiQ66HQpsXeDQO/hqJEQBXYJ+NIr5WC6l+HZgKGLNG2mIFuY2ruVuQraJT3GurpeLDIEto5DLiygIASBiaznJZvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e9+89s+c; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 88D631C0004;
	Wed, 30 Oct 2024 13:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730296507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=USR+Fzw0NXq+MVkAGU4k4vAzfDhl2SPQnxVoSwYhqsY=;
	b=e9+89s+c332faF6zSkYvJokQR5ZxrSWQ4C5j5aJCEWNzuFpOgNj5PrllvTYaY8AtZ9kMak
	sTHoR0t+sxCraCRpF7foJ0ZQoyHHstbZaw9YEjd1SMqfGmncsdvvJIwvMc8MUunWwg3MG5
	ZaCLzNatESi+caZlwedl4VFg/LD2cL+EIGoLszlspQRvignmo6oceNvyALWNnhZbqcbLFK
	yuGl3ikK8ZTCBZswwZp5tiezTmzpN1lyISfZ+YSrUz9BgWnQQCbVvm/KADdYq+VY6fmOX0
	J+A139x4Y8TRh3zUfPP3O7EgTy5ck+10LgxAaC7+Q5jUaU+65O0Snz/8GNrc1w==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 30 Oct 2024 14:54:45 +0100
Subject: [PATCH net-next v19 03/10] ptp: Add phc source and helpers to
 register specific PTP clock or get information
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-feature_ptp_netnext-v19-3-94f8aadc9d5c@bootlin.com>
References: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
In-Reply-To: <20241030-feature_ptp_netnext-v19-0-94f8aadc9d5c@bootlin.com>
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
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
 donald.hunter@gmail.com, danieller@nvidia.com, ecree.xilinx@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Shannon Nelson <shannon.nelson@amd.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.1
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

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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
index 01b5cd91eb61..ab4990f56e5e 100644
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
index c892d22ce0a7..87d8f42b2cc1 100644
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
@@ -342,6 +344,106 @@ extern void ptp_clock_event(struct ptp_clock *ptp,
 
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
@@ -407,6 +509,29 @@ static inline void ptp_clock_event(struct ptp_clock *ptp,
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


