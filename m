Return-Path: <netdev+bounces-151146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00B69ECFC9
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EC716A315
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9E61D14FA;
	Wed, 11 Dec 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOUgm8sC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9911F1A4F22
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931144; cv=none; b=JhczAwLxNpsTk78X+5LfhjRWj5KGt//lJZMPzWpaIJHHhupqFGrTgWmZ2nA4kKBP6bhAwofkyDF6F2MMIDayEzs0ZfnLFE/VUJ6B0r2cO5d3829dS06qt+eiircSNU10kWWBh73vE33FsSUcICXVHr/4STni8eMB2xaXPqLmWik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931144; c=relaxed/simple;
	bh=EoKLh/pM5nNqF9swvB7EQWfP7hlELeMaP30SHFDjaJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+KB2N1SB/oKqbaOivi58Yi4XULQz4HWBENXP6cYWkwT+BUITvC1jYg7LXVb113NfoU0Xdou5sRxntXAKoCvsZvjZaY+3YaocrdLD5HMZrd/ypDk6Z+LUju2NBGojW1XUKkBrofXyodynL6RAev406Z2pGy1Q71+7DuySTRnTqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOUgm8sC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47EAC4CED2;
	Wed, 11 Dec 2024 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931144;
	bh=EoKLh/pM5nNqF9swvB7EQWfP7hlELeMaP30SHFDjaJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QOUgm8sCSgGBNVz2chyf4RsBrkAUMo7ogz8opW8xmCkQnUeejNAyKx5iyb4aS8LZz
	 9Qozz7R9w50Y/xaZ/EhydM09eYBbVVUiLZOFr8Qzg5PNFa07IGc6VrB1APKgYCzYCD
	 9Si7JN34CgXtu8g5KQ30mtE+i94ulFvRakCpkyGhU4ndzYXvp20nbPzbLiAhD7f6dV
	 plTDa7XRJbzTSmxoreT0RKviIRpYdZR2OuHR7m9uf4xo9JoYEcW+241tJvGK2wmzZQ
	 w4IbfaPZUliKyjSLoK0YOK2tFEAPbR1MgKoF+pFPQxrXgyeZD40sBUNKMp9XXXyWbI
	 mnOJF9j7fQcRw==
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
Subject: [RFC net-next 5/5] net: airoha: Add sched TBF offload support
Date: Wed, 11 Dec 2024 16:31:53 +0100
Message-ID: <454e81d5ef8f7de1749555936bf73ff7a709cc7c.1733930558.git.lorenzo@kernel.org>
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

Introduce support for TBF qdisc offload available in the Airoha EN7581
ethernet controller. Add the capability to configure hw TBF Qdisc for
the specified DSA user port via the QDMA block available in the mac chip
(QDMA block is connected to the DSA switch cpu port).

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 185 +++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 23aad8670a17..a79c92a816a2 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -42,6 +42,9 @@
 #define PSE_RSV_PAGES			128
 #define PSE_QUEUE_RSV_PAGES		64
 
+#define QDMA_METER_IDX(_n)		((_n) & 0xff)
+#define QDMA_METER_GROUP(_n)		(((_n) >> 8) & 0x3)
+
 /* FE */
 #define PSE_BASE			0x0100
 #define CSR_IFC_BASE			0x0200
@@ -582,6 +585,17 @@
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
@@ -758,6 +772,29 @@ enum tx_sched_mode {
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
@@ -2752,6 +2789,152 @@ static int airoha_tc_setup_qdisc_ets(struct airoha_gdm_port *port, int channel,
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
+static int airoha_qdma_set_tx_tbf_sched(struct airoha_gdm_port *port,
+					int channel, u32 rate, u32 bucket_size)
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
+static int airoha_tc_setup_qdisc_tbf(struct airoha_gdm_port *port, int channel,
+				     struct tc_tbf_qopt_offload *qopt)
+{
+	struct tc_tbf_qopt_offload_replace_params *p = &qopt->replace_params;
+	u32 rate = 0;
+
+	if (qopt->parent != TC_H_ROOT)
+		return -EINVAL;
+
+	switch (qopt->command) {
+	case TC_TBF_REPLACE:
+		rate = div_u64(p->rate.rate_bytes_ps, 1000) << 3; /* kbps */
+		fallthrough;
+	case TC_TBF_DESTROY:
+		return airoha_qdma_set_tx_tbf_sched(port, channel, rate,
+						    p->max_size);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int airoha_dev_tc_setup_conduit(struct net_device *dev, int channel,
 				       enum tc_setup_type type,
 				       void *type_data)
@@ -2761,6 +2944,8 @@ static int airoha_dev_tc_setup_conduit(struct net_device *dev, int channel,
 	switch (type) {
 	case TC_SETUP_QDISC_ETS:
 		return airoha_tc_setup_qdisc_ets(port, channel, type_data);
+	case TC_SETUP_QDISC_TBF:
+		return airoha_tc_setup_qdisc_tbf(port, channel, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.47.1


