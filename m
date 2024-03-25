Return-Path: <netdev+bounces-81760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007EE88B143
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A981830061E
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C471245026;
	Mon, 25 Mar 2024 20:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A40rn+OK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52D43AB6
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398307; cv=none; b=U4JDPlVxerBpy+YRwrhYY0DnhVy0pBT1f4YkNL0r1giOiKikxJPr/X9/0nfRs/5Qr2we9dD+B8stmY2BosMX4nTieWeCrDXgNd1sNap3ltaDULX5Gg5U/8mFLn9WsaNN1tbaaeIJJQp7yIx8RjiEetyCf3fTdNUJ0W3UrrrClms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398307; c=relaxed/simple;
	bh=7p09WJiSGsXQo7PM/MWCnQsbBhKl3oZQNHb6ZPosCB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a81JH5PO/OdwiWvHN063ECWARF/AF+MPHgHh/0BLBRV8omhztdLDa7/nHnZhuRvIUklZwPTQUUelshp95vN39uD6pFPwnlVUzTbbDfcNjGfUGiSkIhpQbwtBbeUWLJX2Ck/Q+iCxnNcoXWyPD8fkbItL+5IAc816tu8Tg3OtpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A40rn+OK; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398307; x=1742934307;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Asgho1UWYenYA2GErEKKF8xNZYxLWHCdH/1HGwxHS7Y=;
  b=A40rn+OKjTdjaq3B8kcyc2ZUFEP5wjB+5+rejPUtk8J66hf+kRl9AkwD
   iVcpjPg52VoHFHKw4yYkfB93Tj4CefwdcB84cAl1BfQeOvdxg13kKJ8AP
   6Mw8xTo86Uhva1zWiY5ygFToNICW6pqd0VuRA+rcAZGgBYQCDB4AZq1V+
   I=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="395948054"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:25:04 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:43025]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.112:2525] with esmtp (Farcaster)
 id 96be7fbe-66ed-4f8a-ac86-6719e46955b8; Mon, 25 Mar 2024 20:25:02 +0000 (UTC)
X-Farcaster-Flow-ID: 96be7fbe-66ed-4f8a-ac86-6719e46955b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:25:02 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:25:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 01/15] af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
Date: Mon, 25 Mar 2024 13:24:11 -0700
Message-ID: <20240325202425.60930-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240325202425.60930-1-kuniyu@amazon.com>
References: <20240325202425.60930-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
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


