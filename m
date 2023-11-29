Return-Path: <netdev+bounces-52227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6997FDEE9
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CF451C20B02
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2158AA5;
	Wed, 29 Nov 2023 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jtQC21zV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914A784
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 09:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701280574; x=1732816574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cfyFMyY66E8uYlmk8SQXuQsg3lTBZ8/i8g/y5BK0ZXE=;
  b=jtQC21zVjcPEVrhlqTxNl/WnupNBIZiw1wPIoTHa18/kUcG7asXOXSJA
   HzZFx/JdZLZr5KU6keFFqSF7XqiHihaqeSVXEqDeXwKeNOvTj055XWJ0Z
   ML3RnSunpVmRw/w40t6grk0pl7QV2ZA6M7OO64bluccrYIL163Y6Y5HaF
   Du9eFjLWY2sGEt32ajP+W2KKpllwq5ZwyR4kJ5aI05AXriQ87vF6x9lgX
   tjNWAjWf45BtAz2DmgX27ALH0Ay2gW7vOQp9PUfUw5MJrp0TF9n8KiRq9
   lqaDjmCxpNbMwQhjMbEhizSDogT/9tSto7euIj3d5TAtSYZD3oNyqlDI+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="479404728"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="479404728"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 09:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="797990593"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="797990593"
Received: from sbahadur1-bxdsw.sj.intel.com ([10.232.237.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 09:56:13 -0800
From: Sachin Bahadur <sachin.bahadur@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2] ice: Print NIC FW version during init
Date: Wed, 29 Nov 2023 09:56:04 -0800
Message-Id: <20231129175604.1374020-1-sachin.bahadur@intel.com>
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

Example log from dmesg:
ice 0000:ca:00.0: fw 6.2.9 api 1.7.9 nvm 3.32 0x8000d83e 1.3146.0

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Pawel Kaminski <pawel.kaminski@intel.com>
Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
---
v1->v2: Added example log message
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


