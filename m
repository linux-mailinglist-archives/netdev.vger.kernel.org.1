Return-Path: <netdev+bounces-36603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51B7B0BC6
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 20:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 05BC82851E2
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 18:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA0A4C86D;
	Wed, 27 Sep 2023 18:14:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8AA4C84C
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 18:14:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5879A1
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 11:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYPXhuQu9cj5mUmrvk6G40drp0gFEghsdJRsqKpTUUCD4f9N8IJPiM8L38VeJHy24MPM8/215gaKQxYT3oi2UHoacVU8RAw1jctmi/5musSmyFb73KtQzn5Wil1P9eRf08/mWfdFM6OWx7hW3WE6U4QUL5Ywkhqzi1Fey2gp1nYJxB053ALXr6hVo9D0xr8Zj4HGqawz8Q4E4/OqKMfI4Qt+IcozVFwu/tytTCNs9j0l8BMSdErLGKEcKDs0vlizw3NAp60AqeUlA66gcm3V6vNGJD7f182MQKdt3ZhYTkZZK65MsenG/A+LoyGbBnFM969U+FtD/rDnqkhrDE3FHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qu6gKxwUWzgm6TxjLdtc0KxjSSQkyxrnIniAX9jBMp8=;
 b=kPOeTb4dEH6EzyV07BDkw2ZjbCmuE8qYA5v0yKIpds5fUneFZBM3Eur3jtChq+8RUTim4Th619P9hZK+1nn1Nuir2dCQOjl9z5juUzs4oNkA0qmUMUHQfHKa49ySlhwbmY/no3pbGdyO2MwGgXRsLp+Mjr4mtZ2xHIjXw+ePNPcT4b3HeQfffMLa2FscROUSeWrX6dJsPmWSA3pLCWdclWQOV11UyzoX1FxBG9SM0PKzq0rVCIKJNII9fkH4pakIlOx+i6TvMcjDUE+haMbePfniAJMNnIlGNSgJCzyeIZxB1LCLqbGigOhP+OOa3upVFEAgkz0WlpkD12SyYxSjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=net-swift.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qu6gKxwUWzgm6TxjLdtc0KxjSSQkyxrnIniAX9jBMp8=;
 b=Ng1tImFdQkdODZ0OLMt+s9NTwFs5Rh0uy5LW+3rxi4iPx7/7QcO4zbjiTHcbkDFUba2nqnZnz5UKa4gLRCPC4BG+moMnB4AZjK7aDRG+LR8Lv24RwuW9MdEMvR3yMEgK5uj3STrBcZZlFNXMMPeZGWVwf233tTcLNGlgASeNX4M=
