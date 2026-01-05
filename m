Return-Path: <netdev+bounces-246913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BB5CF2615
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 09:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 062AB30281B2
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D687313520;
	Mon,  5 Jan 2026 08:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wH4A9r1L"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8A22E3E9;
	Mon,  5 Jan 2026 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767601333; cv=none; b=NC57RQ9auSlo4uiCnExxtV4M+gJoMmK5A+Tlr6WH3WbdYqILFmq2NgnRoNpiICfXp5IyQzDqcAyHfLDYTkMx9h0cKqrsN8JAaXCuS2pHF9X3FXYI/L5D0L3s9bzbI/yh6cG/+y6muDC4IM2YxkU37KTghK2g3VGO1G7pkDWEjkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767601333; c=relaxed/simple;
	bh=bD55ltRsoH3ubLcAULmhBIrUO9GkpLMOMpLQ/Cau4m8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LNz6g0V8jrK0i2IBh+UcI17v28wdMXavB2HT6D+yzf5hfv7m6YnLjKWTD6Xt8jijtVm0AEvvJlstWaoHRCQoYzemodE1fZNQqqY+IcPOEfuyWQ7kJQ+Mg+M04QXJHo5Zt/vz41tK6qE/poAVWKLB7zzh3mxs/q4QXr9IiB9NjrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wH4A9r1L; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767601319; bh=lXZuyiPqxgHVa4OJsj5vnpr+LBGAt5DcCj3yHiyEQoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wH4A9r1LK+aYSGQfyZwHi6+q3URFe8D5ty94H74eE4sM720xH4I33z8ajNaEQStc3
	 5roHpeduXj2eaXUcJKFj/QDxH5CHMg8Yi4XeRQt5ybFY7njtpiY9zTrton+CXFF3qn
	 fWfdp/qB8TccWzrS8vOPRaIvfheVCUa73fEIe0M8=
Received: from localhost.localdomain ([61.144.111.35])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 57925034; Mon, 05 Jan 2026 16:21:57 +0800
X-QQ-mid: xmsmtpt1767601317te9acxqp2
Message-ID: <tencent_6FE67BA7BE8376AB038A71ACAD4FF8A90006@qq.com>
X-QQ-XMAILINFO: OIPiZ4jSkGWAR3rmek1NQfj50RkwmECUekHdPWHPKk507wzbluK5Co6bHHMYFY
	 kERosLo8Gtgz61l8Nm/FJlDsX4HS9R5lVhSFVsZgqv1+qDjTgNoHNSpy5lFm4ym8FnR7UbrfFrlz
	 39QSHF+VAvq+u2Sdfl5se80xQ+cDT5ybweyjV6VTGxcSnUnKfSWzMyOlb102mtY55sXdBr8Zn/UJ
	 eLhT+toHXZbajg1LwBiJQvwvAxZdYz3eWAz7yQfwe1sQP86l3UPUGH3eExgB0DsxCD3vil602cR1
	 k4d5EfHpImtZH+xRVmqKf4h/ejh1RduchTBk42PqGAcs6XEAMSFyf6yAIfrwSYIE2lwF++a+RTTJ
	 f0W3m/rT+9VBt8IYizDsTZ9TK03URJm1ZWGeBYuCOIhatqB9S9M7YSzL4sLBvBd6ID3idI5pd9Y1
	 VnHGtOP2Ww8EcFobcIrhxtxDTopwc7JEiirvUlQFFAPdH1Vmu441m9EU+bx+NiXA9uZn4H7QBoKp
	 +Tl+phISV2FpjFVVOPabDlvBW+FKwuMYHg7Q5hLkHYP2RM1EoPRfYZWGsFSsK7Erl89DjySQZZVz
	 xxV3xCP6O9H07rYVNdPAZcVV6n8Cg0uzIb8K64td2NDat87POq5rVfyuSXCceuB0vL1xt2hB+XVz
	 KARwbwFIc7GaAIfD9p9zAbZfM6uXxjzCJVHyAuWVUXwz/WL1cEQ459jz2cNmpj/1PoKrewF5eA/6
	 b5S7isLxKVH1VhO6YdeHQm2aPhpcfMywz5rouaH4UA8hIyurkw8Xo1r6pLzTdL82amK/DN16mYKj
	 Ulo0iaBKdpfHQ30GoTbS1XtcoERBWn4VvO8q7zfzLsMu0xK0HY/PRPs5D9epA38BjNW7FaU5RIcs
	 4zSdlKU9bGRKGYRQJrkEKu8dfxkCM59/8IYX+kUNEDYGEXU0r2WS7agvkqh4c5bPDVq6i/MRneb+
	 DeZIJgn2dD+49kRiz/5KXbsKSxleHl79y8laLiehDBYpPkJ8Jjf1uDM6xfh6LUwW8uZSOCpBrYbX
	 HVD78NQXvBcXGCFTuwh1Pwbi2K541ewM3MrvemRDP7/Ty7zVRy3f5pyjFj80pyxfDFRj8qi7/URb
	 +AY4g44kLES8P/+l8=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: wujing <realwujing@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>,
	Lance Yang <lance.yang@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Qiliang Yuan <yuanql9@chinatelecom.cn>,
	wujing <realwujing@qq.com>
