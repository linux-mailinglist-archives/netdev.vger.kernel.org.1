Return-Path: <netdev+bounces-241247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940FCC81FCB
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BDA53AC5CF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092A42BD5BB;
	Mon, 24 Nov 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhurMcdA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1E02C178E
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006963; cv=none; b=EG1sWzT2tNi5vCM5KmsDBqwgdQweC8dWZdc4arjIUUuHBmElCLnWSh+Y6v8nm3hRonMdvkxRZ74QlxR3KpBYBboar/0XGrfgiNTEwWettaIu0Ke3PncTMugB3ORxThg8QNCNkI61AZzSbMTFpSUtsI+4GsnbGhGvWXG9yRbWAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006963; c=relaxed/simple;
	bh=LPLYW2pLW1T7rkq8ICsFJkcltBBZm5Z5zRHjw745Jnk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gKcgyWtr31GpMzA0ryvQJxpuY2SHY5Yys/ZApHP9WZfkMCBIjZaNlU4xyGxcnuyciGMR32zkHFsJz1uPEEGNLOd6eU3jfsax1gyKSL/WupKxPal6frthpEoayUK1rEjogq3FWqYHdri2+PviPSGAfx8+OtoP25fz+LT3eA3Vaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhurMcdA; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7c7562d889cso4475592a34.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 09:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764006961; x=1764611761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=paSV/p8s9fegNqCkNqhAQ35qWDKoZHw4pPU5u0mO9Sk=;
        b=YhurMcdAxwmnZR0zrIDXM8gdDls1KnxiRKPnT8/1CXODEpj2ZZ+5DPja6aD+0YshFc
         AEaskd1n1cgryh+5PCVZv5N7maOkoGcKJ+GreGRzCs2/X5CSru6XeJBELe85gIpjMCgU
         Q2MX+Kp7Jdo7Fgcrixl/1CRLn92rUyAd10cySqySrNRZ6S50yeZQtUbsPygvjqv32ab1
         7iVKsdlDRVOYANnSnC8i5hGbfo7Ll9MYqfzRLC+JECtm+4wOzTm8hFzaQ/UBG0D5lCXe
         ciV2AaIxifuAmGku5vmA+TuZWXZrOTH+6yG8+Sox7PHWB3HjQ4RS/+s7H1+HVtV5bYmP
         wzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006961; x=1764611761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=paSV/p8s9fegNqCkNqhAQ35qWDKoZHw4pPU5u0mO9Sk=;
        b=wztyQnqREjW0kA6FMgcx4WS+lDS4b0qZ0aPh6xn4kp/LNRflC855gtn/NSmcwYAHTn
         2l8HxHuwNAoj3S70XDOsYg7PTcRLAO5e9cqYKfh2YIy9ZsUZFz9V0pZIt3Rgywrv7Uum
         pkUZDtsO7fHSxSGJJF2Swl3CVciYu+D6tMOCxNEGhcXbE6Vn9ypFu6PnDNfzRHPaN/8+
         R2ulZloerR9eDEM0W07jAVRnEH3wcCc/3v072nkLIeKYHo2xPqFHh1iq5fqLcbrNFriM
         0SU1BxcsWnvAo9nxbUNWlUkMAIi8huYrb3bowE0hwUvHUfSlBV+/Y+ICqjkw1QVBGsBr
         yaNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+mS+LuWH2MAqiuEb159NISgs89s/XyepqQTMFkhmGpoCfui8CXt1w3+I+yuhtaCIhb9WGg9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6I7TtMdnbXGKs3m15V9wTHe7EfJnLl6FJuT2wAb2cJVC2QZHF
	I3PVfXdVX3qhxeqn6gIC6GH7X1e9QNTiX3R0e8iTrRGRIDThVXWQ3MUhRn1qKuzVPt69AD6vxXK
	5N8o0UJW+8a1/CA==
X-Google-Smtp-Source: AGHT+IHIq78gLALOO8zTqg/p/ln+ovL6GLKPY/aBZKqHbk7O2DiCXgd/WRCGax8GdgRmBbdzgdoVO2k0YkMBdg==
X-Received: from qtcw15.prod.google.com ([2002:a05:622a:190f:b0:4ec:ff2e:2e71])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a46:0:b0:4ed:b570:569 with SMTP id d75a77b69052e-4ee5885ceadmr163758811cf.27.1764006616105;
 Mon, 24 Nov 2025 09:50:16 -0800 (PST)
