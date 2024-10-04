Return-Path: <netdev+bounces-132225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF16991027
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508D3280D97
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158291DDA17;
	Fri,  4 Oct 2024 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JMYh2QsS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91131231CAA
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 20:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072111; cv=none; b=fODdCniEGyRKKKWuuf1fKuhwFcPlwrsYxF4RqTjDWq/rf7EN8FhI2T2GbnWxNSRl39VIvGut+1zXhKAqIoJnQqNAv4njCiUmXy3QORfQtoxbI52Hcpfdu39MkWlLUyNk5iDFQw5w1VTXdTEi5ZyouhBV9zhaBDr0gilHlC7EpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072111; c=relaxed/simple;
	bh=yRLXYdZdaW37MrDEWBqrhYDHGIm6Aqz/bBbn0DicHwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGzIrKvmReBGEgWh81p9XCSwaQal5GJM7563Ja0NkHxgsjYm1CC/0qKKHyYeFzuEN3MHcnytsZmUxEIZjtR6CUPJZriceOm/p4hwytzqMHKMZa82xYKa6R0q0iMGAWkvm1ad2OdWzSRro0rm+dwKkGPsMtl8fugHfX2ccIvwyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JMYh2QsS; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728072110; x=1759608110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CpEMbdWsrgCKEw8Rv0fqkJ6kLgLXPflDeOPAB+FXfjM=;
  b=JMYh2QsSw9zb8KDqjali9N0+iNU+vl2o54TPhg7fvhSmEEcs9+MwmCEU
   VnahK3Kg4f4o0HBl7SUY6yGFWMKZzNZF81JSTCp5OqXAhzhpPGp7YjCTB
   F/tYRM30mHjJj6dhIb1SIcDW1flDRCjXbIeOC8UoQcjLqwZ17kO3Ch8mT
   c=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="339861672"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 20:01:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:3401]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.199:2525] with esmtp (Farcaster)
 id d08356d8-e9cb-41c5-9298-a1ff969664b8; Fri, 4 Oct 2024 20:01:46 +0000 (UTC)
X-Farcaster-Flow-ID: d08356d8-e9cb-41c5-9298-a1ff969664b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 20:01:45 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 20:01:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/4] ipv4: Retire global IPv4 hash table inet_addr_lst.
Date: Fri, 4 Oct 2024 12:59:58 -0700
Message-ID: <20241004195958.64396-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

No one uses inet_addr_lst anymore, so let's remove it.

While at it, we can remove net_hash_mix() from the hash calculation.

Reviewed-by: Eric Dumazet <edumazet@google.com>
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
index ac245944e89e..6cdecee96cf5 100644
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
+	return hash_32((__force u32)addr, IN4_ADDR_HSIZE_SHIFT);
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


