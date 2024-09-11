Return-Path: <netdev+bounces-127466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F8C975805
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539DE28A392
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823561AE034;
	Wed, 11 Sep 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SusyNQmg"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB81AB6D7;
	Wed, 11 Sep 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071317; cv=none; b=uk5hCTcYWeo5dM/ocjaK3jTIDdvPXdG4U9WGenj21YOWPDOWOaETarD2Q4cFPK+UlYrCXLqKMQgi+foKTOxSjCjbyGMzjQvVs3XYJMI2JGn8KdTe35tXrqBRnaPhWp/T7V9SsY4eYOGX6NPjGMg4FL/Zj72qnyAhAoM4uGP9wIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071317; c=relaxed/simple;
	bh=1bQ6ImyF/jGacshZUQQdTdRKhwSlL3Wx8mjhu+pdUFg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6UdNPlHLZ9bdOl0GRnkrSjhcpaim3I0qqWvlRJ0b0oja3+1ORqZb99LkjNANTrJlvc1uHIRBjpxMU9X1zn3J5YPOxl5n0eKWdow7rS3TRA9W6pTKGH9xNjVIshBlWJhSROo00n8EtV+B2vHhaKeowmKvgYfRul7dszmJqOnKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SusyNQmg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726071315; x=1757607315;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1bQ6ImyF/jGacshZUQQdTdRKhwSlL3Wx8mjhu+pdUFg=;
  b=SusyNQmgkYTWZIQuRHLa5uUVwS71Pb/lD36cXbz0+tYygj2+oIdtGLFR
   SXd8VX/JVkt2/p+dBBnZ3IukIFZVjhevXkaVJnIbx2CAyiUzI1nKOXPPP
   SwiWvnux9bxwQKZQki0KbEKQBkJC3WlX1GYNtpbXjbFd0RbCmeCs8+Vv4
   STBu4TUBpsdrAHG/qXYAxuyyAdQ+w0p1/abY2PBe/oZG8TsmK9eWk1Xc/
   O/GHpMVtVsHstVtNBuQ0iGEMhmMM7N0qNgYu4e4mngr7VH74ZWFSjySwT
   XqoTFgMU2o1gN9qJN+Ok95M7WEGqeqd2ROtdPlfJftFVKqXWmVSbpwsTS
   Q==;
X-CSE-ConnectionGUID: I+zUQG3KSiiiwGtN22Ixjw==
X-CSE-MsgGUID: 8lKrkbRIRvCbJptRylhr1Q==
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="32280150"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 09:15:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 09:15:05 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 09:15:00 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>, <andrew@lunn.ch>,
	<Steen.Hegelund@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 3/5] net: lan743x: Register the platform device for sfp pluggable module
Date: Wed, 11 Sep 2024 21:40:52 +0530
Message-ID: <20240911161054.4494-4-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for sfp pluggable module as platform device handle the gpio
input and output signals and i2c bus access the sfp eeprom data.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
============
V1 -> V2:
  - Add platform_device_unregister( ) when sfp register fail 
V0 -> V1:
  - No change

 drivers/net/ethernet/microchip/Kconfig        |  1 +
 drivers/net/ethernet/microchip/lan743x_main.c | 43 +++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  1 +
 3 files changed, 45 insertions(+)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 9c08a4af257a..3dacf39b49b4 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -52,6 +52,7 @@ config LAN743X
 	select PHYLINK
 	select I2C_PCI1XXXX
 	select GP_PCI1XXXX
+	select SFP
 	help
 	  Support for the Microchip LAN743x and PCI11x1x families of PCI
 	  Express Ethernet devices
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index dc571020ae1b..c1061e2972f9 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -16,6 +16,7 @@
 #include <linux/iopoll.h>
 #include <linux/crc16.h>
 #include <linux/phylink.h>
+#include <linux/platform_device.h>
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
 
@@ -187,6 +188,11 @@ static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
 
 static void lan743x_pci_cleanup(struct lan743x_adapter *adapter)
 {
+	if (adapter->sfp_dev) {
+		platform_device_unregister(adapter->sfp_dev);
+		adapter->sfp_dev = NULL;
+	}
+
 	if (adapter->nodes) {
 		software_node_unregister_node_group(adapter->nodes->group);
 		kfree(adapter->nodes);
@@ -3062,6 +3068,31 @@ static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
 	return software_node_register_node_group(nodes->group);
 }
 
+static int lan743x_sfp_register(struct lan743x_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct platform_device_info sfp_info;
+	struct platform_device *sfp_dev;
+
+	memset(&sfp_info, 0, sizeof(sfp_info));
+	sfp_info.parent = &adapter->pdev->dev;
+	sfp_info.fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_SFP]);
+	sfp_info.name = "sfp";
+	sfp_info.id = (pdev->bus->number << 8) | pdev->devfn;
+	sfp_dev = platform_device_register_full(&sfp_info);
+	if (IS_ERR(sfp_dev)) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "Failed to register SFP device\n");
+		return PTR_ERR(sfp_dev);
+	}
+
+	adapter->sfp_dev = sfp_dev;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "SFP platform device registered");
+
+	return 0;
+}
+
 static int lan743x_phylink_sgmii_config(struct lan743x_adapter *adapter)
 {
 	u32 sgmii_ctl;
@@ -3851,6 +3882,18 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 	if (ret)
 		goto cleanup_pci;
 
+	if (adapter->is_sfp_support_en) {
+		adapter->i2c_adap->dev.fwnode =
+			software_node_fwnode(adapter->nodes->group[SWNODE_I2C]);
+
+		ret = lan743x_sfp_register(adapter);
+		if (ret < 0) {
+			netif_err(adapter, probe, netdev,
+				  "Failed to register sfp (%d)\n", ret);
+			goto cleanup_pci;
+		}
+	}
+
 	ret = lan743x_mdiobus_init(adapter);
 	if (ret)
 		goto cleanup_hardware;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index bf0d0f285e39..c303a69c3bea 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1129,6 +1129,7 @@ struct lan743x_adapter {
 	struct phylink_config	phylink_config;
 	struct lan743x_sw_nodes	*nodes;
 	struct i2c_adapter	*i2c_adap;
+	struct platform_device	*sfp_dev;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.34.1


