Return-Path: <netdev+bounces-26365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A3A7779DB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E115B282076
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92D1FB54;
	Thu, 10 Aug 2023 13:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7D1FB35
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:45:39 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585EE54
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 06:45:38 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RM7Sk1BlQz1L9tn;
	Thu, 10 Aug 2023 21:44:22 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 21:45:34 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>, <liuhangbin@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next,v2 3/5] bonding: remove redundant NULL check in debugfs function
Date: Thu, 10 Aug 2023 21:50:05 +0800
Message-ID: <20230810135007.3834770-4-shaozhengchao@huawei.com>
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Because debugfs_create_dir returns ERR_PTR, so bonding_debug_root will
never be NULL. Remove redundant NULL check for bonding_debug_root in
debugfs function. The later debugfs_create_dir/debugfs_remove_recursive
/debugfs_remove_recursive functions will check the dentry with IS_ERR().

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/bonding/bond_debugfs.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
index 50e48136c697..b19492a7f6ad 100644
--- a/drivers/net/bonding/bond_debugfs.c
+++ b/drivers/net/bonding/bond_debugfs.c
@@ -49,9 +49,6 @@ DEFINE_SHOW_ATTRIBUTE(bond_debug_rlb_hash);
 
 void bond_debug_register(struct bonding *bond)
 {
-	if (!bonding_debug_root)
-		return;
-
 	bond->debug_dir =
 		debugfs_create_dir(bond->dev->name, bonding_debug_root);
 
@@ -61,9 +58,6 @@ void bond_debug_register(struct bonding *bond)
 
 void bond_debug_unregister(struct bonding *bond)
 {
-	if (!bonding_debug_root)
-		return;
-
 	debugfs_remove_recursive(bond->debug_dir);
 }
 
@@ -71,9 +65,6 @@ void bond_debug_reregister(struct bonding *bond)
 {
 	struct dentry *d;
 
-	if (!bonding_debug_root)
-		return;
-
 	d = debugfs_rename(bonding_debug_root, bond->debug_dir,
 			   bonding_debug_root, bond->dev->name);
 	if (!IS_ERR(d)) {
-- 
2.34.1


