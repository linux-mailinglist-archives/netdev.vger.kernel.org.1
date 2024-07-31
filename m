Return-Path: <netdev+bounces-114449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F2942A0E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5AF1C20FD1
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297BA1AB508;
	Wed, 31 Jul 2024 09:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s1vGey0x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BB21AB501;
	Wed, 31 Jul 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417391; cv=fail; b=ADm+MQUfguePa/leDR00m7fQHROx8K2OSwY9a3WZVCvoP9Bl15tsdRIbGoEIIZTVCRYGMGZ5wLXpc0I5h6VY7GSoiT8wzPIgBbAJu+zi+tGgC90c4QSGAgXEtor3pHa8yHxapU+ZdcGFsucW5Pm9PqwMeFigRCumqLSxhux/zqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417391; c=relaxed/simple;
	bh=bJ9N//TmP7s94AOZq+isXyeLdnlF0+4l1rjhwXMrMWU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDgUjWW3wAYwr3xeiNfsuDVdUWNncU+9irMXGWVcczpH62p2YIE2CBQtEEHGyQAKDWHzBK7mC3D72j1fg1iPtyplf5Qeoehqz5aCTU0rZUvKVmtQ+0aDZFRyhgVp/gav/8nyJho9o8DmJNLU2rYTy9/p4FpZOakYWF+dAOQNB1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s1vGey0x; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XEPsih3upT/suqYeX2W3ZqI2mTnoEJbU2IesmKieOTsLDag7g5Bu25+YKQTswNwHIkfKSfz+j2YqZhYcKkzFwYmzBoWwxFGLG1DHP98RHvf2QLZwNV7mePWBKAQPe3oautDeL7HIDqm5hq25ThndHnTqYVc2owhB9wEeYgzDH35XoTJC5DHqv4gu8uyqr7kUOtsZtt/H09bfvXsU1XE8baJw/xyNIgI59u8QSbo6tQRNu0LVUzU0iUf4b3jso5/iBpCcUuyioHHylIM+lyhRB+rTCV9GMPEUykS1IyZdDPdZZDpUSKAznl0OYBjVxDggFvb3LT1pVW1na6WXs5/aCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RO7bJrGl/xzVJ91LxFCZoXeosBbl6GjncH/e8ncEf0=;
 b=EJ8MsNhO5V9olARYsLIulZzRwTAOon58we2RadTCBu1Svn81InEBJLQdkVX4vvcMK6t3B43FiAlkIciWXwXT65xgmpn/V/Ds1pfXi+vRFzapxI3wUVZKcNZJUxCZCeojm7KhNDY/V6juPTyKLCT6bgCNRqxQSy3p67nc7lrCXKUTz26rqlJXqBBMyHaP0X5ZlywsIisIL+5EJXTG2kTQMoCQDpzkbAT56ndGu1eSqs/49+TVhXxiuE4fWysxow7rFQK2ffyz60eee3zdpkvS+A3RpqDseo+Jix4dgdvCVtRadwCCqyeM1X3CWg6SNyJYdlGkpvYwcLhiigtbwEJ/fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RO7bJrGl/xzVJ91LxFCZoXeosBbl6GjncH/e8ncEf0=;
 b=s1vGey0xVe6/2NeJo6QZi7Glv+BByPQvOAGE60qoW193Y3LhkPYJe3ADsbFJseNpkxHfRW3LgqAHeucTqxp8gilxqJI7y3lVDFz68VKC7dpiuUXZOyUU0C2ahdQ+uCNu6Y90QdqI+lo+jIYM8GbLcrT3TzoOuc7vRa626Iz4JoQ=
Received: from CH0PR03CA0315.namprd03.prod.outlook.com (2603:10b6:610:118::15)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 09:16:25 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::7f) by CH0PR03CA0315.outlook.office365.com
 (2603:10b6:610:118::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Wed, 31 Jul 2024 09:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 09:16:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 04:16:24 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 31 Jul 2024 04:16:20 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Appana Durga Kedareswara Rao
	<appana.durga.rao@xilinx.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v2 1/4] net: axienet: Replace the occurrences of (1<<x) by BIT(x)
