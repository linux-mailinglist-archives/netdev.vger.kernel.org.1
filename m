Return-Path: <netdev+bounces-32698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02037996C6
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 10:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC751C20C49
	for <lists+netdev@lfdr.de>; Sat,  9 Sep 2023 08:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89A817EE;
	Sat,  9 Sep 2023 08:02:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE001C20
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 08:02:26 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1BE19BA
	for <netdev@vger.kernel.org>; Sat,  9 Sep 2023 01:02:24 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RjQN00Q0yzNnGb;
	Sat,  9 Sep 2023 15:58:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 9 Sep
 2023 16:02:21 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v2 1/5] net: microchip: sparx5: Fix memory leak for vcap_api_rule_add_keyvalue_test()
Date: Sat, 9 Sep 2023 16:02:03 +0800
Message-ID: <20230909080207.1174597-2-ruanjinjie@huawei.com>
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

Inject fault while probing kunit-example-test.ko, the field which
is allocated by kzalloc in vcap_rule_add_key() of
vcap_rule_add_key_bit/u32/u128() is not freed, and it cause
the memory leaks below.

unreferenced object 0xffff0276c14b7240 (size 64):
  comm "kunit_try_catch", pid 284, jiffies 4294894220 (age 920.072s)
  hex dump (first 32 bytes):
    28 3c 61 82 00 80 ff ff 28 3c 61 82 00 80 ff ff  (<a.....(<a.....
    67 00 00 00 00 00 00 00 00 01 37 2b af ab ff ff  g.........7+....
  backtrace:
    [<0000000028f08898>] slab_post_alloc_hook+0xb8/0x368
    [<00000000514b9b37>] __kmem_cache_alloc_node+0x174/0x290
    [<000000004620684a>] kmalloc_trace+0x40/0x164
    [<0000000059ad6bcd>] vcap_rule_add_key+0x104/0x180
    [<00000000ff8002d3>] vcap_api_rule_add_keyvalue_test+0x100/0xba8
    [<00000000fcc5326c>] kunit_try_run_case+0x50/0xac
    [<00000000f5f45b20>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000026284079>] kthread+0x124/0x130
    [<0000000024d4a996>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0276c14b7280 (size 64):
  comm "kunit_try_catch", pid 284, jiffies 4294894221 (age 920.068s)
  hex dump (first 32 bytes):
    28 3c 61 82 00 80 ff ff 28 3c 61 82 00 80 ff ff  (<a.....(<a.....
    67 00 00 00 00 00 00 00 01 01 37 2b af ab ff ff  g.........7+....
  backtrace:
    [<0000000028f08898>] slab_post_alloc_hook+0xb8/0x368
    [<00000000514b9b37>] __kmem_cache_alloc_node+0x174/0x290
    [<000000004620684a>] kmalloc_trace+0x40/0x164
    [<0000000059ad6bcd>] vcap_rule_add_key+0x104/0x180
    [<00000000f5ac9dc7>] vcap_api_rule_add_keyvalue_test+0x168/0xba8
    [<00000000fcc5326c>] kunit_try_run_case+0x50/0xac
    [<00000000f5f45b20>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000026284079>] kthread+0x124/0x130
    [<0000000024d4a996>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0276c14b72c0 (size 64):
  comm "kunit_try_catch", pid 284, jiffies 4294894221 (age 920.068s)
  hex dump (first 32 bytes):
    28 3c 61 82 00 80 ff ff 28 3c 61 82 00 80 ff ff  (<a.....(<a.....
    67 00 00 00 00 00 00 00 00 00 37 2b af ab ff ff  g.........7+....
  backtrace:
    [<0000000028f08898>] slab_post_alloc_hook+0xb8/0x368
    [<00000000514b9b37>] __kmem_cache_alloc_node+0x174/0x290
    [<000000004620684a>] kmalloc_trace+0x40/0x164
    [<0000000059ad6bcd>] vcap_rule_add_key+0x104/0x180
    [<00000000c918ae7f>] vcap_api_rule_add_keyvalue_test+0x1d0/0xba8
    [<00000000fcc5326c>] kunit_try_run_case+0x50/0xac
    [<00000000f5f45b20>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000026284079>] kthread+0x124/0x130
    [<0000000024d4a996>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0276c14b7300 (size 64):
  comm "kunit_try_catch", pid 284, jiffies 4294894221 (age 920.084s)
  hex dump (first 32 bytes):
    28 3c 61 82 00 80 ff ff 28 3c 61 82 00 80 ff ff  (<a.....(<a.....
    7d 00 00 00 01 00 00 00 32 54 76 98 ab ff 00 ff  }.......2Tv.....
  backtrace:
    [<0000000028f08898>] slab_post_alloc_hook+0xb8/0x368
    [<00000000514b9b37>] __kmem_cache_alloc_node+0x174/0x290
    [<000000004620684a>] kmalloc_trace+0x40/0x164
    [<0000000059ad6bcd>] vcap_rule_add_key+0x104/0x180
    [<0000000003352814>] vcap_api_rule_add_keyvalue_test+0x240/0xba8
    [<00000000fcc5326c>] kunit_try_run_case+0x50/0xac
    [<00000000f5f45b20>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000026284079>] kthread+0x124/0x130
    [<0000000024d4a996>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0276c14b7340 (size 64):
  comm "kunit_try_catch", pid 284, jiffies 4294894221 (age 920.084s)
  hex dump (first 32 bytes):
    28 3c 61 82 00 80 ff ff 28 3c 61 82 00 80 ff ff  (<a.....(<a.....
    51 00 00 00 07 00 00 00 17 26 35 44 63 62 71 00  Q........&5Dcbq.
  backtrace:
    [<0000000028f08898>] slab_post_alloc_hook+0xb8/0x368
    [<00000000514b9b37>] __kmem_cache_alloc_node+0x174/0x290
    [<000000004620684a>] kmalloc_trace+0x40/0x164
    [<0000000059ad6bcd>] vcap_rule_add_key+0x104/0x180
    [<000000001516f109>] vcap_api_rule_add_keyvalue_test+0x2cc/0xba8
    [<00000000fcc5326c>] kunit_try_run_case+0x50/0xac
    [<00000000f5f45b20>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<0000000026284079>] kthread+0x124/0x130
    [<0000000024d4a996>] ret_from_fork+0x10/0x20

Fixes: c956b9b318d9 ("net: microchip: sparx5: Adding KUNIT tests of key/action values in VCAP API")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c  | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index c07f25e791c7..2fb0b8cf2b0c 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -995,6 +995,16 @@ static void vcap_api_encode_rule_actionset_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (u32)0x00000000, actwords[11]);
 }
 
+static void vcap_free_ckf(struct vcap_rule *rule)
+{
+	struct vcap_client_keyfield *ckf, *next_ckf;
+
+	list_for_each_entry_safe(ckf, next_ckf, &rule->keyfields, ctrl.list) {
+		list_del(&ckf->ctrl.list);
+		kfree(ckf);
+	}
+}
+
 static void vcap_api_rule_add_keyvalue_test(struct kunit *test)
 {
 	struct vcap_admin admin = {
@@ -1027,6 +1037,7 @@ static void vcap_api_rule_add_keyvalue_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, VCAP_FIELD_BIT, kf->ctrl.type);
 	KUNIT_EXPECT_EQ(test, 0x0, kf->data.u1.value);
 	KUNIT_EXPECT_EQ(test, 0x1, kf->data.u1.mask);
+	vcap_free_ckf(rule);
 
 	INIT_LIST_HEAD(&rule->keyfields);
 	ret = vcap_rule_add_key_bit(rule, VCAP_KF_LOOKUP_FIRST_IS, VCAP_BIT_1);
@@ -1039,6 +1050,7 @@ static void vcap_api_rule_add_keyvalue_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, VCAP_FIELD_BIT, kf->ctrl.type);
 	KUNIT_EXPECT_EQ(test, 0x1, kf->data.u1.value);
 	KUNIT_EXPECT_EQ(test, 0x1, kf->data.u1.mask);
+	vcap_free_ckf(rule);
 
 	INIT_LIST_HEAD(&rule->keyfields);
 	ret = vcap_rule_add_key_bit(rule, VCAP_KF_LOOKUP_FIRST_IS,
@@ -1052,6 +1064,7 @@ static void vcap_api_rule_add_keyvalue_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, VCAP_FIELD_BIT, kf->ctrl.type);
 	KUNIT_EXPECT_EQ(test, 0x0, kf->data.u1.value);
 	KUNIT_EXPECT_EQ(test, 0x0, kf->data.u1.mask);
+	vcap_free_ckf(rule);
 
 	INIT_LIST_HEAD(&rule->keyfields);
 	ret = vcap_rule_add_key_u32(rule, VCAP_KF_TYPE, 0x98765432, 0xff00ffab);
@@ -1064,6 +1077,7 @@ static void vcap_api_rule_add_keyvalue_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, VCAP_FIELD_U32, kf->ctrl.type);
 	KUNIT_EXPECT_EQ(test, 0x98765432, kf->data.u32.value);
 	KUNIT_EXPECT_EQ(test, 0xff00ffab, kf->data.u32.mask);
+	vcap_free_ckf(rule);
 
 	INIT_LIST_HEAD(&rule->keyfields);
 	ret = vcap_rule_add_key_u128(rule, VCAP_KF_L3_IP6_SIP, &dip);
@@ -1078,6 +1092,7 @@ static void vcap_api_rule_add_keyvalue_test(struct kunit *test)
 		KUNIT_EXPECT_EQ(test, dip.value[idx], kf->data.u128.value[idx]);
 	for (idx = 0; idx < ARRAY_SIZE(dip.mask); ++idx)
 		KUNIT_EXPECT_EQ(test, dip.mask[idx], kf->data.u128.mask[idx]);
+	vcap_free_ckf(rule);
 }
 
 static void vcap_api_rule_add_actionvalue_test(struct kunit *test)
-- 
2.34.1


