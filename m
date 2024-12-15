Return-Path: <netdev+bounces-152008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582229F2529
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898BE1886219
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B81B4124;
	Sun, 15 Dec 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9vXtcNV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81271B21B2
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734285424; cv=none; b=E15fxEKROSRr4N4YpRxrz1Ar1VzjSoYh1ivQVbRWrXu6MXSEorXl6vo9ubUPodprnbf4Ernce47blAer4kbpCZ+iXlO/+Ytq7BDuEyUbo+TMhG7NTTnZfyg69oxVEFLUU9Gjs3nXAcAVpYQJje+cF6WlJfSuet4q6nDIqNoP9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734285424; c=relaxed/simple;
	bh=pmqBsVm+O9GOOzNqGM5gtbpQ4PVSkgWEKTdLjwIHpKM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fM3J3MbRFnlhwu1PQqcr41ll0bwO0OOW157a8ro1NGvLaD6SB+kffnt6pLHkdAFLrVmM2plwj0M2e4FvMikmZ2G/bJgWTpji23oACUL1pcXZDiKfuajQ0IDTGSSaDKtS4l1uneUx3lSgl6gbr3kqAagD6e2OtAX9MvLNxbG2mwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9vXtcNV; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d8f6903d2eso64736356d6.2
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 09:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734285422; x=1734890222; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UxJLlGxqCWp+SEOeXAQR+oASm+S2l6LuvafwIt/Iv1o=;
        b=M9vXtcNVP74cD9phR5jWZFiUKkdq3Z9urCMGJYAJtzNUtIVV5Ckn+NrWJj+5IlQa7d
         OGYGE4M5TzWvCa8dJkkkA+tzh0LpQ4c5u40SeUQrNfJ8B3spxLEgdwPW/FTM+5zjCWOB
         7UYnL3EpWVR7zPMDfE2AuRVyI+XQfxUhmp31IbHlY34/vGE5/yN5cUJuiooP1+FYPiHI
         eH5S81nP1YKIJn3DLzdpBH3UC8jj/j4ICNF7rBivMiPzg0fq8a/eVxjRH2r/MrHj7kzu
         R0PxJYLmldF5GgI5PF9Jwr3NA26UrXq443CijFY39htyLlDmlIXRW4DBf+JpAxru0qt0
         36cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734285422; x=1734890222;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxJLlGxqCWp+SEOeXAQR+oASm+S2l6LuvafwIt/Iv1o=;
        b=AD4eS3myd4R9QUHkPnd0IS6Tn0g+IJd+toOZijEkByuSdpIPxzV2w8/wkjs15J3N0M
         bpn4NBkJJlvyck1JPlIBqa6jvOlNZk6oMiahm67xTQ2J9bA+oDenatObrvN//3RDVOpX
         WeNm4c0KpLS3N5WfV0Gx/ifPYxZ3CfjLywJ+kaMuaR8/5IncbHiBKOjB5mdWFYpaDgUB
         dBRnvG1TYDQ+UkNjvBmIMlUVzYPdc+gUJo2n2QGp/3D4UOwlGBChbB0/fnoXrBybKrf9
         l1GbepsQ0t+WgUEH+nGS1tG6yWxZ4XQZMPlkH1i4Gra1eZAZLLR06NuykRqQEZaMoisK
         qZww==
X-Gm-Message-State: AOJu0YzI6DYZvANDJWpVskSq+ODwBaF+Ivt3Vb2eCccJGCXn6TdbkGpB
	w5AsuQrncqiR5WHZr9IvoCdCtHN4QvMIDP9u+Pts+ZevsqYHN7V8Ig9uER5g5nY1lUM7ytzKVlC
	Si5twMwVMmA==
X-Google-Smtp-Source: AGHT+IHHs+SXnVWThAcArGS3fGtqtgB/nfKuMly2cpvUOhCG7IIj3q1nRjl3pYyztcF+I8ZPiddmxuliMoHAgw==
X-Received: from qvbdl8.prod.google.com ([2002:ad4:4e08:0:b0:6d8:7cd6:a134])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5086:b0:6d3:f1ff:f8d6 with SMTP id 6a1803df08f44-6dc96848901mr165230346d6.40.1734285421842;
 Sun, 15 Dec 2024 09:57:01 -0800 (PST)
