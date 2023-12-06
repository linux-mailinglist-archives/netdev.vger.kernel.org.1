Return-Path: <netdev+bounces-54661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D8807C5D
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 00:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99CF282122
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 23:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D692EB12;
	Wed,  6 Dec 2023 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="juXgAdk8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6F5A9;
	Wed,  6 Dec 2023 15:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701905817; x=1733441817;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tg8VD3BdVgcoA6Qxss2dDoxNGvYlbM+Kh8VcAX5YFt8=;
  b=juXgAdk80/LCnZxwd5tTuD+64JMEirmqzMX+Miga27ijpuKU1wEIPZrS
   q4NvbkaosCssEAf/i41EqvY50vj6OO1uVQUnDQL2gFJy/go5E5iqB+YkF
   wFNxwQPFomcEeMNoLUgJz4Ofri6v4FiibX5w5VTcDEmxbPUnn3tL4lZOB
   98ytqDgO5zKQnh7wE+AjTErz0o+NbT8DlVQX4JJ5fqnJ5n8Rtvhmdjz6m
   tsImyzd69gvXGcy/3VUm2R9q+AdU7CYo5cDs7ikfQ0m3wySJqszUx5yCR
   glZTZH0z7kxbBrx3eSizM0HX1RlEVsgwEYMUvh94Xw2BYTok0KKx2RzvJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="379163787"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="379163787"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 15:36:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="771486245"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="771486245"
Received: from traguzov-mobl4.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.62.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 15:36:49 -0800
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
	ecree.xilinx@gmail.com,
	linux-doc@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v8 0/8] Support symmetric-xor RSS hash
Date: Wed,  6 Dec 2023 16:36:34 -0700
Message-Id: <20231206233642.447794-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches 1 and 2 modify the get/set_rxh ethtool API to take a pointer to 
struct of parameters instead of individual params. This will allow future
changes to the uAPI-shared struct ethtool_rxfh without changing the
drivers' API.

Patch 3 adds the support at the Kernel level, allowing the user to set a
symmetric-xor RSS hash for a netdevice via:

    # ethtool -X eth0 hfunc toeplitz symmetric-xor

and clears the flag via:

    # ethtool -X eth0 hfunc toeplitz

The "symmetric-xor" is set in a new "input_xfrm" field in struct
ethtool_rxfh. Support for the new "symmetric-xor" flag will be later sent
to the "ethtool" user-space tool.

Patch 4 fixes a long standing bug with the ice hash function register
values. The bug has been benign for now since only (asymmetric) Toeplitz
hash (Zero) has been used.

Patches 5 and 6 lay some groundwork refactoring. While the first is
mainly cosmetic, the second is needed since there is no more room in the
previous 64-bit RSS profile ID for the symmetric attribute introduced in 
the next patch.

Finally, patches 7 and 8 add the symmetric-xor support for the ice 
(E800 PFs) and the iAVF drivers.

---
v8: - Fix build failures on patchwork CI (make allmodconfig).
    - Move the new new struct ethtool_rxfh_params from include/uapi/linux/
      ethtool.h to include/linux/ethtool.h.
    - Add cap_rss_ctx_supported to ice.

v7: - Use new struct ethtool_rxfh_params to pass arguments to set/get_rxfh
    - Remove get/set_rxfh_context functions and use a new capability to 
      indicate RSS context support (cap_rss_ctx_supported).
    - Move the sanity checks on the rxnfc fields when symmetric-xor is set
      back to core.
    - Add a new capability (cap_rss_sym_xor_supported) to indicate
      symmetric-xor support. Core returns -ENOTSUPP if the driver does not
      support symmetric-xor.
    - Rename the new struct ethtool_rxfh field to "input_xfrm" and
      update "Documentation/networking/ethtool-netlink.rst" and 
      "Documentation/netlink/specs/ethtool.yaml".
    - Add a comment on potential vulnerability of symmetric-xor in
      include/uapi/linux/ethtool.h.

v6: switch user interface to "ethtool -X" (ethtool_rxfh) instead of
    "ethtool -N". Patch (1) is added to allow new params in the get/set_rxh
    ethtool API. Doc is updated in "Documentation/networking/scaling.rst"
    to specify how the "symmetric-xor" manipulates the input fields.
    https://lore.kernel.org/netdev/20231120205614.46350-2-ahmed.zaki@intel.com/T/

v5: move sanity checks from ethtool/ioctl.c to ice's and iavf's rxfnc
    drivers entries (patches 5 and 6).
    https://lore.kernel.org/netdev/20231018170635.65409-2-ahmed.zaki@intel.com/T/

