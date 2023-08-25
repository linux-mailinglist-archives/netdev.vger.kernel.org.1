Return-Path: <netdev+bounces-30800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BAC78928D
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C5441C2101C
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 00:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B61AA98;
	Sat, 26 Aug 2023 00:00:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC477198AA
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 00:00:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB26DE7F
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 17:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693008004; x=1724544004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o6irk8ENyv3jxEfPPNI9RPiiXHb1/SE4eUKequVICu0=;
  b=ZmU1YXn++2Fj5iQ7yWsZ4rE7rSv/Tj3Izp2+alLquftTwQWzd1Ayspgm
   X+oFdor+S+PBSafFNwNYshAzFOgLE8PG8FfA4A7Uw9WsfZe2hfHF+skgm
   hORWBhdj8PE/xozGXMi6A8/Ltcx3yckvKEPQ9rsUmrii9f//2EYmhdHKm
   etqsz8tIlHHU1mee/FiI1q0XP0wUKw4ysl0CPNVHPvOfBCPK3piL+RkQB
   BbjQ1w9m35QgfoahrtiwyfMiwnTcsSsImWHfGKpKWIjVsfeHuQgLKFfgi
   deZF8yvr/t39q+fQG5ls2ajOjHwqcXLvO5qHMfzSIvPDWv0582E1islcB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="377565923"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="377565923"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 17:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="1068400131"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="1068400131"
Received: from unknown (HELO lo0-100.bstnma-vfttp-361.verizon-gni.com) ([10.166.80.24])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2023 17:00:01 -0700
From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	sridhar.samudrala@intel.com,
	emil.s.tantilov@intel.com,
	joshua.a.hay@intel.com,
	alan.brady@intel.com,
	madhu.chittim@intel.com,
	shiraz.saleem@intel.com,
	sindhu.devale@intel.com,
	willemb@google.com,
	decot@google.com,
	agtucker@google.com,
	andrew@lunn.ch,
	leon@kernel.org,
	mst@redhat.com,
	simon.horman@corigine.com,
	shannon.nelson@amd.com,
	stephen@networkplumber.org,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Subject: [PATCH net-next v6 00/15] Introduce Intel IDPF driver
Date: Fri, 25 Aug 2023 16:59:39 -0700
Message-Id: <20230825235954.894050-1-pavan.kumar.linga@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series introduces the Intel Infrastructure Data Path Function
(IDPF) driver. It is used for both physical and virtual functions. Except
for some of the device operations the rest of the functionality is the
same for both PF and VF. IDPF uses virtchnl version2 opcodes and
structures defined in the virtchnl2 header file which helps the driver
to learn the capabilities and register offsets from the device
Control Plane (CP) instead of assuming the default values.

The format of the series follows the driver init flow to interface open.
To start with, probe gets called and kicks off the driver initialization
by spawning the 'vc_event_task' work queue which in turn calls the
'hard reset' function. As part of that, the mailbox is initialized which
is used to send/receive the virtchnl messages to/from the CP. Once that is
done, 'core init' kicks in which requests all the required global resources
from the CP and spawns the 'init_task' work queue to create the vports.

Based on the capability information received, the driver creates the said
number of vports (one or many) where each vport is associated to a netdev.
Also, each vport has its own resources such as queues, vectors etc.
From there, rest of the netdev_ops and data path are added.

IDPF implements both single queue which is traditional queueing model
as well as split queue model. In split queue model, it uses separate queue
for both completion descriptors and buffers which helps to implement
out-of-order completions. It also helps to implement asymmetric queues,
for example multiple RX completion queues can be processed by a single
RX buffer queue and multiple TX buffer queues can be processed by a
single TX completion queue. In single queue model, same queue is used
for both descriptor completions as well as buffer completions. It also
supports features such as generic checksum offload, generic receive
offload (hardware GRO) etc.
---
Note:
 * Reported kernel-doc issues regarding missing enum description and
   DEFINE_DMA_UNMAP_[ADDR|LEN] have fixes submitted to documentation tree:
   https://lore.kernel.org/linux-doc/20230815210417.98749-1-pavan.kumar.linga@intel.com/
 * 'Acked-by' is only added to patch 1, 2, 12 and not to the other
   patches because of the changes in v6

