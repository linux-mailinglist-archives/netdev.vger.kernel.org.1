Return-Path: <netdev+bounces-190514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC87AB7268
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 19:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2753A3491
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CE27FD44;
	Wed, 14 May 2025 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCiyJIUg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC351624EA
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747242620; cv=none; b=gSZFSBiYGmNPP9zF64d0HulSU1r/Z/Cn5Zd7hIgPRjrmGOw388Mkrhy0oqet/QU6qktWMUcGV/ixDcOs+apExDPZxAotymjLECISxCVxzw/I/iJ+JfI6+2rCtz5nRRwnviR8Mn3M+KGwmTdaqDMMg+C0SHugvk5mZcEs4jhog5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747242620; c=relaxed/simple;
	bh=jO1c6Omlx+fsF4GHMQV9/rCFGaCws6F9qRa2fiBlvu4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TumtAMI3r/C8qa94PIAHEwk5odKsLuog0NyXob86PxSBA/NwIY/RjgckNKifD55EV2L3uT0zSyYK3aePFp1yDQ26RyshB20eCossny7XSqYSXvda3XVyVUM/ea6Q6h0NxT54CYADc8DeMpvZ+ujGjRBDwr9s5L10oW6TBfcpGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCiyJIUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC2BC4CEE3;
	Wed, 14 May 2025 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747242618;
	bh=jO1c6Omlx+fsF4GHMQV9/rCFGaCws6F9qRa2fiBlvu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CCiyJIUgKiLhD1m2ZrwxCKNR7li+A+1nxrJ8RNMJxE4bDZ0lAK3InQY7f2qdcSBFf
	 /zXKoNbBTAxsvCtjuqO6n3Yj8OXQjD5ZfWWh5WVwDtuCj9JDJo26vdGPaJkxHtga0Z
	 r1dArVYtC7X/dodQycWdP0AXMUltZtv0FvzHKyu2UQCo0L03cRD3zAZCfhXOmSTNoK
	 2uEQyfUvt1S+0InRQBFpEgQE2xvIe7BlGtDSQMP5qyz86AmtL1SW7jF7lrBbk++8uS
	 bK6q8fO3TQUYMVm2P5eEJj/nZLJ84HlMlWPhVMeILCisD4zavAMeDhoA+vDenRC//l
	 yAFi8/6y4vQrw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 14 May 2025 19:09:57 +0200
Subject: [PATCH net-next 1/2] net: airoha: npu: Move memory allocation in
 airoha_npu_send_msg() caller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-airoha-en7581-flowstats-v1-1-c00ede12a2ca@kernel.org>
References: <20250514-airoha-en7581-flowstats-v1-0-c00ede12a2ca@kernel.org>
In-Reply-To: <20250514-airoha-en7581-flowstats-v1-0-c00ede12a2ca@kernel.org>
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
 drivers/net/ethernet/airoha/airoha_npu.c | 123 ++++++++++++++++++-------------
 1 file changed, 70 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index ead0625e781f57cd7c5883b6dd3d441db62292d3..2371677296aff1382f6e0516a8798739029e03fb 100644
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
@@ -261,76 +254,100 @@ static irqreturn_t airoha_npu_wdt_handler(int irq, void *core_instance)
 
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
 
-	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
-				   sizeof(struct ppe_mbox_data));
+	ppe_data = kzalloc(sizeof(*ppe_data), GFP_KERNEL);
+	if (!ppe_data)
+		return -ENOMEM;
+
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
 
-	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
-				   sizeof(struct ppe_mbox_data));
+	ppe_data->func_type = NPU_OP_SET;
+	ppe_data->func_id = PPE_FUNC_SET_WAIT_API;
+	ppe_data->set_info.func_id = PPE_SRAM_RESET_VAL;
+	ppe_data->set_info.data = foe_addr;
+	ppe_data->set_info.size = sram_num_entries;
+
+	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
+				  sizeof(*ppe_data));
+	kfree(ppe_data);
+
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
 		return err;
 
-	ppe_data.set_info.func_id = PPE_SRAM_SET_VAL;
-	ppe_data.set_info.data = hash;
-	ppe_data.set_info.size = sizeof(u32);
+	ppe_data->set_info.func_id = PPE_SRAM_SET_VAL;
+	ppe_data->set_info.data = hash;
+	ppe_data->set_info.size = sizeof(u32);
+
+	err = airoha_npu_send_msg(npu, NPU_FUNC_PPE, ppe_data,
+				  sizeof(*ppe_data));
+	kfree(ppe_data);
 
-	return airoha_npu_send_msg(npu, NPU_FUNC_PPE, &ppe_data,
-				   sizeof(struct ppe_mbox_data));
+	return err;
 }
 
 struct airoha_npu *airoha_npu_get(struct device *dev)

-- 
2.49.0


