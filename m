Return-Path: <netdev+bounces-98249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6279E8D0588
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F1928F401
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C31316A36F;
	Mon, 27 May 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEPrpvxt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA717169AF8
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821588; cv=none; b=XmpFv8aRnkNEdg6PsiKPMn6wwH/Hquuy0/d1/jfspLO4sTqFuU3FDcIGmpuiBhgoE2Pr5A4Sh6dyHN57kOzUfTxviSKasv6RQl4QfDqvti4hlhENRdZOicWUQMVNxKyQ70jpHBMvt94YONs7LK7OVemM122iecs1h5M4wIbeCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821588; c=relaxed/simple;
	bh=itFvPj4YbblaBIt+EU+FXMiwTMvaGWZMYtqVhyY36pE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NrFtQfuM7jAPhFVV6X5Tz9Khup3iqmlAJKmROiPjR47eiVmaUgEOzLO501dXwYEdYAryYIPAC980gKnbmPFeH2ixGHhzx1OHdilUrPLCI4Lz4SjwRdvU3nRFdLgsAXNlig1e/7ISDjHfmMMAF/woOfoYA/lY/JAEGobgD7SzPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEPrpvxt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716821586; x=1748357586;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=itFvPj4YbblaBIt+EU+FXMiwTMvaGWZMYtqVhyY36pE=;
  b=dEPrpvxt7Cw29PMcVhhZ3BqiCR34lnTW6lpErAtxioVhJuRhLUVRNBR0
   46e9KYMRV2aXJWMXJr2sx4CbnSGuTgeZkX2/suPnQE6lv4wOrJiZa41Fb
   dN0OrNI6xsJ9LgP0/NLcL5jHaFk3gJQNv5Hs1iNV5QW0vRUFwvfDY9zn3
   rqn2zSd3O/dMXauH8pQhI3sfk8cTjbK32IUO9nk4ylmrpnPdt5KqRtZa0
   pz2xS1eC97Ht/f1BgwApsvlFf1zC85Aqqw4cAVTQ06LEbYt4kG/0jio0l
   y6PuDIP8jX12gYChdR5eaCrZGP47K7EHDHQVVAvR0Zk5x2MgxQODO99vQ
   g==;
X-CSE-ConnectionGUID: vOOApEDmTtKFEDj1SMpzoQ==
X-CSE-MsgGUID: ZqJcTEDqQ22ZvVDb0ENMew==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="11715233"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="11715233"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 07:53:05 -0700
X-CSE-ConnectionGUID: iC+5xNFOSSGtNsou6gjCZg==
X-CSE-MsgGUID: WLCE/uvSQC6GywQIY0nnag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="39191929"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by fmviesa005.fm.intel.com with ESMTP; 27 May 2024 07:53:03 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v7 0/7] ixgbe: Add support for Intel(R) E610 device
Date: Mon, 27 May 2024 17:10:16 +0200
Message-Id: <20240527151023.3634-1-piotr.kwapulinski@intel.com>
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
V6 -> V7:
  - rebase to adopt recent Makefile "ixgbe-y" changes

2.31.1


