Return-Path: <netdev+bounces-149277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E159E5011
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A298A169BAC
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88AD1D47CB;
	Thu,  5 Dec 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZBhJePi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D251D4610
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 08:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733388301; cv=none; b=BMhKsMBc5az4i1dx3VHtGBolG8dcjUIJzrmJbl5VT3fBdC+S8tnAJH84L4qq7wrucvBkj7WgrRLTHU6oTTDwu1+b2Wy53TWwzSeKPkMMXf9n27h8TZOPtwhOl0wAzOV0A0vW/5fJF4MMSkcmLOfCGKpIoSRhrco+ADkbXD4XCVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733388301; c=relaxed/simple;
	bh=++auwdWGqOBL7xPQ1S/5rKB89GYBl2+ivEQFgMw4iWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6uzDiZ+sPPJrAetTn0r7/iirMSHq2BAeiRu1APtuZg9MAZPMSjdR9RiGk525abfS0FJRofZJzx17G5FPcJghq8QgD/SfMdtXZ3mNz055g38YKoiq8h9BnsRt2O+GENn3W0N0Tm0w13MDfqoUo9shomH20yTvosI8gjWs6/Isn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZBhJePi; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733388300; x=1764924300;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=++auwdWGqOBL7xPQ1S/5rKB89GYBl2+ivEQFgMw4iWU=;
  b=nZBhJePiKQhipqgjFJokwMKhCOk0+bSxGRiPYrhvaYL4n7KCGSHIdU/0
   uu6tTFWLLIKa+IfRqMnUzAc7xtX1ab9xTrGXahWCp3sdQhU3hswKA8AIo
   5USAfuELcDbVtGpxA7M9iWr14xEqocdfqCKnZnSJHcUUDu+REqHPLhHb5
   cHzCE8Om369inmu5ogzO+0K3ZeqXxUWYDmG/8xhXUuahKLbqA+fqMMjAK
   wn7mAjrBz8PrHG8ocaY1ukYRf9msn8lf9HcWn6CJ77yLsTv9gFYNmUOnH
   dKGpsPDFxbHOYgVq0DBzHB6c0nDmLS86m0wyKS2PRH5BPwrPP2ahNfYhc
   Q==;
X-CSE-ConnectionGUID: Y1siU6GOQQq4dN5yCo8OFw==
X-CSE-MsgGUID: BrLoTrr5QwuFHd2/UyOxVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="37623113"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="37623113"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 00:44:59 -0800
X-CSE-ConnectionGUID: HYw9iRdMThiIbL84a5sSPA==
X-CSE-MsgGUID: 4qM3osZUTl6kTHi+jV9IUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; 
   d="scan'208";a="94863952"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.2.76])
  by orviesa008.jf.intel.com with ESMTP; 05 Dec 2024 00:44:58 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v12 0/8] ixgbe: Add support for Intel(R) E610 device
Date: Thu,  5 Dec 2024 09:44:42 +0100
Message-ID: <20241205084450.4651-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
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

Piotr Kwapulinski (8):
  ixgbe: Add support for E610 FW Admin Command Interface
  ixgbe: Add support for E610 device capabilities detection
  ixgbe: Add link management support for E610 device
  ixgbe: Add support for NVM handling in E610 device
  ixgbe: Add support for EEPROM dump in E610 device
  ixgbe: Add ixgbe_x540 multiple header inclusion protection
  ixgbe: Clean up the E610 link management related code
  ixgbe: Enable link management in E610 device

 drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   13 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   25 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2655 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   81 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  436 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   72 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1074 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4405 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h

-- 
v1 -> v2:
  - fix for no previous prototypes for ixgbe_set_fw_drv_ver_x550,
    ixgbe_set_ethertype_anti_spoofing_x550 and
    ixgbe_set_source_address_pruning_x550
  - fix variable type mismatch: u16, u32, u64
  - fix inaccurate doc for ixgbe_aci_desc
  - remove extra buffer allocation in ixgbe_aci_send_cmd_execute
  - replace custom loops with generic fls64 in ixgbe_get_media_type_e610
  - add buffer caching and optimization in ixgbe_aci_send_cmd
v2 -> v3:
  - revert ixgbe_set_eee_capable inlining
  - update copyright date
v3 -> v4:
  - cleanup local variables in ixgbe_get_num_per_func
  - remove redundant casting in ixgbe_aci_disable_rxen
v4 -> v5:
  - remove unnecessary structure members initialization
  - remove unnecessary casting
  - fix comments
v5 -> v6:
  - create dedicated patch for ixgbe_x540 multiple header inclusion protection
  - extend debug messages
  - add descriptive constant for Receive Address Registers
  - remove unrelated changes
  - create dedicated patch for code cleanup
  - remove and cleanup of some conditions
  - spelling fixes
v6 -> v7:
  - rebase to adopt recent Makefile "ixgbe-y" changes
v7 -> v8:
  - implement more clear execution flow in ixgbe_aci_list_caps(),
    ixgbe_discover_func_caps(), ixgbe_get_link_status(),
    ixgbe_fc_autoneg_e610(), ixgbe_disable_rx_e610() and
    ixgbe_setup_phy_link_e610()
  - make use of FIELD_PREP macro in ixgbe_is_media_cage_present()
v8 -> v9:
  - tune-up auto-negotiation advertised link speeds at driver load
  - update the method of pending events detection
  - update the way of discovering device and function capabilities
  - update the parameter set-up for the firmware-controlled PHYs
  - fix port down after driver reload
v9 -> v10:
  - clean-up redundant automatic variables
  - optimize return statements
v10 -> v11:
  - add support for EEPROM dump
  - use little endian type in admin commands
  - fix link status message based on FW link events
v11 -> v12:
  - add early return from ixgbe_read_sr_buf_aci()
  - comment formatting fixes

2.43.0


