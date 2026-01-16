Return-Path: <netdev+bounces-250566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC064D33377
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E339E308F87A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A02B33A6E9;
	Fri, 16 Jan 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVhXgrVM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056F21FDE31
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577407; cv=none; b=GTk2897Gh1Sm5HFZPvmF8o69T0M3NTyPcTSage+xL68HNKiOW963JTec1z+ZoZtEFti0PDus4ubsSJKpA1MlrE4y4Dnf0P3aYkN+8TuPMBXo5BbigIUd9pO9DQspcoC5ytMsHYXT2cL9bp35MFeawx1ZHKFGZ7NhT4xkjgzV380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577407; c=relaxed/simple;
	bh=Z1vZGVdWFRQ0FOSxAf/+3UN8S4J09eTK6zM/m4bEPq0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GGsveD/rieo3V4Xz2Y0YrkpX0RNZhvniKNqHDHduxtEHehkH6YhSiw7SLSSFVK4/HibzqgdFVkc13GU1Ggc2NGQCbbpF1Im9bzIV7hqYHwHJ/S2qyceFH1wfU1s1YvRWWyRva8pkmwUoc7eGxAbE2nKlr7OG0DcBVGjeO75Qa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVhXgrVM; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a32bf024cso23567526d6.2
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 07:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768577405; x=1769182205; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxwjYnLwZbTMj+fynl/ZP2XoHCXrtbg5a7fUY44BVso=;
        b=sVhXgrVMS2MaNCMkZ4pYJ90pYg0M52GjUB8mEqCI2FlHQ4ExZeNpypY4+bgTiAhgeP
         kf5TEKtyJ7hDFPfUBXQDRMJkvnWMI/csRzjuEF9OqIkYYWu+hkLp1jCauxsNkTYd4ZR1
         /eMxeD7FwhHDdVkECn5wGDJ4AhNivsXAzL2PWSQ2i9dapDNPcm0qTP/zP9Nvw3YhdVCZ
         43cizhDLjij1edYtXPPrRum8NJWwhYj5A1rdqRO3+CSEeYLLIisiFM/0cNy6BOToDmQa
         pAm9FSYOliZJ7MDb0UvA9MfRLknih3CDd2VL5uPc8TsZ24Yhpku/tQHPBY6l4FiToEls
         9RTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768577405; x=1769182205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxwjYnLwZbTMj+fynl/ZP2XoHCXrtbg5a7fUY44BVso=;
        b=iVoNfjjpdej7DaprPEdN8pnI45rbdA+hiu0T3SK3CKnVCsZDD9hVKa3CmilAVsJvfE
         iQCAQVLp9J/Es9RBK9ITUwPyIvgYqRY8bCcqcXUt0aZ8g+N1l7I+h3XwIOrHyKE0/xIJ
         SCrhOOzpey70rSDeqXZUZ/Ygb+fLL9N+5mKgva9DnR45f/q37gKEid6OXK+URfYmRZt8
         /QIZNWp5zFJ3a/QnMAnGVCTnt1+0AA5snA9j6YIohRU59jDl8ufAEElffV6dgmaz2ORD
         3FMYD10tRhFQdcKpFqS6plGWKxR+qY4DgApA0wuV2m0WAL15eGeYvKMlcMK3cKO7r2nN
         UFNA==
X-Forwarded-Encrypted: i=1; AJvYcCUiV+igCjKPEJ4eX2sGplftJgV71zqFNidmj+TaV36KUILPcS38ZnCkycKgVzRAgV+l7XfycEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqjitVlYux0NLI6qeuBNDFrgqsGZUi44F+sxvp99ZJNBg9Bh+
	ZrJBlJBxdZDMi806zUL7TmcYhjTs42XEsRA+NcWbXU5TMqGMNvAAF56OM1Nspo+hIOyimlhBpU5
	QFFJzZo+WjwLg9A==
X-Received: from qvbdp2.prod.google.com ([2002:a05:6214:9c2:b0:888:3b63:e0d8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:596d:0:b0:888:6f8d:8e93 with SMTP id 6a1803df08f44-8942dcf76d8mr47224966d6.21.1768577404763;
 Fri, 16 Jan 2026 07:30:04 -0800 (PST)
Date: Fri, 16 Jan 2026 15:29:57 +0000
In-Reply-To: <20260116152957.1825626-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260116152957.1825626-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260116152957.1825626-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] gro: inline tcp6_gro_complete()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, eric.dumazet@gmail.com, 
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
 include/net/tcp.h        |  1 -
 net/ipv6/ip6_offload.c   | 21 +++++++++------------
 net/ipv6/tcpv6_offload.c |  2 +-
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2a7744de226ed0a378719fd60fa2a3830bef2e7e..68bc08c40d5435ce196dd492b46b5d81f8e29b3f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2327,7 +2327,6 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb,
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


