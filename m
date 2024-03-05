Return-Path: <netdev+bounces-77593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31D68723A9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A6BB24375
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61312C520;
	Tue,  5 Mar 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwRTFptb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5C12880D
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654697; cv=none; b=bXVIMkuezhMFdJlP42QxW1FMaiX7EcgFj2vH1Lea5BNBwDUTQ+TCuhNhmQxNuY6Y16pGb8byQJmqIgf368OUga8/SfF8Yu4AFsSc+M3ZEl17hz7evtB9NoxTs4kyucxioYt3+vjdapRJ9w0tjFXhBc+L6IJ8MzXIEXRsJJeezQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654697; c=relaxed/simple;
	bh=wuJAK4u5Z43xMfjz8Ab/ZSWgWF3a+56F0FV9pa0Q9lU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ExhyjqCMBNWwcP80BwQatnuz3TB7HZEeg9X/vE52LGDWkS5O8WCjIt9nMm/f9YLd8Tb2ZBtEwoPig7tiwpLQ2xHTquzVCZSu7UJJcsYDsRV0+2ejaU0/SA9MRy9gVk12DjbFZ/d1n6PGeDF5QdeuPuuvOCaLObhyfjBK19hqcho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwRTFptb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60998466af4so51198667b3.3
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654680; x=1710259480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a1vkV6Sni2i06OF9GaK5ZpbS2xl9biWoyHnzpUvKBKg=;
        b=XwRTFptbx0KFhVvpDcibO2Ek3aCjdC80ttvIjlrSujbMRzJAvx656VsuleHDQgHhx1
         Vsp0rZniPefKaFWExnx201c0cwX1VPpJYZ8GIG1vjqf1ioiWIM08QZqUzqLHaLKZQo+2
         xNTyFQvTcfL8fNXOXNz9dVEUxpJY2bA87LJ/Y03Dv0IX8nMYhA9zG1XWIYhxZCRUtrvZ
         r+CG9saWTj+dW4a4CK10KopMj/iSLCDlfC6672lE4mRWo6Nl1m8IPVetDb5/P+g7pkOJ
         XwNkA5KdJ1jySOZeFMvLMpvyNWmq2FRyHT4nQH/YrpgORRCgoPNcpyFLSuReQ+iHKEvV
         1PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654680; x=1710259480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1vkV6Sni2i06OF9GaK5ZpbS2xl9biWoyHnzpUvKBKg=;
        b=rfSt+hXMbde/kOAKmM4Yr+ajoNEwDEtI4KtGPSC3S3ZWY+pcdwaUYLPM7f+vp0IQc5
         YnCjPss6dmzTE/G7xKFO5kR2V1zRNFq6WStlzhy99g/8FNNb0SbgV6xYs/UT0ZKGpHC1
         VNlEeaMXezvM8y9yWsdznmx+jGHd04PQrb5KR+6YVAm/gNKkOEmjY/FjJHwtloyoB7QJ
         8keuCQNpfWjZc1kO/BjlV0LHqtpyI+zEA+4178xDmWek7L18XuDrvp1K4n6c+UJajbkt
         2OfguJXXEYAZmuC9rm75trirYCPSUY7CPWsKd93FlGTge5APvgBeDRNYHEx6i8X63cSR
         GJfw==
X-Gm-Message-State: AOJu0YxD3FBemOxGbGls+xRRHc2fzrXNJAtyEyyewZHKQOYeN3d1TsT2
	cW2ATRM+5NH8LP/ZM6UFEaBXuLRHzFa9y+5kZ62HeUxbRktSHuFn+x+N4CSXe2SaLnnPV1qCkFt
	hvab64ELGBg==
X-Google-Smtp-Source: AGHT+IERW3RLs7pAvrtK7+8wenp15EOf0eYUuFkXQS/5Va7zov6earse9wZ2K8Bqz+MSmoFd135jNea/Uk3/DA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:d21:b0:608:1b39:246b with SMTP
 id cn33-20020a05690c0d2100b006081b39246bmr3810484ywb.3.1709654680656; Tue, 05
 Mar 2024 08:04:40 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:11 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-17-edumazet@google.com>
Subject: [PATCH net-next 16/18] ipv6: move tcp_ipv6_hash_secret and
 udp_ipv6_hash_secret to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use a 32bit hole in "struct net_offload" to store
the remaining 32bit secrets used by TCPv6 and UDPv6.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h       | 2 ++
 include/net/protocol.h      | 1 +
 net/ipv6/inet6_hashtables.c | 6 ++----
 net/ipv6/udp.c              | 2 --
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index e4dac2f859efd421b975a61360536af949046d0e..0a0a9106b40030f56b04c1e48083c13498ce0939 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -39,7 +39,9 @@ struct net_hotdata {
 #define inet_ehash_secret	net_hotdata.tcp_protocol.secret
 #define udp_ehash_secret	net_hotdata.udp_protocol.secret
 #define inet6_ehash_secret	net_hotdata.tcpv6_protocol.secret
+#define tcp_ipv6_hash_secret	net_hotdata.tcpv6_offload.secret
 #define udp6_ehash_secret	net_hotdata.udpv6_protocol.secret
+#define udp_ipv6_hash_secret	net_hotdata.udpv6_offload.secret
 
 extern struct net_hotdata net_hotdata;
 
diff --git a/include/net/protocol.h b/include/net/protocol.h
index 213649d2ab098edc4eb9f44a5403540887c2b8ef..b2499f88f8f8199de28555d0cbd6b4523325205b 100644
--- a/include/net/protocol.h
+++ b/include/net/protocol.h
@@ -70,6 +70,7 @@ struct inet6_protocol {
 struct net_offload {
 	struct offload_callbacks callbacks;
 	unsigned int		 flags;	/* Flags used by IPv6 for now */
+	u32			 secret;
 };
 /* This should be set for any extension header which is compatible with GSO. */
 #define INET6_PROTO_GSO_EXTHDR	0x1
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index 0fee97f3166cf8326b3b714ac6bde48ca5188cec..2e81383b663b71b95719a295fd9629f1193e4225 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -26,15 +26,13 @@ u32 inet6_ehashfn(const struct net *net,
 		  const struct in6_addr *laddr, const u16 lport,
 		  const struct in6_addr *faddr, const __be16 fport)
 {
-	static u32 ipv6_hash_secret __read_mostly;
-
 	u32 lhash, fhash;
 
 	net_get_random_once(&inet6_ehash_secret, sizeof(inet6_ehash_secret));
-	net_get_random_once(&ipv6_hash_secret, sizeof(ipv6_hash_secret));
+	net_get_random_once(&tcp_ipv6_hash_secret, sizeof(tcp_ipv6_hash_secret));
 
 	lhash = (__force u32)laddr->s6_addr32[3];
-	fhash = __ipv6_addr_jhash(faddr, ipv6_hash_secret);
+	fhash = __ipv6_addr_jhash(faddr, tcp_ipv6_hash_secret);
 
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
 			       inet6_ehash_secret + net_hash_mix(net));
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 1e1c67a51675e8534a953a6d4d63211388d95ca9..80ad8f436b179d7279cbbd5108c3494a9773c0d8 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -79,8 +79,6 @@ u32 udp6_ehashfn(const struct net *net,
 		 const struct in6_addr *faddr,
 		 const __be16 fport)
 {
-	static u32 udp_ipv6_hash_secret __read_mostly;
-
 	u32 lhash, fhash;
 
 	net_get_random_once(&udp6_ehash_secret,
-- 
2.44.0.278.ge034bb2e1d-goog


