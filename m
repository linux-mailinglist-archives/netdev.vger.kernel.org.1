Return-Path: <netdev+bounces-163837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD2A2BC39
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF77A3A6298
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A93F1A23BC;
	Fri,  7 Feb 2025 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oSdinGXp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91B1898F8
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913198; cv=none; b=V1wjrtDPFzB+ksmCDLS2QuwAfRFezNMy8VJG9wm8JlFnVQqXMIOcM+kP1JszW6i5uaF//B7bHDDhYwHskc7oU6lV4nX37DwQ4laxqw0iEDcWOJR8P/1vHTJ7FbP1oBaIcVwIlZqiytXzZQp0ihPgNaFZ3fahxOAsyTqQZ0XA4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913198; c=relaxed/simple;
	bh=cYhOQ/3UJBOKDoPuU8kvn7DAsDlzarz4iNrYnu1HbUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcJcCMtcMo8qs+sTPZjLaHP6nUvLbwUYV+SF7+zPnFXUgTMDkeGKaphM4ZALzIqTwmZsJdXwr3VcjN/Ozax4Jqm4l8P5+EkF80b3Ll0NEplWdPXqpzGIeRVCPPbQpQOBJHPdQbQaDxclASialJsouK90JPf03RPzlNzO0VWUoV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oSdinGXp; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738913197; x=1770449197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=whPzkE4DuMR9tjYvUgzksMF5c7Irk3CnnY+oNpdtivk=;
  b=oSdinGXpBrpsmhj64G4M7iYKvkNiJvY9XwxYFihOtHgKsQaEBG9RiLMQ
   GE2vUU15BSb9uY5wJsWbmy23at+xf5hKsYWmdsw6gxlTWx3Es7WMom/a/
   WffdPIcKu6352PdV1Hn6bXqjz4WTzJ+g94iv6VVK0B8oSatCqWkehhKlt
   E=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="460448869"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:26:35 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:35244]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.44:2525] with esmtp (Farcaster)
 id b53726b3-b94b-4533-b39c-64f918d80364; Fri, 7 Feb 2025 07:26:34 +0000 (UTC)
X-Farcaster-Flow-ID: b53726b3-b94b-4533-b39c-64f918d80364
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 07:26:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 07:26:30 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/8] net: fib_rules: Split fib_nl2rule().
Date: Fri, 7 Feb 2025 16:24:57 +0900
Message-ID: <20250207072502.87775-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will move RTNL down to fib_nl_newrule() and fib_nl_delrule().

Some operations in fib_nl2rule() require RTNL: fib_default_rule_pref()
and __dev_get_by_name().

Let's split the RTNL parts as fib_nl2rule_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 58 +++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 87f731199538..694a8c2884a8 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -550,30 +550,18 @@ static int fib_nl2rule(struct net *net, struct nlmsghdr *nlh,
 	if (tb[FRA_PRIORITY]) {
 		nlrule->pref = nla_get_u32(tb[FRA_PRIORITY]);
 		*user_priority = true;
-	} else {
-		nlrule->pref = fib_default_rule_pref(ops);
 	}
 
 	nlrule->proto = nla_get_u8_default(tb[FRA_PROTOCOL], RTPROT_UNSPEC);
 
 	if (tb[FRA_IIFNAME]) {
-		struct net_device *dev;
-
 		nlrule->iifindex = -1;
 		nla_strscpy(nlrule->iifname, tb[FRA_IIFNAME], IFNAMSIZ);
-		dev = __dev_get_by_name(net, nlrule->iifname);
-		if (dev)
-			nlrule->iifindex = dev->ifindex;
 	}
 
 	if (tb[FRA_OIFNAME]) {
-		struct net_device *dev;
-
 		nlrule->oifindex = -1;
 		nla_strscpy(nlrule->oifname, tb[FRA_OIFNAME], IFNAMSIZ);
-		dev = __dev_get_by_name(net, nlrule->oifname);
-		if (dev)
-			nlrule->oifindex = dev->ifindex;
 	}
 
 	if (tb[FRA_FWMARK]) {
@@ -615,11 +603,6 @@ static int fib_nl2rule(struct net *net, struct nlmsghdr *nlh,
 		}
 
 		nlrule->target = nla_get_u32(tb[FRA_GOTO]);
-		/* Backward jumps are prohibited to avoid endless loops */
-		if (nlrule->target <= nlrule->pref) {
-			NL_SET_ERR_MSG(extack, "Backward goto not supported");
-			goto errout_free;
-		}
 	} else if (nlrule->action == FR_ACT_GOTO) {
 		NL_SET_ERR_MSG(extack, "Missing goto target for action goto");
 		goto errout_free;
@@ -679,6 +662,39 @@ static int fib_nl2rule(struct net *net, struct nlmsghdr *nlh,
 	return err;
 }
 
+static int fib_nl2rule_rtnl(struct fib_rule *nlrule,
+			    struct fib_rules_ops *ops,
+			    struct nlattr *tb[],
+			    struct netlink_ext_ack *extack)
+{
+	if (!tb[FRA_PRIORITY])
+		nlrule->pref = fib_default_rule_pref(ops);
+
+	/* Backward jumps are prohibited to avoid endless loops */
+	if (tb[FRA_GOTO] && nlrule->target <= nlrule->pref) {
+		NL_SET_ERR_MSG(extack, "Backward goto not supported");
+		return -EINVAL;
+	}
+
+	if (tb[FRA_IIFNAME]) {
+		struct net_device *dev;
+
+		dev = __dev_get_by_name(nlrule->fr_net, nlrule->iifname);
+		if (dev)
+			nlrule->iifindex = dev->ifindex;
+	}
+
+	if (tb[FRA_OIFNAME]) {
+		struct net_device *dev;
+
+		dev = __dev_get_by_name(nlrule->fr_net, nlrule->oifname);
+		if (dev)
+			nlrule->oifindex = dev->ifindex;
+	}
+
+	return 0;
+}
+
 static int rule_exists(struct fib_rules_ops *ops, struct fib_rule_hdr *frh,
 		       struct nlattr **tb, struct fib_rule *rule)
 {
@@ -801,6 +817,10 @@ int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto errout;
 
+	err = fib_nl2rule_rtnl(rule, ops, tb, extack);
+	if (err)
+		goto errout_free;
+
 	if ((nlh->nlmsg_flags & NLM_F_EXCL) &&
 	    rule_exists(ops, frh, tb, rule)) {
 		err = -EEXIST;
@@ -909,6 +929,10 @@ int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto errout;
 
+	err = fib_nl2rule_rtnl(nlrule, ops, tb, extack);
+	if (err)
+		goto errout;
+
 	rule = rule_find(ops, frh, tb, nlrule, user_priority);
 	if (!rule) {
 		err = -ENOENT;
-- 
2.39.5 (Apple Git-154)


