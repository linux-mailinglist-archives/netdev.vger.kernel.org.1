Return-Path: <netdev+bounces-164596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ABEA2E66B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6763AAEFB
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42201C1F04;
	Mon, 10 Feb 2025 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBpScxTz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABC1C07E5
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176094; cv=none; b=SE3YSMHiZ/xr1fO8RbpTivIFRHkfesykpRIJjll7oiykimXI/qlwp7cPcdaYzCAnWWi6XdeU91nSbgoW8CSBIoG0UuFUKRVruiAQ3KJgXp5dmMWg96yNW7ESEb8PIEoV2a7GQkE10KxhaonHDFlBHfJNYvsqF5Jy72EoMaSY318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176094; c=relaxed/simple;
	bh=LBe9GrDIJgM8mV1s/6RjJ7C08cMLzSuKNYZgnSKeU5k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sSV1EazYL4GnUgMGhaJIXJB5SMJ1ifVLGh8pJOSVvOThrHQ0wN2mbPTmspNwA8ipluD2U3OEpo2Y+CBZNWDe+UIF2QnNY5aRhvCr0MIlzposw6rwGBjVQgN+XDwV2hKMp6fofbMsOGBtzywVZ0UT6RIuMGacg6r0ye6WwXPE1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBpScxTz; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-866ddb99c4bso3135077241.1
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739176091; x=1739780891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HdSaGgu2aQzPdZEurL45C6et6PXCtsO5NDm+XI3Z+E=;
        b=NBpScxTzoElYnti1eawN64U1KLtpAjQeM9tM/ynFuOTiblUUkCc2ggWP4PVvG8RT+o
         ClaiapuiLKa5Ep7/L86/GP8UCTuio+O+47auKBtqwLUAj2Ou61pzKqc5joPRuD2ToiSU
         RKfS28yhmDwjAJ27PDQ+InggMWZCSnJnVNrzKOwXeyDmo+qcLQ7BNW8IeX9BUvwG8+Ud
         b3+nKd3Kdnlmi0aPSIxz/MZ3dA8dsnjblRM3y/S/pQGstjbVSZo93jkdK4Hxoo5q6SPb
         tyxANRCpEUNoQpNKJh9IzstBlidlB+YCa/4a6MZF0ljMBx1ZulOfnkaKkyEFZqoi4Li8
         1Whw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739176091; x=1739780891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HdSaGgu2aQzPdZEurL45C6et6PXCtsO5NDm+XI3Z+E=;
        b=MvJ6Ljgt0eDp9D0h7q+L7ZZhb1eJ9TK/hoJFW0SIodLnoA8q3saIHvV+MhH5eqLjEL
         BtR1Zj6geFgLqxROyKPDqRunrwVq6S8+9BtIDYG/4ptnuILJ9tF8ZrOCfkhpZA6UqVGd
         lbLM/HAnBt8MP4PwssnrzRVckDJ8hguxFznFCLCuM4Hx5un1fwywQCWq2tFdcyAfl8OC
         4ovP4O2hTP5e6K+WZH5am9NEvFx7k6MJQp3l3dfbCdfYG1VWi4ia9EpIXzGWLKQ5X1Bd
         z6t+RCfSQzf0yQw3fP48oBQ/XxEv2ZtXdq3cMxacpQL2jEUB4hZNqodevwPXjCH0/89G
         WMvQ==
X-Gm-Message-State: AOJu0YyGagrdpdz3swQj5wsxuAsxQZtdOzEIEsxguWgHI9bau5xYsjfF
	nSSwv5jF4WK2latiSE1nG5OhXAwuQ06Xe7jamTwDQXg/ca9EfSQmxbpCbwO32cyfpdkGEitnwP0
	DViM03UyPFA==
