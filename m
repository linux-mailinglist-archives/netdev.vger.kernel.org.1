Return-Path: <netdev+bounces-130606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D64198AE5C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF3C282922
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9931A0B0F;
	Mon, 30 Sep 2024 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mbfR11BE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8719922D
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728099; cv=none; b=QZ1H3nrnUu2ATXESODFbHE9vAYFH3pjiSgNGUNRtxABycc87PfS/3XaSOxzxCgTyUA8Ow/SBw5T2r9Fi2SEXQioXtvNOEeWSUwo9aZYDnftu0RuopBPXJoMSl7vgEXYeZX5eo+qKcCBZqSWd6hFZ8Vr0KWuTpEhFlL5wwON7G0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728099; c=relaxed/simple;
	bh=LTQPQP5co+sPg0ZiNIbUtIBXz7k7O2ps9T/F9UkU8Ro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+oqf/zi+dMjqmvsVkqP3eKwsIevAUqSMM/kDq48mBnYQ4pM9nQjXg+DLS0X3Bo1hjtYT4yitgiIer01OmRwezG1encD1HIBQmA8DyWzlvoFXZgEPPpKgkyyH+tfdw+knGGuVcO6HPJ0HNgGUXLgfrOemTxPY8AWyPSRl7+ygSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mbfR11BE; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727728097; x=1759264097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L82BkNpop3SuTSFdfu3H29QJaYxeVh4KxZCOF7UH+BQ=;
  b=mbfR11BEZEENYNmC5QwYceZ0GYNEjQAhBG5U+S8PZrzYfNK8oTnCBcdO
   mWsO7gYKqDBMReJ9r1scaRFKwUVSqFkRji0X3z1Q+ZbMsZ8GKqDfKzApc
   6d9AQtAG/phWRzhjlzbQbvTuN1REeK+b2Juxt3mLdH8W8COtF9P7DqS6D
   0=;
X-IronPort-AV: E=Sophos;i="6.11,166,1725321600"; 
   d="scan'208";a="133080964"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 20:28:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:15692]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id d80c135a-09bb-40b9-a8ef-eaa4eb86bc2f; Mon, 30 Sep 2024 20:28:15 +0000 (UTC)
X-Farcaster-Flow-ID: d80c135a-09bb-40b9-a8ef-eaa4eb86bc2f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 30 Sep 2024 20:28:15 +0000
Received: from 88665a182662.ant.amazon.com (10.1.212.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 30 Sep 2024 20:28:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/3] rtnetlink: Add assertion helpers for per-net RTNL.
Date: Mon, 30 Sep 2024 23:25:25 +0300
Message-ID: <20240930202524.59357-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once an RTNL scope is converted with rtnl_net_lock(), we will replace RTNL
helper functions inside the scope with the following per-net alternatives:

  ASSERT_RTNL()           -> ASSERT_RTNL_NET(net)
  rcu_dereference_rtnl(p) -> rcu_dereference_rtnl_net(net, p)

Note that the per-net helpers are equivalent to the conventional helpers
unless CONFIG_DEBUG_NET_SMALL_RTNL is enabled.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/rtnetlink.h | 25 +++++++++++++++++++++++++
 net/core/rtnetlink.c      | 12 ++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index c4afe6c49651..458d2320e6d3 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -55,11 +55,36 @@ void __rtnl_net_unlock(struct net *net);
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
 #define __rtnl_net_lock(net)
 #define __rtnl_net_unlock(net)
 #define rtnl_net_lock(net) rtnl_lock()
 #define rtnl_net_unlock(net) rtnl_unlock()
+
+#define ASSERT_RTNL_NET(net)	ASSERT_RTNL()
+
+#define rcu_dereference_rtnl_net(net, p)		\
+	rcu_dereference_rtnl(p)
+#define rtnl_net_dereference(net, p)			\
+	rtnl_dereference(p)
+#define rcu_replace_pointer_rtnl_net(net, rp, p)	\
+	rcu_replace_pointer_rtnl(rp, p)
 #endif
 
 extern wait_queue_head_t netdev_unregistering_wq;
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


