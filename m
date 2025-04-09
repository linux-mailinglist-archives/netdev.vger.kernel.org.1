Return-Path: <netdev+bounces-180669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C3AA82148
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F084C23A4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC27D25D214;
	Wed,  9 Apr 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNBipUjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840D22DFA2
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192060; cv=none; b=kiomkcEouFg3g4mjnCzpncBso/PwWxp3r7mNDYfXLvNabZgey/O+XjN5fqChmf7L1joxUlwu2rp23cRvjqeO80vOSrez+HlPJ9nwgFAbUcykoMJ6z4KblA6g4MggEVJTIqadRP0cSxvX9ug9cGYaZZjHn785ige2Vf8L9DuhuIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192060; c=relaxed/simple;
	bh=0+KmhDC5Bq+hB5H1LEihm9+Jr3ipByVEnTSATi06Hj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tNy1kMawOBfXsxWxFRyXsefbAO3lY5T6ycQUaMP7u3RvFRzlUUVpbBbrIlksN9k61AkucaUqEmacoG/E7gkOGvD2k2O9mqZGgrCpo9mnWk7BobgRCGZrwpVsFVKPVeGwS0df1+vsmVPiUu7Ap68zY3fiSkOnoC218J1Jw6IvGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNBipUjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF18C4CEE3;
	Wed,  9 Apr 2025 09:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744192060;
	bh=0+KmhDC5Bq+hB5H1LEihm9+Jr3ipByVEnTSATi06Hj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DNBipUjS+vhiULkvJjAwla3R/ws3eJzjAAfLbPC2e1yO6TyNaikqMr+UJwyLgrseW
	 TiYeqDjtObhXTTe/yMPrxLvT9NnMv6+axeBIER3clp2Ym2IjDCH0nrBYN1L/Ej692e
	 5lgfEbJVzunoWFmExrdgfgMerdvEo6+FsjJFFywQc5nWyNxz8dMvE9JJUF6VvnulgP
	 6k8n57VURCJUUZr4WqJKzCsbaNa8HN+gzonuVwB1CjPkdrbyhY62x57bdNtAikZGVu
	 1bCs8dMEAxXScS1SGFcv3LEv0iN02OP1xlGA32knRd3P+3jU542obo36frnK4sKqr7
	 PmcQxyltBldXw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 09 Apr 2025 11:47:14 +0200
Subject: [PATCH net-next v2 1/2] net: airoha: Add l2_flows rhashtable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-airoha-flowtable-l2b-v2-1-4a1e3935ea92@kernel.org>
References: <20250409-airoha-flowtable-l2b-v2-0-4a1e3935ea92@kernel.org>
In-Reply-To: <20250409-airoha-flowtable-l2b-v2-0-4a1e3935ea92@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Michal Kubiak <michal.kubiak@intel.com>
X-Mailer: b4 0.14.2

Introduce l2_flows rhashtable in airoha_ppe struct in order to
store L2 flows committed by upper layers of the kernel. This is a
preliminary patch in order to offload L2 traffic rules.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.h |  15 ++++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 103 +++++++++++++++++++++++++------
 2 files changed, 98 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index ec8908f904c61988c3dc973e187596c49af139fb..86e08832246dfdc4fc448a8aeceb7032d633e812 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -422,12 +422,23 @@ struct airoha_flow_data {
 	} pppoe;
 };
 
+enum airoha_flow_entry_type {
+	FLOW_TYPE_L4,
+	FLOW_TYPE_L2,
+	FLOW_TYPE_L2_SUBFLOW,
+};
+
 struct airoha_flow_table_entry {
-	struct hlist_node list;
+	union {
+		struct hlist_node list; /* PPE L3 flow entry */
+		struct rhash_head l2_node; /* L2 flow entry */
+	};
 
 	struct airoha_foe_entry data;
 	u32 hash;
 
+	enum airoha_flow_entry_type type;
+
 	struct rhash_head node;
 	unsigned long cookie;
 };
