Return-Path: <netdev+bounces-249892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18315D2054C
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E77ED300B9DC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6783A6417;
	Wed, 14 Jan 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WcAAE1MN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A63A4F29
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768409476; cv=none; b=lnf3D6soX5aLe+hrWG2lcqDNVwdLpLQJOfqZt/R8IIIxIvi98Dk1MJ0o8fJyqDNfzpJ993/JWDmQ1TAgZ9ZBldwHX5rAsmAlxZsvg0nJxRTpvDqH/5Dnl3+TjTXfi+mJNLzQJLz9Mm204W6Ila2nkjGv3yXgJJzb6NnrfLiWCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768409476; c=relaxed/simple;
	bh=NSs3Ik7B1HYMin1UpshgeyfEslwNzDKlBjC/HPARoGc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F7Ft/r0X2Ozl1iEkxkonbLC2wUUb0hU1Yr3rYNcg9IFCe+u5BKmUIGT6TgaUWus4T2l/aS1iAHrhcKrDmPNJW3khzZHDF7Sa5upLt1h5qLYCiixXd4kf4/Ku8HyXfYTO4J7qlm7ymbODz+rewYaCqMdUaQKLaqad8FzkHn8acls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WcAAE1MN; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88fcbe2e351so25842596d6.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768409473; x=1769014273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CSs1h+3Jome9pZsP/GBiQkQN2iRCoHmDi1R4SFmOKsA=;
        b=WcAAE1MNRbOYp19iZY96aLIYxyzhZk8IMS2zGMnUUvNnyIl2hp6fzId66lebvDVexh
         8+mcoKe1cx8SaOQoSG82CA6Dbic/qUFHHY9dzNBlfnfEvFV5tigQ7/mAvohgKihQsySP
         NqpxoOYrYg8gCGiyR73UJIzPfvnPOufwVXh6JjE3a9aoPfjKq1imrjscvr0GoQ/kZuvJ
         HutSO9QprI5r/qYY/rFfOHZ7GDqjs+DUXqStSBBm3Bq1OX1UneSfZIGMdT2honPr4lhL
         /g0NbGwI30tmj/UZUPp1qWaOQO72e5oR2r2o+RyLenF3yZ4grKFVnX1xJxZYp48guU7S
         XiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768409473; x=1769014273;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CSs1h+3Jome9pZsP/GBiQkQN2iRCoHmDi1R4SFmOKsA=;
        b=f9nE4lFgYqsiXxB28VS2EuXOfknpbcwFYiGTAWwDCAynhawFGqiUr12pDAylwpOFNv
         R7HIGq2lhpo+zN5ZeDmoSF3qUHIf9HUcappO+gFnvf8QxX/f+O53pthfMkG8QMw6RSwT
         2tjJqWpD4XsmqZJMwYDRn+49TbkDA/j/z7nC26iZm3Z+27qma+JmoUWcwld/YslzcuLK
         OOAEpNWVjfW2D3rrk3EexPVLZf4d0e/YOlAyjHhA87ORv5VUhjuEbOry+kMXduf90vnS
         XWMXYd0ml2fZtOTvff4PyxMlQKB6RFyUqPPFoVuCpOVxJ15l5Sc9chXqwot5hHQgLc69
         vLug==
X-Forwarded-Encrypted: i=1; AJvYcCWATvGHGbGEsK+0Cg83Ez3he0iFiAhTQg6IY+bcvmFMACpWLh/nno4GK54KC5fJMGQAs8nyZ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudNwKrSmMb+/G95XBawfE1Z5sF4DmseA741hEx6fS9XFy0H5S
	+Kq0nGjugcZVPvdcqrrdK9mNuJqFwIiYg4vScigvHpLbw0B2TcOzKh4SV4kCu6KJrTGf5kIM6Kw
	W+BgV3PcFKckZDA==