X-Google-Smtp-Source: AGHT+IExeZL9mefAauJIcoXfw5fu76RE38/PB/JciKatS8KgMNSpbpB6OpWAaDpzYzU1Jn6Rnu1JJSUzl3rrlg==
X-Received: from vsbka41.prod.google.com ([2002:a05:6102:8029:b0:4b6:1931:6d0e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:cd3:b0:4b6:15fa:565e with SMTP id ada2fe7eead31-4ba85e13720mr8733070137.11.1739176091200;
 Mon, 10 Feb 2025 00:28:11 -0800 (PST)
Date: Mon, 10 Feb 2025 08:28:04 +0000
In-Reply-To: <20250210082805.465241-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210082805.465241-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210082805.465241-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
to be exported unless CONFIG_IPV6=m

tcp_hashinfo is no longer used from any module anyway.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/secure_seq.c    |  4 ++--
 net/ipv4/syncookies.c    |  8 +++----
 net/ipv4/tcp.c           | 48 ++++++++++++++++++++--------------------
 net/ipv4/tcp_fastopen.c  |  2 +-
 net/ipv4/tcp_input.c     | 14 ++++++------
 net/ipv4/tcp_ipv4.c      | 47 +++++++++++++++++++--------------------
 net/ipv4/tcp_minisocks.c | 11 +++++----
 net/ipv4/tcp_output.c    | 12 +++++-----
 net/ipv4/tcp_timer.c     |  4 ++--
 9 files changed, 74 insertions(+), 76 deletions(-)

diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
index b0ff6153be6232c5df27a64ac6e271a546cfe6ce..64e18dd4febd03df5d97f8ef646665cb0c146597 100644
--- a/net/core/secure_seq.c
+++ b/net/core/secure_seq.c
@@ -71,7 +71,7 @@ u32 secure_tcpv6_ts_off(const struct net *net,
 	return siphash(&combined, offsetofend(typeof(combined), daddr),
 		       &ts_secret);
 }
-EXPORT_SYMBOL(secure_tcpv6_ts_off);
+EXPORT_IPV6_MOD(secure_tcpv6_ts_off);
 
 u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
 		     __be16 sport, __be16 dport)
@@ -94,7 +94,7 @@ u32 secure_tcpv6_seq(const __be32 *saddr, const __be32 *daddr,
 		       &net_secret);
 	return seq_scale(hash);
 }
-EXPORT_SYMBOL(secure_tcpv6_seq);
+EXPORT_IPV6_MOD(secure_tcpv6_seq);
 
 u64 secure_ipv6_port_ephemeral(const __be32 *saddr, const __be32 *daddr,
 			       __be16 dport)
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 1948d15f1f281b0c9dc6ee237ff805bc288766e1..26816b876dd8b37626a3220da71fd697b997e147 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -222,7 +222,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 
 	return NULL;
 }
-EXPORT_SYMBOL(tcp_get_cookie_sock);
+EXPORT_IPV6_MOD(tcp_get_cookie_sock);
 
 /*
  * when syncookies are in effect and tcp timestamps are enabled we stored
@@ -259,7 +259,7 @@ bool cookie_timestamp_decode(const struct net *net,
 
 	return READ_ONCE(net->ipv4.sysctl_tcp_window_scaling) != 0;
 }
-EXPORT_SYMBOL(cookie_timestamp_decode);
+EXPORT_IPV6_MOD(cookie_timestamp_decode);
 
 static int cookie_tcp_reqsk_init(struct sock *sk, struct sk_buff *skb,
 				 struct request_sock *req)
@@ -310,7 +310,7 @@ struct request_sock *cookie_bpf_check(struct sock *sk, struct sk_buff *skb)
 
 	return req;
 }
-EXPORT_SYMBOL_GPL(cookie_bpf_check);
+EXPORT_IPV6_MOD_GPL(cookie_bpf_check);
 #endif
 
 struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
@@ -351,7 +351,7 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 
 	return req;
 }
-EXPORT_SYMBOL_GPL(cookie_tcp_reqsk_alloc);
+EXPORT_IPV6_MOD_GPL(cookie_tcp_reqsk_alloc);
 
 static struct request_sock *cookie_tcp_check(struct net *net, struct sock *sk,
 					     struct sk_buff *skb)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 2021f2709ec32fc3a439540f288d181a6dab274a..af85a9f0c14562d677aa51fe00f0314b75cd74eb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -300,10 +300,10 @@ DEFINE_PER_CPU(u32, tcp_tw_isn);
 EXPORT_PER_CPU_SYMBOL_GPL(tcp_tw_isn);
 
 long sysctl_tcp_mem[3] __read_mostly;
-EXPORT_SYMBOL(sysctl_tcp_mem);
+EXPORT_IPV6_MOD(sysctl_tcp_mem);
 
 atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;	/* Current allocated memory. */
