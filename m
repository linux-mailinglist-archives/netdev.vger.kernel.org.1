Return-Path: <netdev+bounces-154945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDC3A006CA
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC21160C8F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835041D5AC6;
	Fri,  3 Jan 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hV1JXRa9"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A81D5144;
	Fri,  3 Jan 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896076; cv=none; b=H3wIqxSreqEm5Gjo15mKWyejCRFiiaaeE5jQ+Ly17NMhPeKrlh1efEKw9lhEEuyJJ2z/Hhmro/ZwGuiYFucsPJ3aWEnValmH29ihSl/4ABKzVyVXt8wgvwFbVrzMN8uVdZgUmjeBnpcFtHcS0J+0ZMEMpbWwXMMJcPrce5muJX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896076; c=relaxed/simple;
	bh=Vm4O8Uf/tbW3yxay2jNycwiCkLhqJDUOFxtV1k7LtFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQcR/q98A1FFO3MjFvg7+/oKc7rjD0j/5jQSBUAzbEIYrczYbSoGaDVs9OiOb+it1k2VztdpO/849PbvKCcxgz+nG4goIq5SeRODoh8WXh5dAOi7ThXV97SYU7VmMnvjsGvpjxCmSr5XawTHxR+9CxuzgB23VqPfowNocCRlbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hV1JXRa9; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5039KjIY2301485
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 03:20:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1735896045;
	bh=FbTjT2NNOwkQMhz7Ipb77T30eRPf1dFFVqsg6qo9X40=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hV1JXRa95NhWByvRPVu91dy79yap8GjBrJlg1eo5PN18KWcrPZd6WmC4q2Q2iXfEl
	 /PPZPvrdgHPEtjir6BV0dekDiwFw71S+Erk9T17pOnF3gRAEegY/pwIerjhYdk4D2B
	 6CxBNW90M0/L6Si82YvrAjS8NhUZwkd1YqTuurEE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5039Kj1a074824
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jan 2025 03:20:45 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Jan 2025 03:20:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Jan 2025 03:20:44 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5039KiVI055159;
	Fri, 3 Jan 2025 03:20:44 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 5039KhhJ016906;
	Fri, 3 Jan 2025 03:20:43 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Jeongjun Park <aha310510@gmail.com>,
        Alexander Lobakin
	<aleksander.lobakin@intel.com>,
        Lukasz Majewski <lukma@denx.de>, Meghana
 Malladi <m-malladi@ti.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>, <danishanwar@ti.com>,
        Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>,
        Larysa Zaremba
	<larysa.zaremba@intel.com>
Subject: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add Support for Multicast filtering with VLAN in HSR mode
Date: Fri, 3 Jan 2025 14:50:33 +0530
Message-ID: <20250103092033.1533374-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103092033.1533374-1-danishanwar@ti.com>
References: <20250103092033.1533374-1-danishanwar@ti.com>
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
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 83 +++++++++++++++-----
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +
 include/linux/if_hsr.h                       | 18 +++++
 net/hsr/hsr_device.c                         | 13 +++
 net/hsr/hsr_main.h                           |  9 ---
 5 files changed, 97 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index ed8b5a3184d6..29e0e7a86a7f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -515,32 +515,66 @@ static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
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
+			icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id,
+						     true);
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
+			icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id,
+						     false);
+		}
+	} else {
+		emac = netdev_priv(real_dev);
+		icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id, false);
+	}
 
 	return 0;
 }
@@ -558,8 +592,14 @@ static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
 				vdev->addr_len);
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
@@ -808,6 +848,11 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 	if (emac->prueth->is_hsr_offload_mode) {
 		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
 			      icssg_prueth_hsr_del_mcast);
+		if (rtnl_trylock()) {
+			vlan_for_each(emac->prueth->hsr_dev,
+				      icssg_update_vlan_mcast, emac);
+			rtnl_unlock();
+		}
 	} else {
 		__dev_mc_sync(ndev, icssg_prueth_add_mcast,
 			      icssg_prueth_del_mcast);
@@ -1194,7 +1239,7 @@ static int prueth_netdevice_port_link(struct net_device *ndev,
 		if (prueth->br_members & BIT(PRUETH_PORT_MII0) &&
 		    prueth->br_members & BIT(PRUETH_PORT_MII1)) {
 			prueth->is_switch_mode = true;
-			prueth->default_vlan = 1;
+			prueth->default_vlan = PRUETH_DFLT_VLAN_SW;
 			emac->port_vlan = prueth->default_vlan;
 			icssg_change_mode(prueth);
 		}
@@ -1247,7 +1292,7 @@ static int prueth_hsr_port_link(struct net_device *ndev)
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
index 0404f5bf4f30..0e0bbd6ed082 100644
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
@@ -32,6 +41,8 @@ struct hsr_tag {
 #if IS_ENABLED(CONFIG_HSR)
 extern bool is_hsr_master(struct net_device *dev);
 extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
+struct net_device *hsr_get_port_ndev(struct net_device *ndev,
+				     enum hsr_port_type pt);
 #else
 static inline bool is_hsr_master(struct net_device *dev)
 {
@@ -42,6 +53,13 @@ static inline int hsr_get_version(struct net_device *dev,
 {
 	return -EINVAL;
 }
+
+static inline struct net_device *hsr_get_port_ndev(struct net_device *ndev,
+						   enum hsr_port_type pt)
+{
+	return ERR_PTR(-EINVAL);
+}
+
 #endif /* CONFIG_HSR */
 
 #endif /*_LINUX_IF_HSR_H_*/
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 03eadd6c51fd..b6fb18469439 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -663,6 +663,19 @@ bool is_hsr_master(struct net_device *dev)
 }
 EXPORT_SYMBOL(is_hsr_master);
 
+struct net_device *hsr_get_port_ndev(struct net_device *ndev,
+				     enum hsr_port_type pt)
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


