Return-Path: <netdev+bounces-107322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D30491A8D3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AD31C21787
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A8F1991D0;
	Thu, 27 Jun 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K78tEi/h"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481E19755B;
	Thu, 27 Jun 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497437; cv=fail; b=rAkmf8+uvrEC/EoZXjmGPlHUM3ZUjOaHqlTdBVIorIsVjTOCsqqKqYvVz5Lf6UV6Rd6tY9PteFY0iNPx+tNLbY4o1wj5tEdbslbbiOHQGmdNrb7ThvWkIFIHEyytJgy4uDNtYBx3Ba5uzp0x/sEWQ1uf5zF/TjF8Hg3Y60VZ7nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497437; c=relaxed/simple;
	bh=EbrTRw2QVpnZbECqTUp0JQ5mkBSP5fVoau0WvgbYGfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hM41a/hKGDAzYh9+lOcIAyfzPb+pTPvNDxaYQiFCVVWloqf1silVWYWm6Vsq0KAaqIByPWhuo7UZY72hsli4taVVBxw16qh1/Sxb/WQ5gePtCymtM9FDGBCFAkGyQAicUpV+IKyx2rIBlsoTAOI817QpGb7U8T1qP+PZf6Q3TOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K78tEi/h; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9/wq57TKcxUQo9b8ISS0UNrcAlpYk+3yOt80xOqwnU/dzx8OoDS4Old/zuOcW/tpMRZ0fhLEjkx2UKhtuNKba7KNCltBZrsYCwVYHofCiz1Ext50vySBn+Wj12HXRRnicQGcykL1yIrWu1zQAJUAzNO1KVDChqrVowfHJEDJwptR1yG7DB63SaNW7H1dPnj+t4sX3uYy88ME2zV39VDOPos8JW1/1Eh/blc8hh9NcbKs8alJ3mex2T++66Nh1AY/gXd/fghAoqka4371j+etYChWyMGXkwIz+iOVH1FDfUgcKvJR0xJu6R2+7H4xhmkNDMZhPUxPirujFSbb7e7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzchNaUmuyi+LzuK7zc08C0wU4TBOPk7rrAs3wfO+8E=;
 b=ImYQyW+dVRQ4QFgjzrZUokTOzB/7xCtkwmcABuYOBLodJwaCpM4lrNHUo80CIk8nnNSAQlpJUdsPP/9UGrq9/qDeILZTzdlfWc+EusJ6bFjD4q4KhO+qnAjN5YAH9tQCLL0XzHz/KuZl/XMExXsGMLR7nSRIv8Kri42z2fb77SU1a/HIu/iRrZ+kPjIHDYv16/NnTeSW5v2xI0SJnB4LveNX8uMcdp1asHOspk57JRJt/iGr2kH/ZxQqKMolN8yhD/hvXMM4IL58S+RUHr9W5jZHZWSCFY9lD97ae7BXKK7VAP4EcYn9SYgpTN+tm1Sp3bX5xvvxkE420dlaX8jYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzchNaUmuyi+LzuK7zc08C0wU4TBOPk7rrAs3wfO+8E=;
 b=K78tEi/hlQdez5ZavuxnupmJGwOwknG/qZsZ57skt/bS+ekeWojjWOBpzKwCBfiYXgnLj9qzsGlnBaA19pQmWZJWFIXyla3C0oBUhDYoz/Q3w5G8Z2W17WW6ZxC9UDupNs2I1LKBw1O8SLPWaLCxKxeWrciVJozTeEN6rZWl7MH6dIFY+hjzp7ZY5HvR3//wbsjCwgmCVEAA9DrlOj3TjHvAyO2prnPWClx9Xjq+BLq0NjdrbdGd2aczsB0liZUUaircDnZuBw1mxYkdoE3go+mXavehDaRmz7KGQMhtU29z6rTyHZDjC3Y6Ht01BMr+220caBBBVsNm3ILu/lFi0w==
