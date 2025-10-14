Return-Path: <netdev+bounces-229214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6FDBD96AA
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A0D68500C96
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A28313E1D;
	Tue, 14 Oct 2025 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="wp7Vzzu0"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A109313E15;
	Tue, 14 Oct 2025 12:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445673; cv=none; b=Ok5EQihCDqS2AA2fcpNAbFi/gsG3qy2OC/3o4Ulwqyi0TmpYUAErdTzsa53ovtR3oAK1I0zL9CkJwTF2lM3qzG8LqqryH4bSZw033U/5PaUID7LyFcSF+ReR8AXRhAw0SSgzjxInwo6ituzakFiQPEetVpRjhINeYBxwD1967is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445673; c=relaxed/simple;
	bh=tQssEn6DnvaiR8/64eb91YcIrO7oQTdMnHEDGVQG844=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNjnNqj+gxmFAE6QWe+ZHH3jY+IrjGy56jvfmmOMhyqQApVtDzbHS/JR/nggNJltDVyvSRI4cXyNniebjOyiaB0ERZFyoXFFC12QgXiyTWUVBVqQsAudHZ0JwXkjda6e43rv6jPyK/p8CS6HKkzGN3RepkMRxSxp1Sd5t009uBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=wp7Vzzu0; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=01hQKBn41P+w2AFlO3/PkFXnCdu4pqewefRvKrvFoYE=; b=wp7Vzzu0tIkhHgAJr43NkLzTSE
	gfLFfv3mhbew1LsgVMJDQtKcZi0EBzDbYuk6nMxWA2xPpAMqAg7l1dlJUU2nYtuoephuZK56kTXgJ
	mf6eCF10FwwmQD+ByXVi1jd2ceGoS+DvuP77P6LXRBn0i/H+nLyUgzdUMk+J+CvmIOLqtt8/0CVpx
	/3xWzNgPwtKmKoYTl/UPmXPLTs7ip/yH7mtZ7KuHzK54ldkA0DwNvCLeMTaYt0brjr6Q/fVxy9t0k
	3MZ+KoIqY2LHhKH4XIG4GaMUdF5d1EcTCcfvM0EWpwp5mfWkqmx7IPdctpNNgK2A10RtWnWQ+FusZ
	FGdQqytQ==;
Received: from [122.175.9.182] (port=2147 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v8eKx-00000005NDu-3Hmd;
	Tue, 14 Oct 2025 08:41:08 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	basharath@couthit.com,
	afd@ti.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	prajith@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v3 2/3] net: ti: icssm-prueth: Adds switchdev support for icssm_prueth driver
Date: Tue, 14 Oct 2025 18:09:00 +0530
Message-ID: <20251014124018.1596900-3-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014124018.1596900-1-parvathi@couthit.com>
References: <20251014124018.1596900-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

This patch adds support for offloading the RSTP switch feature to the
PRU-ICSS subsystem by adding switchdev support. PRU-ICSS is capable of
operating in RSTP switch mode with two external ports and one host port.

PRUETH driver and firmware interface support will be added into
icssm_prueth in the subsequent commits.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 drivers/net/ethernet/ti/Makefile              |   2 +-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 199 +++++++++++
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  18 +-
 .../ethernet/ti/icssm/icssm_prueth_switch.c   |  78 ++++
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |  11 +-
 .../net/ethernet/ti/icssm/icssm_switchdev.c   | 332 ++++++++++++++++++
 .../net/ethernet/ti/icssm/icssm_switchdev.h   |  13 +
 .../ti/icssm/icssm_vlan_mcast_filter_mmap.h   | 120 +++++++
 8 files changed, 770 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_switchdev.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_vlan_mcast_filter_mmap.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 1fd149dd6115..6da50f4b7c2e 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-$(CONFIG_TI_PRUETH) += icssm-prueth.o
-icssm-prueth-y := icssm/icssm_prueth.o icssm/icssm_prueth_switch.o
+icssm-prueth-y := icssm/icssm_prueth.o icssm/icssm_prueth_switch.o icssm/icssm_switchdev.o
 
 obj-$(CONFIG_TI_CPSW) += cpsw-common.o
 obj-$(CONFIG_TI_DAVINCI_EMAC) += cpsw-common.o
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
index 293b7af04263..9bcece1b09fc 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
@@ -29,6 +29,8 @@
 #include <net/pkt_cls.h>
 
 #include "icssm_prueth.h"
+#include "icssm_prueth_switch.h"
+#include "icssm_vlan_mcast_filter_mmap.h"
 #include "../icssg/icssg_mii_rt.h"
 #include "../icssg/icss_iep.h"
 
@@ -38,6 +40,21 @@
 #define TX_CLK_DELAY_100M	0x6
 #define HR_TIMER_TX_DELAY_US	100
 
