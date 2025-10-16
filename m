Return-Path: <netdev+bounces-230076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 698B1BE3AF0
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5D71A65A0E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2457B2EBBAB;
	Thu, 16 Oct 2025 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PV4i1ERw"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6815B1E5B73;
	Thu, 16 Oct 2025 13:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621011; cv=fail; b=mo4VieTqQvd5VbbQK6U8smVvv7+Iqgdv+BIbXE+zkxS5ikWPabejiNygY/A1rfZxTb+iqsy9vIxpqE+apIMUhbGRTudYv5Dcf0XI9K8E30k4o4B2Q5odef6XYtH+km9ohv0fBo4Y1jZShUBqu3WIWldmBnwJcl3Gf4YLqAe8vZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621011; c=relaxed/simple;
	bh=JKL6c6TV6phrmZOV7eMkmafiFofPNb70j+t66WmkJyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A8/+KV6NOhfRtKAOP/1Qc3RZ40QkrsHCwMmiLbsyQJLwCYjxvk77F+an+lT3rTcadZ6mKTxm37SNgIK8Lm7OFtVAxjes0ynczMwKerf0jdPlgjm1yMtf7xI1M7VlzOQYBdMAlXErxJctpOeGUToEmxxO5MMuKjSQnie2ZX90ABI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PV4i1ERw; arc=fail smtp.client-ip=52.101.56.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egc1xmzLKOxJlpcIKzDFTt9LhjADOBntqjLWuXnVo7pi1WGOiEbeUydpeVR4HvUowyk8IEoFrXtX+6SDJZbjLTlNJ5S5elg8DVF1ORoOJK+iAW1yzvoPXhRxPU1feIJ3uUXT7boW63/qIH+RfWyMUj90y7QhlKqHpViRENeiCaapraTphpp1VVJ5OKHJdI17Dekc0Ja/Oz/4pjxl/19kmYyWEmGnNPvUq2PttsFhRUrt4YahXKcz/8CMzJGs9dlFz1YpcFdn88LNpXQ/YrlidiyvsuJ+EFg/5t3peODthPECE1QCXiB6c3XSryjDst3gSqYlyMOlqA7bxskUBt7+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+PlObsF99EQndQX/YS4NpPguw8hO1uaGnbsUn5rFvM=;
 b=Wod0B4XPcDknZy23p/hx9b1fKSYS7i/2ax8EuWntWEFMTFmb6NrE3oyYKfJJvzNDvreDzu+CeyJcHQ1d6+NdiuR0ezp1JUzpfYeeRmmx5duRw8Nx5519AZGMnovuYNpmyzMbT6e7yAOPoIKlAAyWWp9esL0ZbT7ydasNHUdCCmBCdG/J9vr/Hd1iZEHXRkwsMxFY2lfbKc9DqymAP95bjfGssfmMrx+FbW4ygyNVrJavYcyKpaYh1ttJDIE5tQu2QXDBq7sgpSnR8d1NIZV5fSZeDtjgu9+Y9ht4cqXGNy7Nhaf9bLgQzhpQFiMc7KHct882hyQKYMWkeXFQsemfXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+PlObsF99EQndQX/YS4NpPguw8hO1uaGnbsUn5rFvM=;
 b=PV4i1ERwgBuPzRK6F+jQTuzNvI4JA2lkNDsO1CtRRim7rPjt9Du5BdnOfGbf7jkElY3zoBy7RZzC6Nc6PPZdUoBBg7tBCTEdmdrvJF8T4BCCirqqi6zT/i4fTOlL2kXPEviyKuetlEJtMvCi/w0wBKhkfN+AvfjcJg8U85CgW1A=
