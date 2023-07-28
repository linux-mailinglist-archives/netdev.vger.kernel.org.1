Return-Path: <netdev+bounces-22188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65E766668
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438FF283094
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92BA1095F;
	Fri, 28 Jul 2023 08:02:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9F210944
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:02:13 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4E33C0C;
	Fri, 28 Jul 2023 01:01:53 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RC0Pk5Hv0ztRcF;
	Fri, 28 Jul 2023 15:58:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:01:50 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 5/6] net: hns3: fix wrong print link down up
Date: Fri, 28 Jul 2023 15:58:39 +0800
Message-ID: <20230728075840.4022760-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230728075840.4022760-1-shaojijie@huawei.com>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Peiyang Wang <wangpeiyang1@huawei.com>

This patch will fix a wrong print "device link down/up". Consider a case
that set autoneg to off with same speed and duplex configuration. The link
is always up while the phy state is set to PHY_UP and set back to
PHY_RUNNING later. It will print link down when the phy state is not
PHY_RUNNING. To avoid that, the condition should include PHY_UP.

Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a940e35aef29..1723d0fa49ee 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3089,7 +3089,8 @@ static int hclge_get_mac_phy_link(struct hclge_dev *hdev, int *link_status)
 	if (test_bit(HCLGE_STATE_DOWN, &hdev->state))
 		return 0;
 
-	if (phydev && (phydev->state != PHY_RUNNING || !phydev->link))
+	if (phydev && ((phydev->state != PHY_UP &&
+			phydev->state != PHY_RUNNING) || !phydev->link))
 		return 0;
 
 	return hclge_get_mac_link_status(hdev, link_status);
-- 
2.30.0


