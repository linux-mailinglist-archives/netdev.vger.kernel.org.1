Return-Path: <netdev+bounces-241184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840EDC810C8
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 15:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB623A9E3E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A346C280A3B;
	Mon, 24 Nov 2025 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+52zdpn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187B28152A
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994644; cv=none; b=gboMIiQiB/Y6uPFheb9hN5qq3bTENuRsIhWPZuVTw0OKES7SR7uXi3WC4zrquICNEDhNfCIazbiD1TOK32j9vZKTUCTta7arMEifDchHYrDJCId8lVV8eu71yZSHDwalNRHF9sBIjgr+xKHcjp78VBjQ3/VhZwHnw9sIkNiIPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994644; c=relaxed/simple;
	bh=UVdt4O3MXXGZWpPUvZJL+BEeg/ROxMGZcGZGQPuT86Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TCwGSPssK5IBEvex0X/MklnlWUzOY0OaOlgfXUy2BzGTT1xw3j8MXapzIXujZMLuHY3OjwrrbLfEh1kbei5l89RgwsHw/dCCKgKdo+UnxbziL2WdYjAQeJy61aWhMZKojXf230AmD45YpcGymsRZSG7vwF6/R46EcPu7nROsTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+52zdpn; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b220ddc189so510824185a.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763994640; x=1764599440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYW82/OQPizvlnuIFpJI9bh1i/PGfyIpeKywW7eClrI=;
        b=T+52zdpn0UNfTKlzF+vc4bztM8YWFbQVqVaP8Gp1sD7OZuo4AXFOi82iUCGNARemXX
         Af9hYK7ZKgoekXMBaB1ABNGrOmQtnq0XjqPUC+vMY4y95aOIzj9DhAuDVa2fDLd4ypLQ
         zXP6Px6y0HWlN1dNUylxh2L0lIxyXjBk98rSoqQUCJh2EmnTeZYIIB24aTF9geFNsn3R
         yS0l9vcmpC+ouGRsedfU3TqlmrW9FURQXkYVeUXJfsUHyMy7qObPKq4/hvLdtsRjQhkE
         X1JykLbcam7Ih1DG5ftORme6fyw4LpHd6Bk5EOG3En5auxOw/UuV+RReeApOCJp5nVAe
         MTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763994640; x=1764599440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYW82/OQPizvlnuIFpJI9bh1i/PGfyIpeKywW7eClrI=;
        b=gyt8LheYXsDvHceg6wNrzoSuh1d3esiGydv/h06aARggAD7G7ex5H4V18Hnc/v2Ou5
         bppn6g2DpXorQn+cX0K28ToDyYlY8HUyWUSe7iEuvuP8XnXTr/LfBsdcYRbAaYfNgsZ4
         olQN22RV1IckaTZdR73zitztmATJsBb+zu5cHd6qfrzXzQwuoYgN7IXsAVLMWY2poaus
         p6lpMsWiu/3lpj4pjFi090SesPc5PWq0JzA8PudT3N/s0euald1DGXwYyV4CbD3GXCRm
         FT/Q6fB0SLdKOM0/SVlul5b/Mtz7Z1E3BUrJe5yAuhbfswaRMjar9IIByNO5Xbz3pvEZ
         qYBA==
X-Gm-Message-State: AOJu0YzsGUQ3iNu84G8V2NUvJkHNrYZNDKDUUI4ASWEabQfgUDr7rXxj
	uT7koYKW5SiPhfW5dSj6rh9O00IUo8ZzCTqOCRhezg73/3o9ZSQRe8JXiKGPMybsKtU=
X-Gm-Gg: ASbGncsxBrECoqnO8YYcQA19ZvU+gAtIQfjPqaDDtUgGenP/EESvEVQSM4ezUpeS8qd
	/OjMvanFtfoUSqDeHRkLIzYttNZQl/jLrdGYEcPv6xz35KU/a97VwxkY1R86O7GVDu44xtVw528
	rjsf67SI47UJxRbe4FTkoMaWP97VVrxDr7Sj8YQ3Nxo3WqDZVBrg7igXhj26OtRVsnx14LgNqCC
	FbCFl8NRULIkzAKlgr7rYFQMqu9Eonw1Qe17+SXJyszovL643pjXYO6XvqX+X5HrB4AhnGwUs+/
	224kJ4XwNlKQL5JvbwL1rZ8nxE1wqpsLYcnhPEFOE1xThzNnVh3e0eouub4ljjVpQxbnQAHP7xC
	AyQRsmliORy8sHlznwIwoBhm2XAde9rascKxn7zpVBJW45pDrSbQJxqUi4m8MQm4ZocSnaG5shm
	QsYR6oUUHjC7K/YCDNlTUFxiKGnM4G13qZT/oJVkGaeJzh+XCh5cE=
