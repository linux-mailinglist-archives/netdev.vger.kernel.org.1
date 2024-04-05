Return-Path: <netdev+bounces-85171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8484B899ADA
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80D81C203BE
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B49161902;
	Fri,  5 Apr 2024 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+zR5SoS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDDD16087B
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312970; cv=none; b=srgnS1wGVav1tbvZ4MAHkDkNCICrZp3u5XHZnVcPt0UB9Ol+Yfhd1JKKrI8hRGpQB7pJE1EamCofKZQTQl7dectlcID5rKAb5ZRzmu8k21jK6NwEh8+n+uspgypdVXwj6ijxmwXiGtfEXM9y5CuoVfqL8aPUJRVKD4t95sHxTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312970; c=relaxed/simple;
	bh=j0Y2hhbgzwZ8sEW751sk49un7VN4F+j1OeYQiGQcsPc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uutaeD0UgvKijeCFQWmaNJCxXbhy+8rskdiwln57Wkh/Hy0q6tKMn0AZLYSQRQV/jc1WlnEd5RaTeOCX1f2dKUqE0VeyfdMdvlstAZtmjgfCIwomtfTblA7yAdrI8Vey2h4F5AberBD6N1S25g+lIhrHgS/vORD2j6TTDh8SPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+zR5SoS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc4563611cso3096705276.3
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712312967; x=1712917767; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZDx2yrQRouLc2u2CnAaRe+8FoaNC7eA5oT1BotlubCY=;
        b=j+zR5SoSewflR4L/4ZrvL2qwW4xkLRB4d/wBm8KwUcKVyG3MprLypIZWH6Iix9sj/7
         /BZrQDsk47n18nlOV9+Jh3xipAdvKw7EQ622h0QOpe6rpd/7OouN6/sCcLcO/FrV3BTc
         3VIYqWOVDNL/0zasQ9dGTnEc9QnVpEL1ciaR9DVBs63eu4RiwNGkjgS9orDCxRU5FoPC
         nVZEHXFPnFjauZkS+IZJX1JIz2VTc5mJb91T9o2wdMln+RaB56m7yGwql/mLNLF/DrzR
         wvbaifn7iPGMNnTh6yJNKko2Qwg/fXWf7Z/C/wPpYxHATmmHSUHiNMcXQqBJYE8lMwrn
         nq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712312967; x=1712917767;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZDx2yrQRouLc2u2CnAaRe+8FoaNC7eA5oT1BotlubCY=;
        b=nISOECB02JlkIg4VPPxxbnFPogjlzrouJS45J2WO/jJJ+LvuV1caGqPZq2rIvR8k//
         PFC2NMOy1b5pRxSlTTxxyaAxuWhzU0q346TPlsucPtNljdYtUasrZ9/6wwfYV2ujp6xV
         nr4MJ5yIZVXUmzeuSlJ/7kLlrYFuTciSp8V8t1DlRpmpvS7AAwVw8zk+yTqk1WqOXpW4
         3UhzaKHxGsUcEUbrBxPC9EH1NnHE7KyBGGaf+k8B24DuWpm6VqCBuA9B5zgVgCVYEWyP
         385I5QTSSZn5+a1bBjTw/neSDftBMqLOqCZerXrWL5/44cpHRwau/yzjgrarWlJPkMpB
         fDaw==
X-Gm-Message-State: AOJu0YwvrUSfRTi2iyvLhWl4Zl2BPWZuKQMMFmtQXEYkVbjf+grc5T0b
	DdvKNPTBNnNJStT9vMbNiIYuRvW9YzuGLOlS7LxJVu99qpygvNyKSmoRErJ9YUhGQhH3ukeEoeV
	YnrQiHNqdZQ==
X-Google-Smtp-Source: AGHT+IE3QOmXNnH5UbAC4KmBczFix70v8yrhYgPN5Osb18uL0L8EGvUxTSmZj4RV4wpPdHd8w94OSvRBvEkSww==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1108:b0:dc7:68b5:4f21 with SMTP
 id o8-20020a056902110800b00dc768b54f21mr248595ybu.9.1712312967540; Fri, 05
 Apr 2024 03:29:27 -0700 (PDT)
Date: Fri,  5 Apr 2024 10:29:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405102926.170698-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: more struct tcp_sock adjustments
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tp->recvmsg_inq is used from tcp recvmsg() thus should
be in tcp_sock_read_rx group.

tp->tcp_clock_cache and tp->tcp_mstamp are written
both in rx and tx paths, thus are better placed
in tcp_sock_write_txrx group.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 6 +++---
 net/ipv4/tcp.c      | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 55399ee2a57e736b55ed067fc06ea620bbe62fd3..6a5e08b937b3156ff876eec85d153b975bf217ef 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -244,6 +244,7 @@ struct tcp_sock {
 	/* OOO segments go in this rbtree. Socket lock must be held. */
 	struct rb_root	out_of_order_queue;
 	u32	snd_ssthresh;	/* Slow start size threshold		*/
+	u8	recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
 	__cacheline_group_end(tcp_sock_read_rx);
 
 	/* TX read-write hotpath cache lines */
@@ -266,8 +267,6 @@ struct tcp_sock {
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
-	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
-	u64	tcp_mstamp;	/* most recent packet received/sent */
 	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
 	struct sk_buff *highest_sack;   /* skb just after the highest
 					 * skb with SACKed bit set
@@ -284,6 +283,8 @@ struct tcp_sock {
  *	0x5?10 << 16 + snd_wnd in net byte order
  */
 	__be32	pred_flags;
+	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
+	u64	tcp_mstamp;	/* most recent packet received/sent */
 	u32	rcv_nxt;	/* What we want to receive next		*/
 	u32	snd_nxt;	/* Next sequence we send		*/
 	u32	snd_una;	/* First byte we want an ack for	*/
@@ -370,7 +371,6 @@ struct tcp_sock {
 		tlp_retrans:1,	/* TLP is a retransmission */
 		unused:5;
 	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
-		recvmsg_inq : 1,/* Indicate # of bytes in queue upon recvmsg */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
 		fastopen_client_fail:2, /* reason why fastopen failed */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e767721b3a588b5d56567ae7badf5dffcd35a76a..7c7bd7aa20637a2efa0a4dcd521ead14d9c2cbda 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4648,16 +4648,16 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, lsndtime);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, mdev_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_wstamp_ns);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_clock_cache);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tcp_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, rtt_seq);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, tsorted_sent_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, highest_sack);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_tx, ecn_flags);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 105);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_tx, 89);
 
 	/* TXRX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, pred_flags);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, tcp_clock_cache);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, tcp_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_nxt);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_nxt);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_una);
@@ -4670,7 +4670,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 76);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
-- 
2.44.0.478.gd926399ef9-goog


