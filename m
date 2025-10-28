Return-Path: <netdev+bounces-233501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DACCC147D7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 13:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEF45E46B7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0762A31961B;
	Tue, 28 Oct 2025 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUgj8yP0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F531960D;
	Tue, 28 Oct 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652699; cv=none; b=o6D5rpgk7HbREGBNv54gmEUOajQqRjLZUfBWgHHKfn0Etc7QYTEDYcSbNfXb3UHN9DvCNlqTPF6ejvhdR/6iFqB6J31GKn1nddVhb80/fQkZNknlqN1LFOq3VNoM1NzBkKDPsGf/pev9NtAHmrjgYGi8AqWdWAX57jNMTZ17O1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652699; c=relaxed/simple;
	bh=qGYs0DLzW08coKCc8jkFrJyAxhu+Nf/cV/UOBJyzkN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJADO93iq4nYTQYpmmznJH2PRzGPajbaMhfK37w65JDkmq6DUZ5p3FKL2gEXE36xGX4o1ZzkW3WgQrMqj37ar+jh2eenNjPTbb1zguoWDrJc12Ou04vjxDZ81wd66saK181SjKPsGMvAap2/q1TRpSWotohg9Hy1nKbZPmiiSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUgj8yP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628A4C4CEE7;
	Tue, 28 Oct 2025 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761652699;
	bh=qGYs0DLzW08coKCc8jkFrJyAxhu+Nf/cV/UOBJyzkN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MUgj8yP0ESwX62sPUlJnZpYSqp1/Ih36ePZ01jMxGmS6EG3o1ef8rb+s2EoFfoqRd
	 GOl3Nn9ktJKWvsNOylaQJNbDS9blnQQTHXK+dwcZaX5rUkbK0FM21z/Sgg+61dp5dx
	 glz9wJtVwAm1P++cevqERdLYyDpuvqWz2pWpn32gZqWPDXuA15RpabWjN6HvrcKpgf
	 /wexZEL6CqmbUj7XHZ/iTl2okvf5lb4YTQhCVYoKYGdyVEOITSwfMnW/x4NW9f0iGX
	 EEfEX1UEKyBLWmVASYPlSyD7FDZnUAHulJ7mmUle0VQHvJA4s61HFPgiXm0mQO1vWX
	 mz7zyKpzZWC/g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 Oct 2025 12:58:00 +0100
Subject: [PATCH net v3 2/4] trace: tcp: add three metrics to
 trace_tcp_rcvbuf_grow()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-net-tcp-recv-autotune-v3-2-74b43ba4c84c@kernel.org>
References: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
In-Reply-To: <20251028-net-tcp-recv-autotune-v3-0-74b43ba4c84c@kernel.org>
To: Eric Dumazet <edumazet@google.com>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 mptcp@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3122; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FKVsH/2wDJdmfPbL8tB+fxeV7oTsmdA5vp27hpF0BUE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIZ1p/3izRN77R4K/Nhc6tPq3qFl8XfN+vWbeGQa3+su
 sAy18O5o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCKfXjMyfGg/43dANe180/Y5
 kav/mC2oVC4Rzl9wQ+eg3TTZ0DPdJQz/9KZtZ7jbln7AtTqkTO6YaorgiqsbxZScQxSXCy4R7T3
 LCgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Eric Dumazet <edumazet@google.com>

While chasing yet another receive autotuning bug,
I found useful to add rcv_ssthresh, window_clamp and rcv_wnd.

tcp_stream 40597 [068]  2172.978198: tcp:tcp_rcvbuf_grow: time=50307 rtt_us=50179 copied=77824 inq=0 space=40960 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=107474 window_clamp=112128 rcv_wnd=110592
tcp_stream 40597 [068]  2173.028528: tcp:tcp_rcvbuf_grow: time=50336 rtt_us=50206 copied=110592 inq=0 space=77824 ooo=0 scaling_ratio=219 rcvbuf=509444 rcv_ssthresh=328658 window_clamp=435813 rcv_wnd=331776
tcp_stream 40597 [068]  2173.078830: tcp:tcp_rcvbuf_grow: time=50305 rtt_us=50070 copied=270336 inq=0 space=110592 ooo=0 scaling_ratio=219 rcvbuf=509444 rcv_ssthresh=431159 window_clamp=435813 rcv_wnd=434176
tcp_stream 40597 [068]  2173.129137: tcp:tcp_rcvbuf_grow: time=50313 rtt_us=50118 copied=434176 inq=0 space=270336 ooo=0 scaling_ratio=219 rcvbuf=2457847 rcv_ssthresh=1299511 window_clamp=2102611 rcv_wnd=1302528
tcp_stream 40597 [068]  2173.179451: tcp:tcp_rcvbuf_grow: time=50318 rtt_us=50041 copied=1019904 inq=0 space=434176 ooo=0 scaling_ratio=219 rcvbuf=2457847 rcv_ssthresh=2087445 window_clamp=2102611 rcv_wnd=2088960

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org
---
 include/trace/events/tcp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 9d2c36c6a0ed..6757233bd064 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -218,6 +218,9 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 		__field(__u32, space)
 		__field(__u32, ooo_space)
 		__field(__u32, rcvbuf)
+		__field(__u32, rcv_ssthresh)
+		__field(__u32, window_clamp)
+		__field(__u32, rcv_wnd)
 		__field(__u8, scaling_ratio)
 		__field(__u16, sport)
 		__field(__u16, dport)
@@ -245,6 +248,9 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 				     tp->rcv_nxt;
 
 		__entry->rcvbuf = sk->sk_rcvbuf;
+		__entry->rcv_ssthresh = tp->rcv_ssthresh;
+		__entry->window_clamp = tp->window_clamp;
+		__entry->rcv_wnd = tp->rcv_wnd;
 		__entry->scaling_ratio = tp->scaling_ratio;
 		__entry->sport = ntohs(inet->inet_sport);
 		__entry->dport = ntohs(inet->inet_dport);
@@ -264,11 +270,14 @@ TRACE_EVENT(tcp_rcvbuf_grow,
 	),
 
 	TP_printk("time=%u rtt_us=%u copied=%u inq=%u space=%u ooo=%u scaling_ratio=%u rcvbuf=%u "
+		  "rcv_ssthresh=%u window_clamp=%u rcv_wnd=%u "
 		  "family=%s sport=%hu dport=%hu saddr=%pI4 daddr=%pI4 "
 		  "saddrv6=%pI6c daddrv6=%pI6c skaddr=%p sock_cookie=%llx",
 		  __entry->time, __entry->rtt_us, __entry->copied,
 		  __entry->inq, __entry->space, __entry->ooo_space,
 		  __entry->scaling_ratio, __entry->rcvbuf,
+		  __entry->rcv_ssthresh, __entry->window_clamp,
+		  __entry->rcv_wnd,
 		  show_family_name(__entry->family),
 		  __entry->sport, __entry->dport,
 		  __entry->saddr, __entry->daddr,

-- 
2.51.0


