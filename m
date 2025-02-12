Return-Path: <netdev+bounces-165438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFBCA32064
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 08:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E5E1888789
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BDE204C3F;
	Wed, 12 Feb 2025 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlgVyh6K"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2570204C23
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347059; cv=none; b=Lobj+NIuyJ/1FBo2iyKlXiZ5UJgb1BmP+t/Ea7Ao2F8OTpsteubxLFpoXoCNItYkOQ3tk081dCvHL7fIhuDI5jHrpdHp6i09YT4b53XfrO4hjgPofoKbdkKWWOH1AJEJyV+oqtjsuT8hWs5DWeONTHclE+RvdlRrAzRxLYWsmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347059; c=relaxed/simple;
	bh=nJCkytmPtDyYoEpk7Y2B0AQ4HJ0hsEDOqc+k3dFC+kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8cN+5vmWHOlc1lv5oCKCm62ZqlRESb1eNloUt/rtu/he5r/+sf3Hfs/FQ75FjcAliXChc/oAaOddc7N/08bwntv4uvUV7YLTf1nCa1xXig77up0CEX18uHiL7bK/aQySnSKN2wlU9AE7jANjCG4ZsPMigxpsOuiSI797VugIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlgVyh6K; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739347058; x=1770883058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJCkytmPtDyYoEpk7Y2B0AQ4HJ0hsEDOqc+k3dFC+kY=;
  b=AlgVyh6KyYqojjbejsPi0DcRwW318twdctHspQUKpNALNWk4N42OAzkD
   9QZjU833hCPDD4hGfh27Gmd4X3jGFAGoU5PGFtRbIyiTVEZBkIQ/Iwwmi
   AVbYiSdsm74Q+qJN8yrqMKUxCGH54oGZD8t6StNKD6DV5vSyTtaLdbM4a
   OYoDkGK7g9IX+nBDPVCVlo1eEAnILkJ6Eon8lo7htieg735vnKI/hXIqQ
   BqmsEmEJzMV72whYnd+3oTcyNNeGK0rdbQoxVxu6Bt0c/Oe86VK60/ayC
   EdgO3DMNJDhDIttieSjZ2DEakLsLn5hmZZamk3LC1biumrmHPmyEqUSo8
   w==;
X-CSE-ConnectionGUID: 8bNc0wyqTUu2oROD64NIFQ==
X-CSE-MsgGUID: fWE0rqZZQkubBg/+rFtW3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50212356"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50212356"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 23:57:38 -0800
X-CSE-ConnectionGUID: N6yLGbAJQHWEIEEsfRd2yQ==
X-CSE-MsgGUID: aTB90o7JQmSDzVUk6C9R4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="112579853"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa006.fm.intel.com with ESMTP; 11 Feb 2025 23:57:35 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@intel.com,
	horms@kernel.org
Subject: [iwl-next v2 4/4] ixgbe: turn off MDD while modifying SRRCTL
Date: Wed, 12 Feb 2025 08:57:24 +0100
Message-ID: <20250212075724.3352715-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250212075724.3352715-1-michal.swiatkowski@linux.intel.com>
References: <20250212075724.3352715-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

Modifying SRRCTL register can generate MDD event.

Turn MDD off during SRRCTL register write to prevent generating MDD.

Fix RCT in ixgbe_set_rx_drop_en().

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 22148e65e596..873b46d21042 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4099,8 +4099,12 @@ void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 #endif
 {
-	int i;
 	bool pfc_en = adapter->dcb_cfg.pfc_mode_enable;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int i;
+
+	if (hw->mac.ops.disable_mdd)
+		hw->mac.ops.disable_mdd(hw);
 
 	if (adapter->ixgbe_ieee_pfc)
 		pfc_en |= !!(adapter->ixgbe_ieee_pfc->pfc_en);
@@ -4122,6 +4126,9 @@ static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 		for (i = 0; i < adapter->num_rx_queues; i++)
 			ixgbe_disable_rx_drop(adapter, adapter->rx_ring[i]);
 	}
+
+	if (hw->mac.ops.enable_mdd)
+		hw->mac.ops.enable_mdd(hw);
 }
 
 #define IXGBE_SRRCTL_BSIZEHDRSIZE_SHIFT 2
-- 
2.42.0


