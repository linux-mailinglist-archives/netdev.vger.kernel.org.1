Return-Path: <netdev+bounces-217262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6198B381E7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFB617A6D6
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 12:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669573002B1;
	Wed, 27 Aug 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gN1vGf4q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965B2FF653
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296315; cv=none; b=tCvCmCRpSHTc5UdXrjQ5mwhaWf1li6oGGMmguCC2ich7035IcFCnAFpK/J0LHY7nLQpxLtb+KsUkv4STnoFEt5aFKaM77KMzy8rhRNNgtdjglpeIbb+cywHd7BpAhwYl7yhx4LoxYaaBUr3GOu6pyoxFnfb4UoHEopapXBc1uec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296315; c=relaxed/simple;
	bh=yS19MriUbMm5uiDvFqME6L4De86kZDM0oJMPP2c2tF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GBmcwh3hnxlJ030bpxrV+mQ7h1Tl9c+bU+FBXSkATvJuHgnzxzuwP3lJuBk4FtBKCddMyjbCepfWLcDYlxpglDHK5yDAzriuQd3UTFpHsxdsTh59Ri7u0PX04k930TrvO1cttYUo0YT5NU1H0yH6Ur70Bf5s5UU240t4Zvc7BC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gN1vGf4q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7200579b490so48685507b3.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756296312; x=1756901112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QA+48X6dQP0kirBcGxeKEZDW5ev8MdncIODnnPuBIUQ=;
        b=gN1vGf4qBOJeZ8YTICsYyVG9uKRhUJGCo4o1KB2v+klxcNkugFEnyh3wqSHG7lF/zN
         iPzKdQVEL0iKTTGBxCP7IUrH0RQwrfuOh9qAI0jhMMRBd6tmeWtm8HGdhewIIdc4RD4R
         a53fMwSmvyCM6/ftxTOEe7GhlkaBoH5fw5jZ4Pvs+r4fflBd8HEXwjTauPVu8JoPBKAX
         e7L4DrG2S20bn5yoYVaIGVeqsn10mN9sbCK8nBeUUxmbU8gqeoFvK9eu50wnsUbvMkzU
         KC/XMMLnKEr4AM2ZCSbOY2XE03pgTTWRqm205pttZ/3qaydtRNSBYnqMEMfalRUwEfKX
         rynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756296312; x=1756901112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QA+48X6dQP0kirBcGxeKEZDW5ev8MdncIODnnPuBIUQ=;
        b=mq/V5mm47070IaNBnntte7+zlhDedNO27+SiKbheSiTJBwmPt/hR7N0z6beiTxzvsk
         Ms0BvTEmpng6iB/jUjSR1Y5bjbn42I1S1zH1pDWHKaJD+ff1uSMBBJBcHGp0DIMbxNRq
         W2JsNAZ8JU4WotRLEi/gjm33BBVe7SoAJrSfDLMMN33wHLaQeup6blqTKTHcJgg6Cfhc
         Z4PpYLMabZNUdX1J5d9u26knhnqNCxaHWy3XLdHFX9rCfbE6jZKnWW5WpnqcnDDj8adK
         5hQUuFuGImmGwkt+0pLysfpJEqwm10joL2UtIgd5q9NkVOIuIoQKy0q95JpAQeZpuYRy
         bgAg==
X-Forwarded-Encrypted: i=1; AJvYcCUh9EtXjruQnspb3OG0kympWFFeFXxmI7vQz7LI+OafCxfGQ/XfYlvEFdm09/sttF+s8Mojo38=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+OF4w6+Gi/3iFhvwB97WzOEc9uBOf1GulWzFfEwhvutn6ZLc
	Z4QNj4betbl4X+Xs/9VfIzE+Z4DQOz60+dH1BZu0J0tqVg8SGOQdM3lBFxjZIJmhdhuXLkUmavs
	LDSraOmFmUpU12Q==
X-Google-Smtp-Source: AGHT+IFuoSBLOx7wReZYzWVPV9Pv7R/8vEyJ7LTDe0KD4rq/hCRRTSdt9b4FVpzra66ADjQ6MGas6lt9rUT5Dw==
X-Received: from ywbfk8.prod.google.com ([2002:a05:690c:3348:b0:721:1644:1e1b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:906:b0:71f:b944:1004 with SMTP id 00721157ae682-71fdc42513dmr182660137b3.43.1756296311714;
 Wed, 27 Aug 2025 05:05:11 -0700 (PDT)
Date: Wed, 27 Aug 2025 12:05:02 +0000
In-Reply-To: <20250827120503.3299990-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827120503.3299990-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250827120503.3299990-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] inet: ping: remove ping_hash()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is no point in keeping ping_hash().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ping.c | 10 ----------
 net/ipv6/ping.c |  1 -
 2 files changed, 11 deletions(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 3734e2d5c4814ea0a8d318c54e38b4dc978f6c77..efceb2e17887f32d89c85161ccd818b12e38ff20 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -67,7 +67,6 @@ static inline u32 ping_hashfn(const struct net *net, u32 num, u32 mask)
 	pr_debug("hash(%u) = %u\n", num, res);
 	return res;
 }
-EXPORT_SYMBOL_GPL(ping_hash);
 
 static inline struct hlist_head *ping_hashslot(struct ping_table *table,
 					       struct net *net, unsigned int num)
@@ -144,14 +143,6 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 }
 EXPORT_SYMBOL_GPL(ping_get_port);
 
-int ping_hash(struct sock *sk)
-{
-	pr_debug("ping_hash(sk->port=%u)\n", inet_sk(sk)->inet_num);
-	BUG(); /* "Please do not press this button again." */
-
-	return 0;
-}
-
 void ping_unhash(struct sock *sk)
 {
 	struct inet_sock *isk = inet_sk(sk);
@@ -1006,7 +997,6 @@ struct proto ping_prot = {
 	.bind =		ping_bind,
 	.backlog_rcv =	ping_queue_rcv_skb,
 	.release_cb =	ip4_datagram_release_cb,
-	.hash =		ping_hash,
 	.unhash =	ping_unhash,
 	.get_port =	ping_get_port,
 	.put_port =	ping_unhash,
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index 82b0492923d458213ac7a6f9316158af2191e30f..d7a2cdaa26312b44f1fe502d3d40f3e27f961fa8 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -208,7 +208,6 @@ struct proto pingv6_prot = {
 	.recvmsg =	ping_recvmsg,
 	.bind =		ping_bind,
 	.backlog_rcv =	ping_queue_rcv_skb,
-	.hash =		ping_hash,
 	.unhash =	ping_unhash,
 	.get_port =	ping_get_port,
 	.put_port =	ping_unhash,
-- 
2.51.0.261.g7ce5a0a67e-goog


