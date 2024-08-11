Return-Path: <netdev+bounces-117471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C21894E103
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 14:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1AC1F213D4
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB93482DD;
	Sun, 11 Aug 2024 12:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S2+vE1og"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E233991
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723377622; cv=fail; b=eM71nVFCSqek4BIAnu/oe3BOC8zT7HjqDq6EzD7vCtVf/6HRlfmt/5kCoaebTEtmPHjvCQrDGotWCmVIIp4B+xS3brFC2N8ERKREuayXjBHgKBZ+pdp/KlBxC1ypPYGiygmunUeSW+obteA7FvSasSK2iQ9nfzSMa567LILzY1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723377622; c=relaxed/simple;
	bh=NQf3Y4aX3tmM1sLMXhVSGOv3+NeMSwsZRAdERLUTkFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rc5Y4nX9+gWDpZFQD8v1/ybyHOZNYelVtuuj56SBPKTf3Xxgsw1vgZzZ6+QYBlcMQznlQw/Qu7fYyGNjHuqhzxf64R6vijiD3XvanizIALPcRr8u2RG0tXlqxbOP+wUGa5yEiuKZgiCE/5NyCt5p0cobTZuzoWlS2OrE+qglZXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S2+vE1og; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEJTs8kDJYPFrUrRs+78vi9r2xj6X+IIWriYeOMlaVEUtiFYGZ8ascHNODW1xlhS50i7IWz2B6QXTw3X28x9fQwE3hlqYRWx7FSRvuISHjssnKRQ3zA6JZodGotIF/Ui6n90c1Bhh4BPFSaoO0ql8JlgtMawxbizA1I+MTu9bFohtmAeUKibpfOhjwZiPYw12KnB1/xN2Tu1NuOB0KgCSmnCShMZtjk8HtzOd9+fdsWTtQ5Wrmql3b60m4RuoWkyAa6cGyfjGJmtJKSQeU/XRA/WDhVej0PORiFkHXBUIJ8Z2E/rzyAw5xL6v/lga7+9Al600CHBFk9dqSjhVqd7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gJzY5GH5V/INJt/yqTN0CYscGjjAoIMJT0WBzukMoA=;
 b=RKZ76EmHGBSFe+roMVPv93LrefPyi8yf6Vc4tPPmJBWsH7gRFP5zK8vg+V0RGibqo3D1DlN4iz6m7H04AHf3CBAK/CtPTgf0pEOcMNZh21yeuv0DJe8VJJjscqNN60dnqVhuUbHuuXIH8wuXhGUWnoFOLZJAHQOoHkYAVDBb1gmp5E+uZOa9S6GRr5LXLc2yxBsEKjmmWPzEIjxO9zAStfhMSDz8SgkyVdKqJGYVwujEOC3DdsXaijZqoHrtuSAAp0bMMFAW6/yp36hdcTR/KfRTN4MvSKbzp3ciDBo34bfTuJhLGrp5y+1O68nO7oNWRbRRbCqwbha9MAbDD08F9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gJzY5GH5V/INJt/yqTN0CYscGjjAoIMJT0WBzukMoA=;
 b=S2+vE1oggxJkroavgf2J/Bjq0Z1qKJdY38Ool16YOekWZsmHhpASMSajPMj/6yUWDohpMKgquLaGIANfGx5/MN0jTljjsVqyEez3z6AwyhJtrtHS31Uu6ksRr3g2B7kfoJAQ70ZTJ4JDKAiy+dyf0CezAN3C7VtVJcO1Xf31/hSYZLqDUjE+AwV40cIIM1lsScDKXnH+P+Y/0rk+Mv3XwRgz5ujaR9gIkPmtMpinbbwlJw4CTQDyTklETGTPp06lzgj+kdqu0dWHR/7DFh419E1cf/qq7HUy4wTdzRKpTcB54J7RGYWVTdWdDk47YCHxoqtLXEWUR5gWkWEhaALN7g==
Received: from BN9PR03CA0381.namprd03.prod.outlook.com (2603:10b6:408:f7::26)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Sun, 11 Aug
 2024 12:00:17 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::25) by BN9PR03CA0381.outlook.office365.com
 (2603:10b6:408:f7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Sun, 11 Aug 2024 12:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Sun, 11 Aug 2024 12:00:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 Aug
 2024 05:00:04 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 11 Aug 2024 05:00:02 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 1/3] cmis: Print active and inactive firmware versions
