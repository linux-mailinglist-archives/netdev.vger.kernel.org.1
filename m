Return-Path: <netdev+bounces-32383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A2D797347
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A22C281593
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD04211731;
	Thu,  7 Sep 2023 15:21:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294133E5
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:21:59 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49868170E
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 08:21:29 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RhLVz4FyHzhZJR;
	Thu,  7 Sep 2023 22:00:59 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 7 Sep
 2023 22:04:59 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>, Lars
 Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	<UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net] net: microchip: vcap api: Fix possible memory leak for vcap_dup_rule()
Date: Thu, 7 Sep 2023 22:03:58 +0800
Message-ID: <20230907140359.2399646-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Inject fault When select CONFIG_VCAP_KUNIT_TEST, the below memory leak
occurs. If kzalloc() for duprule succeeds, but the following
kmemdup() fails, the duprule, ckf and caf memory will be leaked. So kfree
them in the error path.

unreferenced object 0xffff122744c50600 (size 192):
  comm "kunit_try_catch", pid 346, jiffies 4294896122 (age 911.812s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 1e 00 00 00 2c 01 00 00  .'..........,...
    00 00 00 00 00 00 00 00 18 06 c5 44 27 12 ff ff  ...........D'...
  backtrace:
    [<00000000394b0db8>] __kmem_cache_alloc_node+0x274/0x2f8
    [<0000000001bedc67>] kmalloc_trace+0x38/0x88
    [<00000000b0612f98>] vcap_dup_rule+0x50/0x460
    [<000000005d2d3aca>] vcap_add_rule+0x8cc/0x1038
    [<00000000eef9d0f8>] test_vcap_xn_rule_creator.constprop.0.isra.0+0x238/0x494
    [<00000000cbda607b>] vcap_api_rule_remove_in_front_test+0x1ac/0x698
    [<00000000c8766299>] kunit_try_run_case+0xe0/0x20c
    [<00000000c4fe9186>] kunit_generic_run_threadfn_adapter+0x50/0x94
    [<00000000f6864acf>] kthread+0x2e8/0x374
    [<0000000022e639b3>] ret_from_fork+0x10/0x20

Fixes: 814e7693207f ("net: microchip: vcap api: Add a storage state to a VCAP rule")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/microchip/vcap/vcap_api.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index 300fe1a93dce..ef980e4e5bc2 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -1021,18 +1021,32 @@ static struct vcap_rule_internal *vcap_dup_rule(struct vcap_rule_internal *ri,
 	list_for_each_entry(ckf, &ri->data.keyfields, ctrl.list) {
 		newckf = kmemdup(ckf, sizeof(*newckf), GFP_KERNEL);
 		if (!newckf)
-			return ERR_PTR(-ENOMEM);
+			goto err;
 		list_add_tail(&newckf->ctrl.list, &duprule->data.keyfields);
 	}
 
 	list_for_each_entry(caf, &ri->data.actionfields, ctrl.list) {
 		newcaf = kmemdup(caf, sizeof(*newcaf), GFP_KERNEL);
 		if (!newcaf)
-			return ERR_PTR(-ENOMEM);
+			goto err;
 		list_add_tail(&newcaf->ctrl.list, &duprule->data.actionfields);
 	}
 
 	return duprule;
+
+err:
+	list_for_each_entry_safe(ckf, newckf, &duprule->data.keyfields, ctrl.list) {
+		list_del(&ckf->ctrl.list);
+		kfree(ckf);
+	}
+
+	list_for_each_entry_safe(caf, newcaf, &duprule->data.actionfields, ctrl.list) {
+		list_del(&caf->ctrl.list);
+		kfree(caf);
+	}
+
+	kfree(duprule);
+	return ERR_PTR(-ENOMEM);
 }
 
 static void vcap_apply_width(u8 *dst, int width, int bytes)
-- 
2.34.1


