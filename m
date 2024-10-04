Return-Path: <netdev+bounces-132256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A46799122C
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6821C22DFA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC9D1ADFFC;
	Fri,  4 Oct 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ufb5xZgC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CBC1A0708
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079898; cv=none; b=egpXVyhHNakfrxlgfOpF/9dY/Nq7x+Szvxg1t/2WpPCYyMs+29V9l8Ke5MdkCmOXTO3+wnIeuV7JtT2J2qiAbIGXTEVwtoKELWbjq8idQ11Ur7Z+jQKdmWX2Xw44bWLcgeDPXyPBcTy3Rqlj9qwTKhLJFLIKqsIUsmMgk8ibgc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079898; c=relaxed/simple;
	bh=g6szUmMCTkntPWGtpBpamuWFHr5QWF7SrQuuuMe5DAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8SAzGccb/j1rMUQlxbu98Sd4LlNNlUd77/S3yrDuzi7li4g+E2lxTXO8bGDHUYbjvfNHrW8vx08HURs9rya8tYAq6prZeXma7Mp4Qli9RG0ApivOcRZ1IEdXJ3kCERudfq50R8XVdbzbDyPo6KjX1sMOsG1pBSO+r1nyMjRNIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ufb5xZgC; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728079897; x=1759615897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T5NZUblj4zUEm6yp+qT6TO768e9tWeVE4fqCJ9htGUA=;
  b=Ufb5xZgCLVjD0ktjYtrUz5j5tcQ6ibonWlyGxm+62oq09uvFxQbTJKUj
   6nKUQV4lpW8U35vJchL227MsMg6kWge7YknQdQ4qJgeZr4UsHGpjPD2Zm
   AmHt7wzgn39LjbRerlgMPGHB1bTuPyH8gsWMCrHEkehxbxkGRGqywgnrO
   g=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="135441522"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:11:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:64119]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.239:2525] with esmtp (Farcaster)
 id 71f1762a-a449-4638-ae14-960e702890aa; Fri, 4 Oct 2024 22:11:31 +0000 (UTC)
X-Farcaster-Flow-ID: 71f1762a-a449-4638-ae14-960e702890aa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:11:31 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:11:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 2/4] rtnetlink: Add per-netns RTNL.
Date: Fri, 4 Oct 2024 15:10:29 -0700
Message-ID: <20241004221031.77743-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The goal is to break RTNL down into per-netns mutex.

This patch adds per-netns mutex and its helper functions, rtnl_net_lock()
and rtnl_net_unlock().

rtnl_net_lock() acquires the global RTNL and per-netns RTNL mutex, and
rtnl_net_unlock() releases them.

We will replace 800+ rtnl_lock() with rtnl_net_lock() and finally removes
rtnl_lock() in rtnl_net_lock().

When we need to nest per-netns RTNL mutex, we will use __rtnl_net_lock(),
and its locking order is defined by rtnl_net_lock_cmp_fn() as follows:

  1. init_net is first
  2. netns address ascending order

