Return-Path: <netdev+bounces-206734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F22B043FF
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB571888618
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C7269D16;
	Mon, 14 Jul 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smX1IeC0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FD2620FA;
	Mon, 14 Jul 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506742; cv=none; b=S8lXU9QGQDZRCEfVbJkEqCX8b/DMyQhmkM1EzHTcBrXAZt277oNzaRzNvvOtQShRM7Fqm91grPUcGaJsODfvTyE4CB4T2jgffgcnOTl8luA3s77fAKjFfB0fjTAboRIVpWsxQc11Y7Pfyi+U2ythicPm8xktzdzNSyXKOeIaU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506742; c=relaxed/simple;
	bh=mt8GmlNMdRJGO4Ucaja9GT8LlCzPjyTro3ntkOcoqF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hez7063cw0UDg9Ja4cimDnrG1hAa0R118qkg6VH5wGas6invLU3dDtvK1YJfCd7Sg+B4teJ9e2ffN93LKJDoJ7EqcFaH7WzeOB7XORenEFJ9Pssdvj2s1Y+t9IkHwhv4bY1EwhqQAOVNYQeS4UnqGWdbnykI8NIOs2IUj/UAkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smX1IeC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C23C4CEED;
	Mon, 14 Jul 2025 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506742;
	bh=mt8GmlNMdRJGO4Ucaja9GT8LlCzPjyTro3ntkOcoqF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=smX1IeC0UNBZluYlsyh4fBXIwhxtG02gOtG0S1T3uVV24uZlbmM/MT8iNDyssIR3w
	 MhHGAQSDbj1xUx2nF12F5mYgI0foREHBnZdV9KQGVBG+sx8WJKV9K4b1+qurx3jEt3
	 DCrPn4QbsAG6is35WsIXOjjGPpGPxtukujUBVkfPAfqcFEPaNp8euXEQaRZMpXZ1ac
	 JJYy9hGy80fl/g0AnOQpGzWYzjbgeuCmojdLyF5BLZAHWianXynxzJY7SBcPjf/yA9
	 OzoA7qeS3FlTzT6wa9StKS3y0KOqiVwkUeTiyInMblNa9t8SKL3fyzlzeLFmSwt6gi
	 YhPgAHQkjZdwQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 14 Jul 2025 17:25:15 +0200
Subject: [PATCH net-next v3 2/7] net: airoha: npu: Add NPU wlan memory
 initialization commands
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-airoha-en7581-wlan-offlaod-v3-2-80abf6aae9e4@kernel.org>
References: <20250714-airoha-en7581-wlan-offlaod-v3-0-80abf6aae9e4@kernel.org>
In-Reply-To: <20250714-airoha-en7581-wlan-offlaod-v3-0-80abf6aae9e4@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce wlan_init_reserved_memory callback used by MT76 driver during
NPU wlan offloading setup.
This is a preliminary patch to enable wlan flowtable offload for EN7581
SoC with MT76 driver.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 81 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_npu.h | 38 +++++++++++++++
 2 files changed, 119 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 4e8deb87f7514b2d17d877d485ffb3bce1ae03be..bcf7f5e645f7ec5e3e8c7474f6715f4810d192dc 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -124,6 +124,17 @@ struct ppe_mbox_data {
 	};
 };
 
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
@@ -390,6 +401,75 @@ static int airoha_npu_stats_setup(struct airoha_npu *npu,
 	return err;
 }
 
+static int airoha_npu_wlan_msg_send(struct airoha_npu *npu, int ifindex,
+				    enum airoha_npu_wlan_set_cmd func_id,
+				    u32 data, gfp_t gfp)
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
+static int
+airoha_npu_wlan_set_reserved_memory(struct airoha_npu *npu,
+				    int ifindex, const char *name,
+				    enum airoha_npu_wlan_set_cmd func_id)
+{
+	struct device *dev = npu->dev;
+	struct resource res;
+	int err;
+
+	err = of_reserved_mem_region_to_resource_byname(dev->of_node, name,
+							&res);
+	if (err)
+		return err;
+
+	return airoha_npu_wlan_msg_send(npu, ifindex, func_id, res.start,
+					GFP_KERNEL);
+}
+
+static int airoha_npu_wlan_init_memory(struct airoha_npu *npu)
+{
+	enum airoha_npu_wlan_set_cmd cmd = WLAN_FUNC_SET_WAIT_NPU_BAND0_ONCPU;
+	int err;
+
+	err = airoha_npu_wlan_msg_send(npu, 1, cmd, 0, GFP_KERNEL);
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
+	return airoha_npu_wlan_msg_send(npu, 0, cmd, 0, GFP_KERNEL);
+}
+
 struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
 {
 	struct platform_device *pdev;
@@ -492,6 +572,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	npu->ops.ppe_deinit = airoha_npu_ppe_deinit;
 	npu->ops.ppe_flush_sram_entries = airoha_npu_ppe_flush_sram_entries;
 	npu->ops.ppe_foe_commit_entry = airoha_npu_foe_commit_entry;
+	npu->ops.wlan_init_reserved_memory = airoha_npu_wlan_init_memory;
 
 	npu->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(npu->regmap))
diff --git a/drivers/net/ethernet/airoha/airoha_npu.h b/drivers/net/ethernet/airoha/airoha_npu.h
index 98ec3be74ce450bf4fa8bc771d19d174e8c157e5..58f4ee04e17161acbe513779638c23fe79a83a78 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -6,6 +6,43 @@
 
 #define NPU_NUM_CORES		8
 
+enum airoha_npu_wlan_set_cmd {
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
 struct airoha_npu {
 	struct device *dev;
 	struct regmap *regmap;
@@ -29,6 +66,7 @@ struct airoha_npu {
 					    dma_addr_t foe_addr,
 					    u32 entry_size, u32 hash,
 					    bool ppe2);
+		int (*wlan_init_reserved_memory)(struct airoha_npu *npu);
 	} ops;
 };
 

-- 
2.50.1


