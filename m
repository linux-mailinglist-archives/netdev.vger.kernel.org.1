Return-Path: <netdev+bounces-164089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF19A2C8DD
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10B07A4E05
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5A199E9A;
	Fri,  7 Feb 2025 16:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT2B/Jz9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4E18DB2F;
	Fri,  7 Feb 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945647; cv=none; b=OWeEGwE3SK34n4E9AeaUZawC/EEI5A5UHkkys9ZPcPVPBms+WCvF6lu8DL31KWInhyGccssLqgx70Cu6AetklQZBTHCvKS3NPnjlbCslOy6/3ND4+nMxlJ6jU5ZfBqmUB0hkcGctIeHAUsYs2EBQC2DoJbkYwzrdZCZEXs8xzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945647; c=relaxed/simple;
	bh=Jx19gArTxLeP4or9st5PQJawzZEi9IZivLppm8OH6b8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGc2zkmg9SkGuP85eTzT3B+zJkUvDXSZP7UWssy5x8HfboWtJVi4pHwPhWjpdNenb9r5S4letwSSZtm9Mu8XnTYK9k9Lhhztl5+JiOPqm4KZW/UGYOXDo+6mvAvHzXZM49V6K1doO5n68oVIdx1DI0kxi58ntFVwy8UlUI8e/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT2B/Jz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF44C4CED1;
	Fri,  7 Feb 2025 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738945646;
	bh=Jx19gArTxLeP4or9st5PQJawzZEi9IZivLppm8OH6b8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AT2B/Jz932+Isd6jCRXxXLVtt7H4awUBN5bM6XNhxffelBF10JSppRIis6advy4N7
	 n50C00v+DAvAtbk8C3QQge7fqBnLhBMNxZA8S5DjxKRhLu9gmx5JxWuy3cgPHSzBL9
	 4D+5q5aGXzRT5u6H1i2duNiGEwJ+QdbUnXQko+Nha9BbklJcMqQtynWChx7hHbq5Rh
	 /xJDlmun6MRFFIxtqdopK/sriJHjP9mkd9q35gF9L9ivmITubhi+UH9lg80Pn3d0Lw
	 5kLrHp1xOa7JKcncVtNJoOtYxQ9CZU0HbiYLzqg3IJKVVaxLNX0+JhQDDDnhPKwtuo
	 4nw/iH+TePGrQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 07 Feb 2025 17:26:30 +0100
Subject: [PATCH net-next v2 15/15] net: airoha: Introduce PPE debugfs
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-airoha-en7581-flowtable-offload-v2-15-3a2239692a67@kernel.org>
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

Similar to PPE support for Mediatek devices, introduce PPE debugfs
in order to dump binded and unbinded flows.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/Makefile             |   1 +
 drivers/net/ethernet/airoha/airoha_eth.h         |  12 ++
 drivers/net/ethernet/airoha/airoha_ppe.c         |   5 +
 drivers/net/ethernet/airoha/airoha_ppe_debugfs.c | 175 +++++++++++++++++++++++
 4 files changed, 193 insertions(+)

diff --git a/drivers/net/ethernet/airoha/Makefile b/drivers/net/ethernet/airoha/Makefile
index 50028cfc3e3e04efbdd353b1bd65f46b488637d8..e5321effdbeaeaf7c4ad3c6df9d0261fe12fdd12 100644
--- a/drivers/net/ethernet/airoha/Makefile
+++ b/drivers/net/ethernet/airoha/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_NET_AIROHA) += airoha-eth.o
 airoha-eth-y := airoha_eth.o airoha_ppe.o
+airoha-eth-$(CONFIG_DEBUG_FS) += airoha_ppe_debugfs.o
 airoha-eth-$(CONFIG_NET_AIROHA_NPU) += airoha_npu.o
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 464d92ad5371a137681b4128cc49a7c1a91ddd19..87d2a2a928eaa6680ce3a256eea973c6ce324f13 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -7,6 +7,7 @@
 #ifndef AIROHA_ETH_H
 #define AIROHA_ETH_H
 
+#include <linux/debugfs.h>
 #include <linux/etherdevice.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -502,6 +503,8 @@ struct airoha_ppe {
 
 	struct hlist_head *foe_flow;
 	u16 foe_check_time[PPE_NUM_ENTRIES];
+
+	struct dentry *debugfs_dir;
 };
 
 struct airoha_eth {
@@ -611,4 +614,13 @@ static inline int airoha_npu_foe_commit_entry(struct airoha_ppe *ppe,
 }
 #endif /* CONFIG_NET_AIROHA_NPU */
 
+#if CONFIG_DEBUG_FS
+int airoha_ppe_debugfs_init(struct airoha_ppe *ppe);
+#else
+static inline int airoha_ppe_debugfs_init(struct airoha_ppe *ppe)
+{
+	return 0;
+}
+#endif
+
 #endif /* AIROHA_ETH_H */
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 699330e28b6328f0a3ea43253143dedab48994ea..5c32045dc74d5d4f04ce5793428ce7f28e5a9a08 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -798,6 +798,10 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	if (err)
 		goto error_npu_deinit;
 
+	err = airoha_ppe_debugfs_init(ppe);
+	if (err)
+		goto error_npu_deinit;
+
 	return 0;
 
 error_npu_deinit:
@@ -815,4 +819,5 @@ void airoha_ppe_deinit(struct airoha_eth *eth)
 		airoha_npu_deinit(eth->npu);
 	}
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


