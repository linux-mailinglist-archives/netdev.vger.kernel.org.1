Return-Path: <netdev+bounces-250840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 167F1D394F2
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 13:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E89D300B282
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9045D234973;
	Sun, 18 Jan 2026 12:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RX9JbIzc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E8CA4E
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768739528; cv=none; b=Wm5f/I1O3OCze87kRmQhMzdeAcvoMiX+sd0E1yZDnL5sZ91huADnS4mZwUgz+B8ecwO0uvpUJDg0OW6y5rdaZ0f4G+QQ7ZzotBqpa+3IKZiBCFKNPP8vHRNWtZ+WIy0zPd/W2vj09MptEm6CsSWWJO5oAxFsCKKQFnkltgyU5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768739528; c=relaxed/simple;
	bh=XHu82F7uTR3r3wrdSA26znqApoPuEgp+Ef67L5YTaj0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ARjy5dWBtMenup3BpUrCCAytHCAvj1a9FWQ0GHHQwi6fWdOUpVLu66qntND/rFZaoW8iBC3YhF0GrcjTYcTxkdRtkZ/h6BWdI9/zr9AF7WcekPKGM8MjMHs8luDSy5whiQO0qzVceLbbOLAVoVmJEcMOuSqYNoPWlPZW3l5wZgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RX9JbIzc; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c53919fbfcso864836085a.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768739526; x=1769344326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xQFer1o50tJZlORKfOv5x8x5Nn49QkQuW5AEvHfXNBc=;
        b=RX9JbIzcfuVQHKgmzNBGlSkk7J88xsvmXe+EXRoEPYhZnumznb/RxgVG+8UaK2K25H
         kU2Yqm9lbZ5Sf+bVvmktTu5PQouJgxJuyFC6PFKpxWJQfsL5gn7hfV4HpctKyD/Bs9Sm
         kkGtkHUKrrPIpXEhEKWAdEbyCpGfoD7yMFYgT/MuxTNqf6pww2vbm7sVpuNZfrsbBAcS
         UZPhzZO8ooIRiiyAUdlpbMVK2Wrhmg5NlDeF3rf8XGrMlti7/7mTKe/FKteg9G/0Pe6N
         Um4SrGsUUOdwSYQdx1u2y5kb90xqG0QrujObgOTMaPUN69J+w6F34KN4ODUHeejmjMFo
         Wamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768739526; x=1769344326;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQFer1o50tJZlORKfOv5x8x5Nn49QkQuW5AEvHfXNBc=;
        b=AHzJR2sPoW8EuKl7XRXPWYFB8ehrbBdbnBkCJzzkLVuV/msWOBqgx/GNfgeiiF3oCm
         46g/pREyCT6f6aouAnrfB2OXsWVxWmUjpY2DoO+9cbzJ411NcNNG95U6p8N8OB34IixD
         7I81WrCEcK7foQRhzq8/Sji75Dv7nmPClbFSbb4Ol0XfOh2JBtRp6/ECQmVTrRFdSbJV
         uWHaLRmB+fifXoe5OfKR3zJZYSXaA+5PRU5KhotSMDyjOAGOhzZDBPOIOEp9yw4xyjYS
         fPPOmAyHcnqabEm5dUc4HXAZLlC2xtgSPrwjHsnsrXva4RH89GAwgx+5HLFsZykuf4lL
         FNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf/mg3AdFCqPkyejzQ/vlczaZZFzj9FFEAN4sxPkG5o7g3PzF/tLydwY1YxY8AaEDq4grFrc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxngbcMHuRMMfWovDzCKH8ih3MDwL/iG0fpApRNTZITBKC97H
	D5mtANtnp/GwqQE9Og4kEIW3MnQ9CLjehe8HhZSuc556Lgg2GtgRb55WLmpr/o7QJ6ubnJOuDHR
	Ej1v3wdDXssqOcA==
X-Received: from qknsw2.prod.google.com ([2002:a05:620a:4bc2:b0:8c3:9707:a7ad])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:8a08:b0:8c6:a723:77c with SMTP id af79cd13be357-8c6a723082bmr845567585a.60.1768739525908;
 Sun, 18 Jan 2026 04:32:05 -0800 (PST)
Date: Sun, 18 Jan 2026 12:32:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260118123204.2315993-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move tcp_rate_skb_delivered() to tcp_input.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_rate_skb_delivered() is only called from tcp_input.c.
Move it there and make it static.

Both gcc and clang are (auto)inlining it, TCP performance
is increased at a small space cost.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 3/0 up/down: 509/-187 (322)
Function                                     old     new   delta
tcp_sacktag_walk                            1682    1867    +185
tcp_ack                                     5230    5405    +175
tcp_shifted_skb                              437     586    +149
__pfx_tcp_rate_skb_delivered                  16       -     -16
tcp_rate_skb_delivered                       171       -    -171
Total: Before=22566192, After=22566514, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    |  2 --
 net/ipv4/tcp_input.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_rate.c  | 44 --------------------------------------------
 3 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 15f9b20f851fe322f4417ff403c3965436aa3f9f..25143f156957288f5b8674d4d27b805e92c592c8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1356,8 +1356,6 @@ static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
 
 /* From tcp_rate.c */
