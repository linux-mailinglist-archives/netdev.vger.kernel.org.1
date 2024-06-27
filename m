Return-Path: <netdev+bounces-107319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8005C91A8C9
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F281D1F287E0
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5C1198E96;
	Thu, 27 Jun 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CTTDhfx8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BE9196DA1;
	Thu, 27 Jun 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497423; cv=fail; b=R2PG/hY5X3Lft0nSx1mQ70epIMr/fKvqX48p/BnMPzwNjmszN8ga8yDF5Ab4QrvjtgoYxNon1BAh0ddeqjr1s+mrTDmyaoxEn7uRgi9js0T2x3I7hVDmNc8/DFH9Igab2G8QRyJvEM8vnPSfpadkxcSR4P2nARujFXAERRTeBPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497423; c=relaxed/simple;
	bh=0JhTrYFbPQxEms9r0XrDZukXl5JzEjsCopD23qbYXa8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kay6D6CLlb8BYKRRe5m7A9KXgFj61eCY//3BsYvAxOef5PYBYzx0Ap1550bVDmVDT9vPCcL2ZqnDpUV3Q0LuJpjG6LiI8wQRMIskTgpgPG6W0aomg0PKzr659JCt0umbhUtja9xvjhNn1LCJm0TeUZobZzlt162Qd1EOfLOIvxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CTTDhfx8; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EggZtO3Bu59hFMlFb8NT9/IV2+2dAMKzkamYHYo8bTpHsOqa/CdErOEWwZqTRfB4Mr0YPYZO4sxxHtzP1VbMZ+mSTZKM0XDqQ4/PG9ztk+ZFYzyNSpUGrVPMYuQMnXdYwozoicJ6xSfXYNSUIlNs3rzzDVGPVko75YszhSovTmxTVeRmu5B0IZU72bYtDkFEHGWjX/LYWnV964f9BpIEO5vxGFbp1gH2RYF5M14+QXp9kOW4MF9MHGuywQqatpZg8nurtkc+Gg6zg8hjiyG309STIoR8ZHMWsb1gziK9DCD8wfIlzPI3NYEDnLn9VGLrWrSL1TFZgi8vyebygX9Dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSNRGgCQeNloOWnF4uwMX4k2fWLjpvEPEB4fqvrE/GU=;
 b=nCkxqchdUweSE6T6sHCEs1SCpFw882faj5Ogb/CPLv28M7OhzORX/lJ+1OzNjLB0qtIA5CfE9ORf2++9HI8CKbzB7AKPCK2+al5UROIp/0z1OYzdIiYuavezwk7McXyHFg8gW4p/8VFK5X0Zq3EI/HjmZIxlJEn58AnpH2iHu7T2BRhMZmVUcsDr00do45fKM+nF52GQ02ivlsPhbHXzxKvuPpBqg16ys6FdmbOAghxvkFRFHqG57eBaULW6uShtNMcRlHh5bLUifZqfNJhvXQw+/sx81mXKa0R5IVEI0jJhxXKUlJB1xjX6cywn/Ekq5TTfNgYRSItIFfJv3Y7D5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSNRGgCQeNloOWnF4uwMX4k2fWLjpvEPEB4fqvrE/GU=;
 b=CTTDhfx8EeS6Ku/jjXC33GSLD/wDtbuLTsK0udJFnaLwOxgjeizhFqhAvT79D+duD/A97e26oatAr5zDc2DZMvO2bMDe5bAHN6hccr+i2/8GQ+9n3qg/BTXXKRGFDLXc3rwt5taAfuQhkgxGkDpGGMmu4XXhDBWu3X4oUCiGoyHUyyJVPrF4pKa0TqWLBoQAxDZzmZlqIt+9LwDpsV+fqaMKD4HcKTfI50jzzVQqJc5fdzQf82ETqpgkm+O0Ohs5CtyaRcLRrTZ6dnqbZ5aN9bpLnT34/jsvHArnwMfihaTm5xWRQM+hD3V9PoqIEP92TIOV9ujzhJEhmDm54EByuw==
