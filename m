Return-Path: <netdev+bounces-154991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D8FA00925
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 13:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7289A1884418
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F51F9F50;
	Fri,  3 Jan 2025 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udHz7lUd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2252A1F9ECE
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906659; cv=none; b=gh6HFAZbwmJIfQ1HDnRpb/N+FGKDS7iUItOsKXkTUXOwM2drW5JgPer5m1M7euuN1zC8/fUvrcCcXM5IzMyr8PGVJN8+s6BHg76xZTWFU5nTTutmPiT34dv23NKvjoC0FlAM2gFFOm7a70zsu+Iui0optAVldlFmOLq7flyD2N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906659; c=relaxed/simple;
	bh=dNnokmlGetQJ5J/ah6XqS/obZr8KKymrYPfureao+/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkw3fIeCQDT/U9k8fFAKvpxnEVP7mPH8gbmspdbiP1351ENy6JB9Nd6A0uD5LvUPd2HvcGWXrrs7O8UNrtFRjAzQFOqCewSVI4YzAcs+d7UdWJOSwHRCuFlYLt4r1x6kJLK4OvjAnw8ExVlALTiMqzVnImGAxRwHMHxFSRtDZgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udHz7lUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C55FC4CECE;
	Fri,  3 Jan 2025 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735906658;
	bh=dNnokmlGetQJ5J/ah6XqS/obZr8KKymrYPfureao+/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=udHz7lUdqLoK89EhTfhNzAcuczK3Ch2FgO2JI3q0EAw8QWqsJQ1WoEsFv8xIjY+nJ
	 acEIGUqyhwy2qLu8dhyrnYcDALwrRfdGmL/p3gsi/vpm4POyTBSh0eLE2XBV7SRilp
	 kZHRjJyzwCtHpQZUpFH8jX54p6K2OQ9XdTQRmYzYpLZMs6Eu7/GJHbYEJCLY/4iu6p
	 UIoK0YyLjx5xfQHmU1Aw4skc3j1Fr92nku0veoR+uEzXaVyRq+xO/H0AvVYn1fKRFa
	 zPLjnwEPkfLGmPi8AFyP7oEl32jwGfZjCeemHLRIxPCO3pozct+zlqDuCWYKPVyAOp
	 4tS54pbtOiOuA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 03 Jan 2025 13:17:04 +0100
Subject: [PATCH net-next 3/4] net: airoha: Add sched ETS offload support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-airoha-en7581-qdisc-offload-v1-3-608a23fa65d5@kernel.org>
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

Introduce support for ETS Qdisc offload available on the Airoha EN7581
ethernet controller. In order to be effective, ETS Qdisc must configured
as leaf of a HTB Qdisc (HTB Qdisc offload will be added in the following
patch). ETS Qdisc available on EN7581 ethernet controller supports at
most 8 concurrent bands (QoS queues). We can enable an ETS Qdisc for
each available QoS channel.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 196 ++++++++++++++++++++++++++++-
 1 file changed, 195 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 4b361f30829f4f5c40b1d8a97d43fd3a206e4206..76cdab2499043adc96e058f8f562676455b6d36d 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -15,6 +15,7 @@
 #include <linux/u64_stats_sync.h>
 #include <net/dsa.h>
 #include <net/page_pool/helpers.h>
+#include <net/pkt_cls.h>
 #include <uapi/linux/ppp_defs.h>
 
 #define AIROHA_MAX_NUM_GDM_PORTS	1
@@ -543,9 +544,24 @@
 #define INGRESS_SLOW_TICK_RATIO_MASK	GENMASK(29, 16)
 #define INGRESS_FAST_TICK_MASK		GENMASK(15, 0)
 
+#define REG_QUEUE_CLOSE_CFG(_n)		(0x00a0 + ((_n) & 0xfc))
+#define TXQ_DISABLE_CHAN_QUEUE_MASK(_n, _m)	BIT((_m) + (((_n) & 0x3) << 3))
+
 #define REG_TXQ_DIS_CFG_BASE(_n)	((_n) ? 0x20a0 : 0x00a0)
 #define REG_TXQ_DIS_CFG(_n, _m)		(REG_TXQ_DIS_CFG_BASE((_n)) + (_m) << 2)
 
+#define REG_CNTR_CFG(_n)		(0x0400 + ((_n) << 3))
+#define CNTR_EN_MASK			BIT(31)
+#define CNTR_ALL_CHAN_EN_MASK		BIT(30)
+#define CNTR_ALL_QUEUE_EN_MASK		BIT(29)
+#define CNTR_ALL_DSCP_RING_EN_MASK	BIT(28)
+#define CNTR_SRC_MASK			GENMASK(27, 24)
+#define CNTR_DSCP_RING_MASK		GENMASK(20, 16)
+#define CNTR_CHAN_MASK			GENMASK(7, 3)
+#define CNTR_QUEUE_MASK			GENMASK(2, 0)
+
+#define REG_CNTR_VAL(_n)		(0x0404 + ((_n) << 3))
+
 #define REG_LMGR_INIT_CFG		0x1000
 #define LMGR_INIT_START			BIT(31)
 #define LMGR_SRAM_MODE_MASK		BIT(30)
