Return-Path: <netdev+bounces-118592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0B69522F4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 21:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7B4B23821
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A081BF32B;
	Wed, 14 Aug 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkX/ht54"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E01AED23
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665383; cv=none; b=ZahOODfveoYbbEmlww874X5D04f4Ga+6qgYbs3kU+DzQnZAPdzEZlJp/BDH/AylmtGY52gWo5qdhAxyfOwlWdK1tX+hLv4zfxhSEaRL9Dxv98beNJehXYLwOIqRbBddQNVSH57pwbvLS9GCpswFRpaNA9vzCxaMeApnMNE2tqTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665383; c=relaxed/simple;
	bh=aECfMSpTudw67XI81fDh7hFBWPgL1yuEKnnS7XVgk9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvKHu0mg0Y9C04mVt6svvY5Vcl4o6vD+6DhcxZsjsM5jW71wM4or2pkC5ZoaZeRiJ8+3w/WFws6sFaOdA3DQZtz/aWO9FDnoaHvVf+T+J3UJgUyX25ekFi5DxPkrjTszSUz+Q48HHr+bv3kFR2lbMo99m1j7bGztf2fKTgQaF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkX/ht54; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723665381; x=1755201381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aECfMSpTudw67XI81fDh7hFBWPgL1yuEKnnS7XVgk9A=;
  b=DkX/ht54AsXLKKKcEAkESSKZAxQJhrOJD1jqyvbgClqZXc6YMOA72zQW
   DyGbaY0KQA63jr2/qvVOPXP3yCxCGazVjU0VgUl/gdoXTBFfOb3yBDsK3
   uLUlZtmxC1prYKkQ0rHp+vDzeU8yzTHIjd7dd4dBWsNBGYphpej8AmiPP
   0Iot77qag5G6ZPiQ/eUSDJC8sH20lmUR45XC/0zT6Sm2lpI1mc7POeNh5
   ZLobUj1HlDITiU5n6ezkyQz/Vb6/b8Db0a++1UzGOYrDSifgAMilor4yg
   Uwvr9DapkNCKPcC8bI9HzkIoWqUhk9IA+Gt2pRMTfZJ1gC1fnoKG7aSv6
   Q==;
X-CSE-ConnectionGUID: vsI7LBDaSE+BxnwZvkrCrw==
X-CSE-MsgGUID: rHoBTfZbQl+DbPqQFHEe+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33292495"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="33292495"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 12:56:20 -0700
X-CSE-ConnectionGUID: E9NPFh9gT5SmfwhlxNAywA==
X-CSE-MsgGUID: 7iNoreR3TlmD+rvG2U1q8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59869696"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa008.jf.intel.com with ESMTP; 14 Aug 2024 12:56:20 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-next v4 0/5] Replace auxbus with ice_adapter in the PTP support code
Date: Wed, 14 Aug 2024 21:54:29 +0200
Message-ID: <20240814195434.72928-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series replaces multiple aux buses and devices used in the PTP support
code with struct ice_adapter holding the necessary shared data

Patches 1,2 add convenience wrappers
Patch 3 does the main refactoring
Patch 4 finalizes the refactoring

Previous discussion: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20240715/042744.html

v1->v2: Code rearrangement between patches
v2->v3: Patch cleanup
v3->v4: E825C support in ice_adapter
v4->v5: Rebased on top of the latest changes

Sergey Temerkhanov (5):
  ice: Introduce ice_get_phy_model() wrapper
  ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
  ice: Initial support for E825C hardware in ice_adapter
  ice: Use ice_adapter for PTP shared data instead of auxdev
  ice: Drop auxbus use for PTP to finalize ice_adapter move

 drivers/net/ethernet/intel/ice/ice.h         |   5 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |  22 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 340 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  24 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   5 +
 7 files changed, 129 insertions(+), 311 deletions(-)

-- 
2.43.0


