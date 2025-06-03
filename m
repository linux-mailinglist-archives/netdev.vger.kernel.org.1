Return-Path: <netdev+bounces-194806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34765ACCBC3
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 19:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1B316CFF2
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856E41DF27E;
	Tue,  3 Jun 2025 17:11:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E31DE881;
	Tue,  3 Jun 2025 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970674; cv=none; b=D7FXaIb1/kXKvpNdKR2G8mlq1fhTXTd9RnY6uAKSSaMUWn/HQNFxC8A5pXEPa+J7PX6ggqB4KctoHGtVmch1RKBlZJdQYH5mc6HAW7459l9HaCYuDAlBqKL6ZNVjjfwU08yeyxad/zDVZ5ZzD/zw0S0HKqIFmUEvukRzmaSBI1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970674; c=relaxed/simple;
	bh=lqbYtMtbV3zVzsS0m8EoAwgPYRF7eEhKzLoHcu/5wbQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ldAuEzB+vKwm5y7MRxl3te1pnqp24CvsXXJsROyCASqTJwCRqC0xI/uCUl2by2LIG7eIlhcObCPkXuJIjL8HFAkwmpbtxcuVZh6rmXflc9u1L8/27DWSmN7p6y1EQlMi5ngj85Um48aWJAHBxS3+NpVebxVEfhGAam5HUOtoNTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA078C4CEF4;
	Tue,  3 Jun 2025 17:11:13 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uMVBc-0000000E40Y-3psS;
	Tue, 03 Jun 2025 13:12:28 -0400
Message-ID: <20250603171228.762591654@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 03 Jun 2025 13:11:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 netdev <netdev@vger.kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Subject: [for-linus][PATCH 3/5] xdp: Remove unused mem_return_failed event
References: <20250603171149.582996770@goodmis.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The change to allow page_pool to handle its own page destruction instead
of relying on XDP removed the trace_mem_return_failed() tracepoint caller,
but did not remove the mem_return_failed trace event. As trace events take
up memory when they are created regardless of if they are used or not,
having this unused event around wastes around 5K of memory.

Remove the unused event.

Link: https://lore.kernel.org/all/20250529130138.544ffec4@gandalf.local.home/

Cc: netdev <netdev@vger.kernel.org>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/20250529160550.1f888b15@gandalf.local.home
Fixes: c3f812cea0d7 ("page_pool: do not release pool until inflight == 0.")
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/xdp.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index a7e5452b5d21..d3ef86c97ae3 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -379,32 +379,6 @@ TRACE_EVENT(mem_connect,
 	)
 );
 
-TRACE_EVENT(mem_return_failed,
-
-	TP_PROTO(const struct xdp_mem_info *mem,
-		 const struct page *page),
-
-	TP_ARGS(mem, page),
-
-	TP_STRUCT__entry(
-		__field(const struct page *,	page)
-		__field(u32,		mem_id)
-		__field(u32,		mem_type)
-	),
-
-	TP_fast_assign(
-		__entry->page		= page;
-		__entry->mem_id		= mem->id;
-		__entry->mem_type	= mem->type;
-	),
-
-	TP_printk("mem_id=%d mem_type=%s page=%p",
-		  __entry->mem_id,
-		  __print_symbolic(__entry->mem_type, __MEM_TYPE_SYM_TAB),
-		  __entry->page
-	)
-);
-
 TRACE_EVENT(bpf_xdp_link_attach_failed,
 
 	TP_PROTO(const char *msg),
-- 
2.47.2



