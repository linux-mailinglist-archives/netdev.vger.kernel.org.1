Return-Path: <netdev+bounces-15724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A010C7495E4
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 08:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CAB2810F5
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 06:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DD7110C;
	Thu,  6 Jul 2023 06:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB7B1102
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 06:47:30 +0000 (UTC)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4E910E
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 23:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688626048; x=1720162048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qdzaoh9oxOhM+jyehcrD+LoVPzNTSDRo3q8tULyb0Rw=;
  b=jArkmVxMsxbw7jzgvrtRjD/QUipQ8rhUb/yy8UDlU98TZSRSqqLXEVLh
   slI2lSNjsaanFMiPer3PYlZkiz1WmRhB6PaGiIgvDRkaAaIL8srreugyJ
   AOrapQHNiTyTOyMqrpZuEsscYY8tfKUaP0iZBi/cxI37h/uuVckHuzfHQ
   1vkgAiWavF83L/jd9xNNX8KxDDtCekasoRPHK7aSvHcwtTh8jBf4XKHmu
   0aR7GEa8PrFD06KF4uohasfRsj9cS3DkibYC1X9ncpABbxUXbb1DAhaRz
   I0kY/z3qeKMgl4x2ZIVypIUFsKYJI2y2vwjBm/KZwwJQP4NQ/48Ip33PW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343115432"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="343115432"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 23:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="966103988"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="966103988"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2023 23:47:25 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	piotr.raczynski@intel.com,
	aleksander.lobakin@intel.com,
	pmenzel@molgen.mpg.de,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v3] ice: prevent NULL pointer deref during reload
Date: Thu,  6 Jul 2023 08:25:51 +0200
Message-ID: <20230706062551.2261312-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Calling ethtool during reload can lead to call trace, because VSI isn't
configured for some time, but netdev is alive.

To fix it add rtnl lock for VSI deconfig and config. Set ::num_q_vectors
to 0 after freeing and add a check for ::tx/rx_rings in ring related
ethtool ops.

Add proper unroll of filters in ice_start_eth().

Reproduction:
$watch -n 0.1 -d 'ethtool -g enp24s0f0np0'
$devlink dev reload pci/0000:18:00.0 action driver_reinit

