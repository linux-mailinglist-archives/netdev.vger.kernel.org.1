Return-Path: <netdev+bounces-206131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A040B01AE1
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 13:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7569B76695A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFDB2DE71A;
	Fri, 11 Jul 2025 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4I00mLqN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A13291C0E
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234022; cv=none; b=HQVBjWHfrlmFU1rXCaorqXkvxF88+yZFj/0bfSmF+JgJT5f59vKwmFq8NA4Gqs44FS+aS9Buzoym+Gh/IeFQerRlolH+rXaqMH53eSZgDNj336DaK0IkaaW+ApKbOCSXRFTN5d/sCG2bbANdD103D+NWzU4L62FEBaBBCAHIz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234022; c=relaxed/simple;
	bh=7frq5e9GrCsfiMUMxHu05lsWkmze+bd9zXucpjxmXRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GC/oZ395MEbKaY4gRrkkpbC/nxpvh3hBMeAPdxP1ZnGsSHFwnS/2yZDM600JLc/euwyMTyYWuP6/JUEycEnhhmyM05W3bs+jTzv/MOE8CcJAhvx4A8cB9adcD3XdUXZyGC7d/TX44ts4tziy55KzGYu7g4aiFS5vN/2qyOA7o+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4I00mLqN; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a9aa439248so24705201cf.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 04:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752234020; x=1752838820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LytA9GbF20o4QzTHVuBiJunht+y/eltduAZuaN7etP4=;
        b=4I00mLqNML1qgCZ9y+EM1ELBAH49uLJfMutS/Xya97QdyrNmh1CwbZr+MGwIWPjsfg
         AX+NQF7uD+W2jzjW/Cp1iA1icknQZDJ8VeG68YK0hCvvdD5FycY26X9AyljT1Gh2fmHI
         Fj0Ydm2c/lQW+RPqLAsqEic9nMkjfPxn9IrHbMYR7YgOb3n0wE4CrnmIiiOsPxf+vIPS
         TPk3/ZxK1UKUV7zxOFGm9SYSz+Crf4jIxysGUGmdL2xtnl0XzLmuTNRHET10GiIXd10M
         W8xK2/J98rhBQHN9Mcyyd/fYI5g/qClLThSFAtS2euKSkvI9hcsIHhGRs/pheYhiHWbp
         yn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234020; x=1752838820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LytA9GbF20o4QzTHVuBiJunht+y/eltduAZuaN7etP4=;
        b=D4Hc1X8FI3dcI1pYRIuwIf+7PlAcM3Tdn3ZuiiODqI06W5Sty0AP7YuoY+1NlFwuN4
         sZB4QhkP/NsGUu3tX4Ha8fhBrqX7P1cVnmgAV2LC4zy2IPJxDQwQ9N1pwdLUnPqFattA
         42bzMvKpWDbH93cJjyZ8S0IMqv16PjCT3Jh1iQWHpIxakvt+6pxhEefuZ6qV/FzQT7NM
         9P8kBOaYu6PF2/2v3wKszN8266qIKNCMOMmQufDsa3yjA96OQz0L3hSDxJEMpQN4rXs6
         WsQFIvnJGWcRC4AcL2MwVueCXDN42RJFGV/nyj6DZc5E96aYvFvi60P29tQvzCDIWuLS
         NkFg==
X-Forwarded-Encrypted: i=1; AJvYcCXbjdeHwBvuogGjNHz7um4PXsLBUJ5dIgttlC4rKjXQGUC/OD2+8TAKQfABqmQwKa5CF6147rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIWIqtn63G8Yz1g5JACR32UVYjttjVEx/KkLJ24kqSD6zJ4wzM
	ghB8cYmCzm+OmNooFvvHUvpCrQ8PPrn93DU+lc1eGQ4SzLmrifhYlheZjGod3OLnDJxIXPLyYy0
	I1bFuLzUw/8fEvg==
