Return-Path: <netdev+bounces-252138-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Fnk/OmGHcWlaIwAAu9opvQ
	(envelope-from <netdev+bounces-252138-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:11:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0848B60BD2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 888C5446676
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED65355046;
	Thu, 22 Jan 2026 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5jPqRxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0734AB06
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769047676; cv=none; b=TrwVkGM2ftqk1JUuPgstHNU3HM9eVmM8wLDFUT0k2emwPVbew0WEmdOAZ4BEWLTuSdwyPSPFuwZVswZlXyFdVFX3U1SW1c3H23NyeJ/GgmBcex8Dt0z1oz2iMb3b7maB+TADJ560dml6aXUizLkGczTUd5+Ya287w+aKpWrDqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769047676; c=relaxed/simple;
	bh=veJ883BXshNbMwe9b2qcWbWT2R5GwwZg36wLGBju1Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFiwvryuysn0lK4ZBA18yOIP1dHXDrH5rJ/WzHYkxsLkRNjvvyrDT3zlUbC2ym2ImMPxN7y3toHWoxGiNQ81V8ibDurA8W3frjTDyZxsEyNdunIG/Vyg1gFOpcJeupW5ddHH9+0vpqdlXreWwu1M99pcGuWAdsUg9QnUiyCxyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5jPqRxJ; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-121a0bcd376so1303725c88.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 18:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769047673; x=1769652473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBQb1uczQpL5GIk29gYfa4oCHjDRy2kNRGngnJTqEfM=;
        b=B5jPqRxJEkAORplOfsx11iCiZS+pN3O8ODaCCbncB4MVc1nlbP2eZw5GqAgvCpFgOA
         +uI7yJjTSGfuUt9CU4XkYGpCTfClAPcmPwhlpNz+qw937Hwd+CbTZQuRWT1qTezYtB6U
         bvWa38U3bt1apTW8MaRz3G0Ui92u+wSXA6DBAmlQMVOcCLeLUVodpGMtzUjnGFhBtRO9
         Oraj1dneISZZ9c0J6uV0Y9+qU1y4Nn85ElCRM67idEo8ezLbXkzOtvph7lOor1ByiMcP
         /murvgmIAeIjTXzxZigfcNrS5FFUO5w3kH9mdPgZJ/SJgBjD5VklF3lHLyn3J+Du2U1f
         gc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769047673; x=1769652473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uBQb1uczQpL5GIk29gYfa4oCHjDRy2kNRGngnJTqEfM=;
        b=XDKGiJ6YljvzcLiNrcAqUM79fRRypj/OLnZeyyoocdYw3XWQVVhvPZ761il2J2wa/a
         /9Y/yFs8NwL0g8ZdZuXP6lU+/hgSi8KDVxhlfVyNxXYQ41IzPokpqIr5wsj6C+mhFW45
         53qOKOB19SqnqK6NSHCHsy/5BuBctqzCKjJJInHn9fHGhBCGaz1DDrHS0xcPqrt5YQKx
         vNAax7VEJ13SBPxbAHFfkNsp8+AeGXWAWaomHdFsXND986CNTVc+z51JznRsGOfQFaj5
         RcErUtYfbON8Z3SQEfQt1jRzP0zzLngdl62RMnweJKTWarEaocBXG0fS2QSYVF96uEvw
         2rww==
X-Forwarded-Encrypted: i=1; AJvYcCVgMr+KOfxaF/akjdO5sQwQL+HqBIp7j1OgGhmaW984aF/FWYZK1t04Sdd5P1SbEljKrFcOna4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwSqq5GnxctYm02sXJnp+He1IIwXXDu5BhLc2Gx6CpHNS+syhY
	MkBgaHCTyILpLmykKJ7BRo5tLUlCElkmV49iPtgz0igKvtjqLrifDAHj/deFNM2KhMM=
X-Gm-Gg: AZuq6aKYTKD56+JjXPcXOsfdYGOyF7ARro8yabkhK+QYT/3y+HdDtvyP5NIrj1D6up2
	39JFNJFMWFPXlKl7xovWwevWR58PEm1GBr3sWR4IZ5vA1OxdyUBYxJ9/c2MBxMrzUoPGWqs8Akv
	PbQeGZk+ZgQXVXDKaA9l/zWAM+5dNpdmgTF8lcIBYFlq4BfJcXXI5x848x6tmBy9J+3VAKD1xtr
	8ZeyzXGv1D+WdUpZldWi5kvpo9xx07xA5j3v0+CUkltrnRN28N5TZxfN+s27wCHddHiB+0AE5eF
	Th/oIXN225E7bSb1PLBU0wulTpmsEo/oNrCY5Q/Q0YdZyctP5sMhJl+cGHN80AnyG4A4/uvTYaB
	dsPPo4HRk6GNBzCc8FNheUEuEhRq2aVVQfIcHlLheORWDrWDWHzKtSer8yQ49YGBQBSztNyD9gb
	ywKfk=
X-Received: by 2002:a05:7022:608b:b0:11b:9386:7ed0 with SMTP id a92af1059eb24-1246aaf0f17mr4977855c88.45.1769047672743;
        Wed, 21 Jan 2026 18:07:52 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6c2de1f29sm21740486eec.15.2026.01.21.18.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 18:07:52 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: akpm@linux-foundation.org
Cc: david@kernel.org,
	mhocko@suse.com,
	vbabka@suse.cz,
	willy@infradead.org,
	lance.yang@linux.dev,
	hannes@cmpxchg.org,
	surenb@google.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	weixugc@google.com,
	rppt@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	jis1@chinatelecom.cn,
	wangh13@chinatelecom.cn,
	liyi1@chinatelecom.cn,
	sunshx@chinatelecom.cn,
	zhangzq20@chinatelecom.cn,
	zhangjn11@chinatelecom.cn,
	Qiliang Yuan <realwujing@gmail.com>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH v6] mm/page_alloc: boost watermarks on atomic allocation failure
