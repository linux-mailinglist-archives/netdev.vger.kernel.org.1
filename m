Return-Path: <netdev+bounces-198915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047E0ADE4D0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143463BCD08
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B49923E32E;
	Wed, 18 Jun 2025 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4ZTWC+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EC2944F
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 07:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750232926; cv=none; b=OD7j5ZC6Wxp+ZlxcT/bNUa0TsudigY+CrKLZTzZ0Qh9B9WAHesB4N0IhlQwCS377volC38VnK8saa0vByNWEMa+JCJCawmAtqaEGC35rBc17QQKrEyjhXBBVaKh2V+uu0g4VvbL4slLq/TU7aqpk8her04YJA5bmz39f+2nLy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750232926; c=relaxed/simple;
	bh=zmxmRAuGPbnBoWImjaQfSrdRisEJjiibW7+o0uMkNko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uceVHiaJzQZ/hI9HrLeXuuUKtM960XeBH9vD0hy16OOhTWBWpruXMKRMSD93UwYfv9thatQvqZ2tjrlwQXnsVJa1WAs4rDI1rCP0QkCmcywCDq5sXGwoYkQwko9OjYCswZ1qjf/6nkjMki8HbNw/Yr/Gv9sIOcRG7ZQRW7WLRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4ZTWC+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43521C4CEE7;
	Wed, 18 Jun 2025 07:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750232925;
	bh=zmxmRAuGPbnBoWImjaQfSrdRisEJjiibW7+o0uMkNko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X4ZTWC+MQ2HneiK1Z1/U+4C8CiA96Jz5ldqrn8y+xTFQGtPGFvwo3X/8tMVLBpGQ+
	 cTuWbi4Cvw1PUHn7X4lpo/rt2RSxTQRMBYTFkzr0MJBYXc0xpw6R1UEix/eNBoX3XW
	 gUd9+Zm6vbS0dOQFYhAX72ARIkbo31U4N+oE/J3c1ubS98uunV4rbPcc0DEncHEFD1
	 npHpPuWaTjMB0GlOrLMio1xvggAvpzmWyJRwO/2SqzSJQwK37uzzb6KLnqFHDwB1dK
	 Y/jMjhyhsEM8VaLQXz+OZ3n5rg3CR63CMDnsgEpyXxN0JvYRB1HRrWr/NID7IeTvlQ
	 Ar8mVnlIv/maA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 18 Jun 2025 09:48:05 +0200
Subject: [PATCH net v3 2/2] net: airoha: Differentiate hwfd buffer size for
 QDMA0 and QDMA1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-airoha-hw-num-desc-v3-2-18a6487cd75e@kernel.org>
References: <20250618-airoha-hw-num-desc-v3-0-18a6487cd75e@kernel.org>
In-Reply-To: <20250618-airoha-hw-num-desc-v3-0-18a6487cd75e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In oreder to reduce the required hwfd buffers queue size for QDMA1,
differentiate hwfd buffer size for QDMA0 and QDMA1 and use 2KB for QDMA0
and 1KB for QDMA1.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 1b7fd7ee0cbf3e1f7717110c70e9c5183fdd93d4..06dea3a13e77ce11f35dbd36966a34c5ef229c11 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1068,14 +1068,15 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 	int size, index, num_desc = HW_DSCP_NUM;
 	struct airoha_eth *eth = qdma->eth;
 	int id = qdma - &eth->qdma[0];
+	u32 status, buf_size;
 	dma_addr_t dma_addr;
 	const char *name;
-	u32 status;
 
 	name = devm_kasprintf(eth->dev, GFP_KERNEL, "qdma%d-buf", id);
 	if (!name)
 		return -ENOMEM;
 
+	buf_size = id ? AIROHA_MAX_PACKET_SIZE / 2 : AIROHA_MAX_PACKET_SIZE;
 	index = of_property_match_string(eth->dev->of_node,
 					 "memory-region-names", name);
 	if (index >= 0) {
@@ -1096,9 +1097,9 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 		/* Compute the number of hw descriptors according to the
 		 * reserved memory size and the payload buffer size
 		 */
-		num_desc = rmem->size / AIROHA_MAX_PACKET_SIZE;
+		num_desc = div_u64(rmem->size, buf_size);
 	} else {
-		size = AIROHA_MAX_PACKET_SIZE * num_desc;
+		size = buf_size * num_desc;
 		if (!dmam_alloc_coherent(eth->dev, size, &dma_addr,
 					 GFP_KERNEL))
 			return -ENOMEM;
@@ -1111,9 +1112,10 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 		return -ENOMEM;
 
 	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
+	/* QDMA0: 2KB. QDMA1: 1KB */
 	airoha_qdma_rmw(qdma, REG_HW_FWD_DSCP_CFG,
 			HW_FWD_DSCP_PAYLOAD_SIZE_MASK,
-			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, 0));
+			FIELD_PREP(HW_FWD_DSCP_PAYLOAD_SIZE_MASK, !!id));
 	airoha_qdma_rmw(qdma, REG_FWD_DSCP_LOW_THR, FWD_DSCP_LOW_THR_MASK,
 			FIELD_PREP(FWD_DSCP_LOW_THR_MASK, 128));
 	airoha_qdma_rmw(qdma, REG_LMGR_INIT_CFG,

-- 
2.49.0


