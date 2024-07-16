Return-Path: <netdev+bounces-111752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D496932730
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E0E1C22E84
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F7619AD71;
	Tue, 16 Jul 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FQ/RHuZN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFB119AD4B
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135515; cv=fail; b=XoPmhs4O8xj9vBzOoymGTtsHpihYOBByI27+YSPu3kq+TSd7uXNiWg6dBsJe6gtlFeAh6w1zKSAmtgNiC/mr98FgXw5PckcM3wDpieAsisLaQ8qkBcneu93QmdIfQk9MubxT5Z4uFsriLGkllgEnzUFtUNQbFKhNeORc60YH+qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135515; c=relaxed/simple;
	bh=+PCRIAMLhysGncRwfOkklAdcYGtvaZ831x/lbhUBR+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwac537YPWu1WALz8HI9l/l3g+QB/XdeBMMgSIIObPZxCAVmBnkv/Kg7ymaR12SnLkFzlTVgCmn1rVb+buJnKmFoluk7jm1sqqX4SasI+UIMddRExUsDI2e6bzIh4VnVo/7AuD7ZJM1sf0U+tIiSLI0r7IVK8fSpU8/ngkofPNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FQ/RHuZN; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MP2A1D6Ljo7E5530wh08liAoGqxG02iwiW/Y7BrOkDGXzHH3oWUED14/XA07YNgkAzaSs8zGogKBxopt/xFfT3+0udIK3hrhiBPokkOSHr0rYn2odOr2YJJ7aDgONGDow5a/iiE6AHfF/zu7gKt6Bn1WftbixoKnNQGi9e4oIJ0spuW/rTVvO6QcgZiIrsqJzSL/p6QXQJYt33anSw5n7wdKAs+VRBlEGpxOuRCh8w0/oQJyEC9BO/XS7y+UxsMWAIc/Yw89NxejGqkUxJhb7qt/X8y3Hbi6tmR18RzgJDTuuG4tYQzucrDUrGuKoufL7k5eJ0D/sjs++G3wo8m8PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNkh8cGT2Vyjkk4zzsHP0gkgH4cjzDS4xIwkoN4u+Ro=;
 b=Z6qQAR1BPiK39XzfsFujdMTnolDQiS2IMnKRzdfUnCZ0xMDyzxUUhQUPv91GKhbRAj6wYYMiv9EyuYnu9erR1KJCC+CDNKoAcBE7pRhMi5ICV+yNEkkcWtRLftRC2igdbO4LbqyqR6sVxmwi0XBdw7br1utXfjFyqRquencv4vsh11HehURVHNLF0w8jKYzHcGu4FhevJ/EY3gindbewMjN6OCEyE/l5049wLcPFIuCgKSiv3ylh0u3UI2irMRfo9KJL1vDEa3K+OSGDMBtuj+6mvcVk9rQ9/INetmrWtI6w/O1FyDIra6BWcKYALt0GginB4qDKttb+pATbo2tmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNkh8cGT2Vyjkk4zzsHP0gkgH4cjzDS4xIwkoN4u+Ro=;
 b=FQ/RHuZNHhY8OLdQnnVzheAyj7XVlXZMlBVV+lWQ+P7BlML1Pclip1SwsfByMSOm0WzUZ3QYmx+4VCJgsRt1zThmrXO1X7bEb6BxUsWO8kH4gB6N/wrQEpN5lSOg5c/Y2W0VCZIsnnlz2AzML86ZUVrhj7uL1r0PU1GkVIznho8OTLtURuwYhI6E5bUFH7L6muhRcFzavP2lytMTK9J8p6AsobwDokBxRNs6x9Af/GPKop39jjXE+rvZtTSWV4cUNgBpa4VQ294/Gk78CtCN3piT0qxx4jU2iBT+lgSS9P2grjs4Vik+QTXnSkd43/q8JUdpfE4sF8erNZ+gokQYcw==
Received: from DM6PR05CA0042.namprd05.prod.outlook.com (2603:10b6:5:335::11)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 13:11:49 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::ea) by DM6PR05CA0042.outlook.office365.com
 (2603:10b6:5:335::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Tue, 16 Jul 2024 13:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 13:11:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Jul
 2024 06:11:33 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Jul 2024 06:11:31 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <mlxsw@nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 3/4] Update UAPI header copies
