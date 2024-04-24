Return-Path: <netdev+bounces-90900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C54E8B0AD7
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 15:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC83288C77
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB8715A4B0;
	Wed, 24 Apr 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzeZUvHU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D51B80F
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965314; cv=none; b=DckzWr10Z6OSlweYcCGGzzzqEqVq9Actu4Oqy6FT+RapNF645AdJ2SnC5mwHEl6XpRl8CFQZEYzHvZqpuKkok3Cd/NDcH2Wl9aExsmiRf/ST0pMC6SbWtaXyw4Zok5XlAQ9UN3f5y2pFB/rROFIY218g/mrgaZQ2EhoazK1SFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965314; c=relaxed/simple;
	bh=xzYZK0bkx/6l071/oTzRHb0U+Rji80nUPCD0ixKgpvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXM09SYrCZjsNS9VF5kxWCvrc/AOUpxW95YZG8Hxn1+JK1wKTV/0qMtF3UwQ9q6lmqVFaSM8T4TG5djM2ExtvI0EDuEy7E3jTp38C7OGuHP1OrZpElwGpMmMOA6hjP/SJkd5s1unPHcSa7Ml9ogbieCirk+FIIC6GwVp5Rl0NXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzeZUvHU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713965312; x=1745501312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xzYZK0bkx/6l071/oTzRHb0U+Rji80nUPCD0ixKgpvk=;
  b=HzeZUvHU9v9QpRXbez14h/56H6T6JU1oeZXMxW/6/d1KRbID7/0tXOaZ
   bCPj2vccvKNKEQmhcgUj/uHpzyyflcfSy0lhsBhqcD7t90sVL29sZ112V
   yHlfbA+uNm8Fi5ZbhpbZpDDcLejT2RXPVQ/dKjpnXqpqAMd1mQoSWrg6t
   VU5bedNVbbli7NGQclFsmf0jdxhy1omGoYpogqEk/bSmA5zIrzuNTw8hD
   Cwlgo4ueHLssD/Lo/AJCTgBNKdvt1wFiqWErlRcnZswP9ikdux/8A9SQS
   n5mUM0XZogxeWjc8pU2WPjeDopQYWVyqjG4JKN29Vj9gnGgypijLY5XBu
   Q==;
X-CSE-ConnectionGUID: uNPjxvkATzWASfQsJMjgvA==
X-CSE-MsgGUID: AWtmXwS9TfK4I5b7gmhY3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="27109406"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="27109406"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 06:28:32 -0700
X-CSE-ConnectionGUID: t2dpmhd7Qzu1GdmLq4P12A==
X-CSE-MsgGUID: uBvjrvmATP20HmvoXDXwjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29350654"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa003.jf.intel.com with ESMTP; 24 Apr 2024 06:28:31 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v10 iwl-next 00/12] Introduce ETH56G PHY model for E825C products
Date: Wed, 24 Apr 2024 15:22:58 +0200
Message-ID: <20240424132824.111827-14-karol.kolacinski@intel.com>
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

V9 -> V10: Changes in:
           - ice: Add support for E825-C TS PLL handling
           - ice: Support 2XNAC configuration using auxbus

V8 -> V9: Fixed kernel-doc warnings by adding missing summaries and return codes
          in all patches

V7 -> V8: Changes in:
          - ice: Move CGU block
          - ice: Introduce ETH56G PHY model for E825C products

V6 -> V7: Changes in:
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

 drivers/net/ethernet/intel/ice/ice.h          |   27 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    2 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h |   77 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   74 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |    4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  272 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |    1 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  402 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3306 ++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  295 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
 13 files changed, 3873 insertions(+), 659 deletions(-)


base-commit: ca2791b2bf030090c5d10868fa79ab97de34f57f
-- 
2.43.0


