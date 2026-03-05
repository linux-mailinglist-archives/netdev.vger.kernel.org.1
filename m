Return-Path: <netdev+bounces-264569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAboOBf8qWl+JAEAu9opvQ
	(envelope-from <netdev+bounces-264569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:56:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 873BC218B76
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 22:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3230E3142A28
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 21:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9D936074B;
	Thu,  5 Mar 2026 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zhKTFHzU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CC73603DD
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772747447; cv=none; b=K1cIrxHm81zVt3ViLHnVuTaOjp3IE2+lLwaOYs6WABSVFMoRdWIzQTyunLiItdBmXZirdVQvDTWpscLiYRV7iEHRaFJ46HYp3ZSTKu4oO7J3Uho/VDlyQT9U+F+ktsw9KA7pt6T8PtcwAyZcZuWPHAU6Cxf1wubPn0FDeGQAl+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772747447; c=relaxed/simple;
	bh=zL/5cwDyp+9FZH/5e6H+GNIg/gDn7ztGlXk9ngoVQpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oAA/0PLFclF3PTLX/rPV9W8oR7yBrGhbWY+Dq50rKH0h/XdSPmDQHkQ7+zEt3jzW0EGi/ZkW1+LGBmX5a5O6q25pkn//g0N6Yyjt8p4ioQSYraaOG6EUTKgYgKVzot6aUItct3IDpG0kpT1qDZYYJUk0dtNdBZGK9JoKb7CXwkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zhKTFHzU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae62c87973so150537135ad.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772747445; x=1773352245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbM5D/cQjJGzk/lpXCEuUTPEcRSIu1pXMT7ZVVOT5mw=;
        b=zhKTFHzUqvQG103h/NjECYhab1wTeiv/ta2Hr2NJ3ohBxFaN2R0PYtiFmPoyjAbvMr
         le7WfEsAQAuoa4BAPy94l6qdy+lf+x9ei8mMg1Q+oNWBpsvuavKRuIeWKxPp1nAph0CB
         viU+CPh7vboxhT2HHG7eru7SI8rLMitmjt/YsbQgeL76zai2IfDWwUp4ggFlgg4NbBLN
         JW3j4Fu2bvy59KrwtEWriaKFgxXTQVS8vwSSTvBZNxztoKmcaVKJcXwfYB7OtX+XfSo8
         18bPRt/tdMvxM0XwjRBYJBYQJnz9u85anVr4XRns7Jo7XeUCQealm7nXsI2ywKobKWik
         8D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772747445; x=1773352245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CbM5D/cQjJGzk/lpXCEuUTPEcRSIu1pXMT7ZVVOT5mw=;
        b=DN60oW4AYAmwe+EhF8oNzOD0XIPIBcHXSXIR3j1M3S3XZi5OS26BAYxBVLb2CNl0FQ
         qytL8JElMn9GOeMGKVQj3A14xY+ftqW5L3z7fv43uZucDHyHI8tZ7p9iEJSf33gKEtHJ
         vQRzB4kj4dRztuO8jHb6/cORX7oaCQ+H16M5Ex/gh6X+RjPyEwxbDLYKt8FV8RI0hzOe
         dP7zL/QmPEKwVTPWTWNUzpNIabj7cydLO1xUrGCf2CKrJHKFqVmlk6lDeNoWkwPSgpnz
         T5w3Qb1vr85hg6ch8HGbp+tP47Ebn8hS3R8z4C5YODQsoXEzsO72szTaUoCDcgAzTSzG
         J5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXMaWnHgdYrB0K6l1zZTvBeWypJJRF9IHQoqHwjWdsjxCDPlcmWVGTMORs9euNcRJ7/XJbCQ0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8yOJkO10NWa9tMj/YqX3shPzDRGPaW/X8ux2CEebumn3bVYa
	s0zk4S7wafoLfud1PF/RItLNBuf+Vg2anC1HSM35PyEOqw9GSyicQR0YX+U1OrOeM+9tgA2y1R3
	ILPlh3w==
X-Received: from plpm4.prod.google.com ([2002:a17:903:3de4:b0:2a8:71ec:6799])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:ac4:b0:2ae:4300:af82
 with SMTP id d9443c01a7336-2ae82451348mr335625ad.42.1772747445373; Thu, 05
 Mar 2026 13:50:45 -0800 (PST)
Date: Thu,  5 Mar 2026 21:50:01 +0000
In-Reply-To: <20260305215013.2984628-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305215013.2984628-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305215013.2984628-16-kuniyu@google.com>
Subject: [PATCH v2 net-next 15/15] udp: Don't pass proto to __udp4_lib_rcv()
 and __udp6_lib_rcv().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 873BC218B76
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264569-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

UDP and UDP-Lite shared __udp4_lib_rcv() and __udp6_lib_rcv()
by passing IPPROTO_UDP or IPPROTO_UDPLITE.

Now, @proto is always IPPROTO_UDP.

Let's not pass it and rename the functions accordingly.

With this series removing a bunch of conditionals for UDP-Lite
from the fast path, udp_rr with 20,000 flows sees a 10% increase
in pps (13.3 Mpps -> 14.7 Mpps)  on an AMD EPYC 7B12 (Zen 2)
64-Core Processor platform.

[ With FDO, the baseline is much higher and the delta was ~3%,
  20.1 Mpps -> 20.7 Mpps ]

Before:

$ nstat > /dev/null; sleep 1; nstat | grep Udp
Udp6InDatagrams                 14013408           0.0
Udp6OutDatagrams                14013128           0.0

After:

$ nstat > /dev/null; sleep 1; nstat | grep Udp
Udp6InDatagrams                 15491971           0.0
Udp6OutDatagrams                15491671           0.0

$ ./scripts/bloat-o-meter vmlinux.before vmlinux.after
add/remove: 13/75 grow/shrink: 11/75 up/down: 13777/-18401 (-4624)
Function                                     old     new   delta
udp4_gro_receive                             872     866      -6
udp6_gro_receive                             910     903      -7
udp_rcv                                       32    1727   +1695
udpv6_rcv                                     32    1450   +1418
__udp4_lib_rcv                              2045       -   -2045
__udp6_lib_rcv                              2084       -   -2084
udp_unicast_rcv_skb                          160     149     -11
udp6_unicast_rcv_skb                         196     181     -15
__udp4_lib_mcast_deliver                     925     846     -79
__udp6_lib_mcast_deliver                     922     810    -112
__udp4_lib_lookup                            973     969      -4
__udp6_lib_lookup                            940     929     -11
__udp4_lib_lookup_skb                        106     100      -6
__udp6_lib_lookup_skb                         71      66      -5
udp4_lib_lookup_skb                          132     127      -5
udp6_lib_lookup_skb                           87      81      -6
udp_queue_rcv_skb                            326     356     +30
udpv6_queue_rcv_skb                          331     361     +30
udp_queue_rcv_one_skb                       1233     914    -319
udpv6_queue_rcv_one_skb                     1250     930    -320
__udp_enqueue_schedule_skb                  1067     995     -72
udp_rcv_segment                              520     480     -40
udp_post_segment_fix_csum                    120       -    -120
udp_lib_checksum_complete                    200      84    -116
udp_err                                       27    1103   +1076
udpv6_err                                     36    1417   +1381
__udp4_lib_err                              1112       -   -1112
__udp6_lib_err                              1448       -   -1448
udp_recvmsg                                 1149     994    -155
udpv6_recvmsg                               1349    1294     -55
udp_sendmsg                                 2730    2648     -82
udp_send_skb                                 909     681    -228
udpv6_sendmsg                               3022    2861    -161
udp_v6_send_skb                             1214     952    -262
...
Total: Before=18446744073748075501, After=18446744073748070877, chg -0.00%

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c | 18 +++++-------------
 net/ipv6/udp.c | 15 ++++-----------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0436462cb9fd..d39dcceb8ba7 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2474,8 +2474,7 @@ EXPORT_IPV6_MOD(udp_sk_rx_dst_set);
  */
 static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 				    struct udphdr  *uh,
-				    __be32 saddr, __be32 daddr,
-				    int proto)
+				    __be32 saddr, __be32 daddr)
 {
 	struct udp_table *udptable = net->ipv4.udp_table;
 	unsigned int hash2, hash2_any, offset;
@@ -2597,7 +2596,7 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
  *	All we need to do is get the socket, and then do a checksum.
  */
 
-static int __udp4_lib_rcv(struct sk_buff *skb, int proto)
+int udp_rcv(struct sk_buff *skb)
 {
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(skb->dev);
@@ -2654,7 +2653,7 @@ static int __udp4_lib_rcv(struct sk_buff *skb, int proto)
 	}
 
 	if (rt->rt_flags & (RTCF_BROADCAST|RTCF_MULTICAST))
-		return __udp4_lib_mcast_deliver(net, skb, uh, saddr, daddr, proto);
+		return __udp4_lib_mcast_deliver(net, skb, uh, saddr, daddr);
 
 	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest);
 	if (sk)
