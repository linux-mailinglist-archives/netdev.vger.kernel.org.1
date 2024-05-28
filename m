Return-Path: <netdev+bounces-98381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306D38D135B
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626FA1C2177E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 04:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C41C68D;
	Tue, 28 May 2024 04:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aD6Q6yHx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889D18637
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 04:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716870802; cv=none; b=J1gtCcWTS0eTuxKwzcFATZB2Z2tUtMSMbScFMmjoxX25D9DAJdNElvVaV/tsRwKnG8c89zhSK5Ox8eMuksV5lxRj7mW2wEucqvN/3CjDrZUV+ucT2p6UJVd6ST5+HOVrlVFm+CBki1JYukYp9llw4SML2Oz0EdU/PlUqY6YQa7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716870802; c=relaxed/simple;
	bh=AmTv/tESt7mKCy4H6882eS1bVEIx1GnnoIApdy9Leyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPZkwD6jl838gdJ8CqC75kfHs9zYHI2EJ5he0zuPdiCR7tIGx31hpd1ponpCFo3utVk1tjg6CfhFR8mLMvdpvcqL2ED9v48Zh06aYa2qhb2T9PqOpIzvCHUX0BrIL28Ltyqb/y3hyuaXdeNOK5ygeWRMXMRBQ5j+cjDVYuG0v28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aD6Q6yHx; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716870801; x=1748406801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmTv/tESt7mKCy4H6882eS1bVEIx1GnnoIApdy9Leyc=;
  b=aD6Q6yHx62iaemodiPFzKaDThAjj4VdDWQi59qnb/rUjO43QQ39l8d74
   tHq3Vey793lHTAFBTr8jMcYhQe/sTZDWbLmyRInMxXh5O0nWoWWlteQNR
   K87JJF86WPmbkK3/dp/FqrMWKNRNrqcUGjY3lo8KiObAA/hKS8K2Dz2Zs
   LkD5Oql5/Q9mA4sCUcwH30pi6JQjPrRFOpPy6yjtO0l5U4WfcpKvfHZMT
   UtUfEX85D+qBjMvOGO4nywppBzM5SDyD7PPHKvjy+/CsikKlmJUIT+j2Z
   +IiJGJi/jAfEmmB9bNiTdaHQ2QvzNqbgGGeWKcMdaipzfxxtSZtSz+XZd
   Q==;
X-CSE-ConnectionGUID: iRecQ+8dRGq0oOtlNzfyLg==
X-CSE-MsgGUID: GYeL7rvBQ9eIDtekQ7rDNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13020089"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13020089"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 21:33:21 -0700
X-CSE-ConnectionGUID: 7Nwuy5psT8KTtXZqyx9GuQ==
X-CSE-MsgGUID: lBp1n1uHSD2TuYrvMlrF0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="66152410"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 27 May 2024 21:33:18 -0700
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
	shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [iwl-next v3 04/15] ice: treat subfunction VSI the same as PF VSI
Date: Tue, 28 May 2024 06:38:02 +0200
Message-ID: <20240528043813.1342483-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
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
index d1d9b63822f5..e32f4307994f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6704,7 +6704,8 @@ static int ice_up_complete(struct ice_vsi *vsi)
 
 	if (vsi->port_info &&
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
-	    vsi->netdev && vsi->type == ICE_VSI_PF) {
+	    ((vsi->netdev && vsi->type == ICE_VSI_PF) ||
+	     (vsi->netdev && vsi->type == ICE_VSI_SF))) {
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
@@ -7402,7 +7403,7 @@ int ice_vsi_open(struct ice_vsi *vsi)
 
 	ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
 
-	if (vsi->type == ICE_VSI_PF) {
+	if (vsi->type == ICE_VSI_PF || vsi->type == ICE_VSI_SF) {
 		/* Notify the stack of the actual queue counts. */
 		err = netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);
 		if (err)
-- 
2.42.0


