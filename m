Return-Path: <netdev+bounces-151200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959949ED66B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 20:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8099B163CEC
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 19:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824C25949B;
	Wed, 11 Dec 2024 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HosjjY0U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1F259497;
	Wed, 11 Dec 2024 19:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733944869; cv=fail; b=hUPaXv/A0/W9pYLQ8OrfNMALKp/RCosWx/+5p2symzdfYggqrSs1IdMmtjLD5RjZxr551DY7WJxa8dwozvd0o6eMTX2dO2Bjzcag0EjzrdGLkVnounCNm8WzZi6F4yo2fq9MOdoUIKbgVMkCxrpcy9+9ENxD48zc4riSloxUXfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733944869; c=relaxed/simple;
	bh=J7ye/VuNPuz1KRkTSxqK3LeBOtkhSmjGDP2ftGIHro4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOPXDwzYBnFn+/IFjMaolX+d5rp1veJEbMkxOm6DU/HWCcncX0NBNYvSxMUXJKpbHLAKjwMxJ7z08dfpfa79ZOvUh44b7+Xii0muAHFotULMbKnQR6w62qSemLy26dGCUGZf84SiYeBcLl39CnD9Vmnj8CHcHXNPGlLUhJ0cz/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HosjjY0U; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=habpuRDV5PXZM8k8J0GeIEIQHqy/ffF1r3ofWiH17KVEbDcnb5ZtPdKLkC7PEMJ4Ri1QtOUCvTFPXwCUutyj2ZGmLK0qQdNpqsQERSqFyyyF+SvG0skqVio39NeCHkOCAQDChS3cPSGGaTBNp4dcc0UWUOLHeGwk4TGnQIIsmObMdBImTLMe1WoNiETa+RrTf2lslMnekYmWc14D4Dm/6ks0EyDS5cDXyWkI6a+bqg004fH9z6NYXMEvEutfHSejPhcMLg76I1xzHcQ0OZyEk9ZgIN/j7MU/riHpM9nahURfFa4jO9xegU+Vxo597IHEzvB8RH7PlDm9FuoLAO237Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukBYmoga4maiUwAYo3bjMwUByGbTFKBh4TpwuC3z8yA=;
 b=X0+I9H4BMc5KMy6LpU9c76rK/EWzRMTlKOLEoaSLK6QvE0YkePwJ/R/oBuYL43n3ChCskyXXlVv3bwAKOuwIe3bUwAmG9KUACYIfhoLAeGZILcqqpOXB0CS70JWjPcn0wEz37P0daEOGGu8j3bM0mQn8tRztoY9cOXv6NFIF8LyCfm2aY03dectcRsmSicMVj6RvX5ItCkkHlCqXSPG1mSVnFK+xjUcarYQTK7y6ssGwadDjwg2BpAuWpTuGsJNDY4SZQS3mh70qE9rVCfbVtFsX9uQ/4d8nRqwLLKOM9+IR2HQwNVngkO3kog0RYRIGxxpNJVKOUAdlUcyI/31ktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukBYmoga4maiUwAYo3bjMwUByGbTFKBh4TpwuC3z8yA=;
 b=HosjjY0UxKkxZrfuAUaTKfHXLNkIkaD1aesAUR6ZXX2qEg2jIxBKJsoQ5BWmpjObUFPxDo5L9X6beVEAHAvGXiVmsbF3+43RzjU8xgfn90y2VVTslYa9DWf9KLsB03o915EZ9aaidXDPdzFOJ15p8IQZ3z+xm3PnVgaVX8Cprd6diI4QPGh7si/hk96C9IDm7RzZzpD4XVkDaOD4Z4bdwmhiEsjl3xCULzh7nPx1MeBW4fEYHr4YeCXp60ad3SNJjdbQnrg0dCdmNfoaRD2tDYBKL15tEV3xa48ukpfYndWE42GC0vWPjXSSqdrbKS5HFiOsaARve8GYk7FQqftIUQ==
