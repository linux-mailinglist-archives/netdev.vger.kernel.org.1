Return-Path: <netdev+bounces-99887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D58D6D5E
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 03:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCBE1F21DC0
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 01:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD8224DC;
	Sat,  1 Jun 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RILy/egF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0479221362
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717206184; cv=none; b=HOvpi5UP7cN6YXkr/NH6U7kWJ1JsiwoLMb4DWvfWvV0fEo3n1RBIKPJwbdS1yRSOXLyNjwVO62nPleAxpYYijWdriCqTmPEdl4x8La0EaEbxRHvcg67yBqFCBXngr1M88g+pGlVENVap0/XlWRVPuyRu9OovpJolEqTIS6ey3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717206184; c=relaxed/simple;
	bh=8vUlbvEH7gTZvH1D61OBJNrvJ28CeUyHOjmFolkGer4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5DnyJ1GRk4AWha6VVIwMONBbw+JVyBn4DjQ0xrj0JBwFDIC9JEUweQONwlg/wfTonq9iYyjbO/dyXAC3d32arP3yGjeNrvGM2w+P9aFzrVi9bOPaqXtu6O/X/V7bIAOnZYpKJUFBeid7/6ChAR9NxMa7P/dcbmxgIRvVGJj54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RILy/egF; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-62a2424ed01so27975757b3.1
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1717206181; x=1717810981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2xdFUxWobdQwEfx7YLKH85Utfki6HaKV/+RpyucODI=;
        b=RILy/egFZdUJ5NO8K+QHWKFHGDB9ns+IJtwcOqMfJCHojQo8GWz6eereq+V3ZdX7n/
         VzyJ1nkcFK37h085zjQomjfjsnchbiREb2IknrJMRwHcctmrbbk7rYwV78yO9QcF+Gf9
         /LK8Ap9Pl4eCthhlRVdrbrH2tBT9njfgJYePH5Yr6frADthoxyW13zUFL7Xkd0rsoNEg
         cibX84nrINkVH1JYpeJLuNKN3XVgYWm9kHZjxXsywhImWa94zRBiwkCMMCmf2hbzmvS5
         w04hC3eB3QeHWL6ODMD00ltPOwrnuivceOsPXHQ93LO9ullid1CAY7uik0T0UM3rF2vg
         Pu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717206181; x=1717810981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2xdFUxWobdQwEfx7YLKH85Utfki6HaKV/+RpyucODI=;
        b=i9uqxO8+urbT8JsCMlUEApmRnl0xappgZrusKi/fVLSCW5bqoTTYWBFrAK5iv7x8sI
         cWr0TWtan9C4/x5WEKH77YBZH8jV2R0+r7ZLqkjHnkkGioM6+MkDOv9nLG4aJ7Bl0aK/
         ZssWJ7LepAExR4aCKpW89wLiPZisJXk+Hy6Ti8V0U4flu2uxX75IZ2vjsH72iI/QSNzl
         DJRV4hnLeBiXHVLcVrl2B++L2O4vXXOk9rvzSQ1p7jxSRIp3D/Fobi+DtvEsImxm2n7l
         G2Qw+pwcdBSfPqjCJ9sKw+pNBdRW1R3PVZKMFkAh20CA5GYkiaEsypV2NrAhlf6dWhXc
         r47w==
X-Gm-Message-State: AOJu0YzdvPir075fCvXMURX1EQxpcvDMpC49xJ7W+u2Fe5IHjVAdjEl4
	evRforqA2KOkAwn884JHYwcQE2TjFELRZJDka9rYjQC2vmsq/yMMszcTiFFe5At8SKvaFh+e9x5
	gO8I=
X-Google-Smtp-Source: AGHT+IEjR0Ljn4HhOxXhAh7n33Q2xIPS6LzvX1WnMQFcShl7OzOwraUD/JRB815GeeImrjbnCz0LRg==
X-Received: by 2002:a0d:cb81:0:b0:622:cc0d:62c3 with SMTP id 00721157ae682-62c7971cbcemr36155437b3.28.1717206180717;
        Fri, 31 May 2024 18:43:00 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f9b::18e:1c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c7667cad3sm5394697b3.87.2024.05.31.18.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 18:43:00 -0700 (PDT)
Date: Fri, 31 May 2024 18:42:58 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Mina Almasry <almasrymina@google.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Howells <dhowells@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [RFC v2 net-next 6/7] udp: use sk_skb_reason_drop to free rx packets
Message-ID: <76cb47137dc232e88a0707d1d863749c5f35ec89.1717206060.git.yan@cloudflare.com>
References: <cover.1717206060.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717206060.git.yan@cloudflare.com>

Replace kfree_skb_reason with sk_skb_reason_drop and pass the receiving
socket to the tracepoint.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/udp.c | 10 +++++-----
 net/ipv6/udp.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 189c9113fe9a..ecafb1695999 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2074,7 +2074,7 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		kfree_skb_reason(skb, drop_reason);
+		sk_skb_reason_drop(sk, skb, drop_reason);
 		return -1;
 	}
 
@@ -2196,7 +2196,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 drop:
 	__UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	atomic_inc(&sk->sk_drops);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return -1;
 }
 
@@ -2383,7 +2383,7 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		   int proto)
 {
-	struct sock *sk;
+	struct sock *sk = NULL;
 	struct udphdr *uh;
 	unsigned short ulen;
 	struct rtable *rt = skb_rtable(skb);
@@ -2460,7 +2460,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	 * Hmm.  We got an UDP packet to a port to which we
 	 * don't wanna listen.  Ignore it.
 	 */
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 
 short_packet:
@@ -2485,7 +2485,7 @@ int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 drop:
 	__UDP_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return 0;
 }
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c81a07ac0463..b56f0b9f4307 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -673,7 +673,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
-		kfree_skb_reason(skb, drop_reason);
+		sk_skb_reason_drop(sk, skb, drop_reason);
 		return -1;
 	}
 
@@ -776,7 +776,7 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 drop:
 	__UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 	atomic_inc(&sk->sk_drops);
-	kfree_skb_reason(skb, drop_reason);
+	sk_skb_reason_drop(sk, skb, drop_reason);
 	return -1;
 }
 
@@ -940,8 +940,8 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct in6_addr *saddr, *daddr;
 	struct net *net = dev_net(skb->dev);
+	struct sock *sk = NULL;
 	struct udphdr *uh;
-	struct sock *sk;
 	bool refcounted;
 	u32 ulen = 0;
 
@@ -1033,7 +1033,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP6_INC_STATS(net, UDP_MIB_NOPORTS, proto == IPPROTO_UDPLITE);
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_PORT_UNREACH, 0);
 
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return 0;
 
 short_packet:
@@ -1054,7 +1054,7 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 	__UDP6_INC_STATS(net, UDP_MIB_CSUMERRORS, proto == IPPROTO_UDPLITE);
 discard:
 	__UDP6_INC_STATS(net, UDP_MIB_INERRORS, proto == IPPROTO_UDPLITE);
-	kfree_skb_reason(skb, reason);
+	sk_skb_reason_drop(sk, skb, reason);
 	return 0;
 }
 
-- 
2.30.2



