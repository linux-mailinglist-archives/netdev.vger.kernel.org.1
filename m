Return-Path: <netdev+bounces-117472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA394E104
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 14:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B10C1C20BC9
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E8742A84;
	Sun, 11 Aug 2024 12:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OwesAKsP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4211CB8
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723377631; cv=fail; b=V4UUkR1VcOoTDYrB0O2Oa3c5NO90h5vpdz3UO3XNTgN7sH8WcT7jK2kv8QIn9iYtLa2gN+kx+KbhGmATi1qQSKFnArAtVrdnfxtsWeV6NIhLsxhLWpkWWGVC6IosISeRbF/U9S9rCLclPGEzHjX3eIAiesYt2k+DwH985w4ms48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723377631; c=relaxed/simple;
	bh=ypvifXDD6K+3EHUJ6OuNtvvPC7HxBCEQ0quwT1CtscE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=upV8YZNMcmoWE+Arl4iLoizEn/c9erw6wAtcP9L5qMnBkieJLOujWnnoeG/ApzdGhJEVbNQenbJfWDeQjjtWa2FXngGCtMPCW1trD8fvwzGuJcUUpp1bA+0uJIZifJSm6OBqWUY5XRR7wPRMpSiw+iedNPZF4miQ67UqAiIPXPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OwesAKsP; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M88aoJP+1v/kocveiopr9cvCSBJ8KOv4InRMUvCxLNxm8H/mENx0IcZ3vEc4a1BCbb0o5p7VdMOC/rP92F4D/rWTfg9yK7kd7gdSXDYOoHG8G+IhW4uVqR4b6Cx77Ohxd6hXX74Co7qjyUx1DCaxjbpE/dP86ej13zwfAFHvm7rsM+ohzxfdxOQedtd0IMglUXa6U18zx33+x5SJl+4uGeS0R1cTpUN63DgZ0Bg0PaBP0j342y0ChxLJkGNXNLZRDo4mi2QRIFiBspmpfVwRpkpAkcUzuFTP4p0ikwYdz81g2Y5tRRvj/vY+tRzBxJ5xzmeHTf/pgSSX5GqXwBSYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DICkl5y956lOBp5s5ApQVIfhzAOcm+r59oMg5hEwjE=;
 b=sdx02RtSlnVnsToQVvQoJahKFM6V84DPETqg3Oy0KhJ4faVHe2rFQH2hC0vLiQQWxiLj7DpTW/ypHYvcvuwCDFj0nlJ962oC4HytO3oTJg7NgCm/SgbuSiaa9/bxf6wM0cnBUdeRfHVoilS5uZZFiPI85RXNJK4lDhdV96oie/1sa9sxKA/6G04lG7iemK+4EsJCpErpZ5M2eNw3SQQ2do32AQp+jRyF3fA1iGCn71W3ikMmyjNHzSdyLiypMosIb7kr/PEhI3zQwc7/utIGzGJ8lNNJ+o3JnzJPTGJEqpNVvrmPVqdn1N3Z2y/kpY4ayU3kyESyLwnafrzvrMZv7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DICkl5y956lOBp5s5ApQVIfhzAOcm+r59oMg5hEwjE=;
 b=OwesAKsPic65S/tCSQkrQveJOY2tFFFeHrBFJJRaiXWE5qc55FNSkSPB03MsqN1HZ7tSnZjtGyN5E1DJPfnJn3kdyZ6SeWcu1O/c5UTHB4sGcSCYShJjhby4C2CMFMx1L27bvcWO2F0Wrms3RCYrVmx2t/D6gq9/WQ/X7MQnJIrbjsgNSRTM5d/ep2mh2Uwr2iIhpSf2O51HrpJpOO+Ro9jUjw3hwI29Nti7e0KBExIK146E+qoNc+C4Dpu7HghpRl0HUxpW5V5w01sI3fLtphWwPsxE4QquxJ7Bs77vVby7w17DijMYe9O+xtNZF298Xr3QUzoie0HyWFigg/En0A==
Received: from BN0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:408:e6::13)
 by MW4PR12MB5626.namprd12.prod.outlook.com (2603:10b6:303:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sun, 11 Aug
 2024 12:00:21 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::38) by BN0PR03CA0008.outlook.office365.com
 (2603:10b6:408:e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Sun, 11 Aug 2024 12:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Sun, 11 Aug 2024 12:00:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 Aug
 2024 05:00:06 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 11 Aug 2024 05:00:04 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 2/3] cmis: Print CDB messaging support advertisement
