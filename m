Return-Path: <netdev+bounces-100559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC79D8FB331
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5334FB2BE9D
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA59146588;
	Tue,  4 Jun 2024 12:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P5RdKaLd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34E11422B4
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505840; cv=none; b=uad3oiwsbvXzglysKir7VK5TqvdMiufouwTFvuDJV3efmDLoxNDG1eCxKPVLgkCeTStunqV/Ha5S4LC9oRTXjhTaGbHVLMxXm5LpOXcg7QmubnNdmP9QhzEw216ifysRIdN/1hcOlOD1pA2iJ9QdI9wq80Q9Dfnrwbhqe7u9krA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505840; c=relaxed/simple;
	bh=9QRE6QyhzZCtFs3LRqDV+9PpiMqhE5qgsLSY5FDmQ18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NhurhJPllbCFpcZM7XQ3+BkEpCxyDj3d0TzMU24MhP/+F2lYRQwfPVAtv4rhmGzfdFKbnj4r5pnhm6ISiLtN6hmaUwYeAklrscaJacfj8vabfPvsQSqm0sYGsT0d5YnXQq7ErvqzrtmhAo0gykx18G/MkvgntQ4c31rNLDXoLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P5RdKaLd; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717505839; x=1749041839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9QRE6QyhzZCtFs3LRqDV+9PpiMqhE5qgsLSY5FDmQ18=;
  b=P5RdKaLdupwepTJ3MuKkp1sfEwod/jcE5XQc7PIAL72Ka85cTg5XQYb6
   1PWD8bBuKsPDKtCQO+kgdhYS81sbwIAAeQj7vX4/7T1hkndnBmxztymvC
   iwLMHX8Ai2c2TWHxEiK86++4of2E5FH+dyjT07ghV4Ls9urFnF1ZWyPB/
   g0g1xy0bxzJXNlmtmI7cAkve/f/VprpRHNUygqbTkglGpWlZ5+eZ3oBEi
   9SRnGeBzeAsywY/qP2Miu3Kktlido8/VUxaIM63k+kWkHl1J5AxwqPazO
   rO/29WTpXh+S/T2eNO3gpdkFEVoZdzDNBw+AxhyNs1k+JBCmRl6wY1zEq
   w==;
X-CSE-ConnectionGUID: jQ7DMXnXRLeQ99FPZy0Z4g==
X-CSE-MsgGUID: QFPkzaY7Td+uYQuBzQrCGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31583607"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="31583607"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 05:57:18 -0700
X-CSE-ConnectionGUID: nfqG6T0wSW+MpnJU7moK0Q==
X-CSE-MsgGUID: 5XOJMMmaQ8u5HD1Mb3L2LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37698338"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 04 Jun 2024 05:57:16 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 09FDA125B4;
	Tue,  4 Jun 2024 13:57:14 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org,
	jacob.e.keller@intel.com
Subject: [PATCH iwl-net v4] ice: implement AQ download pkg retry
Date: Tue,  4 Jun 2024 14:55:14 +0200
Message-Id: <20240604125514.799333-1-wojciech.drewek@intel.com>
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
Safe Mode. Sleep for 20 ms before retrying. This was tested with the
4.40 firmware.

Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
v2: remove "failure" from log message
v3: don't sleep in the last iteration of the wait loop
v4: Mention the delay in the commit msg
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


