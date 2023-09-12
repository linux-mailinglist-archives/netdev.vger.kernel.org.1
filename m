Return-Path: <netdev+bounces-33189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1988C79CF35
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7214C1C20F1D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B26117755;
	Tue, 12 Sep 2023 11:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604417753
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:05:18 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8091FE9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:05:15 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RlLJW75MQzVkfB;
	Tue, 12 Sep 2023 19:02:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 19:05:05 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <lars.povlsen@microchip.com>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net v3 4/5] net: microchip: sparx5: Fix possible memory leaks in test_vcap_xn_rule_creator()
Date: Tue, 12 Sep 2023 19:03:09 +0800
Message-ID: <20230912110310.1540474-5-ruanjinjie@huawei.com>
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

Inject fault while probing kunit-example-test.ko, the rule which
is allocated by kzalloc in vcap_alloc_rule(), the field which is
allocated by kzalloc in vcap_rule_add_action() and
vcap_rule_add_key() is not freed, and it cause the memory leaks
below. Use vcap_free_rule() to free them as other drivers do it.

And since the return rule of test_vcap_xn_rule_creator() is not
used, remove it and switch to void.

unreferenced object 0xffff058383334240 (size 192):
  comm "kunit_try_catch", pid 309, jiffies 4294894222 (age 639.800s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 14 00 00 00 90 01 00 00  .'..............
    00 00 00 00 00 00 00 00 00 81 93 84 83 05 ff ff  ................
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<00000000648fefae>] vcap_alloc_rule+0x17c/0x26c
    [<000000004da16164>] test_vcap_xn_rule_creator.constprop.43+0xac/0x328
    [<00000000231b1097>] vcap_api_rule_insert_in_order_test+0xcc/0x184
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0583849380c0 (size 64):
  comm "kunit_try_catch", pid 309, jiffies 4294894222 (age 639.800s)
  hex dump (first 32 bytes):
    40 81 93 84 83 05 ff ff 68 42 33 83 83 05 ff ff  @.......hB3.....
    22 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  "...............
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<00000000ee41df9e>] vcap_rule_add_action+0x104/0x178
    [<000000001cc1bb38>] test_vcap_xn_rule_creator.constprop.43+0xd8/0x328
    [<00000000231b1097>] vcap_api_rule_insert_in_order_test+0xcc/0x184
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20
unreferenced object 0xffff058384938100 (size 64):
  comm "kunit_try_catch", pid 309, jiffies 4294894222 (age 639.800s)
  hex dump (first 32 bytes):
    80 81 93 84 83 05 ff ff 58 42 33 83 83 05 ff ff  ........XB3.....
    7d 00 00 00 01 00 00 00 02 00 00 00 ff 00 00 00  }...............
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<0000000043c78991>] vcap_rule_add_key+0x104/0x180
    [<00000000ba73cfbe>] vcap_add_type_keyfield+0xfc/0x128
    [<000000002b00f7df>] vcap_val_rule+0x274/0x3e8
    [<00000000e67d2ff5>] test_vcap_xn_rule_creator.constprop.43+0xf0/0x328
    [<00000000231b1097>] vcap_api_rule_insert_in_order_test+0xcc/0x184
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20

unreferenced object 0xffff0583833b6240 (size 192):
  comm "kunit_try_catch", pid 311, jiffies 4294894225 (age 639.844s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 1e 00 00 00 2c 01 00 00  .'..........,...
    00 00 00 00 00 00 00 00 40 91 8f 84 83 05 ff ff  ........@.......
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<00000000648fefae>] vcap_alloc_rule+0x17c/0x26c
    [<000000004da16164>] test_vcap_xn_rule_creator.constprop.43+0xac/0x328
    [<00000000509de3f4>] vcap_api_rule_insert_reverse_order_test+0x10c/0x654
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0583848f9100 (size 64):
  comm "kunit_try_catch", pid 311, jiffies 4294894225 (age 639.844s)
  hex dump (first 32 bytes):
    80 91 8f 84 83 05 ff ff 68 62 3b 83 83 05 ff ff  ........hb;.....
    22 00 00 00 01 00 00 00 00 00 00 00 a5 b4 ff ff  "...............
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<00000000ee41df9e>] vcap_rule_add_action+0x104/0x178
    [<000000001cc1bb38>] test_vcap_xn_rule_creator.constprop.43+0xd8/0x328
    [<00000000509de3f4>] vcap_api_rule_insert_reverse_order_test+0x10c/0x654
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0583848f9140 (size 64):
  comm "kunit_try_catch", pid 311, jiffies 4294894225 (age 639.844s)
  hex dump (first 32 bytes):
    c0 91 8f 84 83 05 ff ff 58 62 3b 83 83 05 ff ff  ........Xb;.....
    7d 00 00 00 01 00 00 00 02 00 00 00 ff 00 00 00  }...............
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<0000000043c78991>] vcap_rule_add_key+0x104/0x180
    [<00000000ba73cfbe>] vcap_add_type_keyfield+0xfc/0x128
    [<000000002b00f7df>] vcap_val_rule+0x274/0x3e8
    [<00000000e67d2ff5>] test_vcap_xn_rule_creator.constprop.43+0xf0/0x328
    [<00000000509de3f4>] vcap_api_rule_insert_reverse_order_test+0x10c/0x654
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20