Date: Sun, 11 Aug 2024 14:59:47 +0300
Message-ID: <20240811115948.3335883-3-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|MW4PR12MB5626:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2f2794-8d02-4318-41aa-08dcb9fd2cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BMyiEIjo3aTpBx8jIqTvUEXcQLPBfTVl95KHk9rYCP41/Y5E6YFuP5zesOSb?=
 =?us-ascii?Q?Te7Hue6ysOpCPPd+gaGQ9fgNb/0Lc1XOLyW5Q6PCmYQspKnx3zMyzaj3JzNI?=
 =?us-ascii?Q?gom3Kn2Gfc7uosIhETwVThGpLn77p01TFFvM2AbaAn6Y61J3lVrHBX8i7O3P?=
 =?us-ascii?Q?7muct4xJV3cLzZsqC4XY7Q0Y93ZYk6tTW+k3tuR3RIHjZAxA4i8X3H50RnHS?=
 =?us-ascii?Q?2Bp5RGC0cRmUITwcx6Nmuv1IaE0oB2qY7GaB9TjYXHmHq2Js8TQfKz1xh7YY?=
 =?us-ascii?Q?R/LYdIvwwNRHjmcJzkE5hBprFlsLHLaVSeBFS6yUHRFoMS6MJRiIabP2C8W1?=
 =?us-ascii?Q?uTFtGzssTNHcqJygSkPEG33xivoPVDg+cQEW5OpdHBO7hJOe2Bf4llEfCpjr?=
 =?us-ascii?Q?JXyKLdtwrxCohXimS4RDNguUuMskAR0OWt2YTFRaN4m0Zx7iEGb9J/crvw74?=
 =?us-ascii?Q?+XMuI71IXNkecIT2JNw6tF5DHsNouvAF5OtbZ32CmNiIR/qe8XZ4xGddf65R?=
 =?us-ascii?Q?FVghlY4lXFc8KSQuJ3jO1FFKuNeLMOyVJMfqL+m685ZnTyz2fZX5lA4rJSRb?=
 =?us-ascii?Q?Ngi6RYwAm9shHumSzCqHmYoO4+97LurpF4zRoLwCGcCQ/EPHNR/kbTuVO/oK?=
 =?us-ascii?Q?oQzU9bhgRpzzjJF4PhwX9ayNkLsy6/Dq5V4MU/znmBbymYlCK14ULXCoAtB3?=
 =?us-ascii?Q?PdVfAjMda4pn0A6jtnZRPoQeO83GiWcRX9/k+DYz9J2nFPHTPPcR5+J4zHoV?=
 =?us-ascii?Q?y55teqxGJjl5dcBo2uKznLw5aWinLeJJZkmus2wam0bSN4qyJzZ0v/Wnl0Be?=
 =?us-ascii?Q?1Qb+wGZq3uclHti8+qvkBD8AlhGYN5OoLN1x9roejtoZVk2tRhhW2AKJ0BvU?=
 =?us-ascii?Q?DgOO8gsghrldDyLTbfwSC6GJe4KrGyCNb+gB4i+mW4rc+g1Rk1jI2MasgbWU?=
 =?us-ascii?Q?Zeiykn7VCBOtmnoipWgE9l/aviUasimQ4XEWq8oWPIVU7KeEg2r5uv5ONUy1?=
 =?us-ascii?Q?b27DEVLhFqs/Byi3wjiWmuJfrKODGWrl9HrNdWSzDUgC/lUxEwMIrqTVHElW?=
 =?us-ascii?Q?x3S3OVQwkTgpZaKBE6JqwhIJw8HXY8WmsWMIPDfmlHY+EyySc2zOTRuGZRHG?=
 =?us-ascii?Q?EjHqHHAbL4qoZGsK5i6SWdKtqnyTUn9LXdmbkUZ4hNV6zEWhM/ELPwtV7TAV?=
 =?us-ascii?Q?7YdpHxTUGKiGviMFCgSpC9WYWpXdAx/ypusJMa7gqljTe6cNTUv/3XpJcY74?=
 =?us-ascii?Q?Gdv1BKdS6sE4ekXj2c9hEV/YUOuKrFXFDG0wAVJROHWX9zz9N9ypy3PuWar6?=
 =?us-ascii?Q?6dvDzwXYd9wnyoYpXrXIUuaFLC8/ZP48PjCbmOtF4a5elVcBTfdn6DVYT3kV?=
 =?us-ascii?Q?VUmXdL30FGAEK0UgJGWe8i6G2pP0X9xUNfli3HC2NYIZyJGNxuj6zK7dltIE?=
 =?us-ascii?Q?9SCeXaLTL1ULFZsIYDK9Nqj0a6A7rzSm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 12:00:20.6176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2f2794-8d02-4318-41aa-08dcb9fd2cbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5626

From: Ido Schimmel <idosch@nvidia.com>

Parse and print CDB messaging support advertisement information to aid
in debugging CDB related problems. Example output:

 # ethtool -m swp23
 Identifier                                : 0x18 (QSFP-DD Double Density 8X Pluggable Transceiver (INF-8628))
 [...]
 CDB instances                             : 1
 CDB background mode                       : Supported
 CDB EPL pages                             : 0
 CDB Maximum EPL RW length                 : 128
 CDB Maximum LPL RW length                 : 128
 CDB trigger method                        : Single write

Fields that are not used by the CDB code in the kernel are not printed,
but can be added in the future, when needed.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 cmis.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cmis.h | 11 ++++++++
 2 files changed, 91 insertions(+)

diff --git a/cmis.c b/cmis.c
index bbbbb47..6fe5dfb 100644
--- a/cmis.c
+++ b/cmis.c
@@ -928,6 +928,85 @@ static void cmis_show_fw_version(const struct cmis_memory_map *map)
 	cmis_show_fw_inactive_version(map);
 }
 
