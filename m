Return-Path: <netdev+bounces-61317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4475382359F
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 20:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37D11F24F44
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 19:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8948E1CF8A;
	Wed,  3 Jan 2024 19:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EhLkFMdE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DB1CF89
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704310391; x=1735846391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSyGwKwJiv8qHhmbBf6jd1hMc8IZ0yY0sSGrIU6DK00=;
  b=EhLkFMdEsV5PqdrdVzvnbOnyOPi4mYe7vM+L55h6DemvhvtIylS0MLhj
   M3rrAlEmxEhDmSvo8zuBJr/FRL28bozgYeSk6NSIwYQGYcRBN/Ilyxh2o
   phHPYGNZDo+CFcR3Wx11Y8h3MuC6y1EH6a0I2tllbtRS0RDUF3ZNQEZ/Y
   NvPERAcH8cBnBJTZvAlWQCe3qkehnV778KXg0gvYIAE+HT/jEaLf6x9ZU
   QjoezX4Y0tiC3SXEQvHyP5nTSCk7SBOlXjtTFJ8RwGGZ0JJtMyBc4SNfs
   JelYJby2Nl92wlgK8tkk+OQRjVp9EA5PSyITy9EqBAUZtAMM/N/KEL8ui
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="395927474"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="395927474"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 11:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="780079849"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="780079849"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2024 11:33:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ke Xiao <xiaoke@sangfor.com.cn>,
	anthony.l.nguyen@intel.com,
	zhudi2@huawei.com,
	zhangrui182@huawei.com,
	shannon.nelson@amd.com,
	Ding Hui <dinghui@sangfor.com.cn>,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 1/4] i40e: fix use-after-free in i40e_aqc_add_filters()
Date: Wed,  3 Jan 2024 11:32:49 -0800
Message-ID: <20240103193254.822968-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240103193254.822968-1-anthony.l.nguyen@intel.com>
References: <20240103193254.822968-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ke Xiao <xiaoke@sangfor.com.cn>

Commit 3116f59c12bd ("i40e: fix use-after-free in
i40e_sync_filters_subtask()") avoided use-after-free issues,
by increasing refcount during update the VSI filter list to
the HW. However, it missed the unicast situation.

When deleting an unicast FDB entry, the i40e driver will release
the mac_filter, and i40e_service_task will concurrently request
firmware to add the mac_filter, which will lead to the following
use-after-free issue.

Fix again for both netdev->uc and netdev->mc.

BUG: KASAN: use-after-free in i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
Read of size 2 at addr ffff888eb3452d60 by task kworker/8:7/6379

CPU: 8 PID: 6379 Comm: kworker/8:7 Kdump: loaded Tainted: G
Workqueue: i40e i40e_service_task [i40e]
Call Trace:
 dump_stack+0x71/0xab
 print_address_description+0x6b/0x290
 kasan_report+0x14a/0x2b0
 i40e_aqc_add_filters+0x55c/0x5b0 [i40e]
 i40e_sync_vsi_filters+0x1676/0x39c0 [i40e]
 i40e_service_task+0x1397/0x2bb0 [i40e]
 process_one_work+0x56a/0x11f0
 worker_thread+0x8f/0xf40
 kthread+0x2a0/0x390
 ret_from_fork+0x1f/0x40

Allocated by task 21948:
 kasan_kmalloc+0xa6/0xd0
 kmem_cache_alloc_trace+0xdb/0x1c0
 i40e_add_filter+0x11e/0x520 [i40e]
 i40e_addr_sync+0x37/0x60 [i40e]
 __hw_addr_sync_dev+0x1f5/0x2f0
 i40e_set_rx_mode+0x61/0x1e0 [i40e]
 dev_uc_add_excl+0x137/0x190
 i40e_ndo_fdb_add+0x161/0x260 [i40e]
 rtnl_fdb_add+0x567/0x950
 rtnetlink_rcv_msg+0x5db/0x880
 netlink_rcv_skb+0x254/0x380
 netlink_unicast+0x454/0x610
 netlink_sendmsg+0x747/0xb00
 sock_sendmsg+0xe2/0x120
 __sys_sendto+0x1ae/0x290
 __x64_sys_sendto+0xdd/0x1b0
 do_syscall_64+0xa0/0x370
 entry_SYSCALL_64_after_hwframe+0x65/0xca

Freed by task 21948:
 __kasan_slab_free+0x137/0x190
 kfree+0x8b/0x1b0
 __i40e_del_filter+0x116/0x1e0 [i40e]
 i40e_del_mac_filter+0x16c/0x300 [i40e]
 i40e_addr_unsync+0x134/0x1b0 [i40e]
 __hw_addr_sync_dev+0xff/0x2f0
 i40e_set_rx_mode+0x61/0x1e0 [i40e]
 dev_uc_del+0x77/0x90
 rtnl_fdb_del+0x6a5/0x860
 rtnetlink_rcv_msg+0x5db/0x880
 netlink_rcv_skb+0x254/0x380
 netlink_unicast+0x454/0x610
 netlink_sendmsg+0x747/0xb00
 sock_sendmsg+0xe2/0x120
 __sys_sendto+0x1ae/0x290
 __x64_sys_sendto+0xdd/0x1b0
 do_syscall_64+0xa0/0x370
 entry_SYSCALL_64_after_hwframe+0x65/0xca

Fixes: 3116f59c12bd ("i40e: fix use-after-free in i40e_sync_filters_subtask()")
Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Ke Xiao <xiaoke@sangfor.com.cn>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Cc: Di Zhu <zhudi2@huawei.com>
Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1ab8dbe2d880..d5633a440cca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -107,12 +107,18 @@ static struct workqueue_struct *i40e_wq;
 static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
 				  struct net_device *netdev, int delta)
 {
+	struct netdev_hw_addr_list *ha_list;
 	struct netdev_hw_addr *ha;
 
 	if (!f || !netdev)
 		return;
 
-	netdev_for_each_mc_addr(ha, netdev) {
+	if (is_unicast_ether_addr(f->macaddr) || is_link_local_ether_addr(f->macaddr))
+		ha_list = &netdev->uc;
+	else
+		ha_list = &netdev->mc;
+
+	netdev_hw_addr_list_for_each(ha, ha_list) {
 		if (ether_addr_equal(ha->addr, f->macaddr)) {
 			ha->refcount += delta;
 			if (ha->refcount <= 0)
-- 
2.41.0


