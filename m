Return-Path: <netdev+bounces-146344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB6A9D2F98
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 21:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4C5283257
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35AA1D1305;
	Tue, 19 Nov 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tzl/HTCz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847216A956;
	Tue, 19 Nov 2024 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048657; cv=fail; b=gs9FqHNLbPKcYTeto8LCr9gl6L63UFtjWOOdu3yQhWBK0PDNT6bzqmM0V4VrkJbqubYuisHAeRGta80ShH9dl3hyDIkIWpuBC5FB1RR9esjOQBwFQvoxdGk+97UnpoNXy+CD0ZkZ4kv6kiFR8WLwDJMa1TBoUIA0mAupfjbysJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048657; c=relaxed/simple;
	bh=pJK2ZE6U6vVLLoJoSzxSm1a7QNsZY5irHbHx66NWSrs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5Vp52gjGBcAQ8bZjVX0BGzfSd+8LPpmT5WbYfppbg8VH3ieSxEeQLOG4v9O3FiSJwSTLi+xgi+mNEt3VyYtSpoqSlhXBO3Lm1XeaP2nnvBZAv4LlalGu4LfZ3uSHVw3XIS0tAUpW+OqJFWN9LaMcLj9mDxsqab4/Ks7WmQj/f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tzl/HTCz; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M+9oUqF95K/Q1WXN9e9tNQiaTLM0iHFwNuQKDI0iXIg8njiSP5ZVXYcZEAqsTSALB1Esq7A1ZIwQMkOoP7Njbjj8L8RjaFe4vsGS3VMUv8m0W7/x5eYeUh7UUZPseef9uH/Bo6mNhJYjbtaVcFUFEXdYNX7EIumcA0xeVySA1qGJGBDPqK6LUgRBjaTVyCIZuJqRvf+wdTxzeMB0XBUAA6qMBqCE5TTV/oaWXV4gc3OCtMalSi4lHyJ4+QpOb+qrdaHu7SapMZ4ZjNEgLPBIpaq8ncQrMM+BUDI5Yu6vLdAFdSHaTRD9ahJzVcJnpwdCg24uGTOmGSVGZm25K09jjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8OLFQeHNfJsb2lphqKQTg6/AmMPN7t3gofsniIc1Gw=;
 b=wDZXNNB3mrS7EJh4O+0Kv4+E66MoGkEnbvUMbtXq38F6FSGZKJdsqafHSCriQ9aBQ7WA1eXBMFH8OUFj3cewQeotNXMXEozAzemSx1VZfNegx6vjXDP9rrhFNeVGcJg5+hAE5MYFXbvCAA+zkztgne6+KBMcvfVgkoq8gAXMrmOz3Dny3/zZAZnbulqSj42DDNPzJkmfW0Ek1dfaynQBnXw7Q/dzXZ5xNT36YhYe6j0pIa19EtDZA/WBDLO35hyhed+wW8mUt2UXvhtrL0WMHbnYtcPIhTIIVzZkSeSgindqtzHF2CTZDxuaGTo1bMFRnGBaPlpiZ51etLfyqDbP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8OLFQeHNfJsb2lphqKQTg6/AmMPN7t3gofsniIc1Gw=;
 b=tzl/HTCzlLVLdVX9bLVFik6gusZMNZM9dVh9r79QHiugrqCmlZf7M3//M81afMPKH+C1GoWGNL1tFzUWJ264QDmA8IkvZW0dnODFxMbmRtXbb8Iv1ottxAUhdkPPgKJqT3+eIreJ1wsc9WHf3LG4cSTUptZCq3QcSsBLYem1XZtIq8BOtWH54OSQL5HPiVlPmytwRlXap5A9cyfLKiXKbyryUXY567ryG2JJH+hPiQwBy6jkFDQH6ZjGR7s5Nz9YmsRiMG7EPNc0JBNhlOpe2p4qBpEz5hJAWzMefIddVsgVKoxSNz2H9X4zAdVGPjbfeiItD+EmZ9qqzDCZCXIY9Q==
