Return-Path: <netdev+bounces-168146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39948A3DB1C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC361792C2
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB371F5425;
	Thu, 20 Feb 2025 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiaYgaG+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595008F6D
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057539; cv=none; b=N7GjC2ocm1dlOjJZBWh/4y0Ft9oGo9cGr5W9BBS7KK3Mmn8OInnMCQi7MGVHWaaI7/tA0KFnwFm6BGbA7bxbZPsVeK1XV/3NhVP8117V8581nx+aZ4L3OUrbpPFohgscf8DnhxBYACOJZgFf6rTy7cQKtaa8bLUnCV89ZV5Yx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057539; c=relaxed/simple;
	bh=70WWJsefY5AJj0fmdgj8Lt3N5gfz0vU0eyhh1HU5ERg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qZaH7f73NloUNGzTF9g/eTvRJzJdZFLryU4SFn6Cb6bGK6xCgRDEjtIwE94At0C5TPgvTuipxKUXgX1zfNs7Dgt5XPmOzpZPHomyIsskDY4fh02FgJlhfllBrhQK+/5z8rVICOxClNOSrQwP4sYfhR1J0vBmdcEIKWQghtXnP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GiaYgaG+; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-471fc73b941so26001911cf.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 05:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740057536; x=1740662336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IsduY17fs31Wtu/GTb0EKi16sOjUJDW1IHAxmZt3EnQ=;
        b=GiaYgaG+yl5dg/lnYegGOObkVW6RbIOT7gXtNHqK+4+5aE0seVDbdC1qR6KtgtUYfn
         kcz2WnNtqENrQOCKhT7j2M1Ync6FK0vBoHtSYjYz8c5qezDSD6mCrAfJ6AI71GT0y2iz
         Tad7xx9nHz7HHgIY0WRelHw99aVCC3PnxWH0UTnc8kQ00cATKZSpRazsCX+Clm3r0doy
         OqLr11szttpd9kN29FnvxwbGqThj+bawYxaeGChTgmEo+REipZMuUTiSPdBiIGUpTm5n
         1LMtHPyop5TZ5PtPtO0/Wan3XRyfi42Opl3IutCc2URv4wtyh8Tb4X7LhaUW+ESOeiTQ
         HE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057536; x=1740662336;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsduY17fs31Wtu/GTb0EKi16sOjUJDW1IHAxmZt3EnQ=;
        b=g6bfkHkZXjS3Q4vHk0cH4EKzq9AtaQJrvKd7qI3srzCas+Zp1PExpGyH7+B+xsJ88k
         TLF3w0qExxa/cRTBUIbV4cbu2iSTtqXSMOmdoLJtJM4Oh+vU6tcJJ1MaYDekDO4awVu6
         70gEaA3aiUOgrLMDkBe0ZVlqTYFBN5GhWt8NusaOtN8hVFz1FXSo6hQT4fyN5gUb43QN
         /Dgt+RdicewMg2LwT9oMdc7LGSkwx6fFKkMwH6GuNbAe/WwiI8Htwb2e7jXpgtmIoM8G
         8PinAgbLEP7j63TaA71Fm5xoQHiaDD0MadfqaxyuOyJ+8FNYxyJWMj3aZN6zHBBjCmOM
         htxg==
X-Gm-Message-State: AOJu0YyD2wiTpzNAQmCMXWO/q8wA7N0L2+D2ENo+pKdVMZbsYZoNWq6X
	xVBlNFxYUARGa3KNI0kE0lA5eR1kfNub8/x6vLR0stBsicJfDZJd2EqAFA/0TiByCZCqr60C2is
	z/LUAd3Z/Yw==
