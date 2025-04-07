Return-Path: <netdev+bounces-179681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D88EA7E164
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E6816941E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226D1DC996;
	Mon,  7 Apr 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl2Nt4hJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19921D88DB
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035532; cv=none; b=Z6v+UZjCaUa/GCpvR3Zo+u+8wcE0V0Zy0e/Kvq0oyLCTbnadDHPcoFvKMI7oLjZkqFUPcfmo3v6peqbYeAt92yoymuQWXTHftKigTr8FFhoIMF3zuRefXmBv2WEz0tRjMIm4FF7aRUXNQ+k+NLGZ/oc6R2c55Ai73fwSujjA5lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035532; c=relaxed/simple;
	bh=smNW7eURXbLB4ENz5lLbAub976bCrWFKe8LdVwQRLVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dQCZEYUrzkMnWaVeXkGJPM4I60eMd6yFuVjQB1+rTIYlSHttBFTMY6Fksp/js+jutoRr0oyhmmIT0o+/e4c6SPX/2Geov7TbpjeY6Xbsx5HHlLagn+uEIJxYyfFqTwMyfGJiFTop50c/YZUmi4lrD8yfIfM313a6/EGU1iiZc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl2Nt4hJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA79C4CEDD;
	Mon,  7 Apr 2025 14:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744035531;
	bh=smNW7eURXbLB4ENz5lLbAub976bCrWFKe8LdVwQRLVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bl2Nt4hJSu1ALcGO3FI92M5BAKmzo7yj8Pc5B7qVPj07QHVr2/dkTDQ/1BulUtEqA
	 ZZJDr3ggj2efvjmlLUEv66EC9Ojs4UI9VtiMxZfJRcijc7bN3Sx35ajHI8goKy8VjC
	 tdVsMLy4sXF7z2YFglV29sauKI/pnZb2uiXjznn/wb3t4VNZuFd+sF4otHZq9CePSg
	 ReurBiMt/GGAzu9xFFF7iYR2eLsHDXgfpa87ss3eLic7YgvCsfASi9b17oWw7ipuWp
	 R4BsnnKnFtQ4iG/qEg9lz5vfcn+JuSgXEH52N5wKIQVX/UT18dUaDkKMYS1UMy1te2
	 X7gWNjUwxgwXQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 07 Apr 2025 16:18:32 +0200
Subject: [PATCH net-next 3/3] net: airoha: Add L2 hw acceleration support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-airoha-flowtable-l2b-v1-3-18777778e568@kernel.org>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
In-Reply-To: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Similar to mtk driver, introduce the capability to offload L2 traffic
defining flower rules in the PSE/PPE engine available on EN7581 SoC.
Since the hw always reports L2/L3/L4 flower rules, link all L2 rules
sharing the same L2 info (with different L3/L4 info) in the L2 subflows
list of a given L2 PPE entry.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c |   2 +-
 drivers/net/ethernet/airoha/airoha_eth.h |  11 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 162 +++++++++++++++++++++++++------
 3 files changed, 144 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index d748dc6de92367365db9f9548f9af52a7fdac187..723eba7cfa0cf405dc2ef9248b34bf6af897ceed 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -694,7 +694,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 
 		reason = FIELD_GET(AIROHA_RXD4_PPE_CPU_REASON, msg1);
 		if (reason == PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED)
-			airoha_ppe_check_skb(eth->ppe, hash);
+			airoha_ppe_check_skb(eth->ppe, q->skb, hash);
 
 		done++;
 		napi_gro_receive(&q->napi, q->skb);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 57925648155b104021c10821096ba267c9c7cef6..e82abfc1a67bda7f675342327ae07601d81f2b8f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -430,11 +430,15 @@ enum airoha_flow_entry_type {
 
 struct airoha_flow_table_entry {
 	union {
-		struct hlist_node list;
-		struct rhash_head l2_node;
+		struct hlist_node list; /* PPE L3 flow entry */
+		struct {
+			struct rhash_head l2_node;  /* L2 flow entry */
+			struct hlist_head l2_flows; /* PPE L2 subflows list */
+		};
 	};
 
 	struct airoha_foe_entry data;
+	struct hlist_node l2_subflow_node; /* PPE L2 subflow entry */
 	u32 hash;
 
 	enum airoha_flow_entry_type type;
@@ -548,7 +552,8 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
 
-void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash);
+void airoha_ppe_check_skb(struct airoha_ppe *ppe, struct sk_buff *skb,
+			  u16 hash);
 int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 				 void *cb_priv);
 int airoha_ppe_init(struct airoha_eth *eth);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 8f75752c6714cc211a8efd0b6fdf5565ffa23c14..e95a7b727dda2e0182e0ddb567cb13fb746cd455 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -204,6 +204,15 @@ static int airoha_get_dsa_port(struct net_device **dev)
 #endif
 }
 
