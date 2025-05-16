Return-Path: <netdev+bounces-190952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D55AB9708
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9845A01CD5
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAB922CBC4;
	Fri, 16 May 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXj4GtWN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11915530C
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382436; cv=none; b=NWJxQZ8yjSs+t0R9cv2fvkikKhLuvI9YgpFbHSYy4LqfWiLaCVxIhZMeiGnH2dVG6jXlK0oZ9uhApyRgGdtGy64iBI0L6y2+0//1SA6/8PzCZDAkG5rn1aaDAjeJI9YluXFL9zt+hylT95/fk46/NjukCvIcuY8bVLhLwVt2xas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382436; c=relaxed/simple;
	bh=sJyp0PS6YswFZq8eBg4a4xjrjdQIP1pQUNaiWS5g9jI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aihLMu7T/tIzScZg73Omijznmvr/NmHMTBSpVvQsW/T3A4nsyW5ZFa4PDMWNqj8LBa8jxkI4U46NN5lyPkC7UHXBfAh9OGKkFKdMsAYTtPPOjW/hwfSchQOh3Q0aI0HD+RE1fUz7jNdAf6OrsaNzhJ7uECmS5Ry04ZJR15p0xN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXj4GtWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7C0C4CEED;
	Fri, 16 May 2025 08:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747382435;
	bh=sJyp0PS6YswFZq8eBg4a4xjrjdQIP1pQUNaiWS5g9jI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZXj4GtWN6svSJzxZ82ItTUOh8LIr0bs9Fbs6/qKf43ALvvF8uuKdi3dmdNYnyWtLo
	 yQ1ec+uZu90SJkImmkX9ogO70BGhzeWvKlVsIGRFUZjXgU7UGdrPNlGjvWKuf4te8w
	 MxriXLLkBNZaBRbNKHo6a6F0r4n+DDPUJ1tReS5sXPNPvV8vU6q0b+g7ugqVjfSyiG
	 BBkGihAMlOhEjQZaRxjPHDQhjL1qSDer/kVQHpzKOpRxXnhJB3cz4ZzsZJalYcx7WK
	 cGkImN6UoxNH5O3Jq14Cet0IWFIVotNqe9lC5VsCH1mqPrZTke8dekZxobbtv+JAsA
	 Rwsg2rrWQCk7g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 16 May 2025 09:59:59 +0200
Subject: [PATCH net-next v2 1/3] net: airoha: npu: Move memory allocation
 in airoha_npu_send_msg() caller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-airoha-en7581-flowstats-v2-1-06d5fbf28984@kernel.org>
References: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
In-Reply-To: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Move ppe_mbox_data struct memory allocation from airoha_npu_send_msg
routine to the caller one. This is a preliminary patch to enable wlan NPU
offloading and flow counter stats support.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 126 ++++++++++++++++++-------------
 1 file changed, 72 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index ead0625e781f57cd7c5883b6dd3d441db62292d3..51c6fbd7b7b772baf8e05b10250d37416fa36f39 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -124,17 +124,12 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 	u16 core = 0; /* FIXME */
 	u32 val, offset = core << 4;
 	dma_addr_t dma_addr;
-	void *addr;
 	int ret;
 
-	addr = kmemdup(p, size, GFP_ATOMIC);
-	if (!addr)
-		return -ENOMEM;
-
-	dma_addr = dma_map_single(npu->dev, addr, size, DMA_TO_DEVICE);
+	dma_addr = dma_map_single(npu->dev, p, size, DMA_TO_DEVICE);
 	ret = dma_mapping_error(npu->dev, dma_addr);
 	if (ret)
-		goto out;
+		return ret;
 
 	spin_lock_bh(&npu->cores[core].lock);
 
@@ -155,8 +150,6 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 	spin_unlock_bh(&npu->cores[core].lock);
 
 	dma_unmap_single(npu->dev, dma_addr, size, DMA_TO_DEVICE);
-out:
-	kfree(addr);
 
 	return ret;
 }
