Return-Path: <netdev+bounces-106227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B432F9155F7
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05560B222FA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F41A01B5;
	Mon, 24 Jun 2024 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TX5zfbwC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC041A0B1A;
	Mon, 24 Jun 2024 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251614; cv=fail; b=UVuJh7VS8jeck9rd2UE87ylJc4licOC/qCl1oaHIDDJnrT8F3V/gkDdraTWoALyYAzms3bLW5DvpQ2T8au4Wt5WuKHeiZoMx/Ek8YK8wDPCaa0f/yYbuUD4RmXtvua/0NxUXTsYvl695jksSavF6RxoKuHKRsptmnbTf+56CRPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251614; c=relaxed/simple;
	bh=RqZrtF9hzPPydnCat2CKUJoLjAR3aJkQL8WArZqek3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZV6t1g9JTwIj/UfBzZ0K5di9sza7b/PlTJ5usRtGMbb67Tasm5DZUZHbl2cyWXhfKslECZOAnT1nvPCOk/Nho06cxWo/5knO/jPw5eEX0lycK2aZgcMzDAR2FUZhc/C1hAW5dpW8SxRUFP71y8A82JI1wac5W/vhhUsc6erZJ+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TX5zfbwC; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyJiTVnXNiOtDyM63Q7cDHYZJZY5rW5FqPdquURYe0TKx+8LOO7pqUAE+XY2z6MqReeeeN6JQzWvqd3IAN/8Xl6wR/lF6JKJqjxVTJtscQJWe7j6MyaDux/1T4a6PIc3SQDnB/mktisFr0extdl1XqGEB5WU/C4KJ6KQO1A/MD1gwVC5tNBgiKlLXYXqkitRFEk7fzHNo/EK5cb4I29ERvuquNOaiVZFQPmKK9TEq4xzoZdKv2gyEWY6jC5WeteL57hordTCG0gR3ntRlY6oeha+dehphjPylvE7qvvy+FhwWJBaAXcFxmIIN6YljbyRaOrRSThzjjIXtrwPRayAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4khK5DkuVZdWTbZsjigRzdxqODND9aPqXhMDUBlsPI=;
 b=cob1b2+55dhOCbWE7Bewf0m1UWxrTtWhzwaWjRocwJdbaydandZ8gRQBc2P1vv3DbxlBH+7mHAvF6J7Qn9Qj10M/jrzegIFtfZkd252sWO9cToQjD3Ki9cgrHFLMK/YUthNVeV12MZgA2kntACZnju1amfknJCSJcDNC0RIRp/InIgbutsi4fONtShNvu0h93vZ8MBK7SZ6Y3UtZHGXpjyWM8Fxj4gWvk9B1JYYvt6WR53iEGUV/pKGeiJaiv+NQ1B8oyF7bG2P6xsL7GafMb2XbLXqYMm/Kp8NuWN7fo2zVZIDT/9fbJBKKL7WPxekqnBUfoEPGYTxJh4MuTvoyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4khK5DkuVZdWTbZsjigRzdxqODND9aPqXhMDUBlsPI=;
 b=TX5zfbwC8MecgQVDPjzP6uwDwLy60OFLKWfWQcy+erFbx4iIBPOkHByncLxyYDgr00aBmTKsFQg9P4bYSoPrc1PygUZpxN7pZpKc1V/PNogjK4rJA/5joo+qAiUgMr8SuTwUJ3fO1/LI2z6D6/gF9hqcRqpEeWezcwVNLjGxjk92Js78efKzEElrSygSz0ykrWvGoNf72lrJcJ1AT9tQtE01W5iyRS9/8iZ6L8m3A7EM72Qx2RuxzAX90T8nK6X3YIk6uNjjyzs20fuVEHRyA4kRg38Fpc8u2uUaYH+Cr4jefHXGiN0T5pxXhQCVETGT91AD0o4NPTB4WlaXkrzz3Q==
