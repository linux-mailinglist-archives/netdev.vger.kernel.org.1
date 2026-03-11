Return-Path: <netdev+bounces-266480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNJcBAX8sGnCpQIAu9opvQ
	(envelope-from <netdev+bounces-266480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:22:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A349225C635
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 411FB30862CF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60832D7F1;
	Wed, 11 Mar 2026 05:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSA/rNat"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A322F1D5ADE
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773206452; cv=none; b=qKewkFbEGPIBMwFHaEaBy4R+jp70oxv7xWL6tz6jCWp0hdrnaH8AvKzJT0EvZCKgfXp8G69s4umb5TL8rfcT0Ekm3nsXwWMofutUq3OWw24pQ1abXMT42EEEPSRfllDkrz53jLt6GZjIm3uVLUyMnFWnGQDaKVq079WefIzIang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773206452; c=relaxed/simple;
	bh=ZFoYg3JvtcoFts1pquf6IJZAuRNjhOpOat2bj9WpYZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BysSGjEp3nJ4INH775aaHQ9HgHJobdbOlCgxrJ8sfafaSJDqFqxqAKu/CnnArZFoO1efHy28pQFretpC7NiSH5i7u77pZH9sALhTq8f5V4Ht/50KWVdZuBvsSHTC/M0yYBC+MH3yTtlZ2BrVItXR0/ErgP5h5QW5FdVz4yW52LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RSA/rNat; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7385e8fa73so3791457a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773206451; x=1773811251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RmbR2Ie4wwD8MVk/0yJckliGzslMn379y+d/tncGcg=;
        b=RSA/rNatn+56/sOIDtBzGEg6qvKhwrHnCEpUslLGxVD/FH5y8hcTbnYVi7lLAaXERv
         w/U4aSvCbW1MV9tGeToGOmoKJ3GFr5xoCBbU0mt2IMh1x2yrNavB447raHSz1igu8hyE
         VJ/kUvy5Tvc9rencseK0Ex9GUi9Y4SjID28cYsB0N0H5HKAh3WuXJuhRE9nVMHlsrBT3
         nHxT/dsAJivHYuEurwjBkeG9bCnwwK2EfrTqzW9sl9jAjVLoJNXFguXFozdwHYqViQOx
         59CYhkUMjch0COBugPXGsM7n9TDtTQEmRgSLRCpavicZNx0T+u5yQi/bNyohqG+/swKM
         63OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773206451; x=1773811251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RmbR2Ie4wwD8MVk/0yJckliGzslMn379y+d/tncGcg=;
        b=lWKDepS7KikuOuAHZ5dJlDuOoM8CWRCu+nscRSg3xQNIubrYCNEhWOzjtJnFHXcRvJ
         EC1YkIp0/4oeBnTFCMWZsAvgh6Zu+lE5N2WFb0U18YOp/dYOXqU/l8sVA8+YKS7UQ/Cd
         n63pmVmEwopSHNKK/BtdlJHyomGM5fTNgQyZ+4K1yfsD2lfmnhyzYAy52GWQ6I1WyEWL
         z4AEI7hGbUougfTmUQz3TErUXNLehu0DDHQxnn8cJcNS/bn5lFd32Zw2g5P2ntApEz8v
         sbVRq/GeIt2ElX+kqJvYAD5o8+iu1ievsKQ0N+0EK0TwwOWgwB7VKnQd7qgyYydMX4/Z
         qCUA==
X-Forwarded-Encrypted: i=1; AJvYcCXMbctG/+xZ8Rc7xpoxCTIAY2eka/8nz/RJcaa7SSm5Wmnnjzd2V1udhufuVUfzB7PdXtOSvrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztPYV/VZZz3HDfXmWeJgJKkEQa6k74m+tDgzDTlRCp6HkKHFXD
	umOKWarfePYfN0mIrMSqYiKWqeebOJATLejR/8IBTJSn2f6lsS3C+FHXbMwd+NGZU/efb0O3VJz
	aDj3zRw==
X-Received: from pjbbj1.prod.google.com ([2002:a17:90b:881:b0:359:7c53:3893])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3881:b0:359:ff8a:ee4c
 with SMTP id 98e67ed59e1d1-35a012cce28mr1436682a91.11.1773206450730; Tue, 10
 Mar 2026 22:20:50 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:20:02 +0000
In-Reply-To: <20260311052020.1213705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052020.1213705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052020.1213705-16-kuniyu@google.com>
Subject: [PATCH v3 net-next 15/15] udp: Don't pass proto to __udp4_lib_rcv()
 and __udp6_lib_rcv().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A349225C635
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266480-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/udp.c | 18 +++++-------------
 net/ipv6/udp.c | 15 ++++-----------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index dff803e7d6a8..7e3f9fd9de19 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2479,8 +2479,7 @@ EXPORT_IPV6_MOD(udp_sk_rx_dst_set);
  */
 static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 				    struct udphdr  *uh,
-				    __be32 saddr, __be32 daddr,
-				    int proto)
+				    __be32 saddr, __be32 daddr)
 {
 	struct udp_table *udptable = net->ipv4.udp_table;
 	unsigned int hash2, hash2_any, offset;
@@ -2602,7 +2601,7 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
  *	All we need to do is get the socket, and then do a checksum.
  */
 
-static int __udp4_lib_rcv(struct sk_buff *skb, int proto)
+int udp_rcv(struct sk_buff *skb)
 {
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(skb->dev);
@@ -2661,7 +2660,7 @@ static int __udp4_lib_rcv(struct sk_buff *skb, int proto)
 	}
 
 	if (rt->rt_flags & (RTCF_BROADCAST|RTCF_MULTICAST))
-		return __udp4_lib_mcast_deliver(net, skb, uh, saddr, daddr, proto);
+		return __udp4_lib_mcast_deliver(net, skb, uh, saddr, daddr);
 
 	sk = __udp4_lib_lookup_skb(skb, uh->source, uh->dest);
 	if (sk)
@@ -2688,8 +2687,7 @@ static int __udp4_lib_rcv(struct sk_buff *skb, int proto)
 
 short_packet:
 	drop_reason = SKB_DROP_REASON_PKT_TOO_SMALL;
-	net_dbg_ratelimited("UDP%s: short packet: From %pI4:%u %d/%d to %pI4:%u\n",
-			    proto == IPPROTO_UDPLITE ? "Lite" : "",
+	net_dbg_ratelimited("UDP: short packet: From %pI4:%u %d/%d to %pI4:%u\n",
 			    &saddr, ntohs(uh->source),
 			    ulen, skb->len,
 			    &daddr, ntohs(uh->dest));
@@ -2701,8 +2699,7 @@ static int __udp4_lib_rcv(struct sk_buff *skb, int proto)
 	 * the network is concerned, anyway) as per 4.1.3.4 (MUST).
 	 */
 	drop_reason = SKB_DROP_REASON_UDP_CSUM;
-	net_dbg_ratelimited("UDP%s: bad checksum. From %pI4:%u to %pI4:%u ulen %d\n",
-			    proto == IPPROTO_UDPLITE ? "Lite" : "",
+	net_dbg_ratelimited("UDP: bad checksum. From %pI4:%u to %pI4:%u ulen %d\n",
 			    &saddr, ntohs(uh->source), &daddr, ntohs(uh->dest),
 			    ulen);
 	__UDP_INC_STATS(net, UDP_MIB_CSUMERRORS);
@@ -2845,11 +2842,6 @@ enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb)
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
index dd958e2b552b..d7cf4c9508b2 100644
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
@@ -1132,7 +1131,7 @@ static int __udp6_lib_rcv(struct sk_buff *skb, int proto)
 	 *	Multicast receive code
 	 */
 	if (ipv6_addr_is_multicast(daddr))
-		return __udp6_lib_mcast_deliver(net, skb, saddr, daddr, proto);
+		return __udp6_lib_mcast_deliver(net, skb, saddr, daddr);
 
 	/* Unicast */
 	sk = __udp6_lib_lookup_skb(skb, uh->source, uh->dest);
@@ -1163,8 +1162,7 @@ static int __udp6_lib_rcv(struct sk_buff *skb, int proto)
 short_packet:
 	if (reason == SKB_DROP_REASON_NOT_SPECIFIED)
 		reason = SKB_DROP_REASON_PKT_TOO_SMALL;
-	net_dbg_ratelimited("UDP%sv6: short packet: From [%pI6c]:%u %d/%d to [%pI6c]:%u\n",
-			    proto == IPPROTO_UDPLITE ? "-Lite" : "",
+	net_dbg_ratelimited("UDPv6: short packet: From [%pI6c]:%u %d/%d to [%pI6c]:%u\n",
 			    saddr, ntohs(uh->source),
 			    ulen, skb->len,
 			    daddr, ntohs(uh->dest));
@@ -1251,11 +1249,6 @@ void udp_v6_early_demux(struct sk_buff *skb)
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


