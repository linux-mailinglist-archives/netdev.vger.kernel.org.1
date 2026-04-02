Return-Path: <netdev+bounces-274767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKDnDpX7zmn7sAYAu9opvQ
	(envelope-from <netdev+bounces-274767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:28:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6FA38F367
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1165830603F4
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F653803CD;
	Thu,  2 Apr 2026 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vv/7uy3k"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1D37266E
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775172380; cv=none; b=r/YBYUVuLl/0GKvD6asiR4YS5Y0wU8KtwgIepKRWet/1ZFHuMH5GwKqIhaM5JjmNSPRqBAZDC1trKk0FUqtISwZXoe+67/tZufS/Z7fnuYg5QJKR+rzra+xeE1cNnZsFn9NbrRh/ZHy9RuxE6Th2j9g1QmQdhKqRDlhwTTDjTqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775172380; c=relaxed/simple;
	bh=eU16QTP3QWyZL67/LIq54z8ZquczNgvOaVIKv3PgbIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8+DkiqCGpJjD2GGedvnIYCL0wqtWlhMey2xkyb/GBYwXntyjQ0RG3hiYQ2+c3BVrXT74D2V13rx5ZXUi6pKk5N3DRDb8X9pBTFozHD8eKnYuBLyn8OgZ5HE0/13q8DXBjMW25muQtV40A8IuQkxFwVlimolzmyYkaQatSEJTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vv/7uy3k; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775172365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PuVAdsykZc8clK+Md88hs1j0p3benQlW+1IQ1dRgBhc=;
	b=vv/7uy3kyRdedWT090Pplu5hGSsiStzXs+T/L5f/qJSRCuzglxLBqIglaTUAqe+G5jJHKY
	ZkMbd7GfykSqPsKz3oY76u8K9kEuvusEecPmL1JnsP+M1yo2SWTZT6ag7tn8v6KR11pJP0
	Z9BoQFvSjsd8o5BFjg/OnfydsI2hsLE=
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
To: linux-mm@kvack.org,
	willy@infradead.org,
	hannes@cmpxchg.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	riel@surriel.com,
	kuba@kernel.org,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] mm/vmpressure: skip socket pressure for costly order reclaim
Date: Thu,  2 Apr 2026 16:25:11 -0700
Message-ID: <20260402232511.17246-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274767-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: BC6FA38F367
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When kswapd reclaims at high order due to fragmentation, vmpressure() can
report poor reclaim efficiency even though the system has plenty of free
memory. This is because kswapd scans many pages but finds little to reclaim
- the pages are actively in use and don't need to be freed. The resulting
scan:reclaim ratio triggers socket pressure, throttling TCP throughput
unnecessarily.

Net allocations do not exceed order 3 (PAGE_ALLOC_COSTLY_ORDER), so high
order reclaim difficulty should not trigger socket pressure. The kernel
already treats this order as the boundary where reclaim is no longer
expected to succeed and compaction may take over.

Make vmpressure() order-aware through an additional parameter sourced from
scan_control at existing call sites. Socket pressure is now only asserted
when order <= PAGE_ALLOC_COSTLY_ORDER.

Memcg reclaim is unaffected since try_to_free_mem_cgroup_pages() always
uses order 0, which passes the filter unconditionally. Similarly,
vmpressure_prio() now passes order 0 internally when calling vmpressure(),
ensuring critical pressure from low reclaim priority is not suppressed by
the order filter.

Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>
---
v2
 - dropped extern specifier from vmpressure decl
 - added comment to explain rationale of adjusted conditional

v1: https://lore.kernel.org/all/20260401203752.643259-1-jp.kobryn@linux.dev/

 include/linux/vmpressure.h |  9 +++++----
 mm/vmpressure.c            | 15 ++++++++++++---
 mm/vmscan.c                |  8 ++++----
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/linux/vmpressure.h b/include/linux/vmpressure.h
index 6a2f51ebbfd35..faecd55224017 100644
--- a/include/linux/vmpressure.h
+++ b/include/linux/vmpressure.h
@@ -30,8 +30,8 @@ struct vmpressure {
 struct mem_cgroup;
 
 #ifdef CONFIG_MEMCG
-extern void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
-		       unsigned long scanned, unsigned long reclaimed);
+void vmpressure(gfp_t gfp, int order, struct mem_cgroup *memcg, bool tree,
+		unsigned long scanned, unsigned long reclaimed);
 extern void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int prio);
 
 extern void vmpressure_init(struct vmpressure *vmpr);
