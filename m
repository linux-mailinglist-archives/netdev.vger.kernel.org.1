Return-Path: <netdev+bounces-94677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9688C02BA
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08645B228ED
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A401F93E;
	Wed,  8 May 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AEix1saJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2619B321D
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188327; cv=none; b=KaHekJ5XXFn3GuDvrua74ThAt+LzZphFBhOtZDFtokvC6323ltDp63hjlT9+WINBYyMWqFjZC6PigDzoDcim8OvaRuTWxWNgXYFjYstUQOGJIPYgYRc3Hs5pBM3DYWMSD8PG1+hP22X/dwHnwmF/FaOMIejqcNTufKrr440pV18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188327; c=relaxed/simple;
	bh=w06mc9S9PUKn9QAb+MEVpliMnDFrWzPqynfLY35ZGGQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UKdhesFwBBCGW9SxxsHCPep5ugI+gh1r0N8iESRGTLSYvcak2CNTS2jZnlvx0FjJw4jdNxALj2bWgzYTZYl2Z1Vb/SxRYomoJB0CFA1J/Z/wEFK++2UvFpUNYildOb5DxHHbXK1yxHhsPKs8+lUMndu8MssOITBNXs2ywh4BdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AEix1saJ; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715188327; x=1746724327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Xjf6Jtvq+VeNTQfoxnFY+nCBFobzlvOrRTzp+/ctGA=;
  b=AEix1saJf34hp68h92s5KN2mky6ozYZ4GzPtcbUri/3A1a4cpRm8qUYG
   mhbciyroM1gbcVN16mIJegv76Z0NfHPO800U3gH3mENIxlw2mO9v2Nziu
   y4cHCWI9UNwtF4sIRXQ+s5FIuxI6fUKaSLSyu/jHIl79SBgIq63ctcW8G
   8=;
X-IronPort-AV: E=Sophos;i="6.08,145,1712620800"; 
   d="scan'208";a="657501105"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 17:12:04 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:35454]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.59:2525] with esmtp (Farcaster)
 id 8cb61b3a-2fbd-4762-a25f-4be7a00e9643; Wed, 8 May 2024 17:12:02 +0000 (UTC)
X-Farcaster-Flow-ID: 8cb61b3a-2fbd-4762-a25f-4be7a00e9643
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 8 May 2024 17:12:02 +0000
Received: from 88665a182662.ant.amazon.com.com (10.88.140.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 8 May 2024 17:11:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next] af_unix: Add dead flag to struct scm_fp_list.
Date: Wed, 8 May 2024 10:11:50 -0700
Message-ID: <20240508171150.50601-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
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

Commit 1af2dface5d2 ("af_unix: Don't access successor in unix_del_edges()
during GC.") fixed use-after-free by avoid accessing edge->successor while
GC is in progress.

However, there could be a small race window where another process could
call unix_del_edges() while gc_in_progress is true and __skb_queue_purge()
is on the way.

So, we need another marker for struct scm_fp_list which indicates if the
skb is garbage-collected.

This patch adds dead flag in struct scm_fp_list and set it true before
calling __skb_queue_purge().

Fixes: 1af2dface5d2 ("af_unix: Don't access successor in unix_del_edges() during GC.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
v2:
  * Postpone patch 2-5 to the next cycle
  * Added Paolo's Acked-by

v1: https://lore.kernel.org/netdev/20240503223150.6035-1-kuniyu@amazon.com/
---
 include/net/scm.h  |  1 +
 net/core/scm.c     |  1 +
 net/unix/garbage.c | 14 ++++++++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index bbc5527809d1..0d35c7c77a74 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -33,6 +33,7 @@ struct scm_fp_list {
 	short			max;
 #ifdef CONFIG_UNIX
 	bool			inflight;
+	bool			dead;
 	struct list_head	vertices;
 	struct unix_edge	*edges;
 #endif
diff --git a/net/core/scm.c b/net/core/scm.c
index 5763f3320358..4f6a14babe5a 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -91,6 +91,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		fpl->user = NULL;
 #if IS_ENABLED(CONFIG_UNIX)
 		fpl->inflight = false;
+		fpl->dead = false;
 		fpl->edges = NULL;
 		INIT_LIST_HEAD(&fpl->vertices);
 #endif
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index d76450133e4f..1f8b8cdfcdc8 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -158,13 +158,11 @@ static void unix_add_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 	unix_update_graph(unix_edge_successor(edge));
 }
 
-static bool gc_in_progress;
-
 static void unix_del_edge(struct scm_fp_list *fpl, struct unix_edge *edge)
 {
 	struct unix_vertex *vertex = edge->predecessor->vertex;
 
-	if (!gc_in_progress)
+	if (!fpl->dead)
 		unix_update_graph(unix_edge_successor(edge));
 
 	list_del(&edge->vertex_entry);
@@ -240,7 +238,7 @@ void unix_del_edges(struct scm_fp_list *fpl)
 		unix_del_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
-	if (!gc_in_progress) {
+	if (!fpl->dead) {
 		receiver = fpl->edges[0].successor;
 		receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
 	}
@@ -559,9 +557,12 @@ static void unix_walk_scc_fast(struct sk_buff_head *hitlist)
 	list_replace_init(&unix_visited_vertices, &unix_unvisited_vertices);
 }
 
+static bool gc_in_progress;
+
 static void __unix_gc(struct work_struct *work)
 {
 	struct sk_buff_head hitlist;
+	struct sk_buff *skb;
 
 	spin_lock(&unix_gc_lock);
 
@@ -579,6 +580,11 @@ static void __unix_gc(struct work_struct *work)
 
 	spin_unlock(&unix_gc_lock);
 
+	skb_queue_walk(&hitlist, skb) {
+		if (UNIXCB(skb).fp)
+			UNIXCB(skb).fp->dead = true;
+	}
+
 	__skb_queue_purge(&hitlist);
 skip_gc:
 	WRITE_ONCE(gc_in_progress, false);
-- 
2.30.2


