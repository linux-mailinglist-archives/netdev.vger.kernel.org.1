Return-Path: <netdev+bounces-106224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EC49155EC
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A987E288510
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307621A073B;
	Mon, 24 Jun 2024 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y3XMhGO6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7571A072C;
	Mon, 24 Jun 2024 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251595; cv=fail; b=Jt9YbttTRVxVtlPhOmHf3ludOzox/HWOQOHmv2Ua+fX6jp3KYi6kPGEGJjocgmPWL0Uu/MxQmHko716R50zST0KY5Z3Z+FjF0ZQj4/gCKhGOhlkmO+AIK/vsFw9I4aNtZS7A0gPRlowrH3K80uZ34CKmLGi8SyuH/Ui5YIf2HdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251595; c=relaxed/simple;
	bh=LiM6FI3aPU5AENZAzmZY2RXjQ1QEzSTefeg3Z8ZTYFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgWX9ellXZCSVkL4evrdPWoFUzFehYevRNXzwF9I9sPMGjDVR1Ypqn8aW/Td+MnmDW4dToGJrWVw0YQNXNg780dG3EqKOnM9NsTobkiLXy0ksSzD7oqVaLKwEqy693xiRPjhK7VX1/BDgRIFuo22rBVfgc3WipWWcVEod8RmYE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y3XMhGO6; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdQzrQDB775LluEYIe7nhmjUoE/LuYa00yNA2dYNPnUHBEzwc78FcLhgLhHOu5faBgrOss4gb1jUqOjaIG+eeaU9WtVJgyotYpPJtN0GIE03aIe9VvufDhccG6GoOSB3PXUCzaWRqQEocycQC/pO61jEKNLQp45apNxr86H0+eNC/tMJFAzgT3aT5Qlb/JlabSewxGwZdA8H4bB0IpGEVx0p/gbZMv8IaGlEhqGfRwWFtTXNPaahbxQ6ohHoOuo6tBeO+IRbjvilryK3nr/X60040AMBVy0xdhfv+iIEwhspiDbxP44RedMm4gFNqsGtVTEFa3P/6P4PmWiEBZV6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqz3R0tPPOWZl/n+Avi0lgJyF400COPcQrtB82HLOys=;
 b=WCrriaemMVsmdeGriuWq+ekECPjHkcBhvEViCsuYrl2DO+3gFeFCT9GL4F4jWn5u4I+gFPaHzq/LUl5eNKcP7YAyZ2z43C0FIgm6ovLzlWtWW/FgRzb8vzDCflPAKVVu2MkkhO4q2COLNi4WE0oY67BGM+d+raQeeGKVFwwUkIpsgdrvIJWNYJnb79eBNrTZqSgNlk1YafxoaS+whdiLgr3dWDmLKktmsFT8ysrGRVJF3zWYCESZnKegIYz2Ka8GVmc8xejSXQTjoQIvuwiWrmtp9JQfEIygI3V/ui4/Ux1NmRLjeNQO2GSW4OcakTomdb4sPc3I5svOJPjTvPrMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqz3R0tPPOWZl/n+Avi0lgJyF400COPcQrtB82HLOys=;
 b=Y3XMhGO64cSG5hT9E44cUwLvbiF1x+beRn7EmjLThYuVPytOGXqZJWEtvSZn3D9nTkTdy6nmBJ5xvB53QRj6TWtgcggAHknGipsCObfs8oIuN+EWM3OqeqTc3X4ZnBylLZ52vgkbUtc/fHmzQICpEhYeUE9wzEyZjih59TBzoJV4T3+Z2NOXSKHIN5vEtwwyaXVZy00nXOqHNxjWUsxDExGaZ3MfY/hYFKgKbfjFl7gZWfAt5rOsVkVqoBbm1TMB0XAFXVjwR88kNj33IhCmj0rtUut8VvqEGXuoQfGUjdnpTQnz58+vU12MeoxhwS3JJ7JynI6FHZ7Y9nwXHMLCOQ==
