Return-Path: <netdev+bounces-88469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE348A757E
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43FA1C20F12
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7A613A3EE;
	Tue, 16 Apr 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ludVfeBj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD27139D18
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299057; cv=none; b=fFkiiSqNk1B6Jvz7mZLJLx8dspGN8fzzyrfkgpcL4XVdp9RT+1oIDG4HTj3Y5FHM0/ZZqcLfzOyfSY/jV26T9dd46Xjk5xtrr/4BWAyDJrMXSLk6khHVRSLv93SZi9skanLfFz8B5kd3NvILXjS3T+1R1e+qJGgXiD7l3lmhvm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299057; c=relaxed/simple;
	bh=Xy691gG63Qt3bA4amjinW1w/KYLE226an9o6FoGMMEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPoHu7StmyLjbd9HVcr3dLc6ZKjvIdQdViD1jVpOH3zmsHn/NYVYa4yKTRGSwNg4FQKkTnlcDOd3Syze0RjPNpiqmvZ1OCm0tcIPLVbkw5dq1cCdFcjTwivDZTlT1gyTvG4M/xBSn/4ebxJWEn2hBJCE8cORyE3W+d+cXlN1nGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ludVfeBj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713299055; x=1744835055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xy691gG63Qt3bA4amjinW1w/KYLE226an9o6FoGMMEI=;
  b=ludVfeBjhb0Yddfw4s3LnOa3gJsApNKPayIqcyh+oWAztInUWF/Cz2le
   x0HxGTa/kbmpCER3LDMjVytMIy7/70ZW7uh7nH2RvJYuNAHg/LQ2tt4FS
   jWU+qGIDEBoiPPa32cHJBfJnkNqg6W8ccuDegzNcDyZHZeLta+SJginA7
   +/Rtlal+ab5zB30o5CnvMcBxi5rCzwscLzudB1D0Y8cm0oLfyJ+e0e9pi
   6eZ1mRxYBjPuT9xouLHvQ43+rdxa8hOAgqLFtt1JhZA5pJRkpkqZ9ne5z
   6hPFn/Ht7cVDhwNqrIxZEA992PFJgUQ9FuXRmYndyYWIkZdaKkkN+y/z/
   A==;
X-CSE-ConnectionGUID: HKYiwdcWRcK3gAU+EaVbEw==
X-CSE-MsgGUID: HRbKAdVQQaSHHfb3BMyB2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8688463"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8688463"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:24:13 -0700
X-CSE-ConnectionGUID: wLiifA18TZuMNNLObzging==
X-CSE-MsgGUID: 5H1DzLZfSYOQrVBQO5TXJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26941880"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 16 Apr 2024 13:24:13 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 3/3] ice: Fix checking for unsupported keys on non-tunnel device
Date: Tue, 16 Apr 2024 13:24:08 -0700
Message-ID: <20240416202409.2008383-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416202409.2008383-1-anthony.l.nguyen@intel.com>
References: <20240416202409.2008383-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

Add missing FLOW_DISSECTOR_KEY_ENC_* checks to TC flower filter parsing.
Without these checks, it would be possible to add filters with tunnel
options on non-tunnel devices. enc_* options are only valid for tunnel
devices.

Example:
  devlink dev eswitch set $PF1_PCI mode switchdev
  echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
  tc qdisc add dev $VF1_PR ingress
  ethtool -K $PF1 hw-tc-offload on
  tc filter add dev $VF1_PR ingress flower enc_ttl 12 skip_sw action drop

Fixes: 9e300987d4a8 ("ice: VXLAN and Geneve TC support")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index bcbcfc67e560..688ccb0615ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -1489,7 +1489,10 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		  (BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
 		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
 		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
-		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS))) {
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_OPTS) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL))) {
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Tunnel key used, but device isn't a tunnel");
 		return -EOPNOTSUPP;
 	} else {
-- 
2.41.0