v6:
Patch 3, 4, 5, 6, 7, 8, 9, 11, 13, 14, 15:
 * renamed 'reset_lock' to 'vport_ctrl_lock' to reflect the lock usage
 * to avoid defensive programming, used 'vport_ctrl_lock' for the user
   callbacks that access the 'vport' to prevent the hardware reset thread
   from releasing the 'vport', when the user callback is in progress
 * added some variables to netdev private structure to avoid vport access
   if possible from ethtool and ndo callbacks
 * moved 'mac_filter_list_lock' and MAC related flags to vport_config
   structure and refactored mac filter flow to handle asynchronous
   ndo mac filter callbacks
 * stop the queues before starting the reset flow to avoid TX hangs
 * removed 'sw_mutex' and 'stop_mutex' as they are not needed anymore
 * added missing clear bit in 'init_task' error path
 * renamed labels appropriately
Patch 8:
 * replaced page_pool_put_page with page_pool_put_full_page
 * for the page pool max_len, used PAGE_SIZE
Patch 10, 11, 13:
 * made use of the 'netif_txq_maybe_stop', '__netif_txq_completed_wake'
   helper macros
Patch 13:
 * removed IDPF_HR_RESET_IN_PROG flag check in idpf_tx_singleq_start
   as it is defensive
Patch 14:
 * removed max descriptor check as the core does that
 * removed unnecessary error messages
 * removed the stats that are common between the ones reported by ethtool
   and ip link
 * replaced snprintf with ethtool_sprintf
 * added a comment to explain the reason for the max queue check
 * as the netdev queues are set on alloc, there is no need to set
   them again on reset unless there is a queue change, so move the
   'idpf_set_real_num_queues' to 'idpf_initiate_soft_reset'
 Patch 15:
 * reworded the 'configure SRIOV' in the commit message

v5: https://lore.kernel.org/netdev/20230816004305.216136-1-anthony.l.nguyen@intel.com/
Most Patches:
 * wrapped line limit to 80 chars to those which don't effect readability
Patch 12:
 * in skb_add_rx_frag, offset 'headlen' w.r.t page_offset when adding a
   frag to avoid adding the header again
Patch 14:
 * added NULL check for 'rxq' when dereferencing it in page_pool_get_stats

v4: https://lore.kernel.org/netdev/20230808003416.3805142-1-anthony.l.nguyen@intel.com/
Patch 1:
 * s/virtcnl/virtchnl
 * removed the kernel doc for the error code definitions that don't exist
 * reworded the summary part in the virtchnl2 header
Patch 3:
 * don't set local variable to NULL on error
 * renamed sq_send_command_out label with err_unlock
 * don't use __GFP_ZERO in dma_alloc_coherent
Patch 4:
 * introduced mailbox workqueue to process mailbox interrupts
Patch 3, 4, 5, 6, 7, 8, 9, 11, 15:
 * removed unnecessary variable 0-init
Patch 3, 5, 7, 8, 9, 15:
 * removed defensive programming checks wherever applicable
 * removed IDPF_CAP_FIELD_LAST as it can be treated as defensive
   programming
Patch 3, 4, 5, 6, 7:
 * replaced IDPF_DFLT_MBX_BUF_SIZE with IDPF_CTLQ_MAX_BUF_LEN
Patch 2 to 15:
 * add kernel-doc for idpf.h and idpf_txrx.h enums and structures
Patch 4, 5, 15:
 * adjusted the destroy sequence of the workqueues as per the alloc
   sequence
Patch 4, 5, 9, 15:
 * scrub unnecessary flags in 'idpf_flags'
   - IDPF_REMOVE_IN_PROG flag can take care of the cases where
     IDPF_REL_RES_IN_PROG is used, removed the later one
   - IDPF_REQ_[TX|RX]_SPLITQ are replaced with struct variables
   - IDPF_CANCEL_[SERVICE|STATS]_TASK are redundant as the work queue
     doesn't get rescheduled again after 'cancel_delayed_work_sync'
   - IDPF_HR_CORE_RESET is removed as there is no set_bit for this flag
   - IDPF_MB_INTR_TRIGGER is removed as it is not needed anymore with the
     mailbox workqueue implementation
Patch 7 to 15:
 * replaced the custom buffer recycling code with page pool API
 * switched the header split buffer allocations from using a bunch of
   pages to using one large chunk of DMA memory
 * reordered some of the flows in vport_open to support page pool
Patch 8, 12:
 * don't suppress the alloc errors by using __GFP_NOWARN
Patch 9:
 * removed dyn_ctl_clrpba_m as it is not being used
Patch 14:
 * introduced enum idpf_vport_reset_cause instead of using vport flags
 * introduced page pool stats

v3: https://lore.kernel.org/netdev/20230616231341.2885622-1-anthony.l.nguyen@intel.com/
Patch 5:
 * instead of void, used 'struct virtchnl2_create_vport' type for
   vport_params_recvd and vport_params_reqd and removed the typecasting
 * used u16/u32 as needed instead of int for variables which cannot be
   negative and updated in all the places whereever applicable
