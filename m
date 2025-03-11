Return-Path: <netdev+bounces-174019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533BAA5D06D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 877AA7A236E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53673264A9F;
	Tue, 11 Mar 2025 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oYDxfWoT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A65264A82;
	Tue, 11 Mar 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723626; cv=fail; b=U0UOI9RetI/HvxZH7Ij1Z15SSdzo6CaLqeE3bjxC3kzfb3jomSQkiqxWu/L68mxVfrO5c8awbAWiO9kU4R5KZIv9/VodBSlaOszjEOGAXmeT4Go6zPNGH1nlbE/gMTwwxkRQpXi33hEJa7EJp/ODG3M8DlxN/xBFC8KN8BIKpY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723626; c=relaxed/simple;
	bh=xZG1AkTmgd4e3EXQeUv1aDTIKetAhysVC2MCD0r16L8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=TNtgIQfrLAXUtML4rnmz7nvI73clTUoRU/PbiiW4TQ1l2TuR38jmKifozjlPT28PdjizAkOJbolKXX+Ep4G9H6Ge8MCRC54rCOOrWnwIdmzaulk9cwKm3vVzqaGqLAmgdwgC2rZ4XU78FfNooisynpaBs3XEBwoh/0LPKGVYpoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oYDxfWoT; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G01gJyg3NxYwyXzCBlJD21azHyqnsH2eMhEWyWMbli6hWOoo55VlQznpeV7BpatNJyBMyckPAD9uyixkWND43HnzdNLqaHV34GEEvW4AYWRLUimmci0gqh7MKQUKrgv/d+jypEqsHYDJp0sPGtS2ZrOkFaojUY9Hl8DBp95yfnuWZLjyWZcbXEPq/UoiXFvW7vGHvH8iopESC0fAnZDHH2Y8PlKMa+O6utuwir7CDKHtyroTIo328srE5U2JMLLMeq/XVe4vGumohKLgdvKLcVKXA3bd2neA56RnJaAH5ttWvj5PxJtK/BnkcJxTaFe5TogNhF7mlPzwXSaCAr1g8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lIovPaCNN46wb/vMW5QFMuua0TPOLc2rPlRxknFbfY=;
 b=U90GIbKY6ssgaaUYkb0RK4RVL8+1VBqRHEvLcznqOBvI4IpQdIbv/Q36ze+G53Ticc9JqlbaWtEmen/P2uSaXj2ygY28Sm2QHwheQC18lewnLwZKDqv1vgdsotkZMTubc4ISrZQ71cpz7OS/O7Hy/OeH8c2bPWqxDpA21Hd/0MmNhOKRUYePwemuWkk8DHG8uz8F0W59CgeNXPEWGNU+uDuZGQvNV18QlZoAhl4kE752wjl2H/qYvTFFBAubvqGU82mK0lcFL7xE7zuTEnYDG2OAzgolbzz3eCMm0dYejLYib6kG18/wpHRceJECslqp8yrVdupGhku7iIIdgsb7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lIovPaCNN46wb/vMW5QFMuua0TPOLc2rPlRxknFbfY=;
 b=oYDxfWoTSkyB+r4bgKSCj/CHd5Z01nw0J8its+e/BL//TX8pd3qGRfe9gP3y+OM1OU7R36M6LVifs2rbqQnHJEbj//7LCWTPHEQ+n4vjzbVICQlkJ6LSGKWHvZUDKg5Z+eHk8quWh6AM+A9cAjpdB1x05xEd7QdQyzBFXh2dGUU=
