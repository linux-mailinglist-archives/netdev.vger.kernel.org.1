Return-Path: <netdev+bounces-199188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52CADF51D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844607ADE44
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56973085A9;
	Wed, 18 Jun 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PPkJYQSW"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C923085A0;
	Wed, 18 Jun 2025 17:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269358; cv=none; b=hSiQMlpisVV/u8VZLvKT34xkYBY6/kz01HkOmfEXUowaVVTqE8ThZByQBFyPkImIqtXATgdtwzll0RWb9BtFuDvyCHn7NsBsyzbQOA2K54+1TYNHg7Y6Pwl6C3es5r7gR+85qvk82yDNj96x54//3XJnZvBZslp7FabQ1ySHCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269358; c=relaxed/simple;
	bh=ALn2j9Qo4vXynfn53zWqfw0fXJmWqmfzwyAt/KCwrF4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qsB4hPVa+uH0AfIX1VhxggaDuvMnOgZXofKmNeIzN2Uws3yD1IIbwG93p+7H82KVDJFvdHGJYDgotj/G0KFCXslj5PENgDtz04E0s8cK5+N7543QZVgFueIxYS9PKPtfFYWdVEtp78zB8Vgu4OCV0l4bcSiDh3Ml28N0VkwFaYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PPkJYQSW; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55IHtdbj377578;
	Wed, 18 Jun 2025 12:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750269339;
	bh=PTqXkeWdOJ01dOchQdWmJ3HLZ+mY40AHiSRqSHI6bU0=;
	h=From:To:CC:Subject:Date;
	b=PPkJYQSWjbFPhgazjQrIQRkzaC1OjJ98bocYItjZV3UX6eLWosLsjPbOPuy0LQRnk
	 pZAYqvSjy2kvvTRiwXw5m7h/bOxoi6GX9Cq9WZZYCiIyuN8iFNYNNSnuznrZPx0llX
	 KyLSaCDF2FXhFto91xin+Mw5d1v6HI75evfAi7QI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55IHtdY6591755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 18 Jun 2025 12:55:39 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 18
 Jun 2025 12:55:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 18 Jun 2025 12:55:38 -0500
Received: from localhost (akira.dhcp.ti.com [10.24.69.4])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55IHtbFZ4143062;
	Wed, 18 Jun 2025 12:55:38 -0500
From: Himanshu Mittal <h-mittal1@ti.com>
To: <h-mittal1@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>, <pratheesh@ti.com>, <prajith@ti.com>
Subject: [PATCH net-next v3] net: ti: icssg-prueth: Add prp offload support to ICSSG driver
Date: Wed, 18 Jun 2025 23:25:36 +0530
Message-ID: <20250618175536.430568-1-h-mittal1@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add support for ICSSG PRP mode which supports offloading of:
 - Packet duplication and PRP trailer insertion
 - Packet duplicate discard and PRP trailer removal

Signed-off-by: Himanshu Mittal <h-mittal1@ti.com>
---
v3-v2:
- Addresses comment to fix structure documentation

v2: https://lore.kernel.org/all/20250618102907.GA1699@horms.kernel.org/

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 12 +++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index a1e013b0a0eb..2aa812cbab92 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -148,8 +148,10 @@ static int prueth_emac_start(struct prueth *prueth)
 
 	if (prueth->is_switch_mode)
 		firmwares = prueth->icssg_switch_firmwares;
-	else if (prueth->is_hsr_offload_mode)
+	else if (prueth->is_hsr_offload_mode && HSR_V1 == prueth->hsr_prp_version)
 		firmwares = prueth->icssg_hsr_firmwares;
+	else if (prueth->is_hsr_offload_mode && PRP_V1 == prueth->hsr_prp_version)
+		firmwares = prueth->icssg_prp_firmwares;
 	else
 		firmwares = prueth->icssg_emac_firmwares;
 
@@ -1527,6 +1529,7 @@ static int prueth_netdevice_event(struct notifier_block *unused,
 	struct netdev_notifier_changeupper_info *info;
 	struct prueth_emac *emac = netdev_priv(ndev);
 	struct prueth *prueth = emac->prueth;
+	enum hsr_version hsr_ndev_version;
 	int ret = NOTIFY_DONE;
 
 	if (ndev->netdev_ops != &emac_netdev_ops)
@@ -1538,6 +1541,11 @@ static int prueth_netdevice_event(struct notifier_block *unused,
 
 		if ((ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES) &&
 		    is_hsr_master(info->upper_dev)) {
+			hsr_get_version(info->upper_dev, &hsr_ndev_version);
+			if (hsr_ndev_version != HSR_V1 && hsr_ndev_version != PRP_V1)
+				return -EOPNOTSUPP;
+			prueth->hsr_prp_version = hsr_ndev_version;
+
 			if (info->linking) {
 				if (!prueth->hsr_dev) {
 					prueth->hsr_dev = info->upper_dev;
@@ -1858,6 +1866,8 @@ static int prueth_probe(struct platform_device *pdev)
 				  prueth->icssg_switch_firmwares, "eth", "sw");
 	icssg_mode_firmware_names(dev, prueth->icssg_emac_firmwares,
 				  prueth->icssg_hsr_firmwares, "eth", "hsr");
+	icssg_mode_firmware_names(dev, prueth->icssg_emac_firmwares,
+				  prueth->icssg_prp_firmwares, "eth", "prp");
 
 	spin_lock_init(&prueth->vtbl_lock);
 	spin_lock_init(&prueth->stats_lock);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index c03e3b3626c1..9ca2e7fdefbd 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -13,6 +13,7 @@
 #include <linux/etherdevice.h>
 #include <linux/genalloc.h>
 #include <linux/if_vlan.h>
+#include <linux/if_hsr.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
@@ -290,6 +291,7 @@ struct icssg_firmwares {
  * @vlan_tbl: VLAN-FID table pointer
  * @hw_bridge_dev: pointer to HW bridge net device
  * @hsr_dev: pointer to the HSR net device
+ * @hsr_prp_version: enum to store the protocol version of hsr master
  * @br_members: bitmask of bridge member ports
  * @hsr_members: bitmask of hsr member ports
  * @prueth_netdevice_nb: netdevice notifier block
@@ -303,6 +305,7 @@ struct icssg_firmwares {
  * @icssg_emac_firmwares: Firmware names for EMAC mode, indexed per MAC
  * @icssg_switch_firmwares: Firmware names for SWITCH mode, indexed per MAC
  * @icssg_hsr_firmwares: Firmware names for HSR mode, indexed per MAC
+ * @icssg_prp_firmwares: Firmware names for PRP mode, indexed per MAC
  */
 struct prueth {
 	struct device *dev;
@@ -332,6 +335,7 @@ struct prueth {
 
 	struct net_device *hw_bridge_dev;
 	struct net_device *hsr_dev;
+	enum hsr_version hsr_prp_version;
 	u8 br_members;
 	u8 hsr_members;
 	struct notifier_block prueth_netdevice_nb;
@@ -349,6 +353,7 @@ struct prueth {
 	struct icssg_firmwares icssg_emac_firmwares[PRUETH_NUM_MACS];
 	struct icssg_firmwares icssg_switch_firmwares[PRUETH_NUM_MACS];
 	struct icssg_firmwares icssg_hsr_firmwares[PRUETH_NUM_MACS];
+	struct icssg_firmwares icssg_prp_firmwares[PRUETH_NUM_MACS];
 };
 
 struct emac_tx_ts_response {
-- 
2.34.1


