Return-Path: <netdev+bounces-223648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EBDB59D27
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348071884EDE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01A229ACD1;
	Tue, 16 Sep 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JObVY46g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D33284B3C
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039001; cv=none; b=rHnKxsrGkObtcqL2xptAHP3w0mJvEhQ2IsH0YjvRpP5R3gj28Kgtfpkncr+f4SeDioQZP7Mk5IHPiR5E+zdfHMaqJ8Q2Ys7z2aIXewBp4ISg/NHT7M8aDu/zpt60gMDV+wHoho3cK5nd/r1zFw71d0tuTut6vrd3NiohIMR6J+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039001; c=relaxed/simple;
	bh=ySwMLgeSiwxqzfZw1kK2i4kIi3w+sddLX+7JOrsAfIU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o4G73o+11Gt/ZbUMO+0IG9EeV5X8H6mTts6pLY1bZ/5gZH0y444GMVwBiijD6XNYQhUPnF6Q5uFQbY1ljxjzmnyS+h2y9ztQYNkt2dhaDquWE7XUrFudGlV/g6LlUkXLVGVv8/MN4lk0jootfkD7TSD3Y4mu0NM8M9vqAGNz30o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JObVY46g; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-72f7e04f75fso31391697b3.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758038999; x=1758643799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Py8jBUhfeybccIRAY6oePNTle5blbStpli5/p5nNRFU=;
        b=JObVY46g8h/X1quPwEA5Zr0M4bOlpUoVC08AkPdmiB+peMaTfzZj/92DkJpAHAEPeU
         +MnPy4TRvOahSvA7GfgIosTqo0LNIxtAgcvjldDPIv4NrIC6zA8Y5kmFaQOdH3sDUwPE
         gFHNH8jpUn2Wcsw2zllWwSZkqJ03A9dkun+jJVZC/0z5XHwDw0TYi0dlJzUalktWnis0
         4Y6pIQrJ6Hlr5vQoS1Rdmj2qntYpwqwUImmuZDDum0URhyaOx82r66dEcodKBeRcvSfa
         +BArc0R9texxu1j7r+o+RYnkwSRnJy4G3srhQh+iDmWCkPgJW2cOiCZCmdO3VNsJ2lCV
         eOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038999; x=1758643799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Py8jBUhfeybccIRAY6oePNTle5blbStpli5/p5nNRFU=;
        b=B3Wh6VmnoRaUKJorBWam6uSXHyKwDwV64AUhkJ/lbwVVbdB6BppxXwwoOZBL4Tw3wN
         HoP1lJVTCp+DTrRjgBBs9DlVp4dtWkXyvklTnjQV5Pd3N9b65El4MICE9zOJI9WyZsoz
         HCTMEDCP1xhtL/Cb7XC0++GaKkOQ5IZcIvVM9Wl1ev4r/G/14R31P3pGHcCTQPJRN14J
         cP1n44axflkUYI6MGm/kQlxwY/a3iBfV40YaWNKBmFvma3ibCKL45sRvW2iKPKyh6Pv2
         uLbLQ/Icb1zJRAc0SJ4y9PsPXxQiAOz+KxT2PrUBK0jFfL6yuj1ftSj/B5wqTVsNWyG/
         aK7w==
X-Forwarded-Encrypted: i=1; AJvYcCURiyrYbfW3svCsM8E4VVAWJIVxZx/XuKhiLdRP2w39jQ9XHKHqiNSYEuf6HcBXWcH3Ruk5PlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwobVy4uMOJUVP/qYa1kejYQ6rXG9OPQLQVlIpDREVUTTbQScrT
	qSIQipes07IDFNE1u318rHvRH18+5e/R8Vv5xy0G+BDL4i9T12ncYAk3LxNczForcaHS8kDwBOh
	QzFaf1AlgpPj3GQ==
