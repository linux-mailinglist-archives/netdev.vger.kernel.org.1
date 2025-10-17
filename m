Return-Path: <netdev+bounces-230391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A0ABE77B3
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76035587EBD
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FBF2D7DD8;
	Fri, 17 Oct 2025 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJP6VjUO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115432D7D2E;
	Fri, 17 Oct 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692010; cv=none; b=KDCt4iUjuU3UJYPXrjV0KHp0aVxjkqANVk8T4S+tUoAcUNhoTTfywt389lgaaZYBn9Q4h0S2lcPO5P1s+Jte/PTvXXIe5spaSXGUYCwznVnF2Y5bXSMLZyGe+tUjYVKGAhjZV09yHM/wPJA0veHH3WTDtIH6jGGjltOxfhje4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692010; c=relaxed/simple;
	bh=hNrhTz9RivBvwoNye3uuIuxIHUqtKrAbVtiIQ+QL17g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AAfp2CUmwXNQc1SglGjlmUBcfxhc3LiCs26vt52494S6VO85wggusL7hUEe1AcyvmIWqxtdtlkZXXMB+glHaJoYHag+dPEqqKMD0sB53/SsMzs2NNS8/+jyV4IFAmXuYYosBx3fyIqBXh8c5rqaXbXsZcMC4cGe3qnhJfa9fezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJP6VjUO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA2AC113D0;
	Fri, 17 Oct 2025 09:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760692009;
	bh=hNrhTz9RivBvwoNye3uuIuxIHUqtKrAbVtiIQ+QL17g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IJP6VjUOzAyspaG0LvetkL7B6Fu27W3n2jt/8ekHyzDijYja0ewa4LZuZOM7Io+Xw
	 9zLyf2GpImy/6Bm6M5regY6cH/cDOmcF9ZYDs4xGsH9bjQ5lU5jhit0Ak9o7C827KP
	 E/RQtuKXPjsGtK0w4wNlhQSsUfo5P67ByHo/1y9hYaAiVzKn8dgVlE4SrqZ3tboyaF
	 UyhxCEpnet4xoSddogHsLHMi/HHPStSKqlrmRHHArbZ/wlu/Nbe8Gaq/fN7nk2UpcA
	 HTOqKMJAkJDoU7sEa0Ef4+1TTfH4WIdCYbRUZQjrD1fBTbKHz2UEFCm4F2eZaA7K/i
	 zsgqPo7TvUbtw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 11:06:16 +0200
Subject: [PATCH net-next v3 07/13] net: airoha: ppe: Remove
 airoha_ppe_is_enabled() where not necessary
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-an7583-eth-support-v3-7-f28319666667@kernel.org>
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

Now each PPE has always PPE_STATS_NUM_ENTRIES entries so we do not need
to run airoha_ppe_is_enabled routine to check if the hash refers to
PPE1 or PPE2.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index d142660e7910425c14ea2f867f8238156419833b..195d97e61197e5c393f2e79f33f685c334612a83 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -514,10 +514,8 @@ static int airoha_ppe_foe_get_flow_stats_index(struct airoha_ppe *ppe,
 	if (ppe_num_stats_entries < 0)
 		return ppe_num_stats_entries;
 
-	*index = hash;
-	if (airoha_ppe_is_enabled(ppe->eth, 1) &&
-	    hash >= ppe_num_stats_entries)
-		*index = *index - PPE_STATS_NUM_ENTRIES;
+	*index = hash >= ppe_num_stats_entries ? hash - PPE_STATS_NUM_ENTRIES
+					       : hash;
 
 	return 0;
 }
@@ -607,13 +605,11 @@ airoha_ppe_foe_get_entry_locked(struct airoha_ppe *ppe, u32 hash)
 
 	if (hash < sram_num_entries) {
 		u32 *hwe = ppe->foe + hash * sizeof(struct airoha_foe_entry);
+		bool ppe2 = hash >= PPE_SRAM_NUM_ENTRIES;
 		struct airoha_eth *eth = ppe->eth;
-		bool ppe2;
 		u32 val;
 		int i;
 
-		ppe2 = airoha_ppe_is_enabled(ppe->eth, 1) &&
-		       hash >= PPE_SRAM_NUM_ENTRIES;
 		airoha_fe_wr(ppe->eth, REG_PPE_RAM_CTRL(ppe2),
 			     FIELD_PREP(PPE_SRAM_CTRL_ENTRY_MASK, hash) |
 			     PPE_SRAM_CTRL_REQ_MASK);
@@ -691,8 +687,7 @@ static int airoha_ppe_foe_commit_entry(struct airoha_ppe *ppe,
 
 	if (hash < sram_num_entries) {
 		dma_addr_t addr = ppe->foe_dma + hash * sizeof(*hwe);
-		bool ppe2 = airoha_ppe_is_enabled(eth, 1) &&
-			    hash >= PPE_SRAM_NUM_ENTRIES;
+		bool ppe2 = hash >= PPE_SRAM_NUM_ENTRIES;
 
 		err = npu->ops.ppe_foe_commit_entry(npu, addr, sizeof(*hwe),
 						    hash, ppe2);

-- 
2.51.0


