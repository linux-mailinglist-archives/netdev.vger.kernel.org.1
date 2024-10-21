Return-Path: <netdev+bounces-137608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B6F9A726B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D802810FF
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222C51F9419;
	Mon, 21 Oct 2024 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I5Du5vJI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43895A41
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535664; cv=none; b=lrRDk0xhVTseqr2Ys/Zquo4vojtyqO8n8INFYSVd7GdHqNFileMkcgu1QIZrDz238al5dxwiRUl7oukyirw7PrEEjL6VSsEefbgX92dCfRS2ea5elJQZUYMeH7e/CMkvO2MD9uxZeSt3xBIO9LQty8RxfJc8TxHqmmaniWsRDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535664; c=relaxed/simple;
	bh=+n4/VJEjXiLSe9RqndPMbi5v9Ld5ezeyKEZtpJur7vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdcN9jRVGyYWLbAcFmqVWYDrQrkSfEJqwb6bhh7vrNCCfuygixALGxE9rZflWLxUanlKNnXhKrpHqJjp34TvP1EbOae+h3OVEgAkzuz+Dv86N7hrG2MtXONazjHh+zPIO8dVnd4hq9ri26r/4qA9EM5L1+q420A2hBMgso6CleQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=I5Du5vJI; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535662; x=1761071662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B0i5h6+nm4bx0lWglBEFpP5xu+wpbdozY698Q1oxVFM=;
  b=I5Du5vJI2TFvrqP+iG5BN8AXFqmMYmhdCgMuehAyFqiuXcu2wAP2X139
   IqQHGZN/laEhw2ACbPGOxEwwCYqLyGghGhxyQ2EoGnNC6BGwG9yZvCptk
   gozNE+dXiV8hODoDHzZbvDZsaVtkMQqHPDVv9awLRjollHe1Bp+Y3WSdC
   0=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="140306217"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:34:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:35491]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.192:2525] with esmtp (Farcaster)
 id 911de188-7708-4651-b83a-5e7f20a3e762; Mon, 21 Oct 2024 18:34:21 +0000 (UTC)
X-Farcaster-Flow-ID: 911de188-7708-4651-b83a-5e7f20a3e762
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:34:20 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:34:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 05/12] ipv4: Convert RTM_NEWADDR to per-netns RTNL.
Date: Mon, 21 Oct 2024 11:32:32 -0700
Message-ID: <20241021183239.79741-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
References: <20241021183239.79741-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The address hash table and GC are already namespacified.

Let's push down RTNL into inet_rtm_newaddr() as rtnl_net_lock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/devinet.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 5e43f9f68e4a..d5050c1bf157 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -974,8 +974,6 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct in_ifaddr *ifa;
 	int ret;
 
-	ASSERT_RTNL();
-
 	ret = inet_validate_rtm(nlh, tb, extack, &valid_lft, &prefered_lft);
 	if (ret < 0)
 		return ret;
@@ -983,9 +981,13 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -998,11 +1000,11 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -1012,7 +1014,8 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (nlh->nlmsg_flags & NLM_F_EXCL ||
 		    !(nlh->nlmsg_flags & NLM_F_REPLACE)) {
 			NL_SET_ERR_MSG(extack, "ipv4: Address already assigned");
-			return -EEXIST;
+			ret = -EEXIST;
+			goto unlock;
 		}
 		ifa = ifa_existing;
 
@@ -1029,7 +1032,11 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -2823,7 +2830,8 @@ static struct rtnl_af_ops inet_af_ops __read_mostly = {
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


