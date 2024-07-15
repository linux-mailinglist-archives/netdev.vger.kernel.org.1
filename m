Return-Path: <netdev+bounces-111535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736A39317C9
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183C91F22844
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB218F2CA;
	Mon, 15 Jul 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="St2rTv6c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5218F2FD
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058043; cv=none; b=Rvypkv+k2HKeS17/6jxlzhnW2cDGcnxUt42beouDaq9rHly2gysnfJnGo28k60HsfubvTJHYwE2TXA3MiVN/7qwVPw1S3uznuFY/Yd2V8cHk8IlBC0iVe0ki4YNBq6voRvlY4djbzBmedTAgy3pwoBAap5KPnhWIdiS25zlcsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058043; c=relaxed/simple;
	bh=Xcby91CvHtdQucL3Gqpiq/obaC+y2zTJJ2JE4tqdZ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVONC3sawjCQIeJ7lugCvXK+VVlbqZlPoahWNPC7j0VLKqfcwiKGAWjhEMFkCFO5HH39W8s0uLzmGw2SkxIJKiuEj/FVo93tUoexV9tRnRm0ol2EAWcRed8ofYsW3uHHFiCEkl3HA+j+yiVelQ5qePLcYxj/1lfoGC9SSOQeg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=St2rTv6c; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721058041; x=1752594041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xcby91CvHtdQucL3Gqpiq/obaC+y2zTJJ2JE4tqdZ6o=;
  b=St2rTv6c2JLLorAMKCpoiYWT+pb17xpAg/kmi3hxg8bBFTUP6GL5v4LL
   f7bxC05kQMGoWJ/g8qE+VrHsW8GZ43mobMeRzy+KTajIaBUWxtd9fC9Hr
   +KLWwPyC8Nl8kI6Yi9Yw1jj7SBVNE26CSek0xQjwkudppc+qf2u+XxeyR
   E4d2dPgX5c3eQPCxN1XRdlxzJg6lR2qZ9HolB4rS86l7P5NUcrCjFYYvh
   tTApY5eA4m5skdlmg9VMjTu3dxo+ReaRJsGXXy6QkX3DPCMe4oU1cpnwY
   O8nRKZxvdGPx+zF36uuQt6ThjB1h/0EZGbTiZm2LqxGzqVXB8qJ4JR9ni
   A==;
X-CSE-ConnectionGUID: lWSaYqaRTpm6BX3Pp7qNdQ==
X-CSE-MsgGUID: 4iAq+5wMQy2BzIkV8jFrsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="35987676"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35987676"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 08:40:41 -0700
X-CSE-ConnectionGUID: OceyW97EQq20oDSYpXRCfg==
X-CSE-MsgGUID: 8/FfvozaQGOhwrjpT9ciqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49408483"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa006.fm.intel.com with ESMTP; 15 Jul 2024 08:40:40 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2 1/2] ice: Fix reset handler
Date: Mon, 15 Jul 2024 17:39:10 +0200
Message-ID: <20240715153911.53208-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715153911.53208-1-sergey.temerkhanov@intel.com>
References: <20240715153911.53208-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Synchronize OICR IRQ when preparing for reset to avoid potential
race conditions between the reset procedure and OICR

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Fixes: 4aad5335969f ("ice: add individual interrupt allocation")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2990993b16f..3405fe749b25 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -560,6 +560,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (test_bit(ICE_PREPARED_FOR_RESET, pf->state))
 		return;
 
+	synchronize_irq(pf->oicr_irq.virq);
+
 	ice_unplug_aux_dev(pf);
 
 	/* Notify VFs of impending reset */
-- 
2.43.0


