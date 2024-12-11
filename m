Return-Path: <netdev+bounces-151185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9129ED3E1
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 18:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FAB18823D0
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 17:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29971D6DA4;
	Wed, 11 Dec 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H6Gb+RKl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316424632C;
	Wed, 11 Dec 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939057; cv=fail; b=fhpi/bznf9lymLLOKuaXfhvysWEVJOXTGDUOC4PB/R6Q8usiidJ7qtR6nNLaHx3DmU0l71MHcL9lbZArmHaOtI08kVt2mhviRywTPXbMDKbSYvcQRl3yTRqvb9b5G6sIiObDqQIcPJMPWXAZYNNXugm06U3JeBRYmJoFIX+nIq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939057; c=relaxed/simple;
	bh=md0pVAk5GrsAXtX/xNDRRpl2KXHqMt9De8xJsB8VmfM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+Wz399SJRt9C2UFrEU4CUiMQJ6mU++usNmTIOoKbh1NZxBthCGwmqx0I507UQ6rMXkrz/osoY/iXe62vSSSlRxmqZLKiEC7e8kTFIk7gwav1RluORs/V9ecyL9NowGh4gPFemICBn/uzFxEte3gql3UQc0uLPufqPetLr6ngWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H6Gb+RKl; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpRtsGQZa3zwVatzr2A9lNXWfQ+Y+WT334DaVEG8sP6PTAzFOw1fh0rmWQKboC4zemkWBtzUjVCmoIQW/yxfhg1SuapkU2hWsuYXZC+0FBhLtnZR50fwB2xFXPl4FoELckC08ykILW6WKXAnisI0YMf3VA8YVP9vJWGWp4PUeRBnc5Us6PFEhZVO8X2TJWYnMjotmTQZinzTLhFYNk5MSmdfN6vSfLTHxbYeTPnJmj1+UYhYSbh4mfTrcnm+p+ji2aUrCxddQcfs9kafO/jWPimc0bFTNI96DV94n3NjbI5xF/vQ2XkoSweO6yfy0FA9QVY0iE86qtlAUkyK99Lnaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vtv9e/uY9K7ZlnR1iYnPML4tWgyQ44RtySK15gz+erg=;
 b=DrjTH66bpHRZ3mrrZIz5OjBU0TEGosFw1XuccCRVgPvuLs42VKorM7X2VWe4hm+Bo64TjBP5xPriBwdzeGjZ+ajqxEwNMDZWnonjRLKGs+35IXMRizR0/40YhceAPItESFM0ZfpHKVepjf+oLRaqLwyUohjKTkfd+s/gCIgHGCQW6cxHysEdrf9cVWCJPGw+DZKE8rt9yr/l4Q/TscL98TyC4+y8vABcyKoV5SgTb0icuvIq0qZzWNrQr3+rQDhIUg9UYqrXwIBxf/uMYyH5wCGjfholLTjJBVdszVtjxmpJnrumfZZ6FP3ljWDxF3KVUZPOoafhNWkCYDKb4Q4Liw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vtv9e/uY9K7ZlnR1iYnPML4tWgyQ44RtySK15gz+erg=;
 b=H6Gb+RKlSDPCTzcSF+Q48qrSe75/BxoysIykn/SPeZyvXZBH02zWniBNrSrwzL0tjS6pQRaPJAzjTPgX0njKCwF2k1Fc/mHYsvmoNlvNzP3WuM2hyNSMxqe7nuVwY+EqJKpoy7GqZK8oZrQVzGHB6RL0VbCx2itfDKgnGiXnu7cNxPB8KVUv97d/R9ZfrjGtSmxxwllSc7wuN1duAPX4WJ+x4s//vGKuYcu5I8bSdMfnBK1hF1RKJUQB1Rlou54KBdi0do/qPpAk3MfbbTn3uzGGY5fSlw0rRJaAEyMHFxnZ6ph1953WYAYuCNhsxT8VXQzcXvJThw+/Pj+TuVXS/A==
