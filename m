Return-Path: <netdev+bounces-297768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ei3MMfmTKWroZwMAu9opvQ
	(envelope-from <netdev+bounces-297768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:42:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BA666B9A9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:42:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=WP0mqnEN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297768-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297768-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 784BE30AF12A
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A8306B08;
	Wed, 10 Jun 2026 16:18:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092682FE056
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:18:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781108335; cv=none; b=crZzyTTji15aqrPtz2MvzuixdiQFR0xFD9/T8qRCCR2cy7jBVWzrSNx/oFIqdBPTbCkhJCIcoJ/UJWaLH0PC6TzR4Cy0vokfUtZaXwKa/BhZJNLBy9UP0v9Q5kn+ImpjFHDww6kVPkEYt6k04mabLxOvK8waKy2I4yPppszMzdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781108335; c=relaxed/simple;
	bh=vflSFvA8eYRGttwWejZrloXG2atEQ3G/7QrS3cu3Km8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J0Ant9mkpLeFP4bpuWpgIPDjgCXo4zJsbOd0LxhhrXP2fpgcatZ6d1PHoZ+Z0ZiW2nYjOS4gftLwEItT4FwmX0LC6Z+T6/UvG/h7PisE75Gb35gqplEHawwFMo6ibp5MFwsXKdM9WhJugG3nH4KbqA69Qe/XmXPJ95ppysXSq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WP0mqnEN; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5174a236220so16847521cf.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781108333; x=1781713133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2QWd+rYm+2S1e6LOwdS4NMPpL5lznZmcm+YgNVJCg4=;
        b=WP0mqnENyeOuu/oae5xUKoW6sUwNcZlKy2J0gcv1LV55t7ru67ut1203/hCF8CfEXX
         dZCM2W/LM7MzmJq4eHzreqIQF43DLbEIFIN5g7twTF0kxLVOkZGM1jcS/N63VrE77wH8
         kpRN2dmzab0cyhu7GBcKE6PcjWPP5b+W8uN9PQ8WzZS5MUjqgrP0Vb0jQkcIZgGvXLWQ
         Ub5UZucdT9cetF61Sl7xTXQdzIZW4edOgw5khV1wb9IwxKGQuXsVAQWrsPsj6iULTfwC
         eJVPyOk86ATnIOYZqpVfcFsEi4LFrLEYfmT1l2WTzVYns/214Sv3HZnboYAQUGztfP6p
         rtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781108333; x=1781713133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2QWd+rYm+2S1e6LOwdS4NMPpL5lznZmcm+YgNVJCg4=;
        b=NvScB6ZqSlK+epnKhv+mei8c5vQbfiLunRr/Y2Oy+CKaFid6wI93XiQML40KdMW5hy
         QwAvsOo/RgxUsjTRoOF3H04Xg3M/gFXU2vwEZ4j6ZU8t8SDjJjSFHxHhhUww7zFfreUd
         TD4FT4mNynQceyozP2hFOO+JvLBWUDVu3bmrzeiQE07NzDSiANp+DNeQOElf+qqEjKgl
         KezWLI3R+kIfQr0uXSfNOk38ce2AIQjV9cdI4xJnxriWOY1zWzxfY8ECdZwPINl2BVP+
         gXMI8jkYMgDePbAWLDvjfduw1iR90+y8Ge4z+7yWfp6oabI8yMTLXSUo/E1w35tNqjfc
         P4Ug==
X-Forwarded-Encrypted: i=1; AFNElJ/TbcQ54f84nwwBqVbc4PcuxwOCgYxYwZU641RwOAQ+dBlZorHR23q7LTcPjDeTKOwylj197rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8m6vHFryDFtEWjUhEgCmxWhOPS2igQgOR+9yyQVEu7AvU7dko
	DUpGASpjNDF/iAIjXe6tGu8/k5A9n9puRv/u6L5/oh+xCNsxQAh3qiKfKmO8f0uzM2Px8aUSOiz
	fpKp6QYe1kSnhRQ==
X-Received: from qtbfu38.prod.google.com ([2002:a05:622a:5da6:b0:517:71d9:d9c4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:15c7:b0:517:89d0:b8cf with SMTP id d75a77b69052e-517ca516edcmr121516471cf.8.1781108332311;
 Wed, 10 Jun 2026 09:18:52 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:18:34 +0000
In-Reply-To: <20260610161836.1275531-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260610161836.1275531-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610161836.1275531-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/5] net: bridge: use atomic ops to read/change
 p->flags (I)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297768-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,blackwall.org,nvidia.com,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68BA666B9A9

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
2.54.0.1099.g489fc7bff1-goog


