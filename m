Return-Path: <netdev+bounces-114697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C4194389D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 00:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDF01C216CC
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 22:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2179A16D30F;
	Wed, 31 Jul 2024 22:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejHxXGy8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155F101EE
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 22:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463848; cv=none; b=DeSU2rybcHZNDfGfxSx6d4E7s8zXH8nOSZz2lMppWDwvGLZxs2By3H5XAvSjHAM0tZkn5XWtsE0vIEdRkrCSmqIbc6T0VddKF1wORnSXn/APfHt/9bjpOMHtRJzxPZf0fJxDLaBKOqGZODT2wob6CEsDHEiHedSibrqWQH6DYXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463848; c=relaxed/simple;
	bh=ohLz7UzPgyciRwIfam3IbldYdM6MBWNXl9g8BWLHnA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW+pMDFHksV/KuwDzFTN65r2klcUrmywCPvuZzuGZBYjmFu1tNPv7hD+/R5ePnV1LuOnVW4OCvTOQ3s/WbssGnndqNTi6N7HApJU4yCi3elrlj850/Oh2wCBuoHPWijKAbknsD1g9Vx3iFdZrBJoCQwy1Jk/W/K8tl7dAplGdlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejHxXGy8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722463846; x=1753999846;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ohLz7UzPgyciRwIfam3IbldYdM6MBWNXl9g8BWLHnA8=;
  b=ejHxXGy8wZe4GUw18/KdSCeEzZrznXqK+VETpCaLjnUO8p9t1D/I/FRk
   tcVUpzwpdgP3N4v4qt+H/D1+FEdaH7hvWVExQPZuwXTA3SVhZNkcqiMyg
   vExwWs8ZWk5xjMtSuxi9I97h2Js3ZVb+tgCabjuyUIAecU+y/MMnArPGY
   tj4Xq0NPx08aBVQwMzpM+T/v+2x9Gzp9EH1wVrakLdh4SU0t1ywve4Zyv
   /JSsWXR3TxVn22FOVEe0n8cecabS9qLSt5h3EfOjLRcGtwx6LT5z2JDGj
   bSGObiEnqREp2hJqUdhlf31LeLt6gnyhuoWOMsZZVXg6fPFKcPbz3SwnV
   g==;
X-CSE-ConnectionGUID: SWP5wp5bSFuEFBSZy5vTpw==
X-CSE-MsgGUID: NO0vW6ZZT2O/WpRqf3PMmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31765467"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31765467"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 15:10:45 -0700
X-CSE-ConnectionGUID: KnYR7fUpQjmcgk6PCHo9NQ==
X-CSE-MsgGUID: vpDK00v7Rd+Wxk3AR2nueA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54734118"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 31 Jul 2024 15:10:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com
Subject: [PATCH net-next v2 00/15][pull request] ice: support devlink subfunction
Date: Wed, 31 Jul 2024 15:10:11 -0700
Message-ID: <20240731221028.965449-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michal Swiatkowski says:

Currently ice driver does not allow creating more than one networking
device per physical function. The only way to have more hardware backed
netdev is to use SR-IOV.

Following patchset adds support for devlink port API. For each new
pcisf type port, driver allocates new VSI, configures all resources
needed, including dynamically MSIX vectors, program rules and registers
new netdev.

This series supports only one Tx/Rx queue pair per subfunction.

Example commands:
devlink port add pci/0000:31:00.1 flavour pcisf pfnum 1 sfnum 1000
devlink port function set pci/0000:31:00.1/1 hw_addr 00:00:00:00:03:14
devlink port function set pci/0000:31:00.1/1 state active
devlink port function del pci/0000:31:00.1/1

Make the port representor and eswitch code generic to support
subfunction representor type.

VSI configuration is slightly different between VF and SF. It needs to
be reflected in the code.
---
v2:
- Add more recipients

v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/

The following are changes since commit 990c304930138dcd7a49763417e6e5313b81293e:
  Add support for PIO p flag
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Michal Swiatkowski (8):
  ice: treat subfunction VSI the same as PF VSI
  ice: make representor code generic
  ice: create port representor for SF
  ice: don't set target VSI for subfunction
  ice: check if SF is ready in ethtool ops
  ice: implement netdevice ops for SF representor
  ice: support subfunction devlink Tx topology
  ice: basic support for VLAN in subfunctions

Piotr Raczynski (7):
  ice: add new VSI type for subfunctions
  ice: export ice ndo_ops functions
  ice: add basic devlink subfunctions support
  ice: allocate devlink for subfunction
  ice: base subfunction aux driver
  ice: implement netdev for subfunction
  ice: allow to activate and deactivate subfunction

 drivers/net/ethernet/intel/ice/Makefile       |   2 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |  47 ++
 .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
 .../ethernet/intel/ice/devlink/devlink_port.c | 503 ++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  46 ++
 drivers/net/ethernet/intel/ice/ice.h          |  19 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 111 +++-
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  52 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  66 ++-
 drivers/net/ethernet/intel/ice/ice_repr.c     | 211 ++++++--
 drivers/net/ethernet/intel/ice/ice_repr.h     |  22 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 331 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 26 files changed, 1396 insertions(+), 137 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h

-- 
2.42.0


