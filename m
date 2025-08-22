Return-Path: <netdev+bounces-215922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5A6B30EC0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4381CE4E21
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0345A2E3AE2;
	Fri, 22 Aug 2025 06:21:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E02E3AE6;
	Fri, 22 Aug 2025 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843703; cv=none; b=EaD155DECtiOL+/VI/mgDk23NWJR+x0JUfsIvVuxrP6DnuFruQm71AjzZIcqJCJ1N0VbAQwoDlbSSULyOCLt6GEQ8DUlpTixOBovjjhjUHl2KC6RqikBPcc8tO+bYvBx0hSXOvo6f38UyzdHCc7WcKT+4tJAr1WFo1nD6jQoZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843703; c=relaxed/simple;
	bh=0Otq+2/vcanDsGkeffe7L/JarqW63r/YNxF07A5f51s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q83ykligOjKnQ6V8J7mxIsCUxL330XiRsZy5HsHEyuRwqLqYyABCysgsf68wDEQqYP8wcnW3vuHinQkWz4egHCIgMMKU5k/UDtDfvq0vMx+2p3uWoP7cE4IJJkXILilrTLphx8wGixPrOThi9WVvckiV4MH2Nt8xK9HICEuA+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c7VPg1sxbz2Dc7L;
	Fri, 22 Aug 2025 14:18:47 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 44D181A0171;
	Fri, 22 Aug 2025 14:21:38 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 22 Aug
 2025 14:21:37 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <dawid.osuchowski@linux.intel.com>
Subject: [PATCH v2 net-next] ipv6: mcast: Add ip6_mc_find_idev() helper
Date: Fri, 22 Aug 2025 14:40:51 +0800
Message-ID: <20250822064051.2991480-1-yuehaibing@huawei.com>
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

Extract the same code logic from __ipv6_sock_mc_join() and
ip6_mc_find_dev(), also add new helper ip6_mc_find_idev() to
reduce redundancy and enhance readability.

No functional changes intended.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
v2: remove unneeded changes in ip6_mc_find_idev()
    refine commit log
---
 net/ipv6/mcast.c | 67 ++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 36ca27496b3c..55c49dc14b1b 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -169,6 +169,29 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 	return iv > 0 ? iv : 1;
 }
 
+static struct net_device *ip6_mc_find_dev(struct net *net,
+					  const struct in6_addr *group,
+					  int ifindex)
+{
+	struct net_device *dev = NULL;
+	struct rt6_info *rt;
+
+	if (ifindex == 0) {
+		rcu_read_lock();
+		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
+		if (rt) {
+			dev = dst_dev(&rt->dst);
+			dev_hold(dev);
+			ip6_rt_put(rt);
+		}
+		rcu_read_unlock();
+	} else {
+		dev = dev_get_by_index(net, ifindex);
+	}
+
+	return dev;
+}
+
 /*
  *	socket join on multicast group
  */
@@ -191,28 +214,13 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
 	}
 
 	mc_lst = sock_kmalloc(sk, sizeof(struct ipv6_mc_socklist), GFP_KERNEL);
-
 	if (!mc_lst)
 		return -ENOMEM;
 
 	mc_lst->next = NULL;
 	mc_lst->addr = *addr;
 
-	if (ifindex == 0) {
-		struct rt6_info *rt;
-
-		rcu_read_lock();
-		rt = rt6_lookup(net, addr, NULL, 0, NULL, 0);
-		if (rt) {
-			dev = dst_dev(&rt->dst);
-			dev_hold(dev);
-			ip6_rt_put(rt);
-		}
-		rcu_read_unlock();
-	} else {
-		dev = dev_get_by_index(net, ifindex);
-	}
-
+	dev = ip6_mc_find_dev(net, addr, ifindex);
 	if (!dev) {
 		sock_kfree_s(sk, mc_lst, sizeof(*mc_lst));
 		return -ENODEV;
@@ -302,27 +310,14 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
 }
 EXPORT_SYMBOL(ipv6_sock_mc_drop);
 
-static struct inet6_dev *ip6_mc_find_dev(struct net *net,
-					 const struct in6_addr *group,
-					 int ifindex)
+static struct inet6_dev *ip6_mc_find_idev(struct net *net,
+					  const struct in6_addr *group,
+					  int ifindex)
 {
-	struct net_device *dev = NULL;
+	struct net_device *dev;
 	struct inet6_dev *idev;
 
-	if (ifindex == 0) {
-		struct rt6_info *rt;
-
-		rcu_read_lock();
-		rt = rt6_lookup(net, group, NULL, 0, NULL, 0);
-		if (rt) {
-			dev = dst_dev(&rt->dst);
-			dev_hold(dev);
-			ip6_rt_put(rt);
-		}
-		rcu_read_unlock();
-	} else {
-		dev = dev_get_by_index(net, ifindex);
-	}
+	dev = ip6_mc_find_dev(net, group, ifindex);
 	if (!dev)
 		return NULL;
 
@@ -374,7 +369,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	if (!ipv6_addr_is_multicast(group))
 		return -EINVAL;
 
-	idev = ip6_mc_find_dev(net, group, pgsr->gsr_interface);
+	idev = ip6_mc_find_idev(net, group, pgsr->gsr_interface);
 	if (!idev)
 		return -ENODEV;
 
@@ -509,7 +504,7 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 	    gsf->gf_fmode != MCAST_EXCLUDE)
 		return -EINVAL;
 
-	idev = ip6_mc_find_dev(net, group, gsf->gf_interface);
+	idev = ip6_mc_find_idev(net, group, gsf->gf_interface);
 	if (!idev)
 		return -ENODEV;
 
-- 
2.34.1


