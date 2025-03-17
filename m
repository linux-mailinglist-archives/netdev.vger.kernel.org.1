Return-Path: <netdev+bounces-175349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379BCA6554A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 16:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3AA6165859
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D3248867;
	Mon, 17 Mar 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ET8SAlDI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294FD2459FA
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742224447; cv=none; b=tNqYg5pYttB47JPrhXk0963KtbIPwQgto3w6YEDukEsF25VirSjdfv+Wcn/B+HDSSeVl4yJBSj5A0CLngMI1C38wQAlDVGQR+7Vl9eWG5wCMluDJDh/c6GcUW3gooLHeJ4NtwKkcWRUrh+msBIIwvD7YrZ+HtY2/52mwXmXuBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742224447; c=relaxed/simple;
	bh=JjCNvtGhz0xPbDZCHEZk5FpgmHpoDsA/RFqnFYC8u5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j5uJsTyEvGEVadhF02Bj8pXZnVx6uqYX5Cbelm6qRAlSkyrV2Vh2AYOEK8fztfKkcO7cxHaHvS6+/WT+XNOatFHHjR8WFgQrsFMOq5cFhKlmw3sgvX0qq9Yupxou2mZKirDujtUeN4QNenLYwaBBcZn5kCb+1FiqmSJZpzmnGmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ET8SAlDI; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-86d37107033so6886837241.0
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742224444; x=1742829244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkRMSS+WaBVNmJUBR/t9KuL0F4TEzyLkM4V9oeIXf38=;
        b=ET8SAlDIeebqlQiJmbXUw23ksMhEVGy1rfg6PWKjescYtMPrtW7wLAHStZGXlco7bG
         NAxWWuhAJQN2kCT3swWP0yamBFRGhrKSjmoYnuAXVBKroofY7G4u3MRMIk5JRgRb4OZ2
         yClzkK9ZiuVCpNZFfb3al3qjzYzh8MHM6dniiQ2WxLmMv22d8KRTtuT9Puz9uYj782pL
         PcR0SJ/T2+EI2guCy/bdmId8IscCcDIhn0uczCaEamvMcniZ0hapBG01C01l2IZDI3gF
         UTTSIkCXeHcztGL3QRC1KBbP3ePFpIgZ1BPQqPJ44pf0xkmCXfYCu2a3INbqtPg2EMh5
         4x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742224444; x=1742829244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkRMSS+WaBVNmJUBR/t9KuL0F4TEzyLkM4V9oeIXf38=;
        b=kks0R5y3cgWMSIoEcguvlPzvHxEpxk4zQ/eiDK4wTsbSSoQO+NAS+FokBoydODrjsq
         R3jGh/REiTMV7Kf8z3HsFjrJU9/wqjXGfks1sY7hMqU4qq3bV7AjZqdIXjBlwjPvoadh
         RMJTxqVEGLFRIec2f3ha1aq92R2R+bhk4/IZ5YkzXVtlJ0kZU4CtDAHfI5fFdvujhJ//
         7fvHSn1rwK4ym9Nf6j+k4THQ6BpdLMum58+ETenP/69cKzbQDeuLt8nDVawYpldV8d9T
         y0hdyRWukPM43bMTbuNhz9vLcYA0WZajEDUUCYQNrKBl0qSNk7gcXov2BZpT3qFIXsEt
         /Xxg==
X-Forwarded-Encrypted: i=1; AJvYcCXTr+/MEav/TU6ekqfCtuSF/nE3S04UXkv7FpLIjqj/TFmBNK3D8q3Cz9uGJUU2Nhz4E8epuxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyea9CHJPKXiP7GW08FUUyhlB6qsNErMMPoQfkZI5+1rCJhYSnR
	7xxkqNU2ImG/XU+7z5AjssjiYXbR3MZX4gOUrzlkbLl1StnLbwEmxWDkYiy2ZNmaH86fBO5eEJN
	fq+a1wHr1Gg==