+static u8 cmis_cdb_instances_get(const struct cmis_memory_map *map)
+{
+	return (map->page_01h[CMIS_CDB_ADVER_OFFSET] &
+		CMIS_CDB_ADVER_INSTANCES_MASK) >> 6;
+}
+
+static bool cmis_cdb_is_supported(const struct cmis_memory_map *map)
+{
+	__u8 cdb_instances = cmis_cdb_instances_get(map);
+
+	/* Up to two CDB instances are supported. */
+	return cdb_instances == 1 || cdb_instances == 2;
+}
+
+static void cmis_show_cdb_instances(const struct cmis_memory_map *map)
+{
+	__u8 cdb_instances = cmis_cdb_instances_get(map);
+
+	printf("\t%-41s : %u\n", "CDB instances", cdb_instances);
+}
+
+static void cmis_show_cdb_mode(const struct cmis_memory_map *map)
+{
+	__u8 mode = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
+		    CMIS_CDB_ADVER_MODE_MASK;
+
+	printf("\t%-41s : %s\n", "CDB background mode",
+	       mode ? "Supported" : "Not supported");
+}
+
+static void cmis_show_cdb_epl_pages(const struct cmis_memory_map *map)
+{
+	__u8 epl_pages = map->page_01h[CMIS_CDB_ADVER_OFFSET] &
+			 CMIS_CDB_ADVER_EPL_MASK;
+
+	printf("\t%-41s : %u\n", "CDB EPL pages", epl_pages);
+}
+
+static void cmis_show_cdb_rw_len(const struct cmis_memory_map *map)
+{
+	__u16 rw_len = map->page_01h[CMIS_CDB_ADVER_RW_LEN_OFFSET];
+
+	/* Maximum read / write length for CDB EPL pages and the LPL page in
+	 * units of 8 bytes, in addition to the minimum 8 bytes.
+	 */
+	rw_len = (rw_len + 1) * 8;
+	printf("\t%-41s : %u\n", "CDB Maximum EPL RW length", rw_len);
+	printf("\t%-41s : %u\n", "CDB Maximum LPL RW length",
+	       rw_len > CMIS_PAGE_SIZE ? CMIS_PAGE_SIZE : rw_len);
+}
+
+static void cmis_show_cdb_trigger(const struct cmis_memory_map *map)
+{
+	__u8 trigger = map->page_01h[CMIS_CDB_ADVER_TRIGGER_OFFSET] &
+		       CMIS_CDB_ADVER_TRIGGER_MASK;
+
+	/* Whether a CDB command can be triggered in a single write to the LPL
+	 * page, or by multiple writes ending with the writing of the CDB
+	 * Command Code (CMDID).
+	 */
+	printf("\t%-41s : %s\n", "CDB trigger method",
+	       trigger ? "Single write" : "Multiple writes");
+}
+
+/* Print CDB messaging support advertisement. Relevant documents:
+ * [1] CMIS Rev. 5, page 133, section 8.4.11
+ */
+static void cmis_show_cdb_adver(const struct cmis_memory_map *map)
+{
+	if (!map->page_01h || !cmis_cdb_is_supported(map))
+		return;
+
+	cmis_show_cdb_instances(map);
+	cmis_show_cdb_mode(map);
+	cmis_show_cdb_epl_pages(map);
+	cmis_show_cdb_rw_len(map);
+	cmis_show_cdb_trigger(map);
+}
+
 static void cmis_show_all_common(const struct cmis_memory_map *map)
 {
 	cmis_show_identifier(map);
@@ -945,6 +1024,7 @@ static void cmis_show_all_common(const struct cmis_memory_map *map)
 	cmis_show_mod_lvl_controls(map);
 	cmis_show_dom(map);
 	cmis_show_fw_version(map);
+	cmis_show_cdb_adver(map);
 }
 
 static void cmis_memory_map_init_buf(struct cmis_memory_map *map,
diff --git a/cmis.h b/cmis.h
index 3015c54..cee2a38 100644
--- a/cmis.h
+++ b/cmis.h
@@ -191,6 +191,17 @@
 #define CMIS_SIG_INTEG_TX_OFFSET		0xA1
 #define CMIS_SIG_INTEG_RX_OFFSET		0xA2
 
+/* CDB Messaging Support Advertisement */
+#define CMIS_CDB_ADVER_OFFSET			0xA3
+#define CMIS_CDB_ADVER_INSTANCES_MASK		0xC0
+#define CMIS_CDB_ADVER_MODE_MASK		0x20
+#define CMIS_CDB_ADVER_EPL_MASK			0x0F
+
+#define CMIS_CDB_ADVER_RW_LEN_OFFSET		0xA4
+
+#define CMIS_CDB_ADVER_TRIGGER_OFFSET		0xA5
+#define CMIS_CDB_ADVER_TRIGGER_MASK		0x80
+
 /*-----------------------------------------------------------------------
  * Upper Memory Page 0x02: Optional Page that informs about module-defined
  * thresholds for module-level and lane-specific threshold crossing monitors.
-- 
2.45.0


