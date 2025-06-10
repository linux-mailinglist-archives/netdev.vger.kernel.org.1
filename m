Return-Path: <netdev+bounces-195947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8521FAD2DCD
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1243A11E5
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 06:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62911E8358;
	Tue, 10 Jun 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="toxh8ybx"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FB32163BD;
	Tue, 10 Jun 2025 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749536216; cv=none; b=KXa5JVgbJvzVMiVhYGovYStgC1nLFLOvC+eRxPKRlqk5ZXRItADj4PdiDFruvtkHV4pAmgJaJT2JF596x0uTBjhX5kDTbIrLcwNLf/d3SgwfdBiM6hnZ8Kw06mRF12XzYkvbO2yT/fbu7Lkc2zmPW87GOrkhUfBmwQ6vOg5+sR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749536216; c=relaxed/simple;
	bh=CZ+kCbfqNafjJHBBswE7R5WpV86k36fuwntQQPYxvLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lPNDob9t0mBiZMtwHeMaqRV0AEsx4TS6MISqfI6ytTKgZqHOIOnBUmK9kPSSXBftZRAdyrpL/KGMNEsTt27cflO/TnZQJ33pp+PIOG63yMmiXcfyiLIcwtNnBVKerGQabdM7HhpFlbppbRiKt9H5UboTbKb9LtNv2j/3xCL2D7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=toxh8ybx; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55A6GeAn2202387;
	Tue, 10 Jun 2025 01:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1749536200;
	bh=2yH8BB10rwYOkRXdp18lG+iXwMuV7jIvlVlKDcjTkGw=;
	h=From:To:CC:Subject:Date;
	b=toxh8ybxtfM4nMbZ9x+mzssj3M9jn++2m+5xQjlPRlEb5X1Um4nxRC7m04iBvL8JN
	 vz0ZWKUwpHO0m9P0dXAp9tV53HlTgzSM3Yx/fstqhkQvKtICWhlXEqaLkTISklft8p
	 TVmkrP9Q1eJ0o4S6eqNHjUkpZtImZA+WOHRC5ItE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55A6Ge5n164656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 10 Jun 2025 01:16:40 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Jun 2025 01:16:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Jun 2025 01:16:39 -0500
Received: from localhost (akira.dhcp.ti.com [10.24.69.4])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55A6GcYT2608655;
	Tue, 10 Jun 2025 01:16:39 -0500
From: Himanshu Mittal <h-mittal1@ti.com>
To: <h-mittal1@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>, <pratheesh@ti.com>, <prajith@ti.com>
Subject: [PATCH net-next] net: ti: icssg-prueth: Add prp offload support to ICSSG driver
Date: Tue, 10 Jun 2025 11:46:38 +0530
Message-ID: <20250610061638.62822-1-h-mittal1@ti.com>
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
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 23 +++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 86fc1278127c..65883c7851c5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -138,6 +138,19 @@ static struct icssg_firmwares icssg_hsr_firmwares[] = {
 	}
 };
 
+static struct icssg_firmwares icssg_prp_firmwares[] = {
+	{
+		.pru = "ti-pruss/am65x-sr2-pru0-pruprp-fw.elf",
+		.rtu = "ti-pruss/am65x-sr2-rtu0-pruprp-fw.elf",
+		.txpru = "ti-pruss/am65x-sr2-txpru0-pruprp-fw.elf",
+	},
+	{
+		.pru = "ti-pruss/am65x-sr2-pru1-pruprp-fw.elf",
+		.rtu = "ti-pruss/am65x-sr2-rtu1-pruprp-fw.elf",
+		.txpru = "ti-pruss/am65x-sr2-txpru1-pruprp-fw.elf",
+	}
+};
+
 static struct icssg_firmwares icssg_switch_firmwares[] = {
 	{
 		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
@@ -187,8 +200,10 @@ static int prueth_emac_start(struct prueth *prueth)
 
 	if (prueth->is_switch_mode)
 		firmwares = icssg_switch_firmwares;
-	else if (prueth->is_hsr_offload_mode)
+	else if (prueth->is_hsr_offload_mode && HSR_V1 == prueth->hsr_prp_version)
 		firmwares = icssg_hsr_firmwares;
+	else if (prueth->is_hsr_offload_mode && PRP_V1 == prueth->hsr_prp_version)
+		firmwares = icssg_prp_firmwares;
 	else
 		firmwares = icssg_emac_firmwares;
 
@@ -1566,6 +1581,7 @@ static int prueth_netdevice_event(struct notifier_block *unused,
 	struct netdev_notifier_changeupper_info *info;
 	struct prueth_emac *emac = netdev_priv(ndev);
 	struct prueth *prueth = emac->prueth;
+	enum hsr_version hsr_ndev_version;
 	int ret = NOTIFY_DONE;
 
 	if (ndev->netdev_ops != &emac_netdev_ops)
@@ -1577,6 +1593,11 @@ static int prueth_netdevice_event(struct notifier_block *unused,
 
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
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 23c465f1ce7f..02d9d76cd287 100644
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
@@ -329,6 +331,7 @@ struct prueth {
 
 	struct net_device *hw_bridge_dev;
 	struct net_device *hsr_dev;
+	enum hsr_version hsr_prp_version;
 	u8 br_members;
 	u8 hsr_members;
 	struct notifier_block prueth_netdevice_nb;
-- 
2.34.1