Received: from CH2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:59::11)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 13:23:25 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::ca) by CH2PR03CA0001.outlook.office365.com
 (2603:10b6:610:59::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 13:23:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 13:23:25 +0000
Received: from [10.254.54.138] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 06:23:24 -0700
Message-ID: <127311bc-d3cd-48e9-9fc3-f19853bb766b@amd.com>
Date: Thu, 16 Oct 2025 08:23:18 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 18/22] cxl: Allow region creation by type2 drivers
To: Dave Jiang <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-19-alejandro.lucero-palau@amd.com>
 <c42081c1-09e6-45be-8f9e-e4eea0eb1296@amd.com>
 <aa942655-d740-4052-8ddc-13540b06ef14@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <aa942655-d740-4052-8ddc-13540b06ef14@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d33775-854a-484e-978c-08de0cb72fe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlZvMmR2UWkxR0liZDB0bUF6V2krSWZDOE5uZmdRRHV4NUNVM2tjZ0piMkt4?=
 =?utf-8?B?WFhFMUt5Z0k1SWwySEFFSEJaSnRFYktOTU5UM0VDMEpDeFpYdXlrUTFueTBn?=
 =?utf-8?B?RmRYdzNQRi9pTisyVjNxbTJmMEFYb20wMjNRVkwrazl4SXhEZXJTczJ3c2ZL?=
 =?utf-8?B?alFNR0xzV0NmN2h2elMySkM4RTArQzF3bksrZTM5aUVha05lVnh1UTA0RVdC?=
 =?utf-8?B?cTZQSGRUaE9GTEpLR3k1azBtQXlTZEFSbW03ZmhROUloL0NkOWFmOWR0eFJ5?=
 =?utf-8?B?VjZEMzV1Q2E2SkJsd2RwNm1jMkN0L2d2RW1CdGp0V0NoaVI5UUdVYTdHajF3?=
 =?utf-8?B?MncxOE40UTZNbGoyK0o5YjMwYi9YRUQ1R2hteVVBZVkreS83SmVqWThtQVN1?=
 =?utf-8?B?RXFtK1k0c0RIcllJSy9xSzVDNkZBRlEwVjhuaVlBbGtBZlM0eFFNa3ZES1Jw?=
 =?utf-8?B?ODJuTkNUdVZqeWZaOFJwRC9rYnh3MjE1a2xtdEhZaVJpbVZVQXNzMFB5a3R6?=
 =?utf-8?B?QmlqQ05ibXlDOXROaFR0eHF1a1dsYjkxaFEzVGNIeG5YM3FRV2l6S3pESU1E?=
 =?utf-8?B?NEJMVE5KcmllM3hHYk9yOUV5eWpCaXNnNFFPSStIMFN5ZDlYSEJWQ3p2WHdF?=
 =?utf-8?B?eERqdkYwRjFpUTJSaU94M2VEMnNEWTl4eWxvVWlrYnNuZWYvWEVKUU95RHdu?=
 =?utf-8?B?TGNhR3ZkS1NxcHhDcnhtVjlmN0JlR0U0dWNTc2pEVHd6UlRXekZqNHpQOUxl?=
 =?utf-8?B?R2tzZG9odGdSWEhvUldqcSszMk9EQWtPcWVoQ1VZQ2lndkc1VlBzVWdBQWJn?=
 =?utf-8?B?WjhLK2NiM21Vd0tteXArdDdOSkxlNVNJeElOWFdIeW1JalJqYlh4czRobWo5?=
 =?utf-8?B?OVhROVg4OGFYUWtNMjVOQ3JiZ3VrT2pNU21manRKSXhWQ3FtMUtwRmpSTmQv?=
 =?utf-8?B?WjN0RVVKSzZmcDVsbm4rME5CQnJ3cSsrdlg3VGF4bzdXVitoU2s4NzZBNHBK?=
 =?utf-8?B?ZVZTbE9wS3FINGZKa2tiNjdjWmIyV3RGb1REUGdmUDJSdnJ2akJ3N2UzYWN1?=
 =?utf-8?B?QTFXTHRlRlcvb001bFlwNU83cjJGYVh3NjZkVGVrejlITDFHMUFvU1NqVlpS?=
 =?utf-8?B?aElGMnAwcSsvQVp3SmpsNVBjbDVVL0t1MFFZNUhTdVJLdnlUSlZONWREdkhN?=
 =?utf-8?B?NGkxODVZQUV2Y2FJeDJMSEFzUmczbVJiSlF3VURLbUpUa2FQMzBiVXQrR20r?=
 =?utf-8?B?SzhkSjhnbkNndEFqMnhTbUoydEkvSC9WWmVkL3ovYnpodDdDZEJNMXQ0ZVhx?=
 =?utf-8?B?R3dZSTlrOWdnaENZWmpRcDBPaGFJdWZtaVJoWEd3cEtxV0hqajJhaGVhTWNS?=
 =?utf-8?B?YnF4RmUxQTZJY3pmWmNTZWl2T3dMYktUMlpqdWpVUTdXYTl6ZXZReEZnTmZK?=
 =?utf-8?B?S1kvMXJpOGgxU1ZyVTl4c2o4TWNXZVdjWHY5b3lySjBGTEtMSnJUeEJMM3px?=
 =?utf-8?B?OENSWUNnd01CWmtaRmZiTVkvQVZiVllpSmVwbkU4alBxYXJ6UXNKcGxuTjE1?=
 =?utf-8?B?cWllN3QyZlhjZ1RQSUpPYmdRSWJWWnhJcCszRkRMVHZHV2lnMWF1eTVUZXdS?=
 =?utf-8?B?Y3JuMzRYeEpiRlNzSzUzNGVpL0VlRElPZ2hwRkdUUk12a3ZwdWp3YkZ3MDdE?=
 =?utf-8?B?dGdGYjVBN1NML0NzOU4zQXE0ZDNKS0hUZTE2bFZhNDFoQk5LbjRNcjBYcEVP?=
 =?utf-8?B?Z2tLMEFjeFJoSFNnWmNCYnVQcTBzZ0R6RmNaQlh6bXBtUGozQmxyVmJWOEtt?=
 =?utf-8?B?RFFuZW5KaVg0SlB5S0d0OExFTVozRVNhczk0ZWJPQnVZbWdHNUtDemRUNU16?=
 =?utf-8?B?b2VNajBNV2xNQk1zVm5QY00zRGZNTjJaWDlhVnhFOTRaTnlwTlAwNTYxSzNH?=
 =?utf-8?B?SldPODlveFRFOGppVnlYWEVYbEN6eEtsRnBHVjRaR0owUTVCdnI1ZVNNdzBh?=
 =?utf-8?B?MG1TR3pUS3NQdzQrMGY5S3gzaEl0cVRlajU3YWNjQkZPd1VWcktJelVrY1Q5?=
 =?utf-8?B?c1VyazNDbzJRVjRZRk8xSDVjRDBKK3NpVXVCMis0dmJ2WFlHcCtCTVFwYW4r?=
 =?utf-8?Q?FWVs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:23:25.4857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d33775-854a-484e-978c-08de0cb72fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

