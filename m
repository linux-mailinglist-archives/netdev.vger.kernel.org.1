Return-Path: <netdev+bounces-170560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 148A5A49056
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 05:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2035E16D9DC
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 04:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454881A2643;
	Fri, 28 Feb 2025 04:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CxjwX6u+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FBF19993D
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 04:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740716926; cv=none; b=rk4w6zsOpKHINJ0uf6/CZZrSAuQBMFCXt9+ObAg4Po2VY7hqhZgxbqYUosfR4xCi5QdyE3Ss4DhU9LbW/OginZg5J9pnZOyUyI23m1G/0ZS1fMkFAp2tQqxTpy8s3eedZQLLL2M6nOgBmAp72/QaY9koTPfZrA3/PBjX/rS0DFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740716926; c=relaxed/simple;
	bh=DYLNc15BlrRffj122jBUwbgcb9K78wC16Lw9kX7+I24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQmX5FnKxcGDXJGzCqlkRkr+27dMJlv8ZangZsNvruR1I94ziY4RhiRN3fCoOjDxcWE9PMksqy0EcBmUi6hqyAXmALwa3Ve6XJ4Atrz9ei1kntU5ZAM2H1SibP3QVrtVq/s4VsvNnPCqOd5elDzncPSn3+6ITFhmDIcRJDZWKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CxjwX6u+; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740716924; x=1772252924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kf8u5XcjAnoIuZ7kLyNUIbgMumUWbXNNlHcydAYTiRM=;
  b=CxjwX6u+M9tdoJH6Vi58XrljJr1Qnk+9wQnZOkHf6tmiFhu8mN1j/uhD
   D4uxy7X4vwosVZKhOBYJVl9ndeo/SxYf2oQbcmj9BmI24cBmi9aTuLn78
   2wvmAR2+QDXP5bX5JqEw5kxqosvs/vwknTOKtNMDwLT6VSl0sR7zR6AnU
   0=;
X-IronPort-AV: E=Sophos;i="6.13,321,1732579200"; 
   d="scan'208";a="173991139"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:28:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:36414]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.141:2525] with esmtp (Farcaster)
 id e568552f-630c-44a8-84ab-5f0c4b0ab256; Fri, 28 Feb 2025 04:28:44 +0000 (UTC)
X-Farcaster-Flow-ID: e568552f-630c-44a8-84ab-5f0c4b0ab256
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:28:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Feb 2025 04:28:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 12/12] ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
Date: Thu, 27 Feb 2025 20:23:28 -0800
Message-ID: <20250228042328.96624-13-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250228042328.96624-1-kuniyu@amazon.com>
References: <20250228042328.96624-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We converted fib_info hash tables to per-netns one and now ready to
convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.

Let's hold rtnl_net_lock() in inet_rtm_newroute() and inet_rtm_delroute().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 net/ipv4/fib_frontend.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index a6372d934e45..6de77415b5b3 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -884,20 +884,24 @@ static int inet_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	rtnl_net_lock(net);
+
 	if (cfg.fc_nh_id && !nexthop_find_by_id(net, cfg.fc_nh_id)) {
 		NL_SET_ERR_MSG(extack, "Nexthop id does not exist");
 		err = -EINVAL;
-		goto errout;
+		goto unlock;
 	}
 
 	tb = fib_get_table(net, cfg.fc_table);
 	if (!tb) {
 		NL_SET_ERR_MSG(extack, "FIB table does not exist");
 		err = -ESRCH;
-		goto errout;
+		goto unlock;
 	}
 
 	err = fib_table_delete(net, tb, &cfg, extack);
+unlock:
+	rtnl_net_unlock(net);
 errout:
 	return err;
 }
@@ -914,15 +918,20 @@ static int inet_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
+	rtnl_net_lock(net);
+
 	tb = fib_new_table(net, cfg.fc_table);
 	if (!tb) {
 		err = -ENOBUFS;
-		goto errout;
+		goto unlock;
 	}
 
 	err = fib_table_insert(net, tb, &cfg, extack);
 	if (!err && cfg.fc_type == RTN_LOCAL)
 		net->ipv4.fib_has_custom_local_routes = true;
+
+unlock:
+	rtnl_net_unlock(net);
 errout:
 	return err;
 }
@@ -1683,9 +1692,9 @@ static struct pernet_operations fib_net_ops = {
 
 static const struct rtnl_msg_handler fib_rtnl_msg_handlers[] __initconst = {
 	{.protocol = PF_INET, .msgtype = RTM_NEWROUTE,
-	 .doit = inet_rtm_newroute},
+	 .doit = inet_rtm_newroute, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_DELROUTE,
-	 .doit = inet_rtm_delroute},
+	 .doit = inet_rtm_delroute, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_GETROUTE, .dumpit = inet_dump_fib,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
 };
-- 
2.39.5 (Apple Git-154)


