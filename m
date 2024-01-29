Return-Path: <netdev+bounces-66853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF71F84130B
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46B47B261DC
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42129CFB;
	Mon, 29 Jan 2024 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rl+xu33z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15F51E53A
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555172; cv=none; b=dFkrnSz3vT2jwkZL8QCHAItpPVJQrhOS9WnnX9nyVN7ypYETcYq47K3rziIOrdkaF2/XrWGqn/4PiAeLP1fUfwHB4XRFdMvQkAZzGhOxxRM3qWJNIFrS7qo9948f5paj/NrcyLjmxmsEY2hHt37mO/aIpdzsoeAFveT178fS49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555172; c=relaxed/simple;
	bh=nBKZdJ0yDkFx21OZklsGspw7X1VlNywOf4NY9YIoA+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvrrNlk8eLNDQl4BgkSInzFaLnVA2LKFPOqoSieJkJHSW0rYH42Cag0Hl4pCPtgTOP1h1hcGvOlA6A37A6AOQb+BtglyQZcohRjyTPCrC2TJZqVh7o2PXCGKQUJqxZ5JeJgNBLBgiBisF5J47BDUo6Zi1cCBNALbBejvRGVzJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rl+xu33z; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706555170; x=1738091170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j1ULfilaOtXdZvu0heBeN/JYzdzMu9mtQbhaeKnEl+M=;
  b=Rl+xu33zVkgjxbQImDVCE19xMR4Eaf8weAftwbPtBmp4lKIoIt+0Kjgq
   QRI92YYUDZYF9iMa0acMxw6CUy9s8xfcf6fHNnSooiLeqKur97RSbfgdJ
   Dz0Pqn1tzEBbz9ilaPWAro2Iwl+3bvoaKerZdUJQ8ZzkF6HKV7Em6n8FH
   I=;
X-IronPort-AV: E=Sophos;i="6.05,227,1701129600"; 
   d="scan'208";a="62045564"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 19:06:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id 59C7140BBD;
	Mon, 29 Jan 2024 19:06:06 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:49417]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.136:2525] with esmtp (Farcaster)
 id a63f1b7c-3a81-49cc-8e52-228e0a95b5cb; Mon, 29 Jan 2024 19:06:05 +0000 (UTC)
X-Farcaster-Flow-ID: a63f1b7c-3a81-49cc-8e52-228e0a95b5cb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 19:06:03 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 19:06:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/3] af_unix: Remove CONFIG_UNIX_SCM.
Date: Mon, 29 Jan 2024 11:04:35 -0800
Message-ID: <20240129190435.57228-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240129190435.57228-1-kuniyu@amazon.com>
References: <20240129190435.57228-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Originally, the code related to garbage collection was all in garbage.c.

