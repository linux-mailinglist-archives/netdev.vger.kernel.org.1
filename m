Return-Path: <netdev+bounces-265217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wVW7OS/nrGlSvwEAu9opvQ
	(envelope-from <netdev+bounces-265217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:04:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A322E5E1
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624A43013A62
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 03:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710CF26FA60;
	Sun,  8 Mar 2026 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4TXWEQn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ECD15C158
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 03:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772939052; cv=none; b=A/qKOe+Q7NDXtNg+zVzunFU2q4SKmBq9Qw6xn71bDhh2l62uhxuF/xQ4XgvX0M/rW0NAdKhjOSK1ZAkgq463BJSZrXyj8gszZOkPbOtqnkrs+eNlwpoT+rIjDX6E72Qhm8+m/oPDJffc0pC7gzVcAp+jWOZzw8faqW7C6sTItOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772939052; c=relaxed/simple;
	bh=XBgtC2Z1aWz9LzFI/MKRAZS5MLNBxHcIhTQT8nTe7bE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BfTxoSghj7yVWBJhg2cJcKnOaR97Ey6EOSa/ukSTP2ivuPyvG51Dtaau1db1zLJf5x8m48ZS11ijGZnvS+rjtv80C3X2EjgewfzhyjDGniuUgp3woh1RUXoWCWYvmAB71VoWEIcLfSxjwE4fK97yYyaZXllykrqRoIsG6AJGWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4TXWEQn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae53ec06b0so326228915ad.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 19:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772939050; x=1773543850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0IaoSMc50PrI1R6KkavQYENP3Zw/o1AejA056RqEjsA=;
        b=f4TXWEQnoQ5sMo6Do0vTSGCSv2Y0bKiT+nkWYkDLBko0Ix1InP+n+Ip9sPcCIJAPm0
         rTcwBy7Qatt7Tn4Ak9vDQSICYQDY1pkZrnNUd8cufmj9Nov63IbSFzi0ICH8QQu8pLL1
         8oEc8eZn7Lms4yj4lLQZX8rsozg1K2Xn8L57ZOH/32YgYbGVG7DMOKh00+y0Xm4aJbCz
         D4qkoJx+oJ8kwOWwko/W39bHa+rT7KCc6rgjSHlVQD+VBNJIJAa7X3vzRsaApwbgLfm7
         sCPAvkYgMZXYZ+3O+oo6ciRyDSZaQ43dINWVelVZhYIfKTyXqK7yxm+bG44dHjSLNnRl
         UUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772939050; x=1773543850;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IaoSMc50PrI1R6KkavQYENP3Zw/o1AejA056RqEjsA=;
        b=mI5uvrS682YNzZBVlqo0TbmZYhQEQCKIQYQ6mSLrY3STl1KW/g+lmM3ToHkN51GWr7
         JkNSpMJ9mqtupjhix8GFWEKd3avLHhVAn2dB67wTs3cvDdZTOfulQsKO+MIjXIXjeR82
         Pyo9YnHGA66QNPPsEpl8XrcuBAZ3GSgvxSPsQM+/pl7QZ2gcK6PyvWF3NQ7tDdFnPEQK
         QIzwBR4J0YtddDjad4PJfx1mfyTVSm5cVWZG20Xp6VDROlNE1w5A2Vv+y7A8jOEIkh75
         N08mj3B2smjsdI2lnV2CcwuaIiFYdjFyCMAx6Jx5C+4KIeN7FC+MUrabkhY6I/Iw2X/A
         7z4A==
X-Forwarded-Encrypted: i=1; AJvYcCXOK/5jku8+AbG0C2KulJSnAdr0R5Egjbr8AKVNHe2zACZ9j+qSnDdsLEirnhmHsnGAlpPzoIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbF0M/6alJBD4IiF6Z1mmUyWT2//7SOdQI0dk6tW8nRbbGkmYS
	+VP+fVGNPv38vSld9dJXhy0fEOENIAFvEkZ50qPkv/2jZHyVzEK1x4++5p9ITFsai1Eho+Sz+Mu
	P3cocHQ==
X-Received: from pliy16.prod.google.com ([2002:a17:903:3d10:b0:2ae:3bfd:19bd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78a:b0:2a9:43a9:d371
 with SMTP id d9443c01a7336-2ae8243b302mr62778905ad.37.1772939050187; Sat, 07
 Mar 2026 19:04:10 -0800 (PST)
Date: Sun,  8 Mar 2026 03:04:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260308030406.1825938-1-kuniyu@google.com>
Subject: [PATCH v1 net] af_unix: Give up GC if MSG_PEEK intervened.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Igor Ushakov <sysroot314@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 125A322E5E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265217-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.973];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Igor Ushakov reported that GC purged the receive queue of
an alive socket due to a race with MSG_PEEK with a nice repro.

This is the exact same issue previously fixed by commit
cbcf01128d0a ("af_unix: fix garbage collect vs MSG_PEEK").

After GC was replaced with the current algorithm, the cited
commit removed the lock dance in unix_peek_fds() and
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

One option is to restore the lock dance in unix_peek_fds(), but
we can resolve this more elegantly thanks to the new algorithm.

We actually do not need to synchronise MSG_PEEK with the dead
SCC detection.  Even if the sequence above occurs, we can just
give up garbage-collecting the SCC if we can detect the race.

Let's notify GC when MSG_PEEK occurs and let it defer the SCC
to the next run.

This way no locking is needed on the MSG_PEEK side, and we can
avoid imposing a penalty on every MSG_PEEK unnecessarily.

Note that we can retry within unix_scc_dead() if MSG_PEEK is
detected, but we do not do so to avoid hung task splat from
abusive MSG_PEEK calls.

Fixes: 118f457da9ed ("af_unix: Remove lock dance in unix_peek_fds().")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c |  2 ++
 net/unix/af_unix.h |  1 +
 net/unix/garbage.c | 71 ++++++++++++++++++++++++++++------------------
 3 files changed, 46 insertions(+), 28 deletions(-)

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
index 816e8fa2b062..468fb0ee463f 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -318,6 +318,21 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
+static bool gc_in_progress;
+static bool unix_fd_peeked;
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
+	WRITE_ONCE(unix_fd_peeked, true);
+}
+
 static bool unix_vertex_dead(struct unix_vertex *vertex)
 {
 	struct unix_edge *edge;
@@ -351,6 +366,32 @@ static bool unix_vertex_dead(struct unix_vertex *vertex)
 	return true;
 }
 
+static LIST_HEAD(unix_visited_vertices);
+static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
+
+static bool unix_scc_dead(struct list_head *scc, bool fast)
+{
+	struct unix_vertex *vertex;
+	bool scc_dead = true;
+
+	WRITE_ONCE(unix_fd_peeked, false);
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
+	return scc_dead && !READ_ONCE(unix_fd_peeked);
+}
+
 static void unix_collect_skb(struct list_head *scc, struct sk_buff_head *hitlist)
 {
 	struct unix_vertex *vertex;
@@ -404,9 +445,6 @@ static bool unix_scc_cyclic(struct list_head *scc)
 	return false;
 }
 
-static LIST_HEAD(unix_visited_vertices);
-static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
-
 static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 				     unsigned long *last_index,
 				     struct sk_buff_head *hitlist)
@@ -474,9 +512,7 @@ static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
 	}
 
 	if (vertex->index == vertex->scc_index) {
-		struct unix_vertex *v;
 		struct list_head scc;
-		bool scc_dead = true;
 
 		/* SCC finalised.
 		 *
@@ -485,18 +521,7 @@ static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
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
@@ -550,19 +575,11 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
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
@@ -577,8 +594,6 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 		   cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC);
 }
 
-static bool gc_in_progress;
-
 static void unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
-- 
2.53.0.473.g4a7958ca14-goog


