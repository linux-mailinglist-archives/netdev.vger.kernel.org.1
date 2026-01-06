Return-Path: <netdev+bounces-247313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD82CF6E0F
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 07:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A27D3013E9F
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 06:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F49F274B48;
	Tue,  6 Jan 2026 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="b0Lv9T0F"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0563A1E9F;
	Tue,  6 Jan 2026 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767680410; cv=none; b=Olpjd6CmPX7n7EYz4UiRI+lrpfQBCiWoinVj9D0yIhHkJGum8OTEr6ge8DIUZ0LJAJW+clEP9YVUUqEdHvdGpHf5kFIZ6BXOMTfu164k+zGWg735+le4wcUGPwmgD0Yi9XyL1E4w026TIfsKAfFCZ9rtKJJuilzyIiu5SsaVCM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767680410; c=relaxed/simple;
	bh=+l93NjZ2rKXQls+vWEP5rLvaQXWr9yQyEBqoWKVUjTw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=HVj+c0wXqNyTg6aJrAlKiwdo6WzJMfoqTz8QeJB05jGqsn1CAGa0yiULd9VvmEFLjr/9ZMPLWjQ6bKv+ECjTX7yJRbK+am4TN4SfcxWWz7PTbZlubqNSdjmyNCbhyzdySJwt5tbL/kJ/RWbrGVkK4GajkdZ6G/qjqDwrhRT4Abo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=b0Lv9T0F; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767680401; bh=UFSN+SdCs/qhH1mWp1W8skDGAS1NgxyCffI3h2S0VGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b0Lv9T0Fmd5M0HeyZfFRH7n+orwc8criBnJXHCtDs/skJs1jt6RdBU3vZgQei3C33
	 7/l9n8ESJcit8z3jedleejNqTo1tRhmcUGig6/dHvMB2y2c6M5OYC3zDGEIp3axnsj
	 ABvoMvQqqyv7xNvbAbIINEly7/F4GjN/I0nyeda4=
Received: from localhost.localdomain ([61.144.111.35])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 4FA1EED5; Tue, 06 Jan 2026 14:19:58 +0800
X-QQ-mid: xmsmtpt1767680398t5ye8pvf8
Message-ID: <tencent_D23BFCB69EA088C55AFAF89F926036743E0A@qq.com>
X-QQ-XMAILINFO: NU1WwRH9AHfm7TOlxfRiKreig6ZSDjwrNmcEADPbn7zOLp/TKopybhBXKK0J+U
	 bMo3BTx4UUVXUVnTAfnkG7Yc9d30IRD9XSC3jscZ1kD6taHi/0RBuiaVX+x2IDfTUoBP9SG4uHEf
	 wEqc6i0zORQy5lrLCi2r6D5vKz+kFVwKgd+ATiNvnS4eyW8HpLW3QCfSxxxlrGmMRS+/3mZwIISb
	 sqCPfvX7JhyBSyub5e2J42AemqaFjpN3qI2Df/cTc8g04pTcNE+q0+eVB/L+GDRLiSSd2lB+LBrP
	 6/OLCxh8ePZ4mlLvOxXew89eB/iK1m5D5+fwZqbC7NGqhGMDG4Xl6EFFeRBrsRnHvRleVeQRlqfZ
	 EBwJsZvDr27lf+kwg2LkFMpj7OhkHic1209ChF+3KRSo9Tey4Vwu5bdYS/1xHjl5quke9jthSYRa
	 qsxrSVda5ZdERns5DUZ91S7bOb6/qDe2ZQcFElnlig6OVGfstnlkGIS9liyiqlEA8b1pjWgPIkxd
	 TVlEd6ECfzX2Iu7J5yB+PtriSfKS1EOnH5HStHBCyuAZmqXU7Bysr2MlCj8SOjbttj/dkcrH/NdR
	 4KAivzRgxOMizIcGcJL4Hsd/uWws3Qt7Z9afoQeHTvNteZpDSqhrOnICazmc4ZtMDvxuCESyKmn+
	 TUmb03sDrDr9+Y7FcrgUqNmY9Q2sEtnjNihyKENpUwtuvhnZXIwzy86brGC8eEeiqkEZWCyT6Gyb
	 itkBL3FxVS3SQTHek3pqpu62S8W+51nmDKx1kbOLowf7RjTzv2JOthdKZHUZO2tqrUjP2MDzwk9h
	 zfgon7tmLgNPMy1W06fxGVQ8tEIwdiDt3cPTbC+g9cp5mw6fR378aad6/0eZ5AYWAWQFTT3Y1gme
	 tqbLdFtMtSq79NIhxSQ9ZbWquRu7ykapl5UPcSHZoOeJqGJUhPFgorvPVb3H1a05OWDFylbMhRYe
	 El09ph7hRJkDQVjSitXxCPPHET/AYYDuac1B3G/mRuBbC0y1NJez9OjWv5nLKyanZ9vz3lh3YdXJ
	 Xi0Gh8hOHCp8FOV8klY/GkliHhFh10fmcuKR8K0w==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: wujing <realwujing@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lance Yang <lance.yang@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <jackmanb@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wujing <realwujing@qq.com>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH v4 1/1] mm/page_alloc: auto-tune watermarks on atomic allocation failure