Date: Sun, 11 Aug 2024 14:59:46 +0300
Message-ID: <20240811115948.3335883-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240811115948.3335883-1-danieller@nvidia.com>
References: <20240811115948.3335883-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: b310814d-33a9-42b2-6e8c-08dcb9fd2a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fbRzaNIm+kBRCJ1pq86pSQyxQSNfIIIt/k2ulSfbwQ9ZDOKip674JFFNKNy1?=
 =?us-ascii?Q?za8/Ewmcrw/l7i7MJKzNJr4Pyk3fMiT/wGuo0xTlOqHsBN/IMZkhl0unu4Bu?=
 =?us-ascii?Q?nwdfU9SG6Ih9LfqBocdoJp7T9U1AIczQM/axq3ctGegsXCJx9S7pljJAWpy5?=
 =?us-ascii?Q?HnyspnYTDhsjnphL4tvQA26WoLocQz+0ULJ6a+rJ1h6ozXjyDV9spmydeuKX?=
 =?us-ascii?Q?P4lGdPpE/la1wIFcTSFplRDcBmcpgUD8YP2YO59ZF7geT/7Vv2AJjJVcrrX4?=
 =?us-ascii?Q?7veYebyBLKldCUCo9fJ8rqoEc+JKLAdT8r5CX5dyqXkW6O8QPVvMZdP/GDA6?=
 =?us-ascii?Q?opT3AWijNkCwEkEtjHF+NO6Q1IzRxDfnT6zilfyxuGprNpILE4D8wXAnccs/?=
 =?us-ascii?Q?WtDnDc2wKYNOcH/vTUFcUzJFeKAZBuiLQC/WNkJNJ/O8279Tu1UP3u4uS4KT?=
 =?us-ascii?Q?/+ceLCXHmJFrSNXqAJ8sFlPuzH9KbpQfKCqBZ1s3dv0DRfw1PV/Qrw+VkcRL?=
 =?us-ascii?Q?aSwj8RMJpeuowH1k+zCieYajr8tMjeAd2GMBtQbUJHy/G2XhZU+KdSYWmqrQ?=
 =?us-ascii?Q?d8UsCLJNdWCgvn5sdLuCQ7L4i905I15UDTzqm1yooKy1FD2JsMg01BfXNyhQ?=
 =?us-ascii?Q?AY0r0KbL3hlsutMDCvIEwSciT0C92KCFiSRv+DfK7NYcvJ1J5x2FEcme1lOd?=
 =?us-ascii?Q?bne9cYXU0igUxKDECDB7pj6tseFRXpDcFGsJDNqoq2/DSjD4znH3TxgJpm/f?=
 =?us-ascii?Q?SlpGC5sHTrE6YFByAUff1wR7vUx5yhadWAtwyrTUXsyJsoD5MIYiwFN+f3kx?=
 =?us-ascii?Q?dL9cWb2yTkXxbaDVoMDljrRTSaKkqkFeYMxGXRtX9osTo2yLhZHdpjq3ZN38?=
 =?us-ascii?Q?r0rJEk8YaJmQ6kZN70zQTOVV+zUfHCDr+2WqDY2kpFnaM/KX0EcNrsHHiSR9?=
 =?us-ascii?Q?cLvtD3n4nz6uDpqI2xD1ue5ez31o7/6cqdGWUj08smln846qX1U+epVxHQku?=
 =?us-ascii?Q?OnOlvhtBd4p+10XsZdQ05xyEqM1q4K3hlRqX6ZvP1oD1bHSZ3P56JIczHzwV?=
 =?us-ascii?Q?CUA4hwDlrfjcx9L7oHPuwv/xYDBJGZGzI+KatpPkM82PrL8/G8W+qVdGfspd?=
 =?us-ascii?Q?6fT0Z/+axNwOJJH0nYk/WFL0gZaVaQ2mRlD9PMIFmPgez8GDO/X/iLboRtLh?=
 =?us-ascii?Q?hDc4P1K0U7hlbBf6uyNgiXkfq2YK0Is7wAUTp4BsMINIu70tR6FPr12yU6W2?=
 =?us-ascii?Q?cjWNJ1X785toCSEMNmpjmEp+FU1BfT9Qb2OVaAL+t9oDjIi8zo5ZwkQSptwF?=
 =?us-ascii?Q?Z8N0xE4o6cmMbXCuEVqWFr+9sEYUoFpl5BxyZqpqQlRNAHinLc/2VCr0s+O0?=
 =?us-ascii?Q?GhsKuxJUSxWOawHfct/u1gIzC8fE7eMx5g5cGrVduVNfKw/S+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 12:00:16.8913
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b310814d-33a9-42b2-6e8c-08dcb9fd2a8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

