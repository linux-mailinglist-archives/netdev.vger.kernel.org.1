Return-Path: <netdev+bounces-190718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7DCAB866C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF981B613D2
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF582989BD;
	Thu, 15 May 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T20X5/L2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C04205AA8
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312419; cv=none; b=Kj57L33mT52r2IgbznX+p03UOthFpsv+Toq2F9cLa65Usmf9Eq4lPBtecDmsQcDZCpBxUZVctP7lGGE7eafBP2BbdtBh5CEeiWHcraw5JvPeXlbKQFLOVZMTLNAcpRkPeIPsehPqVg3ngmkEVcTlNRPlxyz627DdnOlAsWlqYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312419; c=relaxed/simple;
	bh=d8ge57CmNBGpOr47ySBYCPdt/LmqgPo3Abd1sYrRyc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m+kgNh4lcPwZLp8MPuRE3UG8cfKQcVd305ZojIRTVBzrEyGXEw2nurrIA7S/TRjn1cXEtVGC0RuEXJfTW9cGRcPrKljdWGi00be4ZbuAVOZFIoAYNayPDl8hARujPhIgzEZ0ZuA3D/Lk17zfvD1Sh+mUbEoarm33KKCPmIA1jgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T20X5/L2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747312418; x=1778848418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d8ge57CmNBGpOr47ySBYCPdt/LmqgPo3Abd1sYrRyc4=;
  b=T20X5/L23H9JIYI/kOYayAwGjfhTUvSt5n2haJISqp4zSv76Lpg3wjlb
   0/VcznIpdcv7hRL7N9Y4/Wb/67phwuKO+MCQuwdzwaE3M/af8VxEzC4B4
   QwbKLPyBmM9Ku2WBhb1BXpzkGMIviac9V6FiPtfKD0z6YFUHzP1Vrwljj
   L+NM7oYYtuEjF/dwRu1137XyhpY+Cap/PtzcX4Eo0+K9CHsOgzG3HNzsr
   li4mgcp+4gMPbdhhwoT7oQ8FVI891Wh/W3hAvbQ5DTas8oX/3frFTrba1
   BVdL1z8G3uvld4koJF7OgPUOTiL4hFUUbo8qqq7JrPP7QwfcO8QwkGOHY
   w==;
X-CSE-ConnectionGUID: FkyX1aYrQzufOtr71yQ4vQ==
X-CSE-MsgGUID: 206LNPmHT9WjKZaHevvsQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="74646887"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="74646887"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 05:33:37 -0700
X-CSE-ConnectionGUID: czHv+sB6SY61qvbGgeYHYQ==
X-CSE-MsgGUID: hDCdknInQrKlBNvDORWoeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="143309978"
Received: from admindev-x299-aorus-gaming-3-pro.igk.intel.com ([10.91.3.52])
  by orviesa004.jf.intel.com with ESMTP; 15 May 2025 05:33:35 -0700
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Anton Nadezhdin <anton.nadezhdin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net v3] ice/ptp: fix crosstimestamp reporting
Date: Thu, 15 May 2025 14:32:36 +0200
Message-Id: <20250515123236.232338-1-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Set use_nsecs=true as timestamp is reported in ns. Lack of this result
in smaller timestamp error window which cause error during phc2sys
execution on E825 NICs:
phc2sys[1768.256]: ioctl PTP_SYS_OFFSET_PRECISE: Invalid argument

Before commit "Provide infrastructure for converting to/from a base clock"
the parameter use_nsec was not required. "Remove convert_art_to_tsc()"
rework shall already contain use_nsecs=true.

Testing hints (ethX is PF netdev):
phc2sys -s ethX -c CLOCK_REALTIME  -O 37 -m
phc2sys[1769.256]: CLOCK_REALTIME phc offset -5 s0 freq      -0 delay    0

Fixes: d4bea547ebb57 ("ice/ptp: Remove convert_art_to_tsc()")
Fixes" 6b2e29977518e ("timekeeping: Provide infrastructure for converting to/from a base clock")
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 1fd1ae03eb90..11ed48a62b53 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2307,6 +2307,7 @@ static int ice_capture_crosststamp(ktime_t *device,
 	ts = ((u64)ts_hi << 32) | ts_lo;
 	system->cycles = ts;
 	system->cs_id = CSID_X86_ART;
+	system->use_nsecs = true;
 
 	/* Read Device source clock time */
 	ts_lo = rd32(hw, cfg->dev_time_l[tmr_idx]);

base-commit: 7e5af365e38059ed585917623c1ba3a6c04a8c10
-- 
2.34.1


