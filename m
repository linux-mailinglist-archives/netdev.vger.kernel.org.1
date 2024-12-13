Return-Path: <netdev+bounces-151764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0946D9F0CDF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5F8816656A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7C31E00A0;
	Fri, 13 Dec 2024 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E/4sZRFl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C583A1DFE39
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094941; cv=none; b=Pk93uZ7ccxj1+PCqscd6b2LA9i0wniDJ2yd/e55Kc3AIctd5BNzfAXB9X5+Dph2aFIJMmbGEw128pDu4RTL9Na/pIfTlU99LJ52loptAoW9defDTBzkvn6gyMA4sngpqYm9l+Yk9wPgS5QCbxXMP91fnncOfVQFb9jsmq49GPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094941; c=relaxed/simple;
	bh=mWG7wsebwSYYcIqh15+S7wil7C3IoKbNrM+dfseE5nA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=liBZcc747EBErwNXCx0IwDUDy1cNjRkLnhcZIqsigjvqZ3exsYMhblLOlPsiKyPKBzFk4xuNo5hQC77vNLxcFabKbq+J8SamosqyoZpCVsiA7CWX5mDIlzZjuQhJ8QTEG18sJMvnvinVOJuL4s0BtaE7T7CANjWshy+lvYidYJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E/4sZRFl; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467944446a0so31151441cf.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 05:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734094939; x=1734699739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3ZcHiGrMQ0qikxpAt1j1kpn8wlaFfz3JKlP8c3UDe8=;
        b=E/4sZRFlLVJBoqZfl8F2220dqNB5vnv1bF6XBS5rx/kQ/4iptR5/lKlpHY8SAkeyUC
         LDEq7n6yA+NsuMdQaMuazZvMxRc1hpVkT4258PBJSFmvDeb+U7emW8crTZdAcZHjcLRB
         BGkVS/n9MrZiXfVMhuIt0IH3CS9y3Q4dTCmEEZTFsaXicGbem+bZgaW7zm+JSnXmMF5a
         cImgXxPGDMe0kGbaNwefSx/jSSKSnxHdwnMmeUqSI7plE/4CWKcyzIHUM6KYHE/ZfnPd
         gfeLYe/V+6bybrw/BVn4G+Jxhz8fHyCjhv9BzzC9hUjrV7VeJkhMPwGkfUGRRK9C9B6I
         VGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094939; x=1734699739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3ZcHiGrMQ0qikxpAt1j1kpn8wlaFfz3JKlP8c3UDe8=;
        b=Qgx+b8OLlqhdOflQF0elv7PU2JTiGr15DBNioT2UDGbZ0bEgqfTUbuKmrhkHES6mV9
         DiG1l54e/PfWrfVHIoTg8emuX7R0EzeWqBg21/gJF5I0H6w2NCctVn0XtmW+35sSoEZt
         Lm0ZdAHmv3Ju9fLX3I+O4Dvbg4dzB/8z1ueWUa7bDmumoQkE5bmnv7ez/Ocahm/gLL9k
         OQBk9E919q5cpC6wBmbkqfd0I/Tkpy/j0ZaYFpfSuQoDUF4KvrqTpZO+6As6dgLDguGV
         0KnS4P67/jyobLMNR/Z7BsScuc+ykQYtyanAM3FajfWJADbUnd8ZtCVTGZVXaSjgbKkd
         VRgQ==
X-Gm-Message-State: AOJu0YxyKuP5R1EgBHqmwmBgcNZA+6k18j7r7Aemqsl3H3ALaD7QpdNO
	GxfYPYK6miIhPi8sS4prztnte301RJTHxaj6OxokHTUFBdiXSdWS31KTc84NtMRzb9QggBtPo8o
	OolCag8laYQ==
X-Google-Smtp-Source: AGHT+IF5Ft0ySfZj0pWAtikyzIfYWmMCmSd5cixmCjDz8fyO7mWujWDBMtX8HQQpdg38gwlbwsm/BaOdOeWzHg==
X-Received: from qtbbs15.prod.google.com ([2002:ac8:6f0f:0:b0:467:6227:451b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:13d2:b0:467:84a7:5147 with SMTP id d75a77b69052e-467a5807dfdmr63435711cf.39.1734094938610;
 Fri, 13 Dec 2024 05:02:18 -0800 (PST)
Date: Fri, 13 Dec 2024 13:02:10 +0000
In-Reply-To: <20241213130212.1783302-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213130212.1783302-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213130212.1783302-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] inetpeer: remove create argument of inet_getpeer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

All callers of inet_getpeer() want to create an inetpeer.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inetpeer.h | 7 +++----
 net/ipv4/inetpeer.c    | 9 ++-------
 2 files changed, 5 insertions(+), 11 deletions(-)

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
index 5ab56f4cb529769d4edb07261c08d61ff96f0c0f..58d2805b046d00cd509e2d2343abfb8eacfbdde7 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -169,8 +169,7 @@ static void inet_peer_gc(struct inet_peer_base *base,
 }
 
 struct inet_peer *inet_getpeer(struct inet_peer_base *base,
-			       const struct inetpeer_addr *daddr,
-			       int create)
+			       const struct inetpeer_addr *daddr)
 {
 	struct inet_peer *p, *gc_stack[PEER_MAX_GC];
 	struct rb_node **pp, *parent;
@@ -189,10 +188,6 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	if (p)
 		return p;
 
-	/* If no writer did a change during our lookup, we can return early. */
-	if (!create && !invalidated)
-		return NULL;
-
 	/* retry an exact lookup, taking the lock before.
 	 * At least, nodes should be hot in our cache.
 	 */
@@ -201,7 +196,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 
 	gc_cnt = 0;
 	p = lookup(daddr, base, seq, gc_stack, &gc_cnt, &parent, &pp);
-	if (!p && create) {
+	if (!p) {
 		p = kmem_cache_alloc(peer_cachep, GFP_ATOMIC);
 		if (p) {
 			p->daddr = *daddr;
-- 
2.47.1.613.gc27f4b7a9f-goog


