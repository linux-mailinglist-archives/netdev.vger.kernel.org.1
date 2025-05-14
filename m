Return-Path: <netdev+bounces-190533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8586AAB76F4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 22:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B3F3AC2B0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 20:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138AA29616D;
	Wed, 14 May 2025 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="E1R59mBG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EA2213E79
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254049; cv=none; b=oAV9WZTcMOqC29LpHi0THVcOt6EotPU2Pir2Edt6nd18ejFBWzSokqzPr+XZV7HMHfUtDtj+z7K4NxWHTxtLEIWV0AksLMUM2XF+aTlVe4VuDzj2gRnjQpoDwtwzsSM4BqBy+B6x0/lHvioirPDxQYjrgZr/5cJ1Htvi5uD9MYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254049; c=relaxed/simple;
	bh=+UOQ08jkXZYAB03VHeoeycHQW9Xy7HAkxPVGyJPTW4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBSPDU+Hlgp9FTeUlplE3opPKBrWmdK/PUObg0k+OEFAJDM1DDXNj9NDTLmKk5a7DDQaemBZbsfzcuXNGHbiOiXi0zhQ3oa5bDDE5yniHqc45YFea9mvWBSjasYL/A4zTRp4yagkX01SICP0r+Wt0ibhOmrgbJProjBwghiJNkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=E1R59mBG; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747254045; x=1778790045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YOJLoXgi9NuTrVcN5nSCRmsfwcBa4mIk4upHB1WPqMg=;
  b=E1R59mBGems54KZrJ5z6CnzKWMtwwnIqSX6JQtE77z2a2rwD0FhonJXj
   AUDy2RUAyQ29XUGYzRobKaDu4l9OvR5rqmJ3uusXGcLWXlYlqXybZeGYk
   O+gdkBQuZW02utEgx65WoOj2WnpE2CT+yX6vony2r6dW6UkY0nyRsEaZ3
   uslpmYaHqeokEx7GdGkzVfCuJAkWEHelbrW3wlccqHf68FZxs2gx+UOp4
   wTZi1PogHl94UiSrQfOzbjW4p++sP2oCdbGA2R792Wb/Hf2CervLBzC2B
   uvnoz4y1fh5+YB5qa6gRfPwmWF/Mq84raVVOKlhtvK6z1bjD8hMFIhv2t
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,289,1739836800"; 
   d="scan'208";a="200614652"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 20:20:44 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:47316]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.229:2525] with esmtp (Farcaster)
 id 9e588913-17a5-4588-aa73-75f21576d635; Wed, 14 May 2025 20:20:43 +0000 (UTC)
X-Farcaster-Flow-ID: 9e588913-17a5-4588-aa73-75f21576d635
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:20:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 20:20:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/7] inet: Remove rtnl_is_held arg of lwtunnel_valid_encap_type(_attr)?().
Date: Wed, 14 May 2025 13:18:55 -0700
Message-ID: <20250514201943.74456-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514201943.74456-1-kuniyu@amazon.com>
References: <20250514201943.74456-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
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


