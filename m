Return-Path: <netdev+bounces-215972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFE5B312B3
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A863CA07F4D
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7677C29ACF0;
	Fri, 22 Aug 2025 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEyKivO2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D051DDC08
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854253; cv=none; b=ADd8Mc1s3OJRpvrA6IgR0vvhdv1ZH8szMV9vSjhm97dp2mcyRiZpkbRWId8i8Iez/95soZjKzdc4AypQbIzfTsIp3gSd5zgZLyG1J7F91ykT1BuCdOhsITLyAsJOeJwksqkczMRWfGxp5cyUwwDVTORAAW+N1OJKROSZ6I5XjR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854253; c=relaxed/simple;
	bh=VnPy40NVGyvsm8J77FAg5Kne48cLIIbBfaG7vS2Go8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eUtcJhlry8+trW58nu1HNlocKWnOIdF/3SaTpbEmvsqJlNUQH1tmp9Pk846G/QosuGSHW7Wmq11RZ3f6ViayEtOG6NpxEc6xULc/LTCYpOQ5jwRNgupGhU9ghi9tKz6EtTsTmP+Y3nhmFgzCCBv/VO8AmCVbAoNEeT3zAFd84v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEyKivO2; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e87031ae4dso243048985a.0
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755854250; x=1756459050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GQicBrhYGFoE8MccCE5SJiqQxm17dZqmXuLuPxTAf8U=;
        b=FEyKivO2h2+UCNoy8WuQI44fivlLnZ1rYKq9ZRJpNfuIxfdQY1WS8dtqG7qLKfQs43
         pe+HgT4fDs+GCYcEfDas68LRcUrs5pxDV5vl29KyXrAGUUcg8kQDZyAOj0t8gpYCHTb3
         tU9lKd51BkWvwupwWIlKAoMiypIC+yq7EQc97YjGCfWUywIZLZJLSxOcGdV5dz5dTWgj
         6xlZexNrVj/4Q3oi4oi1rgezPCUEkEUc55tQe7IvuYmRqh/1PhIjruw5x090Q39MVUky
         XHcex6weMZDcCKHL0KpfeXr9b63LSWkOCf/Zyl5lcyZH6FOyv8KpgtmTXM+Hl1K/OPhM
         +Olg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854250; x=1756459050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQicBrhYGFoE8MccCE5SJiqQxm17dZqmXuLuPxTAf8U=;
        b=ZfhRFlbPXKt34WoqgvNST5i22CvfbGl7Pwxd6tNXnNRVhoeteeU7jA9vfQBw7opOT2
         7Dgz0NDi+lRulVo9RNxS7V3/b0R/B77VCPbQVDMMXUTt9lBZRz8qkugMT6FJX2ShVI11
         CGZsf/WOBC2Z0LAA/Cw9ESq2i1+sMI+Ig5/JIKzoe/AwPMaGfgpqg+rdPiATI/MlJ0AX
         H2X2f4eoxxoWeE0RyJPEfNhp8Bec9fBXtab0orwyPK2WDqrUJ1hvbW8iIITfHkJ7DeEd
         cgMr6zlQ9mxeZVX3VUaEzTSS5gSJemb9oyd3dnd1uDXstFieA4b8NpCE8jhx4g8tHmVJ
         X5aA==
X-Forwarded-Encrypted: i=1; AJvYcCVkgu0ct8X0wqlKh+nPirNToWxLWKkwQkeqIsLYQvPBebHGhXiV3GFuH3mEahqDMxsXRcrbluI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSSYSGISQz5zKMFSREucebReecVssVjHEI24juvODlhTauucV
	9qVCYje7vyBIqm9vVe6tjBzzWy7S1Cd8kr2BSyrmxOKcv/mJ5Ffy89X4JwXFvUjonmjB+dVqTzi
	9K6FLgpY8hq6IPw==
X-Google-Smtp-Source: AGHT+IGSW4lg6v2wb9ITutlPo4M1U9R1ml1oLxr/lwZtIqJjbgxVN4S7RwrI8JhonfHBmueoeeXjyluroywWQA==
X-Received: from qknql4.prod.google.com ([2002:a05:620a:8904:b0:7e8:7b75:1ade])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a104:b0:7e8:1853:a40f with SMTP id af79cd13be357-7ea11068993mr281547785a.58.1755854250381;
 Fri, 22 Aug 2025 02:17:30 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:17:25 +0000
In-Reply-To: <20250822091727.835869-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822091727.835869-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822091727.835869-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: annotate data-races around icsk->icsk_retransmits
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icsk->icsk_retransmits is read locklessly from inet_sk_diag_fill(),
tcp_get_timestamping_opt_stats, get_tcp4_sock() and get_tcp6_sock().

