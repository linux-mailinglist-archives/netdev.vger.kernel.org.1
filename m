Return-Path: <netdev+bounces-237023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48239C43785
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 03:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03DD3AF535
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 02:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA119F115;
	Sun,  9 Nov 2025 02:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JP8Z8A4Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE65415278E
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 02:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762656758; cv=none; b=VhDub5BAFqkalQzXisZhXLTE+EJrYgkmAuusWIcdswhJ9+zak+ixycAGpEMm+uaYM9STbPb2z/8h09xaZZdSdwRdlA/rk3qUtvsqqxWUiczivrqfwNlXFsWMCHcfpWmL52+g/rc7s5wuqBZAash6YYPh6eTn/CtODI9c4BPeRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762656758; c=relaxed/simple;
	bh=o5XgN65Wo6hzRrlqEOV85jDO6u9CWjzc4suf2/1Sg8w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TwsK4KZExCzJDSFWhgRn623eVUR9CfaeQ4F7/wcsBDE+6nWG+7igv3h05C9KSg4vlwyNzxFBTdzUucb22boqygVx0IxLC65GcleGQj6GaYUxddMRBZmhODQz1KiZbrITPm+yv3tm6oq1hj1mN6ZQ5aHQMLl4aU5KgUG4P/5bhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JP8Z8A4Y; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b993eb2701bso1636874a12.0
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 18:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762656756; x=1763261556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b2mVTvv/0uDHosUJCad9I/8YAheWl5sPbcSS9bDotHA=;
        b=JP8Z8A4YKZ9fsNt8rSJeCfzu4SGYN63iXVCUEk2j3L2IuwqusDixQLA2ynNyoD1NiB
         Z9w44WboEAS7ijBxbPydWNZvcpgvZddtOXTvNJ2ymxZiHS1FhtLT0f4K5A/+M0DhZu28
         5LRxsL5kCiFFDwZ4rlvIb2Q7UYbhk7/7IooUZLbF2hJOwKNa9JlxNOwlZ7WUnW1NSDbQ
         ZK82yZY79Y3TPzn5uUayxp7yF/XHXE/DedKIhocN89ibNnzteBJ3aglnXRBaGAlkG38s
         EqgFnpN6QYpirC53QVtK4GfdlrWDzW3rf77ByZDa08Wj3KUB2F+FIbbc4HsnedJAO3Sx
         xFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762656756; x=1763261556;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b2mVTvv/0uDHosUJCad9I/8YAheWl5sPbcSS9bDotHA=;
        b=CtLSUUXOiSWXEOx79AOdyNYRTdNYWnXiNgC+XXhv1gpvdyWnlEADClNH687uZ9XI5M
         kZy0EwL+RUmTWiCmbvck7L8N4DMgndzeMp9rPZzRmAG2B0RXwUoH6FXaswG3CmmtSCf1
         1xnaGYHAvtLhiXbUr/JbztYakH1O06KE3AYkV5NWU9LBVb2uRA7S7DICLqAaY7Px0az6
         36CN6Oy6oaj66xCDIC4nkj5yHUkZ4XMAw+y/CEBGe8+hgL0mVBKfMKxHnkpmx5eMmzGM
         6mHQWetoe5D3Fi4L1QdwwLvcRru0tT0Yz5NJhVZdGS2g/M597Nn+6BX54p0eRro0M+ke
         xz4A==
X-Forwarded-Encrypted: i=1; AJvYcCWRtYzKBGUj4dgbKd3esegLlLAotbKDZ3hD9yA9600CxdTT2TGmcZWnHSNgXciqONrk90skPJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9zbm0VCA9Laiz5YN0E1rIchF4iwLYbAPTyOxEvRJvjVY0Ku9
	YwJFaRMAq9p7ieRiTYAH35lVnoE2YwwgF3qLsN9GBGiL1R9IAqhGs+WPPF3l89+4kLowp+D49/u
	gmxJGMw==
X-Google-Smtp-Source: AGHT+IEEYKnobIm/1hcjVo9hLBoWxfpUftEm06h2ufRxHWejJ3TLLSuO6jaPry6bdhUVzwJVpbmraXEHxug=
X-Received: from pjsi3.prod.google.com ([2002:a17:90a:65c3:b0:340:8a98:4706])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b84:b0:321:9366:5865
 with SMTP id 98e67ed59e1d1-3436cd0f021mr4605891a91.33.1762656755899; Sat, 08
 Nov 2025 18:52:35 -0800 (PST)
