Return-Path: <netdev+bounces-116968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6494894C3BE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FC41C22245
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F601917D9;
	Thu,  8 Aug 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZ47lha1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61276190062
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138274; cv=none; b=aA6gE0xugaDQi84iRZVN5h9AzujUoCei+5uNUK6ubAnEjC+ZnzWxjoB/KCEQTATU9h1DjR1UERmVt4xlVFylC5MaoIEXcFiIuqUyQKlDDWYS7LuWw3qXAya/bEg8oeQ28pU/8HIOgJpXs0SFsFMEv43HHI50hdWOl5OHN4j6HtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138274; c=relaxed/simple;
	bh=5yWzXMQN/PpZ5YmdwOZHr+yBHTnhuhAO0Kx6/PSL2n4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALDWtp5yW6PzFz4p91w0kvYCd/RwTtL20zTgs0SnQcIokZz/tXXKv5/o250X9vzat/afeusEXH7P1aNh8SaIu0Lz+4SdHD81uybIX5S9lJhGvYxVP+AihCXMDseDXk0xEiroZ8ZNVCTKZRovkMP2w74EWEOBYOdMvbE++uc/Huc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZ47lha1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723138273; x=1754674273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5yWzXMQN/PpZ5YmdwOZHr+yBHTnhuhAO0Kx6/PSL2n4=;
  b=VZ47lha1g2zM8gbeoc2ITq+zZocr4Oh8TxtKq795V8MShHLTQtAUBRZT
   zPLrSlVREqpfi1dQcRsTErS9Mm4QJOH19mQLDcQWgOQ9tdFML0zOLPBu4
   xcHv9SgdczYXQEegszKuIdYXThdCHRsENLaVVJr+QSL2errZrmPJ0SSot
   p21BNYzrSBCXTNnUtQDlEIGkzZYefouIOxTJWU1InxaS4jpFiPb/cgq90
   Ie766jI07C42NxTi1fn2aGoxLRuG42iprRwAb1avCmRQUEZJupfdX9Qse
   RPXIdNKklh+zbNQexmbp3zEIgT2wotLalRiialKSENYb4Yn2qzGvhPw4A
   A==;
X-CSE-ConnectionGUID: 1kcRKkaCRMCI7bodk3MwJA==
X-CSE-MsgGUID: +0QRgaPvRxe/RQbfK8KJJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32675400"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="32675400"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 10:31:11 -0700
X-CSE-ConnectionGUID: K62F4/yyRhS7XCDQvcViuA==
X-CSE-MsgGUID: z47teXT0SVmCSHfGpsl8Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="61682431"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 10:31:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v3 04/15] ice: treat subfunction VSI the same as PF VSI
Date: Thu,  8 Aug 2024 10:30:50 -0700
Message-ID: <20240808173104.385094-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

When subfunction VSI is open the same code as for PF VSI should be
executed. Also when up is complete. Reflect that in code by adding
subfunction VSI to consideration.

In case of stopping, PF doesn't have additional tasks, so the same
is with subfunction VSI.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7ce025b6efe4..e10f10a21c95 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6728,7 +6728,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
+	    ((vsi->netdev && (vsi->type == ICE_VSI_PF ||
+			      vsi->type == ICE_VSI_SF)))) {
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
@@ -7426,7 +7427,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
 
-	if (vsi->type == ICE_VSI_PF) {
+	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
 		if (err)
-- 
2.42.0


