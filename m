Return-Path: <netdev+bounces-223647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6CAB59D07
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED8857A9743
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA93284B2F;
	Tue, 16 Sep 2025 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OAikwI2j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04627E074
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038999; cv=none; b=BsYcGCQqz6gI0TjHc85c3mjR4q/vhnkIuDFI1QFz7xvunzp4nGanKnTy6RoFxKopcen17/uTJOZODKYAE/suxroLGR7wr+B/MjK/XG+BOdzV3xzu7BUAaJujT9L/4zGu56zGaw55biWwwO71kfvdMqCjUtygp0Q1KoXA6KUuKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038999; c=relaxed/simple;
	bh=0bc0gnXNOIwCI8MB6wQx7On04JeVbXPe+/CK3Ow6uu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDx4UFiWAEj2TGiv+31kSgBC1E1E4FdY5DwHMd/J4DT7HbwKu0CYKRhnNGFqaddhpFXWKajL2NiC/eDj7TrcYwSZFfW1utw3otRTpLuAiqV/I6bHOlIwhm5VFiAvGZ6OMOx0Ay1msoycQCwtV6rrDHzH2inWDZ8HgNfhTflduAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAikwI2j; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-812ae9acaecso1316596085a.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758038997; x=1758643797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tMUzSXNJL1L0zrGQci63bM+T6Joi0tTbQ/krE/Icyc=;
        b=OAikwI2jovb092kqEYlWE4dTKoVXDm+Y7dUI5JoAD6adHh4eaQOTdNS/KIqSIEihqp
         4o1K4M3GbDG8WudGE9/quSxrsjslyflrR9U/bAU31nccXESuSNbpWtPpG6OYwEg0etic
         7tl2rlvQV3spHv0+e5UZCbVv5xJLjKG7YE12k8TK6pUmzNrYk1/OA1ZrN5POPYQprg89
         fW3EvJO599pvKV0fMGW5Xn1Y21cnfidaz6eyxXWMw6t/SjnaTOY4Y6cJhPTdb8f1jco3
         rx1X/FqqwjDCtzMfHEdHTzHgO/bY6xQ1MgumN6Rg1xpvTieHv+seC5+SGO3YyNMrW+zo
         N9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038997; x=1758643797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tMUzSXNJL1L0zrGQci63bM+T6Joi0tTbQ/krE/Icyc=;
        b=RQ1LvJqMfHQFhU3uHApiqKEcZIBEW0kix/y2kUsF/NhaMDhjZSpyrAQCuU5pY3dPDi
         I9oGr7mfrhP52pG+fJpCDqBNVnK4dEBB927LhHcUmaWb1l7lcMLEuAzYMAoJAKMBMo5W
         +7nYpLxylzLvbBoJ8mR6UK1G59fEC0h6/Loe7cGlCH04yIGmh2dSYGTz2V/pwcfb0dJE
         p//0+AaSHw5vGwHGDUykWKpm57JzZZZ+JDKbozTxW4zfMzOLGrejsXvfE1b+zaQWEyNB
         hbzJ1PgyCK3MkEsJN/V6lFqHDdPRep0p1rYH9aFFIso7cqPpJeVOetvVIU3J/8dBUmmw
         ZM0A==
X-Forwarded-Encrypted: i=1; AJvYcCWFvRdC05U3WTR9C0l1XOa7XaCXbrwSRVwBD7Q5k+1KkXhXR4Io6zkfQgGmsELs2Khcf41xyig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjegfOb1Sufciq6MgIhNqbuhZloVev8mEhDLMnxcZzjOslzsOP
	VHYjK6Cp6VSPpn+jY3gGTRbVUgEMcVyEBIGz+JBfYJQwsmRefpsokSrsaxk+D1vWz2dqikQEhh6
	z2SkdC3HNrzUKig==
