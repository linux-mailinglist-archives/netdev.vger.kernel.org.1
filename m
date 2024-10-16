Return-Path: <netdev+bounces-136265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E521A9A121B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155BF1C23399
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7E82141CE;
	Wed, 16 Oct 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c5/FxjpS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5CD18CC11
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105026; cv=none; b=Qm2VheNK/2YYTM5dtJnZ/Njet7/1Vlj3hRVCulgb/3sLb2IA1Z0Sm7jGd4yk+sp3FA2RuCcZmulixuXRv1a/y9nS63yoyYTLXkIeePbyTmPi0Ez1EVjEzfk3G6es4zGiQl/yaAak6GYglEbk5NTUU/HvZuyxYiUvgO7tSI5M2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105026; c=relaxed/simple;
	bh=TbaoQecvxromOHOAF6zl0xK8gFGu7B8tIrm8tvhRGsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kzj9RcaYH1fAl0vNBzAxI4xB0qGMT5hKC3obcUnbPHJGgLXEL1NFYfDTJeB7PCMZDem6zhqiU69IaxrgsMfvWRHbfboNRzur5/wUil6msZp32CXtj7MFI2SYTWfqhIqaHdJdeSjEGVX6teZN+edoQnrLtf+Kyo6O4aMriDkJNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=c5/FxjpS; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729105025; x=1760641025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kRisVF0f12Hjx+DhKHOb98m3XBjt1Vrx3QmLTWP9WF8=;
  b=c5/FxjpSMnstUvgPoQMxzwaw05mNt4UMiwc+URW/bid6esgoJm/ZofYL
   LBIS7C0ctcbqUaIIFdjFigCCdXfR1slj/2nyRzdgi/H/G+thcaz/B7YpW
   f+SG8kEUFFo4czcGq7D0igCEx2MU1UfBdGdJiU1hG/fzHvEKL+SzFwzek
   g=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="343752665"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:57:04 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:54576]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id daa56c0f-1ba9-4ad9-9d0e-dc608f736ac4; Wed, 16 Oct 2024 18:57:02 +0000 (UTC)
X-Farcaster-Flow-ID: daa56c0f-1ba9-4ad9-9d0e-dc608f736ac4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:57:02 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:57:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 09/14] rtnetlink: Fetch IFLA_LINK_NETNSID in rtnl_newlink().
Date: Wed, 16 Oct 2024 11:53:52 -0700
Message-ID: <20241016185357.83849-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016185357.83849-1-kuniyu@amazon.com>
References: <20241016185357.83849-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Another netns option for RTM_NEWLINK is IFLA_LINK_NETNSID and
is fetched in rtnl_newlink_create().

This must be done before holding rtnl_net_lock().

Let's move IFLA_LINK_NETNSID processing to rtnl_newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 49 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f6823c8d21ad..eee0f820ddf6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3634,7 +3634,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 
 static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 			       const struct rtnl_link_ops *ops,
-			       struct net *tgt_net,
+			       struct net *tgt_net, struct net *link_net,
 			       const struct nlmsghdr *nlh,
 			       struct nlattr **tb, struct nlattr **data,
 			       struct netlink_ext_ack *extack)
@@ -3644,7 +3644,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	u32 portid = NETLINK_CB(skb).portid;
 	struct net_device *dev;
 	char ifname[IFNAMSIZ];
-	struct net *link_net;
 	int err;
 
 	if (!ops->alloc && !ops->setup)
@@ -3657,22 +3656,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	if (tb[IFLA_LINK_NETNSID]) {
-		int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);
-
-		link_net = get_net_ns_by_id(tgt_net, id);
-		if (!link_net) {
-			NL_SET_ERR_MSG(extack, "Unknown network namespace id");
-			err =  -EINVAL;
-			goto out;
-		}
-		err = -EPERM;
-		if (!netlink_ns_capable(skb, link_net->user_ns, CAP_NET_ADMIN))
-			goto out;
-	} else {
-		link_net = NULL;
-	}
-
 	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
 			       name_assign_type, ops, tb, extack);
 	if (IS_ERR(dev)) {
@@ -3705,9 +3688,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 			goto out_unregister;
 	}
 out:
-	if (link_net)
-		put_net(link_net);
-
 	return err;
 out_unregister:
 	if (ops->newlink) {
@@ -3723,7 +3703,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  const struct rtnl_link_ops *ops,
-			  struct net *tgt_net,
+			  struct net *tgt_net, struct net *link_net,
 			  struct rtnl_newlink_tbs *tbs,
 			  struct nlattr **data,
 			  struct netlink_ext_ack *extack)
@@ -3772,16 +3752,16 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 	}
 
-	return rtnl_newlink_create(skb, ifm, ops, tgt_net, nlh, tb, data, extack);
+	return rtnl_newlink_create(skb, ifm, ops, tgt_net, link_net, nlh, tb, data, extack);
 }
 
 static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
 	struct nlattr **tb, **linkinfo, **data = NULL;
+	struct net *tgt_net, *link_net = NULL;
 	struct rtnl_link_ops *ops = NULL;
 	struct rtnl_newlink_tbs *tbs;
-	struct net *tgt_net;
 	int ops_srcu_index;
 	int ret;
 
@@ -3852,8 +3832,27 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto put_ops;
 	}
 
-	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, tbs, data, extack);
+	if (tb[IFLA_LINK_NETNSID]) {
+		int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);
+
+		link_net = get_net_ns_by_id(tgt_net, id);
+		if (!link_net) {
+			NL_SET_ERR_MSG(extack, "Unknown network namespace id");
+			ret =  -EINVAL;
+			goto put_net;
+		}
+
+		if (!netlink_ns_capable(skb, link_net->user_ns, CAP_NET_ADMIN)) {
+			ret = -EPERM;
+			goto put_net;
+		}
+	}
+
+	ret = __rtnl_newlink(skb, nlh, ops, tgt_net, link_net, tbs, data, extack);
 
+put_net:
+	if (link_net)
+		put_net(link_net);
 	put_net(tgt_net);
 put_ops:
 	if (ops)
-- 
2.39.5 (Apple Git-154)


