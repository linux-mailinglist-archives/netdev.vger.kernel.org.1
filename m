Return-Path: <netdev+bounces-248598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00781D0C402
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 22:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 304B230299EA
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 21:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD5631DD86;
	Fri,  9 Jan 2026 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bptnxPN+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CA31B131
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767992815; cv=none; b=Xy2K2NgakYT5HUQoI0abjQ9VI5Uppcj96WtXlOmup99+qjACNDYouyYH7/6e9nLFat/wkqTPu4pR67iIEHUJI1fHpjpnXjtwH5hTivlAcoZkt2ueYzezn4a5mwKioPK3amyjdJAuBElNFHVP0yXsXhWAvtWUsFRZrXGYhSNLCvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767992815; c=relaxed/simple;
	bh=sP919wvm2WIg4/rtUZntrzL8b49V4vEzvh1frGXz2xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bvZv3lEMErpCTXrPH3mazA+Xb95Spv8BtQX7AhUSb85rhUFbSb0XbOe+14qL4l0ARjU9MPRSg5hB2LOKmdZ3Ttywx0s0cTFg1ZzYMeI1oPtH7AQ2IG9Fo2rAEzHKqxokanzB7LXNoR6eO9tCTjdGOm319dT1++5SoCFecH2WVTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bptnxPN+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767992814; x=1799528814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sP919wvm2WIg4/rtUZntrzL8b49V4vEzvh1frGXz2xU=;
  b=bptnxPN+Fzbe1zjRPfVHOD6XBAAl1DPom2/Sg5khDvRF5TlEMQJTrX7X
   6yHd60Eplz5hZuHcEj+9V+E63/LW+EbqFREx66lbQ2q3oJA7tZXbCRAKR
   9+MDczl7JZm7qK0TUiWZObh2L7KLZB3Tk1n8YkxYRwY6j+6+f/ihfzCPX
   ehPo5HKcySLtANFrBLpron/PyYl3SdKgtbMMKq9HcgXGGmbouxF47PTUf
   WZYYFnufo/nA/2T7MExvppLMeYVqH3+Knh3minDoKciK0Bev+G6YubOrY
   JmKH3IrFFudaS6GSZUM7GguTT0D2P4dFDerMa9k31FXQopS5pahAKowoH
   A==;
X-CSE-ConnectionGUID: MWEWlX5rTxG4HRdSf7MPMg==
X-CSE-MsgGUID: fBsx+3IITzOvPUghSge01Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="73222043"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="73222043"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 13:06:53 -0800
X-CSE-ConnectionGUID: /upkzJCHR7+rhVa5gjOJrw==
X-CSE-MsgGUID: tz2R2JsdSy2qzxUUzm2+0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203571415"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 09 Jan 2026 13:06:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/5][pull request] Intel Wired LAN Driver Updates 2026-01-09 (ice, ixgbe, idpf)
Date: Fri,  9 Jan 2026 13:06:37 -0800
Message-ID: <20260109210647.3849008-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Grzegorz commonizes firmware loading process across all ice devices.

Michal adjusts default queue allocation to be based on
netif_get_num_default_rss_queues() rather than num_online_cpus().

For ixgbe:
Birger Koblitz adds support for 10G-BX modules.

For idpf:
Sreedevi converts always successful function to return void.

Andy Shevchenko fixes kdocs for missing 'Return:' in idpf_txrx.c file.
---
The first two patches originally come from:
https://lore.kernel.org/netdev/20251125223632.1857532-1-anthony.l.nguyen@intel.com/

Changes to patch 2:
- Add 'else' branch to set sfp_type to unknown when BX conditions are
not met.

The following are changes since commit fc65403d55c3be44d19e6290e641433201345a5e:
  Merge branch 'support-for-hwtstamp_get-in-phy-part-2'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Andy Shevchenko (1):
  idpf: Fix kernel-doc descriptions to avoid warnings

Birger Koblitz (1):
  ixgbe: Add 10G-BX support

Grzegorz Nitka (1):
  ice: unify PHY FW loading status handler for E800 devices

Michal Swiatkowski (1):
  ice: use netif_get_num_default_rss_queues()

Sreedevi Joshi (1):
  idpf: update idpf_up_complete() return type to void

 drivers/net/ethernet/intel/ice/ice_common.c   | 79 +++++-----------
 drivers/net/ethernet/intel/ice/ice_irq.c      |  5 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 12 ++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 13 +--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 94 ++++++++++++-------
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  7 ++
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 45 ++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 +
 10 files changed, 145 insertions(+), 116 deletions(-)

-- 
2.47.1


