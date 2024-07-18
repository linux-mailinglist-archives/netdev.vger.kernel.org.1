Return-Path: <netdev+bounces-112052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF999934C02
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9113A1F20626
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361312C484;
	Thu, 18 Jul 2024 10:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+FjeVrp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22CD86126
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300070; cv=none; b=uL4sY8/e2eNCNDKrVPF1Owhrp7HFF7kzWrTyMpSe+L9gugYXyvH+2Np78eFnjVN8h2TOx/KmNJOxs9OmSQFwUbQuOWfndWDkKzsrdtSI5TneTaUorosKwnHA5o7xmM+4DHtxABH2FYxG7LJdmjT4SRlIl3uIslijQdJvXedAyoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300070; c=relaxed/simple;
	bh=sxMWnGOzRQceGXp+LR0DnSHdV1N4rJK5zGv22/Wt+58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RPyp3NUWw687yE0J7qfc9LND8A+ZzFacPZqLsXu5r44uttmjJc/i7JrN+3t/Vnpl3wuisGVjj8OgmkHnSBz53ZVF2XNCEGu/LeURhZZ+btpIc3hWo7F/7urs9ZipuumyZsT+d1vNyXICA4ESXUEWnJWBD6fZ3ZFB384rNPU+3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+FjeVrp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721300067; x=1752836067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sxMWnGOzRQceGXp+LR0DnSHdV1N4rJK5zGv22/Wt+58=;
  b=X+FjeVrpIp/E4buQA6tQzFN4rh5J8i4tDA93QykLGOKfTwJpKK7hpZcJ
   K0mn1V9B68zwjVs+k/c2podN7L++ATziQkd3nv2Tnsf0Acgbvuavp0EWV
   ivN6fx93lMD2jhu7rg0Lk5ySH240BBOchjr3CtmDwoXIveZr+UFDB7XYM
   5zPkd3KlpKYwqgRLn2OJ5TOTaXlGilz/OaaKLtDm2NblFm4Hs7xqZO+f4
   zOBrfb3T63jBcLVI74Wnnk8DR5nvoYvGy/DCs0R6UV9Lb95yZEtAkMEO7
   k3mhMMT8AoxIN5qgTEtgvigN6po4whlO/C/ebHrnEeR8PV26oxWks1Y9m
   w==;
X-CSE-ConnectionGUID: Z/gtqcsoQvWuooz/X9/xuA==
X-CSE-MsgGUID: RiLjl1DITYGrLkz4CWfcsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18987481"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="18987481"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 03:54:27 -0700
X-CSE-ConnectionGUID: /MZsoTwtQdmNcd/fADbQBA==
X-CSE-MsgGUID: IsRPWmyeRlCsR3GuQFQ4Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="50774567"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa009.jf.intel.com with ESMTP; 18 Jul 2024 03:54:26 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-next v4 0/5] Replace auxbus with ice_adapter in the PTP support code
Date: Thu, 18 Jul 2024 12:52:48 +0200
Message-ID: <20240718105253.72997-1-sergey.temerkhanov@intel.com>
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

Previous discussion: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20240701/042528.html

v1->v2: Code rearrangement between patches
v2->v3: Patch cleanup
v3->v4: E825C support in ice_adapter

Sergey Temerkhanov (5):
  ice: Introduce ice_get_phy_model() wrapper
  ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
  ice: Initial support for E825C hardware in ice_adapter
  ice: Use ice_adapter for PTP shared data instead of auxdev
  ice: Drop auxbus use for PTP to finalize ice_adapter move

 drivers/net/ethernet/intel/ice/ice.h         |   5 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |  22 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 339 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  24 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   5 +
 7 files changed, 129 insertions(+), 310 deletions(-)

-- 
2.43.0


