Return-Path: <netdev+bounces-224524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D3EB85DC0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A451B3B7D81
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE44C3164C1;
	Thu, 18 Sep 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QVDdFFUl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDF3081AA
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210943; cv=none; b=DqbFKwQn0sHRhG5PlABJfvrA9eCYNtO/FTx0nHRkDXUe07f71vR7H8rCSitQrl0B2WOTr6/ux9zf/gp6CTtnUc0GAJqz+XKlCF/Tau7stBJGqjrBANeX3B1NVfjEcR86DgCg8+yU6lF7PHT+jwhEvSAQJYh83i702170D4cuHog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210943; c=relaxed/simple;
	bh=KaMqDbOOnLEmvBo1zBM2qVydehbKNeU40zDOMF9QnVM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bOhUG4gJssyeJbc5e7hHi2IfDRe4aXt6SwdpfaUoUKTZ1bZP5i3bcijts4dUSVT1Gw9x8f+Ylx/9Z0Jx+h2xZIUoOHwhRFXNnOW+L+Uy7Vagzlc6cnp+EW3y0Riy2STiZfDcWmzdIQZGagQyG6amAoEidm3U8x4SrMx3i+eFf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVDdFFUl; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8063443ef8cso302969385a.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210941; x=1758815741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RE60dwLTneNoKeZ1sfL+FqOR97T6/SNby2Kj3li+frA=;
        b=QVDdFFUltlq2QOVnuVwpHRz0igXU6NzF4FXyQhilYMIzDk1yuB7rB38ssZ2lvy4KHB
         Glw1bbOodqdm0OckevTlFW1d1n9IKEk5YkfBt1XE+bgEKyClFwzM1pJIpibnyDY1zp20
         ymZNuInDsGyxqiRUYTBFOaxzOBh9DyWqe9GNmPCaAOYNDRNkXkJIx14uTKj+COulI5Ot
         fx0G8OvqOmHvwbam8g40mLbiJxXsURsOTluBdQBLoIqJJkwq/t47Kz4oLCxCoNOXGw5b
         5x7C2plvbDiTpN+UKpb94j1EmV5O9Yvw+sgnm0/lv0Jn7ylJnabKgoYrg1Teu/dP3fuG
         gDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210941; x=1758815741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RE60dwLTneNoKeZ1sfL+FqOR97T6/SNby2Kj3li+frA=;
        b=C2woaH2kmI5BXFr+fyIpoKPFeKWITj2+UUAY8Naajm5mW3ac/R/rfDiXNB9+oQ36zI
         U48nw5vYTM0baf/pSdqVqEoEj4tDDnDb/0uZ2ghuTSDuQM1LXfdyoLXYo/ih8Z3Gx76J
         KNVh6s3DlRVr5/QFTh5Hirfw2KQpJZdqqDq+f4IfzrqKw4LPGzdfDG0G1sVQ+pq6aEnY
         bCVl7RSEr0wXAiIKEMRwY/WHT++xjl4W+dRP1tiVIiOSmRRJal0ssgIA2Y8BWhXtkKJI
         8Jv9EOuut9iU1fWhrnBQ6B6nj/tKNG95SFX/bPCU24fgFB6PC3mV/+F+7esAi0IXEMg4
         6Jvw==
X-Forwarded-Encrypted: i=1; AJvYcCXjEykYFHqdAKXBMINwABVBSEEfcBLtP3ddeHQ8geaJGFg/+kRlXSfYSc8y6QiC+7aA5U4ZBzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1kCXuEBYbAXbseo6pEmyYing//1d27GdajtaC1JiESd4p9TQv
	fc34pssOIPK1IRUQR7DFV7dL0z8/cvHgRABsU3kGgfMbCpC9ge0RUGcHTNTPaF+oT8T9CVagS5W
	EWW0U1V6Y2apeJw==