Date: Mon, 24 Nov 2025 17:50:10 +0000
In-Reply-To: <20251124175013.1473655-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251124175013.1473655-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124175013.1473655-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] tcp: rename icsk_timeout() to tcp_timeout_expires()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation of sk->tcp_timeout_timer introduction,
rename icsk_timeout() helper and change its argument to plain
'const struct sock *sk'.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_connection_sock.h | 5 ++---
 net/ipv4/inet_diag.c               | 4 ++--
 net/ipv4/tcp_ipv4.c                | 4 ++--
 net/ipv4/tcp_timer.c               | 6 +++---
 net/ipv6/tcp_ipv6.c                | 4 ++--
 net/mptcp/protocol.c               | 2 +-
 6 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index fd40af2221b99d74ce2baa79f0378686f86fe997..765c2149d6787ef1063e5f29d78547ec6ca79746 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -184,10 +184,9 @@ static inline void inet_csk_delack_init(struct sock *sk)
 	memset(&inet_csk(sk)->icsk_ack, 0, sizeof(inet_csk(sk)->icsk_ack));
 }
 
-static inline unsigned long
-icsk_timeout(const struct inet_connection_sock *icsk)
+static inline unsigned long tcp_timeout_expires(const struct sock *sk)
 {
-	return READ_ONCE(icsk->icsk_retransmit_timer.expires);
+	return READ_ONCE(inet_csk(sk)->icsk_retransmit_timer.expires);
 }
 
 static inline unsigned long
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index f0b6c5a411a2008e2a039ed37e262f3f132e58ac..9f63c09439a055550c49b659f23ff8a00ee80348 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -287,12 +287,12 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		r->idiag_timer = 1;
 		r->idiag_retrans = READ_ONCE(icsk->icsk_retransmits);
 		r->idiag_expires =
-			jiffies_delta_to_msecs(icsk_timeout(icsk) - jiffies);
+			jiffies_delta_to_msecs(tcp_timeout_expires(sk) - jiffies);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		r->idiag_timer = 4;
 		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
 		r->idiag_expires =
-			jiffies_delta_to_msecs(icsk_timeout(icsk) - jiffies);
+			jiffies_delta_to_msecs(tcp_timeout_expires(sk) - jiffies);
 	} else if (timer_pending(&sk->sk_timer)) {
 		r->idiag_timer = 2;
 		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index e0bb8d9e2d9c8c4a49519655d627e6e4d1b1cbac..7b8af2c8d03a4cf2c0d90029d2725c0f9dc1a071 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2869,10 +2869,10 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active	= 1;
-		timer_expires	= icsk_timeout(icsk);
+		timer_expires	= tcp_timeout_expires(sk);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
-		timer_expires	= icsk_timeout(icsk);
+		timer_expires	= tcp_timeout_expires(sk);
 	} else if (timer_pending(&sk->sk_timer)) {
 		timer_active	= 2;
 		timer_expires	= sk->sk_timer.expires;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 0672c3d8f4f104e4358629ecd4039b3689d08903..afbd901e610e24c88439d5c152531074d514533a 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -510,7 +510,7 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 	 * and tp->rcv_tstamp might very well have been written recently.
 	 * rcv_delta can thus be negative.
 	 */
-	rcv_delta = icsk_timeout(icsk) - tp->rcv_tstamp;
+	rcv_delta = tcp_timeout_expires(sk) - tp->rcv_tstamp;
 	if (rcv_delta <= timeout)
 		return false;
 
@@ -697,9 +697,9 @@ void tcp_write_timer_handler(struct sock *sk)
 	    !icsk->icsk_pending)
 		return;
 
-	if (time_after(icsk_timeout(icsk), jiffies)) {
+	if (time_after(tcp_timeout_expires(sk), jiffies)) {
 		sk_reset_timer(sk, &icsk->icsk_retransmit_timer,
-			       icsk_timeout(icsk));
+			       tcp_timeout_expires(sk));
 		return;
 	}
 	tcp_mstamp_refresh(tcp_sk(sk));
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 08113f43012494df04ef7c66a89169856e5c98df..33c76c3a6da7cb0a1a49344ffe9ae27f0e949388 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2163,10 +2163,10 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active	= 1;
-		timer_expires	= icsk_timeout(icsk);
+		timer_expires	= tcp_timeout_expires(sp);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
-		timer_expires	= icsk_timeout(icsk);
+		timer_expires	= tcp_timeout_expires(sp);
 	} else if (timer_pending(&sp->sk_timer)) {
 		timer_active	= 2;
 		timer_expires	= sp->sk_timer.expires;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 75bb1199bed9ae293e978d6f96d71fb70e9e8e13..e3fc001ea74d224ad3974c214c8e9d2c8b2fcf85 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -524,7 +524,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 	return inet_csk(ssk)->icsk_pending && !subflow->stale_count ?
-	       icsk_timeout(inet_csk(ssk)) - jiffies : 0;
+	       tcp_timeout_expires(ssk) - jiffies : 0;
 }
 
 static void mptcp_set_timeout(struct sock *sk)
-- 
2.52.0.460.gd25c4c69ec-goog


