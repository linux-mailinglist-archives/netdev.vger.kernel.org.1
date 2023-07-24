Return-Path: <netdev+bounces-20241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDD975E9C5
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 04:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78321C20A45
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 02:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE90A2D;
	Mon, 24 Jul 2023 02:32:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930AAA21
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 02:32:31 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CE1AD
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 19:32:16 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R8PH806QwzNmS4;
	Mon, 24 Jul 2023 10:28:52 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 10:32:13 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <simon.horman@corigine.com>, <kuniyu@amazon.com>, <liuhangbin@gmail.com>,
	<jiri@resnulli.us>, <hkallweit1@gmail.com>, <andy.ren@getcruise.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next] net: remove redundant NULL check in remove_xps_queue()
Date: Mon, 24 Jul 2023 10:37:35 +0800
Message-ID: <20230724023735.2751602-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There are currently two paths that call remove_xps_queue():
1. __netif_set_xps_queue -> remove_xps_queue
2. clean_xps_maps -> remove_xps_queue_cpu -> remove_xps_queue
There is no need to check dev_maps in remove_xps_queue() because
dev_maps has been checked on these two paths.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/core/dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f95e0674570f..76a91b849829 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2384,8 +2384,7 @@ static bool remove_xps_queue(struct xps_dev_maps *dev_maps,
 	struct xps_map *map = NULL;
 	int pos;
 
-	if (dev_maps)
-		map = xmap_dereference(dev_maps->attr_map[tci]);
+	map = xmap_dereference(dev_maps->attr_map[tci]);
 	if (!map)
 		return false;
 
-- 
2.34.1


