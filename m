Return-Path: <netdev+bounces-94679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0648C02F7
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 19:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C6B7B23847
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DA514A8C;
	Wed,  8 May 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3IlG543"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEF95336D
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188765; cv=none; b=NDUKPKtqmnu0behXyQ7TirDKz1ZhYGYFGJJM9eiRzlQLslX2RxRieiHENUhCDuEPS4+5mLfcPJi3xvpfMhPDupfyHiSDmGraOPHlvfObGjFnTeDM+Lzu3mR97awH9phvxGba5sFrnWWa3fdHe6uPgsUySExM/x05kV/oRgJ8Azs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188765; c=relaxed/simple;
	bh=v8mAdiEqfJ5Kp6LjiloxDwjDmAldWCrzcKQosgcfbXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/a56i4hCtvIzNIKWPCMcydUg7GJfgN+Ga5uNpW6eG27s2UYN4JUv5JpZz11R5Wv53NvOU7+5XWREcMLKAZRW+u43jL4De835QrOkrdCmtK1HBlO7EP7XntLFkRDr0dJ+iHYZRAcEDUYfb4PZU9mR6P7rCJy0FGYj30+/PD+UUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3IlG543; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715188764; x=1746724764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v8mAdiEqfJ5Kp6LjiloxDwjDmAldWCrzcKQosgcfbXw=;
  b=R3IlG543sSrbHcVD4TAfGLUy6NCgF6QJmB4Mz58aFjqPwECRFCZZhFzY
   PFOyPHefosYd1CIU8SQzeQ5rL7fS+Pwwu4Jw1aFsA6qzO6Hs5xVWgAdzp
   FbERi+sDbEKRd5bVpSk1NYpTGkjezAxaaVuJfFGo9QK3REYlVeZWUiOTe
   6gFCGkEXNFHYegGgfzMPGYxz1/FXpWcfsLoaf5u61nns2gacuh3szqKeG
   eGuGpRo8YHWuJbmWBsLED+t2GxqeQT+lIAp/tZZkQhLK6y/OO62sqA/8D
   L0n+3xeEUMY0XgepwTNTqyUChNjhkOKgLc+4rLmZqaSEbxE9yaY22TOJp
   A==;
X-CSE-ConnectionGUID: zcDsBCKnTi24jasLACVaZw==
X-CSE-MsgGUID: lcMOxQcqRmCWwysDe+D3fQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11228213"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="11228213"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 10:19:18 -0700
X-CSE-ConnectionGUID: QQ18emiMSG+XrV7Gu0O2yA==
X-CSE-MsgGUID: 126z05s1THSbvpn8bfZ/Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="59823692"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 08 May 2024 10:19:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dan Nowlin <dan.nowlin@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net] ice: Fix package download algorithm
Date: Wed,  8 May 2024 10:19:07 -0700
Message-ID: <20240508171908.2760776-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Nowlin <dan.nowlin@intel.com>

Previously, the driver assumed that all signature segments would contain
one or more buffers to download. In the future, there will be signature
segments that will contain no buffers to download.

Correct download flow to allow for signature segments that have zero
download buffers and skip the download in this case.

Fixes: 3cbdb0343022 ("ice: Add support for E830 DDP package segment")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index fc91c4d41186..4df561d64bc3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1424,14 +1424,14 @@ ice_dwnld_sign_and_cfg_segs(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
 		goto exit;
 	}
 
-	conf_idx = le32_to_cpu(seg->signed_seg_idx);
-	start = le32_to_cpu(seg->signed_buf_start);
 	count = le32_to_cpu(seg->signed_buf_count);
-
 	state = ice_download_pkg_sig_seg(hw, seg);
-	if (state)
+	if (state || !count)
 		goto exit;
 
+	conf_idx = le32_to_cpu(seg->signed_seg_idx);
+	start = le32_to_cpu(seg->signed_buf_start);
+
 	state = ice_download_pkg_config_seg(hw, pkg_hdr, conf_idx, start,
 					    count);
 
-- 
2.41.0


