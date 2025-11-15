Return-Path: <netdev+bounces-238816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F54C5FDC6
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8B114E3893
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C181E98EF;
	Sat, 15 Nov 2025 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIcbYIHG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5691E22E9
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172583; cv=none; b=SHwI/lU6YHktfxJyRxbiGDg4fcslH2qjVt3+AlEseyRPa0Bb11UrY4WKZiW4zZtWq7US6azv3RyaeUt9nZ3DJprHCeLs5mChkhn890/Mlc0jX8xaPCuzMltmaMVY9SjN8mrNLySFCl0F0Bu95HftWfoLbrq9Mey+fQtvMFNxuog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172583; c=relaxed/simple;
	bh=jwCppCFCqVl709oakk2QvwDR9Tp6JHIIkl9MK9rWVh0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FUxSkSO3KO+D4SN1IRJJn47UoQ4ZXZgZUSxgFa9wkTnY5wYyrgqQgNY/Qr1dcWzxFxnx1WA6nh7lb0nPjFCiTZ8isuuim6Z1eu6mUyYDU76wOkK0qGy8+64XZDjHHhE3jCrs1rcfhvjVRpWntdoHfpKDTyQOGvUzNVpJ7xuMmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JIcbYIHG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3436e9e3569so5805454a91.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763172581; x=1763777381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRimpaAklr3MgoMxteUiAyHpkrpJlvBhWQSlf6DgDmM=;
        b=JIcbYIHGVJRYZc1CYsQVJFDWUEFLNZpXJxfr2aUt0GvWIQuCWPHKeZGhmwosmXW+Xv
         Rj59uDpBJj2lVN6+ycj/vlWX8oRAYmilhw/LyumsCGFpnmHx3XGkKApyP+eyZNqbTdwS
         LgqVbpO9ZpXh9lOmbJZieYhlWhh917z3abYwclTAdV5x4VaQor/1XnVmekJyanCedMzz
         NeSHpRkgCcdZl97mJkXSHyJHVim+pxI/iLDVQFCOraIc+7Pz3Oc6DDZSGaRJanKjTssY
         1i/YxWdwC9JA/Ka1Awg1EVvhKHZ7m9xoZ6wI8OLTwbS/bhz1Jf6T2S8XwOp6qqSKMgLZ
         bNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172581; x=1763777381;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRimpaAklr3MgoMxteUiAyHpkrpJlvBhWQSlf6DgDmM=;
        b=FE+yKY/CdGrv/ro59Yik+j/O51rnjwzkxBbt1Fc+n8s6Ghiob+ViHYzM9TLog7Q9cf
         ciXmJ1+Lz7t+no8u5aptHmn002vCqQrPeHgXhuePdDMq7Xg51/rfg1+jJqtAfYD3SfTz
         BfXiRM8tMFPeisDSijFBEQ632MzM3IF1eQGpKm2MTSX6TYqn/VpQE4kSVBSCZic8jEYf
         J4y3QH99v4kr+jVuNY2p9NxnKed/MUYL/VEPgL3HWfN78C/sdKV28q6bgAIQ6Tj40G0/
         vjA9VstGXiWGsdhXdv18mv/FykX9UCvBqQFhVLAKVCfEWD5E0qL0QoJCpAiwqpV1Pt2Q
         ZR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmI2f/EebA9mG9JyOXop1vqAJNP98qGVQ5+lXb+U8cHDtxOV9R1Hu4+16CeFrulqA8z8+OULY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXdbxzYz9jjMw/f3zZ1L0F4RcfNDS5ZHxGPK9u/SlH17t2nsNB
	jxPRu88gxEBH6YcoL5pNY9dQbo1bMUWK0/o42WJjAe9bnJRKcpwcop15+buCbnvcDhxDt48ZThw
	yMsfr2g==
X-Google-Smtp-Source: AGHT+IEoVkzwbgDvqk+ynlMFqYhcSdPBjxo8qh1thzLnSTEfL7ozulHod/AvZzB4T+QFAVZs6j/SeqWzlsM=
X-Received: from pjst15.prod.google.com ([2002:a17:90b:18f:b0:340:a575:55db])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b86:b0:33e:30b2:d20
 with SMTP id 98e67ed59e1d1-343fa79011cmr5826510a91.33.1763172580907; Fri, 14
 Nov 2025 18:09:40 -0800 (PST)
