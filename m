Return-Path: <netdev+bounces-26757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1231778C7F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7A7281194
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C2F79CA;
	Fri, 11 Aug 2023 10:55:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE157479
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:55:10 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4444C3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 03:55:09 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RMgdY6Zt0z1GDVk;
	Fri, 11 Aug 2023 18:53:53 +0800 (CST)
Received: from huawei.com (10.175.113.25) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 18:55:06 +0800
From: Zheng Zengkai <zhengzengkai@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <mark.einon@gmail.com>, <siva.kallam@broadcom.com>,
	<prashant@broadcom.com>, <mchan@broadcom.com>,
	<steve.glendinning@shawell.net>, <mw@semihalf.com>,
	<jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>
CC: <netdev@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
	<zhengzengkai@huawei.com>
Subject: [PATCH net-next 4/5] net: tc35815: Use pci_dev_id() to simplify the code
Date: Fri, 11 Aug 2023 19:07:01 +0800
Message-ID: <20230811110702.31019-5-zhengzengkai@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230811110702.31019-1-zhengzengkai@huawei.com>
References: <20230811110702.31019-1-zhengzengkai@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it manually. Use pci_dev_id() to
simplify the code a little bit.

Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 drivers/net/ethernet/toshiba/tc35815.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/tc35815.c b/drivers/net/ethernet/toshiba/tc35815.c
index b50be67b398b..14cf6ecf6d0d 100644
--- a/drivers/net/ethernet/toshiba/tc35815.c
+++ b/drivers/net/ethernet/toshiba/tc35815.c
@@ -667,8 +667,7 @@ static int tc_mii_init(struct net_device *dev)
 	lp->mii_bus->name = "tc35815_mii_bus";
 	lp->mii_bus->read = tc_mdio_read;
 	lp->mii_bus->write = tc_mdio_write;
-	snprintf(lp->mii_bus->id, MII_BUS_ID_SIZE, "%x",
-		 (lp->pci_dev->bus->number << 8) | lp->pci_dev->devfn);
+	snprintf(lp->mii_bus->id, MII_BUS_ID_SIZE, "%x", pci_dev_id(lp->pci_dev));
 	lp->mii_bus->priv = dev;
 	lp->mii_bus->parent = &lp->pci_dev->dev;
 	err = mdiobus_register(lp->mii_bus);
-- 
2.20.1


