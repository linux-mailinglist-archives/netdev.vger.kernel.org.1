Return-Path: <netdev+bounces-190242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72781AB5D3B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 21:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736DD861E0B
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B252C0840;
	Tue, 13 May 2025 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPPTxhRQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71052BFC84
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165172; cv=none; b=HWD+xPgBtJktrnWmYiKog5nvGXsbVGZp5fqiy9kyzW0iuKMhg/8UHeAtgug1O/Jz6UFnHDcKavWz3/kSRIwgJtz72YVa6dDkuBAc1JVz/NYmSbAZvEKw/aLkD811KdUoTDleBBUprG9+q69OLOfi5L6C6FT00pLnNm4Rx9YeUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165172; c=relaxed/simple;
	bh=dp+SprAW7Y9Rw5hT7qg7PF1yVAFyE/uPrIpciHPo7fo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O6oxYRAMX4bwked11eLPjFgVsk7gyuNhwcvpx8ZWih3ejMQ7mFg2TenZiTECVtWpLtEC8A+zuISWqf+IwfC2F6Zgy2n8BUlvkfLG4rHm9/SAmtRXEcRCkq8R7b3i1BH2m3Wta6Ga/F9GErsTfWYHghPpIJqmHsOd4AtnyJVoI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPPTxhRQ; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6f6e59df2f3so94787916d6.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747165169; x=1747769969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFIe5+oIsm0ouF0q4o79SDJa3GmqiAScu3krKXMV1f0=;
        b=MPPTxhRQNUdObilQz9lKGRe8U5VzfivittkfoJu5QL1we7mlgjAJmwG9qq9L5r8jaZ
         1QFrHtqawVJS+QGPLlNn8WX6GGoF8S82ID0xQ0WhHZZoE5F6a7g316fZA/q86KEL0O9m
         BoEFrbOYE6dvZ4mp3sGS5Q+iH4oK1Oq9MAgbj1sSE5c5EI8qOyb+Dp4NH6roHeNnPRT+
         2XBEV2c5bFGEcqK1rZCV0C9Zrb9Fs6IvjK9B4ORuaunnK2TpMCa1kfrYARWWghI9NzPZ
         g8knLbDAXEuwpz3PWBh18HMgnpt8O4zJCxCuw0oT22WRirwBIaNpbLhfPdBKfNNEEWtS
         W9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747165169; x=1747769969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFIe5+oIsm0ouF0q4o79SDJa3GmqiAScu3krKXMV1f0=;
        b=xDSZCFmmBJ3MEGcxCrvzsCTAX41rBP/LEzbzPm1HQ2wZa1prYgNXofy+SCLKVFOZJM
         JCaqWNI1+J6sH5YIFh1nkf3FbztnqZvxXsLXEVUHIUGf7oV3UPU//AA2RXTtdOHzFn00
         D6p1T2RPztmFK7xZUX9JW7VrEEYHe4VWLiWxuq97h7XadI0S4IAEar27LWG3bdNOqSro
         Dcx5v/AW2VcWdeR2bP/hcFwq+WbeVOpsYvbuZfsQhLA42hYhh+GdgzslRqvF2HRq3RSs
         tR/2Mr8Oic+XfUelYPGBJ0EjM6+BZFhTPLKC8/0wBDQdboHztqwK8EmP5N85ou2DcvEO
         JXdg==
X-Forwarded-Encrypted: i=1; AJvYcCV8YxEOi6hpcXRW4nxHC9zDwYzq3K7e+d5U38uUlMbIEs9asZCnVzrV6p+qnu7PcVNKaG3V/Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVjCQGL8FeXnlVK51lUeuXzISrYGWA3YUnZkieL8RVaLHHlRj
	2RZAVFcVHZXZH295dHVctD7PE/Tyy6r0OuBCG1E+mkw98YWDdB6wXGdcQy5WrK3UJmNvQ+hjCbB
	jOdq+NSj9iA==
