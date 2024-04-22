Return-Path: <netdev+bounces-90110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC78ACD43
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 14:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9421C21857
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E019B14EC61;
	Mon, 22 Apr 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMvGkr9F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E30914EC5F
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790168; cv=none; b=qfrQjLUK8j6s6ovDFTnG81k6KfUZAUvUybnJV+3+S0wUays5tcoC4K0BRFWYA3tMK4ULdbQvkhaEi5Sp39DsqUL8ieD8/1SHbzRXRuTi00IDm4WpQyg+tAqomrfGJXANOy3uznhSfrLgGQ0N4xTyXVIaU/MujQbYuGX1LGqySQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790168; c=relaxed/simple;
	bh=OBdLAFzGToia8gq0yy5mNngQuXhBJt0KrcR1RzgL/Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UlCTgyN2bho6AHYs6UwHk+bqWF95e0C7EUAiqvoKl8YYARiFRsnGE1cdIlHdGxiPr4qoFOsH5XpM9VBfNvkAWOciSSUVRvIiyZWKLJANMe26qHe6OBvSIgP5Pb7hHPAct2m07XXSQdAEg5vDNyZ2IOIg6Ge1AI+7PYyj0AgtubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMvGkr9F; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713790167; x=1745326167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OBdLAFzGToia8gq0yy5mNngQuXhBJt0KrcR1RzgL/Vo=;
  b=LMvGkr9FE+mGuLDkM28nEAkEwseW+wLqenkYOMfU3N2oYIWhcNZMWejH
   Nv7Ocp+h9Hp10rAqHHyA1e8apEwVz+RqvJQoSL1C2RBWLMsh+084PokDb
   s3ZQ/IkuCHEZxHRvpOrcoDjEI7AJuRueaHia49zR4EPXRLLqAtVK7W2om
   vfP66eTyhKRT/v5xWVzR6NCUSGCXfntq65DSmsmMM06hXQ0GxT1mzj614
   yn9X8oF+imOEVL5y0cJI1Eth1WiZFvsNAOHHAQcIn6HNX4SELbyfqvuBc
   jhAsRUICXDbo8f4Y+J4xPgtGQ5kbKwtBATnzuQtB73fU739M5IDUjYX/S
   w==;
X-CSE-ConnectionGUID: io1yb4vuRjSR8mQohuS2MQ==
X-CSE-MsgGUID: lI0uVAjFRHOT+M9KwTu7kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="12262978"
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="12262978"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 05:49:26 -0700
X-CSE-ConnectionGUID: pt+OqKq7SXatQnDWu5MhjA==
X-CSE-MsgGUID: RoT0bh00SFC3kYGBl02z8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,220,1708416000"; 
   d="scan'208";a="28789129"
Received: from amlin-018-251.igk.intel.com (HELO localhost.localdomain) ([10.102.18.251])
  by orviesa005.jf.intel.com with ESMTP; 22 Apr 2024 05:49:26 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v4 0/5] ixgbe: Add support for Intel(R) E610 device
Date: Mon, 22 Apr 2024 15:06:06 +0200
Message-Id: <20240422130611.2544-1-piotr.kwapulinski@intel.com>
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  435 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   71 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1064 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   42 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4302 insertions(+), 65 deletions(-)
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

2.31.1


