Return-Path: <netdev+bounces-202747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A8AAEED20
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 05:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31022189E913
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0020A19FA8D;
	Tue,  1 Jul 2025 03:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566729D0D;
	Tue,  1 Jul 2025 03:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751342164; cv=none; b=rTV53tonKmcBYTr9xUR1ArxAcZdRnoQr4tjdpq5CRctEviaJzOxo+pbxznMRXql2r09eEl6R9SHoulC6IgDZfUcPFiSHgW98PLU6dO43Q1tmDY050zMJ3pZjkocNuIBaeQmo88NBUm0Xg4tsYrtr3TP+2P6TM8SBMZRWamUc51k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751342164; c=relaxed/simple;
	bh=gKNJk92w5X4j3ebhftgRkKzwOsKJ28U4bPROq6sHeVY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Il3jNrWeHFDWLbsBl6CVgTZPt1wm1Um3P/Rs5xGh7DYgkQLwbIlKAJl/GEVoWxZ3DgXINNvy75LMmUKlH05Zj9CKlcQZ/oaUE5HdnYlJP12R/TAbnVVY4DBvkSE6bjkHG7vZrNc+PbZvDD+JZfVNymsn30WRVyGfVdbPM4sSz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bWTdw3tsPz1d1rh;
	Tue,  1 Jul 2025 11:53:24 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 888981800EC;
	Tue,  1 Jul 2025 11:55:52 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Jul
 2025 11:55:51 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ipv6: Cleanup fib6_drop_pcpu_from()
Date: Tue, 1 Jul 2025 12:12:35 +0800
Message-ID: <20250701041235.1333687-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Since commit 0e2338749192 ("ipv6: fix races in ip6_dst_destroy()"), 
'table' is unused in __fib6_drop_pcpu_from(), no need pass it from
fib6_drop_pcpu_from().

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/ip6_fib.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 93578b2ec35f..7272d7e0fc36 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -963,8 +963,7 @@ static struct fib6_node *fib6_add_1(struct net *net,
 }
 
 static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
-				  const struct fib6_info *match,
-				  const struct fib6_table *table)
+				  const struct fib6_info *match)
 {
 	int cpu;
 
@@ -999,21 +998,15 @@ static void __fib6_drop_pcpu_from(struct fib6_nh *fib6_nh,
 	rcu_read_unlock();
 }
 
-struct fib6_nh_pcpu_arg {
-	struct fib6_info	*from;
-	const struct fib6_table *table;
-};
-
 static int fib6_nh_drop_pcpu_from(struct fib6_nh *nh, void *_arg)
 {
-	struct fib6_nh_pcpu_arg *arg = _arg;
+	struct fib6_info *arg = _arg;
 
-	__fib6_drop_pcpu_from(nh, arg->from, arg->table);
+	__fib6_drop_pcpu_from(nh, arg);
 	return 0;
 }
 
-static void fib6_drop_pcpu_from(struct fib6_info *f6i,
-				const struct fib6_table *table)
+static void fib6_drop_pcpu_from(struct fib6_info *f6i)
 {
 	/* Make sure rt6_make_pcpu_route() wont add other percpu routes
 	 * while we are cleaning them here.
@@ -1022,19 +1015,14 @@ static void fib6_drop_pcpu_from(struct fib6_info *f6i,
 	mb(); /* paired with the cmpxchg() in rt6_make_pcpu_route() */
 
 	if (f6i->nh) {
-		struct fib6_nh_pcpu_arg arg = {
-			.from = f6i,
-			.table = table
-		};
-
 		rcu_read_lock();
-		nexthop_for_each_fib6_nh(f6i->nh, fib6_nh_drop_pcpu_from, &arg);
+		nexthop_for_each_fib6_nh(f6i->nh, fib6_nh_drop_pcpu_from, f6i);
 		rcu_read_unlock();
 	} else {
 		struct fib6_nh *fib6_nh;
 
 		fib6_nh = f6i->fib6_nh;
-		__fib6_drop_pcpu_from(fib6_nh, f6i, table);
+		__fib6_drop_pcpu_from(fib6_nh, f6i);
 	}
 }
 
@@ -1045,7 +1033,7 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 
 	/* Flush all cached dst in exception table */
 	rt6_flush_exceptions(rt);
-	fib6_drop_pcpu_from(rt, table);
+	fib6_drop_pcpu_from(rt);
 
 	if (rt->nh) {
 		spin_lock(&rt->nh->lock);
-- 
2.34.1