X-Google-Smtp-Source: AGHT+IGcRfEpdcAR7UsbsHazyovTmH8taJZeroOxT2B+ZCakPRXwXdWknAcGtjItnd654jpH0rMCb+BuBjVs9g==
X-Received: from qvbqj11.prod.google.com ([2002:a05:6214:320b:b0:6f5:432c:2957])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:f65:b0:6d8:6a74:ae68 with SMTP id 6a1803df08f44-6f896ea878cmr9640726d6.29.1747165169622;
 Tue, 13 May 2025 12:39:29 -0700 (PDT)
Date: Tue, 13 May 2025 19:39:13 +0000
In-Reply-To: <20250513193919.1089692-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250513193919.1089692-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250513193919.1089692-6-edumazet@google.com>
Subject: [PATCH net-next 05/11] tcp: remove zero TCP TS samples for autotuning
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Rick Jones <jonesrick@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

For TCP flows using ms RFC 7323 timestamp granularity
tcp_rcv_rtt_update() can be fed with 1 ms samples, breaking
TCP autotuning for data center flows with sub ms RTT.

Instead, rely on the window based samples, fed by tcp_rcv_rtt_measure()

tcp_rcvbuf_grow() for a 10 second TCP_STREAM sesssion now looks saner.
We can see rcvbuf is kept at a reasonable value.

  222.234976: tcp:tcp_rcvbuf_grow: time=348 rtt_us=330 copied=110592 inq=0 space=40960 ooo=0 scaling_ratio=230 rcvbuf=131072 ...
  222.235276: tcp:tcp_rcvbuf_grow: time=300 rtt_us=288 copied=126976 inq=0 space=110592 ooo=0 scaling_ratio=230 rcvbuf=246187 ...
  222.235569: tcp:tcp_rcvbuf_grow: time=294 rtt_us=288 copied=184320 inq=0 space=126976 ooo=0 scaling_ratio=230 rcvbuf=282659 ...
  222.235833: tcp:tcp_rcvbuf_grow: time=264 rtt_us=244 copied=373760 inq=0 space=184320 ooo=0 scaling_ratio=230 rcvbuf=410312 ...
  222.236142: tcp:tcp_rcvbuf_grow: time=308 rtt_us=219 copied=424960 inq=20480 space=373760 ooo=0 scaling_ratio=230 rcvbuf=832022 ...
  222.236378: tcp:tcp_rcvbuf_grow: time=236 rtt_us=219 copied=692224 inq=49152 space=404480 ooo=0 scaling_ratio=230 rcvbuf=900407 ...
  222.236602: tcp:tcp_rcvbuf_grow: time=225 rtt_us=219 copied=730112 inq=49152 space=643072 ooo=0 scaling_ratio=230 rcvbuf=1431534 ...
  222.237050: tcp:tcp_rcvbuf_grow: time=229 rtt_us=219 copied=1160192 inq=49152 space=680960 ooo=0 scaling_ratio=230 rcvbuf=1515876 ...
  222.237618: tcp:tcp_rcvbuf_grow: time=305 rtt_us=218 copied=2228224 inq=49152 space=1111040 ooo=0 scaling_ratio=230 rcvbuf=2473271 ...
  222.238591: tcp:tcp_rcvbuf_grow: time=224 rtt_us=218 copied=3063808 inq=360448 space=2179072 ooo=0 scaling_ratio=230 rcvbuf=4850803 ...
  222.240647: tcp:tcp_rcvbuf_grow: time=260 rtt_us=218 copied=2752512 inq=0 space=2703360 ooo=0 scaling_ratio=230 rcvbuf=6017914 ...
  222.243535: tcp:tcp_rcvbuf_grow: time=224 rtt_us=218 copied=2834432 inq=49152 space=2752512 ooo=0 scaling_ratio=230 rcvbuf=6127331 ...
  222.245108: tcp:tcp_rcvbuf_grow: time=240 rtt_us=218 copied=2883584 inq=49152 space=2785280 ooo=0 scaling_ratio=230 rcvbuf=6200275 ...
  222.245333: tcp:tcp_rcvbuf_grow: time=224 rtt_us=218 copied=2859008 inq=0 space=2834432 ooo=0 scaling_ratio=230 rcvbuf=6309692 ...
  222.301021: tcp:tcp_rcvbuf_grow: time=222 rtt_us=218 copied=2883584 inq=0 space=2859008 ooo=0 scaling_ratio=230 rcvbuf=6364400 ...
  222.989242: tcp:tcp_rcvbuf_grow: time=225 rtt_us=218 copied=2899968 inq=0 space=2883584 ooo=0 scaling_ratio=230 rcvbuf=6419108 ...
  224.139553: tcp:tcp_rcvbuf_grow: time=224 rtt_us=218 copied=3014656 inq=65536 space=2899968 ooo=0 scaling_ratio=230 rcvbuf=6455580 ...
  224.584608: tcp:tcp_rcvbuf_grow: time=232 rtt_us=218 copied=3014656 inq=49152 space=2949120 ooo=0 scaling_ratio=230 rcvbuf=6564997 ...
  230.145560: tcp:tcp_rcvbuf_grow: time=223 rtt_us=218 copied=2981888 inq=0 space=2965504 ooo=0 scaling_ratio=230 rcvbuf=6601469 ...

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Wei Wang <weiwan@google.com>
---
 net/ipv4/tcp_input.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5d64a6ecfc8f78de3665afdea112d62c417cee27..f3eae8f5ad2b6c5602542a1083328f71ec8cbded 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -712,7 +712,7 @@ static inline void tcp_rcv_rtt_measure(struct tcp_sock *tp)
 	tp->rcv_rtt_est.time = tp->tcp_mstamp;
 }
 
