Return-Path: <netdev+bounces-202976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0021AF006A
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640F9179008
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880DB27FB18;
	Tue,  1 Jul 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iM/tomNT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66827F4D5
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388205; cv=none; b=aryjWmpRkYz+x6QH+f6o2BAenbSfcqEnTPZQT2ATOpGZIm7lmvQulhAOX8Xxp/p4oTZ93DlljIVerAlKnyd7+CbHCHq0RnZiC8fuxFaKdb/iz1rtSFZJmr3G3dqzbxiFqyqS0WG7Z6GaYAq78FzUBh7XXUdfPMjKE5ld1ULMQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388205; c=relaxed/simple;
	bh=+NZ57ZbFh+VZ7S17wnlmCKf7pZU58AfKU1x2avc3MHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gkspFE8UuUYnDXvoQzYtjazW5yAHsfQL1LnfOKXx+XnOQ9m8TqKf4Z9COvEKn7ZuKNHKyNErpCH+RwM/MiRiTRSX8DYbrH8WLbNyXKmi5MPzKSqJBhoxul7ZNQ9hkPAVyDxnKyHTiomVSXRHXgcPcZPaKMjuc1RMdAbN7r6lNw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iM/tomNT; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751388203; x=1782924203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+NZ57ZbFh+VZ7S17wnlmCKf7pZU58AfKU1x2avc3MHA=;
  b=iM/tomNT7nqb/sGmv9RLFdC/pTizHSJ1nH4hpS5MUevEjcKjqy9hdtih
   jxIKzsY1urx1btnqmA1hPC/GfF8lV68oN31dTFYECcXjLEkKcbgpkIMlm
   pAWEotpw962/ROXl61kqMPPPfh5I98W3cUmQNFWu9HDXDwrvE2Ca+ZiiT
   KWUqhYt1knxg0QvWxrgkV2DdR7A2h0jQgLCbOWg2DtGmANPwMKMLNlJA+
   +bG2eYH06ytsPhYeDpQNYnl643SVf/zg3zffR4xbkcnqEfIXmkbOxa/Lp
   Ndlia0QrbO0mvEdX7oDPD2CZK69QQK7/4rbrEia/QX/zPq8aZBTh+/rIB
   A==;
X-CSE-ConnectionGUID: KNzPEggzQ4O+omuOy/Lhuw==
X-CSE-MsgGUID: JUjCmZRsTOS/mx4dZYnhtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="41296657"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="41296657"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 09:43:20 -0700
X-CSE-ConnectionGUID: Tqq4SG1JRo2uLD9NoEYAIg==
X-CSE-MsgGUID: WoaUsbO2SBi8lZLLk0KwSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153594090"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2025 09:43:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Ahmed Zaki <ahmed.zaki@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 2/3] idpf: convert control queue mutex to a spinlock
Date: Tue,  1 Jul 2025 09:43:14 -0700
Message-ID: <20250701164317.2983952-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250701164317.2983952-1-anthony.l.nguyen@intel.com>
References: <20250701164317.2983952-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ahmed Zaki <ahmed.zaki@intel.com>

With VIRTCHNL2_CAP_MACFILTER enabled, the following warning is generated
on module load:

