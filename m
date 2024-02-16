Return-Path: <netdev+bounces-72531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F658587E5
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68AE9B297A7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F3C137C5A;
	Fri, 16 Feb 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="az7Nyay4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECF7182AE
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117668; cv=none; b=pOMnDW7hgi1nAxLxQYRL47I2thSUkbcAM7EQn0NSNKBWvaMye4MK++anXG1FS5WgqlJOFe0UhPmEndDpSzDu+/50IcLGniF1sH7RaKvmrWWEALbihE3L+T7VcwN4JvcR+UtwEeGz0khLNNAZrB8lsPSU3XfXRLIt9sT6SAq7410=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117668; c=relaxed/simple;
	bh=ZiqeS9y4r0Hpc121u8XhE3RGTxXb8MXTu4aQG2B1dnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7D4KmMFfOzXgYzX1HVVuwwwq3baplwiAb3GXXEb8rtLNolpo8IfWgfAp22O0Tke+yeolTm3xGj9lsjwP7/ggkoXRW0+6lmfQeCLFK8O8CYLCWUbfx0hxPnXYi0E0HXuCJZYSA6iiVF9ZLmLWYRfUCXPW1WHcoV9sbRtW/U1Q/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=az7Nyay4; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117666; x=1739653666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVvp37Z142WMdq9WVP/ExA3q9IgHbAPO4buJ2QhH7w0=;
  b=az7Nyay4gVk3g9TqHcQf5fpWc2tPNoKErJxI1NU73eLQlDZw8fkgKB9b
   HwKUUKLhYtfrrqPZ0IcsB8RHzCZRk5V3dKseQNSacORhWVUV01REZB7M6
   GhXcLlBBAQPNDO9+VglFp/UyXD+yu8zTwAUASq5XK3DrNGsJoXRTNRJqG
   M=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="66639751"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:07:44 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:57626]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.174:2525] with esmtp (Farcaster)
 id 8d8800bb-e7a7-43c8-87a5-a81fafb93804; Fri, 16 Feb 2024 21:07:44 +0000 (UTC)
X-Farcaster-Flow-ID: 8d8800bb-e7a7-43c8-87a5-a81fafb93804
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:07:39 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:07:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/14] af_unix: Link struct unix_edge when queuing skb.
Date: Fri, 16 Feb 2024 13:05:45 -0800
Message-ID: <20240216210556.65913-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216210556.65913-1-kuniyu@amazon.com>
References: <20240216210556.65913-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Just before queuing skb with inflight fds, we call scm_stat_add(),
which is a good place to set up the preallocated struct unix_edge
in UNIXCB(skb).fp->edges.

Then, we call unix_add_edges() and construct the directed graph
as follows:

  1. Set the inflight socket's unix_vertex to unix_edge.predecessor
  2. Set the receiver's unix_vertex to unix_edge.successor
  3. Link unix_edge.entry to the inflight socket's unix_vertex.edges
  4. Link inflight socket's unix_vertex.entry to unix_unvisited_vertices.

