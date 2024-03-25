Return-Path: <netdev+bounces-81762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7578988B148
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06461F641BB
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB5B45037;
	Mon, 25 Mar 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LszJFdns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A71CA9C
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398356; cv=none; b=WIHa6non54UJNq29vRRwPlFS+5E3eoLk9wS7jDNn8hMz8EXv8xfQXGkuCydrh1oju6JNPqMFZ6+d+3u9Y2O835M8x4lp1MFrLlUZ+NWalamavALGlW2mJrZ0IsTmnzsE7G354HvI4m3Yr5YdUsT1+xDkksumW3T8OwU0+HQSuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398356; c=relaxed/simple;
	bh=DZUO+FDhceUXRBkmBe5BuPc11t4zdycYZc9z/Y1adXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBp24sD9KjKu35TMimbOzxc+1HQAhcWVmWuXOt2XBvNmtW5dtLNBGye8T76ubHTY1GBgNeC0g84RwirwgUeMCNW2qtPBjdDC/GkUlWiQCNCn5GtG4M/TWajuGVTjRu+m0ugGsE0ohiICM+rxsdxbG87elL5VfcWwj2mLZjtX4lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LszJFdns; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398355; x=1742934355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G4QSG30Sdhxz7PgBOvOV909i+5vnr7o73dq6xLDBcyQ=;
  b=LszJFdns1VVJHUQNsJnk8xg5ud9U9kcA5FzW61468lh/naF4PuuL7tqm
   Ea8JToZ66aAa83uSLgNiYA396TtVMHeRwPql0551ILp9XraXuN+H6O8cO
   PDJcQk3qmH/PDqsggELF9u37ek3H+x7b+Rth8dK5cA8TqEM+ZKHEnCaWy
   4=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="622262284"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:25:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:7196]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.19:2525] with esmtp (Farcaster)
 id 2f7e7d93-8c92-4de6-b0dd-2599e1d4a302; Mon, 25 Mar 2024 20:25:50 +0000 (UTC)
X-Farcaster-Flow-ID: 2f7e7d93-8c92-4de6-b0dd-2599e1d4a302
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:25:50 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:25:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 03/15] af_unix: Link struct unix_edge when queuing skb.
Date: Mon, 25 Mar 2024 13:24:13 -0700
Message-ID: <20240325202425.60930-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Just before queuing skb with inflight fds, we call scm_stat_add(),
which is a good place to set up the preallocated struct unix_vertex
and struct unix_edge in UNIXCB(skb).fp.

Then, we call unix_add_edges() and construct the directed graph
as follows:

  1. Set the inflight socket's unix_sock to unix_edge.predecessor.
  2. Set the receiver's unix_sock to unix_edge.successor.
  3. Set the preallocated vertex to inflight socket's unix_sock.vertex.
  4. Link inflight socket's unix_vertex.entry to unix_unvisited_vertices.
  5. Link unix_edge.vertex_entry to the inflight socket's unix_vertex.edges.

