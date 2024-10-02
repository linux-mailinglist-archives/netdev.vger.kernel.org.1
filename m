Return-Path: <netdev+bounces-131335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516D98E1A7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E35B26561
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5471D1E60;
	Wed,  2 Oct 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzSNJaWb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EAD1D1739
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890253; cv=none; b=mO3VTbsZ+GLGVAsT8VPV+NSkdA+fdfejAQ5vC84m5XuHYXpb1F+cUILrwKD4Tt0fzXmkTSZwDo40FQWCZUjP8euPTXtXDeUdXdX5FS1dCknbdxeawDgyne3afDvPcTclUxroraGhG4xUNu5gveE/DeQlcRtqoWoa/IP3MGdf5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890253; c=relaxed/simple;
	bh=1C7LtANCjqvXjkSMmkDHQhTROZHZm5Z9JHfUnZf50zQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8YNPtEM16I7z6D2tXngw7CVrKYmmMqlo9opex53wQjaJUThGbH0DS2Ak8l/+IwI2TSjTAwTqwKhpBBBb/+gaYnE6ZjfZ7yGQVsxFWxHIs9QQVJ01/LVbUa4cW82RHq5PA6dLUptvOffr4Fhb1e0d55dC1XQi7I2WCpWb8YeHZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UzSNJaWb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e25a6fddb0so1144587b3.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727890251; x=1728495051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxWBwsiwhkxidE9d07ZP7OQ4yl5Vlsy/f7najGyn8KU=;
        b=UzSNJaWbBW3dyslJBvKllIreElHU2xYjTeuQ7uNwShVzo2LxeANoQw29S9ZMhMOFCF
         DbXxqFDG1IsSXMuH8DpBdXlZkfEXP3AaiE41gkyw8GnlyiHGLSjcnro/RWS39cSzaaAl
         D7Jn2bHtIfr0KVwWGm1U6Xgt/p5CAxmhwTdWFR2v+tvwG10uewQ9KTcVvPO84Npwyix9
         hQV0Q2ivfBpy69/ivo1IVyT5GyKutYw9GuOHVtYewJsdOI0nczI7ebgvs/3EnBYnL1Z8
         eYFjDon/tNkxDpRUFdh/FboSNnG0ReHShDGB7vA4VuQDAmPIQfhs7vF+4v4opcRBnZQZ
         7hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890251; x=1728495051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxWBwsiwhkxidE9d07ZP7OQ4yl5Vlsy/f7najGyn8KU=;
        b=B7LHl0D5vWgE9AkjV95E3RfpNx8YAZpoz61Z6GSF4FL5pGdclNZXKxKYqASLt3BTrm
         m1n7vFHQidCH4wIVLVVzEpcRKYQ1Zf2rCmxzCD6Hdav2co67akAMhvO/h+gh4nFsfyZK
         I8vsgu2BitnzqJoswsE1Tt8vqtitRC14GdXIHXgBtzWiGZrC5D7oakMflmMTk4c07las
         zBf0zjWIrrV4d4qHtZU9dFkO9iLhirW8vlOkIJzunn527GTFq9bO20thi5BVtWJCsW59
         /UeaTQsFHVcS+DmHio5/AxeXU6BnlRojb14RniScLyc1cXVNiQHTiDTdgJmBz1j3GSGF
         m1cg==
X-Forwarded-Encrypted: i=1; AJvYcCXisTFfgEk3qFUnNuYpy7ijpGpRaBCXFPabFxi9O/5sehh4i26w6whqH+avWs4pQaHkuI3g4fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM1Ev6L6T6IAvRlEHsD6tpXmRC+QtTfVkd3J6XmToIJySqPTNl
	43lJv2kMXpMKEonmTpIM5a8M48jNnIRjpDjTDrdgmEn8jbhE7YMiFQXDTcOWMG57jhxkAAXAx8E
	fyfGKN76vvg==
X-Google-Smtp-Source: AGHT+IEDjeeMErPSqjj8QsgH5ugDTe/WngCiK5d+ijrTWl1SmTPvI3GxDfxWSI6GIqiUQxnyMPVeHAlJvWPK4w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:7603:b0:69b:c01:82a5 with SMTP
 id 00721157ae682-6e2a3049ddbmr254307b3.7.1727890250879; Wed, 02 Oct 2024
 10:30:50 -0700 (PDT)
Date: Wed,  2 Oct 2024 17:30:42 +0000
In-Reply-To: <20241002173042.917928-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002173042.917928-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241002173042.917928-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] tcp: add a fast path in tcp_delack_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

delack timer is not stopped from inet_csk_clear_xmit_timer()
because we do not define INET_CSK_CLEAR_TIMERS.

This is a conscious choice : inet_csk_clear_xmit_timer()
is often called from another cpu. Calling del_timer()
would cause false sharing and lock contention.

This means that very often, tcp_delack_timer() is called
at the timer expiration, while there is no ACK to transmit.

This can be detected very early, avoiding the socket spinlock.

Notes:
- test about tp->compressed_ack is racy,
  but in the unlikely case there is a race, the dedicated
  compressed_ack_timer hrtimer would close it.