[  324.701677] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:578
[  324.701684] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1582, name: NetworkManager
[  324.701689] preempt_count: 201, expected: 0
[  324.701693] RCU nest depth: 0, expected: 0
[  324.701697] 2 locks held by NetworkManager/1582:
[  324.701702]  #0: ffffffff9f7be770 (rtnl_mutex){....}-{3:3}, at: rtnl_newlink+0x791/0x21e0
[  324.701730]  #1: ff1100216c380368 (_xmit_ETHER){....}-{2:2}, at: __dev_open+0x3f0/0x870
[  324.701749] Preemption disabled at:
[  324.701752] [<ffffffff9cd23b9d>] __dev_open+0x3dd/0x870
[  324.701765] CPU: 30 UID: 0 PID: 1582 Comm: NetworkManager Not tainted 6.15.0-rc5+ #2 PREEMPT(voluntary)
[  324.701771] Hardware name: Intel Corporation M50FCP2SBSTD/M50FCP2SBSTD, BIOS SE5C741.86B.01.01.0001.2211140926 11/14/2022
[  324.701774] Call Trace:
[  324.701777]  <TASK>
[  324.701779]  dump_stack_lvl+0x5d/0x80
[  324.701788]  ? __dev_open+0x3dd/0x870
[  324.701793]  __might_resched.cold+0x1ef/0x23d
<..>
[  324.701818]  __mutex_lock+0x113/0x1b80
<..>
[  324.701917]  idpf_ctlq_clean_sq+0xad/0x4b0 [idpf]
[  324.701935]  ? kasan_save_track+0x14/0x30
[  324.701941]  idpf_mb_clean+0x143/0x380 [idpf]
<..>
[  324.701991]  idpf_send_mb_msg+0x111/0x720 [idpf]
[  324.702009]  idpf_vc_xn_exec+0x4cc/0x990 [idpf]
[  324.702021]  ? rcu_is_watching+0x12/0xc0
[  324.702035]  idpf_add_del_mac_filters+0x3ed/0xb50 [idpf]
<..>
[  324.702122]  __hw_addr_sync_dev+0x1cf/0x300
[  324.702126]  ? find_held_lock+0x32/0x90
[  324.702134]  idpf_set_rx_mode+0x317/0x390 [idpf]
[  324.702152]  __dev_open+0x3f8/0x870
[  324.702159]  ? __pfx___dev_open+0x10/0x10
[  324.702174]  __dev_change_flags+0x443/0x650
<..>
[  324.702208]  netif_change_flags+0x80/0x160
[  324.702218]  do_setlink.isra.0+0x16a0/0x3960
<..>
[  324.702349]  rtnl_newlink+0x12fd/0x21e0

The sequence is as follows:
	rtnl_newlink()->
	__dev_change_flags()->
	__dev_open()->
	dev_set_rx_mode() - >  # disables BH and grabs "dev->addr_list_lock"
	idpf_set_rx_mode() ->  # proceed only if VIRTCHNL2_CAP_MACFILTER is ON
	__dev_uc_sync() ->
	idpf_add_mac_filter ->
	idpf_add_del_mac_filters ->
	idpf_send_mb_msg() ->
	idpf_mb_clean() ->
	idpf_ctlq_clean_sq()   # mutex_lock(cq_lock)

Fix by converting cq_lock to a spinlock. All operations under the new
lock are safe except freeing the DMA memory, which may use vunmap(). Fix
by requesting a contiguous physical memory for the DMA mapping.

Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/idpf/idpf_controlq.c   | 23 +++++++++----------
 .../ethernet/intel/idpf/idpf_controlq_api.h   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 12 ++++++----
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index b28991dd1870..48b8e184f3db 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -96,7 +96,7 @@ static void idpf_ctlq_init_rxq_bufs(struct idpf_ctlq_info *cq)
  */
 static void idpf_ctlq_shutdown(struct idpf_hw *hw, struct idpf_ctlq_info *cq)
 {
-	mutex_lock(&cq->cq_lock);
+	spin_lock(&cq->cq_lock);
 
 	/* free ring buffers and the ring itself */
 	idpf_ctlq_dealloc_ring_res(hw, cq);
@@ -104,8 +104,7 @@ static void idpf_ctlq_shutdown(struct idpf_hw *hw, struct idpf_ctlq_info *cq)
 	/* Set ring_size to 0 to indicate uninitialized queue */
 	cq->ring_size = 0;
 
-	mutex_unlock(&cq->cq_lock);
-	mutex_destroy(&cq->cq_lock);
+	spin_unlock(&cq->cq_lock);
 }
 
 /**
@@ -173,7 +172,7 @@ int idpf_ctlq_add(struct idpf_hw *hw,
 
 	idpf_ctlq_init_regs(hw, cq, is_rxq);
 
-	mutex_init(&cq->cq_lock);
+	spin_lock_init(&cq->cq_lock);
 
 	list_add(&cq->cq_list, &hw->cq_list_head);
 
@@ -272,7 +271,7 @@ int idpf_ctlq_send(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 	int err = 0;
 	int i;
 
-	mutex_lock(&cq->cq_lock);
+	spin_lock(&cq->cq_lock);
 
 	/* Ensure there are enough descriptors to send all messages */
 	num_desc_avail = IDPF_CTLQ_DESC_UNUSED(cq);