+static void airoha_ppe_foe_set_bridge_addrs(struct airoha_foe_bridge *br,
+					    struct ethhdr *eh)
+{
+	br->dest_mac_hi = get_unaligned_be32(eh->h_dest);
+	br->dest_mac_lo = get_unaligned_be16(eh->h_dest + 4);
+	br->src_mac_hi = get_unaligned_be16(eh->h_source);
+	br->src_mac_lo = get_unaligned_be32(eh->h_source + 2);
+}
+
 static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 					struct airoha_foe_entry *hwe,
 					struct net_device *dev, int type,
@@ -254,13 +263,7 @@ static int airoha_ppe_foe_entry_prepare(struct airoha_eth *eth,
 
 	qdata = FIELD_PREP(AIROHA_FOE_SHAPER_ID, 0x7f);
 	if (type == PPE_PKT_TYPE_BRIDGE) {
-		hwe->bridge.dest_mac_hi = get_unaligned_be32(data->eth.h_dest);
-		hwe->bridge.dest_mac_lo =
-			get_unaligned_be16(data->eth.h_dest + 4);
-		hwe->bridge.src_mac_hi =
-			get_unaligned_be16(data->eth.h_source);
-		hwe->bridge.src_mac_lo =
-			get_unaligned_be32(data->eth.h_source + 2);
+		airoha_ppe_foe_set_bridge_addrs(&hwe->bridge, &data->eth);
 		hwe->bridge.data = qdata;
 		hwe->bridge.ib2 = val;
 		l2 = &hwe->bridge.l2.common;
@@ -385,6 +388,19 @@ static u32 airoha_ppe_foe_get_entry_hash(struct airoha_foe_entry *hwe)
 		hv3 = hwe->ipv6.src_ip[1] ^ hwe->ipv6.dest_ip[1];
 		hv3 ^= hwe->ipv6.src_ip[0];
 		break;
+	case PPE_PKT_TYPE_BRIDGE: {
+		struct airoha_foe_mac_info *l2 = &hwe->bridge.l2;
+
+		hv1 = l2->common.src_mac_hi & 0xffff;
+		hv1 = hv1 << 16 | l2->src_mac_lo;
+
+		hv2 = l2->common.dest_mac_lo;
+		hv2 = hv2 << 16;
+		hv2 = hv2 | ((l2->common.src_mac_hi & 0xffff0000) >> 16);
+
+		hv3 = l2->common.dest_mac_hi;
+		break;
+	}
 	case PPE_PKT_TYPE_IPV4_DSLITE:
 	case PPE_PKT_TYPE_IPV6_6RD:
 	default:
@@ -483,30 +499,100 @@ static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 	return 0;
 }
 
+static void airoha_ppe_foe_remove_flow(struct airoha_ppe *ppe,
+				       struct airoha_flow_table_entry *e)
+{
+	lockdep_assert_held(&ppe_lock);
+
+	hlist_del_init(&e->list);
+	if (e->hash != 0xffff) {
+		e->data.ib1 &= ~AIROHA_FOE_IB1_BIND_STATE;
+		e->data.ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
+					  AIROHA_FOE_STATE_INVALID);
+		airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash);
+		e->hash = 0xffff;
+	}
+	if (e->type == FLOW_TYPE_L2_SUBFLOW) {
+		hlist_del_init(&e->l2_subflow_node);
+		kfree(e);
+	}
+}
+
+static void airoha_ppe_foe_remove_l2_flow(struct airoha_ppe *ppe,
+					  struct airoha_flow_table_entry *e)
+{
+	struct hlist_head *head = &e->l2_flows;
+	struct hlist_node *n;
+
+	lockdep_assert_held(&ppe_lock);
+
+	rhashtable_remove_fast(&ppe->l2_flows, &e->l2_node,
+			       airoha_l2_flow_table_params);
+	hlist_for_each_entry_safe(e, n, head, l2_subflow_node)
+		airoha_ppe_foe_remove_flow(ppe, e);
+}
+
 static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
 					     struct airoha_flow_table_entry *e)
 {
 	lockdep_assert_held(&ppe_lock);
 
-	if (e->type == FLOW_TYPE_L2) {
-		rhashtable_remove_fast(&ppe->l2_flows, &e->l2_node,
-				       airoha_l2_flow_table_params);
-	} else {
-		hlist_del_init(&e->list);
-		if (e->hash != 0xffff) {
-			e->data.ib1 &= ~AIROHA_FOE_IB1_BIND_STATE;
-			e->data.ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
-						  AIROHA_FOE_STATE_INVALID);
-			airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash);
-			e->hash = 0xffff;
-		}
-	}
+	if (e->type == FLOW_TYPE_L2)
+		airoha_ppe_foe_remove_l2_flow(ppe, e);
+	else
+		airoha_ppe_foe_remove_flow(ppe, e);
 }
 