Received: from BLAPR03CA0094.namprd03.prod.outlook.com (2603:10b6:208:32a::9)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Tue, 19 Nov
 2024 20:37:29 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::2f) by BLAPR03CA0094.outlook.office365.com
 (2603:10b6:208:32a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Tue, 19 Nov 2024 20:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 20:37:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:37:10 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:37:09 -0800
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 19 Nov 2024
 12:37:06 -0800
Date: Tue, 19 Nov 2024 22:37:05 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v5 22/27] cxl: allow region creation by type2 drivers
Message-ID: <20241119223705.00001c1d@nvidia.com>
In-Reply-To: <20241118164434.7551-23-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
	<20241118164434.7551-23-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: bfff0118-e42e-41ba-f2e4-08dd08d9fc5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQXyOWrT4dMJ0ZZZBUTRaXkugSpRFDqp30hUng28iIjqYGgJyohaQLL46QZD?=
 =?us-ascii?Q?yWP9z//q7cWPlqX3vUva4eAOD5zFAK4GDbJJ63BsGFdm0xOBfUXVNZMgVM5J?=
 =?us-ascii?Q?48MAdy4j/nFxFxxtLbEPJqCdawAjA0Cw1MTFKCVk/10417JAzQ6Cmf6pLQ5w?=
 =?us-ascii?Q?aqA3OS9TCZJBD8w57FIax2OC9ElG6UWt5okuCqSPR2jIbcupNrcTD6hamMIv?=
 =?us-ascii?Q?z4MTu8OlWsMyGo/+cKC6VrlWrPdCbb3kkOqjjIGM5wnma10TrMaU/Xn7c86f?=
 =?us-ascii?Q?6TPZRzOGMJEwR8pWPNpf4sc2KOnyxyq5JLgZzJPKvra4FllcQ24J9YEXvFcX?=
 =?us-ascii?Q?iCeydWy6R5RNTcsjRgqu7S8Le7jcu3/w+buRrdwuejbeH8u88uSPDw3P+EK4?=
 =?us-ascii?Q?iTPeI5d64o8SYvCvu8yVuDmSgzutT86HSuD8Fo0Mp9y5MRHBBumpeop2FhpJ?=
 =?us-ascii?Q?kLGRX3PfOjE0KaQW+8CFFclt3iRBai42R2Ut2gRh01BkoBwOZEqMapBtgMRC?=
 =?us-ascii?Q?ORQvPGXGpl3Jy6+fqyWOQKfDdKVgAZbRCqEfAVY0tJQCVm+2PL56QP42v6D3?=
 =?us-ascii?Q?bE+AEV0B7j5UCm/up+sZmVqfRRS3drdh2dlmlKD5YkHlnRXJrDp2YinXcvIw?=
 =?us-ascii?Q?xXF6E91EmLThf6lDPikw80Xp7cwBsyz4ZArg5xP7VcuhV0lsmWZ/a7sKBmlx?=
 =?us-ascii?Q?tpAASaTB33aHtv2ktiX9Vz8hXVeIqoyIpAmnCEegxwQE6RaUBKgIbrHaXvNu?=
 =?us-ascii?Q?Ny1xzXUoppNJE+yRxrwUCbzUXPujMT/3r7U9k1T40r+PepdSKlaDEl4+rU6k?=
 =?us-ascii?Q?RTPlm7Xno4Zw9UdNlVuUy6dnxoAitm7T68l/x+Ov5lj3nbp1YbwOak283Aac?=
 =?us-ascii?Q?l9S4ABSwi9I1CI6TtlLt8C6lLL3nqkBiKQ3OjxaeQ2BKbH15ZrhY/I9UI1WW?=
 =?us-ascii?Q?UQsy49+2jLna1meKj1SaBLp/DbeN5UOX4DBxYvLC60YMR6fy4iJTtjhT0078?=
 =?us-ascii?Q?C1w3z+c7GtilU6Bi3QPnhO2FIEXZixYLcQdlSFWOhYWZLe1zZsq/mk+zvH6j?=
 =?us-ascii?Q?1DIwYCg01Z8viFCxrLEXOdpm77lmV9LFkiypDrlt395kh62ifrQLWXzmcIpw?=
 =?us-ascii?Q?ljkH8gWfQXhOnuEz3VhtstKF5Fr44DbQMABsL2VegrIyDaQuKIBkUdIUfa+x?=
 =?us-ascii?Q?KawEDhW05PyvSnkIWvtFUdgH3XGIWWNpDXIz4qbAJUEKZnhNtpLtq4FtMo/r?=
 =?us-ascii?Q?TYMLv2ysnC+1/H+QVNlVwGKpxzw3n7yTsnLT2IO3WEOpsGzihOYX1iQCehik?=
 =?us-ascii?Q?R49xVhzaCK6tryI/EmgbEXIBW63p1PbWCj3IroZr9/0y5ibHa5vtNB0zUkl3?=
 =?us-ascii?Q?ePE/MdhaAF8sa3KXtrePEmEV1CPHo70LhIvHt+OlatBeOnyYNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:37:28.9544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfff0118-e42e-41ba-f2e4-08dd08d9fc5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760

