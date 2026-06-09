Return-Path: <netdev+bounces-296962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wsk4N/bLJ2qH2QIAu9opvQ
	(envelope-from <netdev+bounces-296962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:16:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3161765DA6B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:16:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="tanb/IIT";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296962-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296962-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1FFC3078367
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD33E92BD;
	Tue,  9 Jun 2026 08:08:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390FB34404F
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:08:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992528; cv=none; b=DT/fLUMevwTr9CT5SJDVba7wRLWfqrjltgAsqdp2deoV7/zUVk3a2+vgeehB3z+0LhIItTaDaRBC9EwNpU83qFMC6jVBj7NFQtSiLqSbvHfFNy7jUD5KQH2exPX7Ke8BF9AtMsTCabNZWj8NHNK2PnevyNoY4dikGhRfs3ttfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992528; c=relaxed/simple;
	bh=hBBi2wKJh2J4AGgyWk3UJQveYWI4ovBP3rzQojoNSyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FUlRY4jXlIqjiBHxMG6CBgNmGA7f/qHTeUaGKOuUmvVzvG9BAwkH3lO1Sw96Kep/5WlA2KuTbLdXiBzEzqvAYkO4vTlCJigR6XmW3Ul9Ri+fq6BF2Bv5XNuTDynv2GKwyKEIqasV+0PKq9KaO8nprCycNEf40HxqnvGjzk4unKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tanb/IIT; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-51771d41426so99425071cf.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780992526; x=1781597326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8iKc5sJItnfGBGVpJ2m9iilfCJlx+ULA+fAhnIr4fbU=;
        b=tanb/IITZvw4pKkb2xd4ZwXpV8Upp0cuFLwxyeiOfHJJhUjeDnmKoZArGbGYfTyObS
         NG3TO9O9n14SPuPpktmruRtuTGrMsy/FkYVTY+LMvLcZX1ue9smWhsWdA5dNLqRn9Li6
         cWAv6UJQF6Bl8ikPYcDVHHOLxI3YIbjAnunz0Ad4Puhjjh7fVXAVgf47picRRjzs+GHI
         ryk5efAbMHhtk7x+rhkb0D9wyceqoUyUu4S9JE3iyCajmHoBGhWmCwaHC7OszXi8RGN3
         hIB8FRZpyn7Fl1yTQBPqO0MpLIxav6JaUBA4MIdAp3jkQ5TA8+o3m/tum/FpFERnoiQc
         TEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992526; x=1781597326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iKc5sJItnfGBGVpJ2m9iilfCJlx+ULA+fAhnIr4fbU=;
        b=HRpxpZXL/vI3dmUg3i4bOypv2QI+3j/E667KJi+3lanmPemuKpcCoBxvl3OyQGFX76
         yvrcJaL4AELlY9JEFaeBGRkItQbnzQp/+yRj72g484I/QVjPZnSPNZv6mrKEMX2020q/
         kKQ+K6DZMPbkEpTREn3kpxx90Ph5lsPZSSAMLypGSRu5lbxCasq4dwGvmfrCLBIKt3eN
         XhUTjYmHH8AbosMG2nEqaKH70e6qcfQE2G45aD+Sm0bosWyr57RvlVhRKjhlTP34eYx9
         4Dw5ra6bdimHIafITgwvxNIShJlQH88msd0rjF6AgJ/o5OO8ZHzk2kERgoUgSYryoAMI
         lG5g==
X-Forwarded-Encrypted: i=1; AFNElJ+loGQaBfgnjaQkG+/spx882YcTEAZduJTTMgzpU2tmTpOeZI1Wd5Cswb10u0JlJ/PiTfbylQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9P835yzp1/Tej7pjIIEQSkLQQuoXfE9ExdkYT2jSUeN72w0bk
	K3+gkrLVZyr96N8s2JSCgigTCiJy4pPJB/nQmoI+LSB/0Z3JIDC1e8+1EPiAhFB3A852WXzZORG
	UeeRbUdA0DiCksQ==
X-Received: from qtjy6.prod.google.com ([2002:a05:622a:1646:b0:516:e9d0:589a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a11:b0:517:8fb6:56ba with SMTP id d75a77b69052e-51795afbcaamr251356611cf.24.1780992525798;
 Tue, 09 Jun 2026 01:08:45 -0700 (PDT)
Date: Tue,  9 Jun 2026 08:08:37 +0000
In-Reply-To: <20260609080839.2506801-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609080839.2506801-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609080839.2506801-4-edumazet@google.com>
Subject: [PATCH net-next 3/5] net: bridge: use atomic ops to read/change
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,blackwall.org,vger.kernel.org,gmail.com,google.com];
	TAGGED_FROM(0.00)[bounces-296962-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:razor@blackwall.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3161765DA6B

Use test_bit() in net/bridge/br_arp_nd_proxy.c,
net/bridge/br_fdb.c and net/bridge/br_forward.c.

Use READ_ONCE(p->flags) in br_recalculate_neigh_suppress_enabled()
as we test two bits at once.

Signed-off-by: Eric Dumazet <edumazet@google.com>
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
index 4a77d07433745152241789818949bd228aa95be0..36735f7f7b7b0cb4868a0d7704fc808a9c78e813 100644
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
+			if (!test_bit(BR_MCAST_FLOOD_BIT, &p->flags) && skb->dev != br->dev)
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
2.54.0.1064.gd145956f57-goog


