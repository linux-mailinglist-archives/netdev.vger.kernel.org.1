Return-Path: <netdev+bounces-131333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E898E1A1
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BDD71C22A00
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7051D1743;
	Wed,  2 Oct 2024 17:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hfbsl98u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E91D1739
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 17:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890250; cv=none; b=Z/PNojTZdQRjc/jtkiS5A+FXlOzmSiohJtEzLnvGLhxXKJkJ97GZ4UWOoS3LmaYMbubJ3RyTbXaiUpnKluj/lLB/kAGjoWRNlGLNFiFPKL/VTb8fZDIvwU/CXbPGfR7nLemEpL9Ma7l0O3FY3+cI11ot4Wq77K0S3WhQUhD/r7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890250; c=relaxed/simple;
	bh=n1U+CJK2WNZaCFS+gqoMVyeDBpRHZzR4gIu1IpvHnJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EU5Y6KxfqLfi2y10S/XG4yVmhUbMX3ekztRczEbUyZQt8BWTUsBPGCl7Dfa0j5Q4eZK5T95GHmmWvHcg2QUnKWqgJFPeXphYga2zAmy4bBf1ugZGIxvqcc9/HBT2EYzhoOWJhG1gIu6MEwoT7bUPqm5UUBocmMWaP59jzKyl/Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hfbsl98u; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e24e37f1eeso881647b3.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727890247; x=1728495047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iPC1n2jYybOYlpIvWYJSdmwmrMEoQH22CK9d9IpbAls=;
        b=Hfbsl98uIS2gfi6940lY26GZAcu4gj1+aHXb6b26jpKxA3TnUNC6cuP1sfCYK16L8M
         yKXKBPC9w9RPaos5JOrHiB6pMXE9CbVrPl8wHIErwxvuJSYq/sxxXTN2w976HUhkm1mC
         WDfH2Xvfu1DRuBDjyifOWE+wzi64itvF0INvzwbPF76d+w8EcGQA/mvjbIeJggALcYrS
         5YsiTc9CvwZQ8QUi8D3ymRUYTog1GiDEOIO7JtcgkDwv5JQuRpgiL9rD6id+KGF3gsYv
         6wS/AY38XP/RXxmimS+pRmfcJdhNC9USJT5ixQh+1KE2+V1dHTht1mMiUsyrLN/qxnWI
         nPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727890247; x=1728495047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iPC1n2jYybOYlpIvWYJSdmwmrMEoQH22CK9d9IpbAls=;
        b=Qjfe7rHZyZNdn/7R9HJZFr4s7KE1BQxEh8sHb9S5AgjEUd72hgffI+Ir5aI+y6fuFW
         wqTvpmYzsA1A/UMSF20m1+D5ofdm9YroPwSANfww3GW5SkdwaMwEHpz71LYLrX4s6HZL
         jATwsLJMX8xVJxWQzUFXa3JyvjWZJ9oQ94p+SZHpeAp4Z1Xh/uNG3KYBkItXB4j5gmsu
         0s0xph77u85+97IpmCuRBq21tDOeEB/BJTi3X73iG7zzGBRiHG3v2MnDxdxpckFF92is
         KsF1ddIVv6MQeQafjfn+1m3PwfNjIzYNboBmL2Oa+SojmzGCwTz726nOsguoQIXY3J1Z
         y06w==
X-Forwarded-Encrypted: i=1; AJvYcCXKo+i+n+F24gKSx3FIpuJZOan1XbYwn85hMGq1+oiujpH7fUTV2U/VroqOTs5hlNDJrik6JrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+MU9XOOCn/btaGIIS6tKeoyaACaamjSCFuxsqQO2sE7dk4Uw
	j1S7yoC/SD/AK69yu8h90zK64/Y6G9sbehKuiIkZjKxcdg+Ubf6iGP08CvcGHxpe5mQIEZbZceF
	Hn63NUxhYmQ==
X-Google-Smtp-Source: AGHT+IGhYVNyZjbY3jNQLsjtMcZaFe7rn6xyouzytvUuOSM9AMcaoPIqHbTUQ4CtDg8gGhso+x5qzxyYS5H0yQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:4609:b0:648:fc8a:cd23 with SMTP
 id 00721157ae682-6e2a2ad8dfemr356707b3.2.1727890247652; Wed, 02 Oct 2024
 10:30:47 -0700 (PDT)
