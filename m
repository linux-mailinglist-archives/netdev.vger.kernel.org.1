Return-Path: <netdev+bounces-250565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4200D33386
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9BBA30B3E07
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8D2339B45;
	Fri, 16 Jan 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNXcwImc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840D1DFD96
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 15:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577405; cv=none; b=Xo73UHvoUpSmVVtShX3Vw4L2MiPyQt6zYJnkQkBus/pQCZrec7wbUGgIzdQwAU3Te8dKxKfYYkcW4uiLHXedRMTPKJZIIeCLiXsfWXAbCM+8+yLRrCGJ1f7vfimoRPMbZuazkPIZE9X6DyH6HhqeclfyCOf1u80+MiQ3GwAymcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577405; c=relaxed/simple;
	bh=LCTVYqaCCG78ot6iRtA0amYATw0MxXXYSR+5Lz51C/c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oA1norktY1UU9fEiGHWLaErzjnh8OXyd5lzGciTweaAZeMmi2VHCb8tNXrMhB038xOqXymXXJ09jxJMkJ3EdMyLmzg5u4Mh/R9pgkjbtLfRncbbC1l5bWPiJBn8NTJfep566fFEiSruEJca+GPJCAmfMRSU8TONvh2b6bOJKXjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNXcwImc; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c5329ed28bso515893485a.2
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768577403; x=1769182203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ib/9I72/m9FB5+XGnZPcj3VcBreFFJMN7uw6Ia/BRg=;
        b=jNXcwImchmhkgcZZQlwAqDUm6fZHKQMsVcFoIqoSQU24ylMKv/T5NlH87hefAczfvD
         rpUdehiDxctKBSK7bqGlqDFSL/elSi0Kz1lkofObVEldOkfdzSIflKlvEjyhhhpmWExx
         C8t6eZJDdDxxOdlVqC5LLZnQk7sUwwT+k1AkC7j/MLqQ4RzS08i3ncy41lKlvjD4GC3+
         1AO75gdch537wmI5lizvwM2FKwf/xRo2ltkIJnOjVC3mcKHTU6zEf48VmWHf0eMV01kX
         bKT7mp4aT6PqwjBSNAvQ3PzM5sEobc0Qrg0ow7U7cooHzeDe9VT3W8qyfBbjG/a4N7MM
         OPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768577403; x=1769182203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ib/9I72/m9FB5+XGnZPcj3VcBreFFJMN7uw6Ia/BRg=;
        b=h/3Ak+ApB0jxOSFbrSP41MgyBOoLKvzplJ2phS0zrwOdomh6zx7t1/Kj9j8DqG7+Aa
         86hUFD0U5XyeaqWgGKa93PvohDwnAOwSapvNJAiV3aa6U2HVEG+KRCUCCLP5+MbPuUiu
         4tr7zPBT1YyLFNFaeHzXxrqnCW+WboEVJ/2HXBWLTtUHAudWVHQR5T/KTAHEDBG23C3d
         1TjvKd9OzhSCyu5g2W8zd1Te0ZtjI2O9/4QeFU+WPQO+bvq6hi+aBIW2AFUJLJQVGuBF
         hgsMfWikFczWh04InR3jSp0CWpVKyekIgsRu4uwwZMHB/aNwtvKuWuGfAeWPvJ2mGuGF
         Uv7w==
X-Forwarded-Encrypted: i=1; AJvYcCVTYz+NPNKlYxIvl0TPbxd9Szic21Z7IJXPWGE7/yB/OTfgi38gBnCmBR7jxHEk1Sxg1KwveNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx05q+SGu/OvOu4VTeWT7O3l+dGmWRXQanopr+rzYnDWGy8aLn
	QcqwXje27CtwvL/de/p83AB4zbh0wJgXB6bPJvwMBC6TkZLS14ZiS4+wCbcaUsnZrvkzvewtZsZ
	29vfoCyphBMmEJg==
X-Received: from qkpb2.prod.google.com ([2002:a05:620a:2702:b0:8c5:340d:d103])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4049:b0:8aa:36b9:8056 with SMTP id af79cd13be357-8c6a67649c8mr445348285a.41.1768577402924;
 Fri, 16 Jan 2026 07:30:02 -0800 (PST)
Date: Fri, 16 Jan 2026 15:29:56 +0000
In-Reply-To: <20260116152957.1825626-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260116152957.1825626-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260116152957.1825626-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] gro: inline tcp6_gro_receive()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

FDO/LTO are unable to inline tcp6_gro_receive() from ipv6_gro_receive()

Make sure tcp6_check_fraglist_gro() is only called only when needed,
so that compiler can leave it out-of-line.

