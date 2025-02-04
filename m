Return-Path: <netdev+bounces-162548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA56A2737D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA873160E55
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08269214A82;
	Tue,  4 Feb 2025 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uXtC+Rrp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5E2135BF
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676440; cv=fail; b=Ie+VRUicwmiR6aVPThvPxPJch3goEpin02ZWFPGNU9np7C8kI53G2v7M8zxjwhPUD6JBB4bk6x7EnRnPMYjDMKG8yvms2Tpydsz2cVQl+oDCDJPDsN3I/B8TQnnIasFe9pbxmSG5gmzfd2bVhlO9T2iDm4M8DLuOxul8upj0seQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676440; c=relaxed/simple;
	bh=XDharbSpQhQtiPQcW2BQBIpwZhJAc3S4ufsSo698PVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caqAkgHtJ7ri3uwdXTy10p+QwAg+5nFY99Zm6JeZAUa/WbLSgwwFfv0iRVn6lyx1z356Qi/TOGVJefL1bwWMdWzX+yg0kgAAn6kiXOx6cUL/j5Hyr2Go5i35RKyRNZpt1fDIB9spIgFHp1RD69TS8KDi/6GcwX6OmL5Z1vls6N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uXtC+Rrp; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBmZaBg+EKe9wpgLpqX6uPVJt8AJe06q4670BBVVN/3BLtGiuXJE6pgCiknBaV9Lp3DJp5iz6ep2yI2kPNFImM1TsxKm8m9J67Ko3a8GUU63VQAriByG7gglmXJ8fQBmmPo3DZZUARCIxlk4G0aD+AEkRPKvEWddA8TO9hsntqrMxBdG6m8ILm4+bzm8XmQKsKYsnjJyzOD7r8kL37gQfafjUetz6iDNTsWUPYJHcmf6XqhE+y3iKNBHo5CCfj2CyXKw0x62bEVUZx5xCoezAdUtV718iEeRyQTXB5q1KDeIbuquVsEftgJGbdxCkpuL0Y6jJtPAoqBiqYWQeoZD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WiL2+r9JXHgDjDoPXr9lnayjlJh8Bj0TcmiGAODIs8I=;
 b=m3DBbPC3Nej+qiIgs1YIhkqVX88eJjC+pqxEo8blegCew6eHWqV8X5vTosdlS9pDn/FMdINGL4K8cqY/1imY4rMiwoZqtYTC07jnSBhY8V/tobR9Xi+yP4lcLDI3nDZX1Osayh6dvw/elyqHkyvaI1pHMNJQ8OeX3wHCbYUuUaLfuJelSUdADoBfOwDCKUbuYXU6GgwuiImVKEuMonrtDQAHWg1NBQ63z5psrlqPZcgJ8b8dE98iMolXhLpKq04vskKhR/mkHGNVuvbUZ3IbdcMi801ftjaTMKXnL/A9t2NeCZkQl6JVRWH8+iz6CDPrJ2c+2nJTtD5gW5wLB8nvIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiL2+r9JXHgDjDoPXr9lnayjlJh8Bj0TcmiGAODIs8I=;
 b=uXtC+Rrp1+JeA6GDARByOfMnR7rFLWw23R775s/6K7R6P/aKufpD/0NwH3/eaqJYVQhPyijMTl1Raii3RHzOC6bVtx1hy8N7MDBsQmqLa3XuPOwx8wedS4OI7PRYnuoCSlol/oYz0zqnt0eI/epkenRLEStQIKVbqUGHUmLfwL2l6frwhKe4IaabaGtl/YTubERt6/uDVBQg006zZiKOzQ71JrZLhodyhpMaMxUiaBs9IG8cbkdoqogw6Uj308l+1gkhum7T0J3AeQM4pBRK2p9HMXRYW+SJTupnN+0dbZzgVV8zZRFufblkNjiMvaWiMCw4vfMtxhJQ6Zmobx4n+Q==
Received: from SA1PR04CA0013.namprd04.prod.outlook.com (2603:10b6:806:2ce::19)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 13:40:35 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::b1) by SA1PR04CA0013.outlook.office365.com
 (2603:10b6:806:2ce::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Tue,
 4 Feb 2025 13:40:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 13:40:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 05:40:18 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Feb 2025 05:40:15 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 02/16] ethtool: Standardize Link Length field names across module types
