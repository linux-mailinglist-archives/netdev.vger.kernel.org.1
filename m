Return-Path: <netdev+bounces-164614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C2A2E7D7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14087162A26
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C71C5F10;
	Mon, 10 Feb 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pj0kp9lD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BE1C1AC7
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180038; cv=fail; b=GyXjEUMpFhvpLfPqJZHRCTPQLkow9kRk3TIRdyUE8LgfShMdGSW8G2rnTHN1CJb0fN2jgFhgB1hxse/Myoa4rT2wuLzL7iveJEbjfeNCBaT7742CB91NDBzG6XIUlUZkHmGb2cmSYwrcJo12SNaenurVP6hwAiSLMHgU0dSG5sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180038; c=relaxed/simple;
	bh=PTnalT+EtsLdEt3iUaDMBCBLAkCkkRhSbeOe5KI05Bw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fS/Nfq2LYhEFJwiirV0l2wc+1i3Zes33D8lQaQCTvl5wdeEqGyiX587wk5B0H5USZU18lLn5PlH7EuoSaCvpGPd1E4rWFmkQ7/0wYY7wZGM3DRzux9RYxxraUmla3gpPblEdRODZ43pTxFYZAhMcXdp4I4Ds1YU3K0ZKS0cu9jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pj0kp9lD; arc=fail smtp.client-ip=40.107.94.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlKChEj4GCOel0BoWvsDlQ2JgTG4UNtUtFBN9NVQJZFkvkdo3J3/I1DZvHYr5Rp4pqwtT1uzfdYxa7zz/mnbg0y/XTvVHk2eK+f8zgJUNElYN7O0cWcaeJ8Qq6fHhU2xwaO+hrDVFdY6wFEBAYlLCpJr6lGQy4A+d9e7LUrxRDkuBaPg+p6mh1Xmp0yXnV5YMceVRFXMyNw5ANaaNZLat5AYVwOG51cfd8pdRIzNB/Bbn3CHTm8MrBHql2smCSlJh08dK6dxIxJ7Pkh+3pmA9BpgnzvZrk/mECQ97h8zDVIkjUVCmNN3J3J2rKvqUekv9YiIdtRTach008GW0FzNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8RlQeT463bNWlMcs+njmzKLNuemM7B+uM5+WZEKQf0=;
 b=ulNwmq+f32lxw7NL+etmMWS+ye0ihN2D9LWEACZc5RzZ0xs/9IuHcBQqFdGUb8ehyFAWZye7zO6tcZ6NyVXo5G78GNIF5QYoT0Qdz747f7QicvaISLE6g1sDNMmLHD35O+viEFuwR0bl1xgQBrf8SXbbeuxWjNmJrU68+imGjouN2kb9KrxQ+N94eYntuqHMSWSdyGMthJugGu1wm5yC/Pmtz4BK7zv9gQ0y52GsEd3Q/7IJCJgZj7REIYIJXes3c42ooxd14zKSXtv1dCTQHbbrs8282RHeB1jSlDflJlzSDBn9nMZuLWfENUQGvupTh4Vt2hcMJAJJTxtcKxlOdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8RlQeT463bNWlMcs+njmzKLNuemM7B+uM5+WZEKQf0=;
 b=pj0kp9lDjoRn9yaT/cDbrcMzPPl3U/3f9mFMKsFImB6J18SQqvWCk688mHB+rCNZPKZfXiRDKUTCBt9zNcbR18q5OWyP7xohxdcJg+e13MwoGHorEKXzPR8RuhxNSjWPuk2P+upQR7Ptk1tBECi6j9pOT+0obg6HtBgI1eieRYfeTfy5smc3rPp+ygSAm4yMckHGFZdO2tDeu0ifXRbne85u/xmuqXsGe5GAfYn/6UMHF36uHKZDmQXOIJ7oMO0/uYWyQXPwWKtFFaraXCIj53BZNORF0TjNOU5EwGkBq1WNjQaGJaukysbK2sRihTSc4Tkrp31s/qtWfqRNPwk3xg==
Received: from SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26)
 by SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 09:33:53 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::c5) by SJ0PR13CA0081.outlook.office365.com
 (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Mon,
 10 Feb 2025 09:33:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 09:33:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Feb
 2025 01:33:36 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Feb 2025 01:33:34 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v5 02/16] ethtool: Standardize Link Length field names across module types
