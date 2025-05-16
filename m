Return-Path: <netdev+bounces-190918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4ADAB940A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 04:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051E516BFE8
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B9F22A4CD;
	Fri, 16 May 2025 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="I5Xybu/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893BF2288D6
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747362545; cv=none; b=hRke761YHf4do694Azt+zz0xaM47jvK81z4adVnZ3qZaOHCePcyyMz2MUVZUmDGjcFW8vn2Ewe0PVlSdQIzDriPKSchx9++vbWD6EnRt8cOjtiWVollZHJETNBhtSdTP+WwWCThZyVD6NSBOUYWQFdg9u9NJdR1Cd2DnNj6xYxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747362545; c=relaxed/simple;
	bh=+UOQ08jkXZYAB03VHeoeycHQW9Xy7HAkxPVGyJPTW4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgtIjLHtcBItl4pGDHSjd9LCDamN9kx95/imD1UiNUMu7hWQSJ9Us8jtwIfRfCwdJKz8gFZw8UfB9z/Igwu1YSg06TAix4a41NSJ7GG4zCtJQc5a6Ne2mO8HJoL/JsRwM9M4v5RWD/QD4Hj/FsYI5HoHkJKBh/8AlNHw8PiF15Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=I5Xybu/q; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747362544; x=1778898544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YOJLoXgi9NuTrVcN5nSCRmsfwcBa4mIk4upHB1WPqMg=;
  b=I5Xybu/qzmGPUotXrKcxQS3TiH+N1frgOaomkSO2wSeTsMNWrAtkACrS
   rBpuUkPtEXexOQBrXh+kTnJzyTe84+v3sWRaf5W+BHLCVHlyqBuxBCEEV
   zcz8sy/WcEUFlWYi2FT64TaK7A1DCwgb85SBHXS3a8CWm/yUzMI4zQiWU
   4lCzhO5ksxsApRZRfgM2LyUCrGSGU2DZAbk1ApmsN+rqj7t4pOg+3uBuo
   Jb8YqMuSek50sXM+4Veah6JYuSZLQRxw4nZiHukS73ATNcguADjVlXRg7
   1shaki83SupFjRfQYxmrsIbqkMGSTjrnvZKFmymMQuD5KHlNfkCP85PLF
   g==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="499140984"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:29:01 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:8597]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.241:2525] with esmtp (Farcaster)
 id d64853a9-344f-4d05-b6e0-887aa03e1003; Fri, 16 May 2025 02:28:59 +0000 (UTC)
X-Farcaster-Flow-ID: d64853a9-344f-4d05-b6e0-887aa03e1003
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:28:59 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 16 May 2025 02:28:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 2/7] inet: Remove rtnl_is_held arg of lwtunnel_valid_encap_type(_attr)?().
Date: Thu, 15 May 2025 19:27:18 -0700
Message-ID: <20250516022759.44392-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516022759.44392-1-kuniyu@amazon.com>
References: <20250516022759.44392-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit f130a0cc1b4f ("inet: fix lwtunnel_valid_encap_type() lock
imbalance") added the rtnl_is_held argument as a temporary fix while
I'm converting nexthop and IPv6 routing table to per-netns RTNL or RCU.

Now all callers of lwtunnel_valid_encap_type() do not hold RTNL.

Let's remove the argument.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/lwtunnel.h  | 13 +++++--------
 net/core/lwtunnel.c     | 15 +++------------
 net/ipv4/fib_frontend.c |  4 ++--
 net/ipv4/nexthop.c      |  3 +--
 net/ipv6/route.c        |  6 ++----
 5 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/net/lwtunnel.h b/include/net/lwtunnel.h
index 39cd50300a18..c306ebe379a0 100644
--- a/include/net/lwtunnel.h
+++ b/include/net/lwtunnel.h
@@ -116,11 +116,9 @@ int lwtunnel_encap_add_ops(const struct lwtunnel_encap_ops *op,
 int lwtunnel_encap_del_ops(const struct lwtunnel_encap_ops *op,
 			   unsigned int num);
 int lwtunnel_valid_encap_type(u16 encap_type,
-			      struct netlink_ext_ack *extack,
-			      bool rtnl_is_held);
+			      struct netlink_ext_ack *extack);
 int lwtunnel_valid_encap_type_attr(struct nlattr *attr, int len,
-				   struct netlink_ext_ack *extack,
-				   bool rtnl_is_held);
+				   struct netlink_ext_ack *extack);
 int lwtunnel_build_state(struct net *net, u16 encap_type,
 			 struct nlattr *encap,
 			 unsigned int family, const void *cfg,
@@ -203,15 +201,14 @@ static inline int lwtunnel_encap_del_ops(const struct lwtunnel_encap_ops *op,
 }
 
 static inline int lwtunnel_valid_encap_type(u16 encap_type,
-					    struct netlink_ext_ack *extack,
-					    bool rtnl_is_held)
+					    struct netlink_ext_ack *extack)
 {
 	NL_SET_ERR_MSG(extack, "CONFIG_LWTUNNEL is not enabled in this kernel");
 	return -EOPNOTSUPP;
 }
