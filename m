Return-Path: <netdev+bounces-104854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEE390EAD6
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD169280D0F
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED591509BF;
	Wed, 19 Jun 2024 12:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HC+l0v1j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7ED15099D;
	Wed, 19 Jun 2024 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799521; cv=fail; b=lbtNpAw42gShiGTCQxMG6WjNjKLRR4lq7zWbT1szzy14/97ZTZWo09XXH5AMoKSSKD47jigBnP0LZWjx1IUz6bBZEfZM+9s5zKlMcMuWvKewt7Xi1Pb+LWrsgurVZoO8uWtGa3ILahswY5Z7H9l5MJYPNMGSTeikz9MZwIjdAlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799521; c=relaxed/simple;
	bh=ch0pfnApHsCdyjFizpjfxLpKh7QsAGNl9XyZat8Eg8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfWHnQ/st3YO54cZCacKy4fXDCzy9MqULnVpxCDi7Opy98UKedb1s5lroqZo0ndUo8Tk+I9Xq23rtEkYPLQ8liVhHYXbfJlM1FvG8aU6Z5ZzMqnGcOi1LZ5WYv5YkWOPDSxGOniQNfWaqzuT7Qs9jbNZaDMp4/AQDe67OC43LHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HC+l0v1j; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDl8DSq8uQQpGXBzGWKS/Ma1R/ZIjLTjwu9ZbyMEPVs1jsuN4xk13okGAYWNE2YRCBe9NJJpxZm6a+rRPfq41J3h1TYQVgCG2FujHV7lKGC2WhPKWYP+NdxeIQKy0IDsnUqrPBWyfeoVCOMY/5sjaxjUn8s1W5k57kbCI7iU4JPeyRH+v3s0PRfhqTHLo7aS/vePpNsHbu1zsgdSPRtjHwognS/93JgTXLNCttuzVDKhNBAF9NgS4m5FIpXFCQFyTzdFRkgvYT+1pu1RSh1uT3iPmjqPrqPDom17nm9FKQN95DJbCBKkOhtzT2bOnXqWQUANDFuyrfMBkFjnEgBeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06WPm5E8GS3BBZLDc7SOcTeDtmfJIjTTCgpSJUVW46g=;
 b=iewcd5rT07UI2Jh7B0Xo4+csKeFLDeYViAfx32mXSRbLw4MVr0JiQ7exxBcNtCW/k2aTEqBQGkRp9APYgsvKbzOsb2XquXlsctZxgOZQcj0cBv9E50D2dVnG7uQaGW28BuJgejSdw8kH9bE3Pi5eJgJy+SpkmSPqvDbAP/Ngh3HJm8eZWb3Ut4rrYp7CDX0NJOHH0vUIwlSjtXTRnlZe8r4mODM1zs8Eetod/fpLl4omlMr/p6tEiuQ94LXJTzpw09Zc+8kwehAhX0nVq78JlLqCpztPD0C3UGju758wHPnSMvw42tc7f7cUyBpo/XNWUOZjIe2Hv2rVtmlYElOgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06WPm5E8GS3BBZLDc7SOcTeDtmfJIjTTCgpSJUVW46g=;
 b=HC+l0v1jnXP4eNdE2CuhXRDKM5DJ27cPGEOXVEZ7rz1CJ6jQVcYc441V3oxVzduHCJj/crIuE3h4OrwMcpEfumBjOn0OSW95mk7cjupZra87JIkL/zvetgo8NN7igZWzKsT7uFAS4eKRmbm9P/bZiQ9Op2654WSn0jXKtXXR9mJz3PXf0qIqB9fGCixdbeSoK/RoT4Snnd2JdAKa0ni8/yl9g6aJ8K8zFFYyDKU1Njz5OIhRCZs3n/ZQWktPAOIE16jIX8oB4u5ibO8iQ5eN1ZeNbJfKdcnMTVno0OSoXnj7s2I7MOMcdwUBTA5TVzlsRkUgLh4WTu4KLcRuJ+2O4w==
