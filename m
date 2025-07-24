Return-Path: <netdev+bounces-209752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958B8B10B37
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460193AC80F
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B02D663D;
	Thu, 24 Jul 2025 13:19:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34912D5412
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753363154; cv=none; b=ceetpmHbJ5rQbPL9NmZkrmZ26T8w+4jeqJuBj21gf2eOOx73CVmDY+FcYVbSdqGgAsPDdrnXs5Lz5WXs0xZjgq8M95U4kZjDDLTjZwpG+trxBAPfXk7hM+kxfGWkSd5cFV2H0RMGLWu0rXvxZwkEd36tJ61XTl10tONkpgtyA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753363154; c=relaxed/simple;
	bh=9MUdR9V3xr349HTF9IjCMPhpm7lNfDedz5oD58qQp5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIrklgWSLkoHUv3ZlGxbsjYXxTzpEvL6jKQghxGNBLgAyiIbQPJOQBt5YxN0sTsgbmRMNlzqjASOMmh+MX4MY4U15sV+Kw5Yg94OIyZileK8ytb81rEWbfq1TZ+kFinsvh2PwZ35cpygQQyG1OpakStpiG2MW06nKXXEWPXgyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2001:67c:370:1998:30cb:b625:4f9:61b4] (helo=alea.q.nox.tf)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1uevqi-00000002yTI-2w9l;
	Thu, 24 Jul 2025 15:19:05 +0200
Received: from equinox by alea.q.nox.tf with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1uevqM-000000008NG-127O;
	Thu, 24 Jul 2025 15:18:42 +0200
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [PATCH net-next 2/4] net/ipv6: create ipv6_fl_get_saddr
Date: Thu, 24 Jul 2025 15:18:23 +0200
Message-ID: <20250724131828.32155-3-equinox@diac24.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724131828.32155-1-equinox@diac24.net>
References: <20250724131828.32155-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds passing the relevant flow information as well as selected
nexthop into the source address selection code, to allow the RFC6724
rule 5.5 code to look at its details.

Signed-off-by: David Lamparter <equinox@diac24.net>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Patrick Rohr <prohr@google.com>
---
 include/net/addrconf.h |  4 ++++
 net/ipv6/addrconf.c    | 45 +++++++++++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 9e5e95988b9e..952395c198f9 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -141,6 +141,10 @@ struct inet6_ifaddr *ipv6_get_ifaddr(struct net *net,
 int ipv6_dev_get_saddr(struct net *net, const struct net_device *dev,
 		       const struct in6_addr *daddr, unsigned int srcprefs,
 		       struct in6_addr *saddr);
+int ipv6_fl_get_saddr(struct net *net, const struct dst_entry *dst,
+		      const struct net_device *dst_dev,
+		      const struct sock *sk, unsigned int srcprefs,
+		      struct flowi6 *fl6);
 int ipv6_get_lladdr(struct net_device *dev, struct in6_addr *addr,
 		    u32 banned_flags);
 bool inet_rcv_saddr_equal(const struct sock *sk, const struct sock *sk2,
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 4f1d7d110302..8ff3aad71466 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1528,7 +1528,9 @@ struct ipv6_saddr_score {
 };
 
 struct ipv6_saddr_dst {
-	const struct in6_addr *addr;
+	const struct flowi6 *fl6;
+	const struct dst_entry *dst;
+	const struct sock *sk;
 	int ifindex;
 	int scope;
 	int label;
@@ -1605,7 +1607,7 @@ static int ipv6_get_saddr_eval(struct net *net,
 		break;
 	case IPV6_SADDR_RULE_LOCAL:
 		/* Rule 1: Prefer same address */
-		ret = ipv6_addr_equal(&score->ifa->addr, dst->addr);
+		ret = ipv6_addr_equal(&score->ifa->addr, &dst->fl6->daddr);
 		break;
 	case IPV6_SADDR_RULE_SCOPE:
 		/* Rule 2: Prefer appropriate scope
@@ -1683,11 +1685,11 @@ static int ipv6_get_saddr_eval(struct net *net,
 		 *	    non-ORCHID vs non-ORCHID
 		 */
 		ret = !(ipv6_addr_orchid(&score->ifa->addr) ^
-			ipv6_addr_orchid(dst->addr));
+			ipv6_addr_orchid(&dst->fl6->daddr));
 		break;
 	case IPV6_SADDR_RULE_PREFIX:
 		/* Rule 8: Use longest matching prefix */
-		ret = ipv6_addr_diff(&score->ifa->addr, dst->addr);
+		ret = ipv6_addr_diff(&score->ifa->addr, &dst->fl6->daddr);
 		if (ret > score->ifa->prefix_len)
 			ret = score->ifa->prefix_len;
 		score->matchlen = ret;
@@ -1805,9 +1807,10 @@ static int ipv6_get_saddr_master(struct net *net,
 	return hiscore_idx;
 }
 
-int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
-		       const struct in6_addr *daddr, unsigned int prefs,
-		       struct in6_addr *saddr)
+int ipv6_fl_get_saddr(struct net *net, const struct dst_entry *dst_entry,
+		      const struct net_device *dst_dev,
+		      const struct sock *sk, unsigned int prefs,
+		      struct flowi6 *fl6)
 {
 	struct ipv6_saddr_score scores[2], *hiscore;
 	struct ipv6_saddr_dst dst;
@@ -1818,11 +1821,13 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 	int hiscore_idx = 0;
 	int ret = 0;
 
-	dst_type = __ipv6_addr_type(daddr);
-	dst.addr = daddr;
+	dst_type = __ipv6_addr_type(&fl6->daddr);
+	dst.fl6 = fl6;
+	dst.sk = sk;
+	dst.dst = dst_entry;
 	dst.ifindex = dst_dev ? dst_dev->ifindex : 0;
 	dst.scope = __ipv6_addr_src_scope(dst_type);
-	dst.label = ipv6_addr_label(net, daddr, dst_type, dst.ifindex);
+	dst.label = ipv6_addr_label(net, &fl6->daddr, dst_type, dst.ifindex);
 	dst.prefs = prefs;
 
 	scores[hiscore_idx].rule = -1;
@@ -1897,11 +1902,29 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 	if (!hiscore->ifa)
 		ret = -EADDRNOTAVAIL;
 	else
-		*saddr = hiscore->ifa->addr;
+		fl6->saddr = hiscore->ifa->addr;
 
 	rcu_read_unlock();
 	return ret;
 }
+EXPORT_SYMBOL(ipv6_fl_get_saddr);
+
+int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
+		       const struct in6_addr *daddr, unsigned int prefs,
+		       struct in6_addr *saddr)
+{
+	struct flowi6 fl6;
+	int ret;
+
+	memset(&fl6, 0, sizeof(fl6));
+	fl6.daddr = *daddr;
+
+	ret = ipv6_fl_get_saddr(net, NULL, dst_dev, NULL, prefs, &fl6);
+	if (!ret)
+		*saddr = fl6.saddr;
+
+	return ret;
+}
 EXPORT_SYMBOL(ipv6_dev_get_saddr);
 
 static int __ipv6_get_lladdr(struct inet6_dev *idev, struct in6_addr *addr,
-- 
2.47.2


