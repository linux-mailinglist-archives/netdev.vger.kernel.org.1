Return-Path: <netdev+bounces-105777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B361912CAF
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 19:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC571289F4F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 17:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D8015FD1B;
	Fri, 21 Jun 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5hKpPPq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C531684AD
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992469; cv=none; b=G2VG8qCRcOSlqgPqG6g4Kz1+lWtfOehjhzrOkWANoPNZuT1elZSmj0hN3RIfXMOM6vuMQtUKgVBS4Kz3CqmEmGf+sXu+HnTZrR34deaebPCFcn6uVCvVb3+kbbw+XthiAyL6F7M3tJ0KMqSqa+HUr3ODWOqES9pY6F7XyH4Jbm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992469; c=relaxed/simple;
	bh=Os6paFjlKFEdIUf+MiQ5EtK6+hTny88KwRebe5LC0PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dagdBbPkKp/fkWPPhnFDXlgQE+nj+a1Aumg1Ht22U7Or3XEFG6FiJ3unGUUCPwHjGMNAZ2KIjZOnJ8f3Fr94hEGn+Uky3G/94ZTWSVkhoC8EoN9Bk4KiVYoyzzR1FbazVj3PP5Na1ZawnkNK/Wdq3ES/sJDaDgzI2WDizbE/XDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5hKpPPq; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718992468; x=1750528468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Os6paFjlKFEdIUf+MiQ5EtK6+hTny88KwRebe5LC0PM=;
  b=C5hKpPPqIx/0VfaGFLvyROLVRV1jVHXopLN2srQQoUb0S1Ymd7YlHnqp
   WBq3mqqQLf8JYBe/jjESXZ+waLQDK2ZCL/0ZeS4znHiDnpQ7azj/F6TkW
   4F9rPstAgNpMV8RTIPPIB3t+6Lddjw7g6udofMfrNih8z9mXwvC7GhmVT
   46ppaae9WPlLZmvdFpERVj7aU8j4j5i3CSRVsw42E8BIk4K0+MfXJUvgR
   XFuIykwavw3Gnuere+EFzjh5/0zN66BLulR2VNFb2lP2kWsyAhkYUJYN0
   COxqWRQ8lUIpTZZtIc6hYNKqAruTMfRVIUmM3BTWMI4+AX6SvddjatEJx
   g==;
X-CSE-ConnectionGUID: ZvdQDrevQIOfKAjc4ITLHQ==
X-CSE-MsgGUID: byNCl9SNR1OGxG4NIOT/Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="15795483"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="15795483"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 10:54:27 -0700
X-CSE-ConnectionGUID: 1aD9B0/TQ2qAoyP92tTNsg==
X-CSE-MsgGUID: c9hC5rJtQd+IRgh0L06dJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="42761989"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 21 Jun 2024 10:54:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Karen Ostrowska <karen.ostrowska@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net] ice: Rebuild TC queues on VSI queue reconfiguration
Date: Fri, 21 Jun 2024 10:54:19 -0700
Message-ID: <20240621175420.3406803-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Sokolowski <jan.sokolowski@intel.com>

TC queues needs to be correctly updated when the number of queues on
a VSI is reconfigured, so netdev's queue and TC settings will be
dynamically adjusted and could accurately represent the underlying
hardware state after changes to the VSI queue counts.

Fixes: 0754d65bd4be ("ice: Add infrastructure for mqprio support via ndo_setup_tc")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1766230abfff..55a42aad92a5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4139,7 +4139,7 @@ bool ice_is_wol_supported(struct ice_hw *hw)
 int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 {
 	struct ice_pf *pf = vsi->back;
-	int err = 0, timeout = 50;
+	int i, err = 0, timeout = 50;
 
 	if (!new_rx && !new_tx)
 		return -EINVAL;
@@ -4165,6 +4165,14 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 
 	ice_vsi_close(vsi);
 	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+
+	ice_for_each_traffic_class(i) {
+		if (vsi->tc_cfg.ena_tc & BIT(i))
+			netdev_set_tc_queue(vsi->netdev,
+					    vsi->tc_cfg.tc_info[i].netdev_tc,
+					    vsi->tc_cfg.tc_info[i].qcount_tx,
+					    vsi->tc_cfg.tc_info[i].qoffset);
+	}
 	ice_pf_dcb_recfg(pf, locked);
 	ice_vsi_open(vsi);
 done:
-- 
2.41.0


