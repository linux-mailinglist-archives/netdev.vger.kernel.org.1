Return-Path: <netdev+bounces-99504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70DA8D5124
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006981C2303E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510F482D7;
	Thu, 30 May 2024 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eDeGbH82"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230664779D
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717090807; cv=none; b=tv6Y8DcLEv9F8AkHNUyJ9Sv9w5jvr4k4UyEy5gtUC6X9QF7MqX1lAWoYEv4YY6W82W8Ab6H9IM9NvTkVNo+KhzzXDsJAQz1URMKVP5Ehgltnb/aCg47Fuq/pQkDNozsKioE1+aR6hKAOplIBQVnQiQwDasgAckhhncExW3mZPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717090807; c=relaxed/simple;
	bh=BG/vHwIdIRdfB1AL22eH2dU/OrJqWH1uCYhtCUrgI6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/UZa1llZ6WH4Ylvd7Di93p++M0GMtnve+OhpaGYWv0E9pBxItB1YUKDc+aDb7/a1m7B8x8VQmlfkeTsEL7JJ8jVnL1+2eBWdSk4tQcYfhhXq5kksPdGW76s65/aTOVYnKbRoNX1Vm/DNQvgJtbIQBadtFg25N9n9NUrkuD6owY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eDeGbH82; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717090806; x=1748626806;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BG/vHwIdIRdfB1AL22eH2dU/OrJqWH1uCYhtCUrgI6o=;
  b=eDeGbH82l4osp6iNETGvdmqiLbmP0d40ERfajjRiN0jVPOcK+OLdehpw
   kqp3PZL9w/W+HcDEvpR9sqv1f3IymE43N8/P/TsUCU5yRG4M0k7/ZqX1c
   MvKWfRbidJgZsV2fPj0W9KTziifHRXYDCGbe9SdUifsKl90qU9acq4apt
   bgMsGlvnUwuDrFRKVZLKKy/0J2MogUUu2Jgx4rBX42T18bdKnH8MXq4W9
   pDJMVExuZrl2JCjtfM4WQ2+pvNGERAvkpwpcCsNTmeWqiEsDvlTZ/q7Zr
   rK8UZzg/LTlTQPJxXgShRDkMZoslenGCnCvXTriohDfrJUoIqm1naBYRY
   g==;
X-CSE-ConnectionGUID: QqoNCmlYQyq1Yqt0drelnw==
X-CSE-MsgGUID: hZQSwlk4R/KutEPheZSTyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="31119263"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="31119263"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:02 -0700
X-CSE-ConnectionGUID: jMethchhT52CryxaJfo8Lw==
X-CSE-MsgGUID: AU0pMWO/R1K/cNjnet5eQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="66766680"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:40:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 30 May 2024 10:39:31 -0700
Subject: [PATCH net 4/6] ice: add flag to distinguish reset from .ndo_bpf
 in XDP rings config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-net-2024-05-30-intel-net-fixes-v1-4-8b11c8c9bff8@intel.com>
References: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
In-Reply-To: <20240530-net-2024-05-30-intel-net-fixes-v1-0-8b11c8c9bff8@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Igor Bagnucki <igor.bagnucki@intel.com>, Simon Horman <horms@kernel.org>, 
 Chandan Kumar Rout <chandanx.rout@intel.com>
X-Mailer: b4 0.13.0

From: Larysa Zaremba <larysa.zaremba@intel.com>

Commit 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
has placed ice_vsi_free_q_vectors() after ice_destroy_xdp_rings() in
the rebuild process. The behaviour of the XDP rings config functions is
context-dependent, so the change of order has led to
ice_destroy_xdp_rings() doing additional work and removing XDP prog, when
it was supposed to be preserved.

Also, dependency on the PF state reset flags creates an additional,
fortunately less common problem:

* PFR is requested e.g. by tx_timeout handler
* .ndo_bpf() is asked to delete the program, calls ice_destroy_xdp_rings(),
  but reset flag is set, so rings are destroyed without deleting the
  program
* ice_vsi_rebuild tries to delete non-existent XDP rings, because the
  program is still on the VSI
* system crashes

With a similar race, when requested to attach a program,
ice_prepare_xdp_rings() can actually skip setting the program in the VSI
and nevertheless report success.

Instead of reverting to the old order of function calls, add an enum
argument to both ice_prepare_xdp_rings() and ice_destroy_xdp_rings() in
order to distinguish between calls from rebuild and .ndo_bpf().

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 11 +++++++++--
 drivers/net/ethernet/intel/ice/ice_lib.c  |  5 +++--
 drivers/net/ethernet/intel/ice/ice_main.c | 22 ++++++++++++----------
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index d4d840729bda..b91b2594b29d 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -930,9 +930,16 @@ int ice_down(struct ice_vsi *vsi);
 int ice_down_up(struct ice_vsi *vsi);
 int ice_vsi_cfg_lan(struct ice_vsi *vsi);
 struct ice_vsi *ice_lb_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi);
