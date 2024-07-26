Return-Path: <netdev+bounces-113188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A924793D262
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 13:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E751F21551
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 11:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A0B17A59A;
	Fri, 26 Jul 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3HKoND+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9547F8
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993797; cv=none; b=HZIpeEGDeVw0O4CfVtyH8Wr1pjNn+nDTf86A2zACTnBWFsYiW0J9WybHbgiOYCb6+8Ikr017LQZCJQX/AGo7DwiuFw9eNlK7igMKU4oM1pBtZSPU35Cm2RNv8HiwxkYjh7mrozppqxLR/BTd/lRsm0ZojNx8tMeq+SfxzLSg9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993797; c=relaxed/simple;
	bh=lLsGyUHtaky6SjftTOw4RXqLhCKwhlh+vCooMpdlI5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvvD6ZjLtWasWgO8AkjwtT/b4s9kBV5UGeDNN4wwnwPvfo9QwzwlOAYQheFe6rjrs3A9NPBN9d6A5wbHvHyvcFx+Pnk9rQvI2qULCXvxEVPv5RkewucuAqLasoiKMUTGPcyRXlp48GjdskxebSPpVcNnCHxF7nKJAxr3qvbiMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3HKoND+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721993796; x=1753529796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lLsGyUHtaky6SjftTOw4RXqLhCKwhlh+vCooMpdlI5k=;
  b=l3HKoND+HS8hQg6O9Pe+3cL9ISb0JhUVcCLLuc5CaBn34DaQWvMP3N/s
   FD8ROKZ6mOUj73g2rHNm4x4ezXB5mdOdU0cky7qpUT/DJwP1rh7VBGcZ3
   FVyc964wNhdR7yx7Vm3tv899WBr+M1HtUkfSYVqe241sFlKNX7cSGmFnD
   gum6vx2j9NEDuFkDtWYEgqx56eyqLH5Pa78BtsoaqxGfEz9g9JsyuKK6r
   9MMo9v9TI5WKQwMcXpJSdvc8t2lsgP3ekjL3LrcqDHVluWjg9k0ypCXrg
   SfaXxh4DgvtlwI45MKh3LTjeAR3qyLJ5XFc+8BwawvsFrEB5WvfT6Cc8h
   w==;
X-CSE-ConnectionGUID: B0WZkLTESxKOmWbB5eihug==
X-CSE-MsgGUID: JlIj26/aQ0WMJGzA7VI0Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19743232"
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="19743232"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 04:36:35 -0700
X-CSE-ConnectionGUID: e96tUXc/T3ylS3NxesiAEA==
X-CSE-MsgGUID: zbVkCjKLQPSt4Wd0mwcYTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,238,1716274800"; 
   d="scan'208";a="76466848"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jul 2024 04:36:34 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v4 iwl-next 0/4] ice: Implement PTP support for E830 devices
Date: Fri, 26 Jul 2024 13:34:42 +0200
Message-ID: <20240726113631.200083-6-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_common.c   |  17 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  25 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 356 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 208 +++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  25 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 11 files changed, 508 insertions(+), 159 deletions(-)

V3 -> V4: Further kdoc fixes in "ice: Implement PTP support for
          E830 devices"
V2 -> V3: Rebased and fixed kdoc in "ice: Implement PTP support for
          E830 devices"
V1 -> V2: Fixed compilation issue in "ice: Implement PTP support for
          E830 devices"

base-commit: fcc95601acb4a30b42cef594d03d2d2ec2bdb56a
-- 
2.45.2


