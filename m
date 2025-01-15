Return-Path: <netdev+bounces-158304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD965A115DB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A5C168C48
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0961FB3;
	Wed, 15 Jan 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PD1KHl1O"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ACE10FD
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899734; cv=none; b=VTWymbGuR3AMR7RGA/Uxe2/76qc3bzuo91IrzHnkxHjO9jawJ/dHKV3CfQ0hSQPMrSebUTBiSwWoyPZvy9qDiCaUuraeK38TtVjZ6qssVZ11Qe3LQXMJDOXFeSGlOWVuJyiKeTR/Ce/pZrVPXnLUS6IREPm95LBwEtWWl0986Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899734; c=relaxed/simple;
	bh=KoStXcsMPxtxUyJL05ZTxlkznKcEEFAiMjT4x+Ra3xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSU5Fp7p2cH7D6oRILbTe9+iDh8YVVIbir4iMx2XACtlD2OTYrvpfOX+QYgpTK/Ts5z+JqqBseluayNomcRT/0rSqwYNH8uQ3/SQxVedlSOC9uTLgpSz91sEGB4THOYCr98hGiGtxnYdtuEKQICsusz9tStwbSkVzywgqJrjsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PD1KHl1O; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899732; x=1768435732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KoStXcsMPxtxUyJL05ZTxlkznKcEEFAiMjT4x+Ra3xg=;
  b=PD1KHl1OZsBskzixszuoPqM3T2PvdwpOstU8Py+26VRgqJtWRIMXRT7I
   6Zbrj/3DmYMh6g+WwaCPdU0PpIjjeT6JW1DL6aqVdIdffAd/7hfwat/iB
   4qepJQm82XOnTdOdw3zZuaUgK30oVMEmFjXOhw15LeOoDOaWOsA124Mlb
   WaFDi70k1GqR5p0xpLpCNwdypif2o70cxunos2CrgaswKJBQdIPxdBcNO
   zgQsMqEJHZNoG2iQw814exR6u6IiuUNfqSW7CdJPmHmv9Q2SuhuKZHg5d
   n2/8LhDyU0Mcn7F0WERiWhFENeuQFG2nGs9kKEIoqSey35XJiSv6a7bT6
   g==;
X-CSE-ConnectionGUID: THPaWVcsQ1Krl78zv4g5Vg==
X-CSE-MsgGUID: O84lMNbZSUOdP/oA7CWXQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897443"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897443"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:51 -0800
X-CSE-ConnectionGUID: aUBvepCGQZGVj/TWydWnQg==
X-CSE-MsgGUID: vqVx2XKXRQOg6ukK0TMNHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211387"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:50 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next v2 00/13][pull request] Intel Wired LAN Driver Updates 2025-01-08 (ice)
Date: Tue, 14 Jan 2025 16:08:26 -0800
Message-ID: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
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
---
v1: https://lore.kernel.org/netdev/20250108221753.2055987-1-anthony.l.nguyen@intel.com/
- Remove rd32_poll_timeout_atomic macro and update commit message (patch 8)
- Change spin_lock_irqsave() & spin_unlock_irqrestore() calls to
spin_lock_irq() & spin_unlock_irq() (patch 12)
- Use REG_LL_PROXY_H & REG_LL_PROXY_L defines over PF_SB_ATQBAL &
PF_SB_ATQBAH (patch 12)

The following are changes since commit 9c7ad35632297edc08d0f2c7b599137e9fb5f9ff:
  Merge branch 'arrange-pse-core-and-update-tps23881-driver'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (5):
  ice: use read_poll_timeout_atomic in ice_read_phy_tstamp_ll_e810
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
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 130 +++++---
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   2 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  12 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 164 ++++++++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  40 +--
 drivers/net/ethernet/intel/ice/ice_switch.c   |   3 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |  17 +
 14 files changed, 804 insertions(+), 216 deletions(-)

-- 
2.47.1


