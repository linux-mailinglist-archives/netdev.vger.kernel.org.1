Return-Path: <netdev+bounces-174012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD475A5D05F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 615117A69A8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D436E1E833F;
	Tue, 11 Mar 2025 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AtV6nnex"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576E1EDA20;
	Tue, 11 Mar 2025 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723575; cv=fail; b=a36Lg43QAHRTn7tg8ucl1u20SDsaLiyjgSUa4jiHju5T4UDI9k5bYaGGjkmvZS9gABdlAyUKchFHCc+s1joqITI4tMhE7fZNtptrUvyFPlyVeq6XkkYp3P03G0LLJq9LsagPEUGO1RAEUxk82uHXXT9HrmZLllQNqKLMusBASog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723575; c=relaxed/simple;
	bh=0Le625Riu2wtO9asr0Gx6xwB1pE+Oyp4alANTREjOig=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=QmipwEUyIxfn3YQ3zT1jlPbcN2N2st2aGcBv8XK2toXo0p3nY9VhbdSsPHwefLBGUsdmLnTdk5wR4I4qp+MXpJxFqPYwkjrJwdjbyGrAa7JDXFRLcFae5ZrXDedpsCVEdkB9pYGGpoH6XW7XGMnMvSVD0DNqHuSpGlhWGgnDTAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AtV6nnex; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBFUacBPqgc+EDTkmVekO0wzHnK8hSyq1VAwX80uzGONuvQ6r2B4JROCTQs7TkT1Zd5Wr37FvRYTxTKox2hzBi9aG5iJcn9aYHqcuvx7WX8wauAbxUQZRL3shZA12UnBSzr7jminFmMk3zohl0px9VzNa61C4p9N6YCBsfSx0qD8U2XE2zrePaqzX9IsYjpazwiBVxYA/Yo9BYQfpDE6wvPmxI5nGcyhDecKcHsFuRQ/0B5KNwrg2ozGmQcwJJGwb25ed0Eu9JYwF7dMUgO3vi+qfRqLZ6yfU/IRm6rkPPozEtCO+jA17SRY584sgkkeO5lPFpbF6o3CXiUNgByfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlqYcrk9BlgpIL/QooCyfLPByxLvCondT4cbF79mOoM=;
 b=NYDfJKtK5s+MSCTs5aXHijgHZgA4ED4kQIXVI9VJEXoS1PTof3r0dlR88Rb2h9DxNpOOigRBK/0nsACVY0ygezfEcro+2BKZ5u88xJiLeioc6FIncbuCKDen+0bs9QEI82/hKvfGvGvbifxkfxSWB7s5c9d6C+7rdLeqdmgZkVr2MzzbjesZAB5tHVfOs4xNdtxL8zu+aDGIam/AFCORPmjbWG3KH81N7d0xwUIXBMRcjduCsKWCXS+9ZWEbxqMtzfw0yXRVaQVx8qIxCJmOEaoXipcMxdWlYBUAaO7qLXnj/VEFrEG4iHNq8Px2nvzpYjDNhhjoAN6fJIdCE8jNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlqYcrk9BlgpIL/QooCyfLPByxLvCondT4cbF79mOoM=;
 b=AtV6nnexROOMYYJf81sv4YRyrToYZB0kN/1XPyfWCurlgLqouiApJrOq/G4FygLQgy44ts5rzVMD0zUKlxY6+YwlxgWLBsHt/t4Y7aC4kP6RqyQgqv6FHBfuClVg3jPGTahLX6yoJjWUKngSGTN3UNrmPWcBBYjlfvIdbto4/iE=
Received: from MN0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::23)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:06:09 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::6a) by MN0P220CA0011.outlook.office365.com
 (2603:10b6:208:52e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 20:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:06:08 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:06:06 -0500
Message-ID: <34efb2e9-a2fe-4362-a1d3-43b63a4d7c76@amd.com>
Date: Tue, 11 Mar 2025 15:06:05 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 11/23] cxl: define a driver interface for HPA free
 space enumeration
