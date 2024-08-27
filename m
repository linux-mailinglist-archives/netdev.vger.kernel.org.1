Return-Path: <netdev+bounces-122291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDD9609A3
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A4E287340
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074611A0B0C;
	Tue, 27 Aug 2024 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SOGPlJDu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE991A2C2D
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724760419; cv=none; b=JTHsxl5XOl2LQcqVPjcvCcDE06DJA0iNhVhgnTvFB4ifGVnKm21SpcWcinswPcPQG2kpI5OknVmMUlFrsyOsmJqGhHCEXuaYW9UqfFjG2w0oHL21md2XqzkFzfVZzU5B0UJYuhkgmaTn5+jS65hy3X6QQgys/1Re5EQHL+NF4HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724760419; c=relaxed/simple;
	bh=CuQqeXOp202blbLrhLWZf9tZv1DvWnzjK2L1ps/5IIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEkJA532l0+uLIHpiwQLAANXhLpdJ5L7AbLp0P19tgpFVgwqB0iXF0F2dZ+jykcoCjobX67pX/h5UxQMfG7B7oFhR01ZucyHC241gYv0riO/hnDU9DS7CtPL8cD7IWs2SQSpoN7J1qmG4/+2IIg5Xo5mUx0tybbCucP9rIqzH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SOGPlJDu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42808071810so46902995e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1724760416; x=1725365216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaDaJ1x2uvxkSNsBnbIPfI/+C7ONYX1yRfCw4NNMLsQ=;
        b=SOGPlJDuPcioLt486QB9X0feBBdSu4GHzAM5i4GkhtaRUGWFTeW5WWkN5apidwUPoV
         KKUfQ1S9BBeMjAFoBXrNd9FOodUhZjsLaA7u4kJzIHT3pEd+OFCP6h6xRskj6vwUdfDE
         pjI2yUWKVy7aOavZ+KxA5pLh3RBt1UjoW2Xc8bQBgOaFLZr41VoJtL9z/kycWfV1WQll
         oMqnTuhvejKstw1u6QbCG6UlGvGpGTyFVWWVxy9SfKKQooznTspI2KFO14uA9qpveV9+
         CeCzjsoCP6jmKSjpgLJoKey7NyrB5hZyXA5kkBpiudJBlPmfPEiCubljUq5dGxPDwQQn
         IgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724760416; x=1725365216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaDaJ1x2uvxkSNsBnbIPfI/+C7ONYX1yRfCw4NNMLsQ=;
        b=f5DSP+ve6PHFr6ls00Jd/kJi4jWlqg6ZbJlVvBAOVgMvMjnkkOwz40I0Sif/5yC/0T
         WguVm+PA/tSldbM6qWMw2KGeCVsikMNHv1zc+PfqyokNd8G1vxtIoz+03c8Csvj0NxcP
         LP8rBmBYSVVP4D8dU/W2yrIY5F2AiQgjmp42GWy0dJxjPzCwfOCKDOK1K5PxBRvIijXW
         JozGZJms3q1BS1LpJiLlluqOrUcSpOgiI4bNvot3xB8+2qJbA6UcrV02M9VwQc5LYRC+
         QoI+ZSIRuEa9lDIyaCpDHVg4tOewkYmcYdawRkITVc8nyLPMsD+0x6f5sjWSWmti/8JW
         v45g==
X-Gm-Message-State: AOJu0YxrUpiwpAByDfsHTkTsr1Td2Xce84rEmj9KDQN2Kc/o6pxct8RF
	UYmXxjoxQUdGAhVf0mQzoW+eatEZp1IJzj21E8bVsrnVz5utj8yv1mkm/IKlxxXTOeJn5mhVvZ/
	T
X-Google-Smtp-Source: AGHT+IGHLFFruldWL0SD24QgHHR1HesLymbS/LS2T9H8Ue9USc5U8gKhz2ycJ9OdH4+d4viTI8IHZg==
X-Received: by 2002:adf:f089:0:b0:368:584f:9e08 with SMTP id ffacd0b85a97d-3748c7cd777mr1749542f8f.22.1724760415750;
        Tue, 27 Aug 2024 05:06:55 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:69a:caae:ca68:74ad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5158f14sm187273765e9.16.2024.08.27.05.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:06:55 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v6 16/25] ovpn: implement peer lookup logic
Date: Tue, 27 Aug 2024 14:07:56 +0200
Message-ID: <20240827120805.13681-17-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240827120805.13681-1-antonio@openvpn.net>
References: <20240827120805.13681-1-antonio@openvpn.net>
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
 drivers/net/ovpn/peer.c | 270 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 262 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 58037c2cbcca..1225032e605c 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -10,6 +10,7 @@
 #include <linux/skbuff.h>
 #include <linux/list.h>
 #include <linux/hashtable.h>
+#include <net/ip6_route.h>
 
 #include "ovpnstruct.h"
 #include "bind.h"
@@ -126,6 +127,92 @@ static bool ovpn_peer_skb_to_sockaddr(struct sk_buff *skb,
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
+#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
+	typeof(_tbl) *__tbl = &(_tbl);				\
+	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
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
@@ -203,14 +290,44 @@ ovpn_peer_get_by_transp_addr_p2p(struct ovpn_struct *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
 					       struct sk_buff *skb)
 {
-	struct ovpn_peer *peer = NULL;
+	struct ovpn_peer *tmp, *peer = NULL;
 	struct sockaddr_storage ss = { 0 };
+	struct hlist_nulls_head *nhead;
+	struct hlist_nulls_node *ntmp;
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
+	nhead = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &ss, sa_len);
+
+	rcu_read_lock();
+	hlist_nulls_for_each_entry_rcu(tmp, ntmp, nhead,
+				       hash_entry_transp_addr) {
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
@@ -245,10 +362,27 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_struct *ovpn,
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
@@ -270,6 +404,8 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 				       struct sk_buff *skb)
 {
 	struct ovpn_peer *peer = NULL;
+	struct in6_addr addr6;
+	__be32 addr4;
 
 	/* in P2P mode, no matter the destination, packets are always sent to
 	 * the single peer listening on the other side
@@ -280,11 +416,109 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 		if (unlikely(peer && !ovpn_peer_hold(peer)))
 			peer = NULL;
 		rcu_read_unlock();
+		return peer;
 	}
 
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
+	}
+
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
@@ -297,6 +531,8 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
 			    struct ovpn_peer *peer)
 {
 	bool match = false;
+	struct in6_addr addr6;
+	__be32 addr4;
 
 	if (ovpn->mode == OVPN_MODE_P2P) {
 		/* in P2P mode, no matter the destination, packets are always
@@ -305,15 +541,33 @@ bool ovpn_peer_check_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb,
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
 }
 
-#define ovpn_get_hash_head(_tbl, _key, _key_len) ({		\
-	typeof(_tbl) *__tbl = &(_tbl);				\
-	(&(*__tbl)[jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl)]); }) \
-
 /**
  * ovpn_peer_add_mp - add peer to related tables in a MP instance
  * @ovpn: the instance to add the peer to
-- 
2.44.2


