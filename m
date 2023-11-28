Return-Path: <netdev+bounces-51800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 135807FC361
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 19:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44E701C20B88
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870C930347;
	Tue, 28 Nov 2023 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nY1qftFv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13001A5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 10:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701196512; x=1732732512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3XrKzGgorsTXEq5Z259hGATFbw7UsEoW85mUltUx3Mc=;
  b=nY1qftFvhLYCF76JyXih1Ljh3PozvyB6a0eSy4Bdfxa9JdjwN4mFknLO
   Ah/HuKofMpabY7i7n4MFqc6O3tn/Et4nvlEMVtcvquJf5uH+scljZgcUx
   hK/IwyZ1L86Y8qvN8/v6w0BqVoKFr0fA+bRgG+qDast/J+dOA85ATpRGu
   U3vrT6q5Znj0+4w+snvyGll/T9QXTv63/FlyJ4Q0J3hU+lDCGm7qnMWIG
   1ejx/CPygUwYWHbGRfPTf19hYzG/9V0PZyUcTYkA9KGJ7w+U54dNHXyAS
   8n2prb7oeFT0fGaHA0786mb57Y3mXKgZ2J/fEfrnPuLfq1wJ4+bYyl5LO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="390142834"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="390142834"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:35:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="803027246"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="803027246"
Received: from sbahadur1-bxdsw.sj.intel.com ([10.232.237.139])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:35:12 -0800
From: Sachin Bahadur <sachin.bahadur@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v1] ice: Print NIC FW version during init
Date: Tue, 28 Nov 2023 10:35:05 -0800
Message-Id: <20231128183505.1338736-1-sachin.bahadur@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Print NIC FW version during PF initialization. FW version in dmesg is used
to identify and isolate issues. Particularly useful when dmesg is read
after reboot.

Reviewed-by: Pawel Kaminski <pawel.kaminski@intel.com>
Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1f159b4362ec..71d3d8cfdd1d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4568,6 +4568,12 @@ static int ice_init_dev(struct ice_pf *pf)
 		dev_err(dev, "ice_init_hw failed: %d\n", err);
 		return err;
 	}
+	dev_info(dev, "fw %u.%u.%u api %u.%u.%u nvm %u.%u 0x%08x %u.%u.%u\n",
+		 hw->fw_maj_ver, hw->fw_min_ver, hw->fw_patch, hw->api_maj_ver,
+		 hw->api_min_ver, hw->api_patch, hw->flash.nvm.major,
+		 hw->flash.nvm.minor, hw->flash.nvm.eetrack,
+		 hw->flash.orom.major, hw->flash.orom.build,
+		 hw->flash.orom.patch);
 
 	/* Some cards require longer initialization times
 	 * due to necessity of loading FW from an external source.
-- 
2.25.1


