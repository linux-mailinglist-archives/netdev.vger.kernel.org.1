Return-Path: <netdev+bounces-160969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F6A1C797
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F68218862B3
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61922156968;
	Sun, 26 Jan 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NyYXLYXD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6085D13AA3E
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892640; cv=fail; b=dHDp/6pjM427ThymLrtBQmqLv9FIp9S5jN3V5N42yP9gfgULM2WqvyxI6c0FGUOIq0eSEPZ+y2Mn4fJ3b/SxbVCmy6tNECmpAJInD3oD1wMU9tvKDb9j2BNEgummM66BvgyDg8TKc/Fz6JCpXK8q/8tmkXduQYlkUk1l77J8sjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892640; c=relaxed/simple;
	bh=5jjhUQySOxqB+WCj5Xvl7141BGtmNuM7+Yuit05ksJE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RU29W7cN7AGoQmsFbJwRt8/5+brMBxP0IRpfOqbh677XvDQnJqvRaaEmk2O4/dKfYXebrFNKM0uASgqplLao33sYgzCXzjsUwm51xMjQePUcZjTcU4HWGuPwzPSNDBokPM7CQIYIlG+rIagR3sBPuvSWCsDQl4nO+g6jJcng2GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NyYXLYXD; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vyt4CrVUj71gEBJf1eGT2V1BiNRli3TqqiP8nHQapn6iuG7+koeVt09KAUJZycO20YgPEjg/5F19leW7FZIItbE5OoyPuSikBdZJmPFwpM1CTy8yoTWOilsEsLz3uB2N0/G+RxKvOQiVfdwQcG4qXEwIK6zyL4LHI1gNoo8cNy17hKhd68ChBao5lwe4f3SPjsTP+NDJZrxJsI62QGv84lOPOdTlypgyctkJQ2vsV6/d0L3vPfpdJr3MmJsuvELjjmbNOL5BmeRNDi6QrVjjyzepfT4OM7gShTpw7YtuRvoP3S+oKpD9jpSsJqlmT7jEl1fvJ1ffh2bbDkaAlxZr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQJXW8Kzd+ioqgzM19ubv25ilEsllvYPH/d8MWps8RU=;
 b=MAMGOIpSZpHWkVHEWss7OuWulbI1CZxOP/f2U3YgmhXaVJ2uW4EnR9ogYgTf4wHMUP7F6qmaFCpLcl09FNBNKEERFNYc26ttNwteHSsryYKFYKpr7CL6nqG8hU+XBNEuEUMVj2bp8/WPMEkwjyKid8LF+9mZd8haBPA1V3bcFXfgHCR76dvZ+TRpoGdyWmZfCchQ+Es63ZRVfsC65BmSMfEPWrBoQT2BI8UhNJg5pWmkZ0BFP8UqpxJQqMO9YE1p5hwoqm059uREiM/z1qJsTYC3MhFJqi9bYWSULE9qS0yBkWqpsySwcO3yoIUMU3sBe827aYHILD0ZPUnbXQD9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQJXW8Kzd+ioqgzM19ubv25ilEsllvYPH/d8MWps8RU=;
 b=NyYXLYXDfO/uqIdVNEm0eOdPx6wvm9snhV/pTztn7K9AF/0vn3ZvpI4MLENW86P9m9zqI9lKUqx5XD6TX9PCsJpCl2hDsTMfqRx2vFEOpIJqJ/iR+PCvB+uCTHcdor8KdHifE4r+UvL8UJCng8dOTL+e7AJPyFPJuXN6AVmuiehNrvBMtgOPMiGXig22mhOSMd+NqqYq9wT3AOnFkOjk99tLu6+jTiHZjfMhttnVemGSDjpobTqWUj3HeHr+qMe4kiN9CfrVTZ9Y1YLT/acYvIT7UHexj+XL5FDimMu7WtC1NRLo9Pwwbu6cumZkejkQ7c5trRxUHagQIApaoJJaew==
Received: from PH7PR17CA0061.namprd17.prod.outlook.com (2603:10b6:510:325::11)
 by CYYPR12MB8749.namprd12.prod.outlook.com (2603:10b6:930:c6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Sun, 26 Jan
 2025 11:57:12 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::48) by PH7PR17CA0061.outlook.office365.com
 (2603:10b6:510:325::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Sun,
 26 Jan 2025 11:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:57:00 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:56:58 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 04/14] qsfp: Reorder the channel-level flags list for SFF8636 module type
