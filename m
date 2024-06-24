Return-Path: <netdev+bounces-106228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC58E9155FA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABE61F210C2
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762E1A01CA;
	Mon, 24 Jun 2024 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="csKX8wpm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAB81A08C3;
	Mon, 24 Jun 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251625; cv=fail; b=R0K7oX5vgzkfRqjDDsALOt541RG9FQuau6XtgAnXsYiEyM+lKTGiUyDC99tXw3eHrmXDvMFFs/vnwNwRKSfhyl4QvoE57WThGfqniJwgOFYqjA/sie3sj3DHPC9YR9xAltZOpUWKrwlRlVbtIlxHJMsyZtFK4AYX1GasGLY9Y0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251625; c=relaxed/simple;
	bh=EbrTRw2QVpnZbECqTUp0JQ5mkBSP5fVoau0WvgbYGfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaGpjOKisyY7rTRMEj3xIPyahG9GMG+ZMpQ0VGBWyj0BY8ocipKfdfOQjZlZYY/9fgjw0gcJ5u8zcL0h7guDzZbGI7soJ/b2J9ixFTj/H6EHkz7wa+h7i7K7+w1iwNy5caTn6m3Y9m1uCSLRGffrvpNCWXsA6J8KEoCSQ36CXIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=csKX8wpm; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHo+aMdYKTt0o8P3cv0qx3fQ5IC6UFsiqo97An4WR3vtvDEY7XATeAZd465NyBmfWjGrOW3qaYuzEm4gsK2MoYR4Ct0Wm6awVJQ2CmlixgyVVW5xFQ8W2SNUIEgLfbcPkSjLu1uCn84uulDVU5bUwqHOzaZLWoyYvtYg0BMM8E8jI7jHhJFqPky66bLkhmyXCVjl+xFwn9lCmxtIx07r5KwXWsEuFdFGzMFYPLCQRnACaZ22K0CqeBeMWoJtmAhrm4y9DhEwAhzpTCthGFQNdDt/f9DjBlQjkY7LhuO1jQUyk4tJLijOpgxsfG4CRO3gMDF58U3wpVvb6plt5HKBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzchNaUmuyi+LzuK7zc08C0wU4TBOPk7rrAs3wfO+8E=;
 b=I6oPuYLO6XK6LehrhQhkF1Y5U5ZUv2MUEdWhv2szRpYl+TR6a/8Cj7ygHmJrxGIdQJB6fiBjkcTQIrc7CUaLv0Y6LBxtN+FfaXJCU7Ugv6FUimxu6f03lrWXt9p+vQ8UZhmx5+C9xzbKCoRZ6h9mAd8Gsldiz59B5CdrbHGzBf38iRshsMT2HUCeEGNjVdwejMmtTAMcMLqcjb2HxtDbG6bAed3pOHu3Tjf8n5q592dhZWEzUIpCNOPNvXJKpslgaigc/2YIBdBy+Cg82tcCPp3oQntwWo+r8AcM1xY807+WfjWTsL7EfBiEoOraenqVyIKfjlMCWZrTpVyFyAWKkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzchNaUmuyi+LzuK7zc08C0wU4TBOPk7rrAs3wfO+8E=;
 b=csKX8wpmEk5/dTUFXwl6ZdjEsrz7kSI1nUfvvm9UCXojLv4D2U9t27M7HGr8bWYsp4SpKQ5t8itpv//lebkvKubOF3+LxMgSA7m0H28sJYUaw1HjGZOr2PpfVP0j1/yjAR7lnvy16l+dX+whFrp/K8X4OQvq2biwKHMh77xX43PMSyyejGKVj6+YF87Xb9PkvXv8pKng9hxyvafU8fgFMy40QZ95GsBr7bD4UMXyQUBdLwaq4vjMsSu5JfJ/Zt8Rlay6LV/u4FOKd64yL4L5e4RhZ9+s1FKfoPbl+YxIVcMeDiWIOAIq3yVL+XcjwSBGkiJK3YMGGF5kRUOINF6fwQ==
