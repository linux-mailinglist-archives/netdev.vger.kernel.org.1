Return-Path: <netdev+bounces-39806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B19C7C486E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 05:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4B11C20CAA
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 03:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9D66AA0;
	Wed, 11 Oct 2023 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A236663B5
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 03:24:59 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D192
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:24:56 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S4yhn3LBKzkY9G;
	Wed, 11 Oct 2023 11:20:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 11:24:54 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <netdev@vger.kernel.org>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3] net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register()
Date: Wed, 11 Oct 2023 11:24:19 +0800
Message-ID: <20231011032419.2423290-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In bcm_sf2_mdio_register(), the class_find_device() will call get_device()
to increment reference count for priv->master_mii_bus->dev if
of_mdio_find_bus() succeeds. If mdiobus_alloc() or mdiobus_register()
fails, it will call get_device() twice without decrement reference count
for the device. And it is the same if bcm_sf2_mdio_register() succeeds but
fails in bcm_sf2_sw_probe(), or if bcm_sf2_sw_probe() succeeds. If the
reference count has not decremented to zero, the dev related resource will
not be freed.

So remove the get_device() in bcm_sf2_mdio_register(), and call
put_device() if mdiobus_alloc() or mdiobus_register() fails and in
bcm_sf2_mdio_unregister() to solve the issue.

And as Simon suggested, unwind from errors for bcm_sf2_mdio_register() and
just return 0 if it succeeds to make it cleaner.

Fixes: 461cd1b03e32 ("net: dsa: bcm_sf2: Register our slave MDIO bus")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Suggested-by: Simon Horman <horms@kernel.org>
---
v3:
- Unwind from errors for bcm_sf2_mdio_register().
- Update the commit message.
- Add Suggested-by.
v2:
- Update the commit message.
---
 drivers/net/dsa/bcm_sf2.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 72374b066f64..cd1f240c90f3 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -617,17 +617,16 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	dn = of_find_compatible_node(NULL, NULL, "brcm,unimac-mdio");
 	priv->master_mii_bus = of_mdio_find_bus(dn);
 	if (!priv->master_mii_bus) {
-		of_node_put(dn);
-		return -EPROBE_DEFER;
+		err = -EPROBE_DEFER;
+		goto err_of_node_put;
 	}
 
-	get_device(&priv->master_mii_bus->dev);
 	priv->master_mii_dn = dn;
 
 	priv->slave_mii_bus = mdiobus_alloc();
 	if (!priv->slave_mii_bus) {
-		of_node_put(dn);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_put_master_mii_bus_dev;
 	}
 
 	priv->slave_mii_bus->priv = priv;
@@ -684,11 +683,17 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	}
 
 	err = mdiobus_register(priv->slave_mii_bus);
-	if (err && dn) {
-		mdiobus_free(priv->slave_mii_bus);
-		of_node_put(dn);
-	}
+	if (err && dn)
+		goto err_free_slave_mii_bus;
 
+	return 0;
+
+err_free_slave_mii_bus:
+	mdiobus_free(priv->slave_mii_bus);
+err_put_master_mii_bus_dev:
+	put_device(&priv->master_mii_bus->dev);
+err_of_node_put:
+	of_node_put(dn);
 	return err;
 }
 
@@ -696,6 +701,7 @@ static void bcm_sf2_mdio_unregister(struct bcm_sf2_priv *priv)
 {
 	mdiobus_unregister(priv->slave_mii_bus);
 	mdiobus_free(priv->slave_mii_bus);
+	put_device(&priv->master_mii_bus->dev);
 	of_node_put(priv->master_mii_dn);
 }
 
-- 
2.34.1


