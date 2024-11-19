Return-Path: <netdev+bounces-146347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6925C9D2FAB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 21:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296DF280612
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFAF1D63F9;
	Tue, 19 Nov 2024 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PSLbQfOt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69B1D3565;
	Tue, 19 Nov 2024 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048773; cv=fail; b=jK/Smyx8SNHdZ6boDGXy6rI7pEZPMS4eTImnAwOMydYW/9URnhUNe2jrQFGE5eyvxTbS7lzQNT7+qs7ozTdNBC6sajueXZpfe4hDLTA4Smdfq/OrivKgMUB3S+4BO+s/EowHGL8J3H3KVpZQ6kGODoc+pDYf8Qe+TdCXIvM0WFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048773; c=relaxed/simple;
	bh=2f8L9r5MfMXneb4XLRU97r0gfMX7u7bBvq8MzSYvwvM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H760xV/dHlV++kggYDU5ImFoTBNJxdiDr+nVdksHwxSOuMkm0UapBQn78coyQRDfrZGmuFFVFXRXMWBxv2rkICPNZ8allqJzpZqgBY0oh6M8zb9AM3uxSdeazbVyhVw7FOVnHQrSkP2VVdGRp9zNBa6SaRwyuN5xxPaLWyTPF+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PSLbQfOt; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5up9vtO2n3M33vVnWp1zK+zCIrsxqGMCHo01VwCcqggwmbHvzlZFnYdrcsqkOSPWTxAr6SLBSlT8d6wpF+NaRL20p/XwCg/uYofj6+qBtYEtk74NyZH//7wnHZ9R9b5DTdo3C7v/FnPmIfTvNyd9Xvrh5NjSgsnMXqMNA0+FuZfhy7TWUVNTOaC15IPga076IFcNs6AMKE0IJouVkyBHI4umxj0MsDF/6Bwkg0KRdNGAzwb1wjQpmWe//DU+1sg11qsDP7LormGwy4Ow/utJhYN5BuZs4xCuWPVOkwzVRRkJApMaAGgIHoXdcvIpxgcIHPvHOHGj9I5CdX7Ukzmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAxp+bvM6GTNiTlDyS/eOnFX4fCHk0qS9T6VSbzSNoc=;
 b=xzgH+MqBMZfv1AQsRdGpwUj5zEuYUommnO9asSV3xcPqrAWDxF5ZWc+IJYW95z1WafDXVZQQwY6btKpCXrnycGl5dgbJaMj0F9Uvl+ucQ8H8B7RmCC6q1C1rvIsiTvpDLDdHLtUPsV/9J0RbTlKgYSbtjT2MEuQqLnC2Q4jLqNilI24A1S2Opeoxqhzjk/+Ua2XhkT5eyGpgygaOlzBtISpusd1quKkGc/nqvBzLSyLOU3xTcd+futUGId4DPrBwJLKjGABArA3KLO6UoWO84+Lf7Q/Nk8NTB8bZCcmjQBKAD9MbaqJsE/luhqh2x1cryJb4OCtGqX2YJ6MSnRUHlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAxp+bvM6GTNiTlDyS/eOnFX4fCHk0qS9T6VSbzSNoc=;
 b=PSLbQfOt7AT3dHjHr0X/wrBqmcW58sH69RPSk9qR/U3SQZIRIIFHcnkhyEsRNzQEJVFOmc7dVwNDE2xTMpiEUJB7tYd8oXx7Y0W4gAt7J9nqq9uAHFc7Azf8zyhmocxq8YB1sK8yFJhR3T+OV9j3pY4FIzZXqsV0ga1DgjkeGxDwbUJZH2ikhag/hnGPDZPIq3DD9k1cVyEbrqLAKVvNlpnZcyRdiVGeov2ZbDL/M0qeeYYs8DJdVKLO2Q+K0secz0gN7gSRbC1f3C4g35ve0e6SX+JeSRiQatTR5mDk9+JofD14URY1XnvFc+cerbxQ6A4KlZfN7TNIuoVag9rgxA==
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by PH0PR12MB7077.namprd12.prod.outlook.com (2603:10b6:510:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 20:39:28 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::d3) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.13 via Frontend
 Transport; Tue, 19 Nov 2024 20:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 20:39:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:39:09 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:39:09 -0800
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 19 Nov 2024
 12:39:06 -0800
Date: Tue, 19 Nov 2024 22:39:05 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v5 24/27] cxl: add region flag for precluding a device
 memory to be used for dax