From: Ido Schimmel <idosch@nvidia.com>

Parse and print the active and inactive firmware versions from the CMIS
EEPROM dump. Example output:

 # ethtool -m swp23
 Identifier                                : 0x18 (QSFP-DD Double Density 8X Pluggable Transceiver (INF-8628))
 [...]
 Active firmware version                   : 2.6
 Inactive firmware version                 : 2.7

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 cmis.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 cmis.h |  8 ++++++++
 2 files changed, 53 insertions(+)

diff --git a/cmis.c b/cmis.c
index 531932e..bbbbb47 100644
--- a/cmis.c
+++ b/cmis.c
@@ -884,6 +884,50 @@ static void cmis_show_dom(const struct cmis_memory_map *map)
 		sff_show_thresholds(sd);
 }
 
+/* Print active and inactive firmware versions. Relevant documents:
+ * [1] CMIS Rev. 5, page 115, section 8.2.9, Table 8-14
+ * [2] CMIS Rev. 5, page 127, section 8.4.1, Table 8-37
+ */
+static void cmis_show_fw_version_common(const char *name, __u8 major,
+					__u8 minor)
+{
+	if (major == 0 && minor == 0) {
+		return;
+	} else if (major == 0xFF && minor == 0xFF) {
+		printf("\t%-41s : Invalid\n", name);
+		return;
+	}
+
+	printf("\t%-41s : %d.%d\n", name, major, minor);
+}
+
+static void cmis_show_fw_active_version(const struct cmis_memory_map *map)
+{
+	__u8 major = map->lower_memory[CMIS_MODULE_ACTIVE_FW_MAJOR_OFFSET];
+	__u8 minor = map->lower_memory[CMIS_MODULE_ACTIVE_FW_MINOR_OFFSET];
+
+	cmis_show_fw_version_common("Active firmware version", major, minor);
+}
+
+static void cmis_show_fw_inactive_version(const struct cmis_memory_map *map)
+{
+	__u8 major;
+	__u8 minor;
+
+	if (!map->page_01h)
+		return;
+
+	major = map->page_01h[CMIS_MODULE_INACTIVE_FW_MAJOR_OFFSET];
+	minor = map->page_01h[CMIS_MODULE_INACTIVE_FW_MINOR_OFFSET];
+	cmis_show_fw_version_common("Inactive firmware version", major, minor);
+}
+
+static void cmis_show_fw_version(const struct cmis_memory_map *map)
+{
+	cmis_show_fw_active_version(map);
+	cmis_show_fw_inactive_version(map);
+}
+
 static void cmis_show_all_common(const struct cmis_memory_map *map)
 {
 	cmis_show_identifier(map);
@@ -900,6 +944,7 @@ static void cmis_show_all_common(const struct cmis_memory_map *map)
 	cmis_show_mod_fault_cause(map);
 	cmis_show_mod_lvl_controls(map);
 	cmis_show_dom(map);
+	cmis_show_fw_version(map);
 }
 
 static void cmis_memory_map_init_buf(struct cmis_memory_map *map,
diff --git a/cmis.h b/cmis.h
index 8d66f92..3015c54 100644
--- a/cmis.h
+++ b/cmis.h
@@ -41,6 +41,10 @@
 #define CMIS_LOW_PWR_ALLOW_REQUEST_HW_MASK	0x40
 #define CMIS_LOW_PWR_REQUEST_SW_MASK		0x10
 
+/* Module Active Firmware Version (Page 0) */
+#define CMIS_MODULE_ACTIVE_FW_MAJOR_OFFSET	0x27
+#define CMIS_MODULE_ACTIVE_FW_MINOR_OFFSET	0x28
+
 /* Module Fault Information (Page 0) */
 #define CMIS_MODULE_FAULT_OFFSET		0x29
 #define CMIS_MODULE_FAULT_NO_FAULT		0x00
@@ -134,6 +138,10 @@
  * GlobalOffset = 2 * 0x80 + LocalOffset
  */
 
+/* Module Inactive Firmware Version (Page 1) */
+#define CMIS_MODULE_INACTIVE_FW_MAJOR_OFFSET	0x80
+#define CMIS_MODULE_INACTIVE_FW_MINOR_OFFSET	0x81
+
 /* Supported Link Length (Page 1) */
 #define CMIS_SMF_LEN_OFFSET			0x84
 #define CMIS_OM5_LEN_OFFSET			0x85
-- 
2.45.0


