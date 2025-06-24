Return-Path: <netdev+bounces-200642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D07DAE66D8
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A69A5A0A0D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3632C326E;
	Tue, 24 Jun 2025 13:43:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D12C3271;
	Tue, 24 Jun 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772581; cv=none; b=Lcaag76+nVkwBoKBEyTB9pLvQXdL2/ZrlBDemx/dXAEoXutpidFivVriNCWb+QWgpOALKS5UrSUJETDuQi7eOcuRwfyh7iyXGdiR7uORf7pWsYxkRYpcdKzrmzfYEogjTlI+/M67WN3dpeeSBQxFLK+BX5RUw+HXvrCSQoA+ypE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772581; c=relaxed/simple;
	bh=s1V/WtV6NCwB8AJMF9B3WuzHu1P6SSh8cYjjoXF/YJ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yy5RUWa+XFkyTnLuHofkOckIMSKBBIyTTWcl1aYfsERj0dKMhTp3DKa/bpSPjyJFTuNKeWNhv9EujMMBpfs7Su/FyctzMoAJYs//ruQYtbDoBYWoNUd6DSIQfiZjXZHJ5X4OEwyXOSxVUHK9+HwEFamg6wHCbksuaf/PXRlWih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bRR0X0SvGz1W3TM;
	Tue, 24 Jun 2025 21:40:28 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 910F81A0188;
	Tue, 24 Jun 2025 21:42:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Jun
 2025 21:42:54 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] net: Remove unnecessary NULL check for lwtunnel_fill_encap()
Date: Tue, 24 Jun 2025 22:00:15 +0800
Message-ID: <20250624140015.3929241-1-yuehaibing@huawei.com>
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

lwtunnel_fill_encap() has NULL check and return 0, so no need
to check before call it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv4/fib_semantics.c | 3 +--
 net/ipv4/nexthop.c       | 3 +--
 net/ipv4/route.c         | 3 +--
 net/ipv6/route.c         | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 2b60e0b010e1..475ffcbf4927 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1632,8 +1632,7 @@ int fib_nexthop_info(struct sk_buff *skb, const struct fib_nh_common *nhc,
 	    nla_put_u32(skb, RTA_OIF, nhc->nhc_dev->ifindex))
 		goto nla_put_failure;
 
-	if (nhc->nhc_lwtstate &&
-	    lwtunnel_fill_encap(skb, nhc->nhc_lwtstate,
+	if (lwtunnel_fill_encap(skb, nhc->nhc_lwtstate,
 				RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
 		goto nla_put_failure;
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 4397e89d3123..e808801ab9b8 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -985,8 +985,7 @@ static int nh_fill_node(struct sk_buff *skb, struct nexthop *nh,
 		break;
 	}
 
-	if (nhi->fib_nhc.nhc_lwtstate &&
-	    lwtunnel_fill_encap(skb, nhi->fib_nhc.nhc_lwtstate,
+	if (lwtunnel_fill_encap(skb, nhi->fib_nhc.nhc_lwtstate,
 				NHA_ENCAP, NHA_ENCAP_TYPE) < 0)
 		goto nla_put_failure;
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 3ddf6bf40357..1dc18decb4a8 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2977,8 +2977,7 @@ static int rt_fill_info(struct net *net, __be32 dst, __be32 src,
 	if (rt->dst.dev &&
 	    nla_put_u32(skb, RTA_OIF, rt->dst.dev->ifindex))
 		goto nla_put_failure;
-	if (rt->dst.lwtstate &&
-	    lwtunnel_fill_encap(skb, rt->dst.lwtstate, RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
+	if (lwtunnel_fill_encap(skb, rt->dst.lwtstate, RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
 		goto nla_put_failure;
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	if (rt->dst.tclassid &&
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index df0caffefb38..477e3d4dab8b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5852,8 +5852,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 		if (dst->dev && nla_put_u32(skb, RTA_OIF, dst->dev->ifindex))
 			goto nla_put_failure;
 
-		if (dst->lwtstate &&
-		    lwtunnel_fill_encap(skb, dst->lwtstate, RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
+		if (lwtunnel_fill_encap(skb, dst->lwtstate, RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
 			goto nla_put_failure;
 	} else if (rt->fib6_nsiblings) {
 		struct fib6_info *sibling;
-- 
2.34.1