X-Google-Smtp-Source: AGHT+IGPSpWL67aJql66iZeEq8i+Fmx84mOVwWWkKmlwGRnqgMk9sY6fmzQNZFqqmby4IMFPdXIcAGI2BVdaLQ==
X-Received: from qkbef6.prod.google.com ([2002:a05:620a:8086:b0:827:8396:d3c2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:47df:b0:7fe:9d98:4806 with SMTP id af79cd13be357-83baacc9d56mr5137385a.59.1758210940976;
 Thu, 18 Sep 2025 08:55:40 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:55:30 +0000
In-Reply-To: <20250918155532.751173-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918155532.751173-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918155532.751173-6-edumazet@google.com>
Subject: [PATCH net-next 5/7] tcp: move tcp_clean_acked to tcp_sock_read_tx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tp->tcp_clean_acked is fetched in tx path when snd_una is updated.

This field thus belongs to tcp_sock_read_tx group.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst |  2 +-
 include/linux/tcp.h                                  |  6 +++---
 net/ipv4/tcp.c                                       | 11 +++++------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index c2138619b995882663a06c2a388d5333d6fe54f0..26f32dbcf6ec9004e3be1bfefba8d303a60b1a99 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -27,7 +27,7 @@ u32                           dsack_dups
 u32                           snd_una                 read_mostly         read_write          tcp_wnd_end,tcp_urg_mode,tcp_minshall_check,tcp_cwnd_validate(tx);tcp_ack,tcp_may_update_window,tcp_clean_rtx_queue(write),tcp_ack_tstamp(rx)
 u32                           snd_sml                 read_write                              tcp_minshall_check,tcp_minshall_update
 u32                           rcv_tstamp              read_write          read_write          tcp_ack
-void *                        tcp_clean_acked                             read_mostly         tcp_ack
+void *                        tcp_clean_acked         read_mostly                             tcp_ack
 u32                           lsndtime                read_write                              tcp_slow_start_after_idle_check,tcp_event_data_sent
 u32                           last_oow_ack_time
 u32                           compressed_ack_rcv_nxt
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index c1d7fce251d74be8c5912526637f44c97905e738..3f282130c863d07cddd931b85f43afaf44bc7323 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -215,6 +215,9 @@ struct tcp_sock {
 	u16	gso_segs;	/* Max number of segs per GSO packet	*/
 	/* from STCP, retrans queue hinting */
 	struct sk_buff *retransmit_skb_hint;
+#if defined(CONFIG_TLS_DEVICE)
+	void (*tcp_clean_acked)(struct sock *sk, u32 acked_seq);
+#endif
 	__cacheline_group_end(tcp_sock_read_tx);
 
 	/* TXRX read-mostly hotpath cache lines */
@@ -250,9 +253,6 @@ struct tcp_sock {
 	struct  minmax rtt_min;
 	/* OOO segments go in this rbtree. Socket lock must be held. */
 	struct rb_root	out_of_order_queue;
-#if defined(CONFIG_TLS_DEVICE)
-	void (*tcp_clean_acked)(struct sock *sk, u32 acked_seq);
-#endif
 	__cacheline_group_end(tcp_sock_read_rx);
 
 	/* TX read-write hotpath cache lines */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1d8611ad4c88f164eb45a54e1f6b812b1d02637d..098e017ff5da1cbd05f10a6ed32883980facb314 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5096,8 +5096,12 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, notsent_lowat);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, gso_segs);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, retransmit_skb_hint);
+#if IS_ENABLED(CONFIG_TLS_DEVICE)
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, tcp_clean_acked);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_tx, 40);
+#else
 	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_tx, 32);
-
+#endif
 	/* TXRX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, tsoffset);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, snd_wnd);
@@ -5121,12 +5125,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rtt_min);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, out_of_order_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_ssthresh);
-#if IS_ENABLED(CONFIG_TLS_DEVICE)
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, tcp_clean_acked);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 72);
-#else
 	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 64);
-#endif
 
 	/* TX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, segs_out);
-- 
2.51.0.384.g4c02a37b29-goog


