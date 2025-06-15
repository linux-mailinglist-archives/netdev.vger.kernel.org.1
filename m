Return-Path: <netdev+bounces-197851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3485CADA05D
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 02:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3F41895F20
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2D98460;
	Sun, 15 Jun 2025 00:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jO4pDCgT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7F29A9
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749946486; cv=none; b=JMUq2A9WhwQ3NKKkjvx/Fr0Wl0pUzYgTjDEj66S5rJCMp/ZVQUOuZlbR8PW4KahWqTBOBL4oRvqL3YGBvaTQvYQo1zeVzvltveWIisEmQFUoegnZ1YxnoV2SS1Rg6b1NdwPQ2/jROIWi3WGkzVrfy+jveiJXXuP2It8DS/E6H40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749946486; c=relaxed/simple;
	bh=lfED64EElBXFW7oFQDmHZQuVpFtfgbcvvmwDwognsLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMCPPb1zwMSMT+erSE1YCN1EdoIjkuk5m9taNvC2EF9jW82uMo33M8mJpJcB9aovEI3mPLpdscA+62XHTbaq39eI8VAqzI0Rk2nbjhIoQPFXjOpckdUJPO4OY/w3WmK4cMvJpWIOzfkqktrDfClUGMf7s7e0C6E+SLxYRdwmnkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jO4pDCgT; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d0a659e236so37854885a.0
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 17:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749946484; x=1750551284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCml5/N0kTKx0dstq2eExvuMKXraBjlaD4azIIkhY74=;
        b=jO4pDCgTcs9ImXfy315B3x1eIoxq5tqqEMoevMPh7Pw6wRtHDI2KhQVqgtkXgyxfic
         FdOLdheo8sCCzk2a4E4JM878IRJLRPbwPQHUJHY6nD1LkrjmCw/OMZoyPdke10hmG+q+
         JKHlqijlX5S8j1Isc6VYcxpy54cWZKsHQJdLNHUGU/8XB+tcIloGugdmRBKcN1WSxecp
         LquzVlGL4d4Ze6ZFpPoBtdFfUeXqesEmpPrDMy2rFYj/H8DBphkZ6c1PDJvG1S4rR2OO
         wpnJfGtwhAGTUTEk96EqONDROP1KGfCdQrcY7WjVOqRKAAwG9oEMD/s0D0W1zPL/MIrB
         uNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749946484; x=1750551284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCml5/N0kTKx0dstq2eExvuMKXraBjlaD4azIIkhY74=;
        b=kQ2+IEOpXyqPJOV+yUn2ezF0qmpvyD05zjjidFGJzji3WZ5uBH897KaRL2JZd0HOw7
         3JQHEatNFhvRsM7AjqfFwjXpwaXWc0RvyyVHP2o0WB777t2GswNn7QCfLBKD1cfw3gRA
         lbbd0BoAWya7Jw9V8A7Njfx56Dmung+oyq4qsHRWIOAR8VoHnNW36QwLNO3uuqjG9s0N
         L7XvZYWmwwwtjmnz7JSeeUxKVAyNALLYTnh0Im4KwvDVD+y+cpeyNTtMtVlZad6dc0Mo
         triFIAAVW5QNog5R4C9iKfmPzajddGeNIXbyLgCfvBvspaPJbam5L6vJOhmCSuRRRuIt
         a3bQ==
X-Gm-Message-State: AOJu0YyTyZelHB1NPdKvYNQwnPpONBpqehKm7G0PKJuJTJppnE9+Mjfu
	Y0dBS+SqEDti/KM9VtBA/jbtcfkfcHEm9olddpTONUU7p8SeWgzLc7a/
X-Gm-Gg: ASbGncv2tt/9DaYL0cIyhQmKNI6ob+k6J9SfUdtGxTejYoMwyvmZqyXBPTUAmHnl6m0
	8vsL3C1NKeH8cnc/jjGrB6tKp+HI6c1WcI5GIXuLsgZtdanS9E5fEInPDyjY6R6xNMkUzBszjsO
	TKvCaV8L4Vp05gIIRN1bdmiBsAb9Wn4jVJbiH0RR7bLzzNVG3lGAWZF1jfP4UCyi/mkqeLW1iPG
	sc4RPHLpETzdDngD2H/HCYSuGxsbOLdjhN0D/djoZVEIXgsLvGXmAQ5y0fvGd96xMB3TV6qsKqL
	SzE2z0JATaR30qrT5PTEgIfYfs8yT3lQtTQzj0fjf8Sf4EOxrrdXasoh04SLtRzT2gUC7XQcZhH
	ySHU=
