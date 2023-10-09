Return-Path: <netdev+bounces-38989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD037BD55E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653AA28156B
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF02417D1;
	Mon,  9 Oct 2023 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076B800
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 08:39:58 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1646BA
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 01:39:55 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S3snB2k7HzNpCP;
	Mon,  9 Oct 2023 16:35:58 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 9 Oct
 2023 16:39:53 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <netdev@vger.kernel.org>, Florian Fainelli
	<florian.fainelli@broadcom.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register()
Date: Mon, 9 Oct 2023 16:39:06 +0800
Message-ID: <20231009083906.1212900-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Fixes: 461cd1b03e32 ("net: dsa: bcm_sf2: Register our slave MDIO bus")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Update the commit message.
---
 drivers/net/dsa/bcm_sf2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 72374b066f64..f2b14bd7c38b 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -621,11 +621,11 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 		return -EPROBE_DEFER;
 	}
 
-	get_device(&priv->master_mii_bus->dev);
 	priv->master_mii_dn = dn;
 
 	priv->slave_mii_bus = mdiobus_alloc();
 	if (!priv->slave_mii_bus) {
+		put_device(&priv->master_mii_bus->dev);
 		of_node_put(dn);
 		return -ENOMEM;
 	}
@@ -686,6 +686,7 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 	err = mdiobus_register(priv->slave_mii_bus);
 	if (err && dn) {
 		mdiobus_free(priv->slave_mii_bus);
+		put_device(&priv->master_mii_bus->dev);
 		of_node_put(dn);
 	}
 
@@ -696,6 +697,7 @@ static void bcm_sf2_mdio_unregister(struct bcm_sf2_priv *priv)
 {
 	mdiobus_unregister(priv->slave_mii_bus);
 	mdiobus_free(priv->slave_mii_bus);
+	put_device(&priv->master_mii_bus->dev);
 	of_node_put(priv->master_mii_dn);
 }
 
-- 
2.34.1


