Return-Path: <netdev+bounces-241431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CB783C83F6C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B8347761
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5FA214A8B;
	Tue, 25 Nov 2025 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J2Pf5qPm"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A762D8379
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059076; cv=none; b=FkO4faG45CZ3LCIIKeeEtrhDaV2CwyS+f3d21AbEN4IjEq3e9znuexZ84CnHLadU0ZDOfwG04tV/2EsxbV/riMIss7VUJOfkfjhqJjF90cqM8lynEZrMcTVivh9ir2Mzr6A7FJoNpJXMc32Lh08xWE28/LGTybDFkYM3VW9sLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059076; c=relaxed/simple;
	bh=LLzpqkneb1EniVPD7ARGUrLwj9wBOs51JHhwuqLjXLI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OaWwVvLriTTBfosIFycsg1oo3OPKgJ78eQsv1VZe0zx5UtHNdN8ASNDc47ar6hAyNVbbRH2vryDb+CLEwyBmkaLqc8pUy/phMzg7AEBibH+7wO3lf+dnVxHdUuiw5iTYUHiyz3RCqPZr6wwy7jRlaf1LZNg/mmx1F947uqUom+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J2Pf5qPm; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764059061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UVMKZpiAgjdj1OrjiOCmq9JWsKoWT5hUh7417oGOV5Q=;
	b=J2Pf5qPmhe3Z/feXILv7t76bYUY6p6BkPx+cxzinGjbsFGniRnQWVJURQr1ovbDSOrQc/y
	X0DaQxxX/mEdQpQsFxx6WJzFHc1P8aBujWch0LkGVMm0fS2f6CAT4KEs61aszhY8DzjNbm
	V5xcO2XTERw9MSRe5ZiDkSPpnjEK1J0=
From: Leon Hwang <leon.hwang@linux.dev>
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	lance.yang@linux.dev,
	jiayuan.chen@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Leon Huang Fu <leon.huangfu@shopee.com>
Subject: [RFC PATCH net-next] page_pool: Add page_pool_release_stalled tracepoint
Date: Tue, 25 Nov 2025 16:22:07 +0800
Message-ID: <20251125082207.356075-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce a new tracepoint to track stalled page pool releases,
providing better observability for page pool lifecycle issues.

Problem:
Currently, when a page pool shutdown is stalled due to inflight pages,
the kernel only logs a warning message via pr_warn(). This has several
limitations:

1. The warning floods the kernel log after the initial DEFER_WARN_INTERVAL,
   making it difficult to track the progression of stalled releases
2. There's no structured way to monitor or analyze these events
3. Debugging tools cannot easily capture and correlate stalled pool
   events with other network activity

Solution:
Add a new tracepoint, page_pool_release_stalled, that fires when a page
pool shutdown is stalled. The tracepoint captures:
- pool: pointer to the stalled page_pool
- inflight: number of pages still in flight
- sec: seconds since the release was deferred

The implementation also modifies the logging behavior:
- pr_warn() is only emitted during the first warning interval
  (DEFER_WARN_INTERVAL to DEFER_WARN_INTERVAL*2)
- The tracepoint is fired always, reducing log noise while still
  allowing monitoring tools to track the issue

This allows developers and system administrators to:
- Use tools like perf, ftrace, or eBPF to monitor stalled releases
- Correlate page pool issues with network driver behavior
- Analyze patterns without parsing kernel logs
- Track the progression of inflight page counts over time

Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/trace/events/page_pool.h | 22 ++++++++++++++++++++++
 net/core/page_pool.c             |  6 ++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/page_pool.h b/include/trace/events/page_pool.h
index 31825ed30032..c4205af9bf93 100644
--- a/include/trace/events/page_pool.h
+++ b/include/trace/events/page_pool.h
@@ -113,6 +113,28 @@ TRACE_EVENT(page_pool_update_nid,
 		  __entry->pool, __entry->pool_nid, __entry->new_nid)
 );
 
+TRACE_EVENT(page_pool_release_stalled,
+
+	TP_PROTO(const struct page_pool *pool, int inflight, int sec),
+
+	TP_ARGS(pool, inflight, sec),
+
+	TP_STRUCT__entry(
+		__field(const struct page_pool *, pool)
+		__field(int,			  inflight)
+		__field(int,			  sec)
+	),
+
+	TP_fast_assign(
+		__entry->pool		= pool;
+		__entry->inflight	= inflight;
+		__entry->sec		= sec;
+	),
+
+	TP_printk("page_pool=%p id=%d inflight=%d sec=%d",
+		  __entry->pool, __entry->pool->user.id, __entry->inflight, __entry->sec)
+);
+
 #endif /* _TRACE_PAGE_POOL_H */
 
 /* This part must be outside protection */
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1a5edec485f1..9fd86749c705 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1218,8 +1218,10 @@ static void page_pool_release_retry(struct work_struct *wq)
 	    (!netdev || netdev == NET_PTR_POISON)) {
 		int sec = (s32)((u32)jiffies - (u32)pool->defer_start) / HZ;
 
-		pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
-			__func__, pool->user.id, inflight, sec);
+		if (sec >= DEFER_WARN_INTERVAL / HZ && sec < DEFER_WARN_INTERVAL * 2 / HZ)
+			pr_warn("%s() stalled pool shutdown: id %u, %d inflight %d sec\n",
+				__func__, pool->user.id, inflight, sec);
+		trace_page_pool_release_stalled(pool, inflight, sec);
 		pool->defer_warn = jiffies + DEFER_WARN_INTERVAL;
 	}
 
-- 
2.52.0