X-Google-Smtp-Source: AGHT+IEcSI0338neKKBiRkr2oYhRIyS9HCgNNTx/aASfeJnfOC9B576gK6XNPMi4n7NRaUMMgcoPqoQKd4M/aQ==
X-Received: from vsvf10.prod.google.com ([2002:a05:6102:150a:b0:4c1:6d54:5104])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:c0f:b0:4bb:baa0:370b with SMTP id ada2fe7eead31-4c383b5b3b2mr6297404137.7.1742224443939;
 Mon, 17 Mar 2025 08:14:03 -0700 (PDT)
Date: Mon, 17 Mar 2025 15:14:00 +0000
In-Reply-To: <20250317151401.3439637-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250317151401.3439637-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317151401.3439637-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp/dccp: remove icsk->icsk_timeout
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icsk->icsk_timeout can be replaced by icsk->icsk_retransmit_timer.expires

This saves 8 bytes in TCP/DCCP sockets and helps for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net_cachelines/inet_connection_sock.rst          |  3 +--
 include/net/inet_connection_sock.h                   | 12 ++++++++----
 net/dccp/timer.c                                     |  4 ++--
 net/ipv4/inet_diag.c                                 |  4 ++--
 net/ipv4/tcp_ipv4.c                                  |  4 ++--
 net/ipv4/tcp_timer.c                                 | 11 ++++++-----
 net/ipv6/tcp_ipv6.c                                  |  4 ++--
 net/mptcp/protocol.c                                 |  2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c    |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c    |  4 ++--
 10 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.rst b/Documentation/networking/net_cachelines/inet_connection_sock.rst
index b2401aa7c45090b07c2262ac31a3584725f92233..5fb0dd70c9af76ca68b3406ce76d4b61957c7da9 100644
--- a/Documentation/networking/net_cachelines/inet_connection_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
@@ -12,8 +12,7 @@ struct inet_sock                    icsk_inet              read_mostly         r
 struct request_sock_queue           icsk_accept_queue
 struct inet_bind_bucket             icsk_bind_hash         read_mostly                             tcp_set_state
 struct inet_bind2_bucket            icsk_bind2_hash        read_mostly                             tcp_set_state,inet_put_port
