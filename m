Return-Path: <netdev+bounces-76525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5FA86E09F
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 12:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C30282F73
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E623B6CDD0;
	Fri,  1 Mar 2024 11:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlCIhrjy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5116D1BB
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293795; cv=none; b=dW8Nal7QU7I3+it5spIhIkRZ3Vxh+0PpSk1lik2enlVF182pOfWUIxkAK/xETs7FZkw+6t7aGVYnwNdI3zlR6kB0XVr1kjqFYgbBrt2BIdmAvW2SIPieft7cOF/zxrZKb63lscaeTJJtJNIIrpemTwlIbBjqkoJgiAYuqT1IACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293795; c=relaxed/simple;
	bh=Y3mKbWe5Ja4zuaLAeR5o+tou2lig1vky9SwusxY6/oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsWRxbYVhrUJD6boK171S8Bwxw73j1dx+GO1k7VPIj4qVS7uM1PRSJ1dLaYDjn2AbLKuNoiuwgqP20uc/Do66kdB74fPs0P8su/E9dowBd3TxBsyNRr6wXqwo7hKREHvxMCLDDFfk9p8oGef+psGN2xSAqoqBJA9PAs8995iRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlCIhrjy; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709293794; x=1740829794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y3mKbWe5Ja4zuaLAeR5o+tou2lig1vky9SwusxY6/oQ=;
  b=mlCIhrjyyqpeqjLVvgeyUQeyeG841/PixTA5b6WPhj/Ibv8FJQVtiffR
   dWPGFhFu1DZqw11Nbshk657xWCvXPZDqCzJrSw+KYSYb648g9K7/gUgGd
   NvYIPrOBzyh30mFByWfjyga2PUeaBm9Es/2jEeXKF+Lcr9NIO6EJb/LAP
   4GmfVURCX6H3LkEP0N/rh3wo+HogYqq2XC0mdDnLmH5hYoH04DFL+aP+E
   vnC5MtT9Pj0RTD9w/4STL/YG+vvFidgAVi5CIv46mdqcARmZoYzOGY4+I
   PWnxtiRnH5Okxmc4Qq40O5Zu745/benVzfpJyy6kRGt0i1Vy5eWocNSUZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="4000039"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="4000039"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 03:49:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="39195034"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 01 Mar 2024 03:49:52 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	sujai.buvaneswaran@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [iwl-next v3 2/8] ice: do Tx through PF netdev in slow-path
Date: Fri,  1 Mar 2024 12:54:08 +0100
Message-ID: <20240301115414.502097-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
References: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tx can be done using PF netdev.

Checks before Tx are unnecessary. Checking if switchdev mode is set
seems too defensive (there is no PR netdev in legacy mode). If
corresponding VF is disabled or during reset, PR netdev also should be
down.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 26 +++++---------------
 drivers/net/ethernet/intel/ice/ice_repr.c    | 12 ---------
 drivers/net/ethernet/intel/ice/ice_repr.h    |  2 --
 3 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 2e999f801c0a..8ad271534d80 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -236,7 +236,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
  */
 static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 {
-	struct ice_vsi *ctrl_vsi = pf->eswitch.control_vsi;
+	struct ice_vsi *uplink_vsi = pf->eswitch.uplink_vsi;
 	struct ice_vsi *vsi = repr->src_vsi;
 	struct metadata_dst *dst;
 
@@ -255,12 +255,11 @@ static int ice_eswitch_setup_repr(struct ice_pf *pf, struct ice_repr *repr)
 	netif_napi_add(repr->netdev, &repr->q_vector->napi,
 		       ice_napi_poll);
 
-	netif_keep_dst(repr->netdev);
+	netif_keep_dst(uplink_vsi->netdev);
 
 	dst = repr->dst;
 	dst->u.port_info.port_id = vsi->vsi_num;
-	dst->u.port_info.lower_dev = repr->netdev;
-	ice_repr_set_traffic_vsi(repr, ctrl_vsi);
+	dst->u.port_info.lower_dev = uplink_vsi->netdev;
 
 	return 0;
 
@@ -318,27 +317,14 @@ void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
 netdev_tx_t
 ice_eswitch_port_start_xmit(struct sk_buff *skb, struct net_device *netdev)
 {
-	struct ice_netdev_priv *np;
-	struct ice_repr *repr;
-	struct ice_vsi *vsi;
-
-	np = netdev_priv(netdev);
-	vsi = np->vsi;
-
-	if (!vsi || !ice_is_switchdev_running(vsi->back))
-		return NETDEV_TX_BUSY;
-
-	if (ice_is_reset_in_progress(vsi->back->state) ||
-	    test_bit(ICE_VF_DIS, vsi->back->state))
-		return NETDEV_TX_BUSY;
+	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 
-	repr = ice_netdev_to_repr(netdev);
 	skb_dst_drop(skb);
 	dst_hold((struct dst_entry *)repr->dst);
 	skb_dst_set(skb, (struct dst_entry *)repr->dst);
-	skb->queue_mapping = repr->q_id;
+	skb->dev = repr->dst->u.port_info.lower_dev;
 
-	return ice_start_xmit(skb, netdev);
+	return dev_queue_xmit(skb);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 5f30fb131f74..6191bee6c536 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -439,15 +439,3 @@ void ice_repr_stop_tx_queues(struct ice_repr *repr)
 	netif_carrier_off(repr->netdev);
 	netif_tx_stop_all_queues(repr->netdev);
 }
-
-/**
- * ice_repr_set_traffic_vsi - set traffic VSI for port representor
- * @repr: repr on with VSI will be set
- * @vsi: pointer to VSI that will be used by port representor to pass traffic
- */
-void ice_repr_set_traffic_vsi(struct ice_repr *repr, struct ice_vsi *vsi)
-{
-	struct ice_netdev_priv *np = netdev_priv(repr->netdev);
-
-	np->vsi = vsi;
-}
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index f9aede315716..b107e058d538 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -28,8 +28,6 @@ void ice_repr_rem_vf(struct ice_repr *repr);
 void ice_repr_start_tx_queues(struct ice_repr *repr);
 void ice_repr_stop_tx_queues(struct ice_repr *repr);
 
-void ice_repr_set_traffic_vsi(struct ice_repr *repr, struct ice_vsi *vsi);
-
 struct ice_repr *ice_netdev_to_repr(struct net_device *netdev);
 bool ice_is_port_repr_netdev(const struct net_device *netdev);
 
-- 
2.42.0


