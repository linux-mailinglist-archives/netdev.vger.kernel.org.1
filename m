Return-Path: <netdev+bounces-138068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7753D9ABBAB
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A031F22236
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FE3762F7;
	Wed, 23 Oct 2024 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B352qviX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218F49659
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651197; cv=none; b=FLQQMN3Q13fU2s9fH7GsLK00OgAQcD2G0I99kh8P9yXTUl0AptjuoyGoJly3ruomeXuuJ7rYKH/sp1jmUisgUFwkmePbZc/IGtsAPddZ8jUMDoFpcy+8Cy9BIiGpgKGUMoxUqwZO+neT5I2ZOT81En49MOhK8dvwWyxUvHxoINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651197; c=relaxed/simple;
	bh=luSz0wR9ae3qc/NRPPLb5F51Oam8ok0QnTKVp56Q2/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OBB7sEsqjXMwiTywFHXOt2gMokAJNo72wWEknJKnDjFYdrHwQrHYt40MyOFUvFJrwKOLNkFXl8svokei0jQ1VuzKYt66k3j7qWybXYK21WXBkJr7vB/DcPImsVoafPHk2YGVSuhizV5d4VpCC719l+cNSxU8JliQOHbNEjo2bRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B352qviX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729651196; x=1761187196;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=luSz0wR9ae3qc/NRPPLb5F51Oam8ok0QnTKVp56Q2/k=;
  b=B352qviXojL9D9bI/4yjxA7X5WAC570l0HV+1iIwqnXmBp/xiSJGbaUl
   8Gri5IWFB6xg2eJ+mLHgGMJEx+C64kbi2mFmgQ4zqlenDO69Xwgeab3OR
   6cleU0wgn8wIY8g9LHsv3vq2/PvPzP14BKL8AnVIKdOwZ36/oxvpcgEEM
   rv5gspudxX7zaAFu0TwNuvNNaV4dTPGrZ1EpUwB33HULfxwyS4paRQiFo
   Vz+gorSJOCWFJyz1waFHWCCfumJpqc0aRSrYIXPkHfZC9pt96za86jbcq
   kuJVMxEWIVsoqymd7KIpBUmQe1NUmk7vOtXBXKdgfF/iqptuDqmYTnmbz
   A==;
X-CSE-ConnectionGUID: QfJnF3JyRrCoCIwNb/u3XA==
X-CSE-MsgGUID: dNUcxhnOSsiyJQSwRI/8qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32918038"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32918038"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 19:39:54 -0700
X-CSE-ConnectionGUID: 178n4kDHTlecO+Y+6Bf3MQ==
X-CSE-MsgGUID: ijpos2Q9RJiVY2cKDXSdoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80396825"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
  by fmviesa010.fm.intel.com with ESMTP; 22 Oct 2024 19:39:53 -0700
From: Chris H <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	vinschen@redhat.com,
	Christopher S M Hall <christopher.s.hall@intel.com>
Subject: [PATCH iwl-net v2 2/4] igc: Lengthen the hardware retry time to prevent timeouts
Date: Wed, 23 Oct 2024 02:30:38 +0000
Message-Id: <20241023023040.111429-3-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023023040.111429-1-christopher.s.hall@intel.com>
References: <20241023023040.111429-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christopher S M Hall <christopher.s.hall@intel.com>

Lengthen the hardware retry timer to four microseconds.

The i225/i226 hardware retries if it receives an inappropriate response
from the upstream device. If the device retries too quickly, the root
port does not respond.

The issue can be reproduced with the following:

$ sudo phc2sys -R 1000 -O 0 -i tsn0 -m

Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
quickly reproduce the issue.

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
  fails

Fixes: 6b8aa753a9f9 ("igc: Decrease PTM short interval from 10 us to 1 us")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index afd0512dc9f8..58bd9dbbdf43 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -574,7 +574,7 @@
 #define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x3f) << 2)
 #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
 
-#define IGC_PTM_SHORT_CYC_DEFAULT	1   /* Default short cycle interval */
+#define IGC_PTM_SHORT_CYC_DEFAULT	4   /* Default short cycle interval */
 #define IGC_PTM_CYC_TIME_DEFAULT	5   /* Default PTM cycle time */
 #define IGC_PTM_TIMEOUT_DEFAULT		255 /* Default timeout for PTM errors */
 
-- 
2.34.1


