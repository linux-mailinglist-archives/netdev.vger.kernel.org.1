Return-Path: <netdev+bounces-197850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD899ADA05C
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 02:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346427A694A
	for <lists+netdev@lfdr.de>; Sun, 15 Jun 2025 00:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42A92E11D0;
	Sun, 15 Jun 2025 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNLQplej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D01C27
	for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749946485; cv=none; b=cPSjpBjl1QuQGfYOs4pwmoEf5IVGYuWYqKsIt/2cYDNaVVOg2Mrnu0DlQYlFi65Bx0q3RSek3aHMHlCoOwhU7gDcNyxc1TN2tdjUuYsCoprToEdnWt/hRsbmw6RHFjIf7HmZCQrj31bVvWueeQG7SQL8TGMDYV50QiniNCZEPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749946485; c=relaxed/simple;
	bh=R+U1iCne8qjQUjuxp0Rjsliyehk/sWR2Rc61urTQgn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUMQqIIeAmNzY+iLGmycpeTcbK/9tGOm83vIczx9rK2ghYOpTEaUEAtQEcYA2CXXEvsxHXo+0Dk/0jOY11YdI7MVFS3r1YCGmOSG4vgncehJwQ19msEi3DSEgpzpvo6Emq4+dtq1rrQD6tgU1M4REFBU2UDt9OEuuU4iVc+Hnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNLQplej; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7caeeef9629so80478485a.3
        for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 17:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749946482; x=1750551282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbIHQFNyIVuo4D5HJCisnl+xiEjtiVx71YSCVqy8Szg=;
        b=VNLQplejw9+H+xsmS3kxlGvLaC13r5g3WPru+3DsqZiRKsvBH6+/x5svRCWifN3I10
         KpU69WgkJuyIENyKjHh3gnuaUwloZ4KCnGIPiAHLPw5uv++daqNNGbWfCLei2prMYteK
         p5mkL1z10PN5oj+rwRkwJzE6uYyJheSeU+rTr/LzoWuS5GaaxBanrtxzmAQ6cORX/or9
         lA/jMYLUd9gwrXSGhS/zV9BSZg83KssZCHjNsr6sQJLgIS8Q3cb9TgoMIjy9z/Cxt/dv
         rPp7xZrmqfP07roo3VjYvl/9HAaQHID+m3sVdZdEL5c3JyB4roL8RVT+sePteH9wf+2o
         wOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749946482; x=1750551282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbIHQFNyIVuo4D5HJCisnl+xiEjtiVx71YSCVqy8Szg=;
        b=SZs4oNSMXcFZW2c22mnZTY9WjcJRFQzY073DoxMvVOELsXIeYFKvlxlwqC5Jki8GSP
         ciF8T7LehDo/xx2b7gQTPLFVIcTQDRSaj57xWBHVayVti1siqVgOF3TaSmS+chvOQzzq
         czxEXBrZzMwmCT7MinqfXGxO+X5ulfRfpXBOZDfZxsRemuR3A1qBM+vFABU+NOUNyRuo
         wkBdCBYaFlG8emw8waKBPV6/qeCnUgtmmvn2JUzyLkKKMIYvrUwCeXvkr1Rrrh52ned8
         IGx5fUjbu7AfJAItU2je+f2EuHjeAoA8ur76JaT4uuWkmAnQLoKWVx+Lk9NmBGbDPrV2
         go3A==
X-Gm-Message-State: AOJu0YzBJKtpzE6Vur4l3qbfJCwDSgHs8RB8F/xhT/T4fknQ0zRmhxj4
	3wVpK3nNLqqPgvLaHAkrLY6sz39rHe3n3kj37mxEfNdYHymW++IBIpCR
X-Gm-Gg: ASbGnctJgUY5cVDvaqXPNcWCrvE2bnJfDH3oRhjg2yIcjnnCgp3IjKGcdiJO92rnZ3F
	BCZcLCIR9UTN+oK9skw9zNQYtllUt15tY8a7n10XeGc25gTQ4RqWpHZoz0a6KVRN9Jqy/WpoYmj
	LMcN0vSjFrXh03yK++wnZNQ0fphQEv3RKWqCHjLM2KDbGh3KQMAeMxEK+VmB3z4njslKqjYG0VH
	gPX06AqkgGPLo1W2q+3TnXptUFPp88F8NXqStmWKZ6NeGKR6CCsjOzSLxCEwy08SCpPxJofyW8w
	EJuFnkOhh7+b/8tprQwIa2JhcrNTU+2O6+7T6iG7Zsz8JmEfWI8FnGOB8J2kiKXNbkK1aMk5c5Q
	1/HU=
