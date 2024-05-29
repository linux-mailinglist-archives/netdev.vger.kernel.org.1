Return-Path: <netdev+bounces-99001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7A78D3579
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887DD2866B5
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D3617F365;
	Wed, 29 May 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bgffExpc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5317A938
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981826; cv=none; b=EXeOGVSGgf+rFZvXKDS6XEZggh/4u5yXnUhYPo5Sm+o6zgiXLP9nLyMQt/h8ToumQAHVeHwioPDlvQuAzYBVLPnFexg8JgN15qv/8ApVuGQf5mjGdcm5Oi6BQkN+lhwF3MKaraTPWB+uzkbtkcDQSZOpi60pzudfFaZf/AG61J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981826; c=relaxed/simple;
	bh=ROb1fNo4eUUBVPk/vZTtKWpVQ5tdIGh5tR00KpxWySo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvBOeBIKp1qIuWLOIkbd9PpvFc9MOy2zihL3UK9IAQMi/tzo77mDeOCNw67M1dTfLeXkmKdhL2IIQ28VNWa6cCmjhB6NUWQT44eKglneXAC0COyWxTw1tIV3Jwu6x1SoGq2ZIyGHTiC7DdFTOSw5VqiH6q6FDgwlFqQGcS6+gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bgffExpc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716981824; x=1748517824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ROb1fNo4eUUBVPk/vZTtKWpVQ5tdIGh5tR00KpxWySo=;
  b=bgffExpcroy9Ob70I9qOU7sBilBmKTyGF9d24nPl7O4wqbRyVIaWaHQj
   ynWw8w0LP2qWXWVknkcQJLwJvTMRoXTWNy9qQ8Ak5caV6XsJn/cW7N8e+
   D9ERsqEf0RP8A7UfDrTv2Z+0rW8iIdaafiXP6+2eonU+nHwnC4czaSXkH
   Y5oTyNvop7Qt7DAOH2ABtOm6xVPTsi3WTs20kPu5jxgAu+Snt/HhUE1gH
   Ws28yyaDDOHRtWSixBuA54ufVMXzJ5fFGpkErmLu7vQvfY6ppcuefDIrb
   9DlSTqT42QaLv7TlTzjkXRg4QJ5+GUeLZBme+zZYRTB3gmMkEIwZ3cuvB
   A==;
X-CSE-ConnectionGUID: vTF4QIOhR6CJq/Qv/be54g==
X-CSE-MsgGUID: zDkbxAc+SFqwGq0wgrJAuA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17169223"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="17169223"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 04:23:44 -0700
X-CSE-ConnectionGUID: ooCYZPpaQku7TvvEwklyDQ==
X-CSE-MsgGUID: G3RW5C5ESveffRA/2C9iyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="66277168"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 29 May 2024 04:23:42 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 iwl-net 1/8] ice: respect netif readiness in AF_XDP ZC related ndo's
Date: Wed, 29 May 2024 13:23:30 +0200
Message-Id: <20240529112337.3639084-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
References: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
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
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 2015f66b0cf9..1bd4b054dd80 100644
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


