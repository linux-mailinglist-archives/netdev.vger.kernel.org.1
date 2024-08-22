Return-Path: <netdev+bounces-120999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82AD95B5FF
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1144D2852A9
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6301CB12A;
	Thu, 22 Aug 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hx2KKmUM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6791CB125;
	Thu, 22 Aug 2024 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332080; cv=fail; b=XtSJCGn79snmRh3SUl7PKOVirTAqe5KAS9ZKDdnBDHbjvk03vDL6Wv7Uf6/gJ/m+FNtz8XELDRbAuprRM38XSEOSOEKS/hnlZiUnr15QGJA2dCouT8u1XeP47n7k1FOSQzhAmE/XQmD9cRWn6vOdOKji4RGA3BCqusj759WC+ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332080; c=relaxed/simple;
	bh=QUDNdBzwLh//7wBJLa+AS5ZEgyiy5SOg7dwdPZVk1IQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZQKFGi1iElCA6Obh6kcDU01K7fMA8r8Bdo0aA78sp/5FsSp7/M/Ub0G/s8vwa5ZFlZC8ZBFJQ5Wyff06SMUiHKA75mcbGwqp3YnTm76xKvRdDO5QNZmDZnnC/ogXBmlS2VtMiN2rAt23t42dsujBv6zQE6MpCF7DhQirCPjbk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hx2KKmUM; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKercLBAU1pecI5GgvGh+d7jV7mj+E9HKeE58T9Yn1OLk+Tu3tnLVxhnfM++q65380LfFiUNjS6RLucKoOOHcvs+o9yTFBW3hqFQtAMRn9HYRmsdxTtfnIU8e/RcL8/Ql8/ajXx/HSF42zbZCkZOva8u4EP2seh8WL3C0WptIrySmhnpLlXAC7oBg93dLb9/f3z5+273eQZoaaWoThYAbM2ChnzGuj1UYICJR/w2a2Di8GOSoFu2IT/PGPr1GMKOSqdjJMYTPq9zNKhuhAvAZE8xne38oVuD7aR0obKIpuy+WimrAeqvHe1Tn8yC/5dpyy7PBHsiXLr+7ihg+S7Oow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVgSWbXogk5kXejJZzJSCS2Y0tn6n0iXfpOUmtVj/bc=;
 b=lLFbkW2c6/bgi8Mywm0juuy496PnhBZSnY+KayD8TmU8soW0a6ue/vOq6grypvr6NBEI20BVKLTOBWapirmrBrzUSLQY66jkQGD78ZGTHvrvoJ+32lAPc9bkO+UepNHdo3oej29eN4nDK0943l0C0K3EniV4qGrQ4Zpehm0oYN+paV3xXrGg04j/Se9wUMxTfDGy9aoQHTaB2TK7Stke9mqi4czVtFeMF36tpyOIeh+RACHKcMGoN55N+DJJbuO0BJTIYg3bSDJFSxEs6SUq4WoHt7m7cO23XNsZmkABkO5CFg6+HbyORXbn7o+FHRkjzWVedD4vw0dzG3JHQUJAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVgSWbXogk5kXejJZzJSCS2Y0tn6n0iXfpOUmtVj/bc=;
 b=Hx2KKmUMlyGNzN40X1rBL3PbCPF4lSrLPqOHw3valOnnUuowMXd3/74Ek4b2eO7u2cIPTTCF2C+BJ9pxFwVMsuRiz2s2uHoLMwiXzITFPpLH3n13qXzw4LvACZ3MJDfA0qEsO7aUQKu9zo2pxbsS1YK9C2UajX8+cGrQmkp1oEsAiiaZYLL2FonjZ9zrah44l5GQiHAry68RNrmUcSsd3m7KlytuR0aa8RZ/mda9XmL/rqsE4oKryZioMvq/X+677jyOeSfEh4dc0HmOKS1rv/6xrKQtebagabUNHefJbVrw7L6i8pPQ+V+iRgXZv2DM7z1MCohE/Lo1Qfps5f52kw==
