Return-Path: <netdev+bounces-165235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA0A3134A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCC21886618
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24A024394F;
	Tue, 11 Feb 2025 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBrgZrfD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB35261571
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295721; cv=none; b=Ymsah/ZxX+TrN0ZRfpyc4ucK36X5oAtIf8qOjdPypIDiCt/0jTCKDWtgnSbS9TweMp4aV8/pF4qzFpeSV9laN0vfP/RjquyQdXPC7zaZFF4OyPDz1qFh+zKcH4Ww3sleodnHbheV4UY2Doi0tm9B/Pooq6bXAcZOlj9RqUqtMw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295721; c=relaxed/simple;
	bh=GgftlG2/oea9KOpUGCKxqmmj2Ugal+b2G6hJrr6GoOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ihp2xyBESoHZtIWfh1qwD8JhNLgIauCPVsR1ylCWZELsc9hE6tU9QOJMm1t0L4REijpkvmlL7jHRU2BQNSKNFdsPK9fDf5/dyvjjpAyKY0V8nDapHP3B9amiZnybo28/37qIyaRlWf70haBlqdh6qhJjlW5IzEuoM7kwb4tFIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBrgZrfD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739295719; x=1770831719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GgftlG2/oea9KOpUGCKxqmmj2Ugal+b2G6hJrr6GoOw=;
  b=WBrgZrfDwRUnYH5mGM2Ls10KYpJgKUhwgogJu6+n4Uphvmhq58oA/m9w
   cwkBwpqowzyey9B/6MNBmhwbxc5nck8Q3eW5BDNFQupbGIpwBM1/uNKrI
   w4RVqfv3w3W5S+lEERKqm1/9e4dPI9O9Ij5B5buxZkj1zQetrtxwz2DtV
   3ytOLQrOIpLfmLt+J0/x23JHpe5UsBQ1y4vDF6zupbEzyT5opfg9iIgFP
   1A4JXUIyOdSM5ApZLpJcIQ1EvDnjXkkeTBJomZIPI2eRqqkK005SswE93
   TS1DPvRkiV3xG+89cKfTU6jHeSdC5sfuah1LLpRuuynX43VjLfDbeGL70
   Q==;
X-CSE-ConnectionGUID: s2zrM3++RfSQ02yLs0sCAw==
X-CSE-MsgGUID: fIjaif4ySci25k/x8EPQuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43855618"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="43855618"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:41:57 -0800
X-CSE-ConnectionGUID: eVIm/HmsTeWiaFOnoajx+Q==
X-CSE-MsgGUID: 4ON84f3IRxmaU5Z8H1GMwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112538344"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 11 Feb 2025 09:41:56 -0800
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D48BD32ECE;
	Tue, 11 Feb 2025 17:41:54 +0000 (GMT)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [PATCH iwl-net 2/2] ice: Avoid setting default Rx VSI twice in switchdev setup
Date: Tue, 11 Feb 2025 18:43:22 +0100
Message-ID: <20250211174322.603652-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250211174322.603652-1-marcin.szycik@linux.intel.com>
References: <20250211174322.603652-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of switchdev environment setup, uplink VSI is configured as
default for both Tx and Rx. Default Rx VSI is also used by promiscuous
mode. If promisc mode is enabled and an attempt to enter switchdev mode
is made, the setup will fail because Rx VSI is already configured as
default (rule exists).

Reproducer:
  devlink dev eswitch set $PF1_PCI mode switchdev
  ip l s $PF1 up
  ip l s $PF1 promisc on
  echo 1 > /sys/class/net/$PF1/device/sriov_numvfs

In switchdev setup, use ice_set_dflt_vsi() instead of plain
ice_cfg_dflt_vsi(), which avoids repeating setting default VSI for Rx if
it's already configured.

Fixes: 50d62022f455 ("ice: default Tx rule instead of to queue")
Reported-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Closes: https://lore.kernel.org/intel-wired-lan/PH0PR11MB50138B635F2E5CEB7075325D961F2@PH0PR11MB5013.namprd11.prod.outlook.com
Reviewed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index b44a375e6365..ed21d7f55ac1 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -38,8 +38,7 @@ static int ice_eswitch_setup_env(struct ice_pf *pf)
 	if (ice_vsi_add_vlan_zero(uplink_vsi))
 		goto err_vlan_zero;
 
-	if (ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, true,
-			     ICE_FLTR_RX))
+	if (ice_set_dflt_vsi(uplink_vsi))
 		goto err_def_rx;
 
 	if (ice_cfg_dflt_vsi(uplink_vsi->port_info, uplink_vsi->idx, true,
-- 
2.45.0


