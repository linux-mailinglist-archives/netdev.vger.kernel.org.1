Return-Path: <netdev+bounces-33190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 577E379CF36
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9DE28155D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D822C1642B;
	Tue, 12 Sep 2023 11:05:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52EFA936
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:05:27 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436A610EF
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:05:25 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RlLKX1PBWz1N818;
	Tue, 12 Sep 2023 19:03:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 19:05:07 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v3 5/5] net: microchip: sparx5: Fix possible memory leaks in vcap_api_kunit
Date: Tue, 12 Sep 2023 19:03:10 +0800
Message-ID: <20230912110310.1540474-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912110310.1540474-1-ruanjinjie@huawei.com>
References: <20230912110310.1540474-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected

Inject fault while probing kunit-example-test.ko, the duprule which
is allocated by kzalloc in vcap_dup_rule() of
test_vcap_xn_rule_creator() is not freed, and it cause the memory leaks
below. Use vcap_del_rule() to free them as other functions do it.

unreferenced object 0xffff6eb4846f6180 (size 192):
  comm "kunit_try_catch", pid 405, jiffies 4294895522 (age 880.004s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 0a 00 00 00 f4 01 00 00  .'..............
    00 00 00 00 00 00 00 00 98 61 6f 84 b4 6e ff ff  .........ao..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000d2ac4ccb>] vcap_api_rule_insert_in_order_test+0xa4/0x114
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4846f6240 (size 192):
  comm "kunit_try_catch", pid 405, jiffies 4294895524 (age 879.996s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 14 00 00 00 90 01 00 00  .'..............
    00 00 00 00 00 00 00 00 58 62 6f 84 b4 6e ff ff  ........Xbo..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<0000000052e6ad35>] vcap_api_rule_insert_in_order_test+0xbc/0x114
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4846f6300 (size 192):
  comm "kunit_try_catch", pid 405, jiffies 4294895524 (age 879.996s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 1e 00 00 00 2c 01 00 00  .'..........,...
    00 00 00 00 00 00 00 00 18 63 6f 84 b4 6e ff ff  .........co..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<000000001b0895d4>] vcap_api_rule_insert_in_order_test+0xd4/0x114
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4846f63c0 (size 192):
  comm "kunit_try_catch", pid 405, jiffies 4294895524 (age 880.012s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 28 00 00 00 c8 00 00 00  .'......(.......
    00 00 00 00 00 00 00 00 d8 63 6f 84 b4 6e ff ff  .........co..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000134c151f>] vcap_api_rule_insert_in_order_test+0xec/0x114
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4845fc180 (size 192):
  comm "kunit_try_catch", pid 407, jiffies 4294895527 (age 880.000s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 14 00 00 00 c8 00 00 00  .'..............
    00 00 00 00 00 00 00 00 98 c1 5f 84 b4 6e ff ff  .........._..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000fa5f64d3>] vcap_api_rule_insert_reverse_order_test+0xc8/0x600
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4845fc240 (size 192):
  comm "kunit_try_catch", pid 407, jiffies 4294895527 (age 880.000s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 1e 00 00 00 2c 01 00 00  .'..........,...
    00 00 00 00 00 00 00 00 58 c2 5f 84 b4 6e ff ff  ........X._..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000453dcd80>] vcap_add_rule+0x134/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000a7db42de>] vcap_api_rule_insert_reverse_order_test+0x108/0x600
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4845fc300 (size 192):
  comm "kunit_try_catch", pid 407, jiffies 4294895527 (age 880.000s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 28 00 00 00 90 01 00 00  .'......(.......
    00 00 00 00 00 00 00 00 18 c3 5f 84 b4 6e ff ff  .........._..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000453dcd80>] vcap_add_rule+0x134/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000ea416c94>] vcap_api_rule_insert_reverse_order_test+0x150/0x600
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb4845fc3c0 (size 192):
  comm "kunit_try_catch", pid 407, jiffies 4294895527 (age 880.020s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 32 00 00 00 f4 01 00 00  .'......2.......
    00 00 00 00 00 00 00 00 d8 c3 5f 84 b4 6e ff ff  .........._..n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000453dcd80>] vcap_add_rule+0x134/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<00000000764a39b4>] vcap_api_rule_insert_reverse_order_test+0x198/0x600
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb484cd4240 (size 192):
  comm "kunit_try_catch", pid 413, jiffies 4294895543 (age 879.956s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 1e 00 00 00 2c 01 00 00  .'..........,...
    00 00 00 00 00 00 00 00 58 42 cd 84 b4 6e ff ff  ........XB...n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<0000000023976dd4>] vcap_api_rule_remove_in_front_test+0x158/0x658
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20
unreferenced object 0xffff6eb484cd4300 (size 192):
  comm "kunit_try_catch", pid 413, jiffies 4294895543 (age 879.956s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 28 00 00 00 c8 00 00 00  .'......(.......
    00 00 00 00 00 00 00 00 18 43 cd 84 b4 6e ff ff  .........C...n..
  backtrace:
    [<00000000f1b5b86e>] slab_post_alloc_hook+0xb8/0x368
    [<00000000c56cdd9a>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000046ef1b64>] kmalloc_trace+0x40/0x164
    [<000000008565145b>] vcap_dup_rule+0x38/0x210
    [<00000000bd9e1f12>] vcap_add_rule+0x29c/0x32c
    [<0000000070a539b1>] test_vcap_xn_rule_creator.constprop.43+0x120/0x330
    [<000000000b4760ff>] vcap_api_rule_remove_in_front_test+0x170/0x658
    [<000000000f88f9cb>] kunit_try_run_case+0x50/0xac
    [<00000000e848de5a>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000058a88b6b>] kthread+0x124/0x130
    [<00000000891cf28a>] ret_from_fork+0x10/0x20

Fixes: dccc30cc4906 ("net: microchip: sparx5: Add KUNIT test of counters and sorted rules")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index 99f04a53a442..fe4e166de8a0 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -1597,6 +1597,11 @@ static void vcap_api_rule_insert_in_order_test(struct kunit *test)
 	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 20, 400, 6, 774);
 	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 30, 300, 3, 771);
 	test_vcap_xn_rule_creator(test, 10000, VCAP_USER_QOS, 40, 200, 2, 768);
