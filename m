Return-Path: <netdev+bounces-137067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7F9A43F9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B850284591
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C731202637;
	Fri, 18 Oct 2024 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lxnl2Q38"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D31203715;
	Fri, 18 Oct 2024 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269652; cv=fail; b=TTBWJgSXgcDjZb8rN+/JrxzG6CPr6+944fYqubmWwrd+7NWHA7M2GjVwZO/rteH7q8fBZfiMoaDfghqvHEvWW6qNrEYyThUA79iBWWgdc4BFiIyyasHA89B+qqHjKpn3Aw1TkeSBdUYY/DqS9PFjWBcBrpUWFe5MDVdJE0CQOEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269652; c=relaxed/simple;
	bh=vyh7CsX1mNdKkCooegt5eHNW2ozHfaGtWA9HKW6KUg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sbljnRQcN7yXAkiLV+ieU+lJ14DcSns08l5I71lo02UJOCJUnPlhDZoPkzBnGPn5OJZPUbVU6ucL2f3SVozqH+8pk/+op8KW57VWQPl9v3wAvxlwNuQc+LSJrhXKep4pxdHN5bZ7hybpxqp/l9Y4MBTdW3s/qIQ6BXpQF/uA1FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lxnl2Q38; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6LbPrMeCrQf8eVkYTk4H9wOJ1kRvRoWAdVrh5xNGObz550YM9pswJgZMBuzxquQgUbzMSN2vU7WF55Zh9ra346/si2RqptzyuC3hYrz/zbC0AdVgVZzZRG+E0ZZyH2sPdgmaPTNgKLeY6nvzpH0rMWFKEFdauuCGD+nLMrNv5WejL7aP6QCjximD0A8quwX7hPb5WJeepls8TmYruRvK9PQNLA9+wMD1tnmLdHIMRLl0nYlBCbqXDx98d/54MMmJ2sdt+8bHWl5N/GDKNxAW9xzUbBOGCoytb4hwMp+r6a6Epg/tKFrmVhxeJmhqaQehqQGdhhXAhmmR5oofDbTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbY3JOsiokca8QW61WyQ5iFDPnEEaGRCL6xlmENpkS4=;
 b=NZYIRhH63zyD5H3jm5BMaZEmkBKh+/FihjksWqBbpB+xw1RgI4yRuQKl7hggL9AQw+vuhdCmEQMpnE3iz0lmomuTlQ5A2vXEjJ0PJwApQrK1IpT343O0iDnpffHBQOy+UvAJ7FYfzEB90an2GqRgLziNvz9Ll7T5hWpdlm/DnJuN3/ICTQsuPmxrsse3Cu+tPg2k3N4UKfMCSHUicg2GMaqZedsTwbRwSi2fo1/eGVnZ53y9Q3FoSgGZ+xCXLWnBTjZruxkMR1USr56zt/pneplXaqnH00olni5RIcV+MW7RbUTfcAA++TU2nWVevZodKDpbZ2IVhOM3lxeuOKcBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbY3JOsiokca8QW61WyQ5iFDPnEEaGRCL6xlmENpkS4=;
 b=lxnl2Q38qWwgYKQUF+u+nTgoBCiKZFRtxOvap8W6V6+yH+5RtTOEYh7R8x15z+AkrYGAiSW0d4c+beFSUuz7KaWbUlQph8uaBzfVej0Ky5HYwvWn0pXk0bQYcQmICfhFSXNws6gyf/vVsAohuSbnDv/H34t/g8A32nLqwpmztqA=
