Return-Path: <netdev+bounces-104857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D4F90EAE2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB7C1C2112B
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F5152799;
	Wed, 19 Jun 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pZzPJHCV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F14152792;
	Wed, 19 Jun 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799548; cv=fail; b=LuCtnLx/0xOqSJS4UAaTwT9DCqdH58oC9q9gui3igrbOxni2I+wW4XRLELulyNidFRFqB5FfkGCcmZ7hh4Ew1Rw2q8zuIrIp6rZ+G3fsQHbW/Syjq7/Cd6fXxAkeQw6Z3j7ySiOSm1/2ucNtrSLVijrsIE2TmXasWyPFU8QZaAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799548; c=relaxed/simple;
	bh=uoXpX6tRkz6V1Wn2AJoaLhCvHbSgnM2LWXXfd+Jj6Ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chrrsoH4YgzbztV5TsSoj6aUGJto1OyOTfmmOFBzC2WQhiGrp6MIp5BJ2mE5iZvvlQDxO4k/fRBN8OTTTCfgLPgOhFNW1ag4qp5zsfQmSSY02Ibvt0v5Sai+9W++ibq+T/+wMiYx5FvQVxsWvJhb5RBmE1rwkOZfyQbZhE0QGCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pZzPJHCV; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKE6gXz6wlLJHpoX3o9itAEqc1KAtuuI8UeCBaIDUux+cVdA3W4kkC0AsEFbPJpDgQMRyTHo37kfAvv28ehKv2Ig7FJtbmZEin2V9P+ZbEyV3vzsLYMbzkOdiEbwhNIq4Ah/YfQO8NpL2CM4vZdIrCYHRAZUeUQY2NDU3V4CMVfzVVmYWvWeK+Xy/Yrojj9fyRmCDa/Fzrs45bviiYvUO4J0uX14MWT8PCrDKcQ3DYAy2OvV7OBoTgMxCpy8OmRoKOi9KLAdV7JOTLR1q6M5wty20dYh3oHAZi66wv7UYIF0dcCoz9HZlhOmfWul0hdgsVzsuLaIHZsrTSIIgaYdLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkjEu4Z8QFvXfS4DKt+D6mUYKtVVG+CCr21CCkHvvhk=;
 b=Tqk0anyTvUerdwYDVuEZabGJS8lkBWrAzwBCwpv68pzs4uroZQAdt7/yRO7C2SHG8CX6D/WzlQAiNiRnHXSu7WrHa+kR9LqBZTvs0UmhXosL4Y/hwnCmWJDb505TSlME+A+FADRKnW+a/buLWBVVcZMPDc3kvWQRWidsBj8UBPAX6durnwEyazEm/TEUOscDKEP+f/QZvd9qGwQ1hIRPH5Q6aNNB2ScnH3xxaUNleazoCIu+I9BcIHLYi7Q2CKNtH4+xU3DJToo81SDktcEa7oTWkazG/gJIG0zzKnuKdOifA3Xe87qv5c/ghVKyhX7bKIKyGdjz6SZgaplKGQkBmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkjEu4Z8QFvXfS4DKt+D6mUYKtVVG+CCr21CCkHvvhk=;
 b=pZzPJHCVLXBXUkEISqAW0FGyN99llpj4Vi8PN69ffgbwC9kFsIiapFA5nP5t8WvNS6/bYKLIRXvyGfspjhjmAEnNxP15u4zPSkTX0lZm13KDhNowGhY7c8AIDqwc10/AIjPywuz81A6peWON8svj+BNa1/8ktpv3CRl2dDQeZeGAOKmivmpj0d/iFE45oY4gePA2rM1dHplQfGANLi/pGW8dNU5nKpKLYsR1VBBlqDO55FEL+4xco5T8khwxh/rNZAd5CDZ5+Y0LhwDf/SkK5uz5+d4i8R9cNxAsBALw6p+klaiCDKNqKosJ8YERb7ffqvkNx3g2Fl39A6qRqvVeoQ==
