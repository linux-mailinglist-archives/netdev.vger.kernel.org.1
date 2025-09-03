Return-Path: <netdev+bounces-219487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DB3B41905
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23001B28004
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 08:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD262EC540;
	Wed,  3 Sep 2025 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izeD1dQW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530092ECD3A
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889249; cv=none; b=YMcNcqNpwHdBEwSEt/Jd3qJgx6wTQnK5X+fOD0nocS9SeUY7K/rUjZSxKUZLCM8mUc1z2SRi0jm88ygwqgInkiHU1ERiRCA8gRt734+orZzI/SCHGRgDs1D8LZMzo/5ynczWPntwrwcR/ckbinbO2tL6M/zAa0yeEc91/OiiJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889249; c=relaxed/simple;
	bh=As7t0iWZVog7H+V8rkOKMCRbDFaxsEGw5tACJYmOROI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dLNtVKhIMP+PhejPEzypU/eKL4AbDAhM9ezrylIRJvxTHhAM9EwZMPVzFrW16VGtNELazW1737dFYwGrpepNcV88+xqoAk40PTowliymMGeMe3Srf57DACoHNZfAlbqBfvnd4dOqEPGljKY9d1mpebL/+2IG1vqpDhma1DaylUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izeD1dQW; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e8702f4cf9so1352779185a.0
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 01:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756889247; x=1757494047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=THLjz7foivYiCqZlrrgR5Q0Te1rh/ehKo12NMcCxHmY=;
        b=izeD1dQWhpfQ2eSIJO2hnlXOe54HxBZ0foiE/XFBJ3RMwv1lGJbRQyJ7qciLDI6uin
         aL9uDDPTLzwo5Mm8bjxizUfoV0tqdDygS7QA2PJSlQeYH2ZMbb4wz3HVgUfzLwSq4oH2
         o42h5D953WhhXTTaxg1oqDp4ZbWjA2ZG14ZVk8EvZa98X0lsXIkufqh/LGeoPkzsh3RN
         lYRtw+wydWDtDKL9f6lN006cxgU6raMNCt5N7FmitHOXZHqQ2eboO/YyFW/9CY415gIn
         3s90L5ouXMvbq5rL4Sg0W0PUy8x41k2KwaUAE42e/TwUn/QAc8wBbtYB/AwVyVey+eCi
         UAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756889247; x=1757494047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THLjz7foivYiCqZlrrgR5Q0Te1rh/ehKo12NMcCxHmY=;
        b=FIvSOZQ8FzLV/CfIAhc75PO6wW/tdvLq/YymND5BqGoRTN8qpkpPrbEU2BVvxoHliT
         i24d1PHmv9dvcl6vRktyWBie3s3/Lm3/GxyeIslnKu7PcIqaPPwoMGHJHz28jHBhAK4B
         UXfNPQM5kOSAOtbr1LCuhp/uUvLp1U6jcedo1mPaou0nGZl4npXCCXeBrHa5slcUGW8v
         7FqXGW35cdZ8/n4B3qP3RtmD3/OnsKPQY2XfV6sEAEZW+RkVaZVKbBN0H6xtSZxSuFcv
         fz1k2506c+iaDBk3Jw00lLHznE4nd12cLv7/cIRUqORHbbyA591ciz1nurE8KFYCtlAb
         dWVw==
X-Forwarded-Encrypted: i=1; AJvYcCXdXB0szNda4Ld+ktroznLjixGDjOZ8lVRGluTD5iLRxAIRBUkepNBnBUST3kvUyHUvUv9/6YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhNoquAq2IjxjM4ETVf7y7Hg5AimR95qgYY/A5KSms+Es9EFNt
	nr9IyB0ioD+gwoDI2AT93JC/rDyy+JrzklsFjRr4QDzbt9rPzpdj0BEYg4S782uc9pSDeBEYEad
	kzJHFkyQzfgKZdg==
X-Google-Smtp-Source: AGHT+IH/P0IVvaUUQQidgE3CrjW15jQSyGQNTY2y7C7hjtwuIMi83r0s7iZRqZjrT+3+ma6xXzwoRYoraHUbUg==
X-Received: from qkbdl11.prod.google.com ([2002:a05:620a:1d0b:b0:7ff:27b2:2198])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:45ab:b0:7f0:d699:244e with SMTP id af79cd13be357-7ff282c772emr1716008785a.31.1756889246999;
 Wed, 03 Sep 2025 01:47:26 -0700 (PDT)
Date: Wed,  3 Sep 2025 08:47:20 +0000
In-Reply-To: <20250903084720.1168904-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250903084720.1168904-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250903084720.1168904-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] tcp: use tcp_eat_recv_skb in __tcp_close()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Small change to use tcp_eat_recv_skb() instead
of __kfree_skb(). This can help if an application
under attack has to close many sockets with unread data.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 39eb03f6d07f..588932c3cf1d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3118,14 +3118,14 @@ void __tcp_close(struct sock *sk, long timeout)
 	 *  descriptor close, not protocol-sourced closes, because the
 	 *  reader process may not have drained the data yet!
 	 */
-	while ((skb = __skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
 		u32 end_seq = TCP_SKB_CB(skb)->end_seq;
 
 		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
 			end_seq--;
 		if (after(end_seq, tcp_sk(sk)->copied_seq))
 			data_was_unread = true;
-		__kfree_skb(skb);
+		tcp_eat_recv_skb(sk, skb);
 	}
 
 	/* If socket has been already reset (e.g. in tcp_reset()) - kill it. */
-- 
2.51.0.338.gd7d06c2dae-goog