Received: from PH7PR10CA0010.namprd10.prod.outlook.com (2603:10b6:510:23d::19)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 17:53:39 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::c1) by PH7PR10CA0010.outlook.office365.com
 (2603:10b6:510:23d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:53:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 10:53:15 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 10:53:09 -0700
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
Subject: [PATCH net-next v7 9/9] ethtool: Add ability to flash transceiver modules' firmware
Date: Mon, 24 Jun 2024 20:51:59 +0300
Message-ID: <20240624175201.130522-10-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 458cabc0-71ab-4985-5340-08dc947693e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tX5luvMqO79JRo9GhHK0C3UPBG3P39CBZzIpn2ItvIqOc7zz8O1XxsI9d2te?=
 =?us-ascii?Q?uk8hCAi1yIKcvVQT5JYREdTnmGNmLmYQlC1JvtZbOKzUyOFPK0HugPXvSo2L?=
 =?us-ascii?Q?NkCxz0n/h/a8py9NnhPOWRA6CRmrTRS/kuU1nPOstYn1NIOSs6Av3e6RTYct?=
 =?us-ascii?Q?nOloyA/wPDyjl7Ly/92LGsvtqWqR9DIzjgtB7+JTqm7uOK7OIV/7p5uVRJio?=
 =?us-ascii?Q?twu2ra5XQvn4U0MDglE3bYISoo5fVEkSUkUolm1p/IsCJoRKVvfU4pLvfAOX?=
 =?us-ascii?Q?3CI+L0Zpidf3uPeR+V8EctYcqM2eCCi3G1i1MHKHlBD9uUKw/MfuzPwzGfpx?=
 =?us-ascii?Q?W+ws3xSzAQoYyZDsY6GVOIQh59uNPePfim5yoSIopNGU8SRcyKgYDd37Zyi9?=
 =?us-ascii?Q?BSTvhSesXIslZYI9U2r+85n/dV4nFL5neTbUAv14HQGnQya87vXf7JV/5Z85?=
 =?us-ascii?Q?5ZuxQrgTjpHLDBgcaXfMshfWBvRVK4FHvvUdwRnT1JqCWpsqMph7e/9iZKKl?=
 =?us-ascii?Q?lVaGyNU+rXjcnpu0jNPSlkc/9Oit+Ci63VKCq7j8IpdhNbsxakXHz0EWHs3l?=
 =?us-ascii?Q?HUmSdyzt6cah0BrdKOBUw/6l08uSo/7H2AIJJGMibwFL+mL8U1nECCMvH9zx?=
 =?us-ascii?Q?NdZTWPTyj2UfK69iq2P0pFLzdDn2p6ZnFbXRfCE+poZc6DZ/MO4aNxjHb4By?=
 =?us-ascii?Q?sxWnVfabinb73qXlxFRYR+TUBStyq3jMBT0gj9UMXUjO4lKOtjewggEtI5H1?=
 =?us-ascii?Q?vaMg4H4yEkSPeE7ZwPIdJS9aHOCJ3r3UsgBMGOvUsN7Velx3ibkrT7X7sujP?=
 =?us-ascii?Q?cTCcxUOOtY8xkZeb5bFDqkjY9D6tNwmqfsw4/jJN44r8jOg0hX/fwYg5cwui?=
 =?us-ascii?Q?fhUKkMAHQhHiefo7BBlKeyfYQ6VszuG/9h/jafB2mn6JiZfSdp5p2wXpOMt7?=
 =?us-ascii?Q?dij02FeEviST7SXx8q92LCEwS79dwIN6fnpqcPotRAsQpjcjO6F5JwXHp/EN?=
 =?us-ascii?Q?1pgjH9Wb3HFQnZKeb+NjZgU+cxlp6P8WFFSh77Kd63/Y0nL7RudJBYqV4T60?=
 =?us-ascii?Q?6ng0xWgfJnz8YSTvKz26QK5B6pSu2FlYEmoavClL3rv66lwvHoJEv8sJmuEU?=
 =?us-ascii?Q?4uczfPq2HMTrqBaFo6UfEZUw1f0DdkJymXMB4UUyxRr2jJOKJZ1/3iuxVe56?=
 =?us-ascii?Q?BOn6xSPG7phPItJlHiygzYyRlLrDwzEkNVwCwiBtPuBHMHYR7fC1aK1juips?=
 =?us-ascii?Q?5cHn8sNs7iJoSQK4me4DrShgAuHcB92ZwbIHYUVvO1mxfPX617qqydrYhyak?=
 =?us-ascii?Q?cBj357aw+ST/yjwxHhQB/u/hu72WG99PT+k6OnneN9UaGkd+mP+I1n0M3rm5?=
 =?us-ascii?Q?51eXEXCcpQ1DJ7N4lZPAKZvDIZf+5AavJzKa+/Y4fAh813fVsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:53:38.6587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 458cabc0-71ab-4985-5340-08dc947693e1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146

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
    v7:
    	* Fix Warning for not unlocking the spin_lock in the error flow
    	  on module_flash_fw_work_list_add().
    	* Avoid the fall-through on ethnl_sock_priv_destroy().
    
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

 net/ethtool/module.c    | 277 ++++++++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h |   3 +
 net/ethtool/netlink.c   |  39 ++++++
 net/ethtool/netlink.h   |  15 +++
 4 files changed, 334 insertions(+)

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index ba728b4a38a1..6b7448df08d5 100644
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
@@ -160,6 +175,268 @@ const struct ethnl_request_ops ethnl_module_request_ops = {
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
+		    work->fw_update.dev == module_fw->fw_update.dev) {
+			spin_unlock(&module_fw_flash_work_list_lock);
+			return -EALREADY;
+		}
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
index a5907bbde427..81fe2e5b95f6 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -4,6 +4,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/pm_runtime.h>
 #include "netlink.h"
+#include "module_fw.h"
 
 static struct genl_family ethtool_genl_family;
 
@@ -30,6 +31,35 @@ const struct nla_policy ethnl_header_policy_stats[] = {
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
+		break;
+	default:
+		break;
+	}
+}
+
 int ethnl_ops_begin(struct net_device *dev)
 {
 	int ret;
@@ -1142,6 +1172,13 @@ static const struct genl_ops ethtool_genl_ops[] = {
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
@@ -1158,6 +1195,8 @@ static struct genl_family ethtool_genl_family __ro_after_init = {
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