X-Google-Smtp-Source: AGHT+IHdLoM5fVn0l9Ce0BWJ8q0YG2tiA9r74mlUsibYIMdgzf9weiLEKunMmZLw4JEbVnPgpXZVvw==
X-Received: by 2002:a05:6214:3986:b0:6f2:c10b:db11 with SMTP id 6a1803df08f44-6fb47793f60mr26405596d6.6.1749946482243;
        Sat, 14 Jun 2025 17:14:42 -0700 (PDT)
Received: from soy.nyc.corp.google.com ([2620:0:1003:315:5a93:3ace:2771:a40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35c322c0sm36194686d6.76.2025.06.14.17.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 17:14:41 -0700 (PDT)
From: Neal Cardwell <ncardwell.sw@gmail.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>
Subject: [PATCH net-next v2 1/3] tcp: remove obsolete and unused RFC3517/RFC6675 loss recovery code
Date: Sat, 14 Jun 2025 20:14:33 -0400
Message-ID: <20250615001435.2390793-2-ncardwell.sw@gmail.com>
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

RACK-TLP loss detection has been enabled as the default loss detection
algorithm for Linux TCP since 2018, in:

 commit b38a51fec1c1 ("tcp: disable RFC6675 loss detection")

In case users ran into unexpected bugs or performance regressions,
that commit allowed Linux system administrators to revert to using
RFC3517/RFC6675 loss recovery by setting net.ipv4.tcp_recovery to 0.

In the seven years since 2018, our team has not heard reports of
anyone reverting Linux TCP to use RFC3517/RFC6675 loss recovery, and
we can't find any record in web searches of such a revert.

RACK-TLP was published as a standards-track RFC, RFC8985, in February
2021.

Several other major TCP implementations have default-enabled RACK-TLP
at this point as well.

RACK-TLP offers several significant performance advantages over
RFC3517/RFC6675 loss recovery, including much better performance in
the common cases of tail drops, lost retransmissions, and reordering.

It is now time to remove the obsolete and unused RFC3517/RFC6675 loss
recovery code. This will allow a substantial simplification of the
Linux TCP code base, and removes 12 bytes of state in every tcp_sock
for 64-bit machines (8 bytes on 32-bit machines).

To arrange the commits in reasonable sizes, this patch series is split
into 3 commits. The following 2 commits remove bookkeeping state and
code that is no longer needed after this removal of RFC3517/RFC6675
loss recovery.

Suggested-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Reviewed-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 Documentation/networking/ip-sysctl.rst |   8 +-
 net/ipv4/tcp_input.c                   | 137 ++-----------------------
 2 files changed, 15 insertions(+), 130 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 0f1251cce3149..b31c055f576fa 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -645,9 +645,11 @@ tcp_recovery - INTEGER
 	features.
 
 	=========   =============================================================
-	RACK: 0x1   enables the RACK loss detection for fast detection of lost
-		    retransmissions and tail drops. It also subsumes and disables
-		    RFC6675 recovery for SACK connections.
+	RACK: 0x1   enables RACK loss detection, for fast detection of lost
+		    retransmissions and tail drops, and resilience to
+		    reordering. currrently, setting this bit to 0 has no
+		    effect, since RACK is the only supported loss detection
+		    algorithm.
 
 	RACK: 0x2   makes RACK's reordering window static (min_rtt/4).
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8ec92dec321a9..dc234d3854aa4 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2151,12 +2151,6 @@ static inline void tcp_init_undo(struct tcp_sock *tp)
 		tp->undo_retrans = -1;
 }
 
-static bool tcp_is_rack(const struct sock *sk)
-{
-	return READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_recovery) &
-		TCP_RACK_LOSS_DETECTION;
-}
-
 /* If we detect SACK reneging, forget all SACK information
  * and reset tags completely, otherwise preserve SACKs. If receiver
  * dropped its ofo queue, we will know this due to reneging detection.
@@ -2182,8 +2176,7 @@ static void tcp_timeout_mark_lost(struct sock *sk)
 	skb_rbtree_walk_from(skb) {
 		if (is_reneg)
 			TCP_SKB_CB(skb)->sacked &= ~TCPCB_SACKED_ACKED;
-		else if (tcp_is_rack(sk) && skb != head &&
-			 tcp_rack_skb_timeout(tp, skb, 0) > 0)
+		else if (skb != head && tcp_rack_skb_timeout(tp, skb, 0) > 0)
 			continue; /* Don't mark recently sent ones lost yet */
 		tcp_mark_skb_lost(sk, skb);
 	}
