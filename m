Return-Path: <netdev+bounces-179680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE42CA7E163
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76242168866
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524CE1DA634;
	Mon,  7 Apr 2025 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4vmVd1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5DC1D88DB
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744035529; cv=none; b=O8E9/bUAItKgHl1b437XL8g3gs+9zgBwgVQMzhqfw3XGUNCu/TWGjp1szjYhw0arsV3Lk5e9jeovbGkPjGBsTsIsHUiRXsZ2XSwImXeKs50m0JZAS7JoF6hnkzhcQscwhzKnGqw0zwRqds4CU1WQRlc/Ug57WK5LKnzJ8AXQyDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744035529; c=relaxed/simple;
	bh=K5EzkBuJAc3ZaJRcknCSYudz4Q3lzDRYva1mnChGj0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jd4e/1zUdLoLPB+kG+ZYfv3PWxpUYbzL704dnCoGCchdLFfpNCnGJZlfAz1BBoUEjljAZoNxYmmQNW3wimioVZHENZFO3Lxq/+vPslmTTDnzGCdFEQONypfUl0S7Z/Y9RUq+OGwqMM/mia4VzEWWVoJ5WVEFqThlDXBWlknCzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4vmVd1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46906C4CEDD;
	Mon,  7 Apr 2025 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744035528;
	bh=K5EzkBuJAc3ZaJRcknCSYudz4Q3lzDRYva1mnChGj0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V4vmVd1QY1vK4QwpKwk2rxeIMORGRSdiYWWTZ/Dqt983289euYrYVv5/04Ncn9XBi
	 ZZcYbWrdCAC+UuS5uEEClfwBgWF+CTPEw7dWKCcX2IgMKpke9LVPYn8w5E9aPbOi67
	 5Y/0gbpbiV9RDBnK5CRyJSx9pml5HfosgDls8D0FWh6DntGfq2B8YvXXt7OmXsGQnB
	 Aol/cPmZ80Nepju+4QgE5cP7k/fit+x28BFaGzf7Rx3TjGc3rXriKspzgu3mbXH3/M
	 Zc7w0qGWdJyw4+AXxugoq7YedOluRrCxgAw09ISjMPjU8VM2f4cGH0XApA0gqD0mxD
	 zKkFM4/UDgSRg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 07 Apr 2025 16:18:31 +0200
Subject: [PATCH net-next 2/3] net: airoha: Add
 airoha_ppe_foe_flow_remove_entry_locked()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-airoha-flowtable-l2b-v1-2-18777778e568@kernel.org>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
In-Reply-To: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce airoha_ppe_foe_flow_remove_entry_locked utility routine
in order to run airoha_ppe_foe_flow_remove_entry holding ppe_lock.
This is a preliminary patch to L2 offloading support to airoha_eth
driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 45 ++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index aed4a22f3a8b8737f18509b48fc47eae594b9d5f..8f75752c6714cc211a8efd0b6fdf5565ffa23c14 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -483,6 +483,26 @@ static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 	return 0;
 }
 
+static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
+					     struct airoha_flow_table_entry *e)
+{
+	lockdep_assert_held(&ppe_lock);
+
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
+	}
+}
+
 static void airoha_ppe_foe_insert_entry(struct airoha_ppe *ppe, u32 hash)
 {
 	struct airoha_flow_table_entry *e;
@@ -551,25 +571,12 @@ static int airoha_ppe_foe_flow_commit_entry(struct airoha_ppe *ppe,
 	return 0;
 }
 
-static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
-					     struct airoha_flow_table_entry *e)
+static void
+airoha_ppe_foe_flow_remove_entry_locked(struct airoha_ppe *ppe,
+					struct airoha_flow_table_entry *e)
 {
 	spin_lock_bh(&ppe_lock);
-
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
-
+	airoha_ppe_foe_flow_remove_entry(ppe, e);
 	spin_unlock_bh(&ppe_lock);
 }
 
@@ -762,7 +769,7 @@ static int airoha_ppe_flow_offload_replace(struct airoha_gdm_port *port,
 	return 0;
 
 remove_foe_entry:
-	airoha_ppe_foe_flow_remove_entry(eth->ppe, e);
+	airoha_ppe_foe_flow_remove_entry_locked(eth->ppe, e);
 free_entry:
 	kfree(e);
 
@@ -780,7 +787,7 @@ static int airoha_ppe_flow_offload_destroy(struct airoha_gdm_port *port,
 	if (!e)
 		return -ENOENT;
 
-	airoha_ppe_foe_flow_remove_entry(eth->ppe, e);
+	airoha_ppe_foe_flow_remove_entry_locked(eth->ppe, e);
 	rhashtable_remove_fast(&eth->flow_table, &e->node,
 			       airoha_flow_table_params);
 	kfree(e);

-- 
2.49.0