X-Google-Smtp-Source: AGHT+IEfM0IA6g0/wLKpOEv9v0jv5pxn+0/AMpM/SPgRRpJBZCGgxTyAtWyO6jWCj2oCcj/uW5y3gKORumeRmQ==
X-Received: from qkpc16.prod.google.com ([2002:a05:620a:2690:b0:828:9bf9:d9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4107:b0:802:78a5:a86f with SMTP id af79cd13be357-824047c8dd0mr1917316685a.79.1758038996845;
 Tue, 16 Sep 2025 09:09:56 -0700 (PDT)
Date: Tue, 16 Sep 2025 16:09:42 +0000
In-Reply-To: <20250916160951.541279-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916160951.541279-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160951.541279-2-edumazet@google.com>
Subject: [PATCH net-next 01/10] ipv6: make ipv6_pinfo.saddr_cache a boolean
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipv6_pinfo.saddr_cache is either NULL or &np->saddr.

We do not need 8 bytes, a boolean is enough.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/ipv6.h             | 4 ++--
 include/net/ip6_route.h          | 4 ++--
 net/ipv6/af_inet6.c              | 2 +-
 net/ipv6/inet6_connection_sock.c | 2 +-
 net/ipv6/ip6_output.c            | 3 ++-
 net/ipv6/route.c                 | 4 ++--
 net/ipv6/tcp_ipv6.c              | 4 ++--
 7 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index f43314517396777105cc20ba30cac9c651b7dbf9..55c4d1e4dd7df803440e3a3cf18245a495ad949b 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -216,10 +216,10 @@ struct inet6_cork {
 struct ipv6_pinfo {
 	struct in6_addr 	saddr;
 	struct in6_pktinfo	sticky_pktinfo;
-	const struct in6_addr		*daddr_cache;
 #ifdef CONFIG_IPV6_SUBTREES
-	const struct in6_addr		*saddr_cache;
+	bool			saddr_cache;
 #endif
+	const struct in6_addr		*daddr_cache;
 
 	__be32			flow_label;
 	__u32			frag_size;
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 59f48ca3abdf5a8aef6b4ece13f9a1774fc04f38..223c02d4268858cd3f1c83f949877dabc17efbc8 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -230,7 +230,7 @@ static inline const struct rt6_info *skb_rt6_info(const struct sk_buff *skb)
  */
 static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
 				 const struct in6_addr *daddr,
-				 const struct in6_addr *saddr)
+				 bool saddr_set)
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 
@@ -238,7 +238,7 @@ static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
 	sk_setup_caps(sk, dst);
 	np->daddr_cache = daddr;
 #ifdef CONFIG_IPV6_SUBTREES
-	np->saddr_cache = saddr;
+	np->saddr_cache = saddr_set;
 #endif
 }
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 1992621e3f3f4b5b5c63e857b7b1c90576d3766e..c342f8daea7fa9469fa7f3a2d1f0a78572b9ae9a 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -857,7 +857,7 @@ int inet6_sk_rebuild_header(struct sock *sk)
 			return PTR_ERR(dst);
 		}
 
-		ip6_dst_store(sk, dst, NULL, NULL);
+		ip6_dst_store(sk, dst, NULL, false);
 	}
 
 	return 0;
diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 333e43434dd78d73f960708a327c704a185e88d3..1947ccdb00df2301be1a8ce651d635dafd08c3b4 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -91,7 +91,7 @@ static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
 
 		if (!IS_ERR(dst))
-			ip6_dst_store(sk, dst, NULL, NULL);
+			ip6_dst_store(sk, dst, NULL, false);
 	}
 	return dst;
 }
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 9d64c13bab5eacb4cc05c78cccd86a7aeb36d37e..82ff6e1293d04dc9d69a661080cd0ae965cf766c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1102,7 +1102,8 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
 	 */
 	if (ip6_rt_check(&rt->rt6i_dst, &fl6->daddr, np->daddr_cache) ||
 #ifdef CONFIG_IPV6_SUBTREES
-	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr, np->saddr_cache) ||
+	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr,
+			 np->saddr_cache ? &np->saddr : NULL) ||
 #endif
 	   (fl6->flowi6_oif && fl6->flowi6_oif != dst_dev(dst)->ifindex)) {
 		dst_release(dst);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3371f16b7a3e615bbb41ee0d1a7c9187a761fc0c..e1b0aebf8bf92b711581ddb5cde8d9a840e33036 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3036,9 +3036,9 @@ void ip6_sk_dst_store_flow(struct sock *sk, struct dst_entry *dst,
 		      &sk->sk_v6_daddr : NULL,
 #ifdef CONFIG_IPV6_SUBTREES
 		      ipv6_addr_equal(&fl6->saddr, &np->saddr) ?
-		      &np->saddr :
+		      true :
 #endif
-		      NULL);
+		      false);
 }
 
 static bool ip6_redirect_nh_match(const struct fib6_result *res,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 08dabc47a6e7334b89b306af3a1e1c89c9935bb6..3e41ac94beb7d6fdfb6743ea5dbd609140234219 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -299,7 +299,7 @@ static int tcp_v6_connect(struct sock *sk, struct sockaddr *uaddr,
 	inet->inet_rcv_saddr = LOOPBACK4_IPV6;
 
 	sk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(sk, dst, NULL, NULL);
+	ip6_dst_store(sk, dst, NULL, false);
 
 	icsk->icsk_ext_hdr_len = 0;
 	if (opt)
@@ -1458,7 +1458,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
-	ip6_dst_store(newsk, dst, NULL, NULL);
+	ip6_dst_store(newsk, dst, NULL, false);
 
 	newnp->saddr = ireq->ir_v6_loc_addr;
 
-- 
2.51.0.384.g4c02a37b29-goog


