Return-Path: <netdev+bounces-77254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A82870CF6
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6CB1F21324
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510637CF08;
	Mon,  4 Mar 2024 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLmA1mVT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0257C0A0
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587787; cv=none; b=fXuPUTCnQZ/9FrmC6Ml+xKLLqErDBpX0RM8MwaI6PmCxFQ8yUZwcMsJENzHi19hEPWdK17y1wDoKoJvUf0RMcG+SggRQ0vaCOYTJEbjWfacY8+/5QUwOXNGBQGBE4FBVsPcvraOb0JWd0mCETad67lN20wJWAHRk735bBZO78uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587787; c=relaxed/simple;
	bh=LE+LNupttDs8R1qTaruY7FGyhWxYuP4xgT1tV0S86yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJ3D3fVmmcdb8kg1b1DAQtdVkuBa+je2bojPWpvIYGtvmuZggkQNMQoiy5gWeGGDGizvMGfiovDLzqx5FinutQBl7rC1SBH9E1nVN/i1DiKTA5PQqMoj4+FNjq2lfBEGymgkh+FuojFuBfh88AQHxzo41L1IIvsRReM0uFnIHZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLmA1mVT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709587785; x=1741123785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LE+LNupttDs8R1qTaruY7FGyhWxYuP4xgT1tV0S86yU=;
  b=DLmA1mVTIuU1ZKER01T5HNyEF3BudYvaIb6yAKLpAjQ8SERz+JPa9IRu
   IgpHBRqo4ffj2E+37WdNXLRjJNgRjb0imPvWYHmFkchJg6+cnVXCnW9LX
   ecqYKl4Hp7Enwcd3+Dlsuz771rz6xH/Op5WEFCvSPA1h3oqtwdx9Io5F+
   /NkxhrwWvmzJwzCvIFwmr/maln+miIZspuPnBaWcR1GL72OAkTh4rAgFi
   jrwWREiB/qjqnSHfc8D3kmQGFyRxOhPmU3NARhHq74HqbCU2FQGsV9dvn
   7yPUSyAR/h8mmBu++/S0XwrutFtA00s2qwFvqcpjnz6yel2OSzoOJoPdw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3968091"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3968091"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 13:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="46647890"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2024 13:29:41 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 8/9] ice: do not disable Tx queues twice in ice_down()
Date: Mon,  4 Mar 2024 13:29:29 -0800
Message-ID: <20240304212932.3412641-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
References: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

ice_down() clears QINT_TQCTL_CAUSE_ENA_M bit twice, which is not
necessary. First clearing happens in ice_vsi_dis_irq() and second in
ice_vsi_stop_tx_ring() - remove the first one.

While at it, make ice_vsi_dis_irq() static as ice_down() is the only
current caller of it.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 55 -----------------------
 drivers/net/ethernet/intel/ice/ice_lib.h  |  2 -
 drivers/net/ethernet/intel/ice/ice_main.c | 44 ++++++++++++++++++
 3 files changed, 44 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 59e8a2572985..48e4c33a3550 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2719,61 +2719,6 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
 	}
 }
 
-/**
- * ice_vsi_dis_irq - Mask off queue interrupt generation on the VSI
- * @vsi: the VSI being un-configured
- */
-void ice_vsi_dis_irq(struct ice_vsi *vsi)
-{
-	struct ice_pf *pf = vsi->back;
-	struct ice_hw *hw = &pf->hw;
-	u32 val;
-	int i;
-
-	/* disable interrupt causation from each queue */
-	if (vsi->tx_rings) {
-		ice_for_each_txq(vsi, i) {
-			if (vsi->tx_rings[i]) {
-				u16 reg;
-
-				reg = vsi->tx_rings[i]->reg_idx;
-				val = rd32(hw, QINT_TQCTL(reg));
-				val &= ~QINT_TQCTL_CAUSE_ENA_M;
-				wr32(hw, QINT_TQCTL(reg), val);
-			}
-		}
-	}
-
-	if (vsi->rx_rings) {
-		ice_for_each_rxq(vsi, i) {
-			if (vsi->rx_rings[i]) {
-				u16 reg;
-
-				reg = vsi->rx_rings[i]->reg_idx;
-				val = rd32(hw, QINT_RQCTL(reg));
-				val &= ~QINT_RQCTL_CAUSE_ENA_M;
-				wr32(hw, QINT_RQCTL(reg), val);
-			}
-		}
-	}
-
-	/* disable each interrupt */
-	ice_for_each_q_vector(vsi, i) {
-		if (!vsi->q_vectors[i])
-			continue;
-		wr32(hw, GLINT_DYN_CTL(vsi->q_vectors[i]->reg_idx), 0);
-	}
-
-	ice_flush(hw);
-
-	/* don't call synchronize_irq() for VF's from the host */
-	if (vsi->type == ICE_VSI_VF)
-		return;
-
-	ice_for_each_q_vector(vsi, i)
-		synchronize_irq(vsi->q_vectors[i]->irq.virq);
-}
-
 /**
  * __ice_queue_set_napi - Set the napi instance for the queue
  * @dev: device to which NAPI and queue belong
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index b5a1ed7cc4b1..9cd23afe5f15 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -110,8 +110,6 @@ void
 ice_write_qrxflxp_cntxt(struct ice_hw *hw, u16 pf_q, u32 rxdid, u32 prio,
 			bool ena_ts);
 
-void ice_vsi_dis_irq(struct ice_vsi *vsi);
-
 void ice_vsi_free_irq(struct ice_vsi *vsi);
 
 void ice_vsi_free_rx_rings(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8f73ba77e835..062b4ea8e2c3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7001,6 +7001,50 @@ static void ice_napi_disable_all(struct ice_vsi *vsi)
 	}
 }
 
+/**
+ * ice_vsi_dis_irq - Mask off queue interrupt generation on the VSI
+ * @vsi: the VSI being un-configured
+ */
+static void ice_vsi_dis_irq(struct ice_vsi *vsi)
+{
+	struct ice_pf *pf = vsi->back;
+	struct ice_hw *hw = &pf->hw;
+	u32 val;
+	int i;
+
+	/* disable interrupt causation from each Rx queue; Tx queues are
+	 * handled in ice_vsi_stop_tx_ring()
+	 */
+	if (vsi->rx_rings) {
+		ice_for_each_rxq(vsi, i) {
+			if (vsi->rx_rings[i]) {
+				u16 reg;
+
+				reg = vsi->rx_rings[i]->reg_idx;
+				val = rd32(hw, QINT_RQCTL(reg));
+				val &= ~QINT_RQCTL_CAUSE_ENA_M;
+				wr32(hw, QINT_RQCTL(reg), val);
+			}
+		}
+	}
+
+	/* disable each interrupt */
+	ice_for_each_q_vector(vsi, i) {
+		if (!vsi->q_vectors[i])
+			continue;
+		wr32(hw, GLINT_DYN_CTL(vsi->q_vectors[i]->reg_idx), 0);
+	}
+
+	ice_flush(hw);
+
+	/* don't call synchronize_irq() for VF's from the host */
+	if (vsi->type == ICE_VSI_VF)
+		return;
+
+	ice_for_each_q_vector(vsi, i)
+		synchronize_irq(vsi->q_vectors[i]->irq.virq);
+}
+
 /**
  * ice_down - Shutdown the connection
  * @vsi: The VSI being stopped
-- 
2.41.0


