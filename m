Return-Path: <netdev+bounces-142502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC229BF5DA
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C951B216FF
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58720969D;
	Wed,  6 Nov 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKowUAei"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95893209669
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919536; cv=none; b=rkznq/g5muIMkUem316fXYyCkyoWDt6WnBgNetooncSiK5/GxhZYq/TbxnLXqawM9CUggWHVdara1/mLZ0sQjDgOgm322cFpp7o61Nc9VzvS469gEl+sc5xxYW+lD1rascWz9qph8R1aW4aWwNNMSd0b8tA9ZF5cicjtMdcqar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919536; c=relaxed/simple;
	bh=KM5P8kj4DwnOVzFxShC+OcUuG3ZeqIvS6h/aX2Ptt6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBPjppfbv4/pty1mmJemVqPQogxzoVw04Ibmndh76Ze4ZnFIlA0IasEKBw4+mt8ymkcNX6njzu69QdgGue4Jo2zqsOVHQB6HtPjHupesOybicAkWSdE2b2nskuggnDOJ63eLrOgSVZKND3SRlTK3eQ0wWluZ0NuZaguMWyz+eEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nKowUAei; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730919535; x=1762455535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KM5P8kj4DwnOVzFxShC+OcUuG3ZeqIvS6h/aX2Ptt6A=;
  b=nKowUAeiQ9C4Ag72QxLR/jgn7F4IcwpXq2qgYlEq0+leKM9hjSum+Vhw
   tezIWGgzft89Skmd2NiljW1MRnBTM0kkqx7adTTK/pP6xXXd1Jev020jy
   s8c5OEFcYJ+y4LktqpKJM8RuCTNX/JhzLwd4MqR7LkLPzTGOYtCAMdUAk
   1N6rXL5WleuunP4lg42YXb5MlYZd4uJlUKfRKpyqWPSfCnibk1D85vVJU
   mhGFYLfbEki2lrOXoS2lID6OOy0gRdIWrnMJSTb3tOg1AoGUqyZq8Ii1M
   7cxSBVGxR60WhQoP7d/+g9JH9uTj1BjKW5GCUf3jrYrQG56xOLPPhdpsL
   g==;
X-CSE-ConnectionGUID: PWFFIqLcTjCfhVhn7wrgdQ==
X-CSE-MsgGUID: UstNmj6fQ/CiIi+Vyd5FiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30959479"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="30959479"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:58:52 -0800
X-CSE-ConnectionGUID: NcGtzS0ZRtqKpVJPyjXRZw==
X-CSE-MsgGUID: xwbyK6rVTWWRv2j2vxN6FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89813792"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
  by orviesa004.jf.intel.com with ESMTP; 06 Nov 2024 10:56:40 -0800
From: Christopher S M Hall <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	vinschen@redhat.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH iwl-net v3 2/6] igc: Lengthen the hardware retry time to prevent timeouts
Date: Wed,  6 Nov 2024 18:47:18 +0000
Message-Id: <20241106184722.17230-3-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106184722.17230-1-christopher.s.hall@intel.com>
References: <20241106184722.17230-1-christopher.s.hall@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 2ff292f5f63b..84521a4c35b4 100644
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


