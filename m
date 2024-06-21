Return-Path: <netdev+bounces-105566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140F4911CB7
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F620B20D5A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 07:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ABA16B396;
	Fri, 21 Jun 2024 07:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KxhzcPRA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FVAdq1iQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3B67E58D
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718954761; cv=none; b=FANBoOO4VSQI0rRdwzh3RLwDRnWbpJjlAkn81FvhAYWHN4NXrdIXv0OUjYS9b3UEMpbD+naVaLwGxYyzb6bywsNKjeubH0j8GEWOM/YA+5mV1Fq2hCN7Mpg1yU1IB2/yUmYi7Mff57DmxAROGRFqDoPTNA0d/+7LrLN84NfaiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718954761; c=relaxed/simple;
	bh=keJGhzIL/wTU/BvrBynL8CCNPOv41zq8DR3sI+W5IVs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fH35VzsT/7N8IaW+2rUYJcOHbp9UsQyJLI4ae98B/JxqA6tsynarqi6145aQspu05vLuY+UTgt/o9ClkigGO7a1IQB7rvr9y8aS1NGn0CSUHkTuYm7FwRFs0+T3v3Ox2abxyrRpnkvbHmQ9k9K4l9/fyFXj4IdKV8Ig1WJSikD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KxhzcPRA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FVAdq1iQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718954757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fndjrFQvXKLJni/8XYY27o3KJ/r6FPFf4i2JICzHSXU=;
	b=KxhzcPRASVBJ6fN3H/7xWTeh5ulTv9iJwvlyhuAhQqfkZ2SGwonFZdafGlnZWQcVGwbJb3
	njIn6rvR8RNY60e/3EXOmcX6dxlEVvo7bA4H0SUarKGjs8TLQG6J2tUcs6I9WicQT0tL+5
	ZKH75sCeAAUqlzMc9mQ81TefUnXoMnODEP4zHFXewz12DXZpcUMoWNbwf2Pz7RtXn3xaF2
	fUDVq+wKQd2aVdMd5k3MV4IGfn9BBXt/Dlo1CidxTzyNrz9b7caJvltWlfT+htdeyn3Udc
	siHgHFRR/P5mLXml5OSgKU0oGFhjnsVLPJwXeT9RkNLhGmq/7+OW3Psvl1YYUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718954757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fndjrFQvXKLJni/8XYY27o3KJ/r6FPFf4i2JICzHSXU=;
	b=FVAdq1iQlgmxbL2NBqK1fjNNKBeM57ZdVcHC2c0ah1vUuitVMRG4MAg+KEmL1EsYs7oCsC
	FA/+8B/oLrQv0ACw==
Date: Fri, 21 Jun 2024 09:25:55 +0200
Subject: [PATCH iwl-next v3] igc: Add MQPRIO offload support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-igc_mqprio-v3-1-261f5bb99a2a@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAAIrdWYC/3WNyw6CMBQFf4V0bU1b3q78D2NMC1e4CbTY1ooh/
 LuFpdHlyWTOLMSBRXDklCzEQkCHRseRHhLS9FJ3QLGNmwgmMia4oNg1t/ExWTSUpXWRM8YKLio
 SBSUdUGWlbvpNGaXzYDcwWbjjvFcuBF8D1TB7co2kR+eNfe/5wHf+qxQ45bSU0Na5KtOiVecB9
 dNbo3E+trBfBfFfF1HPq7IWGRSKV823vq7rBwuVaEMKAQAA
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 "shenjian (K)" <shenjian15@huawei.com>, Simon Horman <horms@kernel.org>, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11682; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=keJGhzIL/wTU/BvrBynL8CCNPOv41zq8DR3sI+W5IVs=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBmdSsEp1eE6/NTvIs8tUaSYVRdz2gRktXxbNkbg
 40NOhU/7BWJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZnUrBAAKCRDBk9HyqkZz
 gnEsD/9A/K7+5Wuim/TbZQGGL5d3epDXMq063Zu0dAj9B//9LY8eoYmj+CJ1kfNEkZ8eiZUUKOi
 CSj6EnFzNOxle+mOOAVvV7kmTLxJxFebZBRl9kHN0Z1rJBXPEfhkbzhw8wFYIr32SVQQFHrkjkS
 YnjTVVYtGN2A05f5z5L1JpUtm5wsKqz4Rc1ZVFW9uRTdMp0QOEmt39e+Ce8yMAi5g1yYcbxfKup
 vzY2RmvSysGNT+mKadvSU5Mzkd4ipy3BPNfUL7D48wujPfnLm4GznVGVeceBFzyBlstLsgCIhno
 02j7Z3ybzatIpyPnN91tWlKJU0IKMBNOINGn1+urN/YI5iwfxs3TP8XS+VB/iKTtQBfK5pn/UxM
 VsSbhQn3DfhXTyUvhKtFQHeKgaFBeK7SJ7nrxmD7OjIYe4kv2Ae9ugUfbPcW69C8Ku/tk9Yp45n
 A/dgyNTa/rMBcGxYZPImpoMng4N9XCIbkcLjrQesk6fmxmLI1sSb7WrzID2dCbMQ0lJviG65INS
 EHPhmWHyiIxwTWhU1840unpL4wbfr+0qkAiYaKhe9JFrL5ijiGdiT0RWZyuaWaXftKWLiOnsr12
 vAcA6nueOYQ219UH1oTuyMLZrjDGXW60a4DGgoMqQATrtWyzMuJqc6dNGM1FhdAB/OVyYsmBI5N
 TkGfQt/nZrOUbcQ==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Add support for offloading MQPRIO. The hardware has four priorities as well
