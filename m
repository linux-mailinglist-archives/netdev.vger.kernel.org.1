Return-Path: <netdev+bounces-148636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 566B99E2C3D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53470B28048
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CA61FCFD3;
	Tue,  3 Dec 2024 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fPeF+2RN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821761362;
	Tue,  3 Dec 2024 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251401; cv=fail; b=lxccYRXUq/9CPjA/b8ek62J40I/ab0DM7nQbX3FojAGVPs8FWms6iWkpDFdeIpZ8iTQFh2PY5RJ6bLOorTSdRk66B86E9s8Qh7/SmXVH0bf72QZEbCrzyLWF0b4oQPguyv83YD7vJNOjM1IOzN7a+ZRCW2dJvD5uz4twZZbiqt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251401; c=relaxed/simple;
	bh=50whgG8AoABHOJAltFdsQhD12Gh7D+b92L9uHT9VztE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeDAMCiUBfK0spy3K48JeD5sjhInqy/Y7yFZTv1ENserKSh5XxfClIml1oBtVdS0yUus1RH7ApBnXLshlRHLZSItT4e+K1/eek2ZcPu6lTPEnEjNoV1OqRa1xBvfw14ZYscfAtxKHsoY5teftyjC6FOyibHdH9OGB/1a6eYNKVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fPeF+2RN; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AuE2ha2o2wl0b773I5awj6YtDTA+4AqNd2R/6GEZnsLNXXMVTOXCR03DGwIt3VqU49ytJ2VRnfONcPuG0TClYak/WnICLcUtmFgrNn6xmwSHrDr69omK7ATlekGUIYlmvMV/04kLeWYlpR9dI7CfiO74zPkQZ/YMaMny0FVRpKjrzLSfzrQjETdZuVaSYaIkSzJSW1AYDNtYlcOrmoAdQDzsoZItkBPQhdQqYnu6tFLNdpZebnFs0dCnOOPuTV6QW0k1GebpNp2YYJFiVMvq9Y6hJQbH+TASPeRdP6npa08hlKZElOKCr+HJn+TNC3miPM7bLfHDC5hOVv3cb5cMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RBPHO6BmzKBMe+Wi5tlDQYCO/dQWnLvD86ZSNM1JP8=;
 b=GKe2fYBHRWeIaceP9D/uHz95Zek59TlE6fZpGwJde4BXXoBCpipX9L200YfdymtcPlpffRQDUSX6prb1fqWxPS71rgdJdFJ/mE/01XpaXbvtC+0Myr8jBFNT9TgLa83WtDFXyRmiZq4QCYHUuA5sjs2xCNrtQnRVxbtEcpBeIcYXHw4O3TU0IL2MRMdTsGcdjh1t2eSkYvKdI2F8sv59ogMoz1XLhY5tytrfSoheOrHqjVAGMhQQyUP2Jau3CaMgfU+z6CGuHv0/uza2Rl6QA0kZORgRmqjAwFDDp/PD+xuQuOw9Luz/ZejAyvYs70AKBqHuOIkC7vwl+hu/X3wTGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RBPHO6BmzKBMe+Wi5tlDQYCO/dQWnLvD86ZSNM1JP8=;
 b=fPeF+2RN6aeDt8++e2yR0FFM1tuHRBM1psdLNHu7BLM3N5pTfKNxnQd3mM0GGxN8RH03/BbAYlIIK1bnmUqXQxCYs9g4nPZa8M18Dq7sJKLg5B21Dmfp8F1qqczv2sexGh3iw8AnhF1CpxgEjxT1szZzHkpVt+u1k0kzACzrbJEnU0xZ52ujcj/WkvcuToaDzYX6wPnxkdb4P4hT83qW5TSBxcLDO35k00nG9kyN/4c21iFMSjJNspmUO4Klnajy8nGGYUH7TVzA0SrIsDlmCfpO809L21MTZDQ83BXgPB1z8mmgI70bmfxlzQf76lwrC5b2G1RAG9sV8sOxFq0CJA==