+static struct prueth_fw_offsets fw_offsets_v2_1;
+
+static void icssm_prueth_set_fw_offsets(struct prueth *prueth)
+{
+	/* Set VLAN/Multicast filter control and table offsets */
+	if (PRUETH_IS_EMAC(prueth)) {
+		prueth->fw_offsets->mc_ctrl_byte  =
+			ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET;
+		prueth->fw_offsets->mc_filter_mask =
+			ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET;
+		prueth->fw_offsets->mc_filter_tbl =
+			ICSS_EMAC_FW_MULTICAST_FILTER_TABLE;
+	}
+}
+
 static void icssm_prueth_write_reg(struct prueth *prueth,
 				   enum prueth_mem region,
 				   unsigned int reg, u32 val)
@@ -303,6 +320,7 @@ static void icssm_prueth_hostinit(struct prueth *prueth)
  */
 static void icssm_prueth_init_ethernet_mode(struct prueth *prueth)
 {
+	icssm_prueth_set_fw_offsets(prueth);
 	icssm_prueth_hostinit(prueth);
 }
 
@@ -1131,11 +1149,180 @@ static void icssm_emac_ndo_get_stats64(struct net_device *ndev,
 	stats->rx_length_errors = emac->stats.rx_length_errors;
 }
 
+/* enable/disable MC filter */
+static void icssm_emac_mc_filter_ctrl(struct prueth_emac *emac, bool enable)
+{
+	struct prueth *prueth = emac->prueth;
+	void __iomem *mc_filter_ctrl;
+	void __iomem *ram;
+	u32 mc_ctrl_byte;
+	u32 reg;
+
+	ram = prueth->mem[emac->dram].va;
+	mc_ctrl_byte = prueth->fw_offsets->mc_ctrl_byte;
+	mc_filter_ctrl = ram + mc_ctrl_byte;
+
+	if (enable)
+		reg = ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_ENABLED;
+	else
+		reg = ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_DISABLED;
+
+	writeb(reg, mc_filter_ctrl);
+}
+
+/* reset MC filter bins */
+static void icssm_emac_mc_filter_reset(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+	void __iomem *mc_filter_tbl;
+	u32 mc_filter_tbl_base;
+	void __iomem *ram;
+
+	ram = prueth->mem[emac->dram].va;
+	mc_filter_tbl_base = prueth->fw_offsets->mc_filter_tbl;
+
+	mc_filter_tbl = ram + mc_filter_tbl_base;
+	memset_io(mc_filter_tbl, 0, ICSS_EMAC_FW_MULTICAST_TABLE_SIZE_BYTES);
+}
+
+/* set MC filter hashmask */
+static void icssm_emac_mc_filter_hashmask
+		(struct prueth_emac *emac,
+		 u8 mask[ICSS_EMAC_FW_MULTICAST_FILTER_MASK_SIZE_BYTES])
+{
+	struct prueth *prueth = emac->prueth;
+	void __iomem *mc_filter_mask;
+	u32 mc_filter_mask_base;
+	void __iomem *ram;
+
+	ram = prueth->mem[emac->dram].va;
+	mc_filter_mask_base = prueth->fw_offsets->mc_filter_mask;
+
+	mc_filter_mask = ram + mc_filter_mask_base;
+	memcpy_toio(mc_filter_mask, mask,
+		    ICSS_EMAC_FW_MULTICAST_FILTER_MASK_SIZE_BYTES);
+}
+
+static void icssm_emac_mc_filter_bin_update(struct prueth_emac *emac, u8 hash,
+					    u8 val)
+{
+	struct prueth *prueth = emac->prueth;
+	void __iomem *mc_filter_tbl;
+	u32 mc_filter_tbl_base;
+	void __iomem *ram;
+
+	ram = prueth->mem[emac->dram].va;
+	mc_filter_tbl_base = prueth->fw_offsets->mc_filter_tbl;
+
+	mc_filter_tbl = ram + mc_filter_tbl_base;
+	writeb(val, mc_filter_tbl + hash);
+}
+
+void icssm_emac_mc_filter_bin_allow(struct prueth_emac *emac, u8 hash)
+{
+	icssm_emac_mc_filter_bin_update
+		(emac, hash,
+		 ICSS_EMAC_FW_MULTICAST_FILTER_HOST_RCV_ALLOWED);
+}
+
+void icssm_emac_mc_filter_bin_disallow(struct prueth_emac *emac, u8 hash)
+{
+	icssm_emac_mc_filter_bin_update
+		(emac, hash,
+		 ICSS_EMAC_FW_MULTICAST_FILTER_HOST_RCV_NOT_ALLOWED);
+}
+
+u8 icssm_emac_get_mc_hash(u8 *mac, u8 *mask)
+{
+	u8 hash;
+	int j;
+
+	for (j = 0, hash = 0; j < ETH_ALEN; j++)
+		hash ^= (mac[j] & mask[j]);
+
+	return hash;
+}
+
+/**
+ * icssm_emac_ndo_set_rx_mode - EMAC set receive mode function
+ * @ndev: The EMAC network adapter
+ *
+ * Called when system wants to set the receive mode of the device.
+ *
+ */
+static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	bool promisc = ndev->flags & IFF_PROMISC;
+	struct netdev_hw_addr *ha;
+	struct prueth *prueth;
+	unsigned long flags;
+	void __iomem *sram;
+	u32 mask, reg;
+	u8 hash;
+
+	prueth = emac->prueth;
+	sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
+	reg = readl(sram + EMAC_PROMISCUOUS_MODE_OFFSET);
+
+	/* It is a shared table. So lock the access */
+	spin_lock_irqsave(&emac->addr_lock, flags);
+
+	/* Disable and reset multicast filter, allows allmulti */
+	icssm_emac_mc_filter_ctrl(emac, false);
+	icssm_emac_mc_filter_reset(emac);
+	icssm_emac_mc_filter_hashmask(emac, emac->mc_filter_mask);
+
+	if (PRUETH_IS_EMAC(prueth)) {
+		switch (emac->port_id) {
+		case PRUETH_PORT_MII0:
+			mask = EMAC_P1_PROMISCUOUS_BIT;
+			break;
+		case PRUETH_PORT_MII1:
+			mask = EMAC_P2_PROMISCUOUS_BIT;
+			break;
+		default:
+			netdev_err(ndev, "%s: invalid port\n", __func__);
+			goto unlock;
+		}
+
+		if (promisc) {
+			/* Enable promiscuous mode */
+			reg |= mask;
+		} else {
+			/* Disable promiscuous mode */
+			reg &= ~mask;
+		}
+
+		writel(reg, sram + EMAC_PROMISCUOUS_MODE_OFFSET);
+
+		if (promisc)
+			goto unlock;
+	}
+
+	if (ndev->flags & IFF_ALLMULTI && !PRUETH_IS_SWITCH(prueth))
+		goto unlock;
+
+	icssm_emac_mc_filter_ctrl(emac, true);	/* all multicast blocked */
+
+	if (netdev_mc_empty(ndev))
+		goto unlock;
+
+	netdev_for_each_mc_addr(ha, ndev) {
+		hash = icssm_emac_get_mc_hash(ha->addr, emac->mc_filter_mask);
+		icssm_emac_mc_filter_bin_allow(emac, hash);
+	}
+
+unlock:
+	spin_unlock_irqrestore(&emac->addr_lock, flags);
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = icssm_emac_ndo_open,
 	.ndo_stop = icssm_emac_ndo_stop,
 	.ndo_start_xmit = icssm_emac_ndo_start_xmit,
 	.ndo_get_stats64 = icssm_emac_ndo_get_stats64,
