Return-Path: <netdev+bounces-75967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A0D86BCEE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0B3B24830
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4471CD23;
	Thu, 29 Feb 2024 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNBroqZv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC2107B2
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167302; cv=none; b=QRMcJdBLB4iko4KY8BTd/QNj4/bmb69W+GSvqgyWMGmcm4JsoSMaQ91q0GhYUMZQhl14E2OJ08eOJ+36GOwxiL1+uS9ksbTQlx7kAaV9BLcRSaYC4pZMNn3YoAlLJ4mWHyZAK1WGydcyt7iOdTgWo27z5zqHeyUWFpZl5I2WrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167302; c=relaxed/simple;
	bh=diKTYoM9EX0EsS81vwzbZ/W/nLmiOB0HhoflRmzB4zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=db07DJ7cW35wvs0iam8drIdMsubkX3zaG6ZyRg96T9famBUFtDSChyd9yXHRGRyu0mIUNTz5FPk/7+uSpESOtjNYSSHF6elIe2+TEIBOCb0dwfypHfZDRWHyqCXHNJPVh/rrxh2E4WW+txPWZeuqWYEvEF9z+4lUARUQ4zCy7tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNBroqZv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709167301; x=1740703301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=diKTYoM9EX0EsS81vwzbZ/W/nLmiOB0HhoflRmzB4zQ=;
  b=XNBroqZv8EpWss3/shAk8HElQlvfAbnyzNKLpKHceG7CSgfvYyWIXOzC
   P5LykFvIQdOubzL3tB2ouMzi8jrF961QIfRQVRKkmDw85n1imlhxSWozR
   PRvKiaBMLjyy3gcwgogrIbz4eNx8LNGsTLIoXD2UUweMp5j3LwQgg1jf3
   6izWKGeBeS4V1e/+3CUyXxy9ySsbBX3EsT4wM6N8Talc/ll766BLOvz1x
   9+5+DPcaeTz5wpjbbgTAT/agrXznK5mFL8/5inIQ6HStPvYtLXnwYK/gW
   +K1BXAUaGkGdoQaB3zFuBYqtttKsIjBiejUhn5Z4fRvbRqZ0QjY9ik//c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3776513"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3776513"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:41:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="12281946"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 28 Feb 2024 16:41:39 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jon Maxwell <jmaxwell37@gmail.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/4] intel: make module parameters readable in sys filesystem
Date: Wed, 28 Feb 2024 16:41:29 -0800
Message-ID: <20240229004135.741586-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240229004135.741586-1-anthony.l.nguyen@intel.com>
References: <20240229004135.741586-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jon Maxwell <jmaxwell37@gmail.com>

Linux users sometimes need an easy way to check current values of module
parameters. For example the module may be manually reloaded with different
parameters. Make these visible and readable in the /sys filesystem to allow
that. But don't make the "debug" module parameter visible as debugging is
enabled via ethtool msglvl.

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e100.c             | 4 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     | 2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 01f0f12035ca..3fcb8daaa243 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -171,8 +171,8 @@ static int debug = 3;
 static int eeprom_bad_csum_allow = 0;
 static int use_io = 0;
 module_param(debug, int, 0);
-module_param(eeprom_bad_csum_allow, int, 0);
-module_param(use_io, int, 0);
+module_param(eeprom_bad_csum_allow, int, 0444);
+module_param(use_io, int, 0444);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 MODULE_PARM_DESC(eeprom_bad_csum_allow, "Allow bad eeprom checksums");
 MODULE_PARM_DESC(use_io, "Force use of i/o access mode");
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index cebb44f51d5f..244d50cbcc4b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -202,7 +202,7 @@ static struct notifier_block dca_notifier = {
 #endif
 #ifdef CONFIG_PCI_IOV
 static unsigned int max_vfs;
-module_param(max_vfs, uint, 0);
+module_param(max_vfs, uint, 0444);
 MODULE_PARM_DESC(max_vfs, "Maximum number of virtual functions to allocate per physical function");
 #endif /* CONFIG_PCI_IOV */
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index e23c3614fb10..6d8268be01d4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -153,7 +153,7 @@ MODULE_PARM_DESC(max_vfs,
 #endif /* CONFIG_PCI_IOV */
 
 static bool allow_unsupported_sfp;
-module_param(allow_unsupported_sfp, bool, 0);
+module_param(allow_unsupported_sfp, bool, 0444);
 MODULE_PARM_DESC(allow_unsupported_sfp,
 		 "Allow unsupported and untested SFP+ modules on 82599-based adapters");
 
-- 
2.41.0


