Return-Path: <netdev+bounces-243505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF1CCA2BC1
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 09:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A8B430495CF
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D596D324B2F;
	Thu,  4 Dec 2025 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CUlxQ6Xq"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAE5322A1C
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835298; cv=fail; b=KrVsB6vMzqMb5vfFJEKh0N07sKqUcASIrs2P2z2u7a1F/g3KUq8AhDl3CAS8gPqFqlQRuMUw4XBCC+8tyuyvHlaV8R7sYawMInam3M/cxQH7LHWQ0LJEv6/o0WDwGfXaHUQ/iotKKezVQ+c63pjt+H8KTRdJlwWFU+kMHmbkQjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835298; c=relaxed/simple;
	bh=GzLMFRFay+aoAZtjOU46yp0leasB06u7TVUP8gvHwgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baTAw+cO16VUlWLK7q7IwDTD0hIzo1PiXumzjfUTUmNPVzjVotbXw0YExQCgF5Xwu/X5Fb54gxbcil2UPLalMtVaOE98HrSBkcwT0OXtFIcCj9O81KHqyWmypSJMCxwLaqGLTLos7DdBLQL3szr5NAlsVNvnLYu8HBFLd8Uy4bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CUlxQ6Xq; arc=fail smtp.client-ip=52.101.85.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQuwOaObe3C2xvy54nVjciRFEz52PslXf4dWmegYsozm3NkEog/FSNc9Jn+J73cE0iyKxKzDmX/w6gtTGcUBl5RadFuxUOLS3nt2Seg0V+kU70tcRij7yAFLpqKCsOruMB897Dvu1ZzFkdJ1U0wBau1w2W+AHcSgddQ9cuL4iAdSTVLxVQ5UxTlrJSfWt0zqqPrcOzl2naWU19OUn447mae0Ud26LxfHphvjwd5SIcDhW2a4UEUw/Po+s0HXGJ8KowlH+RqK6XvxBu/OPhuFLk2aYrYgvTpoRTA/MOgWE1c3kXzLQS7Wx+DXU2anhxGj6bny/LpiCc49UzBMj/EP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Oa8Q6bsv58zo/Og0m2mimEeXqwFSKTNTrj7dpFjEzo=;
 b=CfRlHU+NeiMdIj+JEB+UNkKGiXrakY6ZrsF5aRNJv3U1GO1EU4VRHmMH+hYJlTZUMndhrrwmrZjLHy13GtkPGevsCI7Ss3RjjHF28xZhryYIpJYz1LWvQf+R3u4occoMdltHtcfehkE9KeNBvGvitAtKwHPRe4J6+qBeHlb2mEWUiMH2tCIqO2gnDW+3vJ/uzeJEu8rPuE7QcLH1Uz9yrOpgB/Gtjm+dr49uuHcq23WzZF6elU2DJ93N1kE4heR1cSc05VK+BSXvyPwYgHYBIx2aCnrmb3+rzOpbbjrBYzTcFrbgt0dx/BKMlvGJxRRpvZTijzHktlHJAvj8cZ3I9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oa8Q6bsv58zo/Og0m2mimEeXqwFSKTNTrj7dpFjEzo=;
 b=CUlxQ6XqjuT43WpGzFZfvIz6WkGBI7+cGI1E74Qj85S7b5vke6tsvp5KT2nK5buKsj53Xs8q+Bz1j6tcUU7IgJqCmNUaldeOHPhSGOK8NEj5TD1wkHw50BVixZv39No/6CEAlZ7nh2gg1mcuchJP04Dy4CufbElkp555GmTCCER4HU+xHLwmuoKiHDRDSj+ARlr4U43OP/NPLY7kmwVKob5j/t0kqz/IS/XS9XUBSG4sHWVjwCSNlNDuX76k8OgFQzxshlBad6VkjnyMDtveCI69UhUogMuR+3F/rKOu45Ve1iH6O4oZu/BztSlTkDK/GNWIe6zedAhhXe7rixu5gA==