Received: from BLAPR03CA0138.namprd03.prod.outlook.com (2603:10b6:208:32e::23)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 19:20:56 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:32e:cafe::57) by BLAPR03CA0138.outlook.office365.com
 (2603:10b6:208:32e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Wed,
 11 Dec 2024 19:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 19:20:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 11:20:33 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Dec
 2024 11:20:32 -0800
Received: from localhost (10.127.8.13) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 11 Dec 2024
 11:20:28 -0800
Date: Wed, 11 Dec 2024 21:20:28 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>,
	"Alejandro Lucero" <alucerop@amd.com>
Subject: Re: [PATCH v7 04/28] cxl/pci: add check for validating capabilities
Message-ID: <20241211212028.00003f91@nvidia.com>
In-Reply-To: <20241209185429.54054-5-alejandro.lucero-palau@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
	<20241209185429.54054-5-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: b697b440-47f9-45f8-d82c-08dd1a18ee93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v2cTOVGOrZzKb9GQ6JOwuXydguwLOgM8Z3yGCMOBdMnEaY0UBxVE4U+1xu/4?=
 =?us-ascii?Q?ViLcua1BEBdBme+60BCYQY+JM3/TeKmDFjpnzJAz3yMO4Ol8ISWB9XY6O2cj?=
 =?us-ascii?Q?CxdbaA6xgwizcErrUtQOpTx07UJW6JQ+b87vTG8Iecx153EL+YzuMu9qudpR?=
 =?us-ascii?Q?OMtscD+dMWUhzUTe9GUhhD6CV30XCDd+drQhwbjT/3ZhhYix29PLa4ITyC3y?=
 =?us-ascii?Q?zJ+rp9HC1i5nhadUVx2Jw7XimWueuu0iXyZPHL/OzvFW8bo64gEdcWZB2pZf?=
 =?us-ascii?Q?X4Z+RAliM0c2vt2dG1/vz4ZbmfvmVqAmGwNlItVZearbhw5wFtVqnCNIKDKl?=
 =?us-ascii?Q?Jr5zLmkkj4Zg+xQMUp8ueqGgXulKiwQtzfKL8UeOUeqLEjetl/ZRFGj1Jf6n?=
 =?us-ascii?Q?fHhUaqlCB3UdvcVYbVou08JW+KbCvT+vcma5LxjKiUGReEJcrO/jQ0ZK8771?=
 =?us-ascii?Q?kmKsCPnFdXnR/+WyDwpVRglng3BnBwbf3JUF2p2f3fJ+slZAuc8kCp+XNsYF?=
 =?us-ascii?Q?oN5rlZgpglTeWobMNQoKmElc9LGu57Z6HDLthQlzg9pptHqSgg8OoVxSDl5M?=
 =?us-ascii?Q?FWnQnQkkGEihXXljTV7pp5ICi8MobW0mj//Vh+IpiUMxj3P5PQ+YI7JlIyQ0?=
 =?us-ascii?Q?W246p537g77+k67tDqbOn+sDFkZE1Ba35EwiYlBwaCzA9/8J4bHHQ2vJTt9G?=
 =?us-ascii?Q?zpX0RcDjPlf8cj3v50fpS6ijNRxjBcT/zkPAIsd0eOXiMonEL3FLS+64b8QI?=
 =?us-ascii?Q?I9toXqq+C3JVVGwP0sD2E/HgUpkU3AG3Mo/dNJSm+DdD9zTC2vYaVU/g9VcT?=
 =?us-ascii?Q?QBwK3y3wdTBzMPcuCgfukToHKkxBAxOyOhbTPm/2XU6eJOwFHXoHKGTff15P?=
 =?us-ascii?Q?fxAmn7M/R9o3RuRpseZkTuTYf/tI0PaLXSnQguNB0Lo2BsBkJzWt83LJ9FVm?=
 =?us-ascii?Q?PXt+wuoDX+TfhmDTSP4WZNVPvDGD8tUOLPrO9Nybf0U/gY8cakxJqP68dM08?=
 =?us-ascii?Q?XnRROXlxl23l82fHHORJloIIMubET2ObS1Ms4lDXUbTQBCxqN/CrNhRBxzkB?=
 =?us-ascii?Q?ut9p3/ADL/49wOD2fUEgGCxXJ10Gh3DIIIJTWge4eRauvpO8H1Tg1yIcbEpf?=
 =?us-ascii?Q?KVCNc+kHUXXorxn4NXkMyqlOUCU6qf7NAnwx44o34gNneoUV+Ye52kt9yWlY?=
 =?us-ascii?Q?Yxoe0CA9OxUKYYchHVcGRatTdDJKJhj6aCFyQt6Egfo0l3TQHZ+vF8BEmzrb?=
 =?us-ascii?Q?IUWrRcbaCNTboSjAA6WpP8VdSVZiVl8xtWwb4qjaadM1r2qUbTDlf8TxQez/?=
 =?us-ascii?Q?aNz5L/G/Hj1mm4xU56+O8ozAinwHifZBd77gFcUKo8r1nyIQS9BKIITPh9Tg?=
 =?us-ascii?Q?KvLFkBk4AssyFbTj+OqHsogFh5rppRzUt5aXaGh7Gxwsu8AEy5ZmwFfEaRuY?=
 =?us-ascii?Q?+USDOtKoBCcW+RPVFnJMVsWioRX2JR/I?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 19:20:53.8651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b697b440-47f9-45f8-d82c-08dd1a18ee93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211

On Mon, 9 Dec 2024 18:54:05 +0000
<alejandro.lucero-palau@amd.com> wrote:

Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> From: Alejandro Lucero <alucerop@amd.com>
> 
> During CXL device initialization supported capabilities by the device
> are discovered. Type3 and Type2 devices have different mandatory
> capabilities and a Type2 expects a specific set including optional
> capabilities.
> 
> Add a function for checking expected capabilities against those found
> during initialization and allow those mandatory/expected capabilities to
> be a subset of the capabilities found.
> 
> Rely on this function for validating capabilities instead of when CXL
> regs are probed.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/pci.c  | 16 ++++++++++++++++
>  drivers/cxl/core/regs.c |  9 ---------
>  drivers/cxl/pci.c       | 24 ++++++++++++++++++++++++
>  include/cxl/cxl.h       |  3 +++
>  4 files changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c07651cd8f3d..bc098b2ce55d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -8,6 +8,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/aer.h>
> +#include <cxl/cxl.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> @@ -1055,3 +1056,18 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>  
>  	return 0;
>  }
> +
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
> +			unsigned long *current_caps)
> +{
> +
> +	if (current_caps)
> +		bitmap_copy(current_caps, cxlds->capabilities, CXL_MAX_CAPS);
> +
> +	dev_dbg(cxlds->dev, "Checking cxlds caps 0x%08lx vs expected caps 0x%08lx\n",
> +		*cxlds->capabilities, *expected_caps);
> +
> +	/* Checking a minimum of mandatory/expected capabilities */
> +	return bitmap_subset(expected_caps, cxlds->capabilities, CXL_MAX_CAPS);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_check_caps, "CXL");
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index ac3a27c6e442..deaf18be896d 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -446,15 +446,6 @@ static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
>  		cxl_probe_device_regs(host, base, dev_map, caps);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
> -			return -ENXIO;
> -		}
> -
>  		dev_dbg(host, "Probing device registers...\n");
>  		break;
>  	default:
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index dbc1cd9bec09..1fcc53df1217 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -903,6 +903,8 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct cxl_memdev_state *mds;
>  	struct cxl_dev_state *cxlds;
>  	struct cxl_register_map map;
> @@ -964,6 +966,28 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>  
> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
> +
> +	/*
> +	 * These are the mandatory capabilities for a Type3 device.
> +	 * Only checking capabilities used by current Linux drivers.
> +	 */
> +	bitmap_set(expected, CXL_DEV_CAP_HDM, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_DEV_STATUS, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_MAILBOX_PRIMARY, 1);
> +	bitmap_set(expected, CXL_DEV_CAP_MEMDEV, 1);
> +
> +	/*
> +	 * Checking mandatory caps are there as, at least, a subset of those
> +	 * found.
> +	 */
> +	if (!cxl_pci_check_caps(cxlds, expected, found)) {
> +		dev_err(&pdev->dev,
> +			"Expected mandatory capabilities not found: (%08lx - %08lx)\n",
> +			*expected, *found);
> +		return -ENXIO;
> +	}
> +
>  	rc = cxl_pci_type3_init_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index f656fcd4945f..05f06bfd2c29 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -37,4 +37,7 @@ void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>  void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>  int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>  		     enum cxl_resource);
> +bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
> +			unsigned long *expected_caps,
> +			unsigned long *current_caps);
>  #endif