-static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe, u32 hash)
+static int
+airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
+				    struct airoha_flow_table_entry *e,
+				    u32 hash)
+{
+	u32 mask = AIROHA_FOE_IB1_BIND_PACKET_TYPE | AIROHA_FOE_IB1_BIND_UDP;
+	struct airoha_foe_entry *hwe_p, hwe;
+	struct airoha_flow_table_entry *f;
+	struct airoha_foe_mac_info *l2;
+	int type;
+
+	hwe_p = airoha_ppe_foe_get_entry(ppe, hash);
+	if (!hwe_p)
+		return -EINVAL;
+
+	f = kzalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return -ENOMEM;
+
+	hlist_add_head(&f->l2_subflow_node, &e->l2_flows);
+	f->type = FLOW_TYPE_L2_SUBFLOW;
+	f->hash = hash;
+
+	memcpy(&hwe, hwe_p, sizeof(*hwe_p));
+	hwe.ib1 = (hwe.ib1 & mask) | (e->data.ib1 & ~mask);
+	l2 = &hwe.bridge.l2;
+	memcpy(l2, &e->data.bridge.l2, sizeof(*l2));
+
+	type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe.ib1);
+	if (type == PPE_PKT_TYPE_IPV4_HNAPT)
+		memcpy(&hwe.ipv4.new_tuple, &hwe.ipv4.orig_tuple,
+		       sizeof(hwe.ipv4.new_tuple));
+	else if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T &&
+		 l2->common.etype == ETH_P_IP)
+		l2->common.etype = ETH_P_IPV6;
+
+	hwe.bridge.ib2 = e->data.bridge.ib2;
+	airoha_ppe_foe_commit_entry(ppe, &hwe, hash);
+
+	return 0;
+}
+
+static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
+					struct sk_buff *skb,
+					u32 hash)
 {
 	struct airoha_flow_table_entry *e;
+	struct airoha_foe_bridge br = {};
 	struct airoha_foe_entry *hwe;
+	bool commit_done = false;
 	struct hlist_node *n;
 	u32 index, state;
 
@@ -522,12 +608,33 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe, u32 hash)
 
 	index = airoha_ppe_foe_get_entry_hash(hwe);
 	hlist_for_each_entry_safe(e, n, &ppe->foe_flow[index], list) {
-		if (airoha_ppe_foe_compare_entry(e, hwe)) {
-			airoha_ppe_foe_commit_entry(ppe, &e->data, hash);
-			e->hash = hash;
-			break;
+		if (e->type == FLOW_TYPE_L2_SUBFLOW) {
+			state = FIELD_GET(AIROHA_FOE_IB1_BIND_STATE, hwe->ib1);
+			if (state != AIROHA_FOE_STATE_BIND) {
+				e->hash = 0xffff;
+				airoha_ppe_foe_remove_flow(ppe, e);
+			}
+			continue;
+		}
+
+		if (commit_done || !airoha_ppe_foe_compare_entry(e, hwe)) {
+			e->hash = 0xffff;
+			continue;
 		}
+
+		airoha_ppe_foe_commit_entry(ppe, &e->data, hash);
+		commit_done = true;
+		e->hash = hash;
 	}
+
+	if (commit_done)
+		goto unlock;
+
+	airoha_ppe_foe_set_bridge_addrs(&br, eth_hdr(skb));
+	e = rhashtable_lookup_fast(&ppe->l2_flows, &br,
+				   airoha_l2_flow_table_params);
+	if (e)
+		airoha_ppe_foe_commit_subflow_entry(ppe, e, hash);
 unlock:
 	spin_unlock_bh(&ppe_lock);
 }
@@ -890,7 +997,8 @@ int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 	return err;
 }
 
-void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash)
+void airoha_ppe_check_skb(struct airoha_ppe *ppe, struct sk_buff *skb,
+			  u16 hash)
 {
 	u16 now, diff;
 
@@ -903,7 +1011,7 @@ void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash)
 		return;
 
 	ppe->foe_check_time[hash] = now;
-	airoha_ppe_foe_insert_entry(ppe, hash);
+	airoha_ppe_foe_insert_entry(ppe, skb, hash);
 }
 
 int airoha_ppe_init(struct airoha_eth *eth)

-- 
2.49.0


