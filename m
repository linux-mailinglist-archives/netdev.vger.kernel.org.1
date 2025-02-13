Return-Path: <netdev+bounces-166097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C3A3480F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923CF1893B57
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E262222C8;
	Thu, 13 Feb 2025 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlTmOBSF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB7A1946C7;
	Thu, 13 Feb 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460930; cv=none; b=lEthUR4+Om03AHrmUSN6MtOS6hoCyhIpHYjQ3npABO7+aNqK0SNkYsBEAhJTWUNP98X5YuET2eyqAJXMz3QEqo9tYdZ7svAY2Lmpxg4KH5ry1rcG2IBQSd6/1dM4ItvU8uoqttfE2b/0fROXdJ7B9Yx7jnLg55FX6uhiccJIa7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460930; c=relaxed/simple;
	bh=1Rb+4jmHgXEuS60iJKLLggv5HEm6LdCrBtgbYBGoEos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnRYnRKheECpO/hogjg4WpedX+36Jxm0bpU8dIHSJ9WFl05c6syEP4SX2SXAHbcWECA4Bks6D05w1Z2PofQnGPwc+nDuUax5KGOhej2OaQo8vtmAZks5JAf/c0HucxWq/5rMdjuno+dDxE8SQCA+Jfyi3RKrvvgq9R92EASGQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlTmOBSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAF9C4CED1;
	Thu, 13 Feb 2025 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739460929;
	bh=1Rb+4jmHgXEuS60iJKLLggv5HEm6LdCrBtgbYBGoEos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rlTmOBSFo+RcrfcO8/EmCHfzZBHverrEfQsyN06895sn8vNq1ESdLEar9wl6ALNMa
	 WCLJbzIuOrrVP/QY/7sJ+nBoUv4LTA0AClk6BFxKU80hsL2KO85UAzK8FeFQCa3BVX
	 TNSDwiFbiqpC8feFfSy087Yyt9yAkQk1Z2lD96tulJWD9vJvmkPA0bQUnbxoUfRi8L
	 JQu1hCbfiyzSL/mtwgvEryIa7Yxk7a0/lAD8VNwZixijgPta+K14y89bv/BIB6GapT
	 W0sSwtfYuDPSaNTLmEwl/HKyqlnsAZ3HfoKuYEwmOJwCGPwpX0ZnIN5eFPLLG1Sbos
	 /uk9x633BJLtA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 13 Feb 2025 16:34:35 +0100
Subject: [PATCH net-next v4 16/16] net: airoha: Introduce PPE debugfs
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-airoha-en7581-flowtable-offload-v4-16-b69ca16d74db@kernel.org>
References: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
In-Reply-To: <20250213-airoha-en7581-flowtable-offload-v4-0-b69ca16d74db@kernel.org>
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

Similar to PPE support for Mediatek devices, introduce PPE debugfs
in order to dump binded and unbinded flows.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/Makefile             |   1 +
 drivers/net/ethernet/airoha/airoha_eth.h         |  14 ++
 drivers/net/ethernet/airoha/airoha_ppe.c         |  17 ++-
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c | 175 +++++++++++++++++++++++
 4 files changed, 203 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/Makefile b/drivers/net/ethernet/airoha/Makefile
index 6deff2f16229a7638be0737caa06282ba63183a4..94468053e34bef8fd155760e13745a8663592f4a 100644
--- a/drivers/net/ethernet/airoha/Makefile
+++ b/drivers/net/ethernet/airoha/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_NET_AIROHA) += airoha-eth.o
 airoha-eth-y := airoha_eth.o airoha_ppe.o
+airoha-eth-$(CONFIG_DEBUG_FS) += airoha_ppe_debugfs.o
 obj-$(CONFIG_NET_AIROHA_NPU) += airoha_npu.o
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 064941348bd91f1115082bf5e7734f34007953f8..18b5fed7ff286b813b260fae121892f44eb1cf8c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -7,6 +7,7 @@
 #ifndef AIROHA_ETH_H
 #define AIROHA_ETH_H
 
+#include <linux/debugfs.h>
 #include <linux/etherdevice.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -482,6 +483,8 @@ struct airoha_ppe {
 
 	struct hlist_head *foe_flow;
 	u16 foe_check_time[PPE_NUM_ENTRIES];
+
+	struct dentry *debugfs_dir;
 };
 
 struct airoha_eth {
@@ -535,5 +538,16 @@ int airoha_ppe_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
 				 void *cb_priv);
 int airoha_ppe_init(struct airoha_eth *eth);
 void airoha_ppe_deinit(struct airoha_eth *eth);
+struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
+						  u32 hash);
+
+#if CONFIG_DEBUG_FS
+int airoha_ppe_debugfs_init(struct airoha_ppe *ppe);
+#else
+static inline int airoha_ppe_debugfs_init(struct airoha_ppe *ppe)
+{
+	return 0;
+}
+#endif
 
 #endif /* AIROHA_ETH_H */
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 71761a0a4b0e93587151e2eae55c090992ce85a2..f28ae8735639959a97b99358cfc7e44c1bcac11d 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -377,8 +377,8 @@ static u32 airoha_ppe_foe_get_entry_hash(struct airoha_foe_entry *hwe)
 	return hash;
 }
 