-EXPORT_SYMBOL(tcp_memory_allocated);
+EXPORT_IPV6_MOD(tcp_memory_allocated);
 DEFINE_PER_CPU(int, tcp_memory_per_cpu_fw_alloc);
 EXPORT_PER_CPU_SYMBOL_GPL(tcp_memory_per_cpu_fw_alloc);
 
@@ -316,7 +316,7 @@ EXPORT_SYMBOL(tcp_have_smc);
  * Current number of TCP sockets.
  */
 struct percpu_counter tcp_sockets_allocated ____cacheline_aligned_in_smp;
-EXPORT_SYMBOL(tcp_sockets_allocated);
+EXPORT_IPV6_MOD(tcp_sockets_allocated);
 
 /*
  * TCP splice context
@@ -334,7 +334,7 @@ struct tcp_splice_state {
  * is strict, actions are advisory and have some latency.
  */
 unsigned long tcp_memory_pressure __read_mostly;
-EXPORT_SYMBOL_GPL(tcp_memory_pressure);
+EXPORT_IPV6_MOD_GPL(tcp_memory_pressure);
 
 void tcp_enter_memory_pressure(struct sock *sk)
 {
@@ -349,7 +349,7 @@ void tcp_enter_memory_pressure(struct sock *sk)
 	if (!cmpxchg(&tcp_memory_pressure, 0, val))
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMEMORYPRESSURES);
 }
-EXPORT_SYMBOL_GPL(tcp_enter_memory_pressure);
+EXPORT_IPV6_MOD_GPL(tcp_enter_memory_pressure);
 
 void tcp_leave_memory_pressure(struct sock *sk)
 {
@@ -362,7 +362,7 @@ void tcp_leave_memory_pressure(struct sock *sk)
 		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPMEMORYPRESSURESCHRONO,
 			      jiffies_to_msecs(jiffies - val));
 }
-EXPORT_SYMBOL_GPL(tcp_leave_memory_pressure);
+EXPORT_IPV6_MOD_GPL(tcp_leave_memory_pressure);
 
 /* Convert seconds to retransmits based on initial and max timeout */
 static u8 secs_to_retrans(int seconds, int timeout, int rto_max)
@@ -475,7 +475,7 @@ void tcp_init_sock(struct sock *sk)
 	sk_sockets_allocated_inc(sk);
 	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
 }
-EXPORT_SYMBOL(tcp_init_sock);
+EXPORT_IPV6_MOD(tcp_init_sock);
 
 static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
@@ -613,7 +613,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 
 	return mask;
 }
-EXPORT_SYMBOL(tcp_poll);
+EXPORT_IPV6_MOD(tcp_poll);
 
 int tcp_ioctl(struct sock *sk, int cmd, int *karg)
 {
@@ -660,7 +660,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg)
 	*karg = answ;
 	return 0;
 }
-EXPORT_SYMBOL(tcp_ioctl);
+EXPORT_IPV6_MOD(tcp_ioctl);
 
 void tcp_mark_push(struct tcp_sock *tp, struct sk_buff *skb)
 {
@@ -876,7 +876,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 
 	return ret;
 }
-EXPORT_SYMBOL(tcp_splice_read);
+EXPORT_IPV6_MOD(tcp_splice_read);
 
 struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 				     bool force_schedule)
@@ -1376,7 +1376,7 @@ void tcp_splice_eof(struct socket *sock)
 	tcp_push(sk, 0, mss_now, tp->nonagle, size_goal);
 	release_sock(sk);
 }