+
 static inline int lwtunnel_valid_encap_type_attr(struct nlattr *attr, int len,
-						 struct netlink_ext_ack *extack,
-						 bool rtnl_is_held)
+						 struct netlink_ext_ack *extack)
 {
 	/* return 0 since we are not walking attr looking for
 	 * RTA_ENCAP_TYPE attribute on nexthops.
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 60f27cb4e54f..f9d76d85d04f 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -149,8 +149,7 @@ int lwtunnel_build_state(struct net *net, u16 encap_type,
 }
 EXPORT_SYMBOL_GPL(lwtunnel_build_state);
 
-int lwtunnel_valid_encap_type(u16 encap_type, struct netlink_ext_ack *extack,
-			      bool rtnl_is_held)
+int lwtunnel_valid_encap_type(u16 encap_type, struct netlink_ext_ack *extack)
 {
 	const struct lwtunnel_encap_ops *ops;
 	int ret = -EINVAL;
@@ -167,12 +166,7 @@ int lwtunnel_valid_encap_type(u16 encap_type, struct netlink_ext_ack *extack,
 		const char *encap_type_str = lwtunnel_encap_str(encap_type);
 
 		if (encap_type_str) {
-			if (rtnl_is_held)
-				__rtnl_unlock();
 			request_module("rtnl-lwt-%s", encap_type_str);
-			if (rtnl_is_held)
-				rtnl_lock();
-
 			ops = rcu_access_pointer(lwtun_encaps[encap_type]);
 		}
 	}
@@ -186,8 +180,7 @@ int lwtunnel_valid_encap_type(u16 encap_type, struct netlink_ext_ack *extack,
 EXPORT_SYMBOL_GPL(lwtunnel_valid_encap_type);
 
 int lwtunnel_valid_encap_type_attr(struct nlattr *attr, int remaining,
-				   struct netlink_ext_ack *extack,
-				   bool rtnl_is_held)
+				   struct netlink_ext_ack *extack)
 {
 	struct rtnexthop *rtnh = (struct rtnexthop *)attr;
 	struct nlattr *nla_entype;
@@ -208,9 +201,7 @@ int lwtunnel_valid_encap_type_attr(struct nlattr *attr, int remaining,
 				}
 				encap_type = nla_get_u16(nla_entype);
 
-				if (lwtunnel_valid_encap_type(encap_type,
-							      extack,
-							      rtnl_is_held) != 0)
+				if (lwtunnel_valid_encap_type(encap_type, extack))
 					return -EOPNOTSUPP;
 			}
 		}
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 57f088e5540e..fd1e1507a224 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -807,7 +807,7 @@ static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
 		case RTA_MULTIPATH:
 			err = lwtunnel_valid_encap_type_attr(nla_data(attr),
 							     nla_len(attr),
-							     extack, false);
+							     extack);
 			if (err < 0)
 				goto errout;
 			cfg->fc_mp = nla_data(attr);
@@ -825,7 +825,7 @@ static int rtm_to_fib_config(struct net *net, struct sk_buff *skb,
 		case RTA_ENCAP_TYPE:
 			cfg->fc_encap_type = nla_get_u16(attr);
 			err = lwtunnel_valid_encap_type(cfg->fc_encap_type,
-							extack, false);
+							extack);
 			if (err < 0)
 				goto errout;
 			break;
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 823e4a783d2b..4397e89d3123 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3180,8 +3180,7 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 		}
 
 		cfg->nh_encap_type = nla_get_u16(tb[NHA_ENCAP_TYPE]);
-		err = lwtunnel_valid_encap_type(cfg->nh_encap_type,
-						extack, false);
+		err = lwtunnel_valid_encap_type(cfg->nh_encap_type, extack);
 		if (err < 0)
 			goto out;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 44300962230b..6baf177c529b 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5172,8 +5172,7 @@ static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
 		rtnh = rtnh_next(rtnh, &remaining);
 	} while (rtnh_ok(rtnh, remaining));
 
-	return lwtunnel_valid_encap_type_attr(cfg->fc_mp, cfg->fc_mp_len,
-					      extack, false);
+	return lwtunnel_valid_encap_type_attr(cfg->fc_mp, cfg->fc_mp_len, extack);
 }
 
 static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -5310,8 +5309,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (tb[RTA_ENCAP_TYPE]) {
 		cfg->fc_encap_type = nla_get_u16(tb[RTA_ENCAP_TYPE]);
 
-		err = lwtunnel_valid_encap_type(cfg->fc_encap_type,
-						extack, false);
+		err = lwtunnel_valid_encap_type(cfg->fc_encap_type, extack);
 		if (err < 0)
 			goto errout;
 	}
-- 
2.49.0


