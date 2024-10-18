Return-Path: <netdev+bounces-136787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19B9A3203
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006541F222D2
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A0551016;
	Fri, 18 Oct 2024 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IIVfxVrQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A653804
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214640; cv=none; b=nbTjWeapMSM/rTqKUlC0mFzq49Fbm4GP2/jNR2NLKpCYtC7bWfGEbddgWuiDLKWXkrGQVMHyLlaRzHgOTkKa3Hh4stTR/54Mc8jcFQnT1M7xa9ZPUI3qCLLdOYdcXo+4gitPkl64EDN9SuSqO4ngt7FUy7uT6Ft+SS4gJS2esLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214640; c=relaxed/simple;
	bh=FSo9iJkH4DtfAtSngABLB0H7cReaH+vYlCEL5cMtE9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAiaeE5puUaOT96LUyb+pcg2h9TR1IgB5lWvO1956n0cfNrjeFIz+dxv8V6dVqlS2fFtEL3sQV8anpugV2Yr7oTTYXvtF5x/CQSbijccDeXja3p96i4V57zH9XHdRew9EjeqSchTYSHYhw1G7NcBOYYNXBfJbU4U3wLJOsU3ArI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IIVfxVrQ; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214639; x=1760750639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cJliJZ0gFWBbzhYLZXGSYHYJk/pUmfRqYL88UTf2lEo=;
  b=IIVfxVrQEBwS3j68o51FO2O7tjqjptSWil36MymQWsJaaWsV4fiYpPLp
   VZtizRqFOn+G1fLWMft0O/ujVWUUQNJEdyxzw3HT5h5eib/J9JDvbbKgQ
   SQ0vs8NSJ98SEUnCt0n1WuNS2L16yFyHHy/jEGsKMwdvkiz4ds4xOIa6u
   k=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="767837077"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:23:52 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:60675]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id c26fb830-8a5c-4ca5-9474-3a5d0a2c928d; Fri, 18 Oct 2024 01:23:52 +0000 (UTC)
X-Farcaster-Flow-ID: c26fb830-8a5c-4ca5-9474-3a5d0a2c928d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:23:51 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:23:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/11] ipv4: Convert RTM_NEWADDR to per-netns RTNL.
Date: Thu, 17 Oct 2024 18:22:18 -0700
Message-ID: <20241018012225.90409-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241018012225.90409-1-kuniyu@amazon.com>
References: <20241018012225.90409-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The address hash table and GC are already namespacified.

Let's push down RTNL into inet_rtm_newaddr() as rtnl_net_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 636df3661963..6abafdd20b3c 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -959,8 +959,6 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct in_ifaddr *ifa;
 	int ret;
 
-	ASSERT_RTNL();
-
 	ret = inet_validate_rtm(nlh, tb, extack, &valid_lft, &prefered_lft);
 	if (ret < 0)
 		return ret;
@@ -968,9 +966,13 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!nla_get_in_addr(tb[IFA_LOCAL]))
 		return 0;
 
+	rtnl_net_lock(net);
+
 	ifa = inet_rtm_to_ifa(net, nlh, tb, extack);
-	if (IS_ERR(ifa))
-		return PTR_ERR(ifa);
+	if (IS_ERR(ifa)) {
+		ret = PTR_ERR(ifa);
+		goto unlock;
+	}
 
 	ifa_existing = find_matching_ifa(ifa);
 	if (!ifa_existing) {
@@ -983,11 +985,11 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			if (ret < 0) {
 				NL_SET_ERR_MSG(extack, "ipv4: Multicast auto join failed");
 				inet_free_ifa(ifa);
-				return ret;
+				goto unlock;
 			}
 		}
-		return __inet_insert_ifa(ifa, nlh, NETLINK_CB(skb).portid,
-					 extack);
+
+		ret = __inet_insert_ifa(ifa, nlh, NETLINK_CB(skb).portid, extack);
 	} else {
 		u32 new_metric = ifa->ifa_rt_priority;
 		u8 new_proto = ifa->ifa_proto;
@@ -997,7 +999,8 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (nlh->nlmsg_flags & NLM_F_EXCL ||
 		    !(nlh->nlmsg_flags & NLM_F_REPLACE)) {
 			NL_SET_ERR_MSG(extack, "ipv4: Address already assigned");
-			return -EEXIST;
+			ret = -EEXIST;
+			goto unlock;
 		}
 		ifa = ifa_existing;
 
@@ -1014,7 +1017,11 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 				   &net->ipv4.addr_chk_work, 0);
 		rtmsg_ifa(RTM_NEWADDR, ifa, nlh, NETLINK_CB(skb).portid);
 	}
-	return 0;
+
+unlock:
+	rtnl_net_unlock(net);
+
+	return ret;
 }
 
 /*
@@ -2808,7 +2815,8 @@ static struct rtnl_af_ops inet_af_ops __read_mostly = {
 };
 
 static const struct rtnl_msg_handler devinet_rtnl_msg_handlers[] __initconst = {
-	{.protocol = PF_INET, .msgtype = RTM_NEWADDR, .doit = inet_rtm_newaddr},
+	{.protocol = PF_INET, .msgtype = RTM_NEWADDR, .doit = inet_rtm_newaddr,
+	 .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_DELADDR, .doit = inet_rtm_deladdr},
 	{.protocol = PF_INET, .msgtype = RTM_GETADDR, .dumpit = inet_dump_ifaddr,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
-- 
2.39.5 (Apple Git-154)


