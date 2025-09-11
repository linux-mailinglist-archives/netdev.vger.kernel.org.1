Return-Path: <netdev+bounces-222319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8EAB53D78
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABC87AB2F5
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB32DECBC;
	Thu, 11 Sep 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/3Yrb+X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DBA2DE719
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624744; cv=none; b=UgKZal5giJxJEZZNdsaYOtKrNpWOMoZ1SC7S/SHvNLs3ZF/O555hOhvdv8HgBVcM40CC7vLulXRou3/s7BGM2YVJVUNcNzQiO89MeHZ13WpB74kvrtApd8AkWnHNWklC0fe2rtgW0jVlBZM3CjH9YtxNDZO4QGek75MDQjIp6Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624744; c=relaxed/simple;
	bh=00AJuTuwXj+w7hJI4STlvDHJtbCqcHB7yp/p2RDsC48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qj4Uao6k/s8lss7Mt0+VaBBzLMA4Vg3p09xVHMem8i6XP25CoIsOhRAowAwbUuWvks2yTO/jTodF/4oWbhQdrfi8EYCypY3BnE0dSh1X/TTCLGgj7OBGgJBbwKto43FUT1KhfI8dFKWv7x2MZ5S5ggfED9oCD1Z+SitHmXFlSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/3Yrb+X; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624744; x=1789160744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=00AJuTuwXj+w7hJI4STlvDHJtbCqcHB7yp/p2RDsC48=;
  b=K/3Yrb+XaOHQYs5UXiep74pKLYHeKa8kY/lfESDRXgMxujB8orTiPcp9
   4fSk028tXfwpp5/Zuhp9kfY2m7lNIEi4RxnVqzeQ72NCDjjcV0ssOnbDP
   IrqXyscx5FFlMOS/uIH0V/b7+JE8PQ0au3LdFlTNJ4Yu8rc7eVOOwyBb+
   BLU0pqQdjhcwP1dv4Nf7oz7N7fXOed1qeFGDmSRtbQN6fkd2TuYY8KCk1
   n8YYKF6EVuaiSCYazN61JS3G5jmqmnlk4nFrR9FhqXAd1ZlFHH7CVn8Va
   pBHm0g6eJfoexffv1PQXRODdq3+WLCDm4o9YUBbnUKj7Hgv05BILp5OiA
   w==;
X-CSE-ConnectionGUID: e3O8fY75QfmDgMGv41sEZQ==
X-CSE-MsgGUID: razVKl7zS4eLozSylcBtMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558911"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558911"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:41 -0700
X-CSE-ConnectionGUID: dv2QynrPQFKDWR5mPRAoCg==
X-CSE-MsgGUID: PzD+szxFTOOhA7Nm8Y6Ndg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583372"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:40 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Rinitha S <sx.rinitha@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 08/15] ice: check for PF number outside the fwlog code
Date: Thu, 11 Sep 2025 14:05:07 -0700
Message-ID: <20250911210525.345110-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
References: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Fwlog can be supported only on PF 0. Check this before calling
init/deinit functions.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 8 ++++++++
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 4 ----
 drivers/net/ethernet/intel/ice/ice_fwlog.c   | 8 --------
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 16765c2da4bd..e73585d90eaa 100644
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
index b9849d1ef928..ca1e74082d57 100644
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
index f7dbcb5e11aa..2ed631e933b2 100644
--- a/drivers/net/ethernet/intel/ice/ice_fwlog.c
+++ b/drivers/net/ethernet/intel/ice/ice_fwlog.c
@@ -242,10 +242,6 @@ static void ice_fwlog_set_supported(struct ice_fwlog *fwlog)
 int ice_fwlog_init(struct ice_hw *hw, struct ice_fwlog *fwlog,
 		   struct ice_fwlog_api *api)
 {
-	/* only support fw log commands on PF 0 */
-	if (hw->bus.func)
-		return -EINVAL;
-
 	fwlog->api = *api;
 	ice_fwlog_set_supported(fwlog);
 
@@ -296,10 +292,6 @@ void ice_fwlog_deinit(struct ice_hw *hw, struct ice_fwlog *fwlog)
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
2.47.1


