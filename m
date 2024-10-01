Return-Path: <netdev+bounces-130688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E131D98B298
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 04:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 111821C25EA9
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 02:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4535D915;
	Tue,  1 Oct 2024 02:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LNa/3Wzk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87F433A2
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727751099; cv=none; b=Gt3yCW7xTyaUZu4KUUsMsAjCm43DE3WAY+lZ1x+Dz/ecJdekTIHO3ISd/p9ywgIsmDFF7dHJgmeWuyZi7Tr+HZfuPYOGooPZGNJp6qmgyyygmR+zWmC0JbTL/z1rtvDXzob9E1eOFEL0gc0PPGa80lrHNF7Ly0IKgu+f97xmqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727751099; c=relaxed/simple;
	bh=f+25mNvpWEGZuResiOiwFm3krJUbIdhlRov4jxhwVS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZYOptHGi3usIb1F/J6+3JQtVBAUdWcuApULpM6h679BR5jMJppjjPLGXgQvuxMukj4y6v6kE+XaT3tt++olfUgkO9tkOGXSTdJv3L46SeX4Pj7L4SUU8+XN2lxbLTZPHWCyVC8ZpADnu86I0Uzzxocwe97jIjXOdLwsaHqk2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LNa/3Wzk; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727751097; x=1759287097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N8NK0DuLa+RBUqX50QSuzr3CBPqdGBNM05YDfGH+Gik=;
  b=LNa/3WzkJgPb/STATHpBxVNPps7Q5PEkwxozhfzfkM0Cz6vCetDEQsSK
   9PdWugSrKgLGF34IexEuMB86pw76wT6Y29jj41f06K/68DfpbfIS1fC45
   IHCL6ziiAG/aJ+3pYEB6Vaq2cdfMjcSqkcJFDz+t7pHdgRtEVI57G22Yo
   k=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="133234201"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 02:51:37 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:41849]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.107:2525] with esmtp (Farcaster)
 id 889ec91d-6cbc-43ca-b489-8cae9154dfd2; Tue, 1 Oct 2024 02:51:37 +0000 (UTC)
X-Farcaster-Flow-ID: 889ec91d-6cbc-43ca-b489-8cae9154dfd2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 02:51:36 +0000
Received: from 88665a182662.ant.amazon.com (10.1.212.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 02:51:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/5] ipv4: Trigger check_lifetime() only when necessary.
Date: Tue, 1 Oct 2024 05:48:37 +0300
Message-ID: <20241001024837.96425-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241001024837.96425-1-kuniyu@amazon.com>
References: <20241001024837.96425-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

DHCP is unlikely to be used in non-root network namespaces, and GC is
unnecessary in such cases.

Let's count the number of non-permanent IPv4 addresses and schedule GC
only when the count is not zero.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/netns/ipv4.h |  1 +
 net/ipv4/devinet.c       | 45 +++++++++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 66a4cffc44ee..e37001572111 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -272,5 +272,6 @@ struct netns_ipv4 {
 	siphash_key_t	ip_id_key;
 	struct hlist_head	*inet_addr_lst;
 	struct delayed_work	addr_chk_work;
+	unsigned int		addr_non_perm;
 };
 #endif
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 96fc4aacc539..2510d3ef3291 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -124,18 +124,38 @@ static u32 inet_addr_hash(const struct net *net, __be32 addr)
 	return hash_32(addr, IN4_ADDR_HSIZE_SHIFT);
 }
 
+static bool inet_ifa_has_lifetime(struct in_ifaddr *ifa)
+{
+	return !(ifa->ifa_flags & IFA_F_PERMANENT);
+}
+
 static void inet_hash_insert(struct net *net, struct in_ifaddr *ifa)
 {
 	u32 hash = inet_addr_hash(net, ifa->ifa_local);
 
 	ASSERT_RTNL();
 	hlist_add_head_rcu(&ifa->addr_lst, &net->ipv4.inet_addr_lst[hash]);
+
+	if (inet_ifa_has_lifetime(ifa)) {
+		WRITE_ONCE(net->ipv4.addr_non_perm, net->ipv4.addr_non_perm + 1);
+		cancel_delayed_work(&net->ipv4.addr_chk_work);
+		queue_delayed_work(system_power_efficient_wq,
+				   &net->ipv4.addr_chk_work, 0);
+	}
 }
 
 static void inet_hash_remove(struct in_ifaddr *ifa)
 {
 	ASSERT_RTNL();
 	hlist_del_init_rcu(&ifa->addr_lst);
+
+	if (inet_ifa_has_lifetime(ifa)) {
+		struct net *net = dev_net(ifa->ifa_dev->dev);
+
+		WRITE_ONCE(net->ipv4.addr_non_perm, net->ipv4.addr_non_perm - 1);
+		if (!net->ipv4.addr_non_perm)
+			cancel_delayed_work(&net->ipv4.addr_chk_work);
+	}
 }
 
 /**
@@ -484,7 +504,6 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 {
 	struct in_ifaddr __rcu **last_primary, **ifap;
 	struct in_device *in_dev = ifa->ifa_dev;
-	struct net *net = dev_net(in_dev->dev);
 	struct in_validator_info ivi;
 	struct in_ifaddr *ifa1;
 	int ret;
@@ -553,9 +572,6 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 
 	inet_hash_insert(dev_net(in_dev->dev), ifa);
 
-	cancel_delayed_work(&net->ipv4.addr_chk_work);
-	queue_delayed_work(system_power_efficient_wq, &net->ipv4.addr_chk_work, 0);
-
 	/* Send message first, then call notifier.
 	   Notifier will trigger FIB update, so that
 	   listeners of netlink will know about new ifaddr */
@@ -787,6 +803,9 @@ static void check_lifetime(struct work_struct *work)
 		rtnl_unlock();
 	}
 
+	if (!READ_ONCE(net->ipv4.addr_non_perm))
+		return;
+
 	next_sec = round_jiffies_up(next);
 	next_sched = next;
 
@@ -979,6 +998,7 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 	} else {
 		u32 new_metric = ifa->ifa_rt_priority;
 		u8 new_proto = ifa->ifa_proto;
+		int delta = 0;
 
 		inet_free_ifa(ifa);
 
@@ -996,10 +1016,21 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 		ifa->ifa_proto = new_proto;
 
+		if (inet_ifa_has_lifetime(ifa))
+			delta -= 1;
+
 		set_ifa_lifetime(ifa, valid_lft, prefered_lft);
-		cancel_delayed_work(&net->ipv4.addr_chk_work);
-		queue_delayed_work(system_power_efficient_wq,
-				   &net->ipv4.addr_chk_work, 0);
+
+		if (inet_ifa_has_lifetime(ifa))
+			delta += 1;
+
+		if (delta) {
+			WRITE_ONCE(net->ipv4.addr_non_perm, net->ipv4.addr_non_perm + delta);
+			cancel_delayed_work(&net->ipv4.addr_chk_work);
+			queue_delayed_work(system_power_efficient_wq,
+					   &net->ipv4.addr_chk_work, 0);
+		}
+
 		rtmsg_ifa(RTM_NEWADDR, ifa, nlh, NETLINK_CB(skb).portid);
 	}
 	return 0;
-- 
2.30.2


