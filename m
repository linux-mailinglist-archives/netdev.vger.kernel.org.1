Return-Path: <netdev+bounces-107276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53191A75A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C419A281F5C
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D0218A935;
	Thu, 27 Jun 2024 13:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="B1hWbh7v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6ED186E59
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493695; cv=none; b=QHVDNK6b2Zy7FwD7/06haZYSZIT4F0uwzO+Fp0YUbjhy78mx+LnceVQMUycsfQVciRvC1MSsaRXPCWm1jaNItqKM+39djUwCwViSL/a+uDZ04y+7Iae3pIcFSd7gTgiUblhJDNVZOqHq5RxVTR3ZbyhuEWbTEtJqhsC6E1DzeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493695; c=relaxed/simple;
	bh=dmJwUAiskJaEgrKTsduUNqhmmmSXjXa6w9WDtdlNohM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bB/p1wpLTugadvZDZd1Z5qdaysPUmaipqgdeJ8E0vEmWsE5UMuB5RAim9kiqbenSIBVh8ocSe5AikPYrzaMI521hJEMKIa5UkNmleQF0Zag++JDpF2VLyuUXi5doyEEDuCqJCWRQl6gYcBsj2Lbz0L1BE2A/RLZOzTXMrvEOfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=B1hWbh7v; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so1085066f8f.1
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719493691; x=1720098491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOvM5S3whYEL2igzp4f8omXKIS7wTl2TEf6lvFT6b2c=;
        b=B1hWbh7vZxM+Pt0RKOWJiBVcmALCjuvUfiA97rvlP4fvpucyKUksB0MFwocINdQDfA
         3XS+eAI1qiXi8vtiSCAagz6c6x52YDMrKSC+efWCkZ4xzokTulSFP4tjNVcyzQccuTgA
         XZEX743P+zOBTuhtQuzaitUwvYAzWazUfzABL2z8kDenClGeajio2odcnSAuMYLnNbBm
         cF3W7KvurcaEinn+oTrcwq4ZGlbEUDtiTfejUMkniVaMUgu5oOYTAd1x0MGlviUr/ENy
         DvdRFJx9P+q+9E2VNv3ux5WV+dIkooBfrycwLhCo0Jt5EduUBfB6NGAfGeiqrBNeuu0C
         GxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719493691; x=1720098491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOvM5S3whYEL2igzp4f8omXKIS7wTl2TEf6lvFT6b2c=;
        b=Ee0n8wJbp7Ok76DRNte50Z537/DmFpKkukiiqfbMRN+/GVViFasxfg+GhiQOLAblOw
         CCfD1d925Xs0Y1BLytHABCPSTu50+FQoQ/5RZKDiPCaRGYXq/muDc91m9/U4U+BFhDiB
         rdtywjmM2UNqAUGQja05RA3bGNqplvko39tbJB+zz6osABzO4oolvggdNdOpCuKtWToC
         XJBnLDdDitHgJWt6xHDEWJMcT0TYydlRvM01VCgVC3hHUqYwxN7aZbqfOgeapCJMEepm
         e9sgo53UJuNFk+nxnbOP/OSYSRmZWNJNx+ekr1PDt4CTQ09daL188dQgx6AZI/7fhgn8
         GaBw==
X-Gm-Message-State: AOJu0YwyOeW43SmsnVQfW96jnA2ipTL04YT5CPAUSXVbReF+HXobLbBJ
	P/x2JpWXSGL/0wwJfWRPGbadixHUnV/338QM0GLrN5c5FQTxJXzYCUycnOb5I0p7TSbCl/0QDx+
	M
X-Google-Smtp-Source: AGHT+IEltD3b0PKacOCkD4RP6aIGihuXSG+HWZQBoXMJ1kWyhCb7NBPjwrTSH5gBs1Mvi0UsdEAepg==
X-Received: by 2002:a5d:64e6:0:b0:366:ee84:6a77 with SMTP id ffacd0b85a97d-3674176ca43mr2320303f8f.3.1719493691186;
        Thu, 27 Jun 2024 06:08:11 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564b6583asm26177475e9.15.2024.06.27.06.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 06:08:10 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	ryazanov.s.a@gmail.com,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v5 16/25] ovpn: implement peer lookup logic
Date: Thu, 27 Jun 2024 15:08:34 +0200
Message-ID: <20240627130843.21042-17-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240627130843.21042-1-antonio@openvpn.net>
References: <20240627130843.21042-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a multi-peer scenario there are a number of situations when a
specific peer needs to be looked up.

We may want to lookup a peer by:
1. its ID
2. its VPN destination IP
3. its transport IP/port couple

For each of the above, there is a specific routing table referencing all
peers for fast look up.

