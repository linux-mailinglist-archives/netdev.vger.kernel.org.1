Return-Path: <netdev+bounces-127759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FF9765F7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AD1F1C20984
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E44819C554;
	Thu, 12 Sep 2024 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buHmsn0q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B85191F69
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134449; cv=none; b=ANMWfF19NG2JwJkngx40AwJer9oNAn3NTdz7G+jlQLBZkFJhTFPt+SIwg5lsYlclQpihthfkLR6DUgSg2YkOhFf5izzXPhNaYsqfM8s4btAFwK/6CkhUxMe2OKpfE3Q/o+XKcsWwph38Dm7w9R8ZV/CGb85+pjE/wsRDtCY3AB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134449; c=relaxed/simple;
	bh=f9EzcP2QTcdX3X/6TPVQngtbn28a3/SgphO1r2Uj3Wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mM4JQL6x7f4K/rdjhwXITRU4wIAmR6LttyGl4EAnW1r7P0iaJmQXOfaCsJjz9n+R4vYSakXcG10kUcoJTp23QGTcWsCxSRz+7U1uuqeNltjtrfIEt3SAzE6xiR8UFlBPznqZGqtD+1o+JurA7jYfhVEzINy9Rsvet+IsBmt5Tho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buHmsn0q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726134448; x=1757670448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f9EzcP2QTcdX3X/6TPVQngtbn28a3/SgphO1r2Uj3Wo=;
  b=buHmsn0qJhN+Yx4PmXffwoKrKgtlpMuc7mfBNfXm+gJlRK2NvIUfjBPX
   7k3mGRBAsdF40a+ZF1Z6FMxcV8BJhGJwoILy8RKiBmFu9Vy25GYHCAB53
   jgeQHKMiSxvXLwf8T2kdI+Kk9dbZ5juHbviV5eX0IMLEWEomA9tUXBjJK
   9Mmn/INHU013Nj2pSjpv6whxeXOids+GoclsvC0dKC5vY86D7rCNyCZwA
   XMRSVOVSAOksi3NhdzQ/3Hf6hov0uA34PPRk6qV9wrcM5iJLaQbZ1bIUC
   wWrqB1/0qPNJmPB7xWVvRLTovYapbFn7PpZ2owWGaarJBCyemyLZd8N0k
   g==;
X-CSE-ConnectionGUID: DQPV9k9DRVS8vdA1c3bR7Q==
X-CSE-MsgGUID: TljbLXZHTAaYNtrsiw04+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36115358"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="36115358"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 02:47:25 -0700
X-CSE-ConnectionGUID: FMz10dl4RlqUaRHpHNv7Ag==
X-CSE-MsgGUID: 3jguLI5BQk+7wZdpv+YM8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="72650626"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by orviesa004.jf.intel.com with ESMTP; 12 Sep 2024 02:47:23 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v10 iwl-next 0/7] ice: Implement PTP support for E830 devices
Date: Thu, 12 Sep 2024 11:41:45 +0200
Message-ID: <20240912094720.832348-9-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_main.c     |  27 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 509 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 403 ++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  41 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   9 -
 15 files changed, 730 insertions(+), 543 deletions(-)

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

base-commit: 6899a44bb1849adc6bf9b0bad085fdf37bc3123e
-- 
2.46.0