Commit f4e65870e5ce ("net: split out functions related to registering
inflight socket files") moved some functions to scm.c for io_uring and
added CONFIG_UNIX_SCM just in case AF_UNIX was built as module.

However, since commit 97154bcf4d1b ("af_unix: Kconfig: make CONFIG_UNIX
bool"), AF_UNIX is no longer built separately.  Also, io_uring does not
support SCM_RIGHTS now.

Let's move the functions back to garbage.c

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |   7 +-
 net/Makefile          |   2 +-
 net/unix/Kconfig      |   5 --
 net/unix/Makefile     |   2 -
 net/unix/af_unix.c    |  63 +++++++++++++++++-
 net/unix/garbage.c    |  73 +++++++++++++++++++-
 net/unix/scm.c        | 150 ------------------------------------------
 net/unix/scm.h        |  10 ---
 8 files changed, 137 insertions(+), 175 deletions(-)
 delete mode 100644 net/unix/scm.c
 delete mode 100644 net/unix/scm.h

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 9e39b2ec4524..54e346152eb1 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -17,19 +17,20 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
 }
 #endif
 
+extern spinlock_t unix_gc_lock;
+extern unsigned int unix_tot_inflight;
+
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
-void unix_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
+
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
 #define UNIX_HASH_SIZE	(256 * 2)
 #define UNIX_HASH_BITS	8
 
-extern unsigned int unix_tot_inflight;
-
 struct unix_address {
 	refcount_t	refcnt;
 	int		len;
diff --git a/net/Makefile b/net/Makefile
index b06b5539e7a6..65bb8c72a35e 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_NETFILTER)		+= netfilter/
 obj-$(CONFIG_INET)		+= ipv4/
 obj-$(CONFIG_TLS)		+= tls/
 obj-$(CONFIG_XFRM)		+= xfrm/
-obj-$(CONFIG_UNIX_SCM)		+= unix/
+obj-$(CONFIG_UNIX)		+= unix/
 obj-y				+= ipv6/
 obj-$(CONFIG_PACKET)		+= packet/
 obj-$(CONFIG_NET_KEY)		+= key/
diff --git a/net/unix/Kconfig b/net/unix/Kconfig
index 28b232f281ab..8b5d04210d7c 100644
--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -16,11 +16,6 @@ config UNIX
 
 	  Say Y unless you know what you are doing.
 
-config UNIX_SCM
-	bool
-	depends on UNIX
-	default y
-
 config	AF_UNIX_OOB
 	bool
 	depends on UNIX
diff --git a/net/unix/Makefile b/net/unix/Makefile
index 20491825b4d0..4ddd125c4642 100644
--- a/net/unix/Makefile
+++ b/net/unix/Makefile
@@ -11,5 +11,3 @@ unix-$(CONFIG_BPF_SYSCALL) += unix_bpf.o
 
 obj-$(CONFIG_UNIX_DIAG)	+= unix_diag.o
 unix_diag-y		:= diag.o
-
-obj-$(CONFIG_UNIX_SCM)	+= scm.o
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1720419d93d6..1cfbc586adb4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -118,8 +118,6 @@
 #include <linux/btf_ids.h>
 #include <linux/bpf-cgroup.h>
 
-#include "scm.h"
-
 static atomic_long_t unix_nr_socks;
 static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
 static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
@@ -1790,6 +1788,52 @@ static int unix_getname(struct socket *sock, struct sockaddr *uaddr, int peer)
 	return err;
 }
 
+/* The "user->unix_inflight" variable is protected by the garbage
+ * collection lock, and we just read it locklessly here. If you go
+ * over the limit, there might be a tiny race in actually noticing
+ * it across threads. Tough.
+ */
+static inline bool too_many_unix_fds(struct task_struct *p)
+{
+	struct user_struct *user = current_user();
+
+	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
+		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+	return false;
+}
+
+static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
+{
+	int i;
+
+	if (too_many_unix_fds(current))
+		return -ETOOMANYREFS;
+
+	/* Need to duplicate file references for the sake of garbage
+	 * collection.  Otherwise a socket in the fps might become a
+	 * candidate for GC while the skb is not yet queued.
+	 */
+	UNIXCB(skb).fp = scm_fp_dup(scm->fp);
+	if (!UNIXCB(skb).fp)
+		return -ENOMEM;
+
+	for (i = scm->fp->count - 1; i >= 0; i--)
+		unix_inflight(scm->fp->user, scm->fp->fp[i]);
+
+	return 0;
+}
+
+static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
+{
+	int i;
+
+	scm->fp = UNIXCB(skb).fp;
+	UNIXCB(skb).fp = NULL;
+
+	for (i = scm->fp->count - 1; i >= 0; i--)
+		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
+}
+
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
@@ -1837,6 +1881,21 @@ static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	spin_unlock(&unix_gc_lock);
 }
 
