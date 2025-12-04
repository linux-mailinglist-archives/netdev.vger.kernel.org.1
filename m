Return-Path: <netdev+bounces-243504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37130CA2BAF
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 09:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 483AB301EF91
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 08:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04C322DA8;
	Thu,  4 Dec 2025 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mSIy1hFZ"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6432142D
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764835285; cv=fail; b=kqleFRbx6KWC6tD1Q9OIXhj9xBiy/A/ooXyQxoZ9YIWtFmW+N6NPqrcp8fsPYkSXzSaN68zvG+J7fHM4nbsFcj8TTbfdVV+VacBN2KJmV2C4w/cNfqMc8o8aXF7HrGPMB8JnRye1o2ydOgcV2tVdNfB5FJK4IHIQ0Nhe8O4gvJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764835285; c=relaxed/simple;
	bh=R/ydoeUBuzGDRAaMW7LeQL/dw4/BIJzK7l+sgQS2nKM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t/kkirhkovqNwuJ7FT3nFfPXWVvRC0HCwv81IXZwg8/L1DsLA3E8k0vsJK2UeH47dfloEgumCzGLpVQ4FKjuDw5y03NmXK+duBGgSClaE0Q33+EtrAqtiqBslyQzvkGhp73fZ5xYSU3WuM+TNYE363WNwnvwOiKevO0Oi2vmpYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mSIy1hFZ; arc=fail smtp.client-ip=52.101.201.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saUclBLDzF4T8AVGM8Bi8ey1JUn0SjiqlS9Gc1oK5jgXr9/OucRmYFo0ClqiIsb80nZ4oiZeuoCMrXBT+f3nmoZhhLji5pV6WS+A49xgH/cn8wQ0ker3mnXXmvmGyydnbe89UGYNuR6kbTnbbxCtJvL/W8eXYpq74rSviAKYYzh1PhqeRZAWkU6zskmauwx7zjydwNN5rV/34ZRZmi8sq1K9y95y9lyGJXyuIAvZOZcSB/esNckOm64Ywu7XUvDBT2nDPEj7v58CpMWv0oYmFl+iAwnSTB9iq9CtQ1AhuCMsypukxF8bQFJg9N3vBVKxiAPVeeDdFru8opDSHG1aug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPbi0MzYVwPVithQ/zvHL+LHC1SPISIipN8Lmu2+cB0=;
 b=NjTbp0NMMJQQpXguKjhy00/6+Fors/pSyLxgXWdMpXDPGfjzzh/Xo6h2baxwpni2Ljq0J25drR10Mqdusdo1ruQlkHzOWjzxOacpZ6sKl6gdmmn/lwtbba1WVsVZqz0/MGb2711P+4Y/bEI0MVhzBLGUi7LthkzvdAJldJPGEGpWmWlBzhyyINY4ZvvhBcYkIH8Bx7ag2mp7bHdMciDJBdA02zFbLDd8LdqDmPBlu5WkwAt0EOdhsRBnF2IH8a650iqW19jutXUnfTcIYEUfeyOiJFIbcdoXckeGxJ0WhuEOW+ei1vPEM4wXnU+Oy8kauHurFX83wvLQxu8um3OGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPbi0MzYVwPVithQ/zvHL+LHC1SPISIipN8Lmu2+cB0=;
 b=mSIy1hFZ4Vd+KkDM/8ZkEt3MmXN9CQh9/86gdnNB0CXImWbQ/Cbd0//80g55oX05Xli4dIoQufG6BRTBvaIoS1SFo1/+pk6DVoQ7iGfu528rByQqf6h70AOEuBpwvkHpb3JWG1sBDmKwLhz+5rcy4xDjtrK3mUDwBDPLjxcyVxyiSNScTRxYy2ZMlOr8dNnZV8x9opYxmYxyvE3jvzDK5mfLMHP710HJsqnLoR0+nGwzIOLs4pEMKSkoxYL2IC5AVA+6iCd2eIPJ6lAPjUvR5yaI7P1mproVZl9qk+ZOauQKeS7phr1sizE2KoJbKnB6vt9t9Jx6axcVJTuK52m59Q==
