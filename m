Return-Path: <netdev+bounces-252645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8A/KA5MYc2nSsAAAu9opvQ
	(envelope-from <netdev+bounces-252645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:43:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F999711CE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02A3E302C774
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933A033B6D5;
	Fri, 23 Jan 2026 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayVwVzzD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DDD337692
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 06:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150570; cv=none; b=jtN3ZvkHGmgd087sWF2Nsj+d7mUJINrKlF+23afr8P1WrgC2PVMr8DoBgJDkbTiLJmTM8nOD8AT/mq8VUN8Cab47733Nxy4kDZrHKzy3Dw2Gix0CnNZ4SqbWRNHSawtvDAVh9srdppRQlj4VRQAiEml8dwkl4kRRstYSCkTnEZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150570; c=relaxed/simple;
	bh=anSJldvMGDdKtmD4mqjHGwl+/ENgn5/LFgwWaAXUyCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnu0BH7TffQABhusjHDt0rsu8p8ehrwhcgKyjoe+MtiGlCSXyRFmF1rMbEDciy5JWYFZN9FxCjWEzuIg1OsWsDgAiOpXgUkz71W8SZlBAzY8ADlpcJzdPM/W/OgipkLSZ3CoVf8QtBQ7mmmaByegeHgbJYajbACnxrgK0O89X+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayVwVzzD; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1233b953bebso4925215c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769150568; x=1769755368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RurLsspuwixyatIbkQyVE9ShmUOAQwG6MPVdwLrORJU=;
        b=ayVwVzzD7qVwDmhoKZagt5cXSF8ZVt2WMlWAYJbRXRoCZ3nyTkfrGsObSR7ivipIKp
         GiJs5KnV5js20Z2GNJGu10/csDzIsLORzLnHom/zTJgyMcwnMB7d5K3iwsfmz85BDtua
         EeMHe/HK3IdHSkI62LfIsuo/gGuZ7r8FYLtkzyDYZzcKi6ueLE2GadS86orTJnh4H3XA
         9R+iE7QwlCkGy2hHyAKOppwWf/G+skuYd/KFjVYM+NsxiL+JCJgVCgtw79YL571xokSN
         Oy6LUbDXmDnVp/jT+wRT7jxMijcIg+bXPlzIerKYoj3eoiz9UfgEt3d4C/uMA0jHe/X0
         TgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769150568; x=1769755368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RurLsspuwixyatIbkQyVE9ShmUOAQwG6MPVdwLrORJU=;
        b=d8sRwpPQ5lgDul8juw0ssDZQxJBDkRIexUOjEcabaFk4wRdl1z/ee/VjsBXVZOkD8F
         I1v4oTxFVpySYS7Jr4RsEa1flyHrkeZ4DyjHP7/g2ygTj0SejA4uGhs5O3E5bzVSAMID
         AoPrYu2rtCh2a8mW+bGhkL8dpRMRiwewFHb6k5xxpQMU6H6NdDVkYC7nB21XClDm2Js3
         WGuUqeKdbqEoV2YprM0UAVZ39DZWulAAytaiyfM4X0hR9JlikKOGPaZD/aFyuTniKxjB
         ayljNpkhiILVIxiXc0hL+DGlcvK2KFe6wGj5j+mwvw/MpmU5yMnPA+z4IBk/gvp+qqdn
         t5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWdBAfrYT5dM1tiZ5IxHN/mZVhpn+QjD1vGD3400K2y5NatolQy6I6htbyp9KGiS9OGUFjo6R8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Q9VJRgXeM8c+36fg+GrioTfnOiidVFRREns6u1kZzF5/fbLQ
	8isrBtnVraRAQKF64M2NuZDbaU8/NY4vBOpHS34grYJMS1yreRxYqk4T
X-Gm-Gg: AZuq6aICwoXB3u/m3f3D7iw6uFTt/IvLnexjytQUPF8Z/stWsG37eJsc1LZaA+8xEcu
	6BAW8w/fuVaArAdeUvLDXoD9+MAHoFuk9R46d2cIEvVdcLMWE+WlHGsD6iE3dKvYewcCJ7T7hea
	NCXCxNvu9VI3sGSaW0jAhJf96u6zBPCarLxHC4UiIKGNcwUgXYkaOzPXpjrVobS/Na6Y2XyjIVG
	WPCTp6vWb+QfOn7zY/iNzAoAWKU59QvUUnynyMxbEB63Tl82uCL+EgznWg19l1NnnW6VBUH+b+a
	etzQkWQygPKpQSBZLPZbPAgXZ4QUriLHXilbwC1twGPivqxzDeeo3wyKswExcKqA/EfS6hX358s
	uaie13DYEse8y0CLW3XE4sjRpiAQJB6KirqW3wXuYwjBFnx1aB8mSmcMhASTbE5r0I8LcLNpHpS
	wM5O8=
X-Received: by 2002:a05:7022:102:b0:119:e56b:c74b with SMTP id a92af1059eb24-1247dbb463emr967983c88.16.1769150567825;
        Thu, 22 Jan 2026 22:42:47 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247dba0135sm3130527c88.17.2026.01.22.22.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 22:42:47 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: vbabka@suse.cz
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	edumazet@google.com,
	hannes@cmpxchg.org,
	jackmanb@google.com,
	jis1@chinatelecom.cn,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liyi1@chinatelecom.cn,
	mhocko@suse.com,
	netdev@vger.kernel.org,
	realwujing@gmail.com,
	rppt@kernel.org,
	sunshx@chinatelecom.cn,
	surenb@google.com,
	wangh13@chinatelecom.cn,
	weixugc@google.com,
	willy@infradead.org,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn,
	zhangzq20@chinatelecom.cn,
	ziy@nvidia.com
Subject: [PATCH v7] mm/page_alloc: boost watermarks on atomic allocation failure
Date: Fri, 23 Jan 2026 01:42:30 -0500
Message-ID: <20260123064231.250767-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <dfdd0648-a7da-4e8e-8781-cf094da4844f@suse.cz>
References: <dfdd0648-a7da-4e8e-8781-cf094da4844f@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252645-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,google.com,cmpxchg.org,chinatelecom.cn,linux.dev,vger.kernel.org,kvack.org,suse.com,gmail.com,infradead.org,nvidia.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F999711CE
X-Rspamd-Action: no action

Atomic allocations (GFP_ATOMIC) are prone to failure under heavy memory
pressure as they cannot enter direct reclaim. This patch introduces a
watermark boost mechanism to mitigate this issue.

When a GFP_ATOMIC request enters the slowpath, the preferred zone's
watermark_boost is increased under zone->lock protection. This triggers
kswapd to proactively reclaim memory, creating a safety buffer for
future atomic allocations. A 1-second debounce timer prevents excessive
boosts during traffic bursts.

This approach reuses existing watermark_boost infrastructure with
minimal overhead and proper locking to ensure thread safety.

Allocation failure logs:
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

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
v7:
  - Use local variable for boost_amount to improve code readability
  - Add zone->lock protection in boost_zones_for_atomic()
  - Add lockdep assertion in boost_watermark() to prevent locking mistakes
  - Remove redundant boost call at fail label due to 1-second debounce
v6:
  - Replace magic number ">> 10" with ATOMIC_BOOST_SCALE_SHIFT define
  - Add documentation explaining 0.1% zone size boost rationale
v5:
  - Simplify to use native boost_watermark() instead of custom logic
v4:
  - Add watermark_scale_boost and gradual decay via balance_pgdat
v3:
  - Move debounce timer to per-zone; optimize zone selection
v2:
  - Add debounce logic and zone-proportional boosting
v1:
  - Initial: boost min_free_kbytes on GFP_ATOMIC failure

 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 46 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 75ef7c9f9307..8e37e4e6765b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -882,6 +882,7 @@ struct zone {
 	/* zone watermarks, access with *_wmark_pages(zone) macros */
 	unsigned long _watermark[NR_WMARK];
 	unsigned long watermark_boost;
+	unsigned long last_boost_jiffies;
 
 	unsigned long nr_reserved_highatomic;
 	unsigned long nr_free_highatomic;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c380f063e8b7..94168571cc38 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -218,6 +218,13 @@ unsigned int pageblock_order __read_mostly;
 static void __free_pages_ok(struct page *page, unsigned int order,
 			    fpi_t fpi_flags);
 
+/*
+ * Boost watermarks by ~0.1% of zone size on atomic allocation pressure.
+ * This provides zone-proportional safety buffers: ~1MB per 1GB of zone size.
+ * Larger zones under GFP_ATOMIC pressure need proportionally larger reserves.
+ */
+#define ATOMIC_BOOST_SCALE_SHIFT 10
+
 /*
  * results with 256, 32 in the lowmem_reserve sysctl:
  *	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
@@ -2161,6 +2168,9 @@ bool pageblock_unisolate_and_move_free_pages(struct zone *zone, struct page *pag
 static inline bool boost_watermark(struct zone *zone)
 {
 	unsigned long max_boost;
+	unsigned long boost_amount;
+
+	lockdep_assert_held(&zone->lock);
 
 	if (!watermark_boost_factor)
 		return false;
@@ -2189,12 +2199,40 @@ static inline bool boost_watermark(struct zone *zone)
 
 	max_boost = max(pageblock_nr_pages, max_boost);
 
-	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
-		max_boost);
+	boost_amount = max(pageblock_nr_pages,
+			   zone_managed_pages(zone) >> ATOMIC_BOOST_SCALE_SHIFT);
+	zone->watermark_boost = min(zone->watermark_boost + boost_amount,
+				    max_boost);
 
 	return true;
 }
 
+static void boost_zones_for_atomic(struct alloc_context *ac, gfp_t gfp_mask)
+{
+	struct zoneref *z;
+	struct zone *zone;
+	unsigned long now = jiffies;
+	bool should_wake;
+
+	for_each_zone_zonelist(zone, z, ac->zonelist, ac->highest_zoneidx) {
+		/* Rate-limit boosts to once per second per zone */
+		if (time_after(now, zone->last_boost_jiffies + HZ)) {
+			zone->last_boost_jiffies = now;
+
+			/* Modify watermark under lock, wake kswapd outside */
+			spin_lock(&zone->lock);
+			should_wake = boost_watermark(zone);
+			spin_unlock(&zone->lock);
+
+			if (should_wake)
+				wakeup_kswapd(zone, gfp_mask, 0, ac->highest_zoneidx);
+
+			/* Boost only the preferred zone */
+			break;
+		}
+	}
+}
+
 /*
  * When we are falling back to another migratetype during allocation, should we
  * try to claim an entire block to satisfy further allocations, instead of
@@ -4742,6 +4780,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (page)
 		goto got_pg;
 
+	/* Boost watermarks for atomic requests entering slowpath */
+	if ((gfp_mask & GFP_ATOMIC) && order == 0)
+		boost_zones_for_atomic(ac, gfp_mask);
+
 	/*
 	 * For costly allocations, try direct compaction first, as it's likely
 	 * that we have enough base pages and don't need to reclaim. For non-
-- 
2.51.0


