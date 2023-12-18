Return-Path: <netdev+bounces-58640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A7F817B5A
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 20:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD5284B84
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 19:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8C72062;
	Mon, 18 Dec 2023 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="caoe1X3M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98217205E
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702928917; x=1734464917;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gu3jqmXCkp3zRHKLCXtnpEnk936UDCQ/1VGV7w6q1XI=;
  b=caoe1X3MQN/+H3UYrZ/JwQ9AzdFq4lbD6pAyipH0DAIH4F+tE1qAt8dl
   jZGApoKCpjwA+vW2gIJIiu+BwOJ6D4UJe8GeLf9ccQ9xkE/t7gEwkRQZE
   fwp5/H11wifdMEgHbEtNy8scIO/APPcOqGk9QdXpXEw/Q6pDRbLcAWT1k
   IbpSWv6F2GLLRYK/9grB4ylOXKCN9SdDGkmZ1Xx2eVNxTOeSd4X7rIH5d
   FF55oaA0ReG+IvX8Ni7NUFLF2vw91LCL3lqmxabCwgGqyAqdaIQjg6edG
   hBAlTA7au01UqYF098BDXOUPblga4pDeIJoPfTXg1fNU32zTiyDgw/RZZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="394436774"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="394436774"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 11:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="23902060"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 18 Dec 2023 11:48:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jesse.brandeburg@intel.com
Subject: [PATCH net-next 00/15][pull request] intel: use bitfield operations
Date: Mon, 18 Dec 2023 11:48:15 -0800
Message-ID: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jesse Brandeburg says:

After repeatedly getting review comments on new patches, and sporadic
patches to fix parts of our drivers, we should just convert the Intel code
to use FIELD_PREP() and FIELD_GET().  It's then "common" in the code and
hopefully future change-sets will see the context and do-the-right-thing.

This conversion was done with a coccinelle script which is mentioned in the
commit messages. Generally there were only a couple conversions that were
"undone" after the automatic changes because they tried to convert a
non-contiguous mask.

Patch 1 is required at the beginning of this series to fix a "forever"
issue in the e1000e driver that fails the compilation test after conversion
because the shift / mask was out of range.

The second patch just adds all the new #includes in one go.

The patch titled: "ice: fix pre-shifted bit usage" is needed to allow the
use of the FIELD_* macros and fix up the unexpected "shifts included"
defines found while creating this series.

The rest are the conversion to use FIELD_PREP()/FIELD_GET(), and the
occasional leXX_{get,set,encode}_bits() call, as suggested by Alex.

The following are changes since commit 610a689d2a57af3e21993cb6d8c3e5f839a8c89e:
  Merge branch 'rtnl-rcu'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Jesse Brandeburg (15):
  e1000e: make lost bits explicit
  intel: add bit macro includes where needed
  intel: legacy: field prep conversion
  i40e: field prep conversion
  iavf: field prep conversion
  ice: field prep conversion
  ice: fix pre-shifted bit usage
  igc: field prep conversion
  intel: legacy: field get conversion
  igc: field get conversion
  i40e: field get conversion
  iavf: field get conversion
  ice: field get conversion
  ice: cleanup inconsistent code
  idpf: refactor some missing field get/prep conversions

 drivers/net/ethernet/intel/e1000/e1000_hw.c   |  46 ++-
 .../net/ethernet/intel/e1000e/80003es2lan.c   |  23 +-
 drivers/net/ethernet/intel/e1000e/82571.c     |   3 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |   7 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c   |  18 +-
 drivers/net/ethernet/intel/e1000e/mac.c       |   2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |  11 +-
 drivers/net/ethernet/intel/e1000e/phy.c       |  24 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c   |   7 +-
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c   |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c | 140 ++++-----
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    | 276 +++++++-----------
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   4 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  85 +++---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  14 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  70 ++---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  29 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c |  34 +--
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   8 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.c   |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  21 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  10 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |  32 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  54 ++--
 drivers/net/ethernet/intel/ice/ice_dcb.c      |  79 ++---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   4 +-
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |   3 +-
 drivers/net/ethernet/intel/ice/ice_fdir.c     |  69 ++---
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   8 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  54 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     |  48 ++-
 drivers/net/ethernet/intel/ice/ice_nvm.c      |  15 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  13 +-
 drivers/net/ethernet/intel/ice/ice_sched.c    |   3 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  41 +--
 drivers/net/ethernet/intel/ice/ice_switch.c   |  75 +++--
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   2 +-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  13 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  41 +--
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |   7 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  58 ++--
 drivers/net/ethernet/intel/igb/e1000_82575.c  |  29 +-
 drivers/net/ethernet/intel/igb/e1000_i210.c   |  19 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c    |   2 +-
 drivers/net/ethernet/intel/igb/e1000_nvm.c    |  18 +-
 drivers/net/ethernet/intel/igb/e1000_phy.c    |  17 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  11 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |  13 +-
 drivers/net/ethernet/intel/igbvf/mbx.c        |   1 +
 drivers/net/ethernet/intel/igbvf/netdev.c     |  33 +--
 drivers/net/ethernet/intel/igc/igc_base.c     |   6 +-
 drivers/net/ethernet/intel/igc/igc_i225.c     |   6 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |  10 +-
 drivers/net/ethernet/intel/igc/igc_phy.c      |   5 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |   2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  30 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |   8 +-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |  19 +-
 include/linux/avf/virtchnl.h                  |   1 +
 71 files changed, 734 insertions(+), 1016 deletions(-)

-- 
2.41.0


