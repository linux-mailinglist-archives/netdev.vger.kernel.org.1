Return-Path: <netdev+bounces-250914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E846DD398A4
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 18:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5889301671C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 17:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ADB2FE076;
	Sun, 18 Jan 2026 17:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mut56NO2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9092FD68A
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768758745; cv=none; b=KVvNr9084y0bs6elsNY17GsUUZQtQ9wcQjfmj7g19mdscysAJkioJ4em3OBUOA7yxLnBEe+0JjMxiHFA+pCe97zqDzw+jdDxQ4c5jGvMIdv6aQ0ZhmLK1F4ZGo/5yhl7yJ+uZl3HvHCePubLtlHzvDl8HgHigPAnc0oDLiAupPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768758745; c=relaxed/simple;
	bh=ZSEYJfNmWgWRTF5in8x4hDmXyDIqyYg3oFGW/t1OciA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SXRI2nnAOeLB2QTwc5Q6WJo0ChvqhRMu0WTCPso2FTzR3+eNVc5H4AvCyUBx8n1NPlYq80vbjuKHcSkSZAEykDS3wO5D/YvR5eWyvZV6Regsi9sbrEvWfirhJfYN87nh8P3jCxCfF24ta2i/wsxlCfyeD861tTCmW8f+OI17QII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mut56NO2; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8905883e793so106394116d6.2
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768758743; x=1769363543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MdCDqQFypvh6z/BKdgDwVFZ5Er2kcF+Ytj1Q4p5tEng=;
        b=Mut56NO2KTO8WWDJirLxFdxt+/H11tp1I7jxnlCpngkOhxO3s/078eOHw2riUXSt4r
         9li6fkIrrVp8pCiZCmDtuJsrXCOLHyAG1SXF7q7F9zUM+JpOVHQZuUuzB6uo1/p1kKHB
         nY5WQpxevHhver5aSL1wSb4ByIBGx6+DB86+E7MM2SLlEw5NIBAk9yh6UzhWI8UhUzw6
         BSwhwo+M3cEVZ17qeEpaV/GxFcB8/qdIZNnuxWutwRPPLKzjSx8rAlMMsRQhbgSzZqX2
         XCeGbS/DwDAjrcSlCHcUHSlnO6d+4fWjbdbQ+yBozbpamIUXVu7qdeeCqQK2P0pS2Nl5
         tMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768758743; x=1769363543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdCDqQFypvh6z/BKdgDwVFZ5Er2kcF+Ytj1Q4p5tEng=;
        b=t7djawYzeHfxhu3K7CJo9aKUdsHgWJJaqiYocdcAr8AHn2zd1iaI9doj3SkV8qWZbP
         xxmgTyLw7bYJorMFX+4EvJu3tRHwvLv0dWkjLEWK4TJlCC2LsNXhFRSKhYJ8x7fR2lIj
         Hvr4EW4K/UhRYVpTMFbdKD3XJC9Gyrbo5t4kqKPatBJbwCozhtRAiBCLHLnqIrQgbk7x
         BEzE2QfUQ5p4NtI1qSI/q6MZpiAk5TX1o3p/RZV6fLnHuXYTYIRC+/2DPfdB4bl420Y3
         cDK3uKDfpYj/hDzns5xfJdqPc8rz82Ff+hKNIisEZTQ4nJZ+e23mg/7CYHH34nh78Q3c
         0hnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF78M3VvfHhylDCHXfFfWvSB6ItVlnWBP4g496fFmMutjGyDZD5YhbuCVx5JDjd4hSCTrezjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR91U/6aVKG7j9ZWB4gN9znoeSHewoEPj9AKVRkAJFYMBegGyc
	owGsrjIS6Qa0asKVBzIsnHZ8HVaA/vVMqiNuEMwU2RhkJuUBqOylWJh0ExmUa74p/xfIeInohoA
	kLHL21V7D3m8/gw==
