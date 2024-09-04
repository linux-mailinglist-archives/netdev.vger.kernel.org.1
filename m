Return-Path: <netdev+bounces-125054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D996BC6A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35EBDB23BB3
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6231D934F;
	Wed,  4 Sep 2024 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6EkYrpf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDF1D9342
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453198; cv=none; b=hsAxJP5ZqQFFfNIxdIfJGUsQq+dXxy++cGNYMVn4y8infI1p2sTZTMAGxKvJ4Y6YcOnABRtO/q8GmVrhwK52IuhGjkr6yHVVKClBZVs6WlNN0g7QhJ/bzQ6juJIcbEzbrosact0XVGqmvsxuTHYrGDG6EBi82lSXvyvWzMS0Caw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453198; c=relaxed/simple;
	bh=3zZVN5QEEQ0tht7sMIhSJX3o61lUp/lS8M8cFNU4AzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCxkBLgppZhm7OaqzBuVztt3F88rPbFUvVNApE7PM8G26oU0EM/F4e4sYj5XIHRm1bpMFrfWjNWcb7ducBces23EVpX5KOWVIAZy0zlupAEV2qkL50b6+x+wgODeHZ/5K5iP32P9zM4YeJ3G+fzpnhvXwSv6ZOQeOZUJivuonis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6EkYrpf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725453197; x=1756989197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3zZVN5QEEQ0tht7sMIhSJX3o61lUp/lS8M8cFNU4AzE=;
  b=R6EkYrpfzIK1qXXQ6rvqlujMqLy4TAwFAONoj9Yg7/R9VZe3QnRyzG18
   pzhLRQkJUO5LtMXBvsokhLXAmMP0z1g18BRFdOUx3Q6hZLaT5nxaQq519
   933u0oa9iaY63w48YDq6KqbhOkk/OzeJWFKbw2WroVi4oj3ZL7qgiY15B
   aCmStDPVoVz9/TpxOqYMxT27P3fopOV8ZEoAxLcgYdS8SUl2nsQIy5xF5
   5bT3ok9n78OND7jgh8F+3nyBHn4SEyfDIiMCEDaUYg7fYcEBSwI/NLQs3
   eecoD1Obka9OSTxprI4LeOMJwmv1IJ8EOTAUEka71GjKOf5WE+f7c6LtR
   A==;
X-CSE-ConnectionGUID: AgRp0p2LQGGMglbDibc/8Q==
X-CSE-MsgGUID: fKX8CelrTEOPPMmiE14dGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="27029725"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="27029725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:33:16 -0700
X-CSE-ConnectionGUID: YZFOA4XuRK6wcWLR7GVbrQ==
X-CSE-MsgGUID: 0eEjeUZfTVSh1T0Gvk+W7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="102665900"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 04 Sep 2024 05:33:14 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.246.22])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 04A9528167;
	Wed,  4 Sep 2024 13:33:12 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH iwl-net] ice: fix memleak in ice_init_tx_topology()
Date: Wed,  4 Sep 2024 14:32:57 +0200
Message-ID: <20240904123306.14629-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix leak of the FW blob, by not copying it.
ice_cfg_tx_topo() is not changing the passed buffer, but constification
of it is not a -net material, constification patch is mentioned by Link.

This was found by kmemleak, with the following trace for each PF:
    [<ffffffff8761044d>] kmemdup_noprof+0x1d/0x50
    [<ffffffffc0a0a480>] ice_init_ddp_config+0x100/0x220 [ice]
    [<ffffffffc0a0da7f>] ice_init_dev+0x6f/0x200 [ice]
    [<ffffffffc0a0dc49>] ice_init+0x29/0x560 [ice]
    [<ffffffffc0a10c1d>] ice_probe+0x21d/0x310 [ice]

Link: https://lore.kernel.org/intel-wired-lan/20240904093135.8795-2-przemyslaw.kitszel@intel.com
Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6f97ed471fe9..71f592dda156 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4535,16 +4535,10 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
 	u8 num_tx_sched_layers = hw->num_tx_sched_layers;
 	struct ice_pf *pf = hw->back;
 	struct device *dev;
-	u8 *buf_copy;
 	int err;
 
 	dev = ice_pf_to_dev(pf);
-	/* ice_cfg_tx_topo buf argument is not a constant,
-	 * so we have to make a copy
-	 */
-	buf_copy = kmemdup(firmware->data, firmware->size, GFP_KERNEL);
-
-	err = ice_cfg_tx_topo(hw, buf_copy, firmware->size);
+	err = ice_cfg_tx_topo(hw, (void *)firmware->data, firmware->size);
 	if (!err) {
 		if (hw->num_tx_sched_layers > num_tx_sched_layers)
 			dev_info(dev, "Tx scheduling layers switching feature disabled\n");

base-commit: 4186c8d9e6af57bab0687b299df10ebd47534a0a
-- 
2.46.0


