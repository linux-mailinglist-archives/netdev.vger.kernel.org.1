Return-Path: <netdev+bounces-132224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD4799108F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F482B28A4B
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94811DD9D9;
	Fri,  4 Oct 2024 20:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Qm8JmgdL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87041DDA07
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 20:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072087; cv=none; b=Cb0q68o3weIOD6xzdKeM/MUPR9H+5xFI0j2f7frIUpykIl6CVdL3x3byVYN2e46V6Cz7KL9n3KD1jKs1ODcYrtssU75ENxJj1KZlMOJC4UAl05Yx27mTXHAycryJeWhFDEoxOp7P/qIt/mh76FYGB9MzcKxiKTsObp/csXGhCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072087; c=relaxed/simple;
	bh=43yeFm/o0y6KSlj3p9WiCHzeviNPHb1XbUXkpcW4JDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0zf3zUusc88BRjPszDjuZbaQN55bioQacAhbJp6fHeAiqGKaxlZeV8qj3Za8DpnIOgGFqhAHnjJhyzKuMzUQALNiL7oFeh7m1blNz8gI8glxoI57T5KvGwZaQ3CmgQ4bX8b+RrN0F20wjKDb5L3NcHGudDjzK5c6jpivju6NWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Qm8JmgdL; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728072086; x=1759608086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NBvsANyGHUcwoPCqQBtkeHAiCC2XNq1H+0IF/aqEurk=;
  b=Qm8JmgdLQbm9Des3XC7LtPXwsBIpdTS/o/vpctCJvuBzwxLAHccuHUDd
   AS7e5MfkM50eZCC8Ry/hcKZt7uGUx/+JomUJ1O9G7Xrvoie5EPSQmaXfn
   +2CaV8U83oWREeoW/uf1s84IifK0uSvaHsPPaiSUM27MkLN+Fv7lQYXN1
   4=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="432676100"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 20:01:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:25562]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.198:2525] with esmtp (Farcaster)
 id 4ee6adc9-0296-4d78-9f5c-866fca1d5ce3; Fri, 4 Oct 2024 20:01:22 +0000 (UTC)
X-Farcaster-Flow-ID: 4ee6adc9-0296-4d78-9f5c-866fca1d5ce3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 20:01:21 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 20:01:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/4] ipv4: Namespacify IPv4 address GC.
Date: Fri, 4 Oct 2024 12:59:57 -0700
Message-ID: <20241004195958.64396-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004195958.64396-1-kuniyu@amazon.com>
References: <20241004195958.64396-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
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