-EXPORT_SYMBOL_GPL(tcp_splice_eof);
+EXPORT_IPV6_MOD_GPL(tcp_splice_eof);
 
 /*
  *	Handle reading urgent data. BSD has very simple semantics for
@@ -1667,7 +1667,7 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 	return copied;
 }
-EXPORT_SYMBOL(tcp_read_skb);
+EXPORT_IPV6_MOD(tcp_read_skb);
 
 void tcp_read_done(struct sock *sk, size_t len)
 {
@@ -1712,7 +1712,7 @@ int tcp_peek_len(struct socket *sock)
 {
 	return tcp_inq(sock->sk);
 }
-EXPORT_SYMBOL(tcp_peek_len);
+EXPORT_IPV6_MOD(tcp_peek_len);
 
 /* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
 int tcp_set_rcvlowat(struct sock *sk, int val)
@@ -1739,7 +1739,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(tcp_set_rcvlowat);
+EXPORT_IPV6_MOD(tcp_set_rcvlowat);
 
 void tcp_update_recv_tstamps(struct sk_buff *skb,
 			     struct scm_timestamping_internal *tss)
@@ -1772,7 +1772,7 @@ int tcp_mmap(struct file *file, struct socket *sock,
 	vma->vm_ops = &tcp_vm_ops;
 	return 0;
 }
-EXPORT_SYMBOL(tcp_mmap);
+EXPORT_IPV6_MOD(tcp_mmap);
 
 static skb_frag_t *skb_advance_to_frag(struct sk_buff *skb, u32 offset_skb,
 				       u32 *offset_frag)
@@ -2869,7 +2869,7 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	}
 	return ret;
 }
-EXPORT_SYMBOL(tcp_recvmsg);
+EXPORT_IPV6_MOD(tcp_recvmsg);
 
 void tcp_set_state(struct sock *sk, int state)
 {
@@ -2999,7 +2999,7 @@ void tcp_shutdown(struct sock *sk, int how)
 			tcp_send_fin(sk);
 	}
 }
-EXPORT_SYMBOL(tcp_shutdown);
+EXPORT_IPV6_MOD(tcp_shutdown);
 
 int tcp_orphan_count_sum(void)
 {
@@ -3498,7 +3498,7 @@ static int tcp_repair_options_est(struct sock *sk, sockptr_t optbuf,
 }
 
 DEFINE_STATIC_KEY_FALSE(tcp_tx_delay_enabled);
-EXPORT_SYMBOL(tcp_tx_delay_enabled);
+EXPORT_IPV6_MOD(tcp_tx_delay_enabled);
 
 static void tcp_enable_tx_delay(void)
 {
@@ -4036,7 +4036,7 @@ int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 								optval, optlen);
 	return do_tcp_setsockopt(sk, level, optname, optval, optlen);
 }
-EXPORT_SYMBOL(tcp_setsockopt);
+EXPORT_IPV6_MOD(tcp_setsockopt);
 
 static void tcp_get_info_chrono_stats(const struct tcp_sock *tp,
 				      struct tcp_info *info)
@@ -4664,7 +4664,7 @@ bool tcp_bpf_bypass_getsockopt(int level, int optname)
 
 	return false;
 }
-EXPORT_SYMBOL(tcp_bpf_bypass_getsockopt);
+EXPORT_IPV6_MOD(tcp_bpf_bypass_getsockopt);
 
 int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 		   int __user *optlen)
@@ -4678,11 +4678,11 @@ int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 	return do_tcp_getsockopt(sk, level, optname, USER_SOCKPTR(optval),
 				 USER_SOCKPTR(optlen));
 }
-EXPORT_SYMBOL(tcp_getsockopt);
+EXPORT_IPV6_MOD(tcp_getsockopt);
 
 #ifdef CONFIG_TCP_MD5SIG
 int tcp_md5_sigpool_id = -1;
-EXPORT_SYMBOL_GPL(tcp_md5_sigpool_id);
+EXPORT_IPV6_MOD_GPL(tcp_md5_sigpool_id);
 
 int tcp_md5_alloc_sigpool(void)
 {
@@ -4728,7 +4728,7 @@ int tcp_md5_hash_key(struct tcp_sigpool *hp,
 	 */
 	return data_race(crypto_ahash_update(hp->req));
 }
-EXPORT_SYMBOL(tcp_md5_hash_key);
+EXPORT_IPV6_MOD(tcp_md5_hash_key);
 
 /* Called with rcu_read_lock() */
 static enum skb_drop_reason
@@ -4848,7 +4848,7 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
 				    l3index, md5_location);
 }
-EXPORT_SYMBOL_GPL(tcp_inbound_hash);
+EXPORT_IPV6_MOD_GPL(tcp_inbound_hash);
 
 void tcp_done(struct sock *sk)
 {
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 0f523cbfe329efeaee2ef206b0779e9911ef22cd..8e6717df54c1449251425aa0a2015c0240bb06c8 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -468,7 +468,7 @@ bool tcp_fastopen_defer_connect(struct sock *sk, int *err)
 	}
 	return false;
 }