Received: from BN0PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:ea::9)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 12:18:57 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:ea:cafe::27) by BN0PR04CA0064.outlook.office365.com
 (2603:10b6:408:ea::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 12:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 12:18:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 05:18:41 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 05:18:35 -0700
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
Subject: [PATCH net-next v6 9/9] ethtool: Add ability to flash transceiver modules' firmware
Date: Wed, 19 Jun 2024 15:17:27 +0300
Message-ID: <20240619121727.3643161-10-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 235fe76d-01a3-4a21-ef64-08dc9059fe8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qNLeY+9MRKnRaXHTBPeDfSHQ7GB+50zYYkQeuBh8PaJGyhknFPLwVWd3tRl5?=
 =?us-ascii?Q?6b+qzEk/AO+BF04EG349RZb7hZf5f1la8WNq4TGmBm8mJGY1joZ6aQy0g6j6?=
 =?us-ascii?Q?dxkYiUEab98gOBidpDt9IEnXR1usg8FyzuHDGQ41WesXwH0GykZugPy/JX0o?=
 =?us-ascii?Q?9uOGKUBhwrOTEDmew6mMhOZlkPFKIXCtRHmn6e9do/pfKXX9HAX54PTI1zKd?=
 =?us-ascii?Q?yFC4wTcrs2o9Bx8YGBoPutBnf5KP81s3SzJrxQ6PDJ08occGZjPPQwAZS1a3?=
 =?us-ascii?Q?Cr5i60B6bZuaGXoFRE0XaQ8E+1RPpW8B8692zoyT0fIl51NxVJlVYVJa/1hH?=
 =?us-ascii?Q?R09wg8matMqxdIUGmnGxU0NBlJWl9yZGS5tY2JidvpxTs9IpzPrGdJOToZ2s?=
 =?us-ascii?Q?9j1tshgPybr0Rfy3wWqVIBFd8amGKL2iIehRfjbDWHR3IJNYoWp9LvzhpvHC?=
 =?us-ascii?Q?MHMsrXgniPDIcq/sl8ryUj3Z1Z4szv4wsvDPAMuQBPCRhW5j3gDM6sLJp8Hw?=
 =?us-ascii?Q?6HH9V4EuK7HcASDeCo1joctqSJ/Ncj6saaaPOmVmwio0RKi7MyG2xKyACOze?=
 =?us-ascii?Q?LCi3tnpCInlcOU+yRe+oL8WAB4qok4cyeTXyL3yfeSZ1nHEiCBeCndGlxWNr?=
 =?us-ascii?Q?pgFyfxk1mOWPvKiNcdAfpVlddrHjRFH4BSwTRbSF1HzErxWhXHGXf/fealw3?=
 =?us-ascii?Q?nmBXV+6frfGX7dfby3U7rm7uxjk25BC+uCpk89UeDdfWfhxlOsFLODrXME5v?=
 =?us-ascii?Q?EogCSvONBnZVZWJMTQQqXCeER2dMiqxwk0FiK/7QxkjOvvx29AX4GiH7VoKa?=
 =?us-ascii?Q?cY7QHt8B3v72yuKsq52/ekAN7asr135fr0FBx3wucKjKhgHtbYywDEuKWLbh?=
 =?us-ascii?Q?BRX44i+oi9+rGbiDTS1NA92wwVgaCC4upZ6K8vRGTQYQpGr6M8CIwGyjJr1u?=
 =?us-ascii?Q?0RjL6HDM6lk/h0fcIajGGU9anzc2wLl9mgbkABIaf902osht2fw88IEFHmOR?=
 =?us-ascii?Q?k9wD8nfrEB/e5giFoGq+3MnkIrPdVjATEfQD0fmDb+PeRp7uUlMLpICZ1exD?=
 =?us-ascii?Q?8QktmgwsalY1/eAXF4sccHhqHrpw6hbVoqYYl2Hfa17cZA/UVC5/uXgolwxP?=
 =?us-ascii?Q?k29b2pfXkQOoaP/a5HLjj1uMn2ql6RmVzNIbo5seodtJ1JhDvh29fvU4hGuB?=
 =?us-ascii?Q?Rx4H+u1pGB/X5NqUwpXKLxie4hn+d3WL+RAWgegHSFYE4PJgDTYuUAz/Dp7T?=
 =?us-ascii?Q?n5W3OJ+tAwK+n+W/939+TtMpE7AlT2FeGiDTje0kP+wKq0aO4bh0mkS8K4Kw?=
 =?us-ascii?Q?6NRdY8IzjXyicZYIoEdAAq+og7+Sry9/tFr+Y+P1NV44oSapG7Lkv85l+S+c?=
 =?us-ascii?Q?z9yKmcDemAAhpFUtmTNOn48q73DnCn/VywA7pXvyBmREUuUnlQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:18:57.4899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 235fe76d-01a3-4a21-ef64-08dc9059fe8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434

Add the ability to flash the modules' firmware by implementing the
interface between the user space and the kernel.

Example from a succeeding implementation:

 # ethtool --flash-module-firmware swp40 file test.bin

 Transceiver module firmware flashing started for device swp40
 Transceiver module firmware flashing in progress for device swp40
 Progress: 99%
 Transceiver module firmware flashing completed for device swp40

In addition, add infrastructure that allows modules to set socket-specific
private data. This ensures that when a socket is closed from user space
during the flashing process, the right socket halts sending notifications
to user space until the work item is completed.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v6:
    	* Add a paragraph in the commit message.
    	* Rename labels in module_flash_fw_schedule().
    	* Add info to genl_sk_priv_*() and implement the relevant
    	  callbacks, in order to handle properly a scenario of closing the
    	  socket from user space before the work item was ended.
    	* Add a list the holds all the ethtool_module_fw_flash struct
    	  that corresponds to the in progress work items.
    	* Add a new enum for the socket types.
    	* Use both above to identify a flashing socket, add it to the
    	  list and when closing socket affect only the flashing type.
    	* Create a new function that will get the work item instead of
    	  ethtool_cmis_fw_update().
    	* Edit the relevant functions to get the relevant params for them.
    	* The new function will call the old ethtool_cmis_fw_update(), and do
    	  the cleaning, so the existence of the list should be completely
    	  isolated in module.c.

 net/ethtool/module.c    | 275 ++++++++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h |   3 +
 net/ethtool/netlink.c   |  38 ++++++
 net/ethtool/netlink.h   |  15 +++
 4 files changed, 331 insertions(+)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 932415bd44c6..7e4ea0596508 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/ethtool.h>
+#include <linux/firmware.h>
+#include <linux/sfp.h>
+#include <net/devlink.h>
 
 #include "netlink.h"
 #include "common.h"
@@ -34,6 +37,12 @@ static int module_get_power_mode(struct net_device *dev,
 	if (!ops->get_module_power_mode)
 		return 0;
 
+	if (dev->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(extack,
+			       "Module firmware flashing is in progress");
+		return -EBUSY;
+	}
+
 	return ops->get_module_power_mode(dev, &data->power, extack);
 }
 
@@ -110,6 +119,12 @@ ethnl_set_module_validate(struct ethnl_req_info *req_info,
 	if (!tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY])
 		return 0;
 
+	if (req_info->dev->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Module firmware flashing is in progress");
+		return -EBUSY;
+	}
+
 	if (!ops->get_module_power_mode || !ops->set_module_power_mode) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY],
