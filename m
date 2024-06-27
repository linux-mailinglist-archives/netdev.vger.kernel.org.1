Return-Path: <netdev+bounces-107317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA991A8C3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4751F27FED
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE89198A10;
	Thu, 27 Jun 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cxT5/+ug"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96621196446;
	Thu, 27 Jun 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497410; cv=fail; b=ocDd5vNw6hgBHj3mIV3EzaqPdMoG0EwuhBJJGR3Cdttw9oBbdPWNlDialRGSQKSqA1xW8GBgvPu8z6m9G48fV/pzCMeSTKxiCIsN6QZh85BPrhg+owAEf8IzJHb+pFwW7dO8tpoa1l0J26LeD1cw53jRSPZ+oyd02StG7wqumko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497410; c=relaxed/simple;
	bh=F32vPIxZw4R+tVUf3f3aQxhqoM9YvVNcWeSJ7l/lx3U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8GSGamWyXXpx++TsGpCo0PgwF14ssNRaBSSMLte1FkrtpQ2fw4MbArMrIAUj8ljyD4+Uyh/BD1yVjGxUuVzkVNrKszuRah1NYBeKasEQxzbYVdLi56c2hiGmXbRescMm6mRrNSupuQhj6vzsZBmvl2XUbGhOh5kERw7/V5l+pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cxT5/+ug; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejyIi61BPx9LPCArF/OBVTcM6V58TwqHz0s8XeFPdarv7na34Kabj8+QINk00d5VACqbj2SBhioVQJ02EUUXJwu+BrIqK8tTn/UXoEfvYGLhm5rkOrGkRLDAcCoRKPW51lmVkcNV8V5mL+cTYpD6VnMwN0fk9IS+ARtagSp2GHVp5vQ5AojcbyFNA6qkpsPCjrJe8jBWd9tgKlhADjmfXz3/NZMY8e5+UeX7TlOyhQLHARmf+UtUSgiVakHvb6jfHN3EnDM24/aPvkATF2TcBW1ftaOI7MEKe4eXAtnECkvqGSvf5yYZbmFCfueNxA1Og0tTXhe9yaqTBTwGMjqPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0x9M4bDBCRjTJ2J3ocOJy0M8j1SiN9GVWWPMirmQu0=;
 b=KmisVEf000xLuEljTROEHGOVYEIQ6RzizY8kmtq8CqX6jQwn55Z2b/gzdLOvUjFG+nl3O9By7crO4K107S7VRAslTu81HCD24Gp07JYOXNm/w5WtOGWIpRMOVyoXMbILzldH4M3XpjJaGDVTUKo3RcR2icUhKttI1hd63Jvm8nlkaMq5akP0N9Cu0as9l2CBWY79/txb5NnvBcLxgtFvwcx+qxAIujTtjggexdRW/0miXrKQlP2XjBzLYc8J1Q9AsCvhewgb2+jEH5pHFYzfMWt48CG/KDfImTrcqXg/OwtjATJW2lzQ48uXA+j0ymWdPYcTrYGJXMd/Nb9EfdblAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0x9M4bDBCRjTJ2J3ocOJy0M8j1SiN9GVWWPMirmQu0=;
 b=cxT5/+ugLSxCiUixVCXgytmrmlRzMpIUbnJlz9ksmKr0fnDdfUy67w1HWDORcnq8T4E01Qc3Ml1OwMY+m2KsxIeMI1SfsJIDbYCnL7An6dr1hmnosYY5LO3bqHusxgq4ehGt4D/HMzKQjAOEyXqFPAi0rsBOAWs7NSZlwu8TpvW1WX2h35QcNZ03DYlx7fVkoTX16PVXksiq2AnaITcOxpLGc1gIL09XqlTpnJk/ZzU4cIdkf+dLeZL3HD5USdacKPje3SWRicnuE9+saIXRiiGPYX0tmKkyOf4IZtwQbQDEcuZNhIJnWhxjHvUJPPshnodfo/wCOya0A8w3FPkkTQ==
Received: from SA0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:130::21)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 14:10:04 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::84) by SA0PR13CA0016.outlook.office365.com
 (2603:10b6:806:130::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Thu, 27 Jun 2024 14:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:10:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:09:50 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:09:44 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <linux@armlinux.org.uk>,
	<sdf@google.com>, <kory.maincent@bootlin.com>,
	<maxime.chevallier@bootlin.com>, <vladimir.oltean@nxp.com>,
	<przemyslaw.kitszel@intel.com>, <ahmed.zaki@intel.com>,
	<richardcochran@gmail.com>, <shayagr@amazon.com>, <paul.greenwalt@intel.com>,
	<jiri@resnulli.us>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mlxsw@nvidia.com>, <idosch@nvidia.com>,
	<petrm@nvidia.com>, Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH net-next v8 5/9] ethtool: Veto some operations during firmware flashing process
