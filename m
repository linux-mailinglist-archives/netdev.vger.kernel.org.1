Return-Path: <netdev+bounces-175943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D343FA680B9
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3E63B6841
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672D92063D5;
	Tue, 18 Mar 2025 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TQnNsIEW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08EE1EF39E
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340800; cv=none; b=YCk2W+duGvclHIkDzF1q+1f15+5awc+8QiHohd/P2v49YS63QbJz+cx3kBiYfCvfGTbAKL2hb6Kc1FANwJzcugfkO9oAlLYG7z9LW1mOmHwuuZn2NXDi/sOu/jFLcHR+8ZMKo4JIJlTy41Sw3n679ZBFMzs9Kcn+rZf6UuhE13U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340800; c=relaxed/simple;
	bh=4i13R7Ze1ivTLzxG2CFzV2CD2mtQO9xvEdXP237qUUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTCRhbPuNOWGIHszFbbMOrsKAj2yK9ZHJolvCYpVnkT170yO2RzL8jzEC6uCB7YW+2/mUewgQbzvKgsygOZDiF8HypISh/NCDPmer8V6asV2V1qOeVWC8/7HMbHs3jLvw38APdbXzuXJK77rqKTwGyKDazK2YU0YXIWxS6romKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TQnNsIEW; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742340798; x=1773876798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ymCdQhgVdJVYK45xjx4+I3K0h7s+YUkZc2dbRPZ3uQ=;
  b=TQnNsIEWABZdHE8XUorCJwOrgt1BprZ5KofmTi/r4afbBxFHB7Ohix1N
   7Hu0Qhp0lDj61THmRcuAE9+bE9B+xdnx529hhK+uF/lSehlDP5o2mUOKr
   l2FwNgvry6hu2jX8JdxqJLugM9RU7ywWvkXcISijTTqG+BGk3ZaPOOI6N
   c=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="179801360"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:33:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:53629]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id afcf3cd4-3665-4882-a76d-397a305887df; Tue, 18 Mar 2025 23:33:16 +0000 (UTC)
X-Farcaster-Flow-ID: afcf3cd4-3665-4882-a76d-397a305887df
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:33:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.212.115) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:33:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/7] nexthop: Move nlmsg_parse() in rtm_to_nh_config() to rtm_new_nexthop().
Date: Tue, 18 Mar 2025 16:31:44 -0700
Message-ID: <20250318233240.53946-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318233240.53946-1-kuniyu@amazon.com>
References: <20250318233240.53946-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will split rtm_to_nh_config() into non-RTNL and RTNL parts,
and then the latter also needs tb.

As a prep, let's move nlmsg_parse() to rtm_new_nexthop().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 01df7dd795f0..487933ecdb68 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3016,19 +3016,13 @@ static int rtm_to_nh_config_grp_res(struct nlattr *res, struct nh_config *cfg,
 }
 
 static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
-			    struct nlmsghdr *nlh, struct nh_config *cfg,
+			    struct nlmsghdr *nlh, struct nlattr **tb,
+			    struct nh_config *cfg,
 			    struct netlink_ext_ack *extack)
 {
 	struct nhmsg *nhm = nlmsg_data(nlh);
-	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_new)];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(*nhm), tb,
-			  ARRAY_SIZE(rtm_nh_policy_new) - 1,
-			  rtm_nh_policy_new, extack);
-	if (err < 0)
-		return err;
-
 	err = -EINVAL;
 	if (nhm->resvd || nhm->nh_scope) {
 		NL_SET_ERR_MSG(extack, "Invalid values in ancillary header");
@@ -3093,7 +3087,8 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 			NL_SET_ERR_MSG(extack, "Invalid group type");
 			goto out;
 		}
-		err = nh_check_attr_group(net, tb, ARRAY_SIZE(tb),
+
+		err = nh_check_attr_group(net, tb, ARRAY_SIZE(rtm_nh_policy_new),
 					  cfg->nh_grp_type, extack);
 		if (err)
 			goto out;
@@ -3211,18 +3206,26 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 			   struct netlink_ext_ack *extack)
 {
+	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_new)];
 	struct net *net = sock_net(skb->sk);
 	struct nh_config cfg;
 	struct nexthop *nh;
 	int err;
 
-	err = rtm_to_nh_config(net, skb, nlh, &cfg, extack);
-	if (!err) {
-		nh = nexthop_add(net, &cfg, extack);
-		if (IS_ERR(nh))
-			err = PTR_ERR(nh);
-	}
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
+			  ARRAY_SIZE(rtm_nh_policy_new) - 1,
+			  rtm_nh_policy_new, extack);
+	if (err < 0)
+		goto out;
 
+	err = rtm_to_nh_config(net, skb, nlh, tb, &cfg, extack);
+	if (err)
+		goto out;
+
+	nh = nexthop_add(net, &cfg, extack);
+	if (IS_ERR(nh))
+		err = PTR_ERR(nh);
+out:
 	return err;
 }
 
-- 
2.48.1


