Return-Path: <netdev+bounces-116855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E194BE04
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7B61C21E01
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7258E18C91F;
	Thu,  8 Aug 2024 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i6kdFBBl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C41487C0
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723121913; cv=none; b=A+GyL+GuwWJBxbP6kfiRioSctvRKlUfldYSqXgCSSjVgx4QT5OoCtIfqI5w+amVPCu8gvh4cdNgpemA/S8tSoq5Je5PY4c0y4PcCjHv/bD5LfhJW8fdj85nIVz6hh08Ykg10zx/o9egDKchVa9F7Z9/4IWXbJtOoqHO+mfiDTAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723121913; c=relaxed/simple;
	bh=o6k55yf1spn/c3CkBKCM6I8CSExYb7qwa4LrVRUuHQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtguLSyzS/ltHT/02k60Nc3fk5P9iCUNhi4/gQXmrTXMTFikRk4w1gO6+voXEZmasqi4jI/+RNZImje8tlab5KseusXmUT5EMY1EulChVRfsBC0EfJumWZ+rVS+m2xtbN74EnlJjAVaH++yVO2nvaPp5zNy/EbLM3iYkvJnwXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i6kdFBBl; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723121911; x=1754657911;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o6k55yf1spn/c3CkBKCM6I8CSExYb7qwa4LrVRUuHQI=;
  b=i6kdFBBlSWE7joiejdmrkbpJxqAvZ10CSq+VWpsOQJihE7A3Y6/dpmM4
   5PxOKEkOav8oX7HWC/6Q8YTUCQUw+NjbBSGW32TU3/s8QXNvBdgqAruay
   sAok/asX42c09xIaaeCJ3QyBVULrgkGh4pdoGHfZNbsXWmCZvP2n5HFNg
   lSgRchAxoOJesLx6lOCPejlzBIE8ukVGuqoO7ydfMJK7um36wla0LvTM5
   W7QLEaS5vwXgksX2/fFG2AiI6A2WAmvS56EjFu96Ytk9KUgo9OIkbpcQD
   blUbLCYJEsHs5/EfcHHbWbOHo+eYQ5D/WsBrk4PGxv3DiRtwP+2wbM8mB
   A==;
X-CSE-ConnectionGUID: cz5CEXc+QoKCStResiHBVg==
X-CSE-MsgGUID: tLW7Jm3sTPujn/stov0E/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21404748"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21404748"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:58:31 -0700
X-CSE-ConnectionGUID: jPBah51OSrKOZhXwXI/urA==
X-CSE-MsgGUID: LTYM0w6qT66vnNMAQSHOlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="61595064"
Received: from unknown (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by fmviesa005.fm.intel.com with ESMTP; 08 Aug 2024 05:58:29 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v5 iwl-next 0/6] ice: Implement PTP support for E830 devices
Date: Thu,  8 Aug 2024 14:57:42 +0200
Message-ID: <20240808125825.560093-8-karol.kolacinski@intel.com>
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

Karol Kolacinski (4):
  ice: Remove unncecessary ice_is_e8xx() functions
  ice: Use FIELD_PREP for timestamp values
  ice: Process TSYN IRQ in a separate function
  ice: Add timestamp ready bitmap for E830 products

Michal Michalik (1):
  ice: Implement PTP support for E830 devices

 drivers/net/ethernet/intel/Kconfig            |   2 +-
 drivers/net/ethernet/intel/ice/ice_common.c   | 128 +----
 drivers/net/ethernet/intel/ice/ice_common.h   |  19 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c     |  23 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  25 +-
 drivers/net/ethernet/intel/ice/ice_osdep.h    |   4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 469 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 289 ++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  41 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   9 -
 13 files changed, 618 insertions(+), 416 deletions(-)

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

base-commit: 58c0a87ea4b48467b6cc94835cc5d206a589d724
-- 
2.45.2


