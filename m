Return-Path: <netdev+bounces-216196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D164B32782
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B979E7BD08D
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA30E22A4FE;
	Sat, 23 Aug 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEuA0nsm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9C150997
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755935793; cv=none; b=ENpOjl+Dhq4twp6zdUDzugbGYgeudUYXDxUgDkfp2Jr2pOiezqfm8SWcpC7MTDDCLmpFbOP+ThjcW0PyENNq14p2sJ4KbsflmW19scpcZhFRLDyruYomW/eM899feCSNFeiYjnKSbfI5IPr2HznwF+UtOKr7ftYVfyAs5ikRcBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755935793; c=relaxed/simple;
	bh=Tbme8j5p7op4L6staVb0SYIyNq6Rfw+asaK7RC4Bgu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vmhq1Kq3I5vWiW71Eqxe3kYs+p2DTcKLYlNTd/HpypltDsmZDLsOcTP05lOHicn4ivpQDutrymW00M+NAzMDB1RA924D9ZlWY9ycOGwbKKCYiPDWv9bJVX6B/E09liVzwRkdKr6VqfcoeclepxMEidnn32gErBy6oJeksz7mYlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEuA0nsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B80C4CEE7;
	Sat, 23 Aug 2025 07:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755935793;
	bh=Tbme8j5p7op4L6staVb0SYIyNq6Rfw+asaK7RC4Bgu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DEuA0nsmNpRsG8Zr7JOf1GFl3750lOiEqavhv6ysiK3Ksg9bjVyWxn/yXWGZGxKBm
	 b7zSJ4Hd8kb+x02iBWxRe0Q3ZSpTtRDr8XoJy2QOhcG3T1P1/KsYVSGW76UwuYCBBq
	 USEdK3WFEj1wkd815C1Rveo4Vq0b3dVfO9KPBY2an4U+DCLzSg8u+nCM7gfuOxbWP0
	 DIa78dXZyatZWFqq4tCH9HhZ6Las2mSYbnsRKC77l5PuF1JTnZUTQFL/S1AIIwKLXH
	 Q5Sw6uWW2poyl99pa1/O17VXdXEnK0V4csM8+KLFUZAcTAfyCfk21zARXIF7HO7WQh
	 cHCplH6gqkKOw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 23 Aug 2025 09:56:04 +0200
Subject: [PATCH net-next v3 3/3] net: airoha: Introduce check_skb callback
 in ppe_dev ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-airoha-en7581-wlan-rx-offload-v3-3-f78600ec3ed8@kernel.org>
References: <20250823-airoha-en7581-wlan-rx-offload-v3-0-f78600ec3ed8@kernel.org>
In-Reply-To: <20250823-airoha-en7581-wlan-rx-offload-v3-0-f78600ec3ed8@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Export airoha_ppe_check_skb routine in ppe_dev ops. check_skb callback
will be used by the MT76 driver in order to offload the traffic received
by the wlan NIC and forwarded to the ethernet one.
Add rx_wlan parameter to airoha_ppe_check_skb routine signature.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  |  3 ++-
 drivers/net/ethernet/airoha/airoha_eth.h  |  8 ++------
 drivers/net/ethernet/airoha/airoha_ppe.c  | 25 ++++++++++++++-----------
 include/linux/soc/airoha/airoha_offload.h | 20 ++++++++++++++++++++
 4 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a04f90dd3de47ae0ee8e90bfe221618076297e6..81ea01a652b9c545c348ad6390af8be873a4997f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -698,7 +698,8 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 
 		reason = FIELD_GET(AIROHA_RXD4_PPE_CPU_REASON, msg1);
 		if (reason == PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED)
-			airoha_ppe_check_skb(eth->ppe, q->skb, hash);
+			airoha_ppe_check_skb(&eth->ppe->dev, q->skb, hash,
+					     false);
 
 		done++;
 		napi_gro_receive(&q->napi, q->skb);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 9060b1d2814e0e4023d42a05ecb5265212df588f..77fd13d466dcd235a3ab39a488aa26d8f793cf77 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -229,10 +229,6 @@ struct airoha_hw_stats {
 	u64 rx_len[7];
 };
 
-enum {
-	PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED = 0x0f,
-};
-
 enum {
 	AIROHA_FOE_STATE_INVALID,
 	AIROHA_FOE_STATE_UNBIND,
@@ -622,8 +618,8 @@ static inline bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
 
-void airoha_ppe_check_skb(struct airoha_ppe *ppe, struct sk_buff *skb,
-			  u16 hash);
+void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
+			  u16 hash, bool rx_wlan);
 int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_data);
 int airoha_ppe_init(struct airoha_eth *eth);
 void airoha_ppe_deinit(struct airoha_eth *eth);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 03d9b1f24bb34008b36d9590ec355f4503f9b01c..78473527ff508919fa60a464917617cb882aac20 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -616,7 +616,7 @@ static bool airoha_ppe_foe_compare_entry(struct airoha_flow_table_entry *e,
 
 static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 				       struct airoha_foe_entry *e,
-				       u32 hash)
+				       u32 hash, bool rx_wlan)
 {
 	struct airoha_foe_entry *hwe = ppe->foe + hash * sizeof(*hwe);
 	u32 ts = airoha_ppe_get_timestamp(ppe);
@@ -639,7 +639,8 @@ static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 		goto unlock;
 	}
 
