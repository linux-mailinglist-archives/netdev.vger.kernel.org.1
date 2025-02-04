Return-Path: <netdev+bounces-162664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00580A27901
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB231887E83
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D90A21660A;
	Tue,  4 Feb 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQJ1HVjM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548542165E0
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691578; cv=none; b=eekFE5Igt7e4BjIKuT+2BJyZAn5NGnG6Z5wpBCv7QksGZgWMI9l5slrcFRdvR6zaI44qahALC6RC3zPueiE1a3of0uLcwJA0YBaBFwOxD18xqk75ksX4jPICwvusSySal9V9D8PG6P4KmM9KEhruQtGjixM60YJ0YxIGbpJ7Nh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691578; c=relaxed/simple;
	bh=FYdWzTpcxPkf0D2vrnuywRxJdpODKh0DW9jB4ZCwYoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnPRST8Toh6S2AdoGd8T2AqLNQH7WbBKvb8FFqv/4PV8KduST3i5yZZ/MdYV1IsJbdiiOxGW6yPz9JB9x04V7tRY1nXb7aPwk0s+Fxb+OzO70iaEKzVoiWJ+fb0ukh9xXs3GKWMDrUHrGbL6vZPDQRd06AWkwajfdNFHB6tbvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQJ1HVjM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691577; x=1770227577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FYdWzTpcxPkf0D2vrnuywRxJdpODKh0DW9jB4ZCwYoY=;
  b=GQJ1HVjM5IKxgVrSFCrqg1SSqnsZB0zSlSQu/b4GlN2u1dJzQG4xTdDm
   696LJVOSu19qtH7sb12G04qhr8jx28hnRSnVoQKk0yWRcZ9S5yqi2UyBV
   MA8JVmu+InHjhzdMVGyDU9JlHWCEL2dzlcutHT/RlS2p6luc6CI7Ynk4C
   mUD4obFSkNMrfDy8TBOX6FDSe2hpjnu6BF12HwpGUtRWUjgYnV6Vw7XCB
   CtBWfRfUfiJXz+SqGrNUjh720nHV9mzy+298sfKaC0x5inHAzZUeykzqv
   DJCNJQIzvIe6SD+rNgHSPBD8YJLpavvCkhBGtHxdJK+aReYrDuo7M6O4c
   Q==;
X-CSE-ConnectionGUID: P54LWji2QauNo8bfcrFodQ==
X-CSE-MsgGUID: g2s8Nc5cRdekB7qqztlHBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39371896"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39371896"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:52:54 -0800
X-CSE-ConnectionGUID: 3W+/JMlsRw+s2Dj99EDLPQ==
X-CSE-MsgGUID: 2IRSlQ1hSWGEeO+Ja6xtuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110652396"
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
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 3/4] igb: split igb_msg_task()
Date: Tue,  4 Feb 2025 09:52:39 -0800
Message-ID: <20250204175243.810189-4-anthony.l.nguyen@intel.com>
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

From the perspective of PREEMPT_RT, igb_msg_task() invokes functions
that are a mix of IRQ-safe and non-IRQ-safe operations.

To address this, we separate igb_msg_task() into distinct IRQ-safe and
preemptible-safe components. This is a preparatory step for upcoming
commits, where the igb_msix_other interrupt handler will be split into
IRQ and threaded handlers, each invoking the appropriate part of the
newly divided igb_msg_task().

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 88 +++++++++++++++++++++--
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 4e75c88f6214..6d590192c27f 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -146,6 +146,8 @@ static int igb_vlan_rx_kill_vid(struct net_device *, __be16, u16);
 static void igb_restore_vlan(struct igb_adapter *);
 static void igb_rar_set_index(struct igb_adapter *, u32);
 static void igb_ping_all_vfs(struct igb_adapter *);
+static void igb_msg_task_irq_safe(struct igb_adapter *adapter);
+static void igb_msg_task_preemptible_safe(struct igb_adapter *adapter);
 static void igb_msg_task(struct igb_adapter *);
 static void igb_vmm_control(struct igb_adapter *);
 static int igb_set_vf_mac(struct igb_adapter *, int, unsigned char *);
@@ -3681,6 +3683,30 @@ static __always_inline void vfs_unlock_irqrestore(struct igb_adapter *adapter,
 	raw_spin_unlock_irqrestore(&adapter->raw_vfs_lock, flags);
 	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 }
