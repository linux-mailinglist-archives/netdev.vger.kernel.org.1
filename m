Return-Path: <netdev+bounces-52941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D096800D1A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 15:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D24B20B64
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54363D980;
	Fri,  1 Dec 2023 14:25:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911E610F4;
	Fri,  1 Dec 2023 06:25:08 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1r94Rs-0000PA-CQ; Fri, 01 Dec 2023 15:24:56 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@theobroma-systems.com,
	heiko@sntech.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] net: mdio: enable optional clock when registering a phy from devicetree
Date: Fri,  1 Dec 2023 15:24:53 +0100
Message-Id: <20231201142453.324697-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The ethernet-phy binding (now) specifys that phys can declare a clock
supply. Phy driver itself will handle this when probing the phy-driver.

But there is a gap when trying to detect phys, because the mdio-bus needs
to talk to the phy to get its phy-id. Using actual phy-ids in the dt like
       compatible = "ethernet-phy-id0022.1640",
                    "ethernet-phy-ieee802.3-c22";
of course circumvents this, but in turn hard-codes the phy.

With boards often having multiple phy options and the mdio-bus being able
to actually probe devices, this feels like a step back.

So check for the existence of a phy-clock per the -dtbinding in the
of_mdiobus_register_phy() and enable the clock around the
fwnode_mdiobus_register_phy() call which tries to determine the phy-id.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/net/mdio/of_mdio.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 64ebcb6d235c..895b12849b23 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -8,6 +8,7 @@
  * out of the OpenFirmware device tree and using it to populate an mii_bus.
  */
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fwnode_mdio.h>
@@ -15,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
+#include <linux/of_clk.h>
 #include <linux/of_irq.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
@@ -46,7 +48,37 @@ EXPORT_SYMBOL(of_mdiobus_phy_device_register);
 static int of_mdiobus_register_phy(struct mii_bus *mdio,
 				    struct device_node *child, u32 addr)
 {
-	return fwnode_mdiobus_register_phy(mdio, of_fwnode_handle(child), addr);
+	struct clk *clk = NULL;
+	int ret;
+
+	/* ethernet-phy binding specifies a maximum of 1 clock */
+	if (of_clk_get_parent_count(child) == 1) {
+		clk = of_clk_get(child, 0);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) != -ENOENT)
+				return dev_err_probe(&mdio->dev, PTR_ERR(clk),
+						     "Could not get defined clock for MDIO device at address %u\n",
+						     addr);
+
+			clk = NULL;
+		}
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret < 0) {
+		clk_put(clk);
+		dev_err(&mdio->dev,
+			"Could not enable clock for MDIO device at address %u: %d\n",
+			addr, ret);
+		return ret;
+	}
+
+	ret = fwnode_mdiobus_register_phy(mdio, of_fwnode_handle(child), addr);
+
+	clk_disable_unprepare(clk);
+	clk_put(clk);
+
+	return ret;
 }
 
 static int of_mdiobus_register_device(struct mii_bus *mdio,
-- 
2.39.2


