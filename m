Return-Path: <netdev+bounces-165523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E9DA326E8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960627A2C60
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471F20E03B;
	Wed, 12 Feb 2025 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AX70x5Xz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC420E32B
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366667; cv=none; b=NhIYp1WfSEPUzVg/+a1oqhkPRxhEvg5LG8FoxOXXZYF+Ijr6lH1AVbj65E2oJ6Bia8VRft7AskeBLcYq9kjIIiu7wmzOfCwXv1W9O+XPZU/Ur5Kngttwhp/TqLGX9K2C2hPziMGTVyXLTf5oWSJPH+eTtf3URmJaP3mHFQA/hmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366667; c=relaxed/simple;
	bh=gZ76Cx2DfFWVrTs7c9ANlpexJwiIjl2Tg9ZAVyo47w0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mRxvXhHebAG/wDj4oFtFUSwqWjp+JnX5PBK2FbQGBm6TsIxiJPdeImBfl/lzarMKGsyTaI04hITp8n8njuhZGOb3JkVjgftzlpnzqx99ORI/Lef+ZKFbGZwNOqk1SafxLBxOqMkGBJ4KMYI2EXkceFmsH2GTjh9qdB38IeMxu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AX70x5Xz; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-471a0703d15so39279621cf.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739366664; x=1739971464; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KUEK/cwmi4od+uky7+8YumLkuCcUonn0k6oFXlO0utc=;
        b=AX70x5XzBplz70FBlTCi4qeTn38Ouj5rJASFAWZKJKEw326m1/IhceJe/iFkVjHsgQ
         QonYQUdq2moAq1gQFS3GXgG45w31Y7Xuw5OZRPY9/jQMxma2psD7ra8V+RLv7QKkoTwI
         veFUMUzzrGhIcoenCACyIbkIkIB4ujfm0uYDjU5W+C8EOWZsvA+vIW5aX6pe7knz4bzt
         NZOSfbjAsFsPsdbcNB68Ybsi04ynLimQ+0DQI7lsNUavUhZrvFiiTxxNExFcZO9zfTIM
         yoTvz1zFJ9I5gHeiJv5qqRu4KTde6qQ37hd9DeiUEYx/T7jWojQIm0jhTm/9UC7NUj01
         SHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739366664; x=1739971464;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUEK/cwmi4od+uky7+8YumLkuCcUonn0k6oFXlO0utc=;
        b=CMAdyXgvrsLI2TZqmJr1lH0qthqvGRTPN0ubdLX2gJDnfy5B3GCSsuYaBQLm2P11CQ
         HGBK+ehHsSXQDhzNrCPh/lHFBakkAF7HgtvY6eZO6LfiqgqjFQw72AFLWINCd9JlLKuN
         SrynHfFosyYKvUvT7F3rkazP97L94tcXnfJ5xbjqVjGBleWxPldvJKeIWljC5RA5rRiO
         K5orgQ/KmuRjM3lh6eGTUx2zTEWz9q13cu9Ry+wKftsSV+7lHpB4sRbFu5Cjmvjq3NZ0
         D9fa/Z/VUtHgWrBB9cJS0VcILilarev9j+7i/ROfMWWKY9NTTW+sl5qfrJDLkXASP2MF
         nV6w==
X-Gm-Message-State: AOJu0Yz1nekrKMZgsXYC424bjYfKhh5UAvFv3AIY035jV7rg95xHn3GB
	MBnL8nLDt4a2cRp/97PWhVaOvKdhY7LT+RZn1N2Yx2N3kH9Y8eJoOPC9z5n3cfSFCw9T7dkmwcH
	EaxsJyg1zoQ==
X-Google-Smtp-Source: AGHT+IEuOeKShggcCBP71KERAN3m/FkLDoqzRAUGrO4lJUcHUiSly/wQapb02Bve37k8Z4jCUd32DU76ZMSpYg==
X-Received: from qtbbq21.prod.google.com ([2002:a05:622a:1c15:b0:471:8bb9:4c51])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:668d:b0:471:b192:16c7 with SMTP id d75a77b69052e-471b19217ecmr26614131cf.26.1739366663914;
 Wed, 12 Feb 2025 05:24:23 -0800 (PST)
Date: Wed, 12 Feb 2025 13:24:17 +0000
In-Reply-To: <20250212132418.1524422-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212132418.1524422-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212132418.1524422-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
to be exported unless CONFIG_IPV6=m

