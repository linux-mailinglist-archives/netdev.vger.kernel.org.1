Return-Path: <netdev+bounces-203046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA33AF0681
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41691C04F89
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE9277CBA;
	Tue,  1 Jul 2025 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxYFR93u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C6B125D6
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408644; cv=none; b=B5Dnf5R55MP4V/zyeuOo72jC0niW6tZlTTRXDWnRDDTZXOic6Gu/6aSLX7ynmlIBXAAx0YOgsXIm6izuX4zT0+gMPpv5AnM8OMwi/AVFEjJA284UCUcZlDEneKSjvJ1x1yvszhySxsYhvuhObcuMT9UeyjNnCoPDBi+o+dCHla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408644; c=relaxed/simple;
	bh=K9FFHLIOVp/T297T8ldnFsmbwPzUF1X8BIBdvNgA5HA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F4h8SarLOJQ0Jjznj5/qk9ugriAqvFePwR1J67zy9AOAA7krcvjT8hzGHwuT6l/7oYFCdEiW4rpplAkoPHVDYJnqdec1doFwcSu5eYgBB+w/C/dmSgN15UsI7XCIV9mWua+cHlBJhE6lbY3xnZOcTAquozZc5JSxltHHtr00DQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxYFR93u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C450C4CEEB;
	Tue,  1 Jul 2025 22:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408643;
	bh=K9FFHLIOVp/T297T8ldnFsmbwPzUF1X8BIBdvNgA5HA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bxYFR93uOXwel02OpZ5zXOqa46WNkfECGnxHjX0/KopB6xC7NonUdIdZJ6L0HlapQ
	 zqxZqwWWRzq0TfD38eEE7My1D0II7t5awxBwuheVo6LFAlGKv6SZRVVIOSw0hpuKtK
	 DrmLHXZNemOBHF7XV3ybXRSpse2VCA5mhozmzg5EcOY8PJygsn4pCIOfZ4iYNv9FLM
	 DzTotIpglygXsyv4hQXoZ7u4Ei/HZUH1Q9CdFWGqKIFOIpqp9MMmX3Lnxn94CUqTZQ
	 t8DIh0gGc2VlUDd6CH3QoUAyJU2abPW5zglChFpZ/ikNU/cJgtiUeesRghcaJxQv31
	 Ek1wHKN6ZN+Rw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 02 Jul 2025 00:23:31 +0200
Subject: [PATCH net-next 2/6] net: airoha: npu: Add more wlan NPU callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-airoha-en7581-wlan-offlaod-v1-2-803009700b38@kernel.org>
References: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
In-Reply-To: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce more NPU wlan callbacks used by wlan driver (MT76) to initialize
NPU module register for offloading wireless-wired offloading.
This is a preliminary patch to enable wlan flowtable offload for EN7581
SoC with MT76 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 163 +++++++++++++++++++++++++++++++
 drivers/net/ethernet/airoha/airoha_npu.h |  21 ++++
 2 files changed, 184 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index f8057072cfd7bb114e34af176aabaa1ef9f052c0..8acb2c627dc32386f40795a26e03d36fffe359ac 100644
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
@@ -161,6 +177,19 @@ enum {
 	WLAN_FUNC_SET_WAIT_DEBUG_ARRAY_ADDR,
 };
 
