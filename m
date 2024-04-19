Return-Path: <netdev+bounces-89533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA38AA9B9
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18CF281E69
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978B4314E;
	Fri, 19 Apr 2024 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R2GdrUhE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6453385
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 08:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713513983; cv=fail; b=l0979pDY8jvB9CR6Nwb60UzlvY9EHHT7x37GZtDKL7a53vnFhee76DEINz8paXJuxeP+mmllLNPVxzaFBdwZrr+YfvECeiksZv60W/JdJe7oaO1P5fbRlXLut3kSuYcRXEm7czmnx7nm1Ez/KiGR32WUICYqA8gsUPWh7CQJNek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713513983; c=relaxed/simple;
	bh=25w+x7rX9B6QiwWn3XLHUYaqR+yfbp/P5QH4MdkJyWc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CmK6QyaZFw4h+dedDachw5rZziAvU4s27T17KICZuwGV5vg5Y8J8T5XT0RPs/QvDiu9seG+GpymeysD598croDyOFGwaBwyvhNz9B68GWeVkKndgjhFW8GDwnlIuTgNyg0M0mey3KYEPOBlYvf3DxNxTV2KBmC6XXyLNlcHmQP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R2GdrUhE; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZCaxJ3YTDi68x5wfbqfSxFpQT689hk3f0CAwEvPdIVhnMEB4A6UViiG/EvWeTmouvBJBIVrGthHRsHq6I/U3qR2fPnJvaNH4cox/jbNXX/bHTZ+0oayBIbISDsdgnwaf8O0KIi2wxf6gliYZ8RC46BwMmnbcpqdlp1yfHfQXIzZT1Vt/hmGRhCX5tp9Cviv0w7G+vMhVF/vUiTmoLdwxmvHsHbVrjQO6QcLdfVKBsTED2eLnGI8Aoki9yr0lqp25Qanaaut5ZVmm0ZCUh2fgJ13Yb2NWOvg4WMpPrFHp+A/+CA36XBekrmQUiohp/maH29JBE4YQQR3b1yHGwkkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsL22yDaM7QD2nWXr728b8CsQMUKGCH/jvUWyGRwKTU=;
 b=WI5X4wXUvrv3HpY6NU8L28LSemSsp4jvCtQz2TuUHauBKqOKMfZCqu24ZdsyaFZ2wuiL8bBdjwZJ/UmBUuT7a+9WJTo/HEZ+TcC8niLT48U841BGKQqOwm2XeUUPlpishO1xDelcXCS4slU1gwRYi6m8822xzmtUrYlt/r4ltFHkWkoBKdSVigBWRhkZLmvL0f1CfHzD5TuilpPGSTJ3I9juJVVQPLylhZuXhHQcuvl+oFL76gXDLJQ+tl13gBVsHqioADUDADFvKS06ghYls5/xlsV8I+ypFOfO7jt4o2PaRzYW8x3oFyn567/iz+xIH+gdcbsgROJ7VPK7ISlbZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsL22yDaM7QD2nWXr728b8CsQMUKGCH/jvUWyGRwKTU=;
 b=R2GdrUhEbN83zfaMAEtcdaIxBzM99jVvJ7e5MvzUQ6M0bM26+MP9phfd3wMVrB+fgiLIVxKhizdt5VOJ90AEKxobEN/iRn4sYL6eAuFj6Ernf+hIkE3bYWC6asa9DVE17WeFcr/iJD3vVb4fcjWCllxYV63qZLg665hVwUXFkwF1FLjTwBAVe1n9jY8cgqeewcFiaWHUXv5wB/S8D4G9j1kOdrR41rJNXSUcnEgfSlSW9JdVgcz66V93bem4Duxs+L/XqGEh4+z2BjhlxZ9V6+vtzP5tHWn/+CcWju2kJd3BygkbDVi3kurMIuVhE/ieJbGk/AhVJaDB7dyuC7SkOw==
