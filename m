Return-Path: <netdev+bounces-26756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F270A778C7E
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900BC2811A9
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C5D748D;
	Fri, 11 Aug 2023 10:55:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8BE7479
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:55:09 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00616E5C
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 03:55:08 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RMgdX1htDzrS4M;
	Fri, 11 Aug 2023 18:53:52 +0800 (CST)
Received: from huawei.com (10.175.113.25) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 18:55:05 +0800
From: Zheng Zengkai <zhengzengkai@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <mark.einon@gmail.com>, <siva.kallam@broadcom.com>,
	<prashant@broadcom.com>, <mchan@broadcom.com>,
	<steve.glendinning@shawell.net>, <mw@semihalf.com>,
	<jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>
CC: <netdev@vger.kernel.org>, <wangxiongfeng2@huawei.com>,
	<zhengzengkai@huawei.com>
Subject: [PATCH net-next 3/5] net: smsc: Use pci_dev_id() to simplify the code
Date: Fri, 11 Aug 2023 19:07:00 +0800
Message-ID: <20230811110702.31019-4-zhengzengkai@huawei.com>
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
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

PCI core API pci_dev_id() can be used to get the BDF number for a pci
device. We don't need to compose it manually. Use pci_dev_id() to
simplify the code a little bit.

Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
---
 drivers/net/ethernet/smsc/smsc9420.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc9420.c b/drivers/net/ethernet/smsc/smsc9420.c
index 71fbb358bb7d..350becc0c6ec 100644
--- a/drivers/net/ethernet/smsc/smsc9420.c
+++ b/drivers/net/ethernet/smsc/smsc9420.c
@@ -1144,8 +1144,7 @@ static int smsc9420_mii_init(struct net_device *dev)
 		goto err_out_1;
 	}
 	pd->mii_bus->name = DRV_MDIONAME;
-	snprintf(pd->mii_bus->id, MII_BUS_ID_SIZE, "%x",
-		(pd->pdev->bus->number << 8) | pd->pdev->devfn);
+	snprintf(pd->mii_bus->id, MII_BUS_ID_SIZE, "%x", pci_dev_id(pd->pdev));
 	pd->mii_bus->priv = pd;
 	pd->mii_bus->read = smsc9420_mii_read;
 	pd->mii_bus->write = smsc9420_mii_write;
-- 
2.20.1


