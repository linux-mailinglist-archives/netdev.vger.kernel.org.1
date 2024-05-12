Return-Path: <netdev+bounces-95773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F29DF8C368C
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 14:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686F61F21E03
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12E32033A;
	Sun, 12 May 2024 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ovGhLpye"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D21CAAF
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715517853; cv=fail; b=Ldpdmu5qkzpruVwxqeR2i28JTOxZeQUs5WVSFWeX8ArjFWFgTDv8yxFttflGceXqaAsKT4HgvTPY5QzlVZ5O+w4ivZHzxI3P25Gk1qU5Qp5HPMPq/WNclvMwLXVjjZ6WFIbmWNnUFxBjwkPuFlbNF//yxTDR3xxbFNMgiUqy1lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715517853; c=relaxed/simple;
	bh=RI55n3p4qvUSlsA6AX5ZJ8qVuBtB/u7zs21hFkRkqzo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uL7lAkWI6gccUlnCS6bV3SrDa5qwPlb/YEvEf80zyx1tJS1tmJQRDxfafkCN7C1ceAM2SarDNKkGnqameB7D/MLAXDo8EkocN87UkXxC+Y8e7kTJ3yJL27wK58Kh/Fazgssemli5a57p5NcZ+eKkx3XOQF+KqgJ4fIi8tKDri1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ovGhLpye; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X91Ynr/uS/ghmOK0U1O8ksZ1PhlKloQcL8MMsO0sTTjPQBeAWE4hKcgrKqeY8h2CGIFEt1+XLRgfoo2co2MIs7kra8xfY/bYAQmE0yAztfHija11sbyO1NdVug7MDFijZb/4uWDF/15rTbo7ZNDcKNFsSbVwCRFYTfi4APGYWJaXd4q0q2xr2NYXzEuC5ojWBMzumgbMIRs0CqgoAJfolONSf8m1lUKzxqvgiyswIwyjpgW1zzQfHqwrMvi+6rkusKJohShlq0hZLTVYy1+t74oNZ+5fkz9NBjj8n4pYu+tpX/OdJBwAqZ76M7M31fLc86unz0SFe7ZLm4Gk5oBLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cnK+S1KUpQZ/LtPbs2Nduy/N4i0RpoE3VzCgJ6e1QU=;
 b=VVfPgxFfstqvYN6uU1k0vnpGgBGgFD3Zhp1p6gtBzPz2Oq+eHGiDJZU28o2DaSTt19ZMRvPTH8mjVHFZKBbs5YYZ2m1op5XcYvIEPjOwAyFDuvXeimIm4XYndvwa2h7bpIkA9+Cvdy9t22S0OG/Hk395th464lnO8YH7SeYhlBn6hoV66ZOnMyvD26QgQhPXvoly1hhQul7FPOfWk6kznVkRuyo/3MkBo6opb5CAb1Y5diw0/BeRIcYdiHSweKFWVMcoH+VIocpxNHb2zxr1nAAkfeX/uJjLfq/A66cUT94Bn7Rs5iETKWySfVz+wRvtWBljbAAATY+Kb2C8soVG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cnK+S1KUpQZ/LtPbs2Nduy/N4i0RpoE3VzCgJ6e1QU=;
 b=ovGhLpyeMp0wFWBU+gcT8ZPXN8cOhJMdz4tsQymWkZ46Duv0ThqBP8cZ1ZxBQ8VImZvD0a1vo2ZuC53syJUKXCflk41m5S/nIf2jo61lFwerkWd8SRpjSPctTKiSAqx/uHZ3KjZqPEMmFRSW1l2vAtqvL4IA9x5SKnZHUtmR8SnMX1kNu+2AmXWHzphEXEOqgQY/w6FI/FLrLoQ3jAUiFaznIuhPlIu9x8/EBWopdct8gQQbgQYICrRiN4qsgCLTK85I+D2f/p2ViAlCe0U0kUIn7hSxoxGZvbhFngeuGS86MRNQmNDJKcUtzUe+qTs8+Wt1Qhn0XPvPL7i26rWAqw==
Received: from SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) by DS0PR12MB6629.namprd12.prod.outlook.com
 (2603:10b6:8:d3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 12:44:08 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:803:41:cafe::5) by SN4PR0501CA0069.outlook.office365.com
 (2603:10b6:803:41::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.21 via Frontend
 Transport; Sun, 12 May 2024 12:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 12:44:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 05:43:45 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 05:43:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Sun, 12 May
 2024 05:43:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 0/3] mlx5 misc patches