@@ -160,6 +175,266 @@ const struct ethnl_request_ops ethnl_module_request_ops = {
 	.set_ntf_cmd		= ETHTOOL_MSG_MODULE_NTF,
 };
 
+/* MODULE_FW_FLASH_ACT */
+
+const struct nla_policy
+ethnl_module_fw_flash_act_policy[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD + 1] = {
+	[ETHTOOL_A_MODULE_FW_FLASH_HEADER] =
+		NLA_POLICY_NESTED(ethnl_header_policy),
+	[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME] = { .type = NLA_NUL_STRING },
+	[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD] = { .type = NLA_U32 },
+};
+
+static LIST_HEAD(module_fw_flash_work_list);
+static DEFINE_SPINLOCK(module_fw_flash_work_list_lock);
+
+static int
+module_flash_fw_work_list_add(struct ethtool_module_fw_flash *module_fw,
+			      struct genl_info *info)
+{
+	struct ethtool_module_fw_flash *work;
+
+	/* First, check if already registered. */
+	spin_lock(&module_fw_flash_work_list_lock);
+	list_for_each_entry(work, &module_fw_flash_work_list, list) {
+		if (work->fw_update.ntf_params.portid == info->snd_portid &&
+		    work->fw_update.dev == module_fw->fw_update.dev)
+			return -EALREADY;
+	}
+
+	list_add_tail(&module_fw->list, &module_fw_flash_work_list);
+	spin_unlock(&module_fw_flash_work_list_lock);
+
+	return 0;
+}
+
+static void module_flash_fw_work_list_del(struct list_head *list)
+{
+	spin_lock(&module_fw_flash_work_list_lock);
+	list_del(list);
+	spin_unlock(&module_fw_flash_work_list_lock);
+}
+
+static void module_flash_fw_work(struct work_struct *work)
+{
+	struct ethtool_module_fw_flash *module_fw;
+
+	module_fw = container_of(work, struct ethtool_module_fw_flash, work);
+
+	ethtool_cmis_fw_update(&module_fw->fw_update);
+
+	module_flash_fw_work_list_del(&module_fw->list);
+	module_fw->fw_update.dev->module_fw_flash_in_progress = false;
+	netdev_put(module_fw->fw_update.dev, &module_fw->dev_tracker);
+	release_firmware(module_fw->fw_update.fw);
+	kfree(module_fw);
+}
+
+#define MODULE_EEPROM_PHYS_ID_PAGE	0
+#define MODULE_EEPROM_PHYS_ID_I2C_ADDR	0x50
+
+static int module_flash_fw_work_init(struct ethtool_module_fw_flash *module_fw,
+				     struct net_device *dev,
+				     struct netlink_ext_ack *extack)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_module_eeprom page_data = {};
+	u8 phys_id;
+	int err;
+
+	/* Fetch the SFF-8024 Identifier Value. For all supported standards, it
+	 * is located at I2C address 0x50, byte 0. See section 4.1 in SFF-8024,
+	 * revision 4.9.
+	 */
+	page_data.page = MODULE_EEPROM_PHYS_ID_PAGE;
+	page_data.offset = SFP_PHYS_ID;
+	page_data.length = sizeof(phys_id);
+	page_data.i2c_address = MODULE_EEPROM_PHYS_ID_I2C_ADDR;
+	page_data.data = &phys_id;
+
+	err = ops->get_module_eeprom_by_page(dev, &page_data, extack);
+	if (err < 0)
+		return err;
+
+	switch (phys_id) {
+	case SFF8024_ID_QSFP_DD:
+	case SFF8024_ID_OSFP:
+	case SFF8024_ID_DSFP:
+	case SFF8024_ID_QSFP_PLUS_CMIS:
+	case SFF8024_ID_SFP_DD_CMIS:
+	case SFF8024_ID_SFP_PLUS_CMIS:
+		INIT_WORK(&module_fw->work, module_flash_fw_work);
+		break;
+	default:
+		NL_SET_ERR_MSG(extack,
+			       "Module type does not support firmware flashing");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+void ethnl_module_fw_flash_sock_destroy(struct ethnl_sock_priv *sk_priv)
+{
+	struct ethtool_module_fw_flash *work;
+
+	spin_lock(&module_fw_flash_work_list_lock);
+	list_for_each_entry(work, &module_fw_flash_work_list, list) {
+		if (work->fw_update.dev == sk_priv->dev &&
+		    work->fw_update.ntf_params.portid == sk_priv->portid) {
+			work->fw_update.ntf_params.closed_sock = true;
+			break;
+		}
+	}
+	spin_unlock(&module_fw_flash_work_list_lock);
+}
+
+static int
+module_flash_fw_schedule(struct net_device *dev, const char *file_name,
+			 struct ethtool_module_fw_flash_params *params,
+			 struct sk_buff *skb, struct genl_info *info)
+{
+	struct ethtool_cmis_fw_update_params *fw_update;
+	struct ethtool_module_fw_flash *module_fw;
+	int err;
+
+	module_fw = kzalloc(sizeof(*module_fw), GFP_KERNEL);
+	if (!module_fw)
+		return -ENOMEM;
+
+	fw_update = &module_fw->fw_update;
+	fw_update->params = *params;
+	err = request_firmware_direct(&fw_update->fw,
+				      file_name, &dev->dev);
+	if (err) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Failed to request module firmware image");
+		goto err_free;
+	}
+
+	err = module_flash_fw_work_init(module_fw, dev, info->extack);
+	if (err < 0)
+		goto err_release_firmware;
+
+	dev->module_fw_flash_in_progress = true;
+	netdev_hold(dev, &module_fw->dev_tracker, GFP_KERNEL);
+	fw_update->dev = dev;
+	fw_update->ntf_params.portid = info->snd_portid;
+	fw_update->ntf_params.seq = info->snd_seq;
+	fw_update->ntf_params.closed_sock = false;
+
+	err = ethnl_sock_priv_set(skb, dev, fw_update->ntf_params.portid,
+				  ETHTOOL_SOCK_TYPE_MODULE_FW_FLASH);
+	if (err < 0)
+		goto err_release_firmware;
+
+	err = module_flash_fw_work_list_add(module_fw, info);
+	if (err < 0)
+		goto err_release_firmware;
+
+	schedule_work(&module_fw->work);
+
+	return 0;
+
+err_release_firmware:
+	release_firmware(fw_update->fw);
+err_free:
+	kfree(module_fw);
+	return err;
+}
+
+static int module_flash_fw(struct net_device *dev, struct nlattr **tb,
+			   struct sk_buff *skb, struct genl_info *info)
+{
+	struct ethtool_module_fw_flash_params params = {};
+	const char *file_name;
+	struct nlattr *attr;
+
+	if (GENL_REQ_ATTR_CHECK(info, ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME))
+		return -EINVAL;
+
+	file_name = nla_data(tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]);
+
+	attr = tb[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD];
+	if (attr) {
+		params.password = cpu_to_be32(nla_get_u32(attr));
+		params.password_valid = true;
+	}
+
+	return module_flash_fw_schedule(dev, file_name, &params, skb, info);
+}
+
+static int ethnl_module_fw_flash_validate(struct net_device *dev,
+					  struct netlink_ext_ack *extack)
+{
+	struct devlink_port *devlink_port = dev->devlink_port;
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+
+	if (!ops->set_module_eeprom_by_page ||
+	    !ops->get_module_eeprom_by_page) {
+		NL_SET_ERR_MSG(extack,
+			       "Flashing module firmware is not supported by this device");
+		return -EOPNOTSUPP;
+	}
+
+	if (!ops->reset) {
+		NL_SET_ERR_MSG(extack,
+			       "Reset module is not supported by this device, so flashing is not permitted");
+		return -EOPNOTSUPP;
+	}
+
+	if (dev->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(extack, "Module firmware flashing already in progress");
+		return -EBUSY;
+	}
+
+	if (dev->flags & IFF_UP) {
+		NL_SET_ERR_MSG(extack, "Netdevice is up, so flashing is not permitted");
+		return -EBUSY;
+	}
+
+	if (devlink_port && devlink_port->attrs.split) {
+		NL_SET_ERR_MSG(extack, "Can't perform firmware flashing on a split port");
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ethnl_req_info req_info = {};
+	struct nlattr **tb = info->attrs;
+	struct net_device *dev;
+	int ret;
+
+	ret = ethnl_parse_header_dev_get(&req_info,
+					 tb[ETHTOOL_A_MODULE_FW_FLASH_HEADER],
+					 genl_info_net(info), info->extack,
+					 true);
+	if (ret < 0)
+		return ret;
+	dev = req_info.dev;
+
+	rtnl_lock();
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		goto out_rtnl;
+
+	ret = ethnl_module_fw_flash_validate(dev, info->extack);
+	if (ret < 0)
+		goto out_rtnl;
+
+	ret = module_flash_fw(dev, tb, skb, info);
+
+	ethnl_ops_complete(dev);
+
+out_rtnl:
+	rtnl_unlock();
+	ethnl_parse_header_dev_put(&req_info);
+	return ret;
+}
+
 /* MODULE_FW_FLASH_NTF */
 
 static int
diff --git a/net/ethtool/module_fw.h b/net/ethtool/module_fw.h
index d0fc2529b60e..634543a12d0c 100644
--- a/net/ethtool/module_fw.h
+++ b/net/ethtool/module_fw.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
 #include <uapi/linux/ethtool.h>
+#include "netlink.h"
 
 /**
  * struct ethnl_module_fw_flash_ntf_params - module firmware flashing
@@ -54,6 +55,8 @@ struct ethtool_module_fw_flash {
 	struct ethtool_cmis_fw_update_params fw_update;
 };
 
+void ethnl_module_fw_flash_sock_destroy(struct ethnl_sock_priv *sk_priv);
+
 void
 ethnl_module_fw_flash_ntf_err(struct net_device *dev,
 			      struct ethnl_module_fw_flash_ntf_params *params,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index a5907bbde427..a5e6f341e4b9 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -4,6 +4,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/pm_runtime.h>
 #include "netlink.h"
+#include "module_fw.h"
 
 static struct genl_family ethtool_genl_family;
 
@@ -30,6 +31,34 @@ const struct nla_policy ethnl_header_policy_stats[] = {
 							  ETHTOOL_FLAGS_STATS),
 };
 
+int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
+			enum ethnl_sock_type type)
+{
+	struct ethnl_sock_priv *sk_priv;
+
+	sk_priv = genl_sk_priv_get(&ethtool_genl_family, NETLINK_CB(skb).sk);
+	if (IS_ERR(sk_priv))
+		return PTR_ERR(sk_priv);
+
+	sk_priv->dev = dev;
+	sk_priv->portid = portid;
+	sk_priv->type = type;
+
+	return 0;
+}
+
+static void ethnl_sock_priv_destroy(void *priv)
+{
+	struct ethnl_sock_priv *sk_priv = priv;
+
+	switch (sk_priv->type) {
+	case ETHTOOL_SOCK_TYPE_MODULE_FW_FLASH:
+		ethnl_module_fw_flash_sock_destroy(sk_priv);
+	default:
+		break;
+	}
+}
+
 int ethnl_ops_begin(struct net_device *dev)
 {
 	int ret;
@@ -1142,6 +1171,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
 		.policy = ethnl_mm_set_policy,
 		.maxattr = ARRAY_SIZE(ethnl_mm_set_policy) - 1,
 	},
+	{
+		.cmd	= ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
+		.flags	= GENL_UNS_ADMIN_PERM,
+		.doit	= ethnl_act_module_fw_flash,
+		.policy	= ethnl_module_fw_flash_act_policy,
+		.maxattr = ARRAY_SIZE(ethnl_module_fw_flash_act_policy) - 1,
+	},
 };
 
 static const struct genl_multicast_group ethtool_nl_mcgrps[] = {
@@ -1158,6 +1194,8 @@ static struct genl_family ethtool_genl_family __ro_after_init = {
 	.resv_start_op	= ETHTOOL_MSG_MODULE_GET + 1,
 	.mcgrps		= ethtool_nl_mcgrps,
 	.n_mcgrps	= ARRAY_SIZE(ethtool_nl_mcgrps),
+	.sock_priv_size		= sizeof(struct ethnl_sock_priv),
+	.sock_priv_destroy	= ethnl_sock_priv_destroy,
 };
 
 /* module setup */
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 5e6c6a7b7adc..46ec273a87c5 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -284,6 +284,19 @@ struct ethnl_reply_data {
 int ethnl_ops_begin(struct net_device *dev);
 void ethnl_ops_complete(struct net_device *dev);
 
+enum ethnl_sock_type {
+	ETHTOOL_SOCK_TYPE_MODULE_FW_FLASH,
+};
+
+struct ethnl_sock_priv {
+	struct net_device *dev;
+	u32 portid;
+	enum ethnl_sock_type type;
+};
+
+int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
+			enum ethnl_sock_type type);
+
 /**
  * struct ethnl_request_ops - unified handling of GET and SET requests
  * @request_cmd:      command id for request (GET)
@@ -442,6 +455,7 @@ extern const struct nla_policy ethnl_plca_set_cfg_policy[ETHTOOL_A_PLCA_MAX + 1]
 extern const struct nla_policy ethnl_plca_get_status_policy[ETHTOOL_A_PLCA_HEADER + 1];
 extern const struct nla_policy ethnl_mm_get_policy[ETHTOOL_A_MM_HEADER + 1];
 extern const struct nla_policy ethnl_mm_set_policy[ETHTOOL_A_MM_MAX + 1];
+extern const struct nla_policy ethnl_module_fw_flash_act_policy[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD + 1];
 
 int ethnl_set_features(struct sk_buff *skb, struct genl_info *info);
 int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info);
@@ -449,6 +463,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_doit(struct sk_buff *skb, struct genl_info *info);
 int ethnl_tunnel_info_start(struct netlink_callback *cb);
 int ethnl_tunnel_info_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info);
 
 extern const char stats_std_names[__ETHTOOL_STATS_CNT][ETH_GSTRING_LEN];
 extern const char stats_eth_phy_names[__ETHTOOL_A_STATS_ETH_PHY_CNT][ETH_GSTRING_LEN];
-- 
2.45.0


