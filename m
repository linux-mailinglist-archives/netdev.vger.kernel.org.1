Return-Path: <netdev+bounces-98563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C858D1C82
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DBA1C22571
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80591171079;
	Tue, 28 May 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJzXWA8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961216F267
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902134; cv=none; b=hZbS4mBpJfBHpu/PV2w3k3kbAAl092QaSxqyO2epsAQEWDmdyXJRnDgJXA5FHTZshNghIEQbEFqLb4KcjvkZOFLNzKIi88/qGh67GgpGH/sK3ZeByhE9FBkdsWWwu/n0baRIIF0eXvSmFhxaU1wKHQN3Whv6FIpKcOeeRyX5nhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902134; c=relaxed/simple;
	bh=ROb1fNo4eUUBVPk/vZTtKWpVQ5tdIGh5tR00KpxWySo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1+Z3qyTR4S9BHVuqMk2MgZlt/W83ZzLJKMWMUrfYjINGvEXnm9IarcmE8R4pAMEootjJhJdIH3P88vmhIMJ3kIV7e8EJdof9p1WmjeE9VvRUdPyenD/+YlRWmmGHGnFBuzhhSgmcmOp7l8jaeHpUW3MoQaDxK+h0FphUajQsRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJzXWA8Z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902133; x=1748438133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ROb1fNo4eUUBVPk/vZTtKWpVQ5tdIGh5tR00KpxWySo=;
  b=TJzXWA8Zgqpp36e+7HKHXyIj3I8wqNNbbvlG4QmnyaxsI1nQpKQ00QKk
   YTnwwKnQB/88Y8F2gvUwTPO4I1BmaL//+z4I8th5He5kVYMWQFkrlompo
   mPoNVg/cdLx8Eh3sh3nx6QOaSMU1vwYwiGpSseNCjlz6OmIQFpBHuU3Y2
   zNXMq+CshOH5k7OyqcEJAcow3GfMPo00hsZkcQXGzVP3EXkbTX/6aDp1k
   3Wui/uqV48TENpmlTPkYuzvRuYIZ8Ei2EcbFZS3Tq6FVsQbA+7JlvZEhQ
   TnxGuOXDSRCjBzHcgnGEfLQCjtVxU+vHMOdCLA8SW+pD5nNEKbhQ2V/bc
   w==;
X-CSE-ConnectionGUID: T6f4ZAUASIKNQ9Rj0k3DUQ==
X-CSE-MsgGUID: U775DJd7Ts+3ksnsGf3Tfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193525"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193525"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:31 -0700
X-CSE-ConnectionGUID: snxPHJpoRPO3MbU5aeH8Fw==
X-CSE-MsgGUID: 9LakitMJS7+V6bWMmQfCHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891105"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:29 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 01/11] ice: respect netif readiness in AF_XDP ZC related ndo's
Date: Tue, 28 May 2024 15:14:19 +0200
Message-Id: <20240528131429.3012910-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
References: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
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


