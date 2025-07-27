Return-Path: <netdev+bounces-210382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF6B12FE5
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C756D1896600
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528F21ADC5;
	Sun, 27 Jul 2025 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kj1oanZu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD282192F5;
	Sun, 27 Jul 2025 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627279; cv=none; b=ZWAYtN9xiaDy4VdEVfUKkcFaKHSlfYdj4hDv/Z0SVK8+bw2VwjJJGToKABxX1BhtD5YVK5YGFk3G3H3LI37iCE69dzz7EJNgdA8m1X1IlQFQlU2AJT7wIvEXuXLkFhScNmOZj1+HjnE1U3tDkA8KX08pcXRcQ8sp+gs/o/bcdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627279; c=relaxed/simple;
	bh=vauFiW74hhbj/jdFSyXcApvOsLoMPGDTXeUdzAXWFkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bpamrPSXL8b+LY5dd98vSmcjI8vLOnciZJiZ8aFZdfANx9/KASN2/HsbdIz2LeD1MZ29tG4HJ/PlAsV88admq83JiahW6lu0cYbYvKUVl1qxj9SFCEGYDGsI6G7WDU1VgU+cMbX9XFLcMwi+/oTbvzA0j6racP23Imm1/VyZa5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kj1oanZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB872C4CEEB;
	Sun, 27 Jul 2025 14:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753627279;
	bh=vauFiW74hhbj/jdFSyXcApvOsLoMPGDTXeUdzAXWFkQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kj1oanZu0LA0sCcBJcz8xHf5regKPNf9HJe4veNHbtttb/z8I9it4WTrpTAs8GYDX
	 B9bw1Hf5LVhCa5oGkOGr9i+XfyMQWZMDYFvEPv2oYYH/ZPoZjGK1hH4fbgRbExmSZn
	 KBBaLBIUq0XDxi53RAf6Kci6F8xw9w9ENUFQR1x6rdOm2h+PQaOiW0mgHphmVDZgtt
	 kJJbhLZJvFXaSo9ZdQ+VYsfiH9y99Qse/RrUxJtXp0bsSPfhbN1HF1UM9wedGMUxwb
	 qBNCLIXeqZYe/5i2QQUf5+N8d7hdHLeShtHgrRQwz4qAE3CIIh/Mz+rPb479E0RF2L
	 LN9B6BR2Qk02A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 27 Jul 2025 16:40:48 +0200
Subject: [PATCH net-next v6 3/7] net: airoha: npu: Add wlan_{send,get}_msg
 NPU callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-airoha-en7581-wlan-offlaod-v6-3-6afad96ac176@kernel.org>
References: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
In-Reply-To: <20250727-airoha-en7581-wlan-offlaod-v6-0-6afad96ac176@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce wlan_send_msg() and wlan_get_msg() NPU wlan callbacks used
by the wlan driver (MT76) to initialize NPU module registers in order to
offload wireless-wired traffic.
This is a preliminary patch to enable wlan flowtable offload for EN7581
SoC with MT76 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 52 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_npu.h | 22 ++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 187ee222fc392f635fd64f5a0db28f14d2e11c53..09e6ede8044eac9bfd03997850dde3b83a4078f2 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -42,6 +42,22 @@
 #define REG_CR_MBQ8_CTRL(_n)		(NPU_MBOX_BASE_ADDR + 0x0b0 + ((_n) << 2))
 #define REG_CR_NPU_MIB(_n)		(NPU_MBOX_BASE_ADDR + 0x140 + ((_n) << 2))
 
+#define NPU_WLAN_BASE_ADDR		0x30d000
+
+#define REG_IRQ_STATUS			(NPU_WLAN_BASE_ADDR + 0x030)
+#define REG_IRQ_RXDONE(_n)		(NPU_WLAN_BASE_ADDR + ((_n) << 2) + 0x034)
+#define NPU_IRQ_RX_MASK(_n)		((_n) == 1 ? BIT(17) : BIT(16))
+
+#define REG_TX_BASE(_n)			(NPU_WLAN_BASE_ADDR + ((_n) << 4) + 0x080)
+#define REG_TX_DSCP_NUM(_n)		(NPU_WLAN_BASE_ADDR + ((_n) << 4) + 0x084)
+#define REG_TX_CPU_IDX(_n)		(NPU_WLAN_BASE_ADDR + ((_n) << 4) + 0x088)
+#define REG_TX_DMA_IDX(_n)		(NPU_WLAN_BASE_ADDR + ((_n) << 4) + 0x08c)
+
+#define REG_RX_BASE(_n)			(NPU_WLAN_BASE_ADDR + ((_n) << 4) + 0x180)
+#define REG_RX_DSCP_NUM(_n)		(NPU_WLAN_BASE_ADDR + ((_n) << 4) + 0x184)
+#define REG_RX_CPU_IDX(_n)		(NPU_WLAN_BASE_ADDR + ((_n) << 4) + 0x188)
+#define REG_RX_DMA_IDX(_n)		(NPU_WLAN_BASE_ADDR + ((_n) << 4) + 0x18c)
+
 #define NPU_TIMER_BASE_ADDR		0x310100
 #define REG_WDT_TIMER_CTRL(_n)		(NPU_TIMER_BASE_ADDR + ((_n) * 0x100))
 #define WDT_EN_MASK			BIT(25)