$ scripts/bloat-o-meter -t vmlinux.1 vmlinux.2
add/remove: 2/0 grow/shrink: 3/1 up/down: 1123/-253 (870)
Function                                     old     new   delta
ipv6_gro_receive                            1069    1846    +777
tcp6_check_fraglist_gro                        -     272    +272
ipv6_offload_init                            218     274     +56
__pfx_tcp6_check_fraglist_gro                  -      16     +16
ipv6_gro_complete                            433     435      +2
tcp6_gro_receive                             959     706    -253
Total: Before=22592662, After=22593532, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h        |  1 -
 net/ipv6/Makefile        |  2 +-
 net/ipv6/ip6_offload.c   | 22 +++++++++++++---------
 net/ipv6/tcpv6_offload.c | 10 ++++------
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index ef0fee58fde82620399df49a35c7ecae8e34068e..2a7744de226ed0a378719fd60fa2a3830bef2e7e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2328,7 +2328,6 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb));
 INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb, int thoff));
-INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb));
 #ifdef CONFIG_INET
 void tcp_gro_complete(struct sk_buff *skb);
 #else
diff --git a/net/ipv6/Makefile b/net/ipv6/Makefile
index d283c59df4c1c421bc043056fe11e5437cc4aece..0492f1a0b4918ada8c56cf649fbec04c7114863a 100644
--- a/net/ipv6/Makefile
+++ b/net/ipv6/Makefile
@@ -45,7 +45,7 @@ obj-$(CONFIG_IPV6_FOU) += fou6.o
 
 obj-y += addrconf_core.o exthdrs_core.o ip6_checksum.o ip6_icmp.o
 obj-$(CONFIG_INET) += output_core.o protocol.o \
-			ip6_offload.o tcpv6_offload.o exthdrs_offload.o
+			ip6_offload.o exthdrs_offload.o
 
 obj-$(subst m,y,$(CONFIG_IPV6)) += inet6_hashtables.o
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index fce91183797a60fcbf271c73e086aeb0aa9d40c6..4d96154c0dcd019322908ab6ddaa663a2a565e44 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -19,6 +19,7 @@
 #include <net/gso.h>
 
 #include "ip6_offload.h"
+#include "tcpv6_offload.c"
 
 /* All GRO functions are always builtin, except UDP over ipv6, which lays in
  * ipv6 module, as it depends on UDPv6 lookup function, so we need special care
@@ -30,13 +31,6 @@
 #define INDIRECT_CALL_L4(f, f2, f1, ...) INDIRECT_CALL_1(f, f2, __VA_ARGS__)
 #endif
 
-#define indirect_call_gro_receive_l4(f2, f1, cb, head, skb)	\
-({								\
-	unlikely(gro_recursion_inc_test(skb)) ?			\
-		NAPI_GRO_CB(skb)->flush |= 1, NULL :		\
-		INDIRECT_CALL_L4(cb, f2, f1, head, skb);	\
-})
-
 static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
 {
 	const struct net_offload *ops = NULL;
@@ -298,9 +292,19 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 
 	skb_gro_postpull_rcsum(skb, iph, nlen);
 
-	pp = indirect_call_gro_receive_l4(tcp6_gro_receive, udp6_gro_receive,
-					 ops->callbacks.gro_receive, head, skb);
+	if (unlikely(gro_recursion_inc_test(skb))) {
+		flush = 1;
+		goto out;
+	}
 
+	if (likely(proto == IPPROTO_TCP))
+		pp = tcp6_gro_receive(head, skb);
+#if IS_BUILTIN(CONFIG_IPV6)
+	else if (likely(proto == IPPROTO_UDP))
+		pp = udp6_gro_receive(head, skb);
+#endif
+	else
+		pp = ops->callbacks.gro_receive(head, skb);
 out:
 	skb_gro_flush_final(skb, pp, flush);
 
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index effeba58630b5ac2593b824bd8fc10a473954b6c..7f19ce423058870f285b7f8ae2a4d116d783f9fb 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -24,9 +24,6 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 	struct net *net;
 	int iif, sdif;
 
-	if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
-		return;
-
 	p = tcp_gro_lookup(head, th);
 	if (p) {
 		NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
@@ -45,8 +42,8 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
 #endif /* IS_ENABLED(CONFIG_IPV6) */
 }
 
-INDIRECT_CALLABLE_SCOPE
-struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
+static __always_inline struct sk_buff *tcp6_gro_receive(struct list_head *head,
+							struct sk_buff *skb)
 {
 	struct tcphdr *th;
 
@@ -60,7 +57,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 	if (!th)
 		goto flush;
 
-	tcp6_check_fraglist_gro(head, skb, th);
+	if (unlikely(skb->dev->features & NETIF_F_GRO_FRAGLIST))
+		tcp6_check_fraglist_gro(head, skb, th);
 
 	return tcp_gro_receive(head, skb, th);
 
-- 
2.52.0.457.g6b5491de43-goog


