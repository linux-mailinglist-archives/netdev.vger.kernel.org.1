Return-Path: <netdev+bounces-96414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3EC8C5B24
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA871C219B1
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A50F144D3E;
	Tue, 14 May 2024 18:36:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from EX-PRD-EDGE01.vmware.com (EX-PRD-EDGE01.vmware.com [208.91.3.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AB180A61;
	Tue, 14 May 2024 18:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.91.3.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711787; cv=none; b=K1uBsSGlu7dxkoelRD3lX9EMOQQko6/OGsDeZw2GfMFs4BdtHtrCZUZvJehXt6yK+aYrFBDjvuKRpaLk8qmevpFvmtRyq1zIZNag6EQS+vRUc8o2xJCQijTzJYZ/sp5bcGCRf1Z3eiEI8Xw0+Ib5MKKXh49s0m9Sqg93nawGLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711787; c=relaxed/simple;
	bh=UaV11EJDKhayJ4pE+bHk6XCQKZJIPyUBdUfILaFIwEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8/BaDKsFay1DtD7wgIaMWSZUr3LTV2+yvFu2B5RTfPC6JNEjBXQtMsFAecK6Lw+7jTBK4MakZijAX77ALcAuw64DU2dLnOGsbkaUFOnA1uW98R0dSJ1Qwo9G08F0bXm5G2ycFjrKd++LaxeJKXQxxF+CyjlG4uo4tzOByjauBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com; spf=pass smtp.mailfrom=vmware.com; arc=none smtp.client-ip=208.91.3.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vmware.com
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX-PRD-EDGE01.vmware.com (10.188.245.6) with Microsoft SMTP Server id
 15.1.2375.34; Tue, 14 May 2024 11:20:59 -0700
Received: from htb-1n-eng-dhcp122.eng.vmware.com (unknown [10.172.6.252])
	by sc9-mailhost2.vmware.com (Postfix) with ESMTP id AADF6202D7;
	Tue, 14 May 2024 11:21:07 -0700 (PDT)
Received: by htb-1n-eng-dhcp122.eng.vmware.com (Postfix, from userid 0)
	id A8FA1AECCE; Tue, 14 May 2024 11:21:07 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: <netdev@vger.kernel.org>
CC: Ronak Doshi <ronak.doshi@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 3/4] vmxnet3: add command to allow disabling of offloads
Date: Tue, 14 May 2024 11:20:48 -0700
Message-ID: <20240514182050.20931-4-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240514182050.20931-1-ronak.doshi@broadcom.com>
References: <20240514182050.20931-1-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: SoftFail (EX-PRD-EDGE01.vmware.com: domain of transitioning
 ronak.doshi@broadcom.com discourages use of 10.113.161.72 as permitted
 sender)

This patch adds a new command to disable certain offloads. This
allows user to specify, using VM configuration, if certain offloads
need to be disabled.

Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
---
 drivers/net/vmxnet3/vmxnet3_defs.h    |  4 ++++
 drivers/net/vmxnet3/vmxnet3_drv.c     | 19 +++++++++++++++++++
 drivers/net/vmxnet3/vmxnet3_ethtool.c |  8 ++++++++
 drivers/net/vmxnet3/vmxnet3_int.h     |  1 +
 4 files changed, 32 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_defs.h b/drivers/net/vmxnet3/vmxnet3_defs.h
index dcf1cf8e7a86..5e56e1d42f77 100644
--- a/drivers/net/vmxnet3/vmxnet3_defs.h
+++ b/drivers/net/vmxnet3/vmxnet3_defs.h
@@ -126,6 +126,7 @@ enum {
 	VMXNET3_CMD_GET_MAX_CAPABILITIES,
 	VMXNET3_CMD_GET_DCR0_REG,
 	VMXNET3_CMD_GET_TSRING_DESC_SIZE,
+	VMXNET3_CMD_GET_DISABLED_OFFLOADS,
 };
 
 /*
@@ -912,4 +913,7 @@ struct Vmxnet3_DriverShared {
 /* when new capability is introduced, update VMXNET3_CAP_MAX */
 #define VMXNET3_CAP_MAX                            VMXNET3_CAP_VERSION_7_MAX
 
+#define VMXNET3_OFFLOAD_TSO         (1 << 0)
+#define VMXNET3_OFFLOAD_LRO         (1 << 1)
+
 #endif /* _VMXNET3_DEFS_H_ */
diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 74cb63e3d311..2eaa9204c38e 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -3646,6 +3646,15 @@ static void
 vmxnet3_declare_features(struct vmxnet3_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	unsigned long flags;
+
+	if (VMXNET3_VERSION_GE_9(adapter)) {
+		spin_lock_irqsave(&adapter->cmd_lock, flags);
+		VMXNET3_WRITE_BAR1_REG(adapter, VMXNET3_REG_CMD,
+				       VMXNET3_CMD_GET_DISABLED_OFFLOADS);
+		adapter->disabledOffloads = VMXNET3_READ_BAR1_REG(adapter, VMXNET3_REG_CMD);
+		spin_unlock_irqrestore(&adapter->cmd_lock, flags);
+	}
 
 	netdev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 		NETIF_F_HW_CSUM | NETIF_F_HW_VLAN_CTAG_TX |
@@ -3663,6 +3672,16 @@ vmxnet3_declare_features(struct vmxnet3_adapter *adapter)
 			NETIF_F_GSO_UDP_TUNNEL_CSUM;
 	}
 
+	if (adapter->disabledOffloads & VMXNET3_OFFLOAD_TSO) {
+		netdev->hw_features &= ~(NETIF_F_TSO | NETIF_F_TSO6);
+		netdev->hw_enc_features &= ~(NETIF_F_TSO | NETIF_F_TSO6);
+	}
+
+	if (adapter->disabledOffloads & VMXNET3_OFFLOAD_LRO) {
+		netdev->hw_features &= ~(NETIF_F_LRO);
+		netdev->hw_enc_features &= ~(NETIF_F_LRO);
+	}
+
 	if (VMXNET3_VERSION_GE_7(adapter)) {
 		unsigned long flags;
 
diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index 471f91c4204a..b78cda41f643 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -270,6 +270,14 @@ netdev_features_t vmxnet3_fix_features(struct net_device *netdev,
 	if (!(features & NETIF_F_RXCSUM))
 		features &= ~NETIF_F_LRO;
 
+	if ((features & NETIF_F_LRO) &&
+	    (adapter->disabledOffloads & VMXNET3_OFFLOAD_LRO))
+		features &= ~NETIF_F_LRO;
+
+	if ((features & (NETIF_F_TSO | NETIF_F_TSO6)) &&
+	    (adapter->disabledOffloads & VMXNET3_OFFLOAD_TSO))
+		features &= ~(NETIF_F_TSO | NETIF_F_TSO6);
+
 	/* If XDP is enabled, then LRO should not be enabled */
 	if (vmxnet3_xdp_enabled(adapter) && (features & NETIF_F_LRO)) {
 		netdev_err(netdev, "LRO is not supported with XDP");
diff --git a/drivers/net/vmxnet3/vmxnet3_int.h b/drivers/net/vmxnet3/vmxnet3_int.h
index 68358e71526c..31e8db568db2 100644
--- a/drivers/net/vmxnet3/vmxnet3_int.h
+++ b/drivers/net/vmxnet3/vmxnet3_int.h
@@ -454,6 +454,7 @@ struct vmxnet3_adapter {
 	/* Size of buffer in the ts ring */
 	u16     tx_ts_desc_size;
 	u16     rx_ts_desc_size;
+	u32     disabledOffloads;
 };
 
 #define VMXNET3_WRITE_BAR0_REG(adapter, reg, val)  \
-- 
2.11.0