Date: Tue, 16 Jul 2024 16:11:11 +0300
Message-ID: <20240716131112.2634572-4-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240716131112.2634572-1-danieller@nvidia.com>
References: <20240716131112.2634572-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 39ed7594-10bd-4b4a-c9b2-08dca598da0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oaJJUTDiBM7octRh+PmDJpcEOagbpPl2ydfTXNfTR0cwKfpBcp2Eek+7pH5u?=
 =?us-ascii?Q?REVDy/Dbd4KjcXsOAGtEI/fs491uKRe7en7gN648EitIunAvb7nTVGX4YJcc?=
 =?us-ascii?Q?z5g6/ejbUcpR71ag0GwmwqOzi/f+RkFd/vjlYZqu662lAEFDLlEC2F8q13+x?=
 =?us-ascii?Q?DZD8m0zFW3qdFxbJNr9oB2P2XfRrB/aTCqquhBelU2ag4V2GyN3O1VMOyufS?=
 =?us-ascii?Q?MlyPqfGLzXjEVk4QkS27yGO467KOpI/COiObWu9n5DsYu+sK6FSrrvmUBSXP?=
 =?us-ascii?Q?8PsMycmo3aO8Krgh5qZrUxrDim3/DGA9pWQJSOxyNl/8TmmWM9g7MX2gJRdQ?=
 =?us-ascii?Q?Eq1Lvv0GUEzIJGq2FbZNv6N7P0e0Dl1+xOkupIaxi9UUVcJlXf4rQ6OLzdnt?=
 =?us-ascii?Q?26cQC1LQSK3lhzotCaXCqQF87QY2o/v9oJL5g6QYqWBvTFACCiNQKsbvmYmR?=
 =?us-ascii?Q?PNihoaF3UA671UhGR6i3sCytfz4VYheTkqUBywELg+h+Gnsv+Nkzu4aN67va?=
 =?us-ascii?Q?Xs/JMibBl2olZpAc9S3dyx4GHdotfsoVOVRY/YKlIDvmIhNRl30JHOsxeDs1?=
 =?us-ascii?Q?dksSHcXmWbSd6sHJr+9sAShwmCN7s/26+PeD4kMCxU6bW7R340I/igJFbh3e?=
 =?us-ascii?Q?K6LdaeHtKK+iCl5y3nCaaGB3gmB3B8l25DgRtRRV6Km/Q9Ykw6IC4rLXtl9N?=
 =?us-ascii?Q?UQngZ2Ia789Cs63Ze6/CXSyN5G/CDhXYiwwiGzvavXtxgzYLX6GYlfI5OrkS?=
 =?us-ascii?Q?fcuKEBMymIJMGcBf/rwpFskZxPS7MGSgQ1UVoqr7J8Q2a5wNQU/nKG3P5suH?=
 =?us-ascii?Q?HQiONNIlELC3xsWGMVTEiSimnzzbzSfh50jpwhygFF9Mky2MuUPhgtS1xU2E?=
 =?us-ascii?Q?ugQ4Yo8u6yuPebAIuU9SUARrzfAJQ3aNULvkNEQJfZhqSKdkeLE5UOyWSqEn?=
 =?us-ascii?Q?/VmODEsQpLZlLlm9w2E3M/J1NlMsIiue46/58CmX+jOmp+LEJ0BL/+0QPZA+?=
 =?us-ascii?Q?cGPz+/his4U9eCRbDQCgn3Ig1zdgHw0HUrb/vZnQHz0UiCMls+xPt7ztVx3L?=
 =?us-ascii?Q?KO+b2gCHguh5gSsINufld18h72apSytgcDhmGZlTKiwRWOwk74KXUmapr9Kg?=
 =?us-ascii?Q?jfoW6RbtiZAvdC4iy0YQMrFJsZJSlRo8MAPvszTJbT5H3w7694MjapALL7IK?=
 =?us-ascii?Q?XXHtlZcBmk/SRZvgDnxXE9dzckSuulCO3B5aI3kFhPUG2ht+EICroB1qFWe8?=
 =?us-ascii?Q?iZcfc340gj7TtJ4XXQog0XuCYVAMXhjrnvjuMirP8531GXZ/I1GFgDhSR9u8?=
 =?us-ascii?Q?O98OHwn5QQkV7WHHegajs5RgBCug9JTU0wTmaARX73yOP3qIqC2g3c4G5buc?=
 =?us-ascii?Q?yOFEynfUr4CQren1TGJIXkAYSJ6BSVohtSFs5g+wOyljr+kEkszR5pGpTKgg?=
 =?us-ascii?Q?qOiIGY6paB0Lz4cgBcDt/YvO7ajyWooD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:11:49.0844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ed7594-10bd-4b4a-c9b2-08dca598da0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185

