Return-Path: <netdev+bounces-302608-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QF+1ABxoQmr56QkAu9opvQ
	(envelope-from <netdev+bounces-302608-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:42:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB26DA690
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 14:42:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CVVQzhBg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302608-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302608-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBA58305EE89
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59C14028D0;
	Mon, 29 Jun 2026 12:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9C406811
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:33:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736410; cv=none; b=m58S4GOTwV3i+Pk4YHlkJ+ZNBsjdM7yCbDK27ZhjMzUDUkzmXbirTjS9kDWkLJwJswKOR8UOLANkPW6z5cR3pGhYWMOU11ZC8rHqKueGkMwD+9PCo9Y3bJWTbC3jKXAmgm8BYLhMy34Z6LojGUmpicFO52RZSSLNCYRh2T6COLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736410; c=relaxed/simple;
	bh=uFlsWrhJwtQf9yt8auqKp+aP7EpEMnGUWhzv1INgKXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIkEEg02eK0daDQfn/ogAw3V42tEydTNalHqc/QgVAhfpm2KA6Dx1QOOLON9sGbjMCxOs6GtCmT3ioXJXDyRDCStWKlA7LQobMetoduxFGFGleLG0y8bTws/yo4cpPMx3s8r7VSe38nmDkx/fH+JPAGSnVzK0/viK0BPJWApZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVVQzhBg; arc=none smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1274bedebfso67327566b.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782736407; x=1783341207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZkMfYGbmmBFNVQavhfnwkj1f6U3WSLYvJuEXnZXuTc=;
        b=CVVQzhBg49eB4j7A7psihJsf6tvncRS3TukHErnyrHCN1EZuBa9sJg4hUSTrB+oL7P
         74XZyAbvSZ5XvbZ6ws6zllCQXyisPUgJdRvLGVUsvex5ldHyfX+ftFrA3MrWr96AqpDF
         4BGdZq/Hd75LSV8UENq8iEP8yUc9ddw/i9h6HrUbP/gEQnozC4dy/WrY18Ykj065loXr
         lS8rEEDGzJB+kMKBxQ8sOru/5FiqgmuNRGTkWjT8W8E0/XdTgwyMDG2zW2IMqUDc/PLw
         ZUjlG/7vEJVNpvBziLuXpfZmsQQqbaLS2ttA9XEjLfmea0xqTjja23UWitQrtwLfcV7F
         80+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782736407; x=1783341207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ZkMfYGbmmBFNVQavhfnwkj1f6U3WSLYvJuEXnZXuTc=;
        b=GpjdyVnGQahtPs92SBmhvFFYtOcwGxacZFqOF7XGuwfNuIWRkruH4Pn57B8r/+S567
         zdJOhuvVb27RcxxwAIhxutGGNKKp7YFq4aMSzcWcYlxaRlGfs0WiG/DuZvtgXUp3snaj
         l4EMCT5L6BlMM7xpdDGwpftuNCrKXqq6sTlBdsovYjpe1gDiBtbmQOhWov4rSQslSFRA
         Pr0qaGLeiVQJoNg9qe6YPpTowx01s0bdnxLaUZVrF2pJPQG6qQw02zY5ZOTjFIPts2el
         K0IbnPNZ/Az1hyiX11SdjCK6IkID3KpdKK8T6DpXHCSv9zTeB8KCUKRrivP7vYIoXFpl
         kYWg==
X-Forwarded-Encrypted: i=1; AHgh+Rrw9pazyih+v+2T2I3hpYq12hNrq7hr8PnNjrDYUL+38ZajchXkGBgZiq8/7tVz185ktaSDdEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDv7AKbnyE0zBOsv6BsxcAz27GPwCQvp902w+w0qbFyrioQAc
	iTj1vy+4g+c5/ynX+fwBMXeEssqU29EFhhxvP/13XCm6MSNe/+j5pJY5
X-Gm-Gg: AfdE7cnlISfVwf+yAoYPMveqZREAPzhRQ5qvjYFs0zi51la9XJxNgAnTIQMN4mtLHYP
	w2z7AtRRCwIiYO44tvHGvSg4IwFv1NaENp7+RPSfNrH75Qcvco5h9GoyRw3FfJnqej60gdw8wC/
	o7T0EC3LLZxtw0u1TfI4z7jakNKwp7Svt0dWuauOlc48MIMjqcIsspTKrHqs45ItPOBOn59C4Kr
	jmyLXi0FUmARxRe7wkjWHwmmm9SN2o/SaDTxrLxqitgo3BZmwN74hdbh4NW8P5eff4IF0bIgaIa
	TTOyZUJYiuevOPZLcId784HA8ZN6LORoxqUgvyN6yQosX58Ol2X0DgS1V741kc80SayF7RdyPx3
	3O0+vIVV7KdwWtdSYaIws9qf5lv0x+EzOWJGQ5XrL2HOS+ec9BUkmgOvB9nOQGq06ClsOejEnLa
	6Wc59hq2Y=
X-Received: by 2002:a17:906:4fc4:b0:c07:fcdd:7043 with SMTP id a640c23a62f3a-c12813bb075mr20833366b.16.1782736407037;
        Mon, 29 Jun 2026 05:33:27 -0700 (PDT)
Received: from fedora ([46.205.218.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05c22sm773866566b.39.2026.06.29.05.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:33:25 -0700 (PDT)
From: Daniel Pawlik <pawlik.dan@gmail.com>
To: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	idosch@nvidia.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	bridge@lists.linux.dev,
	coreteam@netfilter.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	rchen14b@gmail.com,
	lorenzo@kernel.org,
	Daniel Pawlik <pawlik.dan@gmail.com>
Subject: [PATCH 3/5] netfilter: nf_flow_table_path: add L2 bridge offload
Date: Mon, 29 Jun 2026 14:32:51 +0200
Message-ID: <20260629123253.1912621-4-pawlik.dan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629123253.1912621-1-pawlik.dan@gmail.com>
References: <20260629123253.1912621-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-302608-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:netdev@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:razor@blackwall.org,m:idosch@nvidia.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:bridge@lists.linux.dev,m:coreteam@netfilter.org,m:linux-mediatek@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:rchen14b@gmail.com,m:lorenzo@kernel.org,m:pawlik.dan@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,m:pawlikdan@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[pawlikdan@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,blackwall.org,nvidia.com,gmail.com,collabora.com,lists.linux.dev,lists.infradead.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawlikdan@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mediatek.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93FB26DA690

From: Ryan Chen <rchen14b@gmail.com>

Allow nft_flow_offload to accelerate traffic forwarded at layer 2 through
Linux bridge ports.

Detection: nft_flow_offload_is_bridging() identifies bridged flows by
checking that the ingress device is a bridge port and that the destination
MAC appears in the bridge FDB with a forwarding destination port (non-local
entry). VLAN resolution and FDB lookup are combined in a single
br_port_get_rcu() call via br_fdb_has_forwarding_entry_rcu().

Routing: nft_flow_route_bridging() allocates minimal dst entries anchored
to the bridge master device via rt_dst_alloc()/ip6_dst_alloc(). A full
routing table lookup via nf_route() is intentionally avoided: it fails for
prefixes that are only bridged, not routed, through the bridge interface
(e.g. when the bridge has no IP address or the bridged subnet is not in
the routing table).

MAC addresses: for bridged flows, nft_dev_forward_path() copies Ethernet
addresses directly from the packet header instead of going through the
neighbour table. Direction (original vs reply) is resolved against the
conntrack direction so both flow directions receive the correct MAC pair.

VLAN context: nft_br_vlan_dev_fill_forward_path() pre-populates the
net_device_path_ctx with the port VLAN id and protocol before the forward
path walk, enabling VLAN-aware hardware offload entries.

Also:
- info->indev is updated for every path type in nft_dev_path_info() so
  the bridge ingress device is correctly tracked regardless of path type.
- nft_flow_route() is now a thin dispatcher that delegates to
  nft_flow_route_routing() (routed traffic) or nft_flow_route_bridging()
  (bridged traffic); the exported API is unchanged.

Path discovery infrastructure was moved to nf_flow_table_path.c in
commit 93d7a7ed0734 ("netfilter: flowtable: move path discovery
infrastructure to its own file"), so all changes land in that file.

Based on a MediaTek SDK patch by Bo-Cun Chen <bc-bocun.chen@mediatek.com>.
Co-developed-by: Daniel Pawlik <pawlik.dan@gmail.com>
Signed-off-by: Daniel Pawlik <pawlik.dan@gmail.com>
Signed-off-by: Ryan Chen <rchen14b@gmail.com>
---
 net/netfilter/nf_flow_table_path.c | 167 +++++++++++++++++++++++++++--
 1 file changed, 157 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_flow_table_path.c b/net/netfilter/nf_flow_table_path.c
index 98c03b487f52..6c470854127f 100644
--- a/net/netfilter/nf_flow_table_path.c
+++ b/net/netfilter/nf_flow_table_path.c
@@ -15,6 +15,10 @@
 #include <net/netfilter/nf_conntrack_core.h>
 #include <net/netfilter/nf_conntrack_extend.h>
 #include <net/netfilter/nf_flow_table.h>
+#include <linux/if_bridge.h>
+#include <linux/if_ether.h>
+#include <net/route.h>
+#include <net/ip6_route.h>
 
 static enum flow_offload_xmit_type nft_xmit_type(struct dst_entry *dst)
 {
@@ -42,7 +46,25 @@ static bool nft_is_valid_ether_device(const struct net_device *dev)
 	return true;
 }
 
-static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
+static bool nft_flow_offload_is_bridging(struct sk_buff *skb)
+{
+	bool ret;
+
+	if (!netif_is_bridge_port(skb->dev))
+		return false;
+	if (!skb_mac_header_was_set(skb))
+		return false;
+
+	rcu_read_lock();
+	ret = br_fdb_has_forwarding_entry_rcu(skb->dev, skb,
+					      eth_hdr(skb)->h_dest);
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static int nft_dev_fill_forward_path(struct net_device_path_ctx *ctx,
+				     const struct nf_flow_route *route,
 				     const struct dst_entry *dst_cache,
 				     const struct nf_conn *ct,
 				     enum ip_conntrack_dir dir, u8 *ha,
@@ -58,6 +80,12 @@ static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
 		goto out;
 	}
 
+	/* Bridging fastpath copies Ethernet addresses into ha; do not replace
+	 * them via neighbour lookup on the routed destination device.
+	 */
+	if (!is_zero_ether_addr(ha))
+		goto out;
+
 	n = dst_neigh_lookup(dst_cache, daddr);
 	if (!n)
 		return -1;
@@ -72,7 +100,23 @@ static int nft_dev_fill_forward_path(const struct nf_flow_route *route,
 		return -1;
 
 out:
-	return dev_fill_forward_path(dev, ha, stack);
+	return __dev_fill_forward_path(ctx, ha, stack);
+}
+
+static void nft_br_vlan_dev_fill_forward_path(const struct nft_pktinfo *pkt,
+					      struct net_device_path_ctx *ctx)
+{
+	__be16 proto = 0;
+	u16 vlan_id;
+
+	rcu_read_lock();
+	vlan_id = br_vlan_get_offload_info_rcu(pkt->skb->dev, pkt->skb, &proto);
+	if (vlan_id) {
+		ctx->num_vlans = 1;
+		ctx->vlan[0].id = vlan_id;
+		ctx->vlan[0].proto = proto;
+	}
+	rcu_read_unlock();
 }
 
 struct nft_forward_info {
@@ -103,13 +147,13 @@ static int nft_dev_path_info(const struct net_device_path_stack *stack,
 
 	for (i = 0; i < stack->num_paths; i++) {
 		path = &stack->path[i];
+		info->indev = path->dev;
 		switch (path->type) {
 		case DEV_PATH_ETHERNET:
 		case DEV_PATH_DSA:
 		case DEV_PATH_VLAN:
 		case DEV_PATH_PPPOE:
 		case DEV_PATH_TUN:
-			info->indev = path->dev;
 			if (is_zero_ether_addr(info->h_source))
 				memcpy(info->h_source, path->dev->dev_addr, ETH_ALEN);
 
@@ -244,6 +288,7 @@ static int nft_flow_tunnel_update_route(const struct nft_pktinfo *pkt,
 }
 
 static int nft_dev_forward_path(const struct nft_pktinfo *pkt,
+				bool is_bridging,
 				struct nf_flow_route *route,
 				const struct nf_conn *ct,
 				enum ip_conntrack_dir dir,
@@ -251,11 +296,33 @@ static int nft_dev_forward_path(const struct nft_pktinfo *pkt,
 {
 	const struct dst_entry *dst = route->tuple[dir].dst;
 	struct net_device_path_stack stack;
+	struct net_device_path_ctx ctx = {
+		.dev	= dst->dev,
+	};
 	struct nft_forward_info info = {};
+	enum ip_conntrack_info pkt_ctinfo;
+	enum ip_conntrack_dir skb_dir;
+	struct ethhdr *eth;
 	unsigned char ha[ETH_ALEN];
 	int i;
 
-	if (nft_dev_fill_forward_path(route, dst, ct, dir, ha, &stack) < 0 ||
+	memset(ha, 0, sizeof(ha));
+
+	if (is_bridging) {
+		nf_ct_get(pkt->skb, &pkt_ctinfo);
+		eth = eth_hdr(pkt->skb);
+		skb_dir = CTINFO2DIR(pkt_ctinfo);
+		if (skb_dir != dir) {
+			memcpy(ha, eth->h_source, ETH_ALEN);
+			memcpy(info.h_source, eth->h_dest, ETH_ALEN);
+		} else {
+			memcpy(ha, eth->h_dest, ETH_ALEN);
+			memcpy(info.h_source, eth->h_source, ETH_ALEN);
+		}
+		nft_br_vlan_dev_fill_forward_path(pkt, &ctx);
+	}
+
+	if (nft_dev_fill_forward_path(&ctx, route, dst, ct, dir, ha, &stack) < 0 ||
 	    nft_dev_path_info(&stack, &info, ha, &ft->data) < 0)
 		return -ENOENT;
 
@@ -292,9 +359,11 @@ static int nft_dev_forward_path(const struct nft_pktinfo *pkt,
 	return 0;
 }
 
-int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
-		   struct nf_flow_route *route, enum ip_conntrack_dir dir,
-		   struct nft_flowtable *ft)
+static int nft_flow_route_routing(const struct nft_pktinfo *pkt,
+				  const struct nf_conn *ct,
+				  struct nf_flow_route *route,
+				  enum ip_conntrack_dir dir,
+				  struct nft_flowtable *ft)
 {
 	struct dst_entry *this_dst = skb_dst(pkt->skb);
 	struct dst_entry *other_dst = NULL;
@@ -334,12 +403,12 @@ int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
 	nft_default_forward_path(route, this_dst, dir);
 	nft_default_forward_path(route, other_dst, !dir);
 
-	if (route->tuple[dir].xmit_type	== FLOW_OFFLOAD_XMIT_NEIGH &&
-	    nft_dev_forward_path(pkt, route, ct, dir, ft) < 0)
+	if (route->tuple[dir].xmit_type == FLOW_OFFLOAD_XMIT_NEIGH &&
+	    nft_dev_forward_path(pkt, false, route, ct, dir, ft) < 0)
 		goto err_dst_release;
 
 	if (route->tuple[!dir].xmit_type == FLOW_OFFLOAD_XMIT_NEIGH &&
-	    nft_dev_forward_path(pkt, route, ct, !dir, ft) < 0)
+	    nft_dev_forward_path(pkt, false, route, ct, !dir, ft) < 0)
 		goto err_dst_release;
 
 	return 0;
@@ -349,4 +418,82 @@ int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
 	dst_release(route->tuple[!dir].dst);
 	return -ENOENT;
 }
+
+static int nft_flow_route_bridging(const struct nft_pktinfo *pkt,
+				   const struct nf_conn *ct,
+				   struct nf_flow_route *route,
+				   enum ip_conntrack_dir dir,
+				   struct nft_flowtable *ft)
+{
+	struct dst_entry *dsts[IP_CT_DIR_MAX] = {};
+	struct net_device *br_dev;
+	int i;
+
+	/* Allocate minimal dsts anchored to the bridge master device to supply
+	 * xmit_type and MTU. A full routing lookup via nf_route() is avoided
+	 * because it fails for prefixes that are bridged but not routed.
+	 */
+	rcu_read_lock();
+	br_dev = netdev_master_upper_dev_get_rcu(pkt->skb->dev);
+	if (!br_dev || !netif_is_bridge_master(br_dev)) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+
+	for (i = 0; i < IP_CT_DIR_MAX; i++) {
+		switch (nft_pf(pkt)) {
+		case NFPROTO_IPV4: {
+			struct rtable *rt;
+
+			rt = rt_dst_alloc(br_dev, 0, RTN_UNICAST, true);
+			if (rt)
+				dsts[i] = &rt->dst;
+			break;
+		}
+		case NFPROTO_IPV6: {
+			struct rt6_info *rt;
+
+			rt = ip6_dst_alloc(nft_net(pkt), br_dev, 0);
+			if (rt)
+				dsts[i] = &rt->dst;
+			break;
+		}
+		}
+	}
+	rcu_read_unlock();
+
+	if (!dsts[dir] || !dsts[!dir]) {
+		dst_release(dsts[dir]);
+		dst_release(dsts[!dir]);
+		return -ENOENT;
+	}
+
+	nft_default_forward_path(route, dsts[dir], dir);
+	nft_default_forward_path(route, dsts[!dir], !dir);
+	/* Drop allocation references; route->tuple[*].dst holds the clones. */
+	dst_release(dsts[dir]);
+	dst_release(dsts[!dir]);
+
+	if (route->tuple[dir].xmit_type == FLOW_OFFLOAD_XMIT_NEIGH &&
+	    route->tuple[!dir].xmit_type == FLOW_OFFLOAD_XMIT_NEIGH) {
+		if (nft_dev_forward_path(pkt, true, route, ct, dir, ft) ||
+		    nft_dev_forward_path(pkt, true, route, ct, !dir, ft)) {
+			dst_release(route->tuple[dir].dst);
+			dst_release(route->tuple[!dir].dst);
+			return -ENOENT;
+		}
+	}
+
+	return 0;
+}
+
+int nft_flow_route(const struct nft_pktinfo *pkt, const struct nf_conn *ct,
+		   struct nf_flow_route *route, enum ip_conntrack_dir dir,
+		   struct nft_flowtable *ft)
+{
+	if (nft_flow_offload_is_bridging(pkt->skb))
+		return nft_flow_route_bridging(pkt, ct, route, dir, ft);
+
+	return nft_flow_route_routing(pkt, ct, route, dir, ft);
+}
 EXPORT_SYMBOL_GPL(nft_flow_route);
-- 
2.54.0