Received: from PH7PR10CA0004.namprd10.prod.outlook.com (2603:10b6:510:23d::22)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 17:53:28 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::54) by PH7PR10CA0004.outlook.office365.com
 (2603:10b6:510:23d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:53:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 10:53:09 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 10:53:03 -0700
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
Subject: [PATCH net-next v7 8/9] ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB
Date: Mon, 24 Jun 2024 20:51:58 +0300
Message-ID: <20240624175201.130522-9-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SA1PR12MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2f87e9-10d7-49ef-38b9-08dc94768dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eF7mb2LStuNUpr91BMNvVQm4JEFSlEWSKfpbR6JiweMYX6AvTcCuWyEJE/A4?=
 =?us-ascii?Q?CYEh+IAoMxVmIostdXiMHWhUICs9ALpV3gHuBt+bNb86PGS1cVSecCvez3dF?=
 =?us-ascii?Q?8s6kS4ilQJBWgJQmzzRrmDFWnOz9fstCdKJEfvS+Sh99P2fce8pRMIFCrafl?=
 =?us-ascii?Q?2aiLcXx7xiC0GxuDrY/7tg7v33iuWOE+84ET2aZGCaJcjMpz0O+6UvflYN02?=
 =?us-ascii?Q?g3X1fSNtr/ZUESYa4tY3X2eSMxMoYhwohUQfjsVKHkePJPU93nVZ1jxg3dYr?=
 =?us-ascii?Q?JbQSHUqaHnOaLB7Ix5SFgFkOE4lwQvYowAvl5rvQt0JJQd551NFw0hzbiaM8?=
 =?us-ascii?Q?0Ax4JXjscLlcj3RvjH1HoE1V0m/HV//lSMqIrIDo7OheGHgFC2YoBJM2nyVo?=
 =?us-ascii?Q?Qs3KdZ5E0G8KclT2OICrmsQuYgwytYRxFn2WKb6bKVopFHzZat2jbWIbu1fh?=
 =?us-ascii?Q?v8+I3m0fTWQEI56fDNJSX+gEHbWCpQ2mXSLtra9udNvvBVH59vLWxS/FTGP/?=
 =?us-ascii?Q?Uc2fbMOXlQDEq9ocmg5gj6EQtmqpHLmfOxgPBMlD/Gwl+ySNcNV9KhPWc7Xb?=
 =?us-ascii?Q?6iXshEecrS/bXEdEYvmpSTJPHaXa+ht3jAgN0rDnunocR6yYUxgDci/QpS9B?=
 =?us-ascii?Q?pW87Q0VQy0iG02pwvyYqALR5Ze6Qs/1cninWNeBNcmbDYbi67V0oGqkoRdaa?=
 =?us-ascii?Q?7evzCbVgDPP2PvPpj3+xUTHIOKOCREyTHlSkSXJN9qMf9Rbnzth2O7rHZyhV?=
 =?us-ascii?Q?EqCQSjS4zQ+pMRMRJbuW0/BJXI7IREi0oiWYS8cviBHKfR3QqXtzEettzgqD?=
 =?us-ascii?Q?pSwEgQpVJaHzfQjm+xQAjpsp1Z4fPYQ7oHkvDxIbGojNebFGu/EF8EJi2M2Z?=
 =?us-ascii?Q?UrKKNhBzltik/bfbjHCuQj3lXX5gsOVXmuRMxFufl3p2SwPxeFqdgbqKqAh6?=
 =?us-ascii?Q?d8SFgd/kdovXE4hAM9SoDNX8HxB/844ldQNvFIPr6Ai82SGuzo+qRyhORd9e?=
 =?us-ascii?Q?O1REBkLRGnoaPfigNGR6QCB/nGbTQtMJGmweRAMwebE8dlVVCOgMwwqGvC8H?=
 =?us-ascii?Q?06i7gPuyq3a8wTQcJ2L0YGhhdevyfSpDs1aXbiy/dQ6OjqZEo1JJtD4blxcn?=
 =?us-ascii?Q?8yFOoY352wDfXiwotwpt4hzzeJla9AtCGsSDnDcTlAnVUIHQ2lbnqH3d5oxO?=
 =?us-ascii?Q?8RRYcnrAxu/WJClzTsdX00e2LZM/U34PHwip3em7wIa+l0WNH2VjTZnoGV8S?=
 =?us-ascii?Q?2bBXPVbHwg5G1G+K4nqfOPdXYwaW/KGqeRcG8lx2mTVai8CC1MovDf90J8d1?=
 =?us-ascii?Q?/vrhc2XAZLJN6nmcNddHEMqL4Vx+iHYKUSqNAI/g9Gx++6zaNrOrCQfMaiez?=
 =?us-ascii?Q?yQdc34vLjrwzg38NMdTpFTnQ4EvGzJQjfvqZC4rQYXB0tE5IZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:53:28.4556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2f87e9-10d7-49ef-38b9-08dc94768dd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118

According to the CMIS standard, the firmware update process is done using
a CDB commands sequence.

Implement a work that will be triggered from the module layer in the
next patch the will initiate and execute all the CDB commands in order, to
eventually complete the firmware update process.

This flashing process includes, writing the firmware image, running the new
firmware image and committing it after testing, so that it will run upon
reset.

This work will also notify user space about the progress of the firmware
update process.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v6:
    	* Add a list field to struct ethtool_module_fw_flash for
    	  module_fw_flash_work_list that will be presented in the next
    	  patch.
    	* Move ethtool_cmis_fw_update() cleaning to a new function that
    	  will be represented in the next patch.
    	* Move some of the fields in struct ethtool_module_fw_flash to a
    	  separate struct, so ethtool_cmis_fw_update() will get only the
    	  relevant parameters for it.
    	* Edit the relevant functions to get the relevant params for them.
    	* s/CMIS_MODULE_READY_MAX_DURATION_USEC/CMIS_MODULE_READY_MAX_DURATION_MSEC.
    
    v2:
    	* Decrease msleep before querying completion flag in Write FW
    	  Image command.
    	* Change the condition for failing when LPL is not supported.
    	* Re-write cmis_fw_update_write_image().

 net/ethtool/Makefile         |   2 +-
 net/ethtool/cmis.h           |   7 +
 net/ethtool/cmis_fw_update.c | 399 +++++++++++++++++++++++++++++++++++
 net/ethtool/module_fw.h      |  31 +++
 4 files changed, 438 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/cmis_fw_update.c

diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
index 38806b3ecf83..9a190635fe95 100644
--- a/net/ethtool/Makefile
+++ b/net/ethtool/Makefile
@@ -8,4 +8,4 @@ ethtool_nl-y	:= netlink.o bitset.o strset.o linkinfo.o linkmodes.o rss.o \
 		   linkstate.o debug.o wol.o features.o privflags.o rings.o \
 		   channels.o coalesce.o pause.o eee.o tsinfo.o cabletest.o \
 		   tunnels.o fec.o eeprom.o stats.o phc_vclocks.o mm.o \
-		   module.o cmis_cdb.o pse-pd.o plca.o mm.o
+		   module.o cmis_fw_update.o cmis_cdb.o pse-pd.o plca.o mm.o
diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 295f5d0df915..e71cc3e1b7eb 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -20,6 +20,12 @@ struct ethtool_cmis_cdb {
 enum ethtool_cmis_cdb_cmd_id {
 	ETHTOOL_CMIS_CDB_CMD_QUERY_STATUS		= 0x0000,
 	ETHTOOL_CMIS_CDB_CMD_MODULE_FEATURES		= 0x0040,
+	ETHTOOL_CMIS_CDB_CMD_FW_MANAGMENT_FEATURES	= 0x0041,
+	ETHTOOL_CMIS_CDB_CMD_START_FW_DOWNLOAD		= 0x0101,
+	ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_LPL		= 0x0103,
+	ETHTOOL_CMIS_CDB_CMD_COMPLETE_FW_DOWNLOAD	= 0x0107,
+	ETHTOOL_CMIS_CDB_CMD_RUN_FW_IMAGE		= 0x0109,
+	ETHTOOL_CMIS_CDB_CMD_COMMIT_FW_IMAGE		= 0x010A,
 };
 
 /**
@@ -47,6 +53,7 @@ struct ethtool_cmis_cdb_request {
 
 #define CDB_F_COMPLETION_VALID		BIT(0)
 #define CDB_F_STATUS_VALID		BIT(1)
+#define CDB_F_MODULE_STATE_VALID	BIT(2)
 
 /**
  * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
new file mode 100644
index 000000000000..ae4b4b28a601
--- /dev/null
+++ b/net/ethtool/cmis_fw_update.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/ethtool.h>
+#include <linux/firmware.h>
+
+#include "common.h"
+#include "module_fw.h"
+#include "cmis.h"
+
+struct cmis_fw_update_fw_mng_features {
+	u8	start_cmd_payload_size;
+	u16	max_duration_start;
+	u16	max_duration_write;
+	u16	max_duration_complete;
+};
+
+/* See section 9.4.2 "CMD 0041h: Firmware Management Features" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_fw_mng_features_rpl is a structured layout of the flat
+ * array, ethtool_cmis_cdb_rpl::payload.
+ */
+struct cmis_cdb_fw_mng_features_rpl {
+	u8	resv1;
+	u8	resv2;
+	u8	start_cmd_payload_size;
+	u8	resv3;
+	u8	read_write_len_ext;
+	u8	write_mechanism;
+	u8	resv4;
+	u8	resv5;
+	__be16	max_duration_start;
+	__be16	resv6;
+	__be16	max_duration_write;
+	__be16	max_duration_complete;
+	__be16	resv7;
+};
+
+#define CMIS_CDB_FW_WRITE_MECHANISM_LPL	0x01
+
+static int
+cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
+				   struct net_device *dev,
+				   struct cmis_fw_update_fw_mng_features *fw_mng,
+				   struct ethnl_module_fw_flash_ntf_params *ntf_params)
+{
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	struct cmis_cdb_fw_mng_features_rpl *rpl;
+	u8 flags = CDB_F_STATUS_VALID;
+	int err;
+
+	ethtool_cmis_cdb_check_completion_flag(cdb->cmis_rev, &flags);
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_FW_MANAGMENT_FEATURES,
+				      NULL, 0, cdb->max_completion_time,
+				      cdb->read_write_len_ext, 1000,
+				      sizeof(*rpl), flags);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0) {
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "FW Management Features command failed",
+					      args.err_msg);
+		return err;
+	}
+
+	rpl = (struct cmis_cdb_fw_mng_features_rpl *)args.req.payload;
+	if (!(rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL)) {
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Write LPL is not supported",
+					      NULL);
+		return  -EOPNOTSUPP;
+	}
+
+	/* Above, we used read_write_len_ext that we got from CDB
+	 * advertisement. Update it with the value that we got from module
+	 * features query, which is specific for Firmware Management Commands
+	 * (IDs 0100h-01FFh).
+	 */
+	cdb->read_write_len_ext = rpl->read_write_len_ext;
+	fw_mng->start_cmd_payload_size = rpl->start_cmd_payload_size;
+	fw_mng->max_duration_start = be16_to_cpu(rpl->max_duration_start);
+	fw_mng->max_duration_write = be16_to_cpu(rpl->max_duration_write);
+	fw_mng->max_duration_complete = be16_to_cpu(rpl->max_duration_complete);
+
+	return 0;
+}
+
+/* See section 9.7.2 "CMD 0101h: Start Firmware Download" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_start_fw_download_pl is a structured layout of the
+ * flat array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_start_fw_download_pl {
+	__struct_group(cmis_cdb_start_fw_download_pl_h, head, /* no attrs */,
+			__be32	image_size;
+			__be32	resv1;
+	);
+	u8 vendor_data[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH -
+		sizeof(struct cmis_cdb_start_fw_download_pl_h)];
+};
+
+static int
+cmis_fw_update_start_download(struct ethtool_cmis_cdb *cdb,
+			      struct ethtool_cmis_fw_update_params *fw_update,
+			      struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	u8 vendor_data_size = fw_mng->start_cmd_payload_size;
+	struct cmis_cdb_start_fw_download_pl pl = {};
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	u8 lpl_len;
+	int err;
+
+	pl.image_size = cpu_to_be32(fw_update->fw->size);
+	memcpy(pl.vendor_data, fw_update->fw->data, vendor_data_size);
+
+	lpl_len = offsetof(struct cmis_cdb_start_fw_download_pl,
+			   vendor_data[vendor_data_size]);
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_START_FW_DOWNLOAD,
+				      (u8 *)&pl, lpl_len,
+				      fw_mng->max_duration_start,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(fw_update->dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(fw_update->dev,
+					      &fw_update->ntf_params,
+					      "Start FW download command failed",
+					      args.err_msg);
+
+	return err;
+}
+
+/* See section 9.7.4 "CMD 0103h: Write Firmware Block LPL" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_write_fw_block_lpl_pl is a structured layout of the
+ * flat array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_write_fw_block_lpl_pl {
+	__be32	block_address;
+	u8 fw_block[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH - sizeof(__be32)];
+};
+
+static int
+cmis_fw_update_write_image(struct ethtool_cmis_cdb *cdb,
+			   struct ethtool_cmis_fw_update_params *fw_update,
+			   struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	u8 start = fw_mng->start_cmd_payload_size;
+	u32 offset, max_block_size, max_lpl_len;
+	u32 image_size = fw_update->fw->size;
+	int err;
+
+	max_lpl_len = min_t(u32,
+			    ethtool_cmis_get_max_payload_size(cdb->read_write_len_ext),
+			    ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH);
+	max_block_size =
+		max_lpl_len - sizeof_field(struct cmis_cdb_write_fw_block_lpl_pl,
+					   block_address);
+
+	for (offset = start; offset < image_size; offset += max_block_size) {
+		struct cmis_cdb_write_fw_block_lpl_pl pl = {
+			.block_address = cpu_to_be32(offset - start),
+		};
+		struct ethtool_cmis_cdb_cmd_args args = {};
+		u32 block_size, lpl_len;
+
+		ethnl_module_fw_flash_ntf_in_progress(fw_update->dev,
+						      &fw_update->ntf_params,
+						      offset - start,
+						      image_size);
+		block_size = min_t(u32, max_block_size, image_size - offset);
+		memcpy(pl.fw_block, &fw_update->fw->data[offset], block_size);
+		lpl_len = block_size +
+			sizeof_field(struct cmis_cdb_write_fw_block_lpl_pl,
+				     block_address);
+
+		ethtool_cmis_cdb_compose_args(&args,
+					      ETHTOOL_CMIS_CDB_CMD_WRITE_FW_BLOCK_LPL,
+					      (u8 *)&pl, lpl_len,
+					      fw_mng->max_duration_write,
+					      cdb->read_write_len_ext, 1, 0,
+					      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+		err = ethtool_cmis_cdb_execute_cmd(fw_update->dev, &args);
+		if (err < 0) {
+			ethnl_module_fw_flash_ntf_err(fw_update->dev,
+						      &fw_update->ntf_params,
+						      "Write FW block LPL command failed",
+						      args.err_msg);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int
+cmis_fw_update_complete_download(struct ethtool_cmis_cdb *cdb,
+				 struct net_device *dev,
+				 struct cmis_fw_update_fw_mng_features *fw_mng,
+				 struct ethnl_module_fw_flash_ntf_params *ntf_params)
+{
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_COMPLETE_FW_DOWNLOAD,
+				      NULL, 0, fw_mng->max_duration_complete,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Complete FW download command failed",
+					      args.err_msg);
+
+	return err;
+}
+
+static int
+cmis_fw_update_download_image(struct ethtool_cmis_cdb *cdb,
+			      struct ethtool_cmis_fw_update_params *fw_update,
+			      struct cmis_fw_update_fw_mng_features *fw_mng)
+{
+	int err;
+
+	err = cmis_fw_update_start_download(cdb, fw_update, fw_mng);
+	if (err < 0)
+		return err;
+
+	err = cmis_fw_update_write_image(cdb, fw_update, fw_mng);
+	if (err < 0)
+		return err;
+
+	err = cmis_fw_update_complete_download(cdb, fw_update->dev, fw_mng,
+					       &fw_update->ntf_params);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+enum {
+	CMIS_MODULE_LOW_PWR	= 1,
+	CMIS_MODULE_READY	= 3,
+};
+
+static bool module_is_ready(u8 data)
+{
+	u8 state = (data >> 1) & 7;
+
+	return state == CMIS_MODULE_READY || state == CMIS_MODULE_LOW_PWR;
+}
+
+#define CMIS_MODULE_READY_MAX_DURATION_MSEC	1000
+#define CMIS_MODULE_STATE_OFFSET		3
+
+static int
+cmis_fw_update_wait_for_module_state(struct net_device *dev, u8 flags)
+{
+	u8 state;
+
+	return ethtool_cmis_wait_for_cond(dev, flags, CDB_F_MODULE_STATE_VALID,
+					  CMIS_MODULE_READY_MAX_DURATION_MSEC,
+					  CMIS_MODULE_STATE_OFFSET,
+					  module_is_ready, NULL, &state);
+}
+
+/* See section 9.7.10 "CMD 0109h: Run Firmware Image" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_run_fw_image_pl is a structured layout of the flat
+ * array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_run_fw_image_pl {
+	u8 resv1;
+	u8 image_to_run;
+	u16 delay_to_reset;
+};
+
+static int
+cmis_fw_update_run_image(struct ethtool_cmis_cdb *cdb, struct net_device *dev,
+			 struct ethnl_module_fw_flash_ntf_params *ntf_params)
+{
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	struct cmis_cdb_run_fw_image_pl pl = {0};
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args, ETHTOOL_CMIS_CDB_CMD_RUN_FW_IMAGE,
+				      (u8 *)&pl, sizeof(pl),
+				      cdb->max_completion_time,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_MODULE_STATE_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0) {
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Run image command failed",
+					      args.err_msg);
+		return err;
+	}
+
+	err = cmis_fw_update_wait_for_module_state(dev, args.flags);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Module is not ready on time after reset",
+					      NULL);
+
+	return err;
+}
+
+static int
+cmis_fw_update_commit_image(struct ethtool_cmis_cdb *cdb,
+			    struct net_device *dev,
+			    struct ethnl_module_fw_flash_ntf_params *ntf_params)
+{
+	struct ethtool_cmis_cdb_cmd_args args = {};
+	int err;
+
+	ethtool_cmis_cdb_compose_args(&args,
+				      ETHTOOL_CMIS_CDB_CMD_COMMIT_FW_IMAGE,
+				      NULL, 0, cdb->max_completion_time,
+				      cdb->read_write_len_ext, 1000, 0,
+				      CDB_F_COMPLETION_VALID | CDB_F_STATUS_VALID);
+
+	err = ethtool_cmis_cdb_execute_cmd(dev, &args);
+	if (err < 0)
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Commit image command failed",
+					      args.err_msg);
+
+	return err;
+}
+
+static int cmis_fw_update_reset(struct net_device *dev)
+{
+	__u32 reset_data = ETH_RESET_PHY;
+
+	return dev->ethtool_ops->reset(dev, &reset_data);
+}
+
+void
+ethtool_cmis_fw_update(struct ethtool_cmis_fw_update_params *fw_update)
+{
+	struct ethnl_module_fw_flash_ntf_params *ntf_params =
+						&fw_update->ntf_params;
+	struct cmis_fw_update_fw_mng_features fw_mng = {0};
+	struct net_device *dev = fw_update->dev;
+	struct ethtool_cmis_cdb *cdb;
+	int err;
+
+	cdb = ethtool_cmis_cdb_init(dev, &fw_update->params, ntf_params);
+	if (IS_ERR(cdb))
+		goto err_send_ntf;
+
+	ethnl_module_fw_flash_ntf_start(dev, ntf_params);
+
+	err = cmis_fw_update_fw_mng_features_get(cdb, dev, &fw_mng, ntf_params);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	err = cmis_fw_update_download_image(cdb, fw_update, &fw_mng);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	err = cmis_fw_update_run_image(cdb, dev, ntf_params);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	/* The CDB command "Run Firmware Image" resets the firmware, so the new
+	 * one might have different settings.
+	 * Free the old CDB instance, and init a new one.
+	 */
+	ethtool_cmis_cdb_fini(cdb);
+
+	cdb = ethtool_cmis_cdb_init(dev, &fw_update->params, ntf_params);
+	if (IS_ERR(cdb))
+		goto err_send_ntf;
+
+	err = cmis_fw_update_commit_image(cdb, dev, ntf_params);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	err = cmis_fw_update_reset(dev);
+	if (err < 0)
+		goto err_cdb_fini;
+
+	ethnl_module_fw_flash_ntf_complete(dev, ntf_params);
+	ethtool_cmis_cdb_fini(cdb);
+	return;
+
+err_cdb_fini:
+	ethtool_cmis_cdb_fini(cdb);
+err_send_ntf:
+	ethnl_module_fw_flash_ntf_err(dev, ntf_params, NULL, NULL);
+}
diff --git a/net/ethtool/module_fw.h b/net/ethtool/module_fw.h
index 6c86d05ab6cf..d0fc2529b60e 100644
--- a/net/ethtool/module_fw.h
+++ b/net/ethtool/module_fw.h
@@ -25,6 +25,35 @@ struct ethtool_module_fw_flash_params {
 	u8 password_valid:1;
 };
 