Let's say we pass the fd of AF_UNIX socket A to B and the fd of B
to C.  The graph looks like this:

  +-------------------------+
  | unix_unvisited_vertices | <-------------------------.
  +-------------------------+                           |
  +                                                     |
  |     +--------------+             +--------------+   |         +--------------+
  |     |  unix_sock A | <---. .---> |  unix_sock B | <-|-. .---> |  unix_sock C |
  |     +--------------+     | |     +--------------+   | | |     +--------------+
  | .-+ |    vertex    |     | | .-+ |    vertex    |   | | |     |    vertex    |
  | |   +--------------+     | | |   +--------------+   | | |     +--------------+
  | |                        | | |                      | | |
  | |   +--------------+     | | |   +--------------+   | | |
  | '-> |  unix_vertex |     | | '-> |  unix_vertex |   | | |
  |     +--------------+     | |     +--------------+   | | |
  `---> |    entry     | +---------> |    entry     | +-' | |
        |--------------|     | |     |--------------|     | |
        |    edges     | <-. | |     |    edges     | <-. | |
        +--------------+   | | |     +--------------+   | | |
                           | | |                        | | |
    .----------------------' | | .----------------------' | |
    |                        | | |                        | |
    |   +--------------+     | | |   +--------------+     | |
    |   |   unix_edge  |     | | |   |   unix_edge  |     | |
    |   +--------------+     | | |   +--------------+     | |
    `-> | vertex_entry |     | | `-> | vertex_entry |     | |
        |--------------|     | |     |--------------|     | |
        |  predecessor | +---' |     |  predecessor | +---' |
        |--------------|       |     |--------------|       |
        |   successor  | +-----'     |   successor  | +-----'
        +--------------+             +--------------+

Henceforth, we denote such a graph as A -> B (-> C).

Now, we can express all inflight fd graphs that do not contain
embryo sockets.  We will support the particular case later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  2 +
 include/net/scm.h     |  1 +
 net/core/scm.c        |  2 +
 net/unix/af_unix.c    |  8 +++-
 net/unix/garbage.c    | 90 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 55c4abc26a71..f31ad1166346 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -22,6 +22,8 @@ extern unsigned int unix_tot_inflight;
 
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
+void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
+void unix_del_edges(struct scm_fp_list *fpl);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_gc(void);
diff --git a/include/net/scm.h b/include/net/scm.h
index 5f5154e5096d..bbc5527809d1 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -32,6 +32,7 @@ struct scm_fp_list {
 	short			count_unix;
 	short			max;
 #ifdef CONFIG_UNIX
+	bool			inflight;
 	struct list_head	vertices;
 	struct unix_edge	*edges;
 #endif
diff --git a/net/core/scm.c b/net/core/scm.c
index 1bcc8a2d65e3..5763f3320358 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -90,6 +90,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
 #if IS_ENABLED(CONFIG_UNIX)
+		fpl->inflight = false;
 		fpl->edges = NULL;
 		INIT_LIST_HEAD(&fpl->vertices);
 #endif
@@ -384,6 +385,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
 #if IS_ENABLED(CONFIG_UNIX)
+		new_fpl->inflight = false;
 		new_fpl->edges = NULL;
 		INIT_LIST_HEAD(&new_fpl->vertices);
 #endif
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a3b25d311560..24adbc4d5188 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1943,8 +1943,10 @@ static void scm_stat_add(struct sock *sk, struct sk_buff *skb)
 	struct scm_fp_list *fp = UNIXCB(skb).fp;
 	struct unix_sock *u = unix_sk(sk);
 
-	if (unlikely(fp && fp->count))
+	if (unlikely(fp && fp->count)) {
 		atomic_add(fp->count, &u->scm_stat.nr_fds);
+		unix_add_edges(fp, u);
+	}
 }
 
 static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
@@ -1952,8 +1954,10 @@ static void scm_stat_del(struct sock *sk, struct sk_buff *skb)
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
index f31917683288..36d665936096 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,38 @@ struct unix_sock *unix_get_socket(struct file *filp)
 	return NULL;
 }
 
+static LIST_HEAD(unix_unvisited_vertices);
+
+static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
+{
+	struct unix_vertex *vertex = edge->predecessor->vertex;
+
+	if (!vertex) {
+		vertex = list_first_entry(&fpl->vertices, typeof(*vertex), entry);
+		vertex->out_degree = 0;
+		INIT_LIST_HEAD(&vertex->edges);
+
+		list_move_tail(&vertex->entry, &unix_unvisited_vertices);
+		edge->predecessor->vertex = vertex;
+	}
+
+	vertex->out_degree++;
+	list_add_tail(&edge->vertex_entry, &vertex->edges);
+}
+
+static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
+{
+	struct unix_vertex *vertex = edge->predecessor->vertex;
+
+	list_del(&edge->vertex_entry);
+	vertex->out_degree--;
+
+	if (!vertex->out_degree) {
+		edge->predecessor->vertex = NULL;
+		list_move_tail(&vertex->entry, &fpl->vertices);
+	}
+}
+
 static void unix_free_vertices(struct scm_fp_list *fpl)
 {
 	struct unix_vertex *vertex, *next_vertex;
@@ -111,6 +143,60 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 	}
 }
 
+DEFINE_SPINLOCK(unix_gc_lock);
+
+void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
+{
+	int i = 0, j = 0;
+
+	spin_lock(&unix_gc_lock);
+
+	if (!fpl->count_unix)
+		goto out;
+
+	do {
+		struct unix_sock *inflight = unix_get_socket(fpl->fp[j++]);
+		struct unix_edge *edge;
+
+		if (!inflight)
+			continue;
+
+		edge = fpl->edges + i++;
+		edge->predecessor = inflight;
+		edge->successor = receiver;
+
+		unix_add_edge(fpl, edge);
+	} while (i < fpl->count_unix);
+
+out:
+	spin_unlock(&unix_gc_lock);
+
+	fpl->inflight = true;
+
+	unix_free_vertices(fpl);
+}
+
+void unix_del_edges(struct scm_fp_list *fpl)
+{
+	int i = 0;
+
+	spin_lock(&unix_gc_lock);
+
+	if (!fpl->count_unix)
+		goto out;
+
+	do {
+		struct unix_edge *edge = fpl->edges + i++;
+
+		unix_del_edge(fpl, edge);
+	} while (i < fpl->count_unix);
+
+out:
+	spin_unlock(&unix_gc_lock);
+
+	fpl->inflight = false;
+}
+
 int unix_prepare_fpl(struct scm_fp_list *fpl)
 {
 	struct unix_vertex *vertex;
@@ -141,11 +227,13 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
 
 void unix_destroy_fpl(struct scm_fp_list *fpl)
 {
+	if (fpl->inflight)
+		unix_del_edges(fpl);
+
 	kvfree(fpl->edges);
 	unix_free_vertices(fpl);
 }
 
-DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
 static LIST_HEAD(gc_inflight_list);
-- 
2.30.2


