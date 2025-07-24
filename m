Return-Path: <netdev+bounces-209722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4D7B1094F
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4873BD65E
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF90278154;
	Thu, 24 Jul 2025 11:35:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526A1339A4;
	Thu, 24 Jul 2025 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356910; cv=none; b=Z5W5ZW0/a3OQQQsoHF4cfEGn+4RKpyRH0sKL7xAJk1Fr+Mx76lXTIi7jrJ70wFt9VPlL737aciyFnh8nRR2AoHsDKMxdEMfBiHUw5ERNdjN5coh3dakzbtXk+B4Q2Q0kQMU9A+VTYekhno1x2VEHROz4Ydv0PtcLxVHbqff4ZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356910; c=relaxed/simple;
	bh=s9edkJMmo2+O5omNpaFOEJGj0jH3yQhnGKRUh1LPk1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MseOMRi7fvvacbDH2Jho7blT/gnpFF0Wxe/ZIEAixnE8ek2k+c2aOdHAQ1DXB+B6taW2PdXCtvCF4qFKOCVrkFW0PtUqI86IOFlQAfjffdSpwz0eE5lEz4bnvCNbxmWHawxHa60pvzV1JvtLJPFsASvz9bds+JWgGttvVdeVoWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bnpkw4Nvwz1R8lP;
	Thu, 24 Jul 2025 19:32:24 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 960791A0188;
	Thu, 24 Jul 2025 19:35:05 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Jul
 2025 19:35:04 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ipv6: mcast: Add ip6_mc_find_idev() helper
Date: Thu, 24 Jul 2025 19:56:31 +0800
Message-ID: <20250724115631.1522458-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

__ipv6_sock_mc_join() has the same code as ip6_mc_find_dev() to find dev,
extract this into ip6_mc_find_dev() and add ip6_mc_find_idev() to reduce
code duplication and improve readability.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/mcast.c | 76 +++++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 36ca27496b3c..3fdff47c7b84 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -169,6 +169,30 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 	return iv > 0 ? iv : 1;
 }
 
+static struct net_device *ip6_mc_find_dev(struct net *net,
+					  const struct in6_addr *group,
+					  int ifindex)
+{
+	struct net_device *dev = NULL;
+
+	if (ifindex == 0) {
+		struct rt6_info *rt;
+
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
@@ -198,21 +222,7 @@ static int __ipv6_sock_mc_join(struct sock *sk, int ifindex,
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
@@ -302,32 +312,18 @@ int ipv6_sock_mc_drop(struct sock *sk, int ifindex, const struct in6_addr *addr)
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
@@ -374,7 +370,7 @@ int ip6_mc_source(int add, int omode, struct sock *sk,
 	if (!ipv6_addr_is_multicast(group))
 		return -EINVAL;
 
-	idev = ip6_mc_find_dev(net, group, pgsr->gsr_interface);
+	idev = ip6_mc_find_idev(net, group, pgsr->gsr_interface);
 	if (!idev)
 		return -ENODEV;
 
@@ -509,7 +505,7 @@ int ip6_mc_msfilter(struct sock *sk, struct group_filter *gsf,
 	    gsf->gf_fmode != MCAST_EXCLUDE)
 		return -EINVAL;
 
-	idev = ip6_mc_find_dev(net, group, gsf->gf_interface);
+	idev = ip6_mc_find_idev(net, group, gsf->gf_interface);
 	if (!idev)
 		return -ENODEV;
 
-- 
2.34.1


