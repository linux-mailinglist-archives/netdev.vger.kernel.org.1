Return-Path: <netdev+bounces-32699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1CA7996C7
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 10:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD38E1C20C0A
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 08:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224721C20;
	Sat,  9 Sep 2023 08:02:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155B81FD1
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 08:02:28 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FC919BC
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 01:02:26 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RjQN23Sy1zNmtx;
	Sat,  9 Sep 2023 15:58:42 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 9 Sep
 2023 16:02:23 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v2 3/5] net: microchip: sparx5: Fix possible memory leak in vcap_api_encode_rule_test()
Date: Sat, 9 Sep 2023 16:02:05 +0800
Message-ID: <20230909080207.1174597-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230909080207.1174597-1-ruanjinjie@huawei.com>
References: <20230909080207.1174597-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Inject fault while probing kunit-example-test.ko, the duprule which
is allocated in vcap_dup_rule() and the export which is allocated in
vcap_enable() of vcap_enable_lookups in vcap_api_encode_rule_test()
is not freed, and it cause the memory leaks below.

Use vcap_enable_lookups() with false arg to free the export as
other drivers do it. And use vcap_del_rule() to free the duprule.

unreferenced object 0xffff677a0278bb00 (size 64):
  comm "kunit_try_catch", pid 388, jiffies 4294895987 (age 1101.840s)
  hex dump (first 32 bytes):
    18 bd a5 82 00 80 ff ff 18 bd a5 82 00 80 ff ff  ................
    40 fe c8 0e be c6 ff ff 00 00 00 00 00 00 00 00  @...............
  backtrace:
    [<000000007d53023a>] slab_post_alloc_hook+0xb8/0x368
    [<0000000076e3f654>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000034d76721>] kmalloc_trace+0x40/0x164
    [<00000000013380a5>] vcap_enable_lookups+0x1c8/0x70c
    [<00000000bbec496b>] vcap_api_encode_rule_test+0x2f8/0xb18
    [<000000002c2bfb7b>] kunit_try_run_case+0x50/0xac
    [<00000000ff74642b>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<000000004af845ca>] kthread+0x124/0x130
    [<0000000038a000ca>] ret_from_fork+0x10/0x20
unreferenced object 0xffff677a027803c0 (size 192):
  comm "kunit_try_catch", pid 388, jiffies 4294895988 (age 1101.836s)
  hex dump (first 32 bytes):
    00 12 7a 00 05 00 00 00 0a 00 00 00 64 00 00 00  ..z.........d...
    00 00 00 00 00 00 00 00 d8 03 78 02 7a 67 ff ff  ..........x.zg..
  backtrace:
    [<000000007d53023a>] slab_post_alloc_hook+0xb8/0x368
    [<0000000076e3f654>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000034d76721>] kmalloc_trace+0x40/0x164
    [<00000000c1010131>] vcap_dup_rule+0x34/0x14c
    [<00000000d43c54a4>] vcap_add_rule+0x29c/0x32c
    [<0000000073f1c26d>] vcap_api_encode_rule_test+0x304/0xb18
    [<000000002c2bfb7b>] kunit_try_run_case+0x50/0xac
    [<00000000ff74642b>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<000000004af845ca>] kthread+0x124/0x130
    [<0000000038a000ca>] ret_from_fork+0x10/0x20

Fixes: c956b9b318d9 ("net: microchip: sparx5: Adding KUNIT tests of key/action values in VCAP API")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index f268383a7570..8c61a5dbce55 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -1439,6 +1439,10 @@ static void vcap_api_encode_rule_test(struct kunit *test)
 	ret = list_empty(&is2_admin.rules);
 	KUNIT_EXPECT_EQ(test, false, ret);
 	KUNIT_EXPECT_EQ(test, 0, ret);
+
+	vcap_enable_lookups(&test_vctrl, &test_netdev, 0, 0,
+			    rule->cookie, false);
+
 	vcap_free_rule(rule);
 
 	/* Check that the rule has been freed: tricky to access since this
@@ -1449,6 +1453,8 @@ static void vcap_api_encode_rule_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, true, ret);
 	ret = list_empty(&rule->actionfields);
 	KUNIT_EXPECT_EQ(test, true, ret);
+
+	vcap_del_rule(&test_vctrl, &test_netdev, id);
 }
 
 static void vcap_api_set_rule_counter_test(struct kunit *test)
-- 
2.34.1