To: <alejandro.lucero-palau@amd.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b339c3d-7380-432c-57ac-08dd60d829b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXl3NXMwbnliVER0blQ0OGhXYzVlWW9RWVpNdngvVFhrRm14OHZGM01VdGVP?=
 =?utf-8?B?ckxLdll5bG9QMzR3NWw4bnZNTitKc2xEZERIMVk2dFRqTGJzeGp3YlAwZGI4?=
 =?utf-8?B?Mm5DZEpTUWF6RE1GcXZSV1E2U0svSEtjekp1Z0VYaWJpMmYrZjNPdDBYSmo2?=
 =?utf-8?B?WGJ3RGRrSHdhTVNSd3ZzUDQrbW4vRUUxMmZXQ2ZDcGlqMVRHTjdWcVFwWG1p?=
 =?utf-8?B?aENSUnB0Nk03TnRXQW9ZTUZ4SHFyekdQZ2RmN0xVbE01RDdNUnZQaThJeHEz?=
 =?utf-8?B?QXFyTXM5d09ubFNFZDJhUXVEWU1EMzNpN09RZ1Zqakt5QW9LL0pKeW83U0lN?=
 =?utf-8?B?SHZicXVXMWtGNVFNMDRHWktkNm5DZ0x6ZGFhVkFVZStkLzE1YlBoRkREZUNE?=
 =?utf-8?B?TjZ5RlZlMmlGdnRiRnphRlAyenVFOTdycmJjWk9vNE1hVno2NkhFZC9LS0Jn?=
 =?utf-8?B?SlpBUVBZK01mSXh6Q20rOHZPalRNajdOMDdUSVVHTklUa3JRUzd0NzkzUTBI?=
 =?utf-8?B?dzlXWFFWdjFvRVA5WkIyRU9DSjM1dkxCbDhwWGg3R0tZcHJFZzZIM3NCbUdw?=
 =?utf-8?B?UUYrSjZzVG9ub1hsV2h4c0dkYVVBWWdxQ01jWHgwS3BUVE1xU0JicjBiTVdj?=
 =?utf-8?B?UC9ybjBUZC9GWmxWc29oUHI4WllqR0hwYXZWNFAzVWNTRk1CdWtVWlJ5eHV2?=
 =?utf-8?B?cm45aWFuazdYV1JmZG03UzhZaHNFMDhRYTE3MlJtbE9JckR5OTNZZW9YdmZk?=
 =?utf-8?B?QkxlcG5pNy83VzVubU5jaURwRHA2SG8rQUNtKy82SGwxamVkQlk3UEtyN0NG?=
 =?utf-8?B?ellHb3BIaXF6TnB6OCtwaUMyM3VwWGhYMWl4UlNnQWxWejNaOXVVZTB5aUdV?=
 =?utf-8?B?cnhsU0dyZzJkV1RRWjY0eGMwOUtDbDY3OGlkL2RhYTBTRTNINmNWQVM2UEg2?=
 =?utf-8?B?UHlvTXh0Rm4xRGc1N0VmWHIxRDdXTk5uUFMzN3RzRm5Ubng3SDhYcFdhRUgw?=
 =?utf-8?B?OVZWaHViZFgvQ3pGck0waUpOOEh4ZCttZkNldWdKblZZcmplRVNxOHdKdEQ4?=
 =?utf-8?B?Q0FCQWJFYlZ0Rm1qdzlIV3lvV090S3JCUEpIQ3F2S1l3M1lydGtzaGNnd3Zu?=
 =?utf-8?B?NWJCY2szcDRoemhEMlpOL3Q4ZWlqa05VQ21ad0ZGL25GMnhubHZtR1R3bXkr?=
 =?utf-8?B?R0xJWDBVVEx0RFRwckEwKzh6Y1hZNmJTcUVrMG9oZDRNKy9CK2Fnb1dIWkEv?=
 =?utf-8?B?VUJNb1RrL2R6Zll1UktCdXZIMWpLSURITTU1cmNKSy91c1p4a0ZKWDhTNUNy?=
 =?utf-8?B?cEdWVjE3NEVnR3BmSmRRVXNjcUtMWHNnNnJobUh0bGxPS0NMNmxBSnpWRTA4?=
 =?utf-8?B?K0xWR0VwNTZ4dEpPNi9IK2t5SHVqUkcwa0xaZTB6VEFGMG9SdGQyTTB5MWJu?=
 =?utf-8?B?a0xhZlpyaDRQR2QzU3hPc3lMN292Q3ZNUkhzZk5KYm9qMm9OT1ZtUXNGa1Vr?=
 =?utf-8?B?MzRUSFVjQVF3dVpjYm04UHovMXRRZWo0bVVodFJxb3NqRlVvNVcvTEp5NC80?=
 =?utf-8?B?Snk4K3hXYWFXcXE0K3BwUjIwaGhGbnllMFFyVzVlMkdLYXZldDN3VFAxY1A5?=
 =?utf-8?B?L2NVbDc3K2NydVg5bCtBbzhtNElzZHd4eVJSeTkxRms4eEt0d2lJUWc2WEl1?=
 =?utf-8?B?RnlhMVVZbnRqcjVtM1ZJWVRPZmdidUNabnV4TVFyN214RFYvN2NMOWRUb04z?=
 =?utf-8?B?TzdSZGlPSjM4UTZCeGYwWmpMSTdNYWdHKzRIM2ZFWTg0cFBrVktkQmxhNVp2?=
 =?utf-8?B?RWNTUUpnRzFMbkhJRUtITXlZaUovc0l6UUpER0ZqZUt2Q2h5RnVpcEorMkMv?=
 =?utf-8?B?cEdUMDF4UVFLaWl0bG9DWnV0RUo0UlFGTlR3T21PU25mMUVyN0xuNVp4V1Jx?=
 =?utf-8?B?U1JiRGt0elg3N2YrSldJM1B6K1dJQm1OVXhNWGJnNlZPTHpza21Gb2N6R1Ba?=
 =?utf-8?Q?4HGLREeS3E7ygvFJrJIJ0J1OFrRcEQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:06:08.4856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b339c3d-7380-432c-57ac-08dd60d829b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  drivers/cxl/mem.c         |  26 +++++--
