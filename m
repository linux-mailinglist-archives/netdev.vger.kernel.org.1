Return-Path: <netdev+bounces-146856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FB49D6506
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04996282A43
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101C2176ADB;
	Fri, 22 Nov 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GUHQL2mL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CF116849F;
	Fri, 22 Nov 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308342; cv=fail; b=Tkw2H4swB/TIYLMcIHjvlvEwheLIYcKkyidBKLk+JILSZYDvTz2ZKsovxR98IwHheCI4UyttWEmFkAtVUh5dWg0ivLzemhLMPev2Yoru7aqadKHCpERwm9zSZHEF03oViIAtnxeaf1ycd9bBRzIUw6UTs3Efy6ShRhNQbdem1Xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308342; c=relaxed/simple;
	bh=khv2h728mUHdnnn+LxaaBw2tVDqvqr61EisrgJp+epg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=BzAuwlnHCjbUTfhNCRzob/jrWhOUJsnonxVAWiowmtadFL37GDtPVknab1/HP0U6+oYPbAe/ALAgE6en2EFxng6jv7YcN8pqoCoox2EWiTu86EyYu8MPqlg4oAaLWxF9okCb6atpgRIORQyKZmUaC/xBvdU0P13aGsdVevWw4gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GUHQL2mL; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZWaQKeHbKZ+JejwXY4DC9nvmdhOlPKWoDg624zSZshh4h0TtLAh1GCFe+nPET737G+9J8N9oH4GycfUDSHqtocwhVdmXu9QlTmfOhWg40jl1T2vtTWEeiceiUrA/p0baYLLIA40gP4ruA1waf8ehQUbCoAGmj056CurE6XckT4WQSENF5SggzbclD5MHFIOuESIdG9u5rKuWwF0Ux7Vki3qSosEbBUJ4ClZ310LuX6XKYBdSQPr+FMbTB+d7kFYfKfFR7B9xnMwKvkZkXTT6VG6hP2jMSD83c/ecLCU+6cXXXb64ZivfMFujk3yr1knwfbKtw3Mmz+eMP6/BgB+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0EJ7D1Qw3UpKvBvLZ0w3JhJlzU/MMhvL+JbHK1xWvk=;
 b=wz5BQrM2wVN7qHwdbf62iJe/KtK5rZbllKmer6/iSKCBK20Di8XWibDjcx0ESTGiCStiqKmrIyeYlrwSchm83U+sn/b6aEuXYsOCufa2u6T+2WN5pNd5U1mvAn0nk3G4Ufntu24QUtJB7WaseE/wrpuDKcz/S6DKOy53iXZBdtnOAiPDy65CPL7hLaKRAonjrnpltYWHtcuk/PUxOGz+S3p3Dv/OA2k+Mk/tAk/3BiaYEIiuv8xO4i01quHj4pmJnZqlSFml0RN+5EehiiTn9Ao7x3H4XG9L0GDBmnzZF3LwYoqaihC8NRv4ZdV3tRAlXmAf/DRw3e5a9jFDltsT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0EJ7D1Qw3UpKvBvLZ0w3JhJlzU/MMhvL+JbHK1xWvk=;
 b=GUHQL2mLu9RgoVlJhdn5kTUqO2qKAf3fl/WQTf8xhusWmaS0AH9DOfpucMTDkT86e7+wndX5UhxgaKp15YCp3meY/b53cDozULIyJuzIGlX2W3BD8I74Dj2VAuvBjoiUXQewYRCUTGRK8g+BQvdlhXkaLHRRK0ox8cqwSAP00CQ=
