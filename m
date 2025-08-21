Return-Path: <netdev+bounces-215496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1AB2EE03
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B7681C20230
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD13273D84;
	Thu, 21 Aug 2025 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WT9UuWAI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DDB261B83
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755756966; cv=none; b=Lx9MOkeWDSaRv2OTLBeLxRc4hDplEN1SbPN92NjxhmJtEDUfmYwqaT0M6sIcuba2G882UHRQiL3tbHfQn2JnHkfZeIEEjmPQJ0BEEB9jeCTXjDfi4nxkdXU21IIeJbyW35EtfpO40Li/S1SUVDYlQy2QB3bXzbbXb3TS0AnQTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755756966; c=relaxed/simple;
	bh=q4oJYTxWMq/q9KoMG5/x5TNWrPBTm0uaJyyWXGTFR40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LIqs30wMgly8kDuiiDoLNjdQKvU8FILSGk59ZVjJz9L+pHG7Ee8FmHmnhZrhdNI1kxHy6n0GSKlf1edFfouIxNu74NgorPiF8cwIUlPan9kQCyaIXubsnE280hk+CmRvyM1xAAYxXNUAwFOhfPBSN+8kQ5GIgCwcUTu2i3w1UoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WT9UuWAI; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3234811cab3so780476a91.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755756964; x=1756361764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CZsrvFU/1bGGy8dC5xlGXZ4D/jyraR0R8oqSfo7nFxI=;
        b=WT9UuWAIJ7nK1dmNbel69Ohst1YTfEIRXYRPcuBI7pyI7UQRWg/F4yV0LtdtGkodIW
         4N3iWF/vtMwq7pmSkdLO3wtLCPEy2PI/cxL9ldKym7r20ItyYEcomFAZBbmvj4LsULaj
         HCbnPadl98GYpaV6JrAw74xhpG5KHXNyaRVCa1OU8SyyuXifYZtb27RodKFZXdWo4GuR
         Zpm4PY7pdcF9KY0yhcb9mzQCWEgbQOJ30Dw7ao8FIjUnkGFdGu2uLQGLdNbfDZWWC2c7
         rL9bIjulF6eqEaGj0W7aPxLX4biSvDZQPVwAVDh7j9IZ8TqzXU8SEHB58JKKaCby2yml
         wb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755756964; x=1756361764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZsrvFU/1bGGy8dC5xlGXZ4D/jyraR0R8oqSfo7nFxI=;
        b=XR2ovOcRJfV9BtQUJPyEULHpT4G5jVo+yV563F2MVZnB20kk6matatcOY6we48QGY8
         eUZ4nRJENS4+gb4WSBo/YRQHBnlgBzBRCR4f2D4cZbKOGnhtoxQk/BAUCwg97TwtiNsc
         oeTWzeprC86rQhUwEfVXbYP+PeNX7WgWGmLbsZ6ucAl8jfs879UILfRnXZFLzMS3v6NW
         GGwH/U+323GxAh1hmWgVkgA1ubymX965kmSUj4+mCeLYt7bY6aToA0gjSjGxqPoCLUgj
         wlvPgKNhv3viRiLxYbb4Ts5iOWmrIK3YF9UsOstQkXOvItJUw11fqI5YexeOEVitj8RQ
         dt6g==
X-Forwarded-Encrypted: i=1; AJvYcCVKhffNUEJERR5x+tog9LHC4W8cxxWxer8AtNRRvOoEV72W9Z5gC6TFIWDX8wtisRX+MK0f9Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYNea9CLv43LMjDi6Nu+SHnhDDIfPRZW21/Ps4bry7wxhsOC5
	f52o7bnLIDbBWSRFPIedhTiFE193551TetNT5sCOiDe0N6SdLxdwv78BU71TwgtPobcRTOddlXe
	oJegLhQ==