X-Google-Smtp-Source: AGHT+IEBMoWviumGa3L/rheNv5qCLPp3x9oke2I3E9S7pALBLwRX+bma6dIDtKD+Io/gVg8c1WzKSqpg6Aaczg==
X-Received: from qtbfj27.prod.google.com ([2002:a05:622a:551b:b0:472:1c8:89ba])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1654:b0:471:f2c3:9447 with SMTP id d75a77b69052e-471f2d2daf8mr216820051cf.48.1740057535998;
 Thu, 20 Feb 2025 05:18:55 -0800 (PST)
Date: Thu, 20 Feb 2025 13:18:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220131854.4048077-1-edumazet@google.com>
Subject: [PATCH net] net: better track kernel sockets lifetime
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+30a19e01a97420719891@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

While kernel sockets are dismantled during pernet_operations->exit(),
their freeing can be delayed by any tx packets still held in qdisc
or device queues, due to skb_set_owner_w() prior calls.

This then trigger the following warning from ref_tracker_dir_exit() [1]

To fix this, make sure that kernel sockets own a reference on net->passive.

Add sk_net_refcnt_upgrade() helper, used whenever a kernel socket
is converted to a refcounted one.

[1]

[  136.263918][   T35] ref_tracker: net notrefcnt@ffff8880638f01e0 has 1/2 users at
[  136.263918][   T35]      sk_alloc+0x2b3/0x370
[  136.263918][   T35]      inet6_create+0x6ce/0x10f0
[  136.263918][   T35]      __sock_create+0x4c0/0xa30
[  136.263918][   T35]      inet_ctl_sock_create+0xc2/0x250
[  136.263918][   T35]      igmp6_net_init+0x39/0x390
[  136.263918][   T35]      ops_init+0x31e/0x590
[  136.263918][   T35]      setup_net+0x287/0x9e0
[  136.263918][   T35]      copy_net_ns+0x33f/0x570
[  136.263918][   T35]      create_new_namespaces+0x425/0x7b0
[  136.263918][   T35]      unshare_nsproxy_namespaces+0x124/0x180
[  136.263918][   T35]      ksys_unshare+0x57d/0xa70
[  136.263918][   T35]      __x64_sys_unshare+0x38/0x40
[  136.263918][   T35]      do_syscall_64+0xf3/0x230
[  136.263918][   T35]      entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  136.263918][   T35]
[  136.343488][   T35] ref_tracker: net notrefcnt@ffff8880638f01e0 has 1/2 users at
[  136.343488][   T35]      sk_alloc+0x2b3/0x370
[  136.343488][   T35]      inet6_create+0x6ce/0x10f0
[  136.343488][   T35]      __sock_create+0x4c0/0xa30
[  136.343488][   T35]      inet_ctl_sock_create+0xc2/0x250
[  136.343488][   T35]      ndisc_net_init+0xa7/0x2b0
[  136.343488][   T35]      ops_init+0x31e/0x590
[  136.343488][   T35]      setup_net+0x287/0x9e0
[  136.343488][   T35]      copy_net_ns+0x33f/0x570
[  136.343488][   T35]      create_new_namespaces+0x425/0x7b0
[  136.343488][   T35]      unshare_nsproxy_namespaces+0x124/0x180
[  136.343488][   T35]      ksys_unshare+0x57d/0xa70
[  136.343488][   T35]      __x64_sys_unshare+0x38/0x40
[  136.343488][   T35]      do_syscall_64+0xf3/0x230
[  136.343488][   T35]      entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 0cafd77dcd03 ("net: add a refcount tracker for kernel sockets")
Reported-by: syzbot+30a19e01a97420719891@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67b72aeb.050a0220.14d86d.0283.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h       |  1 +
 net/core/sock.c          | 27 ++++++++++++++++++++++-----
 net/mptcp/subflow.c      |  5 +----
 net/netlink/af_netlink.c | 10 ----------
 net/rds/tcp.c            |  8 ++------
 net/smc/af_smc.c         |  5 +----
 net/sunrpc/svcsock.c     |  5 +----
 net/sunrpc/xprtsock.c    |  8 ++------
 8 files changed, 30 insertions(+), 39 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8be64550dcfd6ce213039460acb1f..7ef728324e4e7e6e9cfa7aad56d4f46b29de2e06 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1751,6 +1751,7 @@ static inline bool sock_allow_reclassification(const struct sock *csk)
 struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 		      struct proto *prot, int kern);
 void sk_free(struct sock *sk);