Received: from BL1PR13CA0176.namprd13.prod.outlook.com (2603:10b6:208:2bd::31)
 by IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 20:45:36 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2bd:cafe::cc) by BL1PR13CA0176.outlook.office365.com
 (2603:10b6:208:2bd::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 20:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:45:36 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:45:33 -0600
Message-ID: <87e61d7d-039d-4899-975b-0797d3bc486c@amd.com>
Date: Fri, 22 Nov 2024 14:45:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 13/27] cxl: prepare memdev creation for type2
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, "Cheatham, Benjamin" <bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-14-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA1PR12MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: d49af0ca-f850-4f46-b272-08dd0b369ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDMrU3dFWDZxTnR1M0JEZFdmRnVsOXFsWncwZnJRQTBnUHJ3MWgzWnV5a1Zn?=
 =?utf-8?B?b2pTMUJqckQyQ2NmbXI1OWJ2a3Y3dkNnbzk2aXRURXFjUStBcVdCdjFGOUFG?=
 =?utf-8?B?TC9Mc3FJQTRVamptTHMxZFVNa1RqZXkvVERVcDZ3dkVFbldzNmxFOHBvbXVP?=
 =?utf-8?B?NDBleEhmWFQ3WjRnakw5Y3dKajM5WkNRb0RVNDhZeWtwdGI1L1NoSWxoVGJs?=
 =?utf-8?B?MSswcVhLamZlWHMvLzl5VHlIa0ZmQXhTUzhoVXV2U24zTWRUeENRd0E5OE9p?=
 =?utf-8?B?SGl6M1FWMW44c09xN0ZHaStjQVdkSWwwZk10Z3dtVUIvSUFzTEFsY1dxR0t4?=
 =?utf-8?B?RXgvbCszdzhUUEdoQ2RlVndYS3JZT2s0Q0RZSUNkUFFjWWJ2b3l6NkNrenFz?=
 =?utf-8?B?T1J2Tm5SWlg4Q2k3ZmNzeWdhdERicUpseU5mWVVXSWJ0bTFyeFRXZkZiLzhE?=
 =?utf-8?B?ZXlYVWhMNGtmZWpib3pQbW0vYXh1U2h0QjlXak1MeHVzZlUzbEZEVVcwVDZt?=
 =?utf-8?B?ZTFSVHZPZFl1Y29RMXJYQnd4Z2I3TDlDVERkRXlsb1k2WkVQdmQ4c2t4bXYz?=
 =?utf-8?B?ZnhkTUxhUkZpOEdBZW04TVZ2UU5pU1RYdUNJT0VEMCs4ekdyTVBHZ0RNaWVl?=
 =?utf-8?B?MC9HQXFDaGwyaEppWkloR1lEUlg4MHBZODZReHVWYVZpWkZMeUIxMlZnUXJG?=
 =?utf-8?B?eTU5NVJkWFB3VllGZUc3R2N3Z0MrRnVoT3Rvb0JGd0llMkJGZGtxSTFLaUdD?=
 =?utf-8?B?N3NMaXJ2byt5cmZEdDkvNmRHMVdaZnpJbWE3bEEzanJ0dzVwQi9WVnVYTUU0?=
 =?utf-8?B?cndudWx0OUppeDdZUVNuZVNjKzlHVWF3TDFKZHh2WkZMYU5EVkY0ZGx6aGRx?=
 =?utf-8?B?azVvaE9WcDYvcjRDYjA1MWk2eC9SKzJJUlhTd2RaTFZJVFVvR0FkcTdRSmFJ?=
 =?utf-8?B?UFFNOWV0aUQvcU5CYmFxNWhiQmdEMXJTck5PeFdLU3AwQ3NUeUNPNlU1NDJk?=
 =?utf-8?B?aWtEcXE1VG0vbVNZRUMwc2xVVGlRU2t3dytEVlh2aGNtUDlCYWpKc1YxVks4?=
 =?utf-8?B?Y0VKOUdXU0JZSE41eThQKzBrNVRQY2ZhQTdkNTdBelg4L0lGeTFlbUlBc3Rj?=
 =?utf-8?B?blNaSTdNb0JnejJCaHdYN0gyb2lFNktmejNHTzRWU25CTGgwdmJUZDVaYWpJ?=
 =?utf-8?B?RFlydjZtOStnRTVTUW9EejN3aEtWdzFuUnU1OW5ZZHViZDNNdkFZdjJFeE81?=
 =?utf-8?B?RG93RS8wYTNEM2pzMEU5YmxuM2dhc290eHdiVXFGN0NNcEtpYjJrU1d5UVlK?=
 =?utf-8?B?Q3Z6SFFDUmRlR0ZCbVFGamxoMmxZVU1XVEoyWDB3Y0l1S0loREtnTldiV0pa?=
 =?utf-8?B?REw5WU1kSHQ4bHpreTdMY24rNGc1emhDMTRLUVlOWWJNUkpXQXZWNis3dFFO?=
 =?utf-8?B?OGI0Tk9rTWIrRmZJRnErSUZlajJSZzRyRUphRnRRaklRU2trbU1sTFBiRERU?=
 =?utf-8?B?UGw4YXlldmdXOGlxbURiL1JEWEpwUG9qTEZQNnJvZjJtSy9MVTVFSnRCcTVJ?=
 =?utf-8?B?Y2ZKVWczcWhNVGtaWjFJWjBxc2pwcTJ5RVRlVk5UeXdhbDNjdmdMVFJYaFhp?=
 =?utf-8?B?TEVDZWVJVWVrR0NTaStwbEcvNVptM0Uxam1mWFQvZk5iT09vMkpZV1ZPMk9x?=
 =?utf-8?B?aWREaExsQUViKzYxYzkwMjZBaUtxSHZDUWgyR0hhUVFTemU2Z2JBd2JjM0JU?=
 =?utf-8?B?a0tFbWcxZExVS3R3VUhjbHIzRGxuMTRYbGFwK3QydVJHSjB1dzRiUGxXekQ0?=
 =?utf-8?B?MXhGL1gwSkZ4UFhJZDZkWVRzcTNJemNwbVpBSjNraDBWaTg5WStWbS9rSHBB?=
 =?utf-8?B?czRIWFQ5T0RSQjFNOEZPcTZndEExVXJwTEFiaWxic01NbDNJb0dSbFJZSGNk?=
 =?utf-8?Q?AFGS5PG4rl0Nfgr5KFqxFVSybrjSJRd2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:45:36.0545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d49af0ca-f850-4f46-b272-08dd0b369ddd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6460

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected.
> 
> Create a new cxl_mem device type with no attributes for Type2.
> 
> Avoid debugfs files relying on existence of clx_memdev_state.
> 
> Make devm_cxl_add_memdev accesible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/cdat.c   |  3 +++
>  drivers/cxl/core/memdev.c | 15 +++++++++++++--
>  drivers/cxl/core/region.c |  3 ++-
>  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>  include/cxl/cxl.h         |  2 ++
>  5 files changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index e9cd7939c407..192cff18ea25 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  	struct cxl_dpa_perf *perf;
>  
> +	if (!mds)
> +		return ERR_PTR(-EINVAL);
> +
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  		perf = &mds->ram_perf;
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index d746c8a1021c..df31eea0c06b 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -547,9 +547,17 @@ static const struct device_type cxl_memdev_type = {
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +static const struct device_type cxl_accel_memdev_type = {
> +	.name = "cxl_memdev",

I would like to see a different name than cxl_memdev here, since this is technically
a different type and I could see it being confusing sysfs-wise. Maybe "cxl_acceldev"
or "cxl_accel_memdev" instead?

> +	.release = cxl_memdev_release,
> +	.devnode = cxl_memdev_devnode,
> +};
> +
>  bool is_cxl_memdev(const struct device *dev)
>  {
> -	return dev->type == &cxl_memdev_type;
> +	return (dev->type == &cxl_memdev_type ||
> +		dev->type == &cxl_accel_memdev_type);
> +
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
>  
> @@ -660,7 +668,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->parent = cxlds->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> -	dev->type = &cxl_memdev_type;
> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> +		dev->type = &cxl_accel_memdev_type;
> +	else
> +		dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
>  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index dff618c708dc..622e3bb2e04b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EINVAL;
>  	}
>  
> -	cxl_region_perf_data_calculate(cxlr, cxled);
> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
> +		cxl_region_perf_data_calculate(cxlr, cxled);
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		int i;
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index a9fd5cd5a0d2..cb771bf196cd 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
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
> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
> +					    &cxl_poison_clear_fops);
> +	}
>  
>  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>  	if (rc)
> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>  
> +	/*
> +	 * Avoid poison sysfs files for Type2 devices as they rely on
> +	 * cxl_memdev_state.
> +	 */
> +	if (!mds)
> +		return 0;

cxl_accel_memdev don't use the same attributes, so I imagine this modification isn't needed?
I'm probably just missing something here.

> +
>  	if (a == &dev_attr_trigger_poison_list.attr)
>  		if (!test_bit(CXL_POISON_ENABLED_LIST,
>  			      mds->poison.enabled_cmds))
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 6033ce84b3d3..5608ed0f5f15 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>  int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  void cxl_set_media_ready(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);
>  #endif