@@ -261,76 +254,101 @@ static irqreturn_t airoha_npu_wdt_handler(int irq, void *core_instance)
 
 static int airoha_npu_ppe_init(struct airoha_npu *npu)
 {
-	struct ppe_mbox_data ppe_data = {
-		.func_type = NPU_OP_SET,
-		.func_id = PPE_FUNC_SET_WAIT_HWNAT_INIT,
-		.init_info = {
-			.ppe_type = PPE_TYPE_L2B_IPV4_IPV6,
-			.wan_mode = QDMA_WAN_ETHER,
-		},
-	};
+	struct ppe_mbox_data *ppe_data;
+	int err;
+
+	ppe_data = kzalloc(sizeof(*ppe_data), GFP_KERNEL);
+	if (!ppe_data)
+		return -ENOMEM;
 
-	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
-				   sizeof(struct ppe_mbox_data));
+	ppe_data->func_type = NPU_OP_SET;
+	ppe_data->func_id = PPE_FUNC_SET_WAIT_HWNAT_INIT;
+	ppe_data->init_info.ppe_type = PPE_TYPE_L2B_IPV4_IPV6;
+	ppe_data->init_info.wan_mode = QDMA_WAN_ETHER;
+
+	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
+				  sizeof(*ppe_data));
+	kfree(ppe_data);
+
+	return err;
 }
 
 static int airoha_npu_ppe_deinit(struct airoha_npu *npu)
 {
-	struct ppe_mbox_data ppe_data = {
-		.func_type = NPU_OP_SET,
-		.func_id = PPE_FUNC_SET_WAIT_HWNAT_DEINIT,
-	};
+	struct ppe_mbox_data *ppe_data;
+	int err;
+
+	ppe_data = kzalloc(sizeof(*ppe_data), GFP_KERNEL);
+	if (!ppe_data)
+		return -ENOMEM;
+
+	ppe_data->func_type = NPU_OP_SET;
+	ppe_data->func_id = PPE_FUNC_SET_WAIT_HWNAT_DEINIT;
 
-	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
-				   sizeof(struct ppe_mbox_data));
+	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
+				  sizeof(*ppe_data));
+	kfree(ppe_data);
+
+	return err;
 }
 
 static int airoha_npu_ppe_flush_sram_entries(struct airoha_npu *npu,
 					     dma_addr_t foe_addr,
 					     int sram_num_entries)
 {
-	struct ppe_mbox_data ppe_data = {
-		.func_type = NPU_OP_SET,
-		.func_id = PPE_FUNC_SET_WAIT_API,
-		.set_info = {
-			.func_id = PPE_SRAM_RESET_VAL,
-			.data = foe_addr,
-			.size = sram_num_entries,
-		},
-	};
+	struct ppe_mbox_data *ppe_data;
+	int err;
+
+	ppe_data = kzalloc(sizeof(*ppe_data), GFP_KERNEL);
+	if (!ppe_data)
+		return -ENOMEM;
+
+	ppe_data->func_type = NPU_OP_SET;
+	ppe_data->func_id = PPE_FUNC_SET_WAIT_API;
+	ppe_data->set_info.func_id = PPE_SRAM_RESET_VAL;
+	ppe_data->set_info.data = foe_addr;
+	ppe_data->set_info.size = sram_num_entries;
+
+	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
+				  sizeof(*ppe_data));
+	kfree(ppe_data);
 
-	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
-				   sizeof(struct ppe_mbox_data));
+	return err;
 }
 
 static int airoha_npu_foe_commit_entry(struct airoha_npu *npu,
 				       dma_addr_t foe_addr,
 				       u32 entry_size, u32 hash, bool ppe2)
 {
-	struct ppe_mbox_data ppe_data = {
-		.func_type = NPU_OP_SET,
-		.func_id = PPE_FUNC_SET_WAIT_API,
-		.set_info = {
-			.data = foe_addr,
-			.size = entry_size,
-		},
-	};
+	struct ppe_mbox_data *ppe_data;
 	int err;
 
-	ppe_data.set_info.func_id = ppe2 ? PPE2_SRAM_SET_ENTRY
-					 : PPE_SRAM_SET_ENTRY;
+	ppe_data = kzalloc(sizeof(*ppe_data), GFP_ATOMIC);
+	if (!ppe_data)
+		return -ENOMEM;
+
+	ppe_data->func_type = NPU_OP_SET;
+	ppe_data->func_id = PPE_FUNC_SET_WAIT_API;
+	ppe_data->set_info.data = foe_addr;
+	ppe_data->set_info.size = entry_size;
+	ppe_data->set_info.func_id = ppe2 ? PPE2_SRAM_SET_ENTRY
+					  : PPE_SRAM_SET_ENTRY;
 
-	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
-				  sizeof(struct ppe_mbox_data));
+	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
+				  sizeof(*ppe_data));
 	if (err)
-		return err;
+		goto out;
+
+	ppe_data->set_info.func_id = PPE_SRAM_SET_VAL;
+	ppe_data->set_info.data = hash;
+	ppe_data->set_info.size = sizeof(u32);
 
-	ppe_data.set_info.func_id = PPE_SRAM_SET_VAL;
-	ppe_data.set_info.data = hash;
-	ppe_data.set_info.size = sizeof(u32);
+	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
+				  sizeof(*ppe_data));
+out:
+	kfree(ppe_data);
 
-	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
-				   sizeof(struct ppe_mbox_data));
+	return err;
 }
 
 struct airoha_npu *airoha_npu_get(struct device *dev)

-- 
2.49.0


