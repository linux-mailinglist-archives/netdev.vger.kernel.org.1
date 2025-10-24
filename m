Return-Path: <netdev+bounces-232518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3149C06297
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766A8189F52B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2E1313526;
	Fri, 24 Oct 2025 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Le0G96Ze"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82126E702
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307631; cv=none; b=aCxGuHX0nZsFzKXVl+b6Urx+35M9XBlE9GQLIvcfR5/pJyVYso/cyBJry8XfsquJv2dIlrn7w+KLXba9I5ogwcASaA2F7OqgQ4OmpMvuspRNDYnZ3SkuvzJXv8Cb/wdBwdK3q88GcjTw3SJ5RRq7Mx3VSQ1qXqPsOeipHvFn0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307631; c=relaxed/simple;
	bh=Ge/lC8zQ5jVeNC9B88lOaicJsTHA7YsVTocnMfDgbBo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SxE5/lVOFz/DTE97xiiZDZsGnRt83xf32QNZqcVHb/rUKfDp+Vtd7UdjXkaz95UqbxSlmRLRnRPJIuEqrPHQ6brIA1onSDPa3qfYkTBotb0HXbJ7xmTAT0Ucd45ykyconQWH0RiCC+0WR5m83sx0xTzQ0KfFwG8BUfp6TtyaIRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Le0G96Ze; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-892d6d7836dso419365485a.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761307629; x=1761912429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SOXV5l+BvPedV6wprllzQPCcpXmgGNfZEp0jO0RclYY=;
        b=Le0G96Ze6hWjbYAgsMJ2p6vmV7egeUBNJ5sM6pcFBar4RrorypPmFO75MFa0SGAMVu
         M+2dROCPPPYilj6Jogfg0I89+s6NxgECvOhAnnGNwPlgKhUhr7pO6XiBm9fLDkCDPFDp
         viHDrTQmXkrWBiAhCNhPsA8U0zUjORlF7wGcnXX7MYkSFu5l/msq62PJAPsTbH6RBM7V
         BIj1I4NDg2Onpv1s+V5dZMop18s7J5uS6cf0U9Vv1NCRQGYYpXNVnWM9Ln02/EEQLK+M
         a3v1rgW9gtPPgbcae4Ak3xoP0dqwDjT4A0X1TpfSeTWAkS7gnNXd4YBsunTCAEhCTCMQ
         3/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761307629; x=1761912429;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SOXV5l+BvPedV6wprllzQPCcpXmgGNfZEp0jO0RclYY=;
        b=om5IsR3u+kycsjtTs2oTii823sghFNnW+JF7KBuZPSj6D3CrW00pz3RgijBRudx5+5
         fnhqQMuQA2QvggimRxJQyuzoh1sB0U0yoEkCgP14iEMrniz6w8/BMm/5sWaKkNWAMX0X
         tWru2I8z7Hunn3+Em3dmbAkczYAt3FLxZioLxfZkTpFDxWozrMDE+vKSAVQvqgHOedbJ
         xtEmEl8PkdtquFDTTxwFYEFAdKcrZxPTEzXl6zyNMAxDu5z3hM5rknEFClejIAmKy0kx
         CRLNmLAeAFDfCpq6ZTKv9JrF+C9ytX8etW7MBXx7YeN1B2y8JsYJTQOdkmZrsbsJrJK8
         oFEg==
X-Forwarded-Encrypted: i=1; AJvYcCUxKYMAcISC2bo6fPUJBD11qmdR/fhkHDYAuOpqNyoty9WDAr1Qyd1buYpX7QfxL3Yuu2e+FYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgew48fyu4f0mwP9We6es4zbFXoXTJ18iuZ/0hjvhqskfLaEF
	/2A1iiSbRlQdXFpF8AzjM9Aqhh+D7mehFx/dlZw6fHzijDbdFmBkL1j6Hdv7L+Yz/lsg7f0fYl1
	SCkTQiyTKOThyQA==
X-Google-Smtp-Source: AGHT+IGMaP7wIhJip3T/xPSFnevBkz5oQ1FnKdRmrt6BV9Ea9oU71n38QAvyaDCDw+xclWFQbQEu+0552Kb+tA==
X-Received: from qkpf18.prod.google.com ([2002:a05:620a:2812:b0:88e:12a2:6b9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4607:b0:88e:8d97:f3ae with SMTP id af79cd13be357-89dbff8349dmr250183685a.26.1761307628791;
 Fri, 24 Oct 2025 05:07:08 -0700 (PDT)
Date: Fri, 24 Oct 2025 12:07:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024120707.3516550-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: remove one ktime_get() from recvmsg() fast path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Each time some payload is consumed by user space (recvmsg() and friends),
TCP calls tcp_rcv_space_adjust() to run DRS algorithm to check
if an increase of sk->sk_rcvbuf is needed.

This function is based on time sampling, and currently calls
tcp_mstamp_refresh(tp), which is a wrapper around ktime_get_ns().

ktime_get_ns() has a high cost on some platforms.
100+ cycles for rdtscp on AMD EPYC Turin for instance.

We do not have to refresh tp->tcp_mpstamp, using the last cached value
is enough. We only need to refresh it from __tcp_cleanup_rbuf()
if an ACK must be sent (this is a rare event).

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c       |  4 +++-
 net/ipv4/tcp_input.c | 10 ++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index b79da6d39392751e189f1f65969b15c904a6792a..a9345aa5a2e5f4a2ca7ca599e7523d017ffa64ee 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1556,8 +1556,10 @@ void __tcp_cleanup_rbuf(struct sock *sk, int copied)
 				time_to_ack = true;
 		}
 	}
-	if (time_to_ack)
+	if (time_to_ack) {
+		tcp_mstamp_refresh(tp);
 		tcp_send_ack(sk);
+	}
 }
 
 void tcp_cleanup_rbuf(struct sock *sk, int copied)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8fc97f4d8a6b2f8e39cabf6c9b3e6cdae294a5f5..ff19f6e54d55cb63f04c2da0b241e3d7d2f946a0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -928,9 +928,15 @@ void tcp_rcv_space_adjust(struct sock *sk)
 
 	trace_tcp_rcv_space_adjust(sk);
 
-	tcp_mstamp_refresh(tp);
+	if (unlikely(!tp->rcv_rtt_est.rtt_us))
+		return;
+
+	/* We do not refresh tp->tcp_mstamp here.
+	 * Some platforms have expensive ktime_get() implementations.
+	 * Using the last cached value is enough for DRS.
+	 */
 	time = tcp_stamp_us_delta(tp->tcp_mstamp, tp->rcvq_space.time);
-	if (time < (tp->rcv_rtt_est.rtt_us >> 3) || tp->rcv_rtt_est.rtt_us == 0)
+	if (time < (tp->rcv_rtt_est.rtt_us >> 3))
 		return;
 
 	/* Number of bytes copied to user in last RTT */
-- 
2.51.1.821.gb6fe4d2222-goog