Received: from SA0PR11CA0186.namprd11.prod.outlook.com (2603:10b6:806:1bc::11)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 18:43:14 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::5d) by SA0PR11CA0186.outlook.office365.com
 (2603:10b6:806:1bc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 18:43:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 18:43:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 10:42:48 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 10:42:47 -0800
Received: from localhost (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec 2024
 10:42:44 -0800
Date: Tue, 3 Dec 2024 20:42:44 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>,
	"Alejandro Lucero" <alucerop@amd.com>
Subject: Re: [PATCH v6 08/28] cxl: add functions for resource
 request/release by a driver
Message-ID: <20241203204244.00005e6a@nvidia.com>
In-Reply-To: <20241202171222.62595-9-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
	<20241202171222.62595-9-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b1a434-d11a-4ecf-da44-08dd13ca58a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sM6pcb93p/yxJUcEW6b0CkE76Mp3yvq2rBSM2pF6U/PXJx++0CvLKREeDeEX?=
 =?us-ascii?Q?w0X8Ahc0AxRcqPJF/k/wI4eps8GOnEhPsDNvqPrzgeHqyMVWEeHdvwJBcyNO?=
 =?us-ascii?Q?oFfVtJWzmypqfqxCrRpFJKk5w34MWldE+gFIielZAtF2I0Y5iIz/3I0pIOpv?=
 =?us-ascii?Q?1OW6ru0INnli0O4c5pDkpAMTvI2V96ruEMRGwj4Xb3O5In2h4xVYD/8ah6aq?=
 =?us-ascii?Q?ZR/luZITapB5beBume0MdRJ+hKYMCYzxcvFUQy93A4K8q/hRmqgLq1J8GH6Q?=
 =?us-ascii?Q?yBCStrbo7FP9I56LWU9Fgp8ei8pdpaYMJ+dP/MrlnNXfu4B2RPmkoYDt0JNc?=
 =?us-ascii?Q?vbZ61kJkZAQfCnhCHbkcfFIMVWMmrJ1TRPnPsGG5dWO6qij9q3Cn67NH9fKT?=
 =?us-ascii?Q?wbRHsFOdNtjra61Z8WlOvK+Jqj180SklmbdUKKppYsyxz0dwLoH8h8w5ZE5k?=
 =?us-ascii?Q?Y1Wohxp8caUf4vZ3h96mR3cSwWbYOGzGEIgYcgKBi/dL1XlATSdD/u8UI/qt?=
 =?us-ascii?Q?N8UU4w78yHCEASVehUOULjfUG/VEU+S/L020b2p674oIidmGvE+jUtYB42Po?=
 =?us-ascii?Q?eKIiupvYQ1usemAvmWHPSBOfwWy2cIwq0ndvhyK/9dne9KGQ6aKfVmOL8cgs?=
 =?us-ascii?Q?7k81Wd0Hye0iSFixYCIGmEDqPPj1ziy7ajWW4d9pOG+9Q4GXPBWbdRRxEXy/?=
 =?us-ascii?Q?yLPrgbcjXiPhIE4az6OwXaGpLKkawjbbGswC0Z5Ft8ehtLpKk/yRczxCtKhX?=
 =?us-ascii?Q?DL87bNJEoHlSs44TCOU985PkLaWBF4QpREtiFkfFewmYe49AMzDo2Xw5zJQr?=
 =?us-ascii?Q?Y5W0XdH4NBOCiRc6EA6ipqzBvr/h1reU05F3HC304HtyzBwnTHujpxy74pxC?=
 =?us-ascii?Q?cZan1ZuWsUmLG7TCcWmZIfW1sYl4ctNkMrXOBJm/wqtXj8wJHhfRY1gY94Pa?=
 =?us-ascii?Q?TCyv6iF72Zc9Hqu1roHXn2q/sAtdO+Pt+ZUDm/5K99lUjgi7X57D7PxLv4jC?=
 =?us-ascii?Q?FCtrXf5cZbpNPrBw8ZxlDKGwXW+xDAU/tuf7CUCJYuX+O0lHluqLqFdQ438D?=
 =?us-ascii?Q?kt6+1fksbEr61h+34j/NtPY9KBo7+mPiI3vkKJgk2K2ogPklwi2SUiFKw2yk?=
 =?us-ascii?Q?LrRsqeZkPrD2jAO670ERyL7SggxPbFuV0+o7MypXKzK1gS3nca3YIfZd1BUx?=
 =?us-ascii?Q?P4J+txqPlE1lp1C12rkFKtmU/YEWdA45e4vMFWay4a42+ZxzX/mKoj15cAyl?=
 =?us-ascii?Q?trT/fFkGtiQSmnzI0XoF9Fa8EbQqhkChg5DOxaaBjG8lPOtUumnkKLHIWcHn?=
 =?us-ascii?Q?/F9M3dyOpEZ3MHWfKoRH5ShTksXbrcP1S21VBHLsx63DILTy0LN+anAeYBXI?=
 =?us-ascii?Q?pdZ0Q0vPvYBEQEKXvaFOlF6rIZghZESKLb3zo91V0eYvRgtSklXnjpxUZpSB?=
 =?us-ascii?Q?p8LJlYwolodxWkG8FYZmnJLEbmUDTV+i?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:43:14.5302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b1a434-d11a-4ecf-da44-08dd13ca58a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436

On Mon, 2 Dec 2024 17:12:02 +0000
<alejandro.lucero-palau@amd.com> wrote:

LGTM. Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create accessors for an accel driver requesting and releasing a resource.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h         |  2 ++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 8257993562b6..1d43fa60525b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -744,6 +744,57 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>  
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_RES_RAM:
> +		if (!resource_size(&cxlds->ram_res)) {
> +			dev_err(cxlds->dev,
> +				"resource request for ram with size 0\n");
> +			return -EINVAL;
> +		}
> +
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
> +		break;
> +	case CXL_RES_PMEM:
> +		if (!resource_size(&cxlds->pmem_res)) {
> +			dev_err(cxlds->dev,
> +				"resource request for pmem with size 0\n");
> +			return -EINVAL;
> +		}
> +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
> +		break;
> +	default:
> +		dev_err(cxlds->dev, "unsupported resource type (%u)\n", type);
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
> +
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
> +{
> +	int rc;
> +
> +	switch (type) {
> +	case CXL_RES_RAM:
> +		rc = release_resource(&cxlds->ram_res);
> +		break;
> +	case CXL_RES_PMEM:
> +		rc = release_resource(&cxlds->pmem_res);
> +		break;
> +	default:
> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
> +		return -EINVAL;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
> +
>  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>  {
>  	struct cxl_memdev *cxlmd =
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 18fb01adcf19..44664c9928a4 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -42,4 +42,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  			unsigned long *expected_caps,
>  			unsigned long *current_caps);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  #endif


