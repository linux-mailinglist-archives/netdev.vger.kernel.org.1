Return-Path: <netdev+bounces-99002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A3A8D357B
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37DB1F23AEE
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2626C1802C5;
	Wed, 29 May 2024 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpCzmaga"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96914A4C3
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716981828; cv=none; b=BpA0vvFbeKiZZNxvDdshJYuFzwDHAJnO38x6VTbyxHqAe5YXt4fPMyR0w1tFOQw4o/qSvj/4b7MAOxLCYZ65uQnnJTDoKK8ImiDnZU1omjWoQPWzwPeoI84gPS1V8bCifZOY5qFfL0oGX7qQHQdeJJBe+/zYEkCdwAIf9BujKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716981828; c=relaxed/simple;
	bh=89ItfMvWVLYERCZU8akE0pKSpXDzCfiBwTBt6Ag8CQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nvdwg1r4t4L/ITelEuh5Qen9LfiEorgThsVInV8hvwhJnDAS0m8R2AJF6f4Gw56/kSqh4KmIFWyywu4sRCWUt+VlzJsEvaR9QPGuUYM+YR1MGmdYFVROyp+2xd69FmYdkhhqnHefO/zcb6Xopaz1tqHfLuppg+Quhfz7k/yL4Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpCzmaga; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716981826; x=1748517826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=89ItfMvWVLYERCZU8akE0pKSpXDzCfiBwTBt6Ag8CQc=;
  b=FpCzmaga4NOuJeXuZvhvpYH9xXo40vv+CmpRSHh66EsX2cCOxjFgJPM5
   VuYglu7ZDGgBVFI3o3j67/y2LFrsdxiaX29bT1TX11+0B55wtTx9+B1ro
   mEcoBh0mmvV6uA9CB3d1R+YpWfl1Q1WwGqJTNiyp1+3BVQ4enDv9nZ3ym
   YFiy7JcH7wONI+LgzBMt0S7AUb3fDmAihQXvpnHgsqrfFuVTFmlZr9rZB
   nxGk3taRfc9wbd4EW+ZCDSEzrh3QVLMRoiy5Pb/KnNwm3DIbowa3iI47R
   5hzZBpqbACJ7R7bzwp4Y9lpT2X1gI326OAkaJ+CWc8fokuR43H7X0dzWW
   g==;
X-CSE-ConnectionGUID: vyUQGc/yQ7CNv6AF2Bv/Tw==
X-CSE-MsgGUID: iIReIsPHSCiU7mkjeptphw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="17169231"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="17169231"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 04:23:46 -0700
X-CSE-ConnectionGUID: cZ3wnMpwRdSwAVNHP0BaAQ==
X-CSE-MsgGUID: aMza/qXhSkquNo3zewXxmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="66277173"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 29 May 2024 04:23:44 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v2 iwl-net 2/8] ice: don't busy wait for Rx queue disable in ice_qp_dis()
Date: Wed, 29 May 2024 13:23:31 +0200
Message-Id: <20240529112337.3639084-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
References: <20240529112337.3639084-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ice driver is spammed with multiple xdpsock instances and flow
control is enabled, there are cases when Rx queue gets stuck and unable
to reflect the disable state in QRX_CTRL register. Similar issue has
previously been addressed in commit 13a6233b033f ("ice: Add support to
enable/disable all Rx queues before waiting").

To workaround this, let us simply not wait for a disabled state as later
patch will make sure that regardless of the encountered error in the
process of disabling a queue pair, the Rx queue will be enabled.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 1bd4b054dd80..4f606a1055b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -199,10 +199,8 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
-	if (err)
-		return err;
 
+	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
-- 
2.34.1