-static s32 tcp_rtt_tsopt_us(const struct tcp_sock *tp)
+static s32 tcp_rtt_tsopt_us(const struct tcp_sock *tp, u32 min_delta)
 {
 	u32 delta, delta_us;
 
@@ -722,7 +722,7 @@ static s32 tcp_rtt_tsopt_us(const struct tcp_sock *tp)
 
 	if (likely(delta < INT_MAX / (USEC_PER_SEC / TCP_TS_HZ))) {
 		if (!delta)
-			delta = 1;
+			delta = min_delta;
 		delta_us = delta * (USEC_PER_SEC / TCP_TS_HZ);
 		return delta_us;
 	}
@@ -740,9 +740,9 @@ static inline void tcp_rcv_rtt_measure_ts(struct sock *sk,
 
 	if (TCP_SKB_CB(skb)->end_seq -
 	    TCP_SKB_CB(skb)->seq >= inet_csk(sk)->icsk_ack.rcv_mss) {
-		s32 delta = tcp_rtt_tsopt_us(tp);
+		s32 delta = tcp_rtt_tsopt_us(tp, 0);
 
-		if (delta >= 0)
+		if (delta > 0)
 			tcp_rcv_rtt_update(tp, delta, 0);
 	}
 }
@@ -3224,7 +3224,7 @@ static bool tcp_ack_update_rtt(struct sock *sk, const int flag,
 	 */
 	if (seq_rtt_us < 0 && tp->rx_opt.saw_tstamp &&
 	    tp->rx_opt.rcv_tsecr && flag & FLAG_ACKED)
-		seq_rtt_us = ca_rtt_us = tcp_rtt_tsopt_us(tp);
+		seq_rtt_us = ca_rtt_us = tcp_rtt_tsopt_us(tp, 1);
 
 	rs->rtt_us = ca_rtt_us; /* RTT of last (S)ACKed packet (or -1) */
 	if (seq_rtt_us < 0)
-- 
2.49.0.1045.g170613ef41-goog


