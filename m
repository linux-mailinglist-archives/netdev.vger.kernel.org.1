Return-Path: <netdev+bounces-235503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1BC31A25
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64193B93A2
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F92F6189;
	Tue,  4 Nov 2025 14:50:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02C24EF8C
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267857; cv=none; b=ujKluZuNI21snQ0lmvWNk+K295tafp8kk8WsYjnpJyi9Gj+qjiUFOI3fntEeF+8//SGecpD+CabEeI4B9OIae0h0Nk21w4qfuXlg/5TOOxjsWnMTIcv6loLYS8fKLGDb88QHPl8jCjHGNyH6zbisFn2WOV4eo9EWPH9UIPAEMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267857; c=relaxed/simple;
	bh=kgM37izfwuqc3oKZ7R3XMe2aaxNE5MI450/rV4ZFA2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S36UnBA5qsnvykbz+5iL7TJW6Zzg2O0mzG7rRK5GO+igK6tBOehztl2SFmybWn1ObZEo+Jja3PY/bfJvQsFmeyn7CQKM39TIFGN1teF8SFdUygBeQlqHAny1EcrUxm/OSdp97JA2OLk35DGISylrQVaTMv+kxlsA0k1hHQL0sCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diac24.net
Received: from [2001:67c:1232:144:9c7d:e76f:d255:c66c] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <equinox@diac24.net>)
	id 1vGILB-000000009AG-2q4g;
	Tue, 04 Nov 2025 15:48:59 +0100
Received: from equinox by alea with local (Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1vGIKl-0000000057U-3N90;
	Tue, 04 Nov 2025 09:48:31 -0500
From: David Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: David Lamparter <equinox@diac24.net>,
	Lorenzo Colitti <lorenzo@google.com>,
	Patrick Rohr <prohr@google.com>
Subject: [RESEND PATCH net-next v2 2/4] net/ipv6: create ipv6_fl_get_saddr
Date: Tue,  4 Nov 2025 09:48:20 -0500
Message-ID: <20251104144824.19648-3-equinox@diac24.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251104144824.19648-1-equinox@diac24.net>
References: <20251104144824.19648-1-equinox@diac24.net>
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
---
 include/net/addrconf.h |  4 ++++
 net/ipv6/addrconf.c    | 45 +++++++++++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 78e8b877fb25..577debd34c11 100644
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
index 40e9c336f6c5..f20367156062 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1533,7 +1533,9 @@ struct ipv6_saddr_score {
 };
 
 struct ipv6_saddr_dst {
-	const struct in6_addr *addr;
+	const struct flowi6 *fl6;
+	const struct dst_entry *dst;
+	const struct sock *sk;
 	int ifindex;
 	int scope;
 	int label;
@@ -1610,7 +1612,7 @@ static int ipv6_get_saddr_eval(struct net *net,
 		break;
 	case IPV6_SADDR_RULE_LOCAL:
 		/* Rule 1: Prefer same address */
-		ret = ipv6_addr_equal(&score->ifa->addr, dst->addr);
+		ret = ipv6_addr_equal(&score->ifa->addr, &dst->fl6->daddr);
 		break;
 	case IPV6_SADDR_RULE_SCOPE:
 		/* Rule 2: Prefer appropriate scope
@@ -1688,11 +1690,11 @@ static int ipv6_get_saddr_eval(struct net *net,
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
@@ -1810,9 +1812,10 @@ static int ipv6_get_saddr_master(struct net *net,
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
@@ -1823,11 +1826,13 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
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
@@ -1902,11 +1907,29 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
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
2.50.1