Received: from BN9PR03CA0964.namprd03.prod.outlook.com (2603:10b6:408:109::9)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 12:18:37 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::81) by BN9PR03CA0964.outlook.office365.com
 (2603:10b6:408:109::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Wed, 19 Jun 2024 12:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 12:18:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Jun
 2024 05:18:23 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 19 Jun 2024 05:18:16 -0700
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
Subject: [PATCH net-next v6 6/9] net: sfp: Add more extended compliance codes
Date: Wed, 19 Jun 2024 15:17:24 +0300
Message-ID: <20240619121727.3643161-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240619121727.3643161-1-danieller@nvidia.com>
References: <20240619121727.3643161-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 531f1a59-0229-4780-6bf5-08dc9059f259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|82310400023|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?joZd1/lIYOVIUKXAfcHNdvnm99IejXhU5gxsZ8gLaebN3wqLhRJd7/BDaR7U?=
 =?us-ascii?Q?jK1w1YMc0DV/rd8AGHtUSetkl6m9/0n8jlwegaFiI93htV2iqcfslT7YUBfo?=
 =?us-ascii?Q?wkl1quIP/tF9LDe09k6Pi2+cA1ANxcf0/Y7MHmsT9yUBeiFx58CT3fl82V4S?=
 =?us-ascii?Q?w7puff5FjBeEGVoouk8Vsh1QYZXySvtb+GlZAtGi2GDvZpLHFCQDn542mrL6?=
 =?us-ascii?Q?r32gHEnYI0WRvCCYzMQMv4qQm79rHGTTGz29o4myRR3IUAKrqefGboPrY8lv?=
 =?us-ascii?Q?K3ZHeBwzWyq7r+ZsLqFX8JHTQhJK51o6OSqap3A+raZs03pKkj1reHLSx58N?=
 =?us-ascii?Q?sPvz5WH/r5YRTIPL1ZJe3SVC6T06z0cV7T6DaZa4JjkwIVD+mEyOCPwrwk7r?=
 =?us-ascii?Q?7yFgXV16J54Ok7yfal76DMTwHYpV8/cuis2phKndyunF6VeIcEEGzjAKpHUT?=
 =?us-ascii?Q?/KBpTMsFcLGAJNfzKEvKqzMPJ3QFyddQuoGjqalxmHjz2ghkzfl+VBZQz5x4?=
 =?us-ascii?Q?AdYp0AFwITf4L7KnsujgHzxQWQQSaBQY01clTvMCrZa5XwjBIcPgTruzdfGp?=
 =?us-ascii?Q?DlAmhQdvspOXI6ZhGFup2bleg/mgEu+EEv77cELycwZ0CS77LA+Fya3hjMGU?=
 =?us-ascii?Q?V4L44QxhcKdkjJ1FqtylNFiMKMqog24HR/TYOgveU7OXq2mqTsTKD5Dn1dxZ?=
 =?us-ascii?Q?dctAoBuKXlrbOU8L/M+eDnlOQA3In1GPW6wMo/SXm5UtUuFTr0QjX/XoLp+A?=
 =?us-ascii?Q?3bclaisoLgepf1DgZjWo427HfbQJKabcf6ukR4QxajNAxX3ZnB+JSqL4dqdI?=
 =?us-ascii?Q?FzPvUfLgDfkQ4xVGG+y03NRIi5plGrgeCtPju3iB8sSOoBjgLoLEOlMC6o3A?=
 =?us-ascii?Q?Le9W7MUvnaGhJXQB6pXzNVwaNBzyU31o4dqeis7TsXDwtzSiKtX8IdGvzDYn?=
 =?us-ascii?Q?ebVBvsPAYIOs7of6pKV+TKdD390dVOpHGKmH0spefgE85TlB7Mr2057ejSDJ?=
 =?us-ascii?Q?s7mQ/qIOWnRXHakfHv1mlB6W1celGA5gepCdmaoyXJXas75bpzRR09O7Wqzf?=
 =?us-ascii?Q?4s2wONMrbboKJWsoe9bNDyN9x7ZQHFBcdu7FJbUZ0YUcOetChcnMJGUPI72S?=
 =?us-ascii?Q?rlQkTaNHwTYlPWyhibIl12Gzlx/KcCYvuviME5VfwH8/MlI6st+Elobi04b9?=
 =?us-ascii?Q?N4n5cQHYYtjgYpvdVEdbMl8QSFpHDNYka3+2JoPnMnQCzzUnCaE2NZEjmEV6?=
 =?us-ascii?Q?WYd5F/ZGHRGBr71osLgMuCO97E8wUtfSau4gwUuU4nBpxArnvuPG/m3W9DBc?=
 =?us-ascii?Q?1r5b0yRbwTcxDOnSA1HUQtdsKjtZmL8z8eRwgKV3BMwOS1NXBFphbPJuRsUH?=
 =?us-ascii?Q?iWY2x5MzJ28SzTkmBFcUMOVCWe83dP3iwuWSrB+y9guwoS72DA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(82310400023)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 12:18:37.0328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 531f1a59-0229-4780-6bf5-08dc9059f259
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222

SFF-8024 is used to define various constants re-used in several SFF
SFP-related specifications.

Add SFF-8024 extended compliance code definitions for CMIS compliant
modules and use them in the next patch to determine the firmware flashing
work.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
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