@@ -2264,22 +2257,6 @@ static bool tcp_check_sack_reneging(struct sock *sk, int *ack_flag)
 	return false;
 }
 
-/* Heurestics to calculate number of duplicate ACKs. There's no dupACKs
- * counter when SACK is enabled (without SACK, sacked_out is used for
- * that purpose).
- *
- * With reordering, holes may still be in flight, so RFC3517 recovery
- * uses pure sacked_out (total number of SACKed segments) even though
- * it violates the RFC that uses duplicate ACKs, often these are equal
- * but when e.g. out-of-window ACKs or packet duplication occurs,
- * they differ. Since neither occurs due to loss, TCP should really
- * ignore them.
- */
-static inline int tcp_dupack_heuristics(const struct tcp_sock *tp)
-{
-	return tp->sacked_out + 1;
-}
-
 /* Linux NewReno/SACK/ECN state machine.
  * --------------------------------------
  *
@@ -2332,13 +2309,7 @@ static inline int tcp_dupack_heuristics(const struct tcp_sock *tp)
  *
  *		If the receiver supports SACK:
  *
- *		RFC6675/3517: It is the conventional algorithm. A packet is
- *		considered lost if the number of higher sequence packets
- *		SACKed is greater than or equal the DUPACK thoreshold
- *		(reordering). This is implemented in tcp_mark_head_lost and
- *		tcp_update_scoreboard.
- *
- *		RACK (draft-ietf-tcpm-rack-01): it is a newer algorithm
+ *		RACK (RFC8985): RACK is a newer loss detection algorithm
  *		(2017-) that checks timing instead of counting DUPACKs.
  *		Essentially a packet is considered lost if it's not S/ACKed
  *		after RTT + reordering_window, where both metrics are
@@ -2353,8 +2324,8 @@ static inline int tcp_dupack_heuristics(const struct tcp_sock *tp)
  *		is lost (NewReno). This heuristics are the same in NewReno
  *		and SACK.
  *
- * Really tricky (and requiring careful tuning) part of algorithm
- * is hidden in functions tcp_time_to_recover() and tcp_xmit_retransmit_queue().
+ * The really tricky (and requiring careful tuning) part of the algorithm
+ * is hidden in the RACK code in tcp_recovery.c and tcp_xmit_retransmit_queue().
  * The first determines the moment _when_ we should reduce CWND and,
  * hence, slow down forward transmission. In fact, it determines the moment
  * when we decide that hole is caused by loss, rather than by a reorder.
@@ -2381,79 +2352,8 @@ static bool tcp_time_to_recover(struct sock *sk, int flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	/* Trick#1: The loss is proven. */
-	if (tp->lost_out)
-		return true;
-
-	/* Not-A-Trick#2 : Classic rule... */
-	if (!tcp_is_rack(sk) && tcp_dupack_heuristics(tp) > tp->reordering)
-		return true;
-
-	return false;
-}
-
-/* Detect loss in event "A" above by marking head of queue up as lost.
- * For RFC3517 SACK, a segment is considered lost if it
- * has at least tp->reordering SACKed seqments above it; "packets" refers to
- * the maximum SACKed segments to pass before reaching this limit.
- */
-static void tcp_mark_head_lost(struct sock *sk, int packets, int mark_head)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-	struct sk_buff *skb;
-	int cnt;
-	/* Use SACK to deduce losses of new sequences sent during recovery */
-	const u32 loss_high = tp->snd_nxt;
-
-	WARN_ON(packets > tp->packets_out);
-	skb = tp->lost_skb_hint;
-	if (skb) {
-		/* Head already handled? */
-		if (mark_head && after(TCP_SKB_CB(skb)->seq, tp->snd_una))
-			return;
-		cnt = tp->lost_cnt_hint;
-	} else {
-		skb = tcp_rtx_queue_head(sk);
-		cnt = 0;
-	}
-
-	skb_rbtree_walk_from(skb) {
-		/* TODO: do this better */
-		/* this is not the most efficient way to do this... */
-		tp->lost_skb_hint = skb;
-		tp->lost_cnt_hint = cnt;
-
-		if (after(TCP_SKB_CB(skb)->end_seq, loss_high))
-			break;
-
-		if (TCP_SKB_CB(skb)->sacked & TCPCB_SACKED_ACKED)
-			cnt += tcp_skb_pcount(skb);
-
-		if (cnt > packets)
-			break;
-
-		if (!(TCP_SKB_CB(skb)->sacked & TCPCB_LOST))
-			tcp_mark_skb_lost(sk, skb);
-
-		if (mark_head)
-			break;
-	}
-	tcp_verify_left_out(tp);
-}
-
-/* Account newly detected lost packet(s) */
-
-static void tcp_update_scoreboard(struct sock *sk, int fast_rexmit)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	if (tcp_is_sack(tp)) {
-		int sacked_upto = tp->sacked_out - tp->reordering;
-		if (sacked_upto >= 0)
-			tcp_mark_head_lost(sk, sacked_upto, 0);
-		else if (fast_rexmit)
-			tcp_mark_head_lost(sk, 1, 1);
-	}
+	/* Has loss detection marked at least one packet lost? */
+	return tp->lost_out != 0;
 }
 
 static bool tcp_tsopt_ecr_before(const struct tcp_sock *tp, u32 when)