tcp_hashinfo and tcp_openreq_init_rwin() are no longer
used from any module anyway.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/secure_seq.c    |  2 +-
 net/ipv4/syncookies.c    |  8 +++----
 net/ipv4/tcp.c           | 44 ++++++++++++++++++-------------------
 net/ipv4/tcp_fastopen.c  |  2 +-
 net/ipv4/tcp_input.c     | 14 ++++++------
 net/ipv4/tcp_ipv4.c      | 47 ++++++++++++++++++++--------------------
 net/ipv4/tcp_minisocks.c | 11 +++++-----
 net/ipv4/tcp_output.c    | 12 +++++-----
 net/ipv4/tcp_timer.c     |  4 ++--
 9 files changed, 71 insertions(+), 73 deletions(-)

diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
index b0ff6153be6232c5df27a64ac6e271a546cfe6ce..568779d5a0efa4e6891820a0bbb87d3fd9f65721 100644
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
index 992d5c9b2487ce7a689253c068ad7b826f6b6fb0..5d78ab3b416e2d299252145d3881561ea7c61e15 100644
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
@@ -479,7 +479,7 @@ void tcp_init_sock(struct sock *sk)
 	sk_sockets_allocated_inc(sk);
 	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
 }
-EXPORT_SYMBOL(tcp_init_sock);
+EXPORT_IPV6_MOD(tcp_init_sock);
 
 static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 {
@@ -664,7 +664,7 @@ int tcp_ioctl(struct sock *sk, int cmd, int *karg)
 	*karg = answ;
 	return 0;
 }
-EXPORT_SYMBOL(tcp_ioctl);
+EXPORT_IPV6_MOD(tcp_ioctl);
 
 void tcp_mark_push(struct tcp_sock *tp, struct sk_buff *skb)
 {
@@ -880,7 +880,7 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 
 	return ret;
 }
-EXPORT_SYMBOL(tcp_splice_read);
+EXPORT_IPV6_MOD(tcp_splice_read);
 
 struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 				     bool force_schedule)
@@ -1380,7 +1380,7 @@ void tcp_splice_eof(struct socket *sock)
 	tcp_push(sk, 0, mss_now, tp->nonagle, size_goal);
 	release_sock(sk);
 }
-EXPORT_SYMBOL_GPL(tcp_splice_eof);
+EXPORT_IPV6_MOD_GPL(tcp_splice_eof);
 
 /*
  *	Handle reading urgent data. BSD has very simple semantics for
@@ -1671,7 +1671,7 @@ int tcp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	}
 	return copied;
 }
-EXPORT_SYMBOL(tcp_read_skb);
+EXPORT_IPV6_MOD(tcp_read_skb);
 
 void tcp_read_done(struct sock *sk, size_t len)
 {
@@ -1716,7 +1716,7 @@ int tcp_peek_len(struct socket *sock)
 {
 	return tcp_inq(sock->sk);
 }
-EXPORT_SYMBOL(tcp_peek_len);
+EXPORT_IPV6_MOD(tcp_peek_len);
 
 /* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
 int tcp_set_rcvlowat(struct sock *sk, int val)
@@ -1743,7 +1743,7 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(tcp_set_rcvlowat);
+EXPORT_IPV6_MOD(tcp_set_rcvlowat);
 
 void tcp_update_recv_tstamps(struct sk_buff *skb,
 			     struct scm_timestamping_internal *tss)
@@ -1776,7 +1776,7 @@ int tcp_mmap(struct file *file, struct socket *sock,
 	vma->vm_ops = &tcp_vm_ops;
 	return 0;
 }
-EXPORT_SYMBOL(tcp_mmap);
+EXPORT_IPV6_MOD(tcp_mmap);
 
 static skb_frag_t *skb_advance_to_frag(struct sk_buff *skb, u32 offset_skb,
 				       u32 *offset_frag)
@@ -2873,7 +2873,7 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	}
 	return ret;
 }
-EXPORT_SYMBOL(tcp_recvmsg);
+EXPORT_IPV6_MOD(tcp_recvmsg);
 
 void tcp_set_state(struct sock *sk, int state)
 {
@@ -3003,7 +3003,7 @@ void tcp_shutdown(struct sock *sk, int how)
 			tcp_send_fin(sk);
 	}
 }
-EXPORT_SYMBOL(tcp_shutdown);
+EXPORT_IPV6_MOD(tcp_shutdown);
 
 int tcp_orphan_count_sum(void)
 {
@@ -3502,7 +3502,7 @@ static int tcp_repair_options_est(struct sock *sk, sockptr_t optbuf,
 }
 
 DEFINE_STATIC_KEY_FALSE(tcp_tx_delay_enabled);
-EXPORT_SYMBOL(tcp_tx_delay_enabled);
+EXPORT_IPV6_MOD(tcp_tx_delay_enabled);
 
 static void tcp_enable_tx_delay(void)
 {
@@ -4045,7 +4045,7 @@ int tcp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 								optval, optlen);
 	return do_tcp_setsockopt(sk, level, optname, optval, optlen);
 }
-EXPORT_SYMBOL(tcp_setsockopt);
+EXPORT_IPV6_MOD(tcp_setsockopt);
 
 static void tcp_get_info_chrono_stats(const struct tcp_sock *tp,
 				      struct tcp_info *info)
@@ -4676,7 +4676,7 @@ bool tcp_bpf_bypass_getsockopt(int level, int optname)
 
 	return false;
 }
-EXPORT_SYMBOL(tcp_bpf_bypass_getsockopt);
+EXPORT_IPV6_MOD(tcp_bpf_bypass_getsockopt);
 
 int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
 		   int __user *optlen)
@@ -4690,11 +4690,11 @@ int tcp_getsockopt(struct sock *sk, int level, int optname, char __user *optval,
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
@@ -4740,7 +4740,7 @@ int tcp_md5_hash_key(struct tcp_sigpool *hp,
 	 */
 	return data_race(crypto_ahash_update(hp->req));
 }
