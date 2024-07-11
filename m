Return-Path: <netdev+bounces-110759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D192E373
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3101C2164F
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BAE4D10A;
	Thu, 11 Jul 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TLc0GdUX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8954903
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690211; cv=none; b=arQD8l998Ju0GR3pFDT4V1kcPfLEvbBTmFphWGqHPhrad9NTgFQQ100L6W0o/cNC6usU/7lCKNxZoaRx6J15WLVduFaS2QIPpS5ynf6ZtphMHt/tXqCLNNpfP7njBpvyu3UeaodXlFegg54Nxdd7hN9BhWyz5Owdd5Zp+2Uqy74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690211; c=relaxed/simple;
	bh=9Fo4yrIyLx4oHY0U43D6U62Om4Lto/smBwSovdP0DxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdXohwv+TjdfxbPa+FyhPUEmVd2BNNDRHhtEK1LGamPuY7MlEajeDUVRVpGDickzSEaVWDQVnHTB/y3/Dfhek214l2mIszhXZ+elfTVjxZXRM6lhEVsfOgbsX8T5EfARkg4kPFx4rnY0xT1NCqHdGgUz2ApnN6eCrC9X5Llx2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TLc0GdUX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720690210; x=1752226210;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9Fo4yrIyLx4oHY0U43D6U62Om4Lto/smBwSovdP0DxU=;
  b=TLc0GdUXoO4PNDzqYrHLiDCvoXZoBTdzKBQcCwMsfktzYE9QE8E7tmW5
   TzSNDz7wnFCucGSJdHR397GYBeerAoHEuhV5MJLCLcCkPgx5tFCrWtLFF
   nJ/jO/6inZPk0wyX6XD0mCIhn0zhSqc18AJWmYz1OBAnira+Eka9F2QGX
   JVdCi5cisloo3fZwaenxvzCXs3whPp564RaI7WDmJSE5GuUIT+ynH0JLT
   SPWPhyOas9OCmShMAU5TTgi0ofZwryrH9ewhpYtyieBRYx5xww74Y3c1D
   QeD/njoRij7YJorNNlioxUkRcszOLh3GBoNKPoYkbkvBZIOAJASsJKBwL
   g==;
X-CSE-ConnectionGUID: WrPKPbECTduZNvGxvLqshw==
X-CSE-MsgGUID: dZucXdVAQxO5gYfWo8znfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21821447"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="21821447"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:28:15 -0700
X-CSE-ConnectionGUID: 2hYEYgIrTPCGWZQl/uPsxQ==
X-CSE-MsgGUID: TzkX6edTQbStIBSDP7/MSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48580011"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2024 02:28:14 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 0/4] ice: Implement PTP support for E830 devices
Date: Thu, 11 Jul 2024 11:24:23 +0200
Message-ID: <20240711092757.890786-6-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add specific functions and definitions for E830 devices to enable
PTP support.
Refactor processing of timestamping interrupt and cross timestamp
to avoid code redundancy.

Jacob Keller (1):
  ice: combine cross timestamp functions for E82x and E830

Karol Kolacinski (2):
  ice: Process TSYN IRQ in a separate function
  ice: Add timestamp ready bitmap for E830 products

Michal Michalik (1):
  ice: Implement PTP support for E830 devices

 drivers/net/ethernet/intel/Kconfig            |  10 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  11 +
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  25 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 354 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 197 +++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  25 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 11 files changed, 493 insertions(+), 155 deletions(-)

V1 -> V2: Fixed compilation issue in "ice: Implement PTP support for
          E830 devices"

base-commit: fcfec1114f48ac1a73f68c3a60c2dddbd3ba3902
-- 
2.45.2