X-Google-Smtp-Source: AGHT+IEp4p/ml/XGJPH2umMmv84fSdDjNTRVBmQAHJ85gwUFZSrNF8gYUdm3iv2TIf1jW5TSEOEUp+Dudmlbqw==
X-Received: from qtxz14.prod.google.com ([2002:a05:622a:124e:b0:4a9:ae5f:14c1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5a19:b0:4a7:a6ba:2f01 with SMTP id d75a77b69052e-4aa35e850c9mr46576291cf.32.1752234020024;
 Fri, 11 Jul 2025 04:40:20 -0700 (PDT)
Date: Fri, 11 Jul 2025 11:40:05 +0000
In-Reply-To: <20250711114006.480026-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711114006.480026-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711114006.480026-8-edumazet@google.com>
Subject: [PATCH net-next 7/8] tcp: stronger sk_rcvbuf checks
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, TCP stack accepts incoming packet if sizes of receive queues
are below sk->sk_rcvbuf limit.

This can cause memory overshoot if the packet is big, like an 1/2 MB
BIG TCP one.

Refine the check to take into account the incoming skb truesize.

Note that we still accept the packet if the receive queue is empty,
to not completely freeze TCP flows in pathological conditions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_input.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 39de55ff898e6ec9c6e5bc9dc7b80ec9d235ca44..9c5baace4b7b24140ab5e0eafc397f124c8c64dd 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4888,10 +4888,20 @@ static void tcp_ofo_queue(struct sock *sk)
 static bool tcp_prune_ofo_queue(struct sock *sk, const struct sk_buff *in_skb);
 static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb);
 
+/* Check if this incoming skb can be added to socket receive queues
+ * while satisfying sk->sk_rcvbuf limit.
+ */
+static bool tcp_can_ingest(const struct sock *sk, const struct sk_buff *skb)
+{
+	unsigned int new_mem = atomic_read(&sk->sk_rmem_alloc) + skb->truesize;
+
+	return new_mem <= sk->sk_rcvbuf;
+}
+
 static int tcp_try_rmem_schedule(struct sock *sk, const struct sk_buff *skb,
 				 unsigned int size)
 {
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
+	if (!tcp_can_ingest(sk, skb) ||
 	    !sk_rmem_schedule(sk, skb, size)) {
 
 		if (tcp_prune_queue(sk, skb) < 0)
@@ -5507,7 +5517,7 @@ static bool tcp_prune_ofo_queue(struct sock *sk, const struct sk_buff *in_skb)
 		tcp_drop_reason(sk, skb, SKB_DROP_REASON_TCP_OFO_QUEUE_PRUNE);
 		tp->ooo_last_skb = rb_to_skb(prev);
 		if (!prev || goal <= 0) {
-			if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
+			if (tcp_can_ingest(sk, skb) &&
 			    !tcp_under_memory_pressure(sk))
 				break;
 			goal = sk->sk_rcvbuf >> 3;
@@ -5541,12 +5551,12 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 
 	NET_INC_STATS(sock_net(sk), LINUX_MIB_PRUNECALLED);
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
+	if (!tcp_can_ingest(sk, in_skb))
 		tcp_clamp_window(sk);
 	else if (tcp_under_memory_pressure(sk))
 		tcp_adjust_rcv_ssthresh(sk);
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf)
+	if (tcp_can_ingest(sk, in_skb))
 		return 0;
 
 	tcp_collapse_ofo_queue(sk);
@@ -5556,7 +5566,7 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 			     NULL,
 			     tp->copied_seq, tp->rcv_nxt);
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf)
+	if (tcp_can_ingest(sk, in_skb))
 		return 0;
 
 	/* Collapsing did not help, destructive actions follow.
@@ -5564,7 +5574,7 @@ static int tcp_prune_queue(struct sock *sk, const struct sk_buff *in_skb)
 
 	tcp_prune_ofo_queue(sk, in_skb);
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf)
+	if (tcp_can_ingest(sk, in_skb))
 		return 0;
 
 	/* If we are really being abused, tell the caller to silently
-- 
2.50.0.727.gbf7dc18ff4-goog


