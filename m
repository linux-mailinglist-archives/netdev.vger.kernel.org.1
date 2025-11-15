Return-Path: <netdev+bounces-238817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E60C5FDC9
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 03:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70E8A35A97E
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 02:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D61F03EF;
	Sat, 15 Nov 2025 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZrzH57M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD41E8337
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172584; cv=none; b=Re/opycxwlQF68W5DhF1YHNw7giiAO3jHz/Q+Ksb/daGmjq3N1WEpH9+OxNcsy9m5fJl9UyLtiWTgYwaes+AlGlK9kkWhH6fMFoHrkFrKHoo0xS9BD8JPwlOL7aOrjDCwcbRZQL3SmhM4IiYP5yhRBhZRq5jvcwfF3b2p5SzW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172584; c=relaxed/simple;
	bh=bn3xL+dL7vOwgQyVt3D6QidHQP2tk1KZPQ8uPATZ4y8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=phoqX0kKyI5zfcMqwEFi7DpdZFa0hsex+KLjTijv0yao9dZYZSHHeVzf8x17RGFm61Q97zRBC78wyHpZCj56qNgNa7KiYTdNiCyfQbGt8lb70tkLKvDrbFyDymxjcnEfQf7vf76Wb3gWItztt0CVKWFuzyyi4E2S/JFQHT+xNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZrzH57M; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343daf0f38aso3076365a91.3
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 18:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763172582; x=1763777382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=71Fx0lFJdTb4YOLn3Z/PbZf2BFefMTlijGaRei61nVk=;
        b=gZrzH57MBOPuRhVqP39/8zPxRfQqarPQZgsyjGIQ6B8AX2cAxT143M5TMQ03F4mfAg
         NB/b0o3Pu4k5nXv9hTXsZ1KAUplHTb4wWUdgKnTgHtVlmUirwl5CpfIUrPyxfdroqwXM
         Qd6xPRyvmd6QAU05xPzTufRUwSMdR4h4JOAytImmIKiGkAEgKfW5FPzAf1VHpCOoE1cv
         pEIRqSBWh2Kzc5P6juHGu9VAncWZvx6VnLcOaIU4/PZhQDjAnrTt1WkbLOJcm0u9aORj
         TtbBsT3iAfrORmpQVN6hl2jZoExrm5s4Erh9GMxoMazYPGQ1EGH/uPZ7nMGX4Nb204qA
         phIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172582; x=1763777382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71Fx0lFJdTb4YOLn3Z/PbZf2BFefMTlijGaRei61nVk=;
        b=dkfWyskIxLVhlzEdzyqLv359/BebPk7cvG8xbpAqecOUBp5plWeNZaqnPrin6XNNvj
         BERWYPHd+UHm41ADDBfHxeDqUxiFciiJFLbpbXRKhFxv/g+8lnby3jHv3JG312/hm3Tt
         YOa4BH3Pig4PGMqFyqkRCTobtVw/kdoeGjbih4u+7Im6oeGd1UM9vYRQEL13du9E3Dft
         ZkwHhGSGfr3nRHLNr/3RrONfZ+RsGTVsQ8fev8E9eU5sVugUCGxP9MyuilHZrK9AlG6D
         AXz/pbTiv4CgFiA5p377Gv/yt4uRpN7unDaid0uF1XYe9RsGDsKxeSPfq2rv14REuJgy
         eQ2g==
X-Forwarded-Encrypted: i=1; AJvYcCVzVLNc07a03xfB279fGarkgQqa8ZY5+43YR5mc6CgChskteDkIGLg/If81qfp0PpF660rWXF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9pJHXMbCRZJabHravG+NrtvFrlHEAhqchSsqpQ6qg4cfxwggs
	x+JBfv7YO4GxPwV4crnxjTslwJmcnLTY/WYIFaw8iuR1AmLm0e7AMUfLz9cY3ks7+I1QRTHQTzM
	Shq4RLQ==
