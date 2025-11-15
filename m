Return-Path: <netdev+bounces-238818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C501C5FDCD
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DE3235AB26
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6608B1E8337;
	Sat, 15 Nov 2025 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aURz0Vsq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EA31EF38E
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172586; cv=none; b=FmZ7fF82tGFXVYsWxPayhML9qNvnZLzHJwrO0pOWa67lZ4di5NXfHE484/t/yg3c0Vvg90p5GMVV5PK3/UAJDl7FSrPLfwoHheQAU+4Vx4ltOS4ZBjq0vy7NtG88JTnJX5b87mQC57Z8OkS7VHIZLbZe9oeJEi1JVTj9LqNWmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172586; c=relaxed/simple;
	bh=Fh1zQAltlOUq6BoIsbX2QpmSvMjtzW1vta76MdDJAvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fh9EQukjebXHM1FESBJ82m+NV+tQauselj6YtFotEo2R9gNBMjRcTNlJYzhBnuitKzPVi1ddcR3oGKxzHPCti/31uw9f65l4HXNpTn+QXJiQz9Da3TU4ILGd1IHzjSxNgBAAeYZc3hjf94NDhebVylehwgRVRHCNMqOfSkd6m9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aURz0Vsq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3437b43eec4so4564290a91.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763172584; x=1763777384; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WuCyq3wmO5kTXLoSkm3upkclGgdlEt/GZP83URL/g0M=;
        b=aURz0Vsq0DZp2WC+pG88CXQlCyy4l0OdNcf7VNyd5uvDDvYChX4MEq3MV1lBsbJbZb
         LwbkhqnEIQ1RuiKvBwZ/f8JmsEqNFKZaGx0K5GpBjZiaZzW5dfZX8LGLEBIV3Co130fy
         wlHx61ILMZZ/OrLfT8+/LKr4FARbIHQkkeKOD5eqmx6tSn/KAMG86oHDDb78/9/XYKd3
         SwSiufdrq4a3lTJThoMTsqEeq4elI2XIHAX09y1Yej4iqxl/FPGZgV4rNuwfHaT5ysBc
         AW+WaCYbNAa/BmZknimEZOkvgr2kiXK/+XHQlD8G4+QMeNOsIKuK2fxa6Ae3mDGUyt90
         5Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172584; x=1763777384;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuCyq3wmO5kTXLoSkm3upkclGgdlEt/GZP83URL/g0M=;
        b=p5/P7w8d7PZOvwNfwQieIj6PTNA0Txxx3qkN+7U+9cWlwd+BrciHyAbv392spucHPJ
         zfV/fHtDtVWeQPrFQWER3fNfsRdrEbnNroV6H+uikXmrPJs22qVE9ujAcZ3aqSVuusa6
         4hFLddocf0oTf7c1tUNB5rnnRrtZi9vKME4aXZsSzyrc1a8fh1DsimkyUgquKgzavtv1
         HclsoPRN4u93dmFn75WP80lTmAqJ7TRnuIuqte35lriu+zyxYUiDpPfQgW2mTeJGAvf8
         jlXGcgL4K3OA+1qM+s3MIGpxhukI/koBKdNgFKoyyFyak9VBekeoC3ecZRIYChXSRXjn
         fjnw==
X-Forwarded-Encrypted: i=1; AJvYcCXS7t971rF7qG4Q7HZoDr9mlLtJOJGVJLYchKkcaTiATUoACaVIbZvdxKgydC36wswOSkwKvIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr94ZjGuakFG3wyd7RpXwfUJHTM3OsAVVj3SUPdKAtgDfhmLsZ
	OPCRx6ewKI8i8uNweLoHwmhMsmf87NS64lgh7FpyUcF84FY4yPC0Uh9ub+MrGs+PjyatE7d1n1w
	W/gzCKw==
