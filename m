Return-Path: <netdev+bounces-190108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB7AB5344
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8BC3AA8F3
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9BB28689B;
	Tue, 13 May 2025 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="li9VD3SJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29561E501C
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133753; cv=none; b=FSqnLRgEgIkWnCW75Wrgxk5sHD4JVvgjld2hIpVTwsXl3nbzxp/KahAVC73JZlZKcdmVXoftzFEizAHESZ+I5YUleYOar675BlGfiQvwz/4uwfaGi9B711dWE/e7tezdx2Xy8+hE+Xji0Rk/ksZn/QeZiIfDluPHZ2ptmCkarAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133753; c=relaxed/simple;
	bh=k4LqbJNigjuVf37XyTfYGGiRhYtQVXluUC2rn4JnhtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzOjRW8bCqjFOVkouiBurJ5KQ5ocboqVKVVUfugr8dIrMSQOpv/kk39u5wbxXAO2y4uvIpsuujhgJgaNqnMavZ37xd/x44FjfXAsPsPEHU5+9CscrTmAm3cl55m1vTtSdbMGIyp9dOynqp9MtUaRXVnRmHtyHORDUO0q8AgsLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=li9VD3SJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747133751; x=1778669751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k4LqbJNigjuVf37XyTfYGGiRhYtQVXluUC2rn4JnhtA=;
  b=li9VD3SJ26EfV5GnbY+3l0Q4fV7HAODSMnAtvCjvA8NGAUC4WZI/zxAf
   eC7Np7nHg4rQWhwDGhb4v3rtkD/WATc6i/wDN8YuowZtsC8RMFn8LqF8s
   arjWU7Vl2IrKqMruOWDgDVveSyLoGuNiQJbzGLZ+b7ARNHK5uBu54rOtB
   v8pzAVKyWgPTzU0jAskXuojuSaxXxCi/sRiigHZarF7Ellsn/mALfh6EZ
   Aszoe8FW0kkFU6BW512Ra5O7BdcXncZy9VeC1xUchk3UxSnE01m0Eyuvz
   h4lMgeHSEjL6PDtMkHnIk4zCDYceHhkZb5/Xk7ISNG7uC2tpFQPBg6tX0
   A==;
X-CSE-ConnectionGUID: wLtoxaT8SPiyfXAJ3hpKRQ==
X-CSE-MsgGUID: IYemsdoxQfWmDXy9tJztGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="52630659"
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="52630659"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:55:51 -0700
X-CSE-ConnectionGUID: ZLGTlR/QQPqxIXoAJzuj4Q==
X-CSE-MsgGUID: FL0j/ME3SjGSo/vEGMmfTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,285,1739865600"; 
   d="scan'208";a="138600547"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 03:55:48 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	jacob.e.keller@intel.com,
	jbrandeburg@cloudflare.com,
	netdev@vger.kernel.org,
	Michal Kubiak <michal.kubiak@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v3 1/3] ice: fix Tx scheduler error handling in XDP callback
Date: Tue, 13 May 2025 12:55:27 +0200
Message-ID: <20250513105529.241745-2-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513105529.241745-1-michal.kubiak@intel.com>
References: <20250513105529.241745-1-michal.kubiak@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the XDP program is loaded, the XDP callback adds new Tx queues.
This means that the callback must update the Tx scheduler with the new
queue number. In the event of a Tx scheduler failure, the XDP callback
should also fail and roll back any changes previously made for XDP
preparation.

The previous implementation had a bug that not all changes made by the
XDP callback were rolled back. This caused the crash with the following
call trace:

[  +9.549584] ice 0000:ca:00.0: Failed VSI LAN queue config for XDP, error: -5
[  +0.382335] Oops: general protection fault, probably for non-canonical address 0x50a2250a90495525: 0000 [#1] SMP NOPTI
[  +0.010710] CPU: 103 UID: 0 PID: 0 Comm: swapper/103 Not tainted 6.14.0-net-next-mar-31+ #14 PREEMPT(voluntary)
[  +0.010175] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0005.2202160810 02/16/2022
[  +0.010946] RIP: 0010:__ice_update_sample+0x39/0xe0 [ice]

[...]

[  +0.002715] Call Trace:
[  +0.002452]  <IRQ>
[  +0.002021]  ? __die_body.cold+0x19/0x29
[  +0.003922]  ? die_addr+0x3c/0x60
[  +0.003319]  ? exc_general_protection+0x17c/0x400
[  +0.004707]  ? asm_exc_general_protection+0x26/0x30
[  +0.004879]  ? __ice_update_sample+0x39/0xe0 [ice]
[  +0.004835]  ice_napi_poll+0x665/0x680 [ice]
[  +0.004320]  __napi_poll+0x28/0x190
[  +0.003500]  net_rx_action+0x198/0x360
[  +0.003752]  ? update_rq_clock+0x39/0x220
[  +0.004013]  handle_softirqs+0xf1/0x340
[  +0.003840]  ? sched_clock_cpu+0xf/0x1f0
[  +0.003925]  __irq_exit_rcu+0xc2/0xe0
[  +0.003665]  common_interrupt+0x85/0xa0
[  +0.003839]  </IRQ>
[  +0.002098]  <TASK>
[  +0.002106]  asm_common_interrupt+0x26/0x40
[  +0.004184] RIP: 0010:cpuidle_enter_state+0xd3/0x690

Fix this by performing the missing unmapping of XDP queues from
q_vectors and setting the XDP rings pointer back to NULL after all those
queues are released.
Also, add an immediate exit from the XDP callback in case of ring
preparation failure.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 47 ++++++++++++++++-------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8119913b5f69..34df104ac567 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2740,6 +2740,27 @@ void ice_map_xdp_rings(struct ice_vsi *vsi)
 	}
 }
 
