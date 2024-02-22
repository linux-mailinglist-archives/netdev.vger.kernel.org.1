Return-Path: <netdev+bounces-74043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDAA85FB97
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E411F25154
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE29A148FE0;
	Thu, 22 Feb 2024 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TKCOyKJN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C18C14691D
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 14:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613437; cv=none; b=fWHECKkMInoG31nyiRcqYc+uLNh385jXxIj+Zu2BQ/tB5t2bSijbxvmEZ+wfLZit4mtcODaxMedkJhkLd2rSactU7igyszcVIwL6MNdTsxi890ENPYaQO0/O2RWHKH88YcKY2ZDpQthFVW/8PX9Ow5JdrdxaEfodNeruo9tJV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613437; c=relaxed/simple;
	bh=BW7wwqyKxArUwiSHVbXejxxx5q8h4BjX8WMNFKPPFU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DcDtpqJgETUQcWRy1x+n7Y+gn5teCOviD8J8U2KM3dH3sjCDtzEEySDi0V6izbAjUmEOUkIi/Ibq/9EtgaVjK6FVq1FZNtQ61iwBbR9cp/zmLv3HPyAMQO1Ot48ceEypJDhqkceet3TmypDDKSfyYV3zQRg/2CDNGFo6E1byVS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TKCOyKJN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708613435; x=1740149435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BW7wwqyKxArUwiSHVbXejxxx5q8h4BjX8WMNFKPPFU4=;
  b=TKCOyKJN7kCZfX1gpHkT+cHI4TDyihpZW+LH39RKLwVTKBxxMkQhTIML
   k6hv9fO9CEe9/qjzS3kIZkcJtnuvRSI631YjKusflduSOo0pvPMtdFX/0
   T1Gr4O9839Nm92VR23Uh9Z/mWkKObeAxWDaTdW3Zfkix3XY8XvJrRuTBv
   J+y58G+renU1dYlQsi5LNqOn7aiSfmE5jckhYWtALK8lKYT4a6Dz/coVE
   VQStnOwsEFt64LfByuk/hlPS4DtidOTKjhZL6DYnHmYWyuf8gC3ZDGQ5m
   X/shR6hfRHX5CDryvVLabwCnapXMY0Nb01mnxTl/0O+/A4145V6uBbqM2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2949296"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2949296"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 06:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5670933"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa008.fm.intel.com with ESMTP; 22 Feb 2024 06:50:33 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-next 1/3] ice: do not disable Tx queues twice in ice_down()
Date: Thu, 22 Feb 2024 15:50:23 +0100
Message-Id: <20240222145025.722515-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240222145025.722515-1-maciej.fijalkowski@intel.com>
References: <20240222145025.722515-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_down() clears QINT_TQCTL_CAUSE_ENA_M bit twice, which is not
necessary. First clearing happens in ice_vsi_dis_irq() and second in
ice_vsi_stop_tx_ring() - remove the first one.

While at it, make ice_vsi_dis_irq() static as ice_down() is the only
current caller of it.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 55 -----------------------
 drivers/net/ethernet/intel/ice/ice_lib.h  |  2 -
 drivers/net/ethernet/intel/ice/ice_main.c | 44 ++++++++++++++++++
 3 files changed, 44 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9be724291ef8..9323bc1d4bdc 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2848,61 +2848,6 @@ void ice_dis_vsi(struct ice_vsi *vsi, bool locked)
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
  * ice_queue_set_napi - Set the napi instance for the queue
  * @dev: device to which NAPI and queue belong
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 71bd27244941..c394fe9abba4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -114,8 +114,6 @@ void
 ice_write_qrxflxp_cntxt(struct ice_hw *hw, u16 pf_q, u32 rxdid, u32 prio,
 			bool ena_ts);
 
-void ice_vsi_dis_irq(struct ice_vsi *vsi);
-
 void ice_vsi_free_irq(struct ice_vsi *vsi);
 
 void ice_vsi_free_rx_rings(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index dd4a9bc0dfdc..2358977324fd 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7059,6 +7059,50 @@ static void ice_napi_disable_all(struct ice_vsi *vsi)
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
2.34.1


