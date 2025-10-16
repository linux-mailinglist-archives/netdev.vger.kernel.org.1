Return-Path: <netdev+bounces-229976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86791BE2C73
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D577719C7D65
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A94C1FDE14;
	Thu, 16 Oct 2025 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdBXWFwi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D3E5464F;
	Thu, 16 Oct 2025 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610526; cv=none; b=Go3eTc/+Tw83WIOo0qy8Vg5iSimtjHeKPSpzG04mOt7Bwd0K8kvEfAH/AgJLjXp6JfVKiuK+l4RAAYa8ajD+WVpFENAsPMiwNRUzMHBJg8ERpeNXT95NSFkZKPmx1V0eEr+++HbD5UwXUWGK2rJwPJjRMuqiaE+Dc4PntLP/aFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610526; c=relaxed/simple;
	bh=lDTg+XZzdSUTO5ewJqPNTfRoSjX4DQuSi3gS46csMv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=isr26HtdVvrj+rxdPW8LNEkCo3TBm/ZrqrVU8PfzDXwlE4tel1rjjPU05XuauiJdQltgatkcTc0i2UhRGccbmSInXO28sjTchFLt+BeI8to0cJerUlM8j6H4IJyLUSzDe+dQlrvf0aFLVwsowcwNJfJLcq4IGBjt0gL8xGK5BIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdBXWFwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4581DC4CEF9;
	Thu, 16 Oct 2025 10:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760610525;
	bh=lDTg+XZzdSUTO5ewJqPNTfRoSjX4DQuSi3gS46csMv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DdBXWFwiEcUJFN6IpSaMWgNj6ZCQipKRnwj28UeUSw6oyBDer8fdTJAbqUwKgQigA
	 7rn7GwkgxVO+9+ieJYrLf1hQm9NITNnyHjJwDiHpgUmr53LWDFQ+n56ek2ViVLzWgO
	 kMHt+taahB4aTBFZg8CUqvD4yvw4wlECvpEYsq1T3bFxGEh7nb5KUZAXmAUjZJiFCC
	 1CxQVJ2jj8JDZ3Ow/RYwYyVRGgMy5loCrq7TzRKmZAQ8Q18uUv2HAVL/irIy6ZQGpN
	 GfI+05OUJ4qMLO8HmzMwU4wISZ4fB1evmNoRrzaaO0IE8kWaq0eY25YfcHX/tbQrvM
	 J7ZwQ45EeoqpA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Oct 2025 12:28:17 +0200
Subject: [PATCH net-next v2 03/13] net: airoha: Add
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
Message-Id: <20251016-an7583-eth-support-v2-3-ea6e7e9acbdb@kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
In-Reply-To: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
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
 drivers/net/ethernet/airoha/airoha_ppe.c | 101 ++++++++++++++++++++++++-------
 2 files changed, 81 insertions(+), 30 deletions(-)

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
index 8d1dceadce0becb2b1ce656d64ab77bd3c2f914a..22ecece0e33ef4d7c9b1e2d6c5c9e510e3e0c040 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -32,6 +32,24 @@ static const struct rhashtable_params airoha_l2_flow_table_params = {
 	.automatic_shrinking = true,
 };
 