Date: Sun, 26 Jan 2025 13:56:25 +0200
Message-ID: <20250126115635.801935-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250126115635.801935-1-danieller@nvidia.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CYYPR12MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac751cf-6caf-4e3a-9d45-08dd3e00917a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4hajbkSUjiDALVZrWZMyo2lmkUTgn415QP0fxrx2yA+7omGdWOsGGReBVeLu?=
 =?us-ascii?Q?H7WIORRAODO3IugkiQNOgdY1Uv3tR5+KIWdWE8pWRzmOP+xLXioIGTBKafSP?=
 =?us-ascii?Q?vxdMK5LCBLnUAAKmOwsmJ1Fckxkow4UGi/MT+DVAMkeIL6tbzvxDkIQdgCLQ?=
 =?us-ascii?Q?N7ayDRSMWg5/auAvULGiUUZHd2fCFyF5VO4FMaUQD6DXB7mzYBp7LXDMQbs8?=
 =?us-ascii?Q?WjiVFeBFo8USZ6/Qld7NaaHhXYh4Agktw7wGv51vAiGKWNeJxZ3ILH9ZeubY?=
 =?us-ascii?Q?Gxc0SM5+IIVaVy9DCYdUAnlt2rcL/8mkrgUxUiz9C94aUgzYNwfX1++8lwpr?=
 =?us-ascii?Q?xgugEAWutpUGEyHZySKr8gbLn19uytfI2ueF2ZoxaNS/VxX+QQ5gTIBecAD3?=
 =?us-ascii?Q?Jgy7Izs5Wx6HNngV0/qzVjsbGAzZz+fDfBF1A6EU6zZpeQqlcUkvyMXIS5I3?=
 =?us-ascii?Q?9OYsGCqOKxyVmiKZzLRk5e+y0ZvOucKYPE85oCsAp9wNv8J9RfIfXYKDBff9?=
 =?us-ascii?Q?Q3NWC5PQr5rHrFuRlncGbMSyeurTbm6rGywqc/wgTPacvk+bkOiDf/txinsv?=
 =?us-ascii?Q?oQHHtZpAAk5OueZu7Y+L8unn0AciUshXXbMrhVq2/w3uMh00qtqEa80d1uQd?=
 =?us-ascii?Q?TXtx4udb54AFynz+b1vdRf+VRqv+01ZJcy57weecMuzh9K3kB+EVaK9rAvfX?=
 =?us-ascii?Q?ST5AxtmGuaHhDfdL789mlABNtjgupMZJp+FEm88slwws6Tdgatn8iP7RoVYb?=
 =?us-ascii?Q?PcY+0Ck+KazDeb/mizMxCULSOmTxMuqmNjjSXJCiQrldHorXlguXSzM21I+N?=
 =?us-ascii?Q?tdCtxGRcgVLk1xmL40+FSizoIuyEg3UfWdmd+JFHQDVL7RtlO2yM45lHQ6t2?=
 =?us-ascii?Q?WZFRqsBHBukuMR6RVMF4vHUEqKVqg7UKU3HmMBrByhOy/UCYxdOVucfne3Ca?=
 =?us-ascii?Q?iKcWq+O826hf5+EMWqxD/mU6hJ3ufYjlcivWfJt5rYkRDUUfhzUpk7+62RYi?=
 =?us-ascii?Q?a8RGkH79IhiGoO4HiNoPjLxYfFbLiwC+LdqugXNsYFWPVmwQoGpaRlgroTDM?=
 =?us-ascii?Q?lOj39qpR1s6NdlrLpFC0Lct0IXNMXiym18ZnRhRRV2X0YKnvtzMIHK7xJYws?=
 =?us-ascii?Q?+8H0Pu+iMLmADBZLnziAQc5/t4JvHd8djzOxWrBvGVH+i7vZ2UygznSqu0qH?=
 =?us-ascii?Q?Rrm6vLnjpm8q6gaMZGAHH6AONzIYpB0PZW00jAYnNRAlbYohxakp4n8QJJBS?=
 =?us-ascii?Q?n8knaIh9OfZqdxfj3uktNDxRitfLzjRvNvdANivoz8cBy4fqog3SUwFKtE8k?=
 =?us-ascii?Q?osFqS3+rvgHV2JOSzRGvfEo/gCopxhqZkMFxUNdlI08rmv08V6rYOomXYZR6?=
 =?us-ascii?Q?1nFGGQC5mtE+FKTfuT0+fyor7nNNKtma6+T37KwMKePkVMC1iX2DP07cImYY?=
 =?us-ascii?Q?uGhW9Gm9bwMpJ5H7Iyu515DeNcBqTPuwgk9zfLORI1PQUtWJiTVpgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:11.6726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac751cf-6caf-4e3a-9d45-08dd3e00917a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8749