X-Received: from qvbld33.prod.google.com ([2002:a05:6214:41a1:b0:88a:27b1:923a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:12d1:b0:884:6f86:e09a with SMTP id 6a1803df08f44-893980c14d7mr866966d6.6.1768409473431;
 Wed, 14 Jan 2026 08:51:13 -0800 (PST)
Date: Wed, 14 Jan 2026 16:51:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114165109.1747722-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move tcp_rate_skb_sent() to tcp_output.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

It is only called from __tcp_transmit_skb() and __tcp_retransmit_skb().

Move it in tcp_output.c and make it static.

clang compiler is now able to inline it from __tcp_transmit_skb().

gcc compiler inlines it in the two callers, which is also fine.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h     |  1 -
 net/ipv4/tcp_output.c | 35 +++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_rate.c   | 35 -----------------------------------
 3 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ef0fee58fde82620399df49a35c7ecae8e34068e..15f9b20f851fe322f4417ff403c3965436aa3f9f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1356,7 +1356,6 @@ static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
 
 /* From tcp_rate.c */
-void tcp_rate_skb_sent(struct sock *sk, struct sk_buff *skb);
 void tcp_rate_skb_delivered(struct sock *sk, struct sk_buff *skb,
 			    struct rate_sample *rs);
 void tcp_rate_gen(struct sock *sk, u32 delivered, u32 lost,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 479afb714bdf901cdf733c94cd7f22bd705c9d02..256b669e8d3b4a4d191e61e79784e412aaef8965 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1432,6 +1432,41 @@ static void tcp_update_skb_after_send(struct sock *sk, struct sk_buff *skb,
 	list_move_tail(&skb->tcp_tsorted_anchor, &tp->tsorted_sent_queue);
 }
 
+/* Snapshot the current delivery information in the skb, to generate
+ * a rate sample later when the skb is (s)acked in tcp_rate_skb_delivered().
+ */
+static void tcp_rate_skb_sent(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	 /* In general we need to start delivery rate samples from the
+	  * time we received the most recent ACK, to ensure we include
+	  * the full time the network needs to deliver all in-flight
+	  * packets. If there are no packets in flight yet, then we
+	  * know that any ACKs after now indicate that the network was
+	  * able to deliver those packets completely in the sampling
+	  * interval between now and the next ACK.
+	  *
+	  * Note that we use packets_out instead of tcp_packets_in_flight(tp)
+	  * because the latter is a guess based on RTO and loss-marking
+	  * heuristics. We don't want spurious RTOs or loss markings to cause
+	  * a spuriously small time interval, causing a spuriously high
+	  * bandwidth estimate.
+	  */
+	if (!tp->packets_out) {
+		u64 tstamp_us = tcp_skb_timestamp_us(skb);
+
+		tp->first_tx_mstamp  = tstamp_us;
+		tp->delivered_mstamp = tstamp_us;
+	}
+
+	TCP_SKB_CB(skb)->tx.first_tx_mstamp	= tp->first_tx_mstamp;
+	TCP_SKB_CB(skb)->tx.delivered_mstamp	= tp->delivered_mstamp;
+	TCP_SKB_CB(skb)->tx.delivered		= tp->delivered;
+	TCP_SKB_CB(skb)->tx.delivered_ce	= tp->delivered_ce;
+	TCP_SKB_CB(skb)->tx.is_app_limited	= tp->app_limited ? 1 : 0;
+}
+
 INDIRECT_CALLABLE_DECLARE(int ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl));
 INDIRECT_CALLABLE_DECLARE(int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl));
 INDIRECT_CALLABLE_DECLARE(void tcp_v4_send_check(struct sock *sk, struct sk_buff *skb));
diff --git a/net/ipv4/tcp_rate.c b/net/ipv4/tcp_rate.c
index a8f6d9d06f2eb1893c65dec678edb92211fee52f..98eb346f986ef24969f804c3b55acbf60d2ec299 100644
--- a/net/ipv4/tcp_rate.c
+++ b/net/ipv4/tcp_rate.c
@@ -34,41 +34,6 @@
  * ready to send in the write queue.
  */
 
-/* Snapshot the current delivery information in the skb, to generate
- * a rate sample later when the skb is (s)acked in tcp_rate_skb_delivered().
- */
-void tcp_rate_skb_sent(struct sock *sk, struct sk_buff *skb)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	 /* In general we need to start delivery rate samples from the
-	  * time we received the most recent ACK, to ensure we include
-	  * the full time the network needs to deliver all in-flight
-	  * packets. If there are no packets in flight yet, then we
-	  * know that any ACKs after now indicate that the network was
-	  * able to deliver those packets completely in the sampling
-	  * interval between now and the next ACK.
-	  *
-	  * Note that we use packets_out instead of tcp_packets_in_flight(tp)
-	  * because the latter is a guess based on RTO and loss-marking
-	  * heuristics. We don't want spurious RTOs or loss markings to cause
-	  * a spuriously small time interval, causing a spuriously high
-	  * bandwidth estimate.
-	  */
-	if (!tp->packets_out) {
-		u64 tstamp_us = tcp_skb_timestamp_us(skb);
-
-		tp->first_tx_mstamp  = tstamp_us;
-		tp->delivered_mstamp = tstamp_us;
-	}
-
-	TCP_SKB_CB(skb)->tx.first_tx_mstamp	= tp->first_tx_mstamp;
-	TCP_SKB_CB(skb)->tx.delivered_mstamp	= tp->delivered_mstamp;
-	TCP_SKB_CB(skb)->tx.delivered		= tp->delivered;
-	TCP_SKB_CB(skb)->tx.delivered_ce	= tp->delivered_ce;
-	TCP_SKB_CB(skb)->tx.is_app_limited	= tp->app_limited ? 1 : 0;
-}
-
 /* When an skb is sacked or acked, we fill in the rate sample with the (prior)
  * delivery information when the skb was last transmitted.
  *
-- 
2.52.0.457.g6b5491de43-goog