On Mon, 18 Nov 2024 16:44:29 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c | 147 ++++++++++++++++++++++++++++++++++----
>  drivers/cxl/cxlmem.h      |   2 +
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |   4 ++
>  4 files changed, 142 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6652887ea396..70549d42c2e3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2256,6 +2256,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  	return rc;
>  }
>  
> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
> +{
> +	int rc;
> +
> +	down_write(&cxl_region_rwsem);
> +	cxled->mode = CXL_DECODER_DEAD;
> +	rc = cxl_region_detach(cxled);
> +	up_write(&cxl_region_rwsem);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, CXL);
> +
>  void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	down_write(&cxl_region_rwsem);
> @@ -2770,6 +2782,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>  	return to_cxl_region(region_dev);
>  }
>  
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +
>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)
> @@ -3376,17 +3396,18 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static void construct_region_end(void)
> +{
> +	up_write(&cxl_region_rwsem);
> +}
> +
> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
> +						 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> -	struct resource *res;
> -	int rc;
> +	int err;

maybe let's keep the original name "rc".
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> @@ -3395,8 +3416,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
>  	if (IS_ERR(cxlr)) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s failed assign region: %ld\n",
> +		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__, PTR_ERR(cxlr));
>  		return cxlr;
> @@ -3406,13 +3426,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	p = &cxlr->params;
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s autodiscovery interrupted\n",
> +			"%s:%s: %s region setup interrupted\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__);
> -		rc = -EBUSY;
> -		goto err;
> +		err = -EBUSY;
> +		construct_region_end();
> +		drop_region(cxlr);
> +		return ERR_PTR(err);
>  	}
>  
> +	return cxlr;
> +}
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>  
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
> @@ -3435,6 +3475,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  			 __func__, dev_name(&cxlr->dev));
>  	}
>  
> +	p = &cxlr->params;
>  	p->res = res;
>  	p->interleave_ways = cxled->cxld.interleave_ways;
>  	p->interleave_granularity = cxled->cxld.interleave_granularity;
> @@ -3452,15 +3493,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	/* ...to match put_device() in cxl_add_to_region() */
>  	get_device(&cxlr->dev);
>  	up_write(&cxl_region_rwsem);
> -
> +	construct_region_end();

cxl_region_rwsem seems got up_write() two times. Guess you should remove
it like below since it is now done in construct_region_end().

>  	return cxlr;
>  
>  err:
> -	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +	construct_region_end();
> +	drop_region(cxlr);
> +	return ERR_PTR(rc);
> +}
> +
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	rc = set_interleave_ways(cxlr, 1);
> +	if (rc)
> +		goto err;
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
> +		goto err;
> +
> +	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
> +	if (rc)
> +		goto err;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	rc = cxl_region_attach(cxlr, cxled, 0);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (rc)
> +		goto err;
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		goto err;
> +
> +	p = &cxlr->params;
> +	p->state = CXL_CONFIG_COMMIT;
> +
> +	construct_region_end();
> +	return cxlr;
> +err:
> +	construct_region_end();
> +	drop_region(cxlr);
>  	return ERR_PTR(rc);
>  }
>  
> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoder with reserved DPA capacity
> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_region *cxlr;
> +
> +	mutex_lock(&cxlrd->range_lock);
> +	cxlr = __construct_new_region(cxlrd, cxled);
> +	mutex_unlock(&cxlrd->range_lock);
> +
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	if (device_attach(&cxlr->dev) <= 0) {
> +		dev_err(&cxlr->dev, "failed to create region\n");
> +		drop_region(cxlr);
> +		return ERR_PTR(-ENODEV);
> +	}
> +	return cxlr;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
> +
>  int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 4c1c53c29544..9d874f1cb3bf 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -874,4 +874,6 @@ struct cxl_hdm {
>  struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index acf2ac70f343..ec1f0cfb11a5 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -33,6 +33,7 @@ static void schedule_detach(void *cxlmd)
>  static int discover_region(struct device *dev, void *root)
>  {
>  	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_memdev *cxlmd;
>  	int rc;
>  
>  	if (!is_endpoint_decoder(dev))
> @@ -42,7 +43,9 @@ static int discover_region(struct device *dev, void *root)
>  	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
>  		return 0;
>  
> -	if (cxled->state != CXL_DECODER_STATE_AUTO)
> +	cxlmd = cxled_to_memdev(cxled);
> +	if (cxled->state != CXL_DECODER_STATE_AUTO ||
> +	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
>  		return 0;
>  
>  	/*
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 9b5b5472a86b..d295af4f5f9e 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -72,4 +72,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     resource_size_t min,
>  					     resource_size_t max);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled);
> +
> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>  #endif