+static int airoha_ppe_get_num_stats_entries(struct airoha_ppe *ppe)
+{
+	if (!IS_ENABLED(CONFIG_NET_AIROHA_FLOW_STATS))
+		return -EOPNOTSUPP;
+
+	return PPE1_STATS_NUM_ENTRIES;
+}
+
+static int airoha_ppe_get_total_num_stats_entries(struct airoha_ppe *ppe)
+{
+	int num_stats = airoha_ppe_get_num_stats_entries(ppe);
+
+	if (num_stats > 0)
+		num_stats = num_stats * PPE_NUM;
+
+	return num_stats;
+}
+
 static bool airoha_ppe2_is_enabled(struct airoha_eth *eth)
 {
 	return airoha_fe_rr(eth, REG_PPE_GLO_CFG(1)) & PPE_GLO_CFG_EN_MASK;
@@ -48,7 +66,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 {
 	u32 sram_tb_size, sram_num_entries, dram_num_entries;
 	struct airoha_eth *eth = ppe->eth;
-	int i;
+	int i, sram_num_stats_entries;
 
 	sram_tb_size = PPE_SRAM_NUM_ENTRIES * sizeof(struct airoha_foe_entry);
 	dram_num_entries = PPE_RAM_NUM_ENTRIES_SHIFT(PPE_DRAM_NUM_ENTRIES);
@@ -103,8 +121,13 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 	}
 
 	if (airoha_ppe2_is_enabled(eth)) {
-		sram_num_entries =
-			PPE_RAM_NUM_ENTRIES_SHIFT(PPE1_SRAM_NUM_DATA_ENTRIES);
+		sram_num_entries = PPE1_SRAM_NUM_ENTRIES;
+		sram_num_stats_entries =
+			airoha_ppe_get_num_stats_entries(ppe);
+		if (sram_num_stats_entries > 0)
+			sram_num_entries -= sram_num_stats_entries;
+		sram_num_entries = PPE_RAM_NUM_ENTRIES_SHIFT(sram_num_entries);
+
 		airoha_fe_rmw(eth, REG_PPE_TB_CFG(0),
 			      PPE_SRAM_TB_NUM_ENTRY_MASK |
 			      PPE_DRAM_TB_NUM_ENTRY_MASK,
@@ -120,8 +143,13 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 			      FIELD_PREP(PPE_DRAM_TB_NUM_ENTRY_MASK,
 					 dram_num_entries));
 	} else {
-		sram_num_entries =
-			PPE_RAM_NUM_ENTRIES_SHIFT(PPE_SRAM_NUM_DATA_ENTRIES);
+		sram_num_entries = PPE_SRAM_NUM_ENTRIES;
+		sram_num_stats_entries =
+			airoha_ppe_get_total_num_stats_entries(ppe);
+		if (sram_num_stats_entries > 0)
+			sram_num_entries -= sram_num_stats_entries;
+		sram_num_entries = PPE_RAM_NUM_ENTRIES_SHIFT(sram_num_entries);
+
 		airoha_fe_rmw(eth, REG_PPE_TB_CFG(0),
 			      PPE_SRAM_TB_NUM_ENTRY_MASK |
 			      PPE_DRAM_TB_NUM_ENTRY_MASK,
@@ -480,13 +508,21 @@ static u32 airoha_ppe_foe_get_entry_hash(struct airoha_foe_entry *hwe)
 	return hash;
 }
 
-static u32 airoha_ppe_foe_get_flow_stats_index(struct airoha_ppe *ppe, u32 hash)
+static int airoha_ppe_foe_get_flow_stats_index(struct airoha_ppe *ppe,
+					       u32 hash, u32 *index)
 {
-	if (!airoha_ppe2_is_enabled(ppe->eth))
-		return hash;
+	int ppe_num_stats_entries;
+
+	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
+	if (ppe_num_stats_entries < 0)
+		return ppe_num_stats_entries;
 
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
@@ -500,9 +536,13 @@ static void airoha_ppe_foe_flow_stat_entry_reset(struct airoha_ppe *ppe,
 static void airoha_ppe_foe_flow_stats_reset(struct airoha_ppe *ppe,
 					    struct airoha_npu *npu)
 {
-	int i;
+	int i, ppe_num_stats_entries;
+
+	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
+	if (ppe_num_stats_entries < 0)
+		return;
 
-	for (i = 0; i < PPE_STATS_NUM_ENTRIES; i++)
+	for (i = 0; i < ppe_num_stats_entries; i++)
 		airoha_ppe_foe_flow_stat_entry_reset(ppe, npu, i);
 }
 
@@ -513,10 +553,17 @@ static void airoha_ppe_foe_flow_stats_update(struct airoha_ppe *ppe,
 {
 	int type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, hwe->ib1);
 	u32 index, pse_port, val, *data, *ib2, *meter;
+	int ppe_num_stats_entries;
 	u8 nbq;
 
-	index = airoha_ppe_foe_get_flow_stats_index(ppe, hash);
-	if (index >= PPE_STATS_NUM_ENTRIES)
+	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
+	if (ppe_num_stats_entries < 0)
+		return;
+
+	if (airoha_ppe_foe_get_flow_stats_index(ppe, hash, &index))
+		return;
+
+	if (index >= ppe_num_stats_entries)
 		return;
 
 	if (type == PPE_PKT_TYPE_BRIDGE) {
@@ -1158,11 +1205,19 @@ static int airoha_ppe_flow_offload_destroy(struct airoha_eth *eth,
 void airoha_ppe_foe_entry_get_stats(struct airoha_ppe *ppe, u32 hash,
 				    struct airoha_foe_stats64 *stats)
 {
-	u32 index = airoha_ppe_foe_get_flow_stats_index(ppe, hash);
 	struct airoha_eth *eth = ppe->eth;
+	int ppe_num_stats_entries;
 	struct airoha_npu *npu;
+	u32 index;
+
+	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
+	if (ppe_num_stats_entries < 0)
+		return;
 
-	if (index >= PPE_STATS_NUM_ENTRIES)
+	if (airoha_ppe_foe_get_flow_stats_index(ppe, hash, &index))
+		return;
+
+	if (index >= ppe_num_stats_entries)
 		return;
 
 	rcu_read_lock();
@@ -1257,7 +1312,7 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 {
 	struct airoha_npu *npu = airoha_ppe_npu_get(eth);
 	struct airoha_ppe *ppe = eth->ppe;
-	int err;
+	int err, ppe_num_stats_entries;
 
 	if (IS_ERR(npu))
 		return PTR_ERR(npu);
@@ -1266,9 +1321,10 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	if (err)
 		goto error_npu_put;
 
-	if (PPE_STATS_NUM_ENTRIES) {
+	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
+	if (ppe_num_stats_entries > 0) {
 		err = npu->ops.ppe_init_stats(npu, ppe->foe_stats_dma,
-					      PPE_STATS_NUM_ENTRIES);
+					      ppe_num_stats_entries);
 		if (err)
 			goto error_npu_put;
 	}
@@ -1405,8 +1461,8 @@ EXPORT_SYMBOL_GPL(airoha_ppe_put_dev);
 
 int airoha_ppe_init(struct airoha_eth *eth)
 {
+	int foe_size, err, ppe_num_stats_entries;
 	struct airoha_ppe *ppe;
-	int foe_size, err;
 
 	ppe = devm_kzalloc(eth->dev, sizeof(*ppe), GFP_KERNEL);
 	if (!ppe)
@@ -1431,8 +1487,9 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	if (!ppe->foe_flow)
 		return -ENOMEM;
 
-	foe_size = PPE_STATS_NUM_ENTRIES * sizeof(*ppe->foe_stats);
-	if (foe_size) {
+	ppe_num_stats_entries = airoha_ppe_get_total_num_stats_entries(ppe);
+	if (ppe_num_stats_entries > 0) {
+		foe_size = ppe_num_stats_entries * sizeof(*ppe->foe_stats);
 		ppe->foe_stats = dmam_alloc_coherent(eth->dev, foe_size,
 						     &ppe->foe_stats_dma,
 						     GFP_KERNEL);

-- 
2.51.0