Date: Wed, 31 Jul 2024 14:46:04 +0530
Message-ID: <1722417367-4113948-2-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 26608056-86b2-4834-7468-08dcb141739f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5kq7QNHWbmspGz+WyltEusd34y3WVv96AMJW0+Qt90nVQFthUMcW0A4lQs3F?=
 =?us-ascii?Q?5/iMYOMQRZC8COVbFL+2nHor/K21oZZnzG2qLf3qZrLRhVN7f5bpNoI6GWnj?=
 =?us-ascii?Q?BhHze0twHcP5XFRikZjfjMRH65DInj6w4kn3QFnqDomjT7QSWaiDATW2cZk3?=
 =?us-ascii?Q?x1EP0CYi9+5y6BAmiDyijztTD+8ngMRH1sSIrnRw3ms3/bNAdE5JOuEft4kS?=
 =?us-ascii?Q?9U96CSdjzR9XTZkd6K/loHBXpRyxHgGRpS6jkqJ3YvMzvgzIuKWSnk69f+ir?=
 =?us-ascii?Q?tsPNkOQrxWvqRoT5ZfXVX9s/44HJJeVM8BX39dSvdfRL7OwadnqgSoI0lFU6?=
 =?us-ascii?Q?cCVbKdOwO2Q2+2mDPlihY4J/GGFyiC+9scFoSMnlX8z8Yq/3bFdpodxiXSKt?=
 =?us-ascii?Q?DyMQHFXpixzjU5XIQ6JwbN78l6LS730yCebwpaz5vW/Zm2YM5qhkbZ+yZVeC?=
 =?us-ascii?Q?RYInldndIs6yB24fuppRiOotGBtfUPPqZ67j81jj8wyvpttJTK5LipVgR68p?=
 =?us-ascii?Q?ULvsLV9MpGEsL6ohjCYkUe3KiyUKx8+lLy14ml1epeaSExeL5zHTrsfkB3ra?=
 =?us-ascii?Q?pHsSVA+7zVTCG93tOXITkN8RmCFj+Hug4A78HZWqp4nw+KZQM7wiCF0L00y6?=
 =?us-ascii?Q?Xac0+hkMHY4HaF4D31oXhu82fmiIKdciu3j7PUFU8FSS3RE1vX6I+2brwtdb?=
 =?us-ascii?Q?RUtlGqqqiRkeV9baWsZsqQL4e7SnMMJO27pWPG7Jj948iwgv/y+qx877mHlc?=
 =?us-ascii?Q?mOxtO9Iyl8n23Kgzhg5De8JCWsawRDRut+WzzNQdhDJlH9F64nExb8Ectvns?=
 =?us-ascii?Q?uzoJ3boinMaP1nwwEOhySIzuF4wgwzDcnvslonnZdga1G5waSRxDzWgN8OUi?=
 =?us-ascii?Q?OPAexBclYtIgJ1AaL6BWAlqMiX7wP7O43BXp3ozfVj31GLs4Hj/TZnEXrS2C?=
 =?us-ascii?Q?VB7MPovV9zJq4bdyuR99dYqhVlZQEQUF1xXDGkMNirm0KU30HGobaadRC26z?=
 =?us-ascii?Q?1M/WBHd8Ct6HzIuz7brb7eqGScuyQAznJR1XQS0Gyj4FG6FtRxNVKQln+ftq?=
 =?us-ascii?Q?RA7aKvETXWm8+HxWyp8bbTOg4CL2zz+Z0g/U0dkjKfsM7/luP9ljTfgmwbk/?=
 =?us-ascii?Q?Wp4rXEvAaN98lXigU7Pm/YiAkl8KE/3tglMUR3IdxM4cc7EZeavDN4uiiRKp?=
 =?us-ascii?Q?gSEeA5ov3D/uRBD8AoxReaceKM8kX2cnmDfvmXVnEY6+jJ+aox0RQzOTEAke?=
 =?us-ascii?Q?LrGpr3EaTxGVD4WyAiHRzSsULnIi5vMJZMw7Nlvacf848ZYSiCwdW1l4KV62?=
 =?us-ascii?Q?CTsunVqgEc/AEfe/S5AmZuP3DxoYa7kVFpvvUlZB5XiqqsT78jgt+SX7IMjk?=
 =?us-ascii?Q?v2TvJibnVi0IC1H48QnXHWcG+5XpiTo6i4LL7IWtgClfv/rOF/hlFh1kCF3W?=
 =?us-ascii?Q?QEQwpe7f6v7Bx6/QFwdg4nTDCh+CDhi8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:16:24.9807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26608056-86b2-4834-7468-08dcb141739f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656

