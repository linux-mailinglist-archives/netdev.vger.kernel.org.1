Return-Path: <netdev+bounces-93387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A47E8BB7A2
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664BEB231C2
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0190586257;
	Fri,  3 May 2024 22:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="F1b8Fv8O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A884A4F
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775645; cv=none; b=Y6fRhaB5hYp3UF/kUaVlnxvwMVSdT84VliGhlUvGzzKp5uZTdYpbev4n27WOMznh5zf9twdk/CJqyWERynsZ3twVK7hhj2mI6mC6JROBs+BbHuJv1X9q6RpomNln3MHDaDhy65zDzmBlt5Km/zc1MuuhFcWywc2I2WfcBvjIVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775645; c=relaxed/simple;
	bh=WK+B8Bs8viY4KE5Abjv3HZ5UGzlvDET0ffb+z7a2bNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWHe5KywHmLMzOjwqTYuxddT3FHc8eQtnIAQdvsHy6xL8gErKf00PjPemYQc0gAV9kRyvOH2hPkav3EGiI4ekPZCNR8c8jcXEsRTyAczMay4+C/xu33mOO22XDnn4K8nPJUs1i6z/GCeXrHOiporRD6WKFc0VmgON0rK7q6TIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=F1b8Fv8O; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714775645; x=1746311645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXYH5fpf0y+XFw/VidzK3Ry5kZgM04X4YWdxYb+d/ts=;
  b=F1b8Fv8OU25WE0Pcx535CWYPkHaxIkmNf8zqYRYaj/Kx2idlCkkvQ0hn
   OFJxoGHg0Xb9GU/ZuGyjAQH7iK7trA+48hxLEK62/qsROQuylGsqWpbu3
   SneiKlMb2qVP0aHNJAvHyJIbjj/wIH78kNjE1hZE4ymre5xyGxGa5iioA
   c=;
X-IronPort-AV: E=Sophos;i="6.07,252,1708387200"; 
   d="scan'208";a="293892173"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 22:34:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:21792]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.153:2525] with esmtp (Farcaster)
 id 7ed52cd0-ad13-437f-b3ce-a13fd06b0614; Fri, 3 May 2024 22:34:02 +0000 (UTC)
X-Farcaster-Flow-ID: 7ed52cd0-ad13-437f-b3ce-a13fd06b0614
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:34:01 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 3 May 2024 22:33:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/6] af_unix: Schedule GC based on graph state during sendmsg().
Date: Fri, 3 May 2024 15:31:49 -0700
Message-ID: <20240503223150.6035-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240503223150.6035-1-kuniyu@amazon.com>
References: <20240503223150.6035-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The conventional test to trigger GC was based on the number of inflight
sockets.

Now we have more reliable data indicating if the loop exists in the graph.

When the graph state is

  1. UNIX_GRAPH_NOT_CYCLIC, do not scheudle GC
  2. UNIX_GRAPH_MAYBE_CYCLIC, schedule GC if unix_tot_inflight > 16384
  3. UNIX_GRAPH_CYCLIC, schedule GC if unix_graph_circles > 1024

1024 might sound much smaller than 16384, but if the number of loops
is larger than 1024, there must be something wrong.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 85c0500764d4..48cea3cf4a42 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -128,7 +128,7 @@ static void unix_update_graph(struct unix_vertex *vertex)
 	if (!vertex)
 		return;
 
-	unix_graph_state = UNIX_GRAPH_MAYBE_CYCLIC;
+	WRITE_ONCE(unix_graph_state, UNIX_GRAPH_MAYBE_CYCLIC);
 }
 
 static LIST_HEAD(unix_unvisited_vertices);
@@ -533,7 +533,8 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 
-	unix_graph_state = unix_graph_circles ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC;
+	WRITE_ONCE(unix_graph_state,
+		   unix_graph_circles ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC);
 }
 
 static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
@@ -555,7 +556,7 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 
 		if (scc_dead) {
 			unix_collect_skb(&scc, hitlist);
-			unix_graph_circles--;
+			WRITE_ONCE(unix_graph_circles, unix_graph_circles - 1);
 		}
 
 		list_del(&scc);
@@ -564,7 +565,7 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 
 	if (!unix_graph_circles)
-		unix_graph_state = UNIX_GRAPH_NOT_CYCLIC;
+		WRITE_ONCE(unix_graph_state, UNIX_GRAPH_NOT_CYCLIC);
 }
 
 static bool gc_in_progress;
@@ -608,27 +609,38 @@ void unix_gc(void)
 	queue_work(system_unbound_wq, &unix_gc_work);
 }
 
-#define UNIX_INFLIGHT_TRIGGER_GC 16000
+#define UNIX_INFLIGHT_SANE_CIRCLES (1 << 10)
+#define UNIX_INFLIGHT_SANE_SOCKETS (1 << 14)
 #define UNIX_INFLIGHT_SANE_USER (SCM_MAX_FD * 8)
 
 static void __unix_schedule_gc(struct scm_fp_list *fpl)
 {
-	/* If number of inflight sockets is insane,
-	 * force a garbage collect right now.
-	 *
-	 * Paired with the WRITE_ONCE() in unix_inflight(),
-	 * unix_notinflight(), and __unix_gc().
+	unsigned char graph_state = READ_ONCE(unix_graph_state);
+	bool wait = false;
+
+	if (graph_state == UNIX_GRAPH_NOT_CYCLIC)
+		return;
+
+	/* If the number of inflight sockets or cyclic references
+	 * is insane, schedule garbage collector if not running.
 	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
-	    !READ_ONCE(gc_in_progress))
-		unix_gc();
+	if (graph_state == UNIX_GRAPH_CYCLIC) {
+		if (READ_ONCE(unix_graph_circles) < UNIX_INFLIGHT_SANE_CIRCLES)
+			return;
+	} else {
+		if (READ_ONCE(unix_tot_inflight) < UNIX_INFLIGHT_SANE_SOCKETS)
+			return;
+	}
 
 	/* Penalise users who want to send AF_UNIX sockets
 	 * but whose sockets have not been received yet.
 	 */
-	if (READ_ONCE(fpl->user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
-		return;
+	if (READ_ONCE(fpl->user->unix_inflight) > UNIX_INFLIGHT_SANE_USER)
+		wait = true;
+
+	if (!READ_ONCE(gc_in_progress))
+		unix_gc();
 
-	if (READ_ONCE(gc_in_progress))
+	if (wait)
 		flush_work(&unix_gc_work);
 }
-- 
2.30.2


