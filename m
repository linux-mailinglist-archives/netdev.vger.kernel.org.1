Return-Path: <netdev+bounces-73451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8340685CA3E
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38A071F23030
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FB9152E06;
	Tue, 20 Feb 2024 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ix5OTGQM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9E152E12
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465597; cv=none; b=H1atKu+QmDrv/QV9ttCeDLt2JxBjPSaf90GS2DOEwLStJtDar5u49tq+P6QW1kFhMluuLTn5qZl2ejgGCA+UQAcYtx75FU2TZknORjFzShXXX8yVYtj2lN8E6uYDEj2PmxJGpTwurL2doKZgpF4N+yW8LI/Keg0QS7xcK9Zeec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465597; c=relaxed/simple;
	bh=EQBBZrUMfaIxKRF6wbG6jkwDinDonJrtXR5podir5pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMPvJXD6LtzFBks9PfoZE2Yf5EiHVye/eXw+a7x7JnQp/b3k3/ASqfyJS/BN+ECZB/XDPIflGLZXGOLboElIWLGKlTEcsG45rhUMrhJSMiVSWVA4/cl8JSK213o1tELvzZuclObVJuq22QizeGgE++p+B24MboxWry5mvOCqp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ix5OTGQM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465596; x=1740001596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EQBBZrUMfaIxKRF6wbG6jkwDinDonJrtXR5podir5pU=;
  b=Ix5OTGQMEgSNPtFyFF64kbNaYI4i52G5bdD8/Sz+UbeCLzLBT9ZaQrJU
   nPtQ7H/SNSSTMhGddTzV7n4+beferao01EOUa1CT2fzc2wKLXh/9eIVC6
   qI3hRfYHn75XlkmPQdi1XpZo53xBehEZ9iCcQfHqYB4LhmAb3H4wDhszx
   92cqrS/NpBM5hS01hOtWrI/gZHO4ATApviH7bzhFqYKK1OCCQqMEybjds
   C3ZbM8ZtvyOC6KE60K+eBrmSIh5a4xJxsgekHB2XtGudhcKYmH1AcB/KD
   QgxE5HSNMXoEwX5k07QiYQ6Z35Qse/aCn0ZVi14SUnRsKJmuvNDnbzPJZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2462671"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2462671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:46:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="35681903"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2024 13:46:33 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 3/3] ice: reorder disabling IRQ and NAPI in ice_qp_dis
Date: Tue, 20 Feb 2024 22:45:53 +0100
Message-Id: <20240220214553.714243-4-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
References: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_qp_dis() currently does things in very mixed way. Tx is stopped
before disabling IRQ on related queue vector, then it takes care of
disabling Rx and finally NAPI is disabled.

Let us start with disabling IRQs in the first place followed by turning
off NAPI. Then it is safe to handle queues.

One subtle change on top of that is that even though ice_qp_ena() looks
more sane, clear ICE_CFG_BUSY as the last thing there.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 8b81a1677045..2eecd0f39aa6 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -179,6 +179,10 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 			return -EBUSY;
 		usleep_range(1000, 2000);
 	}
+
+	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
+	ice_qvec_toggle_napi(vsi, q_vector, false);
+
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
@@ -195,13 +199,10 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
-
 	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
 	if (err)
 		return err;
 
-	ice_qvec_toggle_napi(vsi, q_vector, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
@@ -259,11 +260,11 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	if (err)
 		return err;
 
-	clear_bit(ICE_CFG_BUSY, vsi->state);
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
 
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return 0;
 }
-- 
2.34.1


