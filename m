Return-Path: <netdev+bounces-17381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5E751672
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5431C2119F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC4EBC;
	Thu, 13 Jul 2023 02:47:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36CA52
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:47:17 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24F391FC8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:47:11 -0700 (PDT)
Received: from loongson.cn (unknown [112.20.109.108])
	by gateway (Coremail) with SMTP id _____8AxDOuuZa9ksj8EAA--.6621S3;
	Thu, 13 Jul 2023 10:47:10 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.108])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx_c6sZa9kuJcrAA--.57200S3;
	Thu, 13 Jul 2023 10:47:10 +0800 (CST)
From: Feiyang Chen <chenfeiyang@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	chenhuacai@loongson.cn
Cc: Feiyang Chen <chenfeiyang@loongson.cn>,
	linux@armlinux.org.uk,
	dongbiao@loongson.cn,
	loongson-kernel@lists.loongnix.cn,
	netdev@vger.kernel.org,
	loongarch@lists.linux.dev,
	chris.chenfeiyang@gmail.com
Subject: [RFC PATCH 01/10] net: phy: Add driver for Loongson PHY
Date: Thu, 13 Jul 2023 10:46:53 +0800
Message-Id: <be1874e517f4f4cc50906f18689a0add3594c2e0.1689215889.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1689215889.git.chenfeiyang@loongson.cn>
References: <cover.1689215889.git.chenfeiyang@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx_c6sZa9kuJcrAA--.57200S3
X-CM-SenderInfo: hfkh0wphl1t03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jw4DAF1rtryUWF4DAw1UArc_yoWxXrW7pw
	4kAa47ArWDJa12ya15JrWDCr1Yvw4fu34xJrWakwn0ka4kCFy5ZrnFkFWDJrZ5ZrWkXFWF
	gr9YkasFkFZ8WwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support for the Loongson PHY.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 drivers/net/phy/Kconfig        |  5 +++
 drivers/net/phy/Makefile       |  1 +
 drivers/net/phy/loongson-phy.c | 69 ++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c   | 16 ++++++++
 include/linux/phy.h            |  2 +
 5 files changed, 93 insertions(+)
 create mode 100644 drivers/net/phy/loongson-phy.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 93b8efc79227..4f8ea32cbc68 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -202,6 +202,11 @@ config INTEL_XWAY_PHY
 	  PEF 7061, PEF 7071 and PEF 7072 or integrated into the Intel
 	  SoCs xRX200, xRX300, xRX330, xRX350 and xRX550.
 
+config LOONGSON_PHY
+	tristate "Loongson PHY driver"
+	help
+	  Supports the Loongson PHY.
+
 config LSI_ET1011C_PHY
 	tristate "LSI ET1011C PHY"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index f289ab16a1da..f775373e12b7 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_DP83TD510_PHY)	+= dp83td510.o
 obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
 obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
+obj-$(CONFIG_LOONGSON_PHY)	+= loongson-phy.o
 obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
 obj-$(CONFIG_LXT_PHY)		+= lxt.o
 obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
diff --git a/drivers/net/phy/loongson-phy.c b/drivers/net/phy/loongson-phy.c
new file mode 100644
index 000000000000..d4aefa2110f8
--- /dev/null
+++ b/drivers/net/phy/loongson-phy.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LS7A PHY driver
+ *
+ * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
+ *
+ * Author: Zhang Baoqi <zhangbaoqi@loongson.cn>
+ */
+
+#include <linux/mii.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/phy.h>
+
+#define PHY_ID_LS7A2000		0x00061ce0
+#define GNET_REV_LS7A2000	0x00
+
+static int ls7a2000_config_aneg(struct phy_device *phydev)
+{
+	if (phydev->speed == SPEED_1000)
+		phydev->autoneg = AUTONEG_ENABLE;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+	    phydev->advertising) ||
+	    linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+	    phydev->advertising) ||
+	    linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+	    phydev->advertising))
+	    return genphy_config_aneg(phydev);
+
+	netdev_info(phydev->attached_dev, "Parameter Setting Error\n");
+	return -1;
+}
+
+int ls7a2000_match_phy_device(struct phy_device *phydev)
+{
+	struct net_device *ndev;
+	struct pci_dev *pdev;
+
+	if ((phydev->phy_id & 0xfffffff0) != PHY_ID_LS7A2000)
+		return 0;
+
+	ndev = phydev->mdio.bus->priv;
+	pdev = to_pci_dev(ndev->dev.parent);
+
+	return pdev->revision == GNET_REV_LS7A2000;
+}
+
+static struct phy_driver loongson_phy_driver[] = {
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_LS7A2000),
+		.name			= "LS7A2000 PHY",
+		.features		= PHY_LOONGSON_FEATURES,
+		.config_aneg		= ls7a2000_config_aneg,
+		.match_phy_device	= ls7a2000_match_phy_device,
+	},
+};
+module_phy_driver(loongson_phy_driver);
+
+static struct mdio_device_id __maybe_unused loongson_tbl[] = {
+	{ PHY_ID_MATCH_MODEL(PHY_ID_LS7A2000) },
+	{ },
+};
+MODULE_DEVICE_TABLE(mdio, loongson_tbl);
+
+MODULE_DESCRIPTION("Loongson PHY driver");
+MODULE_AUTHOR("Zhang Baoqi <zhangbaoqi@loongson.cn>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 53598210be6c..00568608118a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -146,6 +146,15 @@ static const int phy_eee_cap1_features_array[] = {
 __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
 EXPORT_SYMBOL_GPL(phy_eee_cap1_features);
 
+static const int phy_10_100_1000_full_features_array[] = {
+	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+};
+
+__ETHTOOL_DECLARE_LINK_MODE_MASK(phy_loongson_features) __ro_after_init;
+EXPORT_SYMBOL_GPL(phy_loongson_features);
+
 static void features_init(void)
 {
 	/* 10/100 half/full*/
@@ -230,6 +239,13 @@ static void features_init(void)
 	linkmode_set_bit_array(phy_eee_cap1_features_array,
 			       ARRAY_SIZE(phy_eee_cap1_features_array),
 			       phy_eee_cap1_features);
+	/* 10/100/1000 full */
+	linkmode_set_bit_array(phy_basic_ports_array,
+			       ARRAY_SIZE(phy_basic_ports_array),
+			       phy_loongson_features);
+	linkmode_set_bit_array(phy_10_100_1000_full_features_array,
+			       ARRAY_SIZE(phy_10_100_1000_full_features_array),
+			       phy_loongson_features);
 
 }
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 6478838405a0..6bdb2a479755 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -54,6 +54,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_fec_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_full_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
+extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_loongson_features) __ro_after_init;
 
 #define PHY_BASIC_FEATURES ((unsigned long *)&phy_basic_features)
 #define PHY_BASIC_T1_FEATURES ((unsigned long *)&phy_basic_t1_features)
@@ -65,6 +66,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
 #define PHY_10GBIT_FEC_FEATURES ((unsigned long *)&phy_10gbit_fec_features)
 #define PHY_10GBIT_FULL_FEATURES ((unsigned long *)&phy_10gbit_full_features)
 #define PHY_EEE_CAP1_FEATURES ((unsigned long *)&phy_eee_cap1_features)
+#define PHY_LOONGSON_FEATURES ((unsigned long *)&phy_loongson_features)
 
 extern const int phy_basic_ports_array[3];
 extern const int phy_fibre_port_array[1];
-- 
2.39.3


