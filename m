Return-Path: <netdev+bounces-206125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA21AB01ADA
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9962542C17
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B32D77EF;
	Fri, 11 Jul 2025 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t90P+LhL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96212D63ED
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234013; cv=none; b=k53OG0+JAI3/uO1HkaggwMMWcHL8f2CtswDirmBWEzoOZMI6R6YG4r3KlWz+SEFtre5JB18g2VNKhYOAUNaCMO/UpZb2/Zl+Jk2afmSwnQ5EW5D/KVafo5bpqqEv5ieM1KE9hd2rxyKTph9klE3MzDjLFrb1ZDu6Jmxx1KlY3NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234013; c=relaxed/simple;
	bh=0pN8wFiGXVX1lbGwV4dwU9MIBmibC8cqZ05E+lsrgTM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o7Lu0s1QKg7nlQcZ1QmC4Pe2BEds2BoKDdOFABvreUUIL0C0VzYCK850gYSOU97i40VdYfsOIxpzEgXCHsHH5bPqQIwKOb08hqSlSEOcvg64BGqwHKwIeFbbX93VePbuAeIuIRwKf7eG4AxwBaHTDOSgyAnXQgvZn1wXqh/8c0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t90P+LhL; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4a441a769c7so35220671cf.3
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752234011; x=1752838811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7bpJvh+CBiIzEU5RZxSiJIbkUGS1/VJXbQrUuE17Rw=;
        b=t90P+LhLfkWrny5Eqv9ZDoRhvyxfYQXEjUvfzYhdPh/xKL80AMdcRoo/CLrDTps8D7
         RqrnvF4fh8bqSIsMVLodUmK/3cegmG1K/JuBNut+tKJfEGYsXRnxYiCZxFsgmIVNaJ9n
         +dlSIMP+zFvOMHwut+TsTy/WqNr7OJ1IE6XKBmgAu1zVycOfP8/PXiHnwgntaudYAfWn
         n0Phq4wEvw1BfhibIRjZr+hdkrW8SYae3rDrPRBUs9nMID2pyv7WRyUDMrbYUwwmioov
         0QsdPFQspj1bn1cEtrXy70sk9X5fcCBmqcra3N/4oSP+PRI0SM4B/u7FM0YGKRGeI3qn
         y2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234011; x=1752838811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7bpJvh+CBiIzEU5RZxSiJIbkUGS1/VJXbQrUuE17Rw=;
        b=pHT7jYrfBxpJFw15i4771Oyj5/A/y5sgP7sjhBlIdso2FrHdzXbO71licvyLI3tJS/
         Iw80GDEoqKl/ljvDXv+Zdpyt1pl1i3VLThXZWLI60jE466DXD9XmH6e+trw9YU+aodid
         Fejuu9k3lXdd+jzp/AFxaWNzsmf2O1EpIumokCBu0LrqvaLiwW7vH3n3INOuATObo6fn
         mOdR2tnBk4TmSeBeMZaeMaTVTAzYfj6L+17IdHpzSlSDNI32yFfNRm75SlgGcSLolwTn
         /HNz//MTFc9Kwh9rbKsNYEj3NagtkSqsidihyfOB2tmXjctLZHxFJYaobA10x+BldoPe
         OnEg==
X-Forwarded-Encrypted: i=1; AJvYcCWeLF42mGZCA0Dmhmi3YCtrJAuVM6kX7RKcMOokvu7QQgdwSWYhyQHgarsjkVMU5ry4qvP7wTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YykRJqy43TTQR9d0gdypMfKV5FuzlVGbywm+lWX1hGVTOXgHkDO
	JLEEW/SkKtJwkFnXKUdDZrIOTxgB2L5q4sStAhXK24UMQOkdgXDwYr0uu4ArtWK012F1E40HWBf
	S9ZvS/jA5dxomwQ==
