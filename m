Return-Path: <netdev+bounces-162666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E6A27903
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F6A1887FA0
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FADF216E09;
	Tue,  4 Feb 2025 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+H5aNWt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F22165E4
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691579; cv=none; b=N2ouyhO4fQ4WDVADLmJ/IloRCMScsr3KbGZOOVd0hlI9vvFrvbAJuUGqVdj8LNuMDiInW5d0Gl9AACvU81kQdIYBvFapx5N0nqKxQ6PxYeUuDw7gsN9dpYlOLuW1wkSKczjPuuKUowJaFz3xkKc4gkHWGrf5cV8gYr9TsbfalHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691579; c=relaxed/simple;
	bh=Ij5+AAvOEp0oI4NlaPmZaEL3V4o/dX6CD6vtMOaL+9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgQ0XciEPL1opko2By/FLuKjTPO+Nla0yvQPeYkz0KiHZ7PmPhKZICFTsPGu+DZ6drnlD+KtftqfEtjPN2uzKRGsPUXrzv/RoaZR1LqYO7SZ2vetxmhbWIioM0s2oyRKmuWB2XFaW/5KusdQ3SxyL7bQ8urcOComw7IJTQJywac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+H5aNWt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691577; x=1770227577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ij5+AAvOEp0oI4NlaPmZaEL3V4o/dX6CD6vtMOaL+9M=;
  b=G+H5aNWtcgsHXbWrOJeZvpwplWkkTuVIxMwk/JSRklXbd0EuMeFj4PXP
   LBPKX0Yz8Y6Pm6+4hoUe5VKSehG4elyKOFVfSxRH26P1ZCDE01N854IHv
   drSgCWIlm4GW3bEDF106SjJknDJOtnBzAqspmyPlZWnEVKTxElLNGWMEj
   WlhGS8+pIpg+H3v6d6BlmJM8f0hpdvV4EQoTkOnQEhvSNvJT4kCRv7kUJ
   4WPqQ9mAs7sQ7pEdA7u3igFSQ/GUhHbBh9xPcOcnRCeGZRPFv6mXu9NYL
   s8s5ELGVoDrVs3TduLUTc9ceSOx6yoAdoF/QT+Q3O7KoWsVtY+j2Qj/8b
   A==;
X-CSE-ConnectionGUID: X1fFGUzkT/C8MapDN73oZA==
X-CSE-MsgGUID: WedJB6wHS1i6FT8kzPdPeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39371886"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39371886"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:52:54 -0800
X-CSE-ConnectionGUID: wKHizxhkSN24MAHp/mtT9g==
X-CSE-MsgGUID: rypIaQFbQb67jBu8T0tSfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110652390"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 04 Feb 2025 09:52:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Wander Lairson Costa <wander@redhat.com>,
	anthony.l.nguyen@intel.com,
	rostedt@goodmis.org,
	clrkwllms@kernel.org,
	bigeasy@linutronix.de,
	jgarzik@redhat.com,
	yuma@redhat.com,
	linux-rt-devel@lists.linux.dev,
	Clark Williams <williams@redhat.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/4] igb: introduce raw vfs_lock to igb_adapter
Date: Tue,  4 Feb 2025 09:52:38 -0800
Message-ID: <20250204175243.810189-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wander Lairson Costa <wander@redhat.com>

This change adds a raw_spinlock for the vfs_lock to the
igb_adapter structure, enabling its use in both interrupt and
preemptible contexts. This is essential for upcoming modifications
to split igb_msg_task() into interrupt-safe and preemptible-safe
parts.