Received: from DM6PR18CA0032.namprd18.prod.outlook.com (2603:10b6:5:15b::45)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 4 Dec
 2025 08:01:15 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:15b:cafe::d0) by DM6PR18CA0032.outlook.office365.com
 (2603:10b6:5:15b::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 08:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 08:01:14 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 00:00:57 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 00:00:57 -0800
Received: from fedora.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 4 Dec 2025 00:00:56 -0800
From: Carolina Jubran <cjubran@nvidia.com>
To: Michal Kubecek <mkubecek@suse.cz>, "John W . Linville"
	<linville@tuxdriver.com>
CC: <netdev@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH ethtool 0/2] ethtool: Add support for 1600G link modes
Date: Thu, 4 Dec 2025 09:59:28 +0200
Message-ID: <20251204075930.979564-1-cjubran@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 47de970d-48a4-4c76-73f5-08de330b4bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZdpVa8Hy2Sn8UMm7xnvanJRtrNm3yylq/Fdbc3D1QuBu+/IvCvo/U4dH2Mym?=
 =?us-ascii?Q?S6y5dWaOe6naUfOxrf7Zgi9NdnUOnekTCUl1J4VcIiPyFdjz1IC6PyxXqbh1?=
 =?us-ascii?Q?/N5Ol/KlbyP7DJ8Vl92AYX2DfrqhxVCKkGfQsyMCPssO50g3SEAlzw06pzEb?=
 =?us-ascii?Q?iXYjsMJIqda3pc7iEgUz4JSIL8YpWZA6Fm0NTVA7O6bqOIpm1Vpf4uq/Acfb?=
 =?us-ascii?Q?sYUG8a7kzA4qsiXT/KqFN//stoEwt+jjBSc/AG2tNbo+f3VtYVd3PIqd7Ixd?=
 =?us-ascii?Q?chPNxTMvxPwoOW0KmCxO7v4w9Ya2I1fdPZCpqVpPf2IeG/KUSfZk7ja/Autp?=
 =?us-ascii?Q?ciPeKyDxnSOshj2VTjt3j3XTul0jZFw+Xovj+WzZB3nHnOrT7v3Pm8ifG1vi?=
 =?us-ascii?Q?/wmp83XFAgHAwbLSMTMagxmbCz9k5yWOiLiBwCbRduSMu34/z+d8+87JoK3Y?=
 =?us-ascii?Q?uPojs/avxRrZst8Hwj6MJrrj+l5bpKN3cm+ZYuB3XINN6muPNSdJt/Ppi9vP?=
 =?us-ascii?Q?qzn5XYYOvQfhYbJGpWuZzJIqVoZz2RJLQb/WfZyiBXH3GyMq0Uw36p3ILoiy?=
 =?us-ascii?Q?9AhvXbdUvDsDsxu0jaqipZtZQ84hN0U9UOAPVSqN0Sfv4wmkAEdodDyPVV0C?=
 =?us-ascii?Q?0ip2pWAhbJQB8KHx274f3wgOc+URFvjP9k3RejnZD4YN2h7kxcTNuO40YMxz?=
 =?us-ascii?Q?nWFGLwy01H1E36FeKyKSFR0M9UvfGqxDxB0gRzNsBpY8ZheJXCPpI2pe/Kl/?=
 =?us-ascii?Q?njtBv/t4hy2HKhDlXtxChRL8D5d6TpcOa74dJMC6wiTE+yzW1W+Oyt+0gPsV?=
 =?us-ascii?Q?6jdXO5b0Bec8OxBNngt2SmUBQaThU9XBi3Eaa2XH0SL++nMXj6Aewfdx3Kgu?=
 =?us-ascii?Q?UKMmgDlWCiM0DWELwgs0ghQoiyujPsWO1d/2hm0TFOBsngTXljWtf3bZ2SNB?=
 =?us-ascii?Q?yNDQ66Gl058D5gLNb70sMOB+6bfMckWrTr2tnVDRaDnFFJ9K4qVUzbEfj7sn?=
 =?us-ascii?Q?pdl3Z2MgQKEzyTl2dF/vU2fxqDuglsUfchhFersUx+CnpH3Eb782ecCYCEVS?=
 =?us-ascii?Q?fz3UTDaQmgF2tqDXyEaFtkfcYlRQOVm02xnynuXR5HJgmpSw5tilUh/UX6ng?=
 =?us-ascii?Q?4e6nC4Yx+g+vxjCOWRWzhzhT2/TXd0MOqyVa2NVOH/WK7goxvjwzvPTeyIWq?=
 =?us-ascii?Q?VnxdrioIzg9xaBTXP0WNZHAiY13bI4Dlm7fPtMf4UmmjtHS/62EyB5w90mFw?=
 =?us-ascii?Q?Jo75msHdiZQqUIPj4PB65skUMDpx5hndUlokKqj6xdthMdrkiClhzd2gvmWS?=
 =?us-ascii?Q?5u10g3Sv2PNxR7oatjpJj0a2G8xkyruw05YU4YCJEQqRkQKo38JN7BL89Tvu?=
 =?us-ascii?Q?xPRjD1j2nWsNih433HCAyc9VMMu5pfACqtTdLzbHjYHVxAjRhqRPo1O94VBz?=
 =?us-ascii?Q?4H8Y/+MYyrPvYheDpabj2o+0/BDa0klAlzJX0GuNEzU1guQk72Plte7ezelw?=
 =?us-ascii?Q?1+NUEIpAAqVL8ShNpy1M1eJiTKRGqiMFunDE7QTKT+GlTL4cV/fYfE5AjYsB?=
 =?us-ascii?Q?+KYRdn7Xz27KX71AXOs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 08:01:14.4086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47de970d-48a4-4c76-73f5-08de330b4bfa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997

Hi,

This series by Yael updates the UAPI header copies from the kernel and
adds support in ethtool for the new 1600G link modes.

Thanks,
Carolina

Yael Chemla (2):
  update UAPI header copies
  ethtool: add new 1600G modes to link mode tables

 ethtool.8.in                           |  4 +++
 ethtool.c                              | 12 +++++++
 netlink/settings.c                     |  4 +++
 uapi/linux/ethtool.h                   |  6 ++++
 uapi/linux/ethtool_netlink_generated.h | 47 ++++++++++++++++++++++++++
 uapi/linux/if_ether.h                  |  2 ++
 uapi/linux/if_link.h                   |  3 ++
 uapi/linux/stddef.h                    |  1 -
 8 files changed, 78 insertions(+), 1 deletion(-)

-- 
2.38.1


