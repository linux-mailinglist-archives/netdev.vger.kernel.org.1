Return-Path: <netdev+bounces-95905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A508D8C3D3B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ADF3B21AA8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 08:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0F61474DB;
	Mon, 13 May 2024 08:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXQZPLJP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365B1474B8
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589171; cv=none; b=tJX6cirSNJDe2aWFtbmLFg/VrG2aXuDpylteIqpbqhWY/jPDGydUSKaUyvmCnLXBa2WiFHAqh6H6QPmnXkj0BkGrChfESeLKa2+9UX7NnQkxJ6uqaQF9XSKDNfkTpyMZSZCKR3VKqmT6XTwGlz2SoTZw2+25rPcrCd8yqeU9i+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589171; c=relaxed/simple;
	bh=/a8xZgcIwHCzfQSRk2xTwVeJnDlTCKa8eF0caQ2Ztn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ls4u1Td550jUMFSxx6KyDshxmGIk4fjTQW73KMsNGud/EqQe6D/kmsFVE/jpOY0pip9zTu54hZheBBSYm/q07fhdNSkoBTTud/Gu06w1DkS6sl1eyTeom3T+PUO/LM+0Wf1A4LV8H1E4bqrz35EUGG4QATRnq9aoPB5yL/9nkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXQZPLJP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715589171; x=1747125171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/a8xZgcIwHCzfQSRk2xTwVeJnDlTCKa8eF0caQ2Ztn4=;
  b=nXQZPLJP369moBtVMptWKCCrOi4jii2ALXoXn8tbKP5q5I69d5Y/dQdZ
   +/Bt2Wt1FfUrRdAR4T7lTY2xnPGkZCDUo6hv7f72MGBJAbJ28Uo8nY8du
   ad1ppxV0K1wy/R74Pfh5UdZYxf0ZdE8dzokFUlkTQBPxdiH0l0Nf76sfI
   ESE+D24rwjmScKEqAXjgWJUgUo8XnVMHuPDmrb2g2bXTFKHVc3cjT7ZuI
   HMEFOhji/mhWb+5aJAdjy0FKC81uzZtDcu2tIwiXRXgFw8CX3zY0tsb/U
   hglWGPR4RSXo+Q6EPj7npbE1SVIgPs+uML3QRTz3TV/HHdebZ8FIvJHJe
   g==;
X-CSE-ConnectionGUID: czUnyXxiSt6M0dH+fZRhrQ==
X-CSE-MsgGUID: Op8zax2AQ92GnH1sVQHhSw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22914819"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="22914819"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 01:32:48 -0700
X-CSE-ConnectionGUID: fxPliVWPQwWDbgMw5EwutA==
X-CSE-MsgGUID: Is44rideSuqFjI1YrXf8Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="30303437"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa006.fm.intel.com with ESMTP; 13 May 2024 01:32:44 -0700
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
Subject: [iwl-next v2 04/15] ice: treat subfunction VSI the same as PF VSI
Date: Mon, 13 May 2024 10:37:24 +0200
Message-ID: <20240513083735.54791-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
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
index e50aeed55ff5..a555f70f78ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6684,7 +6684,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
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