Let's say we pass the fd of AF_UNIX socket A to B and the fd of B
to C.  The graph looks like this:

  +-------------------------+
  | unix_unvisited_vertices | <------------------------.
  +-------------------------+                          |
  +                                                    |
  |   +-------------+                +-------------+   |            +-------------+
  |   | unix_sock A |                | unix_sock B |   |            | unix_sock C |
  |   +-------------+                +-------------+   |            +-------------+
  |   | unix_vertex | <----.  .----> | unix_vertex | <-|--.  .----> | unix_vertex |
  |   | +-----------+      |  |      | +-----------+   |  |  |      | +-----------+
  `-> | |   entry   | +------------> | |   entry   | +-'  |  |      | |   entry   |
      | |-----------|      |  |      | |-----------|      |  |      | |-----------|
      | |   edges   | <-.  |  |      | |   edges   | <-.  |  |      | |   edges   |
      +-+-----------+   |  |  |      +-+-----------+   |  |  |      +-+-----------+
                        |  |  |                        |  |  |
  .---------------------'  |  |  .---------------------'  |  |
  |                        |  |  |                        |  |
  |   +-------------+      |  |  |   +-------------+      |  |
  |   |  unix_edge  |      |  |  |   |  unix_edge  |      |  |
  |   +-------------+      |  |  |   +-------------+      |  |
  `-> |    entry    |      |  |  `-> |    entry    |      |  |
      |-------------|      |  |      |-------------|      |  |
      | predecessor | +----'  |      | predecessor | +----'  |
      |-------------|         |      |-------------|         |
      |  successor  | +-------'      |  successor  | +-------'
      +-------------+                +-------------+

Henceforth, we denote such a graph as A -> B (-> C).

Now, we can express all inflight fd graphs that do not contain
embryo sockets.  The following two patches will support the
particular case.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  2 ++
 include/net/scm.h     |  1 +
 net/core/scm.c        |  2 ++
 net/unix/af_unix.c    |  8 +++++--
 net/unix/garbage.c    | 55 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index cab9dfb666f3..54d62467a70b 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -23,6 +23,8 @@ extern unsigned int unix_tot_inflight;
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_init_vertex(struct unix_sock *u);
+void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
+void unix_del_edges(struct scm_fp_list *fpl);
 int unix_alloc_edges(struct scm_fp_list *fpl);
 void unix_free_edges(struct scm_fp_list *fpl);
 void unix_gc(void);
diff --git a/include/net/scm.h b/include/net/scm.h
index a1142dee086c..7d807fe466a3 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -32,6 +32,7 @@ struct scm_fp_list {
 	short			count_unix;
 	short			max;
 #ifdef CONFIG_UNIX
+	bool			inflight;
 	struct unix_edge	*edges;
 #endif
 	struct user_struct	*user;
diff --git a/net/core/scm.c b/net/core/scm.c
index bc75b6927222..cad0c153ac93 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -88,6 +88,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		fpl->count = 0;
 		fpl->count_unix = 0;
 #if IS_ENABLED(CONFIG_UNIX)
+		fpl->inflight = false;
 		fpl->edges = NULL;
 #endif
 		fpl->max = SCM_MAX_FD;
@@ -381,6 +382,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 			get_file(fpl->fp[i]);
 
 #if IS_ENABLED(CONFIG_UNIX)
+		new_fpl->inflight = false;
 		new_fpl->edges = NULL;
 #endif
 		new_fpl->max = new_fpl->count;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0391f66546a6..ea7bac18a781 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1956,8 +1956,10 @@ static void scm_stat_add(struct sock *sk, struct sk_buff *skb)
 	struct scm_fp_list *fp = UNIXCB(skb).fp;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (unlikely(fp && fp->count))
+	if (unlikely(fp && fp->count)) {
 		atomic_add(fp->count, &u->scm_stat.nr_fds);
+		unix_add_edges(fp, u);
+	}
 }
 
 static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
@@ -1965,8 +1967,10 @@ static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
 	struct scm_fp_list *fp = UNIXCB(skb).fp;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (unlikely(fp && fp->count))
+	if (unlikely(fp && fp->count)) {
 		atomic_sub(fp->count, &u->scm_stat.nr_fds);
+		unix_del_edges(fp);
+	}
 }
 
 /*
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index ec998c7d6b4c..353416f38738 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -109,6 +109,57 @@ void unix_init_vertex(struct unix_sock *u)
 	INIT_LIST_HEAD(&vertex->edges);
 }
 
+DEFINE_SPINLOCK(unix_gc_lock);
+static LIST_HEAD(unix_unvisited_vertices);
+
+void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
+{
+	int i = 0, j = 0;
+
+	spin_lock(&unix_gc_lock);
+
+	while (i < fpl->count_unix) {
+		struct unix_sock *inflight = unix_get_socket(fpl->fp[j++]);
+		struct unix_edge *edge;
+
+		if (!inflight)
+			continue;
+
+		edge = fpl->edges + i++;
+		edge->predecessor = &inflight->vertex;
+		edge->successor = &receiver->vertex;
+
+		if (!edge->predecessor->out_degree++)
+			list_add_tail(&edge->predecessor->entry, &unix_unvisited_vertices);
+
+		list_add_tail(&edge->entry, &edge->predecessor->edges);
+	}
+
+	spin_unlock(&unix_gc_lock);
+
+	fpl->inflight = true;
+}
+
+void unix_del_edges(struct scm_fp_list *fpl)
+{
+	int i = 0;
+
+	spin_lock(&unix_gc_lock);
+
+	while (i < fpl->count_unix) {
+		struct unix_edge *edge = fpl->edges + i++;
+
+		list_del(&edge->entry);
+
+		if (!--edge->predecessor->out_degree)
+			list_del_init(&edge->predecessor->entry);
+	}
+
+	spin_unlock(&unix_gc_lock);
+
+	fpl->inflight = false;
+}
+
 int unix_alloc_edges(struct scm_fp_list *fpl)
 {
 	if (!fpl->count_unix)
@@ -124,10 +175,12 @@ int unix_alloc_edges(struct scm_fp_list *fpl)
 
 void unix_free_edges(struct scm_fp_list *fpl)
 {
+	if (fpl->inflight)
+		unix_del_edges(fpl);
+
 	kvfree(fpl->edges);
 }
 
-DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
 static LIST_HEAD(gc_inflight_list);
-- 
2.30.2


