Return-Path: <netdev+bounces-29511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A141C783892
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 05:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3681C209E2
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 03:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C782915C4;
	Tue, 22 Aug 2023 03:35:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47047F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 03:35:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A6187
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 20:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692675327; x=1724211327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IDjHvJCkgR9BZBy8I0QPXQ6ytxuhXb3xADP+6B5/38E=;
  b=JWYdekJYJDeVmNIwOQ7BXV3LZzpepHyv2hRenVpJojkm46ysisOw0auw
   szqRqTPKtJ+0amGP+ry+4152G45vV3Xsr8Ez9b8rlzVZ18bg/Lpg3mTTb
   dSpMGKJU7pKbMF/Par/BVB7hCYbwRwdqPOT4mCpKqFsyU0cgsEIh6e0DM
   VHWxvgEwBE+K58eV8vvsKLyPLmLIolAh+fQsKW/PraZkiGZNkPVCuBtNM
   bRGzt9EAFVe81P3HSVp7y2/Ru9/pZDYDHwDMYlnLOtvYwqPsdU6ez9bRf
   P+acX11+NmpJVNcWA+QMdieX8UZju8qA2KeeTvv/UeBcYwgRWDSCC/8Ws
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373738202"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="373738202"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 20:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="739149337"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="739149337"
Received: from dpdk-wuwenjun-icelake-ii.sh.intel.com ([10.67.110.152])
  by fmsmga007.fm.intel.com with ESMTP; 21 Aug 2023 20:35:24 -0700
From: Wenjun Wu <wenjun1.wu@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: xuejun.zhang@intel.com,
	madhu.chittim@intel.com,
	qi.z.zhang@intel.com,
	anthony.l.nguyen@intel.com,
	Wenjun Wu <wenjun1.wu@intel.com>
Subject: [PATCH iwl-next v4 0/5] iavf: Add devlink and devlink rate support
Date: Tue, 22 Aug 2023 11:39:58 +0800
Message-Id: <20230822034003.31628-1-wenjun1.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727021021.961119-1-wenjun1.wu@intel.com>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To allow user to configure queue bandwidth, devlink port support
is added to support devlink port rate API. [1]

Add devlink framework registration/unregistration on iavf driver
initialization and remove, and devlink port of DEVLINK_PORT_FLAVOUR_VIRTUAL
is created to be associated iavf netdevice.

iavf rate tree with root node, queue nodes, and leaf node is created
and registered with devlink rate when iavf adapter is configured, and
if PF indicates support of VIRTCHNL_VF_OFFLOAD_QOS through VF Resource /
Capability Exchange.

[root@localhost ~]# devlink port function rate show
pci/0000:af:01.0/txq_15: type node parent iavf_root
pci/0000:af:01.0/txq_14: type node parent iavf_root
pci/0000:af:01.0/txq_13: type node parent iavf_root
pci/0000:af:01.0/txq_12: type node parent iavf_root
pci/0000:af:01.0/txq_11: type node parent iavf_root
pci/0000:af:01.0/txq_10: type node parent iavf_root
pci/0000:af:01.0/txq_9: type node parent iavf_root
pci/0000:af:01.0/txq_8: type node parent iavf_root
pci/0000:af:01.0/txq_7: type node parent iavf_root
pci/0000:af:01.0/txq_6: type node parent iavf_root
pci/0000:af:01.0/txq_5: type node parent iavf_root
pci/0000:af:01.0/txq_4: type node parent iavf_root
pci/0000:af:01.0/txq_3: type node parent iavf_root
pci/0000:af:01.0/txq_2: type node parent iavf_root
pci/0000:af:01.0/txq_1: type node parent iavf_root
pci/0000:af:01.0/txq_0: type node parent iavf_root
pci/0000:af:01.0/iavf_root: type node


                         +---------+
                         |   root  |
                         +----+----+
                              |
            |-----------------|-----------------|
       +----v----+       +----v----+       +----v----+
       |  txq_0  |       |  txq_1  |       |  txq_x  |
       +----+----+       +----+----+       +----+----+

