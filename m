Return-Path: <netdev+bounces-156478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A4EA06811
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06605188613F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAD71E1C3B;
	Wed,  8 Jan 2025 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcRm5QGE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511B1A0706
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374685; cv=none; b=KbF/NNBILIAWeTo48mOoLtL/LIdrtufWew9A9KQ8y8v/jKD5cdn6w/yigXPYHPAO7W8gipx5ULk1j/f4pJt+u6quBLK2LDIceRLDWwDrj0RfVF90HlKdlT39GmfJcCYRBbxSQkTdtIE1ASWCFJnlPcf9u7TzJ6X7o7qP4lO86+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374685; c=relaxed/simple;
	bh=P++G9BR+DLCLB26mJp8TBjG9tTNotcOH7HFgoKoYAp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fV4hJL2RhC1FFDU3MU0CeCvk3IiuuUiom1BwgpuDW3eE92a6kS1h4x5amhiawcucSBsXKbSoT8+UjrKXiFGV9KQTp4Pv6jhcyLh8AtB2FA+ElCucX7CHEsGv6PKIvu2qr/sJ7CJu8bovVivxA3NB9NiJlVXcF8lgOCcezGvqATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcRm5QGE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736374683; x=1767910683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P++G9BR+DLCLB26mJp8TBjG9tTNotcOH7HFgoKoYAp8=;
  b=hcRm5QGEBommmDi+FVqiOALpSnOr9LFTBjRKdXgcyPT8KdsuTNBLLHBq
   F+HKOayswMTVUb9EfU7jpDwJrVXY92YLj0PW5+TcppOVO5RDBZmdrGvWO
   LP4GT4d60hAVt7CjNtCIHr9mjnjekkVL3+MukYlOkwSN+iDgH3120LHp/
   fuG64vsge0QJlLpVdcw1AwkxpHOn9g81jChbEWlWBKd4Tw9Xa2G1qyuLX
   zc2dij+FpbxK+S0ggD62Ln5NbNo0FkHLV/QYj/2+u7IvpqF5iIIJYfrGu
   KZsO/+2uzMH5RKSrTu4si93epi6UYKNEyD++SYv3WRFmRIgwN1HpQHxHR
   g==;
X-CSE-ConnectionGUID: QsqffitGS3mbiwfMSkhaig==
X-CSE-MsgGUID: KFYY96pyRhKQPMSmif0KjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40384631"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40384631"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:18:02 -0800
X-CSE-ConnectionGUID: b78LtXQmRqm0R6fBxrObgQ==
X-CSE-MsgGUID: O5+gafHnSXW/fyEh7CtwaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140545104"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jan 2025 14:18:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/13][pull request] Intel Wired LAN Driver Updates 2025-01-08 (ice)
Date: Wed,  8 Jan 2025 14:17:37 -0800
Message-ID: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Przemek reworks implementation so that ice_init_hw() is called before
ice_adapter initialization. The motivation is to have ability to act
on the number of PFs in ice_adapter initialization. This is not done
here but the code is also a bit cleaner.

Michal adds priority to be considered when matching recipes for proper
differentiation.

Konrad adds devlink health reporting for firmware generated events.

R Sundar utilizes string helpers over open coded versions.

Jake adds implementation to utilize a lower latency interface to program
PHY timer when supported.

Additional information can be found on the original cover letter:
https://lore.kernel.org/intel-wired-lan/20241216145453.333745-1-anton.nadezhdin@intel.com/

Karol adds and allows for different PTP delay values to be used per pin.

The following are changes since commit 7bf1659bad4e9413cdba132ef9cbd0caa9cabcc4:
  Merge branch 'intel-wired-lan-driver-updates-2025-01-06-igb-igc-ixgbe-ixgbevf-i40e-fm10k'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (5):
  ice: use rd32_poll_timeout_atomic in ice_read_phy_tstamp_ll_e810
  ice: rename TS_LL_READ* macros to REG_LL_PROXY_H_*
  ice: add lock to protect low latency interface
  ice: check low latency PHY timer update firmware capability
  ice: implement low latency PHY timer updates

Karol Kolacinski (1):
  ice: Add in/out PTP pin delays

Konrad Knitter (1):
  ice: add fw and port health reporters

Michal Swiatkowski (1):
  ice: add recipe priority check in search

Przemek Kitszel (4):
  ice: c827: move wait for FW to ice_init_hw()
  ice: split ice_init_hw() out from ice_init_dev()
  ice: minor: rename goto labels from err to unroll
  ice: ice_probe: init ice_adapter after HW init

R Sundar (1):
  ice: use string choice helpers

 .../net/ethernet/intel/ice/devlink/devlink.c  |  10 +-
 .../net/ethernet/intel/ice/devlink/health.c   | 295 +++++++++++++++++-
 .../net/ethernet/intel/ice/devlink/health.h   |  15 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  87 ++++++
 drivers/net/ethernet/intel/ice/ice_common.c   | 151 ++++++---
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  91 ++----
 drivers/net/ethernet/intel/ice/ice_osdep.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 130 +++++---
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   2 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  12 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 163 ++++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  40 +--
 drivers/net/ethernet/intel/ice/ice_switch.c   |   3 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |  17 +
 15 files changed, 806 insertions(+), 216 deletions(-)

-- 
2.47.1


