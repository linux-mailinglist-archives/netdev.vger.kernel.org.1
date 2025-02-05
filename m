Return-Path: <netdev+bounces-163102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492F4A2956B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5D81674CD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929519068E;
	Wed,  5 Feb 2025 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nApj2/e/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26518DF64
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770930; cv=fail; b=jH/v09cdSrb6Abb977nAiEhCXjbTbC117ADoHPUkkVEhJDJ9iXwICiapxQkM1BLStQdVZkF8XvbDtgXjuBqxq/o+PRWjF9W4AN1oF5t17SopMNYqehFGlpg35rcrmkUBUrIeqMxg8C193d20wy8m4FW50lvw7pAMZzBxFy9korI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770930; c=relaxed/simple;
	bh=XDharbSpQhQtiPQcW2BQBIpwZhJAc3S4ufsSo698PVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1mwzbpRkIAtUNOh73xfOf29SMg1gKGuxbge4AigGaqgiuNOAtdhG2+oXa+BpfdirmLDEEHzGTJc3dVXJn7m1HiWPJ+YeE+xr1CZd8gBi/NkdI1DWUepWvS4oCg7HELtV+DDyB12naNYLCSUF8gadRo1geXdxRi/ycpj2fIMawE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nApj2/e/; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RU1OAJb65JVprOsFpuXRSBkTjJZ8u8FdJnmUPrWoHEcpjty6DHpo6MoUZ4NO3hMYq3JzpmLMRoBwp239gLWOEsMqZZYopoghaj+lJDAbgIlbsLnSq7peXsC38eQMlfFqrQ1b1l5ZIgryeis0hNkEX1/Xn8zQ8UeKKswHQtFpHb2Irf2RvGKben9SQr9XNDpr0utpv8IC8kkjgAu9STHmAwZlnevRatvyF/Mg2eQTBrztyGQZ1wDuzldWMXRK2rMMuyDLjvc/kn5DJrFhSsScPWdCsx21qaXrq++KNMtxInwnvGDu1fMsNP9LqUA0XyGQOGwwRrtdfHYTOXQL17iJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiL2+r9JXHgDjDoPXr9lnayjlJh8Bj0TcmiGAODIs8I=;
 b=vGeWH3xpHaLmmYEQvjfXCNmv52nhfdGanTNgZp2v3ZJtMNPZYQopPMJdDc3EnGGoiizT9We16jdB2bi4iJZ/YPamHvK5OtiyTWjt7xCoZsMoMPfzIbHbvT9QkAbLyR1nJ6Ihjy8GWFIxvvaqMgVV/nXjTy507lui7CxQcVzQODI3RvDcR/fuR0PgVkq/B+rOv8bDt2yUM7uei+XK04NaZgvd3ZCrTDcxqIRB0BDGTXoeJScf05Qhgr8NvIjb57DG/DTmhU2LEkWmOh+JBF10LOa+AA2DT5DMB343fCabOttsgOZZRC2xHr90MiOaThJ15tOckVZiFyKPoeqE4GAG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiL2+r9JXHgDjDoPXr9lnayjlJh8Bj0TcmiGAODIs8I=;
 b=nApj2/e/XKLH+EnYwuXnjlN1Q16CMN+hWEUA79LAzMBAbFLjX6DmjAZQH1X4SMLqutjB24P+tkdbMl9DD3MfmqzX0Asx15OkT1N9IKzX7nlmWSiih4u2GwPs04rQaymPHoqPNpZhmakQCznhyeN3LvIHYFVa+/O00H48rhgIvvpvsj0kUz60qtEyGQDM0Yyz/xHruWCLwNUQtjcRUvPsfRtmYkBHj5jmJdRf810kCS4DKMDLW2gmjwuW7PQwnGXUcIy0Vm/Lm018jf8MQsbpmI4ygRM7Bgv9bbGTiT63DdIcJiXyP6MuuSJCUrwpifTVq0iiwBCll7Gge7+pabFP9w==
Received: from BL1PR13CA0144.namprd13.prod.outlook.com (2603:10b6:208:2bb::29)
 by SN7PR12MB6957.namprd12.prod.outlook.com (2603:10b6:806:263::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 15:55:17 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::ae) by BL1PR13CA0144.outlook.office365.com
 (2603:10b6:208:2bb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 15:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:55:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:01 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:54:59 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 02/16] ethtool: Standardize Link Length field names across module types