Date: Tue, 4 Feb 2025 15:39:43 +0200
Message-ID: <20250204133957.1140677-3-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250204133957.1140677-1-danieller@nvidia.com>
References: <20250204133957.1140677-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 851b9051-6960-4421-2ebc-08dd45218098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v3gmbBbIPR/evrLd+hQ+RcX1AaohPnaFyRDgs9CiBwfwOQ8dBL4ikkM+90Vc?=
 =?us-ascii?Q?c9yCkKtS0DP1g5A5JmNclPMe1fFWTkiDbAUZ3s/jxHGSekUGVf/IL8qDup8b?=
 =?us-ascii?Q?319retreYMpBacWiKzbvRXaoAENqTDGazJ26kqK+xDRUk9AurbLdjWp/PIIC?=
 =?us-ascii?Q?iPEnMX/uA2ADKR6czxlKe6m1G4XQH1Sgt/+8qcmy2nSi2W7w55Pgxf/CmpUu?=
 =?us-ascii?Q?m12msgKNHTzdeEiXCWtdkZjjrR5PxZn/RYDJNDtpYIv5sB+DW535PEgC+IQN?=
 =?us-ascii?Q?K5WVIfQ8eABVYkd18qYXEt6bqsJlPmdrRHzJ5EGgnyyMrzP7lONK+An1z6mw?=
 =?us-ascii?Q?3symsDlGnuE6jiMKI43x+8JZE0P/ZP7wdfzg5kCVQlgesCfOjNnCQiYlLZGT?=
 =?us-ascii?Q?pFEe/hQtwTUXzK+8xGIm/db0AhEMfCrBnQbAdwUKV1gsWpTdlB9TCvcBBj6t?=
 =?us-ascii?Q?dQYF2V6tymH5aLaE1bzTDgXaQfe0U0/8JboxpTi1mGK9XBKphrxYsXN554nZ?=
 =?us-ascii?Q?iqaH4YHNp/HwbLu6DbAptxBcTcLqiogLTawvqacgR16gT92iIrlIX+PfqQC8?=
 =?us-ascii?Q?2W7qcv8b5vOZ2vHWyLUxvnXPDc7iSatOKgbPLqE7aiICUksh8Dvvc4DbWoM+?=
 =?us-ascii?Q?2YsoQOMckJFG8jm6VQUmQgQlrGqfyM1UStyBIg88eQrHycy23UViMwVqR+yV?=
 =?us-ascii?Q?8O+uE77o7Td7bcZrhtNfHlnKmE+gfVP05kkH7/U93h4VY5D0ODaV9zS8Xh5E?=
 =?us-ascii?Q?ZiGkIvRNle/QOtzNlBvZxpXyobUpLUt6lGvi/GgOXyXAK+Eud0ZZKsCkhv2n?=
 =?us-ascii?Q?fxSlDuWJqRqMbcZGt6eItdhIPQK6BAoBb3hVCw2H0Bu9oIfBC9HC7eD+sio/?=
 =?us-ascii?Q?g/Ow+kxvgGcBQKg3XLNabxogzrKAcBJtvGVjLveOeXac4soLqHia9PvfowFo?=
 =?us-ascii?Q?TCtnWYHyAS0tinH7DcKkeH3Ca+7IpUBFD8iaRX7KH1kbs8NzAnbz/ivjOWOm?=
 =?us-ascii?Q?YtE153/wkdvnlK3sOLrUeQmgTTX0IKVn5tJv/fOL28ozL8kRcHm3K0Xr+TTC?=
 =?us-ascii?Q?M81iV8wNBU/0c7abIT69Op9NkvW081vsHkr8DjgYdK26FwlMds0+i3JSilb2?=
 =?us-ascii?Q?jRZQvTnxDwcZZs3NrfRPHTAwxnJXYKkN9zan/0iR1z2dxTJNFOVQTEBUiHBf?=
 =?us-ascii?Q?mFOk8EnAiHfkgXiCI5EkQv5MEo5EPYUcObXuzX/a21pikaW5H/dQg3vkCY+K?=
 =?us-ascii?Q?BTESTdqRepaSL7sC64YS4JqOo0R5/Uf2o5gl79dWu1yaibCywxLD/c7CRyBD?=
 =?us-ascii?Q?loI39Z1Q4Svy3wmOPLgXxvlJk1wGOL9WER+cHIMu95TJlbR2fA9++mP2ooM6?=
 =?us-ascii?Q?UqWbJU6YraLrvHg4LSS4V2IQqH3dYHTqG8mWR0F4eiudR9HB1PqYD6Cmw7/9?=
 =?us-ascii?Q?xaILPnQqjhbHt9H1Ii9lnKh/yPoLIUucK6cYvS8bXKBExp6Gy/jBe5F7IHhc?=
 =?us-ascii?Q?04IQYdSILJBzjKc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 13:40:34.8922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851b9051-6960-4421-2ebc-08dd45218098
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505

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


