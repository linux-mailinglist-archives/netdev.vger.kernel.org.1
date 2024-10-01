Return-Path: <netdev+bounces-130687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AF498B296
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 04:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAC6B26D44
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 02:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BCE4317B;
	Tue,  1 Oct 2024 02:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VuJTlmYL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F0F43178
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 02:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727751063; cv=none; b=dP5Uo3yxeuqESnX7Fw64gt9dXdPrdfYLD6fOLmEDNfkf9zlj9NuPgGq9hLiUOjfjUmpzdC60bYyJ8w5N/TeKpQMHa3RIjmh+K4t8YyVhZ5LHfipmSyBW5IV0ubyoSSDV04aWf+/8uh+fWQ9NyRjWPky6qnNZh5sBoG50FbgxJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727751063; c=relaxed/simple;
	bh=HBWKCgE5EY78NmPOf3z/dGtMPpNnFUhICgHwI6GWNK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJbFM3LIVMEOiYl4lbcN/BbXaUmoFl0zAV3HkxzVkS9dp0niUj6rLkPI4QiQfT5WFszFyo2oAFL+ORk/IFyH7BJAPoXvSOY98SO/GNwiTO6gPhfOSgt1Jsw/HS76klItjqbElOBZ0j5y7+J5iXY1yjA9ecWHSGcpwtY6cI6zpUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VuJTlmYL; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727751062; x=1759287062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JVaTk5JnmONlWw4j0Cheg9c9QDUyy42Jw7yUalwPwMQ=;
  b=VuJTlmYLkz1aweJ01icCo3zB2ZIPNsO7ciF9UK2lPdUIa0sruPgI/e7c
   wmPXqlh54RDXnH8xejAZnJe+2tLWATjktcqudrhstPgdQ0NS0jcy1KxBk
   TqUwj40Tu7BB6ci7U1b32f2qgZcti4Ba85UKfhcGQuajb5yTiB5QRDLuJ
   o=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="235755525"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 02:51:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:53858]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.223:2525] with esmtp (Farcaster)
 id 045d401b-8193-4227-b27b-a8d8f166a631; Tue, 1 Oct 2024 02:50:59 +0000 (UTC)
X-Farcaster-Flow-ID: 045d401b-8193-4227-b27b-a8d8f166a631
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 02:50:59 +0000
Received: from 88665a182662.ant.amazon.com (10.1.212.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 02:50:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/5] ipv4: Retire global IPv4 hash table inet_addr_lst.
Date: Tue, 1 Oct 2024 05:48:36 +0300
Message-ID: <20241001024837.96425-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

No one uses inet_addr_lst anymore, so let's remove it.

While at it, we can remove net_hash_mix() from the hash calculation.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/inetdevice.h |  1 -
 net/ipv4/devinet.c         | 14 +-------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index d0c2bf67a9b0..d9c690c8c80b 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -141,7 +141,6 @@ static inline void ipv4_devconf_setall(struct in_device *in_dev)
 							  ARP_EVICT_NOCARRIER)
 
 struct in_ifaddr {
-	struct hlist_node	hash;
 	struct hlist_node	addr_lst;
 	struct in_ifaddr	__rcu *ifa_next;
 	struct in_device	*ifa_dev;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index ac245944e89e..96fc4aacc539 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -119,13 +119,9 @@ struct inet_fill_args {
 #define IN4_ADDR_HSIZE_SHIFT	8
 #define IN4_ADDR_HSIZE		(1U << IN4_ADDR_HSIZE_SHIFT)
 
-static struct hlist_head inet_addr_lst[IN4_ADDR_HSIZE];
-
 static u32 inet_addr_hash(const struct net *net, __be32 addr)
 {
-	u32 val = (__force u32) addr ^ net_hash_mix(net);
-
-	return hash_32(val, IN4_ADDR_HSIZE_SHIFT);
+	return hash_32(addr, IN4_ADDR_HSIZE_SHIFT);
 }
 
 static void inet_hash_insert(struct net *net, struct in_ifaddr *ifa)
@@ -133,7 +129,6 @@ static void inet_hash_insert(struct net *net, struct in_ifaddr *ifa)
 	u32 hash = inet_addr_hash(net, ifa->ifa_local);
 
 	ASSERT_RTNL();
-	hlist_add_head_rcu(&ifa->hash, &inet_addr_lst[hash]);
 	hlist_add_head_rcu(&ifa->addr_lst, &net->ipv4.inet_addr_lst[hash]);
 }
 
@@ -141,7 +136,6 @@ static void inet_hash_remove(struct in_ifaddr *ifa)
 {
 	ASSERT_RTNL();
 	hlist_del_init_rcu(&ifa->addr_lst);
-	hlist_del_init_rcu(&ifa->hash);
 }
 
 /**
@@ -228,7 +222,6 @@ static struct in_ifaddr *inet_alloc_ifa(struct in_device *in_dev)
 	in_dev_hold(in_dev);
 	ifa->ifa_dev = in_dev;
 
-	INIT_HLIST_NODE(&ifa->hash);
 	INIT_HLIST_NODE(&ifa->addr_lst);
 
 	return ifa;
@@ -2804,11 +2797,6 @@ static struct rtnl_af_ops inet_af_ops __read_mostly = {
 
 void __init devinet_init(void)
 {
-	int i;
-
-	for (i = 0; i < IN4_ADDR_HSIZE; i++)
-		INIT_HLIST_HEAD(&inet_addr_lst[i]);
-
 	register_pernet_subsys(&devinet_ops);
 	register_netdevice_notifier(&ip_netdev_notifier);
 
-- 
2.30.2


