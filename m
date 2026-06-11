Return-Path: <netdev+bounces-298341-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R+SANGMcK2pM2wMAu9opvQ
	(envelope-from <netdev+bounces-298341-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:36:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B5675343
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:36:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ZlTDgtZb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298341-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298341-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E8E633A9092
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D88436AB4D;
	Thu, 11 Jun 2026 20:35:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6798368D5E
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 20:35:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781210102; cv=none; b=pi3/ouvEA3fwGZmhppxYFyHCAGP8BecRekDvWK03shLPNbnYt/fJacymgFMf8ibnvfA/8qYyXeRIXVITcmIjhRHJXbGAYIeFNnIuVrA4otiMByS0QVdLKlV9a+JU7aytgnUZ6OgyKxc6ySlRZG9sqaO1bGgo6IwZ7FlUqD2Oa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781210102; c=relaxed/simple;
	bh=mmJlKNbzKJjKW3rO4PC0k0wJ4AbEx/NNjtPJotvDy28=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F+BUHqXWN4jP0GokYTZIcABf6hOrTelqvievOB7L+7L4n1BRdtYSQLq5L3RoMn7md7XUnRlmOBQxpoGl6T48oXLHq3fOQhRrTmxOv/T51Qd+WbPGGvCZJBbW05pTSm2kJbJOY67vAUxhiI/g+7iuXJEVxU7yB6+CGunLo8LAw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZlTDgtZb; arc=none smtp.client-ip=209.85.219.74
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8ccd5491db4so2324066d6.2
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781210100; x=1781814900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tqj3eNjPz835i7keeVkJPWJ4RLjYDfv8wQBER7Prezc=;
        b=ZlTDgtZbyl/yjp1Kb46FT41PeoEzHiYxol3663Cbl0peOsmmZF0niFPDsyZjfmCt+b
         jrOfwEXy0PRZOotBTfduDeL8NVS9LLiLRFOba+dfb29is4cl34nbkZzzHbsr0WKoaGiO
         3q4BlXNN1I9VuJkyy201Hsby//3PLy6CQTS1yz2NqsbdCO5TaC7UFDXFPGxoK7mokQZt
         Ba+1JhKqTl95O8pyujbU4xCM/vi9smB+thLwFm/2jr0a/akQauM5ZlQCOWjpF1JgtijU
         3JD4pIC7uJl+mA8vbUSrNmVttW3Wmk/5dF7iehL4QsVHsbmM5l1W/IPKbEzvORlyv6CB
         Nkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781210100; x=1781814900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tqj3eNjPz835i7keeVkJPWJ4RLjYDfv8wQBER7Prezc=;
        b=r+1Dd3dVFLUu17MEVxNYlFpBaTPBcKCNDVKxRAF5A/huqHqmnmi13GgUPiwsFN6za1
         H4JvXqRgU0Xsa0RDBpiyrfuS+12xpdeE42N6efWKTZj2J3aUTEMLpRRj+jDyJ53zHdOs
         zVXwuGBQL6yuHAcsQFG0H3TPKRQKf2exZmFUC7Bm3PDZfODdng85VdP4FF1inATzNNGG
         Wkk8C5Uk4uDHjqkFenM3MaHZrR4jL8kLXU9Iwers4fe14s/IvFEKG/Vx0LsaA4MsTO3s
         iPhBDoV/qiX3G9QCHfTSuqCRKmKxfQvsc6EKOQooqPUCmYqqH9Q8qV8mqnR6O5MtaJT2
         8jOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MeoFT3X4L/6QTM6dG4PAd9ZPUo2xnwiFZfJDCyoaYSF2xJsif3klFnZ8qFu+0OdTJxtAOAvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0zC/FsOjf1N4s0tRfOKSmIkwZVqb7LLzvFnX56iiJaye8bTk
	cbG3edvInoGHejwSzi8EHrW+TYoS4cy38xzb1mYnE8+uC7YirPwh8B+c/w5p+QXOtXd9GWRIJa5
	lHadI0XZ7y+xdLg==
X-Received: from qvbld24.prod.google.com ([2002:a05:6214:4198:b0:8ce:aa0f:74aa])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5c4a:0:b0:8ca:1cee:7c38 with SMTP id 6a1803df08f44-8d1da56165emr76604356d6.24.1781210099301;
 Thu, 11 Jun 2026 13:34:59 -0700 (PDT)
Date: Thu, 11 Jun 2026 20:34:51 +0000
In-Reply-To: <20260611203453.3067462-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260611203453.3067462-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260611203453.3067462-4-edumazet@google.com>
Subject: [PATCH v3 net-next 3/5] net: bridge: use atomic ops to read/change
 p->flags (I)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298341-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E6B5675343

Use test_bit() in net/bridge/br_arp_nd_proxy.c,
net/bridge/br_fdb.c and net/bridge/br_forward.c.

Use READ_ONCE(p->flags) in br_recalculate_neigh_suppress_enabled()
as we test two bits at once.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_arp_nd_proxy.c | 22 +++++++---------------
 net/bridge/br_fdb.c          |  2 +-
 net/bridge/br_forward.c      | 15 ++++++++-------
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 5263232278b4fe95775cfcbba71615197e2f5311..23eb6931a2b4ad9137ef20735d8333f376fd49f2 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -29,7 +29,7 @@ void br_recalculate_neigh_suppress_enabled(struct net_bridge *br)
 	bool neigh_suppress = false;
 
 	list_for_each_entry(p, &br->port_list, list) {
-		if (p->flags & (BR_NEIGH_SUPPRESS | BR_NEIGH_VLAN_SUPPRESS)) {
+		if (READ_ONCE(p->flags) & (BR_NEIGH_SUPPRESS | BR_NEIGH_VLAN_SUPPRESS)) {
 			neigh_suppress = true;
 			break;
 		}
@@ -206,8 +206,8 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			const struct net_bridge_port *dst = READ_ONCE(f->dst);
 			bool replied = false;
 
-			if ((p && (p->flags & BR_PROXYARP)) ||
-			    (dst && (dst->flags & BR_PROXYARP_WIFI)) ||
+			if ((p && test_bit(BR_PROXYARP_BIT, &p->flags)) ||
+			    (dst && test_bit(BR_PROXYARP_WIFI_BIT, &dst->flags)) ||
 			    br_is_neigh_suppress_enabled(dst, vid)) {
 				if (!vid)
 					br_arp_send(br, p, skb->dev, sip, tip,
@@ -511,10 +511,7 @@ bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid)
 	if (!p)
 		return false;
 
-	if (!vid)
-		return !!(p->flags & BR_NEIGH_SUPPRESS);
-
-	if (p->flags & BR_NEIGH_VLAN_SUPPRESS) {
+	if (vid && test_bit(BR_NEIGH_VLAN_SUPPRESS_BIT, &p->flags)) {
 		struct net_bridge_vlan_group *vg = nbp_vlan_group_rcu(p);
 		struct net_bridge_vlan *v;
 
@@ -522,17 +519,13 @@ bool br_is_neigh_suppress_enabled(const struct net_bridge_port *p, u16 vid)
 		if (!v)
 			return false;
 		return !!(v->priv_flags & BR_VLFLAG_NEIGH_SUPPRESS_ENABLED);
-	} else {
-		return !!(p->flags & BR_NEIGH_SUPPRESS);
 	}
+	return test_bit(BR_NEIGH_SUPPRESS_BIT, &p->flags);
 }
 
 bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid)
 {
-	if (!vid)
-		return !!(p->flags & BR_NEIGH_FORWARD_GRAT);
-
-	if (p->flags & BR_NEIGH_VLAN_SUPPRESS) {
+	if (vid && test_bit(BR_NEIGH_VLAN_SUPPRESS_BIT, &p->flags)) {
 		struct net_bridge_vlan_group *vg = nbp_vlan_group_rcu(p);
 		struct net_bridge_vlan *v;
 
@@ -540,7 +533,6 @@ bool br_is_neigh_forward_grat_enabled(const struct net_bridge_port *p, u16 vid)
 		if (!v)
 			return false;
 		return !!(v->priv_flags & BR_VLFLAG_NEIGH_FORWARD_GRAT_ENABLED);
-	} else {
-		return !!(p->flags & BR_NEIGH_FORWARD_GRAT);
 	}
+	return test_bit(BR_NEIGH_FORWARD_GRAT_BIT, &p->flags);
 }
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index a114373c98163d1e81b090b9c799adcb1bfeed77..e4570bbed85445bcda08537b81c78bacd163f28d 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1514,7 +1514,7 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 
 	trace_br_fdb_external_learn_add(br, p, addr, vid);
 
-	if (locked && (!p || !(p->flags & BR_PORT_MAB)))
+	if (locked && (!p || !test_bit(BR_PORT_MAB_BIT, &p->flags)))
 		return -EINVAL;
 
 	spin_lock_bh(&br->hash_lock);
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 4a77d07433745152241789818949bd228aa95be0..46c762ca5177e5ffb8bc21077cdb14ca25a4a453 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -24,7 +24,7 @@ static inline int should_deliver(const struct net_bridge_port *p,
 	struct net_bridge_vlan_group *vg;
 
 	vg = nbp_vlan_group_rcu(p);
-	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev != p->dev) &&
+	return (test_bit(BR_HAIRPIN_MODE_BIT, &p->flags) || skb->dev != p->dev) &&
 		(br_mst_is_enabled(p) || p->state == BR_STATE_FORWARDING) &&
 		br_allowed_egress(vg, skb) && nbp_switchdev_allowed_egress(p, skb) &&
 		!br_skb_isolated(p, skb);
@@ -214,24 +214,24 @@ void br_flood(struct net_bridge *br, struct sk_buff *skb,
 		 */
 		switch (pkt_type) {
 		case BR_PKT_UNICAST:
-			if (!(p->flags & BR_FLOOD))
+			if (!test_bit(BR_FLOOD_BIT, &p->flags))
 				continue;
 			break;
 		case BR_PKT_MULTICAST:
-			if (!(p->flags & BR_MCAST_FLOOD) && skb->dev != br->dev)
+			if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) && skb->dev != br->dev)
 				continue;
 			break;
 		case BR_PKT_BROADCAST:
-			if (!(p->flags & BR_BCAST_FLOOD) && skb->dev != br->dev)
+			if (!test_bit(BR_BCAST_FLOOD_BIT, &p->flags) && skb->dev != br->dev)
 				continue;
 			break;
 		}
 
 		/* Do not flood to ports that enable proxy ARP */
-		if (p->flags & BR_PROXYARP)
+		if (test_bit(BR_PROXYARP_BIT, &p->flags))
 			continue;
 		if (BR_INPUT_SKB_CB(skb)->proxyarp_replied) {
-			if (p->flags & BR_PROXYARP_WIFI)
+			if (test_bit(BR_PROXYARP_WIFI_BIT, &p->flags))
 				continue;
 			/* For gratuitous ARPs/NAs, check neigh_forward_grat.
 			 * For regular ARPs/NDs, check only neigh_suppress.
@@ -328,7 +328,8 @@ void br_multicast_flood(struct net_bridge_mdb_entry *mdst,
 		if ((unsigned long)lport > (unsigned long)rport) {
 			port = lport;
 
-			if (port->flags & BR_MULTICAST_TO_UNICAST) {
+			if (test_bit(BR_MULTICAST_TO_UNICAST_BIT,
+				     &port->flags)) {
 				maybe_deliver_addr(lport, skb, p->eth_addr,
 						   local_orig);
 				goto delivered;
-- 
2.54.0.1136.gdb2ca164c4-goog