From: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>

Replace all occurences of (1<<x) by BIT(x) to get rid of checkpatch.pl
"CHECK" output "Prefer using the BIT macro".

Signed-off-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Split coding style change into separate patch.
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h | 28 ++++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index fa5500decc96..0d5b300107e0 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -29,26 +29,26 @@
 /* Configuration options */
 
 /* Accept all incoming packets. Default: disabled (cleared) */
-#define XAE_OPTION_PROMISC			(1 << 0)
+#define XAE_OPTION_PROMISC			BIT(0)
 
 /* Jumbo frame support for Tx & Rx. Default: disabled (cleared) */
-#define XAE_OPTION_JUMBO			(1 << 1)
+#define XAE_OPTION_JUMBO			BIT(1)
 
 /* VLAN Rx & Tx frame support. Default: disabled (cleared) */
-#define XAE_OPTION_VLAN				(1 << 2)
+#define XAE_OPTION_VLAN				BIT(2)
 
 /* Enable recognition of flow control frames on Rx. Default: enabled (set) */
-#define XAE_OPTION_FLOW_CONTROL			(1 << 4)
+#define XAE_OPTION_FLOW_CONTROL			BIT(4)
 
 /* Strip FCS and PAD from incoming frames. Note: PAD from VLAN frames is not
  * stripped. Default: disabled (set)
  */
-#define XAE_OPTION_FCS_STRIP			(1 << 5)
+#define XAE_OPTION_FCS_STRIP			BIT(5)
 
 /* Generate FCS field and add PAD automatically for outgoing frames.
  * Default: enabled (set)
  */
-#define XAE_OPTION_FCS_INSERT			(1 << 6)
+#define XAE_OPTION_FCS_INSERT			BIT(6)
 
 /* Enable Length/Type error checking for incoming frames. When this option is
  * set, the MAC will filter frames that have a mismatched type/length field
@@ -56,13 +56,13 @@
  * types of frames are encountered. When this option is cleared, the MAC will
  * allow these types of frames to be received. Default: enabled (set)
  */
-#define XAE_OPTION_LENTYPE_ERR			(1 << 7)
+#define XAE_OPTION_LENTYPE_ERR			BIT(7)
 
 /* Enable the transmitter. Default: enabled (set) */
-#define XAE_OPTION_TXEN				(1 << 11)
+#define XAE_OPTION_TXEN				BIT(11)
 
 /*  Enable the receiver. Default: enabled (set) */
-#define XAE_OPTION_RXEN				(1 << 12)
+#define XAE_OPTION_RXEN				BIT(12)
 
 /*  Default options set when device is initialized or reset */
 #define XAE_OPTION_DEFAULTS				   \
@@ -326,11 +326,11 @@
 #define XAE_MULTICAST_CAM_TABLE_NUM	4
 
 /* Axi Ethernet Synthesis features */
-#define XAE_FEATURE_PARTIAL_RX_CSUM	(1 << 0)
-#define XAE_FEATURE_PARTIAL_TX_CSUM	(1 << 1)
-#define XAE_FEATURE_FULL_RX_CSUM	(1 << 2)
-#define XAE_FEATURE_FULL_TX_CSUM	(1 << 3)
-#define XAE_FEATURE_DMA_64BIT		(1 << 4)
+#define XAE_FEATURE_PARTIAL_RX_CSUM	BIT(0)
+#define XAE_FEATURE_PARTIAL_TX_CSUM	BIT(1)
+#define XAE_FEATURE_FULL_RX_CSUM	BIT(2)
+#define XAE_FEATURE_FULL_TX_CSUM	BIT(3)
+#define XAE_FEATURE_DMA_64BIT		BIT(4)
 
 #define XAE_NO_CSUM_OFFLOAD		0
 
-- 
2.34.1