+
+static __always_inline void vfs_spin_lock_irqsave(struct igb_adapter *adapter,
+						  unsigned long *flags)
+{
+	spin_lock_irqsave(&adapter->vfs_lock, *flags);
+}
+
+static __always_inline void vfs_spin_unlock_irqrestore(struct igb_adapter *adapter,
+						       unsigned long flags)
+{
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+}
+
+static __always_inline void vfs_raw_spin_lock_irqsave(struct igb_adapter *adapter,
+						      unsigned long *flags)
+{
+	raw_spin_lock_irqsave(&adapter->raw_vfs_lock, *flags);
+}
+
+static __always_inline void vfs_raw_spin_unlock_irqrestore(struct igb_adapter *adapter,
+							   unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&adapter->raw_vfs_lock, flags);
+}
 #else
 static __always_inline void vfs_lock_init(struct igb_adapter *adapter)
 {
@@ -3696,6 +3722,30 @@ static __always_inline void vfs_unlock_irqrestore(struct igb_adapter *adapter, u
 {
 	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
 }
+
+static __always_inline void vfs_spin_lock_irqsave(struct igb_adapter *adapter,
+						  unsigned long *flags)
+{
+	spin_lock_irqsave(&adapter->vfs_lock, *flags);
+}
+
+static __always_inline void vfs_spin_unlock_irqrestore(struct igb_adapter *adapter,
+						       unsigned long flags)
+{
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+}
+
+static __always_inline void vfs_raw_spin_lock_irqsave(struct igb_adapter *adapter,
+						      unsigned long *flags)
+{
+	spin_lock_irqsave(&adapter->vfs_lock, *flags);
+}
+
+static __always_inline void vfs_raw_spin_unlock_irqrestore(struct igb_adapter *adapter,
+							   unsigned long flags)
+{
+	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+}
 #endif
 
 #ifdef CONFIG_PCI_IOV
@@ -8113,27 +8163,51 @@ static void igb_rcv_msg_from_vf(struct igb_adapter *adapter, u32 vf)
 	igb_unlock_mbx(hw, vf);
 }
 
-static void igb_msg_task(struct igb_adapter *adapter)
+/*
+ * Note: the split of irq and preempible safe parts of igb_msg_task()
+ * only makes sense under PREEMPT_RT.
+ * The root cause of igb_rcv_msg_from_vf() is not IRQ safe is because
+ * it calls kcalloc with GFP_ATOMIC, but GFP_ATOMIC is not IRQ safe
+ * in PREEMPT_RT.
+ */
+static void igb_msg_task_irq_safe(struct igb_adapter *adapter)
 {
 	struct e1000_hw *hw = &adapter->hw;
 	unsigned long flags;
 	u32 vf;
 
-	vfs_lock_irqsave(adapter, &flags);
+	vfs_raw_spin_lock_irqsave(adapter, &flags);
 	for (vf = 0; vf < adapter->vfs_allocated_count; vf++) {
 		/* process any reset requests */
 		if (!igb_check_for_rst(hw, vf))
 			igb_vf_reset_event(adapter, vf);
 
-		/* process any messages pending */
-		if (!igb_check_for_msg(hw, vf))
-			igb_rcv_msg_from_vf(adapter, vf);
-
 		/* process any acks */
 		if (!igb_check_for_ack(hw, vf))
 			igb_rcv_ack_from_vf(adapter, vf);
 	}
-	vfs_unlock_irqrestore(adapter, flags);
+	vfs_raw_spin_unlock_irqrestore(adapter, flags);
+}
+
+static void igb_msg_task_preemptible_safe(struct igb_adapter *adapter)
+{
+	struct e1000_hw *hw = &adapter->hw;
+	unsigned long flags;
+	u32 vf;
+
+	vfs_spin_lock_irqsave(adapter, &flags);
+	for (vf = 0; vf < adapter->vfs_allocated_count; vf++) {
+		/* process any messages pending */
+		if (!igb_check_for_msg(hw, vf))
+			igb_rcv_msg_from_vf(adapter, vf);
+	}
+	vfs_spin_unlock_irqrestore(adapter, flags);
+}
+
+static __always_inline void igb_msg_task(struct igb_adapter *adapter)
+{
+	igb_msg_task_irq_safe(adapter);
+	igb_msg_task_preemptible_safe(adapter);
 }
 
 /**
-- 
2.47.1


