Return-Path: <netdev+bounces-229488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981EBDCDCF
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6FDC3B237D
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99460313E17;
	Wed, 15 Oct 2025 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLSYsi5z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713491CAA7B;
	Wed, 15 Oct 2025 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512539; cv=none; b=aMgAmHpwRON4oWmPkh4y6MLySjKfgi/QZyzaxWodK4dj1PgDV+j9C/sTmXpBG2ujt3+BOcGpqsyZzLmZ90dyWAGq4pLV/CWG8TmXt4qjPGdqVrlVoGmAvCoaIVKFOOhLyogI0CPoFM07rzO7K93xbr/97nf6kw29kvf4mykZNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512539; c=relaxed/simple;
	bh=0qqJSSdFbxw9gl1NsDAn3AH1f6qSlgwoyC5PH+2KaWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HfzXhMx4rI/J3ePS3movMuz8O5UWaph0LVtfIM6jjTCOddXU7ijWTKvaUTPGpmyY5XFMApezV0vBbNM7wBWsLpsk+aTE50YyjS3WFhbg8w4DM9KIdBS9w19dB3gVpM/BV6K4Cr1VybXYcU39JTocosAvrQQjbvoJvCOj6ZLjnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLSYsi5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89BCC116B1;
	Wed, 15 Oct 2025 07:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512539;
	bh=0qqJSSdFbxw9gl1NsDAn3AH1f6qSlgwoyC5PH+2KaWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hLSYsi5zVHP+zHOQGc/b+6nFtASWcSQOzySPoC9c0YA9I98CRP1IC6xk/DSK/0y5d
	 PUv6UG+L1E8DXSGYaSNSbsuCTDupG9J2CrXYwK+11cV/TyrR36tpuy7lBYuGkScMyY
	 jqE9x7yRJaJxLB75LliEfW01HxhZaaTFkQvc0UaxJqy/8olghRZDN9Qcze2GrHDuTQ
	 AlWgHK53aGvbCqTUEI8BtbEm6ODHz23EZIMDbFOLK//CB/PnFTDXlxqv0ybnTnxr6+
	 ipukC0NpQfkF8xnB5LUPo5QXDZt0J0r7E8UG7Jt8s2SRkgUM2/VqUHBKeGRWenha5M
	 eoWFq8Pe1DQHg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Oct 2025 09:15:03 +0200
Subject: [PATCH net-next 03/12] net: airoha: Add
 airoha_ppe_get_num_stats_entries() and
 airoha_ppe_get_num_total_stats_entries()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-an7583-eth-support-v1-3-064855f05923@kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
In-Reply-To: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce airoha_ppe_get_num_stats_entries and
airoha_ppe_get_num_total_stats_entries routines in order to make the
code more readable controlling if CONFIG_NET_AIROHA_FLOW_STATS is
enabled or disabled.
Modify airoha_ppe_foe_get_flow_stats_index routine signature relying on
airoha_ppe_get_num_total_stats_entries().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.h |  10 +--
 drivers/net/ethernet/airoha/airoha_ppe.c | 103 +++++++++++++++++++++++++------
 2 files changed, 86 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 4330b672d99e1e190efa5ad75d13fb35e77d070e..1f7e34a5f457ca2200e9c81dd05dc03cd7c5eb77 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -50,15 +50,9 @@
 
 #define PPE_NUM				2
 #define PPE1_SRAM_NUM_ENTRIES		(8 * 1024)
-#define PPE_SRAM_NUM_ENTRIES		(2 * PPE1_SRAM_NUM_ENTRIES)
-#ifdef CONFIG_NET_AIROHA_FLOW_STATS
+#define PPE_SRAM_NUM_ENTRIES		(PPE_NUM * PPE1_SRAM_NUM_ENTRIES)
 #define PPE1_STATS_NUM_ENTRIES		(4 * 1024)
-#else
-#define PPE1_STATS_NUM_ENTRIES		0
-#endif /* CONFIG_NET_AIROHA_FLOW_STATS */
-#define PPE_STATS_NUM_ENTRIES		(2 * PPE1_STATS_NUM_ENTRIES)
-#define PPE1_SRAM_NUM_DATA_ENTRIES	(PPE1_SRAM_NUM_ENTRIES - PPE1_STATS_NUM_ENTRIES)
-#define PPE_SRAM_NUM_DATA_ENTRIES	(2 * PPE1_SRAM_NUM_DATA_ENTRIES)
+#define PPE_STATS_NUM_ENTRIES		(PPE_NUM * PPE1_STATS_NUM_ENTRIES)
 #define PPE_DRAM_NUM_ENTRIES		(16 * 1024)
 #define PPE_NUM_ENTRIES			(PPE_SRAM_NUM_ENTRIES + PPE_DRAM_NUM_ENTRIES)
 #define PPE_HASH_MASK			(PPE_NUM_ENTRIES - 1)
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 8d1dceadce0becb2b1ce656d64ab77bd3c2f914a..303d31e1da4b723023ee0cc1ca5f6038c16966cd 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -32,6 +32,30 @@ static const struct rhashtable_params airoha_l2_flow_table_params = {
 	.automatic_shrinking = true,
 };
 
