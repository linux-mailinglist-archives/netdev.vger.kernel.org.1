Return-Path: <netdev+bounces-151145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC329ECFC7
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF203188A6D5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4881C1F1D;
	Wed, 11 Dec 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt1fQo7n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6901BDAB5
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931140; cv=none; b=HflI8J/0P0xcltwQcY1qBxbxa96/tGYjcAfAzJcklChkR2FS2qhDv9vn9dIlNsBmUMSRWHk6tF7p4Hlnfn/5+gbl3UMBrFkWS1AbFXGHcJh9/NhoeIYyFgVQWq2wh/LyblvUnkZTb7/bjPRLfNlgBA0TW9B3Ts/6VD99tuzwbN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931140; c=relaxed/simple;
	bh=XoKW2zY976GO2P35664sYhJ6oHt0mDyyKYtYUAPwBOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VFvRi6pWjyM2vX/pN8kzakDDmJl0pYyRs75zNfRPLSAR1MxDREoiPsATLcQHIXDSoT9d7v4UrDWf9/rhOhOHmRms6sY9qlsVWb4rRwXRRl8aKUkzqpjVc6AmaH4vZwEca+p8PcJf47jBz7rKJ2tV9MVcSAwcrDEyorO4FlHroOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt1fQo7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B0FC4CED2;
	Wed, 11 Dec 2024 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931140;
	bh=XoKW2zY976GO2P35664sYhJ6oHt0mDyyKYtYUAPwBOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mt1fQo7nPvInxc8xP793fDIz7XmicDt2AGUhiYuqq5YqQr1+6uDKOQHE/AJKu9ZHO
	 VarxJw1k/mJZcBB0xAvZLtzOjBQWCUkj2lUM5Dv1T3fp8i1+7+xlZXAQCHLbCQ2cc+
	 vRwLj++CY3Zsj7uHhfkWfTDeF623Q2OQmQzo0ROQc5Uv65GLnZu6b199n8p3max9Y/
	 PqerlbE27HoY3szz7rd2BMM68V6QCXisYAltzBAgYdmL3uyn946YS82LCm2OZPDonr
	 Nl0zMZ03FYGgMNOmWAjl/SA/afCawNx6/ShkZ0p3H3x6G1ZGpKxGRQwyiwWXKSaOPn
	 aO5lRu2UppVtA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: [RFC net-next 4/5] net: airoha: Add sched ETS offload support
Date: Wed, 11 Dec 2024 16:31:52 +0100
Message-ID: <b4d34136f5ef0d43e2727c2bf833adb41216cdc1.1733930558.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733930558.git.lorenzo@kernel.org>
References: <cover.1733930558.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for ETS qdisc offload available in the Airoha EN7581
ethernet controller. Add the capability to configure hw ETS Qdisc for
the specified DSA user port via the QDMA block available in the mac chip
(QDMA block is connected to the DSA switch cpu port).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 155 ++++++++++++++++++++-
 1 file changed, 154 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 8b927bf310ed..23aad8670a17 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -15,6 +15,7 @@
 #include <linux/u64_stats_sync.h>
 #include <net/dsa.h>
 #include <net/page_pool/helpers.h>
+#include <net/pkt_cls.h>
 #include <uapi/linux/ppp_defs.h>
 
 #define AIROHA_MAX_NUM_GDM_PORTS	1
@@ -542,9 +543,24 @@
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
@@ -570,9 +586,19 @@
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
@@ -721,6 +747,17 @@ enum {
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
@@ -2624,6 +2661,119 @@ airoha_ethtool_get_rmon_stats(struct net_device *dev,
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
+	if (p->bands != AIROHA_NUM_QOS_QUEUES)
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
+static int airoha_tc_setup_qdisc_ets(struct airoha_gdm_port *port, int channel,
+				     struct tc_ets_qopt_offload *opt)
+{
+	switch (opt->command) {
+	case TC_ETS_REPLACE:
+		return airoha_qdma_set_tx_ets_sched(port, channel, opt);
+	case TC_ETS_DESTROY:
+		/* PRIO is default qdisc scheduler */
+		return airoha_qdma_set_tx_prio_sched(port, channel);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int airoha_dev_tc_setup_conduit(struct net_device *dev, int channel,
+				       enum tc_setup_type type,
+				       void *type_data)
+{
+	struct airoha_gdm_port *port = netdev_priv(dev);
+
+	switch (type) {
+	case TC_SETUP_QDISC_ETS:
+		return airoha_tc_setup_qdisc_ets(port, channel, type_data);
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
+	return airoha_dev_tc_setup_conduit(dev, port->id, type, type_data);
+}
+
 static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_init		= airoha_dev_init,
 	.ndo_open		= airoha_dev_open,
@@ -2632,6 +2782,8 @@ static const struct net_device_ops airoha_netdev_ops = {
 	.ndo_start_xmit		= airoha_dev_xmit,
 	.ndo_get_stats64        = airoha_dev_get_stats64,
 	.ndo_set_mac_address	= airoha_dev_set_macaddr,
+	.ndo_setup_tc		= airoha_dev_tc_setup,
+	.ndo_setup_tc_conduit	= airoha_dev_tc_setup_conduit,
 };
 
 static const struct ethtool_ops airoha_ethtool_ops = {
@@ -2681,7 +2833,8 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth, struct device_node *np)
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


