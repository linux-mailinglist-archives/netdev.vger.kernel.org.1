Return-Path: <netdev+bounces-263555-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIhCO4WYp2kCigAAu9opvQ
	(envelope-from <netdev+bounces-263555-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:27:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0106C1F9D95
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02912301FE47
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F6227A10F;
	Wed,  4 Mar 2026 02:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A2a/Azvz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0D25BEF8
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772591230; cv=none; b=IuSQpLlT98bxe6kDJyyMXoWyHfiZ+lfQx3RaSrEqjwQMx5cJHym5pVjeax36iANmzuD11vVciAt11Aq8uxafBTznSEnwxtFic0mYYXgR++PL88J+j0Yiydyj05tC7m8D/e6BLqHy2GwT34puuuVZz+QZFMJFQ68lYN/zpAgRNOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772591230; c=relaxed/simple;
	bh=ZaRr6rfuOidsINQncdRom0g2oxe4gI7+CyZ1HT9HcCc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U3eB2Jt3pU5KDK8WkXtn8hm56bFzIuJUnToUxI6OzUkziQBaCh5QllwdCutAab0Hs/BgXVb4U6fsbsLQEdyQB6AArcnspsY7Nmw8XiewWGupx1BoVFTqGjEhGVSazuHsw24+qYgXEawLTeWwp3yBwuavjzFz6kuWxYPxTiXv9Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A2a/Azvz; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-899bef1ea49so157764156d6.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 18:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772591228; x=1773196028; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iOfB83CJ2nLwJ4OAz1uc/n0mV8rJrM5HQ8u0yNv0xxs=;
        b=A2a/AzvzpTNfQ3gRsuGiKjGqprllUBFJMgHpOAmyxjtzHvNeMZnxXcT914BfrDTGM/
         I8me4G7fe9Wb0tuu68c0VNqUAEbvuga3UD4LHwnjVmTDQmVFHTvwYjJM0iKHIiZja4Se
         tcG37NAMz7O1pwV7ncHACa/cLUd1bLg70Lv47dWA9kdU8km0PQOQw0eOkKUsAgH1T5+x
         CGkWDuwtFkl/kRhzm7pAvmij3lbp0z4vRA88WKeCr3m6ScNnPXjanMhNMyHmnvkZgDXP
         u6JbMz6hbHyoGc7dGI7lGUk9GF/LHUxScHnQY7PSjcr04w4P70SRcSDGcOyCyzycw1C3
         MFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772591228; x=1773196028;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOfB83CJ2nLwJ4OAz1uc/n0mV8rJrM5HQ8u0yNv0xxs=;
        b=SKlgbRtsBEVIEzRYgsLT2ukLzXJzoOXMHYmLgCC+m32K1QQ3HUkl+BNomLGRvKsyPE
         Kv2tmW/XMcOSsxLi1bt1c/7qyxJPw9bgH/2ovyiQybR3/yLOg9d/Tovm++HEkUSxOPFw
         4qtGPJGLiJlK3ClKCHVBPLD3F0m5pfFJ6BULu95Cxlizib9j4URYMfGuDdOfg9mDxIo+
         bNKgvOvxfxHLkla4AohISy7bw31uSGAzkjw87Y+2AxtBYT8pYG0T6vfWyclgESoKEKrs
         B1jMJ0pYpEIy8NyLqxhY56nh+Ed3P5aOqNFaIqjEYqPtz/0YYCSrwYLW7ytNY9NOTwNG
         LuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpH/w5ZxOmv4fQSKnz1Z2GQLrLwT6nrVtMmcpDKBGGq18M1A4m+rdGGDC2FICF05HctFGYssQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysvGJjd2DfKEX8GVs9+uVy+fJ/n1dSHxd6g9f8HAOoBBqjZbc1
	bwJdzobqVHeN+IBgihRLgqwHvIkV9IIW6W6evSnEiNsf1mM6/z6CvuHmUzih8+5w0uybeMOMiON
	Ea3FslzZsDu4Bcg==
X-Received: from qvbif10.prod.google.com ([2002:a05:6214:1c4a:b0:89a:181c:bf46])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:202b:b0:89a:629:2203 with SMTP id 6a1803df08f44-89a19ac8b6amr5929126d6.11.1772591228229;
 Tue, 03 Mar 2026 18:27:08 -0800 (PST)
Date: Wed,  4 Mar 2026 02:27:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304022706.1062459-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move tcp_v6_early_demux() to net/ipv6/ip6_input.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0106C1F9D95
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263555-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

tcp_v6_early_demux() has a single caller : ip6_rcv_finish_core().

Move it to net/ipv6/ip6_input.c and mark it static, for possible
compiler/linker optimizations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h    |  1 -
 net/ipv6/ip6_input.c | 40 ++++++++++++++++++++++++++++++++++++++++
 net/ipv6/tcp_ipv6.c  | 38 --------------------------------------
 3 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 9cf8785ef0b42460a2389b4aa75570b3aa31cbb4..92289054e186e716d30bc6b893ceccfa266505d5 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1134,7 +1134,6 @@ static inline int tcp_v6_sdif(const struct sk_buff *skb)
 extern const struct inet_connection_sock_af_ops ipv6_specific;
 
 INDIRECT_CALLABLE_DECLARE(int tcp_v6_rcv(struct sk_buff *skb));
-void tcp_v6_early_demux(struct sk_buff *skb);
 
 #endif
 
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 2bcb981c91aa83fe08d782c29a185c8559aeacde..967b07aeb6831e2e1d3f1526c5be04da8a18b68b 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -44,6 +44,46 @@
 #include <net/xfrm.h>
 #include <net/inet_ecn.h>
 #include <net/dst_metadata.h>
+#include <net/inet6_hashtables.h>
+
+static void tcp_v6_early_demux(struct sk_buff *skb)
+{
+	struct net *net = dev_net_rcu(skb->dev);
+	const struct ipv6hdr *hdr;
+	const struct tcphdr *th;
+	struct sock *sk;
+
+	if (skb->pkt_type != PACKET_HOST)
+		return;
+
+	if (!pskb_may_pull(skb, skb_transport_offset(skb) +
+				sizeof(struct tcphdr)))
+		return;
+
+	hdr = ipv6_hdr(skb);
+	th = tcp_hdr(skb);
+
+	if (th->doff < sizeof(struct tcphdr) / 4)
+		return;
+
+	/* Note : We use inet6_iif() here, not tcp_v6_iif() */
+	sk = __inet6_lookup_established(net, &hdr->saddr, th->source,
+					&hdr->daddr, ntohs(th->dest),
+					inet6_iif(skb), inet6_sdif(skb));
+	if (sk) {
+		skb->sk = sk;
+		skb->destructor = sock_edemux;
+		if (sk_fullsock(sk)) {
+			struct dst_entry *dst = rcu_dereference(sk->sk_rx_dst);
+
+			if (dst)
+				dst = dst_check(dst, sk->sk_rx_dst_cookie);
+			if (dst &&
+			    sk->sk_rx_dst_ifindex == skb->skb_iif)
+				skb_dst_set_noref(skb, dst);
+		}
+	}
+}
 
 static void ip6_rcv_finish_core(struct net *net, struct sock *sk,
 				struct sk_buff *skb)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index c2816048007d7e00981c7cb4e876337a9fbb6391..e099d9a17a39cf8b95d93adcf822664747fda177 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1974,44 +1974,6 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 	goto discard_it;
 }
 
