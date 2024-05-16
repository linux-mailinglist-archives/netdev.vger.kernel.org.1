Return-Path: <netdev+bounces-96740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779728C783A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 16:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09921F21870
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FC11487E1;
	Thu, 16 May 2024 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqf0JihA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A4147C75
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868405; cv=none; b=ol6ghI0Ntw3K4Cpi9O2OXYK828sg7LVjCrPTqHl32RfTKMst8779A/RkyaKHO9sTPv+gx9ecgmgdq19PiJX5Xs1zz6UJf/XP+UGZ1TSWKrOB4fiKcGJRZ4J3tAqHMvCi4WW5RIfLdJtpQkLYOkZd0hy9BDcJ8N7uVIzvQIabmrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868405; c=relaxed/simple;
	bh=1meNr4gmZklS0C260mbbqDqUdbj2abQB/UN7m80/d/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZbreWFe+l41etnge1m1Vwi518GKCjF0caRaVsCfGr6ASpx20DAe3jCvOnC/91X0dhnfIcNc154pwBNcbBZp+U0yi36Zz0A4EDShrL8IFx5hnWSXINGM+Th60PcIvkmZzbsyLpGKkhc1W3tt6fmH9LpBzmwAX8FEFaBIIt7o1bss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqf0JihA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715868403; x=1747404403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1meNr4gmZklS0C260mbbqDqUdbj2abQB/UN7m80/d/k=;
  b=jqf0JihASSZvotbRLpfGAA78l5M4AJotNaed+XrXVCuRq3XoDN9p6yC3
   GM5jEXPeQho5kmTZR+BGoMGz+Qts7NpyKbX95RJ4FWbTMtwdmtbuGAqMF
   vcEloFUIctyFdFpATVPNIhLojNIwTCt/wVEPSQbFlo29X5LODrvpaKPFV
   T3rDwFg061br+E/q/12h22/25jatwvv6sOaG/udR/CCcq5PvIsfISE8O1
   MZ7vlVEi7USowwp+Jb6kpiczb7wT98eR0kWiUwIWugAXcMpp6NopsSSAu
   qlUVxfctkQC0m0FPKMBMXM6gfCcClFWhRhJSe+N99UKp0KVFmsicbvrCc
   g==;
X-CSE-ConnectionGUID: o9tgLojqScmJHx0xIY+iFw==
X-CSE-MsgGUID: vQCdhM96Ru+Hw8p46MFWrg==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="12164652"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="12164652"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 07:06:42 -0700
X-CSE-ConnectionGUID: ixZ6xb/FTKWh+hPlWQdzgw==
X-CSE-MsgGUID: FZZPw3sxRSmx8XinnsIvow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31369877"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 16 May 2024 07:06:41 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BDE0928785;
	Thu, 16 May 2024 15:06:39 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
Subject: [PATCH iwl-net] ice: implement AQ download pkg retry
Date: Thu, 16 May 2024 16:04:26 +0200
Message-Id: <20240516140426.60439-1-wojciech.drewek@intel.com>
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

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index ce5034ed2b24..19e2111fcf08 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1339,6 +1339,7 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
 
 	for (i = 0; i < count; i++) {
 		bool last = false;
+		int try_cnt = 0;
 		int status;
 
 		bh = (struct ice_buf_hdr *)(bufs + start + i);
@@ -1346,8 +1347,22 @@ ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
 		if (indicate_last)
 			last = ice_is_last_download_buffer(bh, i, count);
 
-		status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE, last,
-					     &offset, &info, NULL);
+		while (try_cnt < 5) {
+			status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
+						     last, &offset, &info,
+						     NULL);
+			if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
+			    hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
+				break;
+
+			try_cnt++;
+			msleep(20);
+		}
+
+		if (try_cnt)
+			dev_dbg(ice_hw_to_dev(hw),
+				"ice_aq_download_pkg failed, number of retries: %d\n",
+				try_cnt);
 
 		/* Save AQ status from download package */
 		if (status) {
-- 
2.40.1


