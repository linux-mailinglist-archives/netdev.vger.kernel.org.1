Return-Path: <netdev+bounces-224885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86285B8B3C6
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402871CC36F9
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D1C2D1926;
	Fri, 19 Sep 2025 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5rpSQO8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA6A2853F7
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314951; cv=none; b=aUOHPUJ0oygnlePtA+iiHyOagDic5UKN2RzG2PsTyjEa77VrGfl97EQehL9QQIGFS4Vk7wRnG7Wp1H+0kEWH9LSVjVOIt+yqDe/khyAkPwb1ey/LV3nXB4j9w+fJzHxb7yFZM6Db4mlG1uWxvMhu+/YNrAf8lIA1xKG5ZaXeu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314951; c=relaxed/simple;
	bh=NwqGngNupHRfH/Rh3qFWiG2jnZWFTTlRiwm4jEQZUOQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WFdacmXkCNzgt/AsGdBGb+FMRkaNAAyWCl/OSmOLybjWUtDF918Y+749FtW0vQ1w3/dSYLYs3yuWsFk513/d0ccuDfDtM/bNIglL8a9zLILE6CbL9CNi5RHBWDbuODgnBype92gihCePPYteFYjQHlotVcZ4KDLUWs5OMRq2F0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5rpSQO8; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-829080582b4so467628485a.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758314949; x=1758919749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BwDpdE23YT/k/S3r/7hEJ8opQ35JUaDh8uieYY1LD9g=;
        b=O5rpSQO8uRtmVWjLm5RdDJ/YvJDgoaP4hOJfWrfblG6nvrQgAIn3+9orCV7h8G99pZ
         b+btcKHgSU07DdVjc8SKYgCDi4YFxGUiqesV4/AtMg07JBtj9BT/Q0gyQxI/iF38fIDu
         JfOIfdGVl0IkPK7fTbu675dKh0fwH8aLWPZpNNW2z3k15KG+OqxKZIKDSpyUKLG2CcST
         UmRGH84d9yMB70QRis2IPOUlFYiZbfsn7CPd5m3W/v71xMo9Bvk3pCFk7VJmktpJO3mA
         h5fTLaf9KWMyfKJci8Ce4EwbT+/uVeYJBkEXF8M3C5ufEPsk7x82YDdMw3o6dUoNuhib
         ob2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314949; x=1758919749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwDpdE23YT/k/S3r/7hEJ8opQ35JUaDh8uieYY1LD9g=;
        b=wbf6AxqQXpomt8ZhYCbZRN6rNOUzGaEDWO/2pOy+IydF/W/uuCyIpmSDp2EKbSDe+O
         f7ZcWN6ZhB47GNwKtl9PuQAXXbdJSdx2vnGpkM9Az26pX48f8SS94n7cL8THS7RYhGnr
         8j1uHmzftEqr4j+Zu8NWHcWHLSBTDwa09ndCBoq0+yA28tfqluXpM8wb+yZG7S0xGZP9
         bsvwgbIP2aBxtSibmC6zYgarm+BWch1TVVS4cr3qkBHBR+4RR9CZqcuOK4pf00mBqXfo
         9Bn++6i23ei0NjnCtUx50Tq4AY7ZZMfOPwNT5fqWZ1qhCugnktveJd1wZQFSVR+Kf8e1
         YY0g==
X-Forwarded-Encrypted: i=1; AJvYcCWLljw3t4vihJ+b+NCf633BSE4utO8KqI+QmALkwYnw98usgSluJKiSa0uAw1uW0vB2lGjx7RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqYurjaHam2fZXQqX6bR4kU+PJYZd1yvRl3UNh+DAEkzUYj6a
	Ugk4AKX6rRYePgOUtQMQWtLJDDkkpMqGgPH5in0MU2boXEkVeo5GUNLueV0o5ETeXApmcyebn6R
	eNzBFabBOYHMTwg==
X-Google-Smtp-Source: AGHT+IG9o2wGhsOj/d3Q2tGP4W42BqWsNL0gMcwFhuJAVgnQbDMG5S2aCgvzf183evw5LjmrrUi+i7XdMTafmA==
X-Received: from qknvl15.prod.google.com ([2002:a05:620a:710f:b0:80b:6697:c403])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8ec1:b0:835:f736:64c6 with SMTP id af79cd13be357-83ba29b67f0mr367013885a.10.1758314948626;
 Fri, 19 Sep 2025 13:49:08 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:48:54 +0000
In-Reply-To: <20250919204856.2977245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919204856.2977245-7-edumazet@google.com>
Subject: [PATCH v2 net-next 6/8] tcp: move tcp_clean_acked to tcp_sock_read_tx group
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
 Documentation/networking/net_cachelines/tcp_sock.rst | 2 +-
 include/linux/tcp.h                                  | 6 +++---
 net/ipv4/tcp.c                                       | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

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
index 721287ca3328eb543e1d8c999b08ca617b77b8a7..7949d16506a46eb561479b77bebce4fe88971c12 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5101,6 +5101,9 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, notsent_lowat);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, gso_segs);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, retransmit_skb_hint);
+#if IS_ENABLED(CONFIG_TLS_DEVICE)
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, tcp_clean_acked);
+#endif
 
 	/* TXRX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, tsoffset);
@@ -5124,9 +5127,6 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rtt_min);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, out_of_order_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_ssthresh);
-#if IS_ENABLED(CONFIG_TLS_DEVICE)
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, tcp_clean_acked);
-#endif
 
 	/* TX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, segs_out);
-- 
2.51.0.470.ga7dc726c21-goog