+
+enum ice_xdp_cfg {
+	ICE_XDP_CFG_FULL,	/* Fully apply new config in .ndo_bpf() */
+	ICE_XDP_CFG_PART,	/* Save/use part of config in VSI rebuild */
+};
+
 int ice_vsi_determine_xdp_res(struct ice_vsi *vsi);
-int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog);
-int ice_destroy_xdp_rings(struct ice_vsi *vsi);
+int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
+			  enum ice_xdp_cfg cfg_type);
+int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type);
 int
 ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	     u32 flags);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c0a7ff6c7e87..dd8b374823ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2285,7 +2285,8 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 			ret = ice_vsi_determine_xdp_res(vsi);
 			if (ret)
 				goto unroll_vector_base;
-			ret = ice_prepare_xdp_rings(vsi, vsi->xdp_prog);
+			ret = ice_prepare_xdp_rings(vsi, vsi->xdp_prog,
+						    ICE_XDP_CFG_PART);
 			if (ret)
 				goto unroll_vector_base;
 		}
@@ -2429,7 +2430,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 		/* return value check can be skipped here, it always returns
 		 * 0 if reset is in progress
 		 */
-		ice_destroy_xdp_rings(vsi);
+		ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_PART);
 
 	ice_vsi_clear_rings(vsi);
 	ice_vsi_free_q_vectors(vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f60c022f7960..2a270aacd24a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2711,10 +2711,12 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
  * ice_prepare_xdp_rings - Allocate, configure and setup Tx rings for XDP
  * @vsi: VSI to bring up Tx rings used by XDP
  * @prog: bpf program that will be assigned to VSI
+ * @cfg_type: create from scratch or restore the existing configuration
  *
  * Return 0 on success and negative value on error
  */
-int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
+int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
+			  enum ice_xdp_cfg cfg_type)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	int xdp_rings_rem = vsi->num_xdp_txq;
@@ -2790,7 +2792,7 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
 	 * taken into account at the end of ice_vsi_rebuild, where
 	 * ice_cfg_vsi_lan is being called
 	 */
-	if (ice_is_reset_in_progress(pf->state))
+	if (cfg_type == ICE_XDP_CFG_PART)
 		return 0;
 
 	/* tell the Tx scheduler that right now we have
@@ -2842,22 +2844,21 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
 /**
  * ice_destroy_xdp_rings - undo the configuration made by ice_prepare_xdp_rings
  * @vsi: VSI to remove XDP rings
+ * @cfg_type: disable XDP permanently or allow it to be restored later
  *
  * Detach XDP rings from irq vectors, clean up the PF bitmap and free
  * resources
  */
-int ice_destroy_xdp_rings(struct ice_vsi *vsi)
+int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	struct ice_pf *pf = vsi->back;
 	int i, v_idx;
 
 	/* q_vectors are freed in reset path so there's no point in detaching
-	 * rings; in case of rebuild being triggered not from reset bits
-	 * in pf->state won't be set, so additionally check first q_vector
-	 * against NULL
+	 * rings
 	 */
-	if (ice_is_reset_in_progress(pf->state) || !vsi->q_vectors[0])
+	if (cfg_type == ICE_XDP_CFG_PART)
 		goto free_qmap;
 
 	ice_for_each_q_vector(vsi, v_idx) {
@@ -2898,7 +2899,7 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi)
 	if (static_key_enabled(&ice_xdp_locking_key))
 		static_branch_dec(&ice_xdp_locking_key);
 
-	if (ice_is_reset_in_progress(pf->state) || !vsi->q_vectors[0])
+	if (cfg_type == ICE_XDP_CFG_PART)
 		return 0;
 
 	ice_vsi_assign_bpf_prog(vsi, NULL);
@@ -3009,7 +3010,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		if (xdp_ring_err) {
 			NL_SET_ERR_MSG_MOD(extack, "Not enough Tx resources for XDP");
 		} else {
-			xdp_ring_err = ice_prepare_xdp_rings(vsi, prog);
+			xdp_ring_err = ice_prepare_xdp_rings(vsi, prog,
+							     ICE_XDP_CFG_FULL);
 			if (xdp_ring_err)
 				NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Tx resources failed");
 		}
@@ -3020,7 +3022,7 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 			NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Rx resources failed");
 	} else if (ice_is_xdp_ena_vsi(vsi) && !prog) {
 		xdp_features_clear_redirect_target(vsi->netdev);
-		xdp_ring_err = ice_destroy_xdp_rings(vsi);
+		xdp_ring_err = ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_FULL);
 		if (xdp_ring_err)
 			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Tx resources failed");
 		/* reallocate Rx queues that were used for zero-copy */

-- 
2.44.0.53.g0f9d4d28b7e6