@@ -420,6 +436,30 @@ static int airoha_npu_wlan_msg_send(struct airoha_npu *npu, int ifindex,
 	return err;
 }
 
+static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
+				   enum airoha_npu_wlan_get_cmd func_id,
+				   u32 *data, gfp_t gfp)
+{
+	struct wlan_mbox_data *wlan_data;
+	int err;
+
+	wlan_data = kzalloc(sizeof(*wlan_data), gfp);
+	if (!wlan_data)
+		return -ENOMEM;
+
+	wlan_data->ifindex = ifindex;
+	wlan_data->func_type = NPU_OP_GET;
+	wlan_data->func_id = func_id;
+
+	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data,
+				  sizeof(*wlan_data));
+	if (!err)
+		*data = wlan_data->data;
+	kfree(wlan_data);
+
+	return err;
+}
+
 static int
 airoha_npu_wlan_set_reserved_memory(struct airoha_npu *npu,
 				    int ifindex, const char *name,
@@ -466,6 +506,15 @@ static int airoha_npu_wlan_init_memory(struct airoha_npu *npu)
 	return airoha_npu_wlan_msg_send(npu, 0, cmd, 0, GFP_KERNEL);
 }
 
+static u32 airoha_npu_wlan_queue_addr_get(struct airoha_npu *npu, int qid,
+					  bool xmit)
+{
+	if (xmit)
+		return REG_TX_BASE(qid + 2);
+
+	return REG_RX_BASE(qid);
+}
+
 struct airoha_npu *airoha_npu_get(struct device *dev, dma_addr_t *stats_addr)
 {
 	struct platform_device *pdev;
@@ -570,6 +619,9 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	npu->ops.ppe_flush_sram_entries = airoha_npu_ppe_flush_sram_entries;
 	npu->ops.ppe_foe_commit_entry = airoha_npu_foe_commit_entry;
 	npu->ops.wlan_init_reserved_memory = airoha_npu_wlan_init_memory;
+	npu->ops.wlan_send_msg = airoha_npu_wlan_msg_send;
+	npu->ops.wlan_get_msg = airoha_npu_wlan_msg_get;
+	npu->ops.wlan_get_queue_addr = airoha_npu_wlan_queue_addr_get;
 
 	npu->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(npu->regmap))
diff --git a/drivers/net/ethernet/airoha/airoha_npu.h b/drivers/net/ethernet/airoha/airoha_npu.h
index 0cb5356b00e90fd45cde90b92d9125d49e51e5e5..bcf6cd5e47ddb6adba060e7f8a32d243505cc046 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -43,6 +43,20 @@ enum airoha_npu_wlan_set_cmd {
 	WLAN_FUNC_SET_WAIT_TOKEN_ID_SIZE,
 };
 
+enum airoha_npu_wlan_get_cmd {
+	WLAN_FUNC_GET_WAIT_NPU_INFO,
+	WLAN_FUNC_GET_WAIT_LAST_RATE,
+	WLAN_FUNC_GET_WAIT_COUNTER,
+	WLAN_FUNC_GET_WAIT_DBG_COUNTER,
+	WLAN_FUNC_GET_WAIT_RXDESC_BASE,
+	WLAN_FUNC_GET_WAIT_WCID_DBG_COUNTER,
+	WLAN_FUNC_GET_WAIT_DMA_ADDR,
+	WLAN_FUNC_GET_WAIT_RING_SIZE,
+	WLAN_FUNC_GET_WAIT_NPU_SUPPORT_MAP,
+	WLAN_FUNC_GET_WAIT_MDC_LOCK_ADDRESS,
+	WLAN_FUNC_GET_WAIT_NPU_VERSION,
+};
+
 struct airoha_npu {
 	struct device *dev;
 	struct regmap *regmap;
@@ -67,6 +81,14 @@ struct airoha_npu {
 					    u32 entry_size, u32 hash,
 					    bool ppe2);
 		int (*wlan_init_reserved_memory)(struct airoha_npu *npu);
+		int (*wlan_send_msg)(struct airoha_npu *npu, int ifindex,
+				     enum airoha_npu_wlan_set_cmd func_id,
+				     u32 data, gfp_t gfp);
+		int (*wlan_get_msg)(struct airoha_npu *npu, int ifindex,
+				    enum airoha_npu_wlan_get_cmd func_id,
+				    u32 *data, gfp_t gfp);
+		u32 (*wlan_get_queue_addr)(struct airoha_npu *npu, int qid,
+					   bool xmit);
 	} ops;
 };
 

-- 
2.50.1


