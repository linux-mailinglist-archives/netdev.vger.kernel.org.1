Return-Path: <netdev+bounces-84758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8276D898445
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 11:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27F51C2749A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFF9745C2;
	Thu,  4 Apr 2024 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJyhZxo/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558074437
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712223323; cv=none; b=hiIW/cFShVY1FMm8TGT4hADFnuJ4dLxiwshBeVGxgtnUnGPnzZe0oLEcSqSeSHxurTjL1juKS1xEMZxxiSdogHRKnrYrJXH2ovyJn7pP/Cb7eF5avFZsh7Ct3Ui1a9Kv8gL6TtEjcdcXBZMahqXcvyTxUolajwRtGX1xN7z+yM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712223323; c=relaxed/simple;
	bh=804h/wJ3Vn2oUveeLzbpox++xlV4ieOC7u4DPiWV3T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgtUgJPwyMageyrTXupKbfnX9DrtdoaWAxPVNBJnhxYZFwqxTSNCJ9MIbEwmZDP/CKz1/BI2OfaTrAWPCEJhaBZDHnOZonAxdALFeuf7DpK8dzXZThQ4RvVoRGqcJ1BMzC9JSKQlMkjqnlnui8dE/WsHz64qTWWP2E7Woh8/7Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJyhZxo/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712223319; x=1743759319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=804h/wJ3Vn2oUveeLzbpox++xlV4ieOC7u4DPiWV3T0=;
  b=RJyhZxo/50cDtCm2dfecVg7oTKiADPbmICzihk7yyCS4i4irz+d3XaXD
   PxctMC7C8nJc3wuRWNrjKW3FboY68xC0iG/SQBuXuFj0EZliRwX/e5lMA
   q8ix1tOERnqGzvzl8CDYCtwWDQgf3NAjPnY4ul3YKylonj5UvO9lquZEs
   8Ym84xJvX24lvRswqRL/oeJrPi1STbRbdyESV9SjArZnQqi8A2pLM48AN
   7+PnjoZ5eVBtbZ2+vzG/1ydY3KMEGki17Kx3Sx+v4OGATfMM2Fzxg4cgq
   FoouPUzvy7lZIaX+/LzlTioTE0B9y4w8YhUuhab46YXNBcwle93GtvCP8
   g==;
X-CSE-ConnectionGUID: YgyW2SvIQA2ek6W1glhoNA==
X-CSE-MsgGUID: WrVFTdmuQyqDo0MZPmkwnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="29966570"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="29966570"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 02:22:44 -0700
X-CSE-ConnectionGUID: obZfBmr2TEqevBkAqZwoPw==
X-CSE-MsgGUID: fOZgO6YQQ+y2faJSBZFnaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="56180695"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa001.jf.intel.com with ESMTP; 04 Apr 2024 02:22:42 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v5 iwl-next 00/12] Introduce ETH56G PHY model for E825C products
Date: Thu,  4 Apr 2024 11:09:48 +0200
Message-ID: <20240404092238.26975-14-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3647 +++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  286 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
 13 files changed, 3900 insertions(+), 936 deletions(-)


base-commit: e4c417070c4f5e3f78e2b568d81d3861004ced3a
-- 
2.43.0


