Return-Path: <netdev+bounces-108424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E09D923C32
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483FF1F21AE5
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5378C158A3D;
	Tue,  2 Jul 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aX/lkvc+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47206FC3
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919011; cv=none; b=bjZsBBZIujhjOKzyR1lY57t263uss8gRpbSNzqrRMRTqTE48QIfvzsoZ0sLBpC3Xm0q5RasX2YMY+rV2c4B8zLSGF8Hd1u4+G7DvjFJJVgfqa1nlfF5B8JcdTmtA7IUupe40J9iEYS5+j6vf4xqykpuzGFLOPIs9JZTTceKGJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919011; c=relaxed/simple;
	bh=TmwvCbXGUOyqh2fsdiY4RTdtMgEQTuFLI6cCmk0YpNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tG4TGf9GWr3gqusroWNpni8gByeKJTvG8VJqfVjlXd3KooZlsyu2cwpuGhcW+LB86mJkkDLf/gWmC8RxGfNo0p9xqC9nrupwQUS/BlbetZI5kqPQAJghnH5gUdfNFafnrMGknwov6b8nwEDcMXu3MopA0XuYHxKwDkBQxLtnX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aX/lkvc+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719919010; x=1751455010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TmwvCbXGUOyqh2fsdiY4RTdtMgEQTuFLI6cCmk0YpNY=;
  b=aX/lkvc++CeWhlj3E3saJQ4YroR9jDObice7I/ovXnLFq/sqNxSjMeQ5
   u/KxTFKguUc9X496BXa0WS64pjcNS2ozCSigtEtgB+BEyAp3+vqSME/TK
   c4vAOWqkb3vVWZv02UGbDSDHXpMdxnkuN2dXwJ77IKIIctoZiFqc1zfZA
   8Ew3C3DGAZ1K6QAwY0NiK27orLkyRHmoiMNBooIBiZG7M23Xb9r9IU6Cr
   DbHtt3Z/vRd7XYNwSPIKIBEFCN2ltCp11o0KhxKa6C1YK4FMmLXoCX0Fp
   2M2kHq7XbXKDg/RqfFmdfiu7TPqbqV+tAOO4Cg5h+rHofhm3YTdfN/Lbl
   w==;
X-CSE-ConnectionGUID: JkV/WhT0SEyciee8Bef7kQ==
X-CSE-MsgGUID: KLB8UYZCTkqGBZgRhQ0G6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="28481835"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="28481835"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 04:16:50 -0700
X-CSE-ConnectionGUID: O/Yiek0pS5+bBgEGALDFIw==
X-CSE-MsgGUID: G5Vyqi26Qz2BeVeuE1TcHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46005711"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa009.jf.intel.com with ESMTP; 02 Jul 2024 04:16:48 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Subject: [PATCH iwl-next v3 0/4] Replace auxbus with ice_adapter in the PTP support code
Date: Tue,  2 Jul 2024 13:15:29 +0200
Message-ID: <20240702111533.83485-1-sergey.temerkhanov@intel.com>
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

Previous discussion: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20240624/042439.html

v1->v2: Code rearrangement between patches
v2->v3: Patch cleanup

Sergey Temerkhanov (4):
  ice: Introduce ice_get_phy_model() wrapper
  ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
  ice: Use ice_adapter for PTP shared data instead of auxdev
  ice: Drop auxbus use for PTP to finalize ice_adapter move

 drivers/net/ethernet/intel/ice/ice.h         |   5 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |   6 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 337 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  24 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   5 +
 7 files changed, 112 insertions(+), 309 deletions(-)

-- 
2.43.0


