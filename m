Return-Path: <netdev+bounces-224883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC6B8B3BD
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D156D7B5EED
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FC129E0E6;
	Fri, 19 Sep 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TY/Hz9Rv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A292C3278
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314948; cv=none; b=P2aatbAd/n/8sGU0NCD8Cx8Ug61Iq/iY6+BFYG3D+/z0rF+YnIUjaByycENVoatZixgaoK/RRqN4u+9KM2ektjVQM/6GkKF4DJlu0kuHobc0qcyUpWWDZh39RT30UDm3/UucZd7m2wrkimzTx/PoWYykr6J2V/BZtTkkvKlNNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314948; c=relaxed/simple;
	bh=STu2iWBZirSeHBDPYHhBZAQRhGs6cn39qB4/ZtEqUfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q//Ctg+70B8PLAKLi9/ioV0/jHXUl2o1K4Cy7ER/eMt1SFM6WoxEez9VfjFBXGgCocAvxKzOrwXE6d3mUh8AR9YEpFxAuqg/W7BMmqHF/eqPdlVIlfRPu93MS9VKiP1vkthVCB8UeTedDNiKdiCpHoi3+RSbX0mAEHqub3w6Fds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TY/Hz9Rv; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4bf1e8c996eso32779171cf.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758314945; x=1758919745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bfa9oRxHJzp0v2NhPkUM9c4E7RKjv/1NyTAGx+qy0SM=;
        b=TY/Hz9Rv15hvTKEIVDjD8TIjmyTLlEAqUY24r6syLv6FH7o59fY/wB13+S8PcDvGir
         /Xl5FiRvyq0LmGT2WRdzgEtRC5+SDdC0fxiBNoLgY+UKbmkGA+yN9GqglzLqf/yfz2Tr
         2EdXouevWUBoxJEEq3KteVqBA4CINX5jcf9ZSi968EvIEJ4OulKMrgTqJ5KmePRYt2x6
         pBc5gz+NE/iByISumdjgrnBg9sNi57Sbz1wb+llx08X5WQJgwSdAqFOGcAEzx15BNAkS
         ew65g3XniQptg9yAP6GPXUKZUWUP2dn+S50Myyd50e7d/cpLyJGIGBEGtdLK0nzYOLTb
         ZdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314945; x=1758919745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bfa9oRxHJzp0v2NhPkUM9c4E7RKjv/1NyTAGx+qy0SM=;
        b=L+BBjpCc/nLNU+dx3pBLXiwqWQLo3V3iEhshLfi/17UudR3jhGiCZpM4zm/sFyNQUn
         dSTJBmW36P82/bbPJn3GRdteDrH7D03qIxqORRfNKmceuXoCq7KlAdMbwqZH3Ksmj8gk
         RKYXU/2fsx2C6P/bYcP0J2FKtxAjwajiFlHOb8DSoAPPlJu0UKyI+S4oB1DijwNrahZ/
         pxwkVADXlO1AnvXpcxjFr0FDPQ4FPdN78vBDGh4NED69g5YhhBzthxoMdpKHOb0UdoC5
         gaU0741cwT0ocyZhUGh65WeGfMdWqDxoDf5Dh8nqlpki8f7d3wZqgMBxAez0C+MkT163
         WhBA==
X-Forwarded-Encrypted: i=1; AJvYcCVW0nxTgf6nxUkR0m91wdhVbJA7T0tcgGLgXlj2r/7fxdpQY+5llweYoqZTO17ar7mJ/lZxNG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlu2CL1V4AjRtVN4B2qrDnb3t6jX8Xzrz1/WJB13nV29LBP2V
	TIWqedilaautew2yDX8tPdR3xxmzFQnJ14xyNtUfZLPpxbndcpaM1Yglo++uFeGSic1vTzSqRT8
	SJgOiFJS/zkun6g==
