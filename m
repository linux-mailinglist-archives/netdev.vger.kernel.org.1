Return-Path: <netdev+bounces-154992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97285A00926
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC02C163917
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08F31FA16B;
	Fri,  3 Jan 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6iUBxA5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FA81F9F72
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906661; cv=none; b=WBLM17PuxxDN7AU9b2qF/iXquA86K6kUaHZxotOvG94r0Eg7t/w/APuDYg5f0X5pz0hz4uBYqZiqmUknnKMFV+64YT/yxFFAneIZE3FMuDmSflGROyYvwUIICI8gqLXF5BhKeVnhKI1jeRiOCHYzvkRfiMljIwybat4jjW1LTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906661; c=relaxed/simple;
	bh=BREf+AuvwXGyuxndCIojls+R4cWTgkuRgtwXcPueSEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPJEO31NvNIDVU9MWEK/xnBNCHPbsD3mbSLpH93A4N68OZbPPxKmv5ux6KqZONmSqqq9XpdyzZwCo2akvupb9x8x2IJMv77jgDgRSD6g4giCoSvPahmAzD+1CC0sArnYri6VRvA2GId53K0zbLq+vdLCWSrtHI3XueY0IMm/tUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6iUBxA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1898AC4CECE;
	Fri,  3 Jan 2025 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735906661;
	bh=BREf+AuvwXGyuxndCIojls+R4cWTgkuRgtwXcPueSEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q6iUBxA5cIYqe3mgi/2ApaTu3I7higBtyYSHVQJghe1M3OswcYaezdXGcpW3a4sy1
	 +JxYTJSrPVAT9j0nWIRgdtB3sr+jLVsVabkEo4Fxs006kNbH/ro5tX/nHI4s83/PLz
	 YS0YZXEThjIGO83mOMWiKOnv8RyE6ejj8h5od5yLdzFR8xOusyY/6CFXimIEyZVx32
	 dVVTu0jJ04/CaR/V58z2HSAVydvgtfM5xQvdbeZode0peLS4ZtbNvJT9sqgbHtFmsk
	 ZTmCSZmXfODFv3ip5T8sC8YtsyOQ0Nw0UKBozoQj+ESewuNduswZ+kO6EckbAC7WZH
	 DWTwbsgKLyORw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 03 Jan 2025 13:17:05 +0100
Subject: [PATCH net-next 4/4] net: airoha: Add sched HTB offload support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-airoha-en7581-qdisc-offload-v1-4-608a23fa65d5@kernel.org>
References: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
In-Reply-To: <20250103-airoha-en7581-qdisc-offload-v1-0-608a23fa65d5@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 upstream@airoha.com, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce support for HTB Qdisc offload available in the Airoha EN7581
ethernet controller. EN7581 can offload only one level of HTB leafs.
Each HTB leaf represents a QoS channel supported by EN7581 SoC.
The typical use-case is creating a HTB leaf for QoS channel to rate
limit the egress traffic and attach an ETS Qdisc to each HTB leaf in
order to enforce traffic prioritization.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 288 ++++++++++++++++++++++++++++-
 1 file changed, 287 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 76cdab2499043adc96e058f8f562676455b6d36d..b9f1c42f0a40ca268506b4595dfa1902a15be26c 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -28,6 +28,8 @@
 #define AIROHA_NUM_QOS_QUEUES		8
 #define AIROHA_NUM_TX_RING		32
 #define AIROHA_NUM_RX_RING		32
+#define AIROHA_NUM_NETDEV_TX_RINGS	(AIROHA_NUM_TX_RING + \
+					 AIROHA_NUM_QOS_CHANNELS)
 #define AIROHA_FE_MC_MAX_VLAN_TABLE	64
 #define AIROHA_FE_MC_MAX_VLAN_PORT	16
 #define AIROHA_NUM_TX_IRQ		2
@@ -43,6 +45,9 @@
 #define PSE_RSV_PAGES			128
 #define PSE_QUEUE_RSV_PAGES		64
 
+#define QDMA_METER_IDX(_n)		((_n) & 0xff)
+#define QDMA_METER_GROUP(_n)		(((_n) >> 8) & 0x3)
+
 /* FE */
 #define PSE_BASE			0x0100
 #define CSR_IFC_BASE			0x0200
@@ -583,6 +588,17 @@
 #define EGRESS_SLOW_TICK_RATIO_MASK	GENMASK(29, 16)
 #define EGRESS_FAST_TICK_MASK		GENMASK(15, 0)
 