Received: from SN7PR04CA0233.namprd04.prod.outlook.com (2603:10b6:806:127::28)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 18:14:24 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:127:cafe::9f) by SN7PR04CA0233.outlook.office365.com
 (2603:10b6:806:127::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 18:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 18:14:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 27 Sep
 2023 13:14:22 -0500
Received: from xcbecree41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 27 Sep 2023 13:14:20 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <hkallweit1@gmail.com>, <nic_swsd@realtek.com>,
	<jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>
Subject: [PATCH v4 net-next 1/7] net: move ethtool-related netdev state into its own struct
Date: Wed, 27 Sep 2023 19:13:32 +0100
Message-ID: <31cdf199dad8e26bd5f732fd04b0d640c41f5616.1695838185.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1695838185.git.ecree.xilinx@gmail.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d0a4bf-28f9-4f58-8f3c-08dbbf8593d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ENcBgcKorDZHc3OBivedzQCoZZX49pTU5599G4jv7lQR5GUWLHS0OkYWGZO9XYHBkgTzVS//CpbWY7Iq6oSf2azmy4JgGgZSCBIT9AhdZuKlD7wi/2Q7zRVU34Wsgel92Xh19IlKLvEvk422D//YNfBN6izIZ2QkTHHHolAcovmGfL9syc/giCCMvJ/3tjzIC3U714ER0uONF83FUCdMJoIo7bc9SvlMQi4O2f0GQpVzM1kG+4OWtBACf291zvh1d3cbpdkkh/IZoAQbIHXQK/LCU6GWQJMQG6EpqTvH48NLPE39GQfsPecS067Ig1myiGDK0WGVbObadWnxcSmREhaXLKd7yZPbvivlxys9fMT4bls7YWH0/Ls3cOrarDJkHRXZCklLnLF6n9t9l7RUb0GMGUkppu5zN1jm35NRJ7aazQBHesx3puGjB/t+7h1AbGZyaMl6O3mrL15Ym/ri4nwT0Mt09nU9lDdhm9Muh1dCZw1ZgCsvFF7xoiKZm7v8ANSTNL4QeAO2GixYQUHhV92fC3j5WxfGOQvBX0iqUFEIBIrxOSM4Czr2MCN416xf5HIxOFfK44Mb5MQ0CHPz6EEWpwxUnf3kYq0dzwC95v25+BfrAOn+dxhWv/dWcyJlyf0J7eIHuENTeDOJaUeBvFhLFWDmfixUssQlO15FSc3zpdFh7Q1+cqHairEBukC8qtothUbK7uzqfZatr5g4KW5A9LvymUCjJ0b0ceTPdaHh7zJ3pNSE3/scVmMwYZEakaSPl5sA0Y/B2WywJen9x25JEoZyIhm1XDDktN4dsIU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(316002)(5660300002)(36860700001)(8936002)(40480700001)(4326008)(8676002)(41300700001)(110136005)(54906003)(70206006)(70586007)(7416002)(2876002)(40460700003)(2906002)(356005)(9686003)(81166007)(55446002)(36756003)(47076005)(478600001)(26005)(86362001)(83380400001)(336012)(426003)(82740400003)(6666004)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 18:14:23.4168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d0a4bf-28f9-4f58-8f3c-08dbbf8593d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Edward Cree <ecree.xilinx@gmail.com>

net_dev->ethtool is a pointer to new struct ethtool_netdev_state, which
 currently contains only the wol_enabled field.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c        | 4 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c | 4 ++--
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c    | 2 +-
 drivers/net/phy/phy.c                            | 2 +-
 drivers/net/phy/phy_device.c                     | 5 +++--
 drivers/net/phy/phylink.c                        | 2 +-
 include/linux/ethtool.h                          | 8 ++++++++
 include/linux/netdevice.h                        | 7 ++++---
 net/core/dev.c                                   | 4 ++++
 net/ethtool/ioctl.c                              | 2 +-
 net/ethtool/wol.c                                | 2 +-
 11 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 6351a2dc13bc..fe69416f2a93 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1455,7 +1455,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 
 	if (tp->dash_type == RTL_DASH_NONE) {
 		rtl_set_d3_pll_down(tp, !wolopts);
-		tp->dev->wol_enabled = wolopts ? 1 : 0;
+		tp->dev->ethtool->wol_enabled = wolopts ? 1 : 0;
 	}
 }
 
