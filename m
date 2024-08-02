Return-Path: <netdev+bounces-115345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DA2945ECD
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 15:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6829A1C20869
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550ED1E4859;
	Fri,  2 Aug 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQ1hYnJU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69831E3CD5
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722606038; cv=none; b=FNe4CfeRfCJ3kP8OaLKBxWlMbCcqspe0Z83b7LLapLL06rTzNKQ9dVKGUfgGfnXvu7JcnB06ezsjL8Lji4BeXJcrchdkxxRl33sCRuFKCY1tkpr/R4A/QOhsuOAh5DBPJaDhxYj/2UVB9/EacGmwmA8BHnly6pRTIKtkTEA+pO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722606038; c=relaxed/simple;
	bh=spCrNzbGkK8/+ZHqzp4os4fkptzalQRSmeVLbxdO8gk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oEX1IW8ujY75Zoo63noCMwe/QVSbSjj1owiz+TSmuqiXSr1wXC01KoMTjesMNlbDCgyRYRC/GsXQb1A7u9jq7E2u+Jg/yCpsUYxbpz+1NQD1tjQuEkY43KsphLusDLeqnY3k2NuV2xak/bNPc8s5Q2rSq2cYb71TLh9CxjWjeig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQ1hYnJU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-65194ea3d4dso157926357b3.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722606035; x=1723210835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=knorcKRv5dDMneA1GmD9DFCzjlihhkTLp7+wgFH0124=;
        b=IQ1hYnJUjxdP2c7IQzbkAja7JBHtkig9RbNYlzNAJW2Iz9yNoUTdRW5FtsrOXydktQ
         Lfc0vT4BVG8NeXjpIH3JrIPrqhCdkdcI8ygCiQ2KEeAKucjLQkk4Qg9lHU7bV05AHgBI
         sqB/8009co7Qno1eZwnynEiDPEf5HPrbWGBJ1lEK/np+Ihl0zAtHQlmu/Ow6RonwYo80
         K8wzpwQHVOGXRTPPHdGBlkjKmuIZ1i1/dFJtIAVmsba56+K3aG/9lK0fLL7s/bXhs+Ja
         zCcSt9kxqw5rh6bhoZXJlznx3BJIwrW1itWU9jLclyqqz1I5ONd+np4LCq2q7M3CJEl0
         6Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722606035; x=1723210835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knorcKRv5dDMneA1GmD9DFCzjlihhkTLp7+wgFH0124=;
        b=a/ixeKR0Qtc0yuNfSllatRAXxxpfQidg/sVOUr53d7xPfFcJv7kbY2Dx81/NNyA/RK
         OyZSln95FYg23bERaKq03dYEOfPYjBfCTztd9sWWEOK6NLymBS6KsQTTeHQnU0djvELR
         gYwoLge5HZHJ5stK3r7BO0kFGCyGxImfC3IdB3FBC2nkyPLYcI9Ix/295lc5sCMMwYPU
         tXSWb5nsl/uTyE5xQZj/+KarlAW59MSFFggXPOrefonhmpBMDE7k59Uap7EWTBGZ4w9U
         T33mSGQJvE9+VrrgibKsk9gJSh5ZWKXV9jFpsNlyTEmv24NZJD3aaM2EiTpp5+Al2n5d
         GSTw==
X-Forwarded-Encrypted: i=1; AJvYcCW3ZmRFoehxZ8f5rTAkppMLYVADrIwM/0kmSXe1DgEp4Y8dqpA4P9OHDwVdPKCWL27P5Yb5zxTqm9OgOmXNCbCmXM+alr9U
X-Gm-Message-State: AOJu0YyuY7GkAuXkKPr5T6kteSXs8jM2YiTt1Ql7SpcLcoxXOGfp+iPN
	5Nv5n7hlyDQzVe9bBrpBpMzyqKzM+wx0dpSLo+0mcsMkUGjKNTjLi/im92FG5ww4qzstXSxrkQ4
	+j//MiFpd1w==
