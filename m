Return-Path: <netdev+bounces-26363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB557779CF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2AF1C21548
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AE11FB2B;
	Thu, 10 Aug 2023 13:45:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E841FB26
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:45:38 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB31B2133
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:45:37 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM7Q65l1yzCrS2;
	Thu, 10 Aug 2023 21:42:06 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 21:45:35 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>, <liuhangbin@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next,v2 5/5] bonding: remove unnecessary NULL check in bond_destructor
Date: Thu, 10 Aug 2023 21:50:07 +0800
Message-ID: <20230810135007.3834770-6-shaozhengchao@huawei.com>
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

The free_percpu function also could check whether "rr_tx_counter"
parameter is NULL. Therefore, remove NULL check in bond_destructor.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/bonding/bond_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index de3ae9c57da0..f398bec78457 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5863,8 +5863,7 @@ static void bond_destructor(struct net_device *bond_dev)
 	if (bond->wq)
 		destroy_workqueue(bond->wq);
 
-	if (bond->rr_tx_counter)
-		free_percpu(bond->rr_tx_counter);
+	free_percpu(bond->rr_tx_counter);
 }
 
 void bond_setup(struct net_device *bond_dev)
-- 
2.34.1


