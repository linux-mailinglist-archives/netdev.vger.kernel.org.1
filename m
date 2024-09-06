Return-Path: <netdev+bounces-126092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C74796FDF6
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 00:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5679A284E7C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE3D158D96;
	Fri,  6 Sep 2024 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1udSfa/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4AD158A26
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661813; cv=none; b=R73gpV5w6YGGND4aEoJDl9rzaQfrgHlAjya3Tht4nJiSgXrzpUJkyfisp2ZGNIRGXUKDSBVm+wfUVHzO9iAhd/mly9GBiQfJB9N4pqOMW1weei8HiozUSatRNUSWIXhm9bnH5ojsToBVds1MrNzjXrjWpucWwyO+PALVEN0s8p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661813; c=relaxed/simple;
	bh=7ZGJIc/kAUcWqS6fvkIheVlDB6hVq03F06/Mqw7FtRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SASpxJ2J4jHLXRsB7iOxycy5p9SZDvzehVGdyfp5SktQdLB2RoekIOaXXT47N3FZbkz0QsMdnaIbO6vEd0lb3U5cOeHSAVFD0dyMpf1eAnygDpzJkh8uISBrJ9wxYJTGeLiraxYRFPiLAWsfmCHHo84sEHT/ILtXn9Vbet+iEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1udSfa/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725661812; x=1757197812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7ZGJIc/kAUcWqS6fvkIheVlDB6hVq03F06/Mqw7FtRo=;
  b=O1udSfa/BOI5ZO9y1TtYGOP1OAtbza92EaAd0m7VloGvJapP0RiGsXA6
   iLaXF6pjsc98Wjsq7avfjlbWpJVxZGhC+SnFnxekLKVDaFdsBDibghipc
   KCSIuLqKgWlzNDVuBoz78lbtfka6+WmO9y4uGeH0+OA3y983J7w38P83p
   8DvNo2OgZEV2qubGTkB6pnpP7Zfq99cTR9Ecp1mHU37n6f08oHEdTWOHU
   B6vBlLJm44TtqRn1OTK1fQy8TNWqwBkn4hCof9/q/jv7nsGlBw51Wiizw
   VQykk3rrZEzwiACh87sfcA08dNY8licEWjJzthJvmD0G2rtbSDwBJqaAI
   w==;
X-CSE-ConnectionGUID: 7cX0pyWqRlS9JxQi0EVVOg==
X-CSE-MsgGUID: 7ohqr2KlTECZcjfFe6m7PQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35030659"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35030659"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 15:30:12 -0700
X-CSE-ConnectionGUID: NTo1KXmlQcaK7goqRPF9IA==
X-CSE-MsgGUID: GRu6+eSPRMu/sdaCJEFKGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="70490366"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2024 15:30:11 -0700
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
Subject: [PATCH net-next v5 00/15][pull request] ice: support devlink subfunction
Date: Fri,  6 Sep 2024 15:29:51 -0700
Message-ID: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
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
v5:
- drop reviewed-by tag on patch 03/15
- move out changing devlink physical port number 03/15
  https://lore.kernel.org/netdev/20240820215620.1245310-5-anthony.l.nguyen@intel.com/

v4: https://lore.kernel.org/netdev/20240813215005.3647350-1-anthony.l.nguyen@intel.com/
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

The following are changes since commit 52fc70a32573707f70d6b1b5c5fe85cc91457393:
  Merge branch 'rx-sw-tstamp-for-all'
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
 .../ethernet/intel/ice/devlink/devlink_port.c | 506 ++++++++++++++++++
 .../ethernet/intel/ice/devlink/devlink_port.h |  46 ++
 drivers/net/ethernet/intel/ice/ice.h          |  19 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   1 +
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 111 +++-
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  50 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  64 ++-
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
 26 files changed, 1394 insertions(+), 135 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_eth.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_sf_vsi_vlan_ops.h

-- 
2.42.0


