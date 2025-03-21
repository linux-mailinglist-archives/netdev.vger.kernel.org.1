Return-Path: <netdev+bounces-176651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE74A6B384
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 05:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF087A9487
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 04:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158721957FF;
	Fri, 21 Mar 2025 04:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DTrJYJoh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7EA944
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 04:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742529740; cv=none; b=ZjnVvhEjkiDig8fLQ3TU2WBE5H1HaxQ7KCtg+CRcpsgtMpqRd7QASHvA5rcUYTNnYy1bf1N5sL3AxF0SuXNzA9XTN+Ck97aLKfR9pyxxdbw39a93ZelxsNpUXuP3GMH2ucvUgX4uS8b67bICbnADHy59blJLVHGwOFcqI7v0YiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742529740; c=relaxed/simple;
	bh=zOmgCjvZBt5ZzBkOZ7fA6PRfE2HLKr2oqn15B9HdFZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXTcrcGAFuWftLWS3Hi10yOr4IHhA32spYc9qRSPdNRz/zjI7TnTpG6JfNomDXtfIBkWFukhHkKFV9cPMUvxZd/8L2AuD1wcgV4aoNEFb1ucGD1C1F7v/E0ZdrPO6WrUUCFrCPuPlYuOIZjAotYNEB8E3ut1MbIB77mcLGSspN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DTrJYJoh; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742529738; x=1774065738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2O0b88XU64brEuURodIW/A2w6KldKC/6p6w0yBr5dgw=;
  b=DTrJYJohvfSKpFCjxV3cwgrvcdRgE4A/IUpAXTsJcx8hMoNu2JQFp2zZ
   wwv8GGZFwxE4N9B/+OrxSKQNQwzYCf+K/UYoFFttoZcC9oifwm49yO3n1
   YIF10IotKMcZkPROz1zHcSqQbaDq2BF4gi7aKW+pF9YSp3HnYdmqZo6Qc
   8=;
X-IronPort-AV: E=Sophos;i="6.14,263,1736812800"; 
   d="scan'208";a="476936461"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 04:02:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:28059]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.159:2525] with esmtp (Farcaster)
 id 808b003a-1a51-4439-8c94-875156348794; Fri, 21 Mar 2025 04:02:13 +0000 (UTC)
X-Farcaster-Flow-ID: 808b003a-1a51-4439-8c94-875156348794
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:02:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Mar 2025 04:02:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/13] ipv6: Validate RTA_GATEWAY of RTA_MULTIPATH in rtm_to_fib6_config().
Date: Thu, 20 Mar 2025 21:00:38 -0700
Message-ID: <20250321040131.21057-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321040131.21057-1-kuniyu@amazon.com>
References: <20250321040131.21057-1-kuniyu@amazon.com>
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
RTM_ADDROUTE.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/route.c | 82 +++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index c3406a0d45bd..6c9c99fb02fe 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5016,6 +5016,44 @@ static const struct nla_policy rtm_ipv6_policy[RTA_MAX+1] = {
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
@@ -5130,9 +5168,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 		cfg->fc_mp = nla_data(tb[RTA_MULTIPATH]);
 		cfg->fc_mp_len = nla_len(tb[RTA_MULTIPATH]);
 
-		err = lwtunnel_valid_encap_type_attr(cfg->fc_mp,
-						     cfg->fc_mp_len,
-						     extack, true);
+		err = rtm_to_fib6_multipath_config(cfg, extack);
 		if (err < 0)
 			goto errout;
 	}
@@ -5252,19 +5288,6 @@ static bool ip6_route_mpath_should_notify(const struct fib6_info *rt)
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
@@ -5305,18 +5328,11 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 
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
@@ -5349,12 +5365,6 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
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
@@ -5476,21 +5486,15 @@ static int ip6_route_multipath_del(struct fib6_config *cfg,
 
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
2.48.1


