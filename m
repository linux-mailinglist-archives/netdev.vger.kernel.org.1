Return-Path: <netdev+bounces-175214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E886DA6464A
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265583B0328
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B10220680;
	Mon, 17 Mar 2025 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x1RwGbc3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB91721CC79
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201599; cv=none; b=hBZHmq7tslPk5YUuN2KHmC+rEKdonUNW9a5DxmEMAgzNgW8ujdPzzjcJ5HW+7K9KVxIWzGY3JXjwHvrzh7S9k+j7mmTsjEorffbqPAqPEfcBaOrzEGBGaqEg9didP89jiA7makc+9zSeMG64dx9HLdmTrQA+YRL6RjZT+Y/PLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201599; c=relaxed/simple;
	bh=FB8+A7akOXLRNCyw0IDF9goQjKYgDuNR6fNZg2F/WL0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ql5kD2NC/KbgunxlCvlhux25v1Xaa3bErdgHDIZbemuza3AY/4fL8VwtpCU7qWIx1XfyZU/FwZboJQqMd4rpQvO8n9rgLvJ9/FDMq1u7SkNspGPDVmLj0vLIJOacPO2phI9ZCxHPgJm0btunMjDRt+EQ8AQ4hXMys3yAOVyr6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x1RwGbc3; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-476aa099fb3so145135851cf.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 01:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742201595; x=1742806395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lgXBbDUcMRi4jnDfmJZ/u7Y2hTviR7hICk/lVWqVPHM=;
        b=x1RwGbc3qpsTnTg//94OMQnAXmyXKjFXCiGCBgBIjsldma86m+vLXgBqI41HucNopI
         6uKWERvuKVdhzBYt+8ikOYbCoWozYgZ6EkbMNT7p8YiegxgHu+LWk8iEFL9DbGpYXfD9
         wrtl0qmbjZ52d4R40Ap8XGWSfN/xYkfWamWRsg+J9MvIY586t8cWozeD5L7PLIi6/qyL
         j/FufJuJTRbUPclcf4WVpQd1cZ9CPmyJ2B0hxbkCU2gSY1GkJ1dB4pNwoRuunREbZlzu
         Q+kICzbVV6sM2N94YaGZToa414oQMLSTOq96/eUkIxxOe+XSBzxp2W4GP5NxyLkYS5L8
         XhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742201595; x=1742806395;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgXBbDUcMRi4jnDfmJZ/u7Y2hTviR7hICk/lVWqVPHM=;
        b=jnL6O3blQlC/h/Y7dE/AlQn9jvHKmnJV34L5ugMOKfedeMQM6ESsAxx7xbXloF+7bN
         Stevvde4o5RcGuoyIL10BWIoYkPrDd4rTNXwqpW5JL/7Og7HRWkLz7T1bY8AkdWLr9hP
         AbafNy+bCntqCX1mbq+RZbXDQCBJdE7lJ6bHiAJMFiVO7+TGwvqiZfngx9e0txbMjxvA
         4YR7pzB4DYRpasWM0eNjK8ApLnzAw6IlfjFrcfOUBkmXekqXd38Mk02N4i40aNsu1R1h
         SL/KipsvZIncsN588Z2hCu0zXkaQ0OuocTgUUs7byn9SPC5o/YqOt9u8znIQYGXI1/KS
         5G4g==
X-Forwarded-Encrypted: i=1; AJvYcCVwNsLHYci93Wg+f7JDIKEcMdORVa/TOQVaObkTrVH+adLxtSwxFi+EBzrTIlWCTiWLjshNNf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtGXFY53q7LwcuidAVcWAIQyP7Yl4NFrTeloGpCg+qVp1lIfE
	fgiD4VUl66v2Ihmhp4zAjvP+MM+g4EFIFddd8fASrlABMCR27dvdFYRO+JjvqkJVoYpN9XrTo5V
	mRjoqpuhnYA==
X-Google-Smtp-Source: AGHT+IEZtWo6L8daKeX1RGJ91KajSAZB0mj0pEX2eaixmuq/CMCvMs11ZagprPjDRY3QGSxX1LTYVdo06Pk3Kw==
X-Received: from qtbhg17.prod.google.com ([2002:a05:622a:6111:b0:476:6e8b:6971])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:10e:b0:476:5fd5:4df8 with SMTP id d75a77b69052e-476c81d92cbmr165716411cf.45.1742201594853;
 Mon, 17 Mar 2025 01:53:14 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:53:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317085313.2023214-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move icsk_clean_acked to a better location
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

