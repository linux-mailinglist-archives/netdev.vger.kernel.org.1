Return-Path: <netdev+bounces-77141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC68704E8
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159BA1F23044
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF94AEE3;
	Mon,  4 Mar 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="LxLoIC2I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC847793
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564961; cv=none; b=ODGPlqfJs0OGZ3C/B7IzouFSYtqO/SRCNzY2aAZ+Qh6DBpJPsRvUO4Y5C9fAXIdbCjAnwXwPctJ6rDq+QSfkA6GUIkYPnUUqrYkxB/Mo5L/RdEbzAtfTGmrxDA/gjWEwdYdNMe1VQfi/o9FcmBsOTxi0745fmYeGYBt7HRhazSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564961; c=relaxed/simple;
	bh=A69vsMj2GoXYB7W9AgjIXBm3o/wKhxGCRkftuw4Xgik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQBE6VGtpTpn8RcX5fbb5E1HY8JLKDAoLCQZZ347PuMtVtZjvMXn2pK3RGG7ofQdTSV4hB53FqtITKXwGVh0bap9oHciCgaen2OiPM7nxca3nNj0fTzA7t3LV1evccHkj38heaiOGaGRTuLuPOT7N/MwiOh5S0qDGJBT9Vrk0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=LxLoIC2I; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d33986dbc0so39702131fa.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564956; x=1710169756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3oRiEp3NZs/xKxeXglzjnRdqrECAVpXc+2oNcRP5fg=;
        b=LxLoIC2It8KClESAfnwxaFzQQPNZqw5B3g1AgFBlUkCl0RrThuGYXVHBWIDW7+V9nB
         frjDDF+2rWO98DDwhmMb2mSiK0sGhgp17MMWSI4zH2D/HM48Ir3GKUh4TC64PZioytwr
         MyJqiacmI27DiY2E0dG7sWDpVp5Viok6BFhZM4thsU5VDZRLno1aZiUxHzG3tuH2TAbz
         34Qu3p/30vmdF4UFwigAded+DJvnFnkY0tZE8kDhAygWsjGq4/0B8TwsWY0EFHOvl79E
         KOUa1rxb6qdM3dx5nsY20Hn+ynshR3dDsnj592zAUqd+qBTGpTX2VwwcqNIJk0n5i/52
         AZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564956; x=1710169756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3oRiEp3NZs/xKxeXglzjnRdqrECAVpXc+2oNcRP5fg=;
        b=W7eHwnx9j0JeKJ+kM4z7ruVUL03JvV18pDn70Yo1TTUBjVBR7LTXC4l2dUY/ghc9rR
         belPG1BA7LUtaVCQK6rXrqGIqtG7VM8zMmKnlQCEe5rfNCSjUO0Mhu2n8qIe3xOxWpJ4
         nlLFy8JallVQU9mWAsspTXWyBZVq6yyaALgxS1K/n9kaRFcbSVSom68kCnJA+BIqtUAe
         YDoZTLAFJCjpTrhsxYmgIuQhfJd2yoVNpuL+HxonmoGgzspbcMIUP0nuE1vcopbzQXSP
         3mge9ZSlVW3VXemJZIwBHFYZmNBbar4XaJPwztfCnt7ttXOlrQYjHcviym31DXsvoS3C
         p5kA==
X-Gm-Message-State: AOJu0YyLcyns+wejQWXuWGhmnO+PcsWBL0gKWM5kHoT92n/rg0AGmw8h
	oDQCTG4JP7uWMB8mp7Uu5KHMprW6ix+5VMG4R3MrPA5N7Bkkzt7oAjRska0bbsWxvd1pxB2jcGW
	t
X-Google-Smtp-Source: AGHT+IEBH1KG89NhDHgTl7A3wi55Axgeq867goMvwoyvrX7nSW2ODBMgcCzvy/9ASdalvtxVbpa8Uw==
X-Received: by 2002:a05:6512:716:b0:513:1385:c943 with SMTP id b22-20020a056512071600b005131385c943mr5631739lfs.40.1709564956285;
        Mon, 04 Mar 2024 07:09:16 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:15 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 14/22] ovpn: implement peer lookup logic