Currently, when printing channel-level flags in the ethtool dump, we
iterate over a list where each element represents a flag and a channel.

The list is structured such that, for each channel, all elements with
the same flag are grouped together.

To accommodate future JSON support, where per-channel fields will be
represented as an array (with each element corresponding to a specific
channel), the presentation order needs to change.
Additionally, the hard-coded channel numbers in the flag names should
be removed.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 module-common.c | 168 ++++++++++++++++++++++++------------------------
 qsfp.c          |  26 ++++++--
 2 files changed, 104 insertions(+), 90 deletions(-)

diff --git a/module-common.c b/module-common.c
index ec61b1e..4146a84 100644
--- a/module-common.c
+++ b/module-common.c
@@ -87,112 +87,112 @@ const struct module_aw_chan module_aw_chan_flags[] = {
 	  CMIS_RX_PWR_AW_LWARN_OFFSET, CMIS_DIAG_CHAN_ADVER_OFFSET,
 	  CMIS_RX_PWR_MON_MASK },
 
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 1)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0,(SFF8636_TX_BIAS_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 1)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 2)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 2)",
-	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 3)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 3)",
-	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm   (Chan 4)",
+	{ MODULE_TYPE_SFF8636, "Laser bias current high alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm    (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0,(SFF8636_TX_BIAS_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low alarm",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current high warning (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current high warning",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser bias current low warning  (Chan 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_12_AW_OFFSET, 0, (SFF8636_TX_BIAS_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
+	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser bias current low warning",
 	  SFF8636_TX_BIAS_34_AW_OFFSET, 0, (SFF8636_TX_BIAS_4_LWARN) },
 
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 1)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 1)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 2)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 2)",
-	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 3)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 3)",
-	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm   (Channel 4)",
+	{ MODULE_TYPE_SFF8636, "Laser tx power high alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm    (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low alarm",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power high warning (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power high warning",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser tx power low warning  (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_12_AW_OFFSET, 0, (SFF8636_TX_PWR_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
+	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser tx power low warning",
 	  SFF8636_TX_PWR_34_AW_OFFSET, 0, (SFF8636_TX_PWR_4_LWARN) },
 
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 1)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 1)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 2)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 2)",
-	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 3)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 3)",
-	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LWARN) },
-
-	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm   (Channel 4)",
+	{ MODULE_TYPE_SFF8636, "Laser rx power high alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_HALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm    (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LALARM) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low alarm",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_LALARM) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power high warning (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_HWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power high warning",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_HWARN) },
-	{ MODULE_TYPE_SFF8636, "Laser rx power low warning  (Channel 4)",
+
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_1_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_12_AW_OFFSET, 0, (SFF8636_RX_PWR_2_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
+	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_3_LWARN) },
+	{ MODULE_TYPE_SFF8636, "Laser rx power low warning",
 	  SFF8636_RX_PWR_34_AW_OFFSET, 0, (SFF8636_RX_PWR_4_LWARN) },
 
 	{ 0, NULL, 0, 0, 0 },
diff --git a/qsfp.c b/qsfp.c
index 6c7e72c..674242c 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -711,13 +711,27 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
 	}
 
 	if (sd.supports_alarms) {
+		bool value;
+
 		for (i = 0; module_aw_chan_flags[i].fmt_str; ++i) {
-			if (module_aw_chan_flags[i].type == MODULE_TYPE_SFF8636)
-				printf("\t%-41s : %s\n",
-				       module_aw_chan_flags[i].fmt_str,
-				       (map->lower_memory[module_aw_chan_flags[i].offset]
-				        & module_aw_chan_flags[i].adver_value) ?
-				       "On" : "Off");
+			int j = 1;
+
+			if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
+				continue;
+
+			do {
+				value = map->lower_memory[module_aw_chan_flags[i].offset] &
+					module_aw_chan_flags[i].adver_value;
+				printf("\t%-41s (Chan %d) : %s\n",
+				       module_aw_chan_flags[i].fmt_str, j,
+				       value ? "On" : "Off");
+				j++;
+				i++;
+			}
+			while (module_aw_chan_flags[i].fmt_str &&
+			       strcmp(module_aw_chan_flags[i].fmt_str,
+				      module_aw_chan_flags[i-1].fmt_str) == 0);
+			i--;
 		}
 		for (i = 0; module_aw_mod_flags[i].str; ++i) {
 			if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
-- 
2.47.0