v4: add a comment to "#define RXH_SYMMETRIC_XOR" (in uapi/linux/ethtool.h)
    https://lore.kernel.org/netdev/20231016154937.41224-1-ahmed.zaki@intel.com/T/

v3: rename "symmetric" to "symmetric-xor" and drop "Fixes" tag in patch 2.
v2: fixed a "Reviewed by" to "Reviewed-by", also need to cc maintainers.

Ahmed Zaki (6):
  net: ethtool: pass a pointer to parameters to get/set_rxfh ethtool ops
  net: ethtool: get rid of get/set_rxfh_context functions
  net: ethtool: add support for symmetric-xor RSS hash
  ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values
  ice: refactor the FD and RSS flow ID generation
  iavf: enable symmetric-xor RSS for Toeplitz hash function

Jeff Guo (1):
  ice: enable symmetric-xor RSS for Toeplitz hash function

Qi Zhang (1):
  ice: refactor RSS configuration

 Documentation/netlink/specs/ethtool.yaml      |   4 +
 Documentation/networking/ethtool-netlink.rst  |   6 +-
 Documentation/networking/scaling.rst          |  15 +
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  28 +-
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |  33 +-
 .../ethernet/aquantia/atlantic/aq_ethtool.c   |  31 +-
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |  25 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  28 +-
 drivers/net/ethernet/broadcom/tg3.c           |  22 +-
 .../ethernet/cavium/thunder/nicvf_ethtool.c   |  31 +-
 .../ethernet/chelsio/cxgb4/cxgb4_ethtool.c    |  24 +-
 .../net/ethernet/cisco/enic/enic_ethtool.c    |  25 +-
 .../net/ethernet/emulex/benet/be_ethtool.c    |  28 +-
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  31 +-
 .../ethernet/fungible/funeth/funeth_ethtool.c |  40 +-
 .../net/ethernet/hisilicon/hns/hns_ethtool.c  |  17 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  23 +-
 .../net/ethernet/huawei/hinic/hinic_ethtool.c |  40 +-
 .../net/ethernet/intel/fm10k/fm10k_ethtool.c  |  26 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  38 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |   5 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.c    |   8 +-
 .../net/ethernet/intel/iavf/iavf_adv_rss.h    |   3 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  74 ++-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   4 +
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  41 ++
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   8 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 106 ++--
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
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  40 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c  |  27 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  27 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  35 +-
 drivers/net/ethernet/intel/ixgbevf/ethtool.c  |  27 +-
 drivers/net/ethernet/marvell/mvneta.c         |  25 +-
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  79 +--
 .../marvell/octeontx2/nic/otx2_ethtool.c      |  80 ++-
 .../net/ethernet/mellanox/mlx4/en_ethtool.c   |  40 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  43 +-
 .../net/ethernet/microchip/lan743x_ethtool.c  |  34 +-
 .../ethernet/microsoft/mana/mana_ethtool.c    |  33 +-
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  |  38 +-
 .../ethernet/pensando/ionic/ionic_ethtool.c   |  26 +-
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  32 +-
 drivers/net/ethernet/sfc/ef100_ethtool.c      |   3 +-
 drivers/net/ethernet/sfc/ethtool.c            |   3 +-
 drivers/net/ethernet/sfc/ethtool_common.c     | 126 ++---
 drivers/net/ethernet/sfc/ethtool_common.h     |  13 +-
 drivers/net/ethernet/sfc/falcon/ethtool.c     |  26 +-
 drivers/net/ethernet/sfc/siena/ethtool.c      |   3 +-
 .../net/ethernet/sfc/siena/ethtool_common.c   | 126 ++---
 .../net/ethernet/sfc/siena/ethtool_common.h   |  13 +-
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  31 +-
 drivers/net/hyperv/netvsc_drv.c               |  32 +-
 drivers/net/virtio_net.c                      |  29 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c         |  22 +-
 include/linux/avf/virtchnl.h                  |  35 +-
 include/linux/ethtool.h                       |  60 ++-
 include/uapi/linux/ethtool.h                  |  13 +-
 include/uapi/linux/ethtool_netlink.h          |   1 +
 net/ethtool/common.c                          |  12 +-
 net/ethtool/ioctl.c                           | 218 ++++----
 net/ethtool/rss.c                             |  55 +-
 79 files changed, 1866 insertions(+), 1267 deletions(-)

-- 
2.34.1


