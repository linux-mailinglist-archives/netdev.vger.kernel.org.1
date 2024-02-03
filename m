Return-Path: <netdev+bounces-68759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6267B847FC7
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0442B28A9B
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3C66FC9;
	Sat,  3 Feb 2024 03:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iykL2XTO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898795398
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929354; cv=none; b=d7jZQywH1KPZWJ+s/98WUNrCWcLANGbdi2XImr31LcaDnzw++BQZGRJjMNJ4b3yS6uUWveHlu/E/4f9nmnkMpmM4hrjACnhepq5HJOan0cu1TAfESbjg8LcY5l7tEW1sllGPvjiXKB1X7TPaDNQ3UbdU7CBwhw3GC+LKimmg1Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929354; c=relaxed/simple;
	bh=WsNeJq/kRuC5napU72PYhUrFouzazMAAsqDLLI0CCh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S6D6brqm/ihDEyS4l3EfFQdSW8j/h3OZmkmxLC0IDA0jmMzvWBgSzUJ07bGdw0t8+dA7gnpanzi+cQqMtQGl8nxqNHy9HoC3Pd1gKg+fiBe0KRrrZD1jile6OY1TgwoILoFJkvCu9ewv7l259jDAS8afHoAdECE+cNiwEI1hyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iykL2XTO; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929349; x=1738465349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QuK67kBJjxtqszhtR0/lyJLNjyWIQPOl6cL3gMjM8vc=;
  b=iykL2XTOU6ZNywJU3UxlMA6IXvOgsmtMjpRzLU48fq+lf0lLFCIIDXCH
   dUWaqvaOjGUUmHEWNxjeeqfkRTQM5Y16el3PEfO/o8C+4LJ8FoVQ4sUAT
   RwFwo+7bJAbW809HeXZPOP2KNVUiK+LXWtYsB7qUyDGHlNj4dQG6XQ3Ao
   A=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="270771703"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:02:29 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:22017]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.97:2525] with esmtp (Farcaster)
 id aaf2486e-2e82-4138-9904-fb462d1d60c9; Sat, 3 Feb 2024 03:02:28 +0000 (UTC)
X-Farcaster-Flow-ID: aaf2486e-2e82-4138-9904-fb462d1d60c9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:02:28 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:02:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/16] af_unix: Link struct unix_edge when queuing skb.
Date: Fri, 2 Feb 2024 19:00:45 -0800
Message-ID: <20240203030058.60750-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
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
 net/unix/garbage.c    | 56 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 66 insertions(+), 3 deletions(-)

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
index 8661524ed6e5..d141c00eb116 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -87,6 +87,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		*fplp = fpl;
 		fpl->count = 0;
 		fpl->count_unix = 0;
+		fpl->inflight = false;
 		fpl->edges = NULL;
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
@@ -378,6 +379,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 		for (i = 0; i < fpl->count; i++)
 			get_file(fpl->fp[i]);
 
+		new_fpl->inflight = false;
 		new_fpl->edges = NULL;
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
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
index 6a3572e43b9f..572ac0994c69 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -110,6 +110,58 @@ void unix_init_vertex(struct unix_sock *u)
 	INIT_LIST_HEAD(&vertex->entry);
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
+		INIT_LIST_HEAD(&edge->entry);
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
@@ -125,10 +177,12 @@ int unix_alloc_edges(struct scm_fp_list *fpl)
 
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


