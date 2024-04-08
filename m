Return-Path: <netdev+bounces-85695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D489BDE4
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485771C20D59
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52CD65198;
	Mon,  8 Apr 2024 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwOLbOKP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27D5FB8C
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575102; cv=none; b=Z4ohdJoowjQOvXDEFMtkEYPcr6Q1R3S8qoWC03EWG9nCs1End0wacf1ke4ynyf7ktaGTHE9PGU3DJaFJRZ+srjNIQZilYKVosLEFMlAS15DjcjlKUroOJZjZv1jOkOjUZ/6EssGfhXYq39oUtpw73y/pWX7oHfZeKeCgCuv/OU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575102; c=relaxed/simple;
	bh=dQPBce9GX9FJrilfHJ6ellVM2ibschBaLtiITZVazNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Po4RzfOdplk4ICpjRG8myRVVAC6MZT/iVbqA4Bu3FivrfQHFw1dR+gWgIJYIeGk+fKIlZ2sRoAOX9GbcuoXH65wRAQkAt1ZzqPEr3tBX2wv3b7CytS8BNal+gFjBIB6RnRG9lvCUI2wN9yH3QOOh27Wdy+2iN6itoCV0DJMPzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwOLbOKP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712575099; x=1744111099;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dQPBce9GX9FJrilfHJ6ellVM2ibschBaLtiITZVazNM=;
  b=gwOLbOKPMZRKb3K9F4uLsTqFpc+xN1skeuQJn2p+ZaiRGpAi/V3X5N/e
   EIb71sUU69pl0aC1Y6Ols1zOCvJ9zv2gf0zMclytY0iIHOpF8WbnAbth1
   8CVEJ6+crODKJf7AlhRf3qC+inOEDOGuIPtz7a8t/PUlDTPq0wqGldWvw
   41aSJ5N3Ja3qOT+ul9zsr2G62VMlJmtR1lzsGVA9YN6gJhzCGuOD4FMFU
   5Qeyf44HaUw3WgIMLaB+GiLDYPn+LQ2aA5fctgVshz5s/lnT4PVJgcKHT
   ovreRI2AmicIrCD/v+rxk4ZiQ0BOoP6+bWLQFRYDkYJhuF9LiQD1taj8m
   w==;
X-CSE-ConnectionGUID: 7cjschctQtqAbh5lb7JXRA==
X-CSE-MsgGUID: VGRCtNdFTHOhpZRtqf2USQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="18988518"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="18988518"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 04:18:19 -0700
X-CSE-ConnectionGUID: yyloKoNDQOmifP5SRRu2iA==
X-CSE-MsgGUID: cA+pxOSXSlav9QKxdelNtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="19904875"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa009.fm.intel.com with ESMTP; 08 Apr 2024 04:18:17 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v7 iwl-next 00/12] Introduce ETH56G PHY model for E825C products
Date: Mon,  8 Apr 2024 13:07:21 +0200
Message-ID: <20240408111814.404583-14-karol.kolacinski@intel.com>
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

V5 -> V6: Changes in:
          - ice: Move CGU block

V5 -> V6: Changes in:
          - ice: Implement Tx interrupt enablement functions
          - ice: Move CGU block

V4 -> V5: Changes in:
          - ice: Introduce ice_ptp_hw struct
          - ice: Introduce helper to get tmr_cmd_reg values
          - ice: Introduce ice_get_base_incval() helper
          - ice: Introduce ETH56G PHY model for E825C products
          - ice: Add support for E825-C TS PLL handling
          - ice: Adjust PTP init for 2x50G E825C devices

V1 -> V4: Changes in:
          - ice: Introduce ETH56G PHY model for E825C products

 drivers/net/ethernet/intel/ice/ice.h          |   23 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    1 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h |   77 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   58 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |    4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  265 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |    1 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  402 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3594 +++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  290 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
 13 files changed, 3873 insertions(+), 914 deletions(-)


base-commit: c6f2492cda380a8bce00f61c3a4272401fbb9043
-- 
2.43.0


