Return-Path: <netdev+bounces-75463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F232486A07B
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 20:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50512B34C50
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2FA51C3F;
	Tue, 27 Feb 2024 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VHawGEHS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80B50A68
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062046; cv=none; b=TAHXtpM1Ctg0h5JvVNq2UCbpTM9y5YUG6PHjY4h/jRqETU7Ie6J+1Yxx/h51mw3xEKc+PTH16r9ZUUJy2yxCb0cHaCj9Vv8OqMLFNDt30kHL60JJnvoBtXOB4krHCHVlPUwgjYXXQLJEE/IYWvK6NY69iY9jftAaEHyBLwganig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062046; c=relaxed/simple;
	bh=PBa/pJM7AcjrMxwQq5W4HIcny1Z7S8PYk+z/8Tn19X8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HjxwawKn9HqtokM5Lt3yJXtFKwMV1wiRwjDZYVvQLg9qkSsBGCOmVqIK+obSEOJR33OFB7OCOUSDyc+1bU0werAF7bceqlSoK9FDaVFIlwAgg3Lk1AE70EiOGTx2MJ4nojrhcxc654433DHGSsf76PKkMrSkgHdjmpBE2QT0XIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VHawGEHS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso8360125276.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709062043; x=1709666843; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pcqIOfiEpesUFQCxCeEH6BLuqyD2RZZwLKPfboASVP8=;
        b=VHawGEHStcf8mxKQEvs8TktqQi//DmmM0YaPtS6Y0DzG8e6Cp9+370j6frG0lffX5k
         +kk9vuE/c31/1zQNzQInT1Mw8IjZBEQLeKeh6Ajx9JRQP0vJS2NG50RJF7C4WqKJKrnU
         6NtGv75XbwBx8SxAlfGtU98tyVrQHURAil6W1zfscO25614giR6O5ZMI8gJ2WsQZ1AXA
         mCbYJzpsPR2XHOu0wSYXyuCp/CSEBWFvKLL2zRnqEADj7xrhwIyLz7RCOOIODZgqHZcy
         ScLanpDSgBl0SnlktV7PDAkxpZj3IKKZXNgyHR/cyseyCyqGMz1yKuHH63KGRttrb4/2
         Ufdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062043; x=1709666843;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pcqIOfiEpesUFQCxCeEH6BLuqyD2RZZwLKPfboASVP8=;
        b=P17H/d2TWAKaZjutpikUNPuUAtzklV2MMHeLaLZ0XQywiBFUq/YRof5L/4fMToZ+i9
         o0sQ/sU44UA4/7OzRd0ngbQHVNJy7RwnIDssuIJICNdMkDuVTsE4/ezaPKhUi1WvkAMh
         FlkoFwnNFBqnD8ALLd4FvWjblTqYzfN7mYKjrfQ95WPErXZYu87OpWWYXocIvjUQBO1G
         AMyGC1LeSxjNPyNGRgDj3R0UI9xvFGo0uZRDHOHR89khD/ezB+tJJ5PeSb6dkUiNJcz3
         +hDqp2Ryo3v0dnz31kyHRqoVzFxbQH1+Q7ugIL1OhENVmKbbYQbPXGL0TCDk+haLFDqE
         jFtw==
X-Gm-Message-State: AOJu0Yzu1ZnMwkQ0LNmcRbz3Wb4+p1er7MCclhsHZY/f+s8Ur5wj313w
	eHRjE+KOhosH0tjOXqApmKnmg0hExIhGCTspQVzufjI0OrCiVHtePJXIIhk48zf7wWx91o07cut
	I+zMpHkoIzg==
X-Google-Smtp-Source: AGHT+IHrvUtmF4Smp49UE3C5hBDSJAdbIWVoxMWVDpTzz5nJSoySVvR4OoeZuMKc5kv50gBlRs6zVr8GetaN+w==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:f09:b0:dcc:9f24:692b with SMTP
 id et9-20020a0569020f0900b00dcc9f24692bmr18797ybb.13.1709062042818; Tue, 27
 Feb 2024 11:27:22 -0800 (PST)
Date: Tue, 27 Feb 2024 19:27:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227192721.3558982-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: remove some holes in struct tcp_sock
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Naman Gulati <namangulati@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

By moving some fields around, this patch shrinks
holes size from 56 to 32, saving 24 bytes on 64bit arches.

After the patch pahole gives the following for 'struct tcp_sock':

	/* size: 2304, cachelines: 36, members: 162 */
	/* sum members: 2234, holes: 6, sum holes: 32 */
	/* sum bitfield members: 34 bits, bit holes: 5, sum bit holes: 14 bits */
	/* padding: 32 */
	/* paddings: 3, sum paddings: 10 */
	/* forced alignments: 1, forced holes: 1, sum forced holes: 12 */

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index a1c47a6d69b0efd7e62765fbd873c848da22aaec..988a30ef6bfe956fa573f1f18c8284aa382dc1cc 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -264,10 +264,10 @@ struct tcp_sock {
 	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
 	u32	lsndtime;
 	u32	mdev_us;	/* medium deviation			*/
+	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
-	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	struct list_head tsorted_sent_queue; /* time-sorted sent but un-SACKed skbs */
 	struct sk_buff *highest_sack;   /* skb just after the highest
 					 * skb with SACKed bit set
@@ -350,7 +350,6 @@ struct tcp_sock {
 	u32	dsack_dups;	/* RFC4898 tcpEStatsStackDSACKDups
 				 * total number of DSACK blocks received
 				 */
-	u32	last_oow_ack_time;  /* timestamp of last out-of-window ACK */
 	u32	compressed_ack_rcv_nxt;
 	struct list_head tsq_node; /* anchor in tsq_tasklet.head list */
 
@@ -384,12 +383,12 @@ struct tcp_sock {
 		syn_fastopen_ch:1, /* Active TFO re-enabling probe */
 		syn_data_acked:1;/* data in SYN is acked by SYN-ACK */
 
+	u8	keepalive_probes; /* num of allowed keep alive probes	*/
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
 	u32	mdev_max_us;	/* maximal mdev for the last rtt period	*/
 
-	u8	keepalive_probes; /* num of allowed keep alive probes	*/
 	u32	reord_seen;	/* number of data packet reordering events */
 
 /*
@@ -402,6 +401,7 @@ struct tcp_sock {
 	u32	prior_cwnd;	/* cwnd right before starting loss recovery */
 	u32	prr_delivered;	/* Number of newly delivered packets to
 				 * receiver in Recovery. */
+	u32	last_oow_ack_time;  /* timestamp of last out-of-window ACK */
 
 	struct hrtimer	pacing_timer;
 	struct hrtimer	compressed_ack_timer;
@@ -477,8 +477,8 @@ struct tcp_sock {
 	bool	is_mptcp;
 #endif
 #if IS_ENABLED(CONFIG_SMC)
-	bool	(*smc_hs_congested)(const struct sock *sk);
 	bool	syn_smc;	/* SYN includes SMC */
+	bool	(*smc_hs_congested)(const struct sock *sk);
 #endif
 
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
-- 
2.44.0.rc1.240.g4c46232300-goog