@@ -5321,7 +5321,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		rtl_set_d3_pll_down(tp, true);
 	} else {
 		rtl_set_d3_pll_down(tp, false);
-		dev->wol_enabled = 1;
+		dev->ethtool->wol_enabled = 1;
 	}
 
 	jumbo_max = rtl_jumbo_max(tp);
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
index ec0e869e9aac..091ee3d3e74d 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_ethtool.c
@@ -34,9 +34,9 @@ static int ngbe_set_wol(struct net_device *netdev,
 	wx->wol = 0;
 	if (wol->wolopts & WAKE_MAGIC)
 		wx->wol = WX_PSR_WKUP_CTL_MAG;
-	netdev->wol_enabled = !!(wx->wol);
+	netdev->ethtool->wol_enabled = !!(wx->wol);
 	wr32(wx, WX_PSR_WKUP_CTL, wx->wol);
-	device_set_wakeup_enable(&pdev->dev, netdev->wol_enabled);
+	device_set_wakeup_enable(&pdev->dev, netdev->ethtool->wol_enabled);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index 2b431db6085a..6752f8d04d9c 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -636,7 +636,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	if (wx->wol_hw_supported)
 		wx->wol = NGBE_PSR_WKUP_CTL_MAG;
 
-	netdev->wol_enabled = !!(wx->wol);
+	netdev->ethtool->wol_enabled = !!(wx->wol);
 	wr32(wx, NGBE_PSR_WKUP_CTL, wx->wol);
 	device_set_wakeup_enable(&pdev->dev, wx->wol);
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index a5fa077650e8..32bfea9b5c6c 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1282,7 +1282,7 @@ static irqreturn_t phy_interrupt(int irq, void *phy_dat)
 		if (netdev) {
 			struct device *parent = netdev->dev.parent;
 
-			if (netdev->wol_enabled)
+			if (netdev->ethtool->wol_enabled)
 				pm_system_wakeup();
 			else if (device_may_wakeup(&netdev->dev))
 				pm_wakeup_dev_event(&netdev->dev, 0, true);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2ce74593d6e4..62afc0424fbd 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -285,7 +285,7 @@ static bool mdio_bus_phy_may_suspend(struct phy_device *phydev)
 	if (!netdev)
 		goto out;
 
-	if (netdev->wol_enabled)
+	if (netdev->ethtool->wol_enabled)
 		return false;
 
 	/* As long as not all affected network drivers support the
@@ -1859,7 +1859,8 @@ int phy_suspend(struct phy_device *phydev)
 		return 0;
 
 	phy_ethtool_get_wol(phydev, &wol);
-	phydev->wol_enabled = wol.wolopts || (netdev && netdev->wol_enabled);
+	phydev->wol_enabled = wol.wolopts ||
+			      (netdev && netdev->ethtool->wol_enabled);
 	/* If the device has WOL enabled, we cannot suspend the PHY */
 	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
 		return -EBUSY;
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0d7354955d62..b808ba1197c3 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2172,7 +2172,7 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 {
 	ASSERT_RTNL();
 
-	if (mac_wol && (!pl->netdev || pl->netdev->wol_enabled)) {
+	if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
 		/* Wake-on-Lan enabled, MAC handling */
 		mutex_lock(&pl->state_mutex);
 
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..8aeefc0b4e10 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -935,6 +935,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
 				       const struct ethtool_link_ksettings *cmd,
 				       u32 *dev_speed, u8 *dev_duplex);
 
+/**
+ * struct ethtool_netdev_state - per-netdevice state for ethtool features
+ * @wol_enabled:	Wake-on-LAN is enabled
+ */
+struct ethtool_netdev_state {
+	unsigned		wol_enabled:1;
+};
+
 struct phy_device;
 struct phy_tdr_config;
 struct phy_plca_cfg;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7e520c14eb8c..05ea6cb56800 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -79,6 +79,7 @@ struct xdp_buff;
 struct xdp_frame;
 struct xdp_metadata_ops;
 struct xdp_md;
+struct ethtool_netdev_state;
 /* DPLL specific */
 struct dpll_pin;
 
@@ -2014,8 +2015,6 @@ enum netdev_ml_priv_type {
  *			switch driver and used to set the phys state of the
  *			switch port.
  *
- *	@wol_enabled:	Wake-on-LAN is enabled
- *
  *	@threaded:	napi threaded mode is enabled
  *
  *	@net_notifier_list:	List of per-net netdev notifier block
@@ -2027,6 +2026,7 @@ enum netdev_ml_priv_type {
  *	@udp_tunnel_nic_info:	static structure describing the UDP tunnel
  *				offload capabilities of the device
  *	@udp_tunnel_nic:	UDP tunnel offload state
+ *	@ethtool:	ethtool related state
  *	@xdp_state:		stores info on attached XDP BPF programs
  *
  *	@nested_level:	Used as a parameter of spin_lock_nested() of
@@ -2389,7 +2389,6 @@ struct net_device {
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
-	unsigned		wol_enabled:1;
 	unsigned		threaded:1;
 
 	struct list_head	net_notifier_list;
@@ -2401,6 +2400,8 @@ struct net_device {
 	const struct udp_tunnel_nic_info	*udp_tunnel_nic_info;
 	struct udp_tunnel_nic	*udp_tunnel_nic;
 
+	struct ethtool_netdev_state *ethtool;
+
 	/* protected by rtnl_lock */
 	struct bpf_xdp_entity	xdp_state[__MAX_XDP_MODE];
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 606a366cc209..9e85a71e33ed 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10769,6 +10769,9 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 	dev->real_num_rx_queues = rxqs;
 	if (netif_alloc_rx_queues(dev))
 		goto free_all;
+	dev->ethtool = kzalloc(sizeof(*dev->ethtool), GFP_KERNEL_ACCOUNT);
+	if (!dev->ethtool)
+		goto free_all;
 
 	strcpy(dev->name, name);
 	dev->name_assign_type = name_assign_type;
@@ -10819,6 +10822,7 @@ void free_netdev(struct net_device *dev)
 		return;
 	}
 
+	kfree(dev->ethtool);
 	netif_free_tx_queues(dev);
 	netif_free_rx_queues(dev);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 0b0ce4f81c01..de78b24fffc9 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1461,7 +1461,7 @@ static int ethtool_set_wol(struct net_device *dev, char __user *useraddr)
 	if (ret)
 		return ret;
 
-	dev->wol_enabled = !!wol.wolopts;
+	dev->ethtool->wol_enabled = !!wol.wolopts;
 	ethtool_notify(dev, ETHTOOL_MSG_WOL_NTF, NULL);
 
 	return 0;
diff --git a/net/ethtool/wol.c b/net/ethtool/wol.c
index 0ed56c9ac1bc..a39d8000d808 100644
--- a/net/ethtool/wol.c
+++ b/net/ethtool/wol.c
@@ -137,7 +137,7 @@ ethnl_set_wol(struct ethnl_req_info *req_info, struct genl_info *info)
 	ret = dev->ethtool_ops->set_wol(dev, &wol);
 	if (ret)
 		return ret;
-	dev->wol_enabled = !!wol.wolopts;
+	dev->ethtool->wol_enabled = !!wol.wolopts;
 	return 1;
 }
 

