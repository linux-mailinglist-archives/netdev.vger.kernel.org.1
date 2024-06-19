Return-Path: <netdev+bounces-104853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263C090EAD1
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A806B1F23F2D
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B971459F0;
	Wed, 19 Jun 2024 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sPw1jV5h"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13309145352;
	Wed, 19 Jun 2024 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799516; cv=fail; b=b8u7v6MHWuX0sLn1mXPPQ/n7JYaYLiOk3D7IEdSe8Gn22eCsGGc+nOgdEuNv955kXgdz2UGMoVbf5Eh+KyVXzvPSwGyTw/QDnWIdMLEKSbUCr4yYDkpc/hkd7zY7B9PF0FUQZ1z676RbV4VPAshj/m6ZUPOxn7FeO46R1llRYMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799516; c=relaxed/simple;
	bh=LiM6FI3aPU5AENZAzmZY2RXjQ1QEzSTefeg3Z8ZTYFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9blWvlWQ5p0vatn8S7BVA6zNkYZWvc9whrvaltSJniI0Ji/TBKh7H75Jl9Sgc6L7ukSL3FvlDCU2BWKmSgmP09RsWsOby5VWyRRmgi3V7G9TuITQheUQetyv2chbVxD1Fa5hZsdvbklQ1RqB6YzrqSdpJw37r/zI3M+QcqX0bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sPw1jV5h; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxLBH3c/DF6pX7lnQFMD0lRQnzPgIzJsFXxL1LRkuPB4kBtITRLx2SRyKVJDGMZKgfzWpaDDIfgmNbg9malXfQY+zoVzBIkyPA/ayqQcr5DblWxG9fMf0j2tB7O7tW8zHsSF+QUpXrn+dfAUUwpofMATQJ/X6BiDZe4/z2Rs2PY1MU1JYRW16f4zcWAt4FpIchmLzqLlKyPGjJS2sKiFMb1RPWNdNPcUgjfbLKEiHI5tiZLJGEjVhYyJ7PbcpAHXQ1I+6KZ/tpmC++klbCRPwJ2N9bZTwtqkU19mBSkp8jWYp/14D+TGujBNofn4QYOk4g5fMr0ORa0JIW7g/pfkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqz3R0tPPOWZl/n+Avi0lgJyF400COPcQrtB82HLOys=;
 b=SsINisZLxl75mcrfvs0SNjWt0sqoa7Q+/edmu8EUyk//OMg1OuQCRzNI2nShbhr9oTZ4vLvjYawrccbbjoaZDBrVp2B2826uy6fRmH4hKs5GcjMVxU+k8Zm6aBf44/NBLbKJgwE7+ov6S5d/60bUByYFc/vmmGiQtFb3qpjIiVh5tB6tcy1RU7xeAOu4URNFUYV55GgWjiwz7mWB8UfKlsSImbkr08So2XbIukqWFbm2HUunW9JqXR4Yfz0M20YB17yPG3S3yLczZjxny+cSqk35aBLgFInbpQOzbBvzOCYWVcPHGaQHkG7CZ3WT++81apSVjzekMn+horhsZJCdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqz3R0tPPOWZl/n+Avi0lgJyF400COPcQrtB82HLOys=;
 b=sPw1jV5hsy00acN0BuWXGRee/nkbKnt/7/S8zLgWBKZPEKZyeB4nGf/S/inJH1EbqZdZ04xZFMc7JcLsoo2SM3+CKwxmiLml1u77T3Rv8EseiEcMVD4LsqW6jzA0ac/rKepUZlOktnFkQr+M7u7w7MPTjLJtUyUE6O0K9ARaWSKTXOxa1jOzV9dSSGksMGd6yu3p/WhnIC3WikIrnBNWikVWocIN82jpKHP+mu08kzV0IJUi3e7Xpe0UrF/9ssE4WoSMO/TJdt5EgRywpLJilhU4gNVTaTxMa0GjfK3vKM8oBteovX5VpQOciK3bpinGhL3g2hGrIU01hIAQh4W7Bw==