Subject: [PATCH v2 1/1] mm/page_alloc: auto-tune min_free_kbytes on atomic allocation failure
Date: Mon,  5 Jan 2026 16:21:52 +0800
X-OQ-MSGID: <20260105082152.1309853-1-realwujing@qq.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260105081720.1308764-1-realwujing@qq.com>
References: <20260105081720.1308764-1-realwujing@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a mechanism to dynamically increase vm.min_free_kbytes when
critical atomic allocations (GFP_ATOMIC, order-0) fail. This prevents
recurring network packet drops or other atomic failures by proactively
reserving more memory.

The system increases min_free_kbytes by 50% upon failure, capped at 1%
of total RAM. To prevent repeated adjustments during burst traffic, a
10-second debounce window is enforced.

After traffic subsides, min_free_kbytes automatically decays by 5% every
5 minutes. However, decay stops at 1.2x the initial value rather than
returning to baseline. This ensures the system "remembers" previous
pressure patterns and avoids repeated failures under similar load.

Observed failure logs:
[38535641.026406] node 0: slabs: 941, objs: 54656, free: 0
[38535641.037711] node 1: slabs: 349, objs: 22096, free: 272
[38535641.049025] node 1: slabs: 349, objs: 22096, free: 272
[38535642.795972] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535642.805017] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535642.816311] node 0: slabs: 854, objs: 42320, free: 0
[38535642.823066] node 1: slabs: 400, objs: 25360, free: 294
[38535643.070199] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535643.078861] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535643.089719] node 0: slabs: 841, objs: 41824, free: 0
[38535643.096513] node 1: slabs: 393, objs: 24480, free: 272
[38535643.484149] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535643.492831] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
[38535643.503666] node 0: slabs: 898, objs: 43120, free: 159
[38535643.510140] node 1: slabs: 404, objs: 25424, free: 319
[38535644.699224] SLUB: Unable to allocate memory on node -1, gfp=0x480020(GFP_ATOMIC)
[38535644.707911] cache: skbuff_head_cache, object size: 232, buffer size: 256, default order: 2, min order: 0
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
 mm/page_alloc.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c380f063e8b7..2f12d7a9ecbc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -30,6 +30,7 @@
 #include <linux/oom.h>
 #include <linux/topology.h>
 #include <linux/sysctl.h>
+#include <linux/workqueue.h>
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/pagevec.h>
@@ -3975,6 +3976,16 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 	mem_cgroup_show_protected_memory(NULL);
 }
 
