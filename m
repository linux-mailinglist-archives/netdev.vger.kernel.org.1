Return-Path: <netdev+bounces-224522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3DFB85DB1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C848D3B66AB
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D3314D3D;
	Thu, 18 Sep 2025 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWC5ZIbf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B06315D2E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210940; cv=none; b=m15CQvOpvDgQqsCiprtfybO7c3BUrZdCOIahulNG+KhHJ5pdRkzXh/nFUJmISWwnr92jojfvrhugKSJ1ZCXWTqSX/66yHt38PU6NIy67ru7nIyw7g+rKppdw5uTBG+cKOZMEWjHLUIaTvu0BCQUZvGwvMZlG84QDfngmkf2K2WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210940; c=relaxed/simple;
	bh=km6A/bMGMm1m0V4EOCoD+x7LaPxVusiF5I6dFTl3gvk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I+CNr8zO6/MiUJ94E+JR6fXfgJDQT1f6EYpdEy/U9AIyRjS99vi76LEeiXJbYts2hh8DdAkbxCZ4jc34z6lKGNSIi6uSlWDhSrUtlW6aEXMtYI1VeTLpkRyfdWnOf58lcowidDc3nKqcmw4MTg8cDDctYg0unrMovFcW2/Nyqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWC5ZIbf; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-811917bdcfeso210541485a.3
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758210938; x=1758815738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFU0m3wZAeNMPkQISYLMe5OW9qX8+zwfmkgSMDRTQ6k=;
        b=lWC5ZIbf0gx6QOLtpsxNsxpbEGmMhfl3EHbDrVog3XN0ltnwT2ma/kiz3iqNsS1ecR
         LfgOBxrTCztMhSt9E5jvp5IbFcrqy16w3BwRZA+rfHdQFmUL6S6PaoDdxbs+19SCI2fG
         gGy+OpEbNPGt7A3zBKbqEzOVFSmWv3NQP6VWOlLvLtgl0gtxiFWbQIXi3iOLE1+YjB3n
         NpdvENeCbm14qUe4FiBHHDvjw1DflGw0BhOpk5qV8RlVFa3SRSCLVDkxKtmUQBQghwkt
         ka+XoGNE0SJR3DdjSVN/pD2AYJ9o/HK8GFAuvhH7mMO/fW1Ayy7bnPkzA9i1aftaABDl
         3a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210938; x=1758815738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFU0m3wZAeNMPkQISYLMe5OW9qX8+zwfmkgSMDRTQ6k=;
        b=KVumoDf/htKWRFHFBYYZyk/tTucacjC+gHbQ14C6hWyPDL8AFM7+wlkCHY8Yojd0AV
         3TB+CnZbQn1kGBEMCxzO+O8/QdHwycWdfR2DevhJIyLeSs3BEndNK+JV7Qp5zRDuN7BF
         iGhTVkPf9LuT/0oBQ9BXpQKwH8G+0D49rysI3LHd7ZBMhruwssXHXjaT2CRrW+MSgknZ
         GDo/zynvUUzOoWMXip16SbydCttW2qrGMQdq+sf/AmZIcO8IojLWfDDLwshtxHxIyE60
         mu0DAsagmE1BAgEMawJJee4WY7D+2t7DVLsUx/IrxbzSEDbKrfHjy9jNFaXvADtOBGlG
         A6xg==
X-Forwarded-Encrypted: i=1; AJvYcCWEXXfVzgSrcRg9Sck7VW79W4I2kmE/YJrxttxqq1hbi+23Wus/Fix7nEjF48vZmZgtQcb/IFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWnfl4DFydU84tE1ovKj1HMYSr7RM10WEXewr4+1Lzzs5MG+P
	JKR5m7HziWG3qTf42x9cqPil6s06FPS2R7nBZsfX9nThZrbi8Hpd36v/VWp7CxnmMLi11IQ/uuC
	Z8mOjCR0KiUaNWQ==
X-Google-Smtp-Source: AGHT+IFA5P2fLYnzT0W6us0i8lP6UcIfzsxcMK90ZRSJYJzLfByrkZfGzYNprs/FtS66sLXBrJfzfN9tYXgOkQ==
X-Received: from qkbdz16.prod.google.com ([2002:a05:620a:2b90:b0:828:9bf9:d9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2802:b0:824:c795:ec3b with SMTP id af79cd13be357-83ba1e39ee4mr9452785a.12.1758210938022;
 Thu, 18 Sep 2025 08:55:38 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:55:28 +0000
In-Reply-To: <20250918155532.751173-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918155532.751173-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918155532.751173-4-edumazet@google.com>
Subject: [PATCH net-next 3/7] tcp: move tcp->rcv_tstamp to tcp_sock_write_txrx group
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
 net/ipv4/tcp.c                                       | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

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
index d6d0d970e014d4352050115e84d3b5a56f8bed26..24787d2b04aa3d442175df41e0f507ad60398120 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5111,7 +5111,6 @@ static void __init tcp_struct_check(void)
 
 	/* RX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, copied_seq);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rcv_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_wl1);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, tlp_high_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, rttvar_us);
@@ -5124,9 +5123,9 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, snd_ssthresh);
 #if IS_ENABLED(CONFIG_TLS_DEVICE)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, tcp_clean_acked);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 77);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 73);
 #else
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 69);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_rx, 65);
 #endif
 
 	/* TX read-write hotpath cache lines */
@@ -5165,6 +5164,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_tstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
 
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
-- 
2.51.0.384.g4c02a37b29-goog


