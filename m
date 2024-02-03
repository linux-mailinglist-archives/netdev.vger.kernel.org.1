Return-Path: <netdev+bounces-68758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D891B847FC6
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E9A1C220DA
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FBA4C8A;
	Sat,  3 Feb 2024 03:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="O1Z28t5d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2377468
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929328; cv=none; b=QjbI/Qd38bvx+Mqt/O/Ik8To8me095UJGjqbq8mNK+iG0lQzoyNEu9ZevVkeCAI5JNU98HeqzRYPvdeBCUGAbFDXjPpvAKJcWN4ckE75c9il/p93YsSJmvyvj58Ua/5BEyok5WfxCWSmap3XfU2vEPA1SsFlO/M+MKJkj4kV0wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929328; c=relaxed/simple;
	bh=0TdLj9e0qGFO/+kEdxl1deVcWmAWNCaVjE5Nk7++wNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wq3Jvdpy2SkgtmmdeRnTIkw6fo3UckT4IVT285fCzUGGjp14W2Li6rpfVDTeWfUyTSrqVHwE71NMtJe7kN7bQPQ43L3ct3QzqaFoDpQrXfJttrdhNv1K8l+2eyR/OH26KdGoJbt6RShJqJw7yaw/7fBcWErB5g0l4E+wpcFpf0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=O1Z28t5d; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929327; x=1738465327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CCLYCiq1bJzjiE6dyt7cmr9tkPRVxgZCsH/htQydwRw=;
  b=O1Z28t5duDe8SE7DKVCxGdWBTGZZA38lmAOrzVrYD1hhpDJSAzyGznnz
   uXF8JsYnLP1ceEQFnbMVe/LIH4g45EdS/stew3zePnK62FNYe7x/Z3iWT
   aMF2FcUY+VKh5Swu912F0PUd4blW2EJ41HGQQVZ2r3pVP+lzS29fxIRee
   8=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="270771696"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:02:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:9898]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.242:2525] with esmtp (Farcaster)
 id 83fea5bf-8d60-4e63-8d58-ff9e5a05942f; Sat, 3 Feb 2024 03:02:03 +0000 (UTC)
X-Farcaster-Flow-ID: 83fea5bf-8d60-4e63-8d58-ff9e5a05942f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:02:03 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:02:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/16] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
Date: Fri, 2 Feb 2024 19:00:44 -0800
Message-ID: <20240203030058.60750-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240203030058.60750-1-kuniyu@amazon.com>
References: <20240203030058.60750-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When we send fd using SCM_RIGHTS message, we allocate struct
scm_fp_list to struct scm_cookie in scm_fp_copy().  Also, we bump
each refcount of the inflight fds' struct file and save them in
scm_fp_list.fp.

Later, we clone scm_fp_list of scm_cookie and set it to skb in
unix_attach_fds().

Then, we just preallocate to skb's scm_fp_list an array of struct
unix_edge in the number of inflight AF_UNIX fds and do not use them
there because sendmsg() could fail after this point.  The actual
use will be in the next patch.

When we queue skb with inflight edges, we will set the inflight
socket's unix_vertex as unix_edge->predecessor and the receiver's
vertex as successor, and then we will link the edge to the inflight
socket's unix_vertex.edges.

Note that we set NULL to cloned scm_fp_list.edges in scm_fp_dup()
so that MSG_PEEK does not change the shape of the directed graph.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  8 ++++++++
 include/net/scm.h     |  7 +++++++
 net/core/scm.c        |  3 +++
 net/unix/af_unix.c    |  5 +++++
 net/unix/garbage.c    | 18 ++++++++++++++++++
 5 files changed, 41 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 664f6bff60ab..cab9dfb666f3 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -23,6 +23,8 @@ extern unsigned int unix_tot_inflight;
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_init_vertex(struct unix_sock *u);
+int unix_alloc_edges(struct scm_fp_list *fpl);
+void unix_free_edges(struct scm_fp_list *fpl);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
 
@@ -32,6 +34,12 @@ struct unix_vertex {
 	unsigned long out_degree;
 };
 
+struct unix_edge {
+	struct unix_vertex *predecessor;
+	struct unix_vertex *successor;
+	struct list_head entry;
+};
+
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
diff --git a/include/net/scm.h b/include/net/scm.h
index 92276a2c5543..a1142dee086c 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -23,10 +23,17 @@ struct scm_creds {
 	kgid_t	gid;
 };
 
+#ifdef CONFIG_UNIX
+struct unix_edge;
+#endif
+
 struct scm_fp_list {
 	short			count;
 	short			count_unix;
 	short			max;
+#ifdef CONFIG_UNIX
+	struct unix_edge	*edges;
+#endif
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
 };
diff --git a/net/core/scm.c b/net/core/scm.c
index 9cd4b0a01cd6..8661524ed6e5 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -87,6 +87,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		*fplp = fpl;
 		fpl->count = 0;
 		fpl->count_unix = 0;
+		fpl->edges = NULL;
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
 	}
@@ -376,6 +377,8 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 	if (new_fpl) {
 		for (i = 0; i < fpl->count; i++)
 			get_file(fpl->fp[i]);
+
+		new_fpl->edges = NULL;
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
 	}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ae145b6f77d8..0391f66546a6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1819,6 +1819,9 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	for (i = scm->fp->count - 1; i >= 0; i--)
 		unix_inflight(scm->fp->user, scm->fp->fp[i]);
 
+	if (unix_alloc_edges(UNIXCB(skb).fp))
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1829,6 +1832,8 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	scm->fp = UNIXCB(skb).fp;
 	UNIXCB(skb).fp = NULL;
 
+	unix_free_edges(scm->fp);
+
 	for (i = scm->fp->count - 1; i >= 0; i--)
 		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
 }
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index db9ac289ce08..6a3572e43b9f 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -110,6 +110,24 @@ void unix_init_vertex(struct unix_sock *u)
 	INIT_LIST_HEAD(&vertex->entry);
 }
 
+int unix_alloc_edges(struct scm_fp_list *fpl)
+{
+	if (!fpl->count_unix)
+		return 0;
+
+	fpl->edges = kvmalloc_array(fpl->count_unix, sizeof(*fpl->edges),
+				    GFP_KERNEL_ACCOUNT);
+	if (!fpl->edges)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void unix_free_edges(struct scm_fp_list *fpl)
+{
+	kvfree(fpl->edges);
+}
+
 DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
-- 
2.30.2