X-Google-Smtp-Source: AGHT+IEyHIaZKLozDcDkFabaI10XaPeA1jrbwJQvuCoV2XNZTl00fe+Gm61fetJxZXSPbOSY5NsbIReT0ElyUQ==
X-Received: from ywbcm3.prod.google.com ([2002:a05:690c:c83:b0:71f:ee38:1c9f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:4d49:b0:721:29fe:1d44 with SMTP id 00721157ae682-730636755bcmr157102907b3.13.1758038998793;
 Tue, 16 Sep 2025 09:09:58 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:43 +0000
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-3-edumazet@google.com>
Subject: [PATCH net-next 02/10] ipv6: make ipv6_pinfo.daddr_cache a boolean
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipv6_pinfo.daddr_cache is either NULL or &sk->sk_v6_daddr

We do not need 8 bytes, a boolean is enough.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h             | 2 +-
 include/net/ip6_route.h          | 4 ++--
 net/ipv6/af_inet6.c              | 2 +-
 net/ipv6/inet6_connection_sock.c | 2 +-
 net/ipv6/ip6_output.c            | 3 ++-
 net/ipv6/route.c                 | 3 +--
 net/ipv6/tcp_ipv6.c              | 4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 55c4d1e4dd7df803440e3a3cf18245a495ad949b..8e6d9f8b3dc80c3904ff13e1d218b9527a554e35 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -219,7 +219,7 @@ struct ipv6_pinfo {
 #ifdef CONFIG_IPV6_SUBTREES
 	bool			saddr_cache;
 #endif
-	const struct in6_addr		*daddr_cache;
+	bool			daddr_cache;
 
 	__be32			flow_label;
 	__u32			frag_size;
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 223c02d4268858cd3f1c83f949877dabc17efbc8..7c5512baa4b2b7503494b1ae02756df29ef93666 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -229,14 +229,14 @@ static inline const struct rt6_info *skb_rt6_info(const struct sk_buff *skb)
  *	Store a destination cache entry in a socket
  */
 static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
-				 const struct in6_addr *daddr,
+				 bool daddr_set,
 				 bool saddr_set)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 
 	np->dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
 	sk_setup_caps(sk, dst);
-	np->daddr_cache = daddr;
+	np->daddr_cache = daddr_set;
 #ifdef CONFIG_IPV6_SUBTREES
 	np->saddr_cache = saddr_set;
 #endif
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index c342f8daea7fa9469fa7f3a2d1f0a78572b9ae9a..1b0314644e0ccce137158160945b11511588c1df 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -857,7 +857,7 @@ int inet6_sk_rebuild_header(struct sock *sk)
 			return PTR_ERR(dst);
 		}
 
-		ip6_dst_store(sk, dst, NULL, false);
+		ip6_dst_store(sk, dst, false, false);
 	}
 
 	return 0;
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 1947ccdb00df2301be1a8ce651d635dafd08c3b4..ea5cf3fdfdd648e43f4c53611f61509ce06d4cf8 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -91,7 +91,7 @@ static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 
 		if (!IS_ERR(dst))
-			ip6_dst_store(sk, dst, NULL, false);
+			ip6_dst_store(sk, dst, false, false);
 	}
 	return dst;
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 82ff6e1293d04dc9d69a661080cd0ae965cf766c..f904739e99b907a5704c32452ff585479e369727 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1100,7 +1100,8 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
 	 *    sockets.
 	 * 2. oif also should be the same.
 	 */
-	if (ip6_rt_check(&rt->rt6i_dst, &fl6->daddr, np->daddr_cache) ||
+	if (ip6_rt_check(&rt->rt6i_dst, &fl6->daddr,
+			 np->daddr_cache ? &sk->sk_v6_daddr : NULL) ||
 #ifdef CONFIG_IPV6_SUBTREES
 	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr,
 			 np->saddr_cache ? &np->saddr : NULL) ||
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index e1b0aebf8bf92b711581ddb5cde8d9a840e33036..aee6a10b112aac6b17a2ca241b7ecc42ab883a2f 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3032,8 +3032,7 @@ void ip6_sk_dst_store_flow(struct sock *sk, struct dst_entry *dst,
 #endif
 
 	ip6_dst_store(sk, dst,
-		      ipv6_addr_equal(&fl6->daddr, &sk->sk_v6_daddr) ?
-		      &sk->sk_v6_daddr : NULL,
+		      ipv6_addr_equal(&fl6->daddr, &sk->sk_v6_daddr),
 #ifdef CONFIG_IPV6_SUBTREES
 		      ipv6_addr_equal(&fl6->saddr, &np->saddr) ?
 		      true :
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3e41ac94beb7d6fdfb6743ea5dbd609140234219..b76504eebcfa9272fed909655cdc695e82e721dc 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -299,7 +299,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	inet->inet_rcv_saddr = LOOPBACK4_IPV6;
 
 	sk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(sk, dst, NULL, false);
+	ip6_dst_store(sk, dst, false, false);
 
 	icsk->icsk_ext_hdr_len = 0;
 	if (opt)
@@ -1458,7 +1458,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
-	ip6_dst_store(newsk, dst, NULL, false);
+	ip6_dst_store(newsk, dst, false, false);
 
 	newnp->saddr = ireq->ir_v6_loc_addr;
 
-- 
2.51.0.384.g4c02a37b29-goog