X-Google-Smtp-Source: AGHT+IE1WPfQR5vYwR+Idb2act7F8DUd0LNET6m+S6Z412VYPAWgltoYchFsRh1KOJYzP7eg/i9sL6LX6lYTZQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2b8b:b0:e05:eb99:5f84 with SMTP
 id 3f1490d57ef6-e0bde3656a2mr5785276.4.1722606035605; Fri, 02 Aug 2024
 06:40:35 -0700 (PDT)
Date: Fri,  2 Aug 2024 13:40:25 +0000
In-Reply-To: <20240802134029.3748005-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802134029.3748005-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802134029.3748005-2-edumazet@google.com>
Subject: [PATCH net-next 1/5] inet: constify inet_sk_bound_dev_eq() net parameter
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Tom Herbert <tom@herbertland.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_sk_bound_dev_eq() and its callers do not modify the net structure.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet6_hashtables.h | 2 +-
 include/net/inet_hashtables.h  | 2 +-
 include/net/inet_sock.h        | 3 ++-
 net/ipv4/inet_hashtables.c     | 2 +-
 net/ipv6/inet6_hashtables.c    | 2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 533a7337865a4308c073b30b69dae4dcf7e6b264..591cbf5e4d5f86375598b9622f616ac662b0fc4e 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -175,7 +175,7 @@ struct sock *inet6_lookup(struct net *net, struct inet_hashinfo *hashinfo,
 
 int inet6_hash(struct sock *sk);
 
-static inline bool inet6_match(struct net *net, const struct sock *sk,
+static inline bool inet6_match(const struct net *net, const struct sock *sk,
 			       const struct in6_addr *saddr,
 			       const struct in6_addr *daddr,
 			       const __portpair ports,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 7f1b384587437d06834bde554edd8df983fd64a4..1cc8b7ca20a10c1b0c8a6b9a029e5f8b4a1e846d 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -351,7 +351,7 @@ static inline struct sock *inet_lookup_listener(struct net *net,
 				   ((__force __u64)(__be32)(__saddr)))
 #endif /* __BIG_ENDIAN */
 
-static inline bool inet_match(struct net *net, const struct sock *sk,
+static inline bool inet_match(const struct net *net, const struct sock *sk,
 			      const __addrpair cookie, const __portpair ports,
 			      int dif, int sdif)
 {
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index f9ddd47dc4f8d989e1c966bf363ed846c0911639..394c3b66065e20d34594d6e2a2010c55bb457810 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -150,7 +150,8 @@ static inline bool inet_bound_dev_eq(bool l3mdev_accept, int bound_dev_if,
 	return bound_dev_if == dif || bound_dev_if == sdif;
 }
 
-static inline bool inet_sk_bound_dev_eq(struct net *net, int bound_dev_if,
+static inline bool inet_sk_bound_dev_eq(const struct net *net,
+					int bound_dev_if,
 					int dif, int sdif)
 {
 #if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 48d0d494185b19a5e7282ffb6b33051604c28c9f..3d913dbd028404b1a1bf4dc3f988133e4a1d52ec 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -310,7 +310,7 @@ inet_lhash2_bucket_sk(struct inet_hashinfo *h, struct sock *sk)
 	return inet_lhash2_bucket(h, hash);
 }
 
-static inline int compute_score(struct sock *sk, struct net *net,
+static inline int compute_score(struct sock *sk, const struct net *net,
 				const unsigned short hnum, const __be32 daddr,
 				const int dif, const int sdif)
 {
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 6db71bb1cd300a9a3d91a8d771db4521978bc5d6..f29f094e57a4a5da8b238246d437328569a165d3 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -89,7 +89,7 @@ struct sock *__inet6_lookup_established(struct net *net,
 }
 EXPORT_SYMBOL(__inet6_lookup_established);
 
-static inline int compute_score(struct sock *sk, struct net *net,
+static inline int compute_score(struct sock *sk, const struct net *net,
 				const unsigned short hnum,
 				const struct in6_addr *daddr,
 				const int dif, const int sdif)
-- 
2.46.0.rc2.264.g509ed76dc8-goog


