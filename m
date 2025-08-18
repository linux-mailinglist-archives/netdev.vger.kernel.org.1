Return-Path: <netdev+bounces-214496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0923B29E58
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C684E58F8
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2E286897;
	Mon, 18 Aug 2025 09:48:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FD819D08F;
	Mon, 18 Aug 2025 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510515; cv=none; b=Vh4kzzxZnxCu5MEaczpqr9PEMr6OrFbr+s6clIgkdC6mltC/VChLErA0wpHeRQnl2uCOUSJlQOWwQSskX0M6xQgDoi84cVPGU6Q2RLhmopWV25GD8D+PPg4ViVT1WwxdvyUAiRDGFQkk55GtQLOub7SXQc6COiBdMCuU7kNrdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510515; c=relaxed/simple;
	bh=2cebde2kfuXyzBvXebgHT65nyp1L5Usz3QUTVaXigEg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qRtUoAmKMMOY9QDRjoqBeNsB0B9fbEYr9rwl1Ecz1mAt/OwZd663hukfR1mIikuD3jJBBPr515gHOOkq3MA4TMDxeutSn+2lSKgxTibF3/pqCVM3zB+a1RkeylKGB1F9tMTk9gusqw4+L+vDOXNKhc7/4lY120PgOzzH0UmMO90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4c57Gh3LqYz3TqZL;
	Mon, 18 Aug 2025 17:49:32 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 80585180042;
	Mon, 18 Aug 2025 17:48:27 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 17:48:26 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH RESEND net-next] ipv6: mcast: Add ip6_mc_find_idev() helper
Date: Mon, 18 Aug 2025 18:10:51 +0800
Message-ID: <20250818101051.892443-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

__ipv6_sock_mc_join() has the same code as ip6_mc_find_dev() to find dev,
extract this into ip6_mc_find_dev() and add ip6_mc_find_idev() to reduce
code duplication and improve readability.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/mcast.c | 76 ++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 41 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 36ca27496b3c..75430ad55c3d 100644
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
@@ -302,32 +310,18 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
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
-	struct inet6_dev *idev;
-
-	if (ifindex == 0) {
-		struct rt6_info *rt;
+	struct inet6_dev *idev = NULL;
+	struct net_device *dev;
 
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
+	dev = ip6_mc_find_dev(net, group, ifindex);
+	if (dev) {
+		idev = in6_dev_get(dev);
+		dev_put(dev);
 	}
-	if (!dev)
-		return NULL;
-
-	idev = in6_dev_get(dev);
-	dev_put(dev);
 
 	return idev;
 }
@@ -374,7 +368,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	if (!ipv6_addr_is_multicast(group))
 		return -EINVAL;
 
-	idev = ip6_mc_find_dev(net, group, pgsr->gsr_interface);
+	idev = ip6_mc_find_idev(net, group, pgsr->gsr_interface);
 	if (!idev)
 		return -ENODEV;
 
@@ -509,7 +503,7 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 	    gsf->gf_fmode != MCAST_EXCLUDE)
 		return -EINVAL;
 
-	idev = ip6_mc_find_dev(net, group, gsf->gf_interface);
+	idev = ip6_mc_find_idev(net, group, gsf->gf_interface);
 	if (!idev)
 		return -ENODEV;
 
-- 
2.34.1