-EXPORT_SYMBOL(tcp_md5_hash_key);
+EXPORT_IPV6_MOD(tcp_md5_hash_key);
 
 /* Called with rcu_read_lock() */
 static enum skb_drop_reason
@@ -4860,7 +4860,7 @@ tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
 	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
 				    l3index, md5_location);
 }
-EXPORT_SYMBOL_GPL(tcp_inbound_hash);
+EXPORT_IPV6_MOD_GPL(tcp_inbound_hash);
 
 void tcp_done(struct sock *sk)
 {
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index e4c95238df58f133249a7829af4c9131e52baf10..3a352c40a4865134cf0674cbafd67ee92006b7e6 100644
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
index 4686783b70defe0457571efd72d41ac88c528f7b..074406890552a7e253ddf65f7cd9eaa2cdb16266 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -630,7 +630,7 @@ void tcp_initialize_rcv_mss(struct sock *sk)
 
 	inet_csk(sk)->icsk_ack.rcv_mss = hint;
 }
-EXPORT_SYMBOL(tcp_initialize_rcv_mss);
+EXPORT_IPV6_MOD(tcp_initialize_rcv_mss);
 
 /* Receiver "autotuning" code.
  *
@@ -2891,7 +2891,7 @@ void tcp_simple_retransmit(struct sock *sk)
 	 */
 	tcp_non_congestion_loss_retransmit(sk);
 }
-EXPORT_SYMBOL(tcp_simple_retransmit);
+EXPORT_IPV6_MOD(tcp_simple_retransmit);
 
 void tcp_enter_recovery(struct sock *sk, bool ece_ack)
 {
@@ -4521,7 +4521,7 @@ void tcp_done_with_error(struct sock *sk, int err)
 	if (!sock_flag(sk, SOCK_DEAD))
 		sk_error_report(sk);
 }
-EXPORT_SYMBOL(tcp_done_with_error);
+EXPORT_IPV6_MOD(tcp_done_with_error);
 
 /* When we get a reset we do this. */
 void tcp_reset(struct sock *sk, struct sk_buff *skb)
@@ -6291,7 +6291,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 discard:
 	tcp_drop_reason(sk, skb, reason);
 }
-EXPORT_SYMBOL(tcp_rcv_established);
+EXPORT_IPV6_MOD(tcp_rcv_established);
 
 void tcp_init_transfer(struct sock *sk, int bpf_op, struct sk_buff *skb)
 {
@@ -7004,7 +7004,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 	__kfree_skb(skb);
 	return 0;
 }
-EXPORT_SYMBOL(tcp_rcv_state_process);
+EXPORT_IPV6_MOD(tcp_rcv_state_process);
 
 static inline void pr_drop_req(struct request_sock *req, __u16 port, int family)
 {
@@ -7186,7 +7186,7 @@ u16 tcp_get_syncookie_mss(struct request_sock_ops *rsk_ops,
 
 	return mss;
 }
-EXPORT_SYMBOL_GPL(tcp_get_syncookie_mss);
+EXPORT_IPV6_MOD_GPL(tcp_get_syncookie_mss);
 
 int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		     const struct tcp_request_sock_ops *af_ops,
@@ -7367,4 +7367,4 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_listendrop(sk);
 	return 0;
 }