Received: from SN7PR18CA0016.namprd18.prod.outlook.com (2603:10b6:806:f3::20)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 14:10:31 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::ef) by SN7PR18CA0016.outlook.office365.com
 (2603:10b6:806:f3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:10:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:10:14 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:10:09 -0700
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
Subject: [PATCH net-next v8 9/9] ethtool: Add ability to flash transceiver modules' firmware
Date: Thu, 27 Jun 2024 17:08:56 +0300
Message-ID: <20240627140857.1398100-10-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cef1cbc-2a8a-4783-e7ea-08dc96b2e73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JDSvf52o+EEPo8YgCUARwaGumcygFos2utqHGC8glgEdmV0MTXIKmSoHdTFm?=
 =?us-ascii?Q?dH7BRWGTjAWX+LYDEqLkdyx1GuxsZDKvFIVLO6sIXD3/ovtEW3swMyOkFjiF?=
 =?us-ascii?Q?L4oxaHsMgJo8VxqdvAQ7ZdwN43Ge5cdsClfywOqjhDNKoEdkuVNDdWzeTqVY?=
 =?us-ascii?Q?JM6PxKbxKzHCqJ7CNm+G/YSJSiCm5SjjgUG3W83EDyg/MDK+giavH7ARix0u?=
 =?us-ascii?Q?26heKOR7grHTzplgZHaYSmIt97rMsN94w/5I9va7sVJShBt4Yg8fsuJxyfqA?=
 =?us-ascii?Q?FNNRim9VbPOMXOCdrX1CbC9/NQCGsNqhdKYHcAO79HoGB6VyRzGJKxmmjW/Q?=
 =?us-ascii?Q?l1tW4hkKw68fFXpl/A+e4UwVuJ/fWbdx7bRewoMrHMfVLaCVxxcJi+tkZJrq?=
 =?us-ascii?Q?ZviUUZUrYclnrqG7GKV+ImdvyvIarUMZ5TX748A75ptEFhEGoVKdoDPvA/9X?=
 =?us-ascii?Q?W2R/zOBZ4wpH7n19jr9alj/T52ulHvZmVjpJfKWsS7ylWzfiq2fjLFZm2xwf?=
 =?us-ascii?Q?OVaa7/p4Yxq3lcA34Uk18iPgbqbVg34NOJVgjbO6uGrdPdyzSLc0Hd7/xJcn?=
 =?us-ascii?Q?cIFp/9Vn5VcvGime6kpH84ru0FvVk1B7BU07BiSP0oIQ1/ZkkApCtd3cengs?=
 =?us-ascii?Q?B3eyV/7x2AyNYhOoBK78OTLwx4z8UklYlAbUfK+4y6VLsoYCsVoZZhqfcRf6?=
 =?us-ascii?Q?mhO8yMHD38SVHjw6aoRfSm9ItDM2YVceUbAdLqxOFizvBYuOrOvbveF8+c/3?=
 =?us-ascii?Q?WfJXAbJiSf3m/2TXF+KLs+tofDFz0jcsFdTiZMi1JnWbbcGERq2K6X5gPRgX?=
 =?us-ascii?Q?pUhsGj/mTcGD3aNCbtXxGuHL+vk7GWvfjupd0vzoxiEQB7PxUA2JQO2vLmdh?=
 =?us-ascii?Q?q+eE5JpIoUCKy9z1uQT0+6wJZlaz2A4M0zA9i7RZGAVJdkE4eC4vU2gS6/zY?=
 =?us-ascii?Q?dsvsQHmwx2qyt5d4Vs0KwtrRMZOfuW643oomkRZQIopLXdQXgiA1ngzGsTRi?=
 =?us-ascii?Q?tlQTT7gPFO7n8vVRZon0r/SEWsCoCNXlSN9cZZhSO4gxHJ2hjCEFW8um4Z3J?=
 =?us-ascii?Q?K0lc5CsaYUBaPjV709g91Y9o98WwRSanvrilEwjJRZWIFRe6I6my9YVVBWQZ?=
 =?us-ascii?Q?PVdV37lcmehnWHD0kxsDoHx3h2AsPXJDguXSVyUJD1N+vFnGOiFYVOMi7CJb?=
 =?us-ascii?Q?pq/D979YQ8YRWJluqdvXIrHzJzS5XmReCDfCsD9vkFDJvzaTHcFvB906hPt7?=
 =?us-ascii?Q?tL+TeAi4+eSG8+WLcRt8+XvknZEtU8s7TS3t7WB8qKVlYKVvHjoZ+9KZLNz0?=
 =?us-ascii?Q?sztdBCEY2L0VPn8aMFPBqHq1sIFLEb42qwayJQqwyzefc+IiLHX5g26h5qXi?=
 =?us-ascii?Q?Ie64aDdzZ+JcQ0eFzO3d2rgZ7aK4I/66az0t5jK4reY7/gbVaCSHqDzeUI2r?=
 =?us-ascii?Q?kkswSpejLIZA80oEtvwLj7V7yLF2Tjrk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:10:30.5166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cef1cbc-2a8a-4783-e7ea-08dc96b2e73a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

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