Date: Sun, 12 May 2024 15:43:02 +0300
Message-ID: <20240512124306.740898-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 14562b93-c5b8-4c91-4db1-08dc72813738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QhDcYxkEfPM5sKH3JnO47tXvTjTy38LFqvMd0HdR/WnV8eblWxBAkSoJRWV8?=
 =?us-ascii?Q?llsynXD/NaciKziq92x9i/Ixkh9tH4c0adSpbej3tiDRef4NqdGYJ9I6DdtC?=
 =?us-ascii?Q?OR9a8OLnaL5HKZHcdVdctdyy17h34oPcUd+1pLTNa5zZANaus56PViJ14Yxy?=
 =?us-ascii?Q?esJtO2EQbul1yAiAWz1dHdVBbi0CmAp0IRK2hvtuUed6lGG3lFbQXnMu/W+2?=
 =?us-ascii?Q?d6u404JbKZGpOyVlNa490FgHuH33CkFGf9dSCEb+L3QjDIu1q9DlQjpXuilW?=
 =?us-ascii?Q?5NbWW/9IXil+PEOXjxQEQVS8Af1BPXic7wiOIiHy1rmDUzBCpeQ3f2HmKmlD?=
 =?us-ascii?Q?se9U6knjCT2x1/ePNT1Hb//n81r86GihQ2XHEHUfPIDhjSb5grbSbIGtLxTR?=
 =?us-ascii?Q?vgi59jIYoX5oP1licEK6Hv+dmKTeicbVm6HOxAJBZ+vLc16c9yM0hS8xKNlo?=
 =?us-ascii?Q?1KrrznVYSm5crJ1YqeDMsr/E5TFEJuUPHmGjSvaNgem51+P4A967PK0sfewJ?=
 =?us-ascii?Q?7bsWxE9vnjBK51OIf1u5jROfoxstImHjoDRluG+v/Dc/m8I/wKF+e+ASynOc?=
 =?us-ascii?Q?cbwSc90rkWBzuWA74n9PzjnbbAgvarBiqyoYPktRA0loNJDh0tm3dDptMCsz?=
 =?us-ascii?Q?lndfmJ98s+jDlcBdLrtEM5IaaSsg5c/0plwCitGkd/ahLit99AAuTxUMF4d0?=
 =?us-ascii?Q?AJa1d7Mq+fdPzK2dUdNM7jixmLC+r7AP++2T6AXH4hZ/Xh2fPUTyXTtHSmk5?=
 =?us-ascii?Q?2ye3r5NRLTuwegAb24UG5OFJ/4CAMb2X4j7r2xpA/gNmfijfdlAwocV14p4u?=
 =?us-ascii?Q?IVtR6+Q4ZyUwuxAaq3riJWWdhWUENzndbBTcGaxvt6197LKDT3bp/OiIxDgT?=
 =?us-ascii?Q?MCSwLP1uiOAjlK+yJ4agy7DuNidb3pZ/8txUuZ8EqHWCv5e9lphLZxpyM09r?=
 =?us-ascii?Q?Eas4VjvpNMcjJML0AR7HFUhXN3uuhcFm4bGbaC2/ypajolpGVGf3ZKjGnLtu?=
 =?us-ascii?Q?4OdFAjgclmv1/H/Ixq+iQ+rhEsJJh+nmZ94NKAH1LaNVx0lDF7p8odIxZUvH?=
 =?us-ascii?Q?79vo7mNJP9AMnbOWC+gLu7XVDIzWgwYVugkvgfSMsBP8lv9QaO7H42BFXz6n?=
 =?us-ascii?Q?0EycGL3SjQkZD6bkXSE0+n3z5ONhRkCbdqZR666xIQ1Ymuht22rH4jpWDeGw?=
 =?us-ascii?Q?mzzSZHlnu89fuvE9Lwsbjo2Ma4/ss6cYf6Ip9NTXz3Ds1vOAdhUPjpVIaBPK?=
 =?us-ascii?Q?ZTIfhJa99HBpc8KKJhEqDj4vBkJe961NLcwEnsMQAaMT9+bDKHrGzuYQn2KP?=
 =?us-ascii?Q?Y1wRomXoIcF9tLVhtVOuG9gObI3S1XnA3GnM0TNmXfcER51dM4TfDzFTA6Ov?=
 =?us-ascii?Q?BfUEjLxtiUa3VxIMFCN7AqgAjXt9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 12:44:08.0989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14562b93-c5b8-4c91-4db1-08dc72813738
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629

Hi,

This series includes patches for the mlx5 driver.

Patch 1 by Shay enables LAG with HCAs of 8 ports.

Patch 2 by Carolina optimizes the safe switch channels operation for the
TX-only changes.

Patch 3 by Parav cleans up some unused code.

Series generated against:
commit cddd2dc6390b ("Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue")

Thanks,
Tariq.

Carolina Jubran (1):
  net/mlx5e: Modifying channels number and updating TX queues

Parav Pandit (1):
  net/mlx5: Remove unused msix related exported APIs

Shay Drory (1):
  net/mlx5: Enable 8 ports LAG

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 95 +++++++++----------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  3 -
 .../net/ethernet/mellanox/mlx5/core/pci_irq.c | 52 ----------
 include/linux/mlx5/driver.h                   |  9 +-
 6 files changed, 48 insertions(+), 114 deletions(-)

-- 
2.44.0