-void tcp_rate_skb_delivered(struct sock *sk, struct sk_buff *skb,
-			    struct rate_sample *rs);
 void tcp_rate_gen(struct sock *sk, u32 delivered, u32 lost,
 		  bool is_sack_reneg, struct rate_sample *rs);
 void tcp_rate_check_app_limited(struct sock *sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 198f8a0d37be04f78da9268a230c9494b50b672a..dc8e256321b03da0ef97b4512d2cb5f202501dfa 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1637,6 +1637,50 @@ static u8 tcp_sacktag_one(struct sock *sk,
 	return sacked;
 }
 
+/* When an skb is sacked or acked, we fill in the rate sample with the (prior)
+ * delivery information when the skb was last transmitted.
+ *
+ * If an ACK (s)acks multiple skbs (e.g., stretched-acks), this function is
+ * called multiple times. We favor the information from the most recently
+ * sent skb, i.e., the skb with the most recently sent time and the highest
+ * sequence.
+ */
+static void tcp_rate_skb_delivered(struct sock *sk, struct sk_buff *skb,
+				   struct rate_sample *rs)
+{
+	struct tcp_skb_cb *scb = TCP_SKB_CB(skb);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u64 tx_tstamp;
+
+	if (!scb->tx.delivered_mstamp)
+		return;
+
+	tx_tstamp = tcp_skb_timestamp_us(skb);
+	if (!rs->prior_delivered ||
+	    tcp_skb_sent_after(tx_tstamp, tp->first_tx_mstamp,
+			       scb->end_seq, rs->last_end_seq)) {
+		rs->prior_delivered_ce  = scb->tx.delivered_ce;
+		rs->prior_delivered  = scb->tx.delivered;
+		rs->prior_mstamp     = scb->tx.delivered_mstamp;
+		rs->is_app_limited   = scb->tx.is_app_limited;
+		rs->is_retrans	     = scb->sacked & TCPCB_RETRANS;
+		rs->last_end_seq     = scb->end_seq;
+
+		/* Record send time of most recently ACKed packet: */
+		tp->first_tx_mstamp  = tx_tstamp;
+		/* Find the duration of the "send phase" of this window: */
+		rs->interval_us = tcp_stamp_us_delta(tp->first_tx_mstamp,
+						     scb->tx.first_tx_mstamp);
+
+	}
+	/* Mark off the skb delivered once it's sacked to avoid being
+	 * used again when it's cumulatively acked. For acked packets
+	 * we don't need to reset since it'll be freed soon.
+	 */
+	if (scb->sacked & TCPCB_SACKED_ACKED)
+		scb->tx.delivered_mstamp = 0;
+}
+
 /* Shift newly-SACKed bytes from this skb to the immediately previous
  * already-SACKed sk_buff. Mark the newly-SACKed bytes as such.
  */
diff --git a/net/ipv4/tcp_rate.c b/net/ipv4/tcp_rate.c
index 98eb346f986ef24969f804c3b55acbf60d2ec299..f0f2ef377043d797eb0270be1f54e65b21673f02 100644
--- a/net/ipv4/tcp_rate.c
+++ b/net/ipv4/tcp_rate.c
@@ -34,50 +34,6 @@
  * ready to send in the write queue.
  */
 
-/* When an skb is sacked or acked, we fill in the rate sample with the (prior)
- * delivery information when the skb was last transmitted.
- *
- * If an ACK (s)acks multiple skbs (e.g., stretched-acks), this function is
- * called multiple times. We favor the information from the most recently
- * sent skb, i.e., the skb with the most recently sent time and the highest
- * sequence.
- */
-void tcp_rate_skb_delivered(struct sock *sk, struct sk_buff *skb,
-			    struct rate_sample *rs)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-	struct tcp_skb_cb *scb = TCP_SKB_CB(skb);
-	u64 tx_tstamp;
-
-	if (!scb->tx.delivered_mstamp)
-		return;
-
-	tx_tstamp = tcp_skb_timestamp_us(skb);
-	if (!rs->prior_delivered ||
-	    tcp_skb_sent_after(tx_tstamp, tp->first_tx_mstamp,
-			       scb->end_seq, rs->last_end_seq)) {
-		rs->prior_delivered_ce  = scb->tx.delivered_ce;
-		rs->prior_delivered  = scb->tx.delivered;
-		rs->prior_mstamp     = scb->tx.delivered_mstamp;
-		rs->is_app_limited   = scb->tx.is_app_limited;
-		rs->is_retrans	     = scb->sacked & TCPCB_RETRANS;
-		rs->last_end_seq     = scb->end_seq;
-
-		/* Record send time of most recently ACKed packet: */
-		tp->first_tx_mstamp  = tx_tstamp;
-		/* Find the duration of the "send phase" of this window: */
-		rs->interval_us = tcp_stamp_us_delta(tp->first_tx_mstamp,
-						     scb->tx.first_tx_mstamp);
-
-	}
-	/* Mark off the skb delivered once it's sacked to avoid being
-	 * used again when it's cumulatively acked. For acked packets
-	 * we don't need to reset since it'll be freed soon.
-	 */
-	if (scb->sacked & TCPCB_SACKED_ACKED)
-		scb->tx.delivered_mstamp = 0;
-}
-
 /* Update the connection delivery information and generate a rate sample. */
 void tcp_rate_gen(struct sock *sk, u32 delivered, u32 lost,
 		  bool is_sack_reneg, struct rate_sample *rs)
-- 
2.52.0.457.g6b5491de43-goog


