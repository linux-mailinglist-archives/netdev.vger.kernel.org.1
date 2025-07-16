Return-Path: <netdev+bounces-207428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A92B072A8
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 12:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E657916A5CE
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C175F2F2C7F;
	Wed, 16 Jul 2025 10:07:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFB72F272B;
	Wed, 16 Jul 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660471; cv=none; b=Weu3+2Jm5B08lwdFXW5XuKQ4JQ2kDXLJZtcmAz5+s/gh/zio6nldBTpxlZDCVwkP+3CnFrDJpQT0PL24RiFBwC8PIRMfxPwStvtr38KSsDQAT6U+QymCMWR6UYRIgsqpWJSX/lf7SXtVlA95eKu5WlpKG5WU5FQLnoFmXKsQwRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660471; c=relaxed/simple;
	bh=nLDtChB/cR47HVGRGZA8t5xKv5ZD1c2sMJhML42iCEE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukPCEF6NaL5wYU7oO+yMOyF9pDrjb7j0RItCByWg2/c1bBmxjaTZeeF3FkdL4q9yiapZPvVB6LVChgDteBHw1uBSNFUeWSeTRnltDdFYaI+6+I91H4jacU2GSOtYG1MS5XhAoe3/NsEfor70uL4aYB/CCgDnhP6gDk0sdMxkvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bhs9w4Tjvz1R7Ys;
	Wed, 16 Jul 2025 18:05:08 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id EA1161A016C;
	Wed, 16 Jul 2025 18:07:45 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Jul 2025 18:07:45 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 2/2] net: hibmcge: Add support for PHY LEDs on YT8521
Date: Wed, 16 Jul 2025 18:00:41 +0800
Message-ID: <20250716100041.2833168-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250716100041.2833168-1-shaojijie@huawei.com>
References: <20250716100041.2833168-1-shaojijie@huawei.com>
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

hibmcge is a PCIE EP device, and its controller is
not on the board. And board uses ACPI not DTS
to create the device tree.

So, this makes it impossible to add a "reg" property(used in of_phy_led())
for hibmcge. Therefore, the PHY_LED framework cannot be used directly.

This patch creates a separate LED device for hibmcge
and directly calls the phy->drv->led_hw**() function to
operate the related LEDs.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/Kconfig        |   8 ++
 .../net/ethernet/hisilicon/hibmcge/Makefile   |   1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_led.c  | 132 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_led.h  |  17 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |   7 +
 5 files changed, 165 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_led.c
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_led.h

diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 65302c41bfb1..143b25f329c7 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -157,4 +157,12 @@ config HIBMCGE
 
 	  If you are unsure, say N.
 
+config HIBMCGE_LEDS
+	def_bool LEDS_TRIGGER_NETDEV
+	depends on HIBMCGE && LEDS_CLASS
+	depends on LEDS_CLASS=y || HIBMCGE=m
+	help
+	  Optional support for controlling the NIC LED's with the netdev
+	  LED trigger.
+
 endif # NET_VENDOR_HISILICON
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/Makefile b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
index 1a9da564b306..a78057208064 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/Makefile
+++ b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_HIBMCGE) += hibmcge.o
 
 hibmcge-objs = hbg_main.o hbg_hw.o hbg_mdio.o hbg_irq.o hbg_txrx.o hbg_ethtool.o \
 		hbg_debugfs.o hbg_err.o hbg_diagnose.o
