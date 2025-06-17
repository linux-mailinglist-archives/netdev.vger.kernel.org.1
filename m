Return-Path: <netdev+bounces-198511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F30DADC7E8
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23263178D0F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B812F215175;
	Tue, 17 Jun 2025 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DInoz4Q8"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6061E5383;
	Tue, 17 Jun 2025 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155547; cv=none; b=Ur8Hlkc/W/w+Gylh2I3cxvWGHsT4Cj0pJ4I3QTK4njkoJGz3YnGjqGktvbCdoDnVmh9u/OvZ0FU0gPjQSb6hthXZV89YO8NJzqw+arRZp9J/FJLyXwt8EmfEy5xl2CiiffQIDDKuI/ZHXbDtc2MD+Uob05lvpi6/4AkcO2aHe4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155547; c=relaxed/simple;
	bh=lWVgHkdCmmhxPJ/pPYm/0EoMpSP4kpv53wc1doly1l0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FhqFUVxvLFRHsvuTQju4XQf1xKsIYd/B2H+TH9wmwENIChHhdDAFW2uhgPVgOdGkLv/8tLG/t6zCK86WLM6nYvzjQq3Kx1b3LFtSUG6XLERRELZxEREoJJwMaregQhsRmmmqIVdbeHI+EfI3qxClLmQGa0POBmT4kFd4C0DWaCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DInoz4Q8; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55HAId552851641;
	Tue, 17 Jun 2025 05:18:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750155519;
	bh=H5JYcPxPvOm/wQvlylxZSm+Bf6z0WAAFiSnAvpWknfg=;
	h=From:To:CC:Subject:Date;
	b=DInoz4Q8qwcy235WKiiEeVQ7+yWTB9Sd9QZPsMXp3wip8Kq0PzBC72IK9eIL1BZAO
	 fsIg1Ak6nA6z/3KtXfjGw5ZSBDZgO7qy6RcfxhfLDCM1mIlxPkEPRbrbW9r4X0nIQE
	 p0fN5f2X6ocbMJUOi5+M6FxmZW1g80fz2JMpEsOQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55HAId4Q3522504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 17 Jun 2025 05:18:39 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 17
 Jun 2025 05:18:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 17 Jun 2025 05:18:38 -0500
Received: from localhost (akira.dhcp.ti.com [10.24.69.4])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55HAIb9A1511897;
	Tue, 17 Jun 2025 05:18:38 -0500
From: Himanshu Mittal <h-mittal1@ti.com>
To: <h-mittal1@ti.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>, <pratheesh@ti.com>, <prajith@ti.com>
Subject: [PATCH net-next v2] net: ti: icssg-prueth: Add prp offload support to ICSSG driver
Date: Tue, 17 Jun 2025 15:48:37 +0530
Message-ID: <20250617101837.381217-1-h-mittal1@ti.com>
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
v2-v1:
- Align with recent firmware name handling updates made in:
 https://lore.kernel.org/all/20250613064547.44394-1-danishanwar@ti.com/

v1: https://lore.kernel.org/all/42ac0736-cb5a-4d99-a11c-6f861adbdb5f@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 12 +++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  4 ++++
 2 files changed, 15 insertions(+), 1 deletion(-)

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
index c03e3b3626c1..4a9940b12e47 100644
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
@@ -332,6 +334,7 @@ struct prueth {
 
 	struct net_device *hw_bridge_dev;
 	struct net_device *hsr_dev;
+	enum hsr_version hsr_prp_version;
 	u8 br_members;
 	u8 hsr_members;
 	struct notifier_block prueth_netdevice_nb;
@@ -349,6 +352,7 @@ struct prueth {
 	struct icssg_firmwares icssg_emac_firmwares[PRUETH_NUM_MACS];
 	struct icssg_firmwares icssg_switch_firmwares[PRUETH_NUM_MACS];
 	struct icssg_firmwares icssg_hsr_firmwares[PRUETH_NUM_MACS];
+	struct icssg_firmwares icssg_prp_firmwares[PRUETH_NUM_MACS];
 };
 
 struct emac_tx_ts_response {
-- 
2.34.1


