Return-Path: <netdev+bounces-135486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F9399E11F
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198661C20FF4
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE111C3026;
	Tue, 15 Oct 2024 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sk1MJRWP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46118A6A5
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981130; cv=fail; b=dqE3+KdHIUKapO4was7uRkIu0C5s8/fddPHRv/AWF2YgG8XIWTFx10+C0r0RHXO5iqVjbWNjthByExc4zYmca4QvDBS3velLWMchiLYMt6NmgYePYFhnbecbtlkFvSjGfqQhwuS6yUnB7F2Kgq+Y+Si963wKZf0a64ecDzIlZlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981130; c=relaxed/simple;
	bh=JXJJCvoQtW9Jqo7uOD/4JPyl+X7/jrm671v56TiGHNk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KUOXVX/yEGvkifUFSChTjOuVAPidYCUdcFrZjdzLfnQblPzgK5y2c/HzpbQxavNefbqmkTjo7MamR2/6orbjv+SofIxP6Qv2Sx8HWAX5vRXf/Kby+383TJruR4f79AyI79CTT1KZcS2k4OsG2S8QA3FA7wQHQoz1vbay/eJbCZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sk1MJRWP; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jX6BJVg4tgS9PCQ3f5jFxsrLS4rZNwP49MdJWW9xgc81vUlDHTxprh5MdFcHvIIejICTliUvx0GeZWg6aG9dZzePZhek3WoQwzYE15SHK55qVPmnG3vkIbfdZ3kt7xcPwvyb+KCQ9HTsVxPLucwrE/AFEQo6vHsnSj7FaN4Jhk1l3Dv2JP78S3AS6/jHd68fiFBElBlOHAqWFROD1lzX5WH42DKluBnk21WDyOzr+dwL8JwmuIOQlbmY6Si9A1kkRSukgmAPDk0e2+UaT59G6MeYwtAci99ie2LhudhqhERv+pukLFElH0fP5AOcp/InhdWKPYBwesBYSaOi50S9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SFyaaj3MnxAcCvJwZ5vPVvENkDZjPwRZoK+hPuhnWY=;
 b=XavtESyBVTG8QL2BbBN/Sp2PRq6wrcBJI5pfmWXo4xLJyEQYs0dp7FJlTkophd9Vzf5IzF6aSpitAeTwfJCj0VyFIxOZtrmgTTR2TlSMdghyrDzH2AFfVl6ozc7wYboaMB1oVjgZSs249Bg3Y2Kn7Oys7slrqNdhZmdbjP8C4ULgqi6yqyQ/WnZa48E2EhcssDkFAsI6hQALTkiDX31xrLcB445NL7Pum7MGGSKGgmWL+g8xR6W8DKH7xTR3XHsdtcoRZe0w+tfbcXY1/BJnLsUaqX24zwr5cGmhAk41V7vL6nErTU9mKQWsmTtEBm7ngY5FZ5hqoYKHYHHY7t000A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SFyaaj3MnxAcCvJwZ5vPVvENkDZjPwRZoK+hPuhnWY=;
 b=sk1MJRWPt3lWMKouRPlpjL9O0t0YrpC9w/HpN0Vn5WR5jKCQlexPfZg/yb+8huKEHVyyhXjixNZSwhES0QUv5Lc0FnWaLVLejD879q9473BeZQpfS9aiTbFjbqKVmD22a4Nub11Z7H2+2zZgyCR7MXoH1TlfQYKn8Ylalov4JllFOVF1cdQDNp/jDWdflgmi6ra3ao8Qqhv5i0UqdWEhyFdjuILa4Cy87/b2Kls664RvtAJRolSPY10g1zyfK4d6mzvsRhheB+IvUPkYzcAKv+6a+Nf/5bd3NL55yFpzCvjL3ox9LBQRFdq8qKUdS/OkVEEUS9PIK077NnKrHJCv5Q==
Received: from PH7PR10CA0001.namprd10.prod.outlook.com (2603:10b6:510:23d::23)
 by PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 08:32:05 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:23d:cafe::13) by PH7PR10CA0001.outlook.office365.com
 (2603:10b6:510:23d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 08:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:32:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 01:31:49 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Oct
 2024 01:31:45 -0700
References: <20241015063651.8610-1-yuancan@huawei.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Yuan Can <yuancan@huawei.com>
CC: <idosch@nvidia.com>, <petrm@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] mlxsw: spectrum_router: fix xa_store() error
 checking
