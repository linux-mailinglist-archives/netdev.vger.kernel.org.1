Return-Path: <netdev+bounces-117237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD5F94D369
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71B0B234DC
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F1194C62;
	Fri,  9 Aug 2024 15:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BGx/urpG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E582198A1B;
	Fri,  9 Aug 2024 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217086; cv=fail; b=d1gfYFYfxG/RuhaAGu1uHeW/GDUPvc2KOZJOc/82gbqb0m8idQEW4VxVFIio/KunV/mqostiLzqAdSZQud1PxCAvj5E3cGuLxAY+IuojaJ3tKRqcOIHQCIaEdN8P5x3y7fO+LTkMNWYmhQUloaY3aNT3MQnhbb+FQLprJzbTAJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217086; c=relaxed/simple;
	bh=EUdVDqX+8xysLABg5kmZSY5OeYKmfs2k7vDXrM5cxKc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T/P9pXnh6gO8aK+o8eiXtvcSehbfaD1BcNYGVgSSccb9T2MYm42fpsNOYHm7Q0gl0ZHwTOdn0CUFjYoTwc1Oaxo2NAMM8ICebdGL2ETcHJjw7cDLFdiaPZElLZxUhsBJP4R38jE/SUDYbmXYjlzceEe4ZTdKn7tYRnCoRV1rqo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BGx/urpG; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p82MDGpMFfh+TzMlIadr4L3KNY8Bnu3gM2nytJ6D05AMuNy/e2PS5sHjxF6YsTlrR5UffVwZ+OiTmJGCm0V32jjHD5lov7Y66/wPN3jCIAQTUqcjVyX89lxxmURBcKcG9B4FHjarZZHT5/3rJrauSbfUYBPB6nBLwosRyaYaKGPzWvknAtTSBEdESvI3H7rVuhb9Qss4qPBzbOP/Z1TGErB4k1EpRYzB3la1bL2d8SSxz4i/bTHs94pSY18DRnbuz7DDPleriFt9ruo+C2pHYMmFeaDdw+exsXYZK+1QPc5LCPFKuwnl8zd5/UieVGunwExO/6IRG/nUYehtIHkWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc5Gq47jhQoculGJ0UN4WLv0fAYd9/C+F6rQY3voTiA=;
 b=vvR2ltFCwaySjGJzfAO6UGdqhb5eI5oIzrvmYuW7LNQDRvOxmp8D22tX3edqqCKBi5u605EJgnSljS0f7QAZYycQrOCcnmSOraiu1rgy44cZ7WMh+/1WI6Jjhp6c5CO+z7vJr6Z3TBeXjJKQXHbfvJ8c97zCWKLLDHQCf9aSJr30yDdjdnsVw7D/7z3/pq1x41h2N8+O6g5Ti1gnafoDCXI5jKB6ytqBkRLPCf3dc2qpdTpCeY9cY2aFY6Ak5mU96V8tg0ZnED0lE6bTZ6ICYyG04T67rkSC00YC2CDy892HdNNzKodqEzaV3+qyUpeqe2/s2LNQ85z+677kw6+oKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc5Gq47jhQoculGJ0UN4WLv0fAYd9/C+F6rQY3voTiA=;
 b=BGx/urpGdylAzEMuFsWAyfsA7uu7egbacaO4yPL3wV09JwM8wBrXwZiw9K2B6c1f4lEYWRwibO5jCcvvBZCgRySYNdEf7efOSOsQXKqT/imEwqk+PA6tQOVx5CxQbQK601g24+B+OeNuTVkSuduTGhDOZgqj6bYQbImYN+1t3cR0d3B4saLJSPF2iqLLscdtWuzMPArLwaaDcXhImwMOBvwTk7Mc9UxWwBgBj8R/ib7EWGKHt3ykaX9QhLnf+rtE62jBUXLsvHuR9fCShF+MVcruRc2aEOKde+c2BnMlmAFq/YBUtK1Z9SKR6thbU7Mnp5oilweUNbX3Oius7DL4BQ==