Date: Wed, 5 Feb 2025 17:54:22 +0200
Message-ID: <20250205155436.1276904-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250205155436.1276904-1-danieller@nvidia.com>
References: <20250205155436.1276904-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SN7PR12MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c26f80f-3d84-4d6c-2911-08dd45fd7bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gIStDAF1OQJNobCgGx4E/VD/4/w4/AroPXZPvoKsgAcFL0BMfhE+Du4AWmja?=
 =?us-ascii?Q?OOiNJFfVPDSDZe7t3+ao1u48JLNG7sz4ILRny/VOq8m++xq7/AHCkwYcADOZ?=
 =?us-ascii?Q?TYqpXaNTKsg/rirepsoLsJY8idSdKiYasJY8vhs2Tc1jlKFndaoSQnEQ6OMl?=
 =?us-ascii?Q?8b+sKZ8H79aUQlY4x5faSWDKUogNmWXQ9WCfEbx6uiDYh2+ZDk4JywlIkOO8?=
 =?us-ascii?Q?EUH1RxwN5qp2Q0KbxaFEP68s6C8RIpDXBCcsel50z4mmL0Sv1Ebtw4002/JE?=
 =?us-ascii?Q?7c6uFx9Q6IbCyb46D/gHTONmvPSRBifzqugN1S+8+NjrBT7zoq0B5OIXHvcg?=
 =?us-ascii?Q?b4xEkccyUzBHo0B2rAnOCd7lPTc7WhzHfwJuwX/YAcJ/J99sc4Q9I9bUQlof?=
 =?us-ascii?Q?w9Yu67ik7CAjmrhUS1PvCqsl6HFyftDp/VXXiltl+tL2X98QquEl9L4LKJlK?=
 =?us-ascii?Q?wX38LCU183lZ02LIdkLi/lukCucZjXc7bQNzYG1aJqkflgfAYAU3gKjO4o05?=
 =?us-ascii?Q?v9aFlrmTtVN9rbn/76H4c4/ayudxh5Kq1ZdNpnxv/325OiO1UjLSkp6xbsGl?=
 =?us-ascii?Q?bg+MavYF6xDpgFc7jHyqF7JsGtsFsPaHbvyFc/xFrLft3961kda1dYBqMwNv?=
 =?us-ascii?Q?7NBEx3Z9wOur81cAbFgRv4XcJ+Z0o8erDWo60/k5sEl7NZuNMHbdRDccOSqR?=
 =?us-ascii?Q?lAloVk1gvfFS5bPH2p9aUw76xqx25M6mLuZutkA/XOaODdqVTcfCTl5c+iXW?=
 =?us-ascii?Q?y4ebl8zpToWJODbFdnd08P6RAJVHm6Ra4RZcj5ogYlFbnCkE52iYU3e6Au4F?=
 =?us-ascii?Q?hgXqrhUDklp6dTgw6gPfgl4Y7RdTY0PFqiu+YF0B2xJOaywhQdPkCJeJoAxf?=
 =?us-ascii?Q?K7WR8NJRdvSo1txBkCUzJYAjSkSzDDINDxQG0+2TRPlp2/vFqsJoKXySJIxX?=
 =?us-ascii?Q?OnVtV+pOhbtUWVYiKtw5jzeXmwSKTIprB9ioMEO8SQXLW+FGpqP657v2XEya?=
 =?us-ascii?Q?f6ksan8yC1Mx4CaCp9+4tv29TrARbCkoeeBdQXp7NrA+xCpKWb1n4aMqkn2p?=
 =?us-ascii?Q?ROWrIHH/hXTwt165ggPM3Nom23OkH4fpr9bAIIm47s8xb3IzyPlvR1WtAJpd?=
 =?us-ascii?Q?rptvp7ImmusOWQa3Tt9+ygd+YBVJuxBXYOkdqt6iIJAGuLDnhTdQCJIfr48h?=
 =?us-ascii?Q?uu/CAP7qnAXXm9ZDdH1nydokS7Wm7L8etZUKT3ylqq4gvmws7vmaT5O1xHfM?=
 =?us-ascii?Q?r0igElF9lV6XJgEW22DEvpA+VhaQhHPC9en2yh7ZW2GVFsX7TdwQCJ2QS/p6?=
 =?us-ascii?Q?/ZqBb2gt8fu2PakTp69BKBc6CBQAtEjILRVqwNxtE6P3IaCpxvEKMZ9/W2/W?=
 =?us-ascii?Q?DQ+I2h0EKboy1vrJIuqSEZMJ20P1CT/JnD695qlfVBhh0UTOp4ckvbspCHhP?=
 =?us-ascii?Q?Vxkf38pqBgWf3YcOPdhsyHEofZOPkJvrntDY9PmKoEFxsEQZmf2MFht8qAWI?=
 =?us-ascii?Q?JLGdWNbYH6n1dfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:16.3310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c26f80f-3d84-4d6c-2911-08dd45fd7bf5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6957