-EXPORT_SYMBOL(tcp_fastopen_defer_connect);
+EXPORT_IPV6_MOD(tcp_fastopen_defer_connect);
 
 /*
  * The following code block is to deal with middle box issues with TFO:
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 286f15e4994a96ceae9386e76c127e76caf79220..5c5799b31653d783519adb9eea9db1160640dea8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -630,7 +630,7 @@ void tcp_initialize_rcv_mss(struct sock *sk)
 
 	inet_csk(sk)->icsk_ack.rcv_mss = hint;
 }
-EXPORT_SYMBOL(tcp_initialize_rcv_mss);
+EXPORT_IPV6_MOD(tcp_initialize_rcv_mss);
 
 /* Receiver "autotuning" code.
  *
@@ -2892,7 +2892,7 @@ void tcp_simple_retransmit(struct sock *sk)
 	 */
 	tcp_non_congestion_loss_retransmit(sk);
 }
-EXPORT_SYMBOL(tcp_simple_retransmit);
+EXPORT_IPV6_MOD(tcp_simple_retransmit);
 
 void tcp_enter_recovery(struct sock *sk, bool ece_ack)
 {
@@ -4523,7 +4523,7 @@ void tcp_done_with_error(struct sock *sk, int err)
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk_error_report(sk);
 }
-EXPORT_SYMBOL(tcp_done_with_error);
+EXPORT_IPV6_MOD(tcp_done_with_error);
 
 /* When we get a reset we do this. */
 void tcp_reset(struct sock *sk, struct sk_buff *skb)
@@ -6293,7 +6293,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 discard:
 	tcp_drop_reason(sk, skb, reason);
 }
-EXPORT_SYMBOL(tcp_rcv_established);
+EXPORT_IPV6_MOD(tcp_rcv_established);
 
 void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb)
 {
@@ -7007,7 +7007,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 	return 0;
 }
-EXPORT_SYMBOL(tcp_rcv_state_process);
+EXPORT_IPV6_MOD(tcp_rcv_state_process);
 
 static inline void pr_drop_req(struct request_sock *req, __u16 port, int family)
 {
@@ -7189,7 +7189,7 @@ u16 tcp_get_syncookie_mss(struct request_sock_ops *rsk_ops,
 
 	return mss;
 }
-EXPORT_SYMBOL_GPL(tcp_get_syncookie_mss);
+EXPORT_IPV6_MOD_GPL(tcp_get_syncookie_mss);
 
 int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		     const struct tcp_request_sock_ops *af_ops,
@@ -7370,4 +7370,4 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_listendrop(sk);
 	return 0;
 }
-EXPORT_SYMBOL(tcp_conn_request);
+EXPORT_IPV6_MOD(tcp_conn_request);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index cc2b5194a18d2e64595f474f62c6f2fd3eff319f..2f5a342a4a493d236220b37614f59ca00101a112 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -92,7 +92,6 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 #endif
 
 struct inet_hashinfo tcp_hashinfo;
-EXPORT_SYMBOL(tcp_hashinfo);
 
 static DEFINE_PER_CPU(struct sock_bh_locked, ipv4_tcp_sk) = {
 	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
@@ -199,7 +198,7 @@ int tcp_twsk_unique(struct sock *sk, struct sock *sktw, void *twp)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(tcp_twsk_unique);
+EXPORT_IPV6_MOD_GPL(tcp_twsk_unique);
 
 static int tcp_v4_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 			      int addr_len)
@@ -359,7 +358,7 @@ int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	inet->inet_dport = 0;
 	return err;
 }
-EXPORT_SYMBOL(tcp_v4_connect);
+EXPORT_IPV6_MOD(tcp_v4_connect);
 
 /*
  * This routine reacts to ICMP_FRAG_NEEDED mtu indications as defined in RFC1191.
@@ -400,7 +399,7 @@ void tcp_v4_mtu_reduced(struct sock *sk)
 		tcp_simple_retransmit(sk);
 	} /* else let the usual retransmit timer handle it */
 }
-EXPORT_SYMBOL(tcp_v4_mtu_reduced);
+EXPORT_IPV6_MOD(tcp_v4_mtu_reduced);
 
 static void do_redirect(struct sk_buff *skb, struct sock *sk)
 {
@@ -434,7 +433,7 @@ void tcp_req_err(struct sock *sk, u32 seq, bool abort)
 	}
 	reqsk_put(req);
 }