+static void unix_destruct_scm(struct sk_buff *skb)
+{
+	struct scm_cookie scm;
+
+	memset(&scm, 0, sizeof(scm));
+	scm.pid  = UNIXCB(skb).pid;
+	if (UNIXCB(skb).fp)
+		unix_detach_fds(&scm, skb);
+
+	/* Alas, it calls VFS */
+	/* So fscking what? fput() had been SMP-safe since the last Summer */
+	scm_destroy(&scm);
+	sock_wfree(skb);
+}
+
 static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool send_fds)
 {
 	int err = 0;
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index ce5b5f87b16e..9b8473dd79a4 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -81,11 +81,80 @@
 #include <net/scm.h>
 #include <net/tcp_states.h>
 
-#include "scm.h"
+struct unix_sock *unix_get_socket(struct file *filp)
+{
+	struct inode *inode = file_inode(filp);
+
+	/* Socket ? */
+	if (S_ISSOCK(inode->i_mode) && !(filp->f_mode & FMODE_PATH)) {
+		struct socket *sock = SOCKET_I(inode);
+		const struct proto_ops *ops;
+		struct sock *sk = sock->sk;
 
-/* Internal data structures and random procedures: */
+		ops = READ_ONCE(sock->ops);
 
+		/* PF_UNIX ? */
+		if (sk && ops && ops->family == PF_UNIX)
+			return unix_sk(sk);
+	}
+
+	return NULL;
+}
+
+DEFINE_SPINLOCK(unix_gc_lock);
+unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
+static LIST_HEAD(gc_inflight_list);
+
+/* Keep the number of times in flight count for the file
+ * descriptor if it is for an AF_UNIX socket.
+ */
+void unix_inflight(struct user_struct *user, struct file *filp)
+{
+	struct unix_sock *u = unix_get_socket(filp);
+
+	spin_lock(&unix_gc_lock);
+
+	if (u) {
+		if (!u->inflight) {
+			WARN_ON_ONCE(!list_empty(&u->link));
+			list_add_tail(&u->link, &gc_inflight_list);
+		} else {
+			WARN_ON_ONCE(list_empty(&u->link));
+		}
+		u->inflight++;
+
+		/* Paired with READ_ONCE() in wait_for_unix_gc() */
+		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
+	}
+
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
+
+	spin_unlock(&unix_gc_lock);
+}
+
+void unix_notinflight(struct user_struct *user, struct file *filp)
+{
+	struct unix_sock *u = unix_get_socket(filp);
+
+	spin_lock(&unix_gc_lock);
+
+	if (u) {
+		WARN_ON_ONCE(!u->inflight);
+		WARN_ON_ONCE(list_empty(&u->link));
+
+		u->inflight--;
+		if (!u->inflight)
+			list_del_init(&u->link);
+
+		/* Paired with READ_ONCE() in wait_for_unix_gc() */
+		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
+	}
+
+	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
+
+	spin_unlock(&unix_gc_lock);
+}
 
 static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			  struct sk_buff_head *hitlist)
