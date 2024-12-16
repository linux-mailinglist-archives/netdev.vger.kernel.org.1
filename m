Return-Path: <netdev+bounces-152142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D077A9F2DB0
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329A218895BE
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2834E202C4C;
	Mon, 16 Dec 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UUjSe/wi"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA688202C47;
	Mon, 16 Dec 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343305; cv=none; b=nBFz2kNLfUVK0eLCMZCWdf0HwmKF0+FWeQwgcTRvFfma0NDR1BJ0ru/rR43saASBTEsTnbKg31zIdOPXJ1lKaQ8kRFzhM0gSUKjWkPhyfCL94jP/qViv+oDlkKfQ8AJw9w2qEIL3RkRZreeiXLjFv84wuYBvGGQMq2Z1qUKhjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343305; c=relaxed/simple;
	bh=Pmrci5ITQweFRa6tVUJ9nCqr42iRc5K5pt8DMY0jtbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQFdj7b7sMlMoiYVwsEl5uZMc/qVteb8V/RcVjZ6HnniA37O70ijlahY/0scqvi09yI9XyeDkED4LQtVr+JkNMq/QT2ZVoUELIkr8WEzHLpQTyDRq5eYoZqWJseJ0jNhQyFrfO3zSOrBCqrjWZJmxkM4/4qOTV418z3uoWrQxfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UUjSe/wi; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BGA14Bd089014;
	Mon, 16 Dec 2024 04:01:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734343264;
	bh=7bZOk2G2gvBaeDKP7eXwq9VLhaEuvHR9gCkM5uGMM4w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UUjSe/wijqUntOybdLwdaTa7zIAkdgA0kCnbv7szwUgM4Azkkt1iW7D1TX6a6ezms
	 0odWotbdCfaEOARptYqzFKv8zDo7WfrE25Xf3fVePkK2aFdNBxRIARLI1JzDtmqooT
	 So655B+hMTwxbUvfh1BDg3XH9eYSmg2Fi4CWXTFs=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BGA136C029350
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Dec 2024 04:01:03 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Dec 2024 04:01:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Dec 2024 04:01:02 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BGA12RR081965;
	Mon, 16 Dec 2024 04:01:02 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4BGA12U4000676;
	Mon, 16 Dec 2024 04:01:02 -0600
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
Subject: [PATCH net-next 4/4] net: ti: icssg-prueth: Add Support for Multicast filtering with VLAN in HSR mode
Date: Mon, 16 Dec 2024 15:30:44 +0530
Message-ID: <20241216100044.577489-5-danishanwar@ti.com>
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

Add multicast filtering support for VLAN interfaces in HSR offload mode
for ICSSG driver.

The driver calls vlan_for_each() API on the hsr device's ndev to get the
list of available vlans for the hsr device. The driver then sync mc addr of
vlan interface with a locally mainatined list emac->vlan_mcast_list[vid]
using __hw_addr_sync_multiple() API.

The driver then calls the sync / unsync callbacks.

In the sync / unsync call back, driver checks if the vdev's real dev is
hsr device or not. If the real dev is hsr device, driver gets the per
port device using hsr_get_port_ndev() and then driver passes appropriate
vid to FDB helper functions.

This commit makes below changes in the hsr files.
- Move enum hsr_port_type from net/hsr/hsr_main.h to include/linux/if_hsr.h
  so that the enum can be accessed by drivers using hsr.
- Create hsr_get_port_ndev() API that can be used to get the ndev
  pointer to the slave port from ndev pointer to the hsr net device.
- Export hsr_get_port_ndev() API so that the API can be accessed by
  drivers using hsr.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 88 ++++++++++++++------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +
 include/linux/if_hsr.h                       | 16 ++++
 net/hsr/hsr_device.c                         | 12 +++
 net/hsr/hsr_main.h                           |  9 --
 5 files changed, 93 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index a18773ef6eab..4b13787a5fa8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -514,32 +514,64 @@ static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
 	return 0;
 }
 
