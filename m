Return-Path: <netdev+bounces-83374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE551892167
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 17:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBA21F25B0D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2E68565D;
	Fri, 29 Mar 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBtj6Ro4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C93A7E772
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729057; cv=none; b=R5H4Ov3jeFYG3RONaRMAGqiUF5SDASz8BOxC8eGDmYTKwoVbNQXbKjAd95kuxQy+Lx83PSIyizu1DmEnQCFXzkCIdtR27B8ydxn30jJ5tuMWCgVI6IVBsDu/voSPTIPhCNW2bT2MT7YMPwWZeVkxl1WobXMgouQ4MrXW1m89pkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729057; c=relaxed/simple;
	bh=TWEar+EA5p/uHKzxMG0sGK1L5h5ifWNU0O+J2bTzfwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qL9Wztr854tsDcoQzivLLHqSTW5/rjokyrIq74MfHMqLe2+9Ol0OpKO3r/EYMXNHrlRIKSH3qmDZyX75YdfvNac+V7Ciy7HcRJDCy8zz04vvb+9zCzLx5IauZXMu8vTLNlD+Hcm2ONvcDeb15Hl77qElm5Heju3oFxDVy7OEw5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBtj6Ro4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711729055; x=1743265055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TWEar+EA5p/uHKzxMG0sGK1L5h5ifWNU0O+J2bTzfwA=;
  b=GBtj6Ro4Uz903Mc+Pye7DkpYXOtpq6JFKHqzuzxEaQZ7OOBx7sECJtns
   u9rTif77hzu75pBDLo4eggLu1gDXAYjlWx+puAIDVcaK7CJM+aigq+Mup
   W9FxxbUXyGhNJWU8fVjZh6ZXdM0bpW7I40V62ynFcVLbYkjdfXugkyPVF
   9WzuczuHNF49yUBrzIOIolufqlunnh01F//TWYKjne55ORqrYDj633mqx
   LZzsiK86zx1NF1xA2SkbO7exFkatOlwcyK23PvZ318Se8r0GBC7jbUlCi
   SNDQlHHiu3j33QvYAE4qGFg/osds5QHhZyC3jQRKU8uq5c0JjRifKKWHs
   Q==;
X-CSE-ConnectionGUID: 1dYEODCzQ6ugCAFj1Lo/mg==
X-CSE-MsgGUID: Nk5kumwpS/qMLHlZCsIHVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7038288"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7038288"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:17:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="21474478"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa005.fm.intel.com with ESMTP; 29 Mar 2024 09:17:33 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v4 iwl-next 00/12] Introduce ETH56G PHY model for E825C products
Date: Fri, 29 Mar 2024 17:09:39 +0100
Message-ID: <20240329161730.47777-14-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3659 +++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  286 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
 13 files changed, 3912 insertions(+), 934 deletions(-)


base-commit: ab4851b5e85f6c55f3d6ebd18134d43746b1f7ce
-- 
2.43.0


