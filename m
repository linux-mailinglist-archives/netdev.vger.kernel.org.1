Return-Path: <netdev+bounces-49394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2177F1E51
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0D51F25A13
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A9A249FC;
	Mon, 20 Nov 2023 20:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+ZBHUw2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7A0E7;
	Mon, 20 Nov 2023 12:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700513788; x=1732049788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wGwsgnA/t7SrzMu/qCHumWhoQ9pMGfMRuWcha0iwNfg=;
  b=P+ZBHUw2W0qCCHhex0BEfwi+Iw78mptH9vBTNNS8hG6BOA3tN9axMIOZ
   Lpdqc3wSr7zm1rFvtx46UtOyiweS5X5nypJiWhEoPTy+XABLdstk6RxAw
   CmHcCg1iIIsFF7d4+Bj7UmOhOl0ICld/Yj5o210DlGv3QM2uBCl4QO74x
   jtIo1DdXme7CGRaHAjI24MoHbJu5T+0V7Q/5fRjlHMCKc6z3wpgoDUnvd
   wUSjQiJNTcxr83mLH/2Nmz9BU3pTs+uRUjmK1MeESVFj0lNjZxMufGVAG
   ZdhHT3llDD5/rtw+NhxIRUx1ldpAphCiZcYvzk0Ies6hySq4h6CcU7dZ6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="391484208"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="391484208"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:56:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="857106100"
X-IronPort-AV: E=Sophos;i="6.04,214,1695711600"; 
   d="scan'208";a="857106100"
Received: from cchircul-mobl2.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.249.46.122])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 12:56:22 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	andrew@lunn.ch,
	horms@kernel.org,
	mkubecek@suse.cz,
	willemdebruijn.kernel@gmail.com,
	gal@nvidia.com,
	alexander.duyck@gmail.com,
	linux-doc@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v6 0/7] Support symmetric-xor RSS hash
Date: Mon, 20 Nov 2023 13:56:07 -0700
Message-Id: <20231120205614.46350-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 modifies the set_rxh ethtool API to take a pointer to struct
ethtool_rxfh instead of individual params. This will allow future 
changes to the struct without changing the API.

Patch 2 adds the support at the Kernel level, allowing the user to set a
symmetric-xor RSS hash for a netdevice via:

    # ethtool -X eth0 hfunc toeplitz symmetric-xor

and clears the flag via:

    # ethtool -X eth0 hfunc toeplitz

The "symmetric-xor" is set in a new "data" field in struct ethtool_rxfh.
Support for the new "symmetric-xor" flag will be later sent to the
"ethtool" user-space tool.

Patch 3 fixes a long standing bug with the ice hash function register
values. The bug has been benign for now since only (asymmetric) Toeplitz
hash (Zero) has been used.

Patches 4 and 5 lay some groundwork refactoring. While the first is
mainly cosmetic, the second is needed since there is no more room in the
previous 64-bit RSS profile ID for the symmetric attribute introduced in 
the next patch.

Finally, patches 6 and 7 add the symmetric-xor support for the ice 
(E800 PFs) and the iAVF drivers.

---
v6: switch user interface to "ethtool -X" (ethtool_rxfh) instead of
    "ethtool -N". Patch (1) is added to allow new params in the get/set_rxh
    ethtool API. Doc is updated in "Documentation/networking/scaling.rst"
    to specify how the "symmetric-xor" manipulates the input fields.

v5: move sanity checks from ethtool/ioctl.c to ice's and iavf's rxfnc
    drivers entries (patches 5 and 6).
    https://lore.kernel.org/netdev/20231018170635.65409-2-ahmed.zaki@intel.com/T/

v4: add a comment to "#define RXH_SYMMETRIC_XOR" (in uapi/linux/ethtool.h)
    https://lore.kernel.org/netdev/20231016154937.41224-1-ahmed.zaki@intel.com/T/

v3: rename "symmetric" to "symmetric-xor" and drop "Fixes" tag in patch 2.
v2: fixed a "Reviewed by" to "Reviewed-by", also need to cc maintainers.

Ahmed Zaki (5):
  net: ethtool: pass ethtool_rxfh to get/set_rxfh ethtool ops
  net: ethtool: add support for symmetric-xor RSS hash
  ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values
  ice: refactor the FD and RSS flow ID generation
  iavf: enable symmetric-xor RSS for Toeplitz hash function

Jeff Guo (1):
  ice: enable symmetric-xor RSS for Toeplitz hash function

Qi Zhang (1):
  ice: refactor RSS configuration

 Documentation/networking/scaling.rst          |  15 +
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  13 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |  15 +-
 .../ethernet/aquantia/atlantic/aq_ethtool.c   |  17 +-
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  15 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  14 +-
 drivers/net/ethernet/broadcom/tg3.c           |  14 +-
 .../ethernet/cavium/thunder/nicvf_ethtool.c   |  15 +-
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    |  14 +-
 .../net/ethernet/cisco/enic/enic_ethtool.c    |  15 +-
 .../net/ethernet/emulex/benet/be_ethtool.c    |  15 +-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  12 +-
 .../ethernet/fungible/funeth/funeth_ethtool.c |  18 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  15 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  19 +-
 .../net/ethernet/huawei/hinic/hinic_ethtool.c |  20 +-
 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  |  15 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  19 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |   5 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |   8 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |   3 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  60 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   4 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  41 ++
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   8 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  74 ++-
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  35 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.c    |  44 +-
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |   4 +-
 .../net/ethernet/intel/ice/ice_flex_type.h    |   7 +
 drivers/net/ethernet/intel/ice/ice_flow.c     | 482 +++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_flow.h     |  60 ++-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   4 +
 drivers/net/ethernet/intel/ice/ice_lib.c      | 116 ++---
 drivers/net/ethernet/intel/ice/ice_main.c     |  58 ++-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 105 +++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   1 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   1 +
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  35 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  19 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  15 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  16 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  15 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |   9 +-
 drivers/net/ethernet/marvell/mvneta.c         |  17 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  17 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |  14 +-
 .../net/ethernet/mellanox/mlx4/en_ethtool.c   |  20 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   7 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  12 +-
 .../net/ethernet/microchip/lan743x_ethtool.c  |  14 +-
 .../ethernet/microsoft/mana/mana_ethtool.c    |  15 +-
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  |  21 +-
 .../ethernet/pensando/ionic/ionic_ethtool.c   |  15 +-
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  14 +-
 drivers/net/ethernet/sfc/ethtool_common.c     |  15 +-
 drivers/net/ethernet/sfc/ethtool_common.h     |   8 +-
 drivers/net/ethernet/sfc/falcon/ethtool.c     |  17 +-
 .../net/ethernet/sfc/siena/ethtool_common.c   |  17 +-
 .../net/ethernet/sfc/siena/ethtool_common.h   |   7 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  15 +-
 drivers/net/hyperv/netvsc_drv.c               |  15 +-
 drivers/net/virtio_net.c                      |  13 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c         |  14 +-
 include/linux/avf/virtchnl.h                  |  35 +-
 include/linux/ethtool.h                       |   8 +-
 include/uapi/linux/ethtool.h                  |  12 +-
 include/uapi/linux/ethtool_netlink.h          |   1 +
 net/ethtool/common.c                          |   2 +-
 net/ethtool/ioctl.c                           |  28 +-
 net/ethtool/rss.c                             |  14 +-
 74 files changed, 1263 insertions(+), 637 deletions(-)

-- 
2.34.1