Message-ID: <20241119223905.000030cd@nvidia.com>
In-Reply-To: <20241118164434.7551-25-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
	<20241118164434.7551-25-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH0PR12MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfe1f72-bd5f-4c84-47b3-08dd08da4380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JVClLyzCyH9yLmBwD2kzxnrO04D4hSuoGYZiwIV6ssDiQCKxWlAx81QAA3m8?=
 =?us-ascii?Q?2nd4wkRXi080ZhkwQ5rxB8mo8ogqnubdm1oLcfIhxj3qHlRRPvJI180WF+pA?=
 =?us-ascii?Q?rVQj1NDykzUcoStcMTB4MrVQWPdTyyVMOVtCxY0JQIQsldLCUmfi4jnIW18M?=
 =?us-ascii?Q?mWbIrwckDroprPLvHT7yc9RJCk3sLh1Ra6U1q27Kjnpon5Pda2xuheFCHqSi?=
 =?us-ascii?Q?z3caSy+WEIK5/1lOQMzHyCKrJWbikfJ4ECyiUa4PXhuKn0N3wDVa4/7vxNI/?=
 =?us-ascii?Q?tp94QCN5BtW7laTLQvmxz8qN1xQtRwo3oJm+gHKEEB32nJ7a0FGz9LCYcQRH?=
 =?us-ascii?Q?oeV06mm6VNHBGbvi0RzToGuOyoxqCygUQr5ON5XdQmC39OfBpMes4OB1XsPz?=
 =?us-ascii?Q?4n0CQ03ZbGWZ3t/eS9oNAnkQMeDmONY7MmdX+ZWmFpoedhyUuQmLyoGdfEm4?=
 =?us-ascii?Q?CzUr7naKcR2WNiVRO+VfQI5mfHvpGZZ8IEdMnAWXeGhnRe1bvRqecuuiX4yF?=
 =?us-ascii?Q?hT8yvYOPJ+Z1v60MseOw4RdiNCzu7ys99jETuC1RqU2JPsd7Oa7oVv2JeAIu?=
 =?us-ascii?Q?a+BLsU54BLW0g64PiYu+9MpuGoXYaD9lApPVUfRv7H6U1WJKINk6WDs2477U?=
 =?us-ascii?Q?SDOA6eQPR8biu6P5GN9KdSIdo8Fpa2Dpvdsmao2wknLC1h5HJlJ0TPzw/J5i?=
 =?us-ascii?Q?Ur75BGIJO8H6LyvkZQnc04f9WavazKC8cN7LmEb5i3po4i8qEVIAvnw3eR5b?=
 =?us-ascii?Q?ondEIydClCCdbNSztPbfU3/le3w2HkF1nlXkAJP0ss9YXPV30kfnb8/HtYPN?=
 =?us-ascii?Q?1Z01iCiikR+/HIuoiqcbaQoX34Dggt++pMuhpRsYiG5ezF8Ls9mA7jIKX8UR?=
 =?us-ascii?Q?cSJKYlk+1OLHpjrXtY3yM5hNxQhGal93i/qcmZ4PrX4IanSGVwtpnbTugFpL?=
 =?us-ascii?Q?aGMba6SpZdlQ8KHnpLbwHUJpHeHvLevg8ilCFmJ7a1MLTJfjxAODrQVqEp7P?=
 =?us-ascii?Q?qBCvOBQRZ5tc8Pn2l/9ghsAKyuA7PQYd+kX40v+1CJ172g00Ug01rDYi5u/Y?=
 =?us-ascii?Q?0aW6jQR07y4F3HyWwn/+ZENGc0ouVXPvn6ad6/kqy2w41Uo+luGG0w9KiUWA?=
 =?us-ascii?Q?XkhgsTMuIUMHl2/3Vb5aa6bb77pc9HnjQcSubJq8p/cebSgGu2WNQrIAw1Hf?=
 =?us-ascii?Q?5Xrgk7MPCSNyGeoXQYcSJd17yvyJIRRn6Av1+Oy6C3WAhLlMU5AtccgfbSyf?=
 =?us-ascii?Q?nS1YPnsXHEJROFQVQ/fP5VcRPrTTCZvIqIl4LDA9bTugFEdR8jIqle1w7+N8?=
 =?us-ascii?Q?GW9D+coRd9Sfa5rOLehpUzfVIpvNkuT4ASFCakW2+9SHTUhxIK7u9K9Ubs8W?=
 =?us-ascii?Q?IKf+MqqlqP8+IHhPyE0DAo6UFHMFJIcl4n4f9hha3Rv2CZVRCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:39:28.3601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfe1f72-bd5f-4c84-47b3-08dd08da4380
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7077

On Mon, 18 Nov 2024 16:44:31 +0000
<alejandro.lucero-palau@amd.com> wrote:

Minor comment: maybe no_dax would be better than "avoid dax".

> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses. However, a dax interface could be just good enough in some cases.
> 
> Add a flag to a cxl region for specifically state to not create a dax
> device. Allow a Type2 driver to set that flag at region creation time.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 10 +++++++++-
>  drivers/cxl/cxl.h         |  3 +++
>  drivers/cxl/cxlmem.h      |  3 ++-
>  include/cxl/cxl.h         |  3 ++-
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 70549d42c2e3..eff3ad788077 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3558,7 +3558,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>   * cxl_region driver.
>   */
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled)
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool avoid_dax)
>  {
>  	struct cxl_region *cxlr;
>  
> @@ -3574,6 +3575,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  		drop_region(cxlr);
>  		return ERR_PTR(-ENODEV);
>  	}
> +
> +	if (avoid_dax)
> +		set_bit(CXL_REGION_F_AVOID_DAX, &cxlr->flags);
> +
>  	return cxlr;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
> @@ -3713,6 +3718,9 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_DECODER_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_DECODER_RAM:
> +		if (test_bit(CXL_REGION_F_AVOID_DAX, &cxlr->flags))
> +			return 0;
> +
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1e0e797b9303..ee3385db5663 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -512,6 +512,9 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_NEEDS_RESET 1
>  
> +/* Allow Type2 drivers to specify if a dax region should not be created. */
> +#define CXL_REGION_F_AVOID_DAX 2
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9d874f1cb3bf..cc2e2a295f3d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -875,5 +875,6 @@ struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled);
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool avoid_dax);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index d295af4f5f9e..2a8ebabfc1dd 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -73,7 +73,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     resource_size_t max);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled);
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool avoid_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>  #endif


