Return-Path: <netdev+bounces-183990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A264CA92E9C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0993B51B7
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B205372;
	Fri, 18 Apr 2025 00:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="myBjw2Cj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C14C80
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934791; cv=none; b=aoWZdEAqgxgVYpabwj2SrXpNGOoUg7VXHeewuU7LVEM5QKlXmBGId8Rd8do8mn+hMWTgonjQET9p32SScmpxJhVDW09QOWMHm/gvXSJ9Tqs/dL+ljYlC8HE6H/q9Hjasj81YO+8AUH2FEHOeTFTpbNTr317FKRkS/oRiP9pgCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934791; c=relaxed/simple;
	bh=N8uxOTRUw9pLZHNjU69D1FMyv8yjlDTJPBfVh0b4tD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ii494RTXsKAVld1JmR05JjikxmYW9xcxv6leb3hZYesO3bgNoOq9GLcFBfDTNAYf1KA/o4cPl1nY8zium9QLlnz//UG4R0CA0ujyY6kReLt/2XlQ79WM9I1FkqNfxscdc2F5INPt7QmNg7oBEmBGndclHlB6rhX+li2G2rLZeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=myBjw2Cj; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744934789; x=1776470789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=syCUoJTRDODfrogevKezlpcwY1DeV1c2TMvS+hQzchE=;
  b=myBjw2CjBGS5gfW25YNehtrJSMvOcOMukDjCffGUguGdi+fZMBKpCGFQ
   Yb6ilcZz2NoNUf3JxeLRJk/xvHGWa9Vatx/yctAvFz6TApWkI/EL+DXXu
   sRdxkC9Y85/qImV1vOqNtIstf6+HH/PXEVHolydw00lveqOed3hY4nC7o
   U=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="188416455"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:05:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:17811]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.20:2525] with esmtp (Farcaster)
 id 482fb004-6bfd-43d2-9615-11b4220022e0; Fri, 18 Apr 2025 00:05:20 +0000 (UTC)
X-Farcaster-Flow-ID: 482fb004-6bfd-43d2-9615-11b4220022e0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:05:19 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:05:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 01/15] ipv6: Validate RTA_GATEWAY of RTA_MULTIPATH in rtm_to_fib6_config().
Date: Thu, 17 Apr 2025 17:03:42 -0700
Message-ID: <20250418000443.43734-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418000443.43734-1-kuniyu@amazon.com>
References: <20250418000443.43734-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will perform RTM_NEWROUTE and RTM_DELROUTE under RCU, and then
we want to perform some validation out of the RCU scope.

When creating / removing an IPv6 route with RTA_MULTIPATH,
inet6_rtm_newroute() / inet6_rtm_delroute() validates RTA_GATEWAY
in each multipath entry.

Let's do that in rtm_to_fib6_config().

Note that now RTM_DELROUTE returns an error for RTA_MULTIPATH with
0 entries, which was accepted but should result in -EINVAL as
RTM_NEWROUTE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 82 +++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index e2c6c0b0684b..51f693581b7c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5050,6 +5050,44 @@ static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
 	[RTA_FLOWLABEL]		= { .type = NLA_BE32 },
 };
 
+static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
+					struct netlink_ext_ack *extack)
+{
+	struct rtnexthop *rtnh;
+	int remaining;
+
+	remaining = cfg->fc_mp_len;
+	rtnh = (struct rtnexthop *)cfg->fc_mp;
+
+	if (!rtnh_ok(rtnh, remaining)) {
+		NL_SET_ERR_MSG(extack, "Invalid nexthop configuration - no valid nexthops");
+		return -EINVAL;
+	}
+
+	do {
+		int attrlen = rtnh_attrlen(rtnh);
+
+		if (attrlen > 0) {
+			struct nlattr *nla, *attrs;
+
+			attrs = rtnh_attrs(rtnh);
+			nla = nla_find(attrs, attrlen, RTA_GATEWAY);
+			if (nla) {
+				if (nla_len(nla) < sizeof(cfg->fc_gateway)) {
+					NL_SET_ERR_MSG(extack,
+						       "Invalid IPv6 address in RTA_GATEWAY");
+					return -EINVAL;
+				}
+			}
+		}
+
+		rtnh = rtnh_next(rtnh, &remaining);
+	} while (rtnh_ok(rtnh, remaining));
+
+	return lwtunnel_valid_encap_type_attr(cfg->fc_mp, cfg->fc_mp_len,
+					      extack, true);
+}
+
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 			      struct fib6_config *cfg,
 			      struct netlink_ext_ack *extack)