Date: Wed, 21 Jan 2026 21:07:42 -0500
Message-ID: <20260122020742.230219-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121125603.47b204cc8fbe9466b25cce16@linux-foundation.org>
References: <20260121125603.47b204cc8fbe9466b25cce16@linux-foundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-252138-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,suse.cz,infradead.org,linux.dev,cmpxchg.org,google.com,nvidia.com,kvack.org,vger.kernel.org,chinatelecom.cn,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 0848B60BD2
X-Rspamd-Action: no action

Atomic allocations (GFP_ATOMIC) are prone to failure under heavy memory
pressure as they cannot enter direct reclaim. This patch introduces a
'Soft Boost' mechanism to mitigate this.

When a GFP_ATOMIC request fails or enters the slowpath, the preferred
zone's watermark_boost is increased. This triggers kswapd to proactively
reclaim memory, creating a safety buffer for future atomic bursts.

To prevent excessive reclaim during packet storms, a 1-second debounce
timer (last_boost_jiffies) is added to each zone to rate-limit boosts.

This approach reuses existing watermark_boost infrastructure, ensuring
minimal overhead and asynchronous background reclaim via kswapd.

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
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

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
index c380f063e8b7..8ea2435125d5 100644
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
@@ -2189,12 +2196,31 @@ static inline bool boost_watermark(struct zone *zone)
 
 	max_boost = max(pageblock_nr_pages, max_boost);
 
-	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
+	zone->watermark_boost = min(zone->watermark_boost +
+		max(pageblock_nr_pages, zone_managed_pages(zone) >> ATOMIC_BOOST_SCALE_SHIFT),
 		max_boost);
 
 	return true;
 }
 
+static void boost_zones_for_atomic(struct alloc_context *ac, gfp_t gfp_mask)
+{
+	struct zoneref *z;
+	struct zone *zone;
+	unsigned long now = jiffies;
+
+	for_each_zone_zonelist(zone, z, ac->zonelist, ac->highest_zoneidx) {
+		/* 1 second debounce to avoid spamming boosts in a burst */
+		if (time_after(now, zone->last_boost_jiffies + HZ)) {
+			zone->last_boost_jiffies = now;
+			if (boost_watermark(zone))
+				wakeup_kswapd(zone, gfp_mask, 0, ac->highest_zoneidx);
+			/* Only boost the preferred zone to be precise */
+			break;
+		}
+	}
+}
+
 /*
  * When we are falling back to another migratetype during allocation, should we
  * try to claim an entire block to satisfy further allocations, instead of
@@ -4742,6 +4768,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (page)
 		goto got_pg;
 
+	/* Proactively boost for atomic requests entering slowpath */
+	if ((gfp_mask & GFP_ATOMIC) && order == 0)
+		boost_zones_for_atomic(ac, gfp_mask);
+
 	/*
 	 * For costly allocations, try direct compaction first, as it's likely
 	 * that we have enough base pages and don't need to reclaim. For non-
@@ -4947,6 +4977,10 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		goto retry;
 	}
 fail:
+	/* Boost watermarks on atomic allocation failure to trigger kswapd */
+	if (unlikely(page == NULL && (gfp_mask & GFP_ATOMIC) && order == 0))
+		boost_zones_for_atomic(ac, gfp_mask);
+
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
-- 
2.51.0


