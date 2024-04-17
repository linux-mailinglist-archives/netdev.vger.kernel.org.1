Return-Path: <netdev+bounces-88790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E898A892D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469D81F2199A
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4C016FF54;
	Wed, 17 Apr 2024 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REY4RC/0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532716FF52
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372293; cv=none; b=n2IDCfzZ7XBRLaxttTPXgcSrg/dpEhFx5lRDqew70RRfNIeofPARBGcwfFvjcUk0uBH7E/4FSLdKflAt1X7XFfGmSK/5bKVtX572aUze0Fx+e6nKH5rcuEecnUIy0QXWjwt2JLwMUPbBfKfFGLsySHOApy1Hv+o/TbCD8Inrmuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372293; c=relaxed/simple;
	bh=y3RtqdXbPhw0XqC4j6k8eguD/9SDmXsvmBp473qqfas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9d+0efPzhk7DDOplefvPyVzgUQYDsYU3SKqOw8qUlX4lmGpSQaWbzYAQo0CkCoFKDBU31KCXn3Jg3xH4PxIc61oBprpaFXpbeSBjub3U0mB1Jk/UB05UNI8gMQ2x00H8WXzrK8ZFkKAmWZz1DJY8b6wpvOE3gKNspziJJYpO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REY4RC/0; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713372292; x=1744908292;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y3RtqdXbPhw0XqC4j6k8eguD/9SDmXsvmBp473qqfas=;
  b=REY4RC/0MRpcfHb8NzKeLgcTRDtrYr0EeXod7LnJqu92UpWgG0U3kT0n
   oHTA+oa5i/uXzbmE3kfqjIL5gOtGOUOiiKsf/UjAZjfR/77XAl9zYqpeq
   IbJ8AhMUxyu+w5GGQfGF47v/SWkE+JhwPhWIhtNSzSiCzmqdgyPRYAHai
   8E1lWB+WAARO69XbHJek0dw8gZu673Tk9xZ8WanMmuI09D9ifOR584aEg
   Z7QQsFLgKfvAEJbHStNZp4AD6UQPoTkx6Cn1m9Q96hf0XeG5HhFIHJjPL
   8bUStWRbSTQ0Dj++aPKm5d6eux4r3a5HV7x6SnrzjfAa5OC+TlstamEkU
   w==;
X-CSE-ConnectionGUID: Jwg1REBOSpedtxRvH2bjcg==
X-CSE-MsgGUID: jr++tkC6Qvyqh2CnVReNxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="12660677"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="12660677"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 09:44:52 -0700
X-CSE-ConnectionGUID: Z3FiP38xTB+LCWel3nh7MA==
X-CSE-MsgGUID: vWV9BssUSGSRNwqzeCi3OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="27470610"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2024 09:44:50 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v9 iwl-next 00/12] Introduce ETH56G PHY model for E825C products
Date: Wed, 17 Apr 2024 18:39:04 +0200
Message-ID: <20240417164410.850175-14-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_common.c   |   65 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |    4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  270 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |    1 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  402 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3306 ++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  295 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
 13 files changed, 3864 insertions(+), 657 deletions(-)


base-commit: ca2791b2bf030090c5d10868fa79ab97de34f57f
-- 
2.43.0


