Return-Path: <netdev+bounces-41903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 403B77CC1DA
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 13:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC9C280E1A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DD341E33;
	Tue, 17 Oct 2023 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007741AAC
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 11:34:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F3A8EA;
	Tue, 17 Oct 2023 04:34:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,231,1694703600"; 
   d="scan'208";a="179586178"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Oct 2023 20:34:04 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3DE3C4003EA8;
	Tue, 17 Oct 2023 20:34:04 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH net-next v3 2/2] rswitch: Add PM ops
Date: Tue, 17 Oct 2023 20:34:02 +0900
Message-Id: <20231017113402.849735-3-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231017113402.849735-1-yoshihiro.shimoda.uh@renesas.com>
References: <20231017113402.849735-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add PM ops for Suspend to Idle. When the system suspended,
the Ethernet Serdes's clock will be stopped. So, this driver needs
to re-initialize the Ethernet Serdes by phy_init() in
renesas_eth_sw_resume(). Otherwise, timeout happened in phy_power_on().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 43 ++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index e5a41e7880d8..43a7795d6591 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -17,6 +17,7 @@
 #include <linux/of_net.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/rtnetlink.h>
 #include <linux/slab.h>
@@ -1315,6 +1316,7 @@ static int rswitch_phy_device_init(struct rswitch_device *rdev)
 	if (!phydev)
 		goto out;
 	__set_bit(rdev->etha->phy_interface, phydev->host_interfaces);
+	phydev->mac_managed_pm = true;
 
 	phydev = of_phy_connect(rdev->ndev, phy, rswitch_adjust_link, 0,
 				rdev->etha->phy_interface);
@@ -1995,11 +1997,52 @@ static void renesas_eth_sw_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+static int renesas_eth_sw_suspend(struct device *dev)
+{
+	struct rswitch_private *priv = dev_get_drvdata(dev);
+	struct net_device *ndev;
+	unsigned int i;
+
+	rswitch_for_each_enabled_port(priv, i) {
+		ndev = priv->rdev[i]->ndev;
+		if (netif_running(ndev)) {
+			netif_device_detach(ndev);
+			rswitch_stop(ndev);
+		}
+		if (priv->rdev[i]->serdes->init_count)
+			phy_exit(priv->rdev[i]->serdes);
+	}
+
+	return 0;
+}
+
+static int renesas_eth_sw_resume(struct device *dev)
+{
+	struct rswitch_private *priv = dev_get_drvdata(dev);
+	struct net_device *ndev;
+	unsigned int i;
+
+	rswitch_for_each_enabled_port(priv, i) {
+		phy_init(priv->rdev[i]->serdes);
+		ndev = priv->rdev[i]->ndev;
+		if (netif_running(ndev)) {
+			rswitch_open(ndev);
+			netif_device_attach(ndev);
+		}
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(renesas_eth_sw_pm_ops, renesas_eth_sw_suspend,
+				renesas_eth_sw_resume);
+
 static struct platform_driver renesas_eth_sw_driver_platform = {
 	.probe = renesas_eth_sw_probe,
 	.remove_new = renesas_eth_sw_remove,
 	.driver = {
 		.name = "renesas_eth_sw",
+		.pm = pm_sleep_ptr(&renesas_eth_sw_pm_ops),
 		.of_match_table = renesas_eth_sw_of_table,
 	}
 };
-- 
2.25.1


