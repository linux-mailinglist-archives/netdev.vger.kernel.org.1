Return-Path: <netdev+bounces-106225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD89155F0
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5671C22250
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D7C1A0709;
	Mon, 24 Jun 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHKErVIH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716D91A08BC;
	Mon, 24 Jun 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251601; cv=fail; b=WJrS4kUY5WYrvASRujttHDAUzf5Y58aLR5RENCYY6M/NHNOd9W399yaI4jkSTAqnQjcbVHzsnlRZnWFG+t2yHk+8isTf24iyI3d6r5iONPlBpY1HMWts2RJksvGNnrYgBU8VlxGxqkpgBi1b9A87pvuy0ld+MppuaRBgSBDh67Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251601; c=relaxed/simple;
	bh=ch0pfnApHsCdyjFizpjfxLpKh7QsAGNl9XyZat8Eg8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huNVs9u8+U3fb0cF0ECvY6TCfur+9Bsb6OX3ficifutPXPa7W2PGqgyYhE10UV/yg/3ElOYLKUA0guxaldM4wnXBUhi7F0jwGZeqR7QGIKTJhQ7vQWbpdMqPoL+Xao7Vb/RI06c8lRjuqWeHEcmOP9QpknclfHdsW0n75qqP9mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHKErVIH; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoTneaTtOwHalT4hGUDbcuK8FmyijZjKT8WQtlo1MDV0PCdjq2wAkUPQh2yMrleqt7HA+FyZyLKL9ErLhhHkBt+qoZMEayMFbY5vgCyDrXqehgHdE5OpRfvS4pjDiWEkanaowsyMGEWbGCAWhYuMLROtlpWABn7bXNsM4/hy/M1nfyxf/+IZvFVw0zoKuqAo/8Ou4Dzs/syEP6Rj8pjP9kBZNM43lrVKv8jrjAcFxsDm1edZz+9r81j7XDgjGN1k7Zk9lPnrwQ+G6QhJhYqzD7DGx0JKa9eTerxhIYvLBBiSCsF8GYPSpyyXHge2dn4a8/IYv3F8r/cBygHrreiL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06WPm5E8GS3BBZLDc7SOcTeDtmfJIjTTCgpSJUVW46g=;
 b=a+qNrjsTCMC2at9Q2XIAmHnQdPHNLSTDf6KG2b9plJIm+2EeCXj+RLnWgzMNp5IV0kzT8dcA3Vq7Yway4yQhdEshzCEmOIQVmXE4N59SWksUektMsxDjoTIRNj4mNeXmuSJL81b5Meow0JpPgbg0wKk40oYlmpXLpUfL7AaBTyma3O5wENOno2boIjAEGT3q4Q8vuqu5vPeQCWMs+vqSB4fQrBf2vl2OCNBlx7q8rdmFCs4clHRDeInnzzmIDVeGjXFTY1bOvOJRTK4Lwb7u4vaGFbTh9kZ2s6DZtIwzKAcVHxq2yp02Ze3mZNFO5dg1N+/+vhtYiplFc/NNNZC6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06WPm5E8GS3BBZLDc7SOcTeDtmfJIjTTCgpSJUVW46g=;
 b=tHKErVIHmarcmn3q2hgNfOKp7xUiHnDEwWPVOet/766gfhDmSNAUfiYiqUrRe3gwAeJGAD7mQv01ORmLGUpGK2+jR4cNmzM6V9Mj1Jua1NVnh4DEXDG6FLsSxPAwgwHKcFQm+qbwEGJchGZqk0r7VHQuTr0ndRa/o69Xm4HP2qh5DfQNt8jXtmwCIe8/6WKAJSnuPbGHxqUrFpHxhC78ov+7oVZON6Z9VT6MNOk9qgky4uapMNtsYGHrZYSvh5LPmaEJ0NkMB40rT8DYww6pWzgoCMkOgJAya16ynencpwFVSFNMX/8aPMTa/y+dqzLAeo8z7nQ2SkyQN0+wtqBZ6A==
