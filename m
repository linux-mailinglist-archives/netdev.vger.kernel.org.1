Return-Path: <netdev+bounces-251564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB8qNWnKb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:33:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A94874983F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 838F562D160
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A534D3AA;
	Tue, 20 Jan 2026 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kDDDBB2U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A65134CFBE
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927754; cv=none; b=dj8wAA8Xg2eicoVqTNd9eoUYHhK/W7Fn668y1pifhvb4UCMz+R+D3qIx5JM1cOMDaehaSFixVjsA8eDDJWz3UtzlAaw/oVVZlBa+Jte/ZZY22GbD/KFdoTwXVGiCO4rG/QYAMUcT0XIWqUr4Ay84u30mlllwIJxmnkz572Hi7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927754; c=relaxed/simple;
	bh=PHbaW4hewM36q0sswR179GZ7BLXMzCt76EYAufFdrfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ir+zT/rXnKsVPY9TJMJhaRVgOwqsmai8J8blJjGUeK0vPR5FNMhDl2cTfy8OXyxPD+DYHF+l+GYyuy7gJLfDn7q0N4tM1QZFxlSQ4GM4afWjVFABnl3sH2hv5gKT1UxquOWEAeRsHJjjgjmZo19rtuckgWld+9cNDpSACOQL0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kDDDBB2U; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-6465127c7fcso7235009d50.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768927751; x=1769532551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mYEReVCPXmTD8QgwZzRjHyvsdnUJkU6KY0UFy4cFcY=;
        b=kDDDBB2U7KzLAFaLgqKhT35Is5ZyP5FA89NJtRmTAphm4YmgrIBp/rx1ItFEwVnda0
         TZPIpjv14e1GUHk+pxOSc0Z54VuAxxd5N7hknokzzkSq7yUh9Ob1cqsbDa4HR9IU9YFm
         8UmbelGlwUYlMEWOwYREIuXyZlpXRfBX75hcOMheduxqqOMulY9LBAu+R1SCnzn9NVSN
         dYBcRzTAV4wQXwAOysWCe0GjM/r34NkLH1HSSBjwmoaxyozQ0jloXY0I2xjjKErJcZUG
         g9W3Jt+MT7AiUt4/BKUnKbmRcaW76ePmFt+Q0MHKRlTc17sZAgn9PPeXRqsONespDpH4
         OCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768927751; x=1769532551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mYEReVCPXmTD8QgwZzRjHyvsdnUJkU6KY0UFy4cFcY=;
        b=XsmCAXyAQcyGvCFab2hhhhTFiqGr+iU4whHecDjNXRn5R68f67ApQ2qnXstFa36Ocz
         uSh8V3KA4TdUi7REArtmgMnyfl5IcyzUiXL7CCYmIe7IiQKKgc2NvrM5a95VtxzDnnOU
         LQqVnHIqJMxeD3cmthdGpQBlh5a1DqUszcnSiw0m3dko8LNugP+EotjHdhpsQQ5qJmR5
         Jdx0ESBqpRLb+6C0quBAoSJr8dMvVTNuGvp27w2WWTFkU4lIe7PtxQOlsdX+kIN+KWQE
         qRfDtTh/+DjiYYC5SH+ayg7j3FiCXOHmc1yjSmA0DY78gF3GBnJdbLNLnl1SEZ/YTlJx
         LR8w==
X-Forwarded-Encrypted: i=1; AJvYcCW167sbCTN9xFBAOfkNWuiCzBO+OM1p6Wj4HQhUN1aDc9XszDZrqN8+0ypWocHIZL4kgfl9VhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwS5NYQtYXFqu0+ZB4xEMeJqPK9SD4lukybXmGnYmSmTzK52t
	eZdBuFSrEMUD2OAXjVUMCV2VGtyCW5ZW/ar5KHAcEbQnGvhVCEsHl8ow+JEQPsFABYjcKMPWE+6
	KyR1TG1oDfOpbCg==
X-Received: from yxtg19.prod.google.com ([2002:a53:e013:0:b0:644:75dd:1eeb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1904:b0:63f:a48d:b7ce with SMTP id 956f58d0204a3-6493c7f3831mr1809838d50.27.1768927751175;
 Tue, 20 Jan 2026 08:49:11 -0800 (PST)
Date: Tue, 20 Jan 2026 16:49:03 +0000
In-Reply-To: <20260120164903.1912995-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120164903.1912995-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260120164903.1912995-4-edumazet@google.com>
Subject: [PATCH v3 net-next 3/3] gro: inline tcp6_gro_complete()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251564-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A94874983F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 net/ipv6/udp_offload.c   |  2 +-
 5 files changed, 12 insertions(+), 16 deletions(-)

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
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index e90aaa84941c60ec0fa2e23051c422064a959096..e003b8494dc0e900994e6d4d2928f6bb8dd5787e 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -164,7 +164,7 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)
 	return NULL;
 }
 
-INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
+int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct ipv6hdr *ipv6h = (struct ipv6hdr *)(skb->data + offset);
-- 
2.52.0.457.g6b5491de43-goog


