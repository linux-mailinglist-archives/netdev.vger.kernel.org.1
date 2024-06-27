Return-Path: <netdev+bounces-107295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9665891A7B9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52932284AD6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DCF192B99;
	Thu, 27 Jun 2024 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwHcByJA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB21940A9
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494337; cv=none; b=L23+oSHE9VKDE5ykg7zCv7FnyjvG2MwYDzUs35eVL4oZWzuDVlbP0k8LjIBQWWyGaqBWDMVLna8NQtZISfQ5H9P45u6UR2XBhE/Kfo5aclmK7Evu5bTzlJxRrQJLEY/y+8vxKwovAB0/xsyHQFYgHa28oga5gVDzUVgqfGQlUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494337; c=relaxed/simple;
	bh=XvoRlqGncktv1xgCjbELElNoarbRYtEIlGwUPaqFV50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7IH+tPrBzKpZQnmqEqCUz3om63EInDiONehCqScKAf34JOHVknOa4k3iLLU1G8MPL+K5+jpcTfXfIVOwitxqiTxPAhROWd/5xKqdiU6uhFs4SS791YvgkDDRfCWlDBMHukSMGvzC36ptuhsKmW9AHMcgDv8P/tcARGFZ6pK3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwHcByJA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719494336; x=1751030336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XvoRlqGncktv1xgCjbELElNoarbRYtEIlGwUPaqFV50=;
  b=lwHcByJAQfTEz1C21jnbfduEwV4PR8dVIGCN5o2iO+Tb3b0qPHK7YAyA
   lZRwLTqAGrvB4n/WBpAJSPe6Cy0dnO5ySgqpA9Fo48t3Ooe1EMOjgPBiG
   h1ZU8A/XLutT9eLiTApxLqNKZG3yWHTnIrxxb38PT8jQs2R/KH97ubuyB
   sqLTpraQufK0av2o1mmkxpCNiH7Tqtg5C7Ae2+AIAgS2kwkZpvwOdKAqb
   IH/1n2YH4h0rvOOth+Kpd4zMonbv3nZdEEzht7qYD4si7GSeaAUtDiIvc
   VuUU8TBjhkb3lrQKi6nLJALqPr+ASK2smHeUYdSCuTxaEgyioqLfjtidd
   A==;
X-CSE-ConnectionGUID: okjD7tuHRLyF7JjgSXGBow==
X-CSE-MsgGUID: mOXdje+ORG2xY/oxZS2whg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16452361"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16452361"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 06:18:56 -0700
X-CSE-ConnectionGUID: Xkyb8akdQ8+TYntViXcjWg==
X-CSE-MsgGUID: sa0QjsZzRcyFeI2mjpfxLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49315399"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 27 Jun 2024 06:18:53 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	aleksander.lobakin@intel.com,
	michal.kubiak@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH v4 iwl-net 5/8] ice: toggle netif_carrier when setting up XSK pool
Date: Thu, 27 Jun 2024 15:17:54 +0200
Message-Id: <20240627131757.144991-6-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240627131757.144991-1-maciej.fijalkowski@intel.com>
References: <20240627131757.144991-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This so we prevent Tx timeout issues. One of conditions checked on
running in the background dev_watchdog() is netif_carrier_ok(), so let
us turn it off when we disable the queues that belong to a q_vector
where XSK pool is being configured. Turn carrier on in ice_qp_ena()
only when ice_get_link_status() tells us that physical link is up.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 902096b000f5..3fbe4cfadfbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -180,6 +180,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 	}
 
 	synchronize_net();
+	netif_carrier_off(vsi->netdev);
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
@@ -218,6 +219,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 {
 	struct ice_q_vector *q_vector;
 	int fail = 0;
+	bool link_up;
 	int err;
 
 	err = ice_vsi_cfg_single_txq(vsi, vsi->tx_rings, q_idx);
@@ -248,7 +250,11 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
 
-	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+	ice_get_link_status(vsi->port_info, &link_up);
+	if (link_up) {
+		netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+		netif_carrier_on(vsi->netdev);
+	}
 	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return fail;
-- 
2.34.1