-static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
+static void icssg_prueth_hsr_fdb_add_del(struct prueth_emac *emac,
+					 const u8 *addr, u8 vid, bool add)
 {
-	struct prueth_emac *emac = netdev_priv(ndev);
-	struct prueth *prueth = emac->prueth;
-
-	icssg_fdb_add_del(emac, addr, prueth->default_vlan,
+	icssg_fdb_add_del(emac, addr, vid,
 			  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
 			  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
 			  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
-			  ICSSG_FDB_ENTRY_BLOCK, true);
+			  ICSSG_FDB_ENTRY_BLOCK, add);
+
+	if (add)
+		icssg_vtbl_modify(emac, vid, BIT(emac->port_id),
+				  BIT(emac->port_id), add);
+}
+
+static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
+{
+	struct net_device *real_dev;
+	struct prueth_emac *emac;
+	u8 vlan_id, i;
+
+	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_HSR;
+	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
+
+	if (is_hsr_master(real_dev)) {
+		for (i = HSR_PT_SLAVE_A; i < HSR_PT_INTERLINK; i++) {
+			emac = netdev_priv(hsr_get_port_ndev(real_dev, i));
+			if (!emac)
+				return -EINVAL;
+			icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id, true);
+		}
+	} else {
+		emac = netdev_priv(real_dev);
+		icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id, true);
+	}
 
-	icssg_vtbl_modify(emac, emac->port_vlan, BIT(emac->port_id),
-			  BIT(emac->port_id), true);
 	return 0;
 }
 
 static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
 {
-	struct prueth_emac *emac = netdev_priv(ndev);
-	struct prueth *prueth = emac->prueth;
+	struct net_device *real_dev;
+	struct prueth_emac *emac;
+	u8 vlan_id, i;
 
-	icssg_fdb_add_del(emac, addr, prueth->default_vlan,
-			  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
-			  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
-			  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
-			  ICSSG_FDB_ENTRY_BLOCK, false);
+	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_HSR;
+	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
+
+	if (is_hsr_master(real_dev)) {
+		for (i = HSR_PT_SLAVE_A; i < HSR_PT_INTERLINK; i++) {
+			emac = netdev_priv(hsr_get_port_ndev(real_dev, i));
+			if (!emac)
+				return -EINVAL;
+			icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id, false);
+		}
+	} else {
+		emac = netdev_priv(real_dev);
+		icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id, false);
+	}
 
 	return 0;
 }
@@ -547,21 +579,23 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
 static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
 				   void *args)
 {
-	struct net_device *vport_ndev;
-	struct prueth_emac *emac;
+	struct prueth_emac *emac = args;
 
 	if (!vdev || !vid)
 		return 0;
 
-	vport_ndev = vlan_dev_real_dev(vdev);
-	emac = netdev_priv(vport_ndev);
-
 	netif_addr_lock_bh(vdev);
 	__hw_addr_sync_multiple(&emac->vlan_mcast_list[vid], &vdev->mc, vdev->addr_len);
 	netif_addr_unlock_bh(vdev);
 
-	__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
-			   icssg_prueth_add_mcast, icssg_prueth_del_mcast);
+	if (emac->prueth->is_hsr_offload_mode)
+		__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
+				   icssg_prueth_hsr_add_mcast,
+				   icssg_prueth_hsr_del_mcast);
+	else
+		__hw_addr_sync_dev(&emac->vlan_mcast_list[vid], vdev,
+				   icssg_prueth_add_mcast,
+				   icssg_prueth_del_mcast);
 
 	return 0;
 }
@@ -810,11 +844,15 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 	if (emac->prueth->is_hsr_offload_mode) {
 		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
 			      icssg_prueth_hsr_del_mcast);
+		if (rtnl_trylock()) {
+			vlan_for_each(emac->prueth->hsr_dev, icssg_update_vlan_mcast, emac);
+			rtnl_unlock();
+		}
 	} else {
 		__dev_mc_sync(ndev, icssg_prueth_add_mcast,
 			      icssg_prueth_del_mcast);
 		if (rtnl_trylock()) {
-			vlan_for_each(ndev, icssg_update_vlan_mcast, NULL);
+			vlan_for_each(ndev, icssg_update_vlan_mcast, emac);
 			rtnl_unlock();
 		}
 	}
@@ -1196,7 +1234,7 @@ static int prueth_netdevice_port_link(struct net_device *ndev,
 		if (prueth->br_members & BIT(PRUETH_PORT_MII0) &&
 		    prueth->br_members & BIT(PRUETH_PORT_MII1)) {
 			prueth->is_switch_mode = true;
-			prueth->default_vlan = 1;
+			prueth->default_vlan = PRUETH_DFLT_VLAN_SW;
 			emac->port_vlan = prueth->default_vlan;
 			icssg_change_mode(prueth);
 		}
@@ -1249,7 +1287,7 @@ static int prueth_hsr_port_link(struct net_device *ndev)
 			      NETIF_PRUETH_HSR_OFFLOAD_FEATURES))
 				return -EOPNOTSUPP;
 			prueth->is_hsr_offload_mode = true;
