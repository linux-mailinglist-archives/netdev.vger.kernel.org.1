Return-Path: <netdev+bounces-96708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8C48C739A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 11:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BFA1C2291E
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7BD143866;
	Thu, 16 May 2024 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BJ6ijVfB"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0329143756;
	Thu, 16 May 2024 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851111; cv=none; b=SUMLSkSH6asEUnxxB9YA58HqSiHO4JAqyeMaFYr222eMYTt8kjeBo5tbuRjesGAFmG2svTN5z0/9vuZPlW5vrAycPsFeGgx9ftC8gKw2oIfHUJleUtKKvMxVgVM9mB1U8kmOOwW8lx5AnmygSbnSSjumQz3IKwR+itsLb69rhRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851111; c=relaxed/simple;
	bh=yooVkyDaL2ZL6kbFXQCdCRX/qDt6VZuPf6Q9SA2heEk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMD+DqO8ciPoT41itTLrn39DKcHAgh0pB7E8F56QaXYph+uF7r0h+lHLpYzkSUD/hfb89tPOxOmTZCTQeMOQxn7zT1pRaA7eOffybgClz2Ld0omZcj4NY52kaGryVGhfOjt8+XxIucHPi30pk6/4OM1VomGqtm/UczjIdv1+ejg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BJ6ijVfB; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44G9Hxma014151;
	Thu, 16 May 2024 04:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715851079;
	bh=N8Ec913Pb8o5Y8U1og1INLrMIXbabvh3TuFbhbleDy8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BJ6ijVfB9GOMeGEejdmAPltEQHXk8W34O/IFlkZDD/c45u7ISo60RTshrfoqZs/bU
	 KUFeYT8YmXL9gGPAx+1TLLKkyH49WmOgKYPRZApToE/MCQQ6+5hK17piYSg1UJu9aJ
	 WuHkumSCiW9v7RyEi4YmUweT6GkKpcod4601b6Pk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44G9Hxnp014952
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 May 2024 04:17:59 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 04:17:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 04:17:58 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44G9HwBt038270;
	Thu, 16 May 2024 04:17:58 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44G9HvmF027568;
	Thu, 16 May 2024 04:17:58 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Diogo Ivo
	<diogo.ivo@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn
	<andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [RFC PATCH net-next 2/2] net: ti: icssg-prueth: Add multicast filtering support
Date: Thu, 16 May 2024 14:47:52 +0530
Message-ID: <20240516091752.2969092-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516091752.2969092-1-danishanwar@ti.com>
References: <20240516091752.2969092-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add multicast filtering support for ICSSG Driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_config.c | 16 +++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 50 ++++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 ++
 3 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 2213374d4d45..4e30bb995078 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -318,17 +318,27 @@ static int prueth_emac_buffer_setup(struct prueth_emac *emac)
 
 static void icssg_init_emac_mode(struct prueth *prueth)
 {
+	u32 addr = prueth->shram.pa + VLAN_STATIC_REG_TABLE_OFFSET;
 	/* When the device is configured as a bridge and it is being brought
 	 * back to the emac mode, the host mac address has to be set as 0.
 	 */
 	u8 mac[ETH_ALEN] = { 0 };
+	int i;
 
 	if (prueth->emacs_initialized)
 		return;
 
-	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1,
-			   SMEM_VLAN_OFFSET_MASK, 0);
-	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, 0);
+	/* Set VLAN TABLE address base */
+	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
+			   addr <<  SMEM_VLAN_OFFSET);
+	/* Configure CFG2 register */
+	regmap_write(prueth->miig_rt, FDB_GEN_CFG2, (FDB_PRU0_EN | FDB_PRU1_EN | FDB_HOST_EN));
+
+	prueth->vlan_tbl = prueth->shram.va + VLAN_STATIC_REG_TABLE_OFFSET;
+	for (i = 0; i < SZ_4K - 1; i++) {
+		prueth->vlan_tbl[i].fid = i;
+		prueth->vlan_tbl[i].fid_c1 = 0;
+	}
 	/* Clear host MAC address */
 	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 7c9e9518f555..bd343c4b6b57 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -417,6 +417,37 @@ const struct icss_iep_clockops prueth_iep_clockops = {
 	.perout_enable = prueth_perout_enable,
 };
 
+static int icssg_prueth_mac_add_mcast(struct net_device *ndev, const u8 *addr)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int port_mask = BIT(emac->port_id);
+
+	port_mask |= icssg_fdb_lookup(emac, addr, 0);
+	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
+	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
+
+	return 0;
+}
+
+static int icssg_prueth_mac_del_mcast(struct net_device *ndev, const u8 *addr)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int port_mask = BIT(emac->port_id);
+	int other_port_mask;
+
+	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
+
+	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
+	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
+
+	if (other_port_mask) {
+		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
+		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
+	}
+
+	return 0;
+}
+
 /**
  * emac_ndo_open - EMAC device open
  * @ndev: network adapter device
@@ -526,6 +557,8 @@ static int emac_ndo_open(struct net_device *ndev)
 
 	prueth->emacs_initialized++;
 
+	__hw_addr_init(&emac->mcast_list);
+
 	queue_work(system_long_wq, &emac->stats_work.work);
 
 	return 0;
@@ -578,6 +611,9 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
 
+	__dev_mc_unsync(ndev, icssg_prueth_mac_del_mcast);
+	__hw_addr_init(&emac->mcast_list);
+
 	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
 	/* ensure new tdown_cnt value is visible */
 	smp_mb__after_atomic();
@@ -654,10 +690,15 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 		return;
 	}
 
-	if (!netdev_mc_empty(ndev)) {
-		emac_set_port_state(emac, ICSSG_EMAC_PORT_MC_FLOODING_ENABLE);
-		return;
-	}
+	/* make a mc list copy */
+
+	netif_addr_lock_bh(ndev);
+	__hw_addr_sync(&emac->mcast_list, &ndev->mc, ndev->addr_len);
+	netif_addr_unlock_bh(ndev);
+
+	__hw_addr_sync_dev(&emac->mcast_list, ndev,
+			   icssg_prueth_mac_add_mcast,
+			   icssg_prueth_mac_del_mcast);
 }
 
 /**
@@ -746,6 +787,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	SET_NETDEV_DEV(ndev, prueth->dev);
 	spin_lock_init(&emac->lock);
 	mutex_init(&emac->cmd_lock);
+	__hw_addr_init(&emac->mcast_list);
 
 	emac->phy_node = of_parse_phandle(eth_node, "phy-handle", 0);
 	if (!emac->phy_node && !of_phy_is_fixed_link(eth_node)) {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 82bdad9702c3..0cad80a437e8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -155,6 +155,9 @@ struct prueth_emac {
 	unsigned int tx_ts_enabled : 1;
 	unsigned int half_duplex : 1;
 
+	/* List for storing mutlicast addresses */
+	struct netdev_hw_addr_list mcast_list;
+
 	/* DMA related */
 	struct prueth_tx_chn tx_chns[PRUETH_MAX_TX_QUEUES];
 	struct completion tdown_complete;
-- 
2.34.1


