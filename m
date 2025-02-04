Return-Path: <netdev+bounces-162665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAE8A27902
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C3881887E6D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC241216611;
	Tue,  4 Feb 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTKQvEYn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11012165F7
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691578; cv=none; b=iFGVIB2pgJRCpg/bHz2GdCAD2+Xdw0AKz/BzNx1z4aNT54TLDMqY+RJWZwpimyTgirIm0q+39XatPEMbXfaX8UZl1AIRmtnS7JJDuZxbjRQBWPO7q9O5rdbncmioredyQSHLJPP1C0CMF4hf5O++kM+KoeLI1HiXG+zX8o+42MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691578; c=relaxed/simple;
	bh=2QsB+IUnFx+X0yxAJ3ioapItqWtm0WFT+lDWHUDiofE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csf7kcCSaT6nMsy0pqCGS+JbQ+Y6qsPnu5eP5hpWQJfgP/yMCokDhcDPjiCFEyTU3HjsJ+qQnmqTpOZW81jQgdFuMq8xgOrfStOxKjGdZqlt7J0mKhwpRLawmiUCHCCqVmI1nmKQTXKXIBrHMT/HmoJfID7T39zzoowDKFdkugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTKQvEYn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691577; x=1770227577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2QsB+IUnFx+X0yxAJ3ioapItqWtm0WFT+lDWHUDiofE=;
  b=LTKQvEYnV4ZoTf/4TWdW3oWQGSR8WWqbkohbFnOY0OEUKFMU8CI99yz/
   jDMncYPbFsb6NPnpVSO/kDrbj4EUZa1/DhsZo2YHo3VLMwlHmiPIcWHJl
   SjczbjNEyhWPzQxj44jzbnErNFqtLjAIx65OOueSl2o5RXOc0bNlAx4Iy
   pQ3QB+OZc/Zxs7LNhX5MTYiwLkwEJBuz4tQ8GzdO72ApM0SblvIIGvr7e
   VGAUvYd2JJOrBhaX1PHIfg1UEAiDO2hxzz49O2bw/Ceq3a7xa8E7NGaDa
   ad+ar03NjVizcMaG/TZVmem0P7GcxKP+IucUSkMf3dVJatTyyJYCEKq+T
   g==;
X-CSE-ConnectionGUID: QdzCytRiQVG2Tnk+qQOYIg==
X-CSE-MsgGUID: i7MabNnCRpqwSutYHaaxNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39371905"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39371905"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:52:54 -0800
X-CSE-ConnectionGUID: dWtmlRkMRlCBjsf+tvueSA==
X-CSE-MsgGUID: kb3uPnDsQC6DK2z4SvZgug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="110652399"
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
Subject: [PATCH net 4/4] igb: fix igb_msix_other() handling for PREEMPT_RT
Date: Tue,  4 Feb 2025 09:52:40 -0800
Message-ID: <20250204175243.810189-5-anthony.l.nguyen@intel.com>
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

During testing of SR-IOV, Red Hat QE encountered an issue where the
ip link up command intermittently fails for the igbvf interfaces when
using the PREEMPT_RT variant. Investigation revealed that
e1000_write_posted_mbx returns an error due to the lack of an ACK
from e1000_poll_for_ack.

The underlying issue arises from the fact that IRQs are threaded by
default under PREEMPT_RT. While the exact hardware details are not
available, it appears that the IRQ handled by igb_msix_other must
be processed before e1000_poll_for_ack times out. However,
e1000_write_posted_mbx is called with preemption disabled, leading
to a scenario where the IRQ is serviced only after the failure of
e1000_write_posted_mbx.

Commit 338c4d3902fe ("igb: Disable threaded IRQ for igb_msix_other")
forced the ISR to run in a non-threaded context. However, Sebastian
observed that some functions called within the ISR acquire locks that
may sleep.

In the previous two patches, we managed to make igb_msg_mask() safe to
call from an interrupt context.

In this commit, we move most of the ISR handling to an interrupt
context, leaving non IRQ safe code to be called from the thread
context under PREEMPT_RT.

Reproducer:

