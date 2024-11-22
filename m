Return-Path: <netdev+bounces-146854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144F59D6504
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AED28169F
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BFF1DF96F;
	Fri, 22 Nov 2024 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bRZyYNT4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9B188706;
	Fri, 22 Nov 2024 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308317; cv=fail; b=ticZiE23VS4Fu6+93GTMWQNYz9yh8xNka6Y4KlNfoYwy3EWY7QecdYt/yPs6xx4Pag/AuWd2DzXFQhUl2TcZdCZtHDxgsRz39eBCm06ia2lDrYH7617NPyFS4T3df6WrTOTDeoVhjdBZ/ziXbaie9iQ424bhKB8SPUaeLzCBS50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308317; c=relaxed/simple;
	bh=SqLU6UDw+/dqej+XtIimWuNIfOwGvDD1vyax1QvCNgU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=TSR+9+DRVfmro0ANpKqCQupTekfKMqtvZHqOkyydIv/9Ztlnb+m/B0oGejgYM5idupMDjYquWHlLdkdVOt1DaWzKVkrxuMGw14SKcfSkBY3WrpCSSYsEICp3NKf+eJf+MftOm/rKrppDNCKcRDZklf/bx+QEkxfhEAPtlLd65bA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bRZyYNT4; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+KaP5rbl9nvE+BjVB9ES50zS04Z6syON4BDvYolJIl+9GtwqMbevCQ2DtvOf36sWoo8Hpg5ZEJ+nM+SnB/T9OHLNuOzBaVyWxP+XcscxpWyS/pV7qBORzTFuGGorvospX2JZXpe7zm7yRETatDLfXrgsCgHr0eTv3Gtz4T9VRL0zSK59qfc0bkb5iWwX65YpdfyopRWQ4zTzOs3p5xbrhscn44Wm0xQpsFbdYgY98EREl7mBh3dqzMpoHq6vOHIfrqRrk+JJBPSZN+6Nta2UFKJBwPjL5PycpqQyRALqCfIEbRwNqVT0hOIQj0qQq881yp7sEICxvJgoagtFjO11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQJ6jiyV3Xm7gROjYAtXaOJjHCvmDjjIgIUbet1O3qg=;
 b=RIQgF3xFH8PzhyYZ4qkERxc9plJ9rhkkvDdIW7eUkdPsmMbjzRl6dChKE5CmXJMWVN2i+dbeYW8q72Hj9MR7/g8U3LFgBATTxw6JxmKPYyPi9gsPPE9SviaEmUA5Mw8K4rWThapCeXp4OAqzZDibkR3rb1Zxgs6VxPpvc38eYNZbXCVP/1RnKs038ihOyEun+I54db5NGJ0lM8apgJvFTIpARdrlCsKAKZYFqRQmx/eoWSIojTrfYjoxz04Y4ztNaxndEcRVcHVFAFbFZwQ/Z1fLZ9t0wRLWdAV1uDsKP4X9x8XOqdkHH02r72APiN5Er2nDCNEniU4EHRPc5LDCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQJ6jiyV3Xm7gROjYAtXaOJjHCvmDjjIgIUbet1O3qg=;
 b=bRZyYNT4Q5q/rX85hjD0RPUUbpm5NevY/UXtMDcPADJQ0XQfCx1N1pStBNt2o29M5nNWvlrRbIVJgNMsQtmIa9n1j/xDfJo1itaX4ne2eTG5wd+FDl4uLQB81vmffXvZUp/1kS50kXCH/C3YZNYhtiexsXYOZ7WvWMpm/ySSu7o=