-void tcp_v6_early_demux(struct sk_buff *skb)
-{
-	struct net *net = dev_net_rcu(skb->dev);
-	const struct ipv6hdr *hdr;
-	const struct tcphdr *th;
-	struct sock *sk;
-
-	if (skb->pkt_type != PACKET_HOST)
-		return;
-
-	if (!pskb_may_pull(skb, skb_transport_offset(skb) + sizeof(struct tcphdr)))
-		return;
-
-	hdr = ipv6_hdr(skb);
-	th = tcp_hdr(skb);
-
-	if (th->doff < sizeof(struct tcphdr) / 4)
-		return;
-
-	/* Note : We use inet6_iif() here, not tcp_v6_iif() */
-	sk = __inet6_lookup_established(net, &hdr->saddr, th->source,
-					&hdr->daddr, ntohs(th->dest),
-					inet6_iif(skb), inet6_sdif(skb));
-	if (sk) {
-		skb->sk = sk;
-		skb->destructor = sock_edemux;
-		if (sk_fullsock(sk)) {
-			struct dst_entry *dst = rcu_dereference(sk->sk_rx_dst);
-
-			if (dst)
-				dst = dst_check(dst, sk->sk_rx_dst_cookie);
-			if (dst &&
-			    sk->sk_rx_dst_ifindex == skb->skb_iif)
-				skb_dst_set_noref(skb, dst);
-		}
-	}
-}
-
 static struct timewait_sock_ops tcp6_timewait_sock_ops = {
 	.twsk_obj_size	= sizeof(struct tcp6_timewait_sock),
 };
-- 
2.53.0.473.g4a7958ca14-goog


