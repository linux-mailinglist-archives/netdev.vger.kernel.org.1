Return-Path: <netdev+bounces-123228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF3F96434C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4961C246D5
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A81922E6;
	Thu, 29 Aug 2024 11:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZanU6CQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D199191F86
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931728; cv=none; b=h7EIgjZviLFdEkZBudwhDe7hRTmzyEPS8NSqOq5A4zTxzF6pb+V/lyIOA6Mu51mIKIyf6CewolVNj418Ns8mDf0hTvHfHiiVP077iuJke/r1EkF3RQK/qruiBjcltfnKPCjU6pPYRXMfuMRC0/uPfqwX+cG4o56v8bT5lWcPhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931728; c=relaxed/simple;
	bh=xPaxi/7gwUkkALGMYm83jqvODfD2o15/EeyIv9h1ans=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqxueyqJmJu2N3wqFs8v+Us9foW3hC++OYP4+bqjve6tMAZUVcbonRzbwrXcZTpusJTT2aEiB+qFv462utfgs5uSCfyvfIxxVtP1iGHRd9zpSg/k76oCvBAB18kVnhIRIDlJC/fLMT8RJf8lTFP2aYh0AyjaHZV4myX2aBrjZFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZanU6CQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724931727; x=1756467727;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xPaxi/7gwUkkALGMYm83jqvODfD2o15/EeyIv9h1ans=;
  b=iZanU6CQ24zp8u3KKyJdffW35U2NYEkjh/+N++gsbVN9zcQU9TRhHeXu
   3SARHDwyFHkU/WsOBO2bo0Ir0A4OoqjH3h9EVs7ed72m5yoHlvOJNP9uM
   p89jHC21FrY2WFENXBQDT96bZkOir5h/e7yDTjOBW8ynx3PapgE/QlYyd
   T5GST81g1JyPZ8l0GNE9N/68o7l2xqZC0m4lXyj3AqMEpFiIWcZzM4Ymd
   YIFDbypo7DnTtbmgfrXL5/EcP7pjqc1KnI/QBImZcIXJkAUTC+WgLh4V8
   aI7Aj8whijT3vVXdO/4M+3VTuO2TvpffwXOhCssJbCo9vgmCf7yRHRrHc
   A==;
X-CSE-ConnectionGUID: B1xyMZlGT4W2buon9rdtFQ==
X-CSE-MsgGUID: bPfnPThNSSO0v2ur7/PuBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23092320"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23092320"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:42:06 -0700
X-CSE-ConnectionGUID: VSML9KV2RCupfvLPArDvdw==
X-CSE-MsgGUID: zlbv79xJS2OopENsxNESPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="64045375"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by orviesa007.jf.intel.com with ESMTP; 29 Aug 2024 04:42:04 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v9 iwl-next 0/7] ice: Implement PTP support for E830 devices
Date: Thu, 29 Aug 2024 13:37:36 +0200
Message-ID: <20240829114201.1030938-9-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add specific functions and definitions for E830 devices to enable
PTP support.

Refactor processing of timestamping interrupt, cross timestamping, and
remove usage of ice_is_e8xx() functions to avoid code redundancy.

Refactor GNSS presence check to be able to remove ice_is_e8xx()
functions.

Jacob Keller (1):
  ice: Add unified ice_capture_crosststamp

Karol Kolacinski (5):
  ice: Don't check device type when checking GNSS presence
  ice: Remove unncecessary ice_is_e8xx() functions
  ice: Use FIELD_PREP for timestamp values
  ice: Process TSYN IRQ in a separate function
  ice: Refactor ice_ptp_init_tx_*

Michal Michalik (1):
  ice: Implement PTP support for E830 devices

 drivers/net/ethernet/intel/Kconfig            |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |   5 -
 drivers/net/ethernet/intel/ice/ice_common.c   | 210 ++++----
 drivers/net/ethernet/intel/ice/ice_common.h   |   7 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c     |  29 +-
 drivers/net/ethernet/intel/ice/ice_gnss.h     |   4 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  24 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 507 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 403 ++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  42 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   9 -
 15 files changed, 727 insertions(+), 542 deletions(-)

V8 -> V9: Fixed compilation issue introduced after rebase in "ice: Remove
          unncecessary ice_is_e8xx()"
V7 -> V8: - reordered patches to have all E830 changes in "ice: Implement PTP
            support for E830 devices"
          - added "ice: Don't check device type when checking GNSS presence",
            which removes GNSS related changes from "ice: Remove unncecessary
            ice_is_e8xx() functions"
          - reworded commit messages
V6 -> V7: Fixed timestamp acquisition in "ice: Implement PTP support for
          E830 devices"
V5 -> V6: Fixed minor compilation issue in "ice: Use FIELD_PREP for timestamp
          values"
V4 -> V5: Added 2 patches: "ice: Remove unncecessary ice_is_e8xx()
          functions" and "ice: Use FIELD_PREP for timestamp values".
          Edited return values "ice: Implement PTP support for E830
          devices".
V3 -> V4: Further kdoc fixes in "ice: Implement PTP support for
          E830 devices"
V2 -> V3: Rebased and fixed kdoc in "ice: Implement PTP support for
          E830 devices"
V1 -> V2: Fixed compilation issue in "ice: Implement PTP support for
          E830 devices"

base-commit: 1d27028dacb9fdd63de4a7cc819b7dc04b29928f
-- 
2.46.0


