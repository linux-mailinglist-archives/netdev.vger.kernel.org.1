Return-Path: <netdev+bounces-230393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0506ABE7723
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0CBB5625BE
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83A12D7DF7;
	Fri, 17 Oct 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4suWbBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D422D7DD9;
	Fri, 17 Oct 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692012; cv=none; b=E5qjzyCZ0XCPgH/GNUNv8qSjXSu4KB4nw/qN+3S/a8sf90F9tpVGlrk5RybFKEUVM/xX5nkDT+WBgqSylr3YuCIlQTXNwKLeZzRJj8PoDPLegsIEiIHFPClyqbk+5qmkUtyIUDLlnbDErqb9+r1x4YsUkZmt0y828yVIes83NyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692012; c=relaxed/simple;
	bh=RD21qU2VSBHLisd/MpZuos9XQ0jlkCrzeoHBUEQk+G0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OU6G/QU0ys8eO+yaUfP15DyWXz+TgUcjxcAdbEOVX/JkbnJUKrA3zFnGT4h0dSZO5BryXWgI9JXarCdBrbtmjPJSF50ALQJ+yvVtjgszWsQEDxbwOYsiIm9hdee7RSZS9KT2C9Q54MBOJqR3THjNg0Eq387Nahe5769p13R+ogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4suWbBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F17C4CEE7;
	Fri, 17 Oct 2025 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760692012;
	bh=RD21qU2VSBHLisd/MpZuos9XQ0jlkCrzeoHBUEQk+G0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I4suWbBLn3Yi0GOgjSrigQQPRF/aH6jPtQVyarNs8haxJsPAadsU7R8utM9d9f2/T
	 AwLJHX+eF2Y4w8viKGHRaPsJMjTP8EDndnwlyrbOxIeqf0EdSVwRTOz5sL0rwNKRvy
	 E2bXG4cv/UPIs8MYwW0kFn8W0A7idkNInCB9HBR5dGgqr4bbHZCRt1rTlIuSnKxs/K
	 2pq5WOw3jTz7YPe2B01BEhNITZ7ShDuxdsHsgPS0S396td133vr+LuwNZ8z9lWHMkA
	 2XopuwM+p84sAOGanWZGWCohKclSb5GNdmyLU53R9UpwocIZSeizShRwhkae+ZC3xC
	 ug2dRftdFv4ww==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 11:06:17 +0200
Subject: [PATCH net-next v3 08/13] net: airoha: ppe: Configure SRAM PPE
 entries via the cpu
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-an7583-eth-support-v3-8-f28319666667@kernel.org>
References: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
In-Reply-To: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

Introduce airoha_ppe_foe_commit_sram_entry routine in order to configure
the SRAM PPE entries directly via the CPU instead of using the NPU APIs.
This is a preliminary patch to enable netfilter flowtable hw offload for
AN7583 SoC.

Reviewed-by: Simon Horman <horms@kernel.org>
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


