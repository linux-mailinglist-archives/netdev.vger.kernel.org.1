Return-Path: <netdev+bounces-232704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B97C081FA
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825FD1C248E8
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C903E2FCBF3;
	Fri, 24 Oct 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f50HrEVe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8D2FBE03
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338878; cv=none; b=RvbfbwybMaljEiAcf3eYf/EkhebFAyLBw1HBuGzI2KtwEZSgZMrF4f/BZ2j2qLnDOkrLXAJGo2UK6F+SVNxHA66Q6txXuoyaHlRYURdm+rByWQsaNbJFjshy6si8jNvE0TAIogL70R3wt/5Ffryo2OWas4XG1b6pM44mzhwSlmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338878; c=relaxed/simple;
	bh=873lGkq41gyIY0i/Ti7UX58OanW8m1xH8LhVmF1w8Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhQ6C8HpE5rwYG/6+gsAYS2nQqPXWphFTOVhqKt50JaPuOkQFKMKwIdmlIDwScGo21RG24pJ+szKCDOuVM65R9NJxT+pn3dB9cbMT0rWMq9J5QWVc8ovlptbpiqFaqUW/1QhcmLBQ9oO0DrHQt7uBDgvBSST5UfkeDkP66VmETs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f50HrEVe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761338877; x=1792874877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=873lGkq41gyIY0i/Ti7UX58OanW8m1xH8LhVmF1w8Bw=;
  b=f50HrEVeRYKbO7UVfZFndtl1CccgfzutZGa8ENdNLsmWU3Cr7epRKF5p
   P+MIOrwyrUk6U4Iy7o6pyDp+Ad43J7jYkyuIx7a0g1Edp1lYBMX63CU94
   a+MRIIIsR1xg6L+z+kGvb5As43VdZ6SjuAWInWXl2rLBYA9GPFMsXoq21
   dsTKn+E7mw0zuqwXq4TujZJmwoblIoWWPkdgItalpSTiAtweefsH9didn
   1ksLcEOqtgDnxsJAH8snwLGvwQfKagaqJhjaEWEEW8Br0FdJy1d3prMp7
   wio6gZWK7ChJizUBFkoRG6rCGOtLwBEM6M0Csvd/kfTRcTlx2vkmwuQvR
   g==;
X-CSE-ConnectionGUID: vzAhJq7/QgSzY5g1R8U0zg==
X-CSE-MsgGUID: xv7wV8umQ5Ou6Sfm/sxrLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66139507"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66139507"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:47:53 -0700
X-CSE-ConnectionGUID: j+UocRbZTM2X3xIUecjQ8A==
X-CSE-MsgGUID: Cgu4hXxcShKq4A0DZ/xhsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188821526"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 24 Oct 2025 13:47:53 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	mschmidt@redhat.com,
	poros@redhat.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 5/9] ice: move udp_tunnel_nic and misc IRQ setup into ice_init_pf()
Date: Fri, 24 Oct 2025 13:47:40 -0700
Message-ID: <20251024204746.3092277-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
References: <20251024204746.3092277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Move udp_tunnel_nic setup and ice_req_irq_msix_misc() call into
ice_init_pf(), remove some redundancy in the former while moving.

Move ice_free_irq_msix_misc() call into ice_deinit_pf(), to mimic
the above in terms of needed cleanup. Guard it via emptiness check,
to keep the allowance of half-initialized pf being cleaned up.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 58 +++++++++++------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 09dee43e48aa..1691dda1067e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3978,6 +3978,9 @@ static void ice_deinit_pf(struct ice_pf *pf)
 	if (pf->ptp.clock)
 		ptp_clock_unregister(pf->ptp.clock);
 
+	if (!xa_empty(&pf->irq_tracker.entries))
+		ice_free_irq_msix_misc(pf);
+
 	xa_destroy(&pf->dyn_ports);
 	xa_destroy(&pf->sf_nums);
 }