X-Google-Smtp-Source: AGHT+IGFLOQoFwKpUe5gjSWQXclzZG2EFPDFda7LFRAW4s5WWAPFJhUXbwrp6KIWfWMwokna0Fy5sNPuZGTdGQ==
X-Received: from qtbfj16.prod.google.com ([2002:a05:622a:5510:b0:4a3:db07:acc8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5913:0:b0:494:ad27:72ae with SMTP id d75a77b69052e-4a9fb97b942mr42085911cf.48.1752234010868;
 Fri, 11 Jul 2025 04:40:10 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:39:59 +0000
In-Reply-To: <20250711114006.480026-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711114006.480026-2-edumazet@google.com>
Subject: [PATCH net-next 1/8] tcp: do not accept packets beyond window
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, TCP accepts incoming packets which might go beyond the
offered RWIN.

Add to tcp_sequence() the validation of packet end sequence.

Add the corresponding check in the fast path.

We relax this new constraint if the receive queue is empty,
to not freeze flows from buggy peers.

Add a new drop reason : SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/dropreason-core.h |  7 ++++++-
 net/ipv4/tcp_input.c          | 22 +++++++++++++++++-----
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index b9e78290269e6e7d9d9155171f6b0ef03c7697c9..d88ff9a75d15fe60a961332a7eb4be94c5c7c3ec 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -45,6 +45,7 @@
 	FN(TCP_LISTEN_OVERFLOW)		\
 	FN(TCP_OLD_SEQUENCE)		\
 	FN(TCP_INVALID_SEQUENCE)	\
+	FN(TCP_INVALID_END_SEQUENCE)	\
 	FN(TCP_INVALID_ACK_SEQUENCE)	\
 	FN(TCP_RESET)			\
 	FN(TCP_INVALID_SYN)		\
@@ -303,8 +304,12 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TCP_LISTEN_OVERFLOW,
 	/** @SKB_DROP_REASON_TCP_OLD_SEQUENCE: Old SEQ field (duplicate packet) */
 	SKB_DROP_REASON_TCP_OLD_SEQUENCE,
-	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field */
+	/** @SKB_DROP_REASON_TCP_INVALID_SEQUENCE: Not acceptable SEQ field.
+	 */
 	SKB_DROP_REASON_TCP_INVALID_SEQUENCE,
+	/** @SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE: Not acceptable END_SEQ field.
+	 */
+	SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE,
 	/**
 	 * @SKB_DROP_REASON_TCP_INVALID_ACK_SEQUENCE: Not acceptable ACK SEQ
 	 * field because ack sequence is not in the window between snd_una
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9b03c44c12b862b5d33f4390cfc85e2f8897cd8e..f0f9c78654b449cb2a122e8c53fdcc96e5317de7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4391,14 +4391,22 @@ static enum skb_drop_reason tcp_disordered_ack_check(const struct sock *sk,
  * (borrowed from freebsd)
  */
 
-static enum skb_drop_reason tcp_sequence(const struct tcp_sock *tp,
+static enum skb_drop_reason tcp_sequence(const struct sock *sk,
 					 u32 seq, u32 end_seq)
 {
+	const struct tcp_sock *tp = tcp_sk(sk);
+
 	if (before(end_seq, tp->rcv_wup))
 		return SKB_DROP_REASON_TCP_OLD_SEQUENCE;
 
-	if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
-		return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
+	if (after(end_seq, tp->rcv_nxt + tcp_receive_window(tp))) {
+		if (after(seq, tp->rcv_nxt + tcp_receive_window(tp)))
+			return SKB_DROP_REASON_TCP_INVALID_SEQUENCE;
+
+		/* Only accept this packet if receive queue is empty. */
+		if (skb_queue_len(&sk->sk_receive_queue))
+			return SKB_DROP_REASON_TCP_INVALID_END_SEQUENCE;
+	}
 
 	return SKB_NOT_DROPPED_YET;
 }
@@ -5881,7 +5889,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 
 step1:
 	/* Step 1: check sequence number */
-	reason = tcp_sequence(tp, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq);
+	reason = tcp_sequence(sk, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq);
 	if (reason) {
 		/* RFC793, page 37: "In all states except SYN-SENT, all reset
 		 * (RST) segments are validated by checking their SEQ-fields."
@@ -6110,6 +6118,10 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			if (tcp_checksum_complete(skb))
 				goto csum_error;
 
+			if (after(TCP_SKB_CB(skb)->end_seq,
+				  tp->rcv_nxt + tcp_receive_window(tp)))
+				goto validate;
+
 			if ((int)skb->truesize > sk->sk_forward_alloc)
 				goto step5;
 
@@ -6165,7 +6177,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 	/*
 	 *	Standard slow path.
 	 */
-
+validate:
 	if (!tcp_validate_incoming(sk, skb, th, 1))
 		return;
 
-- 
2.50.0.727.gbf7dc18ff4-goog


