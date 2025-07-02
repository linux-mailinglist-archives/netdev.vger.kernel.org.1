Return-Path: <netdev+bounces-203281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CC5AF11D2
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481811C27025
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BB2242D9D;
	Wed,  2 Jul 2025 10:27:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBF17A2E6;
	Wed,  2 Jul 2025 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751452038; cv=none; b=fkKgu4suyJxdyEQRk50dTqLJtKRmK23DuiEpsJcZUYP4FIaoNrVSsYcGoEcOG2WAnwufxgccETzfvyGfiogCAFvY5Fz75XUa9TYiVpAe3wi/qCDAV01Q5WJlxSLAfslHo4D8wKlUFG3R/H1qXMGXcQ25HUzzWUNt+mQzZCn6St8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751452038; c=relaxed/simple;
	bh=VwCvQamL3OLboOtaKpp5/6Nma/BoEDweaCfWoWZixfc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rRlbgpcOBZdavtmlREtiunbg6SObVUwnUK6FkDErNInBYBI/exjQ0ZUmlrfX+Kg/issklUMu0T4LtZoM/WTGEfJWVk5y/3evaWM4HbIrXyUBnOXE2YN7vUkDJ0UUz/sJECanM3343325aDg7LOkvz89U8JEPanX8JxSiL69yrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bXGHp59Cxz2BdVx;
	Wed,  2 Jul 2025 18:25:26 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 99D4C180042;
	Wed,  2 Jul 2025 18:27:12 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 2 Jul
 2025 18:27:11 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: replace ADDRLABEL with dynamic debug
Date: Wed, 2 Jul 2025 18:44:17 +0800
Message-ID: <20250702104417.1526138-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500016.china.huawei.com (7.185.36.197)

ADDRLABEL only works when it was set in compilation phase. Replace it with
net_dbg_ratelimited().

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/ipv6/addrlabel.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/net/ipv6/addrlabel.c b/net/ipv6/addrlabel.c
index fb63ffbcfc64..567efd626ab4 100644
--- a/net/ipv6/addrlabel.c
+++ b/net/ipv6/addrlabel.c
@@ -20,12 +20,6 @@
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
 
-#if 0
-#define ADDRLABEL(x...) printk(x)
-#else
-#define ADDRLABEL(x...) do { ; } while (0)
-#endif
-
 /*
  * Policy Table
  */
@@ -150,8 +144,8 @@ u32 ipv6_addr_label(struct net *net,
 	label = p ? p->label : IPV6_ADDR_LABEL_DEFAULT;
 	rcu_read_unlock();
 
-	ADDRLABEL(KERN_DEBUG "%s(addr=%pI6, type=%d, ifindex=%d) => %08x\n",
-		  __func__, addr, type, ifindex, label);
+	net_dbg_ratelimited("%s(addr=%pI6, type=%d, ifindex=%d) => %08x\n", __func__, addr, type,
+			    ifindex, label);
 
 	return label;
 }
@@ -164,8 +158,8 @@ static struct ip6addrlbl_entry *ip6addrlbl_alloc(const struct in6_addr *prefix,
 	struct ip6addrlbl_entry *newp;
 	int addrtype;
 
-	ADDRLABEL(KERN_DEBUG "%s(prefix=%pI6, prefixlen=%d, ifindex=%d, label=%u)\n",
-		  __func__, prefix, prefixlen, ifindex, (unsigned int)label);
+	net_dbg_ratelimited("%s(prefix=%pI6, prefixlen=%d, ifindex=%d, label=%u)\n", __func__,
+			    prefix, prefixlen, ifindex, (unsigned int)label);
 
 	addrtype = ipv6_addr_type(prefix) & (IPV6_ADDR_MAPPED | IPV6_ADDR_COMPATv4 | IPV6_ADDR_LOOPBACK);
 
@@ -207,8 +201,7 @@ static int __ip6addrlbl_add(struct net *net, struct ip6addrlbl_entry *newp,
 	struct hlist_node *n;
 	int ret = 0;
 
-	ADDRLABEL(KERN_DEBUG "%s(newp=%p, replace=%d)\n", __func__, newp,
-		  replace);
+	net_dbg_ratelimited("%s(newp=%p, replace=%d)\n", __func__, newp, replace);
 
 	hlist_for_each_entry_safe(p, n,	&net->ipv6.ip6addrlbl_table.head, list) {
 		if (p->prefixlen == newp->prefixlen &&
@@ -247,9 +240,8 @@ static int ip6addrlbl_add(struct net *net,
 	struct ip6addrlbl_entry *newp;
 	int ret = 0;
 
-	ADDRLABEL(KERN_DEBUG "%s(prefix=%pI6, prefixlen=%d, ifindex=%d, label=%u, replace=%d)\n",
-		  __func__, prefix, prefixlen, ifindex, (unsigned int)label,
-		  replace);
+	net_dbg_ratelimited("%s(prefix=%pI6, prefixlen=%d, ifindex=%d, label=%u, replace=%d)\n",
+			    __func__, prefix, prefixlen, ifindex, (unsigned int)label, replace);
 
 	newp = ip6addrlbl_alloc(prefix, prefixlen, ifindex, label);
 	if (IS_ERR(newp))
@@ -271,8 +263,8 @@ static int __ip6addrlbl_del(struct net *net,
 	struct hlist_node *n;
 	int ret = -ESRCH;
 
-	ADDRLABEL(KERN_DEBUG "%s(prefix=%pI6, prefixlen=%d, ifindex=%d)\n",
-		  __func__, prefix, prefixlen, ifindex);
+	net_dbg_ratelimited("%s(prefix=%pI6, prefixlen=%d, ifindex=%d)\n", __func__, prefix,
+			    prefixlen, ifindex);
 
 	hlist_for_each_entry_safe(p, n, &net->ipv6.ip6addrlbl_table.head, list) {
 		if (p->prefixlen == prefixlen &&
@@ -294,8 +286,8 @@ static int ip6addrlbl_del(struct net *net,
 	struct in6_addr prefix_buf;
 	int ret;
 
-	ADDRLABEL(KERN_DEBUG "%s(prefix=%pI6, prefixlen=%d, ifindex=%d)\n",
-		  __func__, prefix, prefixlen, ifindex);
+	net_dbg_ratelimited("%s(prefix=%pI6, prefixlen=%d, ifindex=%d)\n", __func__, prefix,
+			    prefixlen, ifindex);
 
 	ipv6_addr_prefix(&prefix_buf, prefix, prefixlen);
 	spin_lock(&net->ipv6.ip6addrlbl_table.lock);
@@ -312,8 +304,6 @@ static int __net_init ip6addrlbl_net_init(struct net *net)
 	int err;
 	int i;
 
-	ADDRLABEL(KERN_DEBUG "%s\n", __func__);
-
 	spin_lock_init(&net->ipv6.ip6addrlbl_table.lock);
 	INIT_HLIST_HEAD(&net->ipv6.ip6addrlbl_table.head);
 
-- 
2.34.1