@@ -4045,6 +4048,11 @@ void ice_start_service_task(struct ice_pf *pf)
  */
 static int ice_init_pf(struct ice_pf *pf)
 {
+	struct udp_tunnel_nic_info *udp_tunnel_nic = &pf->hw.udp_tunnel_nic;
+	struct device *dev = ice_pf_to_dev(pf);
+	struct ice_hw *hw = &pf->hw;
+	int err = -ENOMEM;
+
 	mutex_init(&pf->sw_mutex);
 	mutex_init(&pf->tc_mutex);
 	mutex_init(&pf->adev_mutex);
@@ -4075,11 +4083,30 @@ static int ice_init_pf(struct ice_pf *pf)
 	if (!pf->avail_txqs || !pf->avail_rxqs || !pf->txtime_txqs)
 		goto undo_init;
 
+	udp_tunnel_nic->set_port = ice_udp_tunnel_set_port;
+	udp_tunnel_nic->unset_port = ice_udp_tunnel_unset_port;
+	udp_tunnel_nic->shared = &hw->udp_tunnel_shared;
+	udp_tunnel_nic->tables[0].n_entries = hw->tnl.valid_count[TNL_VXLAN];
+	udp_tunnel_nic->tables[0].tunnel_types = UDP_TUNNEL_TYPE_VXLAN;
+	udp_tunnel_nic->tables[1].n_entries = hw->tnl.valid_count[TNL_GENEVE];
+	udp_tunnel_nic->tables[1].tunnel_types = UDP_TUNNEL_TYPE_GENEVE;
+
+	/* In case of MSIX we are going to setup the misc vector right here
+	 * to handle admin queue events etc. In case of legacy and MSI
+	 * the misc functionality and queue processing is combined in
+	 * the same vector and that gets setup at open.
+	 */
+	err = ice_req_irq_msix_misc(pf);
+	if (err) {
+		dev_err(dev, "setup of misc vector failed: %d\n", err);
+		goto undo_init;
+	}
+
 	return 0;
 undo_init:
 	/* deinit handles half-initialized pf just fine */
 	ice_deinit_pf(pf);
-	return -ENOMEM;
+	return err;
 }
 
 /**
@@ -4751,36 +4778,8 @@ int ice_init_dev(struct ice_pf *pf)
 		goto unroll_irq_scheme_init;
 	}
 
-	pf->hw.udp_tunnel_nic.set_port = ice_udp_tunnel_set_port;
-	pf->hw.udp_tunnel_nic.unset_port = ice_udp_tunnel_unset_port;
-	pf->hw.udp_tunnel_nic.shared = &pf->hw.udp_tunnel_shared;
-	if (pf->hw.tnl.valid_count[TNL_VXLAN]) {
-		pf->hw.udp_tunnel_nic.tables[0].n_entries =
-			pf->hw.tnl.valid_count[TNL_VXLAN];
-		pf->hw.udp_tunnel_nic.tables[0].tunnel_types =
-			UDP_TUNNEL_TYPE_VXLAN;
-	}
-	if (pf->hw.tnl.valid_count[TNL_GENEVE]) {
-		pf->hw.udp_tunnel_nic.tables[1].n_entries =
-			pf->hw.tnl.valid_count[TNL_GENEVE];
-		pf->hw.udp_tunnel_nic.tables[1].tunnel_types =
-			UDP_TUNNEL_TYPE_GENEVE;
-	}
-	/* In case of MSIX we are going to setup the misc vector right here
-	 * to handle admin queue events etc. In case of legacy and MSI
-	 * the misc functionality and queue processing is combined in
-	 * the same vector and that gets setup at open.
-	 */
-	err = ice_req_irq_msix_misc(pf);
-	if (err) {
-		dev_err(dev, "setup of misc vector failed: %d\n", err);
-		goto unroll_pf_init;
-	}
-
 	return 0;
 
-unroll_pf_init:
-	ice_deinit_pf(pf);
 unroll_irq_scheme_init:
 	ice_service_task_stop(pf);
 	ice_clear_interrupt_scheme(pf);
@@ -4789,7 +4788,6 @@ int ice_init_dev(struct ice_pf *pf)
 
 void ice_deinit_dev(struct ice_pf *pf)
 {
-	ice_free_irq_msix_misc(pf);
 	ice_deinit_pf(pf);
 	ice_deinit_hw(&pf->hw);
 	ice_service_task_stop(pf);
-- 
2.47.1


