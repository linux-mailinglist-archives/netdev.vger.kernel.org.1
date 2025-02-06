Return-Path: <netdev+bounces-163462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A516FA2A4ED
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DF73A0FC6
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5FF2144BE;
	Thu,  6 Feb 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/SOOhto"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC13224884
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738835169; cv=none; b=TBYKKPFNEbqP1R98Z6WXDMBQFhxBQJWJGqP1Q4CZcY+Y5LTBkwCz+RaL/TYPE1AE5EB5obRPH0vJHhNOIB8AslAlcP+kYfaocy5ZLuSSHvDf2nmESR7Mt3FaFMHmtaEJWZSJW2iLF10bl7zQUyfr+FGbJSRBU1Rs8aLe3fNrHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738835169; c=relaxed/simple;
	bh=ahJsj9lCWHxFn3mifUi7FqVQFk0LrPuPDphJUVHIJWY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CqQJFcJmjVx9UysAH1tvaYNozJO+doMYt57hkVVekTRD6Ek0TeEEIUfwsj+LaFVvD5cPKWYHyev2/kGVkSZBGWnLNUl0Z5lFytXB/x0UBXyBO7WwTlF8bscw595LjV6nMlxyfSYherbhcWKlnKgv4gocmERWUymUkM71UaODtoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/SOOhto; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-4aff533abadso545533137.1
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738835166; x=1739439966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1TLui7ZoX1mh7mNH8kbsMHKi+iUodA6ID1dg3nxOBEQ=;
        b=X/SOOhtoavkJkyUHeQ0wH77fqqB1ZHzbNXB6f+hfpRY4yUsV4dF+bLOQDuVV28drz8
         YUjhn9dC3kG5M95ClQhSXresXBDJspwYV4jh9VL0MZeqkJi+RUuBV7CiIvvn471xdKrm
         gNLZeYLkgwVM+KTgzvUoziNqMA0huODRSK4GMMH57ocCrnq4MnQk2APQyk+LiqkE5HXS
         DzsWKhY0yrCzq21bvqQjn0RVgCSPXWpoR/YjrCCYkoBuVgV8ghCwwuYwl/1bdo/8FGe0
         qtGesGevDUhRyzyVlD7sdoLO56sPYyXj8o3hy1ZeoEXVm6TBD2s36qBkVxcWtscX4sO3
         rPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738835166; x=1739439966;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TLui7ZoX1mh7mNH8kbsMHKi+iUodA6ID1dg3nxOBEQ=;
        b=LuUH0MhM8KwrgN+Z0snE/hH6dWSMJ2z7f5PLQIsfZBwQz27pA4YzuBh5tmy6ssOZTg
         TiSeTI/YXCth7E+u3HPssoa19WzFLf0Ogy2SrzYLlo+5gHpsMqRiLBrxn4WgWqv4j/S4
         7rU9t3o19Tl6dkom4QCy5QWv0kcgEaaKqeU834wmMhm7zPsi05v+U+p/BjmOYNqHt2Ab
         TiL9Fe/o3su6kFng5M/fnNS5RdWhjr1fNx7kxtI+3KKKknXP7tHrYjjINXdOGqerbWMQ
         4lLxYjEzBEQZzP/6dKS08MpeNivNiy4HFih0M/I5DlcmhUp161HU/+dhndeTlN+fuIFS
         aaeg==
X-Gm-Message-State: AOJu0Yw8zlg1fCBMdr2ieFv9/5FjIaKxbGHPN9ON8JwIxNRo9z6CPp/T
	qTuV9eCx8D/bUn2Ec1KrBJezoSRIU7jVAJ6s4e4I5lUiUjOU1XCbzBlbEhQq22xhtNCVNGaS9yq
	yRlKkjFxyXA==
X-Google-Smtp-Source: AGHT+IH6WLVd9pShTel9R0VS13j5kDlXoGvswjYZzsQHv6rG6OPbGJjN0nSHasFuG6OXJZYoU2yUbtIYnujTKg==
X-Received: from vsvj37.prod.google.com ([2002:a05:6102:3e25:b0:4b2:cc7a:f725])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:3a10:b0:4b9:d187:aa90 with SMTP id ada2fe7eead31-4ba4791e78amr4096072137.8.1738835166508;
 Thu, 06 Feb 2025 01:46:06 -0800 (PST)