-EXPORT_SYMBOL(tcp_req_err);
+EXPORT_IPV6_MOD(tcp_req_err);
 
 /* TCP-LD (RFC 6069) logic */
 void tcp_ld_RTO_revert(struct sock *sk, u32 seq)
@@ -474,7 +473,7 @@ void tcp_ld_RTO_revert(struct sock *sk, u32 seq)
 		tcp_retransmit_timer(sk);
 	}
 }
-EXPORT_SYMBOL(tcp_ld_RTO_revert);
+EXPORT_IPV6_MOD(tcp_ld_RTO_revert);
 
 /*
  * This routine is called by the ICMP module when it gets some
@@ -676,7 +675,7 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
 
 	__tcp_v4_send_check(skb, inet->inet_saddr, inet->inet_daddr);
 }
-EXPORT_SYMBOL(tcp_v4_send_check);
+EXPORT_IPV6_MOD(tcp_v4_send_check);
 
 #define REPLY_OPTIONS_LEN      (MAX_TCP_OPTION_SPACE / sizeof(__be32))
 
@@ -1231,7 +1230,7 @@ static void tcp_v4_reqsk_destructor(struct request_sock *req)
  */
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_md5_needed, HZ);
-EXPORT_SYMBOL(tcp_md5_needed);
+EXPORT_IPV6_MOD(tcp_md5_needed);
 
 static bool better_md5_match(struct tcp_md5sig_key *old, struct tcp_md5sig_key *new)
 {
@@ -1290,7 +1289,7 @@ struct tcp_md5sig_key *__tcp_md5_do_lookup(const struct sock *sk, int l3index,
 	}
 	return best_match;
 }
-EXPORT_SYMBOL(__tcp_md5_do_lookup);
+EXPORT_IPV6_MOD(__tcp_md5_do_lookup);
 
 static struct tcp_md5sig_key *tcp_md5_do_lookup_exact(const struct sock *sk,
 						      const union tcp_md5_addr *addr,
@@ -1337,7 +1336,7 @@ struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
 	addr = (const union tcp_md5_addr *)&addr_sk->sk_daddr;
 	return tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
 }
-EXPORT_SYMBOL(tcp_v4_md5_lookup);
+EXPORT_IPV6_MOD(tcp_v4_md5_lookup);
 
 static int tcp_md5sig_info_add(struct sock *sk, gfp_t gfp)
 {
@@ -1433,7 +1432,7 @@ int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *addr,
 	return __tcp_md5_do_add(sk, addr, family, prefixlen, l3index, flags,
 				newkey, newkeylen, GFP_KERNEL);
 }
-EXPORT_SYMBOL(tcp_md5_do_add);
+EXPORT_IPV6_MOD(tcp_md5_do_add);
 
 int tcp_md5_key_copy(struct sock *sk, const union tcp_md5_addr *addr,
 		     int family, u8 prefixlen, int l3index,
@@ -1465,7 +1464,7 @@ int tcp_md5_key_copy(struct sock *sk, const union tcp_md5_addr *addr,
 				key->flags, key->key, key->keylen,
 				sk_gfp_mask(sk, GFP_ATOMIC));
 }
-EXPORT_SYMBOL(tcp_md5_key_copy);
+EXPORT_IPV6_MOD(tcp_md5_key_copy);
 
 int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr, int family,
 		   u8 prefixlen, int l3index, u8 flags)
@@ -1480,7 +1479,7 @@ int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr, int family,
 	kfree_rcu(key, rcu);
 	return 0;
 }
-EXPORT_SYMBOL(tcp_md5_do_del);
+EXPORT_IPV6_MOD(tcp_md5_do_del);
 
 void tcp_clear_md5_list(struct sock *sk)
 {
@@ -1659,7 +1658,7 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 	memset(md5_hash, 0, 16);
 	return 1;
 }
-EXPORT_SYMBOL(tcp_v4_md5_hash_skb);
+EXPORT_IPV6_MOD(tcp_v4_md5_hash_skb);
 
 #endif
 
@@ -1732,7 +1731,7 @@ int tcp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	tcp_listendrop(sk);
 	return 0;
 }
