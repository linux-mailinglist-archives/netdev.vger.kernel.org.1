Return-Path: <netdev+bounces-108060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB191DB1E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13D511C2182D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 09:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A7513F439;
	Mon,  1 Jul 2024 09:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFPTWS0I"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C180A13AD04
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824906; cv=none; b=QBy3xCq5NpAiINsBGC5vNxbrMaX6VVLu7E52C5C2rO0TtPJvLJyuP0xfFSNP18cUemdmoU6ClvmhP9V2ON309IkwjjVvTVEWXIUk7n2t269DP9+1DCpNMOpWS6s/KyDxrX2iWqpQx5zepowo9M+35lW9U7QoA+bdexvJhNu2rUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824906; c=relaxed/simple;
	bh=YzoctkienM/RHSl/MxnQWSeBZnA19kNmBR99veARymE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W5CoNvVPnIcmCXTRoLrGIy0ssKGsBpXp2LpMH0PfJhOGSQlPH8inez30mnlKg1zospsTbXgrl7g71ZWaYHVsqVAXWgf8oT2jnXSJrZt2ba0hTBTLb2xK+xMblASF/xa+NUdN3dV+ahcOzO+0D9fxG8+pg7wJtRecChI8FNEkUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFPTWS0I; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719824903; x=1751360903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YzoctkienM/RHSl/MxnQWSeBZnA19kNmBR99veARymE=;
  b=CFPTWS0IlB++TgNzxvQQFo330LIewhOXx6K5JwS1FpZiagPO+oDVOFpJ
   WO168w4TRcDt2+l1FYPdIo89F+sOOB5cN4wdp03A9MPzTgNg0ift8zBMW
   K3i7SLPFHt2fjfeCCdClxDA35+IX7KIcFN9DhoIYo/hdOZlQE57k+v8q1
   TeSFIK0W6ZFI/Ijg3wsBcjRC28M3PygQNIjtqUs6hJTIR6NjhVmz1gkpj
   2wvPRpaNVBm5hTYEqC8TWPziVsQ9dGkhnIQebltUgRf0Ys0rsSwT69qJA
   LHl4cULaLd6sZbujmTCJA2SPSfBh4grOPZCCSPNlclXW7ERFn6qPXNB97
   g==;
X-CSE-ConnectionGUID: EPH9x1FgSWewJmiSMnyu8w==
X-CSE-MsgGUID: SobOE17gR6q4lq4HO5nyew==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="27619851"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="27619851"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 02:08:13 -0700
X-CSE-ConnectionGUID: a+j0va57ThSCMnb84GNGxg==
X-CSE-MsgGUID: JgXYfGS6SCuOGaCyI9jnTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="45281920"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa006.fm.intel.com with ESMTP; 01 Jul 2024 02:08:11 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 512E4125BB;
	Mon,  1 Jul 2024 10:08:10 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: przemyslaw.kitszel@intel.com,
	marcin.szycik@linux.intel.com,
	netdev@vger.kernel.org
Subject: [PATCH iwl-net] ice: Fix recipe read procedure
Date: Mon,  1 Jul 2024 11:05:46 +0200
Message-Id: <20240701090546.31243-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ice driver reads recipes from firmware information about
need_pass_l2 and allow_pass_l2 flags is not stored correctly.
Those flags are stored as one bit each in ice_sw_recipe structure.
Because of that, the result of checking a flag has to be casted to bool.
Note that the need_pass_l2 flag currently works correctly, because
it's stored in the first bit.

Fixes: bccd9bce29e0 ("ice: Add guard rule when creating FDB in switchdev")
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 1191031b2a43..ffd6c42bda1e 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -2413,10 +2413,10 @@ ice_get_recp_frm_fw(struct ice_hw *hw, struct ice_sw_recipe *recps, u8 rid,
 		/* Propagate some data to the recipe database */
 		recps[idx].is_root = !!is_root;
 		recps[idx].priority = root_bufs.content.act_ctrl_fwd_priority;
-		recps[idx].need_pass_l2 = root_bufs.content.act_ctrl &
-					  ICE_AQ_RECIPE_ACT_NEED_PASS_L2;
-		recps[idx].allow_pass_l2 = root_bufs.content.act_ctrl &
-					   ICE_AQ_RECIPE_ACT_ALLOW_PASS_L2;
+		recps[idx].need_pass_l2 = !!(root_bufs.content.act_ctrl &
+					     ICE_AQ_RECIPE_ACT_NEED_PASS_L2);
+		recps[idx].allow_pass_l2 = !!(root_bufs.content.act_ctrl &
+					      ICE_AQ_RECIPE_ACT_ALLOW_PASS_L2);
 		bitmap_zero(recps[idx].res_idxs, ICE_MAX_FV_WORDS);
 		if (root_bufs.content.result_indx & ICE_AQ_RECIPE_RESULT_EN) {
 			recps[idx].chain_idx = root_bufs.content.result_indx &
-- 
2.40.1