unreferenced object 0xffff05838264e0c0 (size 192):
  comm "kunit_try_catch", pid 313, jiffies 4294894230 (age 639.864s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 0a 00 00 00 f4 01 00 00  .'..............
    00 00 00 00 00 00 00 00 40 3a 97 84 83 05 ff ff  ........@:......
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<00000000648fefae>] vcap_alloc_rule+0x17c/0x26c
    [<000000004da16164>] test_vcap_xn_rule_creator.constprop.43+0xac/0x328
    [<00000000a29794d8>] vcap_api_rule_remove_at_end_test+0xbc/0xb48
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20
unreferenced object 0xffff058384973a80 (size 64):
  comm "kunit_try_catch", pid 313, jiffies 4294894230 (age 639.864s)
  hex dump (first 32 bytes):
    e8 e0 64 82 83 05 ff ff e8 e0 64 82 83 05 ff ff  ..d.......d.....
    22 00 00 00 01 00 00 00 00 00 00 00 00 80 ff ff  "...............
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<00000000ee41df9e>] vcap_rule_add_action+0x104/0x178
    [<000000001cc1bb38>] test_vcap_xn_rule_creator.constprop.43+0xd8/0x328
    [<00000000a29794d8>] vcap_api_rule_remove_at_end_test+0xbc/0xb48
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20
unreferenced object 0xffff058384973a40 (size 64):
  comm "kunit_try_catch", pid 313, jiffies 4294894230 (age 639.880s)
  hex dump (first 32 bytes):
    80 39 97 84 83 05 ff ff d8 e0 64 82 83 05 ff ff  .9........d.....
    7d 00 00 00 00 00 00 00 00 01 00 00 00 00 00 00  }...............
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<0000000043c78991>] vcap_rule_add_key+0x104/0x180
    [<0000000094335477>] vcap_add_type_keyfield+0xbc/0x128
    [<000000002b00f7df>] vcap_val_rule+0x274/0x3e8
    [<00000000e67d2ff5>] test_vcap_xn_rule_creator.constprop.43+0xf0/0x328
    [<00000000a29794d8>] vcap_api_rule_remove_at_end_test+0xbc/0xb48
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20

unreferenced object 0xffff0583832fa240 (size 192):
  comm "kunit_try_catch", pid 315, jiffies 4294894233 (age 639.920s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 14 00 00 00 90 01 00 00  .'..............
    00 00 00 00 00 00 00 00 00 a1 8b 84 83 05 ff ff  ................
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<00000000648fefae>] vcap_alloc_rule+0x17c/0x26c
    [<000000004da16164>] test_vcap_xn_rule_creator.constprop.43+0xac/0x328
    [<00000000be638a45>] vcap_api_rule_remove_in_middle_test+0xc4/0xb80
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0583848ba0c0 (size 64):
  comm "kunit_try_catch", pid 315, jiffies 4294894233 (age 639.920s)
  hex dump (first 32 bytes):
    40 a1 8b 84 83 05 ff ff 68 a2 2f 83 83 05 ff ff  @.......h./.....
    22 00 00 00 01 00 00 00 00 00 00 00 00 80 ff ff  "...............
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<00000000ee41df9e>] vcap_rule_add_action+0x104/0x178
    [<000000001cc1bb38>] test_vcap_xn_rule_creator.constprop.43+0xd8/0x328
    [<00000000be638a45>] vcap_api_rule_remove_in_middle_test+0xc4/0xb80
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20
unreferenced object 0xffff0583848ba100 (size 64):
  comm "kunit_try_catch", pid 315, jiffies 4294894233 (age 639.920s)
  hex dump (first 32 bytes):
    80 a1 8b 84 83 05 ff ff 58 a2 2f 83 83 05 ff ff  ........X./.....
    7d 00 00 00 01 00 00 00 02 00 00 00 ff 00 00 00  }...............
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<0000000043c78991>] vcap_rule_add_key+0x104/0x180
    [<00000000ba73cfbe>] vcap_add_type_keyfield+0xfc/0x128
    [<000000002b00f7df>] vcap_val_rule+0x274/0x3e8
    [<00000000e67d2ff5>] test_vcap_xn_rule_creator.constprop.43+0xf0/0x328
    [<00000000be638a45>] vcap_api_rule_remove_in_middle_test+0xc4/0xb80
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20