X-Google-Smtp-Source: AGHT+IG0gHwE3NXv4CdfHrVHSJu53ChWN9AvnLWDAe4DfC9aYuzuhQ1MS9Yc/d7ArnvvCLJLzTWEpYNHwxVdRQ==
X-Received: from qtnm6.prod.google.com ([2002:ac8:4446:0:b0:4b6:11e3:69a1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1114:b0:4b3:1697:4e53 with SMTP id d75a77b69052e-4c073111ca0mr51215431cf.66.1758314945259;
 Fri, 19 Sep 2025 13:49:05 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:48:52 +0000
In-Reply-To: <20250919204856.2977245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919204856.2977245-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/8] tcp: move tcp->rcv_tstamp to
 tcp_sock_write_txrx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_ack() writes this field, it belongs to tcp_sock_write_txrx.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst | 2 +-
 include/linux/tcp.h                                  | 4 ++--
 net/ipv4/tcp.c                                       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index d4dc018009451261c81a46dac2d6322005901c99..429df29fba8bc08bce519870e403815780a2182b 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -26,7 +26,7 @@ u64                           bytes_acked                                 read_w
 u32                           dsack_dups
 u32                           snd_una                 read_mostly         read_write          tcp_wnd_end,tcp_urg_mode,tcp_minshall_check,tcp_cwnd_validate(tx);tcp_ack,tcp_may_update_window,tcp_clean_rtx_queue(write),tcp_ack_tstamp(rx)
 u32                           snd_sml                 read_write                              tcp_minshall_check,tcp_minshall_update
-u32                           rcv_tstamp                                  read_mostly         tcp_ack
+u32                           rcv_tstamp              read_write          read_write          tcp_ack
 void *                        tcp_clean_acked                             read_mostly         tcp_ack
 u32                           lsndtime                read_write                              tcp_slow_start_after_idle_check,tcp_event_data_sent
 u32                           last_oow_ack_time
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3ca5ed02de6d48e64c26744f117d72675f84a3f3..1e6c2ded22c985134bd48b7bf5fd464e01e2fd51 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -238,7 +238,6 @@ struct tcp_sock {
 	/* RX read-mostly hotpath cache lines */
 	__cacheline_group_begin(tcp_sock_read_rx);
 	u32	copied_seq;	/* Head of yet unread data */
-	u32	rcv_tstamp;	/* timestamp of last received ACK (for keepalives) */
 	u32	snd_wl1;	/* Sequence for window update		*/
 	u32	tlp_high_seq;	/* snd_nxt at the time of TLP */
 	u32	rttvar_us;	/* smoothed mdev_max			*/
@@ -246,13 +245,13 @@ struct tcp_sock {
 	u16	advmss;		/* Advertised MSS			*/
 	u16	urg_data;	/* Saved octet of OOB data and control flags */
 	u32	lost;		/* Total data packets lost incl. rexmits */
+	u32	snd_ssthresh;	/* Slow start size threshold		*/
 	struct  minmax rtt_min;
 	/* OOO segments go in this rbtree. Socket lock must be held. */
 	struct rb_root	out_of_order_queue;
 #if defined(CONFIG_TLS_DEVICE)
 	void (*tcp_clean_acked)(struct sock *sk, u32 acked_seq);
 #endif
-	u32	snd_ssthresh;	/* Slow start size threshold		*/
 	u8	recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
 	__cacheline_group_end(tcp_sock_read_rx);
 
@@ -319,6 +318,7 @@ struct tcp_sock {
 					*/
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
+	u32	rcv_tstamp;	/* timestamp of last received ACK (for keepalives) */
 /*
  *      Options received (usually on last packet, some only on SYN packets).
  */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5932dba3bd717b59e730630d7390b65f329b03c2..721287ca3328eb543e1d8c999b08ca617b77b8a7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5114,7 +5114,6 @@ static void __init tcp_struct_check(void)
 
 	/* RX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, copied_seq);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rcv_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_wl1);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, tlp_high_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rttvar_us);
@@ -5164,6 +5163,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
 
 	/* RX read-write hotpath cache lines */
-- 
2.51.0.470.ga7dc726c21-goog