Date: Mon, 10 Feb 2025 11:33:02 +0200
Message-ID: <20250210093316.1580715-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250210093316.1580715-1-danieller@nvidia.com>
References: <20250210093316.1580715-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: f25fdf56-7b5e-4726-6100-08dd49b60845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1hSpD/Fj331IHRS/6k3YD1L8UVaCr1IdpfsPxNbEPg1X4AEW9ygF0ZwDanOn?=
 =?us-ascii?Q?Bllhw42UMUg85hbseeohRvpJtmv9Muncb+FRYjyScJpvx8sFWqZ8dMFr+1qe?=
 =?us-ascii?Q?CLEJTSQJzt7C7HFSvpfMFzREYLmtdDDYG6adpqc3u7efKdQGmbRD411CvWde?=
 =?us-ascii?Q?XqVDa/hwqgblFyEamOs2fW3A37f41gIRTFOnvrt/+1l15IaRKVgQso0FZJ8F?=
 =?us-ascii?Q?xJDnSmJPGSJCFnkFEvEpvzNwOAlMHc4lXFQLyjxgYSTYvWv+Imu5ulWATH19?=
 =?us-ascii?Q?D6BI7WOekR27QkLAVKUioLkEykYF6Oo1ovRsJgmg/FNAkCbqXWJpu6MR+JxL?=
 =?us-ascii?Q?5uq2YIe7oNzkCMgKr673OV1LVwOz1iI5V6QPXO0SWrPQK5QOIEEsTRQ9LrPZ?=
 =?us-ascii?Q?lvm1/HCP6BEXmW9XxMnOsGk10md/WwJ1iva9tAA/UIgX0rJk2+KgpRSdSv9h?=
 =?us-ascii?Q?84356pk7rl3r1lNia9xooqXWJ3iswmTvhSxs0rSsGbG+2OduMoEZI7qUqlrj?=
 =?us-ascii?Q?C2Wru9cASAjXquoqWOrJU7sEXF0ym6kZu8KiVlBkPXFYBa8LNv9h7XTBGjhF?=
 =?us-ascii?Q?oPgp/62IlWNDJV66nSBDlAhyQP6euKPO/X9S6FlGMcVUb+YteaCjV6nkqrXb?=
 =?us-ascii?Q?lkUl+i17mcx3gwfroXExxCPaSDPUQsmxD8tmzgR5PdsHTR5KDNVYq/rBW6e+?=
 =?us-ascii?Q?edc5unpmmRK15FwUqkKcwe5nidd6vT+XpqH/jlcEgeYSWo4tqyvz1P75fZd3?=
 =?us-ascii?Q?xsE4TmglH0KVEz9YmHdnLMIvUebP31udu9ZsOFhW2PR1z3g5O2/Mk1uywLJr?=
 =?us-ascii?Q?OuNz8R3abAOhBg1zUUwitE8SUBoOTBdld5dhE+iGRIPaXoGToY9QQfYHzNMM?=
 =?us-ascii?Q?ChXKdofQJIwIU15RDZcwLLNLrE/tNgdCaV/HYn43U5YLnR8El/VwtOLEMZfV?=
 =?us-ascii?Q?kWyAcngDmXTp6IcyplS2dziCjd8+INhywwg4lE1yejpMTrFU36GTYln4YLg8?=
 =?us-ascii?Q?S0dH/rmVgDPVjMJzj/RsJUz5BLHfu25afRjYYn/pbkROG33gmvl7ndagufRt?=
 =?us-ascii?Q?+TPT7vpvq/Kuofw76d0iKTuE2+zqjgfbz2ydIHBk26an5g+E2q305RhPlJyd?=
 =?us-ascii?Q?iXJyU3ZbTg8fRduVXhwT5DZJ4iej4DPQQmekSgMv+D2IsAeg4YTvlh6jeOl9?=
 =?us-ascii?Q?9vclyLqnBheLf7GEpZ+B3W8BxGoupolf99bF4I/5MTQmBkuR3bkQtWtYpEB4?=
 =?us-ascii?Q?phV1+Pgome+YijP+cwwNKZeGd5q1+lLHNb/PP7xTa1AVFPJiAtbo2rtN03Fb?=
 =?us-ascii?Q?yR/PO0WiKn+90fYRUcijzgcUzkz9meGEEiyPKYghTmHXbFzKj2Qt/bLxBSqg?=
 =?us-ascii?Q?ZihUZiYrhYG5zwkoiXdR/dVuYGowPP9YA8EyXmhiSHTbK5BYZJQzYCUv9SA1?=
 =?us-ascii?Q?7jcampo0ouvONhGn1JK4OFIRtCVX8PyfTE+lTQoCduGQaefR4Jo25r9RV9Ww?=
 =?us-ascii?Q?1NU4ObrVw7fyzio=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:33:52.7649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25fdf56-7b5e-4726-6100-08dd49b60845
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035

The 'Link Length' fields have inconsistent naming across different
module types.

To ensure consistency, especially with the upcoming JSON support for the
EEPROM dump, these field names should be aligned.

Standardize the Link Length fields across all module types.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
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


