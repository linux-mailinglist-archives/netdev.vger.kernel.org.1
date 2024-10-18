Return-Path: <netdev+bounces-136789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F79A3206
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D49C28035D
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98D3A1CD;
	Fri, 18 Oct 2024 01:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OnP11qsV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3E3BBC5
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214675; cv=none; b=bl3ptURwL+nUokonAbsN79mHaY/PodwJ+/UlxMX1ylNtXZ9780wa0Uf8n+5MA0azL33w84OH+0Hx/NzIokKxtOaNlY3jKkBIfVNOCHlooILK+tL4xtbZAKKqbbDZubJFwdeq9js6icFZlJ7b0jvuX9ISV8HTyqQNxrSimq0owqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214675; c=relaxed/simple;
	bh=f+ZnG8XO+K8eSeBb9dPJmFL3N1u5R+C8/6lKHbRwcQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJAkkiWVUCuq0j1zVgXaYaF+N/bBleRyxAIMYFFE1vSwJ5T1zqFGGJ0L0zjuFyNA9PciQX4gD46z0EDoE1xwVD6wL2m2UBR7IvkZ8aIaXkCzlpINt45xnK8IyjMpVMzcgDvYSEu380MKIj6Nf5Z3aave/H8cNyOJH24y3Z/V0aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OnP11qsV; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729214674; x=1760750674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QEVEjgaQP26R+DPy/iVYzCZMduqGsilYwmF+KQ5hmek=;
  b=OnP11qsVFNVJlEzypbONQva053vzqhpvNmMl687lNYfUcZpOiFXTzggL
   5aYih1YQsNbi3oeByhxO70EbaUzCALj32ZPsc2rOvXBUYopkEati0J3NI
   mGnbDHvsCQfMLDgPHROk2Enj7m/esXCahIbqru4UDs5BhJs1lUd3IqjpK
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="441778982"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:24:31 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:62554]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id ec78a740-50b3-45f7-9d90-5ed16703c33e; Fri, 18 Oct 2024 01:24:30 +0000 (UTC)
X-Farcaster-Flow-ID: ec78a740-50b3-45f7-9d90-5ed16703c33e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:24:29 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:24:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 06/11] ipv4: Convert RTM_DELADDR to per-netns RTNL.
Date: Thu, 17 Oct 2024 18:22:20 -0700
Message-ID: <20241018012225.90409-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's push down RTNL into inet_rtm_deladdr() as rtnl_net_lock().

Now, ip_mc_autojoin_config() is always called under per-netns RTNL,
so ASSERT_RTNL() can be replaced with ASSERT_RTNL_NET().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/devinet.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 4f94fc8f552d..cbda22eb8d06 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -630,7 +630,7 @@ static int ip_mc_autojoin_config(struct net *net, bool join,
 	struct sock *sk = net->ipv4.mc_autojoin_sk;
 	int ret;
 
-	ASSERT_RTNL();
+	ASSERT_RTNL_NET(net);
 
 	lock_sock(sk);
 	if (join)
@@ -656,22 +656,24 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct in_ifaddr *ifa;
 	int err;
 
-	ASSERT_RTNL();
-
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFA_MAX,
 				     ifa_ipv4_policy, extack);
 	if (err < 0)
-		goto errout;
+		goto out;
 
 	ifm = nlmsg_data(nlh);
+
+	rtnl_net_lock(net);
+
 	in_dev = inetdev_by_index(net, ifm->ifa_index);
 	if (!in_dev) {
 		NL_SET_ERR_MSG(extack, "ipv4: Device not found");
 		err = -ENODEV;
-		goto errout;
+		goto unlock;
 	}
 
-	for (ifap = &in_dev->ifa_list; (ifa = rtnl_dereference(*ifap)) != NULL;
+	for (ifap = &in_dev->ifa_list;
+	     (ifa = rtnl_net_dereference(net, *ifap)) != NULL;
 	     ifap = &ifa->ifa_next) {
 		if (tb[IFA_LOCAL] &&
 		    ifa->ifa_local != nla_get_in_addr(tb[IFA_LOCAL]))
@@ -687,13 +689,16 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 		if (ipv4_is_multicast(ifa->ifa_address))
 			ip_mc_autojoin_config(net, false, ifa);
+
 		__inet_del_ifa(in_dev, ifap, 1, nlh, NETLINK_CB(skb).portid);
-		return 0;
+		goto unlock;
 	}
 
 	NL_SET_ERR_MSG(extack, "ipv4: Address not found");
 	err = -EADDRNOTAVAIL;
-errout:
+unlock:
+	rtnl_net_unlock(net);
+out:
 	return err;
 }
 
@@ -2817,7 +2822,8 @@ static struct rtnl_af_ops inet_af_ops __read_mostly = {
 static const struct rtnl_msg_handler devinet_rtnl_msg_handlers[] __initconst = {
 	{.protocol = PF_INET, .msgtype = RTM_NEWADDR, .doit = inet_rtm_newaddr,
 	 .flags = RTNL_FLAG_DOIT_PERNET},
-	{.protocol = PF_INET, .msgtype = RTM_DELADDR, .doit = inet_rtm_deladdr},
+	{.protocol = PF_INET, .msgtype = RTM_DELADDR, .doit = inet_rtm_deladdr,
+	 .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_GETADDR, .dumpit = inet_dump_ifaddr,
 	 .flags = RTNL_FLAG_DUMP_UNLOCKED | RTNL_FLAG_DUMP_SPLIT_NLM_DONE},
 	{.protocol = PF_INET, .msgtype = RTM_GETNETCONF,
-- 
2.39.5 (Apple Git-154)


