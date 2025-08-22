Return-Path: <netdev+bounces-215973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A04FB312B5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA331CE5B5F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACEF2E229D;
	Fri, 22 Aug 2025 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYMLZGXC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DBE137750
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854254; cv=none; b=Y2FJZZXGXYhuAhQkz3yQ+LfNjSP/9hOHwZdnxxkoENYK3hLlEDBserY2zAyOUAjkAZUpzlwyTKPYhqHB5SxEPS+KkNjIj9Of0saPEQWkBivIgq+/kyubJ3azmYcr62xliq99W1GE+nYzAfW4IY0jnCs+//uDWnTuOdPWbS9L+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854254; c=relaxed/simple;
	bh=REjm4nA2TUzpHoap4H5khwfh+SvKTyHKudy+Zz8EVL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=paOUXHDhZW+JITh4OM4FCtsdh159Yj3avX4MlQXw4XmWHRtt0xjtZDxJGvEguLOQce+Y+MlSHfMEhQBD2/768n7YMTJl/CxgC26yl/Oxv85t72YWpwAtwfzDpgOIr4EsAStsxLgOr9fYY7KTzgt6mWwDzGSBhGDdvdVddYgRYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYMLZGXC; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e8706abd44so498970785a.3
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755854252; x=1756459052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQGF0xufyj7fD1wLix704tYmZLDP2pGOhJlJ/cLw3Gs=;
        b=TYMLZGXCjG1cbhhI4cwL6fvxUZTxKQf70bzc3oc2y3hcSJnf9tWgHYFfFfHj54cWh+
         WG6TjhQUbLGWq84Pwni7njMtxr17P+qJ7RidHCOBVVp5bUjVxxsH45dZM6Lqu0TtPFsL
         2QiT4svoA9JDMMd0g59WJvpYsaBu58m+zsauH4Pv8fA8ncld6pYuAKxh+ewluus/1ZiV
         ITu/8M1mTjf0G63a7GsKl7M0dnDZhaCn+lI5E4cqgqy0oh4vsU8gwnlwEfG/h6+WWQj4
         I2yekWs6meYBkrODsHv0JUbaJlL1CfIvbw30QYqkh7DGJMSN7FLzNtb514oP0M68NInH
         sp6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854252; x=1756459052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQGF0xufyj7fD1wLix704tYmZLDP2pGOhJlJ/cLw3Gs=;
        b=jNXyZFi/Uy0S8fzJgd8qG6e0FpV7If+0mB5ZSRNG91nfJEZs2lzbL4IeKtFBl46eMk
         b+Q3ObQ61c/T6D+xVCkvgCPrHXGQTeJqx1byVOBB/RD3QqBnkbg956hB5p6mf4eS8peE
         InC2aSxJ/JglEgfLiPEIFmQ+IZODw1cqlyUAMTYjPufnI8p7jJ8271dX1Io1Ka+v7xTg
         95bIP+mMUX8UEacwPaHVjJt3S5qr7m7CISBYL7+Ni3OAZlYLeVUdnq/7u9v6EJUmUbWp
         fpv3aSU5uUJPKsJtK04c9KdjMJmuOiXZ5yov6VC/sG5/TxEngnIOz4BJaa+Jawl5gJhC
         TGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl7MuNMVoldWl1Zi92LP4o67MczrsvcnSIfLwqMl0L6pBSaXsfLq3PHr/dOGWyejrc4KXHC68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3CxSo43Stjn4TCiPjD7rKFXOGgwr6ucP6uVRK3PVpcNsEvuso
	0nUaHptFAbYpzHLzWBBCSHEz4mLsmynsWmG+axpJ/FOyMUBPRb9c2Ef0DIQ0FAXcqjQm2xTeeLB
	SSjCC4nQfC3l1sg==
X-Google-Smtp-Source: AGHT+IEgEGtNQu9W7WYoTZmtpAFIwJHWvyeUZKFO+MRw2LHTik9pPlgqhRSMPFulTkz8uJx3GqsN1IYzqwpw+A==
X-Received: from qkbdx6.prod.google.com ([2002:a05:620a:6086:b0:7e9:fd78:237])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a110:b0:7e6:9332:356a with SMTP id af79cd13be357-7ea11096afcmr238015285a.45.1755854251866;
 Fri, 22 Aug 2025 02:17:31 -0700 (PDT)
Date: Fri, 22 Aug 2025 09:17:26 +0000
In-Reply-To: <20250822091727.835869-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822091727.835869-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822091727.835869-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp: annotate data-races around icsk->icsk_probes_out
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

icsk->icsk_probes_out is read locklessly from inet_sk_diag_fill(),
get_tcp4_sock() and get_tcp6_sock().

