Return-Path: <netdev+bounces-100348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 943348D8B44
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D32B246E5
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F9C13B588;
	Mon,  3 Jun 2024 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OGDHUnGD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A7134409
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448760; cv=fail; b=A74uiZRWiEh9A3wJ91u91KyMQWZLp+EEyqwJDC+G7bdNn12/vYAwz5GAmctM2rUyqE3GBPZUAreryTeOXyx4CUbiqgIX4Hp0LQSscMbBc7CLB65WGY7YUp/SzeV2ibmzQY69sidAWQTjZUk8L7/NXKVrJI9gEakRcgkAS6644a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448760; c=relaxed/simple;
	bh=idzSrI9HtyrjM5GtWUeS+MO5zxvhR5kp2jkR9x9LGK0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=giR/73Fr21Px9RI46qvlBkd0+RnCBpyXmajJNgh6CtMLv0WMODHksg4JlgSr6sdA1ZWVjo7u2o8xOCNm7uqcgv+eko5jwwBAWeQxP5UAlpRdqAnUz0jqQ+v7uaX/sqxVfnjXH92YDIu8qNZbtCfZdOmPIrRGb9uHRUobO5QXN40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OGDHUnGD; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeQ19q56EHPahImiF4M8dk3w2JHwLUC2+gvRgYO3PnRIk8nGjtzf89Gnc7JgPxbCx/l9SheSjyce110/XvS4wM5b73OWkhIIbTHSlsgBYrgkmo5gCQuzs1faiS3uhEnfEg2DqmhhH5Aoxr5gZw/UjcetkwXdGLo3j6tY3dL5DWYcg8FMAI3w9RNHebk4HUUa3keSfSzSy5fAAXooJkYsZ4GzkGv6XZIYiNu/5NoyMzlz71K5ODtIqIytdimmkSS/i00rxl34Brw8Ptacaig54paUkMWCDa2JbWxAaBRuB0JHD2p6ZLldTioCRtTuXaIdKnRDJw/j3kWJWu0Z4r7UVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZ2rspHFamPH55/l7e5R+juxuavxsE9dyJsF99KbL84=;
 b=hK0HPckQ2YY6f0up/OmMn1EHaExCHW8Nk2LDiqz+HuQbEoIs4j7DcfG6QJtGJGkli9p3gAHZIJ98MrMWYIZ1LyOGNSFiLA6taBvzkB2F8s35x6wc455MrAxyqDJM8EF4ay33Jqcwg2OOW2hYKltJJtmgN6+wBpAPlKsyGvgPGWmgcTQaiTx+UTZu1MLM+sQj+we2YRHSnNxzNzzGgaTBvcI99hK+uOHcDu/1WvbvjXP2y2Np4g1gfV7RLiI5wqlm7qGIgHHF2sLvgPhDelTpr8lUV1QucDj/WvY5cwDu0c64NUBCD38ji6VpsmAxBpj7wsU9vMMq+prjrTJtHX/loA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZ2rspHFamPH55/l7e5R+juxuavxsE9dyJsF99KbL84=;
 b=OGDHUnGDpy6RJzVHlDNZLRUrsDurnXKZks5xBIExXf+G3QxkN3ToVsFpjWo+xlYFykHhcYnonToUoQEiq19RRZ9aRuBn8Pfc99ONtUkCHrn8ExqxsiSYYw1tViTsAia/Ea2wJeve3wFKmyY0UifwGypN490vlqGwDwIzdjc/1+glEV5osQPkmsoWTnkEhunHBFcHdPSJPxo3UBeqiN9fTuyDb2BWE+XdwMfVgJCAAWxlIUncCPoIs9/y8wBz7Z0VyPjS5DywxBze1NXulLSXiOVeH/3IFiN4DQ2MlNP/eo8s8+J8DJjL8/p6iL4oQZinN00hBkCP9rpS5f4+qC83jw==
Received: from DS7PR03CA0346.namprd03.prod.outlook.com (2603:10b6:8:55::9) by
 DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.27; Mon, 3 Jun 2024 21:05:56 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::af) by DS7PR03CA0346.outlook.office365.com
 (2603:10b6:8:55::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Mon, 3 Jun 2024 21:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 21:05:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Jun 2024
 14:05:48 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 3 Jun 2024 14:05:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 3 Jun 2024 14:05:46 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/2] mlx5 core fixes 20240603
