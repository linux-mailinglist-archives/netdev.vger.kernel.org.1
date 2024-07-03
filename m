Return-Path: <netdev+bounces-108846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0FE926014
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7F71F23A21
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AFC16EC15;
	Wed,  3 Jul 2024 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YOWXYXCn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6508685298
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 12:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720009183; cv=fail; b=AucPjs1qgC1vORXhj3tIJuPWRQMGXLcvzrqWYOmnkVW82mRGB2FITaqc0lSTyrBo2p8y2/7craIEOACMSpdeSpKq3AstuCjYMyhqafRC3xHcxqjqjkgyAHDKtJvyU5RB4sK/uhUPtEoBSkDj17s424HT9V1Z8LYoE4WrHAaPixE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720009183; c=relaxed/simple;
	bh=JvEPwHPSfsY45Tbk2xUMcPuAerEr6K5dsHf8lCSX3qo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n//E/HHifVtY44gDO6Pixs753uc0/SPYwgEiAHkjkd/J5NXkQrSsxhrKocavLHME/EaHBHjZeEiOkCXdreMC0D577s2Dzs7RSgMeIHKnR3g/Y0zmiu38ujvy+oKjPHn8pmt2K3DvqRnE31eVmDNNVsAZ9nRFJAK9cFEnWnuHygs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YOWXYXCn; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=larIYfP14ibEhQUCAOmJ2DHHohCAvK4xIMpMIPSMOlwoGh0gZBqCR+zadDjWk73aWe3OoPQET/0jfTLbH9H1j4oJcOmEdDSYDJsGBnHGHGV7shKgVlvBNud1QW/d9CPUjgXgstHHH9s5CGOVMqmcdGT6VogS8ie3Ty1aod6neW8n8wHfaX6Y5NqBZW3q8b/ED4OatYjWdBadDLr9K/7KazxTaHSnR0TzsDRhXl+S0jITKEoFSoSk2+ltrtkNPeeXSPimNB4R2GWVbGwDNvcJ5PgQgCH/ona1/8uUXUPiKK+9AeMKn0w9SJHzE+H+QSyUNY/0NGjoIvdMMh+mKGhXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9KblA1CuFIepfVecvX2xLT+S2eedsHlwMARrgjKECA=;
 b=PzAD0BAk5nNKHYZ7IyWCqVbOtgr7Ipr4WfvbJqo8T1cnfOWI4lsk+64FD7oIeev3aqaW7cSpy35JrsyyI9OXfimBu41WqGHPVmjbB8snU+LuETnNM1ZTIRIDoaJW7gjDpIPEzNcZ6iC7sKG9JuTnqCRsLzjQmw097TAg0bzsAB4HrIJG9TO6HatOs6YW8n6wonQ0l6YTh7m8uZ03lgvd3GtN3oZK/KkTp+RpBvCMFc0GfNqJ1dHi2cjsXUxxOo4y1mtx9Y3Mjw6VEoaEV2m47X0XhBaaKVdWwFVps/2qvXCfcB1VVRgQ8hXdzo9ZEqjxN7nkdvYSEf/J40krj6cJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9KblA1CuFIepfVecvX2xLT+S2eedsHlwMARrgjKECA=;
 b=YOWXYXCnJFBcmYuDfVPu95EhEHeIwCLo4UgiveJsj77pn8o/DnQyBtFSvlEvPlGTstwTghsQta62qeSvnG3Z+0JfyI/1J8Ha2+19cLdTXG+/evCluQVTgDHnBxNxzXMNQr+0XwRdxQSleCHPhcPTXcQSJUh0xR+yzDaXM8hobm0=