diff --git a/net/unix/scm.c b/net/unix/scm.c
deleted file mode 100644
index db65b0ab5947..000000000000
--- a/net/unix/scm.c
+++ /dev/null
@@ -1,150 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/socket.h>
-#include <linux/net.h>
-#include <linux/fs.h>
-#include <net/af_unix.h>
-#include <net/scm.h>
-#include <linux/init.h>
-#include <linux/io_uring.h>
-
-#include "scm.h"
-
-unsigned int unix_tot_inflight;
-EXPORT_SYMBOL(unix_tot_inflight);
-
-LIST_HEAD(gc_inflight_list);
-EXPORT_SYMBOL(gc_inflight_list);
-
-DEFINE_SPINLOCK(unix_gc_lock);
-EXPORT_SYMBOL(unix_gc_lock);
-
-struct unix_sock *unix_get_socket(struct file *filp)
-{
-	struct inode *inode = file_inode(filp);
-
-	/* Socket ? */
-	if (S_ISSOCK(inode->i_mode) && !(filp->f_mode & FMODE_PATH)) {
-		struct socket *sock = SOCKET_I(inode);
-		const struct proto_ops *ops = READ_ONCE(sock->ops);
-		struct sock *s = sock->sk;
-
-		/* PF_UNIX ? */
-		if (s && ops && ops->family == PF_UNIX)
-			return unix_sk(s);
-	}
-
-	return NULL;
-}
-EXPORT_SYMBOL(unix_get_socket);
-
-/* Keep the number of times in flight count for the file
- * descriptor if it is for an AF_UNIX socket.
- */
-void unix_inflight(struct user_struct *user, struct file *fp)
-{
-	struct unix_sock *u = unix_get_socket(fp);
-
-	spin_lock(&unix_gc_lock);
-
-	if (u) {
-		if (!u->inflight) {
-			WARN_ON_ONCE(!list_empty(&u->link));
-			list_add_tail(&u->link, &gc_inflight_list);
-		} else {
-			WARN_ON_ONCE(list_empty(&u->link));
-		}
-		u->inflight++;
-		/* Paired with READ_ONCE() in wait_for_unix_gc() */
-		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
-	}
-	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
-	spin_unlock(&unix_gc_lock);
-}
-
-void unix_notinflight(struct user_struct *user, struct file *fp)
-{
-	struct unix_sock *u = unix_get_socket(fp);
-
-	spin_lock(&unix_gc_lock);
-
-	if (u) {
-		WARN_ON_ONCE(!u->inflight);
-		WARN_ON_ONCE(list_empty(&u->link));
-
-		u->inflight--;
-		if (!u->inflight)
-			list_del_init(&u->link);
-		/* Paired with READ_ONCE() in wait_for_unix_gc() */
-		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
-	}
-	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
-	spin_unlock(&unix_gc_lock);
-}
-
-/*
- * The "user->unix_inflight" variable is protected by the garbage
- * collection lock, and we just read it locklessly here. If you go
- * over the limit, there might be a tiny race in actually noticing
- * it across threads. Tough.
- */
-static inline bool too_many_unix_fds(struct task_struct *p)
-{
-	struct user_struct *user = current_user();
-
-	if (unlikely(READ_ONCE(user->unix_inflight) > task_rlimit(p, RLIMIT_NOFILE)))
-		return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
-	return false;
-}
-
-int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
-{
-	int i;
-
-	if (too_many_unix_fds(current))
-		return -ETOOMANYREFS;
-
-	/*
-	 * Need to duplicate file references for the sake of garbage
-	 * collection.  Otherwise a socket in the fps might become a
-	 * candidate for GC while the skb is not yet queued.
-	 */
-	UNIXCB(skb).fp = scm_fp_dup(scm->fp);
-	if (!UNIXCB(skb).fp)
-		return -ENOMEM;
-
-	for (i = scm->fp->count - 1; i >= 0; i--)
-		unix_inflight(scm->fp->user, scm->fp->fp[i]);
-	return 0;
-}
-EXPORT_SYMBOL(unix_attach_fds);
-
-void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
-{
-	int i;
-
-	scm->fp = UNIXCB(skb).fp;
-	UNIXCB(skb).fp = NULL;
-
-	for (i = scm->fp->count-1; i >= 0; i--)
-		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
-}
-EXPORT_SYMBOL(unix_detach_fds);
-
-void unix_destruct_scm(struct sk_buff *skb)
-{
-	struct scm_cookie scm;
-
-	memset(&scm, 0, sizeof(scm));
-	scm.pid  = UNIXCB(skb).pid;
-	if (UNIXCB(skb).fp)
-		unix_detach_fds(&scm, skb);
-
-	/* Alas, it calls VFS */
-	/* So fscking what? fput() had been SMP-safe since the last Summer */
-	scm_destroy(&scm);
-	sock_wfree(skb);
-}
-EXPORT_SYMBOL(unix_destruct_scm);
diff --git a/net/unix/scm.h b/net/unix/scm.h
deleted file mode 100644
index 5a255a477f16..000000000000
--- a/net/unix/scm.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef NET_UNIX_SCM_H
-#define NET_UNIX_SCM_H
-
-extern struct list_head gc_inflight_list;
-extern spinlock_t unix_gc_lock;
-
-int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb);
-void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb);
-
-#endif
-- 
2.30.2


