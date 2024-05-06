Return-Path: <netdev+bounces-93571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6D8BC553
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB35B214B1
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D547F62;
	Mon,  6 May 2024 01:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NssvkLL6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5E3E49E
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958154; cv=none; b=EkVuCaMvP+Vf34r45Tj73Rq1hS8CSGCb0iz3H//kLzL78KobaHJcgtqlzNFQOmSbVR+RwHfz0uA/DMrpUQ8QpsnLajjO8hEt2inWQML46FEKbeWzva/FYxd369oDC2TZbfg4kH9FY406m34DJfiGbqZIJV10MxFswz65K7UFNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958154; c=relaxed/simple;
	bh=kXJU/nTryKi5Lq+oGaJBYQDqy9RBtvtmwP/WT8QUmK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaw4FRkazY4cWFqVfn58sQ8O7JIlj/wRSpf0mJCVedDss1Q/3HfY+O4O9vGsf3H5cImyDx5PtIonOYAUSUhZsNj4HjN9EcLIEONMlKu5lzbwD6v+8dQVkAdS6wvk8vVo9eiE2gfDxfDy/q/kbSV7Pc6ncXgQMLMQtlPujAndDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NssvkLL6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41dc9c83e57so20479805e9.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958151; x=1715562951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuwPPFVLu0hYlXMKoyNARQ1+yw3yMsvxi9YCmvzZ2lc=;
        b=NssvkLL60F9hF2KPYOzQ7f1oD+orpB0U2furdxSmVFj9YOX5e2Ov5g9pWBxaccDOV5
         q60/CJrf1hNMsqeDmqThklI4Qe+xUtWs0DN/e3vTEXvAsyKMXJNwb5H2tuuh6C0lXIHP
         Fg7rj663ae+nAYV3zqeQJQ/Emzuw+NoAjvXYMeIrt6W6AP02RAYanaxI8g2DNTl/LVQj
         dVXBQj3IpOz7S88oXOObuj4PDf7LHI98yJBeWvkUCyG4vqsjNLDr9DwxFF2EJ6oDNKxI
         FJEInrqB+hNStisBnRI+vwJilkstAml39aRavGv7ule2C9Sgez+uWu6vg/L1+MQmbhwV
         R7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958151; x=1715562951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuwPPFVLu0hYlXMKoyNARQ1+yw3yMsvxi9YCmvzZ2lc=;
        b=gvT2Z4VSBPSHOwjXsSnMDo5d1Uy3zHgIFeMd4Uc8aTN7IACVKroNHwT9qZIiR5w7LN
         NuskJjKPdPSSkhNPbNUbl1mwWxdkKo7jeN2D2fwuezS1PUBR2Z18D0uJXkFxYAZAGDRX
         6wqQ9RNFrvbW93nWr7b0G/h/aRAKSN9G4ulF4WraKz/1bpCeHK9yJAVxsgoNVBmbkBlo
         6TwiIi+xb+/buQ6au9YT7QK8jWhwscpnyVfnPp+BwFJsHMmcYdidJYmPbKMjbD7HpuVI
         v0qgbGrr3YF11nWjHdDKdG4/2RhIjVLjQfblj6NvXGRVUYcgssS22upmCLxxyPMsKf9R
         2H4w==
X-Gm-Message-State: AOJu0Yy/vZn0DPzXR/ZUv2ae4v4e/6J5baGyL6pl6uT3Nq3M8jHF+T3O
	4S57qtZn7A3BojgBH0dYsrrv4bzT3Zz4jIT1B3LBIKn0zlFDXNgxhtXaQjmragVFmejGIzPt9SO
	r
X-Google-Smtp-Source: AGHT+IEB6jFKYycrA9zZd8NMLmT6JsUn45dberlpxH+TRweaXBDpxGiXzVu/9wFX2c7y3e7sWiJbXg==
X-Received: by 2002:adf:f44a:0:b0:34d:d5e5:6816 with SMTP id f10-20020adff44a000000b0034dd5e56816mr10507892wrp.8.1714958151035;
        Sun, 05 May 2024 18:15:51 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:15:50 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 15/24] ovpn: implement peer lookup logic