X-Google-Smtp-Source: AGHT+IH2zWa7dCmy/GAWtEY4wsXh5TgwpKNNJUkUwxMEWavwGXNbU3/M0zpGKAGA5p0Rux0Cxv5ZhQ==
X-Received: by 2002:a05:620a:4402:b0:8b2:e17a:37 with SMTP id af79cd13be357-8b33d478a6emr1351906185a.43.1763994639737;
        Mon, 24 Nov 2025 06:30:39 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3294321fdsm929713485a.12.2025.11.24.06.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 06:30:39 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	quic@lists.linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Metzmacher <metze@samba.org>,
	Moritz Buhl <mbuhl@openbsd.org>,
	Tyler Fanelli <tfanelli@redhat.com>,
	Pengtao He <hepengtao@xiaomi.com>,
	Thomas Dreibholz <dreibh@simula.no>,
	linux-cifs@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Steve Dickson <steved@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Alexander Aring <aahringo@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	John Ericson <mail@johnericson.me>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"D . Wythe" <alibuda@linux.alibaba.com>,
	Jason Baron <jbaron@akamai.com>,
	illiliti <illiliti@protonmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Daniel Stenberg <daniel@haxx.se>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next v5 13/16] quic: add timer management
Date: Mon, 24 Nov 2025 09:28:26 -0500
Message-ID: <0409d12fd4262e885cd5fd178a4f48df6a28d96d.1763994509.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1763994509.git.lucien.xin@gmail.com>
References: <cover.1763994509.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces 'quic_timer' to unify and manage the five main
timers used in QUIC: loss detection, delayed ACK, path validation,
PMTU probing, and pacing. These timers are critical for driving
retransmissions, connection liveness, and flow control.

Each timer type is initialized, started, reset, or stopped using a common
set of operations.

- quic_timer_reset(): Reset a timer with type and timeout

- quic_timer_start(): Start a timer with type and timeout

- quic_timer_stop(): Stop a timer with type

Although handler functions for each timer are defined, they are currently
placeholders; their logic will be implemented in upcoming patches for
packet transmission and outqueue handling.

Deferred timer actions are also integrated through quic_release_cb(),
which dispatches to the appropriate handler when timers expire.

Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
v5:
  - Rename QUIC_TSQ_DEFERRED to QUIC_PACE_DEFERRED.
---
 net/quic/Makefile |   2 +-
 net/quic/socket.c |  33 ++++++++
 net/quic/socket.h |  33 ++++++++
 net/quic/timer.c  | 196 ++++++++++++++++++++++++++++++++++++++++++++++
 net/quic/timer.h  |  47 +++++++++++
 5 files changed, 310 insertions(+), 1 deletion(-)
 create mode 100644 net/quic/timer.c
 create mode 100644 net/quic/timer.h

diff --git a/net/quic/Makefile b/net/quic/Makefile
index 58bb18f7926d..2ccf01ad9e22 100644
--- a/net/quic/Makefile
+++ b/net/quic/Makefile
@@ -6,4 +6,4 @@
 obj-$(CONFIG_IP_QUIC) += quic.o
 
 quic-y := common.o family.o protocol.o socket.o stream.o connid.o path.o \
-	  cong.o pnspace.o crypto.o
+	  cong.o pnspace.o crypto.o timer.o
diff --git a/net/quic/socket.c b/net/quic/socket.c
index 895fbcbdce22..0a6e59f85d32 100644
--- a/net/quic/socket.c
+++ b/net/quic/socket.c
@@ -47,6 +47,8 @@ static int quic_init_sock(struct sock *sk)
 	quic_conn_id_set_init(quic_dest(sk), 0);
 	quic_cong_init(quic_cong(sk));
 
+	quic_timer_init(sk);
+
 	if (quic_stream_init(quic_streams(sk)))
 		return -ENOMEM;
 
