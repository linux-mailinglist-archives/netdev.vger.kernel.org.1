Return-Path: <netdev+bounces-212490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9FEB2107E
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2305686482
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70437296BAA;
	Mon, 11 Aug 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdUIxxWn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868B296BA7;
	Mon, 11 Aug 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926337; cv=none; b=bOVBce36AYj9ro7toY6naa0BhLOB10pv9GFOs53odU0Wgr5HjGs50nOEZz2F1HaC2fquYeFiW1VChW/c66UqbLiYVeRJpg4/j5DaywSmORAbce0mzogA3PfQQ4nooBSAbck8oPUpSJYmiwJ8LYyItuhiU+SXP7hlcUNSZwft9ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926337; c=relaxed/simple;
	bh=a5gF8Qfbhqh9LNW8eSQfRf6Gu603MIH17Dx0nWsWDUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+ZpOyLHQBynNPlPHq0tASYB6Xpyie8skB/RzHkuAWHL27MoYI2sasf7bwvJ6+m4NLWcrO04X7HgUXKa/P1iJK1aI6cYUQYni02RM1iWi0Y+MtzjGKELHt1RbVCtjuXpV9zbYJpLtCC5bHjPWPZRNlZTO6fpyUa8w7f4kWNu7hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdUIxxWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97998C4CEED;
	Mon, 11 Aug 2025 15:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926336;
	bh=a5gF8Qfbhqh9LNW8eSQfRf6Gu603MIH17Dx0nWsWDUE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CdUIxxWncoesGOOG/pI3RQL05yHxFf7Sgqw1G7I3iSUXc4FYQExXKVW0c3OPKDJJn
	 CrDkQtnoj8H9BmkVbFnQODYS6N2BJ26Tzjbpc5W9p30m1pUW3hGIzKkQDNOUoaIvGl
	 TfJqVPMaC/k/FI72k4Iw/2Q96xNcvwR4Wta7SMXIYv+wDtPl2cFCUntymi7utDWKY9
	 ZT5Hq0lIrEBcqKCqDVI2kQ80lbJl93ZK257d77823qScF84udTFPszYBVUTFqEjTmH
	 l/lXkeI20hVBlp0DEWskJq0BSB+8I6nU99l5ovg2OxnjUK0X611T6Z3DGdyPaBnsc1
	 UZZranxSyY9gw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 11 Aug 2025 17:31:37 +0200
Subject: [PATCH net-next v7 2/7] net: airoha: npu: Add NPU wlan memory
 initialization commands
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-airoha-en7581-wlan-offlaod-v7-2-58823603bb4e@kernel.org>
References: <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
In-Reply-To: <20250811-airoha-en7581-wlan-offlaod-v7-0-58823603bb4e@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce wlan_init_reserved_memory callback used by MT76 driver during
NPU wlan offloading setup.
This is a preliminary patch to enable wlan flowtable offload for EN7581
SoC with MT76 driver.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 82 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_npu.h | 38 +++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index a802f95df99dd693293b1c0cc0fbf09afab2c835..731e0119d988cf1e1663f376ce6fc9971f79f4a9 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -124,6 +124,13 @@ struct ppe_mbox_data {
 	};
 };
 
+struct wlan_mbox_data {
+	u32 ifindex:4;
+	u32 func_type:4;
+	u32 func_id;
+	DECLARE_FLEX_ARRAY(u8, d);
+};
+
 static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 			       void *p, int size)
 {
@@ -390,6 +397,80 @@ static int airoha_npu_stats_setup(struct airoha_npu *npu,
 	return err;
 }
 
+static int airoha_npu_wlan_msg_send(struct airoha_npu *npu, int ifindex,
+				    enum airoha_npu_wlan_set_cmd func_id,
+				    void *data, int data_len, gfp_t gfp)
+{
+	struct wlan_mbox_data *wlan_data;
+	int err, len;
+
+	len = sizeof(*wlan_data) + data_len;
+	wlan_data = kzalloc(len, gfp);
+	if (!wlan_data)
+		return -ENOMEM;
+
+	wlan_data->ifindex = ifindex;
+	wlan_data->func_type = NPU_OP_SET;
+	wlan_data->func_id = func_id;
+	memcpy(wlan_data->d, data, data_len);
+
+	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data, len);
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
+	u32 val;
+
+	err = of_reserved_mem_region_to_resource_byname(dev->of_node, name,
+							&res);
+	if (err)
+		return err;
+
+	val = res.start;
+	return airoha_npu_wlan_msg_send(npu, ifindex, func_id, &val,
+					sizeof(val), GFP_KERNEL);
+}
+
+static int airoha_npu_wlan_init_memory(struct airoha_npu *npu)
+{
+	enum airoha_npu_wlan_set_cmd cmd = WLAN_FUNC_SET_WAIT_NPU_BAND0_ONCPU;
+	u32 val = 0;
+	int err;
+
+	err = airoha_npu_wlan_msg_send(npu, 1, cmd, &val, sizeof(val),
+				       GFP_KERNEL);
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
+	return airoha_npu_wlan_msg_send(npu, 0, cmd, &val, sizeof(val),
+					GFP_KERNEL);
+}
+
 struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
 {
 	struct platform_device *pdev;
@@ -493,6 +574,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	npu->ops.ppe_deinit = airoha_npu_ppe_deinit;
 	npu->ops.ppe_flush_sram_entries = airoha_npu_ppe_flush_sram_entries;
 	npu->ops.ppe_foe_commit_entry = airoha_npu_foe_commit_entry;
+	npu->ops.wlan_init_reserved_memory = airoha_npu_wlan_init_memory;
 
 	npu->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(npu->regmap))
diff --git a/drivers/net/ethernet/airoha/airoha_npu.h b/drivers/net/ethernet/airoha/airoha_npu.h
index 98ec3be74ce450bf4fa8bc771d19d174e8c157e5..0cb5356b00e90fd45cde90b92d9125d49e51e5e5 100644
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
+	WLAN_FUNC_SET_WAIT_TOKEN_ID_SIZE,
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


