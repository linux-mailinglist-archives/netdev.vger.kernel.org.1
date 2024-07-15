Return-Path: <netdev+bounces-111462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4A931299
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 12:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540761C22A4E
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00249188CC3;
	Mon, 15 Jul 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwcEswmd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2DB188CB8
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040623; cv=none; b=g6CNu9hoqcL2weMgNHgy0Wklh1xo1RFZQAAYGj4EFvDrUAxgaewEYuNICCijzpx/DwphsZFHyAYQGfJKfVPhBgXFMPzsrpZn5CKFCbzCm60YGvkQxFbet8bzejRBsOxN8POWxBRH41e6rs4n+5V1IDGzZS1WlHQW20BhhLQ8Wio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040623; c=relaxed/simple;
	bh=Xcby91CvHtdQucL3Gqpiq/obaC+y2zTJJ2JE4tqdZ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABlz6S8Xsy1t+F9UHKojcZiP8oFRz8TOaoC9sBnimNvBn80+awhDiovJDSp3Abl9c3aCK83EWzSoaLhdFFqKU3QM/LITm4CKuXd5pB+79kORb2Q2W8V363yjTxdxIXhtiCnvwbHz8kg1ye6Y2AeGgzVASqMgcvbmylVSm5TRzCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwcEswmd; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721040623; x=1752576623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xcby91CvHtdQucL3Gqpiq/obaC+y2zTJJ2JE4tqdZ6o=;
  b=KwcEswmdsBx+3ILdVax1IUFd6Tnt3HZXzGHk1iMnlJUvoCZXa5fSdHJW
   KgaGw2YAQHXglY7rBP2xCZsG/0QZxBwulb/Gnyos8mrV4GL7Rk8lSmvxd
   QMrtO8Rc+8vJWCnT8EgGhjKTA5esSlTa5/RIdQlOL3vSwhvf6OHFH4Bg5
   Ro3ct0Yayl7IL4r/tFB+WLoBw+JgxYTR4Lk/G6q6I8K00GMKc/2WhakcC
   LI5zqIkGvV1a2BcThTzSJdaaPAnex99NbHj48Ssxx9/eJpPlPhmOTTy9H
   qJWFL2uHNYW1DXg3Tsj90+OJpAgc4thN2J9PTiGelLZyOfrHg2bqHDAWd
   Q==;
X-CSE-ConnectionGUID: WU1msNvOSn2nQlmK5ZILlQ==
X-CSE-MsgGUID: NChDFK4fRzybla7lASOzSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18609010"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="18609010"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 03:50:20 -0700
X-CSE-ConnectionGUID: 2t9QlrDnQDquXCaCLEbrVg==
X-CSE-MsgGUID: r6XHH3dJT/m22GOXVyrZ5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49545153"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by fmviesa009.fm.intel.com with ESMTP; 15 Jul 2024 03:50:19 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v1 1/2] ice: Fix reset handler
Date: Mon, 15 Jul 2024 12:48:44 +0200
Message-ID: <20240715104845.51419-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715104845.51419-1-sergey.temerkhanov@intel.com>
References: <20240715104845.51419-1-sergey.temerkhanov@intel.com>
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


