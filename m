Return-Path: <netdev+bounces-62284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B00826700
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 02:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E00891C21696
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 01:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89F64F;
	Mon,  8 Jan 2024 01:01:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319547F
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4T7bMl5xjLzNkcY;
	Mon,  8 Jan 2024 09:00:35 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 01B111400DC;
	Mon,  8 Jan 2024 09:01:11 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 09:01:10 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next] fib: rules: use memcmp to simplify code in rule_exists
Date: Mon, 8 Jan 2024 09:11:31 +0800
Message-ID: <20240108011131.83295-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)

In the fib_rule structure, the member variables 'pref' to 'oifname' are
consecutive. In addition, the newly generated rule uses kzalloc to
allocate memory, and all allocated memory is initialized to 0. Therefore,
the comparison of two fib_rule structures from 'pref' to 'oifname' can be
simplified into the comparison of continuous memory.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/core/fib_rules.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index a50a0bde8db1..e6def052e7d3 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -686,6 +686,10 @@ static int rule_exists(struct fib_rules_ops *ops, struct fib_rule_hdr *frh,
 		       struct nlattr **tb, struct fib_rule *rule)
 {
 	struct fib_rule *r;
+	size_t off_len;
+
+	off_len = offsetof(struct fib_rule, uid_range) -
+		  offsetof(struct fib_rule, pref);
 
 	list_for_each_entry(r, &ops->rules_list, list) {
 		if (r->action != rule->action)
@@ -694,24 +698,12 @@ static int rule_exists(struct fib_rules_ops *ops, struct fib_rule_hdr *frh,
 		if (r->table != rule->table)
 			continue;
 
-		if (r->pref != rule->pref)
-			continue;
-
-		if (memcmp(r->iifname, rule->iifname, IFNAMSIZ))
-			continue;
-
-		if (memcmp(r->oifname, rule->oifname, IFNAMSIZ))
+		if (memcmp(&r->pref, &rule->pref, off_len))
 			continue;
 
 		if (r->mark != rule->mark)
 			continue;
 
-		if (r->suppress_ifgroup != rule->suppress_ifgroup)
-			continue;
-
-		if (r->suppress_prefixlen != rule->suppress_prefixlen)
-			continue;
-
 		if (r->mark_mask != rule->mark_mask)
 			continue;
 
-- 
2.34.1


