Return-Path: <netdev+bounces-251839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEskEDuocGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:19:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C7551C4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4749F389C2F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9FB481AAB;
	Wed, 21 Jan 2026 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hhwSogsK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94668481A9F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989571; cv=none; b=bPLO537KBfyEqb8g192q4RhU2QHaF6bbAajue+IuQuVD9sn964mULRC+D/42JCjOSNPu+VaPXko/w0e7/5w9mMaGTVuDPEY0oaErSbYgMJC9eaRfX/GEpoT3eGh444b0W5MRnB3shWyT6EWCvCHe+HTejcY1Q3a17Ujfzux5KCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989571; c=relaxed/simple;
	bh=XdWBqOJuLGqn49lCdQfnSlLXVhMb8hX0joCHDVwQb3w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fsoZbGkAnkHL14A/xoiJCXykF/+eAvg742Cc33RurT5ScBDKV6AWpwV24YvK8j47jGqYAcDbazWM/3l81GBuwmFgq15szK7rphhAoc5lVRhLYfKJxcvtnGsmF4g8R88FGaqi7gmhceF+v8zQE8oAt+G/UBuB9WZ07ezbdOQADCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hhwSogsK; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c6a341ac9fso305471485a.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768989568; x=1769594368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=baBPMx6fR6nrtpG57RAA9kqe+KK+aGd/pdKMyAA31Fs=;
        b=hhwSogsKUUwuDnyS22auM02DAGQG9i5afVWaAsWgo1YcAmRR957R5yG8NWXF2i5KE+
         2jpnldKcHZrz3mLIdsC1fb6vVXAXEbIg7o82lBpj49XskdQvLdNtFzTWTF7ZZN6U1rtb
         FO6nP8aKI8Y+8L3w5Bm72Tky8q1K/16rn3/unus/zHcPgpteWZeBEGLlnzc33Sp0UAHI
         HXnWSuxreIEfqP2QkSU9xDn0cEAaMWWOUEM9xfhQH7bAry8247Sis8ESwont7BE7nGm7
         /7eNjQXH6w5TcF7unyOKLMat4n8k+jZS86YvR738LC8ltqSFzQCSO5EH1tolTXldlFjd
         rqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989568; x=1769594368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baBPMx6fR6nrtpG57RAA9kqe+KK+aGd/pdKMyAA31Fs=;
        b=tPWlADM0wnOsi3oQfJOnte5M5EW6vB0UwGXDCE8YIXOaGnQwcbBd+PK+pGngZ4mtrH
         QwaLuyj2ArVdc1YVjjGCJ61imPKPWBmvOwspol8DvlsWkac5lNlLTtorealWG/z3zQm1
         GcSgLBaEVW0Y19a2ndUYGirsP5JEF0WCBXs9yFWu2bdQGXaT2VuhuAE8phPP+1wvaGqW
         TO3UNNRR7ZB8RSvWzn92ZMEP1yC6Npk4pbBnf30UE6WLJuAScQfZWrcAO4uqwsxkvQmC
         mw/3byqd9S5b2sCRU16sKFiDJG17g1hRBFrfYUHCUfUCR789WnyPiHUv0Pr/qVseoVmI
         6xcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVyhF3iiPvCoKkzQJQLaq4hq8d8phMqzdiTKQdkfd6mnocfpSzpnOFMbNnCDczKHB5I76VcNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFeU7ILu2aQDbLBqgVdXRi6AxEHFa0jqnpQ9WsHPjNrMN7UoD
	r/NZ3R2VR3ScnKJhu+HP8pnhLcG93AUqzja5JApBq8TGGIzOIdPYR/bBht37gbM43IR6+yaljE4
	rPdbwQzo9wWMHMw==
X-Received: from qkhk23.prod.google.com ([2002:a05:620a:b97:b0:8b1:45e5:3926])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4455:b0:8c5:2e83:d023 with SMTP id af79cd13be357-8c6cce3b6d3mr601598785a.64.1768989568285;
 Wed, 21 Jan 2026 01:59:28 -0800 (PST)
Date: Wed, 21 Jan 2026 09:59:23 +0000
In-Reply-To: <20260121095923.3134639-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121095923.3134639-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121095923.3134639-3-edumazet@google.com>
Subject: [PATCH net-next 2/2] tcp: move tcp_rate_check_app_limited() to tcp.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251839-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,vmlinux.new:url]
X-Rspamd-Queue-Id: C85C7551C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_rate_check_app_limited() is used from tcp_sendmsg_locked()
fast path and from other callers.

Move it to tcp.c so that it can be inlined in tcp_sendmsg_locked().

