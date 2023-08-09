Return-Path: <netdev+bounces-25829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CF2775F38
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893D81C21264
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCEC182AD;
	Wed,  9 Aug 2023 12:36:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D4182A7
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:36:36 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9111BDA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:36:33 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RLTzW6vWJz15NTj;
	Wed,  9 Aug 2023 20:35:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 20:36:30 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next 1/5] bonding: add modifier to initialization function and exit function
Date: Wed, 9 Aug 2023 20:41:03 +0800
Message-ID: <20230809124107.360574-2-shaozhengchao@huawei.com>
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

Some functions are only used in initialization and exit functions, so add
the __init/__net_init and __net_exit modifiers to these functions.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/bonding/bond_debugfs.c | 4 ++--
 drivers/net/bonding/bond_main.c    | 2 +-
 drivers/net/bonding/bond_sysfs.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 594094526648..94c2f35e3bfc 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -84,7 +84,7 @@ void bond_debug_reregister(struct bonding *bond)
 	}
 }
 
-void bond_create_debugfs(void)
+void __init bond_create_debugfs(void)
 {
 	bonding_debug_root = debugfs_create_dir("bonding", NULL);
 
@@ -113,7 +113,7 @@ void bond_debug_reregister(struct bonding *bond)
 {
 }
 
-void bond_create_debugfs(void)
+void __init bond_create_debugfs(void)
 {
 }
 
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d26c69d84c1e..6636638f5d97 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5981,7 +5981,7 @@ static void bond_uninit(struct net_device *bond_dev)
 
 /*------------------------- Module initialization ---------------------------*/
 
-static int bond_check_params(struct bond_params *params)
+static int __init bond_check_params(struct bond_params *params)
 {
 	int arp_validate_value, fail_over_mac_value, primary_reselect_value, i;
 	struct bond_opt_value newval;
diff --git a/drivers/net/bonding/bond_sysfs.c b/drivers/net/bonding/bond_sysfs.c
index 0bb59da24922..2805135a7205 100644
--- a/drivers/net/bonding/bond_sysfs.c
+++ b/drivers/net/bonding/bond_sysfs.c
@@ -803,7 +803,7 @@ static const struct attribute_group bonding_group = {
 /* Initialize sysfs.  This sets up the bonding_masters file in
  * /sys/class/net.
  */
-int bond_create_sysfs(struct bond_net *bn)
+int __net_init bond_create_sysfs(struct bond_net *bn)
 {
 	int ret;
 
@@ -836,7 +836,7 @@ int bond_create_sysfs(struct bond_net *bn)
 }
 
 /* Remove /sys/class/net/bonding_masters. */
-void bond_destroy_sysfs(struct bond_net *bn)
+void __net_exit bond_destroy_sysfs(struct bond_net *bn)
 {
 	netdev_class_remove_file_ns(&bn->class_attr_bonding_masters, bn->net);
 }
-- 
2.34.1


