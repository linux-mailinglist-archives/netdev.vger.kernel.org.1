Return-Path: <netdev+bounces-161499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4C0A21DBB
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05AC47A3822
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F72A3A1DB;
	Wed, 29 Jan 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C5NB50Ji"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85847182D9
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156600; cv=fail; b=BpxvsD/EY4ohf2OHNFBx9K4zo1gSo7LmPpkUUtZCpDZmKm++x7DIJfHpDk/ZdSqx+lZ/rDc3GRfgr+SIEVsmRkooxF4fuvs87unxfrMnXAllPsmIA8kIeTNCt/v4eTN1BPCMDP4w5P07JVmAC2HKpIcUElskk9Q8Rl7DTqSutHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156600; c=relaxed/simple;
	bh=Ng33/SEK1ZzJgZIMbQ+ZM8hH8ZyVZoUyoXYOp82/Mjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3DKwfjzvtVbZ+0H6I8FNRDfp9NF3tgzz6KDzuUYffU5rD9XdF/eW4kV2mkDuafbMn8sIX8apdzFDXw/GJNaqNOgvn6BG7qcEODWIprI98gSow5TIjz2buglkN1ifbKHVHcm2Qu5YFlHDhSt3YMk9iis2wL6EZyN6AtjAhdyadY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C5NB50Ji; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVPlcSLz7mlK6YDe/GBFderlzBpr+dpMKvUBQhAtU/nhzovAPcEAVZmxNYjJq1TMolZtF7fvC9MtyHkqiD3qlMgkKoeSUy4naEYJrYVFYsPpgnUYtWtZNQ0dxbqi78CdhuJfJq1uEapM5c68OJTGWekKejvgfp6rwxRkr63iqISaz2RWQwLQ91e8Ij+pK1qpOkm08M9PboB8c8NMZKTBWI8SV7Y8yrudg6slBlwttuvglcW+02DDaCg1sVxGYnxjRmGr94zzV139eG30bq058GVaGShq+1YtWF1vCsg66/az04ICkhoKwBC6wcrZdpv9sXVHx0KXGcYCwQUgMRikhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/vgWH0w/04VEUiy2GkFrYsw7omYlp9/d8IHfDH+/00=;
 b=UdLAM7aNWB3AM0AlzVqqZgsu/iK6uBorMPltIIbKxJsBmJzqyz/+Row0l1b4icm8DxAYTbb8kBmlt3aJq5g03TGMymP04Ox7PPCHTuOJBEoKQLNNuuWn2UV8Psbz/SX9QtC48C8Ho7Z1GSWRDfvwuNVG40gWuRmhSSSQ+27MwKvNgMXqLVeRDhLnF7RkSbZCaTPpptl/PT+KXdnDt1zghUHnunIbltp1bJW6ZvhMr9D2EaKm6kJ8WEoW+Nkk4+Ld3Ule5MA24JsKGZwRBmlWpCMNssIF4ccKSkqQfByhUIq8VKwITPx/KCYhbsm8VqEI7S52ZmDFdUBtHTbgHavM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/vgWH0w/04VEUiy2GkFrYsw7omYlp9/d8IHfDH+/00=;
 b=C5NB50JiDD6KO3r9wEt9FQFcGlwyBecCxovWCCz1AsaDlcIKrcWNRY/Co4n9JdLOod4QNWCxsgKkZAJDIrDurbqab1JvlYpTMPsQM7H3ZKz9LtXC+UGWOjPR6HPBIYH1oCbtcafH185wSIURN8vgO7/7Ac9b4XmgoDnKC8+1ABP3SWefY+OzxHHRE4Cdu0/SceXnwkd954HqFsWIvTeNIj71eH6fze99Ud0A4KN05V9kiVz2EHohGGCyOSK13v5OCdBAht65KTzZliAXzFK8o8JUrj5X4KekYQmSP8oiupYkR98/41sQ/GwVhdlD19EnWSGfwIqqKbd4RZHXL5IfLQ==
Received: from PH7P220CA0083.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::19)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 13:16:30 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::a1) by PH7P220CA0083.outlook.office365.com
 (2603:10b6:510:32c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 13:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 13:16:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 29 Jan
 2025 05:16:12 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 29 Jan 2025 05:16:10 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 04/14] qsfp: Reorder the channel-level flags list for SFF8636 module type
