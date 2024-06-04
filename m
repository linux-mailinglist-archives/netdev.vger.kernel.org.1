Return-Path: <netdev+bounces-100569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D051A8FB389
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78271C21C3E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0957146593;
	Tue,  4 Jun 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvD+gYsr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C49146D54
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507335; cv=none; b=EiaEw2A2UIIbsttR+nt/MD7DArj6GaAoh0npmwrTVmtuNJlHM7vUi+TBDceSI/aaCkwSIZ8iM7hRpwmFn5I6+ABwgjYeNiSivBtHWRSq/0tHdoxRv2qJhr9gnJlP/cUxGIaDTRnk9LA72ogp+JP9oNrZ9AvKKpsYCp+Jg2fm7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507335; c=relaxed/simple;
	bh=p1JwXrBLeqtHbBTg1Kj/Bhit/0gw24QRk2fbCtHBAQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tJMe+yNnVKYWCgbsYcAg9AydOUWY64+9C5sF3YEIvs3mPUnOx3jAzd7W4pt7k2JILY4ym4N79xPny3s0DiGYMMA6jdr3JsAv8mfJ/Fe0pVHwDESQQNcMemME5va3o5QeNJmTcGvz3BwFdutdC0IbQ3/vzhBqSTkjYWaoKmVhwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvD+gYsr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717507333; x=1749043333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1JwXrBLeqtHbBTg1Kj/Bhit/0gw24QRk2fbCtHBAQE=;
  b=nvD+gYsrrd3zLatBQ4AL4w2SW3Di1Lj+uM5UZmF7D6Hgc7Q4yY0a4hRM
   flZJo1uWu/MDrykvduNVqGA/XNVJK80r6aoy8L1g8VyJJI0lcihoAHh6T
   9VkV7sf3k3BLYxX+feyChVq9O7zRmiYTz4uVPMy61qV/mWKAtVbBNzXmP
   1riP2cIjawzaehLgKx6oSbmFGSCBbrjNYg7fiM96PQYmGVAgR+zY6E2lk
   pR5XfcbElnkcJaom1YxEUhE37CkzmrDIn97KBOFrhNlZ+baRzZMA6e3RE
   yLTlY13WGhuXw6y6Wd64Gd+RC1uU222PIVz7SaeW5P115l+pEBbWTuvUR
   Q==;
X-CSE-ConnectionGUID: uakdV3M5Tv2fGUaqFt7c2Q==
X-CSE-MsgGUID: M36cT9SeRJOe+mAYok+bFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31552854"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="31552854"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:22:13 -0700
X-CSE-ConnectionGUID: x6sRikV9RQi67Hbr24oGKg==
X-CSE-MsgGUID: wFs4HhCQRMiqPhAPSDdbUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37350132"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2024 06:22:11 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH v3 iwl-net 2/8] ice: don't busy wait for Rx queue disable in ice_qp_dis()
Date: Tue,  4 Jun 2024 15:21:49 +0200
Message-Id: <20240604132155.3573752-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
References: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ice driver is spammed with multiple xdpsock instances and flow
control is enabled, there are cases when Rx queue gets stuck and unable
to reflect the disable state in QRX_CTRL register. Similar issue has
previously been addressed in commit 13a6233b033f ("ice: Add support to
enable/disable all Rx queues before waiting").

To workaround this, let us simply not wait for a disabled state as later
patch will make sure that regardless of the encountered error in the
process of disabling a queue pair, the Rx queue will be enabled.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 1bd4b054dd80..4f606a1055b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -199,10 +199,8 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
-	if (err)
-		return err;
 
+	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
-- 
2.34.1


