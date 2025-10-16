Return-Path: <netdev+bounces-229981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F019BE2D5D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DDE581D5C
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1A131961B;
	Thu, 16 Oct 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGjDf2Gv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0702C2DFF3F;
	Thu, 16 Oct 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610540; cv=none; b=rPdHotL8/gmlC1yXSnF77UVcxhY2NZva+0A8H+kGobI/uhKiI/LFnJA3b+PfgWTeYtiZwh3PuMOsXdBjmM/RnlmVLhZAjqSM4B9w088yV8y/xYMD29HjvopbtKh9Fy4TpkSXVokFm3kORG5jnv9cpa1STJQfrUIzcrVSBqOwARw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610540; c=relaxed/simple;
	bh=nEifpoyi2uHHtXE2HCxJFum2zuqlAdUcNjUSB5XTpZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aRFayXXSp0QdNgto1axlFYAwsnWTLU5VXyadtyyfkoW+NEf0tZBvg71dkmtyE0NiPv6nRCo3tgY4nXA/B5dSRdJlalWF54QYwZbduVp67O4pgLM4wC0IXwAJKiQFy9Z9T4mwoOxYfCZZQvavEvONc4Nc5c3C0MDKTb0hmT1vD4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGjDf2Gv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D33BC113D0;
	Thu, 16 Oct 2025 10:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760610539;
	bh=nEifpoyi2uHHtXE2HCxJFum2zuqlAdUcNjUSB5XTpZM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gGjDf2GvRztXochV/PNVJP0BVS8A9Irq8cdj6W5aaSXAFJjBqF37wJPhZlKg5lxwI
	 zGKjMJJHxRhMBuilDWy7bj/BGXGx2hbPrOaeZaubAh1v7zUC69UMdgWPfMSKuOXq7M
	 1acL5lWx2nVTUn1AwPtJszGcERj9OFszImPuhL7a5z+VY0zRIy8pYlEQsOmp91NobH
	 dSYSwx78QZ6kBifx1ntYFskfadpLkZAxT99QBExCXFhs6Rpl6AXOi///Q+KH5AetPU
	 ZtorNjJ5FJ7ak84kGfRkSJi+h1WUT7qSdhBDaV0YiyXi5MgBwTHDqjLkWte+ySXnML
	 jr7g3OXmzD2ZQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Oct 2025 12:28:22 +0200
Subject: [PATCH net-next v2 08/13] net: airoha: ppe: Configure SRAM PPE
 entries via the cpu
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-an7583-eth-support-v2-8-ea6e7e9acbdb@kernel.org>
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

Introduce airoha_ppe_foe_commit_sram_entry routine in order to configure
the SRAM PPE entries directly via the CPU instead of using the NPU APIs.
This is a preliminary patch to enable netfilter flowtable hw offload for
AN7583 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 195d97e61197e5c393f2e79f33f685c334612a83..46755bc60a8e822b296e188c061c45eae0b88cb5 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -656,6 +656,27 @@ static bool airoha_ppe_foe_compare_entry(struct airoha_flow_table_entry *e,
 	return !memcmp(&e->data.d, &hwe->d, len - sizeof(hwe->ib1));
 }
 
+static int airoha_ppe_foe_commit_sram_entry(struct airoha_ppe *ppe, u32 hash)
+{
+	struct airoha_foe_entry *hwe = ppe->foe + hash * sizeof(*hwe);
+	bool ppe2 = hash >= PPE_SRAM_NUM_ENTRIES;
+	u32 *ptr = (u32 *)hwe, val;
+	int i;
+
+	for (i = 0; i < sizeof(*hwe) / sizeof(*ptr); i++)
+		airoha_fe_wr(ppe->eth, REG_PPE_RAM_ENTRY(ppe2, i), ptr[i]);
+
+	wmb();
+	airoha_fe_wr(ppe->eth, REG_PPE_RAM_CTRL(ppe2),
+		     FIELD_PREP(PPE_SRAM_CTRL_ENTRY_MASK, hash) |
+		     PPE_SRAM_CTRL_WR_MASK | PPE_SRAM_CTRL_REQ_MASK);
+
+	return read_poll_timeout_atomic(airoha_fe_rr, val,
+					val & PPE_SRAM_CTRL_ACK_MASK,
+					10, 100, false, ppe->eth,
+					REG_PPE_RAM_CTRL(ppe2));
+}
+
 static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 				       struct airoha_foe_entry *e,
 				       u32 hash, bool rx_wlan)
@@ -685,13 +706,8 @@ static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 	if (!rx_wlan)
 		airoha_ppe_foe_flow_stats_update(ppe, npu, hwe, hash);
 
-	if (hash < sram_num_entries) {
-		dma_addr_t addr = ppe->foe_dma + hash * sizeof(*hwe);
-		bool ppe2 = hash >= PPE_SRAM_NUM_ENTRIES;
-
-		err = npu->ops.ppe_foe_commit_entry(npu, addr, sizeof(*hwe),
-						    hash, ppe2);
-	}
+	if (hash < sram_num_entries)
+		err = airoha_ppe_foe_commit_sram_entry(ppe, hash);
 unlock:
 	rcu_read_unlock();
 

-- 
2.51.0


