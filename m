Return-Path: <netdev+bounces-204346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE867AFA1F4
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 23:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A373BA6EC
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA99523B61C;
	Sat,  5 Jul 2025 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSbv7rt6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8342F136349;
	Sat,  5 Jul 2025 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751749813; cv=none; b=h0knXjvyPOlMxppUXhksCpazTjFWbJT80LMw+W0KAyLl0xxRcY4HVazgpM6kEd6sHuwKnHJ56aLjk+TfDGQTZ19AlXDtydmAEWIfVGvboFQOuORjhodxbgZFaSrsMCSuqpt3qGCMWo8q/7tcXZcm2NSGYGdk6ACfRKIbLpLRmAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751749813; c=relaxed/simple;
	bh=BERWwBj60rOtpA8UFFTiNE6VRZpLv15psHW96sdyx5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxBOHR0kRPD2cEQDrU7FRDz6+w+38+eBhFGdHpjr7xbTN28Qd3x5HHLXNK6h5mJ9I599Xuj6x58EXmAYaFrze4hHbwi8OD5gHb54V3zJgVjt04jOBCBVHc2FQtwi1t/7ETTl51XOV9P+eJEWgSDsEujkGDL4QyOpufopqTvza0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSbv7rt6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65BBC4CEE7;
	Sat,  5 Jul 2025 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751749813;
	bh=BERWwBj60rOtpA8UFFTiNE6VRZpLv15psHW96sdyx5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cSbv7rt6+B5XvAodk/5o1FQnpeldug2OJkTrmC3W2zJhAfPatCAEeR0Qd99pbUZGH
	 6jJQ3q8jvoJAjtlvyHlckF3wFuf9XMS7NlClEPVUUj8AUMaKWKfjbEbwtJCB7kOk1+
	 esW0uDnxyucVDhCARfM72qFqIi92wEQPGSHHjgQdGwpv6Dnv0/9jXmHqA5AKUOXJnj
	 mGQ+3n74FNSv8RmxBUgkJHANx0Se7lgjU6V3llb+97L1k8tYYKUfTMC11Pr/AjWB65
	 Ia2vJKtsCbiJGXTHQunlgzSJbR/mFvr+en5TJfKKRlPwc/1Yjff+iylvE4pHpiIkL9
	 uD2VoF56tankQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 05 Jul 2025 23:09:47 +0200
Subject: [PATCH net-next v2 3/7] net: airoha: npu: Add wlan_{send,get}_msg
 NPU callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250705-airoha-en7581-wlan-offlaod-v2-3-3cf32785e381@kernel.org>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
In-Reply-To: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce wlan_send_msg() and wlan_get_msg() NPU wlan callbacks used
by the wlan driver (MT76) to initialize NPU module registers in order to
offload wireless-wired traffic.
This is a preliminary patch to enable wlan flowtable offload for EN7581
SoC with MT76 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 58 ++++++++++++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_npu.h | 21 ++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 8c5031a00f54ce64ded5950dafefe5f28d54e79a..a1568233edcb180c7d19245051f0c409664b5242 100644
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
@@ -131,6 +147,12 @@ struct wlan_mbox_data {
 	u32 func_id;
 	union {
 		u32 data;
+		struct {
+			u32 dir;
+			u32 in_counter_addr;
+			u32 out_status_addr;
+			u32 out_counter_addr;
+		} txrx_addr;
 		u8 stats[WLAN_MAX_STATS_SIZE];
 	};
 };
@@ -424,6 +446,30 @@ static int airoha_npu_wlan_msg_send(struct airoha_npu *npu, int ifindex,
 	return err;
 }
 
+static int airoha_npu_wlan_msg_get(struct airoha_npu *npu, int ifindex,
+				   enum airoha_npu_wlan_get_cmd func_id,
+				   u32 *data)
+{
+	struct wlan_mbox_data *wlan_data;
+	int err;
+
+	wlan_data = kzalloc(sizeof(*wlan_data), GFP_ATOMIC);
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
@@ -470,6 +516,15 @@ static int airoha_npu_wlan_init_memory(struct airoha_npu *npu)
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
@@ -574,6 +629,9 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	npu->ops.ppe_flush_sram_entries = airoha_npu_ppe_flush_sram_entries;
 	npu->ops.ppe_foe_commit_entry = airoha_npu_foe_commit_entry;
 	npu->ops.wlan_init_reserved_memory = airoha_npu_wlan_init_memory;
+	npu->ops.wlan_send_msg = airoha_npu_wlan_msg_send;
+	npu->ops.wlan_get_msg = airoha_npu_wlan_msg_get;
+	npu->ops.wlan_get_queue_addr = airoha_npu_wlan_queue_addr_get;
 
 	npu->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(npu->regmap))
diff --git a/drivers/net/ethernet/airoha/airoha_npu.h b/drivers/net/ethernet/airoha/airoha_npu.h
index 58f4ee04e17161acbe513779638c23fe79a83a78..6a9cb1425f48ad8b01daf191ace4e443d22949dc 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -43,6 +43,19 @@ enum airoha_npu_wlan_set_cmd {
 	WLAN_FUNC_SET_WAIT_DEBUG_ARRAY_ADDR,
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
+};
+
 struct airoha_npu {
 	struct device *dev;
 	struct regmap *regmap;
@@ -67,6 +80,14 @@ struct airoha_npu {
 					    u32 entry_size, u32 hash,
 					    bool ppe2);
 		int (*wlan_init_reserved_memory)(struct airoha_npu *npu);
+		int (*wlan_send_msg)(struct airoha_npu *npu, int ifindex,
+				     enum airoha_npu_wlan_set_cmd func_id,
+				     u32 data, gfp_t gfp);
+		int (*wlan_get_msg)(struct airoha_npu *npu, int ifindex,
+				    enum airoha_npu_wlan_get_cmd func_id,
+				    u32 *data);
+		u32 (*wlan_get_queue_addr)(struct airoha_npu *npu, int qid,
+					   bool xmit);
 	} ops;
 };
 

-- 
2.50.0