Date: Wed,  2 Oct 2024 17:30:40 +0000
In-Reply-To: <20241002173042.917928-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002173042.917928-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241002173042.917928-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] tcp: annotate data-races around icsk->icsk_pending
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icsk->icsk_pending can be read locklessly already.

Following patch in the series will add another lockless read.

Add smp_load_acquire() and smp_store_release() annotations
because following patch will add a test in tcp_write_timer(),
and READ_ONCE()/WRITE_ONCE() alone would possibly lead to races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_connection_sock.h |  4 ++--
 net/ipv4/inet_connection_sock.c    |  6 ++++--
 net/ipv4/inet_diag.c               | 10 ++++++----
 net/ipv4/tcp_ipv4.c                | 10 ++++++----
 net/ipv4/tcp_output.c              |  4 ++--
 net/ipv4/tcp_timer.c               |  4 ++--
 net/ipv6/tcp_ipv6.c                | 10 ++++++----
 7 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index c0deaafebfdc0bc5b7f9e1b2a881f797a1a82ace..914d1977270449241f6fc6da2055f3af02a75f99 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -197,7 +197,7 @@ static inline void inet_csk_clear_xmit_timer(struct sock *sk, const int what)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	if (what == ICSK_TIME_RETRANS || what == ICSK_TIME_PROBE0) {
-		icsk->icsk_pending = 0;
+		smp_store_release(&icsk->icsk_pending, 0);
 #ifdef INET_CSK_CLEAR_TIMERS
 		sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
 #endif
@@ -229,7 +229,7 @@ static inline void inet_csk_reset_xmit_timer(struct sock *sk, const int what,
 
 	if (what == ICSK_TIME_RETRANS || what == ICSK_TIME_PROBE0 ||
 	    what == ICSK_TIME_LOSS_PROBE || what == ICSK_TIME_REO_TIMEOUT) {
-		icsk->icsk_pending = what;
+		smp_store_release(&icsk->icsk_pending, what);
 		icsk->icsk_timeout = jiffies + when;
 		sk_reset_timer(sk, &icsk->icsk_retransmit_timer, icsk->icsk_timeout);
 	} else if (what == ICSK_TIME_DACK) {
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 2c5632d4fddbe8ad96f6c35b9ed770d09126eb5d..8c53385cc808c61097898514fd91a322e3a08d31 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -775,7 +775,8 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
-	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
+	smp_store_release(&icsk->icsk_pending, 0);
+	icsk->icsk_ack.pending = 0;
 
 	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
 	sk_stop_timer(sk, &icsk->icsk_delack_timer);
@@ -790,7 +791,8 @@ void inet_csk_clear_xmit_timers_sync(struct sock *sk)
 	/* ongoing timer handlers need to acquire socket lock. */
 	sock_not_owned_by_me(sk);
 
-	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
+	smp_store_release(&icsk->icsk_pending, 0);
+	icsk->icsk_ack.pending = 0;
 
 	sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
 	sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 67639309163d05c034fad80fc9a6096c3b79d42f..321acc8abf17e8c7d6a4e3326615123fff19deab 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -247,6 +247,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 	struct nlmsghdr  *nlh;
 	struct nlattr *attr;
 	void *info = NULL;
+	u8 icsk_pending;
 	int protocol;
 
 	cb_data = cb->data;
@@ -307,14 +308,15 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		goto out;
 	}
 
-	if (icsk->icsk_pending == ICSK_TIME_RETRANS ||
-	    icsk->icsk_pending == ICSK_TIME_REO_TIMEOUT ||
-	    icsk->icsk_pending == ICSK_TIME_LOSS_PROBE) {
+	icsk_pending = smp_load_acquire(&icsk->icsk_pending);
+	if (icsk_pending == ICSK_TIME_RETRANS ||
+	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
+	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		r->idiag_timer = 1;
 		r->idiag_retrans = icsk->icsk_retransmits;
 		r->idiag_expires =
 			jiffies_delta_to_msecs(icsk->icsk_timeout - jiffies);
-	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
+	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		r->idiag_timer = 4;
 		r->idiag_retrans = icsk->icsk_probes_out;
 		r->idiag_expires =
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5afe5e57c89b5c28dfada2bf2e01fa7b3afa61f0..985028434f644c399e51d12ba8d9c2c5740dc6e1 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2900,15 +2900,17 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 	__be32 src = inet->inet_rcv_saddr;
 	__u16 destp = ntohs(inet->inet_dport);
 	__u16 srcp = ntohs(inet->inet_sport);
+	u8 icsk_pending;
 	int rx_queue;
 	int state;
 
-	if (icsk->icsk_pending == ICSK_TIME_RETRANS ||
-	    icsk->icsk_pending == ICSK_TIME_REO_TIMEOUT ||
-	    icsk->icsk_pending == ICSK_TIME_LOSS_PROBE) {
+	icsk_pending = smp_load_acquire(&icsk->icsk_pending);
+	if (icsk_pending == ICSK_TIME_RETRANS ||
+	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
+	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active	= 1;
 		timer_expires	= icsk->icsk_timeout;
-	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
+	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
 		timer_expires	= icsk->icsk_timeout;
 	} else if (timer_pending(&sk->sk_timer)) {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4fd746bd4d54f621601b20c3821e71370a4a615a..4d04073016035dcf62ba5e0ad23aac86e54e65c7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2960,7 +2960,7 @@ void tcp_send_loss_probe(struct sock *sk)
 		WARN_ONCE(tp->packets_out,
 			  "invalid inflight: %u state %u cwnd %u mss %d\n",
 			  tp->packets_out, sk->sk_state, tcp_snd_cwnd(tp), mss);
-		inet_csk(sk)->icsk_pending = 0;
+		smp_store_release(&inet_csk(sk)->icsk_pending, 0);
 		return;
 	}
 
@@ -2993,7 +2993,7 @@ void tcp_send_loss_probe(struct sock *sk)
 
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPLOSSPROBES);
 	/* Reset s.t. tcp_rearm_rto will restart timer from now */
-	inet_csk(sk)->icsk_pending = 0;
+	smp_store_release(&inet_csk(sk)->icsk_pending, 0);
 rearm_timer:
 	tcp_rearm_rto(sk);
 }
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 79064580c8c0d55daa2ab4dc6d27a5ab8802e599..56c597e763ac7a8cebeba324f84e57b1eeeae977 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -701,11 +701,11 @@ void tcp_write_timer_handler(struct sock *sk)
 		tcp_send_loss_probe(sk);
 		break;
 	case ICSK_TIME_RETRANS:
-		icsk->icsk_pending = 0;
+		smp_store_release(&icsk->icsk_pending, 0);
 		tcp_retransmit_timer(sk);
 		break;
 	case ICSK_TIME_PROBE0:
-		icsk->icsk_pending = 0;
+		smp_store_release(&icsk->icsk_pending, 0);
 		tcp_probe_timer(sk);
 		break;
 	}
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d71ab4e1efe1c6598cf3d3e4334adf0881064ce9..7634c0be6acbdb67bb378cc81bdbf184552d2afc 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2177,6 +2177,7 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 	const struct tcp_sock *tp = tcp_sk(sp);
 	const struct inet_connection_sock *icsk = inet_csk(sp);
 	const struct fastopen_queue *fastopenq = &icsk->icsk_accept_queue.fastopenq;
+	u8 icsk_pending;
 	int rx_queue;
 	int state;
 
@@ -2185,12 +2186,13 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 	destp = ntohs(inet->inet_dport);
 	srcp  = ntohs(inet->inet_sport);
 
-	if (icsk->icsk_pending == ICSK_TIME_RETRANS ||
-	    icsk->icsk_pending == ICSK_TIME_REO_TIMEOUT ||
-	    icsk->icsk_pending == ICSK_TIME_LOSS_PROBE) {
+	icsk_pending = smp_load_acquire(&icsk->icsk_pending);
+	if (icsk_pending == ICSK_TIME_RETRANS ||
+	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
+	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active	= 1;
 		timer_expires	= icsk->icsk_timeout;
-	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
+	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
 		timer_expires	= icsk->icsk_timeout;
 	} else if (timer_pending(&sp->sk_timer)) {
-- 
2.47.0.rc0.187.ge670bccf7e-goog


