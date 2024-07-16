Return-Path: <netdev+bounces-111751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C599493272F
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30FB1C229C3
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A243A19AD6A;
	Tue, 16 Jul 2024 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UO4TIDvt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063019AD4B
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135509; cv=fail; b=ooSd1a71h2bqLOJPiUsxlVGVabEGX2rr1fF3gnYSZYtWJKuWOPrCdW1WB2Rdidh/+GpPFLFPUp7A6pBuEc9UXSzu5RbP9JsVzBZH1NbpCogtor6s2/iF/4FiIJp7WLDvKIg1WVs6zwvFmjiJwQdjY/xlNHdy91fEAGKi5gNrP4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135509; c=relaxed/simple;
	bh=NQf3Y4aX3tmM1sLMXhVSGOv3+NeMSwsZRAdERLUTkFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvzTkwGLPn6zEeynPrIAUdLIWHfsIatmXGP1CbhIH9GWe3GECYcDIeetqgpfJ7atIeb5+IcoTUPA6y+g6uo7LSm+rMkdAPrKvgycjyyV5ba4GaBiQlVH4Z82GrOfhdJ3IrPElDoQJRrpuPWHGfw2KtIAmm10no7n8goC0MKfErU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UO4TIDvt; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOkqhzlhj6Kosos0pXnO7ujWKFDjiTmGdp+0EaA88wrVP/D+xB3/+yMgRfUHdw6G5/HpJ/Iod/orx1OTOwYtLmLT5ZIDWK6GQdPU8sEZkOaFtWly0EkJXlKGcwmiBSOHO2H7U6QZTcgUxqSE0V+ohE6GjDiGI7qWN+ZOC7rb/eTRlVGwVzu8QJxfqXDFwzKh62ccxK8wauiZk1cb2ZKYMm6CsvYVOz7mxh+7A0fwcAvUB0qOoJg+pMYr5weRgepXl82dW0uKhNrOMnXG+701BubkaeNC0Xpkeo6mum4hjM1onCjCisOvokatCJZerCpelCBi2Y3amtxuBkpOBleiPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gJzY5GH5V/INJt/yqTN0CYscGjjAoIMJT0WBzukMoA=;
 b=veQpAKJ8vjcin2RRtU+IxpykX0bcXjyHBCENa+s3a7Qkfj/5a8N8t5RizToTxxwPJYC0RLqpAsWe83TKBKF/3Hx06kjJZp5cPi+lXm1VlUeYP8vJ9aU2WI6siOvm9OlI+rTO3pqfU1YIucobg72BWBWalUTRzH5TLPzi924+QxeW8syTSASqCNewjPuGQRfMVEU0XO07pLDi5KhV+cGfx5hiYNAa7LAycNojKDaafVXwQi3KiItpqTgF8xej0W14Sj5cK3GaTaLgNiiTaj9eVNKD3eHmC/Bag308to/4T56hRQ/gZR/IhqLMH/nALlNHpudkSsrd02eGy+GdB+z2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gJzY5GH5V/INJt/yqTN0CYscGjjAoIMJT0WBzukMoA=;
 b=UO4TIDvt1JfImTsK2oTwgC65ey6h/dT9axkWd1iigzO66iBpiP7RVEZyUW/uvodMCwZHlRvRlUs/KTFjPi429BYfXMho4f+2Wi/2PeKjoPPuCuTGrvoQSITx+/yawzsT2RcH6EGefPUp+bW9tIeqidiuX7r7DmKRrY+I2A3E9zB3hwgGudGkw3DwXiE31XX2XnewL5zsSgd/mbehQae41QZKg/NUTmwrB6cQ88KNjuHwplQW9A5sc/N+JFtbUr9GLWje5lkk/6FVJ2oNq76hufoLpfSW7JLt+jcIQqCJ5n3wnk0P50uLXu6oDqeSfRiD8uW6JVsN8KRGWtBUeM7jJQ==
Received: from DM6PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:40::24) by
 SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.28; Tue, 16 Jul 2024 13:11:44 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::e6) by DM6PR03CA0011.outlook.office365.com
 (2603:10b6:5:40::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Tue, 16 Jul 2024 13:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Tue, 16 Jul 2024 13:11:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 16 Jul
 2024 06:11:28 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Jul 2024 06:11:26 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH ethtool-next 1/4] cmis: Print active and inactive firmware versions