Received: from SJ0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:a03:33e::25)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Fri, 19 Apr
 2024 08:06:19 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::c5) by SJ0PR03CA0050.outlook.office365.com
 (2603:10b6:a03:33e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Fri, 19 Apr 2024 08:06:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 08:06:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 19 Apr
 2024 01:06:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 19 Apr
 2024 01:06:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Nabil S . Alramli"
	<dev@nalramli.com>, Joe Damato <jdamato@fastly.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 0/5] mlx5e per-queue coalescing
Date: Fri, 19 Apr 2024 11:04:40 +0300
Message-ID: <20240419080445.417574-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: eebcbcf7-316d-41a6-6bf8-08dc60479809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j9G0w/V+3V5HTcrW+se25ONudy4uiK5CnXEAB7+x27jZCE65p4/vEtC2R4reg54YkOpkQlsoa+w4lLCjivR4C4OjhDiByktM36z9a701uzcYZS5s4yL07ibPd9Sj6/EvldnvkUien50OeT7p9VgE6FCPROfXl/U8+GEonl5/FPyDYffGeKa3DTLbOymL/FwaXvSTJWX+P7nUYKWehIiIKdXKbhSpDEa16BwRpXKo1nPdgCU6Ooag3flNL4cLP+Cn4jDIY9dLkwZZS89Upx+nvKVBox3sd3cAktYvTsE4k4gggpSVlSvdesy54f/6LKiVQ+GEdeGPMgnHJr420zQBQbV3YFbMfjonNfwvhyWxBWCyxIN/jsWipcpO8HkpFonM1Ppm9DSBdbUaOe+5GzbOOHNtCp2DobOiJ0iQ+1GWH63nzCn6LVKhCbPIexd5q+63KunQ4Iq30zLyMQztLlmCbp1XSC3SIKiNotoLnr3Ez+h0lFNZaI+OLXieAHZfYXAKND3/INMO7WbTL1YiD3AIPwxqDCbjMvuwjrofTpA8BVZrMkOIeEd2IlCAQH+vds+85ZInCy0Yq8+EDKgLHHrdwZczw2aKSmGX32pv9NviRKWCb/bAixQEo6DGK13VDU8SEPtirn3fUHdGvVvm2NjfogIcMvjlnNKRJalzUMnaEMiekRtJhAVk8R9i3CjX5DZpzJIhwtMlumSrbOhcP3/2+VWOpQEUeWzAtLs5+5IJ1s8cYirZLPummEnsfYIOMmmQ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 08:06:18.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eebcbcf7-316d-41a6-6bf8-08dc60479809
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457

Hi,

This patchset adds ethtool per-queue coalescing support for the mlx5e
driver.

The series introduce some changes needed as preparations for the final
patch which adds the support and implements the callbacks.  Main
changes:
- DIM code movements into its own header file.
- Switch to dynamic allocation of the DIM struct in the RQs/SQs.
- Allow coalescing config change without channels reset when possible.

Series generated against:
commit fdf412374379 ("gve: Remove qpl_cfg struct since qpl_ids map with queues respectively")

Thanks,
Tariq.

Rahul Rameshbabu (5):
  net/mlx5e: Move DIM function declarations to en/dim.h
  net/mlx5e: Use DIM constants for CQ period mode parameter
  net/mlx5e: Dynamically allocate DIM structure for SQs/RQs
  net/mlx5e: Support updating coalescing configuration without resetting
    channels
  net/mlx5e: Implement ethtool callbacks for supporting per-queue
    coalescing

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  30 +-
 .../ethernet/mellanox/mlx5/core/en/channels.c |  83 +++++
 .../ethernet/mellanox/mlx5/core/en/channels.h |   4 +
 .../net/ethernet/mellanox/mlx5/core/en/dim.h  |  45 +++
 .../ethernet/mellanox/mlx5/core/en/params.c   |  72 +----
 .../ethernet/mellanox/mlx5/core/en/params.h   |   5 -
 .../net/ethernet/mellanox/mlx5/core/en_dim.c  |  95 +++++-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 300 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 206 ++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |   4 +-
 include/linux/mlx5/cq.h                       |   7 +-
 include/linux/mlx5/mlx5_ifc.h                 |   7 +-
 13 files changed, 672 insertions(+), 196 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/dim.h

-- 
2.31.1


