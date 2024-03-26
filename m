Return-Path: <netdev+bounces-82165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687788C904
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D281C6237A
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF813C696;
	Tue, 26 Mar 2024 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdZVqahr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B956CDD9
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470241; cv=none; b=ZjKgn/Nq1EZiPjmD7M7Ild3kNK59mz4KEV6A6cD/VJOpc4NPD84tDejnxTl10gS3ze6dUVCvl7atC7LGowpB7EvauoBAF2EZTYo0kBLAKAr0U3p5h8qGt2Y2UQ1D0oMrKRapGlaIK9bnTORS0XuRxVp52jBXbaBjFjZZNpjnUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470241; c=relaxed/simple;
	bh=U1buKvqbmRCkX1AdoER2EVMvAHaVnEkSvTcQPvCWgnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sz8QBqj6CEfxMTL0NAQ4BFFI5adD3DvAfy3ZLV5x9ZEUEyeysoCzy5DjrPF1XpYy38l3RVdUbR00a0U/xbv79Ipt1usopWAnKmThW+dVJZLENhHaVRgCqTcb0AlhKwpMWxKI2tKjg/4jvTqYh2k8fhQiTtSOxXaqdZIISFdWG8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdZVqahr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470239; x=1743006239;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U1buKvqbmRCkX1AdoER2EVMvAHaVnEkSvTcQPvCWgnI=;
  b=FdZVqahrWxdFNnAZYQl/fTcfvI0hVCVmMYH8gUH+bGLzQhfAiK87ilaV
   a7xDi1njay0UmOW2cGO2hMM+XLFRTIUr4kzHUz/COL30SfvA5xXN8aTG8
   CRr37Naf8N73ZP0vkxAlwpmePGs59SKlETUVEVvQoGzKppXJztQ7/TXcF
   TY5F/wpNshVTU/WT4nG1Quc6I1p9tPeCjev7XnevGVnSNFETW0A6jZ4M+
   3I7c6vA5sJTFT8c0XKpW0PsEASnVpYg+qGPTdU+5AvoGmXSrhLEc17YoL
   h0ZAHqnxY5sXOjdqTb6HLxjJ9tps/Tt0mQ2T2wzudrYSp8kLyV981qmpm
   A==;
X-CSE-ConnectionGUID: 2UzAK3n2T0+3jYGHYvyScw==
X-CSE-MsgGUID: kcJR521YTX6gness8PD67A==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6724999"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6724999"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20729255"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa005.jf.intel.com with ESMTP; 26 Mar 2024 09:23:57 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 00/12]  Introduce ETH56G PHY model for E825C products
Date: Tue, 26 Mar 2024 17:22:21 +0100
Message-ID: <20240326162339.146053-14-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E825C products have a different PHY model than E822, E823 and E810 products.
This PHY is ETH56G and its support is necessary to have functional PTP stack
for E825C products.

Grzegorz Nitka (2):
  ice: Add NAC Topology device capability parser
  ice: Adjust PTP init for 2x50G E825C devices

Jacob Keller (2):
  ice: Introduce helper to get tmr_cmd_reg values
  ice: Introduce ice_get_base_incval() helper

Karol Kolacinski (4):
  ice: Introduce ice_ptp_hw struct
  ice: Add PHY OFFSET_READY register clearing
  ice: Change CGU regs struct to anonymous
  ice: Support 2XNAC configuration using auxbus

Michal Michalik (1):
  ice: Add support for E825-C TS PLL handling

Sergey Temerkhanov (3):
  ice: Implement Tx interrupt enablement functions
  ice: Move CGU block
  ice: Introduce ETH56G PHY model for E825C products

 drivers/net/ethernet/intel/ice/ice.h          |   23 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    1 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h |   77 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   58 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |    4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  263 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |    1 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  402 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3652 +++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  284 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
 13 files changed, 3905 insertions(+), 932 deletions(-)


base-commit: 51e66116babc46cc4d5157d76f86d3accce53aae
-- 
2.43.0


