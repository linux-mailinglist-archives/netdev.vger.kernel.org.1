Return-Path: <netdev+bounces-98790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843D98D27C1
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B5AC1F2379C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B3A13E881;
	Tue, 28 May 2024 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEZxiIBO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C313E041
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933984; cv=none; b=S8JEFZ+DBFx20DiR5xSz/d4hYs8Ge7itJ6SjtjnaeteIGxdAnnr+Zq2+Qc0psC1l0/i3pUXPkxi7vvJRgByHFFOw03H6/Sip4kJXOeQ3ehIcKQpc03AiopMd2DfsmtIlKY5R0jjMDtCk6sRhQ6CwhfF6zLNLwNMmBPwHEThc4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933984; c=relaxed/simple;
	bh=u5fLStCG3nuS/h7HpE4+72Z+bjHgTZXrM54CD659fUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atgoLznTsjMe6On0qrJfAikQaj939ju3MoBFS1lFlMnUdK7w25SO57tdo2/7YTTWTtwdfaetJiRNpqx+/uw2jSVLIMwmZDxcgCJMintTqW6hPOvNaJcScMMFJB+IN47oB+XDDhoF6M+1RTVU8zMefP/wjWixCmaFlskliMM9D84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEZxiIBO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716933983; x=1748469983;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=u5fLStCG3nuS/h7HpE4+72Z+bjHgTZXrM54CD659fUc=;
  b=oEZxiIBOjNGhEmf3AMHBGRxgRkN4gsKWgUUe1HaiLwR4wNQnjf5Cj6Tf
   nxK6ZA7hXpr8mh1jqonBwCJBcuEwXBWFtPQCs6XUrPYwvW9NzboYGwYg1
   5Mc7ly6bSHMWSQL8HY/U7M4o1b7E41luXtEVMPnQiv1UXYLWKFbpdvYEw
   2HFQVXEUvx7RZ7VnNqTi0RBkCSl9J3iCsgjBDxzPdmM9W5Fz+w3E5GGrk
   AkvVxd5St+j1V3JqyYzmuUD397lSSbBT/UO1RPE9k/N+PTF83LEP0T76b
   1Gw74mgIrG0dLRVWxCo0e/hyWk/CtyFaOg/wWTAba7Ui9cUR3vci7nzHE
   w==;
X-CSE-ConnectionGUID: LQjxCBOCTluMdSR+IRs3KQ==
X-CSE-MsgGUID: vliHrYz0QCKBj4zrUbzUiQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13439626"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13439626"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:19 -0700
X-CSE-ConnectionGUID: AUH9qTsxS26EhQKf3my4yw==
X-CSE-MsgGUID: Iwuum8cTTSKVVh1k1S0gvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40087528"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 15:06:09 -0700
Subject: [PATCH net 6/8] ice: implement AQ download pkg retry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-net-2024-05-28-intel-net-fixes-v1-6-dc8593d2bbc6@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
In-Reply-To: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Brett Creeley <brett.creeley@amd.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

From: Wojciech Drewek <wojciech.drewek@intel.com>

ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due
to FW issue. Fix this by retrying five times before moving to
Safe Mode.

Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP) download")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
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
2.44.0.53.g0f9d4d28b7e6


