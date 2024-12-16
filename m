Return-Path: <netdev+bounces-152139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435DE9F2DA6
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49E9164B6A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE93A202C38;
	Mon, 16 Dec 2024 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D3crGGf0"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA51DDC21;
	Mon, 16 Dec 2024 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343290; cv=none; b=lPWh//UxIlrD+pQA/FIkZs/WnQ0agAsjJK0nUtP/oOSh+zfTE6ZUNqDq92GyqdiIX7jfDW54DsERGtJnQekl3TqUhEbAMctUrNMipmi8hoyXgBst7TPyp9cfK5ZtbrZkyzQqXXlkdrCngeWHbBuaMsg/xvnodszYM8xNIFpYZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343290; c=relaxed/simple;
	bh=LWbfr8UgCrRVWEIbOwNEGrXfzvmPbbLU+6Y73SeWhyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDb46Gp5297nX7l+y/c7WSUMaJmiNHoQeD26sFVICGkKJa/HSw9QAa+S2rlONfR8+eipTB/KkwzQ+wqZkQhnhWOshZhDagsc/854X/MlZYBJESJcrNpbOqlYonC8V64yE3rVuSKQpsyKyyKkIKK4bt5o0kwFaoeUb7lvZrgpr5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D3crGGf0; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BGA114O3459911
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 16 Dec 2024 04:01:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734343261;
	bh=3QL9MBTXLPAnsTaOXmyWD0TbxeO80GgTdO5lWG9Zzls=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=D3crGGf0FNlpcQ7GJUFCQNYi2bPgDeQE2lorFRn3FWgWLDuGheBmOM4qV32sM1V9e
	 dgiyr1quLuDpSY18iHTU7z2frl3CQqQPiws3uYR2iD/YreqlYotUq7IloZ8eb9DAeo
	 qFUlrlRtN31wOw4iBvWhRGXNDW1TyHE/K650Hcq4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BGA11uu095959;
	Mon, 16 Dec 2024 04:01:01 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Dec 2024 04:01:00 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Dec 2024 04:01:01 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BGA1191074027;
	Mon, 16 Dec 2024 04:01:01 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4BGA10Cu000637;
	Mon, 16 Dec 2024 04:01:00 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <rdunlap@infradead.org>,
        <schnelle@linux.ibm.com>, <vladimir.oltean@nxp.com>,
        <horms@kernel.org>, <rogerq@kernel.org>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next 3/4] net: ti: icssg-prueth: Add Multicast Filtering support for VLAN in MAC mode
Date: Mon, 16 Dec 2024 15:30:43 +0530
Message-ID: <20241216100044.577489-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216100044.577489-1-danishanwar@ti.com>
References: <20241216100044.577489-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add multicast filtering support for VLAN interfaces in dual EMAC mode
for ICSSG driver.

The driver uses vlan_for_each() API to get the list of available
vlans. The driver then sync mc addr of vlan interface with a locally
mainatined list emac->vlan_mcast_list[vid] using __hw_addr_sync_multiple()
API.

The driver then calls the sync / unsync callbacks and based on whether
the ndev is vlan or not, driver passes appropriate vid to FDB helper
functions.

This commit also exports __hw_addr_sync_multiple() in order to use it
from the ICSSG driver.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 69 ++++++++++++++++----
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  6 ++
 include/linux/netdevice.h                    |  3 +
 net/core/dev_addr_lists.c                    |  7 +-
 4 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index e031bccf31dc..a18773ef6eab 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -472,30 +472,43 @@ const struct icss_iep_clockops prueth_iep_clockops = {
 
 static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
 {
-	struct prueth_emac *emac = netdev_priv(ndev);
-	int port_mask = BIT(emac->port_id);
+	struct net_device *real_dev;
+	struct prueth_emac *emac;
+	int port_mask;
+	u8 vlan_id;
 
-	port_mask |= icssg_fdb_lookup(emac, addr, 0);
-	icssg_fdb_add_del(emac, addr, 0, port_mask, true);
-	icssg_vtbl_modify(emac, 0, port_mask, port_mask, true);
+	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
+	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
+	emac = netdev_priv(real_dev);
+
+	port_mask = BIT(emac->port_id) | icssg_fdb_lookup(emac, addr, vlan_id);
+	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, true);
+	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, true);
 
 	return 0;
 }
 
 static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
 {
-	struct prueth_emac *emac = netdev_priv(ndev);
-	int port_mask = BIT(emac->port_id);
+	struct net_device *real_dev;
+	struct prueth_emac *emac;
 	int other_port_mask;
+	int port_mask;
+	u8 vlan_id;
+
+	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_MAC;
+	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
+	emac = netdev_priv(real_dev);
 
-	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, 0);
+	port_mask = BIT(emac->port_id);
+	other_port_mask = port_mask ^ icssg_fdb_lookup(emac, addr, vlan_id);
 
