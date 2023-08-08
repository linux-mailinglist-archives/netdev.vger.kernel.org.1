Return-Path: <netdev+bounces-25243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC217736D1
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 04:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DA51C20CDA
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 02:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D5644;
	Tue,  8 Aug 2023 02:37:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A285160
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 02:37:27 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B9D10CC
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 19:37:23 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKcjq69hCzVjtM;
	Tue,  8 Aug 2023 10:35:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 10:37:20 +0800
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
To: <jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maciej.fijalkowski@intel.com>, <andrew@lunn.ch>,
	<piotr.raczynski@intel.com>, <wangxiongfeng2@huawei.com>
CC: <netdev@vger.kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH] net: txgbe: Use pci_dev_id() to simplify the code
Date: Tue, 8 Aug 2023 10:49:31 +0800
Message-ID: <20230808024931.147048-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it mannually. Use pci_dev_id() to
simplify the code a little bit.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 8779645a54be..819d1db34643 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -26,7 +26,7 @@ static int txgbe_swnodes_register(struct txgbe *txgbe)
 	struct software_node *swnodes;
 	u32 id;
 
-	id = (pdev->bus->number << 8) | pdev->devfn;
+	id = pci_dev_id(pdev);
 
 	snprintf(nodes->gpio_name, sizeof(nodes->gpio_name), "txgbe_gpio-%x", id);
 	snprintf(nodes->i2c_name, sizeof(nodes->i2c_name), "txgbe_i2c-%x", id);
@@ -140,7 +140,7 @@ static int txgbe_mdio_pcs_init(struct txgbe *txgbe)
 	mii_bus->phy_mask = ~0;
 	mii_bus->priv = wx;
 	snprintf(mii_bus->id, MII_BUS_ID_SIZE, "txgbe_pcs-%x",
-		 (pdev->bus->number << 8) | pdev->devfn);
+		 pci_dev_id(pdev));
 
 	ret = devm_mdiobus_register(&pdev->dev, mii_bus);
 	if (ret)
@@ -459,7 +459,7 @@ static int txgbe_gpio_init(struct txgbe *txgbe)
 		return -ENOMEM;
 
 	gc->label = devm_kasprintf(dev, GFP_KERNEL, "txgbe_gpio-%x",
-				   (wx->pdev->bus->number << 8) | wx->pdev->devfn);
+				   pci_dev_id(wx->pdev));
 	if (!gc->label)
 		return -ENOMEM;
 
@@ -503,7 +503,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	struct clk *clk;
 
 	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
-		 (pdev->bus->number << 8) | pdev->devfn);
+		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
 	if (IS_ERR(clk))
@@ -566,7 +566,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
 	info.name = "i2c_designware";
-	info.id = (pdev->bus->number << 8) | pdev->devfn;
+	info.id = pci_dev_id(pdev);
 
 	info.res = &DEFINE_RES_IRQ(pdev->irq);
 	info.num_res = 1;
@@ -588,7 +588,7 @@ static int txgbe_sfp_register(struct txgbe *txgbe)
 	info.parent = &pdev->dev;
 	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_SFP]);
 	info.name = "sfp";
-	info.id = (pdev->bus->number << 8) | pdev->devfn;
+	info.id = pci_dev_id(pdev);
 	sfp_dev = platform_device_register_full(&info);
 	if (IS_ERR(sfp_dev))
 		return PTR_ERR(sfp_dev);
-- 
2.20.1


