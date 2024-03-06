Return-Path: <netdev+bounces-78005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A44873B7F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DE71F23D69
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5820E135A6F;
	Wed,  6 Mar 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UltMZEt7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCECD13D2E8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740867; cv=none; b=MmAY4b0RQtXpgor7zr5WA5CsdjZSbyPPN1+agI99rfr5u3ZilR8dw0tiZxhwg52kJAvmA9jL03jPxvNWoEYaSKpqAfbis0AxSJOpjAIR2r0pxKVRiRX4O3YvswCeoz1b/LQkivDg+S3s0sk9XXyvfEaD5UBaUgiIXgtOK8A+/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740867; c=relaxed/simple;
	bh=2opeJepDAvcGIAcNgC0yTFwPLR2lWRo0m74ZuzjGz90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rVWq+Kek3YmIEIieSK8AEUmo6A/Ivi/8q3LLVWbazhuGy6Rxa916FrIqv/5x1TQJCaOFeJRRCkK690F5UDYEgNoED8FQdukt6HbdEgACuRJ6Q47LVKWrPdeLRIuYqlq+R6RnYQbkM9XMPi1bsAb4XpqZzYrz1nKYwuRqVofu0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UltMZEt7; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-42edd97c9e6so43291701cf.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740865; x=1710345665; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6QGdYIRZ1txU93levxcNkXzKVT3WDaykDhB0OxJjos=;
        b=UltMZEt7jSLgvipEDBJma5OE1qU2T98VP4H2/2bUFJKT3nLki5cOVRRY+p3XzoCztz
         UMlzKVHTuxisPyzpxqb0OCN3ZEn9rnRcDLxlfFngTtB265mqkkGBRWfleMsW7UQj0o9P
         1ObMz8rrPvYmvoJ4C1J14oArjakbYviWxJ2h0AQBDyhA4sjV29MhyNTrMMoIEv9mJofQ
         LXX+OOkq7nAP/qpl3K9UrKQ/EYyYSmuUs5XnB5BuAMrw2wuJ8DGRZONHA0bW6UpN/ixk
         LSN9+4U3WqmrunLC28kpp3zYSbXB8MI7JG1otQ96OrES3Qt0+ztHwNeFKCU5jMsomcNV
         OT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740865; x=1710345665;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6QGdYIRZ1txU93levxcNkXzKVT3WDaykDhB0OxJjos=;
        b=DMffpMOGrLynV7zm7Cu4lmFyFJ9HStat/BxTzR47TncNsvDHkxybTcal0SodBJngaS
         mdqdC0c0BNcbMkH3fy8bSOMipfybQdA+MYEheYQNtvdGj3Dj7b8uHUCc1p/LxnYjetko
         bTFNR+QfLtAwEHAGxMVx9SUUE825bpIUPmNEvn8UCBRTRIkAea7SHFHLB1CQmedpPaAr
         MvUUvmycrYzqN47uzygWZjTdRuVT8AUk7FJCOhEUBDV5VmDN6Ykbidft/49kso+rmK82
         AEVXTgN7XiOQZW0DUiTqfNRQcOp+oXMU1uqEdXQ56McEtF1aGmHWpoh0gTVyQD7gXGS5
         bXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlKg2HelEM2A7o+k+tVs/R2ysH2V/gcEufu0qDqy2Zsl036Km6g4f8wTRIt3pA27he+ZGZLW794u+QC9SWZDCuHbyDHT5N
X-Gm-Message-State: AOJu0YzqbwXSYBTbjQWqkkkBKZ6lwnHv7/72dYMGrQPg2wjlS6CvorSY
	2XL4sh1mDP8sPG9SPuBrkp9yigims6z1DxX09gcl5fOSm6QKcEFRcQfpMI9YLDKt3Onwm5z5hsA
	jS4tKT5ApLA==
X-Google-Smtp-Source: AGHT+IGDhIwrizAJYK/rH1j4Y0BOrFqAe/Pku5kY9rF96ILeVxHeVyNuOrxRZKohTtbPuLjPre5WFOWUDeaGbQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6214:f22:b0:68f:2fe5:d4bf with SMTP
 id iw2-20020a0562140f2200b0068f2fe5d4bfmr317188qvb.13.1709740864721; Wed, 06
 Mar 2024 08:01:04 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:27 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-15-edumazet@google.com>
Subject: [PATCH v2 net-next 14/18] inet: move inet_ehash_secret and
 udp_ehash_secret into net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

"struct net_protocol" has a 32bit hole in 32bit arches.

Use it to store the 32bit secret used by UDP and TCP,
to increase cache locality in rx path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/hotdata.h      | 3 +++
 include/net/protocol.h     | 1 +
 net/ipv4/inet_hashtables.c | 3 +--
 net/ipv4/udp.c             | 2 --
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 87215f7ac200f2ba34de9b52841bc0c9e4849857..7a210ea6899c6af4e0424201cd265755ef460078 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -36,6 +36,9 @@ struct net_hotdata {
 	int			dev_rx_weight;
 };
 
+#define inet_ehash_secret	net_hotdata.tcp_protocol.secret
+#define udp_ehash_secret	net_hotdata.udp_protocol.secret
+
 extern struct net_hotdata net_hotdata;
 
 #endif /* _NET_HOTDATA_H */
diff --git a/include/net/protocol.h b/include/net/protocol.h
index 6aef8cb11cc8c409e5f7a2519f5e747be584c8d5..3ff26e66735cec98b08eadb1c3f129e011923cb0 100644
--- a/include/net/protocol.h
+++ b/include/net/protocol.h
@@ -46,6 +46,7 @@ struct net_protocol {
 				 * socket lookup?
 				 */
 				icmp_strict_tag_validation:1;
+	u32			secret;
 };
 
 #if IS_ENABLED(CONFIG_IPV6)
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 308ff34002ea6b5e0620004f65ffd833087afbc1..7498af3201647fd937bf8177f04c200bea178a79 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -24,6 +24,7 @@
 #include <net/inet6_hashtables.h>
 #endif
 #include <net/secure_seq.h>
+#include <net/hotdata.h>
 #include <net/ip.h>
 #include <net/tcp.h>
 #include <net/sock_reuseport.h>
@@ -32,8 +33,6 @@ u32 inet_ehashfn(const struct net *net, const __be32 laddr,
 		 const __u16 lport, const __be32 faddr,
 		 const __be16 fport)
 {
-	static u32 inet_ehash_secret __read_mostly;
-
 	net_get_random_once(&inet_ehash_secret, sizeof(inet_ehash_secret));
 
 	return __inet_ehashfn(laddr, lport, faddr, fport,
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a8acea17b4e5344d022ae8f8eb674d1a36f8035a..2beabf5b2d8628f1fed69a0212c57bd3cd638483 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -411,8 +411,6 @@ INDIRECT_CALLABLE_SCOPE
 u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 		const __be32 faddr, const __be16 fport)
 {
-	static u32 udp_ehash_secret __read_mostly;
-
 	net_get_random_once(&udp_ehash_secret, sizeof(udp_ehash_secret));
 
 	return __inet_ehashfn(laddr, lport, faddr, fport,
-- 
2.44.0.278.ge034bb2e1d-goog


