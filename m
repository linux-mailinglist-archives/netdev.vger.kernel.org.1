Return-Path: <netdev+bounces-148945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85FD9E3920
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76CFC1685AD
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FB01B4F21;
	Wed,  4 Dec 2024 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHvXOgc1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC691B392F
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312637; cv=none; b=TllIifLZ+9vezsY3rM8HKtDqfSLYMJp2pSoUgv8Qxl7/A8yYxomTnQc2otkUeHXjbXQBLlDcERi48P/mwOim0BARzMiHee0BMhXNxB/R51JbVM40Ib6TmyGrmGbz7qunJax3rS45zHmHYZ9M2VAFVwGHAJBD7cHc/UBA1xUITxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312637; c=relaxed/simple;
	bh=TEOVhC2PqVwxsX1BsUmknWTUa83DbpCDkU31ggicte0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhVRH4h0cNc6xmKreWXFQ67hTBj+aV/PauZFPH3lNM8T5Z0Q3KEwIuJBBAbxpyg2siLX2CKRv1LF5QKpWLeopOW1qF/EqIkR0TS6AD8TiA5skzE8QBu13oKvzG/VEvMCDZ/15k7pH8JlzALFbPq1HYqfVr6bQCm+mTFYkYLVEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHvXOgc1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733312634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4OzJ2Yicwkoa/Gn8s9Kz6ryvpeCxefm3yl1+gEE2Ro=;
	b=HHvXOgc1/b/NFH/OO8tNaZE7NPxwB2kztncaIRbALSq64vgWJeqp/ANNt2vzHuyejHrDrZ
	Gznu2M7o7NXNnhiRfvhtKTzArSFpfRq0fSjQcpSukiNf/y9/0DsSlNsi2qlO++ZG8oKykg
	pofYVRa05cxeLb8QyiTMAlrn7QeO+js=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-5TspYdiBP0ab5yCLjwMkAw-1; Wed,
 04 Dec 2024 06:43:52 -0500
X-MC-Unique: 5TspYdiBP0ab5yCLjwMkAw-1
X-Mimecast-MFC-AGG-ID: 5TspYdiBP0ab5yCLjwMkAw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DED91955F3F;
	Wed,  4 Dec 2024 11:43:49 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04D023000197;
	Wed,  4 Dec 2024 11:43:42 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	Jeff Garzik <jgarzik@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: Wander Lairson Costa <wander@redhat.com>,
	Yuying Ma <yuma@redhat.com>
Subject: [PATCH iwl-net 4/4] igb: fix igb_msix_other() handling for PREEMPT_RT
Date: Wed,  4 Dec 2024 08:42:27 -0300
Message-ID: <20241204114229.21452-5-wander@redhat.com>
In-Reply-To: <20241204114229.21452-1-wander@redhat.com>
References: <20241204114229.21452-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
---
 drivers/net/ethernet/intel/igb/igb_main.c | 35 ++++++++++++++++-------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5828831fd29c2..b2894cebe2c9e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -131,6 +131,7 @@ static void igb_set_uta(struct igb_adapter *adapter, bool set);
 static irqreturn_t igb_intr(int irq, void *);
 static irqreturn_t igb_intr_msi(int irq, void *);
 static irqreturn_t igb_msix_other(int irq, void *);
+static irqreturn_t igb_msix_other_threaded(int irq, void *);
 static irqreturn_t igb_msix_ring(int irq, void *);
 #ifdef CONFIG_IGB_DCA
 static void igb_update_dca(struct igb_q_vector *);
@@ -151,7 +152,6 @@ static void igb_rar_set_index(struct igb_adapter *, u32);
 static void igb_ping_all_vfs(struct igb_adapter *);
 static void igb_msg_task_irq_safe(struct igb_adapter *adapter);
 static void igb_msg_task_preemptible_safe(struct igb_adapter *adapter);
-static void igb_msg_task(struct igb_adapter *);
 static void igb_vmm_control(struct igb_adapter *);
 static int igb_set_vf_mac(struct igb_adapter *, int, unsigned char *);
 static void igb_flush_mac_table(struct igb_adapter *);
@@ -908,8 +908,9 @@ static int igb_request_msix(struct igb_adapter *adapter)
 	struct net_device *netdev = adapter->netdev;
 	int i, err = 0, vector = 0, free_vector = 0;
 
-	err = request_irq(adapter->msix_entries[vector].vector,
-			  igb_msix_other, 0, netdev->name, adapter);
+	err = request_threaded_irq(adapter->msix_entries[vector].vector,
+				   igb_msix_other, igb_msix_other_threaded,
+				   IRQF_NO_THREAD, netdev->name, adapter);
 	if (err)
 		goto err_out;
 
@@ -7113,9 +7114,27 @@ static irqreturn_t igb_msix_other(int irq, void *data)
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
@@ -8161,12 +8180,6 @@ static void igb_msg_task_preemptible_safe(struct igb_adapter *adapter)
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
2.47.0