As a followup of my presentation in Zagreb for netdev 0x19:

icsk_clean_acked is only used by TCP when/if CONFIG_TLS_DEVICE
is enabled from tcp_ack().

Rename it to tcp_clean_acked, move it to tcp_sock structure
in the tcp_sock_read_rx for better cache locality in TCP
fast path.

Define this field only when CONFIG_TLS_DEVICE is enabled
saving 8 bytes on configs not using it.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst |  1 +
 include/linux/tcp.h                                  |  3 +++
 include/net/inet_connection_sock.h                   |  2 --
 include/net/tcp.h                                    |  4 ++--
 net/ipv4/tcp.c                                       |  5 +++++
 net/ipv4/tcp_input.c                                 | 12 ++++++------
 net/tls/tls_device.c                                 |  8 ++++----
 7 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 1f79765072b10d99e15815fdd8a4633c74051a7e..bc9b2131bf7acc888e8910b1c5926c83de48f9d6 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -27,6 +27,7 @@ u32                           dsack_dups
 u32                           snd_una                 read_mostly         read_write          tcp_wnd_end,tcp_urg_mode,tcp_minshall_check,tcp_cwnd_validate(tx);tcp_ack,tcp_may_update_window,tcp_clean_rtx_queue(write),tcp_ack_tstamp(rx)
 u32                           snd_sml                 read_write                              tcp_minshall_check,tcp_minshall_update
 u32                           rcv_tstamp                                  read_mostly         tcp_ack
+void *                        tcp_clean_acked                             read_mostly         tcp_ack
 u32                           lsndtime                read_write                              tcp_slow_start_after_idle_check,tcp_event_data_sent
 u32                           last_oow_ack_time
 u32                           compressed_ack_rcv_nxt
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 159b2c59eb6271030dc2c8d58b43229ebef10ea5..1669d95bb0f9aa97e1e74b7b62bb252eb404fbfb 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -244,6 +244,9 @@ struct tcp_sock {
 	struct  minmax rtt_min;
 	/* OOO segments go in this rbtree. Socket lock must be held. */
 	struct rb_root	out_of_order_queue;
+#if defined(CONFIG_TLS_DEVICE)
+	void (*tcp_clean_acked)(struct sock *sk, u32 acked_seq);
+#endif
 	u32	snd_ssthresh;	/* Slow start size threshold		*/
 	u8	recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
 	__cacheline_group_end(tcp_sock_read_rx);
diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
index d9978ffacc970efd308d0011a094aec41b561e65..96e5e4551479a7c55aabeb1aec38fc4cc7d1c958 100644
--- a/include/net/inet_connection_sock.h
+++ b/include/net/inet_connection_sock.h
@@ -66,7 +66,6 @@ struct inet_connection_sock_af_ops {
  * @icsk_af_ops		   Operations which are AF_INET{4,6} specific
  * @icsk_ulp_ops	   Pluggable ULP control hook
  * @icsk_ulp_data	   ULP private data
- * @icsk_clean_acked	   Clean acked data hook
  * @icsk_ca_state:	   Congestion control state
  * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
  * @icsk_pending:	   Scheduled timer event
@@ -97,7 +96,6 @@ struct inet_connection_sock {
 	const struct inet_connection_sock_af_ops *icsk_af_ops;
 	const struct tcp_ulp_ops  *icsk_ulp_ops;
 	void __rcu		  *icsk_ulp_data;
-	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
 	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
 	__u8			  icsk_ca_state:5,
 				  icsk_ca_initialized:1,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7207c52b1fc9ce3cd9cf2a8580310d0e629f82d6..a8171d4d316b8636bdb065ba145942e1c13d64cb 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2770,9 +2770,9 @@ extern struct static_key_false tcp_have_smc;
 #endif
 
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
-void clean_acked_data_enable(struct inet_connection_sock *icsk,
+void clean_acked_data_enable(struct tcp_sock *tp,
 			     void (*cad)(struct sock *sk, u32 ack_seq));
-void clean_acked_data_disable(struct inet_connection_sock *icsk);
+void clean_acked_data_disable(struct tcp_sock *tp);
 void clean_acked_data_flush(void);
 #endif
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 46951e74930844af952dfbc57a107b504d4e296b..26465361c81708ebcac64e149b8920b1eae71ede 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5026,7 +5026,12 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rtt_min);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, out_of_order_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_ssthresh);
+#if IS_ENABLED(CONFIG_TLS_DEVICE)
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, tcp_clean_acked);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 77);
+#else
 	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 69);