-static struct airoha_foe_entry *
-airoha_ppe_foe_get_entry(struct airoha_ppe *ppe, u32 hash)
+struct airoha_foe_entry *airoha_ppe_foe_get_entry(struct airoha_ppe *ppe,
+						  u32 hash)
 {
 	if (hash < PPE_SRAM_NUM_ENTRIES) {
 		u32 *hwe = ppe->foe + hash * sizeof(struct airoha_foe_entry);
@@ -845,7 +845,7 @@ void airoha_ppe_check_skb(struct airoha_ppe *ppe, u16 hash)
 int airoha_ppe_init(struct airoha_eth *eth)
 {
 	struct airoha_ppe *ppe;
-	int foe_size;
+	int foe_size, err;
 
 	ppe = devm_kzalloc(eth->dev, sizeof(*ppe), GFP_KERNEL);
 	if (!ppe)
@@ -866,7 +866,15 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	if (!ppe->foe_flow)
 		return -ENOMEM;
 
-	return rhashtable_init(&eth->flow_table, &airoha_flow_table_params);
+	err = rhashtable_init(&eth->flow_table, &airoha_flow_table_params);
+	if (err)
+		return err;
+
+	err = airoha_ppe_debugfs_init(ppe);
+	if (err)
+		rhashtable_destroy(&eth->flow_table);
+
+	return err;
 }
 
 void airoha_ppe_deinit(struct airoha_eth *eth)
@@ -882,4 +890,5 @@ void airoha_ppe_deinit(struct airoha_eth *eth)
 	rcu_read_unlock();
 
 	rhashtable_destroy(&eth->flow_table);
+	debugfs_remove(eth->ppe->debugfs_dir);
 }
diff --git a/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..f79788458903c93ca73d774edaca97f1e08f92a7
--- /dev/null
+++ b/drivers/net/ethernet/airoha/airoha_ppe_debugfs.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 AIROHA Inc
+ * Author: Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include "airoha_eth.h"
+
+static void airoha_debugfs_ppe_print_tuple(struct seq_file *m,
+					   void *src_addr, void *dest_addr,
+					   u16 *src_port, u16 *dest_port,
+					   bool ipv6)
+{
+	__be32 n_addr[IPV6_ADDR_WORDS];
+
+	if (ipv6) {
+		ipv6_addr_cpu_to_be32(n_addr, src_addr);
+		seq_printf(m, "%pI6", n_addr);
+	} else {
+		seq_printf(m, "%pI4h", src_addr);
+	}
+	if (src_port)
+		seq_printf(m, ":%d", *src_port);
+
+	seq_puts(m, "->");
+
+	if (ipv6) {
+		ipv6_addr_cpu_to_be32(n_addr, dest_addr);
+		seq_printf(m, "%pI6", n_addr);
+	} else {
+		seq_printf(m, "%pI4h", dest_addr);
+	}
+	if (dest_port)
+		seq_printf(m, ":%d", *dest_port);
+}
+
+static int airoha_ppe_debugfs_foe_show(struct seq_file *m, void *private,
+				       bool bind)
+{
+	static const char *const ppe_type_str[] = {
+		[PPE_PKT_TYPE_IPV4_HNAPT] = "IPv4 5T",
+		[PPE_PKT_TYPE_IPV4_ROUTE] = "IPv4 3T",
+		[PPE_PKT_TYPE_BRIDGE] = "L2B",
+		[PPE_PKT_TYPE_IPV4_DSLITE] = "DS-LITE",
+		[PPE_PKT_TYPE_IPV6_ROUTE_3T] = "IPv6 3T",
+		[PPE_PKT_TYPE_IPV6_ROUTE_5T] = "IPv6 5T",
+		[PPE_PKT_TYPE_IPV6_6RD] = "6RD",
+	};
+	static const char *const ppe_state_str[] = {
+		[AIROHA_FOE_STATE_INVALID] = "INV",
+		[AIROHA_FOE_STATE_UNBIND] = "UNB",
+		[AIROHA_FOE_STATE_BIND] = "BND",
+		[AIROHA_FOE_STATE_FIN] = "FIN",
+	};
+	struct airoha_ppe *ppe = m->private;
+	int i;
+
+	for (i = 0; i < PPE_NUM_ENTRIES; i++) {
+		const char *state_str, *type_str = "UNKNOWN";
+		u16 *src_port = NULL, *dest_port = NULL;
+		struct airoha_foe_mac_info_common *l2;
+		unsigned char h_source[ETH_ALEN] = {};
+		unsigned char h_dest[ETH_ALEN];
+		struct airoha_foe_entry *hwe;
+		u32 type, state, ib2, data;
+		void *src_addr, *dest_addr;
+		bool ipv6 = false;
+
+		hwe = airoha_ppe_foe_get_entry(ppe, i);
+		if (!hwe)
+			continue;
+
+		state = FIELD_GET(AIROHA_FOE_IB1_STATE, hwe->ib1);
+		if (!state)
+			continue;
+
+		if (bind && state != AIROHA_FOE_STATE_BIND)
+			continue;
+
+		state_str = ppe_state_str[state % ARRAY_SIZE(ppe_state_str)];
+		type = FIELD_GET(AIROHA_FOE_IB1_PACKET_TYPE, hwe->ib1);
+		if (type < ARRAY_SIZE(ppe_type_str) && ppe_type_str[type])
+			type_str = ppe_type_str[type];
+
+		seq_printf(m, "%05x %s %7s", i, state_str, type_str);
+
+		switch (type) {
+		case PPE_PKT_TYPE_IPV4_HNAPT:
+		case PPE_PKT_TYPE_IPV4_DSLITE:
+			src_port = &hwe->ipv4.orig_tuple.src_port;
+			dest_port = &hwe->ipv4.orig_tuple.dest_port;
+			fallthrough;
+		case PPE_PKT_TYPE_IPV4_ROUTE:
+			src_addr = &hwe->ipv4.orig_tuple.src_ip;
+			dest_addr = &hwe->ipv4.orig_tuple.dest_ip;
+			break;
+		case PPE_PKT_TYPE_IPV6_ROUTE_5T:
+			src_port = &hwe->ipv6.src_port;
+			dest_port = &hwe->ipv6.dest_port;
+			fallthrough;
+		case PPE_PKT_TYPE_IPV6_ROUTE_3T:
+		case PPE_PKT_TYPE_IPV6_6RD:
+			src_addr = &hwe->ipv6.src_ip;
+			dest_addr = &hwe->ipv6.dest_ip;
+			ipv6 = true;
+			break;
+		}
+
+		seq_puts(m, " orig=");
+		airoha_debugfs_ppe_print_tuple(m, src_addr, dest_addr,
+					       src_port, dest_port, ipv6);
+
+		switch (type) {
+		case PPE_PKT_TYPE_IPV4_HNAPT:
+		case PPE_PKT_TYPE_IPV4_DSLITE:
+			src_port = &hwe->ipv4.new_tuple.src_port;
+			dest_port = &hwe->ipv4.new_tuple.dest_port;
+			fallthrough;
+		case PPE_PKT_TYPE_IPV4_ROUTE:
+			src_addr = &hwe->ipv4.new_tuple.src_ip;
+			dest_addr = &hwe->ipv4.new_tuple.dest_ip;
+			seq_puts(m, " new=");
+			airoha_debugfs_ppe_print_tuple(m, src_addr, dest_addr,
+						       src_port, dest_port,
+						       ipv6);
+			break;
+		}
+
+		if (type >= PPE_PKT_TYPE_IPV6_ROUTE_3T) {
+			data = hwe->ipv6.data;
+			ib2 = hwe->ipv6.ib2;
+			l2 = &hwe->ipv6.l2;
+		} else {
+			data = hwe->ipv4.data;
+			ib2 = hwe->ipv4.ib2;
+			l2 = &hwe->ipv4.l2.common;
+			*((__be16 *)&h_source[4]) =
+				cpu_to_be16(hwe->ipv4.l2.src_mac_lo);
+		}
+
+		*((__be32 *)h_dest) = cpu_to_be32(l2->dest_mac_hi);
+		*((__be16 *)&h_dest[4]) = cpu_to_be16(l2->dest_mac_lo);
+		*((__be32 *)h_source) = cpu_to_be32(l2->src_mac_hi);
+
+		seq_printf(m, " eth=%pM->%pM etype=%04x data=%08x"
+			      " vlan=%d,%d ib1=%08x ib2=%08x\n",
+			   h_source, h_dest, l2->etype, data,
+			   l2->vlan1, l2->vlan2, hwe->ib1, ib2);
+	}
+
+	return 0;
+}
+
+static int airoha_ppe_debugfs_foe_all_show(struct seq_file *m, void *private)
+{
+	return airoha_ppe_debugfs_foe_show(m, private, false);
+}
+DEFINE_SHOW_ATTRIBUTE(airoha_ppe_debugfs_foe_all);
+
+static int airoha_ppe_debugfs_foe_bind_show(struct seq_file *m, void *private)
+{
+	return airoha_ppe_debugfs_foe_show(m, private, true);
+}
+DEFINE_SHOW_ATTRIBUTE(airoha_ppe_debugfs_foe_bind);
+
+int airoha_ppe_debugfs_init(struct airoha_ppe *ppe)
+{
+	ppe->debugfs_dir = debugfs_create_dir("ppe", NULL);
+	debugfs_create_file("entries", 0444, ppe->debugfs_dir, ppe,
+			    &airoha_ppe_debugfs_foe_all_fops);
+	debugfs_create_file("bind", 0444, ppe->debugfs_dir, ppe,
+			    &airoha_ppe_debugfs_foe_bind_fops);
+
+	return 0;
+}

-- 
2.48.1