Note that the conversion will be done under CONFIG_DEBUG_NET_SMALL_RTNL
with LOCKDEP so that we can carefully add the extra mutex without slowing
down RTNL operations during conversion.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/rtnetlink.h   | 21 ++++++++++++++
 include/net/net_namespace.h |  4 +++
 net/Kconfig.debug           | 15 ++++++++++
 net/core/net_namespace.c    |  6 ++++
 net/core/rtnetlink.c        | 58 +++++++++++++++++++++++++++++++++++++
 5 files changed, 104 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index cdfc897f1e3c..edd840a49989 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -92,6 +92,27 @@ static inline bool lockdep_rtnl_is_held(void)
 #define rcu_replace_pointer_rtnl(rp, p)			\
 	rcu_replace_pointer(rp, p, lockdep_rtnl_is_held())
 
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+void __rtnl_net_lock(struct net *net);
+void __rtnl_net_unlock(struct net *net);
+void rtnl_net_lock(struct net *net);
+void rtnl_net_unlock(struct net *net);
+int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b);
+#else
+static inline void __rtnl_net_lock(struct net *net) {}
+static inline void __rtnl_net_unlock(struct net *net) {}
+
+static inline void rtnl_net_lock(struct net *net)
+{
+	rtnl_lock();
+}
+
+static inline void rtnl_net_unlock(struct net *net)
+{
+	rtnl_unlock();
+}
+#endif
+
 static inline struct netdev_queue *dev_ingress_queue(struct net_device *dev)
 {
 	return rtnl_dereference(dev->ingress_queue);
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index e67b483cc8bb..873c0f9fdac6 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -188,6 +188,10 @@ struct net {
 #if IS_ENABLED(CONFIG_SMC)
 	struct netns_smc	smc;
 #endif
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	/* Move to a better place when the config guard is removed. */
+	struct mutex		rtnl_mutex;
+#endif
 } __randomize_layout;
 
 #include <linux/seq_file_net.h>
diff --git a/net/Kconfig.debug b/net/Kconfig.debug
index 5e3fffe707dd..277fab8c4d77 100644
--- a/net/Kconfig.debug
+++ b/net/Kconfig.debug
@@ -24,3 +24,18 @@ config DEBUG_NET
 	help
 	  Enable extra sanity checks in networking.
 	  This is mostly used by fuzzers, but is safe to select.
+
+config DEBUG_NET_SMALL_RTNL
+	bool "Add extra per-netns mutex inside RTNL"
+	depends on DEBUG_KERNEL && NET && LOCK_DEBUGGING_SUPPORT
+	select PROVE_LOCKING
+	default n
+	help
+	  rtnl_lock() is being replaced with rtnl_net_lock() that
+	  acquires the global RTNL and a small per-netns RTNL mutex.
+
+	  During the conversion, rtnl_net_lock() just adds an extra
+	  mutex in every RTNL scope and slows down the operations.
+
+	  Once the conversion completes, rtnl_lock() will be removed
+	  and rtnetlink will gain per-netns scalability.
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index e39479f1c9a4..105e3cd26763 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -334,6 +334,12 @@ static __net_init void preinit_net(struct net *net, struct user_namespace *user_
 	idr_init(&net->netns_ids);
 	spin_lock_init(&net->nsid_lock);
 	mutex_init(&net->ipv4.ra_mutex);
+
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+	mutex_init(&net->rtnl_mutex);
+	lock_set_cmp_fn(&net->rtnl_mutex, rtnl_net_lock_cmp_fn, NULL);
+#endif
+
 	preinit_net_sysctl(net);
 }
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f0a520987085..edf530441b65 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -179,6 +179,64 @@ bool lockdep_rtnl_is_held(void)
 EXPORT_SYMBOL(lockdep_rtnl_is_held);
 #endif /* #ifdef CONFIG_PROVE_LOCKING */
 
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+void __rtnl_net_lock(struct net *net)
+{
+	ASSERT_RTNL();
+
+	mutex_lock(&net->rtnl_mutex);
+}
+EXPORT_SYMBOL(__rtnl_net_lock);
+
+void __rtnl_net_unlock(struct net *net)
+{
+	ASSERT_RTNL();
+
+	mutex_unlock(&net->rtnl_mutex);
+}
+EXPORT_SYMBOL(__rtnl_net_unlock);
+
+void rtnl_net_lock(struct net *net)
+{
+	rtnl_lock();
+	__rtnl_net_lock(net);
+}
+EXPORT_SYMBOL(rtnl_net_lock);
+
+void rtnl_net_unlock(struct net *net)
+{
+	__rtnl_net_unlock(net);
+	rtnl_unlock();
+}
+EXPORT_SYMBOL(rtnl_net_unlock);
+
+static int rtnl_net_cmp_locks(const struct net *net_a, const struct net *net_b)
+{
+	if (net_eq(net_a, net_b))
+		return 0;
+
+	/* always init_net first */
+	if (net_eq(net_a, &init_net))
+		return -1;
+
+	if (net_eq(net_b, &init_net))
+		return 1;
+
+	/* otherwise lock in ascending order */
+	return net_a < net_b ? -1 : 1;
+}
+
+int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b)
+{
+	const struct net *net_a, *net_b;
+
+	net_a = container_of(a, struct net, rtnl_mutex.dep_map);
+	net_b = container_of(b, struct net, rtnl_mutex.dep_map);
+
+	return rtnl_net_cmp_locks(net_a, net_b);
+}
+#endif
+
 static struct rtnl_link __rcu *__rcu *rtnl_msg_handlers[RTNL_FAMILY_MAX + 1];
 
 static inline int rtm_msgindex(int msgtype)
-- 
2.30.2