@@ -332,7 +331,7 @@ int idpf_ctlq_send(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 	wr32(hw, cq->reg.tail, cq->next_to_use);
 
 err_unlock:
-	mutex_unlock(&cq->cq_lock);
+	spin_unlock(&cq->cq_lock);
 
 	return err;
 }
@@ -364,7 +363,7 @@ int idpf_ctlq_clean_sq(struct idpf_ctlq_info *cq, u16 *clean_count,
 	if (*clean_count > cq->ring_size)
 		return -EBADR;
 
-	mutex_lock(&cq->cq_lock);
+	spin_lock(&cq->cq_lock);
 
 	ntc = cq->next_to_clean;
 
@@ -397,7 +396,7 @@ int idpf_ctlq_clean_sq(struct idpf_ctlq_info *cq, u16 *clean_count,
 
 	cq->next_to_clean = ntc;
 
-	mutex_unlock(&cq->cq_lock);
+	spin_unlock(&cq->cq_lock);
 
 	/* Return number of descriptors actually cleaned */
 	*clean_count = i;
@@ -435,7 +434,7 @@ int idpf_ctlq_post_rx_buffs(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 	if (*buff_count > 0)
 		buffs_avail = true;
 
-	mutex_lock(&cq->cq_lock);
+	spin_lock(&cq->cq_lock);
 
 	if (tbp >= cq->ring_size)
 		tbp = 0;
@@ -524,7 +523,7 @@ int idpf_ctlq_post_rx_buffs(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 		wr32(hw, cq->reg.tail, cq->next_to_post);
 	}
 
-	mutex_unlock(&cq->cq_lock);
+	spin_unlock(&cq->cq_lock);
 
 	/* return the number of buffers that were not posted */
 	*buff_count = *buff_count - i;
@@ -552,7 +551,7 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 	u16 i;
 
 	/* take the lock before we start messing with the ring */
-	mutex_lock(&cq->cq_lock);
+	spin_lock(&cq->cq_lock);
 
 	ntc = cq->next_to_clean;
 
@@ -614,7 +613,7 @@ int idpf_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 
 	cq->next_to_clean = ntc;
 
-	mutex_unlock(&cq->cq_lock);
+	spin_unlock(&cq->cq_lock);
 
 	*num_q_msg = i;
 	if (*num_q_msg == 0)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h b/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
index 9642494a67d8..3414c5f9a831 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
@@ -99,7 +99,7 @@ struct idpf_ctlq_info {
 
 	enum idpf_ctlq_type cq_type;
 	int q_id;
-	struct mutex cq_lock;		/* control queue lock */
+	spinlock_t cq_lock;		/* control queue lock */
 	/* used for interrupt processing */
 	u16 next_to_use;
 	u16 next_to_clean;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 4eb20ec2accb..80382ff4a5fa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -2314,8 +2314,12 @@ void *idpf_alloc_dma_mem(struct idpf_hw *hw, struct idpf_dma_mem *mem, u64 size)
 	struct idpf_adapter *adapter = hw->back;
 	size_t sz = ALIGN(size, 4096);
 
-	mem->va = dma_alloc_coherent(&adapter->pdev->dev, sz,
-				     &mem->pa, GFP_KERNEL);
+	/* The control queue resources are freed under a spinlock, contiguous
+	 * pages will avoid IOMMU remapping and the use vmap (and vunmap in
+	 * dma_free_*() path.
+	 */
+	mem->va = dma_alloc_attrs(&adapter->pdev->dev, sz, &mem->pa,
+				  GFP_KERNEL, DMA_ATTR_FORCE_CONTIGUOUS);
 	mem->size = sz;
 
 	return mem->va;
@@ -2330,8 +2334,8 @@ void idpf_free_dma_mem(struct idpf_hw *hw, struct idpf_dma_mem *mem)
 {
 	struct idpf_adapter *adapter = hw->back;
 
-	dma_free_coherent(&adapter->pdev->dev, mem->size,
-			  mem->va, mem->pa);
+	dma_free_attrs(&adapter->pdev->dev, mem->size,
+		       mem->va, mem->pa, DMA_ATTR_FORCE_CONTIGUOUS);
 	mem->size = 0;
 	mem->va = NULL;
 	mem->pa = 0;
-- 
2.47.1


