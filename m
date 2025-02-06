Return-Path: <netdev+bounces-163423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7FAA2A389
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B383A8003
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012BB214231;
	Thu,  6 Feb 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v6Ce1OFC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5464D22578E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831764; cv=none; b=k5ruaBb6+NDCxNjmlmhM6ib/pX9l6KA8qIIf8KjD7sbz4Qci+tgIT6Xcxz9kCTcUcpTLHmLeRPPSmijX+bel9awxPKZOudtnFZ1mUAZmoMG3+SFAS6/9Xlgdc/mxfDyhLWoJXEfC5F9BsF4JjzLd7RoyeSPemrZyBnQwTAkqL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831764; c=relaxed/simple;
	bh=yuQndV53eh6JnDaOL7Dv7tv7gWBKGlFuStTlljBr1a4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWYytE758Gv134SkMVK0mgAmlAsPxz39ztEh2LpSG2iEexI4kaYCTRob0ip0bLjtbpu3hfQkIr5FYh2+j5ulg5kDtGcWoYgUQkDEH2Am6CJl24vRHwxTmZurojfVskJeDQP7i0HB5NNC76uIJmk8xQbzOjza9e0iwlcaJK3aQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=v6Ce1OFC; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738831763; x=1770367763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/LyxjULeVQVu51J3sSQ7p8Lmg0R5Trlt+EwKMvHVY4A=;
  b=v6Ce1OFCqbutRgpYAiZwoFIsqOHZI4YhyhIT1MmyZcF1Vo8vQNvy7BY/
   AqcB3OpsX3n81t/IlNbuVxadMYN7PmYns/Kh/ze6I0qYQkg3nkc8f3/oB
   tkhdj/0IyKIQeM5V+29VxSjh0HyUpq8WVM6YslYcBb3GClsaRCDWCX3gC
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="374964194"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 08:49:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:47884]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.242:2525] with esmtp (Farcaster)
 id dc3ebe3a-7086-4f78-940b-1cdb748fc108; Thu, 6 Feb 2025 08:49:22 +0000 (UTC)
X-Farcaster-Flow-ID: dc3ebe3a-7086-4f78-940b-1cdb748fc108
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:49:22 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:49:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/6] fib: rules: Convert RTM_DELRULE to per-netns RTNL.
Date: Thu, 6 Feb 2025 17:46:29 +0900
Message-ID: <20250206084629.16602-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

fib_nl_delrule() is the doit() handler for RTM_DELRULE but also called
1;95;0cfrom vrf_newlink() in case something fails in vrf_add_fib_rules().

In the latter case, RTNL is already held and the 3rd arg extack is NULL.

Let's hold per-netns RTNL in fib_nl_delrule() if extack is NULL.

Now we can place ASSERT_RTNL_NET() in call_fib_rule_notifiers().

While at it, fib_rule r is moved to the suitable scope.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index cc26c762fa9e..3430d026134d 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -371,7 +371,8 @@ static int call_fib_rule_notifiers(struct net *net,
 		.rule = rule,
 	};
 
-	ASSERT_RTNL();
+	ASSERT_RTNL_NET(net);
+
 	/* Paired with READ_ONCE() in fib_rules_seq() */
 	WRITE_ONCE(ops->fib_rules_seq, ops->fib_rules_seq + 1);
 	return call_fib_notifiers(net, event_type, &info.info);
@@ -909,13 +910,13 @@ EXPORT_SYMBOL_GPL(fib_nl_newrule);
 int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 		   struct netlink_ext_ack *extack)
 {
-	struct net *net = sock_net(skb->sk);
+	bool user_priority = false, hold_rtnl = !!extack;
+	struct fib_rule *rule = NULL, *nlrule = NULL;
 	struct fib_rule_hdr *frh = nlmsg_data(nlh);
+	struct net *net = sock_net(skb->sk);
 	struct fib_rules_ops *ops = NULL;
-	struct fib_rule *rule = NULL, *r, *nlrule = NULL;
 	struct nlattr *tb[FRA_MAX+1];
 	int err = -EINVAL;
-	bool user_priority = false;
 
 	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*frh))) {
 		NL_SET_ERR_MSG(extack, "Invalid msg length");
@@ -940,6 +941,9 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto errout;
 
+	if (hold_rtnl)
+		rtnl_net_lock(net);
+
 	err = fib_nl2rule_rtnl(nlrule, ops, tb, extack);
 	if (err)
 		goto errout_free;
@@ -980,7 +984,7 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	 * current if it is goto rule, have actually been added.
 	 */
 	if (ops->nr_goto_rules > 0) {
-		struct fib_rule *n;
+		struct fib_rule *n, *r;
 
 		n = list_next_entry(rule, list);
 		if (&n->list == &ops->rules_list || n->pref != rule->pref)
@@ -994,10 +998,12 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	call_fib_rule_notifiers(net, FIB_EVENT_RULE_DEL, rule, ops,
-				NULL);
-	notify_rule_change(RTM_DELRULE, rule, ops, nlh,
-			   NETLINK_CB(skb).portid);
+	call_fib_rule_notifiers(net, FIB_EVENT_RULE_DEL, rule, ops, NULL);
+
+	if (hold_rtnl)
+		rtnl_net_unlock(net);
+
+	notify_rule_change(RTM_DELRULE, rule, ops, nlh, NETLINK_CB(skb).portid);
 	fib_rule_put(rule);
 	flush_route_cache(ops);
 	rules_ops_put(ops);
@@ -1005,6 +1011,8 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return 0;
 
 errout_free:
+	if (hold_rtnl)
+		rtnl_net_unlock(net);
 	kfree(nlrule);
 errout:
 	rules_ops_put(ops);
@@ -1324,7 +1332,8 @@ static struct pernet_operations fib_rules_net_ops = {
 static const struct rtnl_msg_handler fib_rules_rtnl_msg_handlers[] __initconst = {
 	{.msgtype = RTM_NEWRULE, .doit = fib_nl_newrule,
 	 .flags = RTNL_FLAG_DOIT_PERNET},
-	{.msgtype = RTM_DELRULE, .doit = fib_nl_delrule},
+	{.msgtype = RTM_DELRULE, .doit = fib_nl_delrule,
+	 .flags = RTNL_FLAG_DOIT_PERNET},
 	{.msgtype = RTM_GETRULE, .dumpit = fib_nl_dumprule,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
 };
-- 
2.39.5 (Apple Git-154)


