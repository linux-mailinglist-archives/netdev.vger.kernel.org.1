Return-Path: <netdev+bounces-94075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EB48BE128
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6011C21C95
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B0152E0D;
	Tue,  7 May 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQt5VFU8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA0155729
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082025; cv=none; b=LlCZ4iaU9ZuIhgf7MSkFY7Bb7hN5T5ivat8L05EBxvEYC+mjGi9CK7HosnPzFNlS1pcZ31O5TNkRKhKusK9COwHs5gYO0hrh3dsPA8depoYPLWUL0wVHOBsU8mX2vow3EpXEM1mYzG+65PXJtgEoll21eGziR0DtRpxeLXUIhXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082025; c=relaxed/simple;
	bh=lO8+5IO5HfxSAncX4rBIRh4yy3is0kHO0is7we3eVuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe6gdUHDaxZn+e+7dEv0ScV7MtFq8cfAzcvYquDTocs72vpLFhWh1ToI+qkzdAfeMgxP8Mq6sxKU/BKDnHpfNHkDBP2w7kXrGbPYkTO5fzBtmqjxbHC9AL0KeiAns6q7QU46LRLbnPew3lsczrC1842bd0610yYjtNEkmhSKQY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQt5VFU8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715082025; x=1746618025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lO8+5IO5HfxSAncX4rBIRh4yy3is0kHO0is7we3eVuo=;
  b=NQt5VFU8Nwl/ynddIaT1Gr2k4IjpOtKnR1ww0Z3P+SkftVU9tlh+WRhC
   nL3wLjjXFw5JbVSeYNi/H3gYwGD4/Pmx7oexDAoca4EuxzNWlI6ch9UKv
   4kVLlh0S1n7+8SqTd6FGhW1zBBzILOU+0JFu1F9yXLSxrdcmJZbP9BgH0
   m6TZD70wW9e5zb68aKQIuzA5Hqq1bhjIo9azrayH08vmnd5NUWdGxVLpC
   KVPsb3nxrEapYgwR/THFLn6ZJUcjcDJNlidXQlJrUMPj07U8uUrChCjQo
   VOQGkTMWJ5bIevu3oML76GaE+6mMSvCp/P/zRO1wgpJWajFhhXvcEmFxW
   Q==;
X-CSE-ConnectionGUID: 9Y58+hlsTiqrP3Il9/oreg==
X-CSE-MsgGUID: uWS6ocZOTC+94AGCD+jMYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22029144"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="22029144"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 04:40:24 -0700
X-CSE-ConnectionGUID: XFUWXmy/RjaUWtbupfauJw==
X-CSE-MsgGUID: au/JKmC8TJSJxtJAlWYLlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="28576691"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 07 May 2024 04:40:21 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com
Subject: [iwl-next v1 04/14] ice: treat subfunction VSI the same as PF VSI
Date: Tue,  7 May 2024 13:45:05 +0200
Message-ID: <20240507114516.9765-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When subfunction VSI is open the same code as for PF VSI should be
executed. Also when up is complete. Reflect that in code by adding
subfunction VSI to consideration.

In case of stopping, PF doesn't have additional tasks, so the same
is with subfunction VSI.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7033981666a7..fdfdb27476e5 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6684,7 +6684,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    ((vsi->netdev && vsi->type == ICE_VSI_PF))) {
+	    ((vsi->netdev && vsi->type == ICE_VSI_PF) ||
+	     (vsi->netdev && vsi->type == ICE_VSI_SF))) {
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
@@ -7382,7 +7383,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
 
-	if (vsi->type == ICE_VSI_PF) {
+	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
 		if (err)
-- 
2.42.0


