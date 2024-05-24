Return-Path: <netdev+bounces-97985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB78CE75E
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 16:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA305281F3F
	for <lists+netdev@lfdr.de>; Fri, 24 May 2024 14:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51A712C498;
	Fri, 24 May 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4TX5gbI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A412C53B
	for <netdev@vger.kernel.org>; Fri, 24 May 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562562; cv=none; b=pVZAR+JFpHQ/CE18PhI506MPta/8565W/D+Qc8bYVU9J63QZdw18HUJr9eCL89rV66KrRlpS4QIX1ZmnM7nEzbDdeJZl4yhD9y/f7Z15UyF5ZzKLPHJCmDx7exkAN8id+Ka2PZSOBdoWpoaeBllb/tcCgXV3Gz7RBfzmOKN+0JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562562; c=relaxed/simple;
	bh=AewH8JA9HIUsgxrnXtqykExha6GUv7XIEJDRz2IYeDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b8ITg57DRiEEuBTNVGcbmvBKGnDV6Xy3tU/CgRmJzPMVuRwRYEP4+g6rNo5u1pf+kfMiIMUP9/plHmfWB7bOEgj5/iwtOMhyz/z6wxcz6Hi2DVAKU3hcg5UR2z85Ax589+ZLtANHEitGRX9uR5tM83eSN+ugEpFjlIcCQY0NCtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4TX5gbI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716562561; x=1748098561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AewH8JA9HIUsgxrnXtqykExha6GUv7XIEJDRz2IYeDM=;
  b=K4TX5gbIWXLeWGZJTiyvDDckCRuJga7W2GMygGId20yDQpjgyaI0YA/7
   eihc+kCvsi4SpRewAxEgmvS7v+dArz1mr+Uuc6PdfgW8CrVOUvQvBVnVV
   fAqR83MIp0qtCiv/eCcD5bW9LXrzxHlM13Gr3XuDOG7RHWBMIabmhBplq
   oV62ocEWkFpmAvQyVvjDnuQvheQ2aoF+EZWORQwQLTooe6IZAyu/vWU3p
   WyJ5PWuDGexicJrQ2Av/xkV8uHEYV1ql6VSIMuifSgnbutliDmeIx3xbj
   2Z0+nROQLMJrimeULMx6qUaZc/IcKfACDNk18ykHt6JPTdU5dBIcfGFmQ
   g==;
X-CSE-ConnectionGUID: AV0iI9sxRHaUJFyLsy2esg==
X-CSE-MsgGUID: A0EKjKK5Q+KkhKeAkucl9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="24070365"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="24070365"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 07:56:00 -0700
X-CSE-ConnectionGUID: yHEWC3Q6QxaR5iqWHDubaQ==
X-CSE-MsgGUID: pP9nWGpRSeyjY+TNx+xF6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="33946047"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by orviesa010.jf.intel.com with ESMTP; 24 May 2024 07:55:57 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v6 0/7] ixgbe: Add support for Intel(R) E610 device
Date: Fri, 24 May 2024 17:13:04 +0200
Message-Id: <20240524151311.78939-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for Intel(R) E610 Series of network devices. The E610
is based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability.

This patch series adds low level support for the following features and
enables link management.

Piotr Kwapulinski (7):
  ixgbe: Add support for E610 FW Admin Command Interface
  ixgbe: Add support for E610 device capabilities detection
  ixgbe: Add link management support for E610 device
  ixgbe: Add support for NVM handling in E610 device
  ixgbe: Add ixgbe_x540 multiple header inclusion protection
  ixgbe: Clean up the E610 link management related code
  ixgbe: Enable link management in E610 device

 drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   14 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   19 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2545 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   75 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  430 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   71 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1062 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4265 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h

-- 
V1 -> V2:
  - fix for no previous prototypes for ixgbe_set_fw_drv_ver_x550,
    ixgbe_set_ethertype_anti_spoofing_x550 and
    ixgbe_set_source_address_pruning_x550
  - fix variable type mismatch: u16, u32, u64
  - fix inaccurate doc for ixgbe_aci_desc
  - remove extra buffer allocation in ixgbe_aci_send_cmd_execute
  - replace custom loops with generic fls64 in ixgbe_get_media_type_e610
  - add buffer caching and optimization in ixgbe_aci_send_cmd
V2 -> V3:
  - revert ixgbe_set_eee_capable inlining
  - update copyright date
V3 -> V4:
  - cleanup local variables in ixgbe_get_num_per_func
  - remove redundant casting in ixgbe_aci_disable_rxen
V4 -> V5:
  - remove unnecessary structure members initialization
  - remove unnecessary casting
  - fix comments
V5 -> V6:
  - create dedicated patch for ixgbe_x540 multiple header inclusion protection
  - extend debug messages
  - add descriptive constant for Receive Address Registers
  - remove unrelated changes
  - create dedicated patch for code cleanup
  - remove and cleanup of some conditions
  - spelling fixes
  
Eventually I decided not to create a dedicated patch for ixgbe_schedule_fw_event(). In order it makes sense it would require to extract some extra event code as well. This extra code is explicitly dedicated to link management i.e. to what the specific patch implements.

2.31.1


