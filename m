Return-Path: <netdev+bounces-49794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E60B77F3805
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 22:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE9BB218C7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035955466F;
	Tue, 21 Nov 2023 21:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJ0jkGZa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9131819E
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 13:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700601579; x=1732137579;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Qft3Kif2jDd7FcxoyFTaYULEq5BlIfAq0P2rkH/uL0=;
  b=PJ0jkGZaZ3cOZxrtUKUtmQDYBZwqu40J/Xk5AcK3YZRQozRLNrsAOQVv
   m4LQAzfOSIpo8xowrKbe7/ITdhlV+dPOi9q5fdTZvLbiDc810LvIZxrPg
   SZBqfrVO9QcgRK4HO1B5a6vB+qMBj1zqyPpf0+aJAg7YanuGJMjADtgQ1
   /dU3ESoZXdnn+DRW0Crh47gu/PhRZN7TmX7HIHwHy8k8GJLwuqcuONV7p
   eF8uL55MEjqx/ckJV2Ni7MGtWw4tPLLbTnk+H2edDYlwFECz8AqCX0g7t
   eFeZIqSPBunc4ysf1zzyDW460/4YX+m8N9mE7NnPn3OCWK+7EpICWvVth
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="423022062"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="423022062"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:19:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716630528"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="716630528"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 13:19:37 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v1 00/13] intel: use FIELD_PREP and FIELD_GET
Date: Tue, 21 Nov 2023 13:19:08 -0800
Message-Id: <20231121211921.19834-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

The rest are the conversion to use FIELD_PREP()/FIELD_GET().

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Jesse Brandeburg (13):
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

 drivers/net/ethernet/intel/e1000/e1000_hw.c   |  46 ++-
 .../net/ethernet/intel/e1000e/80003es2lan.c   |  23 +-
 drivers/net/ethernet/intel/e1000e/82571.c     |   3 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |   7 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c   |  18 +-
 drivers/net/ethernet/intel/e1000e/mac.c       |   8 +-
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
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  27 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c |  34 +--
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |   8 +-
 drivers/net/ethernet/intel/iavf/iavf_fdir.c   |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  21 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  18 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |  32 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  38 ++-
 drivers/net/ethernet/intel/ice/ice_dcb.c      |  77 ++---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   4 +-
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |   3 +-
 drivers/net/ethernet/intel/ice/ice_fdir.c     |  69 ++---
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |   8 +-
 drivers/net/ethernet/intel/ice/ice_flow.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  64 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     |  48 ++-
 drivers/net/ethernet/intel/ice/ice_nvm.c      |  15 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  13 +-
 drivers/net/ethernet/intel/ice/ice_sched.c    |   3 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  41 +--
 drivers/net/ethernet/intel/ice/ice_switch.c   |  61 ++--
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  14 +-
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  15 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  35 +--
 drivers/net/ethernet/intel/igb/e1000_82575.c  |  29 +-
 drivers/net/ethernet/intel/igb/e1000_i210.c   |  19 +-
 drivers/net/ethernet/intel/igb/e1000_mac.c    |   7 +-
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
 69 files changed, 705 insertions(+), 978 deletions(-)

-- 
2.39.3


