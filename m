Return-Path: <netdev+bounces-216918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCA0B35FAA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDEE1BA4DBE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939431EA7FF;
	Tue, 26 Aug 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/EfgVXZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7FEEAB
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212646; cv=none; b=dmyVmbQopiYEvcdycyuYntbXBuqZmG3XDIhUC0B5+spS0da5wzecEM32s6sW060ZI+fE4S055E05sTiZ31btTDr7M3Wbtj7elckAAMcmKg54FteYv64q2rsCMQ/oGHEi7VrVaPxjahm/lxC+dWR5TTTEJvyAPBBvXnq9S60/B3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212646; c=relaxed/simple;
	bh=GAWuNDqaRl/oJt8Byf6TR4d2f+Xlo6ShVd8d87nAmS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYbgq1gC3wDJPG7ge6gwYuJFG46hQi91gJNCspW7K/bkl8sabG6dvPLFO/naVpPcS3KpfOOu49HzxDQn8BvEsycnN6hAslvPOTY/0oeJWOGQ3cts5SVZKkUjlO4VR8XPvGE3nr/Uu3DWEGKP+5mcAleG62u8jI7x4HLzcMl7eko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/EfgVXZ; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e8704d540cso599140485a.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756212644; x=1756817444; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cyb13O7OCTXLMlwuqHUCrLToPlRopPV/XtYy55Y2upw=;
        b=D/EfgVXZ9AznZUQE48ZnqwwloY0obA9fwficEORab6tDBbU7Rhv0fiTioVrq/LdAPp
         GghoAfm9i7FrVye1vZ+/uyiEJZz0CMyfeZpxYxtua1CBVIz0GMS4J4TYCVF4LOe1AbA/
         2+cvKzldc25TQMeBln5Rm9Ep/rtIfAdDicECXnvR+4jcVJPbowUIQFAwMp/Gva3amhrK
         UO0BVw9lRL/tRcSd9pnbSZKUfLx9/3JwJAKQIL6Y6PFklSbRokpS6o0p1aM4VW+hIRmg
         WqIFRZ5/8l0+u0j78jOn+67J6xev6vS/aoNPhXtB6iEIRXlIqGrKxQn388ubo/mdTV7q
         5Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212644; x=1756817444;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cyb13O7OCTXLMlwuqHUCrLToPlRopPV/XtYy55Y2upw=;
        b=Ie2zK9eHaKxeHKUaQ0M7XuSAoFbmw7AddEJWPO14J6f6IHeKTP5NJ0X9A8dX+8DYdV
         yxpJkvXnb40aoLKye0Y+TkYhoHb9wnCjF91lY58IYNCWs/KjWCff1G9Yzpv8Mb4TjB9h
         BRsE6IHcNsgKg8sGYMQVRCEI+UeZ2Zw1AjIoQI+AZeRfotNeoVEVxfx3tMeTbmQ3gbf5
         VpL7eUpk/2gabfvd3RogrJJXvmHV/43g+rQ8NFE4wzK2Uk/gpPW920Y35zOGf9exSRJB
         XqQX/pjwHrQrVkEOSyBaiHHul0lF8aX+PML/+B8q2U4JYWGpYos5YwOD/qkNh+Ptzfkn
         uymA==
X-Forwarded-Encrypted: i=1; AJvYcCV7HrjlNa1DVc6V42YYt2NuWUgkpha+dH3KL+rEn6y9XkwsROQC7djqYB7senUFReDCUSMU3mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3ISB+9Winz/HNlnDcOciu7uJOAkWuyorShxT2SaSvvktzqUO
	4U/OwAkJftl6jMv1rqcQvRvmHw87iOFRlD8KWghL1ohNysTwx493E29tGCVWHa0y08I8nbOL2VU
	HXWJWZMfBbQ74pQ==
X-Google-Smtp-Source: AGHT+IERsf9f1st0cDHrD5Z6hZJ+dMPcv3BN5CJZdNqHC9hWcrRPjnlv7AeHDqwWNt2SQqD8G9ES1xBV3xOBMg==
X-Received: from qvbbu18.prod.google.com ([2002:ad4:55f2:0:b0:70d:ad11:c925])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:4a83:b0:70d:dade:c35f with SMTP id 6a1803df08f44-70ddadec912mr4062896d6.59.1756212643808;
 Tue, 26 Aug 2025 05:50:43 -0700 (PDT)
