Return-Path: <netdev+bounces-110863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF4C92EA53
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 16:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C337A2811CB
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C16160887;
	Thu, 11 Jul 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y/RT/R/z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002D14BFA2;
	Thu, 11 Jul 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707010; cv=fail; b=RrQ7PoTd799JpuQ31mPeToxRZwi0oq5b2xlL0NNRMvk65YAU/JMeHPwX1SxTbPeNbC1NCqyF3u8Zd9Mclwy5bSwMZ2vIVhdxxydgb31E6jLHPOLYLrmhbL9DtiJ0NCUekLsGakANZXj10T6HwYQiO086aiyE/V1vz3e8fstCvdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707010; c=relaxed/simple;
	bh=KTL6OGfaYQ51eL/IFumkAi27BbuIi3O4SvpgUuRScdQ=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NiNgEOOaEmj/2dybHYbE2H449SKFF5I9TJYXe3pTzlc2hRK52WvfT+sL4IZsXsbikQvOtr3WBTS7WYUTLsQi7QMRNNvuKChCx3ZTzbAEJG5Pmh1ZJXK4Jdx2p/A6+adHjJDllOFmYeLgZ2PO+FufdsfkJVs3eG+NTTiYQiWaJE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y/RT/R/z; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6w6suIeovVOxgN2083vnuT1y/sEYDyOejGKm/Wk6kudDudi+fyoIQaV8rajnvNNIj1IyO7gYvaoozo+SgS9BOsMyRXt4QoHH2s9RupDRgaWC95IRLo1/lQ1+rdGa1GnxcD5GNCrLgeyBGZxM5TsqAlFHuoHc/yKao/3hKNQLWSP7ngl7I5F8qaoAi++aamkwRacs2ub4t1Wy9JZS9OBQhFL+vdK7OTNEJGjdgct4jlBfdeIFkOaHSxdYjMGBwHCRJ4i2wbYF0kBaTHPVG3JJTR5kxijj1n7XRl9sw+VA9HgsuwyMWmRlnuGhm7rz/rgCwNat6xMKMLkKLiVrlylYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTL6OGfaYQ51eL/IFumkAi27BbuIi3O4SvpgUuRScdQ=;
 b=iECDMgaJaMpI1fTKz6tIgWGefFjbIEtBhXWoRp6dy15qLr22D6jFXNtr4IKZRjOeWVUwySjqt8PU3vaZBjHO6Pl+Jkr4FcMUnaSJkg7W7QnhawmUovsdf9Q/p97IkXefzaep0spgrNj5Ose43DbLzQXz/yg2oukkmL8FFPG0oXULDGaieG22D4OAj3xEgaVvu3x1vu9amprZvYD/HS37v5xphNYbrfDNdjGO357yD7EkfuNkL7aQk6tJfZSFD6QZ5XQK68WT0cIubCuf5hYAs0dt8/g5tkmWqcWHwjILUY/TleLA+UUo2dB33elRmBvA4MYRqmW9pCe/mc0VBJj6Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTL6OGfaYQ51eL/IFumkAi27BbuIi3O4SvpgUuRScdQ=;
 b=Y/RT/R/zekdjiHM8DmfQdGalA9l4Kx+La179uor4Q0UMgJvbdZHq9OyPqLH2rzlU34zasD1zk893rKZM0nUJZGjbno2z8hQyEXEzupX4b6Z/9EnBUAhylaMkerfZVzX1fLyFb4fsj1P3YzBI7FxRsQCQcCgj1BcPvjGFWYuoJA630TFp/GqGNu0h3iOaWBpYOLBe0D3QjpAC8QnWb7W7hDQzLL6xYlLK+kZG8sknxzK4qEVNFghlHWEu15myEARq0xv8dVzMRrG7st01rQEPU7+njDigwfZhWsP7LrqFw6o1TXURZqwk1B1CUEy0S2nr+A/c6v5WA4GbGuUBLPF5zw==
