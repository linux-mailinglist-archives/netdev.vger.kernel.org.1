Return-Path: <netdev+bounces-133231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BF99955A8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 19:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE3E1C24095
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73E20126D;
	Tue,  8 Oct 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Mn0K/2aE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B718D201117
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408657; cv=none; b=XJZZFET1sGxzxkQtRZUYqSWQPguKN4WMukhPPJw/jEKm0dLDZkfALRGx+1WDis+SjkwTKcoflt1EeI/knnknfH3SG5ylEDU42a923okJImuTB4l/P2XnHQkpnkE+pcruhdTQYFP8a97+Nil7d23S8xZZJ5U/2wpm8hin/j+BfPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408657; c=relaxed/simple;
	bh=RKk6l7e6rY9kN2NHF7fyNiOh8a/6/k7/4c0Ul80z884=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlNH37xF1KxFVNnCCjj5TVXjU3+Li7cTn7/UaoqzDEbs2raWKox8nBsSxU5vr2+Sq97Ve0fiPsdIjRb0wlJPlrHAuX3UrnFIryqxox23vvjXaatj1IIWua1gzk3b8x5zAuGTSiLxBXN/QK3PwskPrzEhRtrRAnYMZitkKZr+qFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Mn0K/2aE; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728408655; x=1759944655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WvezyimE1VHai11DrU5pF1pE50SK2wPrzKx0OwiTI8Q=;
  b=Mn0K/2aEkn6CuyHHG7EpUSA5EooPvbRdiVAvNTqWwJGUHbWNB7HvnkLm
   YcQi3ChLFxtbkkmWDqlXH2ySyc+Ul8OwNrWW+1m+SZvlq3evn+XjpyIBU
   cBPCM0BB9RYoxCrb7BpsL+UIUcxqGJevyhB8hc9LfQgbEggAVceb9kFR9
   o=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="136740337"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 17:30:55 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:42096]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.107:2525] with esmtp (Farcaster)
 id d9a366c7-7341-4599-beef-29fb95064bed; Tue, 8 Oct 2024 17:30:54 +0000 (UTC)
X-Farcaster-Flow-ID: d9a366c7-7341-4599-beef-29fb95064bed
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 17:30:54 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 17:30:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 4/4] ipv4: Retire global IPv4 hash table inet_addr_lst.
Date: Tue, 8 Oct 2024 10:29:06 -0700
Message-ID: <20241008172906.1326-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

No one uses inet_addr_lst anymore, so let's remove it.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v3:
  * Drop change in inet_addr_hash()

v2:
  * Fix sparse warning (__force u32)
---
 include/linux/inetdevice.h |  1 -
 net/ipv4/devinet.c         | 10 ----------
 2 files changed, 11 deletions(-)

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
index ac245944e89e..7c156f85b7d2 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -119,8 +119,6 @@ struct inet_fill_args {
 #define IN4_ADDR_HSIZE_SHIFT	8
 #define IN4_ADDR_HSIZE		(1U << IN4_ADDR_HSIZE_SHIFT)
 
-static struct hlist_head inet_addr_lst[IN4_ADDR_HSIZE];
-
 static u32 inet_addr_hash(const struct net *net, __be32 addr)
 {
 	u32 val = (__force u32) addr ^ net_hash_mix(net);
@@ -133,7 +131,6 @@ static void inet_hash_insert(struct net *net, struct in_ifaddr *ifa)
 	u32 hash = inet_addr_hash(net, ifa->ifa_local);
 
 	ASSERT_RTNL();
-	hlist_add_head_rcu(&ifa->hash, &inet_addr_lst[hash]);
 	hlist_add_head_rcu(&ifa->addr_lst, &net->ipv4.inet_addr_lst[hash]);
 }
 
@@ -141,7 +138,6 @@ static void inet_hash_remove(struct in_ifaddr *ifa)
 {
 	ASSERT_RTNL();
 	hlist_del_init_rcu(&ifa->addr_lst);
-	hlist_del_init_rcu(&ifa->hash);
 }
 
 /**
@@ -228,7 +224,6 @@ static struct in_ifaddr *inet_alloc_ifa(struct in_device *in_dev)
 	in_dev_hold(in_dev);
 	ifa->ifa_dev = in_dev;
 
-	INIT_HLIST_NODE(&ifa->hash);
 	INIT_HLIST_NODE(&ifa->addr_lst);
 
 	return ifa;
@@ -2804,11 +2799,6 @@ static struct rtnl_af_ops inet_af_ops __read_mostly = {
 
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


