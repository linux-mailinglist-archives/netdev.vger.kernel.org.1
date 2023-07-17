Return-Path: <netdev+bounces-18378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA8756B19
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8698D1C20B2D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F47BE75;
	Mon, 17 Jul 2023 17:58:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1882BBE6F
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:58:19 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28B8E
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689616697; x=1721152697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/mHGAsskpNjbc+COmDNXOKNOtHiD11t9XUYQrv+A5wM=;
  b=m8hjiNuRYQES1X4ym5eRkXTeiuPtPpvnDCUPT0eLAwy0hJ3bz0zuGqcq
   GLiFXtexoq7+37PoprXyCZQ/2zO4oj6VmXctbL8c4onpvOn5rxMBTLHt8
   pavOPWvJcM+EjZtttPpD23JULjVNZEpzwGJxFpmMeHnSaWFYw6SEpRgqR
   oHz6b6HlA52pa/mXRjXvPvdN3/jzH4DLFXUFnRnfLGjPiFomRb182Y03N
   EQj7p7uXdYU+9RqXNuuBeARwFjwD3PJU0aBIan0iknqgrPEW7t96F1fRg
   SE9FhYiimjRNre3XuoBP0IVE5IDCAtMKDKz1gOp6TtWn+u9uYcrMOedtS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432172657"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432172657"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723294558"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723294558"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2023 10:57:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ding Hui <dinghui@sangfor.com.cn>,
	anthony.l.nguyen@intel.com,
	Donglin Peng <pengdonglin@sangfor.com.cn>,
	Huang Cun <huangcun@sangfor.com.cn>,
	Leon Romanovsky <leonro@nvidia.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/8] iavf: Fix out-of-bounds when setting channels on remove
Date: Mon, 17 Jul 2023 10:51:59 -0700
Message-Id: <20230717175205.3217774-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230717175205.3217774-1-anthony.l.nguyen@intel.com>
References: <20230717175205.3217774-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ding Hui <dinghui@sangfor.com.cn>

If we set channels greater during iavf_remove(), and waiting reset done
would be timeout, then returned with error but changed num_active_queues
directly, that will lead to OOB like the following logs. Because the
num_active_queues is greater than tx/rx_rings[] allocated actually.

Reproducer:

  [root@host ~]# cat repro.sh
  #!/bin/bash

  pf_dbsf="0000:41:00.0"
  vf0_dbsf="0000:41:02.0"
  g_pids=()

  function do_set_numvf()
  {
      echo 2 >/sys/bus/pci/devices/${pf_dbsf}/sriov_numvfs
      sleep $((RANDOM%3+1))
      echo 0 >/sys/bus/pci/devices/${pf_dbsf}/sriov_numvfs
      sleep $((RANDOM%3+1))
  }

  function do_set_channel()
  {
      local nic=$(ls -1 --indicator-style=none /sys/bus/pci/devices/${vf0_dbsf}/net/)
      [ -z "$nic" ] && { sleep $((RANDOM%3)) ; return 1; }
      ifconfig $nic 192.168.18.5 netmask 255.255.255.0
      ifconfig $nic up
      ethtool -L $nic combined 1
      ethtool -L $nic combined 4
      sleep $((RANDOM%3))
  }

  function on_exit()
  {
      local pid
      for pid in "${g_pids[@]}"; do
          kill -0 "$pid" &>/dev/null && kill "$pid" &>/dev/null
      done
      g_pids=()
  }

  trap "on_exit; exit" EXIT

  while :; do do_set_numvf ; done &
  g_pids+=($!)
  while :; do do_set_channel ; done &
  g_pids+=($!)

  wait

Result:

[ 3506.152887] iavf 0000:41:02.0: Removing device
[ 3510.400799] ==================================================================
[ 3510.400820] BUG: KASAN: slab-out-of-bounds in iavf_free_all_tx_resources+0x156/0x160 [iavf]
[ 3510.400823] Read of size 8 at addr ffff88b6f9311008 by task repro.sh/55536
[ 3510.400823]
[ 3510.400830] CPU: 101 PID: 55536 Comm: repro.sh Kdump: loaded Tainted: G           O     --------- -t - 4.18.0 #1
[ 3510.400832] Hardware name: Powerleader PR2008AL/H12DSi-N6, BIOS 2.0 04/09/2021
[ 3510.400835] Call Trace:
[ 3510.400851]  dump_stack+0x71/0xab
[ 3510.400860]  print_address_description+0x6b/0x290
[ 3510.400865]  ? iavf_free_all_tx_resources+0x156/0x160 [iavf]
[ 3510.400868]  kasan_report+0x14a/0x2b0
[ 3510.400873]  iavf_free_all_tx_resources+0x156/0x160 [iavf]
[ 3510.400880]  iavf_remove+0x2b6/0xc70 [iavf]
[ 3510.400884]  ? iavf_free_all_rx_resources+0x160/0x160 [iavf]
[ 3510.400891]  ? wait_woken+0x1d0/0x1d0
[ 3510.400895]  ? notifier_call_chain+0xc1/0x130
[ 3510.400903]  pci_device_remove+0xa8/0x1f0
[ 3510.400910]  device_release_driver_internal+0x1c6/0x460
[ 3510.400916]  pci_stop_bus_device+0x101/0x150
[ 3510.400919]  pci_stop_and_remove_bus_device+0xe/0x20
[ 3510.400924]  pci_iov_remove_virtfn+0x187/0x420
[ 3510.400927]  ? pci_iov_add_virtfn+0xe10/0xe10
[ 3510.400929]  ? pci_get_subsys+0x90/0x90
[ 3510.400932]  sriov_disable+0xed/0x3e0
[ 3510.400936]  ? bus_find_device+0x12d/0x1a0
[ 3510.400953]  i40e_free_vfs+0x754/0x1210 [i40e]
[ 3510.400966]  ? i40e_reset_all_vfs+0x880/0x880 [i40e]
[ 3510.400968]  ? pci_get_device+0x7c/0x90
[ 3510.400970]  ? pci_get_subsys+0x90/0x90
[ 3510.400982]  ? pci_vfs_assigned.part.7+0x144/0x210
[ 3510.400987]  ? __mutex_lock_slowpath+0x10/0x10
[ 3510.400996]  i40e_pci_sriov_configure+0x1fa/0x2e0 [i40e]
[ 3510.401001]  sriov_numvfs_store+0x214/0x290
[ 3510.401005]  ? sriov_totalvfs_show+0x30/0x30
[ 3510.401007]  ? __mutex_lock_slowpath+0x10/0x10
[ 3510.401011]  ? __check_object_size+0x15a/0x350
[ 3510.401018]  kernfs_fop_write+0x280/0x3f0
[ 3510.401022]  vfs_write+0x145/0x440
[ 3510.401025]  ksys_write+0xab/0x160
[ 3510.401028]  ? __ia32_sys_read+0xb0/0xb0
[ 3510.401031]  ? fput_many+0x1a/0x120
[ 3510.401032]  ? filp_close+0xf0/0x130
[ 3510.401038]  do_syscall_64+0xa0/0x370
[ 3510.401041]  ? page_fault+0x8/0x30
[ 3510.401043]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[ 3510.401073] RIP: 0033:0x7f3a9bb842c0
[ 3510.401079] Code: 73 01 c3 48 8b 0d d8 cb 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe dd 01 00 48 89 04 24
[ 3510.401080] RSP: 002b:00007ffc05f1fe18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 3510.401083] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f3a9bb842c0
[ 3510.401085] RDX: 0000000000000002 RSI: 0000000002327408 RDI: 0000000000000001
[ 3510.401086] RBP: 0000000002327408 R08: 00007f3a9be53780 R09: 00007f3a9c8a4700
[ 3510.401086] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[ 3510.401087] R13: 0000000000000001 R14: 00007f3a9be52620 R15: 0000000000000001
[ 3510.401090]
[ 3510.401093] Allocated by task 76795:
[ 3510.401098]  kasan_kmalloc+0xa6/0xd0
[ 3510.401099]  __kmalloc+0xfb/0x200
[ 3510.401104]  iavf_init_interrupt_scheme+0x26f/0x1310 [iavf]
[ 3510.401108]  iavf_watchdog_task+0x1d58/0x4050 [iavf]
[ 3510.401114]  process_one_work+0x56a/0x11f0
[ 3510.401115]  worker_thread+0x8f/0xf40
[ 3510.401117]  kthread+0x2a0/0x390
[ 3510.401119]  ret_from_fork+0x1f/0x40
[ 3510.401122]  0xffffffffffffffff
[ 3510.401123]

In timeout handling, we should keep the original num_active_queues
and reset num_req_queues to 0.

Fixes: 4e5e6b5d9d13 ("iavf: Fix return of set the new channel count")
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
Cc: Huang Cun <huangcun@sangfor.com.cn>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 6f171d1d85b7..92443f8e9fbd 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1863,7 +1863,7 @@ static int iavf_set_channels(struct net_device *netdev,
 	}
 	if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
 		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
-		adapter->num_active_queues = num_req;
+		adapter->num_req_queues = 0;
 		return -EOPNOTSUPP;
 	}
 
-- 
2.38.1


