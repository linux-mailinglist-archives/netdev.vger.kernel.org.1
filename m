Return-Path: <netdev+bounces-33192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6EA79CF4C
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976691C210A6
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815AE179AF;
	Tue, 12 Sep 2023 11:05:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBEF179AB
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:05:29 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A22A211E
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:05:28 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RlLKD1lyqzrSgM;
	Tue, 12 Sep 2023 19:02:56 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 19:04:51 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v3 2/5] net: microchip: sparx5: Fix memory leak for vcap_api_rule_add_actionvalue_test()
Date: Tue, 12 Sep 2023 19:03:07 +0800
Message-ID: <20230912110310.1540474-3-ruanjinjie@huawei.com>
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

Inject fault while probing kunit-example-test.ko, the field which
is allocated by kzalloc in vcap_rule_add_action() of
vcap_rule_add_action_bit/u32() is not freed, and it cause
the memory leaks below.

unreferenced object 0xffff0276c496b300 (size 64):
  comm "kunit_try_catch", pid 286, jiffies 4294894224 (age 920.072s)
  hex dump (first 32 bytes):
    68 3c 62 82 00 80 ff ff 68 3c 62 82 00 80 ff ff  h<b.....h<b.....
    3c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  <...............
  backtrace:
    [<0000000028f08898>] slab_post_alloc_hook+0xb8/0x368
    [<00000000514b9b37>] __kmem_cache_alloc_node+0x174/0x290
    [<000000004620684a>] kmalloc_trace+0x40/0x164
    [<000000008b41c84d>] vcap_rule_add_action+0x104/0x178
    [<00000000ae66c16c>] vcap_api_rule_add_actionvalue_test+0xa4/0x990
    [<00000000fcc5326c>] kunit_try_run_case+0x50/0xac
    [<00000000f5f45b20>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000026284079>] kthread+0x124/0x130
    [<0000000024d4a996>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0276c496b2c0 (size 64):
  comm "kunit_try_catch", pid 286, jiffies 4294894224 (age 920.072s)
  hex dump (first 32 bytes):
    68 3c 62 82 00 80 ff ff 68 3c 62 82 00 80 ff ff  h<b.....h<b.....
    3c 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  <...............
  backtrace:
    [<0000000028f08898>] slab_post_alloc_hook+0xb8/0x368
    [<00000000514b9b37>] __kmem_cache_alloc_node+0x174/0x290
    [<000000004620684a>] kmalloc_trace+0x40/0x164
    [<000000008b41c84d>] vcap_rule_add_action+0x104/0x178
    [<00000000607782aa>] vcap_api_rule_add_actionvalue_test+0x100/0x990
    [<00000000fcc5326c>] kunit_try_run_case+0x50/0xac
    [<00000000f5f45b20>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000026284079>] kthread+0x124/0x130
    [<0000000024d4a996>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0276c496b280 (size 64):
  comm "kunit_try_catch", pid 286, jiffies 4294894224 (age 920.072s)
  hex dump (first 32 bytes):
    68 3c 62 82 00 80 ff ff 68 3c 62 82 00 80 ff ff  h<b.....h<b.....
    3c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  <...............
  backtrace:
    [<0000000028f08898>] slab_post_alloc_hook+0xb8/0x368
    [<00000000514b9b37>] __kmem_cache_alloc_node+0x174/0x290
    [<000000004620684a>] kmalloc_trace+0x40/0x164
    [<000000008b41c84d>] vcap_rule_add_action+0x104/0x178
    [<000000004e640602>] vcap_api_rule_add_actionvalue_test+0x15c/0x990
    [<00000000fcc5326c>] kunit_try_run_case+0x50/0xac
    [<00000000f5f45b20>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000026284079>] kthread+0x124/0x130
    [<0000000024d4a996>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0276c496b240 (size 64):
  comm "kunit_try_catch", pid 286, jiffies 4294894224 (age 920.092s)
  hex dump (first 32 bytes):
    68 3c 62 82 00 80 ff ff 68 3c 62 82 00 80 ff ff  h<b.....h<b.....
    5a 00 00 00 01 00 00 00 32 54 76 98 00 00 00 00  Z.......2Tv.....
  backtrace:
    [<0000000028f08898>] slab_post_alloc_hook+0xb8/0x368
    [<00000000514b9b37>] __kmem_cache_alloc_node+0x174/0x290
    [<000000004620684a>] kmalloc_trace+0x40/0x164
    [<000000008b41c84d>] vcap_rule_add_action+0x104/0x178
    [<0000000011141bf8>] vcap_api_rule_add_actionvalue_test+0x1bc/0x990
    [<00000000fcc5326c>] kunit_try_run_case+0x50/0xac
    [<00000000f5f45b20>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000026284079>] kthread+0x124/0x130
    [<0000000024d4a996>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0276c496b200 (size 64):
  comm "kunit_try_catch", pid 286, jiffies 4294894224 (age 920.092s)
  hex dump (first 32 bytes):
    68 3c 62 82 00 80 ff ff 68 3c 62 82 00 80 ff ff  h<b.....h<b.....
    28 00 00 00 01 00 00 00 dd cc bb aa 00 00 00 00  (...............
  backtrace:
    [<0000000028f08898>] slab_post_alloc_hook+0xb8/0x368
    [<00000000514b9b37>] __kmem_cache_alloc_node+0x174/0x290
    [<000000004620684a>] kmalloc_trace+0x40/0x164
    [<000000008b41c84d>] vcap_rule_add_action+0x104/0x178
    [<00000000d5ed3088>] vcap_api_rule_add_actionvalue_test+0x22c/0x990
    [<00000000fcc5326c>] kunit_try_run_case+0x50/0xac
    [<00000000f5f45b20>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000026284079>] kthread+0x124/0x130
    [<0000000024d4a996>] ret_from_fork+0x10/0x20

Fixes: c956b9b318d9 ("net: microchip: sparx5: Adding KUNIT tests of key/action values in VCAP API")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Adhere to the 80 character limit in vcap_free_caf()
---
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index 2fb0b8cf2b0c..f268383a7570 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -1095,6 +1095,17 @@ static void vcap_api_rule_add_keyvalue_test(struct kunit *test)
 	vcap_free_ckf(rule);
 }
 
+static void vcap_free_caf(struct vcap_rule *rule)
+{
+	struct vcap_client_actionfield *caf, *next_caf;
+
+	list_for_each_entry_safe(caf, next_caf,
+				 &rule->actionfields, ctrl.list) {
+		list_del(&caf->ctrl.list);
+		kfree(caf);
+	}
+}
+
 static void vcap_api_rule_add_actionvalue_test(struct kunit *test)
 {
 	struct vcap_admin admin = {
@@ -1120,6 +1131,7 @@ static void vcap_api_rule_add_actionvalue_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, VCAP_AF_POLICE_ENA, af->ctrl.action);
 	KUNIT_EXPECT_EQ(test, VCAP_FIELD_BIT, af->ctrl.type);
 	KUNIT_EXPECT_EQ(test, 0x0, af->data.u1.value);
+	vcap_free_caf(rule);
 
 	INIT_LIST_HEAD(&rule->actionfields);
 	ret = vcap_rule_add_action_bit(rule, VCAP_AF_POLICE_ENA, VCAP_BIT_1);
@@ -1131,6 +1143,7 @@ static void vcap_api_rule_add_actionvalue_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, VCAP_AF_POLICE_ENA, af->ctrl.action);
 	KUNIT_EXPECT_EQ(test, VCAP_FIELD_BIT, af->ctrl.type);
 	KUNIT_EXPECT_EQ(test, 0x1, af->data.u1.value);
+	vcap_free_caf(rule);
 
 	INIT_LIST_HEAD(&rule->actionfields);
 	ret = vcap_rule_add_action_bit(rule, VCAP_AF_POLICE_ENA, VCAP_BIT_ANY);
@@ -1142,6 +1155,7 @@ static void vcap_api_rule_add_actionvalue_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, VCAP_AF_POLICE_ENA, af->ctrl.action);
 	KUNIT_EXPECT_EQ(test, VCAP_FIELD_BIT, af->ctrl.type);
 	KUNIT_EXPECT_EQ(test, 0x0, af->data.u1.value);
+	vcap_free_caf(rule);
 
 	INIT_LIST_HEAD(&rule->actionfields);
 	ret = vcap_rule_add_action_u32(rule, VCAP_AF_TYPE, 0x98765432);
@@ -1153,6 +1167,7 @@ static void vcap_api_rule_add_actionvalue_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, VCAP_AF_TYPE, af->ctrl.action);
 	KUNIT_EXPECT_EQ(test, VCAP_FIELD_U32, af->ctrl.type);
 	KUNIT_EXPECT_EQ(test, 0x98765432, af->data.u32.value);
+	vcap_free_caf(rule);
 
 	INIT_LIST_HEAD(&rule->actionfields);
 	ret = vcap_rule_add_action_u32(rule, VCAP_AF_MASK_MODE, 0xaabbccdd);
@@ -1164,6 +1179,7 @@ static void vcap_api_rule_add_actionvalue_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, VCAP_AF_MASK_MODE, af->ctrl.action);
 	KUNIT_EXPECT_EQ(test, VCAP_FIELD_U32, af->ctrl.type);
 	KUNIT_EXPECT_EQ(test, 0xaabbccdd, af->data.u32.value);
+	vcap_free_caf(rule);
 }
 
 static void vcap_api_rule_find_keyset_basic_test(struct kunit *test)
-- 
2.34.1


