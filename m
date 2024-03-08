Return-Path: <netdev+bounces-78709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF49876393
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924091C2083D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF16535B7;
	Fri,  8 Mar 2024 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6wySnS4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD621DA21
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898446; cv=none; b=iqda6cR7lVLaSBaYhqoH+4EI3B/b4cR75msMbZUoAIqy0hQk8jEIZDzsFhNh0vaH+C0G9oO2hhqnwGRU+HcCbCaag6XjqtPcnWrhpnh8gjsv+2JEMXWummC1IsBrnwingcV+fl4s3l4/eQGyR74zk/4ScT9hd2ZbWc/wMSViEFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898446; c=relaxed/simple;
	bh=5/6gIpu665kaDySqjr476UgYPYR2H9SQ0vvqIgW0f/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cn96mY5GRFnA+Cnt3HZRM7+GL6yDs6PXXZZda+s6PeZ+d//Ht7YcU+PQv9GaUUF+SP14DUQCwTFcPaf7GPw9J5XkNs3ivYxgDk207VXeN2CmEwcXA3sPE39Ne/JmGu7qOH8SWm4uZp9zVmMhXtpEjrYQZBBlk4QAs0LIHwxySrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6wySnS4; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709898445; x=1741434445;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5/6gIpu665kaDySqjr476UgYPYR2H9SQ0vvqIgW0f/c=;
  b=d6wySnS4osoft1cUYqo/CtYpsap3Uc6V+IZX+J9fcXKxp49ouynQIY++
   HCUoyacEUvG13fQq5S9vqsQIXrH57ZLb0rP7KdNyuL2TuC0ufkmt/0jnU
   yH8W1iiXQKMmSfdqBPPIvfr11VKMo9ZZtTI7VjEll93lAeMNJmFC6ki0i
   9/LHwiIxPGK0PfxY910G7Xe4G3MxUVWBoH+aM3x2KUn25g+7Y3DTWGXre
   yhMz7U+gDmWDRHx2+DJQarUGMXL/IGnt/3f0zuhAvzlpRxlGnvN53lXMw
   VzxFqq5bJOXOsFXBzjtnCvuj6cNwiI2Y3FUNV3M14nd3drbstKGuhCkfB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="7559149"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="7559149"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 03:47:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="10341758"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 03:47:21 -0800
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id AF92D3496B;
	Fri,  8 Mar 2024 11:47:18 +0000 (GMT)
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
Subject: [Intel-wired-lan] [PATCH iwl-next v7 0/6] ice: Support 5 layer Tx scheduler topology
Date: Fri,  8 Mar 2024 06:39:13 -0500
Message-Id: <20240308113919.11787-1-mateusz.polchlopek@intel.com>
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

I sent it again to iwl list, because we need to test that change,
devlink change is rather mechanical. @Tony - who should send it to
netdev list after getting Tested-by tag from our Validation?

---
v7:
- fixed comments from v6 in commit 1 and commit 5
- included Documentation change that should be in v6 (reboot -> PCI slot powercycle)
- added Reviewed-by tag to commit 1 and commit 6

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

 Documentation/networking/devlink/ice.rst      |  47 +++++
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   6 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  32 +++
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 199 ++++++++++++++++++
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
 drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   3 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   3 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   3 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |   3 +-
 .../mellanox/mlxsw/spectrum_acl_tcam.c        |   3 +-
 .../ethernet/netronome/nfp/devlink_param.c    |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |   3 +-
 drivers/net/wwan/iosm/iosm_ipc_devlink.c      |   3 +-
 include/net/devlink.h                         |   3 +-
 include/net/dsa.h                             |   3 +-
 net/devlink/param.c                           |   7 +-
 net/dsa/devlink.c                             |   3 +-
 28 files changed, 614 insertions(+), 70 deletions(-)

-- 
2.38.1