Date: Thu,  6 Feb 2025 09:46:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250206094605.2694118-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: rename inet_csk_{delete|reset}_keepalive_timer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Neal Cardwell <ncardwell@google.com>, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_csk_delete_keepalive_timer() and inet_csk_reset_keepalive_timer()
are only used from core TCP, there is no need to export them.

Replace their prefix by tcp.

Move them to net/ipv4/tcp_timer.c and make tcp_delete_keepalive_timer()
static.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_connection_sock.h |  3 ---
 include/net/tcp.h                  |  1 +
 net/ipv4/inet_connection_sock.c    | 12 ------------
 net/ipv4/tcp.c                     |  4 ++--
 net/ipv4/tcp_input.c               |  6 +++---
 net/ipv4/tcp_minisocks.c           |  3 +--
 net/ipv4/tcp_timer.c               | 21 +++++++++++++++------
 7 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index c7f42844c79a9bde6d77c457f392229b1d3a9d5c..055aa80b05c6da8c36b6acf2709ee116136918e6 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -189,9 +189,6 @@ static inline void inet_csk_delack_init(struct sock *sk)
 	memset(&inet_csk(sk)->icsk_ack, 0, sizeof(inet_csk(sk)->icsk_ack));
 }
 
-void inet_csk_delete_keepalive_timer(struct sock *sk);
-void inet_csk_reset_keepalive_timer(struct sock *sk, unsigned long timeout);
-
 static inline void inet_csk_clear_xmit_timer(struct sock *sk, const int what)
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5b2b04835688f65daa25ca208e29775326520e1e..bb7edf0e72aa077ed4de02c6e7cd7048976d8a1e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -415,6 +415,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		      sockptr_t optval, unsigned int optlen);
 int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		   unsigned int optlen);
+void tcp_reset_keepalive_timer(struct sock *sk, unsigned long timeout);
 void tcp_set_keepalive(struct sock *sk, int val);
 void tcp_syn_ack_timeout(const struct request_sock *req);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e4decfb270fa1f9c81da76566c056dd5ce5b0447..2b7775b90a0907727fa3e4d04cfa77f6e76e82b0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -799,18 +799,6 @@ void inet_csk_clear_xmit_timers_sync(struct sock *sk)
 	sk_stop_timer_sync(sk, &sk->sk_timer);
 }
 