+	.ndo_set_rx_mode = icssm_emac_ndo_set_rx_mode,
 };
 
 /* get emac_port corresponding to eth_node name */
@@ -1310,6 +1497,17 @@ static void icssm_prueth_netdev_exit(struct prueth *prueth,
 	prueth->emac[mac] = NULL;
 }
 
+bool icssm_prueth_sw_port_dev_check(const struct net_device *ndev)
+{
+	if (ndev->netdev_ops != &emac_netdev_ops)
+		return false;
+
+	if (ndev->features & NETIF_F_HW_L2FW_DOFFLOAD)
+		return true;
+
+	return false;
+}
+
 static int icssm_prueth_probe(struct platform_device *pdev)
 {
 	struct device_node *eth0_node = NULL, *eth1_node = NULL;
@@ -1332,6 +1530,7 @@ static int icssm_prueth_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, prueth);
 	prueth->dev = dev;
 	prueth->fw_data = device_get_match_data(dev);
+	prueth->fw_offsets = &fw_offsets_v2_1;
 
 	eth_ports_node = of_get_child_by_name(np, "ethernet-ports");
 	if (!eth_ports_node)
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
index 4b50133c5a72..c98ed2cd76e7 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
@@ -178,6 +178,13 @@ enum pruss_device {
 	PRUSS_K2G
 };
 
+/* Firmware offsets/size information */
+struct prueth_fw_offsets {
+	u32 mc_ctrl_byte;
+	u32 mc_filter_mask;
+	u32 mc_filter_tbl;
+};
+
 /**
  * struct prueth_private_data - PRU Ethernet private data
  * @driver_data: PRU Ethernet device name
@@ -222,12 +229,14 @@ struct prueth_emac {
 	const char *phy_id;
 	u32 msg_enable;
 	u8 mac_addr[6];
+	unsigned char mc_filter_mask[ETH_ALEN]; /* for multicast filtering */
 	phy_interface_t phy_if;
 
 	/* spin lock used to protect
 	 * during link configuration
 	 */
 	spinlock_t lock;
+	spinlock_t addr_lock;   /* serialize access to VLAN/MC filter table */
 
 	struct hrtimer tx_hrtimer;
 	struct prueth_emac_stats stats;
