Return-Path: <netdev+bounces-265712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNKRGbgYr2nHNgIAu9opvQ
	(envelope-from <netdev+bounces-265712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 20:00:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFEE23F0D2
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 20:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB1543016EF5
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2809D3ED11D;
	Mon,  9 Mar 2026 18:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHtwdsu4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD932877CB
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082733; cv=none; b=cl5qVbRNYnwwrhhcAXYmOj7iCbSMXi40ZC7xZ6z0Adivh7VID+uvybC+cw1ZYXQNaVWbDphnUHprohnaDtK3mjk4kuS/8mXIqmyvjFkgVko/fxbaLKUcMRsGyHpUZB3knO+Fyl28O2ZtgKqYQMMCehNXBnI4JmGuDZ3z5ePOtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082733; c=relaxed/simple;
	bh=oaC0Y6yFR9ESJZQPEZvsoBpEfy3GPCv4OTBLP8W9OLs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZiTNjBSzE1nTsp3ZrLB5/iUbPkhIjYUc+jCQdzLi4S5afBw3ETtrcYNW6K1lZO17pnqsp8vDA2Y9mEl/V2AJyzDxBR2tMYS5Sp+WKmMWsbwCYNN28znBDaIMaiImAX03fT7vZ+vlH5h/VVu2mKNO2gP++LAeV4Ly9JJKedB71ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHtwdsu4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3598c05c806so8143817a91.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773082731; x=1773687531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wvQTEM4gpRBzF78qIxSQmneMDQkv9OFclc59SzAyapA=;
        b=CHtwdsu42esDsLbQNfSb9Q5HYR/OqpeGlXYuVwl5MQ22EmG+K2np5denDK8aNK7kJ4
         NAFbwpEOzIbLNLWifqk11kof4d+1UxIdw9z0Jb26iJnnto0Ijt382YIO49abnkn/8pI7
         cPmQWVpKidJMQCTkeAe82v4/qEBh/wJh5lJbuGGnGwqgO7tNZCO+DyJmvQoN6CRjuVLr
         DcgCA7R4pz4cvIeKu0rPzfKaa9JIQnQ4cbzL96WYrHS3a/oEPs7MuswMbOMeW6nuMMOs
         CJ40s8/8jeSUa2lVv0mW7sISdOwz/F6BH0+Gtwij0vJZGtVilrYWJofZb1BcktfdkVN+
         eRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773082731; x=1773687531;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wvQTEM4gpRBzF78qIxSQmneMDQkv9OFclc59SzAyapA=;
        b=tj3rvASUAErXYDVfpjnvGIHvzB397+bQTCRhCS0xVjYOXT93EfYTonu7//noBCTMHR
         X1ceQ3goieWfRa9UQi1S2/Yee4LYGaKqsPWrMRqxQBa2Pe4SeTk8VyQ50+NH95T8SbsK
         2Qs+9B/obRrmSsn+raEotzHMkfKiNiJ0l6ZchNGkUs9P+xHQwo1ttXmmo6xaQjSc4WOS
         ws90E0s+Zro/R+w+CPxJ0t2BbbfPguUod0/QPWYdconYpbaLgQbW1vS8mvxREGBBED8L
         e2d0ULDmMZDiq8q9Ystf7Qd5F9LwAdvRR9pL1JHMZiAYlkxJM/uAPd8eq9XvP/vG9vMS
         OUHA==
X-Forwarded-Encrypted: i=1; AJvYcCWXHqlJMs8EIYHPbeNhj3Pt38YexlQGb+udnf+YAaAhKZn5QdB6pM6q4c3cqtzrH+v/CiG8JGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhOiOyNmv+oA3nmmYcfki1JCqd+w/4rU1/ABBmX6Hm2Yjb72G
	I146yCpi1J+E3X483zRJNALOC4vDYJ2Nz+ywX4j7sQ9wsvdJRtPgoQguoc+NLnmYolBwzqiz3By
	OtUzewg==
X-Received: from pjvn18.prod.google.com ([2002:a17:90a:de92:b0:359:8e86:237f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8a:b0:359:9a60:44c8
 with SMTP id 98e67ed59e1d1-359be32a1f9mr10684232a91.30.1773082730872; Mon, 09
 Mar 2026 11:58:50 -0700 (PDT)
Date: Mon,  9 Mar 2026 18:58:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309185823.3502204-1-kuniyu@google.com>
Subject: [PATCH v2 net] af_unix: Give up GC if MSG_PEEK intervened.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	netdev@vger.kernel.org, Igor Ushakov <sysroot314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BFFEE23F0D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265712-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,linuxfoundation.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Igor Ushakov reported that GC purged the receive queue of
an alive socket due to a race with MSG_PEEK with a nice repro.

This is the exact same issue previously fixed by commit
cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").

After GC was replaced with the current algorithm, the cited
commit removed the locking dance in unix_peek_fds() and
reintroduced the same issue.

The problem is that MSG_PEEK bumps a file refcount without
interacting with GC.

Consider an SCC containing sk-A and sk-B, where sk-A is
close()d but can be recv()ed via sk-B.

The bad thing happens if sk-A is recv()ed with MSG_PEEK from
sk-B and sk-B is close()d while GC is checking unix_vertex_dead()
for sk-A and sk-B.

  GC thread                    User thread
  ---------                    -----------
  unix_vertex_dead(sk-A)
  -> true   <------.
                    \
                     `------   recv(sk-B, MSG_PEEK)
              invalidate !!    -> sk-A's file refcount : 1 -> 2

                               close(sk-B)
                               -> sk-B's file refcount : 2 -> 1
  unix_vertex_dead(sk-B)
  -> true

Initially, sk-A's file refcount is 1 by the inflight fd in sk-B
recvq.  GC thinks sk-A is dead because the file refcount is the
same as the number of its inflight fds.

However, sk-A's file refcount is bumped silently by MSG_PEEK,
which invalidates the previous evaluation.

At this moment, sk-B's file refcount is 2; one by the open fd,
and one by the inflight fd in sk-A.  The subsequent close()
releases one refcount by the former.

Finally, GC incorrectly concludes that both sk-A and sk-B are dead.

One option is to restore the locking dance in unix_peek_fds(),
but we can resolve this more elegantly thanks to the new algorithm.

The point is that the issue does not occur without the subsequent
close() and we actually do not need to synchronise MSG_PEEK with
the dead SCC detection.

When the issue occurs, close() and GC touch the same file refcount.
If GC sees the refcount being decremented by close(), it can just
give up garbage-collecting the SCC.

Therefore, we only need to signal the race during MSG_PEEK with
a proper memory barrier to make it visible to the GC.

Let's use seqcount_t to notify GC when MSG_PEEK occurs and let
it defer the SCC to the next run.

This way no locking is needed on the MSG_PEEK side, and we can
avoid imposing a penalty on every MSG_PEEK unnecessarily.

Note that we can retry within unix_scc_dead() if MSG_PEEK is
detected, but we do not do so to avoid hung task splat from
abusive MSG_PEEK calls.

Fixes: 118f457da9ed ("af_unix: Remove lock dance in unix_peek_fds().")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Use seqcount_t for proper memory barrier
v1: https://lore.kernel.org/netdev/20260308030406.1825938-1-kuniyu@google.com/
---
 net/unix/af_unix.c |  2 ++
 net/unix/af_unix.h |  1 +
 net/unix/garbage.c | 75 +++++++++++++++++++++++++++++-----------------
 3 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7eaa5b187fef..b23c33df8b46 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1958,6 +1958,8 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 static void unix_peek_fds(struct scm_cookie *scm, struct sk_buff *skb)
 {
 	scm->fp = scm_fp_dup(UNIXCB(skb).fp);
+
+	unix_peek_fpl(scm->fp);
 }
 
 static void unix_destruct_scm(struct sk_buff *skb)
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index c4f1b2da363d..8119dbeef3a3 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -29,6 +29,7 @@ void unix_del_edges(struct scm_fp_list *fpl);
 void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
+void unix_peek_fpl(struct scm_fp_list *fpl);
 void unix_schedule_gc(struct user_struct *user);
 
 /* SOCK_DIAG */
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 816e8fa2b062..5c9692c98d23 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -318,6 +318,21 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static bool gc_in_progress;
+static seqcount_t unix_peek_seq = SEQCNT_ZERO(unix_peek_seq);
+
+void unix_peek_fpl(struct scm_fp_list *fpl)
+{
+	if (!fpl->count_unix)
+		return;
+
+	if (!READ_ONCE(gc_in_progress))
+		return;
+
+	/* Invalidate the final refcnt check in unix_vertex_dead(). */
+	raw_write_seqcount_barrier(&unix_peek_seq);
+}
+
 static bool unix_vertex_dead(struct unix_vertex *vertex)
 {
 	struct unix_edge *edge;
@@ -351,6 +366,36 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 	return true;
 }
 
+static LIST_HEAD(unix_visited_vertices);
+static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
+
+static bool unix_scc_dead(struct list_head *scc, bool fast)
+{
+	struct unix_vertex *vertex;
+	bool scc_dead = true;
+	unsigned int seq;
+
+	seq = read_seqcount_begin(&unix_peek_seq);
+
+	list_for_each_entry_reverse(vertex, scc, scc_entry) {
+		/* Don't restart DFS from this vertex. */
+		list_move_tail(&vertex->entry, &unix_visited_vertices);
+
+		/* Mark vertex as off-stack for __unix_walk_scc(). */
+		if (!fast)
+			vertex->index = unix_vertex_grouped_index;
+
+		if (scc_dead)
+			scc_dead = unix_vertex_dead(vertex);
+	}
+
+	/* If MSG_PEEK intervened, defer this SCC to the next round. */
+	if (read_seqcount_retry(&unix_peek_seq, seq))
+		return false;
+
+	return scc_dead;
+}
+
 static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
 {
 	struct unix_vertex *vertex;
@@ -404,9 +449,6 @@ static bool unix_scc_cyclic(struct list_head *scc)
 	return false;
 }
 
-static LIST_HEAD(unix_visited_vertices);
-static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
-
 static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 				     unsigned long *last_index,
 				     struct sk_buff_head *hitlist)
@@ -474,9 +516,7 @@ static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 	}
 
 	if (vertex->index == vertex->scc_index) {
-		struct unix_vertex *v;
 		struct list_head scc;
-		bool scc_dead = true;
 
 		/* SCC finalised.
 		 *
@@ -485,18 +525,7 @@ static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 		 */
 		__list_cut_position(&scc, &vertex_stack, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(v, &scc, scc_entry) {
-			/* Don't restart DFS from this vertex in unix_walk_scc(). */
-			list_move_tail(&v->entry, &unix_visited_vertices);
-
-			/* Mark vertex as off-stack. */
-			v->index = unix_vertex_grouped_index;
-
-			if (scc_dead)
-				scc_dead = unix_vertex_dead(v);
-		}
-
-		if (scc_dead) {
+		if (unix_scc_dead(&scc, false)) {
 			unix_collect_skb(&scc, hitlist);
 		} else {
 			if (unix_vertex_max_scc_index < vertex->scc_index)
@@ -550,19 +579,11 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
 		struct list_head scc;
-		bool scc_dead = true;
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
 		list_add(&scc, &vertex->scc_entry);
 
-		list_for_each_entry_reverse(vertex, &scc, scc_entry) {
-			list_move_tail(&vertex->entry, &unix_visited_vertices);
-
-			if (scc_dead)
-				scc_dead = unix_vertex_dead(vertex);
-		}
-
-		if (scc_dead) {
+		if (unix_scc_dead(&scc, true)) {
 			cyclic_sccs--;
 			unix_collect_skb(&scc, hitlist);
 		}
@@ -577,8 +598,6 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 		   cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC);
 }
 
-static bool gc_in_progress;
-
 static void unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
-- 
2.53.0.473.g4a7958ca14-goog