-EXPORT_SYMBOL(tcp_conn_request);
+EXPORT_IPV6_MOD(tcp_conn_request);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d1fd2128ac6cce9b845b1f8d278a194c511db87b..6245e24fcbf3fd0ca3c26c21f3503b8bea44c2b1 100644
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
@@ -473,7 +472,7 @@ void tcp_ld_RTO_revert(struct sock *sk, u32 seq)
 		tcp_retransmit_timer(sk);
 	}
 }
-EXPORT_SYMBOL(tcp_ld_RTO_revert);
+EXPORT_IPV6_MOD(tcp_ld_RTO_revert);
 
 /*
  * This routine is called by the ICMP module when it gets some
@@ -675,7 +674,7 @@ void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb)
 
 	__tcp_v4_send_check(skb, inet->inet_saddr, inet->inet_daddr);
 }
-EXPORT_SYMBOL(tcp_v4_send_check);
+EXPORT_IPV6_MOD(tcp_v4_send_check);
 
 #define REPLY_OPTIONS_LEN      (MAX_TCP_OPTION_SPACE / sizeof(__be32))
 
@@ -1230,7 +1229,7 @@ static void tcp_v4_reqsk_destructor(struct request_sock *req)
  */
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(tcp_md5_needed, HZ);
-EXPORT_SYMBOL(tcp_md5_needed);
+EXPORT_IPV6_MOD(tcp_md5_needed);
 
 static bool better_md5_match(struct tcp_md5sig_key *old, struct tcp_md5sig_key *new)
 {
@@ -1289,7 +1288,7 @@ struct tcp_md5sig_key *__tcp_md5_do_lookup(const struct sock *sk, int l3index,
 	}
 	return best_match;
 }
-EXPORT_SYMBOL(__tcp_md5_do_lookup);
+EXPORT_IPV6_MOD(__tcp_md5_do_lookup);
 
 static struct tcp_md5sig_key *tcp_md5_do_lookup_exact(const struct sock *sk,
 						      const union tcp_md5_addr *addr,
@@ -1336,7 +1335,7 @@ struct tcp_md5sig_key *tcp_v4_md5_lookup(const struct sock *sk,
 	addr = (const union tcp_md5_addr *)&addr_sk->sk_daddr;
 	return tcp_md5_do_lookup(sk, l3index, addr, AF_INET);
 }
-EXPORT_SYMBOL(tcp_v4_md5_lookup);
+EXPORT_IPV6_MOD(tcp_v4_md5_lookup);
 
 static int tcp_md5sig_info_add(struct sock *sk, gfp_t gfp)
 {
@@ -1432,7 +1431,7 @@ int tcp_md5_do_add(struct sock *sk, const union tcp_md5_addr *addr,
 	return __tcp_md5_do_add(sk, addr, family, prefixlen, l3index, flags,
 				newkey, newkeylen, GFP_KERNEL);
 }
-EXPORT_SYMBOL(tcp_md5_do_add);
+EXPORT_IPV6_MOD(tcp_md5_do_add);
 
 int tcp_md5_key_copy(struct sock *sk, const union tcp_md5_addr *addr,
 		     int family, u8 prefixlen, int l3index,
@@ -1464,7 +1463,7 @@ int tcp_md5_key_copy(struct sock *sk, const union tcp_md5_addr *addr,
 				key->flags, key->key, key->keylen,
 				sk_gfp_mask(sk, GFP_ATOMIC));
 }
-EXPORT_SYMBOL(tcp_md5_key_copy);
+EXPORT_IPV6_MOD(tcp_md5_key_copy);
 
 int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr, int family,
 		   u8 prefixlen, int l3index, u8 flags)
@@ -1479,7 +1478,7 @@ int tcp_md5_do_del(struct sock *sk, const union tcp_md5_addr *addr, int family,
 	kfree_rcu(key, rcu);
 	return 0;
 }
-EXPORT_SYMBOL(tcp_md5_do_del);
+EXPORT_IPV6_MOD(tcp_md5_do_del);
 
 void tcp_clear_md5_list(struct sock *sk)
 {
@@ -1658,7 +1657,7 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 	memset(md5_hash, 0, 16);
 	return 1;
 }
-EXPORT_SYMBOL(tcp_v4_md5_hash_skb);
+EXPORT_IPV6_MOD(tcp_v4_md5_hash_skb);
 
 #endif
 
@@ -1731,7 +1730,7 @@ int tcp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	tcp_listendrop(sk);
 	return 0;
 }