@@ -480,6 +491,8 @@ struct airoha_ppe {
 	void *foe;
 	dma_addr_t foe_dma;
 
+	struct rhashtable l2_flows;
+
 	struct hlist_head *foe_flow;
 	u16 foe_check_time[PPE_NUM_ENTRIES];
 
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index f10dab935cab6fad747fdfaa70b67903904c1703..7219125ade134614d12bfad3f02b48392962d88f 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -24,6 +24,13 @@ static const struct rhashtable_params airoha_flow_table_params = {
 	.automatic_shrinking = true,
 };
 
+static const struct rhashtable_params airoha_l2_flow_table_params = {
+	.head_offset = offsetof(struct airoha_flow_table_entry, l2_node),
+	.key_offset = offsetof(struct airoha_flow_table_entry, data.bridge),
+	.key_len = 2 * ETH_ALEN,
+	.automatic_shrinking = true,
+};
+
 static bool airoha_ppe2_is_enabled(struct airoha_eth *eth)
 {
 	return airoha_fe_rr(eth, REG_PPE_GLO_CFG(1)) & PPE_GLO_CFG_EN_MASK;
@@ -476,6 +483,43 @@ static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
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
+}
+
+static void airoha_ppe_foe_remove_l2_flow(struct airoha_ppe *ppe,
+					  struct airoha_flow_table_entry *e)
+{
+	lockdep_assert_held(&ppe_lock);
+
+	rhashtable_remove_fast(&ppe->l2_flows, &e->l2_node,
+			       airoha_l2_flow_table_params);
+}
+
+static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
+					     struct airoha_flow_table_entry *e)
+{
+	spin_lock_bh(&ppe_lock);
+
+	if (e->type == FLOW_TYPE_L2)
+		airoha_ppe_foe_remove_l2_flow(ppe, e);
+	else
+		airoha_ppe_foe_remove_flow(ppe, e);
+
+	spin_unlock_bh(&ppe_lock);
+}
+
 static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe, u32 hash)
 {
 	struct airoha_flow_table_entry *e;
@@ -505,11 +549,37 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe, u32 hash)
 	spin_unlock_bh(&ppe_lock);
 }
 
+static int
+airoha_ppe_foe_l2_flow_commit_entry(struct airoha_ppe *ppe,
+				    struct airoha_flow_table_entry *e)
+{
+	struct airoha_flow_table_entry *prev;
+
+	e->type = FLOW_TYPE_L2;
+	prev = rhashtable_lookup_get_insert_fast(&ppe->l2_flows, &e->l2_node,
+						 airoha_l2_flow_table_params);
+	if (!prev)
+		return 0;
+
+	if (IS_ERR(prev))
+		return PTR_ERR(prev);
+
+	return rhashtable_replace_fast(&ppe->l2_flows, &prev->l2_node,
+				       &e->l2_node,
+				       airoha_l2_flow_table_params);
+}
+
 static int airoha_ppe_foe_flow_commit_entry(struct airoha_ppe *ppe,
 					    struct airoha_flow_table_entry *e)
 {
-	u32 hash = airoha_ppe_foe_get_entry_hash(&e->data);
+	int type = FIELD_GET(AIROHA_FOE_IB1_BIND_PACKET_TYPE, e->data.ib1);
+	u32 hash;
 
+	if (type == PPE_PKT_TYPE_BRIDGE)
+		return airoha_ppe_foe_l2_flow_commit_entry(ppe, e);
+
+	hash = airoha_ppe_foe_get_entry_hash(&e->data);
+	e->type = FLOW_TYPE_L4;
 	e->hash = 0xffff;
 
 	spin_lock_bh(&ppe_lock);
@@ -519,23 +589,6 @@ static int airoha_ppe_foe_flow_commit_entry(struct airoha_ppe *ppe,
 	return 0;
 }
 
-static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
-					     struct airoha_flow_table_entry *e)
-{
-	spin_lock_bh(&ppe_lock);
-
-	hlist_del_init(&e->list);
-	if (e->hash != 0xffff) {
-		e->data.ib1 &= ~AIROHA_FOE_IB1_BIND_STATE;
-		e->data.ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
-					  AIROHA_FOE_STATE_INVALID);
-		airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash);
-		e->hash = 0xffff;
-	}
-
-	spin_unlock_bh(&ppe_lock);
-}
-
 static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
 					   struct flow_cls_offload *f)
 {
@@ -890,9 +943,20 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	if (err)
 		return err;
 
+	err = rhashtable_init(&ppe->l2_flows, &airoha_l2_flow_table_params);
+	if (err)
+		goto error_flow_table_destroy;
+
 	err = airoha_ppe_debugfs_init(ppe);
 	if (err)
-		rhashtable_destroy(&eth->flow_table);
+		goto error_l2_flow_table_destroy;
+
+	return 0;
+
+error_l2_flow_table_destroy:
+	rhashtable_destroy(&ppe->l2_flows);
+error_flow_table_destroy:
+	rhashtable_destroy(&eth->flow_table);
 
 	return err;
 }
@@ -909,6 +973,7 @@ void airoha_ppe_deinit(struct airoha_eth *eth)
 	}
 	rcu_read_unlock();
 
+	rhashtable_destroy(&eth->ppe->l2_flows);
 	rhashtable_destroy(&eth->flow_table);
 	debugfs_remove(eth->ppe->debugfs_dir);
 }

-- 
2.49.0


