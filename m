Return-Path: <netdev+bounces-243916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E1ECAAA26
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 17:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087B4302DB65
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608322FFFA4;
	Sat,  6 Dec 2025 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="wINfV37U"
X-Original-To: netdev@vger.kernel.org
Received: from mailgate01.uberspace.is (mailgate01.uberspace.is [95.143.172.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA8F258CD0
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765038382; cv=none; b=fa0laqtRYUTM/DD1oTcnFFufPkHEhFlLLHm8WSDWhi9SHk5eU8dmHrj5Y5GDSWZ+mXoKeptqSoKGZ/jgs6IF2a9Sh2xkHHgK3n//HiIkuj6bup2m0pkKFJnR1R6QU+KpXspPGTlmUphONSFexH7loVTETf811qmIW5eZEOKFOVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765038382; c=relaxed/simple;
	bh=oY2ka5lja8UpTFcpu2gZKgfaOGa68I0bntBzjHS9b8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLSz+YGG7YDlHH3wLqI2spyPTR3FqAGg3M3BF+Ms3QhBZWaXOcp1rS/QN1GALPrkK7Ch6vVNLI8WuQTwJvTgr1XEWlAyqdjK8RSpeZOQr27b1J2CiL1xcOd6pWB3k6ynvnft/iXDtpFBeLTrLZ6BF7W/04NeAMVNCiImxBAGrgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=wINfV37U; arc=none smtp.client-ip=95.143.172.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	by mailgate01.uberspace.is (Postfix) with ESMTPS id 5F8A660D10
	for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 17:26:10 +0100 (CET)
Received: (qmail 16583 invoked by uid 988); 6 Dec 2025 16:26:10 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sat, 06 Dec 2025 17:26:10 +0100
From: David Bauer <mail@david-bauer.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"R. Parameswaran" <parameswaran.r7@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] l2tp: account for IP version in SKB headroom
Date: Sat,  6 Dec 2025 17:26:01 +0100
Message-ID: <20251206162603.24900-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-3) MID_CONTAINS_FROM(1) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -0.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=oY2ka5lja8UpTFcpu2gZKgfaOGa68I0bntBzjHS9b8k=;
	b=wINfV37UHZ4TMH/IR8ttaWc5wP9+Hyx2xTYANNdPHP2Fq3TCxj6aecY+07GCXj6BIdSiS9TyYD
	+jZptlE1NwPSGoVzWmd4XCMNmYu5b7IM5GkjJ25bh5eNSf6m9Wys60Ba4nN2YMxMKy9QqvY2Zdnh
	ptemAZ0rMEAcl56dAW15QLVmSa18Vz4XHYo1o5p/NrWs1hsVd3F4+3oPhix6vVEWlxgeEZ2Mx/Vd
	gfMbEsylEs7I32WYe2z2Fm6TB30fz+kbBC7VHqLt/J9GrQONey6JabAjbRIpuXet8zx8IHyHbjDS
	ee4gFubRTG/7dlq/tntAwyxGXow/9jxalbHvkxufsQMQkPIFyIOlvbPA4yItAXrajTnbGu5hlYrW
	ZP9JepYLX7/wBEDMvxdVvORvn2jzVppSN9CUJyOBo4sAh28KI08YMXO09A9ktKJzzyDlp50MsxcA
	zELbXyThO1ghMgzd15OhbIH349CmUpHvqBGien1KMR/O0xOFrglzN5AsmeTJDdCANWFXBHYmFRnr
	hyfJRiNj8Vb9BZ1qn/Vi+3dnGSLakEa5+j5m1HX6a/OggiN6fjLSR397Xowu2QwwVQK61iGm9dNZ
	XYIi1qKc+/jIvAvHOsXzB5VmxXYgSATKVPi4DaAqHgHKJ+1BojyecaqBlN9HirAv1mG5gFu2IqtX
	I=

Account for the IP version of the tunnel when accounting skb headroom on
xmit. This avoids having to potentially copy the skb a second time down
the stack due to allocating not enough space for IPv6 headers in case
the tunnel uses IPv6.

Fixes: b784e7ebfce8 ("L2TP:Adjust intf MTU, add underlay L3, L2 hdrs.")
Signed-off-by: David Bauer <mail@david-bauer.net>
---
 net/l2tp/l2tp_core.c | 3 ++-
 net/l2tp/l2tp_core.h | 1 +
 net/l2tp/l2tp_eth.c  | 9 ++-------
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 687c1366a4d0f..b07b4861f2f59 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1234,7 +1234,7 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 	 * make room. Adjust truesize.
 	 */
 	uhlen = (tunnel->encap == L2TP_ENCAPTYPE_UDP) ? sizeof(*uh) : 0;
-	headroom = NET_SKB_PAD + sizeof(struct iphdr) + uhlen + session->hdr_len;
+	headroom = NET_SKB_PAD + tunnel->l3_overhead + uhlen + session->hdr_len;
 	if (skb_cow_head(skb, headroom)) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
@@ -1680,6 +1680,7 @@ int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
 	}
 
 	sk->sk_allocation = GFP_ATOMIC;
+	tunnel->l3_overhead = kernel_sock_ip_overhead(sk);
 	release_sock(sk);
 
 	sock_hold(sk);
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index ffd8ced3a51ff..aab574376d95f 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -167,6 +167,7 @@ struct l2tp_tunnel {
 	u32			tunnel_id;
 	u32			peer_tunnel_id;
 	int			version;	/* 2=>L2TPv2, 3=>L2TPv3 */
+	int			l3_overhead;	/* IP header overhead */
 
 	char			name[L2TP_TUNNEL_NAME_MAX]; /* for logging */
 	enum l2tp_encap_type	encap;
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index cf0b66f4fb29b..709e1fb1b2e3c 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -187,7 +187,6 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 				struct net_device *dev)
 {
 	unsigned int overhead = 0;
-	u32 l3_overhead = 0;
 	u32 mtu;
 
 	/* if the encap is UDP, account for UDP header size */
@@ -196,11 +195,7 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 		dev->needed_headroom += sizeof(struct udphdr);
 	}
 
-	lock_sock(tunnel->sock);
-	l3_overhead = kernel_sock_ip_overhead(tunnel->sock);
-	release_sock(tunnel->sock);
-
-	if (l3_overhead == 0) {
+	if (tunnel->l3_overhead == 0) {
 		/* L3 Overhead couldn't be identified, this could be
 		 * because tunnel->sock was NULL or the socket's
 		 * address family was not IPv4 or IPv6,
@@ -211,7 +206,7 @@ static void l2tp_eth_adjust_mtu(struct l2tp_tunnel *tunnel,
 	/* Adjust MTU, factor overhead - underlay L3, overlay L2 hdr
 	 * UDP overhead, if any, was already factored in above.
 	 */
-	overhead += session->hdr_len + ETH_HLEN + l3_overhead;
+	overhead += session->hdr_len + ETH_HLEN + tunnel->l3_overhead;
 
 	mtu = l2tp_tunnel_dst_mtu(tunnel) - overhead;
 	if (mtu < dev->min_mtu || mtu > dev->max_mtu)
-- 
2.51.0