X-Google-Smtp-Source: AGHT+IGn60cAzwVRJLyjAJPKC/a0CWmPkbhtmTM5tRdjDn1/UTTTfLc/XTV9HngvyEol5OWmoRpeZQ==
X-Received: by 2002:ad4:5968:0:b0:6fb:d7:f38b with SMTP id 6a1803df08f44-6fb478181d4mr25178356d6.9.1749946483604;
        Sat, 14 Jun 2025 17:14:43 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:315:5a93:3ace:2771:a40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c322c0sm36194686d6.76.2025.06.14.17.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 17:14:43 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next v2 2/3] tcp: remove RFC3517/RFC6675 hint state: lost_skb_hint, lost_cnt_hint
Date: Sat, 14 Jun 2025 20:14:34 -0400
Message-ID: <20250615001435.2390793-3-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250615001435.2390793-1-ncardwell.sw@gmail.com>
References: <20250615001435.2390793-1-ncardwell.sw@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neal Cardwell <ncardwell@google.com>

Now that obsolete RFC3517/RFC6675 TCP loss detection has been removed,
we can remove the somewhat complex and intrusive code to maintain its
hint state: lost_skb_hint and lost_cnt_hint.

This commit makes tcp_clear_retrans_hints_partial() empty. We will
remove tcp_clear_retrans_hints_partial() and its call sites in the
next commit.

Suggested-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |  2 --
 include/linux/tcp.h                           |  3 ---
 include/net/tcp.h                             |  1 -
 net/ipv4/tcp.c                                |  3 +--
 net/ipv4/tcp_input.c                          | 19 -------------------
 net/ipv4/tcp_output.c                         |  5 -----
 6 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index bc9b2131bf7ac..7bbda5944ee2f 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -115,7 +115,6 @@ u32                           lost_out                read_mostly         read_m
 u32                           sacked_out              read_mostly         read_mostly         tcp_left_out(tx);tcp_packets_in_flight(tx/rx);tcp_clean_rtx_queue(rx)
 struct hrtimer                pacing_timer
 struct hrtimer                compressed_ack_timer
-struct sk_buff*               lost_skb_hint           read_mostly                             tcp_clean_rtx_queue
 struct sk_buff*               retransmit_skb_hint     read_mostly                             tcp_clean_rtx_queue
 struct rb_root                out_of_order_queue                          read_mostly         tcp_data_queue,tcp_fast_path_check
 struct sk_buff*               ooo_last_skb
@@ -123,7 +122,6 @@ struct tcp_sack_block[1]      duplicate_sack
 struct tcp_sack_block[4]      selective_acks
 struct tcp_sack_block[4]      recv_sack_cache
 struct sk_buff*               highest_sack            read_write                              tcp_event_new_data_sent
-int                           lost_cnt_hint
 u32                           prior_ssthresh
 u32                           high_seq
 u32                           retrans_stamp
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 29f59d50dc73f..1a5737b3753d0 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -208,7 +208,6 @@ struct tcp_sock {
 	u32	notsent_lowat;	/* TCP_NOTSENT_LOWAT */
 	u16	gso_segs;	/* Max number of segs per GSO packet	*/
 	/* from STCP, retrans queue hinting */
-	struct sk_buff *lost_skb_hint;
 	struct sk_buff *retransmit_skb_hint;
 	__cacheline_group_end(tcp_sock_read_tx);
 
@@ -419,8 +418,6 @@ struct tcp_sock {
 
 	struct tcp_sack_block recv_sack_cache[4];
 
-	int     lost_cnt_hint;
-
 	u32	prior_ssthresh; /* ssthresh saved at recovery start	*/
 	u32	high_seq;	/* snd_nxt at onset of congestion	*/
 
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5078ad868feef..f57d121837949 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1813,7 +1813,6 @@ static inline void tcp_mib_init(struct net *net)
 /* from STCP */
 static inline void tcp_clear_retrans_hints_partial(struct tcp_sock *tp)
 {
-	tp->lost_skb_hint = NULL;
 }
 
 static inline void tcp_clear_all_retrans_hints(struct tcp_sock *tp)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f64f8276a73cd..27d3ef83ce7b2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5053,9 +5053,8 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, reordering);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, notsent_lowat);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, gso_segs);