Received: from CH2PR18CA0027.namprd18.prod.outlook.com (2603:10b6:610:4f::37)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 16:40:41 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::ba) by CH2PR18CA0027.outlook.office365.com
 (2603:10b6:610:4f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Fri, 18 Oct 2024 16:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 16:40:41 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 11:40:38 -0500
Message-ID: <54dd9faf-0078-4f3f-b31e-a500bcff64ba@amd.com>
Date: Fri, 18 Oct 2024 11:40:38 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/26] cxl: allow region creation by type2 drivers
To: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-23-alejandro.lucero-palau@amd.com>
 <4b699955-8131-48d8-a698-999d90523261@amd.com>
 <22262215-54de-1a36-056b-5854ff05ccc1@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <22262215-54de-1a36-056b-5854ff05ccc1@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: c37825f8-fc15-4962-da56-08dcef939af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rm55ejVQOGZwaWJKNHdWdTFuellOa0NOcTNnOXgzRVBtUFY1SEk4ay9wdE5N?=
 =?utf-8?B?M2NQcllmZlBYL1pMeHRNdXFuOUJHOEpBdUtZbEp3d1pMeERIQ3RYQzRHU2lu?=
 =?utf-8?B?dDlGYmhDNUZ2eklsZHBOMVFZcG5EYi9YbFdqd3FTYmpJRk5ISWYxbHcyUWhK?=
 =?utf-8?B?WXp2cFVaTFQwTk5vWHdwWW1lMlI2M29PanphckZTUFROelR5SG9vMGhRM2JM?=
 =?utf-8?B?NlNYQ2dhZXZ3WXUwbll1cEtUc1NwdWZZeW5MYmJIUktZZkFTVVFHT3NGT1VU?=
 =?utf-8?B?d1lqWnoxTk1xTmlUelBBbFBxZTJVK09ERFR4bVV4aGgvTmh3eHNpQVl4ZkpT?=
 =?utf-8?B?MnZxTmZHeUg5UFk4VVNxM1F1YjBkcE5FR0N4eE1iRjArZHlFU0xhTlpCRnVH?=
 =?utf-8?B?cUU3RGt2Zi9JYXlhL2M5TUxuWHFMSkFySldBTHBJR0VqZ1Uyc0JQOTMvSUM1?=
 =?utf-8?B?M3FHZXRzZlhwdnNySUZMUGZvOVlxN1N1UGwwdGEremlpcjEzYXhSN3FRSVhO?=
 =?utf-8?B?aGRWSjlLR24zS1VMVklENFk2ZldKQVVkNjdkMmxCcWl6aXVmUGk4Y3N6UlZB?=
 =?utf-8?B?UUJwTTUvVm8wZzVRMU01SE5tYTdBV2s4TzFDb1pxTGRQNUZNdGF1cTVETlg5?=
 =?utf-8?B?QStvNnhCbldDVFpNVFRsM1MvTW5UT0VLa2NoVVI4VFJVNTcvUjlzN2UrZEZl?=
 =?utf-8?B?d0cvOFZVOEdtZDZsRExSQzQyVDdVTGJWT3BMTXRWUnhsWFZyaXZ4bGt1VzZD?=
 =?utf-8?B?N1B1QTBjRFR4aklwQ3ZBSEVvSW4xTUtkcTR1b0o5Tm0ycEN3ek8wME51V2dZ?=
 =?utf-8?B?OVB0WDBzd3ZMVW1jOGw4TWxFblpuOS9nbklqOHdkcjZPcGhYNUVUa0h0WDJQ?=
 =?utf-8?B?eDNybmFNY2tZVVhlWENIUTlFZ0JhT1Q3QkRRWXlHNG53dVZEVS8xbnJoLzVa?=
 =?utf-8?B?SlprZ0M5a2xHL0o0MmkxS0MzTnZuVytrVlBFSGNiUDg0WWhLWnVVN0tEYzFQ?=
 =?utf-8?B?SVUrb0dVSTJHRFJQUFlmVkQwTEliNm81WDNWZXN1ZTVBcGtrOWNxd29vUnpG?=
 =?utf-8?B?N0g2Qi9kb1l0aEVwOWVTOW9OQ0wwUnFLc2RnditzMlUyVkRxcXR6OHNyenVQ?=
 =?utf-8?B?dnc5VmZRaUpLeHJWU1RXeC9PcUZsNUU4Y2JEemRZWGRCZ0k4QW96OXFQbHRw?=
 =?utf-8?B?bDhBOHB5UlhVeWNuS3lwd1hzc3dNSXR0Mk1zRzZ3cGxTWktpcFVyNk8wVjEy?=
 =?utf-8?B?bjdoMlJSS0FXQmt3ZWpPSWt0YWpvSXl0SHRURGJWeFJuZHFZbFhxRTFHZm9I?=
 =?utf-8?B?SUVIYU1ydzVVQzRYYkxKeTdMUXA2cGVmVWVueGZHNnp3TjdzOXRteXRndUFD?=
 =?utf-8?B?eUE3RmNKSUphSXFiaWdIeDZSWmtjNG1DN0d2VGRIeHhKK0szQXlKVm5LWit6?=
 =?utf-8?B?TFhWYUZHRndaUlJhMDVvdk5YRGpzMWpSTFhEdVJ0YlR6MG9TelA2MnhrUWxJ?=
 =?utf-8?B?YURxN0l1Um55SUNtOFRjald5V3pXNlBjanBDdFNQeGhVUWNkQzJ2QW5ubE1T?=
 =?utf-8?B?OVBld0xtUmtyWmNDRWNENVdTNVFwZC9wRExzaEZMdnRCL3pNVVRPS1JxajVP?=
 =?utf-8?B?R2tsdjZjT3NQeWt4SUNNek1lU1pTZjRjcDZpeUcwQVV6N2F0bm0rWFBsblJN?=
 =?utf-8?B?SFJhcFJKMm55V0VYWUlaMFc5TUs4WnlZWVlieUZBcW5RQUVGM0NwTFhZNWJa?=
 =?utf-8?B?OUdTK0g2d05kMDJQcVdVNFpkTTh2ZjRSU2VEcm9VUUpKQ2pwZ0ZuR081MVkv?=
 =?utf-8?B?K2x3eXJ3ck4zbHk5ZlBBTTR5b3ZPWWJEVzRUcS8xQWZmZEkzTlAvVXVSbGY2?=
 =?utf-8?B?dHVmYzFCZitTV1ZzSUdsSmp1RVMxYTNzNDBRelBxbTBOMVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:40:41.8283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37825f8-fc15-4962-da56-08dcef939af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246