+static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe,
+					    u32 *num_stats)
+{
+#ifdef CONFIG_NET_AIROHA_FLOW_STATS
+	*num_stats = PPE1_STATS_NUM_ENTRIES;
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif /* CONFIG_NET_AIROHA_FLOW_STATS */
+}
+
+static int airoha_ppe_get_total_num_stats_entries(struct airoha_ppe *ppe,
+						  u32 *num_stats)
+{
+	int err;
+
+	err = airoha_ppe_get_num_stats_entries(ppe, num_stats);
+	if (err)
+		return err;
+
+	*num_stats = *num_stats * PPE_NUM;
+	return 0;
+}
+
 static bool airoha_ppe2_is_enabled(struct airoha_eth *eth)
 {
 	return airoha_fe_rr(eth, REG_PPE_GLO_CFG(1)) & PPE_GLO_CFG_EN_MASK;
@@ -48,6 +72,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 {
 	u32 sram_tb_size, sram_num_entries, dram_num_entries;
 	struct airoha_eth *eth = ppe->eth;
+	u32 sram_num_stats_entries;
 	int i;
 
 	sram_tb_size = PPE_SRAM_NUM_ENTRIES * sizeof(struct airoha_foe_entry);
@@ -103,8 +128,12 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 	}
 
 	if (airoha_ppe2_is_enabled(eth)) {
-		sram_num_entries =
-			PPE_RAM_NUM_ENTRIES_SHIFT(PPE1_SRAM_NUM_DATA_ENTRIES);
+		sram_num_entries = PPE1_SRAM_NUM_ENTRIES;
+		if (!airoha_ppe_get_num_stats_entries(ppe,
+						      &sram_num_stats_entries))
+			sram_num_entries -= sram_num_stats_entries;
+		sram_num_entries = PPE_RAM_NUM_ENTRIES_SHIFT(sram_num_entries);
+
 		airoha_fe_rmw(eth, REG_PPE_TB_CFG(0),
 			      PPE_SRAM_TB_NUM_ENTRY_MASK |
 			      PPE_DRAM_TB_NUM_ENTRY_MASK,
@@ -120,8 +149,12 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			      FIELD_PREP(PPE_DRAM_TB_NUM_ENTRY_MASK,
 					 dram_num_entries));
 	} else {
-		sram_num_entries =
-			PPE_RAM_NUM_ENTRIES_SHIFT(PPE_SRAM_NUM_DATA_ENTRIES);
+		sram_num_entries = PPE_SRAM_NUM_ENTRIES;
+		if (!airoha_ppe_get_total_num_stats_entries(ppe,
+							    &sram_num_stats_entries))
+			sram_num_entries -= sram_num_stats_entries;
+		sram_num_entries = PPE_RAM_NUM_ENTRIES_SHIFT(sram_num_entries);
+
 		airoha_fe_rmw(eth, REG_PPE_TB_CFG(0),
 			      PPE_SRAM_TB_NUM_ENTRY_MASK |
 			      PPE_DRAM_TB_NUM_ENTRY_MASK,
@@ -480,13 +513,23 @@ static u32 airoha_ppe_foe_get_entry_hash(struct airoha_foe_entry *hwe)
 	return hash;
 }
 
-static u32 airoha_ppe_foe_get_flow_stats_index(struct airoha_ppe *ppe, u32 hash)
+static int airoha_ppe_foe_get_flow_stats_index(struct airoha_ppe *ppe,
+					       u32 hash, u32 *index)
 {
-	if (!airoha_ppe2_is_enabled(ppe->eth))
-		return hash;
+	u32 ppe_num_stats_entries;
+	int err;
+
+	err = airoha_ppe_get_total_num_stats_entries(ppe,
+						     &ppe_num_stats_entries);
+	if (err)
+		return err;
 
-	return hash >= PPE_STATS_NUM_ENTRIES ? hash - PPE1_STATS_NUM_ENTRIES
-					     : hash;
+	*index = hash;
+	if (airoha_ppe2_is_enabled(ppe->eth) &&
+	    hash >= ppe_num_stats_entries)
+		*index = *index - PPE_STATS_NUM_ENTRIES;
+
+	return 0;
 }
 
 static void airoha_ppe_foe_flow_stat_entry_reset(struct airoha_ppe *ppe,
@@ -500,9 +543,14 @@ static void airoha_ppe_foe_flow_stat_entry_reset(struct airoha_ppe *ppe,
 static void airoha_ppe_foe_flow_stats_reset(struct airoha_ppe *ppe,
 					    struct airoha_npu *npu)
 {
+	u32 ppe_num_stats_entries;
 	int i;
 
-	for (i = 0; i < PPE_STATS_NUM_ENTRIES; i++)
+	if (airoha_ppe_get_total_num_stats_entries(ppe,
+						   &ppe_num_stats_entries))
+		return;
+
+	for (i = 0; i < ppe_num_stats_entries; i++)
 		airoha_ppe_foe_flow_stat_entry_reset(ppe, npu, i);
 }
 
@@ -511,12 +559,18 @@ static void airoha_ppe_foe_flow_stats_update(struct airoha_ppe *ppe,
 					     struct airoha_foe_entry *hwe,
 					     u32 hash)
 {
+	u32 ppe_num_stats_entries, index, pse_port, val, *data, *ib2, *meter;
 	int type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe->ib1);
-	u32 index, pse_port, val, *data, *ib2, *meter;
 	u8 nbq;
 
-	index = airoha_ppe_foe_get_flow_stats_index(ppe, hash);
-	if (index >= PPE_STATS_NUM_ENTRIES)
+	if (airoha_ppe_get_total_num_stats_entries(ppe,
+						   &ppe_num_stats_entries))
+		return;
+
+	if (airoha_ppe_foe_get_flow_stats_index(ppe, hash, &index))
+		return;
+
+	if (index >= ppe_num_stats_entries)
 		return;
 
 	if (type == PPE_PKT_TYPE_BRIDGE) {
@@ -1158,11 +1212,18 @@ static int airoha_ppe_flow_offload_destroy(struct airoha_eth *eth,
 void airoha_ppe_foe_entry_get_stats(struct airoha_ppe *ppe, u32 hash,
 				    struct airoha_foe_stats64 *stats)
 {
-	u32 index = airoha_ppe_foe_get_flow_stats_index(ppe, hash);
 	struct airoha_eth *eth = ppe->eth;
+	u32 index, ppe_num_stats_entries;
 	struct airoha_npu *npu;
 
-	if (index >= PPE_STATS_NUM_ENTRIES)
+	if (airoha_ppe_get_total_num_stats_entries(ppe,
+						   &ppe_num_stats_entries))
+		return;
+
+	if (airoha_ppe_foe_get_flow_stats_index(ppe, hash, &index))
+		return;
+
+	if (index >= ppe_num_stats_entries)
 		return;
 
 	rcu_read_lock();
@@ -1257,6 +1318,7 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 {
 	struct airoha_npu *npu = airoha_ppe_npu_get(eth);
 	struct airoha_ppe *ppe = eth->ppe;
+	u32 ppe_num_stats_entries;
 	int err;
 
 	if (IS_ERR(npu))
@@ -1266,9 +1328,10 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	if (err)
 		goto error_npu_put;
 
-	if (PPE_STATS_NUM_ENTRIES) {
+	if (!airoha_ppe_get_total_num_stats_entries(ppe,
+						    &ppe_num_stats_entries)) {
 		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
-					      PPE_STATS_NUM_ENTRIES);
+					      ppe_num_stats_entries);
 		if (err)
 			goto error_npu_put;
 	}
@@ -1405,6 +1468,7 @@ EXPORT_SYMBOL_GPL(airoha_ppe_put_dev);
 
 int airoha_ppe_init(struct airoha_eth *eth)
 {
+	u32 ppe_num_stats_entries;
 	struct airoha_ppe *ppe;
 	int foe_size, err;
 
@@ -1431,8 +1495,9 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	if (!ppe->foe_flow)
 		return -ENOMEM;
 
-	foe_size = PPE_STATS_NUM_ENTRIES * sizeof(*ppe->foe_stats);
-	if (foe_size) {
+	if (!airoha_ppe_get_total_num_stats_entries(ppe,
+						    &ppe_num_stats_entries)) {
+		foe_size = ppe_num_stats_entries * sizeof(*ppe->foe_stats);
 		ppe->foe_stats = dmam_alloc_coherent(eth->dev, foe_size,
 						     &ppe->foe_stats_dma,
 						     GFP_KERNEL);

-- 
2.51.0