+#endif
 
 	/* TX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, segs_out);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4e221234808898131a462bc93ee4c9c0ae04309e..36a82c0496e7065d63a61ef4d45499ba34680723 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -118,18 +118,18 @@ int sysctl_tcp_max_orphans __read_mostly = NR_FILE;
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
 static DEFINE_STATIC_KEY_DEFERRED_FALSE(clean_acked_data_enabled, HZ);
 
-void clean_acked_data_enable(struct inet_connection_sock *icsk,
+void clean_acked_data_enable(struct tcp_sock *tp,
 			     void (*cad)(struct sock *sk, u32 ack_seq))
 {
-	icsk->icsk_clean_acked = cad;
+	tp->tcp_clean_acked = cad;
 	static_branch_deferred_inc(&clean_acked_data_enabled);
 }
 EXPORT_SYMBOL_GPL(clean_acked_data_enable);
 
-void clean_acked_data_disable(struct inet_connection_sock *icsk)
+void clean_acked_data_disable(struct tcp_sock *tp)
 {
 	static_branch_slow_dec_deferred(&clean_acked_data_enabled);
-	icsk->icsk_clean_acked = NULL;
+	tp->tcp_clean_acked = NULL;
 }
 EXPORT_SYMBOL_GPL(clean_acked_data_disable);
 
@@ -3962,8 +3962,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
 		if (static_branch_unlikely(&clean_acked_data_enabled.key))
-			if (icsk->icsk_clean_acked)
-				icsk->icsk_clean_acked(sk, ack);
+			if (tp->tcp_clean_acked)
+				tp->tcp_clean_acked(sk, ack);
 #endif
 	}
 
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index e50b6e71df13be57183bcccdd00768f0f5a7cd95..f672a62a9a52f6ea7a0f5c500acdf9538f08d297 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -157,7 +157,7 @@ static void delete_all_records(struct tls_offload_context_tx *offload_ctx)
 	offload_ctx->retransmit_hint = NULL;
 }
 
-static void tls_icsk_clean_acked(struct sock *sk, u32 acked_seq)
+static void tls_tcp_clean_acked(struct sock *sk, u32 acked_seq)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_record_info *info, *temp;
@@ -204,7 +204,7 @@ void tls_device_sk_destruct(struct sock *sk)
 			destroy_record(ctx->open_record);
 		delete_all_records(ctx);
 		crypto_free_aead(ctx->aead_send);
-		clean_acked_data_disable(inet_csk(sk));
+		clean_acked_data_disable(tcp_sk(sk));
 	}
 
 	tls_device_queue_ctx_destruction(tls_ctx);
@@ -1126,7 +1126,7 @@ int tls_set_device_offload(struct sock *sk)
 	start_marker_record->num_frags = 0;
 	list_add_tail(&start_marker_record->list, &offload_ctx->records_list);
 
-	clean_acked_data_enable(inet_csk(sk), &tls_icsk_clean_acked);
+	clean_acked_data_enable(tcp_sk(sk), &tls_tcp_clean_acked);
 	ctx->push_pending_record = tls_device_push_pending_record;
 
 	/* TLS offload is greatly simplified if we don't send
@@ -1172,7 +1172,7 @@ int tls_set_device_offload(struct sock *sk)
 
 release_lock:
 	up_read(&device_offload_lock);
-	clean_acked_data_disable(inet_csk(sk));
+	clean_acked_data_disable(tcp_sk(sk));
 	crypto_free_aead(offload_ctx->aead_send);
 free_offload_ctx:
 	kfree(offload_ctx);
-- 
2.49.0.rc1.451.g8f38331e32-goog


