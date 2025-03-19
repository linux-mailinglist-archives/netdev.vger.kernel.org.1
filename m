Return-Path: <netdev+bounces-176338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9839AA69C8C
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 00:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07CC467BAC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885F222573;
	Wed, 19 Mar 2025 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iYENdIdD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF6221F3E
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742425717; cv=none; b=HMvyAXGKmg/6BCxRUsxiOqIZEDSKyRv6pvxOlBFh+GRK/22eE44oCQ/UJ1FYrH+7jjUFlWcbGeMAuTF0c6MNFB15/oqsTpfV1tOgucUkXiTcOmRbSkK7HjeDyrvgghyJWqyzcyecBBDTBfBRKBdcSSRRTfJQ7oYSq+X2pWygQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742425717; c=relaxed/simple;
	bh=4i13R7Ze1ivTLzxG2CFzV2CD2mtQO9xvEdXP237qUUo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrmgxZMzNbiPpOO5XYM1nbKpYizjSTLonh/Mvgjbp/3sXe8gePDUqhvJ9e2L7v4ARYRWAWoYOyrakFoBKtsPGp7bmV17sPhq9+Vc6+QwJW7W/Egb/8b0hWjx4sW5LnRN5UJ8axtL/WhgzOejBplQMRCGzH7gAVe/XAgoqeQMWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iYENdIdD; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742425712; x=1773961712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ymCdQhgVdJVYK45xjx4+I3K0h7s+YUkZc2dbRPZ3uQ=;
  b=iYENdIdDmRTiWQaQC3ngNJy9aVP7WurAe8S+nosD5fk3c9NDJL3vX16M
   aaG9GAzwgEVmBuMSumBxKWZzH9IYQJRYQTvYThMY1IDc2CwC38lxcKp5z
   f8iQn2AmnsWpd1ZBOX0b2kD6yr7bp4W6Njdix59lG/KvoyLojkmVvdjHm
   w=;
X-IronPort-AV: E=Sophos;i="6.14,260,1736812800"; 
   d="scan'208";a="75909516"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 23:08:28 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:6300]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.37:2525] with esmtp (Farcaster)
 id 45c1f746-bb45-4f9a-8bd2-1575fcff1483; Wed, 19 Mar 2025 23:08:28 +0000 (UTC)
X-Farcaster-Flow-ID: 45c1f746-bb45-4f9a-8bd2-1575fcff1483
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:08:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 23:08:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/7] nexthop: Move nlmsg_parse() in rtm_to_nh_config() to rtm_new_nexthop().
Date: Wed, 19 Mar 2025 16:06:46 -0700
Message-ID: <20250319230743.65267-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319230743.65267-1-kuniyu@amazon.com>
References: <20250319230743.65267-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
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


