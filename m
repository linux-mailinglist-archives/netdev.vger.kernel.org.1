Return-Path: <netdev+bounces-122317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4A7960B6C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA00728441F
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99881C6F71;
	Tue, 27 Aug 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYy77Xik"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F91C68AD
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764117; cv=none; b=pAp+awN3NJc75b68sw6TyOaTl/3kII8XpFnscZKPMVp5CigMjKFxdIdZXen9V0xeadNpV3aVcuxhCDRgKO7uU6daZ8K4e9BvZiC65cBd4NgtPisEfAYsOaG2dm3w7JK0NDDYzdg2tPbrGYDrT3ae5hZM+KPNng8yb9XI5vRIcvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764117; c=relaxed/simple;
	bh=bOOr8+ktER/c2B6h2bKZYPgvOLeNv8UOaoUjRIzORKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JCU0r0pPyyUyajsCnU+dhQgkcGRmQvCg5TsVZJ/yhnjiwrN9ZqXw5U8yDPFHvIQTyKj0yqK2GvQMRGAS+CxRAcknQ2MY6L94PNfcyw2BuGiBsIsBrCqcxaxkNwsf9WIdDz+UVVbx8qbJmyc9+0M+dUawpTticFhVUFq1K0B1lHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYy77Xik; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764115; x=1756300115;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bOOr8+ktER/c2B6h2bKZYPgvOLeNv8UOaoUjRIzORKc=;
  b=IYy77XikBTyDLYllgRsLQue6Pw559K/DHYb55AS6RPjFEIX6s5t4GFip
   qfOWiQ4lPc5/tkE96zus2GPwCby5/g4XxEquxuVwaB+izkklVtajokryc
   W+yRI9McbIm2fxoPmon8zbAYw06jSFQXiRaVz5cqPqZCKcr+IDtNt24DH
   h67HoIENMw/CYXtmrvgJcP3zHlOwMgVePju9I0e9I+wxI4QyMeaMLZqCY
   4RbpiRrAerZOOdjw7pJ5oZMThnJ9McxS9Aanq2CN48brhZYKIO1cxtlvE
   Oy/NcIYtmcHcus07mdy5rd2msZQFhdl00A0RqfHPs6AmGoba4orrw9R4+
   g==;
X-CSE-ConnectionGUID: H5HxFdRJSCGAbIah+CpmbA==
X-CSE-MsgGUID: v0w7E491S3eH9k0k4VLepA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40710287"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40710287"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:08:34 -0700
X-CSE-ConnectionGUID: 9Y2LWkFrSVGWY8+330Jlrw==
X-CSE-MsgGUID: EhQC/UYhSyWnRq2UtyvmiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="93650087"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by fmviesa001.fm.intel.com with ESMTP; 27 Aug 2024 06:08:32 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v8 iwl-next 0/7] ice: Implement PTP support for E830 devices
Date: Tue, 27 Aug 2024 14:50:42 +0200
Message-ID: <20240827130814.732181-9-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_common.c   | 218 ++++----
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c     |  29 +-
 drivers/net/ethernet/intel/ice/ice_gnss.h     |   4 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  24 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 502 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 403 ++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  42 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   9 -
 15 files changed, 722 insertions(+), 545 deletions(-)

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

base-commit: 025f455f893c9f39ec392d7237d1de55d2d00101
-- 
2.46.0


