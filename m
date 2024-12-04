Return-Path: <netdev+bounces-148943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326369E391E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5FB7282E6B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 11:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A181B4152;
	Wed,  4 Dec 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMYAF5TX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30351AE863
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733312625; cv=none; b=TapkGDo4kBMlJ6qvxGAvlnslRERrxRT2NDfbCPvmMy6O/3x/Wx2H7Ep0sqakuBFUuUSH11iujaR5M/8ASo7l0kW9QsIfIHStb764zNdZLuLlsnpfxZz8WQeQfB4gu3D9+g2TDrPkxFII+blB/QFU7eE9sgGqFw41Pbs14455KF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733312625; c=relaxed/simple;
	bh=6pOZwGCmloHsmVGZv/rVxnHFHdoX+lPrF/GXyDFQxGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gL5h99t3p9+Tc5R7Q23R8oAgOwO8gP28jcwOktXPnoSkPhH/c1aEC9LXjkBHyIJu028wORMkrn6kHtDCbbrPw4IInXYh3swL15xjeIyn0akJkTgRNLE6nu5nGd95vt3Qw/GfgOhfPLlCP4IeWweKXBsGqv+O14HsgWHX04cvjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMYAF5TX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733312623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOTYSXLeLG/VXXfQqMnchfUvQ+U6U+p7WeEdqM7zheA=;
	b=TMYAF5TX+oKXdkj72U5m4MA8tHbmXxyNV7C54ockdwQuDs7VTvIn6nJjHyuDwke+dOA6YP
	sQzyoM/QLthwmKmp6G73OQ7FhguHMOv47jt6Qz5/hItTXWwqHM3pDDqcnL5yYQ//S1MXbB
	sSTtwge9huMUpz6kxQ3t0YGGPaNK1Hc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-wgdQ46f1ORGI3g8c15s_sQ-1; Wed,
 04 Dec 2024 06:43:37 -0500
X-MC-Unique: wgdQ46f1ORGI3g8c15s_sQ-1
X-Mimecast-MFC-AGG-ID: wgdQ46f1ORGI3g8c15s_sQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5D851953940;
	Wed,  4 Dec 2024 11:43:34 +0000 (UTC)
Received: from wcosta-thinkpadt14gen4.rmtbr.csb (unknown [10.22.88.52])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC95C3000197;
	Wed,  4 Dec 2024 11:43:27 +0000 (UTC)
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
	Jeff Garzik <jgarzik@redhat.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT)
Cc: Wander Lairson Costa <wander@redhat.com>,
	Clark Williams <williams@redhat.com>
Subject: [PATCH iwl-net 2/4] igb: introduce raw vfs_lock to igb_adapter
Date: Wed,  4 Dec 2024 08:42:25 -0300
Message-ID: <20241204114229.21452-3-wander@redhat.com>
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
---
 drivers/net/ethernet/intel/igb/igb.h      |  4 ++
 drivers/net/ethernet/intel/igb/igb_main.c | 51 ++++++++++++++++++++---
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 3c2dc7bdebb50..d50c22f09d0f8 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -666,6 +666,10 @@ struct igb_adapter {
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
index 4ca25660e876e..9b4235ec226df 100644
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
@@ -8035,7 +8076,7 @@ static void igb_msg_task(struct igb_adapter *adapter)
 	unsigned long flags;
 	u32 vf;
 
-	spin_lock_irqsave(&adapter->vfs_lock, flags);
+	vfs_lock_irqsave(adapter, &flags);
 	for (vf = 0; vf < adapter->vfs_allocated_count; vf++) {
 		/* process any reset requests */
 		if (!igb_check_for_rst(hw, vf))
@@ -8049,7 +8090,7 @@ static void igb_msg_task(struct igb_adapter *adapter)
 		if (!igb_check_for_ack(hw, vf))
 			igb_rcv_ack_from_vf(adapter, vf);
 	}
-	spin_unlock_irqrestore(&adapter->vfs_lock, flags);
+	vfs_unlock_irqrestore(adapter, flags);
 }
 
 /**
-- 
2.47.0