Date: Tue,  6 Jan 2026 14:19:50 +0800
X-OQ-MSGID: <20260106061950.1498914-2-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260106061950.1498914-1-realwujing@qq.com>
References: <20260106061950.1498914-1-realwujing@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During high-concurrency network traffic bursts, GFP_ATOMIC order-0
allocations can fail due to rapid exhaustion of the atomic reserve.
The current kernel lacks a reactive mechanism to refill these
reserves quickly enough to prevent packet drops and performance
degradation.

This patch introduces a multi-tier, reactive auto-tuning mechanism
using the watermark_boost infrastructure with the following
optimizations for robustness and horizontal precision:

1. Per-Zone Debounce: Move the boost debounce timer from a global
   variable to struct zone. This ensures that memory pressure is handled
   independently per node/zone, preventing one node from inadvertently
   stifling the response of another.

2. Scaled Boosting Strength: Replace the fixed pageblock_nr_pages
   increment with a dynamic value scaled by zone_managed_pages (approx.
   0.1%). This ensures sufficient reclaim pressure on large-memory
   systems where a single pageblock might be insufficient.

3. Precision Path: Optimize the slowpath failure logic to only boost
   the candidate zones that are actually under pressure, avoiding
   unnecessary reclaim overhead on distant or unrelated nodes.

4. Proactive Soft-Boosting: Trigger a smaller, half-strength (pageblock >> 1)
   boost when an atomic request enters the slowpath but has not yet failed.
   This proactive approach aims to prevent the reserve exhaustion before
   it leads to allocation failure.

5. Hybrid Tuning & Gradual Decay: Introduce watermark_scale_boost in
   struct zone. When failure occurs, we not only boost the watermark level
   but also temporarily increase the watermark_scale_factor. To ensure
   stability, the scale boost is decayed gradually (-5 per kswapd cycle)
   in balance_pgdat() rather than reset instantly, with watermarks
   recalculated at each step via setup_per_zone_wmarks().

Additionally, the patch implements a strict (gfp_mask & GFP_ATOMIC) ==
GFP_ATOMIC check to ensure that only true mission-critical atomic
requests trigger the tuning, excluding less sensitive non-blocking
allocations.

Together, these changes provide a robust, scalable, and precise
defense-in-depth for critical atomic allocations.

Observed failure logs:
[38535644.718700] node 0: slabs: 1031, objs: 43328, free: 0
[38535644.725059] node 1: slabs: 339, objs: 17616, free: 317
[38535645.428345] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535645.436888] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535645.447664] node 0: slabs: 940, objs: 40864, free: 144
[38535645.454026] node 1: slabs: 322, objs: 19168, free: 383
[38535645.556122] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535645.564576] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535649.655523] warn_alloc: 59 callbacks suppressed
[38535649.655527] swapper/100: page allocation failure: order:0, mode:0x480020(GFP_ATOMIC), nodemask=(null)
[38535649.671692] swapper/100 cpuset=/ mems_allowed=0-1

Signed-off-by: wujing <realwujing@qq.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 55 +++++++++++++++++++++++++++++++++++++++---
 mm/vmscan.c            | 10 ++++++++
 3 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 75ef7c9f9307..4d06b041f318 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -882,6 +882,8 @@ struct zone {
 	/* zone watermarks, access with *_wmark_pages(zone) macros */
 	unsigned long _watermark[NR_WMARK];
 	unsigned long watermark_boost;
+	unsigned long last_boost_jiffies;
+	unsigned int watermark_scale_boost;
 
 	unsigned long nr_reserved_highatomic;
 	unsigned long nr_free_highatomic;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c380f063e8b7..4a8243abfb17 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -217,6 +217,7 @@ unsigned int pageblock_order __read_mostly;
 
 static void __free_pages_ok(struct page *page, unsigned int order,
 			    fpi_t fpi_flags);
+static void __setup_per_zone_wmarks(void);
 
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
@@ -2189,7 +2190,7 @@ static inline bool boost_watermark(struct zone *zone)
 
 	max_boost = max(pageblock_nr_pages, max_boost);
 
-	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
+	zone->watermark_boost = min(zone->watermark_boost + max(pageblock_nr_pages, zone_managed_pages(zone) >> 10),
 		max_boost);
 
 	return true;
@@ -3975,6 +3976,9 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 	mem_cgroup_show_protected_memory(NULL);
 }
 