Received: from PH7PR10CA0020.namprd10.prod.outlook.com (2603:10b6:510:23d::18)
 by MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 17:53:08 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::f0) by PH7PR10CA0020.outlook.office365.com
 (2603:10b6:510:23d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:53:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 10:52:51 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 10:52:45 -0700
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
Subject: [PATCH net-next v7 5/9] ethtool: Veto some operations during firmware flashing process
Date: Mon, 24 Jun 2024 20:51:55 +0300
Message-ID: <20240624175201.130522-6-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624175201.130522-1-danieller@nvidia.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aba903e-d23f-4fac-0f23-08dc9476819a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CYMggIt1iMUpIq957v7tKXH2tjtiu3bnrK79s/et3xLNm/jX2ovnOCrEH0Eu?=
 =?us-ascii?Q?Zhl0EOxF7BVifBGnmsIQ5C+5rZlzV7WMd9tUyfkFI35p1oskRhZOsrEabZub?=
 =?us-ascii?Q?DeiqTGwhMWLaWY9FhDYc8ZIoMVd0dSMPLmTjGHqcfrWBoo2egsVzB51W8aQK?=
 =?us-ascii?Q?QGYlQHgk9gmfbQKrBdKsFETgP6GgHA47omYIEpyDn2sBCvCgukecRyHx7x/7?=
 =?us-ascii?Q?3MFH/iT6jJGnY/V2BS7j6OM2iAdEaqw2BIM6AdmrY2HrWgmZUVb/QUYMKnLM?=
 =?us-ascii?Q?FS4rdIib3QKUrzpFhQTctt0BdtDOHCKHmtg+DG5fmAyh7R9Vrz2KYy99bu5r?=
 =?us-ascii?Q?BuHoshx8b7wmGPrCWrrBsTCtDFVdmZhOKYfRdYO5hb6rTbB/UUA04g+jU6gB?=
 =?us-ascii?Q?0uP+1mc/hlvT/NVY6Ffxob53BOJhmcLsK2hexa+G+8go/KNmMLmcKHB+q7KC?=
 =?us-ascii?Q?LJKTeRElsGWAJjO/TtOect4sMqSIx1EkI/HBnOJcHU7Z+JGwlQQqQZOCnbEd?=
 =?us-ascii?Q?H/WXfdBYXqwMi/vItE+Gxkks0gsp2M64yXlFe7WMH7HFaY1An8/jyLk8V9PL?=
 =?us-ascii?Q?lm+KXKF6AH41+c4QpUIuzAnQB26PFNOAOzHBPqG950YeU7GDl13Sj7M9jDr7?=
 =?us-ascii?Q?/UGaeYVbfjd2BnJPNJRFmRL1WNRL2hxC2l4N+X/q7cFQUf+eV6Ad4ruGOcRN?=
 =?us-ascii?Q?ZpS52qKshzxn6QKbsPqIh/3RlTGkevkp9hbA48y0dXZXpheMNqwyfJQ3dvhU?=
 =?us-ascii?Q?wk7JudfhUgiMDgrRqP07EfqWx6iMI0n5nmnzWG/N8urG+CYtm3zxeJOo69LY?=
 =?us-ascii?Q?sRN4cnptpmT0P7xjXaeYgS6p8OSHIfx9cERlD9Nn/wr6RfMJw4FbeLgNGkv/?=
 =?us-ascii?Q?IKcDy6G9Wr5X2A8l8RPMk6sKO91RxWiOF+1UgsfvjiyUHaW4OGcd0W98tG0x?=
 =?us-ascii?Q?SiLF3E1+tPvnJkTbpjjFdlSB4DiX6Ozgp3oFje9gQKE5wr8mXE82svc4mytw?=
 =?us-ascii?Q?iZG1c4nu5pNAly6DNFIgJuqJ4R6HTpjRbHGHo9634VLHJpzY3gfDBn3AjqPw?=
 =?us-ascii?Q?kyeo09mJqcom6nLWgaOrC8ITLi2Vm2GKEf+AyIY8AKJcl8uMSBak71fMtwl4?=
 =?us-ascii?Q?2DmHwN89mMG5IZWka0EUfd4ZHFokvBbkCWcKrcyfWeY3YzPYLYobr3wHUv6I?=
 =?us-ascii?Q?KahzJ/hnWHXk0MRSruZ5lYeq0KdYjzyv2lzaBIrH5G1axSZrmQ89+mtIbHED?=
 =?us-ascii?Q?Z5fgBxmhO09xSTGyR+qUsKrJfNbA9Y9/1hL8LczEgrjGPQ44sDL3nrgO2ZTf?=
 =?us-ascii?Q?V8XECTKTpWgVs7hfZmoBpooFl5WmcH1IcQolngJUaxvZT78OOQjdw8poqJTe?=
 =?us-ascii?Q?eLc7xP59VXlA4iBVCX4/esc1BsizCmKgVQkW+Yi1nseAVoNYfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:53:07.9770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aba903e-d23f-4fac-0f23-08dc9476819a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487

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


