Return-Path: <netdev+bounces-107291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D6A91A7AE
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F66A283159
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E9E192B8B;
	Thu, 27 Jun 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F8Z0nzQd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F041922FF
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719494327; cv=none; b=Gb1ZhEEiAJXDTDSspWYILgkItFSWvKgHqDS/tSdMIIiNJvm3yoOHBXEQD3JSZ2MY2g4KTMFgg0PJNqNj8S5tShx/NHXtnNtZ+uG77PnfWF8l4Hjj12nAW4EHsW1CbTER22EPWFuriRgYvJT4sjUerIK2/ABvClOKFtegOMC6p4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719494327; c=relaxed/simple;
	bh=iQ/9HbZUPqxoVo1bdBIyY2nG6c2SzdJzTrMSU2GD4eE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XIpgTx227/K034Ge0Zu5e9GXOBRlvX5F4WL4M39zC4kvgqssmbXjoh0v3sHweXY+iYmgnRn0EKIXy5+4+TeMnypfWiJT16DUT03nakv2rE2r+WK0sLPpuiJ1AnKb90kWfhptIgAkqj5yRVuAOkLHlo8QlenhYv0tD0xbTB2andQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F8Z0nzQd; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719494326; x=1751030326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iQ/9HbZUPqxoVo1bdBIyY2nG6c2SzdJzTrMSU2GD4eE=;
  b=F8Z0nzQd3GpnhKuJyFN8qPLo0dCdBAh9Sajqic9RCc83NBv/0EwtjPuO
   TkZFere1bdYjaZQFvopGDF077l4BwOmsCarIfkqy52kK2XUCAFmq0/i9S
   drW24hjR63ilqGUQlCGkPQhmrn3Pq7TqrMEbxClhfbd4lnh0O/qdNYR2c
   teaFTgWr6orzaT1JFFsBXq76MoKaR9YxwM7XA3d8zzDZ5h1HzrIvL2wIp
   /SIFw02lbSk5OS+0Id0E0GGYU22M3H37m9yeYPTTEfSjrw/bA+tz85Ftk
   DDhKba4bYgOc9m33+4ZxGsKp5XDC98pbtOnf0g8MC2JP6PZlQn2E5hRjL
   w==;
X-CSE-ConnectionGUID: 7Wg9XBjWTCuFnr+lNApapQ==
X-CSE-MsgGUID: jjIRBc45T1W5laxuPWk7/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16452338"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16452338"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 06:18:45 -0700
X-CSE-ConnectionGUID: d3lXf33ZTJuUUMaUDmNR1Q==
X-CSE-MsgGUID: xnVpY13KSZ2cCPjHQiHCBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="49315367"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 27 Jun 2024 06:18:42 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	aleksander.lobakin@intel.com,
	michal.kubiak@intel.com,
	Shannon Nelson <shannon.nelson@amd.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v4 iwl-net 1/8] ice: respect netif readiness in AF_XDP ZC related ndo's
Date: Thu, 27 Jun 2024 15:17:50 +0200
Message-Id: <20240627131757.144991-2-maciej.fijalkowski@intel.com>
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

From: Michal Kubiak <michal.kubiak@intel.com>

Address a scenario in which XSK ZC Tx produces descriptors to XDP Tx
ring when link is either not yet fully initialized or process of
stopping the netdev has already started. To avoid this, add checks
against carrier readiness in ice_xsk_wakeup() and in ice_xmit_zc().
One could argue that bailing out early in ice_xsk_wakeup() would be
sufficient but given the fact that we produce Tx descriptors on behalf
of NAPI that is triggered for Rx traffic, the latter is also needed.

Bringing link up is an asynchronous event executed within
ice_service_task so even though interface has been brought up there is
still a time frame where link is not yet ok.

Without this patch, when AF_XDP ZC Tx is used simultaneously with stack
Tx, Tx timeouts occur after going through link flap (admin brings
interface down then up again). HW seem to be unable to transmit
descriptor to the wire after HW tail register bump which in turn causes
bit __QUEUE_STATE_STACK_XOFF to be set forever as
netdev_tx_completed_queue() sees no cleaned bytes on the input.

Fixes: 126cdfe1007a ("ice: xsk: Improve AF_XDP ZC Tx and use batching API")
Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index a65955eb23c0..72738b8b8a68 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -1048,6 +1048,10 @@ bool ice_xmit_zc(struct ice_tx_ring *xdp_ring)
 
 	ice_clean_xdp_irq_zc(xdp_ring);
 
+	if (!netif_carrier_ok(xdp_ring->vsi->netdev) ||
+	    !netif_running(xdp_ring->vsi->netdev))
+		return true;
+
 	budget = ICE_DESC_UNUSED(xdp_ring);
 	budget = min_t(u16, budget, ICE_RING_QUARTER(xdp_ring));
 
@@ -1091,7 +1095,7 @@ ice_xsk_wakeup(struct net_device *netdev, u32 queue_id,
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_tx_ring *ring;
 
-	if (test_bit(ICE_VSI_DOWN, vsi->state))
+	if (test_bit(ICE_VSI_DOWN, vsi->state) || !netif_carrier_ok(netdev))
 		return -ENETDOWN;
 
 	if (!ice_is_xdp_ena_vsi(vsi))
-- 
2.34.1


