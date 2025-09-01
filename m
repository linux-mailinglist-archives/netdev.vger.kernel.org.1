Return-Path: <netdev+bounces-218724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0A1B3E184
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 13:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5145C1A81836
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07E31355E;
	Mon,  1 Sep 2025 11:28:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D425F7A5;
	Mon,  1 Sep 2025 11:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726084; cv=none; b=Cz44P8zH2018lMwzT1F2k6lkTfz9MvGykN6jj4mLPISw755G9XBzVor6BqWc+s1qjW81q0NYH+jefl+DFNZuijG5yOI55EY2Fwtudrm8LLktNZE2szCI1nlp0v/nsj128odFrzeC7kM/A9ohRD85UyjRkizug24CAs1fayerdSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726084; c=relaxed/simple;
	bh=OmTetXE5ocst2keGv5Wx00aNa3FJGSFgN7qZOOKvQvY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WMvVYq7LLNXJf6oaTilZ6yzpFlGQo6QS+I0OIQUoHuosfl2QySU9Fi9yWKX9vLtMj75qHuf5jtXnWVts83v8LbSV+wyd7/udCJ2BCGTbeEwp5SH3fUqyNt62LQfVtE/5EXCjYGtY6h2M4nn86Nx4l/r4F+kAVCx0RoYoQGOnTes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cFmjQ6X8qz13NKb;
	Mon,  1 Sep 2025 19:24:10 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C2C3A1402CD;
	Mon,  1 Sep 2025 19:27:59 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Sep
 2025 19:27:58 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <aleksander.lobakin@intel.com>
Subject: [PATCH v3 net-next] ipv6: sit: Add ipip6_tunnel_dst_find() for cleanup
Date: Mon, 1 Sep 2025 19:48:57 +0800
Message-ID: <20250901114857.1968513-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Extract the dst lookup logic from ipip6_tunnel_xmit() into new helper
ipip6_tunnel_dst_find() to reduce code duplication and enhance readability.
No functional change intended.

On a x86_64, with allmodconfig object size is also reduced:

./scripts/bloat-o-meter net/ipv6/sit.o net/ipv6/sit-new.o
add/remove: 5/3 grow/shrink: 3/4 up/down: 1841/-2275 (-434)
Function                                     old     new   delta
ipip6_tunnel_dst_find                          -    1697   +1697
__pfx_ipip6_tunnel_dst_find                    -      64     +64
__UNIQUE_ID_modinfo2094                        -      43     +43
ipip6_tunnel_xmit.isra.cold                   79      88      +9
__UNIQUE_ID_modinfo2096                       12      20      +8
__UNIQUE_ID___addressable_init_module2092       -       8      +8
__UNIQUE_ID___addressable_cleanup_module2093       -       8      +8
__func__                                      55      59      +4
__UNIQUE_ID_modinfo2097                       20      18      -2
__UNIQUE_ID___addressable_init_module2093       8       -      -8
__UNIQUE_ID___addressable_cleanup_module2094       8       -      -8
__UNIQUE_ID_modinfo2098                       18       -     -18
__UNIQUE_ID_modinfo2095                       43      12     -31
descriptor                                   112      56     -56
ipip6_tunnel_xmit.isra                      9910    7758   -2152
Total: Before=72537, After=72103, chg -0.60%

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v3: flatten if conditions of ipip6_tunnel_dst_find()
v2: add newlines before return in ipip6_tunnel_dst_find()
    add bloat-o-meter info in commit log
---
 net/ipv6/sit.c | 104 +++++++++++++++++++++++--------------------------
 1 file changed, 48 insertions(+), 56 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 12496ba1b7d4..cf37ad9686e6 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -848,6 +848,49 @@ static inline __be32 try_6rd(struct ip_tunnel *tunnel,
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
+		return false;
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
+
+	neigh_release(neigh);
+
+	return found;
+}
+
 /*
  *	This function assumes it is being called from dev_queue_xmit()
  *	and that skb is filled properly by that function.
@@ -867,8 +910,6 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 	__be32 dst = tiph->daddr;
 	struct flowi4 fl4;
 	int    mtu;
-	const struct in6_addr *addr6;
-	int addr_type;
 	u8 ttl;
 	u8 protocol = IPPROTO_IPV6;
 	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
@@ -877,64 +918,15 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 		tos = ipv6_get_dsfield(iph6);
 
 	/* ISATAP (RFC4214) - must come before 6to4 */
-	if (dev->priv_flags & IFF_ISATAP) {
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
-			goto tx_error;
-	}
+	if ((dev->priv_flags & IFF_ISATAP) &&
+	    !ipip6_tunnel_dst_find(skb, &dst, true))
+		goto tx_error;
 
 	if (!dst)
 		dst = try_6rd(tunnel, &iph6->daddr);
 
-	if (!dst) {
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
-			goto tx_error;
-	}
+	if (!dst && !ipip6_tunnel_dst_find(skb, &dst, false))
+		goto tx_error;
 
 	flowi4_init_output(&fl4, tunnel->parms.link, tunnel->fwmark,
 			   tos & INET_DSCP_MASK, RT_SCOPE_UNIVERSE,
-- 
2.34.1


