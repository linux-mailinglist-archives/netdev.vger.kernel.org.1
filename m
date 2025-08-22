Return-Path: <netdev+bounces-216128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC32CB3229B
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 21:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 768687BD29F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 19:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4242C17A8;
	Fri, 22 Aug 2025 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfI/CtYH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B282D0C92
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889706; cv=none; b=fIP8oGfgYDL5Z+j+DJQVpN/uRNggIt0yl98B29JVnQL58L1FGoC4Brwj/cY6CkFDOecMyzXHhdwmA/kk0wEroyKh0NM+G6RtV5h+GSq1CCvY+DHK4mliV7fAr3jY62NV2mejFTgm4M0cUU1UYDHM3tBMuT1pGRxIY9DdrB31UxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889706; c=relaxed/simple;
	bh=3SXp0BxDXUflJVlTfg6x9ae8F0sy51DkRyG/wefNOUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tybiuCD+mHvn6AN2HyC7G/I05vPciLgBT0wkb02aULMWPwgVOZ/4CDpHPlAkBdiIICdaYuuvotzYM5h9QXy7hiTDPNKlNzTtDd5WCnhXGj5ncrq7RtUJbG3xNTcESM+I1dydQ0M5rm0v2D/i/rUZcUiRYt+0qPCmDeSV1Vle3kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfI/CtYH; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e46a20so4139632a91.3
        for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755889705; x=1756494505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cm8gdNgP/IT+Dy8Aws56AeZFEMwdsUJgs8gcWZ/JpQI=;
        b=rfI/CtYHgVwEgRmyBLCwem26Fs2brStR65+4XlxVjFkQXPxOWU3VYJcN+n8R6SeZZZ
         kg1BXiaxlLk08iLwa2G9yPMD9Yo3IJvF1J35ZWhRCDehwwgFjjYpxfTEuBaXPscxLt29
         DBBo2snXELe58zT4mEzuVGN8q4toSX6sO3FiY+W5Cwvbv/wVvZKo1GI/a+LROwRr/YMI
         bzhjXXaO2UeUmgVmY3QZK3xSlLNt9w9d3yw9Jzy4GUEL3+N6clG+7NcfFhLO8bdXPh6M
         w7XGdd2PspBJy8BBzKyY1MRjo/u4txCH3TTuSfIMI8ocHRibW6zx7n9w/KzTfz2agHyB
         cMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889705; x=1756494505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cm8gdNgP/IT+Dy8Aws56AeZFEMwdsUJgs8gcWZ/JpQI=;
        b=lUfJFF1f3K+/3lbKDVcgeW25eUW3hdZJd3WKo67u+8Ggrx4+TQCBYNSxDwUlMBFoHD
         AZAe6u40ADqBPj2hYsEPXqIZuCJIL2vZBe5bCC0QqwnjLlgN/9bjAfh13lTeUxVNBTRj
         G5R11WjSniSJtnq81qG5h0S0XG3WGVgu4ZC4nM1oAk9fwrEpCaCFyY6ueeAWVmTwARhl
         V2aMvw5ZXg7O1xpg3csVYsRlSs4MT144uCwzfFmqzBnPrFCKN6xGZkGlLUKtQH4thpwr
         ScKyyUO9DQpXVDRWSAC1V/GXbzv06dlklHyPVytltfSFpMsOxcxf6hVzxamuVdMfbp8z
         LpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfuOY5AWB4oED/8jYqnYLUK2imHrnGd/kRZz0ut7BqAWpIM4U0ZgwrcvkKqLzvXrcAGMaJKSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC27Xgt68BdDvcoe8qdmbyqKTBePjW2o0IIpWsYf7CWLa7OEs9
	TnCKYlZy7+iGijamEIXetmIWPu37qqjLWccYGby92/zKvecdRQuqlvsMllPBcPNTH65PeXjoB/9
	YmbKqwQ==
X-Google-Smtp-Source: AGHT+IErm0vjTZgTSQnQeJMskJLahNjqNmZhSct5kIY56XV8nGQngXQOiOPZYskebASUvZ5Vlrusnt0HSes=
X-Received: from pjbeu4.prod.google.com ([2002:a17:90a:f944:b0:311:ff32:a85d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39c7:b0:31f:652b:e67e
 with SMTP id 98e67ed59e1d1-32515e50ec4mr5919459a91.15.1755889704727; Fri, 22
 Aug 2025 12:08:24 -0700 (PDT)
Date: Fri, 22 Aug 2025 19:06:57 +0000
In-Reply-To: <20250822190803.540788-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250822190803.540788-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250822190803.540788-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/6] tcp: Remove timewait_sock_ops.twsk_destructor().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since DCCP has been removed, sk->sk_prot->twsk_prot->twsk_destructor
is always tcp_twsk_destructor().

Let's call tcp_twsk_destructor() directly in inet_twsk_free() and
remove ->twsk_destructor().

While at it, tcp_twsk_destructor() is un-exported.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/timewait_sock.h   | 7 -------
 net/ipv4/inet_timewait_sock.c | 5 +++--
 net/ipv4/tcp_ipv4.c           | 1 -
 net/ipv4/tcp_minisocks.c      | 1 -
 net/ipv6/tcp_ipv6.c           | 1 -
 5 files changed, 3 insertions(+), 12 deletions(-)

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
index 875ff923a8ed..5b5426b8ee92 100644
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
@@ -74,7 +74,8 @@ static void inet_twsk_kill(struct inet_timewait_sock *tw)
 void inet_twsk_free(struct inet_timewait_sock *tw)
 {
 	struct module *owner = tw->tw_prot->owner;
-	twsk_destructor((struct sock *)tw);
+
+	tcp_twsk_destructor((struct sock *)tw);
 	kmem_cache_free(tw->tw_prot->twsk_prot->twsk_slab, tw);
 	module_put(owner);
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
2.51.0.rc2.233.g662b1ed5c5-goog


