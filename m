Return-Path: <netdev+bounces-146341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F269D2F5D
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 21:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8941F236B2
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9EF1CF5D4;
	Tue, 19 Nov 2024 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hl1YFE3S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE68148FE8;
	Tue, 19 Nov 2024 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047414; cv=fail; b=sg0CVFhi6yZ6JB/v65EO6v6yeqH9Umo9HxVy9JctvT9jXcEr9L/xx1OKYJI1lU+x2OK9jNZoXz/xjlW4LincWO6+EHw67T90QqCYhnzHih9XgsIY3orCz7/FY6NP974KOdSAxxnXeLly3JD3rm4Kt1As1kGZP9dKKQAfUhtbAr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047414; c=relaxed/simple;
	bh=CBcsrRrF0iI8KgzI1yfgK6MlBbaPtC1i2v1Lu2AMBVE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qv6k16wzxE4mHpbzJ0tf3o4Abogz4GPkILF9qSOwqnc2pvNmWQcHm86JnJF+5azD/1a0lPyQE397FaSUm0oADtIm4Zs16+s07kw5uYg2PAVshOREep1bYvgixloSeQM+hcD8OSPyCyYS0W4aW+Wb1DOFU1GlFkt2nWbgjAw+89A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hl1YFE3S; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHHuXu189yAKoLOnAePiPz8UiflKi5wqoOGJYzZCyQrGyQTP49A6NiOcwY9XHUgDFVQEGr0MtbaC9Meve3ialGUfKSRYMq8fSqKfvcByHdXvw7o+yK+wg8QBc7LvR7uF3fNmEgT3nHGPZ6j2TjJ/V4ANCzFS+6ppl6Xw3KwsR5lPgkYwKfjzFv9Ej6KwcJwuLZkibL+/msD7QTbrH3NzF9cd5jB+3ykUw3wMzN0jef5SelZ09OxBkpnOFv7+3xiSNL3cCIW622mKh4+1VgWraADM3Jf3/+KStHs0OSKtDCr4JeHDKvG2s5V9Wnw9h4Hmre/GEY1EoMZYq+EKOuZcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udK6sYwx0fDcMj25PydUAQFENgJ1YNgt1p2CyVOIuOI=;
 b=FYwl5pQYM3PqW/Jn0CQF90UslJAgL7+lV21hMJ8Fw9iioAw29d4Sr6jqTJrz2q5X2BXKf68uE36GLhJovJkpFFh1voP72LxmCTCKo4Oivov8ptD4ximwZg6EgjpT8Gn6MZMioQtk1Gou8cjb9+aH+bIJ4qGnUXCvTaLMSmQNs8C7FV9JE+MyIhfWy5MDDumAr8FZ/JZu8hPthln9SXGHQVEbIIUHbyWJ7m/igVMPqivRAgPgZdy4QzqOzf8m9JwmWm0TPyh1w57Y2JykrsTZwYKXoEpn8u9yNOtctOCe6uthXCm59pPijJ3sJH/rAQ+/VjEJojYCvzhVVtccY/eYTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udK6sYwx0fDcMj25PydUAQFENgJ1YNgt1p2CyVOIuOI=;
 b=Hl1YFE3SLIQzg7BMZHOC3krET4pgCYR8ljHf15pQiklentO6hTqw3DE4Ub05njyOCMh1X52qLlndv3iAx+cOr0RwG+4hlzfavHdQc4+HFgOd1WNtQa1O03xQUYY346tQaLqMgUYL3RhXoJNCfHBh6uYpTDShQNPI/U34tKUijGzM2YmRM6sqpw3HI8XyBYOU6AQSul9oTbZr2lM9VpZ1qrZ+SvQ2b3g+BR1KRGpsSQZKE07YxcCSyyGxn8hEg1XaOin7wd9SYHKNZkuZprmst+OAoIP7c7Hm7mDNXuNlhT+tznzpgtgP9CFVAz0yXarKLEVoBnPNamDXJcZbyXxR6w==
Received: from SA9PR13CA0166.namprd13.prod.outlook.com (2603:10b6:806:28::21)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Tue, 19 Nov
 2024 20:16:49 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::8a) by SA9PR13CA0166.outlook.office365.com
 (2603:10b6:806:28::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12 via Frontend
 Transport; Tue, 19 Nov 2024 20:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 20:16:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:16:35 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 19 Nov 2024 12:16:35 -0800
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.126.190.180) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 19 Nov 2024
 12:16:32 -0800
