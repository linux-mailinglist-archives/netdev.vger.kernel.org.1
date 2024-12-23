Return-Path: <netdev+bounces-154013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850809FABF4
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329F71885E33
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 09:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E1B19343E;
	Mon, 23 Dec 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jruOE6ET"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6368259489;
	Mon, 23 Dec 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734945999; cv=none; b=gLQFuBpyKppmL87xpOwjI7TH+EMOtXwfFNmZ6bymh6+7BKFZBnY5slZ/wIoUmubKHufs8MQGeBacLZQ4NyfRTQFfyJYJjVNkesqINxwZCTEkCqfgz/+Sscw8uXmyDH3iHRH4saaDXnjxihMl2NaN0BbG70/lVY//Zgz8fGfTD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734945999; c=relaxed/simple;
	bh=h0GC6lMzi4CHgF/ESTSY4PVz/UWvXZ/f5kIg9DxX8t4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ML2A6P5jf7GoL+YrYSt/S7dBy8Rpy2qCDK5Y6bPq8VbmhCSekhaQRmPN5k6g/+W/VAUi2Qer+WNxfoIP2eduePYYJfFKfWtLuGLdo49jDJp3+B7IzLXc9Ap6IZJNMugLV0KOxCgLu9BHlK4s1l04ysaYKJovLMHGd8jAb1rBZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jruOE6ET; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN9Q5QY856700
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Dec 2024 03:26:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1734945965;
	bh=6cZrHKkJFMqtSt9H2JnEWM9Ru6S2s3la+DRB+YAd7WM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jruOE6ETw61vjGzZi37i4d2di4SACsbLisaHsG727tdhy6jSejPHJnSvoc36SFTtn
	 dX8btz2Kt/M0ZpP7+R0fmRgFos+a+rAX/DKi4M2s/pK5lL9fYRuUkJw0Rl/BhGSnV7
	 gMJMn0WDhb07RXk3DCGiYmkXrSPO/C5iISBSbt7g=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN9Q541093123
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Dec 2024 03:26:05 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Dec 2024 03:26:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Dec 2024 03:26:04 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BN9Q4m9012184;
	Mon, 23 Dec 2024 03:26:04 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4BN9Q3Pi006706;
	Mon, 23 Dec 2024 03:26:04 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <wojciech.drewek@intel.com>, <n.zhandarovich@fintech.ru>,
        <aleksander.lobakin@intel.com>, <lukma@denx.de>, <m-malladi@ti.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: [PATCH net-next v2 2/3] net: ti: icssg-prueth: Add Multicast Filtering support for VLAN in MAC mode
Date: Mon, 23 Dec 2024 14:55:56 +0530
Message-ID: <20241223092557.2077526-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241223092557.2077526-1-danishanwar@ti.com>
References: <20241223092557.2077526-1-danishanwar@ti.com>
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
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 67 ++++++++++++++++----
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  6 ++
 include/linux/netdevice.h                    |  3 +
 net/core/dev_addr_lists.c                    |  7 +-
 4 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 1663941e59e3..ed8b5a3184d6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -472,30 +472,44 @@ const struct icss_iep_clockops prueth_iep_clockops = {
 
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
+		icssg_vtbl_modify(emac, vlan_id, other_port_mask,
+				  other_port_mask, true);
 	}
 
 	return 0;
@@ -531,6 +545,25 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
 	return 0;
 }
 
+static int icssg_update_vlan_mcast(struct net_device *vdev, int vid,
+				   void *args)
+{
+	struct prueth_emac *emac = args;
+
+	if (!vdev || !vid)
+		return 0;
+
+	netif_addr_lock_bh(vdev);
+	__hw_addr_sync_multiple(&emac->vlan_mcast_list[vid], &vdev->mc,
+				vdev->addr_len);
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
@@ -772,12 +805,17 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
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
+			vlan_for_each(ndev, icssg_update_vlan_mcast, emac);
+			rtnl_unlock();
+		}
+	}
 }
 
 /**
@@ -828,6 +866,7 @@ static int emac_ndo_vlan_rx_add_vid(struct net_device *ndev,
 	if (prueth->is_hsr_offload_mode)
 		port_mask |= BIT(PRUETH_PORT_HOST);
 
+	__hw_addr_init(&emac->vlan_mcast_list[vid]);
 	netdev_dbg(emac->ndev, "VID add vid:%u port_mask:%X untag_mask %X\n",
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
index 2593019ad5b1..3ee833e9b6f7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4689,6 +4689,9 @@ int devm_register_netdev(struct device *dev, struct net_device *ndev);
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