On 10/18/24 3:51 AM, Alejandro Lucero Palau wrote:
> 
> On 10/17/24 22:49, Ben Cheatham wrote:
>> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Creating a CXL region requires userspace intervention through the cxl
>>> sysfs files. Type2 support should allow accelerator drivers to create
>>> such cxl region from kernel code.
>>>
>>> Adding that functionality and integrating it with current support for
>>> memory expanders.
>>>
>>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>
>> So I ran into an issue at this point when using v3 as a base for my own testing. The problem is that
>> you are doing manual region management while not explicitly preventing auto region discovery when
>> devm_cxl_add_memdev() is called (patch 14/26 in this series). This caused some resource allocation
>> conflicts which then caused both the auto region and the manual region set up to fail. To make it more
>> concrete, here's the flow I encountered (I tried something new here, let me know if the ascii
>> is all mangled):
>>
>> devm_cxl_add_memdev() is called
>> │
>> ├───► cxl_mem probes new memdev
>> │     │
>> │     ├─► cxl_mem probe adds new endpoint port
>> │     │
>> │     └─► cxl_mem probe finishes
>> ├───────────────────────────────────────────────► Manual region set up starts (finding free space, etc.)
>> ├───► cxl_port probes the new endpoint port            │
>> │     │                                                │
>> │     ├─► cxl_port probe sets up new endpoint          ├─► create_new_region() is called
>> │     │                                                │
>> │     ├─► cxl_port calls discover_region()             │
>> │     │                                                │
>> │     ├─► discover_region() creates new auto           ├─► create_new_region() creates
>> │     │   discoveredregion                             │   new manual region
>> │◄────◄────────────────────────────────────────────────┘
>> │
>> └─► Region creation fails due to resource contention/race (DPA resource, RAM resource, etc.)
>>
>> The timeline is a little off here I think, but it should be close enough to illustrate the point.
> 
> 
> Interesting.
> 
> 
> I'm aware of that code path when endpoint port is probed, but it is not a problem with my testing because the decoder is not enabled at the time of discover_region.
> 
> 
> I've tested this with two different emulated devices, one a dumb qemu type2 device with a driver doing nothing but cxl initialization, and another being our network device with CXL support and using RTL emulation, and in both cases the decoder is not enabled at that point, which makes sense since, AFAIK, it is at region creation/attachment when the decoder is committed/enabled. So my obvious question is how are you testing this functionality? It seems as if you could have been creating more than one region somehow, or maybe something I'm just missing about this.
> 

I think the reason you aren't seeing this is that QEMU doesn't have regions programmed by firmware. In my setup
the decoders are coming up pre-programmed and enabled by firmware, so it is hitting the path during endpoint probe.

Thanks,
Ben

