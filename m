Return-Path: <netdev+bounces-164087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A35A2C8CF
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B168916973B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40CE1990DE;
	Fri,  7 Feb 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3if5/rK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9A18DB14;
	Fri,  7 Feb 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945641; cv=none; b=u0/+vNbun4OQGN02cAYyvv8JVtNEG6Qaqo8FiigLPXXX51SIDD21BL8HTjeucFMkDODSOlplBU9JfiPD1uxnYtpLjDNr9zs23hxOo5BwAr1C99/5SLYOf4sAveGL1LpZVcBcIqDmqh4JvSmQmDKF2xsrKqNlLebtDIT6Ojx+RnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945641; c=relaxed/simple;
	bh=+2BGReS+UvVYrGtVJA0nI+XTXSnhi1JR1W5KwkJxkWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkkgENCJLqDftDaZCYeqoiOdth8urOoeSgRZsVdxT0v6mo1KxNz8GoQ9zQwXkjARxGQNTN2lGCBnhcsLsgZ3yWgGWUDztjW7sLJ79KnRQ+6tDXmfXbb2Rz1rH3XVZ11oqAwpmToBOxBwIGGoEDbKbzjQuEV/ozStWRImoTRejwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3if5/rK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB55C4CED1;
	Fri,  7 Feb 2025 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738945641;
	bh=+2BGReS+UvVYrGtVJA0nI+XTXSnhi1JR1W5KwkJxkWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P3if5/rKLggAV+gycD0tSET4fw4uj9ruCVS6iBQvmcxhzeots51FjRvIQe7W5Cl7I
	 suFP4WUwwgghr7tK1l3m2DSJYzmlk/RD1jJjbzPru5LXEf4rHrF9ZusPOnUOBG7/Qc
	 L8urvUBRNdfjIuDvc0kUE1pRVO15dYfbkrMqbiE0CrX9a/FYGutmcPKVuCxemzvOfk
	 9NxlFz3qxYi2lI1KFqmL8X4N2Ht8JIEUe+TwrCqjOkZK5B1GynP74iTitNjFI3XU27
	 huU0NjLqG1lqXO5ZMQFKBSUKZuMY9o6Y8UhE47AdJ+UB0LkjyNWkNScEWnJa8Zttl6
	 CyQ/lXhdo+OMQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 07 Feb 2025 17:26:28 +0100
Subject: [PATCH net-next v2 13/15] net: airoha: Introduce flowtable offload
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-airoha-en7581-flowtable-offload-v2-13-3a2239692a67@kernel.org>
References: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
In-Reply-To: <20250207-airoha-en7581-flowtable-offload-v2-0-3a2239692a67@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 "Chester A. Unal" <chester.a.unal@arinc9.com>, 
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

Introduce netfilter flowtable integration in order to allow airoha_eth
driver to offload 5-tuple flower rules learned by the PPE module if the
user accelerates them using a nft configuration similar to the one reported
below:

table inet filter {
	flowtable ft {
		hook ingress priority filter
		devices = { lan1, lan2, lan3, lan4, eth1 }
		flags offload;
	}
	chain forward {
		type filter hook forward priority filter; policy accept;
		meta l4proto { tcp, udp } flow add @ft
	}
}

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c |  56 ++-
 drivers/net/ethernet/airoha/airoha_eth.h | 242 ++++++++++-
 drivers/net/ethernet/airoha/airoha_npu.c |  50 +++
 drivers/net/ethernet/airoha/airoha_ppe.c | 690 ++++++++++++++++++++++++++++++-
 4 files changed, 1029 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 592aafc7c0d0a1da018a8bdfcb1f3ffe11286965..ac581658769a240ea483ee87c1543bf5c7cea05e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -5,10 +5,8 @@
  */
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
-#include <net/dsa.h>
 #include <net/dst_metadata.h>
 #include <net/page_pool/helpers.h>
-#include <net/pkt_cls.h>
 #include <uapi/linux/ppp_defs.h>
 
 #include "airoha_regs.h"
@@ -616,6 +614,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 	while (done < budget) {
 		struct airoha_queue_entry *e = &q->entry[q->tail];
 		struct airoha_qdma_desc *desc = &q->desc[q->tail];
+		u32 hash, reason, msg1 = le32_to_cpu(desc->msg1);
 		dma_addr_t dma_addr = le32_to_cpu(desc->addr);
 		u32 desc_ctrl = le32_to_cpu(desc->ctrl);
 		struct airoha_gdm_port *port;
@@ -678,6 +677,15 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 						  &port->dsa_meta[sptag]->dst);
 		}
 
+		hash = FIELD_GET(AIROHA_RXD4_FOE_ENTRY, msg1);
+		if (hash != AIROHA_RXD4_FOE_ENTRY)
+			skb_set_hash(skb, jhash_1word(hash, 0),
+				     PKT_HASH_TYPE_L4);
+
+		reason = FIELD_GET(AIROHA_RXD4_PPE_CPU_REASON, msg1);
+		if (reason == PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED)
+			airoha_ppe_check_skb(eth->ppe, hash);
+
 		napi_gro_receive(&q->napi, skb);
 
 		done++;
@@ -2157,6 +2165,47 @@ static int airoha_tc_htb_alloc_leaf_queue(struct airoha_gdm_port *port,
 	return 0;
 }
 
