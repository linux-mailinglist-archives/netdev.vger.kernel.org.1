Return-Path: <netdev+bounces-130686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E7E98B295
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 04:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B471C25C1A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 02:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E454645;
	Tue,  1 Oct 2024 02:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dxoeAluI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C214F883
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727751036; cv=none; b=ov1wXaD0vCX6j89L5l+CeVrlf3pGyNRgG/Pv0QDAUoQLnWMzMpwznvuZ3Lks8ObTRbVSfwM8OdaL2Z4zJQIg+WeZ1cc/jDgFrF7pUM6Tr4CvedGfkiY4SLF3uAfb87V8YI3CxUXbOYqJltDMExvPTUp6j3mleEeeULKiqVqPsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727751036; c=relaxed/simple;
	bh=q+bdNpAxd6hgCql1hkb/jPYaQH3RXzTUvHYI6F4BTmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ae7QWhY4pWkN8RVigipX63VLsTC7Yjw7zG8gqp0zXSpat/M4cYt8dfrDU/LQcMipXOUvP1szYqfCNFDW1sh6+0NoHW7fIlJ/7y8q8EmANKDf5fPw94ufnXBJWkVXsL0WKEqLDQWdwu1aKmPVAv6DotPmEKRjYaeq9XDHyVtiHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dxoeAluI; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727751034; x=1759287034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehBbqGnYqTFVCQZutQ3QPyYNUDMNo3ikdRIJD8yR/wI=;
  b=dxoeAluISytnqH5TamnlS1XU7LMF0FEMYM1EMIWXCjAWbwhULEXD6ZDl
   cK57IcMmhyWBzoOwxeGBBDIMQ/9cNa/OL2KJnY56l9LNjwgYAC69yHXEI
   ZXSoLV4XZGxMeTGWOkSpOl8rBFSu7nep/PHqFEW5km6lvHrgXR1+i8m4P
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="427833935"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 02:50:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:2172]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.100:2525] with esmtp (Farcaster)
 id bef925d5-940a-4762-9222-096d60e5b767; Tue, 1 Oct 2024 02:50:29 +0000 (UTC)
X-Farcaster-Flow-ID: bef925d5-940a-4762-9222-096d60e5b767
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 02:50:29 +0000
Received: from 88665a182662.ant.amazon.com (10.1.212.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 02:50:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/5] ipv4: Namespacify IPv4 address GC.
Date: Tue, 1 Oct 2024 05:48:35 +0300
Message-ID: <20241001024837.96425-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Each IPv4 address could have a lifetime, which is useful for DHCP,
and GC is periodically executed as check_lifetime_work.

check_lifetime() does the actual GC under RTNL.

  1. Acquire RTNL
  2. Iterate inet_addr_lst
  3. Remove IPv4 address if expired
  4. Release RTNL

Namespacifying the GC is required for per-net RTNL, but using the
per-net hash table will shorten the time on the hash bucket iteration
under RTNL.

Let's add per-net GC work and use the per-net hash table.

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