Date: Tue, 16 Jul 2024 16:11:09 +0300
Message-ID: <20240716131112.2634572-2-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SN7PR12MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 78727eed-f65c-4be5-230d-08dca598d72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?707k0QyVX38sUyzk9cQwmkM9dxiF4/Y6XPli79Pk/c1SXI96ACqs6nJx6kUZ?=
 =?us-ascii?Q?RWVrX4yKMuWtxdInmOEZldO+mrl9ZdrHBzMyjFntS7EyCieWju5c6a+p0Kjq?=
 =?us-ascii?Q?DxJVOUxDyVjWM8TaIVPayAxd8aBiflQnILvgAJ6HNwIpx2qCLW/c1ybV6hNQ?=
 =?us-ascii?Q?kX4Ekfzuf7cnSm1VjsTKgu1CNQlaUp3iCTBqz8o3q/JLMBqdVIRkoHmzkvkD?=
 =?us-ascii?Q?4cgVYLPU2deqQjqJHWFpxIzpP1U4lLAypqjKp9sHDYckwmRKMuhooz24jOkw?=
 =?us-ascii?Q?AD76/RFvAsqmSRwgp5YfokErlXvOSjJV8O409gV9p1r/z3AbYPDLxqJS4QcE?=
 =?us-ascii?Q?SKzmq+j0Kx4w/6ALrQ4r6J0V4nxxyEU+KzTjmAp1tjudcDn1W04wWuA/37aV?=
 =?us-ascii?Q?fDJyrjiineyyKw+dA73IlmOu8qM5y9Y5TRBjAMFNhU5nJ7LeRWMaepsvCMvD?=
 =?us-ascii?Q?QvTFCb/E7srwyO+Df2liih0zzsQ1s2gUPGo3YyoaVmnAp8Fc/tZq9jnibVCL?=
 =?us-ascii?Q?wSHh1DzsK/NayN6tR2NS44yjxAhSq141NUQnC+DOWa7vxQDF0WHOKH04b9TA?=
 =?us-ascii?Q?9BO4WHNAiC2NO8qNVzazpLTlXS5FewIhvql03zzQ6vKL0dx3zz1FKhNLihFo?=
 =?us-ascii?Q?D7lBpqNiHM/udMq6IjjpEPivA42Ym0/fymJqnxTkkd11tkMwItM3qtIkDvKU?=
 =?us-ascii?Q?Lf8sOBMzkPu8qD/FePdHdOXPR5rMqpFlHc236USgc973KfKq5wQWaHXflhDj?=
 =?us-ascii?Q?5OhB8Gy4x/R++bQ/NQrZDVvW4IgLKCaNInhN2EkH05RxRG2/XU7NUOrlsuhv?=
 =?us-ascii?Q?ZXJePc3HOKu/0dQO+l7aHmlyWIvlV0al4rH3bNBizOO/jKQ5yPecnZswQZro?=
 =?us-ascii?Q?KPU/G00D3sNj1Sq9pa4u4USo6pHftRolgo/9zjO4/BtD0WrY5m8uWHLe+7Cp?=
 =?us-ascii?Q?o8bk82MouuiB6cEd0h8ujVF35s6lsyMErdBw32C4xr9lKi7byXnEJXU/qlkJ?=
 =?us-ascii?Q?0WB3N+EAGnoPrhImIwY3NUgFs1NwHkYU0TJ2+Lbeg7ivBBvjOvL/oRCB5RSD?=
 =?us-ascii?Q?fC5i66qJydCnjmiob70//1mL0dPACRZf9Ztzg5hiNkfGbB1JXK1S8I0sCrAg?=
 =?us-ascii?Q?xUpy+cYczwKitivoceRElwU3lh4T3e3bvkTh7R3RSK/sARVjcyLnKIrbGBy9?=
 =?us-ascii?Q?PL3miySIToUnPbRweZ0WvtbYN8DdEiFGIesOGXlRUk5WtuWC9Erz+2EL55wP?=
 =?us-ascii?Q?2XtUrtoiKFc3VTzLeh8Nh5Itcw0e8ZrKCMA8sw9ZjnYuvzFBFzmfN6H2c0Wo?=
 =?us-ascii?Q?JA3TcBSuzL1zvlpd4scM/CJ5uB5GfUCZtDMBzCQQv6QlW3NNQcdZXHzwhBGk?=
 =?us-ascii?Q?WoJu8eCoa4zd15mwS3VicRaFRufsf/MSSSPTG72fT9V7t+MXOh6uphyzM0zF?=
 =?us-ascii?Q?P0p6K23l6zg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:11:44.2123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78727eed-f65c-4be5-230d-08dca598d72c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984

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


