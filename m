Return-Path: <netdev+bounces-203045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5915AF0680
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBCC445525
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C08302053;
	Tue,  1 Jul 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SERKQbIY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E018125D6
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408641; cv=none; b=khzGUhaWUzlnYjb0wjK3/Ds8TYp/BZSliCDddxcvM9GhpXs13bEX9HTy5EVdLTIRBy7xXK0p3qlBoc8e1IRWRha6CFnfEWNujRF4ArZkN8lBx3mkxWSGIySCx7dEpTAepky+TEVHUUvdUmoHxePRMiqUsEptXmprvE0rZy8BID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408641; c=relaxed/simple;
	bh=L4tJw4hsttorpP+qYBOR1FpFss4EbxB4am5UrHANugQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2lfsr2GLBU/VA0/ew+PJTdqusPUYkdGx87t2exBOveASjRzd8rNq/30oA382DMnwBvm+eoQiHctjjTeBo7VbyhFFCoXm0GgU+0QRM6Bfx/dISjmjkvLFNrrIrTadvfNcNc68sjHrqn0FK7mijYHGpbCkAZGKDKjuS7istOUR2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SERKQbIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E154FC4CEEB;
	Tue,  1 Jul 2025 22:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408641;
	bh=L4tJw4hsttorpP+qYBOR1FpFss4EbxB4am5UrHANugQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SERKQbIYvexa87rKN5AKXXF9n0mPV4PJF8rqWbsgSfqj5njfCItuwQXfS/CTUkXlA
	 EmBxgkC5hLJ5DAUxCON0wSPU3pC2XAVDjzCgTyGIEcn6UT2439OKC6SgcswRr+x7nD
	 Lb7qcgfnPE5CUS+H9CvV//EDbG445SUDPnT3z04LiReiIngtYGqwQdUZcVyKo1KDlY
	 eGSkM4D+xhy7ofSMFMOLfQScV3y3OfQ3Ju0hRWhRLDkuzsLUk99sOsuesuzUXtC6IT
	 AEO6ePy6+DFgW8slSeTKdFKq/ARAUQH1MIbWFgtTWPafcZzg9BqdbXsTbOPoHxJXIL
	 w69LeEeQg7Pcg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 02 Jul 2025 00:23:30 +0200
Subject: [PATCH net-next 1/6] net: airoha: npu: Add NPU wlan memory
 initialization commands
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-airoha-en7581-wlan-offlaod-v1-1-803009700b38@kernel.org>
References: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
In-Reply-To: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce wlan_init_reserved_memory callback used by MT76 driver during
NPU wlan offloading setup.
This is a preliminary patch to enable wlan flowtable offload for EN7581
SoC with MT76 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 123 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_npu.h |   1 +
 2 files changed, 124 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 0e5b8c21b9aa8bacdfb2e1572afe4324003e8279..f8057072cfd7bb114e34af176aabaa1ef9f052c0 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -124,6 +124,54 @@ struct ppe_mbox_data {
 	};
 };
 