@@ -571,9 +587,19 @@
 #define TWRR_WEIGHT_SCALE_MASK		BIT(31)
 #define TWRR_WEIGHT_BASE_MASK		BIT(3)
 
+#define REG_TXWRR_WEIGHT_CFG		0x1024
+#define TWRR_RW_CMD_MASK		BIT(31)
+#define TWRR_RW_CMD_DONE		BIT(30)
+#define TWRR_CHAN_IDX_MASK		GENMASK(23, 19)
+#define TWRR_QUEUE_IDX_MASK		GENMASK(18, 16)
+#define TWRR_VALUE_MASK			GENMASK(15, 0)
+
 #define REG_PSE_BUF_USAGE_CFG		0x1028
 #define PSE_BUF_ESTIMATE_EN_MASK	BIT(29)
 
+#define REG_CHAN_QOS_MODE(_n)		(0x1040 + ((_n) << 2))
+#define CHAN_QOS_MODE_MASK(_n)		GENMASK(2 + ((_n) << 2), (_n) << 2)
+
 #define REG_GLB_TRTCM_CFG		0x1080
 #define GLB_TRTCM_EN_MASK		BIT(31)
 #define GLB_TRTCM_MODE_MASK		BIT(30)
@@ -722,6 +748,17 @@ enum {
 	FE_PSE_PORT_DROP = 0xf,
 };
 
+enum tx_sched_mode {
+	TC_SCH_WRR8,
+	TC_SCH_SP,
+	TC_SCH_WRR7,
+	TC_SCH_WRR6,
+	TC_SCH_WRR5,
+	TC_SCH_WRR4,
+	TC_SCH_WRR3,
+	TC_SCH_WRR2,
+};
+
 struct airoha_queue_entry {
 	union {
 		void *buf;
@@ -812,6 +849,10 @@ struct airoha_gdm_port {
 	int id;
 
 	struct airoha_hw_stats stats;
+
+	/* qos stats counters */
+	u64 cpu_tx_packets;
+	u64 fwd_tx_packets;
 };
 
 struct airoha_eth {
@@ -1961,6 +2002,27 @@ static void airoha_qdma_init_qos(struct airoha_qdma *qdma)
 			FIELD_PREP(SLA_SLOW_TICK_RATIO_MASK, 40));
 }
 
+static void airoha_qdma_init_qos_stats(struct airoha_qdma *qdma)
+{
+	int i;
+
+	for (i = 0; i < AIROHA_NUM_QOS_CHANNELS; i++) {
+		/* Tx-cpu transferred count */
+		airoha_qdma_wr(qdma, REG_CNTR_VAL(i << 1), 0);
+		airoha_qdma_wr(qdma, REG_CNTR_CFG(i << 1),
+			       CNTR_EN_MASK | CNTR_ALL_QUEUE_EN_MASK |
+			       CNTR_ALL_DSCP_RING_EN_MASK |
+			       FIELD_PREP(CNTR_CHAN_MASK, i));
+		/* Tx-fwd transferred count */
+		airoha_qdma_wr(qdma, REG_CNTR_VAL((i << 1) + 1), 0);
+		airoha_qdma_wr(qdma, REG_CNTR_CFG(i << 1),
+			       CNTR_EN_MASK | CNTR_ALL_QUEUE_EN_MASK |
+			       CNTR_ALL_DSCP_RING_EN_MASK |
+			       FIELD_PREP(CNTR_SRC_MASK, 1) |
+			       FIELD_PREP(CNTR_CHAN_MASK, i));
+	}
+}
+
 static int airoha_qdma_hw_init(struct airoha_qdma *qdma)
 {
 	int i;
@@ -2011,6 +2073,7 @@ static int airoha_qdma_hw_init(struct airoha_qdma *qdma)
 
 	airoha_qdma_set(qdma, REG_TXQ_CNGST_CFG,
 			TXQ_CNGST_DROP_EN | TXQ_CNGST_DEI_DROP_EN);
+	airoha_qdma_init_qos_stats(qdma);
 
 	return 0;
 }
@@ -2638,6 +2701,135 @@ airoha_ethtool_get_rmon_stats(struct net_device *dev,
 	} while (u64_stats_fetch_retry(&port->stats.syncp, start));
 }
 
