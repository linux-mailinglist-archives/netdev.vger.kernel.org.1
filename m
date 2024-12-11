Return-Path: <netdev+bounces-151199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B09ED64A
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 20:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E5782842A3
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B5D1D63F9;
	Wed, 11 Dec 2024 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uP/2BKOR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DD1C1F2F;
	Wed, 11 Dec 2024 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944671; cv=fail; b=p3rHIlUDOxnSMzMRB/BllXoWu2vURJX8rMBEzvFnZihRj5Qhsj+zZjbZoxpmHAW3C+Cl/rizxOEYhhIvoWp9uEuKzrEK0KNcIyBEFcAouzDMPvwUAWH+HuivlqMxDmrlhcTOelGU38q82ahE/82T6kHnT3GpUF8TcI3ytrrnlPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944671; c=relaxed/simple;
	bh=qlxubNMytjRKAUTWUgAA8P6BDciKFQbbVATk+pxVA38=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGInbs5CwvryUCPMjA0IlFSXNQLFNm2gPvx99+7JSSdAJK7OSfogtvLiZDxdFLP9NJ/paTJna9bbjCf1PbjEHvGcQten6ZECJx+W2kQQ79m5oZ7FIKkR7PVynqoA77YVx+mTDMJYcoV4sCfFHkDd/c5LDpzJK5JUICegwO25xKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uP/2BKOR; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rveMvaWuOFq6nuEviaOce8Yz+yvu1wUhmre6TafzMnMaeLHtOkL8yFMFZLEGAE4H5vNyzNWHOkR1FfSdyyfNuYZ4w6Z/1k1o6aC3UmCE6vdG9ePOmE1XnovDeihU99xOYmbzLupFzMceZ/tt5irjnZMwSVL+MFZOgBBP4U9BMN+J14Nf4zoh4n1Sq68w+SfYEhqyG3INsRuV/BiClVaN+c6VOFXkXfxu9GlIj8hvNt0/w/RRJtdu7X4CIColKhR/c/F+v2Xe0JZBvdC4bEFqfWfIeT7OCocoiR7k+eQhvKeH36IChIpsp74eeM8KEAaWZH+t5tMZdulI5dnAwKJ7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vce+4MFscfqVV4q+sPUMOZVvfqvM4yAmGnXKnwZZfxE=;
 b=zHA7QSgGEP4bw1JgzOh7OEaUZi857Nh8jbx5Npxh4haHzY8hEMD0DBLV4uSmodJIFka96DA0L6WzUP4jU4KY2pCce5XmSh4KTaNhUC6YW9vRe65t5iSZGE063OUahc/kb8cnER5V+D31TMMsNbMBt7hfe01qRwUPaoavnWLoe6OW9zKbypAGYSiH6EgmvqTHGX6qcKqq66CYv7o4kPbumuShu1iy9SCVKT5p4DVPmR8NPzdkUk0M5rM3tmSCxwJKtLx8sbBp9EPKYejuZ/oO7OgijCOqcVkPfoz6pjyYTB6MvLnJqXgFf7Hr/HE5quHzLryf9ukTIdQtsXY1V1FgLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vce+4MFscfqVV4q+sPUMOZVvfqvM4yAmGnXKnwZZfxE=;
 b=uP/2BKOR0hdu42S+YJay8DZuiCOQKh3EW5QFv4a26h1ppog+5aJV6+im2M5PST9O7YcaJIir86XGEai68Vmk/2TZgLnPYiYDW0Bk8i4tsVgFfkkIV34q0lnfowCw9MPQPFpnuPahJiIw0N2fCRo5a/8vBT7ijf3VWsVJAvOe/bQ7qUnEc4leam9XNNLyf5R6iQdk3uBK5evjsW+Oz2i+s4+IWRiY/CpTrpSQ5riXS6r12iag6fZ6njHBMkr1/fxLUnxWthzaQJmxYd9fqp0yx/2SOvOqcc+4Tp2vpVQM3g+xmb3IxbVUR5eoItcUG0fclXj22qhthUnZn4pu37bMCg==
