Return-Path: <netdev+bounces-97175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B488C9B79
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 12:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970BA1F2241C
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8505F5337F;
	Mon, 20 May 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBOfE9Bv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D596B524DC
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201555; cv=none; b=qv8LtEKMa3M5ItArvV/YbsegTovctexJ6nk/zVFsq2FIatoe79vZDf0U+D9puGOlg8TYdG6Uvm/4hJamnK4Bzf1AESYxJps34lXE+VxEY0r4MfrJ0A4FgW26hs9U/Fr2a3n9ndgKJ1Jb/KbFPPrAFpwm7PHHtjBxuwYuHzakLQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201555; c=relaxed/simple;
	bh=kgB4AHCFonuq9Yiu5dzmjUmmAbiK9vcIe8NHet0Na6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ti4DRSlG0EXpcO9wrFZ43S9JrpuXPEb2mBbQk5tEfCuIFzBHNPFSNOJoRAYYti9wzSG4lKwPWlFp4zqXmagBIofB3hLY9zMztS8KRgdLB/lgXjWT8+1LhijH+T3fB4EGxNIiEKHOlKz8QeuS8jFUuE19jAKQbYBMEFBaXVJukhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBOfE9Bv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716201554; x=1747737554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kgB4AHCFonuq9Yiu5dzmjUmmAbiK9vcIe8NHet0Na6I=;
  b=YBOfE9BvL/BBz+T0ll3NkZ8PmeF9K/8txkViC7DxEdn2V8MbnU6uJw3F
   c64TSWuAw/E6gB2xOkCvXi4UhWrsUZK45x13mwT4EX3bMikkJvyDxBr4x
   L60KIJGY8dO0FH0/XzlKrl7BQR9RE+ygYmIBMTRgHEt2NE6WJ6+sw8wWJ
   SNEVAGqc55EjCx9kUX/43wk4dnwl3CphXl57v25SbwjFrAWSo1tjh0DCh
   bgsaCU5IwzUJWDeIRzANeEd7JHvQMAjDm/DziJIvba6IZnZE5Vp6DEUOH
   Ybw+wayprHfJVxio0tQZ6tpMmYmdzY/8NqD+JBHtf4IvHOk+uj7o6+25Y
   g==;
X-CSE-ConnectionGUID: 2g7NwyznRaeMT0HPZ+0IJw==
X-CSE-MsgGUID: naf22ep8Q++gGKA3nNNjmw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12169924"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12169924"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 03:39:13 -0700
X-CSE-ConnectionGUID: T8CGvU8oRdudpcVq05li8g==
X-CSE-MsgGUID: wlIPx+6uTIC5OZCo7sQu5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="37078912"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 20 May 2024 03:39:11 -0700
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9F9F327BD9;
	Mon, 20 May 2024 11:39:10 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	naveenm@marvell.com,
	bcreeley@amd.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH iwl-net v2] ice: implement AQ download pkg retry
Date: Mon, 20 May 2024 12:37:00 +0200
Message-Id: <20240520103700.81122-1-wojciech.drewek@intel.com>
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
---
v2: remove "failure" from log message
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index ce5034ed2b24..77b81e5a5a44 100644
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
+				"ice_aq_download_pkg number of retries: %d\n",
+				try_cnt);
 
 		/* Save AQ status from download package */
 		if (status) {
-- 
2.40.1


