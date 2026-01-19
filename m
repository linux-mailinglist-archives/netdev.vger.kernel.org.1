Return-Path: <netdev+bounces-251040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D56B2D3A4E9
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 11:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAA94302D884
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776002FF66A;
	Mon, 19 Jan 2026 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lwLVVrYW"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6E336EFE
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818277; cv=none; b=c+JzrflEt6XA2Cexm4BDP8rxz9a4RNgGVYqosKACRZ/M3ixIJ6UcqmSf79QmOv1fZVk3FTgfgFoWH5U8+j8Qw4A1I1R+ekTSewjVn22CdixmMpawN9aNZHCxIc/Q92lK3mIUzvL6K6ogwV6gAKG6zRt5ClZXXb5KN15J7A5AMxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818277; c=relaxed/simple;
	bh=GQFcCgB9R8zm685nHCYu33zEwGKEBFqhbL7sxn4dsY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mDbuWmjXRutpmOWwCZYOmT+ZAHKVQ5q4UxYOF/t4X+WMtRILUTsOwnWeeaGfqYCQPStbhfFzDVtgCCmf0LCNY8hEM1Lxi8XwdzdSHpX4PmrrlN2FxdA/qKLKUD1zE7xfjUZ96Kjx167sQaQbl3l+I/3rdacRc1FmrbUI+ayS68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lwLVVrYW; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768818262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WKbhwHETp9lQVp4X1qT343o8DBHuZUjbE2HkDCgnbz0=;
	b=lwLVVrYWS8wYW2NcNkFcCGIkE39tSlTWlPHtjkFRQxCTNoiZenYIS9X0dybG0p8IQTRprJ
	euxXzI6inQ7FcdD2ty0qptWdnUmWouzm0ZpQ64z4RWMkEiktpjSKVxYkr66zkvCnFOgMuS
	c+PzUTqlJ0e1ViZ8tCdm7+4YknmnLrs=
From: Leon Hwang <leon.hwang@linux.dev>
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	kerneljasonxing@gmail.com,
	lance.yang@linux.dev,
	jiayuan.chen@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Leon Huang Fu <leon.huangfu@shopee.com>
Subject: [PATCH net-next v4] page_pool: Add page_pool_release_stalled tracepoint
Date: Mon, 19 Jan 2026 18:21:19 +0800
Message-ID: <20260119102119.176211-1-leon.hwang@linux.dev>
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

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v3 -> v4:
 - Collect Reviewed-by from Steven, thanks.
 - Collect Acked-by from Jesper, thanks.
 - https://lore.kernel.org/netdev/20260102071745.291969-1-leon.hwang@linux.dev/

v2 -> v3:
 - Print id using '%u'.
 - https://lore.kernel.org/netdev/20260102061718.210248-1-leon.hwang@linux.dev/

v1 -> v2:
 - Drop RFC.
 - Store 'pool->user.id' to '__entry->id' (per Steven Rostedt).
 - https://lore.kernel.org/netdev/20251125082207.356075-1-leon.hwang@linux.dev/
---
 include/trace/events/page_pool.h | 24 ++++++++++++++++++++++++
 net/core/page_pool.c             |  6 ++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/page_pool.h b/include/trace/events/page_pool.h
index 31825ed30032..a851e0f6a384 100644
--- a/include/trace/events/page_pool.h
+++ b/include/trace/events/page_pool.h
@@ -113,6 +113,30 @@ TRACE_EVENT(page_pool_update_nid,
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
+		__field(u32,			  id)
+		__field(int,			  inflight)
+		__field(int,			  sec)
+	),
+
+	TP_fast_assign(
+		__entry->pool		= pool;
+		__entry->id		= pool->user.id;
+		__entry->inflight	= inflight;
+		__entry->sec		= sec;
+	),
+
+	TP_printk("page_pool=%p id=%u inflight=%d sec=%d",
+		  __entry->pool, __entry->id, __entry->inflight, __entry->sec)
+);
+
 #endif /* _TRACE_PAGE_POOL_H */
 
 /* This part must be outside protection */
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 265a729431bb..01564aa84c89 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1222,8 +1222,10 @@ static void page_pool_release_retry(struct work_struct *wq)
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


