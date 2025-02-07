Return-Path: <netdev+bounces-163840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB742A2BC3C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4351888CD8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CA1A2544;
	Fri,  7 Feb 2025 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nRnWfN/Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347D1A23BC
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913275; cv=none; b=J/tI+SxpAhMAtje+44Y/9RMubCDFL5qpJ/ER0Jqfvuo69lOIckJDnqIZFDd5rkeqpX6N4GcqnmuihTrDI1+sBqfx3t2TcjtqrMNbydZ7dg/dTN191ccoxydY+3k7ay+jm2UqCmAPm/Qrp+YMJ/ERF/CPbJ32WW24+c9FDgyBG/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913275; c=relaxed/simple;
	bh=5is2ubP5uAWhhiqrfuxRKlD2aWDVdAqZMd5hysxKKbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PgRDxRs31SlS1eJMypcFlkklPrpr8+7T3o3Usa2btBVRSGJLItns+kDBv7L8NATOf8XXpEGKDjO5kdyp1Rl61LvYVQCYARKxzW5QfN+9A+jkl9W5R7zwQGXAv0AolQGrLZHVVy09S2s02FiYBi6UvrrNR90BKzt0JYb4yqc4820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nRnWfN/Q; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738913274; x=1770449274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EsaWzkAK83WZE9EpkOFv9yeybZJ5wbbLOrwIBj9tjrk=;
  b=nRnWfN/QH4WSlRYxJFIyjDUSi6SLZfMWpJiKECF9oVnTjX+Ug8PTD+JF
   lnpVlgkkJc7GTqXssHrozY/D9wuIXKvzmEIidp7xRWztJGCAzhqVG0J9d
   QmgbBdTOiypvifCqke/h1s9v3N5Q/BU0iKX8XKu0ibuJt7karI2fzk4BV
   U=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="20517885"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:27:54 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:30210]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id 6b7f16e8-be28-4898-8500-a7ded1e2bdc3; Fri, 7 Feb 2025 07:27:52 +0000 (UTC)
X-Farcaster-Flow-ID: 6b7f16e8-be28-4898-8500-a7ded1e2bdc3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 07:27:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 07:27:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 6/8] net: fib_rules: Convert RTM_NEWRULE to per-netns RTNL.
Date: Fri, 7 Feb 2025 16:25:00 +0900
Message-ID: <20250207072502.87775-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

fib_nl_newrule() is the doit() handler for RTM_NEWRULE but also called
from vrf_newlink().

In the latter case, RTNL is already held and the 4th arg is true.

Let's hold per-netns RTNL in fib_newrule() if rtnl_held is false.

Note that we call fib_rule_get() before releasing per-netns RTNL to call
notify_rule_change() without RTNL and prevent freeing the new rule.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index d68332d9cac6..d0995ea9d852 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -816,6 +816,9 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto errout;
 
+	if (!rtnl_held)
+		rtnl_net_lock(net);
+
 	err = fib_nl2rule_rtnl(rule, ops, tb, extack);
 	if (err)
 		goto errout_free;
@@ -881,12 +884,20 @@ int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (rule->tun_id)
 		ip_tunnel_need_metadata();
 
+	fib_rule_get(rule);
+
+	if (!rtnl_held)
+		rtnl_net_unlock(net);
+
 	notify_rule_change(RTM_NEWRULE, rule, ops, nlh, NETLINK_CB(skb).portid);
+	fib_rule_put(rule);
 	flush_route_cache(ops);
 	rules_ops_put(ops);
 	return 0;
 
 errout_free:
+	if (!rtnl_held)
+		rtnl_net_unlock(net);
 	kfree(rule);
 errout:
 	rules_ops_put(ops);
@@ -897,7 +908,7 @@ EXPORT_SYMBOL_GPL(fib_newrule);
 static int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct netlink_ext_ack *extack)
 {
-	return fib_newrule(sock_net(skb->sk), skb, nlh, extack, true);
+	return fib_newrule(sock_net(skb->sk), skb, nlh, extack, false);
 }
 
 int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
@@ -1320,7 +1331,8 @@ static struct pernet_operations fib_rules_net_ops = {
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