+/**
+ * struct ethtool_cmis_fw_update_params - CMIS firmware update specific
+ *						parameters
+ * @dev: Pointer to the net_device to be flashed.
+ * @params: Module firmware flashing parameters.
+ * @ntf_params: Module firmware flashing notification parameters.
+ * @fw: Firmware to flash.
+ */
+struct ethtool_cmis_fw_update_params {
+	struct net_device *dev;
+	struct ethtool_module_fw_flash_params params;
+	struct ethnl_module_fw_flash_ntf_params ntf_params;
+	const struct firmware *fw;
+};
+
+/**
+ * struct ethtool_module_fw_flash - module firmware flashing
+ * @list: List node for &module_fw_flash_work_list.
+ * @dev_tracker: Refcount tracker for @dev.
+ * @work: The flashing firmware work.
+ * @fw_update: CMIS firmware update specific parameters.
+ */
+struct ethtool_module_fw_flash {
+	struct list_head list;
+	netdevice_tracker dev_tracker;
+	struct work_struct work;
+	struct ethtool_cmis_fw_update_params fw_update;
+};
+
 void
 ethnl_module_fw_flash_ntf_err(struct net_device *dev,
 			      struct ethnl_module_fw_flash_ntf_params *params,
@@ -39,3 +68,5 @@ void
 ethnl_module_fw_flash_ntf_in_progress(struct net_device *dev,
 				      struct ethnl_module_fw_flash_ntf_params *params,
 				      u64 done, u64 total);
+
+void ethtool_cmis_fw_update(struct ethtool_cmis_fw_update_params *params);
-- 
2.45.0