-	icssg_fdb_add_del(emac, addr, 0, port_mask, false);
-	icssg_vtbl_modify(emac, 0, port_mask, port_mask, false);
+	icssg_fdb_add_del(emac, addr, vlan_id, port_mask, false);
+	icssg_vtbl_modify(emac, vlan_id, port_mask, port_mask, false);
 
 	if (other_port_mask) {
-		icssg_fdb_add_del(emac, addr, 0, other_port_mask, true);
-		icssg_vtbl_modify(emac, 0, other_port_mask, other_port_mask, true);
+		icssg_fdb_add_del(emac, addr, vlan_id, other_port_mask, true);
+		icssg_vtbl_modify(emac, vlan_id, other_port_mask, other_port_mask, true);
 	}
 
 	return 0;
@@ -531,6 +544,28 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
 	return 0;
 }
 
+static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
+				   void *args)
+{
+	struct net_device *vport_ndev;
+	struct prueth_emac *emac;
+
+	if (!vdev || !vid)
+		return 0;
+
+	vport_ndev = vlan_dev_real_dev(vdev);
+	emac = netdev_priv(vport_ndev);
+
+	netif_addr_lock_bh(vdev);
+	__hw_addr_sync_multiple(&emac->vlan_mcast_list[vid], &vdev->mc, vdev->addr_len);
+	netif_addr_unlock_bh(vdev);
+
+	__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
+			   icssg_prueth_add_mcast, icssg_prueth_del_mcast);
+
+	return 0;
+}
+
 /**
  * emac_ndo_open - EMAC device open
  * @ndev: network adapter device
@@ -772,12 +807,17 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 		return;
 	}
 
-	if (emac->prueth->is_hsr_offload_mode)
+	if (emac->prueth->is_hsr_offload_mode) {
 		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
 			      icssg_prueth_hsr_del_mcast);
-	else
+	} else {
 		__dev_mc_sync(ndev, icssg_prueth_add_mcast,
 			      icssg_prueth_del_mcast);
+		if (rtnl_trylock()) {
+			vlan_for_each(ndev, icssg_update_vlan_mcast, NULL);
+			rtnl_unlock();
+		}
+	}
 }
 
 /**
@@ -828,6 +868,7 @@ static int emac_ndo_vlan_rx_add_vid(struct net_device *ndev,
 	if (prueth->is_hsr_offload_mode)
 		port_mask |= BIT(PRUETH_PORT_HOST);
 
+	__hw_addr_init(&emac->vlan_mcast_list[vid]);
 	netdev_err(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
 		   vid, port_mask, untag_mask);
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index f5c1d473e9f9..4da8b87408b5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -83,6 +83,10 @@
 #define ICSS_CMD_ADD_FILTER 0x7
 #define ICSS_CMD_ADD_MAC 0x8
 
+/* VLAN Filtering Related MACROs */
+#define PRUETH_DFLT_VLAN_MAC	0
+#define MAX_VLAN_ID		256
+
 /* In switch mode there are 3 real ports i.e. 3 mac addrs.
  * however Linux sees only the host side port. The other 2 ports
  * are the switch ports.
@@ -201,6 +205,8 @@ struct prueth_emac {
 	/* RX IRQ Coalescing Related */
 	struct hrtimer rx_hrtimer;
 	unsigned long rx_pace_timeout_ns;
+
+	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
 };
 
 /**
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d917949bba03..a5c169b19543 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4685,6 +4685,9 @@ int devm_register_netdev(struct device *dev, struct net_device *ndev);
 /* General hardware address lists handling functions */
 int __hw_addr_sync(struct netdev_hw_addr_list *to_list,
 		   struct netdev_hw_addr_list *from_list, int addr_len);
+int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
+			    struct netdev_hw_addr_list *from_list,
+			    int addr_len);
 void __hw_addr_unsync(struct netdev_hw_addr_list *to_list,
 		      struct netdev_hw_addr_list *from_list, int addr_len);
 int __hw_addr_sync_dev(struct netdev_hw_addr_list *list,
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 166e404f7c03..90716bd736f3 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -242,9 +242,9 @@ static void __hw_addr_unsync_one(struct netdev_hw_addr_list *to_list,
 	__hw_addr_del_entry(from_list, ha, false, false);
 }
 
-static int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
-				   struct netdev_hw_addr_list *from_list,
-				   int addr_len)
+int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
+			    struct netdev_hw_addr_list *from_list,
+			    int addr_len)
 {
 	int err = 0;
 	struct netdev_hw_addr *ha, *tmp;
@@ -260,6 +260,7 @@ static int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
 	}
 	return err;
 }
+EXPORT_SYMBOL(__hw_addr_sync_multiple);
 
 /* This function only works where there is a strict 1-1 relationship
  * between source and destination of they synch. If you ever need to
-- 
2.34.1


