Return-Path: <netdev+bounces-98884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8738D2E01
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 09:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7A71C234C9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BDF1667ED;
	Wed, 29 May 2024 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InEB0TJ6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F381649D9
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967244; cv=none; b=fyeqMtr7NK685wLZfmwtI0AAFMBZMWoQZg1LUNoFaRrVUyMXj7vJJr0MtN2KrLB3ZxKKYrVhMsR2DgtdX6hgVl0hp+AyuQD5DjutbQp2cztDcewBUKIbaTUs/AK9XvUsC91UE83jT5bpjfbYf9ahpi3iqS9W9ypnkEK42DaiBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967244; c=relaxed/simple;
	bh=mlvptsq7XkvG6wp3U0Gjq2yqNUa4cp9Vs6EwoVYz544=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yex+AGaddpkhcUkxuroc21PaXxuU1vmDjJA8LtWqnNL3Rp0/MXuRzunJre2HzPOeksYjyfS2LpE+54YcLqVyidubdWzyN8Tlf6becuHIohXrvwx/sNZA86Sl2SdEPksuv4J2vhJ4kOjWyZGB5IvCCBro/0ke2u1y7Uat8aopyO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InEB0TJ6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716967243; x=1748503243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mlvptsq7XkvG6wp3U0Gjq2yqNUa4cp9Vs6EwoVYz544=;
  b=InEB0TJ6EB+naAyv4sK5pBGbxJ2RUkMgW6jO2yTKC27uwPDcsfyIfCfd
   5qg2YKGUsD2qNSQODdJuEOJJs7Z2RqC7H1PcN4F6bLk9/Y5OukP+x/lGQ
   o0vyNLlnrnwd6F16DXLslvxqAnVJROWhlX+POBWdDdmUGb66VMY82+moE
   frFKnOVGfhYstSD3uCjcKnw6Yzl5diT9yEDmqKrlvweC4+ClRKICuOOYJ
   ulEHBczIJqA6tCi/E3o0cl40rZWALkhgmbC5/dD/V7SfGLypPCIctLxv8
   JczW06TqeTaHB148DV86pq4s48WcLwh/BNMoMNRMvoMEbS7X61WbPpLRw
   w==;
X-CSE-ConnectionGUID: /xTqIovERR+JMGfmoful7Q==
X-CSE-MsgGUID: 2HC6qX06RLSiYNY8jrPPlg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23908584"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="23908584"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 00:20:42 -0700
X-CSE-ConnectionGUID: PujpZo6DTIaqZ8E9ieU4qA==
X-CSE-MsgGUID: m8YvJwBUQi6vm8EdmM6K3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="35295623"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.123.220.50])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2024 00:20:40 -0700
From: Karen Ostrowska <karen.ostrowska@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Karen Ostrowska <karen.ostrowska@intel.com>
Subject: [PATCH iwl-net v1] ice: Rebuild TC queues on VSI queue reconfiguration
Date: Wed, 29 May 2024 09:17:36 +0200
Message-Id: <20240529071736.224973-1-karen.ostrowska@intel.com>
X-Mailer: git-send-email 2.31.1
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
---
 drivers/net/ethernet/intel/ice/ice_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1b61ca3a6eb6..a1798ec4d904 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4136,7 +4136,7 @@ bool ice_is_wol_supported(struct ice_hw *hw)
 int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 {
 	struct ice_pf *pf = vsi->back;
-	int err = 0, timeout = 50;
+	int i, err = 0, timeout = 50;
 
 	if (!new_rx && !new_tx)
 		return -EINVAL;
@@ -4162,6 +4162,14 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 
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
2.31.1


