Return-Path: <netdev+bounces-18376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E7756B16
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E61281242
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95111878;
	Mon, 17 Jul 2023 17:58:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A99BE58
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:58:18 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C541BE
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689616696; x=1721152696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h1DSVhkRCnYoplLn04S6QJ4F4AB5HKYBkWusHwJrdnk=;
  b=YCo2l7zE3D/O5LTOHJknVC5VFWfeCrp4yeWF4/gaF+Bfl9GMpJIBdZ2p
   O/rxvCtcYDja1oIAv9ktlkIwVMDi9WYJma9dM5imxt0UFK2QZwcGrQ2mZ
   nT+tr/+s9ZHPcUVP8Iib8NBxN5vIMGOh7gpgnwbMjVKvEwxZ14XdekU12
   Sj7HCIMvZUI2nnrQROjlR30aipnM/YidNYPdCB/dvu2BoLXeIB4zo4p8c
   mRzM206FlYw4ylcPcYY3LYvFZrUSzBVtEiIeePaBeCIUQEbMvJHyf7rBN
   U3VqSc0FKsWqCv025dEI1/dkRNpqE9iBenlKraxOY8R6Zpqg98K+8p1TS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="432172649"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="432172649"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 10:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723294555"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723294555"
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
	Simon Horman <simon.horman@corigine.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 1/8] iavf: Fix use-after-free in free_netdev
Date: Mon, 17 Jul 2023 10:51:58 -0700
Message-Id: <20230717175205.3217774-2-anthony.l.nguyen@intel.com>
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

We do netif_napi_add() for all allocated q_vectors[], but potentially
do netif_napi_del() for part of them, then kfree q_vectors and leave
invalid pointers at dev->napi_list.

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

[ 4093.900222] ==================================================================
[ 4093.900230] BUG: KASAN: use-after-free in free_netdev+0x308/0x390
[ 4093.900232] Read of size 8 at addr ffff88b4dc145640 by task repro.sh/6699
[ 4093.900233]
[ 4093.900236] CPU: 10 PID: 6699 Comm: repro.sh Kdump: loaded Tainted: G           O     --------- -t - 4.18.0 #1
[ 4093.900238] Hardware name: Powerleader PR2008AL/H12DSi-N6, BIOS 2.0 04/09/2021
[ 4093.900239] Call Trace:
[ 4093.900244]  dump_stack+0x71/0xab
[ 4093.900249]  print_address_description+0x6b/0x290
[ 4093.900251]  ? free_netdev+0x308/0x390
[ 4093.900252]  kasan_report+0x14a/0x2b0
[ 4093.900254]  free_netdev+0x308/0x390
[ 4093.900261]  iavf_remove+0x825/0xd20 [iavf]
[ 4093.900265]  pci_device_remove+0xa8/0x1f0
[ 4093.900268]  device_release_driver_internal+0x1c6/0x460
[ 4093.900271]  pci_stop_bus_device+0x101/0x150
[ 4093.900273]  pci_stop_and_remove_bus_device+0xe/0x20
[ 4093.900275]  pci_iov_remove_virtfn+0x187/0x420
[ 4093.900277]  ? pci_iov_add_virtfn+0xe10/0xe10
[ 4093.900278]  ? pci_get_subsys+0x90/0x90
[ 4093.900280]  sriov_disable+0xed/0x3e0
[ 4093.900282]  ? bus_find_device+0x12d/0x1a0
[ 4093.900290]  i40e_free_vfs+0x754/0x1210 [i40e]
[ 4093.900298]  ? i40e_reset_all_vfs+0x880/0x880 [i40e]
[ 4093.900299]  ? pci_get_device+0x7c/0x90
[ 4093.900300]  ? pci_get_subsys+0x90/0x90
[ 4093.900306]  ? pci_vfs_assigned.part.7+0x144/0x210
[ 4093.900309]  ? __mutex_lock_slowpath+0x10/0x10
[ 4093.900315]  i40e_pci_sriov_configure+0x1fa/0x2e0 [i40e]
[ 4093.900318]  sriov_numvfs_store+0x214/0x290
[ 4093.900320]  ? sriov_totalvfs_show+0x30/0x30
[ 4093.900321]  ? __mutex_lock_slowpath+0x10/0x10
[ 4093.900323]  ? __check_object_size+0x15a/0x350
[ 4093.900326]  kernfs_fop_write+0x280/0x3f0
[ 4093.900329]  vfs_write+0x145/0x440
[ 4093.900330]  ksys_write+0xab/0x160
[ 4093.900332]  ? __ia32_sys_read+0xb0/0xb0
[ 4093.900334]  ? fput_many+0x1a/0x120
[ 4093.900335]  ? filp_close+0xf0/0x130
[ 4093.900338]  do_syscall_64+0xa0/0x370
[ 4093.900339]  ? page_fault+0x8/0x30
[ 4093.900341]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[ 4093.900357] RIP: 0033:0x7f16ad4d22c0
[ 4093.900359] Code: 73 01 c3 48 8b 0d d8 cb 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe dd 01 00 48 89 04 24
[ 4093.900360] RSP: 002b:00007ffd6491b7f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 4093.900362] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f16ad4d22c0
[ 4093.900363] RDX: 0000000000000002 RSI: 0000000001a41408 RDI: 0000000000000001
[ 4093.900364] RBP: 0000000001a41408 R08: 00007f16ad7a1780 R09: 00007f16ae1f2700
[ 4093.900364] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[ 4093.900365] R13: 0000000000000001 R14: 00007f16ad7a0620 R15: 0000000000000001
[ 4093.900367]
[ 4093.900368] Allocated by task 820:
[ 4093.900371]  kasan_kmalloc+0xa6/0xd0
[ 4093.900373]  __kmalloc+0xfb/0x200
[ 4093.900376]  iavf_init_interrupt_scheme+0x63b/0x1320 [iavf]
[ 4093.900380]  iavf_watchdog_task+0x3d51/0x52c0 [iavf]
[ 4093.900382]  process_one_work+0x56a/0x11f0
[ 4093.900383]  worker_thread+0x8f/0xf40
[ 4093.900384]  kthread+0x2a0/0x390
[ 4093.900385]  ret_from_fork+0x1f/0x40
[ 4093.900387]  0xffffffffffffffff
[ 4093.900387]
[ 4093.900388] Freed by task 6699:
[ 4093.900390]  __kasan_slab_free+0x137/0x190
[ 4093.900391]  kfree+0x8b/0x1b0
[ 4093.900394]  iavf_free_q_vectors+0x11d/0x1a0 [iavf]
[ 4093.900397]  iavf_remove+0x35a/0xd20 [iavf]
[ 4093.900399]  pci_device_remove+0xa8/0x1f0
[ 4093.900400]  device_release_driver_internal+0x1c6/0x460
[ 4093.900401]  pci_stop_bus_device+0x101/0x150
[ 4093.900402]  pci_stop_and_remove_bus_device+0xe/0x20
[ 4093.900403]  pci_iov_remove_virtfn+0x187/0x420
[ 4093.900404]  sriov_disable+0xed/0x3e0
[ 4093.900409]  i40e_free_vfs+0x754/0x1210 [i40e]
[ 4093.900415]  i40e_pci_sriov_configure+0x1fa/0x2e0 [i40e]
[ 4093.900416]  sriov_numvfs_store+0x214/0x290
[ 4093.900417]  kernfs_fop_write+0x280/0x3f0
[ 4093.900418]  vfs_write+0x145/0x440
[ 4093.900419]  ksys_write+0xab/0x160
[ 4093.900420]  do_syscall_64+0xa0/0x370
[ 4093.900421]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[ 4093.900422]  0xffffffffffffffff
[ 4093.900422]
[ 4093.900424] The buggy address belongs to the object at ffff88b4dc144200
                which belongs to the cache kmalloc-8k of size 8192