Received: from BY5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:1d0::31)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 14:10:00 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::1a) by BY5PR04CA0021.outlook.office365.com
 (2603:10b6:a03:1d0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22 via Frontend
 Transport; Thu, 11 Jul 2024 14:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 14:09:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Jul
 2024 07:09:43 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 11 Jul
 2024 07:09:38 -0700
References: <20240711080934.2071869-1-danieller@nvidia.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Danielle Ratson <danieller@nvidia.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <idosch@nvidia.com>,
	<petrm@nvidia.com>, <ecree.xilinx@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: ethtool: Monotonically increase the
 message sequence number
Date: Thu, 11 Jul 2024 16:09:28 +0200
In-Reply-To: <20240711080934.2071869-1-danieller@nvidia.com>
Message-ID: <878qy8rpeq.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c1fa3d-291d-4493-8a2e-08dca1b32667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vwoLQO/NQfoehISlZgGLqVzGFAatR8QBQQra5zPseZo7AmOLScw0jkuQO+TI?=
 =?us-ascii?Q?17b60PjYsg0Ovbo4d6twrEOABQv2ppAe3ELpf+jIo5hOTfXHGaViSFQktMsY?=
 =?us-ascii?Q?gfcDI4MdIIQJuyvp381FsU4rbR99BhsUQIFsUPVaiJYhei9PyLdf/vW6pKfm?=
 =?us-ascii?Q?R0F0AmtaXk9fSelMzxCIIbGnuCwABu628hmd0+RlYPOdt/Jgn74CStGEvMDt?=
 =?us-ascii?Q?oHxP5lvCp0p9hUZu11qyDDlE/VImiTU1Vn2LVHCVx92xEzmz0nbalikrCpSs?=
 =?us-ascii?Q?oZyysrZM6z7Gj0FvhPA/HpqK893nZJvpJB1JuUVbO5qSF5Dmz4e5Jvd4Yx2S?=
 =?us-ascii?Q?8v+TVYNQLwLnM8E09k8/ikF4XbcwP6T1/Vee9ObfMbgbaYL3cJ60yPyGQzVB?=
 =?us-ascii?Q?BCRHPIaR/8OV6c42abuqCDedqzFtNNfgVZ5jiOJPHV59IfwMPR/7INS3TwWg?=
 =?us-ascii?Q?6meS3pu3EXP6+QbRy6X22ju44en/MBvNQ7GCy5TgbM4FpfJ6PTyBouYp3kkb?=
 =?us-ascii?Q?zyQfE1cxsO9/1IUDS7Fs7K5VlKCspJAjfsVmqrOOlrH3iFXkehdgvu7N+xhY?=
 =?us-ascii?Q?bFgo20BxFTplPeG4fnwj1ZqitGUNszYwbkULiwtp3w/pzeJdGPyhB/WVbDx4?=
 =?us-ascii?Q?rI+KelZQOAluOLHNfahZ9yVJlA0ys0hbjuv2dM9p9D9qHJKvyYYHCyUk9VRw?=
 =?us-ascii?Q?5t13vzIefK0FQqlGKHqTttUcdvSJF3xA6f1clN/rZXVCIjyRbJuT0V8G+9Nx?=
 =?us-ascii?Q?m5oJfpdnoc7jnRrLh1OqthcK8sM4qqcvdHL8nowweW3BpRreOFHKBCiSgutk?=
 =?us-ascii?Q?vv20yYjMki7HSOepXmR8eG2K2lcgrzahLOp6d1sP8eKjQ9Xx6Qxx4VNWP5mF?=
 =?us-ascii?Q?Gb9UdK/PZ0tP4tKTYTjIsCQzrK12gPJyE2ewaXMN8jcGmAxULwP0fWhW60QS?=
 =?us-ascii?Q?6M5VA2aXHAkNKdwr2almHz11friGqSNrXFYpYMUyB1DAuC6O5lJZ5WDhuoVh?=
 =?us-ascii?Q?UA53EJ3xh+5TpD7E1KaXcy4ctdjgKxE5vBdqHMZ3csHrZAXEjbECjTNG1KQA?=
 =?us-ascii?Q?G4eHzBVUFFTbo0ejy0HFmwMPtNF/dPvqntLLRLJITHPzVi7qx/rXZ0nE4cqq?=
 =?us-ascii?Q?yz2rvxLueQwjBwWT07cpy8Myn5uM43X0YhfgaqjhQw4CbY0WlrN/ckepmnzI?=
 =?us-ascii?Q?loZE6ycu3BJXcPLW6K/K1uMoe2IWNM8Tufz/Lq4i9ZTfcvJjfDkZ1mRu0B7q?=
 =?us-ascii?Q?8iNGHXeDGd+4qawL7+LigqIoNFJp50hmBFTCYY/pYSJZzidXv5cwNxk7LmuZ?=
 =?us-ascii?Q?acVAWVdHLuXiCebVOUuShI4lqPKlfZiZ9D8Qt7kUuwCaalYWMuWBCrqScQ80?=
 =?us-ascii?Q?1yDUSQ7v2M9V1piDsv+1B90RDPjCeccAoU+hRCvpo3g6TgHpFu/oqaKTTzM6?=
 =?us-ascii?Q?++yewX1Pl+uBL32vbvNovsKVee9XsRO5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 14:09:59.3899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c1fa3d-291d-4493-8a2e-08dca1b32667
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707


Danielle Ratson <danieller@nvidia.com> writes:

> Currently, during the module firmware flashing process, unicast
> notifications are sent from the kernel using the same sequence number,
> making it impossible for user space to track missed notifications.
>
> Monotonically increase the message sequence number, so the order of
> notifications could be tracked effectively.
>
> Signed-off-by: Danielle Ratson <danieller@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Applied, thanks.