+enum {
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
 #define WLAN_MAX_STATS_SIZE	4408
 struct wlan_mbox_data {
 	u32 ifindex:4;
@@ -168,6 +197,12 @@ struct wlan_mbox_data {
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
@@ -460,6 +495,29 @@ static int airoha_npu_wlan_send_msg(struct airoha_npu *npu, int ifindex,
 	return err;
 }
 
+static int airoha_npu_wlan_get_msg(struct airoha_npu *npu, int index,
+				   int func_id, u32 *data)
+{
+	struct wlan_mbox_data *wlan_data;
+	int err;
+
+	wlan_data = kzalloc(sizeof(*wlan_data), GFP_ATOMIC);
+	if (!wlan_data)
+		return -ENOMEM;
+
+	wlan_data->ifindex = index;
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
 static int airoha_npu_wlan_set_reserved_memory(struct airoha_npu *npu,
 					       int ifindex, const char *name,
 					       int func_id)
@@ -512,6 +570,99 @@ static int airoha_npu_wlan_init_memory(struct airoha_npu *npu)
 	return airoha_npu_wlan_send_msg(npu, 0, cmd, 0, GFP_KERNEL);
 }
 
+static int airoha_npu_wlan_txrx_reg_addr_set(struct airoha_npu *npu,
+					     int ifindex, u32 dir,
+					     u32 in_counter_addr,
+					     u32 out_status_addr,
+					     u32 out_counter_addr)
+{
+	struct wlan_mbox_data *wlan_data;
+	int err;
+
+	wlan_data = kzalloc(sizeof(*wlan_data), GFP_ATOMIC);
+	if (!wlan_data)
+		return -ENOMEM;
+
+	wlan_data->ifindex = ifindex;
+	wlan_data->func_type = NPU_OP_SET;
+	wlan_data->func_id = WLAN_FUNC_SET_WAIT_INODE_TXRX_REG_ADDR;
+	wlan_data->txrx_addr.dir = dir;
+	wlan_data->txrx_addr.in_counter_addr = in_counter_addr;
+	wlan_data->txrx_addr.out_status_addr = out_status_addr;
+	wlan_data->txrx_addr.out_counter_addr = out_counter_addr;
+
+	err = airoha_npu_send_msg(npu, NPU_FUNC_WIFI, wlan_data,
+				  sizeof(*wlan_data));
+	kfree(wlan_data);
+
+	return err;
+}
+
+static int airoha_npu_wlan_pcie_port_type_set(struct airoha_npu *npu,
+					      int ifindex, u32 port_type)
+{
+	return airoha_npu_wlan_send_msg(npu, ifindex,
+					WLAN_FUNC_SET_WAIT_PCIE_PORT_TYPE,
+					port_type, GFP_ATOMIC);
+}
+
+static int airoha_npu_wlan_pcie_addr_set(struct airoha_npu *npu,
+					 int ifindex, u32 addr)
+{
+	return airoha_npu_wlan_send_msg(npu, ifindex,
+					WLAN_FUNC_SET_WAIT_PCIE_ADDR, addr,
+					GFP_ATOMIC);
+}
+
+static int airoha_npu_wlan_desc_set(struct airoha_npu *npu, int ifindex,
+				    u32 desc)
+{
+	return airoha_npu_wlan_send_msg(npu, ifindex,
+					WLAN_FUNC_SET_WAIT_DESC, desc,
+					GFP_ATOMIC);
+}
+
+static int airoha_npu_wlan_tx_ring_pcie_addr_set(struct airoha_npu *npu,
+						 int ifindex, u32 addr)
+{
+	return airoha_npu_wlan_send_msg(npu, ifindex,
+					WLAN_FUNC_SET_WAIT_TX_RING_PCIE_ADDR,
+					addr, GFP_ATOMIC);
+}
+
+static int airoha_npu_wlan_rx_desc_base_get(struct airoha_npu *npu,
+					    int ifindex, u32 *data)
+
+{
+	return airoha_npu_wlan_get_msg(npu, ifindex,
+				       WLAN_FUNC_GET_WAIT_RXDESC_BASE, data);
+}
+
+static int airoha_npu_wlan_tx_buf_space_base_set(struct airoha_npu *npu,
+						 int ifindex, u32 addr)
+{
+	return airoha_npu_wlan_send_msg(npu, ifindex,
+			WLAN_FUNC_SET_WAIT_TX_BUF_SPACE_HW_BASE,
+			addr, GFP_ATOMIC);
+}
+
+static int airoha_npu_wlan_rx_ring_for_txdone_set(struct airoha_npu *npu,
+						  int ifindex, u32 addr)
+{
+	return airoha_npu_wlan_send_msg(npu, ifindex,
+			WLAN_FUNC_SET_WAIT_RX_RING_FOR_TXDONE_HW_BASE,
+			addr, GFP_ATOMIC);
+}
+
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
@@ -616,6 +767,18 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	npu->ops.ppe_flush_sram_entries = airoha_npu_ppe_flush_sram_entries;
 	npu->ops.ppe_foe_commit_entry = airoha_npu_foe_commit_entry;
 	npu->ops.wlan_init_reserved_memory = airoha_npu_wlan_init_memory;
+	npu->ops.wlan_set_txrx_reg_addr = airoha_npu_wlan_txrx_reg_addr_set;
+	npu->ops.wlan_set_pcie_port_type = airoha_npu_wlan_pcie_port_type_set;
+	npu->ops.wlan_set_pcie_addr = airoha_npu_wlan_pcie_addr_set;
+	npu->ops.wlan_set_desc = airoha_npu_wlan_desc_set;
+	npu->ops.wlan_set_tx_ring_pcie_addr =
+		airoha_npu_wlan_tx_ring_pcie_addr_set;
+	npu->ops.wlan_get_rx_desc_base = airoha_npu_wlan_rx_desc_base_get;
+	npu->ops.wlan_set_tx_buf_space_base =
+		airoha_npu_wlan_tx_buf_space_base_set;
+	npu->ops.wlan_set_rx_ring_for_txdone =
+		airoha_npu_wlan_rx_ring_for_txdone_set;
+	npu->ops.wlan_get_queue_addr = airoha_npu_wlan_queue_addr_get;
 
 	npu->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
 	if (IS_ERR(npu->regmap))
diff --git a/drivers/net/ethernet/airoha/airoha_npu.h b/drivers/net/ethernet/airoha/airoha_npu.h
index 242f0d15b2f7c262daaf7bb78ee386ccc8a0433d..9fdec469e7b0e7caa5d988dfd78578d860a0e66d 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.h
+++ b/drivers/net/ethernet/airoha/airoha_npu.h
@@ -30,6 +30,27 @@ struct airoha_npu {
 					    u32 entry_size, u32 hash,
 					    bool ppe2);
 		int (*wlan_init_reserved_memory)(struct airoha_npu *npu);
+		int (*wlan_set_txrx_reg_addr)(struct airoha_npu *npu,
+					      int ifindex, u32 dir,
+					      u32 in_counter_addr,
+					      u32 out_status_addr,
+					      u32 out_counter_addr);
+		int (*wlan_set_pcie_port_type)(struct airoha_npu *npu,
+					       int ifindex, u32 port_type);
+		int (*wlan_set_pcie_addr)(struct airoha_npu *npu, int ifindex,
+					  u32 addr);
+		int (*wlan_set_desc)(struct airoha_npu *npu, int ifindex,
+				     u32 desc);
+		int (*wlan_set_tx_ring_pcie_addr)(struct airoha_npu *npu,
+						  int ifindex, u32 addr);
+		int (*wlan_get_rx_desc_base)(struct airoha_npu *npu,
+					     int ifindex, u32 *data);
+		int (*wlan_set_tx_buf_space_base)(struct airoha_npu *npu,
+						  int ifindex, u32 addr);
+		int (*wlan_set_rx_ring_for_txdone)(struct airoha_npu *npu,
+						   int ifindex, u32 addr);
+		u32 (*wlan_get_queue_addr)(struct airoha_npu *npu, int qid,
+					   bool xmit);
 	} ops;
 };
 

-- 
2.50.0