>  include/cxl/cxl.h         |  11 +++
>  4 files changed, 194 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8537b6a9ca18..ad809721a3e4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -695,6 +695,166 @@ static int free_hpa(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +struct cxlrd_max_context {
> +	struct device * const *host_bridges;
> +	int interleave_ways;
> +	unsigned long flags;
> +	resource_size_t max_hpa;
> +	struct cxl_root_decoder *cxlrd;
> +};
> +
> +static int find_max_hpa(struct device *dev, void *data)
> +{
> +	struct cxlrd_max_context *ctx = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_root_decoder *cxlrd;
> +	struct resource *res, *prev;
> +	struct cxl_decoder *cxld;
> +	resource_size_t max;
> +	int found = 0;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
> +			cxld->flags, ctx->flags);
> +		return 0;
> +	}
> +
> +	for (int i = 0; i < ctx->interleave_ways; i++)
> +		for (int j = 0; j < ctx->interleave_ways; j++)
> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> +				found++;
> +				break;
> +			}

I think kernel coding style requires braces on the above for statements, but I may be wrong here.

> +
> +	if (found != ctx->interleave_ways) {
> +		dev_dbg(dev, "Not enough host bridges found(%d) for interleave ways requested (%d)\n",
> +			found, ctx->interleave_ways);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	max = 0;
> +	res = cxlrd->res->child;
> +
> +	/* With no resource child the whole parent resource is available */
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		/*
> +		 * Sanity check for preventing arithmetic problems below as a
> +		 * resource with size 0 could imply using the end field below
> +		 * when set to unsigned zero - 1 or all f in hex.
> +		 */
> +		if (prev && !resource_size(prev))
> +			continue;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +		dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n",
> +			&max);
Duplicate debug prints here

> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
> + *	    decoder
> + * @interleave_ways: number of entries in @host_bridges
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]

Looking below, the HDM-H vs HDM-D[B] flag is called CXL_DECODER_F_TYPE2, so I think
it would be good to reference that either here or in include/cxl/cxl.h.

> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this root decoder's capacity the capacity is reduced then
> + * caller needs to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with put_device(CXLRD_DEV(cxlrd)).

s/put_device(CXLRD_DEV(cxlrd))/cxl_put_root_decoder(cxlrd)/

Using put_device() isn't possible in accelerator drivers due to not struct cxl_root_decoder
not being exported.

> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxlrd_max_context ctx = {
> +		.host_bridges = &endpoint->host_bridge,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +
> +	if (!is_cxl_endpoint(endpoint)) {
> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	down_read(&cxl_region_rwsem);
> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +	up_read(&cxl_region_rwsem);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
> +
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
> +{
> +	put_device(CXLRD_DEV(cxlrd));
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
> +
>  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4523864eebd2..c35620c24c8f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -672,6 +672,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> +
> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> +
>  bool is_switch_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
>  struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 9675243bd05b..ac152f58df98 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -130,12 +130,19 @@ static int cxl_mem_probe(struct device *dev)
>  	dentry = cxl_debugfs_create_dir(dev_name(dev));
>  	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>  
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> -				    &cxl_poison_clear_fops);
> +	/*
> +	 * Avoid poison debugfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (mds) {
> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_inject_fops);
> +
> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_clear_fops);
> +	}
>  
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
> @@ -219,6 +226,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	/*
> +	 * Avoid poison sysfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return 0;
> +

Are these changes to cxl/mem.c supposed to be in patch 09/23? They aren't related to this one
as far as I can tell...

>  	if (a == &dev_attr_trigger_poison_list.attr)
>  		if (!test_bit(CXL_POISON_ENABLED_LIST,
>  			      mds->poison.enabled_cmds))
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 340503d7c33c..6ca6230d1fe5 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -25,6 +25,9 @@ enum cxl_devtype {
>  
>  struct device;
>  
> +#define CXL_DECODER_F_RAM   BIT(0)
> +#define CXL_DECODER_F_PMEM  BIT(1)
> +#define CXL_DECODER_F_TYPE2 BIT(2)
>  
>  /* Capabilities as defined for:
>   *
> @@ -244,4 +247,12 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
>  int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlmds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);

This declaration is duplicated

> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       int interleave_ways,
> +					       unsigned long flags,
> +					       resource_size_t *max);
> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>  #endif