@@ -5164,9 +5202,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		cfg->fc_mp = nla_data(tb[RTA_MULTIPATH]);
 		cfg->fc_mp_len = nla_len(tb[RTA_MULTIPATH]);
 
-		err = lwtunnel_valid_encap_type_attr(cfg->fc_mp,
-						     cfg->fc_mp_len,
-						     extack, true);
+		err = rtm_to_fib6_multipath_config(cfg, extack);
 		if (err < 0)
 			goto errout;
 	}
@@ -5286,19 +5322,6 @@ static bool ip6_route_mpath_should_notify(const struct fib6_info *rt)
 	return should_notify;
 }
 
-static int fib6_gw_from_attr(struct in6_addr *gw, struct nlattr *nla,
-			     struct netlink_ext_ack *extack)
-{
-	if (nla_len(nla) < sizeof(*gw)) {
-		NL_SET_ERR_MSG(extack, "Invalid IPv6 address in RTA_GATEWAY");
-		return -EINVAL;
-	}
-
-	*gw = nla_get_in6_addr(nla);
-
-	return 0;
-}
-
 static int ip6_route_multipath_add(struct fib6_config *cfg,
 				   struct netlink_ext_ack *extack)
 {
@@ -5339,18 +5362,11 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
 			nla = nla_find(attrs, attrlen, RTA_GATEWAY);
 			if (nla) {
-				err = fib6_gw_from_attr(&r_cfg.fc_gateway, nla,
-							extack);
-				if (err)
-					goto cleanup;
-
+				r_cfg.fc_gateway = nla_get_in6_addr(nla);
 				r_cfg.fc_flags |= RTF_GATEWAY;
 			}
-			r_cfg.fc_encap = nla_find(attrs, attrlen, RTA_ENCAP);
 
-			/* RTA_ENCAP_TYPE length checked in
-			 * lwtunnel_valid_encap_type_attr
-			 */
+			r_cfg.fc_encap = nla_find(attrs, attrlen, RTA_ENCAP);
 			nla = nla_find(attrs, attrlen, RTA_ENCAP_TYPE);
 			if (nla)
 				r_cfg.fc_encap_type = nla_get_u16(nla);
@@ -5383,12 +5399,6 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 		rtnh = rtnh_next(rtnh, &remaining);
 	}
 
-	if (list_empty(&rt6_nh_list)) {
-		NL_SET_ERR_MSG(extack,
-			       "Invalid nexthop configuration - no valid nexthops");
-		return -EINVAL;
-	}
-
 	/* for add and replace send one notification with all nexthops.
 	 * Skip the notification in fib6_add_rt2node and send one with
 	 * the full route when done
@@ -5510,21 +5520,15 @@ static int ip6_route_multipath_del(struct fib6_config *cfg,
 
 			nla = nla_find(attrs, attrlen, RTA_GATEWAY);
 			if (nla) {
-				err = fib6_gw_from_attr(&r_cfg.fc_gateway, nla,
-							extack);
-				if (err) {
-					last_err = err;
-					goto next_rtnh;
-				}
-
+				r_cfg.fc_gateway = nla_get_in6_addr(nla);
 				r_cfg.fc_flags |= RTF_GATEWAY;
 			}
 		}
+
 		err = ip6_route_del(&r_cfg, extack);
 		if (err)
 			last_err = err;
 
-next_rtnh:
 		rtnh = rtnh_next(rtnh, &remaining);
 	}
 
-- 
2.49.0