Date: Thu, 27 Jun 2024 17:08:52 +0300
Message-ID: <20240627140857.1398100-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627140857.1398100-1-danieller@nvidia.com>
References: <20240627140857.1398100-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7a68be-33d8-4607-f585-08dc96b2d791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y8UGWFjh5ZlvCAfBaR2bmeAACV95OG5/+U9Fc7Y5pFe3TKq11BsToLLTVnvs?=
 =?us-ascii?Q?fxBOQuLyKuiteKlp1YCPtBMu//JkIQa31uk6IrwmKtosj0cFO2p0N9mLXcas?=
 =?us-ascii?Q?YH3uKINUoDLyMfBWeWubBOrg8G9Fs7RJ2I3F7sPnty/UiznREwW17MDNwj12?=
 =?us-ascii?Q?rk4tAbMcVKATJ9ired2CnYaHaR6SVkIBOgWKYzjihEEgoInCDNsguIVPPYso?=
 =?us-ascii?Q?m80I/QUujnI2nU49Tt1BJQcgDr7UGEJ5Xbnwg9sBcLeLzB978jUbVNFfSy6j?=
 =?us-ascii?Q?or7jYm7qq8jmdlADOlVVrFgstfBaEDa01uR/rZrAN+zz4SX89vHMO0d9gL/1?=
 =?us-ascii?Q?DG4imDtOGerthotQ125+gTxkzxjrW5+Bkli1MMv6GI1W81FN1TOAM13Y/h0H?=
 =?us-ascii?Q?LSFdyD2QSpKT9L+AMPaw+QHP99RUv7L8gIrdi94qy8eEQGBqYtbMesTcFpps?=
 =?us-ascii?Q?c6xw3oHNMYgTUwNmNHpUmhXEsVYK1SeCiJ/nuWWfXu9ghXB3UAn+J6sVnf1k?=
 =?us-ascii?Q?W7Wuh57k67eRLCteWiw0erUBylM2Nwl3V1b+Rt1oEFsMk4H4ReNiJ0Y/k7py?=
 =?us-ascii?Q?sC+k7HkyKWljfC9xwDiEOmtFeCOrPvOwlAylJiPtLxY3A5ryYGMshVTfSnDD?=
 =?us-ascii?Q?hRwgo3NTizie/8yG6iKkF4s/GHtxMD9tHl3FyES+yuHsykthGDAVI4bbSt9H?=
 =?us-ascii?Q?gVoKp4MLPmHkPgBpYJnbHHhZ9bjvoanMuWYSVuEppe2N4sSzJZrDPTt+HuOO?=
 =?us-ascii?Q?+uY8tweRlf72iMx0Nzy/8yHrHkAI2OGsBCy5txSdFsTKRnHaVro0xgDc8YLZ?=
 =?us-ascii?Q?HfSgh2y/LYMVs56NBHeTDrLFO8zjbbd9EDfs7BzLAl/Z0eU+qwhxis+5S6Iz?=
 =?us-ascii?Q?AtCRSyUUwvP5gfwH7RwfEV2UGL88zebYVpLsqKhziCw5c1l0TnvlvKJUX7sy?=
 =?us-ascii?Q?hRFZeWCiMi5giob5TC2QHuF0xRH/OL+tI4ljCqNUkz8ZJ76MVq77LDhv+GWo?=
 =?us-ascii?Q?kl0cICWSbTPlnD4Nw+n4paauNnS//yb3sJaD7S6fxOifCEqpPv4dVmPXA14e?=
 =?us-ascii?Q?GOx7zjB/PkROnkl93YdpeV35z1sFP3Kl6PHo82jzTy0x/VbY600MRJbG7hUT?=
 =?us-ascii?Q?hAxPnQAxhEQ2NrIesUmytXqWnCi1Gkk5LR8vXA8QQLdLnFtAcsgm5DW7DrbR?=
 =?us-ascii?Q?REYWsuN+T4gB5/KVNZxMxdBdLeDADEz9WEsr1dzOIOS6XF7blxHd4avfZbDY?=
 =?us-ascii?Q?7qc3rjvflZ8DpFGfxRc6nIh8xy5b0Vg7bR9016A4pGmER+ygk30a+DwbM6wv?=
 =?us-ascii?Q?65Ad4LkNe+F3mmISz8t9rmO3ALTgKZiWZDFcmXOCekCyy0ryheu1dexdZhrJ?=
 =?us-ascii?Q?RwnPn6aOqI3eeqtFGN9/0T5XW6odK9an3uBMX1xhFHxclbE2+iZmkvBtOjT9?=
 =?us-ascii?Q?4GNZTmSPe4spE3nYP6VLud3IHlYf1tqf?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:10:04.3373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7a68be-33d8-4607-f585-08dc96b2d791
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