Date: Tue, 26 Aug 2025 12:50:30 +0000
In-Reply-To: <20250826125031.1578842-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826125031.1578842-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826125031.1578842-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/5] udp: add drop_counters to udp socket
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

When a packet flood hits one or more UDP sockets, many cpus
have to update sk->sk_drops.

This slows down other cpus, because currently
sk_drops is in sock_write_rx group.

Add a socket_drop_counters structure to udp sockets.

Using dedicated cache lines to hold drop counters
makes sure that consumers no longer suffer from
false sharing if/when producers only change sk->sk_drops.

This adds 128 bytes per UDP socket.

Tested with the following stress test, sending about 11 Mpps
to a dual socket AMD EPYC 7B13 64-Core.

super_netperf 20 -t UDP_STREAM -H DUT -l10 -- -n -P,1000 -m 120
Note: due to socket lookup, only one UDP socket is receiving
packets on DUT.

Then measure receiver (DUT) behavior. We can see both
consumer and BH handlers can process more packets per second.

Before:

nstat -n ; sleep 1 ; nstat | grep Udp
Udp6InDatagrams                 615091             0.0
Udp6InErrors                    3904277            0.0
Udp6RcvbufErrors                3904277            0.0

After:

nstat -n ; sleep 1 ; nstat | grep Udp
Udp6InDatagrams                 816281             0.0
Udp6InErrors                    7497093            0.0
Udp6RcvbufErrors                7497093            0.0

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/udp.h                               | 1 +
 include/net/udp.h                                 | 1 +
 tools/testing/selftests/bpf/progs/bpf_iter_udp4.c | 3 ++-
 tools/testing/selftests/bpf/progs/bpf_iter_udp6.c | 4 ++--
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 4e1a672af4c57f01d10dde906b2114327387ca73..981506be1e15ad3aa831c1d4884372b2a477f988 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -108,6 +108,7 @@ struct udp_sock {
 	 * the last UDP socket cacheline.
 	 */
 	struct hlist_node	tunnel_list;
+	struct socket_drop_counters drop_counters;
 };
 
 #define udp_test_bit(nr, sk)			\
diff --git a/include/net/udp.h b/include/net/udp.h
index 7b26d4c50f33b94507933c407531c14b8edd306a..93b159f30e884ce7d30e2d2240b846441c5e135b 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -288,6 +288,7 @@ static inline void udp_lib_init_sock(struct sock *sk)
 {
 	struct udp_sock *up = udp_sk(sk);
 
+	sk->sk_drop_counters = &up->drop_counters;
 	skb_queue_head_init(&up->reader_queue);
 	INIT_HLIST_NODE(&up->tunnel_list);
 	up->forward_threshold = sk->sk_rcvbuf >> 2;
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
index ffbd4b116d17ffbb9f14440c788e50490fb0f4e0..23b2aa2604de2fd0b8075c9b446230125961ae8c 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
@@ -64,7 +64,8 @@ int dump_udp4(struct bpf_iter__udp *ctx)
 		       0, 0L, 0, ctx->uid, 0,
 		       sock_i_ino(&inet->sk),
 		       inet->sk.sk_refcnt.refs.counter, udp_sk,
-		       inet->sk.sk_drops.counter);
+		       udp_sk->drop_counters.drops0.counter +
+		       udp_sk->drop_counters.drops1.counter);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
index 47ff7754f4fda4c9db92fbf1dc2e6a68f044174e..c48b05aa2a4b2a008b0e2dcc1d97dc84d67aff68 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
@@ -72,7 +72,7 @@ int dump_udp6(struct bpf_iter__udp *ctx)
 		       0, 0L, 0, ctx->uid, 0,
 		       sock_i_ino(&inet->sk),
 		       inet->sk.sk_refcnt.refs.counter, udp_sk,
-		       inet->sk.sk_drops.counter);
-
+		       udp_sk->drop_counters.drops0.counter +
+		       udp_sk->drop_counters.drops1.counter);
 	return 0;
 }
-- 
2.51.0.261.g7ce5a0a67e-goog