+static int airoha_dev_setup_tc_block(struct airoha_gdm_port *port,
+				     struct flow_block_offload *f)
+{
+	flow_setup_cb_t *cb = airoha_ppe_setup_tc_block_cb;
+	static LIST_HEAD(block_cb_list);
+	struct flow_block_cb *block_cb;
+
+	if (f->binder_type != FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
+		return -EOPNOTSUPP;
+
+	f->driver_block_list = &block_cb_list;
+	switch (f->command) {
+	case FLOW_BLOCK_BIND:
+		block_cb = flow_block_cb_lookup(f->block, cb, port->dev);
+		if (block_cb) {
+			flow_block_cb_incref(block_cb);
+			return 0;
+		}
+		block_cb = flow_block_cb_alloc(cb, port->dev, port->dev, NULL);
+		if (IS_ERR(block_cb))
+			return PTR_ERR(block_cb);
+
+		flow_block_cb_incref(block_cb);
+		flow_block_cb_add(block_cb, f);
+		list_add_tail(&block_cb->driver_list, &block_cb_list);
+		return 0;
+	case FLOW_BLOCK_UNBIND:
+		block_cb = flow_block_cb_lookup(f->block, cb, port->dev);
+		if (!block_cb)
+			return -ENOENT;
+
+		if (!flow_block_cb_decref(block_cb)) {
+			flow_block_cb_remove(block_cb, f);
+			list_del(&block_cb->driver_list);
+		}
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void airoha_tc_remove_htb_queue(struct airoha_gdm_port *port, int queue)
 {
 	struct net_device *dev = port->dev;
@@ -2240,6 +2289,9 @@ static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
 		return airoha_tc_setup_qdisc_ets(port, type_data);
 	case TC_SETUP_QDISC_HTB:
 		return airoha_tc_setup_qdisc_htb(port, type_data);
+	case TC_SETUP_BLOCK:
+	case TC_SETUP_FT:
+		return airoha_dev_setup_tc_block(port, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index d882b8c74c713209d15603311e4837f1502bbbfd..c51fa6713be07415a56ba4da2456d738d9a8f2af 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -16,6 +16,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
+#include <net/dsa.h>
+#include <net/pkt_cls.h>
 
 #define AIROHA_NPU_NUM_CORES		8
 #define AIROHA_MAX_NUM_GDM_PORTS	4
@@ -209,8 +211,224 @@ struct airoha_hw_stats {
 	u64 rx_len[7];
 };
 
+enum {
+	PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED = 0x0f,
+};
+
+enum {
+	AIROHA_FOE_STATE_INVALID,
+	AIROHA_FOE_STATE_UNBIND,
+	AIROHA_FOE_STATE_BIND,
+	AIROHA_FOE_STATE_FIN
+};
+
+enum {
+	PPE_PKT_TYPE_IPV4_HNAPT = 0,
+	PPE_PKT_TYPE_IPV4_ROUTE = 1,
+	PPE_PKT_TYPE_BRIDGE = 2,
+	PPE_PKT_TYPE_IPV4_DSLITE = 3,
+	PPE_PKT_TYPE_IPV6_ROUTE_3T = 4,
+	PPE_PKT_TYPE_IPV6_ROUTE_5T = 5,
+	PPE_PKT_TYPE_IPV6_6RD = 7,
+};
+
+#define AIROHA_FOE_MAC_PPPOE_ID		GENMASK(15, 0)
+#define AIROHA_FOE_MAC_SMAC_ID		GENMASK(20, 16)
+
+struct airoha_foe_mac_info_common {
+	u16 vlan1;
+	u16 etype;
+
+	u32 dest_mac_hi;
+
+	u16 vlan2;
+	u16 dest_mac_lo;
+
+	u32 src_mac_hi;
+};
+
+struct airoha_foe_mac_info {
+	struct airoha_foe_mac_info_common common;
+
+	u16 pppoe_id;
+	u16 src_mac_lo;
+};
+
+#define AIROHA_FOE_IB1_UNBIND_TIMESTAMP		GENMASK(7, 0)
+#define AIROHA_FOE_IB1_UNBIND_PACKETS		GENMASK(23, 8)
+#define AIROHA_FOE_IB1_UNBIND_PREBIND		BIT(24)
+
+#define AIROHA_FOE_IB1_BIND_TIMESTAMP		GENMASK(14, 0)
+#define AIROHA_FOE_IB1_BIND_KEEPALIVE		BIT(15)
+#define AIROHA_FOE_IB1_BIND_VLAN_LAYER		GENMASK(18, 16)
+#define AIROHA_FOE_IB1_BIND_PPPOE		BIT(19)
+#define AIROHA_FOE_IB1_BIND_VLAN_TAG		BIT(20)
+#define AIROHA_FOE_IB1_BIND_PKT_SAMPLE		BIT(21)
+#define AIROHA_FOE_IB1_BIND_CACHE		BIT(22)
+#define AIROHA_FOE_IB1_BIND_TUNNEL_DECAP	BIT(23)
+#define AIROHA_FOE_IB1_BIND_TTL			BIT(24)
+#define AIROHA_FOE_IB1_PACKET_TYPE		GENMASK(27, 25)
+#define AIROHA_FOE_IB1_STATE			GENMASK(29, 28)
+#define AIROHA_FOE_IB1_UDP			BIT(30)
+#define AIROHA_FOE_IB1_STATIC			BIT(31)
+
+#define AIROHA_FOE_IB2_NBQ			GENMASK(4, 0)
+#define AIROHA_FOE_IB2_PSE_PORT			GENMASK(8, 5)
+#define AIROHA_FOE_IB2_PSE_QOS			BIT(9)
+#define AIROHA_FOE_IB2_FAST_PATH		BIT(10)
+#define AIROHA_FOE_IB2_MULTICAST		BIT(11)
+#define AIROHA_FOE_IB2_PCP			BIT(12)
+#define AIROHA_FOE_IB2_PORT_AG			GENMASK(23, 13)
+#define AIROHA_FOE_IB2_DSCP			GENMASK(31, 24)
+
+#define AIROHA_FOE_TUNNEL_ID			GENMASK(5, 0)
+#define AIROHA_FOE_TUNNEL			BIT(6)
+#define AIROHA_FOE_DPI				BIT(7)
+#define AIROHA_FOE_QID				GENMASK(10, 8)
+#define AIROHA_FOE_CHANNEL			GENMASK(15, 11)
+#define AIROHA_FOE_SHAPER_ID			GENMASK(23, 16)
+#define AIROHA_FOE_ACTDP			GENMASK(31, 24)
+
+struct airoha_foe_bridge {
+	u32 dest_mac_hi;
+
+	u16 src_mac_hi;
+	u16 dest_mac_lo;
+
+	u32 src_mac_lo;
+
+	u32 ib2;
+
+	u32 rsv[5];
+
+	u32 data;
+
+	struct airoha_foe_mac_info l2;
+};
+
+struct airoha_foe_ipv4_tuple {
+	u32 src_ip;
+	u32 dest_ip;
+	union {
+		struct {
+			u16 dest_port;
+			u16 src_port;
+		};
+		struct {
+			u8 protocol;
+			u8 _pad[3]; /* fill with 0xa5a5a5 */
+		};
+		u32 ports;
+	};
+};
+
+struct airoha_foe_ipv4 {
+	struct airoha_foe_ipv4_tuple orig_tuple;
+
+	u32 ib2;
+
+	struct airoha_foe_ipv4_tuple new_tuple;
+
+	u32 rsv[2];
+
+	u32 data;
+
+	struct airoha_foe_mac_info l2;
+};
+
+struct airoha_foe_ipv4_dslite {
+	struct airoha_foe_ipv4_tuple ip4;
+
+	u32 ib2;
+
+	u8 flow_label[3];
+	u8 priority;
+
+	u32 rsv[4];
+
+	u32 data;
+
+	struct airoha_foe_mac_info l2;
+};
+
+struct airoha_foe_ipv6 {
+	u32 src_ip[4];
+	u32 dest_ip[4];
+
+	union {
+		struct {
+			u16 dest_port;
+			u16 src_port;
+		};
+		struct {
+			u8 protocol;
+			u8 pad[3];
+		};
+		u32 ports;
+	};
+
+	u32 data;
+
+	u32 ib2;
+
+	struct airoha_foe_mac_info_common l2;
+};
+
 struct airoha_foe_entry {
-	u8 data[PPE_ENTRY_SIZE];
+	union {
+		struct {
+			u32 ib1;
+			union {
+				struct airoha_foe_bridge bridge;
+				struct airoha_foe_ipv4 ipv4;
+				struct airoha_foe_ipv4_dslite dslite;
+				struct airoha_foe_ipv6 ipv6;
+				DECLARE_FLEX_ARRAY(u32, d);
+			};
+		};
+		u8 data[PPE_ENTRY_SIZE];
+	};
+};
+
+struct airoha_flow_data {
+	struct ethhdr eth;
+
+	union {
+		struct {
+			__be32 src_addr;
+			__be32 dst_addr;
+		} v4;
+
+		struct {
+			struct in6_addr src_addr;
+			struct in6_addr dst_addr;
+		} v6;
+	};
+
+	__be16 src_port;
+	__be16 dst_port;
+
+	u16 vlan_in;
+
+	struct {
+		u16 id;
+		__be16 proto;
+		u8 num;
+	} vlan;
+	struct {
+		u16 sid;
+		u8 num;
+	} pppoe;
+};
+
+struct airoha_flow_table_entry {
+	struct hlist_node list;
+
+	struct airoha_foe_entry data;
+	u32 hash;
+
+	struct rhash_head node;
+	unsigned long cookie;
 };
 
 struct airoha_qdma {
@@ -266,11 +484,17 @@ struct airoha_npu {
 	} cores[AIROHA_NPU_NUM_CORES];
 };
 
+#define AIROHA_RXD4_FOE_ENTRY		GENMASK(15, 0)
+#define AIROHA_RXD4_PPE_CPU_REASON	GENMASK(20, 16)
+
 struct airoha_ppe {
 	struct airoha_eth *eth;
 
 	void *foe;
 	dma_addr_t foe_dma;
+
+	struct hlist_head *foe_flow;
+	u16 foe_check_time[PPE_NUM_ENTRIES];
 };
 
 struct airoha_eth {
@@ -281,6 +505,7 @@ struct airoha_eth {
 
 	struct airoha_npu *npu;
 	struct airoha_ppe *ppe;
+	struct rhashtable flow_table;
 
 	struct reset_control_bulk_data rsts[AIROHA_MAX_NUM_RSTS];
 	struct reset_control_bulk_data xsi_rsts[AIROHA_MAX_NUM_XSI_RSTS];
@@ -318,6 +543,12 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
 bool airoha_ppe2_is_enabled(struct airoha_eth *eth);
+void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash);
+int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
+				 void *cb_priv);
+u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe);
+struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
+						  u32 hash);
 
 #ifdef CONFIG_NET_AIROHA_NPU
 int airoha_ppe_init(struct airoha_eth *eth);
@@ -328,6 +559,8 @@ int airoha_npu_ppe_init(struct airoha_npu *npu);
 int airoha_npu_ppe_deinit(struct airoha_npu *npu);
 int airoha_npu_flush_ppe_sram_entries(struct airoha_npu *npu,
 				      struct airoha_ppe *ppe);
+int airoha_npu_foe_commit_entry(struct airoha_ppe *ppe,
+				struct airoha_foe_entry *e, u32 hash);
 #else
 static inline int airoha_ppe_init(struct airoha_eth *eth)
 {
@@ -362,6 +595,13 @@ static inline int airoha_npu_flush_ppe_sram_entries(struct airoha_npu *npu,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int airoha_npu_foe_commit_entry(struct airoha_ppe *ppe,
+					      struct airoha_foe_entry *e,
+					      u32 hash)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_NET_AIROHA_NPU */
 
 #endif /* AIROHA_ETH_H */
diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index b912ab4c02166d7f9f1aaacb4b5b6b30740a3b6c..f8b2407a5dd2086a1a5da469a70720b8b0a22a7f 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -336,6 +336,56 @@ static irqreturn_t airoha_npu_wdt_handler(int irq, void *core_instance)
 	return IRQ_HANDLED;
 }
 
+int airoha_npu_foe_commit_entry(struct airoha_ppe *ppe,
+				struct airoha_foe_entry *e, u32 hash)
+{
+	struct airoha_foe_entry *hwe = ppe->foe + hash * sizeof(*hwe);
+	u16 ts = airoha_ppe_get_timestamp(ppe);
+
+	memcpy(&hwe->d, &e->d, sizeof(*hwe) - sizeof(hwe->ib1));
+	wmb();
+
+	e->ib1 &= ~AIROHA_FOE_IB1_BIND_TIMESTAMP;
+	e->ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_TIMESTAMP, ts);
+	hwe->ib1 = e->ib1;
+
+	if (hash < PPE_SRAM_NUM_ENTRIES) {
+		dma_addr_t addr = ppe->foe_dma + hash * sizeof(*hwe);
+		struct ppe_mbox_data ppe_data = {
+			.func_type = NPU_OP_SET,
+			.func_id = PPE_FUNC_SET_WAIT_API,
+			.set_info = {
+				.data = addr,
+				.size = sizeof(*hwe),
+			},
+		};
+		struct airoha_eth *eth = ppe->eth;
+		bool ppe2;
+		int err;
+
+		ppe2 = airoha_ppe2_is_enabled(ppe->eth) &&
+		       hash >= PPE1_SRAM_NUM_ENTRIES;
+		ppe_data.set_info.func_id = ppe2 ? PPE2_SRAM_SET_ENTRY
+						 : PPE_SRAM_SET_ENTRY;
+
+		err = airoha_npu_send_msg(eth->npu, NPU_FUNC_PPE, &ppe_data,
+					  sizeof(struct ppe_mbox_data));
+		if (err)
+			return err;
+
+		ppe_data.set_info.func_id = PPE_SRAM_SET_VAL;
+		ppe_data.set_info.data = hash;
+		ppe_data.set_info.size = sizeof(u32);
+
+		err = airoha_npu_send_msg(eth->npu, NPU_FUNC_PPE, &ppe_data,
+					  sizeof(struct ppe_mbox_data));
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 struct airoha_npu *airoha_npu_init(struct airoha_eth *eth)
 {
 	struct reserved_mem *rmem;
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 63fc09f6f705cc1a876c39a786fb18a3a58f97f1..712e673d3a50a1a249a5d8eceffd0cccf6c03474 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -4,14 +4,678 @@
  * Author: Lorenzo Bianconi <lorenzo@kernel.org>
  */
 
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/rhashtable.h>
+#include <net/ipv6.h>
+
 #include "airoha_regs.h"
 #include "airoha_eth.h"
 
+static DEFINE_MUTEX(flow_offload_mutex);
+static DEFINE_SPINLOCK(ppe_lock);
+
 bool airoha_ppe2_is_enabled(struct airoha_eth *eth)
 {
 	return airoha_fe_rr(eth, REG_PPE_GLO_CFG(1)) & PPE_GLO_CFG_EN_MASK;
 }
 
+static const struct rhashtable_params airoha_flow_table_params = {
+	.head_offset = offsetof(struct airoha_flow_table_entry, node),
+	.key_offset = offsetof(struct airoha_flow_table_entry, cookie),
+	.key_len = sizeof(unsigned long),
+	.automatic_shrinking = true,
+};
+
+u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
+{
+	u16 timestamp = airoha_fe_rr(ppe->eth, REG_FE_FOE_TS);
+
+	return FIELD_GET(AIROHA_FOE_IB1_BIND_TIMESTAMP, timestamp);
+}
+
+static void airoha_ppe_flow_mangle_eth(const struct flow_action_entry *act, void *eth)
+{
+	void *dest = eth + act->mangle.offset;
+	const void *src = &act->mangle.val;
+
+	if (act->mangle.offset > 8)
+		return;
+
+	if (act->mangle.mask == 0xffff) {
+		src += 2;
+		dest += 2;
+	}
+
+	memcpy(dest, src, act->mangle.mask ? 2 : 4);
+}
+
+static int airoha_ppe_flow_mangle_ports(const struct flow_action_entry *act,
+					struct airoha_flow_data *data)
+{
+	u32 val = be32_to_cpu((__force __be32)act->mangle.val);
+
+	switch (act->mangle.offset) {
+	case 0:
+		if ((__force __be32)act->mangle.mask == ~cpu_to_be32(0xffff))
+			data->dst_port = cpu_to_be16(val);
+		else
+			data->src_port = cpu_to_be16(val >> 16);
+		break;
+	case 2:
+		data->dst_port = cpu_to_be16(val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int airoha_ppe_flow_mangle_ipv4(const struct flow_action_entry *act,
+				       struct airoha_flow_data *data)
+{
+	__be32 *dest;
+
+	switch (act->mangle.offset) {
+	case offsetof(struct iphdr, saddr):
+		dest = &data->v4.src_addr;
+		break;
+	case offsetof(struct iphdr, daddr):
+		dest = &data->v4.dst_addr;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	memcpy(dest, &act->mangle.val, sizeof(u32));
+
+	return 0;
+}
+
+static int airoha_get_dsa_port(struct net_device **dev)
+{
+#if IS_ENABLED(CONFIG_NET_DSA)
+	struct dsa_port *dp = dsa_port_from_netdev(*dev);
+
+	if (IS_ERR(dp))
+		return -ENODEV;
+
+	*dev = dsa_port_to_conduit(dp);
+	return dp->index;
+#else
+	return -ENODEV;
+#endif
+}
+
+static int airoha_ppe_foe_entry_prepare(struct airoha_foe_entry *hwe,
+					struct net_device *dev, int type,
+					int l4proto, u8 *src_mac, u8 *dest_mac)
+{
+	int dsa_port = airoha_get_dsa_port(&dev);
+	struct airoha_foe_mac_info_common *l2;
+	u32 data, ports_pad, val;
+
+	memset(hwe, 0, sizeof(*hwe));
+
+	val = FIELD_PREP(AIROHA_FOE_IB1_STATE, AIROHA_FOE_STATE_BIND) |
+	      FIELD_PREP(AIROHA_FOE_IB1_PACKET_TYPE, type) |
+	      FIELD_PREP(AIROHA_FOE_IB1_UDP, l4proto == IPPROTO_UDP) |
+	      AIROHA_FOE_IB1_BIND_TTL;
+	hwe->ib1 = val;
+
+	val = FIELD_PREP(AIROHA_FOE_IB2_PORT_AG, 0x1f);
+	if (dsa_port >= 0)
+		val |= FIELD_PREP(AIROHA_FOE_IB2_NBQ, dsa_port);
+	if (dev) {
+		struct airoha_gdm_port *port = netdev_priv(dev);
+		u8 pse_port;
+
+		pse_port = port->id == 4 ? FE_PSE_PORT_GDM4 : port->id;
+		val |= FIELD_PREP(AIROHA_FOE_IB2_PSE_PORT, pse_port);
+	}
+
+	/* FIXME: implement QoS support setting pse_port to 2 (loopback)
+	 * for uplink and setting qos bit in ib2
+	 */
+
+	if (is_multicast_ether_addr(dest_mac))
+		val |= AIROHA_FOE_IB2_MULTICAST;
+
+	ports_pad = 0xa5a5a500 | (l4proto & 0xff);
+	if (type == PPE_PKT_TYPE_IPV4_ROUTE)
+		hwe->ipv4.orig_tuple.ports = ports_pad;
+	if (type == PPE_PKT_TYPE_IPV6_ROUTE_3T)
+		hwe->ipv6.ports = ports_pad;
+
+	data = FIELD_PREP(AIROHA_FOE_SHAPER_ID, 0x7f);
+	if (type == PPE_PKT_TYPE_BRIDGE) {
+		hwe->bridge.dest_mac_hi = get_unaligned_be32(dest_mac);
+		hwe->bridge.dest_mac_lo = get_unaligned_be16(dest_mac + 4);
+		hwe->bridge.src_mac_hi = get_unaligned_be16(src_mac);
+		hwe->bridge.src_mac_lo = get_unaligned_be32(src_mac + 2);
+		hwe->bridge.data = data;
+		hwe->bridge.ib2 = val;
+		l2 = &hwe->bridge.l2.common;
+	} else if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T) {
+		hwe->ipv6.data = data;
+		hwe->ipv6.ib2 = val;
+		l2 = &hwe->ipv6.l2;
+	} else {
+		hwe->ipv4.data = data;
+		hwe->ipv4.ib2 = val;
+		l2 = &hwe->ipv4.l2.common;
+	}
+
+	l2->dest_mac_hi = get_unaligned_be32(dest_mac);
+	l2->dest_mac_lo = get_unaligned_be16(dest_mac + 4);
+	if (type <= PPE_PKT_TYPE_IPV4_DSLITE) {
+		l2->src_mac_hi = get_unaligned_be32(src_mac);
+		hwe->ipv4.l2.src_mac_lo = get_unaligned_be16(src_mac + 4);
+	} else {
+		l2->src_mac_hi = FIELD_PREP(AIROHA_FOE_MAC_SMAC_ID, 0xf);
+	}
+
+	if (dsa_port >= 0)
+		l2->etype = BIT(15) | BIT(dsa_port);
+	else if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T)
+		l2->etype = ETH_P_IPV6;
+	else
+		l2->etype = ETH_P_IP;
+
+	return 0;
+}
+
+static int airoha_ppe_foe_entry_set_ipv4_tuple(struct airoha_foe_entry *hwe,
+					       struct airoha_flow_data *data,
+					       bool egress)
+{
+	int type = FIELD_GET(AIROHA_FOE_IB1_PACKET_TYPE, hwe->ib1);
+	struct airoha_foe_ipv4_tuple *t;
+
+	switch (type) {
+	case PPE_PKT_TYPE_IPV4_HNAPT:
+		if (egress) {
+			t = &hwe->ipv4.new_tuple;
+			break;
+		}
+		fallthrough;
+	case PPE_PKT_TYPE_IPV4_DSLITE:
+	case PPE_PKT_TYPE_IPV4_ROUTE:
+		t = &hwe->ipv4.orig_tuple;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	t->src_ip = be32_to_cpu(data->v4.src_addr);
+	t->dest_ip = be32_to_cpu(data->v4.dst_addr);
+
+	if (type != PPE_PKT_TYPE_IPV4_ROUTE) {
+		t->src_port = be16_to_cpu(data->src_port);
+		t->dest_port = be16_to_cpu(data->dst_port);
+	}
+
+	return 0;
+}
+
+static int airoha_ppe_foe_entry_set_ipv6_tuple(struct airoha_foe_entry *hwe,
+					       struct airoha_flow_data *data)
+
+{
+	int type = FIELD_GET(AIROHA_FOE_IB1_PACKET_TYPE, hwe->ib1);
+	u32 *src, *dest;
+
+	switch (type) {
+	case PPE_PKT_TYPE_IPV6_ROUTE_5T:
+	case PPE_PKT_TYPE_IPV6_6RD:
+		hwe->ipv6.src_port = be16_to_cpu(data->src_port);
+		hwe->ipv6.dest_port = be16_to_cpu(data->dst_port);
+		fallthrough;
+	case PPE_PKT_TYPE_IPV6_ROUTE_3T:
+		src = hwe->ipv6.src_ip;
+		dest = hwe->ipv6.dest_ip;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
+
+	ipv6_addr_be32_to_cpu(src, data->v6.src_addr.s6_addr32);
+	ipv6_addr_be32_to_cpu(dest, data->v6.dst_addr.s6_addr32);
+
+	return 0;
+}
+
+static u32 airoha_ppe_foe_get_entry_hash(struct airoha_foe_entry *hwe)
+{
+	int type = FIELD_GET(AIROHA_FOE_IB1_PACKET_TYPE, hwe->ib1);
+	u32 hash, hv1, hv2, hv3;
+
+	switch (type) {
+	case PPE_PKT_TYPE_IPV4_ROUTE:
+	case PPE_PKT_TYPE_IPV4_HNAPT:
+		hv1 = hwe->ipv4.orig_tuple.ports;
+		hv2 = hwe->ipv4.orig_tuple.dest_ip;
+		hv3 = hwe->ipv4.orig_tuple.src_ip;
+		break;
+	case PPE_PKT_TYPE_IPV6_ROUTE_3T:
+	case PPE_PKT_TYPE_IPV6_ROUTE_5T:
+		hv1 = hwe->ipv6.src_ip[3] ^ hwe->ipv6.dest_ip[3];
+		hv1 ^= hwe->ipv6.ports;
+
+		hv2 = hwe->ipv6.src_ip[2] ^ hwe->ipv6.dest_ip[2];
+		hv2 ^= hwe->ipv6.dest_ip[0];
+
+		hv3 = hwe->ipv6.src_ip[1] ^ hwe->ipv6.dest_ip[1];
+		hv3 ^= hwe->ipv6.src_ip[0];
+		break;
+	case PPE_PKT_TYPE_IPV4_DSLITE:
+	case PPE_PKT_TYPE_IPV6_6RD:
+	default:
+		WARN_ON_ONCE(1);
+		return PPE_HASH_MASK;
+	}
+
+	hash = (hv1 & hv2) | ((~hv1) & hv3);
+	hash = (hash >> 24) | ((hash & 0xffffff) << 8);
+	hash ^= hv1 ^ hv2 ^ hv3;
+	hash ^= hash >> 16;
+	hash &= PPE_NUM_ENTRIES - 1;
+
+	return hash;
+}
+
+struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
+						  u32 hash)
+{
+	if (hash < PPE_SRAM_NUM_ENTRIES) {
+		u32 *hwe = ppe->foe + hash * sizeof(struct airoha_foe_entry);
+		struct airoha_eth *eth = ppe->eth;
+		bool ppe2;
+		u32 val;
+		int i;
+
+		ppe2 = airoha_ppe2_is_enabled(ppe->eth) &&
+		       hash >= PPE1_SRAM_NUM_ENTRIES;
+		airoha_fe_wr(ppe->eth, REG_PPE_RAM_CTRL(ppe2),
+			     FIELD_PREP(PPE_SRAM_CTRL_ENTRY_MASK, hash) |
+			     PPE_SRAM_CTRL_REQ_MASK);
+		if (read_poll_timeout_atomic(airoha_fe_rr, val,
+					     val & PPE_SRAM_CTRL_ACK_MASK,
+					     10, 100, false, eth,
+					     REG_PPE_RAM_CTRL(ppe2)))
+			return NULL;
+
+		for (i = 0; i < sizeof(struct airoha_foe_entry) / 4; i++)
+			hwe[i] = airoha_fe_rr(eth,
+					      REG_PPE_RAM_ENTRY(ppe2, i));
+	}
+
+	return ppe->foe + hash * sizeof(struct airoha_foe_entry);
+}
+
+static bool airoha_ppe_foe_compare_entry(struct airoha_flow_table_entry *e,
+					 struct airoha_foe_entry *hwe)
+{
+	int type = FIELD_GET(AIROHA_FOE_IB1_PACKET_TYPE, e->data.ib1), len;
+
+	if ((hwe->ib1 ^ e->data.ib1) & AIROHA_FOE_IB1_UDP)
+		return false;
+
+	if (type > PPE_PKT_TYPE_IPV4_DSLITE)
+		len = offsetof(struct airoha_foe_entry, ipv6.data);
+	else
+		len = offsetof(struct airoha_foe_entry, ipv4.ib2);
+
+	return !memcmp(&e->data.d, &hwe->d, len - sizeof(hwe->ib1));
+}
+
+static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe, u32 hash)
+{
+	struct airoha_flow_table_entry *e;
+	struct airoha_foe_entry *hwe;
+	struct hlist_node *n;
+	u32 index;
+
+	spin_lock_bh(&ppe_lock);
+
+	hwe = airoha_ppe_foe_get_entry(ppe, hash);
+	if (!hwe)
+		goto unlock;
+
+	if (FIELD_GET(AIROHA_FOE_IB1_STATE, hwe->ib1) == AIROHA_FOE_STATE_BIND)
+		goto unlock;
+
+	index = airoha_ppe_foe_get_entry_hash(hwe);
+	hlist_for_each_entry_safe(e, n, &ppe->foe_flow[index], list) {
+		if (airoha_ppe_foe_compare_entry(e, hwe)) {
+			airoha_npu_foe_commit_entry(ppe, &e->data, hash);
+			e->hash = hash;
+			break;
+		}
+	}
+unlock:
+	spin_unlock_bh(&ppe_lock);
+}
+
+static int airoha_ppe_foe_flow_commit_entry(struct airoha_ppe *ppe,
+					    struct airoha_flow_table_entry *e)
+{
+	u32 hash = airoha_ppe_foe_get_entry_hash(&e->data);
+
+	e->hash = 0xffff;
+
+	spin_lock_bh(&ppe_lock);
+	hlist_add_head(&e->list, &ppe->foe_flow[hash]);
+	spin_unlock_bh(&ppe_lock);
+
+	return 0;
+}
+
+static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
+					     struct airoha_flow_table_entry *e)
+{
+	spin_lock_bh(&ppe_lock);
+
+	hlist_del_init(&e->list);
+	if (e->hash != 0xffff) {
+		e->data.ib1 &= ~AIROHA_FOE_IB1_STATE;
+		e->data.ib1 |= FIELD_PREP(AIROHA_FOE_IB1_STATE,
+					  AIROHA_FOE_STATE_INVALID);
+		airoha_npu_foe_commit_entry(ppe, &e->data, e->hash);
+		e->hash = 0xffff;
+	}
+
+	spin_unlock_bh(&ppe_lock);
+}
+
+static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
+					   struct flow_cls_offload *f)
+{
+	struct flow_rule *rule = flow_cls_offload_flow_rule(f);
+	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_flow_table_entry *e;
+	struct airoha_flow_data data = {};
+	struct net_device *odev = NULL;
+	struct flow_action_entry *act;
+	struct airoha_foe_entry hwe;
+	int err, i, offload_type;
+	u16 addr_type = 0;
+	u8 l4proto = 0;
+
+	if (rhashtable_lookup(&eth->flow_table, &f->cookie,
+			      airoha_flow_table_params))
+		return -EEXIST;
+
+	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_META))
+		return -EOPNOTSUPP;
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
+		struct flow_match_control match;
+
+		flow_rule_match_control(rule, &match);
+		addr_type = match.key->addr_type;
+		if (flow_rule_has_control_flags(match.mask->flags,
+						f->common.extack))
+			return -EOPNOTSUPP;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_match_basic match;
+
+		flow_rule_match_basic(rule, &match);
+		l4proto = match.key->ip_proto;
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	switch (addr_type) {
+	case 0:
+		offload_type = PPE_PKT_TYPE_BRIDGE;
+		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+			struct flow_match_eth_addrs match;
+
+			flow_rule_match_eth_addrs(rule, &match);
+			memcpy(data.eth.h_dest, match.key->dst, ETH_ALEN);
+			memcpy(data.eth.h_source, match.key->src, ETH_ALEN);
+		} else {
+			return -EOPNOTSUPP;
+		}
+
+		if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_VLAN)) {
+			struct flow_match_vlan match;
+
+			flow_rule_match_vlan(rule, &match);
+			if (match.key->vlan_tpid != cpu_to_be16(ETH_P_8021Q))
+				return -EOPNOTSUPP;
+
+			data.vlan_in = match.key->vlan_id;
+		}
+		break;
+	case FLOW_DISSECTOR_KEY_IPV4_ADDRS:
+		offload_type = PPE_PKT_TYPE_IPV4_HNAPT;
+		break;
+	case FLOW_DISSECTOR_KEY_IPV6_ADDRS:
+		offload_type = PPE_PKT_TYPE_IPV6_ROUTE_5T;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	flow_action_for_each(i, act, &rule->action) {
+		switch (act->id) {
+		case FLOW_ACTION_MANGLE:
+			if (offload_type == PPE_PKT_TYPE_BRIDGE)
+				return -EOPNOTSUPP;
+
+			if (act->mangle.htype == FLOW_ACT_MANGLE_HDR_TYPE_ETH)
+				airoha_ppe_flow_mangle_eth(act, &data.eth);
+			break;
+		case FLOW_ACTION_REDIRECT:
+			odev = act->dev;
+			break;
+		case FLOW_ACTION_CSUM:
+			break;
+		case FLOW_ACTION_VLAN_PUSH:
+			if (data.vlan.num == 1 ||
+			    act->vlan.proto != htons(ETH_P_8021Q))
+				return -EOPNOTSUPP;
+
+			data.vlan.id = act->vlan.vid;
+			data.vlan.proto = act->vlan.proto;
+			data.vlan.num++;
+			break;
+		case FLOW_ACTION_VLAN_POP:
+			break;
+		case FLOW_ACTION_PPPOE_PUSH:
+			if (data.pppoe.num == 1)
+				return -EOPNOTSUPP;
+
+			data.pppoe.sid = act->pppoe.sid;
+			data.pppoe.num++;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+	}
+
+	if (!is_valid_ether_addr(data.eth.h_source) ||
+	    !is_valid_ether_addr(data.eth.h_dest))
+		return -EINVAL;
+
+	err = airoha_ppe_foe_entry_prepare(&hwe, odev, offload_type, l4proto,
+					   data.eth.h_source, data.eth.h_dest);
+	if (err)
+		return err;
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
+		struct flow_match_ports ports;
+
+		if (offload_type == PPE_PKT_TYPE_BRIDGE)
+			return -EOPNOTSUPP;
+
+		flow_rule_match_ports(rule, &ports);
+		data.src_port = ports.key->src;
+		data.dst_port = ports.key->dst;
+	} else if (offload_type != PPE_PKT_TYPE_BRIDGE) {
+		return -EOPNOTSUPP;
+	}
+
+	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
+		struct flow_match_ipv4_addrs addrs;
+
+		flow_rule_match_ipv4_addrs(rule, &addrs);
+		data.v4.src_addr = addrs.key->src;
+		data.v4.dst_addr = addrs.key->dst;
+		airoha_ppe_foe_entry_set_ipv4_tuple(&hwe, &data, false);
+	}
+
+	if (addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS) {
+		struct flow_match_ipv6_addrs addrs;
+
+		flow_rule_match_ipv6_addrs(rule, &addrs);
+
+		data.v6.src_addr = addrs.key->src;
+		data.v6.dst_addr = addrs.key->dst;
+		airoha_ppe_foe_entry_set_ipv6_tuple(&hwe, &data);
+	}
+
+	flow_action_for_each(i, act, &rule->action) {
+		if (act->id != FLOW_ACTION_MANGLE)
+			continue;
+
+		if (offload_type == PPE_PKT_TYPE_BRIDGE)
+			return -EOPNOTSUPP;
+
+		switch (act->mangle.htype) {
+		case FLOW_ACT_MANGLE_HDR_TYPE_TCP:
+		case FLOW_ACT_MANGLE_HDR_TYPE_UDP:
+			err = airoha_ppe_flow_mangle_ports(act, &data);
+			break;
+		case FLOW_ACT_MANGLE_HDR_TYPE_IP4:
+			err = airoha_ppe_flow_mangle_ipv4(act, &data);
+			break;
+		case FLOW_ACT_MANGLE_HDR_TYPE_ETH:
+			/* handled earlier */
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+		if (err)
+			return err;
+	}
+
+	if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
+		err = airoha_ppe_foe_entry_set_ipv4_tuple(&hwe, &data, true);
+		if (err)
+			return err;
+	}
+
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+	if (!e)
+		return -ENOMEM;
+
+	e->cookie = f->cookie;
+	memcpy(&e->data, &hwe, sizeof(e->data));
+
+	err = airoha_ppe_foe_flow_commit_entry(eth->ppe, e);
+	if (err)
+		goto free_entry;
+
+	err = rhashtable_insert_fast(&eth->flow_table, &e->node,
+				     airoha_flow_table_params);
+	if (err < 0)
+		goto remove_foe_entry;
+
+	return 0;
+
+remove_foe_entry:
+	airoha_ppe_foe_flow_remove_entry(eth->ppe, e);
+free_entry:
+	kfree(e);
+
+	return err;
+}
+
+static int airoha_ppe_flow_offload_destroy(struct airoha_gdm_port *port,
+					   struct flow_cls_offload *f)
+{
+	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_flow_table_entry *e;
+
+	e = rhashtable_lookup(&eth->flow_table, &f->cookie,
+			      airoha_flow_table_params);
+	if (!e)
+		return -ENOENT;
+
+	airoha_ppe_foe_flow_remove_entry(eth->ppe, e);
+	rhashtable_remove_fast(&eth->flow_table, &e->node,
+			       airoha_flow_table_params);
+	kfree(e);
+
+	return 0;
+}
+
+static int airoha_ppe_flow_offload_cmd(struct airoha_gdm_port *port,
+				       struct flow_cls_offload *f)
+{
+	int err = -EOPNOTSUPP;
+
+	mutex_lock(&flow_offload_mutex);
+
+	switch (f->command) {
+	case FLOW_CLS_REPLACE:
+		err = airoha_ppe_flow_offload_replace(port, f);
+		break;
+	case FLOW_CLS_DESTROY:
+		err = airoha_ppe_flow_offload_destroy(port, f);
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&flow_offload_mutex);
+
+	return err;
+}
+
+int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
+				 void *cb_priv)
+{
+	struct flow_cls_offload *cls = type_data;
+	struct net_device *dev = cb_priv;
+	struct airoha_gdm_port *port = netdev_priv(dev);
+
+	if (!tc_can_offload(dev) || type != TC_SETUP_CLSFLOWER)
+		return -EOPNOTSUPP;
+
+	if (!port->qdma->eth->npu)
+		return -EOPNOTSUPP;
+
+	return airoha_ppe_flow_offload_cmd(port, cls);
+}
+
+void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash)
+{
+	u16 now, diff;
+
+	if (hash > PPE_HASH_MASK)
+		return;
+
+	now = (u16)jiffies;
+	diff = now - ppe->foe_check_time[hash];
+	if (diff < HZ / 10)
+		return;
+
+	ppe->foe_check_time[hash] = now;
+	airoha_ppe_foe_insert_entry(ppe, hash);
+}
+
 static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 {
 	u32 sram_tb_size, sram_num_entries, dram_num_entries;
@@ -107,33 +771,47 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	ppe->eth = eth;
 	eth->ppe = ppe;
 
+	ppe->foe_flow = devm_kzalloc(eth->dev,
+				     PPE_NUM_ENTRIES * sizeof(*ppe->foe_flow),
+				     GFP_KERNEL);
+	if (!ppe->foe_flow)
+		return -ENOMEM;
+
+	err = rhashtable_init(&eth->flow_table, &airoha_flow_table_params);
+	if (err)
+		return err;
+
 	npu = airoha_npu_init(eth);
-	if (IS_ERR(npu))
-		return PTR_ERR(npu);
+	if (IS_ERR(npu)) {
+		err = PTR_ERR(npu);
+		goto error_destroy_flow_table;
+	}
 
 	eth->npu = npu;
 	err = airoha_npu_ppe_init(npu);
 	if (err)
-		goto error;
+		goto error_npu_deinit;
 
 	airoha_ppe_hw_init(ppe);
 	err = airoha_npu_flush_ppe_sram_entries(npu, ppe);
 	if (err)
-		goto error;
+		goto error_npu_deinit;
 
 	return 0;
 
-error:
+error_npu_deinit:
 	airoha_npu_deinit(npu);
 	eth->npu = NULL;
+error_destroy_flow_table:
+	rhashtable_destroy(&eth->flow_table);
 
 	return err;
 }
-
 void airoha_ppe_deinit(struct airoha_eth *eth)
 {
 	if (eth->npu) {
 		airoha_npu_ppe_deinit(eth->npu);
 		airoha_npu_deinit(eth->npu);
 	}
+	rhashtable_destroy(&eth->flow_table);
 }

-- 
2.48.1