Received: from CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::11)
 by DM4PR12MB6012.namprd12.prod.outlook.com (2603:10b6:8:6c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.23; Wed, 3 Jul 2024 12:19:38 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::7) by CH0P220CA0021.outlook.office365.com
 (2603:10b6:610:ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Wed, 3 Jul 2024 12:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Wed, 3 Jul 2024 12:19:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 07:19:36 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 3 Jul 2024 07:19:35 -0500
From: <edward.cree@amd.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<danieller@nvidia.com>, <andrew@lunn.ch>
Subject: [PATCH net-next] ethtool: move firmware flashing flag to struct ethtool_netdev_state
Date: Wed, 3 Jul 2024 13:18:49 +0100
Message-ID: <20240703121849.652893-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|DM4PR12MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: cb3f3cca-be84-4f67-dd8c-08dc9b5a6845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XVCfgxD4ajMYPhshhPsLo/5rxZUj+v/7CfbXaaTDnNNOjisVq8471TwnMo3P?=
 =?us-ascii?Q?u46qkkdEBzBneWnrklzAVPIT5N5z+HZ75Ew/4DGDb/JtnkFrg8o8IaYqtykp?=
 =?us-ascii?Q?EWRKg0YbpECHuMcnFhZybCzna6Vq0qVdZulglcEL+aCeV60RFDuT9vbnpB3j?=
 =?us-ascii?Q?U48kHFgDKBpYeUKMeBnzoYAgu7KmrgCM76DgDPh3GwbZtvWQcT3GXy0ILh0j?=
 =?us-ascii?Q?Et2gV9EeKExyZUYK1TT2cObuKLFoIFtSgCfIQn5Jh8NNBpNcuKDAKAIQXiFn?=
 =?us-ascii?Q?LA81Ze1PgUqpxuw9MjSuxnbd2M5cI4Tz9EdKobhXD2mqWmFbIDqxBgenzTNE?=
 =?us-ascii?Q?Xk8SRCZU3mxHzhfHhhJd+EK1oK3wZ3Wv8oQCUiYQ1V5+Sl35Vh6f1BLrEGjL?=
 =?us-ascii?Q?HjL8ITyON06EUZbBCGMe9kITo/2NTls82qz/4wneIqif/FUoleZm781VUifq?=
 =?us-ascii?Q?A8no37DfU4Vy3ESgo8rEa/W29dB/Q34zYrLAdTiA3sAXMQ0pdYbQYbuVx57/?=
 =?us-ascii?Q?S+Jlkkte+hsKLna2TEck3lMToaNzvxnQmjwHZXnm4kdr/L4Jc1z2s8rY5SFv?=
 =?us-ascii?Q?W6q6RYaBmVe4ZI85NjzaPaoedV+q4BMZPyCwYuXiBkc0yA0KH9HiCw/igS1a?=
 =?us-ascii?Q?n8afTU5qA/WbcjPl7qqolW6YNN1wMK7I8XXIQk6w745L9her2YjvztdPCRkZ?=
 =?us-ascii?Q?jgasZoqc4OfFubaGVJJWXVexDk5KD1mV6dfAeq5bej9feumBIa3BpokRhDuU?=
 =?us-ascii?Q?U+uMUu7XteUGnJklFMqD4r15zqtI3E9c6Rho3iAU2U9OwMttootj0awSphBW?=
 =?us-ascii?Q?lFiroxwUNtcrx83EJocU4vcPmqvg5y0BYCfVMJRczGfK8CbW1MGKKWgNMYC1?=
 =?us-ascii?Q?0q/klRFOqem5u1th4I+8iFup+xNmtb1JGv/+RIfQ7vKW8knbk/3dwkxPeA+n?=
 =?us-ascii?Q?Ik4Qerrvv9UKLYzT9O9G8DxwFteeL3YXRNkZBP2iXOa1XeJ00OlgI/Md+y2l?=
 =?us-ascii?Q?RlTWo6khuO5QlnTOyGTujjOBCOVYkaRTyyREpL7N9qITbFiZO/u1qzBSBb0Y?=
 =?us-ascii?Q?vr2Xl2MYCPpJLvly28f8o6bM0AQJpCgvRXlxwyCnbXd63vdcymd3Cc6nZmk/?=
 =?us-ascii?Q?FHRpme+piYqjuXse9RgM1KEQTI5o2pU3url32geS+6xT/+gLWJPM0oYuBzst?=
 =?us-ascii?Q?ECDpsNKBHlkGmNGy6QEWd85ElGj5/7mnd5peZ5nAi4jo/1Kz1hkW9NdJAeZt?=
 =?us-ascii?Q?lkngoNeOwYnaGzRwdnp+dmrnoubrrG4zz5N3g/gRP2cdn55pLwhUkofUrA9r?=
 =?us-ascii?Q?1jtKmENnFhCuAUl0oWJ5XWu7thrb6oiZZcAxZtffBSo2j6aVN7WzRWVXqaLm?=
 =?us-ascii?Q?eZag6Vd2KCvOcTj6eDytYnHXWQbK4pubUNa71D29wJVPdSsvDepVj/D9bE79?=
 =?us-ascii?Q?TeLkbzxEGqoTZcNxW7+iWi8ZObFlsJ4J?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 12:19:37.7445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3f3cca-be84-4f67-dd8c-08dc9b5a6845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6012

From: Edward Cree <ecree.xilinx@gmail.com>

Commit 31e0aa99dc02 ("ethtool: Veto some operations during firmware flashing process")
 added a flag module_fw_flash_in_progress to struct net_device.  As
 this is ethtool related state, move it to the recently created
 struct ethtool_netdev_state, accessed via the 'ethtool' member of
 struct net_device.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
Build tested only.

 include/linux/ethtool.h   |  2 ++
 include/linux/netdevice.h |  3 ---
 net/ethtool/eeprom.c      |  2 +-
 net/ethtool/ioctl.c       |  8 ++++----
 net/ethtool/module.c      | 10 +++++-----
 net/ethtool/netlink.c     |  2 +-
 6 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index f74bb0cf8ed1..3a99238ef895 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -1107,11 +1107,13 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
  * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
  *			within RTNL.
  * @wol_enabled:	Wake-on-LAN is enabled
+ * @module_fw_flash_in_progress: Module firmware flashing is in progress.
  */
 struct ethtool_netdev_state {
 	struct xarray		rss_ctx;
 	struct mutex		rss_lock;
 	unsigned		wol_enabled:1;
+	unsigned		module_fw_flash_in_progress:1;
 };
 
 struct phy_device;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 3c719f0d5f5a..93558645c6d0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1989,8 +1989,6 @@ enum netdev_reg_state {
  *
  *	@threaded:	napi threaded mode is enabled
  *
- *	@module_fw_flash_in_progress:	Module firmware flashing is in progress.
- *
  *	@net_notifier_list:	List of per-net netdev notifier block
  *				that follow this device when it is moved
  *				to another network namespace.
@@ -2376,7 +2374,6 @@ struct net_device {
 	bool			proto_down;
 	bool			threaded;
 
-	unsigned		module_fw_flash_in_progress:1;
 	struct list_head	net_notifier_list;
 
 #if IS_ENABLED(CONFIG_MACSEC)
diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index f36811b3ecf1..3b8209e930fd 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -91,7 +91,7 @@ static int get_module_eeprom_by_page(struct net_device *dev,
 {
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 
-	if (dev->module_fw_flash_in_progress) {
+	if (dev->ethtool->module_fw_flash_in_progress) {
 		NL_SET_ERR_MSG(extack,
 			       "Module firmware flashing is in progress");
 		return -EBUSY;
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index d8795ed07ba3..ee4ecedd92fc 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -658,7 +658,7 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
-	if (dev->module_fw_flash_in_progress)
+	if (dev->ethtool->module_fw_flash_in_progress)
 		return -EBUSY;
 
 	memset(&link_ksettings, 0, sizeof(link_ksettings));
@@ -1572,7 +1572,7 @@ static int ethtool_reset(struct net_device *dev, char __user *useraddr)
 	if (!dev->ethtool_ops->reset)
 		return -EOPNOTSUPP;
 
-	if (dev->module_fw_flash_in_progress)
+	if (dev->ethtool->module_fw_flash_in_progress)
 		return -EBUSY;
 
 	if (copy_from_user(&reset, useraddr, sizeof(reset)))
@@ -2588,7 +2588,7 @@ int ethtool_get_module_info_call(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
 
-	if (dev->module_fw_flash_in_progress)
+	if (dev->ethtool->module_fw_flash_in_progress)
 		return -EBUSY;
 
 	if (dev->sfp_bus)
@@ -2628,7 +2628,7 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 	const struct ethtool_ops *ops = dev->ethtool_ops;
 	struct phy_device *phydev = dev->phydev;
 
-	if (dev->module_fw_flash_in_progress)
+	if (dev->ethtool->module_fw_flash_in_progress)
 		return -EBUSY;
 
 	if (dev->sfp_bus)
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 6b7448df08d5..aba78436d350 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -37,7 +37,7 @@ static int module_get_power_mode(struct net_device *dev,
 	if (!ops->get_module_power_mode)
 		return 0;
 
-	if (dev->module_fw_flash_in_progress) {
+	if (dev->ethtool->module_fw_flash_in_progress) {
 		NL_SET_ERR_MSG(extack,
 			       "Module firmware flashing is in progress");
 		return -EBUSY;
@@ -119,7 +119,7 @@ ethnl_set_module_validate(struct ethnl_req_info *req_info,
 	if (!tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY])
 		return 0;
 
-	if (req_info->dev->module_fw_flash_in_progress) {
+	if (req_info->dev->ethtool->module_fw_flash_in_progress) {
 		NL_SET_ERR_MSG(info->extack,
 			       "Module firmware flashing is in progress");
 		return -EBUSY;
@@ -226,7 +226,7 @@ static void module_flash_fw_work(struct work_struct *work)
 	ethtool_cmis_fw_update(&module_fw->fw_update);
 
 	module_flash_fw_work_list_del(&module_fw->list);
-	module_fw->fw_update.dev->module_fw_flash_in_progress = false;
+	module_fw->fw_update.dev->ethtool->module_fw_flash_in_progress = false;
 	netdev_put(module_fw->fw_update.dev, &module_fw->dev_tracker);
 	release_firmware(module_fw->fw_update.fw);
 	kfree(module_fw);
@@ -318,7 +318,7 @@ module_flash_fw_schedule(struct net_device *dev, const char *file_name,
 	if (err < 0)
 		goto err_release_firmware;
 
-	dev->module_fw_flash_in_progress = true;
+	dev->ethtool->module_fw_flash_in_progress = true;
 	netdev_hold(dev, &module_fw->dev_tracker, GFP_KERNEL);
 	fw_update->dev = dev;
 	fw_update->ntf_params.portid = info->snd_portid;
@@ -385,7 +385,7 @@ static int ethnl_module_fw_flash_validate(struct net_device *dev,
 		return -EOPNOTSUPP;
 	}
 
-	if (dev->module_fw_flash_in_progress) {
+	if (dev->ethtool->module_fw_flash_in_progress) {
 		NL_SET_ERR_MSG(extack, "Module firmware flashing already in progress");
 		return -EBUSY;
 	}
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 81fe2e5b95f6..cb1eea00e349 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -807,7 +807,7 @@ static int ethnl_netdev_event(struct notifier_block *this, unsigned long event,
 		ethnl_notify_features(ptr);
 		break;
 	case NETDEV_PRE_UP:
-		if (dev->module_fw_flash_in_progress) {
+		if (dev->ethtool->module_fw_flash_in_progress) {
 			NL_SET_ERR_MSG(extack, "Can't set port up while flashing module firmware");
 			return NOTIFY_BAD;
 		}