X-Received: from qvboi7.prod.google.com ([2002:a05:6214:43c7:b0:882:2f2f:9fe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:4ea7:0:b0:88a:2444:36e1 with SMTP id 6a1803df08f44-8942dde4516mr128361006d6.62.1768758742637;
 Sun, 18 Jan 2026 09:52:22 -0800 (PST)
Date: Sun, 18 Jan 2026 17:52:15 +0000
In-Reply-To: <20260118175215.2871535-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260118175215.2871535-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260118175215.2871535-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] gro: inline tcp6_gro_complete()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Remove one function call from GRO stack for native IPv6 + TCP packets.

$ scripts/bloat-o-meter -t vmlinux.2 vmlinux.3
add/remove: 0/0 grow/shrink: 1/1 up/down: 298/-5 (293)
Function                                     old     new   delta
ipv6_gro_complete                            435     733    +298
tcp6_gro_complete                            311     306      -5
Total: Before=22593532, After=22593825, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/gro.h        |  2 +-
 include/net/tcp.h        |  1 -
 net/ipv6/ip6_offload.c   | 21 +++++++++------------
 net/ipv6/tcpv6_offload.c |  2 +-
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 85e5eeed4c90feef9440c57af9382b0e9ead1219..2300b6da05b2728ec40f42228f8fa9c195d8479c 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -406,7 +406,7 @@ INDIRECT_CALLABLE_DECLARE(struct sk_buff *udp4_gro_receive(struct list_head *,
 INDIRECT_CALLABLE_DECLARE(int udp4_gro_complete(struct sk_buff *, int));
 
 struct sk_buff *udp6_gro_receive(struct list_head *, struct sk_buff *);
-INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int));
+int udp6_gro_complete(struct sk_buff *, int);
 
 #define indirect_call_gro_receive_inet(cb, f2, f1, head, skb)	\
 ({								\
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3b94c84888a884d9ca8eb602ad1f7d4f941f3ef9..ebdf59d435b8002ca9b90803f40720a58ce3e809 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2326,7 +2326,6 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
 				struct tcphdr *th);
 INDIRECT_CALLABLE_DECLARE(int tcp4_gro_complete(struct sk_buff *skb, int thoff));
 INDIRECT_CALLABLE_DECLARE(struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb));
-INDIRECT_CALLABLE_DECLARE(int tcp6_gro_complete(struct sk_buff *skb, int thoff));
 #ifdef CONFIG_INET
 void tcp_gro_complete(struct sk_buff *skb);
 #else
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 4d96154c0dcd019322908ab6ddaa663a2a565e44..32a104ead8760d33e152e0b0a6a6896d70d155b5 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -21,16 +21,6 @@
 #include "ip6_offload.h"
 #include "tcpv6_offload.c"
 
-/* All GRO functions are always builtin, except UDP over ipv6, which lays in
- * ipv6 module, as it depends on UDPv6 lookup function, so we need special care
- * when ipv6 is built as a module
- */
-#if IS_BUILTIN(CONFIG_IPV6)
-#define INDIRECT_CALL_L4(f, f2, f1, ...) INDIRECT_CALL_2(f, f2, f1, __VA_ARGS__)
-#else
-#define INDIRECT_CALL_L4(f, f2, f1, ...) INDIRECT_CALL_1(f, f2, __VA_ARGS__)
-#endif
-
 static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
 {
 	const struct net_offload *ops = NULL;
@@ -383,11 +373,18 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 	}
 
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
+
+	if (likely(ops == &net_hotdata.tcpv6_offload))
+		return tcp6_gro_complete(skb, nhoff);
+#if IS_BUILTIN(CONFIG_IPV6)
+	if (ops == &net_hotdata.udpv6_offload)
+		return udp6_gro_complete(skb, nhoff);
+#endif
+
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
 
-	err = INDIRECT_CALL_L4(ops->callbacks.gro_complete, tcp6_gro_complete,
-			       udp6_gro_complete, skb, nhoff);
+	err = ops->callbacks.gro_complete(skb, nhoff);
 
 out:
 	return err;
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 7f19ce423058870f285b7f8ae2a4d116d783f9fb..46fa2069d321663ed232e2836db77e3fcb1f4f07 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -67,7 +67,7 @@ static __always_inline struct sk_buff *tcp6_gro_receive(struct list_head *head,
 	return NULL;
 }
 
-INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
+static __always_inline int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
-- 
2.52.0.457.g6b5491de43-goog