+
+	vcap_del_rule(&test_vctrl, &test_netdev, 200);
+	vcap_del_rule(&test_vctrl, &test_netdev, 300);
+	vcap_del_rule(&test_vctrl, &test_netdev, 400);
+	vcap_del_rule(&test_vctrl, &test_netdev, 500);
 }
 
 static void vcap_api_rule_insert_reverse_order_test(struct kunit *test)
@@ -1655,6 +1660,11 @@ static void vcap_api_rule_insert_reverse_order_test(struct kunit *test)
 		++idx;
 	}
 	KUNIT_EXPECT_EQ(test, 768, admin.last_used_addr);
+
+	vcap_del_rule(&test_vctrl, &test_netdev, 500);
+	vcap_del_rule(&test_vctrl, &test_netdev, 400);
+	vcap_del_rule(&test_vctrl, &test_netdev, 300);
+	vcap_del_rule(&test_vctrl, &test_netdev, 200);
 }
 
 static void vcap_api_rule_remove_at_end_test(struct kunit *test)
@@ -1855,6 +1865,9 @@ static void vcap_api_rule_remove_in_front_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 786, test_init_start);
 	KUNIT_EXPECT_EQ(test, 8, test_init_count);
 	KUNIT_EXPECT_EQ(test, 794, admin.last_used_addr);
+
+	vcap_del_rule(&test_vctrl, &test_netdev, 200);
+	vcap_del_rule(&test_vctrl, &test_netdev, 300);
 }
 
 static struct kunit_case vcap_api_rule_remove_test_cases[] = {
-- 
2.34.1


