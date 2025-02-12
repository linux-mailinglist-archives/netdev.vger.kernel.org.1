Return-Path: <netdev+bounces-165522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB08A326E7
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341BD3A6B98
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B2620E339;
	Wed, 12 Feb 2025 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upKg3SXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0843220E03B
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366665; cv=none; b=CkJr+aTR7Hx+HFGPAuq83OX5MDEZm6ZA7qt76N0QLy4ubCg1+m1Ysr6NmD9jOrZvDKBcKumVGAOj8QocDGsLO5VZuoFuDud7hYdPnIx4ldr1vYHAaacz3fBWNydtXueT+Ezv20rJLMQoW9gUYNGTWcnVGuCR3GSDEvDKFfoAgfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366665; c=relaxed/simple;
	bh=ayfR++ZeFX/AUSDvHtw2VYyUWBaMOEdjxs/NlJb58PI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMqOdRQQMxRI58fjuHa+j48+WGsLeJTxyN7zNPul4lrUNzbeaQBlpnPJJvEc9i08QTjN3HQeYRTLBSvAC3HR78WnsM3orhIIZKuJJfXokHVNlVRSmUzJ9rPhp3bLfwLXItTch3das/EqxnHY8VVI7X7kWVb9UWIVP+2kXuw0/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=upKg3SXI; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-471939c23b6so86100151cf.2
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739366663; x=1739971463; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OB0pFMHBGPIqfhxLFFeOsSG9n4Qav98e6VUkoeWr3EY=;
        b=upKg3SXIJpF2gEghjy2MKLQnvPg8fvKz3uBLcWFohcaqxtewhz4tlU3GKhYq0kdBX+
         qB1W3A7Ewj39qKApq+mReDA907EFlDnx+jcUHVGihViK6k58QB1sAzYCfyC2bPNJ0sjc
         sb/FdW2fzJSQ+8170X1A5Xx6+pS7D/CR4TYf0OBAluiiZoIfw9ziHtAxtfQWqoNWnGFO
         0MBxcPRoH+bhZg4VjGgsAPomvoczLN9plasuETJg8YUgwZnsC9BoTYctLnZEU8HWkkIc
         8/i1gYP9h1FR4xLiWp+LgsaVJyI1L6h9bPL+oNZcUC1GNxq8Bi9PQy82d3Q8NzaZpQc7
         tppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739366663; x=1739971463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OB0pFMHBGPIqfhxLFFeOsSG9n4Qav98e6VUkoeWr3EY=;
        b=qoEz1KJTREIBVtfFtFG0Md0sIzBMF92Tzr9t/p0Ghaj8t+RNoHl+MwJKf3oetO3vf2
         YPu4LsJdGBn8AfrqhEwGiTAyituZ6YHC8QrE9h5uSgPUYicmetZUEcNZoOSCXNVQanVc
         QUHtWvwFCwRBzdoyN4qBGJ734z7AjYwbGs4Sk2OMJPlxkGmQODfeHG803fzmqqkJ/BMu
         ilBtorb9GwO30xXYesC7OHFCyLV0SUoZ26QGL+d7HYkXczQqDiLh5qOv+RqderuW2uFE
         nYylbTqYttmczf0H2xwG3wVuAEU2Cy4rAx7qUhoNS4sgvmkWxMRg9mNf6qRLkBeYVnB8
         e6cA==
X-Gm-Message-State: AOJu0Yxzsdzqt2TuuXQaHJDYhOUaro8YWYeeBlwcCCGhDayoUk/DZzB2
	EbDC+dt3Ggxex17A0jQOFpqonk+dsuTmb5h5yQp3iqWPJKwYAHfuPZtrJBJRwzzi+kpIt4sITD3
	Ajf8AXGp4Aw==
X-Google-Smtp-Source: AGHT+IEK8IXO/XfK6NWRDzjiigiIo8nmXnMH+TTAYf2hXxwH8AUVwmrTupxXif3waz/8l8rWdXdZ20T43uuIHQ==
X-Received: from qtbbq23.prod.google.com ([2002:a05:622a:1c17:b0:471:a4e2:f6f2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:138d:b0:471:9174:53b6 with SMTP id d75a77b69052e-471afe00af1mr45761451cf.11.1739366662900;
 Wed, 12 Feb 2025 05:24:22 -0800 (PST)
Date: Wed, 12 Feb 2025 13:24:16 +0000
In-Reply-To: <20250212132418.1524422-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212132418.1524422-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212132418.1524422-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] inetpeer: use EXPORT_IPV6_MOD[_GPL]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use EXPORT_IPV6_MOD[_GPL]() for symbols that do not need to
to be exported unless CONFIG_IPV6=m

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inetpeer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index b8b23a77ceb4f0f1a3d3adaacea2a7c59a7da3c9..7b1e0a2d6906673316ec4bef777e359ac175dbf8 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -60,7 +60,7 @@ void inet_peer_base_init(struct inet_peer_base *bp)
 	seqlock_init(&bp->lock);
 	bp->total = 0;
 }
-EXPORT_SYMBOL_GPL(inet_peer_base_init);
+EXPORT_IPV6_MOD_GPL(inet_peer_base_init);
 
 #define PEER_MAX_GC 32
 
@@ -218,7 +218,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 
 	return p;
 }
-EXPORT_SYMBOL_GPL(inet_getpeer);
+EXPORT_IPV6_MOD_GPL(inet_getpeer);
 
 void inet_putpeer(struct inet_peer *p)
 {
@@ -269,7 +269,7 @@ bool inet_peer_xrlim_allow(struct inet_peer *peer, int timeout)
 		WRITE_ONCE(peer->rate_tokens, token);
 	return rc;
 }
-EXPORT_SYMBOL(inet_peer_xrlim_allow);
+EXPORT_IPV6_MOD(inet_peer_xrlim_allow);
 
 void inetpeer_invalidate_tree(struct inet_peer_base *base)
 {
@@ -286,4 +286,4 @@ void inetpeer_invalidate_tree(struct inet_peer_base *base)
 
 	base->total = 0;
 }
-EXPORT_SYMBOL(inetpeer_invalidate_tree);
+EXPORT_IPV6_MOD(inetpeer_invalidate_tree);
-- 
2.48.1.502.g6dc24dfdaf-goog