@@ -2990,17 +2890,8 @@ static void tcp_process_loss(struct sock *sk, int flag, int num_dupack,
 	*rexmit = REXMIT_LOST;
 }
 
-static bool tcp_force_fast_retransmit(struct sock *sk)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	return after(tcp_highest_sack_seq(tp),
-		     tp->snd_una + tp->reordering * tp->mss_cache);
-}
-
 /* Undo during fast recovery after partial ACK. */
-static bool tcp_try_undo_partial(struct sock *sk, u32 prior_snd_una,
-				 bool *do_lost)
+static bool tcp_try_undo_partial(struct sock *sk, u32 prior_snd_una)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
@@ -3025,9 +2916,6 @@ static bool tcp_try_undo_partial(struct sock *sk, u32 prior_snd_una,
 		tcp_undo_cwnd_reduction(sk, true);
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPPARTIALUNDO);
 		tcp_try_keep_open(sk);
-	} else {
-		/* Partial ACK arrived. Force fast retransmit. */
-		*do_lost = tcp_force_fast_retransmit(sk);
 	}
 	return false;
 }
@@ -3041,7 +2929,7 @@ static void tcp_identify_packet_loss(struct sock *sk, int *ack_flag)
 
 	if (unlikely(tcp_is_reno(tp))) {
 		tcp_newreno_mark_lost(sk, *ack_flag & FLAG_SND_UNA_ADVANCED);
-	} else if (tcp_is_rack(sk)) {
+	} else {
 		u32 prior_retrans = tp->retrans_out;
 
 		if (tcp_rack_mark_lost(sk))
@@ -3068,10 +2956,8 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 {
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
-	int fast_rexmit = 0, flag = *ack_flag;
+	int flag = *ack_flag;
 	bool ece_ack = flag & FLAG_ECE;
-	bool do_lost = num_dupack || ((flag & FLAG_DATA_SACKED) &&
-				      tcp_force_fast_retransmit(sk));
 
 	if (!tp->packets_out && tp->sacked_out)
 		tp->sacked_out = 0;
@@ -3120,7 +3006,7 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 		if (!(flag & FLAG_SND_UNA_ADVANCED)) {
 			if (tcp_is_reno(tp))
 				tcp_add_reno_sack(sk, num_dupack, ece_ack);
-		} else if (tcp_try_undo_partial(sk, prior_snd_una, &do_lost))
+		} else if (tcp_try_undo_partial(sk, prior_snd_una))
 			return;
 
 		if (tcp_try_undo_dsack(sk))
@@ -3175,11 +3061,8 @@ static void tcp_fastretrans_alert(struct sock *sk, const u32 prior_snd_una,
 
 		/* Otherwise enter Recovery state */
 		tcp_enter_recovery(sk, ece_ack);
-		fast_rexmit = 1;
 	}
 
-	if (!tcp_is_rack(sk) && do_lost)
-		tcp_update_scoreboard(sk, fast_rexmit);
 	*rexmit = REXMIT_LOST;
 }
 
-- 
2.50.0.rc1.591.g9c95f17f64-goog