Received: from BY3PR10CA0010.namprd10.prod.outlook.com (2603:10b6:a03:255::15)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Wed, 11 Dec
 2024 17:44:12 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:255:cafe::8b) by BY3PR10CA0010.outlook.office365.com
 (2603:10b6:a03:255::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 17:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Wed, 11 Dec 2024 17:44:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 09:44:00 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 09:44:00 -0800
Received: from localhost (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec 2024
 09:43:57 -0800
Date: Wed, 11 Dec 2024 19:43:56 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>,
	"Alejandro Lucero" <alucerop@amd.com>
Subject: Re: [PATCH v7 26/28] cxl: add function for obtaining region range
Message-ID: <20241211194356.00002976@nvidia.com>
In-Reply-To: <20241209185429.54054-27-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
	<20241209185429.54054-27-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|CH3PR12MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: a5963e0f-65aa-4d4c-b9a4-08dd1a0b6c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ET1Tkooog7eTg7suMTyD9enKjMdrZ8iULpwafajqp2Yf9auPN5JYFGLdL3Tv?=
 =?us-ascii?Q?GWIbXuq31euFeYMTPIaq2pVqN07joP7M5o0jWaEqNAFfrQAdzoZQfam2IbsP?=
 =?us-ascii?Q?L7mbXc/qOfZNXhHzhmgqbKmYbWlDvEpDiZFLLN6QjQJpRWTa9ukAsx0Bnc9C?=
 =?us-ascii?Q?w+/DzXRkU8VuwG+PLQ7Gkj8PhwUn2iUtxq3HEzsOpGaIpgO1A0dk8uCByPtp?=
 =?us-ascii?Q?nyM2uKTg5UxkOx+mYs8cF8EIoQ9pt79/4C2m0n/k+E2krxSUN7n/93CZbra/?=
 =?us-ascii?Q?MzTECTvecBGQPH6YICGWuKBi0Fe/T8ZUNtYqwygzA/yaQJR6IXwISPo2eQ3i?=
 =?us-ascii?Q?og6Ls/SdzHkZw8DBzNb53FEiYD/bCztmZsVs76SF1qHJ3PYT6zwEY+3fl3J/?=
 =?us-ascii?Q?7Jfw+65bkKXBFR7LsMpTyz+e3jYb2vDnkujsBfIqFYQN2UK4i2SSjB7WQfCT?=
 =?us-ascii?Q?s0XgAR0Mr0o6Qqq23wCxcTn1lgEmixfgrLpdwHLV+ThvpRB3V2pIwdCet5B+?=
 =?us-ascii?Q?F+tB4FxJkdUo6pjcVx2Z9rdM1UyWLZzMCsQjKerCctB14R6oqDA0xZc83YGZ?=
 =?us-ascii?Q?tpwyogPYcPtgiHEWBEhQo/gcOwN9WzeIUC87zPCkLC8T042At3X6X6cX4e6u?=
 =?us-ascii?Q?pQ7yLG1calPtMuM9x8SU9hbaDK9f/2kScOpbtmFgd7yTkIwHKYg+mm4T5iOu?=
 =?us-ascii?Q?jclQpXkmw/VKU1P2Rjs8hQryVKHwYL0K0/sNggHDt/YGRK9O4jWQ7v6+BLwf?=
 =?us-ascii?Q?7ewzQi+rIDNphxK/Lzgo0+R60faW7P1/kCDAseS86nJzdzaePH05VGIFvrxm?=
 =?us-ascii?Q?Nst4MhOePmwjdq1Ko0M48HZIFqk0k/utdNacZdXsT4M/CD02YM88RGkEdwP3?=
 =?us-ascii?Q?u80bnzzs3jeJ7V6CSsOj41VUuPYa2yruexULELZbneZkQxIxhMJu1Wiqr7Sz?=
 =?us-ascii?Q?lVFwuSczHn72VC2VONAl7Fnk5ZLeCYQMbGBcYn0e5q2D6fpEpOoKTVNgAKSB?=
 =?us-ascii?Q?AGvi84hWKH7lQCki2xfeaUkwwEOFMXCC2F37CXZL3TyciXaxT/XgeD5hWRZB?=
 =?us-ascii?Q?QtzclzKLSpSX/zioPPYhgErlZkk0mCWuZQufT05FV2cVyHfx7z/LxL7DCxeQ?=
 =?us-ascii?Q?KWKCSjdBag32gus2AcIljuBhdbxWg0wGXYXWBw73CS9pPy8bxG6kh5eL9jcv?=
 =?us-ascii?Q?jlVQBynke72iRJOwTal6xWQMss127qk5+89QTd+Gu7h6YTy0TIBr5DeQkf27?=
 =?us-ascii?Q?FWDWSK2D7b20XQtvKMlGOyjuHeYNP+w1DUD3Wg6lKF/F9q/hAnmKWNN3BHKs?=
 =?us-ascii?Q?LBOfkMXAvyhzX6QhDpnJyNaoZHHtpBIIHvJdz+YNmRhYMbCeJPepnG/cpGmy?=
 =?us-ascii?Q?2mxPKAqbGz70KfBmFLNDXMeYx0TTL+FgSpxk2YpeWFtf+KFgTzDylBfNzefb?=
 =?us-ascii?Q?3zb1jkcuWhRyWafh4jRmpWX7Y+9FaVvq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:44:12.1250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5963e0f-65aa-4d4c-b9a4-08dd1a0b6c60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910

On Mon, 9 Dec 2024 18:54:27 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 

Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> A CXL region struct contains the physical address to work with.
> 
> Add a function for getting the cxl region range to be used for mapping
> such memory range.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 15 +++++++++++++++
>  drivers/cxl/cxl.h         |  1 +
>  include/cxl/cxl.h         |  1 +
>  3 files changed, 17 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index b39086356d74..910037546a06 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2676,6 +2676,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
> +{
> +	if (WARN_ON_ONCE(!region))
> +		return -ENODEV;
> +
> +	if (!region->params.res)
> +		return -ENOSPC;
> +
> +	range->start = region->params.res->start;
> +	range->end = region->params.res->end;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
> +
>  static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>  {
>  	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cc9e3d859fa6..32d2bd0520d4 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -920,6 +920,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 14be26358f9c..0ed9e32f25dd 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -65,4 +65,5 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     bool no_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>  #endif