Date: Sat, 15 Nov 2025 02:08:32 +0000
In-Reply-To: <20251115020935.2643121-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251115020935.2643121-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251115020935.2643121-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/7] af_unix: Count cyclic SCC.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__unix_walk_scc() and unix_walk_scc_fast() call unix_scc_cyclic()
for each SCC to check if it forms a cyclic reference, so that we
can skip GC at the following invocations in case all SCCs do not
have any cycles.

If we count the number of cyclic SCCs in __unix_walk_scc(), we can
simplify unix_walk_scc_fast() because the number of cyclic SCCs
only changes when it garbage-collects a SCC.

So, let's count cyclic SCC in __unix_walk_scc() and decrement it
in unix_walk_scc_fast() when performing garbage collection.

Note that we will use this counter in a later patch to check if a
cycle existed in the previous GC run.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/garbage.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 65396a4e1b07..9f62d5097973 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -404,9 +404,11 @@ static bool unix_scc_cyclic(struct list_head *scc)
 static LIST_HEAD(unix_visited_vertices);
 static unsigned long unix_vertex_grouped_index = UNIX_VERTEX_INDEX_MARK2;
 
-static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_index,
-			    struct sk_buff_head *hitlist)
+static unsigned long __unix_walk_scc(struct unix_vertex *vertex,
+				     unsigned long *last_index,
+				     struct sk_buff_head *hitlist)
 {
+	unsigned long cyclic_sccs = 0;
 	LIST_HEAD(vertex_stack);
 	struct unix_edge *edge;
 	LIST_HEAD(edge_stack);
@@ -497,8 +499,8 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 			if (unix_vertex_max_scc_index < vertex->scc_index)
 				unix_vertex_max_scc_index = vertex->scc_index;
 
-			if (!unix_graph_maybe_cyclic)
-				unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+			if (unix_scc_cyclic(&scc))
+				cyclic_sccs++;
 		}
 
 		list_del(&scc);
@@ -507,13 +509,17 @@ static void __unix_walk_scc(struct unix_vertex *vertex, unsigned long *last_inde
 	/* Need backtracking ? */
 	if (!list_empty(&edge_stack))
 		goto prev_vertex;
+
+	return cyclic_sccs;
 }
 
+static unsigned long unix_graph_cyclic_sccs;
+
 static void unix_walk_scc(struct sk_buff_head *hitlist)
 {
 	unsigned long last_index = UNIX_VERTEX_INDEX_START;
+	unsigned long cyclic_sccs = 0;
 
-	unix_graph_maybe_cyclic = false;
 	unix_vertex_max_scc_index = UNIX_VERTEX_INDEX_START;
 
 	/* Visit every vertex exactly once.
@@ -523,18 +529,20 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 		struct unix_vertex *vertex;
 
 		vertex = list_first_entry(&unix_unvisited_vertices, typeof(*vertex), entry);
-		__unix_walk_scc(vertex, &last_index, hitlist);
+		cyclic_sccs += __unix_walk_scc(vertex, &last_index, hitlist);
 	}
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 
+	unix_graph_cyclic_sccs = cyclic_sccs;
+	unix_graph_maybe_cyclic = !!unix_graph_cyclic_sccs;
 	unix_graph_grouped = true;
 }
 
 static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 {
-	unix_graph_maybe_cyclic = false;
+	unsigned long cyclic_sccs = unix_graph_cyclic_sccs;
 
 	while (!list_empty(&unix_unvisited_vertices)) {
 		struct unix_vertex *vertex;
@@ -551,15 +559,18 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 				scc_dead = unix_vertex_dead(vertex);
 		}
 
-		if (scc_dead)
+		if (scc_dead) {
+			cyclic_sccs--;
 			unix_collect_skb(&scc, hitlist);
-		else if (!unix_graph_maybe_cyclic)
-			unix_graph_maybe_cyclic = unix_scc_cyclic(&scc);
+		}
 
 		list_del(&scc);
 	}
 
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
+
+	unix_graph_cyclic_sccs = cyclic_sccs;
+	unix_graph_maybe_cyclic = !!unix_graph_cyclic_sccs;
 }
 
 static bool gc_in_progress;
-- 
2.52.0.rc1.455.g30608eb744-goog


