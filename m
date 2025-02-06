Return-Path: <netdev+bounces-163421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAF0A2A37F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E9B1677C7
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA5214231;
	Thu,  6 Feb 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X6P3ayo7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1969163
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831713; cv=none; b=CNGryMA73MYNxvtxgdXLO7XNGnmj3h7Lg/IYBAuSSMW2Vm3ef/WH11t+MBgA/xZ7c2V4UPxATQpYdjF2uRp6PJsN0b1Zqn6XbfBhZuH87Rrj+u027FzG+Fde0qszVaW7ScRbuCe7D35k3qdG6glxBB3sxzcz2rTVV1aDblD/wm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831713; c=relaxed/simple;
	bh=O31ATdtnTQFm2JtGFbgfAcyL+s8ArtGXBNbgdN0NME8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6bIxEVs8gHTqqIKq/TGAwCC/raun152mhMs5m0QjoozIIKZpRLTXipQgqfRvW9Ss/R/iyWpYjsR6LIl9ATJLS/kDsbS+sYxc+fV3ebAdpYSLdueHAK60gpWvtFEp127BhurDaQUJSYGULnv4HKzM0VNzsgrxHdYl6Pe9jZipoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=X6P3ayo7; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738831711; x=1770367711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YjUDPFsIp5DWWJKHjHQWO//JSRngbJ3rbnnht5syDb4=;
  b=X6P3ayo7F2CrEx+a9Y1HS3RY8ANBlt98KRiZEwH9ulYsJ5a5yqcZzcPC
   XyCAYX+CT67Ih1+QDhH3W5N2hS4GjuWw/W/BdwvYUX7p0A1eAr9oxki67
   D/cYiAHzr6o/KjGw9Aqw4V68cYlnrDspR/0X1SZElWdE5e4lRetLplfCp
   0=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="167332938"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 08:48:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:2396]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.120:2525] with esmtp (Farcaster)
 id 01f240bf-72cd-4aeb-a87c-e1fec1a906d9; Thu, 6 Feb 2025 08:48:30 +0000 (UTC)
X-Farcaster-Flow-ID: 01f240bf-72cd-4aeb-a87c-e1fec1a906d9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:48:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:48:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/6] fib: rules: Convert RTM_NEWRULE to per-netns RTNL.
Date: Thu, 6 Feb 2025 17:46:27 +0900
Message-ID: <20250206084629.16602-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250206084629.16602-1-kuniyu@amazon.com>
References: <20250206084629.16602-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

fib_nl_newrule() is the doit() handler for RTM_NEWRULE but also called
from vrf_newlink().

In the latter case, RTNL is already held and the 3rd arg extack is NULL.

Let's hold per-netns RTNL in fib_nl_newrule() if extack is NULL.

Note that we call fib_rule_get() before releasing per-netns RTNL to call
notify_rule_change() without RTNL and prevent freeing the new rule.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 694a8c2884a8..3cdfa3ac8c7c 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -786,13 +786,13 @@ static const struct nla_policy fib_rule_policy[FRA_MAX + 1] = {
 int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 		   struct netlink_ext_ack *extack)
 {
-	struct net *net = sock_net(skb->sk);
+	bool user_priority = false, hold_rtnl = !!extack;
 	struct fib_rule_hdr *frh = nlmsg_data(nlh);
+	struct fib_rule *rule, *r, *last = NULL;
+	struct net *net = sock_net(skb->sk);
+	int err = -EINVAL, unresolved = 0;
 	struct fib_rules_ops *ops = NULL;
-	struct fib_rule *rule = NULL, *r, *last = NULL;
 	struct nlattr *tb[FRA_MAX + 1];
-	int err = -EINVAL, unresolved = 0;
-	bool user_priority = false;
 
 	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*frh))) {
 		NL_SET_ERR_MSG(extack, "Invalid msg length");
@@ -817,6 +817,9 @@ int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto errout;
 
+	if (hold_rtnl)
+		rtnl_net_lock(net);
+
 	err = fib_nl2rule_rtnl(rule, ops, tb, extack);
 	if (err)
 		goto errout_free;
@@ -882,12 +885,20 @@ int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (rule->tun_id)
 		ip_tunnel_need_metadata();
 
+	fib_rule_get(rule);
+
+	if (hold_rtnl)
+		rtnl_net_unlock(net);
+
 	notify_rule_change(RTM_NEWRULE, rule, ops, nlh, NETLINK_CB(skb).portid);
+	fib_rule_put(rule);
 	flush_route_cache(ops);
 	rules_ops_put(ops);
 	return 0;
 
 errout_free:
+	if (hold_rtnl)
+		rtnl_net_unlock(net);
 	kfree(rule);
 errout:
 	rules_ops_put(ops);
@@ -1310,7 +1321,8 @@ static struct pernet_operations fib_rules_net_ops = {
 };
 
 static const struct rtnl_msg_handler fib_rules_rtnl_msg_handlers[] __initconst = {
-	{.msgtype = RTM_NEWRULE, .doit = fib_nl_newrule},
+	{.msgtype = RTM_NEWRULE, .doit = fib_nl_newrule,
+	 .flags = RTNL_FLAG_DOIT_PERNET},
 	{.msgtype = RTM_DELRULE, .doit = fib_nl_delrule},
 	{.msgtype = RTM_GETRULE, .dumpit = fib_nl_dumprule,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
-- 
2.39.5 (Apple Git-154)


