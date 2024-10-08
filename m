Return-Path: <netdev+bounces-133230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9C9955A7
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE901F21A3B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF331FCC78;
	Tue,  8 Oct 2024 17:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Pyhy3HZj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9A1FCC7A
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408633; cv=none; b=KtRktQZ4w4o5vqPjgZn/Rr2ECO9UC7jneOVor+6Q4C95+hNTQb/VelD0UAwZkOUozWCfb/Tz0jiIqEjLkU/uxo+esw0KlnchuR74WrlSPbyuPGM9SKXZVyktqBgGmFzNxX8XiHaXSfEZ3bSyeLaptoUgkza0LLYfvv3mKr8AorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408633; c=relaxed/simple;
	bh=43yeFm/o0y6KSlj3p9WiCHzeviNPHb1XbUXkpcW4JDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHBfU0M48qOcJ7p18PPtaA+40AQCthgtjNerX2VjV/FtTpSWx9EvV7ndine1G2U30QycSPBWCsrnJay9/MHEh/BszFGXVQDUQHs11Mk8thzLnXZ3nooi7INR6jtrXcToNZhHZGa+oPFXf4P3TeAG8WNx6lO7FClhYFvR4lJLHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Pyhy3HZj; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728408632; x=1759944632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NBvsANyGHUcwoPCqQBtkeHAiCC2XNq1H+0IF/aqEurk=;
  b=Pyhy3HZjAy7pGoGGdnc8LP80qA7YB/kpxwlLbPj4CqyCbZW6z81kyywA
   jE/F6VWrmvviTFrXDKxIz2E/rc7MViZpvlyxyrTeEw145O/FjtcmwG/bs
   2rz3ckAqgX30QHAXlPYaDJfFqT74fJu3aXfA6CeUKiuT6mN1fN71cbt7a
   A=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="136740163"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 17:30:30 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:61451]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id 8dd8d682-e08b-4029-8c53-b547fbf4d93d; Tue, 8 Oct 2024 17:30:30 +0000 (UTC)
X-Farcaster-Flow-ID: 8dd8d682-e08b-4029-8c53-b547fbf4d93d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 17:30:29 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 17:30:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 3/4] ipv4: Namespacify IPv4 address GC.
Date: Tue, 8 Oct 2024 10:29:05 -0700
Message-ID: <20241008172906.1326-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008172906.1326-1-kuniyu@amazon.com>
References: <20241008172906.1326-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC003.ant.amazon.com (10.13.139.240) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Each IPv4 address could have a lifetime, which is useful for DHCP,
and GC is periodically executed as check_lifetime_work.

check_lifetime() does the actual GC under RTNL.

  1. Acquire RTNL
  2. Iterate inet_addr_lst
  3. Remove IPv4 address if expired
  4. Release RTNL

Namespacifying the GC is required for per-netns RTNL, but using the
per-netns hash table will shorten the time on the hash bucket iteration
under RTNL.

Let's add per-netns GC work and use the per-netns hash table.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/netns/ipv4.h |  1 +
 net/ipv4/devinet.c       | 32 ++++++++++++++++++--------------
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 29eba2eaaa26..66a4cffc44ee 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -271,5 +271,6 @@ struct netns_ipv4 {
 	atomic_t	rt_genid;
 	siphash_key_t	ip_id_key;
 	struct hlist_head	*inet_addr_lst;
+	struct delayed_work	addr_chk_work;
 };
 #endif
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index cf47b5ac061f..ac245944e89e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -486,15 +486,12 @@ static void inet_del_ifa(struct in_device *in_dev,
 	__inet_del_ifa(in_dev, ifap, destroy, NULL, 0);
 }
 