@@ -44,8 +44,9 @@ extern int vmpressure_register_event(struct mem_cgroup *memcg,
 extern void vmpressure_unregister_event(struct mem_cgroup *memcg,
 					struct eventfd_ctx *eventfd);
 #else
-static inline void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
-			      unsigned long scanned, unsigned long reclaimed) {}
+static inline void vmpressure(gfp_t gfp, int order, struct mem_cgroup *memcg,
+			      bool tree, unsigned long scanned,
+			      unsigned long reclaimed) {}
 static inline void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg,
 				   int prio) {}
 #endif /* CONFIG_MEMCG */
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 3fbb86996c4d2..f053554e58264 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -218,6 +218,7 @@ static void vmpressure_work_fn(struct work_struct *work)
 /**
  * vmpressure() - Account memory pressure through scanned/reclaimed ratio
  * @gfp:	reclaimer's gfp mask
+ * @order:	allocation order being reclaimed for
  * @memcg:	cgroup memory controller handle
  * @tree:	legacy subtree mode
  * @scanned:	number of pages scanned
@@ -236,7 +237,7 @@ static void vmpressure_work_fn(struct work_struct *work)
  *
  * This function does not return any value.
  */
-void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
+void vmpressure(gfp_t gfp, int order, struct mem_cgroup *memcg, bool tree,
 		unsigned long scanned, unsigned long reclaimed)
 {
 	struct vmpressure *vmpr;
@@ -307,7 +308,15 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 
 		level = vmpressure_calc_level(scanned, reclaimed);
 
-		if (level > VMPRESSURE_LOW) {
+		/*
+		 * Once we go above COSTLY_ORDER, reclaim relies heavily on
+		 * compaction to make progress. Reclaim efficiency was never a
+		 * great proxy for pressure to begin with, but it's outright
+		 * misleading with these high orders. Don't throttle sockets
+		 * because somebody is attempting something crazy like an order-7
+		 * and predictably struggling.
+		 */
+		if (level > VMPRESSURE_LOW && order <= PAGE_ALLOC_COSTLY_ORDER) {
 			/*
 			 * Let the socket buffer allocator know that
 			 * we are having trouble reclaiming LRU pages.
@@ -348,7 +357,7 @@ void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int prio)
 	 * to the vmpressure() basically means that we signal 'critical'
 	 * level.
 	 */
-	vmpressure(gfp, memcg, true, vmpressure_win, 0);
+	vmpressure(gfp, 0, memcg, true, vmpressure_win, 0);
 }
 
 #define MAX_VMPRESSURE_ARGS_LEN	(strlen("critical") + strlen("hierarchy") + 2)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5a8c8fcccbfc9..1342323a0b41f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5071,8 +5071,8 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
 
 	if (!sc->proactive)
-		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
-			   sc->nr_reclaimed - reclaimed);
+		vmpressure(sc->gfp_mask, sc->order, memcg, false,
+			   sc->nr_scanned - scanned, sc->nr_reclaimed - reclaimed);
 
 	flush_reclaim_state(sc);
 
@@ -6175,7 +6175,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		/* Record the group's reclaim efficiency */
 		if (!sc->proactive)
-			vmpressure(sc->gfp_mask, memcg, false,
+			vmpressure(sc->gfp_mask, sc->order, memcg, false,
 				   sc->nr_scanned - scanned,
 				   sc->nr_reclaimed - reclaimed);
 
@@ -6220,7 +6220,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	/* Record the subtree's reclaim efficiency */
 	if (!sc->proactive)
-		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
+		vmpressure(sc->gfp_mask, sc->order, sc->target_mem_cgroup, true,
 			   sc->nr_scanned - nr_scanned, nr_node_reclaimed);
 
 	if (nr_node_reclaimed)
-- 
2.52.0