Date: Sun, 15 Dec 2024 17:56:27 +0000
In-Reply-To: <20241215175629.1248773-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241215175629.1248773-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241215175629.1248773-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] inetpeer: remove create argument of inet_getpeer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

All callers of inet_getpeer() want to create an inetpeer.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inetpeer.h |  7 +++----
 net/ipv4/inetpeer.c    | 11 ++---------
 2 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/include/net/inetpeer.h b/include/net/inetpeer.h
index 6f51f81d6cb19c623e9b347dbdbbd8d849848f6e..f475757daafba998a10c815d0178c98d2bf1ae43 100644
--- a/include/net/inetpeer.h
+++ b/include/net/inetpeer.h
@@ -96,8 +96,7 @@ static inline struct in6_addr *inetpeer_get_addr_v6(struct inetpeer_addr *iaddr)
 
 /* can be called with or without local BH being disabled */
 struct inet_peer *inet_getpeer(struct inet_peer_base *base,
-			       const struct inetpeer_addr *daddr,
-			       int create);
+			       const struct inetpeer_addr *daddr);
 
 static inline struct inet_peer *inet_getpeer_v4(struct inet_peer_base *base,
 						__be32 v4daddr,
@@ -108,7 +107,7 @@ static inline struct inet_peer *inet_getpeer_v4(struct inet_peer_base *base,
 	daddr.a4.addr = v4daddr;
 	daddr.a4.vif = vif;
 	daddr.family = AF_INET;
-	return inet_getpeer(base, &daddr, 1);
+	return inet_getpeer(base, &daddr);
 }
 
 static inline struct inet_peer *inet_getpeer_v6(struct inet_peer_base *base,
@@ -118,7 +117,7 @@ static inline struct inet_peer *inet_getpeer_v6(struct inet_peer_base *base,
 
 	daddr.a6 = *v6daddr;
 	daddr.family = AF_INET6;
-	return inet_getpeer(base, &daddr, 1);
+	return inet_getpeer(base, &daddr);
 }
 
 static inline int inetpeer_addr_cmp(const struct inetpeer_addr *a,
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 5ab56f4cb529769d4edb07261c08d61ff96f0c0f..bc79cc9d13ebb4691660f51babbc748900b8f6db 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -169,13 +169,11 @@ static void inet_peer_gc(struct inet_peer_base *base,
 }
 
 struct inet_peer *inet_getpeer(struct inet_peer_base *base,
-			       const struct inetpeer_addr *daddr,
-			       int create)
+			       const struct inetpeer_addr *daddr)
 {
 	struct inet_peer *p, *gc_stack[PEER_MAX_GC];
 	struct rb_node **pp, *parent;
 	unsigned int gc_cnt, seq;
-	int invalidated;
 
 	/* Attempt a lockless lookup first.
 	 * Because of a concurrent writer, we might not find an existing entry.
@@ -183,16 +181,11 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	rcu_read_lock();
 	seq = read_seqbegin(&base->lock);
 	p = lookup(daddr, base, seq, NULL, &gc_cnt, &parent, &pp);
-	invalidated = read_seqretry(&base->lock, seq);
 	rcu_read_unlock();
 
 	if (p)
 		return p;
 
-	/* If no writer did a change during our lookup, we can return early. */
-	if (!create && !invalidated)
-		return NULL;
-
 	/* retry an exact lookup, taking the lock before.
 	 * At least, nodes should be hot in our cache.
 	 */
@@ -201,7 +194,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 
 	gc_cnt = 0;
 	p = lookup(daddr, base, seq, gc_stack, &gc_cnt, &parent, &pp);
-	if (!p && create) {
+	if (!p) {
 		p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
 		if (p) {
 			p->daddr = *daddr;
-- 
2.47.1.613.gc27f4b7a9f-goog


