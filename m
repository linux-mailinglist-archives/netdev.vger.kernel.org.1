Return-Path: <netdev+bounces-60779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B418217E5
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 08:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB731C213D8
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 07:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFA815D0;
	Tue,  2 Jan 2024 07:04:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD2A20F5
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4T43k22LVSzsV8g;
	Tue,  2 Jan 2024 15:04:10 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BEFC140486;
	Tue,  2 Jan 2024 15:04:44 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 2 Jan
 2024 15:04:43 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next] fib: remove unnecessary input parameters in fib_default_rule_add
Date: Tue, 2 Jan 2024 15:15:19 +0800
Message-ID: <20240102071519.3781384-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)

When fib_default_rule_add is invoked, the value of the input parameter
'flags' is always 0. Rules uses kzalloc to allocate memory, so 'flags' has
been initialized to 0. Therefore, remove the input parameter 'flags' in
fib_default_rule_add.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 include/net/fib_rules.h | 3 +--
 net/core/fib_rules.c    | 3 +--
 net/ipv4/fib_rules.c    | 6 +++---
 net/ipv4/ipmr.c         | 2 +-
 net/ipv6/fib6_rules.c   | 4 ++--
 net/ipv6/ip6mr.c        | 2 +-
 6 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index 82da359bca03..d17855c52ef9 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -172,8 +172,7 @@ void fib_rules_unregister(struct fib_rules_ops *);
 
 int fib_rules_lookup(struct fib_rules_ops *, struct flowi *, int flags,
 		     struct fib_lookup_arg *);
-int fib_default_rule_add(struct fib_rules_ops *, u32 pref, u32 table,
-			 u32 flags);
+int fib_default_rule_add(struct fib_rules_ops *, u32 pref, u32 table);
 bool fib_rule_matchall(const struct fib_rule *rule);
 int fib_rules_dump(struct net *net, struct notifier_block *nb, int family,
 		   struct netlink_ext_ack *extack);
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 75282222e0b4..96622bfb838a 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -53,7 +53,7 @@ bool fib_rule_matchall(const struct fib_rule *rule)
 EXPORT_SYMBOL_GPL(fib_rule_matchall);
 
 int fib_default_rule_add(struct fib_rules_ops *ops,
-			 u32 pref, u32 table, u32 flags)
+			 u32 pref, u32 table)
 {
 	struct fib_rule *r;
 
@@ -65,7 +65,6 @@ int fib_default_rule_add(struct fib_rules_ops *ops,
 	r->action = FR_ACT_TO_TBL;
 	r->pref = pref;
 	r->table = table;
-	r->flags = flags;
 	r->proto = RTPROT_KERNEL;
 	r->fr_net = ops->fro_net;
 	r->uid_range = fib_kuid_range_unset;
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 513f475c6a53..5bdd1c016009 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -395,13 +395,13 @@ static int fib_default_rules_init(struct fib_rules_ops *ops)
 {
 	int err;
 
-	err = fib_default_rule_add(ops, 0, RT_TABLE_LOCAL, 0);
+	err = fib_default_rule_add(ops, 0, RT_TABLE_LOCAL);
 	if (err < 0)
 		return err;
-	err = fib_default_rule_add(ops, 0x7FFE, RT_TABLE_MAIN, 0);
+	err = fib_default_rule_add(ops, 0x7FFE, RT_TABLE_MAIN);
 	if (err < 0)
 		return err;
-	err = fib_default_rule_add(ops, 0x7FFF, RT_TABLE_DEFAULT, 0);
+	err = fib_default_rule_add(ops, 0x7FFF, RT_TABLE_DEFAULT);
 	if (err < 0)
 		return err;
 	return 0;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 0063a237253b..9d6f59531b3a 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -253,7 +253,7 @@ static int __net_init ipmr_rules_init(struct net *net)
 		goto err1;
 	}
 
-	err = fib_default_rule_add(ops, 0x7fff, RT_TABLE_DEFAULT, 0);
+	err = fib_default_rule_add(ops, 0x7fff, RT_TABLE_DEFAULT);
 	if (err < 0)
 		goto err2;
 
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 7c2003833010..7523c4baef35 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -475,11 +475,11 @@ static int __net_init fib6_rules_net_init(struct net *net)
 	if (IS_ERR(ops))
 		return PTR_ERR(ops);
 
-	err = fib_default_rule_add(ops, 0, RT6_TABLE_LOCAL, 0);
+	err = fib_default_rule_add(ops, 0, RT6_TABLE_LOCAL);
 	if (err)
 		goto out_fib6_rules_ops;
 
-	err = fib_default_rule_add(ops, 0x7FFE, RT6_TABLE_MAIN, 0);
+	err = fib_default_rule_add(ops, 0x7FFE, RT6_TABLE_MAIN);
 	if (err)
 		goto out_fib6_rules_ops;
 
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 30ca064b76ef..9782c180fee6 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -242,7 +242,7 @@ static int __net_init ip6mr_rules_init(struct net *net)
 		goto err1;
 	}
 
-	err = fib_default_rule_add(ops, 0x7fff, RT6_TABLE_DFLT, 0);
+	err = fib_default_rule_add(ops, 0x7fff, RT6_TABLE_DFLT);
 	if (err < 0)
 		goto err2;
 
-- 
2.34.1