unreferenced object 0xffff0583827d2180 (size 192):
  comm "kunit_try_catch", pid 317, jiffies 4294894238 (age 639.956s)
  hex dump (first 32 bytes):
    10 27 00 00 04 00 00 00 14 00 00 00 90 01 00 00  .'..............
    00 00 00 00 00 00 00 00 00 e1 06 83 83 05 ff ff  ................
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<00000000648fefae>] vcap_alloc_rule+0x17c/0x26c
    [<000000004da16164>] test_vcap_xn_rule_creator.constprop.43+0xac/0x328
    [<00000000e1ed8350>] vcap_api_rule_remove_in_front_test+0x144/0x6c0
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20
unreferenced object 0xffff05838306e0c0 (size 64):
  comm "kunit_try_catch", pid 317, jiffies 4294894238 (age 639.956s)
  hex dump (first 32 bytes):
    40 e1 06 83 83 05 ff ff a8 21 7d 82 83 05 ff ff  @........!}.....
    22 00 00 00 01 00 00 00 00 00 00 00 00 80 ff ff  "...............
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<00000000ee41df9e>] vcap_rule_add_action+0x104/0x178
    [<000000001cc1bb38>] test_vcap_xn_rule_creator.constprop.43+0xd8/0x328
    [<00000000e1ed8350>] vcap_api_rule_remove_in_front_test+0x144/0x6c0
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20
unreferenced object 0xffff05838306e180 (size 64):
  comm "kunit_try_catch", pid 317, jiffies 4294894238 (age 639.968s)
  hex dump (first 32 bytes):
    98 21 7d 82 83 05 ff ff 00 e1 06 83 83 05 ff ff  .!}.............
    67 00 00 00 00 00 00 00 01 01 00 00 ff 00 00 00  g...............
  backtrace:
    [<000000008585a8f7>] slab_post_alloc_hook+0xb8/0x368
    [<00000000795eba12>] __kmem_cache_alloc_node+0x174/0x290
    [<0000000061886991>] kmalloc_trace+0x40/0x164
    [<0000000043c78991>] vcap_rule_add_key+0x104/0x180
    [<000000006ce4945d>] test_add_def_fields+0x84/0x8c
    [<00000000507e0ab6>] vcap_val_rule+0x294/0x3e8
    [<00000000e67d2ff5>] test_vcap_xn_rule_creator.constprop.43+0xf0/0x328
    [<00000000e1ed8350>] vcap_api_rule_remove_in_front_test+0x144/0x6c0
    [<00000000548b559e>] kunit_try_run_case+0x50/0xac
    [<00000000663f0105>] kunit_generic_run_threadfn_adapter+0x20/0x2c
    [<00000000e646f120>] kthread+0x124/0x130
    [<000000005257599e>] ret_from_fork+0x10/0x20

Fixes: dccc30cc4906 ("net: microchip: sparx5: Add KUNIT test of counters and sorted rules")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309090950.uOTEKQq3-lkp@intel.com/
---
v3:
- Fix the typo from "vcap_dup_rule" to "vcap_alloc_rule"
---
 drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
index 8c61a5dbce55..99f04a53a442 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c
@@ -243,10 +243,9 @@ static void vcap_test_api_init(struct vcap_admin *admin)
 }
 
 /* Helper function to create a rule of a specific size */
-static struct vcap_rule *
-test_vcap_xn_rule_creator(struct kunit *test, int cid, enum vcap_user user,
-			  u16 priority,
-			  int id, int size, int expected_addr)
+static void test_vcap_xn_rule_creator(struct kunit *test, int cid,
+				      enum vcap_user user, u16 priority,
+				      int id, int size, int expected_addr)
 {
 	struct vcap_rule *rule;
 	struct vcap_rule_internal *ri;
@@ -311,7 +310,7 @@ test_vcap_xn_rule_creator(struct kunit *test, int cid, enum vcap_user user,
 	ret = vcap_add_rule(rule);
 	KUNIT_EXPECT_EQ(test, 0, ret);
 	KUNIT_EXPECT_EQ(test, expected_addr, ri->addr);
-	return rule;
+	vcap_free_rule(rule);
 }
 
 /* Prepare testing rule deletion */
-- 
2.34.1