+hibmcge-$(CONFIG_HIBMCGE_LEDS) += hbg_led.o
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_led.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_led.c
new file mode 100644
index 000000000000..013eae1c54f2
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_led.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2025 Hisilicon Limited.
+
+#include <linux/device.h>
+#include <linux/etherdevice.h>
+#include <linux/phy.h>
+#include "hbg_common.h"
+#include "hbg_led.h"
+
+#define PHY_ID_YT8521		0x0000011a
+
+#define to_hbg_led(lcdev) container_of(lcdev, struct hbg_led_classdev, led)
+#define to_hbg_phy_dev(lcdev) \
+	(((struct hbg_led_classdev *)to_hbg_led(lcdev))->priv->mac.phydev)
+
+static int hbg_led_hw_control_set(struct led_classdev *led_cdev,
+				  unsigned long rules)
+{
+	struct hbg_led_classdev *hbg_led = to_hbg_led(led_cdev);
+	struct phy_device *phydev = to_hbg_phy_dev(led_cdev);
+	int ret;
+
+	mutex_lock(&phydev->lock);
+	ret = phydev->drv->led_hw_control_set(phydev, hbg_led->index, rules);
+	mutex_unlock(&phydev->lock);
+
+	return ret;
+}
+
+static int hbg_led_hw_control_get(struct led_classdev *led_cdev,
+				  unsigned long *rules)
+{
+	struct hbg_led_classdev *hbg_led = to_hbg_led(led_cdev);
+	struct phy_device *phydev = to_hbg_phy_dev(led_cdev);
+	int ret;
+
+	mutex_lock(&phydev->lock);
+	ret = phydev->drv->led_hw_control_get(phydev, hbg_led->index, rules);
+	mutex_unlock(&phydev->lock);
+
+	return ret;
+}
+
+static int hbg_led_hw_is_supported(struct led_classdev *led_cdev,
+				   unsigned long rules)
+{
+	struct hbg_led_classdev *hbg_led = to_hbg_led(led_cdev);
+	struct phy_device *phydev = to_hbg_phy_dev(led_cdev);
+	int ret;
+
+	mutex_lock(&phydev->lock);
+	ret = phydev->drv->led_hw_is_supported(phydev, hbg_led->index, rules);
+	mutex_unlock(&phydev->lock);
+
+	return ret;
+}
+
+static struct device *
+	hbg_led_hw_control_get_device(struct led_classdev *led_cdev)
+{
+	struct hbg_led_classdev *hbg_led = to_hbg_led(led_cdev);
+
+	return &hbg_led->priv->netdev->dev;
+}
+
+static int hbg_setup_ldev(struct hbg_led_classdev *hbg_led)
+{
+	struct led_classdev *ldev = &hbg_led->led;
+	struct hbg_priv *priv = hbg_led->priv;
+	struct device *dev = &priv->pdev->dev;
+
+	ldev->name = devm_kasprintf(dev, GFP_KERNEL, "%s-%s-%d",
+				    dev_driver_string(dev),
+				    pci_name(priv->pdev), hbg_led->index);
+	if (!ldev->name)
+		return -ENOMEM;
+
+	ldev->hw_control_trigger = "netdev";
+	ldev->hw_control_set = hbg_led_hw_control_set;
+	ldev->hw_control_get = hbg_led_hw_control_get;
+	ldev->hw_control_is_supported = hbg_led_hw_is_supported;
+	ldev->hw_control_get_device = hbg_led_hw_control_get_device;
+
+	return devm_led_classdev_register(dev, ldev);
+}
+
+static u32 hbg_get_phy_max_led_count(struct hbg_priv *priv)
+{
+	struct phy_device *phydev = priv->mac.phydev;
+
+	if (!phydev->drv->led_hw_is_supported ||
+	    !phydev->drv->led_hw_control_set ||
+	    !phydev->drv->led_hw_control_get)
+		return 0;
+
+	/* YT8521, support 3 leds */
+	if (phydev->drv->phy_id == PHY_ID_YT8521)
+		return 3;
+
+	return 0;
+}
+
+int hbg_leds_init(struct hbg_priv *priv)
+{
+	u32 led_count = hbg_get_phy_max_led_count(priv);
+	struct phy_device *phydev = priv->mac.phydev;
+	struct hbg_led_classdev *leds;
+	int ret;
+	int i;
+
+	if (!led_count)
+		return 0;
+
+	leds = devm_kcalloc(&priv->pdev->dev, led_count,
+			    sizeof(*leds), GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	for (i = 0; i < led_count; i++) {
+		/* for YT8521, we only have two lights, 0 and 2. */
+		if (phydev->drv->phy_id == PHY_ID_YT8521 && i == 1)
+			continue;
+
+		leds[i].priv = priv;
+		leds[i].index = i;
+		ret = hbg_setup_ldev(&leds[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_led.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_led.h
new file mode 100644
index 000000000000..463285077c91
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_led.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2025 Hisilicon Limited. */
+
+#ifndef __HBG_LED_H
+#define __HBG_LED_H
+
+#include "hbg_common.h"
+
+struct hbg_led_classdev {
+	struct hbg_priv *priv;
+	struct led_classdev led;
+	u32 index;
+};
+
+int hbg_leds_init(struct hbg_priv *priv);
+
+#endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 2e64dc1ab355..f2f8f651f3d2 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -12,6 +12,7 @@
 #include "hbg_ethtool.h"
 #include "hbg_hw.h"
 #include "hbg_irq.h"
+#include "hbg_led.h"
 #include "hbg_mdio.h"
 #include "hbg_txrx.h"
 #include "hbg_debugfs.h"
@@ -383,6 +384,12 @@ static int hbg_init(struct hbg_priv *priv)
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_HIBMCGE_LEDS)) {
+		ret = hbg_leds_init(priv);
+		if (ret)
+			return ret;
+	}
+
 	ret = hbg_mac_filter_init(priv);
 	if (ret)
 		return ret;
-- 
2.33.0