ipaddr_vlan=3
nic_test=ens14f0
vf=${nic_test}v0 # The main testing steps:
while true; do
    ip link set ${nic_test} mtu 1500
    ip link set ${vf} mtu 1500
    ip link set $vf up
    # 3. set vlan and ip for VF
    ip link set ${nic_test} vf 0 vlan ${ipaddr_vlan}
    ip addr add 172.30.${ipaddr_vlan}.1/24 dev ${vf}
    ip addr add 2021:db8:${ipaddr_vlan}::1/64 dev ${vf}
    # 4. check the link state for VF and PF
    ip link show ${nic_test}
    if ! ip link show $vf | grep 'state UP'; then
        echo 'Error found'
        break
    fi
    ip link set $vf down
done

You can also reproduce it more reliably by setting nr_cpus=1 in the
kernel command line.

Fixes: 9d5c824399de ("igb: PCI-Express 82575 Gigabit Ethernet driver")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reported-by: Yuying Ma <yuma@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 35 ++++++++++++++++-------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 6d590192c27f..3cc85584d9ce 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -128,6 +128,7 @@ static void igb_set_uta(struct igb_adapter *adapter, bool set);
 static irqreturn_t igb_intr(int irq, void *);
 static irqreturn_t igb_intr_msi(int irq, void *);
 static irqreturn_t igb_msix_other(int irq, void *);
+static irqreturn_t igb_msix_other_threaded(int irq, void *);
 static irqreturn_t igb_msix_ring(int irq, void *);
 #ifdef CONFIG_IGB_DCA
 static void igb_update_dca(struct igb_q_vector *);
@@ -148,7 +149,6 @@ static void igb_rar_set_index(struct igb_adapter *, u32);
 static void igb_ping_all_vfs(struct igb_adapter *);
 static void igb_msg_task_irq_safe(struct igb_adapter *adapter);
 static void igb_msg_task_preemptible_safe(struct igb_adapter *adapter);
-static void igb_msg_task(struct igb_adapter *);
 static void igb_vmm_control(struct igb_adapter *);
 static int igb_set_vf_mac(struct igb_adapter *, int, unsigned char *);
 static void igb_flush_mac_table(struct igb_adapter *);
@@ -914,8 +914,9 @@ static int igb_request_msix(struct igb_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i, err = 0, vector = 0, free_vector = 0;
 
-	err = request_irq(adapter->msix_entries[vector].vector,
-			  igb_msix_other, 0, netdev->name, adapter);
+	err = request_threaded_irq(adapter->msix_entries[vector].vector,
+				   igb_msix_other, igb_msix_other_threaded,
+				   IRQF_NO_THREAD, netdev->name, adapter);
 	if (err)
 		goto err_out;
 
@@ -7156,9 +7157,27 @@ static irqreturn_t igb_msix_other(int irq, void *data)
 		igb_check_wvbr(adapter);
 	}
 
-	/* Check for a mailbox event */
+	/* Check for a mailbox event (interrupt safe part) */
 	if (icr & E1000_ICR_VMMB)
-		igb_msg_task(adapter);
+		igb_msg_task_irq_safe(adapter);
+
+	adapter->test_icr = icr;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		return igb_msix_other_threaded(irq, data);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t igb_msix_other_threaded(int irq, void *data)
+{
+	struct igb_adapter *adapter = data;
+	struct e1000_hw *hw = &adapter->hw;
+	u32 icr = adapter->test_icr;
+
+	/* Check for a mailbox event (preempible safe part) */
+	if (icr & E1000_ICR_VMMB)
+		igb_msg_task_preemptible_safe(adapter);
 
 	if (icr & E1000_ICR_LSC) {
 		hw->mac.get_link_status = 1;
@@ -8204,12 +8223,6 @@ static void igb_msg_task_preemptible_safe(struct igb_adapter *adapter)
 	vfs_spin_unlock_irqrestore(adapter, flags);
 }
 
-static __always_inline void igb_msg_task(struct igb_adapter *adapter)
-{
-	igb_msg_task_irq_safe(adapter);
-	igb_msg_task_preemptible_safe(adapter);
-}
-
 /**
  *  igb_set_uta - Set unicast filter table address
  *  @adapter: board private structure
-- 
2.47.1


