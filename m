Return-Path: <netdev+bounces-78006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF5E873B80
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C1E1F27274
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A4013DB9F;
	Wed,  6 Mar 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIhtizzP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF1713D31A
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740869; cv=none; b=nvnkTRyR83FHwrc/MwBZ4Ow9HmbZG4Z1A0U1II29Btrm2hH8wFv+Oj0DM8UZENrnWrw5Vt3rxwXp4eX7D0RXPFIcnSv3X9cQov38Tw+GGdk8LeiiUrOvNhoB36H93ISuBJ2H54ox60E/G4dV8BibWZ7a4RimVNLDiA47fYtLcqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740869; c=relaxed/simple;
	bh=/eW15AbMiemK9oqz4ilGYw0a/HW/ZN6orQzNDLi+j2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XK6KRqoT4rF3zPvJ9+sECEm5PSifUnOAarJbUTIr+wJQYY/2/9A/rxdYUM6TNH0CyUrbpFkYPRMwuYqctBB3NyIoVAD31ZtkLzSqyKbRDR641xAAgXxBOOMerzFTvpE4PuwIuKISDvyYuHXgzho5aWlSxHqSKJjx7qufmYZI8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIhtizzP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so10474628276.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740867; x=1710345667; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2ukU5wCmt4sKFPMRc+fc8OauvFPCsq5nLlkABZEOnE=;
        b=eIhtizzPeh70wE0/5Q8OL5DBHvRRZuqQiraTmlSO4yEU50gvIw+o5Jm0JRJ7AwNo/g
         oBVW+0268t60kasJ3GZmrEq8eEt5QlmXGUO+NZoE1mfgVgob7tusCRxw8Zglg89cGCZq
         AOixz7AO0pDks5cHvRo6B9AkHuY4HjU4C2X/2Ur/CeJrv7J+3X3UEoZIa0wcmloE/t2V
         cEsk7fgsXkCQHVUA6W/UH+zH69vll4nnW3j2LDD9wbp8jzQF5dGekzkKz+HARRDisQN2
         60vHPTgVoz9VGlb/NuMkp4k3k5JBiDoTjK4QNyq0SGSZUCt99bSHlp28y92zA6AwHHhG
         JXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740867; x=1710345667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2ukU5wCmt4sKFPMRc+fc8OauvFPCsq5nLlkABZEOnE=;
        b=jWKBtG6HdfGChlEf3GYlc68Xd3T1HLZC4kdRiBTVjJjTVOF7RqGX1ZjX9thNAgcfbh
         9e1d4BVbTk/a7WO+AYcRBERfA68gd2cxg2tcn3bW6AS9YddvxIwQ8IS+ZFeTnToNgx3s
         qsklmbFVLFOZeF0yTFPRBSfjSKOfvlQvlM2FracVyJuhozFJ9/BisAlJc3qGqBK29Y5i
         awL98uxj9WgsjBKjvzxpIBtce0TQfnxKlMOA8CR0RYVnHvNGXWESeNI3ggdjF2i6PTmp
         n+L3mQstEwYM6WzoTVfImB5nHsVQrt21EvC2ZuFI/oHEs+j1LBD0A1InArKP7y0FhHd9
         DmhA==
X-Forwarded-Encrypted: i=1; AJvYcCV+RFIOnXF+m+JlTUOdUQlPDqwTKwXSrqY1J2BuG80Uh1Lb4pGiUqBo5NcMwqRj8VcE3Px0nYZOSEyOikFX/gckMEtu0Ep5
X-Gm-Message-State: AOJu0YybU1vkarR12X48a0TdkPuNtSehbIIrfJW1zK5SyAPln1laNpoH
	8nFd+qpoIP9IpFXXnJb8INgPouCaMjOYE7vMvH5SyNAbXh29q2ObdbnibkE3N8glueOBwpq0/hl
	9BMa5gLUTlA==
X-Google-Smtp-Source: AGHT+IFfgR5Q1V5r56+jQkxCYyYWXwrOOZfCPaoNQs5240C00aL+3LW1Iq+7rt8o8E8JPfE2KCubLeugHje2BA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2206:b0:dc2:26f6:fbc8 with SMTP
 id dm6-20020a056902220600b00dc226f6fbc8mr649839ybb.7.1709740866795; Wed, 06
 Mar 2024 08:01:06 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:28 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-16-edumazet@google.com>
Subject: [PATCH v2 net-next 15/18] ipv6: move inet6_ehash_secret and
 udp6_ehash_secret into net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

"struct inet6_protocol" has a 32bit hole in 32bit arches.

Use it to store the 32bit secret used by UDP and TCP,
to increase cache locality in rx path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/hotdata.h       | 2 ++
 include/net/protocol.h      | 1 +
 net/ipv6/inet6_hashtables.c | 2 +-
 net/ipv6/udp.c              | 1 -
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 7a210ea6899c6af4e0424201cd265755ef460078..6d5cd967183a59271da1a27edfee1bc6bf155c1b 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -38,6 +38,8 @@ struct net_hotdata {
 
 #define inet_ehash_secret	net_hotdata.tcp_protocol.secret
 #define udp_ehash_secret	net_hotdata.udp_protocol.secret
+#define inet6_ehash_secret	net_hotdata.tcpv6_protocol.secret
+#define udp6_ehash_secret	net_hotdata.udpv6_protocol.secret
 
 extern struct net_hotdata net_hotdata;
 
diff --git a/include/net/protocol.h b/include/net/protocol.h
index 3ff26e66735cec98b08eadb1c3f129e011923cb0..213649d2ab098edc4eb9f44a5403540887c2b8ef 100644
--- a/include/net/protocol.h
+++ b/include/net/protocol.h
@@ -60,6 +60,7 @@ struct inet6_protocol {
 			       __be32 info);
 
 	unsigned int	flags;	/* INET6_PROTO_xxx */
+	u32		secret;
 };
 
 #define INET6_PROTO_NOPOLICY	0x1
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b0e8d278e8a9b794d0001efdc0f43716f9a34f8f..0fee97f3166cf8326b3b714ac6bde48ca5188cec 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -14,6 +14,7 @@
 #include <linux/random.h>
 
 #include <net/addrconf.h>
+#include <net/hotdata.h>
 #include <net/inet_connection_sock.h>
 #include <net/inet_hashtables.h>
 #include <net/inet6_hashtables.h>
@@ -25,7 +26,6 @@ u32 inet6_ehashfn(const struct net *net,
 		  const struct in6_addr *laddr, const u16 lport,
 		  const struct in6_addr *faddr, const __be16 fport)
 {
-	static u32 inet6_ehash_secret __read_mostly;
 	static u32 ipv6_hash_secret __read_mostly;
 
 	u32 lhash, fhash;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 97d86909aabb6588d0bba901f6df1f23a4f2e561..1e1c67a51675e8534a953a6d4d63211388d95ca9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -79,7 +79,6 @@ u32 udp6_ehashfn(const struct net *net,
 		 const struct in6_addr *faddr,
 		 const __be16 fport)
 {
-	static u32 udp6_ehash_secret __read_mostly;
 	static u32 udp_ipv6_hash_secret __read_mostly;
 
 	u32 lhash, fhash;
-- 
2.44.0.278.ge034bb2e1d-goog


