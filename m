Return-Path: <netdev+bounces-90946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5B08B0BFA
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD8B1C22972
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BAC15F409;
	Wed, 24 Apr 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHmTM/WE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7647B15E210
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967568; cv=none; b=JHORPQ83I8gyYwlwUruzUcQDwT00jgJsFGxOdGV0/TjV0HxPRClglldBn7/9lXo08X6YZHEA83E94gU0ZDwqzqN4m2fxP9eQR/NR1S2BGqynWIxSVr13MFQoGpP/R7GXgh3RH9r1PJ4I3HC1eKIfwwl6gL+COOECifT4+nFeisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967568; c=relaxed/simple;
	bh=Er1MsQgnGHHH4ZmIxCZWEFVY8Z60X76jmdptKTGKOzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uOjFD1BCh+F8+l+FaA9b8UQ/zunqlJyiNwFuEcf9jDEVZJkiPAkt6Zkv2DVyUmBbd1YP7hItuK06o2TDe088ZKsc2n5HNr7BzG406GzpPfGv6TwG4QI984uWah/Kbz2e6hSFJxktLi2FGF56MGmC9DmlgKyv0BVg9pOm/kEQ5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHmTM/WE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713967567; x=1745503567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Er1MsQgnGHHH4ZmIxCZWEFVY8Z60X76jmdptKTGKOzY=;
  b=AHmTM/WErbJs0nAgx51A0L74GKcmFLkfAPRet3IqImt25WhLjTx2Wr+7
   qtLovKAIDbsKFq3zRJxWebvyVugjIGkwwfkt0jYfmH5m+Qfqbhpu6yp28
   3Tptm7zPpN/qa3oMNTNQkNw+hy6L8bYi+XkUd+SWGcQ6TTz6Bpmkn2pAv
   j3R/2OKQbvx+8HuuCGFGhFT2eg86VvPZ2RUhFwPKoCYXJJKQyHO/hDWHQ
   9WEQ3J0GBnUOKOmkWQnhUhRWqjLyCIE+Fnb7S9YCO8kbbnTK2W+JjjbPc
   13EWaUKsavHwKRCLcivDmgxS3BldagheDgZJsKvA+bNAodp5GoGPzLkXc
   A==;
X-CSE-ConnectionGUID: v72t84k7S6irKfCdvTbyiw==
X-CSE-MsgGUID: U0duORRYQjiEDBat7gLqFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="10138133"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="10138133"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:06:06 -0700
X-CSE-ConnectionGUID: qQbGo4DeQ5SNM70bLLjrsw==
X-CSE-MsgGUID: phZiunlZQxiag/JD9QppVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="55922827"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by fmviesa001.fm.intel.com with ESMTP; 24 Apr 2024 07:06:04 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	horms@kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v5 0/5] ixgbe: Add support for Intel(R) E610 device
Date: Wed, 24 Apr 2024 16:22:46 +0200
Message-Id: <20240424142251.3887-1-piotr.kwapulinski@intel.com>
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

Piotr Kwapulinski (5):
  ixgbe: Add support for E610 FW Admin Command Interface
  ixgbe: Add support for E610 device capabilities detection
  ixgbe: Add link management support for E610 device
  ixgbe: Add support for NVM handling in E610 device
  ixgbe: Enable link management in E610 device

 drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   15 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   19 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2533 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   75 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  435 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   71 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1064 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   42 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4274 insertions(+), 65 deletions(-)
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

2.31.1