[ 4093.900425] The buggy address is located 5184 bytes inside of
                8192-byte region [ffff88b4dc144200, ffff88b4dc146200)
[ 4093.900425] The buggy address belongs to the page:
[ 4093.900427] page:ffffea00d3705000 refcount:1 mapcount:0 mapping:ffff88bf04415c80 index:0x0 compound_mapcount: 0
[ 4093.900430] flags: 0x10000000008100(slab|head)
[ 4093.900433] raw: 0010000000008100 dead000000000100 dead000000000200 ffff88bf04415c80
[ 4093.900434] raw: 0000000000000000 0000000000030003 00000001ffffffff 0000000000000000
[ 4093.900434] page dumped because: kasan: bad access detected
[ 4093.900435]
[ 4093.900435] Memory state around the buggy address:
[ 4093.900436]  ffff88b4dc145500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 4093.900437]  ffff88b4dc145580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 4093.900438] >ffff88b4dc145600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 4093.900438]                                            ^
[ 4093.900439]  ffff88b4dc145680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 4093.900440]  ffff88b4dc145700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 4093.900440] ==================================================================

Although the patch #2 (of 2) can avoid the issue triggered by this
repro.sh, there still are other potential risks that if num_active_queues
is changed to less than allocated q_vectors[] by unexpected, the
mismatched netif_napi_add/del() can also cause UAF.

Since we actually call netif_napi_add() for all allocated q_vectors
unconditionally in iavf_alloc_q_vectors(), so we should fix it by
letting netif_napi_del() match to netif_napi_add().

Fixes: 5eae00c57f5e ("i40evf: main driver core")
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
Cc: Huang Cun <huangcun@sangfor.com.cn>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a483eb185c99..89d88c3a7add 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1828,19 +1828,16 @@ static int iavf_alloc_q_vectors(struct iavf_adapter *adapter)
 static void iavf_free_q_vectors(struct iavf_adapter *adapter)
 {
 	int q_idx, num_q_vectors;
-	int napi_vectors;
 
 	if (!adapter->q_vectors)
 		return;
 
 	num_q_vectors = adapter->num_msix_vectors - NONQ_VECS;
-	napi_vectors = adapter->num_active_queues;
 
 	for (q_idx = 0; q_idx < num_q_vectors; q_idx++) {
 		struct iavf_q_vector *q_vector = &adapter->q_vectors[q_idx];
 
-		if (q_idx < napi_vectors)
-			netif_napi_del(&q_vector->napi);
+		netif_napi_del(&q_vector->napi);
 	}
 	kfree(adapter->q_vectors);
 	adapter->q_vectors = NULL;
-- 
2.38.1