-	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, lost_skb_hint);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_tx, retransmit_skb_hint);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_tx, 40);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_tx, 32);
 
 	/* TXRX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, tsoffset);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index dc234d3854aa4..e8e130e946f14 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1451,11 +1451,6 @@ static u8 tcp_sacktag_one(struct sock *sk,
 		tp->sacked_out += pcount;
 		/* Out-of-order packets delivered */
 		state->sack_delivered += pcount;
-
-		/* Lost marker hint past SACKed? Tweak RFC3517 cnt */
-		if (tp->lost_skb_hint &&
-		    before(start_seq, TCP_SKB_CB(tp->lost_skb_hint)->seq))
-			tp->lost_cnt_hint += pcount;
 	}
 
 	/* D-SACK. We can detect redundant retransmission in S|R and plain R
@@ -1496,9 +1491,6 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 			tcp_skb_timestamp_us(skb));
 	tcp_rate_skb_delivered(sk, skb, state->rate);
 
-	if (skb == tp->lost_skb_hint)
-		tp->lost_cnt_hint += pcount;
-
 	TCP_SKB_CB(prev)->end_seq += shifted;
 	TCP_SKB_CB(skb)->seq += shifted;
 
@@ -1531,10 +1523,6 @@ static bool tcp_shifted_skb(struct sock *sk, struct sk_buff *prev,
 
 	if (skb == tp->retransmit_skb_hint)
 		tp->retransmit_skb_hint = prev;
-	if (skb == tp->lost_skb_hint) {
-		tp->lost_skb_hint = prev;
-		tp->lost_cnt_hint -= tcp_skb_pcount(prev);
-	}
 
 	TCP_SKB_CB(prev)->tcp_flags |= TCP_SKB_CB(skb)->tcp_flags;
 	TCP_SKB_CB(prev)->eor = TCP_SKB_CB(skb)->eor;
@@ -3318,8 +3306,6 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 		next = skb_rb_next(skb);
 		if (unlikely(skb == tp->retransmit_skb_hint))
 			tp->retransmit_skb_hint = NULL;
-		if (unlikely(skb == tp->lost_skb_hint))
-			tp->lost_skb_hint = NULL;
 		tcp_highest_sack_replace(sk, skb, next);
 		tcp_rtx_queue_unlink_and_free(skb, sk);
 	}
@@ -3377,14 +3363,9 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 			if (flag & FLAG_RETRANS_DATA_ACKED)
 				flag &= ~FLAG_ORIG_SACK_ACKED;
 		} else {
-			int delta;
-
 			/* Non-retransmitted hole got filled? That's reordering */
 			if (before(reord, prior_fack))
 				tcp_check_sack_reordering(sk, reord, 0);
-
-			delta = prior_sacked - tp->sacked_out;
-			tp->lost_cnt_hint -= min(tp->lost_cnt_hint, delta);
 		}
 	} else if (skb && rtt_update && sack_rtt_us >= 0 &&
 		   sack_rtt_us > tcp_stamp_us_delta(tp->tcp_mstamp,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3ac8d2d17e1ff..b0ffefe604b4c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1554,11 +1554,6 @@ static void tcp_adjust_pcount(struct sock *sk, const struct sk_buff *skb, int de
 	if (tcp_is_reno(tp) && decr > 0)
 		tp->sacked_out -= min_t(u32, tp->sacked_out, decr);
 
-	if (tp->lost_skb_hint &&
-	    before(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(tp->lost_skb_hint)->seq) &&
-	    (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED))
-		tp->lost_cnt_hint -= decr;
-
 	tcp_verify_left_out(tp);
 }
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


