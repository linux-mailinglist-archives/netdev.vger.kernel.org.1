Return-Path: <netdev+bounces-163839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E8DA2BC3B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A797A2B36
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF691A2564;
	Fri,  7 Feb 2025 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bhmb8Ln9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBB1898F8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913250; cv=none; b=ANn1DJARjjvEplutF2XQpT14tcHr42Il84dN8AXqPXxdazW7kW2OCsMfkLzyfjdlG9+YfMVX0m3EQ/132XVe/0LGjhfd4iK2N94L0CsuUeIDVXW4dJrAmHY+RZavhvzloz2RNLDapuXD7gpmAn69uMb9gePrU42D6UoaeaYg+wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913250; c=relaxed/simple;
	bh=WLzIdnF5vkImn5zlzJ6zbUw4kCDbO0Xbu5wbNjt/ZRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8SqXXdJCwcOmXVpKiwCNqamdQUCrt9k2nWteTnZQVUDueLmZCA3FknFoq2MXcGGKb+gA+gLwCcJ+XwopRMdq0+1CqPxh59jhEgq/RdIt3Ic40kJvZ2HJg46pLVJqhc8qj4bcwlDhV3NkG2gE2POc/6QNzl000pupjb+RFjt3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bhmb8Ln9; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738913248; x=1770449248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HE30SIoV5NaVwKKtPZuNeev9GHJTlVEkkAQyXbEEw2Y=;
  b=bhmb8Ln9sWlirSnNo4l/fhe67n/CmrfowlQu54n1vz+ilHWv+Mz82yQN
   p5WdvCrO22hl5AlreaSILNODFKoEVCxVCuaztqdyMeO/8wmc9qWd+IoaK
   5ZhK0pdmOaNoKoDNWNL/L/xcDFu3LHoQdvbTVAOhCTyM9XP2blj5gFXgd
   0=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="375264730"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:27:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:51285]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.117:2525] with esmtp (Farcaster)
 id 7403ba95-a684-4463-b66b-72a812f89d51; Fri, 7 Feb 2025 07:27:26 +0000 (UTC)
X-Farcaster-Flow-ID: 7403ba95-a684-4463-b66b-72a812f89d51
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 07:27:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 07:27:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 5/8] net: fib_rules: Factorise fib_newrule() and fib_delrule().
Date: Fri, 7 Feb 2025 16:24:59 +0900
Message-ID: <20250207072502.87775-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207072502.87775-1-kuniyu@amazon.com>
References: <20250207072502.87775-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

fib_nl_newrule() / fib_nl_delrule() is the doit() handler for
RTM_NEWRULE / RTM_DELRULE but also called from vrf_newlink().

Currently, we hold RTNL on both paths but will not on the former.

Also, we set dev_net(dev)->rtnl to skb->sk in vrf_fib_rule() because
fib_nl_newrule() / fib_nl_delrule() fetch net as sock_net(skb->sk).

Let's Factorise the two functions and pass net and rtnl_held flag.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/vrf.c       |  6 ++----
 include/net/fib_rules.h |  8 ++++----
 net/core/fib_rules.c    | 36 +++++++++++++++++++++++-------------
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index ca81b212a246..5f21ce1013c4 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1537,14 +1537,12 @@ static int vrf_fib_rule(const struct net_device *dev, __u8 family, bool add_it)
 
 	nlmsg_end(skb, nlh);
 
-	/* fib_nl_{new,del}rule handling looks for net from skb->sk */
-	skb->sk = dev_net(dev)->rtnl;
 	if (add_it) {
-		err = fib_nl_newrule(skb, nlh, NULL);
+		err = fib_newrule(dev_net(dev), skb, nlh, NULL, true);
 		if (err == -EEXIST)
 			err = 0;
 	} else {
-		err = fib_nl_delrule(skb, nlh, NULL);
+		err = fib_delrule(dev_net(dev), skb, nlh, NULL, true);
 		if (err == -ENOENT)
 			err = 0;
 	}
diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index 04383d90a1e3..710caacad9da 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -178,10 +178,10 @@ int fib_rules_dump(struct net *net, struct notifier_block *nb, int family,
 		   struct netlink_ext_ack *extack);
 unsigned int fib_rules_seq_read(const struct net *net, int family);
 
-int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
-		   struct netlink_ext_ack *extack);
-int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
-		   struct netlink_ext_ack *extack);
+int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
+		struct netlink_ext_ack *extack, bool rtnl_held);
+int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
+		struct netlink_ext_ack *extack, bool rtnl_held);
 
 INDIRECT_CALLABLE_DECLARE(int fib6_rule_match(struct fib_rule *rule,
 					    struct flowi *fl, int flags));
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 694a8c2884a8..d68332d9cac6 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -783,15 +783,14 @@ static const struct nla_policy fib_rule_policy[FRA_MAX + 1] = {
 	[FRA_FLOWLABEL_MASK] = { .type = NLA_BE32 },
 };
 
-int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
-		   struct netlink_ext_ack *extack)
+int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
+		struct netlink_ext_ack *extack, bool rtnl_held)
 {
-	struct net *net = sock_net(skb->sk);
+	struct fib_rule *rule = NULL, *r, *last = NULL;
 	struct fib_rule_hdr *frh = nlmsg_data(nlh);
+	int err = -EINVAL, unresolved = 0;
 	struct fib_rules_ops *ops = NULL;
-	struct fib_rule *rule = NULL, *r, *last = NULL;
 	struct nlattr *tb[FRA_MAX + 1];
-	int err = -EINVAL, unresolved = 0;
 	bool user_priority = false;
 
 	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*frh))) {
@@ -893,18 +892,23 @@ int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	rules_ops_put(ops);
 	return err;
 }
-EXPORT_SYMBOL_GPL(fib_nl_newrule);
+EXPORT_SYMBOL_GPL(fib_newrule);
 
-int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
-		   struct netlink_ext_ack *extack)
+static int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
+			  struct netlink_ext_ack *extack)
 {
-	struct net *net = sock_net(skb->sk);
+	return fib_newrule(sock_net(skb->sk), skb, nlh, extack, true);
+}
+
+int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
+		struct netlink_ext_ack *extack, bool rtnl_held)
+{
+	struct fib_rule *rule = NULL, *nlrule = NULL;
 	struct fib_rule_hdr *frh = nlmsg_data(nlh);
 	struct fib_rules_ops *ops = NULL;
-	struct fib_rule *rule = NULL, *r, *nlrule = NULL;
 	struct nlattr *tb[FRA_MAX+1];
-	int err = -EINVAL;
 	bool user_priority = false;
+	int err = -EINVAL;
 
 	if (nlh->nlmsg_len < nlmsg_msg_size(sizeof(*frh))) {
 		NL_SET_ERR_MSG(extack, "Invalid msg length");
@@ -969,7 +973,7 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	 * current if it is goto rule, have actually been added.
 	 */
 	if (ops->nr_goto_rules > 0) {
-		struct fib_rule *n;
+		struct fib_rule *n, *r;
 
 		n = list_next_entry(rule, list);
 		if (&n->list == &ops->rules_list || n->pref != rule->pref)
@@ -998,7 +1002,13 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	rules_ops_put(ops);
 	return err;
 }
-EXPORT_SYMBOL_GPL(fib_nl_delrule);
+EXPORT_SYMBOL_GPL(fib_delrule);
+
+static int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
+			  struct netlink_ext_ack *extack)
+{
+	return fib_delrule(sock_net(skb->sk), skb, nlh, extack, true);
+}
 
 static inline size_t fib_rule_nlmsg_size(struct fib_rules_ops *ops,
 					 struct fib_rule *rule)
-- 
2.39.5 (Apple Git-154)


