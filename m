Return-Path: <netdev+bounces-191392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E282ABB60F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41A527A6E20
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71212267B0C;
	Mon, 19 May 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJIN/Pio"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DF267F43;
	Mon, 19 May 2025 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747639255; cv=none; b=nX9N53afMuZ3INxZhwghQ2Hp8qTdcL8mK5MXWfzwGLku0lSY+4/pWm1mNLJWE1QtXXr9aex/QgpIfUDuhe/b1kxvrgQuQ74zdDYPGPDISUWEY44bozCGT5165AYcB/dtc1liUDEDmfrzxFkhszB2BH7jaHvcePzMex22ZMuBOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747639255; c=relaxed/simple;
	bh=eNzloNIoEXB/yepq9/BmYUsrKVK9QvnC22RSQhugWgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snIV4V1tFy7ukFpm+op/tZbB1xGwK2zQPruvhz27Hs3T9KsvtPVljKEeY+jWFXvVGn4EfpJIwX2PVqBOUXQ0xMv5Yer3+zetUpvtHAcFoLTa4Tea42aiEOqDYwcEf5Dn9oE+qQ+GYIgtEaG7G+GPsxyUPUYIAKVUkstnZIIf9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJIN/Pio; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747639253; x=1779175253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eNzloNIoEXB/yepq9/BmYUsrKVK9QvnC22RSQhugWgE=;
  b=VJIN/PiooqCzh+c6JkIRKZ8dWQSccK7vqdxsNHuUQkBXPET8nBbbQUap
   nQ4m3d09QYpAA1WVFaKdtwbcYuGCIGrihP2ppYd8rn7cYdn99fSEQsQjj
   acbZyAQxX0VErNZqB2PpGS/fmZMuuB1LB2i6e25VD8tXSoPhEStczwmUx
   oZ3ui0I/foPBETgkXRyXzHAZBebmzgePPzbUaR+bQUBs5XGCDpVSn+dRy
   14Y4J/35HPTf+cKPmBFN9ph5RNzusI0fWaS6CLKm72yS1bIOMwsbEyUUa
   hllKU8qVWPOtX5MGOsUyzNssRUc+rwkdmphZNXZVpJ1Y6ij4s46b2Ncfc
   w==;
X-CSE-ConnectionGUID: bMexMrslR6GB8fLdLZQ21w==
X-CSE-MsgGUID: QUO0GqVdT8Od9jw5Az0c9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="72030738"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="72030738"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 00:20:53 -0700
X-CSE-ConnectionGUID: fOqtxuL1SYGUZDLmQJzPtQ==
X-CSE-MsgGUID: kTl+MainQY61t8WzPKXsHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139798836"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
  by orviesa007.jf.intel.com with ESMTP; 19 May 2025 00:20:50 -0700
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: [PATCH iwl-next v3 4/7] igc: assign highest TX queue number as highest priority in mqprio
Date: Mon, 19 May 2025 03:19:08 -0400
Message-Id: <20250519071911.2748406-5-faizal.abdul.rahim@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250519071911.2748406-1-faizal.abdul.rahim@intel.com>
References: <20250519071911.2748406-1-faizal.abdul.rahim@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Previously, TX arbitration prioritized queues based on the TC they were
mapped to. A queue mapped to TC 3 had higher priority than one mapped to
TC 0.

To improve code reuse for upcoming patches and align with typical NIC
behavior, this patch updates the logic to prioritize higher queue numbers
when mqprio is used. As a result, queue 0 becomes the lowest priority and
queue 3 becomes the highest.

This patch also introduces igc_tsn_is_tc_to_queue_priority_ordered() to
preserve the original TC-based priority rule and reject configurations
where a higher TC maps to a lower queue offset.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 19 ++++++++++++
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 35 ++++++++++++++---------
 2 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index f3a312c9413b..1033d64fc0e8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6724,6 +6724,19 @@ static void igc_save_mqprio_params(struct igc_adapter *adapter, u8 num_tc,
 		adapter->queue_per_tc[i] = offset[i];
 }
 
+static bool igc_tsn_is_tc_to_queue_priority_ordered(struct tc_mqprio_qopt_offload *mqprio)
+{
+	int i;
+	int num_tc = mqprio->qopt.num_tc;
+
+	for (i = 1; i < num_tc; i++) {
+		if (mqprio->qopt.offset[i - 1] > mqprio->qopt.offset[i])
+			return false;
+	}
+
+	return true;
+}
+
 static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 				 struct tc_mqprio_qopt_offload *mqprio)
 {
@@ -6756,6 +6769,12 @@ static int igc_tsn_enable_mqprio(struct igc_adapter *adapter,
 		}
 	}
 