-			prueth->default_vlan = 1;
+			prueth->default_vlan = PRUETH_DFLT_VLAN_HSR;
 			emac0->port_vlan = prueth->default_vlan;
 			emac1->port_vlan = prueth->default_vlan;
 			icssg_change_mode(prueth);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 4da8b87408b5..956cb59d98b2 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -84,6 +84,8 @@
 #define ICSS_CMD_ADD_MAC 0x8
 
 /* VLAN Filtering Related MACROs */
+#define PRUETH_DFLT_VLAN_HSR	1
+#define PRUETH_DFLT_VLAN_SW	1
 #define PRUETH_DFLT_VLAN_MAC	0
 #define MAX_VLAN_ID		256
 
diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
index 0404f5bf4f30..d97e1d1599f0 100644
--- a/include/linux/if_hsr.h
+++ b/include/linux/if_hsr.h
@@ -13,6 +13,15 @@ enum hsr_version {
 	PRP_V1,
 };
 
+enum hsr_port_type {
+	HSR_PT_NONE = 0,	/* Must be 0, used by framereg */
+	HSR_PT_SLAVE_A,
+	HSR_PT_SLAVE_B,
+	HSR_PT_INTERLINK,
+	HSR_PT_MASTER,
+	HSR_PT_PORTS,	/* This must be the last item in the enum */
+};
+
 /* HSR Tag.
  * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype = 0x88FB,
  * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
@@ -32,6 +41,7 @@ struct hsr_tag {
 #if IS_ENABLED(CONFIG_HSR)
 extern bool is_hsr_master(struct net_device *dev);
 extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
+struct net_device *hsr_get_port_ndev(struct net_device *ndev, enum hsr_port_type pt);
 #else
 static inline bool is_hsr_master(struct net_device *dev)
 {
@@ -42,6 +52,12 @@ static inline int hsr_get_version(struct net_device *dev,
 {
 	return -EINVAL;
 }
+
+static inline struct net_device *hsr_get_port_ndev(struct net_device *ndev, enum hsr_port_type pt)
+{
+	return ERR_PTR(-EINVAL);
+}
+
 #endif /* CONFIG_HSR */
 
 #endif /*_LINUX_IF_HSR_H_*/
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 03eadd6c51fd..1e1cbfd02778 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -663,6 +663,18 @@ bool is_hsr_master(struct net_device *dev)
 }
 EXPORT_SYMBOL(is_hsr_master);
 
+struct net_device *hsr_get_port_ndev(struct net_device *ndev, enum hsr_port_type pt)
+{
+	struct hsr_priv *hsr = netdev_priv(ndev);
+	struct hsr_port *port;
+
+	hsr_for_each_port(hsr, port)
+		if (port->type == pt)
+			return port->dev;
+	return NULL;
+}
+EXPORT_SYMBOL(hsr_get_port_ndev);
+
 /* Default multicast address for HSR Supervision frames */
 static const unsigned char def_multicast_addr[ETH_ALEN] __aligned(2) = {
 	0x01, 0x15, 0x4e, 0x00, 0x01, 0x00
diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
index fcfeb79bb040..db7d88c05b7f 100644
--- a/net/hsr/hsr_main.h
+++ b/net/hsr/hsr_main.h
@@ -121,15 +121,6 @@ struct hsrv1_ethhdr_sp {
 	struct hsr_sup_tag	hsr_sup;
 } __packed;
 
-enum hsr_port_type {
-	HSR_PT_NONE = 0,	/* Must be 0, used by framereg */
-	HSR_PT_SLAVE_A,
-	HSR_PT_SLAVE_B,
-	HSR_PT_INTERLINK,
-	HSR_PT_MASTER,
-	HSR_PT_PORTS,	/* This must be the last item in the enum */
-};
-
 /* PRP Redunancy Control Trailor (RCT).
  * As defined in IEC-62439-4:2012, the PRP RCT is really { sequence Nr,
  * Lan indentifier (LanId), LSDU_size and PRP_suffix = 0x88FB }.
-- 
2.34.1