Received: from BN8PR15CA0071.namprd15.prod.outlook.com (2603:10b6:408:80::48)
 by SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 14:10:18 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:80:cafe::70) by BN8PR15CA0071.outlook.office365.com
 (2603:10b6:408:80::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.0 via Frontend Transport; Thu, 27 Jun 2024 14:10:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:09:56 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Jun 2024 07:09:50 -0700
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
Subject: [PATCH net-next v8 6/9] net: sfp: Add more extended compliance codes
Date: Thu, 27 Jun 2024 17:08:53 +0300
Message-ID: <20240627140857.1398100-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240627140857.1398100-1-danieller@nvidia.com>
References: <20240627140857.1398100-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0da56a-7d8b-40e1-3f1c-08dc96b2dffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VANWpRb+F9WXfq8Vjl1BQh+uxt5Dg1nZzCYwvHN9tdGi8z1eOaJfhgPatPEc?=
 =?us-ascii?Q?NY2jWb+/bxln59bCa4bFEmL9yQi26xU6gUp2STmudX/jdxC5hKd5Uyt4sqm2?=
 =?us-ascii?Q?TQ1FPjvdSEM2P2cufh4vSjlsPztW0W8ej0YVKpmTuwV/ECGrDRbdW5+E/u/b?=
 =?us-ascii?Q?4gONl/2Vpx8JEU6r4SFswf0J8Q6NXwFy5iIhhuEUDMCn+5Oy+glQ/p2MOmAZ?=
 =?us-ascii?Q?DRx/Ss6KfD5sYYHw2kGFgXewPzjxcTlBhcsgdrk1SsiJkPlCHG2mNyyJSawL?=
 =?us-ascii?Q?MYC9KyJWqnh/Pd0BAI4DGcqUK6eomVhfbuWYoAiIVc5DAbvfLLr9IV6kEtBb?=
 =?us-ascii?Q?JAN0qiH+JMRjQV1N6SeM8R+v2NY11jl1iea4K8L8qDkaYulA80zpYVQJD1DW?=
 =?us-ascii?Q?8rJxTMMR7UCNQGl5Kh1eZhPatjbXXLwojlEdaALrB3pHX8pv1wwBdf8zYI54?=
 =?us-ascii?Q?/81CLmscYpDd4xp0+RWi6MkIafY9II9yepfBc8YCjU7qDR7bgnxlCxj4AYS7?=
 =?us-ascii?Q?xwgiL3XZprX5T6QhG/NlpZszKlrcaJXCMmPd7axbG3sxhQomlAmDtuKCjf9T?=
 =?us-ascii?Q?3Pc96HYMpGZz4HJ6G4abwR3CLYPojIFtvGpyIVhRx3jjMLb9IOe5oLqbTvOA?=
 =?us-ascii?Q?U21SO7Znx9lEH4uloVlXQhK2mkaNqVhObwsE+ewXSZp9CZHSgchQMT4p/r7p?=
 =?us-ascii?Q?v7AlVTogAoQlJfzt0MDCZ5bNcpTyiiIlebl1z1Dtdm4KThoxFo/+MY1sem82?=
 =?us-ascii?Q?538bnAz8z09cl2ROFMyxizQTlM6jpMhZU6vLgyWcaY0eqk3rfgOEGk8hyZjB?=
 =?us-ascii?Q?7Y/b9srCdwz52Owp44VQ8eo/qDvbE6POpkb99odzzZwEzrnRjeAhYbdMoWPf?=
 =?us-ascii?Q?5O6B0K1pu26hHvkxOa23ldaUvxm3VxXRn/keeUFJsCO6dqasU9+FIinUVX+t?=
 =?us-ascii?Q?q+IwmjYOUhDrD9bhLj7C3I/vGK/iY8nl5ES7yG9z2Ps1pO/ZbmKAnMLCAXSU?=
 =?us-ascii?Q?R9cVvfPOGLRsenzl3AT6WlbNpimp2wB/CiAEC1GnW/7cvJTEGrTNqMJmwDrI?=
 =?us-ascii?Q?YcU1zxrxlc1shTJV7dJS0mRJVSwXfZRUbD0MVGRzXWs6ZFKEvCo/surqdgZ3?=
 =?us-ascii?Q?aKWo0kKG0eFQo2HNuqeuCeabYPvrzoAJsRMxk45TR9BPqEfXi9ktrRVYvsiH?=
 =?us-ascii?Q?N3uzr03zstWCQt++IQYyda+a7vjecCdrmmmzSmFUaSuZmQ24bWkA5qitedF/?=
 =?us-ascii?Q?byOadvsosgKc0rrjAAb74O2y4rod1ki+MeMG+WoCOIwgS6uVk5T2F3mAtmha?=
 =?us-ascii?Q?vurgplPgZ+CKTJ3cpdaX8tqeLvk6N1ZUYZ/VomriCRvt0Q9XcFHbIB6QTcUA?=
 =?us-ascii?Q?p0WTdThlt6r1JCF7AHgazqHl3R20yHLbmoNOiOfCTM08oaXcNQgAG/wCjZva?=
 =?us-ascii?Q?gpTjqzS83aONySZMQe29T6MBksx66zrT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:10:18.3866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0da56a-7d8b-40e1-3f1c-08dc96b2dffb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225

SFF-8024 is used to define various constants re-used in several SFF
SFP-related specifications.

Add SFF-8024 extended compliance code definitions for CMIS compliant
modules and use them in the next patch to determine the firmware flashing
work.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 include/linux/sfp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index a45da7eef9a2..b14be59550e3 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -284,6 +284,12 @@ enum {
 	SFF8024_ID_QSFP_8438		= 0x0c,
 	SFF8024_ID_QSFP_8436_8636	= 0x0d,
 	SFF8024_ID_QSFP28_8636		= 0x11,
+	SFF8024_ID_QSFP_DD		= 0x18,
+	SFF8024_ID_OSFP			= 0x19,
+	SFF8024_ID_DSFP			= 0x1B,
+	SFF8024_ID_QSFP_PLUS_CMIS	= 0x1E,
+	SFF8024_ID_SFP_DD_CMIS		= 0x1F,
+	SFF8024_ID_SFP_PLUS_CMIS	= 0x20,
 
 	SFF8024_ENCODING_UNSPEC		= 0x00,
 	SFF8024_ENCODING_8B10B		= 0x01,
-- 
2.45.0