Received: from BN0PR04CA0052.namprd04.prod.outlook.com (2603:10b6:408:e8::27)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 12:18:30 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::82) by BN0PR04CA0052.outlook.office365.com
 (2603:10b6:408:e8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 12:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 12:18:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 05:18:16 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 05:18:10 -0700
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
Subject: [PATCH net-next v6 5/9] ethtool: Veto some operations during firmware flashing process
Date: Wed, 19 Jun 2024 15:17:23 +0300
Message-ID: <20240619121727.3643161-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619121727.3643161-1-danieller@nvidia.com>
References: <20240619121727.3643161-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: 952902d5-2edb-4faf-4d17-08dc9059ee75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JI67lGsEOECnGrA7tYU17Vzq+X7vGgtLvHOdcwdP7g64EHowinbxe+C1QmAY?=
 =?us-ascii?Q?RRRPNxvCipL61BvOgKsAPi1db9mJZA+jPLl4OyWnzMILqNwX0lQ/5PnBps8M?=
 =?us-ascii?Q?u4ZTDG6tfGYTex9TH0EoSvJVzn43T6U5AFWnO00+GrAOUxzizG3ofzifhx3e?=
 =?us-ascii?Q?1Qdk5QsaazPIPXt//ejfUY5/SPUXoqZtce7PFGbs53RTy9TjE1h0LmV4IbtM?=
 =?us-ascii?Q?XQbv95FR+qEnpA7PHkxJGOyt94f1QD31lZtm2pnJQJFhAwYFbV42RIHwlxNM?=
 =?us-ascii?Q?HZ2tnpgcUzfW2GSpzzk74cFccE77R/KvHdLOvgM7RhQtIQv9Z9w9sc453STb?=
 =?us-ascii?Q?7pEDV3aB5dzXMJuQr5VMP8LkItwZ3e8svlfOX1lWedony0f99C1pGUbLhFtH?=
 =?us-ascii?Q?9MSuAdchMAhQTPUofxBooOKXRICgG5AFCVdHTmWrg5iI/F9nsu0+LSoJX2Kr?=
 =?us-ascii?Q?doujNW42QY7vJOVE67pBrXAvAe8UJklpBANBs0YXT+udfMsqhg/wZmAOpOpT?=
 =?us-ascii?Q?rGHrjAV3pmovy2SUfQ4O+buG2T+y13VkpomvkM0YMbq9NzV6pK5Nr8WpdGqS?=
 =?us-ascii?Q?GpTX9ivUwpWcPNWNOyk/1v6hB77djOImHR4A0LjyhBbrE0FeNUaVPo934vAw?=
 =?us-ascii?Q?4cPJnHNSXj4iJEqW31NqIKAssUn4uC2YEjoZEGg0jTgrURAxwvtA1yEwK584?=
 =?us-ascii?Q?AeqdX85gJgrzQUC+aDeEAXcZgydp1i3GI8fLM2/vOR7PtHWcZ7SPYZW4uGRy?=
 =?us-ascii?Q?rgIpnq7jI3PDbp/Nw6NyPZjqAfF1c4O6QgHX3Ok9S98RXzewZQBBZGrpnq3K?=
 =?us-ascii?Q?rdxZcqZ/EVDmEKv864OhnMRH3s27oJ5N+4QAMfW8aGNgb2SxhrA6I696g8hn?=
 =?us-ascii?Q?Vn/fKS1226/uY43yupn8IWXTf8xWq0r25Lk0mVZwdltkTSSMeAp/EWOEPwXq?=
 =?us-ascii?Q?aGv8OYYLGezPMHOiGtjV0Lt7E0Jss5xKWatrFFEhH1seQdkBn0/IqWIT89nn?=
 =?us-ascii?Q?A1F/4ucsu5jF4Sx8LjifIoPagJpK03fyD/YTk9RfZMaG2J3rzIwHf3AdRQ6d?=
 =?us-ascii?Q?skE4GTGdUaqgMeTDVgP7AUGOIrYrP5o7u7OeKHX3Eg/X1Q7pfMCoaQU7mixY?=
 =?us-ascii?Q?7kPFLzbe6bXkKLx+2EnMDd4PzB4TIv+Fk4aGBEX0MmIYR+pNojmnrBKMjLFb?=
 =?us-ascii?Q?iNqWxMQC/Kx8vWYZxpBUcEMBoqaw2mbz3A/OOLgjvs3X5SJnz0irDK5lldPY?=
 =?us-ascii?Q?gTv1n8aRNBkjlLAhOTw9jmAXOau/rsKHEa1tkQRt9PNG/R658j+CptBNDf/c?=
 =?us-ascii?Q?c77YaXO8fSCZFXcAj9RJbIhuBo8hfK+AlAr+qKI7F47FhJz9k169vah83Elk?=
 =?us-ascii?Q?nvzi4dVRqE1E2I+hs7ZF38Op8QAKd8pjY6F6lccQdSup43NhSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:18:30.4890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 952902d5-2edb-4faf-4d17-08dc9059ee75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

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
index f148a01dd1d1..43ec53fc0128 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1989,6 +1989,8 @@ enum netdev_reg_state {
  *
  *	@threaded:	napi threaded mode is enabled
  *
+ *	@module_fw_flash_in_progress:	Module firmware flashing is in progress.
+ *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
  *				to another network namespace.
@@ -2373,7 +2375,7 @@ struct net_device {
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


