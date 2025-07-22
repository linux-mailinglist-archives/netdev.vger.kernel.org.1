Return-Path: <netdev+bounces-208891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3078B0D7D1
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3C8AA309A
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85D2E426C;
	Tue, 22 Jul 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3oxiA8i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C3028A1C1
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182432; cv=none; b=pZFpCBeiNX/DhY8n4rrMTggaB1UMaFWLjFRB1md5bGcFNvAhhClEmRXUOejPwqw6MzYsxq8x5WNtkIxk3L8qpCgcpKU2NorbTiS3/jO0GTWMEAMs8VSUjripotuv7zVbIXszw1+1evaND8N0L//EYOAn2NdAvfbC9JNRegowtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182432; c=relaxed/simple;
	bh=QP9GUCAor9gC0Bchqukq1BDFNneOrXprXCte43gP9BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoyFDtQ6/f+N13PQmj4b8aAjQey3HEowAx6VfvF4loDCTCRNWMM3i5Q8z72o1uYUxHla6W5VNUHZcMgNUMKZVekSe8VyPuztbpPu0vMHviWxzihecb5BwRK2uy95j3/OyWtZlO1UN1qpBooFFBBcKDHRs3KEtV7bkQw9Cl5YhQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3oxiA8i; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753182431; x=1784718431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QP9GUCAor9gC0Bchqukq1BDFNneOrXprXCte43gP9BU=;
  b=M3oxiA8ixz8uVT6uwOni5X+A2Dk7YD5uGrf+FwDC+80FVmiC0C8gzYak
   6Gv5Q0EIPkIkI+pkvggMrg8UVuJIf24t/KgqMzDWGSvjWJbEVgYXpQckD
   km6WBs0I6oGzTDfIyD538fHBuhFD+ALQIY6Uy4CWwbYC4tHtUIXlCaTj4
   85KMfJ5fln1oKreMmezxRtMlCCwjqU6H/wKFOnT7TeJZiCSCNY2MB4Hel
   GvA+MGk9CF3agklXXf5ReoM5UUk6+q2s52684guBwrzNoJLPwcTgDBC6r
   5rF1yTH1mUQkNdeq6/ZdW5cREOdGJnsghdYtovcWOUTYvS4fzP60BMv15
   Q==;
X-CSE-ConnectionGUID: kMvoz4S/SbiuJOTmgbFEgw==
X-CSE-MsgGUID: PJL5Cyt+SFOIFCrs9dfR2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59083611"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="59083611"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 04:07:11 -0700
X-CSE-ConnectionGUID: JFW1nJ6MR06twSS5+tVPyQ==
X-CSE-MsgGUID: xd+8WJsKTHeExMa7dq074g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163153964"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jul 2025 04:07:09 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 08/15] ice: check for PF number outside the fwlog code
Date: Tue, 22 Jul 2025 12:45:53 +0200
Message-ID: <20250722104600.10141-9-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fwlog can be supported only on PF 0. Check this before calling
init/deinit functions.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 8 ++++++++
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 4 ----
 drivers/net/ethernet/intel/ice/ice_fwlog.c   | 7 -------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 9119d097eb08..2666e59b0786 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1002,6 +1002,10 @@ static int __fwlog_init(struct ice_hw *hw)
 	};
 	int err;
 
+	/* only support fw log commands on PF 0 */
+	if (hw->bus.func)
+		return -EINVAL;
+
 	err = ice_debugfs_pf_init(pf);
 	if (err)
 		return err;
@@ -1186,6 +1190,10 @@ int ice_init_hw(struct ice_hw *hw)
 
 static void __fwlog_deinit(struct ice_hw *hw)
 {
+	/* only support fw log commands on PF 0 */
+	if (hw->bus.func)
+		return;
+
 	ice_debugfs_pf_deinit(hw->back);
 	ice_fwlog_deinit(hw, &hw->fwlog);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index c7d9e92d7f56..e5b63b6bd44d 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -588,10 +588,6 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
 	struct dentry **fw_modules;
 	int i;
 
-	/* only support fw log commands on PF 0 */
-	if (pf->hw.bus.func)
-		return;
-
 	/* allocate space for this first because if it fails then we don't
 	 * need to unwind
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_fwlog.c b/drivers/net/ethernet/intel/ice/ice_fwlog.c
index f7dbcb5e11aa..634e3de3ae66 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -242,9 +242,6 @@ static void ice_fwlog_set_supported(struct ice_fwlog *fwlog)
 int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog,
 		   struct ice_fwlog_api *api)
 {
-	/* only support fw log commands on PF 0 */
-	if (hw->bus.func)
-		return -EINVAL;
 
 	fwlog->api = *api;
 	ice_fwlog_set_supported(fwlog);
@@ -296,10 +293,6 @@ void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
 	struct ice_pf *pf = hw->back;
 	int status;
 
-	/* only support fw log commands on PF 0 */
-	if (hw->bus.func)
-		return;
-
 	/* make sure FW logging is disabled to not put the FW in a weird state
 	 * for the next driver load
 	 */
-- 
2.49.0