as four queues. Each queue must be a assigned with a unique priority.

However, the priorities are only considered in TSN Tx mode. There are two
TSN Tx modes. In case of MQPRIO the Qbv capability is not required.
Therefore, use the legacy TSN Tx mode, which performs strict priority
arbitration.

Example for mqprio with hardware offload:

|tc qdisc replace dev ${INTERFACE} handle 100 parent root mqprio num_tc 4 \
|   map 0 0 0 0 0 1 2 3 0 0 0 0 0 0 0 0 \
|   queues 1@0 1@1 1@2 1@3 \
|   hw 1

The mqprio Qdisc also allows to configure the `preemptible_tcs'. However,
frame preemption is not supported yet.

Tested on Intel i225 and implemented by following data sheet section 7.5.2,
Transmit Scheduling.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
Changes in v3:
- Use FIELD_PREP for Tx ARB (Simon)
- Add helper for Tx ARB configuration (Simon)
- Limit ethtool_set_channels when mqprio is enabled (Jian)
- Link to v2: https://lore.kernel.org/r/20240212-igc_mqprio-v2-1-587924e6b18c@linutronix.de

Changes in v2:
- Improve changelog (Paul Menzel)
- Link to v1: https://lore.kernel.org/r/20240212-igc_mqprio-v1-1-7aed95b736db@linutronix.de
---
 drivers/net/ethernet/intel/igc/igc.h         | 10 +++-
 drivers/net/ethernet/intel/igc/igc_defines.h | 11 +++++
 drivers/net/ethernet/intel/igc/igc_ethtool.c |  4 ++
 drivers/net/ethernet/intel/igc/igc_main.c    | 69 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc_regs.h    |  2 +
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 70 +++++++++++++++++++++++++++-
 6 files changed, 163 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index 8b14c029eda1..b31cd2d7120d 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -260,6 +260,10 @@ struct igc_adapter {
 	 */
 	spinlock_t qbv_tx_lock;
 
+	bool strict_priority_enable;
+	u8 num_tc;
+	u16 queue_per_tc[IGC_MAX_TX_QUEUES];
+
 	/* OS defined structs */
 	struct pci_dev *pdev;
 	/* lock for statistics */
@@ -383,9 +387,11 @@ extern char igc_driver_name[];
 #define IGC_FLAG_RX_LEGACY		BIT(16)
 #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
 #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
+#define IGC_FLAG_TSN_LEGACY_ENABLED	BIT(19)
 
-#define IGC_FLAG_TSN_ANY_ENABLED \
-	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED)
+#define IGC_FLAG_TSN_ANY_ENABLED				\
+	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
+	 IGC_FLAG_TSN_LEGACY_ENABLED)
 
 #define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
 #define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 5f92b3c7c3d4..58f6631bfdd5 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -4,6 +4,8 @@
 #ifndef _IGC_DEFINES_H_
 #define _IGC_DEFINES_H_
 
+#include <linux/bitfield.h>
+
 /* Number of Transmit and Receive Descriptors must be a multiple of 8 */
 #define REQ_TX_DESCRIPTOR_MULTIPLE	8
 #define REQ_RX_DESCRIPTOR_MULTIPLE	8
@@ -547,6 +549,15 @@
 
 #define IGC_MAX_SR_QUEUES		2
 
+#define IGC_TXARB_TXQ_PRIO_0_MASK	GENMASK(1, 0)
+#define IGC_TXARB_TXQ_PRIO_1_MASK	GENMASK(3, 2)
+#define IGC_TXARB_TXQ_PRIO_2_MASK	GENMASK(5, 4)
+#define IGC_TXARB_TXQ_PRIO_3_MASK	GENMASK(7, 6)
+#define IGC_TXARB_TXQ_PRIO_0(x)		FIELD_PREP(IGC_TXARB_TXQ_PRIO_0_MASK, (x))
+#define IGC_TXARB_TXQ_PRIO_1(x)		FIELD_PREP(IGC_TXARB_TXQ_PRIO_1_MASK, (x))
+#define IGC_TXARB_TXQ_PRIO_2(x)		FIELD_PREP(IGC_TXARB_TXQ_PRIO_2_MASK, (x))
+#define IGC_TXARB_TXQ_PRIO_3(x)		FIELD_PREP(IGC_TXARB_TXQ_PRIO_3_MASK, (x))
+
 /* Receive Checksum Control */
 #define IGC_RXCSUM_CRCOFL	0x00000800   /* CRC32 offload enable */
 #define IGC_RXCSUM_PCSD		0x00002000   /* packet checksum disabled */
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0cd2bd695db1..d436472f3388 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1540,6 +1540,10 @@ static int igc_ethtool_set_channels(struct net_device *netdev,
 	if (ch->other_count != NON_Q_VECTORS)
 		return -EINVAL;
 
+	/* Do not allow channel reconfiguration when mqprio is enabled */
+	if (adapter->strict_priority_enable)
+		return -EINVAL;
+
 	/* Verify the number of channels doesn't exceed hw limits */
 	max_combined = igc_get_max_rss_queues(adapter);
 	if (count > max_combined)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 87b655b839c1..7a027ef96e93 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6514,6 +6514,13 @@ static int igc_tc_query_caps(struct igc_adapter *adapter,
 	struct igc_hw *hw = &adapter->hw;
 
 	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+
+		return 0;
+	}
 	case TC_SETUP_QDISC_TAPRIO: {
 		struct tc_taprio_caps *caps = base->caps;
 
@@ -6531,6 +6538,65 @@ static int igc_tc_query_caps(struct igc_adapter *adapter,
 	}
 }
 
+static void igc_save_mqprio_params(struct igc_adapter *adapter, u8 num_tc,
+				   u16 *offset)
+{
+	int i;
+
+	adapter->strict_priority_enable = true;
+	adapter->num_tc = num_tc;
+
+	for (i = 0; i < num_tc; i++)
+		adapter->queue_per_tc[i] = offset[i];
+}
+
+static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
+				 struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct igc_hw *hw = &adapter->hw;
+	int i;
+
+	if (hw->mac.type != igc_i225)
+		return -EOPNOTSUPP;
+
+	if (!mqprio->qopt.num_tc) {
+		adapter->strict_priority_enable = false;
+		goto apply;
+	}
+
+	/* There are as many TCs as Tx queues. */
+	if (mqprio->qopt.num_tc != adapter->num_tx_queues) {
+		NL_SET_ERR_MSG_FMT_MOD(mqprio->extack,
+				       "Only %d traffic classes supported",
+				       adapter->num_tx_queues);
+		return -EOPNOTSUPP;
+	}
+
+	/* Only one queue per TC is supported. */
+	for (i = 0; i < mqprio->qopt.num_tc; i++) {
+		if (mqprio->qopt.count[i] != 1) {
+			NL_SET_ERR_MSG_MOD(mqprio->extack,
+					   "Only one queue per TC supported");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	/* Preemption is not supported yet. */
+	if (mqprio->preemptible_tcs) {
+		NL_SET_ERR_MSG_MOD(mqprio->extack,
+				   "Preemption is not supported yet");
+		return -EOPNOTSUPP;
+	}
+
+	igc_save_mqprio_params(adapter, mqprio->qopt.num_tc,
+			       mqprio->qopt.offset);
+
+	mqprio->qopt.hw = TC_MQPRIO_HW_OFFLOAD_TCS;
+
+apply:
+	return igc_tsn_offload_apply(adapter);
+}
+
 static int igc_setup_tc(struct net_device *dev, enum tc_setup_type type,
 			void *type_data)
 {
@@ -6550,6 +6616,9 @@ static int igc_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	case TC_SETUP_QDISC_CBS:
 		return igc_tsn_enable_cbs(adapter, type_data);
 
+	case TC_SETUP_QDISC_MQPRIO:
+		return igc_tsn_enable_mqprio(adapter, type_data);
+
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index e5b893fc5b66..c83c723f7c7e 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -238,6 +238,8 @@
 #define IGC_TQAVCC(_n)		(0x3004 + ((_n) * 0x40))
 #define IGC_TQAVHC(_n)		(0x300C + ((_n) * 0x40))
 
+#define IGC_TXARB		0x3354 /* Tx Arbitration Control TxARB - RW */
+
 /* System Time Registers */
 #define IGC_SYSTIML	0x0B600  /* System time register Low - RO */
 #define IGC_SYSTIMH	0x0B604  /* System time register High - RO */
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 22cefb1eeedf..5222323b2478 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -46,6 +46,9 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
 	if (is_cbs_enabled(adapter))
 		new_flags |= IGC_FLAG_TSN_QAV_ENABLED;
 
+	if (adapter->strict_priority_enable)
+		new_flags |= IGC_FLAG_TSN_LEGACY_ENABLED;
+
 	return new_flags;
 }
 
@@ -78,11 +81,32 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
 	wr32(IGC_GTXOFFSET, txoffset);
 }
 
+static void igc_tsn_tx_arb(struct igc_adapter *adapter, u16 *queue_per_tc)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u32 txarb;
+
+	txarb = rd32(IGC_TXARB);
+
+	txarb &= ~(IGC_TXARB_TXQ_PRIO_0_MASK |
+		   IGC_TXARB_TXQ_PRIO_1_MASK |
+		   IGC_TXARB_TXQ_PRIO_2_MASK |
+		   IGC_TXARB_TXQ_PRIO_3_MASK);
+
+	txarb |= IGC_TXARB_TXQ_PRIO_0(queue_per_tc[3]);
+	txarb |= IGC_TXARB_TXQ_PRIO_1(queue_per_tc[2]);
+	txarb |= IGC_TXARB_TXQ_PRIO_2(queue_per_tc[1]);
+	txarb |= IGC_TXARB_TXQ_PRIO_3(queue_per_tc[0]);
+
+	wr32(IGC_TXARB, txarb);
+}
+
 /* Returns the TSN specific registers to their default values after
  * the adapter is reset.
  */
 static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 {
+	u16 queue_per_tc[4] = { 3, 2, 1, 0 };
 	struct igc_hw *hw = &adapter->hw;
 	u32 tqavctrl;
 	int i;
@@ -106,7 +130,16 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	wr32(IGC_QBVCYCLET_S, 0);
 	wr32(IGC_QBVCYCLET, NSEC_PER_SEC);
 
+	/* Reset mqprio TC configuration. */
+	netdev_reset_tc(adapter->netdev);
+
+	/* Restore the default Tx arbitration: Priority 0 has the highest
+	 * priority and is assigned to queue 0 and so on and so forth.
+	 */
+	igc_tsn_tx_arb(adapter, queue_per_tc);
+
 	adapter->flags &= ~IGC_FLAG_TSN_QBV_ENABLED;
+	adapter->flags &= ~IGC_FLAG_TSN_LEGACY_ENABLED;
 
 	return 0;
 }
@@ -123,6 +156,40 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
 	wr32(IGC_TXPBS, IGC_TXPBSIZE_TSN);
 
+	if (adapter->strict_priority_enable) {
+		int err;
+
+		err = netdev_set_num_tc(adapter->netdev, adapter->num_tc);
+		if (err)
+			return err;
+
+		for (i = 0; i < adapter->num_tc; i++) {
+			err = netdev_set_tc_queue(adapter->netdev, i, 1,
+						  adapter->queue_per_tc[i]);
+			if (err)
+				return err;
+		}
+
+		/* In case the card is configured with less than four queues. */
+		for (; i < IGC_MAX_TX_QUEUES; i++)
+			adapter->queue_per_tc[i] = i;
+
+		/* Configure queue priorities according to the user provided
+		 * mapping.
+		 */
+		igc_tsn_tx_arb(adapter, adapter->queue_per_tc);
+
+		/* Enable legacy TSN mode which will do strict priority without
+		 * any other TSN features.
+		 */
+		tqavctrl = rd32(IGC_TQAVCTRL);
+		tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN;
+		tqavctrl &= ~IGC_TQAVCTRL_ENHANCED_QAV;
+		wr32(IGC_TQAVCTRL, tqavctrl);
+
+		return 0;
+	}
+
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
 		u32 txqctl = 0;
@@ -339,7 +406,8 @@ int igc_tsn_offload_apply(struct igc_adapter *adapter)
 	 * cannot be changed dynamically. Require reset the adapter.
 	 */
 	if (netif_running(adapter->netdev) &&
-	    (igc_is_device_id_i225(hw) || !adapter->qbv_count)) {
+	    (igc_is_device_id_i225(hw) || !adapter->qbv_count ||
+	     !adapter->strict_priority_enable)) {
 		schedule_work(&adapter->reset_task);
 		return 0;
 	}

---
base-commit: a6ec08beec9ea93f342d6daeac922208709694dc
change-id: 20240212-igc_mqprio-039650006128

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