+static int airoha_qdma_set_chan_tx_sched(struct airoha_gdm_port *port,
+					 int channel, enum tx_sched_mode mode,
+					 const u16 *weights, u8 n_weights)
+{
+	int i;
+
+	for (i = 0; i < AIROHA_NUM_TX_RING; i++)
+		airoha_qdma_clear(port->qdma, REG_QUEUE_CLOSE_CFG(channel),
+				  TXQ_DISABLE_CHAN_QUEUE_MASK(channel, i));
+
+	for (i = 0; i < n_weights; i++) {
+		u32 status;
+		int err;
+
+		airoha_qdma_wr(port->qdma, REG_TXWRR_WEIGHT_CFG,
+			       TWRR_RW_CMD_MASK |
+			       FIELD_PREP(TWRR_CHAN_IDX_MASK, channel) |
+			       FIELD_PREP(TWRR_QUEUE_IDX_MASK, i) |
+			       FIELD_PREP(TWRR_VALUE_MASK, weights[i]));
+		err = read_poll_timeout(airoha_qdma_rr, status,
+					status & TWRR_RW_CMD_DONE,
+					USEC_PER_MSEC, 10 * USEC_PER_MSEC,
+					true, port->qdma,
+					REG_TXWRR_WEIGHT_CFG);
+		if (err)
+			return err;
+	}
+
+	airoha_qdma_rmw(port->qdma, REG_CHAN_QOS_MODE(channel >> 3),
+			CHAN_QOS_MODE_MASK(channel),
+			mode << __ffs(CHAN_QOS_MODE_MASK(channel)));
+
+	return 0;
+}
+
+static int airoha_qdma_set_tx_prio_sched(struct airoha_gdm_port *port,
+					 int channel)
+{
+	static const u16 w[AIROHA_NUM_QOS_QUEUES] = {};
+
+	return airoha_qdma_set_chan_tx_sched(port, channel, TC_SCH_SP, w,
+					     ARRAY_SIZE(w));
+}
+
+static int airoha_qdma_set_tx_ets_sched(struct airoha_gdm_port *port,
+					int channel,
+					struct tc_ets_qopt_offload *opt)
+{
+	struct tc_ets_qopt_offload_replace_params *p = &opt->replace_params;
+	enum tx_sched_mode mode = TC_SCH_SP;
+	u16 w[AIROHA_NUM_QOS_QUEUES] = {};
+	int i, nstrict = 0;
+
+	if (p->bands > AIROHA_NUM_QOS_QUEUES)
+		return -EINVAL;
+
+	for (i = 0; i < p->bands; i++) {
+		if (!p->quanta[i])
+			nstrict++;
+	}
+
+	/* this configuration is not supported by the hw */
+	if (nstrict == AIROHA_NUM_QOS_QUEUES - 1)
+		return -EINVAL;
+
+	for (i = 0; i < p->bands - nstrict; i++)
+		w[i] = p->weights[nstrict + i];
+
+	if (!nstrict)
+		mode = TC_SCH_WRR8;
+	else if (nstrict < AIROHA_NUM_QOS_QUEUES - 1)
+		mode = nstrict + 1;
+
+	return airoha_qdma_set_chan_tx_sched(port, channel, mode, w,
+					     ARRAY_SIZE(w));
+}
+
+static int airoha_qdma_get_tx_ets_stats(struct airoha_gdm_port *port,
+					int channel,
+					struct tc_ets_qopt_offload *opt)
+{
+	u64 cpu_tx_packets = airoha_qdma_rr(port->qdma,
+					    REG_CNTR_VAL(channel << 1));
+	u64 fwd_tx_packets = airoha_qdma_rr(port->qdma,
+					    REG_CNTR_VAL((channel << 1) + 1));
+	u64 tx_packets = (cpu_tx_packets - port->cpu_tx_packets) +
+			 (fwd_tx_packets - port->fwd_tx_packets);
+	_bstats_update(opt->stats.bstats, 0, tx_packets);
+
+	port->cpu_tx_packets = cpu_tx_packets;
+	port->fwd_tx_packets = fwd_tx_packets;
+
+	return 0;
+}
+
+static int airoha_tc_setup_qdisc_ets(struct airoha_gdm_port *port,
+				     struct tc_ets_qopt_offload *opt)
+{
+	int channel = TC_H_MAJ(opt->handle) >> 16;
+
+	if (opt->parent == TC_H_ROOT)
+		return -EINVAL;
+
+	switch (opt->command) {
+	case TC_ETS_REPLACE:
+		return airoha_qdma_set_tx_ets_sched(port, channel, opt);
+	case TC_ETS_DESTROY:
+		/* PRIO is default qdisc scheduler */
+		return airoha_qdma_set_tx_prio_sched(port, channel);
+	case TC_ETS_STATS:
+		return airoha_qdma_get_tx_ets_stats(port, channel, opt);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
+			       void *type_data)
+{
+	struct airoha_gdm_port *port = netdev_priv(dev);
+
+	switch (type) {
+	case TC_SETUP_QDISC_ETS:
+		return airoha_tc_setup_qdisc_ets(port, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_init		= airoha_dev_init,
 	.ndo_open		= airoha_dev_open,
@@ -2646,6 +2838,7 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
+	.ndo_setup_tc		= airoha_dev_tc_setup,
 };
 
 static const struct ethtool_ops airoha_ethtool_ops = {
@@ -2695,7 +2888,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
 	dev->watchdog_timeo = 5 * HZ;
 	dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
 			   NETIF_F_TSO6 | NETIF_F_IPV6_CSUM |
-			   NETIF_F_SG | NETIF_F_TSO;
+			   NETIF_F_SG | NETIF_F_TSO |
+			   NETIF_F_HW_TC;
 	dev->features |= dev->hw_features;
 	dev->dev.of_node = np;
 	dev->irq = qdma->irq;

-- 
2.47.1