Received: from MN0P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::7)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::994) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:06:59 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:52b:cafe::f) by MN0P223CA0009.outlook.office365.com
 (2603:10b6:208:52b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 20:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:06:58 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:06:56 -0500
Message-ID: <6a2dc88f-fb7a-475f-aa95-6d1ba2433384@amd.com>
Date: Tue, 11 Mar 2025 15:06:55 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 21/23] cxl: add function for obtaining region range
To: <alejandro.lucero-palau@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-22-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-22-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f64a0a-3829-4d7a-b6d0-08dd60d84790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlZjRzdwQ0ZNSXV0UU9xTlFEeDNPb0JVWjIwTWpoQ0FCdW1DNThkcVYybDlo?=
 =?utf-8?B?a09HWjFQWEU1R29qbFgraERMaXIzbXp6R1ZvbWZDTmkwSk1VRWdqZ0h5ZlA0?=
 =?utf-8?B?MzZ1dGxOSThWaTFxRHZwZkxaVEZnZnBMWWRIdlRMN0NhdUJLaXc4a2thYk9l?=
 =?utf-8?B?dnc4bWM5QkZuemhHcGNnZkQxR1ZMblYvL1ZocEtlMURjRS9tNWhKaElRYUxj?=
 =?utf-8?B?ZUcwNDV4VXltaW5rczB2eW1OTE50ZUkzek5sY1dUL2tuTGpZQXZiQjlDR1pq?=
 =?utf-8?B?ZHV1TVBPTG05NDUvekJXSWZuMVo5NHFobVRJcjNPYldnd1FJaUgwV1R6MXNo?=
 =?utf-8?B?S0VRQlY0LzZTNUlkd3NPQ0tyYWgzd2duZ1ArcWZPdnI1T2JCY0Z3TloyaG9G?=
 =?utf-8?B?M1ZhdVNlYk1rQzI2Z3duMXoyRVVMQnBCdU53cXZiV0k3RlExdHBSL0JuM1Bt?=
 =?utf-8?B?ZkZwSzJIK3VkVG1MUkhzc1ZDWmt4Y2NHTzlUdFRwNlRvWUIrbzk5aWd0RVhQ?=
 =?utf-8?B?MDM2eXhlSHhYbVRsVXRxOWJhZGhzS21LRnhzQWhrenZBOVZBcjdqYUVzQWM0?=
 =?utf-8?B?VHhRVDRYallGUWRuTUlTNUtlMXF0TGYrbVQ3Wk5hL000RkRzWXJZTEUzb3hP?=
 =?utf-8?B?Z1pyMlk5TkdYR05HT05UQ1FTOVpqTWFBWWY5ZG90T3NHYXV1MXNrWm9zSXRR?=
 =?utf-8?B?SkJBWDJhVW1VMlN0bThaeEdlSisxVUJyL2JmdmQ2czRncngvczNmajgvNzBh?=
 =?utf-8?B?R1IyaTRDQ3E1dU84N3puMFU1Q0xldm5laU5qYlo3YTBwTC9UMFNIWmpqRFZW?=
 =?utf-8?B?TEhqUXBibGNERXhub2RlTjZSZmJDeEVwTzZ2TzFoZjRJZHY5QS9NRlhOK0lR?=
 =?utf-8?B?dXQvbU1xbHd4ZmU4WUZzVit4NFZQZ3B3Z0M5Z1IzWk1VdFlFMzVoQWpuTmFh?=
 =?utf-8?B?TTBUQjBWSVRFdzcvZVpUWG5UeW11Uld4OVBrWDZ6aVFadEhJQXIrQk03VWpW?=
 =?utf-8?B?K2VZLzRqVDIrNGpCY0xKeEltK3Z0TmxlWis4MExiK3lMVkFzc1phbldOaTht?=
 =?utf-8?B?dzlncyt4clU4TzdjRGtvT1haT3lmNXA4blgvUW5Cb0J3S2dzaXZ6WGhhQnVv?=
 =?utf-8?B?OGdWYmF1U2htc3VPeDhpL1pBVEJKSUpOZW8yclhrSElOWTcrRTNON3N4aXFE?=
 =?utf-8?B?U1YwYnBBMTRvUFozMXJVMnZDMDQ1TjVOZ0hZSWVUZmxMdDBpa0xvMmFiREQ4?=
 =?utf-8?B?WlI1Y0NiaEliMXNQZWt0UjVNL3h2MUhlaVIvM2NLcnF0enlTYTB0RG90QTVF?=
 =?utf-8?B?NUR5ODRxOEJsQ2w4dUZTQmVCVWhFZ3RPM1lKSHJ3QnB4YnVoYU1IWC9WMXR5?=
 =?utf-8?B?S1dmeHhZMlJ3ckY4QWJNZCt3S1pXajFuUXlkREpwUHdJZ3NYaUpBaWlMdzlT?=
 =?utf-8?B?NlBRcWZGQUxsU3YvMzlTc0FMUitESWUxVVk5L0htenVBUENVV2dvZ3lGYnBo?=
 =?utf-8?B?OWQvc1QydGY1WXRXTVpnaXVuZ09Ja1pKZHgza2tzL0doRG5hMlRwR2syaWV5?=
 =?utf-8?B?NGpIZG0vNVFmV054Z3R4dWpsNUNWVW54ODNoTjFTSUJSZ0VqZmRWQXNXQjFJ?=
 =?utf-8?B?V2V2Nm13cHh2K3VRbjNFN3Y3WkJvZUlyNzlvVnJ4TXlYSFlFZTJwSnR5ZWN0?=
 =?utf-8?B?MnoydHprZHovS0N2MVhwUnRmRVZaa1c0QzdLazVIeTZqS085YzJQQWFCL1lS?=
 =?utf-8?B?ZFZjeVl3YkIyUlpoOTlZaUx1WWgyYldyQnFlWmZkbElLSHF1SFhVcTUwMWV6?=
 =?utf-8?B?V0xQbE1jc2d3Ukh4cXlLeE5XcmhiWGZkOUpHQnU5MHJSVVBNRTdGUUNxRGda?=
 =?utf-8?B?ZGY2dmFxaTJCSVN3ZURCU1NuaVkyOG05RnF0bUVNY2tBdVNDWWdRVWd5NHor?=
 =?utf-8?B?WHVlbmh5OWhFTEw5eGJ5bUhwdHlUTWZNYUdEN051ViswYkE0ZTJqbFAwMGpw?=
 =?utf-8?Q?lEIQ1w4f6srGU1zRszGqYPwEzcL2ZA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:06:58.5878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f64a0a-3829-4d7a-b6d0-08dd60d84790
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Add a function for getting the cxl region range to be used for mapping
> such memory range.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 15 +++++++++++++++
>  drivers/cxl/cxl.h         |  1 +
>  include/cxl/cxl.h         |  2 ++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 7f832cb1db51..0c85245c2407 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2716,6 +2716,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
> +{
> +	if (WARN_ON_ONCE(!region))
> +		return -ENODEV;
> +
> +	if (!region->params.res)
> +		return -ENOSPC;
> +
> +	range->start = region->params.res->start;
> +	range->end = region->params.res->end;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
> +
>  static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>  {
>  	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2eb927c9229c..953af2b31b1c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -811,6 +811,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
>  
> +int cxl_get_region_range(struct cxl_region *region, struct range *range);

I don't think this needs to be declared in drivers/cxl/cxl.h since it'll
get defined when including include/cxl/cxl.h.

>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index f54d8c72bc79..8eb918241c48 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -264,4 +264,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     bool no_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
> +struct range;
> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>  #endif


