Return-Path: <netdev+bounces-146859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F959D650C
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF34B21E85
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DDB64A8F;
	Fri, 22 Nov 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2SFwtJwS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E705D189BBB;
	Fri, 22 Nov 2024 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308386; cv=fail; b=YbtCNcwOIRJj6RGXT3271GgjWnpXSXDC70x8qJ13vWcxM6kR6cpooNyYUFDfhctQHtdp48wmUr12OWcWmolXrtPgv+NAwyNGKRUEIhRqbHjMwFINCTR7lfRiyqC6vSY6IBiCyj/QKMcKLMmP69IU0+dOtE/WJYuM1U7HteQ3ID8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308386; c=relaxed/simple;
	bh=SOWxyItHuc8ZOWl9wpv8YhoSAd9VoMClwYH+hqESBs0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=IL7wcc0AZ6yWxz9NHTxSNFcvTGbjQ6MhxAEG2rOlKpYOOG670Lf4RP0XWXYU1N9MbVJrJ59TPI8/u9f5I05J5q6EKgjOiNleoa02kNLyCBfK4sDv66+CsuLe76ixosMie3MFtcNN78Gw4fV+cDRjgRLmc35SBzxG2IjRWp8DoTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2SFwtJwS; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtXC/X8oHE8kKTKi+EOrLYjl5wCl6lnVwdf8HFT8yayZSY/M+r9u4I/3KSaGiSXpuRBKb5E+km01rPm8qNb4L09HJCrZtilESSQrcWf9UW17Cwc5EMFaFgsgPPT83xscgc0Kyty2iLJaYWPIaXEb1loKwYwt68Vl/Pdt10yERTLKWqmN1Dn7+SWRqvn3btPZ934XfH7/XIFjUj1xdOgf+LB/CEvc+F0rR6RDfrdxvHyy0/uy3IS3f4i9FvXv2Wwl8nUUQSzwIup/m+sEdKkaJPYCS5Fn2M1rr7aDwWEr0zxWFtBvWVjyRGTaqVpnCg4kQrFFnf55h3VL3gRwhNoFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/GeFua2r6BR3rDBB5XdSoxboKtMc/1CT0DBP2nk9p4=;
 b=gbytJiE9uVv829WWkEz//mJNEn51APRaA5Ecml3jcdyyaY257gEzgusVPGMQmfzwHvlXOGrJMc8yCgj7oDF/Ztt3ObTsNnz1jg7Mi7bFgHCAUKd4pykov9KNPuRhalmEAmRDFXaCL+N2aDxGiIedjCze9qEPU/0525ZsFjv2xwsQ0X7r8xMB5SLZeBea+zqv8sEdYXnvgELiwx54j+AA8QFISk3b1l9+AzMOvXZ21xSk9fAN4c32GoFZZsDGha3pZjZq2ZLWLW7muFpcZxzg4M17w4dTQehrng156/ANZ+PratwKh7r/P30GivRBd4QALOvOAbJpBIPgvHXmyxj51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/GeFua2r6BR3rDBB5XdSoxboKtMc/1CT0DBP2nk9p4=;
 b=2SFwtJwSBMCTSJSg6vZL1FmuYuiTf3HxbgjassKn0tD9FnccjlCrWW/3tWLbagcQy83vHZKmGfqUsPnxtVCGU2BoOd5+MavVQmWWIldW98PQwlrUDL03O+/U6Hy0jf5SP1GwfXOTBCp1McpM7zC/twOQxZebQtZ73YqVC2nwTEU=