- Even if the fast path is not taken, reading
  icsk->icsk_ack.pending and tp->compressed_ack
  before acquiring the socket spinlock reduces
  acquisition time and chances of contention.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_connection_sock.h | 5 +++--
 net/ipv4/inet_connection_sock.c    | 4 ++--
 net/ipv4/tcp_output.c              | 3 ++-
 net/ipv4/tcp_timer.c               | 9 +++++++++
 net/mptcp/protocol.c               | 3 ++-
 5 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 914d1977270449241f6fc6da2055f3af02a75f99..3c82fad904d4c6c51069e2e703673d667bb36d06 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -202,7 +202,7 @@ static inline void inet_csk_clear_xmit_timer(struct sock *sk, const int what)
 		sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
 #endif
 	} else if (what == ICSK_TIME_DACK) {
-		icsk->icsk_ack.pending = 0;
+		smp_store_release(&icsk->icsk_ack.pending, 0);
 		icsk->icsk_ack.retry = 0;
 #ifdef INET_CSK_CLEAR_TIMERS
 		sk_stop_timer(sk, &icsk->icsk_delack_timer);
@@ -233,7 +233,8 @@ static inline void inet_csk_reset_xmit_timer(struct sock *sk, const int what,
 		icsk->icsk_timeout = jiffies + when;
 		sk_reset_timer(sk, &icsk->icsk_retransmit_timer, icsk->icsk_timeout);
 	} else if (what == ICSK_TIME_DACK) {
-		icsk->icsk_ack.pending |= ICSK_ACK_TIMER;
+		smp_store_release(&icsk->icsk_ack.pending,
+				  icsk->icsk_ack.pending | ICSK_ACK_TIMER);
 		icsk->icsk_ack.timeout = jiffies + when;
 		sk_reset_timer(sk, &icsk->icsk_delack_timer, icsk->icsk_ack.timeout);
 	} else {
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 8c53385cc808c61097898514fd91a322e3a08d31..12e975ed4910d8c7cca79b1812f365589a5d469a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -776,7 +776,7 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	smp_store_release(&icsk->icsk_pending, 0);
-	icsk->icsk_ack.pending = 0;
+	smp_store_release(&icsk->icsk_ack.pending, 0);
 
 	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
 	sk_stop_timer(sk, &icsk->icsk_delack_timer);
@@ -792,7 +792,7 @@ void inet_csk_clear_xmit_timers_sync(struct sock *sk)
 	sock_not_owned_by_me(sk);
 
 	smp_store_release(&icsk->icsk_pending, 0);
-	icsk->icsk_ack.pending = 0;
+	smp_store_release(&icsk->icsk_ack.pending, 0);
 
 	sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
 	sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4d04073016035dcf62ba5e0ad23aac86e54e65c7..08772395690d13a0c3309a273543a51aa0dd3fdc 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4224,7 +4224,8 @@ void tcp_send_delayed_ack(struct sock *sk)
 		if (!time_before(timeout, icsk->icsk_ack.timeout))
 			timeout = icsk->icsk_ack.timeout;
 	}
-	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
+	smp_store_release(&icsk->icsk_ack.pending,
+			  icsk->icsk_ack.pending | ICSK_ACK_SCHED | ICSK_ACK_TIMER);
 	icsk->icsk_ack.timeout = timeout;
 	sk_reset_timer(sk, &icsk->icsk_delack_timer, timeout);
 }
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index b7266b9101ce5933776bd38d086287667e3a7f18..c3a7442332d4926a6089812f789e89ee23081306 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -361,6 +361,14 @@ static void tcp_delack_timer(struct timer_list *t)
 			from_timer(icsk, t, icsk_delack_timer);
 	struct sock *sk = &icsk->icsk_inet.sk;
 
+	/* Avoid taking socket spinlock if there is no ACK to send.
+	 * The compressed_ack check is racy, but a separate hrtimer
+	 * will take care of it eventually.
+	 */
+	if (!(smp_load_acquire(&icsk->icsk_ack.pending) & ICSK_ACK_TIMER) &&
+	    !READ_ONCE(tcp_sk(sk)->compressed_ack))
+		goto out;
+
 	bh_lock_sock(sk);
 	if (!sock_owned_by_user(sk)) {
 		tcp_delack_timer_handler(sk);
@@ -371,6 +379,7 @@ static void tcp_delack_timer(struct timer_list *t)
 			sock_hold(sk);
 	}
 	bh_unlock_sock(sk);
+out:
 	sock_put(sk);
 }
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c2317919fc148a67a81ded795359bd613c9b0dff..e85862352084907582ec884dcb96832356419fa5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3504,7 +3504,8 @@ static void schedule_3rdack_retransmission(struct sock *ssk)
 	timeout += jiffies;
 
 	WARN_ON_ONCE(icsk->icsk_ack.pending & ICSK_ACK_TIMER);
-	icsk->icsk_ack.pending |= ICSK_ACK_SCHED | ICSK_ACK_TIMER;
+	smp_store_release(&icsk->icsk_ack.pending,
+			  icsk->icsk_ack.pending | ICSK_ACK_SCHED | ICSK_ACK_TIMER);
 	icsk->icsk_ack.timeout = timeout;
 	sk_reset_timer(ssk, &icsk->icsk_delack_timer, timeout);
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


