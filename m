Return-Path: <netdev+bounces-82104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22C888C55B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF911F3D338
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E9763E6;
	Tue, 26 Mar 2024 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M0601OWg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B310813C3D2
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463999; cv=none; b=Gbp8euGI040AdmL+7LLMTvmvQQCpRuW9v50j1OraH+Whuc6IHjYT9ym8keteQFahT7qdhVxqU4VEFeiqvYBXJM7rZ2HWYoS6lhpmE2n/h8bN6+qSo9dkHGIIGDRqM6tSOuUaUFLuVohkAfTfnar1hbqV6sNdxIZFxe9qqyNOMx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463999; c=relaxed/simple;
	bh=5gV6EVhEbMv0yAYpnYZRUXxjR+lELJinE6IjzP3XhuY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I4MdUneFQ7InxFXVKXAP4bqdPzTWp4Rv/gI33zbNKGfs1ErUoM/fjb+07ttRl/3d+1undhJeykbOGd7MntDMYvKOwH6mLbyXYtzzvE5s76DwgDTJSVcQtTV28oh1VyBWFJMyhis8qFgAwJXSjEATlJprYuCtFK4VkGesmuGwhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M0601OWg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711463998; x=1742999998;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5gV6EVhEbMv0yAYpnYZRUXxjR+lELJinE6IjzP3XhuY=;
  b=M0601OWgKcWkMSEQhf+UanEsh1onNdSGSIcesOEh3PKbbJR8JsNDOKr6
   9oR7jnv4bPXE+zvWCKEiToTNPL0R0nVX5IM2WLyGf3OANjCJVFKjCNHQW
   qrT6YzMYBQEjC0o8fsHFc1KJnhcIpxw/n+U901s0/NmjjU8vJzt7rj9qJ
   kN9tZ6ODDo/gXNg3Q/O83US5DyxpsZnS272xzLo/Oy7g86Ei24bxF7nG4
   EaBjHg8F7tbwc9d72JfWEj8cjbdlTunuiHBDDQ9wzg0ZBqNPtJUCkDfyg
   HdCqgpa77DHN6uHtVeMYgzXdirx7y0rM/CRKEgBsVBEy/X6FkNoSd1v2t
   Q==;
X-CSE-ConnectionGUID: MOV6N3BlQEywZ5a9s1hP2w==
X-CSE-MsgGUID: V6FpV/f2QVC9d1s3O2pjVQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10296697"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="10296697"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 07:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16412243"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 26 Mar 2024 07:39:54 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 404922819E;
	Tue, 26 Mar 2024 14:39:42 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jiri@resnulli.us,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	victor.raj@intel.com,
	michal.wilczynski@intel.com,
	lukasz.czapnik@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH net-next v8 0/6] ice: Support 5 layer Tx scheduler topology
Date: Tue, 26 Mar 2024 10:30:36 -0400
Message-Id: <20240326143042.9240-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For performance reasons there is a need to have support for selectable
Tx scheduler topology. Currently firmware supports only the default
9-layer and 5-layer topology. This patch series enables switch from
default to 5-layer topology, if user decides to opt-in.

---
v8:
- fixed all drivers to use new *set pointer - commit 1
- added setting flag in ice_copy_and_init_pkg based on family - commit 2
- changed the way of registering devlink param - commit 5
- changed the name of devlink param to be more descriptive - commit 5
- added RB in commit 1 and commit 6

v7:
- fixed comments from v6 in commit 1 (devlink changes) and commit 5 (ice_devlink changes)
- included Documentation change that should be in v6 (reboot -> PCI slot powercycle)
- added Reviewed-by tag to commit 1 (devlink changes) and commit 6 (Documentation)
https://lore.kernel.org/netdev/20240308113919.11787-1-mateusz.polchlopek@intel.com/

v6:
- extended devlink_param *set pointer to accept one more parameter - extack
- adjusted all drivers that use *set pointer to pass one more parameter
- updated Documentation - changed "reboot" to "PCI slot powercycle", kept Kuba's ACK
- removed "Error: " prefix from NL_SET_ERR_MSG_MOD function in ice_devlink.c
- removed/adjusted messages sent to end user in ice_devlink.c
https://lore.kernel.org/netdev/20240305143942.23757-1-mateusz.polchlopek@intel.com/

v5:
- updated Documentation commit as suggested in v4
https://lore.kernel.org/netdev/20240228142054.474626-1-mateusz.polchlopek@intel.com/

v4:
- restored the initial way of passing firmware data to ice_cfg_tx_topo
  function in ice_init_tx_topology function in ice_main.c file. In v2
  and v3 version it was passed as const u8 parameter which caused kernel
  crash. Because of this change I decided to drop all Reviewed-by tags.
https://lore.kernel.org/netdev/20240219100555.7220-1-mateusz.polchlopek@intel.com/

v3:
- fixed documentation warnings
https://lore.kernel.org/netdev/20231009090711.136777-1-mateusz.polchlopek@intel.com/

v2:
- updated documentation
- reorder of variables list (default-init first)
- comments changed to be more descriptive
- added elseif's instead of few if's
- returned error when ice_request_fw fails
- ice_cfg_tx_topo() changed to take const u8 as parameter (get rid of copy
  buffer)
- renamed all "balance" occurences to the new one
- prevent fail of ice_aq_read_nvm() function
- unified variables names (int err instead of int status in few
  functions)
- some smaller fixes, typo fixes
https://lore.kernel.org/netdev/20231006110212.96305-1-mateusz.polchlopek@intel.com/

v1:
https://lore.kernel.org/netdev/20230523174008.3585300-1-anthony.l.nguyen@intel.com/
---

Lukasz Czapnik (1):
  ice: Add tx_scheduling_layers devlink param

Mateusz Polchlopek (1):
  devlink: extend devlink_param *set pointer

Michal Wilczynski (2):
  ice: Enable switching default Tx scheduler topology
  ice: Document tx_scheduling_layers parameter

Raj Victor (2):
  ice: Support 5 layer topology
  ice: Adjust the VSI/Aggregator layers

 Documentation/networking/devlink/ice.rst      |  47 ++++
 .../marvell/octeontx2/otx2_cpt_devlink.c      |   9 +-
 drivers/net/ethernet/amd/pds_core/core.h      |   3 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |   3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   6 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  32 +++
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 205 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_devlink.c  | 184 +++++++++++++++-
 .../net/ethernet/intel/ice/ice_fw_update.c    |   7 +-
 .../net/ethernet/intel/ice/ice_fw_update.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 102 +++++++--
 drivers/net/ethernet/intel/ice/ice_nvm.c      |   7 +-
 drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_sched.c    |  37 ++--
 drivers/net/ethernet/intel/ice/ice_sched.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 .../marvell/octeontx2/af/rvu_devlink.c        |  12 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      |   3 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   3 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   3 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   3 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |   3 +-
 .../mellanox/mlxsw/spectrum_acl_tcam.c        |   3 +-
 .../ethernet/netronome/nfp/devlink_param.c    |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |   3 +-
 drivers/net/ethernet/ti/cpsw_new.c            |   6 +-
 drivers/net/wwan/iosm/iosm_ipc_devlink.c      |   3 +-
 include/net/devlink.h                         |   3 +-
 include/net/dsa.h                             |   3 +-
 net/devlink/param.c                           |   7 +-
 net/dsa/devlink.c                             |   3 +-
 35 files changed, 645 insertions(+), 84 deletions(-)

-- 
2.38.1


