Return-Path: <netdev+bounces-25832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD3C775F45
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E09281CC8
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B0E182D9;
	Wed,  9 Aug 2023 12:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28E182C3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:36:37 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848761FCA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:36:34 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RLTxf4KFWz1hwf3;
	Wed,  9 Aug 2023 20:33:42 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 20:36:32 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next 4/5] bonding: use bond_set_slave_arr to simplify code
Date: Wed, 9 Aug 2023 20:41:06 +0800
Message-ID: <20230809124107.360574-5-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809124107.360574-1-shaozhengchao@huawei.com>
References: <20230809124107.360574-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/bonding/bond_main.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 6636638f5d97..dcc67bd4d5cf 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5044,21 +5044,9 @@ static void bond_set_slave_arr(struct bonding *bond,
 	kfree_rcu(all, rcu);
 }
 
-static void bond_reset_slave_arr(struct bonding *bond)
+static inline void bond_reset_slave_arr(struct bonding *bond)
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


