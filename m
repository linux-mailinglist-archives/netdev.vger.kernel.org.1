Return-Path: <netdev+bounces-180544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEC1A81A58
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 03:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A2F1B64848
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 01:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3DC42048;
	Wed,  9 Apr 2025 01:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JhPxg/3c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303FBE555
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161204; cv=none; b=fYJWUzJyji+dTj+WdK2k5py5ZD1sF9l6RhJJoNKr3YTLYuEXNxbNJdAEsyMt4QXTdO1aZNR8uS1Xawrhr+k849SV/63EPBDds0ycy5RC8yKSJ5BYJDFcW7QgE/aquVOfFjJLi3cZUuY3XH5wpIWz4mz7Yj7XINsFYqw2So0QWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161204; c=relaxed/simple;
	bh=Zp6E6ZE6Qnsr8K7T5RjMvIozc61aEV1RlCaf2OPOCuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjoHtMtX/GUpoZU1ejwdX+6Q2nUc0kbuD2w7uuv+r1WW17rGuK2bXbCKBv3rpYRhCcALi51mPqeNvmNturXx4U6SlWZRpWaz3AP/SszTkqfV95iM6rOaYIqImqYCQDECDzVfPqMG+Y2Juk9UmyUfDuDAPNzW4jtTNCYDmWd3gqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JhPxg/3c; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744161203; x=1775697203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0cu1lzVf7QGU3VwJ6keugam7FRf1LeWsen8XKq9Oj5w=;
  b=JhPxg/3cw9Yc0J7YNPm8mhcQJB1CXrWRVMsWTcT0D5CQSkAWcv7qCQhE
   XytJ1t/V27kLypQd4touYIIDdzjoS9uVbv6GuwqOew/QX8a73oG6iG0Ea
   0z2Qyp3b3KYQSPC/og8vbCS9sbMAQoQRaxFxatXSAntH1yaHHEt1dBdWZ
   g=;
X-IronPort-AV: E=Sophos;i="6.15,199,1739836800"; 
   d="scan'208";a="185750847"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 01:13:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:24148]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 88dca748-31c3-42d4-b481-079fe41880f9; Wed, 9 Apr 2025 01:13:20 +0000 (UTC)
X-Farcaster-Flow-ID: 88dca748-31c3-42d4-b481-079fe41880f9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:13:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 9 Apr 2025 01:13:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/14] ipv6: Validate RTA_GATEWAY of RTA_MULTIPATH in rtm_to_fib6_config().
Date: Tue, 8 Apr 2025 18:12:09 -0700
Message-ID: <20250409011243.26195-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409011243.26195-1-kuniyu@amazon.com>
References: <20250409011243.26195-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
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
index ab12b816ab94..b6f2c0f1cbba 100644
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


