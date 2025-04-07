Return-Path: <netdev+bounces-179679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4DEA7E102
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D22D1887C2C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D31D7E5F;
	Mon,  7 Apr 2025 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqFeO53f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8171CAA64
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035525; cv=none; b=KYq1sbEUTS6QN/Qgix/PXHUqmVjy3gYgFm/k3UK8GKqgoj9lnIQWx/1us2kqFkIjzhQ3MQpBoXPcqz12n8591kLoAnLFC3ADe8xhzxumAH32Qx/78ZVYG1izl6103FebiIKWmji4CIhInNrFARQkEZlZAoRqHhR69e5w4iVjiEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035525; c=relaxed/simple;
	bh=PEpWf8UDnWeJgZfMFDcP4fGro2nxdLzGkplXxHxBRYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lC0HSKJT09r8ZzNWiWmvULvJBo+9sVPX5sE33fxuWFVIvcad3JQK5CzDQGVHAiVEi4tr9vImRFg/QwkQuKZUrP6SHKwz8RQ1CUNRVpTNAOg82+s9+hVTq8SfFj1SV2hgClpaBhr9nr19upFZV0xo8aMfKm7KJfcbyYciNHspsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqFeO53f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A22C4CEDD;
	Mon,  7 Apr 2025 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744035525;
	bh=PEpWf8UDnWeJgZfMFDcP4fGro2nxdLzGkplXxHxBRYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UqFeO53ffL2wmeJDPwHEtPBVn0HgR/ZAof9fceTLjw7xZAvzUodrc6+ZGRcrpqFNc
	 FJb6tAElmStsMRakUxfajNYGcUmDhNmRE+yOKGPMUYvTdfmcKEG7/XOyiE5On6YHI0
	 VIxtwBHYXf6SfMHFYFW/0FyorPzHIgT1bn4/jM3vsDLKRkAGclY5VVxebIDxwBWaIe
	 sHL0tw63cjr/R4IFsJLuLCR4zJrDGHJ+kJORaxbogIfT7lWYZrgfiyWCc1fBToKzV8
	 nwzSmj8nk/vP++iUEYCSlmAaaebZ4jUp2r9x3lriBoCom0x0VGKzuC04xpswo7D2e9
	 f2cICdZEFRVwA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 07 Apr 2025 16:18:30 +0200
Subject: [PATCH net-next 1/3] net: airoha: Add l2_flows rhashtable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-airoha-flowtable-l2b-v1-1-18777778e568@kernel.org>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
In-Reply-To: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce l2_flows rhashtable in airoha_ppe struct in order to
store L2 flows committed by upper layers of the kernel. This is a
preliminary patch in order to offload L2 traffic rules.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 15 ++++++-
 drivers/net/ethernet/airoha/airoha_ppe.c | 67 +++++++++++++++++++++++++++-----
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index ec8908f904c61988c3dc973e187596c49af139fb..57925648155b104021c10821096ba267c9c7cef6 100644
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
+		struct hlist_node list;
+		struct rhash_head l2_node;
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
index f10dab935cab6fad747fdfaa70b67903904c1703..aed4a22f3a8b8737f18509b48fc47eae594b9d5f 100644
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
@@ -505,11 +512,36 @@ static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe, u32 hash)
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
 	e->hash = 0xffff;
 
 	spin_lock_bh(&ppe_lock);
@@ -524,13 +556,18 @@ static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
 {
 	spin_lock_bh(&ppe_lock);
 
-	hlist_del_init(&e->list);
-	if (e->hash != 0xffff) {
-		e->data.ib1 &= ~AIROHA_FOE_IB1_BIND_STATE;
-		e->data.ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
-					  AIROHA_FOE_STATE_INVALID);
-		airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash);
-		e->hash = 0xffff;
+	if (e->type == FLOW_TYPE_L2) {
+		rhashtable_remove_fast(&ppe->l2_flows, &e->l2_node,
+				       airoha_l2_flow_table_params);
+	} else {
+		hlist_del_init(&e->list);
+		if (e->hash != 0xffff) {
+			e->data.ib1 &= ~AIROHA_FOE_IB1_BIND_STATE;
+			e->data.ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
+						  AIROHA_FOE_STATE_INVALID);
+			airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash);
+			e->hash = 0xffff;
+		}
 	}
 
 	spin_unlock_bh(&ppe_lock);
@@ -890,9 +927,20 @@ int airoha_ppe_init(struct airoha_eth *eth)
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
@@ -909,6 +957,7 @@ void airoha_ppe_deinit(struct airoha_eth *eth)
 	}
 	rcu_read_unlock();
 
+	rhashtable_destroy(&eth->ppe->l2_flows);
 	rhashtable_destroy(&eth->flow_table);
 	debugfs_remove(eth->ppe->debugfs_dir);
 }

-- 
2.49.0


