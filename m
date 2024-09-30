Return-Path: <netdev+bounces-130605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C49D98AE5B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606E11C21D6F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23DE1A2630;
	Mon, 30 Sep 2024 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eJXUN1Jw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCC21A2634
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728061; cv=none; b=p1hp/g687SYazOvsHk446cex+r7AwYilcRc1qmVMlHrPEcf9XkW94i9ITyt+IGv6WSNJljyj/YbVAEJPGKMb0UAOqNW/7uS8t6wD/ClDkI1GYIyU1ljw7Oh6H1JyA8dBOqSGqt6c2VE4C0uY44rEDNOA4l264pqlrNifpJYpT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728061; c=relaxed/simple;
	bh=2qV4U+RuecP0ZE7bwXlXD5qxXEdiO6n9VAAROqPLqIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPw6aUEhMKYFkqOSDsPHtuE4xA1DraKIHczlosE9NSIGtD0ZNBRq9hlKS6DIbjDDNhGakgIhIjPLv2Dqh2uhQFS91ov61rekSn42zw2z7yvmD6alYLTQh62I9iuVkAvS9z484njMuZO8zLLFb5LAjeUFrQyl2fqKqB0rUhs4eWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eJXUN1Jw; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727728060; x=1759264060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mUt4k3AyxmxOpIWLjp77PrDfxei0sGDBS6x66WmFiKw=;
  b=eJXUN1JwO1H4+G15+3NmVVBaznKtYECF3fexsfFGnwYQ+HlZD2hjGrML
   d8v3fR7CIJXBBsQw2MWz5pAjLQbphSwtbhZiCDTvzqCBC9viVKpwUik3H
   pgRAzdFepxzmgXykxgXN8tsR2TP3I82AAGNsBJKC6jg94neqzcno+SwJd
   E=;
X-IronPort-AV: E=Sophos;i="6.11,166,1725321600"; 
   d="scan'208";a="235696541"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 20:27:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:5423]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id f114ac10-8afa-47f0-854b-ce8b2cbddbbb; Mon, 30 Sep 2024 20:27:36 +0000 (UTC)
X-Farcaster-Flow-ID: f114ac10-8afa-47f0-854b-ce8b2cbddbbb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 30 Sep 2024 20:27:35 +0000
Received: from 88665a182662.ant.amazon.com (10.1.212.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 30 Sep 2024 20:27:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/3] rtnetlink: Add per-net RTNL.
Date: Mon, 30 Sep 2024 23:25:24 +0300
Message-ID: <20240930202524.59357-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240930202524.59357-1-kuniyu@amazon.com>
References: <20240930202524.59357-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The goal is to break RTNL down into per-net mutex.

This patch adds per-net mutex and its helper functions, rtnl_net_lock()
and rtnl_net_unlock().

rtnl_net_lock() acquires the global RTNL and per-net RTNL mutex, and
rtnl_net_unlock() releases them.

We will replace 800+ rtnl_lock() instances with rtnl_net_lock() and
finally removes rtnl_lock() in rtnl_net_lock().

When we need to nest per-net RTNL mutex, we will use __rtnl_net_lock(),
and its locking order is defined by rtnl_net_lock_cmp_fn() as follows:

  1. init_net is first
  2. netns address ascending order

Note that the conversion will be done under CONFIG_DEBUG_NET_SMALL_RTNL
with LOCKDEP so that we can carefully add the extra mutex without slowing
down RTNL operations during conversion.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/rtnetlink.h   | 13 +++++++++
 include/net/net_namespace.h |  4 +++
 net/Kconfig.debug           | 14 +++++++++
 net/core/net_namespace.c    |  6 ++++
 net/core/rtnetlink.c        | 58 +++++++++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index a7da7dfc06a2..c4afe6c49651 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -49,6 +49,19 @@ extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
 
 DEFINE_LOCK_GUARD_0(rtnl, rtnl_lock(), rtnl_unlock())
 
+#ifdef CONFIG_DEBUG_NET_SMALL_RTNL
+void __rtnl_net_lock(struct net *net);
+void __rtnl_net_unlock(struct net *net);
+void rtnl_net_lock(struct net *net);
+void rtnl_net_unlock(struct net *net);
+int rtnl_net_lock_cmp_fn(const struct lockdep_map *a, const struct lockdep_map *b);
+#else
+#define __rtnl_net_lock(net)
+#define __rtnl_net_unlock(net)
+#define rtnl_net_lock(net) rtnl_lock()
+#define rtnl_net_unlock(net) rtnl_unlock()
+#endif
+
 extern wait_queue_head_t netdev_unregistering_wq;
 extern atomic_t dev_unreg_count;
 extern struct rw_semaphore pernet_ops_rwsem;
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
index 5e3fffe707dd..281f34acb89e 100644
--- a/net/Kconfig.debug
+++ b/net/Kconfig.debug
@@ -24,3 +24,17 @@ config DEBUG_NET
 	help
 	  Enable extra sanity checks in networking.
 	  This is mostly used by fuzzers, but is safe to select.
+
+config DEBUG_NET_SMALL_RTNL
+	bool "Add extra per-netns mutex inside RTNL"
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