The 'Link Length' fields have inconsistent naming across different
module types.

To ensure consistency, especially with the upcoming JSON support for the
EEPROM dump, these field names should be aligned.

Standardize the Link Length fields across all module types.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v3:
    	* New patch.

 cmis.c  |  4 ++--
 qsfp.c  |  8 ++++----
 sfpid.c | 11 ++++++-----
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/cmis.c b/cmis.c
index 71f0745..5efafca 100644
--- a/cmis.c
+++ b/cmis.c
@@ -282,9 +282,9 @@ static void cmis_show_link_len(const struct cmis_memory_map *map)
 	module_show_value_with_unit(map->page_01h, CMIS_OM4_LEN_OFFSET,
 				    "Length (OM4)", 2, "m");
 	module_show_value_with_unit(map->page_01h, CMIS_OM3_LEN_OFFSET,
-				    "Length (OM3 50/125um)", 2, "m");
+				    "Length (OM3)", 2, "m");
 	module_show_value_with_unit(map->page_01h, CMIS_OM2_LEN_OFFSET,
-				    "Length (OM2 50/125um)", 1, "m");
+				    "Length (OM2)", 1, "m");
 }
 
 /**
diff --git a/qsfp.c b/qsfp.c
index 6d774f8..1aa75fd 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -736,13 +736,13 @@ static void sff8636_show_page_zero(const struct sff8636_memory_map *map)
 				    "BR, Nominal", 100, "Mbps");
 	sff8636_show_rate_identifier(map);
 	module_show_value_with_unit(map->page_00h, SFF8636_SM_LEN_OFFSET,
-				    "Length (SMF,km)", 1, "km");
+				    "Length (SMF)", 1, "km");
 	module_show_value_with_unit(map->page_00h, SFF8636_OM3_LEN_OFFSET,
-				    "Length (OM3 50um)", 2, "m");
+				    "Length (OM3)", 2, "m");
 	module_show_value_with_unit(map->page_00h, SFF8636_OM2_LEN_OFFSET,
-				    "Length (OM2 50um)", 1, "m");
+				    "Length (OM2)", 1, "m");
 	module_show_value_with_unit(map->page_00h, SFF8636_OM1_LEN_OFFSET,
-				    "Length (OM1 62.5um)", 1, "m");
+				    "Length (OM1)", 1, "m");
 	module_show_value_with_unit(map->page_00h, SFF8636_CBL_LEN_OFFSET,
 				    "Length (Copper or Active cable)", 1, "m");
 	sff8636_show_wavelength_or_copper_compliance(map);
diff --git a/sfpid.c b/sfpid.c
index 459ed0b..d128f48 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -395,11 +395,12 @@ static void sff8079_show_all_common(const __u8 *id)
 		sff8079_show_encoding(id);
 		printf("\t%-41s : %u%s\n", "BR, Nominal", br_nom, "MBd");
 		sff8079_show_rate_identifier(id);
-		module_show_value_with_unit(id, 14, "Length (SMF,km)", 1, "km");
-		module_show_value_with_unit(id, 15, "Length (SMF)", 100, "m");
-		module_show_value_with_unit(id, 16, "Length (50um)", 10, "m");
-		module_show_value_with_unit(id, 17, "Length (62.5um)", 10, "m");
-		module_show_value_with_unit(id, 18, "Length (Copper)", 1, "m");
+		module_show_value_with_unit(id, 14, "Length (SMF)", 1, "km");
+		module_show_value_with_unit(id, 16, "Length (OM2)", 10, "m");
+		module_show_value_with_unit(id, 17, "Length (OM1)", 10, "m");
+		module_show_value_with_unit(id, 18,
+					    "Length (Copper or Active cable)",
+					    1, "m");
 		module_show_value_with_unit(id, 19, "Length (OM3)", 10, "m");
 		sff8079_show_wavelength_or_copper_compliance(id);
 		module_show_ascii(id, 20, 35, "Vendor name");
-- 
2.47.0


