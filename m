Return-Path: <netdev+bounces-93385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1A8BB79F
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA12288A15
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA56C839F8;
	Fri,  3 May 2024 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="T/n3ECKf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579FA7E56C
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775603; cv=none; b=ERL1ag+RhfV4oifb0o2dV9aqHxyXNM+NKme6JlF8ikC0FHzMOzAgmYFW3RcuDuMRoonm+N/9HoPgtELbfVNcacfhCGOpnxwcm2Qz7egpPMncJhWCkIq8TBVWipanlCMgS9PrrQT33UzD71cB+8OTx5B3leSRpZvwnF0Uv9Qe7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775603; c=relaxed/simple;
	bh=xa5cFyUIJcwK1Mk8lpIyCjDJyHppop1Eyv6yPwafLzg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZa86ODsv1fnDUMiSEtmv/Tk7+QltO79pe+JNPvpFKkVFrp2Z06nyRtzAZc5nFtUengNHKID4okP981E4h7+RGptKLZo3NuQ0tGdfY/zvapajTn91wNgbVzhjcKGyYvg4NwbFdx0Wq0CuIbplkyiGict7nAgKa/KzVtE/APOtOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=T/n3ECKf; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714775602; x=1746311602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TWPXT+dP4zPVPgasr2vqReZRsgaZLTNcDUim8So3alA=;
  b=T/n3ECKfNy9aGaH25znExardn4b4hE1hPMuQtaUyIWEmHpLOBMJp/tZy
   JlEqgAmgJ6w+hglSw2f8i/PzrERcwLEr7uV3X9+x3NEFn0S2hR3UguSwq
   qmlQDNnFEmHG0m2wQab9OnH2FIk8cZRKRM0UXp5hgSH7+eTigrbSJhTGk
   g=;
X-IronPort-AV: E=Sophos;i="6.07,252,1708387200"; 
   d="scan'208";a="342641954"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 22:33:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:7653]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.73:2525] with esmtp (Farcaster)
 id 326e160e-d662-4497-b624-48d9cef98ef8; Fri, 3 May 2024 22:33:14 +0000 (UTC)
X-Farcaster-Flow-ID: 326e160e-d662-4497-b624-48d9cef98ef8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:33:14 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:33:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/6] af_unix: Manage inflight graph state as unix_graph_state.
Date: Fri, 3 May 2024 15:31:47 -0700
Message-ID: <20240503223150.6035-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The graph state is managed by two variables, unix_graph_maybe_cyclic
and unix_graph_grouped.

However, unix_graph_grouped is checked only when unix_graph_maybe_cyclic
is true, so the graph state is actually tri-state.

Let's merge the two variables into unix_graph_state.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 7ffb80dd422c..478b2eb479a2 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -112,8 +112,13 @@ static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
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
@@ -123,8 +128,7 @@ static void unix_update_graph(struct unix_vertex *vertex)
 	if (!vertex)
 		return;
 
-	unix_graph_maybe_cyclic = true;
-	unix_graph_grouped = false;
+	unix_graph_state = UNIX_GRAPH_MAYBE_CYCLIC;
 }
 
 static LIST_HEAD(unix_unvisited_vertices);
@@ -525,8 +529,7 @@ static void unix_walk_scc(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 	swap(unix_vertex_unvisited_index, unix_vertex_grouped_index);
 
-	unix_graph_maybe_cyclic = !!unix_graph_circles;
-	unix_graph_grouped = true;
+	unix_graph_state = unix_graph_circles ? UNIX_GRAPH_CYCLIC : UNIX_GRAPH_NOT_CYCLIC;
 }
 
 static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
@@ -557,7 +560,7 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 
 	if (!unix_graph_circles)
-		unix_graph_maybe_cyclic = false;
+		unix_graph_state = UNIX_GRAPH_NOT_CYCLIC;
 }
 
 static bool gc_in_progress;
@@ -569,14 +572,14 @@ static void __unix_gc(struct work_struct *work)
 
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
2.30.2