Date: Mon,  6 May 2024 03:16:28 +0200
Message-ID: <20240506011637.27272-16-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
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
 drivers/net/ovpn/peer.c | 285 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 281 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 38a89595dade..31d7fb718b6b 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -198,6 +198,98 @@ static bool ovpn_peer_skb_to_sockaddr(struct sk_buff *skb,
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
+	struct rtable *rt = skb_rtable(skb);
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
+	struct rt6_info *rt = (struct rt6_info *)skb_rtable(skb);
+
+	if (!rt || !(rt->rt6i_flags & RTF_GATEWAY))
+		return ipv6_hdr(skb)->daddr;
+
+	return rt->rt6i_gateway;
+}
+
+/**
+ * ovpn_peer_get_by_vpn_addr4 - retrieve peer by its VPN IPv4 address
+ * @head: list head to search
+ * @addr: VPN IPv4 to use as search key
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *ovpn_peer_get_by_vpn_addr4(struct hlist_head *head,
+						    __be32 *addr)
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
+/**
+ * ovpn_peer_get_by_vpn_addr6 - retrieve peer by its VPN IPv6 address
+ * @head: list head to search
+ * @addr: VPN IPv6 to use as search key
+ *
+ * Return: the peer if found or NULL otherwise
+ */
+static struct ovpn_peer *ovpn_peer_get_by_vpn_addr6(struct hlist_head *head,
+						    struct in6_addr *addr)
+{
+	struct ovpn_peer *tmp, *peer = NULL;
+	int i;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(tmp, head, hash_entry_addr6) {
+		for (i = 0; i < 4; i++) {
+			if (addr->s6_addr32[i] !=
+			    tmp->vpn_addrs.ipv6.s6_addr32[i])
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
  * ovpn_peer_transp_match - check if sockaddr and peer binding match
  * @peer: the peer to get the binding from
@@ -268,14 +360,46 @@ ovpn_peer_get_by_transp_addr_p2p(struct ovpn_struct *ovpn,
 struct ovpn_peer *ovpn_peer_get_by_transp_addr(struct ovpn_struct *ovpn,
 					       struct sk_buff *skb)
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
@@ -303,10 +427,28 @@ static struct ovpn_peer *ovpn_peer_get_by_id_p2p(struct ovpn_struct *ovpn,
 
 struct ovpn_peer *ovpn_peer_get_by_id(struct ovpn_struct *ovpn, u32 peer_id)
 {
-	struct ovpn_peer *peer = NULL;
+	struct ovpn_peer *tmp, *peer = NULL;
+	struct hlist_head *head;
+	u32 index;
 
 	if (ovpn->mode == OVPN_MODE_P2P)
-		peer = ovpn_peer_get_by_id_p2p(ovpn, peer_id);
+		return ovpn_peer_get_by_id_p2p(ovpn, peer_id);
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
@@ -328,6 +470,11 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
 				       struct sk_buff *skb)
 {
 	struct ovpn_peer *tmp, *peer = NULL;
+	struct hlist_head *head;
+	sa_family_t sa_fam;
+	struct in6_addr addr6;
+	__be32 addr4;
+	u32 index;
 
 	/* in P2P mode, no matter the destination, packets are always sent to
 	 * the single peer listening on the other side
@@ -338,15 +485,123 @@ struct ovpn_peer *ovpn_peer_get_by_dst(struct ovpn_struct *ovpn,
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
+		addr4 = ovpn_nexthop_from_skb4(skb);
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr4,
+					sizeof(addr4));
+		head = &ovpn->peers.by_vpn_addr[index];
+
+		peer = ovpn_peer_get_by_vpn_addr4(head, &addr4);
+		break;
+	case AF_INET6:
+		addr6 = ovpn_nexthop_from_skb6(skb);
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr6,
+					sizeof(addr6));
+		head = &ovpn->peers.by_vpn_addr[index];
+
+		peer = ovpn_peer_get_by_vpn_addr6(head, &addr6);
+		break;
 	}
 
 	return peer;
 }
 
+/**
+ * ovpn_nexthop_from_rt4 - look up the IPv4 nexthop for the given destination
+ * @ovpn: the private data representing the current VPN session
+ * @dst: the destination to be looked up
+ *
+ * Looks up in the IPv4 system routing table the IP of the nexthop to be used
+ * to reach the destination passed as argument. If no nexthop can be found, the
+ * destination itself is returned as it probably has to be used as nexthop.
+ *
+ * Return: the IP of the next hop if found or the dst itself otherwise
+ */
+static __be32 ovpn_nexthop_from_rt4(struct ovpn_struct *ovpn, __be32 dst)
+{
+	struct rtable *rt;
+	struct flowi4 fl = {
+		.daddr = dst
+	};
+
+	rt = ip_route_output_flow(dev_net(ovpn->dev), &fl, NULL);
+	if (IS_ERR(rt)) {
+		net_dbg_ratelimited("%s: no route to host %pI4\n", __func__,
+				    &dst);
+		/* if we end up here this packet is probably going to be
+		 * thrown away later
+		 */
+		return dst;
+	}
+
+	if (!rt->rt_uses_gateway)
+		goto out;
+
+	dst = rt->rt_gw4;
+out:
+	ip_rt_put(rt);
+	return dst;
+}
+
+/**
+ * ovpn_nexthop_from_rt6 - look up the IPv6 nexthop for the given destination
+ * @ovpn: the private data representing the current VPN session
+ * @dst: the destination to be looked up
+ *
+ * Looks up in the IPv6 system routing table the IO of the nexthop to be used
+ * to reach the destination passed as argument. IF no nexthop can be found, the
+ * destination itself is returned as it probably has to be used as nexthop.
+ *
+ * Return: the IP of the next hop if found or the dst itself otherwise
+ */
+static struct in6_addr ovpn_nexthop_from_rt6(struct ovpn_struct *ovpn,
+					     struct in6_addr dst)
+{
+#if IS_ENABLED(CONFIG_IPV6)
+	struct dst_entry *entry;
+	struct rt6_info *rt;
+	struct flowi6 fl = {
+		.daddr = dst,
+	};
+
+	entry = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ovpn->dev), NULL, &fl,
+						NULL);
+	if (IS_ERR(entry)) {
+		net_dbg_ratelimited("%s: no route to host %pI6c\n", __func__,
+				    &dst);
+		/* if we end up here this packet is probably going to be
+		 * thrown away later
+		 */
+		return dst;
+	}
+
+	rt = container_of(entry, struct rt6_info, dst);
+
+	if (!(rt->rt6i_flags & RTF_GATEWAY))
+		goto out;
+
+	dst = rt->rt6i_gateway;
+out:
+	dst_release((struct dst_entry *)rt);
+#endif
+	return dst;
+}
+
 struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
 				       struct sk_buff *skb)
 {
 	struct ovpn_peer *tmp, *peer = NULL;
+	struct hlist_head *head;
+	sa_family_t sa_fam;
+	struct in6_addr addr6;
+	__be32 addr4;
+	u32 index;
 
 	/* in P2P mode, no matter the destination, packets are always sent to
 	 * the single peer listening on the other side
@@ -357,6 +612,28 @@ struct ovpn_peer *ovpn_peer_get_by_src(struct ovpn_struct *ovpn,
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
+		addr4 = ovpn_nexthop_from_rt4(ovpn, ip_hdr(skb)->saddr);
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr4,
+					sizeof(addr4));
+		head = &ovpn->peers.by_vpn_addr[index];
+
+		peer = ovpn_peer_get_by_vpn_addr4(head, &addr4);
+		break;
+	case AF_INET6:
+		addr6 = ovpn_nexthop_from_rt6(ovpn, ipv6_hdr(skb)->saddr);
+		index = ovpn_peer_index(ovpn->peers.by_vpn_addr, &addr6,
+					sizeof(addr6));
+		head = &ovpn->peers.by_vpn_addr[index];
+
+		peer = ovpn_peer_get_by_vpn_addr6(head, &addr6);
+		break;
 	}
 
 	return peer;
-- 
2.43.2