+	if (!igc_tsn_is_tc_to_queue_priority_ordered(mqprio)) {
+		NL_SET_ERR_MSG_MOD(mqprio->extack,
+				   "tc to queue mapping must preserve increasing priority (higher tc → higher queue)");
+		return -EOPNOTSUPP;
+	}
+
 	/* Preemption is not supported yet. */
 	if (mqprio->preemptible_tcs) {
 		NL_SET_ERR_MSG_MOD(mqprio->extack,
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index f22cc4d4f459..78a4a9cf5f96 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -13,6 +13,13 @@
 #define TX_MAX_FRAG_SIZE	(TX_MIN_FRAG_SIZE * \
 				 (MAX_MULTPLIER_TX_MIN_FRAG + 1))
 
+enum tx_queue {
+	TX_QUEUE_0 = 0,
+	TX_QUEUE_1,
+	TX_QUEUE_2,
+	TX_QUEUE_3,
+};
+
 DEFINE_STATIC_KEY_FALSE(igc_fpe_enabled);
 
 static int igc_fpe_init_smd_frame(struct igc_ring *ring,
@@ -238,7 +245,7 @@ bool igc_tsn_is_taprio_activated_by_user(struct igc_adapter *adapter)
 		adapter->taprio_offload_enable;
 }
 
-static void igc_tsn_tx_arb(struct igc_adapter *adapter, u16 *queue_per_tc)
+static void igc_tsn_tx_arb(struct igc_adapter *adapter, bool reverse_prio)
 {
 	struct igc_hw *hw = &adapter->hw;
 	u32 txarb;
@@ -250,10 +257,17 @@ static void igc_tsn_tx_arb(struct igc_adapter *adapter, u16 *queue_per_tc)
 		   IGC_TXARB_TXQ_PRIO_2_MASK |
 		   IGC_TXARB_TXQ_PRIO_3_MASK);
 
-	txarb |= IGC_TXARB_TXQ_PRIO_0(queue_per_tc[3]);
-	txarb |= IGC_TXARB_TXQ_PRIO_1(queue_per_tc[2]);
-	txarb |= IGC_TXARB_TXQ_PRIO_2(queue_per_tc[1]);
-	txarb |= IGC_TXARB_TXQ_PRIO_3(queue_per_tc[0]);
+	if (reverse_prio) {
+		txarb |= IGC_TXARB_TXQ_PRIO_0(TX_QUEUE_3);
+		txarb |= IGC_TXARB_TXQ_PRIO_1(TX_QUEUE_2);
+		txarb |= IGC_TXARB_TXQ_PRIO_2(TX_QUEUE_1);
+		txarb |= IGC_TXARB_TXQ_PRIO_3(TX_QUEUE_0);
+	} else {
+		txarb |= IGC_TXARB_TXQ_PRIO_0(TX_QUEUE_0);
+		txarb |= IGC_TXARB_TXQ_PRIO_1(TX_QUEUE_1);
+		txarb |= IGC_TXARB_TXQ_PRIO_2(TX_QUEUE_2);
+		txarb |= IGC_TXARB_TXQ_PRIO_3(TX_QUEUE_3);
+	}
 
 	wr32(IGC_TXARB, txarb);
 }
@@ -286,7 +300,6 @@ static void igc_tsn_set_rxpbsize(struct igc_adapter *adapter,
  */
 static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 {
-	u16 queue_per_tc[4] = { 3, 2, 1, 0 };
 	struct igc_hw *hw = &adapter->hw;
 	u32 tqavctrl;
 	int i;
@@ -319,7 +332,7 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	/* Restore the default Tx arbitration: Priority 0 has the highest
 	 * priority and is assigned to queue 0 and so on and so forth.
 	 */
-	igc_tsn_tx_arb(adapter, queue_per_tc);
+	igc_tsn_tx_arb(adapter, false);
 
 	adapter->flags &= ~IGC_FLAG_TSN_QBV_ENABLED;
 
@@ -385,12 +398,8 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
 	if (igc_is_device_id_i226(hw))
 		igc_tsn_set_retx_qbvfullthreshold(adapter);
 
-	if (adapter->strict_priority_enable) {
-		/* Configure queue priorities according to the user provided
-		 * mapping.
-		 */
-		igc_tsn_tx_arb(adapter, adapter->queue_per_tc);
-	}
+	if (adapter->strict_priority_enable)
+		igc_tsn_tx_arb(adapter, true);
 
 	for (i = 0; i < adapter->num_tx_queues; i++) {
 		struct igc_ring *ring = adapter->tx_ring[i];
-- 
2.34.1


