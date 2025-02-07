Return-Path: <netdev+bounces-163842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4820CA2BC40
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D1367A2B76
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DEF1A23BC;
	Fri,  7 Feb 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KgWMCR/D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4691A2645
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913331; cv=none; b=J/tJ4qUcTk3LSX16BX5ToVoem5G8W9003dkpaWt35UqpQ5NJo5BGJIpayU/D9GTJJ0srA80lMT1IQWWBsxWXKAZKVYys8ZXs3RSjkrl8Ll0Saiu+Dse/Nsw9Uczt9jNxqK7Mo8wV1Dtl31AXIyyaVYtNFBakrGHiI1RVSfoF+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913331; c=relaxed/simple;
	bh=PuIBWkrObSeCJrW3eid7cA7DPk6i66Hc6+wiUE2WBtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RxPqKuheOot9B2goLal8McLblb1ekf9IjsZfAKx1+QfG2VGGjojgPCIK6fSK5WV2wzLX8Y6sIlyJWdjOvigeenqSaVL8F7uZMh1fF25UzP07NaZDdtjOFi3YlDTKIcplUg/FVscXChjFAa5kHoWzm/qiMbhTWtmXrSA8/5OIH5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KgWMCR/D; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738913330; x=1770449330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8GxUUpslWPTGz1zUEwNOxegL8s599BJ4KziecfFmEmk=;
  b=KgWMCR/DJX5UQsA5hBBdry25gGDThpuZtLltoelill4+tpSVd8VMELPr
   6pV14cKmjobEUJkR7BWohlM0tmuGDC/2w255ENRhI3hzmksnWO9wHEY3s
   l65RpFWa651iiQVgxmAPE9TIxZ1iLwflOIeFVt3uXj6uaddniligksu/U
   U=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="695139055"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 07:28:47 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:26612]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.117:2525] with esmtp (Farcaster)
 id ea28b20e-3bd0-4d2f-a7f0-eb4835dbf6ac; Fri, 7 Feb 2025 07:28:46 +0000 (UTC)
X-Farcaster-Flow-ID: ea28b20e-3bd0-4d2f-a7f0-eb4835dbf6ac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 07:28:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 07:28:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Ido Schimmel <idosch@idosch.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 8/8] net: fib_rules: Convert RTM_DELRULE to per-netns RTNL.
Date: Fri, 7 Feb 2025 16:25:02 +0900
Message-ID: <20250207072502.87775-9-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

fib_nl_delrule() is the doit() handler for RTM_DELRULE but also called
from vrf_newlink() in case something fails in vrf_add_fib_rules().

In the latter case, RTNL is already held and the 4th arg is true.

Let's hold per-netns RTNL in fib_delrule() if rtnl_held is false.

Now we can place ASSERT_RTNL_NET() in call_fib_rule_notifiers().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/fib_rules.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 10a7336b8d44..5045affeac78 100644
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
@@ -944,6 +945,9 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err)
 		goto errout;
 
+	if (!rtnl_held)
+		rtnl_net_lock(net);
+
 	err = fib_nl2rule_rtnl(nlrule, ops, tb, extack);
 	if (err)
 		goto errout_free;
@@ -998,10 +1002,12 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 	}
 
-	call_fib_rule_notifiers(net, FIB_EVENT_RULE_DEL, rule, ops,
-				NULL);
-	notify_rule_change(RTM_DELRULE, rule, ops, nlh,
-			   NETLINK_CB(skb).portid);
+	call_fib_rule_notifiers(net, FIB_EVENT_RULE_DEL, rule, ops, NULL);
+
+	if (!rtnl_held)
+		rtnl_net_unlock(net);
+
+	notify_rule_change(RTM_DELRULE, rule, ops, nlh, NETLINK_CB(skb).portid);
 	fib_rule_put(rule);
 	flush_route_cache(ops);
 	rules_ops_put(ops);
@@ -1009,6 +1015,8 @@ int fib_delrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
 	return 0;
 
 errout_free:
+	if (!rtnl_held)
+		rtnl_net_unlock(net);
 	kfree(nlrule);
 errout:
 	rules_ops_put(ops);
@@ -1019,7 +1027,7 @@ EXPORT_SYMBOL_GPL(fib_delrule);
 static int fib_nl_delrule(struct sk_buff *skb, struct nlmsghdr *nlh,
 			  struct netlink_ext_ack *extack)
 {
-	return fib_delrule(sock_net(skb->sk), skb, nlh, extack, true);
+	return fib_delrule(sock_net(skb->sk), skb, nlh, extack, false);
 }
 
 static inline size_t fib_rule_nlmsg_size(struct fib_rules_ops *ops,
@@ -1334,7 +1342,8 @@ static struct pernet_operations fib_rules_net_ops = {
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


