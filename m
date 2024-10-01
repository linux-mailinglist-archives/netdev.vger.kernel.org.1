Return-Path: <netdev+bounces-130684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970A098B293
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 04:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA09F1C25C7D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 02:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C551C3E;
	Tue,  1 Oct 2024 02:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GiO9BEhg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651263B78D
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750970; cv=none; b=AUuDK309K6x5IFX3h360QUQ1pqbmKl3s08gQkVhRzbsQDBePb2n5Tf4MRP1MnT4A7JJuywIgAKubP3WQmS3SnxEezgE7spg5X5f/4cYaxXm2NXvAYILCqITAwwMTV28qygBAbJ64GJ/VuNe4vY7fzXdIN6m0U7fIKcuPvZTSle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750970; c=relaxed/simple;
	bh=aPypaMet8gQuRiKLY2AZJTtnVi61JtyVb/CjJKspRrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iN1kfDk45YF5cxYjKaWtMS5QVnfZ2VzAtgf0KoU3f29aVG0wtZKoE5T/V5ER6avqp5HcNV+eqzYMnMJGDfg5ItpghT4drKIfxTHSb9v8kUC34T0gTJk2RFNVTlT29X4NHAtrh7lWWVkTWOTu+d2vrf8auck9TRUhiF3jB6XKTos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GiO9BEhg; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727750969; x=1759286969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XiUyuTg4T/DHJbYNYSmoZg2vxYc9CVrMrJTAFZYrcHY=;
  b=GiO9BEhgGNDLoU1cmWdXtFKeuNSj9efhBJah5CeqLtCGbH1C3TwAB2Qg
   qYYH34aDuAQKsh8Ijs9a1hL5Yyco2V/YgJZ69VxDak9x9YB2oKCQ2fdJp
   rTBb3yO8woJWgTEZFkVj1HtBQ5rBCcjyOJX7MPOdD4HzYjx9YBM5o/KON
   s=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="133233538"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 02:49:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:11886]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.191:2525] with esmtp (Farcaster)
 id f970e763-9edc-439f-a920-bab77589027f; Tue, 1 Oct 2024 02:49:28 +0000 (UTC)
X-Farcaster-Flow-ID: f970e763-9edc-439f-a920-bab77589027f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 02:49:28 +0000
Received: from 88665a182662.ant.amazon.com (10.1.212.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 02:49:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/5] ipv4: Link IPv4 address to per-net hash table.
Date: Tue, 1 Oct 2024 05:48:33 +0300
Message-ID: <20241001024837.96425-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

As a prep for per-net RTNL conversion, we want to namespacify
the IPv4 address hash table and the GC work.

Let's allocate the per-net IPv4 address hash table to
net->ipv4.inet_addr_lst and link IPv4 addresses into it.

The actual users will be converted later.

Note that the IPv6 address hash table is already namespacified.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/inetdevice.h |  1 +
 include/net/netns/ipv4.h   |  1 +
 net/ipv4/devinet.c         | 22 +++++++++++++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index cb5280e6cc21..d0c2bf67a9b0 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -142,6 +142,7 @@ static inline void ipv4_devconf_setall(struct in_device *in_dev)
 
 struct in_ifaddr {
 	struct hlist_node	hash;
+	struct hlist_node	addr_lst;
 	struct in_ifaddr	__rcu *ifa_next;
 	struct in_device	*ifa_dev;
 	struct rcu_head		rcu_head;
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 276f622f3516..29eba2eaaa26 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -270,5 +270,6 @@ struct netns_ipv4 {
 
 	atomic_t	rt_genid;
 	siphash_key_t	ip_id_key;
+	struct hlist_head	*inet_addr_lst;
 };
 #endif
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index ab76744383cf..059807a627a6 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -134,11 +134,13 @@ static void inet_hash_insert(struct net *net, struct in_ifaddr *ifa)
 
 	ASSERT_RTNL();
 	hlist_add_head_rcu(&ifa->hash, &inet_addr_lst[hash]);
+	hlist_add_head_rcu(&ifa->addr_lst, &net->ipv4.inet_addr_lst[hash]);
 }
 
 static void inet_hash_remove(struct in_ifaddr *ifa)
 {
 	ASSERT_RTNL();
+	hlist_del_init_rcu(&ifa->addr_lst);
 	hlist_del_init_rcu(&ifa->hash);
 }
 
@@ -228,6 +230,7 @@ static struct in_ifaddr *inet_alloc_ifa(struct in_device *in_dev)
 	ifa->ifa_dev = in_dev;
 
 	INIT_HLIST_NODE(&ifa->hash);
+	INIT_HLIST_NODE(&ifa->addr_lst);
 
 	return ifa;
 }
@@ -2663,14 +2666,21 @@ static struct ctl_table ctl_forward_entry[] = {
 
 static __net_init int devinet_init_net(struct net *net)
 {
-	int err;
-	struct ipv4_devconf *all, *dflt;
 #ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
 	struct ctl_table_header *forw_hdr;
+	struct ctl_table *tbl;
 #endif
+	struct ipv4_devconf *all, *dflt;
+	int err;
+	int i;
 
 	err = -ENOMEM;
+	net->ipv4.inet_addr_lst = kmalloc_array(IN4_ADDR_HSIZE,
+						sizeof(struct hlist_head),
+						GFP_KERNEL);
+	if (!net->ipv4.inet_addr_lst)
+		goto err_alloc_hash;
+
 	all = kmemdup(&ipv4_devconf, sizeof(ipv4_devconf), GFP_KERNEL);
 	if (!all)
 		goto err_alloc_all;
@@ -2731,6 +2741,9 @@ static __net_init int devinet_init_net(struct net *net)
 	net->ipv4.forw_hdr = forw_hdr;
 #endif
 
+	for (i = 0; i < IN4_ADDR_HSIZE; i++)
+		INIT_HLIST_HEAD(&net->ipv4.inet_addr_lst[i]);
+
 	net->ipv4.devconf_all = all;
 	net->ipv4.devconf_dflt = dflt;
 	return 0;
@@ -2748,6 +2761,8 @@ static __net_init int devinet_init_net(struct net *net)
 err_alloc_dflt:
 	kfree(all);
 err_alloc_all:
+	kfree(net->ipv4.inet_addr_lst);
+err_alloc_hash:
 	return err;
 }
 
@@ -2766,6 +2781,7 @@ static __net_exit void devinet_exit_net(struct net *net)
 #endif
 	kfree(net->ipv4.devconf_dflt);
 	kfree(net->ipv4.devconf_all);
+	kfree(net->ipv4.inet_addr_lst);
 }
 
 static __net_initdata struct pernet_operations devinet_ops = {
-- 
2.30.2