-EXPORT_SYMBOL(tcp_v4_conn_request);
+EXPORT_IPV6_MOD(tcp_v4_conn_request);
 
 
 /*
@@ -1855,7 +1854,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	tcp_done(newsk);
 	goto exit;
 }
-EXPORT_SYMBOL(tcp_v4_syn_recv_sock);
+EXPORT_IPV6_MOD(tcp_v4_syn_recv_sock);
 
 static struct sock *tcp_v4_cookie_check(struct sock *sk, struct sk_buff *skb)
 {
@@ -2134,7 +2133,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	}
 	return false;
 }
-EXPORT_SYMBOL(tcp_add_backlog);
+EXPORT_IPV6_MOD(tcp_add_backlog);
 
 int tcp_filter(struct sock *sk, struct sk_buff *skb)
 {
@@ -2142,7 +2141,7 @@ int tcp_filter(struct sock *sk, struct sk_buff *skb)
 
 	return sk_filter_trim_cap(sk, skb, th->doff * 4);
 }
-EXPORT_SYMBOL(tcp_filter);
+EXPORT_IPV6_MOD(tcp_filter);
 
 static void tcp_v4_restore_cb(struct sk_buff *skb)
 {
@@ -2451,7 +2450,7 @@ void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 		sk->sk_rx_dst_ifindex = skb->skb_iif;
 	}
 }
-EXPORT_SYMBOL(inet_sk_rx_dst_set);
+EXPORT_IPV6_MOD(inet_sk_rx_dst_set);
 
 const struct inet_connection_sock_af_ops ipv4_specific = {
 	.queue_xmit	   = ip_queue_xmit,
@@ -2467,7 +2466,7 @@ const struct inet_connection_sock_af_ops ipv4_specific = {
 	.sockaddr_len	   = sizeof(struct sockaddr_in),
 	.mtu_reduced	   = tcp_v4_mtu_reduced,
 };
-EXPORT_SYMBOL(ipv4_specific);
+EXPORT_IPV6_MOD(ipv4_specific);
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
 static const struct tcp_sock_af_ops tcp_sock_ipv4_specific = {
@@ -2577,7 +2576,7 @@ void tcp_v4_destroy_sock(struct sock *sk)
 
 	sk_sockets_allocated_dec(sk);
 }
-EXPORT_SYMBOL(tcp_v4_destroy_sock);
+EXPORT_IPV6_MOD(tcp_v4_destroy_sock);
 
 #ifdef CONFIG_PROC_FS
 /* Proc filesystem TCP sock list dumping. */
@@ -2813,7 +2812,7 @@ void *tcp_seq_start(struct seq_file *seq, loff_t *pos)
 	st->last_pos = *pos;
 	return rc;
 }
-EXPORT_SYMBOL(tcp_seq_start);
+EXPORT_IPV6_MOD(tcp_seq_start);
 
 void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
@@ -2844,7 +2843,7 @@ void *tcp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	st->last_pos = *pos;
 	return rc;
 }
-EXPORT_SYMBOL(tcp_seq_next);
+EXPORT_IPV6_MOD(tcp_seq_next);
 
 void tcp_seq_stop(struct seq_file *seq, void *v)
 {
@@ -2862,7 +2861,7 @@ void tcp_seq_stop(struct seq_file *seq, void *v)
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
index 464232a0d63796d5ac7437dafb5f496d5c05bc1c..b4b40f13543233eb34c79577bdf9deb7163e99ee 100644
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
@@ -3851,7 +3851,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	return skb;
 }
-EXPORT_SYMBOL(tcp_make_synack);
+EXPORT_IPV6_MOD(tcp_make_synack);
 
 static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 {
@@ -4428,4 +4428,4 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	}
 	return res;
 }
-EXPORT_SYMBOL(tcp_rtx_synack);
+EXPORT_IPV6_MOD(tcp_rtx_synack);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index c0e601e4f39c146d7859a59d4f2b2d07827e9d12..728bce01ccd3ddb1f374fa96b86434a415dbe2cb 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -750,7 +750,7 @@ void tcp_syn_ack_timeout(const struct request_sock *req)
 
 	__NET_INC_STATS(net, LINUX_MIB_TCPTIMEOUTS);
 }
-EXPORT_SYMBOL(tcp_syn_ack_timeout);
+EXPORT_IPV6_MOD(tcp_syn_ack_timeout);
 
 void tcp_reset_keepalive_timer(struct sock *sk, unsigned long len)
 {
@@ -772,7 +772,7 @@ void tcp_set_keepalive(struct sock *sk, int val)
 	else if (!val)
 		tcp_delete_keepalive_timer(sk);
 }
-EXPORT_SYMBOL_GPL(tcp_set_keepalive);
+EXPORT_IPV6_MOD_GPL(tcp_set_keepalive);
 
 static void tcp_keepalive_timer(struct timer_list *t)
 {
-- 
2.48.1.502.g6dc24dfdaf-goog


