Return-Path: <netdev+bounces-165232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2173A3125F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C4E166FFD
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58C25EFB0;
	Tue, 11 Feb 2025 17:04:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE31FCCE9;
	Tue, 11 Feb 2025 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293497; cv=none; b=DpVQz0MG1YryMayu6943DVxUN3sTiFwicFNopNlmbIH0DkIbZP3hSW7fCD+PiLNkfgRG9FAY0wmkg/s1lJDdGUtW2SGrXaABcLKvZ4F3SrcGjKM6jn6kL1dbBM2KT5LwF/bUNHyGxHtcFjnulim3vIpeaHFAuBcIy7zGcc8XCq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293497; c=relaxed/simple;
	bh=XsNH6eH8ybVKvCt7G6pYO+W7xKqMPqW7ljf0EDTS4F4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvnTAaKVD8Cq7tkYCQ+ZXoNFakxG3vhlOhP5lfxzNxSyNUKM4xmpF23dV1qMCTb5rSFYOgGhfVAXpOBdu3K0jw/w6sijhlpgEJpyj9PxniaDY3S+Y3kt0Gepj4vLNEzUQyKaUaPv4I6BStZQc1FXCaYkDJq4IOEcOMZeTfnoiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ED6C4CEDD;
	Tue, 11 Feb 2025 17:04:55 +0000 (UTC)
Date: Tue, 11 Feb 2025 12:05:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Breno Leitao <leitao@debian.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for
 tcp_cwnd_reduction()
Message-ID: <20250211120500.0b1e571c@gandalf.local.home>
In-Reply-To: <CANn89iLMK5B-9LQtga2HEnEs3rS=ta6eOcxxXB2gCkYYApLM4w@mail.gmail.com>
References: <20250207-cwnd_tracepoint-v1-1-13650f3ca96d@debian.org>
	<CANn89iLMK5B-9LQtga2HEnEs3rS=ta6eOcxxXB2gCkYYApLM4w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 16:19:54 +0100
Eric Dumazet <edumazet@google.com> wrote:

> I can give my +2 on this patch, although I have no way of testing it.

If you want to test this, apply the below patch, enable
CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS, and after you boot up, do the following:

 # modprobe trace_custom_sched
 # cd /sys/kernel/tracing
 # echo 1 > events/custom/tcp_cwnd_reduction_tp/enable

[ do something to trigger it ]

 # cat trace

-- Steve

diff --git a/samples/trace_events/trace_custom_sched.c b/samples/trace_events/trace_custom_sched.c
index dd409b704b35..35b3cfa6e91d 100644
--- a/samples/trace_events/trace_custom_sched.c
+++ b/samples/trace_events/trace_custom_sched.c
@@ -16,6 +16,7 @@
  * from the C file, and not in the custom header file.
  */
 #include <trace/events/sched.h>
+#include <trace/events/tcp.h>
 
 /* Declare CREATE_CUSTOM_TRACE_EVENTS before including custom header */
 #define CREATE_CUSTOM_TRACE_EVENTS
@@ -37,6 +38,7 @@
  */
 static void fct(struct tracepoint *tp, void *priv)
 {
+	trace_custom_event_tcp_cwnd_reduction_tp_update(tp);
 	trace_custom_event_sched_switch_update(tp);
 	trace_custom_event_sched_waking_update(tp);
 }
diff --git a/samples/trace_events/trace_custom_sched.h b/samples/trace_events/trace_custom_sched.h
index 951388334a3f..339957d692c0 100644
--- a/samples/trace_events/trace_custom_sched.h
+++ b/samples/trace_events/trace_custom_sched.h
@@ -74,6 +74,33 @@ TRACE_CUSTOM_EVENT(sched_waking,
 
 	TP_printk("pid=%d prio=%d", __entry->pid, __entry->prio)
 )
+
+struct sock;
+
+TRACE_CUSTOM_EVENT(tcp_cwnd_reduction_tp,
+
+	TP_PROTO(const struct sock *sk, int newly_acked_sacked,
+                int newly_lost, int flag),
+
+	TP_ARGS(sk, newly_acked_sacked, newly_lost, flag),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,		sk	)
+		__field(	int,			ack	)
+		__field(	int,			lost	)
+		__field(	int,			flag	)
+	),
+
+	TP_fast_assign(
+		__entry->sk	= (unsigned long)sk;
+		__entry->ack	= newly_acked_sacked;
+		__entry->lost	= newly_lost;
+		__entry->flag	= flag;
+	),
+
+	TP_printk("sk=%lx ack=%d lost=%d flag=%d", __entry->sk,
+		__entry->ack, __entry->lost, __entry->flag)
+)
 #endif
 /*
  * Just like the headers that create TRACE_EVENTs, the below must

