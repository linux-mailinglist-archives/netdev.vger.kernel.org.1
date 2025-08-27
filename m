Return-Path: <netdev+bounces-217134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825D3B378A1
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 05:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75E81B64A7E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 03:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CABE2192E3;
	Wed, 27 Aug 2025 03:39:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59880366;
	Wed, 27 Aug 2025 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756265999; cv=none; b=jzgtWnOYzK3v6CVbfKxueCQbELYem11sVTwjuEg63Ic0+ci9QhSWEnT2FJV2MRrdGGecILr9DDNzAFJnkXnNOBCf1nhCllOPVAoxc7oWCvMDM28xaj8wznlH06f2oLQREF3u75c7xKg7PjUT0pafLGcsTjWqfJSexPmR60ldKuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756265999; c=relaxed/simple;
	bh=kIZz56o+BRvkcYy+7q+hWQW13ZtVMi2D9iQFL5rmnag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kQsc2I4DpXRD9cOS8B3+lEyghn5V1yow8ey11mylYe+W/t+rNMjH6Fa/4nXBukpttcTOaMVDs+zHA8Qf2LxRcDHHQuDBvFv2WOehJKaW74khWAo/qgbpjMJYn4Lf7h7UiN7xfyH+n9Zk8U7uWBrZRaDI/3/ZqxO6eOdkBKzvg1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cBVZV0Trmz1R95m;
	Wed, 27 Aug 2025 11:36:50 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 318231A016C;
	Wed, 27 Aug 2025 11:39:46 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 27 Aug
 2025 11:39:45 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ipv6: sit: Add ipip6_tunnel_dst_find() for cleanup
Date: Wed, 27 Aug 2025 12:00:27 +0800
Message-ID: <20250827040027.1013335-1-yuehaibing@huawei.com>
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

Extract the dst lookup logic from ipip6_tunnel_xmit() into new helper
ipip6_tunnel_dst_find() to reduce code duplication and enhance readability.

No functional change intended.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/sit.c | 93 +++++++++++++++++++++++---------------------------
 1 file changed, 43 insertions(+), 50 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 12496ba1b7d4..bcd261ff985b 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -848,6 +848,47 @@ static inline __be32 try_6rd(struct ip_tunnel *tunnel,
 	return dst;
 }
 
+static bool ipip6_tunnel_dst_find(struct sk_buff *skb, __be32 *dst,
+				  bool is_isatap)
+{
+	const struct ipv6hdr *iph6 = ipv6_hdr(skb);
+	struct neighbour *neigh = NULL;
+	const struct in6_addr *addr6;
+	bool found = false;
+	int addr_type;
+
+	if (skb_dst(skb))
+		neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
+
+	if (!neigh) {
+		net_dbg_ratelimited("nexthop == NULL\n");
+		return found;
+	}
+
+	addr6 = (const struct in6_addr *)&neigh->primary_key;
+	addr_type = ipv6_addr_type(addr6);
+
+	if (is_isatap) {
+		if ((addr_type & IPV6_ADDR_UNICAST) &&
+		    ipv6_addr_is_isatap(addr6)) {
+			*dst = addr6->s6_addr32[3];
+			found = true;
+		}
+	} else {
+		if (addr_type == IPV6_ADDR_ANY) {
+			addr6 = &ipv6_hdr(skb)->daddr;
+			addr_type = ipv6_addr_type(addr6);
+		}
+
+		if ((addr_type & IPV6_ADDR_COMPATv4) != 0) {
+			*dst = addr6->s6_addr32[3];
+			found = true;
+		}
+	}
+	neigh_release(neigh);
+	return found;
+}
+
 /*
  *	This function assumes it is being called from dev_queue_xmit()
  *	and that skb is filled properly by that function.
@@ -867,8 +908,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	__be32 dst = tiph->daddr;
 	struct flowi4 fl4;
 	int    mtu;
-	const struct in6_addr *addr6;
-	int addr_type;
 	u8 ttl;
 	u8 protocol = IPPROTO_IPV6;
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
@@ -878,28 +917,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 
 	/* ISATAP (RFC4214) - must come before 6to4 */
 	if (dev->priv_flags & IFF_ISATAP) {
-		struct neighbour *neigh = NULL;
-		bool do_tx_error = false;
-
-		if (skb_dst(skb))
-			neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
-
-		if (!neigh) {
-			net_dbg_ratelimited("nexthop == NULL\n");
-			goto tx_error;
-		}
-
-		addr6 = (const struct in6_addr *)&neigh->primary_key;
-		addr_type = ipv6_addr_type(addr6);
-
-		if ((addr_type & IPV6_ADDR_UNICAST) &&
-		     ipv6_addr_is_isatap(addr6))
-			dst = addr6->s6_addr32[3];
-		else
-			do_tx_error = true;
-
-		neigh_release(neigh);
-		if (do_tx_error)
+		if (!ipip6_tunnel_dst_find(skb, &dst, true))
 			goto tx_error;
 	}
 
@@ -907,32 +925,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 		dst = try_6rd(tunnel, &iph6->daddr);
 
 	if (!dst) {
-		struct neighbour *neigh = NULL;
-		bool do_tx_error = false;
-
-		if (skb_dst(skb))
-			neigh = dst_neigh_lookup(skb_dst(skb), &iph6->daddr);
-
-		if (!neigh) {
-			net_dbg_ratelimited("nexthop == NULL\n");
-			goto tx_error;
-		}
-
-		addr6 = (const struct in6_addr *)&neigh->primary_key;
-		addr_type = ipv6_addr_type(addr6);
-
-		if (addr_type == IPV6_ADDR_ANY) {
-			addr6 = &ipv6_hdr(skb)->daddr;
-			addr_type = ipv6_addr_type(addr6);
-		}
-
-		if ((addr_type & IPV6_ADDR_COMPATv4) != 0)
-			dst = addr6->s6_addr32[3];
-		else
-			do_tx_error = true;
-
-		neigh_release(neigh);
-		if (do_tx_error)
+		if (!ipip6_tunnel_dst_find(skb, &dst, false))
 			goto tx_error;
 	}
 
-- 
2.34.1