Some operations cannot be performed during the firmware flashing
process.

For example:

- Port must be down during the whole flashing process to avoid packet loss
  while committing reset for example.

- Writing to EEPROM interrupts the flashing process, so operations like
  ethtool dump, module reset, get and set power mode should be vetoed.

- Split port firmware flashing should be vetoed.

In order to veto those scenarios, add a flag in 'struct net_device' that
indicates when a firmware flash is taking place on the module and use it
to prevent interruptions during the process.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    v6:
    	* Squash some of the vetoes from the last patch to this patch.

 include/linux/netdevice.h |  4 +++-
 net/ethtool/eeprom.c      |  6 ++++++
 net/ethtool/ioctl.c       | 12 ++++++++++++
 net/ethtool/netlink.c     | 12 ++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cc18acd3c58b..1e3401093c13 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1990,6 +1990,8 @@ enum netdev_reg_state {
  *
  *	@threaded:	napi threaded mode is enabled
  *
+ *	@module_fw_flash_in_progress:	Module firmware flashing is in progress.
+ *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
  *				to another network namespace.
@@ -2374,7 +2376,7 @@ struct net_device {
 	bool			proto_down;
 	bool			threaded;
 	unsigned		wol_enabled:1;
-
+	unsigned		module_fw_flash_in_progress:1;
 	struct list_head	net_notifier_list;
 
 #if IS_ENABLED(CONFIG_MACSEC)
diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index 6209c3a9c8f7..f36811b3ecf1 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -91,6 +91,12 @@ static int get_module_eeprom_by_page(struct net_device *dev,
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 
+	if (dev->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(extack,
+			       "Module firmware flashing is in progress");
+		return -EBUSY;
+	}
+
 	if (dev->sfp_bus)
 		return sfp_get_module_eeprom_by_page(dev->sfp_bus, page_data, extack);
 
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index e645d751a5e8..1cca372c0d80 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -658,6 +658,9 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
+	if (dev->module_fw_flash_in_progress)
+		return -EBUSY;
+
 	memset(&link_ksettings, 0, sizeof(link_ksettings));
 	err = dev->ethtool_ops->get_link_ksettings(dev, &link_ksettings);
 	if (err < 0)
@@ -1449,6 +1452,9 @@ static int ethtool_reset(struct net_device *dev, char __user *useraddr)
 	if (!dev->ethtool_ops->reset)
 		return -EOPNOTSUPP;
 
+	if (dev->module_fw_flash_in_progress)
+		return -EBUSY;
+
 	if (copy_from_user(&reset, useraddr, sizeof(reset)))
 		return -EFAULT;
 
@@ -2462,6 +2468,9 @@ int ethtool_get_module_info_call(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
 
+	if (dev->module_fw_flash_in_progress)
+		return -EBUSY;
+
 	if (dev->sfp_bus)
 		return sfp_get_module_info(dev->sfp_bus, modinfo);
 
@@ -2499,6 +2508,9 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
 
+	if (dev->module_fw_flash_in_progress)
+		return -EBUSY;
+
 	if (dev->sfp_bus)
 		return sfp_get_module_eeprom(dev->sfp_bus, ee, data);
 
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 393ce668fb04..a5907bbde427 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -765,10 +765,22 @@ static void ethnl_notify_features(struct netdev_notifier_info *info)
 static int ethnl_netdev_event(struct notifier_block *this, unsigned long event,
 			      void *ptr)
 {
+	struct netdev_notifier_info *info = ptr;
+	struct netlink_ext_ack *extack;
+	struct net_device *dev;
+
+	dev = netdev_notifier_info_to_dev(info);
+	extack = netdev_notifier_info_to_extack(info);
+
 	switch (event) {
 	case NETDEV_FEAT_CHANGE:
 		ethnl_notify_features(ptr);
 		break;
+	case NETDEV_PRE_UP:
+		if (dev->module_fw_flash_in_progress) {
+			NL_SET_ERR_MSG(extack, "Can't set port up while flashing module firmware");
+			return NOTIFY_BAD;
+		}
 	}
 
 	return NOTIFY_DONE;
-- 
2.45.0


