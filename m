Return-Path: <netdev+bounces-78007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF62873B83
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8761A1F27323
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B21361C6;
	Wed,  6 Mar 2024 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1oUnGUy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA58913DBA8
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740871; cv=none; b=rMPMfwOzBbHyeT1hrxJ+tvTDuN/hCO3lOxS5a5JfMUGExlTf4Zcox49/DwIWj6gja1nH6dF+2gfr01z/Slriyx84a9prRqxkKzQQgDY84n6DchGPXmPgXtBfWREoMLGWxXVToeAQqxSTV9vuIaPQ828WJyhXiV+rcluOO/Tfbf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740871; c=relaxed/simple;
	bh=bJ9aOpH+BaxXE35lQxVH4r4D5Eph3o4WWJ9g3/xoPEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BsmGoJYk96dq40EHkxs4RyHZRpHO7jTRRdNMpYYyqyxZswRBMrmeV4kn49AWvZ0l1vc8rx3KmwXm9PmoEeX06/MytfsOP4FxQl7lXEWLnkMvASzREDOUti+jY4soog4+JsJSJE3BcRME5kOjzlXvFacSmBFnPT8/4zUvpvgUkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1oUnGUy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609e2b87a6bso7428017b3.3
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740869; x=1710345669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2R25cjMr9AGnx6ecTXh/eQZ9+fsMiqc+w/JGSBoEK8o=;
        b=W1oUnGUyAGjJbxkxwnf2Ii7uZ7pv2iRNa6y331LZjMOguQlj4qdCTFU+YElBcu8UNY
         yOh8BpWj5LQRqlqdv3zwJMu1ec6vpIo5JHoUAAaxCjq6O6SCFFGKv65Ss5TeQb15o/Px
         gPygoeHDY0WPyF0rKY6AVmSKVyPR3CcnXjpmmPXMG2LvnlOluLtHMHFDgY3flEc/rP6C
         KFscjL3kVFA7PZfgDdYJQZIxZfoJZhrndGnE+yP/AllLV8AD6MkhWAIM3iW8IuyEVycc
         rwWBz0SKfDlsL1xYvLBzyTbwwoYjFHnFnvuaqaqsCXV5KKr60ZpdkiWZPy2ltgeTdA7C
         AFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740869; x=1710345669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2R25cjMr9AGnx6ecTXh/eQZ9+fsMiqc+w/JGSBoEK8o=;
        b=G1q4wxwY2JmwH1MlY+ep8nJLjgktFCJHAukcLTOAx7JRmQjWMRslTGabgGMI1fjtzN
         1jSFl3BiYBzDtWQlyEADIB/7flVBcLPJVbTT3B7MSNMWqV3aMQtLbr6P8u8qvZrvaa2r
         vSKX/0XMJGsQicNnO+7kUH4Rnxgni3JfGD3cHa29G/KKVMrQYA84hiOdiI6WurCktaRF
         1ow688g1NnocqPWDvj76pxmYZjuvu2u92knbzumJWrctqCPnvqNadw87NbABWv9vGyKd
         Sy9rxtOmd6W1aYzPDUHohVz59Pr0tZ2UfClt3K22TeUXOA7zI0U0b9z/A8/iss2KOIrK
         Vcpw==
X-Forwarded-Encrypted: i=1; AJvYcCWaHP9KQ8/1xRKuYnH64t9wY6lpDg/xrUDoUT3d7nZXACeXpehBty0XZIwikOga4L8gwAIeIwJFwGEKMY3DRPVLKP6qV5Jq
X-Gm-Message-State: AOJu0YylzekhitO3eitwfTa0Wsgp4t4iJcsilEY+8sa9N+ioCxu1lDg9
	oLJxYokTSMDJ1eqGG+EbNalj+9476g0pGuqHwi202s3ebsQXmYFYm3xGVp1qUvRWpiFKFe4VRT1
	95EeT+QYLdg==
X-Google-Smtp-Source: AGHT+IGuH/+1sm8gr5pH6TpPwdyBiLAhBdAhs0+TbaxqCAinOgnH+MLmHW+UYQXq106TUoc8dPAXIVL5NDIyaQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:7908:0:b0:609:2cab:1bd7 with SMTP id
 u8-20020a817908000000b006092cab1bd7mr4361436ywc.1.1709740868862; Wed, 06 Mar
 2024 08:01:08 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:29 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-17-edumazet@google.com>
Subject: [PATCH v2 net-next 16/18] ipv6: move tcp_ipv6_hash_secret and
 udp_ipv6_hash_secret to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use a 32bit hole in "struct net_offload" to store
the remaining 32bit secrets used by TCPv6 and UDPv6.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/hotdata.h       | 2 ++
 include/net/protocol.h      | 1 +
 net/ipv6/inet6_hashtables.c | 6 ++----
 net/ipv6/udp.c              | 2 --
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 6d5cd967183a59271da1a27edfee1bc6bf155c1b..b0b847585f7e62245cee81a56b5a252051e07834 100644
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


