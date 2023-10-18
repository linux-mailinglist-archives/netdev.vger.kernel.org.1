Return-Path: <netdev+bounces-42314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B777CE303
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AF82817FE
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D757F3C6A6;
	Wed, 18 Oct 2023 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/6oIdo1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B83AC26
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 16:39:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B77412F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697647159; x=1729183159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5O/5Qut56p5kx3ifgiN+cnPcgcX/d49y7uyznNjPtc0=;
  b=I/6oIdo1OpjbSj1hE8U50hJxwo/050PG1nNDfH0lbJ4ZbyGPY0ZjHIfm
   BXEMURwZN1l9rfQgTxejUIUX/TXAXmTSvwbdWmOBmqEXIE3GxAbr/Fxhf
   VfMkog/2USOcQh+hOCATb71Ba87TLzzbz0qww4RO7S2hhhqaqHILCtXkv
   ela3N3EAffcb+vp99dTNv/0VDHuC0LzMZDepCLiiZO09fS4OIsgBAY+wb
   gz/Rcg+ELSCJFVScT8VObjF7jfIEZ9+YZb0Muc2n6NT2W3fGHwDzyjbLl
   CoYbvzXaz/596RXhpxLoOsjSqYkb8phLhVOX/AlfsdZZWLtvijNdmyutI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="383276992"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="383276992"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 09:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="785991296"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="785991296"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2023 09:39:17 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>
Subject: [PATCH net] i40e: xsk: remove count_mask
Date: Wed, 18 Oct 2023 18:39:08 +0200
Message-Id: <20231018163908.40841-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Cited commit introduced a neat way of updating next_to_clean that does
not require boundary checks on each increment. This was done by masking
the new value with (ring length - 1) mask. Problem is that this is
applicable only for power of 2 ring sizes, for every other size this
assumption can not be made. In turn, it leads to cleaning descriptors
out of order as well as splats:

[ 1388.411915] Workqueue: events xp_release_deferred
[ 1388.411919] RIP: 0010:xp_free+0x1a/0x50
[ 1388.411921] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 55 48 8b 57 70 48 8d 47 70 48 89 e5 48 39 d0 74 06 <5d> c3 cc cc cc cc 48 8b 57 60 83 82 b8 00 00 00 01 48 8b 57 60 48
[ 1388.411922] RSP: 0018:ffa0000000a83cb0 EFLAGS: 00000206
[ 1388.411923] RAX: ff11000119aa5030 RBX: 000000000000001d RCX: ff110001129b6e50
[ 1388.411924] RDX: ff11000119aa4fa0 RSI: 0000000055555554 RDI: ff11000119aa4fc0
[ 1388.411925] RBP: ffa0000000a83cb0 R08: 0000000000000000 R09: 0000000000000000
[ 1388.411926] R10: 0000000000000001 R11: 0000000000000000 R12: ff11000115829b80
[ 1388.411927] R13: 000000000000005f R14: 0000000000000000 R15: ff11000119aa4fc0
[ 1388.411928] FS:  0000000000000000(0000) GS:ff11000277e00000(0000) knlGS:0000000000000000
[ 1388.411929] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1388.411930] CR2: 00007f1f564e6c14 CR3: 000000000783c005 CR4: 0000000000771ef0
[ 1388.411931] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1388.411931] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1388.411932] PKRU: 55555554
[ 1388.411933] Call Trace:
[ 1388.411934]  <IRQ>
[ 1388.411935]  ? show_regs+0x6e/0x80
[ 1388.411937]  ? watchdog_timer_fn+0x1d2/0x240
[ 1388.411939]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 1388.411941]  ? __hrtimer_run_queues+0x10e/0x290
[ 1388.411945]  ? clockevents_program_event+0xae/0x130
[ 1388.411947]  ? hrtimer_interrupt+0x105/0x240
[ 1388.411949]  ? __sysvec_apic_timer_interrupt+0x54/0x150
[ 1388.411952]  ? sysvec_apic_timer_interrupt+0x7f/0x90
[ 1388.411955]  </IRQ>
[ 1388.411955]  <TASK>
[ 1388.411956]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[ 1388.411958]  ? xp_free+0x1a/0x50
[ 1388.411960]  i40e_xsk_clean_rx_ring+0x5d/0x100 [i40e]
[ 1388.411968]  i40e_clean_rx_ring+0x14c/0x170 [i40e]
[ 1388.411977]  i40e_queue_pair_disable+0xda/0x260 [i40e]
[ 1388.411986]  i40e_xsk_pool_setup+0x192/0x1d0 [i40e]
[ 1388.411993]  i40e_reconfig_rss_queues+0x1f0/0x1450 [i40e]
[ 1388.412002]  xp_disable_drv_zc+0x73/0xf0
[ 1388.412004]  ? mutex_lock+0x17/0x50
[ 1388.412007]  xp_release_deferred+0x2b/0xc0
[ 1388.412010]  process_one_work+0x178/0x350
[ 1388.412011]  ? __pfx_worker_thread+0x10/0x10
[ 1388.412012]  worker_thread+0x2f7/0x420
[ 1388.412014]  ? __pfx_worker_thread+0x10/0x10
[ 1388.412015]  kthread+0xf8/0x130
[ 1388.412017]  ? __pfx_kthread+0x10/0x10
[ 1388.412019]  ret_from_fork+0x3d/0x60
[ 1388.412021]  ? __pfx_kthread+0x10/0x10
[ 1388.412023]  ret_from_fork_asm+0x1b/0x30
[ 1388.412026]  </TASK>