+/* Auto-tuning min_free_kbytes on atomic allocation failures (v2) */
+static void decay_min_free_kbytes_workfn(struct work_struct *work);
+static void boost_min_free_kbytes_workfn(struct work_struct *work);
+static DECLARE_WORK(boost_min_free_kbytes_work, boost_min_free_kbytes_workfn);
+static DECLARE_DELAYED_WORK(decay_min_free_kbytes_work, decay_min_free_kbytes_workfn);
+static unsigned long last_boost_jiffies = 0;
+static int initial_min_free_kbytes = 0;
+#define BOOST_DEBOUNCE_MS 10000  /* 10 seconds debounce */
+
+
 void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 {
 	struct va_format vaf;
@@ -4947,6 +4958,17 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		goto retry;
 	}
 fail:
+	/* Auto-tuning: trigger boost if atomic allocation fails */
+	if ((gfp_mask & GFP_ATOMIC) && order == 0) {
+		unsigned long now = jiffies;
+		
+		/* Debounce: only boost once every 10 seconds */
+		if (time_after(now, last_boost_jiffies + msecs_to_jiffies(BOOST_DEBOUNCE_MS))) {
+			last_boost_jiffies = now;
+			schedule_work(&boost_min_free_kbytes_work);
+		}
+	}
+
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
@@ -6526,6 +6548,10 @@ int __meminit init_per_zone_wmark_min(void)
 	refresh_zone_stat_thresholds();
 	setup_per_zone_lowmem_reserve();
 
+	/* Save initial value for auto-tuning decay mechanism */
+	if (initial_min_free_kbytes == 0)
+		initial_min_free_kbytes = min_free_kbytes;
+
 #ifdef CONFIG_NUMA
 	setup_min_unmapped_ratio();
 	setup_min_slab_ratio();
@@ -7682,3 +7708,62 @@ struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int or
 	return page;
 }
 EXPORT_SYMBOL_GPL(alloc_pages_nolock_noprof);
+
+static void boost_min_free_kbytes_workfn(struct work_struct *work)
+{
+	int new_min;
+
+	/* Cap at 1% of total RAM for safety */
+	unsigned long total_kbytes = totalram_pages() << (PAGE_SHIFT - 10);
+	int max_limit = total_kbytes / 100;
+
+	/* Responsive increase: 50% instead of doubling */
+	new_min = min_free_kbytes + (min_free_kbytes / 2);
+
+	if (new_min > max_limit)
+		new_min = max_limit;
+
+	if (new_min > min_free_kbytes) {
+		min_free_kbytes = new_min;
+		/* Update user_min_free_kbytes so it persists through recalculations */
+		if (new_min > user_min_free_kbytes)
+			user_min_free_kbytes = new_min;
+		
+		setup_per_zone_wmarks();
+		
+		/* Schedule decay after 5 minutes */
+		schedule_delayed_work(&decay_min_free_kbytes_work, 
+				      msecs_to_jiffies(300000));
+		
+		pr_info("Auto-tuning: atomic failure, increasing min_free_kbytes to %d\n", 
+			min_free_kbytes);
+	}
+}
+
+static void decay_min_free_kbytes_workfn(struct work_struct *work)
+{
+	int new_min;
+	int decay_floor;
+	
+	/* Decay by 5% */
+	new_min = min_free_kbytes - (min_free_kbytes / 20);
+	
+	/* Don't go below 1.2x initial value (preserve learning effect) */
+	decay_floor = initial_min_free_kbytes + (initial_min_free_kbytes / 5);
+	if (new_min < decay_floor)
+		new_min = decay_floor;
+	
+	if (new_min < min_free_kbytes) {
+		min_free_kbytes = new_min;
+		user_min_free_kbytes = new_min;
+		setup_per_zone_wmarks();
+		
+		/* Schedule next decay if still above floor */
+		if (new_min > decay_floor) {
+			schedule_delayed_work(&decay_min_free_kbytes_work,
+					      msecs_to_jiffies(300000));
+		}
+		
+		pr_info("Auto-tuning: decaying min_free_kbytes to %d\n", min_free_kbytes);
+	}
+}
-- 
2.39.5


