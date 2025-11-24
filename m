Return-Path: <netdev+bounces-241244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6026C81FA1
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8602C3AA2FA
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D431355F;
	Mon, 24 Nov 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzbE4ivp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2AF4F1
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006621; cv=none; b=JWbvJG5EeyGhwGWq9GOLr+uJC5d8JJwM1Y+jXs+5D1bukcCAkoddM1njppggO1MQJjIc6J+u31hJz48Pxf8Yv5EgjpBstoH7nuCJfqPu/7JxzGkCiU4OvMssWQ0FAbRZ+LUC4LcO5NtFh4/U8gk1/qeVATgc3s03BewuUgjQOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006621; c=relaxed/simple;
	bh=G4H/4xZhDHrwdW1mehc6MfHb2NVI72f4L/55dnYJVrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p+hhXfDvgFSo6sf/mB2mr0yjRl9/dCae41KhnXbi5Di/nTfJ3d1ofCLNr+dxiNQz45yFIU6rL9Qzwrsj/JsDn+ZiAUov/ou0xalGAwuXVGgqCHDIP5/LU15q/rjhsuqSDXmaBUS1/YRFfeUtg/p6aLMZVOs/IxgsyrNy7nEfAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QzbE4ivp; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8824292911cso131700576d6.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 09:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764006618; x=1764611418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xR3rOKJX1I9HyfvOpJdBk9JM2cqpGjNrAZ+xfOB8/Jw=;
        b=QzbE4ivps1j++lF5PAAp5tyxFxP0+ekeil2Uwso4z2bAWh8pxOL8mHr/N/hVHjJi5j
         dC8uftIWi2w5Io5rjTWynacYX/OhJqO0iKIlbznx2PHsdYPSvz5t13EgM+34+KhaBBcA
         VZhyf6k5nalxJVuw1l5kaC8uLAQhfkvocUu0Q1oM33dunAJSfIHWnczbxThPe0xqBiZH
         P6/O9uy/f1S+vM6hB3MNduxZxKi25rZqIqYZ/tyFLwRAg9FnYq5H0uWceQKuHKv1Och6
         YqGQacJNsuFxXIbh63PnkczDmEzvFYGDZ2Ow2DalYm/NGzOxmCTLwJ5krnK3HQ2NQmVo
         Zp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006618; x=1764611418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xR3rOKJX1I9HyfvOpJdBk9JM2cqpGjNrAZ+xfOB8/Jw=;
        b=S+OV2jaDSQUDQxwhRKkDedXmoYvWGUefP+Hw9eeMnpoIkMZBFHDse38jg/TVXDIem/
         us//jOD9rs3MtLf8LWueFV2LxD6dJpPWSjcg1ERcoV9vg+5zVKGK6Z1y+uEzz53B+anE
         mFjqcPshX1uo2VIP+6YFU6byXkofQXPTW1Vl+oJ+2aTZGVaFziGKWxOoC/UYmzZVCs/H
         YNLeJTHd6ijRHq5cCnp5YEzKokXW7Nt63wxwioxcpptej4snUYzv6QHx1UKUrL8siXVy
         OV8ZKfzY0luYENRZOVjKtQDThN52nFV/kte8ZVcZTD9zFGXtYiEayyCd5ryMM+xY8kn/
         wYjw==
X-Forwarded-Encrypted: i=1; AJvYcCULWU7eolpI+rDysrgUPhKwJHAiw+pcVccvzSizEke1QqkXm2p0Je/bODOSLiSEpZ41IY4ekIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0AwvS0ttN22LuRittPXc50p6/3XkM2Dz5RiCH66sK7wjTDFn
	2VKVNBp3gnT5CMYpBy+OtOeMzPdrmGwnBGZqIQyawGyybitWGqVIuLPQvafX3oPh6F4fNH/kaTV
	CW+B+PP4yTn8rTg==