> 
>> The easy solution here to not allow auto region discovery for CXL type 2 devices, like so:
>>
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 22a9ba89cf5a..07b991e2c05b 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -34,6 +34,7 @@ static void schedule_detach(void *cxlmd)
>>   static int discover_region(struct device *dev, void *root)
>>   {
>>          struct cxl_endpoint_decoder *cxled;
>> +       struct cxl_memdev *cxlmd;
>>          int rc;
>>
>>          dev_err(dev, "%s:%d: Enter\n", __func__, __LINE__);
>> @@ -45,7 +46,9 @@ static int discover_region(struct device *dev, void *root)
>>          if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
>>                  return 0;
>>
>> -       if (cxled->state != CXL_DECODER_STATE_AUTO)
>> +       cxlmd = cxled_to_memdev(cxled);
>> +       if (cxled->state != CXL_DECODER_STATE_AUTO ||
>> +           cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
>>                  return 0;
>>
>> I think there's a better way to go about this, more to say about it in patch 24/26. I've
>> dropped this here just in case you don't like my ideas there ;).
>>                                                                     
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>   drivers/cxl/core/region.c | 147 ++++++++++++++++++++++++++++++++++----
>>>   drivers/cxl/cxlmem.h      |   2 +
>>>   include/linux/cxl/cxl.h   |   4 ++
>>>   3 files changed, 138 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index d08a2a848ac9..04c270a29e96 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -2253,6 +2253,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>>>       return rc;
>>>   }
>>>   +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
>>> +{
>>> +    int rc;
>>> +
>>> +    down_write(&cxl_region_rwsem);
>>> +    cxled->mode = CXL_DECODER_DEAD;
>>> +    rc = cxl_region_detach(cxled);
>>> +    up_write(&cxl_region_rwsem);
>>> +    return rc;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, CXL);
>>> +
>>>   void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>>>   {
>>>       down_write(&cxl_region_rwsem);
>>> @@ -2781,6 +2793,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>>       return to_cxl_region(region_dev);
>>>   }
>>>   +static void drop_region(struct cxl_region *cxlr)
>>> +{
>>> +    struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>> +    struct cxl_port *port = cxlrd_to_port(cxlrd);
>>> +
>>> +    devm_release_action(port->uport_dev, unregister_region, cxlr);
>>> +}
>>> +
>>>   static ssize_t delete_region_store(struct device *dev,
>>>                      struct device_attribute *attr,
>>>                      const char *buf, size_t len)
>>> @@ -3386,17 +3406,18 @@ static int match_region_by_range(struct device *dev, void *data)
>>>       return rc;
>>>   }
>>>   -/* Establish an empty region covering the given HPA range */
>>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>> -                       struct cxl_endpoint_decoder *cxled)
>>> +static void construct_region_end(void)
>>> +{
>>> +    up_write(&cxl_region_rwsem);
>>> +}
>>> +
>>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>>> +                         struct cxl_endpoint_decoder *cxled)
>>>   {
>>>       struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>> -    struct cxl_port *port = cxlrd_to_port(cxlrd);
>>> -    struct range *hpa = &cxled->cxld.hpa_range;
>>>       struct cxl_region_params *p;
>>>       struct cxl_region *cxlr;
>>> -    struct resource *res;
>>> -    int rc;
>>> +    int err;
>>>         do {
>>>           cxlr = __create_region(cxlrd, cxled->mode,
>>> @@ -3405,8 +3426,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>       } while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>>         if (IS_ERR(cxlr)) {
>>> -        dev_err(cxlmd->dev.parent,
>>> -            "%s:%s: %s failed assign region: %ld\n",
>>> +        dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
>>>               dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>>               __func__, PTR_ERR(cxlr));
>>>           return cxlr;
>>> @@ -3416,13 +3436,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>       p = &cxlr->params;
>>>       if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>>>           dev_err(cxlmd->dev.parent,
>>> -            "%s:%s: %s autodiscovery interrupted\n",
>>> +            "%s:%s: %s region setup interrupted\n",
>>>               dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>>               __func__);
>>> -        rc = -EBUSY;
>>> -        goto err;
>>> +        err = -EBUSY;
>>> +        construct_region_end();
>>> +        drop_region(cxlr);
>>> +        return ERR_PTR(err);
>>>       }
>>>   +    return cxlr;
>>> +}
>>> +
>>> +/* Establish an empty region covering the given HPA range */
>>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>> +                       struct cxl_endpoint_decoder *cxled)
>>> +{
>>> +    struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>> +    struct range *hpa = &cxled->cxld.hpa_range;
>>> +    struct cxl_region_params *p;
>>> +    struct cxl_region *cxlr;
>>> +    struct resource *res;
>>> +    int rc;
>>> +
>>> +    cxlr = construct_region_begin(cxlrd, cxled);
>>> +    if (IS_ERR(cxlr))
>>> +        return cxlr;
>>> +
>>>       set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>>>         res = kmalloc(sizeof(*res), GFP_KERNEL);
>>> @@ -3445,6 +3485,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>                __func__, dev_name(&cxlr->dev));
>>>       }
>>>   +    p = &cxlr->params;
>>>       p->res = res;
>>>       p->interleave_ways = cxled->cxld.interleave_ways;
>>>       p->interleave_granularity = cxled->cxld.interleave_granularity;
>>> @@ -3462,15 +3503,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>       /* ...to match put_device() in cxl_add_to_region() */
>>>       get_device(&cxlr->dev);
>>>       up_write(&cxl_region_rwsem);
>>> -
>>> +    construct_region_end();
>>>       return cxlr;
>>>     err:
>>> -    up_write(&cxl_region_rwsem);
>>> -    devm_release_action(port->uport_dev, unregister_region, cxlr);
>>> +    construct_region_end();
>>> +    drop_region(cxlr);
>>> +    return ERR_PTR(rc);
>>> +}
>>> +
>>> +static struct cxl_region *
>>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>>> +               struct cxl_endpoint_decoder *cxled)
>>> +{
>>> +    struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>>> +    struct cxl_region_params *p;
>>> +    struct cxl_region *cxlr;
>>> +    int rc;
>>> +
>>> +    cxlr = construct_region_begin(cxlrd, cxled);
>>> +    if (IS_ERR(cxlr))
>>> +        return cxlr;
>>> +
>>> +    rc = set_interleave_ways(cxlr, 1);
>>> +    if (rc)
>>> +        goto err;
>>> +
>>> +    rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>>> +    if (rc)
>>> +        goto err;
>>> +
>>> +    rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
>>> +    if (rc)
>>> +        goto err;
>>> +
>>> +    down_read(&cxl_dpa_rwsem);
>>> +    rc = cxl_region_attach(cxlr, cxled, 0);
>>> +    up_read(&cxl_dpa_rwsem);
>>> +
>>> +    if (rc)
>>> +        goto err;
>>> +
>>> +    rc = cxl_region_decode_commit(cxlr);
>>> +    if (rc)
>>> +        goto err;
>>> +
>>> +    p = &cxlr->params;
>>> +    p->state = CXL_CONFIG_COMMIT;
>>> +
>>> +    construct_region_end();
>>> +    return cxlr;
>>> +err:
>>> +    construct_region_end();
>>> +    drop_region(cxlr);
>>>       return ERR_PTR(rc);
>>>   }
>>>   +/**
>>> + * cxl_create_region - Establish a region given an endpoint decoder
>>> + * @cxlrd: root decoder to allocate HPA
>>> + * @cxled: endpoint decoder with reserved DPA capacity
>>> + *
>>> + * Returns a fully formed region in the commit state and attached to the
>>> + * cxl_region driver.
>>> + */
>>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>> +                     struct cxl_endpoint_decoder *cxled)
>>> +{
>>> +    struct cxl_region *cxlr;
>>> +
>>> +    mutex_lock(&cxlrd->range_lock);
>>> +    cxlr = __construct_new_region(cxlrd, cxled);
>>> +    mutex_unlock(&cxlrd->range_lock);
>>> +
>>> +    if (IS_ERR(cxlr))
>>> +        return cxlr;
>>> +
>>> +    if (device_attach(&cxlr->dev) <= 0) {
>>> +        dev_err(&cxlr->dev, "failed to create region\n");
>>> +        drop_region(cxlr);
>>> +        return ERR_PTR(-ENODEV);
>>> +    }
>>> +    return cxlr;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
>>> +
>>>   int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>>>   {
>>>       struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>> index 68d28eab3696..0f5c71909fd1 100644
>>> --- a/drivers/cxl/cxlmem.h
>>> +++ b/drivers/cxl/cxlmem.h
>>> @@ -875,4 +875,6 @@ struct cxl_hdm {
>>>   struct seq_file;
>>>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>>>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>> +                     struct cxl_endpoint_decoder *cxled);
>>>   #endif /* __CXL_MEM_H__ */
>>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>>> index 45b6badb8048..c544339c2baf 100644
>>> --- a/include/linux/cxl/cxl.h
>>> +++ b/include/linux/cxl/cxl.h
>>> @@ -72,4 +72,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>>                            resource_size_t min,
>>>                            resource_size_t max);
>>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>> +                     struct cxl_endpoint_decoder *cxled);
>>> +
>>> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>>>   #endif