-	airoha_ppe_foe_flow_stats_update(ppe, npu, hwe, hash);
+	if (!rx_wlan)
+		airoha_ppe_foe_flow_stats_update(ppe, npu, hwe, hash);
 
 	if (hash < PPE_SRAM_NUM_ENTRIES) {
 		dma_addr_t addr = ppe->foe_dma + hash * sizeof(*hwe);
@@ -665,7 +666,7 @@ static void airoha_ppe_foe_remove_flow(struct airoha_ppe *ppe,
 		e->data.ib1 &= ~AIROHA_FOE_IB1_BIND_STATE;
 		e->data.ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
 					  AIROHA_FOE_STATE_INVALID);
-		airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash);
+		airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash, false);
 		e->hash = 0xffff;
 	}
 	if (e->type == FLOW_TYPE_L2_SUBFLOW) {
@@ -704,7 +705,7 @@ static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
 static int
 airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
 				    struct airoha_flow_table_entry *e,
-				    u32 hash)
+				    u32 hash, bool rx_wlan)
 {
 	u32 mask = AIROHA_FOE_IB1_BIND_PACKET_TYPE | AIROHA_FOE_IB1_BIND_UDP;
 	struct airoha_foe_entry *hwe_p, hwe;
@@ -745,14 +746,14 @@ airoha_ppe_foe_commit_subflow_entry(struct airoha_ppe *ppe,
 	}
 
 	hwe.bridge.data = e->data.bridge.data;
-	airoha_ppe_foe_commit_entry(ppe, &hwe, hash);
+	airoha_ppe_foe_commit_entry(ppe, &hwe, hash, rx_wlan);
 
 	return 0;
 }
 
 static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
 					struct sk_buff *skb,
-					u32 hash)
+					u32 hash, bool rx_wlan)
 {
 	struct airoha_flow_table_entry *e;
 	struct airoha_foe_bridge br = {};
@@ -785,7 +786,7 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
 		if (!airoha_ppe_foe_compare_entry(e, hwe))
 			continue;
 
-		airoha_ppe_foe_commit_entry(ppe, &e->data, hash);
+		airoha_ppe_foe_commit_entry(ppe, &e->data, hash, rx_wlan);
 		commit_done = true;
 		e->hash = hash;
 	}
@@ -797,7 +798,7 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe,
 	e = rhashtable_lookup_fast(&ppe->l2_flows, &br,
 				   airoha_l2_flow_table_params);
 	if (e)
-		airoha_ppe_foe_commit_subflow_entry(ppe, e, hash);
+		airoha_ppe_foe_commit_subflow_entry(ppe, e, hash, rx_wlan);
 unlock:
 	spin_unlock_bh(&ppe_lock);
 }
@@ -1301,9 +1302,10 @@ int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_data)
 	return err;
 }
 
-void airoha_ppe_check_skb(struct airoha_ppe *ppe, struct sk_buff *skb,
-			  u16 hash)
+void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
+			  u16 hash, bool rx_wlan)
 {
+	struct airoha_ppe *ppe = dev->priv;
 	u16 now, diff;
 
 	if (hash > PPE_HASH_MASK)
@@ -1315,7 +1317,7 @@ void airoha_ppe_check_skb(struct airoha_ppe *ppe, struct sk_buff *skb,
 		return;
 
 	ppe->foe_check_time[hash] = now;
-	airoha_ppe_foe_insert_entry(ppe, skb, hash);
+	airoha_ppe_foe_insert_entry(ppe, skb, hash, rx_wlan);
 }
 
 void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port)
@@ -1404,6 +1406,7 @@ int airoha_ppe_init(struct airoha_eth *eth)
 		return -ENOMEM;
 
 	ppe->dev.ops.setup_tc_block_cb = airoha_ppe_setup_tc_block_cb;
+	ppe->dev.ops.check_skb = airoha_ppe_check_skb;
 	ppe->dev.priv = ppe;
 
 	foe_size = PPE_NUM_ENTRIES * sizeof(struct airoha_foe_entry);
diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index 4b4b8b9e426dbc555bec4438b5e110cd235d2edc..1dc5b4e35ef9eaa1d06072a6b6dad52902468f79 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -9,10 +9,17 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
+enum {
+	PPE_CPU_REASON_HIT_UNBIND_RATE_REACHED = 0x0f,
+};
+
 struct airoha_ppe_dev {
 	struct {
 		int (*setup_tc_block_cb)(struct airoha_ppe_dev *dev,
 					 void *type_data);
+		void (*check_skb)(struct airoha_ppe_dev *dev,
+				  struct sk_buff *skb, u16 hash,
+				  bool rx_wlan);
 	} ops;
 
 	void *priv;
@@ -27,6 +34,13 @@ static inline int airoha_ppe_dev_setup_tc_block_cb(struct airoha_ppe_dev *dev,
 {
 	return dev->ops.setup_tc_block_cb(dev, type_data);
 }
+
+static inline void airoha_ppe_dev_check_skb(struct airoha_ppe_dev *dev,
+					    struct sk_buff *skb,
+					    u16 hash, bool rx_wlan)
+{
+	dev->ops.check_skb(dev, skb, hash, rx_wlan);
+}
 #else
 static inline struct airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev)
 {
@@ -42,6 +56,12 @@ static inline int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline void airoha_ppe_dev_check_skb(struct airoha_ppe_dev *dev,
+					    struct sk_buff *skb, u16 hash,
+					    bool rx_wlan)
+{
+}
 #endif
 
 #define NPU_NUM_CORES		8

-- 
2.50.1