Received: from BN8PR15CA0058.namprd15.prod.outlook.com (2603:10b6:408:80::35)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 13:07:47 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:80:cafe::dd) by BN8PR15CA0058.outlook.office365.com
 (2603:10b6:408:80::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25 via Frontend
 Transport; Thu, 22 Aug 2024 13:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 13:07:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 22 Aug
 2024 06:07:33 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 22 Aug 2024 06:07:32 -0700
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.126.190.182) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 22 Aug 2024
 06:07:30 -0700
Date: Thu, 22 Aug 2024 16:07:30 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>, <targupta@nvidia.com>,
	<zhiwang@kernel.org>
Subject: Re: [PATCH v2 03/15] cxl: add function for type2 resource request
Message-ID: <20240822160730.00002102.zhiw@nvidia.com>
In-Reply-To: <20240715172835.24757-4-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-4-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5d76ed-70d5-4192-3436-08dcc2ab6adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tF1cGVtNOqp+t2a9bbr53737/aziQ7451tpPsk1W3ZGJhGyWlAv+gugdrUyI?=
 =?us-ascii?Q?oIds84dcCbhHIOdsP0fLlvzwOIWb/WAbIyzjerMaxOiwWgtbSGVqVVP96Lrr?=
 =?us-ascii?Q?7AGg74DAQZvMOXmwMEsT1TgN9ehllp/abGzZofrq0DlxSDYzicf9tBLRcryo?=
 =?us-ascii?Q?DaaX3XF4c9Ar8WhyS5VGl15f1wmrn85cqYVgM7YsmKNMCFPg4ItPI/4zG1Wk?=
 =?us-ascii?Q?+qNNYOv+bBwZLqSlmu/LX/uDU4et1Q2XTDP7YyPMkSKl9tVZzHKFs5LzLUz4?=
 =?us-ascii?Q?fo9927igVkt3ZnQ8LN1YF3CK+iAofbxcEVj/9FnKuGpw0hPPkcDJhJdYPpjm?=
 =?us-ascii?Q?i+wsoSEqJFQt2q9IctTZd5+ofSR6CI8F5aK7e0+bGZW4+NZYjAi89lb+xXNc?=
 =?us-ascii?Q?HtU3HljIbH++FAyqZ5kP2PFOWGB6S3ZWmkpoz826CItXoDe6FZhbH1SPC1+7?=
 =?us-ascii?Q?ak170OWItpEOm+DZuF2yuoJnkGNuLgzTdB2mHv1fg8gexrc8zVIGlYlNAoxm?=
 =?us-ascii?Q?OA0yLqS2Wl8kj8GmZzBlNqAQXEd4rK6I+Lim3Y5jScWPeL/O8bHUKk8lFsUZ?=
 =?us-ascii?Q?365/KfyQTJj2t7Ewqo62t5eKnOceqlIfeo3QXVFggabnl+BNjlx4l3zy3pcT?=
 =?us-ascii?Q?XiOPU1xmn99H5HVLU2BXZtZ2mqFEThL6xUSM57oSTXw2ZcQXNpByBcmIvwFn?=
 =?us-ascii?Q?b9UzLRd+EAV/NLKiIH6b9K5W+yGNR3oKz/k/sZGaI68k7hMydMVaz5YKxCKr?=
 =?us-ascii?Q?8rZVpemdpUyy92NEwA1sT8GkuXnypcrcV08f8OERFulL0xeQnXFJg4HYqajV?=
 =?us-ascii?Q?i7moOaE1hYVZ67aKi5Mpg4nS4Vmxe1884sofL2eFhe3RuBkc0kyQf5+dRe3M?=
 =?us-ascii?Q?bsx76bMs3RSd3btreYuk0VtI3NapUjb6FsTIE1QndI1pXU6R5ArM56BIh1O3?=
 =?us-ascii?Q?+LspNvDc1cLNr4JNc9W8Ju9YvEUZGcO+d0SfNmGb54PqbUMIxDq31cPF+gcF?=
 =?us-ascii?Q?lfFgrnoivEDJvAUy2jJtR+ASivT6fw0lhQIbhqoPEoBbCW+rzwIhElHcfLdV?=
 =?us-ascii?Q?wiuyMadW12ZUEh9Z55/R//pNE79HRGYTxD9FSo/gkanlCDaXlQ1Up1eufva7?=
 =?us-ascii?Q?03Wgog7hT+ukUJPmaplA7KU0AWlVbnLfK8d3w1CCQ2Obz9GqEh840z/LTWQk?=
 =?us-ascii?Q?un6geBRirAGZGnZa8ZxwkKPvCgKI6e+qOwOxiOzq1pbx28l7KNcwNcIK0kyY?=
 =?us-ascii?Q?X0MeAFk3/FwzfQ4Zb8QTyd/eS9xJja5vWgh4fH/nRetN4V8KlHYMTa2bfPBy?=
 =?us-ascii?Q?Dk9EWk8kgA/o2Rqfjrv3/7RH5gzsfvZLVjzDJYEhyZcQoNcgwPWnHCm5cWcm?=
 =?us-ascii?Q?ZcCKjkqg7XnWz2HG3YFkq+eyeOy2S4PFBrTS249vDx1OWld6PtlbSfGyY504?=
 =?us-ascii?Q?XFiqo1o95ovRFcuVG4WF2WHm5HxEA6zP?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:07:46.5839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5d76ed-70d5-4192-3436-08dcc2ab6adb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163