Date: Sun,  9 Nov 2025 02:52:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251109025233.3659187-1-kuniyu@google.com>
Subject: [PATCH v1 net] af_unix: Initialise scc_index in unix_add_edge().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Quang Le <quanglex97@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Quang Le reported that the AF_UNIX GC could garbage-collect a
receive queue of an alive in-flight socket, with a nice repro.

The repro consists of three stages.

  1)
    1-a. Create a single cyclic reference with many sockets
    1-b. close() all sockets
    1-c. Trigger GC

  2)
    2-a. Pass sk-A to an embryo sk-B
    2-b. Pass sk-X to sk-X
    2-c. Trigger GC

  3)
    3-a. accept() the embryo sk-B
    3-b. Pass sk-B to sk-C
    3-c. close() the in-flight sk-A
    3-d. Trigger GC

As of 2-c, sk-A and sk-X are linked to unix_unvisited_vertices,
and unix_walk_scc() groups them into two different SCCs:

  unix_sk(sk-A)->vertex->scc_index = 2 (UNIX_VERTEX_INDEX_START)
  unix_sk(sk-X)->vertex->scc_index = 3

Once GC completes, unix_graph_grouped is set to true.
Also, unix_graph_maybe_cyclic is set to true due to sk-X's
cyclic self-reference, which makes close() trigger GC.

At 3-b, unix_add_edge() allocates unix_sk(sk-B)->vertex and
links it to unix_unvisited_vertices.

unix_update_graph() is called at 3-a. and 3-b., but neither
unix_graph_grouped nor unix_graph_maybe_cyclic is changed
because both sk-B's listener and sk-C are not in-flight.

3-c decrements sk-A's file refcnt to 1.

Since unix_graph_grouped is true at 3-d, unix_walk_scc_fast()
is finally called and iterates 3 sockets sk-A, sk-B, and sk-X:

  sk-A -> sk-B (-> sk-C)
  sk-X -> sk-X

This is totally fine.  All of them are not yet close()d and
should be grouped into different SCCs.

However, unix_vertex_dead() misjudges that sk-A and sk-B are
in the same SCC and sk-A is dead.

  unix_sk(sk-A)->scc_index == unix_sk(sk-B)->scc_index <-- Wrong!
  &&
  sk-A's file refcnt == unix_sk(sk-A)->vertex->out_degree
                                       ^-- 1 in-flight count for sk-B
  -> sk-A is dead !?

The problem is that unix_add_edge() does not initialise scc_index.

Stage 1) is used for heap spraying, making a newly allocated
vertex have vertex->scc_index == 2 (UNIX_VERTEX_INDEX_START)
set by unix_walk_scc() at 1-c.

Let's track the max SCC index from the previous unix_walk_scc()
call and assign the max + 1 to a new vertex's scc_index.

This way, we can continue to avoid Tarjan's algorithm while
preventing misjudgments.

Fixes: ad081928a8b0 ("af_unix: Avoid Tarjan's algorithm if unnecessary.")
Reported-by: Quang Le <quanglex97@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/garbage.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 684ab03137b6..65396a4e1b07 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -145,6 +145,7 @@ enum unix_vertex_index {
 };
 
 static unsigned long unix_vertex_unvisited_index = UNIX_VERTEX_INDEX_MARK1;
+static unsigned long unix_vertex_max_scc_index = UNIX_VERTEX_INDEX_START;
 
 static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
@@ -153,6 +154,7 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 	if (!vertex) {
 		vertex = list_first_entry(&fpl->vertices, typeof(*vertex), entry);
 		vertex->index = unix_vertex_unvisited_index;
+		vertex->scc_index = ++unix_vertex_max_scc_index;
 		vertex->out_degree = 0;
 		INIT_LIST_HEAD(&vertex->edges);
 		INIT_LIST_HEAD(&vertex->scc_entry);
@@ -489,10 +491,15 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 				scc_dead = unix_vertex_dead(v);
 		}
 
-		if (scc_dead)
+		if (scc_dead) {
 			unix_collect_skb(&scc, hitlist);
-		else if (!unix_graph_maybe_cyclic)
-			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+		} else {
+			if (unix_vertex_max_scc_index < vertex->scc_index)
+				unix_vertex_max_scc_index = vertex->scc_index;
+
+			if (!unix_graph_maybe_cyclic)
+				unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+		}
 
 		list_del(&scc);
 	}
@@ -507,6 +514,7 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 	unsigned long last_index = UNIX_VERTEX_INDEX_START;
 
 	unix_graph_maybe_cyclic = false;
+	unix_vertex_max_scc_index = UNIX_VERTEX_INDEX_START;
 
 	/* Visit every vertex exactly once.
 	 * __unix_walk_scc() moves visited vertices to unix_visited_vertices.
-- 
2.51.2.1041.gc1ab5b90ca-goog