Received: from CH2PR02CA0027.namprd02.prod.outlook.com (2603:10b6:610:4e::37)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Wed, 11 Dec 2024 19:17:35 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::54) by CH2PR02CA0027.outlook.office365.com
 (2603:10b6:610:4e::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Wed,
 11 Dec 2024 19:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 19:17:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 11:17:20 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 11:17:20 -0800
Received: from localhost (10.127.8.13) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec 2024
 11:17:17 -0800
Date: Wed, 11 Dec 2024 21:17:16 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>,
	"Alejandro Lucero" <alucerop@amd.com>
Subject: Re: [PATCH v7 22/28] cxl: allow region creation by type2 drivers
Message-ID: <20241211211716.00001342@nvidia.com>
In-Reply-To: <20241209185429.54054-23-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
	<20241209185429.54054-23-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: a5044ab2-faf9-4bba-d4fb-08dd1a18777e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AYwfHHsDQtHxZly/SQzLOwPQZM90a1ePBY3BXuElbY0b2YmhvYt5IKP0RRq4?=
 =?us-ascii?Q?Gf0NnY5vTQ8n7urp6/rkCvjTQvDPkdoMwUbi9tKtKasz3jJR7GrRcN5TZ9Vg?=
 =?us-ascii?Q?VbaJlYMwUUfbIcO55mhw4mUSsyLg6EiN240gOQgjfbHN+s6L4aKkh0hBIZ/2?=
 =?us-ascii?Q?u4xpelzMfMsoy5uaE2BuyycNpyAGZ4o06sLZ3izoRlRoLmf4Q9FIZEVuaajD?=
 =?us-ascii?Q?4ALXAeIIFK+S2QccpwBI17KFqOTCnloyiQZBCvgkBX4oPtksmoKdSMWZ/HQ+?=
 =?us-ascii?Q?dvc1KR5QfnxHwJ4powkZR5WLuB0rV3J17ka4BOWrhbAB3vM/OVAJIy4BrEoJ?=
 =?us-ascii?Q?39JVhTWnMDOIrEJ7x2yhR64c4bAqDvQS0ln+OffbuGjpnq1MsCvCXC5/oDiQ?=
 =?us-ascii?Q?KcvssH50FqwBlr/OgHwgoWYhE2XEpYb0/7TN4hzkblZ6nfh/dQQtMfDm6wzn?=
 =?us-ascii?Q?SFWuQ7SDDfOLhBkaG99+jCygTeL6NufTvBzfrCi/z4ROL76mo7haVxRIXB+f?=
 =?us-ascii?Q?wSGV7Qknq+wUKjXp9h81MwyMEUazSfAWWlG1CL/l/D0ydBD+HPuCMDpUte+J?=
 =?us-ascii?Q?g1IYyilpymE4lBIkcs0rlayPdWDVNLjdLMgp1xb8LtO1Wuy6kfvAlRdfwLrw?=
 =?us-ascii?Q?qatgzOpbaM6NqRZJLsWVPg9OPaYBUYVk/1dgedoqImiBmRCkHckjqlPsfdwk?=
 =?us-ascii?Q?XRmnxAi+aaacluF6udBo2dBsoHMSkfD8QS2C30P3GWlGsuu7Pl3zxTmSGHML?=
 =?us-ascii?Q?y0833F3jd2PbRbXttJbuXY14Lgf4ZKVviV5KSTkFWMwCueBRXaY6m8bbJJUj?=
 =?us-ascii?Q?i6O0DmGMBuBnpbYtolXCuCGGaEqUNpKNcn20x1hKDFn2iQ/1K5io9s8kfXpq?=
 =?us-ascii?Q?Gvp7RprQLwYBdAXDdvPJfEM7Qn1haAG58jaWR/11601LUGpOCEigRV0d0J1q?=
 =?us-ascii?Q?r3bunRW6L+YqmpkV3lyGakHyGSAKJ/ca39sDGwRsCfeL4ge0nxTQWSLRUO0M?=
 =?us-ascii?Q?0bjNXvwyQXKf+7Uy+iuqnvHxizPtPJuVaIZfH1wM7ZqTi6OQoJbJQu4V5Crm?=
 =?us-ascii?Q?8wHBTFNXkbJWlSiRW43XKNfA1mXAyQpbLIWgAsOxIPUwNbzDRlf4QnDai5lX?=
 =?us-ascii?Q?9IyHld167zqxsAJM6ZI9pPhw6RCx18Zmi0YmusGdOCicOUcuol3XiuMKxfHn?=
 =?us-ascii?Q?D7hi0dtWhof8ae6pYFfDVx2ZZwFkag7+3fhGm6lHzI589MjW0Td2oaKJQjt/?=
 =?us-ascii?Q?UO5JPTm7NJeZhq7ri/+sRAM6795WdTLdgLFKFWQzyqkmkqYby5iPzGFCSmui?=
 =?us-ascii?Q?KVlgxHBr2O+29WmElmM2tcp8huDexTp5HiD2t0N7JNShF7sMLDW/aXno5AA1?=
 =?us-ascii?Q?kE1ae3m0a5XhWvud8GWX3gGoHa/aNUrXh4XUbCFjNoitkCeoNSzdJ2a+JUet?=
 =?us-ascii?Q?oWST0Da3W8NeQXlJDNXggQs4aY2YbEmw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 19:17:34.1253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5044ab2-faf9-4bba-d4fb-08dd1a18777e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312

On Mon, 9 Dec 2024 18:54:23 +0000
<alejandro.lucero-palau@amd.com> wrote:

Reviewed-by: Zhi Wang <zhiw@nvidia.com>

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
>  drivers/cxl/core/region.c | 148 +++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxlmem.h      |   2 +
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |   4 ++
>  4 files changed, 142 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5379f0f08700..b014f2fab789 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2269,6 +2269,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
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
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
> +
>  void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	down_write(&cxl_region_rwsem);
> @@ -2775,6 +2787,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
> @@ -3381,17 +3401,18 @@ static int match_region_by_range(struct device *dev, void *data)
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
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> @@ -3400,8 +3421,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
>  	if (IS_ERR(cxlr)) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s failed assign region: %ld\n",
> +		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__, PTR_ERR(cxlr));
>  		return cxlr;
> @@ -3411,13 +3431,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
> @@ -3440,6 +3480,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  			 __func__, dev_name(&cxlr->dev));
>  	}
>  
> +	p = &cxlr->params;
>  	p->res = res;
>  	p->interleave_ways = cxled->cxld.interleave_ways;
>  	p->interleave_granularity = cxled->cxld.interleave_granularity;
> @@ -3456,16 +3497,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	/* ...to match put_device() in cxl_add_to_region() */
>  	get_device(&cxlr->dev);
> -	up_write(&cxl_region_rwsem);
> -
> +	construct_region_end();
>  	return cxlr;
>  
>  err:
> -	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +	construct_region_end();
> +	drop_region(cxlr);
>  	return ERR_PTR(rc);
>  }
>  
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
> +	return ERR_PTR(rc);
> +}
> +
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
> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
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
> index 4c83f6a22e58..4bb89b81223c 100644
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
> index c450dc09a2c6..e0ea5b801a2e 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -60,4 +60,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     resource_size_t min,
>  					     resource_size_t max);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled);
> +
> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>  #endif


