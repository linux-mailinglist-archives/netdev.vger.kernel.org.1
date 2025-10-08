Return-Path: <netdev+bounces-228191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8084FBC452C
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 12:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FACB4E213D
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE862242D69;
	Wed,  8 Oct 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HK/MLfCI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8F22370A
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919490; cv=none; b=LWBh3myT1jA4y3msE19cSAU3qvWn+e8G2eI1MkHkDUxgXvTjsGnFdXdmBkJjqAdMzY9LyF358x1VN/50jwGO+/e6rJmoVbqcW55OKkd5WRfr+1Vq7lc9tyZmfk0uX8v+vt+NIbEoWf9AKNBxwPIRNZUSCn6RK6yTUd3u4e3hCfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919490; c=relaxed/simple;
	bh=L8s98Pp+Npa8RTT/IAdqGHuMIi9QoaXe5bkMmNP7FE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=taX7iHvDvJa80uJTDaevlTcjJWBPt+5IjvcvU6l8j6L3Gfm3tCKcCJdj5S0JUjTfDP3hnIPhagiUaZ6X2eI23m+UH0euNTGRLTXTs5sxWy46btBJEtW79/5uGTrlX88sPomNsbteo0i0aqFKNTJtLMtqxGF6j9PpCb7rc2c/81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HK/MLfCI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759919489; x=1791455489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L8s98Pp+Npa8RTT/IAdqGHuMIi9QoaXe5bkMmNP7FE0=;
  b=HK/MLfCIUMpOp9JnwA/T4QIcedjiUbgMli6SFRPwX/YtXac8eA+HoHIh
   IZnVoo9rjO5NAtxfq6wpyBzXRUR/V9AjI3BI/xqFC8jyPBnJxkPKSyMGH
   bcqWv0clyPzFkjHAhJ2C6eKOvqbXmb5cB3Kd5xC5Q8wFYKXGMifelSMtt
   xyoIqwR95kEW59KT2bCS5+u6x5WFgKsSXX/HH8N3Yre5ul5qKWnlrq6ce
   yqXWiFemANrOX+LmXREqfdV3SRT2DWyQtGteFP4v8paB21Q99oUHdZCgj
   iHmWm01mK/Bz+s75DIX759Euo2JBXVMCuds8vCn+Kh3GOHBt3L2aCGelq
   Q==;
X-CSE-ConnectionGUID: Z/X9UniIQPOTg23V0VPIHw==
X-CSE-MsgGUID: 2P4WHS3aRH21iSRpn+Ukag==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="61314900"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="61314900"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 03:30:57 -0700
X-CSE-ConnectionGUID: r3EuW9CJS5OKctu8XH4RLQ==
X-CSE-MsgGUID: tYTE/BKiTB2+U5f4lQCSNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="180231287"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa007.jf.intel.com with ESMTP; 08 Oct 2025 03:30:51 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ice: fix usage of logical PF id
Date: Wed,  8 Oct 2025 12:28:53 +0200
Message-Id: <20251008102853.1058695-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some devices, the function numbers used are non-contiguous. For
example, here is such configuration for E825 device:

root@/home/root# lspci -v | grep Eth
0a:00.0 Ethernet controller: Intel Corporation Ethernet Connection
E825-C for backplane (rev 04)
0a:00.1 Ethernet controller: Intel Corporation Ethernet Connection
E825-C for backplane (rev 04)
0a:00.4 Ethernet controller: Intel Corporation Ethernet Connection
E825-C 10GbE (rev 04)
0a:00.5 Ethernet controller: Intel Corporation Ethernet Connection
E825-C 10GbE (rev 04)

When distributing RSS and FDIR masks, which are global resources across
the active devices, it is required to have a contiguous PF id, which can
be described as a logical PF id. In the case above, function 0 would
have a logical PF id of 0, function 1 would have a logical PF id
of 1, and functions 4 and 5 would have a logical PF ids 2 and 3
respectively.
Using logical PF id can properly describe which slice of resources can
be used by a particular PF.

The 'function id' to 'logical id' mapping has been introduced with the
commit 015307754a19 ("ice: Support VF queue rate limit and quanta size
configuration"). However, the usage of 'logical_pf_id' field was
unintentionally skipped for profile mask configuration.
Fix it by using 'logical_pf_id' instead of 'pf_id' value when configuring
masks.

Without that patch, wrong indexes, i.e. out of range for given PF, can
be used while configuring resources masks, which might lead to memory
corruption and undefined driver behavior.
The call trace below is one of the examples of such error:

[  +0.000008] WARNING: CPU: 39 PID: 3830 at drivers/base/devres.c:1095
devm_kfree+0x70/0xa0
[  +0.000002] RIP: 0010:devm_kfree+0x70/0xa0
[  +0.000001] Call Trace:
[  +0.000002]  <TASK>
[  +0.000002]  ice_free_hw_tbls+0x183/0x710 [ice]
[  +0.000106]  ice_deinit_hw+0x67/0x90 [ice]
[  +0.000091]  ice_deinit+0x20d/0x2f0 [ice]
[  +0.000076]  ice_remove+0x1fa/0x6a0 [ice]
[  +0.000075]  pci_device_remove+0xa7/0x1d0
[  +0.000010]  device_release_driver_internal+0x365/0x530
[  +0.000006]  driver_detach+0xbb/0x170
[  +0.000003]  bus_remove_driver+0x117/0x290
[  +0.000007]  pci_unregister_driver+0x26/0x250

Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
Suggested-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index 363ae79a3620..013c93b6605e 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -1479,7 +1479,7 @@ static void ice_init_prof_masks(struct ice_hw *hw, enum ice_block blk)
 	per_pf = ICE_PROF_MASK_COUNT / hw->dev_caps.num_funcs;
 
 	hw->blk[blk].masks.count = per_pf;
-	hw->blk[blk].masks.first = hw->pf_id * per_pf;
+	hw->blk[blk].masks.first = hw->logical_pf_id * per_pf;
 
 	memset(hw->blk[blk].masks.masks, 0, sizeof(hw->blk[blk].masks.masks));
 

base-commit: 8b223715f39c8a944abff2831c47d5509fdb6e57
-- 
2.39.3


