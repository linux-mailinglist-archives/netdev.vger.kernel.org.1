Return-Path: <netdev+bounces-138223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 779839ACA63
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39002283305
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0002C1DDEA;
	Wed, 23 Oct 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOcLWyS5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F6C154439
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687509; cv=none; b=uiYFu+E5LqQL+YOPxoTDK1KwiWnGKyy/vr5eS5g86jF4i9ksiK+3PMgAOs3+/JrFpF8mrPw8J1zEZk0AISknQ1C/MltkGdbFA6oXBPCwQtQY5hGuyabDvt0DSlFFrLB5m/w7sS/TFPMQ+JK9qd60YY2X5D9v+SRgVz95RcOU+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687509; c=relaxed/simple;
	bh=xwAyI5JyxS35wE+3qzFW0EIOwo9s6HxY4SXzlRAjhQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHvMiPhgpzGe/nSXzj6+VbpM3xH+mIsQzgtdyyijj2uk63iYZ4nQRJhavIcgXCruduz/zV22DN6CCLyw+VyUSx/Dn+d8gXgopZ72IGAoAVGPkvQulZ1y0wjYXAFgU3CpwMOeGAE+vhPLssOu6XHUj1Is/XRr4siXzZdp9HHLsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOcLWyS5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729687508; x=1761223508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xwAyI5JyxS35wE+3qzFW0EIOwo9s6HxY4SXzlRAjhQA=;
  b=BOcLWyS5GavBPdWGSYZjVHdAKEeQtoyi9n/3y3YS0BeuSlnn1eKqZiR7
   xrr/WzX4zCVHWJWAqKAHEJndW97BkgtUYron12JC4P3JA/kWe5DdO8i/g
   mBBjXjpAcDmW/YoRkAHgNXaG5GwucBrlLHkoKLutvXhejV939N2p36laZ
   IlcjgTuFzLCxz1aiN1DCREfj6gSgpBDOvEu5hP4BPnfCbTPN4WWVT82gl
   3VlIm86vTmOZvsy+Yo4+h2cDu/wnQHwix/r5RBlHZde16WTm3ijM21b/R
   m5Gi8a2twEYj6OlZem8D/fBELA4TUppoQZ3DssO0uC5RiZEx4UBMCYFjk
   w==;
X-CSE-ConnectionGUID: qAceWKycRIa9rN88fxQOvg==
X-CSE-MsgGUID: LP/TXtcHSFi0BKquWFpVFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51814058"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51814058"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 05:45:07 -0700
X-CSE-ConnectionGUID: VuFzFYlVSqKSMS17MsOL7g==
X-CSE-MsgGUID: g1bihl7gScStsMuspdIHSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,226,1725346800"; 
   d="scan'208";a="80119711"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.246.19.66])
  by orviesa010.jf.intel.com with ESMTP; 23 Oct 2024 05:45:06 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v10 0/7] ixgbe: Add support for Intel(R) E610 device
Date: Wed, 23 Oct 2024 14:43:51 +0200
Message-ID: <20241023124358.6967-1-piotr.kwapulinski@intel.com>
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
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   25 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2552 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   76 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  436 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   72 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1067 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4290 insertions(+), 48 deletions(-)
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
V7 -> V8:
  - implement more clear execution flow in ixgbe_aci_list_caps(),
    ixgbe_discover_func_caps(), ixgbe_get_link_status(),
    ixgbe_fc_autoneg_e610(), ixgbe_disable_rx_e610() and
    ixgbe_setup_phy_link_e610()
  - make use of FIELD_PREP macro in ixgbe_is_media_cage_present()
V8 -> V9:
  - tune-up auto-negotiation advertised link speeds at driver load
  - update the method of pending events detection
  - update the way of discovering device and function capabilities
  - update the parameter set-up for the firmware-controlled PHYs
  - fix port down after driver reload
V9 -> V10:
  - clean-up redundant automatic variables
  - optimize return statements

2.43.0