X-Google-Smtp-Source: AGHT+IHPIit4EBCi4KUwrIF8JqHnJu2P8oo8qjAe90cTQLM6Pq0qvSnkFUdlDy8G5kowRkiqmWWg+HwRXaM=
X-Received: from pjbml14.prod.google.com ([2002:a17:90b:360e:b0:341:3e7:538f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5444:b0:339:d1f0:c740
 with SMTP id 98e67ed59e1d1-343f9ea688fmr5241098a91.1.1763172583954; Fri, 14
 Nov 2025 18:09:43 -0800 (PST)
Date: Sat, 15 Nov 2025 02:08:34 +0000
In-Reply-To: <20251115020935.2643121-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251115020935.2643121-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251115020935.2643121-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/7] af_unix: Don't trigger GC from close() if unnecessary.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have been triggering GC on every close() if there is even one
inflight AF_UNIX socket.

This is because the old GC implementation had no idea of the graph
shape formed by SCM_RIGHTS references.

The new GC knows whether there could be a cyclic reference or not,
and we can do better.

Let's not trigger GC from close() if there is no cyclic reference
or GC is already in progress.

While at it, unix_gc() is renamed to unix_schedule_gc() as it does
not actually perform GC since commit 8b90a9f819dc ("af_unix: Run
GC on only one CPU.").

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c |  3 +--
 net/unix/af_unix.h |  3 +--
 net/unix/garbage.c | 27 +++++++++++++++++----------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3b44cadaed96..4a80dac56bbd 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -733,8 +733,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
 
 	/* ---- Socket is dead now and most probably destroyed ---- */
 
-	if (READ_ONCE(unix_tot_inflight))
-		unix_gc();		/* Garbage collect fds */
+	unix_schedule_gc();
 }
 
 struct unix_peercred {
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index 59db179df9bb..0fb5b348ad94 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -24,13 +24,12 @@ struct unix_skb_parms {
 #define UNIXCB(skb)	(*(struct unix_skb_parms *)&((skb)->cb))
 
 /* GC for SCM_RIGHTS */
-extern unsigned int unix_tot_inflight;
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
 void unix_del_edges(struct scm_fp_list *fpl);
 void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
-void unix_gc(void);
+void unix_schedule_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
 
 /* SOCK_DIAG */
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 7528e2db1293..190dea73f0ab 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -137,7 +137,7 @@ static void unix_update_graph(struct unix_vertex *vertex)
 	if (!vertex)
 		return;
 
-	unix_graph_state = UNIX_GRAPH_MAYBE_CYCLIC;
+	WRITE_ONCE(unix_graph_state, UNIX_GRAPH_MAYBE_CYCLIC);
 }
 
 static LIST_HEAD(unix_unvisited_vertices);
@@ -200,7 +200,7 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 }
 
 static DEFINE_SPINLOCK(unix_gc_lock);
-unsigned int unix_tot_inflight;
+static unsigned int unix_tot_inflight;
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
@@ -540,7 +540,8 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 
 	unix_graph_cyclic_sccs = cyclic_sccs;
-	unix_graph_state = cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC;
+	WRITE_ONCE(unix_graph_state,
+		   cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC);
 }
 
 static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
@@ -573,12 +574,13 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 
 	unix_graph_cyclic_sccs = cyclic_sccs;
-	unix_graph_state = cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC;
+	WRITE_ONCE(unix_graph_state,
+		   cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC);
 }
 
 static bool gc_in_progress;
 
-static void __unix_gc(struct work_struct *work)
+static void unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
@@ -609,10 +611,16 @@ static void __unix_gc(struct work_struct *work)
 	WRITE_ONCE(gc_in_progress, false);
 }
 
-static DECLARE_WORK(unix_gc_work, __unix_gc);
+static DECLARE_WORK(unix_gc_work, unix_gc);
 
-void unix_gc(void)
+void unix_schedule_gc(void)
 {
+	if (READ_ONCE(unix_graph_state) == UNIX_GRAPH_NOT_CYCLIC)
+		return;
+
+	if (READ_ONCE(gc_in_progress))
+		return;
+
 	WRITE_ONCE(gc_in_progress, true);
 	queue_work(system_dfl_wq, &unix_gc_work);
 }
@@ -628,9 +636,8 @@ void wait_for_unix_gc(struct scm_fp_list *fpl)
 	 * Paired with the WRITE_ONCE() in unix_inflight(),
 	 * unix_notinflight(), and __unix_gc().
 	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
-	    !READ_ONCE(gc_in_progress))
-		unix_gc();
+	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
+		unix_schedule_gc();
 
 	/* Penalise users who want to send AF_UNIX sockets
 	 * but whose sockets have not been received yet.
-- 
2.52.0.rc1.455.g30608eb744-goog


