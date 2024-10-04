Return-Path: <netdev+bounces-132257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCD299122E
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55811C22D78
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239A41AE004;
	Fri,  4 Oct 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NrbeVIRP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911213A3ED
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079926; cv=none; b=Sxj3OcYgLuCoOy03+aArn3us54qYpLo0NXV16FUUUwzjJYVZ91IIAmFXpwf7oD65+OJW+T907FHB9FjYQd6QPx8LJH2Nk8QtMD3Huft1jUSCxlnLXQFWZmTeMC8Y9YBA5nzyNIF8x7wXRxbBgXUEuoCGqfWDMDrMPLGMuDBk+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079926; c=relaxed/simple;
	bh=AJHvovNuUuCrJIJRcYOXXhIZIMf4iHgjNnur+wyTEOM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsyFM1mQKD9hWNKeYi4Yma2w2Vk3CX8fUEmoCDJ7J0Pfy+TDT95bvOGqPGoa75r9251qja+HX2699dDLvUlntAhLMw7U+WRrY7CV/Q45IBFOfJb3ySQAhDTotCr9w4W+1mTXptWAKXgd1f2ODItnOF4sCOEIxsa7kARf9Mro1f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NrbeVIRP; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728079924; x=1759615924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0MxUf6Y09Vm05/Y3x518OfOz/ufHCwc9QWOCj3Lkfcs=;
  b=NrbeVIRPb/XJnd4zdob7vvOi9Vk05wygqlJ2r8uyBcsiRXEClQyWsebl
   FA3o1mciGbgjH0Gnm8ySpeFLAbRe5kmdz8NXq+NHMgbDTlQdROgGDkGAg
   jyZdz47gxpQ5S2a+OjO5u/42yk1YCQECRclHcwLTtq2wrN4h7MSL2uGHE
   E=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="236894557"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:12:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:22676]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.198:2525] with esmtp (Farcaster)
 id 56324534-0cb3-48b1-b8a5-0f6b31e4e7af; Fri, 4 Oct 2024 22:11:55 +0000 (UTC)
X-Farcaster-Flow-ID: 56324534-0cb3-48b1-b8a5-0f6b31e4e7af
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:11:55 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:11:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 3/4] rtnetlink: Add assertion helpers for per-netns RTNL.
Date: Fri, 4 Oct 2024 15:10:30 -0700
Message-ID: <20241004221031.77743-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004221031.77743-1-kuniyu@amazon.com>
References: <20241004221031.77743-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once an RTNL scope is converted with rtnl_net_lock(), we will replace
RTNL helper functions inside the scope with the following per-netns
alternatives:

  ASSERT_RTNL()           -> ASSERT_RTNL_NET(net)
  rcu_dereference_rtnl(p) -> rcu_dereference_rtnl_net(net, p)

Note that the per-netns helpers are equivalent to the conventional
helpers unless CONFIG_DEBUG_NET_SMALL_RTNL is enabled.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/rtnetlink.h | 45 +++++++++++++++++++++++++++++++++++----
 net/core/rtnetlink.c      | 12 +++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index edd840a49989..8468a4ce8510 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -51,6 +51,10 @@ extern atomic_t dev_unreg_count;
 extern struct rw_semaphore pernet_ops_rwsem;
 extern struct rw_semaphore net_rwsem;
 
+#define ASSERT_RTNL() \
+	WARN_ONCE(!rtnl_is_locked(), \
+		  "RTNL: assertion failed at %s (%d)\n", __FILE__,  __LINE__)
+
 #ifdef CONFIG_PROVE_LOCKING
 extern bool lockdep_rtnl_is_held(void);
 #else
@@ -98,6 +102,22 @@ void __rtnl_net_unlock(struct net *net);
 void rtnl_net_lock(struct net *net);
 void rtnl_net_unlock(struct net *net);
 int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b);
+
+bool rtnl_net_is_locked(struct net *net);
+
+#define ASSERT_RTNL_NET(net)						\
+	WARN_ONCE(!rtnl_net_is_locked(net),				\
+		  "RTNL_NET: assertion failed at %s (%d)\n",		\
+		  __FILE__,  __LINE__)
+
+bool lockdep_rtnl_net_is_held(struct net *net);
+
+#define rcu_dereference_rtnl_net(net, p)				\
+	rcu_dereference_check(p, lockdep_rtnl_net_is_held(net))
+#define rtnl_net_dereference(net, p)					\
+	rcu_dereference_protected(p, lockdep_rtnl_net_is_held(net))
+#define rcu_replace_pointer_rtnl_net(net, rp, p)			\
+	rcu_replace_pointer(rp, p, lockdep_rtnl_net_is_held(net))
 #else
 static inline void __rtnl_net_lock(struct net *net) {}
 static inline void __rtnl_net_unlock(struct net *net) {}
@@ -111,6 +131,27 @@ static inline void rtnl_net_unlock(struct net *net)
 {
 	rtnl_unlock();
 }
+
+static inline void ASSERT_RTNL_NET(struct net *net)
+{
+	ASSERT_RTNL();
+}
+
+static inline void *rcu_dereference_rtnl_net(struct net *net, void *p)
+{
+	return rcu_dereference_rtnl(p);
+}
+
+static inline void *rtnl_net_dereference(struct net *net, void *p)
+{
+	return rtnl_dereference(p);
+}
+
+static inline void *rcu_replace_pointer_rtnl_net(struct net *net,
+						 void *rp, void *p)
+{
+	return rcu_replace_pointer_rtnl(rp, p);
+}
 #endif
 
 static inline struct netdev_queue *dev_ingress_queue(struct net_device *dev)
@@ -140,10 +181,6 @@ void rtnetlink_init(void);
 void __rtnl_unlock(void);
 void rtnl_kfree_skbs(struct sk_buff *head, struct sk_buff *tail);
 
-#define ASSERT_RTNL() \
-	WARN_ONCE(!rtnl_is_locked(), \
-		  "RTNL: assertion failed at %s (%d)\n", __FILE__,  __LINE__)
-
 extern int ndo_dflt_fdb_dump(struct sk_buff *skb,
 			     struct netlink_callback *cb,
 			     struct net_device *dev,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index edf530441b65..2b44ec690780 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -235,6 +235,18 @@ int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *
 
 	return rtnl_net_cmp_locks(net_a, net_b);
 }
+
+bool rtnl_net_is_locked(struct net *net)
+{
+	return rtnl_is_locked() && mutex_is_locked(&net->rtnl_mutex);
+}
+EXPORT_SYMBOL(rtnl_net_is_locked);
+
+bool lockdep_rtnl_net_is_held(struct net *net)
+{
+	return lockdep_rtnl_is_held() && lockdep_is_held(&net->rtnl_mutex);
+}
+EXPORT_SYMBOL(lockdep_rtnl_net_is_held);
 #endif
 
 static struct rtnl_link __rcu *__rcu *rtnl_msg_handlers[RTNL_FAMILY_MAX + 1];
-- 
2.30.2