+void sk_net_refcnt_upgrade(struct sock *sk);
 void sk_destruct(struct sock *sk);
 struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority);
 void sk_free_unlock_clone(struct sock *sk);
diff --git a/net/core/sock.c b/net/core/sock.c
index eae2ae70a2e03df370d8ef7750a7bb13cc3b8d8f..6c0e87f97fa4a7220950ff576b10291e3e55731d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2246,6 +2246,7 @@ struct sock *sk_alloc(struct net *net, int family, gfp_t priority,
 			get_net_track(net, &sk->ns_tracker, priority);
 			sock_inuse_add(net, 1);
 		} else {
+			net_passive_inc(net);
 			__netns_tracker_alloc(net, &sk->ns_tracker,
 					      false, priority);
 		}
@@ -2270,6 +2271,7 @@ EXPORT_SYMBOL(sk_alloc);
 static void __sk_destruct(struct rcu_head *head)
 {
 	struct sock *sk = container_of(head, struct sock, sk_rcu);
+	struct net *net = sock_net(sk);
 	struct sk_filter *filter;
 
 	if (sk->sk_destruct)
@@ -2301,14 +2303,28 @@ static void __sk_destruct(struct rcu_head *head)
 	put_cred(sk->sk_peer_cred);
 	put_pid(sk->sk_peer_pid);
 
-	if (likely(sk->sk_net_refcnt))
-		put_net_track(sock_net(sk), &sk->ns_tracker);
-	else
-		__netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
-
+	if (likely(sk->sk_net_refcnt)) {
+		put_net_track(net, &sk->ns_tracker);
+	} else {
+		__netns_tracker_free(net, &sk->ns_tracker, false);
+		net_passive_dec(net);
+	}
 	sk_prot_free(sk->sk_prot_creator, sk);
 }
 
+void sk_net_refcnt_upgrade(struct sock *sk)
+{
+	struct net *net = sock_net(sk);
+
+	WARN_ON_ONCE(sk->sk_net_refcnt);
+	__netns_tracker_free(net, &sk->ns_tracker, false);
+	net_passive_dec(net);
+	sk->sk_net_refcnt = 1;
+	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
+	sock_inuse_add(net, 1);
+}
+EXPORT_SYMBOL_GPL(sk_net_refcnt_upgrade);
+
 void sk_destruct(struct sock *sk)
 {
 	bool use_call_rcu = sock_flag(sk, SOCK_RCU_FREE);
@@ -2405,6 +2421,7 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 		 * is not properly dismantling its kernel sockets at netns
 		 * destroy time.
 		 */
+		net_passive_inc(sock_net(newsk));
 		__netns_tracker_alloc(sock_net(newsk), &newsk->ns_tracker,
 				      false, priority);
 	}
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index fd021cf8286eff9234b950a4d4c083ea7756eba3..dfcbef9c46246983d21c827d9551d4eb2c95430e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1772,10 +1772,7 @@ int mptcp_subflow_create_socket(struct sock *sk, unsigned short family,
 	 * needs it.
 	 * Update ns_tracker to current stack trace and refcounted tracker.
 	 */
-	__netns_tracker_free(net, &sf->sk->ns_tracker, false);
-	sf->sk->sk_net_refcnt = 1;
-	get_net_track(net, &sf->sk->ns_tracker, GFP_KERNEL);
-	sock_inuse_add(net, 1);
+	sk_net_refcnt_upgrade(sf->sk);
 	err = tcp_set_ulp(sf->sk, "mptcp");
 	if (err)
 		goto err_free;
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 85311226183a259574c64643eae9e906ccc9c1da..a53ea60d0a78d1b739ab392b16d383686c613d7f 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -795,16 +795,6 @@ static int netlink_release(struct socket *sock)
 
 	sock_prot_inuse_add(sock_net(sk), &netlink_proto, -1);
 
-	/* Because struct net might disappear soon, do not keep a pointer. */
-	if (!sk->sk_net_refcnt && sock_net(sk) != &init_net) {
-		__netns_tracker_free(sock_net(sk), &sk->ns_tracker, false);
-		/* Because of deferred_put_nlk_sk and use of work queue,
-		 * it is possible  netns will be freed before this socket.
-		 */
-		sock_net_set(sk, &init_net);
-		__netns_tracker_alloc(&init_net, &sk->ns_tracker,
-				      false, GFP_KERNEL);
-	}
 	call_rcu(&nlk->rcu, deferred_put_nlk_sk);
 	return 0;
 }
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 0581c53e6517043ad6c2ad4207b26ab169989ed8..3cc2f303bf786579a77b8b67ddc77468e085a3d3 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -504,12 +504,8 @@ bool rds_tcp_tune(struct socket *sock)
 			release_sock(sk);
 			return false;
 		}