Date: Tue, 15 Oct 2024 10:06:19 +0200
In-Reply-To: <20241015063651.8610-1-yuancan@huawei.com>
Message-ID: <8734kxix77.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 0908cab8-a7b9-420e-22a9-08dcecf3d9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1WCWK4WuAAe77pzXZIZTo5VBOSBA/1p+StZAEyG3YPtoODvp7Fbt9Vz20LCX?=
 =?us-ascii?Q?u/Qq47ElwFyEhxkmn7Gs2Aqb+XODC9X3oxDKtvfRF6O69a4GpGikgZIzjTBn?=
 =?us-ascii?Q?E9I0iZH+y6I0NoTu2fSatiL5cstRg/BEzG2TGJvv5SqCdfRPqL3V5RTDztY7?=
 =?us-ascii?Q?i3W97YeUbV2i7H6pqBhsmb/6ieEb6WfigfcDeehvdLPQ1NB8DJYtGifbEqhv?=
 =?us-ascii?Q?ONLnRi3xiGXEoHzIEP/HkYuHVUsoJjCOL/HH/K5ig8LdXADsImROGvLuiFFo?=
 =?us-ascii?Q?4QQoQiHo7yhsElSEu1fh9sUNaFmzA64NLzG7kHTjrYKeP4ZIBtMGv59hsjVV?=
 =?us-ascii?Q?yS+041zANFtaHh+patoJmGsvgjRs3UmvJKjhpDJ16KTpUZXQ4fU27UWRXOpm?=
 =?us-ascii?Q?Nm5aXiVBaU0C6EQFBNcR7VrzipBnRzX+fGF3AfSRybYkvQMDChkpCuehUS0w?=
 =?us-ascii?Q?xYcFw87FLQS1ybzjlzCKjPMojpoP2AK/lNFmFPMA+5o9qzc4R9m/K3iAu98v?=
 =?us-ascii?Q?w5q7AWlsmtJqEStdn3As9b17wtjptuw6qXh9KH5mff/HhYkrksrxOBTrcZFV?=
 =?us-ascii?Q?uegAfIr4akqI9rDy5176euvhlfIyyWuczruGs0VgeaR/KMbo5kH+1OQPoF4h?=
 =?us-ascii?Q?XHsHhcXSALsI22/7q47csgvoHW8x6I8GXaPhOQBVaIUYb9miuA9qLzDhcw0m?=
 =?us-ascii?Q?RP8e9lgJVP3emyiqmiYk1KaOvG3r0trPNVSFogHI7tdXF7npGUWDjbje0yJI?=
 =?us-ascii?Q?Q3ca55+euVlidV9BHbDXct8ORK6/+QkkszlD8aB7/w22zilp2NMHZJigQOR0?=
 =?us-ascii?Q?+H+q0XRozjUnlYxwe24cZrY1CKnrAlBGF3ZGz3X7Dt12feN40BZUsKaATG0C?=
 =?us-ascii?Q?v6YLk+SbzNqy00nBKc8iHkGAVzRYb+cGGTJjzxOfbT0SbJY4lPVK8rtLv5xE?=
 =?us-ascii?Q?R5XSpuhq1DhsrzAopFAyhtDTC0kyLFvh8pkrGK2rOPuLA1RDt589cUf960ST?=
 =?us-ascii?Q?vg3K+z50+VYhyWG39UapdyLsWRJ2qyUvUisR28OSV9mBp+C+V/zW5Zp4k6CF?=
 =?us-ascii?Q?yOqOf4TJ39kDmKXzt6RUAgtBn0yjMZTuTYzbXwDvh3Z0hGtVdcgaEvlWDBrz?=
 =?us-ascii?Q?yNwsU8sUSwcfgqpa6ePxnX6hmU6AjgHvok/6QBWS+N3VLArYhHZw4bSnaVDx?=
 =?us-ascii?Q?G1Jcs+itXIm6VxqREf0ylqu3vN2DdqODg+FgPnmGguMIsrexI+L+Wte6AiBH?=
 =?us-ascii?Q?nBLFm+81t3qW3dY0F7yfC1ZvwRw1b9aGZw1QjRQX7qcCGl3lHP8n8sGSufgr?=
 =?us-ascii?Q?6XRHklbH/TEhdnp1rRRhtzonj/e3JXlea2wzBCd/Jjv7FT5Sfzt5/zzNb7s0?=
 =?us-ascii?Q?cC3sjI8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:32:05.3669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0908cab8-a7b9-420e-22a9-08dcecf3d9cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853


Yuan Can <yuancan@huawei.com> writes:

> It is meant to use xa_err() to extract the error encoded in the return
> value of xa_store().
>
> Fixes: 44c2fbebe18a ("mlxsw: spectrum_router: Share nexthop counters in resilient groups")
> Signed-off-by: Yuan Can <yuancan@huawei.com>

Reviewed-by: Petr Machata <petrm@nvidia.com>

What's the consequence of using IS_ERR()/PTR_ERR() vs. xa_err()? From
the documentation it looks like IS_ERR() might interpret some valid
pointers as errors[0]. Which would then show as leaks, because we bail
out early and never clean up?

I.e. should this aim at net rather than net-next? It looks like it's not
just semantics, but has actual observable impact.

[0] "The XArray does not support storing IS_ERR() pointers as some
    conflict with value entries or internal entries."

> ---
>  drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> index 800dfb64ec83..7d6d859cef3f 100644
> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> @@ -3197,7 +3197,6 @@ mlxsw_sp_nexthop_sh_counter_get(struct mlxsw_sp *mlxsw_sp,
>  {
>  	struct mlxsw_sp_nexthop_group *nh_grp = nh->nhgi->nh_grp;
>  	struct mlxsw_sp_nexthop_counter *nhct;
> -	void *ptr;
>  	int err;
>  
>  	nhct = xa_load(&nh_grp->nhgi->nexthop_counters, nh->id);
> @@ -3210,12 +3209,10 @@ mlxsw_sp_nexthop_sh_counter_get(struct mlxsw_sp *mlxsw_sp,
>  	if (IS_ERR(nhct))
>  		return nhct;
>  
> -	ptr = xa_store(&nh_grp->nhgi->nexthop_counters, nh->id, nhct,
> -		       GFP_KERNEL);
> -	if (IS_ERR(ptr)) {
> -		err = PTR_ERR(ptr);
> +	err = xa_err(xa_store(&nh_grp->nhgi->nexthop_counters, nh->id, nhct,
> +			      GFP_KERNEL));
> +	if (err)
>  		goto err_store;
> -	}