Small increase of code, for better TCP performance.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 1/0 up/down: 87/0 (87)
Function                                     old     new   delta
tcp_sendmsg_locked                          4217    4304     +87
Total: Before=22566462, After=22566549, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h   |  3 +--
 net/ipv4/Makefile   |  2 +-
 net/ipv4/tcp.c      | 18 ++++++++++++++++++
 net/ipv4/tcp_rate.c | 20 --------------------
 4 files changed, 20 insertions(+), 23 deletions(-)
 delete mode 100644 net/ipv4/tcp_rate.c

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d6a77b59dddeb065d3a2df12543878ccc4704a3f..01c8ba2c42f6e3f5debb4350b2a5970d7328a93d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -809,6 +809,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize)
 
 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_rate_check_app_limited(struct sock *sk);
 
 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
@@ -1355,8 +1356,6 @@ static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 /* From tcp_cong.c */
 void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
 
-/* From tcp_rate.c */
-void tcp_rate_check_app_limited(struct sock *sk);
 
 static inline bool tcp_skb_sent_after(u64 t1, u64 t2, u32 seq1, u32 seq2)
 {
diff --git a/net/ipv4/Makefile b/net/ipv4/Makefile
index ec36d2ec059e800ec840e61a9e480e17c4c585ba..18108a6f0499907a675aead180f90a7b8ca2ea6c 100644
--- a/net/ipv4/Makefile
+++ b/net/ipv4/Makefile
@@ -9,7 +9,7 @@ obj-y     := route.o inetpeer.o protocol.o \
 	     inet_timewait_sock.o inet_connection_sock.o \
 	     tcp.o tcp_input.o tcp_output.o tcp_timer.o tcp_ipv4.o \
 	     tcp_minisocks.o tcp_cong.o tcp_metrics.o tcp_fastopen.o \
-	     tcp_rate.o tcp_recovery.o tcp_ulp.o \
+	     tcp_recovery.o tcp_ulp.o \
 	     tcp_offload.o tcp_plb.o datagram.o raw.o udp.o udplite.o \
 	     udp_offload.o arp.o icmp.o devinet.o af_inet.o igmp.o \
 	     fib_frontend.o fib_semantics.o fib_trie.o fib_notifier.o \
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d5319ebe24525ef9c1f0ea0297eb6c70878e0b29..148cdf3cd6233add37ea52e273cb4fb3e75fcbcb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1074,6 +1074,24 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
 	return err;
 }
 
+/* If a gap is detected between sends, mark the socket application-limited. */
+void tcp_rate_check_app_limited(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (/* We have less than one packet to send. */
+	    tp->write_seq - tp->snd_nxt < tp->mss_cache &&
+	    /* Nothing in sending host's qdisc queues or NIC tx queue. */
+	    sk_wmem_alloc_get(sk) < SKB_TRUESIZE(1) &&
+	    /* We are not limited by CWND. */
+	    tcp_packets_in_flight(tp) < tcp_snd_cwnd(tp) &&
+	    /* All lost packets have been retransmitted. */
+	    tp->lost_out <= tp->retrans_out)
+		tp->app_limited =
+			(tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
+}
+EXPORT_SYMBOL_GPL(tcp_rate_check_app_limited);
+
 int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 {
 	struct net_devmem_dmabuf_binding *binding = NULL;
diff --git a/net/ipv4/tcp_rate.c b/net/ipv4/tcp_rate.c
deleted file mode 100644
index 272806ba3b4e451362af1a9ede01f7ad378865cb..0000000000000000000000000000000000000000
--- a/net/ipv4/tcp_rate.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <net/tcp.h>
-
-/* If a gap is detected between sends, mark the socket application-limited. */
-void tcp_rate_check_app_limited(struct sock *sk)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	if (/* We have less than one packet to send. */
-	    tp->write_seq - tp->snd_nxt < tp->mss_cache &&
-	    /* Nothing in sending host's qdisc queues or NIC tx queue. */
-	    sk_wmem_alloc_get(sk) < SKB_TRUESIZE(1) &&
-	    /* We are not limited by CWND. */
-	    tcp_packets_in_flight(tp) < tcp_snd_cwnd(tp) &&
-	    /* All lost packets have been retransmitted. */
-	    tp->lost_out <= tp->retrans_out)
-		tp->app_limited =
-			(tp->delivered + tcp_packets_in_flight(tp)) ? : 1;
-}
-EXPORT_SYMBOL_GPL(tcp_rate_check_app_limited);
-- 
2.52.0.457.g6b5491de43-goog