Received: from SJ0PR03CA0142.namprd03.prod.outlook.com (2603:10b6:a03:33c::27)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 17:53:14 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::b0) by SJ0PR03CA0142.outlook.office365.com
 (2603:10b6:a03:33c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:53:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 10:52:57 -0700
Received: from dev-r-vrt-156.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 10:52:51 -0700
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
Subject: [PATCH net-next v7 6/9] net: sfp: Add more extended compliance codes
Date: Mon, 24 Jun 2024 20:51:56 +0300
Message-ID: <20240624175201.130522-7-danieller@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240624175201.130522-1-danieller@nvidia.com>
References: <20240624175201.130522-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: e6eee9af-409a-44f3-f056-08dc9476850d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9KoHaUouY60R9Z8dFU88/lR4Sj91UofB6Bcs03cyZJQ8ni1p80UXbUvhR0Jt?=
 =?us-ascii?Q?UxkYB0LiWpYmNvVadXka/GQLIi7J6m0gH+ACbafkblRr0azvMwVAbcBCqkKe?=
 =?us-ascii?Q?09mYOnb47ZYnQyJmJiHcAE8uZwE9mYibk5/jgLrrLzfyZkG67cdsoLG9iELH?=
 =?us-ascii?Q?apPoHEuqDgA6WaFA1N5IyErj3okSDtmIS9dArs389CwS3KeVlnD2ZGYPsWBq?=
 =?us-ascii?Q?A8IIyRDKNvMZv3FdoRyhBFBp+bRhztKzy9VhJHLMNZ9wccsVv+WsZEkIjqyt?=
 =?us-ascii?Q?331uY2ZRVxQO0ah3iEOt9/ZJF7mmI24AXQWuKe6IexMWDbSlONYzc+soJqIX?=
 =?us-ascii?Q?XKoK8pYYbSWRgezMZV4Lltm3YD9/8wGjcqWS8c9D0ryTvJN5FcgcSLV8onll?=
 =?us-ascii?Q?QzNdNyXjjVUVKWgRHRwfOhBqaUGZwp9wjosRIX0Bt3n51uMbxe3rAcorud2i?=
 =?us-ascii?Q?NkhQnvwByMg9saLtK4pgGZUAdKZCSPWJyMJMqh3CQldJcbVYhn8+o+H6Tf4e?=
 =?us-ascii?Q?/fBrBdngmvPnMtmqXN9iVWZpAPlJTsEGFc86Yl47SWv+XOWF0FGylVGMyRCJ?=
 =?us-ascii?Q?hsFUcJvxcypGVCL2BgXh5hIvA57PZxdcYdoFDNOqoLReZX1UISVV5kfDLF8U?=
 =?us-ascii?Q?EkWhCIR+wriwRVaq0Ie8Yyk+YQ3Hd43L9s3lQTr3HyGHYWCOovRnfhVv7oQ2?=
 =?us-ascii?Q?q7ukaION94ItAqZRFWMuxjg3tGEjkC44LS0PeaaA7EX0O2meiQh3jjYcSC6p?=
 =?us-ascii?Q?ntCOoebi/3t64K2SYGhPF5dVmAQPZCn3srX42vG4pZGsKhcGbOQYqepk8y+O?=
 =?us-ascii?Q?sz8HEDTzStYSGHKZHfB56C0Ogj5Ixj+aZqpd5qNYoGMMjJz1VDysx+GpQ3GU?=
 =?us-ascii?Q?rHChyipjK5h2SnKhgHAq/H9G+YUr0eSdai0hCx9KyEYhn+mcbOvWnwRnm/se?=
 =?us-ascii?Q?q+nIMpfCZv5073kdgMvhNk9g56tNBj8Dl1UnQcKpaMSYKjcnSZpaoEz0XyEg?=
 =?us-ascii?Q?FxZdRV8GGP8u3eIoZgJA0SzM5B++Wl89OjN2WDXcwX67UPfO9FJHlzAiIwk5?=
 =?us-ascii?Q?seAlAJvhp2M0yuZo9mmdM6woiGyYx0UdCsdT3DCVshYATZ7EOLd47dA8EjeO?=
 =?us-ascii?Q?QTVEotGxTc4s0EENZpQ0IAVs1P4Rl2ENMsk41xvgycZW6I56YEQOP4b6C6VB?=
 =?us-ascii?Q?RxX7GoDPs3UMslueRtCK1QyhU5EAlfQHWsIg9nipuUVu+6rdqmqsA0IpC8b4?=
 =?us-ascii?Q?2nPxoqhCyujQJkYEsBdwQvRMp924WwYwrpP+JK/1+BZJQLmuD0tafyfDYcy8?=
 =?us-ascii?Q?lSqdOZufHDlnTGpcJG9c6rUXArXmblUAPfFGaD1QZcMjn/iU5LCfL3PPYjT0?=
 =?us-ascii?Q?RpzkqXPf1uU4Ug29BwNtBmuox+4AFx/+pnYxRkUhz4rLTZTL3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:53:13.7852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6eee9af-409a-44f3-f056-08dc9476850d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347

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