The motivation for this change stems from the need to modify
igb_msix_other() to run in interrupt context under PREEMPT_RT.
Currently, igb_msg_task() contains a code path that invokes
kcalloc() with the GFP_ATOMIC flag. However, on PREEMPT_RT,
GFP_ATOMIC is not honored, making it unsafe to call allocation
functions in interrupt context. By introducing this raw spinlock,
we can safely acquire the lock in both contexts, paving the way for
the necessary restructuring of igb_msg_task().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Suggested-by: Clark Williams <williams@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |  4 ++
 drivers/net/ethernet/intel/igb/igb_main.c | 51 ++++++++++++++++++++---
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 02f340280d20..30a188c5710e 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -673,6 +673,10 @@ struct igb_adapter {
 	struct vf_mac_filter *vf_mac_list;
 	/* lock for VF resources */
 	spinlock_t vfs_lock;
+#ifdef CONFIG_PREEMPT_RT
+	/* Used to lock VFS in interrupt context under PREEMPT_RT */
+	raw_spinlock_t raw_vfs_lock;
+#endif
 };
 
 /* flags controlling PTP/1588 function */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 77571f6fdbfd..4e75c88f6214 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3657,6 +3657,47 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return err;
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static __always_inline void vfs_lock_init(struct igb_adapter *adapter)
+{
+	spin_lock_init(&adapter->vfs_lock);
+	raw_spin_lock_init(&adapter->raw_vfs_lock);
+}
+
+static __always_inline void vfs_lock_irqsave(struct igb_adapter *adapter,
+					     unsigned long *flags)
+{
+	/*
+	 * Remember that under PREEMPT_RT spin_lock_irqsave
+	 * ignores the flags parameter
+	 */
+	spin_lock_irqsave(&adapter->vfs_lock, *flags);
+	raw_spin_lock_irqsave(&adapter->raw_vfs_lock, *flags);
+}
+
+static __always_inline void vfs_unlock_irqrestore(struct igb_adapter *adapter,
+						  unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&adapter->raw_vfs_lock, flags);
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+}
+#else
+static __always_inline void vfs_lock_init(struct igb_adapter *adapter)
+{
+	spin_lock_init(&adapter->vfs_lock);
+}
+
+static __always_inline void vfs_lock_irqsave(struct igb_adapter *adapter, unsigned long *flags)
+{
+	spin_lock_irqsave(&adapter->vfs_lock, *flags);
+}
+
+static __always_inline void vfs_unlock_irqrestore(struct igb_adapter *adapter, unsigned long flags)
+{
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+}
+#endif
+
 #ifdef CONFIG_PCI_IOV
 static int igb_sriov_reinit(struct pci_dev *dev)
 {
@@ -3707,9 +3748,9 @@ static int igb_disable_sriov(struct pci_dev *pdev, bool reinit)
 			pci_disable_sriov(pdev);
 			msleep(500);
 		}
-		spin_lock_irqsave(&adapter->vfs_lock, flags);
+		vfs_lock_irqsave(adapter, &flags);
 		adapter->vfs_allocated_count = 0;
-		spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+		vfs_unlock_irqrestore(adapter, flags);
 		kfree(adapter->vf_mac_list);
 		adapter->vf_mac_list = NULL;
 		kfree(adapter->vf_data);
@@ -4042,7 +4083,7 @@ static int igb_sw_init(struct igb_adapter *adapter)
 	spin_lock_init(&adapter->stats64_lock);
 
 	/* init spinlock to avoid concurrency of VF resources */
-	spin_lock_init(&adapter->vfs_lock);
+	vfs_lock_init(adapter);
 #ifdef CONFIG_PCI_IOV
 	switch (hw->mac.type) {
 	case e1000_82576:
@@ -8078,7 +8119,7 @@ static void igb_msg_task(struct igb_adapter *adapter)
 	unsigned long flags;
 	u32 vf;
 
-	spin_lock_irqsave(&adapter->vfs_lock, flags);
+	vfs_lock_irqsave(adapter, &flags);
 	for (vf = 0; vf < adapter->vfs_allocated_count; vf++) {
 		/* process any reset requests */
 		if (!igb_check_for_rst(hw, vf))
@@ -8092,7 +8133,7 @@ static void igb_msg_task(struct igb_adapter *adapter)
 		if (!igb_check_for_ack(hw, vf))
 			igb_rcv_ack_from_vf(adapter, vf);
 	}
-	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+	vfs_unlock_irqrestore(adapter, flags);
 }
 
 /**
-- 
2.47.1