-unsigned_long                       icsk_timeout           read_mostly                             inet_csk_reset_xmit_timer,tcp_connect
-struct timer_list                   icsk_retransmit_timer  read_mostly                             inet_csk_reset_xmit_timer,tcp_connect
+struct timer_list                   icsk_retransmit_timer  read_write                              inet_csk_reset_xmit_timer,tcp_connect
 struct timer_list                   icsk_delack_timer      read_mostly                             inet_csk_reset_xmit_timer,tcp_connect
 u32                                 icsk_rto               read_write                              tcp_cwnd_validate,tcp_schedule_loss_probe,tcp_connect_init,tcp_connect,tcp_write_xmit,tcp_push_one
 u32                                 icsk_rto_min
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index d9978ffacc970efd308d0011a094aec41b561e65..6cf0fb69fc99ec0d4b368c53733c4cf0ac60669a 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -58,7 +58,6 @@ struct inet_connection_sock_af_ops {
  * @icsk_accept_queue:	   FIFO of established children
  * @icsk_bind_hash:	   Bind node
  * @icsk_bind2_hash:	   Bind node in the bhash2 table
- * @icsk_timeout:	   Timeout
  * @icsk_retransmit_timer: Resend (no ack)
  * @icsk_rto:		   Retransmit timeout
  * @icsk_pmtu_cookie	   Last pmtu seen by socket
@@ -85,7 +84,6 @@ struct inet_connection_sock {
 	struct request_sock_queue icsk_accept_queue;
 	struct inet_bind_bucket	  *icsk_bind_hash;
 	struct inet_bind2_bucket  *icsk_bind2_hash;
-	unsigned long		  icsk_timeout;
  	struct timer_list	  icsk_retransmit_timer;
  	struct timer_list	  icsk_delack_timer;
 	__u32			  icsk_rto;
@@ -190,6 +188,12 @@ static inline void inet_csk_delack_init(struct sock *sk)
 	memset(&inet_csk(sk)->icsk_ack, 0, sizeof(inet_csk(sk)->icsk_ack));
 }
 
+static inline unsigned long
+icsk_timeout(const struct inet_connection_sock *icsk)
+{
+	return READ_ONCE(icsk->icsk_retransmit_timer.expires);
+}
+
 static inline void inet_csk_clear_xmit_timer(struct sock *sk, const int what)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -228,8 +232,8 @@ static inline void inet_csk_reset_xmit_timer(struct sock *sk, const int what,
 	if (what == ICSK_TIME_RETRANS || what == ICSK_TIME_PROBE0 ||
 	    what == ICSK_TIME_LOSS_PROBE || what == ICSK_TIME_REO_TIMEOUT) {
 		smp_store_release(&icsk->icsk_pending, what);
-		icsk->icsk_timeout = jiffies + when;
-		sk_reset_timer(sk, &icsk->icsk_retransmit_timer, icsk->icsk_timeout);
+		when += jiffies;
+		sk_reset_timer(sk, &icsk->icsk_retransmit_timer, when);
 	} else if (what == ICSK_TIME_DACK) {
 		smp_store_release(&icsk->icsk_ack.pending,
 				  icsk->icsk_ack.pending | ICSK_ACK_TIMER);
diff --git a/net/dccp/timer.c b/net/dccp/timer.c
index a4cfb47b60e523bd4a8f1f47cfedc11e633945c6..9fd14a3361893d5f2d9f0ad18a65cff963cc7e22 100644
--- a/net/dccp/timer.c
+++ b/net/dccp/timer.c
@@ -139,9 +139,9 @@ static void dccp_write_timer(struct timer_list *t)
 	if (sk->sk_state == DCCP_CLOSED || !icsk->icsk_pending)
 		goto out;
 
-	if (time_after(icsk->icsk_timeout, jiffies)) {
+	if (time_after(icsk_timeout(icsk), jiffies)) {
 		sk_reset_timer(sk, &icsk->icsk_retransmit_timer,
-			       icsk->icsk_timeout);
+			       icsk_timeout(icsk));
 		goto out;
 	}
 
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index efe2a085cf68e90cd1e79b5556e667a0fd044bfd..c2bb91d9e9ffd1fc7dc9bf048c1d6bbd75462997 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -315,12 +315,12 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		r->idiag_timer = 1;
 		r->idiag_retrans = icsk->icsk_retransmits;
 		r->idiag_expires =
-			jiffies_delta_to_msecs(icsk->icsk_timeout - jiffies);
+			jiffies_delta_to_msecs(icsk_timeout(icsk) - jiffies);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		r->idiag_timer = 4;
 		r->idiag_retrans = icsk->icsk_probes_out;
 		r->idiag_expires =
-			jiffies_delta_to_msecs(icsk->icsk_timeout - jiffies);
+			jiffies_delta_to_msecs(icsk_timeout(icsk) - jiffies);
 	} else if (timer_pending(&sk->sk_timer)) {
 		r->idiag_timer = 2;
 		r->idiag_retrans = icsk->icsk_probes_out;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4fa4fbb0ad12dba8b99f5698c74793743ba1bdaf..4ffc41990b6d271a356d9c5f208a9a927da39874 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2925,10 +2925,10 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active	= 1;
-		timer_expires	= icsk->icsk_timeout;
+		timer_expires	= icsk_timeout(icsk);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
-		timer_expires	= icsk->icsk_timeout;
+		timer_expires	= icsk_timeout(icsk);
 	} else if (timer_pending(&sk->sk_timer)) {
 		timer_active	= 2;
 		timer_expires	= sk->sk_timer.expires;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 728bce01ccd3ddb1f374fa96b86434a415dbe2cb..d828b74c3e73d75cdae777645e8e8856c0751201 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -509,7 +509,7 @@ static bool tcp_rtx_probe0_timed_out(const struct sock *sk,
 	 * and tp->rcv_tstamp might very well have been written recently.
 	 * rcv_delta can thus be negative.
 	 */
-	rcv_delta = icsk->icsk_timeout - tp->rcv_tstamp;
+	rcv_delta = icsk_timeout(icsk) - tp->rcv_tstamp;
 	if (rcv_delta <= timeout)
 		return false;
 
@@ -685,7 +685,8 @@ out:;
 }
 
 /* Called with bottom-half processing disabled.
-   Called by tcp_write_timer() */
+ * Called by tcp_write_timer() and tcp_release_cb().
+ */
 void tcp_write_timer_handler(struct sock *sk)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -695,11 +696,11 @@ void tcp_write_timer_handler(struct sock *sk)
 	    !icsk->icsk_pending)
 		return;
 
-	if (time_after(icsk->icsk_timeout, jiffies)) {
-		sk_reset_timer(sk, &icsk->icsk_retransmit_timer, icsk->icsk_timeout);
+	if (time_after(icsk_timeout(icsk), jiffies)) {
+		sk_reset_timer(sk, &icsk->icsk_retransmit_timer,
+			       icsk_timeout(icsk));
 		return;
 	}
-
 	tcp_mstamp_refresh(tcp_sk(sk));
 	event = icsk->icsk_pending;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e182ee0a233046468b14832b0e4730b2846e1d43..988111f09a3e2c8850a0ac551c3a50cf3bb22824 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2199,10 +2199,10 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active	= 1;
-		timer_expires	= icsk->icsk_timeout;
+		timer_expires	= icsk_timeout(icsk);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
-		timer_expires	= icsk->icsk_timeout;
+		timer_expires	= icsk_timeout(icsk);
 	} else if (timer_pending(&sp->sk_timer)) {
 		timer_active	= 2;
 		timer_expires	= sp->sk_timer.expires;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ad780ae1d30dcb6ff72960b340e1472a1400618a..1ac378ba1d67cd17449ab6c4b4793b65d520ec44 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -422,7 +422,7 @@ static long mptcp_timeout_from_subflow(const struct mptcp_subflow_context *subfl
 	const struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 	return inet_csk(ssk)->icsk_pending && !subflow->stale_count ?
-	       inet_csk(ssk)->icsk_timeout - jiffies : 0;
+	       icsk_timeout(inet_csk(ssk)) - jiffies : 0;
 }
 
 static void mptcp_set_timeout(struct sock *sk)
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
index d22449c69363afe3c3aaae158f0ef0c6ef65916c..164640db3a29cf720e193453cab79f4bc317917c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -99,10 +99,10 @@ static int dump_tcp_sock(struct seq_file *seq, struct tcp_sock *tp,
 	    icsk->icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk->icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active = 1;
-		timer_expires = icsk->icsk_timeout;
+		timer_expires = icsk->icsk_retransmit_timer.expires;
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active = 4;
-		timer_expires = icsk->icsk_timeout;
+		timer_expires = icsk->icsk_retransmit_timer.expires;
 	} else if (timer_pending(&sp->sk_timer)) {
 		timer_active = 2;
 		timer_expires = sp->sk_timer.expires;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
index 8b072666f9d9a0ce023e7cb2c2716bf4a5bd3905..591c703f5032f024e4b511a6af8d63d1233a042a 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -99,10 +99,10 @@ static int dump_tcp6_sock(struct seq_file *seq, struct tcp6_sock *tp,
 	    icsk->icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk->icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		timer_active = 1;
-		timer_expires = icsk->icsk_timeout;
+		timer_expires = icsk->icsk_retransmit_timer.expires;
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active = 4;
-		timer_expires = icsk->icsk_timeout;
+		timer_expires = icsk->icsk_retransmit_timer.expires;
 	} else if (timer_pending(&sp->sk_timer)) {
 		timer_active = 2;
 		timer_expires = sp->sk_timer.expires;
-- 
2.49.0.rc1.451.g8f38331e32-goog