Patch 6:
 * changed the commit message to "add ptypes and MAC filter support"
 * used the sender Signed-off-by as the last tag on all the patches
 * removed unnecessary variables 0-init
 * instead of fixing the code in this commit, fixed it in the commit
   where the change was introduced first
 * moved get_type_info struct on to the stack instead of memory alloc
 * moved mutex_lock and ptype_info memory alloc outside while loop and
   adjusted the return flow
 * used 'break' instead of 'continue' in ptype id switch case

v2: https://lore.kernel.org/netdev/20230614171428.1504179-1-anthony.l.nguyen@intel.com/
Patch 2:
 * added "Intel(R)" to the DRV_SUMMARY and Makefile.
Patch 4, 5, 6, 15:
 * replaced IDPF_VC_MSG_PENDING flag with mutex 'vc_buf_lock' for the
   adapter related virtchnl opcodes.
 * get the mutex lock in the virtchnl send thread itself instead of
   in receive thread.
Patch 5, 6, 7, 8, 9, 11, 14, 15:
 * replaced IDPF_VPORT_VC_MSG_PENDING flag with mutex 'vc_buf_lock' for
   the vport related virtchnl opcodes.
 * get the mutex lock in the virtchnl send thread itself instead of
   in receive thread.
Patch 6:
 * converted get_ptype_info logic from 1:N to 1:1 message exchange for
   better handling of mutex lock.
Patch 15:
 * introduced 'stats_lock' spinlock to avoid concurrent stats update.

v1: https://lore.kernel.org/netdev/20230530234501.2680230-1-anthony.l.nguyen@intel.com/

iwl-next:
v6 - https://lore.kernel.org/netdev/20230523002252.26124-1-pavan.kumar.linga@intel.com/
v5 - https://lore.kernel.org/netdev/20230513225710.3898-1-emil.s.tantilov@intel.com/
v4 - https://lore.kernel.org/netdev/20230508194326.482-1-emil.s.tantilov@intel.com/
v3 - https://lore.kernel.org/netdev/20230427020917.12029-1-emil.s.tantilov@intel.com/
v2 - https://lore.kernel.org/netdev/20230411011354.2619359-1-pavan.kumar.linga@intel.com/
v1 - https://lore.kernel.org/netdev/20230329140404.1647925-1-pavan.kumar.linga@intel.com/

Alan Brady (4):
  idpf: configure resources for TX queues
  idpf: configure resources for RX queues
  idpf: add RX splitq napi poll support
  idpf: add ethtool callbacks

Joshua Hay (5):
  idpf: add controlq init and reset checks
  idpf: add splitq start_xmit
  idpf: add TX splitq napi poll support
  idpf: add singleq start_xmit and napi poll
  idpf: add SRIOV support and other ndo_ops

Pavan Kumar Linga (5):
  virtchnl: add virtchnl version 2 ops
  idpf: add core init and interrupt request
  idpf: add create vport and netdev configuration
  idpf: add ptypes and MAC filter support
  idpf: initialize interrupts and enable vport

Phani Burra (1):
  idpf: add module register and probe functionality

 .../device_drivers/ethernet/index.rst         |    1 +
 .../device_drivers/ethernet/intel/idpf.rst    |  160 +
 drivers/net/ethernet/intel/Kconfig            |   12 +
 drivers/net/ethernet/intel/Makefile           |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |   18 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  968 ++++
 .../net/ethernet/intel/idpf/idpf_controlq.c   |  621 +++
 .../net/ethernet/intel/idpf/idpf_controlq.h   |  130 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |  169 +
 .../ethernet/intel/idpf/idpf_controlq_setup.c |  171 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  165 +
 drivers/net/ethernet/intel/idpf/idpf_devids.h |   10 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 1371 ++++++
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |  124 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  293 ++
 .../ethernet/intel/idpf/idpf_lan_vf_regs.h    |  128 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 2379 +++++++++
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  283 ++
 drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 1183 +++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 4289 +++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 1024 ++++
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  163 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 3791 +++++++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 1273 +++++
 .../ethernet/intel/idpf/virtchnl2_lan_desc.h  |  451 ++
 26 files changed, 19198 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/intel/idpf.rst
 create mode 100644 drivers/net/ethernet/intel/idpf/Makefile
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_dev.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devids.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ethtool.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_pf_regs.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lan_vf_regs.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_lib.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_main.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_txrx.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_txrx.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/idpf/virtchnl2.h
 create mode 100644 drivers/net/ethernet/intel/idpf/virtchnl2_lan_desc.h

-- 
2.38.1