Date: Wed, 29 Jan 2025 15:15:37 +0200
Message-ID: <20250129131547.964711-5-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250129131547.964711-1-danieller@nvidia.com>
References: <20250129131547.964711-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 65963bb3-c4c5-42bf-a9ec-08dd406724a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rcDzjYMbf2yVhjxUvnCJqidfCgpRoJz9ptmnEn902CZmwpQTXjJcebWCs8uz?=
 =?us-ascii?Q?IDwzxDRWJnEGnvnclG40fbimPYYRxFfB8J09hHx4ccy0OhYR/OSwuL7d6FHA?=
 =?us-ascii?Q?BIxN7hMpCF+zpkiPt0uTJ0yjeaFNTfLaLmqJzfH4TXB8nzA/KGp0UbLnyLpH?=
 =?us-ascii?Q?sRZaqUh7sERKdeRC9Hqrpa+tyLN39qvhfPRr1jz5f7eyqpvdErtqxDBV5ICv?=
 =?us-ascii?Q?FIsB3pXqYD2RDWgvuV147e4+QC36VFmGd6IfbPOs+YFBwHIwJhcplrOWxKer?=
 =?us-ascii?Q?WRRfPMhiXJV4nwbrCFRO4+ZXH7OOnilumgLgheXmFZ3cCGiB3lef1SfQuao2?=
 =?us-ascii?Q?VWyVqmvXkXW9Hd65hiQEjnrbUWI4U79BHD06qt1oeX9NX0X4j5lOraZ2XrJ4?=
 =?us-ascii?Q?2sUqh3HTf6gJFsJsCVwLPI2VhHNuViF7sX8G9LaWKIr1XJYKAv1y4nhJn0jM?=
 =?us-ascii?Q?oCu02WismFlTYgYfyIwkRcvzkmJ0HZMDu/Mq2r0ZdPt/5fNgJiDKrWoV8idH?=
 =?us-ascii?Q?5pnAw3zkI69cKpRHH6KJZYLmfSLMpwZ4cMSnIo/SbV7vGkgPNZ+xVYuU+nql?=
 =?us-ascii?Q?Qy+MFjV9N+t+twSntd0n6kTjguktH4ZTWScKMf7D08aZApnfj51UIanaC+WA?=
 =?us-ascii?Q?Rx0JPjVu/Hnnl3VpWrqk/7Gc6vlcRwWAw4JRYXYri/G5YKx0vaNAE7AXXwJ6?=
 =?us-ascii?Q?fc4itzZSSOXtLMtb9RpMSnNcWcxim6c9DLHFZjC6xR3Gh+a3LXVHj6+yc0xj?=
 =?us-ascii?Q?ql49OmKNRxTBAjXWS0sIe7KCXbAaC33c3x+Y6WX0zgDvrf9nt3H4CoVcCcrx?=
 =?us-ascii?Q?a3e1zZooOp5uQYBom9hwfc0SRsy77AbTdBTG7smXybs2IPaeg4eCeu57Aj7a?=
 =?us-ascii?Q?nlH3VIDFcKr8R36lDvvm9C71n6KBzWlV14Q2c1lsOiyDGTVacDMt4IN5IeyN?=
 =?us-ascii?Q?srJq1x7gBnrGoaFs8AcH7ebzHs4wihC/eHrgimJgWTs9/YFnbuIyNLnRCNKu?=
 =?us-ascii?Q?3Uy3NPlo0VQaCfLzS3xOVk83DhDS1w0fgBkrcetc4DpbjtkcU+NdwkxnZnKg?=
 =?us-ascii?Q?j9z9aIrn9OL8OxaExQbBcbVi1xf/95OlzvO+OPh9DHinZ1HvPttGqNib7qeY?=
 =?us-ascii?Q?gmdOU/WMkWzV/EscugIIvE0CbD2rEbm4Pgzy4hBGEfdj8yFUs4XkRGgK+C3D?=
 =?us-ascii?Q?VkwWiXH54qNdbBi9GyEwEVes/nFN6y9NzovulGQObZ4Kq8QvYLXf8OhN+uJN?=
 =?us-ascii?Q?7knG9X1F606QVvdFwlqG49sH5hTZe5xVTTdvIgygHBCVLKkk4kvCYovPlfMw?=
 =?us-ascii?Q?Isw9xt0OkmB85z740z+2SmQY/8ClvVNnVJqHxZvwdF0LCi9J/XSdQUBMbclV?=
 =?us-ascii?Q?3hlCttuVH3UDvW0hqDqIOEBu0RiI2+5G1AOZItUvFXKp2M2vpVoQP/vksK1X?=
 =?us-ascii?Q?l7VWlDMJeLH2nC8ErYLD5Ke3QpLWc6hpKHlU1KhEArupW5BGOoZ1pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:16:29.5455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65963bb3-c4c5-42bf-a9ec-08dd406724a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488

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

Notes:
    v2:
    	* Simplify sff8636_show_dom().

 module-common.c | 168 ++++++++++++++++++++++++------------------------
 qsfp.c          |  17 +++--
 2 files changed, 95 insertions(+), 90 deletions(-)

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
index 6c7e72c..d272dbf 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -711,13 +711,18 @@ static void sff8636_show_dom(const struct sff8636_memory_map *map)
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
+			if (module_aw_chan_flags[i].type != MODULE_TYPE_SFF8636)
+				continue;
+
+			value = map->lower_memory[module_aw_chan_flags[i].offset] &
+				module_aw_chan_flags[i].adver_value;
+			printf("\t%-41s (Chan %d) : %s\n",
+			       module_aw_chan_flags[i].fmt_str,
+			       (i % SFF8636_MAX_CHANNEL_NUM) + 1,
+			       value ? "On" : "Off");
 		}
 		for (i = 0; module_aw_mod_flags[i].str; ++i) {
 			if (module_aw_mod_flags[i].type == MODULE_TYPE_SFF8636)
-- 
2.47.0