-EXPORT_SYMBOL(tcp_v4_conn_request);
+EXPORT_IPV6_MOD(tcp_v4_conn_request);
 
 
 /*
@@ -1856,7 +1855,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	tcp_done(newsk);
 	goto exit;
 }
-EXPORT_SYMBOL(tcp_v4_syn_recv_sock);
+EXPORT_IPV6_MOD(tcp_v4_syn_recv_sock);
 
 static struct sock *tcp_v4_cookie_check(struct sock *sk, struct sk_buff *skb)
 {
@@ -2135,7 +2134,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	}
 	return false;
 }
-EXPORT_SYMBOL(tcp_add_backlog);
+EXPORT_IPV6_MOD(tcp_add_backlog);
 
 int tcp_filter(struct sock *sk, struct sk_buff *skb)
 {
@@ -2143,7 +2142,7 @@ int tcp_filter(struct sock *sk, struct sk_buff *skb)
 
 	return sk_filter_trim_cap(sk, skb, th->doff * 4);
 }
-EXPORT_SYMBOL(tcp_filter);
+EXPORT_IPV6_MOD(tcp_filter);
 
 static void tcp_v4_restore_cb(struct sk_buff *skb)
 {
@@ -2452,7 +2451,7 @@ void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 		sk->sk_rx_dst_ifindex = skb->skb_iif;
 	}
 }
-EXPORT_SYMBOL(inet_sk_rx_dst_set);
+EXPORT_IPV6_MOD(inet_sk_rx_dst_set);
 
 const struct inet_connection_sock_af_ops ipv4_specific = {
 	.queue_xmit	   = ip_queue_xmit,
@@ -2468,7 +2467,7 @@ const struct inet_connection_sock_af_ops ipv4_specific = {
 	.sockaddr_len	   = sizeof(struct sockaddr_in),
 	.mtu_reduced	   = tcp_v4_mtu_reduced,
 };
-EXPORT_SYMBOL(ipv4_specific);
+EXPORT_IPV6_MOD(ipv4_specific);
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 static const struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
@@ -2578,7 +2577,7 @@ void tcp_v4_destroy_sock(struct sock *sk)
 
 	sk_sockets_allocated_dec(sk);
 }
-EXPORT_SYMBOL(tcp_v4_destroy_sock);
+EXPORT_IPV6_MOD(tcp_v4_destroy_sock);
 
 #ifdef CONFIG_PROC_FS
 /* Proc filesystem TCP sock list dumping. */
@@ -2814,7 +2813,7 @@ void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 	st->last_pos = *pos;
 	return rc;
 }
-EXPORT_SYMBOL(tcp_seq_start);
+EXPORT_IPV6_MOD(tcp_seq_start);
 
 void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
@@ -2845,7 +2844,7 @@ void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	st->last_pos = *pos;
 	return rc;
 }
-EXPORT_SYMBOL(tcp_seq_next);
+EXPORT_IPV6_MOD(tcp_seq_next);
 
 void tcp_seq_stop(struct seq_file *seq, void *v)
 {
@@ -2863,7 +2862,7 @@ void tcp_seq_stop(struct seq_file *seq, void *v)
 		break;
 	}
 }
-EXPORT_SYMBOL(tcp_seq_stop);
+EXPORT_IPV6_MOD(tcp_seq_stop);
 
 static void get_openreq4(const struct request_sock *req,
 			 struct seq_file *f, int i)
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 0deb2ac85acf7a9e8377e97915087afec6f8a835..1eccc518b957eb9b81cab8b288cb6a5bca931e5a 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -264,7 +264,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	inet_twsk_put(tw);
 	return TCP_TW_SUCCESS;
 }
-EXPORT_SYMBOL(tcp_timewait_state_process);
+EXPORT_IPV6_MOD(tcp_timewait_state_process);
 
 static void tcp_time_wait_init(struct sock *sk, struct tcp_timewait_sock *tcptw)
 {
@@ -398,7 +398,7 @@ void tcp_twsk_destructor(struct sock *sk)
 #endif
 	tcp_ao_destroy_sock(sk, true);
 }
-EXPORT_SYMBOL_GPL(tcp_twsk_destructor);
+EXPORT_IPV6_MOD_GPL(tcp_twsk_destructor);
 
 void tcp_twsk_purge(struct list_head *net_exit_list)
 {
@@ -457,7 +457,6 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 		rcv_wnd);
 	ireq->rcv_wscale = rcv_wscale;
 }
-EXPORT_SYMBOL(tcp_openreq_init_rwin);
 
 static void tcp_ecn_openreq_child(struct tcp_sock *tp,
 				  const struct request_sock *req)