Add corresponding READ_ONCE()/WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_diag.c  | 2 +-
 net/ipv4/tcp.c        | 3 ++-
 net/ipv4/tcp_input.c  | 6 +++---
 net/ipv4/tcp_ipv4.c   | 2 +-
 net/ipv4/tcp_output.c | 2 +-
 net/ipv4/tcp_timer.c  | 2 +-
 net/ipv6/tcp_ipv6.c   | 2 +-
 net/mptcp/protocol.c  | 3 ++-
 8 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 2fa53b16fe7788eed9796c8476157a77eced096c..35c1579e5bd4cef4a8c44d03ed1af16fe1735ac0 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -313,7 +313,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 	    icsk_pending == ICSK_TIME_REO_TIMEOUT ||
 	    icsk_pending == ICSK_TIME_LOSS_PROBE) {
 		r->idiag_timer = 1;
-		r->idiag_retrans = icsk->icsk_retransmits;
+		r->idiag_retrans = READ_ONCE(icsk->icsk_retransmits);
 		r->idiag_expires =
 			jiffies_delta_to_msecs(icsk_timeout(icsk) - jiffies);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 71a956fbfc5533224ee00e792de2cfdccd4d40aa..463281ad076fd3baeaee5f9131f0e2ffd947e90b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4348,7 +4348,8 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 	nla_put_u32(stats, TCP_NLA_REORDERING, tp->reordering);
 	nla_put_u32(stats, TCP_NLA_MIN_RTT, tcp_min_rtt(tp));
 
-	nla_put_u8(stats, TCP_NLA_RECUR_RETRANS, inet_csk(sk)->icsk_retransmits);
+	nla_put_u8(stats, TCP_NLA_RECUR_RETRANS,
+		   READ_ONCE(inet_csk(sk)->icsk_retransmits));
 	nla_put_u8(stats, TCP_NLA_DELIVERY_RATE_APP_LMT, !!tp->rate_app_limited);
 	nla_put_u32(stats, TCP_NLA_SND_SSTHRESH, tp->snd_ssthresh);
 	nla_put_u32(stats, TCP_NLA_DELIVERED, tp->delivered);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 71b76e98371a667b6e8263b32c242363672d7c5a..87f06e5acfe86411f5ea68e565f0c2bf4794ed53 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2569,7 +2569,7 @@ static bool tcp_try_undo_loss(struct sock *sk, bool frto_undo)
 		if (frto_undo)
 			NET_INC_STATS(sock_net(sk),
 					LINUX_MIB_TCPSPURIOUSRTOS);
-		inet_csk(sk)->icsk_retransmits = 0;
+		WRITE_ONCE(inet_csk(sk)->icsk_retransmits, 0);
 		if (tcp_is_non_sack_preventing_reopen(sk))
 			return true;
 		if (frto_undo || tcp_is_sack(tp)) {
@@ -3851,7 +3851,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	if (after(ack, prior_snd_una)) {
 		flag |= FLAG_SND_UNA_ADVANCED;
-		icsk->icsk_retransmits = 0;
+		WRITE_ONCE(icsk->icsk_retransmits, 0);
 
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
 		if (static_branch_unlikely(&clean_acked_data_enabled.key))
@@ -6636,7 +6636,7 @@ static void tcp_rcv_synrecv_state_fastopen(struct sock *sk)
 		tcp_try_undo_recovery(sk);
 
 	tcp_update_rto_time(tp);
-	inet_csk(sk)->icsk_retransmits = 0;
+	WRITE_ONCE(inet_csk(sk)->icsk_retransmits, 0);
 	/* In tcp_fastopen_synack_timer() on the first SYNACK RTO we set
 	 * retrans_stamp but don't enter CA_Loss, so in case that happened we
 	 * need to zero retrans_stamp here to prevent spurious
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 84d3d556ed8062d07fe7019bc0dadd90d3b80d96..5d549dfd4e601eedb7c5cc3f3e503a5bef7ed4a4 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2958,7 +2958,7 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 		rx_queue,
 		timer_active,
 		jiffies_delta_to_clock_t(timer_expires - jiffies),
-		icsk->icsk_retransmits,
+		READ_ONCE(icsk->icsk_retransmits),
 		from_kuid_munged(seq_user_ns(f), sk_uid(sk)),
 		icsk->icsk_probes_out,
 		sock_i_ino(sk),
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index dfbac0876d96ee6b556fff5b6c9ec8fe2e04aa05..8623def6f88921130e1944f03eb5408e9e26120d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3954,7 +3954,7 @@ static void tcp_connect_init(struct sock *sk)
 	WRITE_ONCE(tp->copied_seq, tp->rcv_nxt);
 
 	inet_csk(sk)->icsk_rto = tcp_timeout_init(sk);
-	inet_csk(sk)->icsk_retransmits = 0;
+	WRITE_ONCE(inet_csk(sk)->icsk_retransmits, 0);
 	tcp_clear_retrans(tp);
 }
 
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index a207877270fbdef6f86f61093aa476b6cd6f8706..8b11ab4cc9524f0e0066f474044a4c585115ec29 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -444,7 +444,7 @@ static void tcp_update_rto_stats(struct sock *sk)
 		tp->total_rto_recoveries++;
 		tp->rto_stamp = tcp_time_stamp_ms(tp);
 	}
-	icsk->icsk_retransmits++;
+	WRITE_ONCE(icsk->icsk_retransmits, icsk->icsk_retransmits + 1);
 	tp->total_rto++;
 }
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7577e7eb2c97b821826f633a11dd5567dde7b7cb..7b177054452b983d3f49a06869950565c03c13ee 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2230,7 +2230,7 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 		   rx_queue,
 		   timer_active,
 		   jiffies_delta_to_clock_t(timer_expires - jiffies),
-		   icsk->icsk_retransmits,
+		   READ_ONCE(icsk->icsk_retransmits),
 		   from_kuid_munged(seq_user_ns(seq), sk_uid(sp)),
 		   icsk->icsk_probes_out,
 		   sock_i_ino(sp),
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9a287b75c1b31bac9c35581db996e39e594872e0..f2e728239480444ffdb297efc35303848d4c4a31 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2587,7 +2587,8 @@ static void __mptcp_retrans(struct sock *sk)
 		if (mptcp_data_fin_enabled(msk)) {
 			struct inet_connection_sock *icsk = inet_csk(sk);
 
-			icsk->icsk_retransmits++;
+			WRITE_ONCE(icsk->icsk_retransmits,
+				   icsk->icsk_retransmits + 1);
 			mptcp_set_datafin_timeout(sk);
 			mptcp_send_ack(msk);
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


