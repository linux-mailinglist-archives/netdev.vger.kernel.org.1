Return-Path: <netdev+bounces-118203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0B7950F4B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73B41F2389F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA5F1AB537;
	Tue, 13 Aug 2024 21:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfGn4b1J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55F1AB50A
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585822; cv=none; b=TNe25sHQ2HsYX72JV48gn4VQ6zbZcQX8d4wcAKVUuZLmOf6p4NrdYnuH94S/3PaR9MG+Cxhs0jOmRWpywOHtL80r0+eXuIbapEC2/vezYqHmGpaKChuCDLm7PR4OA8qTsAGBfD9r+ffXjxZb5I37zi1VYauA/YdQPtThMayo4uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585822; c=relaxed/simple;
	bh=D52LaZZ2z6obrDRwyzSgy9Xt17Q6Y7mlEVS+23W4KKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBCxyaI94EUZJE+lp+vv8pvcdoDbvIQdtM4pER2BYMSZLll/up+sazd7Qw+oAxzmFOZ/7ERUzL0Uchi94jdU0hyWHDpfJzmiU7szg2vYJzkcf3GTtug0RlG0JTiXnEM4VEAK8UWfDOWZmBhKv/gXh0Yq8ngIftHz5jgeMN15GtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfGn4b1J; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585821; x=1755121821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D52LaZZ2z6obrDRwyzSgy9Xt17Q6Y7mlEVS+23W4KKE=;
  b=hfGn4b1J88Ti3PQ8uyUfTqfCtj5LxDp0vHPMaCzZByYjizksmG8Y1T2S
   nAW1MSgAxUh4gdBi+PK5nGppEMooLbf8iXmIKX9wnvgHvBu1UmGfpuaST
   FfPsFpfZmZRZMCXkmr+UmKGidrG0HTZxL1+sNinuwu4j/NWi316LzjK34
   zxxqgEtJ676w1SOHLcnaqCRQgC/g4KhxJYxFC6dVzEtBaUSP1eAGQjxPC
   ZeM+JdIropuYh3pWM0lW9R8lmwBp8NaxufuKCzuKlxaqrY9bjcGuw/qKI
   psZEX2Dm0WtyPTkFCUKz/ll2KYqwO48keh24H0Yb5Hg09dsLIlvgKCR6w
   g==;
X-CSE-ConnectionGUID: S0gSNoJzRWuH7+oerEBaRw==
X-CSE-MsgGUID: vUNf+YHcS26cvoOn2SKi/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21748128"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21748128"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:50:07 -0700
X-CSE-ConnectionGUID: DVKq7Fc2RKu0e1VTfNiDnw==
X-CSE-MsgGUID: lFT1k50fTxGA+KuBKWtwiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58685564"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2024 14:50:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
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
Subject: [PATCH net-next v4 04/15] ice: treat subfunction VSI the same as PF VSI
Date: Tue, 13 Aug 2024 14:49:53 -0700
Message-ID: <20240813215005.3647350-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
References: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
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
index be3237730511..0dfba2c59925 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6730,7 +6730,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
+	    ((vsi->netdev && (vsi->type == ICE_VSI_PF ||
+			      vsi->type == ICE_VSI_SF)))) {
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
@@ -7428,7 +7429,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
 
-	if (vsi->type == ICE_VSI_PF) {
+	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
 		if (err)
-- 
2.42.0