@@ -492,7 +491,7 @@ void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
 
 	tcp_set_ca_state(sk, TCP_CA_Open);
 }
-EXPORT_SYMBOL_GPL(tcp_ca_openreq_child);
+EXPORT_IPV6_MOD_GPL(tcp_ca_openreq_child);
 
 static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
 				    struct request_sock *req,
@@ -909,7 +908,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(tcp_check_req);
+EXPORT_IPV6_MOD(tcp_check_req);
 
 /*
  * Queue segment on the new socket if the new socket is active,
@@ -951,4 +950,4 @@ enum skb_drop_reason tcp_child_process(struct sock *parent, struct sock *child,
 	sock_put(child);
 	return reason;
 }
-EXPORT_SYMBOL(tcp_child_process);
+EXPORT_IPV6_MOD(tcp_child_process);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ef9f6172680f5f3a9384132962d6e34cfbf83f14..0a6b1508dad45fa6a136325e86499eb8918a9210 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -250,7 +250,7 @@ void tcp_select_initial_window(const struct sock *sk, int __space, __u32 mss,
 	WRITE_ONCE(*__window_clamp,
 		   min_t(__u32, U16_MAX << (*rcv_wscale), window_clamp));
 }
-EXPORT_SYMBOL(tcp_select_initial_window);
+EXPORT_IPV6_MOD(tcp_select_initial_window);
 
 /* Chose a new window to advertise, update state in tcp_sock for the
  * socket, and return result with RFC1323 scaling applied.  The return
@@ -1171,7 +1171,7 @@ void tcp_release_cb(struct sock *sk)
 	if ((flags & TCPF_ACK_DEFERRED) && inet_csk_ack_scheduled(sk))
 		tcp_send_ack(sk);
 }
-EXPORT_SYMBOL(tcp_release_cb);
+EXPORT_IPV6_MOD(tcp_release_cb);
 
 void __init tcp_tasklet_init(void)
 {
@@ -1783,7 +1783,7 @@ int tcp_mtu_to_mss(struct sock *sk, int pmtu)
 	return __tcp_mtu_to_mss(sk, pmtu) -
 	       (tcp_sk(sk)->tcp_header_len - sizeof(struct tcphdr));
 }
-EXPORT_SYMBOL(tcp_mtu_to_mss);
+EXPORT_IPV6_MOD(tcp_mtu_to_mss);
 
 /* Inverse of above */
 int tcp_mss_to_mtu(struct sock *sk, int mss)
@@ -1856,7 +1856,7 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu)
 
 	return mss_now;
 }
-EXPORT_SYMBOL(tcp_sync_mss);
+EXPORT_IPV6_MOD(tcp_sync_mss);
 
 /* Compute the current effective MSS, taking SACKs and IP options,
  * and even PMTU discovery events into account.
@@ -3852,7 +3852,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	return skb;
 }
-EXPORT_SYMBOL(tcp_make_synack);
+EXPORT_IPV6_MOD(tcp_make_synack);
 
 static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 {
@@ -4429,4 +4429,4 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	}
 	return res;
 }
-EXPORT_SYMBOL(tcp_rtx_synack);
+EXPORT_IPV6_MOD(tcp_rtx_synack);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index cfb6f4c4e4c9fc3eb6963dcb659b2c6489193dd9..8d035aecf58e6bacd047aa4a5fb7ff8f5e2ce068 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -749,7 +749,7 @@ void tcp_syn_ack_timeout(const struct request_sock *req)
 
 	__NET_INC_STATS(net, LINUX_MIB_TCPTIMEOUTS);
 }
-EXPORT_SYMBOL(tcp_syn_ack_timeout);
+EXPORT_IPV6_MOD(tcp_syn_ack_timeout);
 
 void tcp_reset_keepalive_timer(struct sock *sk, unsigned long len)
 {
@@ -771,7 +771,7 @@ void tcp_set_keepalive(struct sock *sk, int val)
 	else if (!val)
 		tcp_delete_keepalive_timer(sk);
 }
-EXPORT_SYMBOL_GPL(tcp_set_keepalive);
+EXPORT_IPV6_MOD_GPL(tcp_set_keepalive);
 
 static void tcp_keepalive_timer(struct timer_list *t)
 {
-- 
2.48.1.502.g6dc24dfdaf-goog