User can configure the tx_max and tx_share of each queue. Once any one of the
queues are fully configured, VIRTCHNL opcodes of VIRTCHNL_OP_CONFIG_QUEUE_BW
and VIRTCHNL_OP_CONFIG_QUANTA will be sent to PF to configure queues allocated
to VF

Example:

1.To Set the queue tx_share:
devlink port function rate set pci/0000:af:01.0 txq_0 tx_share 100 MBps

2.To Set the queue tx_max:
devlink port function rate set pci/0000:af:01.0 txq_0 tx_max 200 MBps

3.To Show Current devlink port rate info:
devlink port function rate function show
[root@localhost ~]# devlink port function rate show
pci/0000:af:01.0/txq_15: type node parent iavf_root
pci/0000:af:01.0/txq_14: type node parent iavf_root
pci/0000:af:01.0/txq_13: type node parent iavf_root
pci/0000:af:01.0/txq_12: type node parent iavf_root
pci/0000:af:01.0/txq_11: type node parent iavf_root
pci/0000:af:01.0/txq_10: type node parent iavf_root
pci/0000:af:01.0/txq_9: type node parent iavf_root
pci/0000:af:01.0/txq_8: type node parent iavf_root
pci/0000:af:01.0/txq_7: type node parent iavf_root
pci/0000:af:01.0/txq_6: type node parent iavf_root
pci/0000:af:01.0/txq_5: type node parent iavf_root
pci/0000:af:01.0/txq_4: type node parent iavf_root
pci/0000:af:01.0/txq_3: type node parent iavf_root
pci/0000:af:01.0/txq_2: type node parent iavf_root
pci/0000:af:01.0/txq_1: type node parent iavf_root
pci/0000:af:01.0/txq_0: type node tx_share 800Mbit tx_max 1600Mbit parent iavf_root
pci/0000:af:01.0/iavf_root: type node


[1]https://lore.kernel.org/netdev/20221115104825.172668-1-michal.wilczynski@intel.com/

Change log:

v4:
- Rearrange the ice_vf_qs_bw structure, put the largest number first
- Minimize the scope of values
- Remove the unnecessary brackets
- Remove the unnecessary memory allocation.
- Added Error Code and moved devlink registration before aq lock initialization
- Changed devlink registration for error handling in case of allocation failure
- Used kcalloc for object array memory allocation and initialization
- Changed functions & comments for readability

v3:
- Rebase the code
- Changed rate node max/share set function description
- Put variable in local scope

v2:
- Change static array to flex array
- Use struct_size helper
- Align all the error code types in the function
- Move the register field definitions to the right place in the file
- Fix coding style
- Adapted to queue bw cfg and qos cap list virtchnl message with flex array fields
---

Jun Zhang (3):
  iavf: Add devlink and devlink port support
  iavf: Add devlink port function rate API support
  iavf: Add VIRTCHNL Opcodes Support for Queue bw Setting

Wenjun Wu (2):
  virtchnl: support queue rate limit and quanta size configuration
  ice: Support VF queue rate limit and quanta size configuration

 drivers/net/ethernet/intel/Kconfig            |   1 +
 drivers/net/ethernet/intel/iavf/Makefile      |   2 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  19 +
 .../net/ethernet/intel/iavf/iavf_devlink.c    | 377 ++++++++++++++++++
 .../net/ethernet/intel/iavf/iavf_devlink.h    |  38 ++
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  64 ++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 231 ++++++++++-
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_base.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  19 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   8 +
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   2 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   9 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 310 ++++++++++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |  11 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
 include/linux/avf/virtchnl.h                  | 119 ++++++
 18 files changed, 1218 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_devlink.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_devlink.h

-- 
2.34.1