Case 2. is a bit special in the sense that an outgoing packet may not be
sent to the peer VPN IP directly, but rather to a network behind it. For
this reason we first perform a nexthop lookup in the system routing
table and then we use the retrieved nexthop as peer search key.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 299 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 274 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 2b5e2bbb2578..8c23268db916 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -10,6 +10,7 @@
 #include <linux/skbuff.h>
 #include <linux/list.h>
 #include <linux/hashtable.h>
+#include <net/ip6_route.h>
 
 #include "ovpnstruct.h"
 #include "bind.h"
@@ -65,9 +66,6 @@ struct ovpn_peer *ovpn_peer_new(struct ovpn_struct *ovpn, u32 id)
 	return peer;
 }
 
-#define ovpn_peer_index(_tbl, _key, _key_len)		\
-	(jhash(_key, _key_len, 0) % HASH_SIZE(_tbl))	\
-
 /**
  * ovpn_peer_release - release peer private members
  * @peer: the peer to release
@@ -129,6 +127,91 @@ static bool ovpn_peer_skb_to_sockaddr(struct sk_buff *skb,
 	return true;
 }
 
+/**
+ * ovpn_nexthop_from_skb4 - retrieve IPv4 nexthop for outgoing skb
+ * @skb: the outgoing packet
+ *
+ * Return: the IPv4 of the nexthop
+ */
+static __be32 ovpn_nexthop_from_skb4(struct sk_buff *skb)
+{
+	const struct rtable *rt = skb_rtable(skb);
+
+	if (rt && rt->rt_uses_gateway)
+		return rt->rt_gw4;
+
+	return ip_hdr(skb)->daddr;
+}
+
+/**
+ * ovpn_nexthop_from_skb6 - retrieve IPv6 nexthop for outgoing skb
+ * @skb: the outgoing packet
+ *
+ * Return: the IPv6 of the nexthop
+ */
+static struct in6_addr ovpn_nexthop_from_skb6(struct sk_buff *skb)
+{
+	const struct rt6_info *rt = skb_rt6_info(skb);
+
+	if (!rt || !(rt->rt6i_flags & RTF_GATEWAY))
+		return ipv6_hdr(skb)->daddr;
+
+	return rt->rt6i_gateway;
+}
+
+#define ovpn_get_hash_head(_tbl, _key, _key_len)		\
+	(&(_tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(_tbl)])	\
+
+/**
+ * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
+ * @ovpn: the openvpn instance to search
+ * @addr: VPN IPv4 to use as search key
+ *
+ * Refcounter is not increased for the returned peer.
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *ovpn_peer_get_by_vpn_addr4(struct ovpn_struct *ovpn,
+						    __be32 addr)
+{
+	struct hlist_head *head;
+	struct ovpn_peer *tmp;
+
+	head = ovpn_get_hash_head(ovpn->peers->by_vpn_addr, &addr,
+				  sizeof(addr));
+
+	hlist_for_each_entry_rcu(tmp, head, hash_entry_addr4)
+		if (addr == tmp->vpn_addrs.ipv4.s_addr)
+			return tmp;
+
+	return NULL;
+}
+
+/**
+ * ovpn_peer_get_by_vpn_addr6 - retrieve peer by its VPN IPv6 address
+ * @ovpn: the openvpn instance to search
+ * @addr: VPN IPv6 to use as search key
+ *
+ * Refcounter is not increased for the returned peer.
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct ovpn_struct *ovpn,
+						    struct in6_addr *addr)
+{
+	struct hlist_head *head;
+	struct ovpn_peer *tmp;
+
+	head = ovpn_get_hash_head(ovpn->peers->by_vpn_addr, addr,
+				  sizeof(*addr));
+
+	hlist_for_each_entry_rcu(tmp, head, hash_entry_addr6)
+		if (ipv6_addr_equal(addr, &tmp->vpn_addrs.ipv6))
+			return tmp;
+
+	return NULL;
+}
+
 /**
  * ovpn_peer_transp_match - check if sockaddr and peer binding match
  * @peer: the peer to get the binding from
@@ -205,14 +288,42 @@ ovpn_peer_get_by_transp_addr_p2p(struct ovpn_struct *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
 					       struct sk_buff *skb)
 {
-	struct ovpn_peer *peer = NULL;
+	struct ovpn_peer *tmp, *peer = NULL;
 	struct sockaddr_storage ss = { 0 };
+	struct hlist_head *head;
+	size_t sa_len;
 
 	if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
 		return NULL;
 
 	if (ovpn->mode == OVPN_MODE_P2P)
-		peer = ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
+		return ovpn_peer_get_by_transp_addr_p2p(ovpn, &ss);
+
+	switch (ss.ss_family) {
+	case AF_INET:
+		sa_len = sizeof(struct sockaddr_in);
+		break;
+	case AF_INET6:
+		sa_len = sizeof(struct sockaddr_in6);
+		break;
+	default:
+		return NULL;
+	}
+
+	head = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &ss, sa_len);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp, head, hash_entry_transp_addr) {
+		if (!ovpn_peer_transp_match(tmp, &ss))
+			continue;
+
+		if (!ovpn_peer_hold(tmp))
+			continue;
+
+		peer = tmp;
+		break;
+	}
+	rcu_read_unlock();
 
 	return peer;
 }
@@ -247,10 +358,27 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_struct *ovpn,
  */
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
 {
-	struct ovpn_peer *peer = NULL;
+	struct ovpn_peer *tmp, *peer = NULL;
+	struct hlist_head *head;
 
 	if (ovpn->mode == OVPN_MODE_P2P)
-		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
+		return ovpn_peer_get_by_id_p2p(ovpn, peer_id);
+
+	head = ovpn_get_hash_head(ovpn->peers->by_id, &peer_id,
+				  sizeof(peer_id));
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp, head, hash_entry_id) {
+		if (tmp->id != peer_id)
+			continue;
+
+		if (!ovpn_peer_hold(tmp))
+			continue;
+
+		peer = tmp;
+		break;
+	}
+	rcu_read_unlock();
 
 	return peer;
 }