Received: from MN0P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::16)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.18; Fri, 22 Nov 2024 20:46:20 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52a:cafe::26) by MN0P221CA0028.outlook.office365.com
 (2603:10b6:208:52a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Fri, 22 Nov 2024 20:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:46:20 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:46:16 -0600
Message-ID: <32f4889b-c097-4e72-8a71-511aa06daa58@amd.com>
Date: Fri, 22 Nov 2024 14:46:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 24/27] cxl: add region flag for precluding a device
 memory to be used for dax
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-25-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-25-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DS0PR12MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d614aa-e4f4-4e42-cb85-08dd0b36b832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTBoRC8rRHhpMFlUTjMrbDgvcU15OXdWRVlrNXF3OUdZUW42UGxGZzJmd29O?=
 =?utf-8?B?dlJaNjVTWTVwU0l5NnUzdm1Rc3poV1Y2WTlMWjBjbkU1T3dGVFh6SVNaV1hX?=
 =?utf-8?B?dnI2NW1uWkxpd3FTYzNKTDV4ZW8yb2dyVlhMRzJZci8yaGhJQktKcmJxdUxL?=
 =?utf-8?B?YU9QTnJib29lT2ZyRHVNVE9rb3B3a2lCN1lZcGZDajhsZEZQVVpkT3d6eExB?=
 =?utf-8?B?VWZSSnV0MzI3OWlYVTNPL3cxZm1oS3VzU0tJZVR0ajhlVlJMOFhBd1ZxTzlX?=
 =?utf-8?B?d3ZiMWU3TlBBYW1wMGc4ZmVXYzhIWi9GeHZUeXhxZVdTYkZmRHFQbWs1RDBZ?=
 =?utf-8?B?QzNOM0RXYUZCTUg3RVFHTW5XcUNoaU44OC83K3RJZU5UUzFwcFV5VmFuSGVa?=
 =?utf-8?B?WVlXRW43SkZyVUorODRvRnRxZFh5Q1FMNjlLeW15a09ndStNOFB5NjVzaGRw?=
 =?utf-8?B?cWRZKy96Mi9mSVhYd241ekliM0RpRVdLOE1JMlkzbkZidGN4eUVmbDR0dnlX?=
 =?utf-8?B?U2JPcjZIZVFlWEFXK0N1a0Nyb1JmYTRjNjRCU1NBUStNOFQ5dVl5WkRYaUla?=
 =?utf-8?B?Mm9ycEI2TGM0OU00Y09PZEVLMDJHZUZCK0MzWDFYVUM3SFBVRjI3RUtCN0hQ?=
 =?utf-8?B?dENsWHN1cVdWSHBYTnM4M3ZLQUVuVk9JL2dZTGEzbklOWjNkblQ0alo5U3JU?=
 =?utf-8?B?R01FWEFqVUU1bHFibzNDV1BRRy9SOTl1Nk55c2RjTE1nMUtsdGJJSWpRQmYr?=
 =?utf-8?B?dXFHYjJkQkYxbm8vZXQ4dTdvWVVsUllnRzZoMzBaQXlvM1BjbnRZV1loRzRi?=
 =?utf-8?B?TEdETldxUGsyNnRyeitRRlVSYXpVTkdzTUNQQlh0QURNRGxoRHJUMkZva21t?=
 =?utf-8?B?SW1TNmlhNnNmdHpaSDM1bXl0Z0k5MzNDR3lDVEJMeEtGb01XTStMMWplU3VD?=
 =?utf-8?B?anJPczNIa01tVklHVWN6dVNGU0xOYTF2b2ZQYVlWbm14S2hIT3ZtVDIzUFZP?=
 =?utf-8?B?TUF3bHdtRllBL2IwaitmbTZINFp2WTltWjIyOHd6aCtpT1FOTE0zME80YTVZ?=
 =?utf-8?B?WnJZTUkrd1J6QjZnaUJGVHFnb0dqdElMOUpWcnZrd1VIdy9LZ3FGVjJ5Nmxt?=
 =?utf-8?B?M2ZRdmhyYnNjamswM1F1c0ZHVXAzNVc0VlRwaWlRbitEMDhIWXF6Wll2K1hK?=
 =?utf-8?B?b0tCenIrVUR3NVFvenRqejVnL2xtTlJSOFpRbEhzL1NKbW1nNTVBU2pCdm9T?=
 =?utf-8?B?Zys4d01WVEtQUUhLN05RWXBYRS9ZcGk0b0loaFBIWUwxbHdYU1pzeWppbGVW?=
 =?utf-8?B?V1FjNzlNdUZxWlcwQ1VHK09QazROLzFpWklQRmJHUGxQZ2dyM0xzTm5zRldo?=
 =?utf-8?B?Zzh2alBFb3puOTVmZDM4MnlIUzFheHZ5N3V1OEg0TS9Wbm5jNy9MV3dZVHJT?=
 =?utf-8?B?MTUwSXdhOFROSFplQTI4TE9NWU5iN0o5YW83U3FDOXpsVUlneVZNQk5IS3hN?=
 =?utf-8?B?UmpBTlBKR2txSkR6Y3lWVkhIczNRL21OZGoweVN2OWNJcG5rVFNBcHYvNUx2?=
 =?utf-8?B?VS9HeHNybkRuUzE4TmtRVmhOTURDZHpMVVJwbmtTbmRCVCs0eGJPMFhKWGhU?=
 =?utf-8?B?ZGJIQjNuM1ZNTEtaSThVT0dvcHJXeU5JdWdEbVNaek0zWmFMUjBFS1RHRERs?=
 =?utf-8?B?NHI2NTVrTXZ0TEFTdzRlTmV0UFIrRkM2QVB6cDBFc1Bzd2tQbzRvQ2R4RE9I?=
 =?utf-8?B?S0xYOXh2a2p4NWp3Y3lUbndmRWFPd1FyY1I2bFBNZXFSOVpxcG9TYzgrK29w?=
 =?utf-8?B?cjJJeXFoeXVkYkFtTnFRMWxNTm5qbmloaEdPd3BYaEF5RmFpK1EwZGVuWHpQ?=
 =?utf-8?B?OFBldWFHNDZzdzVNSW9LZmkwc2ZRVThKeEY3dDZ1WDJYZDd1MzhNYXpaSzc3?=
 =?utf-8?Q?5OUBtjiHAlOjpfRmtuINpLfGTwXVVCdR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:46:20.2173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d614aa-e4f4-4e42-cb85-08dd0b36b832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
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

I think it's possible for a type 2 device to have pmem as well, and
it looks like these are the only two options at the moment, so I would
just move this check to before the switch statement.

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

I would like to see flags such that the device could choose the region type 
(system ram, device-dax, or none). I think that adding the ability
for device-dax would add a patch or two, so that may be a good follow up
patch.

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