Date: Mon,  4 Mar 2024 16:09:05 +0100
Message-ID: <20240304150914.11444-15-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
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
3. its tranport IP/port couple

For each of the above, there is a specific routing table referencing all
peers for fast look up.

Case 2. is a bit special in the sense that an outgoing packet may not be
sent to the peer VPN IP directly, but rather to a network behind it. For
this reason we first perform a nexthop lookup in the system routing
table and then we use the retrieved nexthop as peer search key.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 283 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 259 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 6c2c6877d539..acef27b1ca5d 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -153,6 +153,69 @@ void ovpn_peer_release_kref(struct kref *kref)
 	queue_work(peer->ovpn->events_wq, &peer->delete_work);
 }
 
+static __be32 ovpn_nexthop_from_rt4(struct sk_buff *skb)
+{
+	struct rtable *rt = skb_rtable(skb);
+
+	if (rt && rt->rt_uses_gateway)
+		return rt->rt_gw4;
+
+	return ip_hdr(skb)->daddr;
+}
+
+static struct in6_addr ovpn_nexthop_from_rt6(struct sk_buff *skb)
+{
+	struct rt6_info *rt = (struct rt6_info *)skb_rtable(skb);
+
+	if (!rt || !(rt->rt6i_flags & RTF_GATEWAY))
+		return ipv6_hdr(skb)->daddr;
+
+	return rt->rt6i_gateway;
+}
+
+static struct ovpn_peer *ovpn_peer_lookup_vpn_addr4(struct hlist_head *head, __be32 *addr)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp, head, hash_entry_addr4) {
+		if (*addr != tmp->vpn_addrs.ipv4.s_addr)
+			continue;
+
+		if (!ovpn_peer_hold(tmp))
+			continue;
+
+		peer = tmp;
+		break;
+	}
+	rcu_read_unlock();
+
+	return peer;
+}
+
+static struct ovpn_peer *ovpn_peer_lookup_vpn_addr6(struct hlist_head *head, struct in6_addr *addr)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+	int i;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp, head, hash_entry_addr6) {
+		for (i = 0; i < 4; i++) {
+			if (addr->s6_addr32[i] != tmp->vpn_addrs.ipv6.s6_addr32[i])
+				continue;
+		}
+
+		if (!ovpn_peer_hold(tmp))
+			continue;
+
+		peer = tmp;
+		break;
+	}
+	rcu_read_unlock();
+
+	return peer;
+}
+
 /**
  * ovpn_peer_lookup_by_dst() - Lookup peer to send skb to
  *
@@ -170,6 +233,11 @@ void ovpn_peer_release_kref(struct kref *kref)
 struct ovpn_peer *ovpn_peer_lookup_by_dst(struct ovpn_struct *ovpn, struct sk_buff *skb)
 {
 	struct ovpn_peer *tmp, *peer = NULL;
+	struct hlist_head *head;
+	sa_family_t sa_fam;
+	struct in6_addr addr6;
+	__be32 addr4;
+	u32 index;
 
 	/* in P2P mode, no matter the destination, packets are always sent to the single peer
 	 * listening on the other side
@@ -180,14 +248,111 @@ struct ovpn_peer *ovpn_peer_lookup_by_dst(struct ovpn_struct *ovpn, struct sk_bu
 		if (likely(tmp && ovpn_peer_hold(tmp)))
 			peer = tmp;
 		rcu_read_unlock();
+		return peer;
+	}
+
+	sa_fam = skb_protocol_to_family(skb);
+
+	switch (sa_fam) {
+	case AF_INET:
+		addr4 = ovpn_nexthop_from_rt4(skb);
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr4, sizeof(addr4));
+		head = &ovpn->peers.by_vpn_addr[index];
+
+		peer = ovpn_peer_lookup_vpn_addr4(head, &addr4);
+		break;
+	case AF_INET6:
+		addr6 = ovpn_nexthop_from_rt6(skb);
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr6, sizeof(addr6));
+		head = &ovpn->peers.by_vpn_addr[index];
+
+		peer = ovpn_peer_lookup_vpn_addr6(head, &addr6);
+		break;
 	}
 
 	return peer;
 }
 
+/**
+ * ovpn_nexthop_lookup4() - looks up the IP of the nexthop for the given destination
+ *
+ * Looks up in the IPv4 system routing table the IP of the nexthop to be used
+ * to reach the destination passed as argument. If no nexthop can be found, the
+ * destination itself is returned as it probably has to be used as nexthop.
+ *
+ * @ovpn: the private data representing the current VPN session
+ * @dst: the destination to be looked up
+ *
+ * Return the IP of the next hop if found or the dst itself otherwise
+ */
+static __be32 ovpn_nexthop_lookup4(struct ovpn_struct *ovpn, __be32 src)
+{
+	struct rtable *rt;
+	struct flowi4 fl = {
+		.daddr = src
+	};
+
+	rt = ip_route_output_flow(dev_net(ovpn->dev), &fl, NULL);
+	if (IS_ERR(rt)) {
+		net_dbg_ratelimited("%s: no nexthop found for %pI4\n", ovpn->dev->name, &src);
+		/* if we end up here this packet is probably going to be
+		 * thrown away later
+		 */
+		return src;
+	}
+
+	if (!rt->rt_uses_gateway)
+		goto out;
+
+	src = rt->rt_gw4;
+out:
+	return src;
+}
+
+/**
+ * ovpn_nexthop_lookup6() - looks up the IPv6 of the nexthop for the given destination
+ *
+ * Looks up in the IPv6 system routing table the IP of the nexthop to be used
+ * to reach the destination passed as argument. If no nexthop can be found, the
+ * destination itself is returned as it probably has to be used as nexthop.
+ *
+ * @ovpn: the private data representing the current VPN session
+ * @dst: the destination to be looked up
+ *
+ * Return the IP of the next hop if found or the dst itself otherwise
+ */
+static struct in6_addr ovpn_nexthop_lookup6(struct ovpn_struct *ovpn, struct in6_addr addr)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	struct rt6_info *rt;
+	struct flowi6 fl = {
+		.daddr = addr,
+	};
+
+	rt = (struct rt6_info *)ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
+								NULL);
+	if (IS_ERR(rt)) {
+		net_dbg_ratelimited("%s: no nexthop found for %pI6\n", ovpn->dev->name, &addr);
+		/* if we end up here this packet is probably going to be thrown away later */
+		return addr;
+	}
+
+	if (rt->rt6i_flags & RTF_GATEWAY)
+		addr = rt->rt6i_gateway;
+
+	dst_release((struct dst_entry *)rt);
+#endif
+	return addr;
+}
+
 struct ovpn_peer *ovpn_peer_lookup_by_src(struct ovpn_struct *ovpn, struct sk_buff *skb)
 {
 	struct ovpn_peer *tmp, *peer = NULL;
+	struct hlist_head *head;
+	sa_family_t sa_fam;
+	struct in6_addr addr6;
+	__be32 addr4;
+	u32 index;
 
 	/* in P2P mode, no matter the destination, packets are always sent to the single peer
 	 * listening on the other side
@@ -198,35 +363,29 @@ struct ovpn_peer *ovpn_peer_lookup_by_src(struct ovpn_struct *ovpn, struct sk_bu
 		if (likely(tmp && ovpn_peer_hold(tmp)))
 			peer = tmp;
 		rcu_read_unlock();
+		return peer;
 	}
 
-	return peer;
-}
+	sa_fam = skb_protocol_to_family(skb);
 
-static bool ovpn_peer_skb_to_sockaddr(struct sk_buff *skb, struct sockaddr_storage *ss)
-{
-	struct sockaddr_in6 *sa6;
-	struct sockaddr_in *sa4;
-
-	ss->ss_family = skb_protocol_to_family(skb);
-	switch (ss->ss_family) {
+	switch (sa_fam) {
 	case AF_INET:
-		sa4 = (struct sockaddr_in *)ss;
-		sa4->sin_family = AF_INET;
-		sa4->sin_addr.s_addr = ip_hdr(skb)->saddr;
-		sa4->sin_port = udp_hdr(skb)->source;
+		addr4 = ovpn_nexthop_lookup4(ovpn, ip_hdr(skb)->saddr);
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr4, sizeof(addr4));
+		head = &ovpn->peers.by_vpn_addr[index];
+
+		peer = ovpn_peer_lookup_vpn_addr4(head, &addr4);
 		break;
 	case AF_INET6:
-		sa6 = (struct sockaddr_in6 *)ss;
-		sa6->sin6_family = AF_INET6;
-		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
-		sa6->sin6_port = udp_hdr(skb)->source;
+		addr6 = ovpn_nexthop_lookup6(ovpn, ipv6_hdr(skb)->saddr);
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr6, sizeof(addr6));
+		head = &ovpn->peers.by_vpn_addr[index];
+
+		peer = ovpn_peer_lookup_vpn_addr6(head, &addr6);
 		break;
-	default:
-		return false;
 	}
 
-	return true;
+	return peer;
 }
 
 static bool ovpn_peer_transp_match(struct ovpn_peer *peer, struct sockaddr_storage *ss)
@@ -277,16 +436,74 @@ static struct ovpn_peer *ovpn_peer_lookup_transp_addr_p2p(struct ovpn_struct *ov
 	return peer;
 }
 
+static bool ovpn_peer_skb_to_sockaddr(struct sk_buff *skb, struct sockaddr_storage *ss)
+{
+	struct sockaddr_in6 *sa6;
+	struct sockaddr_in *sa4;
+
+	ss->ss_family = skb_protocol_to_family(skb);
+	switch (ss->ss_family) {
+	case AF_INET:
+		sa4 = (struct sockaddr_in *)ss;
+		sa4->sin_family = AF_INET;
+		sa4->sin_addr.s_addr = ip_hdr(skb)->saddr;
+		sa4->sin_port = udp_hdr(skb)->source;
+		break;
+	case AF_INET6:
+		sa6 = (struct sockaddr_in6 *)ss;
+		sa6->sin6_family = AF_INET6;
+		sa6->sin6_addr = ipv6_hdr(skb)->saddr;
+		sa6->sin6_port = udp_hdr(skb)->source;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 struct ovpn_peer *ovpn_peer_lookup_transp_addr(struct ovpn_struct *ovpn, struct sk_buff *skb)
 {
-	struct ovpn_peer *peer = NULL;
+	struct ovpn_peer *tmp, *peer = NULL;
 	struct sockaddr_storage ss = { 0 };
+	struct hlist_head *head;
+	size_t sa_len;
+	bool found;
+	u32 index;
 
 	if (unlikely(!ovpn_peer_skb_to_sockaddr(skb, &ss)))
 		return NULL;
 
 	if (ovpn->mode == OVPN_MODE_P2P)
-		peer = ovpn_peer_lookup_transp_addr_p2p(ovpn, &ss);
+		return ovpn_peer_lookup_transp_addr_p2p(ovpn, &ss);
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
+	index = ovpn_peer_index(ovpn->peers.by_transp_addr, &ss, sa_len);
+	head = &ovpn->peers.by_transp_addr[index];
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp, head, hash_entry_transp_addr) {
+		found = ovpn_peer_transp_match(tmp, &ss);
+		if (!found)
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
@@ -306,10 +523,28 @@ static struct ovpn_peer *ovpn_peer_lookup_id_p2p(struct ovpn_struct *ovpn, u32 p
 
 struct ovpn_peer *ovpn_peer_lookup_id(struct ovpn_struct *ovpn, u32 peer_id)
 {
-	struct ovpn_peer *peer = NULL;
+	struct ovpn_peer *tmp, *peer = NULL;
+	struct hlist_head *head;
+	u32 index;
 
 	if (ovpn->mode == OVPN_MODE_P2P)
-		peer = ovpn_peer_lookup_id_p2p(ovpn, peer_id);
+		return ovpn_peer_lookup_id_p2p(ovpn, peer_id);
+
+	index = ovpn_peer_index(ovpn->peers.by_id, &peer_id, sizeof(peer_id));
+	head = &ovpn->peers.by_id[index];
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
-- 
2.43.0