X-Google-Smtp-Source: AGHT+IEmZ83Y1Lb0wHs6eItDUPMl65snlg7z15KOb+RAbbgs0/L4ImtN/7y5Q2vFqTdslVn8HyzaATegcFk=
X-Received: from pjbbr14.prod.google.com ([2002:a17:90b:f0e:b0:33b:52d6:e13e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dc9:b0:343:7714:4caa
 with SMTP id 98e67ed59e1d1-343f9e92175mr5560109a91.3.1763172582406; Fri, 14
 Nov 2025 18:09:42 -0800 (PST)
Date: Sat, 15 Nov 2025 02:08:33 +0000
In-Reply-To: <20251115020935.2643121-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251115020935.2643121-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251115020935.2643121-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/7] af_unix: Simplify GC state.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

GC manages its state by two variables, unix_graph_maybe_cyclic
and unix_graph_grouped, both of which are set to false in the
initial state.

When an AF_UNIX socket is passed to an in-flight AF_UNIX socket,
unix_update_graph() sets unix_graph_maybe_cyclic to true and
unix_graph_grouped to false, making the next GC invocation call
unix_walk_scc() to group SCCs.

Once unix_walk_scc() finishes, sockets in the same SCC are linked
via vertex->scc_entry.  Then, unix_graph_grouped is set to true
so that the following GC invocations can skip Tarjan's algorithm
and simply iterate through the list in unix_walk_scc_fast().

In addition, if we know there is at least one cyclic reference,
we set unix_graph_maybe_cyclic to true so that we do not skip GC.

So the state transitions as follows:

  (unix_graph_maybe_cyclic, unix_graph_grouped)
  =
  (false, false) -> (true, false) -> (true, true) or (false, true)
                         ^.______________/________________/

There is no transition to the initial state where both variables
are false.

If we consider the initial state as grouped, we can see that the
GC actually has a tristate.

Let's consolidate two variables into one enum.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/garbage.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 9f62d5097973..7528e2db1293 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -121,8 +121,13 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
 	return edge->successor->vertex;
 }
 
-static bool unix_graph_maybe_cyclic;
-static bool unix_graph_grouped;
+enum {
+	UNIX_GRAPH_NOT_CYCLIC,
+	UNIX_GRAPH_MAYBE_CYCLIC,
+	UNIX_GRAPH_CYCLIC,
+};
+
+static unsigned char unix_graph_state;
 
 static void unix_update_graph(struct unix_vertex *vertex)
 {
@@ -132,8 +137,7 @@ static void unix_update_graph(struct unix_vertex *vertex)
 	if (!vertex)
 		return;
 
-	unix_graph_maybe_cyclic = true;
-	unix_graph_grouped = false;
+	unix_graph_state = UNIX_GRAPH_MAYBE_CYCLIC;
 }
 
 static LIST_HEAD(unix_unvisited_vertices);
@@ -536,8 +540,7 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 
 	unix_graph_cyclic_sccs = cyclic_sccs;
-	unix_graph_maybe_cyclic = !!unix_graph_cyclic_sccs;
-	unix_graph_grouped = true;
+	unix_graph_state = cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC;
 }
 
 static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
@@ -570,7 +573,7 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 
 	unix_graph_cyclic_sccs = cyclic_sccs;
-	unix_graph_maybe_cyclic = !!unix_graph_cyclic_sccs;
+	unix_graph_state = cyclic_sccs ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC;
 }
 
 static bool gc_in_progress;
@@ -582,14 +585,14 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_lock(&unix_gc_lock);
 
-	if (!unix_graph_maybe_cyclic) {
+	if (unix_graph_state == UNIX_GRAPH_NOT_CYCLIC) {
 		spin_unlock(&unix_gc_lock);
 		goto skip_gc;
 	}
 
 	__skb_queue_head_init(&hitlist);
 
-	if (unix_graph_grouped)
+	if (unix_graph_state == UNIX_GRAPH_CYCLIC)
 		unix_walk_scc_fast(&hitlist);
 	else
 		unix_walk_scc(&hitlist);
-- 
2.52.0.rc1.455.g30608eb744-goog