@@ -68,6 +70,8 @@ static void quic_destroy_sock(struct sock *sk)
 {
 	u8 i;
 
+	quic_timer_free(sk);
+
 	for (i = 0; i < QUIC_PNSPACE_MAX; i++)
 		quic_pnspace_free(quic_pnspace(sk, i));
 	for (i = 0; i < QUIC_CRYPTO_MAX; i++)
@@ -204,6 +208,35 @@ EXPORT_SYMBOL_GPL(quic_kernel_getsockopt);
 
 static void quic_release_cb(struct sock *sk)
 {
+	/* Similar to tcp_release_cb(). */
+	unsigned long nflags, flags = smp_load_acquire(&sk->sk_tsq_flags);
+
+	do {
+		if (!(flags & QUIC_DEFERRED_ALL))
+			return;
+		nflags = flags & ~QUIC_DEFERRED_ALL;
+	} while (!try_cmpxchg(&sk->sk_tsq_flags, &flags, nflags));
+
+	if (flags & QUIC_F_LOSS_DEFERRED) {
+		quic_timer_loss_handler(sk);
+		__sock_put(sk);
+	}
+	if (flags & QUIC_F_SACK_DEFERRED) {
+		quic_timer_sack_handler(sk);
+		__sock_put(sk);
+	}
+	if (flags & QUIC_F_PATH_DEFERRED) {
+		quic_timer_path_handler(sk);
+		__sock_put(sk);
+	}
+	if (flags & QUIC_F_PMTU_DEFERRED) {
+		quic_timer_pmtu_handler(sk);
+		__sock_put(sk);
+	}
+	if (flags & QUIC_F_PACE_DEFERRED) {
+		quic_timer_pace_handler(sk);
+		__sock_put(sk);
+	}
 }
 
 static int quic_disconnect(struct sock *sk, int flags)
diff --git a/net/quic/socket.h b/net/quic/socket.h
index fc203eecbb8b..5e9b21430f42 100644
--- a/net/quic/socket.h
+++ b/net/quic/socket.h
@@ -21,6 +21,7 @@
 #include "cong.h"
 
 #include "protocol.h"
+#include "timer.h"
 
 extern struct proto quic_prot;
 extern struct proto quicv6_prot;
@@ -32,6 +33,31 @@ enum quic_state {
 	QUIC_SS_ESTABLISHED	= TCP_ESTABLISHED,
 };
 
+enum quic_tsq_enum {
+	QUIC_MTU_REDUCED_DEFERRED,
+	QUIC_LOSS_DEFERRED,
+	QUIC_SACK_DEFERRED,
+	QUIC_PATH_DEFERRED,
+	QUIC_PMTU_DEFERRED,
+	QUIC_PACE_DEFERRED,
+};
+
+enum quic_tsq_flags {
+	QUIC_F_MTU_REDUCED_DEFERRED	= BIT(QUIC_MTU_REDUCED_DEFERRED),
+	QUIC_F_LOSS_DEFERRED		= BIT(QUIC_LOSS_DEFERRED),
+	QUIC_F_SACK_DEFERRED		= BIT(QUIC_SACK_DEFERRED),
+	QUIC_F_PATH_DEFERRED		= BIT(QUIC_PATH_DEFERRED),
+	QUIC_F_PMTU_DEFERRED		= BIT(QUIC_PMTU_DEFERRED),
+	QUIC_F_PACE_DEFERRED		= BIT(QUIC_PACE_DEFERRED),
+};
+
+#define QUIC_DEFERRED_ALL (QUIC_F_MTU_REDUCED_DEFERRED |	\
+			   QUIC_F_LOSS_DEFERRED |		\
+			   QUIC_F_SACK_DEFERRED |		\
+			   QUIC_F_PATH_DEFERRED |		\
+			   QUIC_F_PMTU_DEFERRED |		\
+			   QUIC_F_PACE_DEFERRED)
+
 struct quic_sock {
 	struct inet_sock		inet;
 	struct list_head		reqs;
@@ -48,6 +74,8 @@ struct quic_sock {
 	struct quic_cong		cong;
 	struct quic_pnspace		space[QUIC_PNSPACE_MAX];
 	struct quic_crypto		crypto[QUIC_CRYPTO_MAX];
+
+	struct quic_timer		timers[QUIC_TIMER_MAX];
 };
 
 struct quic6_sock {
@@ -125,6 +153,11 @@ static inline struct quic_crypto *quic_crypto(const struct sock *sk, u8 level)
 	return &quic_sk(sk)->crypto[level];
 }
 
+static inline void *quic_timer(const struct sock *sk, u8 type)
+{
+	return (void *)&quic_sk(sk)->timers[type];
+}
+
 static inline bool quic_is_establishing(struct sock *sk)
 {
 	return sk->sk_state == QUIC_SS_ESTABLISHING;
diff --git a/net/quic/timer.c b/net/quic/timer.c
new file mode 100644
index 000000000000..6f957385a341
--- /dev/null
+++ b/net/quic/timer.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Initialization/cleanup for QUIC protocol support.
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+#include "socket.h"
+
+void quic_timer_sack_handler(struct sock *sk)
+{
+}
+
+static void quic_timer_sack_timeout(struct timer_list *t)
+{
+	struct quic_sock *qs = container_of(t, struct quic_sock, timers[QUIC_TIMER_SACK].t);
+	struct sock *sk = &qs->inet.sk;
+
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		if (!test_and_set_bit(QUIC_SACK_DEFERRED, &sk->sk_tsq_flags))
+			sock_hold(sk);
+		goto out;
+	}
+
+	quic_timer_sack_handler(sk);
+out:
+	bh_unlock_sock(sk);
+	sock_put(sk);
+}
+
+void quic_timer_loss_handler(struct sock *sk)
+{
+}
+
+static void quic_timer_loss_timeout(struct timer_list *t)
+{
+	struct quic_sock *qs = container_of(t, struct quic_sock, timers[QUIC_TIMER_LOSS].t);
+	struct sock *sk = &qs->inet.sk;
+
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		if (!test_and_set_bit(QUIC_LOSS_DEFERRED, &sk->sk_tsq_flags))
+			sock_hold(sk);
+		goto out;
+	}
+
+	quic_timer_loss_handler(sk);
+out:
+	bh_unlock_sock(sk);
+	sock_put(sk);
+}
+
+void quic_timer_path_handler(struct sock *sk)
+{
+}
+
+static void quic_timer_path_timeout(struct timer_list *t)
+{
+	struct quic_sock *qs = container_of(t, struct quic_sock, timers[QUIC_TIMER_PATH].t);
+	struct sock *sk = &qs->inet.sk;
+
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		if (!test_and_set_bit(QUIC_PATH_DEFERRED, &sk->sk_tsq_flags))
+			sock_hold(sk);
+		goto out;
+	}
+
+	quic_timer_path_handler(sk);
+out:
+	bh_unlock_sock(sk);
+	sock_put(sk);
+}
+
+void quic_timer_reset_path(struct sock *sk)
+{
+	struct quic_cong *cong = quic_cong(sk);
+	u64 timeout = cong->pto * 2;
+
+	/* Calculate timeout based on cong.pto, but enforce a lower bound. */
+	if (timeout < QUIC_MIN_PATH_TIMEOUT)
+		timeout = QUIC_MIN_PATH_TIMEOUT;
+	quic_timer_reset(sk, QUIC_TIMER_PATH, timeout);
+}
+
+void quic_timer_pmtu_handler(struct sock *sk)
+{
+}
+
+static void quic_timer_pmtu_timeout(struct timer_list *t)
+{
+	struct quic_sock *qs = container_of(t, struct quic_sock, timers[QUIC_TIMER_PMTU].t);
+	struct sock *sk = &qs->inet.sk;
+
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		if (!test_and_set_bit(QUIC_PMTU_DEFERRED, &sk->sk_tsq_flags))
+			sock_hold(sk);
+		goto out;
+	}
+
+	quic_timer_pmtu_handler(sk);
+out:
+	bh_unlock_sock(sk);
+	sock_put(sk);
+}
+
+void quic_timer_pace_handler(struct sock *sk)
+{
+}
+
+static enum hrtimer_restart quic_timer_pace_timeout(struct hrtimer *hr)
+{
+	struct quic_sock *qs = container_of(hr, struct quic_sock, timers[QUIC_TIMER_PACE].hr);
+	struct sock *sk = &qs->inet.sk;
+
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		if (!test_and_set_bit(QUIC_PACE_DEFERRED, &sk->sk_tsq_flags))
+			sock_hold(sk);
+		goto out;
+	}
+
+	quic_timer_pace_handler(sk);
+out:
+	bh_unlock_sock(sk);
+	sock_put(sk);
+	return HRTIMER_NORESTART;
+}
+
+void quic_timer_reset(struct sock *sk, u8 type, u64 timeout)
+{
+	struct timer_list *t = quic_timer(sk, type);
+
+	if (timeout && !mod_timer(t, jiffies + usecs_to_jiffies(timeout)))
+		sock_hold(sk);
+}
+
+void quic_timer_start(struct sock *sk, u8 type, u64 timeout)
+{
+	struct timer_list *t;
+	struct hrtimer *hr;
+
+	if (type == QUIC_TIMER_PACE) {
+		hr = quic_timer(sk, type);
+
+		if (!hrtimer_is_queued(hr)) {
+			hrtimer_start(hr, ns_to_ktime(timeout), HRTIMER_MODE_ABS_PINNED_SOFT);
+			sock_hold(sk);
+		}
+		return;
+	}
+
+	t = quic_timer(sk, type);
+	if (timeout && !timer_pending(t)) {
+		if (!mod_timer(t, jiffies + usecs_to_jiffies(timeout)))
+			sock_hold(sk);
+	}
+}
+
+void quic_timer_stop(struct sock *sk, u8 type)
+{
+	if (type == QUIC_TIMER_PACE) {
+		if (hrtimer_try_to_cancel(quic_timer(sk, type)) == 1)
+			sock_put(sk);
+		return;
+	}
+	if (timer_delete(quic_timer(sk, type)))
+		sock_put(sk);
+}
+
+void quic_timer_init(struct sock *sk)
+{
+	timer_setup(quic_timer(sk, QUIC_TIMER_LOSS), quic_timer_loss_timeout, 0);
+	timer_setup(quic_timer(sk, QUIC_TIMER_SACK), quic_timer_sack_timeout, 0);
+	timer_setup(quic_timer(sk, QUIC_TIMER_PATH), quic_timer_path_timeout, 0);
+	timer_setup(quic_timer(sk, QUIC_TIMER_PMTU), quic_timer_pmtu_timeout, 0);
+	/* Use hrtimer for pace timer, ensuring precise control over send timing. */
+	hrtimer_setup(quic_timer(sk, QUIC_TIMER_PACE), quic_timer_pace_timeout,
+		      CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_SOFT);
+}
+
+void quic_timer_free(struct sock *sk)
+{
+	quic_timer_stop(sk, QUIC_TIMER_LOSS);
+	quic_timer_stop(sk, QUIC_TIMER_SACK);
+	quic_timer_stop(sk, QUIC_TIMER_PATH);
+	quic_timer_stop(sk, QUIC_TIMER_PMTU);
+	quic_timer_stop(sk, QUIC_TIMER_PACE);
+}
diff --git a/net/quic/timer.h b/net/quic/timer.h
new file mode 100644
index 000000000000..61b094325334
--- /dev/null
+++ b/net/quic/timer.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* QUIC kernel implementation
+ * (C) Copyright Red Hat Corp. 2023
+ *
+ * This file is part of the QUIC kernel implementation
+ *
+ * Written or modified by:
+ *    Xin Long <lucien.xin@gmail.com>
+ */
+
+enum {
+	QUIC_TIMER_LOSS,	/* Loss detection timer: triggers retransmission on packet loss */
+	QUIC_TIMER_SACK,	/* ACK delay timer, also used as idle timer alias */
+	QUIC_TIMER_PATH,	/* Path validation timer: verifies network path connectivity */
+	QUIC_TIMER_PMTU,	/* Packetization Layer Path MTU Discovery probing timer */
+	QUIC_TIMER_PACE,	/* Pacing timer: controls packet transmission pacing */
+	QUIC_TIMER_MAX,
+	QUIC_TIMER_IDLE = QUIC_TIMER_SACK,
+};
+
+struct quic_timer {
+	union {
+		struct timer_list t;
+		struct hrtimer hr;
+	};
+};
+
+#define QUIC_MIN_PROBE_TIMEOUT	5000000
+
+#define QUIC_MIN_PATH_TIMEOUT	1500000
+
+#define QUIC_MIN_IDLE_TIMEOUT	1000000
+#define QUIC_DEF_IDLE_TIMEOUT	30000000
+
+void quic_timer_reset(struct sock *sk, u8 type, u64 timeout);
+void quic_timer_start(struct sock *sk, u8 type, u64 timeout);
+void quic_timer_stop(struct sock *sk, u8 type);
+void quic_timer_init(struct sock *sk);
+void quic_timer_free(struct sock *sk);
+
+void quic_timer_reset_path(struct sock *sk);
+
+void quic_timer_loss_handler(struct sock *sk);
+void quic_timer_pace_handler(struct sock *sk);
+void quic_timer_path_handler(struct sock *sk);
+void quic_timer_sack_handler(struct sock *sk);
+void quic_timer_pmtu_handler(struct sock *sk);
-- 
2.47.1


