Return-Path: <netdev+bounces-259961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDfNNz0fnGkZ/wMAu9opvQ
	(envelope-from <netdev+bounces-259961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:34:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82027173F84
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 556AB301F6BA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A0A34F484;
	Mon, 23 Feb 2026 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3CckNfar"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA84834E75E
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839289; cv=none; b=Ml9xXRU0MN4z3O6an7HssA/bvSYy93QCGoKo3HnCRjBJcwi95RlWTdPu8TJc0ujrNb9hOkwAfGvdkI5c0MX1EEs9U0MhHGml7JY6OrEls8okLHUaqsepAFii/d2VoMIYUewImqDcbOTjk7DAY5mnD3+4QnQ6XUFvbsg50bIgspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839289; c=relaxed/simple;
	bh=ILkfiBqKI02H1HCrvmquYghyw7WwGpjItReju/8tqIc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gg2RLGG1VXV+NHoifFa27ZoiBV6eBiZAF9lDKcNl26Ac+Tb0ZaKEuGiSIM9MKI0F70BAw+DGJNBrusqEqKfTEaqgX6cXu9zCghiqDkAB1JzmAEcSiwtsQi6vQFWkwOB8vtQR89eMNljdQCVIQtV2NF9vLOgbf6krI1QarIqGlPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3CckNfar; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c70fadd9a3so2285651685a.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 01:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771839287; x=1772444087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ScdjLvvAtmPvua+J0Czj/GB2aktA/DnullMYkfu4zM4=;
        b=3CckNfarssHEkcR4UIuEf2puadRr6/FgnxavslE/FZrUsMRfGkuMMZq7hM9UoXSh6L
         PicQkSOPg3EwWIr+YIXhH1wPZkmWMquti5iNrDvnAQb9MoItpULgbU2jiLVTDkvY+gIN
         /cWQaJR0XYpkNIThQ+dNJtA3ut/00oiuhzWjApGe4IZlJXI/gxTtfM2fSVaL5bBC1zY8
         Os6eRF0uLaE6B6gr7qH4vxuoGVOh0gBca93klsmCxg9tj7IA/8suUk4c2BxhrB1Jh4J9
         PvOF6mQ0N/IEdL+WQS1hojsNx9qI+lbBjWCXkGedUJHXry9KOP3yFsThNe8PVb5M97Ui
         xiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771839287; x=1772444087;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScdjLvvAtmPvua+J0Czj/GB2aktA/DnullMYkfu4zM4=;
        b=iPfG/J5KTASMPGJ9HskDKUaeNDbbx639x2TlDYp+Q/8nD447fq3bt30U51zq5EK3q2
         S0oG0J7BEmaXOPvW+ot0VM3M09YwYUnjpPLjeijAlKKzAve3CpVLyWoZPr783GW2YViW
         JQhyjQtpQZAEsx8zpZBRP4ZQL2aPZIvCtCGEujDp8Pw6y7U+kIkxr4+XhYT1jrLFYxoY
         R/KCqGiytYh5YOtynTjbmQZLzi7ragLTqaMFC+VwFxDrBRYecRgbBCz8cldKgztZ/HoV
         q0UVwHhXTvOvtZNH6DyMzKay6p8qWC13dVspGo/ZcAIDNDFoscxTX+k4I0cA6FfLNSLP
         TV1A==
X-Forwarded-Encrypted: i=1; AJvYcCUh8a10lWnELDQvceyGAd3u+Q/rcLWpiq38hXnFX0j9nHvvxNSWfDRt4IO2W4HyS0VHw2tK07s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7klMi1quyQFv+Z6D3nIKmxtzIay02l98T1R7jZ9qrsoFaXVQQ
	h7w8W17XJlWmD77HuyaAgZOSnKwvBYeb3XIobLGGtpALdTHG5Gt8cUyhabrEUSiNaHpV6+gMDJC
	gGNsvp7mOQh2w5A==
X-Received: from qkka3.prod.google.com ([2002:a05:620a:1023:b0:8cb:4a66:621a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4444:b0:8c8:8126:7770 with SMTP id af79cd13be357-8cb8ca8bf9bmr898254885a.67.1771839286670;
 Mon, 23 Feb 2026 01:34:46 -0800 (PST)
Date: Mon, 23 Feb 2026 09:34:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260223093445.3696368-1-edumazet@google.com>
Subject: [PATCH net-next] udp: move udp6_csum_init() back to net/ipv6/udp.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259961-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82027173F84
X-Rspamd-Action: no action

This function has a single caller in net/ipv6/udp.c.

Move it there so that the compiler can decide to (auto)inline
it if he prefers to. IBT glue is removed anyway.

With clang, we can see it was able to inline it and also
inlined one other helper at the same time.

UDPLITE removal will also help.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 1/0 up/down: 840/-785 (55)
Function                                     old     new   delta
__udp6_lib_rcv                              1247    2087    +840
__pfx_udp6_csum_init                          16       -     -16
udp6_csum_init                               769       -    -769
Total: Before=25074399, After=25074454, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip6_checksum.h |  2 --
 net/ipv6/ip6_checksum.c    | 47 --------------------------------------
 net/ipv6/udp.c             | 46 +++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/include/net/ip6_checksum.h b/include/net/ip6_checksum.h
index c8a96b8882772b66b902a2f5ad654f2dc8b62180..6677b3cc397261875661dd7521e75908a89cc6d9 100644
--- a/include/net/ip6_checksum.h
+++ b/include/net/ip6_checksum.h
@@ -82,6 +82,4 @@ static inline __sum16 udp_v6_check(int len,
 void udp6_set_csum(bool nocheck, struct sk_buff *skb,
 		   const struct in6_addr *saddr,
 		   const struct in6_addr *daddr, int len);
-
-int udp6_csum_init(struct sk_buff *skb, struct udphdr *uh, int proto);
 #endif
diff --git a/net/ipv6/ip6_checksum.c b/net/ipv6/ip6_checksum.c
index 377717045f8f55fa1a5c8a87de829190b807dc06..8bb68a0cdfd681a7fb51959fa7cbce96a6dc271a 100644
--- a/net/ipv6/ip6_checksum.c
+++ b/net/ipv6/ip6_checksum.c
@@ -62,53 +62,6 @@ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 EXPORT_SYMBOL(csum_ipv6_magic);
 #endif
 
-int udp6_csum_init(struct sk_buff *skb, struct udphdr *uh, int proto)
-{
-	int err;
-
-	UDP_SKB_CB(skb)->partial_cov = 0;
-	UDP_SKB_CB(skb)->cscov = skb->len;
-
-	if (proto == IPPROTO_UDPLITE) {
-		err = udplite_checksum_init(skb, uh);
-		if (err)
-			return err;
-
-		if (UDP_SKB_CB(skb)->partial_cov) {
-			skb->csum = ip6_compute_pseudo(skb, proto);
-			return 0;
-		}
-	}
-
-	/* To support RFC 6936 (allow zero checksum in UDP/IPV6 for tunnels)
-	 * we accept a checksum of zero here. When we find the socket
-	 * for the UDP packet we'll check if that socket allows zero checksum
-	 * for IPv6 (set by socket option).
-	 *
-	 * Note, we are only interested in != 0 or == 0, thus the
-	 * force to int.
-	 */
-	err = (__force int)skb_checksum_init_zero_check(skb, proto, uh->check,
-							ip6_compute_pseudo);
-	if (err)
-		return err;
-
-	if (skb->ip_summed == CHECKSUM_COMPLETE && !skb->csum_valid) {
-		/* If SW calculated the value, we know it's bad */
-		if (skb->csum_complete_sw)
-			return 1;
-
-		/* HW says the value is bad. Let's validate that.
-		 * skb->csum is no longer the full packet checksum,
-		 * so don't treat is as such.
-		 */
-		skb_checksum_complete_unset(skb);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(udp6_csum_init);
-
 /* Function to set UDP checksum for an IPv6 UDP packet. This is intended
  * for the simple case like when setting the checksum for a UDP tunnel.
  */
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 010b909275dd01583fa5825eaba49a1013dbf974..48f73401adf41effe280f62e146edbf9e54b1429 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1069,6 +1069,52 @@ static int udp6_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 	return 0;
 }
 
+static int udp6_csum_init(struct sk_buff *skb, struct udphdr *uh, int proto)
+{
+	int err;
+
+	UDP_SKB_CB(skb)->partial_cov = 0;
+	UDP_SKB_CB(skb)->cscov = skb->len;
+
+	if (proto == IPPROTO_UDPLITE) {
+		err = udplite_checksum_init(skb, uh);
+		if (err)
+			return err;
+
+		if (UDP_SKB_CB(skb)->partial_cov) {
+			skb->csum = ip6_compute_pseudo(skb, proto);
+			return 0;
+		}
+	}
+
+	/* To support RFC 6936 (allow zero checksum in UDP/IPV6 for tunnels)
+	 * we accept a checksum of zero here. When we find the socket
+	 * for the UDP packet we'll check if that socket allows zero checksum
+	 * for IPv6 (set by socket option).
+	 *
+	 * Note, we are only interested in != 0 or == 0, thus the
+	 * force to int.
+	 */
+	err = (__force int)skb_checksum_init_zero_check(skb, proto, uh->check,
+							ip6_compute_pseudo);
+	if (err)
+		return err;
+
+	if (skb->ip_summed == CHECKSUM_COMPLETE && !skb->csum_valid) {
+		/* If SW calculated the value, we know it's bad */
+		if (skb->csum_complete_sw)
+			return 1;
+
+		/* HW says the value is bad. Let's validate that.
+		 * skb->csum is no longer the full packet checksum,
+		 * so don't treat is as such.
+		 */
+		skb_checksum_complete_unset(skb);
+	}
+
+	return 0;
+}
+
 int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		   int proto)
 {
-- 
2.53.0.345.g96ddfc5eaa-goog


