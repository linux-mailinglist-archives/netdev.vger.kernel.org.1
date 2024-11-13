Return-Path: <netdev+bounces-144540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 008AB9C7BA9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9F71F212CB
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAB8202647;
	Wed, 13 Nov 2024 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JkrVX0sA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4065201113
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524079; cv=none; b=ouX7VH3M4A37MsJiJxmk5x7U3Jy9RX2Wudou27ElWK76cZ8MGJJuem4j5fqYNTv7wEbMy34+cpIrtmwU9RltDDhjtpfS/0YG4mlmyTfae/LXxqsSQHvkZEEBjFE3PnSxkV+FdJ5mwcWJv9JIMzc8Dd8BFc6NvFZbCnT0pJ18v3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524079; c=relaxed/simple;
	bh=TpDMKmRcnpDthQ5xv9cMlcaoHaq5BVwFbZ250lRCp10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YlfyXZ7AAU+F384JI4P3TNYfqfdVbQphRCR0axpfJ9cdsZk60tfC3/PbSzxgspuLY5snvXxrB0zSkd2Z/AQKlFwEaftE+okyc0I6LWBgLdBsQe9fJk0+Dl06hmChzfJEAY35M0l+h71r2v/gihGH0/lNL1vndFk/Sut6bo+eQxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JkrVX0sA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731524078; x=1763060078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TpDMKmRcnpDthQ5xv9cMlcaoHaq5BVwFbZ250lRCp10=;
  b=JkrVX0sAI+OuFIwWrvQx0xr6TSRtnNSjIC1STstrMlvB0e+gylPfocsX
   W8a/B+60ACq7416J+OwST7UJpv61B10Ad8WcwtISb8HbO9IQaouuFDehg
   j707p/NALP4y80TzTFIvfdCVxtEj8Dk52jiseuYNE76LCpKLbepsJrhu6
   HK4oEbZnE2UMxFS4DNtksC6XWnXAMNcUk+JixiXu5uZcInRxBP0ob5jJB
   2eJgEi4va7gM8eNjLP7xQpsS+Y6ojmQD/i4jGgTuI+y4cWfx3QEhXSB9O
   XSIp3qkmbs9rY/ucfN2lz6zyJ3rPCxiOLLHNiSOu5zpvxGdNzkQnOutNB
   A==;
X-CSE-ConnectionGUID: 3dGR8LxjRGmO5PqlwzcjSg==
X-CSE-MsgGUID: ql0zHzoRQE27h9tAbxlXiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31589465"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31589465"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 10:54:37 -0800
X-CSE-ConnectionGUID: bh8GbJRoTGeF/98UVrB9Dw==
X-CSE-MsgGUID: Of+iyZ2oRFOH4VtD1W4JdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87520717"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 13 Nov 2024 10:54:36 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next v2 00/14][pull request] Intel Wired LAN Driver Updates 2024-11-05 (ice, ixgbe, igc. igb, igbvf, e1000)
Date: Wed, 13 Nov 2024 10:54:15 -0800
Message-ID: <20241113185431.1289708-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:

Mateusz refactors and adds additional SerDes configuration values to be
output.

Przemek refactors processing of DDP and adds support for a flag field in
the DDP's signature segment header.

Joe Damato adds support for persistent NAPI config.

Brett adjusts setting of Tx promiscuous based on unicast/multicast
setting.

Jake moves setting of pf->supported_rxdids to occur directly after DDP
load and changes a small struct to use stack memory.

Frederic Weisbecker adds WQ_UNBOUND flag to the workqueue.

For ixgbe:

Diomidis Spinellis removes a circular dependency.

For igc:

Vitaly removes an unneeded autoneg parameter.

For igb:

Johnny Park fixes a couple of typos.

For igbvf:

Wander Lairson Costa removes an unused spinlock.

For e1000:

Joe Damato adds RTNL lock to some calls where it is expected to be held.
---
v1: https://lore.kernel.org/netdev/20241105222351.3320587-1-anthony.l.nguyen@intel.com/
- Drop, previous, patch 1 while it's being discussed
- Move conditional OR operator up a line (now patch 4)

The following are changes since commit 31a1f8752f7df7e3d8122054fbef02a9a8bff38f:
  Merge branch 'phy-mediatek-reorg'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Brett Creeley (1):
  ice: only allow Tx promiscuous for multicast

Diomidis Spinellis (1):
  ixgbe: Break include dependency cycle

Frederic Weisbecker (1):
  ice: Unbind the workqueue

Jacob Keller (2):
  ice: initialize pf->supported_rxdids immediately after loading DDP
  ice: use stack variable for virtchnl_supported_rxdids

Joe Damato (2):
  ice: Add support for persistent NAPI config
  e1000: Hold RTNL when e1000_down can be called

Johnny Park (1):
  igb: Fix 2 typos in comments in igb_main.c

Mateusz Polchlopek (2):
  ice: rework of dump serdes equalizer values feature
  ice: extend dump serdes equalizer values feature

Przemek Kitszel (2):
  ice: refactor "last" segment of DDP pkg
  ice: support optional flags in signature segment header

Vitaly Lifshits (1):
  igc: remove autoneg parameter from igc_mac_info

Wander Lairson Costa (1):
  igbvf: remove unused spinlock

 drivers/net/ethernet/intel/e1000/e1000_main.c |  10 +-
 drivers/net/ethernet/intel/ice/ice.h          |   6 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  17 +
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 302 +++++++++--------
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   5 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 110 +++---
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  39 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   6 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  33 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  59 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     |   4 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h      |   3 -
 drivers/net/ethernet/intel/igbvf/netdev.c     |   3 -
 drivers/net/ethernet/intel/igc/igc_diag.c     |   3 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  13 +-
 drivers/net/ethernet/intel/igc/igc_hw.h       |   1 -
 drivers/net/ethernet/intel/igc/igc_mac.c      | 316 +++++++++---------
 drivers/net/ethernet/intel/igc/igc_main.c     |   1 -
 drivers/net/ethernet/intel/igc/igc_phy.c      |  24 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |  16 +-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  15 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   1 +
 27 files changed, 513 insertions(+), 481 deletions(-)

-- 
2.42.0