X-Google-Smtp-Source: AGHT+IGJKQ3gdDuZ9Yjds5HNyPGHqy2T/lvaCFhTqgk4VrvUPWN3vnFCUVA6Jx8duHIMEKGy23xLqlVzSOQ=
X-Received: from pjbsx12.prod.google.com ([2002:a17:90b:2ccc:b0:313:245:8921])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3fcf:b0:324:ecb3:f0f6
 with SMTP id 98e67ed59e1d1-324ed1bf8demr1806011a91.27.1755756964043; Wed, 20
 Aug 2025 23:16:04 -0700 (PDT)
Date: Thu, 21 Aug 2025 06:15:14 +0000
In-Reply-To: <20250821061540.2876953-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821061540.2876953-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 3/7] tcp: Remove timewait_sock_ops.twsk_destructor().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

From: Kuniyuki Iwashima <kuniyu@amazon.com>

Since DCCP has been removed, sk->sk_prot->twsk_prot->twsk_destructor
is always tcp_twsk_destructor().

Let's call tcp_twsk_destructor() directly in inet_twsk_free() and
remove ->twsk_destructor().

While at it, tcp_twsk_destructor() is un-exported.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/timewait_sock.h   | 7 -------
 net/ipv4/inet_timewait_sock.c | 4 ++--
 net/ipv4/tcp_ipv4.c           | 1 -
 net/ipv4/tcp_minisocks.c      | 1 -
 net/ipv6/tcp_ipv6.c           | 1 -
 5 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/include/net/timewait_sock.h b/include/net/timewait_sock.h
index 62b3e9f2aed4..0a85ac64a66d 100644
--- a/include/net/timewait_sock.h
+++ b/include/net/timewait_sock.h
@@ -15,13 +15,6 @@ struct timewait_sock_ops {
 	struct kmem_cache	*twsk_slab;
 	char		*twsk_slab_name;
 	unsigned int	twsk_obj_size;
-	void		(*twsk_destructor)(struct sock *sk);
 };
 
-static inline void twsk_destructor(struct sock *sk)
-{
-	if (sk->sk_prot->twsk_prot->twsk_destructor != NULL)
-		sk->sk_prot->twsk_prot->twsk_destructor(sk);
-}
-
 #endif /* _TIMEWAIT_SOCK_H */
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 024463a3e696..3fd46122d313 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -15,7 +15,7 @@
 #include <net/inet_hashtables.h>
 #include <net/inet_timewait_sock.h>
 #include <net/ip.h>
-
+#include <net/tcp.h>
 
 /**
  *	inet_twsk_bind_unhash - unhash a timewait socket from bind hash
@@ -73,7 +73,7 @@ static void inet_twsk_kill(struct inet_timewait_sock *tw)
 
 void inet_twsk_free(struct inet_timewait_sock *tw)
 {
-	twsk_destructor((struct sock *)tw);
+	tcp_twsk_destructor((struct sock *)tw);
 	kfree(tw);
 }
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 84d3d556ed80..c7b9377e5a66 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2459,7 +2459,6 @@ int tcp_v4_rcv(struct sk_buff *skb)
 
 static struct timewait_sock_ops tcp_timewait_sock_ops = {
 	.twsk_obj_size	= sizeof(struct tcp_timewait_sock),
-	.twsk_destructor= tcp_twsk_destructor,
 };
 
 void inet_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 2994c9222c9c..d1c9e4088646 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -401,7 +401,6 @@ void tcp_twsk_destructor(struct sock *sk)
 #endif
 	tcp_ao_destroy_sock(sk, true);
 }
-EXPORT_IPV6_MOD_GPL(tcp_twsk_destructor);
 
 void tcp_twsk_purge(struct list_head *net_exit_list)
 {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 7577e7eb2c97..4bc0431bf928 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2050,7 +2050,6 @@ void tcp_v6_early_demux(struct sk_buff *skb)
 
 static struct timewait_sock_ops tcp6_timewait_sock_ops = {
 	.twsk_obj_size	= sizeof(struct tcp6_timewait_sock),
-	.twsk_destructor = tcp_twsk_destructor,
 };
 
 INDIRECT_CALLABLE_SCOPE void tcp_v6_send_check(struct sock *sk, struct sk_buff *skb)
-- 
2.51.0.rc1.193.gad69d77794-goog