+enum {
+	WLAN_FUNC_SET_WAIT_PCIE_ADDR,
+	WLAN_FUNC_SET_WAIT_DESC,
+	WLAN_FUNC_SET_WAIT_NPU_INIT_DONE,
+	WLAN_FUNC_SET_WAIT_TRAN_TO_CPU,
+	WLAN_FUNC_SET_WAIT_BA_WIN_SIZE,
+	WLAN_FUNC_SET_WAIT_DRIVER_MODEL,
+	WLAN_FUNC_SET_WAIT_DEL_STA,
+	WLAN_FUNC_SET_WAIT_DRAM_BA_NODE_ADDR,
+	WLAN_FUNC_SET_WAIT_PKT_BUF_ADDR,
+	WLAN_FUNC_SET_WAIT_IS_TEST_NOBA,
+	WLAN_FUNC_SET_WAIT_FLUSHONE_TIMEOUT,
+	WLAN_FUNC_SET_WAIT_FLUSHALL_TIMEOUT,
+	WLAN_FUNC_SET_WAIT_IS_FORCE_TO_CPU,
+	WLAN_FUNC_SET_WAIT_PCIE_STATE,
+	WLAN_FUNC_SET_WAIT_PCIE_PORT_TYPE,
+	WLAN_FUNC_SET_WAIT_ERROR_RETRY_TIMES,
+	WLAN_FUNC_SET_WAIT_BAR_INFO,
+	WLAN_FUNC_SET_WAIT_FAST_FLAG,
+	WLAN_FUNC_SET_WAIT_NPU_BAND0_ONCPU,
+	WLAN_FUNC_SET_WAIT_TX_RING_PCIE_ADDR,
+	WLAN_FUNC_SET_WAIT_TX_DESC_HW_BASE,
+	WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
+	WLAN_FUNC_SET_WAIT_RX_RING_FOR_TXDONE_HW_BASE,
+	WLAN_FUNC_SET_WAIT_TX_PKT_BUF_ADDR,
+	WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR,
+	WLAN_FUNC_SET_WAIT_INODE_DEBUG_FLAG,
+	WLAN_FUNC_SET_WAIT_INODE_HW_CFG_INFO,
+	WLAN_FUNC_SET_WAIT_INODE_STOP_ACTION,
+	WLAN_FUNC_SET_WAIT_INODE_PCIE_SWAP,
+	WLAN_FUNC_SET_WAIT_RATELIMIT_CTRL,
+	WLAN_FUNC_SET_WAIT_HWNAT_INIT,
+	WLAN_FUNC_SET_WAIT_ARHT_CHIP_INFO,
+	WLAN_FUNC_SET_WAIT_TX_BUF_CHECK_ADDR,
+	WLAN_FUNC_SET_WAIT_DEBUG_ARRAY_ADDR,
+};
+
+#define WLAN_MAX_STATS_SIZE	4408
+struct wlan_mbox_data {
+	u32 ifindex:4;
+	u32 func_type:4;
+	u32 func_id;
+	union {
+		u32 data;
+		u8 stats[WLAN_MAX_STATS_SIZE];
+	};
+};
+
 static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 			       void *p, int size)
 {
@@ -390,6 +438,80 @@ static int airoha_npu_stats_setup(struct airoha_npu *npu,
 	return err;
 }
 
+static int airoha_npu_wlan_send_msg(struct airoha_npu *npu, int ifindex,
+				    int func_id, u32 data, gfp_t gfp)
+{
+	struct wlan_mbox_data *wlan_data;
+	int err;
+
+	wlan_data = kzalloc(sizeof(*wlan_data), gfp);
+	if (!wlan_data)
+		return -ENOMEM;
+
+	wlan_data->ifindex = ifindex;
+	wlan_data->func_type = NPU_OP_SET;
+	wlan_data->func_id = func_id;
+	wlan_data->data = data;
+
+	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data,
+				  sizeof(*wlan_data));
+	kfree(wlan_data);
+
+	return err;
+}
+
+static int airoha_npu_wlan_set_reserved_memory(struct airoha_npu *npu,
+					       int ifindex, const char *name,
+					       int func_id)
+{
+	struct device *dev = npu->dev;
+	struct reserved_mem *rmem;
+	struct device_node *np;
+	int index;
+
+	index = of_property_match_string(dev->of_node, "memory-region-names",
+					 name);
+	if (index < 0)
+		return -ENODEV;
+
+	np = of_parse_phandle(dev->of_node, "memory-region", index);
+	if (!np)
+		return -ENODEV;
+
+	rmem = of_reserved_mem_lookup(np);
+	of_node_put(np);
+
+	return airoha_npu_wlan_send_msg(npu, ifindex, func_id, rmem->base,
+					GFP_KERNEL);
+}
+
+static int airoha_npu_wlan_init_memory(struct airoha_npu *npu)
+{
+	int err, cmd = WLAN_FUNC_SET_WAIT_NPU_BAND0_ONCPU;
+
+	err = airoha_npu_wlan_send_msg(npu, 1, cmd, 0, GFP_KERNEL);
+	if (err)
+		return err;
+
+	cmd = WLAN_FUNC_SET_WAIT_TX_BUF_CHECK_ADDR;
+	err = airoha_npu_wlan_set_reserved_memory(npu, 0, "tx-bufid", cmd);
+	if (err)
+		return err;
+
+	cmd = WLAN_FUNC_SET_WAIT_PKT_BUF_ADDR;
+	err = airoha_npu_wlan_set_reserved_memory(npu, 0, "pkt", cmd);
+	if (err)
+		return err;
+
+	cmd = WLAN_FUNC_SET_WAIT_TX_PKT_BUF_ADDR;
+	err = airoha_npu_wlan_set_reserved_memory(npu, 0, "tx-pkt", cmd);
+	if (err)
+		return err;
+
+	cmd = WLAN_FUNC_SET_WAIT_IS_FORCE_TO_CPU;
+	return airoha_npu_wlan_send_msg(npu, 0, cmd, 0, GFP_KERNEL);
+}
+
 struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
 {
 	struct platform_device *pdev;
@@ -493,6 +615,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	npu->ops.ppe_deinit = airoha_npu_ppe_deinit;
 	npu->ops.ppe_flush_sram_entries = airoha_npu_ppe_flush_sram_entries;
 	npu->ops.ppe_foe_commit_entry = airoha_npu_foe_commit_entry;
+	npu->ops.wlan_init_reserved_memory = airoha_npu_wlan_init_memory;
 
 	npu->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(npu->regmap))
diff --git a/drivers/net/ethernet/airoha/airoha_npu.h b/drivers/net/ethernet/airoha/airoha_npu.h
index 98ec3be74ce450bf4fa8bc771d19d174e8c157e5..242f0d15b2f7c262daaf7bb78ee386ccc8a0433d 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -29,6 +29,7 @@ struct airoha_npu {
 					    dma_addr_t foe_addr,
 					    u32 entry_size, u32 hash,
 					    bool ppe2);
+		int (*wlan_init_reserved_memory)(struct airoha_npu *npu);
 	} ops;
 };
 

-- 
2.50.0


