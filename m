Return-Path: <netdev+bounces-232702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2258C08212
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C04407203
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B42FC022;
	Fri, 24 Oct 2025 20:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdwcsxZm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB732FABE6
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338877; cv=none; b=COr1IwGhtelsw4cNDcM3iu2RD+PdVVX5D5A6MCDTjJ3g0bKLvIZHTvt0TfTw8q4vqt8TGhKo/LmY/rIIbEicB0vIdAHlSpnKcCbUCFuVRJLXOe363EoKoEFUe04lT5OcGE2ETTkzNOdMIzo8Ulf/6JRBsRiHeZE+f18onSMTdg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338877; c=relaxed/simple;
	bh=bftKwvRTgkdOeqR6pzmBCh5jPpjs5FHYOY98Mly06G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTxAHb24UPOi5/19MU0yc30XVIIxXiSqzMNtdlpxA8AIYWZO8L8ZoFlukTXGoKiHcAk3iBYriqd8rNpd2SwbP5xQdbccBvecONXuaccZrftvMBgGbjHwrrmbmlRZl6NyeZBtSFYAD5JYHDnXPNkVercpQXv3yXkKEC8f2RjKL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdwcsxZm; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761338876; x=1792874876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bftKwvRTgkdOeqR6pzmBCh5jPpjs5FHYOY98Mly06G0=;
  b=DdwcsxZmxE1nz7OdhOU3nxQCTNZHzf+t6t7G0QPd8Av7ID/mm5IKIMAr
   ZduYaqo7+nZrD9LlxbJjdYrP2YQOWH4YBQPceljuc+Dr8fDMBj/8Crys7
   4owVSxtX3REV2rLXBACV6LpeDOMFAvmZzTMFPq6rnojaPgI8/ED1QjrVn
   HchXpRtvXZI26Y2Uf72yiwn/7v5uKS0dSpw/H1IwDTUnXYo56kq1PwYAQ
   H9dWg6NMun0WAzoGeK2S+c6rZURFgGe2RbRqHW4tudKWwM7uKIqRGh89q
   7icy9cinutIQ9JJxeQlq+R5D9OfHjEKec6VIctz3TqipyB++AUOr40fzA
   Q==;
X-CSE-ConnectionGUID: olfd92ZiQMS3Wptbi9EnHA==
X-CSE-MsgGUID: Rle6yswUQ2ivd2NjLB7/Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66139505"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="66139505"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 13:47:53 -0700
X-CSE-ConnectionGUID: jLD8sq3KRpua2r4CGOGtZw==
X-CSE-MsgGUID: PUZWlHYgTjqqARL0RLuZLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="188821520"
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
Subject: [PATCH net-next 3/9] ice: move ice_init_interrupt_scheme() prior ice_init_pf()
Date: Fri, 24 Oct 2025 13:47:38 -0700
Message-ID: <20251024204746.3092277-4-anthony.l.nguyen@intel.com>
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

Move ice_init_interrupt_scheme() prior ice_init_pf().
To enable the move ice_set_pf_caps() was moved out from ice_init_pf()
to the caller (ice_init_dev()), and placed prior to the irq scheme init.

The move makes deinit order of ice_deinit_dev() and failure-path of
ice_init_pf() match (at least in terms of not calling
ice_clear_interrupt_scheme() and ice_deinit_pf() in opposite ways).

The new order aligns with findings made by Jakub Buchocki in
the commit 24b454bc354a ("ice: Fix ice module unload").

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 25 ++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f9e464b79bca..e00c282a8c18 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4043,8 +4043,6 @@ void ice_start_service_task(struct ice_pf *pf)
  */
 static int ice_init_pf(struct ice_pf *pf)
 {
-	ice_set_pf_caps(pf);
-
 	mutex_init(&pf->sw_mutex);
 	mutex_init(&pf->tc_mutex);
 	mutex_init(&pf->adev_mutex);
@@ -4746,11 +4744,18 @@ int ice_init_dev(struct ice_pf *pf)
 		ice_set_safe_mode_caps(hw);
 	}
 
+	ice_set_pf_caps(pf);
+	err = ice_init_interrupt_scheme(pf);
+	if (err) {
+		dev_err(dev, "ice_init_interrupt_scheme failed: %d\n", err);
+		return -EIO;
+	}
+
 	ice_start_service_task(pf);
 	err = ice_init_pf(pf);
 	if (err) {
 		dev_err(dev, "ice_init_pf failed: %d\n", err);
-		return err;
+		goto unroll_irq_scheme_init;
 	}
 
 	pf->hw.udp_tunnel_nic.set_port = ice_udp_tunnel_set_port;
@@ -4768,14 +4773,6 @@ int ice_init_dev(struct ice_pf *pf)
 		pf->hw.udp_tunnel_nic.tables[1].tunnel_types =
 			UDP_TUNNEL_TYPE_GENEVE;
 	}
-
-	err = ice_init_interrupt_scheme(pf);
-	if (err) {
-		dev_err(dev, "ice_init_interrupt_scheme failed: %d\n", err);
-		err = -EIO;
-		goto unroll_pf_init;
-	}
-
 	/* In case of MSIX we are going to setup the misc vector right here
 	 * to handle admin queue events etc. In case of legacy and MSI
 	 * the misc functionality and queue processing is combined in
@@ -4784,16 +4781,16 @@ int ice_init_dev(struct ice_pf *pf)
 	err = ice_req_irq_msix_misc(pf);
 	if (err) {
 		dev_err(dev, "setup of misc vector failed: %d\n", err);
-		goto unroll_irq_scheme_init;
+		goto unroll_pf_init;
 	}
 
 	return 0;
 
-unroll_irq_scheme_init:
-	ice_clear_interrupt_scheme(pf);
 unroll_pf_init:
 	ice_deinit_pf(pf);
+unroll_irq_scheme_init:
 	ice_service_task_stop(pf);
+	ice_clear_interrupt_scheme(pf);
 	return err;
 }
 
-- 
2.47.1