Date: Tue, 19 Nov 2024 22:16:31 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v5 19/27] cxl: make region type based on endpoint type
Message-ID: <20241119221631.000008a6@nvidia.com>
In-Reply-To: <20241118164434.7551-20-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
	<20241118164434.7551-20-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 227afc6b-4f3e-4f05-a2ff-08dd08d71966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FTRlv7vYzY50OlNoPuMHsTp5W6i5gXQ3SHywgkIkNJM5m9ALW4hocVmH4KCV?=
 =?us-ascii?Q?05QUz84QIgb7Jvic9X1vmnxP7vLhLmGy60RaJaKjDdvrtNk8hRACH9rpZ18q?=
 =?us-ascii?Q?d/6XxJfiPpZJKBq+Et08feRG/ALMxHb75fghd/8Nmh4xsqlCb471Amk6TTX/?=
 =?us-ascii?Q?XbJw+o2sELz8N+o49GGuRkwLdZkGSvEdCTE5UK282l1gPysN0p0Ua8cfQDoe?=
 =?us-ascii?Q?qlZFYFywYBADi+CvPg6WUBujO5ab8M8DqsH6k54GfF4WHZdQS63Z26wsMwwv?=
 =?us-ascii?Q?pg5nALO2THk5/4Z5PW+HmE/JF4MG72N2qQxVCnZXVnPlHRsybNtBgw/kCKTk?=
 =?us-ascii?Q?gwu7EsrJ53LTklYgDfXdfd1d5bpYu9n2gOW+7y1Q9t/xKNED5UK/QMN19uCL?=
 =?us-ascii?Q?gE9A/X/hcNYGd5VH4ErMiWze0bslTA9LJNaRaxFXJFVewUWJRfp/8LXujRAw?=
 =?us-ascii?Q?n6a8eVqZ9kxNUX+17OH8arE0UXtm+7xu47a3nEyxFN5RXu+UtePIslvYpVrl?=
 =?us-ascii?Q?0V5x4OFwHrRCSmF3ksYEWubLRb2rUk1FCuSldfpyvAFb2ctIqkQOONDv0p8t?=
 =?us-ascii?Q?+ZFCcGRcI6BGkXyzUjGGrnLE7qNuGXtHBITPm+GBL+FacB8Lhno9AHLv8fWu?=
 =?us-ascii?Q?V+lyKOnAJhQ0ohI0h58LddMZZ+IPXByVcILjXrP3ISOnPNzuiPVkoo/WVosZ?=
 =?us-ascii?Q?l+Q7wckQkvbY2ci/xKdUvFESNGc1ZEYV1UOcM9You5BaCQ5YxJnS+EsEnUKL?=
 =?us-ascii?Q?lbZaxT1W6u7RzVA7bhl0SfvwElcSq9SXqNfX5rifEtOeOjjdaeYmglECsOS4?=
 =?us-ascii?Q?FGZ+m9cpcl4j5Bs6w5cOshmn42aSdh7LGnXdZWGwqS3QexI8s0G8cc9QvUKd?=
 =?us-ascii?Q?loGyFgVW28foYz/lEsp6e+SBbXGbmeC+EQYGQqsCdvDumvVj5RT5QioAYGDv?=
 =?us-ascii?Q?e1QWcjJZFIVW0/DYDsHDxS5vxVMuHCy3F1YyYT2WdU9OUF9YrU6wAEYCxs8U?=
 =?us-ascii?Q?KlKREidCAWkr6jfGFYqox60y5M8aH/fRxPy3PKOT3Y5Nr1z+OU5GYqy/EFrP?=
 =?us-ascii?Q?DuS44clkpxG7FRd4AaXuokUpz8xhGhEzVVivJc4KuWEaqLdKNSkyWoAdLP8S?=
 =?us-ascii?Q?CUC8FMF1VZJJ1WUvSAcF1o8+MqfYMw1zlHLDIPK11/Lak+XQqC7Y2CWcIiOs?=
 =?us-ascii?Q?+Lp5Mk55d0mHa5ls+zEla9p+lz8e9HF7PnJXQmpY9J/UyNbgdYUKX2+H73RF?=
 =?us-ascii?Q?Q4bi0re0KytU+C6BOBpeAjS2lV001lhiklSm9pzrLHIbeV1PMbCOAiZAsAKb?=
 =?us-ascii?Q?Bvcc9HBdMh+RoVPMorT8fP0UoGVRoTKIYgfi6T2Tv7UVvFxS1cGyBerD7ziP?=
 =?us-ascii?Q?t6C/Fs/3yf7UQybjRUB/dBSqr4baHmPStVVd4h+gKHZidyAObg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:16:49.2376
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 227afc6b-4f3e-4f05-a2ff-08dd08d71966
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792

On Mon, 18 Nov 2024 16:44:26 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 

LGTM. Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices
> only. Support for Type2 implies region type needs to be based on the
> endpoint type instead.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d107cc1b4350..8e2dbd15cfc0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2654,7 +2654,8 @@ static ssize_t create_ram_region_show(struct
> device *dev, }
>  
>  static struct cxl_region *__create_region(struct cxl_root_decoder
> *cxlrd,
> -					  enum cxl_decoder_mode
> mode, int id)
> +					  enum cxl_decoder_mode
> mode, int id,
> +					  enum cxl_decoder_type
> target_type) {
>  	int rc;
>  
> @@ -2676,7 +2677,7 @@ static struct cxl_region
> *__create_region(struct cxl_root_decoder *cxlrd, return
> ERR_PTR(-EBUSY); }
>  
> -	return devm_cxl_add_region(cxlrd, id, mode,
> CXL_DECODER_HOSTONLYMEM);
> +	return devm_cxl_add_region(cxlrd, id, mode, target_type);
>  }
>  
>  static ssize_t create_pmem_region_store(struct device *dev,
> @@ -2691,7 +2692,8 @@ static ssize_t create_pmem_region_store(struct
> device *dev, if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
> +	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id,
> +			       CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -2711,7 +2713,8 @@ static ssize_t create_ram_region_store(struct
> device *dev, if (rc != 1)
>  		return -EINVAL;
>  
> -	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
> +	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id,
> +			       CXL_DECODER_HOSTONLYMEM);
>  	if (IS_ERR(cxlr))
>  		return PTR_ERR(cxlr);
>  
> @@ -3372,7 +3375,8 @@ static struct cxl_region
> *construct_region(struct cxl_root_decoder *cxlrd, 
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> -
> atomic_read(&cxlrd->region_id));
> +
> atomic_read(&cxlrd->region_id),
> +				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
>  	if (IS_ERR(cxlr)) {


