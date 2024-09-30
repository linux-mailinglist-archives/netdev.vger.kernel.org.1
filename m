Return-Path: <netdev+bounces-130339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA7898A246
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D2AB2673E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C241E193401;
	Mon, 30 Sep 2024 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqFMTgF8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C9192D67
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698576; cv=none; b=Fw2L2Sh2pZWhFuLZS2kf4MLBNl2DMyuNZXkFjrNNailFe/nEm0MxJZL2XeP5VUgg0ovqqzxaYBLIgZKvb8S8RsgYDNybSvB12hQLsp+go3mHxvba9MDaT0XdBI+kWpWGVQHeeNq8dGJ5DiFKtZIAOigNqFAPu2Qbgoq4rjXWiyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698576; c=relaxed/simple;
	bh=DTt47dpPGDffgJ3IfOdmw0KPNMFVGWGjZt99zsrS5qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPdf/CR4LrS+XOUGbLlmwucHvMRPSalUPbTY2K5HCebsBTwAZpB0FurVxUvOIovME7YHCC9EnRgT76j6C2CK5nHDM3PSb9a/WD8Obnpj3E823o7aKnQ0+ql/HVk4G7vlwo3l2bCoFD5KG6HdPyriIMSfFlXL0JEvtJPUYKqVtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqFMTgF8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727698575; x=1759234575;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DTt47dpPGDffgJ3IfOdmw0KPNMFVGWGjZt99zsrS5qo=;
  b=SqFMTgF8vxRJ5htEQ0nfOlv7J0gqvW8qmU8OGdvVeKFt3YlBZNfU9RS8
   s4oJuqAWwd7USaZa/rgDcXfrRNGkptewLmr7QGaxTqSqfJCGQkq46EcC7
   jfN0zZzPaGi5TpwRDeQrQZ09VHDb5a8VnwcthewqjL4Xo3os/2nSBuBnU
   ASnt0N24ekjMvPgyuZeFy9NYFUWzdYq0BfFBKLvT5gBXkAyRB6YA9DuMy
   uPpTJ1lHdRQrzEN27fMWWDxDOMgdh7CSQQmtzZYIATIl2dneghgb5sLhh
   P3TRwG8V8EeQUVwzy5zJqc/zORX57740TLEAVcz6pHeMvwhVWTxCJJQKg
   w==;
X-CSE-ConnectionGUID: WP7V0QE1Q6upJ3OMQWAv+w==
X-CSE-MsgGUID: fBsSxBvuROiWComqn6YAGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26666753"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26666753"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:16:15 -0700
X-CSE-ConnectionGUID: DwiH+0tiRCCEwhLXNr0P3w==
X-CSE-MsgGUID: A30vNuTqQEen5Jp0DwEpjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73592727"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2024 05:16:13 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v12 iwl-next 0/7] ice: Implement PTP support for E830 devices
Date: Mon, 30 Sep 2024 14:12:37 +0200
Message-ID: <20240930121610.679430-9-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.1
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
 drivers/net/ethernet/intel/ice/ice_main.c     |  27 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 509 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 407 ++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  42 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   9 -
 15 files changed, 735 insertions(+), 543 deletions(-)

V11 -> V12: Fixed missing E830 case in ice_get_base_incval() in "ice: Implement
            PTP support for E830 devices"
V10 -> V11: Fixed adjustments not working on E830 in "ice: Implement PTP support
            for E830 devices"
V9 -> V10: Fixed E825C MAC condition in caps and and enabled
           ICE_FLAG_PTP_SUPPORTED for E830
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

base-commit: 252daba137fd8c5a841f7120fdafa6f2ad67e88a
-- 
2.46.1


