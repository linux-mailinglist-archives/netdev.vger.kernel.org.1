Return-Path: <netdev+bounces-26364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D3F7779D6
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0801C215F7
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D891FB3A;
	Thu, 10 Aug 2023 13:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E871FB35
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:45:38 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DCB2132
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:45:37 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM7Sk0SlszkXJW;
	Thu, 10 Aug 2023 21:44:22 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 21:45:34 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>, <liuhangbin@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next,v2 4/5] bonding: use bond_set_slave_arr to simplify code
Date: Thu, 10 Aug 2023 21:50:06 +0800
Message-ID: <20230810135007.3834770-5-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810135007.3834770-1-shaozhengchao@huawei.com>
References: <20230810135007.3834770-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In bond_reset_slave_arr(), values are assigned and memory is released only
when the variables "usable" and "all" are not NULL. But even if the
"usable" and "all" variables are NULL, they can still work, because value
will be checked in kfree_rcu. Therefore, use bond_set_slave_arr() and set
the input parameters "usable_slaves" and "all_slaves" to NULL to simplify
the code in bond_reset_slave_arr(). And the same to bond_uninit().

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/bonding/bond_main.c | 27 ++-------------------------
 1 file changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 6636638f5d97..de3ae9c57da0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5046,19 +5046,7 @@ static void bond_set_slave_arr(struct bonding *bond,
 
 static void bond_reset_slave_arr(struct bonding *bond)
 {
-	struct bond_up_slave *usable, *all;
-
-	usable = rtnl_dereference(bond->usable_slaves);
-	if (usable) {
-		RCU_INIT_POINTER(bond->usable_slaves, NULL);
-		kfree_rcu(usable, rcu);
-	}
-
-	all = rtnl_dereference(bond->all_slaves);
-	if (all) {
-		RCU_INIT_POINTER(bond->all_slaves, NULL);
-		kfree_rcu(all, rcu);
-	}
+	bond_set_slave_arr(bond, NULL, NULL);
 }
 
 /* Build the usable slaves array in control path for modes that use xmit-hash
@@ -5951,7 +5939,6 @@ void bond_setup(struct net_device *bond_dev)
 static void bond_uninit(struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct bond_up_slave *usable, *all;
 	struct list_head *iter;
 	struct slave *slave;
 
@@ -5962,17 +5949,7 @@ static void bond_uninit(struct net_device *bond_dev)
 		__bond_release_one(bond_dev, slave->dev, true, true);
 	netdev_info(bond_dev, "Released all slaves\n");
 
-	usable = rtnl_dereference(bond->usable_slaves);
-	if (usable) {
-		RCU_INIT_POINTER(bond->usable_slaves, NULL);
-		kfree_rcu(usable, rcu);
-	}
-
-	all = rtnl_dereference(bond->all_slaves);
-	if (all) {
-		RCU_INIT_POINTER(bond->all_slaves, NULL);
-		kfree_rcu(all, rcu);
-	}
+	bond_set_slave_arr(bond, NULL, NULL);
 
 	list_del(&bond->bond_list);
 
-- 
2.34.1