-static void check_lifetime(struct work_struct *work);
-
-static DECLARE_DELAYED_WORK(check_lifetime_work, check_lifetime);
-
 static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 			     u32 portid, struct netlink_ext_ack *extack)
 {
 	struct in_ifaddr __rcu **last_primary, **ifap;
 	struct in_device *in_dev = ifa->ifa_dev;
+	struct net *net = dev_net(in_dev->dev);
 	struct in_validator_info ivi;
 	struct in_ifaddr *ifa1;
 	int ret;
@@ -563,8 +560,8 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 
 	inet_hash_insert(dev_net(in_dev->dev), ifa);
 
-	cancel_delayed_work(&check_lifetime_work);
-	queue_delayed_work(system_power_efficient_wq, &check_lifetime_work, 0);
+	cancel_delayed_work(&net->ipv4.addr_chk_work);
+	queue_delayed_work(system_power_efficient_wq, &net->ipv4.addr_chk_work, 0);
 
 	/* Send message first, then call notifier.
 	   Notifier will trigger FIB update, so that
@@ -710,16 +707,19 @@ static void check_lifetime(struct work_struct *work)
 	unsigned long now, next, next_sec, next_sched;
 	struct in_ifaddr *ifa;
 	struct hlist_node *n;
+	struct net *net;
 	int i;
 
+	net = container_of(to_delayed_work(work), struct net, ipv4.addr_chk_work);
 	now = jiffies;
 	next = round_jiffies_up(now + ADDR_CHECK_FREQUENCY);
 
 	for (i = 0; i < IN4_ADDR_HSIZE; i++) {
+		struct hlist_head *head = &net->ipv4.inet_addr_lst[i];
 		bool change_needed = false;
 
 		rcu_read_lock();
-		hlist_for_each_entry_rcu(ifa, &inet_addr_lst[i], hash) {
+		hlist_for_each_entry_rcu(ifa, head, addr_lst) {
 			unsigned long age, tstamp;
 			u32 preferred_lft;
 			u32 valid_lft;
@@ -757,7 +757,7 @@ static void check_lifetime(struct work_struct *work)
 		if (!change_needed)
 			continue;
 		rtnl_lock();
-		hlist_for_each_entry_safe(ifa, n, &inet_addr_lst[i], hash) {
+		hlist_for_each_entry_safe(ifa, n, head, addr_lst) {
 			unsigned long age;
 
 			if (ifa->ifa_flags & IFA_F_PERMANENT)
@@ -806,8 +806,8 @@ static void check_lifetime(struct work_struct *work)
 	if (time_before(next_sched, now + ADDRCONF_TIMER_FUZZ_MAX))
 		next_sched = now + ADDRCONF_TIMER_FUZZ_MAX;
 
-	queue_delayed_work(system_power_efficient_wq, &check_lifetime_work,
-			next_sched - now);
+	queue_delayed_work(system_power_efficient_wq, &net->ipv4.addr_chk_work,
+			   next_sched - now);
 }
 
 static void set_ifa_lifetime(struct in_ifaddr *ifa, __u32 valid_lft,
@@ -1004,9 +1004,9 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 		ifa->ifa_proto = new_proto;
 
 		set_ifa_lifetime(ifa, valid_lft, prefered_lft);
-		cancel_delayed_work(&check_lifetime_work);
+		cancel_delayed_work(&net->ipv4.addr_chk_work);
 		queue_delayed_work(system_power_efficient_wq,
-				&check_lifetime_work, 0);
+				   &net->ipv4.addr_chk_work, 0);
 		rtmsg_ifa(RTM_NEWADDR, ifa, nlh, NETLINK_CB(skb).portid);
 	}
 	return 0;
@@ -2743,6 +2743,8 @@ static __net_init int devinet_init_net(struct net *net)
 	for (i = 0; i < IN4_ADDR_HSIZE; i++)
 		INIT_HLIST_HEAD(&net->ipv4.inet_addr_lst[i]);
 
+	INIT_DEFERRABLE_WORK(&net->ipv4.addr_chk_work, check_lifetime);
+
 	net->ipv4.devconf_all = all;
 	net->ipv4.devconf_dflt = dflt;
 	return 0;
@@ -2769,7 +2771,11 @@ static __net_exit void devinet_exit_net(struct net *net)
 {
 #ifdef CONFIG_SYSCTL
 	const struct ctl_table *tbl;
+#endif
+
+	cancel_delayed_work_sync(&net->ipv4.addr_chk_work);
 
+#ifdef CONFIG_SYSCTL
 	tbl = net->ipv4.forw_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.forw_hdr);
 	__devinet_sysctl_unregister(net, net->ipv4.devconf_dflt,
@@ -2806,8 +2812,6 @@ void __init devinet_init(void)
 	register_pernet_subsys(&devinet_ops);
 	register_netdevice_notifier(&ip_netdev_notifier);
 
-	queue_delayed_work(system_power_efficient_wq, &check_lifetime_work, 0);
-
 	rtnl_af_register(&inet_af_ops);
 
 	rtnl_register(PF_INET, RTM_NEWADDR, inet_rtm_newaddr, NULL, 0);
-- 
2.30.2