+/* Auto-tuning watermarks on atomic allocation failures */
+#define BOOST_DEBOUNCE_MS 10000  /* 10 seconds debounce */
+
 void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -4742,6 +4746,27 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (page)
 		goto got_pg;
 
+	/* Proactively boost watermarks when atomic request enters slowpath */
+	if (((gfp_mask & GFP_ATOMIC) == GFP_ATOMIC) && order == 0) {
+		struct zoneref *z;
+		struct zone *zone;
+
+		for_each_zone_zonelist(zone, z, ac->zonelist, ac->highest_zoneidx) {
+			if (time_after(jiffies, zone->last_boost_jiffies + msecs_to_jiffies(BOOST_DEBOUNCE_MS))) {
+				zone->last_boost_jiffies = jiffies;
+				/* Smaller boost than the failure path */
+				zone->watermark_boost = min(zone->watermark_boost + (pageblock_nr_pages >> 1),
+					high_wmark_pages(zone) >> 1);
+				wakeup_kswapd(zone, gfp_mask, 0, ac->highest_zoneidx);
+				/*
+				 * Precision: only boost the preferred zone(s) to avoid 
+				 * overallocation across all nodes if one is sufficient.
+				 */
+				break;
+			}
+		}
+	}
+
 	/*
 	 * For costly allocations, try direct compaction first, as it's likely
 	 * that we have enough base pages and don't need to reclaim. For non-
@@ -4947,6 +4972,30 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		goto retry;
 	}
 fail:
+	/* Auto-tuning: boost watermarks on atomic allocation failure */
+	if (((gfp_mask & GFP_ATOMIC) == GFP_ATOMIC) && order == 0) {
+		unsigned long now = jiffies;
+		struct zoneref *z;
+		struct zone *zone;
+
+		for_each_zone_zonelist(zone, z, ac->zonelist, ac->highest_zoneidx) {
+			if (time_after(now, zone->last_boost_jiffies + msecs_to_jiffies(BOOST_DEBOUNCE_MS))) {
+				zone->last_boost_jiffies = now;
+				if (boost_watermark(zone)) {
+					/* Temporarily increase scale factor to accelerate reclaim */
+					zone->watermark_scale_boost = min(zone->watermark_scale_boost + 5, 100U);
+					__setup_per_zone_wmarks();
+					wakeup_kswapd(zone, gfp_mask, 0, ac->highest_zoneidx);
+				}
+				/*
+				 * Precision: only boost the preferred zone(s) to avoid 
+				 * overallocation across all nodes if one is sufficient.
+				 */
+				break; 
+			}
+		}
+	}
+
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
@@ -6296,6 +6345,7 @@ void __init page_alloc_init_cpuhp(void)
  * calculate_totalreserve_pages - called when sysctl_lowmem_reserve_ratio
  *	or min_free_kbytes changes.
  */
+static void __setup_per_zone_wmarks(void);
 static void calculate_totalreserve_pages(void)
 {
 	struct pglist_data *pgdat;
@@ -6440,9 +6490,8 @@ static void __setup_per_zone_wmarks(void)
 		 */
 		tmp = max_t(u64, tmp >> 2,
 			    mult_frac(zone_managed_pages(zone),
-				      watermark_scale_factor, 10000));
+				      watermark_scale_factor + zone->watermark_scale_boost, 10000));
 
-		zone->watermark_boost = 0;
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_HIGH] = low_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_PROMO] = high_wmark_pages(zone) + tmp;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 670fe9fae5ba..7fca44bdbfe5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7143,6 +7143,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	/* If reclaim was boosted, account for the reclaim done in this pass */
 	if (boosted) {
 		unsigned long flags;
+		bool scale_decayed = false;
 
 		for (i = 0; i <= highest_zoneidx; i++) {
 			if (!zone_boosts[i])
@@ -7152,9 +7153,18 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 			zone = pgdat->node_zones + i;
 			spin_lock_irqsave(&zone->lock, flags);
 			zone->watermark_boost -= min(zone->watermark_boost, zone_boosts[i]);
+			/* Decay scale boost gradually after kswapd completes work */
+			if (zone->watermark_scale_boost) {
+				zone->watermark_scale_boost = (zone->watermark_scale_boost > 5) ?
+								(zone->watermark_scale_boost - 5) : 0;
+				scale_decayed = true;
+			}
 			spin_unlock_irqrestore(&zone->lock, flags);
 		}
 
+		if (scale_decayed)
+			setup_per_zone_wmarks();
+
 		/*
 		 * As there is now likely space, wakeup kcompact to defragment
 		 * pageblocks.
-- 
2.39.5


