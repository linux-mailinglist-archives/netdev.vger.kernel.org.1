Return-Path: <netdev+bounces-118199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D5D950F46
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 23:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBDB284976
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAAE1AAE11;
	Tue, 13 Aug 2024 21:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPaxLa2/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA11E498
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585819; cv=none; b=JYM+g73lszs7Rf1ddpBvCfGK8e2CVP1yPMKFmDYa/2botZvm6nnIdZ1NFSwBX56JGKCC3+F1YPgfkP0S6wQGpgzwkJYnCBFDc14LUdJCRLsE+pzVGDWYSh7Qi0YjJo+s/aM9WFDM7busnvZNNQ0emqEL580XT4jojf1NJKzC/7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585819; c=relaxed/simple;
	bh=P+7Fr/xkTM99wC+AQAuhc8VCHoTamGAh+rvVok8wAQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nz4Y50fRwN5IP05YXQJZxWJt8ZalIRFIe00ZJbeP0xlegbt1+v6CFZZZt/Vne8HLWcsuVucWY9tCkqFbziMJ8FLzBc5hrIjD6XaTAoxAGGqQ47wSXXIkjMoMfKw3ISjQk3CYKzRcucKfZIv9bawKHsFnWvULKkInQYm+oqo8c9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPaxLa2/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723585817; x=1755121817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P+7Fr/xkTM99wC+AQAuhc8VCHoTamGAh+rvVok8wAQo=;
  b=hPaxLa2/eeR8hopRSBx3Lu40dA/nZG6z8kQPf1jNonQ4/WfIiOrFv8cZ
   9jdSbRZdPNqHGTXIAE6jW8m7CI3agOfnLjjwLo0mVye2XgOdUuVrcUsrF
   jErd20BVsFTU0neoMlvoXtcxLcpN+I2iMljltkpm0phiZW2KApyfV5612
   EZIVyXjwJRBImmuqGF/OV8mJuS7wuM4xJIsO2pIzZCuNw1eL1gTlEvIZs
   kHmUK93AMqNv7jT0JSt5l/DI9S6dfg/ow6fveOunDWJ+vRvhGfIDMGP8n
   M46D+YlmHqR9NbdBSQVA9lMe7lfK7VTTLFEWoeBRLIb1wlP5StH/71mur
   Q==;
X-CSE-ConnectionGUID: jFUVA9XDSCGg/9TUd5sCRg==
X-CSE-MsgGUID: P1IisQCcRymXVEYZszwFZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21748097"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21748097"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 14:50:06 -0700
X-CSE-ConnectionGUID: 2tWm17KjSZKBOA88T5S33A==
X-CSE-MsgGUID: xRiLjT5gRbefP4ehDbJdyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="58685547"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 13 Aug 2024 14:50:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
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
Subject: [PATCH net-next v4 00/15][pull request] ice: support devlink subfunction
Date: Tue, 13 Aug 2024 14:49:49 -0700
Message-ID: <20240813215005.3647350-1-anthony.l.nguyen@intel.com>
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
v4:
- fix dev warn message when index isn't supported
- change pf->hw.bus.func to internal pf id
- use devl_register instead of locking version
- rephrase last commit message

v3: https://lore.kernel.org/netdev/20240808173104.385094-1-anthony.l.nguyen@intel.com/
- move active checking into functions where it is set
- move devlink port creation for subfunction into patchset where it is
  used
- change error message in subfunction activation to be consistent
- remove leftover from patch 5 (sorry Simon that I missed your comment
  previously)
- add support for xsk ZC multi-buffer for subfunction netdev

v2: https://lore.kernel.org/netdev/20240731221028.965449-1-anthony.l.nguyen@intel.com/
- Add more recipients

v1: https://lore.kernel.org/netdev/20240729223431.681842-1-anthony.l.nguyen@intel.com/

iwl-next: https://lore.kernel.org/intel-wired-lan/20240606112503.1939759-1-michal.swiatkowski@linux.intel.com/

The following are changes since commit dd1bf9f9df156b43e5122f90d97ac3f59a1a5621:
  net: hinic: use ethtool_sprintf/puts
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
  ice: subfunction activation and base devlink ops

 drivers/net/ethernet/intel/ice/Makefile       |   2 +
 .../net/ethernet/intel/ice/devlink/devlink.c  |  46 ++
 .../net/ethernet/intel/ice/devlink/devlink.h  |   1 +
 .../ethernet/intel/ice/devlink/devlink_port.c | 508 +++++++++++++++++-
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
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 329 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  33 ++
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.c  |  21 +
 .../ethernet/intel/ice/ice_sf_vsi_vlan_ops.h  |  13 +
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   4 +
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   2 +-
 26 files changed, 1397 insertions(+), 138 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h

-- 
2.42.0


