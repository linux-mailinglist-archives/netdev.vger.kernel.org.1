Return-Path: <netdev+bounces-99695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D3A8D5E68
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94BFBB291D5
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639C613D63E;
	Fri, 31 May 2024 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwxe7tKk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D613213A
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717148055; cv=none; b=Pv0AgcIKYxx8QzhDqktkIzhszpl2wv2+0vJinSvseWGgMp1Km8weVRU/+LD/Im3MAq6KKujvheH8OVfJrToH5hy6QkuSvFppMcRCYHzIwJ0rrguLj1HEmkP1xSvzbT+pNFlLQiyZ6hDOtEAR5TYMUjrvaqaSVtZw5j6y6dxO41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717148055; c=relaxed/simple;
	bh=B27ThbPupqS5VuibtJJnlXAs+k8wq+jRHzw8yNlGgOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YGEWGkAxDr++qB5ZL45/8xgEaAn2ppbdcFJG3Bo9wf5/F4yedNxeYMGF/xDe4hbnnEyq431bvoncD0Hd3/A/UE1+VwMKOqCyPaGxb6b0fUSyBx5HbCq6JyKLl9i12fV3h/tK03TP5hEjz/B9QCCUvs1pNsT16Xfuoqvr990ztUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwxe7tKk; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717148053; x=1748684053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B27ThbPupqS5VuibtJJnlXAs+k8wq+jRHzw8yNlGgOw=;
  b=iwxe7tKkdASf0bPftwIr15UnFhMrb0cWm3Bc1IZaryx69zMp+/43rZMu
   tTzSy/BKuTV/Q9aFv9/W9wPidigL38fST0bQemB508GlTZL/Mwt/lTv0W
   CXUauyKTNJvdVi6UDt3K7nwLbHr5RphesHarF6Uhrvd3gd+8pNmM3nuCz
   a69LKQ6WNgJxVBLjlnsHC3ZkypefRBP6w/5VfF0zB++a1NrCUBSmLvl1z
   pgnh5nS0XgO9petRTcOQfQRGEXcIWho6BNFxDRcIs0wCPXwO0aWIERUr5
   IzHTFuI/TwN0Fk8j8Fi8zxI82l8W3KFlOEnH/KJiNaJCF91glc13BX+Mu
   w==;
X-CSE-ConnectionGUID: ZOthtjCiRXW9BBYUHa70Yg==
X-CSE-MsgGUID: ADLbMYuhTeGsz7hNKqxlMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13525910"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13525910"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 02:34:13 -0700
X-CSE-ConnectionGUID: ALLnxrz+QbKsuYSFb8BWmQ==
X-CSE-MsgGUID: D3kAH/ToQt2XEImtr1E8OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="36194617"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 31 May 2024 02:34:11 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BB52B125AB;
	Fri, 31 May 2024 10:34:10 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH iwl-net v3] ice: implement AQ download pkg retry
Date: Fri, 31 May 2024 11:32:06 +0200
Message-Id: <20240531093206.714632-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
to FW issue. Fix this by retrying five times before moving to
Safe Mode.

Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
v2: remove "failure" from log message
v3: don't sleep in the last iteration of the wait loop
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index ce5034ed2b24..f182179529b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1339,6 +1339,7 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
 
 	for (i = 0; i < count; i++) {
 		bool last = false;
+		int try_cnt = 0;
 		int status;
 
 		bh = (struct ice_buf_hdr *)(bufs + start + i);
@@ -1346,8 +1347,26 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
 		if (indicate_last)
 			last = ice_is_last_download_buffer(bh, i, count);
 
-		status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE, last,
-					     &offset, &info, NULL);
+		while (1) {
+			status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
+						     last, &offset, &info,
+						     NULL);
+			if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
+			    hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
+				break;
+
+			try_cnt++;
+
+			if (try_cnt == 5)
+				break;
+
+			msleep(20);
+		}
+
+		if (try_cnt)
+			dev_dbg(ice_hw_to_dev(hw),
+				"ice_aq_download_pkg number of retries: %d\n",
+				try_cnt);
 
 		/* Save AQ status from download package */
 		if (status) {
-- 
2.40.1