-		/* Update ns_tracker to current stack trace and refcounted tracker */
-		__netns_tracker_free(net, &sk->ns_tracker, false);
-
-		sk->sk_net_refcnt = 1;
-		netns_tracker_alloc(net, &sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
+		sk_net_refcnt_upgrade(sk);
+		put_net(net);
 	}
 	rtn = net_generic(net, rds_tcp_netid);
 	if (rtn->sndbuf_size > 0) {
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index ca6984541edbda33a3539a48ed7c2aefecfa690e..3e6cb35baf25aff51518fe98a0bcbf1c3cec1629 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -3337,10 +3337,7 @@ int smc_create_clcsk(struct net *net, struct sock *sk, int family)
 	 * which need net ref.
 	 */
 	sk = smc->clcsock->sk;
-	__netns_tracker_free(net, &sk->ns_tracker, false);
-	sk->sk_net_refcnt = 1;
-	get_net_track(net, &sk->ns_tracker, GFP_KERNEL);
-	sock_inuse_add(net, 1);
+	sk_net_refcnt_upgrade(sk);
 	return 0;
 }
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index cb3bd12f5818bad13226d9b91be2881c55f56bc2..72e5a01df3d352582a5c25e0b8081a041e3792ee 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1541,10 +1541,7 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	newlen = error;
 
 	if (protocol == IPPROTO_TCP) {
-		__netns_tracker_free(net, &sock->sk->ns_tracker, false);
-		sock->sk->sk_net_refcnt = 1;
-		get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(net, 1);
+		sk_net_refcnt_upgrade(sock->sk);
 		if ((error = kernel_listen(sock, 64)) < 0)
 			goto bummer;
 	}
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c60936d8cef71b3eb7937a3ec8dd8a4edbaaff10..940fe65b2a3511933a3f87465cdee1095ec096c6 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1941,12 +1941,8 @@ static struct socket *xs_create_sock(struct rpc_xprt *xprt,
 		goto out;
 	}
 
-	if (protocol == IPPROTO_TCP) {
-		__netns_tracker_free(xprt->xprt_net, &sock->sk->ns_tracker, false);
-		sock->sk->sk_net_refcnt = 1;
-		get_net_track(xprt->xprt_net, &sock->sk->ns_tracker, GFP_KERNEL);
-		sock_inuse_add(xprt->xprt_net, 1);
-	}
+	if (protocol == IPPROTO_TCP)
+		sk_net_refcnt_upgrade(sock->sk);
 
 	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
 	if (IS_ERR(filp))
-- 
2.48.1.601.g30ceb7b040-goog


