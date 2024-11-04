Return-Path: <netdev+bounces-141636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3463F9BBD75
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 19:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5D2280F12
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 18:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C118D642;
	Mon,  4 Nov 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yw0zyxGq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDB19BBA
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745962; cv=none; b=OXUCBvIphdWnech5Am9OiYxma/KOaTf0ZaWD4VTsjSmxZ5YIsbX8LUfipifYX9MuWGHiFu9RVCpJ+kav2a31r6Zm73TF3OKfgDALmaQ800SsRZZ+P0AaQhWcokv05lFRb1awFyLZOikYC0zXZCV43kmmy7vdhVOS8/9w0vvSm54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745962; c=relaxed/simple;
	bh=r1QhwuPbs8ubNXAmG4ArE39tL4xRdB4Ohl4TH4RUulM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKe0ib6p7tqQbr1jXOldZYTrCxjTjmqK5cQIUa+jF1zyMckP54Ly4zpc14jMlQajPXkkBQHEQH4q/qpOk+jpa/S1B/wwHKv99+3LVmTrrUsP87iyjipWQQg1UhxfYy8/hBl4C9OLK3Bq5sL3oXFQCnaq0TT0rCKldTNpDZyZaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yw0zyxGq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730745960; x=1762281960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r1QhwuPbs8ubNXAmG4ArE39tL4xRdB4Ohl4TH4RUulM=;
  b=Yw0zyxGqvm9bnXN2l5Wj8OPzukVVeTtcuMh56PZRKmr84TmWMKG4e2Gb
   cedbqGeihekM82QogSs5SkVZcWnsMZ/wUHRTh9VNPfnBfrRNv6thuz1gJ
   s56GHOIXc6a9HKTMOoOIjTwvzob7Bf9xZNel/E8sH4+L4OHiEIRnm4aAz
   QJ2ptVjDt3jFG0plSdb8EgLmCUjVCR10PEExacXkPZ80j16EKXJrwJZQo
   fcbnhMRbf2+rmWKQ4CONLYH9CwAxZHdo9xOpC/cAuhCZALeBufJ4wTX8C
   fmj86faqV+SuQFMX9UxcKsze3Cv2uxwb6Zf4qS5eUtH6PqMivySIdRtSN
   g==;
X-CSE-ConnectionGUID: X5asnfJ5RX+fygkDpBOICw==
X-CSE-MsgGUID: epOiiITZQAutEfNKfIB+Yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34248722"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="34248722"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 10:45:59 -0800
X-CSE-ConnectionGUID: r1J37tPaR3+tRmbp17DQ2w==
X-CSE-MsgGUID: e4WPHgxoR++LQSEoLbrzUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="88497487"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 04 Nov 2024 10:45:58 -0800
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BB01628781;
	Mon,  4 Nov 2024 18:45:56 +0000 (GMT)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net] ice: Fix VLAN pruning in switchdev mode
Date: Mon,  4 Nov 2024 19:49:09 +0100
Message-ID: <20241104184908.632863-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In switchdev mode the uplink VSI should receive all unmatched packets,
including VLANs. Therefore, VLAN pruning should be disabled if uplink is
in switchdev mode. It is already being done in ice_eswitch_setup_env(),
however the addition of ice_up() in commit 44ba608db509 ("ice: do
switchdev slow-path Rx using PF VSI") caused VLAN pruning to be
re-enabled after disabling it.

Add a check to ice_set_vlan_filtering_features() to ensure VLAN
filtering will not be enabled if uplink is in switchdev mode. Note that
ice_is_eswitch_mode_switchdev() is being used instead of
ice_is_switchdev_running(), as the latter would only return true after
the whole switchdev setup completes.

Fixes: 44ba608db509 ("ice: do switchdev slow-path Rx using PF VSI")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b1e7727b8677..8f2e758c3942 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6361,10 +6361,12 @@ ice_set_vlan_filtering_features(struct ice_vsi *vsi, netdev_features_t features)
 	int err = 0;
 
 	/* support Single VLAN Mode (SVM) and Double VLAN Mode (DVM) by checking
-	 * if either bit is set
+	 * if either bit is set. In switchdev mode Rx filtering should never be
+	 * enabled.
 	 */
-	if (features &
-	    (NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER))
+	if ((features &
+	     (NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)) &&
+	     !ice_is_eswitch_mode_switchdev(vsi->back))
 		err = vlan_ops->ena_rx_filtering(vsi);
 	else
 		err = vlan_ops->dis_rx_filtering(vsi);
-- 
2.45.0