Add corresponding READ_ONCE()/WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inet_diag.c  | 4 ++--
 net/ipv4/tcp.c        | 2 +-
 net/ipv4/tcp_input.c  | 2 +-
 net/ipv4/tcp_ipv4.c   | 2 +-
 net/ipv4/tcp_output.c | 4 ++--
 net/ipv4/tcp_timer.c  | 4 ++--
 net/ipv6/tcp_ipv6.c   | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 35c1579e5bd4cef4a8c44d03ed1af16fe1735ac0..549f1f521f4f6f9e5fe347767ed0f98f4aa9b62a 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -318,12 +318,12 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 			jiffies_delta_to_msecs(icsk_timeout(icsk) - jiffies);
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		r->idiag_timer = 4;
-		r->idiag_retrans = icsk->icsk_probes_out;
+		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
 		r->idiag_expires =
 			jiffies_delta_to_msecs(icsk_timeout(icsk) - jiffies);
 	} else if (timer_pending(&sk->sk_timer)) {
 		r->idiag_timer = 2;
-		r->idiag_retrans = icsk->icsk_probes_out;
+		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
 		r->idiag_expires =
 			jiffies_delta_to_msecs(sk->sk_timer.expires - jiffies);
 	}
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 463281ad076fd3baeaee5f9131f0e2ffd947e90b..676b23d6fef9198361afd75bb161454e99aaefdc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3376,7 +3376,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(tp->write_seq, seq);
 
 	icsk->icsk_backoff = 0;
-	icsk->icsk_probes_out = 0;
+	WRITE_ONCE(icsk->icsk_probes_out, 0);
 	icsk->icsk_probes_tstamp = 0;
 	icsk->icsk_rto = TCP_TIMEOUT_INIT;
 	WRITE_ONCE(icsk->icsk_rto_min, TCP_RTO_MIN);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 87f06e5acfe86411f5ea68e565f0c2bf4794ed53..29b1ab0bde59fd5e0237c233f5a50258ce7ab39f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3913,7 +3913,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	 * log. Something worked...
 	 */
 	WRITE_ONCE(sk->sk_err_soft, 0);
-	icsk->icsk_probes_out = 0;
+	WRITE_ONCE(icsk->icsk_probes_out, 0);
 	tp->rcv_tstamp = tcp_jiffies32;
 	if (!prior_packets)
 		goto no_queue;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5d549dfd4e601eedb7c5cc3f3e503a5bef7ed4a4..9543f153835908286384defa787e2a707fb8dbda 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2960,7 +2960,7 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 		jiffies_delta_to_clock_t(timer_expires - jiffies),
 		READ_ONCE(icsk->icsk_retransmits),
 		from_kuid_munged(seq_user_ns(f), sk_uid(sk)),
-		icsk->icsk_probes_out,
+		READ_ONCE(icsk->icsk_probes_out),
 		sock_i_ino(sk),
 		refcount_read(&sk->sk_refcnt), sk,
 		jiffies_to_clock_t(icsk->icsk_rto),
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8623def6f88921130e1944f03eb5408e9e26120d..5bd4e52c397fe5a9a070c06e0cce20a767718550 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4392,13 +4392,13 @@ void tcp_send_probe0(struct sock *sk)
 
 	if (tp->packets_out || tcp_write_queue_empty(sk)) {
 		/* Cancel probe timer, if it is not required. */
-		icsk->icsk_probes_out = 0;
+		WRITE_ONCE(icsk->icsk_probes_out, 0);
 		icsk->icsk_backoff = 0;
 		icsk->icsk_probes_tstamp = 0;
 		return;
 	}
 
-	icsk->icsk_probes_out++;
+	WRITE_ONCE(icsk->icsk_probes_out, icsk->icsk_probes_out + 1);
 	if (err <= 0) {
 		if (icsk->icsk_backoff < READ_ONCE(net->ipv4.sysctl_tcp_retries2))
 			icsk->icsk_backoff++;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 8b11ab4cc9524f0e0066f474044a4c585115ec29..2dd73a4e8e517ab46d69ab655a6b1a9cbcaf7c1e 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -392,7 +392,7 @@ static void tcp_probe_timer(struct sock *sk)
 	int max_probes;
 
 	if (tp->packets_out || !skb) {
-		icsk->icsk_probes_out = 0;
+		WRITE_ONCE(icsk->icsk_probes_out, 0);
 		icsk->icsk_probes_tstamp = 0;
 		return;
 	}
@@ -839,7 +839,7 @@ static void tcp_keepalive_timer(struct timer_list *t)
 			goto out;
 		}
 		if (tcp_write_wakeup(sk, LINUX_MIB_TCPKEEPALIVE) <= 0) {
-			icsk->icsk_probes_out++;
+			WRITE_ONCE(icsk->icsk_probes_out, icsk->icsk_probes_out + 1);
 			elapsed = keepalive_intvl_when(tp);
 		} else {
 			/* If keepalive was lost due to local congestion,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7b177054452b983d3f49a06869950565c03c13ee..5620d9e50e195894fb0289d5bb8963579e14429e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2232,7 +2232,7 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 		   jiffies_delta_to_clock_t(timer_expires - jiffies),
 		   READ_ONCE(icsk->icsk_retransmits),
 		   from_kuid_munged(seq_user_ns(seq), sk_uid(sp)),
-		   icsk->icsk_probes_out,
+		   READ_ONCE(icsk->icsk_probes_out),
 		   sock_i_ino(sp),
 		   refcount_read(&sp->sk_refcnt), sp,
 		   jiffies_to_clock_t(icsk->icsk_rto),
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


