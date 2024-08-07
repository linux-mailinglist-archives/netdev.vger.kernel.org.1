Return-Path: <netdev+bounces-116281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FCE949D0E
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 02:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FFA6B212C7
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B78FB674;
	Wed,  7 Aug 2024 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJGXCJVM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD31DDEB
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 00:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991015; cv=none; b=rU6ZRv701iBbb2eegh59GkfwHlwA1qkC4kL5Zq/k/ExrO6KPeEseEoiH5GAkkhdP6Zp58Jerv7VFJN4+zRcCMOMRAsBMYogugG6j+HwWx4K0udibhJTWx10u9/jHPAKE+GvHCfmX2hyUp3R0i3d2lQ0pwEwbTjMLsnzuYmtyZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991015; c=relaxed/simple;
	bh=8IGk7nHl0AUnnVWG/KooB+heOx9cbDf+RxJNRQCnw/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/SEwduSmlJ6DDKLY42Zk/ptNJZA75FCDHqqYoBE5OvOqnrmGn67lEibORuJH0XyDSyryBmJwolAtOrGKs5u9DMtwoHNZaWpD13f8XtRNRwgtWjjA5K/en+hHKucCEcZoAJycqp6vhmGSYpxk7daZzfx7jSMIg7zo/twA0+FtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJGXCJVM; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722991014; x=1754527014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8IGk7nHl0AUnnVWG/KooB+heOx9cbDf+RxJNRQCnw/Y=;
  b=oJGXCJVMRv9VypdWNHYjbTvNooauPPCMp185pAewnPkLLTQzDWc4CNir
   UxUTjq1BNRZN/e127EP7lwTiESrTtqWpRlXzPwpAF/XUDKoQsA52EH3hP
   H0VDDTwYlxnab8wrUQ2I6Z+QV4z4qPyOOSdRXvWqpxlVWp7GRUMb4Lfju
   EqhJmWT0myFBk78QQJj60BMUHQHhoQdGiaX8fVNZcoZHOaeg6c7vTJS4T
   gAJAnHux9vikYX77APBKQ9nHcg7i8W8m3sF89ZH1fwQabqkkBtOBtvCFV
   wCGzZRx9TtCdhx8Hlf2kTBQRlYg26Be25p0Lj+c70FJK3/e1d7eTP0XqB
   w==;
X-CSE-ConnectionGUID: WBy3jxJnQf+o+foSEyzP+g==
X-CSE-MsgGUID: U/+sDLRCQ06xQ4Cg9waAdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31669749"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="31669749"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 17:36:54 -0700
X-CSE-ConnectionGUID: ufmNvA3cQD+TL9MvJz8adw==
X-CSE-MsgGUID: 2tU1vrmWRxydCuKp3Ln+4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61497010"
Received: from timelab-spr09.ch.intel.com (HELO timelab-spr09.sc.intel.com) ([143.182.136.138])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 17:36:52 -0700
From: christopher.s.hall@intel.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com,
	Christopher S M Hall <christopher.s.hall@intel.com>
Subject: [PATCH iwl-net v1 2/5] igc: Lengthen the hardware retry time to prevent timeouts
Date: Tue,  6 Aug 2024 17:30:29 -0700
Message-Id: <20240807003032.10300-3-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807003032.10300-1-christopher.s.hall@intel.com>
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
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
index ec191d26c650..253327c23903 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -564,7 +564,7 @@
 #define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x3f) << 2)
 #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
 
-#define IGC_PTM_SHORT_CYC_DEFAULT	1   /* Default short cycle interval */
+#define IGC_PTM_SHORT_CYC_DEFAULT	4   /* Default short cycle interval */
 #define IGC_PTM_CYC_TIME_DEFAULT	5   /* Default PTM cycle time */
 #define IGC_PTM_TIMEOUT_DEFAULT		255 /* Default timeout for PTM errors */
 
-- 
2.34.1