Received: from MW3PR06CA0019.namprd06.prod.outlook.com (2603:10b6:303:2a::24)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 20:45:12 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::bb) by MW3PR06CA0019.outlook.office365.com
 (2603:10b6:303:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Fri, 22 Nov 2024 20:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:45:11 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:45:06 -0600
Message-ID: <fe8041fd-b6a1-4e0b-87f6-4205489a5c26@amd.com>
Date: Fri, 22 Nov 2024 14:45:03 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 08/27] cxl: add functions for resource request/release
 by a driver
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, "Cheatham, Benjamin"
	<bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-9-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-9-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba8a768-6c16-4bde-9cfd-08dd0b368f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEVYcVpDazkxNlFWVndmaUdiajN1SlN2ZmFIS0NmQWlZMWwxUGQycFZYR2d2?=
 =?utf-8?B?TXBwTXFzTlZTQUxQTE9seG9JeFdIVGVlaTJJQ0o4aytSWGxOamx5NUFEekc5?=
 =?utf-8?B?QmxvZCtXMnd3b0w1cHpmOFJGbHNGUEIzeHl4S3hrcVZUSTBDUUlKclMvUmJO?=
 =?utf-8?B?M24vU2Z3V05FYkdzdkhNY2J2dVBBZmZybW43VG1kMW5KejluSTJIVDJXdnp5?=
 =?utf-8?B?WDhUcDlEYnRmNDZsR0N5RHptejlZZ2tNcVNWalVOd1VZWUorU2lmemxHdjNP?=
 =?utf-8?B?N0hBUklENWhvUFJtUmhldUptWnNHNFNQUFBTODU2ZktIS2tYa0hNcEUzQjBM?=
 =?utf-8?B?ZWcrSXZpaDN3akRhNDZSUytEVWNTM2tFWmxDcU10elZ5MVJpNnFWL1diTWty?=
 =?utf-8?B?RjNieVUxOUpSRmxBSEQzWnB2bnk0NE9adXg4a0U1QnUvWDlmRjlKNHY1WjJR?=
 =?utf-8?B?NEF1VzMzV1RzU2taUmk4a0JSbnpuZXpsMFdsMzBpdmFYbVEzRVFCUzVheGZ4?=
 =?utf-8?B?eXMvOUZWdGh0YzJITjJiR1BzdXdtVmQ3QVZHbUFZTmRRN1FpejVmNEdLbUNW?=
 =?utf-8?B?eWo3UWRpVlZwRlFId1l5WWtDL2FOR0RwKzdSdVdMcEVWbnBvV2FDS0dldGNZ?=
 =?utf-8?B?NmdhSnc1RURZdk9xTDZBZnpXMUpENVBHWnlZbXFneGFyYjc3dDM1TUx1Q3Yv?=
 =?utf-8?B?UGlnQ2hoMHZDbWE1c3BxZlZMakcxMVNiZFlVRVpaQUxOSGJ3Tzc1YTFnbWRY?=
 =?utf-8?B?c3d4WFkvTE02aWd4U2FBN2NDUUhrelV5NHB1L2dlQjc5REFZSi81Z0xweERS?=
 =?utf-8?B?NnBvZUVzVHBubnlzZ1NDQlYzaXhiODEzWW5xMkFnSUMreWFJaEhOY1Vzamsx?=
 =?utf-8?B?dW4rSE9QSnFYZmVtUHQybkUyQkhZaGZBVXFGMnBYc2Yrb2twWGNOKzVqZnk3?=
 =?utf-8?B?Wkg4Y1cyNzNBZ0RvUnNkbjNNS29IeDlPdHUwUlp1VW1QMmtDa0ppN1JwdkYr?=
 =?utf-8?B?VWpOMUVBbXBOMnBIZTZwK0pmVmV0M1NITFFjY3hJaVZjNnU2TWNodWk4Zi85?=
 =?utf-8?B?TnRpRElaYkhDZXJaVEQ3a0JOdWtSYkpQL21zeTMxcnozajFBMTd6a3cyZksv?=
 =?utf-8?B?V1JKRG1XT1FFT1ZwWklLRlpIUlhMK2UyOWNwcHlpaUhGbUhyYmJvTlhKaW5G?=
 =?utf-8?B?THRvZjRtWFhSQUdOS2hSOWVUYzY1Nk5GU3BYTGdCRVJVNmFOcGE4aHc0MXBT?=
 =?utf-8?B?Wkp6NEVIUlBBM3ZmUW9tQ2V2dlQ5a21iNFd0WUtZL3NBK1FUVStIWE1TcUpJ?=
 =?utf-8?B?QURvVzRkWmVPcUhPdkZQUVRPMjU0clp0bjRLMFAyWmpmWlM1VHYrRmxZaWVx?=
 =?utf-8?B?a0JVdEoxS2l2ZEVtMFhuVFRnalN5RmtLRk03UTdFMFVjZUFVcSsxS0xlVWdO?=
 =?utf-8?B?U2hZajFqUEhodUhqSkpTdDA5VUF1VkExM3dSWjg4K3BSS1Z4blowN0M1YjBW?=
 =?utf-8?B?K1JuMWtZZlV3NFZ0elhJWmxSWlZOMUZFdTNVTHVyRWsycUZDR29SOUM2SkZx?=
 =?utf-8?B?N1RManJBNHdtYm94a0JqOXpBZW5oUDlkdGFJU1Z5dHFjRGJUdzFERVRJeFRU?=
 =?utf-8?B?OStXMjhtc2JRMS9rQzcwdFB3UUVWMFRYT25Mam9IYXlIYUdSbTZnTENEWjVR?=
 =?utf-8?B?M1RwREFwOFJ3YmZHN0ZERXVMSUF1R2k4RWxHcUtLenFDMkVWL3o1Zy8yVTI3?=
 =?utf-8?B?OSsrVzFuRG5oYWJjazY2WGZwSEwvVkxSVEMyWHJVSW12WU9wWk8xNjhySkM2?=
 =?utf-8?B?U051YUg3Mkc5T3doY0F5Z2NSZDhBc21yTHhaeE9tano3bXJybkxuSDNHeUh3?=
 =?utf-8?B?V0hadVNYR0NENlhBdkwxT3R2QVJzQmwrN3dUYm1yTC95OEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:45:11.6962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba8a768-6c16-4bde-9cfd-08dd0b368f69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Create accessors for an accel driver requesting and releasing a resource.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

>  drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h         |  2 ++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index d083fd13a6dd..7450172c1864 100644
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
> index a88d3475e551..e0bafd066b93 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -54,4 +54,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>  			unsigned long *current_caps,
>  			bool is_subset);
>  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  #endif