@@ -272,6 +400,8 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 				       struct sk_buff *skb)
 {
 	struct ovpn_peer *peer = NULL;
+	struct in6_addr addr6;
+	__be32 addr4;
 
 	/* in P2P mode, no matter the destination, packets are always sent to
 	 * the single peer listening on the other side
@@ -282,11 +412,109 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 		if (unlikely(peer && !ovpn_peer_hold(peer)))
 			peer = NULL;
 		rcu_read_unlock();
+		return peer;
+	}
+
+	rcu_read_lock();
+	switch (skb_protocol_to_family(skb)) {
+	case AF_INET:
+		addr4 = ovpn_nexthop_from_skb4(skb);
+		peer = ovpn_peer_get_by_vpn_addr4(ovpn, addr4);
+		break;
+	case AF_INET6:
+		addr6 = ovpn_nexthop_from_skb6(skb);
+		peer = ovpn_peer_get_by_vpn_addr6(ovpn, &addr6);
+		break;
 	}
 
+	if (unlikely(peer && !ovpn_peer_hold(peer)))
+		peer = NULL;
+	rcu_read_unlock();
+
 	return peer;
 }
 
+/**
+ * ovpn_nexthop_from_rt4 - look up the IPv4 nexthop for the given destination
+ * @ovpn: the private data representing the current VPN session
+ * @dest: the destination to be looked up
+ *
+ * Looks up in the IPv4 system routing table the IP of the nexthop to be used
+ * to reach the destination passed as argument. If no nexthop can be found, the
+ * destination itself is returned as it probably has to be used as nexthop.
+ *
+ * Return: the IP of the next hop if found or dest itself otherwise
+ */
+static __be32 ovpn_nexthop_from_rt4(struct ovpn_struct *ovpn, __be32 dest)
+{
+	struct rtable *rt;
+	struct flowi4 fl = {
+		.daddr = dest
+	};
+
+	rt = ip_route_output_flow(dev_net(ovpn->dev), &fl, NULL);
+	if (IS_ERR(rt)) {
+		net_dbg_ratelimited("%s: no route to host %pI4\n", __func__,
+				    &dest);
+		/* if we end up here this packet is probably going to be
+		 * thrown away later
+		 */
+		return dest;
+	}
+
+	if (!rt->rt_uses_gateway)
+		goto out;
+
+	dest = rt->rt_gw4;
+out:
+	ip_rt_put(rt);
+	return dest;
+}
+
+/**
+ * ovpn_nexthop_from_rt6 - look up the IPv6 nexthop for the given destination
+ * @ovpn: the private data representing the current VPN session
+ * @dest: the destination to be looked up
+ *
+ * Looks up in the IPv6 system routing table the IP of the nexthop to be used
+ * to reach the destination passed as argument. If no nexthop can be found, the
+ * destination itself is returned as it probably has to be used as nexthop.
+ *
+ * Return: the IP of the next hop if found or dest itself otherwise
+ */
+static struct in6_addr ovpn_nexthop_from_rt6(struct ovpn_struct *ovpn,
+					     struct in6_addr dest)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	struct dst_entry *entry;
+	struct rt6_info *rt;
+	struct flowi6 fl = {
+		.daddr = dest,
+	};
+
+	entry = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
+						NULL);
+	if (IS_ERR(entry)) {
+		net_dbg_ratelimited("%s: no route to host %pI6c\n", __func__,
+				    &dest);
+		/* if we end up here this packet is probably going to be
+		 * thrown away later
+		 */
+		return dest;
+	}
+
+	rt = dst_rt6_info(entry);
+
+	if (!(rt->rt6i_flags & RTF_GATEWAY))
+		goto out;
+
+	dest = rt->rt6i_gateway;
+out:
+	dst_release((struct dst_entry *)rt);
+#endif
+	return dest;
+}
+
 /**
  * ovpn_peer_check_by_src - check that skb source is routed via peer
  * @ovpn: the openvpn instance to search
@@ -299,6 +527,8 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer)
 {
 	bool match = false;
+	struct in6_addr addr6;
+	__be32 addr4;
 
 	if (ovpn->mode == OVPN_MODE_P2P) {
 		/* in P2P mode, no matter the destination, packets are always
@@ -307,6 +537,28 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 		rcu_read_lock();
 		match = (peer == rcu_dereference(ovpn->peer));
 		rcu_read_unlock();
+		return match;
+	}
+
+	/* This function performs a reverse path check, therefore we now
+	 * lookup the nexthop we would use if we wanted to route a packet
+	 * to the source IP. If the nexthop matches the sender we know the
+	 * latter is valid and we allow the packet to come in
+	 */
+
+	switch (skb_protocol_to_family(skb)) {
+	case AF_INET:
+		addr4 = ovpn_nexthop_from_rt4(ovpn, ip_hdr(skb)->saddr);
+		rcu_read_lock();
+		match = (peer == ovpn_peer_get_by_vpn_addr4(ovpn, addr4));
+		rcu_read_unlock();
+		break;
+	case AF_INET6:
+		addr6 = ovpn_nexthop_from_rt6(ovpn, ipv6_hdr(skb)->saddr);
+		rcu_read_lock();
+		match = (peer == ovpn_peer_get_by_vpn_addr6(ovpn, &addr6));
+		rcu_read_unlock();
+		break;
 	}
 
 	return match;