-void inet_csk_delete_keepalive_timer(struct sock *sk)
-{
-	sk_stop_timer(sk, &sk->sk_timer);
-}
-EXPORT_SYMBOL(inet_csk_delete_keepalive_timer);
-
-void inet_csk_reset_keepalive_timer(struct sock *sk, unsigned long len)
-{
-	sk_reset_timer(sk, &sk->sk_timer, jiffies + len);
-}
-EXPORT_SYMBOL(inet_csk_reset_keepalive_timer);
-
 struct dst_entry *inet_csk_route_req(const struct sock *sk,
 				     struct flowi4 *fl4,
 				     const struct request_sock *req)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0d704bda6c416bd722223eb19bec5667df4e7bb7..4136535cd984d85c615a615f8991ce55ad5af42d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3174,7 +3174,7 @@ void __tcp_close(struct sock *sk, long timeout)
 			const int tmo = tcp_fin_time(sk);
 
 			if (tmo > TCP_TIMEWAIT_LEN) {
-				inet_csk_reset_keepalive_timer(sk,
+				tcp_reset_keepalive_timer(sk,
 						tmo - TCP_TIMEWAIT_LEN);
 			} else {
 				tcp_time_wait(sk, TCP_FIN_WAIT2, tmo);
@@ -3627,7 +3627,7 @@ int tcp_sock_set_keepidle_locked(struct sock *sk, int val)
 			elapsed = tp->keepalive_time - elapsed;
 		else
 			elapsed = 0;
-		inet_csk_reset_keepalive_timer(sk, elapsed);
+		tcp_reset_keepalive_timer(sk, elapsed);
 	}
 
 	return 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index eb82e01da911048b41ca380f913ef55566be79a7..f6b925985b802e0ce6811bd77ff8497c6fc9b055 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6347,7 +6347,7 @@ void tcp_finish_connect(struct sock *sk, struct sk_buff *skb)
 	tp->lsndtime = tcp_jiffies32;
 
 	if (sock_flag(sk, SOCK_KEEPOPEN))
-		inet_csk_reset_keepalive_timer(sk, keepalive_time_when(tp));
+		tcp_reset_keepalive_timer(sk, keepalive_time_when(tp));
 
 	if (!tp->rx_opt.snd_wscale)
 		__tcp_fast_path_on(tp, tp->snd_wnd);
@@ -6922,7 +6922,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 		tmo = tcp_fin_time(sk);
 		if (tmo > TCP_TIMEWAIT_LEN) {
-			inet_csk_reset_keepalive_timer(sk, tmo - TCP_TIMEWAIT_LEN);
+			tcp_reset_keepalive_timer(sk, tmo - TCP_TIMEWAIT_LEN);
 		} else if (th->fin || sock_owned_by_user(sk)) {
 			/* Bad case. We could lose such FIN otherwise.
 			 * It is not a big problem, but it looks confusing
@@ -6930,7 +6930,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			 * if it spins in bh_lock_sock(), but it is really
 			 * marginal case.
 			 */
-			inet_csk_reset_keepalive_timer(sk, tmo);
+			tcp_reset_keepalive_timer(sk, tmo);
 		} else {
 			tcp_time_wait(sk, TCP_FIN_WAIT2, tmo);
 			goto consume;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index b089b08e9617862cd73b47ac06b5ac6c1e843ec6..0deb2ac85acf7a9e8377e97915087afec6f8a835 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -566,8 +566,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	WRITE_ONCE(newtp->write_seq, newtp->pushed_seq = treq->snt_isn + 1);
 
 	if (sock_flag(newsk, SOCK_KEEPOPEN))
-		inet_csk_reset_keepalive_timer(newsk,
-					       keepalive_time_when(newtp));
+		tcp_reset_keepalive_timer(newsk, keepalive_time_when(newtp));
 
 	newtp->rx_opt.tstamp_ok = ireq->tstamp_ok;
 	newtp->rx_opt.sack_ok = ireq->sack_ok;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index b412ed88ccd9a81a2689cf38f13899551b1078e3..cfb6f4c4e4c9fc3eb6963dcb659b2c6489193dd9 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -751,20 +751,29 @@ void tcp_syn_ack_timeout(const struct request_sock *req)
 }
 EXPORT_SYMBOL(tcp_syn_ack_timeout);
 
+void tcp_reset_keepalive_timer(struct sock *sk, unsigned long len)
+{
+	sk_reset_timer(sk, &sk->sk_timer, jiffies + len);
+}
+
+static void tcp_delete_keepalive_timer(struct sock *sk)
+{
+	sk_stop_timer(sk, &sk->sk_timer);
+}
+
 void tcp_set_keepalive(struct sock *sk, int val)
 {
 	if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
 		return;
 
 	if (val && !sock_flag(sk, SOCK_KEEPOPEN))
-		inet_csk_reset_keepalive_timer(sk, keepalive_time_when(tcp_sk(sk)));
+		tcp_reset_keepalive_timer(sk, keepalive_time_when(tcp_sk(sk)));
 	else if (!val)
-		inet_csk_delete_keepalive_timer(sk);
+		tcp_delete_keepalive_timer(sk);
 }
 EXPORT_SYMBOL_GPL(tcp_set_keepalive);
 
-
-static void tcp_keepalive_timer (struct timer_list *t)
+static void tcp_keepalive_timer(struct timer_list *t)
 {
 	struct sock *sk = from_timer(sk, t, sk_timer);
 	struct inet_connection_sock *icsk = inet_csk(sk);
@@ -775,7 +784,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
 		/* Try again later. */
-		inet_csk_reset_keepalive_timer (sk, HZ/20);
+		tcp_reset_keepalive_timer(sk, HZ/20);
 		goto out;
 	}
 
@@ -841,7 +850,7 @@ static void tcp_keepalive_timer (struct timer_list *t)
 	}
 
 resched:
-	inet_csk_reset_keepalive_timer (sk, elapsed);
+	tcp_reset_keepalive_timer(sk, elapsed);
 	goto out;
 
 death:
-- 
2.48.1.362.g079036d154-goog


