Return-Path: <netdev+bounces-212760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D3AB21C47
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E0962722B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 04:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8512DE6F1;
	Tue, 12 Aug 2025 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP+P46yM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7802DCBE0
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754974030; cv=none; b=MZw4EcWDmT4Fdf2iKk0DvUxIUXzuRNNC9x6DzS2LM1mFpaMjoqG1i1VrX7tWzse6DH58pPqFFaFg8sabm3YKTjuTQUdFK8aRFHCxptf/FtJBBdB105bbt5NKT5hxjKTf9bQ9KZJaY3yvC+Ot3RsqMVE2bTmCFYKPGmkaAmguTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754974030; c=relaxed/simple;
	bh=QP9GUCAor9gC0Bchqukq1BDFNneOrXprXCte43gP9BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktTa7A/6hb8IFtLFVK/tchFNk6qzH2m5utagzymOJvQw4VWZ0btDaXvKp2cr/ncFCsf/uOLwVOUgpeS5ROKMKurWVxxkcExc9HcL7g8VQxI2EMPCS0X+zRNMcNLSz5dx97SDlAwCMnNNliDvkpfvUAcCT8Y+fgATHJQ+TA+IOdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BP+P46yM; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754974029; x=1786510029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QP9GUCAor9gC0Bchqukq1BDFNneOrXprXCte43gP9BU=;
  b=BP+P46yM4dlnfOmOwKm90sU8nxjP2+Of6BHC+V1oUMP0Z1fUBEawb72v
   BTHmHUzAuePOijq+OqDRHClIIXAZCTxs1V4NNUx1RUv2jNwcy81TzLfXg
   9sCQRPm5Pi7DDsKrry1YMCy92jaXBrF9uzmfN7NlY4wqFG5FQ13URXtl+
   3d4EYfAErF9M0ckwVwvbhXqYdVjEdSyThC1KTXY8RbpwmfO5eTxMIlL6M
   odt+xaUm4yDoZ3ily1+OA2SH0W9ZqrIcy8tLdqDTn/lb4fZRAqzbqT6kF
   Rsra9+zeu9nAQLgPj/+hv5ppDuFuEFC8yBKG1+MonLuv+O8JMwjwQhQFL
   A==;
X-CSE-ConnectionGUID: VgjW7PX2RNqNx0EW2sl7dg==
X-CSE-MsgGUID: hnnxYprlRM2fsxa/0q/VNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68612758"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="68612758"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 21:47:09 -0700
X-CSE-ConnectionGUID: c0hNlJvzSbCJ9nmJonwOJQ==
X-CSE-MsgGUID: dVW1VjN+Spa3mdfZskJQag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="165327904"
Received: from unknown (HELO os-delivery.igk.intel.com) ([10.102.21.165])
  by orviesa010.jf.intel.com with ESMTP; 11 Aug 2025 21:47:08 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v2 08/15] ice: check for PF number outside the fwlog code
Date: Tue, 12 Aug 2025 06:23:29 +0200
Message-ID: <20250812042337.1356907-9-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
References: <20250812042337.1356907-1-michal.swiatkowski@linux.intel.com>
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