+#define TRTCM_PARAM_RW_MASK		BIT(31)
+#define TRTCM_PARAM_RW_DONE_MASK	BIT(30)
+#define TRTCM_PARAM_TYPE_MASK		GENMASK(29, 28)
+#define TRTCM_METER_GROUP_MASK		GENMASK(27, 26)
+#define TRTCM_PARAM_INDEX_MASK		GENMASK(23, 17)
+#define TRTCM_PARAM_RATE_TYPE_MASK	BIT(16)
+
+#define REG_TRTCM_CFG_PARAM(_n)		((_n) + 0x4)
+#define REG_TRTCM_DATA_LOW(_n)		((_n) + 0x8)
+#define REG_TRTCM_DATA_HIGH(_n)		((_n) + 0xc)
+
 #define REG_TXWRR_MODE_CFG		0x1020
 #define TWRR_WEIGHT_SCALE_MASK		BIT(31)
 #define TWRR_WEIGHT_BASE_MASK		BIT(3)
@@ -759,6 +775,29 @@ enum tx_sched_mode {
 	TC_SCH_WRR2,
 };
 
+enum trtcm_param_type {
+	TRTCM_MISC_MODE, /* meter_en, pps_mode, tick_sel */
+	TRTCM_TOKEN_RATE_MODE,
+	TRTCM_BUCKETSIZE_SHIFT_MODE,
+	TRTCM_BUCKET_COUNTER_MODE,
+};
+
+enum trtcm_mode_type {
+	TRTCM_COMMIT_MODE,
+	TRTCM_PEAK_MODE,
+};
+
+enum trtcm_param {
+	TRTCM_TICK_SEL = BIT(0),
+	TRTCM_PKT_MODE = BIT(1),
+	TRTCM_METER_MODE = BIT(2),
+};
+
+#define MIN_TOKEN_SIZE				4096
+#define MAX_TOKEN_SIZE_OFFSET			17
+#define TRTCM_TOKEN_RATE_MASK			GENMASK(23, 6)
+#define TRTCM_TOKEN_RATE_FRACTION_MASK		GENMASK(5, 0)
+
 struct airoha_queue_entry {
 	union {
 		void *buf;
@@ -850,6 +889,8 @@ struct airoha_gdm_port {
 
 	struct airoha_hw_stats stats;
 
+	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
+
 	/* qos stats counters */
 	u64 cpu_tx_packets;
 	u64 fwd_tx_packets;
@@ -2817,6 +2858,243 @@ static int airoha_tc_setup_qdisc_ets(struct airoha_gdm_port *port,
 	}
 }
 
+static int airoha_qdma_get_trtcm_param(struct airoha_qdma *qdma, int channel,
+				       u32 addr, enum trtcm_param_type param,
+				       enum trtcm_mode_type mode,
+				       u32 *val_low, u32 *val_high)
+{
+	u32 idx = QDMA_METER_IDX(channel), group = QDMA_METER_GROUP(channel);
+	u32 val, config = FIELD_PREP(TRTCM_PARAM_TYPE_MASK, param) |
+			  FIELD_PREP(TRTCM_METER_GROUP_MASK, group) |
+			  FIELD_PREP(TRTCM_PARAM_INDEX_MASK, idx) |
+			  FIELD_PREP(TRTCM_PARAM_RATE_TYPE_MASK, mode);
+
+	airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
+	if (read_poll_timeout(airoha_qdma_rr, val,
+			      val & TRTCM_PARAM_RW_DONE_MASK,
+			      USEC_PER_MSEC, 10 * USEC_PER_MSEC, true,
+			      qdma, REG_TRTCM_CFG_PARAM(addr)))
+		return -ETIMEDOUT;
+
+	*val_low = airoha_qdma_rr(qdma, REG_TRTCM_DATA_LOW(addr));
+	if (val_high)
+		*val_high = airoha_qdma_rr(qdma, REG_TRTCM_DATA_HIGH(addr));
+
+	return 0;
+}
+
+static int airoha_qdma_set_trtcm_param(struct airoha_qdma *qdma, int channel,
+				       u32 addr, enum trtcm_param_type param,
+				       enum trtcm_mode_type mode, u32 val)
+{
+	u32 idx = QDMA_METER_IDX(channel), group = QDMA_METER_GROUP(channel);
+	u32 config = TRTCM_PARAM_RW_MASK |
+		     FIELD_PREP(TRTCM_PARAM_TYPE_MASK, param) |
+		     FIELD_PREP(TRTCM_METER_GROUP_MASK, group) |
+		     FIELD_PREP(TRTCM_PARAM_INDEX_MASK, idx) |
+		     FIELD_PREP(TRTCM_PARAM_RATE_TYPE_MASK, mode);
+
+	airoha_qdma_wr(qdma, REG_TRTCM_DATA_LOW(addr), val);
+	airoha_qdma_wr(qdma, REG_TRTCM_CFG_PARAM(addr), config);
+
+	return read_poll_timeout(airoha_qdma_rr, val,
+				 val & TRTCM_PARAM_RW_DONE_MASK,
+				 USEC_PER_MSEC, 10 * USEC_PER_MSEC, true,
+				 qdma, REG_TRTCM_CFG_PARAM(addr));
+}
+
+static int airoha_qdma_set_trtcm_config(struct airoha_qdma *qdma, int channel,
+					u32 addr, enum trtcm_mode_type mode,
+					bool enable, u32 enable_mask)
+{
+	u32 val;
+
+	if (airoha_qdma_get_trtcm_param(qdma, channel, addr, TRTCM_MISC_MODE,
+					mode, &val, NULL))
+		return -EINVAL;
+
+	val = enable ? val | enable_mask : val & ~enable_mask;
+
+	return airoha_qdma_set_trtcm_param(qdma, channel, addr, TRTCM_MISC_MODE,
+					   mode, val);
+}
+
+static int airoha_qdma_set_trtcm_token_bucket(struct airoha_qdma *qdma,
+					      int channel, u32 addr,
+					      enum trtcm_mode_type mode,
+					      u32 rate_val, u32 bucket_size)
+{
+	u32 val, config, tick, unit, rate, rate_frac;
+	int err;
+
+	if (airoha_qdma_get_trtcm_param(qdma, channel, addr, TRTCM_MISC_MODE,
+					mode, &config, NULL))
+		return -EINVAL;
+
+	val = airoha_qdma_rr(qdma, addr);
+	tick = FIELD_GET(INGRESS_FAST_TICK_MASK, val);
+	if (config & TRTCM_TICK_SEL)
+		tick *= FIELD_GET(INGRESS_SLOW_TICK_RATIO_MASK, val);
+	if (!tick)
+		return -EINVAL;
+
+	unit = (config & TRTCM_PKT_MODE) ? 1000000 / tick : 8000 / tick;
+	if (!unit)
+		return -EINVAL;
+
+	rate = rate_val / unit;
+	rate_frac = rate_val % unit;
+	rate_frac = FIELD_PREP(TRTCM_TOKEN_RATE_MASK, rate_frac) / unit;
+	rate = FIELD_PREP(TRTCM_TOKEN_RATE_MASK, rate) |
+	       FIELD_PREP(TRTCM_TOKEN_RATE_FRACTION_MASK, rate_frac);
+
+	err = airoha_qdma_set_trtcm_param(qdma, channel, addr,
+					  TRTCM_TOKEN_RATE_MODE, mode, rate);
+	if (err)
+		return err;
+
+	val = max_t(u32, bucket_size, MIN_TOKEN_SIZE);
+	val = min_t(u32, __fls(val), MAX_TOKEN_SIZE_OFFSET);
+
+	return airoha_qdma_set_trtcm_param(qdma, channel, addr,
+					   TRTCM_BUCKETSIZE_SHIFT_MODE,
+					   mode, val);
+}
+
+static int airoha_qdma_set_tx_rate_limit(struct airoha_gdm_port *port,
+					 int channel, u32 rate,
+					 u32 bucket_size)
+{
+	int i, err;
+
+	for (i = 0; i <= TRTCM_PEAK_MODE; i++) {
+		err = airoha_qdma_set_trtcm_config(port->qdma, channel,
+						   REG_EGRESS_TRTCM_CFG, i,
+						   !!rate, TRTCM_METER_MODE);
+		if (err)
+			return err;
+
+		err = airoha_qdma_set_trtcm_token_bucket(port->qdma, channel,
+							 REG_EGRESS_TRTCM_CFG,
+							 i, rate, bucket_size);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int airoha_tc_htb_alloc_leaf_queue(struct airoha_gdm_port *port,
+					  struct tc_htb_qopt_offload *opt)
+{
+	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
+	u32 rate = div_u64(opt->rate, 1000) << 3; /* kbps */
+	struct net_device *dev = port->dev;
+	int num_tx_queues = dev->real_num_tx_queues;
+	int err;
+
+	if (opt->parent_classid != TC_HTB_CLASSID_ROOT) {
+		NL_SET_ERR_MSG_MOD(opt->extack, "invalid parent classid");
+		return -EINVAL;
+	}
+
+	err = airoha_qdma_set_tx_rate_limit(port, channel, rate, opt->quantum);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(opt->extack,
+				   "failed configuring htb offload");
+		return err;
+	}
+
+	if (opt->command == TC_HTB_NODE_MODIFY)
+		return 0;
+
+	err = netif_set_real_num_tx_queues(dev, num_tx_queues + 1);
+	if (err) {
+		airoha_qdma_set_tx_rate_limit(port, channel, 0, opt->quantum);
+		NL_SET_ERR_MSG_MOD(opt->extack,
+				   "failed setting real_num_tx_queues");
+		return err;
+	}
+
+	set_bit(channel, port->qos_sq_bmap);
+	opt->qid = AIROHA_NUM_TX_RING + channel;
+
+	return 0;
+}
+
+static void airoha_tc_remove_htb_queue(struct airoha_gdm_port *port, int queue)
+{
+	struct net_device *dev = port->dev;
+
+	netif_set_real_num_tx_queues(dev, dev->real_num_tx_queues - 1);
+	airoha_qdma_set_tx_rate_limit(port, queue + 1, 0, 0);
+	clear_bit(queue, port->qos_sq_bmap);
+}
+
+static int airoha_tc_htb_delete_leaf_queue(struct airoha_gdm_port *port,
+					   struct tc_htb_qopt_offload *opt)
+{
+	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
+
+	if (!test_bit(channel, port->qos_sq_bmap)) {
+		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
+		return -EINVAL;
+	}
+
+	airoha_tc_remove_htb_queue(port, channel);
+
+	return 0;
+}
+
+static int airoha_tc_htb_destroy(struct airoha_gdm_port *port)
+{
+	int q;
+
+	for_each_set_bit(q, port->qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS)
+		airoha_tc_remove_htb_queue(port, q);
+
+	return 0;
+}
+
+static int airoha_tc_get_htb_get_leaf_queue(struct airoha_gdm_port *port,
+					    struct tc_htb_qopt_offload *opt)
+{
+	u32 channel = TC_H_MIN(opt->classid) % AIROHA_NUM_QOS_CHANNELS;
+
+	if (!test_bit(channel, port->qos_sq_bmap)) {
+		NL_SET_ERR_MSG_MOD(opt->extack, "invalid queue id");
+		return -EINVAL;
+	}
+
+	opt->qid = channel;
+
+	return 0;
+}
+
+static int airoha_tc_setup_qdisc_htb(struct airoha_gdm_port *port,
+				     struct tc_htb_qopt_offload *opt)
+{
+	switch (opt->command) {
+	case TC_HTB_CREATE:
+		break;
+	case TC_HTB_DESTROY:
+		return airoha_tc_htb_destroy(port);
+	case TC_HTB_NODE_MODIFY:
+	case TC_HTB_LEAF_ALLOC_QUEUE:
+		return airoha_tc_htb_alloc_leaf_queue(port, opt);
+	case TC_HTB_LEAF_DEL:
+	case TC_HTB_LEAF_DEL_LAST:
+	case TC_HTB_LEAF_DEL_LAST_FORCE:
+		return airoha_tc_htb_delete_leaf_queue(port, opt);
+	case TC_HTB_LEAF_QUERY_QUEUE:
+		return airoha_tc_get_htb_get_leaf_queue(port, opt);
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
 			       void *type_data)
 {
@@ -2825,6 +3103,8 @@ static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
 	switch (type) {
 	case TC_SETUP_QDISC_ETS:
 		return airoha_tc_setup_qdisc_ets(port, type_data);
+	case TC_SETUP_QDISC_HTB:
+		return airoha_tc_setup_qdisc_htb(port, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2875,7 +3155,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 	}
 
 	dev = devm_alloc_etherdev_mqs(eth->dev, sizeof(*port),
-				      AIROHA_NUM_TX_RING, AIROHA_NUM_RX_RING);
+				      AIROHA_NUM_NETDEV_TX_RINGS,
+				      AIROHA_NUM_RX_RING);
 	if (!dev) {
 		dev_err(eth->dev, "alloc_etherdev failed\n");
 		return -ENOMEM;
@@ -2895,6 +3176,11 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 	dev->irq = qdma->irq;
 	SET_NETDEV_DEV(dev, eth->dev);
 
+	/* reserve hw queues for HTB offloading */
+	err = netif_set_real_num_tx_queues(dev, AIROHA_NUM_TX_RING);
+	if (err)
+		return err;
+
 	err = of_get_ethdev_address(np, dev);
 	if (err) {
 		if (err == -EPROBE_DEFER)

-- 
2.47.1


