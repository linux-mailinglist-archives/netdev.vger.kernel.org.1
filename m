Return-Path: <netdev+bounces-87845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4188A4C60
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2B0283574
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7FF3BBF8;
	Mon, 15 Apr 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBfd5CNX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C015B4EB34
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176294; cv=none; b=scQ6bsqx+sup4UkSrV7EOYhgH88GNAlREabIDWhVSigrdH+F5LSYc0LU7HfFJYmawO6U5dS7fdNj9Szz64RrgWImjo4XBg7qKM+JrYBbPQJXbXWjjlPgLrV+mSYDrCyidOzSwib2pVMcpWK8SRWCSg8j9m0qUObKboqy5znE2YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176294; c=relaxed/simple;
	bh=AZS4DmOzGFIcN0PHic8w9urf/jdRAOlvQ3Vo+rfERxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ieZimiD5GFAeilzApDABjMpj22+7LhGnM2kEsFdq5u4HQPqc/FkZiMY7a7OkYiMYbKW4M5Yco0rJSVD3QtvTJQ9LSvcipa9CCJRIElUUhmL6WlVrgcM7wwf7WNgOfwAgbTqAGE4CDyLUeJNnVLEa/Rgn+KlEm7uq77ST3eodSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBfd5CNX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713176293; x=1744712293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AZS4DmOzGFIcN0PHic8w9urf/jdRAOlvQ3Vo+rfERxw=;
  b=XBfd5CNXoz8IeYwVV2j5wFVlZihuurYn1yX0U3KuvikChx6B0Ma4o4TP
   ga1mI9O4JyBpnZE3KC6MOfERIsz0AUeQfRjQvw2SICPuhSO6+48R81aTc
   mnjEIi/ZvnRcwXcgUaNwyMIUs/RvHwx6JsF9TcxQNA0EXAy7jEjCc2DXV
   eaDz9pjtDZJA1WAKYWF5vALxkT8Oa3mMbSL8dNeRJBDXdAuPhdVY2j6XL
   L9fqqauygCYnEsKhUNEgKA9EIz0TBm0QV8KdPbya8j4FSrEwDIr/MdaTP
   FgX2pfOXBf0btWPprF+K85UEXGWtaZg3d9EZTPjdre4bI+JvhI/5BRq9v
   Q==;
X-CSE-ConnectionGUID: zVX3BL1QSMapD3t2nZbtug==
X-CSE-MsgGUID: uGIdDC6+SyWy7RXqS9L0fA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="26070186"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26070186"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 03:18:12 -0700
X-CSE-ConnectionGUID: C/eiN/JPRguQT3nK8OLRAQ==
X-CSE-MsgGUID: c79uc+BTTseD7k6VHmWh/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="22295442"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by orviesa006.jf.intel.com with ESMTP; 15 Apr 2024 03:18:10 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	vinicius.gomes@intel.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v2 0/5] ixgbe: Add support for Intel(R) E610 device
Date: Mon, 15 Apr 2024 12:34:30 +0200
Message-Id: <20240415103435.6674-1-piotr.kwapulinski@intel.com>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2561 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   75 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  437 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   71 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1064 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   42 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4303 insertions(+), 66 deletions(-)
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
  - fix inacurate doc for ixgbe_aci_desc
  - remove extra buffer allocation in ixgbe_aci_send_cmd_execute
  - replace custom loops with generic fls64 in ixgbe_get_media_type_e610

2.31.1


