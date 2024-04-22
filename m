Return-Path: <netdev+bounces-90263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9388AD5F2
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 22:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E51F21711
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B5D1B810;
	Mon, 22 Apr 2024 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDU/6AAO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD0A18EBF
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818367; cv=none; b=M6JEKnZ0Z1Jo2aaxN20pFAwVLY+zwLzxLh6x4FGvDiPzwNd+uQKrMHm2Ba6Xgg558PnXcITOGw6uT9oIA869sxtmu9j9eYcs9kTWBq3G4rIltq8n69DTl5SOK87dIH+TEr4KJt9FcqLSKpJuDU+lavpzvoFIu9lZhdoQv46qKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818367; c=relaxed/simple;
	bh=yGzXCTQLuFGboFNU9fqsJU1rJZDooPJdzKKKsyu8KRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4OPo53jvopBZ0d2fFAym1/yglPyTtpmRxaSG2GaU/MzV+jmLYPE5RwwxPs57y8jLP0lJOWur1vE6zBaSs2TlgeXSR+coJ+hyF+++2tk7lPktpwxrSE8rt8acGN3xiE5av3CRt9Sk10Eq43KUnopI24tX6V+kliMZHt4i53zPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDU/6AAO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713818365; x=1745354365;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yGzXCTQLuFGboFNU9fqsJU1rJZDooPJdzKKKsyu8KRQ=;
  b=gDU/6AAOxSEcLQMW4nTEIfGRtwkQ/wqb+BQM9wSbzISPFsC8v5G8Mpoj
   dNq6uKDTj8VraInEYFg4KW0xmOdWVsagtmkQKxqPQLld2z6V1HAb93kdc
   MY03vfMWXTCoUAoFoRqrEscbKbPlBtPRii9qfSHjn7JShBWkXQ5tsUw/9
   D9wPT6UwtO7YTxce7rlgscYhlSEhwPr8Y85sJidGL8MDcX83YG4IGHk1s
   r+pYhuQXobC2v8CzQz6jBheOaoN3QUC2GG5e8iF1GbE+JqgLPuibUdS6d
   KLtoo6rC+FnxRTpaH34CT5zSxIrBIaApxWVPYN6T8/M5FrbPBPtcDikz2
   w==;
X-CSE-ConnectionGUID: a/GOws8cTFq6/uzfU0RNmg==
X-CSE-MsgGUID: K+ehMpePTLCLgN73OSzw9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9244789"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="9244789"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 13:39:19 -0700
X-CSE-ConnectionGUID: uiafDrUEQp6dyf5eNDcuhw==
X-CSE-MsgGUID: vJHWl0b/RMqiEuje57nhjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="28945602"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 22 Apr 2024 13:39:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	mateusz.polchlopek@intel.com
Subject: [PATCH net-next 0/6][pull request] ice: Support 5 layer Tx scheduler topology
Date: Mon, 22 Apr 2024 13:39:05 -0700
Message-ID: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mateusz Polchlopek says:

For performance reasons there is a need to have support for selectable
Tx scheduler topology. Currently firmware supports only the default
9-layer and 5-layer topology. This patch series enables switch from
default to 5-layer topology, if user decides to opt-in.

The following are changes since commit c51db4ac10d57c366f9a92121e3889bfc6c324cd:
  tcp: do not export tcp_twsk_purge()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

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
 .../net/ethernet/intel/ice/devlink/devlink.c  | 184 ++++++++++++++-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  32 +++
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 209 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   2 +
 .../net/ethernet/intel/ice/ice_fw_update.c    |   7 +-
 .../net/ethernet/intel/ice/ice_fw_update.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 108 +++++++--
 drivers/net/ethernet/intel/ice/ice_nvm.c      |   7 +-
 drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_sched.c    |  37 ++--
 drivers/net/ethernet/intel/ice/ice_sched.h    |  11 +
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
 35 files changed, 663 insertions(+), 84 deletions(-)

-- 
2.41.0