Call trace before fix:
[66303.926205] BUG: kernel NULL pointer dereference, address: 0000000000000000
[66303.926259] #PF: supervisor read access in kernel mode
[66303.926286] #PF: error_code(0x0000) - not-present page
[66303.926311] PGD 0 P4D 0
[66303.926332] Oops: 0000 [#1] PREEMPT SMP PTI
[66303.926358] CPU: 4 PID: 933821 Comm: ethtool Kdump: loaded Tainted: G           OE      6.4.0-rc5+ #1
[66303.926400] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.00.01.0014.070920180847 07/09/2018
[66303.926446] RIP: 0010:ice_get_ringparam+0x22/0x50 [ice]
[66303.926649] Code: 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 48 8b 87 c0 09 00 00 c7 46 04 e0 1f 00 00 c7 46 10 e0 1f 00 00 48 8b 50 20 <48> 8b 12 0f b7 52 3a 89 56 14 48 8b 40 28 48 8b 00 0f b7 40 58 48
[66303.926722] RSP: 0018:ffffad40472f39c8 EFLAGS: 00010246
[66303.926749] RAX: ffff98a8ada05828 RBX: ffff98a8c46dd060 RCX: ffffad40472f3b48
[66303.926781] RDX: 0000000000000000 RSI: ffff98a8c46dd068 RDI: ffff98a8b23c4000
[66303.926811] RBP: ffffad40472f3b48 R08: 00000000000337b0 R09: 0000000000000000
[66303.926843] R10: 0000000000000001 R11: 0000000000000100 R12: ffff98a8b23c4000
[66303.926874] R13: ffff98a8c46dd060 R14: 000000000000000f R15: ffffad40472f3a50
[66303.926906] FS:  00007f6397966740(0000) GS:ffff98b390900000(0000) knlGS:0000000000000000
[66303.926941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[66303.926967] CR2: 0000000000000000 CR3: 000000011ac20002 CR4: 00000000007706e0
[66303.926999] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[66303.927029] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[66303.927060] PKRU: 55555554
[66303.927075] Call Trace:
[66303.927094]  <TASK>
[66303.927111]  ? __die+0x23/0x70
[66303.927140]  ? page_fault_oops+0x171/0x4e0
[66303.927176]  ? exc_page_fault+0x7f/0x180
[66303.927209]  ? asm_exc_page_fault+0x26/0x30
[66303.927244]  ? ice_get_ringparam+0x22/0x50 [ice]
[66303.927433]  rings_prepare_data+0x62/0x80
[66303.927469]  ethnl_default_doit+0xe2/0x350
[66303.927501]  genl_family_rcv_msg_doit.isra.0+0xe3/0x140
[66303.927538]  genl_rcv_msg+0x1b1/0x2c0
[66303.927561]  ? __pfx_ethnl_default_doit+0x10/0x10
[66303.927590]  ? __pfx_genl_rcv_msg+0x10/0x10
[66303.927615]  netlink_rcv_skb+0x58/0x110
[66303.927644]  genl_rcv+0x28/0x40
[66303.927665]  netlink_unicast+0x19e/0x290
[66303.927691]  netlink_sendmsg+0x254/0x4d0
[66303.927717]  sock_sendmsg+0x93/0xa0
[66303.927743]  __sys_sendto+0x126/0x170
[66303.927780]  __x64_sys_sendto+0x24/0x30
[66303.928593]  do_syscall_64+0x5d/0x90
[66303.929370]  ? __count_memcg_events+0x60/0xa0
[66303.930146]  ? count_memcg_events.constprop.0+0x1a/0x30
[66303.930920]  ? handle_mm_fault+0x9e/0x350
[66303.931688]  ? do_user_addr_fault+0x258/0x740
[66303.932452]  ? exc_page_fault+0x7f/0x180
[66303.933193]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v2 --> v1 [1] pointed by Paul:
 * change the title to more specific
v1 --> v2 [2] pointed by Olek:
 * Remove not useful part of call trace from commit message
 * Reword comment about no rings
 * Unroll adding filters in ice_start_eth()
 * Proper lock in ice_load() also in unroll path

[1] https://lore.kernel.org/netdev/20230705040510.906029-1-michal.swiatkowski@linux.intel.com/
[2] https://lore.kernel.org/netdev/20230703103215.54570-1-michal.swiatkowski@linux.intel.com/T/#t
---
 drivers/net/ethernet/intel/ice/ice_base.c    |  2 ++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 13 +++++++++++--
 drivers/net/ethernet/intel/ice/ice_main.c    | 10 ++++++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 1911d644dfa8..619cb07a4069 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -758,6 +758,8 @@ void ice_vsi_free_q_vectors(struct ice_vsi *vsi)
 
 	ice_for_each_q_vector(vsi, v_idx)
 		ice_free_q_vector(vsi, v_idx);
+
+	vsi->num_q_vectors = 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index f86e814354a3..ec4138e684bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2920,8 +2920,13 @@ ice_get_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 
 	ring->rx_max_pending = ICE_MAX_NUM_DESC;
 	ring->tx_max_pending = ICE_MAX_NUM_DESC;
-	ring->rx_pending = vsi->rx_rings[0]->count;
-	ring->tx_pending = vsi->tx_rings[0]->count;
+	if (vsi->tx_rings && vsi->rx_rings) {
+		ring->rx_pending = vsi->rx_rings[0]->count;
+		ring->tx_pending = vsi->tx_rings[0]->count;
+	} else {
+		ring->rx_pending = 0;
+		ring->tx_pending = 0;
+	}
 
 	/* Rx mini and jumbo rings are not supported */
 	ring->rx_mini_max_pending = 0;
@@ -2955,6 +2960,10 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		return -EINVAL;
 	}
 
+	/* Return if there is no rings (device is reloading) */
+	if (!vsi->tx_rings || !vsi->rx_rings)
+		return -EBUSY;
+
 	new_tx_cnt = ALIGN(ring->tx_pending, ICE_REQ_DESC_MULTIPLE);
 	if (new_tx_cnt != ring->tx_pending)
 		netdev_info(netdev, "Requested Tx descriptor count rounded up to %d\n",
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0d8b8c6f9bd3..9168feda2c19 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4634,9 +4634,9 @@ static int ice_start_eth(struct ice_vsi *vsi)
 	if (err)
 		return err;
 
-	rtnl_lock();
 	err = ice_vsi_open(vsi);
-	rtnl_unlock();
+	if (err)
+		ice_fltr_remove_all(vsi);
 
 	return err;
 }
@@ -5099,6 +5099,7 @@ int ice_load(struct ice_pf *pf)
 	params = ice_vsi_to_params(vsi);
 	params.flags = ICE_VSI_FLAG_INIT;
 
+	rtnl_lock();
 	err = ice_vsi_cfg(vsi, &params);
 	if (err)
 		goto err_vsi_cfg;
@@ -5106,6 +5107,7 @@ int ice_load(struct ice_pf *pf)
 	err = ice_start_eth(ice_get_main_vsi(pf));
 	if (err)
 		goto err_start_eth;
+	rtnl_unlock();
 
 	err = ice_init_rdma(pf);
 	if (err)
@@ -5120,9 +5122,11 @@ int ice_load(struct ice_pf *pf)
 
 err_init_rdma:
 	ice_vsi_close(ice_get_main_vsi(pf));
+	rtnl_lock();
 err_start_eth:
 	ice_vsi_decfg(ice_get_main_vsi(pf));
 err_vsi_cfg:
+	rtnl_unlock();
 	ice_deinit_dev(pf);
 	return err;
 }
@@ -5135,8 +5139,10 @@ void ice_unload(struct ice_pf *pf)
 {
 	ice_deinit_features(pf);
 	ice_deinit_rdma(pf);
+	rtnl_lock();
 	ice_stop_eth(ice_get_main_vsi(pf));
 	ice_vsi_decfg(ice_get_main_vsi(pf));
+	rtnl_unlock();
 	ice_deinit_dev(pf);
 }
 
-- 
2.41.0