@@ -2681,8 +2680,7 @@ static int __udp4_lib_rcv(struct sk_buff *skb, int proto)
 
 short_packet:
 	drop_reason = SKB_DROP_REASON_PKT_TOO_SMALL;
-	net_dbg_ratelimited("UDP%s: short packet: From %pI4:%u %d/%d to %pI4:%u\n",
-			    proto == IPPROTO_UDPLITE ? "Lite" : "",
+	net_dbg_ratelimited("UDP: short packet: From %pI4:%u %d/%d to %pI4:%u\n",
 			    &saddr, ntohs(uh->source),
 			    ulen, skb->len,
 			    &daddr, ntohs(uh->dest));
@@ -2694,8 +2692,7 @@ static int __udp4_lib_rcv(struct sk_buff *skb, int proto)
 	 * the network is concerned, anyway) as per 4.1.3.4 (MUST).
 	 */
 	drop_reason = SKB_DROP_REASON_UDP_CSUM;
-	net_dbg_ratelimited("UDP%s: bad checksum. From %pI4:%u to %pI4:%u ulen %d\n",
-			    proto == IPPROTO_UDPLITE ? "Lite" : "",
+	net_dbg_ratelimited("UDP: bad checksum. From %pI4:%u to %pI4:%u ulen %d\n",
 			    &saddr, ntohs(uh->source), &daddr, ntohs(uh->dest),
 			    ulen);
 	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
@@ -2838,11 +2835,6 @@ enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb)
 	return SKB_NOT_DROPPED_YET;
 }
 