Received: from DM6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:5:190::16)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 08:01:22 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::24) by DM6PR11CA0003.outlook.office365.com
 (2603:10b6:5:190::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Thu,
 4 Dec 2025 08:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 08:01:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 00:01:05 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 00:01:04 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 00:01:03 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Michal Kubecek <mkubecek@suse.cz>, "John W . Linville"
	<linville@tuxdriver.com>
CC: <netdev@vger.kernel.org>, Yael Chemla <ychemla@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>
Subject: [PATCH ethtool 2/2] ethtool: add new 1600G modes to link mode tables
Date: Thu, 4 Dec 2025 09:59:30 +0200
Message-ID: <20251204075930.979564-3-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20251204075930.979564-1-cjubran@nvidia.com>
References: <20251204075930.979564-1-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: baeb0ce5-9733-4862-c274-08de330b5065
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rRKOK1uQtyr0WcbELABxTNe+lPn1BBF/4wfaz/xPqualb31C+pM3tVmQiCnA?=
 =?us-ascii?Q?OX2cF+cT8lZ2qvHFliaJWe+8I00+NhwHbOyg1/8ezLz2gnrNr+1RLrY6tgpb?=
 =?us-ascii?Q?aXpzMKMvoK0ezwfGF5twoPieq9AolBtwqGDoUBYxpldLscJlpCv/Dx5EBLn2?=
 =?us-ascii?Q?fNzz23+tx/teO6PMrVuBqB9Pkd719dtFtqmG0BcwRgKyryk2NYmbyBmUV/L8?=
 =?us-ascii?Q?bkwtddUS7zq2opIZoN5REAibbELnz7NS4p0A4AivYEX93z+Zt5ZZEomepppR?=
 =?us-ascii?Q?H5BATeCP3LPI7W8UQ7Hq7dI65IRSob3Qhn2E9YoNh9pg0w/YYVvlUPyf5yQ5?=
 =?us-ascii?Q?wcLkyxsbSMKI6rtfENBl80r3elEYbNMruKVEMfb6aRzLZuUFr0x5WdLkM0Yc?=
 =?us-ascii?Q?I/cY+hg8BZdZVJ8Vb0pR+sacXlMflsqFFFy7V7jxe5nLUm5XtI2s6MAvynUu?=
 =?us-ascii?Q?0ee+j567+Q9mMynFDb3gWdxoJzO1yZ399I6FdtGCrt6OWAxloaJDBGvkjTUN?=
 =?us-ascii?Q?3UByg+lftI0JHrsP6dfWHZXvGziYom7P2LvieDYrgAgePjvg9nc+xryFXkSX?=
 =?us-ascii?Q?vs/ioFwntCpHVmom+ZnusuWkTFdmYcej1IJBFilA4zGR7WFeikHoT+DEDA5+?=
 =?us-ascii?Q?0XRdSC1faQYlCzq4po6pOvsDnh5NWGPihVQA+1MlbQ5+Wd/ay9zOP17JlrLS?=
 =?us-ascii?Q?SG0HAQLLkv039D5NY0j+nl1rVYsHfv/R84kvTP+ZtnSA8+UI37aOvuD4NHLx?=
 =?us-ascii?Q?d72eLkkcCQf1HQTHNsaZ2l24jHDRPzvbtYF72I3tY+W2LUFBjNJdnaH3rg6j?=
 =?us-ascii?Q?p+/bXgCNeSxfeiToPsd0pjw8tZ5y9+QIFdpm1i3YKhyXnjYXkx8KaCwUhuLU?=
 =?us-ascii?Q?7OceBRcqAPim4dQWn+kFw+1+G8y/+PU0FzNuf/rroDaSCzlKkypyjEsKYqnz?=
 =?us-ascii?Q?mJCihcScncremtkC2MxMYAwZ8mpiSsSis7dPvb4mKFn6efXGuBHHV8Y2gqrw?=
 =?us-ascii?Q?9ZRrXy/hBxQzfPdTizf7NmBhslID7tDou6hU5UEI9BtLf1g1zJP2i/5gwe3y?=
 =?us-ascii?Q?iPTVpAd26k0ueMNI1U01N0cVqQlFfrgns7OMAmoAQ9LJuaIMri18HUzf3OzF?=
 =?us-ascii?Q?FQ35zhdJj+r9d/22EqVcsaHrQ37uzEVPYHZag4iX08NvxYTVLIM0jiSK3JB6?=
 =?us-ascii?Q?Px9TIg52ub0n3SqCXRAw84MbourPAtFGI8W5BJU5HEh9DmAE426AwS4B5//t?=
 =?us-ascii?Q?5p6auqKy1RSe0G/jPosauRZLyo9OTiR1HSVcSmoEHAa4uxhhhhhQ4JUaNp+x?=
 =?us-ascii?Q?fKfFDFRHGU2aoy93grvw9ZVss9CmFQdbowKnhUjd+oZe6Q9g0WBsfOPXbpRy?=
 =?us-ascii?Q?uYlUNpoKFCHuH2zeAwImUlA/ZQlCzNkoSe8pn/1+Qi8xaOcfNnbNsk9+Jh3t?=
 =?us-ascii?Q?fH9j/jAk9nwXEmt76GBpBCYEb82uzitGLjUBrVwKH911c+LJMRVgeY8+QgIa?=
 =?us-ascii?Q?7hV5l08zhwPIBYHgr/gZNPTwOq6Gw/VBQsAmsG9W3OmN9XGn2nNXz/3c2Ee0?=
 =?us-ascii?Q?n90pVjlKw6CzezfGAEo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 08:01:21.8268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baeb0ce5-9733-4862-c274-08de330b5065
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763

From: Yael Chemla <ychemla@nvidia.com>

Add the 1600G link mode bits, include them in capability dumps and
ioctl fallback, and update the man page.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
---
 ethtool.8.in       |  4 ++++
 ethtool.c          | 12 ++++++++++++
 netlink/settings.c |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/ethtool.8.in b/ethtool.8.in
index 553592b..2a3fc14 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -1013,6 +1013,10 @@ lB	l	lB.
 0x400000000000000000000000000000	800000baseDR4_2 Full
 0x800000000000000000000000000000	800000baseSR4 Full
 0x1000000000000000000000000000000	800000baseVR4 Full
+0x2000000000000000000000000000000	1600000baseCR8 Full
+0x4000000000000000000000000000000	1600000baseKR8 Full
+0x8000000000000000000000000000000	1600000baseDR8 Full
+0x10000000000000000000000000000000	1600000baseDR8_2 Full
 .TE
 .TP
 .BI phyad \ N
diff --git a/ethtool.c b/ethtool.c
index 948d551..21dea0b 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -538,6 +538,10 @@ static void init_global_link_mode_masks(void)
 		ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT,
 		ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT,
 		ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT,
+		ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT,
+		ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT,
+		ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT,
+		ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT,
 	};
 	static const enum ethtool_link_mode_bit_indices
 		additional_advertised_flags_bits[] = {
@@ -836,6 +840,14 @@ static void dump_link_caps(const char *prefix, const char *an_prefix,
 		  "800000baseSR4/Full" },
 		{ 0, ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT,
 		  "800000baseVR4/Full" },
+		{ 0, ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT,
+		  "1600000baseCR8/Full" },
+		{ 0, ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT,
+		  "1600000baseKR8/Full" },
+		{ 0, ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT,
+		  "1600000baseDR8/Full" },
+		{ 0, ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT,
+		  "1600000baseDR8_2/Full" },
 	};
 	int indent;
 	int did1, new_line_pend;
diff --git a/netlink/settings.c b/netlink/settings.c
index 84b2da8..05d215e 100644
--- a/netlink/settings.c
+++ b/netlink/settings.c
@@ -196,6 +196,10 @@ static const struct link_mode_info link_modes[] = {
 	[ETHTOOL_LINK_MODE_800000baseDR4_2_Full_BIT]	= __REAL(800000),
 	[ETHTOOL_LINK_MODE_800000baseSR4_Full_BIT]	= __REAL(800000),
 	[ETHTOOL_LINK_MODE_800000baseVR4_Full_BIT]	= __REAL(800000),
+	[ETHTOOL_LINK_MODE_1600000baseCR8_Full_BIT]	= __REAL(1600000),
+	[ETHTOOL_LINK_MODE_1600000baseKR8_Full_BIT]	= __REAL(1600000),
+	[ETHTOOL_LINK_MODE_1600000baseDR8_Full_BIT]	= __REAL(1600000),
+	[ETHTOOL_LINK_MODE_1600000baseDR8_2_Full_BIT]	= __REAL(1600000),
 };
 const unsigned int link_modes_count = ARRAY_SIZE(link_modes);
 
-- 
2.38.1


