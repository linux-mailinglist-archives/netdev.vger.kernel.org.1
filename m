Return-Path: <netdev+bounces-241680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDE6C87584
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DCF3B5F78
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 22:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02E8314D1B;
	Tue, 25 Nov 2025 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REPQ/ZpA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062AF2EFD91
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764110198; cv=none; b=OZfPXzUU29IsnDx0tf9qKwaZj0yZsgUwmAQI/vYs4zyv63rjcsjW4DZC6nwh6skPwFEYsGuHxEAi1dzxp0GFD7CLTldq1UoJg2EwY8zRbiw2zhoqL2lI3E8Odl1Gx8iK7klAXb3xt/4cCykXFwDWe59ZFG71YwBaVKUTDQboqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764110198; c=relaxed/simple;
	bh=hcRJtIbfuGCj6EbbhHXb5AH940Gb3VVqfGDLXmM7GYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXPV6o5FA/jqvD3HjuW/8oe5STi1SiX7F41BzLBBMT1E52bCvjyJIeXnV7ruAxaVr9jr88ekqObh3dBREg75KMItZvDrJjPwM2lKfWezCEOyW12DCS/78M/fqowByHw6Jc9YEAVUdd/smVmEyfd7gXoKgEVw0fIO2hn/4GTOY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REPQ/ZpA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764110197; x=1795646197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hcRJtIbfuGCj6EbbhHXb5AH940Gb3VVqfGDLXmM7GYA=;
  b=REPQ/ZpAhTRopmNCfKZAjxu3RPK/r5NavyqxypHLuVxNhDh09o7LUJqA
   HHANFd2kTSlJGlmgw9CetFqxsIQcthi+dwn4hNFeqDPYXJi8pvKuVtri/
   SyfCdktkXESH6GpabjWScSES+ysUEYa9yY9S8Uq3SVu66bzXghOYtLED7
   mwvymcrLUcvhgUIpQqEKbgXRATJyrLl3UiwZRdHFq6sz/0z24vROmrt3/
   J6AoF+7xJhgPV3XBSEKxBdkyA120qE7oyKeIIdzt808Q0LHUGB26KUBpR
   hfbyRNd2GehJdQeg1TIjYx55kwduzaFNvoRMhAOyKWe6DBYZsm3eDoyVN
   A==;
X-CSE-ConnectionGUID: Li+SwvGNRnqZLW+tP9o4qg==
X-CSE-MsgGUID: 8DneApJ8QUKviFMNLf234w==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="68729871"
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="68729871"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 14:36:36 -0800
X-CSE-ConnectionGUID: xZXg10n6R6q6ygzM4PJsHw==
X-CSE-MsgGUID: 3Wqjr1bdTW2BP6YrcnHOCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,226,1758610800"; 
   d="scan'208";a="193209539"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 25 Nov 2025 14:36:36 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/11][pull request] Intel Wired LAN Driver Updates 2025-11-25 (ice, idpf, iavf, ixgbe, ixgbevf, e1000e)
Date: Tue, 25 Nov 2025 14:36:19 -0800
Message-ID: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arkadiusz adds support for unmanaged DPLL for ice E830 devices; device
settings are fixed but can be queried by DPLL.

Grzegorz commonizes firmware loading process across all ice devices.

Birger Koblitz adds support for 10G-BX to ixgbe.

Natalia cleans up ixgbevf_q_vector struct removing an unused field.

Emil converts vport state tracking from enum to bitmap and removes
unneeded states for idpf.

Tony removes an unneeded check from e1000e.

Alok Tiwari removes an unnecessary second call to
ixgbe_non_sfp_link_config() and adjusts the checked member, in idpf, to
reflect the member that is later used. He also fixes various typos and
messages for better clarity misc Intel drivers.

The following are changes since commit 61e628023d79386e93d2d64f8b7af439d27617a6:
  Merge branch 'net_sched-speedup-qdisc-dequeue'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Alok Tiwari (5):
  ixgbe: avoid redundant call to ixgbe_non_sfp_link_config()
  idpf: use desc_ring when checking completion queue DMA allocation
  idpf: correct queue index in Rx allocation error messages
  ice: fix comment typo and correct module format string
  iavf: clarify VLAN add/delete log messages and lower log level

Arkadiusz Kubalewski (1):
  ice: add support for unmanaged DPLL on E830 NIC

Birger Koblitz (1):
  ixgbe: Add 10G-BX support

Emil Tantilov (1):
  idpf: convert vport state to bitmap

Grzegorz Nitka (1):
  ice: unify PHY FW loading status handler for E800 devices

Natalia Wochtman (1):
  ixgbevf: ixgbevf_q_vector clean up

Tony Nguyen (1):
  e1000e: Remove unneeded checks

 .../device_drivers/ethernet/intel/ice.rst     |  80 +++++
 drivers/net/ethernet/intel/e1000e/ethtool.c   |   6 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  12 +-
 .../net/ethernet/intel/ice/devlink/health.c   |   4 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 214 ++++++++----
 drivers/net/ethernet/intel/ice/ice_common.h   |   8 +
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 311 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  11 +
 drivers/net/ethernet/intel/ice/ice_fdir.c     |   2 +-
 .../net/ethernet/intel/ice/ice_fw_update.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  14 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  46 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  12 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  12 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  24 +-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  12 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |   4 +-
 drivers/net/ethernet/intel/idpf/xdp.c         |   2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |   7 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  43 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   2 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |  18 +-
 28 files changed, 718 insertions(+), 151 deletions(-)

-- 
2.47.1


