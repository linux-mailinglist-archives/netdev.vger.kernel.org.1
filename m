Return-Path: <netdev+bounces-158227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD178A1128D
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10B9163D55
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851AA20C499;
	Tue, 14 Jan 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2mf+yTA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E358A19149F
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888137; cv=none; b=c/94SvFuj2j/dosBigEWZvVs5A6Hc4PX+SaPydMO0CoQXAeQmVT1JQW1PCpzC/rmkezErVUfFDgz4f66TljOqv6+Yw7JWdebEhHgYf9N+oVfKbnNvr9JU0YUhU0ud8UXME6JgwJvcgr1fTHIvWGhY6dR8GYnFABmCfLvcLs0068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888137; c=relaxed/simple;
	bh=+jiNcGCIk7HzAY4joxHdvs51wDmgqi5k4h8rVtt9YN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a7ndS0nyQXILgQRfrUC4jc2hy2AODmgP8I8LBxvSDAtvxpzgUdS0EKFBcx88Rztha75VpXt0LeUrVJWqrPQl9M3Q3uXDUWJv8bcFH2K19UemWSCu2RwbissMk/PmJVfcdyTfcXo90iDPvFEh+o9ija6FKb/Yd8OLTdI1pfTVE5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X2mf+yTA; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b6f482362aso948429585a.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736888135; x=1737492935; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk+fZj4sfaYNKt3et6GAqarEN+Xwd4BiVEI/0rxxZqk=;
        b=X2mf+yTA49CgXr+iNqoZ879DcyhRPJ+Cs01AmswVEnHk0IDQKEjItNQUp6RqbeGw5d
         +ruuDRpw42ABlpIl3360QcAL3m75OU7RkO2ulMPwId+knUYP+UCXAE8zUOqC1y76Pixh
         QZXwONe22nG7c4Dt49sPRgHbZNLvkf9nGZR2oGUwSZjL2FtPBOvlbGltrcEOt2tOMKk4
         UaUKPZR15dvVrXbXRrTL5K1jj6MgGxMmyv+vB2GsDve/kgCFp2e9NpY7AR0Ul9SACvKj
         oHArlA1mOsqM0wAfTQ99AeoadJPgE1VfPdWFT8MSkZXqX6Fv8rf7F8kAW0dxR7tw4Ngm
         3BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736888135; x=1737492935;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wk+fZj4sfaYNKt3et6GAqarEN+Xwd4BiVEI/0rxxZqk=;
        b=RyxNhBO7jhRINF9YcIdHqIycagxlXxxqpNFP7R/pM9f8EeswMfWiUL+m+sUkGxaVxt
         X7CVs4CiubgL2ndHjE8s9XPWLspu7DDhkKd5zGC7c1Ffc0kEU81jSQhvvA+2XedJrWp7
         6So0NrGNTeFvpEJ35cEF68SrK2vjdgKNjBvL6LOzyvG/6of4g72tiVjPN1u1b1sDN07P
         cndfIZ9T2uyIotj+rgQYbNxPW41jSYhtLncy85gvl8IghpICLDoEUhDkP18OIHaRlfGQ
         lAVLAq16c11hUkqkVSHzQykaKVbvd1XUSu+1V3+v6Ahq9lkalyKm8QKRFrcObmXvuZgQ
         qd+g==
X-Gm-Message-State: AOJu0Yx4wwBc4s6tK0M6Z82XiXS8lTRRJnq326Dlm2pS+NsGEr/4jDdP
	/aNKyX8wTzuYVFy0BJ2Cz0NJ9MquSlhS34L34y4fZAcKZ6wzhGrxQbZNMy/2xyiLChv1zUOltzo
	U9+27LNjjIw==
X-Google-Smtp-Source: AGHT+IGnVqbdwJggzt2aWlemeuMHD8lrwBER1fTkLyfxxL3TVzFB3zQlhRpUVDOt/GLiF6Qn0by+zO9kHAdwxA==
X-Received: from qkmy29.prod.google.com ([2002:a05:620a:e1d:b0:7bc:dee1:94a3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1b8f:b0:7b6:6ffc:e972 with SMTP id af79cd13be357-7bcd96fa261mr4460129185a.5.1736888134879;
 Tue, 14 Jan 2025 12:55:34 -0800 (PST)
Date: Tue, 14 Jan 2025 20:55:27 +0000
In-Reply-To: <20250114205531.967841-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114205531.967841-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250114205531.967841-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/5] net: expedite synchronize_net() for cleanup_net()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

cleanup_net() is the single thread responsible
for netns dismantles, and a serious bottleneck.

Before we can get per-netns RTNL, make sure
all synchronize_net() called from this thread
are using rcu_synchronize_expedited().

v3: deal with CONFIG_NET_NS=n

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/net_namespace.h |  2 ++
 net/core/dev.c              | 11 ++++++++++-
 net/core/net_namespace.c    |  5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 5a2a0df8ad91b677b515b392869c6c755be5c868..0f5eb9db0c6264efc1ac83ab577511fd6823f4fe 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -210,6 +210,8 @@ void net_ns_barrier(void);
 
 struct ns_common *get_net_ns(struct ns_common *ns);
 struct net *get_net_ns_by_fd(int fd);
+extern struct task_struct *cleanup_net_task;
+
 #else /* CONFIG_NET_NS */
 #include <linux/sched.h>
 #include <linux/nsproxy.h>
diff --git a/net/core/dev.c b/net/core/dev.c
index fda4e1039bf01d46cfaa5f134d20e1d2bcdcfdfc..0542346a403c2602f94d8bc61f7be0ea0c64c33a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10072,6 +10072,15 @@ static void dev_index_release(struct net *net, int ifindex)
 	WARN_ON(xa_erase(&net->dev_by_index, ifindex));
 }
 
+static bool from_cleanup_net(void)
+{
+#ifdef CONFIG_NET_NS
+	return current == cleanup_net_task;
+#else
+	return false;
+#endif
+}
+
 /* Delayed registration/unregisteration */
 LIST_HEAD(net_todo_list);
 DECLARE_WAIT_QUEUE_HEAD(netdev_unregistering_wq);
@@ -11447,7 +11456,7 @@ EXPORT_SYMBOL_GPL(alloc_netdev_dummy);
 void synchronize_net(void)
 {
 	might_sleep();
-	if (rtnl_is_locked())
+	if (from_cleanup_net() || rtnl_is_locked())
 		synchronize_rcu_expedited();
 	else
 		synchronize_rcu();
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b5cd3ae4f04cf28d43f8401a3dafebac4a297123..cb39a12b2f8295c605f08b5589932932150a1644 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -588,6 +588,8 @@ static void unhash_nsid(struct net *net, struct net *last)
 
 static LLIST_HEAD(cleanup_list);
 
+struct task_struct *cleanup_net_task;
+
 static void cleanup_net(struct work_struct *work)
 {
 	const struct pernet_operations *ops;
@@ -596,6 +598,8 @@ static void cleanup_net(struct work_struct *work)
 	LIST_HEAD(net_exit_list);
 	LIST_HEAD(dev_kill_list);
 
+	cleanup_net_task = current;
+
 	/* Atomically snapshot the list of namespaces to cleanup */
 	net_kill_list = llist_del_all(&cleanup_list);
 
@@ -670,6 +674,7 @@ static void cleanup_net(struct work_struct *work)
 		put_user_ns(net->user_ns);
 		net_free(net);
 	}
+	cleanup_net_task = NULL;
 }
 
 /**
-- 
2.48.0.rc2.279.g1de40edade-goog


