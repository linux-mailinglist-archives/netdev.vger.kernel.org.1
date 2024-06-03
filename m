Return-Path: <netdev+bounces-100395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F638FA5D7
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 00:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7C91F2399C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF781411D3;
	Mon,  3 Jun 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W89SXTqb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05114039A
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454308; cv=none; b=MuJ4xlLXU7WQLo5eNdPjyKfw0YTVXaeX6m4hnrGY5UskXj3g1gGkk6AE2yc+MFVpHuiIeYbtMOX8PCBCpCdNK6UUiL/MZgCBmzld7oPEEBKQxmWFjHgWPD/kt0oRJDoXQgyXmgGTPF/KcPW0SlmW5sFuQQhB0tK1p7rZ5jhQcgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454308; c=relaxed/simple;
	bh=KsJ8yunZ/jIyjGmyqxaEFGPcWKJlerq3zOg0T3tCmJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=awalpGtrBvTx1M4MX/btEsi3nmwAaq00K31Ye6S/MbgI6spFLiGYjfixJc7Hx/QBTGFw9pHKDab3XjmKmG3JB+Xr2RtZp3NdRMUfFCmTlhyCmgNX/Sj+N6m78ZWj5o81O+gGjqQCRdjLrHhcR6nRoEmoq/p4n1p7aXZvLV65XXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W89SXTqb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717454307; x=1748990307;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KsJ8yunZ/jIyjGmyqxaEFGPcWKJlerq3zOg0T3tCmJE=;
  b=W89SXTqbupTlROuLOtczv6g8/HDXPGyvM9THKzcjBno77E9FNmCkA3au
   GSFZM/18sTcqqXAiWnBX++fVDegWr48w4gbkkt33gQifBU6NGGQzvrqeH
   ekhR5VS3TaBpEPiIvPIvj4UYkDlhAg4b4kuszAwFejy8rHzIoE42csDid
   bW9KFP71m74pOkFiw9H7HnuerBCqgD7VHnJL7JNPi+zuNAX9KY7gusD19
   2Qgh7FnUdjEEm9YNEhy5IfacQ1VnLmbcOLqKpDNLR1gHvCE78C3iPzryL
   Ci0RSiwqsgHqjnkcO4m330HnQtCnSv0Hr7WytOVDLNAdPEJW3afInzFTZ
   Q==;
X-CSE-ConnectionGUID: dtByh64tQbefu+ZLRdc/hA==
X-CSE-MsgGUID: QfH7vB2CRw+YKxrXMSlN/g==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13780131"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="13780131"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:22 -0700
X-CSE-ConnectionGUID: SXQqb+gRSVCYRln5MLPbRA==
X-CSE-MsgGUID: 7iLbRlvQSWSf8VGW+aN5SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="41471204"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 15:38:22 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 15:38:20 -0700
Subject: [PATCH 8/9] ice: Check all ice_vsi_rebuild() errors in function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-next-2024-06-03-intel-next-batch-v1-8-e0523b28f325@intel.com>
References: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
In-Reply-To: <20240603-next-2024-06-03-intel-next-batch-v1-0-e0523b28f325@intel.com>
To: David Miller <davem@davemloft.net>, netdev <netdev@vger.kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Eric Joyner <eric.joyner@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Karen Ostrowska <karen.ostrowska@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

From: Eric Joyner <eric.joyner@intel.com>

Check the return value from ice_vsi_rebuild() and prevent the usage of
incorrectly configured VSI.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Eric Joyner <eric.joyner@intel.com>
Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a5d369b8fed5..74a4b3cb3094 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4135,15 +4135,24 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
 
 	/* set for the next time the netdev is started */
 	if (!netif_running(vsi->netdev)) {
-		ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+		err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+		if (err)
+			goto rebuild_err;
 		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens when link is brought up\n");
 		goto done;
 	}
 
 	ice_vsi_close(vsi);
-	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+	err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
+	if (err)
+		goto rebuild_err;
+
 	ice_pf_dcb_recfg(pf, locked);
 	ice_vsi_open(vsi);
+
+rebuild_err:
+	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n",
+		err);
 done:
 	clear_bit(ICE_CFG_BUSY, pf->state);
 	return err;

-- 
2.44.0.53.g0f9d4d28b7e6