It comes from picking wrong ring entries when cleaning xsk buffers
during pool detach.

Remove the count_mask logic and use they boundary check when updating
next_to_process (which used to be a next_to_clean).

Fixes: c8a8ca3408dc ("i40e: remove unnecessary memory writes of the next to clean pointer")
Reported-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Tested-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 37f41c8a682f..7d991e4d9b89 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -437,12 +437,12 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u16 next_to_process = rx_ring->next_to_process;
 	u16 next_to_clean = rx_ring->next_to_clean;
-	u16 count_mask = rx_ring->count - 1;
 	unsigned int xdp_res, xdp_xmit = 0;
 	struct xdp_buff *first = NULL;
+	u32 count = rx_ring->count;
 	struct bpf_prog *xdp_prog;
+	u32 entries_to_alloc;
 	bool failure = false;
-	u16 cleaned_count;
 
 	if (next_to_process != next_to_clean)
 		first = *i40e_rx_bi(rx_ring, next_to_clean);
@@ -475,7 +475,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 						      qword);
 			bi = *i40e_rx_bi(rx_ring, next_to_process);
 			xsk_buff_free(bi);
-			next_to_process = (next_to_process + 1) & count_mask;
+			if (++next_to_process == count)
+				next_to_process = 0;
 			continue;
 		}
 
@@ -493,7 +494,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		else if (i40e_add_xsk_frag(rx_ring, first, bi, size))
 			break;
 
-		next_to_process = (next_to_process + 1) & count_mask;
+		if (++next_to_process == count)
+			next_to_process = 0;
 
 		if (i40e_is_non_eop(rx_ring, rx_desc))
 			continue;
@@ -513,10 +515,10 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 
 	rx_ring->next_to_clean = next_to_clean;
 	rx_ring->next_to_process = next_to_process;
-	cleaned_count = (next_to_clean - rx_ring->next_to_use - 1) & count_mask;
 
-	if (cleaned_count >= I40E_RX_BUFFER_WRITE)
-		failure |= !i40e_alloc_rx_buffers_zc(rx_ring, cleaned_count);
+	entries_to_alloc = I40E_DESC_UNUSED(rx_ring);
+	if (entries_to_alloc >= I40E_RX_BUFFER_WRITE)
+		failure |= !i40e_alloc_rx_buffers_zc(rx_ring, entries_to_alloc);
 
 	i40e_finalize_xdp_rx(rx_ring, xdp_xmit);
 	i40e_update_rx_stats(rx_ring, total_rx_bytes, total_rx_packets);
@@ -752,14 +754,16 @@ int i40e_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 
 void i40e_xsk_clean_rx_ring(struct i40e_ring *rx_ring)
 {
-	u16 count_mask = rx_ring->count - 1;
 	u16 ntc = rx_ring->next_to_clean;
 	u16 ntu = rx_ring->next_to_use;
 
-	for ( ; ntc != ntu; ntc = (ntc + 1)  & count_mask) {
+	while (ntc != ntu) {
 		struct xdp_buff *rx_bi = *i40e_rx_bi(rx_ring, ntc);
 
 		xsk_buff_free(rx_bi);
+		ntc++;
+		if (ntc >= rx_ring->count)
+			ntc = 0;
 	}
 }
 
-- 
2.34.1


