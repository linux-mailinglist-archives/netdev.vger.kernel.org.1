Return-Path: <netdev+bounces-123220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BD5964319
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6741C20E14
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A3118E373;
	Thu, 29 Aug 2024 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXwKpATo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7313B18E04E
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931188; cv=none; b=ewQQc5cozbzP1rBs9CAiFLoE+Z5rtO/0uFsGpVea7FnxxtEY9DWrnTO9Ov68jd9ZAO0e3NQVdMS6EpwHe5NwD3thXKjUOpyXWNm39iZsquyfREetv/GPTq7pHQajoCNL1h+CSz1/sVbI7gWEfeZTL0xRibIOgARCZAHiUGSo4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931188; c=relaxed/simple;
	bh=W7Jm4YLWj2B1MXcE+VA0Tt/Hbb0N6rfbNNtePOFJV48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BFYGnBhxRrulshURy/ipBRVJh/A7L/6xYN2ZXNYPiV14imzDkTQbumY5nyvaQbCB7vQvERunikTolrAZIuvFUH/N2CMh1U8Tz6bWHMmPLCOUVrbQip+DrKRUM3cudMGEcwhciwmMl+Tk6D7r1iadVWkouWr/oVTYz6NsGPVsO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXwKpATo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724931186; x=1756467186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W7Jm4YLWj2B1MXcE+VA0Tt/Hbb0N6rfbNNtePOFJV48=;
  b=BXwKpATo+RcDIVwdcUEmAQH7/1bdbnJ6EMU86LlwRHUTwbyY90e08HQH
   prOyJIvs5MjVMoxOnRcry3nV7FY5v+/N+Ra4PzdrrKdxLXgTHbSdCcI6L
   BQ1a5WzeqjCk7Dd9o/vEOKnfsvCOIjFK0CtVXfVZC2VXMtYNV6FxKhXbh
   V9Kyo6twgUqvJAKrtHg9YVVgAGTrk1/x2xUTl/qTfCdPaSYikDttIrrP6
   3ilAAHjP+m9QtMbj/r4u0Il3cfxFlfyz8yjrKAvQJ/ZrlvT52bdtE1wGS
   fDy4NhyEjf1Tt8YUP8x5+pFzNwnKEuT0lQAJVJw5DuAq8NVnLjsjUpbw8
   Q==;
X-CSE-ConnectionGUID: DxWP1yqmRMeyq/H6KdGzCw==
X-CSE-MsgGUID: kr/6/hX2RPmT1M8cL3zGhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23677861"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23677861"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:33:06 -0700
X-CSE-ConnectionGUID: AE1KaMHuScueiNefId/jLQ==
X-CSE-MsgGUID: oNBRJMdYTdu7qkIJcHThqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63230573"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa007.fm.intel.com with ESMTP; 29 Aug 2024 04:33:04 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v3 iwl-next 0/7] ice: Cleanup and refactor PTP pin handling
Date: Thu, 29 Aug 2024 13:28:07 +0200
Message-ID: <20240829113257.1023835-9-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up current PTP GPIO pin handling, fixes minor bugs,
refactors implementation for all products, introduces SDP (Software
Definable Pins) for E825C and implements reading SDP section from NVM
for E810 products.


Karol Kolacinski (5):
  ice: Implement ice_ptp_pin_desc
  ice: Add SDPs support for E825C
  ice: Align E810T GPIO to other products
  ice: Cache perout/extts requests and check flags
  ice: Disable shared pin on E810 on setfunc

Sergey Temerkhanov (1):
  ice: Enable 1PPS out from CGU for E825C products

Yochai Hagvi (1):
  ice: Read SDP section from NVM for pin definitions

 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    9 +
 drivers/net/ethernet/intel/ice/ice_gnss.c     |    4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 1129 +++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  119 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |    2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  103 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   72 +-
 7 files changed, 799 insertions(+), 639 deletions(-)

V2 -> V3: swapped in/out pin numbers in all patches introducing them
V1 -> V2: fixed formatting issues for:
          - ice: Implement ice_ptp_pin_desc
          - ice: Add SDPs support for E825C
          - ice: Align E810T GPIO to other products
          - ice: Cache perout/extts requests and check flags
          - ice: Disable shared pin on E810 on setfunc
          - ice: Enable 1PPS out from CGU for E825C products

base-commit: e3b49a7f2d9eded4f7fa4d4a5c803986d747e192
-- 
2.46.0