Update to kernel commit 46fb3ba95b93.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 uapi/linux/ethtool.h         | 18 ++++++++++++++++++
 uapi/linux/ethtool_netlink.h | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index bcec30c..d6e3652 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -875,6 +875,24 @@ enum ethtool_mm_verify_status {
 	ETHTOOL_MM_VERIFY_STATUS_DISABLED,
 };
 
+/**
+ * enum ethtool_module_fw_flash_status - plug-in module firmware flashing status
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED: The firmware flashing process has
+ *	started.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS: The firmware flashing process
+ *	is in progress.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED: The firmware flashing process was
+ *	completed successfully.
+ * @ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR: The firmware flashing process was
+ *	stopped due to an error.
+ */
+enum ethtool_module_fw_flash_status {
+	ETHTOOL_MODULE_FW_FLASH_STATUS_STARTED = 1,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_IN_PROGRESS,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_COMPLETED,
+	ETHTOOL_MODULE_FW_FLASH_STATUS_ERROR,
+};
+
 /**
  * struct ethtool_gstrings - string set for data tagging
  * @cmd: Command number = %ETHTOOL_GSTRINGS
diff --git a/uapi/linux/ethtool_netlink.h b/uapi/linux/ethtool_netlink.h
index c0be6e5..61af33b 100644
--- a/uapi/linux/ethtool_netlink.h
+++ b/uapi/linux/ethtool_netlink.h
@@ -57,6 +57,7 @@ enum {
 	ETHTOOL_MSG_PLCA_GET_STATUS,
 	ETHTOOL_MSG_MM_GET,
 	ETHTOOL_MSG_MM_SET,
+	ETHTOOL_MSG_MODULE_FW_FLASH_ACT,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_USER_CNT,
@@ -109,6 +110,7 @@ enum {
 	ETHTOOL_MSG_PLCA_NTF,
 	ETHTOOL_MSG_MM_GET_REPLY,
 	ETHTOOL_MSG_MM_NTF,
+	ETHTOOL_MSG_MODULE_FW_FLASH_NTF,
 
 	/* add new constants above here */
 	__ETHTOOL_MSG_KERNEL_CNT,
@@ -996,6 +998,23 @@ enum {
 	ETHTOOL_A_MM_MAX = (__ETHTOOL_A_MM_CNT - 1)
 };
 
+/* MODULE_FW_FLASH */
+
+enum {
+	ETHTOOL_A_MODULE_FW_FLASH_UNSPEC,
+	ETHTOOL_A_MODULE_FW_FLASH_HEADER,		/* nest - _A_HEADER_* */
+	ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME,		/* string */
+	ETHTOOL_A_MODULE_FW_FLASH_PASS,			/* u32 */
+	ETHTOOL_A_MODULE_FW_FLASH_STATUS,		/* u32 */
+	ETHTOOL_A_MODULE_FW_FLASH_STATUS_MSG,		/* string */
+	ETHTOOL_A_MODULE_FW_FLASH_DONE,			/* uint */
+	ETHTOOL_A_MODULE_FW_FLASH_TOTAL,		/* uint */
+
+	/* add new constants above here */
+	__ETHTOOL_A_MODULE_FW_FLASH_CNT,
+	ETHTOOL_A_MODULE_FW_FLASH_MAX = (__ETHTOOL_A_MODULE_FW_FLASH_CNT - 1)
+};
+
 /* generic netlink info */
 #define ETHTOOL_GENL_NAME "ethtool"
 #define ETHTOOL_GENL_VERSION 1
-- 
2.45.0


