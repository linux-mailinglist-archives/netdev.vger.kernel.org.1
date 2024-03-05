Return-Path: <netdev+bounces-77592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3F98723A8
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB401C20A93
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB64E12C524;
	Tue,  5 Mar 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3MLJfAC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C3F1292C6
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654695; cv=none; b=Kfn9VdNNVGB4Q4gJFFyVZhRdhKQ/zV07uwJHypAkZtvtr6q9YDQRXqxfV52x/qBTnG/a3kvhIsoxr7TWbT9PHU3raXUyZ3NubZn/IwkYCsNr7IXoy63y6YICQVPfiBuEhlzoRFow58yPVQavtOimE2xIr/Vm3QT8mMX1JixbpI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654695; c=relaxed/simple;
	bh=8lQlopQP1vQVZnm4MX7x/WGwOt74+X00EmL1jeuL3Wg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q9PzC6LFTTEUCLih6kvh6GbH9SwcdUqqGFKGsPW0/7A6cHt7VESDMMomqawPMA2FnLwYxZo8hKkflQEOfohp1ZLtkNOMkpnNb77IXBI7ipLFtxrJcjG0j2F6ITvyctNRSNQnlOHaJdr3j5Z28PxAXu5GlTdUaiXCO75aMNMylWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3MLJfAC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso8836124276.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654679; x=1710259479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J812lKlAoiPYdEqSHKAyJuB8QWUBUqNQavlJ1/QHB4Q=;
        b=v3MLJfACrONnDBM5zRMAqVi/7RDe32TLAfRSpGhY48AEmZnzSfQtafKa8wJ+G83upz
         Ijb2F4wkOlX0OiRggauj6OpuJdSUcAqcZE4EuqDVIb2ZKlxUuYd5ebuHSt/E9Dcq0MuV
         rSxvw0oG6U/j1vDnihiihKpu/8hlN+bG0jR8Z8mFVPCpPBXLJ3FHm4EzxuQKlmx2sR8v
         rx1vaFmrbQYnKYkqZ68p55AJV/PqnAtUqM/S1IHMtzH+mP0rW6MsJOwsMbT86qAKapMl
         Sk15i46ZVZ/92BgrwHUJGtNHpNbx4IJ3QCsxg4oJmUsgqzVjj23bUVnDdvEQvHc8/BJd
         INMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654679; x=1710259479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J812lKlAoiPYdEqSHKAyJuB8QWUBUqNQavlJ1/QHB4Q=;
        b=EpUrRbpABl6r13NTzVe/tsc2m8yoyEHDlpf0RttGwVEaI5J0tkYESMeG4KehHFCALf
         plw6slW6au8lIbtc6PONk3imV0OlAUWEpi+XluZCFoXfYSSeCALp8LYFRsQmJzrQHcU6
         2nozBxQZQBrSXRDwMdKyfod5ZIxMVP29a70ZzwLwZevpY+UvOUBKo6G4ztKJQlw2GI9q
         O2h5iI/liB90Qx+FecipQBxRobTSlPSHf+NRzk1Zpl8s849TzWMwYpkzAs4VjMyrGsEs
         mWDfx1hmmu4amD3VRKfSCkQoWVsEAgAUrC56XYd+swr3Nxq1DAyfQaC/C/drvMWQo4+m
         VcMA==
X-Gm-Message-State: AOJu0YyLKN2a2Ge3yuAFx6ywnivvF9UMoU8DiWA2qXAdM+csoJWOfWTb
	3a7fVe/0DVuTzqZuQCiiV6SwB5N/OKyOW/4rjinE8YTtE2Sl2ykDqySRfZ0+DPQvyWK3g7gSQ0m
	dDRbFBtigPg==
X-Google-Smtp-Source: AGHT+IGV/1LaaidQF4LXBK9bopigujJbsqID9K2WmoimL4rj9Kl+QVYDfqvb3N9Agufc7nICMEpLMpq1lZQTzQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1507:b0:dc7:59d9:7b46 with SMTP
 id q7-20020a056902150700b00dc759d97b46mr476959ybu.3.1709654679032; Tue, 05
 Mar 2024 08:04:39 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:10 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-16-edumazet@google.com>
Subject: [PATCH net-next 15/18] ipv6: move inet6_ehash_secret and
 udp6_ehash_secret into net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

"struct inet6_protocol" has a 32bit hole in 32bit arches.

Use it to store the 32bit secret used by UDP and TCP,
to increase cache locality in rx path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h       | 2 ++
 include/net/protocol.h      | 1 +
 net/ipv6/inet6_hashtables.c | 2 +-
 net/ipv6/udp.c              | 1 -
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 4dd86be99116ff83f2524461a006565b2ade2241..e4dac2f859efd421b975a61360536af949046d0e 100644
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


