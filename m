Return-Path: <netdev+bounces-154944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0F3A006C9
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEFA01638D7
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0A1D516C;
	Fri,  3 Jan 2025 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M/yJmTUQ"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C11D5143;
	Fri,  3 Jan 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896075; cv=none; b=qYTLlPyQcIJvb2KjbwLgodRuPV63ESqUuCWQLoA+8Vq+9SaPo8u/CyiHiXjebgtimpXgP0fRfmEwXgFo/b9KktQInh0OI6IyA2Qv7TdXmI1Io7nbhZ0NKdfrubsNczibObjqdgslPthoHUYG5xmUcSph4jyVNMQmPW2BHNH6q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896075; c=relaxed/simple;
	bh=h0GC6lMzi4CHgF/ESTSY4PVz/UWvXZ/f5kIg9DxX8t4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOjwPMo3AX5qV88MHgJkGB4ahoNvD+qu1c+FxL9JUqqbEqXULyLMc0eEFXL3rm1b9mnGYC935fNghsfUwGWIKz+k9mN3uJGu3Ys0RNcgjLwaToFGA6Y6oqqyJ7EzsB4TKESNvBeRjrN5q77TA5BMs8F+9mUn6inGT359kKPFXZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=M/yJmTUQ; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5039KgMQ2301481
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 03:20:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1735896042;
	bh=6cZrHKkJFMqtSt9H2JnEWM9Ru6S2s3la+DRB+YAd7WM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=M/yJmTUQC7vmGN6wYFvcW3IIwU4D1qbcvqbuUrJNLPAmq8I7OMJJtobjDf/+v/7tX
	 UHiHCepuj2hRWUmhQ1zy1UmtUF5iAMUGmSK192L4ook7TAzAqvBiLEQI0/sswQSzR2
	 hFfTxWx3qCSci4eFaHQ9GvHHQvsG9TAhqY5mSo+0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5039KgHS004100
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jan 2025 03:20:42 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Jan 2025 03:20:42 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Jan 2025 03:20:42 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5039KgmD031117;
	Fri, 3 Jan 2025 03:20:42 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 5039KfAn016900;
	Fri, 3 Jan 2025 03:20:41 -0600
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
Subject: [PATCH net-next v3 2/3] net: ti: icssg-prueth: Add Multicast Filtering support for VLAN in MAC mode
Date: Fri, 3 Jan 2025 14:50:32 +0530
Message-ID: <20250103092033.1533374-3-danishanwar@ti.com>
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


