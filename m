Return-Path: <netdev+bounces-76397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB686D9AB
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD2D281C7D
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643033B798;
	Fri,  1 Mar 2024 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="InbLZs9q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4730F3BB3F
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259811; cv=none; b=UCwhNK41NORPYbE+RuMxDrgXci4zAh6NyhuSa9vEHWxxAqjhYl6U+MqBb27CwsT5okcCMRgaOsrrvWnf1PILxTcOCMAAbmUe0ZTniCaEkcKOFvHc7uKfP9y/Gq7DoCJjq+/MIXTzJz3hJZatFAMeuKiE74Xxdu8VYW3OlY5+AE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259811; c=relaxed/simple;
	bh=7p09WJiSGsXQo7PM/MWCnQsbBhKl3oZQNHb6ZPosCB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuVMpWvfyfy6RRGLiOu7QIoNL7VultzwPII72urjRWUz3YT26xcUKee3m/XTt8mpMsYDH7iBJ0LbExE7jVox5t4JzpTrdlKitpUBnXilJS9WvPAMvne1yD49UeQkf4QI0UZF8eS8kXu5iSRi0l54KWBp5Y0XkTrc7PxUR0z5Vd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=InbLZs9q; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709259810; x=1740795810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Asgho1UWYenYA2GErEKKF8xNZYxLWHCdH/1HGwxHS7Y=;
  b=InbLZs9qAvippVOpYjX36Lwc6QAKhHP4AzcIvQ3wdiVfvpyU7qoEXB7E
   i3qqj4Z+uBwrKGImiwCZ3D6xN7qwyKS6LSS6pzF80urKsyUse5y58HPba
   N7zRtgpf2u81IMMmgeNJtn16hOC34s9RA5zMRxJ2GKHpSYqNI7lEn/9oE
   0=;
X-IronPort-AV: E=Sophos;i="6.06,194,1705363200"; 
   d="scan'208";a="616601697"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 02:23:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:22878]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.52:2525] with esmtp (Farcaster)
 id 3eef6aa0-737b-4534-9f74-a85b13888ade; Fri, 1 Mar 2024 02:23:25 +0000 (UTC)
X-Farcaster-Flow-ID: 3eef6aa0-737b-4534-9f74-a85b13888ade
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:23:25 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:23:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 01/15] af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
Date: Thu, 29 Feb 2024 18:22:29 -0800
Message-ID: <20240301022243.73908-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301022243.73908-1-kuniyu@amazon.com>
References: <20240301022243.73908-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will replace the garbage collection algorithm for AF_UNIX, where
we will consider each inflight AF_UNIX socket as a vertex and its file
descriptor as an edge in a directed graph.

This patch introduces a new struct unix_vertex representing a vertex
in the graph and adds its pointer to struct unix_sock.

When we send a fd using the SCM_RIGHTS message, we allocate struct
scm_fp_list to struct scm_cookie in scm_fp_copy().  Then, we bump
each refcount of the inflight fds' struct file and save them in
scm_fp_list.fp.

After that, unix_attach_fds() inexplicably clones scm_fp_list of
scm_cookie and sets it to skb.  (We will remove this part after
replacing GC.)

Here, we add a new function call in unix_attach_fds() to preallocate
struct unix_vertex per inflight AF_UNIX fd and link each vertex to
skb's scm_fp_list.vertices.

When sendmsg() succeeds later, if the socket of the inflight fd is
still not inflight yet, we will set the preallocated vertex to struct
unix_sock.vertex and link it to a global list unix_unvisited_vertices
under spin_lock(&unix_gc_lock).

If the socket is already inflight, we free the preallocated vertex.
This is to avoid taking the lock unnecessarily when sendmsg() could
fail later.

In the following patch, we will similarly allocate another struct
per edge, which will finally be linked to the inflight socket's
unix_vertex.edges.

And then, we will count the number of edges as unix_vertex.out_degree.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  9 +++++++++
 include/net/scm.h     |  3 +++
 net/core/scm.c        |  7 +++++++
 net/unix/af_unix.c    |  6 ++++++
 net/unix/garbage.c    | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 627ea8e2d915..c270877a5256 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -22,9 +22,17 @@ extern unsigned int unix_tot_inflight;
 
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
+int unix_prepare_fpl(struct scm_fp_list *fpl);
+void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
 
+struct unix_vertex {
+	struct list_head edges;
+	struct list_head entry;
+	unsigned long out_degree;
+};
+
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
@@ -62,6 +70,7 @@ struct unix_sock {
 	struct path		path;
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
+	struct unix_vertex	*vertex;
 	struct list_head	link;
 	unsigned long		inflight;
 	spinlock_t		lock;
diff --git a/include/net/scm.h b/include/net/scm.h
index 92276a2c5543..e34321b6e204 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -27,6 +27,9 @@ struct scm_fp_list {
 	short			count;
 	short			count_unix;
 	short			max;
+#ifdef CONFIG_UNIX
+	struct list_head	vertices;
+#endif
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
 };
diff --git a/net/core/scm.c b/net/core/scm.c
index 9cd4b0a01cd6..87dfec1c3378 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -89,6 +89,9 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		fpl->count_unix = 0;
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
+#if IS_ENABLED(CONFIG_UNIX)
+		INIT_LIST_HEAD(&fpl->vertices);
+#endif
 	}
 	fpp = &fpl->fp[fpl->count];
 
@@ -376,8 +379,12 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 	if (new_fpl) {
 		for (i = 0; i < fpl->count; i++)
 			get_file(fpl->fp[i]);
+
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
+#if IS_ENABLED(CONFIG_UNIX)
+		INIT_LIST_HEAD(&new_fpl->vertices);
+#endif
 	}
 	return new_fpl;
 }
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5b41e2321209..a3b25d311560 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -980,6 +980,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
 	u->inflight = 0;
+	u->vertex = NULL;
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
@@ -1805,6 +1806,9 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	for (i = scm->fp->count - 1; i >= 0; i--)
 		unix_inflight(scm->fp->user, scm->fp->fp[i]);
 
+	if (unix_prepare_fpl(UNIXCB(skb).fp))
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1815,6 +1819,8 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	scm->fp = UNIXCB(skb).fp;
 	UNIXCB(skb).fp = NULL;
 
+	unix_destroy_fpl(scm->fp);
+
 	for (i = scm->fp->count - 1; i >= 0; i--)
 		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
 }
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index fa39b6265238..75bdf66b81df 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,44 @@ struct unix_sock *unix_get_socket(struct file *filp)
 	return NULL;
 }
 
+static void unix_free_vertices(struct scm_fp_list *fpl)
+{
+	struct unix_vertex *vertex, *next_vertex;
+
+	list_for_each_entry_safe(vertex, next_vertex, &fpl->vertices, entry) {
+		list_del(&vertex->entry);
+		kfree(vertex);
+	}
+}
+
+int unix_prepare_fpl(struct scm_fp_list *fpl)
+{
+	struct unix_vertex *vertex;
+	int i;
+
+	if (!fpl->count_unix)
+		return 0;
+
+	for (i = 0; i < fpl->count_unix; i++) {
+		vertex = kmalloc(sizeof(*vertex), GFP_KERNEL);
+		if (!vertex)
+			goto err;
+
+		list_add(&vertex->entry, &fpl->vertices);
+	}
+
+	return 0;
+
+err:
+	unix_free_vertices(fpl);
+	return -ENOMEM;
+}
+
+void unix_destroy_fpl(struct scm_fp_list *fpl)
+{
+	unix_free_vertices(fpl);
+}
+
 DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
-- 
2.30.2


