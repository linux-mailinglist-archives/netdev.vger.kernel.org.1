Return-Path: <netdev+bounces-234182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E60C1DA6D
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 657944E3217
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD862E5B09;
	Wed, 29 Oct 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGhcp+hd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117732F25E6
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779627; cv=none; b=a5bgvitGcYxz1NY+HoHPqfgZOom2hib44FAKj+6/9LWfAjLYfk171m5h3pZaFWp1eadcEDHULV5ISX5riT/RxGyTpy7/psfN1X5Q1JLFDmEmyNlT08d8ymL2T18eufj03dpOYVGQtSrmShex5IPxr8WWn/nJEO1sJvI3la7O05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779627; c=relaxed/simple;
	bh=DAkYfmRlyjhKsFZLWKSbdNJmW5wlXaLYXHZQ4JfW8MI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ui8yCV900TYX0lC4Njv8CPwCK2qUrzd4NBKtV7E8RTuZS3vmpqqdirhyRvbynvCZh9rv26XokIs8+VoPgvyDYE/G0qpLbHCuOGfh0p+o4ih3N5lrQEgCcnlDjI/I/jAcy8k28f5JW/V1jrKHrTf0UjGt9vygGvLCNlZSgG0cBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGhcp+hd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761779626; x=1793315626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DAkYfmRlyjhKsFZLWKSbdNJmW5wlXaLYXHZQ4JfW8MI=;
  b=HGhcp+hddEdV4sogxDQl9wlyheUDBT66h6VzvgEQXGdAMutbP8eQHVQX
   hD0m8VGKzFtXB1U4y5rpSwMmmpnzeYX2/npzDN/elxFlB8a1ZQZOz7Ww+
   eloVon2MmPhc1O8oWe1Le7ckBfF/VYj0S7I1qntJu8BLxdQw+T2SpXiIK
   kwxyIQyokLKFZhPx1y9seoiLfSL3oUvTueT76FqmFOcsnQiOZ6pCzrhwt
   1jJCLyM5GhRe3ihRnLcDmWnkHZE7DdiHolay25+cav3+37hjKehymrPlT
   1DbGTcv/ZJsXbMktOTXD9wKp5FMSKeLEzDmt7pfcDUmfZ7AAXW9q8PfRQ
   g==;
X-CSE-ConnectionGUID: 8CmhN1pBRX2EjwnZiui7dA==
X-CSE-MsgGUID: T41qWumFSTe/sCcgVnnqfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63817602"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63817602"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:13:46 -0700
X-CSE-ConnectionGUID: 1hcyBpLASV22eVM8+skYZw==
X-CSE-MsgGUID: FpQUBaheSnqBj3dwmOVyVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185729682"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Oct 2025 16:13:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/9][pull request] Intel Wired LAN Driver Updates 2025-10-29 (ice, i40e, idpf, ixgbe, igbvf)
Date: Wed, 29 Oct 2025 16:12:07 -0700
Message-ID: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Michal converts driver to utilize Page Pool and libeth APIs. Conversion
is based on similar changes done for iavf in order to simplify buffer
management, improve maintainability, and increase code reuse across
Intel Ethernet drivers.

Additional details:
https://lore.kernel.org/intel-wired-lan/20250925092253.1306476-1-michal.kubiak@intel.com/

Alexander adds support for header split, configurable via ethtool.

Grzegorz allows for use of 100Mbps on E825C SGMII devices.

For i40e:
Jay Vosburgh avoids sending link state changes to VF if it is already in
the requested state.

For idpf:
Sreedevi removes duplicated defines.

For ixgbe:
Alok Tiwari fixes some typos.

For igbvf:
Alok Tiwari fixes output of VLAN warning message.

The following are changes since commit a8abe8e210c175b1d5a7e53df069e107b65c13cb:
  net: phy: motorcomm: Add support for PHY LEDs on YT8531
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Alexander Lobakin (1):
  ice: implement configurable header split for regular Rx

Alok Tiwari (2):
  ixgbe: fix typos in ixgbe driver comments
  igbvf: fix misplaced newline in VLAN add warning message

Grzegorz Nitka (1):
  ice: Allow 100M speed for E825C SGMII device

Jay Vosburgh (1):
  i40e: avoid redundant VF link state updates

Michal Kubiak (3):
  ice: remove legacy Rx and construct SKB
  ice: drop page splitting and recycling
  ice: switch to Page Pool

Sreedevi Joshi (1):
  idpf: remove duplicate defines in IDPF_CAP_RSS

 drivers/net/ethernet/intel/Kconfig            |   1 +
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  12 +
 drivers/net/ethernet/intel/ice/ice.h          |   4 +-
 drivers/net/ethernet/intel/ice/ice_base.c     | 170 +++--
 drivers/net/ethernet/intel/ice/ice_common.c   |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  37 +-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  21 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 710 ++++--------------
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 132 +---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  65 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   9 -
 drivers/net/ethernet/intel/ice/ice_xsk.c      | 146 +---
 drivers/net/ethernet/intel/ice/ice_xsk.h      |   6 +-
 drivers/net/ethernet/intel/ice/virt/queues.c  |   5 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |   2 -
 drivers/net/ethernet/intel/igbvf/netdev.c     |   2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   4 +-
 20 files changed, 364 insertions(+), 971 deletions(-)

-- 
2.47.1