Date: Tue, 4 Jun 2024 00:04:41 +0300
Message-ID: <20240603210443.980518-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 5458ae53-6352-421c-0d3c-08dc8410f644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?scybYp4028AqoBuDivlBTUfpexQGybTQhUBelk3oR7tbDqEus3JiV0tzAuWN?=
 =?us-ascii?Q?8g0iILm65HwIFyS4GK7OVg/rYzl64naTEuCCcbuTsxMRc8AgeAJi10TcxHEy?=
 =?us-ascii?Q?e0Gwcm4vZgPyVXftLTXPCwFBWcZ142XDUNWz+2xcvxI8zBQTjK83oDi1QbE6?=
 =?us-ascii?Q?/yTIvvlvhDQZ7SmhW1tO8uumRuH7gEp/5V6hZhse8FmQDscnlQ3zn9aU8I6r?=
 =?us-ascii?Q?D0ofNJh4pEfBsNdVau7+Jq+8i4dXQ82p3r6APlLqKzkgKoLMIpY3Ja+68sPW?=
 =?us-ascii?Q?Vxs5uhui32Lo8TzvNZxjPF3AnuvS02Y8c5T2J/PUh3YCz6DuLRmhg2GfRitX?=
 =?us-ascii?Q?0b5XoyItV5xU8j6Q9OziJFFWfBerUQJ+Ra9/sN5a4epUfYgMzWtg1nCQVb25?=
 =?us-ascii?Q?4ekPLUp8VOjiJFPgOPSjZWKIz19egXtsu75nyHVw8Jl2haxGhGedFayMBzBb?=
 =?us-ascii?Q?fyupW5UxRep5JZVYMEvVzoyGqbSvU9rW9zhC6a3nUjxrU0OVijl1MqbUDALi?=
 =?us-ascii?Q?bdmdmIVySrKzyYEjkTd1nv3mpXxNnhmh5OpVKM0rVnIa1PyEwuMT3dBMcHqW?=
 =?us-ascii?Q?p2T9O+l+9EVWl2FI7ht+khpM6nDkqR6LXGP+k0CG19EeifMq7ETkF2TICtUL?=
 =?us-ascii?Q?DNgfXftBTaKJgVzvxJ2LAIEnkas0iTf5GppSik5Tc6PN29RVEB0DGP29jxuf?=
 =?us-ascii?Q?WfKrGDiMsH4hbGs/2fAiP0k58we2JWBISCWiPEMakx8d4Cf72e6trGFeIY/O?=
 =?us-ascii?Q?UICY3nVB6nkSejlHNBypXhAuVAKQzw6sOkxOvaE3U0dfM/odA17g2gtkGDNv?=
 =?us-ascii?Q?ADPj1qJ0VZUhaDZlzFCQF0zXKXbDSNRlxlALnVi3eX9DBG7WDdUnPYcnsO+0?=
 =?us-ascii?Q?dThc7lw2dEUIhcAkpC8WrvWoMkegI6ZzvcuiCbCGjkc6cXhRtcDEQ/uWXgN/?=
 =?us-ascii?Q?nXGZPUssH0vdZlCPpEhY8+OeEfmj7SqjxeTte1GmLvh3EChQ45xiCBbwwl5i?=
 =?us-ascii?Q?u3erPNLQPBxI3nu5oUsqaFm4xO+zDPSG5HLlwmtGfvJxevfOnfa7rn5mz9TV?=
 =?us-ascii?Q?HwqCgXU59XCLzLTE04khYGCLWZW04y6NwZKVhFTyD4JNagt7At9qDfxXZGcn?=
 =?us-ascii?Q?I1ELGirgtZxSbhQzB99bV/zjvNVYdtaBMIzZftl6VH+odnHbPd16oF9TifyI?=
 =?us-ascii?Q?cUwvYhfHEN3Brf1wxjvEXMxs1oC6ZGEQqD4KKLdok1nTtty2Z6VvlK4smPbY?=
 =?us-ascii?Q?40puqpeSFiUfI27I3Z8JNhHI5Wtj5oV6aULsifoqsQYXpZ3We81oD2w0cmSX?=
 =?us-ascii?Q?9eHTl50RCKainXV+0eC7fWvzoInbLNpXTGieVvwNPgDcrqnSx0Zv95pVcSjt?=
 =?us-ascii?Q?uUaAEmM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 21:05:56.4359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5458ae53-6352-421c-0d3c-08dc8410f644
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296

Hi,

This small patchset provides two bug fixes from the team to the mlx5 core driver.

Series generated against:
commit 33700a0c9b56 ("net/tcp: Don't consider TCP_CLOSE in TCP_AO_ESTABLISHED")

Regards,
Tariq

Moshe Shemesh (1):
  net/mlx5: Stop waiting for PCI if pci channel is offline

Shay Drory (1):
  net/mlx5: Always stop health timer during driver removal

 drivers/net/ethernet/mellanox/mlx5/core/fw.c          | 4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/health.c      | 8 ++++++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
 drivers/net/ethernet/mellanox/mlx5/core/main.c        | 3 +++
 4 files changed, 19 insertions(+)

-- 
2.31.1