+/**
+ * ice_unmap_xdp_rings - Unmap XDP rings from interrupt vectors
+ * @vsi: the VSI with XDP rings being unmapped
+ */
+static void ice_unmap_xdp_rings(struct ice_vsi *vsi)
+{
+	int v_idx;
+
+	ice_for_each_q_vector(vsi, v_idx) {
+		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
+		struct ice_tx_ring *ring;
+
+		ice_for_each_tx_ring(ring, q_vector->tx)
+			if (!ring->tx_buf || !ice_ring_is_xdp(ring))
+				break;
+
+		/* restore the value of last node prior to XDP setup */
+		q_vector->tx.tx_ring = ring;
+	}
+}
+
 /**
  * ice_prepare_xdp_rings - Allocate, configure and setup Tx rings for XDP
  * @vsi: VSI to bring up Tx rings used by XDP
@@ -2803,7 +2824,7 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 	if (status) {
 		dev_err(dev, "Failed VSI LAN queue config for XDP, error: %d\n",
 			status);
-		goto clear_xdp_rings;
+		goto unmap_xdp_rings;
 	}
 
 	/* assign the prog only when it's not already present on VSI;
@@ -2819,6 +2840,8 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 		ice_vsi_assign_bpf_prog(vsi, prog);
 
 	return 0;
+unmap_xdp_rings:
+	ice_unmap_xdp_rings(vsi);
 clear_xdp_rings:
 	ice_for_each_xdp_txq(vsi, i)
 		if (vsi->xdp_rings[i]) {
@@ -2835,6 +2858,8 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
 	mutex_unlock(&pf->avail_q_mutex);
 
 	devm_kfree(dev, vsi->xdp_rings);
+	vsi->xdp_rings = NULL;
+
 	return -ENOMEM;
 }
 
@@ -2850,7 +2875,7 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	struct ice_pf *pf = vsi->back;
-	int i, v_idx;
+	int i;
 
 	/* q_vectors are freed in reset path so there's no point in detaching
 	 * rings
@@ -2858,17 +2883,7 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 	if (cfg_type == ICE_XDP_CFG_PART)
 		goto free_qmap;
 
-	ice_for_each_q_vector(vsi, v_idx) {
-		struct ice_q_vector *q_vector = vsi->q_vectors[v_idx];
-		struct ice_tx_ring *ring;
-
-		ice_for_each_tx_ring(ring, q_vector->tx)
-			if (!ring->tx_buf || !ice_ring_is_xdp(ring))
-				break;
-
-		/* restore the value of last node prior to XDP setup */
-		q_vector->tx.tx_ring = ring;
-	}
+	ice_unmap_xdp_rings(vsi);
 
 free_qmap:
 	mutex_lock(&pf->avail_q_mutex);
@@ -3013,11 +3028,14 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		xdp_ring_err = ice_vsi_determine_xdp_res(vsi);
 		if (xdp_ring_err) {
 			NL_SET_ERR_MSG_MOD(extack, "Not enough Tx resources for XDP");
+			goto resume_if;
 		} else {
 			xdp_ring_err = ice_prepare_xdp_rings(vsi, prog,
 							     ICE_XDP_CFG_FULL);
-			if (xdp_ring_err)
+			if (xdp_ring_err) {
 				NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Tx resources failed");
+				goto resume_if;
+			}
 		}
 		xdp_features_set_redirect_target(vsi->netdev, true);
 		/* reallocate Rx queues that are used for zero-copy */
@@ -3035,6 +3053,7 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Rx resources failed");
 	}
 
+resume_if:
 	if (if_running)
 		ret = ice_up(vsi);
 
-- 
2.45.2


