Return-Path: <netdev+bounces-233094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E533C0C289
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 08:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C693A9A6D
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA72E03EE;
	Mon, 27 Oct 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sao7PeIa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB892DF700
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550696; cv=none; b=JWfIqRVAoQ7SgMtH+mW+YY6QkFqrjHDwX4b7PsASYv5E5+E6jcEWSl4FOcPPlVaCshguWKTY/dBLhKf0CmZFKzeWnLV640O0rOoL7R6rApL+l/ns+t06QAaPF7/5xOaCuFWM9qVmUGvNbPGL/KCk6e7lsO15WdgKS3Jg6g2Q7YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550696; c=relaxed/simple;
	bh=HYeNLajkD+lS/7fLxxyM+Uku76cK7IqcHQNsW9OVm0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VBjDp/ctoVfQ1BiLf0DLRVkr1OsLisC7z2hhkq467W8pZKVsjui5SR2pvGiGOQrylUQk1UoebQ8vwQgW1MtPYzkI7MJ6TWMO/+jsCzvUeLl6nyotpNFH0tWtlsiW0tboUoteIZWxk5AiR7ElnqTUQlTY3L6eG8CaAZTSvPEdYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sao7PeIa; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-78f2b1bacfcso100980866d6.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 00:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761550693; x=1762155493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uh6V4ej3tUSQu9dfieVhc8CIMklXd4yFOnTxayFJ/qQ=;
        b=Sao7PeIabR/qAdZYsvTwuT7yxemdj2GaqgHMdh4VSLxbtuMWrh6e/IWX0bJS7GECJ8
         bDAMY8avc1pTvZZGb9y6XBwKb64B5Tm06jfHTwJiIlk+5T8AnCa0Ip22JlwO+CQSPZ8e
         DB17wFOqIMvZZYeJhWhVSfNqVDK2Nua5KEMobM2+QcoHqz8B37VBIkRydU5cTmuyw2tF
         E6gJKwDy4o73EtcsDR7iJMwx9Gnv5cJfXFsFjgY4M8eSNfGMzXw5Cpalh7sLOynyJsjn
         9+kSP9Bmcf/yxAEVZFxuVt0SeeLjJsjJxwLDkG+RIwmGiAyfi71zTUqobWddKXGJml8z
         ZrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550693; x=1762155493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uh6V4ej3tUSQu9dfieVhc8CIMklXd4yFOnTxayFJ/qQ=;
        b=jHypwI2MCNO5UrRYHq4gNrzImZxRsenWbSh9xZAhXucnN9Ztyip8MZ5K2+4ul4EsSA
         xmK96qLpr57ldQHX7f6ofAlZJZGf9n+NBgYP8iw1OyNz0+qc4qZxrdPjjuOtz7oL2+sx
         RyGIicOrDlsV7XLNWBLpXfV+2fXcMgA27kQUiFd74ZKNr3+8WAe0uk/ztfwR0unYSCeP
         RISN/efwVWOHvb0SSzFhib5FYuoYqWXrsJpwzjCdO3Trf3l+KpTMWwWclU7W3kebEMpj
         xsWXr4zokOr1mGziDg8zcWvI+yVDuCrVhvHrLFQFjhqEh08y4EpCYEaLvzdpBujQa/7n
         0xRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEqrTB5FaplIHtubtqHDoHGUGKwLidOYPDMbUFWYkU+90NfencSuWNBkqnyWasFlVU9Hi8qtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXK1phaqTBM9zgdI7AIDoHHRbLtPesjDP0ZR+2MIkYT6lYV6ss
	lshCtlPAQXHi7yvJcB9Q33zM8BMK02uzQEb9o0OsKEFLV4VXHUFAOF4lJgsHBHuRSh5v5cBHq2N
	rc0zOJBNzta6cgA==
X-Google-Smtp-Source: AGHT+IH9ha7ywWpJ2PLo6/QknNnwWKZ9dSfJ/JFZicMBk9BKuEgn3pMXLdhlaJ5XRnaqRMyRGKl59b6mK7V5YA==
X-Received: from qvbmf2.prod.google.com ([2002:a05:6214:5d82:b0:87d:cc41:af01])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:21c6:b0:87c:2c76:62a2 with SMTP id 6a1803df08f44-87fb6487b37mr117500416d6.64.1761550692801;
 Mon, 27 Oct 2025 00:38:12 -0700 (PDT)
Date: Mon, 27 Oct 2025 07:38:07 +0000
In-Reply-To: <20251027073809.2112498-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251027073809.2112498-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251027073809.2112498-2-edumazet@google.com>
Subject: [PATCH v2 net 1/3] trace: tcp: add three metrics to trace_tcp_rcvbuf_grow()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

While chasing yet another receive autotuning bug,
I found useful to add rcv_ssthresh, window_clamp and rcv_wnd.

tcp_stream 40597 [068]  2172.978198: tcp:tcp_rcvbuf_grow: time=50307 rtt_us=50179 copied=77824 inq=0 space=40960 ooo=0 scaling_ratio=219 rcvbuf=131072 rcv_ssthresh=107474 window_clamp=112128 rcv_wnd=110592
tcp_stream 40597 [068]  2173.028528: tcp:tcp_rcvbuf_grow: time=50336 rtt_us=50206 copied=110592 inq=0 space=77824 ooo=0 scaling_ratio=219 rcvbuf=509444 rcv_ssthresh=328658 window_clamp=435813 rcv_wnd=331776
tcp_stream 40597 [068]  2173.078830: tcp:tcp_rcvbuf_grow: time=50305 rtt_us=50070 copied=270336 inq=0 space=110592 ooo=0 scaling_ratio=219 rcvbuf=509444 rcv_ssthresh=431159 window_clamp=435813 rcv_wnd=434176
tcp_stream 40597 [068]  2173.129137: tcp:tcp_rcvbuf_grow: time=50313 rtt_us=50118 copied=434176 inq=0 space=270336 ooo=0 scaling_ratio=219 rcvbuf=2457847 rcv_ssthresh=1299511 window_clamp=2102611 rcv_wnd=1302528
tcp_stream 40597 [068]  2173.179451: tcp:tcp_rcvbuf_grow: time=50318 rtt_us=50041 copied=1019904 inq=0 space=434176 ooo=0 scaling_ratio=219 rcvbuf=2457847 rcv_ssthresh=2087445 window_clamp=2102611 rcv_wnd=2088960

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/trace/events/tcp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 9d2c36c6a0ed74c82306f347ff41fabed7ada8c4..6757233bd0641778ce3ee260c9d757070adc0fcf 100644
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
2.51.1.821.gb6fe4d2222-goog