On 10/15/2025 4:42 PM, Dave Jiang wrote:
> 
> 
> On 10/9/25 1:56 PM, Cheatham, Benjamin wrote:
>> On 10/6/2025 5:01 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Creating a CXL region requires userspace intervention through the cxl
>>> sysfs files. Type2 support should allow accelerator drivers to create
>>> such cxl region from kernel code.
>>>
>>> Adding that functionality and integrating it with current support for
>>> memory expanders.
>>>
>>> Support an action by the type2 driver to be linked to the created region
>>> for unwinding the resources allocated properly.
>>>
>>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>
>> Fix for this one should be split between 13/22 and this patch, but the majority of it is in this one. The idea is
>> if we don't find a free decoder we check for pre-programmed decoders and use that instead. Unfortunately, this
>> invalidates some of the assumptions made by __construct_new_region().
> 
> Wouldn't you look for a pre-programmed decoder first and construct the auto region before you try to manually create one? Also for a type 2 device, would the driver know what it wants and what the region configuration should look like? Would it be a single region either it's auto or manual, or would there be a configuration of multiple regions possible? To me a type 2 region is more intentional where the driver would know exactly what it needs and thus trying to get that from the cxl core. 
> 

Since this is a fix I didn't want to supersede the current behavior. A better solution would've been to add a flag to allow the type 2 driver
to set up an expected region type.

As for multiple regions, I have no clue. I haven't heard of any reason why a type 2 device would need multiple regions, but it's still very
early days. I don't think there's anything in this set that keeps you from using multiple regions though.

Thanks,
Ben

> DJ
> 

