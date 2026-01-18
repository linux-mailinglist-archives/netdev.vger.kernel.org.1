Return-Path: <netdev+bounces-250912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE7D398A3
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 18:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D47B300D498
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06BE2FD7A7;
	Sun, 18 Jan 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OItYbhd4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4045A2356A4
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768758743; cv=none; b=O0vTtu0dOPgOGmjgkQu3bjz+DAHp44VP61np0wacgevZY5JvjbUtg/rVByGm8NitA/DhZlvZm3r3P1J502SncF/JfeaEA7YtXKKSWibpEGtHY8rlYiVRrf1gzmU/JnSjhZzZ4oJixb2ROa9Yk+cVvmAf6zPNbsKliiEGWLQ1ZZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768758743; c=relaxed/simple;
	bh=JvvPWf03BqjjfxpGu1rll6Qy9a0hYTuOb7afW/QCjlw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B3cMeD2jC8WfwyUOlvViMPhcyEI/jR/QH/k1S3RFYMBVCEI8J+BovbeCdR+pMVLTAvXQikNauZA9lWZsqu1XUacHaEYoxpy2VOvdwakXQA18OUIKjKy2h4qkXoHVFoEqCwPLq+IIGR8midr+U6M1bnJlU/jL3pw5MLzBFgNsTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OItYbhd4; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a3356a310so81987626d6.3
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768758741; x=1769363541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UcdFdgZnMUhnTh0GRVCbxObJktfLn94EkHan0h262GQ=;
        b=OItYbhd4UoXlPq5EuNLKXuxnMBYtOm4VPqash2UtrWsKysaNQAqGjEjNn1WO+MMxoV
         woZrjJP5CH1l9bWFeIawaFqFAroDAp/Ry1nSZxLmfCeSCfe7AamJNUqqvQnP1yKnzazx
         jeHmeKMuo1UDQ//y0H1p6gd8JnmiN9vD9nSfRA28CuRJYtTHFJaCDUVG1BbTipc6W59M
         ZMF8y/rOFcTXjSD+zV6lE+4h0YlR+fQGoxnpWPAhTLnV8I7BmuOYlPuKK6oJkdOLo+ug
         fe7zUdAjgMzchwxnR0c4EZ1l7YJCszm2Mk4W2BkSJLPP1wraC5Ti18fpIMFetNkuq4VT
         CyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768758741; x=1769363541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcdFdgZnMUhnTh0GRVCbxObJktfLn94EkHan0h262GQ=;
        b=scMzuRMgb+KgOA9ynHPk3j5WJiNEAeUeLlZqo/cXmnqb+/65R08VoV/KVWJwAS6Kyu
         Igr+cJzNO1HrMN7Lv/Pswx1PMmQPei89je4DN14k5Y9gMLXDSG3zWiKZgICzZyMJOBUq
         UOErW/UlyuvqRh4ul+SjZVuIjMbJ9JuAMavk7uJTaCZEbkMZ1Cqmx51lAUdWccQz8dYT
         PydFHuBYj0edxIErXcaQqoKlq1X9QFi8csVGquo9mL/BrS1/vnMikU7HUrIKdCAPCyII
         qwRXxSjgjmSDDc4bu1MZIj9UOwkFLdUGranyqy/dXWK0fkcG4RJ2QtDBRvaUOMavmPNv
         n/ww==
X-Forwarded-Encrypted: i=1; AJvYcCV4pKWsXfUXiDED4uJcBPm1nS17tthayzogHFq5LRjOUI79bnZ5klM9o7HgBql+FzPrtJEqdu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEqkrzz1Fje86kM6rH4B8wfW7HLV3r1l6QNybxMKEV3MZqU/bZ
	tBWWsECcc6CKKBaLjQboQaWZOxcQ5P3kQG/nPum5WlcjL0dVqyMBlE+sYR9ZIBvAtkFpKOEBLjR
	aVuA9u8AA0AVz2w==
X-Received: from qvbrh24.prod.google.com ([2002:a05:6214:4f18:b0:892:7301:399e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5bef:0:b0:888:4938:49e6 with SMTP id 6a1803df08f44-8942ddc1868mr148642296d6.70.1768758741136;
 Sun, 18 Jan 2026 09:52:21 -0800 (PST)
Date: Sun, 18 Jan 2026 17:52:14 +0000
In-Reply-To: <20260118175215.2871535-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260118175215.2871535-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260118175215.2871535-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] gro: inline tcp6_gro_receive()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
 include/net/gro.h        |  3 +--
 include/net/tcp.h        |  1 -
 net/ipv6/Makefile        |  2 +-
 net/ipv6/ip6_offload.c   | 22 +++++++++++++---------
 net/ipv6/tcpv6_offload.c | 10 ++++------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index b65f631c521d7d9741ef86781add0038c9ce4055..85e5eeed4c90feef9440c57af9382b0e9ead1219 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -405,8 +405,7 @@ INDIRECT_CALLABLE_DECLARE(struct sk_buff *udp4_gro_receive(struct list_head *,
 							   struct sk_buff *));
 INDIRECT_CALLABLE_DECLARE(int udp4_gro_complete(struct sk_buff *, int));
 
-INDIRECT_CALLABLE_DECLARE(struct sk_buff *udp6_gro_receive(struct list_head *,
-							   struct sk_buff *));
+struct sk_buff *udp6_gro_receive(struct list_head *, struct sk_buff *);
 INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int));
 
 #define indirect_call_gro_receive_inet(cb, f2, f1, head, skb)	\
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 15f9b20f851fe322f4417ff403c3965436aa3f9f..3b94c84888a884d9ca8eb602ad1f7d4f941f3ef9 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2327,7 +2327,6 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
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