On Mon, 15 Jul 2024 18:28:23 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create a new function for a type2 device requesting a resource
> passing the opaque struct to work with.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c          | 13 +++++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++-
>  include/linux/cxl_accel_mem.h      |  1 +
>  3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 61b5d35b49e7..04c3a0f8bc2e 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -744,6 +744,19 @@ void cxl_accel_set_resource(struct cxl_dev_state
> *cxlds, struct resource res, }
>  EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
>  
> +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool
> is_ram) +{
> +	int rc;
> +
> +	if (is_ram)
> +		rc = request_resource(&cxlds->dpa_res,
> &cxlds->ram_res);
> +	else
> +		rc = request_resource(&cxlds->dpa_res,
> &cxlds->pmem_res); +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
> +

Hi Alejandro:

Since we only have cxl_accel_request_resource() here, how is
the resource going to be released? e.g. in an error handling path. 

Thanks,
Zhi.

>  static int cxl_memdev_release_file(struct inode *inode, struct file
> *file) {
>  	struct cxl_memdev *cxlmd =
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> b/drivers/net/ethernet/sfc/efx_cxl.c index 10c4fb915278..9cefcaf3caca
> 100644 --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -48,8 +48,13 @@ void efx_cxl_init(struct efx_nic *efx)
>  	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
>  	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
>  
> -	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
> +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds)) {
>  		pci_info(pci_dev, "CXL accel setup regs failed");
> +		return;
> +	}
> +
> +	if (cxl_accel_request_resource(cxl->cxlds, true))
> +		pci_info(pci_dev, "CXL accel resource request
> failed"); }
>  
>  
> diff --git a/include/linux/cxl_accel_mem.h
> b/include/linux/cxl_accel_mem.h index ca7af4a9cefc..c7b254edc096
> 100644 --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -20,4 +20,5 @@ void cxl_accel_set_serial(cxl_accel_state *cxlds,
> u64 serial); void cxl_accel_set_resource(struct cxl_dev_state *cxlds,
> struct resource res, enum accel_resource);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct
> cxl_dev_state *cxlds); +int cxl_accel_request_resource(struct
> cxl_dev_state *cxlds, bool is_ram); #endif