X-Google-Smtp-Source: AGHT+IH+/z+ZUkbZmRf45a5fGPXP25B27K3zrbZYOe6Due8/grpRmifrHuwXnCcDwR1qpTBwevsKXwh5WO/pew==
X-Received: from qvbks5.prod.google.com ([2002:a05:6214:3105:b0:882:46f7:ecf1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:ca4:b0:882:49e5:64f9 with SMTP id 6a1803df08f44-884700c5bafmr279248826d6.13.1764006618223;
 Mon, 24 Nov 2025 09:50:18 -0800 (PST)
Date: Mon, 24 Nov 2025 17:50:12 +0000
In-Reply-To: <20251124175013.1473655-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251124175013.1473655-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124175013.1473655-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] tcp: introduce icsk->icsk_keepalive_timer
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sk->sk_timer has been used for TCP keepalives.

Keepalive timers are not in fast path, we want to use sk->sk_timer
storage for retransmit timers, for better cache locality.

Create icsk->icsk_keepalive_timer and change keepalive
code to no longer use sk->sk_timer.

Added space is reclaimed in the following patch.

This includes changes to MPTCP, which was also using sk_timer.

Alias icsk->mptcp_tout_timer and icsk->icsk_keepalive_timer
for inet_sk_diag_fill() sake.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net_cachelines/inet_connection_sock.rst           |  1 +
 include/net/inet_connection_sock.h                    | 11 +++++++++--
 net/ipv4/inet_connection_sock.c                       |  6 +++---
 net/ipv4/inet_diag.c                                  |  4 ++--
 net/ipv4/tcp_ipv4.c                                   |  4 ++--
 net/ipv4/tcp_timer.c                                  |  9 +++++----
 net/ipv6/tcp_ipv6.c                                   |  4 ++--
 net/mptcp/protocol.c                                  | 10 ++++++----
 net/mptcp/protocol.h                                  |  2 +-
 tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c     |  4 ++--
 tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c     |  4 ++--
 11 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/Documentation/networking/net_cachelines/inet_connection_sock.rst b/Documentation/networking/net_cachelines/inet_connection_sock.rst
index 8fae85ebb773085b249c606ce37872e0566b70b4..4f65de2def8c9ccef1108f8f3a3de1d8c12b8497 100644
--- a/Documentation/networking/net_cachelines/inet_connection_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_connection_sock.rst
@@ -14,6 +14,7 @@ struct inet_bind_bucket             icsk_bind_hash         read_mostly
 struct inet_bind2_bucket            icsk_bind2_hash        read_mostly                             tcp_set_state,inet_put_port
 struct timer_list                   icsk_retransmit_timer  read_write                              inet_csk_reset_xmit_timer,tcp_connect
 struct timer_list                   icsk_delack_timer      read_mostly                             inet_csk_reset_xmit_timer,tcp_connect
+struct timer_list                   icsk_keepalive_timer
 u32                                 icsk_rto               read_write                              tcp_cwnd_validate,tcp_schedule_loss_probe,tcp_connect_init,tcp_connect,tcp_write_xmit,tcp_push_one
 u32                                 icsk_rto_min
 u32                                 icsk_rto_max           read_mostly                             tcp_reset_xmit_timer
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index 765c2149d6787ef1063e5f29d78547ec6ca79746..e0d90b996348d895256191a5f10275d8f3f3a69a 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -57,6 +57,9 @@ struct inet_connection_sock_af_ops {
  * @icsk_bind_hash:	   Bind node
  * @icsk_bind2_hash:	   Bind node in the bhash2 table
  * @icsk_retransmit_timer: Resend (no ack)
+ * @icsk_delack_timer:     Delayed ACK timer
+ * @icsk_keepalive_timer:  Keepalive timer
+ * @mptcp_tout_timer: mptcp timer
  * @icsk_rto:		   Retransmit timeout
  * @icsk_pmtu_cookie	   Last pmtu seen by socket
  * @icsk_ca_ops		   Pluggable congestion control hook
@@ -81,8 +84,12 @@ struct inet_connection_sock {
 	struct request_sock_queue icsk_accept_queue;
 	struct inet_bind_bucket	  *icsk_bind_hash;
 	struct inet_bind2_bucket  *icsk_bind2_hash;
- 	struct timer_list	  icsk_retransmit_timer;
- 	struct timer_list	  icsk_delack_timer;
+	struct timer_list	  icsk_retransmit_timer;
+	struct timer_list	  icsk_delack_timer;
+	union {
+		struct timer_list icsk_keepalive_timer;
+		struct timer_list mptcp_tout_timer;
+	};
 	__u32			  icsk_rto;
 	__u32                     icsk_rto_min;
 	u32			  icsk_rto_max;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index b4eae731c9ba5693b38ee063decaa6fd776d9b8b..4fc09f9bf25d59e8155107eba391f5c566f290a0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -739,7 +739,7 @@ void inet_csk_init_xmit_timers(struct sock *sk,
 
 	timer_setup(&icsk->icsk_retransmit_timer, retransmit_handler, 0);
 	timer_setup(&icsk->icsk_delack_timer, delack_handler, 0);
-	timer_setup(&sk->sk_timer, keepalive_handler, 0);
+	timer_setup(&icsk->icsk_keepalive_timer, keepalive_handler, 0);
 	icsk->icsk_pending = icsk->icsk_ack.pending = 0;
 }
 
@@ -752,7 +752,7 @@ void inet_csk_clear_xmit_timers(struct sock *sk)
 
 	sk_stop_timer(sk, &icsk->icsk_retransmit_timer);
 	sk_stop_timer(sk, &icsk->icsk_delack_timer);
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_stop_timer(sk, &icsk->icsk_keepalive_timer);
 }
 
 void inet_csk_clear_xmit_timers_sync(struct sock *sk)
@@ -767,7 +767,7 @@ void inet_csk_clear_xmit_timers_sync(struct sock *sk)
 
 	sk_stop_timer_sync(sk, &icsk->icsk_retransmit_timer);
 	sk_stop_timer_sync(sk, &icsk->icsk_delack_timer);
-	sk_stop_timer_sync(sk, &sk->sk_timer);
+	sk_stop_timer_sync(sk, &icsk->icsk_keepalive_timer);
 }
 
 struct dst_entry *inet_csk_route_req(const struct sock *sk,
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 9f63c09439a055550c49b659f23ff8a00ee80348..3f5b1418a6109bd4e398fb2a7d95013044e75f08 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -293,11 +293,11 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
 		r->idiag_expires =
 			jiffies_delta_to_msecs(tcp_timeout_expires(sk) - jiffies);
-	} else if (timer_pending(&sk->sk_timer)) {
+	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		r->idiag_timer = 2;
 		r->idiag_retrans = READ_ONCE(icsk->icsk_probes_out);
 		r->idiag_expires =
-			jiffies_delta_to_msecs(sk->sk_timer.expires - jiffies);
+			jiffies_delta_to_msecs(icsk->icsk_keepalive_timer.expires - jiffies);
 	}
 
 	if ((ext & (1 << (INET_DIAG_INFO - 1))) && handler->idiag_info_size) {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7b8af2c8d03a4cf2c0d90029d2725c0f9dc1a071..f8a9596e8f4d41563896f02329d20b731fe7961f 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2873,9 +2873,9 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
 		timer_expires	= tcp_timeout_expires(sk);
-	} else if (timer_pending(&sk->sk_timer)) {
+	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active	= 2;
-		timer_expires	= sk->sk_timer.expires;
+		timer_expires	= icsk->icsk_keepalive_timer.expires;
 	} else {
 		timer_active	= 0;
 		timer_expires = jiffies;
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index afbd901e610e24c88439d5c152531074d514533a..d2678dfd811806840cb332d47750dd771b20d6af 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -755,12 +755,12 @@ void tcp_syn_ack_timeout(const struct request_sock *req)
 
 void tcp_reset_keepalive_timer(struct sock *sk, unsigned long len)
 {
-	sk_reset_timer(sk, &sk->sk_timer, jiffies + len);
+	sk_reset_timer(sk, &inet_csk(sk)->icsk_keepalive_timer, jiffies + len);
 }
 
 static void tcp_delete_keepalive_timer(struct sock *sk)
 {
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_stop_timer(sk, &inet_csk(sk)->icsk_keepalive_timer);
 }
 
 void tcp_set_keepalive(struct sock *sk, int val)
@@ -777,8 +777,9 @@ EXPORT_IPV6_MOD_GPL(tcp_set_keepalive);
 
 static void tcp_keepalive_timer(struct timer_list *t)
 {
-	struct sock *sk = timer_container_of(sk, t, sk_timer);
-	struct inet_connection_sock *icsk = inet_csk(sk);
+	struct inet_connection_sock *icsk =
+		timer_container_of(icsk, t, icsk_keepalive_timer);
+	struct sock *sk = &icsk->icsk_inet.sk;
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 elapsed;
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 33c76c3a6da7cb0a1a49344ffe9ae27f0e949388..280fe59785598e269183bf90f962ea8d58632b9a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2167,9 +2167,9 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 	} else if (icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active	= 4;
 		timer_expires	= tcp_timeout_expires(sp);
-	} else if (timer_pending(&sp->sk_timer)) {
+	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active	= 2;
-		timer_expires	= sp->sk_timer.expires;
+		timer_expires	= icsk->icsk_keepalive_timer.expires;
 	} else {
 		timer_active	= 0;
 		timer_expires = jiffies;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e3fc001ea74d224ad3974c214c8e9d2c8b2fcf85..6a3175c922add6d47f3268cc4cc3c663d9509cee 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2326,7 +2326,9 @@ static void mptcp_retransmit_timer(struct timer_list *t)
 
 static void mptcp_tout_timer(struct timer_list *t)
 {
-	struct sock *sk = timer_container_of(sk, t, sk_timer);
+	struct inet_connection_sock *icsk =
+		timer_container_of(icsk, t, mptcp_tout_timer);
+	struct sock *sk = &icsk->icsk_inet.sk;
 
 	mptcp_schedule_work(sk);
 	sock_put(sk);
@@ -2750,7 +2752,7 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	 */
 	timeout = inet_csk(sk)->icsk_mtup.probe_timestamp ? close_timeout : fail_tout;
 
-	sk_reset_timer(sk, &sk->sk_timer, timeout);
+	sk_reset_timer(sk, &inet_csk(sk)->mptcp_tout_timer, timeout);
 }
 
 static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
@@ -2875,7 +2877,7 @@ static void __mptcp_init_sock(struct sock *sk)
 
 	/* re-use the csk retrans timer for MPTCP-level retrans */
 	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);
-	timer_setup(&sk->sk_timer, mptcp_tout_timer, 0);
+	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
 }
 
 static void mptcp_ca_reset(struct sock *sk)
@@ -3077,7 +3079,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	might_sleep();
 
 	mptcp_stop_rtx_timer(sk);
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_stop_timer(sk, &inet_csk(sk)->mptcp_tout_timer);
 	msk->pm.status = 0;
 	mptcp_release_sched(msk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a23780ff670fb2a098bf1b8ef83efa38d69beff5..f38e66cedd7e17bbbdc7f92ea2340fc90fe4f836 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -847,7 +847,7 @@ static inline void mptcp_stop_tout_timer(struct sock *sk)
 	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	sk_stop_timer(sk, &sk->sk_timer);
+	sk_stop_timer(sk, &inet_csk(sk)->mptcp_tout_timer);
 	inet_csk(sk)->icsk_mtup.probe_timestamp = 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
index 164640db3a29cf720e193453cab79f4bc317917c..685811326a04126f411da2199cbb5dba576cdde7 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp4.c
@@ -103,9 +103,9 @@ static int dump_tcp_sock(struct seq_file *seq, struct tcp_sock *tp,
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active = 4;
 		timer_expires = icsk->icsk_retransmit_timer.expires;
-	} else if (timer_pending(&sp->sk_timer)) {
+	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active = 2;
-		timer_expires = sp->sk_timer.expires;
+		timer_expires = icsk->icsk_keepalive_timer.expires;
 	} else {
 		timer_active = 0;
 		timer_expires = bpf_jiffies64();
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
index 591c703f5032f024e4b511a6af8d63d1233a042a..0f4a927127517ce3d156c718c3ddece0407c3137 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tcp6.c
@@ -103,9 +103,9 @@ static int dump_tcp6_sock(struct seq_file *seq, struct tcp6_sock *tp,
 	} else if (icsk->icsk_pending == ICSK_TIME_PROBE0) {
 		timer_active = 4;
 		timer_expires = icsk->icsk_retransmit_timer.expires;
-	} else if (timer_pending(&sp->sk_timer)) {
+	} else if (timer_pending(&icsk->icsk_keepalive_timer)) {
 		timer_active = 2;
-		timer_expires = sp->sk_timer.expires;
+		timer_expires = icsk->icsk_keepalive_timer.expires;
 	} else {
 		timer_active = 0;
 		timer_expires = bpf_jiffies64();
-- 
2.52.0.460.gd25c4c69ec-goog


