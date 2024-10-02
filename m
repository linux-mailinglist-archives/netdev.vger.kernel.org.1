Return-Path: <netdev+bounces-131263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823898DEC9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AD16B2C4E9
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D31D0E17;
	Wed,  2 Oct 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nerzdj6W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4E1D0E00
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882048; cv=none; b=pAf/TjnOIgro2sugdW/VJ2ZY+8bJKbrsKYfMywVZJUB3wzYhQYce29duWv+D523fi6yti5sO0Qc/GdTEfj2kVQFfpUhGbiCBtDDhAPauuBNETC7Wy6jmptUdurTBzOruTlSdUFJAydencRn7VOHNM3xQKR7oyuPQ2Z+aeYPqgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882048; c=relaxed/simple;
	bh=LZFJYBoqg4CUBhYf1eVHf9HTzBMJgmbJIQoY/rwylhs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOmU/QiRR6pYT2lkQKz+vPFGaehDaPAkpgNHT9tZ+kF5AHN/M+de/UviTiQUXwfdc4xkQWeFTq1k1titvUj254J8itdPDzkr0aDc81qd6mlBjgFB2z4d322k7f/9Rtrm+Qz6vamCA8Antr9+/56vjh3YjtJQKj4vEBrTGpbUXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nerzdj6W; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727882047; x=1759418047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0IHZVqENzirNBLGi6Wb5jWKv/Dhyb26NkuNv6pPZ0iU=;
  b=nerzdj6WS7dTRpeYA/l54p7w53mgGIHQfpOcdtNADx0BaN/1EyHn87QF
   TukPLTk9n3zlJZdaJLh0PlVFyRWksZWcd2wlB6/DIbg4AWznelklaksvh
   ZzedKvydd2mGdwVEmgkSxv8OHPB0cnWQtGp1TDPc4TxrmWErp4pI/IOS5
   I=;
X-IronPort-AV: E=Sophos;i="6.11,172,1725321600"; 
   d="scan'208";a="134191469"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 15:14:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:45838]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.191:2525] with esmtp (Farcaster)
 id a29e7fe6-bf9d-422c-bb55-c1f6fbdae7e5; Wed, 2 Oct 2024 15:14:06 +0000 (UTC)
X-Farcaster-Flow-ID: a29e7fe6-bf9d-422c-bb55-c1f6fbdae7e5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 15:14:06 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 2 Oct 2024 15:14:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/4] rtnetlink: Add assertion helpers for per-netns RTNL.
Date: Wed, 2 Oct 2024 08:12:39 -0700
Message-ID: <20241002151240.49813-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241002151240.49813-1-kuniyu@amazon.com>
References: <20241002151240.49813-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
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
 include/linux/rtnetlink.h | 25 +++++++++++++++++++++++++
 net/core/rtnetlink.c      | 12 ++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index f743c4f678bf..ec2fc946cd8a 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -52,11 +52,36 @@ void __rtnl_net_unlock(struct net *net);
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


