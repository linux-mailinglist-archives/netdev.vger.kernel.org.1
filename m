Return-Path: <netdev+bounces-264027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJePEQmJqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:33:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B76E02071FC
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D82C3012CB9
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B9F3E0C61;
	Wed,  4 Mar 2026 19:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObtLGNnk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE73E0C4B
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652663; cv=none; b=r17x/pO7iCmAm8wuh8DSMc4PgaHzAtamKPtVCV1DQGL7Uk2E7Yt31DNW2eSNIu0+ausY+CtBrn2yXlvsPsYpLuGQE/JLCkKmrErrpTqt+vxvjak+13HU6GwE/8Hqxy9qeTtIlg89cKD/f7R+ajk6BMLMeV6P2q+ECLCy+oVY4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652663; c=relaxed/simple;
	bh=g56PIpeEryP7JEqD8NWb+qi+PqkOw5D7i5bPi4jgQbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gOHwZlOo6b0a/NtXNz6J+to5Q0QygQBoVkFTDQoY2K6gdAHUhtjmNVTUJo9RjQ1fUfVjdfu08kPjUtxr8L/18hORidSY5uO44VdnlZ4ni4OuDzTSkDeulZLHfj8hATd7cGfl6MWJGC1E5LnPl+kbLlMjoYyOkz3j2CJCrcoC6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObtLGNnk; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70f137aa4aso4189224a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652661; x=1773257461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0RahaqZIHWiT5W8//wFO82reY+rZAoMu5/+JvylAPM=;
        b=ObtLGNnkL0QPwsarThc6Nfs79OfW3fpaRX1L7rx/XAEzZLSvLhoUxYMvw7Iyrhzggb
         6hOl/eHDodfoVg3DbVsVFD4wXkdroT3lmUEOX0IOcDTn9RCorvjKUyKYuXVacqLoDRIN
         eHzXmLXEKAm/Dp7eW844/SeRrtKjUlVrXVV+YrA2Hdo7kQCBj3eHZUYJy/ix0FF6YLSM
         YIcozPzzBdGfVw0RzWMEIMvzUOjXAZoQVjyXDBxAxefhbUb4OwTewJVo2SdAHaixHGek
         e5fpf1ZX/G88bVEjDqmPZnwe3Z6nFDbtJ4IeCzI+dFfO6vpZQMWA/uutR12Ik3nESb7R
         JV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652661; x=1773257461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0RahaqZIHWiT5W8//wFO82reY+rZAoMu5/+JvylAPM=;
        b=JSUoCNpn69/LKtX/POShIHerRerjzZEj7G1g6tg9OyiCL65JJ4PDLWNFGUsdrIxt2s
         9hZwxIm/i66cdJ4HlArwp3GfvaJ92+x4O+Ur2CKiArsuKMEZjru9LDZ3hdVEcg6wIAbx
         Ukp+ohXolS9fWmKIkJcIHKlGSvOc5fqnGAPvFFc18ZJ69dt6crsyCdPjgrU7bM4wCwgW
         kJ+NFOngGUOjlVZ3bZhSZ18NeOzICHVNzLRSlOOfaoAJGYZg4HPyo0nfB45JBbd8AMhA
         x4cCgSusQazgd0jnpO2LTkdLe9Nr4pqWbCryIV4RvChsfUkackPFiJLuJmt7PENniQeq
         Uhng==
X-Forwarded-Encrypted: i=1; AJvYcCW/KcdNfrxKNv+F8cKYBginTdSZgNUFEF7R7z9IHniOK3NxyhTn3KUEhSQ8CjSmmhMhi7DWmIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrETLCCd/AEik+Pf8YPCGSwrhcUL+LaKTVkGmiXPPq5Ior5F0w
	lwiVYRh279W+dmcxnZX5zG4sj4aCA7ZdeRVTFmBEpjCeGOx8d5u6yUoQqucp7Zll2HDsPG9Z6op
	AgCLZdA==
X-Received: from pga18.prod.google.com ([2002:a05:6a02:4f92:b0:bd9:a349:94c0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:db90:b0:32d:a91a:7713
 with SMTP id adf61e73a8af0-3982e19c6f0mr2974672637.40.1772652661389; Wed, 04
 Mar 2026 11:31:01 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:46 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-16-kuniyu@google.com>
Subject: [PATCH v1 net-next 15/15] udp: Don't pass proto to __udp4_lib_rcv()
 and __udp6_lib_rcv().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: B76E02071FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264027-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
---
 net/ipv4/udp.c | 18 +++++-------------
 net/ipv6/udp.c | 15 ++++-----------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 2ae35ca1bb3f..98b7f015deb3 100644
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


