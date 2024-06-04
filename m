Return-Path: <netdev+bounces-100548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C20218FB149
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348D6281CAE
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02D31459E9;
	Tue,  4 Jun 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="csPMHLCE"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5151C38B;
	Tue,  4 Jun 2024 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501467; cv=none; b=L+otrAaH/e8T/m74j9szFbJRDzgpM5kmEF+ce2waaPHYZgdbAMHq3vkCuK6uXOhvjZ5KdVXH8493kRwG152KwMiJYpVXPDrNGy6YnhNktkGGCOFWTdXuzLfTO8HUC9AtYBJ3U028oWm+WHh6Uy4GntwHzP4vbys8fZRvx7QujZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501467; c=relaxed/simple;
	bh=GyWiXwi+C4XQpWenOLErDVKWqcsO2RL3DBOKE06RJHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QV5dPH0eOTUP4X5F9zRwxqnHvalx9JzUNn03FC2iDMNBIcJkfeY+38In5nzalYBkepx6H3PIUKQKZ4+ZsG6AkjqihD6RFGzxQ/koyC76MZYJUYGumGlkIzPghpoGZJqYDGZUR3RWb28iG9gcFWTvnfZKx99bACO8pK2xMA6v9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=csPMHLCE; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 454Bi6b1114677;
	Tue, 4 Jun 2024 06:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717501446;
	bh=8cMYbVxYDA4UBQAYxdo5KK8U6XsBARlMjGQd9dkeC4s=;
	h=From:To:CC:Subject:Date;
	b=csPMHLCEacoiDxjqLULAAlKqzuCg/522SoCIv113shrieSNlPLoylT3cr2zUHEnck
	 zmAfHRRLBVA51P04X6kdyUrjuvxw7yi8TRolAfy9c5fMt2ddwJRT0EDnxH7J9T6NnV
	 DYsIZV9o2bJQTpXHw2MQRba/34AUKA3sCP65tNx0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 454Bi635089587
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Jun 2024 06:44:06 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 06:44:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 06:44:06 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 454Bi6eX017524;
	Tue, 4 Jun 2024 06:44:06 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 454Bi50k003940;
	Tue, 4 Jun 2024 06:44:05 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka
	<jan.kiszka@siemens.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Andrew Lunn
	<andrew@lunn.ch>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar
	<danishanwar@ti.com>
Subject: [PATCH net-next v2] net: ti: icssg-prueth: Add multicast filtering support
Date: Tue, 4 Jun 2024 17:14:02 +0530
Message-ID: <20240604114402.1835973-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
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

The driver will keep a copy of multicast addresses in emac->mcast_list.
This list will be kept in sync with the netdev list and to add / del
multicast address icssg_prueth_mac_add_mcast / icssg_prueth_mac_del_mcast
APIs will be called.

To add a mac_address for a port, driver need to call icssg_fdb_add_del()
and pass the mac_address and BIT(port_id) to the API. The ICSSG firmware
will then configure the rules and allow filtering.

If a mac_address is added to port0 and the same mac_address needs to be
added for port1, driver needs to pass BIT(port0) | BIT(port1) to the
icssg_fdb_add_del() API. If driver just pass BIT(port1) then the entry for
port0 will be overwritten / lost. This is a design constraint on the
firmware side.

To overcome this in the driver, to add any mac_address for let's say portX
driver first checks if the same mac_address is already added for any other
port. If yes driver calls icssg_fdb_add_del() with BIT(portX) |
BIT(other_existing_port). If not, driver calls icssg_fdb_add_del() with
BIT(portX).

The same thing is applicable for deleting mac_addresses as well. This
logic is in icssg_prueth_mac_add_mcast / icssg_prueth_mac_del_mcast APIs.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
v1 -> v2:
*) Rebased on latest net-next/main.

NOTE: This series can be applied cleanly on the tip of net-next/main. This
series doesn't depend on any other ICSSG driver related series that is
floating around in netdev.

v1 https://lore.kernel.org/all/20240516091752.2969092-1-danishanwar@ti.com/

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 50 ++++++++++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 ++
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 6e65aa0977d4..03dd49f0afb7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -439,6 +439,37 @@ const struct icss_iep_clockops prueth_iep_clockops = {
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
@@ -547,6 +578,8 @@ static int emac_ndo_open(struct net_device *ndev)
 
 	prueth->emacs_initialized++;
 
+	__hw_addr_init(&emac->mcast_list);
+
 	queue_work(system_long_wq, &emac->stats_work.work);
 
 	return 0;
@@ -599,6 +632,9 @@ static int emac_ndo_stop(struct net_device *ndev)
 
 	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
 
+	__dev_mc_unsync(ndev, icssg_prueth_mac_del_mcast);
+	__hw_addr_init(&emac->mcast_list);
+
 	atomic_set(&emac->tdown_cnt, emac->tx_ch_num);
 	/* ensure new tdown_cnt value is visible */
 	smp_mb__after_atomic();
@@ -675,10 +711,15 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
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
@@ -767,6 +808,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	SET_NETDEV_DEV(ndev, prueth->dev);
 	spin_lock_init(&emac->lock);
 	mutex_init(&emac->cmd_lock);
+	__hw_addr_init(&emac->mcast_list);
 
 	emac->phy_node = of_parse_phandle(eth_node, "phy-handle", 0);
 	if (!emac->phy_node && !of_phy_is_fixed_link(eth_node)) {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 5eeeccb73665..2bfda26b5901 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -155,6 +155,9 @@ struct prueth_emac {
 	unsigned int tx_ts_enabled : 1;
 	unsigned int half_duplex : 1;
 
+	/* List for storing multicast addresses */
+	struct netdev_hw_addr_list mcast_list;
+
 	/* DMA related */
 	struct prueth_tx_chn tx_chns[PRUETH_MAX_TX_QUEUES];
 	struct completion tdown_complete;

base-commit: 2589d668e1a6ebe85329f1054cdad13647deac06
-- 
2.34.1