Received: from BN9PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:fb::29)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Fri, 9 Aug
 2024 15:24:41 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:fb:cafe::c4) by BN9PR03CA0054.outlook.office365.com
 (2603:10b6:408:fb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32 via Frontend
 Transport; Fri, 9 Aug 2024 15:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.2 via Frontend Transport; Fri, 9 Aug 2024 15:24:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 08:24:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 08:24:23 -0700
Received: from localhost (10.127.8.11) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 9 Aug 2024
 08:24:20 -0700
Date: Fri, 9 Aug 2024 18:24:20 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>, <targupta@nvidia.com>
Subject: Re: [PATCH v2 14/15] cxl: add function for obtaining params from a
 region
Message-ID: <20240809182420.00002f9e.zhiw@nvidia.com>
In-Reply-To: <20240715172835.24757-15-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-15-alejandro.lucero-palau@amd.com>
Organization: NVIDIA
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: d924aafc-749d-4cea-38dc-08dcb88763f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?66D6qcwAInLrHZ6st4pvrIsmT1Dc3k4TkC0M+vMoe2KHSf1fZxf0FbF75K8V?=
 =?us-ascii?Q?vrqjVil++28pWRnOO6b/zhLc3DWfnjcqxGs0cYlnhJBnvOVm1jiGbFDPUom4?=
 =?us-ascii?Q?p7TMKfOien1mtDq0VWPEtgSVheqWMB15AvQx8Lg4udYlCZmsG+x62D5nWryX?=
 =?us-ascii?Q?SqkCje3hlDmoBefPf4NHRfTEWELgV5E5tMLljn1gsA9xz/La2+UdAtRRzU11?=
 =?us-ascii?Q?NfOqylaD/eBkL7E+ZkxoQtXtLXmsHI3HcxwWxdb8rZZxlvXHvoR7S/c1AR1P?=
 =?us-ascii?Q?7RVa9NJgEUXZ9DKmvEE9d8FN4tWScYLiM2+CGSxQyUG0n8hndFnVjqelBGl2?=
 =?us-ascii?Q?Sb5+CljBgxPu+Kd1g1nnM+5RzJggQ7Z/sOR20bSZR9BnKiioXQZ2ADlrpAu8?=
 =?us-ascii?Q?brqb1uwPSvcmdWg0QVFqSow1xJnK/wJRiH3+0PiMjjzRsJKSJ7DJohkE9r2V?=
 =?us-ascii?Q?C0eSB8Rfk88c07TB9UtVbGtgVNDfEiCNvjdGaHhpnwEtGypN07SJn75elBbt?=
 =?us-ascii?Q?JLFONZI6nilrAXsllrpPS/ceYQsCjSgmBQzGcilsbpLahpkf8z3IKWcNRRIu?=
 =?us-ascii?Q?ZoswcWiDLCFnXnXEKZD8j6mv5qPDIh087gE3mGwrLnOzKeiqTj+W2RZUuA5x?=
 =?us-ascii?Q?TB9t02SyrE4fRKdclc9+B0fBBYlu7BBnNLLnJ+YbDLiE3ZOAsqUKpr7r4U+W?=
 =?us-ascii?Q?wyWpLIUPxpmLOhKTiR9SpPSayid0IHg1Rc2v4EJ9YcCelo5V6koSmKqlZWLS?=
 =?us-ascii?Q?Ymu9jkVJ3CMsJCV/UpF/lsNlSUHhr/3XHWmm5QLQVYY3gABmRZfqse2gwuJr?=
 =?us-ascii?Q?1MblcCJk87r/ik4Fslkmb/Tn/2w13j5kbt3j1YaJGxji6Jnaszn7U+4bVldl?=
 =?us-ascii?Q?Lm+yBZ4+WyU0yWpEi4OsUeGhI//2wT6y2WW4NIo7svO7EMcfG05INFotxJ/S?=
 =?us-ascii?Q?lm4HXVpKwwPW6QAGKCVolAVxWDizPqRRtATeG5H11J4zTw7lvRmIbZdH8V09?=
 =?us-ascii?Q?dPj6S8WQfAqttY7t0gbbZ8nKwFDgbRHS5ME8yb3jq9GsS+RBTjg6CKQ12Hjb?=
 =?us-ascii?Q?KgGAeFrsDjgnUYjfeMvdq7AbgXf1B/d3fwfNn7/VnOykE6t4/DjDYRJ+J8v8?=
 =?us-ascii?Q?3uJJHtGDvjO9mjJHsBa5Nodb1srOmBJmOP14FiRPizaccXIbGfiBGg4Ez+XS?=
 =?us-ascii?Q?VWkfZJECOqAu7EUSMxgHjmSXE2zPgesXIkA5gQz0G9+w2aN+UFbp7e/bAUCX?=
 =?us-ascii?Q?aa4rhOMpKI/8zmcVnyu77JBE9q+3CV+3THBtmHYERG5QX6ranW2RPdaYbc66?=
 =?us-ascii?Q?KVtEggOXkUv/lu4bz+bxY1HmGizq2ro8e1IbqsaiIMVQNanV1qsWM27yEga8?=
 =?us-ascii?Q?ImgPyIhcCd3PfVBT/BhAYbUkvIAZLAU8aLEAn7Fhvbkzv5s71Fw4sbmCjZb6?=
 =?us-ascii?Q?oGq8WsZIGzqOyOaRpwM281wf0CkjmFM9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 15:24:41.4782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d924aafc-749d-4cea-38dc-08dcb88763f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

On Mon, 15 Jul 2024 18:28:34 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Add a function for given a opaque cxl region struct returns the params
> to be used for mapping such memory range.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c     | 16 ++++++++++++++++
>  drivers/cxl/cxl.h             |  3 +++
>  include/linux/cxl_accel_mem.h |  2 ++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c8fc14ac437e..9ff10923e9fc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3345,6 +3345,22 @@ static int devm_cxl_add_dax_region(struct
> cxl_region *cxlr) return rc;
>  }
>  
> +int cxl_accel_get_region_params(struct cxl_region *region,
> +				resource_size_t *start,
> resource_size_t *end) +{
> +	if (!region)
> +		return -ENODEV;
> +
> +	if (!region->params.res) {
> +		return -ENODEV;
> +	}

Remove the extra {}

> +	*start = region->params.res->start;
> +	*end = region->params.res->end;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_get_region_params, CXL);
> +
>  static int match_root_decoder_by_range(struct device *dev, void
> *data) {
>  	struct range *r1, *r2 = data;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1bf3b74ff959..b4c4c4455ef1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -906,6 +906,9 @@ void cxl_coordinates_combine(struct
> access_coordinate *out, bool
> cxl_endpoint_decoder_reset_detected(struct cxl_port *port); 
>  int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
> +
> +int cxl_accel_get_region_params(struct cxl_region *region,
> +				resource_size_t *start,
> resource_size_t *end); /*
>   * Unit test builds overrides this to __weak, find the 'strong'
> version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/include/linux/cxl_accel_mem.h
> b/include/linux/cxl_accel_mem.h index a5f9ffc24509..5d715eea6e91
> 100644 --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -53,4 +53,6 @@ struct cxl_region *cxl_create_region(struct
> cxl_root_decoder *cxlrd, int ways);
>  
>  int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
> +int cxl_accel_get_region_params(struct cxl_region *region,
> +				resource_size_t *start,
> resource_size_t *end); #endif