@@ -324,11 +576,11 @@ static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 	struct sockaddr_storage sa = { 0 };
 	struct sockaddr_in6 *sa6;
 	struct sockaddr_in *sa4;
+	struct hlist_head *head;
 	struct ovpn_bind *bind;
 	struct ovpn_peer *tmp;
 	size_t salen;
 	int ret = 0;
-	u32 index;
 
 	spin_lock_bh(&ovpn->peers->lock);
 	/* do not add duplicates */
@@ -364,30 +616,27 @@ static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
 			goto unlock;
 		}
 
-		index = ovpn_peer_index(ovpn->peers->by_transp_addr, &sa,
-					salen);
-		hlist_add_head_rcu(&peer->hash_entry_transp_addr,
-				   &ovpn->peers->by_transp_addr[index]);
+		head = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &sa,
+					  salen);
+		hlist_add_head_rcu(&peer->hash_entry_transp_addr, head);
 	}
 
-	index = ovpn_peer_index(ovpn->peers->by_id, &peer->id,
-				sizeof(peer->id));
-	hlist_add_head_rcu(&peer->hash_entry_id, &ovpn->peers->by_id[index]);
+	hlist_add_head_rcu(&peer->hash_entry_id,
+			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
+					      sizeof(peer->id)));
 
 	if (peer->vpn_addrs.ipv4.s_addr != htonl(INADDR_ANY)) {
-		index = ovpn_peer_index(ovpn->peers->by_vpn_addr,
-					&peer->vpn_addrs.ipv4,
-					sizeof(peer->vpn_addrs.ipv4));
-		hlist_add_head_rcu(&peer->hash_entry_addr4,
-				   &ovpn->peers->by_vpn_addr[index]);
+		head = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
+					  &peer->vpn_addrs.ipv4,
+					  sizeof(peer->vpn_addrs.ipv4));
+		hlist_add_head_rcu(&peer->hash_entry_addr4, head);
 	}
 
 	if (!ipv6_addr_any(&peer->vpn_addrs.ipv6)) {
-		index = ovpn_peer_index(ovpn->peers->by_vpn_addr,
-					&peer->vpn_addrs.ipv6,
-					sizeof(peer->vpn_addrs.ipv6));
-		hlist_add_head_rcu(&peer->hash_entry_addr6,
-				   &ovpn->peers->by_vpn_addr[index]);
+		head = ovpn_get_hash_head(ovpn->peers->by_vpn_addr,
+					  &peer->vpn_addrs.ipv6,
+					  sizeof(peer->vpn_addrs.ipv6));
+		hlist_add_head_rcu(&peer->hash_entry_addr6, head);
 	}
 
 unlock:
-- 
2.44.2