@@ -249,8 +258,13 @@ struct prueth {
 	struct prueth_emac *emac[PRUETH_NUM_MACS];
 	struct net_device *registered_netdevs[PRUETH_NUM_MACS];
 
+	struct net_device *hw_bridge_dev;
 	struct fdb_tbl *fdb_tbl;
 
+	struct notifier_block prueth_netdevice_nb;
+	struct notifier_block prueth_switchdev_nb;
+	struct notifier_block prueth_switchdev_bl_nb;
+
 	unsigned int eth_type;
 	size_t ocmc_ram_size;
 	u8 emac_configured;
@@ -261,5 +275,7 @@ void icssm_parse_packet_info(struct prueth *prueth, u32 buffer_descriptor,
 int icssm_emac_rx_packet(struct prueth_emac *emac, u16 *bd_rd_ptr,
 			 struct prueth_packet_info *pkt_info,
 			 const struct prueth_queue_info *rxqueue);
-
+void icssm_emac_mc_filter_bin_allow(struct prueth_emac *emac, u8 hash);
+void icssm_emac_mc_filter_bin_disallow(struct prueth_emac *emac, u8 hash);
+u8 icssm_emac_get_mc_hash(u8 *mac, u8 *mask);
 #endif /* __NET_TI_PRUETH_H */
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
index 65874959252e..fdd349a8bc72 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c
@@ -15,6 +15,16 @@
 
 #define FDB_MAC_TBL_ENTRY(n) (&prueth->fdb_tbl->mac_tbl_a->mac_tbl_entry[n])
 
+#define FDB_LEARN  1
+#define FDB_PURGE  2
+
+struct icssm_prueth_sw_fdb_work {
+	struct work_struct work;
+	struct prueth_emac *emac;
+	u8 addr[ETH_ALEN];
+	int event;
+};
+
 void icssm_prueth_sw_free_fdb_table(struct prueth *prueth)
 {
 	if (prueth->emac_configured)
@@ -539,3 +549,71 @@ void icssm_prueth_sw_fdb_del(struct prueth_emac *emac,
 {
 	icssm_prueth_sw_delete_fdb_entry(emac, fdb->addr, 1);
 }
+
+static void icssm_prueth_sw_fdb_work(struct work_struct *work)
+{
+	struct icssm_prueth_sw_fdb_work *fdb_work =
+		container_of(work, struct icssm_prueth_sw_fdb_work, work);
+	struct prueth_emac *emac = fdb_work->emac;
+
+	rtnl_lock();
+
+	/* Interface is not up */
+	if (!emac->prueth->fdb_tbl) {
+		rtnl_unlock();
+		goto free;
+	}
+
+	switch (fdb_work->event) {
+	case FDB_LEARN:
+		icssm_prueth_sw_insert_fdb_entry(emac, fdb_work->addr, 0);
+		break;
+	case FDB_PURGE:
+		icssm_prueth_sw_do_purge_fdb(emac);
+		break;
+	default:
+		break;
+	}
+	rtnl_unlock();
+
+free:
+	kfree(fdb_work);
+	dev_put(emac->ndev);
+}
+
+int icssm_prueth_sw_learn_fdb(struct prueth_emac *emac, u8 *src_mac)
+{
+	struct icssm_prueth_sw_fdb_work *fdb_work;
+
+	fdb_work = kzalloc(sizeof(*fdb_work), GFP_ATOMIC);
+	if (WARN_ON(!fdb_work))
+		return -ENOMEM;
+
+	INIT_WORK(&fdb_work->work, icssm_prueth_sw_fdb_work);
+
+	fdb_work->event = FDB_LEARN;
+	fdb_work->emac  = emac;
+	ether_addr_copy(fdb_work->addr, src_mac);
+
+	dev_hold(emac->ndev);
+	queue_work(system_long_wq, &fdb_work->work);
+	return 0;
+}
+
+int icssm_prueth_sw_purge_fdb(struct prueth_emac *emac)
+{
+	struct icssm_prueth_sw_fdb_work *fdb_work;
+
+	fdb_work = kzalloc(sizeof(*fdb_work), GFP_ATOMIC);
+	if (WARN_ON(!fdb_work))
+		return -ENOMEM;
+
+	INIT_WORK(&fdb_work->work, icssm_prueth_sw_fdb_work);
+
+	fdb_work->event = FDB_PURGE;
+	fdb_work->emac  = emac;
+
+	dev_hold(emac->ndev);
+	queue_work(system_long_wq, &fdb_work->work);
+	return 0;
+}
diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
index fd013ecdc707..d1a092b173a5 100644
--- a/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
+++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_switch.h
@@ -5,8 +5,16 @@
 #ifndef __NET_TI_PRUETH_SWITCH_H
 #define __NET_TI_PRUETH_SWITCH_H
 
+#include <net/switchdev.h>
+
 #include "icssm_prueth.h"
 #include "icssm_prueth_fdb_tbl.h"
+#include "icssm_switchdev.h"
+
+void icssm_prueth_sw_port_set_stp_state(struct prueth *prueth,
+					enum prueth_port port, u8 state);
+u8 icssm_prueth_sw_port_get_stp_state(struct prueth *prueth,
+				      enum prueth_port port);
 
 void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth);
 int icssm_prueth_sw_init_fdb_table(struct prueth *prueth);
@@ -16,5 +24,6 @@ void icssm_prueth_sw_fdb_add(struct prueth_emac *emac,
 			     struct switchdev_notifier_fdb_info *fdb);
 void icssm_prueth_sw_fdb_del(struct prueth_emac *emac,
 			     struct switchdev_notifier_fdb_info *fdb);
-
+int icssm_prueth_sw_learn_fdb(struct prueth_emac *emac, u8 *src_mac);
+int icssm_prueth_sw_purge_fdb(struct prueth_emac *emac);
 #endif /* __NET_TI_PRUETH_SWITCH_H */
diff --git a/drivers/net/ethernet/ti/icssm/icssm_switchdev.c b/drivers/net/ethernet/ti/icssm/icssm_switchdev.c
new file mode 100644
index 000000000000..57b83d790ebb
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_switchdev.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Texas Instruments ICSSM Ethernet Driver
+ *
+ * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/kernel.h>
+#include <linux/remoteproc.h>
+#include <net/switchdev.h>
+
+#include "icssm_prueth.h"
+#include "icssm_prueth_switch.h"
+#include "icssm_prueth_fdb_tbl.h"
+
+/* switchev event work */
+struct icssm_prueth_sw_switchdev_event_work {
+	struct work_struct work;
+	struct switchdev_notifier_fdb_info fdb_info;
+	struct prueth_emac *emac;
+	unsigned long event;
+};
+
+void icssm_prueth_sw_port_set_stp_state(struct prueth *prueth,
+					enum prueth_port port, u8 state)
+{
+	struct fdb_tbl *t = prueth->fdb_tbl;
+
+	writeb(state, port - 1 ? (void __iomem *)&t->port2_stp_cfg->state :
+			(void __iomem *)&t->port1_stp_cfg->state);
+}
+
+u8 icssm_prueth_sw_port_get_stp_state(struct prueth *prueth,
+				      enum prueth_port port)
+{
+	struct fdb_tbl *t = prueth->fdb_tbl;
+	u8 state;
+
+	state = readb(port - 1 ? (void __iomem *)&t->port2_stp_cfg->state :
+			(void __iomem *)&t->port1_stp_cfg->state);
+	return state;
+}
+
+static int icssm_prueth_switchdev_attr_set(struct net_device *ndev,
+					   const void *ctx,
+					   const struct switchdev_attr *attr,
+					   struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int err = 0;
+	u8 o_state;
+
+	/* Interface is not up */
+	if (!prueth->fdb_tbl)
+		return 0;
+
+	switch (attr->id) {
+	case SWITCHDEV_ATTR_ID_PORT_STP_STATE:
+		o_state = icssm_prueth_sw_port_get_stp_state(prueth,
+							     emac->port_id);
+		icssm_prueth_sw_port_set_stp_state(prueth, emac->port_id,
+						   attr->u.stp_state);
+
+		if (o_state != attr->u.stp_state)
+			icssm_prueth_sw_purge_fdb(emac);
+
+		dev_dbg(prueth->dev, "attr set: stp state:%u port:%u\n",
+			attr->u.stp_state, emac->port_id);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+		break;
+	}
+
+	return err;
+}
+
+static void
+icssm_prueth_sw_fdb_offload_notify(struct net_device *ndev,
+				   struct switchdev_notifier_fdb_info *rcv)
+{
+	struct switchdev_notifier_fdb_info info;
+
+	info.addr = rcv->addr;
+	info.vid = rcv->vid;
+	call_switchdev_notifiers(SWITCHDEV_FDB_OFFLOADED, ndev, &info.info,
+				 NULL);
+}
+
+/**
+ * icssm_prueth_sw_switchdev_event_work - insert/delete fdb entry
+ *
+ * @work: work structure
+ *
+ */
+static void icssm_prueth_sw_switchdev_event_work(struct work_struct *work)
+{
+	struct icssm_prueth_sw_switchdev_event_work *switchdev_work =
+		container_of(work,
+			     struct icssm_prueth_sw_switchdev_event_work, work);
+	struct prueth_emac *emac = switchdev_work->emac;
+	struct switchdev_notifier_fdb_info *fdb;
+	struct prueth *prueth = emac->prueth;
+	int port = emac->port_id;
+
+	rtnl_lock();
+
+	/* Interface is not up */
+	if (!emac->prueth->fdb_tbl) {
+		rtnl_unlock();
+		return;
+	}
+
+	switch (switchdev_work->event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+		fdb = &switchdev_work->fdb_info;
+		dev_dbg(prueth->dev,
+			"prueth fdb add: MACID = %pM vid = %u flags = %u -- port %d\n",
+			fdb->addr, fdb->vid, fdb->added_by_user, port);
+
+		if (!fdb->added_by_user)
+			break;
+
+		if (fdb->is_local)
+			break;
+
+		icssm_prueth_sw_fdb_add(emac, fdb);
+		icssm_prueth_sw_fdb_offload_notify(emac->ndev, fdb);
+		break;
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		fdb = &switchdev_work->fdb_info;
+		dev_dbg(prueth->dev,
+			"prueth fdb del: MACID = %pM vid = %u flags = %u -- port %d\n",
+			fdb->addr, fdb->vid, fdb->added_by_user, port);
+
+		if (fdb->is_local)
+			break;
+
+		icssm_prueth_sw_fdb_del(emac, fdb);
+		break;
+	default:
+		break;
+	}
+	rtnl_unlock();
+
+	kfree(switchdev_work->fdb_info.addr);
+	kfree(switchdev_work);
+	dev_put(emac->ndev);
+}
+
+/* called under rcu_read_lock() */
+static int icssm_prueth_sw_switchdev_event(struct notifier_block *unused,
+					   unsigned long event, void *ptr)
+{
+	struct net_device *ndev = switchdev_notifier_info_to_dev(ptr);
+	struct icssm_prueth_sw_switchdev_event_work *switchdev_work;
+	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int err;
+
+	if (!icssm_prueth_sw_port_dev_check(ndev))
+		return NOTIFY_DONE;
+
+	if (event == SWITCHDEV_PORT_ATTR_SET) {
+		err = switchdev_handle_port_attr_set
+			(ndev, ptr, icssm_prueth_sw_port_dev_check,
+			 icssm_prueth_switchdev_attr_set);
+		return notifier_from_errno(err);
+	}
+
+	switchdev_work = kzalloc(sizeof(*switchdev_work), GFP_ATOMIC);
+	if (WARN_ON(!switchdev_work))
+		return NOTIFY_BAD;
+
+	INIT_WORK(&switchdev_work->work, icssm_prueth_sw_switchdev_event_work);
+	switchdev_work->emac = emac;
+	switchdev_work->event = event;
+
+	switch (event) {
+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
+		memcpy(&switchdev_work->fdb_info, ptr,
+		       sizeof(switchdev_work->fdb_info));
+		switchdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
+		if (!switchdev_work->fdb_info.addr)
+			goto err_addr_alloc;
+		ether_addr_copy((u8 *)switchdev_work->fdb_info.addr,
+				fdb_info->addr);
+		dev_hold(ndev);
+		break;
+	default:
+		kfree(switchdev_work);
+		return NOTIFY_DONE;
+	}
+
+	queue_work(system_long_wq, &switchdev_work->work);
+
+	return NOTIFY_DONE;
+
+err_addr_alloc:
+	kfree(switchdev_work);
+	return NOTIFY_BAD;
+}
+
+static int icssm_prueth_switchdev_obj_add(struct net_device *ndev,
+					  const void *ctx,
+					  const struct switchdev_obj *obj,
+					  struct netlink_ext_ack *extack)
+{
+	struct switchdev_obj_port_mdb *mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	int ret = 0;
+	u8 hash;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		dev_dbg(prueth->dev, "MDB add: %s: vid %u:%pM  port: %x\n",
+			ndev->name, mdb->vid, mdb->addr, emac->port_id);
+		hash = icssm_emac_get_mc_hash(mdb->addr, emac->mc_filter_mask);
+		icssm_emac_mc_filter_bin_allow(emac, hash);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+static int icssm_prueth_switchdev_obj_del(struct net_device *ndev,
+					  const void *ctx,
+					  const struct switchdev_obj *obj)
+{
+	struct switchdev_obj_port_mdb *mdb = SWITCHDEV_OBJ_PORT_MDB(obj);
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	struct netdev_hw_addr *ha;
+	u8 hash, tmp_hash;
+	int ret = 0;
+
+	switch (obj->id) {
+	case SWITCHDEV_OBJ_ID_HOST_MDB:
+		dev_dbg(prueth->dev, "MDB del: %s: vid %u:%pM  port: %x\n",
+			ndev->name, mdb->vid, mdb->addr, emac->port_id);
+		hash = icssm_emac_get_mc_hash(mdb->addr, emac->mc_filter_mask);
+		netdev_for_each_mc_addr(ha, prueth->hw_bridge_dev) {
+			tmp_hash = icssm_emac_get_mc_hash(ha->addr,
+							  emac->mc_filter_mask);
+			/* Another MC address is in the bin. Don't disable. */
+			if (tmp_hash == hash)
+				return 0;
+		}
+		icssm_emac_mc_filter_bin_disallow(emac, hash);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+/* switchdev notifiers */
+static int
+icssm_prueth_sw_switchdev_blocking_event(struct notifier_block *unused,
+					 unsigned long event, void *ptr)
+{
+	struct net_device *ndev = switchdev_notifier_info_to_dev(ptr);
+	int err;
+
+	switch (event) {
+	case SWITCHDEV_PORT_OBJ_ADD:
+		err = switchdev_handle_port_obj_add
+			(ndev, ptr, icssm_prueth_sw_port_dev_check,
+			 icssm_prueth_switchdev_obj_add);
+		return notifier_from_errno(err);
+
+	case SWITCHDEV_PORT_OBJ_DEL:
+		err = switchdev_handle_port_obj_del
+			(ndev, ptr, icssm_prueth_sw_port_dev_check,
+			 icssm_prueth_switchdev_obj_del);
+		return notifier_from_errno(err);
+
+	case SWITCHDEV_PORT_ATTR_SET:
+		err = switchdev_handle_port_attr_set
+			(ndev, ptr, icssm_prueth_sw_port_dev_check,
+			 icssm_prueth_switchdev_attr_set);
+		return notifier_from_errno(err);
+
+	default:
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+int icssm_prueth_sw_register_notifiers(struct prueth *prueth)
+{
+	int ret = 0;
+
+	prueth->prueth_switchdev_nb.notifier_call =
+		&icssm_prueth_sw_switchdev_event;
+	ret = register_switchdev_notifier(&prueth->prueth_switchdev_nb);
+	if (ret) {
+		dev_err(prueth->dev,
+			"register switchdev notifier failed ret:%d\n", ret);
+		return ret;
+	}
+
+	prueth->prueth_switchdev_bl_nb.notifier_call =
+		&icssm_prueth_sw_switchdev_blocking_event;
+	ret = register_switchdev_blocking_notifier
+		(&prueth->prueth_switchdev_bl_nb);
+	if (ret) {
+		dev_err(prueth->dev,
+			"register switchdev blocking notifier failed ret:%d\n",
+			ret);
+		unregister_switchdev_notifier(&prueth->prueth_switchdev_nb);
+	}
+
+	return ret;
+}
+
+void icssm_prueth_sw_unregister_notifiers(struct prueth *prueth)
+{
+	unregister_switchdev_blocking_notifier(&prueth->prueth_switchdev_bl_nb);
+	unregister_switchdev_notifier(&prueth->prueth_switchdev_nb);
+}
diff --git a/drivers/net/ethernet/ti/icssm/icssm_switchdev.h b/drivers/net/ethernet/ti/icssm/icssm_switchdev.h
new file mode 100644
index 000000000000..b03a98e3472e
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_switchdev.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2020-2021 Texas Instruments Incorporated - https://www.ti.com
+ */
+
+#ifndef __NET_TI_ICSSM_SWITCHDEV_H
+#define __NET_TI_ICSSM_SWITCHDEV_H
+
+#include "icssm_prueth.h"
+
+int icssm_prueth_sw_register_notifiers(struct prueth *prueth);
+void icssm_prueth_sw_unregister_notifiers(struct prueth *prueth);
+bool icssm_prueth_sw_port_dev_check(const struct net_device *ndev);
+#endif /* __NET_TI_ICSSM_SWITCHDEV_H */
diff --git a/drivers/net/ethernet/ti/icssm/icssm_vlan_mcast_filter_mmap.h b/drivers/net/ethernet/ti/icssm/icssm_vlan_mcast_filter_mmap.h
new file mode 100644
index 000000000000..c177c19a36ef
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssm/icssm_vlan_mcast_filter_mmap.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Copyright (C) 2015-2021 Texas Instruments Incorporated - https://www.ti.com
+ *
+ * This file contains VLAN/Multicast filtering feature memory map
+ *
+ */
+
+#ifndef ICSS_VLAN_MULTICAST_FILTER_MM_H
+#define ICSS_VLAN_MULTICAST_FILTER_MM_H
+
+/* VLAN/Multicast filter defines & offsets,
+ * present on both PRU0 and PRU1 DRAM
+ */
+
+/* Feature enable/disable values for multicast filtering */
+#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_DISABLED		0x00
+#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_ENABLED		0x01
+
+/* Feature enable/disable values for VLAN filtering */
+#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_DISABLED			0x00
+#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_ENABLED			0x01
+
+/* Add/remove multicast mac id for filtering bin */
+#define ICSS_EMAC_FW_MULTICAST_FILTER_HOST_RCV_ALLOWED		0x01
+#define ICSS_EMAC_FW_MULTICAST_FILTER_HOST_RCV_NOT_ALLOWED	0x00
+
+/* Default HASH value for the multicast filtering Mask */
+#define ICSS_EMAC_FW_MULTICAST_FILTER_INIT_VAL			0xFF
+
+/* Size requirements for Multicast filtering feature */
+#define ICSS_EMAC_FW_MULTICAST_TABLE_SIZE_BYTES			       256
+#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_SIZE_BYTES			 6
+#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_SIZE_BYTES			 1
+#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_STATUS_SIZE_BYTES	 1
+#define ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_SIZE_BYTES		 4
+
+/* Size requirements for VLAN filtering feature : 4096 bits = 512 bytes */
+#define ICSS_EMAC_FW_VLAN_FILTER_TABLE_SIZE_BYTES		       512
+#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_SIZE_BYTES			 1
+#define ICSS_EMAC_FW_VLAN_FILTER_DROP_CNT_SIZE_BYTES			 4
+
+/* Mask override set status */
+#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_SET			 1
+/* Mask override not set status */
+#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_NOT_SET		 0
+/* 6 bytes HASH Mask for the MAC */
+#define ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET	  0xF4
+/* 0 -> multicast filtering disabled | 1 -> multicast filtering enabled */
+#define ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET	\
+	(ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OFFSET +	\
+	 ICSS_EMAC_FW_MULTICAST_FILTER_MASK_SIZE_BYTES)
+/* Status indicating if the HASH override is done or not: 0: no, 1: yes */
+#define ICSS_EMAC_FW_MULTICAST_FILTER_OVERRIDE_STATUS	\
+	(ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_OFFSET +	\
+	 ICSS_EMAC_FW_MULTICAST_FILTER_CTRL_SIZE_BYTES)
+/* Multicast drop statistics */
+#define ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_OFFSET	\
+	(ICSS_EMAC_FW_MULTICAST_FILTER_OVERRIDE_STATUS +\
+	 ICSS_EMAC_FW_MULTICAST_FILTER_MASK_OVERRIDE_STATUS_SIZE_BYTES)
+/* Multicast table */
+#define ICSS_EMAC_FW_MULTICAST_FILTER_TABLE		\
+	(ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_OFFSET +\
+	 ICSS_EMAC_FW_MULTICAST_FILTER_DROP_CNT_SIZE_BYTES)
+
+/* Multicast filter defines & offsets for LRE
+ */
+#define ICSS_LRE_FW_MULTICAST_TABLE_SEARCH_OP_CONTROL_BIT	0xE0
+/* one byte field :
+ * 0 -> multicast filtering disabled
+ * 1 -> multicast filtering enabled
+ */
+#define ICSS_LRE_FW_MULTICAST_FILTER_MASK			 0xE4
+#define ICSS_LRE_FW_MULTICAST_FILTER_TABLE			 0x100
+
+/* VLAN table Offsets */
+#define ICSS_EMAC_FW_VLAN_FLTR_TBL_BASE_ADDR		 0x200
+#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_BITMAP_OFFSET	 0xEF
+#define ICSS_EMAC_FW_VLAN_FILTER_DROP_CNT_OFFSET	\
+	(ICSS_EMAC_FW_VLAN_FILTER_CTRL_BITMAP_OFFSET +	\
+	 ICSS_EMAC_FW_VLAN_FILTER_CTRL_SIZE_BYTES)
+
+/* VLAN filter Control Bit maps */
+/* one bit field, bit 0: | 0 : VLAN filter disabled (default),
+ * 1: VLAN filter enabled
+ */
+#define ICSS_EMAC_FW_VLAN_FILTER_CTRL_ENABLE_BIT		       0
+/* one bit field, bit 1: | 0 : untagged host rcv allowed (default),
+ * 1: untagged host rcv not allowed
+ */
+#define ICSS_EMAC_FW_VLAN_FILTER_UNTAG_HOST_RCV_ALLOW_CTRL_BIT	       1
+/* one bit field, bit 1: | 0 : priotag host rcv allowed (default),
+ * 1: priotag host rcv not allowed
+ */
+#define ICSS_EMAC_FW_VLAN_FILTER_PRIOTAG_HOST_RCV_ALLOW_CTRL_BIT       2
+/* one bit field, bit 1: | 0 : skip sv vlan flow
+ * :1 : take sv vlan flow  (not applicable for dual emac )
+ */
+#define ICSS_EMAC_FW_VLAN_FILTER_SV_VLAN_FLOW_HOST_RCV_ALLOW_CTRL_BIT  3
+
+/* VLAN IDs */
+#define ICSS_EMAC_FW_VLAN_FILTER_PRIOTAG_VID			       0
+#define ICSS_EMAC_FW_VLAN_FILTER_VID_MIN			       0x0000
+#define ICSS_EMAC_FW_VLAN_FILTER_VID_MAX			       0x0FFF
+
+/* VLAN Filtering Commands */
+#define ICSS_EMAC_FW_VLAN_FILTER_ADD_VLAN_VID_CMD		       0x00
+#define ICSS_EMAC_FW_VLAN_FILTER_REMOVE_VLAN_VID_CMD		       0x01
+
+/* Switch defines for VLAN/MC filtering */
+/* SRAM
+ * VLAN filter defines & offsets
+ */
+#define ICSS_LRE_FW_VLAN_FLTR_CTRL_BYTE				 0x1FE
+/* one bit field | 0 : VLAN filter disabled
+ *		 | 1 : VLAN filter enabled
+ */
+#define ICSS_LRE_FW_VLAN_FLTR_TBL_BASE_ADDR			 0x200
+
+#endif /* ICSS_MULTICAST_FILTER_MM_H */
-- 
2.43.0


