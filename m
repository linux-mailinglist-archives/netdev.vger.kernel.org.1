Return-Path: <netdev+bounces-197662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6363AD9883
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC9D4A24E2
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9978D28F508;
	Fri, 13 Jun 2025 23:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7wYellm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0C628ECCB
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856156; cv=none; b=fgUr/DQSDx92CLBMPLMxFgB8/1+pcGBjQcF6N+lVEPXbe4hTm+STy2by0cRSrwvaVj5VfbzeVTQjhEuCR0mAhCRZiY8JRvbq8RGLqLBd/iyxwNMosSYIxvJ1mUeipWrNlMcsoFNHiLjG5XqxLbFGacI6yDOkAeGo0bj+O12zBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856156; c=relaxed/simple;
	bh=tOSlEGlQgW7mc9bHyAZvGvEVvhPfpkxVmDqpWZmLw7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8nTiuM0UR5ZcQ27oTRLVgyXbwtVCR8TIjrduwqcGJgTtBQfBfEpwdLHfx2KItiFUfaXx/G9Iyk3k8raubqz/n06W503PW2tE7A7D0siJko71QKKXiUzogW2s+kXk51WaNB/EXdySQZgWcazFZZpMyqfZ2Lvxhsss165rbUQxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7wYellm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d094f67777so45432785a.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749856153; x=1750460953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jztvNaA6dzVjNXbRcCmdP8E8tqNYo036LR3mUZlrfvA=;
        b=V7wYellmKvKoIRW5j2sMAmxbCtdcXxRneTvYL7lCprmWqET6x9I4F4YYy3PFzQK3gq
         iQTTBWt8sylZ7Rc1r5RYeVtsy7f4kJph78SobpRPrrEreuC6SAiVj/ma9rtUnlR9WhHD
         psXeGSPxzUq0y8jypHYzNT3jdEd2BK25J2RMxDf28HLGYNYbm+QtTqQXaFTX6mWPNOly
         th7ZHdjZ4N1Bl2qp6icI0PL9itqAu1jn0oiYoGajxJbs+r174p4zg9ylhpEV/8I12w0M
         nBKQ7He9RqUCCL6+2P/gwvW/qRmAwV0LtMMR72wGrT/8zqVCBhEcRg9nXeVhv0GirhXK
         RQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749856153; x=1750460953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jztvNaA6dzVjNXbRcCmdP8E8tqNYo036LR3mUZlrfvA=;
        b=UwU9HbcrYsBexwwuo42RWeYWpgQutMtv1NrS3TlZ+lqlYe74Ke4mTV0OpL+MqkTc8b
         tfeVl73k91HpW+pWv5dC6sTnCwr+FHw9PACPR/k3+gpuu6jaIE3S5yuGdq2TDKbsbwTz
         ecuUIT9sVgZWm3C0DHG0UOAiwGOHuBmA23tqoiv0zm2GE71UaIeltyRldTMhlmohX33k
         9aKpH+wVQxqsZ2/hdUP7zAstxDvIuIxAMBW0fB4YbEGWKHDAEqG6cpM6HudXO0853mpt
         00loQtEyubf7yuM0IIZxuUyuEZJXkwRTzPea4VF3lM0lC/sjf/xpgszuCqZo75b0WVp/
         SQcA==
X-Gm-Message-State: AOJu0Yz4Ts8l63so0mmKMpVUPih/OwvuxpRgfdGcfr1SinJE5rTuPUhu
	0rse7sjht1SrXcE09irQ4RmBGlRUazIdtPmGXjgUXQuPDWGIp9NWAIDu2TIEbg==
X-Gm-Gg: ASbGnctKSP/bqdrbBi88kiWVUNW7ATEAJddHPhwQ9LvkO3SlUPWDqPfkxM2I7cSn+WQ
	CoiPIpSDmV+xWQqmHFwGy1RdduNBTrzQIfEErFkkSYoQZVYSBxJWpgA/lkhFewIndPurMH2WdVK
	wM6PQqC9Zn8wTIkNlv+GbEtKfHeBHZtUkIeqdZhRpfqMWOtkb3IPEpmtlfGrNjnfgqzdF0QTFc5
	x9VKlvyKq11RcISmzWq7d0bjNuP7glM8wg7FzxCQ6wSC8FLeQ+PxCZ427ljOpwhMb05yDhPD3BH
	P7XQcnORNVoMPvVUNm4eKs65XYqSS7CZc5H2bO63sXgVIg4268F8iaku9kfEWV/9iI8tyY9CXMZ
	rUYQa
X-Google-Smtp-Source: AGHT+IELZnnapLKOT8dUAtIcmvcOpbMZoHNLMJeqp4Go0BuvswxlYaUl37LDvK9Y8bqzUosWnz9JPg==
X-Received: by 2002:a05:622a:38d:b0:476:addb:c452 with SMTP id d75a77b69052e-4a73c568d5emr5699301cf.6.1749856153468;
        Fri, 13 Jun 2025 16:09:13 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:315:8d12:28c7:afe9:8851])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a2f4fc5sm23122651cf.26.2025.06.13.16.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 16:09:13 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next 2/3] tcp: remove RFC3517/RFC6675 hint state: lost_skb_hint, lost_cnt_hint
Date: Fri, 13 Jun 2025 19:09:05 -0400
Message-ID: <20250613230907.1702265-3-ncardwell.sw@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250613230907.1702265-1-ncardwell.sw@gmail.com>
References: <20250613230907.1702265-1-ncardwell.sw@gmail.com>
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
 .../networking/net_cachelines/tcp_sock.rst        |  2 --
 include/linux/tcp.h                               |  3 ---
 include/net/tcp.h                                 |  1 -
 net/ipv4/tcp.c                                    |  3 +--
 net/ipv4/tcp_input.c                              | 15 ---------------
 net/ipv4/tcp_output.c                             |  5 -----
 6 files changed, 1 insertion(+), 28 deletions(-)

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
index b52eaa45e652f..9ded9b371d98a 100644
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
@@ -3319,8 +3307,6 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 		next = skb_rb_next(skb);
 		if (unlikely(skb == tp->retransmit_skb_hint))
 			tp->retransmit_skb_hint = NULL;
-		if (unlikely(skb == tp->lost_skb_hint))
-			tp->lost_skb_hint = NULL;
 		tcp_highest_sack_replace(sk, skb, next);
 		tcp_rtx_queue_unlink_and_free(skb, sk);
 	}
@@ -3385,7 +3371,6 @@ static int tcp_clean_rtx_queue(struct sock *sk, const struct sk_buff *ack_skb,
 				tcp_check_sack_reordering(sk, reord, 0);
 
 			delta = prior_sacked - tp->sacked_out;
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