-int udp_rcv(struct sk_buff *skb)
-{
-	return __udp4_lib_rcv(skb, IPPROTO_UDP);
-}
-
 static void udp_destroy_sock(struct sock *sk)
 {
 	struct udp_sock *up = udp_sk(sk);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 0de28cbfe793..12a1004c4d7f 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -934,8 +934,7 @@ static void udp6_csum_zero_error(struct sk_buff *skb)
  */
 static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 				    const struct in6_addr *saddr,
-				    const struct in6_addr *daddr,
-				    int proto)
+				    const struct in6_addr *daddr)
 {
 	struct udp_table *udptable = net->ipv4.udp_table;
 	const struct udphdr *uh = udp_hdr(skb);
@@ -1063,7 +1062,7 @@ static int udp6_csum_init(struct sk_buff *skb, struct udphdr *uh)
 	return 0;
 }
 
-static int __udp6_lib_rcv(struct sk_buff *skb, int proto)
+INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct in6_addr *saddr, *daddr;
@@ -1133,7 +1132,7 @@ static int __udp6_lib_rcv(struct sk_buff *skb, int proto)
 	 *	Multicast receive code
 	 */
 	if (ipv6_addr_is_multicast(daddr))
-		return __udp6_lib_mcast_deliver(net, skb, saddr, daddr, proto);
+		return __udp6_lib_mcast_deliver(net, skb, saddr, daddr);
 
 	/* Unicast */
 	sk = __udp6_lib_lookup_skb(skb, uh->source, uh->dest);
@@ -1164,8 +1163,7 @@ static int __udp6_lib_rcv(struct sk_buff *skb, int proto)
 short_packet:
 	if (reason == SKB_DROP_REASON_NOT_SPECIFIED)
 		reason = SKB_DROP_REASON_PKT_TOO_SMALL;
-	net_dbg_ratelimited("UDP%sv6: short packet: From [%pI6c]:%u %d/%d to [%pI6c]:%u\n",
-			    proto == IPPROTO_UDPLITE ? "-Lite" : "",
+	net_dbg_ratelimited("UDPv6: short packet: From [%pI6c]:%u %d/%d to [%pI6c]:%u\n",
 			    saddr, ntohs(uh->source),
 			    ulen, skb->len,
 			    daddr, ntohs(uh->dest));
@@ -1252,11 +1250,6 @@ void udp_v6_early_demux(struct sk_buff *skb)
 	}
 }
 
-INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
-{
-	return __udp6_lib_rcv(skb, IPPROTO_UDP);
-}
-
 /*
  * Throw away all pending data and cancel the corking. Socket is locked.
  */
-- 
2.53.0.473.g4a7958ca14-goog


